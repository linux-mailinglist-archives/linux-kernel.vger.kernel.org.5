Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770A27AC25F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjIWNtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjIWNtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:49:36 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C671A5;
        Sat, 23 Sep 2023 06:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdbFsbOjx7DB6aazzpGNBagMAWV2z6aQ/1FwX3kTBMnE1K9ifS6vB0SureYgTeLj170NVCYTtgGsdI2Mo1KmRUPL0ckICjsr6O9a+FUY3v+cwKRdTDrNRQLxlHJHg9Rw6l1XFjTlwoVa14oe2PJPEgoQ7HMaJ0Dc0MtbMQXXpkSbQ0VH5aNl9KJnkIrecmZKaaRcrWxzZ3Y/k6I3YYZR/5FcA2vEPSZh7hnJJ+7X1ev1ooZB/veM3ALbHu+8jozf7eAPI88GEA/JXv0/PVhVJW+pjt6vohPIQ50JRtJs27QdS48KWINoaHAZQ8vSQu5kf3IYjsR1KzVTZmkNLfm0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vY9X0usskXKpLQcnQGAHoEgjxFUewnZMRLemH6ly+w=;
 b=hrgXd+Qa8MUOuOSJKoSncjWUYp4kojlbJ+VDgGZHIq9LMVUUjWgUcjZNKT+Izi2XjeRo6CfLpKkUxALQWbpYsFnztNwTOoXd1xfCqvunVf4yQ1yGah6hcN1TmsAiJObj8LYWQhKTFJubZaf23ddglmI6jF+TRgKMlDGr8Q6a/3u30av4UMy5i+OlelFxDuZDArVD1Q0j45K6vF0exj8PfzqFZ26U8RlKh4EvPQy13GTbVXRKZqChlb5m1UZjO03bOX6HJqnqwmgJrFwjcD48v2crvkAxIfL4ykuqCDcmdevaoAygqN7sc61K/SZiWcZn0+Q6hz4LT2Y+RIcS4K90NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vY9X0usskXKpLQcnQGAHoEgjxFUewnZMRLemH6ly+w=;
 b=qB5wW8SqQfQONuS4pStOTgYnb2yym+fg0nD4Z0wENrjp9k85U41RQZX97FSbnel2ceCIwP0ND+WiGo4qw+cI4bGdZdCN7y7a2Wic3sZZujKeecx+jvoL++mpKLYucTDRuYmDKBgaLS9EKXyMmtzMXv2ltnJDHV5LpDD4gdmAdBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Sat, 23 Sep
 2023 13:49:27 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6813.024; Sat, 23 Sep 2023
 13:49:27 +0000
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
Subject: [RFC PATCH v2 net-next 04/15] phy: allow querying the address of protocol converters through phy_get_status()
Date:   Sat, 23 Sep 2023 16:48:53 +0300
Message-Id: <20230923134904.3627402-5-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11e97d8b-fd6a-40fa-a83f-08dbbc3be70c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWNzmBY2sZVJJGtTFhZNJcuT1yXmrnFcEdTzjX5pi7YXQDqhLMxp3E9LfAK2FYco1San/qxnCxdHV9+0uufPlpdrribo7LjIUJAUl9kbRyIUkDxgGWSKHJbzMJVOabEDf4jzrPraghu1vcyFHTjQP0KnBUX8JM9a+D4VFAVuVVuXnbn8iIaJ2SDG5RUwR6Yjeih/hzHGPIzvm50+eMgfXgdSZJVXbcMIJoBRTtzQoopLikD1p5bwFKVmqsRfb135ufM30g0sKLIx9lSVH6YRA7qb3B53/lxEPv8WCvuLCc+hP11voaTw1V7F4rLgjreMXGdbz5M9WHkdKCe45py5PRtAVYLQimNDz2pGCRPMp3NPQUMe8xPWcuAwAuKzRDHvjIoxfkxbPLI2lUo1UTMJIH4VaAEAuPLWncf5PsHH4ujGUQyC66Pd7igXUVrap5TxsT1e+NEltRsdV7fg6bAe6/FZoSy9TYL5diilzhW/0g0s2j98quVkjZzDDEonRCBeBVnZtFJ//y66m5XGoE0/ljixnotv/tzSZ2qpHQc+w6cG1+AZWRTlN43eyhE/fBNd+qxTDj7awRFBohfHiEPCtGtAMkFwIgwV3oPUyog0BKJgFGFMeCtM+nKGcKzjs6e8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(66556008)(52116002)(2616005)(6506007)(6512007)(316002)(5660300002)(66946007)(38350700002)(6666004)(478600001)(1076003)(66476007)(26005)(44832011)(2906002)(4326008)(36756003)(41300700001)(7416002)(54906003)(38100700002)(6486002)(8936002)(86362001)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GVUfj2vFfBEu+jR/WPmo37tC/4h9xX/OtLEfmF7RUKydKH23VDbZL1agbVQI?=
 =?us-ascii?Q?SFv3HeGCiAe8IZPc72woJCBdrlaNe0pK3SeL9kLbGUTPd2sHrO/SO/dmqUNs?=
 =?us-ascii?Q?JM6rdlVZmyxlICloThQLnh3f88PkGydroTuks4opjL6qbJlH8mBpJwgO33U8?=
 =?us-ascii?Q?AGEv2oZERvdZOM2EQ69rbRpjfyiSbSNjm4HuVxtDGtHqKnH2WpBqlXc/ovYG?=
 =?us-ascii?Q?7M0oY6sqz8LmPpg89sik3rt7158b9HO7Jt2mdprV4E0SdvmKn7HzNFOit0fc?=
 =?us-ascii?Q?U14KbAioMEVjyTm4U8n1oZrDPmLUbGYjir6F1AlNBqgjhrJya6i1GZKRpVgi?=
 =?us-ascii?Q?MfgXUfTJRdDgDxnsutb/FmJpeiaLETbXrBJZ43ToEgmEW0nHmUqQT9mFZaRm?=
 =?us-ascii?Q?dXk2dB69ICs76LSFISe38JnjgfA5LtI7DjCzXhJXiQ/4w7qJOw60TCG7F4ig?=
 =?us-ascii?Q?ghLSGIExsZWq6W0dbz3j1z3bOIpdhgOwsWV92QPcWj0niO6kig4v9uc6TU4m?=
 =?us-ascii?Q?zPmM79IuGxjvD0YMieQJRi50ccTlAv634UjxFRjc3lJVXjimqGjqjy19RKHv?=
 =?us-ascii?Q?66o5rmGHhSVox/Uh1HBtm3D7hQBpPXHj8mObEi2GeRqpInLCuSCjCK6PbXHI?=
 =?us-ascii?Q?8DiIxLYDndY1SI08dLuIryRIZrzo+ZfEH2/zkZ7JCwXq6MP/7Cqh/ckMAsxB?=
 =?us-ascii?Q?fnhjrzFmBjItjcRysO+kmdwlbau7J442GVzSwhH2YnsPRcaaoPDbcZogxZdB?=
 =?us-ascii?Q?XZhzuXc+m31O+mfo6iJc7HUbxNhtNzW4EWKvqWrPE4qnSkC3zHPO++ff37Wg?=
 =?us-ascii?Q?r8Mt3v1uuILCCknFAPyaT6dENH5d2H17a2Nyh7OCfVDSnRRqs7CJfytVv8C5?=
 =?us-ascii?Q?a2vxrOP0WrUY3M8rSVwfECbaDBK6fKi/U4eXOwpVY5HQoVO5eoVYkZ3zBpba?=
 =?us-ascii?Q?EtuJd29gts/v+eydZDfJ3Jfpp6OcBKeZxFXADVqtCWCsjrzIoDS7vRx2q5n1?=
 =?us-ascii?Q?x+anSJYwiOzpPpvX1pSmIrlOTgR2S/sUIed3ap9ESM8aDZzenbcgzq8KrfC5?=
 =?us-ascii?Q?g0A5tjDVd9qI5fBkgINMUmVWxkydnW7UdhSnubIwCodsYuqEw1TqCf4yvQ5d?=
 =?us-ascii?Q?1YAjjsAM5aXtBxgZHj2+lcNkCoilXZDyWiN4rlgFZYyVzMB8PVjIAL8izuOA?=
 =?us-ascii?Q?4DQUajpCTDcIaP8qirEtwyJ8p2CJ2IGsLl7e7dGhV2Y6yMST7kj+Sl6kWAJO?=
 =?us-ascii?Q?CLLu8vo9JThxERg3VrrqEjZl4CToP6pIJB4Rz9oDDWe5Tl1ZN2NnHt7cijvc?=
 =?us-ascii?Q?MMm5P21xvqWQEOk1rQ7RXE2HkK6pynVoTpVaKUXd6dJKoM8rrWm03iYlcBZg?=
 =?us-ascii?Q?ivRVAOWbxcmud4Wd+A58O/TMB8I1HXlCwrIYv+JvzyAsbU5vj5iVSOVRIvAD?=
 =?us-ascii?Q?jZg2MeGyDTg2vdnHDSvfZLrsWJlBcPkRiOby/VAKR0ftBrLf2K0NgmLaMJ1A?=
 =?us-ascii?Q?zRYOyv5f3NIa+dY9otLXRSB6A0NrVOAkEVOq7OwAvwBYr2Y/DdbkOOnVpmZ0?=
 =?us-ascii?Q?nO+F7YAcLUteBm/FCEVNss6I7AXzsE8dywJ1ryQQ91MgtUPJm+nLUadbWc6b?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e97d8b-fd6a-40fa-a83f-08dbbc3be70c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 13:49:26.9984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+B8SSMcfwA6PPASudIaOCjpU9rmfGhOihqkByKF/YDkaYIyPyAwwGqbBFrt8wSnBQYmdwc+ISHDyYiav9KCmw==
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

The bit stream handled by a SerDes lane needs protocol converters to be
usable for Ethernet. On Freescale/NXP SoCs, those protocol converters
are located on the internal MDIO buses of the Ethernet MACs that need
them.

The location on that MDIO bus, on these SoCs, is not fixed, but given by
some control registers of the SerDes block itself.

Because no one modifies those addresses from the power-on default, so
far we've relied on hardcoding the default values in the device trees,
resulting in something like this:

		pcs_mdio1: mdio@8c07000 {
			compatible = "fsl,fman-memac-mdio";

			pcs1: ethernet-phy@0 {
				reg = <0>;
			};
		};

where the "reg" of "pcs1" can actually be retrieved from "serdes_1".

That was for the PCS. For AN/LT blocks, that can also be done, but the
MAC to PCS to AN/LT block mapping is non-trivial and extremely easy to
get wrong, which will confuse and frustrate any device tree writers.

The proposal is to take advantage of the fact that these protocol
converters *are* discoverable, and to side-step that entire device tree
mapping issue by not putting them in the device tree at all. So, one of
the consumers of the SerDes PHY uses the phy_get_status() API to figure
out the address on the MDIO bus, it also has a reference to the MDIO bus
=> it can create the mdio_device in a non OF-based manner.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 include/linux/phy/phy.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index f1f03fa66943..ee721067517b 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -56,6 +56,33 @@ enum phy_media {
 enum phy_status_type {
 	/* Valid for PHY_MODE_ETHERNET and PHY_MODE_ETHTOOL */
 	PHY_STATUS_CDR_LOCK,
+	PHY_STATUS_PCVT_ADDR,
+};
+
+/* enum phy_pcvt_type - PHY protocol converter type
+ *
+ * @PHY_PCVT_ETHERNET_PCS: Ethernet Physical Coding Sublayer, top-most layer of
+ *			   an Ethernet PHY. Connects through MII to the MAC,
+ *			   and handles link status detection and the conversion
+ *			   of MII signals to link-specific code words (8b/10b,
+ *			   64b/66b etc).
+ * @PHY_PCVT_ETHERNET_ANLT: Ethernet Auto-Negotiation and Link Training,
+ *			    bottom-most layer of an Ethernet PHY, beneath the
+ *			    PMA and PMD. Its activity is only visible on the
+ *			    physical medium, and it is responsible for
+ *			    selecting the most adequate PCS/PMA/PMD set that
+ *			    can operate on that medium.
+ */
+enum phy_pcvt_type {
+	PHY_PCVT_ETHERNET_PCS,
+	PHY_PCVT_ETHERNET_ANLT,
+};
+
+struct phy_status_opts_pcvt {
+	enum phy_pcvt_type type;
+	union {
+		unsigned int mdio;
+	} addr;
 };
 
 /* If the CDR (Clock and Data Recovery) block is able to lock onto the RX bit
@@ -71,9 +98,11 @@ struct phy_status_opts_cdr {
  * union phy_status_opts - Opaque generic phy status
  *
  * @cdr:	Configuration set applicable for PHY_STATUS_CDR_LOCK.
+ * @pcvt:	Configuration set applicable for PHY_STATUS_PCVT_ADDR.
  */
 union phy_status_opts {
 	struct phy_status_opts_cdr		cdr;
+	struct phy_status_opts_pcvt		pcvt;
 };
 
 /**
-- 
2.34.1

