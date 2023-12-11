Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B2080C3BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjLKI6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjLKI6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:58:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38D4FD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:58:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c32df9174so34107015e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702285116; x=1702889916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xndb3S0aJ33QuSezQAhJtJok3tQar4xBD7H+FypbxGQ=;
        b=fESYPOZqQRo4exK22pcFuRV9GYGoEGUAE32whSmB9c341eUJQVGCSPY9z/qllqQl+I
         kpGlYxYuah0edkqZoxIFHUt9CYp8cBP1eQyl1RvkyMreaywc3jtbQfWowofwnrTQPa+H
         Z5SUMayA3XGNttxsXLjYJckZl+36jxkysSaIfZtylsu43WaIKehJrR8LvEHeXPhfCJ1+
         NCaXYp1UTxvQrI8Qj9+gSkamq6NzeD+ldbJ6uB7vb3VCefRbwpsfwjCgn1L6R26rMCjL
         wJ81gE4xuNmKv6KAJQAsNNkT7o3GO/SyhBvPy78417v6UYL0eBauHf4gdUY+RGMXTlbl
         L5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285116; x=1702889916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xndb3S0aJ33QuSezQAhJtJok3tQar4xBD7H+FypbxGQ=;
        b=mye8QOXJbLMLYM2LHwFG9t2BeM8+7VZ3edThJcbqUZX8IMARl/X9EE03AToBaUBQsG
         bj5tekJbZzG/x0VsbP+jXhah9CfMf/oHmbJUTQ8BmDie78a8N0PnWplr96MzPIablvC3
         6ZtGbLs76lL2i9OEMj/ddBsM/mRYv6C13D29fJneYeo9cf3Ak/dVXlpa+JC+dNvun+kH
         ICAAjuZNBDteO40/bcwfQ8CEj6sihoRgu0YfXJ6X9y3n9dVtn5ArBplAuLhRPbAmGGzI
         +vZx0B9BIzIZZipBLjLA7sQqLbQyFcZjn3suluKI0skklaAFEdEzRRsMTv7WBQ4y8GMz
         o9Wg==
X-Gm-Message-State: AOJu0YyIlnioUihiglJ4UIjWHUokov7Y6LHMpPgyaeAlmM6d0gBZi5z6
        OmEYASYKyDvyROZ9Z3vTMq+JFw==
X-Google-Smtp-Source: AGHT+IFj7nAJyqu+vNt9O5FvQS/Z/HfcaRXMdNaRLjM9frtJGn8AOK1htzp5C1UgMbr5OAVzW2Flfw==
X-Received: by 2002:a05:600c:2184:b0:40b:5e21:c5af with SMTP id e4-20020a05600c218400b0040b5e21c5afmr1423973wme.125.1702285116186;
        Mon, 11 Dec 2023 00:58:36 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id fl9-20020a05600c0b8900b0040b43da0bbasm12315067wmb.30.2023.12.11.00.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 00:58:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 3/3] arm64: dts: qcom: ipq8074: add dedicated SDHCI compatible
Date:   Mon, 11 Dec 2023 09:58:30 +0100
Message-Id: <20231211085830.25380-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211085830.25380-1-krzysztof.kozlowski@linaro.org>
References: <20231211085830.25380-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dedicated compatible for the SDHCI MMC controller, because usage of
generic qcom,sdhci-msm-v4 compatible alone is deprecated.

Cc: Chukun Pan <amadeus@jmu.edu.cn>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index dca7005c0a9d..915c22b0f270 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -400,7 +400,7 @@ spmi_bus: spmi@200f000 {
 		};
 
 		sdhc_1: mmc@7824900 {
-			compatible = "qcom,sdhci-msm-v4";
+			compatible = "qcom,ipq8074-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x7824900 0x500>, <0x7824000 0x800>;
 			reg-names = "hc", "core";
 
-- 
2.34.1

