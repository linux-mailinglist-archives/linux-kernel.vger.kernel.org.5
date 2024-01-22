Return-Path: <linux-kernel+bounces-33468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564E5836A09
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5683D1C23E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A4013175D;
	Mon, 22 Jan 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uibqolEV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5DC50A9F;
	Mon, 22 Jan 2024 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936412; cv=none; b=UCLzhpeRiB9WSmAOmuB+vdRQ+BCCm/hzbv7fuIj5sE/hycWJjEJSX/mDc3noOt6cS3FTb11NG8PaXUW6A7wX8v4U/f/PZAkow6iv/fQleRyg01h1oZNJUHKM9+ZQedV7iMBJrRkL1agi3mlU/rudcRvIFph1sqtJcRZY8uTAV5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936412; c=relaxed/simple;
	bh=r6vsfXR5p1ENL2KJ+pvplgr2k48uOHDXj1xziqkxF4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7tLIgeYTGiSLLZ1nzJ3a36HdQArMy9H8Rk82pOneaVDZKVise9e8fAhDh3pF2kUlHiZYICYBYLlEMow7dswizB7TMQS4J1W0NPUh1BpVhE4BWRksMIjQVJK7m7eKO5+/YxlIciBy0QDu+BV8uJnY8Rs6E6F0JJQ2cbQTTIThuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uibqolEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51DDC433C7;
	Mon, 22 Jan 2024 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936412;
	bh=r6vsfXR5p1ENL2KJ+pvplgr2k48uOHDXj1xziqkxF4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uibqolEVyRVDN7A3ue2YPTZR1yOjSN/gBthd4+25DAOjBbvBRGspS1t8Gh58UA4so
	 RU9v+pW01ULwt6TpBBwD050JEF+PIY5V6YDQzNH6vmgtxk9+TdJX/c0A1/vikQoNLv
	 3inVHrLatRKypaPgcRwZCs471Gf6rhVc5avby9D7rKeyyWOgWgcbR+0wx1/FSx/tW6
	 jsXk5E3kBVBcghagJEuvNW+C3Q5jKFF/lzSFpWZAxamYkbSCwEyihjwLxHLm97VCge
	 x94rXlDo2GBR2n6vZaQJPJva3rlaUbuPhsAi+I7JMgWxsHtL2kp3F3i2nKwUIFJGjs
	 FSOC8awuYrpcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 11/35] drm/framebuffer: Fix use of uninitialized variable
Date: Mon, 22 Jan 2024 10:12:08 -0500
Message-ID: <20240122151302.995456-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit f9af8f0c1dc567a5a6a6318ff324c45d80d4a60f ]

smatch reports:

drivers/gpu/drm/drm_framebuffer.c:654 drm_mode_getfb2_ioctl() error: uninitialized symbol 'ret'.

'ret' is possibly not set when there are no errors, causing the error
above. I can't say if that ever happens in real-life, but in any case I
think it is good to initialize 'ret' to 0.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231103-uninit-fixes-v2-2-c22b2444f5f5@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_framebuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 07f5abc875e9..4fd018c8235c 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -570,7 +570,7 @@ int drm_mode_getfb2_ioctl(struct drm_device *dev,
 	struct drm_mode_fb_cmd2 *r = data;
 	struct drm_framebuffer *fb;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EINVAL;
-- 
2.43.0


