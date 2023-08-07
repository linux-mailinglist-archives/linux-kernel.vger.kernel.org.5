Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387B6771F18
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjHGLBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjHGLBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:01:18 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E4E1721;
        Mon,  7 Aug 2023 04:01:16 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377B0sv8054566;
        Mon, 7 Aug 2023 06:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691406054;
        bh=ZPjBvlXzHvxA+tZyjo1EWAU6idpL4b02GPU7dEiciNc=;
        h=From:To:CC:Subject:Date;
        b=JJfi7OJe4hTq6PPVdSKngRhg6A5ETI2B85fyTTkbpt325FLpe0oSWhri0dalRgyHa
         y9A2NMUnKxIDm9fImSJF2ek8hpnxvIsW4TrZt4+xJENJitEoXpPyVwrjkZuVbjGfVo
         MnA0m0aNQ555zY9DnMIa1PNDutcDKk7Qq7VxeINg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377B0sZc074768
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 06:00:54 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 06:00:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 06:00:54 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377B0shg031533;
        Mon, 7 Aug 2023 06:00:54 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 377B0rUG028356;
        Mon, 7 Aug 2023 06:00:54 -0500
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
Subject: [PATCH v2 0/5] Introduce IEP driver and packet timestamping support
Date:   Mon, 7 Aug 2023 16:30:43 +0530
Message-ID: <20230807110048.2611456-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

This is v2 of the series [v1]. It addresses comments made on [v1].
This series is based on linux-next(#next-20230807). 

Changes from v1 to v2:
*) Addressed Simon's comment to fix reverse xmas tree declaration. Some APIs
   in patch 3 and 4 were not following reverse xmas tree variable declaration.
   Fixed it in this version.
*) Addressed Conor's comments and removed unsupported SoCs from compatible
   comment in patch 1. 
*) Addded patch 2 which was not part of v1. Patch 2, adds IEP node to dt
   bindings for ICSSG.

[v1] https://lore.kernel.org/all/20230803110153.3309577-1-danishanwar@ti.com/

Thanks and Regards,
Md Danish Anwar

Grygorii Strashko (1):
  net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support

MD Danish Anwar (1):
  dt-bindings: net: Add iep node in ICSSG driver dt binding

Md Danish Anwar (1):
  dt-bindings: net: Add ICSS IEP

Roger Quadros (2):
  net: ti: icss-iep: Add IEP driver
  net: ti: icssg-prueth: add packet timestamping and ptp support

 .../devicetree/bindings/net/ti,icss-iep.yaml  |  37 +
 .../bindings/net/ti,icssg-prueth.yaml         |   7 +
 drivers/net/ethernet/ti/Kconfig               |  12 +
 drivers/net/ethernet/ti/Makefile              |   1 +
 drivers/net/ethernet/ti/icssg/icss_iep.c      | 961 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icss_iep.h      |  41 +
 drivers/net/ethernet/ti/icssg/icssg_config.c  |   6 +
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  21 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 433 +++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  28 +-
 10 files changed, 1540 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml
 create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.h

-- 
2.34.1

