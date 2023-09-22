Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F837AB015
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjIVK7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIVK7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:59:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6F9AF;
        Fri, 22 Sep 2023 03:59:01 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4050D6607298;
        Fri, 22 Sep 2023 11:59:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695380340;
        bh=U4C5cQtZcQUA0ntsm4nl33wSbsxoVynBlr2Tlu5UDy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvfWbikvgdoKQbUkrvqLw0U1sjfu3wnPVUCbTLp2hdcbWzKgS9nyfpa+Jn/8KR6Ya
         eT8dmGSWkNQ2d6qUvouxGZGcvSw6eIi+QVLEKUbqAfqT8SBkqeZ0BNMsfrkUihea5T
         IingQ9QSsI1epKGvyciQUR6HTQf/6IjzAM0PNC5FVW0xfpkuAcv0lPlR/FFzPYAh/A
         yQY4FQ/qnoH0PZXdD4X4LVf0g03plzju55E1Ftk0KucXC4OYpW6U8GVf+HZBsYwzWN
         n6XYS9FCmIpHgqiPkdh4E4/0LtBUm6iIFKSUFnOe19pphgBNxkInSy7PtzgWfrSrDn
         GxIQhYxRM5PXQ==
Date:   Fri, 22 Sep 2023 11:58:57 +0100
From:   =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        healych@amazon.com,
        Boris Brezillon <boris.brezillon@collabora.com>,
        kernel@collabora.com, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v6 4/6] drm/drm_file: Add DRM obj's RSS reporting
 function for fdinfo
Message-ID: <fs3u3b62vhixqpuoa5c4dwckew3l4etvps4zhlgeuwle6o2as2@tsgwsil4s35k>
References: <20230919233556.1458793-1-adrian.larumbe@collabora.com>
 <20230919233556.1458793-5-adrian.larumbe@collabora.com>
 <495203cd-d85e-2c00-4fa9-81879a882441@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <495203cd-d85e-2c00-4fa9-81879a882441@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.2023 16:53, Tvrtko Ursulin wrote:
>
>On 20/09/2023 00:34, Adrián Larumbe wrote:
>> Some BO's might be mapped onto physical memory chunkwise and on demand,
>> like Panfrost's tiler heap. In this case, even though the
>> drm_gem_shmem_object page array might already be allocated, only a very
>> small fraction of the BO is currently backed by system memory, but
>> drm_show_memory_stats will then proceed to add its entire virtual size to
>> the file's total resident size regardless.
>> 
>> This led to very unrealistic RSS sizes being reckoned for Panfrost, where
>> said tiler heap buffer is initially allocated with a virtual size of 128
>> MiB, but only a small part of it will eventually be backed by system memory
>> after successive GPU page faults.
>> 
>> Provide a new DRM object generic function that would allow drivers to
>> return a more accurate RSS size for their BOs.
>> 
>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>> Reviewed-by: Steven Price <steven.price@arm.com>
>> ---
>>   drivers/gpu/drm/drm_file.c | 5 ++++-
>>   include/drm/drm_gem.h      | 9 +++++++++
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
>> index 883d83bc0e3d..762965e3d503 100644
>> --- a/drivers/gpu/drm/drm_file.c
>> +++ b/drivers/gpu/drm/drm_file.c
>> @@ -944,7 +944,10 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
>>   		}
>>   		if (s & DRM_GEM_OBJECT_RESIDENT) {
>> -			status.resident += obj->size;
>> +			if (obj->funcs && obj->funcs->rss)
>> +				status.resident += obj->funcs->rss(obj);
>> +			else
>> +				status.resident += obj->size;
>
>Presumably you'd want the same smaller size in both active and purgeable? Or
>you can end up with more in those two than in rss which would look odd.

I didn't think of this. I guess when an object is both resident and purgeable,
then its RSS and purgeable sizes should be the same.

>Also, alternative to adding a new callback could be adding multiple output
>parameters to the existing obj->func->status() which maybe ends up simpler due
>fewer callbacks?
>
>Like:
>
> s = obj->funcs->status(obj, &supported_status, &rss)
>
>And adjust the code flow to pick up the rss if driver signaled it supports
>reporting it.

I personally find having a separate object callback more readable in this case.
There's also the question of what output parameter value would be used as a token
that the relevant BO doesn't have an RSS different from its virtual
size. I guess '0' would be alright, but this is on the assumption that this
could never be a legitimate BO virtual size across all DRM drivers. I guess
most of them round the size up to the nearest page multiple at BO creation
time.

>
>Regards,
>
>Tvrtko
>
>>   		} else {
>>   			/* If already purged or not yet backed by pages, don't
>>   			 * count it as purgeable:
>> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
>> index bc9f6aa2f3fe..16364487fde9 100644
>> --- a/include/drm/drm_gem.h
>> +++ b/include/drm/drm_gem.h
>> @@ -208,6 +208,15 @@ struct drm_gem_object_funcs {
>>   	 */
>>   	enum drm_gem_object_status (*status)(struct drm_gem_object *obj);
>> +	/**
>> +	 * @rss:
>> +	 *
>> +	 * Return resident size of the object in physical memory.
>> +	 *
>> +	 * Called by drm_show_memory_stats().
>> +	 */
>> +	size_t (*rss)(struct drm_gem_object *obj);
>> +
>>   	/**
>>   	 * @vm_ops:
>>   	 *
