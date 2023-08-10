Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A4E7773E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbjHJJNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjHJJMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:12:33 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B278326A8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:12:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe48d0ab0fso970077e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691658749; x=1692263549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4vMnao8ynro5sLCotm+nXaNSlXbnXYXpD09POJdN54=;
        b=PRSq9Xj1IwTUFdZFXwacGPyOX36KteDLnBAqQZN52uLMB7PYQf2EPsvnZVy8gGvjbz
         KVFPapCZIm9wwTvAmbRN1QYN03qcVJOOkA+tRZhFv0wKfNH6uoHZyxNWALRl9pcIek9o
         TJgsjeSHCrMGD6ZBzNcLXdiB6Pf3coayM/uku3fWcqyBmunH5meFWWQ+6KbjNdeIgM2n
         LgNwjeG/+D2cmUuILvGz1Ll9sGNZKUOG+O72D9Vaze0sB1oQ5R19ABkR2BzpbaJkKN/2
         aPm6aTaJrmhvP9MNjqsVVIAkntwOlJqyfLVzsIASNvwmN7ecd7armrAo1nfsqWXIq+pz
         4sHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658749; x=1692263549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4vMnao8ynro5sLCotm+nXaNSlXbnXYXpD09POJdN54=;
        b=IXPDf2DhrH14srm/RzafG1ln6e1xvscFDImR9240uuiBQSVTnemiTHIjOQHUFc8ugh
         pzlLuZ7QewdEXIpgml9nFGrawmeBslRdGyTA2dnOKashsbt32r+tyYQlbRL2OtFw3TDk
         Si8wt0KJbj5+Nt50vrv8kYI346BjqxR0piSdDenyWEZXGheEudf/6DeQax7j1ZBQdx+E
         9QOl/DHMxu/rQSdach6tXQkUUGulXPCRDtdVq3knLlZFQl5Bftq3pFnkpO/0hRpPbIU4
         GzNETQE+kU+TKuNo5pHq4s+C8/MXP4t/+YGxlJEJd6XDGATPrQmWmsy0/vhDOt9tksA4
         BUhw==
X-Gm-Message-State: AOJu0Yzw1BBV0urcblN5CtO6rkpLVNJzp4EIBTZYq3ZuG6dA+DYDfBfH
        MxwIT8heXCWu0gjJUsYLlgWwXw==
X-Google-Smtp-Source: AGHT+IGm1zgOhdplBb5O86k8X1Zn50kKdJzv8/v8exGVX3ASOQXPtGqlZ9dJZM2GlvtPlOZOrjv0JA==
X-Received: by 2002:ac2:4d19:0:b0:4f8:5905:8e0a with SMTP id r25-20020ac24d19000000b004f859058e0amr1236690lfi.6.1691658748922;
        Thu, 10 Aug 2023 02:12:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id f14-20020a50ee8e000000b0051ded17b30bsm531961edr.40.2023.08.10.02.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:12:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next 2/2] wifi: ath10k: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:12:24 +0200
Message-Id: <20230810091224.70088-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810091224.70088-1-krzysztof.kozlowski@linaro.org>
References: <20230810091224.70088-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'hw_rev' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  ath10k/ahb.c:736:11: error: cast to smaller integer type 'enum ath10k_hw_rev' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/wireless/ath/ath10k/ahb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
index 4a006fb4d424..95bcf54ddc3f 100644
--- a/drivers/net/wireless/ath/ath10k/ahb.c
+++ b/drivers/net/wireless/ath/ath10k/ahb.c
@@ -733,7 +733,7 @@ static int ath10k_ahb_probe(struct platform_device *pdev)
 	int ret;
 	struct ath10k_bus_params bus_params = {};
 
-	hw_rev = (enum ath10k_hw_rev)of_device_get_match_data(&pdev->dev);
+	hw_rev = (uintptr_t)of_device_get_match_data(&pdev->dev);
 	if (!hw_rev) {
 		dev_err(&pdev->dev, "OF data missing\n");
 		return -EINVAL;
-- 
2.34.1

