Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FD379EC60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241531AbjIMPQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbjIMPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:16:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662711A7;
        Wed, 13 Sep 2023 08:16:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401d67434daso75562535e9.2;
        Wed, 13 Sep 2023 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694618185; x=1695222985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNiCJ4XPctshWY8ffyi9hR4b/TdmnnAhBF7gV8ICkpY=;
        b=luVNVtZ3HmtBpd07XMkFDVZY+sc2LdHrJMG/sku0osKa8/hbiDgwi7kXer9Pqmvxcw
         g3NSG44iZmbUbYP6jtoqoK/QBWyc+4GgE0tj0qcEr8nQDsuQ38/xFifSCsmWLvF5jIPb
         W76tiamkOw2gwhzXy/typafy5UusQHnDLXMQgzoWPgkzvdlt5qSQAxGi5nZLXmClOUZs
         m+pr5lyDZ++X9Ps5Q4/8iem0LlutfGy4TxDldeOHhwQIYltuHyUqXceY5p6YELMvHdQw
         W3aW8/9qedUBDQ32Rx1r139ritUYBnjRUlaiSv0h3f9VmzhdavDJgeRksko44XnkdVF0
         k2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618185; x=1695222985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNiCJ4XPctshWY8ffyi9hR4b/TdmnnAhBF7gV8ICkpY=;
        b=IWB3e9oA9zpqxz1mzB80C14MMH8gJBCWpV37lz7ZzRyu64hfCfrTAmRIMh449sJFtS
         4/NxAfvIGWOHykAb+WIXZrKxSLJiUIy9npRG0veN/v8mp0Tjj4eM3lWRCnr1SiQ/evH+
         sL1XD4w0/W16tFN/i0eD8mF/qrA/eHswnhOsMe/2WAUgWEDkC2dnpbPFarWTOLVPZHAA
         raBf9/2CPNvoQ1vzQ3474f9TGTwU9cQFaVUq3BWQX8ljH9yIz1sHjstLb3dc2aeUI1qA
         LYD2zcHDm4SdUr6MEAF2BgrsDUmV04Zkxa3n3F2AbJrize+KgWdUVwZuo3p2b+ah3G2k
         fY3g==
X-Gm-Message-State: AOJu0YznxRasdmmA3a3/xsvwRYj244Dg+9Uh+HKSEi5wfuTm7xYrnOp1
        iLaMmeS18BPy4SbsW/HVkHA=
X-Google-Smtp-Source: AGHT+IFtGPwLNzmJ9lGo6bgRROyUOek+CMPJmj33rLwvWVE4I8uylAeEe5p5UpRZq9go6jeZN8Tc3g==
X-Received: by 2002:a1c:ed01:0:b0:3fc:21:2c43 with SMTP id l1-20020a1ced01000000b003fc00212c43mr2401041wmh.13.1694618184540;
        Wed, 13 Sep 2023 08:16:24 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id s4-20020a05600c044400b003fee567235bsm2305140wmb.1.2023.09.13.08.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:16:24 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/3] ARM: dts: mstar: Enable rtc for SSD202D
Date:   Wed, 13 Sep 2023 17:16:06 +0200
Message-Id: <20230913151606.69494-4-romain.perier@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913151606.69494-1-romain.perier@gmail.com>
References: <20230913151606.69494-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the definition of the rtc device node. It enables RTC block
for SSD202D SoCs and newer.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/sigmastar/mstar-infinity2m.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sigmastar/mstar-infinity2m.dtsi b/arch/arm/boot/dts/sigmastar/mstar-infinity2m.dtsi
index 1b485efd7156..b4ac535a73c8 100644
--- a/arch/arm/boot/dts/sigmastar/mstar-infinity2m.dtsi
+++ b/arch/arm/boot/dts/sigmastar/mstar-infinity2m.dtsi
@@ -32,6 +32,11 @@ cpu1: cpu@1 {
 };
 
 &riu {
+	rtc@6800 {
+		compatible = "mstar,ssd202d-rtc";
+		reg = <0x6800 0x200>;
+	};
+
 	smpctrl: smpctrl@204000 {
 		reg = <0x204000 0x200>;
 		status = "disabled";
-- 
2.39.2

