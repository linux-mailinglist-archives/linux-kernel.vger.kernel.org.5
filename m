Return-Path: <linux-kernel+bounces-33271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F548367C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C141F28BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1DD58AB5;
	Mon, 22 Jan 2024 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6bZK+0P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19EF58ACD;
	Mon, 22 Jan 2024 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935543; cv=none; b=RIvxIxrsaLVRYWBjx52PvfPtS1mXuzNJb4nQAw5uR6ORjSwhCBoPBlVS+KcvFdjCV4Ig5eLSF+auSxZB5F8QEFBSLmegkmRHascpl4Qt+bsc9T5dB9/E11LIn5wIUQzFrMLVPmfnxoxOuvvBPMj1VcSSTwFsvOROpXLAaDy2I+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935543; c=relaxed/simple;
	bh=MSWeEE6FV7XfvdnRuVEZiZxowGTy6E0Grpm61VV6JOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CH4hYmEVOkKAAJ6eAisUrV97QI6Aem6Cs+zg6UZ8rDTYn6VZ8rqFed4HAg5OTGWLiYgQrvKuG4EDu7A0MsekcLqIw03WM0V7sLoZ4K835Rlqe+1RcZfGTZtQPc8VIk/vox6U6D01o9JKlfWDQcW5lsVeBFHswqlJF4E/0TpaUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6bZK+0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281A2C433C7;
	Mon, 22 Jan 2024 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935543;
	bh=MSWeEE6FV7XfvdnRuVEZiZxowGTy6E0Grpm61VV6JOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6bZK+0PpWHjWIT8qSHGaErRWbtcCaRb0hKyeEiWjJHYxmKtQhh6png0ud0zBq5bK
	 VOyv2AlQbyxzI0nIqBFh3XiXj14NGOUdZA8k4wQZvCM7Dn/1bZalCRHgRAONOancis
	 8qyKAbIpG2BoDnJSZsW14865ukGeSjajbYUT3b+IpYUsFg9oxHbdN6qAN6GcfBStc3
	 08fww7Kp8pJW3+M7byZ7qeg9M/gInukjW/wyJtKTBXTQvdbYEpBGeQrzy/nb+mVlMk
	 GQlIDFgl+domhwFwXw/ZI42BsKM0MO/upVz30Iz+R6ClbezBun955VMK6dOPFFJfOt
	 p+3vu+f2Knw5Q==
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
	jun.lei@amd.com,
	hamza.mahfooz@amd.com,
	wenjing.liu@amd.com,
	Wesley.Chalmers@amd.com,
	mdaenzer@redhat.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 51/88] drm/amd/display: Force p-state disallow if leaving no plane config
Date: Mon, 22 Jan 2024 09:51:24 -0500
Message-ID: <20240122145608.990137-51-sashal@kernel.org>
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
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 608221b0dd5d..c3c83178eb1e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1877,6 +1877,8 @@ void dcn20_program_front_end_for_ctx(
 	int i;
 	struct dce_hwseq *hws = dc->hwseq;
 	DC_LOGGER_INIT(dc->ctx->logger);
+	unsigned int prev_hubp_count = 0;
+	unsigned int hubp_count = 0;
 
 	if (resource_is_pipe_topology_changed(dc->current_state, context))
 		resource_log_pipe_topology_update(dc, context);
@@ -1894,6 +1896,20 @@ void dcn20_program_front_end_for_ctx(
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
@@ -2039,6 +2055,10 @@ void dcn20_post_unlock_program_front_end(
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


