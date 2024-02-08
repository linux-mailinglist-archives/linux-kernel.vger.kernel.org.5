Return-Path: <linux-kernel+bounces-58262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF73184E3A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3C11C29AEA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3377CF30;
	Thu,  8 Feb 2024 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCP59gsA"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81A37B3CA
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404477; cv=none; b=XK+CxB8Fc6RWnXLVS25t7UQJRr7njTnHT/lFAT9ztVDFaKfNpxkgUtSvDmAlGzWEu/oMs8Dn6Sr8ZZDQi5Z2dPjEGrlVT9dUWje8c+Cj1bwgNkA+07weyJ327f1CXSgsA3zfpI864xwUJ4glybHtDuzZuYLSqAkpScYR+6mfU0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404477; c=relaxed/simple;
	bh=l8WXS3ws5bU0POmatEizYV75CbeDLs5zSep1gpGQJz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cgDXUbTr8kqIEB/bxmLdFBLye/MGP1im2K/JsiTE6CFI9ORAK+gm7RchflgTbQq3h2nYEzQVymN+r+oiFpCvm9JTMPvlrpiUMmr8N+HnR4sWT3HfuIqGrPeYYi37E6rP6MxmyGFfjsgZgK55MhWn7UwJKcd55vYEc+TD/pgzoh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZCP59gsA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5114c05806eso2900141e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707404473; x=1708009273; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=micFdpjWEfE2iQhufUDk7TfjTaVtXdHcamWR3jJ5CU4=;
        b=ZCP59gsAF3w9VZdSRKBfLOYt+o5tjczGE3Bhxgpf/CTShdTYGs+VAL4cy+uuU0XPyh
         TDb/D3BmvDeykw95ovwlpKdccKbdz6AvLJjjXY0dgOvGhvQSWhWQPXi+PSuWg/sHRZOv
         0Pz/5q4JY6Xix5QindJTINOAobrBQZfcqcn4KhH4n1IaKK8KqRmB21tcD4SJjVY/jzdq
         WcRuDO0R832rQrAr5laJ4UJOlR7++i1Q37DJ0g2olc2BLpmowDeNjcKJBCwE8nKUfOby
         dkmx8oE0hVHELTXTeEhUaaX/9QmLQqb38XV4CdCv4122vW75NlKIg6WGrXXJBgLDflCe
         Yblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707404473; x=1708009273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=micFdpjWEfE2iQhufUDk7TfjTaVtXdHcamWR3jJ5CU4=;
        b=lUoLG/mzLs+n/eVo1/+4O22MYlYZytDXAKxDBqpDNFjBf7vCcrgDRQqix/EABS/1OP
         qxYwVKSxKID1D5uR6QnoGt2ISZzh+gOs3npjV7GI0F3whPRNP7bHE8bpQ8YHOx2p+G9W
         lEointxycOtKFkizH1jYHLGhlrctAIggDRehgTnhFxsHqkHl1LR6ZOkzjjUD7ZIf48lN
         7m0637qhrrD9pV5rgW/6tNG0qb97qVsP74iWnI7hh+ozCRJ6pHJhZesk8ssaq/3ht2gD
         Vp/j2Nz6dhpY0jn/C4RVE/aQFCWPuDRWZsAF7PjsMLq6Tj33VrlYIr6mDK/wbT5vuZy/
         7cRA==
X-Forwarded-Encrypted: i=1; AJvYcCW5S4mHZhxK+rO55HgOX3u28Wh/tIWohF9KBgkPoYCF8xcpPbXp9NlzbhZ8MGp6/Djs735EvjH6jsVYAL+ba+JeeC/9vtdmvyMuwPfs
X-Gm-Message-State: AOJu0YySLFqlGorusYWWipn7OXMFkzL70u4SHoh2QC6CRUSibgH4DQpX
	fxLogs/VfSu6zUA0Ol8G9vUi+8eQlZG7V958e3b5bkh5CM+HXecIoS4Sx/v2vW4=
X-Google-Smtp-Source: AGHT+IEKxPQuiTEdGhUliODLyt4bKlkDiajbJE1Yhvua8o8q9WNLMvK1bFBsNZmn04FP0yj1fhvsgA==
X-Received: by 2002:a05:6512:3e21:b0:511:60ba:a02e with SMTP id i33-20020a0565123e2100b0051160baa02emr6791569lfv.40.1707404472753;
        Thu, 08 Feb 2024 07:01:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUWfyO+YUwrNmX5OGaP+HqleZPdYsG04Ds7ao0CeWN16bbHuQt3u+aO+Zw/SCkAHi6YQHBMr6BF3JbiHNQrsPzMKJTTshL+0u4rDBRdYPtnL5efQBnazgpDhCExpUH7BigN16hrMXoeJjzsCOdHqucZuF2AxCXJPtfSu1/5rBwDxYGLtynw47Sb/EOFtiYER6Lps3TUjHoFnG6NPvUcd3l+DEyPVgyj+sppMkIJhUvWmahWsfimK/UTiTsJ4B+ESdfz4GCNNo5b+ey5XcpQr8QposgPycipvMd7yUeTqydglqcbgGqqmr4Yu3EEgTw8ODw2ygMHISmyM3Ek2uWyVRI/GfOYzaD7gBcqtX4yerpcH9wx3GPibsCq05J94ceEj7v9XT4suzx4BFx
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x18-20020a19f612000000b00511498107b8sm22444lfe.65.2024.02.08.07.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 07:01:12 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 08 Feb 2024 17:01:10 +0200
Subject: [PATCH v4 3/4] drm/msm: add a kernel param to select between MDP5
 and DPU drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-fd-migrate-mdp5-v4-3-945d08ef3fa8@linaro.org>
References: <20240208-fd-migrate-mdp5-v4-0-945d08ef3fa8@linaro.org>
In-Reply-To: <20240208-fd-migrate-mdp5-v4-0-945d08ef3fa8@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Stephen Boyd <swboyd@chromium.org>, Carl Vanderlip <quic_carlv@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3850;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=l8WXS3ws5bU0POmatEizYV75CbeDLs5zSep1gpGQJz8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlxOy1s+We5gpCU3SazjAx5Xh8bF6Dy+O/eQgD0
 CopwZ+OHzeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZcTstQAKCRCLPIo+Aiko
 1Ua4CACsjd27gTUByFMcUJ8n8OTcCFjUb9uZPstAvEqrs4SpLWihGrO1a1tObcml0Qo0mARRxzn
 9Y5ZAIPnolxR0/LzVuQFe1ZA5fpzqUFAi48/aEOBi4PGj/1zGLygX8lNDsp0g07A6F9FLElvxVa
 Cmjk3LLvkLezQEDGkLqQ9w+EQDwdY216C5ee/rU8HyA16vpgBAnTIVvMmcBV7t4qPGdFF7pG8rU
 5o27SeeQTPBMcSAg+16wcIrmPgaDnpVMNcYBRH/ZtEZihdP4hpAYWIuEBmgjYtE5czLunKUW/Pk
 HZFC70zd/MT0triJoZnBYu5TBE1smnpHfqFiYwZUdK4vyIRU
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

For some of the platforms (e.g. SDM660, SDM630, MSM8996, etc.) it is
possible to support this platform via the DPU driver (e.g. to provide
support for DP, multirect, etc). Add a modparam to be able to switch
between these two drivers.

All platforms supported by both drivers are by default handled by the
MDP5 driver. To let them be handled by the DPU driver pass the
`msm.prefer_mdp5=false` kernel param.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  |  3 +++
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c |  3 +++
 drivers/gpu/drm/msm/msm_drv.c            | 31 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.h            |  1 +
 4 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 5de1861f608e..4fab3544e4f1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1276,6 +1276,9 @@ static int dpu_dev_probe(struct platform_device *pdev)
 	int irq;
 	int ret = 0;
 
+	if (!msm_disp_drv_should_bind(&pdev->dev, true))
+		return -ENODEV;
+
 	dpu_kms = devm_kzalloc(dev, sizeof(*dpu_kms), GFP_KERNEL);
 	if (!dpu_kms)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 0827634664ae..43d05851c54d 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -866,6 +866,9 @@ static int mdp5_dev_probe(struct platform_device *pdev)
 
 	DBG("");
 
+	if (!msm_disp_drv_should_bind(&pdev->dev, false))
+		return -ENODEV;
+
 	mdp5_kms = devm_kzalloc(&pdev->dev, sizeof(*mdp5_kms), GFP_KERNEL);
 	if (!mdp5_kms)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 50b65ffc24b1..f79134fc6cc0 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -969,6 +969,37 @@ static int add_components_mdp(struct device *master_dev,
 	return 0;
 }
 
+#if !IS_REACHABLE(CONFIG_DRM_MSM_MDP5) || !IS_REACHABLE(CONFIG_DRM_MSM_DPU)
+bool msm_disp_drv_should_bind(struct device *dev, bool dpu_driver)
+{
+	/* If just a single driver is enabled, use it no matter what */
+	return true;
+}
+#else
+
+static bool prefer_mdp5 = true;
+MODULE_PARM_DESC(prefer_mdp5, "Select whether MDP5 or DPU driver should be preferred");
+module_param(prefer_mdp5, bool, 0444);
+
+/* list all platforms supported by both mdp5 and dpu drivers */
+static const char *const msm_mdp5_dpu_migration[] = {
+	NULL,
+};
+
+bool msm_disp_drv_should_bind(struct device *dev, bool dpu_driver)
+{
+	/* If it is not an MDP5 device, do not try MDP5 driver */
+	if (!of_device_is_compatible(dev->of_node, "qcom,mdp5"))
+		return dpu_driver;
+
+	/* If it is not in the migration list, use MDP5 */
+	if (!of_device_compatible_match(dev->of_node, msm_mdp5_dpu_migration))
+		return !dpu_driver;
+
+	return prefer_mdp5 ? !dpu_driver : dpu_driver;
+}
+#endif
+
 /*
  * We don't know what's the best binding to link the gpu with the drm device.
  * Fow now, we just hunt for all the possible gpus that we support, and add them
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 01e783130054..762e13e2df74 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -563,5 +563,6 @@ int msm_drv_probe(struct device *dev,
 	struct msm_kms *kms);
 void msm_kms_shutdown(struct platform_device *pdev);
 
+bool msm_disp_drv_should_bind(struct device *dev, bool dpu_driver);
 
 #endif /* __MSM_DRV_H__ */

-- 
2.39.2


