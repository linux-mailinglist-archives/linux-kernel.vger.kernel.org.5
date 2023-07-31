Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE1576964C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjGaM2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjGaM20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:28:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD2819A6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:28:03 -0700 (PDT)
Received: from [192.168.2.174] (109-252-150-127.dynamic.spd-mgts.ru [109.252.150.127])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CA89666020AE;
        Mon, 31 Jul 2023 13:27:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690806456;
        bh=t+kNYnRp3JEhtRu3dv/EMffqWCWXTjQlm8JAtUsnSlM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kkjTv2by5suJcB3axLiTbVi3kI0kXtHBEYujiRVXo2butVE3i6rgt5aDFhldO4kFO
         46lQhNIa3g762H7hnJliI5g7bhudEfjySh66SsOYXp9N3X5pPTQWycMZkiGe1qVyDA
         I+Y+xW2zs0qWP+VdYgZQ0I17Md9tWp1TO18GvgioAuf7DwEOEEO8xYVH0WH1mECbPn
         OgrjJ2YSzOhgVf+JnJfHN+l6p6BcX+IkrKfdM9it6o+nOFdxSl1yIua5/YJtp+pths
         mxf+EJtBVHxK/R0qE5rwqsjXcLq/MBb3UEKip7EC3vsLppqOjxi/RlJYzo+1WLEDsR
         uzfU8t+dBOYbA==
Message-ID: <4c5fa735-9bfd-f92a-8deb-888c7368f89e@collabora.com>
Date:   Mon, 31 Jul 2023 15:27:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v14 02/12] drm/shmem-helper: Add pages_pin_count field
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
References: <20230722234746.205949-1-dmitry.osipenko@collabora.com>
 <20230722234746.205949-3-dmitry.osipenko@collabora.com>
 <20230725092709.51356f39@collabora.com>
 <20230725103234.0c8923f1@collabora.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230725103234.0c8923f1@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 11:32, Boris Brezillon wrote:
>> Can we make it an atomic_t, so we can avoid taking the lock when the
>> GEM has already been pinned. That's something I need to be able to grab
>> a pin-ref in a path where the GEM resv lock is already held[1]. We could
>> of course expose the locked version,
> My bad, that's actually not true. The problem is not that I call
> drm_gem_shmem_pin() with the resv lock already held, but that I call
> drm_gem_shmem_pin() in a dma-signaling path where I'm not allowed to
> take a resv lock. I know for sure pin_count > 0, because all GEM objects
> mapped to a VM have their memory pinned right now, and this should
> stand until we decide to add support for live-GEM eviction, at which
> point we'll probably have a way to detect when a GEM is evicted, and
> avoid calling drm_gem_shmem_pin() on it.
> 
> TLDR; I can't trade the atomic_t for a drm_gem_shmem_pin_locked(),
> because that wouldn't solve my problem. The other solution would be to
> add an atomic_t at the driver-GEM level, and only call
> drm_gem_shmem_[un]pin() on 0 <-> 1 transitions, but I thought using an
> atomic at the GEM-shmem level, to avoid locking when we can, would be
> beneficial to the rest of the eco-system. Let me know if that's not an
> option, and I'll go back to the driver-specific atomic_t.

Could you please explain why do you need to pin GEM in a signal handler?
This is not something drivers usually do or need to do. You likely also
shouldn't need to detect that GEM is evicted in yours driver. I'd expect
that Panthor shouldn't differ from Panfrost in regards to how GEM memory
management is done and Panfrost doesn't need to do anything special.

Note that patch #14 makes locked pin/unpin functions public and turns
the unlocked variants into helpers, you'll be able to experiment with
these funcs in the Panthor driver.

In general, using atomic_t or kref should be a good thing to do, but
AFAICS it shouldn't bring benefits to the today's drm-shmem users. I'd
want to understand what you're trying to achieve in the Panthor driver.

-- 
Best regards,
Dmitry

