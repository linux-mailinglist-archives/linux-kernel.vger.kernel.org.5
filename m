Return-Path: <linux-kernel+bounces-130168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0562A8974D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B294E290271
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8346C14D2BF;
	Wed,  3 Apr 2024 16:03:22 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C914D2AF;
	Wed,  3 Apr 2024 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160202; cv=none; b=g/1X5OXrBBzB5fOtj1G+V9HIBYm+x5HImjuWoAPI9Qw4Wl1A/171esQ/C/BBVOfjCka3pBLZY/4kuS7V5xG+MrbxuCEebO431E2heOOh2It77R82WmMvyVpFgDDDFfvqM0js4JsRRRxmaTbPHwO2ZTx0H47vrAdug8IGLAF7MLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160202; c=relaxed/simple;
	bh=PGvQ1DmTBqcKZy8IUAzMM9T/InjRyf+NpsmDLx3U+hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=srebu2QUr5Ar4QjTfEpurPlRQmO3J0JFAqQkRtwq9HQKnFnWshwIBp9zyarEuIM95PvhrNfmy4jnfSG1sNs/JWqBZqMl65IN518CYJGGdDc7CLSnKCN7j0CP0wLkcip3zLIChd8pRMLNWcAdJkEa7xBjflIskDt7NQIVijjYdCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp87t1712160078tqad960p
X-QQ-Originating-IP: CLCSdPaBv+q3yW5ZWsSmxTywOJ3HOLzbmA5cfgnaREE=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Apr 2024 00:01:16 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: R3vftN8GVq/ejRh0RfRkulWkabSnEcU4uBTypdCPJ4NgGPhaTRxAVPQfHgYmO
	cYOCpGN6kAcn8TTZ3dZOQbtERZ3dMH4W/9UmJBWuhYToqn5fKh9DUfB82RIVU9cpMjqkcZA
	2GG37fIRu0ddTC+Xcf1ki5c0UKvjSvUEp8H7RQYM9sWKYhevWvFrhPxT++FlVRO4nPqL+83
	SCOMyeS/+9Zyll3UVPT8+XKzesTjbAKFTEXqBdEwDeToQRx7+vrW8mYO8gKAxP7iX2gYBp6
	lHnt0pKGPQziHzP13MOtRFOKHjpzsW2mar8kWCR5TzkKMpxVzUSskmm8aEdYTJOhdtJf/cw
	FE4QWta+5sbQK3lY6Shvg0HlrLiDYiOwBUfH83EK7z23gOO2uXgWl4jcdNBtreP1g4facsh
	sUwOL76yYy0=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8381501582707765668
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
Subject: [PATCH v3 08/10] perf/hisi_uncore: Avoid placing cpumask on the stack
Date: Wed,  3 Apr 2024 23:59:48 +0800
Message-Id: <20240403155950.2068109-9-dawei.li@shingroup.cn>
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
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 04031450d5fe..ccc9191ad1b6 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -504,7 +504,6 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct hisi_pmu *hisi_pmu = hlist_entry_safe(node, struct hisi_pmu,
 						     node);
-	cpumask_t pmu_online_cpus;
 	unsigned int target;
 
 	if (!cpumask_test_and_clear_cpu(cpu, &hisi_pmu->associated_cpus))
@@ -518,9 +517,8 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	hisi_pmu->on_cpu = -1;
 
 	/* Choose a new CPU to migrate ownership of the PMU to */
-	cpumask_and(&pmu_online_cpus, &hisi_pmu->associated_cpus,
-		    cpu_online_mask);
-	target = cpumask_any_but(&pmu_online_cpus, cpu);
+	target = cpumask_any_and_but(&hisi_pmu->associated_cpus,
+				     cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 
-- 
2.27.0


