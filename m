Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CAB79CB77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjILJTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjILJTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:19:16 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86D1E10CA;
        Tue, 12 Sep 2023 02:19:10 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38C9IcME22457773, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38C9IcME22457773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 17:18:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 12 Sep 2023 17:18:37 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 12 Sep
 2023 17:18:37 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     <kuba@kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next v7 00/13] Add Realtek automotive PCIe driver
Date:   Tue, 12 Sep 2023 17:18:17 +0800
Message-ID: <20230912091830.338164-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.210.160]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes adding realtek automotive ethernet driver 
and adding rtase ethernet driver entry in MAINTAINERS file.

This ethernet device driver for the PCIe interface of 
Realtek Automotive Ethernet Switch,applicable to 
RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.

v1 -> v2:
- Remove redundent debug message.
- Modify coding rule.
- Remove other function codes not related to netdev.

v2 -> v3:
- Remove SR-IOV function - We will add the SR-IOV function together when
uploading the vf driver in the future.
- Remove other unnecessary code and macro.

v3 -> v4:
- Remove function prototype - Our driver does not use recursion, so we
have reordered the code and removed the function prototypes.
- Define macro precisely - Improve macro code readability to make the
source code cleaner.

v4 -> v5:
- Modify ethtool function - Remove some unnecessary code.
- Don't use inline function - Let the compiler decide.

v5 -> v6:
- Some old macro definitions have been removed and replaced with the
lastest usage.
- Replace s32 with int to ensure consistency.
- Clearly point out the objects of the service and remove unnecessary
struct.

v6 -> v7:
- Split this driver into multiple patches.
- Reorganize this driver code and remove redundant code to make this
driver more concise.

Justin Lai (13):
  net:ethernet:realtek:rtase: Add pci table supported in this module
  net:ethernet:realtek:rtase: Implement the .ndo_open function
  net:ethernet:realtek:rtase: Implement the rtase_down function
  net:ethernet:realtek:rtase: Implement the interrupt routine and
    rtase_poll
  net:ethernet:realtek:rtase: Implement hardware configuration function
  net:ethernet:realtek:rtase: Implement .ndo_start_xmit function
  net:ethernet:realtek:rtase: Implement a function to receive packets
  net:ethernet:realtek:rtase: Implement net_device_ops
  net:ethernet:realtek:rtase: Implement pci_driver suspend and resume
    function
  net:ethernet:realtek:rtase: Implement ethtool function
  net:ethernet:realtek:rtase: Add a Makefile in the rtase folder
  net:ethernet:realtek: Update the Makefile and Kconfig in the realtek
    folder
  MAINTAINERS: Add the rtase ethernet driver entry

 MAINTAINERS                                   |    7 +
 drivers/net/ethernet/realtek/Kconfig          |   17 +
 drivers/net/ethernet/realtek/Makefile         |    1 +
 drivers/net/ethernet/realtek/rtase/Makefile   |   10 +
 drivers/net/ethernet/realtek/rtase/rtase.h    |  364 +++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 2440 +++++++++++++++++
 6 files changed, 2839 insertions(+)
 create mode 100644 drivers/net/ethernet/realtek/rtase/Makefile
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase.h
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase_main.c

-- 
2.34.1

