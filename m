Return-Path: <linux-kernel+bounces-33250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A05836747
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA311C229D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A8650A71;
	Mon, 22 Jan 2024 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFySjsMa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08D50A62;
	Mon, 22 Jan 2024 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935496; cv=none; b=sFKzdO+a0a1x+nFN0Lfd2WqGij9RvjVGtbw/YcHb2qhgCgJNziqP+asXrMxpequQRAxvSF6iQv3pHH4HADm28oQ0bzAuXExoZNOHaCd2TjqipYVFpnAmMvFXbK4cb8D4DMbzxn1EQA18QeI2mLTVe+d7ef/OYKU9hKcJQLkue3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935496; c=relaxed/simple;
	bh=h79FRcQ8ko3AliSp8bo2PBAl4wihqcHSFYQMWlnwYeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M12Tvk0cEW0kX0XNwMbhpFwJd1gnppFtqRBuHpZUq6JT1I9Dhz2nj0IRai+h7OOe+aXtkYfbMBRtnOOL6LX/jDxdKFm+NueTKGhsLnt+4yPMVr+xKLLYVpsWkOx3vFHzM05rIRNYc8y59K+0Cn+XyAC24Q+1JzvcZSwrmyvr0NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFySjsMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB766C433C7;
	Mon, 22 Jan 2024 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935496;
	bh=h79FRcQ8ko3AliSp8bo2PBAl4wihqcHSFYQMWlnwYeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lFySjsMaTyD+AwRm2V2nSezrMZgTn86RKSuBAZpzWSE7cZiYZPhhHYrP15tj3WjZV
	 lflwct9JIMnsBgSEFOr3RgEW+r5ULeph6luNomKS8QOdrpM+huaSdnrk6tHRRNVug0
	 JD70Wcf41eLOkp+03ygz0TJ7XdGrmrO3zDH02fF6ZNWD+3kn/cwdDGKW0lDuPPHwPy
	 ved5nPRrbnEUY3hqThRRwSUH6XASzaprOH/L373Piqd7FAQCsty1rM43KMAFMbCKK2
	 a/PKcixjb2XTcEqR03Fmbool/0yH6wd3reURe/NOghzrK72BnVvDUihukQclLBqOTu
	 5E+SCsisuBYtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	robdclark@gmail.com,
	quic_abhinavk@quicinc.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	quic_khsieh@quicinc.com,
	quic_bjorande@quicinc.com,
	quic_vpolimer@quicinc.com,
	swboyd@chromium.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 32/88] drm/msm/dp: Add DisplayPort controller for SM8650
Date: Mon, 22 Jan 2024 09:51:05 -0500
Message-ID: <20240122145608.990137-32-sashal@kernel.org>
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

From: Neil Armstrong <neil.armstrong@linaro.org>

[ Upstream commit 1b2d98bdd7b7c64265732f5f0dace4c52c9ba8a8 ]

The Qualcomm SM8650 platform comes with a DisplayPort controller
with a different base offset than the previous SM8550 SoC,
add support for this in the DisplayPort driver.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/571132/
Link: https://lore.kernel.org/r/20231207-topic-sm8650-upstream-dp-v1-2-b762c06965bb@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1b88fb52726f..4f89c9939501 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -170,6 +170,11 @@ static const struct msm_dp_desc sm8350_dp_descs[] = {
 	{}
 };
 
+static const struct msm_dp_desc sm8650_dp_descs[] = {
+	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
+	{}
+};
+
 static const struct of_device_id dp_dt_match[] = {
 	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_descs },
 	{ .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_descs },
@@ -180,6 +185,7 @@ static const struct of_device_id dp_dt_match[] = {
 	{ .compatible = "qcom,sc8280xp-edp", .data = &sc8280xp_edp_descs },
 	{ .compatible = "qcom,sdm845-dp", .data = &sc7180_dp_descs },
 	{ .compatible = "qcom,sm8350-dp", .data = &sm8350_dp_descs },
+	{ .compatible = "qcom,sm8650-dp", .data = &sm8650_dp_descs },
 	{}
 };
 
-- 
2.43.0


