Return-Path: <linux-kernel+bounces-32856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA57836130
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E817B25F86
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A27482CB;
	Mon, 22 Jan 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri2i+PdE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831F8481CF;
	Mon, 22 Jan 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921534; cv=none; b=ic9vm4HjmKfXbwu9rwY2jMSviGHm2DECka2vay1oGJat9IHUk9gJbFiDlC+UAM0jG5kbe74x8d5gk+gdGuKDXUqtqp3YaGUrz0752Xb7+pVp+C6PNHDOP9vHK6/b+vmsI3EssZQv4R2xphJgGfKaCk4ukAdUQWqA1rgdXB08JTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921534; c=relaxed/simple;
	bh=TxyfiQSfnfbUMhKRrQ0H1rTP3kUo5bAgp6fUTnxFTJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuCz/1U9by6sFWPtYVHG1WABpzELIAd1rAAnyM7EIxQpk0tq9/cG5Q3GuUUAB+kRUNWiYmyWf/Dk0PggtoEsyXGUnbY633YXrKx/jJWaJLuGm/75+ZJYIU5jnnWBqt/P3MM2Jf4e60PwbYC0qPyD2Ue4GJ9hwC1DD/HVwV952kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ri2i+PdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2D1C43399;
	Mon, 22 Jan 2024 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921534;
	bh=TxyfiQSfnfbUMhKRrQ0H1rTP3kUo5bAgp6fUTnxFTJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ri2i+PdEyuTAa48yKloQAaUEBdltv3sUW5IvQCgMHA5/PGjfEtjbCLyTeA5D9LuI/
	 yH1G9cZVHEfEI6SGU2iYZMrZxzEV9R0XdnaK9fjVRzCheDdi9FE06VhDFgjKaU8yZo
	 aMPf9qZt/S4F0J0tomif/GBJhbR/UeVG0uOXR2F5LzH780+xVi4P8AJQidfdFNIUSA
	 2bsuGom7MXXuunapSC1vOQhx0Wn4YBkDm8sIO73aWpIR01/4A+rB6hqNKrjO78Ojfx
	 VI3gGDYa7ZRwCTEoFzkvT8imwotEo0ZgLUE9ICL5topY1Fb6Ff5+0FiDPmHbAxKt/8
	 kWean2TzXr8cg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 42/47] fbcon: remove fbcon_getxy()
Date: Mon, 22 Jan 2024 12:03:56 +0100
Message-ID: <20240122110401.7289-43-jirislaby@kernel.org>
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

Again, fbcon_getxy() is the same as the default implementation since the
softscroll removal in commit 50145474f6ef (fbcon: remove soft scrollback
code). Drop that.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/core/fbcon.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 2166ea1a5430..9c2962900d13 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2593,30 +2593,6 @@ static void fbcon_set_palette(struct vc_data *vc, const unsigned char *table)
 	fb_set_cmap(&palette_cmap, info);
 }
 
-static unsigned long fbcon_getxy(struct vc_data *vc, unsigned long pos,
-				 int *px, int *py)
-{
-	unsigned long ret;
-	int x, y;
-
-	if (pos >= vc->vc_origin && pos < vc->vc_scr_end) {
-		unsigned long offset = (pos - vc->vc_origin) / 2;
-
-		x = offset % vc->vc_cols;
-		y = offset / vc->vc_cols;
-		ret = pos + (vc->vc_cols - x) * 2;
-	} else {
-		/* Should not happen */
-		x = y = 0;
-		ret = vc->vc_origin;
-	}
-	if (px)
-		*px = x;
-	if (py)
-		*py = y;
-	return ret;
-}
-
 /* As we might be inside of softback, we may work with non-contiguous buffer,
    that's why we have to use a separate routine. */
 static void fbcon_invert_region(struct vc_data *vc, u16 * p, int cnt)
@@ -3157,7 +3133,6 @@ static const struct consw fb_con = {
 	.con_font_default	= fbcon_set_def_font,
 	.con_set_palette 	= fbcon_set_palette,
 	.con_invert_region 	= fbcon_invert_region,
-	.con_getxy 		= fbcon_getxy,
 	.con_resize             = fbcon_resize,
 	.con_debug_enter	= fbcon_debug_enter,
 	.con_debug_leave	= fbcon_debug_leave,
-- 
2.43.0


