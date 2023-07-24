Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C6275F987
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjGXONL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjGXONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:13:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37213A3;
        Mon, 24 Jul 2023 07:13:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lELFJSR9HmM12UY0eItTCMCN0O3tkzCmWFh0EJbzQZpqTPetRhcKEZ5Y0uAMmx8Mwrpsxby+5YfToiWj5XH9DXUMCVgtll97gOrd+BDaNXKzpyS+In2bde9UQ4Q5lq4+V2QiFJX4StjsaXTHObSB/tETPKept967Spyv2dzfWW+OqNDaCy8R2fvOHfAbMszxJrL5osuobKFK4mnWONhBNDgFWPjfPAM+oZUrHOEpOWfgtCAoDXC+48iL41aSyRlW2pHvvlyf/411Qg4iKkvA+C6BrdCBSwjDRRQMTBTIAsU3GkJylIbzppYwvwXnLCBVq979CZT3priHhbxQNBrkEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jadCoVrujpc89wNC44EvqDY1NodWAxzqixSXEHnIiQ=;
 b=PzRgyvDhIhm1Ix/5kfVlWe2DnPMkMpawDTYfyezaCBqdhQ7ihBeJuVpYwMjZXil/ECzitFX/qCzMBT9NTguo50wY/DfJ4H5h5s1yIuNy9bEcWnED+SdUFSgxUFIrzAwjp//9/95pb0TpAbYxygHkA47B7hRHVeRcK+64+hIjYO0N5jTu79yJD8oLeNW20sUJ3XRUj2YdPl9src/BE312icBiZut0/1Wl+9mHL5gJ1A3yYaNAdM+4begwV0YI6o4CqSbjL5fOSWpdeMWnTIeh52iOOdl6UNAEAPkOAcQtAv5M00uZ5Z77FDZjKGODlRsACcKZxhcH1GWmTpVcHGTSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jadCoVrujpc89wNC44EvqDY1NodWAxzqixSXEHnIiQ=;
 b=L1Dta+gJR4ndUHZ6cAF7l7hp8kQ6uHDh9jHjFz9nb3jimipo1UAMW5N6AeHcmfka2V4rzeWCZXHadteLE0aB8+gYi9AqUOgw9UleId5nSzY0QiBo0OLSuL2yXUnEw53+5Ry2G7018XtByEgx9WylpZaDpwHkIiciL0uzsOviBqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS4PR04MB9690.eurprd04.prod.outlook.com (2603:10a6:20b:4fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 14:12:54 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:12:54 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v4 11/11] net: phy: nxp-c45-tja11xx: reset PCS if the link goes down
Date:   Mon, 24 Jul 2023 17:12:32 +0300
Message-Id: <20230724141232.233101-12-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::19) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS4PR04MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: 25abdde2-cc5a-49ea-b974-08db8c5012b5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zNjN6MAg5uaT62IuBPN2GhgpZ98qJmME08Lr7x1EZ3OOcFHlA1ck8mNFGqY7RBZqYvxjTS7oBaZmWf+SfDM7QLG3eGbauk932IsMdpnK0M4uiX13//ycd3ujPnkTFJL7qvDf2Gqggwy372zU8pEzGIxrgsvsR+RubGBvFetpE0jngTMg6V76u2vB81mY3UWGSi5t3FJtzPkhpsr1qOJcsQ87n2DYnx6Pd08Q5mDXaoZGWBbqQmhIIDBhpN7OEPm79CaP1t8OuLmPYwgasZj0sKCKlbJpKDIFwyEo6GgtJ8dG0FL/9p5gk2KOHPuwmlHq8XQdffe4IoN257r/rbQKS6McRGBy/myOyBFoN+l5s70mio3+eRFDTGL1umsYjrjC0oyJrhYuFH3GjteSFnRFFdzpoS3xNGFZj1rd4ltsG5J9/uFPIF0KWXoSgY4OCQejm/vmDKgPwKNnw5gC7CP6gpdSFXItfJ7YeHXCCzSo3ZPLaMwB6Iz7Q9U+Iwf/EOMcCfNeRH2AGYy6LgwrmNDBGitN/rJJPIiFEYhun4p2Ev5OcXpDdsl/eoXfyE/+qcYM1nnn1MKj5bxBZIo0bTJev2HMWZN/BDQ0EUy3KfgGAml0LPDoSYBHQ9FhyY7kYW4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(8676002)(8936002)(478600001)(2906002)(7416002)(66476007)(66556008)(66946007)(4326008)(316002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(6506007)(1076003)(186003)(26005)(52116002)(6486002)(6512007)(2616005)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?awTgSJsqEnXFae2veLrRL7LIqZU2fabm+z1OJPj1ArUXBxJ/1jGonljRkQRP?=
 =?us-ascii?Q?aS/JbscuAb69k4cBQO40uA09beY1oBUXNsveZlkd85Nwd7aVKucMIJ4FCUUU?=
 =?us-ascii?Q?441z9KqohVMtvcXxmmBZeQua3N3qYXCWVNZDHYMOHYksgsaRWmVFGy+pfRh/?=
 =?us-ascii?Q?5d+KOvx70q02gkQnT3eb+R/YaoOZ3D7TvhAxoUxj7qN+VAos2qkvv/Q5Alxl?=
 =?us-ascii?Q?3ChZ5VyXgK5IE+3kqC8ZaykaDopzmG7EiH9ksv/+wTDlgHN9hO3r+lxZlyKh?=
 =?us-ascii?Q?6Bg21XChfv5W1GPC8LhomIoUPuG4V0CjvcgDF+7ThwU0h0fQ9eOgK7jbWC1q?=
 =?us-ascii?Q?CJopHDx2ebFJ4ACG48RFbT3T8DQ6K5ayzFtpUTe6rbbRrXS1FPpsEtD8oK/t?=
 =?us-ascii?Q?b0QXTHcZ71HyVP/r/puw6y85BSzlMB17f9mrEWP7Qulz5kXG9brlRXUdSB+C?=
 =?us-ascii?Q?X8UcHNDtDOCiAnYSq4ZK8f0WmyzPevKxZCfkZ2TwL9FK8tQnvaLPB0lN1NPs?=
 =?us-ascii?Q?NwoJ7ryeWQFbdUx++j8LivoBN4oez05wN2J2MHrb+EOBNK5HcYfugDef7aBD?=
 =?us-ascii?Q?jJ3275+8Xw2lvM7UXZiOv15gY5/FFlTOKwS8st3fDKUFslwDULDyoDHIys9p?=
 =?us-ascii?Q?6Vs7knB2WRtSjtIsjfwFrr8JiwaFXHUxeaN+URt6v5zeN3bY67GrHoHoL0ew?=
 =?us-ascii?Q?FoTZQQEpA6DXE/+/AYjG+jtUC4sTkg2Xyl3amJKeOzVNq2IyrGESkWfdYK8R?=
 =?us-ascii?Q?M/fLyWvF3Vg/lc9W584I7WhcdFy+96TOfknVJU8MzXFJljC/9zllUeapXozw?=
 =?us-ascii?Q?dgE/WTZ6GGvCmuQXxdusW+QtezUQfb1EuBqmiLjFUMJhak42oCeWYsX5hqDV?=
 =?us-ascii?Q?N1jjtnN7nqXZSJQ1ZtcouKK0Btxt8Ba04NHiENtpK2yNx7KH4oW5ZPskjVpf?=
 =?us-ascii?Q?q8Aq12RZK+HWmSn+mt2I+jYzowD9gaiSg3rgtcf4spRjkeiBD5hOwAnm8DUf?=
 =?us-ascii?Q?ohWa758iim5XPPGUaWJ8RaCUMycMUFCQIiMKwM3ECeSOPj/CPHvGuRx14P1h?=
 =?us-ascii?Q?KU5ogJ/1kOXRXKCcBnMQx7prNidToRso1H1cDUnqiWmXxfxWx33BLRRoSFFc?=
 =?us-ascii?Q?MsXGjCP0xuzYmd+cLjTapB9T7sy28ishGLMSDskHAZvHDtQ4kd8+3PziaCXY?=
 =?us-ascii?Q?YHa5wjWArHdvkuNmkQLYxZqkt4EhjSBxFkjdo8BHPjQTfieHb892UQZ0XBjZ?=
 =?us-ascii?Q?lAFPxfjYCzAldsoA7LgFEqEcHrTXW0SrKWJneo857CCQqKZ8ST6wG6GnfHVq?=
 =?us-ascii?Q?10wvgXFNV1KHZq2twkoRlDAs4/b0PhnBaRKvCLKBKeG9gCAakKj/4VqIiZtn?=
 =?us-ascii?Q?1hlEV5aG+eBTBdwV+XFTuAqxPO5O6QAiGwGQc0LKWW6OciEJdn49jAD+5Ln0?=
 =?us-ascii?Q?i1DRtpt9ywhlgqfWZCUmToX6TAbPjdB+TzA/F/zfTcunGUhagPkQ5XqyR4uc?=
 =?us-ascii?Q?D57pa6upx9F5haRFjY0YCKN08pwN1U3kv73ZkTrt+qfvMyeu6tR8SW9Lmozd?=
 =?us-ascii?Q?+S96jyGVJWVQ0nzHdWmjKS3vTKwPgC1+N9dLFRlht8OFFW8AXH07BY67qot9?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25abdde2-cc5a-49ea-b974-08db8c5012b5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:12:54.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQSYKZs2uVLcNMQ5MnQY74vass7AhQ60YEADEGEhJOGr+jt4Y/Mdw8rpv6x6GEEE7KMxWUbSGblJARFv8RSsSwRnevvp1xzVpXxVFPn0AAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9690
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During PTP testing on early TJA1120 engineering samples I observed that
if the link is lost and recovered, the tx timestamps will be randomly
lost. To avoid this HW issue, the PCS should be reseted.

Resetting the PCS will break the link and we should reset the PCS on
LINK UP -> LINK DOWN transition, otherwise we will trigger and infinite
loop of LINK UP -> LINK DOWN events.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index c21c6aefc705..af3951e76a47 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -56,6 +56,9 @@
 #define VEND1_PHY_CONFIG		0x8108
 #define PHY_CONFIG_AUTO			BIT(0)
 
+#define TJA1120_EPHY_RESETS		0x810A
+#define EPHY_PCS_RESET			BIT(3)
+
 #define VEND1_SIGNAL_QUALITY		0x8320
 #define SQI_VALID			BIT(14)
 #define SQI_MASK			GENMASK(2, 0)
@@ -1371,6 +1374,19 @@ static int nxp_c45_get_sqi(struct phy_device *phydev)
 	return reg;
 }
 
+static void tja1120_link_change_notify(struct phy_device *phydev)
+{
+	/* Bug workaround for TJA1120 enegineering samples: fix egress
+	 * timestamps lost after link recovery.
+	 */
+	if (phydev->state == PHY_NOLINK) {
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 TJA1120_EPHY_RESETS, EPHY_PCS_RESET);
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   TJA1120_EPHY_RESETS, EPHY_PCS_RESET);
+	}
+}
+
 static int nxp_c45_get_sqi_max(struct phy_device *phydev)
 {
 	return MAX_SQI;
@@ -1932,6 +1948,7 @@ static struct phy_driver nxp_c45_driver[] = {
 		.config_intr		= tja1120_config_intr,
 		.handle_interrupt	= nxp_c45_handle_interrupt,
 		.read_status		= genphy_c45_read_status,
+		.link_change_notify	= tja1120_link_change_notify,
 		.suspend		= genphy_c45_pma_suspend,
 		.resume			= genphy_c45_pma_resume,
 		.get_sset_count		= nxp_c45_get_sset_count,
-- 
2.34.1

