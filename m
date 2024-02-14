Return-Path: <linux-kernel+bounces-65180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E756B854900
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8C92861B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B3F1BC3D;
	Wed, 14 Feb 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="41HykHli"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F1E1B813
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707912904; cv=none; b=hFqub/HIokZFHFrGDK3kMLxa2TDZed7rrvw01EzWd0jXLmPT69BR9I7zrUT5Y/ITpaxW1oDk+fPrMpMCtxpL2dHrJp3EN6LxgMUPu5I9ZSoI36V5OnsItMdgAh9xYF5zuNICnEaI3VcBY3YkYrr2p0qagsbMF15xFwzavwFwONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707912904; c=relaxed/simple;
	bh=a9LrVHonu2XB3YYQb5kFdwq7EY9F5HNdPDXVenpHkh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1vhRYiTXmQUTTGh6rdOo7ytiUlIjNsx8OIc7QAow1oo2GOpWfxDqxklVLsLTub992kWoLrkRHdRUIww7xfPgCOthvtyDjiQr29TJTlvyYJDxfJlohbG7772IC2hnILlpl1bPXkSgwHSYzYa9AOoGWfOyNBXyngwi8OXhU/dhm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=41HykHli; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707912901;
	bh=a9LrVHonu2XB3YYQb5kFdwq7EY9F5HNdPDXVenpHkh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=41HykHliSAXpFUgAys8pjHgemH2RaB+j1D9U3+itBqGNSls4fBavEJaVK51Lt2L7B
	 Y+QAFVZVgLCxg59MCs4ga+esKiRDwX1D/WawTLP/e38G8IQXNkBrWVRJA7nviWF2uN
	 Ua6H0bwgXWcfMoPPq6IfDYe3jXyr/f1G9EEbvOUxEi1pzWUf7ZY2Ups+1ba+CE/tma
	 sf+EBU+uWikHQDtxxVO3jy1N1/iLlLdH44na4532GaMuQ6xkRj7o6/orHEZLIl4mR6
	 w0s1OTUMeiimlTexs856TToWa06qTaNzdiiX7Ug7S+lfkcqmHQpvnFoy/RuGQQRYC0
	 8u/Ey845oTf2Q==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B600A37813DF;
	Wed, 14 Feb 2024 12:15:00 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 1/1] drm/panfrost: Always record job cycle and timestamp information
Date: Wed, 14 Feb 2024 12:14:27 +0000
Message-ID: <20240214121435.3813983-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214121435.3813983-1-adrian.larumbe@collabora.com>
References: <20240214121435.3813983-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some users of Panfrost expressed interest in being able to gather fdinfo
stats for running jobs, on production builds with no built-in debugfs
support. Sysfs was first considered, but eventually it was realised
timestamp and cycle counting don't incur in additional power consumption
when the GPU is running and there are inflight jobs, so there's no reason
to let user space toggle profiling.

Remove the profiling debugfs knob altogether so that cycle and timestamp
counting is always enabled for inflight jobs.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/Makefile           |  2 --
 drivers/gpu/drm/panfrost/panfrost_debugfs.c | 21 ------------------
 drivers/gpu/drm/panfrost/panfrost_debugfs.h | 14 ------------
 drivers/gpu/drm/panfrost/panfrost_device.h  |  1 -
 drivers/gpu/drm/panfrost/panfrost_drv.c     |  5 -----
 drivers/gpu/drm/panfrost/panfrost_job.c     | 24 ++++++++-------------
 drivers/gpu/drm/panfrost/panfrost_job.h     |  1 -
 7 files changed, 9 insertions(+), 59 deletions(-)
 delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.c
 delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.h

diff --git a/drivers/gpu/drm/panfrost/Makefile b/drivers/gpu/drm/panfrost/Makefile
index 2c01c1e7523e..7da2b3f02ed9 100644
--- a/drivers/gpu/drm/panfrost/Makefile
+++ b/drivers/gpu/drm/panfrost/Makefile
@@ -12,6 +12,4 @@ panfrost-y := \
 	panfrost_perfcnt.o \
 	panfrost_dump.o
 
-panfrost-$(CONFIG_DEBUG_FS) += panfrost_debugfs.o
-
 obj-$(CONFIG_DRM_PANFROST) += panfrost.o
diff --git a/drivers/gpu/drm/panfrost/panfrost_debugfs.c b/drivers/gpu/drm/panfrost/panfrost_debugfs.c
deleted file mode 100644
index 72d4286a6bf7..000000000000
--- a/drivers/gpu/drm/panfrost/panfrost_debugfs.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright 2023 Collabora ltd. */
-/* Copyright 2023 Amazon.com, Inc. or its affiliates. */
-
-#include <linux/debugfs.h>
-#include <linux/platform_device.h>
-#include <drm/drm_debugfs.h>
-#include <drm/drm_file.h>
-#include <drm/panfrost_drm.h>
-
-#include "panfrost_device.h"
-#include "panfrost_gpu.h"
-#include "panfrost_debugfs.h"
-
-void panfrost_debugfs_init(struct drm_minor *minor)
-{
-	struct drm_device *dev = minor->dev;
-	struct panfrost_device *pfdev = platform_get_drvdata(to_platform_device(dev->dev));
-
-	debugfs_create_atomic_t("profile", 0600, minor->debugfs_root, &pfdev->profile_mode);
-}
diff --git a/drivers/gpu/drm/panfrost/panfrost_debugfs.h b/drivers/gpu/drm/panfrost/panfrost_debugfs.h
deleted file mode 100644
index c5af5f35877f..000000000000
--- a/drivers/gpu/drm/panfrost/panfrost_debugfs.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright 2023 Collabora ltd.
- * Copyright 2023 Amazon.com, Inc. or its affiliates.
- */
-
-#ifndef PANFROST_DEBUGFS_H
-#define PANFROST_DEBUGFS_H
-
-#ifdef CONFIG_DEBUG_FS
-void panfrost_debugfs_init(struct drm_minor *minor);
-#endif
-
-#endif  /* PANFROST_DEBUGFS_H */
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 62f7e3527385..cd6bbcb2bea4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -130,7 +130,6 @@ struct panfrost_device {
 	struct list_head scheduled_jobs;
 
 	struct panfrost_perfcnt *perfcnt;
-	atomic_t profile_mode;
 
 	struct mutex sched_lock;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index a926d71e8131..e31fd4d62bbe 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -20,7 +20,6 @@
 #include "panfrost_job.h"
 #include "panfrost_gpu.h"
 #include "panfrost_perfcnt.h"
-#include "panfrost_debugfs.h"
 
 static bool unstable_ioctls;
 module_param_unsafe(unstable_ioctls, bool, 0600);
@@ -600,10 +599,6 @@ static const struct drm_driver panfrost_drm_driver = {
 
 	.gem_create_object	= panfrost_gem_create_object,
 	.gem_prime_import_sg_table = panfrost_gem_prime_import_sg_table,
-
-#ifdef CONFIG_DEBUG_FS
-	.debugfs_init		= panfrost_debugfs_init,
-#endif
 };
 
 static int panfrost_probe(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 0c2dbf6ef2a5..745b16a77edd 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -159,13 +159,11 @@ panfrost_dequeue_job(struct panfrost_device *pfdev, int slot)
 	struct panfrost_job *job = pfdev->jobs[slot][0];
 
 	WARN_ON(!job);
-	if (job->is_profiled) {
-		if (job->engine_usage) {
-			job->engine_usage->elapsed_ns[slot] +=
-				ktime_to_ns(ktime_sub(ktime_get(), job->start_time));
-			job->engine_usage->cycles[slot] +=
-				panfrost_cycle_counter_read(pfdev) - job->start_cycles;
-		}
+	if (job->engine_usage) {
+		job->engine_usage->elapsed_ns[slot] +=
+			ktime_to_ns(ktime_sub(ktime_get(), job->start_time));
+		job->engine_usage->cycles[slot] +=
+			panfrost_cycle_counter_read(pfdev) - job->start_cycles;
 		panfrost_cycle_counter_put(job->pfdev);
 	}
 
@@ -243,12 +241,9 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 	subslot = panfrost_enqueue_job(pfdev, js, job);
 	/* Don't queue the job if a reset is in progress */
 	if (!atomic_read(&pfdev->reset.pending)) {
-		if (atomic_read(&pfdev->profile_mode)) {
-			panfrost_cycle_counter_get(pfdev);
-			job->is_profiled = true;
-			job->start_time = ktime_get();
-			job->start_cycles = panfrost_cycle_counter_read(pfdev);
-		}
+		panfrost_cycle_counter_get(pfdev);
+		job->start_time = ktime_get();
+		job->start_cycles = panfrost_cycle_counter_read(pfdev);
 
 		job_write(pfdev, JS_COMMAND_NEXT(js), JS_COMMAND_START);
 		dev_dbg(pfdev->dev,
@@ -693,8 +688,7 @@ panfrost_reset(struct panfrost_device *pfdev,
 	spin_lock(&pfdev->js->job_lock);
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
 		for (j = 0; j < ARRAY_SIZE(pfdev->jobs[0]) && pfdev->jobs[i][j]; j++) {
-			if (pfdev->jobs[i][j]->is_profiled)
-				panfrost_cycle_counter_put(pfdev->jobs[i][j]->pfdev);
+			panfrost_cycle_counter_put(pfdev->jobs[i][j]->pfdev);
 			pm_runtime_put_noidle(pfdev->dev);
 			panfrost_devfreq_record_idle(&pfdev->pfdevfreq);
 		}
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
index ec581b97852b..022c83ede368 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.h
+++ b/drivers/gpu/drm/panfrost/panfrost_job.h
@@ -34,7 +34,6 @@ struct panfrost_job {
 	struct dma_fence *render_done_fence;
 
 	struct panfrost_engine_usage *engine_usage;
-	bool is_profiled;
 	ktime_t start_time;
 	u64 start_cycles;
 };
-- 
2.43.0


