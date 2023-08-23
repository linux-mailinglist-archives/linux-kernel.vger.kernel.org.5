Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CF2785708
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjHWLqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbjHWLpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:45:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E140E6C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 04:45:44 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so46370681fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 04:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692791143; x=1693395943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjH481Mf/JKMLSS8Dehl9BZait7n4XBpkdkpaAiw/gc=;
        b=jiMw21MAtfSSZZamwPjrKgZisbPFYjJNfmVMTY7M+qXHI+TjVXKX+VzvCia/akMOpD
         7Vdte8K+0r9v3PCDyVB6vLOCrKxsuixhOtQyOh2lXtIf7CG8X86WevPFOp1Vp93g4xwl
         Qd/GsDcACXa6D02nXVfrQeju44MCnUlJhDKE9uHJpJFgMc8RyRSyJYDQOZJzKlALzDvV
         5WQtN4D5GP/V3aIG4rsG8Gv+4SlVLs843zoVj3+vpYy3LZL5GYLHZVhpH851Tqn6JYbQ
         FXqxO/caaAB+zjOsK/7AGHjjotDUxWawb0SsXcewacFdq03fy3FQ/h+KYEiO6TdfXNTU
         xHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692791143; x=1693395943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjH481Mf/JKMLSS8Dehl9BZait7n4XBpkdkpaAiw/gc=;
        b=GOq0Fw3M55gYDB9LThPHlhj2/gTUNjUEcaJyvUNDULSHARtHrNrb6Fg1gNw6mv9exs
         uI+ECVULuEVyWGR0G34ynPq4s2hriLs9zu+Ek5IeAwSAM+UXdpYWYQ3ZcykfRDvYarjO
         FkZGUVWdhdFlJOwxVwBNUM0ULLxPX0n0hisP1HWXe7/GXccROG10fZPUnrHBpui37TC8
         LsUulmv3xS3lQW6tagemm/XdO0nWk7vbWfAgFEBIM8UXwAWXBW9hOxNicl/SRUT5ZmPS
         3JsZpuGxfelRE0JaoAIt9IgM65FMmvu7N36Vx+VbaFtmD13+hrbM/Ye7ELD8fVcMAFxT
         jzeA==
X-Gm-Message-State: AOJu0Yyjt3Gf8sY0w4L1F/Em/gMDqLiehfDZnuD63VTXEJXQFLi0lOeN
        JKjEhynpG0uuENyvzbDnMz26uA==
X-Google-Smtp-Source: AGHT+IHv2sYKsl83YnEQionvwx0hiN959Vk/xragTx2/5jUNBywepZwvuDhDBa1tzQ/GfQkGBPpKsQ==
X-Received: by 2002:a2e:8746:0:b0:2b9:20fe:4bc4 with SMTP id q6-20020a2e8746000000b002b920fe4bc4mr8847065ljj.40.1692791142942;
        Wed, 23 Aug 2023 04:45:42 -0700 (PDT)
Received: from hackbox.lan ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bce12000000b003fbc0a49b57sm18503577wmc.6.2023.08.23.04.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:45:42 -0700 (PDT)
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
Subject: [PATCH v3 4/5] clk: qcom: Use HW_CTRL_TRIGGER flag to switch video GDSC to HW mode
Date:   Wed, 23 Aug 2023 14:45:27 +0300
Message-Id: <20230823114528.3677667-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823114528.3677667-1-abel.vesa@linaro.org>
References: <20230823114528.3677667-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Changes since v2:
 * The 5th patch was squashed into this one. No other change done.

 drivers/clk/qcom/videocc-sc7180.c | 2 +-
 drivers/clk/qcom/videocc-sc7280.c | 2 +-
 drivers/clk/qcom/videocc-sdm845.c | 4 ++--
 drivers/clk/qcom/videocc-sm8250.c | 4 ++--
 drivers/clk/qcom/videocc-sm8550.c | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

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
 
diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
index 3bb136ec31b1..504b2ef264eb 100644
--- a/drivers/clk/qcom/videocc-sm8550.c
+++ b/drivers/clk/qcom/videocc-sm8550.c
@@ -324,7 +324,7 @@ static struct gdsc video_cc_mvs0_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.parent = &video_cc_mvs0c_gdsc.pd,
-	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL_TRIGGER,
 };
 
 static struct gdsc video_cc_mvs1c_gdsc = {
@@ -349,7 +349,7 @@ static struct gdsc video_cc_mvs1_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.parent = &video_cc_mvs1c_gdsc.pd,
-	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL_TRIGGER,
 };
 
 static struct clk_regmap *video_cc_sm8550_clocks[] = {
-- 
2.34.1

