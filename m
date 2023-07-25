Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD24760DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjGYJBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjGYJBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:01:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1D02100
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:00:47 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fc04692e20so51872205e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690275638; x=1690880438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icO3d3uWVI1Ske0MIHcKUIP285+5TQhyvGKynKcarCg=;
        b=qnCYmM6BJyv1Kl4qBOeYmNIfEPeInO5QGW3kjTgb9vkXSYyGqYALWrmWonXCZ1ODuk
         dHDorFnKy0ODvRsnS3SAybtdTewEKSlIAOeESkADTPmxTjPa7vG6Ie2LOcQFPCyCOXDB
         Gk4cY3cehTtlL47UgjtTVcEKl4cjIdITsDJVHXmuh8ZyFuJ/y/C87HmX/+Et8FtXOfYv
         MCAcaBfCY/+8sR1HRyOFDpvgepi5v0ZPbnVMTpSYaKq4KSTkLzW/H/pfaZU87SPXKwbT
         dedXggaFRw5YpoaMIoq5KbuuU840x7r5dWE1T1CtiCdJ6m+BDJpuDaH9p+v7LjdmZEik
         aBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690275638; x=1690880438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icO3d3uWVI1Ske0MIHcKUIP285+5TQhyvGKynKcarCg=;
        b=CNdp0pNph0lNvX/Tl8s6VwjBQpqG4cJBtGBcjOBS4N2poULEmvl1T4rkAgYHvLbmc5
         hAkfFPjJ+t8MhyWK5/oa6I3Sa94BSk2vk/cnU8miZGwx9oKjB2X/BA7FtejtJmGBvACj
         ch3w7F1NfaYV48GRHcqRdAQJ9rQVrf58JqGabj8IIBRb+Mkg5rv11qQ4Vfc2rQynwL9n
         uGGP5K7HGxq0dahcTKJ7vHhaF5p+eG2Lm11j/TxkqUipPlpiHSTbxU7SdTvIgRUjqTAe
         s5vaDkeRqsza1BPOMiTKHo0QpHG3Cl6WyQgpwKPsbQUXAWfhWAqLmbU5UodB1s7ma0rT
         ++XA==
X-Gm-Message-State: ABy/qLaWxcoxzCaQ9rskuo5UUzOXPrJHm+BUf2wPluY+xpo5thqgqbmG
        K2eNJAx5EzuepI5FO4Ic+RFakg==
X-Google-Smtp-Source: APBJJlHp6T1MB4wDdldWcQ+TigKJJVv9aHQoxwTURuGJ9mob/EBQSycs938HCPjTMXYyzHlexTW9vg==
X-Received: by 2002:a05:600c:22cf:b0:3fd:2dd9:6d58 with SMTP id 15-20020a05600c22cf00b003fd2dd96d58mr7113128wmg.26.1690275638192;
        Tue, 25 Jul 2023 02:00:38 -0700 (PDT)
Received: from [192.168.1.101] (abxj221.neoplus.adsl.tpnet.pl. [83.9.3.221])
        by smtp.gmail.com with ESMTPSA id f5-20020a1c6a05000000b003fc015ae1e1sm12648420wmc.3.2023.07.25.02.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 02:00:37 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 25 Jul 2023 11:00:30 +0200
Subject: [PATCH v4 3/3] remoteproc: qcom: pas: Add SM6375 MPSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230725-topic-6375_rproc-v4-3-d55e8a6d0f5f@linaro.org>
References: <20230725-topic-6375_rproc-v4-0-d55e8a6d0f5f@linaro.org>
In-Reply-To: <20230725-topic-6375_rproc-v4-0-d55e8a6d0f5f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690275632; l=1570;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=sj7Uy3Esp9/kv46p/vCH0qMBjFc8YM0n5pfjJE2JRcc=;
 b=tj7otmCNcsfvt3qlyFn/RfNnxqor/qP+02vY0/mdd83Mkg2azTQyDLl5/lt+Fo7IC0kgd/0Fm
 bwi5UamLR4KDY95Bfnob6XctHbKPKwI6twgfwa7KEFE51zz+IBXHep4
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a config for the MPSS present on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 0d58b5be9a77..1c87ae9cec9e 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -813,6 +813,21 @@ static const struct adsp_data sm6350_adsp_resource = {
 	.ssctl_id = 0x14,
 };
 
+static const struct adsp_data sm6375_mpss_resource = {
+	.crash_reason_smem = 421,
+	.firmware_name = "modem.mdt",
+	.pas_id = 4,
+	.minidump_id = 3,
+	.auto_boot = false,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		NULL
+	},
+	.ssr_name = "mpss",
+	.sysmon_name = "modem",
+	.ssctl_id = 0x12,
+};
+
 static const struct adsp_data sm8150_adsp_resource = {
 		.crash_reason_smem = 423,
 		.firmware_name = "adsp.mdt",
@@ -1182,6 +1197,7 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sm6350-mpss-pas", .data = &mpss_resource_init},
 	{ .compatible = "qcom,sm6375-adsp-pas", .data = &sm6350_adsp_resource},
 	{ .compatible = "qcom,sm6375-cdsp-pas", .data = &sm8150_cdsp_resource},
+	{ .compatible = "qcom,sm6375-mpss-pas", .data = &sm6375_mpss_resource},
 	{ .compatible = "qcom,sm8150-adsp-pas", .data = &sm8150_adsp_resource},
 	{ .compatible = "qcom,sm8150-cdsp-pas", .data = &sm8150_cdsp_resource},
 	{ .compatible = "qcom,sm8150-mpss-pas", .data = &mpss_resource_init},

-- 
2.41.0

