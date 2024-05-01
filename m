Return-Path: <linux-kernel+bounces-164950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18A08B855A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71890285BB6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9494F4DA16;
	Wed,  1 May 2024 05:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rqWVwqDo"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2081.outbound.protection.outlook.com [40.107.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF34C61B
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 05:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714541572; cv=fail; b=QtAZkN4cvqwAa8ng5nSpTLYsADbjyij5dlqERfDYH/9u+7oIVBjUNcob0zMPLXnZbw/7nEi90wFYixzi6mq08lBmgM274pN8VRt5HH6HU4H15i+RHqCxnV766MPF5WqwG1/Uh2op7S6yLJXUImFG2Or7lHpA6ILg3lV1pmWHPeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714541572; c=relaxed/simple;
	bh=vYU263AdQDIOQFYDalyB8CX250AHCiuprBAacNnCmkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uL3tGCDc6cbowqNzHdqt18kT9U/DQU1hoh2xBKP/0aDEr5FlaOB40Jd2frqQn2n/KJTL6g86lBbN0P7oly5R1iCECb2tppCrabQorW5tkeog9a2FnbCPkAJZxyfj2Xap4tuQIQDZvJQaoTaoXVa0wLzpiPeum5ptnrRYW3tKV4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rqWVwqDo; arc=fail smtp.client-ip=40.107.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifHrmBH7i4XsKEcRWQT0gNB3LyckNrbgT9chKnFUjDaab1Ap2eDS6iRRngkkGxk+8VlGjcX6fT0WDGKKu3FKUvgn96tHpEsl8EiMtUXKP4Eww3j2Tqa7gqzmp/PUeTHPv8UaYdQaM97DWLFZ/95ezNpLzaQ+KsLiRj52FpzQ6QYemyWp+6I68o5Qe43KhEa1ORuCobVFtx4bLIOujWX7DhmP3OoOlUN2qWyxucqFjFUHp+X9alZ4PD+UnVIboZVEpspzQNZKnh5WiKJfOreaA5AspEEhXj+GVu9rk7udlak3F9IO3DonvbV/r0zM5H3D0mcqCU0OtwZs1k7B/SO6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4u5a9BlDewljnct/kMcV6x6s3nlS0FUFWdWexA+zss=;
 b=TlUkhYCRBTSWAZsyhAdQrzZhX59W7TLD57la42f33zZb12eC8Jo0EYq2CqgOoxLdX7vh56odrFdhzAqK0IeVXseEASlsYJnKRZNZCr/klqPfEcY+G7h01xqDfkv8Nsn2PSC6FzbBTSFMPLLjHMIoIzNd6tvae4qHpNFxxf9dTLHuYSZ0jkKiGEecVjAiZqvc+3mjHx7SPi7dkr5bTw4YN6g9c8GO6xg+7E7rRDir1/bnNzB3rrbtbPAW0xf2JksEZyDXf3iEj5zTU8qk0y/bi+y3SjzZXxAcB/9D5L2oLt2ElZBHCZzhY+n45FPemPZAp9lWLUkXg4hELW/Vxs4gfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4u5a9BlDewljnct/kMcV6x6s3nlS0FUFWdWexA+zss=;
 b=rqWVwqDoimMCyggqX8OHNpxpYbkjkhlWIrrgEpR6pAYtMPK/hmbLWpfJRdMAFuHnS+6b0JEkVpxzNG6nGyqAQOQtA475on4CTe1/nHwDuGJJ1GdvpH36peslSRAflsLPXdwlzH0WyAJr9SP70cC8CGBDMrKVV44VMrYw+NdpU+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com (2603:10a6:10:36c::10)
 by AM9PR04MB8859.eurprd04.prod.outlook.com (2603:10a6:20b:40a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 05:32:46 +0000
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab]) by DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab%3]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 05:32:46 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-imx@nxp.com,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: Silvano Di Ninno <silvano.dininno@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	frank.li@nxp.com,
	daniel.baluta@nxp.com,
	Vabhav Sharma <vabhav.sharma@nxp.com>,
	Franck LENORMAND <franck.lenormand@nxp.com>
Subject: [PATCH 1/4] dt-bindings: firmware: secvio: Add documentation
Date: Wed,  1 May 2024 07:32:02 +0200
Message-Id: <20240501053205.1737248-2-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240501053205.1737248-1-vabhav.sharma@nxp.com>
References: <20240501053205.1737248-1-vabhav.sharma@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::20) To DB9PR04MB9354.eurprd04.prod.outlook.com
 (2603:10a6:10:36c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9354:EE_|AM9PR04MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 7996f2a8-72d1-4c12-88fd-08dc69a0218a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|7416005|1800799015|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S8p4nUV3hDTSl2K0WtMV3EcUz6yQsVYwb8IuG7ATRsp0mh9yaWoGIi4ZL8Z+?=
 =?us-ascii?Q?tPpTTa9eXm8UWt8j4u9VwTBiAJG4lM5dKjpwA4kKxqcXeDRFVgMTzt2nPZnK?=
 =?us-ascii?Q?NqYIy9VuGkJsS0vT0iMYMY96NztwA1KimQ9v5bij32illzgSG0saVvBhh/7u?=
 =?us-ascii?Q?RT7YmjaGSwdQu8b4ESh2mcCfKURUKfSC8jaJbIb4cwRxL3x4n74IuESiWyE7?=
 =?us-ascii?Q?2wiSuvmOqNOyp5utHjLnqc+fmE1MT3ED0jCe7RZub4QfYWcR29/eyEvWrFzW?=
 =?us-ascii?Q?3qA0fsB93FoBNwHjMGKSDTjBvfwztAQqAGZCIzEAMb02V3WbQyWtVfI2IimG?=
 =?us-ascii?Q?T+KsjngR8rdt9V58CNgKle52vW2kE7QDF40fYLrWxY1gIviGC+jgZIF8serH?=
 =?us-ascii?Q?FoWuqiJvSNWZec8fP6imHnujkDz1srab2p+mTIpgQPR0JwZ0yGCxPgicwl8d?=
 =?us-ascii?Q?PmgSHe2fkayr7bDHVZ3MSqIgB4GUeObGUyTzbRTZ+ZY70sny0zmvT0Ompa/D?=
 =?us-ascii?Q?/DpFqozSOb8VRBggIphmDNEaDIuEF+CKkSeTIMMp7u/Uirh/GWj/7h79zZQ4?=
 =?us-ascii?Q?FFf5gdWse0M0VSWl0hp6Kkz1g9wxbQcENNNhurjyexCrxjeuYtqcjYbhIoIA?=
 =?us-ascii?Q?g4w9aC1GUI8w3l+GR0tvGnFvonuqE/TcdZDZPfhAfKGwhI54gXGSi4fnEspR?=
 =?us-ascii?Q?anDwSrpJ7vQJystGwZYvOfYiD1AtN2zknXvKLSmtjCz04Tkn/jOqr55vmhEK?=
 =?us-ascii?Q?dqUbYPW4prqcR6SnGVLZzd0VbzfKHeqvqedCBc2lf/+5yt2CC5Ulwc+ECu71?=
 =?us-ascii?Q?vSn5ykLAfI1svzbKBHF0qkydYvqCgpvD5MerkztWN1Lmmrr63cj40kheejnx?=
 =?us-ascii?Q?kCZDK7rGs18EjEj9VuQtWAUVD3Hyq+igajSUmpUt5bwQzCWYbmPxy2XtrYRK?=
 =?us-ascii?Q?hFbeqNPVQJ65aCC16C/kL1YOKHpPIKug5WFb9neqiwQjH0Cm4BGbmIv72FEH?=
 =?us-ascii?Q?42z0vCdGXo53UNMWiA/s717+Eqpp+8ZtBpilgkea8LZME5hU+5EkFdSw3Hl/?=
 =?us-ascii?Q?Q9d2BCCkODv3FEePtIRuK4GD+msdNcGZX0fhrTDLK+uAXoj0oF0vepI5/mVY?=
 =?us-ascii?Q?CKCMLQFEp3PXYSm3oYSHLsjXSlZjSzUVS4zWlboPc0LaLgdyVFNr71ch947P?=
 =?us-ascii?Q?EwG9e90NzltECHvvq4BDrzNvfJe2iQcTvd1KW54onTNWnz4opVcGn1PAio2p?=
 =?us-ascii?Q?idHGirGzPgZoaW6SUbmtn5QZBU9v2206mxonGiEfQXU146JiL/WAuk5HE2fI?=
 =?us-ascii?Q?EQ8O3Mz+SYGntBIJ9g1T3Hcc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9354.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SEhqtZP9zsOnXyMxyxHUsUG08FNqE2nO0UyelXx69YbilKEImcFvWfykS3YS?=
 =?us-ascii?Q?EebKttkpAL3bnWAkFkH91L3EVDcDubftW8BQnh3+7nOL8j76dCJJuZ67kvhO?=
 =?us-ascii?Q?0rf1YjeMCUgCz9m3QnFtJWvxpUMmeW7H59swLECsFHkfjcdozHtPEmryRcEC?=
 =?us-ascii?Q?HCMsEpiTR8Cr4jMbLJUlLqNPUBpNhOhFpo45YHUBdb4vTDO8nyvcOv6ObBku?=
 =?us-ascii?Q?2bXKnf1F0owGB9Vg/A4CmY+kDfNz80+kye6Rg2FuHAl6dDxBXDDnRWHqLIdr?=
 =?us-ascii?Q?NF+DjvHPd6SL42ltdtW/EhHND2594Bwu9gz+BtHcv+APIM58RE5soqCarvmf?=
 =?us-ascii?Q?oX2D16Hj4d/9UQ274MZRiszL2sNEiJHWbmC7Ub69USlRIbrTuK5vTjPnEAzn?=
 =?us-ascii?Q?rZK/QR6BmN6hYwhs670857qETPLRfNbHnjO84vMDPZwzbX9Jksx11YxWgItV?=
 =?us-ascii?Q?OuiEw3RcWU4nszNG/wnTU7GEXQ68/m3yRNHVXKpc2FCGVEQtcuRDTsqV9+uG?=
 =?us-ascii?Q?s25oiQ4ukwOfhmTKzoPYqF4EQFigNqle6xX0SrQLily4GZG1oV5NDP9HTakP?=
 =?us-ascii?Q?ZXIDtb33p8G3DH6+4rWCMInl/hM7uKLYHmoF3Qx0sxBIpdJ88lTLeLqzoFyI?=
 =?us-ascii?Q?R7rY5acwovI8QjwQLP23TpcRMkpmXOG8K4BSLfM3IoghGGQeJBccnRrNSNNl?=
 =?us-ascii?Q?WcXyXIuDLMI31HXlKt6TT9ADI3mkPtHz0MJFsR/1qD9myOPOIF5kFqNYK+tO?=
 =?us-ascii?Q?GM4LE2EqKP1cJw+Famt1YEeFfYbMRWZsNtJlOkUJRAMnOSSAg+iw6qILcimH?=
 =?us-ascii?Q?z73Jtw1jwUsa2Ua6oVY+ro5cJBgmczWpHPZpxX5eC0+QFyLS3OtxhGrkiq7s?=
 =?us-ascii?Q?0yIdXgsoXEXM53TJPPanl9BySLfGe8d5QrerIDFVS7smNj3MN+/EDXDF7cey?=
 =?us-ascii?Q?aunrBCL61UuLNQnMxWKiuSs2U0QKeQqy8iutETeqmMpa95UIitP6UL3eYBT8?=
 =?us-ascii?Q?r/MhMq8dgtwp84Mx0boX1725Zr5TvZqyf6lAgS3arlkaC44x6OqiS4exEswd?=
 =?us-ascii?Q?K4TEHB2cnX9Sg9paaRzgaModsNxYmVo/znYFkSIhb1VmIkyqH5W7RGVzKvCV?=
 =?us-ascii?Q?YWzpu0F5wRcNXSVV3R3qXf/V7qcRsKOfFdfthCwVf8/PjQb/zaDSNu6xisp4?=
 =?us-ascii?Q?sMvEv9MhCW6JcwxXeCDxCf+18j24LUwhS06WRTIwPWBG869dOQlQTDkPPhg/?=
 =?us-ascii?Q?eHDW9SuFtAiZ64b5OkHakzuDA/iyC+COtbelz6e4jrw94I8WGEzPSfqqrTqJ?=
 =?us-ascii?Q?eA62OR6FMrN41STijdGTocZuRHl4W7ZNzhDNSJ7iGG052Mh0BQuWhUgaR80s?=
 =?us-ascii?Q?yWkuZa7bavenq16kqPU160jtoW0lEux7OWOGKXSKZhLx59asXvuoHppNy9pG?=
 =?us-ascii?Q?MFlbt8jlMhjEdujaCCJnyICkStvxgr13OTyguzc/AYcCKEV1fKiaYNc1XbSu?=
 =?us-ascii?Q?ialtQggeOJx5OcCEmE+EZ6UJ1GaGCJfROgFWGdN2QKW1TBqESkXVEv91HIms?=
 =?us-ascii?Q?pma6kAo9UT4Flv2+lfU9eoivAhiSGBlP9vPzAkHL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7996f2a8-72d1-4c12-88fd-08dc69a0218a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 05:32:45.9600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twuh7CDQH4NocNwVwwm6bUK+y4M+pGj4GS/d0Z0Vh0hyHNJVTwDq6uQycv5TJbfB/dZbKlJnmWUsvF12NaJO1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8859

This patch adds the documentation for the SECVIO driver.

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 .../arm/freescale/fsl,scu-secvio.yaml         | 35 +++++++++++++++++++
 .../devicetree/bindings/firmware/fsl,scu.yaml | 10 ++++++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml
new file mode 100644
index 000000000000..30dc1e21f903
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-secvio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX Security Violation driver
+
+maintainers:
+  - Franck LENORMAND <franck.lenormand@nxp.com>
+
+description: |
+  Receive security violation from the SNVS via the SCU firmware. Allow to
+  register notifier for additional processing
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx-sc-secvio
+
+  nvmem:
+    maxItems: 1
+
+required:
+  - compatible
+  - nvmem
+
+additionalProperties: false
+
+examples:
+  - |
+    secvio {
+        compatible = "fsl,imx-sc-secvio";
+        nvmem = <&ocotp>;
+    };
diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
index 557e524786c2..b40e127fdc88 100644
--- a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
+++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
@@ -129,6 +129,11 @@ properties:
       RTC controller provided by the SCU
     $ref: /schemas/rtc/fsl,scu-rtc.yaml
 
+  secvio:
+    description:
+      Receive security violation from the SNVS via the SCU firmware
+    $ref: /schemas/arm/freescale/fsl,scu-secvio.yaml
+
   thermal-sensor:
     description:
       Thermal sensor provided by the SCU
@@ -197,6 +202,11 @@ examples:
                 compatible = "fsl,imx8qxp-sc-rtc";
             };
 
+            secvio {
+                compatible = "fsl,imx-sc-secvio";
+                nvmem = <&ocotp>;
+            };
+
             keys {
                 compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
                 linux,keycodes = <KEY_POWER>;
-- 
2.25.1


