Return-Path: <linux-kernel+bounces-67215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D7E856811
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F9C1F2F22D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BBB135A65;
	Thu, 15 Feb 2024 15:37:58 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E2D13541C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011478; cv=none; b=r9Hqpgi6c9/d7QGLPnscRONalSLgfOqfTfEAYfwbfYkXg1Mncz8VKmlxIFGcjl+DJKWmVINDOZZvYxUdTLR5ZFCPyLocskeFc0P+nc5vBq54lJV2pXaYvM6HqX1oDvPQ1Xvfc0Df13ZHa6TWYdmDcCfscbVuDx8nYNDsTf24bqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011478; c=relaxed/simple;
	bh=efCocjGDk1w3W9iKbxUAnx77/Ju+MiN+a2dnJUfXKoY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNEqCTY6cyWKbERD4EYh//pi1ovlxQ753fh6bUolKax/SaVGNVMDw8v9ufKNlgekHJQLAnRw5iujCmEmymdknDcoM38J4JaEpj+qsLVOrz2COaOczm5ukiFKiVRT/yKPJtkOVzzT0pL83Fuv7rsdnqElXYdoHclo22mzNBvPgxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-YVyoMV41MumVIiMbfc3cWQ-1; Thu,
 15 Feb 2024 10:37:46 -0500
X-MC-Unique: YVyoMV41MumVIiMbfc3cWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 809ED1C0983D;
	Thu, 15 Feb 2024 15:37:46 +0000 (UTC)
Received: from gentoo.redhat.com (unknown [10.45.226.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE04A112131D;
	Thu, 15 Feb 2024 15:37:45 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [RFC PATCH v1 5/5] fbcon: Allow to get max font width and height
Date: Thu, 15 Feb 2024 15:37:24 +0000
Message-ID: <1985617597448ffc0eb4d242cd22d1250542b433.1708011391.git.legion@kernel.org>
In-Reply-To: <cover.1708011391.git.legion@kernel.org>
References: <cover.1708011391.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 1183e7a871f8..6f9015868cac 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -101,6 +101,9 @@ enum {
 	FBCON_LOGO_DONTSHOW	= -3	/* do not show the logo */
 };
 
+#define FBCON_MAX_FONT_WIDTH 32
+#define FBCON_MAX_FONT_HEIGHT 32
+
 static struct fbcon_display fb_display[MAX_NR_CONSOLES];
 
 static struct fb_info *fbcon_registered_fb[FB_MAX];
@@ -2458,6 +2461,17 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	return ret;
 }
 
+
+static int fbcon_font_info(struct vc_data *vc, struct console_font *font)
+{
+	font->width = FBCON_MAX_FONT_WIDTH;
+	font->height = FBCON_MAX_FONT_HEIGHT;
+	font->charcount = 512;
+
+	return 0;
+}
+
+
 /*
  *  User asked to set font; we are guaranteed that charcount does not exceed 512
  *  but lets not assume that, since charcount of 512 is small for unicode support.
@@ -2485,7 +2499,8 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
 	    h > FBCON_SWAP(info->var.rotate, info->var.yres, info->var.xres))
 		return -EINVAL;
 
-	if (font->width > 32 || font->height > 32)
+	if (font->width > FBCON_MAX_FONT_WIDTH ||
+	    font->height > FBCON_MAX_FONT_HEIGHT)
 		return -EINVAL;
 
 	/* Make sure drawing engine can handle the font */
@@ -3160,6 +3175,7 @@ static const struct consw fb_con = {
 	.con_scroll 		= fbcon_scroll,
 	.con_switch 		= fbcon_switch,
 	.con_blank 		= fbcon_blank,
+	.con_font_info 		= fbcon_font_info,
 	.con_font_set 		= fbcon_set_font,
 	.con_font_get 		= fbcon_get_font,
 	.con_font_default	= fbcon_set_def_font,
-- 
2.43.0


