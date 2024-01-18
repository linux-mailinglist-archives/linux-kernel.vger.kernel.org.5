Return-Path: <linux-kernel+bounces-29824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C56A683141A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC99B25B81
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4544D31A81;
	Thu, 18 Jan 2024 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK+FEF6c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7D3175F;
	Thu, 18 Jan 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564765; cv=none; b=DmmErLgYz/UnMf4a3V+rs0Zfqm56xpoHGXEflI94U7h+5p9a5m9sdzNhfA1630aFQPFV9NdIVZ9oPWSzTSzwP04M1IGZQ4CmUxR5zEx2VsqLGmalfHPv8wjt6CbCdr4JymbpuKU44V8xvFT4kO3kVV1oeLbgQXffdrPoWUqbUj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564765; c=relaxed/simple;
	bh=GuttBthplzcWAD92DYxHAXefieOSH/0KZn+o6peTBWY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=mEkngoU3cYmiWnwij/X9XI7LM0lKlNlYezAh+L5/MHcHzCj34cxIl/fWMmzPulAS1pCk1t6d5AHH9GUToc3sMtHvdeEpwjznYReDJFLuQPX5e4WYCzvBELxsaXepIoBGkLzbGl6WjigS52nIcV4AurUbwDjRlpBfvtvX3zQpgiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK+FEF6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604ADC433C7;
	Thu, 18 Jan 2024 07:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564765;
	bh=GuttBthplzcWAD92DYxHAXefieOSH/0KZn+o6peTBWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jK+FEF6cWzI+fO9Fnk6BTANz83FQ+Lf1d+PsJX7UgvaZ3SD0ojQzqBSQUAT0/ca6V
	 Y74TcR+ajAzxBP+CHyJf5GIpa9w6z6aLiowoJ4h0OiNZ5YLqLYiTaf20qygE60FF2e
	 zQ7thTa4t7woijOADtWIoBemY1RBlSKro8h/aNmGhYzubDfgWf3VoNwdxIdB6+TbU1
	 CFQHvk5E6jfSXOeGV3Thu6bwPJbURfO657v2/3kfXKyKWqS9m4bA5F9iQYRBM68YR8
	 tWk0jTTDeyqpvaaMIptgZrva5raYWF4rBZOCHDGJsZoW6VNoRuSpOrRKm5HZ+6rS9C
	 9X1GNlPY2Opww==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 37/45] fbcon: remove consw::con_screen_pos()
Date: Thu, 18 Jan 2024 08:57:48 +0100
Message-ID: <20240118075756.10541-38-jirislaby@kernel.org>
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


