Return-Path: <linux-kernel+bounces-32843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCAA8360CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C381F23DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E703B2AF;
	Mon, 22 Jan 2024 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irbzFxZb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3A41C67;
	Mon, 22 Jan 2024 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921507; cv=none; b=n3yZRDPaSCo9+lOx0fZW26UzU0K50sJIaLpss//jLajnEXq7mKIc2EPxnfnbM/G0BfKI+VsfbFF/Fh36GW09ugn5He7KsvHxC3K6y4ZfYKAoW3u2ZVV6YmqszD8Py02+vuiWr4R1yBH0tgp54l7fMOwQ9LJseGh9FY9wxD1IGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921507; c=relaxed/simple;
	bh=2oWnHAblG1sWOvWbNz/SNfOrR9Iz33Zx1BGelv/f//g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5o6xH8lM6vU1EAImqpUOvaENjCGo9Hxm+JqprIdUf5yThDB0H/c3v5MGG9w0GfxEZDRFOeEPx5Ql/rQyPBneZOwr2FtxxEHT3CWNyVM12LCa1yO1vmaTNZ6Yy4l5g1F9Qn0+K6oh82s7Y9F02lW/bQLPQj1LjQ1Ynk2iBKFGgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irbzFxZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5771EC433C7;
	Mon, 22 Jan 2024 11:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921506;
	bh=2oWnHAblG1sWOvWbNz/SNfOrR9Iz33Zx1BGelv/f//g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irbzFxZbERrCPHhJgTL96lkpx1NjPEMLR3FZZ2Kg/e/7Dz9sPCwHYZ2upuo7M5K49
	 p7OsD1rg66/LT0nVNsKauT0yplk3Mmq3rj9XQgke4RbHadk2NUkJXXLpQUgcoV6IMe
	 xf+0sNpDgd3AlFkiu5WeP/27FxVgcPhaYuhkqjWH0//xj+C7bETwatoKmA4qbLUXJ2
	 Aw9N/FKS9477C3n7tN65zDr4dBhY1NVpbvVVVNmuaMUI7wqq3aoyuD5Z7GLBGLEpzM
	 D7VGFpOvHoSapnqdMhy+Yi8xmj2mQZotvt215MIWF3RMARgeHoUWL6Oj+Uqptuc/Tb
	 oKe0N6Jz2OKwQ==
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
Subject: [PATCH v2 30/47] tty: vt: make consw::con_switch() return a bool
Date: Mon, 22 Jan 2024 12:03:44 +0100
Message-ID: <20240122110401.7289-31-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
References: <20240122110401.7289-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The non-zero (true) return value from consw::con_switch() means a redraw
is needed. So make this return type a bool explicitly instead of int.
The latter might imply that -Eerrors are expected. They are not.

And document the hook.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-parisc@vger.kernel.org
---
 drivers/tty/vt/vt.c                 | 2 +-
 drivers/video/console/dummycon.c    | 4 ++--
 drivers/video/console/mdacon.c      | 4 ++--
 drivers/video/console/newport_con.c | 4 ++--
 drivers/video/console/sticon.c      | 4 ++--
 drivers/video/console/vgacon.c      | 4 ++--
 drivers/video/fbdev/core/fbcon.c    | 6 +++---
 include/linux/console.h             | 4 +++-
 8 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e4edcaf9d0a3..fd868046f586 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -970,7 +970,7 @@ void redraw_screen(struct vc_data *vc, int is_switch)
 	}
 
 	if (redraw) {
-		int update;
+		bool update;
 		int old_was_color = vc->vc_can_do_color;
 
 		set_origin(vc);
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 1171e27edef7..c8d5aa0e3ed0 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -122,9 +122,9 @@ static bool dummycon_scroll(struct vc_data *vc, unsigned int top,
 	return false;
 }
 
-static int dummycon_switch(struct vc_data *vc)
+static bool dummycon_switch(struct vc_data *vc)
 {
-	return 0;
+	return false;
 }
 
 /*
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index bc851a1d9f4d..4485ef923bb3 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -446,9 +446,9 @@ static void mdacon_clear(struct vc_data *c, unsigned int y, unsigned int x,
 	scr_memsetw(dest, eattr, width * 2);
 }
 
-static int mdacon_switch(struct vc_data *c)
+static bool mdacon_switch(struct vc_data *c)
 {
-	return 1;	/* redrawing needed */
+	return true;	/* redrawing needed */
 }
 
 static int mdacon_blank(struct vc_data *c, int blank, int mode_switch)
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index e35406dea7c7..039d1c9937d2 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -459,7 +459,7 @@ static void newport_cursor(struct vc_data *vc, bool enable)
 	newport_vc2_set(npregs, VC2_IREG_CURSY, ycurs);
 }
 
-static int newport_switch(struct vc_data *vc)
+static bool newport_switch(struct vc_data *vc)
 {
 	static int logo_drawn = 0;
 
@@ -473,7 +473,7 @@ static int newport_switch(struct vc_data *vc)
 		}
 	}
 
-	return 1;
+	return true;
 }
 
 static int newport_blank(struct vc_data *c, int blank, int mode_switch)
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 786e1b3a98ea..f3bb48a0e980 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -293,9 +293,9 @@ static void sticon_clear(struct vc_data *conp, unsigned int sy, unsigned int sx,
 	      conp->vc_video_erase_char, font_data[conp->vc_num]);
 }
 
-static int sticon_switch(struct vc_data *conp)
+static bool sticon_switch(struct vc_data *conp)
 {
-    return 1;	/* needs refreshing */
+    return true;	/* needs refreshing */
 }
 
 static int sticon_blank(struct vc_data *c, int blank, int mode_switch)
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index d93eb15da435..f89eb53c0b79 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -614,7 +614,7 @@ static void vgacon_doresize(struct vc_data *c,
 	raw_spin_unlock_irqrestore(&vga_lock, flags);
 }
 
-static int vgacon_switch(struct vc_data *c)
+static bool vgacon_switch(struct vc_data *c)
 {
 	int x = c->vc_cols * VGA_FONTWIDTH;
 	int y = c->vc_rows * c->vc_cell_height;
@@ -643,7 +643,7 @@ static int vgacon_switch(struct vc_data *c)
 			vgacon_doresize(c, c->vc_cols, c->vc_rows);
 	}
 
-	return 0;		/* Redrawing not needed */
+	return false;		/* Redrawing not needed */
 }
 
 static void vga_set_palette(struct vc_data *vc, const unsigned char *table)
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c1765a6ef490..d5d924225209 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2056,7 +2056,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	return 0;
 }
 
-static int fbcon_switch(struct vc_data *vc)
+static bool fbcon_switch(struct vc_data *vc)
 {
 	struct fb_info *info, *old_info = NULL;
 	struct fbcon_ops *ops;
@@ -2178,9 +2178,9 @@ static int fbcon_switch(struct vc_data *vc)
 			      vc->vc_origin + vc->vc_size_row * vc->vc_top,
 			      vc->vc_size_row * (vc->vc_bottom -
 						 vc->vc_top) / 2);
-		return 0;
+		return false;
 	}
-	return 1;
+	return true;
 }
 
 static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
diff --git a/include/linux/console.h b/include/linux/console.h
index a6a46b5efd66..f7c6b5fc3a36 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -46,6 +46,8 @@ enum vc_intensity;
  * @con_scroll: move lines from @top to @bottom in direction @dir by @lines.
  *		Return true if no generic handling should be done.
  *		Invoked by csi_M and printing to the console.
+ * @con_switch: notifier about the console switch; it is supposed to return
+ *		true if a redraw is needed.
  * @con_set_palette: sets the palette of the console to @table (optional)
  * @con_scrolldelta: the contents of the console should be scrolled by @lines.
  *		     Invoked by user. (optional)
@@ -66,7 +68,7 @@ struct consw {
 	bool	(*con_scroll)(struct vc_data *vc, unsigned int top,
 			unsigned int bottom, enum con_scroll dir,
 			unsigned int lines);
-	int	(*con_switch)(struct vc_data *vc);
+	bool	(*con_switch)(struct vc_data *vc);
 	int	(*con_blank)(struct vc_data *vc, int blank, int mode_switch);
 	int	(*con_font_set)(struct vc_data *vc, struct console_font *font,
 			unsigned int vpitch, unsigned int flags);
-- 
2.43.0


