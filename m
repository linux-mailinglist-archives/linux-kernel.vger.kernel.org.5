Return-Path: <linux-kernel+bounces-137389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821E289E15C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E931F2250E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B7815697A;
	Tue,  9 Apr 2024 17:15:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAA8156249
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682924; cv=none; b=UP8tBed0rXiLpEKgM4pwZQzTWu9+gGlUn9GcSCk5AfhBxeMNy2Pv5980qulaBphOHGSQ5Be/nzfLHbilCrvm1KD+NKcvfx4uk4oRDBi1XdardfadlDYpkD9d0MNMPF2u2A6GwZXFl+O1B92JSEASyjlhF/2HYWhi6/I8vvcuvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682924; c=relaxed/simple;
	bh=HPvhrtsQGYLih6FNRMxLsaieI+vQf0NxSAsCdjwProI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c/xTXkT3wwvU0DvVzRXNqDlXAPmU6/MBfCT95B8K+X6ABEW1WXhzW+kED1uyMkMHc02JQdX8KQ85iQoBpQl8c2X2FELGpF6hdQsLHpGXIMVR6+V1eNZ2Z23QmTfQjd9OTNtPNhl0H56EDunapVg6BPdSOutgF+RVLFis6jEOYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC9F0139F;
	Tue,  9 Apr 2024 10:15:51 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A74B3F6C4;
	Tue,  9 Apr 2024 10:15:20 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/arm-cmn: Set PMU device parent
Date: Tue,  9 Apr 2024 18:15:17 +0100
Message-Id: <25d4428df1ddad966c74a3ed60171cd3ca6c8b66.1712682917.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that perf supports giving the PMU device a parent, we can use our
platform device to make the relationship between CMN instances and PMU
IDs trivially discoverable, from either nominal direction:

root@crazy-taxi:~# ls /sys/devices/platform/ARMHC600:00 | grep cmn
arm_cmn_0
root@crazy-taxi:~# realpath /sys/bus/event_source/devices/arm_cmn_0/..
/sys/devices/platform/ARMHC600:00

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 7ef9c7e4836b..b2c607cf3ad7 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2482,6 +2482,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
 	cmn->pmu = (struct pmu) {
 		.module = THIS_MODULE,
+		.parent = cmn->dev,
 		.attr_groups = arm_cmn_attr_groups,
 		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 		.task_ctx_nr = perf_invalid_context,
-- 
2.39.2.101.g768bb238c484.dirty


