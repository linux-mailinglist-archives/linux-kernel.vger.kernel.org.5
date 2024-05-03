Return-Path: <linux-kernel+bounces-167399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 039888BA8F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265D71C2222A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345A614F9DA;
	Fri,  3 May 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="QwnXe0C0"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55214EC67;
	Fri,  3 May 2024 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725704; cv=fail; b=Pd0TKX0fp3gZyhghv0kGt2ce3ac0pxKBwpqfWz76MCnUjNVQNUgb0Kzp+ELTwGmroYVoHzbqpL9CgkN5rtD8WeyqcCvAbUYf3wgYnmSrHJbqit/ZRjm5QFIAnBRRsJ6+ez/U7inwCCMVp7xlEgampJVYg4yVAUYJj7P9zq9+wMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725704; c=relaxed/simple;
	bh=9ot9Azd5CWbCC433PNghPJhOrPRAkMUdxjAGTUCBJxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTt8TuPefS2AqIFixvHyAdBXUyB+GJD757P0lFChh6z/1ydeMyDFx3J3tTyegEGMQVEQrlY4A9CSWUIhIJcyrMOVPDJqG97bYSUDJT9FglUfkqKEbTJOaDFhLtCZn/foeJeqcaK1bGX8c/t8LURp4hyf1+uCVdCkNgURsN8SekU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=QwnXe0C0; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCntYEy38QDQ64CWmt3cLwZbdJX6R5Y2epf0zbeAJhnxmml/xEJ3c5Mq2JBuyfsr1XKj5ulw8GyxgPuFuclTz5ccpBXD46gh1lp+yCMDs09jNL7n5tWph+BdpiewfFdr362BWJtIUpuuCwMD7gu4fn+QGisQCTTquc8SlfAwcb9l50X6nnNupbaUvylf079K6Qp/Jj3cb1VWA0pB0qtNxtp+YvI6O2+KrgRTb5hYOBYwwCSiDeQSNNLSIxrt5gpYaakt9V82f/xQV+4WZik4cQWMhrP7f+/x1aM1EaCA0rWBlGf28a7KBYLfQwe6lueZXFiNY09ehBxf41kJEbzGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VD20iHxrex6Qn3AMKFw1EYu20fao49HMY4Z1mbe4Ynk=;
 b=LKJ4zWCF4Ywxpm1/2LtycJPv4CNgHt3K46OcixpOt937FvVx/LIctMeyHBPfFs9rnly4XUTC+JQ2LhEjDWrWHB5I1kG2fs2dVc7eRkcoqm37lduf0FrkhvEhQxZGidCUlB1tyzEYXYyAvJLJumoC5nevkAQMOlbJ0F/6bFq45Jw7SiTpIb1PrbQreT1hb/TSlQmS5tEHW4vfPk4SCWkIjaGTiOgCHSQDXZhzgJvzkOYTRXZan60gacazBI9/kZ1t76KzZkPwfXngfu1pWGSL2G3Wqp8IQT061AH406Lwj8BtmwWuaCM4RmbN6sOSzzhZkLlUtoGiZe3TN1/+98wZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD20iHxrex6Qn3AMKFw1EYu20fao49HMY4Z1mbe4Ynk=;
 b=QwnXe0C0BR7Vk13lOKKsYDkjMl/o44CESPMRVkk6cICZwinSSWYNdGNz9FTwg9qpivuzoaFk4BVKwSKGXO9e93xWP4xHdMLsZrGiH0jWh1aTo1YSiDnO8NzYxSBxkQi9ZxZAhfUHjwdJuSdLVMKrMpeYPJrre5kh60AnOL4CScA=
Received: from DB9PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:10:1da::7)
 by PR3PR02MB6396.eurprd02.prod.outlook.com (2603:10a6:102:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 08:41:39 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::4) by DB9PR05CA0002.outlook.office365.com
 (2603:10a6:10:1da::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Fri, 3 May 2024 08:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 3 May 2024 08:41:39 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 May
 2024 10:41:38 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] net: phy: bcm54811: Add LRE registers definitions
Date: Fri, 3 May 2024 10:37:18 +0200
Message-ID: <20240503083719.899312-3-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A01:EE_|PR3PR02MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: bf129f67-cd6a-440e-eab3-08dc6b4cd984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVl6NXV4R2trZ0xMT1NYbDV3RktwKzZ5YkU0RG1NQTZXdFNIT0srb3NhM0l0?=
 =?utf-8?B?V3pVQm4rMnllMTV5T2JzTXJHSlg5cFdBV2dLTTBNYWRHSm5iWUd6R2t1OHlS?=
 =?utf-8?B?T3dHaWVHWEQrMnRER2k1c2JmYnRMRnJsaTBtMnBWcWZhdWFUODlFRGdyeWpj?=
 =?utf-8?B?N3EzM0daTStvZzJLWjlPOG1GMzBrZSt1OW9YeE93NXRrQjJ5emtoK2dvZXV2?=
 =?utf-8?B?d2tZVXlETzI2RkpURzVzVjRCK1lMcnZNNjZUNVR5aU5TUEJLbkJnLytiSS9Z?=
 =?utf-8?B?NXFVa0JIenRtcTk0OGJNWnFseDFIQUgrTnZQcXRqZW1HSzBrTEVidXR1d1JE?=
 =?utf-8?B?MG95aUdtdmxpV04vR1RhSUNOTjZmaks2QkRMQzNuNmlES3J2YnpTcFhpZXZN?=
 =?utf-8?B?aEY2cjBMVHErTURDRWk2UmJvMUc3czRJT29mTFBBRWRnK2Q1Q2djMzRYV0pa?=
 =?utf-8?B?SitBblpXTlpKeWttSDRJV2NNYS9nR2xWMW1sWDF2aHlZS1hsU1duekkreWhR?=
 =?utf-8?B?bFZhcnl2YTJTNzFWZUllOUZaSFYrMnRzNms2WkdzZWFRcThicXZsRHVNRURE?=
 =?utf-8?B?cUZERSs2QUYwY3doRUNvVE5hdkZvbHFxUFUwZHlBSjJYcTlSc2JUUHhyUkFE?=
 =?utf-8?B?ajg3TFdZRXBiMVFxR3pOSHVmNjR0TFRVVlRRZ2lWUVFJbkd0TW1idGpLQmtD?=
 =?utf-8?B?WUhaNzZHTGpDWk9DbzJGS24zRVB3SzI2dUs2WEdvL2krSnpONHV0eUVVS1FJ?=
 =?utf-8?B?RjBnUk5DRG1DSzZENUFEVlBucTEybmpGUk9UMkVwOFpxYko5NC83c0trckxN?=
 =?utf-8?B?MkJFTUVvUEdoSmxlVjJUcXEvWm03dHp3Z2pDUXplUXVVaVcxdUpiUkMvNWFu?=
 =?utf-8?B?QXBoTXplRjI2TzRrWEU0S29GS2NLaVRCeGlIblFFTVYvcXFMUmhHa0J1U3Ba?=
 =?utf-8?B?ZnBuMC9GY3owd0lnOWNsSndQb3NSV0ZLWDh4VFkwR3puQWNZVWNJSlNzWVJt?=
 =?utf-8?B?NWNuWVUwbUV4NUY1OUhXbTQzSE1KYklJUVF1aWVYSVhVVmdMcFRNVklUR0F3?=
 =?utf-8?B?aWNsOEVCVjU3RFhBN2dScWhHa3dUdDRYVnZLN2ZnaHN0UFhKdDdHTGc2NHo2?=
 =?utf-8?B?SWNIbnovanl5UlAwcXF2VEZDbW5LdEphTzdRalFXNUVUVCtkK1IyV2pVMVdp?=
 =?utf-8?B?cUhiVUMyOGNYWHhZRHBkT0prdUZ5RXhpL1J4KytWOXFxa1ZndE93aWZaOWRT?=
 =?utf-8?B?OUcwM05oSSt5NGdobm5uZ01CTHJHUmVnMnIwWVdUaERHZDU3NUlUU1M5VUtt?=
 =?utf-8?B?aHpTUFJpdk5qb1BZbmJjdUhIZENJNWxvRm5KWjB3L2c4K0s0dUpTKys5eEJa?=
 =?utf-8?B?akNBRysvenRhK3ExM0VOOHZZTWUvdlRMa3dKZWMxbS9XK3hER2FMZGE2STRa?=
 =?utf-8?B?QXpWdGtUTUpkRlVBSGc3cTlyc0c3S1ZTRGh1WEQwbkZOdVY4ZlNCdjNqaW5s?=
 =?utf-8?B?Y2Y1dnltdWhUOG1vdFVUYkJZa3N6ekFTd2I0akdld0pvK2NaSnBMUXMwTHhE?=
 =?utf-8?B?dUZFcUJJVzl6dVhXZExFaFl6R1luZDZLY29VYkF5WjhCMkt1dVk1a3JONlds?=
 =?utf-8?B?djRGclo0Ujc3WHdXVElPcm9XUUpPNFdreFovRlp5dnZqejdibzYxeFQyaXF5?=
 =?utf-8?B?dTQzTFdIb2JtaDRUS2pjT2JaUlRkWCtMZXAvSXI0RlJDelVDU0M4dTVBbnE3?=
 =?utf-8?B?QVJENjhLcHlOY0NOVFZESTh2aGptWFRlL1lPbUM5NFhudnh2YVd0Slp0TEJo?=
 =?utf-8?B?MUNheEZPc2lLek5SM2QzV1UzbUxBbWhmTDEvVkh0Zkc2UzUrZXE3YlN4czBx?=
 =?utf-8?Q?Cvsb12TCeI2Zj?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 08:41:39.0039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf129f67-cd6a-440e-eab3-08dc6b4cd984
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6396

Add the definitions of LRE registers for Broadcom BCM5481x PHY
Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 include/linux/brcmphy.h | 91 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

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
-- 
2.39.2


