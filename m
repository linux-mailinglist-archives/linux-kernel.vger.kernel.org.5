Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21166775E29
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjHILt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjHILt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:49:29 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7E210D;
        Wed,  9 Aug 2023 04:49:28 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379BnDdT034968;
        Wed, 9 Aug 2023 06:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691581753;
        bh=KDp7H40e6XDbVRlxnqJ5QHmRmDqHv6zD3uTT8GKlR/s=;
        h=From:To:CC:Subject:Date;
        b=aW0Z6K0P/uoQBqvYjuraG7sxMBIj/yVZM4cxJ2g4ocodJK25quHHveR5OmhWqD3wI
         JGNPEXaFwvj7T43kBt5oIJ12e6qcP5dHg67aat/cLJZhw9aPKip+s1P0idWSqAQTF7
         iGBSv5/VN4rF/V3DAg/BLNQTeo9mUWnJWpQNuI+Y=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379BnD6I129508
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 06:49:13 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 06:49:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 06:49:12 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379BnCuO013039;
        Wed, 9 Aug 2023 06:49:12 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 379BnBnD005116;
        Wed, 9 Aug 2023 06:49:12 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/5] Introduce IEP driver and packet timestamping support
Date:   Wed, 9 Aug 2023 17:19:01 +0530
Message-ID: <20230809114906.21866-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces Industrial Ethernet Peripheral (IEP) driver to
support timestamping of ethernet packets and thus support PTP and PPS
for PRU ICSSG ethernet ports.

This series also adds 10M full duplex support for ICSSG ethernet driver.

There are two IEP instances. IEP0 is used for packet timestamping while IEP1
is used for 10M full duplex support.

This is v3 of the series [v1]. It addresses comments made on [v2].
This series is based on linux-next(#next-20230807).

Changes from v2 to v3:
*) Addressed Roger's comment and moved IEP1 related changes in patch 5.
*) Addressed Roger's comment and moved icss_iep.c / .h changes from patch 4
   to patch 3.
*) Added support for multiple timestamping in patch 4 as asked by Roger.
*) Addressed Andrew's comment and added comment in case SPEED_10 in
   icssg_config_ipg() API.
*) Kept compatible as "ti,am654-icss-iep" for all TI K3 SoCs

Changes from v1 to v2:
*) Addressed Simon's comment to fix reverse xmas tree declaration. Some APIs
   in patch 3 and 4 were not following reverse xmas tree variable declaration.
   Fixed it in this version.
*) Addressed Conor's comments and removed unsupported SoCs from compatible
   comment in patch 1. 
*) Addded patch 2 which was not part of v1. Patch 2, adds IEP node to dt
   bindings for ICSSG.

[v1] https://lore.kernel.org/all/20230803110153.3309577-1-danishanwar@ti.com/
[v2] https://lore.kernel.org/all/20230807110048.2611456-1-danishanwar@ti.com/

Thanks and Regards,
Md Danish Anwar

Grygorii Strashko (1):
  net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support

MD Danish Anwar (2):
  dt-bindings: net: Add ICSS IEP
  dt-bindings: net: Add IEP property in ICSSG DT binding

Roger Quadros (2):
  net: ti: icss-iep: Add IEP driver
  net: ti: icssg-prueth: add packet timestamping and ptp support

 .../devicetree/bindings/net/ti,icss-iep.yaml  |  37 +
 .../bindings/net/ti,icssg-prueth.yaml         |   7 +
 drivers/net/ethernet/ti/Kconfig               |  12 +
 drivers/net/ethernet/ti/Makefile              |   1 +
 drivers/net/ethernet/ti/icssg/icss_iep.c      | 961 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icss_iep.h      |  41 +
 drivers/net/ethernet/ti/icssg/icssg_config.c  |   7 +
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  21 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 451 +++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  28 +-
 10 files changed, 1558 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml
 create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.h

-- 
2.34.1

