Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7847F64C6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbjKWRDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345436AbjKWRDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:03:25 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B3310F0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:03:15 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b2b3da41eso7254395e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700758994; x=1701363794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ib96ZmK5LO+Py4E9hj9+63+qAtneu0ywuXljodtPMuY=;
        b=U6x5YaXszv099+Rk8xUiToMirZjVQ4Cefr3zDfKmRhXwx3YnbIuJ/jbZtuuAPKDzBU
         kXf5v2RRD6UDJESXHk3GD7a2oc45RqS0K5QKm+0ikTSM97o+I4ViNzpYHk6bGAOrnK4n
         HLZmms2usNkO9wV05qluLhOsaoW6sswIAS9xK47HFZeBOgohZIc9gDQ1yhgQpClzYyMD
         WlBF9DVqlHNkNj/0Ad/ENKrZ1GEpFpdXihJemXBcuuMQ3LU4ROamgjJbgUk8fI5Rean5
         OHl4gVDnQ5Im5Fdy9f5u3+fNt13dlsi8brLIVC98JjEWdTVO2cu55FuMK7sXxoLA6cLs
         oyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700758994; x=1701363794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ib96ZmK5LO+Py4E9hj9+63+qAtneu0ywuXljodtPMuY=;
        b=emTv8fXvujdxZRXoR5VzDiYRS6o+eKKmjv/GknywvL0DIwveHmyyFY9MNVMBht7REN
         u6OO7n2vQX3acVUJAjMtuH6WNQtw8oA4cAYo/UkZyOiv1rZlEiy5uJTJst3SAPyTYcAd
         UI6xKx1HmA3d1fqRR/tuU2OrZv+lcY1oFUMb+OI/DpXABcW51phDx/NVhZ8jAP4/+BLc
         DvGuNIDl1ePzG0Ig1pCjNt1eKCq1nmu3ERrHRndkdiOW0Cob8m56CStTb8gND/7yoyWX
         bxr0icZ1Yf9Dae4ePVW+V6c7rhcuOndSAlRWkxalQeUAtvrFj5V2yAtlNQuCTlHs0mWZ
         0Ogw==
X-Gm-Message-State: AOJu0YxmLpZL8MsWVTJD6xwD6RFjYU5IcEa0UsPa7shqKzChOjpHruXW
        ue15VGfbnzzDFETEIAljvG+cZg==
X-Google-Smtp-Source: AGHT+IE2ZsqjgtFXfB0jHpQJO9dliYDAYlVpzG4gO7GaQKDTrmrF47UPTmiVBiwsPE265TSI2nmWKg==
X-Received: by 2002:a05:600c:3505:b0:405:3d41:5646 with SMTP id h5-20020a05600c350500b004053d415646mr159586wmq.2.1700758993999;
        Thu, 23 Nov 2023 09:03:13 -0800 (PST)
Received: from [127.0.0.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id f9-20020a0560001b0900b0032196c508e3sm2172585wrz.53.2023.11.23.09.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 09:03:13 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:   Thu, 23 Nov 2023 17:03:07 +0000
Subject: [PATCH v6 8/8] media: qcom: camss: Add sm8250 named power-domain
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-b4-camss-named-power-domains-v6-8-3ec2fd9e8e36@linaro.org>
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

Declare power-domain names "top", "ife0" and "ife1" eponymously for the
power-domains TITAN_TOP_GDSC, IFE_0_GDSC and IFE_1_GDSC respectively.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 942db0dffa59f..3bb23fd29959c 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -849,6 +849,7 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
+		.pd_name = "ife0",
 		.line_num = 3,
 		.has_pd = true,
 		.ops = &vfe_ops_480
@@ -870,6 +871,7 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 				{ 0 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
+		.pd_name = "ife1",
 		.line_num = 3,
 		.has_pd = true,
 		.ops = &vfe_ops_480
@@ -1810,6 +1812,7 @@ static const struct camss_resources sdm845_resources = {
 
 static const struct camss_resources sm8250_resources = {
 	.version = CAMSS_8250,
+	.pd_name = "top",
 	.csiphy_res = csiphy_res_8250,
 	.csid_res = csid_res_8250,
 	.vfe_res = vfe_res_8250,

-- 
2.42.0

