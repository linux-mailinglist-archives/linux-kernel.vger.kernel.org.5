Return-Path: <linux-kernel+bounces-144779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 622818A4AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182222808F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35473A1DB;
	Mon, 15 Apr 2024 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TWMOlasm"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2043.outbound.protection.outlook.com [40.107.15.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A6036AF5;
	Mon, 15 Apr 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170575; cv=fail; b=NrBIF1F3sja2HMqchKvbBgpUfrB21DmEClaAhuQzk7Gillrq8fYKEdnsOgtdGclXNSals4NCeM9tSyjAZcwKb2SQuOeIpwtW7Ey0kI75cP7ltUJNC16m8CVijH4PgyAv0wpUwisefKA8rqYkrCKA6HJaxddy/jHU+nSIxF3s/JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170575; c=relaxed/simple;
	bh=7SN1QTNvAPGvhvtiGRhG3T01HLVOVX485deXBX8UmJ4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=d2/kSTqEzmiFtjxh66WfKKF2b2UO8lCgFCaXtphhPu11Mrzpb83zF6A3ooOPP7zVkHHWi08wLxMMoImQ/VyvO6JZB90e6LedIgcwl85iHWtv5BTIXwU2T3dNNrAtLPtSItWL4RsykIolKn6P6op20LsUHPTUrT+9hO2pc5XndPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TWMOlasm; arc=fail smtp.client-ip=40.107.15.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUqepOv9WIhgUUhC2ko6HGh7geAhQhDdMIqpVv9v6DSMjmJ2t+rN0h/3x3Z0HJRThn/LZ/F2Ujw1HuNVZ9nJnHYRkowr7CmyOP2Ck/TJGT8TrqLoLurBJ85Mn6k2qogkP9rBCkBz0iz51Iz1l/aLiSj8L49WTUyez7DkA0FCNDAKQvbtoWrtyJQIKQ7LqqUpry+5AbsxXKVwC+MtZr07qlxMTpMK/Pg+OAZeDbCI/kURDu60kySZtwsP4PJs23lrcc15LF4D4DeAFuy7SyHfAewmY9n0y3Cn4o3XUWckoYIMPIKr1GqE/IU9TMf2Kw1oG/2/puJc7ovJmN4Zq2zVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sqX5vEz36r9rT14gd0J/Ij4icX4uS7xwO22zDGscog=;
 b=BNZyEwD+cYF2tvbsmJSgff7gCtn4t35GwF7iJQhpUoBgST9SyeJxK+Y4n7MvpC1q3rKn2BdVCBdhXTkIzS+F8uwJO8iZonI6jWGAPu3lqB8XFSTDJetcma+r0ZCZeexMVf1aqx7jeORBMSCTlgzk6BqbH0m9mwPpbVpJpriZ5AJE52PRXjk97K5P/SVK3AlPibnVJeXTqCnQMqTv7nhZmd2e/MukCXNXsHqTiN2wo5m/3Z8hTaWMcaKK0+QsUF2wEVTXYjdGTNvuudmd1imQe0f5XfB5dUC5nUcDNtgsjZG4j/Nbt0rVKyMez8wTEVbyY9HUjtn3OlLvXnSZXp+B1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sqX5vEz36r9rT14gd0J/Ij4icX4uS7xwO22zDGscog=;
 b=TWMOlasmVnNzYPyPxamdnRvDljfquilvZHAE1aHnFaem/hkcjopVyYj00D/iJmB8iIZPMSZzXfBerHAISl/+89E8SF+5BYess9iJUeZxXSVYr9ZZ0amOe7iH0PB98S+D/XfoTOSQyOqR2xCUWCoryKomuMzkVz51vH9W/qj6Ce4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8138.eurprd04.prod.outlook.com (2603:10a6:10:25c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:42:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 08:42:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v10 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Date: Mon, 15 Apr 2024 16:50:48 +0800
Message-Id: <20240415-pinctrl-scmi-v10-0-59c6e7a586ee@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGjqHGYC/3XRS2rDMBAG4KsUreuieVlSV71H6UKWpUbQOMEOJ
 iXk7pUDxbZKlzPwzT8j3dQUxxwn9fp0U2Oc85RPQylAPz+pcPDDZ2xyXxoKNRIgSHPOQ7iMX80
 UjrnhIJ0mw4lDqwo5jzHl62Pe+0epD3m6nMbvx/gZlu4/g2ZodKNTJIncAiTzNlzPL+F0VMuYG
 X8pa9BcUSzUu663re/EW95T2lCEilKhtnfceeP64O2e8koRqaJcKOhYEsk4NFWqrJSgXlgK7cC
 JaaOISbin7Yb+SW2XW60TZEIxQe+pWWlZuaKmUIpewPWAoX5hu6X159hCJQUbiayBLu2p21CoU
 91yqwVDzD1551d6v99/AMV6UQ1/AgAA
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dhruva Gole <d-gole@ti.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713171061; l=7602;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=7SN1QTNvAPGvhvtiGRhG3T01HLVOVX485deXBX8UmJ4=;
 b=Y5oZKhnv9yThKIk/lJO/akcyF7jHBfoDfuebBAF3az2pHSRqSdBSMxNflgRCDkFt5UOz0a0Wu
 Zuu1gq61BqvAZBTgC377WXhMBg/REFRxFm/vQ4v32tbR8y6HHt1S76L
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf3a2ac-0396-44b9-d121-08dc5d2807a4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2As+tO3VPPbc5RR+nBvO1LKSV8edJHZvMOIhNTsFlijhUSLIWbK/jrf1Un4Z0gDOR9B0Z8mcb5eGfNRzJqW3UpuNJ5kKKvjVYaROgtpYIQuwADax/HGFfnQwVoRR++5IiiALl+uEsYqVTVvpXB5AssmApCc17dr0Jdxy8Qs49h/J0bBmqlzLbF0Gqd9oJtRLGUDuCaVWhhTYNeBvyB7VoJ2PGPb0unCoh28K/9SI0cnYN0OhW/nuV+k+CQMfhIKlg482P4IEpHEnTEJuAXHuZBG1ZXkg88+8CS14vPcbIAEpVNKBWhv/MLbONP3spwG8x6G9dLVbsbdfvfcR7oz3Cum0hFbFCrKlks86+x3BKUP0D9ackVDaYpK3a7ync+VT5DX/lZZgQ+t8ux7NdoZEV0gmiYHlpS3ToG/vcCd1E2zuBVSxtpZPqrau/enBKukpM+DTqiH+itk9EPbELxwGSDBnb1MTJIAailJzN7j//M8wkrqYTHZjS5kIUhEcaoQbYWOVNxIeNXfcycdEImWZCe+GFUxGDo5M9CNwXqjzFhYhwXRyNrNIcWBKIffUiXzR8Nagjpy0Yv+p8Doyiqh3BPvHxyFe34FGGsRAc0BDv2uZ5jJBxp62s+y6cLzmBZDEwTJ/Mco5qJ9cZcDrEq2JNk11pz++Wz+1+uzvbOn5Pdw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVp1N0dCOXZ1R2JXVDNvQjhJSUhMMkZ1YnhEWUNxMzZ6b0U3c1Q2d1VwcmdC?=
 =?utf-8?B?MEc2MXdHbzdZK2NHaDRpWDJ6Zy8rNVhBcGpON2hyWGJuRGZJZWkyK3pvSUFY?=
 =?utf-8?B?bmFvdjQ5akpJZURpeUtsTUZuaE1lN0hTSWNaaytNZXlJcmpiZEZqcDJKbXJK?=
 =?utf-8?B?d2V6TW1rZG92ZWJucUpsNnNQeTBEU2o1MFZKZVArWXVOV0pEN043d2VtejZo?=
 =?utf-8?B?V1lGSWlaYUNKK3pUUkxDRWV0VzVVWnFVendsVUZNeGRoQkFyNTFWaEQ5eEQ5?=
 =?utf-8?B?dlplK1FHNzl1ZGNOSXFuSDhBbFJNREV0WW9uTGlhNVpqUU80b0k4T21zYjZP?=
 =?utf-8?B?WmVoakpBc3FCM0d2YXRvektzQkpLNGhrQ0FxSWpCek1xNyt0T3luRVRaMU9a?=
 =?utf-8?B?ZVF5bHUzTElIQU9iSEtVQ2wvYTBQOHZiWUpCc20wYmRNNUhiTm5sNVBVbitW?=
 =?utf-8?B?aXNvUnZKTlVjdWEvVXpYVlpHMk1adVlTQ0FlQUthUE5pbTRaMERTTXFkRDdR?=
 =?utf-8?B?Mm5qeTlzRTNOdnU1ZGFSNDA1d2RJdmdnWXFxQTdDa29SaTdJOWprSkwyZWFV?=
 =?utf-8?B?TVFYeHZIaGI1cW5XREV5eHE4ZGRZM0RpTnI1d1ZLUFBCazhhd0FFZytOUXZy?=
 =?utf-8?B?WjZ1Wm02WXMzVUVhdjRISVNkY0thTFNlU25DenQxVGE0aVU2RXRRMXJLUHk3?=
 =?utf-8?B?eWNWZ1dadS8yMUt3QnlGRUJPUzR1WTZhNHZNcEVYazNQNldLK0tsc2VlUXpV?=
 =?utf-8?B?QTBHbExvQnk1cVYrUWpBbm1GT1NNbmhKZHFxSVlNR3pUL0tOa0xWclVQcDQ0?=
 =?utf-8?B?aW5kdGhXN3hwUURBVHdnK3N4RDJPM0RpNHYvcGRkc2VzbjlyUDNLRXRrNFd2?=
 =?utf-8?B?bWRqMXRqWDRFQmltYThoL1RrZHE1MFUwMXVWUXFGTnFsZ0xjcmZEVm9tUERm?=
 =?utf-8?B?dUVmWFNwK0xHUXBVVlUwOUFmdVFxR2dTY3dCY1V4eXRnRnM3TFRaNkhYVk5Q?=
 =?utf-8?B?ZTNFck1JVXE0YmpiT1hNTXhESXFtcmJTQVd3alRTaDVsN3J3cU1aNGpGb3M5?=
 =?utf-8?B?M1JNOEdCMmZTZzlSWjhYODgyV3lhdXdUVDk1b1JCcDNQV0hZMmVYNVJheTE4?=
 =?utf-8?B?dXBic3VJYmpia3orVHZiL2hGYktmTVV3bHFhb1I0Y0s3ZGRNeXhySzVXazk2?=
 =?utf-8?B?SEJFMEJ1SFM3L2J6dENiWGkxd0RhY2MrMHN2bzVKaGNidnVyQ1dmWWdFUUxa?=
 =?utf-8?B?a09xYVJFM2hzaXlDbUFkSGZEc1AwclJOaFhSV3A0dHVMbzd0dUFiVEU1Yjkv?=
 =?utf-8?B?NmZVNGRXTStYMkxOVmRrbUJzYkx6aW45eDJUaFdJNk02cXdiM3ZnZHlNMkZt?=
 =?utf-8?B?YTdac1QySXU5ZWoySEo4QnZRZEdNK1E4Rzc4aGZxd3RFVC8zbmlrblZkbnFT?=
 =?utf-8?B?ZWRQeXZPc0dGUEpPWFhOaCtZdjI4ZlhYMU1ZUnZ0MVVHT0VmYnl1ZWxTSDFu?=
 =?utf-8?B?dWJZeFlORUl3Wk9NM2xacGFUeEpCYnRNUWNWVHMvS21TL2FHeCtBdVBtcVB2?=
 =?utf-8?B?N2xGL0Y1b21QaU9pZGxhelRGaTJHTlZFMGEyVVZLU1EyMWZoTGpnTHV5R0RZ?=
 =?utf-8?B?WFFia1FVRlFwaGk1UGd3UzFJdmpJWCtSOUdKS2ZTaXRkdnpBRDlPOHV1dmJy?=
 =?utf-8?B?N1NuSGZoQ3ZtUGlOcS9QYnpGSVJYRkY4R1ZPbTZVc3daMnorcjRsWUZad0t6?=
 =?utf-8?B?WVF5LzV2Z0tXNm9QZlh5MTNPcCt0Y3VjbUNtZkdhdUhPazg1NHRJRkR6dDAx?=
 =?utf-8?B?VWV3R0E2OHlaYzRtM3l5Z09IenpMVy9xczJZZE12Snk2M0k4SktRa3JtdEdq?=
 =?utf-8?B?Y2xXWGNkaUd5ZTJXZFcxcUdXbitFV1VJS3paa3p6aWQzTGdQaFV1REU0NXVR?=
 =?utf-8?B?QU1ReEVpNk9sSnRVaERDSHFUTTJYSUE4QTkyUFhpUjhLbFVSZE5vSmZId1ky?=
 =?utf-8?B?ZDZ5eC92dzNKQjRuT3ByMmxzLzFVQkFsbXZrY3VYSlgyRko0OXVzRk5yN1Aw?=
 =?utf-8?B?U1ZBaW9DOTBKNzB3b0ZxclBGRXJwR2NOSEo2Zys4TmV2Wm5tNHpldld0d3NX?=
 =?utf-8?Q?AMPUSX0uiYe8/RP+KO4SYxawm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf3a2ac-0396-44b9-d121-08dc5d2807a4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:42:49.2307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoVbXIPoTrR6yRkdyIdc9JbFmuSW/kG5PnkPyjpBgWIHh3p1BcXEDZ2l1XCFMx74uLVioUFr8nExZVASNUeDQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8138

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
Changes in v10:
- Convert the SCMI -EOPNOTSUPP to pinctrl expected -ENOTSUPP, see:
  https://lore.kernel.org/all/CAHp75Vch7TzevZQK4CE_WSVOgUdzODkJXiv0=OuqrmDfgevV+A@mail.gmail.com/
- Link to v9: https://lore.kernel.org/r/20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com

Changes in v9:
- Rebased to next-20240410
- Because "pinctrl: pinconf-generic: check error value EOPNOTSUPP" was
  applied, so pinctrl-scmi.c not convert to err return value for
  'pinctrl_ops->settings_get_one()'.
- Add R-b for patch [1,2,4]/4 from Dhruva Gole
- Link to v8: https://lore.kernel.org/r/20240405-pinctrl-scmi-v8-0-5fc8e33871bf@nxp.com

Changes in v8:
- For the devm_x, I still keep as it is to follow current SCMI style. In
future we may follow cleanup.h, but it is not this patchset's goal.
- Apply Cristian's change, and add tag
- _pin -> pin to drop underscore
- Add headers per Andy's comments
- Drop casting for func->groups
- Minor update for coding style
- Link to v7: https://lore.kernel.org/r/20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com

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
 drivers/firmware/arm_scmi/pinctrl.c                | 916 +++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h              |   3 +
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-scmi.c                     | 572 +++++++++++++
 include/linux/scmi_protocol.h                      |  84 ++
 10 files changed, 1657 insertions(+), 1 deletion(-)
---
base-commit: ec3243f13db334437b5ce253be2fb23bcf35b490
change-id: 20231215-pinctrl-scmi-4c5b0374f4c6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


