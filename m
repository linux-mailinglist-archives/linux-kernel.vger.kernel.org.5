Return-Path: <linux-kernel+bounces-113273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E92F888301
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6F31C230BC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F618B5F5;
	Sun, 24 Mar 2024 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxmp3J1A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A4167A0D;
	Sun, 24 Mar 2024 22:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320074; cv=none; b=TCMclipQChhY60EoqjNEuq9JztZ4Lt+KcRDygAomUdHMTgNH79V+NShU/b48TCo2eSTbKtxbchqA/zO2ukvbtQz41yqYJ2mO3CFwjs33Zv0jE1+br7Stwhm5AYwM/r28OABmhG02OEctzm4/UWikiqyK3iqWhcsb3YiOS4CXe1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320074; c=relaxed/simple;
	bh=gtdV+/+x84K14c1XoNJ7EP3kgl/E7Qw1TacTh0JRCsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGc74D9AO/SQdbmdz8hy1qq2cc3w9sNzzDblEcq9gT6lxglG7h31WFLXCraiJw4C+I/8DoVBvzsTMedH6cVwBO5Bk/lSc8FlEh4CAr5AzsY655C7cJSK1V/NFSmZJaLz5agAa7bqR9Xzal4gcaSU4bXuN7j7QeRq6S6EgTWDlUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxmp3J1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992B0C43390;
	Sun, 24 Mar 2024 22:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320073;
	bh=gtdV+/+x84K14c1XoNJ7EP3kgl/E7Qw1TacTh0JRCsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxmp3J1AJvEzHSfiWimXFH0a9Em4D506vVVQcxrhtLzcU5Rja18KW8ZKFQ2KH3Rjr
	 jnuaR2tnrUa3sNK1ARDTLJaCTQ5szJ2C4n9hNOCgBle1Kwv2ZMeLP++0CU8TnmICWh
	 rQjJj9K8CDBo3tNPVbRIDMxJcSUV05/zOMkpDp6or+ypK4cCrJvioBqAkOjPBhuBxv
	 PS/TQ1QEBdco3AI1Y5eG7nMHzHbMz2kBXKZJ50d+sgxUZtI+sGfSBaEj1ZRLxHpS5Y
	 unMFKmDQ1JuU9rip6QNRosSniCfAX/OVMYA15r+oFrI/C3TgI3SrdJE/3iN2I3BugD
	 z3uqgBzj+AL2A==
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
Subject: [PATCH 6.8 382/715] drm/amd/display: Fix potential NULL pointer dereferences in 'dcn10_set_output_transfer_func()'
Date: Sun, 24 Mar 2024 18:29:21 -0400
Message-ID: <20240324223455.1342824-383-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 6dd479e8a3485..f614bc2806d86 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1840,6 +1840,9 @@ bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 {
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 
+	if (!stream)
+		return false;
+
 	if (dpp == NULL)
 		return false;
 
@@ -1862,8 +1865,8 @@ bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
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


