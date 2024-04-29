Return-Path: <linux-kernel+bounces-162057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C798B555D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76401F22F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5572E852;
	Mon, 29 Apr 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iW68jbTE"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4FA3D64;
	Mon, 29 Apr 2024 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386674; cv=none; b=WXCeHsmlHfofNmUOMLfbE7QzH3OekhcpsN9nB9lfADYHg4Tlk8ZxEdwvRoTtwVAZ1w16M2SyErQq93H3dJDQDb1kH+AZju5obFPEP7G/AN+2sEYLEqzkVVvUP2NNcrC7zECOmXolo0lQtGpNYNrqEADZO3KQus8xwIneuRDsQKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386674; c=relaxed/simple;
	bh=zrQsoy/7amJzXo21H4drlDiAjvG9OV8HjqnUXrHHh5c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YXKE44gvrQLvAAwx8wi4rHxpFPmxeN8K0cn1ywFJvDITiiiuyiEigrFUj1mVpJntlIHoCum8E48s5/lyS3axNwfyH3oXdGi7lK6x5rUyF0lCy7iLeQyjdrlZBwQiMzYsWkt39J92iI1yxsKlhG7oPKO0whTJjjK3DL78FGXZbLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iW68jbTE; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43TAUQJJ000611;
	Mon, 29 Apr 2024 05:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714386626;
	bh=VtQxS2hr8zAzjfTE7JbqIMUjwm0Bp5Vtjayy/GvYz78=;
	h=From:To:CC:Subject:Date;
	b=iW68jbTEPCidbMCo3qPT2loANohRymSBkfeP+PMguAUxcZdL2ieQ9Zc+/Jj+yOGux
	 Mta0erLajkyIQW1BVTabfGcK05bW3snwJCsgWaqYFh9GoOeAhxk50m+yo036gdQYQP
	 dY3h/94spp9mi9mPrw9b9Ej4kVrItDeus8aUQxCs=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43TAUQhK065381
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 05:30:26 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 05:30:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 05:30:25 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43TAUPgb129218;
	Mon, 29 Apr 2024 05:30:25 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43TAUOO1015710;
	Mon, 29 Apr 2024 05:30:25 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
        Jan Kiszka <jan.kiszka@siemens.com>, Simon Horman <horms@kernel.org>,
        Niklas
 Schnelle <schnelle@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Roger Quadros
	<rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>, Paolo Abeni
	<pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger
 Quadros <rogerq@ti.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH net-next v5] net: ti: icssg_prueth: add TAPRIO offload support
Date: Mon, 29 Apr 2024 16:00:22 +0530
Message-ID: <20240429103022.808161-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Roger Quadros <rogerq@ti.com>

ICSSG dual-emac f/w supports Enhanced Scheduled Traffic (EST – defined
in P802.1Qbv/D2.2 that later got included in IEEE 802.1Q-2018)
configuration. EST allows express queue traffic to be scheduled
(placed) on the wire at specific repeatable time intervals. In
Linux kernel, EST configuration is done through tc command and
the taprio scheduler in the net core implements a software only
scheduler (SCH_TAPRIO). If the NIC is capable of EST configuration,
user indicate "flag 2" in the command which is then parsed by
taprio scheduler in net core and indicate that the command is to
be offloaded to h/w. taprio then offloads the command to the
driver by calling ndo_setup_tc() ndo ops. This patch implements
ndo_setup_tc() to offload EST configuration to ICSSG.

Also move icss_iep structure and it's dependencies to icss_iep.h in
order to access iep->def_inc from driver files.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Cc: Roger Quadros <rogerq@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>

Changes from v4 to v5:
*) Rebased on latest net-next/main [commit 5c4c0edca68a]
*) Moved icss_iep structure to icss_iep.h file so that iep wraparound time
   which is stored in iep->def_inc, can be accessed by qos file.
*) Added comment about IEP wraparound time compensation in icssg_qos.c
*) Moved icssg_qos_tas_init() to prueth_netdev_init() so that icssg_qos_tas_init()
   gets called even if interface is down.
*) Fixed print statements as suggested by Vladimir Oltean <vladimir.oltean@nxp.com>
*) Added taprio_offload_get() and taprio_offload_free() in emac_taprio_replace()
   and emac_taprio_destory() respectively.

Changes from v3 to v4:
*) Rebased on the latest next-20231005 linux-next.
*) Addressed Roger and Vinicius' comments and moved all the validations to
   emac_taprio_replace() API.
*) Modified emac_setup_taprio() API to use switch case based on taprio->cmd
   and added emac_taprio_destroy() and emac_taprio_replace() APIs.
*) Modified the documentation of structs / enums in icssg_qos.h by using
   the correct kdoc format.

Changes from v2 to v3:
*) Rebased on the latest next-20230928 linux-next.
*) Retained original authorship of the patch.
*) Addressed Roger's comments and modified emac_setup_taprio() and
   emac_set_taprio() APIs accordingly.
*) Removed netif_running() check from emac_setup_taprio().
*) Addressed Vinicius' comments and added check for MIN and MAX cycle time.
*) Added check for allocation failure of est_new in emac_setup_taprio().

Changes from v1 to v2:
*) Rebased on the latest next-20230921 linux-next.
*) Dropped the RFC tag as merge window is open now.
*) Splitted this patch from the switch mode series [v1].
*) Removed TODO comment as asked by Andrew and Roger.
*) Changed Copyright to 2023 as asked by Roger.

v4: https://lore.kernel.org/all/20231006102028.3831341-1-danishanwar@ti.com/
v3: https://lore.kernel.org/all/20230928103000.186304-1-danishanwar@ti.com/
v2: https://lore.kernel.org/all/20230921070031.795788-1-danishanwar@ti.com/
v1: https://lore.kernel.org/all/20230830110847.1219515-1-danishanwar@ti.com/

 drivers/net/ethernet/ti/Kconfig              |   1 +
 drivers/net/ethernet/ti/Makefile             |   3 +-
 drivers/net/ethernet/ti/icssg/icss_iep.c     |  72 -----
 drivers/net/ethernet/ti/icssg/icss_iep.h     |  73 ++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |   5 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   5 +
 drivers/net/ethernet/ti/icssg/icssg_qos.c    | 293 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h    | 113 +++++++
 8 files changed, 490 insertions(+), 75 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 1729eb0e0b41..3716d585f9a3 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -190,6 +190,7 @@ config TI_ICSSG_PRUETH
 	depends on PRU_REMOTEPROC
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on NET_SCH_TAPRIO
 	help
 	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
 	  This subsystem is available starting with the AM65 platform.
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 6e086b4c0384..28e794a8ecd1 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -39,7 +39,8 @@ icssg-prueth-y := icssg/icssg_prueth.o \
 		  icssg/icssg_config.o \
 		  icssg/icssg_mii_cfg.o \
 		  icssg/icssg_stats.o \
-		  icssg/icssg_ethtool.o
+		  icssg/icssg_ethtool.o \
+		  icssg/icssg_qos.o
 obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += icssg-prueth-sr1.o
 icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o \
 		      icssg/icssg_common.o \
diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 3025e9c18970..915cd4fda53c 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -52,78 +52,6 @@
 #define IEP_CAP_CFG_CAPNR_1ST_EVENT_EN(n)	BIT(LATCH_INDEX(n))
 #define IEP_CAP_CFG_CAP_ASYNC_EN(n)		BIT(LATCH_INDEX(n) + 10)
 
-enum {
-	ICSS_IEP_GLOBAL_CFG_REG,
-	ICSS_IEP_GLOBAL_STATUS_REG,
-	ICSS_IEP_COMPEN_REG,
-	ICSS_IEP_SLOW_COMPEN_REG,
-	ICSS_IEP_COUNT_REG0,
-	ICSS_IEP_COUNT_REG1,
-	ICSS_IEP_CAPTURE_CFG_REG,
-	ICSS_IEP_CAPTURE_STAT_REG,
-
-	ICSS_IEP_CAP6_RISE_REG0,
-	ICSS_IEP_CAP6_RISE_REG1,
-
-	ICSS_IEP_CAP7_RISE_REG0,
-	ICSS_IEP_CAP7_RISE_REG1,
-
-	ICSS_IEP_CMP_CFG_REG,
-	ICSS_IEP_CMP_STAT_REG,
-	ICSS_IEP_CMP0_REG0,
-	ICSS_IEP_CMP0_REG1,
-	ICSS_IEP_CMP1_REG0,
-	ICSS_IEP_CMP1_REG1,
-
-	ICSS_IEP_CMP8_REG0,
-	ICSS_IEP_CMP8_REG1,
-	ICSS_IEP_SYNC_CTRL_REG,
-	ICSS_IEP_SYNC0_STAT_REG,
-	ICSS_IEP_SYNC1_STAT_REG,
-	ICSS_IEP_SYNC_PWIDTH_REG,
-	ICSS_IEP_SYNC0_PERIOD_REG,
-	ICSS_IEP_SYNC1_DELAY_REG,
-	ICSS_IEP_SYNC_START_REG,
-	ICSS_IEP_MAX_REGS,
-};
-
-/**
- * struct icss_iep_plat_data - Plat data to handle SoC variants
- * @config: Regmap configuration data
- * @reg_offs: register offsets to capture offset differences across SoCs
- * @flags: Flags to represent IEP properties
- */
-struct icss_iep_plat_data {
-	struct regmap_config *config;
-	u32 reg_offs[ICSS_IEP_MAX_REGS];
-	u32 flags;
-};
-
-struct icss_iep {
-	struct device *dev;
-	void __iomem *base;
-	const struct icss_iep_plat_data *plat_data;
-	struct regmap *map;
-	struct device_node *client_np;
-	unsigned long refclk_freq;
-	int clk_tick_time;	/* one refclk tick time in ns */
-	struct ptp_clock_info ptp_info;
-	struct ptp_clock *ptp_clock;
-	struct mutex ptp_clk_mutex;	/* PHC access serializer */
-	spinlock_t irq_lock; /* CMP IRQ vs icss_iep_ptp_enable access */
-	u32 def_inc;
-	s16 slow_cmp_inc;
-	u32 slow_cmp_count;
-	const struct icss_iep_clockops *ops;
-	void *clockops_data;
-	u32 cycle_time_ns;
-	u32 perout_enabled;
-	bool pps_enabled;
-	int cap_cmp_irq;
-	u64 period;
-	u32 latch_enable;
-};
-
 /**
  * icss_iep_get_count_hi() - Get the upper 32 bit IEP counter
  * @iep: Pointer to structure representing IEP.
diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.h b/drivers/net/ethernet/ti/icssg/icss_iep.h
index 803a4b714893..ca84bfc56185 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.h
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.h
@@ -12,7 +12,78 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/regmap.h>
 
-struct icss_iep;
+enum {
+	ICSS_IEP_GLOBAL_CFG_REG,
+	ICSS_IEP_GLOBAL_STATUS_REG,
+	ICSS_IEP_COMPEN_REG,
+	ICSS_IEP_SLOW_COMPEN_REG,
+	ICSS_IEP_COUNT_REG0,
+	ICSS_IEP_COUNT_REG1,
+	ICSS_IEP_CAPTURE_CFG_REG,
+	ICSS_IEP_CAPTURE_STAT_REG,
+
+	ICSS_IEP_CAP6_RISE_REG0,
+	ICSS_IEP_CAP6_RISE_REG1,
+
+	ICSS_IEP_CAP7_RISE_REG0,
+	ICSS_IEP_CAP7_RISE_REG1,
+
+	ICSS_IEP_CMP_CFG_REG,
+	ICSS_IEP_CMP_STAT_REG,
+	ICSS_IEP_CMP0_REG0,
+	ICSS_IEP_CMP0_REG1,
+	ICSS_IEP_CMP1_REG0,
+	ICSS_IEP_CMP1_REG1,
+
+	ICSS_IEP_CMP8_REG0,
+	ICSS_IEP_CMP8_REG1,
+	ICSS_IEP_SYNC_CTRL_REG,
+	ICSS_IEP_SYNC0_STAT_REG,
+	ICSS_IEP_SYNC1_STAT_REG,
+	ICSS_IEP_SYNC_PWIDTH_REG,
+	ICSS_IEP_SYNC0_PERIOD_REG,
+	ICSS_IEP_SYNC1_DELAY_REG,
+	ICSS_IEP_SYNC_START_REG,
+	ICSS_IEP_MAX_REGS,
+};
+
+/**
+ * struct icss_iep_plat_data - Plat data to handle SoC variants
+ * @config: Regmap configuration data
+ * @reg_offs: register offsets to capture offset differences across SoCs
+ * @flags: Flags to represent IEP properties
+ */
+struct icss_iep_plat_data {
+	struct regmap_config *config;
+	u32 reg_offs[ICSS_IEP_MAX_REGS];
+	u32 flags;
+};
+
+struct icss_iep {
+	struct device *dev;
+	void __iomem *base;
+	const struct icss_iep_plat_data *plat_data;
+	struct regmap *map;
+	struct device_node *client_np;
+	unsigned long refclk_freq;
+	int clk_tick_time;	/* one refclk tick time in ns */
+	struct ptp_clock_info ptp_info;
+	struct ptp_clock *ptp_clock;
+	struct mutex ptp_clk_mutex;	/* PHC access serializer */
+	spinlock_t irq_lock; /* CMP IRQ vs icss_iep_ptp_enable access */
+	u32 def_inc;
+	s16 slow_cmp_inc;
+	u32 slow_cmp_count;
+	const struct icss_iep_clockops *ops;
+	void *clockops_data;
+	u32 cycle_time_ns;
+	u32 perout_enabled;
+	bool pps_enabled;
+	int cap_cmp_irq;
+	u64 period;
+	u32 latch_enable;
+};
+
 extern const struct icss_iep_clockops prueth_iep_clockops;
 
 /* Firmware specific clock operations */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 186b0365c2e5..e4c2eed1e12a 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -274,7 +274,7 @@ static int emac_phy_connect(struct prueth_emac *emac)
 	return 0;
 }
 
-static u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
+u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
 {
 	u32 hi_rollover_count, hi_rollover_count_r;
 	struct prueth_emac *emac = clockops_data;
@@ -672,6 +672,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_eth_ioctl = emac_ndo_ioctl,
 	.ndo_get_stats64 = emac_ndo_get_stats64,
 	.ndo_get_phys_port_name = emac_ndo_get_phys_port_name,
+	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -803,6 +804,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 	netif_napi_add(ndev, &emac->napi_rx, emac_napi_rx_poll);
 	prueth->emac[mac] = emac;
 
+	icssg_qos_tas_init(ndev);
+
 	return 0;
 
 free:
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 82e38ef5635b..5ed5fa7c49bd 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -37,6 +37,7 @@
 #include "icssg_config.h"
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
+#include "icssg_qos.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
@@ -181,6 +182,8 @@ struct prueth_emac {
 
 	struct pruss_mem_region dram;
 
+	struct prueth_qos qos;
+
 	struct delayed_work stats_work;
 	u64 stats[ICSSG_NUM_STATS];
 };
@@ -311,6 +314,8 @@ void emac_stats_work_handler(struct work_struct *work);
 void emac_update_hardware_stats(struct prueth_emac *emac);
 int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
 
+u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts);
+
 /* Common functions */
 void prueth_cleanup_rx_chns(struct prueth_emac *emac,
 			    struct prueth_rx_chn *rx_chn,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
new file mode 100644
index 000000000000..459463ea6c20
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSG PRUETH QoS submodule
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include <linux/printk.h>
+#include "icssg_prueth.h"
+#include "icssg_switch_map.h"
+
+static void tas_update_fw_list_pointers(struct prueth_emac *emac)
+{
+	struct tas_config *tas = &emac->qos.tas.config;
+
+	if ((readb(tas->active_list)) == TAS_LIST0) {
+		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST0;
+		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST1;
+	} else {
+		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST1;
+		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST0;
+	}
+}
+
+static void tas_update_maxsdu_table(struct prueth_emac *emac)
+{
+	struct tas_config *tas = &emac->qos.tas.config;
+	u16 __iomem *max_sdu_tbl_ptr;
+	u8 gate_idx;
+
+	/* update the maxsdu table */
+	max_sdu_tbl_ptr = emac->dram.va + TAS_QUEUE_MAX_SDU_LIST;
+
+	for (gate_idx = 0; gate_idx < TAS_MAX_NUM_QUEUES; gate_idx++)
+		writew(tas->max_sdu_table.max_sdu[gate_idx], &max_sdu_tbl_ptr[gate_idx]);
+}
+
+static void tas_reset(struct prueth_emac *emac)
+{
+	struct tas_config *tas = &emac->qos.tas.config;
+	int i;
+
+	for (i = 0; i < TAS_MAX_NUM_QUEUES; i++)
+		tas->max_sdu_table.max_sdu[i] = 2048;
+
+	tas_update_maxsdu_table(emac);
+
+	writeb(TAS_LIST0, tas->active_list);
+
+	memset_io(tas->fw_active_list, 0, sizeof(*tas->fw_active_list));
+	memset_io(tas->fw_shadow_list, 0, sizeof(*tas->fw_shadow_list));
+}
+
+static int tas_set_state(struct prueth_emac *emac, enum tas_state state)
+{
+	struct tas_config *tas = &emac->qos.tas.config;
+	int ret;
+
+	if (tas->state == state)
+		return 0;
+
+	switch (state) {
+	case TAS_STATE_RESET:
+		tas_reset(emac);
+		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_RESET);
+		tas->state = TAS_STATE_RESET;
+		break;
+	case TAS_STATE_ENABLE:
+		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_ENABLE);
+		tas->state = TAS_STATE_ENABLE;
+		break;
+	case TAS_STATE_DISABLE:
+		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_DISABLE);
+		tas->state = TAS_STATE_DISABLE;
+		break;
+	default:
+		netdev_err(emac->ndev, "%s: unsupported state\n", __func__);
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret)
+		netdev_err(emac->ndev, "TAS set state failed %d\n", ret);
+	return ret;
+}
+
+static int tas_set_trigger_list_change(struct prueth_emac *emac)
+{
+	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
+	struct tas_config *tas = &emac->qos.tas.config;
+	struct ptp_system_timestamp sts;
+	u32 change_cycle_count;
+	u32 cycle_time;
+	u64 base_time;
+	u64 cur_time;
+
+	/* IEP clock has a hardware errata due to which it wraps around exactly
+	 * once every taprio cycle. To compensate for that, adjust cycle time
+	 * by the wrap around time which is stored in emac->iep->def_inc
+	 */
+	cycle_time = admin_list->cycle_time - emac->iep->def_inc;
+	base_time = admin_list->base_time;
+	cur_time = prueth_iep_gettime(emac, &sts);
+
+	if (base_time > cur_time)
+		change_cycle_count = DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time);
+	else
+		change_cycle_count = 1;
+
+	writel(cycle_time, emac->dram.va + TAS_ADMIN_CYCLE_TIME);
+	writel(change_cycle_count, emac->dram.va + TAS_CONFIG_CHANGE_CYCLE_COUNT);
+	writeb(admin_list->num_entries, emac->dram.va + TAS_ADMIN_LIST_LENGTH);
+
+	/* config_change cleared by f/w to ack reception of new shadow list */
+	writeb(1, &tas->config_list->config_change);
+	/* config_pending cleared by f/w when new shadow list is copied to active list */
+	writeb(1, &tas->config_list->config_pending);
+
+	return emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);
+}
+
+static int tas_update_oper_list(struct prueth_emac *emac)
+{
+	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
+	struct tas_config *tas = &emac->qos.tas.config;
+	u32 tas_acc_gate_close_time = 0;
+	u8 idx, gate_idx, val;
+	int ret;
+
+	if (admin_list->cycle_time > TAS_MAX_CYCLE_TIME)
+		return -EINVAL;
+
+	tas_update_fw_list_pointers(emac);
+
+	for (idx = 0; idx < admin_list->num_entries; idx++) {
+		writeb(admin_list->entries[idx].gate_mask,
+		       &tas->fw_shadow_list->gate_mask_list[idx]);
+		tas_acc_gate_close_time += admin_list->entries[idx].interval;
+
+		/* extend last entry till end of cycle time */
+		if (idx == admin_list->num_entries - 1)
+			writel(admin_list->cycle_time,
+			       &tas->fw_shadow_list->win_end_time_list[idx]);
+		else
+			writel(tas_acc_gate_close_time,
+			       &tas->fw_shadow_list->win_end_time_list[idx]);
+	}
+
+	/* clear remaining entries */
+	for (idx = admin_list->num_entries; idx < TAS_MAX_CMD_LISTS; idx++) {
+		writeb(0, &tas->fw_shadow_list->gate_mask_list[idx]);
+		writel(0, &tas->fw_shadow_list->win_end_time_list[idx]);
+	}
+
+	/* update the Array of gate close time for each queue in each window */
+	for (idx = 0 ; idx < admin_list->num_entries; idx++) {
+		/* On Linux, only PRUETH_MAX_TX_QUEUES are supported per port */
+		for (gate_idx = 0; gate_idx < PRUETH_MAX_TX_QUEUES; gate_idx++) {
+			u8 gate_mask_list_idx = readb(&tas->fw_shadow_list->gate_mask_list[idx]);
+			u32 gate_close_time = 0;
+
+			if (gate_mask_list_idx & BIT(gate_idx))
+				gate_close_time = readl(&tas->fw_shadow_list->win_end_time_list[idx]);
+
+			writel(gate_close_time,
+			       &tas->fw_shadow_list->gate_close_time_list[idx][gate_idx]);
+		}
+	}
+
+	/* tell f/w to swap active & shadow list */
+	ret = tas_set_trigger_list_change(emac);
+	if (ret) {
+		netdev_err(emac->ndev, "failed to swap f/w config list: %d\n", ret);
+		return ret;
+	}
+
+	/* Wait for completion */
+	ret = readb_poll_timeout(&tas->config_list->config_change, val, !val,
+				 USEC_PER_MSEC, 10 * USEC_PER_MSEC);
+	if (ret) {
+		netdev_err(emac->ndev, "TAS list change completion time out\n");
+		return ret;
+	}
+
+	tas_update_fw_list_pointers(emac);
+
+	return 0;
+}
+
+static int emac_taprio_replace(struct net_device *ndev,
+			       struct tc_taprio_qopt_offload *taprio)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct tc_taprio_qopt_offload *est_new;
+	int ret;
+
+	if (taprio->cycle_time_extension) {
+		NL_SET_ERR_MSG_MOD(taprio->extack, "Cycle time extension not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (taprio->cycle_time < TAS_MIN_CYCLE_TIME) {
+		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "cycle_time %llu is less than min supported cycle_time %d",
+				       taprio->cycle_time, TAS_MIN_CYCLE_TIME);
+		return -EINVAL;
+	}
+
+	if (taprio->num_entries > TAS_MAX_CMD_LISTS) {
+		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "num_entries %lu is more than max supported entries %d",
+				       taprio->num_entries, TAS_MAX_CMD_LISTS);
+		return -EINVAL;
+	}
+
+	if (emac->qos.tas.taprio_admin)
+		devm_kfree(&ndev->dev, emac->qos.tas.taprio_admin);
+
+	est_new = devm_kzalloc(&ndev->dev,
+			       struct_size(est_new, entries, taprio->num_entries),
+			       GFP_KERNEL);
+	if (!est_new)
+		return -ENOMEM;
+
+	emac->qos.tas.taprio_admin = taprio_offload_get(taprio);
+	ret = tas_update_oper_list(emac);
+	if (ret)
+		return ret;
+
+	ret = tas_set_state(emac, TAS_STATE_ENABLE);
+	if (ret) {
+		emac->qos.tas.taprio_admin = NULL;
+		taprio_offload_free(taprio);
+	}
+
+	return ret;
+}
+
+static int emac_taprio_destroy(struct net_device *ndev,
+			       struct tc_taprio_qopt_offload *taprio)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int ret;
+
+	taprio_offload_free(taprio);
+
+	ret = tas_set_state(emac, TAS_STATE_RESET);
+	if (ret)
+		return ret;
+
+	return tas_set_state(emac, TAS_STATE_DISABLE);
+}
+
+static int emac_setup_taprio(struct net_device *ndev, void *type_data)
+{
+	struct tc_taprio_qopt_offload *taprio = type_data;
+	int ret;
+
+	switch (taprio->cmd) {
+	case TAPRIO_CMD_REPLACE:
+		ret = emac_taprio_replace(ndev, taprio);
+		break;
+	case TAPRIO_CMD_DESTROY:
+		ret = emac_taprio_destroy(ndev, taprio);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data)
+{
+	switch (type) {
+	case TC_SETUP_QDISC_TAPRIO:
+		return emac_setup_taprio(ndev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+void icssg_qos_tas_init(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct tas_config *tas;
+
+	tas = &emac->qos.tas.config;
+
+	tas->config_list = emac->dram.va + TAS_CONFIG_CHANGE_TIME;
+	tas->active_list = emac->dram.va + TAS_ACTIVE_LIST_INDEX;
+
+	tas_update_fw_list_pointers(emac);
+
+	tas_set_state(emac, TAS_STATE_RESET);
+}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
new file mode 100644
index 000000000000..25baccdd1ce5
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#ifndef __NET_TI_ICSSG_QOS_H
+#define __NET_TI_ICSSG_QOS_H
+
+#include <linux/atomic.h>
+#include <linux/netdevice.h>
+#include <net/pkt_sched.h>
+
+/* Maximum number of gate command entries in each list. */
+#define TAS_MAX_CMD_LISTS   (16)
+
+/* Maximum number of transmit queues supported by implementation */
+#define TAS_MAX_NUM_QUEUES  (8)
+
+/* Minimum cycle time supported by implementation (in ns) */
+#define TAS_MIN_CYCLE_TIME  (1000000)
+
+/* Minimum cycle time supported by implementation (in ns) */
+#define TAS_MAX_CYCLE_TIME  (4000000000)
+
+/* Minimum TAS window duration supported by implementation (in ns) */
+#define TAS_MIN_WINDOW_DURATION  (10000)
+
+/**
+ * enum tas_list_num - TAS list number
+ * @TAS_LIST0: TAS list number is 0
+ * @TAS_LIST1: TAS list number is 1
+ */
+enum tas_list_num {
+	TAS_LIST0 = 0,
+	TAS_LIST1 = 1
+};
+
+/**
+ * enum tas_state - State of TAS in firmware
+ * @TAS_STATE_DISABLE: TAS state machine is disabled.
+ * @TAS_STATE_ENABLE: TAS state machine is enabled.
+ * @TAS_STATE_RESET: TAS state machine is reset.
+ */
+enum tas_state {
+	TAS_STATE_DISABLE = 0,
+	TAS_STATE_ENABLE = 1,
+	TAS_STATE_RESET = 2,
+};
+
+/**
+ * struct tas_config_list - Config state machine variables
+ * @config_change_time: New list is copied at this time
+ * @config_change_error_counter: Incremented if admin->BaseTime < current time
+ *				 and TAS_enabled is true
+ * @config_pending: True if list update is pending
+ * @config_change: Set to true when application trigger updating of admin list
+ *		   to active list, cleared when configChangeTime is updated
+ */
+struct tas_config_list {
+	u64 config_change_time;
+	u32 config_change_error_counter;
+	u8 config_pending;
+	u8 config_change;
+};
+
+/* Max SDU table. See IEEE Std 802.1Q-2018 12.29.1.1 */
+struct tas_max_sdu_table {
+	u16 max_sdu[TAS_MAX_NUM_QUEUES];
+};
+
+/**
+ * struct tas_firmware_list - TAS List Structure based on firmware memory map
+ * @gate_mask_list: Window gate mask list
+ * @win_end_time_list: Window end time list
+ * @gate_close_time_list: Array of gate close time for each queue in each window
+ */
+struct tas_firmware_list {
+	u8 gate_mask_list[TAS_MAX_CMD_LISTS];
+	u32 win_end_time_list[TAS_MAX_CMD_LISTS];
+	u32 gate_close_time_list[TAS_MAX_CMD_LISTS][TAS_MAX_NUM_QUEUES];
+};
+
+/**
+ * struct tas_config - Main Time Aware Shaper Handle
+ * @state: TAS state
+ * @max_sdu_table: Max SDU table
+ * @config_list: Config change variables
+ * @active_list: Current operating list operating list
+ * @fw_active_list: Active List pointer, used by firmware
+ * @fw_shadow_list: Shadow List pointer, used by driver
+ */
+struct tas_config {
+	enum tas_state state;
+	struct tas_max_sdu_table max_sdu_table;
+	struct tas_config_list __iomem *config_list;
+	u8 __iomem *active_list;
+	struct tas_firmware_list __iomem *fw_active_list;
+	struct tas_firmware_list __iomem *fw_shadow_list;
+};
+
+struct prueth_qos_tas {
+	struct tc_taprio_qopt_offload *taprio_admin;
+	struct tc_taprio_qopt_offload *taprio_oper;
+	struct tas_config config;
+};
+
+struct prueth_qos {
+	struct prueth_qos_tas tas;
+};
+
+void icssg_qos_tas_init(struct net_device *ndev);
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data);
+#endif /* __NET_TI_ICSSG_QOS_H */

base-commit: 5c4c0edca68a5841a8d53ccd49596fe199c8334c
-- 
2.34.1


