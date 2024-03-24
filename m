Return-Path: <linux-kernel+bounces-115106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF89888D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA8C289925
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F5C2FB0FE;
	Mon, 25 Mar 2024 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGhb/Dja"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA41C28CE4C;
	Sun, 24 Mar 2024 23:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324100; cv=none; b=TiQVDcV3lyiw4CZJ4x2qKFAvcE69B0h/ZnWNftPr9NmXp2SK3pX6wrwBjARfL165D8OLSkxmLPd4VERX53GfxWzbUl/yugfsfWokzO5KM5Yhp3QbvAVaqwwV2haNSDh1wl1qevGoL4pdLEn1+xQewnX+vcktMMiGjJDIVH8Ww80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324100; c=relaxed/simple;
	bh=NhapjfnB4Eeq7LvrvruOrdqknPKBH/KR7oS/O09bMzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOF2FYbFzF0SkjrjWCuqEYQb4K4D3htI5Ef+tVQpeMu4uYLo9jnt19FT/Dphe5VMOvgwRicdivJP2SAlNZ5nkUTqgGUmdizwcOHyitVuaylM9HBNj1tKb1TCVxhmv/hWVdL/yhTzhUzxuqXlcVOQPkjvcMwgOMeWNUkcH4Mg0P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGhb/Dja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97656C43394;
	Sun, 24 Mar 2024 23:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324099;
	bh=NhapjfnB4Eeq7LvrvruOrdqknPKBH/KR7oS/O09bMzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGhb/DjaKHsjc22UIoRppEf1y5FI3Lq88zmWlYSWN39dxv4k4T3S9cXsNIObONB/W
	 33tjNi2VjUQgmBrUfRospQnol28wdlMvzryclJGOKk9nVfgxx90poHtbwHAXUfyWGG
	 GRu89x0wlUmRdBS3mrnni/K484E8cwGohCI8esF96LRzss27r4O/Ecj1mK+8TMXWj4
	 AuczcPnfGOzk8I7f+TKy4dTRNRbUr2ex5LLctqNqt+Kvw2e68KDO1s7WwQYbpX6z1n
	 3MbSLeH+km2u+1bkVAaSx8DX+Vl/knXk2gK0QQFp/ya9/rRyxramfl+AEtTvQeJ2a1
	 03G27tofgGvgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Wyatt Wood <wyatt.wood@amd.com>,
	Anthony Koo <Anthony.Koo@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 098/183] drm/amd/display: Fix potential NULL pointer dereferences in 'dcn10_set_output_transfer_func()'
Date: Sun, 24 Mar 2024 19:45:11 -0400
Message-ID: <20240324234638.1355609-99-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 9ccfe80d022df7c595f1925afb31de2232900656 ]

The 'stream' pointer is used in dcn10_set_output_transfer_func() before
the check if 'stream' is NULL.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn10/dcn10_hwseq.c:1892 dcn10_set_output_transfer_func() warn: variable dereferenced before check 'stream' (see line 1875)

Fixes: ddef02de0d71 ("drm/amd/display: add null checks before logging")
Cc: Wyatt Wood <wyatt.wood@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index c4c99bc7f2890..3059739695d8c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1470,6 +1470,9 @@ dcn10_set_output_transfer_func(struct pipe_ctx *pipe_ctx,
 {
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 
+	if (!stream)
+		return false;
+
 	if (dpp == NULL)
 		return false;
 
@@ -1492,8 +1495,8 @@ dcn10_set_output_transfer_func(struct pipe_ctx *pipe_ctx,
 	} else
 		dpp->funcs->dpp_program_regamma_pwl(dpp, NULL, OPP_REGAMMA_BYPASS);
 
-	if (stream != NULL && stream->ctx != NULL &&
-			stream->out_transfer_func != NULL) {
+	if (stream->ctx &&
+	    stream->out_transfer_func) {
 		log_tf(stream->ctx,
 				stream->out_transfer_func,
 				dpp->regamma_params.hw_points_num);
-- 
2.43.0


