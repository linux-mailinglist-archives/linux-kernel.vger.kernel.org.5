Return-Path: <linux-kernel+bounces-114838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E0A8891A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561D51C2D5D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2787D1BB06F;
	Mon, 25 Mar 2024 00:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wwzdg64J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4063C279888;
	Sun, 24 Mar 2024 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323475; cv=none; b=U4//GtsamgHA1mEgoUO5Vc/m/HCm7Upl1ZVchjfJBlGKK5VT2oVOUXlMiGeqXhwCXzKC1gT006wqx+zM9s95C72GHa2tQdiu8AJv7LvefMjvjK7pb3p4BhMZ3SPVcOyvmw4CXj6YXCGHP+WRz3ZJ013/dEa/O1GOEyXlhEm3NC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323475; c=relaxed/simple;
	bh=gOm8QUKYEAL5SWFQcl/aDpAeWskFHl4skoIU8sTcPuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mM7O6tooQIXszIuGOA2n8zcOIs4X6EuNmgvO1yTPE09k9H8YdNuVS2bcPEFm3S9zOpUFT7FWEVXMadOSpgKD5w6iKRRVy5ggZipQHezd0lUGwYTytfo5ezaeBJRP90fg/qIOr1f5Q02Mx/ZETJtNeSQqZF7OBJACEHNvQbog2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wwzdg64J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A06C433F1;
	Sun, 24 Mar 2024 23:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323473;
	bh=gOm8QUKYEAL5SWFQcl/aDpAeWskFHl4skoIU8sTcPuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wwzdg64J+nz9Q1wBrBZSRXDkYzCWMZhLcbW0VmLIynRCZTaSCX8SHJoJZ12l94WdC
	 cyarzKOGwG8GM/W+lYOqgwZ7BqroR1u0f01E6aEeb5UG7dzhGvlzquJkG0xvxunEHB
	 hZqnhvb3y5qwsvfF8flsslWBunL++1HXSL3//GJ6PW+ruNlra1EYO/2Aa/gUiqWhhB
	 slae4MwxwlYjktil4/uDV/P56DJcGk2Ipkfwa67XHnGfGNCgAKwgBCeb40X5b4r1Gz
	 G6eZElQs2lCIoZpPtU1PYzMmqYyXHgtT8XBoaz9PW2p05zgccr5XR+JRD2jmfaVOTF
	 VgNBAQlxbm0hQ==
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
Subject: [PATCH 5.15 178/317] drm/amd/display: Fix a potential buffer overflow in 'dp_dsc_clock_en_read()'
Date: Sun, 24 Mar 2024 19:32:38 -0400
Message-ID: <20240324233458.1352854-179-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 6d694cea24201..ed2f6802b0e20 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1304,7 +1304,7 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 	const uint32_t rd_buf_size = 10;
 	struct pipe_ctx *pipe_ctx;
 	ssize_t result = 0;
-	int i, r, str_len = 30;
+	int i, r, str_len = 10;
 
 	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
 
-- 
2.43.0


