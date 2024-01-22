Return-Path: <linux-kernel+bounces-33240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292598367A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E30ABB28B36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B863EA8D;
	Mon, 22 Jan 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxG3Iup2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C173EA84;
	Mon, 22 Jan 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935472; cv=none; b=UnsRIqnRLsHCmAmXs7lWe74Qmxl5H2sXO51FTE/bf4CS66CruZDrBiVGET+i/W5QGnVKg8Jqnucg6c7yxmxTlMUGdR0/ejt2pZFmRo4HPdH8fRdr84gzt8VTsDjxDKD8BICkHS40/kbU6ZYocjE5jNW77Lb6Sq2Np67ldth5w20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935472; c=relaxed/simple;
	bh=WXssKxsGBsR/yKY6ti/K+rL0PFBq1lOYw7LKaLLK+1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mH/xWjUxANUU/1JmDN9MJVcBbNeGKPdip8qxz2WJ/B+TUnqVvRhv5MGr/6fSV38iEt+qOATBlvQyuZPNd7QoD2soS5tk15V85MB3wgGN3+AEdcSKhZD7bEpPfAFQT4qDa6KF4jdrTOvR8wWe4IbELGtKKpNZKxFqvePRaovhZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxG3Iup2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6ABC43394;
	Mon, 22 Jan 2024 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935471;
	bh=WXssKxsGBsR/yKY6ti/K+rL0PFBq1lOYw7LKaLLK+1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OxG3Iup2OvZbewgNU4jdbFb2lEU2qzV/5hnHF9sHly2BbZNBaBxvZM7GwaoM8supu
	 43t+hYRwg4EBpujiH4HwQKsiRDA/kk1U2jIdEbl7tHXteizpvdVKFxYn6UtMloruBz
	 +BFS7qcUD1U8BK5DHZuohn/KK8COML7zkbYsftRMyuiFKmfKO2i54yNfWB+4AoT48k
	 9Lq8dgCG5XYiKvaJizwtHQhFrGwpXElnAb+aRL3qcQPDTGzPsxZ08HSbsY2u2UUZsw
	 aRHWfBvsm5MQkmqc6bXmrZxyOwjSAswVQegZtMdAf3hu9ND1DjmV8uaxlRpIxD2kP/
	 KglYN5JzL8riw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alvin.lee2@amd.com,
	jun.lei@amd.com,
	dillon.varone@amd.com,
	qingqing.zhuo@amd.com,
	aurabindo.pillai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 22/88] drm/amd/display: Fix writeback_info never got updated
Date: Mon, 22 Jan 2024 09:50:55 -0500
Message-ID: <20240122145608.990137-22-sashal@kernel.org>
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit c09919e6ea5fefd49d8b7b54aa5b222937163108 ]

[WHY]
wb_enabled field is set to false before it is used, and the following
code will never be executed.

[HOW]
Setting wb_enable to false after all removal work is completed.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 4bdf105d1d71..5055af147c20 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -490,18 +490,13 @@ bool dc_stream_remove_writeback(struct dc *dc,
 		return false;
 	}
 
-//	stream->writeback_info[dwb_pipe_inst].wb_enabled = false;
-	for (i = 0; i < stream->num_wb_info; i++) {
-		/*dynamic update*/
-		if (stream->writeback_info[i].wb_enabled &&
-			stream->writeback_info[i].dwb_pipe_inst == dwb_pipe_inst) {
-			stream->writeback_info[i].wb_enabled = false;
-		}
-	}
-
 	/* remove writeback info for disabled writeback pipes from stream */
 	for (i = 0, j = 0; i < stream->num_wb_info; i++) {
 		if (stream->writeback_info[i].wb_enabled) {
+
+			if (stream->writeback_info[i].dwb_pipe_inst == dwb_pipe_inst)
+				stream->writeback_info[i].wb_enabled = false;
+
 			if (j < i)
 				/* trim the array */
 				memcpy(&stream->writeback_info[j], &stream->writeback_info[i],
-- 
2.43.0


