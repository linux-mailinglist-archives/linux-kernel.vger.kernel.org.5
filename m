Return-Path: <linux-kernel+bounces-32847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BDA8360DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA16B1C21F57
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C72446558;
	Mon, 22 Jan 2024 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8fE94Oy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831BD46544;
	Mon, 22 Jan 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921516; cv=none; b=DcRDlZBdpHL0xI98WAf7cTaZ36fTWEQM8qRW8uxheEWwWH9OyQf8rdJp/6lmxzLQGf81lKBtqsl5lx+4wWrrGptqBdjaN5WgQMBYhMjP4JUpPNzYoV9bSqC2KRtc4WrY7DcXWue8KwBeJg6NpjBWq18B8MmE6eZQAU3WtIGHEI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921516; c=relaxed/simple;
	bh=o4zJzmkB8jwgI66XbobRnJrzxHhibmUMjcmGOoEFkJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjPtfE/9ly6bHtLeJi9H45TLK5XraPzHmGdYc3klbmZTXEnQ61w/hzMLaqtRM3L9fwQToIljOvQJmCHb7hm2yE0IV94idZ9ExFL89JyGBxuyYCoHHxbn7wwoXUakKDbCUNW8kXqLWA0quZrI/+v1ZiVuhqzRx4PtKnojsxRYB0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8fE94Oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDE7C433F1;
	Mon, 22 Jan 2024 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921516;
	bh=o4zJzmkB8jwgI66XbobRnJrzxHhibmUMjcmGOoEFkJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8fE94OyV75r5tiKB3g81dK+VH5X141NV5HnA3BkRdxkB2+SGc4VuE6MYylxhvV0t
	 868LvplVN+d/2kF84Dl/6yuGNZMRdR7y0jkk+FsY0sfUvf+1fFykY1MDjm91dSsE/Q
	 PNJFYT9Alc7LuVZm9flUgtVYWYLqd+bjEzFNvp/qlflgV9PeY7wsYkakWTC6RjTQzh
	 9Uw6oDXnOT4Ui05GTR70YCkH3Zpksvj5Pbj+V1NyRC4rJLcMM02fuMXCpkzR9iuWM4
	 7pov9Z3/WkvLCrcDeVWOWrmr++qhUyD0s4QP3JuRbzAjGeMlgr+/rdV1hSB0kj1ClD
	 yNl+f6fZIbzXA==
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
Subject: [PATCH v2 34/47] tty: vt: use enum constants for VESA blanking modes
Date: Mon, 22 Jan 2024 12:03:48 +0100
Message-ID: <20240122110401.7289-35-jirislaby@kernel.org>
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

Use the new enum for VESA constants. This improves type checking in
consw::con_blank().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-parisc@vger.kernel.org
---

Notes:
    [v2] the enum is added earlier, so reword and rebase

 drivers/tty/vt/vt.c                 | 4 ++--
 drivers/video/console/dummycon.c    | 6 ++++--
 drivers/video/console/mdacon.c      | 3 ++-
 drivers/video/console/newport_con.c | 3 ++-
 drivers/video/console/sticon.c      | 3 ++-
 drivers/video/console/vgacon.c      | 7 ++++---
 drivers/video/fbdev/core/fbcon.c    | 3 ++-
 include/linux/console.h             | 3 ++-
 8 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 0d5d7b5074a4..de9148094c2d 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -175,7 +175,7 @@ int do_poke_blanked_console;
 int console_blanked;
 EXPORT_SYMBOL(console_blanked);
 
-static int vesa_blank_mode; /* 0:none 1:suspendV 2:suspendH 3:powerdown */
+static enum vesa_blank_mode vesa_blank_mode;
 static int vesa_off_interval;
 static int blankinterval;
 core_param(consoleblank, blankinterval, int, 0444);
@@ -4320,7 +4320,7 @@ static int set_vesa_blanking(u8 __user *mode_user)
 		return -EFAULT;
 
 	console_lock();
-	vesa_blank_mode = (mode < 4) ? mode : VESA_NO_BLANKING;
+	vesa_blank_mode = (mode <= VESA_BLANK_MAX) ? mode : VESA_NO_BLANKING;
 	console_unlock();
 
 	return 0;
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index c8d5aa0e3ed0..d86c1d798690 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -79,7 +79,8 @@ static void dummycon_putcs(struct vc_data *vc, const u16 *s, unsigned int count,
 	raw_notifier_call_chain(&dummycon_output_nh, 0, NULL);
 }
 
-static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
+static int dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
+			  int mode_switch)
 {
 	/* Redraw, so that we get putc(s) for output done while blanked */
 	return 1;
@@ -89,7 +90,8 @@ static void dummycon_putc(struct vc_data *vc, u16 c, unsigned int y,
 			  unsigned int x) { }
 static void dummycon_putcs(struct vc_data *vc, const u16 *s, unsigned int count,
 			   unsigned int ypos, unsigned int xpos) { }
-static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
+static int dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
+			  int mode_switch)
 {
 	return 0;
 }
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 4485ef923bb3..63e3ce678aab 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -451,7 +451,8 @@ static bool mdacon_switch(struct vc_data *c)
 	return true;	/* redrawing needed */
 }
 
-static int mdacon_blank(struct vc_data *c, int blank, int mode_switch)
+static int mdacon_blank(struct vc_data *c, enum vesa_blank_mode blank,
+			int mode_switch)
 {
 	if (mda_type == TYPE_MDA) {
 		if (blank) 
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index ad3a09142770..38437a53b7f1 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -476,7 +476,8 @@ static bool newport_switch(struct vc_data *vc)
 	return true;
 }
 
-static int newport_blank(struct vc_data *c, int blank, int mode_switch)
+static int newport_blank(struct vc_data *c, enum vesa_blank_mode blank,
+			 int mode_switch)
 {
 	unsigned short treg;
 
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 817b89c45e81..e9d5d1f92883 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -298,7 +298,8 @@ static bool sticon_switch(struct vc_data *conp)
     return true;	/* needs refreshing */
 }
 
-static int sticon_blank(struct vc_data *c, int blank, int mode_switch)
+static int sticon_blank(struct vc_data *c, enum vesa_blank_mode blank,
+			int mode_switch)
 {
     if (blank == VESA_NO_BLANKING) {
 	if (mode_switch)
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 02eccd9b3542..84f3682704c7 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -81,7 +81,7 @@ static unsigned int	vga_video_num_lines;			/* Number of text lines */
 static bool		vga_can_do_color;			/* Do we support colors? */
 static unsigned int	vga_default_font_height __read_mostly;	/* Height of default screen font */
 static unsigned char	vga_video_type		__read_mostly;	/* Card type */
-static int		vga_vesa_blanked;
+static enum vesa_blank_mode vga_vesa_blanked;
 static bool 		vga_palette_blanked;
 static bool 		vga_is_gfx;
 static bool 		vga_512_chars;
@@ -683,7 +683,7 @@ static struct {
 	unsigned char ClockingMode;	/* Seq-Controller:01h */
 } vga_state;
 
-static void vga_vesa_blank(struct vgastate *state, int mode)
+static void vga_vesa_blank(struct vgastate *state, enum vesa_blank_mode mode)
 {
 	/* save original values of VGA controller registers */
 	if (!vga_vesa_blanked) {
@@ -797,7 +797,8 @@ static void vga_pal_blank(struct vgastate *state)
 	}
 }
 
-static int vgacon_blank(struct vc_data *c, int blank, int mode_switch)
+static int vgacon_blank(struct vc_data *c, enum vesa_blank_mode blank,
+			int mode_switch)
 {
 	switch (blank) {
 	case VESA_NO_BLANKING:		/* Unblank */
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index d5d924225209..69be5f2106bc 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2198,7 +2198,8 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 	}
 }
 
-static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
+static int fbcon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
+		       int mode_switch)
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
diff --git a/include/linux/console.h b/include/linux/console.h
index 860f82756c9c..69040d7c8f97 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -70,7 +70,8 @@ struct consw {
 			unsigned int bottom, enum con_scroll dir,
 			unsigned int lines);
 	bool	(*con_switch)(struct vc_data *vc);
-	int	(*con_blank)(struct vc_data *vc, int blank, int mode_switch);
+	int	(*con_blank)(struct vc_data *vc, enum vesa_blank_mode blank,
+			     int mode_switch);
 	int	(*con_font_set)(struct vc_data *vc, struct console_font *font,
 			unsigned int vpitch, unsigned int flags);
 	int	(*con_font_get)(struct vc_data *vc, struct console_font *font,
-- 
2.43.0


