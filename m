Return-Path: <linux-kernel+bounces-127736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CC7895030
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75EB21C2265B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9608F62171;
	Tue,  2 Apr 2024 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8HFVi6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF7160DEA;
	Tue,  2 Apr 2024 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054042; cv=none; b=Uq0U23Wj0BvarrtfnnFD0WUsMybmBLqIav9oERpiekziKYPOnssrOO1rITRK4hF+euKfWfx9mkQnBUntVyo4KAG7/3mauINhtOOXS447NTwMaAkpH6oeKKOW2I7kPwKpq4GIogYEEvvJOdpJp0WgrQGt2vNKlLg8dW8yyqy8mjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054042; c=relaxed/simple;
	bh=iitcsjz5f3Ckn5epCwD7TsbhsD3EMBPLfISwYi/UPLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9fXgnHll7FL2dbfgqDonXuNWFy1Zpusk2ql+qwqHj19QAx2kd9249JCDDiA+5XuCmDKAfE0ODLaOIGwl5R6QCfK+KZEcatNnIj8eOGkAlnDfhPojDxk8fAIjszAXZ7TEC3xCxx/SHAo0DXB7s0ILhLFWPTTRPcgucnyqQt7I2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8HFVi6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4036CC433C7;
	Tue,  2 Apr 2024 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712054042;
	bh=iitcsjz5f3Ckn5epCwD7TsbhsD3EMBPLfISwYi/UPLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F8HFVi6EHkStvMX6/pkYMuNU/GHsy7FJlMWgyo+DrIiixLToUEqndv6HzBmdDkLai
	 2rzB1rTY2ofTQ0dGh/bH6qpsxHXhVx6bEpneYEjKSBwgghd8lMH+pqdMJCjX171xNm
	 PA2PqZ+RpicnL2sZTLNRRkRIobER7dXhAAAlsl7+rZKCrbt1gQmhgQhpNLDorsYUg4
	 jjDCS9p+4DJ7l0nGs0VlMvwXsqYDUPmvhLI+QIsk48KLquWaR0r2wJx7lpI4gWbYJG
	 Dv/Bn+dMthjd+AN4qm82jYCt3TZQoWuVV2iu46E2JF69i1mZHz2+saURUIL8yR5tBm
	 lq1jiXItJg0rg==
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	kbd@lists.linux.dev,
	linux-api@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: [RESEND PATCH v3 2/2] VT: Allow to get max font width and height
Date: Tue,  2 Apr 2024 12:32:57 +0200
Message-ID: <78fcb9ad77b88edee8768806ce6a4d23f6d33118.1712053848.git.legion@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712053848.git.legion@kernel.org>
References: <cover.1710252966.git.legion@kernel.org> <cover.1712053848.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Console drivers has more restrictive font size limits than vt_ioctl.
This leads to errors that are difficult to handle. If a font whose size
is not supported is used, an EINVAL error will be returned, which is
also returned in case of errors in the font itself. At the moment there
is no way to understand what font sizes the current console driver
supports.

To solve this problem, we need to transfer information about the
supported font to userspace from the console driver.

Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/video/console/newport_con.c | 21 +++++++++++++++++----
 drivers/video/console/sticon.c      | 25 +++++++++++++++++++++++--
 drivers/video/console/vgacon.c      | 21 ++++++++++++++++++++-
 drivers/video/fbdev/core/fbcon.c    | 22 +++++++++++++++++++++-
 4 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index e8e4f82cd4a1..87f174a95fa8 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -33,6 +33,9 @@
 
 #define NEWPORT_LEN	0x10000
 
+#define NEWPORT_MAX_FONT_WIDTH 8
+#define NEWPORT_MAX_FONT_HEIGHT 16
+
 #define FONT_DATA ((unsigned char *)font_vga_8x16.data)
 
 static unsigned char *font_data[MAX_NR_CONSOLES];
@@ -328,8 +331,8 @@ static void newport_init(struct vc_data *vc, int init)
 {
 	int cols, rows;
 
-	cols = newport_xsize / 8;
-	rows = newport_ysize / 16;
+	cols = newport_xsize / NEWPORT_MAX_FONT_WIDTH;
+	rows = newport_ysize / NEWPORT_MAX_FONT_HEIGHT;
 	vc->vc_can_do_color = 1;
 	if (init) {
 		vc->vc_cols = cols;
@@ -507,8 +510,8 @@ static int newport_set_font(int unit, struct console_font *op, unsigned int vpit
 
 	/* ladis: when I grow up, there will be a day... and more sizes will
 	 * be supported ;-) */
-	if ((w != 8) || (h != 16) || (vpitch != 32)
-	    || (op->charcount != 256 && op->charcount != 512))
+	if ((w != NEWPORT_MAX_FONT_WIDTH) || (h != NEWPORT_MAX_FONT_HEIGHT) ||
+	    (vpitch != 32) || (op->charcount != 256 && op->charcount != 512))
 		return -EINVAL;
 
 	if (!(new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size,
@@ -569,6 +572,15 @@ static int newport_font_default(struct vc_data *vc, struct console_font *op, cha
 	return newport_set_def_font(vc->vc_num, op);
 }
 
+static int newport_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	info->min_width = info->max_width = NEWPORT_MAX_FONT_WIDTH;
+	info->min_height = info->max_height = NEWPORT_MAX_FONT_HEIGHT;
+	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
+
+	return 0;
+}
+
 static int newport_font_set(struct vc_data *vc, struct console_font *font,
 			    unsigned int vpitch, unsigned int flags)
 {
@@ -688,6 +700,7 @@ const struct consw newport_con = {
 	.con_scroll	  = newport_scroll,
 	.con_switch	  = newport_switch,
 	.con_blank	  = newport_blank,
+	.con_font_info	  = newport_font_info,
 	.con_font_set	  = newport_font_set,
 	.con_font_default = newport_font_default,
 	.con_save_screen  = newport_save_screen
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 992a4fa431aa..d32ca458eb77 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -56,6 +56,11 @@
 #define BLANK 0
 static int vga_is_gfx;
 
+#define STICON_MIN_FONT_WIDTH 6
+#define STICON_MIN_FONT_HEIGHT 6
+#define STICON_MAX_FONT_WIDTH 32
+#define STICON_MAX_FONT_HEIGHT 32
+
 #define STI_DEF_FONT	sticon_sti->font
 
 /* borrowed from fbcon.c */
@@ -180,8 +185,10 @@ static int sticon_set_font(struct vc_data *vc, struct console_font *op,
 	struct sti_cooked_font *cooked_font;
 	unsigned char *data = op->data, *p;
 
-	if ((w < 6) || (h < 6) || (w > 32) || (h > 32) || (vpitch != 32)
-	    || (op->charcount != 256 && op->charcount != 512))
+	if (!in_range(w, STICON_MIN_FONT_WIDTH, STICON_MAX_FONT_WIDTH) ||
+	    !in_range(h, STICON_MIN_FONT_HEIGHT, STICON_MAX_FONT_HEIGHT) ||
+	    (vpitch != 32) ||
+	    (op->charcount != 256 && op->charcount != 512))
 		return -EINVAL;
 	pitch = ALIGN(w, 8) / 8;
 	bpc = pitch * h;
@@ -273,6 +280,19 @@ static int sticon_font_set(struct vc_data *vc, struct console_font *font,
 	return sticon_set_font(vc, font, vpitch);
 }
 
+static int sticon_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	info->min_width = STICON_MIN_FONT_WIDTH;
+	info->min_height = STICON_MIN_FONT_HEIGHT;
+
+	info->max_width = STICON_MAX_FONT_WIDTH;
+	info->max_height = STICON_MAX_FONT_HEIGHT;
+
+	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
+
+	return 0;
+}
+
 static void sticon_init(struct vc_data *c, int init)
 {
     struct sti_struct *sti = sticon_sti;
@@ -371,6 +391,7 @@ static const struct consw sti_con = {
 	.con_scroll		= sticon_scroll,
 	.con_switch		= sticon_switch,
 	.con_blank		= sticon_blank,
+	.con_font_info		= sticon_font_info,
 	.con_font_set		= sticon_font_set,
 	.con_font_default	= sticon_font_default,
 	.con_build_attr		= sticon_build_attr,
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 8ef1579fa57f..b75d31ef3353 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -61,6 +61,10 @@ static struct vgastate vgastate;
 #define BLANK 0x0020
 
 #define VGA_FONTWIDTH       8   /* VGA does not support fontwidths != 8 */
+
+#define VGACON_MAX_FONT_WIDTH VGA_FONTWIDTH
+#define VGACON_MAX_FONT_HEIGHT 32
+
 /*
  *  Interface used by the world
  */
@@ -1013,6 +1017,19 @@ static int vgacon_adjust_height(struct vc_data *vc, unsigned fontheight)
 	return 0;
 }
 
+static int vgacon_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	info->min_width = VGACON_MAX_FONT_WIDTH;
+	info->min_height = 0;
+
+	info->max_width = VGACON_MAX_FONT_WIDTH;
+	info->max_height = VGACON_MAX_FONT_HEIGHT;
+
+	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
+
+	return 0;
+}
+
 static int vgacon_font_set(struct vc_data *c, struct console_font *font,
 			   unsigned int vpitch, unsigned int flags)
 {
@@ -1022,7 +1039,8 @@ static int vgacon_font_set(struct vc_data *c, struct console_font *font,
 	if (vga_video_type < VIDEO_TYPE_EGAM)
 		return -EINVAL;
 
-	if (font->width != VGA_FONTWIDTH || font->height > 32 || vpitch != 32 ||
+	if (font->width != VGACON_MAX_FONT_WIDTH ||
+	    font->height > VGACON_MAX_FONT_HEIGHT || vpitch != 32 ||
 	    (charcount != 256 && charcount != 512))
 		return -EINVAL;
 
@@ -1177,6 +1195,7 @@ const struct consw vga_con = {
 	.con_scroll = vgacon_scroll,
 	.con_switch = vgacon_switch,
 	.con_blank = vgacon_blank,
+	.con_font_info = vgacon_font_info,
 	.con_font_set = vgacon_font_set,
 	.con_font_get = vgacon_font_get,
 	.con_resize = vgacon_resize,
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 46823c2e2ba1..e10abe416159 100644
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
@@ -2456,6 +2459,21 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	return ret;
 }
 
+
+static int fbcon_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	info->min_width = 0;
+	info->min_height = 0;
+
+	info->max_width = FBCON_MAX_FONT_WIDTH;
+	info->max_height = FBCON_MAX_FONT_HEIGHT;
+
+	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
+
+	return 0;
+}
+
+
 /*
  *  User asked to set font; we are guaranteed that charcount does not exceed 512
  *  but lets not assume that, since charcount of 512 is small for unicode support.
@@ -2483,7 +2501,8 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
 	    h > FBCON_SWAP(info->var.rotate, info->var.yres, info->var.xres))
 		return -EINVAL;
 
-	if (font->width > 32 || font->height > 32)
+	if (font->width > FBCON_MAX_FONT_WIDTH ||
+	    font->height > FBCON_MAX_FONT_HEIGHT)
 		return -EINVAL;
 
 	/* Make sure drawing engine can handle the font */
@@ -3158,6 +3177,7 @@ static const struct consw fb_con = {
 	.con_scroll 		= fbcon_scroll,
 	.con_switch 		= fbcon_switch,
 	.con_blank 		= fbcon_blank,
+	.con_font_info 		= fbcon_font_info,
 	.con_font_set 		= fbcon_set_font,
 	.con_font_get 		= fbcon_get_font,
 	.con_font_default	= fbcon_set_def_font,
-- 
2.44.0


