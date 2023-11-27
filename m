Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964347FA5BC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjK0QJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbjK0QJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:09:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 630F0EA;
        Mon, 27 Nov 2023 08:09:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D36971688;
        Mon, 27 Nov 2023 08:09:58 -0800 (PST)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 947263F6C4;
        Mon, 27 Nov 2023 08:09:09 -0800 (PST)
From:   Beata Michalska <beata.michalska@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sumitg@nvidia.com
Cc:     sudeep.holla@arm.covm, will@kernel.org, catalin.marinas@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        ionela.voinescu@arm.com, yang@os.amperecomputing.com,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 2/2] cpufreq: Wire-up arch-flavored freq info into cpufreq_verify_current_freq
Date:   Mon, 27 Nov 2023 16:08:38 +0000
Message-Id: <20231127160838.1403404-3-beata.michalska@arm.com>
In-Reply-To: <20231127160838.1403404-1-beata.michalska@arm.com>
References: <20231127160838.1403404-1-beata.michalska@arm.com>
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

From: Sumit Gupta <sumitg@nvidia.com>

When available, use arch_freq_get_on_cpu to obtain current frequency
(usually an average reported over given period of time)
to better align the cpufreq's view on the current state of affairs.
This also automatically pulls in the update for cpuinfo_cur_freq sysfs
attribute, aligning it with the scaling_cur_freq one, and thus providing
consistent view on relevant platforms.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
[BM: Subject & commit msg]
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 drivers/cpufreq/cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8c4f9c2f9c44..109559438f45 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1756,7 +1756,8 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
 {
 	unsigned int new_freq;
 
-	new_freq = cpufreq_driver->get(policy->cpu);
+	new_freq = arch_freq_get_on_cpu(policy->cpu);
+	new_freq = new_freq ?: cpufreq_driver->get(policy->cpu);
 	if (!new_freq)
 		return 0;
 
-- 
2.25.1

