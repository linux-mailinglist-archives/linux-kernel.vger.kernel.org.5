Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F25806F9C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378062AbjLFMZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377925AbjLFMZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:25:04 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD4211F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:25:06 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9e1021dbd28so95413666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 04:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701865505; x=1702470305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSPJqgRu7qPi+l+hmtBMdBdRoK+soEQmisUntrPtTec=;
        b=L7E3hyDLPETIVo6Mm8tHN2xAZSS7M80MQ/DlspehVsODjU4ROfs9Sg47z0PjkI5fPI
         vRqf1Irz2RrNMhKQ06qWb3KW96Jr8OtVFGAeCo/+uPcnkeYSnyGFP0C2UrrqjYUTrGN0
         q0z3Hv717Ev/hgYB0upmm+X2EfFyVF2LD3khSZaTjKwG3itzCCzMzMRQz8GLsVx5hPo4
         W0DQWxlu27iBHzBSQlj/BNB2KAIWvRAZlY0nW0NN6IJ7llIt891+eJl9WExf0RZvNIN6
         zY0N8aDdHKMwWGkEEmCBLE2nRK0Tou3iQ3aOSCR1iLQlE9FyZrMGscUJs48dXiwxyoGj
         Fkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701865505; x=1702470305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSPJqgRu7qPi+l+hmtBMdBdRoK+soEQmisUntrPtTec=;
        b=cHLzg3/tVHwd7A0/vVV2jAY7HiOSP/ATlZy33rvW3+Bw/DotTumwsQmOSEbSd0N6Fr
         DuQ9Tq3BCkhc1TLbE/CSmmN6EF9z1wtS3LirrTAOHJCJ/BYW51ceoXTY+Zw2r5TvWnrj
         gi8wzpEoLQMJavc6edgrwQrXNHGWFGqzU67awYAW8SGTuG8pQ4/4DB88A5hLzPYbspSX
         NMeZhIIvNn/RbwcOCv6G1NpZ3YdEl8bLIljh5tqP/w9ZhPuPumGahDJZ6sBuZ+/xVBWB
         oG5GdD0N3tVv4lolp37uoXNkrrQaifUaAUmF9lplBSaoB9697K64UMF/WfLNru4hakmA
         853w==
X-Gm-Message-State: AOJu0Yy82QEWHB6GTsQysSbIf3Uc0ej6OtPFFzmqLekiEAUqt//ZQJS6
        mu4fY7nux2kPLAjjAzo9otmm0Q==
X-Google-Smtp-Source: AGHT+IHtG3wgmSPxClZN+MYAjNI7aaFnXOPpyZPkxuMt1SL2AMOnDm2wdd1rH0jDoZWCCdIW+DoTtw==
X-Received: by 2002:a17:906:fc06:b0:a1c:fdb2:e9a7 with SMTP id ov6-20020a170906fc0600b00a1cfdb2e9a7mr476301ejb.141.1701865505354;
        Wed, 06 Dec 2023 04:25:05 -0800 (PST)
Received: from localhost.localdomain (2001-1c06-2302-5600-366d-ca8f-f3af-0381.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:366d:ca8f:f3af:381])
        by smtp.gmail.com with ESMTPSA id oz23-20020a170906cd1700b00a0ad10b3f68sm8188085ejb.205.2023.12.06.04.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 04:25:04 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     laurent.pinchart@ideasonboard.com, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v6.1] media: qcom: camss: Add support for named power-domains
Date:   Wed,  6 Dec 2023 13:25:00 +0100
Message-ID: <20231206122500.3798228-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <43621420-2482-4634-9c3e-1a3278481540@xs4all.nl>
References: <43621420-2482-4634-9c3e-1a3278481540@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Right now we use fixed indexes to assign power-domains, with a
requirement for the TOP GDSC to come last in the list.

Adding support for named power-domains means the declaration in the dtsi
can come in any order.

After this change we continue to support the old indexing - if a SoC
resource declaration or the in-use dtb doesn't declare power-domain names
we fall back to the default legacy indexing.

From this point on though new SoC additions should contain named
power-domains, eventually we will drop support for legacy indexing.

Tested-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 24 +++++++++++++-
 drivers/media/platform/qcom/camss/camss.c     | 31 +++++++++++++++----
 drivers/media/platform/qcom/camss/camss.h     |  2 ++
 3 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 60c4730e7c9d..083d1445a6e2 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1382,7 +1382,29 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
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
 		if (IS_ERR(vfe->genpd))
 			return PTR_ERR(vfe->genpd);
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 35918cf837bd..8de0e9e8d34b 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1522,13 +1522,32 @@ static int camss_configure_pd(struct camss *camss)
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
-		ret = PTR_ERR(camss->genpd);
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
+		if (!camss->genpd)
+			ret = -ENODEV;
+		else
+			ret = PTR_ERR(camss->genpd);
 		goto fail_pm;
 	}
 	camss->genpd_link = device_link_add(camss->dev, camss->genpd,
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 1ba824a2cb76..cd8186fe1797 100644
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

