Return-Path: <linux-kernel+bounces-69927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3273085905F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38802831E7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C237E10F;
	Sat, 17 Feb 2024 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPPejr3i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E287C0B3;
	Sat, 17 Feb 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708182183; cv=none; b=AZBpSBeZiUBtktARm8JOvNfcT++7e8LMbN2kbDiHfzdfeTgH5oKPDT4Ej4o0ppxQeBUYiwFk3buDQiSNkSd0bnOPs0j4hFnW/U3IuDV+fR9O15CqlyGRGSiWUCkuWOy0YqN9B3n7qfzxnqjLG+7fkQsXFJt0H4VYb3nkGppg/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708182183; c=relaxed/simple;
	bh=7NJQ8xLcC4Pw/NsMyFhL+x4rzV/sXkDltG7OfC8mrxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXLasJYtL/PBjtpNRrv1+MUeDDTI9GypjEcPbNehv2CpEMkZK5QXR+Vg6ds9VZUfKh5frS7dXpgcUz6Kf2dYetVzMkwWH+HRfzV/SfiUflUn7pNTbDK2sk7PvSi4KrPMJhuJ+w44kv1942zrD2WnLEMVlh462YWLoOZsGb6FMj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPPejr3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5D9C433A6;
	Sat, 17 Feb 2024 15:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708182183;
	bh=7NJQ8xLcC4Pw/NsMyFhL+x4rzV/sXkDltG7OfC8mrxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OPPejr3iLm85A6MmkuPGuNxKa4BBDq8CYhN+l0KtRM9OD7ghOkDGHoPPEp8ffRASy
	 XdJCp6RK8lS8pgXlDs1Hj5Xj9vFREwv0rv9cxi9CblKdvcPX50V+6bk+7meChV7gxV
	 BGdsS44UNHKTl7J9O6w2HIrZNhFWVyiCbTBKK8eArhami/C6L8mZvn5uTQeLCIeqmH
	 09ykI0yrNAre727AXakVzgdElSudSpRnaXkjo7eznqZzajpBrvC1z5qsqfojO9EnpM
	 IPow9UV6iG/nabuvgkoFtCJGXW0BtmctJjMHkiKMMJ/xOu1O+ls7EsYicfRiA5jfsG
	 8PDu0oWeigPgg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rbMDW-000000001Vu-3Stp;
	Sat, 17 Feb 2024 16:03:02 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Rob Clark <robdclark@chromium.org>,
	stable@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4/6] soc: qcom: pmic_glink: Fix boot when QRTR=m
Date: Sat, 17 Feb 2024 16:02:26 +0100
Message-ID: <20240217150228.5788-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217150228.5788-1-johan+linaro@kernel.org>
References: <20240217150228.5788-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

We need to bail out before adding/removing devices if we are going to
-EPROBE_DEFER. Otherwise boot can get stuck in a probe deferral loop due
to a long-standing issue in driver core (see fbc35b45f9f6 ("Add
documentation on meaning of -EPROBE_DEFER")).

Deregistering the altmode child device can potentially also trigger bugs
in the DRM bridge implementation, which does not expect bridges to go
away.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Link: https://lore.kernel.org/r/20231213210644.8702-1-robdclark@gmail.com
[ johan: rebase on 6.8-rc4, amend commit message and mention DRM ]
Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
Cc: stable@vger.kernel.org      # 6.3
Cc: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/soc/qcom/pmic_glink.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index f4bfd24386f1..f913e9bd57ed 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -265,10 +265,17 @@ static int pmic_glink_probe(struct platform_device *pdev)
 
 	pg->client_mask = *match_data;
 
+	pg->pdr = pdr_handle_alloc(pmic_glink_pdr_callback, pg);
+	if (IS_ERR(pg->pdr)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(pg->pdr),
+				    "failed to initialize pdr\n");
+		return ret;
+	}
+
 	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI)) {
 		ret = pmic_glink_add_aux_device(pg, &pg->ucsi_aux, "ucsi");
 		if (ret)
-			return ret;
+			goto out_release_pdr_handle;
 	}
 	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE)) {
 		ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
@@ -281,17 +288,11 @@ static int pmic_glink_probe(struct platform_device *pdev)
 			goto out_release_altmode_aux;
 	}
 
-	pg->pdr = pdr_handle_alloc(pmic_glink_pdr_callback, pg);
-	if (IS_ERR(pg->pdr)) {
-		ret = dev_err_probe(&pdev->dev, PTR_ERR(pg->pdr), "failed to initialize pdr\n");
-		goto out_release_aux_devices;
-	}
-
 	service = pdr_add_lookup(pg->pdr, "tms/servreg", "msm/adsp/charger_pd");
 	if (IS_ERR(service)) {
 		ret = dev_err_probe(&pdev->dev, PTR_ERR(service),
 				    "failed adding pdr lookup for charger_pd\n");
-		goto out_release_pdr_handle;
+		goto out_release_aux_devices;
 	}
 
 	mutex_lock(&__pmic_glink_lock);
@@ -300,8 +301,6 @@ static int pmic_glink_probe(struct platform_device *pdev)
 
 	return 0;
 
-out_release_pdr_handle:
-	pdr_handle_release(pg->pdr);
 out_release_aux_devices:
 	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
 		pmic_glink_del_aux_device(pg, &pg->ps_aux);
@@ -311,6 +310,8 @@ static int pmic_glink_probe(struct platform_device *pdev)
 out_release_ucsi_aux:
 	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
 		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
+out_release_pdr_handle:
+	pdr_handle_release(pg->pdr);
 
 	return ret;
 }
-- 
2.43.0


