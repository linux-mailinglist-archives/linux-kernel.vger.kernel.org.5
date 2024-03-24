Return-Path: <linux-kernel+bounces-113398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37100888402
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB3AFB240A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA541A2F57;
	Sun, 24 Mar 2024 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DupclW40"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067F1A37B3;
	Sun, 24 Mar 2024 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320200; cv=none; b=sRPVJfABtc/CkA7/cEYAZ46dtjWnfX1ljXYpPwmvzqFifZ4qY7UvQGbLtif25uTrKHOCuFaIgDqzr8KN4vIAu8gn3MDgErK5zpr40ZGCXKlDGqE5kN9Rf282Ctv79IWU9mZ3MUq8y/zRdRHXNEiXowRAE0vgyR3Ipa4guGAC8eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320200; c=relaxed/simple;
	bh=/ZaVBUHkbPamnrasfhrGm+RjGr6zggBt0p17CRmdnXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+OvuYcutUPmz6lfR9B6dQc3hGENHw9JpPilCf4IGY8chHrXeFPyU8JeI+oC05FdhQrBXszUXvbOWGYYmpMk3bAeH50VvAouKFc4QuWi3P0HR12hiRzPiwk0zMOlZJv0yqCjkbib/zmsZlLSX4gSzelb70sjbqndMldd4w6kM6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DupclW40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5137BC433F1;
	Sun, 24 Mar 2024 22:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320199;
	bh=/ZaVBUHkbPamnrasfhrGm+RjGr6zggBt0p17CRmdnXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DupclW40XEL4FGB7wiHrDHD38V8Y0E26O8ZJWs0lELjNs8CIB48ZcnYvCeA2N60dv
	 uf73Vu9Oz52H2nHZOYhD6DTq1kZZd76y0sJsMY8sxx1jhPdJ+kUHEUn1yjdjvpNjyQ
	 VS9Vq8zn6Z+M/pj+uNFE5Z1GqrdmWS+c/L/0Tj0YLblIuEZzpRLg9yt3Br1jihTm8a
	 UNudBb86z5bReesMl7puthyShEaQErFAyGl5m18NJmimFUVV4CtNon5PMQY3UivLq+
	 JuHf9W/f5VdOCsjBOgXKMt3ylm9dwzhE8b0QKOlM9CEHCRoabwBC7p1A0RzhAD8PJf
	 x2tnfvAGFLupg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paloma Arellano <quic_parellan@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 507/715] drm/msm/dpu: allow certain formats for CDM for DP
Date: Sun, 24 Mar 2024 18:31:26 -0400
Message-ID: <20240324223455.1342824-508-sashal@kernel.org>
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

[ Upstream commit 32b6ff95b91240e632f55be35c6ccd4bbe7434e4 ]

CDM block supports formats other than H1V2 for DP. Since we are now
adding support for CDM over DP, relax the checks to allow all other
formats for DP other than H1V2.

Changes in v2:
	- Add fixes tag
	- Move patch to top of series

Fixes: 0afac0ba6024 ("drm/msm/dpu: add dpu_hw_cdm abstraction for CDM block")
Signed-off-by: Paloma Arellano <quic_parellan@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/579606/
Link: https://lore.kernel.org/r/20240222194025.25329-2-quic_parellan@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
index e9cdc7934a499..9016b3ade6bc3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
@@ -186,7 +186,7 @@ static int dpu_hw_cdm_enable(struct dpu_hw_cdm *ctx, struct dpu_hw_cdm_cfg *cdm)
 	dpu_hw_cdm_setup_cdwn(ctx, cdm);
 
 	if (cdm->output_type == CDM_CDWN_OUTPUT_HDMI) {
-		if (fmt->chroma_sample != DPU_CHROMA_H1V2)
+		if (fmt->chroma_sample == DPU_CHROMA_H1V2)
 			return -EINVAL; /*unsupported format */
 		opmode = CDM_HDMI_PACK_OP_MODE_EN;
 		opmode |= (fmt->chroma_sample << 1);
-- 
2.43.0


