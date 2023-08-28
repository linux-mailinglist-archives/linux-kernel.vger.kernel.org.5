Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B13778AF2B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjH1LnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjH1Lmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:42:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F618E8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:42:41 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5007f3d3235so4832172e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693222959; x=1693827759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lczsHPUyJRmspH9y5x62IT1HsVcOeFxIgaLGYJlH4E=;
        b=C5SjzzzMpbr18uc/DlxwwjMrmmjwVRITRtzuLcH5CIPnEwdSQsiP7YRvrVmootWtP/
         yimvzQ+RFkjjU6f8R08QPdO4cT7F+W5gtwO+ir/t/nhkvkRbhN9YDQyiOS11hQVtSDBz
         6+p25zA6urAwJvB0qZrjYbO+0uKstKS5Z1dtY6i6N+/vgj69h/sLkMlA3PAjpFW+/odE
         CdYx2p6C4ukSjnxOm/eWp6KSAbAV59+kJVxufXcU5PXhbmodgGtvu2RNz2iy+gePnasS
         DFY8xPPf249l7Fn4LZqWCZ1CZURBsJGePier9a2UmFQ4cXAYQZa5gXIhWcCbyfQdmEaJ
         A67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693222959; x=1693827759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lczsHPUyJRmspH9y5x62IT1HsVcOeFxIgaLGYJlH4E=;
        b=lnKseZI87diQ0ekgGVqHRLtCFYXjIgYlKlbRPa/q2E7sJZ42LzlpZnjldpqm2SzzE+
         2d7TehMWntZswMXUHoxh9JxSjpWTnylxewuKwnd6EhdKUhfCdGG6yoT55Io/8nyJDu2N
         nhsh5xbyDYnKsN0BISDYRVEzr9+KbqCrNH/K2H0uKgZpnHutbPmIv0yKUBc8hUnwsCsZ
         V4D+z+RK/wvE4psFyyTzl6WXE6xLlP/wDgf8Bi3KPLdiQz6WN5VLttFa46cffdqkOF+I
         hOrbMvzz+jidUyoEbrAWgtjnY9G2j6aSu9X/Ud3exe4uJPOBdarBwGv7XqbJXselHsGW
         XYxQ==
X-Gm-Message-State: AOJu0YzCCwG9Ir7oCqbDwDgHIm7paUii8kMI78D87u4mG/AS/2B6sFU0
        qcrLYt55K1VKnWQ4ipGfyATjbw==
X-Google-Smtp-Source: AGHT+IGapV/pJW+FZOV9bNYIUhxqqJgkctTSP8QyEEptY1rT7ZXBDYXqmTIoWOn0ll3RCJCU5z+gZA==
X-Received: by 2002:a05:6512:615:b0:4fd:d9dd:7a1a with SMTP id b21-20020a056512061500b004fdd9dd7a1amr17484607lfe.31.1693222959556;
        Mon, 28 Aug 2023 04:42:39 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id b2-20020ac247e2000000b005009920b6afsm1547799lfp.9.2023.08.28.04.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 04:42:39 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 28 Aug 2023 13:42:17 +0200
Subject: [PATCH v14 5/9] soc: qcom: cpr-common: Add support for flat fuse
 adjustment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v14-5-9fd23241493d@linaro.org>
References: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693222948; l=2102;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=r+FZtgyjhOegt/rHxqeMXobV6M/mn9z4gyS+IPOc1vM=;
 b=U3Xoy4etONfYRJG0PDzYicPXwrijpIZrw7CCHzvb+YFPm0Kg6Ipp3U/krMDpjBkuNNqub+/gX
 1ySzgw7dkBGCBLIFqtTScwGbLDDASrIy/h1K4nJCcrj4A1noF4mtXNF
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

CPR3 makes use of post-calculation flat value adjustments. Add the
necessary bits to the common functions to support it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: separate this patch out of a bigger one]
Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/genpd/qcom/cpr-common.c | 9 ++++++---
 drivers/genpd/qcom/cpr-common.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/genpd/qcom/cpr-common.c b/drivers/genpd/qcom/cpr-common.c
index ea85f6b4bef8..44c681bbbf13 100644
--- a/drivers/genpd/qcom/cpr-common.c
+++ b/drivers/genpd/qcom/cpr-common.c
@@ -49,7 +49,7 @@ int cpr_populate_ring_osc_idx(struct device *dev,
 EXPORT_SYMBOL_GPL(cpr_populate_ring_osc_idx);
 
 static int cpr_read_fuse_uV(int init_v_width, int step_size_uV, int ref_uV,
-			    int step_volt, const char *init_v_efuse,
+			    int adj, int step_volt, const char *init_v_efuse,
 			    struct device *dev)
 {
 	int steps, uV;
@@ -67,6 +67,9 @@ static int cpr_read_fuse_uV(int init_v_width, int step_size_uV, int ref_uV,
 
 	uV = ref_uV + steps * step_size_uV;
 
+	/* Apply open-loop fixed adjustments to fused values */
+	uV += adj;
+
 	return DIV_ROUND_UP(uV, step_volt) * step_volt;
 }
 
@@ -119,8 +122,8 @@ int cpr_populate_fuse_common(struct device *dev,
 
 	/* Populate uV */
 	uV = cpr_read_fuse_uV(init_v_width, init_v_step,
-			      fdata->ref_uV, step_volt,
-			      cpr_fuse->init_voltage, dev);
+			      fdata->ref_uV, fdata->volt_oloop_adjust,
+			      step_volt, cpr_fuse->init_voltage, dev);
 	if (uV < 0)
 		return uV;
 
diff --git a/drivers/genpd/qcom/cpr-common.h b/drivers/genpd/qcom/cpr-common.h
index 1f2ebf9394cf..0aa227617d2f 100644
--- a/drivers/genpd/qcom/cpr-common.h
+++ b/drivers/genpd/qcom/cpr-common.h
@@ -22,6 +22,7 @@ struct fuse_corner_data {
 	int ref_uV;
 	int max_uV;
 	int min_uV;
+	int volt_oloop_adjust;
 	int max_volt_scale;
 	int max_quot_scale;
 	/* fuse quot */

-- 
2.42.0

