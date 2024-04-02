Return-Path: <linux-kernel+bounces-128463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048ED895B29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C761C218C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2883315B127;
	Tue,  2 Apr 2024 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDPpL1iS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2815AD8C;
	Tue,  2 Apr 2024 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080287; cv=none; b=MQHZRiFgDC2ZmVPfyuD9Y2Y+urUIbzMueeSXtjgWVb83Cdx7YwGFgAVw3/OMh3nVA6ICAN5ttYk/UoFrI+rKsz42CZ13raYMbrnqwxRFWgRDVIrS7rvh8qD6gnW4Ykp1yyfapFDq9dymsbw63l5r3Frj/lhT4wvG2II//DTwkTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080287; c=relaxed/simple;
	bh=CcyeG5LEOSpGWOeOm3cbVKAtUzZmD4pho93LO4Lftsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJnA5jb7yfAzIf8I+Z8z+aHKlyzo9MmVSTpmRqCi5mw986ju2buLhmOuiqZ7QtdZzek75Ymt6O8X83ZG0DsRwQBZ52MTYlBiTpmKc3L6K2gUkv8qJhvXXlHkyHuUgQWtKTlUASz8uAqMsCPPniOoIqNroRuHEl5w8/WM+L4IsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDPpL1iS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2213C43141;
	Tue,  2 Apr 2024 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712080286;
	bh=CcyeG5LEOSpGWOeOm3cbVKAtUzZmD4pho93LO4Lftsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gDPpL1iSidYDTm2cfaFRKWDA6FRECYoVffaodoZH0Kd2Ojp8D965LqLkRBPeV21LO
	 c+uqtYWir+a12YHGnAK7hUoldX5/EJ2oeeSJabTOjujSOY9bj/gTgoKNMsCzHzqvsi
	 WvqK31EfOtcxep9lELkvVMMjBCvA6VM1F4ct8g6HIjsOECCmA4Du9NN63zpYLB/e4k
	 nkOIY++Q/hKLaUUTLiaZcnDuxrmLq7gxr8Ou7Bgq8NHGfFCEMHKyhvwi4+ST6YU9kx
	 UhkMnrvG3kXC/JFi8x8pW70wT/WRXGQ9Fxf4+Qrd53IA0NNKcjuDYmt+CaHxdEMzwx
	 EWzoHhIBCBGRg==
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	kbd@lists.linux.dev,
	linux-api@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v4 3/3] VT: Allow to get max font width and height
Date: Tue,  2 Apr 2024 19:50:46 +0200
Message-ID: <adf46c743e7badf601feebcc31ec2def417cd56b.1712080158.git.legion@kernel.org>
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
 drivers/video/fbdev/core/fbcon.c    | 16 ++++++++++++++++
 4 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index a51cfc1d560e..6167f45326ac 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -33,6 +33,9 @@
 
 #define NEWPORT_LEN	0x10000
 
+#define NEWPORT_MAX_FONT_WIDTH 8
+#define NEWPORT_MAX_FONT_HEIGHT 16
+
 #define FONT_DATA ((unsigned char *)font_vga_8x16.data)
 
 static unsigned char *font_data[MAX_NR_CONSOLES];
@@ -328,8 +331,8 @@ static void newport_init(struct vc_data *vc, bool init)
 {
 	int cols, rows;
 
-	cols = newport_xsize / 8;
-	rows = newport_ysize / 16;
+	cols = newport_xsize / NEWPORT_MAX_FONT_WIDTH;
+	rows = newport_ysize / NEWPORT_MAX_FONT_HEIGHT;
 	vc->vc_can_do_color = 1;
 	if (init) {
 		vc->vc_cols = cols;
@@ -507,8 +510,8 @@ static int newport_set_font(int unit, const struct console_font *op,
 
 	/* ladis: when I grow up, there will be a day... and more sizes will
 	 * be supported ;-) */
-	if ((w != 8) || (h != 16) || (vpitch != 32)
-	    || (op->charcount != 256 && op->charcount != 512))
+	if ((w != NEWPORT_MAX_FONT_WIDTH) || (h != NEWPORT_MAX_FONT_HEIGHT) ||
+	    (vpitch != 32) || (op->charcount != 256 && op->charcount != 512))
 		return -EINVAL;
 
 	if (!(new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size,
@@ -570,6 +573,15 @@ static int newport_font_default(struct vc_data *vc, struct console_font *op,
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
 static int newport_font_set(struct vc_data *vc, const struct console_font *font,
 			    unsigned int vpitch, unsigned int flags)
 {
@@ -689,6 +701,7 @@ const struct consw newport_con = {
 	.con_scroll	  = newport_scroll,
 	.con_switch	  = newport_switch,
 	.con_blank	  = newport_blank,
+	.con_font_info	  = newport_font_info,
 	.con_font_set	  = newport_font_set,
 	.con_font_default = newport_font_default,
 	.con_save_screen  = newport_save_screen
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 4c7b4959a1aa..490e6b266a31 100644
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
@@ -166,8 +171,10 @@ static int sticon_set_font(struct vc_data *vc, const struct console_font *op,
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
@@ -260,6 +267,19 @@ static int sticon_font_set(struct vc_data *vc, const struct console_font *font,
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
 static void sticon_init(struct vc_data *c, bool init)
 {
     struct sti_struct *sti = sticon_sti;
@@ -356,6 +376,7 @@ static const struct consw sti_con = {
 	.con_scroll		= sticon_scroll,
 	.con_switch		= sticon_switch,
 	.con_blank		= sticon_blank,
+	.con_font_info		= sticon_font_info,
 	.con_font_set		= sticon_font_set,
 	.con_font_default	= sticon_font_default,
 	.con_build_attr		= sticon_build_attr,
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 7597f04b0dc7..b5465e555fdc 100644
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
@@ -1039,6 +1043,19 @@ static int vgacon_adjust_height(struct vc_data *vc, unsigned fontheight)
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
 static int vgacon_font_set(struct vc_data *c, const struct console_font *font,
 			   unsigned int vpitch, unsigned int flags)
 {
@@ -1048,7 +1065,8 @@ static int vgacon_font_set(struct vc_data *c, const struct console_font *font,
 	if (vga_video_type < VIDEO_TYPE_EGAM)
 		return -EINVAL;
 
-	if (font->width != VGA_FONTWIDTH || font->height > 32 || vpitch != 32 ||
+	if (font->width != VGACON_MAX_FONT_WIDTH ||
+	    font->height > VGACON_MAX_FONT_HEIGHT || vpitch != 32 ||
 	    (charcount != 256 && charcount != 512))
 		return -EINVAL;
 
@@ -1201,6 +1219,7 @@ const struct consw vga_con = {
 	.con_scroll = vgacon_scroll,
 	.con_switch = vgacon_switch,
 	.con_blank = vgacon_blank,
+	.con_font_info = vgacon_font_info,
 	.con_font_set = vgacon_font_set,
 	.con_font_get = vgacon_font_get,
 	.con_resize = vgacon_resize,
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index fcabc668e9fb..b54031da49fd 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2452,6 +2452,21 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	return ret;
 }
 
+
+static int fbcon_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	info->min_width = 0;
+	info->min_height = 0;
+
+	info->max_width = FB_MAX_BLIT_WIDTH;
+	info->max_height = FB_MAX_BLIT_HEIGHT;
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
@@ -3127,6 +3142,7 @@ static const struct consw fb_con = {
 	.con_scroll 		= fbcon_scroll,
 	.con_switch 		= fbcon_switch,
 	.con_blank 		= fbcon_blank,
+	.con_font_info		= fbcon_font_info,
 	.con_font_set 		= fbcon_set_font,
 	.con_font_get 		= fbcon_get_font,
 	.con_font_default	= fbcon_set_def_font,
-- 
2.44.0


