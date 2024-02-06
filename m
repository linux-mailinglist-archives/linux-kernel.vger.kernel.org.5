Return-Path: <linux-kernel+bounces-55606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93EF84BEE0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082751C22382
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6931B81D;
	Tue,  6 Feb 2024 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fjJbomt/"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C181B800;
	Tue,  6 Feb 2024 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707252332; cv=none; b=rdLkzghZXmKNLCZT/Fvk+LWCyJmG9ItKRW3dKZsw7UqI29/g8BPXvwYURuEbJXgYOlPF/qxV5Zm8dO9oSBqwbQ6eznCUTgReTQ0H29bY+Xt+vij85ZjeYurFJPc+S5Ot0KpVuCxweNFmyBnanmF4VIKxvaEtNHQBBc9ZoK76B6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707252332; c=relaxed/simple;
	bh=Ap1QrnLw5QiRSwLiqIPbFygyvGxpoTHhGkTtorfLHYY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hVJOsXp0Nvh3L/t5yK+qCO7q0nDwYRrpo/PyAULc3sswL5e6+TpzbWr9SAwTiUIDW3kRd2ANW3ZVbxtbMnPqzYf1WxOJ4ia9PNpva2nXSYa991M/hmdzV+xUvNedo3CWt0DCtxrMLUesZvqi5WBY+rJmYblwVWNHiA8hZ65QLks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=fjJbomt/; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 416Kj3N52362804
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 6 Feb 2024 12:45:04 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 416Kj3N52362804
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1707252304;
	bh=kmuk5PBmS8Ah7+ki/VRnqZ/AjJlqfnIkBReotrmN2f8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=fjJbomt/rBG7ek/+hQbCOuhTJBTA4wLNK1D1dKKDi+rj7Tdb1OHmG24i1IxpqKtxx
	 WrRXfZJMFtczMPHypeQOYKFKsxmJ79YRhKi46vZO9WZIjlebT6OMUxypz391LWI9kg
	 GjVR/bnPsxTEOX+kpHvvTN4XoNrHh+y5Hk1Ufh8MvLDSwynxiVrnRUgjWb38z82DHe
	 V3dWKqwA7P0nSyw8a3pp3mGl4OoIWDZT6IKDdUc6S0RRYshMnTJ7+oKQprJCku5FEL
	 FJpUr9IvZQxM4QHSRS6xw8wPNK6VdvzK9c3PGs0kXwpn8rasLC03UGQX+lb+2BKOKb
	 6i8Q2HHrK0kgg==
Date: Tue, 06 Feb 2024 12:45:03 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
        tip-bot2 for Xin Li <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Shan Kang <shan.kang@intel.com>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/fred=5D_x86/ptrace=3A_Cleanup?= =?US-ASCII?Q?_the_definition_of_the_pt=5Fregs_structure?=
User-Agent: K-9 Mail for Android
In-Reply-To: <8f260a93-08f3-48af-81e5-8ee53246e262@zytor.com>
References: <20231205105030.8698-14-xin3.li@intel.com> <170673569232.398.15041548048531772130.tip-bot2@tip-bot2> <2A59D51B-0AA0-4DFC-9957-67CC0C9E37B3@zytor.com> <8f260a93-08f3-48af-81e5-8ee53246e262@zytor.com>
Message-ID: <D64A7458-15DD-4B92-975A-9E4ABD96CAE2@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 6, 2024 11:04:13 AM PST, Xin Li <xin@zytor=2Ecom> wrote:
>On 2/3/2024 3:52 PM, H=2E Peter Anvin wrote:
>> On January 31, 2024 1:14:52 PM PST, tip-bot2 for Xin Li <tip-bot2@linut=
ronix=2Ede> wrote:
>>> The following commit has been merged into the x86/fred branch of tip:
>>>=20
>>> Commit-ID:     ee63291aa8287cb7ded767d340155fe8681fc075
>>> Gitweb:        https://git=2Ekernel=2Eorg/tip/ee63291aa8287cb7ded767d3=
40155fe8681fc075
>>> Author:        Xin Li <xin3=2Eli@intel=2Ecom>
>>> AuthorDate:    Tue, 05 Dec 2023 02:50:02 -08:00
>>> Committer:     Borislav Petkov (AMD) <bp@alien8=2Ede>
>>> CommitterDate: Wed, 31 Jan 2024 22:01:13 +01:00
>>>=20
>>> x86/ptrace: Cleanup the definition of the pt_regs structure
>>>=20
>>> struct pt_regs is hard to read because the member or section related
>>> comments are not aligned with the members=2E
>>>=20
>>> The 'cs' and 'ss' members of pt_regs are type of 'unsigned long' while
>>> in reality they are only 16-bit wide=2E This works so far as the
>>> remaining space is unused, but FRED will use the remaining bits for
>>> other purposes=2E
>>>=20
>>> To prepare for FRED:
>>>=20
>>>   - Cleanup the formatting
>>>   - Convert 'cs' and 'ss' to u16 and embed them into an union
>>>     with a u64
>>>   - Fixup the related printk() format strings
>>>=20
>>> Suggested-by: Thomas Gleixner <tglx@linutronix=2Ede>
>>> Originally-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>>> Signed-off-by: Xin Li <xin3=2Eli@intel=2Ecom>
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix=2Ede>
>>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8=2Ede>
>>> Tested-by: Shan Kang <shan=2Ekang@intel=2Ecom>
>>> Link: https://lore=2Ekernel=2Eorg/r/20231205105030=2E8698-14-xin3=2Eli=
@intel=2Ecom
>
>[=2E=2E=2E]
>
>>> diff --git a/arch/x86/kernel/process_64=2Ec b/arch/x86/kernel/process_=
64=2Ec
>>> index 33b2687=2E=2E0f78b58 100644
>>> --- a/arch/x86/kernel/process_64=2Ec
>>> +++ b/arch/x86/kernel/process_64=2Ec
>>> @@ -117,7 +117,7 @@ void __show_regs(struct pt_regs *regs, enum show_r=
egs_mode mode,
>>>=20
>>> 	printk("%sFS:  %016lx(%04x) GS:%016lx(%04x) knlGS:%016lx\n",
>>> 	       log_lvl, fs, fsindex, gs, gsindex, shadowgs);
>>> -	printk("%sCS:  %04lx DS: %04x ES: %04x CR0: %016lx\n",
>>> +	printk("%sCS:  %04x DS: %04x ES: %04x CR0: %016lx\n",
>>> 		log_lvl, regs->cs, ds, es, cr0);
>>> 	printk("%sCR2: %016lx CR3: %016lx CR4: %016lx\n",
>>> 		log_lvl, cr2, cr3, cr4);
>>=20
>> Incidentally, the comment about callee-saved registers is long since bo=
th obsolete and is now outright wrong=2E
>>=20
>> The next version of gcc (14 I think) will have an attribute to turn off=
 saving registers which we can use for top-level C functions=2E
>>=20
>
>Forgive my ignorance, do we have an official definition for "top-level C =
functions"?
>
>Thanks!
>    Xin
>

(Adding H=2EJ=2E, who did the gcc implementation of __attribute__((no_call=
ee_saved_registers)))=2E

The top level C functions are the ones whose stack frame are immediately b=
elow the exception/syscall frame, i=2Ee=2E the C function called from the e=
ntry assembly code and functions tailcalled from those (unless they set up =
a stack frame for things like memory structures passed to the called functi=
on=2E)

Note that the implementation should properly handle the case when calling =
these functions from C (accidentally, or because it is a rare case that can=
 be validly pessimized=2E)=20

