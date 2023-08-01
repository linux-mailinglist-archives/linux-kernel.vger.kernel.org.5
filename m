Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7852076B099
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjHAKNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjHAKMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:12:34 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA82136;
        Tue,  1 Aug 2023 03:11:13 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3719EZ4l108366;
        Tue, 1 Aug 2023 04:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690881275;
        bh=zk0e9gVTV7UkuWlLNu0FV2sP27WiRrRdrMIHFAtC+zc=;
        h=From:To:CC:Subject:Date;
        b=cZ64hBD4rq4tX4nbnxBo6R0euMuwhubA/HiXydrt57cwmlWeXpLe+NkT+yfeGu6ba
         6ZI8pZ4I57PmPsBjLsZmnNagFaB/uSwewrBoCMNeEkKk2Xy2Jfc5yT8+FsjgAZPCZZ
         g6Rfl1LPct9VCTuFB6mHKMZgXkeHY/PwqCKavN4I=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3719EZ0M028461
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 04:14:35 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 04:14:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 04:14:35 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3719EZ9Q045195;
        Tue, 1 Aug 2023 04:14:35 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3719EYdf015813;
        Tue, 1 Aug 2023 04:14:34 -0500
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
Subject: [PATCH v13 00/10] Introduce ICSSG based ethernet Driver
Date:   Tue, 1 Aug 2023 14:44:18 +0530
Message-ID: <20230801091428.1359979-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Programmable Real-time Unit and Industrial Communication Subsystem
Gigabit (PRU_ICSSG) is a low-latency microcontroller subsystem in the TI
SoCs. This subsystem is provided for the use cases like the implementation
of custom peripheral interfaces, offloading of tasks from the other
processor cores of the SoC, etc.

The subsystem includes many accelerators for data processing like
multiplier and multiplier-accumulator. It also has peripherals like
UART, MII/RGMII, MDIO, etc. Every ICSSG core includes two 32-bit
load/store RISC CPU cores called PRUs.

The above features allow it to be used for implementing custom firmware
based peripherals like ethernet.

This series adds the YAML documentation and the driver with basic EMAC
support for TI AM654 Silicon Rev 2 SoC with the PRU_ICSSG Sub-system.
running dual-EMAC firmware.
This currently supports basic EMAC with 1Gbps and 100Mbps link. 10M and
half-duplex modes are not yet supported because they require the support
of an IEP, which will be added later.
Advanced features like switch-dev and timestamping will be added later. 

This is the v13 of the patch series [v1]. This version of the patchset 
addresses comments made on v12.

There series doesn't have any dependency.

Changes from v12 to v13 :
*) Rebased the series on latest net-next.
*) Addressed Jakub's comments on ndo_xmit API. Now we will only stop queues
   based on occupancy not on dma errors.
*) Removed limiting the number of serviced packets to budget for Tx NAPI.
   Now Tx NAPI will keep servicing packets.
*) Removed netif_running() check when packet arrives.
*) Introduced prototypes of APIs in the same patch where these APIs are added.
   Dropped __maybe_unused tags as compiler only cares about prototypes
   existing, not whether actual callers are in place. Now prototypes of these
   APIs are present in the same patch where they are introduced but thes APIs
   are called later (in patch 6).

Changes from v11 to v12 :
*) Rebased the series on latest net-next.
*) Addressed Jakub's comments on ndo_xmit API.
*) Added hooks to .get_rmon_stats for the driver. Now tx / rx bucket size 
   and frame counts per bucket will be fetched by ethtool_rmon_stats instead
   of ethtool -S.
*) Added __maybe_unused tags to unused config and classifier APIs in patch
   2,3 and 4. These tags are later removed in patch 6. 

Changes from v10 to v11 :
*) Rebased the series on latest net-next.
*) Split the ICSSG driver introduction patch into 9 different patches as
   asked by Jakub.
*) Introduced new patch(patch 8/10) to dump Standard network interface
   staticstics via ndo_get_stats64. Now certain stats that are reported by
   ICSSG hardware and are also part of struct rtnl_link_stats64, will be 
   reported by ndo_get_stats64. While other stats that are not part of the
   struct rtnl_link_stats64 will be reported by ethtool -S. These stats 
   are not duplicated.

Changes from v9 to v10 :
*) Rebased the series on latest net-next.
*) Moved 'ndev prueth->emac[mac] == emac' assignment to the end of function
   prueth_netdev_init().
*) In unsupported phy_mode switch case instead of returning -EINVAL, store
   the error code in ret and 'goto free'

Changes from v8 to v9 :
*) Rebased the series on latest net-next.
*) Fixed smatch and sparse warnings as pointed by Simon.
*) Fixed leaky ndev in prueth_netdev_init() as asked by Simon.

Changes from v7 to v8 :
*) Rebased the series on 6.5-rc1.
*) Fixed few formattings. 

Changes from v6 to v7 :
*) Added RB tag of Rob in patch 1 of this series.
*) Addressed Simon's comment on patch 2 of the series.
*) Rebased patchset on next-20230428 linux-next.

Changes from v5 to v6 :
*) Added RB tag of Andrew Lunn in patch 2 of this series.
*) Addressed Rob's comment on patch 1 of the series.
*) Rebased patchset on next-20230421 linux-next.

Changes from v4 to v5 :
*) Re-arranged properties section in ti,icssg-prueth.yaml file.
*) Added requirement for minimum one ethernet port.
*) Fixed some minor formatting errors as asked by Krzysztof.
*) Dropped SGMII mode from enum mii_mode as SGMII mode is not currently
   supported by the driver.
*) Added switch-case block to handle different phy modes by ICSSG driver.

Changes from v3 to v4 :
*) Addressed Krzysztof's comments and fixed dt_binding_check errors in 
   patch 1/2.
*) Added interrupt-extended property in ethernet-ports properties section.
*) Fixed comments in file icssg_switch_map.h according to the Linux coding
   style in patch 2/2. Added Documentation of structures in patch 2/2.

Changes from v2 to v3 :
*) Addressed Rob and Krzysztof's comments on patch 1 of this series.
   Fixed indentation. Removed description and pinctrl section from 
   ti,icssg-prueth.yaml file.
*) Addressed Krzysztof, Paolo, Randy, Andrew and Christophe's comments on 
   patch 2 of this seires.
*) Fixed blanklines in Kconfig and Makefile. Changed structures to const 
   as suggested by Krzysztof.
*) Fixed while loop logic in emac_tx_complete_packets() API as suggested 
   by Paolo. Previously in the loop's last iteration 'budget' was 0 and 
   napi_consume_skb would wrongly assume the caller is not in NAPI context
   Now, budget won't be zero in last iteration of loop. 
*) Removed inline functions addr_to_da1() and addr_to_da0() as asked by 
   Andrew.
*) Added dev_err_probe() instead of dev_err() as suggested by Christophe.
*) In ti,icssg-prueth.yaml file, in the patternProperties section of 
   ethernet-ports, kept the port name as "port" instead of "ethernet-port" 
   as all other drivers were using "port". Will change it if is compulsory 
   to use "ethernet-port".

[v1] https://lore.kernel.org/all/20220506052433.28087-1-p-mohan@ti.com/
[v2] https://lore.kernel.org/all/20220531095108.21757-1-p-mohan@ti.com/
[v3] https://lore.kernel.org/all/20221223110930.1337536-1-danishanwar@ti.com/
[v4] https://lore.kernel.org/all/20230206060708.3574472-1-danishanwar@ti.com/
[v5] https://lore.kernel.org/all/20230210114957.2667963-1-danishanwar@ti.com/
[v6] https://lore.kernel.org/all/20230424053233.2338782-1-danishanwar@ti.com/
[v7] https://lore.kernel.org/all/20230502061650.2716736-1-danishanwar@ti.com/
[v8] https://lore.kernel.org/all/20230710053550.89160-1-danishanwar@ti.com/
[v9] https://lore.kernel.org/all/20230714094432.1834489-1-danishanwar@ti.com/
[v10] https://lore.kernel.org/all/20230719082755.3399424-1-danishanwar@ti.com/
[v11] https://lore.kernel.org/netdev/20230724112934.2637802-1-danishanwar@ti.com/
[v12] https://lore.kernel.org/all/20230727112827.3977534-1-danishanwar@ti.com/

Thanks and Regards,
Md Danish Anwar

MD Danish Anwar (9):
  net: ti: icssg-prueth: Add Firmware Interface for ICSSG Ethernet
    driver.
  net: ti: icssg-prueth: Add mii helper apis and macros
  net: ti: icssg-prueth: Add Firmware config and classification APIs.
  net: ti: icssg-prueth: Add icssg queues APIs and macros
  dt-bindings: net: Add ICSSG Ethernet
  net: ti: icssg-prueth: Add ICSSG Stats
  net: ti: icssg-prueth: Add Standard network staticstics
  net: ti: icssg-prueth: Add ethtool ops for ICSSG Ethernet driver
  net: ti: icssg-prueth: Add Power management support

Roger Quadros (1):
  net: ti: icssg-prueth: Add ICSSG ethernet driver

 .../bindings/net/ti,icssg-prueth.yaml         |  184 ++
 drivers/net/ethernet/ti/Kconfig               |   13 +
 drivers/net/ethernet/ti/Makefile              |   10 +
 .../net/ethernet/ti/icssg/icssg_classifier.c  |  367 ++++
 drivers/net/ethernet/ti/icssg/icssg_config.c  |  450 ++++
 drivers/net/ethernet/ti/icssg/icssg_config.h  |  200 ++
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  188 ++
 drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c |  120 ++
 drivers/net/ethernet/ti/icssg/icssg_mii_rt.h  |  151 ++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 1897 +++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  262 +++
 drivers/net/ethernet/ti/icssg/icssg_queues.c  |   50 +
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |   57 +
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |  158 ++
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |  234 ++
 15 files changed, 4341 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_classifier.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_config.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_config.h
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_ethtool.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_mii_rt.h
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_prueth.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_prueth.h
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_queues.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_stats.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_stats.h
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switch_map.h

-- 
2.34.1

