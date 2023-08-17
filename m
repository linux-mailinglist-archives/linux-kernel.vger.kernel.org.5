Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BAC77FA4E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352827AbjHQPH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352816AbjHQPHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:07:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226FB2711;
        Thu, 17 Aug 2023 08:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YF3MjuW3rRsmiVFfwjLKIUupHeVZjhzS+QnRi29fYfh/zihOFeT0fq9abLyXlRZ50lZEJN1x/MmbshOy+VHU9GyeH0mXQoiMO1V3XbU3ur0UzqXM3CiQDbZelLjRSOf2V6/lY516BWnsdmpvfEDLQJ09KRTBzvBd9JKAMMKwZ3Povt8ArzYLbvLyen8SpxSfbDk/ssJL8xL8bwD8QLVcOYWE27pcc+Jy/MrvEVCbEsGUV6Sl5/iHlxvRxwXlKw3U+4T8NuIMrC1TkhistrVteFrSvTY6jeWbdWXdkoNt/hLJlCdZdFp4lJjOavekrDBRwKaOInrp71m5nNvU7xVNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7ImfiEnvrOdShACecPKky6yj2SGCUD0V+OnjaenyPM=;
 b=kyR39mBvHZjCQ6l5mQxI9YxqHelIl5R098IwwLVdbs4xOzRvs6thgsPxsySRNnD8R3xE3i576fy4tBjGR/4Umem6olCB9GW6XvPBj3jKhBf8ssHrggvQXv4LR5H92rA4fgvFmTkTkbCZtteF7/k30alIcOTS3kqaCJcXChO4HbbyoqagOVM/Yp5wpwatgr12nX1YYPuMqgrkCO+2u/l6iKHCQclHsP7VD5E8j8kNldRKVbf0wMTM6+G+kpEJpMtkJ03EMdyQsFjA7y/qvq04t1u7gsi6uGO8pPs9CEIkWNvVH+nzcIVMyEfA2so7GBMwBYtJSdvOYvQiZKLk+LQhDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7ImfiEnvrOdShACecPKky6yj2SGCUD0V+OnjaenyPM=;
 b=ZnJ8f+aHNdPZn2OcGrTqtVyyz+F8w1g7BS9qoqldVSjifYGv3edGGmmZ3OlYGXTuUGQn9FmUSP6L6g5inl67iWPB1BvNpSKuwAeGvG1I85yNGXwbKsPxQbzC3aASSVaMIgzqPNJfhnEArdZ0tof4PIn4AqW1Cy/xadTmKl9V+ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB9469.eurprd04.prod.outlook.com (2603:10a6:102:2b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 15:07:03 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:07:03 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: [RFC PATCH net-next 5/8] net: phy: balance calls to ->suspend() and ->resume()
Date:   Thu, 17 Aug 2023 18:06:41 +0300
Message-Id: <20230817150644.3605105-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
References: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0137.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::34) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b0a30f-6ae3-4060-1b46-08db9f339d03
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4/WLngJ5kQl9EJWIPzYKIfdzA4YeEXS5vh+KGimr3WRYrSuW4AFYYjySygxSLH9vpXcgQRdDywdtsmT70mM5xJ2e+JYAXSL2ufOR38QaITsBR6eFw7U91YBnHpqNdABqqZpCpKeIfvg5HpnDtbI5Pn57wn7aOHTfZMV/S7bFonoVKwDcHPq8v1ibyzV+1D8q8Y0GGXVAWn4ddnUlEjborRVhSi7JEn0hwDBmDg9yW21dIX0rwLlgt1N/kwGM4m+oYqM4h+jhiopQBET/jOdFxBmiFGOpl4YyemFRpLrVu7TB7ntaYeWVXT46bnLc6TqviYZqgwoJIYgVN4MGfiyktD5BgNaTlCrYdp5e9dvGRvWtP1MpUg9Qf7levuJudXfSRJ2llb3C3AfyEHXrYauew1eLUf9ay9OhlJIcEL0ulPlbk/pcVnkYal3zXqpyQk6lberwzTiyycagrkh7n5ay9t3JnZDLrjEndRaaVOyMhxDBx2qjb5uWNfLiMmCynOckvykbZYSGoDGhVzalC/ZnDdqx9WteornifJCwQPVQGD4AYRlFlf6ORdz9/KQP6VkXFYirbtO1WEVw6rpMsRk207e/F+ifpbiy2azJP1EH0iBdRPlzOUG3SSaKMk9bxwi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(15650500001)(2906002)(83380400001)(26005)(86362001)(7416002)(478600001)(6506007)(36756003)(6666004)(2616005)(1076003)(6486002)(6512007)(52116002)(44832011)(5660300002)(41300700001)(316002)(54906003)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I7fHMBh98sjb5aWPTH2XHflAZZC2ANmJ1ZRu34ywESbPya3hyZVvPkdJPob0?=
 =?us-ascii?Q?tHoOvGKR4uNEEC5eWyZ2/2nCOQqFMKcidydBSa1WOd2m4XbsyPzHpMEoRts8?=
 =?us-ascii?Q?KeaUpTTPVq2uxNKHC1iZx9b6d2tozDztEyp+TZ+XZoskv9Ua3PqSdkGvOLAR?=
 =?us-ascii?Q?yaJ2TdQadWShcTqDhLnHhCxLpPuqbLVvVA7pUdlxz7ru5k5ddK/No8tqG+4t?=
 =?us-ascii?Q?BTKxwcphR1R1AB8qOK3UeD8VWMIVFHx6PP0wjE2Q0SaCxTM8P/lYMgP6Shtt?=
 =?us-ascii?Q?9bZ8ipDcPslI9eOvut00XeALkHN39C/TMTBvpIFVQ4jYUSCVgiPG1UuSrOj+?=
 =?us-ascii?Q?pK/ad9MqT/fNzjCiAQdndqhILjYiQnMXFFqLd9Q4OejcXUF+A2Alub5gdtW0?=
 =?us-ascii?Q?JyIOmK6jao9KOaPImL/uyORxmj6MF5JG9rSQp2691hC54SjA/SdEZCArotNE?=
 =?us-ascii?Q?s9HdCXHo9YJ5Qv0+LKZvjhN9lrRsS/Zei1hn4JmgEmvrUBmbL/o4qRM2AoM1?=
 =?us-ascii?Q?bsP7zfdAEKoPXK6/LE5+d952pAY0lZTKQHE+htQmcqJAOyYzGvMflkVH32EV?=
 =?us-ascii?Q?cx9cK+SiXNFdNhb8R+dCiKw43AWfm4IWmfwv4kVS1R8/WiVYAyYaIJiVnvaK?=
 =?us-ascii?Q?Lu+oFMktJRKKs1hrLBHnQNzQ47BhwooaeZnCuEAOj30zR3WCRutjNx4rPiAt?=
 =?us-ascii?Q?b4Dcea/FYleIDIzfTUY50AN1bKJYNmb6c7M31NgR7vzoWjzivKQbga7Fu/5/?=
 =?us-ascii?Q?P96WCBEwe/qKM5XXxYf9gHzUHQqTNKu5Ktf+eW4d995UxKfqePG4Luyj7wcx?=
 =?us-ascii?Q?9062uFD3q//rYgTQ9E8lon1oSvvaJY+Mfwv4D79mZhV3YkyV7GwDhm5BfEOT?=
 =?us-ascii?Q?NM5r9qSLSx724Z1WhQX03WP33jc1haHbYIBpsKo30bvnygGNin25SbbqpE4F?=
 =?us-ascii?Q?pJi9fg6esm8z01Hv52Is3sNDW+ckhWbrC6WtUaGaScrD6KBnRHbhAJK9+fCZ?=
 =?us-ascii?Q?AJAw0UMc8sZe7esTPOUIPz18Cs4OXC3xhaabqXc+qRSn8Nycvp/LkiUEo/mz?=
 =?us-ascii?Q?+d3eikp+tIxFbMTHaWTpVEYZK/lWhGcZPP0O60vcR8QBUpI9cSXk0cO8qrDA?=
 =?us-ascii?Q?U9xDOC8ak4K7a2IiOvoXaCQiRoGi2Jk+KiBhbj5yJaF7RSt4/cp7Ngy3uScS?=
 =?us-ascii?Q?GeLieFimZPzHv3PZLVj4O7cnYt4l3GFFyrHxwSyZY5dbnczaEwQp/2tm1/mg?=
 =?us-ascii?Q?XTavL5RyT98GZ9qPchUJovkC95nd38NfalvTMKaYbcVRLaxjjowytS+56XlD?=
 =?us-ascii?Q?EFLUya0gX/iyfi3cRZRi55PX+3v9JP+ZV6Hup6tuo71tm7eIICRY8SU0G0S3?=
 =?us-ascii?Q?/pzQcRLkd4k7tbGEnyTjiqxFSIoRj5SXDNTXsGurNAnzc+Faw/YkJITO/wV5?=
 =?us-ascii?Q?6SoWkNmB5cXMCTFGx17zgu7gIQvjEo9aOef0pBEr3oV55zyAy23icCVPJLpz?=
 =?us-ascii?Q?9oufXjbEewV6lPWK346XfWzDNA46s97zjY+uATgzo8w0X7QNshxMd7jg75Br?=
 =?us-ascii?Q?WP3iiKXZIBScuT2LywUw4MRwIaNx9tAGh3Qd5gMfdYSBdaieSfKN+/BCdu1n?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b0a30f-6ae3-4060-1b46-08db9f339d03
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:07:03.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ww0wmgaac0f4dbWMOEZ10UfjgLSYHEzylfLYuzZTAlK+DH2ylIerfhbaziQnG5ZP06+fQY0wktkHQXJPTBN1kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some future PHY drivers will need to do balanced stuff in these methods,
like phy_power_off() and phy_power_on(). Currently ->resume() is called
twice during initialization, leading to phy_power_off() not actually
doing anything during ->suspend() because the refcount in the generic
PHY core remains elevated.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/phy_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 17cb3e07216a..9cb5aa04b2b5 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1882,7 +1882,7 @@ int __phy_resume(struct phy_device *phydev)
 
 	lockdep_assert_held(&phydev->lock);
 
-	if (!phydrv || !phydrv->resume)
+	if (!phydrv || !phydrv->resume || !phydev->suspended)
 		return 0;
 
 	ret = phydrv->resume(phydev);
@@ -3275,6 +3275,8 @@ static int phy_probe(struct device *dev)
 	if (phydrv->flags & PHY_IS_INTERNAL)
 		phydev->is_internal = true;
 
+	phydev->suspended = true;
+
 	/* Deassert the reset signal */
 	phy_device_reset(phydev, 0);
 
-- 
2.34.1

