Return-Path: <linux-kernel+bounces-113275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B87888305
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87FE1F2443E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CF3136E27;
	Sun, 24 Mar 2024 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGL/EZOM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF518B60D;
	Sun, 24 Mar 2024 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320075; cv=none; b=s/vksEF4IrRC20nsoq5FO4uSsr7MnYywDLuhMRqZQliauN1MoGGL/fCGwL6ECBOIS/BZos2fr2hXysK8LEycOXT6/axt87ygyA1svBrrC2XT5RYMDm64vk6oxotmwOBKSWgz62UUjKqrLzna5okS7u9b4gRegK26R48hZZneh/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320075; c=relaxed/simple;
	bh=NOpg9zxaUBO0n+k+3suS+QM4rrKWbcPxqtgdxUs4IdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KycTulsh83tF2cnIIiRVsZHa6u4X9UAMkeIb7JP6DLkqykcsd0TGsMrm1Ubpa5WYzXxB74ka/BPKobJZJwrM6KFPY8seY6RrmLoeAcdOq00pTTnp2pgGQ8o2WR3DUELZLgOdwHadM5ubgLN4oFqmtHcxb9Xr0DYgG3hjMlr619A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGL/EZOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05BFC43399;
	Sun, 24 Mar 2024 22:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320075;
	bh=NOpg9zxaUBO0n+k+3suS+QM4rrKWbcPxqtgdxUs4IdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGL/EZOMODSSjjIM3Ahkts2QVXI7amqaIsJXOiDG+d5syMK/bI+NO6BscrL/CFWup
	 IG9IbO8ioTLflxo9qgoDDZ3jU1/M1Zcx2NTOwyjmRQ3hxXxw+Me6HsiEC78uwjqEKK
	 uCBqrMuiAraEDYDNY1eygG6CEfc767MapK7eebfMheiCnG4gVtwSRxAus9CTc74IEk
	 JmWvz9UmRyVJZe1Hha2osY8UcLGTOhtvO6fVZ9yMhxauRB67q6h0LeNLPbzcpItSij
	 1dVnsN0h+MT8ECW0IrrOOZGtH5rRrNKAd2jUF6mzXAmJ3HvzlgrQTg3jfe7hFynkae
	 pRX49JcgDzccQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Krastev <martin.krastev@broadcom.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 384/715] drm/vmwgfx: Fix vmw_du_get_cursor_mob fencing of newly-created MOBs
Date: Sun, 24 Mar 2024 18:29:23 -0400
Message-ID: <20240324223455.1342824-385-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 5fd0ccaa0b41b..b6f40781b907a 100644
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


