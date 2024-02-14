Return-Path: <linux-kernel+bounces-64598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C3C8540B4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005DC1F2A1CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4810F2;
	Wed, 14 Feb 2024 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8ip9JAz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8EE7F;
	Wed, 14 Feb 2024 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869386; cv=none; b=B6vJFaHITaEd9JcrcIl1o15m3nLWbqRZ8YHVMrzWWnry/DIArfMD6tCA5lDtFkBW2zi+t11sVeYJPbqGGy5m4R8eily5+CFsS/MhwthZLu2iitoRHaHgxj/UoOANGikeKSCMhUcCLPPqeo6rHHl1NJkGcVLCVX3HAGXIrP8akOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869386; c=relaxed/simple;
	bh=XGF57pUD1lmuUaWsfaETEZITZpWlnPt6/M5D/Up5LbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XL1V2jVmbJDT3VNQJyHvr/MIKAvrpJ7NiEEr/1H+D2g/kgsbza6d3+OdPebwHuC4UjftFjSYqcp99HnH/htXKNB9FzoMHb9WRipVJR7Ez1UugwnL1B2sZsPH6kVaZVAO03g6SUjaAsYHEMsQPoIkL7ybOWK/7wGr/OLF97hTj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8ip9JAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D763C433F1;
	Wed, 14 Feb 2024 00:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707869385;
	bh=XGF57pUD1lmuUaWsfaETEZITZpWlnPt6/M5D/Up5LbA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u8ip9JAzdkIcb3TcwM4qD6FbBawPsJw72koMHQp1u7S4tNYyLTRQB0eNhsHVSk8eb
	 W5oUtVrmvtvKyPyQK35+cerSuRnZf/dTlBVNA2p1MVx1L+3gWUsOkbk/7+D0L7+M7N
	 CnltdzI+S6AcX/5C+SIf50NxayQqOjHoibccvFlt+7QdFhHafx2O5qClqlK0eEJ1vm
	 4La/59C03Eu6OUgg3G6Cv0dlg8HVkan5E1DVjKzsCbk+q3G3Sdot5gWDYNQ+RcJh55
	 ClbpjD8LQAskSSvGe4yi9N40hIy4R/Le977Xey4yYkTk+U9T6KqTUICx0fmqdGx59C
	 nhvvteXWkh5YQ==
Message-ID: <e2d6dded-dea6-4832-ba16-6a97e3060992@kernel.org>
Date: Wed, 14 Feb 2024 09:09:42 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: asm1064: correct count of reported ports
To: Niklas Cassel <cassel@kernel.org>, Andrey Melnikov <temnota.am@gmail.com>
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com
References: <vbpzr7uqpfemb3qa6xy2fxioct44l5vugg2wkywyolfpzqcmau@jgrrhmk2scaj>
 <7559d940-f191-4fe0-e147-17ffa6c1dfc4@gmail.com>
 <CA+PODjpOE=LGPi1G1ebvEwGeXAfpuZ+s_k4uMUwu3i6st9y--g@mail.gmail.com>
 <Zcukjucb4VEbKK9x@x1-carbon> <Zcuvbzoo7/7c/F1q@x1-carbon>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Zcuvbzoo7/7c/F1q@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/24 03:05, Niklas Cassel wrote:
> On Tue, Feb 13, 2024 at 06:19:10PM +0100, Niklas Cassel wrote:
>> On Thu, Feb 08, 2024 at 10:27:11AM +0300, Andrey Melnikov wrote:
>>>> On 2/7/24 12:58 PM, Andrey Jr. Melnikov wrote:
>>>>
>>>>> The ASM1064 SATA host controller always reports wrongly,
>>>>> that it has 24 ports. But in reality, it only has four ports.
>>>>>
>>>>> before:
>>>>> ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
>>>>> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
>>>>> ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst
>>>>>
>>>>> after:
>>>>> ahci 0000:04:00.0: ASM1064 has only four ports
>>>>> ahci 0000:04:00.0: forcing port_map 0xffff0f -> 0xf
>>>>> ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
>>>>> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode
>>>>> ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst
>>>>>
>>>>>
>>>>> Signed-off-by: Andrey Jr. Melnikov <temnota.am@gmail.com>
>>>>>
>>>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>>>> index da2e74fce2d9..ec30d8330d16 100644
>>>>> --- a/drivers/ata/ahci.c
>>>>> +++ b/drivers/ata/ahci.c
>>>>> @@ -671,9 +671,14 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
>>>>>  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>>>>>                                        struct ahci_host_priv *hpriv)
>>>>>  {
>>>>> -     if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
>>>>> -             dev_info(&pdev->dev, "ASM1166 has only six ports\n");
>>>>> -             hpriv->saved_port_map = 0x3f;
>>>>> +     if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
>>>>> +             if (pdev->device == 0x1166) {
>>>>
>>>>    Maybe *switch* instead?
>>>
>>> Ok.
>>
>> Hello Andrey,
>>
>> do you intend to send out a v2 that uses a switch instead?
>>
>> And perhaps take Damien's patch as patch 1/2
>> (with Suggested-by: Damien ... of course),
>> so that the before/after print in your commit message shows
>> the override value.
> 
> On second thought, just go ahead and respin your patch using a switch,
> as I don't think Damien's patch is fully correct.
> 
> He suggested to use hpriv->saved_port_map.
> 
> However, that will show the wrong result for platforms using
> hpriv->mask_port_map.
> 
> As when hpriv->mask_port_map is used, saved_port_map is not set:
> https://github.com/torvalds/linux/blob/v6.8-rc4/drivers/ata/libahci.c#L536-L548
> 
> However, the local variable "port_map" is updated for both
> saved_port_map and mask_port_map cases.
> 
> And then at the end:
> hpriv->port_map = port_map;
> https://github.com/torvalds/linux/blob/v6.8-rc4/drivers/ata/libahci.c#L597
> 
> So I think we should print hpriv->port_map,
> and not hpriv->saved_port_map.

Indeed, good catch...

> However.. hpriv->port_map is already printed:
> https://github.com/torvalds/linux/blob/v6.8-rc4/drivers/ata/libahci.c#L2617
> in the "0x%x impl" print.
> 
> So
>> before:
>> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
> 
>> after:
>> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode
> 
> Actually prints the number of *implemented* ports.
> 
> 
> I have to admit that this is a bit confusing.
> 
> Personally I would have preferred if we simply printed
> "%u ports", hpriv->port_map,
> 
> and simply dropped the "0x%x impl" part of the print,
> but I'm a bit worried that someone parses this print from user space,
> but I guess we must be allowed to improve prints if they are confusing.
> 
> Damien, what do you think?

..but port_map is a mask, not a count of ports. So this would still be wrong.
I think we simply need a small helper that look something like:

int ahci_nr_ports(struct ata_host *host)
{
        struct ahci_host_priv *hpriv = host->private_data;
	int i, n = 0;

	for_each_set_bit(i, &hpriv->port_map, AHCI_MAX_PORTS)
		n++;

	return n;
}

and print that instead together with the mask.

-- 
Damien Le Moal
Western Digital Research


