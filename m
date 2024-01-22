Return-Path: <linux-kernel+bounces-33417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBB983696E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF211C20F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4939811F9;
	Mon, 22 Jan 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga12oVMD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3134E811EF;
	Mon, 22 Jan 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936238; cv=none; b=Hl3Sgde4Bvh4AJIGbzYB+HDZ+cLaBOwCP7WLUDCyNIZAL6EUbn0o9Y6U12MukDAKCIXsR1pVELxvVVU0uR1t7JL7acIMVPRA7nJkQo/eJJe6/XoAIlKz2ciJf4AtWAJQAknC16tMoHI6E7TD66iS+yCOi9EngQptgXqEPG+zJ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936238; c=relaxed/simple;
	bh=h4QL/XZn0tvDjIA14okac6PGT1PPL2ch0Tx+IcBTM00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESewusrnJ9eA3Ehjsn6Qb7p0u52vvdZInkd3ZLVt2p7feHg6NoWlRDj3J88YxNz9D57lWuPCz3gENw0XDDjg6nNW0o8fum3SgpxP0ldF1DjkXwm7qckjxCo6emJl3NcPkYmoTetKiE97Ea/A0YCqUFtDTeF6pclkFawlhOIaD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga12oVMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7BDC433C7;
	Mon, 22 Jan 2024 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936238;
	bh=h4QL/XZn0tvDjIA14okac6PGT1PPL2ch0Tx+IcBTM00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ga12oVMDBqkjGmJzcyjNNE/ijGAQpT2IXGXwv6lBsc+ZeT5z31VJtaI28hrgDVcuu
	 CzmSK8SiYlDX83g9M9Q1cAZGC5wMLxd9Wr/7tkfYFGdiWouiAq6UmYlwKnPHRXp1E0
	 MnDgG6BhdPihNu+5i0uKh1TRqMfy8WGvniu0JK5qXGjNbyDVMZmubaIQqiwCcBw3rF
	 QFvPiaGx3UVjDL7mwoqcOqC16DVVwQ2dG05rNp8O4KXzcYAK8m32VqM2CEoZq/ik04
	 gGWMV3502iQpqYgJqZ0piQWS1XP0ajys0ffLwEkPhT68qxibESq1cyMIHjo+muIeN5
	 b/1yZAJbimalw==
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
Subject: [PATCH AUTOSEL 6.1 17/53] drm/framebuffer: Fix use of uninitialized variable
Date: Mon, 22 Jan 2024 10:08:18 -0500
Message-ID: <20240122150949.994249-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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
index 2dd97473ca10..72ad1715f8e7 100644
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


