Return-Path: <linux-kernel+bounces-128461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0AE895B21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA1E2866C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8836915ADA8;
	Tue,  2 Apr 2024 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNtP5E9M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004415AD8C;
	Tue,  2 Apr 2024 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080282; cv=none; b=KwmncF3bZ8K2Q02hfvMPwcelEX5LHxIN1DCXmlMzxIgQw0Gs/bSep3WxBqP7BGBZKfD/b4e28P54stpwrxgdYXt4MvXsf05hfl2Ns1ilqKaxZ/Hk9fu2YYrGSU6wuStnsi84Vx18JmD3+zBnTrherkO/JKP7A3VK3TgJbjHkRSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080282; c=relaxed/simple;
	bh=5WFj57pz2yfHy3ro+1UVQLaPmaxSgD5e6l15NEGTtrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7c6Asj2Tih7INMrn4/rRSmF9kvCaExVxU0vAhqB1Tgg+Yhts1toKNfT14MMGgfwe0Da31+6EPIu6+JK5YpYfkKlgCYtFsoWLMojBtO4rDwj6j53LhmlAqB15MqTFFDKdnoDmYUVE0afZ1onrNoUlBTKqNL1B9e3APeycByaZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNtP5E9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8360EC433F1;
	Tue,  2 Apr 2024 17:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712080282;
	bh=5WFj57pz2yfHy3ro+1UVQLaPmaxSgD5e6l15NEGTtrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNtP5E9M5TPW/JKEzMoUnnxYrNvAPh8ISI9NbsGGd4lA/0OmkJdJOqJ6H2ewjufqx
	 a8Eq61dGJIoM6vyl/gMRbxRwf94+W47nRy2R6C7j0/39YWqtA7B2khsytP6ttrpa3I
	 HobuBeln7oUGux7kxQgdeJehY/KJ7r7WGt1zGWw1kclHh3OLbkxt8q79WJGkPBm055
	 fLGKotEP4gJ8q6v0LYkIVtnWiy9SF9VZ+2B29lc36YZv/MycOUSzWVv/6b/wDLSyDQ
	 36lUYWR4i5FmY8cMOlgXm6lYVKI/KeKbxbYpjV/AhsTUarsGOYhIHlbwhyZ75D7p+D
	 g5fvMC+TB4f7A==
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	kbd@lists.linux.dev,
	linux-api@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 1/3] VT: Use macros to define ioctls
Date: Tue,  2 Apr 2024 19:50:44 +0200
Message-ID: <e4229fe2933a003341e338b558ab1ea8b63a51f6.1712080158.git.legion@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712080158.git.legion@kernel.org>
References: <74ca50e0-61b1-4d4c-85dd-a5d920548c04@kernel.org> <cover.1712080158.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All other headers use _IOC() macros to describe ioctls for a long time
now. This header is stuck in the last century.

Simply use the _IO() macro. No other changes.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/uapi/linux/kd.h | 96 +++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 47 deletions(-)

diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
index 6b384065c013..8ddb2219a84b 100644
--- a/include/uapi/linux/kd.h
+++ b/include/uapi/linux/kd.h
@@ -5,60 +5,61 @@
 #include <linux/compiler.h>
 
 /* 0x4B is 'K', to avoid collision with termios and vt */
+#define KD_IOCTL_BASE	'K'
 
-#define GIO_FONT	0x4B60	/* gets font in expanded form */
-#define PIO_FONT	0x4B61	/* use font in expanded form */
+#define GIO_FONT	_IO(KD_IOCTL_BASE, 0x60)	/* gets font in expanded form */
+#define PIO_FONT	_IO(KD_IOCTL_BASE, 0x61)	/* use font in expanded form */
 
-#define GIO_FONTX	0x4B6B	/* get font using struct consolefontdesc */
-#define PIO_FONTX	0x4B6C	/* set font using struct consolefontdesc */
+#define GIO_FONTX	_IO(KD_IOCTL_BASE, 0x6B)	/* get font using struct consolefontdesc */
+#define PIO_FONTX	_IO(KD_IOCTL_BASE, 0x6C)	/* set font using struct consolefontdesc */
 struct consolefontdesc {
 	unsigned short charcount;	/* characters in font (256 or 512) */
 	unsigned short charheight;	/* scan lines per character (1-32) */
 	char __user *chardata;		/* font data in expanded form */
 };
 
-#define PIO_FONTRESET   0x4B6D	/* reset to default font */
+#define PIO_FONTRESET	_IO(KD_IOCTL_BASE, 0x6D)	/* reset to default font */
 
-#define GIO_CMAP	0x4B70	/* gets colour palette on VGA+ */
-#define PIO_CMAP	0x4B71	/* sets colour palette on VGA+ */
+#define GIO_CMAP	_IO(KD_IOCTL_BASE, 0x70)	/* gets colour palette on VGA+ */
+#define PIO_CMAP	_IO(KD_IOCTL_BASE, 0x71)	/* sets colour palette on VGA+ */
 
-#define KIOCSOUND	0x4B2F	/* start sound generation (0 for off) */
-#define KDMKTONE	0x4B30	/* generate tone */
+#define KIOCSOUND	_IO(KD_IOCTL_BASE, 0x2F)	/* start sound generation (0 for off) */
+#define KDMKTONE	_IO(KD_IOCTL_BASE, 0x30)	/* generate tone */
 
-#define KDGETLED	0x4B31	/* return current led state */
-#define KDSETLED	0x4B32	/* set led state [lights, not flags] */
+#define KDGETLED	_IO(KD_IOCTL_BASE, 0x31)	/* return current led state */
+#define KDSETLED	_IO(KD_IOCTL_BASE, 0x32)	/* set led state [lights, not flags] */
 #define 	LED_SCR		0x01	/* scroll lock led */
 #define 	LED_NUM		0x02	/* num lock led */
 #define 	LED_CAP		0x04	/* caps lock led */
 
-#define KDGKBTYPE	0x4B33	/* get keyboard type */
+#define KDGKBTYPE	_IO(KD_IOCTL_BASE, 0x33)	/* get keyboard type */
 #define 	KB_84		0x01
 #define 	KB_101		0x02 	/* this is what we always answer */
 #define 	KB_OTHER	0x03
 
-#define KDADDIO		0x4B34	/* add i/o port as valid */
-#define KDDELIO		0x4B35	/* del i/o port as valid */
-#define KDENABIO	0x4B36	/* enable i/o to video board */
-#define KDDISABIO	0x4B37	/* disable i/o to video board */
+#define KDADDIO		_IO(KD_IOCTL_BASE, 0x34)	/* add i/o port as valid */
+#define KDDELIO		_IO(KD_IOCTL_BASE, 0x35)	/* del i/o port as valid */
+#define KDENABIO	_IO(KD_IOCTL_BASE, 0x36)	/* enable i/o to video board */
+#define KDDISABIO	_IO(KD_IOCTL_BASE, 0x37)	/* disable i/o to video board */
 
-#define KDSETMODE	0x4B3A	/* set text/graphics mode */
+#define KDSETMODE	_IO(KD_IOCTL_BASE, 0x3A)	/* set text/graphics mode */
 #define		KD_TEXT		0x00
 #define		KD_GRAPHICS	0x01
 #define		KD_TEXT0	0x02	/* obsolete */
 #define		KD_TEXT1	0x03	/* obsolete */
-#define KDGETMODE	0x4B3B	/* get current mode */
+#define KDGETMODE	_IO(KD_IOCTL_BASE, 0x3B)	/* get current mode */
 
-#define KDMAPDISP	0x4B3C	/* map display into address space */
-#define KDUNMAPDISP	0x4B3D	/* unmap display from address space */
+#define KDMAPDISP	_IO(KD_IOCTL_BASE, 0x3C)	/* map display into address space */
+#define KDUNMAPDISP	_IO(KD_IOCTL_BASE, 0x3D)	/* unmap display from address space */
 
 typedef char scrnmap_t;
 #define		E_TABSZ		256
-#define GIO_SCRNMAP	0x4B40	/* get screen mapping from kernel */
-#define PIO_SCRNMAP	0x4B41	/* put screen mapping table in kernel */
-#define GIO_UNISCRNMAP  0x4B69	/* get full Unicode screen mapping */
-#define PIO_UNISCRNMAP  0x4B6A  /* set full Unicode screen mapping */
+#define GIO_SCRNMAP	_IO(KD_IOCTL_BASE, 0x40)	/* get screen mapping from kernel */
+#define PIO_SCRNMAP	_IO(KD_IOCTL_BASE, 0x41)	/* put screen mapping table in kernel */
+#define GIO_UNISCRNMAP	_IO(KD_IOCTL_BASE, 0x69)	/* get full Unicode screen mapping */
+#define PIO_UNISCRNMAP	_IO(KD_IOCTL_BASE, 0x6A)	/* set full Unicode screen mapping */
 
-#define GIO_UNIMAP	0x4B66	/* get unicode-to-font mapping from kernel */
+#define GIO_UNIMAP	_IO(KD_IOCTL_BASE, 0x66)	/* get unicode-to-font mapping from kernel */
 struct unipair {
 	unsigned short unicode;
 	unsigned short fontpos;
@@ -67,8 +68,8 @@ struct unimapdesc {
 	unsigned short entry_ct;
 	struct unipair __user *entries;
 };
-#define PIO_UNIMAP	0x4B67	/* put unicode-to-font mapping in kernel */
-#define PIO_UNIMAPCLR	0x4B68	/* clear table, possibly advise hash algorithm */
+#define PIO_UNIMAP	_IO(KD_IOCTL_BASE, 0x67)	/* put unicode-to-font mapping in kernel */
+#define PIO_UNIMAPCLR	_IO(KD_IOCTL_BASE, 0x68)	/* clear table, possibly advise hash algorithm */
 struct unimapinit {
 	unsigned short advised_hashsize;  /* 0 if no opinion */
 	unsigned short advised_hashstep;  /* 0 if no opinion */
@@ -83,19 +84,19 @@ struct unimapinit {
 #define		K_MEDIUMRAW	0x02
 #define		K_UNICODE	0x03
 #define		K_OFF		0x04
-#define KDGKBMODE	0x4B44	/* gets current keyboard mode */
-#define KDSKBMODE	0x4B45	/* sets current keyboard mode */
+#define KDGKBMODE	_IO(KD_IOCTL_BASE, 0x44)	/* gets current keyboard mode */
+#define KDSKBMODE	_IO(KD_IOCTL_BASE, 0x45)	/* sets current keyboard mode */
 
 #define		K_METABIT	0x03
 #define		K_ESCPREFIX	0x04
-#define KDGKBMETA	0x4B62	/* gets meta key handling mode */
-#define KDSKBMETA	0x4B63	/* sets meta key handling mode */
+#define KDGKBMETA	_IO(KD_IOCTL_BASE, 0x62)	/* gets meta key handling mode */
+#define KDSKBMETA	_IO(KD_IOCTL_BASE, 0x63)	/* sets meta key handling mode */
 
 #define		K_SCROLLLOCK	0x01
 #define		K_NUMLOCK	0x02
 #define		K_CAPSLOCK	0x04
-#define	KDGKBLED	0x4B64	/* get led flags (not lights) */
-#define	KDSKBLED	0x4B65	/* set led flags (not lights) */
+#define	KDGKBLED	_IO(KD_IOCTL_BASE, 0x64)	/* get led flags (not lights) */
+#define	KDSKBLED	_IO(KD_IOCTL_BASE, 0x65)	/* set led flags (not lights) */
 
 struct kbentry {
 	unsigned char kb_table;
@@ -107,15 +108,15 @@ struct kbentry {
 #define		K_ALTTAB	0x02
 #define		K_ALTSHIFTTAB	0x03
 
-#define KDGKBENT	0x4B46	/* gets one entry in translation table */
-#define KDSKBENT	0x4B47	/* sets one entry in translation table */
+#define KDGKBENT	_IO(KD_IOCTL_BASE, 0x46)	/* gets one entry in translation table */
+#define KDSKBENT	_IO(KD_IOCTL_BASE, 0x47)	/* sets one entry in translation table */
 
 struct kbsentry {
 	unsigned char kb_func;
 	unsigned char kb_string[512];
 };
-#define KDGKBSENT	0x4B48	/* gets one function key string entry */
-#define KDSKBSENT	0x4B49	/* sets one function key string entry */
+#define KDGKBSENT	_IO(KD_IOCTL_BASE, 0x48)	/* gets one function key string entry */
+#define KDSKBSENT	_IO(KD_IOCTL_BASE, 0x49)	/* sets one function key string entry */
 
 struct kbdiacr {
         unsigned char diacr, base, result;
@@ -124,8 +125,8 @@ struct kbdiacrs {
         unsigned int kb_cnt;    /* number of entries in following array */
 	struct kbdiacr kbdiacr[256];    /* MAX_DIACR from keyboard.h */
 };
-#define KDGKBDIACR      0x4B4A  /* read kernel accent table */
-#define KDSKBDIACR      0x4B4B  /* write kernel accent table */
+#define KDGKBDIACR	_IO(KD_IOCTL_BASE, 0x4A)  /* read kernel accent table */
+#define KDSKBDIACR	_IO(KD_IOCTL_BASE, 0x4B)  /* write kernel accent table */
 
 struct kbdiacruc {
 	unsigned int diacr, base, result;
@@ -134,16 +135,16 @@ struct kbdiacrsuc {
         unsigned int kb_cnt;    /* number of entries in following array */
 	struct kbdiacruc kbdiacruc[256];    /* MAX_DIACR from keyboard.h */
 };
-#define KDGKBDIACRUC    0x4BFA  /* read kernel accent table - UCS */
-#define KDSKBDIACRUC    0x4BFB  /* write kernel accent table - UCS */
+#define KDGKBDIACRUC	_IO(KD_IOCTL_BASE, 0xFA)  /* read kernel accent table - UCS */
+#define KDSKBDIACRUC	_IO(KD_IOCTL_BASE, 0xFB)  /* write kernel accent table - UCS */
 
 struct kbkeycode {
 	unsigned int scancode, keycode;
 };
-#define KDGETKEYCODE	0x4B4C	/* read kernel keycode table entry */
-#define KDSETKEYCODE	0x4B4D	/* write kernel keycode table entry */
+#define KDGETKEYCODE	_IO(KD_IOCTL_BASE, 0x4C)	/* read kernel keycode table entry */
+#define KDSETKEYCODE	_IO(KD_IOCTL_BASE, 0x4D)	/* write kernel keycode table entry */
 
-#define KDSIGACCEPT	0x4B4E	/* accept kbd generated signals */
+#define KDSIGACCEPT	_IO(KD_IOCTL_BASE, 0x4E)	/* accept kbd generated signals */
 
 struct kbd_repeat {
 	int delay;	/* in msec; <= 0: don't change */
@@ -151,10 +152,11 @@ struct kbd_repeat {
 			/* earlier this field was misnamed "rate" */
 };
 
-#define KDKBDREP        0x4B52  /* set keyboard delay/repeat rate;
-				 * actually used values are returned */
+#define KDKBDREP	_IO(KD_IOCTL_BASE, 0x52)	/* set keyboard delay/repeat rate;
+							 * actually used values are returned
+							 */
 
-#define KDFONTOP	0x4B72	/* font operations */
+#define KDFONTOP	_IO(KD_IOCTL_BASE, 0x72)	/* font operations */
 
 struct console_font_op {
 	unsigned int op;	/* operation code KD_FONT_OP_* */
-- 
2.44.0


