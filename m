Return-Path: <linux-kernel+bounces-32839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 122F18360C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4651F22E06
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1188140C12;
	Mon, 22 Jan 2024 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XziewYsx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD4840BFE;
	Mon, 22 Jan 2024 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921497; cv=none; b=QOckveEoG2K0wuzgSB4FbYalTvxys8sr7qKdjNFSoOipn9Oll5h8SsNOr4YqfjDSXHLU5zbAjFzaqzIxcCQXqC10dhG5F81/Al8oAcqQCoY38kT38kacJr+Sk5HA159Vqa2GSmmXuxMdRw9nQ5to9RcR5aOz1XNp9HzWW3JqMss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921497; c=relaxed/simple;
	bh=DAOYyLo1oRnD4iTPfOiMEY1vdjbEkdytO8nE0RBybMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9SQuROg1Ikj5wSapqYnw9bNKMElybJ2Yw+HiJaAAu/+Drtpa8DaE0Cy6BCQce9xVHRRMXi/cMMfWRpZ27yId5+bytTnqKTvYVQjupk592+dWZ33s3vJS8KZeXTOmBTm50JL00Soqwl7JsSHdknCnKFJuNvFlncMWY+5STvgpgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XziewYsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847A9C433C7;
	Mon, 22 Jan 2024 11:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921496;
	bh=DAOYyLo1oRnD4iTPfOiMEY1vdjbEkdytO8nE0RBybMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XziewYsxLLlD/hclxqdGpQyzU2GoZaBhkVJilxHVkKwxonK+sZh6dEAtI5MTEfLS6
	 vKJ+mrX4C4Fggy3aisQd/L1XN9j7HC2xUKdE8qDofM1zr0PMXg1c6e3Zf5yduWzw21
	 PJr7LctUU352ia16qtex2WUWJsQffWiPUcCGGaE36gv+Rqfmc7HtBT2gyZa/cojTxe
	 k9Y1rybMlEPWL7LI/IVTEquwEJ/JbT9rqeIsukDTUfAPVRfruAOu6d0WHfEwlh1BI1
	 kfbZEA8KeAKg04aBgHZ1FGNTOwHbYUsZy6KT0dRjGuiN+cVVSK3RzqJrSnAy/meCSi
	 hcvCnkxIuRjgw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 26/47] tty: vt: sanitize consw::con_putcs() parameters
Date: Mon, 22 Jan 2024 12:03:40 +0100
Message-ID: <20240122110401.7289-27-jirislaby@kernel.org>
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

Similar to con_putc() in the previous patch:
* make the pointer to charattr a pointer to u16, and
* make x, y, and count unsigned as they are strictly non-negative.

And again, document that hook.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/video/console/dummycon.c    | 10 +++++-----
 drivers/video/console/mdacon.c      |  4 ++--
 drivers/video/console/newport_con.c |  9 +++++----
 drivers/video/console/sticon.c      |  4 ++--
 drivers/video/console/vgacon.c      |  4 ++--
 drivers/video/fbdev/core/fbcon.c    |  4 ++--
 include/linux/console.h             |  6 ++++--
 7 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 1874beed0325..188d9f3e201c 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -59,10 +59,10 @@ static void dummycon_putc(struct vc_data *vc, u16 c, unsigned int y,
 	raw_notifier_call_chain(&dummycon_output_nh, 0, NULL);
 }
 
-static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
-			   int count, int ypos, int xpos)
+static void dummycon_putcs(struct vc_data *vc, const u16 *s, unsigned int count,
+			   unsigned int ypos, unsigned int xpos)
 {
-	int i;
+	unsigned int i;
 
 	if (!dummycon_putc_called) {
 		/* Ignore erases */
@@ -87,8 +87,8 @@ static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
 #else
 static void dummycon_putc(struct vc_data *vc, u16 c, unsigned int y,
 			  unsigned int x) { }
-static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
-			   int count, int ypos, int xpos) { }
+static void dummycon_putcs(struct vc_data *vc, const u16 *s, unsigned int count,
+			   unsigned int ypos, unsigned int xpos) { }
 static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
 {
 	return 0;
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 01e779943c00..b8822b615b2f 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -427,8 +427,8 @@ static inline u16 *mda_addr(unsigned int x, unsigned int y)
 	return mda_vram_base + y * mda_num_columns + x;
 }
 
-static void mdacon_putcs(struct vc_data *c, const unsigned short *s,
-		         int count, int y, int x)
+static void mdacon_putcs(struct vc_data *c, const u16 *s, unsigned int count,
+			 unsigned int y, unsigned int x)
 {
 	u16 *dest = mda_addr(x, y);
 
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 9b5c0118873e..5e65ee0b7c07 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -396,12 +396,13 @@ static void newport_putc(struct vc_data *vc, u16 charattr, unsigned int ypos,
 	RENDER(npregs, p);
 }
 
-static void newport_putcs(struct vc_data *vc, const unsigned short *s,
-			  int count, int ypos, int xpos)
+static void newport_putcs(struct vc_data *vc, const u16 *s,
+			  unsigned int count, unsigned int ypos,
+			  unsigned int xpos)
 {
-	int i;
-	int charattr;
 	unsigned char *p;
+	unsigned int i;
+	u16 charattr;
 
 	charattr = (scr_readw(s) >> 8) & 0xff;
 
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 2f87b5909d0d..906da1fde7c8 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -71,8 +71,8 @@ static const char *sticon_startup(void)
     return "STI console";
 }
 
-static void sticon_putcs(struct vc_data *conp, const unsigned short *s,
-			 int count, int ypos, int xpos)
+static void sticon_putcs(struct vc_data *conp, const u16 *s, unsigned int count,
+			 unsigned int ypos, unsigned int xpos)
 {
     if (vga_is_gfx || console_blanked)
 	    return;
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 4beab11f87eb..aa0589085847 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1193,8 +1193,8 @@ static bool vgacon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
 
 static void vgacon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
 			 unsigned int width) { }
-static void vgacon_putcs(struct vc_data *vc, const unsigned short *s,
-			 int count, int ypos, int xpos) { }
+static void vgacon_putcs(struct vc_data *vc, const u16 *s, unsigned int count,
+			 unsigned int ypos, unsigned int xpos) { }
 
 const struct consw vga_con = {
 	.owner = THIS_MODULE,
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 38de0f8723aa..7a7b2ac0d7a9 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1279,8 +1279,8 @@ static void fbcon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
 	__fbcon_clear(vc, sy, sx, 1, width);
 }
 
-static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
-			int count, int ypos, int xpos)
+static void fbcon_putcs(struct vc_data *vc, const u16 *s, unsigned int count,
+			unsigned int ypos, unsigned int xpos)
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_display *p = &fb_display[vc->vc_num];
diff --git a/include/linux/console.h b/include/linux/console.h
index 92d57e5b3009..82d55764a66f 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -41,6 +41,7 @@ enum vc_intensity;
  * @con_clear:  erase @count characters at [@x, @y] on @vc. @count >= 1.
  * @con_putc:   emit one character with attributes @ca to [@x, @y] on @vc.
  *		(optional -- @con_putcs would be called instead)
+ * @con_putcs:  emit @count characters with attributes @s to [@x, @y] on @vc.
  * @con_scroll: move lines from @top to @bottom in direction @dir by @lines.
  *		Return true if no generic handling should be done.
  *		Invoked by csi_M and printing to the console.
@@ -57,8 +58,9 @@ struct consw {
 			     unsigned int x, unsigned int count);
 	void	(*con_putc)(struct vc_data *vc, u16 ca, unsigned int y,
 			    unsigned int x);
-	void	(*con_putcs)(struct vc_data *vc, const unsigned short *s,
-			int count, int ypos, int xpos);
+	void	(*con_putcs)(struct vc_data *vc, const u16 *s,
+			     unsigned int count, unsigned int ypos,
+			     unsigned int xpos);
 	void	(*con_cursor)(struct vc_data *vc, int mode);
 	bool	(*con_scroll)(struct vc_data *vc, unsigned int top,
 			unsigned int bottom, enum con_scroll dir,
-- 
2.43.0


