Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F019C7C912D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjJMXIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJMXID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:08:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B20BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:07:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso932793e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697238478; x=1697843278; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ntpWA0KpoWbL2Mip0SNW/VcCmMEOAdpN3Qpqu/MvN+k=;
        b=iSMOv8rPVRXSMfZrkL+mUnc1wCEmwheuV7AP1QnoaFT9ntFpNhLF2SA4bUfvt/I8H2
         VKtm6u0hdPJ5Jd3UFQUb7NT6x3R9NWysTV0QEBRgFugWlbULTOX2xlyOheyviT5IWq+k
         pnDk0uaEHUQnx0dnPCjFdsDkUYXrdOljWn6QzMEQR3uovCDvjyJlW6QhTI8+Mfa1JGuG
         hR/HcNdGp4QfRXhq7iw99eFJGaZeDZid6O3wspnEpgSQcxA4ZZ8pJIXNzFE8yN9PNjzW
         iaFJTfrfNw1sZ59kdh6T0H5XqPMRvafQ7aZ2HZQfrStFAOUpdQpq+BxhzUghBYapvoJm
         gxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697238478; x=1697843278;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntpWA0KpoWbL2Mip0SNW/VcCmMEOAdpN3Qpqu/MvN+k=;
        b=TORhIp4EzeUqHxEpv8UWgU+7vtIjXoJ0UyE8N5EZpSuVKO8N9/1VFgZfZ4Dts1YZ+/
         mjgJkGl+7AGXpFN68bDqJj2P1suS0L5IQGIUvA6tFMMbO7fG7zKGVOp9viGsMJ+x641p
         NaD2XpCTHaBw3i8dSeJr7N17dNzrT2EcpKd32tidCXLcVGw5VCDP2YcxjxXQaR+dAbZd
         EEQUvyFQ+pzlEk8E7GFtoKqD+SStyn4aglkUVSSb2+pPjdv3hAyNg2gCIUg1abAcwyzJ
         xE8V5nYzzpJlM0V3qbMC9kQTFKHpdJMJXMh6n6mRsGJKkpbUUjbi9m9c710gq7lvtC3X
         lUnw==
X-Gm-Message-State: AOJu0YzUfLdQZwWDu49f2OIL4m3AJ1IBnpNHIe3y80EhxfUTShip1OUE
        9wfsqXZdn7K7J46TQyIxTeN58A==
X-Google-Smtp-Source: AGHT+IEJMwBj1J0JzYtqJnElPMCb2Qn7Ch45pieeJc7RnMmM9cj9AkGLOPOfCuprWfC3Xg3v4+RMlA==
X-Received: by 2002:a05:6512:1246:b0:500:9839:b13a with SMTP id fb6-20020a056512124600b005009839b13amr30206505lfb.66.1697238477814;
        Fri, 13 Oct 2023 16:07:57 -0700 (PDT)
Received: from [10.167.154.1] (178235177169.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.169])
        by smtp.gmail.com with ESMTPSA id u13-20020ac248ad000000b00504818fcb07sm3553202lfg.266.2023.10.13.16.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:07:57 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 14 Oct 2023 01:07:46 +0200
Subject: [PATCH] drm/msm/a6xx: Fix up QMP handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231014-topic-a7xxv3-v1-1-616bc95f21ce@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMHNKWUC/x2N0QqDMAwAf0XyvEBTNxR/RfYQ2zgDUqV1UhD/f
 WGPd3DcBUWySoGhuSDLqUW3ZECPBsLC6SOo0Ri88y05euKx7RqQu1rPFqOb2UfqO08vsGTiIjh
 lTmGxKH3X1eSeZdb6f4zv+/4Bzr+H7HMAAAA=
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697238476; l=2554;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=L0RoG9B+wKNyrZ4UA2Vwj13Xo0muadgjIRaCHVUzQ3I=;
 b=0Tz640xtbRU3aIFgDrl3cQRCFtrEfteAL/Yvax+E5GHso3rsWZ6bqFX9Y5eSvxekDoMSTJduI
 Bz7I7UTi6RMAfWwBf2cx/MoFPYBqP+UETorzEdjQS28mwPa60aYQxVG
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit referenced in the Fixes tag had a couple problems (as
pointed out by Dan):

- qmp_put was never called, resulting in refcnt leaks
- failling to acquire the QMP mailbox on A7xx would not undo the probe
  function properly
- the qmp_put call present in the code was unreachable

Fix all of these issues.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 88a0997f2f94 ("drm/msm/a6xx: Send ACD state to QMP at GMU resume")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 0555a0134fad..8c4900444b2c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1558,6 +1558,9 @@ void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu)
 		dev_pm_domain_detach(gmu->gxpd, false);
 	}
 
+	if (!IS_ERR_OR_NULL(gmu->qmp))
+		qmp_put(gmu->qmp);
+
 	iounmap(gmu->mmio);
 	if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "rscc"))
 		iounmap(gmu->rscc);
@@ -1654,6 +1657,7 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	struct platform_device *pdev = of_find_device_by_node(node);
+	struct device_link *link;
 	int ret;
 
 	if (!pdev)
@@ -1777,15 +1781,17 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 		goto err_mmio;
 	}
 
-	if (!device_link_add(gmu->dev, gmu->cxpd,
-					DL_FLAG_PM_RUNTIME)) {
+	link = device_link_add(gmu->dev, gmu->cxpd, DL_FLAG_PM_RUNTIME);
+	if (!link) {
 		ret = -ENODEV;
 		goto detach_cxpd;
 	}
 
 	gmu->qmp = qmp_get(gmu->dev);
-	if (IS_ERR(gmu->qmp) && adreno_is_a7xx(adreno_gpu))
-		return PTR_ERR(gmu->qmp);
+	if (IS_ERR(gmu->qmp) && adreno_is_a7xx(adreno_gpu)) {
+		ret = PTR_ERR(gmu->qmp);
+		goto remove_device_link;
+	}
 
 	init_completion(&gmu->pd_gate);
 	complete_all(&gmu->pd_gate);
@@ -1810,8 +1816,8 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
 	return 0;
 
-	if (!IS_ERR_OR_NULL(gmu->qmp))
-		qmp_put(gmu->qmp);
+remove_device_link:
+	device_link_del(link);
 
 detach_cxpd:
 	dev_pm_domain_detach(gmu->cxpd, false);

---
base-commit: e3b18f7200f45d66f7141136c25554ac1e82009b
change-id: 20231014-topic-a7xxv3-d0fa2d187215

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

