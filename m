Return-Path: <linux-kernel+bounces-32850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 847858360EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8B91F210F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A89647A51;
	Mon, 22 Jan 2024 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgUXEweS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A204779C;
	Mon, 22 Jan 2024 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921524; cv=none; b=XPX/CkjGNmm7CVHQutAD2+p46bbvQK3LqBOXYmXHDeum9imFVvyHRJw5f20Ay/tHkz7wRcEkVPYz/tVIDPe7LRWFAJ0avT/venYSQRLu0D3ilaJAbsokMbO+loSlFhWq9HlsQHfOOMHh0bimdn9SqQx8qIv17ckJpad/K9tMIXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921524; c=relaxed/simple;
	bh=3cbdCulYDMzHdVHQyMlTnkEbtcMWUQ2WS/4aMQLbalE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQxIxJJ3uSqDlrA0BRJud7U8tYEDqeDxVcF03RD6kc7hWZ9AGj+/u0mVu+GvUwZaMmXy0hWJSlliGK6bLKBNUh7xVqpUAUhbYvnicJRWYFaQNQy3LwcULF5dIOnhLAQOqhokcPayxxlt6NqM/c8XYBHmSCNUWMC8rwQuPxZdKzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgUXEweS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A181C433B2;
	Mon, 22 Jan 2024 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921524;
	bh=3cbdCulYDMzHdVHQyMlTnkEbtcMWUQ2WS/4aMQLbalE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgUXEweSjNFK/nw1p8YvQREa0chlb+TkiAcu+Fi7+FCNzam/6zTPyNnOEskoKtPor
	 MBV16HJ30AhMhj5kxauYUJA1m31tOl8xdv5FPhb2qjGFKm4Q9/UK+eJ8h8Nf2BRp2A
	 EcsyoVPx/rz/cUXi5Jk27U/J5Io0NraoViFM0qIIo8ahvfBwWayAX24cWhtd4X57Gz
	 76J3Rff+ucD/dJ98z9SYc7KjjL/3Yo+hhbvrFY6j0WGMRtR+CkMkVVxRPXqDmffg9f
	 8wtZSk+yTH/fmlacapZVNEimxHdKMnb+PR/gPDL8KVhK75VjvvvcxFS8siwPnH3HGf
	 uoo/fMwMsfJYg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH v2 37/47] tty: vt: make consw::con_font_default()'s name const
Date: Mon, 22 Jan 2024 12:03:51 +0100
Message-ID: <20240122110401.7289-38-jirislaby@kernel.org>
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

It's a name after all and that is not supposed to be changed. So make it
const to make this obvious.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-parisc@vger.kernel.org
---
 drivers/video/console/newport_con.c | 3 ++-
 drivers/video/console/sticon.c      | 3 ++-
 drivers/video/fbdev/core/fbcon.c    | 3 ++-
 include/linux/console.h             | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 4203bd5fd0a1..a51cfc1d560e 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -564,7 +564,8 @@ static int newport_set_def_font(int unit, struct console_font *op)
 	return 0;
 }
 
-static int newport_font_default(struct vc_data *vc, struct console_font *op, char *name)
+static int newport_font_default(struct vc_data *vc, struct console_font *op,
+				const char *name)
 {
 	return newport_set_def_font(vc->vc_num, op);
 }
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 710201fb8ce4..4c7b4959a1aa 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -246,7 +246,8 @@ static int sticon_set_font(struct vc_data *vc, const struct console_font *op,
 	return 0;
 }
 
-static int sticon_font_default(struct vc_data *vc, struct console_font *op, char *name)
+static int sticon_font_default(struct vc_data *vc, struct console_font *op,
+			       const char *name)
 {
 	sticon_set_def_font(vc->vc_num);
 
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 62474630c4d4..657160eec0a5 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2533,7 +2533,8 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	return fbcon_do_set_font(vc, font->width, font->height, charcount, new_data, 1);
 }
 
-static int fbcon_set_def_font(struct vc_data *vc, struct console_font *font, char *name)
+static int fbcon_set_def_font(struct vc_data *vc, struct console_font *font,
+			      const char *name)
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	const struct font_desc *f;
diff --git a/include/linux/console.h b/include/linux/console.h
index 0a9f4cbdde83..6bb7e5e37ae4 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -81,7 +81,7 @@ struct consw {
 	int	(*con_font_get)(struct vc_data *vc, struct console_font *font,
 			unsigned int vpitch);
 	int	(*con_font_default)(struct vc_data *vc,
-			struct console_font *font, char *name);
+			struct console_font *font, const char *name);
 	int     (*con_resize)(struct vc_data *vc, unsigned int width,
 			      unsigned int height, bool from_user);
 	void	(*con_set_palette)(struct vc_data *vc,
-- 
2.43.0


