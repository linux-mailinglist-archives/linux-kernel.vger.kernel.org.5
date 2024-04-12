Return-Path: <linux-kernel+bounces-141739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BED8A22D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D4128669F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000B728E7;
	Fri, 12 Apr 2024 00:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eNuPjnuN"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2077.outbound.protection.outlook.com [40.107.15.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BD736C;
	Fri, 12 Apr 2024 00:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712880803; cv=fail; b=IGUdjVGL3S6VDTMfMbV8kamIhggj3hK+AxPZ6+76X52a5HxhrIvHIbZ6Zvl3H6seEgEiru/QSeu/Pj/WCF1brWKjpB2QdZKIhTCcQ01RlyhS1tUjVwg8BqsmZv7Mw+FAkSqtieIM5vRQJZegaTV+5hebbL07EDK49lVt3E2S670=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712880803; c=relaxed/simple;
	bh=L7NzV2X3njXJjCHeGcmi5zG8v4ej2MaV6Nh2d4UXQ70=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=jnQpDPkEfnr5xa99JSLV1DjfaYCkZC2A0Is9LRT4UxP8VQz0SwPYMjItk4apDIYp/JmD+SfX3jGGEU+rgtkqplBf07M7SkUXdVjl8MlJCHTwKJ0Gtl/0nRPqlPEvRxKHkuDTN7IoXRlsWsZlkS7pvn5tVPg5UqzYRJFbxOLAweE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eNuPjnuN; arc=fail smtp.client-ip=40.107.15.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoAXP6oQzKZf734et54lqrT7oSNyjn1EHSsCdGl2UYeQ4BjhpiOXA/ODLoPnUgry+/rfNChOfpsQuQsV9GJ1U8BZ6MDBS34TsT4/VqZZubAhrhoeSH9oNHoHkEvIL4NOWYvLcjE5DztugUjYs2ACQdolal6zQEWlIHoURCe6VYjkoYEljjzTDyDnkJT1ydw9p8kSQAltrfXjf8WdM8xZ+7q5cEe2R2BNvovozddppBPizvCnpT4rvKQQfHmH0gH309MajL0EXGDtqy8ZCxumwHYwpQj6nljzKaoqvEqJvC1vO8an/9HiBubShT6i4bIY7ZOSMuSpWhKa6tO93t7DUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CicC3K7FoGSKEu6c0SKjBksizuTSEyf2o8n+qE6bh7s=;
 b=UWpVVFIparcHFsKCszgl9ZkOwm0zSkpl135bHtYvyVjFQjMkRvc9Pq+ZonKHxrTgkV0xU77BEzW+Tuj/+TqYWTqMdAWwnsmCi/zpW+2vIlrzCkXEI6j/CcaCEBofD3It7cBpTctLGFpEWND3ZBbKDviMcrTlmbO1a5CC9n02fVB0YzfptrQDzkbz8D+HY90NdSypPVAOBjH+d15aQBaD/LdoTQH5CZ43hBW0qbExyunLmVG5gw21SR3FAkzY0ynkUO4V52+LNeCyFsntiF8pIrjNZIx0UrjpJdHxR722DruGczhzJLiWjIP3ZofrvD6WU5dOjqRPi2tEe0WCjvoiBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CicC3K7FoGSKEu6c0SKjBksizuTSEyf2o8n+qE6bh7s=;
 b=eNuPjnuN+eIHYwIwg59mMNL8oejDP7Avm56YFw5BpCQcHWtnzyIvSc1jBI0J0DowgbttL3j5qy069ATpwRne1cLL3dBCuwv7lNlKsxbUxxVH3dRSXQq7qImVeiNzBN1ILnvuOLMqm9I6halo4bjlQKBFz2/b/0PAWHopW80bW1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7970.eurprd04.prod.outlook.com (2603:10a6:20b:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 00:13:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 12 Apr 2024
 00:13:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v9 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Date: Fri, 12 Apr 2024 08:21:18 +0800
Message-Id: <20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH5+GGYC/3XRwWrEIBAG4FdZPNfijE7UPfU9Sg9qtCt0k5AsY
 cuSd69ZKEksPY7w/f+oDzbFMceJnU8PNsY5T7nvymBfTixcXPcZeW7LzFCgBATiQ+7CbfziU7h
 mrgJ5IbVKKjSskGGMKd+fce8fZb7k6daP38/0GdbTf4Jm4IKLFCVF1QAk/dbdh9fQX9kaM+MvV
 QKEqigW6qxvTeM8OaOOVO4oQkVloaa1yjtt2+DMkaqNIsqKqkJBxNIotUVdtdJGJdQLU6EeLOk
 mEumER9rs6J/WZr2rsYRKIukgjlRvtKxcUV2ojI7AtoChfmGzp/XnmEIpBROlNBp82uiyLD+yt
 gKlQwIAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712881290; l=7327;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=L7NzV2X3njXJjCHeGcmi5zG8v4ej2MaV6Nh2d4UXQ70=;
 b=61d3Mk6zviRFU7urYrcngOirnLkXyMOFoLzQ5IAIfhTO5Gg5AJy4TC3yD/pzLn9WLsDhbUDnL
 lrMK3XFCuVNAw19jnukLMvDcNhqjkqTWH7ekyl19IcEqR+majMASJST
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 3454ca77-0aa8-4f4c-27c7-08dc5a855a00
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MgLReN9Kpv/4LfQ61Ij8DQTvMV2JqwtQbx4v10tcTKAcmAJIY3ByjXyxOSfsV1BJO/oBiu+0SB6m9Pqk2KVHeT+YvV0tNd2pe3fPvkvBY46HRA6oAMOHdexgqrqP1Vhu730s+V/Ezzyp6Oh3XERKUWLNrgMtUO8HKIm7EoBathAKNfl5iX3SlwotYDgzdc2KH2QixsGBKsj3VftB0utPUOu+RoJyN4TaE+wjzA4J3qFXweG1Kv1rqkQEhG+qAk07ZmNHIBqXo4PjIbaIbvY1/ClOEKTPDAuucMlHRQO2DRz6V9rES+zDDjF1r/OCNqJiRfl1rpAVp0EYozSZfS9njqfvV9NPsEijCQa/a9rIjsPU8nW3EedB9Ukpks/Cb5j9wxFJwB83kjK7CPV79CacBXHd+h4CUQlN8daSvQX4R7knMGHJXwyRdv45cueMYzTp6odWohMRL3xXACX0gMQfW2Liisuwk61lBE2BEs0uwgPckVDvUqqpO6kXctqiC+9ncav0s0uw4AxHdk/cwCuiRbjI3dO9wJvGhDvcs1wyp6G5y0WAw12WNAw4Gw6OS8EmVFE8eqNfmEYO7/DWSx10aUsnAk3DDklBDx8alFhl939Mn/15NU302yGCXMm7QzjhLTC8OauUn4EDuJD+/2eaUD//dHHeLo/FOhEVGq5chPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0lQYSt6M1FYT0FEbjhMU0NZalpOOHFtcXgwRU5FdlhSNVZORmJjeFJuV1pJ?=
 =?utf-8?B?K09GblBJdGEvTDVGQ2x3N3MwZzBzaDV5NWN4Vkd3ViszWjFsd3BveHlHcjFD?=
 =?utf-8?B?M2c1Z014QWU5UWMxcnhGTlVTOTB1NWdqWXV1aXo1bjVTTWtHaUhBUjRVNDIv?=
 =?utf-8?B?K0JFeDl0dTlqeXdENGxrSU1QM2ZHeUhaQmxzem5qb1cvNGFCN1lqTWZmU1pM?=
 =?utf-8?B?dnNXQURFTElzYWhaTWlLTEtPNUxhNmt5R3JjOGI0dDNtTmlqY3NVelZLQXp4?=
 =?utf-8?B?Rnh0bTNpa1p0T2F2Yjc4U2NOSE5TNGtMdVV4NWtnY1QrekVVY3dnUTg2MGhw?=
 =?utf-8?B?aXhlZXFBWHc3N2xLN3M0THplYmxnUnJJSTJaeXRFRUN6N1EzSHl1NFNqN2RE?=
 =?utf-8?B?dDljSTVmS25GN04yVzVCRDV0ZWFFazdYbit1RXZ4M0lGMFdOTDRBNU5YcWxL?=
 =?utf-8?B?ZWVwUmdhdE1FbFcvZmcvTzJHd0d0MUxpdUVmOVFldi9nQ0pMZUV3dFBPbitR?=
 =?utf-8?B?MkJwenBETU5zZWFWNE03SVdKQytUVTk5WURseXBaamc4cWtrRnZWR1Q5d0pS?=
 =?utf-8?B?S2NrVzB3eVhwR1RYSndyREx1VWEwdEhQZEEwUWlqQ3pXd01qK0txSXZHUDg5?=
 =?utf-8?B?bmcraHVkV2N2TjV5cFlONUJTRlZsTUFHRVR3bml0RVgwYjlFSVhiTTQzRW5q?=
 =?utf-8?B?T2xjVEJEb0ZPOE1aaVZjeERETTltMEU2SHpYMW9aM012aDhWWGpEb3V4L1pm?=
 =?utf-8?B?eVJud3hCTzBsUmtIbFE1b0JBcWRZSlFobUF0N2M5TkV5MXEvYU9SNGExU3V2?=
 =?utf-8?B?c0oycGFzbmhZc0toTHIvWG14UG5wVUZyRlBTcDNPa2RLajVNZmVFSkNNWG00?=
 =?utf-8?B?Vmgyc0RTbFFOcWlsQ2FpZmdKcFFOeXgrNFltakVYWTMySThjVXd4eTdHUmNS?=
 =?utf-8?B?eTRBMThOU1NhSmk3U01ZTjR2b0d6c3cvYnlsZVJuUEhRditJOUsrV2lXelpB?=
 =?utf-8?B?UkRqdUNQZVB1bmRLWGhyVU1yT1pFZ1Rsb3Jsc01WamZYMHZGWWh5c1pQZ2hP?=
 =?utf-8?B?dFFpMmttZmFZS2JGSlpqOVU1U1VNdFV0U3FGRmN5Rk9mOW1DeTZXYUthbVRr?=
 =?utf-8?B?blptVUw1NFJLQlpNS0R1enIzVzlqM2JuZTFvSGtMKzRoN0VpaDVzNXZ5eE4v?=
 =?utf-8?B?YVg1QWkyOEFPQkFxZE5TSGF1Ry9QQ25GUkdDTXYvVHUyVUFjMjhLSHNWYkpG?=
 =?utf-8?B?R1BnY0VVY2picXhVbjNEZ2dpYWg0cVIyUWlUaURybUM4YmZFVVhTS0pmbkxw?=
 =?utf-8?B?eWlOUWgwUTd3aW1xcjRIRmkzUEdkQjBTakFvcTdyMElEQ28yQ2pNZ3JsSXNo?=
 =?utf-8?B?L3BhTGFYRTVlZTFQaUgwNFdDNjdMbVhLVlFwbWU2QlZ5MG9wN3gxU3JEWUgy?=
 =?utf-8?B?THJkdFZrOFVNTHliaXlZZlowWXFXdVZSYVpGYUxFbVMxWTNLQkdJa1Z1VlNP?=
 =?utf-8?B?UlkwU2ltUEdKSzFHb0V3dldOWk1nYk82cWc4clcyQXRHYlp2T3JoRGkwYXhw?=
 =?utf-8?B?V0pXZjluY2kwTUd1SndJcDE1enlnSFVFQ3hOZGJ4TGI0b0JoUTVBeXR4YWlE?=
 =?utf-8?B?eDFkTmJ4SVY4TGNEMldLVExRekRQRG5Xd0lrKzJDc1V3U1dqWUxUK1dDa085?=
 =?utf-8?B?R3lESFRPWk9TVVFpYTlpZkhSN3FadU84VzRSVDdEVzRqc0VuWEJrZTFDUk5H?=
 =?utf-8?B?Z2c2U1dJd2Z6QmZWalJlY3BKc3gyWGZpWjdVOW1odm9kakJCajZENTdTUFRV?=
 =?utf-8?B?QXZGVktkMG5ZTEVCaStZM2ZhNTlCNWg5bWh0VHZ3eEloVWdoYWU2ak5uT2g3?=
 =?utf-8?B?MUdPdEZOYW1Sc05mb2ZLZW00SDVTeXBveS9jaXhCYTFSN1hRNis2Ump1QlYv?=
 =?utf-8?B?RFpqWFdhT1BTaE95dWJjclJwREd6blB1ZE56clZPMWlvMEN5ZUIrYkFYcFhn?=
 =?utf-8?B?U08xNytBbjFSUk10NmQ3bTM0MTZmSDVFeDJMV3Q5dlhDWXNtVUl3Z3BMRjEr?=
 =?utf-8?B?eEdETlh4Nk1oRklCT3JtTGpzVUNVa01YTkdweUpDQ3RvQjIyclBjYW5EMlNt?=
 =?utf-8?Q?lw620kLlO5LTf3sWpasg9dNJT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3454ca77-0aa8-4f4c-27c7-08dc5a855a00
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 00:13:17.0233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcT4I2fWgP/iN3+4gPX7/9BRtRh+nCZ1091kuUI/DLgvEGMTvQgteljJ9ijb09TnQIdDEK22fk9OAgdluAS5fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7970

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
 drivers/pinctrl/pinctrl-scmi.c                     | 564 +++++++++++++
 include/linux/scmi_protocol.h                      |  84 ++
 10 files changed, 1649 insertions(+), 1 deletion(-)
---
base-commit: 0a6816a29018d80d15e3adfac7c444aa20eeb87d
change-id: 20231215-pinctrl-scmi-4c5b0374f4c6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


