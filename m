Return-Path: <linux-kernel+bounces-33298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4071183682B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 943F8B2900F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA655D905;
	Mon, 22 Jan 2024 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5u4CQXK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FDD5EE87;
	Mon, 22 Jan 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935697; cv=none; b=UGISbc+TS9H6/tcXwsSlM37gsQyk6Kzm9lM9Y76wAHxSdue3ONrOOK1WslxpnU+QA0RtV1YjB25ZestqRwFTRthhk42W1VlH/dMH7k/vopix14W0dfTATAdawGCgZMJtBLg5nsqTwvloxaUggZwTBX1ToqwMN/OOYhjoYMr+Av4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935697; c=relaxed/simple;
	bh=fQFFBkrFdLLM7GxjFIKe1M6mKNcU4J+T9QygBhzijbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0sipRftbNOhKJeu5IRumx97FHn11qpra/bn0sS/CXkU2BoK0tRqUrCh8WlljK0pp+v/yvRaybGKjzNKh4IFtHJG6V6Naf9z8PRsneyxw9NRjfDPlxK9DyCoPW4dxn8pp64ncAF6ggNkNRJCAc6CKp/BFlb4Zj1k1KFSOo3518Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5u4CQXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAB7C433C7;
	Mon, 22 Jan 2024 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935697;
	bh=fQFFBkrFdLLM7GxjFIKe1M6mKNcU4J+T9QygBhzijbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K5u4CQXKjXv9BYjxwLF5UkYU1tYwD8edI2DdYO++gZ4cGChfzFomdThqKIoAGLPnn
	 9hBTJANKD/+OgMOZEooXGnTTuKc/uFZPSVcSGtJoVCapSUJNZtoW2IhXcgeMxOPNMd
	 iABFbii39us/m2KhGrCTfvSgmmG3P+54Ng0ruUY0ezpvg/yRGTiZxHsJmKcVtOwnps
	 mfwEJIzyHYu/TTkcsic3kIdAKGo496aIlnbjfuK+Uq6NSaBzj9QFDh6ExlFQMBkGdI
	 jqeg8Rjxd4t39Q6DIzI0ov0Q4/f8A15GzKR+okcsn/CwJ1/3FopV8YPQEdjNFS0Ac5
	 lIsAMBIYrU+0A==
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
Subject: [PATCH AUTOSEL 6.7 76/88] drm/amd/display: Fixing stream allocation regression
Date: Mon, 22 Jan 2024 09:51:49 -0500
Message-ID: <20240122145608.990137-76-sashal@kernel.org>
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
index bc5f0db23d0c..a9c45174abed 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -290,7 +290,7 @@ static void override_det_for_subvp(struct dc *dc, struct dc_state *context, uint
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
-			if (pipe_ctx->stream && pipe_ctx->plane_state && pipe_ctx->stream->mall_stream_config.type != SUBVP_PHANTOM) {
+			if (pipe_ctx->stream && pipe_ctx->plane_state && pipe_ctx->stream->mall_stream_config.type != SUBVP_PHANTOM != SUBVP_PHANTOM) {
 				if (pipe_ctx->stream->timing.v_addressable == 1080 && pipe_ctx->stream->timing.h_addressable == 1920) {
 					if (pipe_segments[i] > 4)
 						pipe_segments[i] = 4;
-- 
2.43.0


