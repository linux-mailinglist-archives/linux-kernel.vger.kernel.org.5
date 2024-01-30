Return-Path: <linux-kernel+bounces-44601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AB48424E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A884F1C237B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C8567E97;
	Tue, 30 Jan 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/iuWvou"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9B76A006;
	Tue, 30 Jan 2024 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617597; cv=none; b=MXZsXK1TawrrPjOxXDjVR1HDZIvM0/Pn6RD/THQ7ALDax94/xaEAwDo08YC8or2WEIobU19shSlJr+eBrvZ8b0cytUWM8ihARGnSNgyt7Y0l+6m3PzShzMhKBzG8z6meFLbS1Pno1MDs5DjcKzx2bd5nysEph1hELTgIDbRBffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617597; c=relaxed/simple;
	bh=pMHAd/MSWd3d0LOHEUFPp259bp/dNc4+vR9bQ1FB1qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+xTsBgKA+7petmj0PGXXerhhCE3JY2bgu0gxW+VgeRh35KexuIH/7b5z+STO6CK4w0ryYJdo1Vw90IKcTR4AYKhGSWzYteAyrx1F1P4dCeN31Zj+FFY80M8Ake9H/zPV4l5PP+Z6OCXlO7khaj+q9FVPBMUv6T/u1+f3QTt93g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/iuWvou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9578BC433F1;
	Tue, 30 Jan 2024 12:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706617596;
	bh=pMHAd/MSWd3d0LOHEUFPp259bp/dNc4+vR9bQ1FB1qg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P/iuWvoupx0VYnvbBZVrrxx3EQ0Rh7GxRWlmLLWgpGYMzobnH+UCYgroT9IR1JR/t
	 TxwJVnskRUQzXZNwh1g+4lO3L2Cw9Vwk1R5vO9rAs8Z3WEDuyyaU0bRIJpl9jGk9tG
	 pbW7NaDaOfS+Di+zLJ5Lf0Jns0fxmxocSYsuBhcqXSrfN1HWbevtQLzevhF8NgnE4i
	 j4N4nR7I80HgU24AMDD3dA3FLhqBDrxrnE4veDOABHIICIuSphjCWmvlnd4qd6+ngl
	 a8ytIykDVuIWnvNPLLVQpoauR9taqftzrFy+tz7VLSraWoScoteyzVbP71wl9W98jh
	 q+HAEzEUgoOIw==
Message-ID: <2d111b04-4307-4f47-b3a4-208f571d04a8@kernel.org>
Date: Tue, 30 Jan 2024 21:26:32 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: Extend ASM1061 43-bit DMA address quirk to other
 ASM106x parts
Content-Language: en-US
To: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 John Garry <john.g.garry@oracle.com>, Joerg Roedel <jroedel@suse.de>,
 Szuying Chen <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
 Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
References: <ZbjgTmR5FbAnb-Ua@wantstofly.org>
 <6ab581f1-385c-49af-bff3-aacd1cdbe1d8@kernel.org>
 <ZbjkoKotLvDSeJTA@wantstofly.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZbjkoKotLvDSeJTA@wantstofly.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/24 20:59, Lennert Buytenhek wrote:
> On Tue, Jan 30, 2024 at 08:46:23PM +0900, Damien Le Moal wrote:
> 
>>> ASMedia have confirmed that all ASM106x parts currently listed in
>>> ahci_pci_tbl[] suffer from the 43-bit DMA address limitation that we ran
>>> into on the ASM1061, and therefore, we need to apply the quirk added by
>>> commit 20730e9b2778 to the other supported ASM106x parts as well.
>>>
>>> Signed-off-by: Lennert Buytenhek <kernel@wantstofly.org>
>>
>> I think this needs a cc: stable tag.
> 
> The commit that is likely responsible for surfacing this issue is
> 791c2b17fb40 which went into v6.6 -- so would this then be appropriate,
> or do you think this should be backported to older versions as well?

Hmmm... given this is a hardware "bug", it seems safer to backport to all stable
& lts. From what I understand, the device may be doing bad DMA, regardless of
what the iommu is doing. Niklas ? you followed this more carefully than I did :)

> 
> Cc: stable@vger.kernel.org # 6.6.x
> 
> 
>>> ---
>>>  drivers/ata/ahci.c | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>> index d2460fa985b7..da2e74fce2d9 100644
>>> --- a/drivers/ata/ahci.c
>>> +++ b/drivers/ata/ahci.c
>>> @@ -606,13 +606,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>>>  	{ PCI_VDEVICE(PROMISE, 0x3781), board_ahci },   /* FastTrak TX8660 ahci-mode */
>>>  
>>>  	/* ASMedia */
>>> -	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
>>> -	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
>>> +	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci_43bit_dma },	/* ASM1060 */
>>> +	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci_43bit_dma },	/* ASM1060 */
>>>  	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci_43bit_dma },	/* ASM1061 */
>>>  	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci_43bit_dma },	/* ASM1061/1062 */
>>> -	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
>>> -	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
>>> -	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
>>> +	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci_43bit_dma },	/* ASM1061R */
>>> +	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci_43bit_dma },	/* ASM1062R */
>>> +	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci_43bit_dma },	/* ASM1062+JMB575 */
>>>  	{ PCI_VDEVICE(ASMEDIA, 0x1062), board_ahci },	/* ASM1062A */
>>>  	{ PCI_VDEVICE(ASMEDIA, 0x1064), board_ahci },	/* ASM1064 */
>>>  	{ PCI_VDEVICE(ASMEDIA, 0x1164), board_ahci },   /* ASM1164 */

-- 
Damien Le Moal
Western Digital Research


