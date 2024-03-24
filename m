Return-Path: <linux-kernel+bounces-113399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46926888404
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01200285928
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC34C1A4358;
	Sun, 24 Mar 2024 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AW4f14tJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94881A4340;
	Sun, 24 Mar 2024 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320201; cv=none; b=s6QhVihyO1a2kIhMT0bsBqrRoXxMuJ/If+ME06e82g7bDBInPVPLQyDcVyGq8l9V4YHTt7g3zzvvytobnzRRuqkRKz54z36/Jt1cmwkn6FY3zhxqxXMJi6zdkTFXN+k7BbaCp3SW1rayb3wNoNmenANB89YqpolUM5nPfF9XtQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320201; c=relaxed/simple;
	bh=+SChueW4aiGDhNe28gOu9r+rnNWL+FfG6Vdr3Jg0dsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfXNhIIpKQi6riaHZQ5/tXyxvg+M/M31pgMpgAt8OXUgRLxFh1Ha9Wy/nHgusCcJtDAINzlPK4qp6POdU2IjzkEEm3mtTdhsHOvyWg1YxTek6JcCNDj6e0iVrSzi1+CYx2yK/5dGSCyS1J/EyVNNjeL9gXMWrh9NAu1EMdeMXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AW4f14tJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3608EC43390;
	Sun, 24 Mar 2024 22:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320200;
	bh=+SChueW4aiGDhNe28gOu9r+rnNWL+FfG6Vdr3Jg0dsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AW4f14tJvdd6lIU/jBMVXkZvIMQd3qWNF8YbSdtMhkbA0YXjgVYKy6ShkOLQe1nFH
	 +8ad4uk2tl2lXydSjms5lQegtAJNpDEoHIGdDqKiN3t2Vot2eOL6Rf/5e9xGFeHOa/
	 dtGvdxCe3xokUh2Yz6ePQu0Mg3N4JzUp34nvGOpp183GOsu8eqVnoS/QKlJ/8K4N8u
	 zWRq4Q7fdYU6SydG7CVw8xhXXLu+bFsJq7rRt2VpIdhXR54MtGgGbPMllOpPFBvfKs
	 E0KZLgTU+jIX4SyWzevZTTCdMNIaVGy2P0vyaVaRhQfdBXpzc/QI2bkhFhEJ8nv235
	 +8v4+tfNPNv6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paloma Arellano <quic_parellan@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 508/715] drm/msm/dpu: add division of drm_display_mode's hskew parameter
Date: Sun, 24 Mar 2024 18:31:27 -0400
Message-ID: <20240324223455.1342824-509-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index f562beb6f7971..f02411b062c4c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -260,12 +260,14 @@ static void dpu_encoder_phys_vid_setup_timing_engine(
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


