Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A3F76638D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjG1FJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjG1FJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:09:13 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561883A8B;
        Thu, 27 Jul 2023 22:09:09 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36S590JH052026;
        Fri, 28 Jul 2023 00:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690520940;
        bh=7zbwQgB4jXg3JyiPhB4TOJriYPz9LlM6mC+Du5rkYY8=;
        h=From:To:CC:Subject:Date;
        b=GwaNYZwm+twjI1Qnj6hXmaTCzgZ4ndLksDUx2cINLZiSnatHsvpkhq9cOELgE/b2W
         VPE+wn+bHuDzoYIQLAIG/3tZkp7EitXBTRMnszSS8RAd4FGwVRj/VRImVPjqal9osf
         TrwYsC1tDDXMqYckOpNRlDyX2+N5aF55ceL1UVCc=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36S590AT124377
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jul 2023 00:09:00 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jul 2023 00:09:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jul 2023 00:09:00 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36S58xLb125962;
        Fri, 28 Jul 2023 00:08:59 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <s-vadapalli@ti.com>, <afd@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>, <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-choudhary@ti.com>
Subject: [PATCH v7 0/4] Add peripherals for J784S4
Date:   Fri, 28 Jul 2023 10:38:55 +0530
Message-ID: <20230728050859.7370-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for:
- SERDES, WIZ DT nodes, Serdes lane control mux
- DSS and DisplayPort-0 nodes

This support DEPENDS upon another series which was introduced as part
of discussion in v5. That series[1] moves the ti-serdes headers file
from bindings to "arch/arm64/boot/dts/ti". (That series is merged in
linux-next tree)

Changelog v6->v7:
- change compatible for scm_conf to 'simple-bus'
- drop main_cpsw node due to driver dependency on [2]

Changelog v5->v6:
- Change header file according to [1].
- Add idle-state property in serdes_ln_ctrl node.
- Fix dtbs_check warning due to clock-frequency property in serdes_refclk
  node by disabling the node in main.dtsi and enabling it in board file
  when the clock-frequency node is actually added.

Changelog v4->v5:
- rebased the patches on linux-next tip.

Changelog v3->v4:
- add reg property to serdes_ln_ctrl and fix the node name again to
  get rid of dtbs_check error.
- reorder reg, reg-names and ranges property for main_cpsw1.
- correct the order for clocks in serdes_wiz nodes to fix dtbs_check
  warnings.
- fix indentation in reg, reg-names and clock property for dss node.
- add comments for the reg type in dss registers.

Changelog v3->v2:
- fix dtc warnings for 'scm_conf' and 'serdes_ln_ctrl' nodes
  (Checked all the changes of the series with W=12 option during build)
- added clock-frequency for serdes_refclk along with other EVM changes
  This refclk is being used by all the instances of serdes_wiz which
  are disabled by default. So configuring refclk when the serdes nodes
  are used for the first time is okay.

Changelog v1->v2:
- Moved J784S4 EVM changes together to the last patch
  (Suggested by Andrew)

v5 patch link:
<https://lore.kernel.org/all/20230721132029.123881-1-j-choudhary@ti.com/>

[1]: <https://lore.kernel.org/all/20230721125732.122421-1-j-choudhary@ti.com/>
[2]: <https://lore.kernel.org/all/20230605154153.24025-1-afd@ti.com/>

Rahul T R (2):
  arm64: dts: ti: k3-j784s4-main: Add DSS and DP-bridge node
  arm64: dts: ti: k3-j784s4-evm: Enable DisplayPort-0

Siddharth Vadapalli (2):
  arm64: dts: ti: k3-j784s4-main: Add system controller and SERDES lane
    mux
  arm64: dts: ti: k3-j784s4: Add WIZ and SERDES PHY nodes

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 117 +++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 285 +++++++++++++++++++++
 2 files changed, 402 insertions(+)

-- 
2.25.1

