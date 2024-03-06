Return-Path: <linux-kernel+bounces-94549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CDF87413C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E297B22172
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAD4140E46;
	Wed,  6 Mar 2024 20:12:56 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D860250
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755975; cv=none; b=pbRZMjlCRDftfO/ueRS05ueJLBf+chlrNUTSliLTxzJs24GMws3M78dwppVMil8LaN9+TZo4VQWO43vi78Yr1bhNljZaLIl1y9M7AChJAIwyBPfnqoFNGZemkopoQqQRzSapnF9U640KkeDElu2iBoj/MxPoPc7EH/rIokxLoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755975; c=relaxed/simple;
	bh=TX547eTfaPewrf9xdqLu4LWOojF0uMxOHFLW/38Gofg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8ZLvjzCWPx4rtwpG87wzdzgaT0OOxo1xuhk4ltJd1T52zfbAZr0R0EZbjUW95UPJFi/7ElBQ+Inhdj15ipAJtc+Q+NiSpyPWOBv9s/W22amv9BURW4lg+F9kBQQ4BpfF2gLH6O7RyuVrdxNI6qTKL3xo2HB1MZ8b/9iBzDusgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2539120002;
	Wed,  6 Mar 2024 20:12:50 +0000 (UTC)
Message-ID: <ca097f2a-59ec-4945-9860-5e380e1665e4@ghiti.fr>
Date: Wed, 6 Mar 2024 21:12:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: compat_vdso: install compat_vdso.so.dbg to
 /lib/modules/*/vdso/
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <20231117125807.1058477-1-masahiroy@kernel.org>
 <CAK7LNAStoCja1gnoFmsKikbzGZmKTcTu+Vc7v9zg8B9hwsH+iQ@mail.gmail.com>
 <CAK7LNATVAcj-pa_G-NGBTr9doCACGk1nKCNbxM50-M0mi9q=7w@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAK7LNATVAcj-pa_G-NGBTr9doCACGk1nKCNbxM50-M0mi9q=7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Masahiro,

On 24/02/2024 04:37, Masahiro Yamada wrote:
> Ping x 2 ?
>
>
>
>
>
> On Sun, Jan 21, 2024 at 6:48 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>> On Fri, Nov 17, 2023 at 9:58 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>> 'make vdso_install' installs debug vdso files to /lib/modules/*/vdso/.
>>>
>>> Only for the compat vdso on riscv, the installation destination differs;
>>> compat_vdso.so.dbg is installed to /lib/module/*/compat_vdso/.
>>>
>>> To follow the standard install destination and simplify the vdso_install
>>> logic, change the install destination to standard /lib/modules/*/vdso/.
>>>
>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>> ---
>>
>> Ping?
>> (in case "yet more RISC-V updates" happens)
>>
>>
>>
>>
>>>   arch/riscv/Makefile | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>>> index a74be78678eb..5cbe596345c1 100644
>>> --- a/arch/riscv/Makefile
>>> +++ b/arch/riscv/Makefile
>>> @@ -146,7 +146,7 @@ endif
>>>   endif
>>>
>>>   vdso-install-y                 += arch/riscv/kernel/vdso/vdso.so.dbg
>>> -vdso-install-$(CONFIG_COMPAT)  += arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg:../compat_vdso/compat_vdso.so
>>> +vdso-install-$(CONFIG_COMPAT)  += arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
>>>
>>>   ifneq ($(CONFIG_XIP_KERNEL),y)
>>>   ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
>>> --
>>> 2.40.1
>>>
>>
>> --
>> Best Regards
>> Masahiro Yamada
>
>
> --
> Best Regards
> Masahiro Yamada
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Couldn't changing this library install path break some existing 
application? I mean it kind of breaks where the library is expected to 
be right?

Thanks,

Alex


