Return-Path: <linux-kernel+bounces-96802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ED18761A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60EC2B21F10
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2365467C;
	Fri,  8 Mar 2024 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8/NB0OJ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1DC53392
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892724; cv=none; b=CF1sdsGaSUrgd3E9/LSocNgmhCFxZL2U5xVV8yzFCBvvhfRPd9SpwPAxb+8DFcsL7cwAxwU3QcHyINisfQlCh6peSk6wIafZ1p8fYKD/Dd8dmPWO6trXx//k0U9tYRwLSyp3HprunNwgl1MhT0jQ/Xdl8LiI998dMnPVI0bW6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892724; c=relaxed/simple;
	bh=Acr8xFG+KetIxOJBbbvxdROO5k0HX5tZ7LVCEm8eOoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIiZH8lzx7sYF+KP0ppKYfyAXecCn4EHlYErgd5698uCo4hV4ehReOoYgp/09lYDad2zZYPNVi/GXgykcOKlq0EDRPrOzjo0at7tmOnBeSfb6k7j+xVXQzS/asZ7YbOpxzb50FK6mNo8ka4M4jEXHtiTlh7U3shsL7sD/xVtQAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8/NB0OJ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5101cd91017so3133699e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709892720; x=1710497520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9SgGDjTSQoEN/9LevpE3gCXBJ1egZW+GlFcG8/AMFY=;
        b=c8/NB0OJ3vfzSUh+kS2KrmXV3zZHp3EPiEa1AJZOQ8XDsH/6KviAYFsxOmi6u/Hwei
         N44hc9GNz9zxSiLHg8V2D63EPnWJxY0sGEgxoJHcyPZrSl+S/RRJsTeL1JPmrfa7qW9K
         +BV2crC/3/fVgwIMMDzCdip3jA1PC+Fx6e+fXoYmhOtsMjKKoccAlV5MnrM+haKwdqT7
         NnQ9ywz/lEUE6TaIz2KaFIiZaa4hiunip7QkDkwdw2oUDQtlPB09QIJ8GjNt4drfDmq0
         oev/cPiCib6LG29LI8fTnZwYsuoKnV/h9y8xDrQLBR+Y9wMpmDM44lNN+WvQcle9ounf
         N4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709892720; x=1710497520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9SgGDjTSQoEN/9LevpE3gCXBJ1egZW+GlFcG8/AMFY=;
        b=n/VewzCfw5MH6KXaMk9Zc2Yx2PVuzYBStzl4uIr37ZxQSyGMtfaQ/wrVpxMkSMGD+g
         xQyjM9l4Y7UVO6OsaUqD3qf+TWfYoZLducTPA6wqgfMWWDuJ7VsxnJJLOHYfpiZoApy5
         HIOFyi7Z/iC4M7NI2rACIzOq/QpXzeengLYMdEk/GyTtG2XanRZFTXyMaV2IXDbKUZc6
         2ti7r9OPZZp0q4dElt4jCiwPy2zNH0xvdqt4Rg3zfSEZ+wtThmfUOktIDn7rdcVA/LPG
         RyskNQyfe28w0HX27Dxjunh4OytWa84xVlDwz0D5Z3PFcFOSb9kNoEskMGRq7zztCCwS
         Y7TA==
X-Forwarded-Encrypted: i=1; AJvYcCVoc+Z2qQEvfPBA4euDuzYfs3OUxbF5P9Zm9CBl20Z8tCwKmgoV/PPsUEcL1Pq38Dat6+CJMQhbTswSvDWXbUnpDuUPn3i888oPZzjt
X-Gm-Message-State: AOJu0YxdlrGfkn+x8LFrUzQUjt66Vv5v70nNX1nQ2JRFFt0bWf+cLeJA
	5dBAw/XmMWfvaW4+An+KnbCi+6+6M6Qh7emYrIuT+RJEm6Bl+rRH
X-Google-Smtp-Source: AGHT+IG+KznqAPTfvHh6FLf/kewNkFBSGCBBUpQgAe9jHTYhYvjUwa+3qYC3NEoGkuHulCC0sf1Ksg==
X-Received: by 2002:ac2:4e93:0:b0:513:5e5c:d4ec with SMTP id o19-20020ac24e93000000b005135e5cd4ecmr2501888lfr.69.1709892720290;
        Fri, 08 Mar 2024 02:12:00 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b00412f12f00adsm5456999wmo.10.2024.03.08.02.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 02:11:59 -0800 (PST)
Message-ID: <b1f8dedf-e671-464d-9087-483e46bbd462@gmail.com>
Date: Fri, 8 Mar 2024 11:11:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: add vm fault information to
 devcoredump
Content-Language: en-US
To: "Khatri, Sunil" <sukhatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mukul Joshi <mukul.joshi@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
References: <20240307205054.3904657-1-sunil.khatri@amd.com>
 <20240307205054.3904657-3-sunil.khatri@amd.com>
 <ab7c8dde-c914-4e07-a95a-126976917416@amd.com>
 <83c46d51-7d4c-4a2f-b34e-8b6700a5fca7@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <83c46d51-7d4c-4a2f-b34e-8b6700a5fca7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.03.24 um 10:16 schrieb Khatri, Sunil:
>
> On 3/8/2024 2:39 PM, Christian König wrote:
>> Am 07.03.24 um 21:50 schrieb Sunil Khatri:
>>> Add page fault information to the devcoredump.
>>>
>>> Output of devcoredump:
>>> **** AMDGPU Device Coredump ****
>>> version: 1
>>> kernel: 6.7.0-amd-staging-drm-next
>>> module: amdgpu
>>> time: 29.725011811
>>> process_name: soft_recovery_p PID: 1720
>>>
>>> Ring timed out details
>>> IP Type: 0 Ring Name: gfx_0.0.0
>>>
>>> [gfxhub] Page fault observed
>>> Faulty page starting at address: 0x0000000000000000
>>> Protection fault status register: 0x301031
>>>
>>> VRAM is lost due to GPU reset!
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 14 +++++++++++++-
>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> index 147100c27c2d..8794a3c21176 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> @@ -203,8 +203,20 @@ amdgpu_devcoredump_read(char *buffer, loff_t 
>>> offset, size_t count,
>>>                  coredump->ring->name);
>>>       }
>>>   +    if (coredump->adev) {
>>> +        struct amdgpu_vm_fault_info *fault_info =
>>> +            &coredump->adev->vm_manager.fault_info;
>>> +
>>> +        drm_printf(&p, "\n[%s] Page fault observed\n",
>>> +               fault_info->vmhub ? "mmhub" : "gfxhub");
>>> +        drm_printf(&p, "Faulty page starting at address: 0x%016llx\n",
>>> +               fault_info->addr);
>>> +        drm_printf(&p, "Protection fault status register: 0x%x\n",
>>> +               fault_info->status);
>>> +    }
>>> +
>>>       if (coredump->reset_vram_lost)
>>> -        drm_printf(&p, "VRAM is lost due to GPU reset!\n");
>>> +        drm_printf(&p, "\nVRAM is lost due to GPU reset!\n");
>>
>> Why this additional new line?
> The intent is the devcoredump have different sections clearly 
> demarcated with an new line else "VRAM is lost due to GPU reset!" 
> seems part of the page fault information.
> [gfxhub] Page fault observed
> Faulty page starting at address: 0x0000000000000000
> Protection fault status register: 0x301031
>
> VRAM is lost due to GPU reset!

In that case I would print the newline independent if VRAM is lost or 
not. Otherwise you get:

Protection fault status register:...

VRAM is lost due to GPU reset!
AMDGPU register dumps:

In one case and:


Protection fault status register:...
AMDGPU register dumps:

In the other case which breaks this sectioning quite a bit.

Regards,
Christian.

>
> Regards
> Sunil
>
>>
>> Apart from that looks really good to me.
>>
>> Regards,
>> Christian.
>>
>>>       if (coredump->adev->reset_info.num_regs) {
>>>           drm_printf(&p, "AMDGPU register dumps:\nOffset:     
>>> Value:\n");
>>


