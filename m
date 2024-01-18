Return-Path: <linux-kernel+bounces-29827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27664831421
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F48F1C228EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C95B32C94;
	Thu, 18 Jan 2024 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ls3qFhFQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9E328D8;
	Thu, 18 Jan 2024 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564771; cv=none; b=d4ahxnDCPU57tDa3OVX/6xtwws6PIw23rtg896A3BimupFDe/X4S0dfu5jRmlNS070lm7pORb5Vbt5rOcDBPpn3yWuDM5GEIYbYbKL5Ff9vC/Yah3Vhk4d2j3MVK+2RZK/eyFg7tnXFw5fZU4OKARj2bapbS8WkNTleLFupmJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564771; c=relaxed/simple;
	bh=TxyfiQSfnfbUMhKRrQ0H1rTP3kUo5bAgp6fUTnxFTJs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=bHw8UnXbq4V4HrBgb58ax3KT7GaOG1sXsYONA+ALzS3UyXSYyZoytch3fmyHucgCs/VwpIkab+XnnDjfaikOT9+9FfnKO5umf5cATf5t4SY5VIO/JQKPSXweaQwNEctcvs9woqeollObZdzg0r6PrHZZVnk3feKnNYtdp6jmGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ls3qFhFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FF8C433F1;
	Thu, 18 Jan 2024 07:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564771;
	bh=TxyfiQSfnfbUMhKRrQ0H1rTP3kUo5bAgp6fUTnxFTJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ls3qFhFQJLk9RLW/rjJ1Jett3RJ2P/AFQ7Df/lDXsXPvS1FzS26Z7HI/QewF2b+/U
	 Mz4Eb1WyZd91E07cU+rSVgy4EPOU6Zhb2nsAQh+p6lVxyOYtTjSlFHulF7f3DxuIJ2
	 harnNn3m0oAUYTpiCu4KOWWtCq7DTPSGupGYPrNlybSuNWeqYSXIYkK0EfCMSfmBxr
	 aOSsYKFA9BOJGvKUFBZS0d5yOFJb+2FFk3jSrILvO7bXc64tpqgkrwASSNl/HImMdt
	 tlvamhci8HICutVrmQw9zyHDGzXueJkb5qtFoTstxUeNb7BhOJOAuZe1o+A5pU/HU0
	 9XwFxrpzYlKPg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 40/45] fbcon: remove fbcon_getxy()
Date: Thu, 18 Jan 2024 08:57:51 +0100
Message-ID: <20240118075756.10541-41-jirislaby@kernel.org>
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


