Return-Path: <linux-kernel+bounces-114300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A53C8889A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EA02899EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2345261CB5;
	Sun, 24 Mar 2024 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpBHVR3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1F20F23F;
	Sun, 24 Mar 2024 23:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321674; cv=none; b=PDSMm0A17xBJN5dJ98OLlN0KN+uT/zowc4SDIoiQBsXkmk5LV6cCtMm96lEtpUhwOCMg5BKJCX15fKWLOvVzcyQaX0XUKpBoC2d9ju80i5cimse1tumw9N1wrT14c/vKwDHohXt/fNlNaOk3ot98pYGC0RPKdkx0EdnVxatXmXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321674; c=relaxed/simple;
	bh=tb7KMw3QYRC8PNCsmxHTx/4pYVLvQWihFzNqZmtNYrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeL0XymhFnntFnIeBOqXrnoXxlQL3zibeH3YW/DKKPJYI03DXGGA94WC6dA8e/e+bFvC3Cx28LRIQNWZXwMZoep3+Z6QU70YPuMUCXJcdPByXFH+lZaX7XnMRZ7cilA1ikokMSeDk//03xANm+PwbjxxW7E/Avz0HWgmnrj01QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpBHVR3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48FDC433C7;
	Sun, 24 Mar 2024 23:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321673;
	bh=tb7KMw3QYRC8PNCsmxHTx/4pYVLvQWihFzNqZmtNYrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpBHVR3/CoX2k8Q8seGl7m+yTUTMr3e/7loKRV20+PROw2U2P8eTglrVbNC5GDvyd
	 1rM4L8fYPphq1u4Lt8M81ix6bWTNHKlfmLXYqmXb3HIJcCyMZwdg4zrmvj/xgXrZVI
	 8UREKzwffSzjP7ZYh18hsC81301iMfeaw8NSScxiiLXghHIv08+0vx3a6B32xoGh44
	 HoPr5AtPFopXAsjOa4Tg7qRozYND0gU0qNyxjQhrdSZa9eNozlI7SQx/7eWKrNlqaH
	 jv2Gr1KgFc6z3RoFIqLG1tvV7yXV7Fji2Fb7IDsdD3xyvisS4b71mSYKRjgcfBbZXa
	 LF7AuXd2FI7gw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 402/638] drm/msm/dpu: Only enable DSC_MODE_MULTIPLEX if dsc_merge is enabled
Date: Sun, 24 Mar 2024 18:57:19 -0400
Message-ID: <20240324230116.1348576-403-sashal@kernel.org>
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

From: Marijn Suijten <marijn.suijten@somainline.org>

[ Upstream commit 06267d22f9ee6fd34150b6dcdb2fa6983e1a85bc ]

When the topology calls for two interfaces on the current fixed topology
of 2 DSC blocks, or uses 1 DSC block for a single interface (e.g. SC7280
with only one DSC block), there should be no merging of DSC output.

This is already represented by the return value of
dpu_encoder_use_dsc_merge(), but not yet used to correctly configure
this flag.

Fixes: 58dca9810749 ("drm/msm/disp/dpu1: Add support for DSC in encoder")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/577067/
Link: https://lore.kernel.org/r/20240204-dpu-dsc-multiplex-v1-1-080963233c52@somainline.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 89bd526f3990a..20e118546432d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1855,7 +1855,9 @@ static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
 	dsc_common_mode = 0;
 	pic_width = dsc->pic_width;
 
-	dsc_common_mode = DSC_MODE_MULTIPLEX | DSC_MODE_SPLIT_PANEL;
+	dsc_common_mode = DSC_MODE_SPLIT_PANEL;
+	if (dpu_encoder_use_dsc_merge(enc_master->parent))
+		dsc_common_mode |= DSC_MODE_MULTIPLEX;
 	if (enc_master->intf_mode == INTF_MODE_VIDEO)
 		dsc_common_mode |= DSC_MODE_VIDEO;
 
-- 
2.43.0


