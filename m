Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C395800AEA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378849AbjLAMbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378804AbjLAMbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:31:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 713991717;
        Fri,  1 Dec 2023 04:31:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CCEC1007;
        Fri,  1 Dec 2023 04:32:12 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AED743F5A1;
        Fri,  1 Dec 2023 04:31:24 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org
Cc:     lukasz.luba@arm.com, rafael@kernel.org, stable@vger.kernel.org
Subject: [PATCH] powercap: DTPM: Fix the missing cpufreq_cpu_put() calls
Date:   Fri,  1 Dec 2023 12:32:05 +0000
Message-Id: <20231201123205.1996790-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The policy returned by cpufreq_cpu_get() has to be released with
the help of cpufreq_cpu_put() to balance its kobject reference counter
properly.

Add the missing calls to cpufreq_cpu_put() in the code.

Fixes: 0aea2e4ec2a2 ("powercap/dtpm_cpu: Reset per_cpu variable in the release function")
Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
Cc: <stable@vger.kernel.org> # v5.10+
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/powercap/dtpm_cpu.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 45bb7e2849d7..aac278e162d9 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -152,6 +152,8 @@ static void pd_release(struct dtpm *dtpm)
 	if (policy) {
 		for_each_cpu(dtpm_cpu->cpu, policy->related_cpus)
 			per_cpu(dtpm_per_cpu, dtpm_cpu->cpu) = NULL;
+
+		cpufreq_cpu_put(policy);
 	}
 	
 	kfree(dtpm_cpu);
@@ -204,12 +206,16 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 		return 0;
 
 	pd = em_cpu_get(cpu);
-	if (!pd || em_is_artificial(pd))
-		return -EINVAL;
+	if (!pd || em_is_artificial(pd)) {
+		ret = -EINVAL;
+		goto release_policy;
+	}
 
 	dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
-	if (!dtpm_cpu)
-		return -ENOMEM;
+	if (!dtpm_cpu) {
+		ret = -ENOMEM;
+		goto release_policy;
+	}
 
 	dtpm_init(&dtpm_cpu->dtpm, &dtpm_ops);
 	dtpm_cpu->cpu = cpu;
@@ -231,6 +237,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 	if (ret)
 		goto out_dtpm_unregister;
 
+	cpufreq_cpu_put(policy);
 	return 0;
 
 out_dtpm_unregister:
@@ -242,6 +249,8 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 		per_cpu(dtpm_per_cpu, cpu) = NULL;
 	kfree(dtpm_cpu);
 
+release_policy:
+	cpufreq_cpu_put(policy);
 	return ret;
 }
 
-- 
2.25.1

