Return-Path: <linux-kernel+bounces-114547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80743888AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E8F28BD14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F0184417;
	Sun, 24 Mar 2024 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut6eMBXK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB022C66B;
	Sun, 24 Mar 2024 23:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322180; cv=none; b=kHin19M3Y8ArvD7ReVj35LUESq2UEuq5cZw00evElzGizT00JmJpq/ZyxjbEFRV2bCWAjjz5Jef3sd40VVhvrUqC8jh3FRVedTa6eW8Bbr3EHtWlCfA5dHUzh3yDX2ZFsGD91ONVdfaAJTIdtAL3GylYRCzU7bQ+H8EhHGQ5vjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322180; c=relaxed/simple;
	bh=dmbzaHsw8AdvHmr+fRwt225oJ3yXnRjo6i5xoc1eCYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SO04K6D6IaylEaCDEDJBL5vdn5963mxlWl74ip63M2sr12g2QnA4hF+KhQNMnerG7M1pvZRWTHqshXzKjYigzewDR+fWzhcIsFCC7hPwoqa7+egEuJEAe2DCn6uHKX+o1rW+zhICTPPXD2UPE+wl41K4UIoUMdg+ioum0lSbdTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut6eMBXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21C8C43399;
	Sun, 24 Mar 2024 23:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322178;
	bh=dmbzaHsw8AdvHmr+fRwt225oJ3yXnRjo6i5xoc1eCYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ut6eMBXKSUWo4vU7QwraoEY9q6VEJ61z3a5maPG0XsaQjOdLOFyNq2CPKqWefPjFN
	 +EsMtRUA+kkCk2rNyArSLvPK/a+eAy3sDWVNyq2BBqZF8Efnw7qxo6R0jVS7J97Xin
	 S4McAa6tVMl0s1tMpyoIsVF95WGlEJeKevSQSc8vUvbGJw4fYDQ0Yj2bKVxuYVOP9j
	 UM4RaM2u8JPIEdlNmsWtHHDIPKZHtxVxCbIEdL4RmOCr7L0tN2Mn7ulFPei8CBxiik
	 3uve1HJA2hEzY6FBZnKxrOtm+CEvmOEOeyIHPJVk2ut6fIrpueccAySt2Df6UzA6x5
	 OqD5NRyb52Tug==
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
Subject: [PATCH 6.1 257/451] drm/amd/display: Fix a potential buffer overflow in 'dp_dsc_clock_en_read()'
Date: Sun, 24 Mar 2024 19:08:53 -0400
Message-ID: <20240324231207.1351418-258-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index ee242d9d8b060..ff7dd17ad0763 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1358,7 +1358,7 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 	const uint32_t rd_buf_size = 10;
 	struct pipe_ctx *pipe_ctx;
 	ssize_t result = 0;
-	int i, r, str_len = 30;
+	int i, r, str_len = 10;
 
 	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
 
-- 
2.43.0


