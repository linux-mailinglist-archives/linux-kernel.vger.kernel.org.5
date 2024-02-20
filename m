Return-Path: <linux-kernel+bounces-73765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D87D85CACC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA6B1F22DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DD4153BF7;
	Tue, 20 Feb 2024 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Es5+31rE"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12411534E7;
	Tue, 20 Feb 2024 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468506; cv=fail; b=kUbqZnriB3JIsv/U5VXr7t4zv9OYdYSNhw1ACFBVyWcrZPYPl0m84ynrGU4cFDjxsyjMvgBpuxqq1fXGJoAXtF/7gLegLDnyWrSb1b6pQRyEhbgG6q0X7/S2WHlVd4VQMvHQkHcuX8ebqCOeGuIIXSMZV7F/9nuzLiu3659Yweo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468506; c=relaxed/simple;
	bh=WSjGKKesTCNMcgLRFNJGPk9HaOEFu9iL23y7olPDQYA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ok+3yiq2S1qfr+llnQSz8QhIVqBo1PriTdHruG7mIYXG2tzhfD6LgYyWgjuJLNWVf7uaS2EzrB3WlW4/Ag8/5tjHQwNFpw3ogRsQNgeiydmHsq0GmIaYetr8Y5LGAP8EKgVngoSJ1vugzJpx7OVzGfV85vaLZe99MXNJ+xysJNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Es5+31rE; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxuzhXW2sjOlYzpYAsfzKLbw9JIX3C3uY432Eh+QRvsrw/3yuAQEz+dRn1vQzupk3T87LKvkD/36iZhvZmiYTFR2gx5b6aHfB8dTz165TV+cuu/xJOgV0Gn928OrqUdgevn89H2F8NINkCajMeiLNiy6alS1VllO6QEQs32bDRY+Oam286BQ8AccvElTfbbyGc2IUyul4d7VEP0aMLYguAtoHWqO3GCNXoCmJy10Ba4Ivtn7Qa/PxE0pZpyg/345jZz1ed4zIEFXUfTFVxAZXd00eOIJTXHw/zosvYifMnEXZat9CWNimTnMfElMbQRiuHGCD5lMAUeot7Bp6O7IoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuFgSzzXAd3OK8EquNLrIty5irQ06KSk0BB0FHY4Eic=;
 b=DtjqE9l2doqqhdz0v/uIcfMfp11Y1qELhuFLUYbnr9PP31PZElHe48SMcDHtuet3jVoFBmQRTPvMowIWTbTR6yTI5CCSbJxGFmaeMKmjgD+48GebyeKVYrmEawJOCKmA8AgdofPfM/szXb7tp9NGfxTgBoQ4Qw35rfI8VLVSAyx+3eVVvJCUJnPVv1V7HmiyQlE8MMmiBlMio5XQciU1W1fMI85u8kBRYMKwXmDv60tD8a9hl4nt00j/fRIkjFI4TlBrPbLBSRbM0MKRSWsr8j6GJEABokZMZ9r7W+EgcEq1y5eHgbcTwTJ/0Ag+wUGKMxxSPbA7t2LV3T8PB4A2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuFgSzzXAd3OK8EquNLrIty5irQ06KSk0BB0FHY4Eic=;
 b=Es5+31rELB9wOrHmqHbg9XwExMH7WdL5Cvz4gde3a0Wbn//IeXRZu3VZcf1P38Y0ESsSqVaGxAx49AfDw35OPDTC5MSRCM8EBSJN7kxhIMnZG2IEhuoydDI9GPWQRPdsR8xf1UgxN+AedbHiJRJvzRIV46cHiZkfgjsq1qCUaro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PA4PR04MB9639.eurprd04.prod.outlook.com (2603:10a6:102:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 22:35:00 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%7]) with mapi id 15.20.7292.029; Tue, 20 Feb 2024
 22:34:59 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Russell King <linux@armlinux.org.uk>,
	Zachary Goldstein <zachary.goldstein@concurrent-rt.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dpaa: fman_memac: accept phy-interface-type = "10gbase-r" in the device tree
Date: Wed, 21 Feb 2024 00:34:42 +0200
Message-Id: <20240220223442.1275946-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0073.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::26) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PA4PR04MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b6c959-d9e4-49d0-f16b-08dc32642bff
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 JMwsdiQE1TBaCd2jOLW+r7a10y+HcIho0XFaLzGf//e8apxfO7FhgWXOPAIKhHTz9YToIkw8LK0HXaI0OIWsubfcK4iQ6rv1ENtYpOP9aaYVU1cOZN9FX5cW+B57OPBHxqKBDl1igi+MUG9XfkzM2g8XRfuRicelz/oOHNQgDxlMvTeybLuuo1Eb9CyjA9PkT5P1TFzW2oQjaEby4SrW64lgUMK+QDXYsuOOAFXIV0FDcGG5wJmeGJPu+DYRgW6JjRONBY8pglAT/fX7wm+Xex9gK/3EXwk+9gdKndoYPsy1wHtjFhuJBimDVWX8vlIebH6qK7Dosk+o1/ySV2ZFL2HOOFedEU96R8ItyOvQb9k/VB131bA4U5uMF4X6xiY8nR8X9CIdoLdskHmNDhclOuPatrRmIh0FwKXSv33R1O8VPDF60d6NQMVZclh1sm2xei/a/pP/k7zzMKvchGDy+pQG/85Aim/rgSy+Q+Sm7ol7gTKhX2TRdF383459m8A+QHjY6FRchAiExWcwPVRtcHK+JFYs1bbTP0Iu4Zil/kI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?hRXMBTrsE1YVPiaFj/+TSQXL4UW80vfZC02ZgMVbUFn2ma1ZClXyMPwODDlp?=
 =?us-ascii?Q?KRo2zZ9VXuO64FEkirPYlm5Wt5BOUEmYkAN1WV1qYG2ElVsA5/gsweXaKq2Q?=
 =?us-ascii?Q?2uKCEwWAdTtZPL7DUROSc44WdDFOpJFUzvRPxWCuQoankn9ra22n4M1DYkP7?=
 =?us-ascii?Q?Txqv9hHVDZgN7Llp0n4/9mpHFxEo8fQqtMXYke/KuFQ5kMJrfXUQpiHYhFJY?=
 =?us-ascii?Q?fK4pB+hDd3O9e5NCLFS0wviWJSiOxv4e+aj/DmZjLSUFspOtgQ+W/Nx1oY3i?=
 =?us-ascii?Q?M9iH/wODkNjQPily7zfolgA7p8ngS6VWt7FX6x28ucUeLgjRJQ5jy3oWWoLa?=
 =?us-ascii?Q?k6Xyz2Ne/GwilSUqj6UzkpBPfwv2BKgklnXw21KOtkr8LxnYnM3FD2eZCTdN?=
 =?us-ascii?Q?twd+JzbknrBIJ39+fQ/7mCFTag5H9MfxOpK3AMHS8bbivItmgfjKLJT3A9Rq?=
 =?us-ascii?Q?k6dlfX8x4VijzXPqNkbV7DNR0g1h1eNgWy3cRdomHeLsso2dlLMjsFh0pJow?=
 =?us-ascii?Q?BMaOKKDY8sfiWse9Tn90J09V+XFvNynj+BYDuH0pSpDF8h1VQwA+K2t/MqAF?=
 =?us-ascii?Q?hff9ufZ3zHQDAujSr4n8T5DYmAUJl6M79BpTQ1j5YxBwX+Dp1Z4b418cho44?=
 =?us-ascii?Q?C1fSoDq4F4tPnDNHMnOS9yaI5s/NwRtVTHUQaAaIExfOiOTKNOmVSDSQnRTW?=
 =?us-ascii?Q?P8yM27LZKzQp/oPKqxBavm2TzT9MCvW2uB9hHaGI9e1Aks7uaA6c/ov75l7a?=
 =?us-ascii?Q?08g1eH5OzcrR0jeMSDf5pLMpmiAaYXVLRNTz9twEf4NYyVtysoRyHNXhYZ3w?=
 =?us-ascii?Q?/Nuym7auJ1rU//eL3ogG2XF+4UHgKcAb9rddIpesliW2KN131xnHqGlw9RTs?=
 =?us-ascii?Q?Kd+ZfOybPHRO60Z/mp/Ur6AecSAy6kXfalu0Dk6aqgYI/R4wQIahI3mUjNjk?=
 =?us-ascii?Q?uSv/cBqzza17HAnVBOINv+ChUGxSnrTgdV4H6/p+FOAtTcgBDkYX/mVkH9C4?=
 =?us-ascii?Q?V+SjhGykEyLMCUfUKSqtEn+V2X1LgwO0/V6v1tMmFRWtsSSm2fCjcIIQS0Z7?=
 =?us-ascii?Q?WgbfpxM8egGpt+Q2YFWwdd83yOeaGLKmkr43wNACSG9MSmmIMO5EOOsq7Pix?=
 =?us-ascii?Q?y4nl1b/UW6Ri/znIyOC4wFYweWR8hn3RyX+cd3A/Zkr5x2Rkkj7F5wK+6ZI5?=
 =?us-ascii?Q?nbMbqvuzzYn5Bitwla/lWxd4A6ktpb/PeJ4BhAbmej1ftCioj/RVlCzden1m?=
 =?us-ascii?Q?wIbyc61NgcSlkc/nNbwcAPB01xsjMuGznLrWmGDFDBG77nXI4wdDIBqclBtO?=
 =?us-ascii?Q?OfA/ynkRfHjfGTw9GxKZ/VhFKblL/QQce8VXpfG53SP6VZDG40qJ5dzFzoy4?=
 =?us-ascii?Q?KcTy8hzhEWpGdYa3CRRpinej7xsbbBdRizGmIEvr0te6UYgwzpshi0YAEaON?=
 =?us-ascii?Q?2jpE63Ht9Y6w8pGb0W688QBcFMEEcedgq2RF3VjGZ6nbcKTL4qXgoAi7Rj9h?=
 =?us-ascii?Q?DmMA+plBRvOik5Fyv4kFeJs45pCflsc6di3ZT1ha2tYCqR8CvPyS/p+7YMCL?=
 =?us-ascii?Q?pDeL/sFU1USf3QPFABiN6t6V5jTjO2w/xq+7RS/wFsLhg5iTrQCH4IKA74Tv?=
 =?us-ascii?Q?BlPNJLD6fBez6Ws+umghfdQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b6c959-d9e4-49d0-f16b-08dc32642bff
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:34:59.7647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ly/ExEXVRBtcAEkeD3zeRpvnRMSsY3b4Z1gRUrAjvJat5HI3Lj1pCNVuRjpdmlgV0kYRawCj0Rq2unBdNucLNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9639

Since commit 5d93cfcf7360 ("net: dpaa: Convert to phylink"), we support
the "10gbase-r" phy-mode through a driver-based conversion of "xgmii",
but we still don't actually support it when the device tree specifies
"10gbase-r" proper.

This is because boards such as LS1046A-RDB do not define pcs-handle-names
(for whatever reason) in the ethernet@f0000 device tree node, and the
code enters through this code path:

	err = of_property_match_string(mac_node, "pcs-handle-names", "xfi");
	// code takes neither branch and falls through
	if (err >= 0) {
		(...)
	} else if (err != -EINVAL && err != -ENODATA) {
		goto _return_fm_mac_free;
	}

	(...)

	/* For compatibility, if pcs-handle-names is missing, we assume this
	 * phy is the first one in pcsphy-handle
	 */
	err = of_property_match_string(mac_node, "pcs-handle-names", "sgmii");
	if (err == -EINVAL || err == -ENODATA)
		pcs = memac_pcs_create(mac_node, 0); // code takes this branch
	else if (err < 0)
		goto _return_fm_mac_free;
	else
		pcs = memac_pcs_create(mac_node, err);

	// A default PCS is created and saved in "pcs"

	// This determination fails and mistakenly saves the default PCS
	// memac->sgmii_pcs instead of memac->xfi_pcs, because at this
	// stage, mac_dev->phy_if == PHY_INTERFACE_MODE_10GBASER.
	if (err && mac_dev->phy_if == PHY_INTERFACE_MODE_XGMII)
		memac->xfi_pcs = pcs;
	else
		memac->sgmii_pcs = pcs;

In other words, in the absence of pcs-handle-names, the default
xfi_pcs assignment logic only works when in the device tree we have
PHY_INTERFACE_MODE_XGMII.

By reversing the order between the fallback xfi_pcs assignment and the
"xgmii" overwrite with "10gbase-r", we are able to support both values
in the device tree, with identical behavior.

Currently, it is impossible to make the s/xgmii/10gbase-r/ device tree
conversion, because it would break forward compatibility (new device
tree with old kernel). The only way to modify existing device trees to
phy-interface-mode = "10gbase-r" is to fix stable kernels to accept this
value and handle it properly.

One reason why the conversion is desirable is because with pre-phylink
kernels, the Aquantia PHY driver used to warn about the improper use
of PHY_INTERFACE_MODE_XGMII [1]. It is best to have a single (latest)
device tree that works with all supported stable kernel versions.

Note that the blamed commit does not constitute a regression per se.
Older stable kernels like 6.1 still do not work with "10gbase-r", but
for a different reason. That is a battle for another time.

[1] https://lore.kernel.org/netdev/20240214-ls1046-dts-use-10gbase-r-v1-1-8c2d68547393@concurrent-rt.com/

Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/ethernet/freescale/fman/fman_memac.c   | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index e30bf75b1d48..0996759907a8 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -1076,6 +1076,14 @@ int memac_initialization(struct mac_device *mac_dev,
 	unsigned long		 capabilities;
 	unsigned long		*supported;
 
+	/* The internal connection to the serdes is XGMII, but this isn't
+	 * really correct for the phy mode (which is the external connection).
+	 * However, this is how all older device trees say that they want
+	 * 10GBASE-R (aka XFI), so just convert it for them.
+	 */
+	if (mac_dev->phy_if == PHY_INTERFACE_MODE_XGMII)
+		mac_dev->phy_if = PHY_INTERFACE_MODE_10GBASER;
+
 	mac_dev->phylink_ops		= &memac_mac_ops;
 	mac_dev->set_promisc		= memac_set_promiscuous;
 	mac_dev->change_addr		= memac_modify_mac_address;
@@ -1142,7 +1150,7 @@ int memac_initialization(struct mac_device *mac_dev,
 	 * (and therefore that xfi_pcs cannot be set). If we are defaulting to
 	 * XGMII, assume this is for XFI. Otherwise, assume it is for SGMII.
 	 */
-	if (err && mac_dev->phy_if == PHY_INTERFACE_MODE_XGMII)
+	if (err && mac_dev->phy_if == PHY_INTERFACE_MODE_10GBASER)
 		memac->xfi_pcs = pcs;
 	else
 		memac->sgmii_pcs = pcs;
@@ -1156,14 +1164,6 @@ int memac_initialization(struct mac_device *mac_dev,
 		goto _return_fm_mac_free;
 	}
 
-	/* The internal connection to the serdes is XGMII, but this isn't
-	 * really correct for the phy mode (which is the external connection).
-	 * However, this is how all older device trees say that they want
-	 * 10GBASE-R (aka XFI), so just convert it for them.
-	 */
-	if (mac_dev->phy_if == PHY_INTERFACE_MODE_XGMII)
-		mac_dev->phy_if = PHY_INTERFACE_MODE_10GBASER;
-
 	/* TODO: The following interface modes are supported by (some) hardware
 	 * but not by this driver:
 	 * - 1000BASE-KX
-- 
2.34.1


