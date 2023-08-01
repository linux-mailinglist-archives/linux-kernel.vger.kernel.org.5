Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D39376ACBC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjHAJSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjHAJRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:17:22 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DBD1BC7;
        Tue,  1 Aug 2023 02:16:25 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3719FMmN066619;
        Tue, 1 Aug 2023 04:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690881322;
        bh=/fLPbV0f6pPdGZr74jxOBl4HnU3j58HVMWFqy5E65xg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BFBXCDDO2POR1PKBXKKM22S9a26xzd5djuIZ8QIna7FushESBr81qJRFEvjqKAa5O
         tjz3NMhHJFDYVUiFcEGivkvVu5w62tcXgk5x9prGfLbBveZWfBF04KfeG+8dVFtyZ3
         47xhsOd9cBj23Yrs+Z4zZjohDYi3DYv/09VU2SD8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3719FMh9086218
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 04:15:22 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 04:15:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 04:15:21 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3719FMdb013005;
        Tue, 1 Aug 2023 04:15:22 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3719FL9c016096;
        Tue, 1 Aug 2023 04:15:21 -0500
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
Subject: [PATCH v13 07/10] net: ti: icssg-prueth: Add ICSSG Stats
Date:   Tue, 1 Aug 2023 14:44:25 +0530
Message-ID: <20230801091428.1359979-8-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801091428.1359979-1-danishanwar@ti.com>
References: <20230801091428.1359979-1-danishanwar@ti.com>
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

Add icssg_stats.c to help dump, icssg related driver statistics.

ICSSG has hardware registers for providing statistics like total rx bytes,
total tx bytes, etc. These registers are of 32 bits and hence in case of 1G
link, they overflows in around 32 seconds. The behaviour of these registers
is such that they don't roll back to 0 after overflow but rather stay at
UINT_MAX.

These registers support a feature where the value written to them is
subtracted from the register. This feature can be utilized to fix the
overflowing of stats.

This solution uses a Workqueues based solution where a function gets
called before the registers overflow (every 25 seconds in 1G link, 25000
seconds in 100M link), this function saves the register
values in local variables and writes the last read value to the
register. So any update during the read will be taken care of.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/Makefile             |   1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |   8 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   8 +
 drivers/net/ethernet/ti/icssg/icssg_stats.c  |  44 ++++++
 drivers/net/ethernet/ti/icssg/icssg_stats.h  | 158 +++++++++++++++++++
 5 files changed, 219 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_stats.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_stats.h

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index efb050cbb4a8..03d9b2b36b5f 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -36,3 +36,4 @@ icssg-prueth-y := k3-cppi-desc-pool.o \
 		  icssg/icssg_queues.o \
 		  icssg/icssg_config.o \
 		  icssg/icssg_mii_cfg.o \
+		  icssg/icssg_stats.o \
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 1869e38f898f..d0bb4db11b30 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma/ti-cppi5.h>
 #include <linux/etherdevice.h>
@@ -1090,6 +1091,8 @@ static int emac_ndo_open(struct net_device *ndev)
 
 	prueth->emacs_initialized++;
 
+	queue_work(system_long_wq, &emac->stats_work.work);
+
 	return 0;
 
 reset_tx_chan:
@@ -1164,6 +1167,9 @@ static int emac_ndo_stop(struct net_device *ndev)
 
 	cancel_work_sync(&emac->rx_mode_work);
 
+	/* Destroying the queued work in ndo_stop() */
+	cancel_delayed_work_sync(&emac->stats_work);
+
 	/* stop PRUs */
 	prueth_emac_stop(emac);
 
@@ -1313,6 +1319,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 	}
 	INIT_WORK(&emac->rx_mode_work, emac_ndo_set_rx_mode_work);
 
+	INIT_DELAYED_WORK(&emac->stats_work, emac_stats_work_handler);
+
 	ret = pruss_request_mem_region(prueth->pruss,
 				       port == PRUETH_PORT_MII0 ?
 				       PRUSS_MEM_DRAM0 : PRUSS_MEM_DRAM1,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index b3a923e7a5c9..f13de0d2e90b 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -49,6 +49,9 @@
 
 #define ICSSG_MAX_RFLOWS	8	/* per slice */
 
+/* Number of ICSSG related stats */
+#define ICSSG_NUM_STATS 60
+
 /* Firmware status codes */
 #define ICSS_HS_FW_READY 0x55555555
 #define ICSS_HS_FW_DEAD 0xDEAD0000	/* lower 16 bits contain error code */
@@ -153,6 +156,9 @@ struct prueth_emac {
 	struct workqueue_struct	*cmd_wq;
 
 	struct pruss_mem_region dram;
+
+	struct delayed_work stats_work;
+	u64 stats[ICSSG_NUM_STATS];
 };
 
 /**
@@ -246,4 +252,6 @@ u32 icssg_queue_level(struct prueth *prueth, int queue);
 #define prueth_napi_to_tx_chn(pnapi) \
 	container_of(pnapi, struct prueth_tx_chn, napi_tx)
 
+void emac_stats_work_handler(struct work_struct *work);
+void emac_update_hardware_stats(struct prueth_emac *emac);
 #endif /* __NET_TI_ICSSG_PRUETH_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
new file mode 100644
index 000000000000..25deb368a3f0
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSG Ethernet driver
+ *
+ * Copyright (C) 2018-2021 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include "icssg_prueth.h"
+#include "icssg_stats.h"
+#include <linux/regmap.h>
+
+static u32 stats_base[] = {	0x54c,	/* Slice 0 stats start */
+				0xb18,	/* Slice 1 stats start */
+};
+
+void emac_update_hardware_stats(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+	int slice = prueth_emac_slice(emac);
+	u32 base = stats_base[slice];
+	u32 val;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++) {
+		regmap_read(prueth->miig_rt,
+			    base + icssg_all_stats[i].offset,
+			    &val);
+		regmap_write(prueth->miig_rt,
+			     base + icssg_all_stats[i].offset,
+			     val);
+
+		emac->stats[i] += val;
+	}
+}
+
+void emac_stats_work_handler(struct work_struct *work)
+{
+	struct prueth_emac *emac = container_of(work, struct prueth_emac,
+						stats_work.work);
+	emac_update_hardware_stats(emac);
+
+	queue_delayed_work(system_long_wq, &emac->stats_work,
+			   msecs_to_jiffies((STATS_TIME_LIMIT_1G_MS * 1000) / emac->speed));
+}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
new file mode 100644
index 000000000000..999a4a91276c
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Texas Instruments ICSSG Ethernet driver
+ *
+ * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#ifndef __NET_TI_ICSSG_STATS_H
+#define __NET_TI_ICSSG_STATS_H
+
+#include "icssg_prueth.h"
+
+#define STATS_TIME_LIMIT_1G_MS    25000    /* 25 seconds @ 1G */
+
+struct miig_stats_regs {
+	/* Rx */
+	u32 rx_packets;
+	u32 rx_broadcast_frames;
+	u32 rx_multicast_frames;
+	u32 rx_crc_errors;
+	u32 rx_mii_error_frames;
+	u32 rx_odd_nibble_frames;
+	u32 rx_frame_max_size;
+	u32 rx_max_size_error_frames;
+	u32 rx_frame_min_size;
+	u32 rx_min_size_error_frames;
+	u32 rx_over_errors;
+	u32 rx_class0_hits;
+	u32 rx_class1_hits;
+	u32 rx_class2_hits;
+	u32 rx_class3_hits;
+	u32 rx_class4_hits;
+	u32 rx_class5_hits;
+	u32 rx_class6_hits;
+	u32 rx_class7_hits;
+	u32 rx_class8_hits;
+	u32 rx_class9_hits;
+	u32 rx_class10_hits;
+	u32 rx_class11_hits;
+	u32 rx_class12_hits;
+	u32 rx_class13_hits;
+	u32 rx_class14_hits;
+	u32 rx_class15_hits;
+	u32 rx_smd_frags;
+	u32 rx_bucket1_size;
+	u32 rx_bucket2_size;
+	u32 rx_bucket3_size;
+	u32 rx_bucket4_size;
+	u32 rx_64B_frames;
+	u32 rx_bucket1_frames;
+	u32 rx_bucket2_frames;
+	u32 rx_bucket3_frames;
+	u32 rx_bucket4_frames;
+	u32 rx_bucket5_frames;
+	u32 rx_bytes;
+	u32 rx_tx_total_bytes;
+	/* Tx */
+	u32 tx_packets;
+	u32 tx_broadcast_frames;
+	u32 tx_multicast_frames;
+	u32 tx_odd_nibble_frames;
+	u32 tx_underflow_errors;
+	u32 tx_frame_max_size;
+	u32 tx_max_size_error_frames;
+	u32 tx_frame_min_size;
+	u32 tx_min_size_error_frames;
+	u32 tx_bucket1_size;
+	u32 tx_bucket2_size;
+	u32 tx_bucket3_size;
+	u32 tx_bucket4_size;
+	u32 tx_64B_frames;
+	u32 tx_bucket1_frames;
+	u32 tx_bucket2_frames;
+	u32 tx_bucket3_frames;
+	u32 tx_bucket4_frames;
+	u32 tx_bucket5_frames;
+	u32 tx_bytes;
+};
+
+#define ICSSG_STATS(field, stats_type)			\
+{							\
+	#field,						\
+	offsetof(struct miig_stats_regs, field),	\
+	stats_type					\
+}
+
+struct icssg_stats {
+	char name[ETH_GSTRING_LEN];
+	u32 offset;
+	bool standard_stats;
+};
+
+static const struct icssg_stats icssg_all_stats[] = {
+	/* Rx */
+	ICSSG_STATS(rx_packets, true),
+	ICSSG_STATS(rx_broadcast_frames, false),
+	ICSSG_STATS(rx_multicast_frames, true),
+	ICSSG_STATS(rx_crc_errors, true),
+	ICSSG_STATS(rx_mii_error_frames, false),
+	ICSSG_STATS(rx_odd_nibble_frames, false),
+	ICSSG_STATS(rx_frame_max_size, true),
+	ICSSG_STATS(rx_max_size_error_frames, false),
+	ICSSG_STATS(rx_frame_min_size, true),
+	ICSSG_STATS(rx_min_size_error_frames, false),
+	ICSSG_STATS(rx_over_errors, true),
+	ICSSG_STATS(rx_class0_hits, false),
+	ICSSG_STATS(rx_class1_hits, false),
+	ICSSG_STATS(rx_class2_hits, false),
+	ICSSG_STATS(rx_class3_hits, false),
+	ICSSG_STATS(rx_class4_hits, false),
+	ICSSG_STATS(rx_class5_hits, false),
+	ICSSG_STATS(rx_class6_hits, false),
+	ICSSG_STATS(rx_class7_hits, false),
+	ICSSG_STATS(rx_class8_hits, false),
+	ICSSG_STATS(rx_class9_hits, false),
+	ICSSG_STATS(rx_class10_hits, false),
+	ICSSG_STATS(rx_class11_hits, false),
+	ICSSG_STATS(rx_class12_hits, false),
+	ICSSG_STATS(rx_class13_hits, false),
+	ICSSG_STATS(rx_class14_hits, false),
+	ICSSG_STATS(rx_class15_hits, false),
+	ICSSG_STATS(rx_smd_frags, false),
+	ICSSG_STATS(rx_bucket1_size, true),
+	ICSSG_STATS(rx_bucket2_size, true),
+	ICSSG_STATS(rx_bucket3_size, true),
+	ICSSG_STATS(rx_bucket4_size, true),
+	ICSSG_STATS(rx_64B_frames, true),
+	ICSSG_STATS(rx_bucket1_frames, true),
+	ICSSG_STATS(rx_bucket2_frames, true),
+	ICSSG_STATS(rx_bucket3_frames, true),
+	ICSSG_STATS(rx_bucket4_frames, true),
+	ICSSG_STATS(rx_bucket5_frames, true),
+	ICSSG_STATS(rx_bytes, true),
+	ICSSG_STATS(rx_tx_total_bytes, false),
+	/* Tx */
+	ICSSG_STATS(tx_packets, true),
+	ICSSG_STATS(tx_broadcast_frames, false),
+	ICSSG_STATS(tx_multicast_frames, false),
+	ICSSG_STATS(tx_odd_nibble_frames, false),
+	ICSSG_STATS(tx_underflow_errors, false),
+	ICSSG_STATS(tx_frame_max_size, true),
+	ICSSG_STATS(tx_max_size_error_frames, false),
+	ICSSG_STATS(tx_frame_min_size, true),
+	ICSSG_STATS(tx_min_size_error_frames, false),
+	ICSSG_STATS(tx_bucket1_size, true),
+	ICSSG_STATS(tx_bucket2_size, true),
+	ICSSG_STATS(tx_bucket3_size, true),
+	ICSSG_STATS(tx_bucket4_size, true),
+	ICSSG_STATS(tx_64B_frames, true),
+	ICSSG_STATS(tx_bucket1_frames, true),
+	ICSSG_STATS(tx_bucket2_frames, true),
+	ICSSG_STATS(tx_bucket3_frames, true),
+	ICSSG_STATS(tx_bucket4_frames, true),
+	ICSSG_STATS(tx_bucket5_frames, true),
+	ICSSG_STATS(tx_bytes, true),
+};
+
+#endif /* __NET_TI_ICSSG_STATS_H */
-- 
2.34.1

