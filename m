Return-Path: <linux-kernel+bounces-84912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A156486AD9B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A221F2B978
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC8B149007;
	Wed, 28 Feb 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="evjudKE3"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2041.outbound.protection.outlook.com [40.107.14.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F7146015;
	Wed, 28 Feb 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119830; cv=fail; b=jWHzoz9onjEA+0ijHhUsYaFkE+TD0YtEXuNYTXM963Qsl+Jl2nz2jt1+98Bbe9KCkmhjpB+tzzd49bjw7MSrhj08VQjkxxofGWzfJdxRyC6QXVb1bl3v/fSgbjq0hwDjWhydklWO5SwBzEF7/mKqEAcdLCrnr9aG/J1dGiQND94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119830; c=relaxed/simple;
	bh=tHdbKUI5jQLpQt8UCD8B60F32XF6NDc2c6OQijjsxxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZGjRd3KGAmLU2s1hpXV1b0WN4/Z4sJQBXqU2MaM+e29J8uJSmrtx6TTOday9jqwnYJHOgvzA58fTb/13BoYQVRmZUliqdfCbsiGEoTQM1//CXUDdVK7VIj3/FTbHY6reWR5QWFgAZDuaQhk1tUXHlQOEXJen8zofXLyu7oeIB2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=evjudKE3; arc=fail smtp.client-ip=40.107.14.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsjVfCgLUEU9K83ynuCBK/9o0kXQs6TKIZVzuNNnxOKQgp7MhMo9DQVOMFIWeUrEqWJLgHMzpR6PHECj5nJ0QuG00kj0VAHvy2AswJinmI78eJFSt7U7sOIn8eglK76CRo2HrdpB9nSD5+h7LkVW8p40NRQnTdoW9ECAatZNdzv8sm4yrG18qXXzo014HkbN9EuPZgHLIdHEYkiAZo++WZrsISAnlsxngF/wYml2ydy20ZPvfbdRyhgirRXkxBqpHD5qpI0on3YTi0tDvnR7epZn1aPNcTcUTpy3rMBZYYxIeG6kYu0Fq99vkdqQDkVow177oXpvCASsjnmA+eGyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxYc5zCmVVzdem2J6287e7PIDGHcqtlIg6NDNRpbl4o=;
 b=mLdeAz0TwZJCKoG6LukjnPcITS5jPvCI6GpwYVm3QqyrUe3PYg6OOcMI4HDpE4oHJJjJ6dFN0G1FaPgr03hmGlLZAnLtbfVdaas+piC9aLnFLuQ2agVg62GAK/lEzw0GcfFx6yp9HjBVNF+mpwQhxq+3H1BxPuVjIZ7tDZkcA1nnSSUvjyHrdqlCkXz7jP1zI++utrCgrG7PxT54Bx4YgnfseFCG02DLtOxlJ00zmFVSSeAVkNmnL0C/Vc3aeP/PmVdwlMhwF4CZwTCB7cuBJx+tScfeZcmJUDknaOEvGDIpfs7V90XjMkthRquToL359AV8u3a+4VkpAa7O+eLpMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxYc5zCmVVzdem2J6287e7PIDGHcqtlIg6NDNRpbl4o=;
 b=evjudKE3otwjlQhtZLm9YeVtruD8G5/d4+VFtm83YxwKXXw8zHBfbs/1BAAMxfbjbTjtck/3yjtoaM9Yan16Vtrv0sEi6ui2YuQoqjYadnh2l/sNbjE4VAKV0sICzkr/Ov7BKW2hE+tafNbgvHZOn+uITfj/X9LYtdHJFWD3mGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 11:30:24 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 11:30:24 +0000
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
Subject: [PATCH v7 05/11] dt-bindings: usb: ci-hdrc-usb2-imx: add restrictions for reg, interrupts, clock and clock-names properties
Date: Wed, 28 Feb 2024 19:29:58 +0800
Message-Id: <20240228113004.918205-5-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 043d5f47-04ad-4bc5-cb0c-08dc3850a7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RP/Z0ksTqiZJg23rxm9Z1IdHEMRbWMoig2mcsYDVkl1J4napLfhDtrN9pYMhd87TvkSaoBmwi/YywJRg3zZCi+3+SnPTq4gR6yE7PTxW1mUsQ9MicCzHCNdMEL9IpAhTrw3xqf8NItDnRVBM9xGBVrZEs9xDfc+y7V4j5X9XNBdmxBu5cT+iXHlOdTne7Oa4HbsC7u/MHO5JZNIj5c/yl7/BnAO8VxL3YYakCRxvyMsyB+PC7fAaHsBLVe1pW7lYyJBG0XhhDXq4SyFkTms9ILYynXWKtRh0+vG1yg7cVi7oQPrncsbLXW+ntssgH/AvsTjIZU2X6jplEO63ZP0t47a5rWOrxV8HurvcdYCbjUklTZ4O4mmkJJ5/en/gSp3QIMLiibdy1ZIoxsaTQ8YzG0nY6F4d7ZS6uDXpboZCcbS8mskacfcBWBbS9RKp2sjABo45kS0zt/g1/j1xJ70fS1Urz8onf4w33/IwVy0uEcJGeq2pBBz2GzoCLM5U99p2WUTLKHutWtyvzj04al/uMQELcLmUg0defkP0uMbPYAaUf4xYgMGEtlT0RLpJZkJvhEM6fAEt7fP6DaP6PkjRHWf2AEI7g1sNg/C7VNcRQTfZQeb2CGpQJTrQ/LW0Wh+09gaG3pcV0Y9NZubxTWSD6Wplz6GSXCtMfwt1vRzGGWUKY9K9VNq7tWaG+kdC7y+g2Cee390mbEVTdOVw7lTY4JlOHaUx/C0ngPFSZmupKqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/kXwmRjtBc513pLDPfqqpqt1IlLIGkqGra8u6dgOmUY1P+IJBY1feFidFZ8o?=
 =?us-ascii?Q?vKXJTAoWTYr9LYZS/FPY+jZf2V/XLtU+0gC9YBFWTI7DR3kTljffRtM5a5Oe?=
 =?us-ascii?Q?NG+78kwLCNwZTHXAQjec5rjrUT85M1CN/jt2+vSFVu5/4m2BowotV3AeXBgh?=
 =?us-ascii?Q?8K/wKzjo7ZfD1XW19E4nNm5zbTl8LFg8EBHx+FKyRmPRgme0M6ylMa3DaFMW?=
 =?us-ascii?Q?QlvlXvIj9vbShs9hm+DLtC78gCGIRzsziNS5uIz8qBVlUHOjKhcQF9ozNVlg?=
 =?us-ascii?Q?5mYPHVC16lMrFlQCyJR6oMN6cDI/+wyvPN/1wwpWysyMaGHrsFfSP9JF9ARz?=
 =?us-ascii?Q?MnEK+Itz+vtSDVx2VRF8qU8eq4/rLPTpYFV7zXSqcr9T++RsJQpS8cgakP0S?=
 =?us-ascii?Q?VaWxyHiiz6JkWYnn07e/PWvn64N67u9VT9zBD/65X3ZfJtvQyFHqzgMdjW9x?=
 =?us-ascii?Q?0DKfWHbWSM5qMhbCqI388ht1Ve+zGd39cpWz5bKpzLYN/MDnlyE68oVFaQpi?=
 =?us-ascii?Q?rwsUugdESaSyB/D4CvCJ/j6cD8A7/porBZ6P9aTAKQnqPkUBdemDCDiv7Ixv?=
 =?us-ascii?Q?k0Q0R14lbAPxykSZ97CVOKuIzkvhw9rqs19a66wj/Tdmobss63n7ydBufi6Z?=
 =?us-ascii?Q?YA6MfJKplW0aNqNPwlACVe+tj1Iiy9ke629U5XgP+OzqQl+J7foexexpG8IS?=
 =?us-ascii?Q?Eysh+9AvWfNeoijk3MAA4hG2pvkic4R3nvNHfr+vf8k0US5QzXUO3QvZoSCs?=
 =?us-ascii?Q?Z8TWBVziArVufRDukGvNL6KoEHU0ZVbVq8zAUI5m41QwiHRu5XQHZYJoCthG?=
 =?us-ascii?Q?MIAGrmvaLIkYKqmI3e+WqYwRZZglFrddnL4lRvjKw4fEn52jmgmackDPVuN0?=
 =?us-ascii?Q?pNwia/EcKauI2pkvipwUXBI/Hd6DxBDVI9wIRyCLTzKnr2GHvcH95+2Cpf0Z?=
 =?us-ascii?Q?hLO+Yg01kFVBA+XthEyA5CyvloWPQxWWlN0Ais8Tmd51RfSnI5xBQRdX737+?=
 =?us-ascii?Q?OWbpzBGuoAchHaswOqZajP2ewzenBWQV+yRNfY26m7X9oVM1m04yuRI+byA1?=
 =?us-ascii?Q?HrXaRTfbERaSok0H5YluGM2kQDhs8fBomDPZ0iq7GB27IbI/f14IJttUrJEE?=
 =?us-ascii?Q?zYJDKwJPett6SRqx9I4kb6gHSootdq4uHnHufL5RGOr0kFtpZoUsxbatkn6u?=
 =?us-ascii?Q?00VSR83D0ZVB2dumfdwcHGu6RnGcSc7RACNIaN3bEB0PRFmk82hi72vxxqi1?=
 =?us-ascii?Q?PJNSIW5F7btQJBmmq1B/F2GaSPdxgkzDS03cprQn3vqPabsTnwZiFAgwiCYk?=
 =?us-ascii?Q?djUo3JEJdhB7N/65uJOKpr0p3eF/bqyi6/nzgMoYa+gK3U4ecv1XL5hZTvW6?=
 =?us-ascii?Q?jkX3WYApOLxdVSX8QNrutV+/i4e2F18w0snzPl5C8ESVqtfvgtU3X5otFBjo?=
 =?us-ascii?Q?6ixJAPvuOo/08NA3YDhMBIkzHLWW2PjmTmjt9F6MDnLgEv+TMi7rMDpDpEkI?=
 =?us-ascii?Q?jooHagyT7zoV7aNs3393HHDw8Dbdu9T5GR3DOSakeTHRdWFWTL36uI/hspem?=
 =?us-ascii?Q?8ztiJz8yoFCDiA4s9/DwTeTshukqtpEwalxj0M8X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043d5f47-04ad-4bc5-cb0c-08dc3850a7d9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:30:24.6026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGxslKlfEXg+qUeJCxUjnyDy1FMnJyN1jhKkvWOUw+x+5MuuRrSRQOUULvaTLEXz13JMyufF7yqo7e9nKIhN5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466

Add restrictions for reg, interrupts, clock and clock-names properties
for imx Socs.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - new patch since v3's discussion
 - split the reg, interrupts, clock and clock-names properties into
   common part and device-specific
Changes in v5:
 - keep common property unchanged
 - make if-then more readable
 - remove non imx part
Changes in v6:
 - new patch based on ci-hdrc-usb2-imx.yaml
Changes in v7:
 - no changes
---
 .../bindings/usb/ci-hdrc-usb2-imx.yaml        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
index 50494ce06d07..a4730a2393e6 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
@@ -49,6 +49,12 @@ properties:
           - const: fsl,imx6ul-usb
           - const: fsl,imx27-usb
 
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
   clocks:
     minItems: 1
     maxItems: 3
@@ -145,8 +151,54 @@ allOf:
             - const: idle
             - const: active
 
+  # imx27 Soc needs three clocks
+  - if:
+      properties:
+        compatible:
+          const: fsl,imx27-usb
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: ipg
+            - const: ahb
+            - const: per
+    else:
+      # imx25 and imx35 Soc need three clocks
+      if:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - fsl,imx25-usb
+                - fsl,imx35-usb
+      then:
+        properties:
+          clocks:
+            minItems: 3
+            maxItems: 3
+          clock-names:
+            items:
+              - const: ipg
+              - const: ahb
+              - const: per
+      else:
+        # other imx Socs only need one clock
+        properties:
+          clocks:
+            minItems: 1
+            maxItems: 1
+          clock-names:
+            minItems: 1
+            maxItems: 1
+
 required:
   - compatible
+  - reg
+  - interrupts
 
 unevaluatedProperties: false
 
-- 
2.34.1


