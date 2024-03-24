Return-Path: <linux-kernel+bounces-113821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD7888E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517461C2B35F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25169130AF3;
	Sun, 24 Mar 2024 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep47OYaA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718041DB087;
	Sun, 24 Mar 2024 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320851; cv=none; b=QDzazybxYoqn8Ge/FGIkcSP/1+KdbTOkWp/69NmxotKL1vsLfFUZUliCWudNkq2xaccP2VIgMQXRhOv/XDj5XdF0iW+evuXbhlbgjrd57OtFxE38NyetR0Gvbbikd5RLxqihnlVTGmK9o/P8T3E+DcoYExq3MucGp1jwkRcSxXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320851; c=relaxed/simple;
	bh=2xVeTehfVDyxoTKFCXcy33KAjVDc4xn38/mSPSwJRCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qS5DGfHJUqQYP50G/QJi1+8/6Dt05fcQE35Lsxy336ogd8RODGJFq50Wq1d8zp0DTWgMYQV8PkYwXxE297DV0tvHSyxV0UeIY57MbL/VqG2FOfu9QcsFZhTMrC5aULFIp+4+aIxS7K+cl/ySx2e7poznQhxNY5MrP/HdWIq3AUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ep47OYaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE32C43390;
	Sun, 24 Mar 2024 22:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320850;
	bh=2xVeTehfVDyxoTKFCXcy33KAjVDc4xn38/mSPSwJRCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ep47OYaAw8Nhn56BU+Tj38OdznWK67HERrrZRa4xTHtNZ+cHcsVxh1DJCIUDUvcA6
	 lrgxJdfPc6M3Nd/fRnzDDyddSht3xWbeWjrjc2dQfy+xvW7R3CdBpD0kniXO44X/F7
	 FcvHwuGRL11s/l8ZJvWTVYkq6d7EQqGjyOiKHT/rEX+tqfxMvEeuag2ZRq1yHlr29k
	 Q8RwEmIuaLgw/tnZ3xswJJRbErzWkYdXbMn2ny7qTmU+VUAdW9Q2vaimRfDqXZF1rM
	 qBrQGvffCQjPRrplD5BTDBn4gkR/Fn3FUV7LHEdBD3U9z8XBa8D0eIdGgNE/5QsoVk
	 oJBv3EEpC7Z+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Qingqing Zhuo <qingqing.zhuo@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 415/713] drm/amd/display: Fix a potential buffer overflow in 'dp_dsc_clock_en_read()'
Date: Sun, 24 Mar 2024 18:42:21 -0400
Message-ID: <20240324224720.1345309-416-sashal@kernel.org>
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

[ Upstream commit 4b09715f1504f1b6e8dff0e9643630610bc05141 ]

Tell snprintf() to store at most 10 bytes in the output buffer
instead of 30.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1508 dp_dsc_clock_en_read() error: snprintf() is printing too much 30 vs 10

Fixes: c06e09b76639 ("drm/amd/display: Add DSC parameters logging to debugfs")
Cc: Alex Hung <alex.hung@amd.com>
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 45c972f2630d8..417c9cb47b89e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1483,7 +1483,7 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 	const uint32_t rd_buf_size = 10;
 	struct pipe_ctx *pipe_ctx;
 	ssize_t result = 0;
-	int i, r, str_len = 30;
+	int i, r, str_len = 10;
 
 	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
 
-- 
2.43.0


