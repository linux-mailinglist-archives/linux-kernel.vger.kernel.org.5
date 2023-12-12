Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F146A80E532
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345968AbjLLHyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345994AbjLLHyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:54:14 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE624113;
        Mon, 11 Dec 2023 23:54:16 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b9efed2e6fso2878556b6e.0;
        Mon, 11 Dec 2023 23:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702367656; x=1702972456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wECkqtuJuNq4vKf49CMC3VZgJYROzMEL16NeUTjnLOQ=;
        b=JP3qThNAEkZnkHCcMonwVFJZU3spKH1QGJT8kfLY5f/SzPqVZSO37h3efJ433lGIwU
         j/UpckjevWJMmpoOugMncH1B9uvU4gGhiw+EnlJpHH7O5rPUtsjdk2lBSywjk2mioHDF
         FaC1/8Ihs7P026IEuc1ADE9j3rtaWLaPkuhHoaBakCCfKEn7m/g2YHytCRZpKd/53pCv
         KcyIqGV5qpsyILZSZYd2YPUFfdzzY6DXfGNsPG+Hh6bA/uHMdwwKxTsw25geBkTYvmfy
         EFjD+HtiplwrxOzUeBLi++D7xXc4xt6OF8W3/yArU+PmZDMObzWisplCBdgIxvhPxtcY
         j+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702367656; x=1702972456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wECkqtuJuNq4vKf49CMC3VZgJYROzMEL16NeUTjnLOQ=;
        b=fhmkvH3cSZQy/OL/B0R4levm4Ma214e/LESSFD760AqM2W8VPVHrtCwuDXp3K1mLlx
         HSIpmHtO9CkvFzcv6UBP4U6ke5fjSynZzpqNQFUB65mAamdCAnzY/l+UJQOcDRzKooiq
         d/UxaMyQrT8kyEoS17PdaPFb2PKFbWPmD9LzMawTO8WD5r5rBRyhmV52jZap7ftfZIAr
         4rCsth4NcCOE2EpTYdkN2oL2gnpK9+IVK1Cj96hqvcZEKDsnVuMtc/qpAXVVUJ3XTeL1
         Uapnaq8X19LGauRgYj8KP1bdrne4MMili98V8mOTN16Mki4A00/+NIGdbKgBOFfjJ7kZ
         6Ljg==
X-Gm-Message-State: AOJu0YwGCii/jrAK0rB6cEEIDLcx64FZe4pHwhJdqkVJ+MjJfHBaaVs3
        GtV6QcMS3/gTdLPiazgq7UPljZM6zgc=
X-Google-Smtp-Source: AGHT+IGQGVQfpsD+7aVeGROKJ2gCtJW313/hYWDkA6RE83+q24qAb7TXxK2YreBWYGv+y6b18OOdJA==
X-Received: by 2002:a05:6808:640f:b0:3b9:f10f:b69f with SMTP id fg15-20020a056808640f00b003b9f10fb69fmr6399289oib.11.1702367655768;
        Mon, 11 Dec 2023 23:54:15 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id qi9-20020a17090b274900b0028a28ad810csm8144319pjb.56.2023.12.11.23.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:54:15 -0800 (PST)
From:   Yang Chen <yangchen.openbmc@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        patrick@stwcx.xyz, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jerry.Lin@quantatw.com, EasonChen1@quantatw.com,
        Leslie.Tong@quantatw.com, yangchen.openbmc@gmail.com
Subject: [PATCH 04/11] ARM: dts: aspeed: minerva: Enable power monitor device
Date:   Tue, 12 Dec 2023 15:51:53 +0800
Message-Id: <20231212075200.983536-5-yangchen.openbmc@gmail.com>
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

Enable power monitor device ina230 and ltc2945 on the i2c bus 0

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index ad77057f921c..ee9691647e4a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -86,6 +86,28 @@ &sgpiom0 {
 
 &i2c0 {
 	status = "okay";
+
+	power-monitor@40 {
+		compatible = "ti,ina230";
+		reg = <0x40>;
+		shunt-resistor = <1000>;
+	};
+
+	power-monitor@41 {
+		compatible = "ti,ina230";
+		reg = <0x41>;
+		shunt-resistor = <1000>;
+	};
+
+	power-monitor@67 {
+		compatible = "adi,ltc2945";
+		reg = <0x67>;
+	};
+
+	power-monitor@68 {
+		compatible = "adi,ltc2945";
+		reg = <0x68>;
+	};
 };
 
 &i2c1 {
-- 
2.34.1

