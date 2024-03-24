Return-Path: <linux-kernel+bounces-115967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6114B8898EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004F51F33A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A92C3941F2;
	Mon, 25 Mar 2024 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MevTwcKK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D914D428;
	Sun, 24 Mar 2024 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322252; cv=none; b=DDdxajE2Ek92Tm4n1SNgasfGpS4A8bHBT9W+INKAUOReDT/iWk88V4BcKXvD2dAooVVVgNYyAAa17ErAvmBFBy36mulsu5/FqnxaOzwZambN4j+fjy4vFKoIsZFuyra9MkE/++x/pAfdXJoIQxK8cnuCrRQFSF6LgR8pJLfI8Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322252; c=relaxed/simple;
	bh=s6ReMCLvAiRvCSUbLW6m4GlEr99CyHtOt5gTLyI1MrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaUxlgrDDXEUTjxndA933CVS+rUnLhEIwx/ukZkbeoSK1e0XZTgD1mG0K2yzrxub5kba64wRfFKYdz4EoeRi7KtOTuC2rELd8KWdngcEXSnnvzu5h8F2hNv0xZzjYuWbL8irDtXkjryj0i+dT+Q66MAcZz1/McV3HPG95Kyz6gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MevTwcKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8ACC43394;
	Sun, 24 Mar 2024 23:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322251;
	bh=s6ReMCLvAiRvCSUbLW6m4GlEr99CyHtOt5gTLyI1MrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MevTwcKKJ/g2Ebwa+DjdqMwrivpfYZim8oK3wFBkTdcTEDSOyCIStrkvlItv1e9fa
	 Qz6jubZS4BJiVXXg5aOaUKbSxjgsGRLEZr0TCOtY5gP8g0bTQouvlI69sKamghthyc
	 SDe+h3IQrW37O7zDzU7dS4n7/jPkdXGk9uq2ilwea/jZxk2IsI2yPPXEAT51Xspzro
	 WKPekycn9g5/DgoWH0IVaojCzU1y4inVWX5/mFWvKHAr2XBJZUGt4m+fgmU/1dSaR9
	 2DlrtuqB6DJjFx4CLQ/U4p7dCFnPuJpLvhvnYP91MAAE2r3ERqrLDnfEJJX8kgH00F
	 LwHfjnHmKfV3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paloma Arellano <quic_parellan@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 333/451] drm/msm/dpu: add division of drm_display_mode's hskew parameter
Date: Sun, 24 Mar 2024 19:10:09 -0400
Message-ID: <20240324231207.1351418-334-sashal@kernel.org>
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
index 09aeec00bf5e2..2baade1cd4876 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -257,12 +257,14 @@ static void dpu_encoder_phys_vid_setup_timing_engine(
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


