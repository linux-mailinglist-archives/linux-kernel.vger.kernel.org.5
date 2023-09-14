Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D386F79F945
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjINEDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjINEDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:03:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C270E6C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:02:58 -0700 (PDT)
Received: from [192.168.2.134] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8B2C46607326;
        Thu, 14 Sep 2023 05:02:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694664175;
        bh=XNbZvDNPElbhAVe9CVrAb1FFndRQKl4kGYWIY9PJnVE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g1jdrQkYXRLrocVXUWPIylg1LMihLjE3ojWdlAwpK60zyHWOZPap+U0EQn4jMNjm1
         S/XQ7xRi7W2kFJhAfMUxpe/HHGKTRLbIT/xmLYJroouiSMGha1IqDeuTO2XDsaSrmq
         etfqJHhcmE4n9/yfr6B9mFjTRG0aaHsP6kZGvA/tnMOQBCqEw8C0DYfKiSPWXlZ2FE
         xlzS4jxYvZl32ffvAxz8WsP73OEnaNEQnj0TDp+nK4BBnYEU/xMgZ2sWbIhqki0RfB
         zD8+7Gyx35ydMcGwMD9kCtxIyf+Tu1sNc2YS4yE9LlNy0tJij60X5c5sNeYfsvlEEG
         QY5AGcQ3gmbGw==
Message-ID: <aa270715-89ae-2aac-e2e3-018c21e1ff0e@collabora.com>
Date:   Thu, 14 Sep 2023 07:02:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v16 15/20] drm/shmem-helper: Add memory shrinker
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
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230913094832.3317c2df@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 10:48, Boris Brezillon wrote:
> On Wed, 13 Sep 2023 03:56:14 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> On 9/5/23 11:03, Boris Brezillon wrote:
>>>>                * But
>>>> +		 * acquiring the obj lock in drm_gem_shmem_release_pages_locked() can
>>>> +		 * cause a locking order inversion between reservation_ww_class_mutex
>>>> +		 * and fs_reclaim.
>>>> +		 *
>>>> +		 * This deadlock is not actually possible, because no one should
>>>> +		 * be already holding the lock when drm_gem_shmem_free() is called.
>>>> +		 * Unfortunately lockdep is not aware of this detail.  So when the
>>>> +		 * refcount drops to zero, don't touch the reservation lock.
>>>> +		 */
>>>> +		if (shmem->got_pages_sgt &&
>>>> +		    refcount_dec_and_test(&shmem->pages_use_count)) {
>>>> +			drm_gem_shmem_do_release_pages_locked(shmem);
>>>> +			shmem->got_pages_sgt = false;
>>>>  		}  
>>> Leaking memory is the right thing to do if pages_use_count > 1 (it's
>>> better to leak than having someone access memory it no longer owns), but
>>> I think it's worth mentioning in the above comment.  
>>
>> It's unlikely that it will be only a leak without a following up
>> use-after-free. Neither is acceptable.
> 
> Not necessarily, if you have a page leak, it could be that the GPU has
> access to those pages, but doesn't need the GEM object anymore
> (pages are mapped by the iommu, which doesn't need shmem->sgt or
> shmem->pages after the mapping is created). Without a WARN_ON(), this
> can go unnoticed and lead to memory corruptions/information leaks.
> 
>>
>> The drm_gem_shmem_free() could be changed such that kernel won't blow up
>> on a refcnt bug, but that's not worthwhile doing because drivers
>> shouldn't have silly bugs.
> 
> We definitely don't want to fix that, but we want to complain loudly
> (WARN_ON()), and make sure the risk is limited (preventing memory from
> being re-assigned to someone else by not freeing it).

That's what the code did and continues to do here. Not exactly sure what
you're trying to say. I'm going to relocate the comment in v17 to
put_pages(), we can continue discussing it there if I'm missing yours point.

-- 
Best regards,
Dmitry

