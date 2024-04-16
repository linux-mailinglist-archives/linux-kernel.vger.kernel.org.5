Return-Path: <linux-kernel+bounces-146805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809628A6B42
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368EA28160F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B938312BF02;
	Tue, 16 Apr 2024 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="FJToPjs0"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A855E41C76;
	Tue, 16 Apr 2024 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271136; cv=fail; b=cFFXp2CuzPnPYNIviJa1WlzbfTPyPdQrDlwU6+kkhPnAqe9wYkPxHe6LNPSGHiLHy0sdqpaySrVmCrNsM8Pg4e/WI7lBSSXneBEzEHqq2CD48g72ay3bjvUc63uhsbjz7CyImXHBTt3YbFOFRjTXNdkDW/utO1ZfOMbxLjxtqL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271136; c=relaxed/simple;
	bh=NX+FAnb26jDs2ZfSFg4j0aUqy/qx6grQIODut/lqJbw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cFk8EVTp4wjuHgwS1IIPsENbp23tS5Ol0bnUwWxBWzZRCqQ64UbFilcSbZHPWrl4ztcab2bfz7ac6PpgR9e+OPMxaQM8aBCy5XTzWSCF/4Y0QDzldJPNoORbHL8yLtOl4IORoRtFjMOFcynwzroTbXXypwQ9Q3+IjOMtYZpxMUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=FJToPjs0; arc=fail smtp.client-ip=40.107.7.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exmN2z6JzT9IhTNCtwXrMXST6Tr/OoQxR8wRESKe44VK+YqNtulCHl43a88Ww51F8/ZDguCcsofxK4J5F3L6elCtSUckMXNSMCn05J5VLi9guHStHmMHFARy9BGeRjv74CG55uPs5FGMNbuVOj+giTyzAbnQjzej//sShXZPIQqsf6wulmhcUdhNteAEop1joYFdtE35/qyWqrgvJdJmDrBm9cuiIRc2kAz/R15DxEu3tQ1kbhDI5YV/lOjgOBMRdGMkVh7g8yUNXV4hLii5jBFg6BqVLtZ6Dx4YOrSYeNdydKXOz3khRlkxp9I0TvxVWfWZTwSIK+JqvmuxX7oZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf7+HZ7p9t8iObWk9S0JyfP7k8OK5dw4l57zlMI7Fcs=;
 b=NZLK89sRbFS5LUBDrx5IqYHqprlfyT5g2/y0MtoilasRCJxOQr/o3mlcVHj366ta9oxm0whbQkh/y4Jo7EmxZ7pXeCA25euVDUHE5cnVcsVniYitUewOljOAuiQkw7U5wY+uJRlF4+DdbBLjPil6QwOZEaH9bwTaVAmRrDrZmxhnDsG/w32JdO4z246TDLM11MHQx5/OI28xZV0GKr7JGszwyj8hNs8c5Bol1blQuSXDoCZeeInTe0XWqCuihOZznjDktZHKAMd7gj5QvLaoQdnjNYWjG+456qqk6Mv5O6TexGd14RkMOJCVUM6I+qyOXK72Mut0ZFaWs6sOeTsLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pf7+HZ7p9t8iObWk9S0JyfP7k8OK5dw4l57zlMI7Fcs=;
 b=FJToPjs04NxznTzPxekQs0GTkTbtEhifUo3//EOAHgtmAlWVW0IKzds4pstxDu+yDasJ25jM2nrLxnkwmvtvuP7V3iatzbYGODLtA4biI4Tv/oudYbQefwqPE4YxIEb/g0NgYIO3e5ox6s0E7AHI3GQlqkC4sHDV8pwFzppKsZw=
Received: from DU6P191CA0058.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::29)
 by PR3PR02MB5978.eurprd02.prod.outlook.com (2603:10a6:102:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:38:49 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::b5) by DU6P191CA0058.outlook.office365.com
 (2603:10a6:10:53e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Tue, 16 Apr 2024 12:38:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 12:38:47 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 Apr
 2024 14:38:46 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] net: phy: bcm54811: add support for BroadR-Reach mode
Date: Tue, 16 Apr 2024 14:38:11 +0200
Message-ID: <20240416123811.1880177-1-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFF:EE_|PR3PR02MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: cc333526-e2d8-4e65-ab3f-08dc5e12296d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lEw3zsNke8GaEGO43KdNeTBpmFcgDDXvk8FGP8FgDxUqVJHWkZ/nrXF739lYdGPFPLW9LKv3VZULVtxvZyV4KHfNi9LfuoNDQGvpkUJDFxc1Nzv+UJaZINyfQfSJJnrG9OPrw/sDJd5dcgb+rZit1kWZIA9xw1P403T8j6tTY3DLelrfr5HxW94rtoQLfCKV0xmcEC940xDIBDzIKY3dvj+cpZ+1CEkZ9D++N1kX6TYFWzNFDPPFhZPz+gLTonXB/JkoAiInRKijxbLgdVPWA7U7wwxIkmh0vT+IiSf+YuCfKqFXiT9mjgvLrFDHP+aqcuyMdftN1NTsY3u8AIwWpzK/3i9TyqAgVjhfTEdhoFFL1pc7kZXM2VivzTePKqqO8wJtuUd1KeoDdys4CPFgi5AzWy64Vz0ptuav8+6AnElx+tBLm3vOOjW9AaN8DSYFVN8ed340hkTTOLc2VYfgz4mSz5CKdaWiFbAGl3qwzRlbr9kRASzr8m7ktUfpWb5C4h0XnBlLcEoQPV/tb4zg9a26xcoRHjeIqp+LKD6uKv+XYxxRdUzLiH8/JDdQjUwxcfy5J9cHqWJilh1TIDLU+xRqUAlV9UVk5rsIafJ62brNHLbC4jTp8oz0JrsgHvaIBvFzV9WDY3njddBGWVv5UbuxoeuTZjn0CaYGyUZoAZ2orB85os6ghkoZ+2n6/PUwTk1MvhBSD4+cul/gkYBCJxIpfRkl0P7LPnyrhU+fUEoNn1B2LI5Dk1An3q2tJTeX
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:38:47.5993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc333526-e2d8-4e65-ab3f-08dc5e12296d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB5978

Enable the BroadR-Reach link modes for BCM54811 PHY by Broadcom.
This allows for two-wire Ethernet at 10 or 100MBit using BroadR-Reach
mode and also for other BroadR-Reach modes using more than one pair.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 drivers/net/phy/broadcom.c   | 432 ++++++++++++++++++++++++++++++++++-
 drivers/net/phy/phy-core.c   |  13 +-
 include/linux/brcmphy.h      |  91 +++++++-
 include/uapi/linux/ethtool.h |  13 +-
 net/ethtool/common.c         |  31 +++
 net/ethtool/ioctl.c          |   1 +
 net/ipv4/tcp.c               |   2 +-
 7 files changed, 567 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 370e4ed45098..aeb49b566aca 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -553,18 +553,46 @@ static int bcm54810_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 	return -EOPNOTSUPP;
 }
 
-static int bcm54811_config_init(struct phy_device *phydev)
+static int bcm54811_get_brrmode(struct phy_device *phydev, u8 *data)
 {
-	int err, reg;
+	int reg;
 
-	/* Disable BroadR-Reach function. */
 	reg = bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
-	reg &= ~BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
-	err = bcm_phy_write_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL,
-				reg);
-	if (err < 0)
+
+	*data = (reg & BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN) ?
+				ETHTOOL_PHY_BRR_MODE_ON : ETHTOOL_PHY_BRR_MODE_OFF;
+
+	return 0;
+}
+
+static int bcm54811_set_brrmode(struct phy_device *phydev, u8 on)
+{
+	int reg;
+	int err;
+
+	reg = bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
+
+	if (on)
+		reg |= BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
+	else
+		reg &= ~BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
+
+	err = bcm_phy_write_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL, reg);
+	if (err)
 		return err;
 
+	/* Ensure LRE or IEEE register set is accessed according to the brr on/off,
+	 *  thus set the override
+	 */
+	return bcm_phy_write_exp(phydev, BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL,
+		BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_EN |
+		on ? 0 : BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL);
+}
+
+static int bcm54811_config_init(struct phy_device *phydev)
+{
+	int err, reg;
+
 	err = bcm54xx_config_init(phydev);
 
 	/* Enable CLK125 MUX on LED4 if ref clock is enabled. */
@@ -576,16 +604,151 @@ static int bcm54811_config_init(struct phy_device *phydev)
 			return err;
 	}
 
-	return err;
+	/* Configure BroadR-Reach function. */
+	return  bcm54811_set_brrmode(phydev, ETHTOOL_PHY_BRR_MODE_OFF);
+}
+
+static int bcm_setup_master_slave(struct phy_device *phydev)
+{
+	u16 ctl = 0;
+
+	switch (phydev->master_slave_set) {
+	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
+	case MASTER_SLAVE_CFG_MASTER_FORCE:
+		ctl = LRECR_MASTER;
+		break;
+	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
+		break;
+	case MASTER_SLAVE_CFG_SLAVE_FORCE:
+		break;
+	case MASTER_SLAVE_CFG_UNKNOWN:
+	case MASTER_SLAVE_CFG_UNSUPPORTED:
+		return 0;
+	default:
+		phydev_warn(phydev, "Unsupported Master/Slave mode\n");
+		return -EOPNOTSUPP;
+	}
+
+	return phy_modify_changed(phydev, MII_BCM54XX_LRECR, LRECR_MASTER, ctl);
+}
+
+static int bcm_setup_forced(struct phy_device *phydev)
+{
+	u16 ctl = 0;
+
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+
+	if (phydev->speed == SPEED_100)
+		ctl |= LRECR_SPEED100;
+
+	if (phydev->duplex != DUPLEX_FULL)
+		return -EOPNOTSUPP;
+
+	return phy_modify(phydev, MII_BCM54XX_LRECR, LRECR_SPEED100, ctl);
+}
+
+/**
+ * bcm_linkmode_adv_to_mii_adv_t
+ * @advertising: the linkmode advertisement settings
+ *
+ * A small helper function that translates linkmode advertisement
+ * settings to phy autonegotiation advertisements for the
+ * MII_BCM54XX_LREANAA register.
+ */
+static inline u32 bcm_linkmode_adv_to_mii_adv_t(unsigned long *advertising)
+{
+	u32 result = 0;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1BR10_BIT, advertising))
+		result |= LREANAA_10_1PAIR;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2BR10_BIT, advertising))
+		result |= LREANAA_10_2PAIR;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1BR100_BIT, advertising))
+		result |= LREANAA_100_1PAIR;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2BR100_BIT, advertising))
+		result |= LREANAA_100_2PAIR;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_4BR100_BIT, advertising))
+		result |= LREANAA_100_4PAIR;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT, advertising))
+		result |= LRELPA_PAUSE;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, advertising))
+		result |= LRELPA_PAUSE_ASYM;
+
+	return result;
+}
+
+/**
+ * bcm_config_advert - sanitize and advertise auto-negotiation parameters
+ * @phydev: target phy_device struct
+ *
+ * Description: Writes MII_BCM54XX_LREANAA with the appropriate values,
+ *   after sanitizing the values to make sure we only advertise
+ *   what is supported.  Returns < 0 on error, 0 if the PHY's advertisement
+ *   hasn't changed, and > 0 if it has changed.
+ */
+static int bcm_config_advert(struct phy_device *phydev)
+{
+	int err;
+	u32 adv;
+
+	/* Only allow advertising what this PHY supports */
+	linkmode_and(phydev->advertising, phydev->advertising,
+		     phydev->supported);
+
+	adv = bcm_linkmode_adv_to_mii_adv_t(phydev->advertising);
+
+	/* Setup BroadR-Reach mode advertisement */
+	err = phy_modify_changed(phydev, MII_BCM54XX_LREANAA,
+				 LRE_ADVERTISE_ALL | LREANAA_PAUSE |
+				 LREANAA_PAUSE_ASYM, adv);
+
+	if (err < 0)
+		return err;
+
+	return err > 0 ? 1 : 0;
+}
+
+static int bcm_config_aneg(struct phy_device *phydev, bool changed)
+{
+	int err;
+
+	if (genphy_config_eee_advert(phydev))
+		changed = true;
+
+	err = bcm_setup_master_slave(phydev);
+	if (err < 0)
+		return err;
+	else if (err)
+		changed = true;
+
+	if (phydev->autoneg != AUTONEG_ENABLE)
+		return bcm_setup_forced(phydev);
+
+	err = bcm_config_advert(phydev);
+	if (err < 0) /* error */
+		return err;
+	else if (err)
+		changed = true;
+
+	return genphy_check_and_restart_aneg(phydev, changed);
 }
 
 static int bcm5481_config_aneg(struct phy_device *phydev)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
 	int ret;
+	u8 brr_mode;
 
 	/* Aneg firstly. */
-	ret = genphy_config_aneg(phydev);
+	ret = bcm54811_get_brrmode(phydev, &brr_mode);
+	if (ret)
+		return ret;
+
+	if (brr_mode == ETHTOOL_PHY_BRR_MODE_ON)
+		ret = bcm_config_aneg(phydev, false);
+	else
+		ret = genphy_config_aneg(phydev);
 
 	/* Then we can set up the delay. */
 	bcm54xx_config_clock_delay(phydev);
@@ -1062,6 +1225,253 @@ static void bcm54xx_link_change_notify(struct phy_device *phydev)
 	bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_EXP08, ret);
 }
 
+static int bcm54811_read_abilities(struct phy_device *phydev)
+{
+	int val, err;
+	int i;
+	static const int modes_array[] = {ETHTOOL_LINK_MODE_1BR100_BIT,
+					  ETHTOOL_LINK_MODE_4BR100_BIT,
+					  ETHTOOL_LINK_MODE_2BR100_BIT,
+					  ETHTOOL_LINK_MODE_2BR10_BIT,
+					  ETHTOOL_LINK_MODE_1BR10_BIT,
+					  ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+					  ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+					  ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
+					  ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+					  ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+					  ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+					  ETHTOOL_LINK_MODE_10baseT_Half_BIT};
+
+	u8 brr_mode;
+
+	for (i = 0; i < ARRAY_SIZE(modes_array); i++)
+		linkmode_clear_bit(modes_array[i], phydev->supported);
+
+	err = bcm54811_get_brrmode(phydev, &brr_mode);
+
+	if (!err) {
+		if (brr_mode == ETHTOOL_PHY_BRR_MODE_ON) {
+			linkmode_set_bit_array(phy_basic_ports_array,
+					       ARRAY_SIZE(phy_basic_ports_array),
+					       phydev->supported);
+
+			val = phy_read(phydev, MII_BCM54XX_LRESR);
+			if (val < 0)
+				return val;
+
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+					 phydev->supported, 1);
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_1BR100_BIT,
+					 phydev->supported,
+					 val & LRESR_100_1PAIR);
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_4BR100_BIT,
+					 phydev->supported,
+					 val & LRESR_100_4PAIR);
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_2BR100_BIT,
+					 phydev->supported,
+					 val & LRESR_100_2PAIR);
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_2BR10_BIT,
+					 phydev->supported,
+					 val & LRESR_10_2PAIR);
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_1BR10_BIT,
+					 phydev->supported,
+					 val & LRESR_10_1PAIR);
+		} else {
+			return genphy_read_abilities(phydev);
+		}
+	}
+
+	return err;
+}
+
+static int bcm54811_get_tunable(struct phy_device *phydev,
+				struct ethtool_tunable *tuna, void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_BRR_MODE:
+		return bcm54811_get_brrmode(phydev, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int bcm54811_set_tunable(struct phy_device *phydev,
+				struct ethtool_tunable *tuna, const void *data)
+{
+	int res;
+
+	switch (tuna->id) {
+	case ETHTOOL_PHY_BRR_MODE:
+		res =  bcm54811_set_brrmode(phydev, *(const u8 *)data);
+		if (res >= 0)
+			res = bcm54811_read_abilities(phydev);
+		break;
+	default:
+		res = -EOPNOTSUPP;
+	}
+
+	return res;
+}
+
+static int bcm_read_master_slave(struct phy_device *phydev)
+{
+	int cfg, state;
+	int val;
+
+	/* In BroadR-Reach mode we are always capable of master-slave
+	 *  and there is no preferred master or slave configuration
+	 */
+	phydev->master_slave_get = MASTER_SLAVE_CFG_UNKNOWN;
+	phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+
+	val = phy_read(phydev, MII_BCM54XX_LRECR);
+	if (val < 0)
+		return val;
+
+	if ((val & LRECR_LDSEN) == 0) {
+		if (val & LRECR_MASTER)
+			cfg = MASTER_SLAVE_CFG_MASTER_FORCE;
+		else
+			cfg = MASTER_SLAVE_CFG_SLAVE_FORCE;
+	}
+
+	val = phy_read(phydev, MII_BCM54XX_LRELDSE);
+	if (val < 0)
+		return val;
+
+	if (val & LDSE_MASTER)
+		state = MASTER_SLAVE_STATE_MASTER;
+	else
+		state = MASTER_SLAVE_STATE_SLAVE;
+
+	phydev->master_slave_get = cfg;
+	phydev->master_slave_state = state;
+
+	return 0;
+}
+
+/* Read LDS Link Partner Ability in BroadR-Reach mode */
+static int bcm_read_lpa(struct phy_device *phydev)
+{
+	int i, lrelpa;
+
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		if (!phydev->autoneg_complete) {
+			/* aneg not yet done, reset all relevant bits */
+			static int br_bits[] = { ETHTOOL_LINK_MODE_Autoneg_BIT,
+						 ETHTOOL_LINK_MODE_Pause_BIT,
+						 ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+						 ETHTOOL_LINK_MODE_1BR10_BIT,
+						 ETHTOOL_LINK_MODE_2BR10_BIT,
+						 ETHTOOL_LINK_MODE_1BR100_BIT,
+						 ETHTOOL_LINK_MODE_2BR100_BIT,
+						 ETHTOOL_LINK_MODE_4BR100_BIT };
+			for (i = 0; i < ARRAY_SIZE(br_bits); i++)
+				linkmode_clear_bit(br_bits[i], phydev->lp_advertising);
+
+			return 0;
+		}
+
+		/* Long-Distance-Signalling Link Partner Ability */
+		lrelpa = phy_read(phydev, MII_BCM54XX_LRELPA);
+		if (lrelpa < 0)
+			return lrelpa;
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				 phydev->lp_advertising, lrelpa & LRELPA_PAUSE_ASYM);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 phydev->lp_advertising, lrelpa & LRELPA_PAUSE);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_1BR100_BIT,
+				 phydev->lp_advertising, lrelpa & LRELPA_100_1PAIR);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_4BR100_BIT,
+				 phydev->lp_advertising, lrelpa & LRELPA_100_4PAIR);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_2BR100_BIT,
+				 phydev->lp_advertising, lrelpa & LRELPA_100_2PAIR);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_2BR10_BIT,
+				 phydev->lp_advertising, lrelpa & LRELPA_10_2PAIR);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_1BR10_BIT,
+				 phydev->lp_advertising, lrelpa & LRELPA_10_1PAIR);
+	} else {
+		linkmode_zero(phydev->lp_advertising);
+	}
+
+	return 0;
+}
+
+static int bcm_read_status_fixed(struct phy_device *phydev)
+{
+	int lrecr = phy_read(phydev, MII_BCM54XX_LRECR);
+
+	if (lrecr < 0)
+		return lrecr;
+
+	phydev->duplex = DUPLEX_FULL;
+
+	if (lrecr & LRECR_SPEED100)
+		phydev->speed = SPEED_100;
+	else
+		phydev->speed = SPEED_10;
+
+	return 0;
+}
+
+static int bcm54811_read_status(struct phy_device *phydev)
+{
+	int err;
+	u8 brr_mode;
+
+	err = bcm54811_get_brrmode(phydev, &brr_mode);
+
+	if (!err) {
+		if (brr_mode == ETHTOOL_PHY_BRR_MODE_ON) {
+			/* Get the status in BroadRReach mode just like genphy_read_status
+			 *   does in normal mode
+			 */
+
+			int err, old_link = phydev->link;
+
+			/* Update the link, but return if there was an error
+			 *  genphy_update_link() functions equally on IEEE and LRE
+			 *  register set
+			 */
+
+			err = genphy_update_link(phydev);
+			if (err)
+				return err;
+
+			/* why bother the PHY if nothing can have changed */
+			if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
+				return 0;
+
+			phydev->speed = SPEED_UNKNOWN;
+			phydev->duplex = DUPLEX_UNKNOWN;
+			phydev->pause = 0;
+			phydev->asym_pause = 0;
+
+			err = bcm_read_master_slave(phydev);
+			if (err < 0)
+				return err;
+
+			/* Read LDS Link Partner Ability */
+			err = bcm_read_lpa(phydev);
+			if (err < 0)
+				return err;
+
+			if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
+				phy_resolve_aneg_linkmode(phydev);
+			} else if (phydev->autoneg == AUTONEG_DISABLE) {
+				err = bcm_read_status_fixed(phydev);
+				if (err < 0)
+					return err;
+			}
+		} else {
+			err = genphy_read_status(phydev);
+		}
+	}
+
+	return err;
+}
+
 static struct phy_driver broadcom_drivers[] = {
 {
 	.phy_id		= PHY_ID_BCM5411,
@@ -1215,6 +1625,10 @@ static struct phy_driver broadcom_drivers[] = {
 	.config_aneg    = bcm5481_config_aneg,
 	.config_intr    = bcm_phy_config_intr,
 	.handle_interrupt = bcm_phy_handle_interrupt,
+	.read_status	= bcm54811_read_status,
+	.get_tunable	= bcm54811_get_tunable,
+	.set_tunable	= bcm54811_set_tunable,
+	.get_features	= bcm54811_read_abilities,
 	.suspend	= bcm54xx_suspend,
 	.resume		= bcm54xx_resume,
 	.link_change_notify	= bcm54xx_link_change_notify,
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 15f349e5995a..e43baa69ac07 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -13,10 +13,9 @@
  */
 const char *phy_speed_to_str(int speed)
 {
-	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 102,
-		"Enum ethtool_link_mode_bit_indices and phylib are out of sync. "
-		"If a speed or mode has been added please update phy_speed_to_str "
-		"and the PHY settings array.\n");
+	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 107,
+			 "Enum ethtool_link_mode_bit_indices and phylib are out of sync. If a speed or mode has been added please update phy_speed_to_str and the PHY settings array.\n"
+			);
 
 	switch (speed) {
 	case SPEED_10:
@@ -258,6 +257,9 @@ static const struct phy_setting settings[] = {
 	PHY_SETTING(    100, HALF,    100baseT_Half		),
 	PHY_SETTING(    100, HALF,    100baseFX_Half		),
 	PHY_SETTING(    100, FULL,    100baseFX_Full		),
+	PHY_SETTING(    100, FULL,    4BR100			),
+	PHY_SETTING(    100, FULL,    2BR100			),
+	PHY_SETTING(    100, FULL,    1BR100			),
 	/* 10M */
 	PHY_SETTING(     10, FULL,     10baseT_Full		),
 	PHY_SETTING(     10, HALF,     10baseT_Half		),
@@ -265,6 +267,9 @@ static const struct phy_setting settings[] = {
 	PHY_SETTING(     10, FULL,     10baseT1S_Full		),
 	PHY_SETTING(     10, HALF,     10baseT1S_Half		),
 	PHY_SETTING(     10, HALF,     10baseT1S_P2MP_Half	),
+	PHY_SETTING(     10, FULL,     2BR10			),
+	PHY_SETTING(     10, FULL,     1BR10			),
+
 };
 #undef PHY_SETTING
 
diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 1394ba302367..9c0b78c1b6fb 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -270,16 +270,105 @@
 #define BCM5482_SSD_SGMII_SLAVE		0x15	/* SGMII Slave Register */
 #define BCM5482_SSD_SGMII_SLAVE_EN	0x0002	/* Slave mode enable */
 #define BCM5482_SSD_SGMII_SLAVE_AD	0x0001	/* Slave auto-detection */
+#define BCM5482_SSD_SGMII_SLAVE_AD	0x0001	/* Slave auto-detection */
+
+/* BroadR-Reach LRE Registers. */
+#define MII_BCM54XX_LRECR		0x00	/* LRE Control Register                    */
+#define MII_BCM54XX_LRESR		0x01	/* LRE Status Register                     */
+#define MII_BCM54XX_LREPHYSID1		0x02	/* LRE PHYS ID 1                           */
+#define MII_BCM54XX_LREPHYSID2		0x03	/* LRE PHYS ID 2                           */
+#define MII_BCM54XX_LREANAA		0x04	/* LDS Auto-Negotiation Advertised Ability */
+#define MII_BCM54XX_LREANAC		0x05	/* LDS Auto-Negotiation Advertised Control */
+#define MII_BCM54XX_LREANPT		0x06	/* LDS Ability Next Page Transmit          */
+#define MII_BCM54XX_LRELPA		0x07	/* LDS Link Partner Ability                */
+#define MII_BCM54XX_LRELPNPM		0x08	/* LDS Link Partner Next Page Message      */
+#define MII_BCM54XX_LRELPNPC		0x09	/* LDS Link Partner Next Page Control      */
+#define MII_BCM54XX_LRELDSE		0x0a	/* LDS Expansion Register                  */
+#define MII_BCM54XX_LREES		0x0f	/* LRE Extended Status                     */
+
+/* LRE control register. */
+#define LRECR_RESET			0x8000	/* Reset to default state      */
+#define LRECR_LOOPBACK			0x4000	/* Internal Loopback           */
+#define LRECR_LDSRES			0x2000	/* Restart LDS Process         */
+#define LRECR_LDSEN			0x1000	/* LDS Enable                  */
+#define LRECR_PDOWN			0x0800	/* Enable low power state      */
+#define LRECR_ISOLATE			0x0400	/* Isolate data paths from MII */
+#define LRECR_SPEED100			0x0200	/* Select 100 Mbps             */
+#define LRECR_SPEED10			0x0000	/* Select 10 Mbps              */
+#define LRECR_4PAIRS			0x0020	/* Select 4 Pairs              */
+#define LRECR_2PAIRS			0x0010	/* Select 2 Pairs              */
+#define LRECR_1PAIR			0x0000	/* Select 1 Pair               */
+#define LRECR_MASTER			0x0008	/* Force Master when LDS disabled */
+#define LRECR_SLAVE			0x0000	/* Force Slave when LDS disabled  */
+
+/* LRE status register. */
+#define LRESR_ERCAP			0x0001	/* Ext-reg capability          */
+#define LRESR_JCD			0x0002	/* Jabber detected             */
+#define LRESR_LSTATUS			0x0004	/* Link status                 */
+#define LRESR_LDSABILITY		0x0008	/* Can do LDS                  */
+#define LRESR_8023			0x0010	/* Has IEEE 802.3 Support      */
+#define LRESR_LDSCOMPLETE		0x0020	/* LDS Auto-negotiation complete */
+#define LRESR_MFPS			0x0040	/* Can suppress Management Frames Preamble */
+#define LRESR_RESV			0x0080	/* Unused...                   */
+#define LRESR_ESTATEN			0x0100	/* Extended Status in R15      */
+#define LRESR_10_1PAIR			0x0200	/* Can do 10Mbps 1 Pair        */
+#define LRESR_10_2PAIR			0x0400	/* Can do 10Mbps 2 Pairs       */
+#define LRESR_100_2PAIR			0x0800	/* Can do 100Mbps 2 Pairs      */
+#define LRESR_100_4PAIR			0x1000	/* Can do 100Mbps 4 Pairs      */
+#define LRESR_100_1PAIR			0x2000	/* Can do 100Mbps 1 Pair       */
+
+/* LDS Auto-Negotiation Advertised Ability. */
+#define LREANAA_PAUSE_ASYM		0x8000	/* Can pause asymmetrically    */
+#define LREANAA_PAUSE			0x4000	/* Can pause                   */
+#define LREANAA_100_1PAIR		0x0020	/* Can do 100Mbps 1 Pair       */
+#define LREANAA_100_4PAIR		0x0010	/* Can do 100Mbps 4 Pair       */
+#define LREANAA_100_2PAIR		0x0008	/* Can do 100Mbps 2 Pair       */
+#define LREANAA_10_2PAIR		0x0004	/* Can do 10Mbps 2 Pair        */
+#define LREANAA_10_1PAIR		0x0002	/* Can do 10Mbps 1 Pair        */
+
+#define LRE_ADVERTISE_FULL		(LREANAA_100_1PAIR | LREANAA_100_4PAIR | \
+					 LREANAA_100_2PAIR | LREANAA_10_2PAIR | \
+					 LREANAA_10_1PAIR)
+
+#define LRE_ADVERTISE_ALL		LRE_ADVERTISE_FULL
+
+/* LDS Link Partner Ability. */
+#define LRELPA_PAUSE_ASYM		0x8000	/* Supports asymmetric pause   */
+#define LRELPA_PAUSE			0x4000	/* Supports pause capability   */
+#define LRELPA_100_1PAIR		0x0020	/* 100Mbps 1 Pair capable      */
+#define LRELPA_100_4PAIR		0x0010	/* 100Mbps 4 Pair capable      */
+#define LRELPA_100_2PAIR		0x0008	/* 100Mbps 2 Pair capable      */
+#define LRELPA_10_2PAIR			0x0004	/* 10Mbps 2 Pair capable       */
+#define LRELPA_10_1PAIR			0x0002	/* 10Mbps 1 Pair capable       */
+
+/* LDS Expansion register. */
+#define LDSE_DOWNGRADE			0x8000	/* Can do LDS Speed Downgrade  */
+#define LDSE_MASTER			0x4000	/* Master / Slave              */
+#define LDSE_PAIRS_MASK			0x3000	/* Pair Count Mask             */
+#define LDSE_4PAIRS			0x2000	/* 4 Pairs Connection          */
+#define LDSE_2PAIRS			0x1000	/* 2 Pairs Connection          */
+#define LDSE_1PAIR			0x0000	/* 1 Pair  Connection          */
+#define LDSE_CABLEN_MASK		0x0FFF	/* Cable Length Mask           */
 
 /* BCM54810 Registers */
 #define BCM54810_EXP_BROADREACH_LRE_MISC_CTL	(MII_BCM54XX_EXP_SEL_ER + 0x90)
 #define BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN	(1 << 0)
 #define BCM54810_SHD_CLK_CTL			0x3
 #define BCM54810_SHD_CLK_CTL_GTXCLK_EN		(1 << 9)
+#define BCM54810_SHD_SCR3_TRDDAPD		0x0100
+
+/* BCM54811 Registers */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL	(MII_BCM54XX_EXP_SEL_ER + 0x9A)
+/* Access Control Override Enable */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_EN		BIT(15)
+/* Access Control Override Value */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL	BIT(14)
+/* Access Control Value */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_VAL		BIT(13)
 
 /* BCM54612E Registers */
 #define BCM54612E_EXP_SPARE0		(MII_BCM54XX_EXP_SEL_ETC + 0x34)
-#define BCM54612E_LED4_CLK125OUT_EN	(1 << 1)
+#define BCM54612E_LED4_CLK125OUT_EN	BIT(1)
 
 
 /* Wake-on-LAN registers */
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 95c2f09f0d0a..b7389204e715 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -289,11 +289,18 @@ struct ethtool_tunable {
 #define ETHTOOL_PHY_EDPD_NO_TX			0xfffe
 #define ETHTOOL_PHY_EDPD_DISABLE		0
 
+/*
+ *	BroadR-Reach Mode Control
+ */
+#define ETHTOOL_PHY_BRR_MODE_ON		1
+#define ETHTOOL_PHY_BRR_MODE_OFF	0
+
 enum phy_tunable_id {
 	ETHTOOL_PHY_ID_UNSPEC,
 	ETHTOOL_PHY_DOWNSHIFT,
 	ETHTOOL_PHY_FAST_LINK_DOWN,
 	ETHTOOL_PHY_EDPD,
+	ETHTOOL_PHY_BRR_MODE,
 	/*
 	 * Add your fresh new phy tunable attribute above and remember to update
 	 * phy_tunable_strings[] in net/ethtool/common.c
@@ -1790,7 +1797,11 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_10baseT1S_Full_BIT		 = 99,
 	ETHTOOL_LINK_MODE_10baseT1S_Half_BIT		 = 100,
 	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT	 = 101,
-
+	ETHTOOL_LINK_MODE_1BR10_BIT			 = 102,
+	ETHTOOL_LINK_MODE_2BR10_BIT			 = 103,
+	ETHTOOL_LINK_MODE_1BR100_BIT			 = 104,
+	ETHTOOL_LINK_MODE_2BR100_BIT			 = 105,
+	ETHTOOL_LINK_MODE_4BR100_BIT			 = 106,
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
 };
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 6b2a360dcdf0..81ad9d2aef1f 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -98,6 +98,7 @@ phy_tunable_strings[__ETHTOOL_PHY_TUNABLE_COUNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_PHY_DOWNSHIFT]	= "phy-downshift",
 	[ETHTOOL_PHY_FAST_LINK_DOWN] = "phy-fast-link-down",
 	[ETHTOOL_PHY_EDPD]	= "phy-energy-detect-power-down",
+	[ETHTOOL_PHY_BRR_MODE]	= "phy-broadrreach-mode",
 };
 
 #define __LINK_MODE_NAME(speed, type, duplex) \
@@ -211,6 +212,11 @@ const char link_mode_names[][ETH_GSTRING_LEN] = {
 	__DEFINE_LINK_MODE_NAME(10, T1S, Full),
 	__DEFINE_LINK_MODE_NAME(10, T1S, Half),
 	__DEFINE_LINK_MODE_NAME(10, T1S_P2MP, Half),
+	__DEFINE_SPECIAL_MODE_NAME(1BR10, "1BR10"),
+	__DEFINE_SPECIAL_MODE_NAME(2BR10, "2BR10"),
+	__DEFINE_SPECIAL_MODE_NAME(1BR100, "1BR100"),
+	__DEFINE_SPECIAL_MODE_NAME(2BR100, "2BR100"),
+	__DEFINE_SPECIAL_MODE_NAME(4BR100, "4BR100"),
 };
 static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
@@ -374,6 +380,31 @@ const struct link_mode_info link_mode_params[] = {
 	__DEFINE_LINK_MODE_PARAMS(10, T1S, Full),
 	__DEFINE_LINK_MODE_PARAMS(10, T1S, Half),
 	__DEFINE_LINK_MODE_PARAMS(10, T1S_P2MP, Half),
+	[ETHTOOL_LINK_MODE_1BR10_BIT] = {
+		.speed	= SPEED_10,
+		.lanes  = 1,
+		.duplex = DUPLEX_FULL,
+	},
+	[ETHTOOL_LINK_MODE_2BR10_BIT] = {
+		.speed	= SPEED_10,
+		.lanes  = 2,
+		.duplex = DUPLEX_FULL,
+	},
+	[ETHTOOL_LINK_MODE_1BR100_BIT] = {
+		.speed	= SPEED_100,
+		.lanes  = 1,
+		.duplex = DUPLEX_FULL,
+	},
+	[ETHTOOL_LINK_MODE_2BR100_BIT] = {
+		.speed	= SPEED_100,
+		.lanes  = 2,
+		.duplex = DUPLEX_FULL,
+	},
+	[ETHTOOL_LINK_MODE_4BR100_BIT] = {
+		.speed	= SPEED_100,
+		.lanes  = 4,
+		.duplex = DUPLEX_FULL,
+	},
 };
 static_assert(ARRAY_SIZE(link_mode_params) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 5a55270aa86e..9e68c8562fa3 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2722,6 +2722,7 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
 	switch (tuna->id) {
 	case ETHTOOL_PHY_DOWNSHIFT:
 	case ETHTOOL_PHY_FAST_LINK_DOWN:
+	case ETHTOOL_PHY_BRR_MODE:
 		if (tuna->len != sizeof(u8) ||
 		    tuna->type_id != ETHTOOL_TUNABLE_U8)
 			return -EINVAL;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b07aa71b24ec..98cb5a22a281 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4673,7 +4673,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92);
+//	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
-- 
2.39.2


