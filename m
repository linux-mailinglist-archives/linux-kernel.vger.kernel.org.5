Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155BA76CFE3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjHBOSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjHBOSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:18:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDC782711;
        Wed,  2 Aug 2023 07:18:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F193113E;
        Wed,  2 Aug 2023 07:19:20 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E6C73F5A1;
        Wed,  2 Aug 2023 07:18:35 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>,
        Shengyu Qu <wiagn233@outlook.com>,
        Martin Botka <martin.botka@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] dt-bindings: mfd: x-powers,axp152: make interrupt optional for more chips
Date:   Wed,  2 Aug 2023 15:18:29 +0100
Message-Id: <20230802141829.522595-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All X-Powers PMICs described by this binding have an IRQ pin, and so
far (almost) all boards connected this to some NMI pin or GPIO on the SoC
they are connected to.
However we start to see boards that omit this connection, and technically
the IRQ pin is not essential to the basic PMIC operation.
The existing Linux driver allows skipping an IRQ pin setup for some
chips already, so update the binding to also make the DT property
optional for these chips, so that we can actually have DTs describing
boards with the PMIC interrupt not wired up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

arguably the IRQ functionality is optional for many more PMICs,
especially if a board doesn't use GPIOs or a power key.
So I wonder if the interrupts property should become optional for all?
After all it's more a board designer's decision to wire up the IRQ pin
or not, and nothing that's really related to a particular PMIC.

Cheers,
Andre

 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index 9ad55746133b5..06f1779835a1e 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -67,7 +67,10 @@ allOf:
         properties:
           compatible:
             contains:
-              const: x-powers,axp305
+              enum:
+                - x-powers,axp15060
+                - x-powers,axp305
+                - x-powers,axp313a
 
     then:
       required:
-- 
2.25.1

