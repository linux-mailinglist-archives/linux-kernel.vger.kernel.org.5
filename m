Return-Path: <linux-kernel+bounces-130167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2718974D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE4E1C263FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DDB152181;
	Wed,  3 Apr 2024 16:03:10 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E2914A0A0;
	Wed,  3 Apr 2024 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160190; cv=none; b=OG4n2JH7MoMg2djXUEsGEM7FR3cQ+ezSjwT0bwRzXj4Kf4uf0J0ElkeOoYsSt8RROBQ24PC4IvwmjmXEmkJ0qgn0XMkP9YVYrZuMdVle40ACQecRzrIFO+HR2HdsATFgQWzOeHi7d83ZJNmtlGqO7+1thBhh4xY/VXxt0+W6c88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160190; c=relaxed/simple;
	bh=S39NoN5D0Hm8QiQxAKgAXeUp14vOeOUWvb++HDsIF1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRpDxGFcPAeOWVQxurh1F5SM7IgvKoOwS1Z7WnC2LhGuqqxp2OydVmhxlO9BUeI5K0vF3ZlNfa1TWXDu8m60d0DVTVAQn42ExYdpkf9OwArp8Lwr2BLdHYqvHplecSfc43BE1DXA3nfeOH8DzekRJ7gIGU+ENj/VSXlXt6h4brU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp88t1712160093t0p9khxu
X-QQ-Originating-IP: 2nxMMCc9CfFM/lEjKxNDtkIzxIqbGNNbRtoULXceEGQ=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Apr 2024 00:01:31 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: t5mnTZTTCFcAs6dFSwwoQTaGRdI1+4sbY8k14dO6qQg5QLCHB4Z7+0DzdXCUA
	PeL8atqprX3BRbff92nalknyUi9FR8I0mcEO1ifGBht1sFnhlt0E/UX1pHeIjPxi4Xvfarz
	WwZeTUBPS4DiR22ywLMUr/eFyw5bMCT9kdeWmkUTsmed/veHPathu8vPxUZGw0TbTs+mcl8
	vuwKHB0hNMRwzWwnuHcwPqsWraqEmOaWkHDwGSZ3wEB1x7mgrXnq5N+YUd5ttS+ROfjxM0C
	LbsIJc55RPqGXIRsqgPrQ5ppR/vdYRPGhMETVAlYSjRVFfj4GMOE8zqlkjbpBarMg3N9C7q
	CYrGXIjzpPjYZZzlcd3bPNm/ECf5BmreZxoOXMeBpHk7B2d4wOksk4FabPzAputzkhdLgKu
	MGVdchYXQUA=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17890806519002536568
From: Dawei Li <dawei.li@shingroup.cn>
To: will@kernel.org,
	mark.rutland@arm.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk
Cc: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v3 10/10] perf/thunderx2: Avoid placing cpumask on the stack
Date: Wed,  3 Apr 2024 23:59:50 +0800
Message-Id: <20240403155950.2068109-11-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240403155950.2068109-1-dawei.li@shingroup.cn>
References: <20240403155950.2068109-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Use cpumask_any_and_but() to avoid the need for a temporary cpumask on
the stack.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/perf/thunderx2_pmu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index e16d10c763de..b3377b662ffc 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -932,9 +932,8 @@ static int tx2_uncore_pmu_online_cpu(unsigned int cpu,
 static int tx2_uncore_pmu_offline_cpu(unsigned int cpu,
 		struct hlist_node *hpnode)
 {
-	int new_cpu;
 	struct tx2_uncore_pmu *tx2_pmu;
-	struct cpumask cpu_online_mask_temp;
+	unsigned int new_cpu;
 
 	tx2_pmu = hlist_entry_safe(hpnode,
 			struct tx2_uncore_pmu, hpnode);
@@ -945,11 +944,8 @@ static int tx2_uncore_pmu_offline_cpu(unsigned int cpu,
 	if (tx2_pmu->hrtimer_callback)
 		hrtimer_cancel(&tx2_pmu->hrtimer);
 
-	cpumask_copy(&cpu_online_mask_temp, cpu_online_mask);
-	cpumask_clear_cpu(cpu, &cpu_online_mask_temp);
-	new_cpu = cpumask_any_and(
-			cpumask_of_node(tx2_pmu->node),
-			&cpu_online_mask_temp);
+	new_cpu = cpumask_any_and_but(cpumask_of_node(tx2_pmu->node),
+				      cpu_online_mask, cpu);
 
 	tx2_pmu->cpu = new_cpu;
 	if (new_cpu >= nr_cpu_ids)
-- 
2.27.0


