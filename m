Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8376F77FA49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352791AbjHQPHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352807AbjHQPHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:07:02 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A572926BC;
        Thu, 17 Aug 2023 08:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6pnwHU+jzwV9QuFDk5wfzxTd7HeElT5PHPXe+1Q7k0rSnce/XppeSC4SEUEaZrdMW5OsTGF07RWgJDsgyFZ1MV7Twa0easrMgP/lQ4RRAoVuEmy0H5sMJFBPMD6fN7DumNyA192uEQ69Ay60c4PuRRMpDLFVauRECQwQM/wMWl3o2bvFr7PNBSk4FRFTUHlFCQZFq7lomelzf4O4x5OhRW44NcYxY+OGECIvyP0WYcCq05uA+YFuX9ZbK6aljEEzY61vsrTml/krrXoBuGRKzF8hh+hnqOmatHXSbc+K7IE0nbIJUUS1f6y8BEZqvbhj+tmKoGx5j5BY8M9DaBv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzeaazmO4RhbOXcSM+9AWmeLsoZ/JxIS2ypqjczS5SQ=;
 b=FdO5a1CMlcHVaIYxNVk27PHRa0jChyddcbH3MM1ZkxKVBjBQ3Ji4ZNF5HIiSQRzhvs6wOJP4Y+5DRSrzfpk6sHvZiWskeEiAho5R3yRl4RsEOohTOsmYhg1wkZLDrXktZZeF54qIirH5YkOq+uzyMEOBYtg3srxM96gsFGWDHAYAqfFJQj09cZ9waxiJaMW0fpuA2b+q+bskMQDGWtU8kCd4/l0a74se6WNWCpDW4th6s6gOFkV/k4/4F0DP9uw0MiorAiOfV/klTaISQ8tGmuXE0BB5kIzsxmsvslcBJij+rb9EtiPqvpB0OMjK5ABpztP9BNsFu5nTt94ylQa2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzeaazmO4RhbOXcSM+9AWmeLsoZ/JxIS2ypqjczS5SQ=;
 b=Pz6vB1vcYxk3KyOrqC4KxUwAmHybM2rCVvNq4R7QFsvJg9AQPRP8F4Cm51KFscf/53evMS3Ihm8bIJJYrHFKFRF34TRhcTU/XMAHj7jhekCs+wZiqHyd8lmYVqathcTYFZ9MJ0ZC2UizkOleMr+gaJZ7fTz0tAK9cfarQ6KfevU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB9469.eurprd04.prod.outlook.com (2603:10a6:102:2b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 15:06:57 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:06:57 +0000
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
Subject: [RFC PATCH net-next 1/8] phy: introduce the phy_check_cdr_lock() function
Date:   Thu, 17 Aug 2023 18:06:37 +0300
Message-Id: <20230817150644.3605105-2-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 155bde4c-f547-4ced-9c2d-08db9f3399ad
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzi5GZ5fzUDiweGM7T4DHlUC4ElMxLQ5VkCFPzMdRhassJAaWPXdD+7OoqdhX5bDfrCx62ndeiqUCSTC1hiwyWVzhz2SBFnHrAmuSZH6AhBd+CfhADblDSVhIzsA6ltYNwYtRYWROhsGvpiW/jD3Vj380jWHZJAUu/efb88AfFjQl0LU/mfQoxlSNq3DXDuz5LbJK6x7eFJUgIKasL80bnGRN0gs50ddcOp3Z32PowFjroRy/3A2wvJb4c+sQpGJbfFefJBLkxBcNoVSDK7dRFlvOZnWdem+uIOIvRXk3bZvBOQzV+iQ+ZMaJl183xWHv+Vw69IAqOpEU2DRQHmfUhIT2YvKRxHDjwPtrOVIAfXk6jpVmA/dd78BSU9NXjiyDiuebUIotkQj+dDUhjpLV331Ga8/ra9GuW/YXHYj1TQrnXXlW9ChWy06dXvGR6oYRcFwyaVcaITVVoTBn8zbghKM+qfwsfAwgUXs9tS3ioRzdm6AGsrahsKhAN3C/90uuavQwThuifa0hfG5pp3pcSv2E4npK3rqMQmOICMwhREwHe4xPefacxA62HCJ5DE7mx9hY+OYfYh+rn2uSy4yooVYRRw5H7cUB6IRAbqdu1xVhSCgGdcA32mog6iUr4Ot
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(7416002)(478600001)(6506007)(36756003)(6666004)(2616005)(1076003)(6486002)(6512007)(52116002)(44832011)(5660300002)(41300700001)(316002)(54906003)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zL/3Avk6HrR4XsjTUFwpO6Yg3LT+cR9fv70kmvUvW1K8++/CaxjxhjvvIByE?=
 =?us-ascii?Q?kUomD14ggrbpxIatH2vR4cQj+01J8Gk8VbQtNWz1ZrrBX5nnmLue/JoSpXhc?=
 =?us-ascii?Q?9yowwmWSE9HI22hXuafhcZZ8ZBsYtHEIsq3P3nMssaL6Ow0Je58Av/9WdHQS?=
 =?us-ascii?Q?cKuZ5b/9xPLoRldMjxWWHzIGKK5E+YFL1+k8QPCDZbM3KzDUvjG5Ss9+deMv?=
 =?us-ascii?Q?YezE/t41JzkX2ZukM/0CcgVZEWQJi8NWaB/CVMqwy3uaHZPHvsfWb2ZHY1e+?=
 =?us-ascii?Q?8m07IkUU0nOcOesl+mK7r+n5zYFYnNSBq9yZIy3Ql7bQuml78j0Fksb6xNA/?=
 =?us-ascii?Q?LDnYUdmb4qxnYwhQfzme/6ikU+hXyz1Zv/E2a4wqT99Sn89a68j6vR6e9a1F?=
 =?us-ascii?Q?ZTnYya4Ef8hsKrTFEhWI1hxOw9q+r8j4VsTCgbsQWhHRBWcVwpbe7aE6PfYM?=
 =?us-ascii?Q?PhPLzgI71P8RB/jPLzDmO1lTh/+CmmvWTXRGxCsaxGteKMnmr4u5G1zJZ/gW?=
 =?us-ascii?Q?YiPnCXs6meI/RHWy88IaDCJEyhT20e9fxuTOokpD8w3CrYOC+pSSOO3+i4Dz?=
 =?us-ascii?Q?Nqqx4zO60xH8/kDDWJToVcBjNIaDOfX+VKrfewjvU43vwIH1p8CX4UlG8G6W?=
 =?us-ascii?Q?AmHz+t+WcaGZzitvP3/qhdm0qxNsN16H9cZGlML/PvtZRP2gLtD1DDKga5Ip?=
 =?us-ascii?Q?Ot/pneBsy5b5RNIrXVPu+Lt6tiBV2oZmf5UC81B+F3mqfEtQ5fYRG3EL9zEy?=
 =?us-ascii?Q?BKfg1DbZK1+g560KzTi0Ek7h+CwzCo1pGuYmPlyzGN+XTTJsqdSYSJGHO8Bq?=
 =?us-ascii?Q?fgK5YCDjtOJwOwEtGxCjmZlSi+KwlByPsEsKacxTTJiCtAOdAE2u4Fx04de3?=
 =?us-ascii?Q?ATruSxQVQ3WsXalzzgqfU7y0ga4+J8zgckyUvJcKh8cIBYuqmOhAywmQmfq/?=
 =?us-ascii?Q?UIVmOEpksXtrD6Tf1MO0v6tmMhrAWWkfI2VyIJEmaXwKps1semOy+Q2LhJtj?=
 =?us-ascii?Q?xDrOu7epF9fYyTwK5EzRqBtuUhxIgG4NYtVEgL8GibJimkKNV8+q4JYlah+8?=
 =?us-ascii?Q?r5rBE7pfPksYWUrIX1fLWklJ7Jlv+fc26dxYNJ7jePVthVJkK/lZ2YYsZvMo?=
 =?us-ascii?Q?AMdRfPYr1rsX55hR9qQ/kSSBVUkZsYWbN4lVssK5hMsag08ct0l0g6oayS5j?=
 =?us-ascii?Q?5ttA8htpg71xYfPI/+tGpYCdwwDcZfVmikIl8SvNa+095hYdmGbYFckL5yZU?=
 =?us-ascii?Q?M8k3TVfM2zgTHPwL3Mo825o+MitAEez5ll/Z28Ubf1DMCfzwaML4XdsZQO7U?=
 =?us-ascii?Q?WLu1oEP6iLC1tr8UzzhtPg7MidvnJjK+e5Ql3k0x447BI/g4TI7cNOxNzuL5?=
 =?us-ascii?Q?3dGuGMLUsPq0H9KRiL2jJtWzEkQdj+6/lPvCN8+Hddbvx/+uDErMeRX2WAQG?=
 =?us-ascii?Q?/ozRA9LCwuvzfDfBzPoSzsLCAbKoEKB8ezywSkgDDY7gtq9CD3Sbc7YvdES1?=
 =?us-ascii?Q?sUyoBTvcYcmXL2cORixpCzFwQDHS+5eGaRC0hDj3xbjd+ax6SW7KiMWAiB+Z?=
 =?us-ascii?Q?Gg3jr5/3xQKM7GpHMwISA3LhWLtgUxBNxxvtdSSGb0Um058/7Wm5dJaWj9/d?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155bde4c-f547-4ced-9c2d-08db9f3399ad
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:06:57.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JvdF87rxmn0F9Qc2/O1iLlnwFFYFUSQ/ogPWupGdolUfses8WhNLCOy8IZVEYFdhB91FRPqQ0woJeOAmSCjBQ==
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

Some modules, like the MTIP AN/LT block used as a copper backplane PHY
driver, need this extra information from the SerDes PHY as another
source of "link up" information.

Namely, at 25Gbps, the PCS does not have a MDIO_CTRL1_LPOWER bit
implemented in its MDIO_MMD_PCS:MDIO_CTRL1 register, so a phy_suspend()
procedure will not power down the link, and will not cause a link drop
event on the link partner.

By implementing the networking phy_suspend() as phy_power_off() in the
SerDes and introducing phy_check_cdr_lock() as a link indication, we are
able to detect that condition and signal it to upper layers of the
network stack.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/phy-core.c  | 18 ++++++++++++++++++
 include/linux/phy/phy.h | 22 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 96a0b1e111f3..e611ebe993c7 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -553,6 +553,24 @@ int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 }
 EXPORT_SYMBOL_GPL(phy_validate);
 
+int phy_check_cdr_lock(struct phy *phy, bool *cdr_locked)
+{
+	int ret;
+
+	if (!phy)
+		return -EINVAL;
+
+	if (!phy->ops->check_cdr_lock)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->check_cdr_lock(phy, cdr_locked);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_check_cdr_lock);
+
 /**
  * _of_phy_get() - lookup and obtain a reference to a phy by phandle
  * @np: device_node for which to get the phy
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index f6d607ef0e80..456d21c67e4f 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -122,6 +122,19 @@ struct phy_ops {
 			    union phy_configure_opts *opts);
 	int	(*reset)(struct phy *phy);
 	int	(*calibrate)(struct phy *phy);
+
+	/**
+	 * @check_cdr_lock:
+	 *
+	 * Optional.
+	 *
+	 * Check that the CDR (Clock and Data Recovery) logic has locked onto
+	 * bit transitions in the RX stream.
+	 *
+	 * Returns: 0 if the operation was successful, negative error code
+	 * otherwise.
+	 */
+	int	(*check_cdr_lock)(struct phy *phy, bool *cdr_locked);
 	void	(*release)(struct phy *phy);
 	struct module *owner;
 };
@@ -236,6 +249,7 @@ int phy_set_speed(struct phy *phy, int speed);
 int phy_configure(struct phy *phy, union phy_configure_opts *opts);
 int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 		 union phy_configure_opts *opts);
+int phy_check_cdr_lock(struct phy *phy, bool *cdr_locked);
 
 static inline enum phy_mode phy_get_mode(struct phy *phy)
 {
@@ -414,6 +428,14 @@ static inline int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 	return -ENOSYS;
 }
 
+static inline int phy_check_cdr_lock(struct phy *phy, bool *cdr_locked)
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

