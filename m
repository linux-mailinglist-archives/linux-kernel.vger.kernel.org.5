Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF997766D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjHISAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjHISAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:00:03 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822E61BD9;
        Wed,  9 Aug 2023 11:00:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379HxqdB119432;
        Wed, 9 Aug 2023 12:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691603992;
        bh=y2SYO516zlr0jAWcRq1XhL154UChJeRiSKyVEmnHyK4=;
        h=From:To:CC:Subject:Date;
        b=UtRxHxJ66KILdW8eBAM3lZhxABASRklxfvFvsaXSRVSeezjXo+FOSwiBHQ+7u5EEv
         Eb6quW6Fa63IcUE0a6sMVL8aO5yNaTTFY7nltkt0TkqPtQGZpJmxlvyUY5jZAdLqUC
         0RX/W+JXSF46Ot2x/BDoYEz1xndPeXeFSElpecWg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379Hxqhe010082
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 12:59:52 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 12:59:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 12:59:52 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Hxm6G098813;
        Wed, 9 Aug 2023 12:59:49 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] soc: ti: k3-ringacc: Add additional register regions
Date:   Wed, 9 Aug 2023 23:29:30 +0530
Message-ID: <20230809175932.2553156-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ringacc on TI K3 SoCs have configuration registers region which is
usually hidden from Linux and configured via Device Manager Firmware
APIs. But certain early SWs like bootloader which run before Device
Manager is fully up would need to directly configure these registers and
thus require to be in DT description.

This add bindings for the cfg region and also adds them to DT files.
Backward compatibility is maintained to existing DT by only mandating
existing regions to be present and this new region as optional.

Nishanth: I am hoping its possible for you to take bindings and DT
via k3-dts-next once reviewed.

Vignesh Raghavendra (2):
  dt-bindings: soc: ti: k3-ringacc: Describe cfg reg region
  arm64: dts: ti: k3: Add cfg reg region to ringacc node

 Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml | 9 +++++++--
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi                 | 5 +++--
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                  | 6 ++++--
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi                | 5 +++--
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi          | 6 ++++--
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi                | 5 +++--
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi          | 5 +++--
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi               | 5 +++--
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi         | 5 +++--
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi               | 5 +++--
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi         | 5 +++--
 11 files changed, 39 insertions(+), 22 deletions(-)

-- 
2.41.0

