Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A127855A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjHWKo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjHWKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:44:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC12CDF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:44:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fef2f05356so26215585e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692787490; x=1693392290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLS0B+SArRid/e9AB/VEkQGWQx14zSatlMTcSargJZU=;
        b=nXV88WHPOYY9HGbq1FnGn9LiAQCFnGn0qNe6AauoCnz4hWRTn+NY8kZMklHW4eL4uy
         aD8ZXPNs5wS25inqE9OxVjMAVdkApSUr7ZXtWSMgqtZovmKgKofmwtDutfwdirhvo/0h
         WQqqbTc5O0GPEvgumuhXiocAPtHCfPHhHgLN3ZT5jviOg5e4+9CBcx/PgtJiv0dJBOH6
         j20EfmTZhMZOlBIWDnHE9hNp18DLpLweG2RefVl6QE8uq0ilTsxD6t1E4TQy3ubnJlvu
         qG7JipC3pHX2uEztcQBlIFCnFGxMVWv6ZDKltTuXeiQuuzAozLtu0MIigSmoge2Ji/+0
         xsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692787490; x=1693392290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLS0B+SArRid/e9AB/VEkQGWQx14zSatlMTcSargJZU=;
        b=leba/xPHVByfQCS/YybIOOd26gzf9xk+IxsJsQ2pzK+0qzg+iZz6/IDAGJxI7v9sNT
         S6RO5FtZ2uG5Q3ZQOL3cyHKtOWhE9Kry2obM9VgMtpq/g/BaK6L4ge2h9MY59kWZJMFo
         CM8Nka9jwQeq1iaDnLqXjE2ASTLlVhQ9ftlVqsrqBU2bIm9Q0qp05wlNr62LwcFDP9YP
         tiEnx6TALoYV+wx0mHCZtNCa0ULgI5BR/hA1ABN7EQRpl/6TE/bdAj4FiuI9UHm90aXD
         /ffcebiWoZccG3m4K1VSgGzOwUFtocW1ltU5AypvSCsa2K8p+LhZ3CObKhAj/lEYunPH
         dEng==
X-Gm-Message-State: AOJu0Yx1gIiU0S8EqPblQDHlfAz7bJVFSdj6Ael1FYpk7K7vMLnRMPsK
        wMS+8QNfmwXrvdgmIn5oxKW/lekJ3fzEfNM0iQo=
X-Google-Smtp-Source: AGHT+IGTCInGt3SIRkdiOlVQctVvqEx6n0AIAtNdDfsbxUsOSKf+y4irFY7Qqvc2cY3q8ANvkzwpyQ==
X-Received: by 2002:a1c:f304:0:b0:3fe:4900:db95 with SMTP id q4-20020a1cf304000000b003fe4900db95mr10142976wmq.37.1692787490508;
        Wed, 23 Aug 2023 03:44:50 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4204000000b0031c5dda3aedsm6281213wrq.95.2023.08.23.03.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 03:44:49 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/15] media: qcom: camss: Amalgamate struct resource with struct resource_ispif
Date:   Wed, 23 Aug 2023 11:44:30 +0100
Message-ID: <20230823104444.1954663-2-bryan.odonoghue@linaro.org>
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

There is no good reason to differentiate the two resource structures
here. As part of a general tidyup of the declaration and passing of
resources within in the CAMSS driver it will be advantageous to have
one unified resource structure.

The two structures are very similar anyway thus leading more credence
still to the argument there should be only one.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-ispif.c |  4 ++--
 drivers/media/platform/qcom/camss/camss-ispif.h |  4 ++--
 drivers/media/platform/qcom/camss/camss.c       | 14 +++++++-------
 drivers/media/platform/qcom/camss/camss.h       |  8 +-------
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
index 1c7e4b1b49401..61765b874b9a2 100644
--- a/drivers/media/platform/qcom/camss/camss-ispif.c
+++ b/drivers/media/platform/qcom/camss/camss-ispif.c
@@ -1095,7 +1095,7 @@ static int ispif_init_formats(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
  * Return 0 on success or a negative error code otherwise
  */
 int msm_ispif_subdev_init(struct camss *camss,
-			  const struct resources_ispif *res)
+			  const struct resources *res)
 {
 	struct device *dev = camss->dev;
 	struct ispif_device *ispif = camss->ispif;
@@ -1152,7 +1152,7 @@ int msm_ispif_subdev_init(struct camss *camss,
 
 	/* Interrupt */
 
-	ret = platform_get_irq_byname(pdev, res->interrupt);
+	ret = platform_get_irq_byname(pdev, res->interrupt[0]);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/media/platform/qcom/camss/camss-ispif.h b/drivers/media/platform/qcom/camss/camss-ispif.h
index fdf28e68cc7d8..c7c41f7afcaad 100644
--- a/drivers/media/platform/qcom/camss/camss-ispif.h
+++ b/drivers/media/platform/qcom/camss/camss-ispif.h
@@ -66,10 +66,10 @@ struct ispif_device {
 	struct camss *camss;
 };
 
-struct resources_ispif;
+struct resources;
 
 int msm_ispif_subdev_init(struct camss *camss,
-			  const struct resources_ispif *res);
+			  const struct resources *res);
 
 int msm_ispif_register_entities(struct ispif_device *ispif,
 				struct v4l2_device *v4l2_dev);
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index f4948bdf3f8f9..de39dc987444f 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -93,14 +93,14 @@ static const struct resources csid_res_8x16[] = {
 	},
 };
 
-static const struct resources_ispif ispif_res_8x16 = {
+static const struct resources ispif_res_8x16 = {
 	/* ISPIF */
 	.clock = { "top_ahb", "ahb", "ispif_ahb",
 		   "csi0", "csi0_pix", "csi0_rdi",
 		   "csi1", "csi1_pix", "csi1_rdi" },
 	.clock_for_reset = { "vfe0", "csi_vfe0" },
 	.reg = { "ispif", "csi_clk_mux" },
-	.interrupt = "ispif"
+	.interrupt = { "ispif" }
 
 };
 
@@ -234,7 +234,7 @@ static const struct resources csid_res_8x96[] = {
 	}
 };
 
-static const struct resources_ispif ispif_res_8x96 = {
+static const struct resources ispif_res_8x96 = {
 	/* ISPIF */
 	.clock = { "top_ahb", "ahb", "ispif_ahb",
 		   "csi0", "csi0_pix", "csi0_rdi",
@@ -243,7 +243,7 @@ static const struct resources_ispif ispif_res_8x96 = {
 		   "csi3", "csi3_pix", "csi3_rdi" },
 	.clock_for_reset = { "vfe0", "csi_vfe0", "vfe1", "csi_vfe1" },
 	.reg = { "ispif", "csi_clk_mux" },
-	.interrupt = "ispif"
+	.interrupt = { "ispif" }
 };
 
 static const struct resources vfe_res_8x96[] = {
@@ -410,7 +410,7 @@ static const struct resources csid_res_660[] = {
 	}
 };
 
-static const struct resources_ispif ispif_res_660 = {
+static const struct resources ispif_res_660 = {
 	/* ISPIF */
 	.clock = { "top_ahb", "ahb", "ispif_ahb",
 		   "csi0", "csi0_pix", "csi0_rdi",
@@ -419,7 +419,7 @@ static const struct resources_ispif ispif_res_660 = {
 		   "csi3", "csi3_pix", "csi3_rdi" },
 	.clock_for_reset = { "vfe0", "csi_vfe0", "vfe1", "csi_vfe1" },
 	.reg = { "ispif", "csi_clk_mux" },
-	.interrupt = "ispif"
+	.interrupt = { "ispif" }
 };
 
 static const struct resources vfe_res_660[] = {
@@ -1122,7 +1122,7 @@ static int camss_init_subdevices(struct camss *camss)
 {
 	const struct resources *csiphy_res;
 	const struct resources *csid_res;
-	const struct resources_ispif *ispif_res;
+	const struct resources *ispif_res;
 	const struct resources *vfe_res;
 	unsigned int i;
 	int ret;
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index f6c326cb853b8..e95211cdb1fd6 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -44,18 +44,12 @@
 struct resources {
 	char *regulators[CAMSS_RES_MAX];
 	char *clock[CAMSS_RES_MAX];
+	char *clock_for_reset[CAMSS_RES_MAX];
 	u32 clock_rate[CAMSS_RES_MAX][CAMSS_RES_MAX];
 	char *reg[CAMSS_RES_MAX];
 	char *interrupt[CAMSS_RES_MAX];
 };
 
-struct resources_ispif {
-	char *clock[CAMSS_RES_MAX];
-	char *clock_for_reset[CAMSS_RES_MAX];
-	char *reg[CAMSS_RES_MAX];
-	char *interrupt;
-};
-
 struct icc_bw_tbl {
 	u32 avg;
 	u32 peak;
-- 
2.41.0

