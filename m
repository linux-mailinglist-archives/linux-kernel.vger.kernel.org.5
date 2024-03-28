Return-Path: <linux-kernel+bounces-123172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9228903A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF161C2E389
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B5A130A5B;
	Thu, 28 Mar 2024 15:43:30 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B3D12F360
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640609; cv=none; b=Ak3IALz+OO7TWiBzJQGSG7oVDXGIz8sCdiy96EvZIbrIqnRb8NwKFm6gZ+zmlKJJVS9YefEQWjWNZGfhMlwTXu7SYCI1lVdL/BLBMUNzDDfddFyg/WfToRuj+bUrFihJqHNt+jacRXFXl/8oqtOfnTG4UdCLj/V3QoGSBs3rA0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640609; c=relaxed/simple;
	bh=MWrmLt9ZBaAOTQ/qoTpb3c8hoHhvxgbX7gZgcqQ56Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5MQFur4yK/hpH2/Ckd8ejI1VfndAhclxbZEQ9EIpE44IVFIlEUG9PRk/6OOziSOo0OIFb4Klu/n1ok/AIDZy6RoPM8oc3ZWajAxDRiTVv1VI8yj6BiVnQKsVGP4lkIqepzp5JzJFotGqTRHFC5xI4umkOT9G5KRbeoiFayNbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9ED6240002;
	Thu, 28 Mar 2024 15:43:21 +0000 (UTC)
Message-ID: <7354b054-9eda-45a6-9503-ff30a1c9c276@ghiti.fr>
Date: Thu, 28 Mar 2024 16:43:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: T-Head: Test availability bit before enabling
 MAEE errata
Content-Language: en-US
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Heiko Stuebner <heiko@sntech.de>, Cooper Qu <cooper.qu@linux.alibaba.com>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
 Huang Tao <eric.huang@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240327103130.3651950-1-christoph.muellner@vrull.eu>
 <20240327103130.3651950-3-christoph.muellner@vrull.eu>
 <20240327-imperfect-washbowl-d95e57cef0ef@spud>
 <20240327-77a6b64153a68452d0438999@orel>
 <CAEg0e7jyGZV3+04HNYzgfHMGYT9wV_c0A=ekpCRi3L-5yjxK=w@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAEg0e7jyGZV3+04HNYzgfHMGYT9wV_c0A=ekpCRi3L-5yjxK=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Christoph,

On 28/03/2024 15:18, Christoph Müllner wrote:
> On Wed, Mar 27, 2024 at 1:41 PM Andrew Jones <ajones@ventanamicro.com> wrote:
>> On Wed, Mar 27, 2024 at 11:03:06AM +0000, Conor Dooley wrote:
>>> On Wed, Mar 27, 2024 at 11:31:30AM +0100, Christoph Müllner wrote:
>>>> T-Head's MAEE mechanism (non-compatible equivalent of RVI's Svpbmt)
>>>> is currently assumed for all T-Head harts. However, QEMU recently
>>>> decided to drop acceptance of guests that write reserved bits in PTEs.
>>>> As MAEE uses reserved bits in PTEs and Linux applies the MAEE errata
>>>> for all T-Head harts, this broke the Linux startup on QEMU emulations
>>>> of the C906 emulation.
>>>>
>>>> This patch attempts to address this issue by testing the MAEE bit
>>>> in TH_MXSTATUS CSR. As the TH_MXSTATUS CSR is only accessible in M-mode
>>>> this patch depends on M-mode firmware that handles this for us
>>>> transparently.
>>>>
>>>> As this patch breaks Linux bootup on all C9xx machines with MAEE,
>>>> which don't have M-mode firmware that handles the access to the
>>>> TH_MXSTATUS CSR, this patch is marked as RFC.
>> Can we wrap the csr access in a _ASM_EXTABLE()? If firmware handles it,
>> then we return true/false based on the value. If firmware doesn't handle
>> it, and we get an illegal instruction exception, then we assume the bit
>> is set, which is the current behavior.
>>
>>> I think this is gonna be unacceptable in its current state given that it
>>> causes problems for every other version of the firmware. Breaking real
>>> systems for the sake of emulation isn't something we can reasonably do.
>>>
>>> To make this sort of change acceptable, you're gonna have to add some way
>>> to differentiate between systems that do and do not support reading this
>>> CSR. I think we either a) need to check the version of the SBI
>>> implementation to see if it hits the threshold for supporting this
>>> feature, or b) add a specific SBI call for this so that we can
>>> differentiate between firmware not supporting the function and the
>> The FWFT SBI extension is being developed as a mechanism for S-mode to ask
>> M-mode things like this, but I think that extension should be used for
>> features that have potential to be changed by S-mode (even if not
>> everything will be changeable on all platforms), whereas anything that's
>> read-only would be better with...
>>
>>> quote-unquote "hardware" not supporting it. I don't really like option a)
>>> as it could grow to several different options (each for a different SBI
>>> implementation) and support for reading the CSR would need to be
>>> unconditional. I have a feeling that I am missing something though,
>>> that'd make it doable without introducing a new call.
>>>
>>> Thanks,
>>> Conor.
>>>
>>> If only we'd made enabling this be controlled by a specific DT property,
>>> then disabling it in QEMU would be as simple as not setting that
>>> property :(
>> ...this, where "DT property" is "ISA extension name". I wonder if we
>> shouldn't start considering the invention of xlinux_vendor_xyz type
>> extension names which firmware could add to the ISA string / array,
>> in order to communicate read-only information like this?
>>
>> Thanks,
>> drew
> Hi Conor and Drew,
>
> Thank you for your hints.
> I fully agree with all your statements and concerns.
>
> Switching from th.mxstatus to th.sxstatus should address all mentioned concerns:
> * no dependency on OpenSBI changes
> * no break of functionality
> * no need for graceful handling of CSR read failures
> * no need to differentiate between HW and emulation (assuming QEMU
> accepts the emulation of th.sxstatus)
>
> Also note that DT handling would be difficult, because we need to probe before
> setting up the page table.


We already parse the DT before setting the page table to disable KASLR 
and to parse "no4lvl" or "no5lvl" command line parameters. Take a look 
at the kernel/pi directory and setup_vm() in mm/init.c.

Thanks,

Alex


>
> Thanks!
>
>
>>>> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
>>>> ---
>>>>   arch/riscv/errata/thead/errata.c | 14 ++++++++++----
>>>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
>>>> index 8c8a8a4b0421..dd7bf6c62a35 100644
>>>> --- a/arch/riscv/errata/thead/errata.c
>>>> +++ b/arch/riscv/errata/thead/errata.c
>>>> @@ -19,6 +19,9 @@
>>>>   #include <asm/patch.h>
>>>>   #include <asm/vendorid_list.h>
>>>>
>>>> +#define CSR_TH_MXSTATUS            0x7c0
>>>> +#define MXSTATUS_MAEE              _AC(0x200000, UL)
>>>> +
>>>>   static bool errata_probe_maee(unsigned int stage,
>>>>                            unsigned long arch_id, unsigned long impid)
>>>>   {
>>>> @@ -28,11 +31,14 @@ static bool errata_probe_maee(unsigned int stage,
>>>>      if (arch_id != 0 || impid != 0)
>>>>              return false;
>>>>
>>>> -   if (stage == RISCV_ALTERNATIVES_EARLY_BOOT ||
>>>> -       stage == RISCV_ALTERNATIVES_MODULE)
>>>> -           return true;
>>>> +   if (stage != RISCV_ALTERNATIVES_EARLY_BOOT &&
>>>> +       stage != RISCV_ALTERNATIVES_MODULE)
>>>> +           return false;
>>>>
>>>> -   return false;
>>>> +   if (!(csr_read(CSR_TH_MXSTATUS) & MXSTATUS_MAEE))
>>>> +           return false;
>>>> +
>>>> +   return true;
>>>>   }
>>>>
>>>>   /*
>>>> --
>>>> 2.44.0
>>>>
>>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

