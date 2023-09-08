Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164327987F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243663AbjIHNec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243582AbjIHNe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:34:27 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7510919BC;
        Fri,  8 Sep 2023 06:34:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGLMSVPlzraYHjsLj2GsOmj3WOeREolMEmakKwMk1OEl0+8TIMx3zSEKCVZaZwy+T9/FiSKkg05cMDsSxEZ1yb3vF3wkUEKFcSKpReuPcYlxlMZxPKRl8530ID6DWYPzEZKr0Ru/LYPDIajXLmdMpr8g7dbPCEQI0VQEC3t+qW0eqimFLtIPwC1/bd+AmIO3Ze8BWiKmhj/tq4YRNOcqjYQ0dj6GvzdBY05XCBU1G8V5OhneYn2y6biWUiVovN4T0nHjEEFmvAW6UrT0YXwJ6DvdRg1ANDZG0R5Z3pi76W2bt1rl7yFYFD7TRZ/HIln6selxVPRRwkfKc3HDuOhD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZNLITou5yVf/sIOWaZk9PVNCJQqaJYoYFEev5erSqY=;
 b=Xfv6vmBeKYjll05fTPJNb1ZfUiOk+b25CuMcArjW7yEN2wWo5aR1HgBXV53DqXbgidO3hiSGAljZKYNDqjM9B9J9rI7Gyvvo0nVukcnqHSrb8VlVIpr4uBkl3wuDbecnmyi/SNCKPSLQ6KNJXN/TSL7++MLCJcCB4BpEiqCa95jK1np3LaEIlmi6jbk83/6VlIUVLYZmGdat5r6JK4aJ+Ec9gZYeXBJZy1v4Wq+1wNQYJbgR8k3mvpo1m1+tR2vsoCzyW35GOepFYaXM2r8endscSDzApwU+NucVdfMOcI2l9Anx879K6/wHDj9MmL6LVTSeCcCUAqHnrkEjro0GTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZNLITou5yVf/sIOWaZk9PVNCJQqaJYoYFEev5erSqY=;
 b=bGN86w0udcmLZE5Bwqr223JujKehHW4ImpkzsWiIyvoThj2LdsVU0jGG7n8WGD0CvTuOczj0b8Z8k+Nn5nB9/lkQTpHEEb/367yTU3aQdx6bHUxmiwEfUFnoOSeatGWqzeFKKK0oiJ5z91KFwcJqEJnMrL02Ja0IDJPoCNHKILw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAWPR04MB9718.eurprd04.prod.outlook.com (2603:10a6:102:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 13:34:08 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 13:34:07 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yanan Yang <yanan.yang@nxp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net 4/5] net: dsa: sja1105: serialize sja1105_port_mcast_flood() with other FDB accesses
Date:   Fri,  8 Sep 2023 16:33:51 +0300
Message-Id: <20230908133352.2007218-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908133352.2007218-1-vladimir.oltean@nxp.com>
References: <20230908133352.2007218-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAWPR04MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c540bc-86a1-4420-3dad-08dbb070464e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9PawD+yjhHDwVobpLms98kilkj9w4ZtlpLTeMvfeAay04N22WsrW5FlNMUnJPik4ztBESm+Y8KPuP3Ch2taEzRxUg6E0FOtzU3gb1Zg61eQny/P47F2hISjBENppd9vbZtoIEi3mnCukeMBv8h9pz3p6WWKTbm442YJ93jNUYWH5E9lyTVKSt/CuHxF6T7eAlKtuaSmOjMI3qDUXZd17qJEFTHZ4DSTsYVwVjRRh93vgA5IVQrWPnYhOYy96Pjw1ESGZze0vmAxJsVoFAXb/tXuxL+8E0Rt5L2VguAyc/eQCfzCmfWVtLFQ6S+yof0PoVPj0XRUXry3f+EHzphC6haOmLqBruypPNii8Ce+gFt1y0MAWurhmeikSmTaYdys+RAJTxeCDMrawh1pZvU9XhEYrDAgkhajgDP5xC8FndVmb2BvVYm75Haknz12WE+w3hNKnme6HFrfIVIKcUPJhkkcJeknsijK7pn6jiYEz1r0Jbh4qnjZiPjCfcP4sUWSyxACH344vmkw9EARVZcchRxZDpqcLTQ9H3X8FTlVsTt1CrjMVPfIxT8pM5OtBoxIpi2GQP0WzYD0rapsTubB6BeoWOxYlBiFktcR3C3KUSnXO1/jQZg2INfBWLqG+Ez2Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(1800799009)(186009)(451199024)(66899024)(2906002)(38350700002)(38100700002)(36756003)(6506007)(41300700001)(6512007)(6486002)(52116002)(66556008)(54906003)(2616005)(66946007)(66476007)(6916009)(316002)(1076003)(86362001)(8676002)(8936002)(4326008)(6666004)(478600001)(5660300002)(26005)(83380400001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ydteNYWU0KEx4Q/wn6fzyKcXOqMbuMXbYahNLTPfsfoYUlr9b4nEq8TL59aY?=
 =?us-ascii?Q?4tC/BGBBHf9/qP0hEcovaKdu7NEopcP/oEDsfsRNSVfeIvkPg6AWJDacwLFa?=
 =?us-ascii?Q?kzxwHBR5wNWQKAw1zrNuGgyaZroAqSsdTDGWL6+ciADygn8OqIWBWmIDouun?=
 =?us-ascii?Q?7rrxJNMqZgCYQdlnLjqwnlFb71wVXXqzT16lvs2XXWBG1+MkXGVIL586w6i2?=
 =?us-ascii?Q?Ulcq0m1Wf5HPt7uxvK+5yVwprd2d6YLcSlcxtlYq5HVYG6tyT99KmN7Vate5?=
 =?us-ascii?Q?SahdcoNVHRyM5Fk/hA7FZfAMRU8gGIQD6uKMZuso6Z0KBzDT8hLgzqqlbyp2?=
 =?us-ascii?Q?oPpc5CDr9RaqW+G4QttM/5HR5anma6YA3Tng4j3zBYOtXYyrQO/AD2JyWlvb?=
 =?us-ascii?Q?uTHt+XdXJ/HNocprhe6xyVLfet6XPLxkVsNrRiBQkc0RTxCb50yN4lvJe/y6?=
 =?us-ascii?Q?DEdwEE6m47VxAR3F3XaE5oIWmw3rXVD1Hyviu+D50GCA+DUa1Fi12LcoypVY?=
 =?us-ascii?Q?w6dUK9lQkKDL7rjc3E3niMYJ3UAK5FT8KLlWqRyES1+iw54K3I2NZftWZuUl?=
 =?us-ascii?Q?6sNMGda1psSYCULQViwwb9RIf5igTI9kpbBD/28jsXYzTCGExH9qc+pp3JyR?=
 =?us-ascii?Q?1bODPjPVh5K22qzwf5rJVWJXLpV0XcZOLzMckmgtt/ehZ5H8w2beHuvdzw0a?=
 =?us-ascii?Q?b5HpiC9bsiT+GV2uB+EK7Gjf/F9q4EMfBjxvmnTBmRdvsAWCemobzF9asfXi?=
 =?us-ascii?Q?ucLxLz7aL+qyLmqzsGZr+AfEU4MiOPh3yF4ExLq5vDVDIRpiipkF/Y62Tj0a?=
 =?us-ascii?Q?v1e3mqAG4u29LDRcqNEOUJR6udXG+q0v7ueFFaIld5PTXvpA8vhZNAxPLbp3?=
 =?us-ascii?Q?umVw/Pvmqcg1lza02h7TL2AK1o+f/Es8XtNYOgwPKdz+HV6jHk46kVccnnIQ?=
 =?us-ascii?Q?QnTKRxGwKYp3OO6k/zSM1f7vaS4IFKQGpqQ3zA1ri1GBcrb2ByoIEKyj5HJi?=
 =?us-ascii?Q?4lioZPt8v/0bgKKx2eEkKIMFgW+8KYKElzG9lI1YpyhfmKcbqpVypPsrQ9jS?=
 =?us-ascii?Q?VpUDczcZWFGrgYVkAFKwgbv3gRtaNU9VLKFR+5DJvIWXkAANBxJqkuR+k5HP?=
 =?us-ascii?Q?70G25e11/Ss+S19Wlbf+pZtSJ4OtcUsLHYeVChmH5jCQceiMbdWNra3esL9M?=
 =?us-ascii?Q?abR9YYlopv+3ZxHc6bYwOMi+3FROynzT+zjJA0VlpVThpSbu/m/dma8gk0s9?=
 =?us-ascii?Q?LUS1DJpjPGQw1Q2bkXOTeE5VX0WAsKYYt1dXK8i+9ltZluuP0dUFVCAYnfMY?=
 =?us-ascii?Q?dCFHRwup6uLExiBR3HHRxNWC2z7YR+84qSXs2xtiHw05TzfXPRwBJCBYB1iS?=
 =?us-ascii?Q?CNZGpqjnnMsF0gki4/pELYDVTxma5+LFGHAINcqQ8GixXH7LbNEddX2oF2Hd?=
 =?us-ascii?Q?jKRY4lQZIj4W+o60Z9g4d0znvr0ww5jlNCSLAiYVzDiyIy31/PpGWbDSJtAn?=
 =?us-ascii?Q?kMZWvbwlirqV/zs/HgG5FAsvEM5Oex0uIl4D23al/EnziEqNw5cm+81NkBgH?=
 =?us-ascii?Q?kuZircJh7P2qzl3Mn+zTUJmJVJJ49PkuaTglaY9eC9QHKJKHZe12eSn0LPXs?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c540bc-86a1-4420-3dad-08dbb070464e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 13:34:06.6812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSNFZszmAKvEwVRryA1DEkOw5vZOXYKCCi4zdgxfmyMkvAtPF1m0MHujx1PjE40WWb6fSJ8SUXUh1LvHhvwRLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sja1105_fdb_add() runs from the dsa_owq, and sja1105_port_mcast_flood()
runs from switchdev_deferred_process_work(). Prior to the blamed commit,
they used to be indirectly serialized through the rtnl_lock(), which
no longer holds true because dsa_owq dropped that.

So, it is now possible that we traverse the static config BLK_IDX_L2_LOOKUP
elements concurrently compared to when we change them, in
sja1105_static_fdb_change(). That is not ideal, since it might result in
data corruption.

Introduce a mutex which serializes accesses to the hardware FDB and to
the static config elements for the L2 Address Lookup table.

I can't find a good reason to add locking around sja1105_fdb_dump().
I'll add it later if needed.

Fixes: 0faf890fc519 ("net: dsa: drop rtnl_lock from dsa_slave_switchdev_event_work")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105.h      |  2 +
 drivers/net/dsa/sja1105/sja1105_main.c | 56 ++++++++++++++++++++------
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index 0617d5ccd3ff..8c66d3bf61f0 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -266,6 +266,8 @@ struct sja1105_private {
 	 * the switch doesn't confuse them with one another.
 	 */
 	struct mutex mgmt_lock;
+	/* Serializes accesses to the FDB */
+	struct mutex fdb_lock;
 	/* PTP two-step TX timestamp ID, and its serialization lock */
 	spinlock_t ts_id_lock;
 	u8 ts_id;
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 11c917d5ce43..cefd72617af4 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1798,6 +1798,7 @@ static int sja1105_fdb_add(struct dsa_switch *ds, int port,
 			   struct dsa_db db)
 {
 	struct sja1105_private *priv = ds->priv;
+	int rc;
 
 	if (!vid) {
 		switch (db.type) {
@@ -1812,12 +1813,16 @@ static int sja1105_fdb_add(struct dsa_switch *ds, int port,
 		}
 	}
 
-	return priv->info->fdb_add_cmd(ds, port, addr, vid);
+	mutex_lock(&priv->fdb_lock);
+	rc = priv->info->fdb_add_cmd(ds, port, addr, vid);
+	mutex_unlock(&priv->fdb_lock);
+
+	return rc;
 }
 
-static int sja1105_fdb_del(struct dsa_switch *ds, int port,
-			   const unsigned char *addr, u16 vid,
-			   struct dsa_db db)
+static int __sja1105_fdb_del(struct dsa_switch *ds, int port,
+			     const unsigned char *addr, u16 vid,
+			     struct dsa_db db)
 {
 	struct sja1105_private *priv = ds->priv;
 
@@ -1837,6 +1842,20 @@ static int sja1105_fdb_del(struct dsa_switch *ds, int port,
 	return priv->info->fdb_del_cmd(ds, port, addr, vid);
 }
 
+static int sja1105_fdb_del(struct dsa_switch *ds, int port,
+			   const unsigned char *addr, u16 vid,
+			   struct dsa_db db)
+{
+	struct sja1105_private *priv = ds->priv;
+	int rc;
+
+	mutex_lock(&priv->fdb_lock);
+	rc = __sja1105_fdb_del(ds, port, addr, vid, db);
+	mutex_unlock(&priv->fdb_lock);
+
+	return rc;
+}
+
 static int sja1105_fdb_dump(struct dsa_switch *ds, int port,
 			    dsa_fdb_dump_cb_t *cb, void *data)
 {
@@ -1899,6 +1918,8 @@ static void sja1105_fast_age(struct dsa_switch *ds, int port)
 	};
 	int i;
 
+	mutex_lock(&priv->fdb_lock);
+
 	for (i = 0; i < SJA1105_MAX_L2_LOOKUP_COUNT; i++) {
 		struct sja1105_l2_lookup_entry l2_lookup = {0};
 		u8 macaddr[ETH_ALEN];
@@ -1912,7 +1933,7 @@ static void sja1105_fast_age(struct dsa_switch *ds, int port)
 		if (rc) {
 			dev_err(ds->dev, "Failed to read FDB: %pe\n",
 				ERR_PTR(rc));
-			return;
+			break;
 		}
 
 		if (!(l2_lookup.destports & BIT(port)))
@@ -1924,14 +1945,16 @@ static void sja1105_fast_age(struct dsa_switch *ds, int port)
 
 		u64_to_ether_addr(l2_lookup.macaddr, macaddr);
 
-		rc = sja1105_fdb_del(ds, port, macaddr, l2_lookup.vlanid, db);
+		rc = __sja1105_fdb_del(ds, port, macaddr, l2_lookup.vlanid, db);
 		if (rc) {
 			dev_err(ds->dev,
 				"Failed to delete FDB entry %pM vid %lld: %pe\n",
 				macaddr, l2_lookup.vlanid, ERR_PTR(rc));
-			return;
+			break;
 		}
 	}
+
+	mutex_unlock(&priv->fdb_lock);
 }
 
 static int sja1105_mdb_add(struct dsa_switch *ds, int port,
@@ -2955,7 +2978,9 @@ static int sja1105_port_mcast_flood(struct sja1105_private *priv, int to,
 {
 	struct sja1105_l2_lookup_entry *l2_lookup;
 	struct sja1105_table *table;
-	int match;
+	int match, rc;
+
+	mutex_lock(&priv->fdb_lock);
 
 	table = &priv->static_config.tables[BLK_IDX_L2_LOOKUP];
 	l2_lookup = table->entries;
@@ -2968,7 +2993,8 @@ static int sja1105_port_mcast_flood(struct sja1105_private *priv, int to,
 	if (match == table->entry_count) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Could not find FDB entry for unknown multicast");
-		return -ENOSPC;
+		rc = -ENOSPC;
+		goto out;
 	}
 
 	if (flags.val & BR_MCAST_FLOOD)
@@ -2976,10 +3002,13 @@ static int sja1105_port_mcast_flood(struct sja1105_private *priv, int to,
 	else
 		l2_lookup[match].destports &= ~BIT(to);
 
-	return sja1105_dynamic_config_write(priv, BLK_IDX_L2_LOOKUP,
-					    l2_lookup[match].index,
-					    &l2_lookup[match],
-					    true);
+	rc = sja1105_dynamic_config_write(priv, BLK_IDX_L2_LOOKUP,
+					  l2_lookup[match].index,
+					  &l2_lookup[match], true);
+out:
+	mutex_unlock(&priv->fdb_lock);
+
+	return rc;
 }
 
 static int sja1105_port_pre_bridge_flags(struct dsa_switch *ds, int port,
@@ -3349,6 +3378,7 @@ static int sja1105_probe(struct spi_device *spi)
 	mutex_init(&priv->ptp_data.lock);
 	mutex_init(&priv->dynamic_config_lock);
 	mutex_init(&priv->mgmt_lock);
+	mutex_init(&priv->fdb_lock);
 	spin_lock_init(&priv->ts_id_lock);
 
 	rc = sja1105_parse_dt(priv);
-- 
2.34.1

