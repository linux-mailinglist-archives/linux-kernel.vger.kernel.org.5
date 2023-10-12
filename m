Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374897C71A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379405AbjJLPgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379472AbjJLPgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:36:11 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E38DD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:36:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50573e85ee0so1463368e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697124965; x=1697729765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yEra9Cx7XV54gD7YoJL8PZvFj4AkKcsevplc+yUjjs=;
        b=iVpU/7e/W+l21djRMT/avFeoxq6Vv+gnRBCsp4VRRi8IdkDLiPqUPRlGsDTnlyrqXC
         CTL8d/sD88NYw60ZUYKtp9uJpYVeJ1QkzxkIgfkFWH9HwvkbnBCMQZ0Wc9hscBafbp+4
         MJW2ksZLnw2sCxkVIma8voJvot/s4/ExRqFCUn2IK5t59/XhsbsaaYukxGxmEHZsYB5B
         uHMAgnbuJGVm3MHSRDZvpcjPSS0Bl3obPX4Qm+3674D+mOY9tDiJXCTR6WmoBMcwxgbJ
         WjfVQ3LCY4Eks9H/BW7tXkSidaWwzVsW5j7mIymEqzQyFmL+/63a7g2N5grse8/w3q7j
         JNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124965; x=1697729765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yEra9Cx7XV54gD7YoJL8PZvFj4AkKcsevplc+yUjjs=;
        b=Wg1ZQIP/nGrbtLpVZnyBrLRh9/+PZwU+XXCYc7NzfMDD7r4ApU3MPVp+zhqQ08XFP9
         gpz8OaBSByh7TH3gGPtNSe1NndKItApclJ8e77gVrs8kp+dD+GKLeCdLsQH/skYs/uxi
         J7olEpsD6l+ov2YCET+VC9LGPSAd2FyakAhAj0A4Uu8cmKQAMP74ae6A2i/7/8zkKn/p
         wSU7k53KK9en1TAD4XY/yiqBWTsD/eJ9NdDpMkn59SGDAsoEI0EmNG7EgdL4gezdlLFW
         o0eDBi4ohD6msPkVhiSdUGbSJmwRuvuZIzwi4m7DWZfGnDrAd4t1f37G+QNpbziErsbw
         53WA==
X-Gm-Message-State: AOJu0YxcAz4TdtNs6fkebTiBn7fQr/aTabb2L+uWVGumM3vUxF9qPR1O
        doJHeREXJ3H6jEUG8vuqZ+ENcw==
X-Google-Smtp-Source: AGHT+IFP2ID5YRRW16YE9Knvq4A85dNzlJuJl5qRjUGexoKPVjohIWJG2IIteA2GoSjoLy+QpiukuA==
X-Received: by 2002:a05:6512:1248:b0:4fe:711:2931 with SMTP id fb8-20020a056512124800b004fe07112931mr26256177lfb.22.1697124962504;
        Thu, 12 Oct 2023 08:36:02 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id b17-20020ac25631000000b0050482b29ac8sm2853085lff.31.2023.10.12.08.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 08:36:01 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/5] pmdomain: qcom: rpmpd: Drop the ->opp_to_performance_state() callback
Date:   Thu, 12 Oct 2023 17:35:58 +0200
Message-Id: <20231012153558.101445-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012152108.101270-1-ulf.hansson@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <->
level dance"), there is no longer any need for genpd providers to assign
the ->opp_to_performance_state(), hence let's drop it.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/qcom/rpmpd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index 3135dd1dafe0..524631dcab4b 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -908,12 +908,6 @@ static int rpmpd_set_performance(struct generic_pm_domain *domain,
 	return ret;
 }
 
-static unsigned int rpmpd_get_performance(struct generic_pm_domain *genpd,
-					  struct dev_pm_opp *opp)
-{
-	return dev_pm_opp_get_level(opp);
-}
-
 static int rpmpd_probe(struct platform_device *pdev)
 {
 	int i;
@@ -959,7 +953,6 @@ static int rpmpd_probe(struct platform_device *pdev)
 		rpmpds[i]->pd.power_off = rpmpd_power_off;
 		rpmpds[i]->pd.power_on = rpmpd_power_on;
 		rpmpds[i]->pd.set_performance_state = rpmpd_set_performance;
-		rpmpds[i]->pd.opp_to_performance_state = rpmpd_get_performance;
 		pm_genpd_init(&rpmpds[i]->pd, NULL, true);
 
 		data->domains[i] = &rpmpds[i]->pd;
-- 
2.34.1

