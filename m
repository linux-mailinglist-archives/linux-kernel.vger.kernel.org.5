Return-Path: <linux-kernel+bounces-130322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C92608976C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C1F292E80
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8715EFA5;
	Wed,  3 Apr 2024 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdZjgRy/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57F15ECF6;
	Wed,  3 Apr 2024 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164729; cv=none; b=o2EQuy1F+mHGsN90HFJY+901sByrjrOWiAW88hV5o7DJ4nsqWgIyEYB8C8c2Bhp/pHv+e+UvD1YYLCdWpaeUMZOB/XatjPPT5AJE8FyCrXIIZ54dJPMZ+sGuFBeMqf3DefPX8TA7Tk/s1v0N2nO6xraoIFIRrq0Ke46GGugn2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164729; c=relaxed/simple;
	bh=hpvSuFBNptZidQwfefjWF5ZfybfxvIK+yhTcUOeTRwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNLAZKOcRMNHXNqxSi4oMKfy908Cq9ud8xCh4olPBZys8uO8aOc2LV9BygFon8YWbrbqTZgG3pZjnGLoMWDrA8hof0J6Yz+PEBA1v/tC65WaeGkI2HDVnmrKy4ZnYTuZUD2rAPq+ghkDGmAf1yDXIcTWuEMKtI3pE5qcM059lAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdZjgRy/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614D4C433F1;
	Wed,  3 Apr 2024 17:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164729;
	bh=hpvSuFBNptZidQwfefjWF5ZfybfxvIK+yhTcUOeTRwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IdZjgRy/yDL5Fg8mjUQ+JtO/sPj393rMjaCd6SusS2PTlwUCW1K3fz+IsO675HsFl
	 W+/5b4GLEyVANIT0msfx4QVGOvgmRE6ZP1QucP6GGBX8zWSdRUIk0QyHrMdzOJFbEu
	 /hdQ6RMHJitOyA7zio84njxs2ks87oqFf+vN5jEh5mTGGwMxCwFFyscw9295i011uW
	 wuKnCNa1oIrK/QYLrfUNc14awdnwkQLPirtf0XSz1OogyiG1wtUnwcuk+PdGH+s+TB
	 aQJE6TXDDawyfpazqgvphted0rK60Bq6W1LL9pBWKawLQwFpbMg92znhIsoaJ0Jey+
	 WExEWalwhKqVg==
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
Subject: [PATCH AUTOSEL 6.6 18/20] fbmon: prevent division by zero in fb_videomode_from_videomode()
Date: Wed,  3 Apr 2024 13:17:59 -0400
Message-ID: <20240403171815.342668-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171815.342668-1-sashal@kernel.org>
References: <20240403171815.342668-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.24
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
index 79e5bfbdd34c2..0a26399dbc899 100644
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


