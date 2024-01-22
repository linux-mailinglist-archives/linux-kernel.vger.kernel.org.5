Return-Path: <linux-kernel+bounces-33504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BE0836A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9BC1F22F32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F39013D4EF;
	Mon, 22 Jan 2024 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWbSrovi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D413F13BEA1;
	Mon, 22 Jan 2024 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936550; cv=none; b=OlUB2E/rC5j9kr/FXDEiyMtOVOD3vZ8ySrYDZap7602k3it2qFH89LVEGxC74tZ2eMVU7hNPrKHYT7uK2/ufDm1NpX+kSnVzrRGkGhZI0VyBiwobtEq+UgI7d1Ln3+OZ0hgAiGZIxUBVOe4spt9LXPcQWQMGczL0BxEE1qvi/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936550; c=relaxed/simple;
	bh=i+hZ+wrE5tGj8QwYNTNOZBpaYzTHWtqGRT3k/OGH0YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTwI/A/wf5dZbwgycpfXdUStWNHoKkaXHea7jLjphgkQ1ZC8eqoGXUEgcGipmRZO0mogzjphOFTnVW2DifeudUoe5eS0+VBLXo63bh7N4cz05aNbfK3sAbRKp5bAB8JBcYIB9jWRvk6UHaBGs4HtJSzv6oYcHEdP/3azAaFXji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWbSrovi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E685C433C7;
	Mon, 22 Jan 2024 15:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936550;
	bh=i+hZ+wrE5tGj8QwYNTNOZBpaYzTHWtqGRT3k/OGH0YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWbSroviTEfbkL3UqDZuId1/iGpNs+aKp/+5IWtrOw6eTPnYvfZNp+Btv7Lhlj2hy
	 KJ+jZmYvGgPQUwz5P8nypFmJcvtg3DFZPzo+cAL1JApYj5UuxPIT3XrdoSU7Vbz4T9
	 zoQyd0OiWw5LfoBFsPJxN+n2CeeXFTrpuYjckouBD8Pd0pD679CNodZMkoMrTepVGc
	 aZY6VT4P6gkjV8HXKMXG6JKVIEJCYOk25eP+ZSVXQb39WKVY+RzhTu8UGbgU0z7J88
	 VWRUdq9alC/5P/SMzwB6CI49O7nMzaEOu0lI/H31n94Rfml0sze6K0RrMNo5bSxQSS
	 IFWyWfVZ8KUuQ==
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
Subject: [PATCH AUTOSEL 5.10 11/28] drm/framebuffer: Fix use of uninitialized variable
Date: Mon, 22 Jan 2024 10:14:37 -0500
Message-ID: <20240122151521.996443-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 2f5b0c2bb0fe..e490ef42441f 100644
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


