Return-Path: <linux-kernel+bounces-161345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C15B8B4AFD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D11B1C20B7C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D55B54F95;
	Sun, 28 Apr 2024 09:30:05 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500133C8;
	Sun, 28 Apr 2024 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714296605; cv=none; b=t8kCS2jmbG2rl1HxHdxYC5FBJ3ua7txwmOu0j1alcVjVWfYTx88TMbk+swPI+hagjKzU1JWZDRCYiN9ZnncOdq1taYnnpQhZqlzteRYenj+McJTWLJEu3WCZZ3sSGitabGakXVyZskukzfXOW2f6tZ24XNhxGmD3Gw8LcNSyar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714296605; c=relaxed/simple;
	bh=9YXrwAzLWYxtUHdEbVOHPNVwCl6S2Vz6RCw8juixITQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J3O/ITgsJCeaNbWLcl+RmlyPHWa3vEgc5BSOlJnQ9LAV2B/4aMxwQjCfIyCMH7COJVVRVmnx5ARwCHYC0jJRpCCDd9Obgv4UNZ561z8alx+b2LLuXEwht5toplfAwou6lSMS4+njTpd9oYrLxH0nENauDZFOvVZVKZCpu+eQEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VS1Lf5DFkzvQ45;
	Sun, 28 Apr 2024 17:26:50 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (unknown [7.185.36.111])
	by mail.maildlp.com (Postfix) with ESMTPS id 91773180080;
	Sun, 28 Apr 2024 17:29:57 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500018.china.huawei.com
 (7.185.36.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 28 Apr
 2024 17:29:57 +0800
From: liwei <liwei728@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <al.stone@linaro.org>, <ashwin.chaugule@linaro.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liwei391@huawei.com>, <liwei728@huawei.com>, <liaoyu15@huawei.com>
Subject: [PATCH] cpufreq/cppc: changing highest_perf to nominal_perf in cppc_cpufreq_cpu_init()
Date: Sun, 28 Apr 2024 17:28:52 +0800
Message-ID: <20240428092852.1588188-1-liwei728@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500018.china.huawei.com (7.185.36.111)

When turning on turbo, if frequency configuration takes effect slowly,
the updated policy->cur may be equal to the frequency configured in
governor->limits(), performance governor will not adjust the frequency,
configured frequency will remain at turbo-freq.

Simplified call stack looks as follows:
cpufreq_register_driver(&cppc_cpufreq_driver)
	...
	cppc_cpufreq_cpu_init()
		cppc_get_perf_caps()
		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf)
			cppc_set_perf(highest_perf) // set highest_perf
			policy->cur = cpufreq_driver->get() // if cur == policy->max
	cpufreq_init_policy()
		...
		cpufreq_start_governor() // governor: performance
			new_freq = cpufreq_driver->get() // if new_freq == policy->max
			if (policy->cur != new_freq)
			cpufreq_out_of_sync(policy, new_freq)
				...
				policy->cur = new_freq
			...
			policy->governor->limits()
				__cpufreq_driver_target(policy->max)
					if (policy->cur==target)
					// generate error, keep set highest_perf
						ret
					cppc_set_perf(target)

Fix this by changing highest_perf to nominal_perf in cppc_cpufreq_cpu_init().

Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
Signed-off-by: liwei <liwei728@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 64420d9cfd1e..db04a82b8a97 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -669,14 +669,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (caps->highest_perf > caps->nominal_perf)
 		boost_supported = true;
 
-	/* Set policy->cur to max now. The governors will adjust later. */
-	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
-	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
+	/* Set policy->cur to norm now. */
+	policy->cur = cppc_perf_to_khz(caps, caps->nominal_perf);
+	cpu_data->perf_ctrls.desired_perf =  caps->nominal_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 caps->highest_perf, cpu, ret);
+			 caps->nominal_perf, cpu, ret);
 		goto out;
 	}
 
-- 
2.25.1


