Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5620D765631
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjG0Opo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbjG0Opj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:45:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D634F2;
        Thu, 27 Jul 2023 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690469136; x=1722005136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AKUBmlFpIsP8FOTuhCgHejCXQyGo5SgEdM8TgCFAfgs=;
  b=KBGpY2BYKXyOq1vdylfFmyGEsLG+0SEGAYUJYWM9Ron3rYRwKxapdkrS
   ejwdSLRQIf5FKXSU3ZJjZUnivCitqmRLotD1XY5deN3qiT/+4w0YVxvK+
   CSSiItKN782HyQ2dnoVkLJFF6LzDbZhVFpzOv1lxEfPrvUE+U41z4Pger
   nZYUsxJVM5whTPxjz76boMFkyxjrDHKeJMH0oRqSIIZkcnUrv5k18Zz+3
   hPvpy1/awQhBAZVBctu7jvnZgkOSn2UneRxtwET4LFp+taXNZtdkzd2Fv
   U+8mTaJJhJiPZb+cM0tpAmdyA89Q90y+TYXZjHfLiovBjy6+jPweKpZrH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432139673"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="432139673"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 07:45:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817119873"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="817119873"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 07:45:32 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/9] page_pool: split types and declarations from page_pool.h
Date:   Thu, 27 Jul 2023 16:43:28 +0200
Message-ID: <20230727144336.1646454-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Split types and pure function declarations from page_pool.h
and add them in page_page/types.h, so that C sources can
include page_pool.h and headers should generally only include
page_pool/types.h as suggested by jakub.
Rename page_pool.h to page_pool/helpers.h to have both in
one place.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 MAINTAINERS                                   |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   2 +-
 drivers/net/ethernet/engleder/tsnep_main.c    |   1 +
 drivers/net/ethernet/freescale/fec_main.c     |   1 +
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   1 +
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |   2 +-
 drivers/net/ethernet/marvell/mvneta.c         |   2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |   2 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |   1 +
 .../marvell/octeontx2/nic/otx2_common.c       |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   1 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |   1 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   |   2 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |   1 +
 .../net/ethernet/mellanox/mlx5/core/en/trap.c |   1 -
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   2 +-
 .../ethernet/mellanox/mlx5/core/en_stats.c    |   2 +-
 .../ethernet/microchip/lan966x/lan966x_fdma.c |   1 +
 .../ethernet/microchip/lan966x/lan966x_main.h |   2 +-
 drivers/net/ethernet/socionext/netsec.c       |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   1 +
 drivers/net/ethernet/ti/cpsw.c                |   2 +-
 drivers/net/ethernet/ti/cpsw_new.c            |   2 +-
 drivers/net/ethernet/ti/cpsw_priv.c           |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   2 +-
 drivers/net/veth.c                            |   2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |   1 -
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 drivers/net/xen-netfront.c                    |   2 +-
 include/linux/skbuff.h                        |   2 +-
 include/net/page_pool/helpers.h               | 193 +++++++++++++++++
 .../net/{page_pool.h => page_pool/types.h}    | 197 +-----------------
 include/trace/events/page_pool.h              |   2 +-
 net/bpf/test_run.c                            |   2 +-
 net/core/page_pool.c                          |   2 +-
 net/core/skbuff.c                             |   2 +-
 net/core/xdp.c                                |   2 +-
 41 files changed, 235 insertions(+), 220 deletions(-)
 create mode 100644 include/net/page_pool/helpers.h
 rename include/net/{page_pool.h => page_pool/types.h} (51%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d0553ad37865..30037d39b82d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16015,8 +16015,7 @@ M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/networking/page_pool.rst
-F:	include/net/page_pool.h
-F:	include/trace/events/page_pool.h
+F:	include/net/page_pool/*.h
 F:	net/core/page_pool.c
 
 PAGE TABLE CHECK
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a3bbd13c070f..2e8a1b79bf3f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -54,7 +54,7 @@
 #include <net/pkt_cls.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
-#include <net/page_pool.h>
+#include <net/page_pool/helpers.h>
 #include <linux/align.h>
 #include <net/netdev_queues.h>
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 5b6fbdc4dc40..0fc2c7514aa6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -15,7 +15,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/filter.h>
-#include <net/page_pool.h>
+#include <net/page_pool/helpers.h>
 #include "bnxt_hsi.h"
 #include "bnxt.h"
 #include "bnxt_xdp.h"
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 079f9f6ae21a..f61bd89734c5 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -28,6 +28,7 @@
 #include <linux/iopoll.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
+#include <net/page_pool/helpers.h>
 #include <net/xdp_sock_drv.h>
 
 #define TSNEP_RX_OFFSET (max(NET_SKB_PAD, XDP_PACKET_HEADROOM) + NET_IP_ALIGN)
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 03ac7690b5c4..27420f3447fc 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -38,6 +38,7 @@
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <net/ip.h>
+#include <net/page_pool/helpers.h>
 #include <net/selftests.h>
 #include <net/tso.h>
 #include <linux/tcp.h>
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 9f6890059666..e5e37a33fd81 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -18,6 +18,7 @@
 #include <net/gre.h>
 #include <net/gro.h>
 #include <net/ip6_checksum.h>
+#include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
 #include <net/tcp.h>
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 88af34bbee34..acd756b0c7c9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -6,7 +6,7 @@
 
 #include <linux/dim.h>
 #include <linux/if_vlan.h>
-#include <net/page_pool.h>
+#include <net/page_pool/types.h>
 #include <asm/barrier.h>
 
 #include "hnae3.h"
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index acf4f6ba73a6..d483b8c00ec0 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -37,7 +37,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/tso.h>
-#include <net/page_pool.h>
+#include <net/page_pool/helpers.h>
 #include <net/pkt_sched.h>
 #include <linux/bpf_trace.h>
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 11e603686a27..e809f91c08fb 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -16,7 +16,7 @@
 #include <linux/phy.h>
 #include <linux/phylink.h>
 #include <net/flow_offload.h>
-#include <net/page_pool.h>
+#include <net/page_pool/types.h>
 #include <linux/bpf.h>
 #include <net/xdp.h>
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 1fec84b4c068..68fef2027221 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -36,6 +36,7 @@
 #include <uapi/linux/ppp_defs.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <net/page_pool/helpers.h>
 #include <net/tso.h>
 #include <linux/bpf_trace.h>
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 8cdd92dd9762..8336cea16aff 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -7,6 +7,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/pci.h>
+#include <net/page_pool/helpers.h>
 #include <net/tso.h>
 #include <linux/bitfield.h>
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 9551b422622a..bfcc13ad9514 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -16,6 +16,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/bitfield.h>
+#include <net/page_pool/types.h>
 
 #include "otx2_reg.h"
 #include "otx2_common.h"
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 7490d48000c2..b72e127d7d3a 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -25,6 +25,7 @@
 #include <linux/bitfield.h>
 #include <net/dsa.h>
 #include <net/dst_metadata.h>
+#include <net/page_pool/helpers.h>
 
 #include "mtk_eth_soc.h"
 #include "mtk_wed.h"
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 28adda0c90c0..5ebe151f0763 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -18,7 +18,7 @@
 #include <linux/rhashtable.h>
 #include <linux/dim.h>
 #include <linux/bitfield.h>
-#include <net/page_pool.h>
+#include <net/page_pool/types.h>
 #include <linux/bpf_trace.h>
 #include "mtk_ppe.h"
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 5ce28ff7685f..e097f336e1c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -6,6 +6,7 @@
 #include "en/port.h"
 #include "en_accel/en_accel.h"
 #include "en_accel/ipsec.h"
+#include <net/page_pool/types.h>
 #include <net/xdp_sock_drv.h>
 
 static u8 mlx5e_mpwrq_min_page_shift(struct mlx5_core_dev *mdev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
index 201ac7dd338f..698647cc8c0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2020 Mellanox Technologies */
 
-#include <net/page_pool.h>
 #include "en/txrx.h"
 #include "en/params.h"
 #include "en/trap.h"
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 40589cebb773..12f56d0db0af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -35,6 +35,7 @@
 #include "en/xdp.h"
 #include "en/params.h"
 #include <linux/bitfield.h>
+#include <net/page_pool/helpers.h>
 
 int mlx5e_xdp_max_mtu(struct mlx5e_params *params, struct mlx5e_xsk_param *xsk)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index defb1efccb78..d9b17ab75fa4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -38,7 +38,7 @@
 #include <linux/debugfs.h>
 #include <linux/if_bridge.h>
 #include <linux/filter.h>
-#include <net/page_pool.h>
+#include <net/page_pool/types.h>
 #include <net/pkt_sched.h>
 #include <net/xdp_sock_drv.h>
 #include "eswitch.h"
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 41d37159e027..d01b7f501d9a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -36,7 +36,7 @@
 #include <linux/bitmap.h>
 #include <linux/filter.h>
 #include <net/ip6_checksum.h>
-#include <net/page_pool.h>
+#include <net/page_pool/helpers.h>
 #include <net/inet_ecn.h>
 #include <net/gro.h>
 #include <net/udp.h>
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 4d77055abd4b..07b84d668fcc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -38,7 +38,7 @@
 #include "en/port.h"
 
 #ifdef CONFIG_PAGE_POOL_STATS
-#include <net/page_pool.h>
+#include <net/page_pool/helpers.h>
 #endif
 
 static unsigned int stats_grps_num(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index bd72fbc2220f..3960534ac2ad 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -2,6 +2,7 @@
 
 #include <linux/bpf.h>
 #include <linux/filter.h>
+#include <net/page_pool/helpers.h>
 
 #include "lan966x_main.h"
 
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 27f272831ea5..b0be99fa8174 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -10,7 +10,7 @@
 #include <linux/phy.h>
 #include <linux/phylink.h>
 #include <linux/ptp_clock_kernel.h>
-#include <net/page_pool.h>
+#include <net/page_pool/types.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
 #include <net/switchdev.h>
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index 2d7347b71c41..0cde22a01e03 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -15,7 +15,7 @@
 #include <linux/bpf_trace.h>
 
 #include <net/tcp.h>
-#include <net/page_pool.h>
+#include <net/page_pool/helpers.h>
 #include <net/ip6_checksum.h>
 
 #define NETSEC_REG_SOFT_RST			0x104
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 4ce5eaaae513..a57f5f362ff5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -21,7 +21,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/net_tstamp.h>
 #include <linux/reset.h>
-#include <net/page_pool.h>
+#include <net/page_pool/types.h>
 #include <uapi/linux/bpf.h>
 
 struct stmmac_resources {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 19e46e8f626a..be676ffefeca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -39,6 +39,7 @@
 #include <linux/phylink.h>
 #include <linux/udp.h>
 #include <linux/bpf_trace.h>
+#include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
 #include <net/xdp_sock_drv.h>
 #include "stmmac_ptp.h"
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index f9cd566d1c9b..ca4d4548f85e 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -31,7 +31,7 @@
 #include <linux/if_vlan.h>
 #include <linux/kmemleak.h>
 #include <linux/sys_soc.h>
-#include <net/page_pool.h>
+#include <net/page_pool/helpers.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index c61e4e44a78f..0e4f526b1753 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -30,7 +30,7 @@
 #include <linux/sys_soc.h>
 
 #include <net/switchdev.h>
-#include <net/page_pool.h>
+#include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
 #include <net/devlink.h>
 
diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
index e966dd47e2db..1e81e95bcc4b 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -18,7 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/skbuff.h>
-#include <net/page_pool.h>
+#include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 2c3f08be8c37..e04d4a5eed7b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3,7 +3,7 @@
 
 #include <linux/etherdevice.h>
 #include <net/ip6_checksum.h>
-#include <net/page_pool.h>
+#include <net/page_pool/helpers.h>
 #include <net/inet_ecn.h>
 #include <linux/iopoll.h>
 #include <linux/sctp.h>
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 614f3e3efab0..953f6d8f8db0 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -26,7 +26,7 @@
 #include <linux/ptr_ring.h>
 #include <linux/bpf_trace.h>
 #include <linux/net_tstamp.h>
-#include <net/page_pool.h>
+#include <net/page_pool/helpers.h>
 
 #define DRV_NAME	"veth"
 #define DRV_VERSION	"1.0"
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 467afef98ba2..c8f7f80746e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -4,7 +4,6 @@
  */
 #include <linux/sched.h>
 #include <linux/of.h>
-#include <net/page_pool.h>
 #include "mt76.h"
 
 #define CHAN2G(_idx, _freq) {			\
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6b07b8fafec2..81192a07f17f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -15,6 +15,7 @@
 #include <linux/average.h>
 #include <linux/soc/mediatek/mtk_wed.h>
 #include <net/mac80211.h>
+#include <net/page_pool/helpers.h>
 #include "util.h"
 #include "testmode.h"
 
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 47d54d8ea59d..ad29f370034e 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -45,7 +45,7 @@
 #include <linux/slab.h>
 #include <net/ip.h>
 #include <linux/bpf.h>
-#include <net/page_pool.h>
+#include <net/page_pool/types.h>
 #include <linux/bpf_trace.h>
 
 #include <xen/xen.h>
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 16a49ba534e4..888e3d7e74c1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -32,7 +32,7 @@
 #include <linux/if_packet.h>
 #include <linux/llist.h>
 #include <net/flow.h>
-#include <net/page_pool.h>
+#include <net/page_pool/types.h>
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 #include <linux/netfilter/nf_conntrack_common.h>
 #endif
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
new file mode 100644
index 000000000000..e2d8d3a8810c
--- /dev/null
+++ b/include/net/page_pool/helpers.h
@@ -0,0 +1,193 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * page_pool/helpers.h
+ *	Author:	Jesper Dangaard Brouer <netoptimizer@brouer.com>
+ *	Copyright (C) 2016 Red Hat, Inc.
+ */
+
+/**
+ * DOC: page_pool allocator
+ *
+ * This page_pool allocator is optimized for the XDP mode that
+ * uses one-frame-per-page, but have fallbacks that act like the
+ * regular page allocator APIs.
+ *
+ * Basic use involve replacing alloc_pages() calls with the
+ * page_pool_alloc_pages() call.  Drivers should likely use
+ * page_pool_dev_alloc_pages() replacing dev_alloc_pages().
+ *
+ * API keeps track of in-flight pages, in-order to let API user know
+ * when it is safe to dealloactor page_pool object.  Thus, API users
+ * must call page_pool_put_page() where appropriate and only attach
+ * the page to a page_pool-aware objects, like skbs marked for recycling.
+ *
+ * API user must only call page_pool_put_page() once on a page, as it
+ * will either recycle the page, or in case of elevated refcnt, it
+ * will release the DMA mapping and in-flight state accounting.  We
+ * hope to lift this requirement in the future.
+ */
+#ifndef _NET_PAGE_POOL_HELPERS_H
+#define _NET_PAGE_POOL_HELPERS_H
+
+#include <net/page_pool/types.h>
+
+#ifdef CONFIG_PAGE_POOL_STATS
+int page_pool_ethtool_stats_get_count(void);
+u8 *page_pool_ethtool_stats_get_strings(u8 *data);
+u64 *page_pool_ethtool_stats_get(u64 *data, void *stats);
+
+/*
+ * Drivers that wish to harvest page pool stats and report them to users
+ * (perhaps via ethtool, debugfs, or another mechanism) can allocate a
+ * struct page_pool_stats call page_pool_get_stats to get stats for the specified pool.
+ */
+bool page_pool_get_stats(struct page_pool *pool,
+			 struct page_pool_stats *stats);
+#else
+static inline int page_pool_ethtool_stats_get_count(void)
+{
+	return 0;
+}
+
+static inline u8 *page_pool_ethtool_stats_get_strings(u8 *data)
+{
+	return data;
+}
+
+static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
+{
+	return data;
+}
+#endif
+
+static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
+{
+	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
+
+	return page_pool_alloc_pages(pool, gfp);
+}
+
+static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
+						    unsigned int *offset,
+						    unsigned int size)
+{
+	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
+
+	return page_pool_alloc_frag(pool, offset, size, gfp);
+}
+
+/* get the stored dma direction. A driver might decide to treat this locally and
+ * avoid the extra cache line from page_pool to determine the direction
+ */
+static
+inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
+{
+	return pool->p.dma_dir;
+}
+
+/* pp_frag_count represents the number of writers who can update the page
+ * either by updating skb->data or via DMA mappings for the device.
+ * We can't rely on the page refcnt for that as we don't know who might be
+ * holding page references and we can't reliably destroy or sync DMA mappings
+ * of the fragments.
+ *
+ * When pp_frag_count reaches 0 we can either recycle the page if the page
+ * refcnt is 1 or return it back to the memory allocator and destroy any
+ * mappings we have.
+ */
+static inline void page_pool_fragment_page(struct page *page, long nr)
+{
+	atomic_long_set(&page->pp_frag_count, nr);
+}
+
+static inline long page_pool_defrag_page(struct page *page, long nr)
+{
+	long ret;
+
+	/* If nr == pp_frag_count then we have cleared all remaining
+	 * references to the page. No need to actually overwrite it, instead
+	 * we can leave this to be overwritten by the calling function.
+	 *
+	 * The main advantage to doing this is that an atomic_read is
+	 * generally a much cheaper operation than an atomic update,
+	 * especially when dealing with a page that may be partitioned
+	 * into only 2 or 3 pieces.
+	 */
+	if (atomic_long_read(&page->pp_frag_count) == nr)
+		return 0;
+
+	ret = atomic_long_sub_return(nr, &page->pp_frag_count);
+	WARN_ON(ret < 0);
+	return ret;
+}
+
+static inline bool page_pool_is_last_frag(struct page_pool *pool,
+					  struct page *page)
+{
+	/* If fragments aren't enabled or count is 0 we were the last user */
+	return !(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
+	       (page_pool_defrag_page(page, 1) == 0);
+}
+
+static inline void page_pool_put_page(struct page_pool *pool,
+				      struct page *page,
+				      unsigned int dma_sync_size,
+				      bool allow_direct)
+{
+	/* When page_pool isn't compiled-in, net/core/xdp.c doesn't
+	 * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
+	 */
+#ifdef CONFIG_PAGE_POOL
+	if (!page_pool_is_last_frag(pool, page))
+		return;
+
+	page_pool_put_defragged_page(pool, page, dma_sync_size, allow_direct);
+#endif
+}
+
+/* Same as above but will try to sync the entire area pool->max_len */
+static inline void page_pool_put_full_page(struct page_pool *pool,
+					   struct page *page, bool allow_direct)
+{
+	page_pool_put_page(pool, page, -1, allow_direct);
+}
+
+/* Same as above but the caller must guarantee safe context. e.g NAPI */
+static inline void page_pool_recycle_direct(struct page_pool *pool,
+					    struct page *page)
+{
+	page_pool_put_full_page(pool, page, true);
+}
+
+#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT	\
+		(sizeof(dma_addr_t) > sizeof(unsigned long))
+
+static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
+{
+	dma_addr_t ret = page->dma_addr;
+
+	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
+		ret |= (dma_addr_t)page->dma_addr_upper << 16 << 16;
+
+	return ret;
+}
+
+static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
+{
+	page->dma_addr = addr;
+	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
+		page->dma_addr_upper = upper_32_bits(addr);
+}
+
+static inline bool page_pool_put(struct page_pool *pool)
+{
+	return refcount_dec_and_test(&pool->user_cnt);
+}
+
+static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
+{
+	if (unlikely(pool->p.nid != new_nid))
+		page_pool_update_nid(pool, new_nid);
+}
+
+#endif /* _NET_PAGE_POOL_HELPERS_H */
diff --git a/include/net/page_pool.h b/include/net/page_pool/types.h
similarity index 51%
rename from include/net/page_pool.h
rename to include/net/page_pool/types.h
index f1d5cc1fa13b..4a0270291deb 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool/types.h
@@ -1,37 +1,10 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * page_pool.h
- *	Author:	Jesper Dangaard Brouer <netoptimizer@brouer.com>
- *	Copyright (C) 2016 Red Hat, Inc.
- */
+/* SPDX-License-Identifier: GPL-2.0 */
 
-/**
- * DOC: page_pool allocator
- *
- * This page_pool allocator is optimized for the XDP mode that
- * uses one-frame-per-page, but have fallbacks that act like the
- * regular page allocator APIs.
- *
- * Basic use involve replacing alloc_pages() calls with the
- * page_pool_alloc_pages() call.  Drivers should likely use
- * page_pool_dev_alloc_pages() replacing dev_alloc_pages().
- *
- * API keeps track of in-flight pages, in-order to let API user know
- * when it is safe to dealloactor page_pool object.  Thus, API users
- * must call page_pool_put_page() where appropriate and only attach
- * the page to a page_pool-aware objects, like skbs marked for recycling.
- *
- * API user must only call page_pool_put_page() once on a page, as it
- * will either recycle the page, or in case of elevated refcnt, it
- * will release the DMA mapping and in-flight state accounting.  We
- * hope to lift this requirement in the future.
- */
-#ifndef _NET_PAGE_POOL_H
-#define _NET_PAGE_POOL_H
+#ifndef _NET_PAGE_POOL_TYPES_H
+#define _NET_PAGE_POOL_TYPES_H
 
-#include <linux/mm.h> /* Needed by ptr_ring */
-#include <linux/ptr_ring.h>
 #include <linux/dma-direction.h>
+#include <linux/ptr_ring.h>
 
 #define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
 					* map/unmap
@@ -116,35 +89,6 @@ struct page_pool_stats {
 	struct page_pool_alloc_stats alloc_stats;
 	struct page_pool_recycle_stats recycle_stats;
 };
-
-int page_pool_ethtool_stats_get_count(void);
-u8 *page_pool_ethtool_stats_get_strings(u8 *data);
-u64 *page_pool_ethtool_stats_get(u64 *data, void *stats);
-
-/*
- * Drivers that wish to harvest page pool stats and report them to users
- * (perhaps via ethtool, debugfs, or another mechanism) can allocate a
- * struct page_pool_stats call page_pool_get_stats to get stats for the specified pool.
- */
-bool page_pool_get_stats(struct page_pool *pool,
-			 struct page_pool_stats *stats);
-#else
-
-static inline int page_pool_ethtool_stats_get_count(void)
-{
-	return 0;
-}
-
-static inline u8 *page_pool_ethtool_stats_get_strings(u8 *data)
-{
-	return data;
-}
-
-static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
-{
-	return data;
-}
-
 #endif
 
 struct page_pool {
@@ -188,7 +132,7 @@ struct page_pool {
 	 * association with allocation resource.
 	 *
 	 * Use ptr_ring, as it separates consumer and producer
-	 * effeciently, it a way that doesn't bounce cache-lines.
+	 * efficiently, it a way that doesn't bounce cache-lines.
 	 *
 	 * TODO: Implement bulk return pages into this structure.
 	 */
@@ -210,35 +154,8 @@ struct page_pool {
 };
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
-
-static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
-{
-	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
-
-	return page_pool_alloc_pages(pool, gfp);
-}
-
 struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
 				  unsigned int size, gfp_t gfp);
-
-static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
-						    unsigned int *offset,
-						    unsigned int size)
-{
-	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
-
-	return page_pool_alloc_frag(pool, offset, size, gfp);
-}
-
-/* get the stored dma direction. A driver might decide to treat this locally and
- * avoid the extra cache line from page_pool to determine the direction
- */
-static
-inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
-{
-	return pool->p.dma_dir;
-}
-
 bool page_pool_return_skb_page(struct page *page, bool napi_safe);
 
 struct page_pool *page_pool_create(const struct page_pool_params *params);
@@ -277,100 +194,6 @@ void page_pool_put_defragged_page(struct page_pool *pool, struct page *page,
 				  unsigned int dma_sync_size,
 				  bool allow_direct);
 
-/* pp_frag_count represents the number of writers who can update the page
- * either by updating skb->data or via DMA mappings for the device.
- * We can't rely on the page refcnt for that as we don't know who might be
- * holding page references and we can't reliably destroy or sync DMA mappings
- * of the fragments.
- *
- * When pp_frag_count reaches 0 we can either recycle the page if the page
- * refcnt is 1 or return it back to the memory allocator and destroy any
- * mappings we have.
- */
-static inline void page_pool_fragment_page(struct page *page, long nr)
-{
-	atomic_long_set(&page->pp_frag_count, nr);
-}
-
-static inline long page_pool_defrag_page(struct page *page, long nr)
-{
-	long ret;
-
-	/* If nr == pp_frag_count then we have cleared all remaining
-	 * references to the page. No need to actually overwrite it, instead
-	 * we can leave this to be overwritten by the calling function.
-	 *
-	 * The main advantage to doing this is that an atomic_read is
-	 * generally a much cheaper operation than an atomic update,
-	 * especially when dealing with a page that may be partitioned
-	 * into only 2 or 3 pieces.
-	 */
-	if (atomic_long_read(&page->pp_frag_count) == nr)
-		return 0;
-
-	ret = atomic_long_sub_return(nr, &page->pp_frag_count);
-	WARN_ON(ret < 0);
-	return ret;
-}
-
-static inline bool page_pool_is_last_frag(struct page_pool *pool,
-					  struct page *page)
-{
-	/* If fragments aren't enabled or count is 0 we were the last user */
-	return !(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
-	       (page_pool_defrag_page(page, 1) == 0);
-}
-
-static inline void page_pool_put_page(struct page_pool *pool,
-				      struct page *page,
-				      unsigned int dma_sync_size,
-				      bool allow_direct)
-{
-	/* When page_pool isn't compiled-in, net/core/xdp.c doesn't
-	 * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
-	 */
-#ifdef CONFIG_PAGE_POOL
-	if (!page_pool_is_last_frag(pool, page))
-		return;
-
-	page_pool_put_defragged_page(pool, page, dma_sync_size, allow_direct);
-#endif
-}
-
-/* Same as above but will try to sync the entire area pool->max_len */
-static inline void page_pool_put_full_page(struct page_pool *pool,
-					   struct page *page, bool allow_direct)
-{
-	page_pool_put_page(pool, page, -1, allow_direct);
-}
-
-/* Same as above but the caller must guarantee safe context. e.g NAPI */
-static inline void page_pool_recycle_direct(struct page_pool *pool,
-					    struct page *page)
-{
-	page_pool_put_full_page(pool, page, true);
-}
-
-#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT	\
-		(sizeof(dma_addr_t) > sizeof(unsigned long))
-
-static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
-{
-	dma_addr_t ret = page->dma_addr;
-
-	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
-		ret |= (dma_addr_t)page->dma_addr_upper << 16 << 16;
-
-	return ret;
-}
-
-static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
-{
-	page->dma_addr = addr;
-	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
-		page->dma_addr_upper = upper_32_bits(addr);
-}
-
 static inline bool is_page_pool_compiled_in(void)
 {
 #ifdef CONFIG_PAGE_POOL
@@ -380,17 +203,7 @@ static inline bool is_page_pool_compiled_in(void)
 #endif
 }
 
-static inline bool page_pool_put(struct page_pool *pool)
-{
-	return refcount_dec_and_test(&pool->user_cnt);
-}
-
 /* Caller must provide appropriate safe context, e.g. NAPI. */
 void page_pool_update_nid(struct page_pool *pool, int new_nid);
-static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
-{
-	if (unlikely(pool->p.nid != new_nid))
-		page_pool_update_nid(pool, new_nid);
-}
 
 #endif /* _NET_PAGE_POOL_H */
diff --git a/include/trace/events/page_pool.h b/include/trace/events/page_pool.h
index ca534501158b..6834356b2d2a 100644
--- a/include/trace/events/page_pool.h
+++ b/include/trace/events/page_pool.h
@@ -9,7 +9,7 @@
 #include <linux/tracepoint.h>
 
 #include <trace/events/mmflags.h>
-#include <net/page_pool.h>
+#include <net/page_pool/types.h>
 
 TRACE_EVENT(page_pool_release,
 
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 7d47f53f20c1..f892698c8829 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -15,7 +15,7 @@
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/net_namespace.h>
-#include <net/page_pool.h>
+#include <net/page_pool/helpers.h>
 #include <linux/error-injection.h>
 #include <linux/smp.h>
 #include <linux/sock_diag.h>
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 7ca456bfab71..2a75f61264c5 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -10,7 +10,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 
-#include <net/page_pool.h>
+#include <net/page_pool/helpers.h>
 #include <net/xdp.h>
 
 #include <linux/dma-direction.h>
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a298992060e6..ac8f421f8ab3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -73,7 +73,7 @@
 #include <net/mpls.h>
 #include <net/mptcp.h>
 #include <net/mctp.h>
-#include <net/page_pool.h>
+#include <net/page_pool/types.h>
 #include <net/dropreason.h>
 
 #include <linux/uaccess.h>
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 8362130bf085..a70670fe9a2d 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -14,7 +14,7 @@
 #include <linux/idr.h>
 #include <linux/rhashtable.h>
 #include <linux/bug.h>
-#include <net/page_pool.h>
+#include <net/page_pool/helpers.h>
 
 #include <net/xdp.h>
 #include <net/xdp_priv.h> /* struct xdp_mem_allocator */
-- 
2.41.0

