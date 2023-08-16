Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A58D77E463
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343914AbjHPO6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343873AbjHPO57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:57:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C07910E9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:57:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c1c66876aso882807466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692197877; x=1692802677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nhu7qUgFNvKeZH+hR8i6J/UgYY5l7kY9GQdBaFblVZw=;
        b=mOxuAMzpiZk7uOwBll137LwsChgoZ2GjH1Kz1quS893yrKUKEmt3QRDzzsr1DtDllu
         GK9EK4qH/ZfmB45mo6VPDf4HdDl3MxbgDLzn0mzx+rsMTDVjQ4pKmNYto+GM8pphhzbp
         4kAgHN2gRLkG20GzxJPrshQv5tXB0kW+nBbI5p3lItSQccAZbIMhnCo+yEOrQqhfgVP1
         XGGNaZu34SoSybNQQL+vE397aCFnhAFTKrAE9qsSw96m3hEXPDUv8QIp2LhqKhgrT89B
         k3kx/s35hbSRbsjPZu3hAj1GiKY1k7wM7KaR6Gxih6oTECwkDJGyOa4vA8+e4tlDnKnG
         vmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692197877; x=1692802677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nhu7qUgFNvKeZH+hR8i6J/UgYY5l7kY9GQdBaFblVZw=;
        b=Jk+cf/l1ZKKAksNVesQDcqMFgVnvE0InceL6g3H6PW1w2gojQTI8o4/XeO4tYAyuVU
         zBa3hmqqPVKzhygtUA6kOpgL4qNIckxOBeHFcoW0hTBxIep46nNHt39wcy3kCeKJUXt1
         V5RIVw2/k9JvRtq8UCYPE+42PjJ4qfofPwoggeeo6FHF1t6UHceJWpSq0rRVOt/GVNDa
         lFV56bBnnSfXaIc8s46ScEXH31vzRCWshSZMMDQyZoRGm5Wf76p67DIjDeGKOb5UnMi8
         Vg04j9CtLeaf6e2rkdPMjrkCLzw1sf3Dofw6++xKwa3A+ezpoRE89jRAhZ0faUF8YCyV
         F5yw==
X-Gm-Message-State: AOJu0YzXXLt8/GRKaQV62BijZHX9eTLHiBt6HwPHvuglNS7MlYGaH3ue
        kLq9syJ3+wQvgciAwFw5XoOBNg==
X-Google-Smtp-Source: AGHT+IGhs6XfomhxZw6A/2i2NDiM6M0F+XDb/B8g19gpmZWAxwq278z9yA/vfMZHnjbJfq9v05jfKQ==
X-Received: by 2002:a17:906:8454:b0:987:5761:2868 with SMTP id e20-20020a170906845400b0098757612868mr1358210ejy.11.1692197876989;
        Wed, 16 Aug 2023 07:57:56 -0700 (PDT)
Received: from hackbox.lan ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906561000b00992076f4a01sm8610403ejq.190.2023.08.16.07.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:57:56 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: [PATCH v2 4/6] clk: qcom: Use HW_CTRL_TRIGGER flag to switch video GDSC to HW mode
Date:   Wed, 16 Aug 2023 17:57:39 +0300
Message-Id: <20230816145741.1472721-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816145741.1472721-1-abel.vesa@linaro.org>
References: <20230816145741.1472721-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Kona <quic_jkona@quicinc.com>

The current HW_CTRL flag switches the video GDSC to HW control mode as
part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
give consumer drivers more control and switch the GDSC mode as and when
required.

HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/videocc-sc7180.c | 2 +-
 drivers/clk/qcom/videocc-sc7280.c | 2 +-
 drivers/clk/qcom/videocc-sdm845.c | 4 ++--
 drivers/clk/qcom/videocc-sm8250.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sc7180.c b/drivers/clk/qcom/videocc-sc7180.c
index 5b9b54f616b8..51439f7ba70c 100644
--- a/drivers/clk/qcom/videocc-sc7180.c
+++ b/drivers/clk/qcom/videocc-sc7180.c
@@ -166,7 +166,7 @@ static struct gdsc vcodec0_gdsc = {
 	.pd = {
 		.name = "vcodec0_gdsc",
 	},
-	.flags = HW_CTRL,
+	.flags = HW_CTRL_TRIGGER,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
diff --git a/drivers/clk/qcom/videocc-sc7280.c b/drivers/clk/qcom/videocc-sc7280.c
index 615695d82319..3d07b1e95986 100644
--- a/drivers/clk/qcom/videocc-sc7280.c
+++ b/drivers/clk/qcom/videocc-sc7280.c
@@ -236,7 +236,7 @@ static struct gdsc mvs0_gdsc = {
 		.name = "mvs0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | RETAIN_FF_ENABLE,
+	.flags = HW_CTRL_TRIGGER | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc mvsc_gdsc = {
diff --git a/drivers/clk/qcom/videocc-sdm845.c b/drivers/clk/qcom/videocc-sdm845.c
index c77a4dd5d39c..dad011c48973 100644
--- a/drivers/clk/qcom/videocc-sdm845.c
+++ b/drivers/clk/qcom/videocc-sdm845.c
@@ -260,7 +260,7 @@ static struct gdsc vcodec0_gdsc = {
 	},
 	.cxcs = (unsigned int []){ 0x890, 0x930 },
 	.cxc_count = 2,
-	.flags = HW_CTRL | POLL_CFG_GDSCR,
+	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
@@ -271,7 +271,7 @@ static struct gdsc vcodec1_gdsc = {
 	},
 	.cxcs = (unsigned int []){ 0x8d0, 0x950 },
 	.cxc_count = 2,
-	.flags = HW_CTRL | POLL_CFG_GDSCR,
+	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index ad46c4014a40..c1b73d852f1c 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -293,7 +293,7 @@ static struct gdsc mvs0_gdsc = {
 	.pd = {
 		.name = "mvs0_gdsc",
 	},
-	.flags = HW_CTRL,
+	.flags = HW_CTRL_TRIGGER,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
@@ -302,7 +302,7 @@ static struct gdsc mvs1_gdsc = {
 	.pd = {
 		.name = "mvs1_gdsc",
 	},
-	.flags = HW_CTRL,
+	.flags = HW_CTRL_TRIGGER,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
-- 
2.34.1

