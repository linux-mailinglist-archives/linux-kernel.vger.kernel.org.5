Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD52797B34
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjIGSJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbjIGSJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AEC2126
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694110077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EVgj5u+n4ytdhz89LH1dh0Jm4Qa5YH8eL53V/NQmF08=;
        b=iutHupX6F+gSSZxhZGPYF7Kp3GbiTDV9Q5Z0TJCKnSgbsu6DUWHWIFH73BWPWpLqB/6Y8v
        W+CnCGE/qlC/YJKiPZZKZr0bWRZIEMxMF/9W8SlJaPjHgqu9VQKKksTrg/b81uauGBQw2W
        sl4ewDeSKhz2F0L3uV+K+ICMLShtXP8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-8ceHOEgLMb-2Iv7veqwLQg-1; Thu, 07 Sep 2023 05:41:14 -0400
X-MC-Unique: 8ceHOEgLMb-2Iv7veqwLQg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a355c9028so43215266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 02:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694079674; x=1694684474;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVgj5u+n4ytdhz89LH1dh0Jm4Qa5YH8eL53V/NQmF08=;
        b=GTLNL/aODiY652D9dayaY8uRQ6QgDukLcoi4A4eWyLw/qTkmy/DagPI4UD3ZkrF0f3
         F2YExCpvqHIenylyz9eM3CNLQie1e41Wcon+Hlh46gRiqQvTrBDC84qDa0n9QVreSyz4
         sIwbstOdsVtBGia5w64SOZgcBCh/s66uiM8Z093rDizrs2NhjEIJxEhkAUhfC0wxtFLL
         1JNw5uTMFy2LnU30UVC2vcc2cUeaRWmJC6m0NQRKJ0697iN+XcH2PZUOAWJsregb8vt9
         XFGBAvOteQmAWaBxkNKLGbbatFMvEQJKREtVfheJGcUr0zUNiNCmZ91Yff6pa+2C+3p4
         Djhg==
X-Gm-Message-State: AOJu0Ywndejw9lw/NQys4y7W27ljJcJ7c7tUPE372freMXsJzoWtmYjY
        NVJvV2aCs3ylIRLgTVfbEGi3tm23pfslAUJWavT+Zh85sVzDKjfH8PkIW8tBjiICXRC25ev/Plr
        dFeNGJhRY4GktJoagRwLLVl2p
X-Received: by 2002:a17:907:1dee:b0:9a1:f21e:cdfd with SMTP id og46-20020a1709071dee00b009a1f21ecdfdmr4269849ejc.34.1694079673852;
        Thu, 07 Sep 2023 02:41:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4QX1xQ5c7FSGik6QJJx3KU6K2gTDdOyyCDY1ZR2k6aTunzdJhBvyM89miqz+SlE9Gm8xV4g==
X-Received: by 2002:a17:907:1dee:b0:9a1:f21e:cdfd with SMTP id og46-20020a1709071dee00b009a1f21ecdfdmr4269824ejc.34.1694079673501;
        Thu, 07 Sep 2023 02:41:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906365600b009a5f1d1564dsm10059659ejb.126.2023.09.07.02.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 02:41:13 -0700 (PDT)
Message-ID: <b3a322f0-9b0b-0ad8-be5d-e081f4061f13@redhat.com>
Date:   Thu, 7 Sep 2023 11:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v2 5/7] drm/gpuvm: add an abstraction for a
 VM / BO combination
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230906214723.4393-1-dakr@redhat.com>
 <20230906214723.4393-6-dakr@redhat.com>
 <20230907104252.4e15acb9@collabora.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230907104252.4e15acb9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 10:42, Boris Brezillon wrote:
> On Wed,  6 Sep 2023 23:47:13 +0200
> Danilo Krummrich <dakr@redhat.com> wrote:
> 
>> +void drm_gpuvm_bo_destroy(struct kref *kref);
> 
> I usually keep kref's release functions private so people are not
> tempted to use them.

I think I did that because drm_gpuvm_bo_put() needs it.

> 
>> +
>> +/**
>> + * drm_gpuvm_bo_get() - acquire a struct drm_gpuvm_bo reference
>> + * @vm_bo: the &drm_gpuvm_bo to acquire the reference of
>> + *
>> + * This function acquires an additional reference to @vm_bo. It is illegal to
>> + * call this without already holding a reference. No locks required.
>> + */
>> +static inline struct drm_gpuvm_bo *
>> +drm_gpuvm_bo_get(struct drm_gpuvm_bo *vm_bo)
>> +{
>> +	kref_get(&vm_bo->kref);
>> +	return vm_bo;
>> +}
>> +
>> +/**
>> + * drm_gpuvm_bo_put() - drop a struct drm_gpuvm_bo reference
>> + * @vm_bo: the &drm_gpuvm_bo to release the reference of
>> + *
>> + * This releases a reference to @vm_bo.
>> + */
>> +static inline void
>> +drm_gpuvm_bo_put(struct drm_gpuvm_bo *vm_bo)
>> +{
>> +	kref_put(&vm_bo->kref, drm_gpuvm_bo_destroy);
> 
> nit: can we have
> 
> 	if (vm_bo)
> 		kref_put(&vm_bo->kref, drm_gpuvm_bo_destroy);
> 
> so we don't have to bother testing the vm_bo value in the error/cleanup
> paths?
> 
>> +}
>> +
> 

