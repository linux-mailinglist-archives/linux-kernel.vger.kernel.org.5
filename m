Return-Path: <linux-kernel+bounces-91712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F327871593
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A93B2474C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF83E7FBBE;
	Tue,  5 Mar 2024 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="X81DUIu/"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2109.outbound.protection.outlook.com [40.107.247.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84F7F478;
	Tue,  5 Mar 2024 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709618129; cv=fail; b=LlDl+ulDvqcAqeDAd4skRMcOeDBTs9VVjCsdHUAOEQz4lGunqfatSyUA8rUuZzAFEuqNkl3jTgqCSBbCtvhFEAG9vtk7wt2ir6Iv//IStpeHEdcik01CmGxkp7IBLs0cb1AnvjQYtB6NGllEuIvKMjKyS202an/7rkbORVLY2LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709618129; c=relaxed/simple;
	bh=aK/tqoGoFX3bOzP7we28NQCLoIDGur9v/pKHCEPg6Ug=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hoWBNB6OY9mhdq24yjsCW0KOz9NDDBZKYBYrHDtDFkJcZN+ljYl6ERw9/J5hAv11OGKtUUxQMCOUbTv8ka4dnK4/T21jEg0e7PhQ0P2jQihIlkaOLwxYVVBy0piL6zW9xCMtRh0ODJDR6iQ4DWwuPc/kskBxBsmByMNOKWji2fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=X81DUIu/; arc=fail smtp.client-ip=40.107.247.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9fiFL9JayeCOLhZg9ZS1zxg6lVY2rSv/P+5pm66wsS8eA1Pvs9h4VW1PJG26fv9tEhLTdCkYHV9cBjhS7VLzFJcoUSU4iw1b4iClS6IbE8iaUr6Vst4npyIRR1ZQlg6WWrXz06nx3Nf+GtDtEytkGymw3VNxBDaN52WO3TCaQAHtAC4tejoL5hF/18WERXlsHyY8DhEoAzmi0KM+rGiQAnh45XNcESWDdbbQQVojFhDvnFmF0ACRK5HU72XMyMi1AGrNeH2Bwq7Ml/ttVGXvQ0tL49Q/z4Gyc28nIOdJg1nISDO4PTaRMNNoJDgzY7H/gfjWGYTlQkIwuHPkFAdrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1eIx71K4MMtP7thaSHv2tS7Es3S7FuRoV0yOAolBjU=;
 b=nqitDVVRMyr/kGdOSIxHyMUkZ8AkYYyGmQOwRgguH0TOshXBdDcd66hnTcfY7duA9tTZC+IZus4EXES/TG5QZ+QFbKZjZ5Nkv6GG6r11XzpzTM9ujlRUAvK1R0q43EMSKIStaKlQDuJQ3PEfI/zIcaskAn+QJ4a1zdaiSGmuKgehhiVndyzYfNZ2FkYnz6/BDo8sxphK/97FLRfqPzwwZFMTW90V+ffZ09I+A/hZ3Iz5cr2MeTJ2dZMvAfzKh3dGTH8Q6kgdW6/WS1a/Mj4tCzt/dGYfJOEIpYS/n7XlwHbY0++ot0E3X/koXO6PHwZ8+YgC0nme4A86qUPOZy9O6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1eIx71K4MMtP7thaSHv2tS7Es3S7FuRoV0yOAolBjU=;
 b=X81DUIu/sLpL+2LTQSx7XRIOXJErToluQvWd7GGkcgWELkklFwjZng8GRmRkwcNn9B2IfcUqrbg3Bundkh/8WA/SoYc04XkRfKqAxoWms17cOzwk5afIBi0wmyNk0QUKpraUhe3S0MIJ/IsjVaxyGidt938kStLAdcb0JY/qH04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB8385.eurprd08.prod.outlook.com (2603:10a6:10:3da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 05:55:19 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 05:55:19 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Tue, 05 Mar 2024 06:55:08 +0100
Subject: [PATCH v7 8/9] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-onboard_xvf3500-v7-8-ad3fb50e593b@wolfvision.net>
References: <20240305-onboard_xvf3500-v7-0-ad3fb50e593b@wolfvision.net>
In-Reply-To: <20240305-onboard_xvf3500-v7-0-ad3fb50e593b@wolfvision.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Helen Koike <helen.koike@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Russell King <linux@armlinux.org.uk>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709618108; l=2173;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=aK/tqoGoFX3bOzP7we28NQCLoIDGur9v/pKHCEPg6Ug=;
 b=wEURFk/qx79Dnvum5+va6FkB411+KyO8Wzq0r3laegKyoPiJjKeobL3JifwvzrciwO34jDWQy
 aNPSsgVXs0IBRD4B2pwVDDxt+asYnoMwKTo0TXqwiqU5iAqz9Ao1Bp2
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: FR4P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::18) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB9PR08MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6216b6-37f7-4114-c68b-08dc3cd8d6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JHMvKyjkKDw/8+iaFTYT/GCPk7L7uT0p8l8TTSauFAhx0qbivqgJNiALrMNJvog/a388qhr0siX4EvrLnPdIf/7vsPuI1zWjPcnWPxYokwY9b68nEgyXlGeKUZndVsd10ScKYlXF7h3NiMosz9DYA6xwR0wNqqwLxpS9DAT+/S1TUPjk55cWtyiFLMzXk2EEytVthaMCPClR0Np7FgfT3pzhUnxK+G9PGMaofORZbmk7g2UIw0dXUPCNjxga20qfaBcFMroggUOOAGbE+dBsxG/FDepDw1+00plT9jMoZXllKpdVLY4WPYEJHZ+GSZ13DL68e24QAgcQzlVU1Lzfg3f5PGjWnVD3GbRWKIQiA9h5wysDpmEWvqRHN7OyzkSzGo5Xe1IkBWf2wci0JI5FBQoBfqkqJDMPizj0p62oh0T/RXTSakk0R5HR3zwI/ZIzR6E+NKosjzdfMwTVtzmfsNklHrbRViAkDCIcdNyE8GS1N8dIT23CAKXKheSg0O3EOwIUej4zy8tg6xRaD7VKiekuR6zSFPTqMXYnWfrC1P4s8evTY6Qdje9oUxB/9aD+OOTotNWOKcreZbOHk0uww7loPfl3JpDWBU/kKEgYnwPyZ2sn1uwBQFmL3JhfE2KDeryqbNTJVPxEoslsld8ik1nqyUoSXRiQlzVXDLeYmFQ9fsVED+BsA/opTPYGxqfc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlN3VldraXR2TTRhbi9MRTlOWDdDSjJLWWpQYmlPNXh2cm0xZzJFUTdTcHdT?=
 =?utf-8?B?NFRvcFFGalBhWnI3dHJFWm03amRocHhpVDJxNy9ub2Z0Tno4bjJNcG5QeThP?=
 =?utf-8?B?bWtlZE9WYUtBNERFd1JQSERzcXlaVmFyM3FSY2xCY01hUjhJWVgvbGhtbjJT?=
 =?utf-8?B?SktTeDN4cGI0ZkRTaTgrUVd6eFppNUpSdWpxSHhRaUc2cVN0NEhCZ2crdTdC?=
 =?utf-8?B?eEV1ZnRkU0YxeWNIQURwOTJBTUZhWHZhajVPVlR6SGRQVzhKRnhDRlJLdnNM?=
 =?utf-8?B?cGJ3TlVVVDlUclNqMmtkRDY4L1E2UWpiYm9VVkJ3L29ETGI0ZWxaUWZINWln?=
 =?utf-8?B?SHEzT1BrM3pyV2YzanprTEpSakRORkx6b1QyN01SWm9GRXRzSExMMDZHaVpQ?=
 =?utf-8?B?ZlRZQk1uTEVvRklHZlVUNDRqb0lQRm9CeUtobmVaODJVakFVSk9zM3h0VDdU?=
 =?utf-8?B?aGRnWFY3VFltN1hQV05BSGdlWGJmUUVWNUYwbEw2Nm9wdWIyZUhHb3N5Qm9L?=
 =?utf-8?B?V3pqR1JtMi9MUFQrZW43UG9QSjNkbk5rZ1FjNmttQUQ4ZUZyajQ4cytKMDE2?=
 =?utf-8?B?c0VKeFlvT3dEWkRhN3RyUjdkWGFOUE1IbEZtbVhXbHNYWUZxRVNYTGZuWFZT?=
 =?utf-8?B?TU9Bc284M08vOHY4cExROVl0aUp5Yzdra3VSbWZpKzQyMUFwNHJOajZ4TCsy?=
 =?utf-8?B?SlBuaEQ5VTk0RmV1MlJFdndTcXlPZUI5b2hSbFM4RCsrL1BVWmNuR1VTbkZO?=
 =?utf-8?B?VTNtQ0lhZEtheHVtdWRZQVdPck1TMkVleUpPelp4MUZyTHExQ0FIcHphY3B2?=
 =?utf-8?B?VDZqT3ZnTE1RblYzOUpoemJPNEVkOTlHVEJYWnpLMTdXS3NidG9CWFBmdE9L?=
 =?utf-8?B?MTNTVHlCYlNtNG4wYkxYd3AzR042ODBWMndydmQ4dmdIbW4ra1VNMDZXRDFu?=
 =?utf-8?B?SHV3OEc2R001NEpFcVI1aUFjQVhZUjlwZDQ5bXMva3JteXAzbkdyM0hCalVB?=
 =?utf-8?B?QkdRTVB0N2UvOVJoMWdYK01OTnZ6aHF2Z2liL3V4a3ZUbHhBUERqc3NJc2lF?=
 =?utf-8?B?S2tTZFV4SGQwTTBOM1B6QzlZeGczd3Y5elRkd0VVZ2o4UzhRbGFZcUozM21L?=
 =?utf-8?B?aDQxVnp2aitDU2NSc2gyOTB0WlFva3YrSTN2Z3F4OTI2YnFBZW54RW9SaHRp?=
 =?utf-8?B?Q0VoWk9YeExOUFVINEd2ZThhZE9SeFhiUFViS3JnOTJYWWJxZmlRUU5BbndK?=
 =?utf-8?B?ZmZ4YUdMU2hWc2tJQmp4R1pvd0picEl6eXgrUnlvTTBvNWpVSCtUR0FFRVZK?=
 =?utf-8?B?Ni91eFFqRDA0eHN1KzBNdFN5aTYxU3VNMGhOSmFLL3VnT1AzQVlpdXdFbXZ2?=
 =?utf-8?B?V0lEaDVhUlFVUWwvMHhKbWZSL1pPZHFnc2kwd2pUcGFacElFNFZVNWR0d0R6?=
 =?utf-8?B?VndoeXZ2N21ybm0wZ21TczRqd241U29ZZGZGVGpjdytkelFYMy9nMlRiMWc0?=
 =?utf-8?B?RnZoUTFCdktzaTFtQ1M2RUUxQ1k0d2x0SVdZTGp3WFdWcXIyMVo2UHc1azlV?=
 =?utf-8?B?c1paaEFFeW84S2ZrR051bnJINEdqazM5Y2o0UVdrNVV6UUtNSklDc2d0eThm?=
 =?utf-8?B?SnZWK0hNWUYyclBzU3NvOS9FYXhSTXdYeXNlQXNub29yR2NXc2JHS1dFcEYw?=
 =?utf-8?B?S3l6MFhMbXRzUnBCZTZlVStLZGtQOHpkSjdLMHRDblhwRUZvS1VyVDBTV04z?=
 =?utf-8?B?dXkzamZmZVZCcEZpR2xFaVM0SDNEdFREbkR2eXB1dW1uQ3M0SVRicWFicUZR?=
 =?utf-8?B?SCtBV1dhYVR0VUE5cktLR0FveU9JNUN3MElNQmhEZDRrU29rYkFBVlFIaDZE?=
 =?utf-8?B?VzB0ek9RMjRyUXUwWHorMzBOem8rOGJhbVpwb1B5T25tVmQ4WXloTXBRanhx?=
 =?utf-8?B?eGZjczZpcmVVMExUYmxXT2h6MHpkdGJWOFlzQUxuT21zZjZVTE52c3F6bHRn?=
 =?utf-8?B?L2xpamN3bC92Y3JNanN5cElBTEM4RU5Vdm83c3FlTThDREFWbVpta2QyNHRi?=
 =?utf-8?B?WlFLVTZNd0lVeERTdjQyYnFhQ3oxL0tLTEM3VnQ0aXlCcCtBcHBrSkhqQWk4?=
 =?utf-8?B?K0d4Sk15MmZYTW4rd2JPSUlsUU1GbkE5VGR3bElhRHhObm1XOUg4Sngxc3dS?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6216b6-37f7-4114-c68b-08dc3cd8d6d6
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 05:55:19.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihkxjQTVBBzmDZH5UvwyYWDJiADkN6ou4EsANkRFMYNs1r/92d7+KNs2xLstjzxGhiPpchqd/pCvcMwOFY3JtOHga0ISO1qcPVb4ei1Dxyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8385

The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
multicore controller for voice processing.

Add new bindings to define the device properties.

[1] https://www.xmos.com/xvf3500/

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../devicetree/bindings/sound/xmos,xvf3500.yaml    | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
new file mode 100644
index 000000000000..fb77a61f1350
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/xmos,xvf3500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: XMOS XVF3500 VocalFusion Voice Processor
+
+maintainers:
+  - Javier Carrasco <javier.carrasco@wolfvision.net>
+
+description:
+  The XMOS XVF3500 VocalFusion Voice Processor is a low-latency, 32-bit
+  multicore controller for voice processing.
+  https://www.xmos.com/xvf3500/
+
+allOf:
+  - $ref: /schemas/usb/usb-device.yaml#
+
+properties:
+  compatible:
+    const: usb20b1,0013
+
+  reg: true
+
+  reset-gpios:
+    maxItems: 1
+
+  vdd-supply:
+    description:
+      Regulator for the 1V0 supply.
+
+  vddio-supply:
+    description:
+      Regulator for the 3V3 supply.
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vdd-supply
+  - vddio-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        voice_processor: voice-processor@1 {
+            compatible = "usb20b1,0013";
+            reg = <1>;
+            reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&vcc1v0>;
+            vddio-supply = <&vcc3v3>;
+        };
+    };
+
+...

-- 
2.40.1


