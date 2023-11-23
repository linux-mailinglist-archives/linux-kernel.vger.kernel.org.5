Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CBD7F64AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbjKWRDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjKWRC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:02:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38213D4A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:03:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-332ce50450dso702528f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700758983; x=1701363783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X26+8wItEuS2j+BVlRHOHS9xadXwL+/+KykUmMySayM=;
        b=U1NGys4jSXa478wAcCoNa4IIy5tjcOydyInU0h3s6KQ0M7pFJKxjmXq9X+ARqlPpy7
         pSgr0V0ec0kVVflR5Sy7EODi1d2D+wuAWnqkY+cLd725bUjBZkK+K1LOANiPxHwVQyWS
         0AJXXtd6x1aPjx//Pfo04CBOUWiFWTw9sjuFrPYcvCqqLFWmDbnmnCipYRWNyTum8EoY
         rB1xYzPGChS56b0NVaU/hfkJt91yDfmCjmMAEkmZLsVgE1qZB2x8XWToNBkyOduGQrl7
         fWYxmjfflN/+R1WvKeytRT5nnGyr67sxHEyuzO5lVWvn3hfbIOAzClTUSY3q1SzldH9l
         JVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700758983; x=1701363783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X26+8wItEuS2j+BVlRHOHS9xadXwL+/+KykUmMySayM=;
        b=tOcUc3BfPGCLguSHv32g7TWLZI+VC8vF8Jnux4zP2KfQlrX9VtiRj7JQrhKU5hSgBZ
         u29NCWohMnDyDrSWOWbQ7N+yC8bAzizUcCmUFjL3lDyCva7ZzkOjVJc4x3jumpmzvvt9
         5ol4C/2Sy/O6hm0y+xF42jDXodXeCSnu2IkqRV6wCmBNrkqS705Eoy0SwrzYcAUeZl14
         3N/eeJUaNPRzTnt22q4T2J1n/nHIRNUIhxS/JIeigH+S4WvVkveceV04RTsRJUI0Gj+5
         lNOJZYb3gIQg9Ux4JMQjRshBnWqO9WlUPKi8MZUiipzt+qzYgPNiNigfZrIXIX1Ff0hc
         s7VA==
X-Gm-Message-State: AOJu0Yy2rslEFTQLsQOEZZb8tb6mDS1LK3NIs/TCHG97mgYVxlLQnk8/
        eE/jsOYJAZ5DUQPGfSpHIBa6cA==
X-Google-Smtp-Source: AGHT+IHtQTwXimrf79Wlg5jnvUDF/YuL90RVlWtpebD3jhmxWckb7X/7abp/KkIBDc8SOLJF86HENg==
X-Received: by 2002:adf:ed09:0:b0:332:e7b9:b671 with SMTP id a9-20020adfed09000000b00332e7b9b671mr75060wro.14.1700758983681;
        Thu, 23 Nov 2023 09:03:03 -0800 (PST)
Received: from [127.0.0.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id f9-20020a0560001b0900b0032196c508e3sm2172585wrz.53.2023.11.23.09.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 09:03:03 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:   Thu, 23 Nov 2023 17:03:00 +0000
Subject: [PATCH v6 1/8] media: qcom: camss: Flag which VFEs require a
 power-domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231123-b4-camss-named-power-domains-v6-1-3ec2fd9e8e36@linaro.org>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment we have some complex code for determining if a VFE requires a
power-domain attachment. Particularly discordant in this scheme is the
subtle reliance on VFE and VFE Lite declaration ordering in our resources.

VFE id is used to determine if a VFE is lite or not and consequently if a
VFE requires power-domain attachment. VFE Lite though is not a correct
delineation between power-domain and non power-domain state since early
SoCs have neither VFE Lite nor power-domains attached to VFEs.

Introduce has_pd to the VFE resource structure to allow the CAMSS code to
understand if it needs to try to attach a power-domain for a given VFE.

As a side-effect from this we no longer need to care about VFE Lite or
non-Lite or the id number associated with either and which order the
VFE/VFE Lite was declared in.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 8 ++++++++
 drivers/media/platform/qcom/camss/camss.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 8e78dd8d5961e..ed01a3ac7a38e 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -278,6 +278,7 @@ static const struct camss_subdev_resources vfe_res_8x96[] = {
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
 		.line_num = 3,
+		.has_pd = true,
 		.ops = &vfe_ops_4_7
 	},
 
@@ -298,6 +299,7 @@ static const struct camss_subdev_resources vfe_res_8x96[] = {
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
 		.line_num = 3,
+		.has_pd = true,
 		.ops = &vfe_ops_4_7
 	}
 };
@@ -468,6 +470,7 @@ static const struct camss_subdev_resources vfe_res_660[] = {
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
 		.line_num = 3,
+		.has_pd = true,
 		.ops = &vfe_ops_4_8
 	},
 
@@ -491,6 +494,7 @@ static const struct camss_subdev_resources vfe_res_660[] = {
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
 		.line_num = 3,
+		.has_pd = true,
 		.ops = &vfe_ops_4_8
 	}
 };
@@ -658,6 +662,7 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
 		.line_num = 4,
+		.has_pd = true,
 		.ops = &vfe_ops_170
 	},
 
@@ -680,6 +685,7 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
 		.line_num = 4,
+		.has_pd = true,
 		.ops = &vfe_ops_170
 	},
 
@@ -840,6 +846,7 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
 		.line_num = 3,
+		.has_pd = true,
 		.ops = &vfe_ops_480
 	},
 	/* VFE1 */
@@ -860,6 +867,7 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
 		.line_num = 3,
+		.has_pd = true,
 		.ops = &vfe_ops_480
 	},
 	/* VFE2 (lite) */
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 8acad7321c09d..b854cff1774d4 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -49,6 +49,7 @@ struct camss_subdev_resources {
 	char *reg[CAMSS_RES_MAX];
 	char *interrupt[CAMSS_RES_MAX];
 	u8 line_num;
+	bool has_pd;
 	const void *ops;
 };
 

-- 
2.42.0

