Return-Path: <linux-kernel+bounces-159124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDD98B29B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F6928515C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBB3153BF2;
	Thu, 25 Apr 2024 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kiXa6Zur"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53A153812;
	Thu, 25 Apr 2024 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076702; cv=fail; b=urFVoBUkScTa8wrAHjc2PeLVBvMGC1v0BaENxARZEUr+72MNLYTuAsSJ6+zTD+p7BpHwZLN2N8WDZjidfQBdaj9xRnI/1DrIGfP5bmbsyfPnTuVi43YgVc1TKr5BTHfDVab+zcR2zSFtJpRXRxm3BGOjFt4juX8gZ2SpiUdphI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076702; c=relaxed/simple;
	bh=P6LypuexdM29ZVnlOc+SqUb1sJ97O+y6kEBv8SH6Tzg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CrxnDr8h4qTDsqpiqnCOFBme1iwcp41BV8YNSSyWRnlNysqw5sum/cCmSZysTG5ah/JH+gNNSwLsxJ0kMU4CZXW4lHQTKkYcfVU4bXmIy2g/2+vaczV3eok3GqrEnEyRb056j24hvMUBRJOL+t9wUU/lsSJFvq9ozp41+UQ2j80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kiXa6Zur; arc=fail smtp.client-ip=40.107.8.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTFdErtJh/J3vvaeLnFe063A7pfzfsz0qWa0DojfMlkSB/QTHFe6ZA1V9i/QkJvkoNMr2Ib2fiPizO+nN6X6qR/L8KzKLmu2yvNew1v01VjX2M0wm0UFrB7fHR2Ks9iURTEXYBiot7lkxAcpXGpPiQBWSnxwrQ+8l404x4CsiWsphfKTk2U8lszLuQz/A6awW52USaXI521/uyv7xllbXU7RAA//EcoJpUjcQHJXXl5FSqm/tsrMeby03yUik72ypVxmEJiu01hk16pZIZyj79CSjAnCa7kBsfKfw8KjU4hzlQY7Cgxo4XZGG2DtPTxOc5+JZydlC11B+OCCnDHAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8rQTmWglgESXNlLjT8xBf98KoviNvxay8re42WfcZY=;
 b=Mi0JAViATCgT87KeeFT2gr5gVB+2r33X8ZiCbtE5MjAEvaOnqWaCVdBS7sEqocnMjyf0qjiovkiQjemcnJbzjai4H0d+ycXEFTbvULVYlGzr0W1xAX75ykuO+PG7tZxAW1bgeUWyfoaFVtXp+VRrZ6Hq/Qk47k+vIZ+nwnyzYYW4YWgPe5Ik4on7deA2yBbdtPQl8xz0cqieD0tX494PPEv3WJsEQER2Uy30lvP2hKkqPAwYp0J2hlrxdQpur3iso+8x3IvAAz21Tqmq7rn31LMvv+CUzoihZiWUA2yB7QwAfN13kt+i38DVN1bCwQiViXcvGlMDNVvbKddH/mZp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8rQTmWglgESXNlLjT8xBf98KoviNvxay8re42WfcZY=;
 b=kiXa6ZurGj6uu0t1FtTJ/7UB6iBaiODB9k1u8htyVXWgmDAqYoDTwhuC0NrbeZhP4+hVYZYDEAU9RYIyRCIYsUg9tS8DTrtysHsY6MsWgCFKIz1c9WApFlj1DXYxukNacqfhbEHlglinka/6B4KujLygDModDrDGi0I7AN1eSlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 20:24:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 20:24:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Apr 2024 16:24:38 -0400
Subject: [PATCH v4 02/10] arm64: dts: imx8qm-ss-audio: add audio nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-dts_8qm_audio-v4-2-7fa6ab2fd64e@nxp.com>
References: <20240425-dts_8qm_audio-v4-0-7fa6ab2fd64e@nxp.com>
In-Reply-To: <20240425-dts_8qm_audio-v4-0-7fa6ab2fd64e@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714076687; l=17204;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=P6LypuexdM29ZVnlOc+SqUb1sJ97O+y6kEBv8SH6Tzg=;
 b=+GIVURTcj/1t0j7M+u7wyul5qikhApslCuJSdwV9pXbNSm0dqsOhHCVxpfneoSApX3xc3uwEj
 ECPivG4UWWfAebfx2tu9WYLMFh4MhCPZipvPnwAYFbYOV2oaV4uiuAg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc2aad7-4ad9-467e-1620-08dc6565c5a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|376005|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUVBRjdCdjJpY3Jsa3FJanZXMEMxV0VZZmh6SzFBWjNpWWkzN3JJeS9SSFdn?=
 =?utf-8?B?NjJ3Q1RlRHltL2RacERHbUhSM0lzOTlWak1LYmNtanpzOEYwdzAzZm5md012?=
 =?utf-8?B?Ny9wYk1BYmtuNFBoVzlGUG5jMUUvS2k2aUh4emxGWVZReklTTTFacVNtMzM1?=
 =?utf-8?B?RkRBckpISENtaU9EMG13V3I3aDZyalBENVpNaWp4d3hOMDJLS01SdjBoY0ZH?=
 =?utf-8?B?SXVSSE56TjdvbHY2eEVXUVRnRUNZVkc1VU1WdlBTbFE4ZkI3LzhXQU5FL3Ri?=
 =?utf-8?B?WFA0TWZ6RGE2SmQwSFh3VVVYQjVHcllVSVFsR0F2UkVUVHpKRW1LTmpNa3Va?=
 =?utf-8?B?OEFYMWJUejBsTWVxL0ZSUmJmNW1jQi93NVhjUUFDRmM1MHA1ZGg3YWsvbC9p?=
 =?utf-8?B?dVlXeTBjOVJOeEUvQ0RTS0pzK3ZtSkFhNG94L0VnQkNON1JFZVNLd1luWUM3?=
 =?utf-8?B?NDBvRkFvU1ArQjBBb0haVkQ1emN5dXpEZ3E1VUxKWXFvbjJpR3FRMjh1Y1J6?=
 =?utf-8?B?Z09jSGV4UEJDc0lZVmFvU2VEN1dzWnc4cW92eUR2TDlRUUZUY280S2ZQUEd4?=
 =?utf-8?B?NHdqQWxIWmt3R1F2TlBsN1JHS01HalliWnYxcDFaVG5nWUZ1UURTNUZkTE9K?=
 =?utf-8?B?QmwyRm1CVXRYOGhRTTZJZzlqdE9TbU9nTHB2ZmJudzBOWDRHVHNvblEwbGxX?=
 =?utf-8?B?WG9rUXgwcDA0VWlkTTBjUUFHK0xCWFRyNyttait4OVB3Z3FHcDBBbE5aamdh?=
 =?utf-8?B?TVk0eGxrbzVhQ2lhZGlyaHllZHVlblU5UE5zakl0ZmJkT1I4VE01bEJuWlM5?=
 =?utf-8?B?dVI4dVBYZDYrY2YzcVFNUUYxeVZKR0toZGwxOXU4ZlVNQUFHeTFVTHB3cEZP?=
 =?utf-8?B?LzFIM0k1aDhHUi81Vmk5aVN3djA1b2dibVVUMGZCWTFaaXdPRlkvRGRTUUw2?=
 =?utf-8?B?OTc5aG5Od0ZSczFsV3d4V20wMWZRRlNqVlpqUHVPQVdidEpXVFRrT2Y0a05B?=
 =?utf-8?B?SHhENHJCcy8zc2pvd3NoTHRmSk5GS3h3MC9ERXlaY0JHL1RWVWFvNHVsaFhs?=
 =?utf-8?B?bjU5Vzd4bS92K1NSZ2dLdHhoaSt1N2hUNVhVM2FyYmdSK21xWUxMTzliR1VN?=
 =?utf-8?B?YlZ3STdJUmNtUlV0WjYyeXBESFJKWGVoYWg3M0xmNkdtYk55bXY5a0RUVEZk?=
 =?utf-8?B?SW15WE9WcUJTeUx3YmZXeXY0R2hqdmVucFcxMUI3TXdHWHo1aUFlenN3TkJY?=
 =?utf-8?B?OHhEYmdLVWRXSUdWb0pQTGI1V3hBa0NxWWxlSERMK2tBSEpWbTZiNU5FdmpF?=
 =?utf-8?B?UEl3aElubVdpbFBBckRwSXcrd0xGNkNSbVJieVM4c1pyTzRPdllNcmxOdFVm?=
 =?utf-8?B?c3hHK1l5TmpyVG9FdUxBV3JJYnFodEVxMEtmMzlRQytaOWZaK2JyZFBqSk5X?=
 =?utf-8?B?ZGVFRlRPZ0J0dW1mRUhTVzB5RkxoYkJlL3Jta1NDVzZlL2thQWV2RXZLUFR5?=
 =?utf-8?B?LzkvRTVOb2x2RkVWOCtnYVdrUit2VE5xcklBbUZ1VWVESmFEbXVPc1B6a2Zm?=
 =?utf-8?B?R29aSUZEVmdJOU1NNzNiVHRCYWdZUWo1L2o5dkhmeS9ZckZTdkVtcnJjRGpJ?=
 =?utf-8?B?UENEeG5aOXgxQUFMT2wxcHVaYzN5Z3hFV0IwajI3VDhtVXRWWjVjRm9xckx6?=
 =?utf-8?B?dWJRbDQxVFZQMnVjTGR0bXVnWVJWbE1UdEhCRUJaQktRZVFiVDg1cHg4d2No?=
 =?utf-8?B?MDdZck9RT3RJbTFNQW5qSVBvR3J2ZUNDMnp5TDZ0eVpwOStkUUY2b0hyZzhy?=
 =?utf-8?B?a0xyYWJrU3grT2ZZa2xsQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmM0MG1hWVM3Y21BNVBtdVFIMGxlUkhwQ2tQTlRPZmdJbCtIc0ZZcEVSTmd4?=
 =?utf-8?B?K1ptTDFpY2lrK0tFMHBLSW5Vdld0citvVXYzNTIyd21JaFFZeEZEdkxmSnNa?=
 =?utf-8?B?WDB2SmtrK2N1bXVBMy9UOW8vWEJLc00zQVFFMS95TUNYRThWUFlRSGRFWVc0?=
 =?utf-8?B?bXJTZjQyRTh0dWx6RDZoODZlMTBObG05Q3Z4MFZaa0Y4b0tmMVFadyt6Nk5U?=
 =?utf-8?B?ZEFZYUpCMUc2ZERZSmtTSjF4QVdQWDI5YVorTmFGTi83Ri81L0liMmJqVU9F?=
 =?utf-8?B?L2xXZjA4d0pVd0Q3b2ltVHQ1ZVNiL05IY3QySzRDZCs5Ri92U3Uvelk5aDdi?=
 =?utf-8?B?UTB5K0RENGh5OVI5YWZyVTkwcmltZUlzZk1BMnVPK0VMMUVHYlN3cC9CSEV4?=
 =?utf-8?B?cEhqUEJyMDd1Mkl3YkhlUE9NN1VCM0VyT0NmbGkrZ09zUlZrT0hadTU4NkxR?=
 =?utf-8?B?SlIydjRWbXhsbFlZQXVJM09ZRmJ1TXlmY0ZvUFVNblZNR1FjY0xFWmNlMTJm?=
 =?utf-8?B?cE5jVDVQVVllN3NQcGRHVlBMVnNObE9XVFl4U2FNeEhmMXlvbVc3NHVBOTBW?=
 =?utf-8?B?YXFEZ3l4b1o5ckxQd095bUEvdDVaMGtDL1NCVXFhOXh4MVhjSytXN01hZWhL?=
 =?utf-8?B?L3EzWEdmWEVBMFZrTXJCMTR6Q2crRjJON3o4NG1ma0w2WUEzSHd0UDNWc1hz?=
 =?utf-8?B?a2s5bTYrRUp2WWxzbjVoNDVYajg5MDBsamwxSE1ZNllaK1F1cVRSVVNuOWRK?=
 =?utf-8?B?dUQvZmRMd0FBRUo4T2FtbGlERENGZUIvSVVXUnlCRjFEOVJFQ0FkM2x6MG44?=
 =?utf-8?B?ZnBiWUVRcTNYVE9rMW14YUFqalRIeGR6cWM0UWdLZUNrekZWMUFKcWZJNXpI?=
 =?utf-8?B?bEJSZHlUYlB6VU9paTc0VlVodjUydEoxRUZiSDRTUy9UZkEyL1grbzB3eVA0?=
 =?utf-8?B?a1VhcDVCRjFwSnJYaWtRNXNuNFgzQXliZUJiVWpwRzUvbjZrM1llNlBKUjdi?=
 =?utf-8?B?WXMwSkI5NGRnM2VZNGtCZkhwUmJ3bWNuL0tHRTBvZkdoOXRHWis4WTRVWjNE?=
 =?utf-8?B?M3NFdDZTSmRtckdBd1JDZ3pvdDN1N3BzbWtsUDdKMnp4VnRUR2ZYZHlhRVVC?=
 =?utf-8?B?QzMrQzJSaEFMSjkzNFdxMVQxR1NWRGE0bHlOY1BaNDFkYUR2OGU4MlhKc2Q4?=
 =?utf-8?B?bURYMjBmV1g5NXhTM0duQURGUnFHWExXa3pUcWQ0N1NnamRjTVZJczU4MG5j?=
 =?utf-8?B?WXp2SElBOXZwQlltdWRTYW91MWNFM2krZEIveDJBVmpPS3pmOVNybUE5K3c0?=
 =?utf-8?B?WlR5WlRGUTZMZGhJcjN1YW5JbklRQThORGNuUGZVQkI2SUcrNmw1RXA0Z1V0?=
 =?utf-8?B?OVdBZXZxUmVCSnFUQVgva3dsWkF4K1YydzgyTjk5ZTJqTktZeVYzQ1FLakZx?=
 =?utf-8?B?clJoWGxJVys4d3RxSHQrNTY4MVlWZGdLaE1SMUEwRk1aamszY1dYRzlCdTBx?=
 =?utf-8?B?Z2FsMGVkd0RPbXYvV0ZLUDg5bmZMU2Y0d0crcmdVRHl0OTFyMHZJQ0JNT2Qv?=
 =?utf-8?B?V3BaZHZGUGRSWHN4aTNIbnVCRzZyT2IxOE16MTdzRExIMmRCVVFXSWQ5c1pK?=
 =?utf-8?B?QmhjQmJ6UGVLV3Z0WHJjRGtGejQrUThqVXViZDJheWRzYnJqd3IzMU04ZnhO?=
 =?utf-8?B?RlptamlUVHFHa05yTWhhTjJZRWRpak1vd1ppOE84UGtxU0JKdzhvaUVWZUVI?=
 =?utf-8?B?NkZUQ2RHQlYxZUJhMk5QbzN6cjcrNmNXRXlkdHRZN0dCYWszMFhGRXZtZDJl?=
 =?utf-8?B?UWFLQWxMcXIvSG5mUHArK0x3UVZIaEZpeTlXemdXdHF2eGZhaTEzOFlNTWNt?=
 =?utf-8?B?TEsrblpGeXozRXdrVkFyZjNtVmFGQ3dzendyTzRoVGlmOWxpVzRIVmlwc09P?=
 =?utf-8?B?V2xvbVk5alNOSTMyWnBUZUNNNjQ4S1dtWVRuVWJDM2F3T1FRMERYMGhvMDFa?=
 =?utf-8?B?a1BXOHJxRGVORWJrUmxrYlBtS1dwd2NWNmo0am9wOG1KZkJYenJtZjhDVFg3?=
 =?utf-8?B?bFZSNEpUWFYvN3FXcXRjVUU3NjBtSnlpTEFCbnhqT1NzRjYrcUFsQ3Q1UlJR?=
 =?utf-8?Q?heyb5ordsuclsIxevwRH1rHTs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc2aad7-4ad9-467e-1620-08dc6565c5a1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:24:56.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcxATOAeb2+2rbzFWwtYO+sH3VligKJcCJjdJ20ET2bOgmFP6CjRWr9kIw0LVVWTFYAQDlqe26nfU+8OTilGXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

Add i.MX8QM audio related nodes and update eDMA[0,1]'s information.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi | 473 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          |  86 ++++
 2 files changed, 559 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
new file mode 100644
index 0000000000000..3036af49fc854
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+/delete-node/ &acm;
+/delete-node/ &sai4;
+/delete-node/ &sai5;
+/delete-node/ &sai4_lpcg;
+/delete-node/ &sai5_lpcg;
+
+&amix {
+	dais = <&sai6>, <&sai7>;
+};
+
+&asrc0 {
+	clocks = <&asrc0_lpcg IMX_LPCG_CLK_0>,
+		 <&asrc0_lpcg IMX_LPCG_CLK_2>,
+		 <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>,
+		 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
+		 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_ASRC_0>;
+};
+
+&asrc0_lpcg {
+	clocks = <&audio_ipg_clk>,
+		 <&audio_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_2>;
+	clock-output-names = "asrc0_lpcg_ipg_clk", "asrc0_lpcg_mem_clk";
+};
+
+&asrc1 {
+	clocks = <&asrc1_lpcg IMX_LPCG_CLK_0>,
+		 <&asrc1_lpcg IMX_LPCG_CLK_2>,
+		 <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>,
+		 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
+		 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_ASRC_1>;
+};
+
+&asrc1_lpcg {
+	clocks = <&audio_ipg_clk>, <&audio_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_2>;
+	clock-output-names = "asrc1_lpcg_ipg_clk", "asrc1_lpcg_mem_clk";
+};
+
+&audio_subsys {
+
+	sai4: sai@59080000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59080000 0x10000>;
+		interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai4_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_dummy>,
+			 <&sai4_lpcg IMX_LPCG_CLK_4>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dma-names = "rx";
+		dmas = <&edma0 18 0 1>;
+		fsl,dataline = <0 0xf 0x0>;
+		power-domains = <&pd IMX_SC_R_SAI_4>;
+		status = "disabled";
+	};
+
+	sai5: sai@59090000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59090000 0x10000>;
+		interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai5_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_dummy>,
+			 <&sai5_lpcg IMX_LPCG_CLK_4>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dma-names = "tx";
+		dmas = <&edma0 19 0 0>;
+		fsl,dataline = <0 0x0 0xf>;
+		power-domains = <&pd IMX_SC_R_SAI_5>;
+		status = "disabled";
+	};
+
+	sai4_lpcg: clock-controller@59480000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59480000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI4_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+		clock-output-names = "sai4_lpcg_mclk", "sai4_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_4>;
+		status = "disabled";
+	};
+
+	sai5_lpcg: clock-controller@59490000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59490000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+		clock-output-names = "sai5_lpcg_mclk", "sai5_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_5>;
+		status = "disabled";
+	};
+
+	esai1: esai@59810000 {
+		compatible = "fsl,imx8qm-esai";
+		reg = <0x59810000 0x10000>;
+		interrupts = <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&esai1_lpcg IMX_LPCG_CLK_0>,
+			 <&esai1_lpcg IMX_LPCG_CLK_4>,
+			 <&esai1_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_dummy>;
+		clock-names = "core", "extal", "fsys", "spba";
+		dmas = <&edma1 6 0 1>, <&edma1 7 0 0>;
+		dma-names = "rx", "tx";
+		power-domains = <&pd IMX_SC_R_ESAI_1>;
+		status = "disabled";
+	};
+
+	sai6: sai@59820000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59820000 0x10000>;
+		interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai6_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_dummy>,
+			 <&sai6_lpcg IMX_LPCG_CLK_4>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dma-names = "rx", "tx";
+		dmas = <&edma1 8 0 1>, <&edma1 9 0 0>;
+		power-domains = <&pd IMX_SC_R_SAI_6>;
+		status = "disabled";
+	};
+
+	sai7: sai@59830000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59830000 0x10000>;
+		interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai7_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_dummy>,
+			 <&sai7_lpcg IMX_LPCG_CLK_4>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dma-names = "tx";
+		dmas = <&edma1 10 0 0>;
+		power-domains = <&pd IMX_SC_R_SAI_7>;
+		status = "disabled";
+	};
+
+	esai1_lpcg: clock-controller@59c10000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c10000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_ESAI1_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+		clock-output-names = "esai1_lpcg_extal_clk", "esai1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_ESAI_1>;
+	};
+
+	sai6_lpcg: clock-controller@59c20000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c20000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI6_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+		clock-output-names = "sai6_lpcg_mclk", "sai6_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_6>;
+	};
+
+	sai7_lpcg: clock-controller@59c30000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c30000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI7_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+		clock-output-names = "sai7_lpcg_mclk", "sai7_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_7>;
+	};
+
+	acm: acm@59e00000 {
+		compatible = "fsl,imx8qm-acm";
+		reg = <0x59e00000 0x1d0000>;
+		#clock-cells = <1>;
+		power-domains = <&pd IMX_SC_R_AUDIO_CLK_0>,
+				<&pd IMX_SC_R_AUDIO_CLK_1>,
+				<&pd IMX_SC_R_MCLK_OUT_0>,
+				<&pd IMX_SC_R_MCLK_OUT_1>,
+				<&pd IMX_SC_R_AUDIO_PLL_0>,
+				<&pd IMX_SC_R_AUDIO_PLL_1>,
+				<&pd IMX_SC_R_ASRC_0>,
+				<&pd IMX_SC_R_ASRC_1>,
+				<&pd IMX_SC_R_ESAI_0>,
+				<&pd IMX_SC_R_ESAI_1>,
+				<&pd IMX_SC_R_SAI_0>,
+				<&pd IMX_SC_R_SAI_1>,
+				<&pd IMX_SC_R_SAI_2>,
+				<&pd IMX_SC_R_SAI_3>,
+				<&pd IMX_SC_R_SAI_4>,
+				<&pd IMX_SC_R_SAI_5>,
+				<&pd IMX_SC_R_SAI_6>,
+				<&pd IMX_SC_R_SAI_7>,
+				<&pd IMX_SC_R_SPDIF_0>,
+				<&pd IMX_SC_R_SPDIF_1>,
+				<&pd IMX_SC_R_MQS_0>;
+		clocks = <&aud_rec0_lpcg IMX_LPCG_CLK_0>,
+			 <&aud_rec1_lpcg IMX_LPCG_CLK_0>,
+			 <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>,
+			 <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_mlb_clk>,
+			 <&clk_hdmi_rx_mclk>,
+			 <&clk_ext_aud_mclk0>,
+			 <&clk_ext_aud_mclk1>,
+			 <&clk_esai0_rx_clk>,
+			 <&clk_esai0_rx_hf_clk>,
+			 <&clk_esai0_tx_clk>,
+			 <&clk_esai0_tx_hf_clk>,
+			 <&clk_esai1_rx_clk>,
+			 <&clk_esai1_rx_hf_clk>,
+			 <&clk_esai1_tx_clk>,
+			 <&clk_esai1_tx_hf_clk>,
+			 <&clk_spdif0_rx>,
+			 <&clk_spdif0_rx>,
+			 <&clk_sai0_rx_bclk>,
+			 <&clk_sai0_tx_bclk>,
+			 <&clk_sai1_rx_bclk>,
+			 <&clk_sai1_tx_bclk>,
+			 <&clk_sai2_rx_bclk>,
+			 <&clk_sai3_rx_bclk>,
+			 <&clk_sai4_rx_bclk>,
+			 <&clk_sai5_rx_bclk>,
+			 <&clk_sai6_rx_bclk>;
+		clock-names = "aud_rec_clk0_lpcg_clk",
+			      "aud_rec_clk1_lpcg_clk",
+			      "aud_pll_div_clk0_lpcg_clk",
+			      "aud_pll_div_clk1_lpcg_clk",
+			      "mlb_clk",
+			      "hdmi_rx_mclk",
+			      "ext_aud_mclk0",
+			      "ext_aud_mclk1",
+			      "esai0_rx_clk",
+			      "esai0_rx_hf_clk",
+			      "esai0_tx_clk",
+			      "esai0_tx_hf_clk",
+			      "esai1_rx_clk",
+			      "esai1_rx_hf_clk",
+			      "esai1_tx_clk",
+			      "esai1_tx_hf_clk",
+			      "spdif0_rx",
+			      "spdif1_rx",
+			      "sai0_rx_bclk",
+			      "sai0_tx_bclk",
+			      "sai1_rx_bclk",
+			      "sai1_tx_bclk",
+			      "sai2_rx_bclk",
+			      "sai3_rx_bclk",
+			      "sai4_rx_bclk",
+			      "sai5_tx_bclk",
+			      "sai6_rx_bclk";
+	};
+};
+
+&dsp_lpcg {
+	status = "disabled";
+};
+
+&dsp_ram_lpcg {
+	status = "disabled";
+};
+
+/* edma2 called in imx8qm RM with the same address in edma0 of imx8qxp */
+&edma0{
+	reg = <0x591f0000 0x150000>;
+	dma-channels = <20>;
+	dma-channel-mask = <0>;
+	interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>, /* asrc0 */
+		     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>, /* esai0 */
+		     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>, /* spdif0 */
+		     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>, /* spdif1 */
+		     <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>, /* sai0 */
+		     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>, /* sai1 */
+		     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>, /* sai2 */
+		     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>, /* sai3 */
+		     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>, /* sai4 */
+		     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>; /* sai5 */
+	power-domains = <&pd IMX_SC_R_DMA_2_CH0>,
+			<&pd IMX_SC_R_DMA_2_CH1>,
+			<&pd IMX_SC_R_DMA_2_CH2>,
+			<&pd IMX_SC_R_DMA_2_CH3>,
+			<&pd IMX_SC_R_DMA_2_CH4>,
+			<&pd IMX_SC_R_DMA_2_CH5>,
+			<&pd IMX_SC_R_DMA_2_CH6>,
+			<&pd IMX_SC_R_DMA_2_CH7>,
+			<&pd IMX_SC_R_DMA_2_CH8>,
+			<&pd IMX_SC_R_DMA_2_CH9>,
+			<&pd IMX_SC_R_DMA_2_CH10>,
+			<&pd IMX_SC_R_DMA_2_CH11>,
+			<&pd IMX_SC_R_DMA_2_CH12>,
+			<&pd IMX_SC_R_DMA_2_CH13>,
+			<&pd IMX_SC_R_DMA_2_CH14>,
+			<&pd IMX_SC_R_DMA_2_CH15>,
+			<&pd IMX_SC_R_DMA_2_CH16>,
+			<&pd IMX_SC_R_DMA_2_CH17>,
+			<&pd IMX_SC_R_DMA_2_CH18>,
+			<&pd IMX_SC_R_DMA_2_CH19>;
+};
+
+/* edma3 called in imx8qm RM with the same address in edma1 of imx8qxp */
+&edma1{
+	reg = <0x599f0000 0xc0000>;
+	dma-channels = <11>;
+	dma-channel-mask = <0xc0>;
+	interrupts = <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>, /* asrc1 */
+		     <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>, /* no used */
+		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>, /* no used */
+		     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>, /* sai6 */
+		     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>; /* sai7 */
+	power-domains = <&pd IMX_SC_R_DMA_3_CH0>,
+			<&pd IMX_SC_R_DMA_3_CH1>,
+			<&pd IMX_SC_R_DMA_3_CH2>,
+			<&pd IMX_SC_R_DMA_3_CH3>,
+			<&pd IMX_SC_R_DMA_3_CH4>,
+			<&pd IMX_SC_R_DMA_3_CH5>,
+			<&pd IMX_SC_R_DMA_3_CH6>,
+			<&pd IMX_SC_R_DMA_3_CH7>,
+			<&pd IMX_SC_R_DMA_3_CH8>,
+			<&pd IMX_SC_R_DMA_3_CH9>,
+			<&pd IMX_SC_R_DMA_3_CH10>;
+};
+
+&esai0 {
+	clocks = <&esai0_lpcg IMX_LPCG_CLK_0>,
+		 <&esai0_lpcg IMX_LPCG_CLK_4>,
+		 <&esai0_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_ESAI_0>;
+};
+
+&esai0_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "esai0_lpcg_extal_clk", "esai0_lpcg_ipg_clk";
+};
+
+&mqs0_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "mqs0_lpcg_mclk", "mqs0_lpcg_ipg_clk";
+};
+
+&sai0 {
+	clocks = <&sai0_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_dummy>,
+		 <&sai0_lpcg IMX_LPCG_CLK_4>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_SAI_0>;
+};
+
+&sai0_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "sai0_lpcg_mclk", "sai0_lpcg_ipg_clk";
+};
+
+&sai1 {
+	clocks = <&sai1_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_dummy>,
+		 <&sai1_lpcg IMX_LPCG_CLK_4>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_SAI_1>;
+};
+
+&sai1_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "sai1_lpcg_mclk", "sai1_lpcg_ipg_clk";
+};
+
+&sai2 {
+	clocks = <&sai2_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_dummy>,
+		 <&sai2_lpcg IMX_LPCG_CLK_4>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_SAI_2>;
+};
+
+&sai2_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "sai2_lpcg_mclk", "sai2_lpcg_ipg_clk";
+};
+
+&sai3 {
+	clocks = <&sai3_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_dummy>,
+		 <&sai3_lpcg IMX_LPCG_CLK_4>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_SAI_3>;
+};
+
+&sai3_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "sai3_lpcg_mclk", "sai3_lpcg_ipg_clk";
+};
+
+&spdif0 {
+	clocks = <&spdif0_lpcg IMX_LPCG_CLK_4>,	/* core */
+		 <&clk_dummy>,			/* rxtx0 */
+		 <&spdif0_lpcg IMX_LPCG_CLK_5>,	/* rxtx1 */
+		 <&clk_dummy>,			/* rxtx2 */
+		 <&clk_dummy>,			/* rxtx3 */
+		 <&clk_dummy>,			/* rxtx4 */
+		 <&audio_ipg_clk>,		/* rxtx5 */
+		 <&clk_dummy>,			/* rxtx6 */
+		 <&clk_dummy>,			/* rxtx7 */
+		 <&clk_dummy>;			/* spba */
+	power-domains = <&pd IMX_SC_R_SPDIF_0>;
+};
+
+&spdif0_lpcg {
+	clock-indices = <IMX_LPCG_CLK_5>, <IMX_LPCG_CLK_4>;
+	clock-output-names = "spdif0_lpcg_tx_clk", "spdif0_lpcg_gclkw";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index b3d01677b70c4..6092d70b10b97 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -461,7 +461,92 @@ drc_crit0: trip1 {
 		};
 	};
 
+	clk_dummy: clock-dummy {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "clk_dummy";
+	};
+
+	clk_esai1_rx_clk: clock-esai1-rx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "esai1_rx_clk";
+	};
+
+	clk_esai1_rx_hf_clk: clock-esai1-rx-hf {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "esai1_rx_hf_clk";
+	};
+
+	clk_esai1_tx_clk: clock-esai1-tx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "esai1_tx_clk";
+	};
+
+	clk_esai1_tx_hf_clk: clock-esai1-tx-hf {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "esai1_tx_hf_clk";
+	};
+
+	clk_hdmi_rx_mclk: clock-hdmi-rx-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "hdmi-rx-mclk";
+	};
+
+	clk_mlb_clk: clock-mlb-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "mlb_clk";
+	};
+
+	clk_sai5_rx_bclk: clock-sai5-rx-bclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "sai5_rx_bclk";
+	};
+
+	clk_sai5_tx_bclk: clock-sai5-tx-bclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "sai5_tx_bclk";
+	};
+
+	clk_sai6_rx_bclk: clock-sai6-rx-bclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "sai6_rx_bclk";
+	};
+
+	clk_sai6_tx_bclk: clock-sai6-tx-bclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "sai6_tx_bclk";
+	};
+
+	clk_spdif1_rx: clock-spdif1-rx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "spdif1_rx";
+	};
+
 	/* sorted in register address */
+	#include "imx8-ss-audio.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
@@ -473,3 +558,4 @@ drc_crit0: trip1 {
 #include "imx8qm-ss-dma.dtsi"
 #include "imx8qm-ss-conn.dtsi"
 #include "imx8qm-ss-lsio.dtsi"
+#include "imx8qm-ss-audio.dtsi"

-- 
2.34.1


