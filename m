Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADC07ADC33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjIYPrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjIYPrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:47:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDF8192
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405361bb94eso67438485e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656838; x=1696261638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RcC5Z13/zUqK69N/so6eHAgcugzjOcvez6QkwUNOkw=;
        b=peCWt9m88Qa6Fj+8OZ896Bc4nufs/BohY3GE0PpRdCRwb1mG4SaZb3p6sDaaJzbuwU
         cAq5Cx3+2McaSTk6WrlK5leT58GvTlodZ0YhQnZwUhWhZUqfTBeJkpfSPwT+kF0zvHBr
         0SMUqr3gyL5KQDplyhLcDVUbuhqaWeZpH2j27jFXOdIDXLH9OyVWzqeftamUCqgwv/J2
         kmWVZcgUoQltk95XucFvPWXcVyjxAHOrDoj9lzFVHTKHuznXgtU3v/I69uDRZ/eIpDsA
         MicupU0eNbZzVJs7VUxxQCcT2ezwjK/Qd1l9GklVrpGPKpUQm3WRsvHlerc58MTdMite
         TJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656838; x=1696261638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RcC5Z13/zUqK69N/so6eHAgcugzjOcvez6QkwUNOkw=;
        b=qan3Dr0Fo9RgFffh9/JHk2KNsIfDYFfO1KrsJOr9+2kEyuiYtwVpdNzbOYvD+efmSO
         B8Y3nnMneJJMs6njwmTdWZRJ26bcSZ2DUx5P3X57sG8BBkg0WnGOTNsI0QIVd2h8uK8I
         +JdS4q87NeMJX+YCfomJbgT+OyP3ufIJlHkfBFro6AeLxhgxG772Iunxda8OUZ1jNzPD
         /EsSFC0ToFig9gFgEgOH4wew5dNrRzgQLEjgaBfLO+STgmfTcGbUAbxhyzbiwGHzi8J0
         6UziH4a5b4y/86NJUkTCVm0nuXOPauURlFonR6jT7g3Rng4bNws7gtot++WqZbt2rMcv
         tNPA==
X-Gm-Message-State: AOJu0YxiOBp3vHHaU4EvBhG7U+3fsVRtyDbodiUeUXx4dC3idjrWSnwr
        W8J1wSbTqQ6TXo/bvK44XUbBVu1PbRAQHxPF5Kw=
X-Google-Smtp-Source: AGHT+IHbDQQ+mWabkID+ZHSlihjCdysYLOzSBboGqBKPkwSwdjJWu9ugLmKVb8A9r5VzKllI1rrLew==
X-Received: by 2002:a7b:c855:0:b0:405:3a65:1b4c with SMTP id c21-20020a7bc855000000b004053a651b4cmr6397322wml.6.1695656838662;
        Mon, 25 Sep 2023 08:47:18 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d4-20020adffd84000000b0031f34a395e7sm12077536wrr.45.2023.09.25.08.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:47:18 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [RESEND PATCH v6 07/17] media: qcom: camss: Pass CAMSS subdev callbacks via resource ops pointer
Date:   Mon, 25 Sep 2023 16:46:57 +0100
Message-ID: <20230925154707.837542-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
References: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
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

It is possible to pass all of the CAMSS subdevice internal operations
pointers from the controlling resources structure with an additional
pointer added to the resources structure.

This allows for the removal of most of the probe-time control structures.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../media/platform/qcom/camss/camss-csid.c    |  12 +-
 .../media/platform/qcom/camss/camss-csiphy.c  |   4 +-
 drivers/media/platform/qcom/camss/camss-vfe.c |  20 +--
 drivers/media/platform/qcom/camss/camss.c     | 117 ++++++++++++------
 drivers/media/platform/qcom/camss/camss.h     |   1 +
 5 files changed, 86 insertions(+), 68 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 14abb7a7ceb47..99f651e2021cb 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -575,18 +575,8 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
 
 	csid->camss = camss;
 	csid->id = id;
+	csid->ops = res->ops;
 
-	if (camss->res->version == CAMSS_8x16) {
-		csid->ops = &csid_ops_4_1;
-	} else if (camss->res->version == CAMSS_8x96 ||
-		   camss->res->version == CAMSS_660) {
-		csid->ops = &csid_ops_4_7;
-	} else if (camss->res->version == CAMSS_845 ||
-		   camss->res->version == CAMSS_8250) {
-		csid->ops = &csid_ops_gen2;
-	} else {
-		return -EINVAL;
-	}
 	csid->ops->subdev_init(csid);
 
 	/* Memory */
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 48e6a101ec9c9..4310a132dcbe2 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -556,19 +556,17 @@ int msm_csiphy_subdev_init(struct camss *camss,
 	csiphy->camss = camss;
 	csiphy->id = id;
 	csiphy->cfg.combo_mode = 0;
+	csiphy->ops = res->ops;
 
 	if (camss->res->version == CAMSS_8x16) {
-		csiphy->ops = &csiphy_ops_2ph_1_0;
 		csiphy->formats = csiphy_formats_8x16;
 		csiphy->nformats = ARRAY_SIZE(csiphy_formats_8x16);
 	} else if (camss->res->version == CAMSS_8x96 ||
 		   camss->res->version == CAMSS_660) {
-		csiphy->ops = &csiphy_ops_3ph_1_0;
 		csiphy->formats = csiphy_formats_8x96;
 		csiphy->nformats = ARRAY_SIZE(csiphy_formats_8x96);
 	} else if (camss->res->version == CAMSS_845 ||
 		   camss->res->version == CAMSS_8250) {
-		csiphy->ops = &csiphy_ops_3ph_1_0;
 		csiphy->formats = csiphy_formats_sdm845;
 		csiphy->nformats = ARRAY_SIZE(csiphy_formats_sdm845);
 	} else {
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index f381c82f1f877..4d5c32d3dddbf 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1286,25 +1286,7 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 	int i, j;
 	int ret;
 
-	switch (camss->res->version) {
-	case CAMSS_8x16:
-		vfe->ops = &vfe_ops_4_1;
-		break;
-	case CAMSS_8x96:
-		vfe->ops = &vfe_ops_4_7;
-		break;
-	case CAMSS_660:
-		vfe->ops = &vfe_ops_4_8;
-		break;
-	case CAMSS_845:
-		vfe->ops = &vfe_ops_170;
-		break;
-	case CAMSS_8250:
-		vfe->ops = &vfe_ops_480;
-		break;
-	default:
-		return -EINVAL;
-	}
+	vfe->ops = res->ops;
 
 	if (!res->line_num)
 		return -EINVAL;
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 54886a2a449b0..12131d9ea7ca8 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -42,7 +42,8 @@ static const struct camss_subdev_resources csiphy_res_8x16[] = {
 				{ 0 },
 				{ 100000000, 200000000 } },
 		.reg = { "csiphy0", "csiphy0_clk_mux" },
-		.interrupt = { "csiphy0" }
+		.interrupt = { "csiphy0" },
+		.ops = &csiphy_ops_2ph_1_0
 	},
 
 	/* CSIPHY1 */
@@ -54,7 +55,8 @@ static const struct camss_subdev_resources csiphy_res_8x16[] = {
 				{ 0 },
 				{ 100000000, 200000000 } },
 		.reg = { "csiphy1", "csiphy1_clk_mux" },
-		.interrupt = { "csiphy1" }
+		.interrupt = { "csiphy1" },
+		.ops = &csiphy_ops_2ph_1_0
 	}
 };
 
@@ -73,7 +75,8 @@ static const struct camss_subdev_resources csid_res_8x16[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "csid0" },
-		.interrupt = { "csid0" }
+		.interrupt = { "csid0" },
+		.ops = &csid_ops_4_1,
 	},
 
 	/* CSID1 */
@@ -90,7 +93,8 @@ static const struct camss_subdev_resources csid_res_8x16[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "csid1" },
-		.interrupt = { "csid1" }
+		.interrupt = { "csid1" },
+		.ops = &csid_ops_4_1,
 	},
 };
 
@@ -125,6 +129,7 @@ static const struct camss_subdev_resources vfe_res_8x16[] = {
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
 		.line_num = VFE_LINE_NUM_GEN1,
+		.ops = &vfe_ops_4_1
 	}
 };
 
@@ -138,7 +143,8 @@ static const struct camss_subdev_resources csiphy_res_8x96[] = {
 				{ 0 },
 				{ 100000000, 200000000, 266666667 } },
 		.reg = { "csiphy0", "csiphy0_clk_mux" },
-		.interrupt = { "csiphy0" }
+		.interrupt = { "csiphy0" },
+		.ops = &csiphy_ops_3ph_1_0
 	},
 
 	/* CSIPHY1 */
@@ -150,7 +156,8 @@ static const struct camss_subdev_resources csiphy_res_8x96[] = {
 				{ 0 },
 				{ 100000000, 200000000, 266666667 } },
 		.reg = { "csiphy1", "csiphy1_clk_mux" },
-		.interrupt = { "csiphy1" }
+		.interrupt = { "csiphy1" },
+		.ops = &csiphy_ops_3ph_1_0
 	},
 
 	/* CSIPHY2 */
@@ -162,7 +169,8 @@ static const struct camss_subdev_resources csiphy_res_8x96[] = {
 				{ 0 },
 				{ 100000000, 200000000, 266666667 } },
 		.reg = { "csiphy2", "csiphy2_clk_mux" },
-		.interrupt = { "csiphy2" }
+		.interrupt = { "csiphy2" },
+		.ops = &csiphy_ops_3ph_1_0
 	}
 };
 
@@ -181,7 +189,8 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "csid0" },
-		.interrupt = { "csid0" }
+		.interrupt = { "csid0" },
+		.ops = &csid_ops_4_7,
 	},
 
 	/* CSID1 */
@@ -198,7 +207,8 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "csid1" },
-		.interrupt = { "csid1" }
+		.interrupt = { "csid1" },
+		.ops = &csid_ops_4_7,
 	},
 
 	/* CSID2 */
@@ -215,7 +225,8 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "csid2" },
-		.interrupt = { "csid2" }
+		.interrupt = { "csid2" },
+		.ops = &csid_ops_4_7,
 	},
 
 	/* CSID3 */
@@ -232,7 +243,8 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "csid3" },
-		.interrupt = { "csid3" }
+		.interrupt = { "csid3" },
+		.ops = &csid_ops_4_7,
 	}
 };
 
@@ -266,6 +278,7 @@ static const struct camss_subdev_resources vfe_res_8x96[] = {
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
 		.line_num = VFE_LINE_NUM_GEN1,
+		.ops = &vfe_ops_4_7
 	},
 
 	/* VFE1 */
@@ -285,6 +298,7 @@ static const struct camss_subdev_resources vfe_res_8x96[] = {
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
 		.line_num = VFE_LINE_NUM_GEN1,
+		.ops = &vfe_ops_4_7
 	}
 };
 
@@ -300,7 +314,8 @@ static const struct camss_subdev_resources csiphy_res_660[] = {
 				{ 100000000, 200000000, 269333333 },
 				{ 0 } },
 		.reg = { "csiphy0", "csiphy0_clk_mux" },
-		.interrupt = { "csiphy0" }
+		.interrupt = { "csiphy0" },
+		.ops = &csiphy_ops_3ph_1_0
 	},
 
 	/* CSIPHY1 */
@@ -314,7 +329,8 @@ static const struct camss_subdev_resources csiphy_res_660[] = {
 				{ 100000000, 200000000, 269333333 },
 				{ 0 } },
 		.reg = { "csiphy1", "csiphy1_clk_mux" },
-		.interrupt = { "csiphy1" }
+		.interrupt = { "csiphy1" },
+		.ops = &csiphy_ops_3ph_1_0
 	},
 
 	/* CSIPHY2 */
@@ -328,7 +344,8 @@ static const struct camss_subdev_resources csiphy_res_660[] = {
 				{ 100000000, 200000000, 269333333 },
 				{ 0 } },
 		.reg = { "csiphy2", "csiphy2_clk_mux" },
-		.interrupt = { "csiphy2" }
+		.interrupt = { "csiphy2" },
+		.ops = &csiphy_ops_3ph_1_0
 	}
 };
 
@@ -350,7 +367,8 @@ static const struct camss_subdev_resources csid_res_660[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "csid0" },
-		.interrupt = { "csid0" }
+		.interrupt = { "csid0" },
+		.ops = &csid_ops_4_7,
 	},
 
 	/* CSID1 */
@@ -370,7 +388,8 @@ static const struct camss_subdev_resources csid_res_660[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "csid1" },
-		.interrupt = { "csid1" }
+		.interrupt = { "csid1" },
+		.ops = &csid_ops_4_7,
 	},
 
 	/* CSID2 */
@@ -390,7 +409,8 @@ static const struct camss_subdev_resources csid_res_660[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "csid2" },
-		.interrupt = { "csid2" }
+		.interrupt = { "csid2" },
+		.ops = &csid_ops_4_7,
 	},
 
 	/* CSID3 */
@@ -410,7 +430,8 @@ static const struct camss_subdev_resources csid_res_660[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "csid3" },
-		.interrupt = { "csid3" }
+		.interrupt = { "csid3" },
+		.ops = &csid_ops_4_7,
 	}
 };
 
@@ -447,6 +468,7 @@ static const struct camss_subdev_resources vfe_res_660[] = {
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
 		.line_num = VFE_LINE_NUM_GEN1,
+		.ops = &vfe_ops_4_8
 	},
 
 	/* VFE1 */
@@ -469,6 +491,7 @@ static const struct camss_subdev_resources vfe_res_660[] = {
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
 		.line_num = VFE_LINE_NUM_GEN1,
+		.ops = &vfe_ops_4_8
 	}
 };
 
@@ -488,7 +511,8 @@ static const struct camss_subdev_resources csiphy_res_845[] = {
 				{ 0 },
 				{ 19200000, 240000000, 269333333 } },
 		.reg = { "csiphy0" },
-		.interrupt = { "csiphy0" }
+		.interrupt = { "csiphy0" },
+		.ops = &csiphy_ops_3ph_1_0
 	},
 
 	/* CSIPHY1 */
@@ -506,7 +530,8 @@ static const struct camss_subdev_resources csiphy_res_845[] = {
 				{ 0 },
 				{ 19200000, 240000000, 269333333 } },
 		.reg = { "csiphy1" },
-		.interrupt = { "csiphy1" }
+		.interrupt = { "csiphy1" },
+		.ops = &csiphy_ops_3ph_1_0
 	},
 
 	/* CSIPHY2 */
@@ -524,7 +549,8 @@ static const struct camss_subdev_resources csiphy_res_845[] = {
 				{ 0 },
 				{ 19200000, 240000000, 269333333 } },
 		.reg = { "csiphy2" },
-		.interrupt = { "csiphy2" }
+		.interrupt = { "csiphy2" },
+		.ops = &csiphy_ops_3ph_1_0
 	},
 
 	/* CSIPHY3 */
@@ -542,7 +568,8 @@ static const struct camss_subdev_resources csiphy_res_845[] = {
 				{ 0 },
 				{ 19200000, 240000000, 269333333 } },
 		.reg = { "csiphy3" },
-		.interrupt = { "csiphy3" }
+		.interrupt = { "csiphy3" },
+		.ops = &csiphy_ops_3ph_1_0
 	}
 };
 
@@ -564,7 +591,8 @@ static const struct camss_subdev_resources csid_res_845[] = {
 				{ 19200000, 75000000, 384000000, 538666667 },
 				{ 384000000 } },
 		.reg = { "csid0" },
-		.interrupt = { "csid0" }
+		.interrupt = { "csid0" },
+		.ops = &csid_ops_gen2
 	},
 
 	/* CSID1 */
@@ -584,7 +612,8 @@ static const struct camss_subdev_resources csid_res_845[] = {
 				{ 19200000, 75000000, 384000000, 538666667 },
 				{ 384000000 } },
 		.reg = { "csid1" },
-		.interrupt = { "csid1" }
+		.interrupt = { "csid1" },
+		.ops = &csid_ops_gen2
 	},
 
 	/* CSID2 */
@@ -604,7 +633,8 @@ static const struct camss_subdev_resources csid_res_845[] = {
 				{ 19200000, 75000000, 384000000, 538666667 },
 				{ 384000000 } },
 		.reg = { "csid2" },
-		.interrupt = { "csid2" }
+		.interrupt = { "csid2" },
+		.ops = &csid_ops_gen2
 	}
 };
 
@@ -628,6 +658,7 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
 		.line_num = VFE_LINE_NUM_GEN2,
+		.ops = &vfe_ops_170
 	},
 
 	/* VFE1 */
@@ -649,6 +680,7 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
 		.line_num = VFE_LINE_NUM_GEN2,
+		.ops = &vfe_ops_170
 	},
 
 	/* VFE-lite */
@@ -669,6 +701,7 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 		.reg = { "vfe_lite" },
 		.interrupt = { "vfe_lite" },
 		.line_num = VFE_LINE_NUM_GEN2,
+		.ops = &vfe_ops_170
 	}
 };
 
@@ -680,7 +713,8 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 		.clock_rate = { { 400000000 },
 				{ 300000000 } },
 		.reg = { "csiphy0" },
-		.interrupt = { "csiphy0" }
+		.interrupt = { "csiphy0" },
+		.ops = &csiphy_ops_3ph_1_0
 	},
 	/* CSIPHY1 */
 	{
@@ -689,7 +723,8 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 		.clock_rate = { { 400000000 },
 				{ 300000000 } },
 		.reg = { "csiphy1" },
-		.interrupt = { "csiphy1" }
+		.interrupt = { "csiphy1" },
+		.ops = &csiphy_ops_3ph_1_0
 	},
 	/* CSIPHY2 */
 	{
@@ -698,7 +733,8 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 		.clock_rate = { { 400000000 },
 				{ 300000000 } },
 		.reg = { "csiphy2" },
-		.interrupt = { "csiphy2" }
+		.interrupt = { "csiphy2" },
+		.ops = &csiphy_ops_3ph_1_0
 	},
 	/* CSIPHY3 */
 	{
@@ -707,7 +743,8 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 		.clock_rate = { { 400000000 },
 				{ 300000000 } },
 		.reg = { "csiphy3" },
-		.interrupt = { "csiphy3" }
+		.interrupt = { "csiphy3" },
+		.ops = &csiphy_ops_3ph_1_0
 	},
 	/* CSIPHY4 */
 	{
@@ -716,7 +753,8 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 		.clock_rate = { { 400000000 },
 				{ 300000000 } },
 		.reg = { "csiphy4" },
-		.interrupt = { "csiphy4" }
+		.interrupt = { "csiphy4" },
+		.ops = &csiphy_ops_3ph_1_0
 	},
 	/* CSIPHY5 */
 	{
@@ -725,7 +763,8 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 		.clock_rate = { { 400000000 },
 				{ 300000000 } },
 		.reg = { "csiphy5" },
-		.interrupt = { "csiphy5" }
+		.interrupt = { "csiphy5" },
+		.ops = &csiphy_ops_3ph_1_0
 	}
 };
 
@@ -740,7 +779,8 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 				{ 100000000, 200000000, 300000000, 400000000 },
 				{ 0 } },
 		.reg = { "csid0" },
-		.interrupt = { "csid0" }
+		.interrupt = { "csid0" },
+		.ops = &csid_ops_gen2
 	},
 	/* CSID1 */
 	{
@@ -752,7 +792,8 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 				{ 100000000, 200000000, 300000000, 400000000 },
 				{ 0 } },
 		.reg = { "csid1" },
-		.interrupt = { "csid1" }
+		.interrupt = { "csid1" },
+		.ops = &csid_ops_gen2
 	},
 	/* CSID2 */
 	{
@@ -763,7 +804,8 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 				{ 400000000, 480000000 },
 				{ 0 } },
 		.reg = { "csid2" },
-		.interrupt = { "csid2" }
+		.interrupt = { "csid2" },
+		.ops = &csid_ops_gen2
 	},
 	/* CSID3 */
 	{
@@ -774,7 +816,8 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 				{ 400000000, 480000000 },
 				{ 0 } },
 		.reg = { "csid3" },
-		.interrupt = { "csid3" }
+		.interrupt = { "csid3" },
+		.ops = &csid_ops_gen2
 	}
 };
 
@@ -797,6 +840,7 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
 		.line_num = 4,
+		.ops = &vfe_ops_480
 	},
 	/* VFE1 */
 	{
@@ -816,6 +860,7 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
 		.line_num = 4,
+		.ops = &vfe_ops_480
 	},
 	/* VFE2 (lite) */
 	{
@@ -834,6 +879,7 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 		.reg = { "vfe_lite0" },
 		.interrupt = { "vfe_lite0" },
 		.line_num = 4,
+		.ops = &vfe_ops_480
 	},
 	/* VFE3 (lite) */
 	{
@@ -852,6 +898,7 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 		.reg = { "vfe_lite1" },
 		.interrupt = { "vfe_lite1" },
 		.line_num = 4,
+		.ops = &vfe_ops_480
 	},
 };
 
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index fc02aa84a5dd7..8acad7321c09d 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -49,6 +49,7 @@ struct camss_subdev_resources {
 	char *reg[CAMSS_RES_MAX];
 	char *interrupt[CAMSS_RES_MAX];
 	u8 line_num;
+	const void *ops;
 };
 
 struct icc_bw_tbl {
-- 
2.42.0

