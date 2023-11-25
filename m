Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481647F8B89
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjKYOS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjKYOSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:18:07 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4361419B7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:18:04 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54b18dbf148so756570a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700921882; x=1701526682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzHhRUdqYzC89phn7gbVveYcCLwhSTvqnPb56NAvVOE=;
        b=pnfuDuliMnWP+SaVlGGDpsn0CZ39xWwrWNF4xIGEAIC24Pp/uWorJIhN0R67RZL2RL
         ERYRJtBU4TVBeemPUcr+jAAu6HXpGJSXhPmM2efBtsKXWwC/lPasiFZQJzYBOe0bOY/u
         tdKbKTIyP4miypd3uImGfd4JWJgAaXuM41NHfyTtI1UCj52QRAq0hVsLU9OVw7NJCMox
         FsE3zqR0aWEEVYAvMUjyQaQvZdZv2ZJnihbCYbZeTVtnxbNWN4om5XrHr3jye2qgJGVQ
         d0tmU9RfFfyaSVom4SAywjDEyEfVD6pZrAWqBtKOjXELKuYrNI92QyJsI7b9Uqv+PHGn
         d7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700921882; x=1701526682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzHhRUdqYzC89phn7gbVveYcCLwhSTvqnPb56NAvVOE=;
        b=NOExUHE0L+Y2en0+UGLJLX7FUFzEK4sLPJ9sd9g6lz0DRpAfqK2qgibp6w5sezGSCM
         DVbFPpnL7Vk5XCzmDn1pNYslcN5MKJSvJKhvNtCGtVFq1WzgHZtsyq7EjFqbhkH2U2UE
         dd8YX8WKsMPARmrdVmEYNqcXaHygHtZYcGl2AHX+vBy5xP3FG6gOxoCTHGaW24yzaTHQ
         QQ/kxnOdj3n7a60OIAwE+1DtMpPnOCRWTUytibiQAkXDPR5ozVEFmncMg/50ip1KeKHd
         +zeQ5jaJ+H72rHe9/4kg69YLU0O99YsdkEx67y5nUGtGA0SO6ItpEt765UrdvcZLp6vm
         8KmA==
X-Gm-Message-State: AOJu0Yxh2zffAJHSRM7d6KfKGdB0JCAXGmFChY+nFjpq/cE0f5wl7LYf
        Rs+loJyn2COuKBruCHgqjAbvCA==
X-Google-Smtp-Source: AGHT+IHXbZJnn2kOU8oXhY8kFLv+tE8yUR0pfflIMAwddWoIAfdAVmz/M0agvUGtae4E5qmsjnU5iw==
X-Received: by 2002:a17:906:2492:b0:9be:30c2:b8fd with SMTP id e18-20020a170906249200b009be30c2b8fdmr4666298ejb.66.1700921882378;
        Sat, 25 Nov 2023 06:18:02 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906319300b00992b8d56f3asm3500345ejy.105.2023.11.25.06.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 06:18:02 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 25 Nov 2023 15:17:35 +0100
Subject: [PATCH 07/12] iommu/arm-smmu-qcom: Add QCM2290 DPU compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v1-7-11d71b12b058@linaro.org>
References: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
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
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700921858; l=876;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=G/TOscakzMl5L7lLg+f1aIz+xjyCycciuqgvdkeUR9s=;
 b=ENgDCU5tCX4v9CkymJG/T7LJb4knR81cFyT/XGNKMDSPge5mWTB461TNnqV2zeQTm7ByPYw3U
 DyVZSXIxFr+D79fGF41S3jBKCH0oWSysSTWmlLWRPUZHnV063SCSZUJ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the QCM2290 DPU compatible to clients compatible list, as it also
needs the workarounds.

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

