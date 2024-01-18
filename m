Return-Path: <linux-kernel+bounces-29817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 699E88313FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01DD7B240A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3C72DF73;
	Thu, 18 Jan 2024 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXfXfYoS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01542D79B;
	Thu, 18 Jan 2024 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564746; cv=none; b=j2qzOZ2H7WvCURm16GXfVV/VnyJPbgAa/HHEs0txIypj73EGxDYZaAyRSrj+R0gsP6PTP+l12+9Eo6VnopUokPSBkWdOa/LFfMigK1IVCMz4mQyXGFgMHzpb3Gp4hEBIv+qFTUvDHtzKhJymfNk2svCly2EBmDqSsl/QqrieNVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564746; c=relaxed/simple;
	bh=1JA5AooyZLXGqVCAGbSDSuK+q4Ohn8Zc6gZRRlzf9bA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=h2r2iCoaYS4GJtgUvwq8oZzI6aW5jKrzt+EfkOrPe+7qBRTumnsPp0w91cnuh+OI2yntCasbCgzTxjVbmBXGXn1oGs9z9F0+HU1iuqrR8XLrQbBsudl+dxrg5YnU7XjgsQqoxX0hk3a54fgi6SJYOfiFHnCfVmO18NAAXFCaxd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXfXfYoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89967C43601;
	Thu, 18 Jan 2024 07:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564746;
	bh=1JA5AooyZLXGqVCAGbSDSuK+q4Ohn8Zc6gZRRlzf9bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BXfXfYoSYpvTCIeWRHpilD2rVpaS8JT+XmLttQvYBF0iQLK2W4NJbrdXyAjLkiTyI
	 94OswkcWBFi2tCRhwgda1dfssgJ4B6prz1UWT44wB+bRKQSLpQNansdc+sxKatxcnD
	 2/h6mnDRiA3gkqcElSRnBLvCGceeH1VuShDp2gcwENBfBZjG0ekzdVWXR+jfcei/BM
	 kH9KJr3y9m3zN1HmFO5wqML5y/KtdOdHjsBejxY1JLSe6VXlTeA+5HRBH+zX8eBVY1
	 9qugeiDF/Uxezsim4HQom06kGaN85b4gJ4SPM2uKC2WabkFW/VZQXozWOlsmTR9upz
	 Z24rUj6n1kQww==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 30/45] tty: vt: stop using -1 for blank mode in consw::con_blank()
Date: Thu, 18 Jan 2024 08:57:41 +0100
Message-ID: <20240118075756.10541-31-jirislaby@kernel.org>
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
index 88d7b48871fb..279f802aa222 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4361,7 +4361,7 @@ void do_blank_screen(int entering_gfx)
 	if (entering_gfx) {
 		hide_cursor(vc);
 		save_screen(vc);
-		vc->vc_sw->con_blank(vc, -1, 1);
+		vc->vc_sw->con_blank(vc, 1, 1);
 		console_blanked = fg_console + 1;
 		blank_state = blank_off;
 		set_origin(vc);
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index e303098aabab..5025ab501f02 100644
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


