Return-Path: <linux-kernel+bounces-147249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8068A7187
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D512A285151
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA72D3CF7E;
	Tue, 16 Apr 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oOz2lzFE"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337A1350DD;
	Tue, 16 Apr 2024 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285205; cv=fail; b=p1NNc1DPMh+zKzLFEixYzP9mulBC+x1+y/A7TzVxDVhsPJGx0mghNC7EMux6iyXDjZEVw7nBONk0dNSdQDb0cbC91j56fmKi/bYwlZYK/hfN9rkP+nNY8CXY9t3myD+j61s7EnekWNv5LOogmhObRHy/T14jQkKIH49n5VxUT1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285205; c=relaxed/simple;
	bh=scfANl0eIs9ZV6ogRCXoqDBvoJ/RtmwYwBTjgcjUIeQ=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tt2OhjZesu1CPH/gJqMPHx6nnUHVlK9TCDLDzLy8wD69llDlbpvwRVWH4PCK2y5JA1xJB7bgOyZReN4s4jMKux2J2zUx7Zq7A2J4KU+hAt/Fk5rKG7eMnmmGErxVGiRRiy421hed9cEMbzEOJ6YVjgVZcxLjMXBffljmVBtUH9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oOz2lzFE; arc=fail smtp.client-ip=40.107.6.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeXJqLYHPnVLlYCUWqonMb9H87fcAyTlEOf60UI1jSpmBs873vWumIaEsKcIxyAJKiZyRErN4PU4Iv7balGtxMNe063WXLmy/AhsqoPgmTC7UmhHdhrjK25JMLCVM1luZ42xOE+ltl20FjPrcV7Hbmv/iwDhV3ca25J6SFX9XN5PWl6ulazpbLU9khzUWLTDa3pSaXaGyhAu5tJfu57mk1qFvT3yh28/ZM10La+ooBMSZz8WebQN5UGwJbtUtDneI2gw443PF8otLSxn+rHzpxTY9TX5fJjqgrRtWhKYPmlIkms8OwFDDPc8uH8s5EohDTX9Ct7GGZoNy31tKbBB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dlsJPLySsb2IqDacO2nSFzYCiALi4HoNdh6SDyyQb8=;
 b=McWCQNciN1iWq1PzIharJ8ZhsyY4LZjy9llU9E+DWPvh3ghmVOQ1crlwY/2naztZYYlZO8ezzao+Krls3Hjm3+gGa01i8vQcHJ4KE8Dc8wFvV7R5JfFX0njJMdZ8uKoYwLEQCtneph7YIqtZ0tXBS1AsrWJkY75L8urAiJswvlk3xNqUBE7HJ6zX7rILem5VwYyQWoJmFBi6Q2+PmhAGA6Cqw6UtXtRK0GeiMakIxWJwcwQMlmobyuRkC2OLcpB1hBK0FNaH8uERIYpifTQOLJ97PnE/ryhyfA5Bk7N86CHkFQb0+UG8cKd4k0zCi2Oz/6G3+k6n6TEgJ2rhpt4UpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dlsJPLySsb2IqDacO2nSFzYCiALi4HoNdh6SDyyQb8=;
 b=oOz2lzFE/WWn8fjMBi9cc/xYPibS0InM47M4EVhLmLbX7BrwF85n4DEQfQlgzg3FAwBy+rnbRUGi+88l+uzafju9F5S5i4cQz+RCvICUxhe9R+f5fgKhSDz7splmqVQNsYNHAOQxMouxxxtlV64Wr+4LP6MUV6Rv4tKbbkiaLrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7428.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 16 Apr
 2024 16:33:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 16:33:20 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/1] arm64: dts: imx8qxp-mek: add cm40_i2c, wm8960 and sai[0,1,4,5]
Date: Tue, 16 Apr 2024 12:32:56 -0400
Message-Id: <20240416163256.2121923-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: de25774b-e324-4fad-daef-08dc5e32ed51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uuTobTgoCY9A701L7mtg0lbbrPBAewOsA8OzoQ3kpYqj85rQ9fWSCCX/4/8H?=
 =?us-ascii?Q?94W+hl5KGBXrIs6vuy1t0JkqspprwgsrHL7/CXEe3YTpAjBY8SzGWz1JvOzM?=
 =?us-ascii?Q?v8moVP0/S2ff1Keh7mGzGFkK/JVPldJDEjzZWes+BA/cq3r2MM+B70oS1Ni1?=
 =?us-ascii?Q?mzZKIEY6ZTSMB0GpjU89GbZb0lkuCr3jUE808mW4sk/MQGT1SzfOEAgZ+X/b?=
 =?us-ascii?Q?g2us2EYWlAayD8oOEd2+D5SVf+nuv2V6RW2aijM/jFHcKmUvGoPTQmGKA+Fw?=
 =?us-ascii?Q?U3q0MyxOum1cXYdr3uTF9r7mpIpPlmPyn/gEG65vJcXIA00ARFRp1ic94DUw?=
 =?us-ascii?Q?eQVGGzDjU3IpGREmQEHjeAPZc7ZW2rHxKtFzXJzyiVtB/Y8K65B8T35SsHoH?=
 =?us-ascii?Q?su+qJR8fw7J0Uot9/jGSD880yNdj8j58jwjj5pLm2J75S1dQgyB8pGaf2tvc?=
 =?us-ascii?Q?8k7xU9yAQggIuGP45qpMxT3Tglmk7GNoVTlsZn5tNbVsGVMZEQdD2ohnsEPg?=
 =?us-ascii?Q?iWh7OvTkJVShy0XIeG0hina78nxVQHU/yMs1GAdxgdaEst26L5EyW25ybBuD?=
 =?us-ascii?Q?d9xTfheg64mbRiZx3ZYK9TrFXFPbyoFOxs2XOR+hgXlS2shxLOA1se8BgejO?=
 =?us-ascii?Q?6rh/ltv1gv2U0VLD04dLpwSzl967ZX3qoSP/DlJBVsX4gLo2QpDyu9Aa7dhl?=
 =?us-ascii?Q?Y9YZLYpVU4CGAt2w85PQaHtGfTZTk2Cbh+HTBzTmVitAadJ0JpGFsUrhgt7Y?=
 =?us-ascii?Q?nsG8m+6uKpZvlS/mM9oxC5udjxeSxWy1wFhvrnV656Z/qex8/aIRcByA79Qg?=
 =?us-ascii?Q?5I/PB1nhHepz5wDbO0Sdgd6WFJYX1ABjXk/zdfDhU5ZVtQOJWj5/tvXaSDvD?=
 =?us-ascii?Q?7teEZ6xRR/7lZtj7Os5wucmyIalZ8mUGNvvu70ovL23Udd68N0gZW/DzvSYB?=
 =?us-ascii?Q?z9sN2ICE/fLgF4Qe/LFUcf020PeTZPpVtWiRlBWHoWT2sqiQ2dktl/ftCkS9?=
 =?us-ascii?Q?nezFBvQ+/wZkq0qBkyuDVXL7+lQdMZyPNDRCtOofgqANrAPcpA21QcbSm4OF?=
 =?us-ascii?Q?rnOYvFf0s6Cb4vNLdI7yAW7jYqNcfWHbMHAUO9oFisBtLOEkGLkMECXrJVEH?=
 =?us-ascii?Q?Pt7XoCACjsSTb5APU232EppMOsj/JYL56nvm+mPEY5HwsuZXzv+YR6m4/CT1?=
 =?us-ascii?Q?cS8BN5auwo4tLYgLdLi0Ca+sf3f4XEskH3XHg90bQ6GN/JPbFAgyFs4i2Kiu?=
 =?us-ascii?Q?OVykAcHjLP4FzVQoOVgBf+dcPmsDgHud9VW5ocqXcG8B7QsDdXnrsp/i+k/Y?=
 =?us-ascii?Q?b7CO48iVxT8Sb26938OqEOYNgPUCwBl43bC5ZrZD2q3/G8rAUU33ERL3tuIR?=
 =?us-ascii?Q?LA5/Rh4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ecKSRH9xG/DxXs/yybycoCLCNdeJwk2bCO+NI/onqU46A/teB0zCLCBmJpf9?=
 =?us-ascii?Q?OCmjNMyw41Zch0xkx3ot7wgn6WjLZlQBf2mlU+1PR9CfX3fLZDv8mUvCje1h?=
 =?us-ascii?Q?Vuj+HxP92VbFTjlqgAMY++3MJNOg1FeB8UbaBrtragNoCb+BvHV6aCYr6hYN?=
 =?us-ascii?Q?blrz+aYtvrLtVCuKsjwepTV2uFiTtTCQgSrcGRnW4o8xhakZnByCbgUDkMhw?=
 =?us-ascii?Q?wreQkfmxJKjks2v3juN2tp6d75g7+2/ViZjv/bZMiDlYqQYeEG0be/IBLH5I?=
 =?us-ascii?Q?1IiOZqxi3mL3QLlUT8LoAxCOjwwrweUDhAZFqqCOlh0RZ1nBBK3m3WmHgt30?=
 =?us-ascii?Q?z32BKeSh7OIIfCYc078mymSb49fZUxjCAasf73wQ9k/PwMhOLwmW3e5ei9Yz?=
 =?us-ascii?Q?3i5wiTdsAafHZ1Eb6HgjyW2Sa38tgc/MyZBjQ47Hh2XMpKROBVJ/ibWjbUFZ?=
 =?us-ascii?Q?pSdUqlpE/DIvVd5DNdKk3srvMD8/ID5VzJU3r+Dt/DPw0P49ZU20iS3JXgSk?=
 =?us-ascii?Q?LdIbu4PWytAreGZk/ecjw6Bn9mwzcqkGs9bpyn4qZ4XAX2IjPigKypkyxIF0?=
 =?us-ascii?Q?w6zAVPFaMLvD4WYyy02pLXdpf/LQCIXCUFQbny0/Wpou8yRyO4T0GabdBIO7?=
 =?us-ascii?Q?Llr9ne/QRCCffvYJjqUc2/CE09H8phNRVXeSKKFlyz4MYTF2TypXNfd9C+U0?=
 =?us-ascii?Q?JKz6cDCIfW8LT8ZH1KqyyBdh/IHVXfFXepaSnnOggCYSuVzaX9ik3WzRM+Qb?=
 =?us-ascii?Q?5NHES1P7rV0miBYFSkrZWX/aMB8JCHEU/LBKNO4A4tP2I0sWMXYYnbI6Hmyx?=
 =?us-ascii?Q?DnDh6nWHdEUv/L9lABlCs96nIhxhUiw31NRsIbLGkDOJxO4GG1W4dYgtQa8c?=
 =?us-ascii?Q?4Z0q0j+Aa/U+6T7HzLOOuDx2f/MfD5qBLwTmEnhrK3Ez9uPKDBRI4V8D+0XW?=
 =?us-ascii?Q?Oq5BPd5DkuFrvdLGDvfenoHQviiZQkwvHcn82osmP8TQ7qS7MvmnZH6TLLSX?=
 =?us-ascii?Q?L2JZ+GtmAbOYOuDKZaA3Bzk80i0zG61qSoC3EgMVRaEZm6oIu/0/75FumMXP?=
 =?us-ascii?Q?Git0l+VjjrF9DYtS4OmGHVYJaMlQiPteI5ra01gEWn+LPmaq7W1E9Sfmes1S?=
 =?us-ascii?Q?X1oAI0cnIg7ur62GnpyfEam3wL0w0eoWMP80Ym2CHwy4458JW2M7cLpqvRsd?=
 =?us-ascii?Q?0pMPgngR0jysV4PlIZRtExh3vbIECsJXLPWpLioa/AI7R8wTbUE0uC7S8IiN?=
 =?us-ascii?Q?MX/+aNwXNFdlQl2shKK2hgytj8TvQX1rqIyNEo5C9J4HFqh7V5kqTnkywKlo?=
 =?us-ascii?Q?UsD1hCPOMz92APeuTBOJkt0i+fuYAnzegTofdX3uHgSjlnCl+mpvm9Q5KV9G?=
 =?us-ascii?Q?tMrfiH7TN96gQgBZRmlwR2tXzwacqpzfdhUKm+voTRgXQQh8em3loeKBZw00?=
 =?us-ascii?Q?AeScJhsqFA6jFy8odiuezwkQPHj8JoCcmKPJGTwzFkDAGQU5DTqC7R6wpXnQ?=
 =?us-ascii?Q?Cq4MVNdJHALN0mUWADMT+P90oYJJLsMP0QhSbyU2yPNHaOStwYCQ8jFgMOHh?=
 =?us-ascii?Q?PFXETvkXNa0y9TO255cFSCajdOcfa3e6d4+MsPXJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de25774b-e324-4fad-daef-08dc5e32ed51
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 16:33:20.4408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpAganJa1d4bdYc9zon+7kXkfU0S0N89Bb0PfwVfJepv4LtViMg8Kl812IsHGngVVkKeEQyVviYzY/NlI9Xy1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7428

Add cm40_i2c, wm8960 and sai[0,1,4,5] for imx8qxp-mek (SCH-38813).

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    Remove dummy i2c bus to support both wm8960 and wm8962 boards.
    Only support old wm8960 boards in this patch, which most popluar in market.

 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 8360bb851ac03..36a7d16f658f8 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -44,6 +44,23 @@ usb3_data_ss: endpoint {
 			};
 		};
 	};
+
+	sound-wm8960 {
+		compatible = "fsl,imx-audio-wm8960";
+		model = "wm8960-audio";
+		audio-cpu = <&sai1>;
+		audio-codec = <&wm8960>;
+		hp-det-gpio = <&lsio_gpio1 0 GPIO_ACTIVE_HIGH>;
+		audio-routing =
+			"Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"LINPUT1", "Mic Jack",
+			"Mic Jack", "MICB";
+	};
 };
 
 &dsp {
@@ -188,6 +205,47 @@ typec_con_ss: endpoint {
 
 };
 
+&cm40_i2c {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_cm40_i2c>;
+	pinctrl-1 = <&pinctrl_cm40_i2c_gpio>;
+	scl-gpios = <&lsio_gpio1 10 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&lsio_gpio1 9 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	wm8960: wm8960@1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+		clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "mclk";
+		wlf,shared-lrclk;
+		wlf,hp-cfg = <2 2 3>;
+		wlf,gpio-cfg = <1 3>;
+		assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+				  <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <786432000>,
+				       <49152000>,
+				       <12288000>,
+				       <12288000>;
+	};
+
+	pca6416: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&cm40_intmux {
+	status = "okay";
+};
+
 &lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
@@ -218,6 +276,53 @@ &scu_key {
 	status = "okay";
 };
 
+&sai0 {
+	#sound-dai-cells = <0>;
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai0_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai0>;
+	status = "okay";
+};
+
+&sai1 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	status = "okay";
+};
+
+&sai4 {
+	assigned-clocks = <&acm IMX_ADMA_ACM_SAI4_MCLK_SEL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai4_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-parents = <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <0>, <786432000>, <98304000>, <12288000>, <98304000>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
+&sai5 {
+	assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai5_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-parents = <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <0>, <786432000>, <98304000>, <12288000>, <98304000>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
 &thermal_zones {
 	pmic-thermal {
 		polling-delay-passive = <250>;
@@ -314,6 +419,21 @@ &vpu_core1 {
 };
 
 &iomuxc {
+
+	pinctrl_cm40_i2c: cm40i2cgrp {
+		fsl,pins = <
+			IMX8QXP_ADC_IN1_M40_I2C0_SDA                            0x0600004c
+			IMX8QXP_ADC_IN0_M40_I2C0_SCL                            0x0600004c
+		>;
+	};
+
+	pinctrl_cm40_i2c_gpio: cm40i2cgpio-grp {
+		fsl,pins = <
+			IMX8QXP_ADC_IN1_LSIO_GPIO1_IO09				0xc600004c
+			IMX8QXP_ADC_IN0_LSIO_GPIO1_IO10				0xc600004c
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8QXP_ENET0_MDC_CONN_ENET0_MDC			0x06000020
@@ -385,6 +505,25 @@ IMX8QXP_ENET0_REFCLK_125M_25M_LSIO_GPIO5_IO09           0x60
 		>;
 	};
 
+	pinctrl_sai0: sai0grp {
+		fsl,pins = <
+			IMX8QXP_SAI0_TXD_ADMA_SAI0_TXD		0x06000060
+			IMX8QXP_SAI0_RXD_ADMA_SAI0_RXD		0x06000040
+			IMX8QXP_SAI0_TXC_ADMA_SAI0_TXC		0x06000040
+			IMX8QXP_SAI0_TXFS_ADMA_SAI0_TXFS	0x06000040
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			IMX8QXP_SAI1_RXD_ADMA_SAI1_RXD     0x06000040
+			IMX8QXP_SAI1_RXC_ADMA_SAI1_TXC     0x06000040
+			IMX8QXP_SAI1_RXFS_ADMA_SAI1_TXFS   0x06000040
+			IMX8QXP_SPI0_CS1_ADMA_SAI1_TXD     0x06000060
+			IMX8QXP_SPI2_CS0_LSIO_GPIO1_IO00   0x06000040
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK			0x06000041
-- 
2.34.1


