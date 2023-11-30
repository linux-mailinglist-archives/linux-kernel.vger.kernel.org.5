Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED607FEE23
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjK3LoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjK3Ln7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:43:59 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A287810E2;
        Thu, 30 Nov 2023 03:44:04 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AUBhaTnB3495101, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AUBhaTnB3495101
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Nov 2023 19:43:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 30 Nov 2023 19:43:36 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 30 Nov
 2023 19:43:35 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     <kuba@kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next v13 00/13] Add Realtek automotive PCIe driver
Date:   Thu, 30 Nov 2023 19:43:14 +0800
Message-ID: <20231130114327.1530225-1-justinlai0215@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

v7 -> v8:
- Add the function to calculate time mitigation and the function to 
calculate packet number mitigation. Users can use these two functions 
to calculate the reg value that needs to be set for the mitigation value
they want to set.
- This device is usually used in automotive embedded systems. The page
pool api will use more memory in receiving packets and requires more 
verification, so we currently do not plan to use it in this patch.

v8 -> v9:
- Declare functions that are not extern as static functions and increase
the size of the character array named name in the rtase_int_vector struct
to correct the build warning noticed by the kernel test robot.

v9 -> v10:
- Currently we change to use the page pool api. However, when we allocate
more than one page to an rx buffer, it will cause system errors
in some cases. Therefore, we set the rx buffer to fixed size with 3776
(PAGE_SIZE - SKB_DATA_ALIGN(sizeof(skb_shared_info) )), and the maximum 
value of mtu is set to 3754(rx buffer size - VLAN_ETH_HLEN - ETH_FCS_LEN).
- When ndo_tx_timeout is called, it will dump some device information,
which can be used for debugging.
- When the mtu is greater than 1500, the device supports checksums
but not TSO.
- Fix compiler warnning.

v10 -> v11:
- Added error handling of rtase_init_ring().
- Modify the error related to asymmetric pause in rtase_get_settings.
- Fix compiler error.

v11 -> v12:
- Use pm_sleep_ptr and related macros.
- Remove multicast filter limit.
- Remove VLAN support and CBS offload functions. 
- Remove redundent code.
- Fix compiler warnning.

v12 -> v13:
- Fixed the compiler warning of unuse rtase_suspend() and rtase_resume()
when there is no define CONFIG_PM_SLEEP.

Justin Lai (13):
  rtase: Add pci table supported in this module
  rtase: Implement the .ndo_open function
  rtase: Implement the rtase_down function
  rtase: Implement the interrupt routine and rtase_poll
  rtase: Implement hardware configuration function
  rtase: Implement .ndo_start_xmit function
  rtase: Implement a function to receive packets
  rtase: Implement net_device_ops
  rtase: Implement pci_driver suspend and resume function
  rtase: Implement ethtool function
  rtase: Add a Makefile in the rtase folder
  realtek: Update the Makefile and Kconfig in the realtek folder
  MAINTAINERS: Add the rtase ethernet driver entry

 MAINTAINERS                                   |    7 +
 drivers/net/ethernet/realtek/Kconfig          |   17 +
 drivers/net/ethernet/realtek/Makefile         |    1 +
 drivers/net/ethernet/realtek/rtase/Makefile   |   10 +
 drivers/net/ethernet/realtek/rtase/rtase.h    |  335 +++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 2366 +++++++++++++++++
 6 files changed, 2736 insertions(+)
 create mode 100644 drivers/net/ethernet/realtek/rtase/Makefile
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase.h
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase_main.c

-- 
2.34.1

