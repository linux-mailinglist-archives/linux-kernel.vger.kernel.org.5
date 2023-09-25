Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4B17ADA91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjIYOvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjIYOvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:51:03 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91F1193
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:50:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c008042211so111400461fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695653446; x=1696258246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kuYbzX57CXaEHQv9Z7JYJxa/eMNR7T/UxhNHWh05adY=;
        b=HWkg81xBBoM6HQtb078K1+cV7c1BhrBTYSb4WwzEVorrF5j1S75IYoZJ6D7YbUWMtH
         OfBFM3M+h8yOJ+U803FvDVUtv014Yby0gS2rF0xMTSdrVXzprb2noyHcIC8uavOS/oFt
         QZ6t2IE5g9ekgdNKFRXfjUTyOZUr7ZTIiZg+RT9ajBhCN2f97RYWEjaoYy+uvu/fU3wM
         pcCdYdXbxBIC+hfPLGhkE0XhvzJd1P18mfya9xiOMVwou/9abQAQH+smkukP3oGD2sp5
         VKaTk5BzXDOeAGUnEuFe/HqwyKp2amJi/QyBmN5g7f0HuJtF1VqZy24TRAWJqEoxwlXr
         5VmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695653446; x=1696258246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuYbzX57CXaEHQv9Z7JYJxa/eMNR7T/UxhNHWh05adY=;
        b=YyE3Qfm7C5JQA3m+igE5ROVhEpv3wHl30ztVgUZVZsE542YxkT6cj5wl0O8hR1HsMS
         99BKvSTmxK46Cz/UbcGfUj2TmgDGM1FXxiT4aMrb2gwyIf6Gbq+qGSYrAnkThDDQOtRY
         p6F2uJfqBy5iG9hWQwN8wOGIll4JphcEhRpNfkrorgM+TMJIu24KVi3vrvkvHJQb1oo2
         KCuZFKKVlz2mx/BtU0IULnPNXfqDe3Dh+nLx68QRivVSzRU0Cpgmvf3TPsAIvEHbKERo
         TfRuAiro61h088HGt6y+nToWhZ2cFsaE4KePqdiKApPExDst9BWJJ9tL4gjkpU7Z2fjd
         SouA==
X-Gm-Message-State: AOJu0YwhjHpmU+oXKteNi9jV+wLB85FHG1ZDZPESTuFlf3D7Hl49Djy8
        ukliyj21cRkM0azGL+APNLp7AQ==
X-Google-Smtp-Source: AGHT+IFUUyH8sZGa5D11MzEv7ltXfHNsbMrRqLKMjbCpozDjZGWz7Ip9PLVc2fqAS+WOuu4K9lVsrQ==
X-Received: by 2002:a2e:8891:0:b0:2bc:b54b:c024 with SMTP id k17-20020a2e8891000000b002bcb54bc024mr5632063lji.29.1695653445911;
        Mon, 25 Sep 2023 07:50:45 -0700 (PDT)
Received: from [10.167.154.1] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id k8-20020a170906a38800b0099bc2d1429csm6426640ejz.72.2023.09.25.07.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 07:50:45 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 25 Sep 2023 16:50:35 +0200
Subject: [PATCH v5 06/10] drm/msm/a6xx: Send ACD state to QMP at GMU resume
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-a7xx_drmmsm-v5-6-3dc527b472d7@linaro.org>
References: <20230628-topic-a7xx_drmmsm-v5-0-3dc527b472d7@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v5-0-3dc527b472d7@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695653434; l=2558;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=HBk29fBjZLK9cQdJl8RcOA0kMaWZoErbqweB6fWXO4Q=;
 b=l6778/nzUGBEHG+F6+sTquBH51vVgeQFiwDUa+GT6cKWt0chJOKo0yCWoCWOX7YIo9LTF4iL2
 hGlIUOr7gi5B2fF09FgfnZGjpSHzGpen1+BKQHKJkA9HFskWa3r5mKE
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 15 +++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 15ab912d9c45..c1934d46c0d7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -989,6 +989,14 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 
 	gmu->hung = false;
 
+	/* Notify AOSS about the ACD state (unimplemented for now => disable it) */
+	if (!IS_ERR(gmu->qmp)) {
+		ret = qmp_send(gmu->qmp, "{class: gpu, res: acd, val: %d}",
+			       0 /* Hardcode ACD to be disabled for now */);
+		if (ret)
+			dev_err(gmu->dev, "failed to send GPU ACD state\n");
+	}
+
 	/* Turn on the resources */
 	pm_runtime_get_sync(gmu->dev);
 
@@ -1741,6 +1749,10 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 		goto detach_cxpd;
 	}
 
+	gmu->qmp = qmp_get(gmu->dev);
+	if (IS_ERR(gmu->qmp) && adreno_is_a7xx(adreno_gpu))
+		return PTR_ERR(gmu->qmp);
+
 	init_completion(&gmu->pd_gate);
 	complete_all(&gmu->pd_gate);
 	gmu->pd_nb.notifier_call = cxpd_notifier_cb;
@@ -1764,6 +1776,9 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
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
2.42.0

