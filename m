Return-Path: <linux-kernel+bounces-153855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48E78AD439
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FCC1C21087
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029DF15539E;
	Mon, 22 Apr 2024 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="awzpoTZF"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F3615533D;
	Mon, 22 Apr 2024 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811531; cv=fail; b=nO+xMzIk/JC5DIjAJ2IV/lMsf/9K6kSDMpEkY8dq++Pg3tAP35hOzLE18a74AhfhDSJVWrxKrgE6rkmi4XeFH5azHo1cF/NiHdUhhOT1b5VVCNKQJPRR8JbvGXEN5oihiWscUtyKvNa+YIaRao7lr8bZcOs6xBLI9O+8zHA0GOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811531; c=relaxed/simple;
	bh=FsUrMXHLKJ/frzTANnIa3b1snsvn1Cr0o0YqBbI+SiM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dtY5OFu+Veamx0PnUlN7/7ikUPm9Q2/3glxtT4Khd45RikwQbOXWnMEZYtfp9jzz0VJ/xBMH3v5oBFrJmj2gHYhKz5zL5W+GYfcid6HMpr6rrt9AZsEQ7Ese5Sqis5CqqqY4CWQ1a4GE8a3RCWBH9OUVRgascZQ5x/IBSOxhQkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=awzpoTZF; arc=fail smtp.client-ip=40.107.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSKsp4GVoE09V1E3cvbuVpNUefZkMin+bWAPI8qj6433mtseGXQExH1yIFqJYmbcOOOImhVVvKhcHxCVZ5Mk9bBCff8i148vUO39nb8S8d4xDxoyvhXe/CzvrZBxfiZnux+tAG1jYhY3QO3arjYtUYTOabpMiaXhIHv03QItw9pAyz+Pdr0USptPEsdF1PjTJDetMAyu3NMv5u1YjHAyw/5JY8JtwUlHmhdTuT9s2tWurTKlIEoDeuvvkCxFmY0dzkAHMUTtGUtGZChnZu9CITiYqGbFzXrdby/dAW5UeWU7GujjjsIDLkd/cxEEhoxy77MfCstqZjGI1oq1jwr+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBIuqHeQVAyOwum0bM19rYmn1M2zD4KXKE+L4JRtf2o=;
 b=GZ3gUsCJoUMzEzFYvvGFHCiTPDZOxtsHLVQ8UEdFeKVafUCWPWiLoMWob2qjIyenog0HRQBFM+mLipoUp/5v8kNNPttZHkU6DOr96LXORBSSak3/NTFBCPtjcP6xpKI29HeOjB/QfvR/OIAJ+uQJVs+/6EaBZC0Ire6+iAp6zRMBLI51CBS9uwnEWTnDFetH9m43oh9gsbL+OKMCRHNylifFPoe6yekr6wY7CBo4qjEmdRv487PAYYgMKudwWdF+lxWN062cGlE0ykooemb9/0YKHG4q4n+dnggJZCPR8LreowYKZfqfaOzCV7hevtH/FDZLGAxqvE875OEqHD/JeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBIuqHeQVAyOwum0bM19rYmn1M2zD4KXKE+L4JRtf2o=;
 b=awzpoTZFK1GD43gpQuvgFomzXfhFafkoDEyRjpv0r+Wu82CpPS8lh9zz9A5WR3TRoIqO9hjJaBOjn0+o+GhGoFliZcynqk7KRcY2hpeOoR23qK/lW9FXaw5b6JHaeT9ABR67TBW1qWDg3ifnNcWLqg9ArAI020fCrfnj+Af8A34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 18:45:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 18:45:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 22 Apr 2024 14:44:54 -0400
Subject: [PATCH v3 3/3] arm64: dts: imx8dxl-evk: add audio nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-b4-dts_dxl_audio-v3-3-5017511f399e@nxp.com>
References: <20240422-b4-dts_dxl_audio-v3-0-5017511f399e@nxp.com>
In-Reply-To: <20240422-b4-dts_dxl_audio-v3-0-5017511f399e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713811515; l=7895;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=FsUrMXHLKJ/frzTANnIa3b1snsvn1Cr0o0YqBbI+SiM=;
 b=XVLr3Ic3Tlqi+2OFUyuk1byOM/Hhlcnv6G8cMysvZSpHtR4R2kp+7QCwjrsm3lU/yTeTaqVbm
 EH+48sezKY1AvXTSG23T3PD0cPEqh+BIpduyEzDApiwBWOMfxoYL7xj
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe5a93d-226f-4126-2cd2-08dc62fc60ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjY3aUFHMXZzNTBFQmY1aExTY2JiSlNXREZVRHFZVlhOQ1MrZ0xnMU1ySmhr?=
 =?utf-8?B?OFowV2QxbVRlYjYrRFpMU1pNK0p5M3pEbHAvT3phd0htbDhObzlmdDV3NU9F?=
 =?utf-8?B?MzU3RTFCOStZOHJ5bWFJdlFBdmJQeXBrUFRCS3dkenZraG9QdmJnZkpRS04z?=
 =?utf-8?B?b0d5cWsvZ2FnMm9zV2w1NFZGK3d0NStYN21UUWptWFJkQVVuS25aVWRyaDVM?=
 =?utf-8?B?Rlk5TzdUa2xUcGt4MFhPRDkvY1UzdTgyVTM2N01NMDlTQ3hldGtTdWFEM253?=
 =?utf-8?B?aFQvM0FtZTd0eUhHYjNoQzFHN1FYSEZJOVhXM3hwZEZVN2gvSXBJS2EvS3A3?=
 =?utf-8?B?RStrWkxjS0tDT2h2c2liZ21PVG5GeER1cVZmVGwyQ0VnbGlvLyt0ZmExN0FZ?=
 =?utf-8?B?ZENWRXpLcFZyVkRnci9KNnd1d2hzWkZmMkltajZtdzhXcXBUNXlma3ZvR3pB?=
 =?utf-8?B?cjh2b0lBZlpQaFF5L3Y2T2FxS2U1VWI4NmRxclZFNmJWRDgrUEljS0czZUFG?=
 =?utf-8?B?NUgzb2RORXp2MjdqM2dGdVlOV2U1R0VtaktLc0sySXZVbk9kT05BSjZZR25h?=
 =?utf-8?B?RjNQdndLUUorR3NLNkU5UVp6SmRjVlB6K3FQM2pqd3JBQWNPd3FwY3NhRkRj?=
 =?utf-8?B?YzE3U3hyeWxHZGlBZEtTVkRBTzFkdmF5bGVqTUlmejdETWtKTTVpQlJPVUN4?=
 =?utf-8?B?bFg5VzBlMjRiTExSY1NwUHNiMThoSXZEZnFrMDBkZlJwem9BZmRBZVpuZUhw?=
 =?utf-8?B?UHdUQVQ0K1NWNEs5QkZxanBBWUNndUkrRmxwdDFEN1NUeHNTVnFjd2tuZTRo?=
 =?utf-8?B?UENQSkE0QjVSU0I0Z0p0dmw5Vm9aWThZRm01RFFWOGpacTJKdHVvRVlmdSti?=
 =?utf-8?B?UWw3RlR3c0p3YjIwWHFlZHZ5T2o1d1hHcTRPWjZ4TWY5RnNYYkZIZk5qUXhp?=
 =?utf-8?B?RU1BWm5pSzA5c0xtWUNzeWhtblBsNyt2RzF0R1RNdFhjT2RHdEJrb1A1VFVT?=
 =?utf-8?B?V0dsQ1cvc3pHemxlMjBoMDArenZsaTdDY1hnVHNETCt5RUdDcGtsd01iczJw?=
 =?utf-8?B?ck1WT1F0TlVFR3JHVFo4bFJmT3dUbFFKaWxXOTc1UWdLMXkzei9GU05BejI2?=
 =?utf-8?B?WTNURW9xK1FWT2lFenkvK1duM3BnbVRaOTJSRUZjeDloaVM1Sk1CcWZ2blY4?=
 =?utf-8?B?UzNUY1dtYnBHNGVuT3hhaXhEYzlKWFQxOFpGYXFETXJwU3Fod1d2aktIcU13?=
 =?utf-8?B?UXRMNm5ydlRtcjFEN0tnQW50YWprd0Y3NzdDVVFxWGZ4bUtLNGk3V3V0WGk0?=
 =?utf-8?B?WGNuZjhCRHZndjJmT3VML20zc3lGTEV6Q3VtTXhZTmtTNnkvVmUweEw2YTRE?=
 =?utf-8?B?ZDBtdzJlZm1jbndyZmFkVjNGQUxGM2dQcno4cmJqRXNmNUJVWmJuUGlwdUFC?=
 =?utf-8?B?bVo3czdnbW90YTI3SjVpMTJpY1ZlS0lsYUIxR2tybGZtT050ZVd0Zml3YmxH?=
 =?utf-8?B?VjVCV3U4ZUkwc0FTMlFSNi9waTVZNzc3dmJGYXFHTjFYUDJHWG56MXM2T0JZ?=
 =?utf-8?B?T1ZVQmZMMUZMVXdJa3lVZUp3dTByQVk5WU1sZE4vV0lraGU5dzBKRkkyOU1K?=
 =?utf-8?B?VXE3VUEzZzFSN1lxeDRrT0MzT0ZROG9sMDVWSkRwc3QwdnJPcEFxZ2Z5cDVu?=
 =?utf-8?B?Y2V4L2xvWE1FeFZZYmZjdW9EQ0pFZkNYcFJKcFk2cEc2bHpYT041TENZTWww?=
 =?utf-8?B?QW11MDJLVmFjT2tzbDhla2dsakNYUUJGYTNIbzJucWVlQ3RBcnArcTYxUWVs?=
 =?utf-8?B?cHA0OTRaLzFEckU1OVhoQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEJid3d1dytuUEY4SENlYmdxWk1tQzI5UmFZTm9vRkxWQXIydVFjTGZxOG4w?=
 =?utf-8?B?ZEx5cUJHRWMwU21NZDlsTG5EeEtrVStlNlZodmlSbVg1aUNLVXo3MFc5K2I5?=
 =?utf-8?B?YS9HRVNteVFrRjA1RkwwdlUwTTZRR081SldWcWh6TGFoOGI4MDkyeW5mQWpI?=
 =?utf-8?B?Q1FBaFNEbzVoRTFiM2lReXBNU3ppRGMyVnViazhYQUZua252cVlWTzR4NjAz?=
 =?utf-8?B?dC9oV0hRdWZZejlQWTFXNTVjajJUVVpVS2tpZW1RdjFDWjR0VjVhWXRrcEE1?=
 =?utf-8?B?TUlqUG5NWERUMmxhRGlTUUFJYzllcFNucEZGb1J5V1FGQkp6aFdnem5TZ1dU?=
 =?utf-8?B?SFY0Y0UzQ0tqejZ4aGhiUUMrYTZPVzlJd2hSOWFKdVVEaDY0bWlCY1VQOTdl?=
 =?utf-8?B?QTZudGxSU3lJbm9VRWh1c2tRL0xUZ0tyM3krNmFvNTN3bThKMy8zS0t0cmVS?=
 =?utf-8?B?dnhKYUpwVHY2WGU5L3pZQ2wvL2JubW11NXQ3OVVGV3NqanlqYmRhbExrRHdr?=
 =?utf-8?B?eWJPaGQxVDZWVzhaSGxYTTFISVJSaWRzZ3lIVGIzenZwZ1BZNTR6clNxMGZv?=
 =?utf-8?B?M29tUmRlTXZvZUZOSExOR1JmaHJwRGZhUlJGK3o1NmdxU2ZUY25LT1h4eTha?=
 =?utf-8?B?em9ESkY5cThHaXdHaTJtbDRHVGJnZFNwcGFnR1puNVA2Y1RKUTNUSkR4NklK?=
 =?utf-8?B?VURKSjFtV3lPK2Z5cXB4ZEVyRG5jTFpndWRiQVQ1RjhpZG5GcGljRlQxOFVm?=
 =?utf-8?B?WVBqMjNRQm5FS25na3VvM1BkNUdLRFhxRzM5ekxiWTEyOXVTWklFa1d2RVhr?=
 =?utf-8?B?SkZrSUhUQlIvcUR3dlNZSnZqdlhIaE4xejRMaTkxWlRxSldCUVprR01GdjQ5?=
 =?utf-8?B?Vnp5Q0lPbGZ4T3hmUDRGZCtyN0JBWUZKZzR1T0FKbVNaNW5yaXF6Q0xFRnVs?=
 =?utf-8?B?ZTNvY2ZlRzFlM1crVnRtS2JMcERjSHBNTUwzd3lzOGFVcWZxWi93Y0dFL3I4?=
 =?utf-8?B?YkcxcWUwVVFNU0R0ZkxRdDQ3Z3kyNEhvSkt3VkZtVTBwR2FRMno5ZmdXbTlO?=
 =?utf-8?B?VWhDb1Ricms3SUlsa2RjY0NmcGlEWGwyRzEwVzFjUVhrb283UE9UbGpoTCtL?=
 =?utf-8?B?a0J0bnZzTzZQM3pjb0w4YkZxYUdVeGJnSlU3ODNudTlPcStIRWdWZ0FBRU12?=
 =?utf-8?B?WHkzRy94ZG1vMTg4bjF5eVNTemJUZkZxZldBbGV0Q2FOSlFKRlYwbE5SdGRN?=
 =?utf-8?B?cyt4OGlnR2Rjc3pscWpPcENBcEZXanY5WUN5djM3alBqMFAwUHBPOVprMnl3?=
 =?utf-8?B?UkUwdGtlcktrdkZNL0kvUDF1N0FNdC9sYmlpL2gra1FBR24rK1BPc2E3TktW?=
 =?utf-8?B?dFJjUEVGRDc3ZXR2L29OR2ZuZ0doL3VqVVR2MGJVVHduOGNYS0JORjkydDVH?=
 =?utf-8?B?MmdUcHNMM0lNbTFnV3E0OHRwZlR0b085Z254QVBjc0VUY2xNbEdqU0JQNlFX?=
 =?utf-8?B?WllBakZsZnBKNXVDRGlXL0VqU240WUtic21CNHplRDVPRndqYWpwNmQ1ZE96?=
 =?utf-8?B?bm1LbUkwWUErN3I5cVFLMWk2T3MwVnNBZFZIRnk5elVJSkl6NytlREVTZlVl?=
 =?utf-8?B?dmFBWE9UUjBQSGZnVk9ta1ZrR0Y0TVJZSE52S3NBekoza2FEc0U3c0RoTGJi?=
 =?utf-8?B?SlVtclB5ZWhuY3ZsUkJ0ekhteXFNL21nQ01rVEJmQVBpL3hWUmxwL0t1Tjk2?=
 =?utf-8?B?aHlCVFdtUjByQTdQdmM0NGFBT2hFUm5pUTQweDdWRlRTeGtwT3YzSVRTWmRC?=
 =?utf-8?B?YzRjSXVaUzNnUmpNdjZFQU55YTlRWG8xZ0lXRTNscWtCWG1uaDQ2YUhJK0do?=
 =?utf-8?B?Wm5zTjRieFZZSW5NUmJFQVQzbFNIaE1YMFlYeUJ5ZTdzSlROOUw3UFVMZVBi?=
 =?utf-8?B?NENBVDFlMExjYUJVOHpnWVZoMzhUcGVKblRtNHVWdlNqL3ZkUXFpREtQVUc4?=
 =?utf-8?B?S0REeHhZYkFZMDBLdHIvTTZUK3FSSmZSWTFYVmZyaXR5WlpLY3JqWnhrZkM0?=
 =?utf-8?B?UVNjbmNFdkxYd09WME1ZeEVlY204TW9ER0hxc2p2ays2bGk1b3BUUkJpdDk1?=
 =?utf-8?Q?qksxAKO/3aTIL4zrtGSIEEo1o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe5a93d-226f-4126-2cd2-08dc62fc60ff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 18:45:27.9185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWgXTJafyNtv/LnTlKgsXjm4bYI0XKxLF9fIPt8ssaMO11YYCZJOiMAZhLCqKDnbGEPPYS8NA6wEESvf8pNZPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853

Add audio nodes for imx8dxl-evk boards.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 231 ++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 2123d431e0613..5b5a7b47217c3 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -125,6 +125,78 @@ mii_select: regulator-4 {
 		enable-active-high;
 		regulator-always-on;
 	};
+
+	bt_sco_codec: audio-codec-bt {
+		compatible = "linux,bt-sco";
+		#sound-dai-cells = <1>;
+	};
+
+	sound-bt-sco {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "bt-sco-audio";
+		simple-audio-card,format = "dsp_a";
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,frame-master = <&btcpu>;
+		simple-audio-card,bitclock-master = <&btcpu>;
+
+		btcpu: simple-audio-card,cpu {
+			sound-dai = <&sai0>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&bt_sco_codec 1>;
+		};
+	};
+
+	sound-wm8960-1 {
+		compatible = "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8960";
+		model = "wm8960-audio";
+		audio-cpu = <&sai1>;
+		audio-codec = <&wm8960_1>;
+		audio-asrc = <&asrc0>;
+		audio-routing = "Headphone Jack", "HP_L",
+				"Headphone Jack", "HP_R",
+				"Ext Spk", "SPK_LP",
+				"Ext Spk", "SPK_LN",
+				"Ext Spk", "SPK_RP",
+				"Ext Spk", "SPK_RN",
+				"LINPUT1", "Mic Jack",
+				"Mic Jack", "MICB";
+	};
+
+	sound-wm8960-2 {
+		compatible = "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8960";
+		model = "wm8960-audio-2";
+		audio-cpu = <&sai2>;
+		audio-codec = <&wm8960_2>;
+		audio-routing =
+			"Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"LINPUT1", "Mic Jack",
+			"Mic Jack", "MICB";
+	};
+
+	sound-wm8960-3 {
+		compatible = "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8960";
+		model = "wm8960-audio-3";
+		audio-cpu = <&sai3>;
+		audio-codec = <&wm8960_3>;
+		audio-routing =
+			"Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"LINPUT1", "Mic Jack",
+			"Mic Jack", "MICB";
+	};
 };
 
 &adc0 {
@@ -132,6 +204,11 @@ &adc0 {
 	status = "okay";
 };
 
+&asrc0 {
+	fsl,asrc-rate = <48000>;
+	status = "okay";
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
@@ -259,6 +336,78 @@ max7322: gpio@68 {
 			};
 		};
 
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+
+			wm8960_1: audio-codec@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+			};
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			wm8960_2: audio-codec@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			wm8960_3: audio-codec@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+			};
+		};
+
 		i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -362,6 +511,53 @@ &lsio_gpio5 {
 	status = "okay";
 };
 
+&sai0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai0>;
+	#sound-dai-cells = <0>;
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai0_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	status = "okay";
+};
+
+&sai1 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	status = "okay";
+};
+
+&sai2 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai2_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
+&sai3 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai3_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
 &thermal_zones {
 	pmic-thermal {
 		polling-delay-passive = <250>;
@@ -595,6 +791,41 @@ IMX8DXL_UART0_TX_ADMA_UART0_TX		0x06000020
 		>;
 	};
 
+	pinctrl_sai0: sai0grp {
+		fsl,pins = <
+			IMX8DXL_SPI0_CS0_ADMA_SAI0_RXD		0x06000060
+			IMX8DXL_SPI0_CS1_ADMA_SAI0_RXC		0x06000040
+			IMX8DXL_SPI0_SCK_ADMA_SAI0_TXC		0x06000060
+			IMX8DXL_SPI0_SDI_ADMA_SAI0_TXD		0x06000060
+			IMX8DXL_SPI0_SDO_ADMA_SAI0_TXFS		0x06000040
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			IMX8DXL_FLEXCAN0_RX_ADMA_SAI1_TXC	0x06000040
+			IMX8DXL_FLEXCAN0_TX_ADMA_SAI1_TXFS	0x06000040
+			IMX8DXL_FLEXCAN1_RX_ADMA_SAI1_TXD	0x06000060
+			IMX8DXL_FLEXCAN1_TX_ADMA_SAI1_RXD	0x06000060
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			IMX8DXL_SNVS_TAMPER_OUT3_ADMA_SAI2_RXC	0x06000040
+			IMX8DXL_SNVS_TAMPER_IN0_ADMA_SAI2_RXFS	0x06000040
+			IMX8DXL_SNVS_TAMPER_OUT4_ADMA_SAI2_RXD	0x06000060
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			IMX8DXL_SNVS_TAMPER_IN1_ADMA_SAI3_RXC	0x06000040
+			IMX8DXL_SNVS_TAMPER_IN3_ADMA_SAI3_RXFS	0x06000040
+			IMX8DXL_SNVS_TAMPER_IN2_ADMA_SAI3_RXD	0x06000060
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK	0x06000041

-- 
2.34.1


