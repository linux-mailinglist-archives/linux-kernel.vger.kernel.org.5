Return-Path: <linux-kernel+bounces-74170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 208E885D0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84E6282B45
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB10F3B791;
	Wed, 21 Feb 2024 06:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G61f3/3y"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECF43A26E;
	Wed, 21 Feb 2024 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498320; cv=fail; b=sTKKS+Vy7IBpozhli6EyCKnZYp2c45yBBIq4CiHsY/WVHf9c3LSBehv76V1kynjKlYbexs50ulJ+VC0N+oP4ZiW6VgtJuAkNTtyLQQ7bVVjs1BjKW183SKplXLayIluAkY6DnuPGv23xxFwjbM1o/AqeOds3ErrBeR+0TBon420=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498320; c=relaxed/simple;
	bh=WHEn0kFo6K+a/0iGnhQiuooMIGSbmpKtktXaRVHR6xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GX+QPdWAegRH87P+SFETmD8xKI2+1E7sGIZ5EXm3iZRqly34nn9NFq036F+vvGPbHqPwz85zf38VgbFrr0g16HbmokR1fYXt0nButEzLdlfUqEb3QAte6d0yPAhlC3bg0ACaZYswl5Joohjn+mcMBXUN5ISvfK7q06dIG/wmJGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=G61f3/3y; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKx4fFWWgzjOEy/rtUSwtX4VHj8Re6T+A3yL7Y1VzBpLmIrlo1qqrGZw27JciKY3CRma3x60yxVyPr8xeCokcF+G0Lx8yBEIl565c9f7h5iUj4hXho3UMbPGJm3kdjGO/tp7Cy97zbRyOyKo4KFlfWmDv6+LjD52TLcqtjkuKV3v++FyrQD/xKKVj5G+bmmuAUakB8Jn6TfCChaVvX09DHXbCza0m3md8voP+YAjd6K3Q/FOTZekU1w9/3D9ovXb96mIk6mtbDdnH5VOndq1M0KbNsAnUVC22mDMaOko54MuSjBIa9XoxesPXddlVfTrnSrpYFkVQQhvotdhzD4o1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkKIFr7sFhI248q5m3aGpcxjKLrVv25prkH9EcL/3Fc=;
 b=AmPTh0Q6th8L56OEL4yFKvIQe2pvynktU+EuQxldEBwjvGOvUVsYQ8GI96OOiL7g9tuXRHaHaai7aCe5zi5Zi/xywa5LBaKfhcapWUJIOaFIbTTuwv02iG/OCsDd90H4hlh3StdXFCJdo8GHgxvS5EivhOBVF98dkLG78PwuBM9bQXEiXNt7fGEtxltdREEFTploHNBD9EC2tEJDkltRNnAmU/Ss2QEI6plks7NRNWifCMmbSaNbhmYv/RGAM8h7kYL1CZ9N4e1WJDBTqohzDoMgz3cYx/ip/L8ivfbZoidWkpm3VcEGIiSOZpCInaqY61pOOrdw9FI/vkOSJgDH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkKIFr7sFhI248q5m3aGpcxjKLrVv25prkH9EcL/3Fc=;
 b=G61f3/3y0yrOshkxW9LllQGsiqiW/0MeLWcILgk+EqZNVDukPtMwCNN0AUjfH/L/mGMfCpzcYrtz6fiV29GIW3lccK8j4C1XNJZWUG0CuUthRThs162YdXSpZwnP+GVzHlYJ/64S+tTCkd1C49CIYdMVqJbRNxpern7u0bVZxUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 06:51:55 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 06:51:55 +0000
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
Subject: [PATCH v6 5/9] dt-bindings: usb: ci-hdrc-usb2-imx: add restrictions for reg, interrupts, clock and clock-names properties
Date: Wed, 21 Feb 2024 22:58:42 +0800
Message-Id: <20240221145846.1611627-5-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221145846.1611627-1-xu.yang_2@nxp.com>
References: <20240221145846.1611627-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b3dbfb-8c25-456e-61e8-08dc32a99716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vV7xNuueqDLYwwhR27jVQXtfTgwj14cVExKRT5umlkfS/uWil6x37RWmFIRC9Z7a9iT7RSq92pCrdbmX9oJu4hOzUMJP2Xp6frJiMnr2tpxtvfyihTG3TRtjiULTGCPVSsr7ilMZhwR0GPqxA8T1zkVWpos0EL1r/m9NJ0QaILWg+a3ZVvEcOULxmCM/jxF1/oJT1EGK6Fi+IQZkh2sa7ZNDJ8F/vuqa4R2E9oTlD+SOWAuxBZQbf02rmoKvqEhUflhFQzZz0pLLe33w+nEQ/vQdvl15Vrx6K3gMJBGMZruSBu5zusul3ZkeYwNQ1QAj8jBznVs04EzrFeVT7SFzCCTTGW7Xzvx/k8f/RGXoH+bDDiAjDCi5JHIlHZ2CTC7uXpz6GPguyXt9gwVmxKiMat1q7m6IihmR35ztBYu3bQ5E8aJwPh+wJzQ6OhMxlBCV158dkxhpNMR9tLEuX44JvyvqdZyUPKYMw1yMyBcZfAtuEovEc7wJ62+2gB1QQ7qiToxlXvGfapaR+k4H1Uf4xTbqzH5yR1Y9XUSJIer/6CRiAaILVqgJQ4aXSe38gOntR8Rk1xHmEk1nXjjAOukHy0TxMpOUz1Jvpyyh5LBvx/41wQ8HqT7RZMlH/ARrJdOv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0AiKq7PoW24y+FC/3D1u/fVvFTxUzlH95PCyRqKwScn5Ahk/af4KstGyLQsh?=
 =?us-ascii?Q?Ia+WsLJ6hecWQ67BoqwYXJFSAFY4Ros/f33aNin14tLrxort1ptzqNz3AIKi?=
 =?us-ascii?Q?1oONlV2T2pAfLPEmRjtlVZ2GIRuln+h4LF5VyvI/n9V6m7HKG0wfBjA43zEZ?=
 =?us-ascii?Q?er0HFWQI+0HCC505gNuo3I3/THrmlv6nBramYmqxI1BE4srFf3dgoHFzNSlf?=
 =?us-ascii?Q?yJ/BC6Me3CtfTvatRWALt8O+pwDb07itgRh5Dfi/XDYOX5RzzllZSVxnjYj4?=
 =?us-ascii?Q?+atba9TJ9uhaCe4vJzBOW1+Fig1B3fdmyKI9fEmJUuvWOlm6os+jFOmq4Pr9?=
 =?us-ascii?Q?RLhYNBeN3K8mckIgYqIGI4beroPMRzQtwrhE+reMzEBTc5guIDy/5o1fXL53?=
 =?us-ascii?Q?L3QugmrsUdtrZ+wb4e6dXpExsh3pEK/zUpWbRk1VRIqEm1NAcm2YfkwqEHP6?=
 =?us-ascii?Q?motIBS9fhI7tFQneXv4Vq1K0XuHac10t5d6vPEQaT32z1IkCGt7cjGX8tYPl?=
 =?us-ascii?Q?IVrgz+CPWwOxw6HTiOXtfYEygjTqBZG6YzySzGByK47X2b1CY1fV+wez9J1n?=
 =?us-ascii?Q?WQI5AEEcl1vOjNQ3Bdqwunnuc6szfPLdwt3e+DtURkWOpalsWih/79uptfKk?=
 =?us-ascii?Q?VGO3KvVsFNfOb1WkHDXCCoUlj66IeU2P+kegWb+nfTfb/8L/H1V1vNpEbi5q?=
 =?us-ascii?Q?hjoOxX6H5KsJyoR8sxEWcHtRrq6oBapFxV7Q3iIJpH2gZU5fI8Yy6Qt0iIyT?=
 =?us-ascii?Q?3nudbGDmYrTZn8Z+W6TeFUW7ANHRLac0pYK0AOJr7UfSOWePEQBXChRIOoy6?=
 =?us-ascii?Q?qVtI80WU/FTgM2uwHq82uBxrPcHAUiFGviC/Ht3I45HlkcnmlaP3AAaseL7r?=
 =?us-ascii?Q?yN5aMcYd1BK8U5baRrw70ofse+26pXDRSMgGwoq3JzMskmhVruTq4V9m6cyU?=
 =?us-ascii?Q?1eyo+UnXTs2pBIjdLEB6/RKiaIUoFANwaDrrZdegiM56vjtvcyjB1hpHXDAQ?=
 =?us-ascii?Q?3fQKvb0Y0hFrMaBw+raBZVQxPCG2G0BKWNoPddLl7VXMTvZ8kd1l8KvHAAFD?=
 =?us-ascii?Q?eW0LQNwG0wdnaJZfrQe1rkhZoFLQ5i6VzrQPYWjcS2hZLwucQOSIS+XqXqQe?=
 =?us-ascii?Q?iWZTRVxMjHxq4/XBFy7p5hmREHtkS3oOpPGtSOWEdz5RGwJ8bFjRGcAxmj1T?=
 =?us-ascii?Q?N1z4jKcYCB8fEeFdIG0iyrZ99REPhpgH17xaK2s4idElNFbmN+8m0ngWWiyP?=
 =?us-ascii?Q?JuIlDN5LqLNPTD4hBa2M1LcgZMY2lhyi0/Kas1oEupd/xDqKPBkgpMUTn3W0?=
 =?us-ascii?Q?JFHlwJDmYnW/D16nFl7WTtI66Q2JwVhVc3Epm/N3Hrw/RwV3UNhQaUGO2Pji?=
 =?us-ascii?Q?fGhBdYNmbyVVknYeJ9R9WTUZ4U1Rghxbawyyt0b0O5yK3kOKluk/FH6X0rFp?=
 =?us-ascii?Q?qYU/ydbC0nLwEg1/v1TsYi4WGLFJEKZIJXpFTVwu1mOD5ZnGT93FoO50mbWh?=
 =?us-ascii?Q?x3AIxYIv3Q1gOEaJ4U9ezG27qWaK1B9zY5+CHvNamgaH0W570WiLRDxu/AF9?=
 =?us-ascii?Q?fBO8YybcMh/Ox7v68/1l7rU5KIbUw4+E05atewD+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b3dbfb-8c25-456e-61e8-08dc32a99716
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 06:51:54.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpU0G7UEY6wp6Anwq2kqUidAxaNQoZ9UOSUq/H0f8HzshTRrtETrPJblN4bDAlxIYowqbLWUb1AasL0VAzELrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304

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
---
 .../bindings/usb/ci-hdrc-usb2-imx.yaml        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
index 2ec62f564bf5..20bb048938ff 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
@@ -49,11 +49,63 @@ properties:
           - const: fsl,imx6ul-usb
           - const: fsl,imx27-usb
 
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
 allOf:
   - $ref: ci-hdrc-usb2.yaml#
 
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


