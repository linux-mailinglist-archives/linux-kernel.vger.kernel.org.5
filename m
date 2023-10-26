Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34737D863B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345518AbjJZPu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345487AbjJZPuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:50:51 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B1F1AA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:50:48 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507cee17b00so1560447e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698335446; x=1698940246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4eTVZcrGQlOPNYTx/N/Kit5wvfICmRRRsyBtCJrWm8=;
        b=Xj6EAYZXmi5cT5Kx6cgnF6v2izByFzNGMYFGIYmNeMidy9MesNJv50iH4JWu8t3yTk
         IQJUoLICAxHqtvKvgVnmOC8ZEXS8PrVashDS2mq6Qk4l4nSh4hC5jKf5F9AeMX1b0wdg
         l5Pgs3a++tJb0yix+jSmeSRcuwFIrGE31YfpEx0kL4ChMI5xQil/glIekgyD5j0qhiya
         Lh9sSgRCSXyUcGuHZWTlamLe024JZzJhD/MDLiQa1mS0G4RAhu/L4d6TwFhIptozNhIO
         Jk/qZKvMKeGUmTFRYfjZD3Yojc+JOr0416l3NL3QwSPZ71BVIvN2pvgQwWtySEBQlYpR
         MoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335447; x=1698940247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4eTVZcrGQlOPNYTx/N/Kit5wvfICmRRRsyBtCJrWm8=;
        b=UR8Cdhk36RK/IIBgsuyCVDL29FZaJKQ864Ya9T4xGWmoeiL/AnidT0Ams7fmlTLPq2
         R8fQSbRuJ/rdccLQRnctsjS8jbZtLf/V0xdBX1ktO/YIuoKG8szoHr557Rq6P8mPhDMC
         3bFw86vBRyP/tKL9byZleuy4qtcr2wbkNmuv1qXAQPCcA1pWstFG7N6wYDE0jhNLF3hD
         1iOHbwar9Q3s9QqdJNSibMkU6dt6uOIpGI0fqGvX4Do1no4W8JCI9XUSA+9MUT4A7U9P
         apODbL8sH2EacejYVXlkK+zL6NbD2Vs/DI6hjJRCzsiQS8ddQG35dQI/qdt89ci+80nX
         VNnQ==
X-Gm-Message-State: AOJu0Yxj0yyTDemkS1DTEEw9WJt2OT/4BvarUrxqrtyU0IorE8JqMD8H
        QAG9RS5ohqA3V2VNAr19mcmE2w==
X-Google-Smtp-Source: AGHT+IF0+5cjSrQazM8lYqFS0a+UU6pP6wLPPy7KnargF1dXcCXwv1I5AUHYgybwTgRGCCipW3LLUg==
X-Received: by 2002:a05:6512:3da8:b0:508:11c3:c8d9 with SMTP id k40-20020a0565123da800b0050811c3c8d9mr6637976lfv.52.1698335446670;
        Thu, 26 Oct 2023 08:50:46 -0700 (PDT)
Received: from sagittarius-a.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b003feae747ff2sm2938289wms.35.2023.10.26.08.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:50:46 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH v2 1/5] media: qcom: camss: Flag which VFEs require a power-domain
Date:   Thu, 26 Oct 2023 16:50:38 +0100
Message-ID: <20231026155042.551731-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026155042.551731-1-bryan.odonoghue@linaro.org>
References: <20231026155042.551731-1-bryan.odonoghue@linaro.org>
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

Add the flag and populate the resources. Subsequent patches will disjunct
on the bool.

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

