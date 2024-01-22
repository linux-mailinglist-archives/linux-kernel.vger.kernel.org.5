Return-Path: <linux-kernel+bounces-33529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCA5836AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D479A1F2544F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8C01474C9;
	Mon, 22 Jan 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EICQzMWi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C4656B77;
	Mon, 22 Jan 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936635; cv=none; b=l3E0QXwsFCtx2OYRgFnirncxNCe7DV6usWARCCqVTSfZA9XSRk9u0ZB0VXd/KhzHmJEkIGwkmTyaqoZPevECBsM7LKQuTKNQeDLExtr8U37r6jRNw2dm7J26lYdmld4hnx75LTNRyNAoQUG+zB2Cu6tG1NX+D7KSseB7r4yJDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936635; c=relaxed/simple;
	bh=TnjZ7Ng7xYs6ytnJmzByWcNLpqkTm7KKVDdG688zMBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUB0+jSUfg3+IS1wkIzo3899a3bgvwx33pwoAYcXC0jfVHDsEM830vs2O/KVm8kGKaN06QznX7NGJQSueD0IFXf1npcXoj9mcA/Io73AmsChVm756jr5wOl+ciSacS+W7UUWSyE0K9Wgytux+6Xb0rPQGqywWrNHxEaG7uJLYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EICQzMWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35290C433F1;
	Mon, 22 Jan 2024 15:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936635;
	bh=TnjZ7Ng7xYs6ytnJmzByWcNLpqkTm7KKVDdG688zMBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EICQzMWiz0qykBp+byeb6YvmGW0flXhkhjVeDv9pP4Sd+FmrdoK/5qgtUmkbBHk/Q
	 /6mKjb73n/evEv2A2MeExoR9C06c1aq9LQ7Oa8KR1LpfoapJrNSnHx5WZqL+tuKbox
	 M2zRARAi/w+f2X2OAYOx0BXXivxC4wuUHFq0ORVKBQ5NkWfQaHobNd+pac3IauXwnz
	 bTAN/UQQj8jHPbBeJQ23uARF0qrG4p/KKF0HZbXs/ZhllOaNTeacJPloBQzu1dwfyI
	 4FaHq5x8ADuwFSBbDWM8D2mVXyxQa3wuAVHsI+XWjh4sMqGKfeKSL4F8feCbwAgD8z
	 snHmhqMWoIU3g==
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
	wayne.lin@amd.com,
	dillon.varone@amd.com,
	qingqing.zhuo@amd.com,
	aurabindo.pillai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 06/24] drm/amd/display: Fix writeback_info never got updated
Date: Mon, 22 Jan 2024 10:16:20 -0500
Message-ID: <20240122151659.997085-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151659.997085-1-sashal@kernel.org>
References: <20240122151659.997085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index 71b10b45a9b9..6e2b7bb47f38 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -448,18 +448,13 @@ bool dc_stream_remove_writeback(struct dc *dc,
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


