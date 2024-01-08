Return-Path: <linux-kernel+bounces-19278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67A6826ABC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F3E2822A7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAA813FF6;
	Mon,  8 Jan 2024 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Ld18rbZ1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974312B87
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dc20b4595bso1349542a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1704706353; x=1705311153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfdL1VvrUAffk+JEt/9C7vAUDoa3/sBqju5Vv3smMQQ=;
        b=Ld18rbZ1Y5wcUbVQYH428vzwZALY9KghdXoh/2OHSl1X2Ge4ktao7m6JKMSJFb8A79
         XHJLe6dJRdb1u9ok5/xjs9JA2qrdZdZEJjFKMZOYv4xBSJ2RJV/xGeNLMx3JTQkrdDkk
         TY/VW++NW1xhOZA0CxI/Zsby5+irfwx3jPoc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706353; x=1705311153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfdL1VvrUAffk+JEt/9C7vAUDoa3/sBqju5Vv3smMQQ=;
        b=gNhiQuZlner/AgzeCxLV3YQqltJN3nDN2Zbewhk/oWSQFTJMzJuRrSFgNGn8CQ9w/C
         NeWcxPzESg74zPyNRmZmT4A3L7Nizg8qAz2sGeIp8rbTDW2eAahQGgrPY9EzoYaMPYi6
         L+i9gUy03TRULvWe6wmDdZ/ZQvSK41vZmf8zGJ7uqUCSbN5vQ77wXpGGzmD7NXr1zZPI
         gZvpTy2slLWxOuEIMceEfuvB/YKI5UFS6kYO0TagQQ4zbDL9Pfd+4ArlE5XODSOLOXnJ
         wnMcvfZGd44Ne7KCZXkaupNDtJlHgApkR+8zRJSaQPCxkFKlMJGLx6n04qTNFOU4Fls4
         bzJQ==
X-Gm-Message-State: AOJu0Yz2IaMMGgGxiraiWNKKCtg9ngxHOuDsA7GbLWnVrAag5MNK+fbf
	AybaX3dBU3EGgV0ouQUZ57vUwUvx78hMcA6Ua3BqN/wxnwA=
X-Google-Smtp-Source: AGHT+IHOfqcx1LisFMsghCeAdvBasVv/c4m8FJbkf6lrgBZPAPZGqSJTbJFW/Lb7JJGqlKNxTU388A==
X-Received: by 2002:a9d:590a:0:b0:6db:fe20:fc1c with SMTP id t10-20020a9d590a000000b006dbfe20fc1cmr2517182oth.63.1704706352778;
        Mon, 08 Jan 2024 01:32:32 -0800 (PST)
Received: from shiro.work.home.arpa ([2400:4162:2428:2ffe:a221:b29b:7116:6ce9])
        by smtp.googlemail.com with ESMTPSA id i8-20020a632208000000b005cdbebd61d8sm5578974pgi.9.2024.01.08.01.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:32:32 -0800 (PST)
From: Daniel Palmer <daniel@0x0f.com>
To: gerg@linux-m68k.org,
	geert@linux-m68k.org,
	fthain@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 2/2] m68k: Fix interrupt stack frames for 68000
Date: Mon,  8 Jan 2024 18:32:21 +0900
Message-ID: <20240108093221.1477020-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108093221.1477020-1-daniel@0x0f.com>
References: <20240108093221.1477020-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The plain old 68000 does not push the frame type/vector on the
stack when an interrupt starts like the brand new 68010 does.

This means that currently everything in struct pt_regs is
a bit off because it expects the processor to push an extra
short before the kernel interrupt code adds the rest.

In entry.S for the 68000 we already need to manually put
the vector number on the stack to work out what interrupt
is being handled because the cpu doesn't push that to the
stack.

So we can jiggle this around a bit to fix the issue:
- For 68000 use the same struct pt_regs layout as coldfire
  where frame/vector is after pc and sp.
- In entry.S push the vector number first, the stack pointer
  now lines up with the sktadj field in pt_regs and when saving
  the remaining registers the offsets match the fields in the
  struct.
- Remove the vec argument from the DragonBall interrupt
  decoding logic as it's not pushed on the stack anymore
  and not used either way.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/m68k/68000/entry.S             | 9 ++++-----
 arch/m68k/68000/ints.c              | 2 +-
 arch/m68k/include/asm/entry.h       | 3 +++
 arch/m68k/include/uapi/asm/ptrace.h | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/68000/entry.S b/arch/m68k/68000/entry.S
index e1fc740412f2..58c64656713a 100644
--- a/arch/m68k/68000/entry.S
+++ b/arch/m68k/68000/entry.S
@@ -54,6 +54,7 @@ do_trace:
 	jra	ret_from_exception
 
 ENTRY(system_call)
+	movew	#32,%sp@-
 	SAVE_ALL_SYS
 
 	/* save top of frame*/
@@ -116,17 +117,15 @@ Lsignal_return:
  .macro inthandler num func
 	.globl inthandler\num
 	inthandler\num:
+	movew	#\num,%sp@-
 	SAVE_ALL_INT
-	movew	%sp@(PT_OFF_FORMATVEC), %d0
-	and	#0x3ff, %d0
 
+	/* Push frame address onto stack */
 	movel	%sp,%sp@-
-	/* put vector # on stack*/
-	movel	#\num,%sp@-
 	/* process the IRQ*/
 	jbsr	\func
 	/* pop parameters off stack*/
-	addql	#8,%sp
+	addql	#4,%sp
 	bra	ret_from_exception
  .endm
 
diff --git a/arch/m68k/68000/ints.c b/arch/m68k/68000/ints.c
index e721932e495d..67c8f9e000ca 100644
--- a/arch/m68k/68000/ints.c
+++ b/arch/m68k/68000/ints.c
@@ -77,7 +77,7 @@ asmlinkage irqreturn_t inthandler71(void);
  * into one vector and look in the blasted mask register...
  * This code is designed to be fast, almost constant time, not clean!
  */
-asmlinkage void process_int(int vec, struct pt_regs *fp)
+asmlinkage void process_int(struct pt_regs *fp)
 {
 	int irq;
 	int mask;
diff --git a/arch/m68k/include/asm/entry.h b/arch/m68k/include/asm/entry.h
index 9b52b060c76a..71396c948162 100644
--- a/arch/m68k/include/asm/entry.h
+++ b/arch/m68k/include/asm/entry.h
@@ -184,6 +184,7 @@
  * that the stack frame is NOT for syscall
  */
 .macro SAVE_ALL_INT
+					/* entry.S should populate the vector */
 	clrl	%sp@-			/* stk_adj */
 	pea	-1:w			/* orig d0 */
 	movel	%d0,%sp@-		/* d0 */
@@ -191,6 +192,7 @@
 .endm
 
 .macro SAVE_ALL_SYS
+					/* entry.S should populate the vector */
 	clrl	%sp@-			/* stk_adj */
 	movel	%d0,%sp@-		/* orig d0 */
 	movel	%d0,%sp@-		/* d0 */
@@ -202,6 +204,7 @@
 	movel	%sp@+,%d0
 	addql	#4,%sp			/* orig d0 */
 	addl	%sp@+,%sp		/* stk adj */
+	addql	#2,%sp			/* entry.S populated vector */
 	rte
 .endm
 
diff --git a/arch/m68k/include/uapi/asm/ptrace.h b/arch/m68k/include/uapi/asm/ptrace.h
index 5b50ea592e00..49d7829df77c 100644
--- a/arch/m68k/include/uapi/asm/ptrace.h
+++ b/arch/m68k/include/uapi/asm/ptrace.h
@@ -39,7 +39,7 @@ struct pt_regs {
   long     d0;
   long     orig_d0;
   long     stkadj;
-#ifdef CONFIG_COLDFIRE
+#if defined(CONFIG_COLDFIRE) || defined(CONFIG_M68000)
   unsigned format :  4; /* frame format specifier */
   unsigned vector : 12; /* vector offset */
   unsigned short sr;
-- 
2.43.0


