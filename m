Return-Path: <linux-kernel+bounces-130858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24635897E13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D93EB222AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3CF21106;
	Thu,  4 Apr 2024 03:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i2XW3Lgi"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2115.outbound.protection.outlook.com [40.107.15.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B971CD32;
	Thu,  4 Apr 2024 03:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712202751; cv=fail; b=TZU5e1ZTdH6U3xKQByi9m/agpKbeJAg7v3UFG2BB0/Q/hUQWp9I8MXvqUuAIJCrEvQ/GHf2VnqzTFtWl+6Ry7c38K1Aqr7YED8JJpFfUU+0KblYF7UQ5ic/BkShirCXhKWl5Zc6wLAWa42R0KuMpZI3RAuUcmLh+2AJGMZnybgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712202751; c=relaxed/simple;
	bh=gh8roNa8vSRMzD3OcuArwckDMJk1+TC0NPpUU1OS3s0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oSbvcBLGb6lalXBHskUNj0VBOuEwkXzgrLR10+nfqGz29yN+MqbUMtvtCSOj73I4Igaqj+2Bj2IR3teVOgigm42Azi8EsspgqznlRKK7xCFq2oYK1LTZbHF3/ER9GsCwgOY0VcwI9O59o/zAGBQvHzU5pFIs+N2geUNH6qInt5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=i2XW3Lgi; arc=fail smtp.client-ip=40.107.15.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/YMEfrl5YO4+jVb59HhOvoY/30xphBLDp9PCIutvhubhDD6XAVx5aQBR+Uih7Rg6RjmONP/WQwlFr+P+b5aVuN1VIQ7O3ygOp+Zhnsyat6DW/5XyHgyr+2s2SAfp+Lym8aWMV7crODstwcryKILZRZDS91vaFzQSwPdChpuUNpsh1Y2VlAfiCGPwagNoTRuQB+9Z+qrwpxLcIwH3wfzxRLMKyljTJfPqcE/JvCu7ADfpEzgvMnERxjpZjjjTqoc7Ey23WBE04oMPWkd9veiIUC6EcdcpJQ9ahdlEI7A+cP6//iK9il2hQIX9xKmyw9/GojFSiXKLWGssuzsq8vFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCm0HEMPLEUGQ0YDtjy6ARqP+uTe35k/sWhLJxXTA88=;
 b=asC2/KqhiF8+u0DPJiiUTQf9uB01eccDn3ISJEszhEPJKc4y7SLI80omo/qr8b0NAudI95acjbN9g2k7WBzbCOuckeycP421VCkuIwKKkIi1V6dZqiWnBx4w4YjDXEh+lN3sviL62l1T/gT9zf5NQWYj2P0zWyqiOlGPQp47Y8zdJKz+/0N3gjnnDsB3OE1y8wQoTkHnHQ++wZD6LfQ2ZeMcGcNayGoBvv82OQlnC6YBOxVQezO9bZKK4rHkc674eKsEcIF+yhgCY8mzlhI9csKc+xbajZBdWqcR5EsDu9py5jQqGA3pRDKYSWrFOexV5tgfkmynl8BU6DfMYgBhDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCm0HEMPLEUGQ0YDtjy6ARqP+uTe35k/sWhLJxXTA88=;
 b=i2XW3Lgicyhhu+BD1abGJ/+8ozm5jBtdit7z58mBOcYuxeR6XtAVrwJxonsWXZN2/AkTePNkQpg0CiYEbxaU2n0PoMhUuqG/fLZp1p70REN6o3DqzgL4Lk2si1SAnhmFpOF4VqAmlSeGhhdLURscFsdyPvKQTS/LMIEZzduvDW8=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10486.eurprd04.prod.outlook.com (2603:10a6:150:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 03:52:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 03:52:26 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Mirela Rabulea <mirela.rabulea@nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev (open list:NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER),
	linux-media@vger.kernel.org (open list:NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: media: imx-jpeg: add clocks,clock-names,slot to fix warning
Date: Wed,  3 Apr 2024 23:52:05 -0400
Message-Id: <20240404035205.59492-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10486:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Sl49Cybgy6G3t2QqHsxtLTzuz9Et88rQJgNoNs3f1xnVbG50ci6TFSQRw7T20V1P+GXBeOtObV1c6ZmyNewyB+b2r91N7EkNFAjO6aY3cyNkayQxtR/Y6WwGipGPMWYkPhB3jrAqMYmxo+S9II3R1hAdJDn1teesh6CdKVBMk7MNasrZOmeJjvRRB/SOiXLU7OD3DxlZbNLMkDMcsPO/T9mq+rTEhKsEf+/fwiGcfS51WGsy7lwtU3aGQREvpisZ+eC4Woz/PCZMhbV1HQ1efh5x5gLVKqidZ3CqASXPl3dVFZ/OZrvBo1hlwYIvSSxodEJrofmrg1lTcswtsAS02EcqC0za1hCvmZ/IeSTDnQLNxpkLbiHfS84FS3Vk3LyL6O/f1aQCrO/e2rQMXIdnJhekJ/LZXrkenyaBlEliJ/rzj9Kse5ZPQwuswRhyI/0aPDjg/gv/eG0rYbeQ1P9PPmf8t1ZRCWJF0qOPZA+aweAWReA3kk1pciLWk+8nEWGJ47mTjVCmbwfnk9eywguQXGowCfy3hErE7E98HJ6aI6DLKjxKGGQgdcqgASnuoPSirT4UHDhd9K9EdHh1LWz26GY3enP18AVP3VWEEdeD3Ns+KPGSFoux+tgzp1yv4nnODN2fiVJ7ji4YQo/Gs8wvz8PjBkLsP/n19qA5VATuwBI0w9FfvYI2LiZXkxJo3Lw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(7416005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D8Xcz0ZkVhxWoAGPGGDr7UrFlOJK9CP+hjaBoEdYyMS27k3yeDEKPhYIzkSg?=
 =?us-ascii?Q?3/MYG24Lhq1bDh9cTnlZwX2krp8wfe9/uNnaeL9Z341Odln64VRZP+/XC0PS?=
 =?us-ascii?Q?kN2zbWo4LuzwQ6wUOhHnbvbAau2SoTNMbTG4G2vjiVbOMAw+Aj4lWr6H/nCP?=
 =?us-ascii?Q?pPZao9Bz3uKwC9rn4n11vlCiM0zUas5/aGeaQ/P1ARscMdiYuhdc7uowWwzX?=
 =?us-ascii?Q?ij4UqMGdh1gG+w5dgNcX1ltePSzml99cipbSyW7SRfaFXQwNiVapwSAI6jX5?=
 =?us-ascii?Q?yAqrGc8e/G3WRTV9gq/YRZTefMG5hQup7b2Y159BG2mMGUuHavIEssOLc2+N?=
 =?us-ascii?Q?KrIJPl3J5LXD0nLyFV2Wda1BCBDKhnHLRk+uao6DBit+1/TbK4azhi0JbwFi?=
 =?us-ascii?Q?i4bk5BTkj9TVcE+Wv6gF8jRU06ViwJkSsOI+vIjxoQT/BaCmvJiUVIVryy+H?=
 =?us-ascii?Q?wevaNQAG+UjAiO2puN/JXvgpPcM/k+ARABMwtc/UUmgYN3OsRdDLMeXM5cqg?=
 =?us-ascii?Q?1n+6SYF7PFnTXLVAfI3yMIYx2+ibAJGf+BdoHUbT5r4kJHnqJxuQEwLQUgNj?=
 =?us-ascii?Q?7xlxEKybmZua7gUFUIb/Y4EqyWOhZv0WCcFhgc/17Qqrh911VXoZnzQAoT9V?=
 =?us-ascii?Q?hjhbQuvXWsNxQ6uRIbbJJbYZYsGX8CnzmIqhXQfnXihabzvB2Ak8GrwpazvT?=
 =?us-ascii?Q?Y3FRUvbYRALel3XuiaoMxMEW8j8ZpTMchY4kVGKZsw5tCn5fIxoA4j0IEcJt?=
 =?us-ascii?Q?zVBWDqX9TgSdpsaov2TvDMSJxfEWUhhtTC7S7Om71Ufgm9ywZJ8vMY3FyyU6?=
 =?us-ascii?Q?XLVZT2TFcA/x1rPJcd6TwnkQZBDy6N62Hx9QEohlybziSQ1DFYCWrSqchlVj?=
 =?us-ascii?Q?je54cYQ+691kEvjkIbbhbXd/749X03l+Tug8PtfYcpQFNoC+SyOgcvEdX5rk?=
 =?us-ascii?Q?woqtVMwGCfITItYM9k2TYNiXTN0wUhc49QQU4hJaUhrCVR0BTP++2hjMhNfv?=
 =?us-ascii?Q?zZOTgrpq3x6G+kQDrwvLrKXHBSGhHhF3jp5Ai0f+gQzFCWDRqgvrDFQo462h?=
 =?us-ascii?Q?JCT8YySs9nE8bNs2xgXS/liEm2pvsllBFKrKBHh22t2YeSsr2xr181SKmbP/?=
 =?us-ascii?Q?APJJ2z87139M78Jxkjz534NZINJRWhH18VeruI4DG3GRQPvJ2TQ+Yzi43tUA?=
 =?us-ascii?Q?HumBtHIV+4PMILQVS3uE2C2xTwH0zKeqve6YUy1TKaAi1vK99ZoCgyNGrHqL?=
 =?us-ascii?Q?G0NpwH04Y5+ReYd/hE+Ru9YTpdDyfqtUze8y+yKr797i4a08SY7wJZ5xSons?=
 =?us-ascii?Q?DTEM1yKmKNzGVa4HhwbtCsm99R9IOIlLg6R4KBEb+8rRjrw/8viLsopHHcrO?=
 =?us-ascii?Q?27O6jA2oJ07hRSIlpgXXe//Kv55Gb/b/GJ2anWqvD6mFpN40XHTSdUkKJbp/?=
 =?us-ascii?Q?WC4KId0HljRjAN/ZpqUowzzRz6k6UQu2teFYOf/9OfIB2R0fEM8nj9p9qo67?=
 =?us-ascii?Q?aZGUqbcAglBh9zg4A64JOH15/PVX/XxO9hKtKSqe8HY+BslkZlNA2Ht7I7x7?=
 =?us-ascii?Q?tU4kcKxoXjMcj2Ae0Nk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdbcbef-40fc-4b47-ec88-08dc545aa436
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 03:52:26.0102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtHpuVan3WvvH1XW18w2iFGdJ8NRCpepzIhrmOmtWsL4IL6LUeAHb8IPIekcRTRAau7/6jvsvrksA1nXWtl77Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10486

Fix below DTB_CHECK warning.

make CHECK_DTBS=y freescale/imx8qxp-mek.dtb
  DTC_CHK arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb
arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: jpegdec@58400000: 'assigned-clock-rates', 'assigned-clocks', 'clock-names', 'clocks', 'slot' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpeg.yaml#

Add 'clocks' and 'clock-names' property.
Add 'slot' to choose which physical jpeg slot.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Pass dtb_binding check
    
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=nxp,imx8-jpeg.yaml
      LINT    Documentation/devicetree/bindings
      DTEX    Documentation/devicetree/bindings/media/nxp,imx8-jpeg.example.dts
      CHKDT   Documentation/devicetree/bindings/processed-schema.json
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      DTC_CHK Documentation/devicetree/bindings/media/nxp,imx8-jpeg.example.dtb

 .../devicetree/bindings/media/nxp,imx8-jpeg.yaml  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
index 3d9d1db37040d..32820ec42de9d 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
@@ -31,6 +31,15 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: per
+      - const: ipg
+
   interrupts:
     description: |
       There are 4 slots available in the IP, which the driver may use
@@ -46,6 +55,12 @@ properties:
     minItems: 2               # Wrapper and 1 slot
     maxItems: 5               # Wrapper and 4 slots
 
+  slot:
+    description: Certain slot number is used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+
 required:
   - compatible
   - reg
-- 
2.34.1


