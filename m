Return-Path: <linux-kernel+bounces-167397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 382948BA8F2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5392838D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E2314BFBF;
	Fri,  3 May 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="XQ3vo+7O"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6F79CD;
	Fri,  3 May 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725694; cv=fail; b=dwkqAWSUiJkv6P19c6X2kLCVbCyUUSWnXtYWOhZgBdIeARKXio+eNZovqnMfbwsxnCu1qiLWZTpMKZD6t6dn+Q0YD6aVsk6fRGv7HOWiEaP5NvE08IbbP2VoCWe2OBROO7IicrgATnIQSHiNCgAzEaHvXo6nMNlb0JwY5MuGWFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725694; c=relaxed/simple;
	bh=ql6MX3PQKVCr6P5TajVkFhz95idCAmM1zDB/CutAOpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4RB73Y69b75k+0Lq+WFbfrCZV5VxENZnErH97obWa01/rxkC1MRCtypS/ZQvbkEFqlwC5npUbwRDYmF7yUC6yC6aiYnWfpC3iyovXF8vc2CypPwEV0R6Z+EqHCZUVq3RrGIkHCWyb4hlbmKVd1cqBVcZbuVx/IhYXn+OVOMkuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=XQ3vo+7O; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/+L7Eh+Ich461oGMRd/qxAutgxwH4ZxMCmLuUwGZF/K2k3/OprJvL2MmNstdY8nehh/TmiOGmjGT8X/6hXxZ8IpgzzvAgXyM/kmrIHrv5aHlIQ9rNWu76AdfRWiZsK9L6Y1Tq/GCSSuoL/85SH3Q8JcnTaUoQMOpU8MTPHGUkhzvMPlkZSBxeJnyHLuTUyKvV9aQcBeaPF4iBj+yXtP72tJjGM6t85MXc4yc9euqCDz1a18PRFGaqER63TWStD3eb2+WufxL5hp5brJssOgDXbGQgx7waSQRd31nOAsz1M0zk3aCbsyWB543TRyyJCOCMgKqReTCIQMTpPK22hCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Gfxp8eWvRaT/oL2qcMuBOgBvFCpuRyaGOmIcHLxsXQ=;
 b=H7Gx0qwzQ30WINN1nRb0kp3rbBY6R/6FdV2lH04s2ph58MS9a/yTfkv8d+HuKL0TcWt1ewu3per6V6PHHBwNYnV0e6MSifbHw7XKrDQYZf7rg5tJV8F16gRsODkG4Acf9pkbMT4H0SchGzfHT2z9jpVoJq3oHKDN+LKiaxul5W4AoTjUafg0A+KO9Xic1saHxJFvdO2miWgFAshuT7bgAZxWOC388U/0pBXefqFzd50tv02ruFy2KimKdfAIEItn+tecDGCVdn8jjoWALiYO2uhpPZ/dagTZltYNUpJFHBrWk4bIgn1QMRYgmaq+P7j4hsZCQFZof8VxKA3gleTI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Gfxp8eWvRaT/oL2qcMuBOgBvFCpuRyaGOmIcHLxsXQ=;
 b=XQ3vo+7OTvGaDPYRM25D0bTgyhbqxo7TxmZC6KUsZ6rZV4Rk+S1PnrQ/rLtYrIIgWIFKS3Uh/gwORyV/Ct4qT1EZTScce/TZzOuMHAB9wp1Gs/tmpGR5sVUpNHdb0Y3KxWzDHQWidccZPqUTB0F7ka4liysUY8mxc0W1Zsriwio=
Received: from DB9PR06CA0005.eurprd06.prod.outlook.com (2603:10a6:10:1db::10)
 by PAWPR02MB9149.eurprd02.prod.outlook.com (2603:10a6:102:33d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Fri, 3 May
 2024 08:41:28 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::1) by DB9PR06CA0005.outlook.office365.com
 (2603:10a6:10:1db::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Fri, 3 May 2024 08:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 08:41:26 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 May
 2024 10:41:26 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] net: phy: bcm54811: New link mode for BroadR-Reach
Date: Fri, 3 May 2024 10:37:17 +0200
Message-ID: <20240503083719.899312-2-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FB:EE_|PAWPR02MB9149:EE_
X-MS-Office365-Filtering-Correlation-Id: 82266147-aca6-4a74-c6d5-08dc6b4cd245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDZQOTAzaVZYWTJTYXk3K25KSDlER2c1dDk5a3NJVlg5ODFHUktKcXVtWDk0?=
 =?utf-8?B?MXRJMFRhVHh4Y3lMSXdXbjk4V0RrZnFBbld0S0UyRmJSdFdnck9sMExvbEhk?=
 =?utf-8?B?ZlFBTDdnWjVpRE40aW1MRzRvang4VWkvZkJ3M0ZmSjVkaXBCc2w3c0lyVURX?=
 =?utf-8?B?ZlJScUJKNFZwMHMwMnJBY2RKakFqVUVGNnFhNnQ5RWJoeHJxMktWRE9WVVRZ?=
 =?utf-8?B?cjRLR3dTc0laMXRQb2xTTy9pdkZheVRJWHdVOGdDa1FqMWVjV2xOWUdJRTFI?=
 =?utf-8?B?Tm0xSE01dFdJd2hUWU5wcllKN1pIcnZydHZOdUtoYXg0aDRGTEMzckt2aEp5?=
 =?utf-8?B?QzRMV1graEtiSGJQVzZicFZSS0ZVWlk0SjFUd1c4b1V2am1nR1c3RTF6Q0l4?=
 =?utf-8?B?MXVyY0phWSttSVFiTERkN3FyeHZNeUlwQ25veUh6bE1UT3lXRlkySDhWU0k4?=
 =?utf-8?B?dlg1bW9Sa3pqRSsydkJ0SURhNWZTMHFpTW5GN01SRWFyL1ZuYTlNanBuN25V?=
 =?utf-8?B?czdHVkNQMU5DOE0yTzdiLy91dURaOGNzVzNyWjM3dXpaaisvZk9wZ3R5Tjdt?=
 =?utf-8?B?SDRiRTNrUHJWQlA0aXVFa0lXQjNOZXJYUEswTTIycU9FMWp0NGtuRk9BOFli?=
 =?utf-8?B?REI2M3ZUeWZ4elQxSTJZcEU3MkJpM0VMamdETU9VQlRPK2JSckxVUkpKQ2tJ?=
 =?utf-8?B?NGNYMTRYYWRCNnNPZmZrcFBHUDBxVG9xbnpORmQwL2dEczJjOEpXVUYvZkRW?=
 =?utf-8?B?UE9BSlNKNnFEb01vYStyRStmWlNqMkJQd0VNQkhxVGJxTGRicThNRTRMNlhW?=
 =?utf-8?B?M3JmSC9QNDN0Tjg2b2NJNmhHV2Y2Q0FvSFUrZVhNUWh6Z1JhM0x2UGdudXVF?=
 =?utf-8?B?eXFSS29uUS9FT253M2E3Q0Ywd3lpWlRVaHIyZUZoMzltNzBIVlR6VDNzOCt5?=
 =?utf-8?B?cE4wOW9nNE0rc3FZZVFXNk1xMUNsS3ZRQ2lDT1FBVVlYZ2QwcnByTE8vajZu?=
 =?utf-8?B?cEtwRTVoaUR1RFNJdWtQSUd1RU81UVYyb0hlMnZOVjhMaUlaR1V3bkJLQ0Zs?=
 =?utf-8?B?bjA5ZkFkSkRVWnNnL2xmVkR0YTkyeWFjN0IvU0NOdkRMSnI1M2ZGdHU5OWpP?=
 =?utf-8?B?S2FKbW91T2pXWXB1bHduY3EvQjlBWkJ5N0ppdlg3M1l0Y0hnUkMwdk5XRDFO?=
 =?utf-8?B?TXFIakVtU3pURm9pS0E2ZHhzSjVVaTJkTW95dkZtY1YyemhDTzMyYlMvR3NN?=
 =?utf-8?B?UWJOT1NIZGxWM0lIZkd0d3l1UFhaUzB0OTFZRkFYcGFobnJ0dW1tcDVlQk1E?=
 =?utf-8?B?dFBvclNMUTRrOFBBZmhSWEdGdklHQUtETDFFZnQva3hlWXVwak0xWWlYK0lS?=
 =?utf-8?B?UUVMSU51bnA0ZGRPbTdld1lSeHVSK0kxUVVJWVVQUzdkcFloLzVrQnZ0czhT?=
 =?utf-8?B?MlY3WTRidXp2MjZZL1ROWVFaQm1sREdVMjcyNWJpZ3lneDJXT0oyTkhIYzJM?=
 =?utf-8?B?R1h2aDA1V29KOE1vS2wrRUdtUGoxR21UYmQzQ1VtdUYrVU5BY21pQTNjbVFs?=
 =?utf-8?B?di9tS0cydEhuOUJLV2QrL0lJU2pydHJpYnpHNlE5Y3kzdHA1WEFCL3BWbjBN?=
 =?utf-8?B?QmtaaTIvbTVNSTFZZmo0RUl2NXA2eEYreUFGTFNxem9SRjdtTDRlYzZnWk5Q?=
 =?utf-8?B?bzJOeXpxc0pHZXRGcTA0a2J2dVkxRVRmSkxvSVQwdXN5cHREZVF3NzR6cGlP?=
 =?utf-8?B?RFplMG1iOTJVM1hJUGJiQ1BtdWVmMTFjSDNYYVFDT082L0pUUW1wdXRLWWVH?=
 =?utf-8?Q?JIjPOeaWBH5eCaBm/XxxIjH+oM+euchk5Xyzs=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 08:41:26.8461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82266147-aca6-4a74-c6d5-08dc6b4cd245
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9149

Introduce new link modes necessary for the BroadR-Reach mode on
bcm5481x PHY by Broadcom and new PHY tunable to choose between
normal (IEEE) ethernet and BroadR-Reach modes of the PHY.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 drivers/net/phy/phy-core.c   | 9 +++++----
 include/uapi/linux/ethtool.h | 9 ++++++++-
 net/ethtool/common.c         | 7 +++++++
 net/ethtool/ioctl.c          | 1 +
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 15f349e5995a..129e223d8985 100644
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
+	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 103,
+			 "Enum ethtool_link_mode_bit_indices and phylib are out of sync. If a speed or mode has been added please update phy_speed_to_str and the PHY settings array.\n"
+			);
 
 	switch (speed) {
 	case SPEED_10:
@@ -265,6 +264,8 @@ static const struct phy_setting settings[] = {
 	PHY_SETTING(     10, FULL,     10baseT1S_Full		),
 	PHY_SETTING(     10, HALF,     10baseT1S_Half		),
 	PHY_SETTING(     10, HALF,     10baseT1S_P2MP_Half	),
+	PHY_SETTING(     10, FULL,     1BR10			),
+
 };
 #undef PHY_SETTING
 
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 041e09c3515d..105432565e6d 100644
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
@@ -1845,7 +1852,7 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_10baseT1S_Full_BIT		 = 99,
 	ETHTOOL_LINK_MODE_10baseT1S_Half_BIT		 = 100,
 	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT	 = 101,
-
+	ETHTOOL_LINK_MODE_1BR10_BIT			 = 102,
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
 };
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 6b2a360dcdf0..5e37804958e9 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -98,6 +98,7 @@ phy_tunable_strings[__ETHTOOL_PHY_TUNABLE_COUNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_PHY_DOWNSHIFT]	= "phy-downshift",
 	[ETHTOOL_PHY_FAST_LINK_DOWN] = "phy-fast-link-down",
 	[ETHTOOL_PHY_EDPD]	= "phy-energy-detect-power-down",
+	[ETHTOOL_PHY_BRR_MODE]	= "phy-broadrreach-mode",
 };
 
 #define __LINK_MODE_NAME(speed, type, duplex) \
@@ -211,6 +212,7 @@ const char link_mode_names[][ETH_GSTRING_LEN] = {
 	__DEFINE_LINK_MODE_NAME(10, T1S, Full),
 	__DEFINE_LINK_MODE_NAME(10, T1S, Half),
 	__DEFINE_LINK_MODE_NAME(10, T1S_P2MP, Half),
+	__DEFINE_SPECIAL_MODE_NAME(1BR10, "1BR10"),
 };
 static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
@@ -374,6 +376,11 @@ const struct link_mode_info link_mode_params[] = {
 	__DEFINE_LINK_MODE_PARAMS(10, T1S, Full),
 	__DEFINE_LINK_MODE_PARAMS(10, T1S, Half),
 	__DEFINE_LINK_MODE_PARAMS(10, T1S_P2MP, Half),
+	[ETHTOOL_LINK_MODE_1BR10_BIT] = {
+		.speed	= SPEED_10,
+		.lanes  = 1,
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
-- 
2.39.2


