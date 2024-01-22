Return-Path: <linux-kernel+bounces-33276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B70CB8367EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B64B2D9F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9975A0FF;
	Mon, 22 Jan 2024 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPgsVY8T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7146F405DE;
	Mon, 22 Jan 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935575; cv=none; b=QH0B517zaUbL5nu+wGKayOAI8pmowovtpaD73gnM32XEHRm+9zh81HL34dJ826+RDzd1AwlJLRcyPozQ5EVPVXcNZALUcBTYlRH7gcSwOBgWt90wr8dhZqlHzEv4pJFFCGFtXmXkSgSWH5Fo7iIOHVGeWMULnBN3KBZ+YOYp7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935575; c=relaxed/simple;
	bh=lR2jOxqgPUcIjqaKZ/rEyHYDH9km0CL3Qv7nI2hAj78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wud+bj35WUhkvQOQuE/eTCELTSZ6KNpkdUAJuRNemB/oC955eYm+o3eVDXWt+mObOUA+hdIHr1FArDWitExVt4b+3g453WGKsLaFoCwIdI2LcvUImP7W3jdCP5TbhzReCX9UKDhAcTr0fBQ8NgRWwWKt51Qy5gRVwx+KQnxikx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPgsVY8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF968C433F1;
	Mon, 22 Jan 2024 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935575;
	bh=lR2jOxqgPUcIjqaKZ/rEyHYDH9km0CL3Qv7nI2hAj78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UPgsVY8T3EytPfC+/n2VkQErm4JJCYN3fuLREs8n+zQpojt5+fzpBti6+kDrt16Dx
	 LYwFFm9AwsvgvZcRGuCIrwCT/BcI2kIHvnUig1xb+2DMnLyfvXdw3dwAyk7PPN4zxJ
	 og+gLrES5as9a0snN25Lxp3PA1g6JmcMyNO9SONTW6wR6EdmUm43q9Un5AUDCxfSpb
	 qH1uCqMc/2OnXngrXRvvlFv2KdXJvEIbatIjXKdIPExQHNbgsbOf1oyAZosCe9n5UZ
	 QzaAPG5SVvz6YiijdByPeqQN6aOQz24Kgu5WZVXFxIAOQLYhd7XLMSMSXBLprIaFx5
	 cL1kfKHNuE/Fg==
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
	neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 56/88] drm/msm/dpu: fix writeback programming for YUV cases
Date: Mon, 22 Jan 2024 09:51:29 -0500
Message-ID: <20240122145608.990137-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index 9668fb97c047..d49b3ef7689e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
@@ -87,6 +87,9 @@ static void dpu_hw_wb_setup_format(struct dpu_hw_wb *ctx,
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


