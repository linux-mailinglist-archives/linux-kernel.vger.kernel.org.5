Return-Path: <linux-kernel+bounces-116175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C15889A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4050D2A8AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D62228FED9;
	Mon, 25 Mar 2024 03:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CurqQ5Pd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A5C17BB18;
	Sun, 24 Mar 2024 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323754; cv=none; b=gC0mbQVPWEJ6XImW2+hVBftxkVDSlkOj62uY+nZOL2MEQGGtGoteEDVUUD5COd9CvSFkcu36/HLMsM2fadEzKle7o0hNbhsK/N+gvXWUTmvX8yxlZ1Am5fHbwrn4jXYIn5/LvM42q7KQz3GiHYHpfbG2rYjSxYPe5B1OWVX/LUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323754; c=relaxed/simple;
	bh=dfcRdPeTUVayWJRGEkGDb9i9+Ny8gRfj+JhkWtSCsHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUiCfcACHV9Fsxrj2FTaAZcW5a/Bf0IQXIOBCzLFsqEufhJB/xxVbmGzHrSZlhv/4vxQlQp3k3GYcTC3SX9Z/4i4vPscsDWAaIZrUPkmAXGzShrkpI6ZpQFJ/6kcztjwUmCkZ37RnDGtBSSBjoJxmjNcPwjy3XJbbdwF4UsJp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CurqQ5Pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C32C43394;
	Sun, 24 Mar 2024 23:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323753;
	bh=dfcRdPeTUVayWJRGEkGDb9i9+Ny8gRfj+JhkWtSCsHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CurqQ5PdV6Y8vVDCoXVTmsBQCOztTtJ29Nqw4ptDo+CGda6wzBpePDBy5P9sHAy8q
	 GiuvuysI3aIbQ9/oFCXF78eFaqtd9iDScnnhKwhbphPFFfV+a0peMs8K0Mot2w60Na
	 c+H1dh63361JEr9Qgw46BSJnUtTIJS2c6wtcfzDDXFEb4esSDxL8vBPyNihRuqfNp2
	 yO7gmxXsRktmrYIz/sJ3TgQsawhfa+u/kimyxvQedujChDzyAEfxHF4CcgNgoS72z0
	 xMaRxf+8R5JIodVoWvhXp8DCRvi+/fcfHKWBuGHj2+irMhbrm+K6kCwnwN5hW0p7Dl
	 IDhQMDFjfPbXQ==
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
Subject: [PATCH 5.10 128/238] drm/amd/display: Fix a potential buffer overflow in 'dp_dsc_clock_en_read()'
Date: Sun, 24 Mar 2024 19:38:36 -0400
Message-ID: <20240324234027.1354210-129-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index e43f82bcb231a..32dbd2a270887 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1179,7 +1179,7 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 	const uint32_t rd_buf_size = 10;
 	struct pipe_ctx *pipe_ctx;
 	ssize_t result = 0;
-	int i, r, str_len = 30;
+	int i, r, str_len = 10;
 
 	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
 
-- 
2.43.0


