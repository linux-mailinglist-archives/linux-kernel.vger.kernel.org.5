Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5715375F98F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjGXONo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjGXONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:13:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F6CE5A;
        Mon, 24 Jul 2023 07:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUXoFqrfcjRXI2ZzMLldgN24lWBzGdlniU8wpgVDbG0No33mLaBYSVD3uAkPTFvA2ja+Dtu01Wx3XLPfjqVfwWTHyP004JfieGi9/jSLdOwTGz8izQ6O0kQ90qLjhl8hBnd1181Mr8JgBA2BeJqz6+e3OcYlZREsaqEnsF0hFZVRYvsGFLXahrsMzovbxGrzaMfKthARp3wcbo7gXjRmjdyGMghnASsFliEnnycKgdGRez/sGG+F0rbEQfyVSaTLoPPUnu1Ldy3ZtJDSAmV6D/R9igTCl+577mbOpxPHODzg8vbPsNfERILcLBE2M0KFX2Jwe6ECHYb0II4UOzO3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TYf3RhJsN4JxynB2bPI2CrQCmJo+10Di484d1szIko=;
 b=G3jfqBP5FX3aDC41yxUTWeekEYEYx8YA05h19Z2yjT9/RpOhFoXn+xZm5z8Ky70SzosQzYmES2J10EJjv10Id6ccMOi3u8UvXQJKsTFNqhr1TjksuNMA3fOG49m6GTd9nrhRzskZAYBkLttb9yhLPNsjewnXiVBJM+UrsHPc3VggC5j2G1+Ft0zB/v7S6OBUcgcAIdUmvxQVDunG9vJfJIuIzS9dnk1bSY/bi0b91DDsYTNsPJ8/wy4l6x2K7cZyXbhLWwgP9G6J18aUrAfmIwuXAsPrjn8q7BrNBvTcW1iWpQpc35pwmniWCPj//K4tX7ixtRfgVz/lI901DmvYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TYf3RhJsN4JxynB2bPI2CrQCmJo+10Di484d1szIko=;
 b=erw90JWfk2mWQmE3K3nv7uZbPA/v20ddkEIk3N3xNo6zocpH8dJ1h6D7qGWbKKR9/OA86HdRWivadWwfsOgSh1hVLNt01ViWO6GG722wfJAgg/mLIs6XBXqunNYkN3g5rgjNhB+wQz5CqmmnLqKwB6K2F8uvIXDYlnZQnyTcR8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS4PR04MB9690.eurprd04.prod.outlook.com (2603:10a6:20b:4fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 14:12:52 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:12:52 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v4 09/11] net: phy: nxp-c45-tja11xx: run cable test with the PHY in test mode
Date:   Mon, 24 Jul 2023 17:12:30 +0300
Message-Id: <20230724141232.233101-10-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 41e60216-9182-45ae-20a3-08db8c5011ad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rY31L3jgchtSyybpwPPHixpMK9FTCKqO7JBwnmzsOr6vqoKrbRq5uLiei7oVEdDtjtg5SfTwvGA66rD5pgouGS4f702cHCAvIenFuuguJAT9rCqinwEaXeebq7N/5q2UYFbTs29eSdxpsSoloP3jrGdpy8b5vyJKeViyB+W6uuabWTf4IgJ6/08tFzL9Lio6ZzHNf2srcCJcMoP502uz41rSiIancQMbn91U71/57XlS9tPKil39rrNmMt0HMTnWKjmu8GGxblH70VfFXnXZt0Cij4W8BpEAcs3vHD0bVkoEPgNzE1wpvvcl4zHd+x8KT4KWafAit3eY7V01I7ZHaM0ULxMIM9Yq+XAakaPH7mdu0KhaX5Zg/5U+GvcOIMoy5aQAHNKqXC/G9o8wuy9oqyx6waGaLj4gTeoSFxWZnW3AdKFp8IPU2Ip3kpUKk1gwYk24N06xqYGmCH/fQNLABcLQIhLlYRoe1gt5K5mxCjBnAMtUOgjEH4uoGFtfgOG/hsBxqnj7VmBltmb0C+y+wsZ+xu4hZFTEOWL3DUJoEaEXm5Dv8afPLv9cxPswtfNESa+Nws7DOU09j9b8Rj2n/u9dGAK6kSNNrgd0aAXtagZa0mBHR5eavRz+TMC84s3y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(8676002)(8936002)(478600001)(2906002)(7416002)(66476007)(66556008)(66946007)(4326008)(316002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(6506007)(1076003)(186003)(26005)(52116002)(6486002)(6512007)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8irZtnI6g80df1BJdbN7eoboNhcWlPDc4jJ/6allJaHusu2iVwh3Efu4woXf?=
 =?us-ascii?Q?do8FTtavYfIWvO33RiSdknVY8udd264vlXs2wZLSvW3vXjxSJjNG3YMquAEe?=
 =?us-ascii?Q?z6lMFNaNjdjmeurglTmG/B4kqrMh46OR/8AhRIfFtQLilitdprwGcfkGsYRI?=
 =?us-ascii?Q?ezxagJCBxIWRJEXjnocELNmMBpAuRetS2kjgfgEijb4zBhOU9Ky3u+Zd/OeT?=
 =?us-ascii?Q?m3c8YR7WwGWslIX/rp+mPhBczRszieHkXN+LnrDNx66OX3gSM3oFR1au/y4S?=
 =?us-ascii?Q?yyySO6O4gAsVhCD4zzN2j8D+DzPDOrCcPv0FQDHXYnaJQiut3grWIIguX4Kr?=
 =?us-ascii?Q?mstzUVVoTUkKPMnZWSfCpra9hBOnKKz765G3q0AIrTKwYbIQLMwwe8psZtIz?=
 =?us-ascii?Q?3nb2B6iAkfRGbx0PJ6ILiYXtsUpp/GsXUstKrWdyxnOq7JGZ1cCeHg3VYwd6?=
 =?us-ascii?Q?uNkOM5N8ENahxyVbpPFVfyrjx97ZbcJNbKu/Z29LiQUm3RBzUkdJHXuygLZ5?=
 =?us-ascii?Q?ntj3vqDt+p6ID5YjPsUqm832fQu+Krjyp/lyTXkOlIjV9a6Phn7A/P2sKnVM?=
 =?us-ascii?Q?qI1YweFtRa2II5tyS9z4jf9l4WLUbb3mKWp3ESlvobJ+JN9uf0aa0JuJzfAJ?=
 =?us-ascii?Q?f0bHBc2ctvLlqCfugCbOna3fE9LogC72VDHY8tvDPhe9vb4xQIB6crwW7rdD?=
 =?us-ascii?Q?fzWeEIS27Jp9D/rlGCe6WCWDoBggFsWEni85VKdIKpuFbgPBCxz3odSe9nUE?=
 =?us-ascii?Q?ve1f/Bai0rgqyZ8Yld2+rVWk3K89qyr6Jjho77LsErc0CctB026hHLYiL1wS?=
 =?us-ascii?Q?qrNJp2PZ+ApJAThk5AwlQ6DnmhaxRZqyuh96IGEe1ekpY+vf/Hdjkn0GwzMf?=
 =?us-ascii?Q?ovMOhhbketArlpbA+nvNp8Qj5LaOeEREGdVPhEC2eapIVwkjPQ8JzrBTaJF3?=
 =?us-ascii?Q?7TGPpaAwvERwC5RPBV3tmbf8BDHhe0Xpg209rs4ruj8b07Arf+keMsQV6fZA?=
 =?us-ascii?Q?ZD+hun7Hz81ZN7zRVD4JPwvFbRF5f+s8wQTdOrJ+k3+wD6vfnlYi8cVMMSxS?=
 =?us-ascii?Q?hBXMBLQ8TLYnCTA8KdRd9RWXLYbDjFqD1mjuBGRyUkKlZHmjovs9HjAXNsa/?=
 =?us-ascii?Q?edagMxpZHFGaB5LhDPbDZyhOLOAYyEMwfPxKYbKO2wYGQXBCoH2NRiof/9Vi?=
 =?us-ascii?Q?ljyK8KSJyJYmMcUWBcJXPVeep/U3zdC+yJBRYAa9phBHYIfgO6/WkCXpHGKs?=
 =?us-ascii?Q?AycPvuSanhpCRgmAmDTCzaCpvnKCv9AJuWsI1oRH1rT9vFAhgYEy1tXTV/bN?=
 =?us-ascii?Q?P2gEWeOpp47fYxN2jzxB20pBGcEYikiX7b1wGUdq91yZxYoCjsDFHrYmtW5t?=
 =?us-ascii?Q?R8Dv/yLejjSAItTjtO8FYfINVB2BsSRo0DMbhrZuGG19wTs/pFvPI2QToAIi?=
 =?us-ascii?Q?NZNHrhNwH7xwNT6hoYaDVIrpTUmJg2ArYtBFOjBOU1uY0LvQGmu38kRC+eAX?=
 =?us-ascii?Q?sP7Ooot53YHWATzCUQcwywtpyRUuVY0XuqfdKT5yS9ro2uAzXXDAZikOW/kH?=
 =?us-ascii?Q?2tVlNzpi5yi+Tlj0/wzN3TthDFRlkFaXy1pHeYB9F/rpQYeoiTrnB+u+3QGI?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e60216-9182-45ae-20a3-08db8c5011ad
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:12:52.6261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PixnRGZrLlyLKofqU0Jotpqi8CMV21+3WGyescI8hgcXgtnFWCltkZMaZ1X2TZOtezZ8YzkgxFFMhiKsnJCy4RAxN3CIeJHGdFzq/4lNGYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9690
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For TJA1120, the enable bit for cable test is not writable if the PHY is
not in test mode.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index a826c845ee7d..8097ac8d6962 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -145,6 +145,7 @@
 
 #define VEND1_PORT_FUNC_ENABLES		0x8048
 #define PTP_ENABLE			BIT(3)
+#define PHY_TEST_ENABLE			BIT(0)
 
 #define VEND1_PORT_PTP_CONTROL		0x9000
 #define PORT_PTP_CONTROL_BYPASS		BIT(11)
@@ -1258,6 +1259,8 @@ static int nxp_c45_cable_test_start(struct phy_device *phydev)
 {
 	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(phydev);
 
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+			 VEND1_PORT_FUNC_ENABLES, PHY_TEST_ENABLE);
 	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, regmap->cable_test,
 				CABLE_TEST_ENABLE | CABLE_TEST_START);
 }
@@ -1299,6 +1302,8 @@ static int nxp_c45_cable_test_get_status(struct phy_device *phydev,
 
 	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, regmap->cable_test,
 			   CABLE_TEST_ENABLE);
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+			   VEND1_PORT_FUNC_ENABLES, PHY_TEST_ENABLE);
 
 	return nxp_c45_start_op(phydev);
 }
-- 
2.34.1

