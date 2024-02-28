Return-Path: <linux-kernel+bounces-84911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACF986AD99
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18E2B25D02
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D88F14831E;
	Wed, 28 Feb 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QTRTZdJt"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2041.outbound.protection.outlook.com [40.107.14.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260B41419A7;
	Wed, 28 Feb 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119827; cv=fail; b=PlQJ9he6BDVOe2A5CaA5ie6k0HRGqwNQKihn8Kht50YazkF2tPfQ4SG6c9USarV8J1o8Kn9Uqpp7ekxtgomspu67BYRqE8mSGTTybZW7JJPvhTUP5GF/4x/QwNTY5Ab2F2Dg2DAIFtBoDp4Mz1fiN3+l4EmlhSJEuJuqQN8lBUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119827; c=relaxed/simple;
	bh=YJQLOSSsooqOajW2Zd/7fRtdNaTqhkj0MZmfNwtD3aU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h/GmAFwwY2dRd2V/YJZAcXekjbEV/x6VWsR9WYMc0i++PBGBMX+Bed0srLFw7JNJ8AP5qSbRujZhmGvtPdmxaYPyru32M40jwfZaaqLsr4iikOVb2R2Meza9L6NYv0MEppx3vmmgIMx353zR0qpCg9HaDhxstu89VcBN3JFQrxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QTRTZdJt; arc=fail smtp.client-ip=40.107.14.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+XeEFxQxf3h2jt/73xlFCYAd40nVhI77pWF4Wg/0NKuNEO+HKmFeWxQqZtDOHCxmUDYrwRtOojnIQknklS9YtlDjz8Zc+4u150qf9Au0diwRSEIXztIh8wuwXhmq2kgkjhoq+ssY6JkhhnZnpkoel1wVx0HVm/wVs1VvZfr0UMv8BShvN8MiT7lRop3JgDh3jMgdA2nMaB99Sl9QqhiSfWUe2VDYCaQU/eTD9B0ve9V4CM7qx5CawpLs+upEaliWKSLNyTRbkzWjuCRTVTVORrIkTiqyB8N4MoSPj6Yb8kiM0iH1+pAU27C1fNUXLD880hIVdNfNIHo+K1Hc9GSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN8D2xtOTzBZluV3Ya9pJjNmZhhTJyx92nuu1oSeAT0=;
 b=RyK40DUzVkvmWCJhyPDm7ANfD14KpLz4ur8Cd78EIBmaBI2skmKqMrDGjM7A/QtbDzdcSmQ4Ogsmz8NOZlOUkEfWuZB7lLJiQe1OpmetTarZOT4PAGx9Tgl1U3rpt7OpoucwklHcQrMspmqAsewqqwRePVy2hR/uVvN8EVWJFV01iURkUJX5iPbljuqFSr2xZn/Wn6C0chQ9+R8P2efzkC+l6Jl8g58zQgJ79kbhqQQmghD0ECpNy4WV+oLv0gCo//fnzB5+bwahdg624ncOPZVvLc3QpuEbmCAWKHMiBotfANCD/vOk4hgTk7GJACLTAYz4d/zX9HZoP4q44l0FxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN8D2xtOTzBZluV3Ya9pJjNmZhhTJyx92nuu1oSeAT0=;
 b=QTRTZdJt2gkXzKLOfHnjT7wkGkT4KRmtF4wESLhALLYzkKBRcBh6dW2qz/vzWOLxSDJRBSr3fxdan4r7YBTJqL92AxLIisEtnCakfMHbSvHqSTxP7XioGONv7z26nZ5ATZvQEe+hkAVULKkPzmRog7gDZF6D7L2Imdnlw9iuVqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 11:30:19 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 11:30:19 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/11] dt-bindings: usb: ci-hdrc-usb2-imx: move imx parts to dedicated schema
Date: Wed, 28 Feb 2024 19:29:57 +0800
Message-Id: <20240228113004.918205-4-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228113004.918205-1-xu.yang_2@nxp.com>
References: <20240228113004.918205-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 785638e6-9f9f-4261-b4a5-08dc3850a4c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M8oYXDKYWhKnECr9JjzkdF1fv58wXaXZZYd8wrblq8JL+iS9M7u6POdmwwYLTUqj2S4qprzAua/e1kZgFUsFhe9v9OutAiZA2nKCLMhIkGU5XIBUgGvoYyeTAaJjwXD7a/vrpLZ+fkLbSxGmkWkpe4RsITSAC0C+6/5dcN8hPgJQrEZhcX/crUlT1xq20Z/bp6lyr1dDUwlxMkNLMk1v5oQq+pvm66EsBEHxMmlSTgOhnXvLOT0maxYBc+OK5q4XWBheF84Zubpz0XpOQF00z+c+Cup1FgiHiyh5H4IjECh8BloLLfoyMBrfQK+j2YXR2/CWMsz5DUVbQF/uge088cFgL0uzZ9jtOmU9U9e62i8dc+MIaiVX57n3e+Wf1san756d0B5WZnjII7Yc+M6iYoMiv1hojMVe4yD9GQOy6OiPHPUsWVw1wQ2hHQst+z91rYt0sdLduCReNxu0fiYGP49end271WwFpcH3r1JQnlXS7JLnWYFyjKvGAljcFmCcI3Ud0AOlgLVliqTlroJDV8jdP3ONDE2h8mPoR+4LRzI7NXpQr/PP4OTY1aV/c35Wtaj5S3Dem9/xdvlR587FrByiB/GX81rxFOUHyqwOgqU3TMcLCp/XEtGjGZZLlDVC6O27EHslAMAP9GiJTvVUYs74W/qj90KaeURkwgJjhsg5VjPaCViLD1prUZ1d/L19QO5PgD7Owbv1iDSXoacUuw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Oh6Oj3S1MjeOiSpLhdj+MbMSnQ6NShQrPmg4Idsk4hit5kdU/r6kuQD7Tkk?=
 =?us-ascii?Q?LrR/FAHHF/OyazC8Bon0Uzm/J9+OIwunRoIlYR816w4YG999gbQ9/NSXbH8/?=
 =?us-ascii?Q?YhexC0v1xRVZwvQMoKeiCBdAczzZ9/kcHFz7cgtFAjyw1VpMyKFMWILWvZ7q?=
 =?us-ascii?Q?ZDyOwwxSwoU5FbVfO0m/revmFADSiYQqrBZpOhIiKLxstdLg0LRhN2tGHwa4?=
 =?us-ascii?Q?lzEjxkCQAuWO+Ebk8dGEkPkOl0ZbcTziphWt2kRy4wQTNPboLmSUDJt4nlza?=
 =?us-ascii?Q?lsFVzYRs9tBJV7yyXi+O0+W0CmExRsbvI1erBHEEdH9d4skPLjHdwPs3Otmb?=
 =?us-ascii?Q?j6HGFFHnKRHrCYrUz4fjH7Ua9SV/ITCMDXqI6gAEw8hF+IdfpmEcr7KG1cal?=
 =?us-ascii?Q?Wl6CC+2gf+ANUECPohbSFGQBDpkUWjVCZ/8QQHiipc/XeOTlaE88pO3o9pma?=
 =?us-ascii?Q?nC2jKk+JKrgZ+ugLW1CBC1JXCAEc39lvJKxGUi4sZu4++PbIPh0E8DRe1EHU?=
 =?us-ascii?Q?n8rbTC6lrzHXHCFdf96jca1AUEowklWteWqRNlBQKy6EU6sr9rSKwY3mYVkv?=
 =?us-ascii?Q?meuPwEn8XoX3HW1jAorp4eG9BOzCQHw8J6T9Fj/wlNFn0mHc5xIZ0uAGkHqJ?=
 =?us-ascii?Q?ugztz16l868wNwRe4OJUc0vG9ZhiumJu/8vTDwVxMRYPRB1T/gF4gU5NqON1?=
 =?us-ascii?Q?MyzNrKVyuM9sZvzJ28PHO5zzfAhkzNKrEFbfk6nKkCBDvtmEYfSoyj6mS6Nw?=
 =?us-ascii?Q?AtzmlHDYTZuOkPIp/D2MDPApS3zFQj3Fbe2EagC7Otm8QDjmvPtlIPmjFLte?=
 =?us-ascii?Q?U6XFcGSzwUl+g1DrpiA1VMfqp9tHlM2hO93nkRU/i/R8A4tzrGqWyyw/8N0D?=
 =?us-ascii?Q?nxsweaxrdfPJlrCJf5WfklC3AOZgq9rE//HqGXsLSObhln/PgDyUvGTto1NG?=
 =?us-ascii?Q?y+A/2Bi+LjBk5KZibnRbxFIFjamZKzC2iupo3vIXeIEd0SRkG0aFw76zqeds?=
 =?us-ascii?Q?Z+fYmK98BQZEI3e1gRHcBust3mY9ShTtdpoxNizOpTYX2l/RIotY42PM/4MX?=
 =?us-ascii?Q?E9FNdDvCh3tnI8ulNMvwyf/PjG1c6TLPjOTs7HIU4tHwHN6IVyolBeYmT6ri?=
 =?us-ascii?Q?Q7EexOcgpVgJWWWP3f+SIwDLtHyC5G6aZ+4w1b940oBQczJ5D+26idc7mYcB?=
 =?us-ascii?Q?AziIxup72uLn7ckVoE4ubqzUfCWlJ9Fbgrrd9mvOrs398lu6RbuLlHt2cP5c?=
 =?us-ascii?Q?qtUV/CLHtrM4kRan0T4ZdsSnKjW9DILNL8i++CpHF/6Wt9dMHhEp1e/gVOFm?=
 =?us-ascii?Q?lQ5nz5K1qohq4Mj7Exn2430sIaq/7A2vVVQpwYASkI8ZmOAP0fjXPZbQzGnb?=
 =?us-ascii?Q?uXTuTb/AUo+FWBSQXG9aGNgvW0Zu9/RJjdJ3URlqfd4AWa5mHnqVEniiDytv?=
 =?us-ascii?Q?ykoWpKxnzYsA/HqK7NPy8c1qyPMogFuiyupDu0cBGGDWijICCALS+3EwRz+o?=
 =?us-ascii?Q?TgqSxFY2Og875XqPG6ZaUV4tNyUQw5qbJGO4pgvGnlVbAfVxbTYkc5MtcUpf?=
 =?us-ascii?Q?0VZ9BCDYdJcwQd//uvy+J0b2h/EhkN/B7sAGAPhB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785638e6-9f9f-4261-b4a5-08dc3850a4c0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:30:19.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2pQao1Sv5twN9yhxGsKodh+4x6vMdvJPzZ7o/aqrpSBOTQXFH60PRrVFq5Tzu4DRSGbslE7b0/uBvUi45W9yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466

As more and more NXP i.MX chips come out, it becomes harder to maintain
ci-hdrc-usb2.yaml if more stuffs like property restrictions are added to
this file. This will separate i.MX parts out of ci-hdrc-usb2.yaml and add
a new schema for NXP ChipIdea USB2 Controller, also add a common schema.

1. Copy common ci-hdrc-usb2.yaml properties to a new shared
   ci-hdrc-usb2-common.yaml schema.
2. Move fsl,* compatible devices and imx spefific properties
   to dedicated binding file ci-hdrc-usb2-imx.yaml.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v6:
 - new patch
Changes in v7:
 - not remove ci-hdrc-usb2.yaml and move imx parts to ci-hdrc-usb2-imx.yaml
---
 .../bindings/usb/ci-hdrc-usb2-common.yaml     | 197 ++++++++++++++++++
 .../bindings/usb/ci-hdrc-usb2-imx.yaml        | 197 ++++++++++++++++++
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 186 -----------------
 3 files changed, 394 insertions(+), 186 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2-common.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-common.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-common.yaml
new file mode 100644
index 000000000000..9f8f2f343dd3
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-common.yaml
@@ -0,0 +1,197 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ci-hdrc-usb2-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: USB2 ChipIdea USB controller Common Properties
+
+maintainers:
+  - Xu Yang <xu.yang_2@nxp.com>
+
+properties:
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
+  dr_mode: true
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+  phy_type: true
+
+  itc-setting:
+    description:
+      interrupt threshold control register control, the setting should be
+      aligned with ITC bits at register USBCMD.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  ahb-burst-config:
+    description:
+      it is vendor dependent, the required value should be aligned with
+      AHBBRST at SBUSCFG, the range is from 0x0 to 0x7. This property is
+      used to change AHB burst configuration, check the chipidea spec for
+      meaning of each value. If this property is not existed, it will use
+      the reset value.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0x7
+
+  tx-burst-size-dword:
+    description:
+      it is vendor dependent, the tx burst size in dword (4 bytes), This
+      register represents the maximum length of a the burst in 32-bit
+      words while moving data from system memory to the USB bus, the value
+      of this property will only take effect if property "ahb-burst-config"
+      is set to 0, if this property is missing the reset default of the
+      hardware implementation will be used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0x20
+
+  rx-burst-size-dword:
+    description:
+      it is vendor dependent, the rx burst size in dword (4 bytes), This
+      register represents the maximum length of a the burst in 32-bit words
+      while moving data from the USB bus to system memory, the value of
+      this property will only take effect if property "ahb-burst-config"
+      is set to 0, if this property is missing the reset default of the
+      hardware implementation will be used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0x20
+
+  extcon:
+    description:
+      Phandles to external connector devices. First phandle should point
+      to external connector, which provide "USB" cable events, the second
+      should point to external connector device, which provide "USB-HOST"
+      cable events. If one of the external connector devices is not
+      required, empty <0> phandle should be specified.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    items:
+      - description: vbus extcon
+      - description: id extcon
+
+  phy-clkgate-delay-us:
+    description:
+      The delay time (us) between putting the PHY into low power mode and
+      gating the PHY clock.
+
+  non-zero-ttctrl-ttha:
+    description:
+      After setting this property, the value of register ttctrl.ttha
+      will be 0x7f; if not, the value will be 0x0, this is the default
+      value. It needs to be very carefully for setting this property, it
+      is recommended that consult with your IC engineer before setting
+      this value.  On the most of chipidea platforms, the "usage_tt" flag
+      at RTL is 0, so this property only affects siTD.
+
+      If this property is not set, the max packet size is 1023 bytes, and
+      if the total of packet size for previous transactions are more than
+      256 bytes, it can't accept any transactions within this frame. The
+      use case is single transaction, but higher frame rate.
+
+      If this property is set, the max packet size is 188 bytes, it can
+      handle more transactions than above case, it can accept transactions
+      until it considers the left room size within frame is less than 188
+      bytes, software needs to make sure it does not send more than 90%
+      maximum_periodic_data_per_frame. The use case is multiple
+      transactions, but less frame rate.
+    type: boolean
+
+  mux-controls:
+    description:
+      The mux control for toggling host/device output of this controller.
+      It's expected that a mux state of 0 indicates device mode and a mux
+      state of 1 indicates host mode.
+    maxItems: 1
+
+  mux-control-names:
+    const: usb_switch
+
+  pinctrl-names:
+    description:
+      Names for optional pin modes in "default", "host", "device".
+      In case of HSIC-mode, "idle" and "active" pin modes are mandatory.
+      In this case, the "idle" state needs to pull down the data and
+      strobe pin and the "active" state needs to pull up the strobe pin.
+    oneOf:
+      - items:
+          - const: idle
+          - const: active
+      - items:
+          - const: default
+          - enum:
+              - host
+              - device
+      - items:
+          - const: default
+
+  pinctrl-0:
+    maxItems: 1
+
+  pinctrl-1:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: usb-phy
+
+  vbus-supply:
+    description: reference to the VBUS regulator.
+
+  usb-phy:
+    description: phandle for the PHY device. Use "phys" instead.
+    maxItems: 1
+    deprecated: true
+
+  port:
+    description:
+      Any connector to the data bus of this controller should be modelled
+      using the OF graph bindings specified, if the "usb-role-switch"
+      property is used.
+    $ref: /schemas/graph.yaml#/properties/port
+
+  reset-gpios:
+    maxItems: 1
+
+dependencies:
+  port: [ usb-role-switch ]
+  mux-controls: [ mux-control-names ]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: usb-hcd.yaml#
+  - $ref: usb-drd.yaml#
+
+additionalProperties: true
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
new file mode 100644
index 000000000000..50494ce06d07
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
@@ -0,0 +1,197 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ci-hdrc-usb2-imx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP USB2 ChipIdea USB controller
+
+maintainers:
+  - Xu Yang <xu.yang_2@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl,imx27-usb
+      - items:
+          - enum:
+              - fsl,imx23-usb
+              - fsl,imx25-usb
+              - fsl,imx28-usb
+              - fsl,imx35-usb
+              - fsl,imx50-usb
+              - fsl,imx51-usb
+              - fsl,imx53-usb
+              - fsl,imx6q-usb
+              - fsl,imx6sl-usb
+              - fsl,imx6sx-usb
+              - fsl,imx6ul-usb
+              - fsl,imx7d-usb
+              - fsl,vf610-usb
+          - const: fsl,imx27-usb
+      - items:
+          - enum:
+              - fsl,imx8dxl-usb
+              - fsl,imx8ulp-usb
+          - const: fsl,imx7ulp-usb
+          - const: fsl,imx6ul-usb
+      - items:
+          - enum:
+              - fsl,imx8mm-usb
+              - fsl,imx8mn-usb
+          - const: fsl,imx7d-usb
+          - const: fsl,imx27-usb
+      - items:
+          - enum:
+              - fsl,imx6sll-usb
+              - fsl,imx7ulp-usb
+          - const: fsl,imx6ul-usb
+          - const: fsl,imx27-usb
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
+  fsl,usbmisc:
+    description:
+      Phandler of non-core register device, with one argument that
+      indicate usb controller index
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to usbmisc node
+          - description: index of usb controller
+
+  fsl,anatop:
+    description: phandle for the anatop node.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  disable-over-current:
+    type: boolean
+    description: disable over current detect
+
+  over-current-active-low:
+    type: boolean
+    description: over current signal polarity is active low
+
+  over-current-active-high:
+    type: boolean
+    description:
+      Over current signal polarity is active high. It's recommended to
+      specify the over current polarity.
+
+  power-active-high:
+    type: boolean
+    description: power signal polarity is active high
+
+  external-vbus-divider:
+    type: boolean
+    description: enables off-chip resistor divider for Vbus
+
+  samsung,picophy-pre-emp-curr-control:
+    description:
+      HS Transmitter Pre-Emphasis Current Control. This signal controls
+      the amount of current sourced to the USB_OTG*_DP and USB_OTG*_DN
+      pins after a J-to-K or K-to-J transition. The range is from 0x0 to
+      0x3, the default value is 0x1. Details can refer to TXPREEMPAMPTUNE0
+      bits of USBNC_n_PHY_CFG1.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0x3
+
+  samsung,picophy-dc-vol-level-adjust:
+    description:
+      HS DC Voltage Level Adjustment. Adjust the high-speed transmitter DC
+      level voltage. The range is from 0x0 to 0xf, the default value is
+      0x3. Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0xf
+
+  fsl,picophy-rise-fall-time-adjust:
+    description:
+      HS Transmitter Rise/Fall Time Adjustment. Adjust the rise/fall times
+      of the high-speed transmitter waveform. It has no unit. The rise/fall
+      time will be increased or decreased by a certain percentage relative
+      to design default time. (0:-10%; 1:design default; 2:+15%; 3:+20%)
+      Details can refer to TXRISETUNE0 bit of USBNC_n_PHY_CFG1.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+    default: 1
+
+  fsl,usbphy:
+    description: phandle of usb phy that connects to the port. Use "phys" instead.
+    $ref: /schemas/types.yaml#/definitions/phandle
+    deprecated: true
+
+allOf:
+  - $ref: ci-hdrc-usb2-common.yaml#
+  - if:
+      properties:
+        phy_type:
+          const: hsic
+      required:
+        - phy_type
+    then:
+      properties:
+        pinctrl-names:
+          items:
+            - const: idle
+            - const: active
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx7d-clock.h>
+
+    usb@30b10000 {
+        compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
+        reg = <0x30b10000 0x200>;
+        interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks IMX7D_USB_CTRL_CLK>;
+        fsl,usbphy = <&usbphynop1>;
+        fsl,usbmisc = <&usbmisc1 0>;
+        phy-clkgate-delay-us = <400>;
+    };
+
+  # Example for HSIC:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx6qdl-clock.h>
+
+    usb@2184400 {
+        compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+        reg = <0x02184400 0x200>;
+        interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks IMX6QDL_CLK_USBOH3>;
+        fsl,usbphy = <&usbphynop1>;
+        fsl,usbmisc = <&usbmisc 2>;
+        phy_type = "hsic";
+        dr_mode = "host";
+        ahb-burst-config = <0x0>;
+        tx-burst-size-dword = <0x10>;
+        rx-burst-size-dword = <0x10>;
+        pinctrl-names = "idle", "active";
+        pinctrl-0 = <&pinctrl_usbh2_idle>;
+        pinctrl-1 = <&pinctrl_usbh2_active>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet@1 {
+            compatible = "usb424,9730";
+            reg = <1>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index 3b56e0edb1c6..9b9b77ad945b 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -15,7 +15,6 @@ properties:
     oneOf:
       - enum:
           - chipidea,usb2
-          - fsl,imx27-usb
           - lsi,zevio-usb
           - nuvoton,npcm750-udc
           - nvidia,tegra20-ehci
@@ -31,40 +30,6 @@ properties:
               - nvidia,tegra124-ehci
               - nvidia,tegra210-ehci
           - const: nvidia,tegra30-ehci
-      - items:
-          - enum:
-              - fsl,imx23-usb
-              - fsl,imx25-usb
-              - fsl,imx28-usb
-              - fsl,imx35-usb
-              - fsl,imx50-usb
-              - fsl,imx51-usb
-              - fsl,imx53-usb
-              - fsl,imx6q-usb
-              - fsl,imx6sl-usb
-              - fsl,imx6sx-usb
-              - fsl,imx6ul-usb
-              - fsl,imx7d-usb
-              - fsl,vf610-usb
-          - const: fsl,imx27-usb
-      - items:
-          - enum:
-              - fsl,imx8dxl-usb
-              - fsl,imx8ulp-usb
-          - const: fsl,imx7ulp-usb
-          - const: fsl,imx6ul-usb
-      - items:
-          - enum:
-              - fsl,imx8mm-usb
-              - fsl,imx8mn-usb
-          - const: fsl,imx7d-usb
-          - const: fsl,imx27-usb
-      - items:
-          - enum:
-              - fsl,imx6sll-usb
-              - fsl,imx7ulp-usb
-          - const: fsl,imx6ul-usb
-          - const: fsl,imx27-usb
       - items:
           - const: xlnx,zynq-usb-2.20a
           - const: chipidea,usb2
@@ -243,84 +208,11 @@ properties:
   vbus-supply:
     description: reference to the VBUS regulator.
 
-  fsl,usbmisc:
-    description:
-      Phandler of non-core register device, with one argument that
-      indicate usb controller index
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      - items:
-          - description: phandle to usbmisc node
-          - description: index of usb controller
-
-  fsl,anatop:
-    description: phandle for the anatop node.
-    $ref: /schemas/types.yaml#/definitions/phandle
-
-  disable-over-current:
-    type: boolean
-    description: disable over current detect
-
-  over-current-active-low:
-    type: boolean
-    description: over current signal polarity is active low
-
-  over-current-active-high:
-    type: boolean
-    description:
-      Over current signal polarity is active high. It's recommended to
-      specify the over current polarity.
-
-  power-active-high:
-    type: boolean
-    description: power signal polarity is active high
-
-  external-vbus-divider:
-    type: boolean
-    description: enables off-chip resistor divider for Vbus
-
-  samsung,picophy-pre-emp-curr-control:
-    description:
-      HS Transmitter Pre-Emphasis Current Control. This signal controls
-      the amount of current sourced to the USB_OTG*_DP and USB_OTG*_DN
-      pins after a J-to-K or K-to-J transition. The range is from 0x0 to
-      0x3, the default value is 0x1. Details can refer to TXPREEMPAMPTUNE0
-      bits of USBNC_n_PHY_CFG1.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0x0
-    maximum: 0x3
-
-  samsung,picophy-dc-vol-level-adjust:
-    description:
-      HS DC Voltage Level Adjustment. Adjust the high-speed transmitter DC
-      level voltage. The range is from 0x0 to 0xf, the default value is
-      0x3. Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0x0
-    maximum: 0xf
-
-  fsl,picophy-rise-fall-time-adjust:
-    description:
-      HS Transmitter Rise/Fall Time Adjustment. Adjust the rise/fall times
-      of the high-speed transmitter waveform. It has no unit. The rise/fall
-      time will be increased or decreased by a certain percentage relative
-      to design default time. (0:-10%; 1:design default; 2:+15%; 3:+20%)
-      Details can refer to TXRISETUNE0 bit of USBNC_n_PHY_CFG1.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0
-    maximum: 3
-    default: 1
-
   usb-phy:
     description: phandle for the PHY device. Use "phys" instead.
     maxItems: 1
     deprecated: true
 
-  fsl,usbphy:
-    description: phandle of usb phy that connects to the port. Use "phys" instead.
-    $ref: /schemas/types.yaml#/definitions/phandle
-    deprecated: true
-
   nvidia,phy:
     description: phandle of usb phy that connects to the port. Use "phys" instead.
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -362,55 +254,6 @@ required:
 allOf:
   - $ref: usb-hcd.yaml#
   - $ref: usb-drd.yaml#
-  - if:
-      properties:
-        phy_type:
-          const: hsic
-      required:
-        - phy_type
-    then:
-      properties:
-        pinctrl-names:
-          items:
-            - const: idle
-            - const: active
-    else:
-      properties:
-        pinctrl-names:
-          minItems: 1
-          maxItems: 2
-          oneOf:
-            - items:
-                - const: default
-                - enum:
-                    - host
-                    - device
-            - items:
-                - const: default
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - chipidea,usb2
-              - lsi,zevio-usb
-              - nuvoton,npcm750-udc
-              - nvidia,tegra20-udc
-              - nvidia,tegra30-udc
-              - nvidia,tegra114-udc
-              - nvidia,tegra124-udc
-              - qcom,ci-hdrc
-              - xlnx,zynq-usb-2.20a
-    then:
-      properties:
-        fsl,usbmisc: false
-        disable-over-current: false
-        over-current-active-low: false
-        over-current-active-high: false
-        power-active-high: false
-        external-vbus-divider: false
-        samsung,picophy-pre-emp-curr-control: false
-        samsung,picophy-dc-vol-level-adjust: false
 
 unevaluatedProperties: false
 
@@ -438,33 +281,4 @@ examples:
         mux-control-names = "usb_switch";
     };
 
-  # Example for HSIC:
-  - |
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/clock/imx6qdl-clock.h>
-
-    usb@2184400 {
-        compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
-        reg = <0x02184400 0x200>;
-        interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
-        clocks = <&clks IMX6QDL_CLK_USBOH3>;
-        fsl,usbphy = <&usbphynop1>;
-        fsl,usbmisc = <&usbmisc 2>;
-        phy_type = "hsic";
-        dr_mode = "host";
-        ahb-burst-config = <0x0>;
-        tx-burst-size-dword = <0x10>;
-        rx-burst-size-dword = <0x10>;
-        pinctrl-names = "idle", "active";
-        pinctrl-0 = <&pinctrl_usbh2_idle>;
-        pinctrl-1 = <&pinctrl_usbh2_active>;
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        ethernet@1 {
-            compatible = "usb424,9730";
-            reg = <1>;
-        };
-    };
-
 ...
-- 
2.34.1


