Return-Path: <linux-kernel+bounces-127802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C2E89512C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533711C22B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31D6839FF;
	Tue,  2 Apr 2024 10:58:09 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CBB664C6;
	Tue,  2 Apr 2024 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055489; cv=none; b=FHai8MOysveU+udNGvNy5J50MZf8x/4UJ1zYvoXzH30DTMgfHcbvm7wP0WCsOeP0sjYZNgAgVDe5SYHVm0chuse+5K0QOkif1ooWbGLFBT5bZDA75maQbjIkeAQ5Zcqf0/1pE5vSB6iB68fKJr7U6yRtBUGAw3jve4r8SX+6+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055489; c=relaxed/simple;
	bh=ogaNYTk5qfBchXVMhHi6q9EXDm5FtzGo5QVXZl2LRJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GNMkU0cLbGFGmEOzcw6bEf/8J/P++/Rsl53wmqKNNl0f7K9sjaFJ4zFdS6GeG31PfqQ3W305I5uNTCR+UFo/Hkm7Urg7C7/KFozqD1KFafz88sLGK3Qr6yQBNA6Q0j4qgglfhC7mklw7/M3DDrv5uz3kMeCndMo5LiP1hxY8nlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp82t1712055417txrsjps3
X-QQ-Originating-IP: Zhhf+oUY7YGq4uJEDWQ5xEym8nwZtAJnOprlRBQnsy0=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Apr 2024 18:56:56 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: +ynUkgUhZJmh3bbpLZOdWsh1CuXcwJwfQmOYzh1es10m+h9VDxJ9F7Ia34mv/
	nL8o8GlT62IzqZsPbFmA9QTSXK0zi31huiF9hyD/60DsLQb9NprTXGqon/YX9c14WR6LtqO
	Z/4d67SIP3vjyRbxhj8sR5zqCLemk+AIx7ozWCuNf3f9XwDNvC9mJYgvlndMT/+IIKvxNYF
	l8IZtDjohfhN8ZtW4tbL+rsoA8JqOAHPtPZyvmt0w0dbykyjy0s3TlkFHtbhaSjxoD9LRyR
	GKAkLJTSZ1OjxP9jWS0SVgNV1kme4FtDS3QRSLgxwQkBAQ8XCZ6DkoofJLwRgKjzyCRRvXY
	AdsCz/ZZwfjCtB/lUNnix1CXy3J27RwvMYHgFa0eZez8/WwJMVSpcXhf/Mb/Dcv9dovGqv4
	caksZ5TvYjcs8jz7BpOGqA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 711303368774048342
From: Dawei Li <dawei.li@shingroup.cn>
To: will@kernel.org,
	mark.rutland@arm.com
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
Subject: [PATCH 3/9] perf/arm_cspmu: Avoid explicit cpumask var allocation from stack
Date: Tue,  2 Apr 2024 18:56:04 +0800
Message-Id: <20240402105610.1695644-4-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240402105610.1695644-1-dawei.li@shingroup.cn>
References: <20240402105610.1695644-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
variable on stack is not recommended since it can cause potential stack
overflow.

Instead, kernel code should always use *cpumask_var API(s) to allocate
cpumask var in config- neutral way, leaving allocation strategy to
CONFIG_CPUMASK_OFFSTACK.

Use *cpumask_var API(s) to address it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index b9a252272f1e..8fa7c26aec28 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1322,8 +1322,8 @@ static int arm_cspmu_cpu_online(unsigned int cpu, struct hlist_node *node)
 
 static int arm_cspmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
 {
+	cpumask_var_t online_supported;
 	int dst;
-	struct cpumask online_supported;
 
 	struct arm_cspmu *cspmu =
 		hlist_entry_safe(node, struct arm_cspmu, cpuhp_node);
@@ -1332,17 +1332,22 @@ static int arm_cspmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
 	if (!cpumask_test_and_clear_cpu(cpu, &cspmu->active_cpu))
 		return 0;
 
+	if (!alloc_cpumask_var(&online_supported, GFP_KERNEL))
+		return 0;
+
 	/* Choose a new CPU to migrate ownership of the PMU to */
-	cpumask_and(&online_supported, &cspmu->associated_cpus,
+	cpumask_and(online_supported, &cspmu->associated_cpus,
 		    cpu_online_mask);
-	dst = cpumask_any_but(&online_supported, cpu);
+	dst = cpumask_any_but(online_supported, cpu);
 	if (dst >= nr_cpu_ids)
-		return 0;
+		goto __free_cpumask;
 
 	/* Use this CPU for event counting */
 	perf_pmu_migrate_context(&cspmu->pmu, cpu, dst);
 	arm_cspmu_set_active_cpu(dst, cspmu);
 
+__free_cpumask:
+	free_cpumask_var(online_supported);
 	return 0;
 }
 
-- 
2.27.0


