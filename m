Return-Path: <linux-kernel+bounces-127281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC21889492D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22D6B224AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCB5F9DA;
	Tue,  2 Apr 2024 02:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KxejUqyY"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2109.outbound.protection.outlook.com [40.107.6.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920B101DA;
	Tue,  2 Apr 2024 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024069; cv=fail; b=iaTyz60L89MS91hAKF135vcVCbxgwS/vfAPaxEz6Uq3BJDnnqlJ/3BZCe1QXuUjTkZFL1KyyXHqCXf9Zf7LgjJ5GKQGI9anqJCI9HzzF+fbno+gy+vRc671KX6lTCmAWc3pGoKAtkZ7/eTF0PfAkmEEQOXaY2FInIU8nrQj2QCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024069; c=relaxed/simple;
	bh=spsSAgt/PRZWYo+dcO3oi7/x8ImKirJ0OcwfHc2zfD8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=M3yu9iEf9NbgDlmldupGdNnIe3eUvwJLoWhGe8vKn/3S9OmN6PIwVn80PgAET8l6VKZCqz7fQ2rMrFuND0AySkoipOlTzqFJvlcPvmKhed3V3hnXK7Y05HDEu4DJHinHELSAa21CsjggkIVLGjfggBGfBbl+5W9vYsh+g5K32cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KxejUqyY; arc=fail smtp.client-ip=40.107.6.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmYeRa92+TS2spms8LimMaS2K3PNMmojBmNISyqVjATyREPrhNwe5vaiBNrzhfVXiWKV77BfPSJYLox7l2yAqpAlsdBJM9/r29APCu2zOlz7Fgok7OrCtnWJpAKsBZ+DQXhcYtPPTQVXFhRzPxFT7MwosNMvE+uxkTLg7L5NvIdKJBeCcnkOxuhgfJrwyyU94ts5sxu27QfyARJG86m2FMeIz4sywnt6v6wAteN2dpvEiXahY9R/VV8H9Z2HWCZqIq2mb6xNXRU9Pjar/j7Zw2MhUsbs/ep7NQYfA2Hc9prqmwwswJ9fwJU6M7epCESazelNxEEqmW1UEJzB5KGtIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sbrO7HhQSvWXEq/62XeIXDY7LF3q2TiUjpV6WX3tSM=;
 b=ZVM4/Ce2zVeruU1aGWI29IPsVMOUa1pKaxxx1CNVlCQ8fHANg5RkeO0cdvNHK8rmtg/qt1qCkKTboxsfmUtNf6N6gZSyjQJBRjAeypNwwJHVSykUhZ7UZ25m2Rig+U2wCC9HZebmzZQKFLRfKiYxptmPktefhVCvu0ZfQoD1PwddIlAOP7L6rtiRkQVGRqCL/FujFSC6/ty1RvQjPlMaok9uqYyDuGD2PHKAnvjmtA3fMAm0HT0S6sQROIC4KXt19uEeWSfWWwY9HqPgmEHBaodm2ftbqIJKwZQimbOH3b9gNh4zMle4Zv0oxuenWGrJFzGrwg8Z1Zd3HHlkIHqhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sbrO7HhQSvWXEq/62XeIXDY7LF3q2TiUjpV6WX3tSM=;
 b=KxejUqyYJhzffPn7u5Azwnxhvm0F/zgOtATel3DxgY6/C8SCMPGcWvEcQt1HvBLtfmQHXMvAUOinHrqZYx8rqs6vnYq1raCTWtyCWc5bWH1KTeKRhpGv7Mi7aTRgsvI2TV4Vn7WIi6Myb3+unO71EA7ny3yHiiD+p517Uvf2wdQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI0PR04MB10163.eurprd04.prod.outlook.com (2603:10a6:800:245::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 02:14:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Tue, 2 Apr 2024
 02:14:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v7 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Date: Tue, 02 Apr 2024 10:22:20 +0800
Message-Id: <20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANxrC2YC/3XPQWrDMBAF0KsErauiGc1IVla9R8lCluVG0NjGC
 iYh+O6VA8WxS5d/4P0vPUSOY4pZHA8PMcYp5dR3Jdi3gwhn331FmZqSBSrUgMBySF24jt8yh0u
 SFLhW2lJLwYhChjG26fas+zyVfE752o/3Z/sEy/WfogmkkqqNmiMZgNZ+dLfhPfQXsdRM+EtJg
 aIdxUK9q5vK+Jp9RVuqXyjCjupCq8ZR7a1rgq+2lFaKqHeUCgUVy6K2Du1ulVeqYf9gLrQGx9Z
 EZtvilpoX+mfVLH+tHCNpZBvUSud5/gEXcekkzQEAAA==
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712024557; l=6543;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=spsSAgt/PRZWYo+dcO3oi7/x8ImKirJ0OcwfHc2zfD8=;
 b=cKrWNPy39F1/2NDQX2wGVUxHCAx31J7ixb4pVZJ1BXs/v0Vdyzujp5/Yixcv/C0lIgKfUA9sv
 4X+K8gJXA++Coxx04Gwfh6eKwPlqv4DtfHPr1R6b25rpZMvyIs5cx6t
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI0PR04MB10163:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GcnMZRX4PIZ1W12VFFGFlS2aCRzQgOvnqdH7rcIl2kOmiwZt+uQxRiM7YPAByvban9I+Lj/njmdc9ZwrDr6/c6sq04owx/cBZhakJ6D9WqJeupW56zF6zNv0uvhQx+66p/aVwLdC5DqLcvV3T00G6S7cPPgT9XRvDWMcW+FEI5/IZ9Z0yAZo8G4UuelDxD9KVzpLwn7GmXNfMuQyHZx/2SSVS/JLCXibvSNOzzsNEuS1UUvKOxraV+FbcXw+++eLZRfK0Whcus1C1f+vTcCAvMY1LNhkr55mKuMV6KkNUtCzYjZR22N6x4DU7+tOKkynp2lCvUnzaLMsA2RvXaqYR9BeLVpqHqxy5DPKTME5xHgGxwFPP1ptnNAXaYRw/OD2FimD0IL70qTI8YJW9Bm+er7dW3GOjo36fXGazaDDpJckwXxknNapCC3LjKX8IhVgKQR9e0HqSI5lIVGIor52hUtSZKxf2aYKcWEDBJ+LVAOoNS4Ttzqf69rHpVnS5IUw3TacyP4ScASz4s54od4UEBtvXrBujK7bdHS6yUluMKizyN1HT+NiD+v1n8iEKTV+0VRAMe6aMuj92aOdCbHIXzPBShFxmSe1Svh85JBIWLMdVjx9pmnRYHxNfKRFu3k0i1NC1L0vNPHhugbl+Rf7Y2SQUvCvfa7VOUE02RoCCx0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dllOeUpIWkowdkVpZktaaWxqK1NMTnRVM3A2dEYwdUV6dGVNUnhGMDN4YWJo?=
 =?utf-8?B?MXpZeXpNL2FIbisvTFBvSW0wOU1CZFVyZ1EzZW5JQVc2Mkc3T2htWDkxVXo1?=
 =?utf-8?B?TWdPUXNKaHI2WmsxVURpQ2N0Wk5rZHRyL0RyalV6Q1dtZTRyU3VsVVA3RE1Y?=
 =?utf-8?B?aWRwTTczSTI1dXg4ZzVQK3EwOTBkZGVQOFlQUmZKTUJrdi9BK2ZpSFpJSGd2?=
 =?utf-8?B?QXdOaFhzZ202TmxlL1BnYUY4Wm1RdE9ObHJnanhWcEkvVk1IWjEzLzViNU5r?=
 =?utf-8?B?SStCOEhzZkk5b0JMbWFwVmpUNXl3emROTU8zUTVDSnhnZkF5RGMrY3FQczBa?=
 =?utf-8?B?bm9hNlZFbU1BMi9VbCt3Qm5yT3NZNW95T01jOGhEaVAyQ25FZG1BQndSNnlW?=
 =?utf-8?B?KzVSMXd2M25rTWhUUGRheUxyckluRlpZVSt6WXJLSmY3eUovSitpTWQwUUhw?=
 =?utf-8?B?UkNCMWoreVZZV3BHYjAzcW5UU0FnZmpGaEpYTzFtS1NRM1prUGVYR3ZGa01E?=
 =?utf-8?B?c09sMit1MXFZN1V3UkRyZVFIeEMxclo2VHBjaVJtKzV4aEpvK3JCNkdiYXNj?=
 =?utf-8?B?Z3hWR1lkRW9oSEdYc0RzRkFtVHd1c1AxNllKT0VPaU96b0lpZTBmQjliL3lj?=
 =?utf-8?B?NEtzck1jOTM3dFRWNFAwWFlEbGVsWlh0NFlEaU90SHRVaUtXQ01MR3h2VFVJ?=
 =?utf-8?B?SWhmT1ZydFFrb1JjRnZFTm8wTXB6NDROSGx1Snl1L29POGZyWkdTRHRjVE9O?=
 =?utf-8?B?SW1FK2FmQk15Q3lRWmFWbHNWRk8yRkFSMEQyVnRrNDFpaFhkSElFSllxbWNY?=
 =?utf-8?B?UStxeW90MVcvNjdUKzhiemJPV3IzUjJoanlPTTVyWWVXa3A1QUZmOWlhcUlp?=
 =?utf-8?B?WXdMbFIvMVY5RTR3SG80NGJ0TUFkVThhb2dPVFpXekhKNzlLbTVBN0NDK0FJ?=
 =?utf-8?B?NlNKdXA2Wk94TWQzNVJ6VStWL1N5Z0Uvc012eVJOc0RpRnRZUlhDeXM2d2Jm?=
 =?utf-8?B?VmlMNUhhUEVBeENRVktIWjdJN3pTdytzMldmUVNZM2c4OVlrSkhzYjRsMmdU?=
 =?utf-8?B?ZjN6ZDBPVFpIVDNkejBnTWFSZjJscGZDMERBWUdyaDhYNjFFZW5rMEY0ZEZv?=
 =?utf-8?B?VEd6UWtPVEJaeERsaTBoWFNtZXlQaXh2aWh0NHVKcmFuWjlaMTZ5MVEwNTFQ?=
 =?utf-8?B?amdDNEpkbVFUQzZ5cTJyQ3QwRTE1ZFQ5NWtSdjhKT1lOa0twMFZwVEI3UWUv?=
 =?utf-8?B?VjdiNkFrcjZLTE1hWVdqUmQxRlFycTVtS0NqM2FMcGxBVnNGTVlxWms2dUVK?=
 =?utf-8?B?SXNEZjhlekNVc1RlNUxmckFZNVRxUzhkcHoyVUJIQnRoK1pzakptUE41TTJl?=
 =?utf-8?B?L0xHNThsRlhGanFQS3c3bk8rQXdTajk5YXUxMDVEaUFpWDBsb3ljaE1HcXpM?=
 =?utf-8?B?SGRUbjV5bjhKM0tjeFYrUEdPYWpTQU54dzdIQUFCQjRFNlI2a2dvSkVDK2JC?=
 =?utf-8?B?bWdtODNVMlNJenovM2hkUmE5eDRIN2ZZU2NFSm01ai9ZSGE2UlYweFg4YWNR?=
 =?utf-8?B?NzhmR0ZxbFA0Ujk0dVVEWkYwcFE1UEZNSkhIcXViQVNPYnN5RHkzSHAwVHNj?=
 =?utf-8?B?UHNiRmN5aHNxRXU2Sng2SFNxRjV0YlpjMGtvSGVoNDdaS1dRMjVOM2JHRlF6?=
 =?utf-8?B?YXNZZzhRak15a2prSWI5eXN0RXZ5c215SDVLUktrbG5iVGpvMGhSdkg0WUt6?=
 =?utf-8?B?N3pQaTBhUDRKSElLTVU5T3lnR1loOUZlSVhtSjNhWnFnV0E5TllDRTYySUxG?=
 =?utf-8?B?TE9aeHpWaytMWi9FN3JRTUp6YURNaTJLMjBBeHZYVGlzMThKcDJmeDAwWEht?=
 =?utf-8?B?RjNyYjVReUw0eGY4Ujh3eCs0dENvZVZsWE9RRzVURGlCYW0rbG1jMmE4OUxX?=
 =?utf-8?B?aWtOT2NYZGwyQ0dsZmFMVHlTZGI5RU14RFZRTUVieEg3bXgvaUluQjc5UnJU?=
 =?utf-8?B?Rm9kRHlmSEphVzZhSGNDNlZmZkZHRk04Ynp0bUY2NEgyNng1R0xJNW90aXdo?=
 =?utf-8?B?RXVtaFl1Vk0vbXlZVVVrOThMRkZxdmZSaGNRazN3Q1hyZ0h0WlZlYkZZY1dn?=
 =?utf-8?Q?kZDBHi427UPXayGCBE+6Yl59T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ee0ede-fe32-4e7c-8255-08dc52ba9c05
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 02:14:21.8141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91FUVRCjg0jZXSE5BbDo2MEO4WUqWYfAIXJBjaIasCMeSxgl/WQ9BVEtibUaPHJjSkYUr9kCP5OQ0W/PpivyGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10163

This patchset is a rework from Oleksii's RFC v5 patchset
https://lore.kernel.org/all/cover.1698353854.git.oleksii_moisieiev@epam.com/

This patchset introduces some changes based on RFC v5:
- introduce helper get_max_msg_size
- support compatible string
- iterate the id_table
- Support multiple configs in one command
- Added i.MX support
- Patch 5 firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
  is almost same as RFCv5 expect multiple configs support.
- Patch 4 the dt-bindings includes compatible string to support i.MX
- Rebased on 2023-12-15 linux-next/master

If any comments from RFC v5 are missed, I am sorry in advance.

This PINCTRL Protocol is following Version 3.2 SCMI Spec Beta release.

On ARM-based systems, a separate Cortex-M based System Control Processor
(SCP) provides control on pins, as well as with power, clocks, reset
controllers. So implement the driver to support such cases.

The i.MX95 Example as below:

Configuration:
The scmi-pinctrl driver can be configured using DT bindings.
For example:
/ {
	sram0: sram@445b1000 {
		compatible = "mmio-sram";
		reg = <0x0 0x445b1000 0x0 0x400>;

		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0x0 0x0 0x445b1000 0x400>;

		scmi_buf0: scmi-sram-section@0 {
			compatible = "arm,scmi-shmem";
			reg = <0x0 0x80>;
		};

		scmi_buf1: scmi-sram-section@80 {
			compatible = "arm,scmi-shmem";
			reg = <0x80 0x80>;
		};
	};

	firmware {
		scmi {
			compatible = "arm,scmi";
			mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
			shmem = <&scmi_buf0>, <&scmi_buf1>;
			#address-cells = <1>;
			#size-cells = <0>;

			scmi_iomuxc: protocol@19 {
				compatible = "fsl,imx95-scmi-pinctrl";
				reg = <0x19>;
			};
		};
	};
};

&scmi_iomuxc {
	pinctrl_tpm3: tpm3grp {
		fsl,pins = <
			IMX95_PAD_GPIO_IO12__TPM3_CH2(0x51e)
		>;
	};
};

This patchset has been tested on i.MX95-19x19-EVK board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v7:
- Hope I not miss any comments. If any missed, please forgive. Since
  i.MX95 SCMI firmware not support all the pinctrl features, I could only
  do limited test.
- Version set to 0x10000
- Drop scmi_msg_func_set
- Use get_all to replace flag[0,1], not support flag 2 as of now.
- Add settings_get_one and settings_get_all ops to support get_all[false, true]
- PINCTRL_SET_PERMISSIONS is not included in this patchset
- Bail out if nr_pins is 0
- Add check nr_functions and nr_groups if they are 0.
- ext_name_flag changed to bool type
- Drop unrelated comment
- Use a central function for pin request and free
- Coding style optimization
- Use pinfunction to replace scmi_pinctrl_funcs
- For the devm_x APIs comments from Andy, I not update in the x/arm_scmi/pinctrl.c,
  because it is correct usage.
- For included headers, I keep not change. I try to follow 80 max chars
  for scmi driver, but with a few lines still exceed.
- Link to v6: https://lore.kernel.org/r/20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com

Changes in v6:
- Update pinctrl driver following ARM SCMI 3.2 public release
- Addressed Dan's comments, and followed Dan's suggestions, thanks.
- Dropped R-b/T-b in patch 3/4 and patch 4/4,
- Link to v5: https://lore.kernel.org/r/20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com

Changes in v5:
- Rebased to linux-next next-20240313
- Link to v4: https://lore.kernel.org/r/20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com

Changes in v4:
- Rebased to next-20240222
- Drop pinctrl-scmi-imx and compatible patches in V3
- Add T-b and R-b collected from v3
- Link to v3: https://lore.kernel.org/r/20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com

Changes in v3:
- Add R-b for dt-binding patch
- Use 80 chars per line to align with other scmi drivers
- Add pinctrl_scmi_alloc_configs pinctrl_scmi_free_configs to replace
  driver global config_value and config_type array to avoid in parrell
  access issue. When num_configs is larger than 4, use alloc, else use
  stack.
- Drop the separate MAITAINERS entry for firmware scmi pinctrl
- Use enum type, not u8 when referring the scmi or generic pin conf type
- Drop scmi_pinctrl_config_get_all which is not used at all for now.
- Update copyright year to 2024
- Move the enum scmi_pinctrl_conf_type above pinctrl_proto_ops for consistency
- Link to v2: https://lore.kernel.org/r/20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com

Changes in v2:
 Added comments, and added R-b for Patch 1
 Moved the compatile string and i.MX patch to the end, marked NOT APPLY
 Patchset based on lore.kernel.org/all/20231221151129.325749-1-cristian.marussi@arm.com/
 Addressed the binding doc issue, dropped i.MX content.
 For the firmware pinctrl scmi driver, addressed the comments from Cristian
 For the pinctrl scmi driver, addressed comments from Cristian

 For the i.MX95 OEM stuff, I not have good idea, expect using compatbile
 string. Maybe the firmware public an protocol attribute to indicate it is
 VENDOR stuff or NXP use a new protocol id, not 0x19. But I think
 current pinctrl-scmi.c not able to support OEM config, should we extend
 it with some method? Anyway if patch 1-4 is good enough, they could
 be picked up first.

 Since I am only able to test the patch on i.MX95 which not support
 geneirc pinconf, only OEM configs are tested in my side.

---
Peng Fan (4):
      firmware: arm_scmi: introduce helper get_max_msg_size
      dt-bindings: firmware: arm,scmi: support pinctrl protocol
      firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
      pinctrl: Implementation of the generic scmi-pinctrl driver

 .../devicetree/bindings/firmware/arm,scmi.yaml     |  50 ++
 MAINTAINERS                                        |   1 +
 drivers/firmware/arm_scmi/Makefile                 |   3 +-
 drivers/firmware/arm_scmi/driver.c                 |  17 +
 drivers/firmware/arm_scmi/pinctrl.c                | 897 +++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h              |   3 +
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-scmi.c                     | 560 +++++++++++++
 include/linux/scmi_protocol.h                      |  83 ++
 10 files changed, 1625 insertions(+), 1 deletion(-)
---
base-commit: 70ca90deeca172d343bd18bf7fb2f992214c23c0
change-id: 20231215-pinctrl-scmi-4c5b0374f4c6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


