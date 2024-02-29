Return-Path: <linux-kernel+bounces-87400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E468D86D3F0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E961C21513
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB0713F43E;
	Thu, 29 Feb 2024 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P0X0HPFi"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E360A2E410;
	Thu, 29 Feb 2024 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237371; cv=fail; b=O8G51SncXoXlqM0XRxGP8tTf1FDnP1j1AESFSBdJEk49K5yAWbVqRY+O77lCCwDN0lkF1JLCmtm1lGeOWg/weTAAfhbjcC6ExmeepS/obRbzlv5kiXZ4xzfjWZnnECSNpSu/ziSKKL0sU92yzOMV1O3tBk/ayJeQIb0Jj0NB334=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237371; c=relaxed/simple;
	bh=ptvQIDCwfCuBugvM9Uqqc/Qp24kQOKB0NTUwx3FeLlE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OGm641ZmcsPiBzNjHVfhNysfWwpcytkLnH4m9co5XmJjH3WMTi24G8QC8S9V9DjswsNQxQBEkAXPsHBPfFxAUnrNQFYF9ZXszShyhNQyvlnpOpgwBwFhCnM57hvDmC5+HJbSW2leqsqFSthrA939ed6fRBha0NVOtkXV5yBsf3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=P0X0HPFi; arc=fail smtp.client-ip=40.107.6.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgovRmBeaiI8lOMB0H2nNjn+ck+ND6XXMMQkp5OdCyoQqqJysEinAL/LEoqTIUkfXfr+AHuuucCefqXKFn+rOhGIxD3EwbNRH6QtCgjwL8Xp+Vc4ZX5FHytjwdz8ScgqZ7GsFRJEjgMyHApxTUrAfagYDqzLDxy2o0FAGd9dEAwVYg0kfS73qX4C4A0xfJiOONDzVgLhJMvyPs08vyf+gTF7OEx9umoARgd6pqUKcjJ7pVZVuW3Hfr3FJstjaExfjqfIBiDcyDNakLcNSilXTRHQC/xpTeowh0hnRyXpib0BPls61/gz7UQL7+0MrV85R2P4SgQCMXsTE6tXGyU0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3VEN3KOKO49APxTli3iWf57QYEETCTe1ufDXP6p5ag=;
 b=SlyM3lU+Z/j9VBmeCA1JCEkeAgsVtIdy9u05quIXYn9DEyzvapI0B5hSpdDD3xjaIMVHplq9Rm2Cra18aowXcjl8FAhjRxOF0xodIIMOxhS+uDmSUz8kKycEYD4DY/iTkKmUHUJj/0mhGFmK5ccu7PXt2M3WLsmNL6o1mDUo5PjDv50G+t7VlAVfM31S2/ZUf6xDhw6KAE0PZjJ9nx3X+AjUP0Cpj/xgS5Twz4aK+qvc1Dg+f8mVysC8Wd8lYamw+3wXxPY/i5iwtZvzsCsdngqoLfMLSK3Ue+07fRJ8OIPd9kB9/ekHRt9/t3q4VUf4NzuS0Kj8GZcFO8qmVsKKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3VEN3KOKO49APxTli3iWf57QYEETCTe1ufDXP6p5ag=;
 b=P0X0HPFiDWPIkbKf9R7sqvXYYXIJdMvfQ6FB8kF4VF1QA1LNUuBOcIaNrEYurQn8dixbOc+Ne9GvXDsD/NscVVIdZGeFGPJ7UmSiZQsz8bsPLQPoNKTTVAIcidCbYMliRgRz3/kgCoqPHPClSHEYvbYSQWdzuIb/MdKgtDcmQ+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8523.eurprd04.prod.outlook.com (2603:10a6:20b:432::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 20:09:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 20:09:26 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Linux Team <linux-imx@nxp.com>,
	linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: interrupt-controller: fsl,intmux: Include power-domains support
Date: Thu, 29 Feb 2024 15:09:11 -0500
Message-Id: <20240229200911.712572-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 59edeec5-ea67-43b5-6ed3-08dc3962545e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pvV8x5UFjXXMXnU47aeNToRgkNjaq43TwEwaSVXH+UkS6PttfXA9Tc1mkX6ywvCURkpnZw4KYfqsCClWXdop9DD3pR5wofePnDzoviEIcyI3BK40zUqjJK5rOzju/07ktYDxN0bHJZplUFAGBHoeJGxoZlqb5NV7FTSMejNfA8NQJrsOcq9CIKBwGa53SMp/gE9T6bUZHSrqM8gsni3iZaMawF9UwvXoisKz5gVB5f+LjzFHszXJY8DMy4qU4t693F6laOKZCPaYMPvOgCJxk0qd9lI4SirhdRmuwzi6tycNZyusS2q6liXWlMTSImxu/tnpkaupwUWW8UsD5pUv5ipV4ArNI82BgGY065+xhkZzDPC4fiS8lIPU7Cbm5Y8hNeQFykFyh+Awok7ctFw8xq25qzVx9z5onYOlCqSQalBy5utV1WNIx5AXmqxIA+4dDxJwZWEENIgWdodYnAEkXFkLjWHK4sD/tZKpUSj5Ej7SfsYxG+HmgDwnImMDWUML04Xm9+hQbiiJ0E6DZk2KKVDc6z4Om4ywG9LkDNl4CPzG6w6ef7cPx64Nls8+QzViWOOsAQHjH9PiIvwMt2FSm6GiTYKK60DBYxqPAvoycirDyphtdORf7xrNhfzC+ruDuiODS1+FV3BEl6ex3el6awEb3P2PeoOrA2kWAyMIwS2t9M5+rqm/Tl1TQiV0lVKTL6CMUspn0NkrMwN8EeohLRRBo0QLaUtfqnfwZARC9z8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3XUz/RrbCBVLJWOvZ5AOjhM6+8Kf/3DVfnqekbgf03rOC+Sld8nx4ySIH8RH?=
 =?us-ascii?Q?fUnkOOcThrfI9y/mxr/RTG/Gc/oMivgyzywofGA7r6MUIxJTgVlnMf5ksvzB?=
 =?us-ascii?Q?RFcON73kcMlYuzAohl9B43eOA/XseqYCVYST7yB/5/l/XdmP+24QGuS3jgO1?=
 =?us-ascii?Q?J8449g181L62c1NOsL+ZOvW45soeaOxd963Y9cFxS9X/9JFVI9qEPMRJV1WC?=
 =?us-ascii?Q?x1DYk3H3SnFAr+ODiylbCJ/vx6E3A+k5cCqYcPBzsXZyUms+lmc+yVfQdeeH?=
 =?us-ascii?Q?B4UrBNVdWvETx7acj6k1ybTri9xNxWuOF4rKG/XqrOojmaBldleCD+KiQVfp?=
 =?us-ascii?Q?CMZWdqt5TsJ2KwE8jwztUAD6N21orvxbcYEFgsmmi984ZmMrD80JthawnrXW?=
 =?us-ascii?Q?RxLA46DQarejQayrGn3w0DOU0zvjhctXlrI+f7fsF4NbcYyTXD7NGrwCblfp?=
 =?us-ascii?Q?AVBpZ7E7z4IlIbPzgzFzJPeTONroEEwHPpUt9Ii+sPj7g1Rec9NvOMQRKx0z?=
 =?us-ascii?Q?eSF4oY+YA6Md+d2yx4QCMvPGwfiAY7E6DAwXf61TkGjFWqoDkkyHole+ulCz?=
 =?us-ascii?Q?PMjs3oWzixw4mF+RFWiJqOpGKaSoKXBVAgee6y4R0ly+i9VwRKxO9j4JjWAD?=
 =?us-ascii?Q?qizZb4voEGqN1sNvt6UN09nbUAVKCnIxXcZWvo2dicIj6keZ0Z+g0qhbgyQ/?=
 =?us-ascii?Q?QjxTB+hv3ToVqZLKVCUaOBUE8rDTCbtiOmCZx0fnRgO7w4ZGFw/mNJY8rCiU?=
 =?us-ascii?Q?SUhtZPihBEDnUPbOk1ghYR3HSr8yrC3C0PLCqqxb5oxAgu2Y9LCGoamqGNV9?=
 =?us-ascii?Q?KwyjUYQbi7XEqvlLRE03yP46VwwJPk9wiiH6lxBdG/QAeJGVLun0Lj+YqV6a?=
 =?us-ascii?Q?kpUkGa873WPUCH+rW122GltVa0cGtK1hMtI457UaK4+RTPGktf1HQqtcpox1?=
 =?us-ascii?Q?JRDDH+6DfZcDpES8yuQXPqBqAZGiNoF9CtLQAMlRVwCD0VGxNeiXSiKEonSJ?=
 =?us-ascii?Q?iyls23Xa57EdvD4kjVHx/SQkE4NxEI+/6mOxP4dn4thCuNhoRr1ThPvkCd+9?=
 =?us-ascii?Q?Z86usA7uiRLg3A/0fRfbbp+ACKiPNmPHa3njzD3AaIbe0GKzb9fgz4Qvvdch?=
 =?us-ascii?Q?FyE+gD1ievZjkF0q/f9jxoG1LHnsRGXyILcMvXW/kKOSBWM77uD3H1+wvWS+?=
 =?us-ascii?Q?47IM94PzpXPPxSx1d4C6+5m7JoSy4EkVveX+sQZKPPvNb3/oPiuT8TuRFs24?=
 =?us-ascii?Q?mI8Hyrmj2PFq9iE1qH2Tttp/7eHa4ZJdA0KZMwTM73viihffPCMpQAzZmJAf?=
 =?us-ascii?Q?RPqt/rff9ZvnkGRAGRTKWfRvvY0l9DPQ2ovAWKT9M+w1ZpDyhq236GG1nZyz?=
 =?us-ascii?Q?k5UtOTeKzKyFo87UdzuTtSkOGmIrgn0UHmVqiC2ptMBb1dI+FUcinnVb2IQL?=
 =?us-ascii?Q?Mv+n2ssxrBWDFXCF3KM7kXIBZZqIIAUmPwgQE215yPoorkKLorQL7vjZsle7?=
 =?us-ascii?Q?6ClVOIcHS4XFb81kR2EV8Apvf86QKfytXC2B2uzgFO9JhSrA+KvQwS4U77Iu?=
 =?us-ascii?Q?bGhtES1E7DLo6vRiEv5Hx6lgtyZeo5qj0UazqUtW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59edeec5-ea67-43b5-6ed3-08dc3962545e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 20:09:26.7749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEApbBajMPF5lSS3AG7fM1tYZoVVYUIEHIFrqwsTXfHu//Ip7dN6LhtGPA1uaY9b9XLErGop82driEE2z6ORWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8523

Enable the power-domains property for the fsl,intmux node. This addition
accommodates i.MX8QXP, i.MX8QM, and i.MX8DXL, which utilize the
power-domains property. Incorporating this eliminates DTB_CHECK errors in
relevant device tree source files.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - Add reason why add 'power-domains'
    - Use maxItem: 1

 .../devicetree/bindings/interrupt-controller/fsl,intmux.yaml   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
index 985bfa4f6fda1..78baa0a571cf7 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
@@ -37,6 +37,9 @@ properties:
   clock-names:
     const: ipg
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.34.1


