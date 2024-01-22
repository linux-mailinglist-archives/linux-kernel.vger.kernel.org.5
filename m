Return-Path: <linux-kernel+bounces-33555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3814836B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF401F25504
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFF014FD0E;
	Mon, 22 Jan 2024 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWUCWLNC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CC714FD01;
	Mon, 22 Jan 2024 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936719; cv=none; b=eGAo8NXbELBy0aQ3oMypMGNqEeR3oBJ6aLY4scCN+8RwOFnOajv0iuRakBxdnJGNjM6fEdT/nKmPCoRWDjjMKLFr1xqU6iFe6NJVMXQ0OKkmnmaoLHpxw/NlZW2ln8DND0b1EnwLNUk0TU8kJ9sIQ9G7iSvrSaumaxgIgR2ehPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936719; c=relaxed/simple;
	bh=HdXz9ZSHSHAv2wETRj/URGKhnJ4QGa4049mSpdOqN3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkqhRVAAb1Is6MincBDxcjhQci5CEbesbfSgLo7qb2Qf7dX9oNIuLsQi4LdPfk4QlvhVm4zJqyBSelyII6WYgT4xa5H7SKEOYsCVVISW2vICiiTgEd0HiXeBwMjEG8d8fqqjGKa1fl2mc1AmJ/Q4dV2bHsd+RHlVWsCoGbKCKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWUCWLNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E50AC433A6;
	Mon, 22 Jan 2024 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936719;
	bh=HdXz9ZSHSHAv2wETRj/URGKhnJ4QGa4049mSpdOqN3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWUCWLNCypRggI822yrjrAOgqz+4KhQOGhvtrHbyzXABwjMXoYPuNyyh2yUWYhIuE
	 981w+oO4ZQ2mSur4ivd2L0+U+pYIKypptFoFWFNZYROqI2NtN/kGf3oEPiLMUArskL
	 nc7m1KYfwk+zKR3Ihbmc/EMlRvvQadk4JNPxoNKfs5PySW4C1ChfbDd8NEcjwZZn3A
	 FZQcFpdUMa/srlmlM25kZnnF7ORF1AiQ02zDl1tVNuEVoC++D82tqWvQesFI/hIqO5
	 cLCsxf4z2Fvqc7dE4QEy3ZFFK7NeXbDWETf38hCMT5jLz4Dq0HEfslT6x0HLoxq4JO
	 znmjP4092xUfw==
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
Subject: [PATCH AUTOSEL 4.19 07/23] drm/framebuffer: Fix use of uninitialized variable
Date: Mon, 22 Jan 2024 10:17:47 -0500
Message-ID: <20240122151823.997644-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151823.997644-1-sashal@kernel.org>
References: <20240122151823.997644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index b64a6ffc0aed..9fc4af4b10a6 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -538,7 +538,7 @@ int drm_mode_dirtyfb_ioctl(struct drm_device *dev,
 	struct drm_framebuffer *fb;
 	unsigned flags;
 	int num_clips;
-	int ret;
+	int ret = 0;
 
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EINVAL;
-- 
2.43.0


