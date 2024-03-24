Return-Path: <linux-kernel+bounces-115712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883F1889483
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7D31C2F2D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FC435F569;
	Mon, 25 Mar 2024 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKt708X/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C7721592C;
	Sun, 24 Mar 2024 23:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321750; cv=none; b=ht3IoAM5rUSTEcRgl7IPdDw130WEZe/T/zW/85o4AJp1fzDXXfrcB6vK33a2rud8Yw0JYm17v5MAyYUlqQRSdxPI8JEUnAwjvi6ZQXrNxuTyhHUuOrgyJSV8WE/BY6NzKWe5z7SIDOlNsxmqdOocStTcQowp2s0NzZerrlRBSq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321750; c=relaxed/simple;
	bh=XBZH04MyonTga9mdAf67jwkN7tm6Zud8jwE7ugfw8/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRQ4br77cmugxmKO/J3kFXRyLy7Kl1+BBlSdLb0yL5AMkpmG7Y3MTkvdz8hybpjX6sGgZv809OLHCL2Yr/+CQ9XWGmq8CxJzf3dlITLTTnx6eX7d5G6vlq3/NN817EKfM6H0iGluE3km9EHa2ZdByRMO3w6KO9cwAVHAAvfXdQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKt708X/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00141C43394;
	Sun, 24 Mar 2024 23:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321750;
	bh=XBZH04MyonTga9mdAf67jwkN7tm6Zud8jwE7ugfw8/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKt708X/A7BbZtOmqQy37KAggg8msPvrCNr43O/NrwGWn/QoSbtArpb4g/cHxUSyQ
	 MaCWBx0Wu1m4KKnbckRTETeHEReM0a8V9e6yGhUZkKF9w9Obf+xem6D1ki0zAU/mtB
	 RC52PpxQ8sd13B9u/aV4YzGWlQKOxr1/7wYDp+f6YAhxHHhmlK68MVtSRFl39XKpb1
	 XFkbZNqChkolBJv0GqFoBk+VZKGNNmH1K9nsxU0oqwhExpVwpby2tZyT8CPkRI8if4
	 3Vj9kD7/F+lLEpTsNcrd7RZYtJLgtSjWXhLV4JKSmVH+EeYV3MyzfJZV+qkVRCEyu7
	 OOEHSAV4/guFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paloma Arellano <quic_parellan@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 478/638] drm/msm/dpu: add division of drm_display_mode's hskew parameter
Date: Sun, 24 Mar 2024 18:58:35 -0400
Message-ID: <20240324230116.1348576-479-sashal@kernel.org>
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
index 97c31d03d5520..2141b81397824 100644
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


