Return-Path: <linux-kernel+bounces-33531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74865836AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78B61C22291
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1884E1474DB;
	Mon, 22 Jan 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZTo+qaN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCBF1482F0;
	Mon, 22 Jan 2024 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936639; cv=none; b=fJV4GPjQHY9dZnnLzQak+WrQ78K8tJsZcnLKuLWkRw93NV5xtDHKsFtTmFayjfO0zl9vcrN33HnsMUR/H7geRKWPowMLehvZeoWmRrxFJMHhkanJbS9DXqd6PNAzdrw3eqlaGjOfvXq896fReA+ODd9onfL6IU/NElhEUGHgX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936639; c=relaxed/simple;
	bh=/4gtotjwXX/OM490ZBA8EUHzvKc/zyuqzDmHJOrDef4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jO7Jl2eDeECgvvAG6lGC5Az/GYp7ZnWGIFMfGjsDteltLNcv/PGrUzMwl0oVh6OhLcq2dGV1SsK/laJ35rWgcut13xC27NoUTulrsz9BktgruOvpCkifISCkVRJroE4P34BYqUcSomyC4tONVYbkkNF/CdBLqGtXpXUh1TIvj7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZTo+qaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEBEC433B2;
	Mon, 22 Jan 2024 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936638;
	bh=/4gtotjwXX/OM490ZBA8EUHzvKc/zyuqzDmHJOrDef4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZTo+qaN2BM2pDUn9/YmtptCBuI/JS1rgAEEQWRcBlUSimRKE0BgxiH4sDAEkcjb5
	 qRhMyWgGq7n9iuNmj/GXgv0bCpv3KNAhDgy807dCWkL8bEtg40/yGRIRK9M6jmw/TB
	 IEzyejHgscx6sA/ywbX85DR7Xnx/Ux3+org4C40282iP8jJT6eYJgE2X7BNXcA14PF
	 20ulgPZn4X4Ibdx7vAahrMTsnHkt7VRdwZdu+Wd2G0GJymgijrd8OP2qo4nzsik/hj
	 d42Q84ImhF/ME8W9MpLUiCXEzi4rH2FYokANb1EBtki9oYYyRp3jCBYijdrqDhqpas
	 Kwk7wZLiDUDFQ==
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
Subject: [PATCH AUTOSEL 5.4 08/24] drm/framebuffer: Fix use of uninitialized variable
Date: Mon, 22 Jan 2024 10:16:22 -0500
Message-ID: <20240122151659.997085-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151659.997085-1-sashal@kernel.org>
References: <20240122151659.997085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index 57564318ceea..e85fbbbc07f8 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -580,7 +580,7 @@ int drm_mode_dirtyfb_ioctl(struct drm_device *dev,
 	struct drm_framebuffer *fb;
 	unsigned flags;
 	int num_clips;
-	int ret;
+	int ret = 0;
 
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EOPNOTSUPP;
-- 
2.43.0


