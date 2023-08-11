Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8B3778EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbjHKMQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbjHKMPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:15:51 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FC030F4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:41 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so29292961fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691756140; x=1692360940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMFnOGKpCcHz5aHCcTcO1hOPnRIEMr4GyfIgQMZzpno=;
        b=I5fddxg1ujfTktw/WvgkoLmgj9nY3HdQIAXurg/1qJ8sRybNrpgPGSBhT2MiFO2HCN
         FmiT45IWTA//ie3PmK64LQ5RUG1wO4G7Xl53BW1qZZItaOaOVd55DhEELI4Ym5GDEom2
         80cnN1U6LKn9eVld/DMCLs0B9gLM14DRk3vkqGaT7v7p5lmRbZgGpg/1iICm3g/ZQSWl
         HwgF8s+/JponTStQfJWTNPJj3hpxjEdfB+Nt9w2P0vidyRWbhgyeKRrzIC5nJgxLYolz
         GGndVuLwxsFnWMNFFZqbhQ5w+M2GQ95L2snS7TTpqf2mSu3m5FkX0I9QBFUg1IyFALcC
         0bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756140; x=1692360940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMFnOGKpCcHz5aHCcTcO1hOPnRIEMr4GyfIgQMZzpno=;
        b=hOB8lXdM0d1Cp9oy0Pgw0TD9tzh2C+jz07qAw1wX+5EIUV/Uqe3CxZ+/wDhOrNVslN
         8yTErz58F2W30B+E5jCRS74SO/2mDF7BPr1aqmbwmyYFc95w/+IeHD3rF5YUMfAF23kZ
         W0PlS1b7d06x774m4udlUU1ERsL0GGPpT59zdV3zcgI+tQUndcFeFMbpgYZb5wj/ls+O
         k65ClUSGTpligJ4Q924jt6r58XBuQh96vnNj0DdzRmn5k8/24VuLMR/MRfr8g6JnI7jU
         K3ri/ypfTMZfAGWmJb5lIrwbbq9JaNioOu7kEOqoiod+cFrhk5fgCd2fSSXYgg3s4j+D
         GpDw==
X-Gm-Message-State: AOJu0YxQU8VwTsWxzqc2lAau1qj+E6I3GHK/DXDuOZa97w59Ac25IzjT
        HY3FQcH0nFGsyzuIHvJGZkFaLg==
X-Google-Smtp-Source: AGHT+IH9i4rUa8QLQq/9DPegBYBau7TirN5yQuzoJp+QgPPboMiE+oKZ+VBtL6EtXVpbhrzE/5IYKA==
X-Received: by 2002:a2e:878b:0:b0:2b6:d5af:1160 with SMTP id n11-20020a2e878b000000b002b6d5af1160mr1537823lji.28.1691756140122;
        Fri, 11 Aug 2023 05:15:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e870c000000b002b9ec22d9fasm848487lji.29.2023.08.11.05.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:15:39 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 14:15:21 +0200
Subject: [PATCH 10/20] interconnect: qcom: icc-rpmh: Retire DEFINE_QNODE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_retire_macrosd-v1-10-c03aaeffc769@linaro.org>
References: <20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org>
In-Reply-To: <20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691756124; l=1035;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=pd0W+LxTiFTGtTMU3Fep3iWiCLhzL6DwXUHDT8FpVKE=;
 b=MxaKndL9wx6bJm+vBda2UR90He1xiFXTlkWe52jrhlEOFT1EIrYms18uqBD9TjXaXgWc1VKxA
 FVbGLPiLgNODhdksdCbudhoqsH6DjcAqwvrOOu+9Sj6jbnNaFJJvlZV
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper has no users anymore. Kill it with heavy fire.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpmh.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 7843d8864d6b..5f0af8b1fc43 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -120,16 +120,6 @@ struct qcom_icc_desc {
 	size_t num_bcms;
 };
 
-#define DEFINE_QNODE(_name, _id, _channels, _buswidth, ...)		\
-		static struct qcom_icc_node _name = {			\
-		.id = _id,						\
-		.name = #_name,						\
-		.channels = _channels,					\
-		.buswidth = _buswidth,					\
-		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
-		.links = { __VA_ARGS__ },				\
-	}
-
 int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 		       u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 int qcom_icc_set(struct icc_node *src, struct icc_node *dst);

-- 
2.41.0

