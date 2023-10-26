Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7027D8643
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345563AbjJZPvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345513AbjJZPu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:50:56 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E731B2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:50:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso16034301fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698335452; x=1698940252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/0Zzd2h9fLzU2CXuGA1RcrpOhxB8m/Gh7+HlmkqAUw=;
        b=NPXqt8Y67wLU1OHLO4XkIQXhhYEM+klnvmqAdAnTlijYCKsUWZBcsGC0sG7TOqCzgI
         DKCfO8yhsGQaJsrrLBLBvFjA4/RngM/O7ndVcxMh3f3IEidKrJ5wMFO5JdRknUvHhgwW
         9O+LXS19jYFJhIbmPkucmngjJUexNf9BvrpJRN9jsc+VNn15K1F3lL8LQz1pLaUV3AcG
         Rz9NfAyhu0y8njVBSvK0eYhKmZVUo67DQYoGnGF8m3N75dpplJjVdDTVP+676fgDhoP0
         XWa67fNHhH2G3Vn+AtDaOF8XNmVIvaOlGZ2lBchzpP4sFUWkgMQYzzak7iYmzMrVhoT1
         gdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335452; x=1698940252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/0Zzd2h9fLzU2CXuGA1RcrpOhxB8m/Gh7+HlmkqAUw=;
        b=T83vA8R2zwLpnFdPTDYjLXr7/Veu2eLie6amUXqFIwFG7C0bq4MP+F1/JOICOMWyv9
         b0MZ3Ns6a7eHbHO/BJJHQmBrcn8+Kgy2lpIRs56Ijm7XeZpVMAHZBC57Y8EGybgH8Gju
         ZjmkQ+HO68hcxZcdj4wPk91JPN+vKMlzLuDD0I63lNmsK2lGUslZjGYijMNM2lnJQdPu
         T6gobTnBSsw42Ab46P6ml1ZBdKo+XTd2MvZPx3sX+b11Z/jE1F9VPh7Z4VqTvA0wuD55
         6661tt7c/chEiD4GiLA2EiLq1jwAZpzExGOd3fKc48ie063iaY7FeahGwYie4iBhutSf
         g7iw==
X-Gm-Message-State: AOJu0YznYBD2gUubYhfPQ0ORGFjHySaTRHfn9Lrr7TiMpfoAKr6aQowO
        66faX9EqpruopZIpBqAkufSbjQ==
X-Google-Smtp-Source: AGHT+IGdDwoWbmfBp5QqiseXEmyfgqqvnQkSWmkf7AwMyNhrrJNhfHSH6bk/6iTeuxWXH4pNsjehUA==
X-Received: by 2002:a05:651c:11ca:b0:2be:3ca8:bdc9 with SMTP id z10-20020a05651c11ca00b002be3ca8bdc9mr11517838ljo.49.1698335451864;
        Thu, 26 Oct 2023 08:50:51 -0700 (PDT)
Received: from sagittarius-a.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b003feae747ff2sm2938289wms.35.2023.10.26.08.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:50:51 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH v2 5/5] media: qcom: camss: Add support for named power-domains
Date:   Thu, 26 Oct 2023 16:50:42 +0100
Message-ID: <20231026155042.551731-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026155042.551731-1-bryan.odonoghue@linaro.org>
References: <20231026155042.551731-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now we use fixed indexes to assign power-domains, with a
requirement for the TOP GDSC to come last in the list.

Adding support for named power-domains means the declaration in the dtsi
can come in any order.

After this change we continue to support the old indexing - if a SoC
resource declration or the in-use dtb doesn't declare power-domain names
we fall back to the default legacy indexing.

From this point on though new SoC additions should contain named
power-domains, eventually we will drop support for legacy indexing.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 24 ++++++++++++++++-
 drivers/media/platform/qcom/camss/camss.c     | 26 +++++++++++++++----
 drivers/media/platform/qcom/camss/camss.h     |  2 ++
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index ebd5da6ad3f2f..cb48723efd8a0 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1381,7 +1381,29 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 	if (!res->line_num)
 		return -EINVAL;
 
-	if (res->has_pd) {
+	/* Power domain */
+
+	if (res->pd_name) {
+		vfe->genpd = dev_pm_domain_attach_by_name(camss->dev,
+							  res->pd_name);
+		if (IS_ERR(vfe->genpd)) {
+			ret = PTR_ERR(vfe->genpd);
+			return ret;
+		}
+	}
+
+	if (!vfe->genpd && res->has_pd) {
+		/*
+		 * Legacy magic index.
+		 * Requires
+		 * power-domain = <VFE_X>,
+		 *                <VFE_Y>,
+		 *                <TITAN_TOP>
+		 * id must correspondng to the index of the VFE which must
+		 * come before the TOP GDSC. VFE Lite has no individually
+		 * collapasible domain which is why id < vfe_num is a valid
+		 * check.
+		 */
 		vfe->genpd = dev_pm_domain_attach_by_id(camss->dev, id);
 		if (IS_ERR(vfe->genpd)) {
 			ret = PTR_ERR(vfe->genpd);
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 03e955c7a7e4c..837bab28d40e2 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1514,12 +1514,28 @@ static int camss_configure_pd(struct camss *camss)
 		return 0;
 
 	/*
-	 * VFE power domains are in the beginning of the list, and while all
-	 * power domains should be attached, only if TITAN_TOP power domain is
-	 * found in the list, it should be linked over here.
+	 * If a power-domain name is defined try to use it.
+	 * It is possible we are running a new kernel with an old dtb so
+	 * fallback to indexes even if a pd_name is defined but not found.
 	 */
-	camss->genpd = dev_pm_domain_attach_by_id(camss->dev, camss->genpd_num - 1);
-	if (IS_ERR(camss->genpd)) {
+	if (camss->res->pd_name) {
+		camss->genpd = dev_pm_domain_attach_by_name(camss->dev,
+							    camss->res->pd_name);
+		if (IS_ERR(camss->genpd)) {
+			ret = PTR_ERR(camss->genpd);
+			goto fail_pm;
+		}
+	}
+
+	if (!camss->genpd) {
+		/*
+		 * Legacy magic index. TITAN_TOP GDSC must be the last
+		 * item in the power-domain list.
+		 */
+		camss->genpd = dev_pm_domain_attach_by_id(camss->dev,
+							  camss->genpd_num - 1);
+	}
+	if (IS_ERR_OR_NULL(camss->genpd)) {
 		ret = PTR_ERR(camss->genpd);
 		goto fail_pm;
 	}
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 1ba824a2cb76c..cd8186fe1797b 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -48,6 +48,7 @@ struct camss_subdev_resources {
 	u32 clock_rate[CAMSS_RES_MAX][CAMSS_RES_MAX];
 	char *reg[CAMSS_RES_MAX];
 	char *interrupt[CAMSS_RES_MAX];
+	char *pd_name;
 	u8 line_num;
 	bool has_pd;
 	const void *ops;
@@ -84,6 +85,7 @@ enum icc_count {
 
 struct camss_resources {
 	enum camss_version version;
+	const char *pd_name;
 	const struct camss_subdev_resources *csiphy_res;
 	const struct camss_subdev_resources *csid_res;
 	const struct camss_subdev_resources *ispif_res;
-- 
2.42.0

