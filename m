Return-Path: <linux-kernel+bounces-33290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6FC836801
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479F328BCC8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77DE41226;
	Mon, 22 Jan 2024 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUFrCnGn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A355C90B;
	Mon, 22 Jan 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935641; cv=none; b=TGf2IWwcvh0RyXVKlavIU97LNgC0TBlYQEM5dkOepbu18usuEhZnLiOpsoRRgTrzmpOfPCJhLhqgEe87sEkvRRIrQRZ5VdjfipbStbcHu8sCpm0/496KtZv7otSnH887rFGyGuLFOpUiuVzwG4ASYLWlizbNlOD5cErG+m0OfKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935641; c=relaxed/simple;
	bh=TUaHewwRDkOKCmO6wFsLmMkfHc9ooD1imeaxcYUU8qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MX/vVdTYrVAfhQWRYLxk5Rksga866SijilxaDsuByrD+bOBItSU3qie3RdFvYKRB9t5ZBmMx//T+yEXSKtdT30rPT3mkPY5S/cKE2mNvqL08htvD6PGmSFy4gqlDLrVP9PB5KRylLxmjXPljHqi8OJWfmKPwVvopZ1nUwhj8cks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUFrCnGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CF3C433F1;
	Mon, 22 Jan 2024 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935640;
	bh=TUaHewwRDkOKCmO6wFsLmMkfHc9ooD1imeaxcYUU8qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUFrCnGnpX4f9l6PiLAM5OheuDqT1sEBLqO68oqaq3nJgdIvqVS8iGzzMIcs0IWXO
	 ff+fkFnzy8Exbc8R1uWb7liWT+wDCfaGvHgEOVQzuKD+jHV9FL2OExo+g4OAw8WOY3
	 b8YUP3AsSJ7lkNUUcXh4FoPalPq/iSTpIjlXiTmjvcCCwj43yARMft9f4vucrlvELC
	 jpwk1N3XyzPvO1CdQ2rfQc4TWs8wt9XFKxAqDq6Chh7D/0hW2krY4dNH05D3H1U4TR
	 77/ZV5Ed4x1tYB2CtsDAWRhjdBOlIWBl0YeSspuwo2imyrF4dm3jOvd6rf6PaUQ4J6
	 zMC2XHnFh8CFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Strauss <michael.strauss@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
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
	Qingqing.Zhuo@amd.com,
	sungkim@amd.com,
	syed.hassan@amd.com,
	gabe.teeger@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 68/88] drm/amd/display: Fix lightup regression with DP2 single display configs
Date: Mon, 22 Jan 2024 09:51:41 -0500
Message-ID: <20240122145608.990137-68-sashal@kernel.org>
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

From: Michael Strauss <michael.strauss@amd.com>

[ Upstream commit 5a82b8d6c05f9b30828ede1b103b9ee5cb5c912e ]

[WHY]
Previous fix for multiple displays downstream of DP2 MST hub caused regression

[HOW]
Match sink IDs instead of sink struct addresses

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 2498b8341199..d6a68484153c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -157,6 +157,14 @@ bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe_ctx)
 {
 	/* If this assert is hit then we have a link encoder dynamic management issue */
 	ASSERT(pipe_ctx->stream_res.hpo_dp_stream_enc ? pipe_ctx->link_res.hpo_dp_link_enc != NULL : true);
+	/* Count MST hubs once by treating only 1st remote sink in topology as an encoder */
+	if (pipe_ctx->stream->link && pipe_ctx->stream->link->remote_sinks[0]) {
+		return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
+			pipe_ctx->link_res.hpo_dp_link_enc &&
+			dc_is_dp_signal(pipe_ctx->stream->signal) &&
+			(pipe_ctx->stream->link->remote_sinks[0]->sink_id == pipe_ctx->stream->sink->sink_id));
+	}
+
 	return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
 		pipe_ctx->link_res.hpo_dp_link_enc &&
 		dc_is_dp_signal(pipe_ctx->stream->signal));
-- 
2.43.0


