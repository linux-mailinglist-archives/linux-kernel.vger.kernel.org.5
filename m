Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0E878BCD1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbjH2C25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbjH2C2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:28:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECC1139
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:28:44 -0700 (PDT)
Received: from [192.168.2.140] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 37E3866071DC;
        Tue, 29 Aug 2023 03:28:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693276121;
        bh=DM5KhwPj8avJg4cJ+aVYATEnavak6IaIxX9ErWk0R6E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C25khkrDgJO3tLeM7ncP//gyJYaGGN2XWeD/tVXEDgzs3w7DHlFrfAcELXofi/BD4
         7FPc60rjkxlcPbmkkrL9xlpf4EZJ2EMjQc3pEt64TR+MncvddXPskqnCbOOrOg3eTb
         hdTDKilIZ+97+oa2hC4/KaJilt7TFoQ8aCrDTjQ01i/vWzGImgned04PVitiNckqoT
         yTEx42ceEZWUSbTfEVngu5HZfmvQYM/9dTijggUNikI0e+MpJXlfJGs5Vu+km2SIcB
         cAGnston0NJrF+KvT6ZjYWCiuq2m1Ntmyp4X2iCU/Z89WAqw9BrsRj7IkI/NrKi0pn
         qJcs9konCYJfA==
Message-ID: <4ec7af7e-d40e-dc83-63f8-44fa473f7035@collabora.com>
Date:   Tue, 29 Aug 2023 05:28:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v15 10/23] locking/refcount, kref: Add kref_put_ww_mutex()
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
References: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
 <20230827175449.1766701-11-dmitry.osipenko@collabora.com>
 <20230828112604.297db23a@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230828112604.297db23a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 12:26, Boris Brezillon wrote:
> On Sun, 27 Aug 2023 20:54:36 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> Introduce kref_put_ww_mutex() helper that will handle the wait-wound
>> mutex auto-locking on kref_put(). This helper is wanted by DRM drivers
>> that extensively use dma-reservation locking which in turns uses ww-mutex.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  include/linux/kref.h     | 12 ++++++++++++
>>  include/linux/refcount.h |  5 +++++
>>  lib/refcount.c           | 34 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 51 insertions(+)
>>
>> diff --git a/include/linux/kref.h b/include/linux/kref.h
>> index d32e21a2538c..b2d8dc6e9ae0 100644
>> --- a/include/linux/kref.h
>> +++ b/include/linux/kref.h
>> @@ -90,6 +90,18 @@ static inline int kref_put_lock(struct kref *kref,
>>  	return 0;
>>  }
>>  
>> +static inline int kref_put_ww_mutex(struct kref *kref,
>> +				    void (*release)(struct kref *kref),
>> +				    struct ww_mutex *lock,
>> +				    struct ww_acquire_ctx *ctx)
>> +{
>> +	if (refcount_dec_and_ww_mutex_lock(&kref->refcount, lock, ctx)) {
>> +		release(kref);
>> +		return 1;
>> +	}
>> +	return 0;
>> +}
>> +
>>  /**
>>   * kref_get_unless_zero - Increment refcount for object unless it is zero.
>>   * @kref: object.
>> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
>> index a62fcca97486..be9ad272bc77 100644
>> --- a/include/linux/refcount.h
>> +++ b/include/linux/refcount.h
>> @@ -99,6 +99,8 @@
>>  #include <linux/spinlock_types.h>
>>  
>>  struct mutex;
>> +struct ww_mutex;
>> +struct ww_acquire_ctx;
>>  
>>  /**
>>   * typedef refcount_t - variant of atomic_t specialized for reference counts
>> @@ -366,4 +368,7 @@ extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
>>  extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
>>  						       spinlock_t *lock,
>>  						       unsigned long *flags) __cond_acquires(lock);
>> +extern __must_check bool refcount_dec_and_ww_mutex_lock(refcount_t *r,
>> +							struct ww_mutex *lock,
>> +							struct ww_acquire_ctx *ctx) __cond_acquires(&lock->base);
>>  #endif /* _LINUX_REFCOUNT_H */
>> diff --git a/lib/refcount.c b/lib/refcount.c
>> index a207a8f22b3c..3f6fd0ceed02 100644
>> --- a/lib/refcount.c
>> +++ b/lib/refcount.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/mutex.h>
>>  #include <linux/refcount.h>
>>  #include <linux/spinlock.h>
>> +#include <linux/ww_mutex.h>
>>  #include <linux/bug.h>
>>  
>>  #define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
>> @@ -184,3 +185,36 @@ bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
>>  	return true;
>>  }
>>  EXPORT_SYMBOL(refcount_dec_and_lock_irqsave);
>> +
>> +/**
>> + * refcount_dec_and_ww_mutex_lock - return holding ww-mutex if able to
>> + *                                  decrement refcount to 0
>> + * @r: the refcount
>> + * @lock: the ww-mutex to be locked
>> + * @ctx: wait-wound context
>> + *
>> + * Similar to atomic_dec_and_lock(), it will WARN on underflow and fail to
>> + * decrement when saturated at REFCOUNT_SATURATED.
>> + *
>> + * Provides release memory ordering, such that prior loads and stores are done
>> + * before, and provides a control dependency such that free() must come after.
>> + * See the comment on top.
>> + *
>> + * Return: true and hold ww-mutex lock if able to decrement refcount to 0,
>> + *         false otherwise
>> + */
>> +bool refcount_dec_and_ww_mutex_lock(refcount_t *r, struct ww_mutex *lock,
>> +				    struct ww_acquire_ctx *ctx)
>> +{
>> +	if (refcount_dec_not_one(r))
>> +		return false;
>> +
>> +	ww_mutex_lock(lock, ctx);
> 
> Unless I'm wrong, ww_mutex_lock() can return -EDEADLK when ctx !=
> NULL, in which case, the lock is not held when it returns. Question is,
> do we really have a use case for ctx != NULL in that kref_put_ww_mutex()
> path. If we need to acquire other ww_locks, this lock, and the other
> locks should have been acquired beforehand, and we can simply call
> kref_put() when we want to release the ref on the resource.

Right, I completely forgot about the deadlocking

-- 
Best regards,
Dmitry

