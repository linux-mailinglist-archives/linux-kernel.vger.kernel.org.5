Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7B776ACA2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjHAJRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjHAJQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:16:54 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F85A26AF;
        Tue,  1 Aug 2023 02:15:52 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3719Eg6N126127;
        Tue, 1 Aug 2023 04:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690881282;
        bh=6VOstsz3UCxzxiDJWRTo/lthIJRQdfEPdFrQeQ4nh3U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xiMFt3WQzUyYmVbUJ65Re7njD0Rqv7Zlk5v27ewD19PQqZnJ94iK6wiq0uuRo4bzj
         ZziLKhJf1W97Co0L2t6PfXA49k1AhH3Fx73oesWVl7dK6OZNoawdvZieqcW641KREL
         kexvGFmavfpAbA0fVmnw8qIXM/c/HoeXEnMSp3jo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3719Egj9110282
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 04:14:42 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 04:14:42 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 04:14:41 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3719Efkd045324;
        Tue, 1 Aug 2023 04:14:41 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3719EfK9015823;
        Tue, 1 Aug 2023 04:14:41 -0500
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
Subject: [PATCH v13 01/10] net: ti: icssg-prueth: Add Firmware Interface for ICSSG Ethernet driver.
Date:   Tue, 1 Aug 2023 14:44:19 +0530
Message-ID: <20230801091428.1359979-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801091428.1359979-1-danishanwar@ti.com>
References: <20230801091428.1359979-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add firmware interface related headers and macros for ICSSG Ethernet
driver. These macros will be later used by the ICSSG ethernet driver.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../net/ethernet/ti/icssg/icssg_switch_map.h  | 234 ++++++++++++++++++
 1 file changed, 234 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switch_map.h

diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
new file mode 100644
index 000000000000..424a7e945ea8
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -0,0 +1,234 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Texas Instruments ICSSG Ethernet driver
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#ifndef __NET_TI_ICSSG_SWITCH_MAP_H
+#define __NET_TI_ICSSG_SWITCH_MAP_H
+
+/************************* Ethernet Switch Constants *********************/
+
+/* if bucket size is changed in firmware then this too should be changed
+ * because it directly impacts FDB ageing calculation
+ */
+#define NUMBER_OF_FDB_BUCKET_ENTRIES            (4)
+
+/* This is fixed in ICSSG */
+#define SIZE_OF_FDB                             (2048)
+
+#define FW_LINK_SPEED_1G                           (0x00)
+#define FW_LINK_SPEED_100M                         (0x01)
+#define FW_LINK_SPEED_10M                          (0x02)
+#define FW_LINK_SPEED_HD                           (0x80)
+
+/* Time after which FDB entries are checked for aged out values.
+ * Values are in nanoseconds
+ */
+#define FDB_AGEING_TIMEOUT_OFFSET                          0x0014
+
+/* Default VLAN tag for Host Port */
+#define HOST_PORT_DF_VLAN_OFFSET                           0x001C
+
+/* Same as HOST_PORT_DF_VLAN_OFFSET */
+#define EMAC_ICSSG_SWITCH_PORT0_DEFAULT_VLAN_OFFSET        HOST_PORT_DF_VLAN_OFFSET
+
+/* Default VLAN tag for P1 Port */
+#define P1_PORT_DF_VLAN_OFFSET                             0x0020
+
+/* Same as P1_PORT_DF_VLAN_OFFSET */
+#define EMAC_ICSSG_SWITCH_PORT1_DEFAULT_VLAN_OFFSET        P1_PORT_DF_VLAN_OFFSET
+
+/* default VLAN tag for P2 Port */
+#define P2_PORT_DF_VLAN_OFFSET                             0x0024
+
+/* Same as P2_PORT_DF_VLAN_OFFSET */
+#define EMAC_ICSSG_SWITCH_PORT2_DEFAULT_VLAN_OFFSET        P2_PORT_DF_VLAN_OFFSET
+
+/* VLAN-FID Table offset. 4096 VIDs. 2B per VID = 8KB = 0x2000 */
+#define VLAN_STATIC_REG_TABLE_OFFSET                       0x0100
+
+/* VLAN-FID Table offset for EMAC  */
+#define EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET        VLAN_STATIC_REG_TABLE_OFFSET
+
+/* Packet descriptor Q reserved memory */
+#define PORT_DESC0_HI                                      0x2104
+
+/* Packet descriptor Q reserved memory */
+#define PORT_DESC0_LO                                      0x2F6C
+
+/* Packet descriptor Q reserved memory */
+#define PORT_DESC1_HI                                      0x3DD4
+
+/* Packet descriptor Q reserved memory */
+#define PORT_DESC1_LO                                      0x4C3C
+
+/* Packet descriptor Q reserved memory */
+#define HOST_DESC0_HI                                      0x5AA4
+
+/* Packet descriptor Q reserved memory */
+#define HOST_DESC0_LO                                      0x5F0C
+
+/* Packet descriptor Q reserved memory */
+#define HOST_DESC1_HI                                      0x6374
+
+/* Packet descriptor Q reserved memory */
+#define HOST_DESC1_LO                                      0x67DC
+
+/* Special packet descriptor Q reserved memory */
+#define HOST_SPPD0                                         0x7AAC
+
+/* Special acket descriptor Q reserved memory */
+#define HOST_SPPD1                                         0x7EAC
+
+/* IEP count cycle counter*/
+#define TIMESYNC_FW_WC_CYCLECOUNT_OFFSET                   0x83EC
+
+/* IEP count hi roll over count */
+#define TIMESYNC_FW_WC_HI_ROLLOVER_COUNT_OFFSET            0x83F4
+
+/* IEP count hi sw counter */
+#define TIMESYNC_FW_WC_COUNT_HI_SW_OFFSET_OFFSET           0x83F8
+
+/* Set clock descriptor */
+#define TIMESYNC_FW_WC_SETCLOCK_DESC_OFFSET                0x83FC
+
+/* IEP count syncout reduction factor */
+#define TIMESYNC_FW_WC_SYNCOUT_REDUCTION_FACTOR_OFFSET     0x843C
+
+/* IEP count syncout reduction counter */
+#define TIMESYNC_FW_WC_SYNCOUT_REDUCTION_COUNT_OFFSET      0x8440
+
+/* IEP count syncout start time cycle counter */
+#define TIMESYNC_FW_WC_SYNCOUT_START_TIME_CYCLECOUNT_OFFSET 0x8444
+
+/* Control variable to generate SYNC1 */
+#define TIMESYNC_FW_WC_ISOM_PIN_SIGNAL_EN_OFFSET           0x844C
+
+/* SystemTime Sync0 periodicity */
+#define TIMESYNC_FW_ST_SYNCOUT_PERIOD_OFFSET               0x8450
+
+/* pktTxDelay for P1 = link speed dependent p1 mac delay + p1 phy delay */
+#define TIMESYNC_FW_WC_PKTTXDELAY_P1_OFFSET                0x8454
+
+/* pktTxDelay for P2 = link speed dependent p2 mac delay + p2 phy delay */
+#define TIMESYNC_FW_WC_PKTTXDELAY_P2_OFFSET                0x8458
+
+/* Set clock operation done signal for next task */
+#define TIMESYNC_FW_SIG_PNFW_OFFSET                        0x845C
+
+/* Set clock operation done signal for next task */
+#define TIMESYNC_FW_SIG_TIMESYNCFW_OFFSET                  0x8460
+
+/* New list is copied at this time */
+#define TAS_CONFIG_CHANGE_TIME                             0x000C
+
+/* config change error counter */
+#define TAS_CONFIG_CHANGE_ERROR_COUNTER                    0x0014
+
+/* TAS List update pending flag */
+#define TAS_CONFIG_PENDING                                 0x0018
+
+/* TAS list update trigger flag */
+#define TAS_CONFIG_CHANGE                                  0x0019
+
+/* List length for new TAS schedule */
+#define TAS_ADMIN_LIST_LENGTH                              0x001A
+
+/* Currently active TAS list index */
+#define TAS_ACTIVE_LIST_INDEX                              0x001B
+
+/* Cycle time for the new TAS schedule */
+#define TAS_ADMIN_CYCLE_TIME                               0x001C
+
+/* Cycle counts remaining till the TAS list update */
+#define TAS_CONFIG_CHANGE_CYCLE_COUNT                      0x0020
+
+/* Base Flow ID for sending  Packets to Host for Slice0 */
+#define PSI_L_REGULAR_FLOW_ID_BASE_OFFSET                  0x0024
+
+/* Same as PSI_L_REGULAR_FLOW_ID_BASE_OFFSET */
+#define EMAC_ICSSG_SWITCH_PSI_L_REGULAR_FLOW_ID_BASE_OFFSET PSI_L_REGULAR_FLOW_ID_BASE_OFFSET
+
+/* Base Flow ID for sending mgmt and Tx TS to Host for Slice0 */
+#define PSI_L_MGMT_FLOW_ID_OFFSET                          0x0026
+
+/* Same as PSI_L_MGMT_FLOW_ID_OFFSET */
+#define EMAC_ICSSG_SWITCH_PSI_L_MGMT_FLOW_ID_BASE_OFFSET   PSI_L_MGMT_FLOW_ID_OFFSET
+
+/* Queue number for Special  Packets written here */
+#define SPL_PKT_DEFAULT_PRIORITY                           0x0028
+
+/* Express Preemptible Queue Mask */
+#define EXPRESS_PRE_EMPTIVE_Q_MASK                         0x0029
+
+/* Port1/Port2 Default Queue number for untagged  Packets, only 1B is used */
+#define QUEUE_NUM_UNTAGGED                                 0x002A
+
+/* Stores the table used for priority regeneration. 1B per PCP/Queue */
+#define PORT_Q_PRIORITY_REGEN_OFFSET                       0x002C
+
+/* For marking Packet as priority/express (this feature is disabled) or
+ * cut-through/S&F.
+ */
+#define EXPRESS_PRE_EMPTIVE_Q_MAP                          0x0034
+
+/* Stores the table used for priority mapping. 1B per PCP/Queue */
+#define PORT_Q_PRIORITY_MAPPING_OFFSET                     0x003C
+
+/* Used to notify the FW of the current link speed */
+#define PORT_LINK_SPEED_OFFSET                             0x00A8
+
+/* TAS gate mask for windows list0 */
+#define TAS_GATE_MASK_LIST0                                0x0100
+
+/* TAS gate mask for windows list1 */
+#define TAS_GATE_MASK_LIST1                                0x0350
+
+/* Memory to Enable/Disable Preemption on TX side */
+#define PRE_EMPTION_ENABLE_TX                              0x05A0
+
+/* Active State of Preemption on TX side */
+#define PRE_EMPTION_ACTIVE_TX                              0x05A1
+
+/* Memory to Enable/Disable Verify State Machine Preemption */
+#define PRE_EMPTION_ENABLE_VERIFY                          0x05A2
+
+/* Verify Status of State Machine */
+#define PRE_EMPTION_VERIFY_STATUS                          0x05A3
+
+/* Non Final Fragment Size supported by Link Partner */
+#define PRE_EMPTION_ADD_FRAG_SIZE_REMOTE                   0x05A4
+
+/* Non Final Fragment Size supported by Firmware */
+#define PRE_EMPTION_ADD_FRAG_SIZE_LOCAL                    0x05A6
+
+/* Time in ms the State machine waits for respond Packet */
+#define PRE_EMPTION_VERIFY_TIME                            0x05A8
+
+/* Memory used for R30 related management commands */
+#define MGR_R30_CMD_OFFSET                                 0x05AC
+
+/* HW Buffer Pool0 base address */
+#define BUFFER_POOL_0_ADDR_OFFSET                          0x05BC
+
+/* 16B for Host Egress MSMC Q (Pre-emptible) context */
+#define HOST_RX_Q_PRE_CONTEXT_OFFSET                       0x0684
+
+/* Buffer for 8 FDB entries to be added by 'Add Multiple FDB entries IOCTL' */
+#define FDB_CMD_BUFFER                                     0x0894
+
+/* TAS queue max sdu length list */
+#define TAS_QUEUE_MAX_SDU_LIST                             0x08FA
+
+/* Used by FW to generate random number with the SEED value */
+#define HD_RAND_SEED_OFFSET                                0x0934
+
+/* 16B for Host Egress MSMC Q (Express) context */
+#define HOST_RX_Q_EXP_CONTEXT_OFFSET                       0x0940
+
+/* Start of 32 bits PA_STAT counters */
+#define PA_STAT_32b_START_OFFSET                           0x0080
+
+#endif /* __NET_TI_ICSSG_SWITCH_MAP_H  */
-- 
2.34.1

