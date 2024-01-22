Return-Path: <linux-kernel+bounces-33414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEAA836973
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45BE5B2980C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268888002A;
	Mon, 22 Jan 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUErfq4t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F94D581;
	Mon, 22 Jan 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936229; cv=none; b=Z5y68/b9OHJl+OuYwrP4Z/6OSR704eYPVJgiYizK3JI6sSaUUgAE+kRmoGtLgP9IDY2UC8AjkJdFrhla9Ex8A3PZnzqpVmiyU7gVxNcoHJVFhb7gwAESRKP4QmfP7+RZT1A2PccbpFSu0kHvAMqNiMq/6WVn/SxywUs9jgzX4BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936229; c=relaxed/simple;
	bh=I2ttqNaYkWSONcBMr0Ex0KP1m88+0wC3Oik8zjvoO48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSmOVocfuI2bPoBvWcrkDFhqHISGHvq3NAPuoHRctKip2kUVPCNY0lFJAmWaPHSI+xedFPYvB5/oplTLaXXPAkok1/LXcEiHmRWRJ8VJFJ5IgAVYccVi11Yfe4FY94/9+u8u3O4GwpXSIAD9rpB8I6uUVan5mtDpfUEojn0zUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUErfq4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C55C43390;
	Mon, 22 Jan 2024 15:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936229;
	bh=I2ttqNaYkWSONcBMr0Ex0KP1m88+0wC3Oik8zjvoO48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUErfq4tpIH5YUD3KXDHn4bW0SPUrJz/p4JhKeTnZIN6n3KT4Gprw669xpfPBPF2v
	 5jnDYFzdB6tywv255WspXRWb/1Sq/s6nGKHUKIO1TRrtbZP+Tffm5pchaP8/ORG5fz
	 kE6KDslx2iMjM5XMZBXcxH3pbRNnLEXw02JO5ZnnlCUZjXgig/2SkFfZrZcjXnglwo
	 fwJPevsZ+zrM20Gya81/JCv6FyB7fFA+lh/FDg3yE6GtlFJlxDK8Wn2yM3NLnLuNGg
	 Uz15z1pHYIP7/0FUwC2pXal3061FIctwe/QeqVuXs2YCZD1Tj2MsSSivwxCRMKa80t
	 l2PUDKAprV4yA==
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
Subject: [PATCH AUTOSEL 6.1 14/53] drm/amd/display: Fix writeback_info never got updated
Date: Mon, 22 Jan 2024 10:08:15 -0500
Message-ID: <20240122150949.994249-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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
index 556c57c390ff..12b73b0ff19e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -514,18 +514,13 @@ bool dc_stream_remove_writeback(struct dc *dc,
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
 				stream->writeback_info[j] = stream->writeback_info[i];
-- 
2.43.0


