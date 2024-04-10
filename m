Return-Path: <linux-kernel+bounces-138968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC14389FCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562801F22B90
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272E217A937;
	Wed, 10 Apr 2024 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdgeLxez"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C617A931
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766268; cv=none; b=OHhEyBWgm9AvVfPINA/lxMaypzC4gY/d80sM/n6skQf7ECjAfe4H9duW4c6zDF/uATXwxxE6lOmW0eTX3KHwWgGHqrPGTUQTK1PteTvcVdXWvOf0qrsPfcxbNECC2LVVKjyp2Q/9gCbGj4DgV7msG2GEra4GmzDcpiYTLBUq0dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766268; c=relaxed/simple;
	bh=nr8Iy+0ZhJ8G9Kh9PGTHX/4nkYkZYKhNpi7Ct2uRhuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbDnmRWtamu4bHd+/D+jfL6f1mFG4pjJdB6CfjlvlLA7j4P0PCtr6Yy5Rqg+IHgnx9H2EVHw0TyLgsAGJvCtJPRBhNrReDoCUbc/UaOagfjVsh5twHpXa/KcT/z3iCYBUzaT2UnM13mfNWUFPUF6JmzNESX+eY1y/hrKf+OArYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdgeLxez; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712766265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SR+1AW9M2A3GnVPo72SCiXJczoeqweAOw7eIFhYpkyg=;
	b=FdgeLxeztcl5LaYNc0AyZJ6Zwlprdg5pZgHEHH9WcPuTUDPpr3ZmQQPv/EjVQQSNJR29rf
	ShG04Sn6y2YyhKlfbGWzsSFDgQ7uBkzrGOpJN199Qlx1CFQqOVbaxrAlMv9fWOOs0iMO7j
	B4+2b5VBM37C2KnVj45EqKh00f32ZxU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-n0DR8fDDMuSsb-SVENnUSQ-1; Wed, 10 Apr 2024 12:24:24 -0400
X-MC-Unique: n0DR8fDDMuSsb-SVENnUSQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343bb240f70so3309966f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712766263; x=1713371063;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR+1AW9M2A3GnVPo72SCiXJczoeqweAOw7eIFhYpkyg=;
        b=v3bALhceehmqyroYPOgJiU4eYw0+u47YmVggxDlV5xdtY8SHfbYnjlJvY2nh2vLLOC
         iPLoWM8KqMw0ApH07WBk/MN9VpP1byf5sFduwK5Wd7Rk13ak2lAyWHwrNDzg/91TqjRU
         mSr3S2aJO2StpsrJnS2oPd0GPyJpi88q03kE8lVlpBm6/UlN7FzsCejnOrI9hkdeZ4Yj
         WnLwkbAPgPdXE+Yk7UYD+nTadDuf1/ufNxC5jeRf55iou6Zu11UJ94nLZylwHpfHhcFF
         vVdaGEpDWggUFUk/BZN2XXkSoLhW7WTf3LRyR1hC/+zwwnsPigBM6FkGY2mRV551nwEk
         woog==
X-Forwarded-Encrypted: i=1; AJvYcCWWW+RPxd0PdRqIxwSTiGaP8Lil8IpecxoJqe9VUaPx1PRPwHqUUEbMa4meCmUYZeqWqknJm5vKk+Nl4AlB6OtvrnnVIsAmJzKE1I0V
X-Gm-Message-State: AOJu0Ywlud7iaM3c2SAsEFZjypgkOj6Vtnb6EdyRYOlP3KilPagcp/Mr
	d5nfD9aCtZwkZtpe41PXG6qJdCT1P4IW50ghbscKZrbcbme/jxQdeZGOlYQnVMne///51UBUm72
	8nM9peWbSTnWr4wdWri7MYHD7ncRC/cJEANoKX79b2Tpj5bwia8nyXObgF3fqtw==
X-Received: by 2002:a5d:46c4:0:b0:343:44cd:7d1e with SMTP id g4-20020a5d46c4000000b0034344cd7d1emr118386wrs.17.1712766262835;
        Wed, 10 Apr 2024 09:24:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMW1X5i7lkXvrY5pH8/hRbgfI9LM1AIWY8oZ53l2ukbPKVk1TIMAo3XiLMuX7AI0rT7T6YFg==
X-Received: by 2002:a5d:46c4:0:b0:343:44cd:7d1e with SMTP id g4-20020a5d46c4000000b0034344cd7d1emr118363wrs.17.1712766262429;
        Wed, 10 Apr 2024 09:24:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id y13-20020a5d4acd000000b00343eac2acc4sm13444649wrs.111.2024.04.10.09.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 09:24:22 -0700 (PDT)
Message-ID: <cd044176-ebd3-4fd8-94ca-6630cd3211a8@redhat.com>
Date: Wed, 10 Apr 2024 18:24:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: nv04: Add check to avoid out of bounds access
To: Mikhail Kobuk <m.kobuk@ispras.ru>, Danilo Krummrich <me@dakr.org>,
 Lyude Paul <lyude@redhat.com>, Karol Herbst <kherbst@redhat.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Francisco Jerez <currojerez@riseup.net>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Fedor Pchelkin <pchelkin@ispras.ru>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>
References: <20240331064552.6112-1-m.kobuk@ispras.ru>
 <c3253f8a-e654-4016-b0c6-d92703107c48@redhat.com>
 <11096e558e67f2fea2aee976c70a19af1b7c212b.camel@redhat.com>
 <03263130-0627-45c4-ab14-aa0e3b597442@dakr.org>
 <624ee851-162b-4490-8444-0d9e06b5863b@ispras.ru>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <624ee851-162b-4490-8444-0d9e06b5863b@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/10/24 17:39, Mikhail Kobuk wrote:
> On 08/04/2024 16:23, Danilo Krummrich wrote:
>> On 4/5/24 22:05, Lyude Paul wrote:
>>> On Fri, 2024-04-05 at 17:53 +0200, Danilo Krummrich wrote:
>>>> On 3/31/24 08:45, Mikhail Kobuk wrote:
>>>>> Output Resource (dcb->or) value is not guaranteed to be non-zero
>>>>> (i.e.
>>>>> in drivers/gpu/drm/nouveau/nouveau_bios.c, in
>>>>> 'fabricate_dcb_encoder_table()'
>>>>> 'dcb->or' is assigned value '0' in call to
>>>>> 'fabricate_dcb_output()').
>>>>
>>>> I don't really know much about the semantics of this code.
>>>>
>>>> Looking at fabricate_dcb_output() though I wonder if the intention
>>>> was to assign
>>>> BIT(or) to entry->or.
>>>>
>>>> @Lyude, can you help here?
>>>
>>> This code is definitely a bit before my time as well - but I think
>>> you're completely correct. Especially considering this bit I found in
>>> nouveau_bios.h:
>>
>> Thanks for confirming.
>>
>> @Mikhail, I think we should rather fix this assignment then.
> 
> Thank you all for a thorough look!
> 
>>
>> - Danilo
>>
>>>
>>> enum nouveau_or {
>>>     DCB_OUTPUT_A = (1 << 0),
>>>     DCB_OUTPUT_B = (1 << 1),
>>>     DCB_OUTPUT_C = (1 << 2)
>>> };
>>>
>>>
> 
> Considering this code bit, and the fact that fabricate_dcb_output() is called in drivers/gpu/drm/nouveau/nouveau_bios.c only, there's option to adjust function calls instead of adding BIT(or), i.e.:
> 
> fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 0, all_heads, DCB_OUTPUT_B);
> 
> instead of current:
> 
> fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 0, all_heads, 1);
> 
> and etc.
> 
> Should I make a new patch with adjusted calls or stick with BIT(or)?

Please send a new patch adjusting the calls using enum nouveau_or, that
seems to be cleaner.

- Danilo

> 
>>>>
>>>> Otherwise, for parsing the DCB entries, it seems that the bound
>>>> checks are
>>>> happening in olddcb_outp_foreach() [1].
>>>>
>>>> [1]
>>>> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/nouveau/nouveau_bios.c#L1331
>>>>
>>>>>
>>>>> Add check to validate 'dcb->or' before it's used.
>>>>>
>>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>>
>>>>> Fixes: 2e5702aff395 ("drm/nouveau: fabricate DCB encoder table for
>>>>> iMac G4")
>>>>> Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
>>>>> ---
>>>>>    drivers/gpu/drm/nouveau/dispnv04/dac.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/nouveau/dispnv04/dac.c
>>>>> b/drivers/gpu/drm/nouveau/dispnv04/dac.c
>>>>> index d6b8e0cce2ac..0c8d4fc95ff3 100644
>>>>> --- a/drivers/gpu/drm/nouveau/dispnv04/dac.c
>>>>> +++ b/drivers/gpu/drm/nouveau/dispnv04/dac.c
>>>>> @@ -428,7 +428,7 @@ void nv04_dac_update_dacclk(struct drm_encoder
>>>>> *encoder, bool enable)
>>>>>        struct drm_device *dev = encoder->dev;
>>>>>        struct dcb_output *dcb = nouveau_encoder(encoder)->dcb;
>>>>> -    if (nv_gf4_disp_arch(dev)) {
>>>>> +    if (nv_gf4_disp_arch(dev) && ffs(dcb->or)) {
>>>>>            uint32_t *dac_users = &nv04_display(dev)-
>>>>>> dac_users[ffs(dcb->or) - 1];
>>>>>            int dacclk_off = NV_PRAMDAC_DACCLK +
>>>>> nv04_dac_output_offset(encoder);
>>>>>            uint32_t dacclk = NVReadRAMDAC(dev, 0,
>>>>> dacclk_off);
>>>>> @@ -453,7 +453,7 @@ bool nv04_dac_in_use(struct drm_encoder
>>>>> *encoder)
>>>>>        struct drm_device *dev = encoder->dev;
>>>>>        struct dcb_output *dcb = nouveau_encoder(encoder)->dcb;
>>>>> -    return nv_gf4_disp_arch(encoder->dev) &&
>>>>> +    return nv_gf4_disp_arch(encoder->dev) && ffs(dcb->or) &&
>>>>>            (nv04_display(dev)->dac_users[ffs(dcb->or) - 1] &
>>>>> ~(1 << dcb->index));
>>>>>    }
>>>>
>>>
> 


