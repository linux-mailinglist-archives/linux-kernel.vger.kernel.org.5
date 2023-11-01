Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA137DE54B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344690AbjKARYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKARY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20959A6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698859420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXewshFpfkGDn8j5Fh6rL3ELP7XseQ2PaUs6p1ijoKo=;
        b=S6Ppfu/w1n1L35jmHSSFP3rFlk44i5pAJQRmNhCcOfhks+ZM5T/IJsKOHJmRaxipCBZcBa
        whC/2Um1AYqFChTTcQO03IHfrrUF0tsmSqhLauFgnrdH8YTXSMBOKiXATMAuwY73Zb/iS4
        wQF/EuQ1WLSynfriFTkKP9Bp+NBgptY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-mzR0DvhSPLmqf-93FBXFYw-1; Wed, 01 Nov 2023 13:23:39 -0400
X-MC-Unique: mzR0DvhSPLmqf-93FBXFYw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507d0e4eedaso7921253e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 10:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698859417; x=1699464217;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXewshFpfkGDn8j5Fh6rL3ELP7XseQ2PaUs6p1ijoKo=;
        b=METnJdRXXLPHAtJKPrGIhOOD0Uapq9uGYceMy1fqV2glnge3egusXmXvidC/Z7Vb3S
         DgcURx1eEbpxc7bEvPFegcg5jc8Jehq8lvys5eVEsOCWDHkSLCHKL+B2d3+qJQHRt91v
         +6OP5jcuyyP2EfDmGSzyJVyEhSZVxsZJ1Bp5mPq2Y8qBCuNvvUl9dWxBe1M6IjEbQYMk
         QfG+smMWtTmqvlCUC2iHqimpWSCIXny6RWcDDaGeSLN+rgN2wJVIYTEO7yyTtOHwJSz+
         2GNyNav5MFESGt/WVDtpK04e8oRXTz5+63RjHAbAcy2mnqOxA/tdXJSvgkAmH31EQegD
         TulQ==
X-Gm-Message-State: AOJu0YxbnP2ENczHe7IpvEunBlyFdPV/PrgpQeMzJig+3LDdclaeS8l6
        W6gaG+apJM+QSZQFhXG9BgRjZx6YB5MJdhArqZRyRi92TuXaQ/p7RRW8hXj3P2MKu+h7XeB4vTD
        vymAsYILbWgPLEP3OQ77U/1V2
X-Received: by 2002:a19:f70c:0:b0:503:3278:3221 with SMTP id z12-20020a19f70c000000b0050332783221mr11374000lfe.69.1698859417371;
        Wed, 01 Nov 2023 10:23:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6HHz3oW4ipafXuoWciK1QIqlCji+n9zHO/WdZA5/mihhlvFcyYrzNsJ02zM3nEz/DRpJg6Q==
X-Received: by 2002:a19:f70c:0:b0:503:3278:3221 with SMTP id z12-20020a19f70c000000b0050332783221mr11373983lfe.69.1698859416958;
        Wed, 01 Nov 2023 10:23:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id z11-20020a1709063a0b00b0099bd7b26639sm170572eje.6.2023.11.01.10.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 10:23:36 -0700 (PDT)
Message-ID: <b0eab26f-23e8-49cb-b831-1188d5abda86@redhat.com>
Date:   Wed, 1 Nov 2023 18:23:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-misc-next v7 4/7] drm/gpuvm: add an abstraction for a
 VM / BO combination
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231023201659.25332-1-dakr@redhat.com>
 <20231023201659.25332-5-dakr@redhat.com>
 <4a51c1cd9e2435332e033f9426bac8fae1c21c60.camel@linux.intel.com>
 <980754a3-7f5a-465e-88a9-62a40c82cae8@redhat.com>
 <ab8f30452540171447118d64931e66da96b6e85e.camel@linux.intel.com>
 <b09e37f3-33f6-4ea8-876b-f0bee9627ced@redhat.com>
 <1043bb3c1156d08015db5478183888892dfeda88.camel@linux.intel.com>
 <bfcaf8f777c2c6f018423bb1840a58ab7c80d97f.camel@linux.intel.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <bfcaf8f777c2c6f018423bb1840a58ab7c80d97f.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/23 10:56, Thomas Hellström wrote:
> On Wed, 2023-11-01 at 10:41 +0100, Thomas Hellström wrote:
>> Hi, Danilo,
>>
>> On Tue, 2023-10-31 at 18:52 +0100, Danilo Krummrich wrote:
>>> On 10/31/23 17:45, Thomas Hellström wrote:
>>>> On Tue, 2023-10-31 at 17:39 +0100, Danilo Krummrich wrote:
>>>>> On 10/31/23 12:25, Thomas Hellström wrote:
>>>>>> On Mon, 2023-10-23 at 22:16 +0200, Danilo Krummrich wrote:
>>>>>>> Add an abstraction layer between the drm_gpuva mappings of
>>>>>>> a
>>>>>>> particular
>>>>>>> drm_gem_object and this GEM object itself. The abstraction
>>>>>>> represents
>>>>>>> a
>>>>>>> combination of a drm_gem_object and drm_gpuvm. The
>>>>>>> drm_gem_object
>>>>>>> holds
>>>>>>> a list of drm_gpuvm_bo structures (the structure
>>>>>>> representing
>>>>>>> this
>>>>>>> abstraction), while each drm_gpuvm_bo contains list of
>>>>>>> mappings
>>>>>>> of
>>>>>>> this
>>>>>>> GEM object.
>>>>>>>
>>>>>>> This has multiple advantages:
>>>>>>>
>>>>>>> 1) We can use the drm_gpuvm_bo structure to attach it to
>>>>>>> various
>>>>>>> lists
>>>>>>>       of the drm_gpuvm. This is useful for tracking external
>>>>>>> and
>>>>>>> evicted
>>>>>>>       objects per VM, which is introduced in subsequent
>>>>>>> patches.
>>>>>>>
>>>>>>> 2) Finding mappings of a certain drm_gem_object mapped in a
>>>>>>> certain
>>>>>>>       drm_gpuvm becomes much cheaper.
>>>>>>>
>>>>>>> 3) Drivers can derive and extend the structure to easily
>>>>>>> represent
>>>>>>>       driver specific states of a BO for a certain GPUVM.
>>>>>>>
>>>>>>> The idea of this abstraction was taken from amdgpu, hence
>>>>>>> the
>>>>>>> credit
>>>>>>> for
>>>>>>> this idea goes to the developers of amdgpu.
>>>>>>>
>>>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>>>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/drm_gpuvm.c            | 335
>>>>>>> +++++++++++++++++++++--
>>>>>>> --
>>>>>>>     drivers/gpu/drm/nouveau/nouveau_uvmm.c |  64 +++--
>>>>>>>     include/drm/drm_gem.h                  |  32 +--
>>>>>>>     include/drm/drm_gpuvm.h                | 188
>>>>>>> +++++++++++++-
>>>>>>>     4 files changed, 533 insertions(+), 86 deletions(-)
>>>>>>
>>>>>> That checkpatch.pl error still remains as well.
>>>>>
>>>>> I guess you refer to:
>>>>>
>>>>> ERROR: do not use assignment in if condition
>>>>> #633: FILE: drivers/gpu/drm/nouveau/nouveau_uvmm.c:1165:
>>>>> +                       if (!(op->gem.obj = obj))
>>>>>
>>>>> This was an intentional decision, since in this specific case
>>>>> it
>>>>> seems to
>>>>> be more readable than the alternatives.
>>>>>
>>>>> However, if we consider this to be a hard rule, which we never
>>>>> ever
>>>>> break,
>>>>> I'm fine changing it too.
>>>>
>>>> With the errors, sooner or later they are going to start generate
>>>> patches to "fix" them. In this particular case also Xe CI is
>>>> complaining and abort building when I submit the Xe adaptation,
>>>> so
>>>> it'd
>>>> be good to be checkpatch.pl conformant IMHO.
>>>
>>> Ok, I will change this one.
>>>
>>> However, in general my opinion on coding style is that we should
>>> preserve us
>>> the privilege to deviate from it when we agree it makes sense and
>>> improves
>>> the code quality.
>>>
>>> Having a CI forcing people to *blindly* follow certain rules and
>>> even
>>> abort
>>> building isn't very beneficial in that respect.
>>>
>>> Also, consider patches which partially change a line of code that
>>> already
>>> contains a coding style "issue" - the CI would also block you on
>>> that
>>> one I
>>> guess. Besides that it seems to block you on unrelated code, note
>>> that the
>>> assignment in question is from Nouveau and not from GPUVM.
>>
>> Yes, I completely agree that having CI enforce error free coding
>> style
>> checks is bad, and I'll see if I can get that changed on Xe CI. To my
>> Knowledge It hasn't always been like that.
>>
>> But OTOH my take on this is that if there are coding style rules and
>> recommendations we should try to follow them unless there are
>> *strong*
>> reasons not to. Sometimes that may result in code that may be a
>> little
>> harder to read, but OTOH a reviewer won't have to read up on the
>> component's style flavor before reviewing and it will avoid future
>> style fix patches.
> 
> Basically meaning I'll continue to point those out when reviewing in
> case the author made an oversight, but won't require fixing for an R-B
> if the component owner thinks otherwise.

Yeah, I fully agree on that. That's why I changed it. I still think it was
better as it was, but clearly way too minor to break the rules.

- Danilo

> 
> Thanks,
> Thomas
> 
>>
>> Thanks,
>> Thomas
>>
>>
>>>
>>> - Danilo
>>>
>>>>
>>>> Thanks,
>>>> Thomas
>>>>
>>>>
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Thomas
>>>>>>
>>>>>
>>>>
>>>
>>
> 

