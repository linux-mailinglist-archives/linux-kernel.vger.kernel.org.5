Return-Path: <linux-kernel+bounces-124718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A6C891BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A1CB26626
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5060146592;
	Fri, 29 Mar 2024 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGFmU6ns"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AEE14658F;
	Fri, 29 Mar 2024 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715981; cv=none; b=cEKZ0vIPBp0PgVCVBtCrPntqxVWpXOmEixUstWwfAaz+Pwzc209sjSqXMaYOB6+9hZclafTmTtrbL5Gb0iuxBC6JSGr8qbBHVsymVpfbSvYd/UhCGseMXmG8G2QVaKWrrctRkrD2J/Qek1OS9LNBnwBwH13gAdLR8wAFiqGQcgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715981; c=relaxed/simple;
	bh=o0vYGURicCJl6LD77hR9+V7iy5H2Vp0VhcIYqv++Vsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5cJc7Rr3nXOvN6Vv0a3X+J1NT8W78EFxYqQjTUn7YkmpRxfSQRkhvdnKv5vHFhyfV0wIKO6C4ycb3RWixnQT7rN8FIPE2iagnTrvHuk7d8sdxBhaQvw7JlOirfCpoVsiuC07woCdBBsNZjbpAbUGhB2ZEn/t0q6k3OrV6W0NVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGFmU6ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438F6C433F1;
	Fri, 29 Mar 2024 12:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715980;
	bh=o0vYGURicCJl6LD77hR9+V7iy5H2Vp0VhcIYqv++Vsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGFmU6nsxW+7tC9te865N80bWdQAHGcVHc/mCP0zs+TivNxPbNDPTyNXj8i2RFpCh
	 ax6KVmAUk1hNlTJTcK9Ox/Nkv50ogs1CfyR36zZEu1ZvafoRbCrqbhWukirVuRVvR7
	 RxAn4bEmp8z36dYiqdQGbe/94vS9j6ixHNcrCB6aZ3o4ir0nmn8KsOfZfPTYNeqDIG
	 7tFnJKuGi7DRWAwdbNRk1yU/nxfdo1VzYiTFz8BNmFBLAR5x3QXoyQAHPV0C7x0Fux
	 xYHih08USOtoPmfFxdqvfAx5loIzSrl0Ts3WMNjsCYjF6Y3mVLsb7NoPwmRIu0nOci
	 AVaSkNScWwwCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sohaib Nadeem <sohaib.nadeem@amd.com>,
	Chaitanya Dhere <chaitanya.dhere@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	jun.lei@amd.com,
	wenjing.liu@amd.com,
	austin.zheng@amd.com,
	Qingqing.Zhuo@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 09/98] drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz
Date: Fri, 29 Mar 2024 08:36:40 -0400
Message-ID: <20240329123919.3087149-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Sohaib Nadeem <sohaib.nadeem@amd.com>

[ Upstream commit d46fb0068c54d3dc95ae8298299c4d9edb0fb7c1 ]

[why]
Originally, PMFW said min FCLK is 300Mhz, but min DCFCLK can be increased
to 400Mhz because min FCLK is now 600Mhz so FCLK >= 1.5 * DCFCLK hardware
requirement will still be satisfied. Increasing min DCFCLK addresses
underflow issues (underflow occurs when phantom pipe is turned on for some
Sub-Viewport configs).

[how]
Increasing DCFCLK by raising the min_dcfclk_mhz

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index a0a65e0991041..ba76dd4a2ce29 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2760,7 +2760,7 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	struct _vcs_dpi_voltage_scaling_st entry = {0};
 	struct clk_limit_table_entry max_clk_data = {0};
 
-	unsigned int min_dcfclk_mhz = 199, min_fclk_mhz = 299;
+	unsigned int min_dcfclk_mhz = 399, min_fclk_mhz = 599;
 
 	static const unsigned int num_dcfclk_stas = 5;
 	unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {199, 615, 906, 1324, 1564};
-- 
2.43.0


