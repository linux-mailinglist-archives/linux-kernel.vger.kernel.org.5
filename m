Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4204C7DD263
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjJaQnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbjJaQmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D55EA255
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698770378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XJqCZxrLTKcwcLAE87Zs5L0NcoxMkUhMyUSeCCjP4ho=;
        b=e8RJvwWETCmvqMLYFNueCelFvSZH1lRK3Wg9IdyI8grJR2A1WZvHROsf67Q07A2Q24JbA+
        WVBPZVJUajhXWcVcgegMx7dGGYkN/WhR0CpQTG9rqPMuRCNi98HttIT2/d719i5IYSBZlF
        oNWxMnNpFFRsdhp7MRGst7hYQMs2ERY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-1qVwYXYvOQWRFkDMsla7RQ-1; Tue, 31 Oct 2023 12:39:36 -0400
X-MC-Unique: 1qVwYXYvOQWRFkDMsla7RQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9d30a6a67abso178515166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698770375; x=1699375175;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJqCZxrLTKcwcLAE87Zs5L0NcoxMkUhMyUSeCCjP4ho=;
        b=AYqsBl+l7g/DZU/xB8x8+apC5MCPm5j/hMmAYUf9pOqc1uhNrAgaz6iI22xhIMqz0e
         zxyLGKnVUFKZpLXd8HG2x1+0Xmr1y3BlcgvCedlE9HogiL8tCR37FNGcql6BuujlWP8m
         Wc8RdJRUPTSDtdEzI7iahPc7lBXvKmJlhCgH6RoxTCfk86QLZZniFfPEi4lt/Npne4kb
         cXvOOwRYOY4iIB1wEpF7eVWVslhmWNAkUdqo3g6BMPokh7NPc59Q11t+MXhj7IuYvRqP
         uOLz+6aNEPxld0GbRP8VFXi7wmxZpT2Ey08+0z75zH9C+iic8Nu4lDINR4xq+3NHJ+1D
         xGuA==
X-Gm-Message-State: AOJu0YyU0Hu4I53Ehcp5GXs5C03M/5wvNynJE6JRY/Fcm9MXsk4jhjKG
        2tLqfz7CjyL8tW2/U99JWFtXH6/CwclBaNR2m29pVJlymdFgcnR0L66erZ5F75yo97LU2gNH0ub
        aeOElGvCCgTsiN6PUSkKZm0LJ
X-Received: by 2002:a17:906:fd8b:b0:9bf:30e8:5bfd with SMTP id xa11-20020a170906fd8b00b009bf30e85bfdmr11756715ejb.48.1698770375522;
        Tue, 31 Oct 2023 09:39:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuyO5pLCHn8pJ83CSPTWoms/T8gldqXUtB/D0/4Zzvxqi9jtHduxrXbKLdaxRhtjX8nVkSdQ==
X-Received: by 2002:a17:906:fd8b:b0:9bf:30e8:5bfd with SMTP id xa11-20020a170906fd8b00b009bf30e85bfdmr11756697ejb.48.1698770375172;
        Tue, 31 Oct 2023 09:39:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id s25-20020a170906bc5900b009b9977867fbsm1230584ejv.109.2023.10.31.09.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 09:39:34 -0700 (PDT)
Message-ID: <980754a3-7f5a-465e-88a9-62a40c82cae8@redhat.com>
Date:   Tue, 31 Oct 2023 17:39:33 +0100
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
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <4a51c1cd9e2435332e033f9426bac8fae1c21c60.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 12:25, Thomas Hellström wrote:
> On Mon, 2023-10-23 at 22:16 +0200, Danilo Krummrich wrote:
>> Add an abstraction layer between the drm_gpuva mappings of a
>> particular
>> drm_gem_object and this GEM object itself. The abstraction represents
>> a
>> combination of a drm_gem_object and drm_gpuvm. The drm_gem_object
>> holds
>> a list of drm_gpuvm_bo structures (the structure representing this
>> abstraction), while each drm_gpuvm_bo contains list of mappings of
>> this
>> GEM object.
>>
>> This has multiple advantages:
>>
>> 1) We can use the drm_gpuvm_bo structure to attach it to various
>> lists
>>     of the drm_gpuvm. This is useful for tracking external and evicted
>>     objects per VM, which is introduced in subsequent patches.
>>
>> 2) Finding mappings of a certain drm_gem_object mapped in a certain
>>     drm_gpuvm becomes much cheaper.
>>
>> 3) Drivers can derive and extend the structure to easily represent
>>     driver specific states of a BO for a certain GPUVM.
>>
>> The idea of this abstraction was taken from amdgpu, hence the credit
>> for
>> this idea goes to the developers of amdgpu.
>>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>>   drivers/gpu/drm/drm_gpuvm.c            | 335 +++++++++++++++++++++--
>> --
>>   drivers/gpu/drm/nouveau/nouveau_uvmm.c |  64 +++--
>>   include/drm/drm_gem.h                  |  32 +--
>>   include/drm/drm_gpuvm.h                | 188 +++++++++++++-
>>   4 files changed, 533 insertions(+), 86 deletions(-)
> 
> That checkpatch.pl error still remains as well.

I guess you refer to:

ERROR: do not use assignment in if condition
#633: FILE: drivers/gpu/drm/nouveau/nouveau_uvmm.c:1165:
+                       if (!(op->gem.obj = obj))

This was an intentional decision, since in this specific case it seems to
be more readable than the alternatives.

However, if we consider this to be a hard rule, which we never ever break,
I'm fine changing it too.

> 
> Thanks,
> Thomas
> 

