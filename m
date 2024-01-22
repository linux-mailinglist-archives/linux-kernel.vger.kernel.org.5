Return-Path: <linux-kernel+bounces-33231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C968366DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5DC286B88
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01F13DBA7;
	Mon, 22 Jan 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6MQ946G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA14BAA5;
	Mon, 22 Jan 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935423; cv=none; b=o+sNzQsN5Gn8b5KOU0Yql/r+j1ytaxFcz/W6ODiWVChDs/daaec/C6bOdf1bOzqRQ481EG3E1igItc3dDvaDvqqGIJxWa+QYbHil9YQxOOB9kV0Dy9JZX8f8m/m5k111dDMAIgFDvIuWi4jPvGAspfZavrdDNuMH/wEOf6guaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935423; c=relaxed/simple;
	bh=h2EMJEwn+xtLhnIs1AdEUWAodoqKiuzxMfQyLE/5Ax0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXQqUyDk5Lv21OkwbJp2k3LREiUU44qgJ8uaR8URZqaEOPPK58llsGEMq6nOuhO22K0Gs4DGMeVYbGQQd6/nfp+uWGpxcjoRBXCzmmgkPTlxUFiqhdSTHJ5GXDgczGT9igJzhtXac3AlSETFELPvhm0dKxKbcSWRI/D65VFx3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6MQ946G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C1EC433C7;
	Mon, 22 Jan 2024 14:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935422;
	bh=h2EMJEwn+xtLhnIs1AdEUWAodoqKiuzxMfQyLE/5Ax0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6MQ946GWyq4ysz102YRflODLX6OKT9QuX7VOrrkUqD68fZdnDLmkFpcbxU2d67NC
	 hIjIhn8Df/XGubxbRvfQpMfX9+EIodWek0B3TH18DSgHUVbXzCWpBzy3M4nXpfOPms
	 DHfiL2mrDEolUSxJ4kn4GNG2/atYahCjk++SjMMjL6xklIqPAkRfF868ehPBR4j4gs
	 GKABjCvq/JBoLw6NzIMpn6jZhC0iDgij74UL4nEy/RAvkXgXRfiy1N2VRf7/zpU+3I
	 /ckxm8ZrccB5XL6k5qN73fxJPyYxGWSLT8Jml1qQjUwjfWduos4376Pz3ItczI+lJd
	 VuqPBhDkHhYBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charlene Liu <charlene.liu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Syed Hassan <syed.hassan@amd.com>,
	Allen Pan <allen.pan@amd.com>,
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
	hamza.mahfooz@amd.com,
	nicholas.kazlauskas@amd.com,
	roman.li@amd.com,
	sungkim@amd.com,
	Qingqing.Zhuo@amd.com,
	jerry.zuo@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 17/88] drm/amd/display: initialize all the dpm level's stutter latency
Date: Mon, 22 Jan 2024 09:50:50 -0500
Message-ID: <20240122145608.990137-17-sashal@kernel.org>
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

From: Charlene Liu <charlene.liu@amd.com>

[ Upstream commit 885c71ad791c1709f668a37f701d33e6872a902f ]

Fix issue when override level bigger than default. Levels 5, 6, and 7
had zero stutter latency, this is because override level being
initialized after stutter latency inits.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Syed Hassan <syed.hassan@amd.com>
Reviewed-by: Allen Pan <allen.pan@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index db06a5b749b4..279e7605a0a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -341,6 +341,9 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 		break;
 	}
 
+	if (dml2->config.bbox_overrides.clks_table.num_states)
+			p->in_states->num_states = dml2->config.bbox_overrides.clks_table.num_states;
+
 	/* Override from passed values, if available */
 	for (i = 0; i < p->in_states->num_states; i++) {
 		if (dml2->config.bbox_overrides.sr_exit_latency_us) {
@@ -397,7 +400,6 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 	}
 	/* Copy clocks tables entries, if available */
 	if (dml2->config.bbox_overrides.clks_table.num_states) {
-		p->in_states->num_states = dml2->config.bbox_overrides.clks_table.num_states;
 
 		for (i = 0; i < dml2->config.bbox_overrides.clks_table.num_entries_per_clk.num_dcfclk_levels; i++) {
 			p->in_states->state_array[i].dcfclk_mhz = dml2->config.bbox_overrides.clks_table.clk_entries[i].dcfclk_mhz;
-- 
2.43.0


