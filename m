Return-Path: <linux-kernel+bounces-57093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC04C84D3F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADB7282C7D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0A13A268;
	Wed,  7 Feb 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ1lEexI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B71813A264;
	Wed,  7 Feb 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340973; cv=none; b=eS75qDHimfehPnhMDfJj1m3wu3/Pq2dJha9bqgzxwxeXax906eZqJ8EwgDpB1ISR8XX117DRSGDTloQGvjwNrH03M9QB+gGaGYIekZCUh6FXgHnS1DmlCha9dFrRAB/cwcicBN1DFSC6Jx30A+oix+qXo2SaW7pnVQJ/pcVgO50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340973; c=relaxed/simple;
	bh=WjrGBbmBwFuClQgLEwq6XHT7XiT7/HS9MDSziNwfJ2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uen/HXGFqPPTrj9XhQy0zX/xLA4ImYcAI6h6iX3AWeLyUo/yZdMSZwOOfH6lM62gsYQ+K02i/7GVBF3V0wNgGXTzjQmCCfKbzegamqtfwDfEOutFGu1i0GZBaZQRMOIgW3poT3j3hDzWlVCpc2K82SfEtsS+suePRJI1ZRlqvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ1lEexI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCFEC43390;
	Wed,  7 Feb 2024 21:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340972;
	bh=WjrGBbmBwFuClQgLEwq6XHT7XiT7/HS9MDSziNwfJ2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJ1lEexIpP1fpVSCxYjhQbOW7GFkFOijNYztZxWUCr+Cs+mddV7HnIeuYQAJfr/1M
	 w023YuByl7y03zP6t+oAWuy8xzrbJGy8QlXl71k8LJW+LmSS/x3e4owXmGaybixVZg
	 VcjQw5br5DnFDGxhTc8Gi8gk9SFeXXSZTauhInhvClMJmANgGx0cjsdfbPRrfhiCNo
	 Q47bENbeP5ENdLyAAUVTawSooVRCr77m8YBhDgBdhRpvh2kOotHPeA/Hw1ERlLLJ+m
	 qkhjrPVLtAfUmIhav2Q8ixQqUBBVSlfQZpEmsS1ae6JFLusG5+F5b+dD/8cTPSVUy3
	 kwQTpNdfdseQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Miess <daniel.miess@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	hamza.mahfooz@amd.com,
	nicholas.kazlauskas@amd.com,
	qingqing.zhuo@amd.com,
	wenjing.liu@amd.com,
	dillon.varone@amd.com,
	ian.chen@amd.com,
	swapnil.patel@amd.com,
	Jingwen.Zhu@amd.com,
	jun.lei@amd.com,
	alvin.lee2@amd.com,
	Wesley.Chalmers@amd.com,
	mdaenzer@redhat.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 27/44] drm/amd/display: Fix DPSTREAM CLK on and off sequence
Date: Wed,  7 Feb 2024 16:20:54 -0500
Message-ID: <20240207212142.1399-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[ Upstream commit 31c2bf25eaf51c2d45f092284a28e97f43b54c15 ]

[Why]
Secondary DP2 display fails to light up in some instances

[How]
Clock needs to be on when DPSTREAMCLK*_EN =1. This change
moves dtbclk_p enable/disable point to make sure this is
the case

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |  2 +-
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 9b8299d97e40..390d7ebfd8db 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1182,9 +1182,9 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		dto_params.timing = &pipe_ctx->stream->timing;
 		dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
 		if (dccg) {
-			dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 			dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
 			dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
+			dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 		}
 	} else if (dccg && dccg->funcs->disable_symclk_se) {
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 608221b0dd5d..780b94592992 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2755,18 +2755,17 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	}
 
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
-		dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
-		dccg->funcs->set_dpstreamclk(dccg, DTBCLK0, tg->inst, dp_hpo_inst);
-
-		phyd32clk = get_phyd32clk_src(link);
-		dccg->funcs->enable_symclk32_se(dccg, dp_hpo_inst, phyd32clk);
-
 		dto_params.otg_inst = tg->inst;
 		dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
 		dto_params.num_odm_segments = get_odm_segment_count(pipe_ctx);
 		dto_params.timing = &pipe_ctx->stream->timing;
 		dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
 		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+		dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
+		dccg->funcs->set_dpstreamclk(dccg, DTBCLK0, tg->inst, dp_hpo_inst);
+
+		phyd32clk = get_phyd32clk_src(link);
+		dccg->funcs->enable_symclk32_se(dccg, dp_hpo_inst, phyd32clk);
 	} else {
 		if (dccg->funcs->enable_symclk_se)
 			dccg->funcs->enable_symclk_se(dccg, stream_enc->stream_enc_inst,
-- 
2.43.0


