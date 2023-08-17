Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E6D77F943
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352041AbjHQOio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352022AbjHQOiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:38:22 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B338E30D4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe5c0e57d2so71671525e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692283099; x=1692887899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6XC+poJvxEFCaLIAoBJcZv+bqQts3pZAc/0VRAbwFk=;
        b=rwXQ0q7dzosmwQnAX940TetwmZkayCf4DgeNvSJzjtbrwJxc2bc36z7eXEKTFTst9p
         jioqRyeTo3T8PSelqOXPREiT1czmnEzEV2Wrxj0cihSOP0Jmt1AjAmZdX1OgPSMPqG8a
         GFk2TUC7beQmX9PgZSLuYklymmkYQ7bxz454y5JuRFvdEaajFMqk342kqCCjXyqAYkR5
         IdjEDniLIJ07VLkiUn7SgIwKDQwBFvGvkY34IdASC/0q6vctrZ19z4dLHutXlXOQ8wAw
         fM1Peii0flYWpBqCcanBrTrK/CXejV3o8PjDXQxN3mGg4ebXxocnxYjdoCVC6MEUnzrY
         R0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283099; x=1692887899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6XC+poJvxEFCaLIAoBJcZv+bqQts3pZAc/0VRAbwFk=;
        b=AMGkvk2G2lm5U+KotfdSlCoqjK3e2HpIM81F4xRydUKYhu3GbCKLiYScrFCI620Ypn
         UV+Xtqu9soE9wYDBfJGapQpW6eduEcBJ36s1WexEb1bFxN/gP8bm1CextJzcNNp7U6rG
         Sm+PA5cusvMEBHPg1A19wY6iUhpjxXnKr3YaQZdO4rqDk7vILWCDLq8sGHK8aVhVDD0p
         vUp4gqnUSo3yLmNNm//qMO9IN1mK3Wihn0QTLvqbyCY78IzlaY1MfBYK0ZP6ZKhA0+vb
         q46/a0KH1W/ldDXpj9KiTKdw6wHp4PxUF/4Llr+6He1CHTBLzxvBeNF97ydK+56HEftu
         Lkwg==
X-Gm-Message-State: AOJu0YwL8csTv3gxCvRlxo377Bf1jJe0sxKESkjnwNt0a41TQpuLQkea
        VUf6R/rzYIWLZW5VTsTIcHThww==
X-Google-Smtp-Source: AGHT+IHYyEqQFgpuVvYUK7qvAKntV6iBvesFlPgR/D0SWvbnckQuDcnIN3hp744UhBPvK6clYgP7IA==
X-Received: by 2002:adf:9d8d:0:b0:317:5d3d:c9df with SMTP id p13-20020adf9d8d000000b003175d3dc9dfmr4583744wre.18.1692283099193;
        Thu, 17 Aug 2023 07:38:19 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b0030647449730sm25218232wrq.74.2023.08.17.07.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:38:18 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/13] media: qcom: camss: Pass icc bandwidth table as a platform parameter
Date:   Thu, 17 Aug 2023 15:38:02 +0100
Message-ID: <20230817143812.677554-4-bryan.odonoghue@linaro.org>
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

Pass the bandwidth table as a platform parameter not if/else derived
pointer to the static table.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 29 +++++++----------------
 drivers/media/platform/qcom/camss/camss.h |  3 ++-
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 2f9d5ad303951..cf2ba31f698e2 100644
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
@@ -1737,6 +1731,8 @@ static const struct camss_resources sm8250_resources = {
 	.csiphy_res = csiphy_res_8250,
 	.csid_res = csid_res_8250,
 	.vfe_res = vfe_res_8250,
+	.icc_res = icc_res_sm8250,
+	.icc_path_num = ARRAY_SIZE(icc_res_sm8250),
 };
 
 static const struct of_device_id camss_dt_match[] = {
@@ -1753,14 +1749,10 @@ MODULE_DEVICE_TABLE(of, camss_dt_match);
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
@@ -1772,17 +1764,14 @@ static int __maybe_unused camss_runtime_suspend(struct device *dev)
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
index f632ee49ad83e..988c313b63551 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -84,6 +84,8 @@ struct camss_resources {
 	const struct resources *csid_res;
 	const struct resources *ispif_res;
 	const struct resources *vfe_res;
+	const struct resources_icc *icc_res;
+	const int icc_path_num;
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
2.41.0

