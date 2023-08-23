Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056B97855C1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjHWKpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbjHWKpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:45:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5EF10CF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:45:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31781e15a0cso4831284f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692787503; x=1693392303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9FgIR5BO1ZA/xwnNK7HzsY7163eVVAl221xkKgdSQ4=;
        b=mhAJonHk82O1JU38yvxq//f+PgwfunLi3MPyMMxfsOJEb0ZCqmh5XBUy/1UdB0f74l
         cHECz8xH1UvCOEDmrCPDR1+4j+6Dv8cGzofbVMulHAL/aDchojUGnS2wGv60ewN6ao/o
         D19WNIpawZ8kRgsVpnchBH60LMuZB1MW8kRiWMbZVtC6miQVYEOlbl5SCA5FwwXuSc+x
         U1c71nCjLDWMoq5qTHSih++bHWPpzAQPba22VtPTSwIBljwVmstxDXWcd2Unh+vGb33E
         Llag17Zk3cCGLA+LDB94GZw/3kbkEEs/wAEOMqnPYOpWhfGYPPNRK66r+hOPwso9/CmO
         uIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692787503; x=1693392303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9FgIR5BO1ZA/xwnNK7HzsY7163eVVAl221xkKgdSQ4=;
        b=AQiQFWu0IgJrj3A3ZosxxXeeNahDVwl5kCF2hH/85qoOvYmji2YEQuVN3wysslMxC/
         hMhFF7HTVxawxduEuBPrBGe4axNYp3Ta0L4oP1xp2NwkEBRGMlyKZQB2CSZ75+Mdz8/8
         ExygOA55yrPF/0oavhBsNrqF5F6IGBdxkCwH8BtBwO45nUDPOXwKs7HFxxur1Y+hdY66
         bs2sNBNUELnDr+dnuyn/orXmRg4vmv/d/HVIEeIDtf4pC+pCx1gtpx7n6h2N4CEpPYGW
         BCjWMQC4Sv/NgeLOcA+0LgChN4IUD2v2kC5IG3tf6YaPJUiNU3UM1hQUU6bWhvKPCid1
         3OYQ==
X-Gm-Message-State: AOJu0Yy0ZuET+65CPo1ThP4D7PNkm4KqWxhTQdUJleHUBCkSfYhDivQj
        tgOrLG509PLnovPos/6mvPL+0Q==
X-Google-Smtp-Source: AGHT+IG1+cvmYpNpk1eoo0KqVXeZN1HIsBfKTqiNgbwKTKafOvOkJR+Y/fxPgNluXdx8pZ5tnLXVHg==
X-Received: by 2002:a5d:4fc7:0:b0:314:1b36:f440 with SMTP id h7-20020a5d4fc7000000b003141b36f440mr8428218wrw.70.1692787503323;
        Wed, 23 Aug 2023 03:45:03 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4204000000b0031c5dda3aedsm6281213wrq.95.2023.08.23.03.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 03:45:02 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/15] media: qcom: camss: Functionally decompose CSIPHY clock lookups
Date:   Wed, 23 Aug 2023 11:44:40 +0100
Message-ID: <20230823104444.1954663-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
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

The csiphyX_timer and csiX_phy values need not be hard-coded. We can
functionally decompose the string matching inside of a loop.

Static string values are brittle, difficult to extend and not required
anyway since the camss->res->csiphy_num value informs us of the number
of CSIPHYs and hence the set of potential clocks for a given CSIPHY.

In simple terms if we have five CSIPHYs we can have no more and no less
than five csiphy_timer clocks. Similarly csi_phy core clocks have a 1:1
relationship with the PHY they clock.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../media/platform/qcom/camss/camss-csiphy.c  | 37 ++++++++++++-------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 0e8c2a59ea241..baf78c525fbfc 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -536,6 +536,15 @@ static int csiphy_init_formats(struct v4l2_subdev *sd,
 	return csiphy_set_format(sd, fh ? fh->state : NULL, &format);
 }
 
+static bool csiphy_match_clock_name(const char *clock_name, const char *format,
+				    int index)
+{
+	char name[CAMSS_RES_MAX];
+
+	snprintf(name, sizeof(name), format, index);
+	return !strcmp(clock_name, name);
+}
+
 /*
  * msm_csiphy_subdev_init - Initialize CSIPHY device structure and resources
  * @csiphy: CSIPHY device
@@ -550,7 +559,7 @@ int msm_csiphy_subdev_init(struct camss *camss,
 {
 	struct device *dev = camss->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	int i, j;
+	int i, j, k;
 	int ret;
 
 	csiphy->camss = camss;
@@ -666,19 +675,19 @@ int msm_csiphy_subdev_init(struct camss *camss,
 		for (j = 0; j < clock->nfreqs; j++)
 			clock->freq[j] = res->clock_rate[i][j];
 
-		if (!strcmp(clock->name, "csiphy0_timer") ||
-		    !strcmp(clock->name, "csiphy1_timer") ||
-		    !strcmp(clock->name, "csiphy2_timer") ||
-		    !strcmp(clock->name, "csiphy3_timer") ||
-		    !strcmp(clock->name, "csiphy4_timer") ||
-		    !strcmp(clock->name, "csiphy5_timer"))
-			csiphy->rate_set[i] = true;
-
-		if (camss->res->version == CAMSS_660 &&
-		    (!strcmp(clock->name, "csi0_phy") ||
-		     !strcmp(clock->name, "csi1_phy") ||
-		     !strcmp(clock->name, "csi2_phy")))
-			csiphy->rate_set[i] = true;
+		for (k = 0; k < camss->res->csiphy_num; k++) {
+			csiphy->rate_set[i] = csiphy_match_clock_name(clock->name,
+								      "csiphy%d_timer", k);
+			if (csiphy->rate_set[i])
+				break;
+
+			if (camss->res->version == CAMSS_660) {
+				csiphy->rate_set[i] = csiphy_match_clock_name(clock->name,
+									      "csi%d_phy", k);
+				if (csiphy->rate_set[i])
+					break;
+			}
+		}
 	}
 
 	return 0;
-- 
2.41.0

