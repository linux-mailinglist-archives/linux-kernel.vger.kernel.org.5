Return-Path: <linux-kernel+bounces-58807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EFD84EC4F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37D0B2855F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A665026D;
	Thu,  8 Feb 2024 23:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4g+lO9XL"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5850257
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 23:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434056; cv=none; b=Np/5aDLp2mUxURkhwrz/um8qhUdyZFahM726PgJi/4UahWBaTLPyISQZJcRV4dET6z6zR/djoqJGdHrKYkpiEihqkDDLwl6dKon6TNu8R/OKgdeJ4/ZgdUzjFcg8TI11ktEpcSmzc4YDxfOQEp3RVGy3R90wLYWl/Y1ByskMGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434056; c=relaxed/simple;
	bh=me8ZF9MFV3b25A/LpyNIDRWvjZIMoVYXkuh8e+uhqu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjIr1t62yC/i9hf938eHwqY1B+YiMqb3sqA1g3BskHrBT1hY7cdJUnWlEqo5vHMlRyf/54kWfX2ZzUdWYEtRJYLH57RieeQ+ZZ2eWdMuleEy+ovn8Tqp1S6k0TK4lhVYe1LhSeI9IWFXpCR2qT2wsqBEtqI9avvkxSfzCrJmgxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4g+lO9XL; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c00cfd7156so12461239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 15:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707434052; x=1708038852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pe6jnI7sJWQLdADxcvkIM7ZK9uT6CeFtU8HHzuib1uI=;
        b=4g+lO9XLlJoQtPaBqQ3SEo6Fh7AeaNA3RLLXDuFd3F0ZXKNgu2G0OUJCfjDQ84fqAw
         dLCvsF/7C02IGnmvzxM/BFsfUUQURtQm3sBHq95RWUWIeQzzxsIJ08XlMi/tfbwkN5N/
         JXtVO/e1i2Ug4n+67Q6rOIY4yz/gFWEnPQ2hO9d2h2Hs8NzwgZEx12pDNtCljlptAF3J
         XgyJBoDVDu01aDFb0nhxLMfl2G/rVCn9PsM96xAPdzWWFlNvCsNAaSCwTgZV81UCRrrk
         nfeRdPEq+wjXesFs+n4qYeY684okTiRul678sUd4XISCAQ1L6w3NZ2rvq2f8EtVVDL8n
         DvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707434052; x=1708038852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe6jnI7sJWQLdADxcvkIM7ZK9uT6CeFtU8HHzuib1uI=;
        b=sx0/0Uz/Fq3CpRoigATwEEnsTtrSDDBz2z3bP1z1E22O9Cjj2XZ0qlbeHb5NFh4l75
         JXRaAptQ4euvdJangbXBkbXxdylL7m4Ev+ldLAcN+IyUVLAqpwDoNtNSnIGKCieLN2L1
         B/DgLFVi9LXl3YQRyfMgK58L8rIpWB2gxjcVlD9UCrw+hFWSOii0UFLJJ+y9hV+IHQrE
         m48yD52PhsXsKzZE3gAiyb4TeVn+n3S70JM4sNp/pLHUoJx1dcRuHlP0/dxyD1SxkrpN
         34as1lap0Riuxh83mp7BNli2Z+wdgESrgKj/hNF1YCmdfznWQZMy9FcWiBVbvkzkVK9O
         aWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKczt2uEOhL5YV39xzcTIkYeX4+tXTxUTB0pfwN/JmR4W0weq71Wr65+qYW0D8FVqR2gCzws5zR74t8CiM17HVo0taZvH+zN8tFsHO
X-Gm-Message-State: AOJu0YxoFFzND58N7kq6/1VXkGkPyAqmm9tX9psuYyapRnMijb2w6Ya9
	dlT6A4/dYZ7CiIlGdxioh1BWXUERczNds4R2E/UgOY6Whimdv4NzKtRkxdEe+g==
X-Google-Smtp-Source: AGHT+IHCKa/qnllJa3a8anZ50HmqNn75qJTTGYvPU2+WwjU6U+rngyIqVcN2/lsJ591YBvYTq0dxLw==
X-Received: by 2002:a6b:6b15:0:b0:7c4:6c8:fe2a with SMTP id g21-20020a6b6b15000000b007c406c8fe2amr64594ioc.11.1707434052059;
        Thu, 08 Feb 2024 15:14:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/sQAnakA0PHqUvHJVwEnGRDfLGGR1Y3EMsnDtlTssTQZLJmdAZJb4weX5gsjP0GHz87cjZ+J4aTm3lhvE8vGjJ7gUV+F94Ka/SSo/b0jZGktJv8SsWuN+Yrn45Ipj+rKMx3j6PTbvF7sIXTY9e4mk+6newdRmq9RdiFbg4fYoOZuLNbxx4HXoEGYuFDdtn2v4l5+YOsvluP3SnMTPSMvLEJwmE6Mrlt7FC4AUaj0/1y4WFnSQi890D49iGXs7laiKi57+1CfTmrGa5diaVMarJ9O9titiQNcX/FXJQYyh6OVxOY1bQ3N5yXIxcec1OGFFBIH7m541j3LvNbQIEAyVT65ZyucUjxkLBvXNwqxZmVLQYDKJGzdW3u+sFiPdyA==
Received: from google.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id t30-20020a05663836de00b004714adc2d2fsm106510jau.46.2024.02.08.15.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 15:14:11 -0800 (PST)
Date: Thu, 8 Feb 2024 23:14:07 +0000
From: Justin Stitt <justinstitt@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, maskray@google.com,
	ndesaulniers@google.com, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev
Subject: Re: [PATCH 00/11] s390: Support linking with ld.lld
Message-ID: <20240208231407.vkisblrowjvivsxb@google.com>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>

Hi,

On Wed, Feb 07, 2024 at 05:14:52PM -0700, Nathan Chancellor wrote:
> Hi all,
>
> This series allows the s390 kernel to be linked with ld.lld (support for
> s390 is under review at [1]). This implicitly depends on [2], which was
> created and sent before it was realized that this series was necessary.
>
> The first chunk of this series enables support for
> CONFIG_LD_ORPHAN_WARN, as it was discovered during testing that the
> kernel fails to build with ld.lld due to differences in orphan section
> handling, which would have been caught with the linker's orphan section
> warnings ahead of the actual build error. There are no warnings when
> building ARCH=s390 defconfig and allmodconfig with GCC 6 through 13 or
> tip of tree Clang using ld.bfd or ld.lld
>
> The final patch resolves a series of errors due to ld.lld having a
> different default for checking for DT_TEXTREL ('-z text') vs ld.bfd,
> which defaults to '-z notext' (but this is configurable at build time).
>
> There is one outstanding issue due to something that ld.lld does not
> support that the kernel relies on:
>
>   ld.lld: error: drivers/nvme/host/fc.o:(__bug_table): writable SHF_MERGE section is not supported
>
> This was changed in the kernel in commit e21f8baf8d9a ("s390/bug: add
> entry size to the __bug_table section"). Is this change truly necessary?
> I selectively applied a revert on top of current mainline and I did not
> observe any issues with either Clang or GCC.
>
> diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
> index aebe1e22c7be..c500d45fb465 100644
> --- a/arch/s390/include/asm/bug.h
> +++ b/arch/s390/include/asm/bug.h
> @@ -14,7 +14,7 @@
>  		".section .rodata.str,\"aMS\",@progbits,1\n"	\
>  		"1:	.asciz	\""__FILE__"\"\n"		\
>  		".previous\n"					\
> -		".section __bug_table,\"awM\",@progbits,%2\n"	\
> +		".section __bug_table,\"aw\"\n"			\
>  		"2:	.long	0b-.\n"				\
>  		"	.long	1b-.\n"				\
>  		"	.short	%0,%1\n"			\
> @@ -30,7 +30,7 @@
>  #define __EMIT_BUG(x) do {					\
>  	asm_inline volatile(					\
>  		"0:	mc	0,0\n"				\
> -		".section __bug_table,\"awM\",@progbits,%1\n"	\
> +		".section __bug_table,\"aw\"\n"			\
>  		"1:	.long	0b-.\n"				\
>  		"	.short	%0\n"				\
>  		"	.org	1b+%1\n"			\
>
> If it is necessary, is there any way to work around this error? For
> testing purposes, disabling CONFIG_BUG is easy enough but that is not
> usable in the real world.
>
> To test this series with ld.lld, you'll need to build ld.lld from the
> pull request, which is easy to do following LLVM's instructions [3].
> Here is a TL;DR version I tested that just builds LLD with minimal noise
> during the build.
>
> $ git clone https://github.com/llvm/llvm-project
> $ cd llvm-project
> $ git fetch https://github.com/llvm/llvm-project pull/75643/head
> $ git switch -d FETCH_HEAD
> $ cmake \
>     -B build \
>     -G Ninja \
>     -S llvm \
>     --log-level=NOTICE \
>     -Wno-dev \
>     -DCMAKE_BUILD_TYPE=Release \
>     -DLLVM_ENABLE_PROJECTS=lld \
>     -DLLVM_ENABLE_WARNINGS=OFF \
>     -DLLVM_TARGETS_TO_BUILD=SystemZ
> $ ninja -C build lld
> $ export PATH=$PWD/build/bin:$PATH
>
> Then build the kernel with 'LD=ld.lld' in addition to whatever command
> line you use (I tested both Clang and GCC). I can boot an ld.lld linked
> kernel built with both compilers in QEMU with this series.

Yeah, this all works for me and I am able to boot. I did need to use the
diff present in 0/11 to remove the warnings regarding SHF_MERGE
sections. It should probably be a patch in this series instead of a
inlined diff?

>
> [    1.386970] Linux version 6.8.0-rc3-00043-g05761ede85d6-dirty (nathan@dev-fedora.aadp) (s390-linux-gcc (GCC) 13.2.0, ClangBuiltLinux LLD 19.0.0) #1 SMP Wed Feb  7 16:51:12 MST 2024
>
> [    0.871923] Linux version 6.8.0-rc3-00043-g05761ede85d6-dirty (nathan@dev-fedora.aadp) (ClangBuiltLinux clang version 19.0.0git (https://github.com/llvm/llvm-project 417075e56aeba5a5b20301c7bfeba9c2a800982b), ClangBuiltLinux LLD 19.0.0) #1 SMP Wed Feb  7 17:01:22 MST 2024
>
> [1]: https://github.com/llvm/llvm-project/pull/75643
> [2]: https://lore.kernel.org/r/20240130-s390-vdso-drop-fpic-from-ldflags-v1-1-094ad104fc55@kernel.org/
^^^^^^^^^
I needed this too, as I was getting a warnings about -fPIC being an
unknown option.


All in all, works great for me building on clang and booting with qemu.

Tested-by: Justin Stitt <justinstitt@google.com>

> [3]: https://llvm.org/docs/CMake.html
>
> ---
> Nathan Chancellor (11):
>       s390: boot: Add support for CONFIG_LD_ORPHAN_WARN
>       s390: vmlinux.lds.S: Handle '.data.rel' sections explicitly
>       s390: vmlinux.lds.S: Explicitly handle '.got' and '.plt' sections
>       s390: vmlinux.lds.S: Discard unnecessary sections
>       s390/boot: vmlinux.lds.S: Handle '.init.text'
>       s390/boot: vmlinux.lds.S: Handle '.rela' sections
>       s390/boot: vmlinux.lds.S: Handle DWARF debug sections
>       s390/boot: vmlinux.lds.S: Handle ELF required sections
>       s390/boot: vmlinux.lds.S: Handle commonly discarded sections
>       s390: Select CONFIG_ARCH_WANT_LD_ORPHAN_WARN
>       s390: Link vmlinux with '-z notext'
>
>  arch/s390/Kconfig              |  1 +
>  arch/s390/Makefile             |  2 +-
>  arch/s390/boot/Makefile        |  5 +++--
>  arch/s390/boot/vmlinux.lds.S   | 28 ++++++++++++++++++++++++++++
>  arch/s390/kernel/vmlinux.lds.S | 28 +++++++++++++++++++++++++++-
>  5 files changed, 60 insertions(+), 4 deletions(-)
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240207-s390-lld-and-orphan-warn-d0ff4ff657b0
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>

Thanks
Justin

