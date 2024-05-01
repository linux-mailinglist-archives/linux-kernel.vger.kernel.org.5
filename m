Return-Path: <linux-kernel+bounces-165579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386258B8E30
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1EF1C213D6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7735BE71;
	Wed,  1 May 2024 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WPtYmdAt"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF58BE5
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581060; cv=none; b=VddWa6nomd7hZBoIZ52smSdI2DaJgt6TXcF6k7EV4Dmlt+ifC1i1BFLNZfX0ebjGcsbD/k5eFxabfhtHQBMXs+66dB1HwKMxRKl/0sV+yxjq/U/YWlMwQP3Guymx8ppmNK4VXazO3r2XMy0dazkzzhKL71LMBUNLa3rCqvVOPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581060; c=relaxed/simple;
	bh=wI0d5uI2O5mnddc0qH/JEJEhRyya2bF6GgWgGHIwi+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o78Rs88MKZZu7/QOHZsdek9717NPh7jKDLfEtwVcISehPDGRf+XyfCWzX7Cjmf/dzVX1Ce9A0qwoA3U/7MrfBPdWrOy+3V3FDQFftoDDvxyTSU/+mlaJZv7oQcIvkIApm4ABEAHVck7aDq/pf7LbsptAmiMu5lEfw8YdzEulqqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=WPtYmdAt; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2dffaf0c6afso1344841fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1714581057; x=1715185857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y752jhftptdt0C7UFaUbMxDQZl9ZN6d8fmcUcY8z3mk=;
        b=WPtYmdAtgYaMY0sV1rQR5jL9M/206PtZKQj1RUdIT2KouWjAEap3bjTFseg1QYUmDO
         3C6leFPgaZInQgPMLoc4AnYDUjXrOidfTVUF/YVq73ZlNSTkRRKltkOdGs9XxP0iLjfb
         zhj4GbUnSxSP1RubjV4NxuAWBX1L6asj7Re7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714581057; x=1715185857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y752jhftptdt0C7UFaUbMxDQZl9ZN6d8fmcUcY8z3mk=;
        b=qY50+fdXGqXYrUNTKFi9ElzeMP0pbYL7rio3EkAf6M7Dd1SgVEJaRUSrmaC/bXHFqC
         JM8pMhMld9E8KgehNFQsj+stZAH4vry4I1kcHLoXiv2BnckpBy9QPXHvGwww0U+w6b0U
         cUfnMVT5eqTXUrobwJB8F85BscDBcgJbf8J0TneK/lagXwL36DbH5eqhQpvQ7MmM07Up
         cjtqM9o0PaKNyPVYMRALtNPcnhJApLSWmA5Bte3ZEoI6gdQbBRZrSDc1jZLSM0ATaSXi
         rlxsp1nqeaNDn8uVTFHq3n4UxzX41WnLaKxrJM8ucGU+srPlaAuGLaxTEy63npeMZfvg
         drDg==
X-Forwarded-Encrypted: i=1; AJvYcCUZxRHzyjTYea8TM73QvTCFulaEfluGu92BhNngYXdamzUxyvU7CIqTzHTfGf9SFDxw7kgaGn6Golq1WWIWg5DBesGGpwCPenr4HVMD
X-Gm-Message-State: AOJu0Yw6DmyM3akdBFlGYZ65Ho5uz/0wXt71zV9vslxFE1jKU98Bkf4e
	Zm3zwshMSWaG5c7UPDv+h46mtMCpWRDUlkT7I4j3z/DLu6YkA9I1J5SqnHIeXPQ=
X-Google-Smtp-Source: AGHT+IGOJ9H+Nbtt2+OO9+GYWkWMUBLFGQppNYe+EIrQMMqtvnGDY+i0r0rEj2BJ6xY09jE/PuJLbw==
X-Received: by 2002:a2e:9e15:0:b0:2df:4a6a:a18d with SMTP id e21-20020a2e9e15000000b002df4a6aa18dmr1821945ljk.2.1714581056513;
        Wed, 01 May 2024 09:30:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b00418a386c17bsm2665811wms.12.2024.05.01.09.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:30:55 -0700 (PDT)
Date: Wed, 1 May 2024 18:30:53 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: =?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Hans de Goede <hdegoede@redhat.com>, kernel@collabora.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Christopher Healy <healych@amazon.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sysfs: Add drm class-wide attribute to get active
 device clients
Message-ID: <ZjJuPQBNnu41Djrr@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>, kernel@collabora.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Christopher Healy <healych@amazon.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240403182951.724488-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240403182951.724488-1-adrian.larumbe@collabora.com>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Wed, Apr 03, 2024 at 07:29:39PM +0100, Adrián Larumbe wrote:
> Up to this day, all fdinfo-based GPU profilers must traverse the entire
> /proc directory structure to find open DRM clients with fdinfo file
> descriptors. This is inefficient and time-consuming.
> 
> This patch adds a new device class attribute that will install a sysfs file
> per DRM device, which can be queried by profilers to get a list of PIDs for
> their open clients. This file isn't human-readable, and it's meant to be
> queried only by GPU profilers like gputop and nvtop.
> 
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: Christopher Healy <healych@amazon.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Tvrtko pointed me at this on irc and .. uh I think this definitely needs
an ack from Greg KH before we can land it. It's quite far away from what
sysfs uapi usually looks like and also semantically does ...
-Sima

> ---
>  drivers/gpu/drm/drm_internal.h       |  2 +-
>  drivers/gpu/drm/drm_privacy_screen.c |  2 +-
>  drivers/gpu/drm/drm_sysfs.c          | 89 ++++++++++++++++++++++------
>  3 files changed, 74 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> index 2215baef9a3e..9a399b03d11c 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -145,7 +145,7 @@ bool drm_master_internal_acquire(struct drm_device *dev);
>  void drm_master_internal_release(struct drm_device *dev);
>  
>  /* drm_sysfs.c */
> -extern struct class *drm_class;
> +extern struct class drm_class;
>  
>  int drm_sysfs_init(void);
>  void drm_sysfs_destroy(void);
> diff --git a/drivers/gpu/drm/drm_privacy_screen.c b/drivers/gpu/drm/drm_privacy_screen.c
> index 6cc39e30781f..2fbd24ba5818 100644
> --- a/drivers/gpu/drm/drm_privacy_screen.c
> +++ b/drivers/gpu/drm/drm_privacy_screen.c
> @@ -401,7 +401,7 @@ struct drm_privacy_screen *drm_privacy_screen_register(
>  	mutex_init(&priv->lock);
>  	BLOCKING_INIT_NOTIFIER_HEAD(&priv->notifier_head);
>  
> -	priv->dev.class = drm_class;
> +	priv->dev.class = &drm_class;
>  	priv->dev.type = &drm_privacy_screen_type;
>  	priv->dev.parent = parent;
>  	priv->dev.release = drm_privacy_screen_device_release;
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index a953f69a34b6..56ca9e22c720 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -58,8 +58,6 @@ static struct device_type drm_sysfs_device_connector = {
>  	.name = "drm_connector",
>  };
>  
> -struct class *drm_class;
> -
>  #ifdef CONFIG_ACPI
>  static bool drm_connector_acpi_bus_match(struct device *dev)
>  {
> @@ -128,6 +126,62 @@ static const struct component_ops typec_connector_ops = {
>  
>  static CLASS_ATTR_STRING(version, S_IRUGO, "drm 1.1.0 20060810");
>  
> +static ssize_t clients_show(struct device *cd, struct device_attribute *attr, char *buf)
> +{
> +	struct drm_minor *minor = cd->driver_data;
> +	struct drm_device *ddev = minor->dev;
> +	struct drm_file *priv;
> +	ssize_t offset = 0;
> +	void *pid_buf;
> +
> +	if (minor->type != DRM_MINOR_RENDER)
> +		return 0;
> +
> +	pid_buf = kvmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!pid_buf)
> +		return 0;
> +
> +	mutex_lock(&ddev->filelist_mutex);
> +	list_for_each_entry_reverse(priv, &ddev->filelist, lhead) {
> +		struct pid *pid;
> +
> +		if (drm_WARN_ON(ddev, (PAGE_SIZE - offset) < sizeof(pid_t)))
> +			break;
> +
> +		rcu_read_lock();
> +		pid = rcu_dereference(priv->pid);
> +		(*(pid_t *)(pid_buf + offset)) = pid_vnr(pid);
> +		rcu_read_unlock();
> +
> +		offset += sizeof(pid_t);
> +	}
> +	mutex_unlock(&ddev->filelist_mutex);
> +
> +	if (offset < PAGE_SIZE)
> +		(*(pid_t *)(pid_buf + offset)) = 0;
> +
> +	memcpy(buf, pid_buf, offset);
> +
> +	kvfree(pid_buf);
> +
> +	return offset;
> +
> +}
> +static DEVICE_ATTR_RO(clients);
> +
> +static struct attribute *drm_device_attrs[] = {
> +	&dev_attr_clients.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(drm_device);
> +
> +struct class drm_class = {
> +	.name		= "drm",
> +	.dev_groups	= drm_device_groups,
> +};
> +
> +static bool drm_class_initialised;
> +
>  /**
>   * drm_sysfs_init - initialize sysfs helpers
>   *
> @@ -142,18 +196,19 @@ int drm_sysfs_init(void)
>  {
>  	int err;
>  
> -	drm_class = class_create("drm");
> -	if (IS_ERR(drm_class))
> -		return PTR_ERR(drm_class);
> +	err = class_register(&drm_class);
> +	if (err)
> +		return err;
>  
> -	err = class_create_file(drm_class, &class_attr_version.attr);
> +	err = class_create_file(&drm_class, &class_attr_version.attr);
>  	if (err) {
> -		class_destroy(drm_class);
> -		drm_class = NULL;
> +		class_destroy(&drm_class);
>  		return err;
>  	}
>  
> -	drm_class->devnode = drm_devnode;
> +	drm_class.devnode = drm_devnode;
> +
> +	drm_class_initialised = true;
>  
>  	drm_sysfs_acpi_register();
>  	return 0;
> @@ -166,12 +221,12 @@ int drm_sysfs_init(void)
>   */
>  void drm_sysfs_destroy(void)
>  {
> -	if (IS_ERR_OR_NULL(drm_class))
> +	if (!drm_class_initialised)
>  		return;
>  	drm_sysfs_acpi_unregister();
> -	class_remove_file(drm_class, &class_attr_version.attr);
> -	class_destroy(drm_class);
> -	drm_class = NULL;
> +	class_remove_file(&drm_class, &class_attr_version.attr);
> +	class_destroy(&drm_class);
> +	drm_class_initialised = false;
>  }
>  
>  static void drm_sysfs_release(struct device *dev)
> @@ -372,7 +427,7 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
>  		return -ENOMEM;
>  
>  	device_initialize(kdev);
> -	kdev->class = drm_class;
> +	kdev->class = &drm_class;
>  	kdev->type = &drm_sysfs_device_connector;
>  	kdev->parent = dev->primary->kdev;
>  	kdev->groups = connector_dev_groups;
> @@ -550,7 +605,7 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
>  			minor_str = "card%d";
>  
>  		kdev->devt = MKDEV(DRM_MAJOR, minor->index);
> -		kdev->class = drm_class;
> +		kdev->class = &drm_class;
>  		kdev->type = &drm_sysfs_device_minor;
>  	}
>  
> @@ -579,10 +634,10 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
>   */
>  int drm_class_device_register(struct device *dev)
>  {
> -	if (!drm_class || IS_ERR(drm_class))
> +	if (!drm_class_initialised)
>  		return -ENOENT;
>  
> -	dev->class = drm_class;
> +	dev->class = &drm_class;
>  	return device_register(dev);
>  }
>  EXPORT_SYMBOL_GPL(drm_class_device_register);
> 
> base-commit: 45c734fdd43db14444025910b4c59dd2b8be714a
> -- 
> 2.44.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

