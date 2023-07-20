Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5071B75A306
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjGTACs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTACr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:02:47 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC3D1BF2;
        Wed, 19 Jul 2023 17:02:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drXnqSw0D5daOEG/51nlrulzc60PZwxRHPOF1Mb25urPcoGCXnoHjgUkmRUJzvlcFaq03/gxrj11dKLx3FKBylKY3nl+c68/Dwa4BFw90XbaE6Mj8KgkdzwlNENLQrGJmXoOPwe4+/GDmqa5J6EJ5cl6zTv5633VRxC5VUBrJkIuo2XAcQhdQcjXwRui/5ejoZNcJSofhzvDWPv3CBKJyc8NZq2vyU4IcpiISN2holIhdpN9VQlUkywV7v+TqaIJTNFJjPGujExM7l+Cw6E+GwRHqb8ppoYvjZQVDarnTAVE49A3+VqpkrHStJWlmu6XA13TyJOy0C95q2aCIK2AiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlNd118RrjjlEhETkFp5aaJBjajtChgMgSnl5SHjNuY=;
 b=cxkjUVtaGxzpTFZhv/d+VEB5fV/LebCBvFB4jG4NT79uzSw06tWMi4Vgc0XVIe6izSI/b7al/cTTaNwdUNJzoPOUn1Ju06Uz0bSEZntNLjZxdNFg9jdID2VQTu0LKKOJHXVXAnuEH0h0T6xcJuqKTuXa+/WB1TaeYDBGXIW9FhZupgxz5iYmeacbW5DgdtN+zi/1ri5RARCzCOp8CR0Im+WbNNd5ezKcZe8xhQv+8+aNG1VJ9w8hQ3s11l+YhiqU8iX6bHQG1nsQHn5JfgF7yrKAPkQjq+Fvjewo7LIfrD1qQMMslyBulCvgP8YfGojaIbmetSDH/xpMEkCeqXWsJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlNd118RrjjlEhETkFp5aaJBjajtChgMgSnl5SHjNuY=;
 b=pDFUfzBNYJ4AciS5NXLs8YhQHACN4YoOl5LyKf1koSgFMcEHiC0sOlteJmxdDDAKrKzQS+grW8GgCt9QBwtSlLvRaXk0tQShMNJY+26jFzuv0y2sNxOldRD6QfcWiqu/BTjvlPWxNiZjjlHYSjfZFKfIZMo80V+Zu9I1K3yVhUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8941.eurprd04.prod.outlook.com (2603:10a6:102:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 00:02:43 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 00:02:43 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: prevent stale pointer dereference in phy_init()
Date:   Thu, 20 Jul 2023 03:02:31 +0300
Message-Id: <20230720000231.1939689-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: b3311cc4-af82-4df9-3ff2-08db88b4a3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79JIe+361Iojb+8MUEesfScdQFV/Wty2KlTTMLL3vJbuHac1d1FxC3WTQV8lOwO77oP94yA8g5LNue/4luYGuMBUBlNFI8JPWWMcZMCpHXKwdwGxbC5knOLGrqsAeG24NB3+97+95G2ZdBbmQdZBm3Xk0GXcKQkgNMLcBIXiBr0WJVZAekWs4zAEvcqE4XOJ8uvrvz1puTtWO6hSJHhCQGRX+CntAajtqlgCXABMH4O2K4x/XP1p+YZKnwFk7awK7mW15xkLIwQoszrP4i/m6CazCnITVkbtfCgZWLllKiJFTnLJgr0e53LZ1mYalcLrviNgklKidiSPLjPS+7n/GAtK0HSXi85PsVEH9QBvClCIkBGdojbBeQ6xMenSHYvZlE4kYgdfjd9SVN9q+vGqgp/5KjR5687D1MYCxVDxd6kAkLiemjsLOfzj6+DdDc/aZevugvPb06TmWtCm552Q+fxfxjbbxuz/XgR8lHagIioT80Gabhin9bPlGHB5NHuMSzf9LN+oSxB3SdRhnZbVU0oUVDTreJE40AEqtYhZ0fl3UcPLFtnwNDoy+wQ5MDAUgVusLwBegh3TH8qCbuts9Bg6GV6JTbDbpf7jYuHXnQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(186003)(6506007)(26005)(2616005)(1076003)(66946007)(316002)(4326008)(66556008)(66476007)(83380400001)(6916009)(6666004)(44832011)(7416002)(41300700001)(5660300002)(6486002)(8936002)(966005)(6512007)(8676002)(54906003)(52116002)(2906002)(478600001)(38350700002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T41Nwo6lXeUiYpxwL+tkFpthKnQCTmAhIWuR4ZKRU/88Y1MBS/SJpgXjYRPR?=
 =?us-ascii?Q?dcT3UpEE726ekXmFdaK+pgqf9Xpnbn8qonBgxJzkrrlyF5fKvvgxxMEf8D5c?=
 =?us-ascii?Q?0xHskldgyEN95UQD1UyZjDU/GicIFvIrrp4vxIebHZ+xjdU0n9yJFt2CkbCI?=
 =?us-ascii?Q?ODClLFpdBYIzuLsM7BtTBeattu90KbsHKpCdPJLPg8oZC5uqMkbdjqvgPkaw?=
 =?us-ascii?Q?iAebxWA1wq5XhJ+HVNvQJbjqE31FMGSbsYQczXGrpXQkE5J8xvXwKYtdTm6/?=
 =?us-ascii?Q?HC0912la5xto0uHQEX2PKoox9utLa9hjHxWqgov4fxULe4X5XbcTHZy0puZ5?=
 =?us-ascii?Q?xadJaBByxTdYTjdUgy9fRqdqgR1cBxQO1mj5UAesWhrvRN77bBAH/beInZs8?=
 =?us-ascii?Q?/DehhmmyKFtdh7QY6XxnmAeoHIYmrJcpdZ++2yMPVzLqw/lKZlTtzOxOrbb8?=
 =?us-ascii?Q?Rer/1COwBOFmvuJiTAsnT9PhvSg6oVIBa2lRyMA4jfp0pcqbsXJkqYpzGfVx?=
 =?us-ascii?Q?GkPHf1PFO+hBrANpMf9lqyWJeqg8jgX+53wlV6z9PWoPvUQBXFnUyXW2iUf4?=
 =?us-ascii?Q?zFdOZQLIBOga7v6x6pV/Esd9hsfawyqoWYxjpHzeppL08t1qD4fBSzU0kZqM?=
 =?us-ascii?Q?ZQGOq9lLsCA0mtTM9ZddTdAjLM+Zv5a8cjrRFBdYRGjnEmCKltUbZIzstPUl?=
 =?us-ascii?Q?NdDZJTGfUop/+3TVLF2hpB4755dqKOLTb5LaSZ4ZDuBWAXw2qIoHgkdjumI+?=
 =?us-ascii?Q?K5mBBOso+fH2bzFt1smq/fn8T8h+QA6zpJGhQgfbGegrr7UN0jDa6KETCkeE?=
 =?us-ascii?Q?+3pPZ8f8CRUfJJljf1Mu5EU0Bd0H+A4n3MCB6QiP6mxVAd4NGbSI1F5vilYd?=
 =?us-ascii?Q?HusDmFKBpYdfC/Tpa87IQCCh9lmkm503x4/Itk4k+Y1YcKsHaSQEEq81GBmI?=
 =?us-ascii?Q?Gux487/mIQ8OWiDjB+yFC6YfXWM7ArT0lzU4PM+kDic179cmmAj622OQ2F8i?=
 =?us-ascii?Q?YW2Fwj0CeXDKyDnEyUe1Y0kjYunoPAfD4ipeWplXS+lr2KrfrYicbnIOFKbq?=
 =?us-ascii?Q?+iJ45/jRp/aTaWFkvPDQTMVJMPYrGdpZMMt6eTClgjEU0iivtjyzFZoIVoWg?=
 =?us-ascii?Q?dZkSHVsXedA83vde2vwMaIRG0lbYrV1HFsW1BBLko7fagLNlAoJzagGmC2ov?=
 =?us-ascii?Q?n1XrxVX945ffkQ2h/L+zna4GX4/DKksKvnA30YcACHXiRXYnnQdL3CSqXUjK?=
 =?us-ascii?Q?lSO0yAl4okPlNovhh9NwnTkI1dE9RBfiNfX/SKHRpJ1Z8MXg+RD4BPVU2T97?=
 =?us-ascii?Q?mbGTRk+SflyV86oI6mFIw96ZuiFEfEki4M4cIa8WvBB2a8w0KCrLglNVNpdo?=
 =?us-ascii?Q?bmr/8tc5AJU5rEKYynqB1se5WDrSoYDxt/vZcZ9QmK51VlMvsCSyNofA6T/m?=
 =?us-ascii?Q?fTNxH/PSR5Ta34CBeUbrElSbFJJ03eYYrnpJB6MojIGuvwuzVSPIFEYhSUj+?=
 =?us-ascii?Q?LzMHrknH7l7HgWkF92rQywgbfiMpJsFF7MCz8AZwx5/Omh/p+gITQKWGuiRM?=
 =?us-ascii?Q?QEKmI27NILZ1HYfyFxFfgyWGArh84qgGIS4Xtjg9Dvuglty6dBdepzGB3Vya?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3311cc4-af82-4df9-3ff2-08db88b4a3f7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 00:02:43.2736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4rKSC59gBR6TPMFuIxpMJ3pBQeGlavydVwPb0nD3x7J6dLWatqqPD81ZABqmdGRpA6adORK9MJtPpVQ88VcZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8941
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mdio_bus_init() and phy_driver_register() both have error paths, and if
those are ever hit, ethtool will have a stale pointer to the
phy_ethtool_phy_ops stub structure, which references memory from a
module that failed to load (phylib).

It is probably hard to force an error in this code path even manually,
but the error teardown path of phy_init() should be the same as
phy_exit(), which is now simply not the case.

Fixes: 55d8f053ce1b ("net: phy: Register ethtool PHY operations")
Link: https://lore.kernel.org/netdev/ZLaiJ4G6TaJYGJyU@shell.armlinux.org.uk/
Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/phy_device.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0c2014accba7..61921d4dbb13 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3451,23 +3451,30 @@ static int __init phy_init(void)
 {
 	int rc;
 
+	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
+
 	rc = mdio_bus_init();
 	if (rc)
-		return rc;
+		goto err_ethtool_phy_ops;
 
-	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
 	features_init();
 
 	rc = phy_driver_register(&genphy_c45_driver, THIS_MODULE);
 	if (rc)
-		goto err_c45;
+		goto err_mdio_bus;
 
 	rc = phy_driver_register(&genphy_driver, THIS_MODULE);
-	if (rc) {
-		phy_driver_unregister(&genphy_c45_driver);
+	if (rc)
+		goto err_c45;
+
+	return 0;
+
 err_c45:
-		mdio_bus_exit();
-	}
+	phy_driver_unregister(&genphy_c45_driver);
+err_mdio_bus:
+	mdio_bus_exit();
+err_ethtool_phy_ops:
+	ethtool_set_ethtool_phy_ops(NULL);
 
 	return rc;
 }
-- 
2.34.1

