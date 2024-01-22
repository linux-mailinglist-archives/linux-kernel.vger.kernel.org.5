Return-Path: <linux-kernel+bounces-33341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949D483688C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C614E1C23B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8D6633E7;
	Mon, 22 Jan 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw2Beozq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C9263134;
	Mon, 22 Jan 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935932; cv=none; b=MZ/nefuvF40O2gJVqwK6a64nvCjHDPa6kysHWiQpR6Ic6k/mkxziduLBX+11aKo33eoPUL7ljgzwlk1w9ZuiWtPbXQmipNobkvPgVTFSyWz9naG3EXaMZAB5EUj8gTb8YISif4kZrlEpZPFYnmJla3IuINtUYUepL8gPZBSGeJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935932; c=relaxed/simple;
	bh=LvbTF2FPVsG1VC5whCyaKO3erI9yAIOQKDXJy016miQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5jXnONTQzZ65Oa5DMZ4bV5MsvY2Nxa9NDiFHeFU1/CB9XTPjBkOA+xDofCgW4G/HADg64uwTi8ZHO/P0ywuoyyJC2unjq7cIFTuxYFgANu7xtyFY2Deqsr+KoN32Lzx3ELblISpK4fIUtTXHG7WMtcDNL+BJtDt8UhwWsV1jwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qw2Beozq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E51C43390;
	Mon, 22 Jan 2024 15:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935932;
	bh=LvbTF2FPVsG1VC5whCyaKO3erI9yAIOQKDXJy016miQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qw2Beozq8ILk2PsGlESqJ93Z+egIppaV5edscxZXXanXH5kdCYQjZvtdo1IimzKJd
	 iJfbseeWXlhOMRnwJRMXCj7+LXfg25yUQyrY8SmcXPk8iAdGELuP59DWwo+1VD/Tz4
	 fC/DGaIzQm64/nOuqq1i2PeDH58zvxJEGtFstuw2Bv5Oh16XLnavil9vmGEfDIz9rN
	 7lfrE2hLdbA03y/l2v/WZjLdoS1craR5xe3vOJbuIsJZ6dZy/4VGaopVWrXGcoMijd
	 qfIRqXO+2vN94yk1l2vH5kzhSZjSNNACofY4wciamhYyupJSJWikpIivxF8N/JyJ7j
	 pz9IOgBKemLGw==
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
Subject: [PATCH AUTOSEL 6.6 19/73] drm/framebuffer: Fix use of uninitialized variable
Date: Mon, 22 Jan 2024 10:01:33 -0500
Message-ID: <20240122150432.992458-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index aff3746dedfb..1955eaeba0ab 100644
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


