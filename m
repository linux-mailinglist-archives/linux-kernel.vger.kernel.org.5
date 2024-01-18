Return-Path: <linux-kernel+bounces-29813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7648313EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C75CB24239
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E142A2D600;
	Thu, 18 Jan 2024 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWdMkNEo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179FC2D054;
	Thu, 18 Jan 2024 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564736; cv=none; b=he8YktdroUWHV5t5ihixijdBV9JNpWCZjYsOPPsFJ0j3b43A+7EQvqzfcPej83uBUTMM8S2+zW5KulZliteZickxU3qnlUAenoejQKs6lulSUyR3GHsN8HJFtH6TcZFzFeVTOCYS6o2yEeEhpUZHSPCf7d25W/lV4gg0IRqJyLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564736; c=relaxed/simple;
	bh=9KIJ7uIX/Te/xBlz0NrBY1Kbgsi0p9OXSqQTf+AUMRE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=hgpb3PCF+4y8qNZlOFYvkWm14aVRJpWenih/F3XWN/VU9crd+8uffjQTTcfjyjWLv3hTfuoAhE1Rpgpyh54g/UkUg1hPta82+lR/T5QkjuDKaLGpceEQO7c2wG+GHVr9IgTttew0NVojaoTEg34iSZ59/2g/lIqZvKvZWl29CGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWdMkNEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC7BC43394;
	Thu, 18 Jan 2024 07:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564735;
	bh=9KIJ7uIX/Te/xBlz0NrBY1Kbgsi0p9OXSqQTf+AUMRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWdMkNEosEIzFt3TlKGSERCw7ekEAHgvdERRn98vGLL8K8cC+zOFAAP35i///H94w
	 jYK/cIgBi8mQjWVf9Fl9/G2smPaTnarlwBj10+Gc4XZgWck0NfzdqwZjaI8zH6nI5S
	 qJlEQUbGwb7dkVLGRhor2Jl2jifja7m64uB4vcDsAnf5AXJcEPyRilDecUp7bu5YvX
	 dTZO1ZNPQpszojVWoV3GCVPANPImZRUjcAeCN+zW0yKT6ROo52ZB/dcIU6xYMsPXM/
	 YGNybHNgZNPxQ7pkgJCsyMsZRL+zTLYLmEzDsyHt2Dm9Xg2VNl7ggo1rsOpeg1F9Yd
	 2RyBY3pxepqIg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 26/45] consoles: use if instead of switch-case in consw::con_cursor()
Date: Thu, 18 Jan 2024 08:57:37 +0100
Message-ID: <20240118075756.10541-27-jirislaby@kernel.org>
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

This is only a preparation for the following cleanup patch to make it
easier. Provided CM_ERASE is the only different, use 'if' instead of
'switch+case' in all those.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/console/newport_con.c | 26 +++++-------
 drivers/video/console/sticon.c      | 27 ++++++------
 drivers/video/console/vgacon.c      | 66 +++++++++++++----------------
 3 files changed, 53 insertions(+), 66 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 5e65ee0b7c07..f852717b88f0 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -443,24 +443,20 @@ static void newport_cursor(struct vc_data *vc, int mode)
 	unsigned short treg;
 	int xcurs, ycurs;
 
-	switch (mode) {
-	case CM_ERASE:
-		treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
-		newport_vc2_set(npregs, VC2_IREG_CONTROL,
-				(treg & ~(VC2_CTRL_ECDISP)));
-		break;
+	treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
 
-	case CM_MOVE:
-	case CM_DRAW:
-		treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
+	if (mode == CM_ERASE) {
 		newport_vc2_set(npregs, VC2_IREG_CONTROL,
-				(treg | VC2_CTRL_ECDISP));
-		xcurs = (vc->vc_pos - vc->vc_visible_origin) / 2;
-		ycurs = ((xcurs / vc->vc_cols) << 4) + 31;
-		xcurs = ((xcurs % vc->vc_cols) << 3) + xcurs_correction;
-		newport_vc2_set(npregs, VC2_IREG_CURSX, xcurs);
-		newport_vc2_set(npregs, VC2_IREG_CURSY, ycurs);
+				(treg & ~(VC2_CTRL_ECDISP)));
+		return;
 	}
+
+	newport_vc2_set(npregs, VC2_IREG_CONTROL, (treg | VC2_CTRL_ECDISP));
+	xcurs = (vc->vc_pos - vc->vc_visible_origin) / 2;
+	ycurs = ((xcurs / vc->vc_cols) << 4) + 31;
+	xcurs = ((xcurs % vc->vc_cols) << 3) + xcurs_correction;
+	newport_vc2_set(npregs, VC2_IREG_CURSX, xcurs);
+	newport_vc2_set(npregs, VC2_IREG_CURSY, ycurs);
 }
 
 static int newport_switch(struct vc_data *vc)
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 906da1fde7c8..42480874db00 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -95,23 +95,20 @@ static void sticon_cursor(struct vc_data *conp, int mode)
 	return;
 
     car1 = conp->vc_screenbuf[conp->state.x + conp->state.y * conp->vc_cols];
-    switch (mode) {
-    case CM_ERASE:
+    if (mode == CM_ERASE) {
 	sti_putc(sticon_sti, car1, conp->state.y, conp->state.x,
 		 font_data[conp->vc_num]);
-	break;
-    case CM_MOVE:
-    case CM_DRAW:
-	switch (CUR_SIZE(conp->vc_cursor_type)) {
-	case CUR_UNDERLINE:
-	case CUR_LOWER_THIRD:
-	case CUR_LOWER_HALF:
-	case CUR_TWO_THIRDS:
-	case CUR_BLOCK:
-	    sti_putc(sticon_sti, (car1 & 255) + (0 << 8) + (7 << 11),
-		     conp->state.y, conp->state.x, font_data[conp->vc_num]);
-	    break;
-	}
+	return;
+    }
+
+    switch (CUR_SIZE(conp->vc_cursor_type)) {
+    case CUR_UNDERLINE:
+    case CUR_LOWER_THIRD:
+    case CUR_LOWER_HALF:
+    case CUR_TWO_THIRDS:
+    case CUR_BLOCK:
+	sti_putc(sticon_sti, (car1 & 255) + (0 << 8) + (7 << 11),
+		 conp->state.y, conp->state.x, font_data[conp->vc_num]);
 	break;
     }
 }
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 558076462b0d..3bf7f46a8998 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -514,47 +514,41 @@ static void vgacon_cursor(struct vc_data *c, int mode)
 
 	c_height = c->vc_cell_height;
 
-	switch (mode) {
-	case CM_ERASE:
-		write_vga(14, (c->vc_pos - vga_vram_base) / 2);
+	write_vga(14, (c->vc_pos - vga_vram_base) / 2);
+
+	if (mode == CM_ERASE) {
 	        if (vga_video_type >= VIDEO_TYPE_VGAC)
 			vgacon_set_cursor_size(31, 30);
 		else
 			vgacon_set_cursor_size(31, 31);
-		break;
+		return;
+	}
 
-	case CM_MOVE:
-	case CM_DRAW:
-		write_vga(14, (c->vc_pos - vga_vram_base) / 2);
-		switch (CUR_SIZE(c->vc_cursor_type)) {
-		case CUR_UNDERLINE:
-			vgacon_set_cursor_size(c_height -
-					       (c_height < 10 ? 2 : 3),
-					       c_height -
-					       (c_height < 10 ? 1 : 2));
-			break;
-		case CUR_TWO_THIRDS:
-			vgacon_set_cursor_size(c_height / 3, c_height -
-					       (c_height < 10 ? 1 : 2));
-			break;
-		case CUR_LOWER_THIRD:
-			vgacon_set_cursor_size(c_height * 2 / 3, c_height -
-					       (c_height < 10 ? 1 : 2));
-			break;
-		case CUR_LOWER_HALF:
-			vgacon_set_cursor_size(c_height / 2, c_height -
-					       (c_height < 10 ? 1 : 2));
-			break;
-		case CUR_NONE:
-			if (vga_video_type >= VIDEO_TYPE_VGAC)
-				vgacon_set_cursor_size(31, 30);
-			else
-				vgacon_set_cursor_size(31, 31);
-			break;
-		default:
-			vgacon_set_cursor_size(1, c_height);
-			break;
-		}
+	switch (CUR_SIZE(c->vc_cursor_type)) {
+	case CUR_UNDERLINE:
+		vgacon_set_cursor_size(c_height - (c_height < 10 ? 2 : 3),
+				       c_height - (c_height < 10 ? 1 : 2));
+		break;
+	case CUR_TWO_THIRDS:
+		vgacon_set_cursor_size(c_height / 3,
+				       c_height - (c_height < 10 ? 1 : 2));
+		break;
+	case CUR_LOWER_THIRD:
+		vgacon_set_cursor_size(c_height * 2 / 3,
+				       c_height - (c_height < 10 ? 1 : 2));
+		break;
+	case CUR_LOWER_HALF:
+		vgacon_set_cursor_size(c_height / 2,
+				       c_height - (c_height < 10 ? 1 : 2));
+		break;
+	case CUR_NONE:
+		if (vga_video_type >= VIDEO_TYPE_VGAC)
+			vgacon_set_cursor_size(31, 30);
+		else
+			vgacon_set_cursor_size(31, 31);
+		break;
+	default:
+		vgacon_set_cursor_size(1, c_height);
 		break;
 	}
 }
-- 
2.43.0


