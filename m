Return-Path: <linux-kernel+bounces-135445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBACE89C2D8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3771C21FE0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87291126F2C;
	Mon,  8 Apr 2024 13:30:24 +0000 (UTC)
Received: from hs01.dakr.org (hs01.dk-develop.de [173.249.23.66])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B88626A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.23.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583024; cv=none; b=iBllGogisEmrxggH5nvFuWmyT/pHcClOHlyatvmPe9MgGm26dzPm9P2iEWbowuvhyyAXr0MtOA8LZw/Z+yZmzjdbCxg8QPoB6sIzLeQ+BMBeCyy0oJFuVMdYwMDnDmo3n+bHsPiEtf6+fpY2rMeeH3kUX5IxLcuxgiKVrXZKC0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583024; c=relaxed/simple;
	bh=cGUqL3dbHW3ADn/GybUgK13ip099GPc1dhi810EXzyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acwtsLfGMhivgexOkWwSAe4o1D2liKn5xexRsFo44DzM7DPepAt6YH79agaDwDmZBBw7/O6shrHf1ziFGIIBW9gi/JmmTBb8IKRPCyxSM6mTONRctPhcGHSwPuqbbRR5SaRKWpJQ+TKDGHWsicLZYBumfUp/pKItfDdHVPJS3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org; spf=pass smtp.mailfrom=dakr.org; arc=none smtp.client-ip=173.249.23.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dakr.org
Message-ID: <03263130-0627-45c4-ab14-aa0e3b597442@dakr.org>
Date: Mon, 8 Apr 2024 15:23:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm: nv04: Add check to avoid out of bounds access
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@redhat.com>,
 Mikhail Kobuk <m.kobuk@ispras.ru>, Karol Herbst <kherbst@redhat.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Francisco Jerez <currojerez@riseup.net>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Fedor Pchelkin <pchelkin@ispras.ru>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>
References: <20240331064552.6112-1-m.kobuk@ispras.ru>
 <c3253f8a-e654-4016-b0c6-d92703107c48@redhat.com>
 <11096e558e67f2fea2aee976c70a19af1b7c212b.camel@redhat.com>
Content-Language: en-US
From: Danilo Krummrich <me@dakr.org>
In-Reply-To: <11096e558e67f2fea2aee976c70a19af1b7c212b.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/5/24 22:05, Lyude Paul wrote:
> On Fri, 2024-04-05 at 17:53 +0200, Danilo Krummrich wrote:
>> On 3/31/24 08:45, Mikhail Kobuk wrote:
>>> Output Resource (dcb->or) value is not guaranteed to be non-zero
>>> (i.e.
>>> in drivers/gpu/drm/nouveau/nouveau_bios.c, in
>>> 'fabricate_dcb_encoder_table()'
>>> 'dcb->or' is assigned value '0' in call to
>>> 'fabricate_dcb_output()').
>>
>> I don't really know much about the semantics of this code.
>>
>> Looking at fabricate_dcb_output() though I wonder if the intention
>> was to assign
>> BIT(or) to entry->or.
>>
>> @Lyude, can you help here?
> 
> This code is definitely a bit before my time as well - but I think
> you're completely correct. Especially considering this bit I found in
> nouveau_bios.h:

Thanks for confirming.

@Mikhail, I think we should rather fix this assignment then.

- Danilo

> 
> enum nouveau_or {
> 	DCB_OUTPUT_A = (1 << 0),
> 	DCB_OUTPUT_B = (1 << 1),
> 	DCB_OUTPUT_C = (1 << 2)
> };
> 
> 
>>
>> Otherwise, for parsing the DCB entries, it seems that the bound
>> checks are
>> happening in olddcb_outp_foreach() [1].
>>
>> [1]
>> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/nouveau/nouveau_bios.c#L1331
>>
>>>
>>> Add check to validate 'dcb->or' before it's used.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Fixes: 2e5702aff395 ("drm/nouveau: fabricate DCB encoder table for
>>> iMac G4")
>>> Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
>>> ---
>>>    drivers/gpu/drm/nouveau/dispnv04/dac.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/nouveau/dispnv04/dac.c
>>> b/drivers/gpu/drm/nouveau/dispnv04/dac.c
>>> index d6b8e0cce2ac..0c8d4fc95ff3 100644
>>> --- a/drivers/gpu/drm/nouveau/dispnv04/dac.c
>>> +++ b/drivers/gpu/drm/nouveau/dispnv04/dac.c
>>> @@ -428,7 +428,7 @@ void nv04_dac_update_dacclk(struct drm_encoder
>>> *encoder, bool enable)
>>>    	struct drm_device *dev = encoder->dev;
>>>    	struct dcb_output *dcb = nouveau_encoder(encoder)->dcb;
>>>    
>>> -	if (nv_gf4_disp_arch(dev)) {
>>> +	if (nv_gf4_disp_arch(dev) && ffs(dcb->or)) {
>>>    		uint32_t *dac_users = &nv04_display(dev)-
>>>> dac_users[ffs(dcb->or) - 1];
>>>    		int dacclk_off = NV_PRAMDAC_DACCLK +
>>> nv04_dac_output_offset(encoder);
>>>    		uint32_t dacclk = NVReadRAMDAC(dev, 0,
>>> dacclk_off);
>>> @@ -453,7 +453,7 @@ bool nv04_dac_in_use(struct drm_encoder
>>> *encoder)
>>>    	struct drm_device *dev = encoder->dev;
>>>    	struct dcb_output *dcb = nouveau_encoder(encoder)->dcb;
>>>    
>>> -	return nv_gf4_disp_arch(encoder->dev) &&
>>> +	return nv_gf4_disp_arch(encoder->dev) && ffs(dcb->or) &&
>>>    		(nv04_display(dev)->dac_users[ffs(dcb->or) - 1] &
>>> ~(1 << dcb->index));
>>>    }
>>>    
>>
> 

