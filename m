Return-Path: <linux-kernel+bounces-115692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05695889716
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF08A1F2D6AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8351F35ADF6;
	Mon, 25 Mar 2024 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6xwOY5/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441191EC4D4;
	Sun, 24 Mar 2024 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321639; cv=none; b=q27+AC32kB7cB6NCdSTiAfjpKNaDOrgFVO53Pusl/olw/CMwiSDQjFQgR0T2VkualzsrshFsovxw2hZV2pZAyDuipBtgZ6bTWrR57pZSinHwwvYBHOTmmrDqatW/L7h4Q5im4nUWhZQW0IFd5TuT99UoGqtzL9FOSbtZ1h/upSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321639; c=relaxed/simple;
	bh=smIg7cRutQ0mZZiJ6ct3Gj4qAu74BxVNBqt3oeOmSX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqD5E/iPCDvmya6tcMVITbdZhD8sLo4wo1yVB8coDh8G0UHxEl+TJpUzW0lolX9vvROlXfc/vA6n7UND5oJ+ND8LU7WMRsTtu6nVDjYjduYrM/GT9k2kcXKLaGU5LtwcE/H+S6Xxxem2ZAKWiKvFBLhyRlzgUZAwP69yprAoYrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6xwOY5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E328C43399;
	Sun, 24 Mar 2024 23:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321639;
	bh=smIg7cRutQ0mZZiJ6ct3Gj4qAu74BxVNBqt3oeOmSX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6xwOY5/OHM9CUAVH+4ccSJNH0TCxcWPhKmY9I1jnujRdhKzlay/pcRR5cvubzK86
	 q1T58USjDabHTyOjX2bHfAX013GEXu26QHKIGdPBPL0BFU3/9y2y61DMQR4Y4YRxwy
	 TY6JAB7v2Jvq+kS4DuDwhaez77898EmdH7oYykUjo/E4MxhMEjZL9vTujHz5O+UvmJ
	 etrTzKITLK3nX2X58yKiU+GF9bD/x0EiFKVmdEJ8NoCv5dw5sooTbtgLm4WNz7xSR6
	 9AfWaZbex605rfOabQ8mSCo6vsUyClNntoSUMRBTQ1PZLZSbvI/2fxOeJRvDXv7fsQ
	 O6iitno5CU3qw==
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
Subject: [PATCH 6.6 369/638] drm/amd/display: Fix a potential buffer overflow in 'dp_dsc_clock_en_read()'
Date: Sun, 24 Mar 2024 18:56:46 -0400
Message-ID: <20240324230116.1348576-370-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 7c21e21bcc51a..f4b9d43c5d979 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1453,7 +1453,7 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 	const uint32_t rd_buf_size = 10;
 	struct pipe_ctx *pipe_ctx;
 	ssize_t result = 0;
-	int i, r, str_len = 30;
+	int i, r, str_len = 10;
 
 	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
 
-- 
2.43.0


