Return-Path: <linux-kernel+bounces-149449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBE98A9141
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3401D1F21C08
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A474F1FC;
	Thu, 18 Apr 2024 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MqmIFShg"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2082.outbound.protection.outlook.com [40.107.15.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C812AC29;
	Thu, 18 Apr 2024 02:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713408322; cv=fail; b=BrWOaDfZ24n3a78xNjYsSf8Hsoahx319EtLxn5NdFlL4kG7GXukLmPOjI+IQ7ISfgdtqSftRsb2sAL1cOjQOyBQE9+y9dn7HeRdi1m5yeiXPsS4LGmGQuIERRqENt0Wjt7IAwueRTgk+bVbia9zlUtQf2FD+bCurbVWW7zSOou0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713408322; c=relaxed/simple;
	bh=lT9GE+1s8i1E698svR3iNLdIFrZoNR8wvubhJlvF8rM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=a29XDY3Qm+KcX1cP4LOkMr3DaJ5V7RZbTvELC2sP7dcU/FY1RJboRfnbPL+CuqqNIrck/cV5Z7GuMJLKMX941vdmXWGoxipe9w7VgxbFL+GhfzxOurTPjeZWC4Ue+oDMue1ASxzNp2++6uvgII5ZZ+nYrZ55uL6/GrJy2YntYL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MqmIFShg; arc=fail smtp.client-ip=40.107.15.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REc2OiedjMSFO96QD1APB4PWTfi4FWRb8WOltJm8caOXEXRgqJORN6ImjZAptB+MJe7BB+4FqcyvfaEDjUTRWZ+AEZMw5kHVQ6iNeBSxywTMbExomIBOn83ODYCVMSb16AqpO5BGklGfGKWwYRnJZrHKklaKr2dqoxWm3q297xDOb9Lztn/fQJbOasaOJeAByjW6xYNXmQyAqUmwGVkJqXwN76kszM6+zHLnA8kErKlmtRGQ+Hu46Xnk2aB4/UHzlDNFOuQmQqRmFreEt6VSRmtaDDniuSAHZkGL4FMuruP/1f03CcNe79jhIn8EqZ/sw4n/Dl2AmHoaUVtHgPWOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlzGtxbOTFzauebolaG1PB+Fe2aCtZU9A8CJGcEztWU=;
 b=HD4ZTWuav32G+jjpFzx5piXvWCbq5tjYt18frObOIzTedq4rrwkb6XFu3JDYt/otEVb2ruab3ABXeS5+CuBp2Q5NjrSDYAD64koy1tcPkNYTQOIXQLgX8be+D18fFIT40izeQyUWsqgkla/m5qJnXX6okNNsl1V6vP6jTB6Zaxy1gpGIP1H0uSyBnVyjZi4vl8rgXLtIFCN6mxjYDCL18mbkTBjzpvLEEjPTsJL6T/cm54Mml4oddQ3VjmcQPV4Tzw2CZoj2HX1q6s+xA8o9smWUPdvROy8NMcbDb4w2fOoKSFpkCyoT3bx74G0QW6y8s72h2QwliNIs7d7fQbgs1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlzGtxbOTFzauebolaG1PB+Fe2aCtZU9A8CJGcEztWU=;
 b=MqmIFShgbnbdio8+ZRJbABM25oXFHzGg2lcIMKpzXy4ZViinJ4DG6OMlASc8AC6l5ZrPxBG/I3Fv//yEtDoWNbCWjxVJTiXCuxp3CqTK9XKwVzuxXgCYXCJbYyfErlvU99j5C5NT+Jp3JWyqEA8JfJo2ehPt/HIpCs+ec7AP0aI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 02:45:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 02:45:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/2] pinctrl: scmi: support i.MX95 OEM extensions
Date: Thu, 18 Apr 2024 10:53:16 +0800
Message-Id: <20240418-pinctrl-scmi-oem-v1-v2-0-3a555a3c58c3@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAByLIGYC/32NTQrCMBCFr1Jm7UgyjPiz8h6lixhTO2CSkpRQK
 bm7sQcQ3uZ78L63QXZJXIZbt0FyRbLE0IAOHdjJhJdDeTYGUsSKNeEswS7pjdl6weg8Fo18ZWv
 IPDRfFLTlnNwo627th8aT5CWmz35S9K/972tReFY8EtOJ2ep7WOejjR6GWusXypTlhLQAAAA=
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@arm.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713408808; l=2021;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=lT9GE+1s8i1E698svR3iNLdIFrZoNR8wvubhJlvF8rM=;
 b=PznJmjthiqxWigQIct+MOXGcraNxZKMIboEwuCIRSCpMyLNbbimHPmk+TJ4zmpI14NSEFDhr/
 SX/xfu9cED1DgOXu1ZSq0poPakWcTENuNDVGU+/qgurVcW4I7pBDrXH
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU4PR04MB10401:EE_
X-MS-Office365-Filtering-Correlation-Id: c42a28ad-8223-44be-0c72-08dc5f51941f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	egIYkorTO6/uvZsjU7D9bcNxwH7t3hQPl2SRFKER/pL4YnpqOjkrlFG+5Ni5+jlbr27BE3Yw+kpBW8Dt7dCbNgP8VJuTdsTy8+pGyYVk8Pksp5hUPLRwj3FCOeV8ftr1I/ULGFSnqXxUBarDqZqNWf4XANtIz90Db93Gq26/SQkmmI2Nn3UPdb6Xc7qI6AkUQdIED2YHNgVBj70DfajEg4SSNBDna4sDHMTkOQhvmBNUpKpicIuWegikZkHeJFO2ZMhwYgkQdAKTboEPHwIS56AuqAO7z8BtBKEBGrkZJaEDmoBeQ/iXKpshEQrf15Dx7MizaqBG+FaSYK8yJG4WUagvpeffLkj123uxUwjIFhMWETQ36URgsMA/amy164ZjUfRH+rwTHpfYDD+YwIRNEWkqMZkZ4GselUWmifRPkmisck8zjmFwDAU3UM4aIw1vVIByKtbw28hNgr2m/RH8tMo3bUPKviIljTgvJMBbXTMGsqYec87xgZGcTQO5IhuDAzkyywlyQTlxJqPqYpu3ehmpQUA6S83kLicfwfzKuybNLcWiKTrzFnCZsfITmha7gyqiPlyLZbJU0o4tp0jAXD2MZlTY+iIOg3d055VkmKM7DSCjsJ+1dMlW2JOTCNa/YUJtZSoGdIIxO5yE6I7c84h9lb0Snrx8ZfXJW3rtYw89QPNl1yJu269yVbSRmmuvx5uHdXiA9eqjNELsFtFKRK48/xCS4wKEl3Uub6T4l4G9WgaTeJ2FzNoiogT4fF87
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3I4aXlJcEhNRHQzUXZZWEtsZ1BVWUpkZktRT3NIRFVyUm1nbTAxU3o2RDJu?=
 =?utf-8?B?UkgvNjNoVFlIa1hSWnpYNy8vQzJzWVlwRTNRODFyNUZFbnk3Q2llNzc2Yndj?=
 =?utf-8?B?YXFBRG1kRHdMRUpDdzA2dGtVREMxSTVoOEwzNGRoTTBNdHRqajZDeEJrWGQ1?=
 =?utf-8?B?YmQrY0phdDNDV2NQam5VTnlxMTdhNjNNR1JzKzgyYWVKQ0pBNW0yVWpaNFNU?=
 =?utf-8?B?RzdkNkh5YXVQQ1UzQzUwU3lCaGd0MXlNTnAzMEY0VUg3STBXRWlEbkcydGJp?=
 =?utf-8?B?bWNxNnplWXpPYklKcHVYR25kdnBxVVhudkM1SFROWGwzcGE1Y0JuQSthOWFQ?=
 =?utf-8?B?Y0podWMyMUFEbUNRa21FWkFmbGpPczV4RWVsNG5CTjBQVG9wZENRRktpbyt5?=
 =?utf-8?B?SXRPWWJpOW9Xa3IwRkdad1J5TW42SXJHWVZaK0tSUEE2Qk1rT3RqazF3TEdm?=
 =?utf-8?B?RTJIVjAwUEwzb0lEMDBFdU9NMHhFMEpoYnZQTWhMUFNyOEtmWkxMc3JVak9K?=
 =?utf-8?B?V3dqVVRIdE9RTk5ieWg1Q1Z1RzBYUzRnWGNyS0k0OSs2UEp4bElqbHRFbFYz?=
 =?utf-8?B?N2psN2ppUnNXTEIvTzNPZHVEQ2U3ME56Y0VvZEhzYTAyNHVOTTN3TVZnbHhC?=
 =?utf-8?B?aTFTaGdBUkU1STdrQm5VY2ZieEhtWTI5ZGRNdFA5Y1k0MW54WFFwZ3pUK0dt?=
 =?utf-8?B?WUpxdXFxQmVCSDVIRlNjYWlJektXcVd1Y2lMMDJnVWpxcWZrRDArbWNDdmlY?=
 =?utf-8?B?Q3E4ZG1aSHd5RnZrdCtQaEZtZjhPYzNudEY2VGhrZ0R2MkRrOGlSVTI3VVlW?=
 =?utf-8?B?Y1VPZlRYb1NBUldZSVRQTERxMmU2aTJMYXVoZGxpQkFvTXc0bXVsdFVLenl2?=
 =?utf-8?B?RnJaQ1R2ekZnelZSU29zMjRpUUd3QmRJdnNuS2luZ1hnbVVHeDJ2L2N5NWlM?=
 =?utf-8?B?TFV2cGNaVmY0RWluNm9wbEZLRXNGcVpaRG8wSnN2d3VCcmQzeGwyUEhQTjRY?=
 =?utf-8?B?MjdRN2c4NkNyMUwzV2RTeDQ0K0dqbitsamY1L3VYK1BOaUNuWjBqTlYzSnBu?=
 =?utf-8?B?U3c3QlJWd3pBMm5KYXFpbUYzSFpmZGlaYWZkS1BieVlVVjdFeFcrdnhxejgy?=
 =?utf-8?B?OG9OODg0ai94QnhwUVVPT1V4RC9IN3JUbzB0LzZUZytFUHl6eEFOQ3JEVU9F?=
 =?utf-8?B?Sk5VRFpINzFDRS9YdGFEZ3BLeUNZaXMySWNBd3JqWGdBdDdoSy8ySm01Zk1O?=
 =?utf-8?B?dnk2UWV6NGxHK0hkMVpFa3Y3OTdpWVdBdGY2S2R1Y3hTd1loakNDWHlvS1U3?=
 =?utf-8?B?MEpDUUNVSEVkdWpYcGx3NC82Ums4ZWJhcWp6VFVhS2czRmt4bkNEbHlZV0FF?=
 =?utf-8?B?WFlaZXhQajE5ZVl3OTI3TDdZeWJaS3E4OXdmdEhxejEyVjk5YlVKQVh3Z0dX?=
 =?utf-8?B?aU9ScWMwL0x3eXp2aGZyQjE4MWNwMDlxUFVmamxPdUs2alhQQ1REWkM1eGdp?=
 =?utf-8?B?NzZZbncybGp1YmpoTFhqdU5yaEFlUmV3K3JTY1VoSjdZNFdwR0FFMC9PRjZS?=
 =?utf-8?B?aHFFZGpDRzhabVFQd3VNTUNra0EyMVM1T0lBY2I1Z0pkV0YrY3R0djRKUWZU?=
 =?utf-8?B?OE5TTXhYYzJ1Zld5enF4eDRLeGtrQ0E2ZlkxemdxeHdEMHVjSmsyYzl3dm5T?=
 =?utf-8?B?WllKWkN6elIxYUxCSGJ1RFZBZ2Q5Z2Y4RnlFSURUeDlFcTJ4QWFGdXp2d2xy?=
 =?utf-8?B?cDBoZmowOG13WkdhTzFrMkhVdUpmMENGR3RrRmxicWZPcFFMNENWTTg3bVNN?=
 =?utf-8?B?KzQxWVdsRnV2YzNSMExNSjgvUGlORzNOMS9VS2hVNEFTbUxSTEtEK29PWTRO?=
 =?utf-8?B?K0RzTmg3UTVNRFZWTXdud0dITnZkaUJmcDBUZmdhMTFkUVlpdW5ZS2FQZzZL?=
 =?utf-8?B?RklKa09iczJqdisyWXFhaEZWb0dLdXNFaUVzNUgvei9PZUhOaGgvZ2ozNHBr?=
 =?utf-8?B?SUtmeHdlZUxyUHluWk90MVQrbXErRnNrK01JWEpWU2dpOUtlMGI0M0FzUFpO?=
 =?utf-8?B?VEFpR3VOWmpKNDBlQkhtNEI4ZWdob0pIMkw3TG5JN0RIMzVFdVM4QkIra1h6?=
 =?utf-8?Q?BVcdihxTVa/2pR4R1W9hxP2ie?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42a28ad-8223-44be-0c72-08dc5f51941f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 02:45:16.3500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLKPW2wRcccCHeINoZOglMxTd86Tjy+5SVUMQq3ofjzJ4W4R9E3Jp5GF1a/WlYk3yaW0TA4yVBmSOXfin4/ncQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401

ARM SCMI v3.2 Table 24 Pin Configuration Type and Enumerations:
'192 -255 OEM specific units'.

i.MX95 System Manager FW supports SCMI PINCTRL protocol, but uses
OEM Pin Configuration type, so extend the driver to support custom
params.

The node will be as below:
pinctrl_usdhc1: usdhc1-pins {
	sd1cmd {  ==> this is needed, so there is a patterProperties in nxp,imx95-scmi-pinctrl.yaml
		pins = "sd1cmd";
		nxp,func-id = <0>;
		nxp,pin-conf = <0x138e>;
	};
	sd1data {
		pins = "sd1data";
		nxp,func-id = <0>;
		nxp,pin-conf = <0x138e>;
	};
};

This patchset depends on [1].

[1] https://lore.kernel.org/all/20240418-pinctrl-scmi-v11-0-499dca9864a7@nxp.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Rename nxp,imx95-pinctrl.yaml  to nxp,imx95-scmi-pinctrl.yaml and move
  to firmware
- Merged patch [1,2]/3 v1 into patch 1/2 v2.
- nxp,imx95-scmi-pinctrl.yaml only has patterProperties for subnode
  The pinctrl will be as below for i.MX95.
	pinctrl_usdhc1: usdhc1-pins {
		sd1cmd {
			pins = "sd1cmd";
			nxp,func-id = <0>;
			nxp,pin-conf = <0x138e>;
		};
		sd1data {
			pins = "sd1data";
			nxp,func-id = <0>;
			nxp,pin-conf = <0x138e>;
		};
	};
- Add pins enum, correct description.
- Link to v1: https://lore.kernel.org/r/20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com

---
Peng Fan (2):
      dt-bindings: firmware: arm,scmi: Add properties for i.MX95 Pinctrl OEM extensions
      pinctrl: scmi: support i.MX OEM pin configuration type

 .../devicetree/bindings/firmware/arm,scmi.yaml     |  9 ++-
 .../bindings/firmware/nxp,imx95-scmi-pinctrl.yaml  | 66 ++++++++++++++++++++++
 drivers/pinctrl/pinctrl-scmi.c                     | 23 ++++++++
 drivers/pinctrl/pinctrl-scmi.h                     | 15 +++++
 4 files changed, 110 insertions(+), 3 deletions(-)
---
base-commit: eb2d3938aa00d2ef504176b77db1735b68763652
change-id: 20240412-pinctrl-scmi-oem-v1-494ca2ab1480

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


