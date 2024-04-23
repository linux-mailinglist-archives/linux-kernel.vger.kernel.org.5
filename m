Return-Path: <linux-kernel+bounces-155927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAA78AF8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B2D1C22838
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA461442EA;
	Tue, 23 Apr 2024 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HgqFIt1e"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21040143C49
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908014; cv=none; b=YjG0yvc1VWl/2w8LAqbVbgZxt343Z+pkpBLO4/vHr6UDA8E1xvAQ1GRUfGJtAOKGGtVgFc+NtNasojvJk8exZIC2fXCOEbOd5rs6nSTcQFv/ck0x2KWPOGOLI4KVtqKiw0S7nIuGN1tkO5SB5keE4mUHkHE9o/H7l0Qq9kGj9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908014; c=relaxed/simple;
	bh=i1eET/RjBYVCS/C3b09AiDsbznYgmcfJ403Ro9pzbh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JokVIW6313/mz3hvHLxhcS5ER/AwoyfPoUCaUmeIB9/3zYnGWIeEnJJ2s7xouzG6wAYnkKE63BBDEyWZYIkApwcS8+KDuq7TCuqFDqUnq8M8ONyazm1BN+wVZam5DFWWlmIayHzNQH+p6+Gz4638LWVLyqv66/wVBtmfu+jMxu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HgqFIt1e; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713908009;
	bh=i1eET/RjBYVCS/C3b09AiDsbznYgmcfJ403Ro9pzbh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HgqFIt1e59YlnlQPDsryRnwgSFZput2VSL58OUwKmAmV6v5S+Ytk3skMWRhSWTca/
	 Rdjv8Sx2ZU/e9FFxfXeyZebSkMHlv+WLVXIwgKwe1LqguGd+AbVM/ESr6+f32X+GnW
	 WrL3g+WdJf6RhBYoywpXEHz/KmJagpwnTPGkIQwYNcmX5j3XbaY3efxVUcjjPS+lMM
	 6XM7Y8wbiYGiJ/NcS8QLvBkuXfuGcQuoXWZh68f+/VW5VSSsNwrA9ls0OU8lzHA0wG
	 8h4LTyy69R7jCVLu2ArLYXImiHkuujR56LfX48/NVCril3s3ZZRAPxFdEnJHMDa4d5
	 bRjOON1Rx7/sg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 58C4C3782141;
	Tue, 23 Apr 2024 21:33:29 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com,
	Adrian Larumbe <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/panthor: Add DRM fdinfo support
Date: Tue, 23 Apr 2024 22:32:35 +0100
Message-ID: <20240423213240.91412-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213240.91412-1-adrian.larumbe@collabora.com>
References: <20240423213240.91412-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drawing from the FW-calculated values in the previous commit, we can
increase the numbers for an open file by collecting them from finished jobs
when updating their group synchronisation objects.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_devfreq.c | 10 +++++
 drivers/gpu/drm/panthor/panthor_device.h  | 11 ++++++
 drivers/gpu/drm/panthor/panthor_drv.c     | 31 +++++++++++++++
 drivers/gpu/drm/panthor/panthor_sched.c   | 46 +++++++++++++++++++++++
 4 files changed, 98 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index c6d3c327cc24..5eededaeade7 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -91,6 +91,7 @@ static int panthor_devfreq_get_dev_status(struct device *dev,
 	spin_lock_irqsave(&pdevfreq->lock, irqflags);
 
 	panthor_devfreq_update_utilization(pdevfreq);
+	ptdev->current_frequency = status->current_frequency;
 
 	status->total_time = ktime_to_ns(ktime_add(pdevfreq->busy_time,
 						   pdevfreq->idle_time));
@@ -130,6 +131,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 	struct panthor_devfreq *pdevfreq;
 	struct dev_pm_opp *opp;
 	unsigned long cur_freq;
+	unsigned long freq = ULONG_MAX;
 	int ret;
 
 	pdevfreq = drmm_kzalloc(&ptdev->base, sizeof(*ptdev->devfreq), GFP_KERNEL);
@@ -204,6 +206,14 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 
 	dev_pm_opp_put(opp);
 
+	/* Find the fastest defined rate  */
+	opp = dev_pm_opp_find_freq_floor(dev, &freq);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+	ptdev->fast_rate = freq;
+
+	dev_pm_opp_put(opp);
+
 	/*
 	 * Setup default thresholds for the simple_ondemand governor.
 	 * The values are chosen based on experiments.
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 2fdd671b38fd..b5b5dfe3cafe 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -162,6 +162,14 @@ struct panthor_device {
 		 */
 		struct page *dummy_latest_flush;
 	} pm;
+
+	unsigned long current_frequency;
+	unsigned long fast_rate;
+};
+
+struct panthor_gpu_usage {
+	u64 time;
+	u64 cycles;
 };
 
 /**
@@ -176,6 +184,9 @@ struct panthor_file {
 
 	/** @groups: Scheduling group pool attached to this file. */
 	struct panthor_group_pool *groups;
+
+	/** @stats: cycle and timestamp measures for job execution. */
+	struct panthor_gpu_usage stats;
 };
 
 int panthor_device_init(struct panthor_device *ptdev);
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index b8a84f26b3ef..6d25385e02a1 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -3,12 +3,17 @@
 /* Copyright 2019 Linaro, Ltd., Rob Herring <robh@kernel.org> */
 /* Copyright 2019 Collabora ltd. */
 
+#ifdef CONFIG_ARM_ARCH_TIMER
+#include <asm/arch_timer.h>
+#endif
+
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/time64.h>
 
 #include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
@@ -1351,6 +1356,30 @@ static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
 	return ret;
 }
 
+static void panthor_gpu_show_fdinfo(struct panthor_device *ptdev,
+				    struct panthor_file *pfile,
+				    struct drm_printer *p)
+{
+#ifdef CONFIG_ARM_ARCH_TIMER
+	drm_printf(p, "drm-engine-panthor:\t%llu ns\n",
+		   DIV_ROUND_UP_ULL((pfile->stats.time * NSEC_PER_SEC),
+				    arch_timer_get_cntfrq()));
+#endif
+	drm_printf(p, "drm-cycles-panthor:\t%llu\n", pfile->stats.cycles);
+	drm_printf(p, "drm-maxfreq-panthor:\t%lu Hz\n", ptdev->fast_rate);
+	drm_printf(p, "drm-curfreq-panthor:\t%lu Hz\n", ptdev->current_frequency);
+}
+
+static void panthor_show_fdinfo(struct drm_printer *p, struct drm_file *file)
+{
+	struct drm_device *dev = file->minor->dev;
+	struct panthor_device *ptdev = container_of(dev, struct panthor_device, base);
+
+	panthor_gpu_show_fdinfo(ptdev, file->driver_priv, p);
+
+	drm_show_memory_stats(p, file);
+}
+
 static const struct file_operations panthor_drm_driver_fops = {
 	.open = drm_open,
 	.release = drm_release,
@@ -1360,6 +1389,7 @@ static const struct file_operations panthor_drm_driver_fops = {
 	.read = drm_read,
 	.llseek = noop_llseek,
 	.mmap = panthor_mmap,
+	.show_fdinfo = drm_show_fdinfo,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -1378,6 +1408,7 @@ static const struct drm_driver panthor_drm_driver = {
 			   DRIVER_SYNCOBJ_TIMELINE | DRIVER_GEM_GPUVA,
 	.open = panthor_open,
 	.postclose = panthor_postclose,
+	.show_fdinfo = panthor_show_fdinfo,
 	.ioctls = panthor_drm_driver_ioctls,
 	.num_ioctls = ARRAY_SIZE(panthor_drm_driver_ioctls),
 	.fops = &panthor_drm_driver_fops,
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 320dfa0388ba..9f1810f5cf4b 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -598,6 +598,18 @@ struct panthor_group {
 		size_t times_offset;
 	} syncobjs;
 
+	/** @fdinfo: Per-file total cycle and timestamp values reference. */
+	struct {
+		/** @data: Pointer to actual per-file sample data. */
+		struct panthor_gpu_usage *data;
+
+		/**
+		 * @lock: Mutex to govern concurrent access from drm file's fdinfo callback
+		 * and job post-completion processing function
+		 */
+		struct mutex lock;
+	} fdinfo;
+
 	/** @state: Group state. */
 	enum panthor_group_state state;
 
@@ -859,6 +871,8 @@ static void group_release_work(struct work_struct *work)
 	struct panthor_device *ptdev = group->ptdev;
 	u32 i;
 
+	mutex_destroy(&group->fdinfo.lock);
+
 	for (i = 0; i < group->queue_count; i++)
 		group_free_queue(group, group->queues[i]);
 
@@ -2741,6 +2755,30 @@ void panthor_sched_post_reset(struct panthor_device *ptdev)
 	sched_queue_work(sched, sync_upd);
 }
 
+static void update_fdinfo_stats(struct panthor_job *job)
+{
+	struct panthor_group *group = job->group;
+	struct panthor_queue *queue = group->queues[job->queue_idx];
+	struct panthor_device *ptdev = group->ptdev;
+	struct panthor_gpu_usage *fdinfo;
+	struct panthor_job_times *times;
+
+	drm_WARN_ON(&ptdev->base, job->ringbuf_idx >=
+		    panthor_kernel_bo_size(queue->ringbuf) / (SLOTSIZE));
+
+	times = (struct panthor_job_times *)
+		((unsigned long)group->syncobjs.bo->kmap + queue->time_offset +
+		 (job->ringbuf_idx * sizeof(struct panthor_job_times)));
+
+	mutex_lock(&group->fdinfo.lock);
+	if ((group->fdinfo.data)) {
+		fdinfo = group->fdinfo.data;
+		fdinfo->cycles += times->cycles.after - times->cycles.before;
+		fdinfo->time += times->time.after - times->time.before;
+	}
+	mutex_unlock(&group->fdinfo.lock);
+}
+
 static void group_sync_upd_work(struct work_struct *work)
 {
 	struct panthor_group *group =
@@ -2776,6 +2814,7 @@ static void group_sync_upd_work(struct work_struct *work)
 	dma_fence_end_signalling(cookie);
 
 	list_for_each_entry_safe(job, job_tmp, &done_jobs, node) {
+		update_fdinfo_stats(job);
 		list_del_init(&job->node);
 		panthor_job_put(&job->base);
 	}
@@ -3240,6 +3279,9 @@ int panthor_group_create(struct panthor_file *pfile,
 	}
 	mutex_unlock(&sched->reset.lock);
 
+	group->fdinfo.data = &pfile->stats;
+	mutex_init(&group->fdinfo.lock);
+
 	return gid;
 
 err_put_group:
@@ -3279,6 +3321,10 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
 	mutex_unlock(&sched->lock);
 	mutex_unlock(&sched->reset.lock);
 
+	mutex_lock(&group->fdinfo.lock);
+	group->fdinfo.data = NULL;
+	mutex_unlock(&group->fdinfo.lock);
+
 	group_put(group);
 	return 0;
 }
-- 
2.44.0


