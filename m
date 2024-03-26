Return-Path: <linux-kernel+bounces-118586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498C288BCEB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D412E43F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAA454917;
	Tue, 26 Mar 2024 08:56:20 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3972548F1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443379; cv=none; b=WZ4B8E+UVNX4/eCFfEABsTIQ5azz3NtW9DcJGEZEQGpGliBkj+UT+zgGwscbt2bmU1EmrCBaN23XOQx0lVquy+L4fIUdlHly8wJXxnI/nlSU+9wGSuj8DiNRs/+rXL8gqS3aKJstyHz4q6cPcChk+djZLHnDqOAESolMl9RXmaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443379; c=relaxed/simple;
	bh=oBipWs+jXHuItcEl/r2AVi229geZIoTDoOYLGnnDWBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPTMMhboZGG7Que8LZ/EYcpGp/ojx/jFcH8FTeO/mpTiYeAX0IQvJjh/FtktwXLJAH9S0AJN5IvfPjJH9Br0W5pbrM+QtcH/NlGtJ6kgCwM/wgBLIKnKyPgzN0w1QUBvgiwzi8dNlSPy11dhE4U054o5hdK6vA8Z3ybkFsuZv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A8D3C0009;
	Tue, 26 Mar 2024 08:56:11 +0000 (UTC)
Message-ID: <be1b8bb6-ae08-4173-9ce5-26f2acee5950@ghiti.fr>
Date: Tue, 26 Mar 2024 09:56:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: hwprobe: do not produce frtace relocation
Content-Language: en-US
To: Vladimir Isaev <vladimir.isaev@syntacore.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, catalin.marinas@arm.com,
 evan@rivosinc.com, nicolas@fjasle.eu, tglx@linutronix.de,
 samitolvanen@google.com, masahiroy@kernel.org, maskray@google.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 guoren@kernel.org
Cc: Roman Artemev <roman.artemev@syntacore.com>
References: <20240313085843.17661-1-vladimir.isaev@syntacore.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240313085843.17661-1-vladimir.isaev@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Vladimir,

s/frtace/ftrace

On 13/03/2024 08:35, Vladimir Isaev wrote:
> Such relocation causes crash of android linker similar to one
> described in commit e05d57dcb8c7
> ("riscv: Fixup __vdso_gettimeofday broke dynamic ftrace").
>
> Looks like this relocation is added by CONFIG_DYNAMIC_FTRACE which is
> disabled in the default android kernel.
>
> Before:
>
> readelf -rW arch/riscv/kernel/vdso/vdso.so:
>
> Relocation section '.rela.dyn' at offset 0xd00 contains 1 entry:
>      Offset             Info             Type
> 0000000000000d20  0000000000000003 R_RISCV_RELATIVE
>
> objdump:
> 0000000000000c86 <__vdso_riscv_hwprobe@@LINUX_4.15>:
>   c86:   0001                    nop
>   c88:   0001                    nop
>   c8a:   0001                    nop
>   c8c:   0001                    nop
>   c8e:   e211                    bnez    a2,c92 <__vdso_riscv_hwprobe...
>
> After:
> readelf -rW arch/riscv/kernel/vdso/vdso.so:
>
> There are no relocations in this file.
>
> objdump:
> 0000000000000c86 <__vdso_riscv_hwprobe@@LINUX_4.15>:
>   c86:   e211                    bnez    a2,c8a <__vdso_riscv_hwprobe...
>   c88:   c6b9                    beqz    a3,cd6 <__vdso_riscv_hwprobe...
>   c8a:   e739                    bnez    a4,cd8 <__vdso_riscv_hwprobe...
>   c8c:   ffffd797                auipc   a5,0xffffd
>
> Also disable SCS since it also should not be available in vdso.
>
> Fixes: aa5af0aa90ba ("RISC-V: Add hwprobe vDSO function and data")
> Signed-off-by: Roman Artemev <roman.artemev@syntacore.com>
> Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
> ---
>   arch/riscv/kernel/vdso/Makefile | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 9b517fe1b8a8..272c431ac5b9 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -37,6 +37,7 @@ endif
>   
>   # Disable -pg to prevent insert call site
>   CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> +CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)


I did not find a way to remove those flags for all C files 
automatically, too bad. But then I noticed that we were the only 
architecture which does not check for dynamic relocations in vdso, so at 
least we'll fail loudly. I'll send a patch for that soon.

This should go into -fixes.

Anyway, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


>   
>   # Disable profiling and instrumentation for VDSO code
>   GCOV_PROFILE := n

