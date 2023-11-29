Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9A7FDA03
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjK2Oo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjK2OoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:44:22 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E349D71
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:44:26 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso10210220e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269065; x=1701873865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wo1sJJZHw7KBTaKmEN30ScvrIwX30d4f2jOhkPUqxBM=;
        b=X1gXV94ruAV5S9zyfjWaEyRKdeCfE3RblTjDyDYZVZeyDNKAorOh7fhM8GmRLfodVV
         KkjBakbaAlGi7diufnEQO6rLvPoU2+AVjX5FjwssZ6Z3Tecd0HyVMahrFx1LO8OZWsIV
         POVTrs+GXH+lPxdTCUWc81YpZmhzUDKtRE8+Nkr36T6EY4+l5vKicdYqoYbUK/kVfYkZ
         DNJQjkIjpEt8Zwlmz33JqHdjR7h9qjtg4LdbiqrdBtgUUM2152eMIRmEuMHgTRkSN/2V
         vBACs1D+tA/UTpxeF1HYJI2kAADOp5rzYK61hPuMu9gL47j7ozlMiN7ysqNIfDiNHTHX
         A3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269065; x=1701873865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo1sJJZHw7KBTaKmEN30ScvrIwX30d4f2jOhkPUqxBM=;
        b=IHUzSlezVdInu2tMrBTTuT+xFDjgD7TfFAwD2sUUlLBZDLZnqLDOcdhi40hpoQ2G+P
         WzT6XhoNNcsw/i6Uhx8eZujbn9Dp23vnZvBwA00cn3nH6ld+1ngNcUE/6IVMjHxIqhBP
         BSEw5qp4bDZ9fbinb1q78YttgwPjb+ZFvQKgEAqVVB/HzrX+k4d3sdgwov30Dy/+pdSG
         l9VfOT0NbV6sC3mYT2su+fbdC1ijplUPK30rrTU83R9q2uhUBOLTeO/MuTuUxyT7Zqk0
         IlupNpp/3SDQ/424Oh8ZXKpqQR1G7j5RoeigSYN5zozZFeL4Ozv4xjseKxtRrQkQppEa
         gQyA==
X-Gm-Message-State: AOJu0Yy+S9fz7KsQcPDVqJ6xfPVWEEzGnSLdqrCoKtiHWUiOaagrefn/
        9Ug9Be7ITjQTgkgLa65TUYbu/g==
X-Google-Smtp-Source: AGHT+IHIFF7EvttkvKqxTdo7EUCkiD1rO8UjhJ/NykBDp9vXAQKIDUWYvgiQY1lP0nrgP7lsgpW8vw==
X-Received: by 2002:a05:6512:3d94:b0:507:9a66:3577 with SMTP id k20-20020a0565123d9400b005079a663577mr11819960lfv.5.1701269064766;
        Wed, 29 Nov 2023 06:44:24 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm7913738ejh.79.2023.11.29.06.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:44:24 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Nov 2023 15:44:02 +0100
Subject: [PATCH v3 05/12] iommu/arm-smmu-qcom: Add QCM2290 MDSS compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v3-5-4cbb567743bb@linaro.org>
References: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701269042; l=938;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ZKnU1eVaZSjTBiyHSPh2Tjy7o0Kv51jXq1kQ7e4q0JU=;
 b=0+UJnE/UFmA357lPZt/AVpOt+TH32uQu3LcDEhl3VCvws5BJst6hotge8OV/5/cQmoLRQIEVm
 h3sFcW4Ar/GDlhsMpOlDPsgg2azmr+u1A/lG/dy/MwcPNnwfEdJT2bg
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the QCM2290 MDSS compatible to clients compatible list, as it also
needs the workarounds.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 549ae4dba3a6..aea5e85b20ff 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -245,6 +245,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
+	{ .compatible = "qcom,qcm2290-mdss" },
 	{ .compatible = "qcom,sc7180-mdss" },
 	{ .compatible = "qcom,sc7180-mss-pil" },
 	{ .compatible = "qcom,sc7280-mdss" },

-- 
2.43.0

