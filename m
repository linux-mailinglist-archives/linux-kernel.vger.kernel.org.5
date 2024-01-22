Return-Path: <linux-kernel+bounces-33243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699CC83671C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B0028C7A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279E74EB34;
	Mon, 22 Jan 2024 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5ePD5R8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C54EB20;
	Mon, 22 Jan 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935479; cv=none; b=kjIOdgAeflhRSfOAqVgT0V6oyFUsjkWll4+XPnMOuXZcEu3z0Ma/QsdWjBY53zKXHYcX7VTbrkR0RHBqy1gVV88RK3pixGLuxykAwunJCysyD0KKMGDVokqpGpCVZiFWgR35zR1XOI3akt2h1Irby+t2plQ9AcGCDSN1SRLdwWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935479; c=relaxed/simple;
	bh=qrdH69aqO+Jo+vFK63ohsopID6bn8jCDdi6976TOWAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZRreDfa0vZ2Dlnz99yjOYJTkvcl0FkVPwuRa85VAS9SHvk6B5pe1EoVB7IgTXBOhUH5VCrFhzdqk9Ii0dCL5yVlvkHo9MUNG3oeeD+pUtYqlNr4c89wM29GpMioHfCn7ApQzH2Vu1jtvGeHvL0zsos0uN34hG6gm+Ocn25rN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5ePD5R8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7DAC43390;
	Mon, 22 Jan 2024 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935479;
	bh=qrdH69aqO+Jo+vFK63ohsopID6bn8jCDdi6976TOWAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5ePD5R8kJUCSASmwEYeXCThJ/Xyp/PBcicgFrFcc2qocddEiyhU2Xq7QOs5sIO2e
	 g/bjePrUQlT4ttczqgbSHwwuD1MVwSrsDyTlULZ4ThySs21zh61mMcQ8KXX5+kiT6C
	 MElFJw4RFbP207JRESS0jdCFJJyEEzk7IpwQCE3bEAXlRAsDglzNLzZJ3nrNJlTSwe
	 YggYsj9TrSDzuO0K1QbFYsxVR0kwsZwmvrrE5/o8eMEKDjVlteuZ/Wb/QQNr688s5/
	 YsFV7PuPPSYchuLbD2gIJ8nHc5Dxdddgz8+FcQkmp3ktyieCFJERH3AzAWrFwX76dr
	 nw9BAonuxAA1w==
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
Subject: [PATCH AUTOSEL 6.7 25/88] drm/framebuffer: Fix use of uninitialized variable
Date: Mon, 22 Jan 2024 09:50:58 -0500
Message-ID: <20240122145608.990137-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index d3ba0698b84b..36c5629af7d8 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -552,7 +552,7 @@ int drm_mode_getfb2_ioctl(struct drm_device *dev,
 	struct drm_mode_fb_cmd2 *r = data;
 	struct drm_framebuffer *fb;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EINVAL;
-- 
2.43.0


