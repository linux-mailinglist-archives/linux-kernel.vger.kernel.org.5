Return-Path: <linux-kernel+bounces-59510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7485B84F831
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD4E1F26585
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3E171B52;
	Fri,  9 Feb 2024 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAF+rme/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E426DD12;
	Fri,  9 Feb 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491325; cv=none; b=HMA82Fpas5JHizyEEL7tgBqiZmDXE4cFg2ZdAviL0uxhmyA1Mr7mktUw/549Fxuu2G4m78BYIEX4iTCrzReMDQEBAzs9KbyQ0spLcLhYUu+YVaJedK16PeB0Ced7l0vcd9e3T1emZNDk9cC+mmMdoiu2YSKu5UN1T2pb7O1a/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491325; c=relaxed/simple;
	bh=1G6lfwF6elBdKH2SRgXlpt4rPawQ+hptmTGr1wbGV88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3pn+HTGaoogyuniH+DYKAdzjZ9AI+toutn8xWIFt6hHxrd4C3HnThYzg6p2h/v3v6u6GHZzwH8E59FmcgO/ra77LixSQyTQTb6uZGtu3eZrD7H4HZpCzRMjSqn8RfvG5AFTlbauE6bIIgzTdLSpX9NxADqBFff9PttzWR9gelE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAF+rme/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A516C43394;
	Fri,  9 Feb 2024 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707491325;
	bh=1G6lfwF6elBdKH2SRgXlpt4rPawQ+hptmTGr1wbGV88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAF+rme/gQucFL5nQCZyST8snsvZiXfO3Zf7cr+dwL3H5pzhrbJnUIvZISN9jf7gf
	 fwiCFNi3Y3BVOWxHA+UpmXcpI+HtR077eWWZBL8Jl6szsLOl2cCXc9UYmhpPyUXF0I
	 2XxrD2GtYkqPDF2M2yOulvr8GAmVmc8SXWcoC25aNKm8uLz6pWRcg3eLBeTENKIGHW
	 EhF+3070vNhOAf+JNrklBlbnjMVVp8632Km2Snnaf8+4GHPfNKGdNRoi9bHRDhgbFe
	 /o14uOQP10lYwJFpC/7hKbwi6mPa3dX77baht/6RMkJLcNQjv0U1mzp7R1jLJnaOlY
	 diT2lyoDtXJhA==
Date: Fri, 9 Feb 2024 08:08:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, maskray@google.com, ndesaulniers@google.com,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 00/11] s390: Support linking with ld.lld
Message-ID: <20240209150842.GA666821@dev-arch.thelio-3990X>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
 <20240209112046.13241-C-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209112046.13241-C-hca@linux.ibm.com>

Hi Heiko,

On Fri, Feb 09, 2024 at 12:20:46PM +0100, Heiko Carstens wrote:
> > This series allows the s390 kernel to be linked with ld.lld (support for
> > s390 is under review at [1]). This implicitly depends on [2], which was
> > created and sent before it was realized that this series was necessary.
> ...
> > There is one outstanding issue due to something that ld.lld does not
> > support that the kernel relies on:
> > 
> >   ld.lld: error: drivers/nvme/host/fc.o:(__bug_table): writable SHF_MERGE section is not supported
> > 
> > This was changed in the kernel in commit e21f8baf8d9a ("s390/bug: add
> > entry size to the __bug_table section"). Is this change truly necessary?
> > I selectively applied a revert on top of current mainline and I did not
> > observe any issues with either Clang or GCC.
> 
> No it is not necessary. As the original patch stated this was a pre-req
> patch for objtool, for which we still don't have support. This (or
> something different) might be needed. But for now this can easily be
> reverted.
> 
> > Then build the kernel with 'LD=ld.lld' in addition to whatever command
> > line you use (I tested both Clang and GCC). I can boot an ld.lld linked
> > kernel built with both compilers in QEMU with this series.
> > 
> > [    1.386970] Linux version 6.8.0-rc3-00043-g05761ede85d6-dirty (nathan@dev-fedora.aadp) (s390-linux-gcc (GCC) 13.2.0, ClangBuiltLinux LLD 19.0.0) #1 SMP Wed Feb  7 16:51:12 MST 2024
> > 
> > [    0.871923] Linux version 6.8.0-rc3-00043-g05761ede85d6-dirty (nathan@dev-fedora.aadp) (ClangBuiltLinux clang version 19.0.0git (https://github.com/llvm/llvm-project 417075e56aeba5a5b20301c7bfeba9c2a800982b), ClangBuiltLinux LLD 19.0.0) #1 SMP Wed Feb  7 17:01:22 MST 2024
> 
> Tested, and works for me. Thanks a lot for your work. This is highly
> appreciated!
> 
> I applied this series internally to get some CI runs over the weekend, and
> push it to our external repository beginning of next week. As suggested by

Excellent, please let me know if anything comes up from that!

> you I reverted the commit you mentioned above, and also removed ENTRY from
> our vdso linker scripts, similar to what you did already for powerpc (see
> patches below).

Ah thanks for spotting that, I was so focused on the errors I forgot to
clean up the warning too.

> Please feel free to send patches for both of the issues, and I'll replace
> my patches with your patches.

Honestly, I am not sure that I will write much better commit messages
than the ones you already have and those solutions seem acceptable to
me. Consider them:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

But if you would prefer patches from myself though, I can send them next
week.

Cheers,
Nathan

> From 30a0a88d0e6c4802b748a942bb3f6f1b223f53ba Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <hca@linux.ibm.com>
> Date: Fri, 9 Feb 2024 11:48:25 +0100
> Subject: [PATCH 1/2] s390/bug: remove entry size from __bug_table section
> 
> Commit e21f8baf8d9a ("s390/bug: add entry size to the __bug_table section")
> changed the __EMIT_BUG() inline assembly to emit mergeable __bug_table
> entries. This is at least currently not needed, but causes problems with
> the upcoming s390 ld.lld support:
> 
>   ld.lld: error: drivers/nvme/host/fc.o:(__bug_table): writable SHF_MERGE section is not supported
> 
> Therefore revert the change for now.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org/
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/bug.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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
> -- 
> 2.40.1
> 
> From bdca9b8dcf3f0884341f491d54502d4cbe660446 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <hca@linux.ibm.com>
> Date: Fri, 9 Feb 2024 11:54:01 +0100
> Subject: [PATCH 2/2] s390/vdso: remove unused ENTRY in linker scripts
> 
> When linking vdso64.so.dbg with ld.lld, there is a warning about not
> finding _start for the starting address:
> 
>   ld.lld: warning: cannot find entry symbol _start; not setting start address
> 
> Fix this be removing the unused ENTRY in both vdso linker scripts. See
> commit e247172854a5 ("powerpc/vdso: Remove unused ENTRY in linker
> scripts"), which solved the same problem for powerpc, for further details.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/vdso32/vdso32.lds.S | 1 -
>  arch/s390/kernel/vdso64/vdso64.lds.S | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/vdso32/vdso32.lds.S b/arch/s390/kernel/vdso32/vdso32.lds.S
> index edf5ff1debe1..65b9513a5a0e 100644
> --- a/arch/s390/kernel/vdso32/vdso32.lds.S
> +++ b/arch/s390/kernel/vdso32/vdso32.lds.S
> @@ -9,7 +9,6 @@
>  
>  OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
>  OUTPUT_ARCH(s390:31-bit)
> -ENTRY(_start)
>  
>  SECTIONS
>  {
> diff --git a/arch/s390/kernel/vdso64/vdso64.lds.S b/arch/s390/kernel/vdso64/vdso64.lds.S
> index 4461ea151e49..37e2a505e81d 100644
> --- a/arch/s390/kernel/vdso64/vdso64.lds.S
> +++ b/arch/s390/kernel/vdso64/vdso64.lds.S
> @@ -9,7 +9,6 @@
>  
>  OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
>  OUTPUT_ARCH(s390:64-bit)
> -ENTRY(_start)
>  
>  SECTIONS
>  {
> -- 
> 2.40.1
> 

