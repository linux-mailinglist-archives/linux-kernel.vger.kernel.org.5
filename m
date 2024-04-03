Return-Path: <linux-kernel+bounces-130340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE00897718
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D5AFB31E72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB3B154451;
	Wed,  3 Apr 2024 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlQixzev"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02316ABC3;
	Wed,  3 Apr 2024 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164779; cv=none; b=DKkkkGdLUqakfqrfyRVbv6lVUMdXU1GypoWfXL6gtjy67Fvhql3xT15oPvZpGcRwKVGpEfoStrCK3FGUmaRD/B7InNbxUb8PfWddDAJZxLyAG2RJ4CjznWhy5FvK32akyb5MTwhYAJqcpjcp1r/pHAFUFxlsEXg15LwfFTAR4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164779; c=relaxed/simple;
	bh=3R/oYCngnfBm8uj5KvKZdVhP62XlJbJ3bOKSaBb7XQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kqx6f8EdLd0FOoSusxJSL2wfuEkEmZ4xT3TUYRN34hFX5Hfw+BxSTgE6L2kp8tlVeKWxhMo9b5YR9F0OHUCzCST4xIsbzH4ohrROAF2yI+kM/TrM0d9weJmM8Au1CH/NdkHwGb0UFPrYbcwCvkGV3eDHf63VRB5HyGzzNIZ75TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlQixzev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C79C433F1;
	Wed,  3 Apr 2024 17:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164779;
	bh=3R/oYCngnfBm8uj5KvKZdVhP62XlJbJ3bOKSaBb7XQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BlQixzevE7Ty6J8NjQKx1cMg5eZsKe7PJCJ8ULBosh/52mWwmZD2nfhMP/Nn2GQi3
	 7WNxCi+guJwElUOcGXJx6UtXTfliUB1f1CKfLFiLKsJe05bU7+h/wXbd4Wm58MO86r
	 L+TN3AuAJMSMHm5VMgV9fbRoy2fZq0bCGtntJD9Jnuv7GXbKKIS/XWW3av7Po0Wv/2
	 vND7aktX3m++FeSdyIhLy9mawI4/mc0dQE4uMSslu8wZkrDhkhNbd8qIEcijGDoVLH
	 mtnb6VUzA4pMh7iTCzDzRr7xHmrw/pZD2Dn+mRl8wLa3f1FahBY5FH9/GsER36lRfg
	 f9H30JdybstQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	daniel@ffwll.ch,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 15/15] fbmon: prevent division by zero in fb_videomode_from_videomode()
Date: Wed,  3 Apr 2024 13:18:59 -0400
Message-ID: <20240403171909.345570-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171909.345570-1-sashal@kernel.org>
References: <20240403171909.345570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
Content-Transfer-Encoding: 8bit

From: Roman Smirnov <r.smirnov@omp.ru>

[ Upstream commit c2d953276b8b27459baed1277a4fdd5dd9bd4126 ]

The expression htotal * vtotal can have a zero value on
overflow. It is necessary to prevent division by zero like in
fb_var_to_videomode().

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbmon.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index b0e690f41025a..9ca99da3a56a0 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1311,7 +1311,7 @@ int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var, struct fb_inf
 int fb_videomode_from_videomode(const struct videomode *vm,
 				struct fb_videomode *fbmode)
 {
-	unsigned int htotal, vtotal;
+	unsigned int htotal, vtotal, total;
 
 	fbmode->xres = vm->hactive;
 	fbmode->left_margin = vm->hback_porch;
@@ -1344,8 +1344,9 @@ int fb_videomode_from_videomode(const struct videomode *vm,
 	vtotal = vm->vactive + vm->vfront_porch + vm->vback_porch +
 		 vm->vsync_len;
 	/* prevent division by zero */
-	if (htotal && vtotal) {
-		fbmode->refresh = vm->pixelclock / (htotal * vtotal);
+	total = htotal * vtotal;
+	if (total) {
+		fbmode->refresh = vm->pixelclock / total;
 	/* a mode must have htotal and vtotal != 0 or it is invalid */
 	} else {
 		fbmode->refresh = 0;
-- 
2.43.0


