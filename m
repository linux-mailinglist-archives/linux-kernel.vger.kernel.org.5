Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B928D7ADBDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjIYPls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjIYPl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:41:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E078197
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:41:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40528376459so67661285e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656474; x=1696261274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FNhGMWyAqnTDmM0T1BgOt5wrTJ6u2MeyoOMIg65gD0=;
        b=lMeYIgJ+NzwNb7+qLmwuFzXZn04V0SXJkUwGnAJK2XP4eQQaYxmzpk+yunKpHaJ+f3
         HIoebVWxjM5zsJFPGDcVvM6CKrgWIOrRJWFAP7ojvvJOqGVfO2mKyRGFQ99JVy5zImVs
         EUghu2cLOCTDqfCMqY9lDV4by/0CZ1CScLJ+AG2aXTIUmkzyyLZq46MAOzloUzt++yrS
         k4nzzMh1QQ9ldtLjuVx3rejaOwXGLqLRg6FKzsaV7X5CaM9ljgzA9dC5gKL5+VetxlRJ
         C/3QIScqbP7194BysCISSZjYQAJqK2aja92Q4/qSHOd41nbZs46a/XMK1BsByd5IiZy1
         7rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656474; x=1696261274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FNhGMWyAqnTDmM0T1BgOt5wrTJ6u2MeyoOMIg65gD0=;
        b=XaD7LwH5ZWRE6naUm0bYedBNn+cHhWKLPrBOvJtcofsaKjTSwUSbBzzgH/8MqvGaaY
         rzMzGX+cris1Q0v9iwi1gfHd6RPwAOqXeQ4pqqIcWwBZmkOG0jkAgIIRZfdkAC5pL6YF
         cu9dd3D4xrdLY/l5IYmjjSsY102Qd4FAJQGRh/UMpvKV+qvYZMLfVPF2pkS78wrNep6Q
         SDbMDAqGMvtuq28kW8/6iLOHEaWKZJZMx2xUOx3HmwrJpflHvHH7V3qdrkkLklVoWzKM
         LkOaDkpmmNyIlKcXpIxW7ETPxN9MAlJ01PYo4nWf6BSfaeYEiyptcmrV8CTHFMvqeWlF
         MXnA==
X-Gm-Message-State: AOJu0Yy2+26pXUqRdGB84J9vpymSZjBJhgDRWymdSGleBiyjjVeA00p+
        2eXVXRJW8eJKMIGAl87a0uQuwA==
X-Google-Smtp-Source: AGHT+IHCTuVqSXI/4CODXvygzrIqcLZ0cck4FqlLYaH34chSvHPLsk0l8jfezj5yo9bq31nUQGuEeg==
X-Received: by 2002:a1c:7417:0:b0:3fe:d630:f568 with SMTP id p23-20020a1c7417000000b003fed630f568mr5693110wmc.39.1695656474636;
        Mon, 25 Sep 2023 08:41:14 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m15-20020a7bca4f000000b003fe4548188bsm15206155wml.48.2023.09.25.08.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:41:14 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v6 09/17] media: qcom: camss: Remove special case for VFE get/put
Date:   Mon, 25 Sep 2023 16:40:51 +0100
Message-ID: <20230925154059.837152-10-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925154059.837152-1-bryan.odonoghue@linaro.org>
References: <20230925154059.837152-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From sdm845 onwards we need to ensure the VFE is powered on prior to
switching on the CSID.

Currently the code tests for sdm845, sm8250 and then does get/set. This is
not extensible and it turns out is not necessary either since vfe_get and
vfe_set reference count.

Remove the over-conservative SoC version check.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # rb3 # db410c
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/qcom/camss/camss-csid.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 99f651e2021cb..95873f988f7e2 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -159,15 +159,17 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 	struct camss *camss = csid->camss;
 	struct device *dev = camss->dev;
 	struct vfe_device *vfe = &camss->vfe[csid->id];
-	u32 version = camss->res->version;
 	int ret = 0;
 
 	if (on) {
-		if (version == CAMSS_8250 || version == CAMSS_845) {
-			ret = vfe_get(vfe);
-			if (ret < 0)
-				return ret;
-		}
+		/*
+		 * From SDM845 onwards, the VFE needs to be powered on before
+		 * switching on the CSID. Do so unconditionally, as there is no
+		 * drawback in following the same powering order on older SoCs.
+		 */
+		ret = vfe_get(vfe);
+		if (ret < 0)
+			return ret;
 
 		ret = pm_runtime_resume_and_get(dev);
 		if (ret < 0)
@@ -217,8 +219,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 		regulator_bulk_disable(csid->num_supplies,
 				       csid->supplies);
 		pm_runtime_put_sync(dev);
-		if (version == CAMSS_8250 || version == CAMSS_845)
-			vfe_put(vfe);
+		vfe_put(vfe);
 	}
 
 	return ret;
-- 
2.42.0

