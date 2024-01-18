Return-Path: <linux-kernel+bounces-29792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310E38313A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EC21C2276E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABF9200A7;
	Thu, 18 Jan 2024 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6jSTSFK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A9A1F94C;
	Thu, 18 Jan 2024 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564693; cv=none; b=eu1wR/cBz432glGKP85X50WTMPi4i34Pz75ygwioutCD8jkU+mJ+12ijE9N3hWI/SmuhkMBAd1VJPai3KV5ImrtxV/HiXVcVgW68W9VvyCLLVYfjtu2r0uQ3yc2OSAQOPjlStMSA5o4tfD2IzqQQKmohiQ4/57V1t3RddhjuuG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564693; c=relaxed/simple;
	bh=fU5lhbNNKhE9QJg5290En/idxniF3ADSYx6DwAHG79Q=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=iDLWzJZgQZuc9gIg/p5cVF/dygtGS1M+zZjo6kZAeR8d9QVuKhd2CXqJ8CxKD+6nILhIoVvojuInHOSjZCtWEyDJNwGz4RB/pbgdqwHzmfkVARTOEDD2RVIcnR/gh36X0eZ2SHfmz1yZ8wr+jm3n5OKskAySa1N7xz7W7eJy/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6jSTSFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70793C433F1;
	Thu, 18 Jan 2024 07:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564692;
	bh=fU5lhbNNKhE9QJg5290En/idxniF3ADSYx6DwAHG79Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6jSTSFKdyXYvQ2xHjDhKeuNXZgLJW65KJz7evGZ3URMzEXTzXfM2mnPdbrQNT4HF
	 ZAp4ouwq/15OO7ocilCYQ0U+ynyRk2QaFxZIhYmdHezZGENb3gU6CgTDsDmFO5ueVQ
	 hqAjmksRFEQ4VULcpkKeWFqffXxUoK2yqMPXZmabLiLKMUbxV08Xl8OqFLZClwTFCa
	 hqo7pNMADYZIiB/w8W1p2NlrxkZg2RrzJb9mMKCh7Jb7pvsm53V8yBQ0VmaDdUgS/2
	 Az5eVkEOKLBhBp0GktCe7/IiseLhgKJNVslj3pPaqVBqcng2ihFaPiXMu8OKNd0Wix
	 DKXLg2/GkTQvg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 05/45] tty: vt: pass proper pointers from tioclinux()
Date: Thu, 18 Jan 2024 08:57:16 +0100
Message-ID: <20240118075756.10541-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118075756.10541-1-jirislaby@kernel.org>
References: <20240118075756.10541-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass proper types and proper pointers (the data with an offset) to the
TIOCL_* handlers. So that they need not to cast or add anything to the
passed pointer.

This makes obvious what is passed/consumed.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/selection.c |  8 ++++----
 drivers/tty/vt/vt.c        | 19 ++++++++++---------
 include/linux/selection.h  |  2 +-
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 8967c3a0d916..e172ede235a0 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -7,7 +7,7 @@
  *     'int set_selection_kernel(struct tiocl_selection *, struct tty_struct *)'
  *     'void clear_selection(void)'
  *     'int paste_selection(struct tty_struct *)'
- *     'int sel_loadlut(char __user *)'
+ *     'int sel_loadlut(u32 __user *)'
  *
  * Now that /dev/vcs exists, most of this can disappear again.
  */
@@ -111,15 +111,15 @@ static inline int inword(const u32 c)
 
 /**
  *	sel_loadlut()		-	load the LUT table
- *	@p: user table
+ *	@lut: user table
  *
  *	Load the LUT table from user space. The caller must hold the console
  *	lock. Make a temporary copy so a partial update doesn't make a mess.
  */
-int sel_loadlut(char __user *p)
+int sel_loadlut(u32 __user *lut)
 {
 	u32 tmplut[ARRAY_SIZE(inwordLut)];
-	if (copy_from_user(tmplut, (u32 __user *)(p+4), sizeof(inwordLut)))
+	if (copy_from_user(tmplut, lut, sizeof(inwordLut)))
 		return -EFAULT;
 	memcpy(inwordLut, tmplut, sizeof(inwordLut));
 	return 0;
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e131edea00da..079dbff562fd 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -145,7 +145,7 @@ static void gotoxy(struct vc_data *vc, int new_x, int new_y);
 static void save_cur(struct vc_data *vc);
 static void reset_terminal(struct vc_data *vc, int do_clear);
 static void con_flush_chars(struct tty_struct *tty);
-static int set_vesa_blanking(char __user *p);
+static int set_vesa_blanking(u8 __user *mode);
 static void set_cursor(struct vc_data *vc);
 static void hide_cursor(struct vc_data *vc);
 static void console_callback(struct work_struct *ignored);
@@ -3134,6 +3134,8 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 {
 	char type, data;
 	char __user *p = (char __user *)arg;
+	void __user *param_aligned32 = (u32 __user *)arg + 1;
+	void __user *param = (void __user *)arg + 1;
 	int lines;
 	int ret;
 
@@ -3147,8 +3149,7 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 	case TIOCL_SETSEL:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		return set_selection_user((struct tiocl_selection
-					 __user *)(p+1), tty);
+		return set_selection_user(param, tty);
 	case TIOCL_PASTESEL:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
@@ -3162,7 +3163,7 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		console_lock();
-		ret = sel_loadlut(p);
+		ret = sel_loadlut(param_aligned32);
 		console_unlock();
 		break;
 	case TIOCL_GETSHIFTSTATE:
@@ -3181,7 +3182,7 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 		return put_user(data, p);
 	case TIOCL_SETVESABLANK:
 		console_lock();
-		ret = set_vesa_blanking(p);
+		ret = set_vesa_blanking(param);
 		console_unlock();
 		break;
 	case TIOCL_GETKMSGREDIRECT:
@@ -3204,7 +3205,7 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 		 */
 		return fg_console;
 	case TIOCL_SCROLLCONSOLE:
-		if (get_user(lines, (s32 __user *)(p+4)))
+		if (get_user(lines, (s32 __user *)param_aligned32))
 			return -EFAULT;
 
 		/*
@@ -4262,11 +4263,11 @@ postcore_initcall(vtconsole_class_init);
  *	Screen blanking
  */
 
-static int set_vesa_blanking(char __user *p)
+static int set_vesa_blanking(u8 __user *mode_user)
 {
-	unsigned int mode;
+	u8 mode;
 
-	if (get_user(mode, p + 1))
+	if (get_user(mode, mode_user))
 		return -EFAULT;
 
 	vesa_blank_mode = (mode < 4) ? mode : 0;
diff --git a/include/linux/selection.h b/include/linux/selection.h
index 170ef28ff26b..b7cd23e56a2b 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -20,7 +20,7 @@ extern int set_selection_user(const struct tiocl_selection __user *sel,
 extern int set_selection_kernel(struct tiocl_selection *v,
 				struct tty_struct *tty);
 extern int paste_selection(struct tty_struct *tty);
-extern int sel_loadlut(char __user *p);
+extern int sel_loadlut(u32 __user *lut);
 extern int mouse_reporting(void);
 extern void mouse_report(struct tty_struct * tty, int butt, int mrx, int mry);
 
-- 
2.43.0


