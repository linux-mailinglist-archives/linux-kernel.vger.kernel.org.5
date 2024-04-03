Return-Path: <linux-kernel+bounces-130368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCA2897738
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B476528DAB8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0DD16FF3C;
	Wed,  3 Apr 2024 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1bLCtQF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C516FF29;
	Wed,  3 Apr 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164849; cv=none; b=OHcsuFihWV3PaVUn3ppSwIu35KdR9e0MnljP5bSR3q5Ci62nO2TJ4cKbTHFk1bCpzZuD6zztqJHA7iHzdBH2V/CtNLblB6m7uBPpaxU0wah2AqciUShqpMO71i7hd4YFybOMLB7DWDdL7NxJJOyzYSMP/c9JSuKL0hmvffj6ab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164849; c=relaxed/simple;
	bh=OVKcgb9zjiNlhCzNE3c8lkJ7toq0usAeeT9Ux2Oi8ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yz4aFGfCv/Ll5+mDJo1+/iCq4au1QA7dIcbXv7LdKY006b9egcv/VqCEmKMvm56LvmRzYk15zFfRpp0U+WvqyQ79O/b/aGUA6tpPC87vP/MwbXOFktvoB+f3YnCv4Mabqm4Mzkq0Y6QtZdQ4lJyvu2zCrNU5/0ozpK0wqh8ZV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1bLCtQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B155C433F1;
	Wed,  3 Apr 2024 17:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164849;
	bh=OVKcgb9zjiNlhCzNE3c8lkJ7toq0usAeeT9Ux2Oi8ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1bLCtQFl0XnQ/G+RX+NcXYdgVjh18yKaP58T3rMHYaAzuiB/r9xErQJiHI3GOHlq
	 JsNMOlq7ymrXUvWT6UJCrwabuxrlcFHpjrA+68GuCfPeK2cFGjRMFTAk/S9kCQiNTp
	 GryBhu239XRuzXTSAkBn0lYUmiSz2bvM279kJJ9BecvN76qwGV0VYLfNyqnaYmAUlN
	 539MM/kFWpDGW7M1lAe8CHlSL0NgUavUVZqkMRa6j6Vs1YB5iM/Pqb8W4il7FKbQnt
	 FZE3b7+XRrjlzpUyMBJKCVWsp5XR20dU5dhgrzaJjj17Rach70OpnGXA9NFxrPg4Bc
	 /wVJB3txzKuew==
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
Subject: [PATCH AUTOSEL 4.19 5/5] fbmon: prevent division by zero in fb_videomode_from_videomode()
Date: Wed,  3 Apr 2024 13:20:38 -0400
Message-ID: <20240403172041.354877-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403172041.354877-1-sashal@kernel.org>
References: <20240403172041.354877-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
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
index 8607439d69328..e4040fb860bbc 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1309,7 +1309,7 @@ int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var, struct fb_inf
 int fb_videomode_from_videomode(const struct videomode *vm,
 				struct fb_videomode *fbmode)
 {
-	unsigned int htotal, vtotal;
+	unsigned int htotal, vtotal, total;
 
 	fbmode->xres = vm->hactive;
 	fbmode->left_margin = vm->hback_porch;
@@ -1342,8 +1342,9 @@ int fb_videomode_from_videomode(const struct videomode *vm,
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


