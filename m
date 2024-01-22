Return-Path: <linux-kernel+bounces-33388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EBE83691D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2471F22A62
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065D27691B;
	Mon, 22 Jan 2024 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpJfNVM4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB314BA82;
	Mon, 22 Jan 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936093; cv=none; b=bMpVszLwbgaDi5bansjm8C7jWvm8q4K1IK7U2C1CNyKJcmWU6gia7DebS2iDxVAJSmZ9dZdJkv3zkmXvtGXdADTebQj7fFIPkEjnzNPyQeLKPCISVugpawFsknmL7YCuXRUnR2iLLFjPgOWQHm5bGL3XOHZpE2S3Y1nrtfzxnKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936093; c=relaxed/simple;
	bh=1Q7Z81zASWE7XHaFnf9WPbdcfwDelvwLdwo+aImNdaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfUn5Fzfmouy6Afxhrup5sznYaKXZwTssxulx94V2+dy0VeQezftCLQQAf9R/kfZfD9LPgERVTYwYVMti8iafRLnT6IeqrZJRimwmbLfbpHkM/Xl3wX+e3dssaMMe0U49Bn9WGImEmtyaBt6JBPRtupq6OYBuOyficxR5omwnp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpJfNVM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5CBC43394;
	Mon, 22 Jan 2024 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936093;
	bh=1Q7Z81zASWE7XHaFnf9WPbdcfwDelvwLdwo+aImNdaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bpJfNVM4IN3CNkQ8ZiW1fY4VA7DVFIFX+NAhoxY9DvnXQqTlUVjjjroPz3pOl3PLd
	 BFc7TLRk3i+T0HOVtOV4RCtXouj78V5yDS6q9aSDi5a0ZfReRH5hSloPDOayVL1TrQ
	 DnKPJgp+mCFQ+h55FAhqJsUpZ4BW8yWmwJ0yB+CrRl8Waoj3s0k8N9zg/5B8NBQbi7
	 rWAyc7ksZTJM9szooE2fdT2v4EBtEgQ0PiKthjtZ8sSGqxaDZ309idpD0TDkkSuMBm
	 40jP3eK8mNFzrAlPD+LtLH7+vRELWv6CA9JdlgfXi7OAmiLPqDfJqfCq8ufSE2Ryz8
	 Di9D9BqTHVErw==
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
Subject: [PATCH AUTOSEL 6.6 63/73] drm/amd/display: Fixing stream allocation regression
Date: Mon, 22 Jan 2024 10:02:17 -0500
Message-ID: <20240122150432.992458-63-sashal@kernel.org>
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
index 3ad2b48954e0..03bd05596d21 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -190,7 +190,7 @@ bool dcn32_subvp_in_use(struct dc *dc,
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (pipe->stream && pipe->stream->mall_stream_config.type != SUBVP_NONE)
+		if (pipe->stream && pipe->stream->mall_stream_config.type != SUBVP_PHANTOM != SUBVP_NONE)
 			return true;
 	}
 	return false;
-- 
2.43.0


