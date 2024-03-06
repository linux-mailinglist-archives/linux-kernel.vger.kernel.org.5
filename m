Return-Path: <linux-kernel+bounces-93507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC0C8730CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31AF1C2170B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D245D48E;
	Wed,  6 Mar 2024 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="s8OAghoa"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A215B1F2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714033; cv=none; b=SsQcYHnSejJDPR7OvH+Yn5XNgop76lPu0+SUnZVVT6RX+Tf+PRIgFhpmd+cYzYIAUQ2HBgO8H+cIN6qIVYZ73eKjodxDE++BzVbJzjTkfNttXWlwwI0IsE+Hw7XgVo/c7jiyfrqqBp+SndwE3mQyBQS4rnDaIYvs07wgURt5WqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714033; c=relaxed/simple;
	bh=sd+lReebe9UFu32zKWfgo1ahECx6oWpoSiA4x8mBxn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzdUDGEf73SqSZHwcpHoBVqUP4N10kTPqlou/OpLoy4ZgnjtnK2p8Yl8XLcBQTQXjoZIOWarJ2uKPEwmMKoWzAFzVafaF6CMhsBNXces3uxFbf41f42SAxA5iZL0GJCZZTaoTtQTAI3RH851boOZu4o5cxQv0BqYm0QUq7mZR6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=s8OAghoa; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-412f55695d1so2951865e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 00:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1709714029; x=1710318829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBXw6tB5aMqLZ8Hc+Iv64yYn3Hav4Q5JVeAcFCnc+tA=;
        b=s8OAghoael5iQk8fJskl2BxvEwzVpMEnJCF/40EgeVI5X9/8Xjng55RlQU3Mz7xIf6
         1Ed7rV0a11pT2AB7oUUoxwl3hDMfRD7JWsxZLDHQLOayXE1lor7b7U58vtnk+ApP3HfW
         TPv3LpaDQLt4Le0MeW2xvKSxZOl9HmfPA357w1c6ciw2+4TVNW0Xf9K99XeHYjqZJgQS
         gXrA0JHYChsBThFo6GyHwABoIKV2B4KN6btSdCBx+kiHo8d5M4458jCR70RX6hvRPBwG
         MQcPXJH3A3nDI7sPXJ8tTOMnAj8n1mL44Pw4n7HiGPYDJsWrOb2EmdjTUGPJk8wKSSGg
         tgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709714029; x=1710318829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBXw6tB5aMqLZ8Hc+Iv64yYn3Hav4Q5JVeAcFCnc+tA=;
        b=r1OBx4PueRKzlhVkNSFhPlVpFngDkVDhorkHN3nZZilV0lB8+zw0Bg7mo0BUw0K4Pv
         ziUOImrHMypWMzSeKTBJUjGgXwUEBu0PBq3ri2iGqsw5c4YcUXn2t5tMZeyTRr/7XJSQ
         jhw4B8S9/xBHcIikQUQb2ErSP+oXeqeP5GZBUimXcKNJfgkf5tTB32GA8oY4zf9bYJ7W
         mClPzUMVQJg2BIhOkJA6uyy4zS56UJlsyrQOSCEMSRcwao0ODs6eJrE0JrJjVUNPtlbi
         GcNtViJIk3sRNoZjxVGioF3k2zlEbSXo0V7ten0ZXa8wihrVs2eLHSsDm34pbEREhq3P
         stVg==
X-Forwarded-Encrypted: i=1; AJvYcCWlat9UF/Zw6JQUbuHZY20JLab9js+t2VRotqrXm5AVd5xTom23lc8aVPqgI9ok6fBD8sbVkqi+tdrdW7T7bdiIEzrNfZFk7kPgxoza
X-Gm-Message-State: AOJu0YztjVgFmP3tZ2L31Akej8SpEJNcrP8kdFTLom6pFBJ5Y+rDpSCA
	NXGBoV8DYXSrR/V/w8WJX81uWZmd+swGHqtypkuzn3yKHvS1J+KyZu3S4fPs0mM=
X-Google-Smtp-Source: AGHT+IHx6OgnZqoA47DWn8wuRljAFdMFhiZ6+NIFrU7zSwOVCqmrAjMM7gy8tqRiA3yb/lHGnh0o8Q==
X-Received: by 2002:a05:600c:3d8a:b0:412:e961:b920 with SMTP id bi10-20020a05600c3d8a00b00412e961b920mr4044192wmb.20.1709714028759;
        Wed, 06 Mar 2024 00:33:48 -0800 (PST)
Received: from [192.168.0.101] ([84.65.0.132])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c1c1000b00412d2dd4bb6sm13713755wms.42.2024.03.06.00.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 00:33:48 -0800 (PST)
Message-ID: <0db9babe-da95-48e2-b577-3e92a81f8303@ursulin.net>
Date: Wed, 6 Mar 2024 08:33:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] drm/panfrost: Replace fdinfo's profiling debugfs
 knob with sysfs
Content-Language: en-GB
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
References: <20240306015819.822128-1-adrian.larumbe@collabora.com>
 <20240306015819.822128-2-adrian.larumbe@collabora.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240306015819.822128-2-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 06/03/2024 01:56, Adrián Larumbe wrote:
> Debugfs isn't always available in production builds that try to squeeze
> every single byte out of the kernel image, but we still need a way to
> toggle the timestamp and cycle counter registers so that jobs can be
> profiled for fdinfo's drm engine and cycle calculations.
> 
> Drop the debugfs knob and replace it with a sysfs file that accomplishes
> the same functionality, and document its ABI in a separate file.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>   .../testing/sysfs-driver-panfrost-profiling   | 10 +++++
>   Documentation/gpu/panfrost.rst                |  9 ++++
>   drivers/gpu/drm/panfrost/Makefile             |  2 -
>   drivers/gpu/drm/panfrost/panfrost_debugfs.c   | 21 ----------
>   drivers/gpu/drm/panfrost/panfrost_debugfs.h   | 14 -------
>   drivers/gpu/drm/panfrost/panfrost_device.h    |  2 +-
>   drivers/gpu/drm/panfrost/panfrost_drv.c       | 41 ++++++++++++++++---
>   drivers/gpu/drm/panfrost/panfrost_job.c       |  2 +-
>   8 files changed, 57 insertions(+), 44 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-driver-panfrost-profiling
>   delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.c
>   delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-panfrost-profiling b/Documentation/ABI/testing/sysfs-driver-panfrost-profiling
> new file mode 100644
> index 000000000000..1d8bb0978920
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-panfrost-profiling
> @@ -0,0 +1,10 @@
> +What:		/sys/bus/platform/drivers/panfrost/.../profiling
> +Date:		February 2024
> +KernelVersion:	6.8.0
> +Contact:	Adrian Larumbe <adrian.larumbe@collabora.com>
> +Description:
> +		Get/set drm fdinfo's engine and cycles profiling status.
> +		Valid values are:
> +		0: Don't enable fdinfo job profiling sources.
> +		1: Enable fdinfo job profiling sources, this enables both the GPU's
> +		   timestamp and cycle counter registers.
> \ No newline at end of file
> diff --git a/Documentation/gpu/panfrost.rst b/Documentation/gpu/panfrost.rst
> index b80e41f4b2c5..51ba375fd80d 100644
> --- a/Documentation/gpu/panfrost.rst
> +++ b/Documentation/gpu/panfrost.rst
> @@ -38,3 +38,12 @@ the currently possible format options:
>   
>   Possible `drm-engine-` key names are: `fragment`, and  `vertex-tiler`.
>   `drm-curfreq-` values convey the current operating frequency for that engine.
> +
> +Users must bear in mind that engine and cycle sampling are disabled by default,
> +because of power saving concerns. `fdinfo` users and benchmark applications which
> +query the fdinfo file must make sure to toggle the job profiling status of the
> +driver by writing into the appropriate sysfs node::
> +
> +    echo <N> > /sys/bus/platform/drivers/panfrost/[a-f0-9]*.gpu/profiling

A late thought - how it would work to not output the inactive fdinfo 
keys when this knob is not enabled?

Generic userspace like gputop already handles that and wouldn't show the 
stat. Which may be more user friendly than showing stats permanently at 
zero. It may be moot once you add the auto-toggle to gputop (or so) but 
perhaps worth considering.

Regards,

Tvrtko

> +
> +Where `N` is either `0` or `1`, depending on the desired enablement status.
> diff --git a/drivers/gpu/drm/panfrost/Makefile b/drivers/gpu/drm/panfrost/Makefile
> index 2c01c1e7523e..7da2b3f02ed9 100644
> --- a/drivers/gpu/drm/panfrost/Makefile
> +++ b/drivers/gpu/drm/panfrost/Makefile
> @@ -12,6 +12,4 @@ panfrost-y := \
>   	panfrost_perfcnt.o \
>   	panfrost_dump.o
>   
> -panfrost-$(CONFIG_DEBUG_FS) += panfrost_debugfs.o
> -
>   obj-$(CONFIG_DRM_PANFROST) += panfrost.o
> diff --git a/drivers/gpu/drm/panfrost/panfrost_debugfs.c b/drivers/gpu/drm/panfrost/panfrost_debugfs.c
> deleted file mode 100644
> index 72d4286a6bf7..000000000000
> --- a/drivers/gpu/drm/panfrost/panfrost_debugfs.c
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/* Copyright 2023 Collabora ltd. */
> -/* Copyright 2023 Amazon.com, Inc. or its affiliates. */
> -
> -#include <linux/debugfs.h>
> -#include <linux/platform_device.h>
> -#include <drm/drm_debugfs.h>
> -#include <drm/drm_file.h>
> -#include <drm/panfrost_drm.h>
> -
> -#include "panfrost_device.h"
> -#include "panfrost_gpu.h"
> -#include "panfrost_debugfs.h"
> -
> -void panfrost_debugfs_init(struct drm_minor *minor)
> -{
> -	struct drm_device *dev = minor->dev;
> -	struct panfrost_device *pfdev = platform_get_drvdata(to_platform_device(dev->dev));
> -
> -	debugfs_create_atomic_t("profile", 0600, minor->debugfs_root, &pfdev->profile_mode);
> -}
> diff --git a/drivers/gpu/drm/panfrost/panfrost_debugfs.h b/drivers/gpu/drm/panfrost/panfrost_debugfs.h
> deleted file mode 100644
> index c5af5f35877f..000000000000
> --- a/drivers/gpu/drm/panfrost/panfrost_debugfs.h
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright 2023 Collabora ltd.
> - * Copyright 2023 Amazon.com, Inc. or its affiliates.
> - */
> -
> -#ifndef PANFROST_DEBUGFS_H
> -#define PANFROST_DEBUGFS_H
> -
> -#ifdef CONFIG_DEBUG_FS
> -void panfrost_debugfs_init(struct drm_minor *minor);
> -#endif
> -
> -#endif  /* PANFROST_DEBUGFS_H */
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index 62f7e3527385..cffcb0ac7c11 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -130,7 +130,7 @@ struct panfrost_device {
>   	struct list_head scheduled_jobs;
>   
>   	struct panfrost_perfcnt *perfcnt;
> -	atomic_t profile_mode;
> +	bool profile_mode;
>   
>   	struct mutex sched_lock;
>   
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index a926d71e8131..9696702800a4 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -20,7 +20,6 @@
>   #include "panfrost_job.h"
>   #include "panfrost_gpu.h"
>   #include "panfrost_perfcnt.h"
> -#include "panfrost_debugfs.h"
>   
>   static bool unstable_ioctls;
>   module_param_unsafe(unstable_ioctls, bool, 0600);
> @@ -600,10 +599,6 @@ static const struct drm_driver panfrost_drm_driver = {
>   
>   	.gem_create_object	= panfrost_gem_create_object,
>   	.gem_prime_import_sg_table = panfrost_gem_prime_import_sg_table,
> -
> -#ifdef CONFIG_DEBUG_FS
> -	.debugfs_init		= panfrost_debugfs_init,
> -#endif
>   };
>   
>   static int panfrost_probe(struct platform_device *pdev)
> @@ -692,6 +687,41 @@ static void panfrost_remove(struct platform_device *pdev)
>   	drm_dev_put(ddev);
>   }
>   
> +static ssize_t profiling_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", pfdev->profile_mode);
> +}
> +
> +
> +static ssize_t profiling_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	err = kstrtobool(buf, &value);
> +	if (err)
> +		return err;
> +
> +	pfdev->profile_mode = value;
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RW(profiling);
> +
> +static struct attribute *panfrost_attrs[] = {
> +	&dev_attr_profiling.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(panfrost);
> +
>   /*
>    * The OPP core wants the supply names to be NULL terminated, but we need the
>    * correct num_supplies value for regulator core. Hence, we NULL terminate here
> @@ -789,6 +819,7 @@ static struct platform_driver panfrost_driver = {
>   		.name	= "panfrost",
>   		.pm	= pm_ptr(&panfrost_pm_ops),
>   		.of_match_table = dt_match,
> +		.dev_groups = panfrost_groups,
>   	},
>   };
>   module_platform_driver(panfrost_driver);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 0c2dbf6ef2a5..a61ef0af9a4e 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -243,7 +243,7 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>   	subslot = panfrost_enqueue_job(pfdev, js, job);
>   	/* Don't queue the job if a reset is in progress */
>   	if (!atomic_read(&pfdev->reset.pending)) {
> -		if (atomic_read(&pfdev->profile_mode)) {
> +		if (pfdev->profile_mode) {
>   			panfrost_cycle_counter_get(pfdev);
>   			job->is_profiled = true;
>   			job->start_time = ktime_get();

