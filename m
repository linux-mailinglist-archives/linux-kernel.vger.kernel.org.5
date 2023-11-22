Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3847F5123
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344536AbjKVUGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344482AbjKVUGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:06:15 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA6E1B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:06:10 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b30308c67so971175e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700683569; x=1701288369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EOznFpP5Wm2+kn1uG/Do2cPlHmY6zYZfJbOPAYwR3c=;
        b=H5sORdv/9BystWaiQuivjt+vLaUn7y6XsfLSe3qrr/nPUTEptZYy2bOoyXJWkzqaMH
         gBlXUt3Zwa0DDDP1cfbUiaDvY0a4Af2F8DSWdQvn6u2G6jOEr4jiOt910q35cvd9TgF6
         tnb3RIUMR/tUxV4NtOc/SnW9oVMrxJ+ocMf0rD9osS+lr6MpS2iC+nvh1xyuPTLLybI9
         9s3B/nKvV59Vu1LN5MNxZ0yNFuFxJ2g0mwxL0SZBOuCYBfm6Qpkfv3ZbiCyErHlBx94g
         RbJrLwOkE1mjiTVzR6hI13YawQncBv6iKbkv92mFN+RlezKVTvPULpTk4MpUfqgwBA1Z
         gmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683569; x=1701288369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EOznFpP5Wm2+kn1uG/Do2cPlHmY6zYZfJbOPAYwR3c=;
        b=Jlw5lVvC53oPKMxpiM1kZn2z4N0tSuc+uktgbD7ls2UJ9/DNZpH/+/+uPOv/J8ThhF
         UHUy10Y1I1c0kaRFGF2qkb80QQLb74AOtXi37Wg9xOAkHgaOHsScjb9BP1W4oFaOZShK
         fNPx9GQFDsESMpkGttEN5/7dbtMkhCFTr1csHH69XSWEoYka7vDS5LfxuXaG+bvQNF6I
         SpiDb3a8kbi5+wJkPUrJjH+3ex4/O238ifXG5uJIXQsrZYKa8gQnzrxquNijaRKYJhON
         SKyMQt0BXaaoe7OiIhZ0epLn+DFYC95tvWVFNOFQYt4T9sJKbIKgDIrcA0dX9eFc5vnL
         IXGw==
X-Gm-Message-State: AOJu0YzTfVjc8FgpudnbvH+EKrxwIxKFDGhgACNITBw1j+VyPuU7kW1Z
        VRkMSbL5YnGwh4jVg/Txrsg7LFWiMFlxQxPMvlU=
X-Google-Smtp-Source: AGHT+IGCVfLzK8Oe+0XBpSNMCveU4O6Qvzpw6gxialiMohgi0yDnSXJlz9A+pgM+VMFdYfI+HDlEDg==
X-Received: by 2002:a05:600c:138c:b0:408:4cf7:4f91 with SMTP id u12-20020a05600c138c00b004084cf74f91mr2636634wmf.16.1700683569119;
        Wed, 22 Nov 2023 12:06:09 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id l17-20020a05600c4f1100b004063c9f68f2sm394665wmq.26.2023.11.22.12.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:06:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        semen.protsenko@linaro.org, Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH 3/3] arm64: dts: exynosautov9: use Exynos7 fallbacks for pin wake-up controllers
Date:   Wed, 22 Nov 2023 21:04:07 +0100
Message-Id: <20231122200407.423264-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122200407.423264-1-krzysztof.kozlowski@linaro.org>
References: <20231122200407.423264-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ExynosAutov9 pin controller capable of wake-ups is still compatible with
Exynos7, however it does not mux interrupts. Add Exynos7 compatible
fallback to annotate that compatibility and match the bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: semen.protsenko@linaro.org
Cc: Jaewon Kim <jaewon02.kim@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
index 417aa56a81f6..c871a2f49fda 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
@@ -310,7 +310,9 @@ pinctrl_alive: pinctrl@10450000 {
 			reg = <0x10450000 0x1000>;
 
 			wakeup-interrupt-controller {
-				compatible = "samsung,exynosautov9-wakeup-eint";
+				compatible = "samsung,exynosautov9-wakeup-eint",
+					     "samsung,exynos850-wakeup-eint",
+					     "samsung,exynos7-wakeup-eint";
 			};
 		};
 
-- 
2.34.1

