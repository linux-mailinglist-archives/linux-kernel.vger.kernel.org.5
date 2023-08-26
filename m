Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC9C7898AC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 20:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjHZS1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 14:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHZS1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 14:27:12 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055411711
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
        Content-Description:In-Reply-To:References:X-Debbugs-Cc;
        bh=NSzUijcZ/MgUsFtsx1EEVy2F3mZEyyGzlmPtWD+DEE8=; b=Bs9E3dPWJM6urKAmwdT9uCRujQ
        9/PKZTFXAeq9yfoPJdpp1q2c7lV4uvcyYMveTkQce6t0ZGn/2CMFy2ULKB/aTZhBRpVh17EkLJ1kR
        ukcP7UbbnpPO6FOQZI3JKgnviEBaynhenqfg4+kDfAaPIXC7Bh5BworGgrZ/EaKwYsNGbsoT06/23
        LlqyNEV4Sz68ypi1qaPVa7GXYZc6K8Im8NNRsJdwV5mA05ae/izD5Gf9Fc4VdSNrJX13D7U4x/tYp
        ZCqIYO7b7P+eL5oCEuHPhv6l3mIIALee9/OLMFAe9oi1XYJ1Gs8JdhyH3dqiZebMCpVwTXelTYWJ3
        MBWesq0w==;
Received: from [2a01:e34:ec5d:a741:9a7b:5831:531:65c9] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1qZy01-00AqTj-1Y; Sat, 26 Aug 2023 20:27:05 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1qZy00-00B5Ey-0m;
        Sat, 26 Aug 2023 20:27:04 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH] riscv: dts: starfive: fix NOR flash reserved-data partition size
Date:   Sat, 26 Aug 2023 20:27:02 +0200
Message-Id: <20230826182702.2641743-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Starfive VisionFive 2 has a 16MiB NOR flash, while the reserved-data
partition is declared starting at address 0x600000 with a size of
0x1000000. This causes the kernel to output the following warning:

[   22.156589] mtd: partition "reserved-data" extends beyond the end of device "13010000.spi.0" -- size truncated to 0xa00000

It seems to be a confusion between the size of the partition and the end
address. Fix that by specifying the right size.

Fixes: 8384087a4223 ("riscv: dts: starfive: Add QSPI controller node for StarFive JH7110 SoC")
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 498eb179d90f..30c85ba6da02 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -262,7 +262,7 @@ uboot@100000 {
 				reg = <0x100000 0x400000>;
 			};
 			reserved-data@600000 {
-				reg = <0x600000 0x1000000>;
+				reg = <0x600000 0xa00000>;
 			};
 		};
 	};
-- 
2.39.2

