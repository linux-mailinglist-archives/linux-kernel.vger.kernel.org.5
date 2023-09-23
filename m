Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CF97AC25E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjIWNth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIWNtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:49:36 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7F51A8;
        Sat, 23 Sep 2023 06:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L60m+OlNp3pU5OL2U0FAFLCArE3K5ykdGIYhofDJtS56vhmIsIkan2tUeKuznGTah2OEETFLIE/3KL4INUxI1RGQJdH8M3JKJrcuSlnr2JUGmYyicMahiLzzU1hNv+Kv6yQ5KGguLbRHe8eoG9tZCsW1rrNx5HsqCB2sZ79UQ+s4HIVeI/D54Mv0CkcVr3nTil/6nkBs6rc1+EHwNsMJ86rQATrkcJ2Pht7v7mB5uqMrTr+f6RuHPc38fM3OZqQ4fRmlXXaKJCWurCKBP2JPtx3HTU3eLysys4Tu2FQ+5VcQnIs0qFXc7ni6kOamhgrnVnOv1xn+HdCuBtsCC705LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+moDXYg7ec3f5CMV+vQmkzpE+tgU/T4ad+voqfJCMHw=;
 b=OBw9KzjVpuboTHDUjMQygm7ECL1YLrt7oL2h9KyBOVbxkbrHqeIZtTudgVkJaKx99ljcPD2J9Qu7ePruT+lMC2jODTDyi7WPkgT4xTWhhnkXbL9/kbugM6tBv//ejN7HfBdTI1g3JeG9TaaYX1L+eRmg0lr+ARfq7OhzzsBHMZE24jLOplg2AcWLUmm/awXD/w5CoDdmPuxlHZTIqFdvYaiMhYIBaQzETAZmgsGXZkRYDFhBQB+70xKc5NDB6DwGxpC3nKkpSIilhPPeCECsZxsBUmjtaX61a3LDORcJQasCi8cjFwZSZqyLsedJekQWk9kPYSuUHE6ZVx8VKG83pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+moDXYg7ec3f5CMV+vQmkzpE+tgU/T4ad+voqfJCMHw=;
 b=Y8wDkgSRvRPAQcnGXCNU/rpBbj9dGrxnpP4luVSFYZA8eRtVkim8tIlsJN9FznvgQXdRUjFoUpk1n+QMzfyL3OBdVucG8hHGN3c84UbHDCC4yOVi7BbGj2fJNiHFcD4tGYU2l6DwtsmbV6ox9LUGopPoC1I2SakDh7AexLoFbAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8396.eurprd04.prod.outlook.com (2603:10a6:10:24a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Sat, 23 Sep
 2023 13:49:23 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6813.024; Sat, 23 Sep 2023
 13:49:23 +0000
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
Subject: [RFC PATCH v2 net-next 01/15] phy: introduce phy_get_status() and use it to report CDR lock
Date:   Sat, 23 Sep 2023 16:48:50 +0300
Message-Id: <20230923134904.3627402-2-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB8396:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a30e01f-fbdd-4dbb-3fbd-08dbbc3be4d5
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6EoJlGk6DYpyl7hzWVTIZJemEiPR+yIkzT+V2dKsEljcg54Sdvfeb0/TEwTY2GL6JMoVpf2VThiwJjB/mtlWUphrscePo4+NV8+ovVq31u4qBmB9fnz8UYbrfLY5vJH65TukWerTneSyO7kE7mz+8Y39z/Yap6osaVVzEGwOc3HNGmy4gH/c+KBXFOQUfMjcu9kixeTxGvo/RN2Cmv0AUuhwpIjAN9lzZf6zXYRkvK3nTKMtl2pZQmd8m5X3Ff3pal4Y3jWf7nrOTFeqofzxbw3104t678NDTBRTB1Jjo0Phpl4QOmE8EWld0R4GsxkWtZ3ShTM5scexVjT8Vr1V1BnAxio5bzczMpRYCPYkQ6OmCfMbDyfdShnYwUYac1Tk+7uJwhd4awznIZhCwkO/qP4gJ/lumvKxDf1jkxNjfgxdL7SdaCQz+yfjx3LvDGP7+/rdWofQeQasWeVmNnvl5rJKRMJbbQgoYS2LaDnU8ERikPr9VAOohQAxLReXPuJFFv9RPi7ZCLpA76zVe8k21R9pbh2iWA4b8aHk5QcjKLBr4DMAgT9ABZBbqbt4R2w+7QdDRBJToOQwiRUaoAkpPSHFI3sPGR8w9egW2anJtJECPAguHct47RM6XeufLabP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(186009)(1800799009)(451199024)(6512007)(52116002)(6506007)(6486002)(6666004)(83380400001)(86362001)(38350700002)(38100700002)(36756003)(1076003)(2616005)(26005)(2906002)(41300700001)(316002)(7416002)(44832011)(54906003)(66946007)(66476007)(66556008)(478600001)(8936002)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MlN8gH3d0n+lxcUvoj7TDzXiHuXWKInTOxMxz894gR66IkbWVCNr2T3D+ztR?=
 =?us-ascii?Q?JCYmzil+VONgC9w4BlUcnsgKCmUL+LOpNhQaOIC9Oh+zvdTUPRrI6tSPnRm7?=
 =?us-ascii?Q?/unGw2k9Io1jOYX2ppUqvXSJgq1EmvXE+Bj6SHEDSjUtyS6bWFqErsELYSzk?=
 =?us-ascii?Q?HE1zdlH8OhM0JtT1O9M76sDeleOMgG7ULrNvrOSncd82FSZzgAHkKK7EsPS1?=
 =?us-ascii?Q?tU1uEp7NVEmAWeWsrjfEV7bPVKWfkS0JNsRZjOl9HlHl3Xq/yysnmuI7ZWFb?=
 =?us-ascii?Q?tSe/6LQW3G7Jm2ntLfah1MhYKVl3Zzyqtq4J0kP7M0GxHTqN2/kn8iE380AI?=
 =?us-ascii?Q?UjbfX5AZlRjQcFg2ER8f1WBXKbGWtLN8OkFD9S1xPjYgHwanLKZKaXJ2MRFk?=
 =?us-ascii?Q?Lag+WXhTYWjMQcKrpf5zuQsX4A+tiXkAI6ut3mjQiSkc0OSlUTy4aWJsYNMT?=
 =?us-ascii?Q?ROLW7PsZy9nPzvL8JZNHdQk69F5/KJ9Mvqev1Kpqdg1OMG27UKZM/96APe4h?=
 =?us-ascii?Q?jZOZbtqWOXlX6Umu79m5jvjE2rsStuJxwNTbRAUousGWf0C3F+HVMl1G+OTz?=
 =?us-ascii?Q?M0Yz9HglCJMGtF8hcUaBioXiDVRxf5qHqBVNiTvf9R8T4PW3cENTB9fyGyC+?=
 =?us-ascii?Q?rheASeq4t+ONKehoQBeLC2+R9CaN4+jtxS8tJM1WfYXL2fiZwNaC09mEgXXU?=
 =?us-ascii?Q?+qBFHk7SOISr3YdL0h0YK6Br8dhbSW2LifcOqYH3kd5YiVkJtZSxWHp9MU9n?=
 =?us-ascii?Q?hpNNFuArz1bRuq8hwUZyni4C+87ZmHTLf/YAg/zujsbk1MrMV6i9/6zixbO3?=
 =?us-ascii?Q?2m0dfDfOYJVfUCnvUd/FzqslW/bxTQhYO2IQBiyU6xfaOIoekXPh0Cpm4vgm?=
 =?us-ascii?Q?sWInaxqxL/uyxOFT2nrQ6OQKwqRwhcf8YQXwF9bs3ROtZGQy9pNuhOqftUvp?=
 =?us-ascii?Q?I/UpdnWxaKmHzqql7vh29SJMsV35oE3z+vqsEqFmG9lAr23dkYIcHEb2sIsm?=
 =?us-ascii?Q?MI9xdAtXsDg3V5loPlqOb1Wri8FivYA9B8OMsb6XtYIArzJx8SwISTpNR4RY?=
 =?us-ascii?Q?f5HFvjpogSsdvFRc/459AoeNGTIP7dZr8osBszOdTB5L1qbtPVJfXVQOjAUq?=
 =?us-ascii?Q?ya0xYmbW5jNNH7rfsweoRg39g9SXamifPh2D+JarTaP3NojLba16HZoEnMQh?=
 =?us-ascii?Q?Sa2QSeDVLw9BbUswk0UcDEUCbNoLSMejcXc18qTF+hOnvcBOn1JvAnlm0/Dr?=
 =?us-ascii?Q?oqGJeY3ljlNi0aWomaWmRRvakny1cafmI8zNxSMx91C4Rf8hk37DW7+1RzaI?=
 =?us-ascii?Q?lrkf6VcoXwbyAMt5UrYgn3txi2xwD14NMQGtS4g3a4BfwDOKky5OIvmuX61I?=
 =?us-ascii?Q?5fEjBADL/5JuTWZRAdWSxv7SKmoFUMoVhqsFMIB1tdaQDlfALHDBVEaS7D5o?=
 =?us-ascii?Q?tX9QwfIH4Jbbc+6PkDNntDI2DNNfnekP3jPO6xI6byN+Pqzjopjl3GwtU8Pc?=
 =?us-ascii?Q?uF7khgRuwTTQt96Xct0BSnokcUx54kiRezow1eHVzCukZG9DER95wUST/prs?=
 =?us-ascii?Q?ZEzZHm0ylxXYPXi4IH5ViisRTIu6X6s5OeertsVgVKLCur9DeBgbTcXPR4Ck?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a30e01f-fbdd-4dbb-3fbd-08dbbc3be4d5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 13:49:23.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+bvc7lu8SUQM6Mnw3bZlimFdqmRifYc89RonsBBaO2/RMr7190jVX56gOVFr3Nv1MZ86qNNM3ZxvOOcmUjsGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some modules, like the MTIP AN/LT block used as a copper backplane PHY
driver, need this extra information from the SerDes PHY as another
source of "link up" information.

Namely, the 25GBase-R PCS does not have a MDIO_CTRL1_LPOWER bit
implemented in its MDIO_MMD_PCS:MDIO_CTRL1 register. That bit is
typically set from phy_suspend() or phylink_pcs_disable() implementations,
and that is supposed to cause a link drop event on the link partner.
But here it does not happen.

By implementing the networking phylink_pcs_disable() as phy_power_off(),
we are able to actually power down the lane in a way that is visible to
the remote end. Where it is visible is the CDR lock, so we introduce
PHY_STATUS_TYPE_CDR_LOCK as an extra link indication, we are able to
detect that condition and signal it to upper layers of the network
stack.

A more high-level and generic phy_get_status() operation was chosen
instead of the more specific phy_get_cdr_lock() alternative, because I
saw this as being more in the spirit of the generic PHY API.
Also, phy_get_status() is more extensible and reusable for other
purposes as well.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: reimplement phy_check_cdr_lock() as something more generic

 drivers/phy/phy-core.c  | 31 ++++++++++++++++++++++++++
 include/linux/phy/phy.h | 49 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 96a0b1e111f3..3b7e04a59a00 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -553,6 +553,37 @@ int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 }
 EXPORT_SYMBOL_GPL(phy_validate);
 
+/**
+ * phy_get_status() - Query various parameters of a PHY
+ * @phy: the phy returned by phy_get()
+ * @type: type of the status being queried
+ * @opts: pointer to union of status structures, determined by type
+ *
+ * phy_init() must have been called on the phy. The status is relative to the
+ * current phy mode, that can be changed using phy_set_mode(). Not all status
+ * types may be relevant to all phy modes.
+ *
+ * Return: %0 if successful, a negative error code otherwise
+ */
+int phy_get_status(struct phy *phy, enum phy_status_type type,
+		   union phy_status_opts *opts)
+{
+	int ret;
+
+	if (!phy)
+		return -EINVAL;
+
+	if (!phy->ops->get_status)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->get_status(phy, type, opts);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_get_status);
+
 /**
  * _of_phy_get() - lookup and obtain a reference to a phy by phandle
  * @np: device_node for which to get the phy
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index f6d607ef0e80..6be348f1fa0e 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -51,6 +51,29 @@ enum phy_media {
 	PHY_MEDIA_DAC,
 };
 
+enum phy_status_type {
+	/* Valid for PHY_MODE_ETHERNET */
+	PHY_STATUS_CDR_LOCK,
+};
+
+/* If the CDR (Clock and Data Recovery) block is able to lock onto the RX bit
+ * stream, it means that the stream contains valid bit transitions for the
+ * configured protocol. This indicates that a link partner is physically
+ * present and powered on.
+ */
+struct phy_status_opts_cdr {
+	bool cdr_locked;
+};
+
+/**
+ * union phy_status_opts - Opaque generic phy status
+ *
+ * @cdr:	Configuration set applicable for PHY_STATUS_CDR_LOCK.
+ */
+union phy_status_opts {
+	struct phy_status_opts_cdr		cdr;
+};
+
 /**
  * union phy_configure_opts - Opaque generic phy configuration
  *
@@ -78,6 +101,7 @@ union phy_configure_opts {
  * @set_speed: set the speed of the phy (optional)
  * @reset: resetting the phy
  * @calibrate: calibrate the phy
+ * @get_status: get the mode-specific status of the phy
  * @release: ops to be performed while the consumer relinquishes the PHY
  * @owner: the module owner containing the ops
  */
@@ -122,6 +146,20 @@ struct phy_ops {
 			    union phy_configure_opts *opts);
 	int	(*reset)(struct phy *phy);
 	int	(*calibrate)(struct phy *phy);
+
+	/**
+	 * @get_status:
+	 *
+	 * Optional.
+	 *
+	 * Used to query the mode-specific status of the phy. Must have no side
+	 * effects.
+	 *
+	 * Returns: 0 if the operation was successful, negative error code
+	 * otherwise.
+	 */
+	int	(*get_status)(struct phy *phy, enum phy_status_type type,
+			      union phy_status_opts *opts);
 	void	(*release)(struct phy *phy);
 	struct module *owner;
 };
@@ -236,6 +274,8 @@ int phy_set_speed(struct phy *phy, int speed);
 int phy_configure(struct phy *phy, union phy_configure_opts *opts);
 int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 		 union phy_configure_opts *opts);
+int phy_get_status(struct phy *phy, enum phy_status_type type,
+		   union phy_status_opts *opts);
 
 static inline enum phy_mode phy_get_mode(struct phy *phy)
 {
@@ -414,6 +454,15 @@ static inline int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 	return -ENOSYS;
 }
 
+static inline int phy_get_status(struct phy *phy, enum phy_status_type type,
+				 union phy_status_opts *opts)
+{
+	if (!phy)
+		return 0;
+
+	return -ENOSYS;
+}
+
 static inline int phy_get_bus_width(struct phy *phy)
 {
 	return -ENOSYS;
-- 
2.34.1

