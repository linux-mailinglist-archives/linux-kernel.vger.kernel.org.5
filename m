Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891757ADBE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjIYPmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjIYPl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:41:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03EA1BC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:41:19 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4053c6f0e50so58655535e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656478; x=1696261278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifKMgYO+e5m0ffw4v7ouj4QBUnl9Qz7bbgTpHwp8oVo=;
        b=yG7Lgeu7ePLO6AhYMQSrwqAi/uZjpUvnfB+wzgnSbmK4j+B06UVKef2gQZqoDJoZhc
         dML34HjtG1Bt/T/FF/35r2r4bk0n6f9D+RSfIiZT0yzc1l76HHH/AzVv1dEHwYdx4/MJ
         LxVploqoK1jZROxi0XfkB+CAHV6tMuBx8jVGUt+69uEJKPQREwvhudmExRSVGCyBKNxT
         tV4AcRfPXetw4PDUsu3yXYJ+QL/vtpJUhCKr1atygs87xctAdq19WScVynaYG/JVbmM2
         SqCueNXnI6keX2lAjLUlCbgqDvitZ56qbYHj1aWV0DJyahldezoJnDfprAIp8BZc0Pjz
         6Ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656478; x=1696261278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifKMgYO+e5m0ffw4v7ouj4QBUnl9Qz7bbgTpHwp8oVo=;
        b=WcI7IAztFqxv/XdlH4rGQUMLGgiuf7mxTnh3XRwjIaCMiXVikN2qmQwblW3s+Lg/uY
         gS/QbJp51Zw0zGaVNv8a967zJ9Bo7o0BdL9GqwlCgbGjcPAWFjUbciNV1We02mWlNivD
         FsYvJgYE31B5bdlhkqFho0rxzcObL96ILYXgCDElOx+NMH5YBWwoRa1G+v9n5enKS6+z
         3VN2MaRf2opbolA0pdIt19h8jzxJJRKXz7tkBwhGE0Qtpmq+t5ZvHAviHlYKFcmkTbxt
         D75SPqZ+ugmGNaT/rAFk3Nk3bpW3Jnpi7Gp/wQ0wYjpuSq+Jruj0RF546ukknecFHNuT
         2r4A==
X-Gm-Message-State: AOJu0YxLSpBcrB4Lc9nk7FdhZuvRLm23BwqZ0EjcimlEehuQfr6QN6Hm
        CKD0S7qfcq8QSt4kf0D3frSu0Q==
X-Google-Smtp-Source: AGHT+IHEEYXVNZNQn02zpyJAQnq6kp7M5Lyshun2VISXE6Gy7akpg6uayDh7bCN494jQrtTMC6Fieg==
X-Received: by 2002:a7b:c8ca:0:b0:404:72fe:ed5c with SMTP id f10-20020a7bc8ca000000b0040472feed5cmr6057734wml.29.1695656478191;
        Mon, 25 Sep 2023 08:41:18 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m15-20020a7bca4f000000b003fe4548188bsm15206155wml.48.2023.09.25.08.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:41:17 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v6 12/17] media: qcom: camss: Functionally decompose CSIPHY clock lookups
Date:   Mon, 25 Sep 2023 16:40:54 +0100
Message-ID: <20230925154059.837152-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925154059.837152-1-bryan.odonoghue@linaro.org>
References: <20230925154059.837152-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 18f9a4defb2a4..20bb361e9ad05 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -536,6 +536,15 @@ static int csiphy_init_formats(struct v4l2_subdev *sd,
 	return csiphy_set_format(sd, fh ? fh->state : NULL, &format);
 }
 
+static bool csiphy_match_clock_name(const char *clock_name, const char *format,
+				    int index)
+{
+	char name[16]; /* csiphyXXX_timer\0 */
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
@@ -656,19 +665,19 @@ int msm_csiphy_subdev_init(struct camss *camss,
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
2.42.0

