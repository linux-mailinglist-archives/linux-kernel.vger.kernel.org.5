Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9475774C37
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjHHVDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbjHHVDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:03:33 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5815C270B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:03:00 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso98354121fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691528578; x=1692133378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a13TlERjZ/yvBKly/AGOqrMMiFpj1YGs0Ux9Op8gIVs=;
        b=H1PJZYsx2T7Rn4anW5XSQZA9afRmTh9NeBPbPqfY5kvZSO7R3brHeG7mSPb196jYXp
         as+6wGFHIpLIkpo05bugbQcrX5qR2Ebpkn6ed8+aILzxYjkn6PuuE712VVxPGQaWX7M+
         5NBikVn9aUZFcus7i5zrpnizNJLXYu36sdpOrX6mwtHGATCsuI+YblaIJpk2zchk/5JX
         O3hZP+rlOzYOwv3puSthY9wWsnCp65dMLr53Djrp/5kKCEaIoFOh1pmvhLy27gDU2iGc
         58cf36uzHg12bXUm0xrhKQIrnsu48m0IULJEYJUkCGgXDKKamKQZuvNAfUgbARKcgBIj
         3gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691528578; x=1692133378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a13TlERjZ/yvBKly/AGOqrMMiFpj1YGs0Ux9Op8gIVs=;
        b=YwCa1PWiAqCQZOorOCPzc8ihoQrF4SrORJN98j0VuwePq+SgJUHaH6+YQSS2mjIFhQ
         2N+OiRozjOYyLhlTwUVR/07OZ5f5rEatiASDOQjzQVEOFLd1RJvyEaDDpCB0RtgOi161
         MQokE7ddc+Cv6BsHMCXeR2aGihd9AukalxbqHEwzBHxDL0g15MW3aSyzZJOPhZDQJeBz
         iVHF6PRvhbJRJwrUvmsKUfpqUcL8b5nRFc1XFU+fDrUmy+oxs7t26+rTdRE0YnbB0BOH
         +9BXNPWXE6t84hDw6gqVAVC+AfRhRnD6NPp089jFTGWS4I0/QSTC/gWqETFJpWAF+yP/
         7f5A==
X-Gm-Message-State: AOJu0YzmeTala+D5K2gcsR7f5G07ZmJZvTk6jsDQ/QInfkvvrRiiiQ2q
        7pviVqlp5rBHrnM7rcgvZCwWdA==
X-Google-Smtp-Source: AGHT+IHwifWAFYokdWjpmdSh19UTnzHvP19artpwYL3ci97p4SwBhNfIJcamjQIDm7o3EPSEFxwWEg==
X-Received: by 2002:a2e:86c3:0:b0:2b9:f1ad:94f5 with SMTP id n3-20020a2e86c3000000b002b9f1ad94f5mr438696ljj.40.1691528578674;
        Tue, 08 Aug 2023 14:02:58 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id h11-20020a2eb0eb000000b002b6cc17add3sm2431483ljl.25.2023.08.08.14.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:02:57 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 23:02:44 +0200
Subject: [PATCH v2 06/14] drm/msm/a6xx: Move LLC accessors to the common
 header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-a7xx_drmmsm-v2-6-1439e1b2343f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691528566; l=2192;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=tUfU3+ovsnb6sldTwSDEUkthoS8ftGWI68xnQOhZSl8=;
 b=Gg1/EQ7JSx1ssTGQaOw1FYx7cTycHkjbtlzVhlDG270vRIUCbgfLbg3AMBVJC2fNsPnBawSiU
 TqXDjJXP2rWABo0WNT8X5kzfCnD17h/qGOicpiVO/tFfqtlvDgapl0L
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

Move these wrappers in preparation for use in a6xx_gmu.c

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # sm8450
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 15 ---------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 0fef92f71c4e..6dd6d72bcd86 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1735,21 +1735,6 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
 	return IRQ_HANDLED;
 }
 
-static void a6xx_llc_rmw(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 mask, u32 or)
-{
-	return msm_rmw(a6xx_gpu->llc_mmio + (reg << 2), mask, or);
-}
-
-static u32 a6xx_llc_read(struct a6xx_gpu *a6xx_gpu, u32 reg)
-{
-	return msm_readl(a6xx_gpu->llc_mmio + (reg << 2));
-}
-
-static void a6xx_llc_write(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 value)
-{
-	msm_writel(value, a6xx_gpu->llc_mmio + (reg << 2));
-}
-
 static void a6xx_llc_deactivate(struct a6xx_gpu *a6xx_gpu)
 {
 	llcc_slice_deactivate(a6xx_gpu->llc_slice);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index ab66d281828c..34822b080759 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -62,6 +62,21 @@ static inline bool a6xx_has_gbif(struct adreno_gpu *gpu)
 	return true;
 }
 
+static inline void a6xx_llc_rmw(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 mask, u32 or)
+{
+	return msm_rmw(a6xx_gpu->llc_mmio + (reg << 2), mask, or);
+}
+
+static inline u32 a6xx_llc_read(struct a6xx_gpu *a6xx_gpu, u32 reg)
+{
+	return msm_readl(a6xx_gpu->llc_mmio + (reg << 2));
+}
+
+static inline void a6xx_llc_write(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 value)
+{
+	msm_writel(value, a6xx_gpu->llc_mmio + (reg << 2));
+}
+
 #define shadowptr(_a6xx_gpu, _ring) ((_a6xx_gpu)->shadow_iova + \
 		((_ring)->id * sizeof(uint32_t)))
 

-- 
2.41.0

