Return-Path: <linux-kernel+bounces-142625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9108A2DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F0B6B21C25
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5D856458;
	Fri, 12 Apr 2024 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="IOU+aZGz"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC697405FF;
	Fri, 12 Apr 2024 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923670; cv=none; b=AVbJQiKXtN/GGBL4BML7WU8LRQddSX6BNJXtWlQiHm7NsCQMLpW3+Fjm9WiftytOeXrGtRNE6cM5BhhW8nRbfsfpfbDLp8sGhlCY4nKH3yCBTViWn1m9dZVQ0+lQ4Sqpa/onLV0SMAQZ1k0L7fh6JmFMPPVoqV0U5NW6SBI5JWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923670; c=relaxed/simple;
	bh=0+DTX+ND8zvwiWWYFnhJVr/zksMtQd1aiZmIx77H+5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wu00Tni0eOTR4vQ3JrqwcViNRbvDez05u+w3coxVyZ+SCp/m5510l8TohsA1RfSQgCsZw57MApjGOvYtnjk08yW1BdoErY0oKDlI623BVzqKw9gIkoNbJraZYM/JIb6Q69gKkwfZsuvTlPUbTXDDycK18UiFgDb0S75emEZxpiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=IOU+aZGz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712923664;
	bh=+6L46Us/2qlRhhkFSf/ej11Qri1UigkSqyiqW3R+DUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IOU+aZGzxjVQGUXs2pw3MGEBG639NiwT0y6sGprZHf7Os4Du4lZbd15clakEZjfA+
	 7spFZncmALJZjPxb2riROX0JC7IU4Q1+CxgnGF72ggg8kTz0BP9FBCNClXs+yKVZz+
	 FFh+dls+x7OSoR+55xOG4T9SohJuAwfG1KoS6LuKG/w94nhF4o6FzkH98j4AHeGTVb
	 cW2Ks+0fefdPnSaIjKrz5voEW0QgS52f/Rbe8TUPGHD/a9cR2WDdzkYJtCt2dIOgSb
	 OVKC3O4ITvcuykiPCyOrXF9qQM1DqHG8s+/9g/Iu6DgxzMotp878IQIXxaehv86OBn
	 XWMy5lQ5sDmrA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VGFgd3XgTz4wnr;
	Fri, 12 Apr 2024 22:07:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vignesh Balasubramanian <vigbalas@amd.com>,
 linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com, ebiederm@xmission.com, keescook@chromium.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 bpetkov@amd.com, jinisusan.george@amd.com, matz@suse.de,
 binutils@sourceware.org, jhb@FreeBSD.org, felix.willgerodt@intel.com,
 Vignesh Balasubramanian <vigbalas@amd.com>
Subject: Re: [PATCH 1/1] Replace macro "ARCH_HAVE_EXTRA_ELF_NOTES" with kconfig
In-Reply-To: <20240412062138.1132841-2-vigbalas@amd.com>
References: <20240412062138.1132841-1-vigbalas@amd.com>
 <20240412062138.1132841-2-vigbalas@amd.com>
Date: Fri, 12 Apr 2024 22:07:39 +1000
Message-ID: <87il0mdbsk.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vignesh Balasubramanian <vigbalas@amd.com> writes:
> "ARCH_HAVE_EXTRA_ELF_NOTES" enables an extra note section in the
> core dump. Kconfig variable is preferred over ARCH_HAVE_* macro.
>
> Co-developed-by: Jini Susan George <jinisusan.george@amd.com>
> Signed-off-by: Jini Susan George <jinisusan.george@amd.com>
> Signed-off-by: Vignesh Balasubramanian <vigbalas@amd.com>
> ---
>  arch/Kconfig                   | 9 +++++++++
>  arch/powerpc/Kconfig           | 1 +
>  arch/powerpc/include/asm/elf.h | 2 --
>  include/linux/elf.h            | 2 +-
>  4 files changed, 11 insertions(+), 3 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/Kconfig b/arch/Kconfig
> index 9f066785bb71..143f021c8a76 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -502,6 +502,15 @@ config MMU_LAZY_TLB_SHOOTDOWN
>  config ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	bool
>  
> +config ARCH_HAVE_EXTRA_ELF_NOTES
> +	bool
> +	help
> +	  An architecture should select this in order to enable adding an
> +	  arch-specific ELF note section to core files. It must provide two
> +	  functions: elf_coredump_extra_notes_size() and
> +	  elf_coredump_extra_notes_write() which are invoked by the ELF core
> +	  dumper.
> +
>  config ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>  	bool
>  
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1c4be3373686..c45fa9d7fb76 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -156,6 +156,7 @@ config PPC
>  	select ARCH_HAS_UACCESS_FLUSHCACHE
>  	select ARCH_HAS_UBSAN
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> +	select ARCH_HAVE_EXTRA_ELF_NOTES        if SPU_BASE
>  	select ARCH_KEEP_MEMBLOCK
>  	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if PPC_RADIX_MMU
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
> diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
> index 79f1c480b5eb..bb4b94444d3e 100644
> --- a/arch/powerpc/include/asm/elf.h
> +++ b/arch/powerpc/include/asm/elf.h
> @@ -127,8 +127,6 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
>  /* Notes used in ET_CORE. Note name is "SPU/<fd>/<filename>". */
>  #define NT_SPU		1
>  
> -#define ARCH_HAVE_EXTRA_ELF_NOTES
> -
>  #endif /* CONFIG_SPU_BASE */
>  
>  #ifdef CONFIG_PPC64
> diff --git a/include/linux/elf.h b/include/linux/elf.h
> index c9a46c4e183b..5c402788da19 100644
> --- a/include/linux/elf.h
> +++ b/include/linux/elf.h
> @@ -65,7 +65,7 @@ extern Elf64_Dyn _DYNAMIC [];
>  struct file;
>  struct coredump_params;
>  
> -#ifndef ARCH_HAVE_EXTRA_ELF_NOTES
> +#ifndef CONFIG_ARCH_HAVE_EXTRA_ELF_NOTES
>  static inline int elf_coredump_extra_notes_size(void) { return 0; }
>  static inline int elf_coredump_extra_notes_write(struct coredump_params *cprm) { return 0; }
>  #else
> -- 
> 2.34.1

