Return-Path: <linux-kernel+bounces-33438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAAE8369AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB951F21696
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3026129A84;
	Mon, 22 Jan 2024 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6EYiCRn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B06A4EB31;
	Mon, 22 Jan 2024 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936293; cv=none; b=iExU//fSa7xHgwqrsMmg5/HJMZnzh3d3zDleJh+RySQqlg1absBKf+8S4Vjw7fpgMPgC8dfb/cDtIR0l1ApqtC16QRswJr6/t+wdiHyjMB4TMW4qz3ekkIjDEK6g3aXQWuQMA9IkWZgqgojDGxv3PG6v5rcWFCF69VL7W5KJ+J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936293; c=relaxed/simple;
	bh=GMtXAPd9uAh19CdKOpwOskMcSN/bwKs1ae2WLjNwMBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWAs+QeVIeT0pJeKWh2gijUPxq6xON5+vU51OUKQ7x9lt5edt5ZXdWnw2f5debapEfF4D7hLMspd+ShrsBtLfbon5oErgpdcAITjY+7d2V5oEnxlEJhRvAG5Ov2CUmVsy2CZkUaEALGXtTxzKhHYA2VD38wXx4Sp6lqaDARvaBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6EYiCRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD2FC433C7;
	Mon, 22 Jan 2024 15:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936292;
	bh=GMtXAPd9uAh19CdKOpwOskMcSN/bwKs1ae2WLjNwMBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n6EYiCRne6ycV6VBN6edBBswQT4UdOkqIrMl52sYav9VLAAeGoozv6gW8zytRMx8O
	 Meno7aJ7jLooxdf681IslTo+3NTO26cPemSIF/UlvvcCbtTGRuowLCsMQoz6vHtsPA
	 mEYWc8fm1VZKj1ZqlgJf7yqCDDmphG7UJgdk8oxlGmsl9pAHpt+fbD2BJdsndJaNyv
	 0vk/TOmQygGNpgG9I8Y7JLxAFgluK8nXTzrm5FjrLLKhg9V3aMyeXuaKxnsH5tJ4yr
	 sQpXyyE6PqxeNF+tE8E/KsbDk3aXb2W9B7mri2Q+9IN4QGCHLIfmnM+3Gmiix+/Kfh
	 NNeByrKKvXlIQ==
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
Subject: [PATCH AUTOSEL 6.1 37/53] drm/msm/dpu: fix writeback programming for YUV cases
Date: Mon, 22 Jan 2024 10:08:38 -0500
Message-ID: <20240122150949.994249-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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
index a3e413d27717..63dc2ee446d4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
@@ -105,6 +105,9 @@ static void dpu_hw_wb_setup_format(struct dpu_hw_wb *ctx,
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


