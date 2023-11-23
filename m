Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D797F64C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbjKWRDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345412AbjKWRDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:03:24 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628E31A8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:03:14 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b36e31b57so5731775e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700758992; x=1701363792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lK2SI9aHXKsbBQPMSODnSDZ93FbVmuXumfrpjOscrSE=;
        b=wNaPuiPy35ox6m5EMw2FFM9JLv4B0SE1sMRx+IHZXJNxN5hINuS2hRHuJBd/gbuDeJ
         ppebC5S/QdQfCyhl1fdsC5V3NFcSXaMLvN2ZK0nticR76mB6shTDMf/8T1xjXWIml9YI
         By1q+tLkwoSivJExrlhM7DUo6ut3dLXMAKeLUsAU0mfuJDLkJA9AS1aZo4scupNvpuCi
         /BS6LTt84nytjbqFAh2KzTcUjesH5/aGE57wN2nRaSy6zpOYSD0Qlw33S7w8YCmHBjFN
         mlhLt6H+GZmi8tfwOqir7x8fpSew05w6L2HyeJK4utrg3hh8ADwDbmqKix6D3pBeSPRH
         G9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700758992; x=1701363792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lK2SI9aHXKsbBQPMSODnSDZ93FbVmuXumfrpjOscrSE=;
        b=hLUHIAEkB3ycJAB4NnmaChtbzvcanAcHLA3MckEgVNXaVr1TpCob4W+dUdaQ6qRSlY
         aGuoaM5Dxxo2CnNgiyHmRjk0mzZ3WKvFQzv44T0qgFnpckOCV4LXww2ttVWBl3UTzwuK
         6FjlqL1iFZZARUywIZkLDA+0wmLyG9yPqbanfC3B85lEiyfQV85KBrusws7Be1RFZOjo
         aXByJQc6c1fB/1RZQwgTozahphROpPEI+MubYzio2yV2h40BPeZKa3yfAEoTq7jIjenp
         i2QAqwMkEu9Tz2GXAdJ4E5pBCvtQ7iMI/kbkXveQ4Fu2hbkHDrz7h+0uuECE/CQiiOE3
         dmSw==
X-Gm-Message-State: AOJu0YzJAypSPz98JdqfO9tFvpIyWNTYeu+C59twswuhYAEFLs4SU85s
        IJlIfn4Th84yOQ1gQhLqt+D2og==
X-Google-Smtp-Source: AGHT+IH53IcrTy1ooYVyzwy4btXf3w7oCDF53B0r9Iyb7M7ljWIwbZ62fzNNWwGFLKw3Yb1IvjMfAQ==
X-Received: by 2002:adf:f388:0:b0:332:c768:8aff with SMTP id m8-20020adff388000000b00332c7688affmr90825wro.3.1700758992617;
        Thu, 23 Nov 2023 09:03:12 -0800 (PST)
Received: from [127.0.0.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id f9-20020a0560001b0900b0032196c508e3sm2172585wrz.53.2023.11.23.09.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 09:03:12 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:   Thu, 23 Nov 2023 17:03:06 +0000
Subject: [PATCH v6 7/8] media: qcom: camss: Flag CSID-lites to support more
 CSIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231123-b4-camss-named-power-domains-v6-7-3ec2fd9e8e36@linaro.org>
References: <20231123-b4-camss-named-power-domains-v6-0-3ec2fd9e8e36@linaro.org>
In-Reply-To: <20231123-b4-camss-named-power-domains-v6-0-3ec2fd9e8e36@linaro.org>
To:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-26615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matti Lehtimäki <matti.lehtimaki@gmail.com>

Some platforms such as SC7280 have 3 CSIDs and 2 CSID-lites but current
code has hardcoded 2 as the maximum number of CSIDs. Remove the hardcoded
maximum number of VFEs to handle all possible combinations of CSIDs and
CSID-lites.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../media/platform/qcom/camss/camss-csid-gen2.c    | 31 +++++++++++-----------
 drivers/media/platform/qcom/camss/camss-csid.c     |  5 ++++
 drivers/media/platform/qcom/camss/camss-csid.h     |  7 +++++
 drivers/media/platform/qcom/camss/camss.c          |  3 +++
 4 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
index 05ff5fa8095a8..b11de4797ccae 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
@@ -21,7 +21,6 @@
  * interface support. As a result of that it has an
  * alternate register layout.
  */
-#define IS_LITE		(csid->id >= 2 ? 1 : 0)
 
 #define CSID_HW_VERSION		0x0
 #define		HW_VERSION_STEPPING	0
@@ -35,13 +34,13 @@
 #define	CSID_CSI2_RX_IRQ_MASK	0x24
 #define CSID_CSI2_RX_IRQ_CLEAR	0x28
 
-#define CSID_CSI2_RDIN_IRQ_STATUS(rdi)		((IS_LITE ? 0x30 : 0x40) \
+#define CSID_CSI2_RDIN_IRQ_STATUS(rdi)		((csid_is_lite(csid) ? 0x30 : 0x40) \
 						 + 0x10 * (rdi))
-#define CSID_CSI2_RDIN_IRQ_MASK(rdi)		((IS_LITE ? 0x34 : 0x44) \
+#define CSID_CSI2_RDIN_IRQ_MASK(rdi)		((csid_is_lite(csid) ? 0x34 : 0x44) \
 						 + 0x10 * (rdi))
-#define CSID_CSI2_RDIN_IRQ_CLEAR(rdi)		((IS_LITE ? 0x38 : 0x48) \
+#define CSID_CSI2_RDIN_IRQ_CLEAR(rdi)		((csid_is_lite(csid) ? 0x38 : 0x48) \
 						 + 0x10 * (rdi))
-#define CSID_CSI2_RDIN_IRQ_SET(rdi)		((IS_LITE ? 0x3C : 0x4C) \
+#define CSID_CSI2_RDIN_IRQ_SET(rdi)		((csid_is_lite(csid) ? 0x3C : 0x4C) \
 						 + 0x10 * (rdi))
 
 #define CSID_TOP_IRQ_STATUS	0x70
@@ -73,7 +72,7 @@
 #define			CGC_MODE_DYNAMIC_GATING		0
 #define			CGC_MODE_ALWAYS_ON		1
 
-#define CSID_RDI_CFG0(rdi)			((IS_LITE ? 0x200 : 0x300) \
+#define CSID_RDI_CFG0(rdi)			((csid_is_lite(csid) ? 0x200 : 0x300) \
 						 + 0x100 * (rdi))
 #define		RDI_CFG0_BYTE_CNTR_EN		0
 #define		RDI_CFG0_FORMAT_MEASURE_EN	1
@@ -98,32 +97,32 @@
 #define		RDI_CFG0_PACKING_FORMAT		30
 #define		RDI_CFG0_ENABLE			31
 
-#define CSID_RDI_CFG1(rdi)			((IS_LITE ? 0x204 : 0x304)\
+#define CSID_RDI_CFG1(rdi)			((csid_is_lite(csid) ? 0x204 : 0x304)\
 						+ 0x100 * (rdi))
 #define		RDI_CFG1_TIMESTAMP_STB_SEL	0
 
-#define CSID_RDI_CTRL(rdi)			((IS_LITE ? 0x208 : 0x308)\
+#define CSID_RDI_CTRL(rdi)			((csid_is_lite(csid) ? 0x208 : 0x308)\
 						+ 0x100 * (rdi))
 #define		RDI_CTRL_HALT_CMD		0
 #define			HALT_CMD_HALT_AT_FRAME_BOUNDARY		0
 #define			HALT_CMD_RESUME_AT_FRAME_BOUNDARY	1
 #define		RDI_CTRL_HALT_MODE		2
 
-#define CSID_RDI_FRM_DROP_PATTERN(rdi)			((IS_LITE ? 0x20C : 0x30C)\
+#define CSID_RDI_FRM_DROP_PATTERN(rdi)			((csid_is_lite(csid) ? 0x20C : 0x30C)\
 							+ 0x100 * (rdi))
-#define CSID_RDI_FRM_DROP_PERIOD(rdi)			((IS_LITE ? 0x210 : 0x310)\
+#define CSID_RDI_FRM_DROP_PERIOD(rdi)			((csid_is_lite(csid) ? 0x210 : 0x310)\
 							+ 0x100 * (rdi))
-#define CSID_RDI_IRQ_SUBSAMPLE_PATTERN(rdi)		((IS_LITE ? 0x214 : 0x314)\
+#define CSID_RDI_IRQ_SUBSAMPLE_PATTERN(rdi)		((csid_is_lite(csid) ? 0x214 : 0x314)\
 							+ 0x100 * (rdi))
-#define CSID_RDI_IRQ_SUBSAMPLE_PERIOD(rdi)		((IS_LITE ? 0x218 : 0x318)\
+#define CSID_RDI_IRQ_SUBSAMPLE_PERIOD(rdi)		((csid_is_lite(csid) ? 0x218 : 0x318)\
 							+ 0x100 * (rdi))
-#define CSID_RDI_RPP_PIX_DROP_PATTERN(rdi)		((IS_LITE ? 0x224 : 0x324)\
+#define CSID_RDI_RPP_PIX_DROP_PATTERN(rdi)		((csid_is_lite(csid) ? 0x224 : 0x324)\
 							+ 0x100 * (rdi))
-#define CSID_RDI_RPP_PIX_DROP_PERIOD(rdi)		((IS_LITE ? 0x228 : 0x328)\
+#define CSID_RDI_RPP_PIX_DROP_PERIOD(rdi)		((csid_is_lite(csid) ? 0x228 : 0x328)\
 							+ 0x100 * (rdi))
-#define CSID_RDI_RPP_LINE_DROP_PATTERN(rdi)		((IS_LITE ? 0x22C : 0x32C)\
+#define CSID_RDI_RPP_LINE_DROP_PATTERN(rdi)		((csid_is_lite(csid) ? 0x22C : 0x32C)\
 							+ 0x100 * (rdi))
-#define CSID_RDI_RPP_LINE_DROP_PERIOD(rdi)		((IS_LITE ? 0x230 : 0x330)\
+#define CSID_RDI_RPP_LINE_DROP_PERIOD(rdi)		((csid_is_lite(csid) ? 0x230 : 0x330)\
 							+ 0x100 * (rdi))
 
 #define CSID_TPG_CTRL		0x600
diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 95873f988f7e2..d393618ed54cb 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -897,3 +897,8 @@ void msm_csid_unregister_entity(struct csid_device *csid)
 	media_entity_cleanup(&csid->subdev.entity);
 	v4l2_ctrl_handler_free(&csid->ctrls);
 }
+
+inline bool csid_is_lite(struct csid_device *csid)
+{
+	return csid->camss->res->csid_res[csid->id].is_lite;
+}
diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
index 30d94eb2eb041..fddccb69da13a 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.h
+++ b/drivers/media/platform/qcom/camss/camss-csid.h
@@ -215,5 +215,12 @@ extern const struct csid_hw_ops csid_ops_4_1;
 extern const struct csid_hw_ops csid_ops_4_7;
 extern const struct csid_hw_ops csid_ops_gen2;
 
+/*
+ * csid_is_lite - Check if CSID is CSID lite.
+ * @csid: CSID Device
+ *
+ * Return whether CSID is CSID lite
+ */
+bool csid_is_lite(struct csid_device *csid);
 
 #endif /* QC_MSM_CAMSS_CSID_H */
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 7c49654a12964..942db0dffa59f 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -638,6 +638,7 @@ static const struct camss_subdev_resources csid_res_845[] = {
 				{ 384000000 } },
 		.reg = { "csid2" },
 		.interrupt = { "csid2" },
+		.is_lite = true,
 		.ops = &csid_ops_gen2
 	}
 };
@@ -812,6 +813,7 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 				{ 0 } },
 		.reg = { "csid2" },
 		.interrupt = { "csid2" },
+		.is_lite = true,
 		.ops = &csid_ops_gen2
 	},
 	/* CSID3 */
@@ -824,6 +826,7 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 				{ 0 } },
 		.reg = { "csid3" },
 		.interrupt = { "csid3" },
+		.is_lite = true,
 		.ops = &csid_ops_gen2
 	}
 };

-- 
2.42.0

