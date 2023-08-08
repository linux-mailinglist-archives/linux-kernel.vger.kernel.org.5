Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B4C774C43
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjHHVEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbjHHVDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:03:40 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EFF526F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:03:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso95724531fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691528585; x=1692133385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWSqXH+9RfbwUTEnzUS/yIoSzpfO5MDzRDb4ETGPnXo=;
        b=HDjwem1ulOLEnOWwiJkSQF5CYp47hiV60zxYdQN0lOvnSjDIYHmdTvaPoFHM51st+1
         hYJFv+X9JYZ6CXSMmV+3JcekbOuuv9Z0NbMJZWoDG1UCpkR9990ABDwO+Jtb0G5dOM09
         0wwadN6rqKQ3qDofigBIoMTKhaav/nyoYL9khx6W3eGYgIwsIHuUDeF2YU4A3PiyPaUV
         9NM2vLTCzWKVOJ5axWTUTjKab3NNyLujAN9QKx7Y/Z+Y7aW7FTXta/LEwVR/PNfa2XrA
         rjW+2bwO30ji2U8WPdreGKkVULpqPYVVp/JaY9zzS0dOr7HNuZTIpRGc9/xGyacj/FFf
         7i0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691528585; x=1692133385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWSqXH+9RfbwUTEnzUS/yIoSzpfO5MDzRDb4ETGPnXo=;
        b=Nd/da31FEAUTXLQoydJ033T1of9inbzNEr22nYVmBu4QDrNGBbxYhsOxuLVnEHw/uJ
         JZnQOYrGL1IEsBP+wZIoHA3qILx09YbDqPoJx4FZZnGNqbFC0UWtT+UNE4EPxsO1mf73
         FCQIAYLdDZZyveLV6hHbiGxr9S3jn+CdEZyB/f+oKpRlAk9BX3xVtoazkTS0DqZj9RqJ
         E9xo7vvi4gfLHs7ud84BvQMya4ygdK7K1wt+2L6Y6HbLnzkU/7TkYvrWvstw4T0ylhGU
         uJctYgojeSECYl04emnEtt1k6px9Dm5yKOt9DSlpiFNY55ZV9B24PRM724Y1zHBUrkv8
         7w9w==
X-Gm-Message-State: AOJu0YwU5CwsMgMFMEsMxRzfRuD5Xlq86xnT/6KAWDIS+NBJYClj6o2R
        SP1b3sBhisGlyMnEhSYhyaDv/g==
X-Google-Smtp-Source: AGHT+IH30kcdgrakV3yA9VIz6jtlC0ExfeVhv/nhNZepLIccW64T5ouuUZPiVHp6SNXZ5fohgyAt6A==
X-Received: by 2002:a2e:b009:0:b0:2b6:df23:2117 with SMTP id y9-20020a2eb009000000b002b6df232117mr484344ljk.43.1691528585080;
        Tue, 08 Aug 2023 14:03:05 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id h11-20020a2eb0eb000000b002b6cc17add3sm2431483ljl.25.2023.08.08.14.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:03:04 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 23:02:47 +0200
Subject: [PATCH v2 09/14] drm/msm/a6xx: Send ACD state to QMP at GMU resume
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-a7xx_drmmsm-v2-9-1439e1b2343f@linaro.org>
References: <20230628-topic-a7xx_drmmsm-v2-0-1439e1b2343f@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v2-0-1439e1b2343f@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691528566; l=3163;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JkmXZM9EFVG7rbP7M14vpehHX3UdHrePo85jPFtHIho=;
 b=ViUB144QP1ZseV6WexhJNzar78IsyKH78bT0Xt0p7SqasyBwYAzOh2k7+FDqwIYL1eHLPJWBA
 tu3tvQBD+r6DlevjhGDLQ/8G40/Oonz8jbwPfKu+zeA0HCwI0qi0QTQ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMP mailbox expects to be notified of the ACD (Adaptive Clock
Distribution) state. Get a handle to the mailbox at probe time and
poke it at GMU resume.

Since we don't fully support ACD yet, hardcode the message to "val: 0"
(state = disabled).

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # sm8450
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 75984260898e..17e1e72f5d7d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -980,11 +980,13 @@ static void a6xx_gmu_set_initial_bw(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
 	dev_pm_opp_put(gpu_opp);
 }
 
+#define GMU_ACD_STATE_MSG_LEN	36
 int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 {
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	struct msm_gpu *gpu = &adreno_gpu->base;
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+	char buf[GMU_ACD_STATE_MSG_LEN];
 	int status, ret;
 
 	if (WARN(!gmu->initialized, "The GMU is not set up yet\n"))
@@ -992,6 +994,18 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 
 	gmu->hung = false;
 
+	/* Notify AOSS about the ACD state (unimplemented for now => disable it) */
+	if (!IS_ERR(gmu->qmp)) {
+		ret = snprintf(buf, sizeof(buf),
+			       "{class: gpu, res: acd, val: %d}",
+			       0 /* Hardcode ACD to be disabled for now */);
+		WARN_ON(ret >= GMU_ACD_STATE_MSG_LEN);
+
+		ret = qmp_send(gmu->qmp, buf, sizeof(buf));
+		if (ret)
+			dev_err(gmu->dev, "failed to send GPU ACD state\n");
+	}
+
 	/* Turn on the resources */
 	pm_runtime_get_sync(gmu->dev);
 
@@ -1744,6 +1758,10 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 		goto detach_cxpd;
 	}
 
+	gmu->qmp = qmp_get(gmu->dev);
+	if (IS_ERR(gmu->qmp) && adreno_is_a7xx(adreno_gpu))
+		return PTR_ERR(gmu->qmp);
+
 	init_completion(&gmu->pd_gate);
 	complete_all(&gmu->pd_gate);
 	gmu->pd_nb.notifier_call = cxpd_notifier_cb;
@@ -1767,6 +1785,9 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
 	return 0;
 
+	if (!IS_ERR_OR_NULL(gmu->qmp))
+		qmp_put(gmu->qmp);
+
 detach_cxpd:
 	dev_pm_domain_detach(gmu->cxpd, false);
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 236f81a43caa..592b296aab22 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -8,6 +8,7 @@
 #include <linux/iopoll.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
+#include <linux/soc/qcom/qcom_aoss.h>
 #include "msm_drv.h"
 #include "a6xx_hfi.h"
 
@@ -96,6 +97,8 @@ struct a6xx_gmu {
 	/* For power domain callback */
 	struct notifier_block pd_nb;
 	struct completion pd_gate;
+
+	struct qmp *qmp;
 };
 
 static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)

-- 
2.41.0

