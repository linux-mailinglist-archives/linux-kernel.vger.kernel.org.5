Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D309F7C854D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjJMMGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjJMMGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F641A9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697198715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+dcXEP+GxfBYG20ABDjpqfoHUMaa+MeG9Y3QKfP39fY=;
        b=gB4QGzwL7Ks3Q32L7IefYfiX/FcxLqa3zZKKRKVixMwoalCHR8WW/1VA9/QNtcloiRYgh8
        2ule8vtdVxUdh6z+b9rjF6Q8LjDlasn4YUwyhy30+RboLZ/a2pHLFLsxvIzjZUShnV932D
        cIc6/i2GmPKQESmttO/53Nza3ujbGXo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-Ewg-rkO2MiqkWiUaKQx7kw-1; Fri, 13 Oct 2023 08:05:14 -0400
X-MC-Unique: Ewg-rkO2MiqkWiUaKQx7kw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae686dafedso152126066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697198712; x=1697803512;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dcXEP+GxfBYG20ABDjpqfoHUMaa+MeG9Y3QKfP39fY=;
        b=dS/JKbczhPDHK9SzBseqjygXESHckZFYhZldry7PcBcpXVCEM7epDD+Y1tZkASbjTn
         V+BTta47kqw8AZZBVh1Tn2P9ayqzVYWnos6YqVzOuxaN7mG2mz8CJHkh/bbnzdSZjQT+
         DSc3F80mGKVmumZF9unLW+TlobLrVBiOXJyMMFOYq46XG5x9ltS302paRy8cIMAeOuOK
         djwbGHkpfUacqXPvzjeamw8e5VoufQrvVQrvD/kJWP4p2Pnq+GWKLAAGVty0YOKPAlSn
         1cxOf+jZD7gejcO4ZMSI7HTrdEYX/MDpTXUAnqADouMSX4lOBoPw/JEOAUUufeK05IBE
         2K7A==
X-Gm-Message-State: AOJu0YyrOGDmmZkFEiFJRajhZn5Jzz6jHQfykECsMv3hA8pCp5gLuA3W
        t17W9ZQ9xl9mQNdzdMU5JTbg7rCDyNExB12SCHqvMp8HP06MsmkuSCFscBJz24U7ConsAf4vdeD
        NzriBrkHneRbPH5z37K6KOPgL
X-Received: by 2002:a17:907:2723:b0:9a5:d657:47ee with SMTP id d3-20020a170907272300b009a5d65747eemr22847162ejl.58.1697198712760;
        Fri, 13 Oct 2023 05:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVP4CGBK7VTrUzYEqzjKP5V5a2WbPdWtJr2jlo1Cabz8+0BX6tXBDev67FhhRKBk7WuWHZ/A==
X-Received: by 2002:a17:907:2723:b0:9a5:d657:47ee with SMTP id d3-20020a170907272300b009a5d65747eemr22847132ejl.58.1697198712443;
        Fri, 13 Oct 2023 05:05:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906078c00b009b94fe3fc47sm12267409ejc.159.2023.10.13.05.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 05:05:12 -0700 (PDT)
Message-ID: <d586d845-fcb1-4ebc-b75d-3f147837c917@redhat.com>
Date:   Fri, 13 Oct 2023 14:05:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-misc-next v6 4/6] drm/gpuvm: track/lock/validate
 external/evicted objects
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231008233212.13815-1-dakr@redhat.com>
 <20231008233212.13815-5-dakr@redhat.com>
 <c6ce663d-dd69-46a2-7b55-359169b6c03c@linux.intel.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <c6ce663d-dd69-46a2-7b55-359169b6c03c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 08:40, Thomas Hellström wrote:
> 
> On 10/9/23 01:32, Danilo Krummrich wrote:
>> Currently the DRM GPUVM offers common infrastructure to track GPU VA
>> allocations and mappings, generically connect GPU VA mappings to their
>> backing buffers and perform more complex mapping operations on the GPU VA
>> space.
>>
>> However, there are more design patterns commonly used by drivers, which
>> can potentially be generalized in order to make the DRM GPUVM represent
>> a basis for GPU-VM implementations. In this context, this patch aims
>> at generalizing the following elements.
>>
>> 1) Provide a common dma-resv for GEM objects not being used outside of
>>     this GPU-VM.
>>
>> 2) Provide tracking of external GEM objects (GEM objects which are
>>     shared with other GPU-VMs).
>>
>> 3) Provide functions to efficiently lock all GEM objects dma-resv the
>>     GPU-VM contains mappings of.
>>
>> 4) Provide tracking of evicted GEM objects the GPU-VM contains mappings
>>     of, such that validation of evicted GEM objects is accelerated.
>>
>> 5) Provide some convinience functions for common patterns.
>>
>> Big thanks to Boris Brezillon for his help to figure out locking for
>> drivers updating the GPU VA space within the fence signalling path.
>>
>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>>
>> +/**
>> + * drm_gpuvm_resv_add_fence - add fence to private and all extobj
>> + * dma-resv
>> + * @gpuvm: the &drm_gpuvm to add a fence to
>> + * @exec: the &drm_exec locking context
>> + * @fence: fence to add
>> + * @private_usage: private dma-resv usage
>> + * @extobj_usage: extobj dma-resv usage
>> + */
>> +void
>> +drm_gpuvm_resv_add_fence(struct drm_gpuvm *gpuvm,
>> +             struct drm_exec *exec,
>> +             struct dma_fence *fence,
>> +             enum dma_resv_usage private_usage,
>> +             enum dma_resv_usage extobj_usage)
>> +{
>> +    struct drm_gem_object *obj;
>> +    unsigned long index;
>> +
>> +    drm_exec_for_each_locked_object(exec, index, obj) {
>> +        dma_resv_assert_held(obj->resv);
>> +        dma_resv_add_fence(obj->resv, fence,
>> +                   drm_gpuvm_is_extobj(gpuvm, obj) ?
>> +                   private_usage : extobj_usage);
> 
> It looks like private_usage and extobj_usage are mixed up above?

Good catch, will fix.

> 
> 
>> +    }
>> +}
>> +EXPORT_SYMBOL_GPL(drm_gpuvm_resv_add_fence);
>> +
> 
> Thanks,
> 
> Thomas
> 
> 

