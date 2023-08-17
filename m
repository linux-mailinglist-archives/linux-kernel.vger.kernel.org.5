Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED2877F968
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352129AbjHQOi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352064AbjHQOic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:38:32 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA5F2D74
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so72412055e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692283109; x=1692887909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9FgIR5BO1ZA/xwnNK7HzsY7163eVVAl221xkKgdSQ4=;
        b=gHn1w7/7/kZJJa+BfagaRBl9isCxX045mRuFkFIvYM4FnMedoT9l3/wrFOJtzhbqRX
         9QQJrVOc/+XjKALVj5AzpPOLeaY86TBTWkrfr/QNpn6v+/QE9eI+QKs0e/7XaMKhvcbo
         n+7PuO9HsJAviH8YIoe1ss4C0dWig7w+pCpmT9NV2DOHQfHZbBc30XG9CR17ifdoA80d
         Kl3HOhU/lLiuL25gIufh+cISF7MnyLNvPgC+gTXtoynCtGfEZ91x5BhLoq/4OCWCzF87
         00WsK1ew81/qvZdk911dboHl6CKdbimOAIghLJf9GnerkvYZmIcfZUvFLp8GWxRS7hLE
         XGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283109; x=1692887909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9FgIR5BO1ZA/xwnNK7HzsY7163eVVAl221xkKgdSQ4=;
        b=Ikr5h7p3oV7+hf73XujI8biXdAJZDI3iuq6/YXt8Br+cPdqEMMrMTLNqommYZuokKE
         IWdsmhj67KmCA+oePFzQCmceyae8Gyul2ObZ8KE34108kMxT3tYRfTUM4K0ehKXOv1Z7
         b1/RyMpmWDzdxHcfjrGklqDRbRQOJi4gOs6siv/8ub7o/AP699gouft1KawAYS8b28nY
         SQSkY7OH+5qhvXbk1EihdxJExUUCrJZWC7ULuaVAFYbKSwkZ6GdwG8SC7iepZqTQCgRB
         vwITg1sZPJ3NftaMpZqnKH6HnzUErTQf/+mHX3zOg+q/gYcmUBLe12LVa2NcGZE7OEgA
         YZng==
X-Gm-Message-State: AOJu0Yyg4O0ImH0AGvNtclQ1oDSy908RGJevovlcVSD/GwM1mnjeAYP+
        AfW1UT6sZitq0mwum3p0N9j9oQ==
X-Google-Smtp-Source: AGHT+IG/eZvxOjp+PkSiSxu0cR90gEMe0y3FwMtpT7CulsWnV/I1wCr6YWATi8HlHSiSxq/sxIuSMA==
X-Received: by 2002:a5d:55c7:0:b0:315:ad1a:5abc with SMTP id i7-20020a5d55c7000000b00315ad1a5abcmr5683508wrw.5.1692283109407;
        Thu, 17 Aug 2023 07:38:29 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b0030647449730sm25218232wrq.74.2023.08.17.07.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:38:28 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/13] media: qcom: camss: Functionally decompose CSIPHY clock lookups
Date:   Thu, 17 Aug 2023 15:38:10 +0100
Message-ID: <20230817143812.677554-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817143812.677554-1-bryan.odonoghue@linaro.org>
References: <20230817143812.677554-1-bryan.odonoghue@linaro.org>
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

