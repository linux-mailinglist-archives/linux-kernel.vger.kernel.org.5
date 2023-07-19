Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA71A759E06
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjGSS6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjGSS6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:58:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DEA1FC8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:58:33 -0700 (PDT)
Received: from [192.168.2.126] (109-252-154-2.dynamic.spd-mgts.ru [109.252.154.2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 741D16607050;
        Wed, 19 Jul 2023 19:58:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689793112;
        bh=TGv8e/l9mvStXaorCqqEd0PI/jyLliAA3UPEWTX1zOQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QMOeHeeq581u0o/Yojl7ZQXaaSpfb+YSkQDIJm7JB1gQBXriCBCQ3mOgUNTGc5CjO
         9EiaZLo3u5PTyFjPjs/jYOBj0WO54mAhCdD7mQCVvDy0ZUxUqFNQJx1uezHjoqLpSe
         +SvrpOuuSSZVl632BV6+Qtrj39yFOcsOttrd51MBQtBn5dXNzv6MBWRF6fIt5AQrLC
         n1kpPFcxRAdWjpYBNKCPZoh+A34ShjsUKT/4sQRUMQxjV4/u5/4st6bnFt23geL4W7
         ZggrLuc5zlm2kCmqU+Db2gp41LwdkvlwBhjvbxshPr9M+FIxwHOMgY5mI4Mfw19E8v
         LrVTlCnM6Qetg==
Message-ID: <259ffa89-39d9-5c00-c70c-0cb26a6aab65@collabora.com>
Date:   Wed, 19 Jul 2023 21:58:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v6 3/3] drm/virtio: Support sync objects
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <20230416115237.798604-4-dmitry.osipenko@collabora.com>
 <CAMuHMdVrJsmQx8X-_Tnxir9W752Mdh8ye7ob2srtY+6HFDEMGw@mail.gmail.com>
 <0ca8034d-0377-26b9-51c8-8caff6c4174a@collabora.com>
 <CAMuHMdWfE=6xFsYFv=mCACpwZp45AiCzFxEB=suEFBhv9ry5aw@mail.gmail.com>
 <2f4d3e96-1e10-3662-bfc5-8c361a4c1366@collabora.com>
 <CAMuHMdV924gJs1X1nMUbQ5LEbFe8hrrXgxxvgZ_dXf95O0bK5Q@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAMuHMdV924gJs1X1nMUbQ5LEbFe8hrrXgxxvgZ_dXf95O0bK5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

27.06.2023 15:01, Geert Uytterhoeven пишет:
> Hi Dmitry,
> 
> On Mon, Jun 26, 2023 at 6:11 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>> On 6/25/23 18:36, Geert Uytterhoeven wrote:
>>> On Sun, Jun 25, 2023 at 2:41 PM Dmitry Osipenko
>>> <dmitry.osipenko@collabora.com> wrote:
>>>> On 6/25/23 11:47, Geert Uytterhoeven wrote:
>>>>> On Sun, Apr 16, 2023 at 1:55 PM Dmitry Osipenko
>>>>> <dmitry.osipenko@collabora.com> wrote:
>>>>>> Add sync object DRM UAPI support to VirtIO-GPU driver. Sync objects
>>>>>> support is needed by native context VirtIO-GPU Mesa drivers, it also will
>>>>>> be used by Venus and Virgl contexts.
>>>>>>
>>>>>> Reviewed-by; Emil Velikov <emil.velikov@collabora.com>
>>>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>>>
>>>>> Thanks for your patch!
>>>>>
>>>>>> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
>>>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
>>>>>
>>>>>> +static int
>>>>>> +virtio_gpu_parse_deps(struct virtio_gpu_submit *submit)
>>>>>> +{
>>>>>> +       struct drm_virtgpu_execbuffer *exbuf = submit->exbuf;
>>>>>> +       struct drm_virtgpu_execbuffer_syncobj syncobj_desc;
>>>>>> +       size_t syncobj_stride = exbuf->syncobj_stride;
>>>>>> +       u32 num_in_syncobjs = exbuf->num_in_syncobjs;
>>>>>> +       struct drm_syncobj **syncobjs;
>>>>>> +       int ret = 0, i;
>>>>>> +
>>>>>> +       if (!num_in_syncobjs)
>>>>>> +               return 0;
>>>>>> +
>>>>>> +       /*
>>>>>> +        * kvalloc at first tries to allocate memory using kmalloc and
>>>>>> +        * falls back to vmalloc only on failure. It also uses GFP_NOWARN
>>>>>
>>>>> GFP_NOWARN does not exist.
>>>>
>>>> https://elixir.bootlin.com/linux/v6.4-rc7/source/include/linux/gfp_types.h#L38
>>>
>>> That line defines "__GFP_NOWARN", not "GFP_NOWARN".
>>> C is case- and underscore-sensitive. as is "git grep -w" ;-)
>>
>> The removal of underscores was done intentionally for improving
>> readability of the comment
> 
> Please don't do that, as IMHO it actually hampers readability:
>   1. For some xxx, both GFP_xxx and __GFP_xxx are defined,
>      so it does matter which one you are referring to,
>   2. After dropping the underscores, "git grep -w" can no longer find
>      the definition, nor its users.
> 
> Thanks!

Alright, I'll change it

-- 
Best regards,
Dmitry

