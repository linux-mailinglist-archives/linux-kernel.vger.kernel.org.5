Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4D27CC1CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbjJQLci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjJQLcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:32:36 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F9BEA;
        Tue, 17 Oct 2023 04:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGBZuPlIkWr9qPWfeMSh7exFu9S1PCEzCrIiwfVtRH5XYdO5WLB44+uOroT8E3bEabmJtE+Yuvul6JDR/W6B8POjo2n0kXzJiKUXfcdT4oueazoslR0RaP3af7BWXjl+7d04ki3xpT1N+8Ii2ir+N6dhie5+efTz7GN3G5cE6QRNIYzdf5sWg7UxQFqzXimYyEMSGc8nu8Xf0ScaMytOvNIoErDr5VZgoEEqm8D2VNLRctkGOxvMKWk0wHWNKhEkMfLm7TugbWiI5iV8tnA3NzKQakrRPTMQZgdq2Y0XLmkijIBDV9KkNIlLpYPKQ3sVQ+4T/7ct0jt6ty5YRbiMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50ZinWRDi0hsKrUkozc8pJbrOTYGLAhOG7dmbSaSZ3c=;
 b=FFATFylWtjo0bnlWHVhu4pFvGHg7EAZ04Ke03LCHggOyhLgpfI2Wg1PvS0MU+AcURyqo2UjejLB91112pSf7TRZTDS+1Mq4T5kDp4oXzTIMC/IV6Lw+aaFyUm7gmXVUOBG2WuprFL5vJpK9tYOc/mnmZYHYfb6gSat6n61hNK7nhH3iV95MghMdoseM0Cn+ZpYW26C2bkEeWmBk+4G2LrzW6Yl1GgB3Py69gGJSpg8/DESUnuDqQc4AUeDs2mp3jXnc47Qv3O3wZ+iqR+7U4nh1SMyTNZT5lzS3MEjqrdX5FTu3EdtijQCRCJrxTAs3g1Lv/D8+wbNKE4yPE/Y+9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50ZinWRDi0hsKrUkozc8pJbrOTYGLAhOG7dmbSaSZ3c=;
 b=ZNj1KXoudWxdLUwnchVoMPFgnUxJaLJKIuWbzg2O0/BOxEGrblhaVoHVeQfZCW4p2oV/tedjFTtfhvT2X/uoD7DbTdZqGe7DYCS0xZdO9HsedBTQXZ31GQHEksfu8Jul+c51ZzYRuMCkG3xpB03J7BYrZZFiGzAFQVVUTrskdOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB7720.eurprd04.prod.outlook.com (2603:10a6:20b:299::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 11:32:32 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 11:32:32 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: mdio-mux: fix C45 access returning -EIO after API change
Date:   Tue, 17 Oct 2023 14:32:22 +0300
Message-Id: <20231017113222.3135895-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0048.eurprd04.prod.outlook.com
 (2603:10a6:208:1::25) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 63cede20-f198-4f8f-8fa6-08dbcf04c072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUFW6Vzo5a8qrTkbRHe/5Chs9RiRNs2aHOL6H7fckxJTqOT00o/T/XBZkUNBL7Xo/HIo4m29JtoJjsOW4LxKOe6nhvZ6fH+x375Ak290m2Aiqy8Zr3Wv603ewuab2KPZ7P+ytwxga6oVsr9/+9vMaQwjZ51RB1RmvsI9Rtr3/diFjzSg94W7MoPhtriTkKQyFGlTKtebKgoGzV9uUsAxXHvuculbUe7JnX+5c7BsHtJ0vyn22kbQybzVrB7pWRmouInnGhQTuP5VWQ+wljuTlQHbKTMAgpfsrWPTWJuTnr38jvZGcu4HgBqntkQiOpopr/APRGWuBpuJyR/ANnBVLXFpMb7qgT6t96HZR7IH0tTRCXA9tLpVYkw4VMqXAvzCgxmxFUyQuQyVyB5aWR32MSTskcu6+qpBnGjkUBuXlVYLmj3FYzWxDbK4+AXn0hB9NUSbGNMv3jVn3JcRpjvQ/8xm56iF3XXx4uoov6IIolH+AFCBts1Q+8FqfTxKYYam3d7zZwL6+vlYHC9OScg3jrbDd4a8qDUGSnMlnw9QkisMSQ04tQ/GyEf4iEXP7L3MxJ6+nrvrTaJZAEb+/Fr1OJF6jejAhrHa1T3ATovt84IPs3JRKQoYVvKkay4BFg8w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6486002)(478600001)(6666004)(52116002)(6512007)(86362001)(36756003)(38350700005)(6506007)(38100700002)(2616005)(1076003)(26005)(83380400001)(316002)(6916009)(54906003)(66946007)(66476007)(41300700001)(5660300002)(66556008)(8936002)(8676002)(4326008)(2906002)(7416002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VO+gRYyndtuJtz8W64uTcbs8kWXfQaQ3MrCxpZjI+NMozEqxKryXf8nvJcYf?=
 =?us-ascii?Q?z7PcLsrpkExJQbtCOSIX8usbVmpUIsOKayYu3g9/XeVVlF3g+ZSy8eFe2W+9?=
 =?us-ascii?Q?00kwambGvCho/0lwFuftA5U495pr/D1gjl7W0DMmMWRNwcNu0ZJPmhXCpJKd?=
 =?us-ascii?Q?UDkqnB6KMDwShJyyfGXrrsxhc16iEejWtx1DYcA/jqaaX9IW0G7DYwgMRHaT?=
 =?us-ascii?Q?YUXlpoyT2OUvkjeH42jc2E4bErPaC8iS6YkSQ0ouXJzPl9TG14pmI4ca49+A?=
 =?us-ascii?Q?ax9Wno1hKdU5cqKBEPbr3LEJ0Zo5FHnghYGwHfwV5EiUj6WbbD6cyCuAAfHt?=
 =?us-ascii?Q?bjOVroVJ8GU0dHwIqrUivO4mN8LyzvO5yTTXcTK8M9a3Rux9VklBnZDL2fDR?=
 =?us-ascii?Q?vOWOoVDjM+k47NTmZ2O37Vb9xiidjUzoOEC0KHFCFd2HdO12PcIWYPEjvA4k?=
 =?us-ascii?Q?t37lCHQAbm1KLPQhGVFeHM4+5D5qIEle7qintRfSp8CaT3bgGdzJKetg0MTR?=
 =?us-ascii?Q?nu/cUUfrClGfqL1wYSdrBX7ewUXRPJpfruwjtgfEYlIdO0LT3gD/NyJefLhR?=
 =?us-ascii?Q?/iyxi9o5/aBWs6KQpGeOnTQYngFa7cyDr6RT8+UAvNZ9uTlPS5PAWbtBs744?=
 =?us-ascii?Q?V7U3X3EkPREuJFJwn3Lf3MKXsSKsUueuRkidx51/nxhX7qpba5gByUFy2Oc1?=
 =?us-ascii?Q?E0gG/PvPst4PJLGAoiR1QYImXYKNTzuKSroTwOzReaVgRagNkxGLM/w76AtF?=
 =?us-ascii?Q?2Nk5iGTtACj3I9IKrwXTSOCU5M3SdBbmU4EgzS6aYRTU2X4USD6r7nEXd8Ph?=
 =?us-ascii?Q?zEUKbCzmUA7LuBUtlxPZ5snF5dkg/w3MOaU9aka+Knmqh+ZGGENzvfl7bl1V?=
 =?us-ascii?Q?rjVT8ph6mefI2q13OGvUfgxrZmjbS6L8QNNCwA3M19cn3ezUEuxtREUgLX68?=
 =?us-ascii?Q?30+QDNK6r67KAYGM/7G4kUsI3MBFTu82u5W+FazxySzC12g5G7lWNSJ4qAxv?=
 =?us-ascii?Q?P1yQCP9Ronqdem36NJKhtxguzMQCXsOIhpXQgOC71hxp6vYEH6WOTUdClxUk?=
 =?us-ascii?Q?8vSFhCe80D3PijTeW4O3o5kaCHHNuQTyVT27b8Itw2K1S4duKaMxY8SrL/YQ?=
 =?us-ascii?Q?gaGfHnTl9MmXGyfl0KEr/gPvro3ikmLVz/qPVYE/RsaJnGVPbIOpvbWs6gs4?=
 =?us-ascii?Q?qF7FaSXahq1A5hcCpDY0z19DrJ24uwRcTD5G1o3r1LbRcm107q6uFZSHx57t?=
 =?us-ascii?Q?tHBxbF9ksED2/WWFQ3G+rekak1m2wCMxVI/BN6mNS45WzKy/aGDf+bvnT5t9?=
 =?us-ascii?Q?k3LF+R0IdhZKrmTHMGP7JpA44MImO3jW51cAhfSYR6+GOi3ScC0xNTKnnUI6?=
 =?us-ascii?Q?CIy0iy6Gu4PsKy0razHGeE773+bj2hahCPtcRiiIUX3pjBpQxxMe3lwB/+ae?=
 =?us-ascii?Q?pBqvn5C7XxMKaumIS99IvoEgWyYQrNkSfPCnoU6H1XzSF/froYayyD/jZHbh?=
 =?us-ascii?Q?e4yoSa1XpyJaboAAWptRVFhQC6Zw+VOmdgNdvrZ5CQGmpQ4rzf+tt2b8eFZ7?=
 =?us-ascii?Q?xEPrW9y87Hn6Cy6xRpDM+phNTZNJEZ/cYeR5lDZkPnLowiKhJKUbCPz+SWHx?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cede20-f198-4f8f-8fa6-08dbcf04c072
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 11:32:32.1314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bv41dVg87YKiq0ryIwQ5IxJHFVxMjPRsNxccOGTofaaUZVTnj+E2cEAYxsxPxt6bnsARp+gTucxkXGmsTjezcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7720
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mii_bus API conversion to read_c45() and write_c45() did not cover
the mdio-mux driver before read() and write() were made C22-only.

This broke arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso.
The -EOPNOTSUPP from mdiobus_c45_read() is transformed by
get_phy_c45_devs_in_pkg() into -EIO, is further propagated to
of_mdiobus_register() and this makes the mdio-mux driver fail to probe
the entire child buses, not just the PHYs that cause access errors.

Fix the regression by introducing special c45 read and write accessors
to mdio-mux which forward the operation to the parent MDIO bus.

Fixes: db1a63aed89c ("net: phy: Remove fallback to old C45 method")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/mdio/mdio-mux.c | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/mdio/mdio-mux.c b/drivers/net/mdio/mdio-mux.c
index a881e3523328..7d322c08c1e9 100644
--- a/drivers/net/mdio/mdio-mux.c
+++ b/drivers/net/mdio/mdio-mux.c
@@ -55,6 +55,27 @@ static int mdio_mux_read(struct mii_bus *bus, int phy_id, int regnum)
 	return r;
 }
 
+static int mdio_mux_read_c45(struct mii_bus *bus, int phy_id, int dev_addr,
+			     int regnum)
+{
+	struct mdio_mux_child_bus *cb = bus->priv;
+	struct mdio_mux_parent_bus *pb = cb->parent;
+	int r;
+
+	mutex_lock_nested(&pb->mii_bus->mdio_lock, MDIO_MUTEX_MUX);
+	r = pb->switch_fn(pb->current_child, cb->bus_number, pb->switch_data);
+	if (r)
+		goto out;
+
+	pb->current_child = cb->bus_number;
+
+	r = pb->mii_bus->read_c45(pb->mii_bus, phy_id, dev_addr, regnum);
+out:
+	mutex_unlock(&pb->mii_bus->mdio_lock);
+
+	return r;
+}
+
 /*
  * The parent bus' lock is used to order access to the switch_fn.
  */
@@ -80,6 +101,28 @@ static int mdio_mux_write(struct mii_bus *bus, int phy_id,
 	return r;
 }
 
+static int mdio_mux_write_c45(struct mii_bus *bus, int phy_id, int dev_addr,
+			      int regnum, u16 val)
+{
+	struct mdio_mux_child_bus *cb = bus->priv;
+	struct mdio_mux_parent_bus *pb = cb->parent;
+
+	int r;
+
+	mutex_lock_nested(&pb->mii_bus->mdio_lock, MDIO_MUTEX_MUX);
+	r = pb->switch_fn(pb->current_child, cb->bus_number, pb->switch_data);
+	if (r)
+		goto out;
+
+	pb->current_child = cb->bus_number;
+
+	r = pb->mii_bus->write_c45(pb->mii_bus, phy_id, dev_addr, regnum, val);
+out:
+	mutex_unlock(&pb->mii_bus->mdio_lock);
+
+	return r;
+}
+
 static int parent_count;
 
 static void mdio_mux_uninit_children(struct mdio_mux_parent_bus *pb)
@@ -173,6 +216,8 @@ int mdio_mux_init(struct device *dev,
 		cb->mii_bus->parent = dev;
 		cb->mii_bus->read = mdio_mux_read;
 		cb->mii_bus->write = mdio_mux_write;
+		cb->mii_bus->read_c45 = mdio_mux_read_c45;
+		cb->mii_bus->write_c45 = mdio_mux_write_c45;
 		r = of_mdiobus_register(cb->mii_bus, child_bus_node);
 		if (r) {
 			mdiobus_free(cb->mii_bus);
-- 
2.34.1

