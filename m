Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18E07AD2D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjIYILf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjIYIL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:11:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00E5CFC;
        Mon, 25 Sep 2023 01:11:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C4551474;
        Mon, 25 Sep 2023 01:11:55 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.93.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F2E633F5A1;
        Mon, 25 Sep 2023 01:11:14 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v4 02/18] PM: EM: Refactor em_cpufreq_update_efficiencies() arguments
Date:   Mon, 25 Sep 2023 09:11:23 +0100
Message-Id: <20230925081139.1305766-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925081139.1305766-1-lukasz.luba@arm.com>
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare the code for the modifiable EM perf_state table,
refactor existing function em_cpufreq_update_efficiencies().

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 8b9dd4a39f63..42486674b834 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -237,10 +237,10 @@ static int em_create_pd(struct device *dev, int nr_states,
 	return 0;
 }
 
-static void em_cpufreq_update_efficiencies(struct device *dev)
+static void
+em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
 {
 	struct em_perf_domain *pd = dev->em_pd;
-	struct em_perf_state *table;
 	struct cpufreq_policy *policy;
 	int found = 0;
 	int i;
@@ -254,8 +254,6 @@ static void em_cpufreq_update_efficiencies(struct device *dev)
 		return;
 	}
 
-	table = pd->table;
-
 	for (i = 0; i < pd->nr_perf_states; i++) {
 		if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
 			continue;
@@ -397,7 +395,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 
 	dev->em_pd->flags |= flags;
 
-	em_cpufreq_update_efficiencies(dev);
+	em_cpufreq_update_efficiencies(dev, dev->em_pd->table);
 
 	em_debug_create_pd(dev);
 	dev_info(dev, "EM: created perf domain\n");
-- 
2.25.1

