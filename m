Return-Path: <linux-kernel+bounces-120074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DDE88D13C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BBD1C3DD81
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3871D13E04A;
	Tue, 26 Mar 2024 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/LUR/oq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C8513E036;
	Tue, 26 Mar 2024 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492732; cv=none; b=oG+JQAi0bhdPJ2GP3XBJtliQsksNKRuAvXP9xdErTvbPZ3LgXmyrtI4CrBydmwRVhLLx/+lQ6E79CzTzkNRKL70XBHFqtzupAfYEpLFYivbzM45uMIwNqChA2n2C42R9L3oCZ05YdTtIqAanOUw7+LvlgLvVE/1Chm+7P4qJcgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492732; c=relaxed/simple;
	bh=4nCC9JNEj51O9TISVBwQcV6lR14jShr/2PiFrxb4DMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Swv6qZiHkC65EjdYJJuma0hmDwwM2bnW/qKjvpsHWU8i9/tkc4a/E3hPTXW15c+7Qv3d7x0yAkfw3XSXGTaIvTIwnonG6uz41vyfOaWk2RLlCoA3uaiycf9TO95EmwU3zaMBjRpKE7hjyHYz/Z5BTQgjNmm49Xg8DTJIyFb2QIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/LUR/oq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47888C43141;
	Tue, 26 Mar 2024 22:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711492731;
	bh=4nCC9JNEj51O9TISVBwQcV6lR14jShr/2PiFrxb4DMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k/LUR/oqbtEkuUoncQuFcPdUw5/uxbCSh0bFFQnRKFjigKDiszTEbBDb+qjLiZXXp
	 2SwD3bE1AvuzrVMBo2KWNyixEB9LpC/El3pI5AU0Gni7TaYhbmbkpPK3ilagc692dK
	 i6EI0Zs+1acBigkxU+CS/RAg+An/og+Hcl5bpq8Z01Qzy8xFI3c/tLRuUcwSICwWK/
	 +6Rkfp8kFmUSJSQjg6xnx123kva6GTdzpJnGOrpu7mC3Ub9DKIO9YOnVFz6ElxnQJb
	 a6DOD91Va4VJijxQ/SBALRYhysYeYYZ7X5QeDgscMrS/Exg1a4vXEVYXtpscmsm4+X
	 d5mED56x4rujw==
From: Arnd Bergmann <arnd@kernel.org>
To: llvm@lists.linux.dev,
	Helge Deller <deller@gmx.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] fbdev: shmobile: fix snprintf truncation
Date: Tue, 26 Mar 2024 23:38:00 +0100
Message-Id: <20240326223825.4084412-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326223825.4084412-1-arnd@kernel.org>
References: <20240326223825.4084412-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The name of the overlay does not fit into the fixed-length field:

drivers/video/fbdev/sh_mobile_lcdcfb.c:1577:2: error: 'snprintf' will always be truncated; specified size is 16, but format string expands to at least 25

Make it short enough by changing the string.

Fixes: c5deac3c9b22 ("fbdev: sh_mobile_lcdc: Implement overlays support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index eb2297b37504..d35d2cf99998 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1575,7 +1575,7 @@ sh_mobile_lcdc_overlay_fb_init(struct sh_mobile_lcdc_overlay *ovl)
 	 */
 	info->fix = sh_mobile_lcdc_overlay_fix;
 	snprintf(info->fix.id, sizeof(info->fix.id),
-		 "SH Mobile LCDC Overlay %u", ovl->index);
+		 "SHMobile ovl %u", ovl->index);
 	info->fix.smem_start = ovl->dma_handle;
 	info->fix.smem_len = ovl->fb_size;
 	info->fix.line_length = ovl->pitch;
-- 
2.39.2


