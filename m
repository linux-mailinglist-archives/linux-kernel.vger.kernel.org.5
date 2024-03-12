Return-Path: <linux-kernel+bounces-100735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6113C879C80
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A1B285333
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A096214264C;
	Tue, 12 Mar 2024 19:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="WMKFZzSe"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2105.outbound.protection.outlook.com [40.107.21.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18513143735;
	Tue, 12 Mar 2024 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273442; cv=fail; b=b6RPujWi/ZMjM1UREieTeK9lJZAEVD3xiVfs6CxoOMdSVMUVlOlizm6MoNOon4RuPdCzt64vql+e1JjzgqHzyriJUaPuzr1Oc8AkpO+hlfomb55EYYuncMgP/wp0QXUwtY0BNDhhpWyw23aShUY35mOPgqoUtnP8HxdeO38iFFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273442; c=relaxed/simple;
	bh=NLtJ1b2mfZERb57uwhB1qFa9L+HhX5shg6cD3bv2xKA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rlyKeMsyb8MejXF61NweYlV96s5HbK/e4Oil4fH9Fi903xHAH5/dLyjQ3lXuyOmjUDckvDegw5QKE+S3LyUrtDHZF+anv2E7c31WDvtzqW5Xnez7pO4n0ExAQcGJ/ptCJdbP5mMJq56O6lwYdOfKbHX8l57rwTe8IStit/VZ+lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=WMKFZzSe; arc=fail smtp.client-ip=40.107.21.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RguWI58d4DmOGEyfpm8Z10dYvS+a6BgdKhvyv3ZZYsTMUpaeieVHZYWlWZrDM0d5Hkytc8X4Mb7/S4fDomAUFQ085TmZxzYNLN8pdFi6QpAa58mjZNmqM1KN10le++J7UbZllSH20E6Fym7U5enZgDIPNirOuV8X+gXnrauZ+2x5kqVz0orEWt9ZkXg2BrK2d3h0WMj7YR3/Vyn2yNGWbVuxr8VZ6XVZAJxP4vTbHnQPNTPRHM7AbswZm40MtI1avv8Nre803oUOzk046jSmBGtSHoVnMwS9Xe9lmo8CTZF9KYUR+gXn0ulUiM20fplRlF1+aoRw6v/vAF31knhQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmYKGzi4mUq+fO0r7wjdyDIXge+HHUaI43XNTCzp+hs=;
 b=AQzXHMZnp05ZB/JK/KXkPY+E3geu0+UREhiVkCwZ33Od07jYej4PlrMSij6Tnltrq+JnO3lBbk3muitMGHC6D/gFxM2xUuy3CN2JIdOo6Wz0Mnmpi0npGXV/StiQ9LSOLMczfyOMaqA+orU7/bM97bgAaUtcV513QlC+KooK0tGPUTz9Eowkyx0Mle1YEjHiCPP5nggYJQc4YVkWn2a7fBtMq/DpqTJNzjOLQspof82mDrr3BUhT8lsR8tOGhqH2wLwDGVs9IKeKlnLXCNR2M5OBxGcM5wCB0wPTZUFCmPmDyWlCaXDRIX52/YMIp3vugg6NRKgHYIBr3sWnmERFwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmYKGzi4mUq+fO0r7wjdyDIXge+HHUaI43XNTCzp+hs=;
 b=WMKFZzSer+qzZDpIeXysjEPViXvs9/bN39yySEmnsgNthYlZezEU+Lptn6/l9E/DhIyGj6SHyLsBg/tlkrOlHjgSQK9odSXddrlK0RyeIWAGjBVHIdf9V3jNJfAlHSmpgJOGb2cdFBS3V+TT4o1WBLdMX7aDFatj2Pla3MfUyXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM9PR04MB8601.eurprd04.prod.outlook.com (2603:10a6:20b:438::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 19:57:13 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 19:57:13 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 12 Mar 2024 20:56:55 +0100
Subject: [PATCH 2/2] arm64: dts: fsl-lx2162a-clearfog: add alias for i2c
 bus iic6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240312-lx2162-rtc-v1-2-1f4cd431b1cf@solid-run.com>
References: <20240312-lx2162-rtc-v1-0-1f4cd431b1cf@solid-run.com>
In-Reply-To: <20240312-lx2162-rtc-v1-0-1f4cd431b1cf@solid-run.com>
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::13) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AM9PR04MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 776f0158-cb5f-4f81-5ce4-08dc42ce9c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0xEvQDePnIvDTOgzdsuelZKTI9S6HHubAxkQx1tJoeYTdFsYNo9xK5u1+uj5a68LyOCnjN7KRJlplnRy9+WPEQrnXLGfEGBJMy7C533OV2br4PMmsFqhH9J8VlAbYfPnyz32JMMLVeJX/5N+BF9XlTlMJBUbNDkhccjCjxKdV1WeN47VVOi8/SqukI3nEW32TSFQgOgMtlbh3Do3oVvemTcjxq20yr4/vTseYpW1dobzz/JIkd3kPxmHwngHKqpA9jQcNocc7bNhY9Tr3Jozic37mUPRyBa3WHf5oB0sdV1BKbUFM0vxA+SZHTSslADqxl5wc7D5JcAEEpkboze0Yq3UAzGDHMEGdyoDvQEIivwBlNgwjD3kwHRBUPk/xY1qm4HfM6Tqh71mzlfmDrKyCBWb1hAS8N+z4OZ/tnIqoSU6CqVWog3YVPcdGYRxBv+4/yMKJOu2iIHA56g0vtJ/cOQjiCQFaYsxBpiBbGCoEUYeJHW19A3dlxdvx2hZG9YSZVAoK7JpT3yJKBSQRUEo7QDxgHhaIrp1r6xuTDpHMa1n9pb3DFf/vIuu2oozBAI606KniyhRI9Ux14mtUgAmVQ4bHJoqGIcQZjuQ9/1yDXL07TNuqh+9bMxpgViz5LwATguQGbHq+/e5tUtlmC2oRh3wiT/oKO+RHzFqSAmFp201CTYNeeipA+sqP+19joNt6H3p2rj8tZNoOayChRqwPwjsqFRaupgGtUXsKeyBDgs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0g1KzF1c09qV3Q2Ni9EREdHQ3RTMHZKLzNzcktaYmVFZW4zZWFUZTlBdzMx?=
 =?utf-8?B?T1dLbGxlajNqQWJzeisxc05SRmxJL2FFeTByUVFRR1dvckFCeWQ4STZDUzZn?=
 =?utf-8?B?NFYzZzZxSml6MEg2bFltYURzMDA4YlhhSElYMURvMTFSZWFZVVZDQ0dBcDNs?=
 =?utf-8?B?TkgvWnNGSm8yMGJvTFEyNVBVdDRsc0xuZUx1WGpPYUowdStMQUZKdTYzNUth?=
 =?utf-8?B?M3lNTzQxVkxIOUc5RXltWEFUbGF0K0s4VXQzMDA3RWRUOWh0bHNwVVBPdnFC?=
 =?utf-8?B?VDJKUHVYVktwVWpTV3YzVHcwbWZnWE5pY0lsbnFKZFQxS29KTWxnOGpwMTFl?=
 =?utf-8?B?dHFOdWswUXZkOUZydDVhMk9ML3BnMFlYSHFHUzBLV0R0cTB4N0hRWU43VE15?=
 =?utf-8?B?WWFUUVE3MHFUUEVUZ0Q0ci9hdVV6b2UxWUl1Y3lRNkkxcW1hditHRFJoN3lD?=
 =?utf-8?B?UlRtSzdDSXdDaHFaWXNVQy9VditXOVIrY2UzSXlDWG1reTFHUGFGUUN2anJN?=
 =?utf-8?B?Y3RWKzFlbHNaeVBNY1JSK0JRcTFqbDd3TDZ4ZDczdUFicVdodlZTNCtxUGsw?=
 =?utf-8?B?Q0VjRmp1cENkQWZMZ3paMHRhUVVrNklYUmZLWTJ5OFlKUlphSldZNGsySzdN?=
 =?utf-8?B?NHd6NUhmM2JpZjh5alZsRDdUcVZjSHEvbnF0ZU9ZVDg3TXBqVTNWUUkxaktZ?=
 =?utf-8?B?MXpNems5Mi9HS0lQUmdHemthRXh0My9iNjFRZmtNcmZpTStCekxHSFZRVzQ1?=
 =?utf-8?B?blBxREJYbkRpL1lMWDhCOEVldXNPMkp4N3RXVzFLVU5ZT1p1dGpvMXNOQVBF?=
 =?utf-8?B?blBqUUR1dlVvN1ViZSt1dDJEdzlQOThHd2VsdkhHV0NneUpud3IvbXZSRkdv?=
 =?utf-8?B?Z1JTYmRuT3J0SHRqUlViVGZDWHMxbEhNcEN5YUszQWhPZFFrNCtHaHBNeDVS?=
 =?utf-8?B?Z2tRcVpPaEZGK0w1eVFnbzAvckN5SVNkQ0M3dDF3cHM0SkRMdWZOdm1leEZv?=
 =?utf-8?B?STNYNVI4QTI5ODhBWXI4azdiV29CZ215VWxHOXJFaHNnL2FLd3FZb2tENTkw?=
 =?utf-8?B?K3pTT2NnUjVEMzJaWEkyOUVhVkdmV0ZFMzZUWkpnZFdkYmtMY2hiSGc0bHJp?=
 =?utf-8?B?TDRYbU1jZ0tjYitrdE1ZVnU3TG1GOEJhNjlrb1ZHQjhhc2o5RUp6bEJPOHkw?=
 =?utf-8?B?T2RKZ2RDRzU2Nll3YmkvYmVMV3NVYysxY0liajQ3ZVVYTk1GaEYxcGdjb3lo?=
 =?utf-8?B?NDUzSXZDUW91WGZUL0VZYk9USDIrQmZpRi9oZ3o1QTZKc0k2bGNqN0lxcWI2?=
 =?utf-8?B?T0IvQU8vd3Vnc3doNmtiUkJQNmtpYndwNHo4Z05HYVBoRzVocDFZM0pFMlda?=
 =?utf-8?B?V3FtSzFyVTBNMUFxNVZPYXQ1VlBIRm9Mdi9aZlRpQjVyeEhzMFlWZmk3QktS?=
 =?utf-8?B?L2tnZ04wUFpHWjVjcksxZ1luVTlsYld5SnVvWjhjN1pMV1FxYWZBeDBPUFh6?=
 =?utf-8?B?QnFFcjVubkY1NWJYL0ZHRFZWYmwrVGVzVFFKS1l2Vk10UEpiLzl1Skora242?=
 =?utf-8?B?dmZvUVVvdTJ0bE55dGRoZmZPYUd0cFVBM2hoRk8zQzZGV2M3dXdkRHJJVkJm?=
 =?utf-8?B?NVBqY2FNeTB5UitoeTBGeTF5eFI1QmJQSEhrRGloUmlZMWQ0SEQ0R2tsMi9Q?=
 =?utf-8?B?QjNhejdGUzBCcEJkMC96aTlqc1ZRMDV0eDY2eUpQMXNDaVhPdTVZZjh5Q2M2?=
 =?utf-8?B?V0lveXZXQ0x6d29VVlBtdXI1R0N6OWh6dDk1TlBzYXFJc1h3T3QwV1RoZFlm?=
 =?utf-8?B?UFMxalZJeGVPNWk0R0p3SGRnQjVXa1ZWYWc1TUF4T3BJcGFzMnMwa3l0Q0RQ?=
 =?utf-8?B?SWVKUmJxQzl4Mnc5NzJMb2xkNkRRdW9DNGl4ZGtyZzJwUDZWTnhEd25vOW0y?=
 =?utf-8?B?R201OXlDZmphTTFud09oOFRSWDFFeGthSy9DZlprMXRUMEFNSC91MUVPZGFD?=
 =?utf-8?B?N0xoWW9hbkJZang0R2JrYjNmN2h4eG1JMW5JQVduR0NSZDVhWk14aXlBblRm?=
 =?utf-8?B?cFI0dGMzTW9OUEJjVmNZSDhvZEpCVjZybkNoUXpHZGErT1FaZUV1ZmxRS0Zl?=
 =?utf-8?Q?WyJHnjmo8snUeuWAYNbwgsEJx?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776f0158-cb5f-4f81-5ce4-08dc42ce9c20
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 19:57:13.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avcuwJ8M+WooZ6c/93/IxlNtpa1CZ3587WAFnaQlneK/WYhGRUXwhPHxLQoN5mUtf85AKLNfwq4vN5YJzR/SlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8601

SoM dts has enabled  i2c bus IIC6 (dts i2c5), but defines no aliases.

LX2162A Clearfog dts has aliases for all i2c buses to ensure predictable
numbering for userspace. Add an additional alias for this extra bus.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
index 9f88583aa25e..eafef8718a0f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
@@ -25,6 +25,7 @@ aliases {
 		i2c7 = &mpcie1_i2c;
 		i2c8 = &mpcie0_i2c;
 		i2c9 = &pcieclk_i2c;
+		i2c10 = &i2c5;
 		mmc0 = &esdhc0;
 		mmc1 = &esdhc1;
 		serial0 = &uart0;

-- 
2.35.3


