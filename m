Return-Path: <linux-kernel+bounces-115025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E314888C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEF91C2A163
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4681C17F6;
	Mon, 25 Mar 2024 00:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIsHpqcK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582917C6D9;
	Sun, 24 Mar 2024 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323802; cv=none; b=t4JQV2rd9nkyMNxOVj7ArhcripbBnwjjuqlpQlG50bDeCATfQbdQ1uI+CtYg90/qagMX3nTMD2Itgu3qdTlsobx3wp83ISqxWyddS9UMwwStWm1AbOjQzNaHf7W/DemE4CprXCJGpMaurxiYKybUwjJwXVKbNX4gsW1msBUhYfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323802; c=relaxed/simple;
	bh=ljODnJprINJouMOUr8OzHtLvij5iu2kW/2nFcfMeJ7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/0l+xjfhdqmi5bCO+SoNuObCRH36js20NBtxeAlxJx+eCODbVRhBbSAOAo3ty9irz0bcgmMo4WYC+5MQrO1JWX0s6xNygWVyrTM8tjVxQ00OHB/1ZxxEbgGwDcnrR26nattEUcKv/Z/NDG6bFln4tCYaRnunFdx+IOIFHfuJ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIsHpqcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CDEC433A6;
	Sun, 24 Mar 2024 23:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323801;
	bh=ljODnJprINJouMOUr8OzHtLvij5iu2kW/2nFcfMeJ7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pIsHpqcKNo69LmjozyN9ZLy+qWIGeX7Qm5aWqgPxnMw45Baa+USU4hO+vYTdIz4r9
	 6o0yDsFkbC+cAE/teXlJo4IbZTNI5hTWztBNn7uDOs3zz/mEz2BfKfh1QUz48sWUnx
	 hUz6jmiod05GXEs3ruBNcabeA6Wb2wfvVHkZvi11zM7o2O6j8vHMQPOGJAEPVFE33A
	 odwF4DrToAmnSewYoWCrxsTpLTS/8wLYzKx8bzGFPGtHaqzGjfroKA440E4v03Z2nP
	 iqAqGtbT0y4ZbGmh/6YbEUb7KlxviiIsFjUqFkoSPe3hRjO+Gj1hgu3TVQnRBbpgFO
	 aUL6knntn/Psg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paloma Arellano <quic_parellan@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 179/238] drm/msm/dpu: add division of drm_display_mode's hskew parameter
Date: Sun, 24 Mar 2024 19:39:27 -0400
Message-ID: <20240324234027.1354210-180-sashal@kernel.org>
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
index 805e059b50b71..33880f66625e6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -265,12 +265,14 @@ static void dpu_encoder_phys_vid_setup_timing_engine(
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


