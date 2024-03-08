Return-Path: <linux-kernel+bounces-97048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060CC8764DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAB228102A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6931E39FD9;
	Fri,  8 Mar 2024 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kmnlx8xi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R7iNo+Db"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FA338389
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903768; cv=none; b=K+ZhppY7/g0LLfJyudkBXY+NDVoIdhieAfFe3p9yjBReNDhZVAGAunsyVurwoFvCJ7kVtM1/46RMQCM6xSFJqUjwvzLXGAc4IHHIZ9/jSnpB+Iw2c2kMCQ2QDGd6Z4VGYM+HXoJE8/G0ZiNLIjfWLcy71KbYqeI31eWoGDcDyMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903768; c=relaxed/simple;
	bh=WzSDL7BlW/IrhKxd+zuyRvHWfwLr4VM9EFYC6/ocZ14=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=JdC1rPo+B+vb5cGivlptfv5sK1FDFuSq0BT6mxIJ+QKthQW2Z2JlsoCE1DnOX9ui9vuO7cZa332/ftm6xdqVTl0/KtAwewGlFP3ZEiGsadELRyKycoAMSLN5jzyirJCmLbhh5n4iF2OTFB+14JSS1nE4btZ+yt5W0fO193+uHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kmnlx8xi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R7iNo+Db; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id D9CC1138012F;
	Fri,  8 Mar 2024 08:16:04 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 08 Mar 2024 08:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709903764; x=1709990164; bh=5iOTB1PMb/
	41BTWQ/WiLiLX9LksL39nQPJ1pMqP5LMM=; b=kmnlx8xi4OHS/Tk9e72aO49pQ5
	kc28mpYGhQqbNLQV/jbwsQjpRmckUnqjxHfiMPaZI+BCmHJHzhn91GFGijHqu4EK
	DKzP26J5zyjrmGpDCsAFDi0iqzPGeFWkTwrA61qUrQshXUi2bAeof18oJ+QDAjs6
	shOvsKx0GFY0iTadXRkS3qosUlrY5vstPZMWYmwu3Z/qdxocb9hRzvXgkQiMUiMI
	/WZbYRACD3g8vEI0AQDuRIhc8k5iUZTv5yJwTy/R1szApDPA1qYv8fhP7pqALI2e
	g9kpR1h+zJ9kK3c6XgD1RASrygs/D9u079pdk0+ZgwtGEkTim0ce3r2XZV1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709903764; x=1709990164; bh=5iOTB1PMb/41BTWQ/WiLiLX9LksL
	39nQPJ1pMqP5LMM=; b=R7iNo+DbbxgC81MkcvLN65yShE1vhebXIBiJlmn/7LNG
	t/hR/eoNnXv2Kc6UUShU4acDLEnl2gkzhbIQdxFWeIPhzkOAPIIpn2wONNNCQssF
	uqPEtKndOjlkIb7ApjGkhc7HSOwXb9RjI0/w8CRiyzxTfKNMQWQNA4Z3uM7XdW+2
	9NXPA6nK6Kwa35aedGmD9EqDeaqUpyaq445nMPFZMwJiJEZcvSXla3B38zOD3p/i
	uSoGfbKRy6T05GR8KYx5ZPRtNCg05YydR0CO2mupx82eus3AKaEdAeQHBeyk800D
	mTdK3K3fIEjV/2sf73/yS4V4px80joCEyWvMQES3Cg==
X-ME-Sender: <xms:kw_rZbOj0larPUxKjpLlncNQ4BrDhvoMnJ5Rf_tRgayQiGzigZ0uDA>
    <xme:kw_rZV-hvKFqsONSA7zLTlGvoc02xTEOe-gwUL0RXGtVpFhHobZiJuy6PBKJ92xRf
    CIPvWyHzmxfGnmckQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieehgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevfeehfedvtdegudetfeehjeejhfdtieeijeegffevgfejudeileduteeutdff
    ieenucffohhmrghinheprghrmhhlihhnuhigrdhorhhgrdhukhdpkhgvrhhnvghlrdhorh
    hgpdhlughsrdhssgdpvghfihhsthhusgdruggrthgrpdgrrhgthhdrihhnfhhonecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrh
    hnuggsrdguvg
X-ME-Proxy: <xmx:kw_rZaRnQHPQmHoFr2vdW-jEboF2n0b33nMIODU6iQJlYAiKWKE2bw>
    <xmx:kw_rZfvknPc8QnUcWMen-4PKhR8CoUReA4WupfpcuV8xf_B2pSbWwQ>
    <xmx:kw_rZTfFLmFo1QcNbubZJx5QAoeF4HRtpWUk8SQ61-4qs1sJFvqMiQ>
    <xmx:lA_rZb_94VmBuy5C3ZTfL3Q3AH439ctaTPEk8YOlZOLqRUQaVu6liQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B5058B6008D; Fri,  8 Mar 2024 08:16:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <58cc1053-7208-4b22-99cb-210fdf700569@app.fastmail.com>
In-Reply-To: <20240307151231.654025-1-liuyuntao12@huawei.com>
References: <20240307151231.654025-1-liuyuntao12@huawei.com>
Date: Fri, 08 Mar 2024 14:15:08 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yuntao Liu" <liuyuntao12@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Ard Biesheuvel" <ardb@kernel.org>, "Fangrui Song" <maskray@google.com>
Cc: "Russell King" <linux@armlinux.org.uk>, "Andrew Davis" <afd@ti.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Jonathan Corbet" <corbet@lwn.net>, "Mike Rapoport" <rppt@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Linus Walleij" <linus.walleij@linaro.org>, llvm@lists.linux.dev
Subject: Re: [PATCH-next v2] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Type: text/plain

On Thu, Mar 7, 2024, at 16:12, Yuntao Liu wrote:
> The current arm32 architecture does not yet support the
> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. arm32 is widely used in
> embedded scenarios, and enabling this feature would be beneficial for
> reducing the size of the kernel image.
>
> In order to make this work, we keep the necessary tables by annotating
> them with KEEP, also it requires further changes to linker script to KEEP
> some tables and wildcard compiler generated sections into the right place.
>
> It boots normally with defconfig, vexpress_defconfig and tinyconfig.
>
> The size comparison of zImage is as follows:
> defconfig       vexpress_defconfig      tinyconfig
> 5137712         5138024                 424192          no dce
> 5032560         4997824                 298384          dce
> 2.0%            2.7%                    29.7%           shrink
>
> When using smaller config file, there is a significant reduction in the
> size of the zImage.
>
> We also tested this patch on a commercially available single-board
> computer, and the comparison is as follows:
> a15eb_config
> 2161384         no dce
> 2092240         dce
> 3.2%            shrink
>
> The zImage size has been reduced by approximately 3.2%, which is 70KB on
> 2.1M.
>
> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>

I've retested with both gcc-13 and clang-18, and so no
more build issues. Your previous version already worked
fine for me.

I did some tests combining this with CONFIG_TRIM_UNUSED_KSYMS,
which showed a significant improvement as expected. I also
tried combining it with an experimental CONFIG_LTO_CLANG
patch, but that did not show any further improvements.

Tested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Adding Ard Biesheuvel and Fangrui Song to Cc, so they can comment
on the ARM_VECTORS_TEXT workaround. I don't understand enough of
the details of what is going on here.

Full quote of the patch below so they can see the whole thing.

If they are also happy with the patch, I think you can send it
into Russell's patch tracker at
https://www.armlinux.org.uk/developer/patches/info.php

> ---
> v2:
>    - Support config XIP_KERNEL.
>    - Support LLVM compilation.
>
> v1: https://lore.kernel.org/all/20240220081527.23408-1-liuyuntao12@huawei.com/
> ---
>  arch/arm/Kconfig                       |  1 +
>  arch/arm/boot/compressed/vmlinux.lds.S |  4 ++--
>  arch/arm/include/asm/vmlinux.lds.h     | 18 +++++++++++++++++-
>  arch/arm/kernel/vmlinux-xip.lds.S      |  8 ++++++--
>  arch/arm/kernel/vmlinux.lds.S          | 10 +++++++---
>  5 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0af6709570d1..de78ceb821df 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -113,6 +113,7 @@ config ARM
>  	select HAVE_KERNEL_XZ
>  	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
>  	select HAVE_KRETPROBES if HAVE_KPROBES
> +	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>  	select HAVE_MOD_ARCH_SPECIFIC
>  	select HAVE_NMI
>  	select HAVE_OPTPROBES if !THUMB2_KERNEL
> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S 
> b/arch/arm/boot/compressed/vmlinux.lds.S
> index 3fcb3e62dc56..da21244aa892 100644
> --- a/arch/arm/boot/compressed/vmlinux.lds.S
> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> @@ -89,7 +89,7 @@ SECTIONS
>       * The EFI stub always executes from RAM, and runs strictly before 
> the
>       * decompressor, so we can make an exception for its r/w data, and 
> keep it
>       */
> -    *(.data.efistub .bss.efistub)
> +    *(.data.* .bss.*)
>      __pecoff_data_end = .;
> 
>      /*
> @@ -125,7 +125,7 @@ SECTIONS
> 
>    . = BSS_START;
>    __bss_start = .;
> -  .bss			: { *(.bss) }
> +  .bss			: { *(.bss .bss.*) }
>    _end = .;
> 
>    . = ALIGN(8);		/* the stack must be 64-bit aligned */
> diff --git a/arch/arm/include/asm/vmlinux.lds.h 
> b/arch/arm/include/asm/vmlinux.lds.h
> index 4c8632d5c432..dfe2b6ad6b51 100644
> --- a/arch/arm/include/asm/vmlinux.lds.h
> +++ b/arch/arm/include/asm/vmlinux.lds.h
> @@ -42,7 +42,7 @@
>  #define PROC_INFO							\
>  		. = ALIGN(4);						\
>  		__proc_info_begin = .;					\
> -		*(.proc.info.init)					\
> +		KEEP(*(.proc.info.init))				\
>  		__proc_info_end = .;
> 
>  #define IDMAP_TEXT							\
> @@ -87,6 +87,22 @@
>  		*(.vfp11_veneer)                                        \
>  		*(.v4_bx)
> 
> +/*
> +When CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is enabled, it is important 
> to
> +annotate .vectors sections with KEEP. While linking with ld, it is
> +acceptable to directly use KEEP with .vectors sections in ARM_VECTORS.
> +However, when using ld.lld for linking, KEEP is not recognized within 
> the
> +OVERLAY command; it is treated as a regular string. Hence, it is 
> advisable
> +to define a distinct section here that explicitly retains the .vectors
> +sections when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is turned on.
> +*/
> +#define ARM_VECTORS_TEXT						\
> +	.vectors.text : {						\
> +		KEEP(*(.vectors))					\
> +		KEEP(*(.vectors.bhb.loop8))				\
> +		KEEP(*(.vectors.bhb.bpiall))				\
> +       }
> +
>  #define ARM_TEXT							\
>  		IDMAP_TEXT						\
>  		__entry_text_start = .;					\
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S 
> b/arch/arm/kernel/vmlinux-xip.lds.S
> index c16d196b5aad..035fa18060b3 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -63,7 +63,7 @@ SECTIONS
>  	. = ALIGN(4);
>  	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
>  		__start___ex_table = .;
> -		ARM_MMU_KEEP(*(__ex_table))
> +		ARM_MMU_KEEP(KEEP(*(__ex_table)))
>  		__stop___ex_table = .;
>  	}
> 
> @@ -83,7 +83,7 @@ SECTIONS
>  	}
>  	.init.arch.info : {
>  		__arch_info_begin = .;
> -		*(.arch.info.init)
> +		KEEP(*(.arch.info.init))
>  		__arch_info_end = .;
>  	}
>  	.init.tagtable : {
> @@ -135,6 +135,10 @@ SECTIONS
>  	ARM_TCM
>  #endif
> 
> +#ifdef LD_DEAD_CODE_DATA_ELIMINATION
> +	ARM_VECTORS_TEXT
> +#endif
> +
>  	/*
>  	 * End of copied data. We need a dummy section to get its LMA.
>  	 * Also located before final ALIGN() as trailing padding is not stored
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index bd9127c4b451..2cfb890c93fb 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -74,7 +74,7 @@ SECTIONS
>  	. = ALIGN(4);
>  	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
>  		__start___ex_table = .;
> -		ARM_MMU_KEEP(*(__ex_table))
> +		ARM_MMU_KEEP(KEEP(*(__ex_table)))
>  		__stop___ex_table = .;
>  	}
> 
> @@ -99,7 +99,7 @@ SECTIONS
>  	}
>  	.init.arch.info : {
>  		__arch_info_begin = .;
> -		*(.arch.info.init)
> +		KEEP(*(.arch.info.init))
>  		__arch_info_end = .;
>  	}
>  	.init.tagtable : {
> @@ -116,7 +116,7 @@ SECTIONS
>  #endif
>  	.init.pv_table : {
>  		__pv_table_begin = .;
> -		*(.pv_table)
> +		KEEP(*(.pv_table))
>  		__pv_table_end = .;
>  	}

I previously asked about this bit, since it appeared that this
might prevent a lot of code from being discarded when
CONFIG_ARM_PATCH_PHYS_VIRT is set. I tested this again now,
and found this makes very little practical difference, so
it's all good.

> @@ -134,6 +134,10 @@ SECTIONS
>  	ARM_TCM
>  #endif
> 
> +#ifdef LD_DEAD_CODE_DATA_ELIMINATION
> +	ARM_VECTORS_TEXT
> +#endif
> +
>  #ifdef CONFIG_STRICT_KERNEL_RWX
>  	. = ALIGN(1<<SECTION_SHIFT);
>  #else

