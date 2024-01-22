Return-Path: <linux-kernel+bounces-33416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9410683696B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D89A288127
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE1A8004F;
	Mon, 22 Jan 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmODezN3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F680055;
	Mon, 22 Jan 2024 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936236; cv=none; b=tmnx81vREbxTFa7M87qeUZztJFjdPn1rkkXs3yQRNzRGS8R3Tnq/18nEenxj3tu7+7MueG6/B6Tt8bkkCM3EirEVHxfwjOH2FkzsKqdJqxzqKPuh9Gnvp9iKV70Mo4MuAeGSN3w/04mxLWOthFCoNH89ygSI4/FyIepiRYWDvkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936236; c=relaxed/simple;
	bh=1zpAfZk3SCNEr2pRRMXhd55UiGljAWLXSiDu3R3vtHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJGY38FJZxivBeQjiwzhFJYORGrByozjUMFT0CuxIWzGz7ELA1yxX/244sti981Ig8jFEtAPwZxqv0NuFSd7Gc1Bt2zrWcw3wUk1QoK4gTdUz/4OHT8CtTlQ9fSnBJ1aL/rLcMTM0C43yucRYnRhvN9SBFYlcCUClVf+M7nLWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmODezN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0017AC43390;
	Mon, 22 Jan 2024 15:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936236;
	bh=1zpAfZk3SCNEr2pRRMXhd55UiGljAWLXSiDu3R3vtHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmODezN3e32Y5IBOr/ugg0wH3Tc1KqqAjvm+INtpu0oDoxzI58kO57Ek7vIoImR6j
	 eZv7gf8uDGAjk7o+BXGSXYvi1aUVUBK8qrH8PufSL5+BQJB8p9ejWomp/8lYW0IBex
	 x4Dr1itHdBjZBeedilmpjBggN+LdeFL70li//wJqg7lSmBQhPrzk21vLSoG/fVtKsT
	 ggJP/4J4guTsqvGBhH/tAqaEcS+8+k0zd/4RRBn9gp9T1qk7mbABJgqKz5iKxKWgeN
	 46m72fNUTB2tAIMenHLI6MyZXfDJAs/OvhrH6h/BMsktYOOJWOXuq42qiczIvkXog8
	 v+HfgcO0KxvCg==
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
Subject: [PATCH AUTOSEL 6.1 16/53] drm/drm_file: fix use of uninitialized variable
Date: Mon, 22 Jan 2024 10:08:17 -0500
Message-ID: <20240122150949.994249-16-sashal@kernel.org>
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

[ Upstream commit 1d3062fad9c7313fff9970a88e0538a24480ffb8 ]

smatch reports:

drivers/gpu/drm/drm_file.c:967 drm_show_memory_stats() error: uninitialized symbol 'supported_status'.

'supported_status' is only set in one code path. I'm not familiar with
the code to say if that path will always be ran in real life, but
whether that is the case or not, I think it is good to initialize
'supported_status' to 0 to silence the warning (and possibly fix a bug).

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231103-uninit-fixes-v2-1-c22b2444f5f5@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index a8b4d918e9a3..d6a0572984b5 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -406,7 +406,7 @@ int drm_open(struct inode *inode, struct file *filp)
 {
 	struct drm_device *dev;
 	struct drm_minor *minor;
-	int retcode;
+	int retcode = 0;
 	int need_setup = 0;
 
 	minor = drm_minor_acquire(iminor(inode));
-- 
2.43.0


