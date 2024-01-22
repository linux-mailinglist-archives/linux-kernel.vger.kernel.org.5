Return-Path: <linux-kernel+bounces-32844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A44F8360DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 644ECB2BDA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7824642C;
	Mon, 22 Jan 2024 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaT/Jk7B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2924439E;
	Mon, 22 Jan 2024 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921509; cv=none; b=pCN0zEbCkWI9j7F/SHBhxTuTO5MAS/HMBBfwsbLdyib/7iCiOw+XYJjKI6QiEEw+V4ZJzoR3almdIZy1urKAv1CII0TTrgxM0eqihXys14YF8+CX/H1mmMLEtOSwwxPUM5x5dUDV0ce4FfYckl1rrEC9fcM6yHidPkx3qPNCpoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921509; c=relaxed/simple;
	bh=ab3iO5eB3FsNHgSte6RrqeuJox0Ztd4VE2emwNkTWnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MekEg9X5Hei2uL8N/wnMBoeo65hKN1j0MiTuU9axUIiIhmWlETk84ls+HVJoosUabyk2F8roduPd0MeOWfC1IM5+ySpYY7mb/8prR2y0gQruo+HoVX6dn05mdh6mLbSI7zmzHrBKvThE1ghem8/UWQ9YLC8oC+rsznErX/La4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaT/Jk7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145C2C43394;
	Mon, 22 Jan 2024 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921508;
	bh=ab3iO5eB3FsNHgSte6RrqeuJox0Ztd4VE2emwNkTWnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QaT/Jk7BEL78I9U8fb1XmJZ05aC0qCpjcl9MCDeTxrKvPZVasheuUJs5lAKtw+hGj
	 u2okeF2UeJJb3Ird5Sb4lroyb40yuT55yBrhW/js2TGCuPUQUMYG/f/wIL5WjwcHjL
	 nzhTF8mgaObz/wjPNyMLGGk/r8EhAXWHVAQwhA9yuLLW4qemjPHebG9/mnL5D6z4Da
	 0NWpd+w2H06uWf59iPJJ00T9Y8rZ8jaofjKXyIHh/N7mXyYZ1j8qV3Pp+RoX8Jq+pL
	 rwqaXEoJIQQ27S9Fg5dSC5lfZAcbL2n8AhSPSbVFds9k2xDfLUMMuTW/aExAzoCT+a
	 V1W1O19AYCBcA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 31/47] tty: vt: stop using -1 for blank mode in consw::con_blank()
Date: Mon, 22 Jan 2024 12:03:45 +0100
Message-ID: <20240122110401.7289-32-jirislaby@kernel.org>
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

-1 is the same as VESA_VSYNC_SUSPEND in all con_blank() implementations.
So we can remove this special case from vgacon now too.

Despite con_blank() of fbcon looks complicated, the "if
(!fbcon_is_inactive(vc, info))" branch is not taken as we set
"ops->graphics = 1;" few lines above. So what matters there (as in all
other blank implementations except vgacon) is if 'blank' is zero or not.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/tty/vt/vt.c            | 2 +-
 drivers/video/console/vgacon.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index fd868046f586..13be125a06aa 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4347,7 +4347,7 @@ void do_blank_screen(int entering_gfx)
 	if (entering_gfx) {
 		hide_cursor(vc);
 		save_screen(vc);
-		vc->vc_sw->con_blank(vc, -1, 1);
+		vc->vc_sw->con_blank(vc, 1, 1);
 		console_blanked = fg_console + 1;
 		blank_state = blank_off;
 		set_origin(vc);
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index f89eb53c0b79..804b6a180b60 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -814,7 +814,6 @@ static int vgacon_blank(struct vc_data *c, int blank, int mode_switch)
 		/* Tell console.c that it has to restore the screen itself */
 		return 1;
 	case 1:		/* Normal blanking */
-	case -1:	/* Obsolete */
 		if (!mode_switch && vga_video_type == VIDEO_TYPE_VGAC) {
 			vga_pal_blank(&vgastate);
 			vga_palette_blanked = true;
-- 
2.43.0


