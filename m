Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF077ADBD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjIYPlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjIYPlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:41:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA1D109
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:41:15 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso33759565e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656473; x=1696261273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhSKtn1WWoetbFcEPefpk8WL/CMtB2nONd2TgD1HTnc=;
        b=oaVWQyEY/Fb3qLAbi289u5rgNukfv8i+OrFUoqm5NdORG3ccZyvQiUSHzyjM3nWvAC
         X3byZLejI3kXGrRZVAj4lWYz54NynYgIkbBQ3qpENOiZ7E2K3WMCiufqSlqTKXokMBRF
         hS0ChC2geChQcIa2TbrBMmxEn+srSMNPbRtvgb7NWIiQ2FDL630rfEGTpfRAya8cwOZf
         LXnkFK+Qnuzc4CvwRT2l9WuW+Qp87YPpOg7hweEMnwr1bPMh+NdmCY1nmkvNmInI3po2
         CpfQszWbeA3etOF5DxvGvn3kLpMzxFox0JeA/aUz8xs9L/VbyGkp7cS2uz1PpgNazSc6
         BwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656473; x=1696261273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhSKtn1WWoetbFcEPefpk8WL/CMtB2nONd2TgD1HTnc=;
        b=BMH0TOfOYCNey2o+K1l+uNZnfRQjsBzUPJ2PMBI4bHrMoyiKqkOeTqhvCCJYw4peYS
         sWTMOvqtzv0/tpDQmQRy3vvNGfajBwRb0CJsbnlKmZFlrbsroeIlQj/KhzX6DRx+rD4r
         d0oa7YCbaBQwQOXD/n6zxxCVMVUpA26cv0rblJXCe5Fpnck2V8S1T2Wk+E3vKUYq6xEd
         4bS7Dr1Ykwa6+HxpqgRMMblM3CZIAytgfuOW6pYekfXTL9p9/UbxmjhMRAA90op2syqC
         38DwFRstVGokuCRHdipTZDZIvnxUytejRXVNNSWwPs9PrYY7l2slseX6Is0aOfDyWhET
         iStw==
X-Gm-Message-State: AOJu0YzrWvacXfc3LjrifXstcx1PF/R0Ql6uitHGCG56cLhAkFzasLuJ
        g5Tb3fLqejeCetnKyRRUUwcK+A==
X-Google-Smtp-Source: AGHT+IFg0BOqko4zKrjTxWd8QjAavwcAz78JXhFZuLIReoRwwl6b7uKAqVKOLT+wudStb5Fwa/lMlA==
X-Received: by 2002:a05:600c:d4:b0:405:3a3d:6f42 with SMTP id u20-20020a05600c00d400b004053a3d6f42mr5841513wmm.39.1695656473410;
        Mon, 25 Sep 2023 08:41:13 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m15-20020a7bca4f000000b003fe4548188bsm15206155wml.48.2023.09.25.08.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:41:13 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v6 08/17] media: qcom: camss: Assign the correct number of RDIs per VFE
Date:   Mon, 25 Sep 2023 16:40:50 +0100
Message-ID: <20230925154059.837152-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925154059.837152-1-bryan.odonoghue@linaro.org>
References: <20230925154059.837152-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each Video Front End - VFE - has a variable number of Raw Data Interfaces -
RDIs associated with it.

The CAMSS code started from a naive implementation where a fixed define was
used as a control in a for(){} loop iterating through RDIs.

That model scales badly. An attempt was made with  VFE_LINE_NUM_GEN2 and
VFE_LINE_NUM_GEN1 to differentiate between SoCs but, the problem with that
is "gen1" and "gen2" have no meaning in the silicon. There is no fixed
constraint in the silicon between VFE and RDI, it is entirely up to the SoC
designers how many VFEs are populated and how many RDIs to associate with
each VFE.

As an example sdm845 has VFE version 175 and sm8250 VFE version 480.
sdm845 has 2 VFEs with 4 RDIs and 1 VFE Lite with 4 RDIs.
sm8250 has 2 VFEs with 3 RDIs and 2 VFE Lite with 4 RDIs.

Clearly then we need a more granular model to capture the necessary data.

The defines have gone away to be replaced with per-SoC data but, we haven't
populated the parameter data with the real values.

Let's call those values out now

msm8916:
1 x VFE
3 x RDI per VFE (not 4)

msm8996:
2 x VFE
3 x RDI per VFE (not 4)

sdm660:
2 x VFE
3 x RDI per VFE (not 4)

sdm845:
2 x VFE
4 x RDI per VFE (not 3)
1 x VFE Lite
4 x RDI per VFE Lite (not 3)

sm8250:
2 x VFE
3 x RDI per VFE (not 4)
2 x VFE Lite
4 x RDI per VFE Lite

This more complex and correct mapping was not possible prior to passing
values via driver data. Now that we have that change in place we can
correctly map VFEs to RDIs for each VFE.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/qcom/camss/camss-vfe.h |  2 --
 drivers/media/platform/qcom/camss/camss.c     | 20 +++++++++----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index b4bae9f65c68f..4783afa73a365 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -52,9 +52,7 @@ enum vfe_line_id {
 	VFE_LINE_RDI0 = 0,
 	VFE_LINE_RDI1 = 1,
 	VFE_LINE_RDI2 = 2,
-	VFE_LINE_NUM_GEN2 = 3,
 	VFE_LINE_PIX = 3,
-	VFE_LINE_NUM_GEN1 = 4,
 	VFE_LINE_NUM_MAX = 4
 };
 
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 12131d9ea7ca8..8e78dd8d5961e 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -128,7 +128,7 @@ static const struct camss_subdev_resources vfe_res_8x16[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = VFE_LINE_NUM_GEN1,
+		.line_num = 3,
 		.ops = &vfe_ops_4_1
 	}
 };
@@ -277,7 +277,7 @@ static const struct camss_subdev_resources vfe_res_8x96[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = VFE_LINE_NUM_GEN1,
+		.line_num = 3,
 		.ops = &vfe_ops_4_7
 	},
 
@@ -297,7 +297,7 @@ static const struct camss_subdev_resources vfe_res_8x96[] = {
 				{ 0 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.line_num = VFE_LINE_NUM_GEN1,
+		.line_num = 3,
 		.ops = &vfe_ops_4_7
 	}
 };
@@ -467,7 +467,7 @@ static const struct camss_subdev_resources vfe_res_660[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = VFE_LINE_NUM_GEN1,
+		.line_num = 3,
 		.ops = &vfe_ops_4_8
 	},
 
@@ -490,7 +490,7 @@ static const struct camss_subdev_resources vfe_res_660[] = {
 				{ 0 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.line_num = VFE_LINE_NUM_GEN1,
+		.line_num = 3,
 		.ops = &vfe_ops_4_8
 	}
 };
@@ -657,7 +657,7 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 				{ 384000000 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = VFE_LINE_NUM_GEN2,
+		.line_num = 4,
 		.ops = &vfe_ops_170
 	},
 
@@ -679,7 +679,7 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 				{ 384000000 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.line_num = VFE_LINE_NUM_GEN2,
+		.line_num = 4,
 		.ops = &vfe_ops_170
 	},
 
@@ -700,7 +700,7 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 				{ 384000000 } },
 		.reg = { "vfe_lite" },
 		.interrupt = { "vfe_lite" },
-		.line_num = VFE_LINE_NUM_GEN2,
+		.line_num = 4,
 		.ops = &vfe_ops_170
 	}
 };
@@ -839,7 +839,7 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = 4,
+		.line_num = 3,
 		.ops = &vfe_ops_480
 	},
 	/* VFE1 */
@@ -859,7 +859,7 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 				{ 0 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.line_num = 4,
+		.line_num = 3,
 		.ops = &vfe_ops_480
 	},
 	/* VFE2 (lite) */
-- 
2.42.0

