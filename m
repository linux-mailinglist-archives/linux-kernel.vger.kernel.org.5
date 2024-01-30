Return-Path: <linux-kernel+bounces-44609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2098424FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCE31C249DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9964D67E7F;
	Tue, 30 Jan 2024 12:34:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A559B7C;
	Tue, 30 Jan 2024 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618097; cv=none; b=QexkGDChVZ9yUakbQOM2HPa3KLWM9aJ4ZTKZPCqUdly1crFK2IZ7xFl5A/edBoTl3ttkt5G6pd38UOPxX6IoC1GT1p1Hwg+dVJxJf4X/lFd1vqPokZdwiWYd+zuX/gCnoONK6elbu/BBZ7GkHBMNlH/sUoDB+Tm+U8YP/n0nOAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618097; c=relaxed/simple;
	bh=t4hqisE3jfM30+5mrq1KKlVdDbamtBqnVOk2QxszE1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVENzRWDwZlYMvCY2pW1hvK8Wg7w13ivn2GYPbfqgqVzisIdI5H+7VdFBO1579ZpjwAIC5fNqjiWo5oeEM70/4MORq30lI7MXNV7dIbD+MM1TxgBcTGKKC3Y2hrRup1YHRAaS9vNu2+m8iJE+qPvTfNlm8N0SNDB0Kq35lZ4z5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6831BDA7;
	Tue, 30 Jan 2024 04:35:37 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FEAE3F762;
	Tue, 30 Jan 2024 04:34:52 -0800 (PST)
Message-ID: <c2b85e83-08ac-42cc-9924-bc6ba115b24d@arm.com>
Date: Tue, 30 Jan 2024 12:34:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: Extend ASM1061 43-bit DMA address quirk to other
 ASM106x parts
To: Damien Le Moal <dlemoal@kernel.org>,
 Lennert Buytenhek <kernel@wantstofly.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Joerg Roedel <jroedel@suse.de>, Szuying Chen <chensiying21@gmail.com>,
 Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
 Chloe_Chen@asmedia.com.tw
References: <ZbjgTmR5FbAnb-Ua@wantstofly.org>
 <6ab581f1-385c-49af-bff3-aacd1cdbe1d8@kernel.org>
 <ZbjkoKotLvDSeJTA@wantstofly.org>
 <2d111b04-4307-4f47-b3a4-208f571d04a8@kernel.org>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <2d111b04-4307-4f47-b3a4-208f571d04a8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/01/2024 12:26 pm, Damien Le Moal wrote:
> On 1/30/24 20:59, Lennert Buytenhek wrote:
>> On Tue, Jan 30, 2024 at 08:46:23PM +0900, Damien Le Moal wrote:
>>
>>>> ASMedia have confirmed that all ASM106x parts currently listed in
>>>> ahci_pci_tbl[] suffer from the 43-bit DMA address limitation that we ran
>>>> into on the ASM1061, and therefore, we need to apply the quirk added by
>>>> commit 20730e9b2778 to the other supported ASM106x parts as well.
>>>>
>>>> Signed-off-by: Lennert Buytenhek <kernel@wantstofly.org>
>>>
>>> I think this needs a cc: stable tag.
>>
>> The commit that is likely responsible for surfacing this issue is
>> 791c2b17fb40 which went into v6.6 -- so would this then be appropriate,
>> or do you think this should be backported to older versions as well?
> 
> Hmmm... given this is a hardware "bug", it seems safer to backport to all stable
> & lts. From what I understand, the device may be doing bad DMA, regardless of
> what the iommu is doing. Niklas ? you followed this more carefully than I did :)

Yes, that would be the case; in practice though it's likely that people 
just don't tend to use these particular controllers in big systems which 
actually have RAM at >43-bit physical addresses.

Thanks,
Robin.

> 
>>
>> Cc: stable@vger.kernel.org # 6.6.x
>>
>>
>>>> ---
>>>>   drivers/ata/ahci.c | 10 +++++-----
>>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>>> index d2460fa985b7..da2e74fce2d9 100644
>>>> --- a/drivers/ata/ahci.c
>>>> +++ b/drivers/ata/ahci.c
>>>> @@ -606,13 +606,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>>>>   	{ PCI_VDEVICE(PROMISE, 0x3781), board_ahci },   /* FastTrak TX8660 ahci-mode */
>>>>   
>>>>   	/* ASMedia */
>>>> -	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
>>>> -	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
>>>> +	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci_43bit_dma },	/* ASM1060 */
>>>> +	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci_43bit_dma },	/* ASM1060 */
>>>>   	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci_43bit_dma },	/* ASM1061 */
>>>>   	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci_43bit_dma },	/* ASM1061/1062 */
>>>> -	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
>>>> -	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
>>>> -	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
>>>> +	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci_43bit_dma },	/* ASM1061R */
>>>> +	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci_43bit_dma },	/* ASM1062R */
>>>> +	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci_43bit_dma },	/* ASM1062+JMB575 */
>>>>   	{ PCI_VDEVICE(ASMEDIA, 0x1062), board_ahci },	/* ASM1062A */
>>>>   	{ PCI_VDEVICE(ASMEDIA, 0x1064), board_ahci },	/* ASM1064 */
>>>>   	{ PCI_VDEVICE(ASMEDIA, 0x1164), board_ahci },   /* ASM1164 */
> 

