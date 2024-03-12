Return-Path: <linux-kernel+bounces-100603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7975879AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2975286FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3653139563;
	Tue, 12 Mar 2024 17:34:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00E11386AF;
	Tue, 12 Mar 2024 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264869; cv=none; b=V5/kP7L4hMTNOzVx0wThXTu5BN9/YYVO0FwKbezHMoN4YKcB5NgF1t9o98SQzuKAi26IHYl3Vr356A6HMvFQ1aUEi3wTIyTqgMWuRfJ2Ixdfq49tS6errxbrXYjOVgWabU9pqKI5mnyaN3pS+lLGjUMR15OF9JU0aCRJZT/aLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264869; c=relaxed/simple;
	bh=cRphM6Rk/wa3iqAPnSFQ/7D1dzvpZzzX3sHdjvVeTZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZsL2Bwf25uybWfOid2885meSu9jjg4fRY9XSnHqzf5itDmJa7ljVgWA5HxpRzJr9ryvrfFbuRyZyaNdGW3OmPwZy1Vu3BHUf9WKGkwsUrZdMKrWjxxs/iJCT57P09CmqHOd+JJk2A113MYn5JYtgIHmx/nC0TaJbs/L/wWLGaKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 571A315BF;
	Tue, 12 Mar 2024 10:35:04 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0740E3F762;
	Tue, 12 Mar 2024 10:34:24 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	jialong.yang@shingroup.cn,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH 01/10] perf/alibaba_uncore_drw: Use correct CPU affinity
Date: Tue, 12 Mar 2024 17:34:03 +0000
Message-Id: <ed30ed57584e09b8492c0ceab20c1a7f16d27726.1710257512.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1710257512.git.robin.murphy@arm.com>
References: <cover.1710257512.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although this driver is trying to use the IRQ-multiplexing mechanism to
handle context migration correctly, it's failing to make events follow
the IRQ instance, instead forcing them onto a per-PMU CPU which is set
once at probe time then never maintained. Fix this by using the correct
CPU from the IRQ instance, and remove the erroneous per-PMU data plus
the redundant check which does not mean what it thinks it means.

CC: Shuai Xue <xueshuai@linux.alibaba.com>
Fixes: cf7b61073e45 ("drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710 SoC")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/alibaba_uncore_drw_pmu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index 19d459a36be5..b37e9794823a 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -96,8 +96,6 @@ struct ali_drw_pmu {
 
 	struct list_head pmus_node;
 	struct ali_drw_pmu_irq *irq;
-	int irq_num;
-	int cpu;
 	DECLARE_BITMAP(used_mask, ALI_DRW_PMU_COMMON_MAX_COUNTERS);
 	struct perf_event *events[ALI_DRW_PMU_COMMON_MAX_COUNTERS];
 	int evtids[ALI_DRW_PMU_COMMON_MAX_COUNTERS];
@@ -221,7 +219,7 @@ static ssize_t ali_drw_pmu_cpumask_show(struct device *dev,
 {
 	struct ali_drw_pmu *drw_pmu = to_ali_drw_pmu(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(drw_pmu->cpu));
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(drw_pmu->irq->cpu));
 }
 
 static struct device_attribute ali_drw_pmu_cpumask_attr =
@@ -550,11 +548,7 @@ static int ali_drw_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
-	event->cpu = drw_pmu->cpu;
-	if (event->cpu < 0) {
-		dev_err(dev, "Per-task mode not supported!\n");
-		return -EOPNOTSUPP;
-	}
+	event->cpu = drw_pmu->irq->cpu;
 
 	if (event->group_leader != event &&
 	    !is_software_event(event->group_leader)) {
@@ -701,8 +695,6 @@ static int ali_drw_pmu_probe(struct platform_device *pdev)
 	/* clearing interrupt status */
 	writel(0xffffff, drw_pmu->cfg_base + ALI_DRW_PMU_OV_INTR_CLR);
 
-	drw_pmu->cpu = smp_processor_id();
-
 	ret = ali_drw_pmu_init_irq(drw_pmu, pdev);
 	if (ret)
 		return ret;
-- 
2.39.2.101.g768bb238c484.dirty


