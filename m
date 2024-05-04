Return-Path: <linux-kernel+bounces-168462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE19B8BB8DE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2B61F23924
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C083010A3D;
	Sat,  4 May 2024 00:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GLXIn02P"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02425BA4D;
	Sat,  4 May 2024 00:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783282; cv=fail; b=K/mTBtkGyEYC7lSDb+491cIs92Hizc1gwS9tMqf9mPVWQcl7cK1xYtmOiFTs66gaz+VIm3Hxe0k5S+43fh31EuvffJJtE+9gczYJhq5OU1xgP/fx0pkR2zxS99h3asXCo5Oxqe1s8Kv3xqJBkt1AAItz4/64nxUiLF3LRLgdTAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783282; c=relaxed/simple;
	bh=q1A0+hU7W4e/wLAiXmKNBgA/x/XkBiviRb5Vkelujko=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RdUaMy1QFY7lgCfPxCqlrCIJ1bDbfdRXXBdV2fnxV3nM6ja+f1+MAZldDhsuB3bA04dV36c56kBxPSPj2h9Z4R5qCI22piMydAczecJdC55qjGYno5RaSLLhsFxEMPcOVYSf9XOXUfL+lykY4qWU+1sqjNmr9vWY2jsprAQMeUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GLXIn02P; arc=fail smtp.client-ip=40.107.105.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgSfjn9xeKLa1mYgy0Ww/bUzKlKAcPdJ1xz5RzAEabHWFOEamO1P60yAoPoDjIn9a81ZLrAWD/AfUcViT7gGF9us64QeG1OY6X/trRcLdLq71fHvze+f2RXRRY6iqV3OE1C8qqxaXENr0iPPPqWuDZF12JVAkNJW7BQPJjOdMQxOqDPwkH3njI3jqmwkfTQ+XUrZGXGX9rd3WyxPeocBN8Enbx9lU1vHD/7AVpFfGEWRFQQCzJbr2SSefkNy1sC3hIFYxN1RPVDS1pq+RSH/ll6Nc84YgtnsgBgB8ZKRZ5oZ5/TzNCijNpvN8J2s8R+Q74jhnzOVgUHTbgmZ+ukBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IV//EdgGByvRtKbvLoHynbxEW/SMWswnYjQkG4VShQ=;
 b=GFyXAI9M4bDH3XQNHd3NzM7rYdTHB2003PUEcDr7ddLEFmuVfP5xGcLibA/unR9ScZpR+JNPwO88CKBcCZhkTqlFtTQDjTXEtIRCaxCMvoIfLCBHBuJ2SyOK7t2xY7h06NIuCVQiiCePTBVeDfyeYaTylxASB3RGFiP1j5iJ8C5jEj51MhVrDmBxDi3WQue86AogSRVYiZKVI2iVHxTn3K+eGCgZmnFxPsOf6W+Hn3dj5ra+WCkfM5+QnGSpvVYk2lnckV+BG+uRh8oQdPyHfhUCod3t4tlT396Bq0aEBSOKF7aX5c5woYcFuLjVOWwPwR0F/McprPz2Y/5C3ColnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IV//EdgGByvRtKbvLoHynbxEW/SMWswnYjQkG4VShQ=;
 b=GLXIn02PsN+LwIGw71rduu5txrbSXqha3OTKwm3lRmpyuNh+AKJbxTQ1M9PAtrUndilMJK8TbxC4qm2VKCvxhvVnTjogzAR2xYL74w2MN1fux56uHsQTEEirROSP9iFfzOwpN/Q0IdmheeeHkq0/NVXlsNcIukhPKnMSayqvKcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:41:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:41:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:48:56 +0800
Subject: [PATCH 03/18] clk: imx: composite-7ulp: Check the PCC present bit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-3-f7915489d58d@nxp.com>
References: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
In-Reply-To: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=1147;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=/EJNZA8jzAtJukHgOj2MT46tK7VZuwWKGrAynGdc6BY=;
 b=v21z0ZYsAPEAg8oXVf0AFWhYjB7qV1FmF/vTgvU6W7PnYD6JYU+/Ppjyes/fcKEHKD6cxOnNX
 vAlOSj5j3FzCth6Z+UOmmVZNbAkPR/VhJ+blpuAaiZPGMLjDjCdoeri
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 3225de88-7b54-43ad-78d6-08dc6bd2e986
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVAwVzBxS3ZudWtpRk9RZERMMjQrZjM3dTMwN3NtZlVhWkpXeXljZWVvM2Fq?=
 =?utf-8?B?enQ5Mi9TVXBTbXg5dUVHU05IV2FPd29nMk1jMW9UU3Z5YjgvU3N2RkdaeWg2?=
 =?utf-8?B?bEtEMCtPQms2bG5vYTVib0xWL0xjSktKZGFSWjh2NGYzd2dZQS81Z0RMTlp3?=
 =?utf-8?B?aDI5ckZheEVzZytEdHJncUQyNTVpMmR0VXZLTWU0UCtsN09OOE5SZStDQzVJ?=
 =?utf-8?B?ellIZTk5ODl0UWxKcWpGNUpWWEhUdUM0eGJNT0duUDVmV3VhU1cxQmFwU24x?=
 =?utf-8?B?OGIyQWNNRlNmV3lGKzBrbTBjUXJ6ZVRtTDgvU0piNEY0VjlSQ0pyd0VxQ1FN?=
 =?utf-8?B?OUswWUFNU09EcHUzSnhMQnoxS2NDNk5lOXJxbjRJa0RSeDVaOHRaSHp3NEl3?=
 =?utf-8?B?cjk1M2xpMU9HNzNCQTlDS01VdFBuNm9CQzkyc0svWVNxOEhVMlJJWloveHo2?=
 =?utf-8?B?Q0UwanJrS0Zva0F2Y0tpeUkwUGg3N2kySHhaMWF1VWpMSWVZL0pSVEpuVHlF?=
 =?utf-8?B?RHBLNzZPa1FWNGhJamJieW5MUzhmaGt4MzNGNk9nZjJDTU9URnk1ZnpubTR1?=
 =?utf-8?B?VzdkR3hhOTZNd3Q1TmxvYkdHdkc2c1JmbUx2MU45eTJLTTl2d3VKdXlLOEJq?=
 =?utf-8?B?cytDcUppUzVtV1J4N2RJM0dqckVjczJrbUw0VGV3M2tESVEzd2ZmbDkxL29M?=
 =?utf-8?B?Sm55aW5DWjA0cnVvQmVRQk9KUHRqczRLL1dQbUVnTWJhUkhyQjVWRkhOei9k?=
 =?utf-8?B?bzJpbGRCT3BFQVpqOTI1dkwwZURuaXhwWlZYZzc1TXY3V05VWTJIeHVFSnVN?=
 =?utf-8?B?NDZhUkFTZmFpVytYenk4NC9qZGVTcGRTRXhFR3hOYmxocjMwRFJaeWU0a3Vy?=
 =?utf-8?B?aG9JNGdzQnZqTkVwREFITFQwWHlQSlZIRHFBVVVLK0JOM3Y2U3MwSTJnRWhn?=
 =?utf-8?B?ZmNBcDRsSHg4TzZhYmJFMUp6ekUyS2ltTXRFMU5Bd2V4L0F5ejNQeVFRRWZ0?=
 =?utf-8?B?SVY4ZlhMRXAwTTIrVEcvL2lTYXJlWVFBQk90SjZZRFlsWHZKUFNLR1VoL014?=
 =?utf-8?B?dDJCZ1VXV2ZjcmZBRi9ma29JWFJwSTkxM0dnZ2h5UkNCaHNHb3k1amo4OVNk?=
 =?utf-8?B?TUgwOUdzR3hzemhQR3BHQ0VCSXFqd1RwTmtTTDZabXhCbnBaOEw0L1NYM3pJ?=
 =?utf-8?B?OXRQUHByU00wcEc4OHNONC9OMXVSN08yL1BJbm4rS0lGS21rRjRBN3BCTTFH?=
 =?utf-8?B?YUxsMGVHSDNyRVIwT2lNblFVaHZYMzNHYzZ2ZCs5cy9nN2RZcUxteGNUdWpu?=
 =?utf-8?B?MURvaHBjdUttemd0eE42YWZ3OCtNODNxMnc1SVh2ZHdXZ3ZIMUU0NlFLVW5U?=
 =?utf-8?B?dUVqZkpwdnkwR3VQOU1NZ01TVVdFazAwVWtqWWZ2dmE1SVJLUTR2enRTV1I4?=
 =?utf-8?B?RmNGdmdlY3pxQ1hRVDlhZVlHbnZTVkhqZzBpNUVSUE45UHkxUTJqOXlROEJ0?=
 =?utf-8?B?SjhjSkY1OHBMSFBXeXM5T3BrazNHZWVhcmY1U05HdHVWalM0ckVqMHhMT1FQ?=
 =?utf-8?B?TmlvMHlKblk3elEwa05FRnVNZmE3d1BjK3BGM1VTMW40Q0Z6SnFBZXdCV1h0?=
 =?utf-8?B?SFlkcXBFL0lQZy9xM1VCWUVXdk04cTRESkpKZktac1lUWFoxekZvWitMSkY0?=
 =?utf-8?B?T044WXQvM041ZWR5bU9wakJwSFNPRDd4WjFlazdFOGhhZ0UvdnZmb2pkQkVU?=
 =?utf-8?B?Z084N2tvTUkyS1MyK0pNN05hQVR5c3o4dXArL1FYcVh2d3RkYXN2Y3lOZkRT?=
 =?utf-8?Q?n8G7wOIcEZDusw00xZZo/3+eG74siph9Q91DU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnJ5eWRGNFVtaUNkVFppTWtuNEkwbGtDeml3eDcxSW0wVEY5bmRyeGxoZGFh?=
 =?utf-8?B?SGM3bDd3S2p1V0ZOMDlpVWVlOVkxRkV1RDBkaXduZHVQWHBLSkRLNWZZVjdG?=
 =?utf-8?B?RFhqclRsTStIOHE4WndPYW5BZFl3dUt2ZU5lUGR0eFJJN2RuSnFXQ2pudSsy?=
 =?utf-8?B?ektZV0xyVWIybzZSNW8yUng5NHZDUDh5bG1zTzlSVGZiSWwwRHpvbFFCd3lS?=
 =?utf-8?B?MXRlR0puM2o0QW9RYWN4Y0dEckdueDJ5dU9aY0lYWVQxWVVzYkwxK0VxTW8x?=
 =?utf-8?B?RWRMV2pFSEUzR1ljeEJVenZJbjJLWFhkYUozL25yek1kdi9rcmNpdUNQNHNY?=
 =?utf-8?B?VmpLNTZpNTc5WjJIVVFBTVlKdXFHejkyemwxZGEwaFBrVFRWdFVtelRMZkJO?=
 =?utf-8?B?a2hTck9rSXV3SWdSN3NDQ1VWZXpjLzFNcUtFQnNGaGlkSlFydHpNMVI0K1Ey?=
 =?utf-8?B?Zm1EUTdjeXZxRkRwSCtJZHl2VDhvRXJnaGhlTWRHMm9uOHpMbi9hblRKTlIx?=
 =?utf-8?B?NkxIS2VSdWpuQUxucW9RRHNaQno5a2Exb3UyR2c3eE5YZ0owSE1QM1VsSG95?=
 =?utf-8?B?VURiTnkvZ0ZpaDZ2UWd0Nm5SaEUwcFgxTlhlSUxwYXhGellRNExhSXdDZ1RM?=
 =?utf-8?B?L2I1REVib01XTlBzKzgvc2ZKYTVST1ZMRzhuMjM4S0JFaFg5eTRrNHo3U1Rl?=
 =?utf-8?B?dmNhMndnNERPY3JqMWEyS0NnSGdQN2EwTjhYSzlyM0dGOW9FQzVweE1Bdjd2?=
 =?utf-8?B?ak9UdmYxOUJwZ2EwZkk4U3hKMm10Q25jN2x6V2FlMXpvTVVBRm9NUWFEMndX?=
 =?utf-8?B?eGtZR3ZRZVhQTmFLT1dqcWJxd2diRnFscklNTEw1QWdmUG1paHdqMVBKYUVt?=
 =?utf-8?B?Y3VRNXdYMlFNUVlxb0ZMdlhwNXMzWlhDZGlqODNFenBrYW1XUXlldmt6UlNq?=
 =?utf-8?B?V28wWW0xUU55cUNNZ2xUQXc2cGY2VUtEcHlQVVBzUmpiV0F0V2kzZThDNFRw?=
 =?utf-8?B?VHBpREhuOGtQbitLd3RwOEJldmg5VWhsMUdaS0hicFhGQ2JXaFQ5aFJkYlU3?=
 =?utf-8?B?UnIzc0VwWWZSWnJTeE1DQkg0NEd5TzVKUFp3THk5c1lHcVFKVG53NHQ0NFh2?=
 =?utf-8?B?RFJ6RzIwamJHWTdROGU3ZGlpQ01mOEZVckFFd3c2cC81QWxacXNuNENIcmJp?=
 =?utf-8?B?UkkwVXpUR0pqNFl3czhiam1aa3ZPaWpFVnFQTXpNMzdRdGIvMzdJdUVWdStX?=
 =?utf-8?B?Y2pLbUs4R0ExY1c0Z0J2blFVY1FRYkhMZWdlTDF6SmtuaHRSeXlzTkRoR2NK?=
 =?utf-8?B?SmxPOVhybFJZWmhxYW93dWdwYU50WVRqcXU3SE9ZdS9ZRG1zQi8xR1NWZnhB?=
 =?utf-8?B?WHZRSFJGcEdBU2JZT29kREFRL1Z0NlVjRTlDUTVSbU1KN3AzNTVKTG5qeXNz?=
 =?utf-8?B?TWNuMktlWHlocXMweFdySjZZcEdPR2wyczRaanpNNk1Wb1Y4RGdTdjRielZQ?=
 =?utf-8?B?UVRQaXltZy84cE53N3FHWUZ1ZHpMbEd1WXpKdjZqQjltbUFFNlJ2WFFFRTI1?=
 =?utf-8?B?TFJpeThYV2RiUlZhbit0dFJYR1Z3a0xzaFJ0Q2ZoZ2JVbWk4UzZiWnBjQnBH?=
 =?utf-8?B?bksxMnlGYjBqWW16QXFFc0twMit4c1hVVHVlOW5lM2NiZXMxZldjTEM4VXB1?=
 =?utf-8?B?eW5QcDNXKzVHbzZ6bENLVFprWWZocEJtTkFaMXQwUHc5ck4waG5oZUROOURZ?=
 =?utf-8?B?UjFZenMrU0FuRzhNTENmUHpHc2lFb25SSHJrcnZmTHNYR1ZqSlBWUVh1MWR2?=
 =?utf-8?B?aDd1NXEraTdScnYrVFcrY01hVStySmlyZTJSQTk5aE16SVNaNGM5NHFnSmJl?=
 =?utf-8?B?RStOb3BTcHVIbzlyS1Bjd3IyTzB4Nk50anp1emxMckpHbjd1N1l2ZlhUanU1?=
 =?utf-8?B?NlpjQ3pIaXRxUEZDRUpxVGZUY3I4di9obkJrQ2tYaE5iKzQvS1Y1L0dkcmtt?=
 =?utf-8?B?QzVpYk1tRVlVN09rbzUwQ3JJM3I0Sk1qcEVyZjVNaTNXNGlnQ1dhWFFwbjNG?=
 =?utf-8?B?SmhaeUdxa3FQc0ZQeVIyQkVNK21makltUUNEckdSQTdUa28weDA1STluZVpK?=
 =?utf-8?Q?vRjZMPwKNSXYNwTp1/6Rb7Qoz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3225de88-7b54-43ad-78d6-08dc6bd2e986
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:41:18.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JPviVk4r5sNokSbVKuWCiYn4ZcST5W/Ck+3pbR9PzVk1k9bRhkVys0m7wm8zsCwIMz4ak7TQ9tb+5gwAHITHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Ye Li <ye.li@nxp.com>

When some module is disabled by fuse, its PCC PR bit is default 0 and
PCC is not operational. Any write to this PCC will cause SError.

Fixes: b40ba8065347 ("clk: imx: Update the compsite driver to support imx8ulp")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-7ulp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-composite-7ulp.c
index e208ddc51133..e70a03e7299c 100644
--- a/drivers/clk/imx/clk-composite-7ulp.c
+++ b/drivers/clk/imx/clk-composite-7ulp.c
@@ -14,6 +14,7 @@
 #include "../clk-fractional-divider.h"
 #include "clk.h"
 
+#define PCG_PR_MASK		BIT(31)
 #define PCG_PCS_SHIFT	24
 #define PCG_PCS_MASK	0x7
 #define PCG_CGC_SHIFT	30
@@ -78,6 +79,10 @@ static struct clk_hw *imx_ulp_clk_hw_composite(const char *name,
 	struct clk_hw *hw;
 	u32 val;
 
+	val = readl(reg);
+	if (!(val & PCG_PR_MASK))
+		return ERR_PTR(-ENODEV);
+
 	if (mux_present) {
 		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 		if (!mux)

-- 
2.37.1


