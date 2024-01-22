Return-Path: <linux-kernel+bounces-32834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 093888360B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0A31C216A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B33FE37;
	Mon, 22 Jan 2024 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcMOMXIJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6583B1A0;
	Mon, 22 Jan 2024 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921493; cv=none; b=KMilCtqesoVrj8YM1XCscsOyQotgXD1RxnRTsTMe2PstokT7YA4LyQbxg63T+MR+ZR3PNzRQrNj1xZueL9fP+F4ARGVpSjUHfr+kZbwWRN4d8hepz/HkhD5ezBy/WGbKDnqy7LpaLPvCJFmLcCIyST44J7stghzzF0qM2W0vy5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921493; c=relaxed/simple;
	bh=iRThJTxTVrt6AkEgbytvLaneeqo13XQBYWEO6rN1MpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwL0uoqZUCnX6kbUsLVR8uzm9yjUCUUDclJ4NzrNGTV2CsBID3QJKuweoM6Yz1g3SUOYPkIKQbfzR+0hHA+jhLqaX4fltaWOseFzMFcVtMKKLZ48yYRnkkKKK95B/mmR3LwGHEgkMDXFx+Gaxp5kOdiatvq95Mm++YEm4suEmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcMOMXIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AE8C43394;
	Mon, 22 Jan 2024 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921492;
	bh=iRThJTxTVrt6AkEgbytvLaneeqo13XQBYWEO6rN1MpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WcMOMXIJz3mLBOONN0l9L4Uda9lbsW/frvp6o6NdytYbuTU82ns19tDKL89zT3Nf7
	 axGYx+3We24HIXDpcTchmoeeK9NmkEUQRnuGFyKVHWHY1H0W1Ji28eTZggFzbc7R/3
	 4duJjT4cp02TsUmUXhvzJ1Ye1ZbrjgBXQcvUpxDeYC4zHypjyNv0VZ1W449tnBO7Lx
	 1Fnw7mvszRYhHxawRASjOpxh+6Qn5NwoYRlFUMairBIMRR3Zuze6mlMEYTMaclZS2A
	 joOLG018fkqX7P+sxdI1d8rD1xfI/qeZb/Oq8/+zQgWZF1PyIkkhpplE8Nt35g+Jx3
	 pOVL266YfyGOg==
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
Subject: [PATCH v2 24/47] tty: vt: eliminate unneeded consw::con_putc() implementations
Date: Mon, 22 Jan 2024 12:03:38 +0100
Message-ID: <20240122110401.7289-25-jirislaby@kernel.org>
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

All these consw::con_putc() implementations do the same as
consw::con_putcs() (only for one charattr) or even call
consw::con_putcs() on their own.

Drop them, as thanks to the new con_putc() helper in the previous patch,
the console code performs this already -- exactly if consw::con_putc()
is missing (NULL).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-parisc@vger.kernel.org
---
 drivers/video/console/mdacon.c   |  6 ------
 drivers/video/console/sticon.c   | 12 ------------
 drivers/video/console/vgacon.c   |  2 --
 drivers/video/fbdev/core/fbcon.c |  9 ---------
 4 files changed, 29 deletions(-)

diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 2ff2c9394d40..01e779943c00 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -427,11 +427,6 @@ static inline u16 *mda_addr(unsigned int x, unsigned int y)
 	return mda_vram_base + y * mda_num_columns + x;
 }
 
-static void mdacon_putc(struct vc_data *c, int ch, int y, int x)
-{
-	scr_writew(mda_convert_attr(ch), mda_addr(x, y));
-}
-
 static void mdacon_putcs(struct vc_data *c, const unsigned short *s,
 		         int count, int y, int x)
 {
@@ -536,7 +531,6 @@ static const struct consw mda_con = {
 	.con_init =		mdacon_init,
 	.con_deinit =		mdacon_deinit,
 	.con_clear =		mdacon_clear,
-	.con_putc =		mdacon_putc,
 	.con_putcs =		mdacon_putcs,
 	.con_cursor =		mdacon_cursor,
 	.con_scroll =		mdacon_scroll,
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index b1d972d9a31c..2f87b5909d0d 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -71,17 +71,6 @@ static const char *sticon_startup(void)
     return "STI console";
 }
 
-static void sticon_putc(struct vc_data *conp, int c, int ypos, int xpos)
-{
-    if (vga_is_gfx || console_blanked)
-	    return;
-
-    if (conp->vc_mode != KD_TEXT)
-    	    return;
-
-    sti_putc(sticon_sti, c, ypos, xpos, font_data[conp->vc_num]);
-}
-
 static void sticon_putcs(struct vc_data *conp, const unsigned short *s,
 			 int count, int ypos, int xpos)
 {
@@ -362,7 +351,6 @@ static const struct consw sti_con = {
 	.con_init		= sticon_init,
 	.con_deinit		= sticon_deinit,
 	.con_clear		= sticon_clear,
-	.con_putc		= sticon_putc,
 	.con_putcs		= sticon_putcs,
 	.con_cursor		= sticon_cursor,
 	.con_scroll		= sticon_scroll,
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 85f29dec2c3d..4beab11f87eb 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1193,7 +1193,6 @@ static bool vgacon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
 
 static void vgacon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
 			 unsigned int width) { }
-static void vgacon_putc(struct vc_data *vc, int c, int ypos, int xpos) { }
 static void vgacon_putcs(struct vc_data *vc, const unsigned short *s,
 			 int count, int ypos, int xpos) { }
 
@@ -1203,7 +1202,6 @@ const struct consw vga_con = {
 	.con_init = vgacon_init,
 	.con_deinit = vgacon_deinit,
 	.con_clear = vgacon_clear,
-	.con_putc = vgacon_putc,
 	.con_putcs = vgacon_putcs,
 	.con_cursor = vgacon_cursor,
 	.con_scroll = vgacon_scroll,
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 8a31a36483ea..38de0f8723aa 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1292,14 +1292,6 @@ static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
 			   get_color(vc, info, scr_readw(s), 0));
 }
 
-static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
-{
-	unsigned short chr;
-
-	scr_writew(c, &chr);
-	fbcon_putcs(vc, &chr, 1, ypos, xpos);
-}
-
 static void fbcon_clear_margins(struct vc_data *vc, int bottom_only)
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
@@ -3159,7 +3151,6 @@ static const struct consw fb_con = {
 	.con_init 		= fbcon_init,
 	.con_deinit 		= fbcon_deinit,
 	.con_clear 		= fbcon_clear,
-	.con_putc 		= fbcon_putc,
 	.con_putcs 		= fbcon_putcs,
 	.con_cursor 		= fbcon_cursor,
 	.con_scroll 		= fbcon_scroll,
-- 
2.43.0


