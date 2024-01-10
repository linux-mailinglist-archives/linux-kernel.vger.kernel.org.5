Return-Path: <linux-kernel+bounces-17796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A568252E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39213287A16
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4072C691;
	Fri,  5 Jan 2024 11:28:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F20028E1A;
	Fri,  5 Jan 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 405BSI2l82336498, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 405BSI2l82336498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 19:28:18 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 5 Jan 2024 19:28:19 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 5 Jan 2024
 19:28:18 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next v16 00/13] Add Realtek automotive PCIe driver
Date: Fri, 5 Jan 2024 19:27:58 +0800
Message-ID: <20240105112811.380952-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

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

v13 -> v14:
- Remove unuse include.
- call eth_hw_addr_random() to generate random MAC and set device flag 
- use pci_enable_msix_exact() instead of pci_enable_msix_range() 
- If dev->dma_mask is non-NULL, dma_set_mask_and_coherent with a 64-bit
mask will never fail, so remove the part that determines the 32-bit mask.
- set dev->pcpu_stat_type before register_netdev() and core will allocate
stats 
- call NAPI instance at the right location

v14 -> v15:
- In rtase_open, when the request interrupt fails, all request interrupts
are freed.
- When calling netif_device_detach, there is no need to call
netif_stop_queue.
- Call netif_tx_disable() instead of stop_queue(), it takes the tx lock so
there is no need to worry about the packets being transmitted.
- In rtase_tx_handler, napi budget is no longer used, but a customized
tx budget is used.
- Use the start / stop macros from include/net/netdev_queues.h. 
- Remove redundent code.

v15 -> v16:
- Re-upload v15 patch set

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
 drivers/net/ethernet/realtek/rtase/rtase.h    |  336 +++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 2314 +++++++++++++++++
 6 files changed, 2685 insertions(+)
 create mode 100644 drivers/net/ethernet/realtek/rtase/Makefile
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase.h
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase_main.c

-- 
2.34.1


