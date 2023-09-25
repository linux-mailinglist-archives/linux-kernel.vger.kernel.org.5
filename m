Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F06B7ADC37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjIYPr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjIYPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:47:36 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBF8C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-404fbfac998so75579095e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656844; x=1696261644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifKMgYO+e5m0ffw4v7ouj4QBUnl9Qz7bbgTpHwp8oVo=;
        b=K+57JA1JTNQddncyEyFtdVtdRHABVLYfi6DobSLG9gpCkHtqW6GPQubP9Hr+vkNDZN
         kRu0ySF0mvgUXkFrPmHa/Gc3DFqUoM770Cb5hDS2xLLAXTMusRQmZ2Nv3Kvlod4yXyZ8
         Phi7SWuaotMMRVGTQpg6IWE8H8J8yfivpR59a+FJC7Isyk7ak9+xyHiOl+JItuCFZ+Mq
         pUmqdOj9z8oJJTmUqQ5TTNItJeII3zvvLgQ9R6K5eb2thnf1vg0Ux5TjRyDsls7hL8aY
         xCcOBODJsHd9U2ywL6yVikulhCUMxnTJAWgfj6wNs3pyPtl/zdM1y1te2y2BZWMWzjNN
         2CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656844; x=1696261644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifKMgYO+e5m0ffw4v7ouj4QBUnl9Qz7bbgTpHwp8oVo=;
        b=XGiVxN5IxTACUDTwWY/2H1MO3JDtdtzHFjjnX3TSjduoBn/0sUjia5z9jz0noIzks+
         sjhzpjDkMQ/Nz23GGp74s4Tl2IRvJyQGoh+RfngGAgohWFMKnChasBwgN0KFvUN0Qlof
         gc+N7+C7Pw+REHtaolikB2V+F98GNFFEkefoaUhNePnl7OfWaoFxbc5a7N5T5760CcHn
         U8yyqhUcgT9DOdD/wM7IGK7rTLhOVkC93sMLt6/Dg0HjqzielSD9bFLhDMkbdXgVzbGV
         Mw8FWsCuH83Qa4aa6VhVgK2jJQgR1VSnlTaYV2mDB45SkV6wGXSi/iMLDRDRKRZPyjG+
         XqPQ==
X-Gm-Message-State: AOJu0Yxgc/7dgEDyBd1ELjC3Lje2J6k2FIJ/INSJJFAUVhxWonc9MP6h
        3u7jRU2F8iY1CELdujV7KVxV+qsefmAF8U/JSOw=
X-Google-Smtp-Source: AGHT+IFB3x9FVfLq1RzYVJOQig2A9+R2ANR8n7wE/7G1IY2rXniFcll8+aMurXlmQ4f59RoETV2MbQ==
X-Received: by 2002:a05:600c:291:b0:404:fc5c:15ed with SMTP id 17-20020a05600c029100b00404fc5c15edmr6507315wmk.35.1695656844381;
        Mon, 25 Sep 2023 08:47:24 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d4-20020adffd84000000b0031f34a395e7sm12077536wrr.45.2023.09.25.08.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:47:24 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [RESEND PATCH v6 12/17] media: qcom: camss: Functionally decompose CSIPHY clock lookups
Date:   Mon, 25 Sep 2023 16:47:02 +0100
Message-ID: <20230925154707.837542-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
References: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

