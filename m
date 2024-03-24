Return-Path: <linux-kernel+bounces-115297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1103889A84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B831F33E00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F581D44B7;
	Mon, 25 Mar 2024 02:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0psc4Wm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107C7F7DC;
	Sun, 24 Mar 2024 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320488; cv=none; b=kp/fOmDMElqKFerPAPYX7rAXoM5EuvzUiNGSto2w3nK+sbz20aBiIxKTvHUjteOu6Fk3SkBaO/0wrijDVVg7stiawPsq7NhTa9fX0XHyQLyafoAi3hCybnduyvLlZWQK41u9nuVRzpiGL3sHqhhDHUyOF/xURBm/EDy8oug0ueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320488; c=relaxed/simple;
	bh=F1BWa4jzZKYFHykP4yUqY5Y3/LkmRdmf8Kjmr64U45s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3UacuZWFaM3B20k+2RC6MSq56BEXd1ngb3hc1MIoRrjcvDGqWCKyCCgLVe3N/cg6h9KUP0QHF449+TJVawxhaBxcsoV649QtHYc5Qeh4w3cfVsS+2d6qfN39nuXjdS1q3XTPH8uf1yWJD69Ib2mvKf/FWU/3E3ZWpWKw8YAQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0psc4Wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456CCC433F1;
	Sun, 24 Mar 2024 22:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320488;
	bh=F1BWa4jzZKYFHykP4yUqY5Y3/LkmRdmf8Kjmr64U45s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r0psc4WmZVsSW2QTPk5O1O5g5/fFypjj5o3BZCMoUj/WW9bldPD8tHqeKR1uQpOM8
	 vzhro9RwMF1apfsCAeuxRfWG8hWv4CryEZ86I5Oia30K1a5hsOtkWeEhT60szvl/Xq
	 bxS+pOWXgRz2KDI1fAH1nc3sK9pa4fKIKJzx0xdO3wpz0F9wk7VnKGk9z9Vx1SasHf
	 dfFCVor3AmS+i/nX/bJTDqCaa/7uTIwxhD1PKQqp+plhQLBCr2FFaPi4+KRScgI0pX
	 wM7zhbGhxbk3i/8cDf+5OZbUNI3ouITq60At7QthwivbI9CVs1bp4wKC2MDkDb7+PN
	 1Dyi6uQwQcHtg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Swapnil Patel <swapnil.patel@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 047/713] drm/amd/display: fix input states translation error for dcn35 & dcn351
Date: Sun, 24 Mar 2024 18:36:13 -0400
Message-ID: <20240324224720.1345309-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Swapnil Patel <swapnil.patel@amd.com>

[ Upstream commit 27a6c49394b1a203beeb94752c9a1d6318f24ddf ]

[Why]
Currently there is an error while translating input clock sates into
output clock states. The highest fclk setting from output sates is
being dropped because of this error.

[How]
For dcn35 and dcn351, make output_states equal to input states.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Swapnil Patel <swapnil.patel@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dml2/dml2_translation_helper.c    | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 2c379be19aa84..16452dae4acac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -398,7 +398,6 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 	/* Copy clocks tables entries, if available */
 	if (dml2->config.bbox_overrides.clks_table.num_states) {
 		p->in_states->num_states = dml2->config.bbox_overrides.clks_table.num_states;
-
 		for (i = 0; i < dml2->config.bbox_overrides.clks_table.num_entries_per_clk.num_dcfclk_levels; i++) {
 			p->in_states->state_array[i].dcfclk_mhz = dml2->config.bbox_overrides.clks_table.clk_entries[i].dcfclk_mhz;
 		}
@@ -437,6 +436,14 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 	}
 
 	dml2_policy_build_synthetic_soc_states(s, p);
+	if (dml2->v20.dml_core_ctx.project == dml_project_dcn35 ||
+		dml2->v20.dml_core_ctx.project == dml_project_dcn351) {
+		// Override last out_state with data from last in_state
+		// This will ensure that out_state contains max fclk
+		memcpy(&p->out_states->state_array[p->out_states->num_states - 1],
+				&p->in_states->state_array[p->in_states->num_states - 1],
+				sizeof(struct soc_state_bounding_box_st));
+	}
 }
 
 void dml2_translate_ip_params(const struct dc *in, struct ip_params_st *out)
-- 
2.43.0


