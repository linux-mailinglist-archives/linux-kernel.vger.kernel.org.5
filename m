Return-Path: <linux-kernel+bounces-115462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F066889BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CA21F2655B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84CE21D138;
	Mon, 25 Mar 2024 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtWwjNsG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9A1292F1;
	Sun, 24 Mar 2024 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320854; cv=none; b=cejAPf6rr5dgfWHGugbCbWBLkTx8ALQsg8RcjnxdHJuzv2UjPZCW5PUpWK3I5Gcj4lW8h38UMbofyQOYxG3yx5zqi4H+DyzsL2R4O1dOsklQ5c9N5AE8jt0MdJXlmtJvbeSpYGj+Iu/ZIYGaD+PY4Qd3e2QTtUCkWmBqGsG/Fvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320854; c=relaxed/simple;
	bh=NqwGCkPP9pHP+VhbOXH+r1P5DCYuQEDtzt/Bgudxgh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJlH2701gmph1YfQhPvnrYlRAkjIer8GtxJXo/v5IdfUAW3WEh8L6pELcisQZ+72eOFTQKgPXdGDLQnC7ix+QgAeUM3y1of7wXUo9KPUbvsEqVmLJAZlt3bHYMgIwDblnQafFst2R41yedOpYMXmCchjSQSsg2Z03qcmF+0XuKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtWwjNsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516DBC433F1;
	Sun, 24 Mar 2024 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320854;
	bh=NqwGCkPP9pHP+VhbOXH+r1P5DCYuQEDtzt/Bgudxgh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtWwjNsGV7Z48i2VaD0LtqkbcNgSg9ax0iwzGpQ4e99wrW/0dIS2JABs4zsEQVJ5p
	 6mrtlVVff7KgY7FTvums3lOHRUDsSY8Az7E1Ilw+oSVnWnWpXi3yryuxP8S8Wkftsg
	 Ccdi0VCE6cRI90QjX0jEzAwSBhhEJLL1iZ4jzy2o8Lliz/glhEEuYaepFWfQuVeKtR
	 GjEm/mHbLpppAbZIQG21FIU9yVntzDgp+Mdit2PXYN0HX12ct55HsEE4lPxOvZiftV
	 Th0rAb6cEFGeB3Vdu8PxIkVG8lVnelih5qR6QUhK0fLiY4tCD1/EJMzhZ7m7a063K8
	 Gs1PdIrKwk6/Q==
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
Subject: [PATCH 6.7 418/713] drm/amd/display: Fix potential NULL pointer dereferences in 'dcn10_set_output_transfer_func()'
Date: Sun, 24 Mar 2024 18:42:24 -0400
Message-ID: <20240324224720.1345309-419-sashal@kernel.org>
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
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 1fc8436c8130e..2b3ef5cdbd458 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1834,6 +1834,9 @@ bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 {
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 
+	if (!stream)
+		return false;
+
 	if (dpp == NULL)
 		return false;
 
@@ -1856,8 +1859,8 @@ bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
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


