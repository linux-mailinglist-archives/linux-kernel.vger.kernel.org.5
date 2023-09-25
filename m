Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9897ADC1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjIYPrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjIYPrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:47:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3C8AF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso36849315e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656835; x=1696261635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc3QrJ7bPpNquzpdbmPtMRrT+D/boaJ7K4FKMOV9GkU=;
        b=H3PVYLPpnelNgvmpHOso/1Vm4/D6bOgu8VbEy+o6OwYWwc2VY9iseE9Sp63V83/VS8
         p74u16t27WkiUvbM8XIMPyvfIYXVuFirljLxJeK/S9zStv8GMldq7S9XLFUY44kkSIFr
         3Ktmn0tFGAI38qUa0HX3FCHsmhnt7PPIhSnrESED6rj+7adokcnJpQ9/WNBqg+iof7Hm
         IXa60ejcQg7WZET8DZ1Ukj8shqUQFeY5FrlHCfUhl28asThkwO9W56c0j7UU1mOw3jUN
         YFgbbaMAtrh4IM6npp9kymismfQT+X00SKXPHOFbCKdR+hmCZZ2Yonsd32ODFW0ngFh7
         s9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656835; x=1696261635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sc3QrJ7bPpNquzpdbmPtMRrT+D/boaJ7K4FKMOV9GkU=;
        b=KOkz25dSX5LA+8lYy97C/AOLosJXPTpmstbWPhg1iDzI5u+urgPDJ64Y3wiRVk94CA
         U+gkFfV3HiZbH8sm2fej4d2RPRk9ygBwNTTWjaRz4GfHrZCmldnYp5j8QLISEXosbjTG
         YbL96W7tBN1gF7uRysY7zMFmXew0RZXc7sXqz7x1Q+icPMT4bPG1Jk+mCw/nb1MVDqjO
         zBJjxMFaKoUkew8AC0acObm2mCgcfDXICzJVhYbYQHXFrybMpBisIZ2w3sVFaOBqaeB6
         jONFEJLp4SRtDKHEGJn+4fZiRNUyPi31+OqOuUmLe5K+oqoSEARFmcbzuOHp8DBbJ5uw
         ZKmg==
X-Gm-Message-State: AOJu0YwsKjctsuTM891QMWGRJcH+kcSjjEt4gK34y/Xtxj9qPiitCpc7
        XSaVFb5y9KqjMYlhoejhIaMKzg==
X-Google-Smtp-Source: AGHT+IG36AW3eM7yXuWX82AYCVyQ/lYpqfCIwvyKT2Wlv/+SLpJWnSF97hCUIVDjdLYa1A33ZDM2mg==
X-Received: by 2002:adf:fd01:0:b0:322:5d58:99b4 with SMTP id e1-20020adffd01000000b003225d5899b4mr5900724wrr.0.1695656835097;
        Mon, 25 Sep 2023 08:47:15 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d4-20020adffd84000000b0031f34a395e7sm12077536wrr.45.2023.09.25.08.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:47:14 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [RESEND PATCH v6 04/17] media: qcom: camss: Pass icc bandwidth table as a platform parameter
Date:   Mon, 25 Sep 2023 16:46:54 +0100
Message-ID: <20230925154707.837542-5-bryan.odonoghue@linaro.org>
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

Pass the bandwidth table as a platform parameter not if/else derived
pointer to the static table.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/qcom/camss/camss.c | 29 +++++++----------------
 drivers/media/platform/qcom/camss/camss.h |  3 ++-
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 8fa5dee75672d..f502b4d9e07c5 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1485,21 +1485,15 @@ static int camss_configure_pd(struct camss *camss)
 static int camss_icc_get(struct camss *camss)
 {
 	const struct resources_icc *icc_res;
-	int nbr_icc_paths = 0;
 	int i;
 
-	if (camss->version == CAMSS_8250) {
-		icc_res = &icc_res_sm8250[0];
-		nbr_icc_paths =	ICC_SM8250_COUNT;
-	}
+	icc_res = camss->res->icc_res;
 
-	for (i = 0; i < nbr_icc_paths; i++) {
+	for (i = 0; i < camss->res->icc_path_num; i++) {
 		camss->icc_path[i] = devm_of_icc_get(camss->dev,
 						     icc_res[i].name);
 		if (IS_ERR(camss->icc_path[i]))
 			return PTR_ERR(camss->icc_path[i]);
-
-		camss->icc_bw_tbl[i] = icc_res[i].icc_bw_tbl;
 	}
 
 	return 0;
@@ -1742,6 +1736,8 @@ static const struct camss_resources sm8250_resources = {
 	.csiphy_res = csiphy_res_8250,
 	.csid_res = csid_res_8250,
 	.vfe_res = vfe_res_8250,
+	.icc_res = icc_res_sm8250,
+	.icc_path_num = ARRAY_SIZE(icc_res_sm8250),
 };
 
 static const struct of_device_id camss_dt_match[] = {
@@ -1758,14 +1754,10 @@ MODULE_DEVICE_TABLE(of, camss_dt_match);
 static int __maybe_unused camss_runtime_suspend(struct device *dev)
 {
 	struct camss *camss = dev_get_drvdata(dev);
-	int nbr_icc_paths = 0;
 	int i;
 	int ret;
 
-	if (camss->version == CAMSS_8250)
-		nbr_icc_paths =	ICC_SM8250_COUNT;
-
-	for (i = 0; i < nbr_icc_paths; i++) {
+	for (i = 0; i < camss->res->icc_path_num; i++) {
 		ret = icc_set_bw(camss->icc_path[i], 0, 0);
 		if (ret)
 			return ret;
@@ -1777,17 +1769,14 @@ static int __maybe_unused camss_runtime_suspend(struct device *dev)
 static int __maybe_unused camss_runtime_resume(struct device *dev)
 {
 	struct camss *camss = dev_get_drvdata(dev);
-	int nbr_icc_paths = 0;
+	const struct resources_icc *icc_res = camss->res->icc_res;
 	int i;
 	int ret;
 
-	if (camss->version == CAMSS_8250)
-		nbr_icc_paths =	ICC_SM8250_COUNT;
-
-	for (i = 0; i < nbr_icc_paths; i++) {
+	for (i = 0; i < camss->res->icc_path_num; i++) {
 		ret = icc_set_bw(camss->icc_path[i],
-				 camss->icc_bw_tbl[i].avg,
-				 camss->icc_bw_tbl[i].peak);
+				 icc_res[i].icc_bw_tbl.avg,
+				 icc_res[i].icc_bw_tbl.peak);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 20c84e8328880..8b2e4adb923ef 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -84,6 +84,8 @@ struct camss_resources {
 	const struct camss_subdev_resources *csid_res;
 	const struct camss_subdev_resources *ispif_res;
 	const struct camss_subdev_resources *vfe_res;
+	const struct resources_icc *icc_res;
+	const unsigned int icc_path_num;
 };
 
 struct camss {
@@ -105,7 +107,6 @@ struct camss {
 	struct device **genpd;
 	struct device_link **genpd_link;
 	struct icc_path *icc_path[ICC_SM8250_COUNT];
-	struct icc_bw_tbl icc_bw_tbl[ICC_SM8250_COUNT];
 	const struct camss_resources *res;
 };
 
-- 
2.42.0

