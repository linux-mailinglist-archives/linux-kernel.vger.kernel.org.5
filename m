Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B57E02D8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376510AbjKCM3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376451AbjKCM3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:29:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3071A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:29:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4084095722aso14909135e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 05:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699014542; x=1699619342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X26+8wItEuS2j+BVlRHOHS9xadXwL+/+KykUmMySayM=;
        b=wmqclJiT8CLQsS9V4QC1RDHpyFRE7DxyW8ZLCFGauC19Tx1IZVF1btplKs05NM2jkW
         CjsnNuXkTB+6MPrKaXxjbODfjV2ylm9sIJZFlGuiqR9xr2wGaxc+sNkbdSGhCKLtPuXg
         aVTk02X5DnW8QP+2FGf7gBheicXTmprreKibot7hbEv3dAhg0cPPZXQ6lrma9NhxLxer
         MTiT1H2EffbouwRXztSQ7Nqw1LtY3s6TgZYRXR6Tu4VfoKtrboVjAaCh+h8wUUycURhh
         2h8nSuo1KSXVcxacDOaxJ0hfCbEqUKStrm4ZXJYUcapJfPNh+x7EnZx+B5NW/k/huTQC
         EBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699014542; x=1699619342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X26+8wItEuS2j+BVlRHOHS9xadXwL+/+KykUmMySayM=;
        b=Wibv9MUr35BlSmjn4enwiJTvtsURuCv1UqRr/Hl17Y95fpha31IrD/jXodDYglYSwN
         SeJjsl85HXJNBYCbnmxRNFRojEOkBOqUaXprYgfYn2YMBE+S40I3wtA6aZZht1BGwFnt
         c+TCZb6gmTC7twFm+lcurXi0OUVds/picDzoip2+TLzZF3sD5yJuFvSLZMaJ/YqxIzJU
         yeVJw3+90YrL45ybT8nv5HcYbAHs7KROi7Ic3fCLYjQD6hRRVkud9TQ4cC3tEMwSJJIF
         h31d7lnKxmwRH8x/1XZScEUNHj74NpLvVYSumto7HJdvAtEY/2BNKdOO8ihDvDIFbUtX
         qk3g==
X-Gm-Message-State: AOJu0YwhyBTOo6ep+HQCZs8tp5UKqtntWmHd2g1LhiU/KWHYfsod9r0m
        P/Im5k9tvasuCoIEBsvomgS0zA==
X-Google-Smtp-Source: AGHT+IFibQFeeW+UnvTpUlmX4CI9MMCPqb0PdohLu0ndVfbvGhwqlE0MDmQ/oLaQFR/71Zrk7ir3Lw==
X-Received: by 2002:a05:600c:d8:b0:409:718b:33e0 with SMTP id u24-20020a05600c00d800b00409718b33e0mr1183300wmm.16.1699014542297;
        Fri, 03 Nov 2023 05:29:02 -0700 (PDT)
Received: from [127.0.0.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05600c1e0800b0040772138bb7sm2402918wmb.2.2023.11.03.05.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 05:29:01 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:   Fri, 03 Nov 2023 12:28:58 +0000
Subject: [PATCH v4 1/7] media: qcom: camss: Flag which VFEs require a
 power-domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231103-b4-camss-named-power-domains-v4-1-33a905359dbc@linaro.org>
References: <20231103-b4-camss-named-power-domains-v4-0-33a905359dbc@linaro.org>
In-Reply-To: <20231103-b4-camss-named-power-domains-v4-0-33a905359dbc@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

