Return-Path: <linux-kernel+bounces-97993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15F687732A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875531F21FE1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47DB605BD;
	Sat,  9 Mar 2024 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohxGrzV8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE215495CB;
	Sat,  9 Mar 2024 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710008149; cv=none; b=B/420UwsdcWlqGo6ih1UcP7E/78uemuZPMKMTJ/gW2stREeDlLVmUwDhOEKKQnQq0ITwxBDHt1WIfpkXBJimtIS8ANwmm4xtpVAAp8X8wVLh7Pn0yXO0knuD0vpf2p7rpWAidHqijlzwkhcnuHDonm4AsH4eToarLnbzw4ZyQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710008149; c=relaxed/simple;
	bh=gN/Ux84r26F4SIDmLoJJKxRQzomkv5eOdwj3wuiudB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SRSLNlzqn53c1HxDpFxgdclsA4GtIShrq6zP0zVvDSMPa7BvpeSfgL3rgRgJjH+ztKJsBlE51C6KYy2vJVKhNR5FWnWiX1RZM7j8yw2ETliP8DQ+VKk0eaaS4rvVXUqderu5aOk/W7d5Bg2Ty/itE8mAYxDC3Vkmq8y+FI0n3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohxGrzV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9CBEC41613;
	Sat,  9 Mar 2024 18:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710008149;
	bh=gN/Ux84r26F4SIDmLoJJKxRQzomkv5eOdwj3wuiudB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ohxGrzV8A8ttDa+X45jbG6/LLg3B/15gZawQKrWsWsKw6ZYTUtDVzxd7yRquRrroT
	 FTImCR63ODZ/19tcyby6EEwbIkqAhB9Vo/+K8klH+KMEM7bjE/DcYU4A1f+b2lzdsH
	 lY+/bjJmCRQdoJDwsDA4Gy38sz4WoBxLdrnK9CRzefjd8aqmNYBvAmIQSZHPX73WZ0
	 Ck5jSytkASf/qmZ0NlyHNBCsaAEYcbGD3OgOClfY10TReQAYPBzd9jj5iUgf32AhC5
	 iLB6SvUCETWm5ydZiW4NsMbbmWJ/rE3G10RvVq79jOPUxmlxiA11ItKWDlax9mIyke
	 jyrRUCmMQjgmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983DDC54E64;
	Sat,  9 Mar 2024 18:15:49 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 09 Mar 2024 19:15:38 +0100
Subject: [PATCH v2 17/28] sparc32: Drop run-time cpuid patching
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-sunset-v2-17-f09912574d2c@ravnborg.org>
References: <20240309-sunset-v2-0-f09912574d2c@ravnborg.org>
In-Reply-To: <20240309-sunset-v2-0-f09912574d2c@ravnborg.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Arnd Bergmann <arnd@kernel.org>, Andreas Larsson <andreas@gaisler.com>
Cc: Helge Deller <deller@gmx.de>, Randy Dunlap <rdunlap@infradead.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Kjetil Oftedal <oftedal@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, sparclinux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710008145; l=3320;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=WR8i3LCeKk7owTDWXkof95pLgCJqOcU2bM6i301Ih2U=; =?utf-8?q?b=3DVjlQ98TX1IGm?=
 =?utf-8?q?687O50jMVaij7sN1LUtJUqv1Eywc/sYeED2dOJcakgTZ+E+KOnHFZ2Rko3l1qDQN?=
 PQqmaoJ9BDRqL2xIwfwVqMl5df8diD7bJ7hbGduAjzZw7rQ64ZMH
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

The CPU is always leon, so the run-time cpuid patching is no longer
required.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reported-by: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/winmacro.h | 12 ------------
 arch/sparc/kernel/entry.S         | 13 -------------
 arch/sparc/kernel/setup_32.c      | 31 -------------------------------
 3 files changed, 56 deletions(-)

diff --git a/arch/sparc/include/asm/winmacro.h b/arch/sparc/include/asm/winmacro.h
index b6e911f5d93c..16144900bd6c 100644
--- a/arch/sparc/include/asm/winmacro.h
+++ b/arch/sparc/include/asm/winmacro.h
@@ -105,21 +105,9 @@
 
 #ifdef CONFIG_SMP
 #define LOAD_CURRENT(dest_reg, idreg) 			\
-661:	rd	%tbr, %idreg;				\
-	srl	%idreg, 10, %idreg;			\
-	and	%idreg, 0xc, %idreg;			\
-	.section	.cpuid_patch, "ax";		\
-	/* Instruction location. */			\
-	.word		661b;				\
-	/* SUN4D implementation. */			\
-	lda	 [%g0] ASI_M_VIKING_TMP1, %idreg;	\
-	sll	 %idreg, 2, %idreg;			\
-	nop;						\
-	/* LEON implementation. */			\
 	rd 	%asr17, %idreg;				\
 	srl	%idreg, 0x1c, %idreg;			\
 	sll	%idreg, 0x02, %idreg;			\
-	.previous;					\
 	sethi    %hi(current_set), %dest_reg; 		\
 	or       %dest_reg, %lo(current_set), %dest_reg;\
 	ld       [%idreg + %dest_reg], %dest_reg;
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 0f2417ee3f95..f158cbca3e62 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -984,21 +984,8 @@ flushw_all:
 
 #ifdef CONFIG_SMP
 ENTRY(hard_smp_processor_id)
-661:	rd		%tbr, %g1
-	srl		%g1, 12, %o0
-	and		%o0, 3, %o0
-	.section	.cpuid_patch, "ax"
-	/* Instruction location. */
-	.word		661b
-	/* SUN4D implementation. */
-	lda		[%g0] ASI_M_VIKING_TMP1, %o0
-	nop
-	nop
-	/* LEON implementation. */
 	rd		%asr17, %o0
 	srl		%o0, 0x1c, %o0
-	nop
-	.previous
 	retl
 	 nop
 ENDPROC(hard_smp_processor_id)
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 0f38d72aae2d..af5f143ed882 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -178,34 +178,6 @@ extern int root_mountflags;
 
 char reboot_command[COMMAND_LINE_SIZE];
 
-struct cpuid_patch_entry {
-	unsigned int	addr;
-	unsigned int	sun4d[3];
-	unsigned int	leon[3];
-};
-extern struct cpuid_patch_entry __cpuid_patch, __cpuid_patch_end;
-
-static void __init per_cpu_patch(void)
-{
-	struct cpuid_patch_entry *p;
-
-	p = &__cpuid_patch;
-	while (p < &__cpuid_patch_end) {
-		unsigned long addr = p->addr;
-		unsigned int *insns;
-
-		insns = &p->leon[0];
-		*(unsigned int *) (addr + 0) = insns[0];
-		flushi(addr + 0);
-		*(unsigned int *) (addr + 4) = insns[1];
-		flushi(addr + 4);
-		*(unsigned int *) (addr + 8) = insns[2];
-		flushi(addr + 8);
-
-		p++;
-	}
-}
-
 static __init void leon_patch(void)
 {
 	/* Default instruction is leon - no patching */
@@ -271,9 +243,6 @@ void __init setup_arch(char **cmdline_p)
 		(*(linux_dbvec->teach_debugger))();
 	}
 
-	/* Run-time patch instructions to match the cpu model */
-	per_cpu_patch();
-
 	paging_init();
 
 	smp_setup_cpu_possible_map();

-- 
2.34.1


