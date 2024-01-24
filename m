Return-Path: <linux-kernel+bounces-37314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD65383AE23
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7C21C24365
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8957D7CF1A;
	Wed, 24 Jan 2024 16:14:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344BF7CF03;
	Wed, 24 Jan 2024 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112889; cv=none; b=D1upao8EZxYybuYv8tuv4fn8b/w6+LTz9+G6MCjulu2P198O0eJOVfEwQOEajafi8PlwbZDa/pCMOXljI+im5vXUdKq7vlf5YUfPBpV2U0brTMU1XGqesIoC/VET5oMD3FJU31scr0pMWG03vJwf5eaUUX0yjoH6XnQ+ImhgXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112889; c=relaxed/simple;
	bh=q1Hn7Di1un3vGjw/pWuBZtI2ypUfglqG7TORIqEdXJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0MLAzho3nc2mj9tUvhYWFx3mGPPv8JBOKPu2eE/SqV3Trt02/sA/Hmk8r5uifs1kRCRIrx7XOW5pDl5FXhFzc+5ZbADy4r9bd59/LGUXT9WEAZfb3MeipaL+f6TdcxAlV6o6Vo8uLSNOHFANmcuArcfVFHJZT8NCzg1tghu3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D5001FB;
	Wed, 24 Jan 2024 08:15:31 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB4743F762;
	Wed, 24 Jan 2024 08:14:45 -0800 (PST)
Message-ID: <83a89509-42cb-4915-94dc-a2b9d5a63311@arm.com>
Date: Wed, 24 Jan 2024 16:14:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ASMedia ASM1062 (AHCI) hang after "ahci 0000:28:00.0: Using
 64-bit DMA addresses"
Content-Language: en-GB
To: Lennert Buytenhek <kernel@wantstofly.org>, Niklas Cassel <nks@flawful.org>
Cc: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZaZ2PIpEId-rl6jv@wantstofly.org> <ZaaQpiW3OOZTSyXw@x1-carbon>
 <ZahDNr97MSPNSHW_@wantstofly.org> <ZahaKaV1jlHQ0sUx@x1-carbon>
 <ZbAo_LqpbiGMfTtW@wantstofly.org> <ZbDjL0TDnUfzknZS@x1-carbon>
 <ZbEFU-rycTXxOtfW@wantstofly.org> <ZbEXcFJkw4zXKxqb@wantstofly.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZbEXcFJkw4zXKxqb@wantstofly.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/01/2024 1:58 pm, Lennert Buytenhek wrote:
> On Wed, Jan 24, 2024 at 02:40:51PM +0200, Lennert Buytenhek wrote:
> 
>>>> There are two ways to handle this -- either set the DMA mask for ASM106x
>>>> parts to 43 bits, or take the lazy route and just use AHCI_HFLAG_32BIT_ONLY
>>>> for these parts.  I feel that the former would be more appropriate, as
>>>> there seem to be plenty of bits beyond bit 31 that do work, but I will
>>>> defer to your judgement on this matter.  What do you think the right way
>>>> to handle this apparent hardware quirk is?
>>>
>>> I've seen something similar for NVMe, where some NVMe controllers from
>>> Amazon was violating the spec, and only supported 48-bit DMA addresses,
>>> even though NVMe spec requires you to support 64-bit DMA addresses, see:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4bdf260362b3be529d170b04662638fd6dc52241
>>>
>>> It is possible that ASMedia ASM1061 has a similar problem (but for AHCI)
>>> and only supports 43-bit DMA addresses, even though it sets AHCI CAP.S64A,
>>> which says "Indicates whether the HBA can access 64-bit data structures.".
>>>
>>> I think the best thing is to do a similar quirk, where we set the dma_mask
>>> accordingly.
>>
>> I'll give that a try.
> 
> I've sent out a patch that appears (from printk debugging) to do the
> right thing, but I haven't validated that that patch fixes the original
> issue, as the original issue is not trivial to trigger, and the hardware
> that it triggered on is currently unavailable.

The missing piece of the puzzle is that *something* has to use up all 
the available 32-bit IOVA space to make you spill over into the 64-bit 
space to begin with. It can happen just from having many large buffers 
mapped simultaneously (particularly if there are several devices in the 
same IOMMU group), or it could be that something is leaking DMA mappings 
over time.

An easy way to confirm the device behaviour should be to boot with 
"iommu.forcedac=1", then all devices will have their full DMA mask 
exercised straight away.

Cheers,
Robin.

> I've also made the quirk apply to all ASMedia ASM106x parts, because I
> expect them to be affected by the same issue, but let's see what the
> ASMedia folks have to say about that.
> 
> Thanks for your help!
> 
> 
> Kind regards,
> Lennert
> 

