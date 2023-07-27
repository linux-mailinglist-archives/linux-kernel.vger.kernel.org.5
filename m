Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1015764D55
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjG0Ibs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbjG0I3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:29:42 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259DB59D6;
        Thu, 27 Jul 2023 01:16:35 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 46C1B868A1;
        Thu, 27 Jul 2023 10:07:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1690445242;
        bh=g4SvEKASYSP69eS/NXGdOyYLEmR+OJsjiSkjk31hOR4=;
        h=From:To:Cc:Subject:Date:From;
        b=Lf0f28PTfYd3fuQSolG1PQabMofo5ilpxJtcHUvLLTS32qb84pClsglqCMrJNI/pL
         AE+3oVtxdifGCKpVgt77rL/ZXHc9nOWK2kCUPnDMlZO6D2LzMSXE5ZbU9JY2scmPs9
         hb3DYnsY3NhDDPryAPHsb4dEcMxBWWYlvpZSrQXj0GbgmQt5bUw4tpkPDxuGU8Fp1w
         D1cbr3gGkPIkgPgf06+BlUxdNlvMIhKP9SMeaRWL8FFUGto6+Z/ReweF55DKsilUK7
         PDOiLZUjZsPB68XOtG5SFRXzAUvQbA2+ZHxTBDGZQOtKb5EIiUxRbMgX8JZOPHUfOA
         Y7jOkpU/RY3HQ==
From:   Lukasz Majewski <lukma@denx.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] ARM: dts: at91: ksz9477_evb: Add tx-internal-delay-ps property for port5
Date:   Thu, 27 Jul 2023 10:06:56 +0200
Message-Id: <20230727080656.3828397-1-lukma@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this change the KSZ9477 Evaluation board's Linux (v6.5-rc1) shows
following device warning:

'ksz-switch spi1.0: Port 5 interpreting RGMII delay settings based on "phy-mode" property, please update device tree to specify "rx-internal-delay-ps" and "tx-internal-delay-ps"'

This is not critical, as KSZ driver by itself assigns default value of
tx delay to 2000 ps (as 'rgmii-txid' is set as PHY mode).

However, to avoid extra warnings in logs - the missing 'tx-internal-delay-ps'
has been specified with the default value of 2000 ps.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts b/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts
index 99cd6d15998b..b66570080894 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts
@@ -152,6 +152,7 @@
 				label = "cpu";
 				ethernet = <&macb0>;
 				phy-mode = "rgmii-txid";
+				tx-internal-delay-ps = <2000>;
 
 				fixed-link {
 					speed = <1000>;
-- 
2.20.1

