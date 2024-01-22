Return-Path: <linux-kernel+bounces-32852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 806038360F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361561F22961
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1023D47F5C;
	Mon, 22 Jan 2024 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkEJ3ZLe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535E247F48;
	Mon, 22 Jan 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921529; cv=none; b=pPRQGe/CU8md4ITP2LaWmgjbH9KKXhTTXfjLMAOi7SYR6kysm8CqxOE0z5s7v7ikUPeXXiJJ0NZNbYT8PeHlx8wQVh8z+RSUD3Us0hzSXclGWJbi6UH8pTCe2mKEYZ1kagan/ERiJeKUG3GVVr+x59zhtyAlP82eZdDXIdYpiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921529; c=relaxed/simple;
	bh=GuttBthplzcWAD92DYxHAXefieOSH/0KZn+o6peTBWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtbE4g4+WSvdJP68w4Tnb09n4BYCJ2kkoZfVb1eELMqSwZgIZPmQBxefzXfEm5uTaXKEs2uAkegQA6kF6V6W1YcSxNPkjWNJ+RHnH5ryNWXFmSWT+4xIDyPGC1h3v/ObujqMTDjPwZlDkg1LsN3s+IwaiiU1n0voeV59NpXS6go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkEJ3ZLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3170C43394;
	Mon, 22 Jan 2024 11:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921528;
	bh=GuttBthplzcWAD92DYxHAXefieOSH/0KZn+o6peTBWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkEJ3ZLeZRKJT8TiXZPqzBFEKe8bSvYCaa3SZPpPAZMk3r7QIrU+oy8ELtckKcy6y
	 5F/Kkgnm6T8CqAJfKL61naUGAqh2QtxSmK8Es8gI0qcrmbAs0WM5ZvU8ZUKqqva4ba
	 4M3SAsgY2fJ0YpGFqC67JbfYi21V+5c0oneK1c1+RdHMpiTWFHwtbvia0utDvqla+T
	 N5mjhTj490fiqEMnP9Bm5mw7X1ZMR6A7ZgjBkIQHjUqggq+dCt8CyRDixMNHw3pxwH
	 y+EIFO+j/t8YPtX2iGQF9Vs+aKGlFrL55d3IldtPP0o/MOpZ63YStm4+HhMomxY9D/
	 21lUB+gCy9n9A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 39/47] fbcon: remove consw::con_screen_pos()
Date: Mon, 22 Jan 2024 12:03:53 +0100
Message-ID: <20240122110401.7289-40-jirislaby@kernel.org>
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

fbcon_screen_pos() performs the same as the default implementation. The
only difference in the default implementation is that is considers both
vc->vc_origin and vc->vc_visible_origin. But given fbcon's softscroll
code was already removed in commit 50145474f6ef (fbcon: remove soft
scrollback code), both are always the same.

So remove fbcon_screen_pos() too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/core/fbcon.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 657160eec0a5..2166ea1a5430 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2593,11 +2593,6 @@ static void fbcon_set_palette(struct vc_data *vc, const unsigned char *table)
 	fb_set_cmap(&palette_cmap, info);
 }
 
-static u16 *fbcon_screen_pos(const struct vc_data *vc, int offset)
-{
-	return (u16 *) (vc->vc_origin + offset);
-}
-
 static unsigned long fbcon_getxy(struct vc_data *vc, unsigned long pos,
 				 int *px, int *py)
 {
@@ -3162,7 +3157,6 @@ static const struct consw fb_con = {
 	.con_font_default	= fbcon_set_def_font,
 	.con_set_palette 	= fbcon_set_palette,
 	.con_invert_region 	= fbcon_invert_region,
-	.con_screen_pos 	= fbcon_screen_pos,
 	.con_getxy 		= fbcon_getxy,
 	.con_resize             = fbcon_resize,
 	.con_debug_enter	= fbcon_debug_enter,
-- 
2.43.0


