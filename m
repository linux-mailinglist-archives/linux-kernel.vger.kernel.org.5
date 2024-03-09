Return-Path: <linux-kernel+bounces-97806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC05876FC2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922DA1C20A0D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB823717B;
	Sat,  9 Mar 2024 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="D1MVVyTa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TTAM/JVG"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90411249F5
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709972452; cv=none; b=sgFPSJXgqmchQGCmoUKpFWf4ExjgQSoDFQXr1UfK3FH1JBXzXBVFUka544fqY0e5IpPOjzeHlIj0piprKeIiKia/xijx1WBNJx/Tywm5wx/fqBSDqkxaPUzHfgMVcnp82xTyK00pX2ND9ryMlic2PonbldyROnqxvdZ0u/ZaoC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709972452; c=relaxed/simple;
	bh=yflydMTLwkTf9u1r8dKppMT9BpeV+YA/TPw9GxCivlI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=W5FsVIZnrEn0lwO4culP6/xxsZFHkCKsy0lvJu8fFpS9xEAsiU5SuODQ94XW8kLSDhfHYCsB2wLsU/2kcE7nsI7jWkI/LMT/Dk1QqFYubRho2EQphG8wGh2wVb86VhCkbO8K6xnO5iKtCC9JGNssCQ5p4irXo+PXXXjOJSNex1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=D1MVVyTa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TTAM/JVG; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 59D56320094F;
	Sat,  9 Mar 2024 03:20:47 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 09 Mar 2024 03:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709972446; x=1710058846; bh=O/clYP0WT8
	TUfViTy/TttNTQQUBUVKt6xrQJBXMtImQ=; b=D1MVVyTaCd9rPXCWN4kBea+RoR
	rThRfAAc7XEsLNRPm9dthQw0ev3LoiXkkQZ/3v5wZL4vjqF49ijxdeY/eKX4zapj
	VjR+op9PjCymkw+Ax2+lLLm93AWCEy+66OdL4o9RX2YYCOyB8N50awH/gfXdeQZ9
	43whi1JZvcCaYP/PpXmyLhgm67RW88PXCGD8Ucg6IGR/VnKArdptCxjoMU63rSm8
	pwP/P3GbKFAhpJt59jX9Bg4uw2JtqXj9+3klUXkLF65xPVKHEHUnPXmSSu2AlVtA
	fvoVqYpV7PCLexwQ4eXNYT5XefT3k7OYFP5AHZpSOCIi26nbBVFEERs3YjDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709972446; x=1710058846; bh=O/clYP0WT8TUfViTy/TttNTQQUBU
	VKt6xrQJBXMtImQ=; b=TTAM/JVGEx2vhnSHIkGonKp8wJBC8rlsGkn6rs9pZirS
	1wpobtGRPEUpwuDHlWmt/NIwn9c47WITKiOm5+6um49vG2Mfzkr5/mxNYhqfLkTo
	+PKCZhyqiMKrvEGUJiYd3RMoy7ob20YCxI6hKZf5JB2xkxalHFde6rznBJAxu1bT
	n/GhhKuaQ2UOxvA26TKuzLCe3nLnv2i+gQOyOR6/EClICxqkkYG/al9fsZf2PcwD
	b4Xwv8xNZ4/2dhCmtT1OU7oVhN+g2BulZb0dw0W0r61310ELr72Xdp1rFaus2iFz
	qLRpWvMc/sHQDI2egDDA13HkS4cOSv1xcwfVhtL5bg==
X-ME-Sender: <xms:3RvsZUm2KLpBMakmCTmMXKcBihTbCvJ7oxsg0R6VMZLKa6qF5zYQYQ>
    <xme:3RvsZT1PXXjMdUhmIRwP6Q6B0XIVh3tBNi0uDOV9POp2ncQxZhnWoSDvizM_K85C1
    R608e_yW6WXBVU4w9c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieeigdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:3RvsZSrjh_4PDYRwoph-2-li7CGQPaCO7Slb52rqeKuIDuHSPJmiHA>
    <xmx:3RvsZQnhjpFogUHUCMnewOzcnQiwTRxQiYgpNv0j26MH1zQxtjXMlw>
    <xmx:3RvsZS2rk9ZJdqPJGURPz3ud6ZPV5wP2yW2S2yYWYu8zOZC8Wm8T5g>
    <xmx:3hvsZcOWj8LsWlwahjvA6n_Keg6GU-v9Acb4UGtmPDiPFx_wO_ZLaw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8AA17B6008D; Sat,  9 Mar 2024 03:20:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2a90581c-f1df-4d6b-8f0b-8e7cbf150ed9@app.fastmail.com>
In-Reply-To: <42892794-7668-4eb0-8d2f-c78ca0daf370@huawei.com>
References: <20240307151231.654025-1-liuyuntao12@huawei.com>
 <58cc1053-7208-4b22-99cb-210fdf700569@app.fastmail.com>
 <42892794-7668-4eb0-8d2f-c78ca0daf370@huawei.com>
Date: Sat, 09 Mar 2024 09:20:15 +0100
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

On Sat, Mar 9, 2024, at 07:14, liuyuntao (F) wrote:
> On 2024/3/8 21:15, Arnd Bergmann wrote:
>> On Thu, Mar 7, 2024, at 16:12, Yuntao Liu wrote:
>
> Thanks for the tests, CONFIG_LD_DEAD_CODE_DATA_ELIMINATION and 
> CONFIG_TRIM_UNUSED_KSYMS do indeed result in a significant improvement.
> I found that arm32 still doesn't support CONFIG_LTO_CLANG. I've done 
> some work on it, but without success. I'd like to learn more about the 
> CONFIG_LTO_CLANG patch. Do you have any relevant links?

I did not try to get it to boot and gave up when I did not see
any size improvement. I think there were previous attempts to
do it elsewhere, which I did not try to find.

The patch below makes it build, but it still requires disabling
CONFIG_THUMB2_KERNEL, which totally defeats the purpose of shrinking
the kernel as it adds some 40% size overhead in the vmlinux.
There are probably also runtime bugs that get introduced by this.

     Arnd

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index de78ceb821df..7ebfda4839e8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2,6 +2,8 @@
 config ARM
 	bool
 	default y
+	select ARCH_SUPPORTS_LTO_CLANG
+	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_32BIT_OFF_T
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES && FRAME_POINTER && !ARM_UNWIND
 	select ARCH_HAS_BINFMT_FLAT
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 726ecabcef09..f2ddce451ab9 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -9,6 +9,8 @@ OBJS		=
 
 HEAD	= head.o
 OBJS	+= misc.o decompress.o
+CFLAGS_REMOVE_misc.o += $(CC_FLAGS_LTO)
+CFLAGS_REMOVE_decompress.o += $(CC_FLAGS_LTO)
 ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
 OBJS	+= debug.o
 AFLAGS_head.o += -DDEBUG
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index d19d140a10c7..aee9e13023a8 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -38,15 +38,14 @@ EXPORT_SYMBOL(arm_heavy_mb);
 static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
 {
 	unsigned long to = FLUSH_ALIAS_START + (CACHE_COLOUR(vaddr) << PAGE_SHIFT);
-	const int zero = 0;
 
 	set_top_pte(to, pfn_pte(pfn, PAGE_KERNEL));
 
-	asm(	"mcrr	p15, 0, %1, %0, c14\n"
-	"	mcr	p15, 0, %2, c7, c10, 4"
+	asm("mcrr	p15, 0, %1, %0, c14"
 	    :
-	    : "r" (to), "r" (to + PAGE_SIZE - 1), "r" (zero)
+	    : "r" (to), "r" (to + PAGE_SIZE - 1)
 	    : "cc");
+	dsb();
 }
 
 static void flush_icache_alias(unsigned long pfn, unsigned long vaddr, unsigned long len)
@@ -68,11 +67,11 @@ void flush_cache_mm(struct mm_struct *mm)
 	}
 
 	if (cache_is_vipt_aliasing()) {
-		asm(	"mcr	p15, 0, %0, c7, c14, 0\n"
-		"	mcr	p15, 0, %0, c7, c10, 4"
+		asm("mcr	p15, 0, %0, c7, c14, 0"
 		    :
 		    : "r" (0)
 		    : "cc");
+		dsb();
 	}
 }
 
@@ -84,11 +83,11 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
 	}
 
 	if (cache_is_vipt_aliasing()) {
-		asm(	"mcr	p15, 0, %0, c7, c14, 0\n"
-		"	mcr	p15, 0, %0, c7, c10, 4"
+		asm("mcr	p15, 0, %0, c7, c14, 0"
 		    :
 		    : "r" (0)
 		    : "cc");
+		dsb();
 	}
 
 	if (vma->vm_flags & VM_EXEC)

