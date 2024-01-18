Return-Path: <linux-kernel+bounces-29823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4D0831417
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E1B281C68
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8FF2EB04;
	Thu, 18 Jan 2024 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6d0N+d0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB0B2E852;
	Thu, 18 Jan 2024 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564763; cv=none; b=H3uLUjCAH7tF3AcYNqu76DX7u2xJpFKdV2Gpl2Vzso/kq6wWYdJSpPlGoWgy1dwQZX+mV0Pr2uzIMYpU4TPKnf31as+StVYWG47FdNoicbhlY7wdnvPMAmFQF+NJkJ9XvaJe4OqNxw6hejg0CQX7n0e3dIAYkKsgoj1v/svSq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564763; c=relaxed/simple;
	bh=+Fey0ueL3fs+YfoywPjRe7ybSQ7PCBnb+Q6J1ddQlD8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=kRoTueQQ1jXNNEv3So2SHnBJ0z4pqjIkfW9KUpHe+cMD8gPWn6WxrK24v6Dqs5paDS8/XZm9XNBEq9bm6SoddDbiqEDF9g9tqy8NckFCYgSaVG7d52EwlzRl56aURtgRUlkwRWSRUmSxp68mDSWMjAa7jlJk6h7rG11Yikz2bPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6d0N+d0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158B8C43399;
	Thu, 18 Jan 2024 07:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564762;
	bh=+Fey0ueL3fs+YfoywPjRe7ybSQ7PCBnb+Q6J1ddQlD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6d0N+d0AoOKuyftlq2UstduK0SAteraz7/1E0aTPJEQfef6OmG9CSofeaGqyUdKA
	 hwKgSj9tEJR5fT59H/Izk8fUdoEqrDAEWg/N87P+xddlAIv6psQeNzXX7udJPzfYd2
	 M01zz2/WKFXSoo20pLY4mZuIErSwMTflEv1KDIFx2kCwSQ9msgpt5yxukoKWhs8Ty5
	 Ltu0WoFKcFd6E0TFeYwWmSoPigVQXjaktPHZLdn7CCYJ+61ZPt/a1BdxYNNQrKLYAK
	 UX41bBxpOaqaLe+xJFhNfhsK4GsZHLYKXFOgcbA2Kcp/O/o19WoqssSadd5S49uwx4
	 rp8Eqbl0abYRA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 36/45] tty: vt: change consw::con_set_origin() return type
Date: Thu, 18 Jan 2024 08:57:47 +0100
Message-ID: <20240118075756.10541-37-jirislaby@kernel.org>
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

The return value of consw::con_set_origin() is only true/false, meaining
if vc->vc_origin is set to vc->vc_screenbuf or not.

So switch the type and returned values accordingly.

And document the hook.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/console/vgacon.c | 8 ++++----
 include/linux/console.h        | 5 ++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index ea086b39c6f5..4a40da81990d 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -65,7 +65,7 @@ static struct vgastate vgastate;
  *  Interface used by the world
  */
 
-static int vgacon_set_origin(struct vc_data *c);
+static bool vgacon_set_origin(struct vc_data *c);
 
 static struct uni_pagedict *vgacon_uni_pagedir;
 static int vgacon_refcount;
@@ -1100,15 +1100,15 @@ static int vgacon_resize(struct vc_data *c, unsigned int width,
 	return 0;
 }
 
-static int vgacon_set_origin(struct vc_data *c)
+static bool vgacon_set_origin(struct vc_data *c)
 {
 	if (vga_is_gfx ||	/* We don't play origin tricks in graphic modes */
 	    (console_blanked && !vga_palette_blanked))	/* Nor we write to blanked screens */
-		return 0;
+		return false;
 	c->vc_origin = c->vc_visible_origin = vga_vram_base;
 	vga_set_mem_top(c);
 	vga_rolled_over = 0;
-	return 1;
+	return true;
 }
 
 static void vgacon_save_screen(struct vc_data *c)
diff --git a/include/linux/console.h b/include/linux/console.h
index 543de22a3f23..c07e1ce6bd14 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -63,6 +63,9 @@ enum vc_intensity;
  * @con_set_palette: sets the palette of the console to @table (optional)
  * @con_scrolldelta: the contents of the console should be scrolled by @lines.
  *		     Invoked by user. (optional)
+ * @con_set_origin: set origin (see &vc_data::vc_origin) of the @vc. If not
+ *		provided or returns false, the origin is set to
+ *		@vc->vc_screenbuf. (optional)
  */
 struct consw {
 	struct module *owner;
@@ -95,7 +98,7 @@ struct consw {
 	void	(*con_set_palette)(struct vc_data *vc,
 			const unsigned char *table);
 	void	(*con_scrolldelta)(struct vc_data *vc, int lines);
-	int	(*con_set_origin)(struct vc_data *vc);
+	bool	(*con_set_origin)(struct vc_data *vc);
 	void	(*con_save_screen)(struct vc_data *vc);
 	u8	(*con_build_attr)(struct vc_data *vc, u8 color,
 			enum vc_intensity intensity,
-- 
2.43.0


