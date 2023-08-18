Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8FC780EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377994AbjHRPK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378004AbjHRPKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:10:50 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F8EE5F;
        Fri, 18 Aug 2023 08:10:49 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76d86b5e37aso64554985a.0;
        Fri, 18 Aug 2023 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692371448; x=1692976248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM3ddTmL3QgnOlaA1OLoKs8b5V811de6dCp7PcXvnc4=;
        b=Kf8VuA48yqIHJmmslvDJIZAzYPfqbSC0peyADZaBnH0G23UkWW2TL80/MCJevIk/71
         ZMz0pkD2/paSkGGyeSLJapnmfNT3MWEeRU0MPFRwc71+OXtxGi4Bnl1kLv+p0co0lCPJ
         /e94WyN7MfCDM6VmUft81FHsA9OTt3FLfDpbO0WC9jCSVZOvxn73Ume5TuYxU9Qn+oRg
         T8snk4KPQ2QUBoxwUtZMPM5LJBbDvM8YeVc+nklnrNMlndJX4+5l5W3ReimP1PCFqOqN
         inTbpFUaIVfV8/2NIEme+73eEEZG760e+0yWczU8ot0VJ87Ln14CAR/wgwhWL4+H8r2K
         Gq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371448; x=1692976248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jM3ddTmL3QgnOlaA1OLoKs8b5V811de6dCp7PcXvnc4=;
        b=He6jPRLcfbSLhpPClBOV2AgiIBoRz1y4DLpNxa8x0m+oefjp4SZWcTS9GsAZQ1+K+s
         cyeB5AKBo9FWyKxWfRmcKEE+j6x2fa62vF6ISwpjEUTLNbwz2u/PrPdPiyaCDuSI+etS
         UuoF+KpcQAArGGAb/y6dvV4kszBIhYJC3RLKEWAXMuRbCz9WfKIunycNCQnkPui4gJba
         FU5BB/rxvjveHjQ2cxeei4MIstogNlkxagVGzu6bhtlwPw29pHAAqVa180Z+iWpgrvAc
         R6RMnFOqexe5BdvSgn+FFCRqphOaBsMCD84oZoxWFE36anmXjqW+V267e8pPrWCHR2mI
         a8Tg==
X-Gm-Message-State: AOJu0YyIjOnCIkfJJcgnIy6zZLt0g0/4gf+jMPQchgPcvAHeFqfaKbQM
        vWTo2SkBraNAikrQpIn0alk=
X-Google-Smtp-Source: AGHT+IEAPvRPfBm9icxZc+Ae6KxUSi+FYvDxMnFNr13qGWvRXxIDaFxMmFK2YsBVoDokUOAZ5wLVjA==
X-Received: by 2002:a05:620a:2444:b0:767:2919:f38f with SMTP id h4-20020a05620a244400b007672919f38fmr3765198qkn.10.1692371448716;
        Fri, 18 Aug 2023 08:10:48 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id w3-20020a05620a148300b0076cbcf8ad3bsm576239qkj.55.2023.08.18.08.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:10:47 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     drew@beagleboard.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: dts: am335x-pocketbeagle: remove dependency cycle
Date:   Fri, 18 Aug 2023 11:10:35 -0400
Message-ID: <20230818151039.40566-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230818151039.40566-1-twoerner@gmail.com>
References: <20230818151039.40566-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the self-referenceing "pinctrl-0" entry inside the pinmux clause.
This eliminates the set of boot messages (one for each referenced pin)
similar to the following:

        platform 44e10800.pinmux: Fixed dependency cycle(s) with /ocp/interconnect@44c00000/segment@200000/target-module@10000/scm@0/pinmux@800/pinmux_P2_17_gpio

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
index 1c11245f6864..1e72b8382597 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
@@ -213,11 +213,6 @@ &am33xx_pinmux {
 	compatible = "pinconf-single";
 	pinctrl-names = "default";
 
-	pinctrl-0 =   < &P2_03_gpio &P1_34_gpio &P2_19_gpio &P2_24_gpio
-			&P2_33_gpio &P2_22_gpio &P2_18_gpio &P2_10_gpio
-			&P2_06_gpio &P2_04_gpio &P2_02_gpio &P2_08_gpio
-			&P2_17_gpio >;
-
 	/* P2_03 (ZCZ ball T10) gpio0_23 0x824 PIN 9 */
 	P2_03_gpio: P2-03-gpio-pins {
 		pinctrl-single,pins = <
-- 
2.41.0.327.gaa9166bcc0ba

