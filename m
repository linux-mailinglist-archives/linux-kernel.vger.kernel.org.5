Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580707A06AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbjINN6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbjINN6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:58:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0256D1FE3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:58:30 -0700 (PDT)
Received: from [192.168.2.134] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 01526660734C;
        Thu, 14 Sep 2023 14:58:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694699908;
        bh=jcYgiNYDQgTGOz7TyRg7l2L0dMvPwLYHvzC/iAYAtps=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D3OAn0OALbAwFVVXtPSYz++8yrjIm8JC8s5blReToB0K5ykSEEuOHAun2UpOi/6Wu
         C23lL5DBGo9S+gssVAMZZMtQtkOmtkS/qisqCRSS/Zw0j18AzBydL82YsT6gb9UMRX
         BSYuCjgy9vQFcpmHSvP5TMbp3d1AdutPw8N045rlXmGjm0ExVAiDGRUpkfUXblh3y/
         rVOQThiVhXOJaGjG7SQET20T1cfFBfhc85Nv5Uul10yNQpyIHpIlSJHCOUJBksTfc7
         ByDptNqb676YG0L6HeFsA8yUNwgsXrO7veAAF+bxL2C0UzUpCxVABHvTFkRk59MZow
         vWlDdlWnG2SPQ==
Message-ID: <03f6df22-8a5f-5996-63e6-50ec0847f690@collabora.com>
Date:   Thu, 14 Sep 2023 16:58:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v16 15/20] drm/shmem-helper: Add memory shrinker
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
References: <20230903170736.513347-1-dmitry.osipenko@collabora.com>
 <20230903170736.513347-16-dmitry.osipenko@collabora.com>
 <20230905100306.3564e729@collabora.com>
 <26f7ba6d-3520-0311-35e2-ef5706a98232@collabora.com>
 <20230913094832.3317c2df@collabora.com>
 <aa270715-89ae-2aac-e2e3-018c21e1ff0e@collabora.com>
 <20230914093626.19692c24@collabora.com>
 <21dda0bd-4264-b480-dbbc-29a7744bc96c@collabora.com>
 <20230914102737.08e61498@collabora.com>
 <a89cc9c1-5054-e45f-edec-819fdbfef2b5@collabora.com>
 <20230914135840.5e0e11fe@collabora.com>
 <ca7e905b-2809-fce4-1b56-7909efb1a229@collabora.com>
 <20230914152703.78b1ac82@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230914152703.78b1ac82@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 16:27, Boris Brezillon wrote:
...
> If you added this pages_use_count > 0 check to deal with the
> 'free-partially-imported-GEM' case, I keep thinking this is not
> the right fix. You should just assume that obj->import_attach == NULL
> means not-a-prime-buffer, and then make sure
> partially-initialized-prime-GEMs have import_attach assigned (see the
> oneliner I suggested in my review of
> `[PATCH v15 01/23] drm/shmem-helper: Fix UAF in error path when
> freeing SGT of imported GEM`).

Yes, I added it to deal with the partially imported GEM. The
obj->import_attach can't be set until dma-buf is fully imported as it
also will cause trouble for the error code path, now dma-buf will be
freed two times.

>> 			dma_unmap_sgtable(obj->dev->dev, shmem->sgt,
>> 					  DMA_BIDIRECTIONAL, 0);
>> 			sg_free_table(shmem->sgt);
>> 			kfree(shmem->sgt);
>>
>> 			__drm_gem_shmem_put_pages(shmem);
> You need to decrement pages_use_count:
> 
> 			/* shmem->pages_use_count should be 1 when ->sgt != NULL and
> 			 * zero otherwise. If some users still hold a pages reference
> 			 * that's a bug, and we intentionally leak the pages so they
> 			 * can't be re-allocated to someone else while the GPU/CPU
> 			 * still have access to it.
> 		 	 */
> 			if (refcount_dec_and_test(&shmem->pages_use_count))
> 				__drm_gem_shmem_put_pages(shmem);
> 

The put_pages() itself decrements the refcnt.

I'm going back to deferring all this questionable changes for the later
times. It is not essential problem for this patchset.

-- 
Best regards,
Dmitry

