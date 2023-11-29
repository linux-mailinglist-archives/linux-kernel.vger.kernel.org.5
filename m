Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B73B7FD4A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjK2Kr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjK2KrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:47:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38139DC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:47:29 -0800 (PST)
Received: from [10.3.2.161] (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 082296602021;
        Wed, 29 Nov 2023 10:47:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701254847;
        bh=G7oY6lpVSeNxefRPC0Bb+0Q6Gm15NLlalNVXTAW9g3Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=muQA55Nb63Lw1xMy0n+wARPHfzfkseDjZ/SYcT8VHWQpT6hAkgfmg5Uq6PAhoj6rm
         tEq5CNDfNwDrgqICY6HGRGA6WfWPD2OXXLnlrp2SCaBp1cbNjF9F33TZKGmzKC0k/s
         qsDvk5aOOwhcytZkDxrpsgxX3YfFOvfoYKC7h022bP8ne2dkGeinUjsYDzRGwWn6az
         pVq/RvwgccPG4sJvo8myCO4ZLmcr/Brh6HolrVkA9Pj/k6aFR7kkhko0FWWKmGwJ6G
         1MyZctnnGIqXCb0rewiNgwBn4Lv223tp605BL8/HlVGLqXt+QNt4ZC1EVzVQ5pz0QF
         IsKE+C0PKXabw==
Message-ID: <bcc8013d-d107-934f-71fa-98ab2e0275ee@collabora.com>
Date:   Wed, 29 Nov 2023 13:47:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v18 04/26] drm/shmem-helper: Refactor locked/unlocked
 functions
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
 <20231029230205.93277-5-dmitry.osipenko@collabora.com>
 <wboljiwogeus7pwgaqzxaltt3xdavy2dzisygn6pdpoiwlnwgc@mwaiukjguzat>
 <20231124115911.79ab24af@collabora.com>
 <kw5bho3jx73d3glvtewmjvqt4qty4khju6dcwypuh25ya3gi4b@7slmijjqdi4p>
 <20231128133712.53a6f6cb@collabora.com>
 <37208c72-7908-0a78-fc89-2fa9b8d756a5@collabora.com>
 <20231129085330.7ccb35d3@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20231129085330.7ccb35d3@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 10:53, Boris Brezillon wrote:
> On Wed, 29 Nov 2023 01:05:14 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> On 11/28/23 15:37, Boris Brezillon wrote:
>>> On Tue, 28 Nov 2023 12:14:42 +0100
>>> Maxime Ripard <mripard@kernel.org> wrote:
>>>   
>>>> Hi,
>>>>
>>>> On Fri, Nov 24, 2023 at 11:59:11AM +0100, Boris Brezillon wrote:  
>>>>> On Fri, 24 Nov 2023 11:40:06 +0100
>>>>> Maxime Ripard <mripard@kernel.org> wrote:
>>>>>     
>>>>>> On Mon, Oct 30, 2023 at 02:01:43AM +0300, Dmitry Osipenko wrote:    
>>>>>>> Add locked and remove unlocked postfixes from drm-shmem function names,
>>>>>>> making names consistent with the drm/gem core code.
>>>>>>>
>>>>>>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>>>>>>> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
>>>>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>      
>>>>>>
>>>>>> This contradicts my earlier ack on a patch but...
>>>>>>     
>>>>>>> ---
>>>>>>>  drivers/gpu/drm/drm_gem_shmem_helper.c        | 64 +++++++++----------
>>>>>>>  drivers/gpu/drm/lima/lima_gem.c               |  8 +--
>>>>>>>  drivers/gpu/drm/panfrost/panfrost_drv.c       |  2 +-
>>>>>>>  drivers/gpu/drm/panfrost/panfrost_gem.c       |  6 +-
>>>>>>>  .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |  2 +-
>>>>>>>  drivers/gpu/drm/panfrost/panfrost_mmu.c       |  2 +-
>>>>>>>  drivers/gpu/drm/v3d/v3d_bo.c                  |  4 +-
>>>>>>>  drivers/gpu/drm/virtio/virtgpu_object.c       |  4 +-
>>>>>>>  include/drm/drm_gem_shmem_helper.h            | 36 +++++------
>>>>>>>  9 files changed, 64 insertions(+), 64 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>>>>>> index 0d61f2b3e213..154585ddae08 100644
>>>>>>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>>>>>>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>>>>>> @@ -43,8 +43,8 @@ static const struct drm_gem_object_funcs drm_gem_shmem_funcs = {
>>>>>>>  	.pin = drm_gem_shmem_object_pin,
>>>>>>>  	.unpin = drm_gem_shmem_object_unpin,
>>>>>>>  	.get_sg_table = drm_gem_shmem_object_get_sg_table,
>>>>>>> -	.vmap = drm_gem_shmem_object_vmap,
>>>>>>> -	.vunmap = drm_gem_shmem_object_vunmap,
>>>>>>> +	.vmap = drm_gem_shmem_object_vmap_locked,
>>>>>>> +	.vunmap = drm_gem_shmem_object_vunmap_locked,      
>>>>>>
>>>>>> While I think we should indeed be consistent with the names, I would
>>>>>> also expect helpers to get the locking right by default.    
>>>>>
>>>>> Wait, actually I think this patch does what you suggest already. The
>>>>> _locked() prefix tells the caller: "you should take care of the locking,
>>>>> I expect the lock to be held when this is hook/function is called". So
>>>>> helpers without the _locked() prefix take care of the locking (which I
>>>>> guess matches your 'helpers get the locking right' expectation), and
>>>>> those with the _locked() prefix don't.    
>>>>
>>>> What I meant by "getting the locking right" is indeed a bit ambiguous,
>>>> sorry. What I'm trying to say I guess is that, in this particular case,
>>>> I don't think you can expect the vmap implementation to be called with
>>>> or without the locks held. The doc for that function will say that it's
>>>> either one or the other, but not both.
>>>>
>>>> So helpers should follow what is needed to provide a default vmap/vunmap
>>>> implementation, including what locking is expected from a vmap/vunmap
>>>> implementation.  
>>>
>>> Hm, yeah, I think that's a matter of taste. When locking is often
>>> deferrable, like it is in DRM, I find it beneficial for funcions and
>>> function pointers to reflect the locking scheme, rather than relying on
>>> people properly reading the doc, especially when this is the only
>>> outlier in the group of drm_gem_object_funcs we already have, and it's
>>> not event documented at the drm_gem_object_funcs level [1] :P.
>>>   
>>>>
>>>> If that means that vmap is always called with the locks taken, then
>>>> drm_gem_shmem_object_vmap can just assume that it will be called with
>>>> the locks taken and there's no need to mention it in the name (and you
>>>> can probably sprinkle a couple of lockdep assertion to make sure the
>>>> locking is indeed consistent).  
>>>
>>> Things get very confusing when you end up having drm_gem_shmem helpers
>>> that are suffixed with _locked() to encode the fact locking is the
>>> caller's responsibility and no suffix for the
>>> callee-takes-care-of-the-locking semantics, while other helpers that are
>>> not suffixed at all actually implement the
>>> caller-should-take-care-of-the-locking semantics.
>>>   
>>>>  
>>>>>> I'm not sure how reasonable it is, but I think I'd prefer to turn this
>>>>>> around and keep the drm_gem_shmem_object_vmap/unmap helpers name, and
>>>>>> convert whatever function needs to be converted to the unlock suffix so
>>>>>> we get a consistent naming.    
>>>>>
>>>>> That would be an _unlocked() prefix if we do it the other way around. I
>>>>> think the main confusion comes from the names of the hooks in
>>>>> drm_gem_shmem_funcs. Some of them, like drm_gem_shmem_funcs::v[un]map()
>>>>> are called with the GEM resv lock held, and locking is handled by the
>>>>> core, others, like drm_gem_shmem_funcs::[un]pin() are called
>>>>> without the GEM resv lock held, and locking is deferred to the
>>>>> implementation. As I said, I don't mind prefixing hooks/helpers with
>>>>> _unlocked() for those that take care of the locking, and no prefix for
>>>>> those that expects locks to be held, as long as it's consistent, but I
>>>>> just wanted to make sure we're on the same page :-).    
>>>>
>>>> What about _nolock then? It's the same number of characters than
>>>> _locked, plus it expresses what the function is (not) doing, not what
>>>> context it's supposed to be called in?  
>>>
>>> Just did a quick
>>>
>>>   git grep _nolock drivers/gpu/drm
>>>
>>> and it returns zero result, where the _locked/_unlocked pattern seems
>>> to already be widely used. Not saying we shouldn't change that, but it
>>> doesn't feel like a change we should do as part of this series.
>>>
>>> Regards,
>>>
>>> Boris
>>>
>>> [1]https://elixir.bootlin.com/linux/v6.7-rc3/source/include/drm/drm_gem.h#L155  
>>
>> I'm fine with dropping the _locked() postfix from the common GEM helpers
>> and documenting the locking rule in drm_gem. Thank you all for the
>> suggestions :)
> 
> Sorry to disagree, but I think a proper function name/suffix is
> sometimes worth a few lines of doc. Not saying we should do one or the
> other, I think we should do both. But when I see a function suffixed
> _locked, _unlocked or _nolock, I can immediately tell if this function
> defers the locking to the caller or not, and then go check which lock
> in the function doc.
> 
> And the second thing I'm not happy with, is the fact we go back to an
> inconsistent naming in drm_gem_shmem_helper.c, where some functions
> deferring the locking to the caller are suffixed _locked and others are
> not, because ultimately, you need a different name when you expose the
> two variants...

By the `common GEM helpers` I meant the .vmap drm-shmem common helpers
used for drm_gem_object_funcs, like was suggested by Maxime. The rest of
functions will retain the _locked part. Sorry for the confusion :)

-- 
Best regards,
Dmitry

