Return-Path: <linux-kernel+bounces-55074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD74584B748
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912C728BA9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7A9134723;
	Tue,  6 Feb 2024 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="cmJrpT3K"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2133.outbound.protection.outlook.com [40.107.21.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F77133405;
	Tue,  6 Feb 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227996; cv=fail; b=ucWCSeuQwoF9U/3scQr7wgg2lWB5wOIgY6OGAA+COl8CFqMO4LoBjAnA7h008KOHJ8t+RuwjI3EIRid4iQKfHIiZmxJk9Pv9suv1my1W4nUYGmgv0JXCOB1VHoFIxTgQd69d7etgGXFae2NceeSc/rTXBEmIbCT2UWxQXLf0xmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227996; c=relaxed/simple;
	bh=0XgQ/K4MzqybyRm7DXYp/jsZVsLQcFuYkKojVXdRw6s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NyP1lSHq0gAGDr2/BOgv7JVrORxnpKVwmZy1CmnXOwkDz5uK+Kut1IRGvjVTm+uP3ogG9Cjgs3cBHEptySsxrwPLV7Tbe+tc95ZBPMH2et6sLFEOiJy2Y688Qc007vhp7oFJ4PphSAJ5NtTLN0cqQj7ygCe3vF9VtYSrGww0Jpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=cmJrpT3K; arc=fail smtp.client-ip=40.107.21.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2ZqgO885Jc4oQOcrqdqZM5uByuYNSZq//wPSuY488ZhCSa1AzE8/gQz2IkSTGQiSd5PUREkolWn+ph6kSbJ/D8HhHOv7PfFPKjqblHcXtQGbWLO1bXtp9KkGbB1jXo4RYysBL0+G+FhD3BIgf3kH4m8ByAqgWRumR2O0ZDsIkoTbM7WfkimCk+dI5Je+K4HdlxRxbZdjvWjx5yCJmI58IQMtzdUHT13mgkwSUHuAN+QEhtOSchKEqhRf+Eqi7u355P07JnlvGaFQN/OmhvrdxGdo6h21nj7pmNou1XplRQevkFhdaH83+spD+9VjP7BFCAcRF9G4yqni8EZsZrUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmhqXwyiM3008Av7VCk/Z3bwY4A9DhYYbxVxY//yP+o=;
 b=KYKY4lw3NRV1XPbaVK5ehv14jYyokCdYzf247Re5KUNOj9dVdBcyE1KcYv8HkAmuflpE2ZRPHcbAKAPfRdqmRauXLMFdNpW1fX14BXv377BpmYq8CyG9yrDzrPQKE1Zaxv6MyM8b0JRclEiy5ZjcjryHIioIUCQOCzjkSZkKf9/h+cxmH1IgRSkJjwd9+t1vkXXYGeXl2s4NMCSYKjadEbnCCDUyLAvtv7rwAPjGe87W8DIF/3YikqaMpeAhLkhxLNNYB506ZeIgoVaHAb1vF/IEGroMm8nLIY7AOMKTd7JKH7ayueTFQBjO0OFb7NhmKrYnaySzFw/okyXoBrMgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmhqXwyiM3008Av7VCk/Z3bwY4A9DhYYbxVxY//yP+o=;
 b=cmJrpT3KaSJfrpImIFATsHaaMHb/FpB4Ius7wJneOYbdrNK3IHs2dmSUwtmFHBvYsJcQwo59utol1bALRVm4ZEi8Qjr/5PmE3TESLayVDaIar8m4ICwjIi8Tcwh4b4dG1JYqHgnkTeK3uDRNJLrr6REo3ERF8hOOIiapw4C3s5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB6330.eurprd08.prod.outlook.com (2603:10a6:10:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 13:59:42 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 13:59:41 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Tue, 06 Feb 2024 14:59:35 +0100
Subject: [PATCH v3 7/7] usb: misc: onboard_hub: add support for XMOS
 XVF3500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-onboard_xvf3500-v3-7-f85b04116688@wolfvision.net>
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
In-Reply-To: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707227975; l=2728;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=0XgQ/K4MzqybyRm7DXYp/jsZVsLQcFuYkKojVXdRw6s=;
 b=wK7XZPQRYTiP9d+VmjjUAQNa5EGoYaS56UOJUZvyBVXHO2lYQ0QOslmUK2Vs0Fy7sFy5TnqYy
 j1g9oXcSjc3CEi0cilRpXFbNp0fhBG7jhVKpZnlUs+FSqgQsKtNOlH/
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: FR5P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::8) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB9PR08MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f53379-ab49-47f8-8fe6-08dc271bdda2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YzrGdfQ6GZcuTSJM8Yo+JWm47U/W0KcFTgwwn218j8hRokmQZ+M2zS+AE+bo/PQz1LPy/FN88d4hz1+O7QcVgmUQtttAST5Vz0khnP6aw0iRjmR5C/fqFE63Qgs+k/3u0M5L+ZZDvCCMj4jUnE2vaUoaedIHWsi/eGb5G2281mMWxfipWC0zW5eoVxD3ulndSjOQzU9P4TsOYfq3dNUVdsp7mjj22H+KSjaEVTxdtgggDooauqo8FZTg0w3GCy1I0iuLFMzAUNvjr+KAjlf3yfRFN0q15MuFYqyO5R7lAlLvIUmdfOBcl+eY84VNmjw9C6CK6Y49FBMkcqHbV0Fu8ix3YGIkCuhdEsas1rHio9Ch47/2W3y3fxTSjboLkTf1jy7QvpXOZceO801ScG8ngg09fliBOsXknSOogG12YnsLb4qaH58y8zs/F8n8kFN8y4drZFbdrCl+rbwuaApKceEozzDy9LihkB3TyGqe/nilS3ZV7qDsGceITVOSywHKSyeSTBesJbeVjqnv1On9wLla1BPbdtErWTaWZabd9m8dXwpQx4KbBVJ3KpFxpt8EyHyViLbvQQrzfbnANnCNlJjZkGK9zNDcheSb4jum39c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39850400004)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(44832011)(26005)(2616005)(6486002)(966005)(107886003)(86362001)(6506007)(6666004)(478600001)(6512007)(52116002)(36756003)(316002)(38350700005)(41300700001)(66946007)(66556008)(66476007)(110136005)(8676002)(4326008)(2906002)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3l6QzliT0ZTSUpGQlgzRitqbHJtTXIyL2RkWFFpQkI3UmtqZEl0VGdOOEdC?=
 =?utf-8?B?am9Pelo0c3Y2MjF4NklqdmEvWklobStJdmhhZXFkZHlwNHIvVFlyMjdBTkxr?=
 =?utf-8?B?Vml0azVXZWYwa3BRdFB3K1JTZkJyU0lqN2NmMVJHZ01XVm9ZQXdtYXVsNEdi?=
 =?utf-8?B?T3Njc3FxUlUxUGQ2VFA4aFVrK2NQWmhBbGMzaEMvdzQ4ZHExSGZnWXpKSnhI?=
 =?utf-8?B?OS96ZU1GTzEvMmN3WWZYS0xZVTR1ZkNseHdKOHNFakt6T0Z0NjFWd292MnBu?=
 =?utf-8?B?WVB5cVlocm9ITU1RSUVESUQxdzF4N1YxZXkvUXBOVmJNWjZkdDdRRDFId3Zu?=
 =?utf-8?B?UU9GWkZyQU5MUmhiM3o2Z0FtemtVM2tvS1RnRUU0aEN5MWdjQTlHQ2VHYVVU?=
 =?utf-8?B?N0lmN2NFNXpUNW16QVB5Wkhtck9LWkE3T243ZzRxUUgwL0srSUs1VUNQNlVo?=
 =?utf-8?B?ZnBhTVI3VExnT2xaUVBLcmt0Nm1qLzFwZC8zWTV3enVZQ3RTc2xnbG54ZmtJ?=
 =?utf-8?B?VFR3b0R3YUc0RXEwSDNSdlQ2bWE5dTB3YXYvSGE1akdVUzV4VzhjT3JaeGJO?=
 =?utf-8?B?VUgwQ3VMbWhiOWt2dDhMZGh0WkFZaVNjaFpqRWs0ZzhQSUUvMWNMdTVXazhE?=
 =?utf-8?B?WVBJbHVsVS96Zlp2MDdmTE1sSnhQbmVIa2g3K1JxaHYyWjZqdXZVODhTOWVy?=
 =?utf-8?B?cGs0RDRibmM0TkZFMXYzNHY3b1pka094Q254VXY1ZGdNZzdiY2VOMDd5NmJ3?=
 =?utf-8?B?ZGVFVWVlMU8zOS9zUkZneDRGWFVINmRDMzgrdUlyc1gvUnUxWTAxbXVobGs1?=
 =?utf-8?B?bDNKcmlKMlJRSmtZdHoxZjkvck9YTHFBdkZvcERjbkw2TFZRaFk2ZkhKd05h?=
 =?utf-8?B?aldLc2Jia2d4VFlEbkVHUHM5VFhRQ3JCRGVhNGl4K1BzbUhhdVNPKzJBQTI3?=
 =?utf-8?B?UmJzdDdZdklBZ2lwZ3A2bDhaSXhzb1BPaWJ4YVRZbFRJTWhjM1NaSXNEN3dO?=
 =?utf-8?B?L29FRTBMUHUrcnVQM0lvc2FwTUVrM2s3bWhpWVl4aVl6bStMUGhxaWI2L0Fm?=
 =?utf-8?B?NkdxajlvWHR3enM3YTdnc01qbkVnZUJNU1VlSzZQelFRV09BSGoyVUpXNUFW?=
 =?utf-8?B?bGh3QS92R3ZwQWRkZWJtVXEvanUzcXJ0R0NWbUVoSnRNQ0FDMzFHTW0vVUJl?=
 =?utf-8?B?Uld4S2tKcGNteHVlS0Qvellqa0lwaTlUcThmMm91ajBZNm5iTFp2aERBYXZU?=
 =?utf-8?B?aEFGOXl1UUlTVUFqNExKUk92YjVCRVAzYWJXeUZtbXQ0YlJ6R3IrR1BEV0hU?=
 =?utf-8?B?eDh5ZzMrS1pkQ2VLM3NZVjNqTFlDWmd2Q0ZNREpXY3lvWUJETEJ3TUhrOHpJ?=
 =?utf-8?B?R0xrZ0JtWHBQdDdnT1B2RHVSNVVjOWFNVzRqUWR2R1AvU0lvRTJEUVVQczU0?=
 =?utf-8?B?S3dNT2lkSWJRTUhQc3hrVzI1Z0RlRWxqajM4am9GdFdYc095U1laeW5ZS3Nv?=
 =?utf-8?B?TXBKVUZUM1dCSkpLOFBCcXJVNkx5bUc1cDYrWEFhNm5FSFBjWXZobVJzOFBo?=
 =?utf-8?B?b3BPLzh0TDNOMjN3NlpwU2ZuTFp2SXgrUTRmL250dzIyTkZCZ2tLN0JhZHgy?=
 =?utf-8?B?dXRyTEtXcjJIQXpaemRob0lsb1VrNkl5RVhPRXJTMzJhVGQ0NzZoQVpCL0wv?=
 =?utf-8?B?NnVKU2hIR2dQbXVrcHdsN1B6V0hoODVtUnBNQXBaVGlyeC83NDNUVlIxUVJz?=
 =?utf-8?B?ZEtMc2tyYVp6WHU5dEhhYTFJNlRxK2ZNOVdQbmoyWFhocjVMRFExN0k3bkdS?=
 =?utf-8?B?d0xYMkFFSTlRamdzODZ6YWxpbEJheFN6elIyT00vSUdLOEM1SSszZ2Vxb3Yv?=
 =?utf-8?B?aDVqV0M1NXd1eTV4czdPV0tobXhZWHN0ZEV2VElsRjZOZ3VtS3VFbW5mV2ND?=
 =?utf-8?B?SXdHYlhsNW56R3V2YkZMZ0xWUWQ4K2ZCR1ZKdlJhZnlEcm1uM1hNSENUMlpD?=
 =?utf-8?B?MEp0ZkthMFlWUDlHU0xsRFVBRHFya1NPRSttdVZwZC8zUjYraTNHU0IzNzhD?=
 =?utf-8?B?emxod2hCU1ZjMHBpMGtkOFhmcVNIcmg1R1JPelBibXZ0VkhlbktPMHlRV1oy?=
 =?utf-8?B?RmVtSXpKZ2J1WmxoaU1USlc4cFphWjR2VUpoK2EvMmxCT3A0UGF6SFVzdHhx?=
 =?utf-8?Q?BYlBNTg0G5FfvYt8fcX3SE0=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f53379-ab49-47f8-8fe6-08dc271bdda2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:59:41.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKHLLR+jQ4Rv2/axtJhWbrrLUMpTbYSJaL8AfhvFoG0cuaGWlfAIvSIxVz83ZNHX5V/fEffG6VQsFl5T+KJthHtymCxQxFrYcmdYEMhu6sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6330

The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
multicore controller for voice processing.

This device requires a specific power sequence, which consists of
enabling the regulators that control the 3V3 and 1V0 device supplies,
and a reset de-assertion after a delay of at least 100ns. Such power
sequence is already supported by the onboard_hub driver, and it can be
reused for non-hub USB devices as well.

Once in normal operation, the XVF3500 registers itself as a USB device,
and it does not require any device-specific operations in the driver.

[1] https://www.xmos.com/xvf3500/

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/misc/onboard_usb_dev.c | 2 ++
 drivers/usb/misc/onboard_usb_dev.h | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index 3ac21ec38ac0..a5bb68f04d1c 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -386,6 +386,7 @@ static struct platform_driver onboard_dev_driver = {
 #define VENDOR_ID_REALTEK	0x0bda
 #define VENDOR_ID_TI		0x0451
 #define VENDOR_ID_VIA		0x2109
+#define VENDOR_ID_XMOS		0x20B1
 
 /*
  * Returns the onboard_dev platform device that is associated with the USB
@@ -478,6 +479,7 @@ static const struct usb_device_id onboard_dev_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
 	{ USB_DEVICE(VENDOR_ID_VIA, 0x0817) }, /* VIA VL817 3.1 */
 	{ USB_DEVICE(VENDOR_ID_VIA, 0x2817) }, /* VIA VL817 2.0 */
+	{ USB_DEVICE(VENDOR_ID_XMOS, 0x0013) }, /* XVF3500 */
 	{}
 };
 MODULE_DEVICE_TABLE(usb, onboard_dev_id_table);
diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
index ebe83e19d818..632481626d30 100644
--- a/drivers/usb/misc/onboard_usb_dev.h
+++ b/drivers/usb/misc/onboard_usb_dev.h
@@ -66,6 +66,12 @@ static const struct onboard_dev_pdata vialab_vl817_data = {
 	.is_hub = true,
 };
 
+static const struct onboard_dev_pdata xmos_xvf3500_data = {
+	.reset_us = 1,
+	.num_supplies = 2,
+	.is_hub = false,
+};
+
 static const struct of_device_id onboard_dev_match[] = {
 	{ .compatible = "usb424,2412", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
@@ -87,6 +93,7 @@ static const struct of_device_id onboard_dev_match[] = {
 	{ .compatible = "usbbda,5414", .data = &realtek_rts5411_data, },
 	{ .compatible = "usb2109,817", .data = &vialab_vl817_data, },
 	{ .compatible = "usb2109,2817", .data = &vialab_vl817_data, },
+	{ .compatible = "usb20b1,0013", .data = &xmos_xvf3500_data, },
 	{}
 };
 

-- 
2.40.1


