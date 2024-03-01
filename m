Return-Path: <linux-kernel+bounces-88427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F341886E177
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C5CB23A65
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABFD4087D;
	Fri,  1 Mar 2024 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hl9uvELK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1680A3D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298200; cv=none; b=EjOUwALDHhuXD39LTwM+SsrMArX9tBoBTFWlD6HHCzMjGSeZgyjsni4rb/tw7PQHSIACFCRESUUWTwwlSjm8iYmNEamDAIGUTugILaxDbLa7L0LhrQNOtIIfGPlKryHvRSRFA7rflTYsUV8dhQR0UjZ+SmX8eLalxpo/B3/UlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298200; c=relaxed/simple;
	bh=JXFXbkCmnJc7dy0GTKc8RStAhsBUY/3tP6GsmxDDIjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ms5NbVH4fyRI9Svm+iM2HYYW5Ok/3CZS3J80ARlQkt/oeEsmI4bNXsrYWr94yRL5z+nyxiqKPo9LJXJYUoSygo1Ae0rz6mfnj6Xwhyp9ZzfZ1NPSU8KO79kpGWOQz4QTSS6ECOWDdbsNYd/ms9uDbXQopj/XV2YKhDQi1DZPz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hl9uvELK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709298197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/qP7BkfcaycLQyChRhPXC6XUe4vu8moh456KABJOUU=;
	b=hl9uvELKbdRHegwsr/RCgPRguf7CNfOPKBZ6LxxxBe3zJYXLnlWFxLTYPTCdYoLlQoCe2Y
	yrElxRvkl6sJrDxmks4MrQ64R0zmzp59Lr+u67Vb38VlbgLhmKsHSfdtvm8qGnZA6wWkPa
	FCQNIbNnWzhBLul8o20DjPGUvYgInvk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-3TN_Tu8oM5WYaSRwwiSCSQ-1; Fri, 01 Mar 2024 08:03:16 -0500
X-MC-Unique: 3TN_Tu8oM5WYaSRwwiSCSQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33dbbe709ffso936624f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 05:03:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709298195; x=1709902995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/qP7BkfcaycLQyChRhPXC6XUe4vu8moh456KABJOUU=;
        b=ByQHGDIghv8Opp+6s/Ye5n9L8rE5yoClYrRe2HtC292tXbDTMtRDp8rgf/DEY0bt7m
         bchrzFedV3jOn15vjTl+xNdGJjov6LU7LoRZo/5qHtfzcd/r9SXax3pYZ2obXAmhPj3X
         LJZjRZ4n9ChyeLwCUhtJ4TSKAaNMYU5ORDKsuJ/f9pNqS0R2WKod5ukeaHK/Gg/ph3Y8
         /g97zL90L0WW2FEBzuno6KwBZZqPMUdbbE3rpRSuYZguYoO4L9B3RMIH+lerkXn7JcRh
         IGslKObTwex9r+OW/opY8dVRwEU6ekf9YN9VHVH7ry9cuA4gO4HVMBvtIuR23b5PbgeD
         Hv/w==
X-Gm-Message-State: AOJu0YwrN9mbNdOvfhj6BZePwrl0zJhGgvacRXUlg+Ta9H45wcSxDfTi
	maiznkcux9RmWcE/Or3ToEih49unUlVNbMYsnat3m6XqDDeG9D7/m8yZMX0n4oKg/jzHMqGOsGz
	xIuYZO/E86SIzviDltoPjCLj7/uoIJMzimw3v0xAqo/w93hWbqc3+AXxd1AfOSA==
X-Received: by 2002:adf:b613:0:b0:33d:222d:f380 with SMTP id f19-20020adfb613000000b0033d222df380mr1737697wre.0.1709298195064;
        Fri, 01 Mar 2024 05:03:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8aSQ157XmhlC80y73KwlubXY2BhLVewuKNvaN2kz8bfjRbG0WIWUlTvoskpdefk7jmfVLOQ==
X-Received: by 2002:adf:b613:0:b0:33d:222d:f380 with SMTP id f19-20020adfb613000000b0033d222df380mr1737670wre.0.1709298194495;
        Fri, 01 Mar 2024 05:03:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id j3-20020adff003000000b0033e01e397d6sm4495397wro.54.2024.03.01.05.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 05:03:14 -0800 (PST)
Message-ID: <78087e9b-533a-4d74-9ffe-8e4eb36e448a@redhat.com>
Date: Fri, 1 Mar 2024 14:03:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/panic: Add drm panic locking
Content-Language: en-US, fr
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
 DRI Development <dri-devel@lists.freedesktop.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Lukas Wunner <lukas@wunner.de>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240301100516.2516297-1-daniel.vetter@ffwll.ch>
 <20240301103903.2538083-1-daniel.vetter@ffwll.ch>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240301103903.2538083-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the patch.

I think it misses to initialize the lock, so we need to add a 
raw_spin_lock_init() in the drm device initialization.

Also I'm wondering if it make sense to put that under the 
CONFIG_DRM_PANIC flag, so that if you don't enable it, panic_lock() and 
panic_unlock() would be no-op.
But that may not work if the driver uses this lock to protect some 
register access.

Best regards,

-- 

Jocelyn

On 01/03/2024 11:39, Daniel Vetter wrote:
> Rough sketch for the locking of drm panic printing code. The upshot of
> this approach is that we can pretty much entirely rely on the atomic
> commit flow, with the pair of raw_spin_lock/unlock providing any
> barriers we need, without having to create really big critical
> sections in code.
> 
> This also avoids the need that drivers must explicitly update the
> panic handler state, which they might forget to do, or not do
> consistently, and then we blow up in the worst possible times.
> 
> It is somewhat racy against a concurrent atomic update, and we might
> write into a buffer which the hardware will never display. But there's
> fundamentally no way to avoid that - if we do the panic state update
> explicitly after writing to the hardware, we might instead write to an
> old buffer that the user will barely ever see.
> 
> Note that an rcu protected deference of plane->state would give us the
> the same guarantees, but it has the downside that we then need to
> protect the plane state freeing functions with call_rcu too. Which
> would very widely impact a lot of code and therefore doesn't seem
> worth the complexity compared to a raw spinlock with very tiny
> critical sections. Plus rcu cannot be used to protect access to
> peek/poke registers anyway, so we'd still need it for those cases.
> 
> Peek/poke registers for vram access (or a gart pte reserved just for
> panic code) are also the reason I've gone with a per-device and not
> per-plane spinlock, since usually these things are global for the
> entire display. Going with per-plane locks would mean drivers for such
> hardware would need additional locks, which we don't want, since it
> deviates from the per-console takeoverlocks design.
> 
> Longer term it might be useful if the panic notifiers grow a bit more
> structure than just the absolute bare
> EXPORT_SYMBOL(panic_notifier_list) - somewhat aside, why is that not
> EXPORT_SYMBOL_GPL ... If panic notifiers would be more like console
> drivers with proper register/unregister interfaces we could perhaps
> reuse the very fancy console lock with all it's check and takeover
> semantics that John Ogness is developing to fix the console_lock mess.
> But for the initial cut of a drm panic printing support I don't think
> we need that, because the critical sections are extremely small and
> only happen once per display refresh. So generally just 60 tiny locked
> sections per second, which is nothing compared to a serial console
> running a 115kbaud doing really slow mmio writes for each byte. So for
> now the raw spintrylock in drm panic notifier callback should be good
> enough.
> 
> Another benefit of making panic notifiers more like full blown
> consoles (that are used in panics only) would be that we get the two
> stage design, where first all the safe outputs are used. And then the
> dangerous takeover tricks are deployed (where for display drivers we
> also might try to intercept any in-flight display buffer flips, which
> if we race and misprogram fifos and watermarks can hang the memory
> controller on some hw).
> 
> For context the actual implementation on the drm side is by Jocelyn
> and this patch is meant to be combined with the overall approach in
> v7 (v8 is a bit less flexible, which I think is the wrong direction):
> 
> https://lore.kernel.org/dri-devel/20240104160301.185915-1-jfalempe@redhat.com/
> 
> Note that the locking is very much not correct there, hence this
> separate rfc.
> 
> v2:
> - fix authorship, this was all my typing
> - some typo oopsies
> - link to the drm panic work by Jocelyn for context
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>   drivers/gpu/drm/drm_atomic_helper.c |  3 +
>   include/drm/drm_mode_config.h       | 10 +++
>   include/drm/drm_panic.h             | 99 +++++++++++++++++++++++++++++
>   3 files changed, 112 insertions(+)
>   create mode 100644 include/drm/drm_panic.h
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 40c2bd3e62e8..5a908c186037 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -38,6 +38,7 @@
>   #include <drm/drm_drv.h>
>   #include <drm/drm_framebuffer.h>
>   #include <drm/drm_gem_atomic_helper.h>
> +#include <drm/drm_panic.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_self_refresh_helper.h>
>   #include <drm/drm_vblank.h>
> @@ -3086,6 +3087,7 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
>   		}
>   	}
>   
> +	drm_panic_lock(state->dev);
>   	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
>   		WARN_ON(plane->state != old_plane_state);
>   
> @@ -3095,6 +3097,7 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
>   		state->planes[i].state = old_plane_state;
>   		plane->state = new_plane_state;
>   	}
> +	drm_panic_unlock(state->dev);
>   
>   	for_each_oldnew_private_obj_in_state(state, obj, old_obj_state, new_obj_state, i) {
>   		WARN_ON(obj->state != old_obj_state);
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 973119a9176b..e79f1a557a22 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -505,6 +505,16 @@ struct drm_mode_config {
>   	 */
>   	struct list_head plane_list;
>   
> +	/**
> +	 * @panic_lock:
> +	 *
> +	 * Raw spinlock used to protect critical sections of code that access
> +	 * the display hardware or modeset software state, which the panic
> +	 * printing code must be protected against. See drm_panic_trylock(),
> +	 * drm_panic_lock() and drm_panic_unlock().
> +	 */
> +	struct raw_spinlock panic_lock;
> +
>   	/**
>   	 * @num_crtc:
>   	 *
> diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
> new file mode 100644
> index 000000000000..f2135d03f1eb
> --- /dev/null
> +++ b/include/drm/drm_panic.h
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0 or MIT */
> +#ifndef __DRM_PANIC_H__
> +#define __DRM_PANIC_H__
> +
> +#include <drm/drm_device.h>
> +/*
> + * Copyright (c) 2024 Intel
> + */
> +
> +/**
> + * drm_panic_trylock - try to enter the panic printing critical section
> + * @dev: struct drm_device
> + *
> + * This function must be called by any panic printing code. The panic printing
> + * attempt must be aborted if the trylock fails.
> + *
> + * Panic printing code can make the following assumptions while holding the
> + * panic lock:
> + *
> + * - Anything protected by drm_panic_lock() and drm_panic_unlock() pairs is safe
> + *   to access.
> + *
> + * - Furthermore the panic printing code only registers in drm_dev_unregister()
> + *   and gets removed in drm_dev_unregister(). This allows the panic code to
> + *   safely access any state which is invariant in between these two function
> + *   calls, like the list of planes drm_mode_config.plane_list or most of the
> + *   struct drm_plane structure.
> + *
> + * Specifically thanks to the protection around plane updates in
> + * drm_atomic_helper_swap_state() the following additional guarantees hold:
> + *
> + * - It is safe to deference the drm_plane.state pointer.
> + *
> + * - Anything in struct drm_plane_state or the driver's subclass thereof which
> + *   stays invariant after the atomic check code has finished is safe to access.
> + *   Specifically this includes the reference counted pointers to framebuffer
> + *   and buffer objects.
> + *
> + * - Anything set up by drm_plane_helper_funcs.fb_prepare and cleaned up
> + *   drm_plane_helper_funcs.fb_cleanup is safe to access, as long as it stays
> + *   invariant between these two calls. This also means that for drivers using
> + *   dynamic buffer management the framebuffer is pinned, and therefer all
> + *   relevant datastructures can be accessed without taking any further locks
> + *   (which would be impossible in panic context anyway).
> + *
> + * - Importantly, software and hardware state set up by
> + *   drm_plane_helper_funcs.begin_fb_access and
> + *   drm_plane_helper_funcs.end_fb_access is not safe to access.
> + *
> + * Drivers must not make any assumptions about the actual state of the hardware,
> + * unless they explicitly protected these hardware access with drm_panic_lock()
> + * and drm_panic_unlock().
> + *
> + * Returns:
> + *
> + * 0 when failing to acquire the raw spinlock, nonzero on success.
> + */
> +static inline int drm_panic_trylock(struct drm_device *dev)
> +{
> +	return raw_spin_trylock(&dev->mode_config.panic_lock);
> +}
> +
> +/**
> + * drm_panic_lock - protect panic printing relevant state
> + * @dev: struct drm_device
> + *
> + * This function must be called to protect software and hardware state that the
> + * panic printing code must be able to rely on. The protected sections must be
> + * as small as possible. Examples include:
> + *
> + * - Access to peek/poke or other similar registers, if that is the way the
> + *   driver prints the pixels into the scanout buffer at panic time.
> + *
> + * - Updates to pointers like drm_plane.state, allowing the panic handler to
> + *   safely deference these. This is done in drm_atomic_helper_swap_state().
> + *
> + * - An state that isn't invariant and that the driver must be able to access
> + *   during panic printing.
> + *
> + * Call drm_panic_unlock() to unlock the locked spinlock.
> + */
> +static inline void drm_panic_lock(struct drm_device *dev)
> +{
> +	return raw_spin_lock(&dev->mode_config.panic_lock);
> +}
> +
> +/**
> + * drm_panic_unlock - end of the panic printing critical section
> + * @dev: struct drm_device
> + *
> + * Unlocks the raw spinlock acquired by either drm_panic_lock() or
> + * drm_panic_trylock().
> + */
> +static inline void drm_panic_unlock(struct drm_device *dev)
> +{
> +	raw_spin_unlock(&dev->mode_config.panic_lock);
> +}
> +
> +#endif /* __DRM_PANIC_H__ */


