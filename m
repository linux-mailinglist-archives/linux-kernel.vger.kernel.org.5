Return-Path: <linux-kernel+bounces-18760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BDA82629F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 02:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EE61F21E4D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF201FC6;
	Sun,  7 Jan 2024 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Ez1akidL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C035717D8
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbc7746812so844193b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 17:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1704591774; x=1705196574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=matoZ5S2fV8t/Ms3FWjpgYbZ+hH9ZfZByV/p/hEQelk=;
        b=Ez1akidLPPN88xomlvERlqVdhWCP+WGOCEVLH7rjLrLocASuai7NFNya/+/AlpO6jF
         0thhBNyQ3uhXIEzf6IrRSUAzl/TM3fs9PBIw2S90+tQYLeUhBmnsKSRj+VkusKfstt0D
         rShXyadZWq8jFlbNhRLv9uy0HmaxaSJ+L4XGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704591774; x=1705196574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=matoZ5S2fV8t/Ms3FWjpgYbZ+hH9ZfZByV/p/hEQelk=;
        b=iVdQfBIEb6FX8OqIL2gyb7WD4mYMZqHgGkLkn70N8wbB7sicfNRdvx9GYUQAxPWm+x
         DvTk7mAz2yEXMsP6jR1Yyww8pKkOS1TPuQd3OeVok042hGnooZIM4qM8vAsN0y1w0SK2
         7m6q387XrElvUhsvi4XLmVY/ihTFD9jmf7ZYw2wY04+ES/VJVL42tmhEhFECxcW1+rsF
         HcEGceflwd3y5kg8HOWL/CZBLmxpKSCNBONH9QeJCrUJ3RMCf8A97a0Vu5BjmWNT5HKm
         7cp/VaOSrIUvPaDTRAv4H8EAbzK7GexuODsQJpV3JFZAW+goeyIYJhAIe2Vl+A4tPhvs
         UTow==
X-Gm-Message-State: AOJu0YzRKQzq3NaePEZNcsZw3Rntfi2yk9rVd3rWFhl+LldQvvIFEGLX
	7ht2gio3jMUVov9B+TzwacVVKHWYBqPyaHZ6TmVZ/5ll3u4=
X-Google-Smtp-Source: AGHT+IFJWW8JzNX6Yzr/MOCXwGIuUzfOgEE8tqgTuOd4awAl24W81lc9UOxCjEtKyyyEbW8ANyCMjw==
X-Received: by 2002:a05:6808:3a11:b0:3bb:e3d4:6694 with SMTP id gr17-20020a0568083a1100b003bbe3d46694mr2851385oib.37.1704591774623;
        Sat, 06 Jan 2024 17:42:54 -0800 (PST)
Received: from shiro.work.home.arpa ([2400:4162:2428:2ffe:618e:93fb:c5ea:6eba])
        by smtp.googlemail.com with ESMTPSA id a23-20020a17090a6d9700b0028d2521dc53sm2370585pjk.46.2024.01.06.17.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 17:42:54 -0800 (PST)
From: Daniel Palmer <daniel@0x0f.com>
To: gerg@linux-m68k.org,
	geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] m68k: Use macro to generate 68000 interrupt entry sleds
Date: Sun,  7 Jan 2024 10:42:48 +0900
Message-ID: <20240107014248.3651022-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for decoupling the plain 68000 code from
the DragonBall support clean entry.S a little bit by
using a macro to generic the interrupt sleds (needed to
put the vector number on the stack as the 68000 doesn't
do that) and use the correct numbers.

The function to call from the sled is a parameter so that
other interrupt types (i.e. autovectored ones) can specify
their handler when they are added later.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---

This is a small patch to show that I'm working on this before someone
comes along and deletes everything. For plain 68000 I have:
  - working QEMU setup using the newish m68k virt machine
  - working u-boot for mc68000 (Works on QEMU for now, will work on
    real hardware too..)
  - u-boot creates a devicetree from the bootinfo and the kernel uses
    that so things are *modern*.
  - buildroot working enough that it can generate a rootfs
  - kernel working enough that it can mount the rootfs over virtio
    and run the shell (there are some problems after that though..)

 arch/m68k/68000/entry.S | 100 ++++++++--------------------------------
 arch/m68k/68000/ints.c  |  14 +++---
 2 files changed, 27 insertions(+), 87 deletions(-)

diff --git a/arch/m68k/68000/entry.S b/arch/m68k/68000/entry.S
index 72e95663b62f..e1fc740412f2 100644
--- a/arch/m68k/68000/entry.S
+++ b/arch/m68k/68000/entry.S
@@ -23,13 +23,6 @@
 .globl ret_from_exception
 .globl sys_call_table
 .globl bad_interrupt
-.globl inthandler1
-.globl inthandler2
-.globl inthandler3
-.globl inthandler4
-.globl inthandler5
-.globl inthandler6
-.globl inthandler7
 
 badsys:
 	movel	#-ENOSYS,%sp@(PT_OFF_D0)
@@ -119,85 +112,32 @@ Lsignal_return:
 	addql	#4,%sp
 	jra	1b
 
-/*
- * This is the main interrupt handler, responsible for calling process_int()
- */
-inthandler1:
-	SAVE_ALL_INT
-	movew	%sp@(PT_OFF_FORMATVEC), %d0
-	and	#0x3ff, %d0
-
-	movel	%sp,%sp@-
-	movel	#65,%sp@- 		/*  put vector # on stack*/
-	jbsr	process_int		/*  process the IRQ*/
-3:     	addql	#8,%sp			/*  pop parameters off stack*/
-	bra	ret_from_exception
-
-inthandler2:
-	SAVE_ALL_INT
-	movew	%sp@(PT_OFF_FORMATVEC), %d0
-	and	#0x3ff, %d0
-
-	movel	%sp,%sp@-
-	movel	#66,%sp@- 		/*  put vector # on stack*/
-	jbsr	process_int		/*  process the IRQ*/
-3:     	addql	#8,%sp			/*  pop parameters off stack*/
-	bra	ret_from_exception
-
-inthandler3:
-	SAVE_ALL_INT
-	movew	%sp@(PT_OFF_FORMATVEC), %d0
-	and	#0x3ff, %d0
-
-	movel	%sp,%sp@-
-	movel	#67,%sp@- 		/*  put vector # on stack*/
-	jbsr	process_int		/*  process the IRQ*/
-3:     	addql	#8,%sp			/*  pop parameters off stack*/
-	bra	ret_from_exception
-
-inthandler4:
+/* Create an interrupt vector sled */
+ .macro inthandler num func
+	.globl inthandler\num
+	inthandler\num:
 	SAVE_ALL_INT
 	movew	%sp@(PT_OFF_FORMATVEC), %d0
 	and	#0x3ff, %d0
 
 	movel	%sp,%sp@-
-	movel	#68,%sp@- 		/*  put vector # on stack*/
-	jbsr	process_int		/*  process the IRQ*/
-3:     	addql	#8,%sp			/*  pop parameters off stack*/
-	bra	ret_from_exception
-
-inthandler5:
-	SAVE_ALL_INT
-	movew	%sp@(PT_OFF_FORMATVEC), %d0
-	and	#0x3ff, %d0
-
-	movel	%sp,%sp@-
-	movel	#69,%sp@- 		/*  put vector # on stack*/
-	jbsr	process_int		/*  process the IRQ*/
-3:     	addql	#8,%sp			/*  pop parameters off stack*/
-	bra	ret_from_exception
-
-inthandler6:
-	SAVE_ALL_INT
-	movew	%sp@(PT_OFF_FORMATVEC), %d0
-	and	#0x3ff, %d0
-
-	movel	%sp,%sp@-
-	movel	#70,%sp@- 		/*  put vector # on stack*/
-	jbsr	process_int		/*  process the IRQ*/
-3:     	addql	#8,%sp			/*  pop parameters off stack*/
-	bra	ret_from_exception
-
-inthandler7:
-	SAVE_ALL_INT
-	movew	%sp@(PT_OFF_FORMATVEC), %d0
-	and	#0x3ff, %d0
-
-	movel	%sp,%sp@-
-	movel	#71,%sp@- 		/*  put vector # on stack*/
-	jbsr	process_int		/*  process the IRQ*/
-3:     	addql	#8,%sp			/*  pop parameters off stack*/
+	/* put vector # on stack*/
+	movel	#\num,%sp@-
+	/* process the IRQ*/
+	jbsr	\func
+	/* pop parameters off stack*/
+	addql	#8,%sp
 	bra	ret_from_exception
+ .endm
+
+/* Dragonball interrupts */
+inthandler 65 process_int
+inthandler 66 process_int
+inthandler 67 process_int
+inthandler 68 process_int
+inthandler 69 process_int
+inthandler 70 process_int
+inthandler 71 process_int
 
 inthandler:
 	SAVE_ALL_INT
diff --git a/arch/m68k/68000/ints.c b/arch/m68k/68000/ints.c
index 2ba9926e91ae..3d93255c2fe4 100644
--- a/arch/m68k/68000/ints.c
+++ b/arch/m68k/68000/ints.c
@@ -63,13 +63,13 @@ asmlinkage void trap46(void);
 asmlinkage void trap47(void);
 asmlinkage irqreturn_t bad_interrupt(int, void *);
 asmlinkage irqreturn_t inthandler(void);
-asmlinkage irqreturn_t inthandler1(void);
-asmlinkage irqreturn_t inthandler2(void);
-asmlinkage irqreturn_t inthandler3(void);
-asmlinkage irqreturn_t inthandler4(void);
-asmlinkage irqreturn_t inthandler5(void);
-asmlinkage irqreturn_t inthandler6(void);
-asmlinkage irqreturn_t inthandler7(void);
+asmlinkage irqreturn_t inthandler65(void);
+asmlinkage irqreturn_t inthandler66(void);
+asmlinkage irqreturn_t inthandler67(void);
+asmlinkage irqreturn_t inthandler68(void);
+asmlinkage irqreturn_t inthandler69(void);
+asmlinkage irqreturn_t inthandler70(void);
+asmlinkage irqreturn_t inthandler71(void);
 
 /* The 68k family did not have a good way to determine the source
  * of interrupts until later in the family.  The EC000 core does
-- 
2.43.0


