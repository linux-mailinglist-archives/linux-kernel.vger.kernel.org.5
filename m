Return-Path: <linux-kernel+bounces-167401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59C98BA90C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA8CB22D3A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7D1509B3;
	Fri,  3 May 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="nvUKT5Zh"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2228614EC67;
	Fri,  3 May 2024 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725712; cv=fail; b=a5P+Tb6itPlz32OIMuuZz9hi19mU0bD8crrDl3ZtJ8owW4s3baj+7qgri1p/Baw8UK0+2fCl3kJHGlzk+Gs5z1Wqf4VIbN4azUXJFTHVF5W3Qbbl58pyWUIQ0bQE274iSI/UQ/LbEBlmnhmO2JiaE5QCi/Obg4rhkd0a4SK4yl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725712; c=relaxed/simple;
	bh=UlKDxwkg1zDIYvXAqDRL8HNJoK6ZBnjDkwC0AMWzksM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMLKdd4fHRKHP+G7T+E240nAB8kZWTUGsCeVClhkf7+4f6CjjfqKR3ioLmslRD7ETPvoEf73ljUd0vftBEPFyrxnMBbC7r7G8k+83gwWD5v51Wd02RNP3THBp+lI2yJcwOnajG76CT1Wfez6nU1hGdKYrLPZmv3SMzv9/aBePso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=nvUKT5Zh; arc=fail smtp.client-ip=40.107.241.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWPJMQnKju4m8RbVrPlR4l2sHXnuTAVnarsqrm1RSQ8fvLQQ4BJgsHIZ6/t5yUW1PnM7mBqCpzjrlaRrzjJGpaL3FeyR6eg96wu4DbK1iJZfZpqOGAA4aAhQFXXh0Nj+Arpa5AQwWFIIY0qbqcHBN/Ow0cPZ8P6R+AwcFCZgjM8viCO7BvuzcKKNbC0Dyz/goyWnkkbLIIBhZfygTqUOCj+zu0TDHUvZKfnynCfTg5jE2S5xU3dF2O5u29a/iE+987UPJmy+tp+LmAsO4CYhqnSBTltdTPseuSMrdDEwn53J476EPqo4jRNZMJsURZXlPpFQ85wmh/pL9tQV4cjwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amQVesDqbY5D72q2/5qdNoPLmsUrKEB5rnzFafOFMtM=;
 b=j0r5dQorGVWiqW6ylcIk/3BVS890M2QtaDsKLFEyG05QfatUpo6XAUlsIpmlhc2y/6aWMGpzvLQ1rqK0O5LBrN61DNASczrNyx3TTICKJo2YO5lJYwMr0Lar/aPPkMn58/Pvgfsk2j6HgOQsw3IAkmeGm8JwLgbaB6i0c4Qkx/0HgXW6jzUKsT30XzQb0xrz+QQwyEUj0TPQD3fP2JEbao6R/fml3/H7bulTEGBEXsXhoLZjdpFMLOfXED0xyfleBg7jaq8Iir+QTep9Ohvo3v+oMlWs5609a42ni5E02wX7FIhYR4rlGyOcEYpKGq61pIvTOPNpwHOK7awGm0aS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amQVesDqbY5D72q2/5qdNoPLmsUrKEB5rnzFafOFMtM=;
 b=nvUKT5Zh4p+rvlHY8/vfPhgJr8M3Ul/YodQ98e58V15HXYNkdn4tFT+F05Sk0fXAEF8vzLb2yzdNg1MB720+lELz9bQnQ/Z9A+YO8qcmi+XovkoM/G+OnRgqYfK5yJdZLSUOolzSPpBIESzOUJbB5goiv2eOv0UfB4kyrcBjUQY=
Received: from DUZP191CA0038.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::22)
 by DB9PR02MB7227.eurprd02.prod.outlook.com (2603:10a6:10:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 08:41:46 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::5) by DUZP191CA0038.outlook.office365.com
 (2603:10a6:10:4f8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Fri, 3 May 2024 08:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 3 May 2024 08:41:44 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 May
 2024 10:41:43 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] net: phy: bcm-phy-lib: Implement BroadR-Reach link modes
Date: Fri, 3 May 2024 10:37:19 +0200
Message-ID: <20240503083719.899312-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503083719.899312-1-kamilh@axis.com>
References: <20240503083719.899312-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|DB9PR02MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6c206f-d77f-4225-1b50-08dc6b4cdcf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVlmbXRPMDZZWm0za2I1dUtqQ0R0ZDUvMEgxZ0hWNGdpbzBVN0hVVmZLcXlz?=
 =?utf-8?B?RWMvV2NxenplbHR1a0ZqRmtmbjBQRlYzWERKZXk0WE9ObVYrYXlweHZ0TVhU?=
 =?utf-8?B?TzBVekFSNWtYWmJ0MVp0a3BIR2VvTnhNUE4vSXdUQW5NdkxCbFZ0SFdEUUVL?=
 =?utf-8?B?RDBSMjE2Mk5hdFVKekNuYk9wLzBuL1V6MVZISmhabldXdUdKTll2dUd0NFA5?=
 =?utf-8?B?T0g2b1IzT1h6NnJvVUJrVEhyRWQ1bVRsWUc5MXl5Yks2M1dBYmEyT2svS2VU?=
 =?utf-8?B?bDZTcDczMVE0d1RPc1B4bzkwN0Zxbk1EYVVRWVl0VGJGcU1oeEpxalNvVjZ0?=
 =?utf-8?B?citxOFROQTA5SXh1cHVEdlJzMUcrTkVFS281bllkVUNlOHJIS3l4ZGw2R0t0?=
 =?utf-8?B?TksrYkZjYk1HQmNRRGVFMXgycnBKRk43WWkxbm94Tk9YWHR4N2luTEFBaDFj?=
 =?utf-8?B?OG1SUWk2YkFiYWZ2bi9oKzExVnZOQ3NRZzQ5dkxLVk9jYkVNcVRjVU9kdUZl?=
 =?utf-8?B?cmZUa2tFb0NmVXVmcFF4ZDNCVXJydWpFeUtIdzNIZmhCMmUyREJ6bURtTGkx?=
 =?utf-8?B?REZ3dWtRK2thczlIVkplSjBwWi9hZlJBczlvZHdmUFdGNEw3clBybXVBeXJx?=
 =?utf-8?B?WmVNWWdjSmtEOWJsVnN0eEptelhUaktDNkhqMm9Id0VPOS9GckJ0eDJBanRw?=
 =?utf-8?B?R0RVNHdUZnFMSktJa3M2ZUZyeUw4MUFZWkhLaUhLVStadTFIbmJPVjlIem9u?=
 =?utf-8?B?MFlKS0kwZzZaRE1IUTdFcVI2a0hCUDZCNys5MmxXQXJrT3lsbUh0Qm02WVhK?=
 =?utf-8?B?VFpOK3NLTzRhdkVKdDREb0ZNbzg1ZG9rLy91UElaMlBsTGxiS3ZycFdiL2N2?=
 =?utf-8?B?M3Z2WXdNQ1FmQkg1Y3B5T2JNTjMyVnpRMW9qWTFYNEpFVjFIUDJuUzhXamp3?=
 =?utf-8?B?dmFaTHFxTWNLR0J2VVc2YVc1bGdxSVI2eDd2Z0pwOEMwMXlJaFlvQ0RSUTJq?=
 =?utf-8?B?TTJJbUlzcmZTWUhZWmpjWmEvWlRLOEQxUjBlTzVvR3VmMU02VWRmeUJoNkJx?=
 =?utf-8?B?bVhLdGY4TU1JKzY0Y1lleUpJTG9IVXIvNUR6c0RaTmtsWjhJaXc0UUpDUSt5?=
 =?utf-8?B?ekh1SFFwOEtXVWtYN0VEOHVEUEUwMmQ3eXRUaWdNTGR6QzBwcjY4bTdiVzZE?=
 =?utf-8?B?LzNPRGFnbWJxVjFLUGxQSWtyRVU3Z2txN054TVpONjVxb1Z4MGxwT1VlMzNn?=
 =?utf-8?B?RFlYRE1rV2x1TXlUblpCZXBCVlJ4UGUwTHhIeXRyeVB3Nzk5UFdSdlhZZFRx?=
 =?utf-8?B?T2hwdmNTQkN4eUNhWmdoc2hpS1lqY1NJNnBDbWZJVFhTbjNtZVNsUWlzQ0FR?=
 =?utf-8?B?N1dhcjNrZDZJcGZ2UTNxSzJGUnIzYW1FYTVhRlBwbEduNlpzRElNSkxjQnNt?=
 =?utf-8?B?eGV4blprbFFNWG1TQlkxOW5ETmRXRDg0U1hzbTJpZVorN281ZmJaMVZhaFhi?=
 =?utf-8?B?UjFQZnlYL0JyTENpT0R5WmxHa25zV29kdDdPWmQvT1dyRmdBQmtDWHZXWUFs?=
 =?utf-8?B?WTJ5UnJ0SGZLUG9sZVhXNjQ0bm5mbHlKZ2xpSVJ5QVBDdHM0R0N5Q0VYdGIz?=
 =?utf-8?B?TEREOEdVbUlzRnpmTk9MeW1qM05tSFhZaHNSc3N1b0EvcmVxVDErK3hkT2tU?=
 =?utf-8?B?OE5jNkZHYnUvOVVwZ3BQMjZWb0VBZGY1dk5lUVlKZ1N1SDBGanBnZlNFZHRm?=
 =?utf-8?B?N2YzWDZqUzBadmVuSDVUVUtpU0lUVFZicm5Bc3RSTXp6SzZER29DWHlvTGMw?=
 =?utf-8?B?N1hzamJSR3hGK1JUR0ovc2EvKzFEeU1oUDhGZFdia1hPcFRKMm1Vc3U0aWlh?=
 =?utf-8?Q?/mTTFuiEltkTM?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 08:41:44.7461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6c206f-d77f-4225-1b50-08dc6b4cdcf1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7227

Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
Create set of functions alternative to IEEE 802.3 to handle configuration
of these modes on compatible Broadcom PHYs.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 drivers/net/phy/bcm-phy-lib.c | 122 ++++++++++++
 drivers/net/phy/bcm-phy-lib.h |   4 +
 drivers/net/phy/broadcom.c    | 336 ++++++++++++++++++++++++++++++++--
 3 files changed, 448 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index 876f28fd8256..9fa2a20e641f 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -794,6 +794,46 @@ static int _bcm_phy_cable_test_get_status(struct phy_device *phydev,
 	return ret;
 }
 
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
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT, advertising))
+		result |= LREANAA_100_1PAIR;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT, advertising))
+		result |= LRELPA_PAUSE;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, advertising))
+		result |= LRELPA_PAUSE_ASYM;
+
+	return result;
+}
+
 int bcm_phy_cable_test_start(struct phy_device *phydev)
 {
 	return _bcm_phy_cable_test_start(phydev, false);
@@ -1066,6 +1106,88 @@ int bcm_phy_led_brightness_set(struct phy_device *phydev,
 }
 EXPORT_SYMBOL_GPL(bcm_phy_led_brightness_set);
 
+int bcm_setup_master_slave(struct phy_device *phydev)
+{
+	u16 ctl = 0;
+
+	switch (phydev->master_slave_set) {
+	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
+	case MASTER_SLAVE_CFG_MASTER_FORCE:
+		ctl = LRECR_MASTER;
+		break;
+	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
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
+EXPORT_SYMBOL_GPL(bcm_setup_master_slave);
+
+int bcm_config_aneg(struct phy_device *phydev, bool changed)
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
+}
+EXPORT_SYMBOL_GPL(bcm_config_aneg);
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
+int bcm_config_advert(struct phy_device *phydev)
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
+EXPORT_SYMBOL_GPL(bcm_config_advert);
+
 MODULE_DESCRIPTION("Broadcom PHY Library");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Broadcom Corporation");
diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
index b52189e45a84..0f6d06c0b7af 100644
--- a/drivers/net/phy/bcm-phy-lib.h
+++ b/drivers/net/phy/bcm-phy-lib.h
@@ -121,4 +121,8 @@ irqreturn_t bcm_phy_wol_isr(int irq, void *dev_id);
 int bcm_phy_led_brightness_set(struct phy_device *phydev,
 			       u8 index, enum led_brightness value);
 
+int bcm_setup_master_slave(struct phy_device *phydev);
+int bcm_config_aneg(struct phy_device *phydev, bool changed);
+int bcm_config_advert(struct phy_device *phydev);
+
 #endif /* _LINUX_BCM_PHY_LIB_H */
diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 370e4ed45098..5bb24c1a4428 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -553,18 +553,46 @@ static int bcm54810_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 	return -EOPNOTSUPP;
 }
 
-static int bcm54811_config_init(struct phy_device *phydev)
+static int bcm5481x_get_brrmode(struct phy_device *phydev, u8 *data)
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
+static int bcm5481x_set_brrmode(struct phy_device *phydev, u8 on)
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
@@ -576,18 +604,16 @@ static int bcm54811_config_init(struct phy_device *phydev)
 			return err;
 	}
 
-	return err;
+	/* Configure BroadR-Reach function. */
+	return  bcm5481x_set_brrmode(phydev, ETHTOOL_PHY_BRR_MODE_OFF);
 }
 
-static int bcm5481_config_aneg(struct phy_device *phydev)
+static int bcm5481x_config_delay_swap(struct phy_device *phydev)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
 	int ret;
 
-	/* Aneg firstly. */
-	ret = genphy_config_aneg(phydev);
-
-	/* Then we can set up the delay. */
+	/* Set up the delay. */
 	bcm54xx_config_clock_delay(phydev);
 
 	if (of_property_read_bool(np, "enet-phy-lane-swap")) {
@@ -601,6 +627,56 @@ static int bcm5481_config_aneg(struct phy_device *phydev)
 	return ret;
 }
 
+static int bcm5481_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+	u8 brr_mode;
+
+	/* Aneg firstly. */
+	ret = bcm5481x_get_brrmode(phydev, &brr_mode);
+	if (ret)
+		return ret;
+
+	if (brr_mode == ETHTOOL_PHY_BRR_MODE_ON)
+		ret = bcm_config_aneg(phydev, false);
+	else
+		ret = genphy_config_aneg(phydev);
+
+	if (ret)
+		return ret;
+
+	/* Then we can set up the delay and swap. */
+	return bcm5481x_config_delay_swap(phydev);
+}
+
+static int bcm54811_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+	u8 brr_mode;
+
+	/* Aneg firstly. */
+	ret = bcm5481x_get_brrmode(phydev, &brr_mode);
+	if (ret)
+		return ret;
+
+	if (brr_mode == ETHTOOL_PHY_BRR_MODE_ON) {
+		/* BCM54811 is only capable of autonegotiation in IEEE mode */
+		if (phydev->autoneg)
+			return -EOPNOTSUPP;
+
+		ret = bcm_config_aneg(phydev, false);
+
+	} else {
+		ret = genphy_config_aneg(phydev);
+	}
+
+	if (ret)
+		return ret;
+
+	/* Then we can set up the delay and swap. */
+	return bcm5481x_config_delay_swap(phydev);
+}
+
 struct bcm54616s_phy_priv {
 	bool mode_1000bx_en;
 };
@@ -1062,6 +1138,234 @@ static void bcm54xx_link_change_notify(struct phy_device *phydev)
 	bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_EXP08, ret);
 }
 
+static int bcm54811_read_abilities(struct phy_device *phydev)
+{
+	int val, err;
+	int i;
+	static const int modes_array[] = {ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
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
+	err = bcm5481x_get_brrmode(phydev, &brr_mode);
+
+	if (err)
+		return err;
+
+	if (brr_mode == ETHTOOL_PHY_BRR_MODE_ON) {
+		linkmode_set_bit_array(phy_basic_ports_array,
+				       ARRAY_SIZE(phy_basic_ports_array),
+				       phydev->supported);
+
+		val = phy_read(phydev, MII_BCM54XX_LRESR);
+		if (val < 0)
+			return val;
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				 phydev->supported, 1);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+				 phydev->supported,
+				 val & LRESR_100_1PAIR);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_1BR10_BIT,
+				 phydev->supported,
+				 val & LRESR_10_1PAIR);
+	} else {
+		return genphy_read_abilities(phydev);
+	}
+
+	return err;
+}
+
+static int bcm5481x_get_tunable(struct phy_device *phydev,
+				struct ethtool_tunable *tuna, void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_BRR_MODE:
+		return bcm5481x_get_brrmode(phydev, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int bcm5481x_set_tunable(struct phy_device *phydev,
+				struct ethtool_tunable *tuna, const void *data)
+{
+	int res;
+
+	switch (tuna->id) {
+	case ETHTOOL_PHY_BRR_MODE:
+		res =  bcm5481x_set_brrmode(phydev, *(const u8 *)data);
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
+	if (phydev->autoneg != AUTONEG_ENABLE) {
+		if (!phydev->autoneg_complete) {
+			/* aneg not yet done, reset all relevant bits */
+			static int br_bits[] = { ETHTOOL_LINK_MODE_Autoneg_BIT,
+						 ETHTOOL_LINK_MODE_Pause_BIT,
+						 ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+						 ETHTOOL_LINK_MODE_1BR10_BIT,
+						 ETHTOOL_LINK_MODE_100baseT1_Full_BIT };
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
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+				 phydev->lp_advertising, lrelpa & LRELPA_100_1PAIR);
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
+	err = bcm5481x_get_brrmode(phydev, &brr_mode);
+
+	if (err)
+		return err;
+
+	if (brr_mode == ETHTOOL_PHY_BRR_MODE_ON) {
+		/* Get the status in BroadRReach mode just like genphy_read_status
+		 *   does in normal mode
+		 */
+
+		int err, old_link = phydev->link;
+
+		/* Update the link, but return if there was an error
+		 *  genphy_update_link() functions equally on IEEE and LRE
+		 *  register set
+		 */
+
+		err = genphy_update_link(phydev);
+		if (err)
+			return err;
+
+		/* why bother the PHY if nothing can have changed */
+		if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
+			return 0;
+
+		phydev->speed = SPEED_UNKNOWN;
+		phydev->duplex = DUPLEX_UNKNOWN;
+		phydev->pause = 0;
+		phydev->asym_pause = 0;
+
+		err = bcm_read_master_slave(phydev);
+		if (err < 0)
+			return err;
+
+		/* Read LDS Link Partner Ability */
+		err = bcm_read_lpa(phydev);
+		if (err < 0)
+			return err;
+
+		if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
+			phy_resolve_aneg_linkmode(phydev);
+		} else if (phydev->autoneg == AUTONEG_DISABLE) {
+			err = bcm_read_status_fixed(phydev);
+			if (err < 0)
+				return err;
+		}
+	} else {
+		err = genphy_read_status(phydev);
+	}
+
+	return err;
+}
+
 static struct phy_driver broadcom_drivers[] = {
 {
 	.phy_id		= PHY_ID_BCM5411,
@@ -1212,9 +1516,13 @@ static struct phy_driver broadcom_drivers[] = {
 	.get_stats	= bcm54xx_get_stats,
 	.probe		= bcm54xx_phy_probe,
 	.config_init    = bcm54811_config_init,
-	.config_aneg    = bcm5481_config_aneg,
+	.config_aneg    = bcm54811_config_aneg,
 	.config_intr    = bcm_phy_config_intr,
 	.handle_interrupt = bcm_phy_handle_interrupt,
+	.read_status	= bcm54811_read_status,
+	.get_tunable	= bcm5481x_get_tunable,
+	.set_tunable	= bcm5481x_set_tunable,
+	.get_features	= bcm54811_read_abilities,
 	.suspend	= bcm54xx_suspend,
 	.resume		= bcm54xx_resume,
 	.link_change_notify	= bcm54xx_link_change_notify,
-- 
2.39.2


