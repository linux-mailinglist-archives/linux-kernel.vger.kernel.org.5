Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817837D2CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjJWIc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjJWIcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17678D6B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698049863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOnHu/HXv+/MexAzD91ndTElaP4qcEAtusLsQWzhRN8=;
        b=DNQUBabz36CAvYMTBzJAUI9AoGWrV13MsJUfsgo5Pv9MznbA9wvVwSuYaEeDUeqasdLHkB
        su4c4yIMQ0moO0vYFKIydGEshtBXoFxLIEWvNmRoJOzUyYRCja8DtRuU5zhXSDGFrcTJmR
        oPGPC/TMQU1Xn+/eSofJhSEKQm8N+qk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-6Zn4pOKYNLaIw1ZH9hr5oQ-1; Mon, 23 Oct 2023 04:31:01 -0400
X-MC-Unique: 6Zn4pOKYNLaIw1ZH9hr5oQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32d879cac50so1388872f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049860; x=1698654660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOnHu/HXv+/MexAzD91ndTElaP4qcEAtusLsQWzhRN8=;
        b=paJLiGtkdqatx+2JXGn5sxw6v+8VM1WRd9zdP7iYzbd8Dfhn1cdb9GPltLPQ7fF82j
         zC03LGl5Vx73yl+M2LWcx0bdtHXrCgbe0arnD1zCSL8Ua3XARAdqFV5/PAv1XoRlNxZu
         N8PoNsoBMfrMKsJdq85WjdUUMtKi4UGSsOucPRJMG3emGcCRoEzepdNErKckMvz/yH6Z
         Yu3gkvBCjvAF802HmVoH9CusPC/rFUchD9dd2RyLE7clvtwAOlkdThBP+G2ihb9Hm+mD
         Ho5NSWpCMaSk7jXwIK+C3npesY9lC+oA0yVpIXfrFb1Tn12Lb4htAbMW0IzSwZBNVDpb
         xwYw==
X-Gm-Message-State: AOJu0Yy5oBT0iDI5q2vXGSvPgrJ6vycdDdeDbZd+88dKai+HGJvJ+fSu
        tpHPAgsDl7XnwzQtCeEmw9g3+Pk/katGFPPh5WSBCUd+2TJ7w1mIXG/NWftSyrcqULGLL5iOypz
        e7bB32m3P5PQVsqGimwXtO1Qn
X-Received: by 2002:adf:ecc8:0:b0:31f:fa61:961d with SMTP id s8-20020adfecc8000000b0031ffa61961dmr5420239wro.63.1698049860239;
        Mon, 23 Oct 2023 01:31:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsM0QtK3+WXTL5mHWBFb49plfkG+D7naag8X+Y3CsdzRTvOrT+44se+2kfRdM5vRG4iQ0u0g==
X-Received: by 2002:adf:ecc8:0:b0:31f:fa61:961d with SMTP id s8-20020adfecc8000000b0031ffa61961dmr5420223wro.63.1698049859823;
        Mon, 23 Oct 2023 01:30:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:680e:9bf4:b6a9:959b? ([2a01:e0a:d5:a000:680e:9bf4:b6a9:959b])
        by smtp.gmail.com with ESMTPSA id f7-20020adff587000000b0031fb91f23e9sm7233075wro.43.2023.10.23.01.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 01:30:59 -0700 (PDT)
Message-ID: <74b367bd-ac80-478b-8f82-e98cb6e40475@redhat.com>
Date:   Mon, 23 Oct 2023 10:30:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mgag200: Flush the cache to improve latency
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, airlied@redhat.com,
        daniel@ffwll.ch
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231019135655.313759-1-jfalempe@redhat.com>
 <660c0260-0e22-4e9c-ab13-157adaa0b14d@suse.de>
Content-Language: en-US
From:   Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <660c0260-0e22-4e9c-ab13-157adaa0b14d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2023 14:06, Thomas Zimmermann wrote:
> (cc'ing lkml for feedback)
> 
> Hi Jocelyn
> 
> Am 19.10.23 um 15:55 schrieb Jocelyn Falempe:
>> We found a regression in v5.10 on real-time server, using the
>> rt-kernel and the mgag200 driver. It's some really specialized
>> workload, with <10us latency expectation on isolated core.
>> After the v5.10, the real time tasks missed their <10us latency
>> when something prints on the screen (fbcon or printk)
> 
> I'd like to hear the opinion of the RT-devs on this patch. Because AFAIK 
> we never did such a workaround in other drivers. And AFAIK printk is a 
> PITA anyway.

Most other drivers uses DMA, which means this workaround can't apply to 
them.

> 
> IMHO if that RT system cannot handle differences in framebuffer caching, 
> it's under-powered. It's just a matter of time until something else 
> changes and the problem returns. And (honest question) as it's an 
> x86-64, how do they handle System Management Mode?

I think it's not a big news, that the Matrox G200 from 1999 is 
under-powered.
I was also a bit surprised that flushing the cache would have such 
effect on latency. The tests we are doing can run 24h with the 
workaround, without any interrupt taking more than 10us. Without the 
workaround, every ~30s the interrupt failed its 10us target.

> 
>>
>> The regression has been bisected to 2 commits:
>> 0b34d58b6c32 ("drm/mgag200: Enable caching for SHMEM pages")
>> 4862ffaec523 ("drm/mgag200: Move vmap out of commit tail")
>>
>> The first one changed the system memory framebuffer from Write-Combine
>> to the default caching.
>> Before the second commit, the mgag200 driver used to unmap the
>> framebuffer after each frame, which implicitly does a cache flush.
>> Both regressions are fixed by the following patch, which forces a
>> cache flush after each frame, reverting to almost v5.9 behavior.
> 
> With that second commit, we essentially never unmap an active 
> framebuffer console. But with commit
> 
> 359c6649cd9a ("drm/gem: Implement shadow-plane {begin, end}_fb_access 
> with vmap")
> 
> we now again unmap the console framebuffer after the pageflip happened.
> 
> So how does the latest kernel behave wrt to the problem?

The regression was found when upgrading the server from v5.4 to v5.14, 
so we didn't test with later kernels.
We will test with v6.3 (which should have 359c6649cd9a ) and see what it 
gives.
> 
>> This is necessary only if you have strong realtime constraints, so I
>> put the cache flush under the CONFIG_PREEMPT_RT config flag.
>> Also clflush is only availabe on x86, (and this issue has only been
>> reproduced on x86_64) so it's also under the CONFIG_X86 config flag.
>>
>> Fixes: 0b34d58b6c32 ("drm/mgag200: Enable caching for SHMEM pages")
>> Fixes: 4862ffaec523 ("drm/mgag200: Move vmap out of commit tail")
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   drivers/gpu/drm/mgag200/mgag200_mode.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c 
>> b/drivers/gpu/drm/mgag200/mgag200_mode.c
>> index af3ce5a6a636..11660cd29cea 100644
>> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
>> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
>> @@ -13,6 +13,7 @@
>>   #include <drm/drm_atomic.h>
>>   #include <drm/drm_atomic_helper.h>
>> +#include <drm/drm_cache.h>
>>   #include <drm/drm_damage_helper.h>
>>   #include <drm/drm_format_helper.h>
>>   #include <drm/drm_fourcc.h>
>> @@ -436,6 +437,10 @@ static void mgag200_handle_damage(struct 
>> mga_device *mdev, const struct iosys_ma
>>       iosys_map_incr(&dst, drm_fb_clip_offset(fb->pitches[0], 
>> fb->format, clip));
>>       drm_fb_memcpy(&dst, fb->pitches, vmap, fb, clip);
>> +    /* On RT systems, flushing the cache reduces the latency for 
>> other RT tasks */
>> +#if defined(CONFIG_X86) && defined(CONFIG_PREEMPT_RT)
>> +    drm_clflush_virt_range(vmap, fb->height * fb->pitches[0]);
>> +#endif
> 
> Your second commit is part of a larger patchset that updates several 
> drivers. They might all be affected. So if anything, the patch should go 
> here before the unmap call:
> 
> https://elixir.bootlin.com/linux/v6.5/source/drivers/gpu/drm/drm_gem_atomic_helper.c#L377
> 
The regression was found only with G200 currently, so I don't want to 
apply it blindly on other drivers.

Thanks for your help,

Best regards,

-- 

Jocelyn

> with a much expanded comment.
> 
> But I'd really like to hear other peoples' opinions on the matter.
> 
> Best regards
> Thomas
> 
>>   }
>>   /*
>>
>> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> 

