Return-Path: <linux-kernel+bounces-29793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35908313AA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F8B1F22BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F1C20337;
	Thu, 18 Jan 2024 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE1F+swH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB8200BC;
	Thu, 18 Jan 2024 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564694; cv=none; b=o52os+/DOYdtPNoBLcdcZcqaqgvGDmZ5ETTVAkbEwid1HH+39mLF7onLVXZs2+DLiUoXb+bMpu12EsAxTZx1FbUDQJVrH2MUfcVnqaVrPTzOLBPDXgvkF3iZLhZ14JuyZaXNkSaJ8DDTJVrStE2F1w8nHzJAust4JwdPoQteuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564694; c=relaxed/simple;
	bh=KLUOMz+nCtQ37yc2nhuHZ5rCdOgRh78LalfH38bE/Io=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=hH/2SHCC3FaVS0KMQj24HF4gWhld4jPrjX8sY/dXUgN9UIS8qqJ+d2al3PhDB8aTKKc91ADi4QB6nWQ674TSisba5XGFLk/aaD8mOVRYQQDZNfTmYKqPIKfxmsITxMLVg+I6aBsPjOMZXKvVZqJEhzeVNKiY7BTOAjWqesIpt7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE1F+swH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FB6C43390;
	Thu, 18 Jan 2024 07:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564694;
	bh=KLUOMz+nCtQ37yc2nhuHZ5rCdOgRh78LalfH38bE/Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HE1F+swHwiEmOCOhxTxLu2VE+QOVFM6l9dW6E/T8BexybVd0VlBk5+p2ZBBghCWte
	 uSr04nOoKyWd6wrHupsx/TKng89u6jJ4YfTwWM9Yx1yAqseL2N97bycflrMdMGKaLm
	 MC1FVA0LIoGja1Y8LfQKO7XuRxOxYZq1aCkeXx2mnYOCCkp3aC15Ag2MwkJ1kCJRBB
	 ARvdbMdtDHzy7a1v3AEm8UR2a7WqZ7Awxv534eE5CA20llt2NgSuX9LKS6MtNEABFl
	 eMKbt2MXO/kIbwm1ct/ya+tHYPledlhfDzn7K/ETgLh2BnTq1voYn8+QPnQ8QAStAD
	 ZvyGhzhehD2LA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/45] tty: vt: push console lock from tioclinux() down to 2 functions
Date: Thu, 18 Jan 2024 08:57:17 +0100
Message-ID: <20240118075756.10541-7-jirislaby@kernel.org>
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

Avoid costly user copies under the console lock. So push the lock down
from tioclinux() to sel_loadlut() and set_vesa_blanking().

It is now obvious what is actually protected.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/selection.c | 11 +++++++++--
 drivers/tty/vt/vt.c        | 13 +++++--------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index e172ede235a0..91d789c025c6 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -113,15 +113,22 @@ static inline int inword(const u32 c)
  *	sel_loadlut()		-	load the LUT table
  *	@lut: user table
  *
- *	Load the LUT table from user space. The caller must hold the console
- *	lock. Make a temporary copy so a partial update doesn't make a mess.
+ *	Load the LUT table from user space. Make a temporary copy so a partial
+ *	update doesn't make a mess.
+ *
+ *	Locking: The console lock is acquired.
  */
 int sel_loadlut(u32 __user *lut)
 {
 	u32 tmplut[ARRAY_SIZE(inwordLut)];
+
 	if (copy_from_user(tmplut, lut, sizeof(inwordLut)))
 		return -EFAULT;
+
+	console_lock();
 	memcpy(inwordLut, tmplut, sizeof(inwordLut));
+	console_unlock();
+
 	return 0;
 }
 
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 079dbff562fd..3a6f60ad2224 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3162,10 +3162,7 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 	case TIOCL_SELLOADLUT:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		console_lock();
-		ret = sel_loadlut(param_aligned32);
-		console_unlock();
-		break;
+		return sel_loadlut(param_aligned32);
 	case TIOCL_GETSHIFTSTATE:
 		/*
 		 * Make it possible to react to Shift+Mousebutton. Note that
@@ -3181,10 +3178,7 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 		console_unlock();
 		return put_user(data, p);
 	case TIOCL_SETVESABLANK:
-		console_lock();
-		ret = set_vesa_blanking(param);
-		console_unlock();
-		break;
+		return set_vesa_blanking(param);
 	case TIOCL_GETKMSGREDIRECT:
 		data = vt_get_kmsg_redirect();
 		return put_user(data, p);
@@ -4270,7 +4264,10 @@ static int set_vesa_blanking(u8 __user *mode_user)
 	if (get_user(mode, mode_user))
 		return -EFAULT;
 
+	console_lock();
 	vesa_blank_mode = (mode < 4) ? mode : 0;
+	console_unlock();
+
 	return 0;
 }
 
-- 
2.43.0


