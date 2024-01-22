Return-Path: <linux-kernel+bounces-33366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC288368D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE82B1C228E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F3D6A35B;
	Mon, 22 Jan 2024 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLFNuCbp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1251348CDD;
	Mon, 22 Jan 2024 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935992; cv=none; b=ArOwTGZ31po2LP/Jz/gGIZu1SEgXdgFC9NNiygRo5VRdx4kOBtRPNlzXww/1i+RRHKFKOj+RMYOB8o4GGvS2g0Dts4pXOdgmnFQ/Q1uJC7M1XOgs+vTDw5eWb4Lpgk5sbe2Dq0delAYMJONZr0voU/hPcIrzHqRch1oHVVc6Quw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935992; c=relaxed/simple;
	bh=N/JYfq2P2B6n2iliMdJGT06WbHGJvbszbHCOVodukAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9fRdQy2hYq+93xPXIAJx2RrwDD7ZshJyiRSTUau0ui4b4ny2kYV4h4Qqb4xvBoz7fyyZMIe+NpcuAnIVXE0v52xmkGwXOl5rH4VjxYuHfVYhDYjrc63rROf3sZPpEJhnRSBivFyXX5Md51VkQM5xuH5vcvlfvqajFQTGOyY1go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLFNuCbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB734C43394;
	Mon, 22 Jan 2024 15:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935991;
	bh=N/JYfq2P2B6n2iliMdJGT06WbHGJvbszbHCOVodukAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLFNuCbpzOPt6eLrHwml0rENpUetiqa7lecsNcYP1L0ASWIGgvHHEpdFoaxI3rSOa
	 QzvYA4WjFV/Udgq+09Qt8nLUjBlBYPePU/FUVne7aXUrRmVG6K8pe/fCzHIJGEJoFP
	 rk5m/5XFwnfJVBbihUEez5u31keD07mO3L82UaG4/oires0GwTDjv+vgoFwJnS+bnW
	 CSwdLV+Ygr6/INuOfavK13KOYTAJ/UhiFr91Ovwai+KJR9ZysWlfrFtMwUl2Jjygue
	 YZnD5pX4upFC0zLfY8SCbENPYrvtZ7bg06U2nPZQbxlB7bZUT4mrXGGN5DWspQr0TW
	 TYOLgJgPJC/CQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alvin Lee <alvin.lee2@amd.com>,
	Samson Tam <samson.tam@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
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
	jun.lei@amd.com,
	Qingqing.Zhuo@amd.com,
	wenjing.liu@amd.com,
	Wesley.Chalmers@amd.com,
	Alvin.Lee2@amd.com,
	mdaenzer@redhat.com,
	gabe.teeger@amd.com,
	ilya.bakoulin@amd.com,
	moadhuri@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 44/73] drm/amd/display: Force p-state disallow if leaving no plane config
Date: Mon, 22 Jan 2024 10:01:58 -0500
Message-ID: <20240122150432.992458-44-sashal@kernel.org>
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

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit 9a902a9073c287353e25913c0761bfed49d75a88 ]

[Description]
- When we're in a no plane config, DCN is always asserting
  P-State allow
- This creates a scenario where the P-State blackout can start
  just as VUPDATE takes place and transitions the DCN config to
  a one where one or more HUBP's are active which can result in
  underflow
- To fix this issue, force p-state disallow and unforce after
  the transition from no planes case -> one or more planes active

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index a2e1ca3b93e8..2c4bcbca8bb8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1792,6 +1792,8 @@ void dcn20_program_front_end_for_ctx(
 	int i;
 	struct dce_hwseq *hws = dc->hwseq;
 	DC_LOGGER_INIT(dc->ctx->logger);
+	unsigned int prev_hubp_count = 0;
+	unsigned int hubp_count = 0;
 
 	/* Carry over GSL groups in case the context is changing. */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -1815,6 +1817,20 @@ void dcn20_program_front_end_for_ctx(
 		}
 	}
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (dc->current_state->res_ctx.pipe_ctx[i].plane_state)
+			prev_hubp_count++;
+		if (context->res_ctx.pipe_ctx[i].plane_state)
+			hubp_count++;
+	}
+
+	if (prev_hubp_count == 0 && hubp_count > 0) {
+		if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
+			dc->res_pool->hubbub->funcs->force_pstate_change_control(
+					dc->res_pool->hubbub, true, false);
+		udelay(500);
+	}
+
 	/* Set pipe update flags and lock pipes */
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		dcn20_detect_pipe_changes(&dc->current_state->res_ctx.pipe_ctx[i],
@@ -1962,6 +1978,10 @@ void dcn20_post_unlock_program_front_end(
 		}
 	}
 
+	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
+		dc->res_pool->hubbub->funcs->force_pstate_change_control(
+				dc->res_pool->hubbub, false, false);
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-- 
2.43.0


