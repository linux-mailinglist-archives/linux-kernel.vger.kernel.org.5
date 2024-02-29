Return-Path: <linux-kernel+bounces-87458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F7A86D4AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9F51C21495
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D7614BD53;
	Thu, 29 Feb 2024 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnBqyPBc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ACB14402F;
	Thu, 29 Feb 2024 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239153; cv=none; b=ZYm4kFW4LKliLQ+P1/qAyJ0e9RbcdAvznr8ieflWsohS7qMt3K5I0KeKF95kdptMS9Tdw5ButCFiOGzeA2nWARnR7gI9LKlyIHeS+ifYagb12tu2M8oqVt3WoBa+fH/PXZbMf5fC+qbSWpjYVG8spG5gpb9vCeCFhPyB8/+zoQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239153; c=relaxed/simple;
	bh=F1BWa4jzZKYFHykP4yUqY5Y3/LkmRdmf8Kjmr64U45s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3A33aZBAKR1AXcnFPZuP7csDTgxJRNKPtnW4j14tqxEDc5MC49UVWCHd1/jLEM1l25gw2CIctlelwNJniFX1HME2qxUCpT8U6IkNy2xUsiWgX5b0yeeJ+Jdvue3jocg83B3BCvJXKUOYqLUV/CU1QPAUmtE0WiIDksMmNJZkGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnBqyPBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB589C433F1;
	Thu, 29 Feb 2024 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239152;
	bh=F1BWa4jzZKYFHykP4yUqY5Y3/LkmRdmf8Kjmr64U45s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UnBqyPBc6vQZct3ynFoSMxTHtFV0cajnkqJH36TeNWTaotTIfF92b4vxcYKoMwPMH
	 beZE7QWOTD2uuEF6tt1Ujogv12Pj4VRKKHcA2z7OzHS3cgMpOUPzVlUuQXE3w5TIEi
	 XpXPOkp23yNegPLxo0s8IieM02JRWjpHiA2JpZZ2K7AjkLGG0EE37MFknfBa3YjvYl
	 6oFyq1vBpCY3RpipcvtQ/dxbMJ9U051ec0KCVkl+GL9IzEy8jE0CH0rraEeLM10xas
	 XPfbwByInw8ULfE7LmsX+t5R00pibZuqB1ril0UMX4ErgZIyY6cvudJ9UvRXM0Ulrd
	 lzhtGrx3ocANg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Swapnil Patel <swapnil.patel@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
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
	nicholas.kazlauskas@amd.com,
	hamza.mahfooz@amd.com,
	roman.li@amd.com,
	syed.hassan@amd.com,
	sungkim@amd.com,
	jerry.zuo@amd.com,
	Qingqing.Zhuo@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 24/24] drm/amd/display: fix input states translation error for dcn35 & dcn351
Date: Thu, 29 Feb 2024 15:37:04 -0500
Message-ID: <20240229203729.2860356-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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


