Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A8A7DD58D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376524AbjJaRxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347037AbjJaRxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A419C2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MM0l2/ZF5doyc+5WQup6Ywo/07BlpO+C3i/f3pi7EBM=;
        b=LbFe3+E2NGZTMLxmGeJcC+Tu5zbjPpTd3/dGYyLl9hnYOKM8KzMgYNX7CkqpYRvCqm61KU
        y07gi2mIdul8UQM+T0vuU9DGOPXgh7wM1NtjD0QcKBHaBJ6GqpJ17ftGmjY1mfbJaaXm0j
        L3Kl+RAD5R98rMFPmi1Qegp4dCaOEE4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-bilSc2BPMvGFT0D5FITWtw-1; Tue, 31 Oct 2023 13:52:52 -0400
X-MC-Unique: bilSc2BPMvGFT0D5FITWtw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5344aaf2703so4379808a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774771; x=1699379571;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MM0l2/ZF5doyc+5WQup6Ywo/07BlpO+C3i/f3pi7EBM=;
        b=sKkHkoIKbLWrt62Vsoacbq7+SqgFtaYGvsjDQGP6mg6rRJP08C5IWuFJ1hhLyf++fC
         pXmgkh/P6RfxzMKBal8Vzu/wWyD3OcwYTihWWhJaRj/yWW5b2XpK05KGLIcnQkF2Y4Wg
         EXSVw+8wshpc7mZlc2LCs0l52mcxkiXTR1dBsyUSiQ2ALrtfyh8DvWKUH2pYTUxQEdp3
         sbSZj8Ll1NOwlFAcvX5OIzKyTW2NqUw9M/Ev2IU6ohOo6290Rnp/JEO9ImpDKU/0antR
         Tyc6jYKATSWTSTEuekbW14z01UKj9etGMkXeLHI3lWSShiZy0sAf8scEjZKkH4krGq5d
         c6aQ==
X-Gm-Message-State: AOJu0YwBiAuwOgVFFBnXpakwsl52ZqgAq8pLd/xJtHZDB5B9pWHAD8M+
        F0WKNrZvVyl2ZCfQdypb0i2nve9aesyRGW+0REqfm7P/hHl3jHPpUwfKfqu8rb31qtz0KV9jij/
        nBiw6MhFjHGiUnikLoUiPs6SC
X-Received: by 2002:a05:6402:5214:b0:540:caed:3619 with SMTP id s20-20020a056402521400b00540caed3619mr14093192edd.24.1698774769073;
        Tue, 31 Oct 2023 10:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqrQl2BkPvKjejlZpdYejly+6BkpnQx23fRbw5JtUR23RuBxlpngOmivqZXHT036Dx+L2nJA==
X-Received: by 2002:a05:6402:5214:b0:540:caed:3619 with SMTP id s20-20020a056402521400b00540caed3619mr14093033edd.24.1698774767721;
        Tue, 31 Oct 2023 10:52:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id b8-20020a50ccc8000000b0053e15aefb0fsm1512922edj.85.2023.10.31.10.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 10:52:47 -0700 (PDT)
Message-ID: <b09e37f3-33f6-4ea8-876b-f0bee9627ced@redhat.com>
Date:   Tue, 31 Oct 2023 18:52:45 +0100
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
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <ab8f30452540171447118d64931e66da96b6e85e.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 17:45, Thomas Hellström wrote:
> On Tue, 2023-10-31 at 17:39 +0100, Danilo Krummrich wrote:
>> On 10/31/23 12:25, Thomas Hellström wrote:
>>> On Mon, 2023-10-23 at 22:16 +0200, Danilo Krummrich wrote:
>>>> Add an abstraction layer between the drm_gpuva mappings of a
>>>> particular
>>>> drm_gem_object and this GEM object itself. The abstraction
>>>> represents
>>>> a
>>>> combination of a drm_gem_object and drm_gpuvm. The drm_gem_object
>>>> holds
>>>> a list of drm_gpuvm_bo structures (the structure representing
>>>> this
>>>> abstraction), while each drm_gpuvm_bo contains list of mappings
>>>> of
>>>> this
>>>> GEM object.
>>>>
>>>> This has multiple advantages:
>>>>
>>>> 1) We can use the drm_gpuvm_bo structure to attach it to various
>>>> lists
>>>>      of the drm_gpuvm. This is useful for tracking external and
>>>> evicted
>>>>      objects per VM, which is introduced in subsequent patches.
>>>>
>>>> 2) Finding mappings of a certain drm_gem_object mapped in a
>>>> certain
>>>>      drm_gpuvm becomes much cheaper.
>>>>
>>>> 3) Drivers can derive and extend the structure to easily
>>>> represent
>>>>      driver specific states of a BO for a certain GPUVM.
>>>>
>>>> The idea of this abstraction was taken from amdgpu, hence the
>>>> credit
>>>> for
>>>> this idea goes to the developers of amdgpu.
>>>>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>>>> ---
>>>>    drivers/gpu/drm/drm_gpuvm.c            | 335
>>>> +++++++++++++++++++++--
>>>> --
>>>>    drivers/gpu/drm/nouveau/nouveau_uvmm.c |  64 +++--
>>>>    include/drm/drm_gem.h                  |  32 +--
>>>>    include/drm/drm_gpuvm.h                | 188 +++++++++++++-
>>>>    4 files changed, 533 insertions(+), 86 deletions(-)
>>>
>>> That checkpatch.pl error still remains as well.
>>
>> I guess you refer to:
>>
>> ERROR: do not use assignment in if condition
>> #633: FILE: drivers/gpu/drm/nouveau/nouveau_uvmm.c:1165:
>> +                       if (!(op->gem.obj = obj))
>>
>> This was an intentional decision, since in this specific case it
>> seems to
>> be more readable than the alternatives.
>>
>> However, if we consider this to be a hard rule, which we never ever
>> break,
>> I'm fine changing it too.
> 
> With the errors, sooner or later they are going to start generate
> patches to "fix" them. In this particular case also Xe CI is
> complaining and abort building when I submit the Xe adaptation, so it'd
> be good to be checkpatch.pl conformant IMHO.

Ok, I will change this one.

However, in general my opinion on coding style is that we should preserve us
the privilege to deviate from it when we agree it makes sense and improves
the code quality.

Having a CI forcing people to *blindly* follow certain rules and even abort
building isn't very beneficial in that respect.

Also, consider patches which partially change a line of code that already
contains a coding style "issue" - the CI would also block you on that one I
guess. Besides that it seems to block you on unrelated code, note that the
assignment in question is from Nouveau and not from GPUVM.

- Danilo

> 
> Thanks,
> Thomas
> 
> 
> 
> 
>>
>>>
>>> Thanks,
>>> Thomas
>>>
>>
> 

