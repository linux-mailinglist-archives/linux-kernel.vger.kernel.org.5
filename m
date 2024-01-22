Return-Path: <linux-kernel+bounces-33466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF54836A02
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8649286528
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB4513173C;
	Mon, 22 Jan 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTPQJqRX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBA850A96;
	Mon, 22 Jan 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936408; cv=none; b=QszKZsDPnLWbAG+PIjV2+GGsJJA7VwKzGHcTBQTB9Rhs8yoriGuu1FFNjIygOEvlNNe1C3I35sORY12WXJyo4GM+BvMtvyG54lBRRr7aRqeQd+CN9yUuwmgGbV5BZGOIjgJQQZIJmdM+7zn4Ec1tAV2TLOkkiuanA395LMDitQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936408; c=relaxed/simple;
	bh=pcNuVs4hs4tO9XuJJi8Usm+s98V3K4PNGoABx/m+dVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HP+LYHdDwNlEU0VcU0cMgK/dnm9Giehbhui8VXxGX8u12pnnI8q0g4SXH0K1OxMYy6/kGygu30EFzJPwzqgn3TtpjuHM2QRIdMFIpBMdKHWadjz5qruM53cmgwomX1al/HwbpG0Eu5CgWAEVRGyjsqQOLyZKqHAAdT333j5Y6mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTPQJqRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41902C43390;
	Mon, 22 Jan 2024 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936408;
	bh=pcNuVs4hs4tO9XuJJi8Usm+s98V3K4PNGoABx/m+dVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gTPQJqRXeZR9iA+McgvP5/Lz1BZj4s8rppGQttVq6FmxZn2AUGBhCt/a/xjvqxd8O
	 gYC/YgpU104JC3XkSsnetHJv7iIyDqLhvBLiz4oH9WiTXJ0GyAFmn1xUklTg1zBTZ3
	 zhqpGgo1q71F0bcHVRP7GOjwJjV3i8eKmn4Ce5DbskWIw572umdXdOgGBwmyg4juAr
	 nQtiunCF1PbrPcfycT+BheCHdqLeIvobMNZIws3Jp8RWTDihj0dJ2DSdRG/mUC4FL1
	 KApOv58iPE0+k/PgWwXtox3nSl2UAi60om1WVSjhZa2SkG7TodMYJUtKH1hkeHX2zZ
	 cuaUS/g8+0how==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
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
Subject: [PATCH AUTOSEL 5.15 09/35] drm/amd/display: Fix writeback_info never got updated
Date: Mon, 22 Jan 2024 10:12:06 -0500
Message-ID: <20240122151302.995456-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 8a307777c36e15f38c9f23778babcd368144c7d8 ]

[WHY]
wb_enabled field is set to false before it is used, and the following
code will never be executed.

[HOW]
Setting wb_enable to false after all removal work is completed.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 5dd57cf170f5..b7b72fc2cb37 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -509,18 +509,13 @@ bool dc_stream_remove_writeback(struct dc *dc,
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
 			if (i != j)
 				/* trim the array */
 				stream->writeback_info[j] = stream->writeback_info[i];
-- 
2.43.0


