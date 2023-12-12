Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31B380E53B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346047AbjLLHye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346009AbjLLHyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:54:20 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE28F2;
        Mon, 11 Dec 2023 23:54:21 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-286b45c5a8dso5576697a91.1;
        Mon, 11 Dec 2023 23:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702367661; x=1702972461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ub1Mj5QhW4GYsiqkx+k8Ak5A4JATw8yMZFp7nxSVbQ=;
        b=iQuL0XEOdydTpikhEh/l0J2TzMKMJpjShAkXrinYqfXMYaGutiFGxUXKKcsx4sCu6n
         fbEZpRlUEslvG6m7a1vwNht02YG35RtvydWsV/J5TQ+G+BN0To2RSWFly8SfXcqSplxB
         nY78zz5ifkbwdNQkp1yuncq6E/4mGc7NQGUOJPd6ZtlPrVwT1dk+qSPJ3JDBx7z0mY83
         k2F8c85cUKWkJczBv1oPCFNPHTrHiDssJmX9YOGWrbRb4OdbvQtnTHAJcaOCE4iUClXe
         iXv69txIScnURvuEB3+mrPndOQqfgGFhq7Td5g/uqbMUDJFoSFRj4tt76T+0AGLMt4o9
         OQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702367661; x=1702972461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ub1Mj5QhW4GYsiqkx+k8Ak5A4JATw8yMZFp7nxSVbQ=;
        b=COzRZ/hsCutHB6SkA65EnY3O0aqlHyId6DZ/e0IHrb/0Yct3aMsRoun8HjKc4YX7PE
         avE5NsCjldQwtBtAjxZXtI0D8ZPLfVMV5ynJErHZTI9ZjpOw//Ur2j9dR8vpVLeZ8DPK
         Mym3HqQX7Sfuygcnza6Yp18wdH7vylThymyf6a80b8hlg55BHNnUlWjvWkbWhxpYgknZ
         sIzAPSG1iSjPu/u6HTJ+NoIz6nHQ5MfjEXXCQtGNe2nmkbknVeC+1cIr/LlKgGXXX61J
         2kxwYgkf2bybxVpybk2BNUWeaA0gLPRs8K+Py+G0xpzSvlewEW3SaSiF0crvqHxu+BNO
         jSig==
X-Gm-Message-State: AOJu0YxZPFz8qrdNeYugipi5mYVRfWH4ovwpWUsw6W+u80fjBN6qzeyY
        j/vgtHRYnHhtJW8uW8s6uo0=
X-Google-Smtp-Source: AGHT+IFc2GRXDPOs0KJgpeLIDeiYAzGM8hIgYjADbg0H7JznPz1hDW7A0FKXOTQVVBxbRjK3yXC14Q==
X-Received: by 2002:a17:90a:e2cc:b0:28a:c6c7:1eb with SMTP id fr12-20020a17090ae2cc00b0028ac6c701ebmr148300pjb.86.1702367661194;
        Mon, 11 Dec 2023 23:54:21 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id qi9-20020a17090b274900b0028a28ad810csm8144319pjb.56.2023.12.11.23.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:54:20 -0800 (PST)
From:   Yang Chen <yangchen.openbmc@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        patrick@stwcx.xyz, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jerry.Lin@quantatw.com, EasonChen1@quantatw.com,
        Leslie.Tong@quantatw.com, yangchen.openbmc@gmail.com
Subject: [PATCH 06/11] ARM: dts: aspeed: minerva: correct the address of eeprom
Date:   Tue, 12 Dec 2023 15:51:55 +0800
Message-Id: <20231212075200.983536-7-yangchen.openbmc@gmail.com>
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

Correct the address from 0x51 to 0x54 of eeprom on the i2c bus 1

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 783d4d5a8f3d..f2a48033ac5c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -123,9 +123,9 @@ temperature-sensor@48 {
 		reg = <0x48>;
 	};
 
-	eeprom@51 {
+	eeprom@54 {
 		compatible = "atmel,24c128";
-		reg = <0x51>;
+		reg = <0x54>;
 	};
 };
 
-- 
2.34.1

