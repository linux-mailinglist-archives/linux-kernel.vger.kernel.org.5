Return-Path: <linux-kernel+bounces-113337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D83888384
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B69E282CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88671197C88;
	Sun, 24 Mar 2024 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkmfLwc9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD57919757C;
	Sun, 24 Mar 2024 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320138; cv=none; b=ifesRuYGmHg4pRTwvZ7sdwTKObahOzhnJVD+bBXzyqxK45dfqF9SygFz9cOQWDklFL99SDuL+gzWXgJZvaXxVYzjEUxt8hkbm04YhnaInKuxP6+qbONTs+QJcrK8wfxNF/0I6/39MsoupYvjoJcfn/vgqnSBLXJgc4sXei6K3BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320138; c=relaxed/simple;
	bh=dbhrgi50dL8sBDMTPgHpKXd85uS5WWzkVEyi07bE/Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5pvpchLsyDklSaSgb0nQkcIkrO/b9e/d3Juz4X2JHBQZ35Iof/L8tM8so5uLo7P2oz4xh9EYFnP2X6zx++KcyjHMOpeMyazxIxtolTwRY4bL8iXJqIhPiiE7qbuFPfr9u1bHYSzJNbSol/PaCnbG3XcSzXzxO47qubmCYlNDME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkmfLwc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCD1C43390;
	Sun, 24 Mar 2024 22:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320138;
	bh=dbhrgi50dL8sBDMTPgHpKXd85uS5WWzkVEyi07bE/Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkmfLwc9vx3/AsEsARQOCmFLxxFs1bYb8CMW1pbfqPYxKInJcUCI1AuEuy6S5O5Yg
	 joX6dua47gRd6L1FCxjzdD2EolwjKovG7vKDXHTgleBnFweIgZrLEnuy+8+rcoGa9X
	 0I2vED+w5bi4+eepXtO5uMceA+2k4kt1MXnx8Ek+GgVJHg9Gz9I1Cg2WSJ0C5LzkFU
	 V+MaWTD0GMsceB4wq84X8du8jJW39v5flwxdn1y6bKlWwWkU82bBbU/c6I2S12l4IM
	 TEqRRyHNTTPwTaCJLe25PLYqwazk6yZMe4cXpNCGGvzCnOWdj6rB6L2uZ0b1WUkxiT
	 jB1RNMJdd7Q2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 446/715] drm/msm/dpu: finalise global state object
Date: Sun, 24 Mar 2024 18:30:25 -0400
Message-ID: <20240324223455.1342824-447-sashal@kernel.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 49e27d3c9cd67fd5851f8b5518645b9bf3d2c6c0 ]

Add calls to finalise global state object and corresponding lock.

Fixes: de3916c70a24 ("drm/msm/dpu: Track resources in global state")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/570175/
Link: https://lore.kernel.org/r/20231203000532.1290480-3-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 723cc1d821431..2330eb2a4e9c8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -374,6 +374,12 @@ static int dpu_kms_global_obj_init(struct dpu_kms *dpu_kms)
 	return 0;
 }
 
+static void dpu_kms_global_obj_fini(struct dpu_kms *dpu_kms)
+{
+	drm_atomic_private_obj_fini(&dpu_kms->global_state);
+	drm_modeset_lock_fini(&dpu_kms->global_state_lock);
+}
+
 static int dpu_kms_parse_data_bus_icc_path(struct dpu_kms *dpu_kms)
 {
 	struct icc_path *path0;
@@ -801,6 +807,8 @@ static void _dpu_kms_hw_destroy(struct dpu_kms *dpu_kms)
 		dpu_kms->hw_vbif[i] = NULL;
 	}
 
+	dpu_kms_global_obj_fini(dpu_kms);
+
 	dpu_kms->catalog = NULL;
 
 	dpu_kms->hw_mdp = NULL;
-- 
2.43.0


