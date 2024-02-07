Return-Path: <linux-kernel+bounces-57133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A33684D459
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECADF1F247DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE877151461;
	Wed,  7 Feb 2024 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmdKDlwU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CBE130AD0;
	Wed,  7 Feb 2024 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341067; cv=none; b=DqCUX/qHpVoTdUbAOAANwAB7loPleaoV7UZmmBmOgb/qGCIlPLNNI+RP/yITcYcUS9wTxgojXcNtmh4ouze9MguG+TbE5RAXFC2/FkKwdSjChzzA8NBFboAqkVdIyH6PFnKOmEblulpMEsJy6wlhgb4rSmDM6Bj7KNJLqUgyOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341067; c=relaxed/simple;
	bh=eF6PkzLfMq6ovPLaVASZedyBzGw+GeqcXaeDHsf8bmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOdfAR/9wY0xzAJcnM7APvn/mMDh75OutiCHP40uadk9TA3UpbS1ENKB9lOml3iQjcXfWiFKHzegkbBKhcXyj0BeBjA9SUJt51UXaxYBieZsdQAcJx7EactXKy5qyBIvU7YZb0J59SAHdhxKT5dG3RFeJ2mb/iLFLtFQTHf+iyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmdKDlwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8F9C433C7;
	Wed,  7 Feb 2024 21:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341065;
	bh=eF6PkzLfMq6ovPLaVASZedyBzGw+GeqcXaeDHsf8bmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmdKDlwUfC6nWkxwLLMjkBqtSR+8VhNuqX0pdEdt5oWh66oZKqothU+jTZVkdzHYD
	 7R5a5eDdXT1trFQ9NHEIo2Cz4q1EN9t2AoFsZ8FPF+B53BFA9OdfYZAXftBNPgD5Z3
	 GyR2B7jOx9dCNLPpxIOXfUUEJxKO7oRF0RwF7uYgPEI6KCr1bLJWVSYCYlEO+bdb0J
	 WHrcUOcY8fW8iTxnnx+ISWRcr3oTIGQL92rAUjpxhZvSd5cHTe5GlFrL9VX5F5rnWG
	 ywavKsBiYzYFlPpMqzHlOeBVRDzL9lP5myX/OHI8x+NUcl9QSwuelJ8b1dgaIXY123
	 wzHQFol3x32Jw==
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
Subject: [PATCH AUTOSEL 6.6 23/38] drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz
Date: Wed,  7 Feb 2024 16:23:09 -0500
Message-ID: <20240207212337.2351-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Sohaib Nadeem <sohaib.nadeem@amd.com>

[ Upstream commit 2ff33c759a4247c84ec0b7815f1f223e155ba82a ]

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
index cf3b400c8619..ec09d5a8876b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2452,7 +2452,7 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	struct _vcs_dpi_voltage_scaling_st entry = {0};
 	struct clk_limit_table_entry max_clk_data = {0};
 
-	unsigned int min_dcfclk_mhz = 199, min_fclk_mhz = 299;
+	unsigned int min_dcfclk_mhz = 399, min_fclk_mhz = 599;
 
 	static const unsigned int num_dcfclk_stas = 5;
 	unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {199, 615, 906, 1324, 1564};
-- 
2.43.0


