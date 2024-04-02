Return-Path: <linux-kernel+bounces-127801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 285AB89512A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B3F2873A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1158172E;
	Tue,  2 Apr 2024 10:58:09 +0000 (UTC)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62A7FBA6;
	Tue,  2 Apr 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.245.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055489; cv=none; b=gzKMaAw0QJd3lGH2LyboCN5amErxMEgCnU1rbMK3avYBpJD8S6udpdoRW2lEYOe4ZIQkoHfiifJ7HAtTmpOaMuYpWDlp1xzvVWko953/k44nTMNHjlt2dwqU1oqv+6pRgT6d9pPACnWw4KmY+zGsyqgi36/jiYAvrEYzObY3AIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055489; c=relaxed/simple;
	bh=kBhgbN7veyPdJiucyzUm36iOG/7FCi2+n/Y5GolQDQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dk+Z19Ey0hETxsgeBESk//ZODA2S9O9C4QezuqRMMDf8/1YNZOWpWifvrXVEQI7MzHLqpWtJisOhNddCt1vhsQlbFW1TdxvZpOZZZZPh/fu+G29/nYnybJVTWb0td4lC7yb9V6xYV55x3uA8XXE7G5+y+7dBnZZUJgmtdl+oSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=13.245.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz6t1712055425t71idd1
X-QQ-Originating-IP: Un3ri6CHwwLui5oq45tA1OXYdCgmI9pohTO0oH1tBU0=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Apr 2024 18:57:04 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: RrZlkntZBfktBWsBF1E+TH5J6loXlgQ3eAU19WtoMF7qdeTVjXhPDBscmPite
	2ovkkkqxI68M8HuFvipOvq8mq8IkFWrgg2ZajQUXeWRV5BA082MjJ5B+wQph7d+l9ItO8fj
	w/NCUcTAB6KgKgiJPO6LHkOzxog1FYAU128tjeKLiTgx0siyjehIhTkYX2Pm7Do1ivTfOVK
	DULIAgFBMAhH+hs8n4SqOqt9Rdh3SglT/1fTStlTmizTpxY2HnRf5J3Fivl2pSJtW7rF6PZ
	+GA+jzuMwnhLZJE9FEZe9nPipczqaLWRJHm8HH7yCT7b3QL7HMrwY1y3NJQOmgLUkIUqXTz
	EZ6PJaWFU8Snde9TL/2V8e0Tunk9dWY+nmtkc+LnLoTrcbIeYWWBqA4X96M+eXHwElKRTs7
	x+JeeYCYIy95lDu7H5qvLw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6688925915623200332
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
Subject: [PATCH 4/9] perf/arm_dsu: Avoid explicit cpumask var allocation from stack
Date: Tue,  2 Apr 2024 18:56:05 +0800
Message-Id: <20240402105610.1695644-5-dawei.li@shingroup.cn>
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
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
variable on stack is not recommended since it can cause potential stack
overflow.

Instead, kernel code should always use *cpumask_var API(s) to allocate
cpumask var in config- neutral way, leaving allocation strategy to
CONFIG_CPUMASK_OFFSTACK.

Use *cpumask_var API(s) to address it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/perf/arm_dsu_pmu.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index bae3ca37f846..87efdca05807 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -230,13 +230,21 @@ static const struct attribute_group *dsu_pmu_attr_groups[] = {
 	NULL,
 };
 
-static int dsu_pmu_get_online_cpu_any_but(struct dsu_pmu *dsu_pmu, int cpu)
+static unsigned int dsu_pmu_get_online_cpu_any_but(struct dsu_pmu *dsu_pmu, int cpu)
 {
-	struct cpumask online_supported;
+	cpumask_var_t online_supported;
+	unsigned int ret;
 
-	cpumask_and(&online_supported,
-			 &dsu_pmu->associated_cpus, cpu_online_mask);
-	return cpumask_any_but(&online_supported, cpu);
+	if (!alloc_cpumask_var(&online_supported, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_and(online_supported,
+		    &dsu_pmu->associated_cpus, cpu_online_mask);
+	ret = cpumask_any_but(&online_supported, cpu);
+
+	free_cpumask_var(online_supported);
+
+	return ret;
 }
 
 static inline bool dsu_pmu_counter_valid(struct dsu_pmu *dsu_pmu, u32 idx)
-- 
2.27.0


