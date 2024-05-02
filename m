Return-Path: <linux-kernel+bounces-166094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A08658B9624
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1543B1F219F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1B62D047;
	Thu,  2 May 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Te0k8KkS"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2803C37144
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637369; cv=none; b=Ft0kLfgHyi7qfQEGneL8qXaV+TfA4SEq0ui2+ShrSBROGcomqeHMT/KO8a3ncX04ZRKzFArmWaYRs9caFs627Waol6ebimb6ef3pRoFt0/6yCXKui/W4Th1DPftCAQ+zEkTs7vDOc8XNgLaYBrrfk9m8mzhWMnwFTnImLaBtEzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637369; c=relaxed/simple;
	bh=MKtcFh18dPF6q18h2Jp/t6VQnkGQ8LNyrdKJ9KVUt6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBluZDMgw9p5bY+IUCIlGSocfdLFaLZpTKUEpieJNvhMccc5mGeHJl4+2bCcZ+OKYHjh9eHK2f0Xsy1bnGGZqaX94tYu7NvR8ndhAw0gVdC59jIfuON/7nMokhHqxtBM/GSY7OYR3ywg6tYIQ+ZQjx4xrSDmLnpYar2h//dGP04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Te0k8KkS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-416463e82fbso4595995e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1714637366; x=1715242166; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0koyprm7usSu/SuJa/n4v1oM1npXoejPyXWW+NRGnRQ=;
        b=Te0k8KkS8wc/uR8kMMT9/bs42RsXlT6SIyVC2O2sSQ2pS9Us3vWpay/l9BhOYOTUy0
         v81Su067dNp2TbjSehYv4ggvQgdzIR3id1x1FEyI7al+OPZipujWxwLuqbHRun9zi/e8
         3TyLFnIRISQPBzRRYGXC+UhKUeq8F521rY9+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637366; x=1715242166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0koyprm7usSu/SuJa/n4v1oM1npXoejPyXWW+NRGnRQ=;
        b=v6htHTBc+QaNt/bTuov6Ht6vd4gInsdjq5v/G93Oo+2pAwogoXWZbQd49LZH3KJNAd
         r+gs+mx9GXgiEFhLZJwQEVCPMJsMzyOVE4g2cc1o3Nfd+o5khTnTIwU5E788eIF4tcUU
         kQ19jEfgb2RqgYyyRA6yNdqVKP4jDp7JrnEoKFiXa+B9z+AVODJo5B+1qXnMbg1Hd9o+
         HQd2+LmVUitSChzrQ0dwzThQ0l2X8WGaajr8UqPOmqxBBLvh3U8nS9UBlQ/rwoL0ZdgV
         syYTPtzUMjqMqwzlQn9gkSMA7SUv2ufdvQOXTdaHCr75JEOV8sARTvmGPzzZL4fKc/BI
         W46Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaCCNe5xwlVmAUycZVel0KlImcg0ItVgsWVpoIiPzHg/9Sl+O1tCHGRL22OLaRziKG4iW8Exbp1VhPYqROBXI3JzcXRa2jvWrUeZl1
X-Gm-Message-State: AOJu0YzBjlXBKwyyxbAXLbBBP74RUkynz8O8dVMPIPYCwjMyO8ieUPAz
	Qv1s9bpy55mEh4nHMUlbj7Ebcej9sbAladUm62Y6XOviusSxLITHyjUUjxOpBnaL313ABK9q+GT
	3
X-Google-Smtp-Source: AGHT+IGlj87pWvRxvdp+xbVn2sO0D6niYS3Puzn6qWBx5arATQrmZ7u1LX4Bqyd8ZFf8CFxYpmGIVA==
X-Received: by 2002:adf:ed4b:0:b0:34c:f9c9:f51c with SMTP id u11-20020adfed4b000000b0034cf9c9f51cmr3374495wro.4.1714637366272;
        Thu, 02 May 2024 01:09:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id r2-20020adfce82000000b0034dd7984d7fsm611033wrn.94.2024.05.02.01.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 01:09:25 -0700 (PDT)
Date: Thu, 2 May 2024 10:09:17 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: =?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH v2 1/1] drm: Add ioctl for querying a DRM device's list
 of open client PIDs
Message-ID: <ZjNKLVZgekRqw5AL@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, kernel@collabora.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Rob Clark <robdclark@gmail.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
References: <20240501185047.3126832-1-adrian.larumbe@collabora.com>
 <20240501185047.3126832-2-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501185047.3126832-2-adrian.larumbe@collabora.com>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Wed, May 01, 2024 at 07:50:43PM +0100, Adrián Larumbe wrote:
> Up to this day, all fdinfo-based GPU profilers must traverse the entire
> /proc directory structure to find open DRM clients with fdinfo file
> descriptors. This is inefficient and time-consuming.
> 
> This patch adds a new DRM ioctl that allows users to obtain a list of PIDs
> for clients who have opened the DRM device. Output from the ioctl isn't
> human-readable, and it's meant to be retrieved only by GPU profilers like
> gputop and nvtop.
> 
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/drm_internal.h |  1 +
>  drivers/gpu/drm/drm_ioctl.c    | 89 ++++++++++++++++++++++++++++++++++
>  include/uapi/drm/drm.h         |  7 +++
>  3 files changed, 97 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> index 690505a1f7a5..6f78954cae16 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -243,6 +243,7 @@ static inline void drm_debugfs_encoder_remove(struct drm_encoder *encoder)
>  drm_ioctl_t drm_version;
>  drm_ioctl_t drm_getunique;
>  drm_ioctl_t drm_getclient;
> +drm_ioctl_t drm_getclients;
>  
>  /* drm_syncobj.c */
>  void drm_syncobj_open(struct drm_file *file_private);
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index e368fc084c77..da7057376581 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -207,6 +207,93 @@ int drm_getclient(struct drm_device *dev, void *data,
>  	}
>  }
>  
> +/*
> + * Get list of client PIDs who have opened a DRM file
> + *
> + * \param dev DRM device we are querying
> + * \param data IOCTL command input.
> + * \param file_priv DRM file private.
> + *
> + * \return zero on success or a negative number on failure.
> + *
> + * Traverses list of open clients for the given DRM device, and
> + * copies them into userpace as an array of PIDs
> + */
> +int drm_getclients(struct drm_device *dev, void *data,
> +		   struct drm_file *file_priv)
> +
> +{
> +	struct drm_get_clients *get_clients = data;
> +	ssize_t size = get_clients->len;
> +	char __user *pid_buf;
> +	ssize_t offset = 0;
> +	int ret = 0;
> +
> +	/*
> +	 * We do not want to show clients of display only devices so
> +	 * as to avoid confusing UM GPU profilers
> +	 */
> +	if (!dev->render) {
> +		get_clients->len = 0;
> +		return 0;
> +	}
> +
> +	/*
> +	 * An input size of zero means UM wants to know the size of the PID buffer
> +	 * We round it up to the nearest multiple of the page size so that we can have
> +	 * some spare headroom in case more clients came in between successive calls
> +	 * of this ioctl, and also to simplify parsing of the PIDs buffer, because
> +	 * sizeof(pid_t) will hopefully always divide PAGE_SIZE
> +	 */
> +	if (size == 0) {
> +		get_clients->len =
> +			roundup(atomic_read(&dev->open_count) * sizeof(pid_t), PAGE_SIZE);
> +		return 0;
> +	}
> +
> +	pid_buf = (char *)(void *)get_clients->user_data;
> +
> +	if (!pid_buf)
> +		return -EINVAL;
> +
> +	mutex_lock(&dev->filelist_mutex);
> +	list_for_each_entry_reverse(file_priv, &dev->filelist, lhead) {
> +		pid_t pid_num;
> +
> +		if ((size - offset) < sizeof(pid_t))
> +			break;
> +
> +		rcu_read_lock();
> +		pid_num = pid_vnr(rcu_dereference(file_priv->pid));
> +		rcu_read_unlock();
> +
> +		/* We do not want to return the profiler's PID */
> +		if (pid_vnr(task_tgid(current)) == pid_num)
> +			continue;
> +
> +		ret = copy_to_user(pid_buf + offset, &pid_num, sizeof(pid_t));
> +		if (ret)
> +			break;
> +
> +		offset += sizeof(pid_t);
> +	}
> +	mutex_unlock(&dev->filelist_mutex);
> +
> +	if (ret)
> +		return -EFAULT;
> +
> +	if ((size - offset) >= sizeof(pid_t)) {
> +		pid_t pid_zero = 0;
> +
> +		ret = copy_to_user(pid_buf + offset,
> +				   &pid_zero, sizeof(pid_t));
> +		if (ret)
> +			return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Get statistics information.
>   *
> @@ -672,6 +759,8 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_LIST_LESSEES, drm_mode_list_lessees_ioctl, DRM_MASTER),
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GET_LEASE, drm_mode_get_lease_ioctl, DRM_MASTER),
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_REVOKE_LEASE, drm_mode_revoke_lease_ioctl, DRM_MASTER),
> +
> +	DRM_IOCTL_DEF(DRM_IOCTL_GET_CLIENTS, drm_getclients, DRM_RENDER_ALLOW),

Uh RENDER_ALLOW sounds like a very bad idea for this, flat out leaks
information that really paranoid people don't want to have leaked.

Natural would be to limit to ptrace ability, but ptrace is for processes
and fd aren't tied to that. So I'm not sure ...

I think a separate file (whether in procfs or a special chardev) where you
can set access rights that suit feels a lot better for this. Plus putting
it into procfs would also give the natural property that you can only read
it if you have access to procfs anyway, so imo that feels like the best
place for this ...

And yes that means some lkml bikeshedding with procfs folks, but I do
think that's good here since we're likely not the only ones who need a bit
faster procfs trawling for some special use-cases. So consistency across
subsystems would be nice to at least try to aim for.
-Sima

>  };
>  
>  #define DRM_CORE_IOCTL_COUNT	ARRAY_SIZE(drm_ioctls)
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 16122819edfe..c47aa9de51ab 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -1024,6 +1024,11 @@ struct drm_crtc_queue_sequence {
>  	__u64 user_data;	/* user data passed to event */
>  };
>  
> +struct drm_get_clients {
> +	__u64 user_data;
> +	__kernel_size_t len;
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> @@ -1236,6 +1241,8 @@ extern "C" {
>  #define DRM_IOCTL_SYNCOBJ_TRANSFER	DRM_IOWR(0xCC, struct drm_syncobj_transfer)
>  #define DRM_IOCTL_SYNCOBJ_TIMELINE_SIGNAL	DRM_IOWR(0xCD, struct drm_syncobj_timeline_array)
>  
> +#define DRM_IOCTL_GET_CLIENTS		DRM_IOWR(0xD1, struct drm_get_clients)
> +
>  /**
>   * DRM_IOCTL_MODE_GETFB2 - Get framebuffer metadata.
>   *
> -- 
> 2.44.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

