Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8692A80E524
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345969AbjLLHyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345948AbjLLHyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:54:02 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08719BE;
        Mon, 11 Dec 2023 23:54:08 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d32c5ce32eso9182475ad.0;
        Mon, 11 Dec 2023 23:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702367647; x=1702972447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hLAkJYqh5vIw0PwclUtW4cStuFQ6fy/7mCCMuD7gQ4=;
        b=TRElaMq/Au8XqFFHGqtLXnV7uRdxKUm4UP1JGenaC4MW/yARmuFn9A/eb9nmyc7abo
         nCO1+Eikm81Y6nifsv4D3dTvlvzJicNYdW6fXKONyvUBl+mZzrbJ+7prVrjDw/PtjF22
         h50eG52pwIXg74xH8eCuupnOCtPL6h5xz4yXd8qG6nwH84zGCFkGjP1YLvTwxyUbNRTx
         5Q95X1v4KlEywa8gTiRqG7R3eNX0q3cE5wyRUwPLKCuKNClbO6IJkFYFSfS2+yaYdNET
         c4v+jYkZ2m9uukamr3bb1jUoDdDr9+hzOsJLrUtohkMWxSmd/5EqkFvlC3ouh1DZlH+M
         fV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702367647; x=1702972447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hLAkJYqh5vIw0PwclUtW4cStuFQ6fy/7mCCMuD7gQ4=;
        b=qQwz0hPge3VpXOGCwua3COg690UuUGbEuyBhhTLeHI21Y3YMp2HwzRMHq3QzrGHQrl
         LL3zuSbCK+ppPln2+7POZ8kFeor3QXCTVyfQZhYMkAL6cjmj4it9+hVM+Y/bo88g9r66
         k9OzGKvI3oZ58nPYndUzugZl/KdyR/Z9Zl+SeFN9VIW490I9s+C1duGvjKiPDERLHNuq
         JA3kVrXnwCbmq36cLiI1uDguWBTwGY+Ii1Q++l5lvwjNYj6xLo2sbXBeZN+SuVEZ9VUl
         CC6qMN7DWxRjnOpjI4MlcmisqwlNmXbfLfqaHzk0NRrv6xWcVbpq5oe0VB6YMlz8Lmz3
         lxAg==
X-Gm-Message-State: AOJu0Yw4egvjWNR5IwJZ1kdC8ovJNhWnfCrrdYXawzNwm9vKeNk0sB3P
        ZRRbVStx+kf7/kadR7CaZb6AzDz7jeQ=
X-Google-Smtp-Source: AGHT+IFzl5/4KHd0c4eJu51FdvpkTwoMSew/3UdLZxGnzPbpxbNtS9KEm1/sM6ZymTzAW/BRC1IT9w==
X-Received: by 2002:a17:90b:19d8:b0:286:7ec2:df49 with SMTP id nm24-20020a17090b19d800b002867ec2df49mr7008802pjb.9.1702367647535;
        Mon, 11 Dec 2023 23:54:07 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id qi9-20020a17090b274900b0028a28ad810csm8144319pjb.56.2023.12.11.23.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:54:07 -0800 (PST)
From:   Yang Chen <yangchen.openbmc@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        patrick@stwcx.xyz, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jerry.Lin@quantatw.com, EasonChen1@quantatw.com,
        Leslie.Tong@quantatw.com, yangchen.openbmc@gmail.com
Subject: [PATCH 01/11] ARM: dts: aspeed: minerva: Revise the name of DTS
Date:   Tue, 12 Dec 2023 15:51:50 +0800
Message-Id: <20231212075200.983536-2-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
References: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The project Minerva which is the platform used by Meta has two boards: the
Chassis Management Module (Minerva) and the Motherboard (Harma), so change
the DTS name to minerva here for CMM use.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile                               | 2 +-
 ...facebook-minerva-cmc.dts => aspeed-bmc-facebook-minerva.dts} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/boot/dts/aspeed/{aspeed-bmc-facebook-minerva-cmc.dts => aspeed-bmc-facebook-minerva.dts} (99%)

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index d3ac20e316d0..b1da302dbcd6 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -19,7 +19,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-fuji.dtb \
 	aspeed-bmc-facebook-galaxy100.dtb \
 	aspeed-bmc-facebook-greatlakes.dtb \
-	aspeed-bmc-facebook-minerva-cmc.dtb \
+	aspeed-bmc-facebook-minerva.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
similarity index 99%
rename from arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index f04ef9063520..c755fb3258a4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -7,7 +7,7 @@
 #include <dt-bindings/i2c/i2c.h>
 
 / {
-	model = "Facebook Minerva CMC";
+	model = "Facebook Minerva CMM";
 	compatible = "facebook,minerva-cmc", "aspeed,ast2600";
 
 	aliases {
-- 
2.34.1

