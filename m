Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D70180B3C2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 11:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjLIKoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 05:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjLIKoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 05:44:14 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3787C8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 02:44:20 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54c846da5e9so2664717a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 02:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702118659; x=1702723459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BCoGI7s/gCFS6PWgnQhz780oAr1iVhq6zVeEGwbfs8=;
        b=cagHxjVd/RLttyqjkwzTlB0EUOuqFfwhesZlYAG2AgnVEnQFgJ3w3WvHWNe04jxQm2
         DYnnOUw+U+mVNaolSxd4fCnlkc5XymraNp6rBEKrnuJ6dosBOeyYVIWBc5ZBNPPJKhrc
         4a3TzEy8vlH+ss45QWUKO4+WqR0krcQpT4k98ALzK18YOSR+DaaohkM397aSHgcsoolu
         Kx7577t3ox5x2gUHeRcGLFin9tlvM6EjEslP8NnymANBni6OrOaiHJeqTzrwtNekTZV4
         ZyqukSI6jmr767ch2FTnayf1+FkBAqX+6p4B2/7enhigLB1nROnkZch6JpvuerK9Nt7G
         +2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702118659; x=1702723459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BCoGI7s/gCFS6PWgnQhz780oAr1iVhq6zVeEGwbfs8=;
        b=gnXlvKAfN+VWqsWq3P1e5IENeIxcQMsd5aDqulTPSeQrofGNpV9oCfUmM4+vMuzZBr
         n9j2ICf1ALKbV1mh8G2icl6o4JwvRqn+pqfZpZI4qAD5H/AFfDlcaOXmY2VXL/bK5iiC
         olZaHOr7rKLwCSm+q74Qgjjrd2mz0ISH4SgP4QKUegzZkD9HZOlBRKHynMEnhKt9e9Xd
         riOV/mwfwSpOjrILREZox++XMlHwUAaNaCNbr11FPUT+CcFV4hag9IWa94LwysvYfZsU
         /+5ESXRy0C6bWCecLLPT8sGY+ROLfFS8PHOloNfirKac1fxYG7+CgiXa8lcfBKhBfTD+
         E/ew==
X-Gm-Message-State: AOJu0YxiOwUHZdVowZ7JNEURcovWBOi2aGrqhPj5INjvqorCjWtDKp2E
        CRWtdsHEmI137Xf6szFui/G4OY5BDVHzL4yCJVk=
X-Google-Smtp-Source: AGHT+IHKXydt6szGsD9Uw4tFNlKvRW/prO21WATDg6wz6AXTumqPVhK40FOV2/2+4YdghH02q1yM9g==
X-Received: by 2002:a50:8d12:0:b0:54b:2894:d198 with SMTP id s18-20020a508d12000000b0054b2894d198mr1011540eds.4.1702118659237;
        Sat, 09 Dec 2023 02:44:19 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id eh12-20020a0564020f8c00b00550e21a4f76sm349604edb.8.2023.12.09.02.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:44:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] ARM: dts: aspeed: yosemite4: correct Mellanox multi-host property
Date:   Sat,  9 Dec 2023 11:44:11 +0100
Message-Id: <20231209104412.12916-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209104412.12916-1-krzysztof.kozlowski@linaro.org>
References: <20231209104412.12916-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"mlx,multi-host" is using incorrect vendor prefix and is not documented.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..1bd555a6c3ba 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -88,7 +88,7 @@ &mac2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii3_default>;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 };
 
 &mac3 {
@@ -96,7 +96,7 @@ &mac3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 };
 
 &fmc {
-- 
2.34.1

