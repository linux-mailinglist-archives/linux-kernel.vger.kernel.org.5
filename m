Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BB47FD501
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjK2LIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjK2LIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:08:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D3E71BEA;
        Wed, 29 Nov 2023 03:08:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36D912F4;
        Wed, 29 Nov 2023 03:09:05 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 917C13F5A1;
        Wed, 29 Nov 2023 03:08:15 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v5 06/23] PM: EM: Check if the get_cost() callback is present in em_compute_costs()
Date:   Wed, 29 Nov 2023 11:08:36 +0000
Message-Id: <20231129110853.94344-7-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129110853.94344-1-lukasz.luba@arm.com>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsequent changes will introduce a case in which 'cb->get_cost' may
not be set in em_compute_costs(), so add a check to ensure that it is
not NULL before attempting to dereference it.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 3bea930410c6..3c8542443dd4 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -116,7 +116,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 	for (i = nr_states - 1; i >= 0; i--) {
 		unsigned long power_res, cost;
 
-		if (flags & EM_PERF_DOMAIN_ARTIFICIAL) {
+		if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
 			ret = cb->get_cost(dev, table[i].frequency, &cost);
 			if (ret || !cost || cost > EM_MAX_POWER) {
 				dev_err(dev, "EM: invalid cost %lu %d\n",
-- 
2.25.1

