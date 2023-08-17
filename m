Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C58677FA4F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352836AbjHQPH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352817AbjHQPHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:07:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C129C106;
        Thu, 17 Aug 2023 08:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mck5g8ceeEiKn77tM1Pkgx2Mq6wC8T1FeZgIKul8BmvSCYKDaOX+7Dt8fWhdQ29F/SUgwyl4rLIzzkFBCJO1IkqWYeKZUWKJv3qBEEE/qIedmY3zW3v1vzqHmhJ0VnhCD0TBYuz9RxIKGj3k5A4KbDl2PAG4xbmc/bHwQH4WJ7gli9oKkE6brpssbkG1nN4dnwPiisqbMca2PJleM++v1ssmecJc6JKr8WdNqYPwgDbisJxlU4s9mMRIoOtdfuaEhvRDF4gYj4tWgQ+5W5ReAK5WYvoc1JVgSWJFaX6fJLJF9RPQHb02n29kKfIZi+3yJXpsVKpL+WsQjW16CGsywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8AkHZ8cYvnIpEOwkWEUYJkx8PnKV/JTVotjFoEl3Oc=;
 b=l8Ki+CEgeO+oH/yEuMK7spd3i8P+QFrmboRvqFz7Ogqe6dE9/DeKeInKYWLa2NS9ifjrlL0s195fnbI0BP8Zv5jyQZ4uyfpNSvS2K8GPgTS1NuChzCUALBP/AbqjkMK6KkuJxpo+dcCyOkKngKU5Xn9YVM0hFdGBFkGU8+QVN0sdqZ8bvMn9mtT8JpPc1QyhRCvY0KSVGOTyaMtS2+OJN4yhI9TD3Eddci2GMf75wL0lqHenxG7iu7jagTKy5lm7KXQI2cvWO42d+uAnZvaiDiPlwK4y+DHnxRYC0oOORoEH39IWlLg0pRSr7lU8k7HNLk2pS77SF0OKXyvj4nwpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8AkHZ8cYvnIpEOwkWEUYJkx8PnKV/JTVotjFoEl3Oc=;
 b=DL9qVRFvEgH4Zm6BRhLPEBx2VLSpdjtU4v4RFjZtlHiTNwEOEaSObv00Uq4mXPfUU2LuST6rncLj7yq9KQnY/n+j2//T4LUgv4qcBl3JMVNFq98+O+UbuRoQRpFa+FWXJXNmsN1ZumEbYQ94z/LOEhQJkuMScCZBEMdU2G+k3O8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB9469.eurprd04.prod.outlook.com (2603:10a6:102:2b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 15:07:04 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:07:04 +0000
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
Subject: [RFC PATCH net-next 6/8] net: phy: initialize phydev->master_slave_set to MASTER_SLAVE_CFG_UNKNOWN
Date:   Thu, 17 Aug 2023 18:06:42 +0300
Message-Id: <20230817150644.3605105-7-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e7790dd4-1735-4a57-22e6-08db9f339dd0
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dr4hbIfWHVUTdmwSgDyxVy4YVZMqrHCmihXThARakQJqDDBa1Ah3yV37AoB904I6seF4WBPzHWt4kXTvpUGeyBCpu1xnUBJYbOYeuJ2CuO8Pa342mPLtCOdAICoD4iDESIbf1mNjbJQrEfn0cCw7Yb8x/CExIfrnPBkKFKh4MfhGwDybTggrITrX9o3e4mQlfTSZweBshhpQS9oJ1nSSHulfuXkDNOG3lun6no4buQ4nBm7IO7G/csQnnslkGgoh2Eu7lxFw+qNC57A/b2VOvQUBgOWXlGq/j1lMPtYXzMfJY9SihCs+NgWR6+18+cKasK/uSM3lOtuB0nCZAmnfasZSZtkDs5g6S6c0pwSRmdUT4r/6NTQ5L6v4j5mDcgn+kfPdALH42vF5fuur4csoO6FXe7SvdwK2v/D3ZJFVEVvXbYWdIYX1AcZWNPXj72m4LTapHj5tvGsL1co2KRTFgO4ISIGMpC0A6So2lrjWBBiZIOAiB9UX84ctN+8H9RXKiuw02LtMVNFhUGmZkLrlC/I2/zlTEYvss49gpvaG4CQNOUJJR7ogciaXuEF/MT1VhTsr5WAAeSi6F09DVW9fGvmqBc9/7WmU0lARH2/glWYbWnkPr4JTmgkK9W5R0QQC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(7416002)(478600001)(6506007)(36756003)(6666004)(2616005)(1076003)(6486002)(6512007)(52116002)(44832011)(5660300002)(41300700001)(316002)(54906003)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Rn9knMI1/Hy3NRw5xHXdkCGgsmbzG9nhSOQj8AoECZEyhKcb+vVrYb6qgg4?=
 =?us-ascii?Q?03xb58qbAVX8Z4zAfmC0to+EDjMIwT0eNiu7rq01Yj2h8d6iwsMrpw2qNne1?=
 =?us-ascii?Q?h/pZi+DnHDs4NALEVaCkGNhzP/iGhuYhMYvCJ1qFFkrY8uTupJK18BwwVxwT?=
 =?us-ascii?Q?BZGEBC5KcQQHiTpChdmkMO4zXNLqqP9V8VzSOb3NGCUH/bL7ACFx7oR4bbAt?=
 =?us-ascii?Q?l4o2IpX58aS289ZFTb7pLiMu13jeCIynwgwqk8iV931Uj7fTPHCGBYSdHVfj?=
 =?us-ascii?Q?VlxICaq3sRdptS7m8Y5vZnwb04pyVj+PX39R161V3uF18gXXkXUVNj7GoNC7?=
 =?us-ascii?Q?SHAcWCOrXTbbv/dDATCIiw4jtFDvp9Vpq+4BCNG86KI1Jp0T+84jGZKEb4gc?=
 =?us-ascii?Q?16o6b1aaysXoFSIrSJjhvXPZaTBix6QUJDJCphegveAtaPxw00bm0Q3H9tU/?=
 =?us-ascii?Q?TEO2ApaSfqX/RMjbW+3lsRCblxkhRl3YXQyFHw7+0w7e2ZyuH6KGfnC3377P?=
 =?us-ascii?Q?J4T3UsNxj+b3s1D2oKiubA70bVbge+3/9U4Val1PufnLuUPccMm7z6+oSvIA?=
 =?us-ascii?Q?8uEq0tCRMc1M2f2Ff7lcJv47oUHCs3n19T+Y7rpipssYzKL07p+MzV3QaVQO?=
 =?us-ascii?Q?AjSF+C/mwWIDyIpQ9J2fXdSYfO6vlicmfphJcG4kdcQKIB6Vbluh171VMLCV?=
 =?us-ascii?Q?hz/t6ZkUuifWahlsJ01PEfAGsNFptlbrMb5UTnFCF3me9jPU+YndphyZ/jAE?=
 =?us-ascii?Q?sPcz4/xL3EBH/d0+CAnSyedUuCk8Z9vYka0od16g9lqszYxYJIe3DxqjgHzf?=
 =?us-ascii?Q?wr5qGyZPKRhCkcBuk+38VokkAAv/0fcFyx117bJVNjQBIG9EGxrRTcQuIR0l?=
 =?us-ascii?Q?0V3k6479iZZDtljNZ70yE4o0Im4iCCobIV1f6y9D/rcsKTAAt5b8KuM/z3Rh?=
 =?us-ascii?Q?GCFOpmOqthRCLcSKI4THHzQ9MtU0L4TAYXxYETsiRG1a8TDG8Pih8iA8tLkr?=
 =?us-ascii?Q?uod+BbbQsenR/9rA1+Njk7aapLCSAfwmeFwEJlzwnb92dsK4gr54qUntzvAA?=
 =?us-ascii?Q?V5UNVMJ/bS+74HWQcbAu3bpZ1ASOv275xBGjbhtzQDgLIQSsjSjYYtauSo52?=
 =?us-ascii?Q?EGXirthAw8O7BQfKrWgKjvR+dFZGQ50eThJsk7Fs5NDuS12qdotAqDXdEcua?=
 =?us-ascii?Q?/H8YqcpS9SpxE4zxgCJPvefVqU/m2r6tSVQKusWreiPMcpgfS6ztTiYCShqk?=
 =?us-ascii?Q?F3LhL78jluzERTWECggunYMDTlXXjeGlt/We237sLDCz7GErTlWd9g5Hzr4J?=
 =?us-ascii?Q?saQdU2dqxgql0zmzYhhGxc2Y2SEBphva0S9jYRepPMXR0NlAEE3w8X0zg6Qk?=
 =?us-ascii?Q?+ykm6g7GRFrnPh01XY5l3+8KBejUwmEtsmkp+3JOdfzUkAw8LezijKUrpd/f?=
 =?us-ascii?Q?voErRNb8deiMdwdaqh8Tx8urW6EHWLho1vFqoBLn4AVMVLGML1NwFQkhvkPs?=
 =?us-ascii?Q?e+SAQCg40YKLWkqCeux9oUlkA6xQA62jvCMe2/rj/zxqCVSR/fHJkyJ/IfoM?=
 =?us-ascii?Q?q3wx6zSn7RmnruZKGom+HVjIkxzZ11fuonm5omybkfjlMTpE7ypCgUVULF34?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7790dd4-1735-4a57-22e6-08db9f339dd0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:07:04.4620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqZYkxD31DRUu1S7Vnt5ymt8TZRRxfZo27r8xDHsNCzkaSRI/VHR4Ll6V4flTkqInzUGlR42Y10N32QP7qwwkQ==
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

It doesn't really make sense for phydev->master_slave_set (the user
requested AN master/slave configuration) to take the value
MASTER_SLAVE_CFG_UNSUPPORTED. That only exists, AFAICS, to detect
implementations which don't report phydev->master_slave_get and
phydev->master_slave_state.

Permit the most trivial of drivers to exist, that where .config_aneg()
accepts any user request, and is implemented as:

	/* We support anything */
	phydev->master_slave_get = phydev->master_slave_set;

This is currently rejected by ethnl_update_linkmodes() with the message
"master/slave configuration not supported by device", precisely because
lsettings->master_slave_cfg (which came from phydev->master_slave_get
through phy_ethtool_ksettings_get()) is MASTER_SLAVE_CFG_UNSUPPORTED
(coming from phydev->master_slave_get, see implementation above).

By making phydev->master_slave_set never hold UNSUPPORTED, we avoid the
above confusion (driver does implement master/slave but still gets
detected as unsupported by core) without special casing in the driver.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/phy_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 9cb5aa04b2b5..e374d1a57030 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3276,6 +3276,7 @@ static int phy_probe(struct device *dev)
 		phydev->is_internal = true;
 
 	phydev->suspended = true;
+	phydev->master_slave_set = MASTER_SLAVE_CFG_UNKNOWN;
 
 	/* Deassert the reset signal */
 	phy_device_reset(phydev, 0);
-- 
2.34.1

