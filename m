Return-Path: <linux-kernel+bounces-129759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1868896F92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB33028DF6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E48F14900B;
	Wed,  3 Apr 2024 12:54:38 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F667148841;
	Wed,  3 Apr 2024 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148878; cv=none; b=DPGm7ed+xBgVUMAWKb2LS+axm7uTaRZILNajLawIi4VbIj+/a7xhtuwPrnFZLI7eIh5p17FNiKpaLthzeVUUqN10dCnID7shnLBct/TuYgJOYv8cxs9Ll7PLxsIMAN1J1MggVzd7cCtYgP+pG08URx8zRTv3H2sLv0awMtatQpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148878; c=relaxed/simple;
	bh=YPbYnG00R6gzJY3wQosCsmzl+ZE2k9Rcp+wAlH+Q/vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KqCC14rph7n3a/navJUIStgHlsyCRizq3WyV3sDU+RRYvZHvZ2sXDUWQ1GZpUc4DDmfIpdiGFnNl+JXgZSBqcmWd2dEFCBoVZ3gtI4hZ8PLsA63obxnG94TnIzrShmI4HPYUmj0PVQ9bj/Td0Ey7v5JG9fOrA0x439TwEjNnIhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp79t1712148775teye1u3j
X-QQ-Originating-IP: xdXNA6zp8ZSrFbbqKwC7auWvxA+9gSLqEpXCtDjvsc8=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 20:52:54 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: RmQi6iQXyoPI3227xPNYQoydQAD/PwEqenSojQohu5757FSm3x7ceIiKbAVGu
	412DzCp1YWMrlYllY6gv9ImMEfEWAD5DsWbtLmD1KDWtDGmFg2aMGLi0Zj5JQVC+1aXtngL
	u2nerBQMgjZ1JaIt5LAA20jmq5u0EV9XnXuTDItDmDBcZMz4dhmUgaEr7djBrbtW95ZRsN6
	2f4bQNLDOB527dcnzaBSi5y/7qjTjHKvftRFlJ8z/GdorcYD1HH7QedXtJNW2Neb7QNAhuz
	0hoK/CAOWuZzThYCMs1Hl3aalSKlRTobx5IxOE3giObFjp5Pno08NUN7R6YKJ/M7KoeAmOe
	m83vrEBDYEwqYIdXMIB/n5acoCF4TyirSZKmSVzR45oKz6Tff4ZyjojIOaUh6Mu1e8xgmpb
	27ARI95bBrMpObXtXUtTNG3idfP/MYs+
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4365670256005717423
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
Subject: [PATCH v2 09/10] perf/qcom_l2: Avoid placing cpumask var on stack
Date: Wed,  3 Apr 2024 20:51:08 +0800
Message-Id: <20240403125109.2054881-10-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240403125109.2054881-1-dawei.li@shingroup.cn>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
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
cpumask var in config-neutral way, leaving allocation strategy to
CONFIG_CPUMASK_OFFSTACK.

But dynamic allocation in cpuhp's teardown callback is somewhat problematic
for if allocation fails(which is unlikely but still possible):
- If -ENOMEM is returned to caller, kernel crashes for non-bringup
  teardown;
- If callback pretends nothing happened and returns 0 to caller, it may
  trap system into an in-consisitent/compromised state;

Use newly-introduced cpumask_any_and_but() to address all issues above.
It eliminates usage of temporary cpumask var in generic way, no matter how
the cpumask var is allocated.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/perf/qcom_l2_pmu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 148df5ae8ef8..b5a44dc1dc3a 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -801,9 +801,8 @@ static int l2cache_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
 
 static int l2cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 {
-	struct cluster_pmu *cluster;
 	struct l2cache_pmu *l2cache_pmu;
-	cpumask_t cluster_online_cpus;
+	struct cluster_pmu *cluster;
 	unsigned int target;
 
 	l2cache_pmu = hlist_entry_safe(node, struct l2cache_pmu, node);
@@ -820,9 +819,8 @@ static int l2cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	cluster->on_cpu = -1;
 
 	/* Any other CPU for this cluster which is still online */
-	cpumask_and(&cluster_online_cpus, &cluster->cluster_cpus,
-		    cpu_online_mask);
-	target = cpumask_any_but(&cluster_online_cpus, cpu);
+	target = cpumask_any_and_but(&cluster->cluster_cpus,
+				     cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids) {
 		disable_irq(cluster->irq);
 		return 0;
-- 
2.27.0


