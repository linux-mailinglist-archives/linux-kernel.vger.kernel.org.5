Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E0275A5BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjGTFnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjGTFnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:43:14 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CB72D60
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:42:46 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a3a8d21208so334889b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689831759; x=1690436559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUALOMVIIGKbG8JEVq4pp7kzPYcPWB7nny4Y+Kz5V+0=;
        b=b+46+HyYoEjSiqRYKHLv9Q+SMSdRjl0EIka5IPmMW8J3jeE31C4SHEcCMivlZhqCdt
         T7gybJ5sVHbVqEpWhEYl9h1dQ8358G78odP9OVt6rqvYryAa4Tjh75zZ0xyzL/4Dsp1r
         HM/pWSkckfN2O3L6WoraJ8clZAkydHX+Z78JfYOanaEZxLAPAsV4Atc/OgYx14mxbVZq
         lOjVEolO9ntGRColMbeW+YKXsefwDQFhSeJCIH8bcC6Kekd1x3fT3fZ4MknmA7soBCx8
         j8J2cdCsJrHMDox+33fig25Ufn3IpasNYA9mQGpkj7jZKEXvLhT8+IDipa1MH9Oc74oT
         hZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689831759; x=1690436559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUALOMVIIGKbG8JEVq4pp7kzPYcPWB7nny4Y+Kz5V+0=;
        b=UtWcP66oFwu83xnESGdBlOVuGmxdE6TilEYZbl7LN+oi4pyn5rjgh2td/CQgoagYub
         zMoJ4SH6mOKmrI9KP8e+UvOMqhMTHxzh1e+PtF1zfyfJvYvdEKDcSlEIijK7489JniMl
         9Dm6YDX8yaLA38+ET6mYFND+vYtNXtELckXzJZJdAvzz1vko/8aodltPBA0/7TZi+vs+
         0UMRRPKH4cmmY5HoLrA7DbhDA4KxY9T5lJPNIH9jFAQbFkmExQJhk8yXkeKYyUSI/xHk
         LaBSM9XSBBgrGrKXMP2T9SGojVsNDV/cYP1e4Mls2rJ/5Tv+ClSOFbJanizZiCItHRPt
         N7QQ==
X-Gm-Message-State: ABy/qLYJ50Tf3xptHvXB5Uei3JFCfzKjkA30CIRFjY1YJmb2tpdm81J5
        +POzgTxVl+9l+LaLo9DmfZOF
X-Google-Smtp-Source: APBJJlGeKm3GXXTyZhwxm8R+nI5xz/XhlsLcog7ilTojlZyO5TzAThnewb5wEVqSc8xkcASIEq/Q+w==
X-Received: by 2002:a05:6808:ec8:b0:3a3:762b:4ee5 with SMTP id q8-20020a0568080ec800b003a3762b4ee5mr888795oiv.28.1689831759208;
        Wed, 19 Jul 2023 22:42:39 -0700 (PDT)
Received: from localhost.localdomain ([117.206.119.70])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001b85bb5fd77sm263367pls.119.2023.07.19.22.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 22:42:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 09/15] PM / devfreq: Switch to dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
Date:   Thu, 20 Jul 2023 11:10:54 +0530
Message-Id: <20230720054100.9940-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devfreq consumers like UFS driver need to work with multiple clocks
through the OPP framework. For this reason, OPP framework exposes the
_indexed() APIs for finding the floor/ceil of the supplied frequency of
the indexed clock. So let's use them in the devfreq driver.

Currently, the clock index of 0 is used which works fine for multiple as
well as single clock.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/devfreq/devfreq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index e36cbb920ec8..7686993d639f 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -88,7 +88,7 @@ static unsigned long find_available_min_freq(struct devfreq *devfreq)
 	struct dev_pm_opp *opp;
 	unsigned long min_freq = 0;
 
-	opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &min_freq);
+	opp = dev_pm_opp_find_freq_ceil_indexed(devfreq->dev.parent, &min_freq, 0);
 	if (IS_ERR(opp))
 		min_freq = 0;
 	else
@@ -102,7 +102,7 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
 	struct dev_pm_opp *opp;
 	unsigned long max_freq = ULONG_MAX;
 
-	opp = dev_pm_opp_find_freq_floor(devfreq->dev.parent, &max_freq);
+	opp = dev_pm_opp_find_freq_floor_indexed(devfreq->dev.parent, &max_freq, 0);
 	if (IS_ERR(opp))
 		max_freq = 0;
 	else
@@ -196,7 +196,7 @@ static int set_freq_table(struct devfreq *devfreq)
 		return -ENOMEM;
 
 	for (i = 0, freq = 0; i < devfreq->max_state; i++, freq++) {
-		opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &freq);
+		opp = dev_pm_opp_find_freq_ceil_indexed(devfreq->dev.parent, &freq, 0);
 		if (IS_ERR(opp)) {
 			devm_kfree(devfreq->dev.parent, devfreq->freq_table);
 			return PTR_ERR(opp);
@@ -2034,18 +2034,18 @@ struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 
 	if (flags & DEVFREQ_FLAG_LEAST_UPPER_BOUND) {
 		/* The freq is an upper bound. opp should be lower */
-		opp = dev_pm_opp_find_freq_floor(dev, freq);
+		opp = dev_pm_opp_find_freq_floor_indexed(dev, freq, 0);
 
 		/* If not available, use the closest opp */
 		if (opp == ERR_PTR(-ERANGE))
-			opp = dev_pm_opp_find_freq_ceil(dev, freq);
+			opp = dev_pm_opp_find_freq_ceil_indexed(dev, freq, 0);
 	} else {
 		/* The freq is an lower bound. opp should be higher */
-		opp = dev_pm_opp_find_freq_ceil(dev, freq);
+		opp = dev_pm_opp_find_freq_ceil_indexed(dev, freq, 0);
 
 		/* If not available, use the closest opp */
 		if (opp == ERR_PTR(-ERANGE))
-			opp = dev_pm_opp_find_freq_floor(dev, freq);
+			opp = dev_pm_opp_find_freq_floor_indexed(dev, freq, 0);
 	}
 
 	return opp;
-- 
2.25.1

