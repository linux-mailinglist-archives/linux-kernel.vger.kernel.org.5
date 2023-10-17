Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2907C7CC5EF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbjJQOb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbjJQOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:31:57 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E0C92;
        Tue, 17 Oct 2023 07:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrOii/M0uUuN+Va/w+rSMbbPy+kExmZIgUy0daLJsI5zB9alX0Ed2sayMqdk82x8i2uHzWs4lHqtMpLioPxwkNeli5wnvE7zkr40KZHU0rZT//HpnuU+DkKfhf1tim9zy+1njjpJEYAM3vRvejGcrHHkErydLNBwvuVtrETnJzMvLPPEYSLk9/i46AUDFnp3WrjNyxCKx2fhf608z8fWUTKZk/YaPQi+P3sGARROrqOoD97VP5jjj7iaze99DVxXizT6rkPCIPdgGZeXLn9OJK6zEN4M0rMjzR38q5JnLsmJeygUGQIbiK7nBq/Np4H9mAHKyg5Y1koXg0Hj9A5pTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeCTIc5F1aJ+lPAPw/K2uD0eVEXVe5+6aAu1qx383/k=;
 b=lTlzlIRCRMBMInh5DnKd8FYqHxVwnlTNd4GbYK/AOu4+r4dOdEoGpTrMiuJJuB+L0dp3A4b+c7OD0ahc7L0W+Gs3+Q4eWcDVh7PMw5OKqyJtWboh8doeOfl5cABjI4sGL8I/c0AL5TkhYhSi1/aFGBZq3UHr0EjcUjQSmjlhsApldMkLENXgtmDYrTPmJP5l1tAnW2Qn0+GdmNNbfJsRXMQYi+pXeO6yuI+bfbbwKrCJ8XmqCbvDfG6qcGZO7/UkgrRjUKV/MN4I0RUFZUTtZLJm6fMJoHfuDo+eGVhzeWjjF9+tiAe5Jy7tTd2Azk11FYmbc2B9sCoDio1e8l5BlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeCTIc5F1aJ+lPAPw/K2uD0eVEXVe5+6aAu1qx383/k=;
 b=VV6vAc7LJ+yBnalTa/o8P6X5+iGLkLy1uopXXrw1Mwdn13ZOBeMF3P0lsIH3TsIWZmGNMhCx6i8FvlzF9xmKmlkFJd7QLAGBbiSrY9ShDAbzKDhwEV3rbCRgJuhRfP/CguWOnVU8/kytkAbtkcZnE6eAlcObfebP+WcmB70LZFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBAPR04MB7430.eurprd04.prod.outlook.com (2603:10a6:10:1aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 14:31:52 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 14:31:52 +0000
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
Subject: [PATCH v2 net] net: mdio-mux: fix C45 access returning -EIO after API change
Date:   Tue, 17 Oct 2023 17:31:44 +0300
Message-Id: <20231017143144.3212657-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0015.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::19) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBAPR04MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 004a6486-91a1-4e43-3e75-08dbcf1dce5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vYsVaajwTEWCk0ep7SbMSwSp8PQjg9+JK4qP9YujticUxVMYmw3AZV/NTT53BQwZqHOy00hMhu2FjwbPONhwEaElIkAbpTLQV4qH60F/XwuKqlR2hzpV95Vzd7Himse+Qv46G/U6fFV4p8A4eC0S3nkvv2aEGGU2jyoPuNrlu3bGDtipK5qB1zJdFWuf3B5OyyzBLrgktjBxC7lrqaNTrLZEqe5cSr6dB8zKsv3x7QA9F1hxkBdonZ6QvqxjWPyZnoFMFsB4NIdaSfMU1ELWLeZVC3FFNZS52JvGNtb3p3jusRd7KhsvmMcqmP4Y/PP01qgFxS/vZuoBWBKJBdXHvCyiDwSMMpbCU+ukfrtlSZ6rrgQHd0qDzz+YRBIBNxeY+cGNgqiGJkpZ82tgT/peLI3+xtB5UZ3ImmX1MBAdZgxv6hXwpWLgqHs9RHTT4RKstZ+IEtM/+xjvlk32AsIGCOOt7Z4Kc+9VdK7jw+KLqJEcT1Q/yVvk6XVHIEScAh1UyjgxIvkAi3NmghloUWzlc0C676aAZz80n/3jD4UjqiIGYqhik81u1rvrUAchcxnvi6V8VlhOFMqli1eOQKHMfdahz9T1oaMM9e8Cy3LM6GPtveK6IgyW3bm/iAnlLeW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6486002)(478600001)(2616005)(1076003)(6916009)(66476007)(54906003)(316002)(66946007)(66556008)(52116002)(26005)(6506007)(2906002)(6512007)(8936002)(4326008)(8676002)(5660300002)(44832011)(7416002)(41300700001)(86362001)(36756003)(38350700005)(38100700002)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dtZaEGYRDMTyi6WrcCs6GekRL2MgAm2it/uk6iHtmtej2qwQmI7KN8/ypWQo?=
 =?us-ascii?Q?X3xdm06FN4ZdB9sZsTeox2930SWWET69NQDi0813jpr14mrYxu6x99nah19U?=
 =?us-ascii?Q?DPkHIoxLGwTpbiqUBQbQUumCPAQ1SJyYnyj43ZS0s8hvhABYQGIpMYLFxN22?=
 =?us-ascii?Q?wH3eLEpvugdqTMt9yi8ert4JQCaEZli1DW7P1dFtDHJJikxPX0YUb/1d2DUE?=
 =?us-ascii?Q?2nPaZa0TyiUDLIIjsgAqCFxA6G5A9lAFDciyJoaMK67yiD9fLOQaI2jvDCw1?=
 =?us-ascii?Q?vkPZWBK8ITnkU5ZyK6u/G/RQbDtjyVOYMe0ACMQdgRou8pBKRXdUleIn96bM?=
 =?us-ascii?Q?MXm6BvxbgY6H6/czsXUDwyYNYBE2ObyCDg8bcsteRxwcueAUuoM/7xRsniKC?=
 =?us-ascii?Q?ctxYXuyieyFn2xj+6GhW4tLb2duAiNTdv5weUOaOHfYL+bW3HsUWy8uVeqdq?=
 =?us-ascii?Q?+76bEUIeGmRlpQE8PsfUP2ZaRy0SUWu8itpPZK2mbDf0Z3IbaLfRLcE8gHWp?=
 =?us-ascii?Q?kLaexlBmn61XSatKZPKm1SkQsaKA6Y6AWwBkxV8IehEZMWFCMgC7tjkiTPPq?=
 =?us-ascii?Q?LvUltX8xVTaGoTRukA4nknfgEyCksz8cCyIsOQSlPfJ56NGdYVZQFeAIjOTU?=
 =?us-ascii?Q?TdEa/GQ8f3OSM/z3oZ45PIxTCW7w6hTLViQ4UsAtXs0jfViq7c1X8L5j2Bv6?=
 =?us-ascii?Q?ZChz64RFapXy51FOyZ7iXXvLNi79Uixl2GopQ0qmsNn9F7gEg/E5GvZF3aY4?=
 =?us-ascii?Q?gDvdsgf/XaP44py40yHxWKE9NNyKzXXV8n/Xyo948SO/3OZCCU8nD7f5xzFy?=
 =?us-ascii?Q?XrUfga6NjP09rVIv9Go2qj0eLxH9yt+a6lfJvYEVqsh1lUl5Lrj+tBOOZGTt?=
 =?us-ascii?Q?Els0THoW/zxKbq2mji7r2zjXzjEBM+53awADzntyeEEL0PmC/lNw4pzQv39k?=
 =?us-ascii?Q?v3GYuJsIrf+bs4k2f6yNZGVO200BNZwCREMo5/L168bOVagjYRhEXsczQKzJ?=
 =?us-ascii?Q?DuFA0juCiOa3dGSFk91tOsNevPoku4qQpul3HMmU9HEfzTzFuihOgJ9ktecV?=
 =?us-ascii?Q?xorH9q17IP1UzFtf5ubLGaliTBXz3FnWtDmQJY6sQmBTI6a4nBgkXF0CteEh?=
 =?us-ascii?Q?cmYtXQD5+4l8iR2r6fMATt5xE9DsgD+FRdd3UTRsgZLQtZdCMvj6wNms9/+b?=
 =?us-ascii?Q?DpufRutfHlz8MzcIS2rZB0rLmWZAeqX6Aoc3+gYmLDdL7U0bzWY1pVyT2ZnX?=
 =?us-ascii?Q?Ee7SlSqpTlMiWd4izfuA5+JosM+/87g94ZiQ4YQRXbsFVjsn2CEc9LCFG7NA?=
 =?us-ascii?Q?nniKhxMrOkJorI4Ld+2PSEmKvsitNZR2HikzLEMYInWoOQK1DsWenfdJK/LP?=
 =?us-ascii?Q?m48iQUcH7GAlr/Qq1RP4Ite+XjUwBjpA0TBdHomSaR/gQcjzyvf9S+mQIEIS?=
 =?us-ascii?Q?zCzWO1EwEW3MR9Ew+1XUY8pFNyASt66hfQX9T8s3V/65ftR6fFs1L1Qayx/8?=
 =?us-ascii?Q?inggemvKFzz8YTHK0oVdWFhMQ9uXcrH+298MyVvBXLPbAx1mS9O6aOrMfM8z?=
 =?us-ascii?Q?FVRDU6W5VPv9C6LIu1eoGtHQG09yVkXOKyrFYKDDrltzPlmPUB0gkRx4fHjR?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004a6486-91a1-4e43-3e75-08dbcf1dce5d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 14:31:52.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdjMDzu9Z3bFlthYvPsZBAu7+ew99qrNNYiDYMhLiXG1VhRqfhXGB2lzgJJOAYZomPvac++LfGTODoijRAv8Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7430
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
v1->v2: apply Russell's suggestion to assign the function pointers
        conditionally based on their presence in the parent bus

 drivers/net/mdio/mdio-mux.c | 47 +++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/mdio/mdio-mux.c b/drivers/net/mdio/mdio-mux.c
index a881e3523328..bef4cce71287 100644
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
@@ -173,6 +216,10 @@ int mdio_mux_init(struct device *dev,
 		cb->mii_bus->parent = dev;
 		cb->mii_bus->read = mdio_mux_read;
 		cb->mii_bus->write = mdio_mux_write;
+		if (parent_bus->read_c45)
+			cb->mii_bus->read_c45 = mdio_mux_read_c45;
+		if (parent_bus->write_c45)
+			cb->mii_bus->write_c45 = mdio_mux_write_c45;
 		r = of_mdiobus_register(cb->mii_bus, child_bus_node);
 		if (r) {
 			mdiobus_free(cb->mii_bus);
-- 
2.34.1

