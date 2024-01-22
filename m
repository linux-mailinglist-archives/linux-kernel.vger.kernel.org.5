Return-Path: <linux-kernel+bounces-33447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592D38369C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED30D1F22515
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79C812BEB3;
	Mon, 22 Jan 2024 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUhCZ8/a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186724F886;
	Mon, 22 Jan 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936336; cv=none; b=Gx0IELQArJVrzTqf7FhfPNAxGliK3KEx+QrGSXqKRpOgDZoL54scGT5iCvcwGZ+SpTeihvLxNPcHLsZqReaBZ5/4MW2BppkDW3Zx8RUC92fQo7a9RoTlkpeA8FWiMYBfBfcnQuWt8CNEI16xhvygNUJ6qEJlHdH6WhW4vRgLpzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936336; c=relaxed/simple;
	bh=mNZZR+4a3jQ2iGjxMb44UQYeZb7y09/TDQQKYWJXy6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irq9QpFxft7CotwYi9ELW+rbaitDIdIf2R5YCzwX7vUHLbVz04vDGk+Ek2xg7HXe0N7CQZTglljDlku1HcMIO1TILvYIGxDXVIImnY6GipeSv8wVhxHBh8F1xGKBp2RknNe6JGarfUZgErEHH6qAqPW75U3PXDqHnwMw6PSQ0eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUhCZ8/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2467AC43394;
	Mon, 22 Jan 2024 15:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936335;
	bh=mNZZR+4a3jQ2iGjxMb44UQYeZb7y09/TDQQKYWJXy6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUhCZ8/aCLTZZPPsM6wEtbAslskZTjqyV1cz7QDwcRafleA9kceCz2Z5zcYaFNK4/
	 FqT2Q53pTHeRE0BVzBtUdwH2KaGFCnhPjU/ngAFzJNmGiEZrXFmmJi1RAogJv9a0Bb
	 LrYnY82WIgwchqfR57+R4/iJJ+bqmlZqrHJwO47yrRS2Jkr5f1esHpLjMbTyKSdnfx
	 TZGACCOJelzsaHX89cvPJpbT7FXJPmEZDx5iQFTHaCdxkSz6lywWUzJXvMp/zxE6fl
	 pL4TxnXx02TPzYO76PGDRtCSxORikLYu3HPdNcVTatpIaiHVjN8kbk8c6Jcd5OpQki
	 7z9e3VBaDxe9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Relja Vojvodic <relja.vojvodic@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Martin Leung <martin.leung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alvin.lee2@amd.com,
	jun.lei@amd.com,
	samson.tam@amd.com,
	srinivasan.shanmugam@amd.com,
	ethan.bitnun@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 46/53] drm/amd/display: Fixing stream allocation regression
Date: Mon, 22 Jan 2024 10:08:47 -0500
Message-ID: <20240122150949.994249-46-sashal@kernel.org>
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

From: Relja Vojvodic <relja.vojvodic@amd.com>

[ Upstream commit 292c2116b2ae84c7e799ae340981e60551b18f5e ]

For certain dual display configs that had one display using a 1080p
mode, the DPM level used to drive the configs regressed from DPM 0 to
DPM 3. This was caused by a missing check that should have only limited
the pipe segments on non-phantom pipes. This caused issues with detile
buffer allocation, which dissallow subvp from being used

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Relja Vojvodic <relja.vojvodic@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index fa3778849db1..5e0fcb80bf36 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -216,7 +216,7 @@ bool dcn32_subvp_in_use(struct dc *dc,
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (pipe->stream && pipe->stream->mall_stream_config.type != SUBVP_NONE)
+		if (pipe->stream && pipe->stream->mall_stream_config.type != SUBVP_PHANTOM != SUBVP_NONE)
 			return true;
 	}
 	return false;
-- 
2.43.0


