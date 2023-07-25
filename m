Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E91760DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjGYIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjGYIw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:52:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219C61BF8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:52:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31297125334so3359831f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690275120; x=1690879920;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SO2fJhdIilzQKSUOeloEP2TDsXS2dBpxn1k7xAINQDE=;
        b=Sa6/7jmR6HjLFfJOReKmBDHqp0oS7SanRctcQNx34dqi05GjH7X5j5Urm5cm/f97/c
         LBXeln34oj+AaQTNQpcQPpkQiSf/C+8XprS0/5cua/cNGmjXQ2KWKIlXlRGqEUsoqw6i
         6pWZLkduJ8BA7ijAUsLE4T6fvOQmSdAHROxi4T7WNwLIn3zxEbli1WTH4YpVjvULxnaU
         1Xb0VjHWhDQoA43vGGpWGTD4KG/ztapc/nLqvxXlJbqwwy6j+Ynf8yvpw83WW5T9SLyF
         7W1SqFBxn83aYAQ+St5WhbpOi0f2vS8L4q1LZxx1g5M9KASHz2FR+0ezk3mybESegiWd
         OSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690275120; x=1690879920;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SO2fJhdIilzQKSUOeloEP2TDsXS2dBpxn1k7xAINQDE=;
        b=k+feCPHeGMf8L0Qp88bJCxOxuerfuS9pkbz6vM7wiT+5jWsz3yrxehMwfSRjso4xDj
         ZX3YqcIC+g2Ev7zLa2l/qm5a+XlqTpWOQaAfUc5XJ0EHPHWAyu29Vj5i9hOGpc7RmMON
         2MVrny23F0nmlk0/VbcgQTlvogEnCZSd2ZK3q/9jEzStZsTXkdUarzKaEgEZYwMYqaME
         9zYQtVtCBB1jAuHSU09jTmC1IWYhtdw21lkAQb/oY1qpeC+8IjO9YtpiuVh9RMinwpSt
         AVWv3tD1ME81y8EnkapFhKcaE+fAazvWekxa9tUko78aWONHfnyHYKM6rVy6SyVjA4Tq
         EU6g==
X-Gm-Message-State: ABy/qLYX4yxpwn6mY0+WOraZvyKI8w7N6eesNkKIBUrdpgUHuRkaBfV5
        rd+qg9KIJbyfoPEHlk1doIxP3g==
X-Google-Smtp-Source: APBJJlGddeMpp0ssush6Q0wqtfS47dG4nR00hXv48WU3nXs23OHZlCKw4jpcwuiHKEP/SG7rKaXHFw==
X-Received: by 2002:a05:6000:1204:b0:317:6855:dc24 with SMTP id e4-20020a056000120400b003176855dc24mr1284761wrx.21.1690275120494;
        Tue, 25 Jul 2023 01:52:00 -0700 (PDT)
Received: from [192.168.1.101] (abxj221.neoplus.adsl.tpnet.pl. [83.9.3.221])
        by smtp.gmail.com with ESMTPSA id r5-20020a5d52c5000000b003143bb5ecd5sm15672475wrv.69.2023.07.25.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:52:00 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 25 Jul 2023 10:51:56 +0200
Subject: [PATCH] clk: qcom: dispcc-sc8280xp: Use ret registers on GDSCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230725-topic-8280_dispcc_gdsc-v1-1-236590060531@linaro.org>
X-B4-Tracking: v=1; b=H4sIACuNv2QC/x2NWwqDMBAAryL73UAeiNKrlCLJZqMLEkO2LQXx7
 l36OQPDnCDUmQTuwwmdPix8VAV3GwC3WFcynJXBWx/s5EfzOhqjmf1sl8zSEJc1C5rk4lQCja4
 EBI1TFDKpx4qb5vW97ypbp8Lf/+3xvK4fo7t4CX0AAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690275119; l=1704;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3kl4LXmb8XT+BmJFp1ldVHzPBlPIncVLnyDnPvEkf+U=;
 b=OUIRvNEgX4mC28YR+Lg3sgPwTO4sdyfWZs7WgYm63ie8AJiVdyBxq3nOkWtMbdnUlSjXvW1VN
 to8vJ7tWhJZDCNh9fljTcFCgpy9PbRI09R5iqleWDk5lgCbrZrXqRH4
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DISP_CC GDSCs have not been instructed to use the ret registers.
Fix that.

Fixes: 4a66e76fdb6d ("clk: qcom: Add SC8280XP display clock controller")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/dispcc-sc8280xp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sc8280xp.c b/drivers/clk/qcom/dispcc-sc8280xp.c
index 167470beb369..30f636b9f0ec 100644
--- a/drivers/clk/qcom/dispcc-sc8280xp.c
+++ b/drivers/clk/qcom/dispcc-sc8280xp.c
@@ -3057,7 +3057,7 @@ static struct gdsc disp0_mdss_gdsc = {
 		.name = "disp0_mdss_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL,
+	.flags = HW_CTRL | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc disp1_mdss_gdsc = {
@@ -3069,7 +3069,7 @@ static struct gdsc disp1_mdss_gdsc = {
 		.name = "disp1_mdss_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL,
+	.flags = HW_CTRL | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc disp0_mdss_int2_gdsc = {
@@ -3081,7 +3081,7 @@ static struct gdsc disp0_mdss_int2_gdsc = {
 		.name = "disp0_mdss_int2_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL,
+	.flags = HW_CTRL | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc disp1_mdss_int2_gdsc = {
@@ -3093,7 +3093,7 @@ static struct gdsc disp1_mdss_int2_gdsc = {
 		.name = "disp1_mdss_int2_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL,
+	.flags = HW_CTRL | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc *disp0_cc_sc8280xp_gdscs[] = {

---
base-commit: 1e25dd7772483f477f79986d956028e9f47f990a
change-id: 20230725-topic-8280_dispcc_gdsc-b1a7f3e51f3c

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

