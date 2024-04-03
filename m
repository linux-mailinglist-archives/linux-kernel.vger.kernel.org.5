Return-Path: <linux-kernel+bounces-130348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FFF897709
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184661F2C1FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FC216D303;
	Wed,  3 Apr 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G85DY4fx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9716C857;
	Wed,  3 Apr 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164800; cv=none; b=POVX+ctzr63glvEp8opddjk5GReqYloJf818+KEKuCL2Q5zFt+tgTYVnnx6XWZTk1c+EMxuiyPgaUwj3CIosIAww6UOzQzKlrQDZ9MysOZOdBGpKCWur84Lmgz2wfivAOu4UOiJ0Hz5jAVdFG2m9tlFvV5hXRFbxcrdL8A3TlMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164800; c=relaxed/simple;
	bh=3R/oYCngnfBm8uj5KvKZdVhP62XlJbJ3bOKSaBb7XQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lR26KLDKrzau7JDJd40dvU1NR/C2SZtVFuvibrXPa05etztmFcWn38nXYEeGAcfX/akUvWwPXYglJHCW6GdYH+8caetQj4NTiKgXVmHMlK8cO9Ee/qZRdHA/y3cyPTC60scSP9T+ROdIkbIha5aT7lstbEppLjEkonq7XkRssIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G85DY4fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51D6C43390;
	Wed,  3 Apr 2024 17:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164799;
	bh=3R/oYCngnfBm8uj5KvKZdVhP62XlJbJ3bOKSaBb7XQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G85DY4fxTerc+Lcygm+DlD3x1/JQqpbcQkn8H217N1M8zbvirgHxittpRrDdFdyvQ
	 DJ/iDNcHqVQmm5hT15POIlfMQOgWfko5IAJ+e36m5tkYOmX8q8JHnyfQmms68pOmHL
	 Z/fLHM9C186FDscG2jyHCRsm3lvHkLJ8q43pucWtOT9ZRv9uic+0kOh7pQUH9ffhl5
	 kmSlrmb8/k1hSlpYnzdbZzy/De+iURKMJAKCgMAjyvYZ/g3o2mTcEDv6I84lNE+0cH
	 9YNDWX+qGqqf6BhJ7IESjiVNUU0odrXgly8uXiCkTg8XEBAGk1KLfz+gC6WlhAfgVi
	 +cGL6jigWo9DA==
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
Subject: [PATCH AUTOSEL 5.15 8/8] fbmon: prevent division by zero in fb_videomode_from_videomode()
Date: Wed,  3 Apr 2024 13:19:41 -0400
Message-ID: <20240403171945.350716-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171945.350716-1-sashal@kernel.org>
References: <20240403171945.350716-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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


