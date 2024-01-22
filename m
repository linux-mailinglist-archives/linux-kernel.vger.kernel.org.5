Return-Path: <linux-kernel+bounces-32846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881918360D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5FE1C21DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E2D46441;
	Mon, 22 Jan 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUXVTr/M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9646525;
	Mon, 22 Jan 2024 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921513; cv=none; b=rsbwRauwEl1esgsgLvlR53wuZOnuXq99/vd/gYUum4+Oj7zkdfb3jqUEttsfVQYhGd0OMxiWB0zXEYi9l7TmE64LX/JojTQxuUF1HStaprt7VQX7okFDL3fdap2gY11G8maf6DJ7xIZNqxbCqZTmp9agL2Dav6+2hzHxYqGvU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921513; c=relaxed/simple;
	bh=DwWv6x3M86fYyUgpn5zQFX4R3m7tZMS8FcG3yrjv1Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqJcHqZHxWSX2DySo+xNS1TIVwSrNBrvCdW3OYq7Ia9q274vFXbNZERoy/Q+bgNsVbb0FCdWl4cnEl7JPfdWo+jSWsY7eFMaLIPjl7tGHLL77zKqfR+Rq7lR65q45QQXkXcjQBn61oKmU9orcZNhizYE7Hnp/+3HHAPJuPDPRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUXVTr/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F606C433C7;
	Mon, 22 Jan 2024 11:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921513;
	bh=DwWv6x3M86fYyUgpn5zQFX4R3m7tZMS8FcG3yrjv1Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUXVTr/M+WAcLTwATBJi6yXN7gzivXUNH+x2E5UeczoFkJcszbBBdE8aJGUWWEftL
	 HAt7qfJJICeCOFgV5JtMrmfqZ/u27eU7sOnWTp47tDrYBXpaqw3QGOJpo/woj27zkr
	 b+xXPSmvdIX+BubFjGoMYH/O/V4fpyYlrJ4ma7G5C1Lyn8fl6UpITTyeIbxSvZ2bMy
	 HnFROFutbKqPFZzBbvAcrEwJG3Dgf0m8BdWv/x56ICr3xIzUXoL5AOgFRUlSLdi9Io
	 4o5sVYXikT4/2Q8By34xeUIgf/LLHgcNy+uti/NEePNxDXJFAlqzsedw0vsjgu/yBP
	 ECsXlTRQCvjDA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH v2 33/47] tty: vt: use VESA blanking constants
Date: Mon, 22 Jan 2024 12:03:47 +0100
Message-ID: <20240122110401.7289-34-jirislaby@kernel.org>
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

There are VESA blanking constants defined in vesa.h. So use them in the
console code instead of constant values.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-parisc@vger.kernel.org
---

Notes:
    [v2] reword the commit log after vesa.h introduction

 drivers/tty/vt/vt.c                 | 9 +++++----
 drivers/video/console/newport_con.c | 2 +-
 drivers/video/console/sticon.c      | 2 +-
 drivers/video/console/vgacon.c      | 6 +++---
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 13be125a06aa..0d5d7b5074a4 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4320,7 +4320,7 @@ static int set_vesa_blanking(u8 __user *mode_user)
 		return -EFAULT;
 
 	console_lock();
-	vesa_blank_mode = (mode < 4) ? mode : 0;
+	vesa_blank_mode = (mode < 4) ? mode : VESA_NO_BLANKING;
 	console_unlock();
 
 	return 0;
@@ -4347,7 +4347,7 @@ void do_blank_screen(int entering_gfx)
 	if (entering_gfx) {
 		hide_cursor(vc);
 		save_screen(vc);
-		vc->vc_sw->con_blank(vc, 1, 1);
+		vc->vc_sw->con_blank(vc, VESA_VSYNC_SUSPEND, 1);
 		console_blanked = fg_console + 1;
 		blank_state = blank_off;
 		set_origin(vc);
@@ -4368,7 +4368,8 @@ void do_blank_screen(int entering_gfx)
 
 	save_screen(vc);
 	/* In case we need to reset origin, blanking hook returns 1 */
-	i = vc->vc_sw->con_blank(vc, vesa_off_interval ? 1 : (vesa_blank_mode + 1), 0);
+	i = vc->vc_sw->con_blank(vc, vesa_off_interval ? VESA_VSYNC_SUSPEND :
+				 (vesa_blank_mode + 1), 0);
 	console_blanked = fg_console + 1;
 	if (i)
 		set_origin(vc);
@@ -4419,7 +4420,7 @@ void do_unblank_screen(int leaving_gfx)
 	}
 
 	console_blanked = 0;
-	if (vc->vc_sw->con_blank(vc, 0, leaving_gfx))
+	if (vc->vc_sw->con_blank(vc, VESA_NO_BLANKING, leaving_gfx))
 		/* Low-level driver cannot restore -> do it ourselves */
 		update_screen(vc);
 	if (console_blank_hook)
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 039d1c9937d2..ad3a09142770 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -480,7 +480,7 @@ static int newport_blank(struct vc_data *c, int blank, int mode_switch)
 {
 	unsigned short treg;
 
-	if (blank == 0) {
+	if (blank == VESA_NO_BLANKING) {
 		/* unblank console */
 		treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
 		newport_vc2_set(npregs, VC2_IREG_CONTROL,
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index f3bb48a0e980..817b89c45e81 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -300,7 +300,7 @@ static bool sticon_switch(struct vc_data *conp)
 
 static int sticon_blank(struct vc_data *c, int blank, int mode_switch)
 {
-    if (blank == 0) {
+    if (blank == VESA_NO_BLANKING) {
 	if (mode_switch)
 	    vga_is_gfx = 0;
 	return 1;
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 804b6a180b60..02eccd9b3542 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -800,10 +800,10 @@ static void vga_pal_blank(struct vgastate *state)
 static int vgacon_blank(struct vc_data *c, int blank, int mode_switch)
 {
 	switch (blank) {
-	case 0:		/* Unblank */
+	case VESA_NO_BLANKING:		/* Unblank */
 		if (vga_vesa_blanked) {
 			vga_vesa_unblank(&vgastate);
-			vga_vesa_blanked = 0;
+			vga_vesa_blanked = VESA_NO_BLANKING;
 		}
 		if (vga_palette_blanked) {
 			vga_set_palette(c, color_table);
@@ -813,7 +813,7 @@ static int vgacon_blank(struct vc_data *c, int blank, int mode_switch)
 		vga_is_gfx = false;
 		/* Tell console.c that it has to restore the screen itself */
 		return 1;
-	case 1:		/* Normal blanking */
+	case VESA_VSYNC_SUSPEND:	/* Normal blanking */
 		if (!mode_switch && vga_video_type == VIDEO_TYPE_VGAC) {
 			vga_pal_blank(&vgastate);
 			vga_palette_blanked = true;
-- 
2.43.0


