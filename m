Return-Path: <linux-kernel+bounces-130363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0B2897782
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CADFCB29AA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E916F294;
	Wed,  3 Apr 2024 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+O21fnJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF5916F287;
	Wed,  3 Apr 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164836; cv=none; b=dPDipc96Uk/+gglf8nYMbuafPECIhzDf4juHillXG/DSftPDdnlufcjZ1vfkD3ARcSL10ivvJqvT5vcuNXiduX/tRtHNcYSNUWeQ8NwpOQAUgHNZV91e+pWS69IRMx4O0mqjPwV1ncNfXIdC8Ypvchx0clL3HtU/m2OoGcM3Tq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164836; c=relaxed/simple;
	bh=C3P9Vy7HFpd4+Ad7XFX1+eAGYT/rSlErX4+p5PG0MSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebWqG+a+eD8jL+zdiJEjCNMktHHUNrSCCNlUCFLe+PSSP8LEKZK1mVlgyd2/KxTQSaQNyBJb7ep3TXgqdKxJfB2t0D9y9t/GnGKOtsTAH+9Ka5eQVQ3aRCZmxqbTSIjGGEwXwEc3p2bNfcO4ra+J6Mm3iPLd003nBQ4Y24r7tGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+O21fnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6906BC43390;
	Wed,  3 Apr 2024 17:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164836;
	bh=C3P9Vy7HFpd4+Ad7XFX1+eAGYT/rSlErX4+p5PG0MSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+O21fnJLUepNnayolnb/GhYNjSeOewd2eZ9Qk0K48KUKRlXEMdQ+OH3tT1yIZiHK
	 CmpfFv1C9bWIeZoaRSPERLFKUfHMgZh/02rU1R4h0ZcFZiqaabtuWwaekTbQgAYBXY
	 UVPPGfwEqlHEFeUkoB2S7f8dVJ3O54kyaTG4qdmDWNEwWK8v3/6puY92PBX6C0Csio
	 4/DjdVagxFX46Bk7xHFuKgeIp4M3zAIp4culGZD7qnAhT5ZBJj3FRtD5B5jV2o/ZCX
	 B3wqePjdEjzE97PllJRuUggqpifCZm2bEJcJfsBnoY/WOlofh1WA5N6O8Wd8SC07Kx
	 BaobqTbRWXomw==
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
Subject: [PATCH AUTOSEL 5.4 6/6] fbmon: prevent division by zero in fb_videomode_from_videomode()
Date: Wed,  3 Apr 2024 13:20:22 -0400
Message-ID: <20240403172026.353926-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403172026.353926-1-sashal@kernel.org>
References: <20240403172026.353926-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index 8e2e19f3bf441..dab5fdeafa97d 100644
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


