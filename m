Return-Path: <linux-kernel+bounces-138904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B343889FBD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6931C286B32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F22816F0D7;
	Wed, 10 Apr 2024 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="bN8ChonH"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5171616EC0A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763563; cv=none; b=hQP52k8TU4PM47HcrmI4dT9iLlqeDGBRAtfDHSR4PsBFTYQjlPyaGvGAg5IpAXuxYqhUXV5Bwlh9quKa3nQHNsS8RTjKn5DM9jvsJXJBgarCJF77A9RqPFTrfQpvTXh8K701llmuwAHMh7ab9+/EcqpZoSRcmbZPhE2wXqRCs5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763563; c=relaxed/simple;
	bh=J5i0P57U+M8dP0G/2Bi2j2gHHivdCiV8f5CuWF3i7vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbMp91IPdl8UW+iUHof9pQhHzScRfGUkzYgqKKPzA9rMtdHwx5xXWZkFBlCoqQ6pEzzrquSt0WgtfP4mPKgV56Q767iIg06UT1gEpxfbq36xLM1TWEKI00fHdN54vwvcHiJuE3Xm03ATFqEe7A9Tkjg+Za2Uvez1lyxiwLO2Ypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=bN8ChonH; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from [10.240.168.185] (unknown [178.176.73.225])
	by mail.ispras.ru (Postfix) with ESMTPSA id 841D74076735;
	Wed, 10 Apr 2024 15:39:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 841D74076735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1712763550;
	bh=xQKnhyAxfz2O94v4XYI3za4g+mMCNJTNwLCL1CPF8Ok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bN8ChonH1inQLvXBDq36U8i+WC0O2pHHPJZfyfYM7wlLgdot/eojoCS4wURkL4Ebp
	 tDwbqg7+qnK6nKWLjpgvGHTY22886SDRtiz2SjKSQ8nmLLU5VYHo63IP+yAbAKze0+
	 4b2lbeBNkcT9LGmUJGit/D/YIpEXp+TIZ9uEcCI4=
Message-ID: <624ee851-162b-4490-8444-0d9e06b5863b@ispras.ru>
Date: Wed, 10 Apr 2024 18:39:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: nv04: Add check to avoid out of bounds access
To: Danilo Krummrich <me@dakr.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@redhat.com>, Karol Herbst <kherbst@redhat.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Francisco Jerez <currojerez@riseup.net>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Fedor Pchelkin <pchelkin@ispras.ru>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>
References: <20240331064552.6112-1-m.kobuk@ispras.ru>
 <c3253f8a-e654-4016-b0c6-d92703107c48@redhat.com>
 <11096e558e67f2fea2aee976c70a19af1b7c212b.camel@redhat.com>
 <03263130-0627-45c4-ab14-aa0e3b597442@dakr.org>
Content-Language: en-US
From: Mikhail Kobuk <m.kobuk@ispras.ru>
In-Reply-To: <03263130-0627-45c4-ab14-aa0e3b597442@dakr.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/04/2024 16:23, Danilo Krummrich wrote:
> On 4/5/24 22:05, Lyude Paul wrote:
>> On Fri, 2024-04-05 at 17:53 +0200, Danilo Krummrich wrote:
>>> On 3/31/24 08:45, Mikhail Kobuk wrote:
>>>> Output Resource (dcb->or) value is not guaranteed to be non-zero
>>>> (i.e.
>>>> in drivers/gpu/drm/nouveau/nouveau_bios.c, in
>>>> 'fabricate_dcb_encoder_table()'
>>>> 'dcb->or' is assigned value '0' in call to
>>>> 'fabricate_dcb_output()').
>>>
>>> I don't really know much about the semantics of this code.
>>>
>>> Looking at fabricate_dcb_output() though I wonder if the intention
>>> was to assign
>>> BIT(or) to entry->or.
>>>
>>> @Lyude, can you help here?
>> 
>> This code is definitely a bit before my time as well - but I think
>> you're completely correct. Especially considering this bit I found in
>> nouveau_bios.h:
> 
> Thanks for confirming.
> 
> @Mikhail, I think we should rather fix this assignment then.

Thank you all for a thorough look!

> 
> - Danilo
> 
>> 
>> enum nouveau_or {
>> 	DCB_OUTPUT_A = (1 << 0),
>> 	DCB_OUTPUT_B = (1 << 1),
>> 	DCB_OUTPUT_C = (1 << 2)
>> };
>> 
>> 

Considering this code bit, and the fact that fabricate_dcb_output() is 
called in drivers/gpu/drm/nouveau/nouveau_bios.c only, there's option to 
adjust function calls instead of adding BIT(or), i.e.:

fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 0, all_heads, DCB_OUTPUT_B);

instead of current:

fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 0, all_heads, 1);

and etc.

Should I make a new patch with adjusted calls or stick with BIT(or)?

>>>
>>> Otherwise, for parsing the DCB entries, it seems that the bound
>>> checks are
>>> happening in olddcb_outp_foreach() [1].
>>>
>>> [1]
>>> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/nouveau/nouveau_bios.c#L1331
>>>
>>>>
>>>> Add check to validate 'dcb->or' before it's used.
>>>>
>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>
>>>> Fixes: 2e5702aff395 ("drm/nouveau: fabricate DCB encoder table for
>>>> iMac G4")
>>>> Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
>>>> ---
>>>>    drivers/gpu/drm/nouveau/dispnv04/dac.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/nouveau/dispnv04/dac.c
>>>> b/drivers/gpu/drm/nouveau/dispnv04/dac.c
>>>> index d6b8e0cce2ac..0c8d4fc95ff3 100644
>>>> --- a/drivers/gpu/drm/nouveau/dispnv04/dac.c
>>>> +++ b/drivers/gpu/drm/nouveau/dispnv04/dac.c
>>>> @@ -428,7 +428,7 @@ void nv04_dac_update_dacclk(struct drm_encoder
>>>> *encoder, bool enable)
>>>>    	struct drm_device *dev = encoder->dev;
>>>>    	struct dcb_output *dcb = nouveau_encoder(encoder)->dcb;
>>>>    
>>>> -	if (nv_gf4_disp_arch(dev)) {
>>>> +	if (nv_gf4_disp_arch(dev) && ffs(dcb->or)) {
>>>>    		uint32_t *dac_users = &nv04_display(dev)-
>>>>> dac_users[ffs(dcb->or) - 1];
>>>>    		int dacclk_off = NV_PRAMDAC_DACCLK +
>>>> nv04_dac_output_offset(encoder);
>>>>    		uint32_t dacclk = NVReadRAMDAC(dev, 0,
>>>> dacclk_off);
>>>> @@ -453,7 +453,7 @@ bool nv04_dac_in_use(struct drm_encoder
>>>> *encoder)
>>>>    	struct drm_device *dev = encoder->dev;
>>>>    	struct dcb_output *dcb = nouveau_encoder(encoder)->dcb;
>>>>    
>>>> -	return nv_gf4_disp_arch(encoder->dev) &&
>>>> +	return nv_gf4_disp_arch(encoder->dev) && ffs(dcb->or) &&
>>>>    		(nv04_display(dev)->dac_users[ffs(dcb->or) - 1] &
>>>> ~(1 << dcb->index));
>>>>    }
>>>>    
>>>
>> 


