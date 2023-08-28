Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E0378A8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjH1J01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjH1J0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:26:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8642CBE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:26:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 82E3B660719F;
        Mon, 28 Aug 2023 10:26:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693214767;
        bh=NTDOelTiWBYU9tc8wqDN3s9YQi6RLHJHso4kMH0H3TE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FI51Z7bvKrol8eTZTpY6PbAC5O8LbMps1y9e2Qqr/jDnW/Ag54+G+wg5KhJ/hjD6+
         cmmRgvQlLfJmoQVeb8NYVS9w5arpCQpOSpzyc90ohzrgihHr7ECY0VOvAXHZSeCdqY
         clH6Ry/HCDhevpS/7g80siA7Ugd7sYGJSjboQ0tFwauCRfFB1hEnS7QPB8npXuUnmd
         Z2KhcH+A99vOZZ2mUzpMm+jFMDLWy5WxNtgk1SzMAuyFGAKutFWZDBJtQMK0UBBsUl
         0aw3R31RrE9Nd10Oh9Voa4gNAaIlafws47Eb1CuSRKFtZg1UID1ETSKaNgbkSDGelz
         fY6412pZBqIyA==
Date:   Mon, 28 Aug 2023 11:26:04 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v15 10/23] locking/refcount, kref: Add
 kref_put_ww_mutex()
Message-ID: <20230828112604.297db23a@collabora.com>
In-Reply-To: <20230827175449.1766701-11-dmitry.osipenko@collabora.com>
References: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
        <20230827175449.1766701-11-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2023 20:54:36 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Introduce kref_put_ww_mutex() helper that will handle the wait-wound
> mutex auto-locking on kref_put(). This helper is wanted by DRM drivers
> that extensively use dma-reservation locking which in turns uses ww-mutex.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  include/linux/kref.h     | 12 ++++++++++++
>  include/linux/refcount.h |  5 +++++
>  lib/refcount.c           | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+)
> 
> diff --git a/include/linux/kref.h b/include/linux/kref.h
> index d32e21a2538c..b2d8dc6e9ae0 100644
> --- a/include/linux/kref.h
> +++ b/include/linux/kref.h
> @@ -90,6 +90,18 @@ static inline int kref_put_lock(struct kref *kref,
>  	return 0;
>  }
>  
> +static inline int kref_put_ww_mutex(struct kref *kref,
> +				    void (*release)(struct kref *kref),
> +				    struct ww_mutex *lock,
> +				    struct ww_acquire_ctx *ctx)
> +{
> +	if (refcount_dec_and_ww_mutex_lock(&kref->refcount, lock, ctx)) {
> +		release(kref);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
>  /**
>   * kref_get_unless_zero - Increment refcount for object unless it is zero.
>   * @kref: object.
> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index a62fcca97486..be9ad272bc77 100644
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -99,6 +99,8 @@
>  #include <linux/spinlock_types.h>
>  
>  struct mutex;
> +struct ww_mutex;
> +struct ww_acquire_ctx;
>  
>  /**
>   * typedef refcount_t - variant of atomic_t specialized for reference counts
> @@ -366,4 +368,7 @@ extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
>  extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
>  						       spinlock_t *lock,
>  						       unsigned long *flags) __cond_acquires(lock);
> +extern __must_check bool refcount_dec_and_ww_mutex_lock(refcount_t *r,
> +							struct ww_mutex *lock,
> +							struct ww_acquire_ctx *ctx) __cond_acquires(&lock->base);
>  #endif /* _LINUX_REFCOUNT_H */
> diff --git a/lib/refcount.c b/lib/refcount.c
> index a207a8f22b3c..3f6fd0ceed02 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -6,6 +6,7 @@
>  #include <linux/mutex.h>
>  #include <linux/refcount.h>
>  #include <linux/spinlock.h>
> +#include <linux/ww_mutex.h>
>  #include <linux/bug.h>
>  
>  #define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
> @@ -184,3 +185,36 @@ bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
>  	return true;
>  }
>  EXPORT_SYMBOL(refcount_dec_and_lock_irqsave);
> +
> +/**
> + * refcount_dec_and_ww_mutex_lock - return holding ww-mutex if able to
> + *                                  decrement refcount to 0
> + * @r: the refcount
> + * @lock: the ww-mutex to be locked
> + * @ctx: wait-wound context
> + *
> + * Similar to atomic_dec_and_lock(), it will WARN on underflow and fail to
> + * decrement when saturated at REFCOUNT_SATURATED.
> + *
> + * Provides release memory ordering, such that prior loads and stores are done
> + * before, and provides a control dependency such that free() must come after.
> + * See the comment on top.
> + *
> + * Return: true and hold ww-mutex lock if able to decrement refcount to 0,
> + *         false otherwise
> + */
> +bool refcount_dec_and_ww_mutex_lock(refcount_t *r, struct ww_mutex *lock,
> +				    struct ww_acquire_ctx *ctx)
> +{
> +	if (refcount_dec_not_one(r))
> +		return false;
> +
> +	ww_mutex_lock(lock, ctx);

Unless I'm wrong, ww_mutex_lock() can return -EDEADLK when ctx !=
NULL, in which case, the lock is not held when it returns. Question is,
do we really have a use case for ctx != NULL in that kref_put_ww_mutex()
path. If we need to acquire other ww_locks, this lock, and the other
locks should have been acquired beforehand, and we can simply call
kref_put() when we want to release the ref on the resource.

> +	if (!refcount_dec_and_test(r)) {
> +		ww_mutex_unlock(lock);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(refcount_dec_and_ww_mutex_lock);

