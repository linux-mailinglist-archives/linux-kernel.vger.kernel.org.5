Return-Path: <linux-kernel+bounces-114272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3914888F82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A2B1C2BDCC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82F425C6A4;
	Sun, 24 Mar 2024 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brxnKIKn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D320CE07;
	Sun, 24 Mar 2024 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321645; cv=none; b=exs1Nyc6qHopaz0csjrIFdbIvLBo/V0VHLTChXPhmQfJVj+ZaipcptQjWrZzg2BfGUHJKI+43meFGp8XkGor4K1CZnQac9yUT0qaNFdReVWT8xczBwzXMq3nW47LD256tDQZnO6hZ9a4D8jJz6ecGToJ6+0ydpFCsGOcuN0F38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321645; c=relaxed/simple;
	bh=NxVz+WguTMB6Coo2YUZwzcntSivhyOF+Rdca8TF9s9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rI9NOWf45On/+tu0SsAv/eStO2EGLZsvE3mgWe2OJpwrEU6/40/Fxk1n/YUbtyM1HMdL8egZxCBslui2fdRznVEKoo+CLp5rMAB80GDq4gI6a6VMv+jNez+oh4RAgtA99b9gtzaD8NwJzRJ9Ny9ID/oWRMakT0Mz6+VawuvPZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brxnKIKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ED4C433C7;
	Sun, 24 Mar 2024 23:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321644;
	bh=NxVz+WguTMB6Coo2YUZwzcntSivhyOF+Rdca8TF9s9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brxnKIKnJPnbvcBpAQea+FyMh3phdY+4cmR7gIfU4yks7+7HjOz1OlkvWFy2AdDka
	 Zai/cxWF4VrXVG1VS8Ni05WgOJFpKLLnCz5+oLkwbCNeEECaAyBLRSSbO6shxXm6l3
	 pLfhPY6yqfKYjbbIiY3LmXg/SORMsUvybQ/HeZx32c1/TFm2T60aYnbgzxa1HT5PQJ
	 SzHMaBm/LbGNCOTJC4lyuXJEVLj5ek0bqEhnZHTmRXoTO0zXEuYlgMUJyqb90NVYdl
	 BkFovA6b3Zhhra3DqHt5aKw49qHKGuPcukV/HIwmNcoQ6PSMBBAAifLlgp418kc/4R
	 s6QbpDUPgmCQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Krastev <martin.krastev@broadcom.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 373/638] drm/vmwgfx: Fix vmw_du_get_cursor_mob fencing of newly-created MOBs
Date: Sun, 24 Mar 2024 18:56:50 -0400
Message-ID: <20240324230116.1348576-374-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Martin Krastev <martin.krastev@broadcom.com>

[ Upstream commit ed96cf7ad590989b009d6da5cd26387d995dac13 ]

The fencing of MOB creation used in vmw_du_get_cursor_mob was incompatible
with register-based device communication employed by this routine. As a
result cursor MOB creation was racy, leading to potentially broken/missing
mouse cursor on desktops using CursorMob device feature.

Fixes: 53bc3f6fb6b3 ("drm/vmwgfx: Clean up cursor mobs")
Signed-off-by: Martin Krastev <martin.krastev@broadcom.com>
Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240126200804.732454-5-zack.rusin@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 818b7f109f538..b51578918cf8d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -272,6 +272,7 @@ static int vmw_du_get_cursor_mob(struct vmw_cursor_plane *vcp,
 	u32 size = vmw_du_cursor_mob_size(vps->base.crtc_w, vps->base.crtc_h);
 	u32 i;
 	u32 cursor_max_dim, mob_max_size;
+	struct vmw_fence_obj *fence = NULL;
 	int ret;
 
 	if (!dev_priv->has_mob ||
@@ -313,7 +314,15 @@ static int vmw_du_get_cursor_mob(struct vmw_cursor_plane *vcp,
 	if (ret != 0)
 		goto teardown;
 
-	vmw_bo_fence_single(&vps->cursor.bo->tbo, NULL);
+	ret = vmw_execbuf_fence_commands(NULL, dev_priv, &fence, NULL);
+	if (ret != 0) {
+		ttm_bo_unreserve(&vps->cursor.bo->tbo);
+		goto teardown;
+	}
+
+	dma_fence_wait(&fence->base, false);
+	dma_fence_put(&fence->base);
+
 	ttm_bo_unreserve(&vps->cursor.bo->tbo);
 	return 0;
 
-- 
2.43.0


