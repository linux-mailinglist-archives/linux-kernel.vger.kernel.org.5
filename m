Return-Path: <linux-kernel+bounces-29815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCB98313F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB29283C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD632D63E;
	Thu, 18 Jan 2024 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7/EIMur"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAAF2D634;
	Thu, 18 Jan 2024 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564741; cv=none; b=B0B//5k/98djayWtoBHPpo550iutjxwTbIYimg9SS5z15xyfDhlq8g/1QB9pG39vfaOqGS2Jk62lKacKVtlQpbe23cxDBtighZR7Uz81GAuE3R3nZGEHTRH3Bhi0yzdO5lFfuLPOdd0SQYnmS6z2aQW9N8i2NOwCp4GPwxLsnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564741; c=relaxed/simple;
	bh=hJma+GlHKJaFxInAwETUzzRK9y+Y4oMfcVBpjzoXkYc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=YwHjKNX8qW23rU73BhvpG2ARcDXCdlM1WWVNdAJmqIyS2Q1f1aIVyCov00oxjek2mmwinGD+mWDW5uTlfjg7qkK/ZlZu881cejy9G+seRs39WIhQgywXtLK9znqmX9g8zi7xurG8hxdsWCFu1tw43iu55jy9nEZwTKL3kn+6qJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7/EIMur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E77C43390;
	Thu, 18 Jan 2024 07:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564741;
	bh=hJma+GlHKJaFxInAwETUzzRK9y+Y4oMfcVBpjzoXkYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H7/EIMurlFVn42SiwT9vP7eS3CaFgXrcIQU9GLe+WnHKJX5RJXGt1GkwzKpO6mXBj
	 fm0axCprlGcACcTLpy9gXrf0cb3YA9uyFdPZfbCnz2HRh7fBJktOb2a+sccrdfGNVs
	 hZJIwON5/M+wQ0mbnNwO5cwbw+eNcgQ7PFdhEISpSp4cJhw2JLlvpiw5OrGxZQPl61
	 X/1chWFCep0STki4iU2LrM0T2ovXzmd57o4twCxHqfuw0eW7nP9/SAVSuIgd5hxXXJ
	 rFageAyBofq8g+yDYFCijMvH929jC6b4LBxlAhwup2v9UyzAvogGqHyyDYdHif2ROQ
	 ewvadhTOlGpqw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH 28/45] tty: vt: remove CM_* constants
Date: Thu, 18 Jan 2024 08:57:39 +0100
Message-ID: <20240118075756.10541-29-jirislaby@kernel.org>
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

There is no difference between CM_MOVE and CM_DRAW. Either of them
enables the cursor. CM_ERASE then disables cursor.

So get rid of all of them and use simple "bool enable".

Note that this propagates down to the fbcon code.

And document the hook.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-parisc@vger.kernel.org
---
 drivers/tty/vt/vt.c                  |  4 ++--
 drivers/video/console/dummycon.c     |  2 +-
 drivers/video/console/mdacon.c       |  4 ++--
 drivers/video/console/newport_con.c  |  4 ++--
 drivers/video/console/sticon.c       |  6 +++---
 drivers/video/console/vgacon.c       |  6 +++---
 drivers/video/fbdev/core/bitblit.c   |  4 ++--
 drivers/video/fbdev/core/fbcon.c     | 19 +++++++++----------
 drivers/video/fbdev/core/fbcon.h     |  4 ++--
 drivers/video/fbdev/core/fbcon_ccw.c |  4 ++--
 drivers/video/fbdev/core/fbcon_cw.c  |  4 ++--
 drivers/video/fbdev/core/fbcon_ud.c  |  4 ++--
 drivers/video/fbdev/core/tileblit.c  |  4 ++--
 include/linux/console.h              |  8 ++------
 14 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 73e48a53dc31..2df306922b4e 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -860,7 +860,7 @@ static void hide_cursor(struct vc_data *vc)
 	if (vc_is_sel(vc))
 		clear_selection();
 
-	vc->vc_sw->con_cursor(vc, CM_ERASE);
+	vc->vc_sw->con_cursor(vc, false);
 	hide_softcursor(vc);
 }
 
@@ -873,7 +873,7 @@ static void set_cursor(struct vc_data *vc)
 			clear_selection();
 		add_softcursor(vc);
 		if (CUR_SIZE(vc->vc_cursor_type) != CUR_NONE)
-			vc->vc_sw->con_cursor(vc, CM_DRAW);
+			vc->vc_sw->con_cursor(vc, true);
 	} else
 		hide_cursor(vc);
 }
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 188d9f3e201c..1171e27edef7 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -113,7 +113,7 @@ static void dummycon_init(struct vc_data *vc, bool init)
 static void dummycon_deinit(struct vc_data *vc) { }
 static void dummycon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
 			   unsigned int width) { }
-static void dummycon_cursor(struct vc_data *vc, int mode) { }
+static void dummycon_cursor(struct vc_data *vc, bool enable) { }
 
 static bool dummycon_scroll(struct vc_data *vc, unsigned int top,
 			    unsigned int bottom, enum con_scroll dir,
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index b8822b615b2f..bc851a1d9f4d 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -470,9 +470,9 @@ static int mdacon_blank(struct vc_data *c, int blank, int mode_switch)
 	}
 }
 
-static void mdacon_cursor(struct vc_data *c, int mode)
+static void mdacon_cursor(struct vc_data *c, bool enable)
 {
-	if (mode == CM_ERASE) {
+	if (!enable) {
 		mda_set_cursor(mda_vram_len - 1);
 		return;
 	}
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index f852717b88f0..e35406dea7c7 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -438,14 +438,14 @@ static void newport_putcs(struct vc_data *vc, const u16 *s,
 	}
 }
 
-static void newport_cursor(struct vc_data *vc, int mode)
+static void newport_cursor(struct vc_data *vc, bool enable)
 {
 	unsigned short treg;
 	int xcurs, ycurs;
 
 	treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
 
-	if (mode == CM_ERASE) {
+	if (!enable) {
 		newport_vc2_set(npregs, VC2_IREG_CONTROL,
 				(treg & ~(VC2_CTRL_ECDISP)));
 		return;
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 42480874db00..786e1b3a98ea 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -86,7 +86,7 @@ static void sticon_putcs(struct vc_data *conp, const u16 *s, unsigned int count,
     }
 }
 
-static void sticon_cursor(struct vc_data *conp, int mode)
+static void sticon_cursor(struct vc_data *conp, bool enable)
 {
     unsigned short car1;
 
@@ -95,7 +95,7 @@ static void sticon_cursor(struct vc_data *conp, int mode)
 	return;
 
     car1 = conp->vc_screenbuf[conp->state.x + conp->state.y * conp->vc_cols];
-    if (mode == CM_ERASE) {
+    if (!enable) {
 	sti_putc(sticon_sti, car1, conp->state.y, conp->state.x,
 		 font_data[conp->vc_num]);
 	return;
@@ -121,7 +121,7 @@ static bool sticon_scroll(struct vc_data *conp, unsigned int t,
     if (vga_is_gfx)
         return false;
 
-    sticon_cursor(conp, CM_ERASE);
+    sticon_cursor(conp, false);
 
     switch (dir) {
     case SM_UP:
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 3bf7f46a8998..c81723ad4dc1 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -503,7 +503,7 @@ static void vgacon_set_cursor_size(int from, int to)
 	raw_spin_unlock_irqrestore(&vga_lock, flags);
 }
 
-static void vgacon_cursor(struct vc_data *c, int mode)
+static void vgacon_cursor(struct vc_data *c, bool enable)
 {
 	unsigned int c_height;
 
@@ -516,7 +516,7 @@ static void vgacon_cursor(struct vc_data *c, int mode)
 
 	write_vga(14, (c->vc_pos - vga_vram_base) / 2);
 
-	if (mode == CM_ERASE) {
+	if (!enable) {
 	        if (vga_video_type >= VIDEO_TYPE_VGAC)
 			vgacon_set_cursor_size(31, 30);
 		else
@@ -1030,7 +1030,7 @@ static int vgacon_adjust_height(struct vc_data *vc, unsigned fontheight)
 			        /* void size to cause regs to be rewritten */
 				cursor_size_lastfrom = 0;
 				cursor_size_lastto = 0;
-				c->vc_sw->con_cursor(c, CM_DRAW);
+				c->vc_sw->con_cursor(c, true);
 			}
 			c->vc_font.height = c->vc_cell_height = fontheight;
 			vc_resize(c, 0, rows);	/* Adjust console size */
diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index daff152f4c22..3ff1b2a8659e 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -233,7 +233,7 @@ static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
 	}
 }
 
-static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
+static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 		       int fg, int bg)
 {
 	struct fb_cursor cursor;
@@ -348,7 +348,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 			mask[i++] = msk;
 	}
 
-	ops->cursor_state.enable = (mode != CM_ERASE) && !use_sw;
+	ops->cursor_state.enable = enable && !use_sw;
 
 	cursor.image.data = src;
 	cursor.image.fg_color = ops->cursor_state.image.fg_color;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 7a7b2ac0d7a9..c1765a6ef490 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -351,7 +351,7 @@ static void fb_flashcursor(struct work_struct *work)
 	struct fb_info *info;
 	struct vc_data *vc = NULL;
 	int c;
-	int mode;
+	bool enable;
 	int ret;
 
 	/* FIXME: we should sort out the unbind locking instead */
@@ -375,9 +375,8 @@ static void fb_flashcursor(struct work_struct *work)
 	}
 
 	c = scr_readw((u16 *) vc->vc_pos);
-	mode = (!ops->cursor_flash || ops->cursor_state.enable) ?
-		CM_ERASE : CM_DRAW;
-	ops->cursor(vc, info, mode, get_color(vc, info, c, 1),
+	enable = ops->cursor_flash && !ops->cursor_state.enable;
+	ops->cursor(vc, info, enable, get_color(vc, info, c, 1),
 		    get_color(vc, info, c, 0));
 	console_unlock();
 
@@ -1301,7 +1300,7 @@ static void fbcon_clear_margins(struct vc_data *vc, int bottom_only)
 		ops->clear_margins(vc, info, margin_color, bottom_only);
 }
 
-static void fbcon_cursor(struct vc_data *vc, int mode)
+static void fbcon_cursor(struct vc_data *vc, bool enable)
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -1317,12 +1316,12 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
 	else
 		fbcon_add_cursor_work(info);
 
-	ops->cursor_flash = (mode == CM_ERASE) ? 0 : 1;
+	ops->cursor_flash = enable;
 
 	if (!ops->cursor)
 		return;
 
-	ops->cursor(vc, info, mode, get_color(vc, info, c, 1),
+	ops->cursor(vc, info, enable, get_color(vc, info, c, 1),
 		    get_color(vc, info, c, 0));
 }
 
@@ -1742,7 +1741,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 	if (fbcon_is_inactive(vc, info))
 		return true;
 
-	fbcon_cursor(vc, CM_ERASE);
+	fbcon_cursor(vc, false);
 
 	/*
 	 * ++Geert: Only use ywrap/ypan if the console is in text mode
@@ -2221,7 +2220,7 @@ static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
  	if (!fbcon_is_inactive(vc, info)) {
 		if (ops->blank_state != blank) {
 			ops->blank_state = blank;
-			fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
+			fbcon_cursor(vc, !blank);
 			ops->cursor_flash = (!blank);
 
 			if (fb_blank(info, blank))
@@ -2649,7 +2648,7 @@ void fbcon_suspended(struct fb_info *info)
 	vc = vc_cons[ops->currcon].d;
 
 	/* Clear cursor, restore saved data */
-	fbcon_cursor(vc, CM_ERASE);
+	fbcon_cursor(vc, false);
 }
 
 void fbcon_resumed(struct fb_info *info)
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 0eaf54a21151..df70ea5ec5b3 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -61,8 +61,8 @@ struct fbcon_ops {
 		      int fg, int bg);
 	void (*clear_margins)(struct vc_data *vc, struct fb_info *info,
 			      int color, int bottom_only);
-	void (*cursor)(struct vc_data *vc, struct fb_info *info, int mode,
-		       int fg, int bg);
+	void (*cursor)(struct vc_data *vc, struct fb_info *info,
+		       bool enable, int fg, int bg);
 	int  (*update_start)(struct fb_info *info);
 	int  (*rotate_font)(struct fb_info *info, struct vc_data *vc);
 	struct fb_var_screeninfo var;  /* copy of the current fb_var_screeninfo */
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 889423d580bc..f9b794ff7d39 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -218,7 +218,7 @@ static void ccw_clear_margins(struct vc_data *vc, struct fb_info *info,
 	}
 }
 
-static void ccw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
+static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 		       int fg, int bg)
 {
 	struct fb_cursor cursor;
@@ -349,7 +349,7 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		kfree(tmp);
 	}
 
-	ops->cursor_state.enable = (mode != CM_ERASE) && !use_sw;
+	ops->cursor_state.enable = enable && !use_sw;
 
 	cursor.image.data = src;
 	cursor.image.fg_color = ops->cursor_state.image.fg_color;
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index a306ca5802e8..903f6fc174e1 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -201,7 +201,7 @@ static void cw_clear_margins(struct vc_data *vc, struct fb_info *info,
 	}
 }
 
-static void cw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
+static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 		      int fg, int bg)
 {
 	struct fb_cursor cursor;
@@ -332,7 +332,7 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		kfree(tmp);
 	}
 
-	ops->cursor_state.enable = (mode != CM_ERASE) && !use_sw;
+	ops->cursor_state.enable = enable && !use_sw;
 
 	cursor.image.data = src;
 	cursor.image.fg_color = ops->cursor_state.image.fg_color;
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index f6fc458b46c7..594331936fd3 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -248,7 +248,7 @@ static void ud_clear_margins(struct vc_data *vc, struct fb_info *info,
 	}
 }
 
-static void ud_cursor(struct vc_data *vc, struct fb_info *info, int mode,
+static void ud_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 		      int fg, int bg)
 {
 	struct fb_cursor cursor;
@@ -372,7 +372,7 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 			mask[i++] = ~msk;
 	}
 
-	ops->cursor_state.enable = (mode != CM_ERASE) && !use_sw;
+	ops->cursor_state.enable = enable && !use_sw;
 
 	cursor.image.data = src;
 	cursor.image.fg_color = ops->cursor_state.image.fg_color;
diff --git a/drivers/video/fbdev/core/tileblit.c b/drivers/video/fbdev/core/tileblit.c
index 2768eff247ba..eff7ec4da167 100644
--- a/drivers/video/fbdev/core/tileblit.c
+++ b/drivers/video/fbdev/core/tileblit.c
@@ -79,7 +79,7 @@ static void tile_clear_margins(struct vc_data *vc, struct fb_info *info,
 	return;
 }
 
-static void tile_cursor(struct vc_data *vc, struct fb_info *info, int mode,
+static void tile_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 			int fg, int bg)
 {
 	struct fb_tilecursor cursor;
@@ -87,7 +87,7 @@ static void tile_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 
 	cursor.sx = vc->state.x;
 	cursor.sy = vc->state.y;
-	cursor.mode = (mode == CM_ERASE || use_sw) ? 0 : 1;
+	cursor.mode = enable && !use_sw;
 	cursor.fg = fg;
 	cursor.bg = bg;
 
diff --git a/include/linux/console.h b/include/linux/console.h
index 82d55764a66f..a6a46b5efd66 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -42,6 +42,7 @@ enum vc_intensity;
  * @con_putc:   emit one character with attributes @ca to [@x, @y] on @vc.
  *		(optional -- @con_putcs would be called instead)
  * @con_putcs:  emit @count characters with attributes @s to [@x, @y] on @vc.
+ * @con_cursor: enable/disable cursor depending on @enable
  * @con_scroll: move lines from @top to @bottom in direction @dir by @lines.
  *		Return true if no generic handling should be done.
  *		Invoked by csi_M and printing to the console.
@@ -61,7 +62,7 @@ struct consw {
 	void	(*con_putcs)(struct vc_data *vc, const u16 *s,
 			     unsigned int count, unsigned int ypos,
 			     unsigned int xpos);
-	void	(*con_cursor)(struct vc_data *vc, int mode);
+	void	(*con_cursor)(struct vc_data *vc, bool enable);
 	bool	(*con_scroll)(struct vc_data *vc, unsigned int top,
 			unsigned int bottom, enum con_scroll dir,
 			unsigned int lines);
@@ -128,11 +129,6 @@ static inline void con_debug_enter(struct vc_data *vc) { }
 static inline void con_debug_leave(void) { }
 #endif
 
-/* cursor */
-#define CM_DRAW     (1)
-#define CM_ERASE    (2)
-#define CM_MOVE     (3)
-
 /*
  * The interface for a console, or any other device that wants to capture
  * console messages (printer driver?)
-- 
2.43.0


