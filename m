Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920C27AE2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjIZAas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIZAar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:30:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E1B10A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:30:41 -0700 (PDT)
Received: from [192.168.2.47] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 78C9C6607243;
        Tue, 26 Sep 2023 01:30:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695688239;
        bh=mcSnwfi+AXEs19IZ43nY6DvON7iYOy/W6ZlsG/AihDw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oPThoU46lcTW8Wl1lrN3e9b8DxC5nN4z1FyzkgPvTTZmV7tDMXwHbDFk8Hyw8sZQo
         yz9R2X+kV4hym8IRTHfIlEzSFtPm2y5j4e0wGI5AEtdxgTrEwKUJU2VmSIeCxcDzHC
         qwbAo7s3HrDrmUtqPQ2L+yfoSPeo9NK9mHD/FFbmf/m6d1WSfKP4KyDs4+6EeclVkz
         oLgoYz3Xa2Mb3L8HjLnK6kRAF6OIjjblgP6XpPxzvhJeJLawdJvm1feuFPecHEGUG6
         O7fwIm3WuSy8qqz2DLn8fhV6YF2fDa66oSrnqK92jBBGX+bVl4tefytmaiCX+oRjVK
         EFa/PfMxREknw==
Message-ID: <454c464e-4534-7ec3-6d38-49b7df83c7be@collabora.com>
Date:   Tue, 26 Sep 2023 03:30:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v17 13/18] drm/shmem-helper: Add memory shrinker
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
References: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
 <20230914232721.408581-14-dmitry.osipenko@collabora.com>
 <20230915104633.0d5c3932@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230915104633.0d5c3932@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/23 11:46, Boris Brezillon wrote:
> The naming becomes quite confusing, with drm_gem_shmem_unpin_locked()
> and drm_gem_shmem_unpin_pages_locked(). By the look of it, it seems to
> do exactly the opposite of drm_gem_shmem_swapin_locked(), except for
> the missing ->evicted = true, which we can move here anyway, given
> drm_gem_shmem_purge_locked() explicitly set it to false anyway. The
> other thing that's missing is the
> drm_gem_shmem_update_pages_state_locked(), but it can also be moved
> there I think, if the the ->madv update happens before the
> drm_gem_shmem_unpin_pages_locked() call in
> drm_gem_shmem_purge_locked().
> 
> So, how about renaming this function drm_gem_shmem_swapout_locked()?

The swapout name would be misleading to me because pages aren't moved to
swap, but allowed to be moved. I'll rename it to
drm_gem_shmem_shrinker_unpin_locked().

>>  {
>>  	struct drm_gem_object *obj = &shmem->base;
>>  	struct drm_device *dev = obj->dev;
>>  
>>  	dma_resv_assert_held(shmem->base.resv);
>>  
>> -	drm_WARN_ON(obj->dev, !drm_gem_shmem_is_purgeable(shmem));
>> +	if (shmem->evicted)
>> +		return;
>>  
>>  	dma_unmap_sgtable(dev->dev, shmem->sgt, DMA_BIDIRECTIONAL, 0);
> Are we sure we'll always have sgt != NULL? IIRC, if the GEM is only
> mmap-ed in userspace, get_sgt() is not necessarily called by the driver
> (needed to map in GPU space), and we have a potential NULL deref here.
> Maybe that changed at some point in the series, and sgt is
> unconditionally populated when get_pages() is called now.

The sgt is always set in this function because it's part of shrinker and
shrinker doesn't touch GEMs without sgt.

>> +	__drm_gem_shmem_release_pages(shmem);
> Make sure you drop the implicit pages_use_count ref the sgt had, this
> way you can still tie the necessity to drop the pages to sgt != NULL in
> drm_gem_shmem_free().

This will require further refcnt re-initialization when pages are
restored if it's dropped to zero. I don't see how this will improve
anything.

-- 
Best regards,
Dmitry

