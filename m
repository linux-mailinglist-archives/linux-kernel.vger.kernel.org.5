Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7937978C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244537AbjIGQyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244542AbjIGQx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:53:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B85D1739
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:53:31 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50098cc8967so1893009e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694105553; x=1694710353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/nXqq80I4IzTYU/xw/l32pkZE5e0Wqos3W+T1+jfP8=;
        b=fntjTtuLJ2/x4rKqwWEQmwSAduS0mgL2Oqod6WukAYdp9q/xGolPtbyxTxQUQLTr44
         3jE5mwCgj5uRn1yUrxemh7MVJ/w4Hb+jqPSRTw7Q06Pg47aiGU2xExYIKl7Fy64YESnb
         DHiEBmDfppKlpQkiyKWhFwexH7y837BP7MvLfyP+yF01mBr6JCrpUQvjTtaMvoekSy6L
         QZ7h7TwmuTZpueaahPyIWO4UU6Z7N1zZCcMkbxlkEOvSRXvfoRcpgU/MGFi2r7LpK7CF
         kw0n3uJ+CyiWAZ9fJiewZO7NgGsO9pRLYSg3RvlFDwnoe2/IOg+hlz5IunCrhQq+C24U
         Ls9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694105553; x=1694710353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/nXqq80I4IzTYU/xw/l32pkZE5e0Wqos3W+T1+jfP8=;
        b=QKukWrJ3CTdo5RBBGoNnMcnu91bCbIlMyLTymHJOOkosbNsU5+sfI2mqOGzPD7RByI
         9lGtoaN1rs1ADI9NHFkkSzX/zXvguIxAiK8/CA6OxTNA0UbGCLM3SiNRSYw3+Gk45/3E
         ehwsmOiOgX1CwYjxT3IB4ka8JmYXGVCdpsJM4Hs9GpgKhNfmj/DqG79ptj2WDdLJlyEY
         J7zzjMI4buzrWIx/8oqHU1uiJ5Sq/DqTTJp+dGlOtTShUiBjrKcMePBnRphd0YBMYzWU
         mXJRlrXjoOfnnglPTDmKzL/lB+yxGRundoz4dnwHeXXtC/L63ipm8v+fCNgEMXr2YLL+
         ipXw==
X-Gm-Message-State: AOJu0Ywq+sRXZJG5KOM90Y/+agtP9n+HP2prAjgRTMR6bmyzy/wrz4Y1
        sAlP6bnalz9FlIKcDISL6VUaKymIpQHNngdCZKs=
X-Google-Smtp-Source: AGHT+IGqptEswUlG0hUEuEen1gglgR+GUxNpzhlwHVg0WMAC2RIUsxeJ8cynTSEoY0qRp5rsXklLTA==
X-Received: by 2002:a7b:ce95:0:b0:401:b0f2:88b4 with SMTP id q21-20020a7bce95000000b00401b0f288b4mr164275wmj.26.1694105058573;
        Thu, 07 Sep 2023 09:44:18 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d15-20020adffd8f000000b00317ab75748bsm23822145wrr.49.2023.09.07.09.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:44:18 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/17] media: qcom: camss: Pass icc bandwidth table as a platform parameter
Date:   Thu,  7 Sep 2023 17:43:57 +0100
Message-ID: <20230907164410.36651-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
References: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
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
2.41.0

