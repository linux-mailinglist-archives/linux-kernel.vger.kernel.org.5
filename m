Return-Path: <linux-kernel+bounces-33227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD788366C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF171C210F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA994A99A;
	Mon, 22 Jan 2024 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxmNuXHn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC934A997;
	Mon, 22 Jan 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935406; cv=none; b=L2zKHqRDYKl+oO1/lvqAD1php4OgC5f9eIEogBenz3mqdZZgr46uuXOFh5KkH/ywnF+W1qV8Dli0hJrdHjP0+M1+FLDOYplZc1agQQhstLumKr91PojJp7wGCiyBgJfcMgIgQvGhFzY9gKaMBIi4PSrwjSeevZc1FtnI8x4kzjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935406; c=relaxed/simple;
	bh=hE+07rdXTV9JCX+fPOGzqBtAVm5A/aZWznuYlnLdIQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WH2O5YtX3J3WbSvy+OG8DDr4epZoRDSsvpvH3g08b8nGR6hQVm6W65GtCn0SJE+C1MmyNL0Q0795W0n27n8ea4FHyinNkHJlc9tZNHeN4Yj/LSBihEg3Nb6OBM140QX0E819XcWOPoud62X3oY237PLWrLXk7CsylSz9MuP4qhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxmNuXHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2486BC433C7;
	Mon, 22 Jan 2024 14:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935405;
	bh=hE+07rdXTV9JCX+fPOGzqBtAVm5A/aZWznuYlnLdIQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxmNuXHntukY1ZGrBtieHyDQc7MgorBCh/xs1SVTkJD0A6KhFKGYfo9c+/gsOlfY3
	 EspRs7C+eSYNEhiOw3cIamgc1X+rergqbmGoIS12W769e2n9UGxuJwKGq8FFtUaiSm
	 QZkasVHOzmLMBokn53CxVEd0ycRsKrcyegtlZi2WCn9skvF+GCEjKzn68kMzOEtxGN
	 JLfVuBQ9p0Gu0bvz6zVHuQVGhyHiVq/MGmfAh0c2h9PuhECWFpUb+kSln9MjeJfvqM
	 No3fhuXq2AF7LAPZsLfyaY+7m7CNt+bLN1arUgK/dYiOvuNpYAO7GEzvNRSC9W6zWp
	 nh4yzPN+Y4G2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
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
	Qingqing.Zhuo@amd.com,
	wenjing.liu@amd.com,
	alvin.lee2@amd.com,
	samson.tam@amd.com,
	aric.cyr@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 13/88] drm/amd/display: Fix tiled display misalignment
Date: Mon, 22 Jan 2024 09:50:46 -0500
Message-ID: <20240122145608.990137-13-sashal@kernel.org>
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[ Upstream commit c4b8394e76adba4f50a3c2696c75b214a291e24a ]

[Why]
When otg workaround is applied during clock update, otgs of
tiled display went out of sync.

[How]
To call dc_trigger_sync() after clock update to sync otgs again.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5c1185206645..220f05975c0d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1964,6 +1964,10 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		wait_for_no_pipes_pending(dc, context);
 		/* pplib is notified if disp_num changed */
 		dc->hwss.optimize_bandwidth(dc, context);
+		/* Need to do otg sync again as otg could be out of sync due to otg
+		 * workaround applied during clock update
+		 */
+		dc_trigger_sync(dc, context);
 	}
 
 	if (dc->hwss.update_dsc_pg)
-- 
2.43.0


