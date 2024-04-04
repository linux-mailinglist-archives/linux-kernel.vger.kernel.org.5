Return-Path: <linux-kernel+bounces-132161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0699899067
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38121C22E91
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB36D13C3E0;
	Thu,  4 Apr 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G4dbCyM1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3951384AE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712266231; cv=none; b=a3P68t+dZm3a9MmzkjWV/ic7J8kzkc8z109t4ok3IKkB0fabVlhbBtKM7zXspCC3sLnyujB43XfPLJzV17p7Peg/vYSk9peQVaGsa9kY1p90duTKHXfdDUr287qX8MH5rCzDx4F4zWgTM0SFMrg5Wfe8Kt3XZ7tBMBZ3wLlrCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712266231; c=relaxed/simple;
	bh=zT/Mj0jfL3gV3UCoOzvYzKXGBz77bWjZZQwDKLOl1gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejHxXCiLp0vOww7C5huHYUeGmx8n4rp3/IxUF/kKYyJQiB4gMshulWwa/ISbLzAnsIxRB4FJppQhSB6wqaFq7czMzd+/NJ53QDg0+48JNDIud09dLPXfu32dcHo/aRj+gY2dUhAbSVCohwwEBiHqzFjBPIVgxHnhVxPfDMZDuis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G4dbCyM1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712266227;
	bh=zT/Mj0jfL3gV3UCoOzvYzKXGBz77bWjZZQwDKLOl1gE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4dbCyM1c/WjOOcfhwTfBS0howOBvDiqsntJqx0hyRv42XKsHEbrXBlye+ZVOWmhL
	 UDP5wM9afy2G47I/NsLa5Zq5C02Qqb4MYgkYxhZI6jbddTV0Jtn5rO/tRYc/VeUYtd
	 h2XUU8NIAXPSt5QeDeqRjrdfBRJYFJtAT0uQ7fDTl3bZ2sYdJ8/4HnXP/izeUhKRuq
	 Y/XyhDEtv5KNjw1TpqkeANxv6JvC1tTTTlmeU9TzLMuTvgCT0HbErSI99h92zHuMb5
	 T8p/xwewNAt2I9AxPgJz4fU9L62g54uIUm8jsFicl7UoAVJV0X96W3x2qx87Ldo6yA
	 WxJFL5MIKe+3A==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 16747378000E;
	Thu,  4 Apr 2024 21:30:27 +0000 (UTC)
Date: Thu, 4 Apr 2024 22:30:26 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com, Christopher Healy <healych@amazon.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: Show overall GPU usage stats through sysfs
 knob
Message-ID: <6aoklcyuvvxgqecjzatn2xopevbsrejhkvzmcqosbu2wkngtui@36gynkk5fay6>
References: <20240404140014.1022816-1-adrian.larumbe@collabora.com>
 <364bd804-2be6-4a0a-a3d2-e6fa136a73ab@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <364bd804-2be6-4a0a-a3d2-e6fa136a73ab@igalia.com>

On 04.04.2024 11:31, Maíra Canal wrote:
> On 4/4/24 11:00, Adrián Larumbe wrote:
> > This changeset is heavily inspired by commit 509433d8146c ("drm/v3d: Expose
> > the total GPU usage stats on sysfs"). The point is making broader GPU
> > occupancy numbers available through the sysfs interface, so that for every
> > job slot, its number of processed jobs and total processing time are
> > displayed.
> 
> Shouldn't we make this sysfs interface a generic DRM interface?
> Something that would be standard for all drivers and that we could
> integrate into gputop in the future.

I think the best way to generalise this sysfs knob would be to create a DRM
class attribute somewhere in drivers/gpu/drm/drm_sysfs.c and then adding a new
function to 'struct drm_driver' that would return a structure with the relevant
information (execution units and their names, number of processed jobs, etc).

What that information would exactly be is up to debate, I guess, since different
drivers might be interested in showing different bits of information.

Laying that down is important because the sysfs file would become part of the
device class API.

I might come up with a new RFC patch series that does precisely that, at least
for v3d and Panfrost, and maybe other people could pitch in with the sort of
things they'd like to see for other drivers?

Cheers,
Adrian

> Best Regards,
> - Maíra
> 
> > 
> > Cc: Boris Brezillon <boris.brezillon@collabora.com>
> > Cc: Christopher Healy <healych@amazon.com>
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >   drivers/gpu/drm/panfrost/panfrost_device.h |  5 +++
> >   drivers/gpu/drm/panfrost/panfrost_drv.c    | 49 ++++++++++++++++++++--
> >   drivers/gpu/drm/panfrost/panfrost_job.c    | 17 +++++++-
> >   drivers/gpu/drm/panfrost/panfrost_job.h    |  3 ++
> >   4 files changed, 68 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> > index cffcb0ac7c11..1d343351c634 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> > @@ -169,6 +169,11 @@ struct panfrost_engine_usage {
> >   	unsigned long long cycles[NUM_JOB_SLOTS];
> >   };
> > +struct panfrost_slot_usage {
> > +	u64 enabled_ns;
> > +	u64 jobs_sent;
> > +};
> > +
> >   struct panfrost_file_priv {
> >   	struct panfrost_device *pfdev;
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index ef9f6c0716d5..6afcde66270f 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -8,6 +8,7 @@
> >   #include <linux/pagemap.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/pm_runtime.h>
> > +#include <linux/sched/clock.h>
> >   #include <drm/panfrost_drm.h>
> >   #include <drm/drm_drv.h>
> >   #include <drm/drm_ioctl.h>
> > @@ -524,6 +525,10 @@ static const struct drm_ioctl_desc panfrost_drm_driver_ioctls[] = {
> >   	PANFROST_IOCTL(MADVISE,		madvise,	DRM_RENDER_ALLOW),
> >   };
> > +static const char * const engine_names[] = {
> > +	"fragment", "vertex-tiler", "compute-only"
> > +};
> > +
> >   static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
> >   				     struct panfrost_file_priv *panfrost_priv,
> >   				     struct drm_printer *p)
> > @@ -543,10 +548,6 @@ static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
> >   	 *   job spent on the GPU.
> >   	 */
> > -	static const char * const engine_names[] = {
> > -		"fragment", "vertex-tiler", "compute-only"
> > -	};
> > -
> >   	BUILD_BUG_ON(ARRAY_SIZE(engine_names) != NUM_JOB_SLOTS);
> >   	for (i = 0; i < NUM_JOB_SLOTS - 1; i++) {
> > @@ -716,8 +717,48 @@ static ssize_t profiling_store(struct device *dev,
> >   static DEVICE_ATTR_RW(profiling);
> > +static ssize_t
> > +gpu_stats_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> > +	struct panfrost_slot_usage stats;
> > +	u64 timestamp = local_clock();
> > +	ssize_t len = 0;
> > +	unsigned int i;
> > +
> > +	BUILD_BUG_ON(ARRAY_SIZE(engine_names) != NUM_JOB_SLOTS);
> > +
> > +	len += sysfs_emit(buf, "queue        timestamp        jobs        runtime\n");
> > +	len += sysfs_emit_at(buf, len, "-------------------------------------------------\n");
> > +
> > +	for (i = 0; i < NUM_JOB_SLOTS - 1; i++) {
> > +
> > +		stats = get_slot_stats(pfdev, i);
> > +
> > +		/*
> > +		 * Each line will display the slot name, timestamp, the number
> > +		 * of jobs handled by that engine and runtime, as shown below:
> > +		 *
> > +		 * queue        timestamp        jobs        runtime
> > +		 * -------------------------------------------------
> > +		 * fragment     12252943467507   638         1184747640
> > +		 * vertex-tiler 12252943467507   636         121663838
> > +		 *
> > +		 */
> > +		len += sysfs_emit_at(buf, len, "%-13s%-17llu%-12llu%llu\n",
> > +				     engine_names[i],
> > +				     timestamp,
> > +				     stats.jobs_sent,
> > +				     stats.enabled_ns);
> > +	}
> > +
> > +	return len;
> > +}
> > +static DEVICE_ATTR_RO(gpu_stats);
> > +
> >   static struct attribute *panfrost_attrs[] = {
> >   	&dev_attr_profiling.attr,
> > +	&dev_attr_gpu_stats.attr,
> >   	NULL,
> >   };
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> > index a61ef0af9a4e..4c779e6f4cb0 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> > @@ -31,6 +31,8 @@ struct panfrost_queue_state {
> >   	struct drm_gpu_scheduler sched;
> >   	u64 fence_context;
> >   	u64 emit_seqno;
> > +
> > +	struct panfrost_slot_usage stats;
> >   };
> >   struct panfrost_job_slot {
> > @@ -160,15 +162,20 @@ panfrost_dequeue_job(struct panfrost_device *pfdev, int slot)
> >   	WARN_ON(!job);
> >   	if (job->is_profiled) {
> > +		u64 job_time = ktime_to_ns(ktime_sub(ktime_get(), job->start_time));
> > +
> >   		if (job->engine_usage) {
> > -			job->engine_usage->elapsed_ns[slot] +=
> > -				ktime_to_ns(ktime_sub(ktime_get(), job->start_time));
> > +			job->engine_usage->elapsed_ns[slot] += job_time;
> >   			job->engine_usage->cycles[slot] +=
> >   				panfrost_cycle_counter_read(pfdev) - job->start_cycles;
> >   		}
> > +
> >   		panfrost_cycle_counter_put(job->pfdev);
> > +		pfdev->js->queue[slot].stats.enabled_ns += job_time;
> >   	}
> > +	pfdev->js->queue[slot].stats.jobs_sent++;
> > +
> >   	pfdev->jobs[slot][0] = pfdev->jobs[slot][1];
> >   	pfdev->jobs[slot][1] = NULL;
> > @@ -987,3 +994,9 @@ int panfrost_job_is_idle(struct panfrost_device *pfdev)
> >   	return true;
> >   }
> > +
> > +struct panfrost_slot_usage
> > +get_slot_stats(struct panfrost_device *pfdev, unsigned int slot)
> > +{
> > +	return pfdev->js->queue[slot].stats;
> > +}
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
> > index ec581b97852b..e9e2c9db0526 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_job.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_job.h
> > @@ -50,4 +50,7 @@ void panfrost_job_enable_interrupts(struct panfrost_device *pfdev);
> >   void panfrost_job_suspend_irq(struct panfrost_device *pfdev);
> >   int panfrost_job_is_idle(struct panfrost_device *pfdev);
> > +struct panfrost_slot_usage
> > +get_slot_stats(struct panfrost_device *pfdev, unsigned int slot);
> > +
> >   #endif
> > 
> > base-commit: 45c734fdd43db14444025910b4c59dd2b8be714a
> > prerequisite-patch-id: 06ac397dd381984bfbff2a7661320c4f05470635

