Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A027E8CAE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 21:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjKKUth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 15:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjKKUtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 15:49:32 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B51A2D77
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 12:49:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40a4d04af5cso4080405e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 12:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699735767; x=1700340567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4JO3wrflztQvCLRxh9c/YzTkfu7aFzRvnmTFixGbvk=;
        b=Yf1aEC8gvjEBLNa2uQQRDIu9QEAni6L4ZKokPdnZq8RM820ptrOJ5Ql6S+AB6eGGvs
         S/RKpeFCuXxYV7yuXIwIY1A45+augElV0BqmDwNzZdZtwLVH15yXnShiYJ8/sqHYsIgx
         n3RWm2CpRZzh5CuMOwouHzpJcdHMTCpWiIsm+NSyDKziK6iM8HZemdRf8XtA1wlVPo8R
         YOM/TH1E0gboubhaG045EkwTG2c0IRl2diWnu8wrrz//Ya12UL8Gm0TmonRUIQ/7bGYN
         dwaUesRpU17m4QgxhStQ63nM06dOouPhb1c/846XvQaW3aEi5pjbrzOHu5MKr7qcEgyJ
         ae+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699735767; x=1700340567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4JO3wrflztQvCLRxh9c/YzTkfu7aFzRvnmTFixGbvk=;
        b=n7UAaxvzHY8RXuXPbggCiGNfA9YQmJa9C35YwJZsM3GZGhxHSZeq37X19jrjGPPmEn
         ZSmJPaEiyv2TGQmhX83krMPcDt0+ufLL1nU7vLXjfl+W5cy2XAASL3uJonkY6pVqO9+d
         BPkCOA3dXeGVmuXSjcswjIv4jhKdsboJae9zdK0N78KjEnthc0ZPzk+d2j15H2ukaxJV
         jW1hu7k4uLxxP6pYscau2afmqRurFMYZbU4ziJJ0lBcHke8Ogju3lLfSeTTPWm79nsbP
         FB69rIAOhHQpg0fhYcIAYHrMv1rWJ5L31WeDKsrqcQvnoaQHcPrR1nVqTssjtp0VgAd3
         dPVw==
X-Gm-Message-State: AOJu0Yw82tRwruiLJ93RnlkyMHF05FYB+1f4v3Wv9vVqIXHSRAnyyn04
        5WWmGClzGj94z/9cuspJ4+yqhQ==
X-Google-Smtp-Source: AGHT+IFjzvE+DwGmctdnC2uZQLa3rYY7uyaFAoERd5ZpRG3Zgu4Rn66Umq0gb2sScDrhCsXQ91QjqA==
X-Received: by 2002:a05:600c:450a:b0:409:375:5a44 with SMTP id t10-20020a05600c450a00b0040903755a44mr2330569wmo.24.1699735767758;
        Sat, 11 Nov 2023 12:49:27 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b00407752bd834sm3121226wmq.1.2023.11.11.12.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 12:49:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 3/3] mailbox: qcom-apcs-ipc: re-organize compatibles with fallbacks
Date:   Sat, 11 Nov 2023 21:49:16 +0100
Message-Id: <20231111204916.35835-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111204916.35835-1-krzysztof.kozlowski@linaro.org>
References: <20231111204916.35835-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to previous commit e17225887005 ("mailbox: qcom-apcs-ipc: do
not grow the of_device_id"), move compatibles with fallbacks in the
of_device_id table, to indicate these are not necessary.  This only
shuffles the code.  No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 002a135ee868..79136fb62f01 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -145,19 +145,19 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8953-apcs-kpss-global", .data = &msm8994_apcs_data },
-	{ .compatible = "qcom,msm8976-apcs-kpss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,msm8994-apcs-kpss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = &msm8996_apcs_data },
-	{ .compatible = "qcom,msm8998-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,qcm2290-apcs-hmss-global", .data = &msm8994_apcs_data },
+	{ .compatible = "qcom,sdm845-apss-shared", .data = &apps_shared_apcs_data },
+	{ .compatible = "qcom,sdx55-apcs-gcc", .data = &sdx55_apcs_data },
+	/* Do not add any more entries using existing driver data */
+	{ .compatible = "qcom,msm8976-apcs-kpss-global", .data = &msm8994_apcs_data },
+	{ .compatible = "qcom,msm8998-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,qcs404-apcs-apps-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,sdm660-apcs-hmss-global", .data = &msm8994_apcs_data },
-	{ .compatible = "qcom,sdm845-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sm4250-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,sm6125-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,sm6115-apcs-hmss-global", .data = &msm8994_apcs_data },
-	{ .compatible = "qcom,sdx55-apcs-gcc", .data = &sdx55_apcs_data },
-	/* Do not add any more entries using existing driver data */
 	{ .compatible = "qcom,ipq5332-apcs-apps-global", .data = &ipq6018_apcs_data },
 	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq6018_apcs_data },
 	{ .compatible = "qcom,sc7180-apss-shared", .data = &apps_shared_apcs_data },
-- 
2.34.1

