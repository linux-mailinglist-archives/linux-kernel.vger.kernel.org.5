Return-Path: <linux-kernel+bounces-32851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E3F8360EF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA981C2206A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DFD47A7B;
	Mon, 22 Jan 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzUIcl3I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005BF47A47;
	Mon, 22 Jan 2024 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921527; cv=none; b=njKdN9RoAoAKW0iPQfyG5Y0IzcjbYhFyUkmHtdBsci8lm5eFPpEEAXqsUDwhcHGHjGslLulH9WbVvkI/VIMm81P+/tV6U39Cw6MSnQS8F5fedu8kS+jgV0pc09C8t8u9K/VguE3piLe/yYuaJmNs5MqtlH/dmVJL/2N0Y6nZJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921527; c=relaxed/simple;
	bh=2URKPRL7zfWbHQYqpoKtEkBU2SALWu3e2GJlko088uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNyLZ3A6tF5KdlFVK2eJ8/DyxnuPl6Vv+3Ih/JJHHmvhMfplT1TN3YlSxVLTsXdtZwYrZNytMBI6tyDEto8/SN4zGcM7mzqF8tkDrghZJF57Su0b32SvPlLVPyXPbzZfhbFSBzXLQANWsjY3uX9xKCjt80QPtumlAxpof1ZXgVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzUIcl3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCABEC43390;
	Mon, 22 Jan 2024 11:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921526;
	bh=2URKPRL7zfWbHQYqpoKtEkBU2SALWu3e2GJlko088uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzUIcl3IVgdt1LAfkiVpeKfY50AYKvfkmObnKYuViAvyPsXvlgJjkZEVtW3QmLoe9
	 I/YvcsOjspyVNZsdjaQuG+rArH/xY/E2IrrVtWLU2m/3derN05jBl2dUmTvO+b77Mr
	 a82d3Kyd0MfhEbAg1kiB6itfc34E3RSpQ4WGxVbvOLOj8dzz7BoPaocd8xJJBYbZHi
	 II16H+iunyulp4AtsHZMAF4uTr9Iwr+GkI/YwrKG43tatrQO444uVhxUSYnXANuYFU
	 KUQKlOYciL1DZZbtpgA0A99HIq+6c5BlC8+JAnQTjcaQ1LdJ6nYliHba8axR5knQfy
	 jXi1oDoQFj0cg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 38/47] tty: vt: change consw::con_set_origin() return type
Date: Mon, 22 Jan 2024 12:03:52 +0100
Message-ID: <20240122110401.7289-39-jirislaby@kernel.org>
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
index 4d1c8f5863af..7597f04b0dc7 100644
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
index 6bb7e5e37ae4..82e4b554a801 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -55,6 +55,9 @@ enum vc_intensity;
  * @con_set_palette: sets the palette of the console to @table (optional)
  * @con_scrolldelta: the contents of the console should be scrolled by @lines.
  *		     Invoked by user. (optional)
+ * @con_set_origin: set origin (see &vc_data::vc_origin) of the @vc. If not
+ *		provided or returns false, the origin is set to
+ *		@vc->vc_screenbuf. (optional)
  */
 struct consw {
 	struct module *owner;
@@ -87,7 +90,7 @@ struct consw {
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


