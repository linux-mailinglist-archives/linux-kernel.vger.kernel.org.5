Return-Path: <linux-kernel+bounces-33337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB21E8368CC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E8BB25044
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07A6482E5;
	Mon, 22 Jan 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahZR+xRJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F7F482D9;
	Mon, 22 Jan 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935924; cv=none; b=Pl4/GiB+sA8QHQKvQmiu/e/s3CsRDS17tX18xf1fTwqbTPkzSHZqM2BwhoNRbRjsxgjscVz73DrgSkHImVFLDO0zpddS6pJP8Ly7vXaYByYN5lJkTLcIbwPXYqz44QRc/Zmgl/28YVPRB2drqutH5fPzmT13zwS0aylD5mo+UPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935924; c=relaxed/simple;
	bh=MjgvzQoYIT5tBm6Pw3QBsMi9YbSr4rTJjeC1r6LJDLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t70wrfUMUYWB+OwGJ6FpxlCA/kSIb/fwE0zHZz0mFxJkg7bjdnZE1m3WwubDNy9K0pc+4Tq5C7yJ5y+rb7842BN+y2JADs6HjNV5Nn/agNTwc2Z95A94GrkfLdPoVgRdKYd1xi2SkdOFTRyJw+vbUEUH6SZ1186+TiGsAvGk9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahZR+xRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80D7C43394;
	Mon, 22 Jan 2024 15:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935923;
	bh=MjgvzQoYIT5tBm6Pw3QBsMi9YbSr4rTJjeC1r6LJDLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ahZR+xRJGgP11hSXng54cxi0GBoiI+wZqf5aoiL5syvKZZfBvbwXs6IvCD5aQjJ2A
	 PZHvYQEtlNIgc3wnDyHjGaQz4ZR51MG4VxLyB3wCbrgjkNHbKqFKNRpB9R6kjTlNLM
	 RP/lbfMd1hQXiDeM+2LNm4CwI+LEKdsL+SVLaRQOEv0z8hOYbgccxqSMe6O+f3rvem
	 +w7EPxZixHEu0niX4FgrRmb2M9qqL67ua2LK/JdDDvoY0usPqZJ4Y7FA21B6bLR/BO
	 qI157O/iOGUOYSQJ8G6fC4vjiMq1OWcOxPqy5l9h/qY4xtbGi7Kv/QvxG3eMMJ4WT2
	 FNXb+/sMSoHlw==
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
Subject: [PATCH AUTOSEL 6.6 16/73] drm/amd/display: Fix writeback_info never got updated
Date: Mon, 22 Jan 2024 10:01:30 -0500
Message-ID: <20240122150432.992458-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index ebe571fcefe3..c232d38e70ae 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -539,18 +539,13 @@ bool dc_stream_remove_writeback(struct dc *dc,
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


