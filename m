Return-Path: <linux-kernel+bounces-33372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F7B8368E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF391F2400E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF44495E7;
	Mon, 22 Jan 2024 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0BTGb1v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E56D1C0;
	Mon, 22 Jan 2024 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936023; cv=none; b=szWEJFD9yMWfw3I8CzlU7A+UfZs5mkXzFraEDjqgnpOwzuD3NJdx4YOBqin0a5b/7n9Ea5YIn2rYCb72SINGct3Hw6APgcsgEWUiQQKXgMyg9zU2KhEVPrehSoETFo2hZPfDKNm1XDLvgo3+CUCzgnF0C1izYbl35Z0E9R+2fkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936023; c=relaxed/simple;
	bh=gkCU85JLz2BGI2YbuLDLMTi6i3LCzu498Ky2LMPCJHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eELO4FRzHxmI+YIUAbGtTu0VO+3tTaXyUbUNeHEBwCNU50fzFbpXWwz01ziZEe7M8x5sKAQtMrc0XvFHY8BrY08CZzeuPfjM0RspmkQ+K+36Nk13Cngm1+J2Gt7yv2YnWz+31Zj5yYkyLnnhT6HdJfiwspkCAe0cdHDILpc65Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0BTGb1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09B2C43601;
	Mon, 22 Jan 2024 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936023;
	bh=gkCU85JLz2BGI2YbuLDLMTi6i3LCzu498Ky2LMPCJHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L0BTGb1vq7W2di3Z4t5lH8olA71REKyGbOa8BgrGe0hFTNM/TpUj/j6hM9AI6rer5
	 Lfqyrae1vztOMLfV5EQklRmRrePdjoazHo10ieijGa8GCISb9CY5UtLA0ASANgAbuL
	 Lv95CjWbe64jZ/Ay5omTxXSc5s7N3BQMEwL+jfyBzeBCktPDwkKn4n+hnWGGo5evHu
	 jfeCAjbbT+80KMbsw/zI6385OYqTFD2Yuk31ZcPp7SXsUrZO2USlc7/b2/CvS1GA91
	 hDFaO9VGQ91h6QDVBfBUkeF5+m5/xXDBa9eTFZjIFcOtgd7KH2p03RFsVBcwE0dFnp
	 f/SGF616Hg/6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	robdclark@gmail.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	marijn.suijten@somainline.org,
	quic_jeykumar@quicinc.com,
	quic_jesszhan@quicinc.com,
	neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 49/73] drm/msm/dpu: fix writeback programming for YUV cases
Date: Mon, 22 Jan 2024 10:02:03 -0500
Message-ID: <20240122150432.992458-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

[ Upstream commit 79caf2f2202b9eaad3a5a726e4b33807f67d0f1b ]

For YUV cases, setting the required format bits was missed
out in the register programming. Lets fix it now in preparation
of adding YUV formats support for writeback.

changes in v2:
    - dropped the fixes tag as its not a fix but adding
      new functionality

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/571814/
Link: https://lore.kernel.org/r/20231212205254.12422-4-quic_abhinavk@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
index ebc416400382..0aa598b355e9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
@@ -86,6 +86,9 @@ static void dpu_hw_wb_setup_format(struct dpu_hw_wb *ctx,
 			dst_format |= BIT(14); /* DST_ALPHA_X */
 	}
 
+	if (DPU_FORMAT_IS_YUV(fmt))
+		dst_format |= BIT(15);
+
 	pattern = (fmt->element[3] << 24) |
 		(fmt->element[2] << 16) |
 		(fmt->element[1] << 8)  |
-- 
2.43.0


