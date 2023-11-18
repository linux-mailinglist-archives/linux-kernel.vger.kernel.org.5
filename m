Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C227EFF76
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 13:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjKRMMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 07:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjKRMLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 07:11:54 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E700110F2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 04:11:49 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso36513321fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 04:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700309508; x=1700914308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BR+YBWVQ86ytjIlOGmAW4/tQxNcN+mCsodRc3VxcTJs=;
        b=zncfqTX3Nvxwo2AFLAxC5Yn1v3ZzJvYY+M/7ID/N/OdrhcO4h6X59h4oSWXxia0srC
         jaXXK2QgP0NUeN+bW2u8TiSyGYYk7McC2iZsAp2Sw9j8036ZOZDPcihLurFbfG7HKcfg
         pZkp5MaDXMIcOj/zThyNBI0jyipETaVZ8eNXCfJR9Fs5XzXuzPLt5iU48g4QYbVnwQ9/
         fGnufvgIAbs9BNrEDZQtPIJH/CaJ+HNXpA3TlGgQBiEuY8NRXOFKU5QuynR4Wqzg5Jek
         3r9gKbhF+5vx3KyIUUV2C7gFDrbVeNk9B78eIrFXHb03m8W0auwZUXZr/OWsy059k/M/
         znBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700309508; x=1700914308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BR+YBWVQ86ytjIlOGmAW4/tQxNcN+mCsodRc3VxcTJs=;
        b=U5D2zvp2thDupqq0kl4Dz9h4AV1Oof9OVozN49N/uftECvZ/QmAgPPdAt1by4VlMi7
         eunCDgLYaHxe9ZSax6guxDlbSgFHe6kMoGzfcGdrsQVarS6+TIa6BB0rn3YBSvKVSlaZ
         ZWp7EqO5DfxwaNFqScx08peI6uQ3dNPkOmdEiDbGKNKbz+hVKRMTpAUpV/tKJeI/LZek
         XrDr25k668TOlP6TIz1kRI//+ebckMBqbX7SGmm/HGPNodvY9hx0Ci13P88S1b4vZhRi
         JcMl/QTFSeUa7GIxS69Ac3oIhwbZhkjoo8liglu9lvXf4Fjyb1/C/nh9LwvyMD7WtoaX
         g40g==
X-Gm-Message-State: AOJu0YyLMmTSQrgByCFaWbo8rpBBihVMHxFdQHrs98KroBZWA0goKNgT
        49EncHsJ/KjOnAUKupsskcW1dA==
X-Google-Smtp-Source: AGHT+IEwFLtIvB7rdi/2cIANfML23FJgQwzpDWS30semnBmuFWv4znpRQ54wyWrQGkPPS687i3IDHQ==
X-Received: by 2002:a2e:b0f1:0:b0:2c6:edfd:658a with SMTP id h17-20020a2eb0f1000000b002c6edfd658amr1607592ljl.31.1700309508101;
        Sat, 18 Nov 2023 04:11:48 -0800 (PST)
Received: from [127.0.0.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c3b9200b00407efbc4361sm10955775wms.9.2023.11.18.04.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 04:11:47 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:   Sat, 18 Nov 2023 12:11:41 +0000
Subject: [PATCH v5 7/7] media: qcom: camss: Flag CSID-lites to support more
 CSIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231118-b4-camss-named-power-domains-v5-7-55eb0f35a30a@linaro.org>
References: <20231118-b4-camss-named-power-domains-v5-0-55eb0f35a30a@linaro.org>
In-Reply-To: <20231118-b4-camss-named-power-domains-v5-0-55eb0f35a30a@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index ea0038f62b807..a0fbbfccf3b7e 100644
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

