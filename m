Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA72A770777
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjHDSGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjHDSGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:06:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B0349F3;
        Fri,  4 Aug 2023 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691172373; x=1722708373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RZ7ZnuPI/D/1t0HO+OKy5Bb5WVFAf8SnWGhQZKMILsI=;
  b=Fa8EPXg+Y550+KoIHUEqNexD3wm21UZR9mDTh4rdN4XsmcKHKs4hP08E
   ZAbAhP7VfrFgX7f5ffX61g+WKZQUXd9YDpachKTYAkla1QyTE3CcUrbqp
   wg4QnjJKdtzAVzXNhkOe4/huDVTaxYojKjr1Ocx7KTqnEyqxP8UaRUomT
   E+ODo2GwtRgZTM1QiBtZNDtpizTcrVIvVAVAk7H9eAJ7Y3ER5SAdCesYv
   f+9ionLRow2JXA36DCR+ACCSsk9b7x/N4NcYxX1mbLeRs8fSOWaf6+0x4
   1lZu031KZgztJet4a8oX34ONbzneMQs/gNVFBdo9gPIVxOn4MQPNyeRW6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="434061609"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="434061609"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 11:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="759673576"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="759673576"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2023 11:06:05 -0700
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
Subject: [PATCH net-next v4 1/6] page_pool: split types and declarations from page_pool.h
Date:   Fri,  4 Aug 2023 20:05:24 +0200
Message-ID: <20230804180529.2483231-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 MAINTAINERS                                   |   2 +-
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
 .../net/{page_pool.h => page_pool/helpers.h}  | 242 +-----------------
 include/net/page_pool/types.h                 | 238 +++++++++++++++++
 include/trace/events/page_pool.h              |   2 +-
 net/bpf/test_run.c                            |   2 +-
 net/core/page_pool.c                          |   2 +-
 net/core/skbuff.c                             |   2 +-
 net/core/xdp.c                                |   2 +-
 41 files changed, 280 insertions(+), 264 deletions(-)
 rename include/net/{page_pool.h => page_pool/helpers.h} (51%)
 create mode 100644 include/net/page_pool/types.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e2bb1059ab6..08bcf3a7c482 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16020,7 +16020,7 @@ M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/networking/page_pool.rst
-F:	include/net/page_pool.h
+F:	include/net/page_pool/
 F:	include/trace/events/page_pool.h
 F:	net/core/page_pool.c
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6a643aae7802..eb168ca983b7 100644
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
index 2ce46d7affe4..96f5ca778c67 100644
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
index 43f14cec91e9..3bd0bf03aedb 100644
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
index 9e1b596c8f08..eb74ccddb440 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -35,6 +35,7 @@
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
index 61f62a6ec662..70b9065f7d10 100644
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
index 1b89f800f6df..fe05c9020269 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -26,6 +26,7 @@
 #include <linux/bitfield.h>
 #include <net/dsa.h>
 #include <net/dst_metadata.h>
+#include <net/page_pool/helpers.h>
 
 #include "mtk_eth_soc.h"
 #include "mtk_wed.h"
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 80d17729e557..4a2470fbad2c 100644
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
index 1c820119e438..c8ec6467d4d1 100644
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
index f7bb5f4aaaca..3fd11b0761e0 100644
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
index aebc9154693a..caa9e0533c96 100644
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
index 0dcd6a568b06..f358ea003193 100644
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
index a6d034968654..3401e888a9f6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -21,7 +21,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/net_tstamp.h>
 #include <linux/reset.h>
-#include <net/page_pool.h>
+#include <net/page_pool/types.h>
 #include <net/xdp.h>
 #include <uapi/linux/bpf.h>
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e1f1c034d325..380ac6c7046f 100644
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
index ae52cdbcf8cc..0ec85635dfd6 100644
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
diff --git a/include/net/page_pool.h b/include/net/page_pool/helpers.h
similarity index 51%
rename from include/net/page_pool.h
rename to include/net/page_pool/helpers.h
index 73d4f786418d..78df91804c87 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool/helpers.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * page_pool.h
+ * page_pool/helpers.h
  *	Author:	Jesper Dangaard Brouer <netoptimizer@brouer.com>
  *	Copyright (C) 2016 Red Hat, Inc.
  */
@@ -26,126 +26,12 @@
  * will release the DMA mapping and in-flight state accounting.  We
  * hope to lift this requirement in the future.
  */
-#ifndef _NET_PAGE_POOL_H
-#define _NET_PAGE_POOL_H
+#ifndef _NET_PAGE_POOL_HELPERS_H
+#define _NET_PAGE_POOL_HELPERS_H
 
-#include <linux/mm.h> /* Needed by ptr_ring */
-#include <linux/ptr_ring.h>
-#include <linux/dma-direction.h>
-
-#define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
-					* map/unmap
-					*/
-#define PP_FLAG_DMA_SYNC_DEV	BIT(1) /* If set all pages that the driver gets
-					* from page_pool will be
-					* DMA-synced-for-device according to
-					* the length provided by the device
-					* driver.
-					* Please note DMA-sync-for-CPU is still
-					* device driver responsibility
-					*/
-#define PP_FLAG_PAGE_FRAG	BIT(2) /* for page frag feature */
-#define PP_FLAG_ALL		(PP_FLAG_DMA_MAP |\
-				 PP_FLAG_DMA_SYNC_DEV |\
-				 PP_FLAG_PAGE_FRAG)
-
-/*
- * Fast allocation side cache array/stack
- *
- * The cache size and refill watermark is related to the network
- * use-case.  The NAPI budget is 64 packets.  After a NAPI poll the RX
- * ring is usually refilled and the max consumed elements will be 64,
- * thus a natural max size of objects needed in the cache.
- *
- * Keeping room for more objects, is due to XDP_DROP use-case.  As
- * XDP_DROP allows the opportunity to recycle objects directly into
- * this array, as it shares the same softirq/NAPI protection.  If
- * cache is already full (or partly full) then the XDP_DROP recycles
- * would have to take a slower code path.
- */
-#define PP_ALLOC_CACHE_SIZE	128
-#define PP_ALLOC_CACHE_REFILL	64
-struct pp_alloc_cache {
-	u32 count;
-	struct page *cache[PP_ALLOC_CACHE_SIZE];
-};
-
-/**
- * struct page_pool_params - page pool parameters
- * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_PAGE_FRAG
- * @order:	2^order pages on allocation
- * @pool_size:	size of the ptr_ring
- * @nid:	NUMA node id to allocate from pages from
- * @dev:	device, for DMA pre-mapping purposes
- * @napi:	NAPI which is the sole consumer of pages, otherwise NULL
- * @dma_dir:	DMA mapping direction
- * @max_len:	max DMA sync memory size for PP_FLAG_DMA_SYNC_DEV
- * @offset:	DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
- */
-struct page_pool_params {
-	unsigned int	flags;
-	unsigned int	order;
-	unsigned int	pool_size;
-	int		nid;
-	struct device	*dev;
-	struct napi_struct *napi;
-	enum dma_data_direction dma_dir;
-	unsigned int	max_len;
-	unsigned int	offset;
-/* private: used by test code only */
-	void (*init_callback)(struct page *page, void *arg);
-	void *init_arg;
-};
+#include <net/page_pool/types.h>
 
 #ifdef CONFIG_PAGE_POOL_STATS
-/**
- * struct page_pool_alloc_stats - allocation statistics
- * @fast:	successful fast path allocations
- * @slow:	slow path order-0 allocations
- * @slow_high_order: slow path high order allocations
- * @empty:	ptr ring is empty, so a slow path allocation was forced
- * @refill:	an allocation which triggered a refill of the cache
- * @waive:	pages obtained from the ptr ring that cannot be added to
- *		the cache due to a NUMA mismatch
- */
-struct page_pool_alloc_stats {
-	u64 fast;
-	u64 slow;
-	u64 slow_high_order;
-	u64 empty;
-	u64 refill;
-	u64 waive;
-};
-
-/**
- * struct page_pool_recycle_stats - recycling (freeing) statistics
- * @cached:	recycling placed page in the page pool cache
- * @cache_full:	page pool cache was full
- * @ring:	page placed into the ptr ring
- * @ring_full:	page released from page pool because the ptr ring was full
- * @released_refcnt:	page released (and not recycled) because refcnt > 1
- */
-struct page_pool_recycle_stats {
-	u64 cached;
-	u64 cache_full;
-	u64 ring;
-	u64 ring_full;
-	u64 released_refcnt;
-};
-
-/**
- * struct page_pool_stats - combined page pool use statistics
- * @alloc_stats:	see struct page_pool_alloc_stats
- * @recycle_stats:	see struct page_pool_recycle_stats
- *
- * Wrapper struct for combining page pool stats with different storage
- * requirements.
- */
-struct page_pool_stats {
-	struct page_pool_alloc_stats alloc_stats;
-	struct page_pool_recycle_stats recycle_stats;
-};
-
 int page_pool_ethtool_stats_get_count(void);
 u8 *page_pool_ethtool_stats_get_strings(u8 *data);
 u64 *page_pool_ethtool_stats_get(u64 *data, void *stats);
@@ -158,7 +44,6 @@ u64 *page_pool_ethtool_stats_get(u64 *data, void *stats);
 bool page_pool_get_stats(struct page_pool *pool,
 			 struct page_pool_stats *stats);
 #else
-
 static inline int page_pool_ethtool_stats_get_count(void)
 {
 	return 0;
@@ -173,72 +58,7 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
 {
 	return data;
 }
-
-#endif
-
-struct page_pool {
-	struct page_pool_params p;
-
-	struct delayed_work release_dw;
-	void (*disconnect)(void *);
-	unsigned long defer_start;
-	unsigned long defer_warn;
-
-	u32 pages_state_hold_cnt;
-	unsigned int frag_offset;
-	struct page *frag_page;
-	long frag_users;
-
-#ifdef CONFIG_PAGE_POOL_STATS
-	/* these stats are incremented while in softirq context */
-	struct page_pool_alloc_stats alloc_stats;
 #endif
-	u32 xdp_mem_id;
-
-	/*
-	 * Data structure for allocation side
-	 *
-	 * Drivers allocation side usually already perform some kind
-	 * of resource protection.  Piggyback on this protection, and
-	 * require driver to protect allocation side.
-	 *
-	 * For NIC drivers this means, allocate a page_pool per
-	 * RX-queue. As the RX-queue is already protected by
-	 * Softirq/BH scheduling and napi_schedule. NAPI schedule
-	 * guarantee that a single napi_struct will only be scheduled
-	 * on a single CPU (see napi_schedule).
-	 */
-	struct pp_alloc_cache alloc ____cacheline_aligned_in_smp;
-
-	/* Data structure for storing recycled pages.
-	 *
-	 * Returning/freeing pages is more complicated synchronization
-	 * wise, because free's can happen on remote CPUs, with no
-	 * association with allocation resource.
-	 *
-	 * Use ptr_ring, as it separates consumer and producer
-	 * effeciently, it a way that doesn't bounce cache-lines.
-	 *
-	 * TODO: Implement bulk return pages into this structure.
-	 */
-	struct ptr_ring ring;
-
-#ifdef CONFIG_PAGE_POOL_STATS
-	/* recycle stats are per-cpu to avoid locking */
-	struct page_pool_recycle_stats __percpu *recycle_stats;
-#endif
-	atomic_t pages_state_release_cnt;
-
-	/* A page_pool is strictly tied to a single RX-queue being
-	 * protected by NAPI, due to above pp_alloc_cache. This
-	 * refcnt serves purpose is to simplify drivers error handling.
-	 */
-	refcount_t user_cnt;
-
-	u64 destroy_cnt;
-};
-
-struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
 
 /**
  * page_pool_dev_alloc_pages() - allocate a page.
@@ -253,9 +73,6 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
 	return page_pool_alloc_pages(pool, gfp);
 }
 
-struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
-				  unsigned int size, gfp_t gfp);
-
 static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
 						    unsigned int *offset,
 						    unsigned int size)
@@ -278,44 +95,6 @@ inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
 	return pool->p.dma_dir;
 }
 
-bool page_pool_return_skb_page(struct page *page, bool napi_safe);
-
-struct page_pool *page_pool_create(const struct page_pool_params *params);
-
-struct xdp_mem_info;
-
-#ifdef CONFIG_PAGE_POOL
-void page_pool_unlink_napi(struct page_pool *pool);
-void page_pool_destroy(struct page_pool *pool);
-void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
-			   struct xdp_mem_info *mem);
-void page_pool_put_page_bulk(struct page_pool *pool, void **data,
-			     int count);
-#else
-static inline void page_pool_unlink_napi(struct page_pool *pool)
-{
-}
-
-static inline void page_pool_destroy(struct page_pool *pool)
-{
-}
-
-static inline void page_pool_use_xdp_mem(struct page_pool *pool,
-					 void (*disconnect)(void *),
-					 struct xdp_mem_info *mem)
-{
-}
-
-static inline void page_pool_put_page_bulk(struct page_pool *pool, void **data,
-					   int count)
-{
-}
-#endif
-
-void page_pool_put_defragged_page(struct page_pool *pool, struct page *page,
-				  unsigned int dma_sync_size,
-				  bool allow_direct);
-
 /* pp_frag_count represents the number of writers who can update the page
  * either by updating skb->data or via DMA mappings for the device.
  * We can't rely on the page refcnt for that as we don't know who might be
@@ -445,26 +224,15 @@ static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
 		page->dma_addr_upper = upper_32_bits(addr);
 }
 
-static inline bool is_page_pool_compiled_in(void)
-{
-#ifdef CONFIG_PAGE_POOL
-	return true;
-#else
-	return false;
-#endif
-}
-
 static inline bool page_pool_put(struct page_pool *pool)
 {
 	return refcount_dec_and_test(&pool->user_cnt);
 }
 
-/* Caller must provide appropriate safe context, e.g. NAPI. */
-void page_pool_update_nid(struct page_pool *pool, int new_nid);
 static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 {
 	if (unlikely(pool->p.nid != new_nid))
 		page_pool_update_nid(pool, new_nid);
 }
 
-#endif /* _NET_PAGE_POOL_H */
+#endif /* _NET_PAGE_POOL_HELPERS_H */
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
new file mode 100644
index 000000000000..9ac39191bed7
--- /dev/null
+++ b/include/net/page_pool/types.h
@@ -0,0 +1,238 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _NET_PAGE_POOL_TYPES_H
+#define _NET_PAGE_POOL_TYPES_H
+
+#include <linux/dma-direction.h>
+#include <linux/ptr_ring.h>
+
+#define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
+					* map/unmap
+					*/
+#define PP_FLAG_DMA_SYNC_DEV	BIT(1) /* If set all pages that the driver gets
+					* from page_pool will be
+					* DMA-synced-for-device according to
+					* the length provided by the device
+					* driver.
+					* Please note DMA-sync-for-CPU is still
+					* device driver responsibility
+					*/
+#define PP_FLAG_PAGE_FRAG	BIT(2) /* for page frag feature */
+#define PP_FLAG_ALL		(PP_FLAG_DMA_MAP |\
+				 PP_FLAG_DMA_SYNC_DEV |\
+				 PP_FLAG_PAGE_FRAG)
+
+/*
+ * Fast allocation side cache array/stack
+ *
+ * The cache size and refill watermark is related to the network
+ * use-case.  The NAPI budget is 64 packets.  After a NAPI poll the RX
+ * ring is usually refilled and the max consumed elements will be 64,
+ * thus a natural max size of objects needed in the cache.
+ *
+ * Keeping room for more objects, is due to XDP_DROP use-case.  As
+ * XDP_DROP allows the opportunity to recycle objects directly into
+ * this array, as it shares the same softirq/NAPI protection.  If
+ * cache is already full (or partly full) then the XDP_DROP recycles
+ * would have to take a slower code path.
+ */
+#define PP_ALLOC_CACHE_SIZE	128
+#define PP_ALLOC_CACHE_REFILL	64
+struct pp_alloc_cache {
+	u32 count;
+	struct page *cache[PP_ALLOC_CACHE_SIZE];
+};
+
+/**
+ * struct page_pool_params - page pool parameters
+ * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_PAGE_FRAG
+ * @order:	2^order pages on allocation
+ * @pool_size:	size of the ptr_ring
+ * @nid:	NUMA node id to allocate from pages from
+ * @dev:	device, for DMA pre-mapping purposes
+ * @napi:	NAPI which is the sole consumer of pages, otherwise NULL
+ * @dma_dir:	DMA mapping direction
+ * @max_len:	max DMA sync memory size for PP_FLAG_DMA_SYNC_DEV
+ * @offset:	DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
+ */
+struct page_pool_params {
+	unsigned int	flags;
+	unsigned int	order;
+	unsigned int	pool_size;
+	int		nid;
+	struct device	*dev;
+	struct napi_struct *napi;
+	enum dma_data_direction dma_dir;
+	unsigned int	max_len;
+	unsigned int	offset;
+/* private: used by test code only */
+	void (*init_callback)(struct page *page, void *arg);
+	void *init_arg;
+};
+
+#ifdef CONFIG_PAGE_POOL_STATS
+/**
+ * struct page_pool_alloc_stats - allocation statistics
+ * @fast:	successful fast path allocations
+ * @slow:	slow path order-0 allocations
+ * @slow_high_order: slow path high order allocations
+ * @empty:	ptr ring is empty, so a slow path allocation was forced
+ * @refill:	an allocation which triggered a refill of the cache
+ * @waive:	pages obtained from the ptr ring that cannot be added to
+ *		the cache due to a NUMA mismatch
+ */
+struct page_pool_alloc_stats {
+	u64 fast;
+	u64 slow;
+	u64 slow_high_order;
+	u64 empty;
+	u64 refill;
+	u64 waive;
+};
+
+/**
+ * struct page_pool_recycle_stats - recycling (freeing) statistics
+ * @cached:	recycling placed page in the page pool cache
+ * @cache_full:	page pool cache was full
+ * @ring:	page placed into the ptr ring
+ * @ring_full:	page released from page pool because the ptr ring was full
+ * @released_refcnt:	page released (and not recycled) because refcnt > 1
+ */
+struct page_pool_recycle_stats {
+	u64 cached;
+	u64 cache_full;
+	u64 ring;
+	u64 ring_full;
+	u64 released_refcnt;
+};
+
+/**
+ * struct page_pool_stats - combined page pool use statistics
+ * @alloc_stats:	see struct page_pool_alloc_stats
+ * @recycle_stats:	see struct page_pool_recycle_stats
+ *
+ * Wrapper struct for combining page pool stats with different storage
+ * requirements.
+ */
+struct page_pool_stats {
+	struct page_pool_alloc_stats alloc_stats;
+	struct page_pool_recycle_stats recycle_stats;
+};
+#endif
+
+struct page_pool {
+	struct page_pool_params p;
+
+	struct delayed_work release_dw;
+	void (*disconnect)(void *pool);
+	unsigned long defer_start;
+	unsigned long defer_warn;
+
+	u32 pages_state_hold_cnt;
+	unsigned int frag_offset;
+	struct page *frag_page;
+	long frag_users;
+
+#ifdef CONFIG_PAGE_POOL_STATS
+	/* these stats are incremented while in softirq context */
+	struct page_pool_alloc_stats alloc_stats;
+#endif
+	u32 xdp_mem_id;
+
+	/*
+	 * Data structure for allocation side
+	 *
+	 * Drivers allocation side usually already perform some kind
+	 * of resource protection.  Piggyback on this protection, and
+	 * require driver to protect allocation side.
+	 *
+	 * For NIC drivers this means, allocate a page_pool per
+	 * RX-queue. As the RX-queue is already protected by
+	 * Softirq/BH scheduling and napi_schedule. NAPI schedule
+	 * guarantee that a single napi_struct will only be scheduled
+	 * on a single CPU (see napi_schedule).
+	 */
+	struct pp_alloc_cache alloc ____cacheline_aligned_in_smp;
+
+	/* Data structure for storing recycled pages.
+	 *
+	 * Returning/freeing pages is more complicated synchronization
+	 * wise, because free's can happen on remote CPUs, with no
+	 * association with allocation resource.
+	 *
+	 * Use ptr_ring, as it separates consumer and producer
+	 * efficiently, it a way that doesn't bounce cache-lines.
+	 *
+	 * TODO: Implement bulk return pages into this structure.
+	 */
+	struct ptr_ring ring;
+
+#ifdef CONFIG_PAGE_POOL_STATS
+	/* recycle stats are per-cpu to avoid locking */
+	struct page_pool_recycle_stats __percpu *recycle_stats;
+#endif
+	atomic_t pages_state_release_cnt;
+
+	/* A page_pool is strictly tied to a single RX-queue being
+	 * protected by NAPI, due to above pp_alloc_cache. This
+	 * refcnt serves purpose is to simplify drivers error handling.
+	 */
+	refcount_t user_cnt;
+
+	u64 destroy_cnt;
+};
+
+struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
+struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
+				  unsigned int size, gfp_t gfp);
+bool page_pool_return_skb_page(struct page *page, bool napi_safe);
+
+struct page_pool *page_pool_create(const struct page_pool_params *params);
+
+struct xdp_mem_info;
+
+#ifdef CONFIG_PAGE_POOL
+void page_pool_unlink_napi(struct page_pool *pool);
+void page_pool_destroy(struct page_pool *pool);
+void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
+			   struct xdp_mem_info *mem);
+void page_pool_put_page_bulk(struct page_pool *pool, void **data,
+			     int count);
+#else
+static inline void page_pool_unlink_napi(struct page_pool *pool)
+{
+}
+
+static inline void page_pool_destroy(struct page_pool *pool)
+{
+}
+
+static inline void page_pool_use_xdp_mem(struct page_pool *pool,
+					 void (*disconnect)(void *),
+					 struct xdp_mem_info *mem)
+{
+}
+
+static inline void page_pool_put_page_bulk(struct page_pool *pool, void **data,
+					   int count)
+{
+}
+#endif
+
+void page_pool_put_defragged_page(struct page_pool *pool, struct page *page,
+				  unsigned int dma_sync_size,
+				  bool allow_direct);
+
+static inline bool is_page_pool_compiled_in(void)
+{
+#ifdef CONFIG_PAGE_POOL
+	return true;
+#else
+	return false;
+#endif
+}
+
+/* Caller must provide appropriate safe context, e.g. NAPI. */
+void page_pool_update_nid(struct page_pool *pool, int new_nid);
+
+#endif /* _NET_PAGE_POOL_H */
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
index 0aac76c13fd4..57a7a64b84ed 100644
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
index 5d615a169718..cd28c1f14002 100644
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
index c6f98245582c..d3bed964123c 100644
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

