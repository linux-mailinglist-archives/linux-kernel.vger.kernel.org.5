Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9510B7FC3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346422AbjK1TCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjK1TCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:02:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77DDC3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701198131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGmHgjiL5RvZl2sLJfs3i9fXFkdmODqGYRvSernjGLI=;
        b=RcQyyHRq8Hqf/fJBqO/vyDYoae4y/l8WCiJY3mCZh0kNF49Yw+XYSrybogSORhCTRuOicg
        QZUUeo/vviokt72mkOKzI2X08oM73GEuAwTfILcWTy5I2yO96UrMJOszOJQ1XiSKlbfFo1
        r3JduxQwAW/EEvyDJmRS7IEososGXKU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-0BwdRZ_cMBGjL3Aeduy4zg-1; Tue, 28 Nov 2023 14:02:09 -0500
X-MC-Unique: 0BwdRZ_cMBGjL3Aeduy4zg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a15ce298cf4so80954766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:02:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198128; x=1701802928;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGmHgjiL5RvZl2sLJfs3i9fXFkdmODqGYRvSernjGLI=;
        b=t0+ueaRFfUiXeN8UYC2idTKUML/BHipiXkw/ZjvERI2m4mhxr7jVaXe1D9YXozz5G9
         wgf1hH+OUtF3xR48bd/kdIvPFZS08DfuEmGuhPOrEmRWBgkWqqKqh+XGBVSWqCcYSdpG
         XqDfaof4oMIV5oVabBJTbIft0AewuMjClWxs6TCvzc45bjHjPuMJFVHSmz215dyFsTQA
         Mytn/iNDPkKNJTcGm2pP93MNEkn9SKcQjHDy8ZafcSL25jqH1yTtxD/BfxKpw/NCbWyE
         8PdstBjWz6TzE54Bzl7DtZD5VrQDdBjbSSbiHpj3S6S/4nMy0UmD5LS6M6Rrir5Fyd7u
         A8tQ==
X-Gm-Message-State: AOJu0YzKok1vtdTEzWBziOwOpNJS3eflKhuazEhNJmbS1Icme3vimNVo
        B6qaKgAijeDWmjgtA1FWDUGKIcU0N/ax4/JfnB6gYESLIWz459VT/w17ftz/qlFlg0fibKoxABr
        NALiGuv9M0oSq6wR627UOhQOb
X-Received: by 2002:a17:906:1d0c:b0:9e5:2c35:50e9 with SMTP id n12-20020a1709061d0c00b009e52c3550e9mr8404035ejh.77.1701198128178;
        Tue, 28 Nov 2023 11:02:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUj8kifnKaxa05P8mGD82jKPO4N0l1GehEfH6yvVc7CQFKp1485CXWi/ZGS5bkOo8AJKnYvg==
X-Received: by 2002:a17:906:1d0c:b0:9e5:2c35:50e9 with SMTP id n12-20020a1709061d0c00b009e52c3550e9mr8404017ejh.77.1701198127854;
        Tue, 28 Nov 2023 11:02:07 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id p4-20020a170906b20400b009ddaf5ebb6fsm7148515ejz.177.2023.11.28.11.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 11:02:07 -0800 (PST)
Message-ID: <40603849-a23b-4098-b0a9-284622d931fb@redhat.com>
Date:   Tue, 28 Nov 2023 20:02:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH drm-misc-next 5/5] drm/imagination: vm: make
 use of GPUVM's drm_exec helper
Content-Language: en-US
To:     Donald Robson <Donald.Robson@imgtec.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Frank Binns <Frank.Binns@imgtec.com>,
        Matt Coster <Matt.Coster@imgtec.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Sarah Walker <Sarah.Walker@imgtec.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231124233650.152653-1-dakr@redhat.com>
 <20231124233650.152653-6-dakr@redhat.com>
 <3582c630ee753db6ef1370612e69f36287536912.camel@imgtec.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <3582c630ee753db6ef1370612e69f36287536912.camel@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 11:47, Donald Robson wrote:
> Hi Danilo,
> 
> Apologies - I guess I should have submitted a patch to handle zero fences in your
> locking functions with the final patch series.
> 
> On Sat, 2023-11-25 at 00:36 +0100, Danilo Krummrich wrote:
>> *** CAUTION: This email originates from a source not known to Imagination Technologies. Think before you click a link or open an attachment ***
>>
>> Make use of GPUVM's drm_exec helper functions preventing direct access
>> to GPUVM internal data structures, such as the external object list.
>>
>> This is especially important to ensure following the locking rules
>> around the GPUVM external object list.
>>
>> Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>>   drivers/gpu/drm/imagination/pvr_vm.c | 16 +++++-----------
>>   1 file changed, 5 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
>> index e0d74d9a6190..3f7888f5cc53 100644
>> --- a/drivers/gpu/drm/imagination/pvr_vm.c
>> +++ b/drivers/gpu/drm/imagination/pvr_vm.c
>> @@ -337,27 +337,21 @@ static int
>>   pvr_vm_bind_op_lock_resvs(struct drm_exec *exec, struct pvr_vm_bind_op *bind_op)
>>   {
>>   	drm_exec_until_all_locked(exec) {
>> -		struct drm_gem_object *r_obj = &bind_op->vm_ctx->dummy_gem;
>>   		struct drm_gpuvm *gpuvm = &bind_op->vm_ctx->gpuvm_mgr;
>>   		struct pvr_gem_object *pvr_obj = bind_op->pvr_obj;
>> -		struct drm_gpuvm_bo *gpuvm_bo;
>>   
>>   		/* Acquire lock on the vm_context's reserve object. */
>> -		int err = drm_exec_lock_obj(exec, r_obj);
>> +		int err = drm_gpuvm_prepare_vm(gpuvm, exec, 0);
>>   
>>   		drm_exec_retry_on_contention(exec);
>>   		if (err)
>>   			return err;
>>   
>>   		/* Acquire lock on all BOs in the context. */
>> -		list_for_each_entry(gpuvm_bo, &gpuvm->extobj.list,
>> -				    list.entry.extobj) {
>> -			err = drm_exec_lock_obj(exec, gpuvm_bo->obj);
>> -
>> -			drm_exec_retry_on_contention(exec);
>> -			if (err)
>> -				return err;
>> -		}
>> +		err = drm_gpuvm_prepare_objects(gpuvm, exec, 0);
>> +		drm_exec_retry_on_contention(exec);
>> +		if (err)
>> +			return err;
> 
> Before I discovered the problem when not reserving fences, I was trying to use
> drm_gpuvm_exec_lock() with vm_exec->extra.fn() for the part below.  Is there
> a reason not to do that now?

No, that works - gonna change that.

- Danilo

> 
> Many thanks,
> Donald
> 
>>   
>>   		/* Unmap operations don't have an object to lock. */
>>   		if (!pvr_obj)

