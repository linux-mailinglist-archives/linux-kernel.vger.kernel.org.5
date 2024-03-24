Return-Path: <linux-kernel+bounces-115137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6008888D64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560D11F2A272
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B15300DE7;
	Mon, 25 Mar 2024 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iP6AXD2r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9FF181D16;
	Sun, 24 Mar 2024 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324147; cv=none; b=dnO5MdBGYlJ06MqvEg5n1ADYWGFAsUg4CRjm4fSd7kFlTYI4QXtgiLN9YkJ5PdA0FTAnUjvbFb2d0kj8FQim7slAZpTp6f8vXnGadQJdgAslm3De7fweKk06PTY4FfF6TMx14+jOt1mPQ5A8Se5PH08CEiMFx0FOgMGViW/xTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324147; c=relaxed/simple;
	bh=GasxbuW90lsjKa6WhOQETR31tGoaeHe/4jBfXK0euBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Al3GCg4/4Y7rFXZdTlp2yiL9V5QlZHiitjU30x87LIH/wMFaV3IqHjlbL4gWamQtSU+yO3G3d2r+3gRteJKTkX+un7SJcvKYprZjciRfmIOPgUEeX6pTHix4NLk9x2kvMvppjPYJVrHgADCgnT7cZZ2y7y7SHJ3W+JK3HqNjaqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iP6AXD2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25E0C433B1;
	Sun, 24 Mar 2024 23:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324146;
	bh=GasxbuW90lsjKa6WhOQETR31tGoaeHe/4jBfXK0euBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iP6AXD2rsttIVqdE/5Qq4NuGdb3Id++3eK9ob+JZGX9Ynd5rZYuM9/uJUVHlDYVkl
	 3mIdxHjN5l60XL6rTwoKCphKUnSrh5FFXijukLRt1OOBifiA99YRiH0FiERkjY8q99
	 RD9QQhYsZDePNqn7CF28sEst2cAr5nLRD6bFsANWiIaGNU1czCCtQ3K8aL2ZbrRo6J
	 OQ+h0vJMADaJpiKW+Qo+C7VtJVaPWJvSXnSOHkYfDoZvRe6XbSNrXGkBqnXZBwao1B
	 3MDDV6vanxGpU/9ayccH17wrOF4uC95Q9lyX5slN6BTnF5F65l8O7vgKCwnGA3j3uu
	 RLE1dxj8lDslg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paloma Arellano <quic_parellan@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 142/183] drm/msm/dpu: add division of drm_display_mode's hskew parameter
Date: Sun, 24 Mar 2024 19:45:55 -0400
Message-ID: <20240324234638.1355609-143-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Paloma Arellano <quic_parellan@quicinc.com>

[ Upstream commit 551ee0f210991d25f336bc27262353bfe99d3eed ]

Setting up the timing engine when the physical encoder has a split role
neglects dividing the drm_display_mode's hskew parameter. Let's fix this
since this must also be done in preparation for implementing YUV420 over
DP.

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Paloma Arellano <quic_parellan@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/579605/
Link: https://lore.kernel.org/r/20240222194025.25329-3-quic_parellan@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index b9c84fb4d4a1f..311863a05a6fa 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -258,12 +258,14 @@ static void dpu_encoder_phys_vid_setup_timing_engine(
 		mode.htotal >>= 1;
 		mode.hsync_start >>= 1;
 		mode.hsync_end >>= 1;
+		mode.hskew >>= 1;
 
 		DPU_DEBUG_VIDENC(phys_enc,
-			"split_role %d, halve horizontal %d %d %d %d\n",
+			"split_role %d, halve horizontal %d %d %d %d %d\n",
 			phys_enc->split_role,
 			mode.hdisplay, mode.htotal,
-			mode.hsync_start, mode.hsync_end);
+			mode.hsync_start, mode.hsync_end,
+			mode.hskew);
 	}
 
 	drm_mode_to_intf_timing_params(phys_enc, &mode, &timing_params);
-- 
2.43.0


