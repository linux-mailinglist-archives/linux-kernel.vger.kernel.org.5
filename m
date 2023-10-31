Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550CF7DD2B3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbjJaQsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346080AbjJaQsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:48:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B9B120
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698770851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/BJcyx0SOypKpo4xmsBmVert8Jenq2HHMEvZSzwm5A=;
        b=TuCi/X179hLsVbvLqQQr2ZbGINy/Z7GG64paA+u/uWi9fRTf1+6p2N4KhqXJ+A/OGfDff+
        RjH81DLsKYNy6H1J47Ib95z4Xn44Kla1ZF7oJHt6B/kzVP5obMd21kL4jtVln4qjW8EGJb
        U79whp8ra/weI2v3lAEU+gNXDWns3HM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-CKeL5SaiOw6SbYGKDRDqIA-1; Tue, 31 Oct 2023 12:47:29 -0400
X-MC-Unique: CKeL5SaiOw6SbYGKDRDqIA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c75886c044so374236266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698770848; x=1699375648;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/BJcyx0SOypKpo4xmsBmVert8Jenq2HHMEvZSzwm5A=;
        b=IA9BspCEzH8Uxyj243m8RpeImxiK1gYoCpBnb3/m3VPBcQMFnVmCC9T6IGS60vPAcQ
         CPlLECh0yVtVvacrs04l6W/BX/SiLpyF6s+woWdmraAOyCMpPdCu75OFYAZ0bX7tnogT
         ZRnsw8+vJEgPknUCrFk/byaEjQfT9qTYxZF8sLs7sh1sC1oxcvI/nlZsulRqibUOJg3x
         r/JiainH5TFvw5LZn+EJlPDmyO4F7FHMBXlUNerTH8QwebEX55H0p+9ijTmVVeffC00r
         60a2QAG6ZEC+KUlGT9t/Il6ahB2N5TK0WUoH5MFwqukfL5YzyL2IjKoRqEjjfE3ErMsN
         0aPQ==
X-Gm-Message-State: AOJu0YzqQhOlVUu2msCiZvhRToA3fekHu58KafFMlDi7IrwZ33BXO/fs
        no//dD+M4KNU0ME3iTT1eEgE5AIzerboIS17EOi6caxurLDfjDilXrkChlx0cZDPKmpUSwB4pD+
        aVbDM7r6lX6qipk+GAd+EiPGM
X-Received: by 2002:a17:907:784:b0:9c6:abf9:2a1e with SMTP id xd4-20020a170907078400b009c6abf92a1emr11311399ejb.31.1698770848310;
        Tue, 31 Oct 2023 09:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMUiDYmMPqVXA/5ppx5Y7BI345CIhxxDojus1mFBGdcNyzsWcdm7CAizqyBS8RhdHm5PW74w==
X-Received: by 2002:a17:907:784:b0:9c6:abf9:2a1e with SMTP id xd4-20020a170907078400b009c6abf92a1emr11311386ejb.31.1698770847987;
        Tue, 31 Oct 2023 09:47:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ks24-20020a170906f85800b009ad8acac02asm1265268ejb.172.2023.10.31.09.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 09:47:27 -0700 (PDT)
Message-ID: <cb09edb7-1f35-414b-b7fd-b5d8271e0cac@redhat.com>
Date:   Tue, 31 Oct 2023 17:47:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-misc-next v7 1/7] drm/gpuvm: convert WARN() to
 drm_WARN() variants
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231023201659.25332-1-dakr@redhat.com>
 <20231023201659.25332-2-dakr@redhat.com>
 <ed8a4b9239cf358657e764be1cb5221651b8246a.camel@linux.intel.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <ed8a4b9239cf358657e764be1cb5221651b8246a.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 11:08, Thomas Hellström wrote:
> On Mon, 2023-10-23 at 22:16 +0200, Danilo Krummrich wrote:
>> Use drm_WARN() and drm_WARN_ON() variants to indicate drivers the
>> context the failing VM resides in.
>>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>>   drivers/gpu/drm/drm_gpuvm.c            | 32 ++++++++++++++----------
>> --
>>   drivers/gpu/drm/nouveau/nouveau_uvmm.c |  3 ++-
>>   include/drm/drm_gpuvm.h                |  7 ++++++
>>   3 files changed, 26 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gpuvm.c
>> b/drivers/gpu/drm/drm_gpuvm.c
>> index 08c088319652..d7367a202fee 100644
>> --- a/drivers/gpu/drm/drm_gpuvm.c
>> +++ b/drivers/gpu/drm/drm_gpuvm.c
>> @@ -614,12 +614,12 @@ static int __drm_gpuva_insert(struct drm_gpuvm
>> *gpuvm,
>>   static void __drm_gpuva_remove(struct drm_gpuva *va);
>>   
>>   static bool
>> -drm_gpuvm_check_overflow(u64 addr, u64 range)
>> +drm_gpuvm_check_overflow(struct drm_gpuvm *gpuvm, u64 addr, u64
>> range)
>>   {
>>          u64 end;
>>   
>> -       return WARN(check_add_overflow(addr, range, &end),
>> -                   "GPUVA address limited to %zu bytes.\n",
>> sizeof(end));
>> +       return drm_WARN(gpuvm->drm, check_add_overflow(addr, range,
>> &end),
>> +                       "GPUVA address limited to %zu bytes.\n",
>> sizeof(end));
>>   }
>>   
>>   static bool
>> @@ -647,7 +647,7 @@ static bool
>>   drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm,
>>                        u64 addr, u64 range)
>>   {
>> -       return !drm_gpuvm_check_overflow(addr, range) &&
>> +       return !drm_gpuvm_check_overflow(gpuvm, addr, range) &&
>>                 drm_gpuvm_in_mm_range(gpuvm, addr, range) &&
>>                 !drm_gpuvm_in_kernel_node(gpuvm, addr, range);
> 
> 
>>   }
>> @@ -656,6 +656,7 @@ drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm,
>>    * drm_gpuvm_init() - initialize a &drm_gpuvm
>>    * @gpuvm: pointer to the &drm_gpuvm to initialize
>>    * @name: the name of the GPU VA space
>> + * @drm: the &drm_device this VM resides in
>>    * @start_offset: the start offset of the GPU VA space
>>    * @range: the size of the GPU VA space
>>    * @reserve_offset: the start of the kernel reserved GPU VA area
>> @@ -668,8 +669,8 @@ drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm,
>>    * &name is expected to be managed by the surrounding driver
>> structures.
>>    */
>>   void
>> -drm_gpuvm_init(struct drm_gpuvm *gpuvm,
>> -              const char *name,
>> +drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
>> +              struct drm_device *drm,
>>                 u64 start_offset, u64 range,
>>                 u64 reserve_offset, u64 reserve_range,
>>                 const struct drm_gpuvm_ops *ops)
>> @@ -677,20 +678,20 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm,
>>          gpuvm->rb.tree = RB_ROOT_CACHED;
>>          INIT_LIST_HEAD(&gpuvm->rb.list);
>>   
>> -       drm_gpuvm_check_overflow(start_offset, range);
>> -       gpuvm->mm_start = start_offset;
>> -       gpuvm->mm_range = range;
>> -
>>          gpuvm->name = name ? name : "unknown";
>>          gpuvm->ops = ops;
>> +       gpuvm->drm = drm;
>>   
>> -       memset(&gpuvm->kernel_alloc_node, 0, sizeof(struct
>> drm_gpuva));
>> +       drm_gpuvm_check_overflow(gpuvm, start_offset, range);
>> +       gpuvm->mm_start = start_offset;
>> +       gpuvm->mm_range = range;
>>   
>> +       memset(&gpuvm->kernel_alloc_node, 0, sizeof(struct
>> drm_gpuva));
>>          if (reserve_range) {
>>                  gpuvm->kernel_alloc_node.va.addr = reserve_offset;
>>                  gpuvm->kernel_alloc_node.va.range = reserve_range;
>>   
>> -               if (likely(!drm_gpuvm_check_overflow(reserve_offset,
>> +               if (likely(!drm_gpuvm_check_overflow(gpuvm,
>> reserve_offset,
>>                                                       reserve_range)))
>>                          __drm_gpuva_insert(gpuvm, &gpuvm-
>>> kernel_alloc_node);
>>          }
>> @@ -712,8 +713,8 @@ drm_gpuvm_destroy(struct drm_gpuvm *gpuvm)
>>          if (gpuvm->kernel_alloc_node.va.range)
>>                  __drm_gpuva_remove(&gpuvm->kernel_alloc_node);
>>   
>> -       WARN(!RB_EMPTY_ROOT(&gpuvm->rb.tree.rb_root),
>> -            "GPUVA tree is not empty, potentially leaking memory.");
>> +       drm_WARN(gpuvm->drm, !RB_EMPTY_ROOT(&gpuvm->rb.tree.rb_root),
>> +                "GPUVA tree is not empty, potentially leaking
>> memory.\n");
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gpuvm_destroy);
>>   
>> @@ -795,7 +796,8 @@ drm_gpuva_remove(struct drm_gpuva *va)
>>          struct drm_gpuvm *gpuvm = va->vm;
>>   
>>          if (unlikely(va == &gpuvm->kernel_alloc_node)) {
>> -               WARN(1, "Can't destroy kernel reserved node.\n");
>> +               drm_WARN(gpuvm->drm, 1,
>> +                        "Can't destroy kernel reserved node.\n");
>>                  return;
>>          }
>>   
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
>> b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
>> index 5cf892c50f43..aaf5d28bd587 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
>> @@ -1808,6 +1808,7 @@ int
>>   nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli
>> *cli,
>>                    u64 kernel_managed_addr, u64 kernel_managed_size)
>>   {
>> +       struct drm_device *drm = cli->drm->dev;
>>          int ret;
>>          u64 kernel_managed_end = kernel_managed_addr +
>> kernel_managed_size;
>>   
>> @@ -1836,7 +1837,7 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm,
>> struct nouveau_cli *cli,
>>          uvmm->kernel_managed_addr = kernel_managed_addr;
>>          uvmm->kernel_managed_size = kernel_managed_size;
>>   
>> -       drm_gpuvm_init(&uvmm->base, cli->name,
>> +       drm_gpuvm_init(&uvmm->base, cli->name, drm,
>>                         NOUVEAU_VA_SPACE_START,
>>                         NOUVEAU_VA_SPACE_END,
>>                         kernel_managed_addr, kernel_managed_size,
>> diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
>> index bdfafc4a7705..687fd5893624 100644
>> --- a/include/drm/drm_gpuvm.h
>> +++ b/include/drm/drm_gpuvm.h
>> @@ -29,6 +29,7 @@
>>   #include <linux/rbtree.h>
>>   #include <linux/types.h>
>>   
>> +#include <drm/drm_device.h>
>>   #include <drm/drm_gem.h>
>>   
>>   struct drm_gpuvm;
>> @@ -201,6 +202,11 @@ struct drm_gpuvm {
>>           */
>>          const char *name;
>>   
>> +       /**
>> +        * @drm: the &drm_device this VM lives in
>> +        */
> 
> Could a one-liner do?
> /** <comment> */

There are a few more existing ones that could be a one-liner as well and
I like consistency. If you think it's preferrable to keep those ones in
one line, I'd probably do it for all in a follow-up patch.

> 
>> +       struct drm_device *drm;
>> +
>>          /**
>>           * @mm_start: start of the VA space
>>           */
>> @@ -241,6 +247,7 @@ struct drm_gpuvm {
>>   };
>>   
>>   void drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
>> +                   struct drm_device *drm,
>>                      u64 start_offset, u64 range,
>>                      u64 reserve_offset, u64 reserve_range,
>>                      const struct drm_gpuvm_ops *ops);
> 
> I figure Christian's commend can be addressed in a follow-up patch if
> neeed.

I already addressed his comment in a local branch, I can also just add the
patch to this series.

> 
> Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> 

