Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EE97F1234
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjKTLiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjKTLiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:38:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F779D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:38:05 -0800 (PST)
Received: from [10.3.2.161] (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 359F96602F1D;
        Mon, 20 Nov 2023 11:38:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700480284;
        bh=lX9d/Us0h3a8J02mdLie/YqRrpifDkBDv3KBw5ibIks=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=chJFgsWQJyiQmfayqPlZ/ywdBeuH/DLNWFm9e+lVYjoPy31JHLrAFwQkqgLrm4MKX
         TKOAq+/8SPGa0jMFfX2Wfn05kUMuCE81IH5j0kWlVBjIDbBB08LQub3NrbLMXYAvU3
         mW7Q/Hme2Utumxsb4KUPawimjE9/8o4BTIVxwnkatOEQQfQ6Y/uZSlR+0kP1MySz38
         jlmwiCSQLA3nLUpg8acg8wBYqxRxS5NLPvwMNMPEjieCzJh78Giapyo24mBtYyv2eT
         rQGfliib8CnQQEkoolLnEoU8zPOV+n5TZkytqmh3rIW4nWZocO7eOZUEXXrgzd8d9O
         X2MoeZ71QhnIw==
Message-ID: <97c673e2-66ee-80de-3ad7-d8f02a56a3f6@collabora.com>
Date:   Mon, 20 Nov 2023 14:38:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v18 11/26] drm/shmem-helper: Prepare drm_gem_shmem_free()
 to shrinker addition
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
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
 <20231029230205.93277-12-dmitry.osipenko@collabora.com>
 <20231110111601.5d6bd1ab@collabora.com>
 <bd2308d6-38e5-6042-3da8-fb436f67a88e@collabora.com>
 <20231120121942.4eef9e03@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20231120121942.4eef9e03@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/23 14:19, Boris Brezillon wrote:
...
>>>> -		dma_resv_lock(shmem->base.resv, NULL);
>>>> -
>>>>  		drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
>>>>  
>>>>  		if (shmem->sgt) {
>>>> @@ -157,8 +171,6 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>>>>    
>>> If you drop the dma_resv_lock/unlock(), you should also replace the
>>> drm_gem_shmem_put_pages_locked() by a drm_gem_shmem_free_pages() in this
>>> commit.  
>>
>> drm_gem_shmem_put_pages_locked() is exported by a later patch of this
>> series, it's not worthwhile to remove this function
> 
> I'm not talking about removing drm_gem_shmem_put_pages_locked(), but
> replacing the drm_gem_shmem_put_pages_locked() call you have in
> drm_gem_shmem_free() by a drm_gem_shmem_free_pages(), so you don't end
> up with a lockdep warning when you stop exactly here in the patch
> series, which is important if we want to keep things bisectable.

Indeed, there is assert_locked() there. Thanks for the clarification :)

-- 
Best regards,
Dmitry

