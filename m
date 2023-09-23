Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183DE7AC26E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjIWNt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjIWNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:49:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6349B1AD;
        Sat, 23 Sep 2023 06:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Au9RnhxRxuYrNIecqSBFLUj6un40ZVTzD6CVNIvdl8gIgdmAX7uE4BkVd/i6hpdHkEb/pwnaIrYMRddQwm6LVhjXvOXdi1v5/QLSAIshsLLRkno/jD2xFSXmTQv74c962aZLuKlSflM1NDESEmxK89uQPx4ovFppp7nUv9B+GsfKkoQkBLKeypKlyBEMa2/s/yPpjCzHT3WJ4m5Y4J6LR0SI2YYTnwN5CSObbwSfP85N80pe9Nj19J2pV09BnZ/3uh9SnVn5AdczOJ+6DAi7ftdOCcyPgKqaGOSdZcx2j2j4e5S/2DH/MS2kNqsqSK0Pcq2nruVfT6Q83/5FzIp5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiSwOhxch5ounlXMEbCvqxtOsgRamFp18/3AewOcUXA=;
 b=jVxSe+N0UCsjP3d7Z2RoyvGa2eKDXADp00/P7rUwM/1oszctZjWQ6ecrcN0V6b9e9lCwMWNvxTXxMxpj7U9pnLWIDjZOQYUKHR5+u+dTLniW6DsAPttc0bo9Hzq3Ddn1T4xQBxf5rqGlA875gnR1+8RjAQLuroutq731t+d+77WY/jDl0MD37D+H1hFp4sX6Pjq/ypJ8nIMG+gsi0gQm2vo/sPW23JGQjh1uYPwUEyBpubwvrmMhuvajn3+xCcUVZSG+JYfYmfX9Pf1nKnfgUTixZr2XByWDN98vvIO+lu5C8MTWLRiTQ4RvmDkn8oxcm58COTuRRViVXLOKivad1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiSwOhxch5ounlXMEbCvqxtOsgRamFp18/3AewOcUXA=;
 b=JhEPZf7Das5BUGkWfbynAJTgZhUJ9d9HWzK2ichSRyCosV/kMk8oTQ+xCQDHkk34DOHGNjRjaM5P9oVoM8H63rc2JKOnjZGQe3yFcenj2CsdlRUNUEeMkUYWMRwdeCxfxeuTnfuYIzDAhB/eYZgr/pvPCsfI0/O6hTQqTwSxmh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Sat, 23 Sep
 2023 13:49:29 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6813.024; Sat, 23 Sep 2023
 13:49:29 +0000
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
Subject: [RFC PATCH v2 net-next 06/15] net: mii: add C73 base page helpers
Date:   Sat, 23 Sep 2023 16:48:55 +0300
Message-Id: <20230923134904.3627402-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS1PR04MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d5a709-02a0-460a-b97e-08dbbc3be887
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJS9s+jRz96uWRHhHlQ5AkbU2skR4FyOMT0jbK4Cr71VyvnP3zJwZy11Up5brgwnC6wXaEYw1lJq4cbjbNl9z2ysmrL1vkyfldaQXKnoqnfcyu7VNhXCql9uESma1Q0JoLvFRCR4lOysbGgR7wYGGYmvv+1AtjMiY4tiJjRBmTVXsByMj1rneSon32KPm7LX1ythSl/5v74pfEdIefGvnwKVJ0TmuTQLphmK84PhSDPslcBQEwVif/dXvDqg3PgVBuSZGpP3FONIz9jKLYwRbjN1OTZ7UGlWeQAxjpHiBT6gDqp7cvfJxtAky4MRVoXIvbIQ2lvS6kvBE7JuqQ+WLX3xjr4qvhQ2M4j7E6Zau/L4gLy13WvPGVTqZb0G4YCG5aUzlaM6vUB++TMFf0xuoAlKw2S/E2fuWeRr3S9jdbfiznaX6R5tiGTGEKoOkadpx4BeVWqwd9rHx7rZXe8PPMOCzj/mk/9Bl4wKfii9u2K1vsO+nV0sKmBD85GpLm+kploAbpAvUShqTmFMk2x7J2MlhNaC8VakIWQ+DmU9uewQiALf1dbARUbOHojozVo2a3aiHmMwcL9aqAhomeLgzxmxCabEp60WOQ73vXVzjSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(66556008)(52116002)(2616005)(6506007)(6512007)(316002)(5660300002)(19627235002)(66946007)(38350700002)(6666004)(478600001)(1076003)(66476007)(26005)(44832011)(2906002)(4326008)(36756003)(41300700001)(7416002)(54906003)(38100700002)(6486002)(8936002)(86362001)(8676002)(966005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TLBAfG097hRsAi69qRxiC9GK1rSZPMBPYRPG0bzDqmjQOKTvNpz2/l8d4gOr?=
 =?us-ascii?Q?INs/+JofosOiwMQm2k1syuBOAHR5T/Wfi1BpDwuRv6R5E5anUnI9QcZ/GjO3?=
 =?us-ascii?Q?y9K/gjWEJ5FEM69wh2GdYO2Oq5TyJmuAdlQlqu3O9jnxvkprB9eWm74BJ8lt?=
 =?us-ascii?Q?+2UKqzGF2KbEMxQn6lj7e3QGaAkEUaFCJbk1uKfwaunaDh52VZIfB0okRqv9?=
 =?us-ascii?Q?Gsc4v+7qECVnjac2EiJbmawCcrV2VmP5K8BODNyVfBtfRXGwtBEbfFORcNRj?=
 =?us-ascii?Q?qED60BIIL6d0C9AwNUckvE/zw6WTz56JYpOagZCFPqXUTCbNF5ByucWA6KyO?=
 =?us-ascii?Q?Rlu3VRLzOCFd5xgWLpoAQ+64c0/kXwY09Xck10iZvpfDlFciKHBOdQAj52qO?=
 =?us-ascii?Q?NjZXLkB8W+jhQoZuBdH9fzX/C9mmRULIb8fMYGYlPMrZ6JmiRLx5HS7HFLSC?=
 =?us-ascii?Q?jELhS3BNLQR632Eu2Yi0u9vFQn8cFeTydqszVWxaotLcFK2N83XtKswuL/vK?=
 =?us-ascii?Q?vS/HlUYGozhK3xmArGmWrWHYLgOelgIBeSm9X4VG6e8+XpyPX7lOhSWDQ6m2?=
 =?us-ascii?Q?KZGMuPaVRK7v5pLu2Yu981kWscQsjDm6w9RVPbjfoS2Tbs7t7hXHiUmcL8WV?=
 =?us-ascii?Q?V2Qh8SPhTFiSYWQ4fpmP3a6N3XX50CAHfrZPMs1dpsJCFZuQxLHdZl2dVlyn?=
 =?us-ascii?Q?gnw64le4BBiTmHfPEJr4nL+/xxIBmY0ayztXasKa21sESg+eye1Lb8UszEmz?=
 =?us-ascii?Q?btUEavKqxouDXiouYl7Gytgfe1qq4f2U6WpyBoc7qZoukNkoE3VBPsqdCNrQ?=
 =?us-ascii?Q?IKJBO9QNyQPVe7X52hqDt78KHjbKJKTs8AmKSBqyb6K4qFp+bf4toAknjIQV?=
 =?us-ascii?Q?13YgfRpuVMTG/Z8gwsXxB8uDZFEfxY52rZAHyqVwDY5Qb1fzDy/hgR/wd1WL?=
 =?us-ascii?Q?5CL4mfudIiPhtvqK5wu2Rxi7IwzyoYuySNM2pHy5TlXJ2cl690Fq4wuZ+K9c?=
 =?us-ascii?Q?/DKQqElMYY3jiRWfyvnevf+ywmvk5ejv5GIF7qeuW9P9mGAGHoq6G4gCYL7p?=
 =?us-ascii?Q?LesKzQryB6YfCSkkPK74A5ot4FBfUQOLUUyyD3Suu5prR/EX6draJfokLR9S?=
 =?us-ascii?Q?PhcQEOgvTMrvB631WcuQjAFXXv9/kwylplD7HElVcmO+q5Ilb1ejGi3SCeF5?=
 =?us-ascii?Q?WH3TlXbCkHBM7hYibEczR/UsTW0vRlMdtciToPLT4+GMTEmdJ7piOfD3Pd/u?=
 =?us-ascii?Q?kstWJwzGcQ4rdMCL1IrdgPfj2tNI4lzcqolkBVA2kKN4um+J0Byl7D0DF2EA?=
 =?us-ascii?Q?tb9C1rRMNlEoJvT+PBk6NuR3BGAnJcjwZ+C4dX1x06p5iyp3xVZOlLYSOm/C?=
 =?us-ascii?Q?kjlOaKYES3j3YMXNNaktqHfRbWch3cXSz5qGeUIf2dEw1S2MXF1Ukj9B7iPx?=
 =?us-ascii?Q?e+IEKomHNXqiBz1YBvT+JvDIkuz1Ika1HZGbvlrjLCKofACZDbHhY3hjApoI?=
 =?us-ascii?Q?cpF1LKdWsoPWSrc5rCsVB88MGlOAMf3J8xfiUmEXi7l8rjbk1lEldkK/mCsj?=
 =?us-ascii?Q?3zuVT3W0LN5T56mMHMeGHQEjLDlW9tI773bVxpzUPo1Dh3DAVqkgZMLd08+W?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d5a709-02a0-460a-b97e-08dbbc3be887
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 13:49:29.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pCHcofvo0X7wWpx6M7TJjLdSv/hCghxVxSXQLXtgMjHHfWQuuVQkx0Md/oKAVBGXIRMqhb7HSVoBqahVAUbdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9454
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IEEE 802.3 clause 73 defines auto-negotiation for backplanes and copper
cable assemblies. This is a medium type (link mode) just like Ethernet
over twisted pairs (BASE-T / BASE-TX) and over two wires for automotive
(BASE-T1) for which the PHY library currently contains support.

As a minimal framework for backplane PHY drivers, introduce a set of
helpers that parse and interpret the base pages that are exchanged by
PHYs during the clause 73 negotiation.

The placement in the "legacy" mii code is perhaps not the best, but I
tried to put them somewhere accessible by phylib, phylink and non-phylib
drivers. Note that phylink also has its own phylink_resolve_c73() which
is more or less similar in purpose, but:

- it requires constructing a struct phylink_link_state which is deeply
  embedded with the phylink API and that may not be desirable for
  drivers

- the presence of some link modes in phylink's own
  phylink_c73_priority_resolution[] is "interesting", like
  ETHTOOL_LINK_MODE_2500baseX_Full_BIT, which is not a backplane mode
  negotiable through C73 at all. That comes from the xpcs driver which
  may have a non-standard C73 autoneg, and this makes it difficult for
  me to e.g. refactor phylink_resolve_c73() to use the more generic
  linkmode_c73_priority_resolution(). Also see the attached link where I
  had previously pointed this out.

Link: https://lore.kernel.org/netdev/20230516090009.ssq3uedjl53kzsjr@skbuf/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: add 25GBase-KR-S and 25GBase-CR-S

 drivers/net/mii.c   |  34 +++++++++++++-
 include/linux/mii.h | 105 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mii.c b/drivers/net/mii.c
index 22680f47385d..03e8b0877600 100644
--- a/drivers/net/mii.c
+++ b/drivers/net/mii.c
@@ -648,6 +648,38 @@ int generic_mii_ioctl(struct mii_if_info *mii_if,
 	return rc;
 }
 
+static const enum ethtool_link_mode_bit_indices c73_linkmodes[] = {
+	ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
+	/* ETHTOOL_LINK_MODE_100000baseKP4_Full_BIT not supported */
+	/* ETHTOOL_LINK_MODE_100000baseCR10_Full_BIT not supported */
+	ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
+	ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseKR_S_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseCR_S_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+};
+
+int
+linkmode_c73_priority_resolution(const unsigned long *modes,
+				 enum ethtool_link_mode_bit_indices *resolved)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(c73_linkmodes); i++) {
+		if (linkmode_test_bit(c73_linkmodes[i], modes)) {
+			*resolved = c73_linkmodes[i];
+			return 0;
+		}
+	}
+
+	return -ENOPROTOOPT;
+}
+
 MODULE_AUTHOR ("Jeff Garzik <jgarzik@pobox.com>");
 MODULE_DESCRIPTION ("MII hardware support library");
 MODULE_LICENSE("GPL");
@@ -662,4 +694,4 @@ EXPORT_SYMBOL(mii_check_link);
 EXPORT_SYMBOL(mii_check_media);
 EXPORT_SYMBOL(mii_check_gmii_support);
 EXPORT_SYMBOL(generic_mii_ioctl);
-
+EXPORT_SYMBOL(linkmode_c73_priority_resolution);
diff --git a/include/linux/mii.h b/include/linux/mii.h
index d5a959ce4877..4b141e9acd08 100644
--- a/include/linux/mii.h
+++ b/include/linux/mii.h
@@ -13,6 +13,36 @@
 #include <linux/linkmode.h>
 #include <uapi/linux/mii.h>
 
+/* 802.3-2018 clause 73.6 Link codeword encoding */
+#define C73_BASE_PAGE_SELECTOR(x)		((x) & GENMASK(4, 0))
+#define C73_BASE_PAGE_ECHOED_NONCE(x)		(((x) << 5) & GENMASK(9, 5))
+#define C73_BASE_PAGE_ECHOED_NONCE_X(x)		(((x) & GENMASK(9, 5)) >> 5)
+#define C73_BASE_PAGE_ECHOED_NONCE_MSK		GENMASK(9, 5)
+#define C73_BASE_PAGE_PAUSE			BIT(10)
+#define C73_BASE_PAGE_ASM_DIR			BIT(11)
+#define C73_BASE_PAGE_RF			BIT(13)
+#define C73_BASE_PAGE_ACK			BIT(14)
+#define C73_BASE_PAGE_NP			BIT(15)
+#define C73_BASE_PAGE_TRANSMITTED_NONCE(x)	(((x) << 16) & GENMASK(20, 16))
+#define C73_BASE_PAGE_TRANSMITTED_NONCE_X(x)	(((x) & GENMASK(20, 16)) >> 16)
+#define C73_BASE_PAGE_TRANSMITTED_NONCE_MSK	GENMASK(20, 16)
+#define C73_BASE_PAGE_A(x)			BIT(21 + (x))
+#define C73_BASE_PAGE_TECH_ABL_1000BASEKX	C73_BASE_PAGE_A(0)
+#define C73_BASE_PAGE_TECH_ABL_10GBASEKX4	C73_BASE_PAGE_A(1)
+#define C73_BASE_PAGE_TECH_ABL_10GBASEKR	C73_BASE_PAGE_A(2)
+#define C73_BASE_PAGE_TECH_ABL_40GBASEKR4	C73_BASE_PAGE_A(3)
+#define C73_BASE_PAGE_TECH_ABL_40GBASECR4	C73_BASE_PAGE_A(4)
+#define C73_BASE_PAGE_TECH_ABL_100GBASECR10	C73_BASE_PAGE_A(5)
+#define C73_BASE_PAGE_TECH_ABL_100GBASEKP4	C73_BASE_PAGE_A(6)
+#define C73_BASE_PAGE_TECH_ABL_100GBASEKR4	C73_BASE_PAGE_A(7)
+#define C73_BASE_PAGE_TECH_ABL_100GBASECR4	C73_BASE_PAGE_A(8)
+#define C73_BASE_PAGE_TECH_ABL_25GBASEKRS	C73_BASE_PAGE_A(9)
+#define C73_BASE_PAGE_TECH_ABL_25GBASEKR	C73_BASE_PAGE_A(10)
+#define C73_BASE_PAGE_25G_RS_FEC_REQ		BIT_ULL(44)
+#define C73_BASE_PAGE_25G_BASER_FEC_REQ		BIT_ULL(45)
+#define C73_BASE_PAGE_10G_BASER_FEC_ABL		BIT_ULL(46)
+#define C73_BASE_PAGE_10G_BASER_FEC_REQ		BIT_ULL(47)
+
 struct ethtool_cmd;
 
 struct mii_if_info {
@@ -47,6 +77,10 @@ extern int generic_mii_ioctl(struct mii_if_info *mii_if,
 			     struct mii_ioctl_data *mii_data, int cmd,
 			     unsigned int *duplex_changed);
 
+extern int
+linkmode_c73_priority_resolution(const unsigned long *modes,
+				 enum ethtool_link_mode_bit_indices *resolved);
+
 
 static inline struct mii_ioctl_data *if_mii(struct ifreq *rq)
 {
@@ -506,6 +540,77 @@ static inline u16 linkmode_adv_to_mii_adv_x(const unsigned long *linkmodes,
 	return adv;
 }
 
+static inline u64 linkmode_adv_to_c73_base_page(const unsigned long *advertising)
+{
+	u64 result = 0;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_1000BASEKX;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_10GBASEKX4;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_10GBASEKR;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_40GBASEKR4;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_40GBASECR4;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_100GBASEKR4;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_100GBASECR4;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_25GBASEKR;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT, advertising))
+		result |= C73_BASE_PAGE_PAUSE;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, advertising))
+		result |= C73_BASE_PAGE_ASM_DIR;
+
+	return result;
+}
+
+static inline void mii_c73_mod_linkmode_lpa_t(unsigned long *advertising,
+					      u64 base_page)
+{
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_1000BASEKX);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_10GBASEKX4);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_10GBASEKR);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_40GBASEKR4);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_40GBASECR4);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_100GBASEKR4);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_100GBASECR4);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_25000baseKR_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_25GBASEKR);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT, advertising,
+			 base_page & C73_BASE_PAGE_PAUSE);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, advertising,
+			 base_page & C73_BASE_PAGE_ASM_DIR);
+}
+
 /**
  * mii_advertise_flowctrl - get flow control advertisement flags
  * @cap: Flow control capabilities (FLOW_CTRL_RX, FLOW_CTRL_TX or both)
-- 
2.34.1

