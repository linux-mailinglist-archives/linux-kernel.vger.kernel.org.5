Return-Path: <linux-kernel+bounces-29816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9538313FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE74282A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758EC1D6B1;
	Thu, 18 Jan 2024 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koG5/fAL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BC92D794;
	Thu, 18 Jan 2024 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564744; cv=none; b=gRMpzV5+TMrQhfgIx3S8z1FtB5wDlQ5my9+cwEwiEXaleOYofIPjImso4pROyM3xObY2YARet/x7jRm399IlUqEejoDxsIBFaLoNZM74SwRib7mgjPKFGZ+pEst+vPkPIHzGqI93eK/Y+WDIHdk+p1JGmBO3E7H4kMgt1IJtMF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564744; c=relaxed/simple;
	bh=/NtUvjlmP2hVHln7V3vPbrBUjpMmcUDbRk8I6b5u3TM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=dd90SLCeTTRJfg7EP6wlEvKwg4gj34eHFO5aVCuv7vOAc2xIjyqkHUrKqvEIKox3XjwiQwppNCMwC2r5AZlZRECtOxq7Bz1Jqy5MQnnHdTVIsRlK8cYdrfoQFIZ1rZ7M/oaSIs3t82gezfNF6gMPebHv/vbjFfTwStm249KTiaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koG5/fAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCD7C433C7;
	Thu, 18 Jan 2024 07:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564744;
	bh=/NtUvjlmP2hVHln7V3vPbrBUjpMmcUDbRk8I6b5u3TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=koG5/fALSjBMhxQD9cANZcieQZWPagCgxNq8DEE/hPg7Y1DiHrBgkuMmxThjdhsw9
	 swC1/fBT593+k3oz/EKujnaldRJLulwXkI8pstExwU0h6e+JYrI3msL5BxHCsPRVqI
	 0zr2hslPBHXXQhR/ozdEXTyylbmdWwTSYxswYh8FrD3/GvJgkkLwUIwlSXLKytcSes
	 CcNmxKFP8M2ZieeGxshms7JQqsMkfeExzCuwpofVGaSUQJZEK8/GljqBfJFWnWqQZr
	 cqaoBjiPQwjitpOUbx6eC2rjC0c9KE9kxBtzoaT68RNuhlvuv575JwF5GuKBpaKEAk
	 qhGf6lIu8G37g==
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
Subject: [PATCH 29/45] tty: vt: make consw::con_switch() return a bool
Date: Thu, 18 Jan 2024 08:57:40 +0100
Message-ID: <20240118075756.10541-30-jirislaby@kernel.org>
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
index 2df306922b4e..88d7b48871fb 100644
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
index c81723ad4dc1..e303098aabab 100644
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


