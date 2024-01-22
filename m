Return-Path: <linux-kernel+bounces-33500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18481836A64
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57DC281BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0796013B7AA;
	Mon, 22 Jan 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kK3HR8ov"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F73D3BD;
	Mon, 22 Jan 2024 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936540; cv=none; b=AoD5nQeuUfk6nbW4RSUvKAqNgL9KujGRQQ2vEBSURImjPaE7YPq7folOeUT3yCMDZFec6YdvvMhj7dKB+v7e4i9AQQtcWEWSkpf5VnmykYBy1bIKS/caKeCd9k/rhar36G6iVRr3DtZYD6xc+H+BU+TvKtNuCrVxTXpNthnHeQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936540; c=relaxed/simple;
	bh=EFenuZeTfK4htTwIGJoDpBTqQUk9QC/xPh9GsknP7mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCRay/5vFSVt4C605ewBEcSrdty6JpxGtybvnjBx2fCOQgOLlnDVhGlDNMcGMfdj3depKzz1Gjgp7s9hlY/AiFbgoVbZ6AUCM2T7lfSDU0Wmg8eqT7oGZDDdSgbgE9NO1Qb8+vtn1z47qsIdEggoF6w0IsMFeEul6SgMdNX61O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK3HR8ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B9BC433C7;
	Mon, 22 Jan 2024 15:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936540;
	bh=EFenuZeTfK4htTwIGJoDpBTqQUk9QC/xPh9GsknP7mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kK3HR8ovikzmiCl+OGQPgnX+Kh43K8j1ziqdt9S6p6RQGyjNPGYH5yTYTRqTLavyO
	 lKPFomQ9j6KlMlx/jRN3440NCpOOKOxtJQijw7VYxWC2r7o1y5zrUC9ypjtFcsHsQk
	 1vhEWD+g5ugg/pWxg/ifMuRvv7+0D9PPJlYbRdQ2sRFVeYKfqLTH5k6VG0xmP41FKy
	 GEvXSw3OXTgkiCcMVteMfbjvucB+/EZGDE8BGFDCAY0oVRZswYTgB/DfMIQJKqPJJn
	 +9bmgw967RJMdglS1Q3IkrZc5VpHfPmz85w9NEBnPW2+gAO1dpgq7UzAo7rVi92SRd
	 suvQkdB+O4OUA==
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
Subject: [PATCH AUTOSEL 5.10 07/28] drm/amd/display: Fix tiled display misalignment
Date: Mon, 22 Jan 2024 10:14:33 -0500
Message-ID: <20240122151521.996443-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 36a9e9c84ed4..272252cd0500 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1440,6 +1440,10 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		wait_for_no_pipes_pending(dc, context);
 		/* pplib is notified if disp_num changed */
 		dc->hwss.optimize_bandwidth(dc, context);
+		/* Need to do otg sync again as otg could be out of sync due to otg
+		 * workaround applied during clock update
+		 */
+		dc_trigger_sync(dc, context);
 	}
 
 	context->stream_mask = get_stream_mask(dc, context);
-- 
2.43.0


