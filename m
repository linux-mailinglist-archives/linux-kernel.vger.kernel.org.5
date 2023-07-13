Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3031675270F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjGMPaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbjGMP3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:29:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427622702
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:29:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31434226a2eso1051949f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689262173; x=1691854173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kp9sugFtWyIDPD/yBMpvNDc39VCfPRNuz+NnzXC9aRs=;
        b=Y0QPRb+aqDCc0MEbQQU3Fz3C3vXNBtkUEbBek3coBBGcSdoTlekUltAoFRT+ITt+0x
         do4e2hS+IteqmBggHX4YkS9ZfmzRrweLmF1BZqcBpBUAFR4q9SIcbyF1Ju1qk9yR8RvX
         kAzaoDVpXiqde1S0BFAJ0Kt6RX4LR6NiJdMNkg/xDToXdRpsKL8zvFhuquwbfx75hOyV
         i4aKCCmdmXJdwP8NgkAyqbiOr0M1ODoBbjeCsGw/3iHQnVNsdOfmhC5QUZuuU7IZhCiq
         i71QfaeN4EEqgejVDgmRFaP/0/FSV3E9qdLYNEF5sltB6HifTQKNpj7XO4QJmRgRJ4Bh
         vthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689262173; x=1691854173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kp9sugFtWyIDPD/yBMpvNDc39VCfPRNuz+NnzXC9aRs=;
        b=fvKwOPpo9nmKh7DV/naoEVh8E0b4cOCTzeotWZ/8pS46bGjct8d2EAx89IM8Sd3vmZ
         f3XHO+zQ7SGvm6kiNg3+KNv16xCgWdpo5Hugi5Vk5naK5lEBluDG8bkX8TwwoN35vWIk
         VXcOHLdF/6noS4pucuoBOO+Guf0QVJuNuyU9ZZU7UrZ+0bVminHI2+eLkZJU1G38eY/a
         BVFQVOGhevjbR5dzNIRnREwT8RNOL/eHSuisyn7ylOGVvAdqFa/j1bKvps9KT2pGw2sN
         x82V8gqABQd1hsLpyg8ruGb98mIhfc0CgAV0JjE+LCFQGNzlP8DNXJZP0WnOGSOsy7ZJ
         8pSg==
X-Gm-Message-State: ABy/qLYRbN5KnnXb+aesag5fzUppO2rqgFyIwGlkSaR+aPZvsThRPQpZ
        gtKFo/QsYvdNGSe+biaoJGZqow==
X-Google-Smtp-Source: APBJJlHiik/5j2yP4OuALeCGWXMARDs1MSuf4Ur9VLzHl7TniGtKQ+UXrP2BTUCTVPBdzP8GMV6abg==
X-Received: by 2002:a5d:4acc:0:b0:315:99be:6fe4 with SMTP id y12-20020a5d4acc000000b0031599be6fe4mr1975591wrs.69.1689262173689;
        Thu, 13 Jul 2023 08:29:33 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d5182000000b003143aa0ca8asm8285924wrv.13.2023.07.13.08.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:29:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: samsung: s5pv210-smdkv210: correct ethernet reg addresses (split)
Date:   Thu, 13 Jul 2023 17:29:26 +0200
Message-Id: <20230713152926.82884-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713152926.82884-1-krzysztof.kozlowski@linaro.org>
References: <20230713152926.82884-1-krzysztof.kozlowski@linaro.org>
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

The davicom,dm9000 Ethernet Controller accepts two reg addresses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/samsung/s5pv210-smdkv210.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/samsung/s5pv210-smdkv210.dts b/arch/arm/boot/dts/samsung/s5pv210-smdkv210.dts
index 6e26c67e0a26..901e7197b136 100644
--- a/arch/arm/boot/dts/samsung/s5pv210-smdkv210.dts
+++ b/arch/arm/boot/dts/samsung/s5pv210-smdkv210.dts
@@ -41,7 +41,7 @@ pmic_ap_clk: clock-0 {
 
 	ethernet@a8000000 {
 		compatible = "davicom,dm9000";
-		reg = <0xA8000000 0x2 0xA8000002 0x2>;
+		reg = <0xa8000000 0x2>, <0xa8000002 0x2>;
 		interrupt-parent = <&gph1>;
 		interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
 		local-mac-address = [00 00 de ad be ef];
-- 
2.34.1

