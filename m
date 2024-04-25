Return-Path: <linux-kernel+bounces-158811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2754A8B252F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7069283E38
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0214C5A6;
	Thu, 25 Apr 2024 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AmJ/nWUP"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAA414C58E;
	Thu, 25 Apr 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059307; cv=fail; b=ChT1v51pDajfPwoxDUGvhJwrg7A0Ko6HVP7M3C/yyMl9wrApDKQZe6b9lAz5bdOsUMxQ0aaNo2eTW8iom4zV9FZvzgvhYEdDO2KGP8aoBqG2bn4+o+kpM5Y9sKO/fDAY5qtKztlsY5mFyFFbOOcm/oKCLveIfrMaBEIT0xVE6eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059307; c=relaxed/simple;
	bh=p8vdcvIu/jGl9YElNP5C9gcehzRlZvEtdSYDpJQ4uhw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=t37Nv1ynzrJJyb/7UqwLwWFQNds7cGz7iCjGDWVzOcUVFF0tJ3VoPsu9xkih+750A5YutXfAmIS2TJj6pT6FUOBAV7C3aOtiHWvgjyOF+VGa3FL81PiUmeLt+B5zaitgH+wzxI/gGMxzYvqt7a9eNuKvj1EbyMICWZ6623AlCnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AmJ/nWUP; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkVI69CK3giPsmULZOxhz24rZRKQkaneZUarNFYbyBKFLELNBgUONJlolKHLVvM5I1AoOmWleqC0f+JO9V86Xe0Q8s+qUjkQEttvgZC81LOpDrQQMcRtT3ZbOkKv99FOtRKJon1ysn7g285IcMtrdsoZOfSpkJWClwVTx7/CaUonZjEVzKLrklc5a9My96N7Pe20iV0ZzUZVzIMsPEvmUcA5+oZV7egT6bl/W/RKbi5zqDN45OvZwv+dGj2CfItgqN2lsv1iDUqfHYVOyp/2yIo3TFCJpTWay+EAMbMMw//DJaVAaLPe+6g8fI/AtUznXOcFke7uvdRwEA+i2fVJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85hNXh4LDMGO9JJQxkOWEdPyQphnyUFJYav2LP26zIY=;
 b=ec58GlrOk9k1xGvu3H3RcsMYg8Uex9vU9WnX9pd6hIMh2qTsAe073ZWQKVUKyUKBXCvoiwdyFbCgzM/g+j8fUAeQGCGseZf9oICMDM7MN3zBWtoE5H4VGgkipn1VMUzZ3KVQL5eCSWxhITd4i1OsPOJd0sU46I8ioyGZZ5kROTTMdPPAW4fdHjYB3tqQVGRIX3DJfZw5IdAU4C8T+e1wM3HjX5jd0jtWy6ixYgYkrvH5FNCKUbedr78boQE8QpyAHTrSlQsxSdyrJ3ZCm9kCiExg3g1Fa1eNYk6szZpnf0D0t17Rw2FAhPnwk1h7nL1tamsn2JXl2xSWaBq9uLwpBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85hNXh4LDMGO9JJQxkOWEdPyQphnyUFJYav2LP26zIY=;
 b=AmJ/nWUP6eN6PDMsUYHEAsrvNh6+HtNXND4if+RiT07SMK6O7ZfHXtaTRf2pih/yiaa8n2OAM97TXqBcimfTlydxjS2Ifm5dh7sJXn+oiUM6YPbXstwRg3nMNyAok4O7w7i5yv8b75aw8n45eABDk4LorpPm7R48wH6BNyJkEuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 15:35:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 15:35:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Apr 2024 11:34:42 -0400
Subject: [PATCH v5 2/3] arm64: dts: imx8dxl-ss-adma: update audio node
 power domains and IRQ number
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-b4-dts_dxl_audio-v5-2-46397f23ce35@nxp.com>
References: <20240425-b4-dts_dxl_audio-v5-0-46397f23ce35@nxp.com>
In-Reply-To: <20240425-b4-dts_dxl_audio-v5-0-46397f23ce35@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714059292; l=2570;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=p8vdcvIu/jGl9YElNP5C9gcehzRlZvEtdSYDpJQ4uhw=;
 b=f96Dpqi6dVeOfe/tvjsIjQ6/jXbbs67QINQMWjDpxsA+hXn26YNXslFP8n6D71exDHeUaChJW
 wMFIR1Q5N7sAfDEEgatI5z8R/2tZsZ4S8h8v+sDE4hkPX4s8JhTawt4
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:a03:255::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc7a357-c8f4-4172-200c-08dc653d4632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|7416005|376005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXUyMGxXVmF3Y3hOUEdBZ1A2bHlRc2pMaFJwN2QwMzlEK01TdXBFRlZBeVBK?=
 =?utf-8?B?cndFKy8xUkFmUmRNckpMMm5OVk1XWjNDaDE4M01ldlBmVHRqMEF6eFlkQWdQ?=
 =?utf-8?B?RERSNGpjcjNrODQ3dGRIaVBLWjhjaG40Nk53NVhDMUVPN3FXbWltcytxKzJO?=
 =?utf-8?B?VDMwTnFic3c1MlF0SG8rOVJ3YXVIRWRFb3B4eUhRSWN3UFZXa3EzSzR6ajlE?=
 =?utf-8?B?MVJrcWFqNUhFSW41UUMyRHVJZWpnZzJkaDh1NGpteU1pYWtlTnFTTExqWW5w?=
 =?utf-8?B?Z2NXUTZ5ZVp0MnJaU0kxRjg3dTU1eG5JR29QTFJYTVdIK3B2aWhCWFJMd2pr?=
 =?utf-8?B?VktJQUNqanVaRE9xbkY1VnlTSXU3ZlYrYm5YdW9SbFcxajNMbHU3NmF1Tm83?=
 =?utf-8?B?cm9OcnpnMFJRY25leU5LSWtjZzlaYXNoVDRZb1VHdW5jNVBZYU12YVltOUNp?=
 =?utf-8?B?TWVSelMrakRDVE00N01IQXhuUlpIUmF3ZmdYL3I5N0w3ZzliNGVZNitpenoz?=
 =?utf-8?B?ZFhJVVR2V29SWXVxRm9WMitSbUhFWDN2QXBWN1lGTFVjaWVFNlRtanhrd2JU?=
 =?utf-8?B?TjM2S3hSSjl1andISU1IdjJESjd3UWJWdXliTmJFTmtUWGUxb0xUei9XT0FZ?=
 =?utf-8?B?VmVoZElHeXRnNWw4L29lc2NLR3M4b1ZiZURuQ2tZMzVnSEpvV3FQZWxDdUVr?=
 =?utf-8?B?ckdHMzF4ajRKTkJuQm9sSW93aUxUdUt3bldGRGZ4eEFsWGNvb2NFQUZiSW5h?=
 =?utf-8?B?K3RFOWtGUmR1aHQzUWJFNU9hRkVIOTgxMXR3dEZQWHJRVEJGWmhCa25qNjJU?=
 =?utf-8?B?RUpBVTdQWW8rajVhdC82OWZxT3ArTkw1Z05XS0IvRU1NK3MrdmJQYzNxOTVz?=
 =?utf-8?B?RUQxU0FXbXN2ZEhTenNZSXpsOW5OMzNQNnlpbDRYVHp6MC9abUZETkliN0tE?=
 =?utf-8?B?RWhSdURIcVd0Y29UcWRibHBGd0tEOEN2ZXljQjk4akhRanhrWXBhVVFLSEhW?=
 =?utf-8?B?c2dEZWNId0c4eTZjYlA0Q0RFZ0lqWGZ3RHhlZXZNclZGa0VIZ0JJS1ZnWTdH?=
 =?utf-8?B?OVVLU2t2L1A5Sm1CZ2lHK1JMWE5mRCtUOXdkNi9ENGVqQXpLaGJDU05UVUIy?=
 =?utf-8?B?UVN0c1BVMW5nRVA0RE5NWFIrTFN5Wmo4ZzMrdTdOMGVPVUZXaGRBQmRQSE5v?=
 =?utf-8?B?alpTeG5zVFlEaEFjYjEvamx2OTMrelRuQTdOVitxenBzSE5oM2Vwd2RMNk5v?=
 =?utf-8?B?RlFTRHR3a0V4cnBVVGRVZ3haMXNyM3R3V2xvOEF4cmtJOEFLazFNcDlFWmU1?=
 =?utf-8?B?OTR6R0VWcEVMU1lscXcxckdMbDNYMElWNHY5MUd1ZC9BSEZWd3FHb3c1cm1W?=
 =?utf-8?B?V2o2K0swWXdjUWs2cndkWnlpK2ZsUDVjamZTSWpVMmFBN2k3SDd5SUJtZ3B0?=
 =?utf-8?B?cUpsY08zY0pIZk9XcGZwWWJlc2NvYTk4NTFoNnIzdHl3Nk9PS0pnRG02eTdR?=
 =?utf-8?B?TDRYSFEzNFdIRU1XWmlyOUJ5Vkc2aFpNcVkzWVQ1a2Zvd2hNYWF3K2ZldDQx?=
 =?utf-8?B?bDVRS2trTWdhYmk3SHd3cE81UTVTQUk4THcxTzZKWEpZTHNYSTdPR3VkK1JP?=
 =?utf-8?B?ZmxvckwzR1NSMTRQOHZaL1dDZ1F6ZFR3YUNCVTd0U2s1NDc4bDBXMWN1Zm5y?=
 =?utf-8?B?cy9TbU9aSWhWbmlNa0pSa3pQaU9udTJyUXlWRDFjSVpTNTdWbWRGOEdKZDJ4?=
 =?utf-8?B?K0NUQWNxQU1NdjYzWXBvSzJtN0Y3ZnFjZXhnMnJHemk2MlJIUzFRUjVTM0R0?=
 =?utf-8?B?di9hQS82Tk1LTTVpVm1SQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0V1K3g2S0tIYlRDMy93V3ZzbGYxaEpmbjZ5ZmM1V1czNkJ3elVEZWFFZTdQ?=
 =?utf-8?B?QnJhdnBTbE8yQTBJTGQwSmdWa29HSEhQZGN3WEROdjhSbEdmYkpoaHpvV0Fs?=
 =?utf-8?B?Qmh4dUo1Z2VML3pXYUFzOW9ucTc3NDJiS3Z5enlEREVjSkFXWHBzZUV0cmJx?=
 =?utf-8?B?YVZFd0dPSCszV2kzbnVha3kyQXZpRnFDbDlyd1BZaVpTb1ZSTnBEc0tZUTI5?=
 =?utf-8?B?dUNaUzFQSDNHTkp1VEh4a3ZuK096cXdKUXB5UHZQTnpQbGtsem16MGM1R1l1?=
 =?utf-8?B?MkVTUW9Md2ZKN3ZiT0swMWtKZGpzR3VieC9CMXVwN09GNTFrcGlmYi9ZQmEv?=
 =?utf-8?B?SDR4TUtaK0VrU2M1cGtKUnliUXgzY2VVbHJCS2VGeVFLZHNhbXBWdGJ0YUxV?=
 =?utf-8?B?UFN5VjJWS2hCUWpWTWY2azFqQ3pkckoxSGNLeXI4dWFpRUhPbjQrWVQ5aWt1?=
 =?utf-8?B?WlZ5QlZGTS95NWRIdEV0MDl4NmpXaU9oMjNWQVNZWWxMR1dCendCNDRsc0Z1?=
 =?utf-8?B?VG9RZDJKeDVoUFJEc21oQVVwMmYvdXVRMXF2MnFtNXBuaEVSL01Za25MV3Bw?=
 =?utf-8?B?emRZOWhIZXB2T0RtV3NJdzJZalBjblhvL0hqTm9IRGVUNUtXUjE5bFVQTFIy?=
 =?utf-8?B?RjJDZDhtV3ZpcE01NWZYdjc4bDNEN1VyWHZQdC93MzcrRTFFWU81NjNaejF0?=
 =?utf-8?B?RzJUc0RNZ1grQkZsSVBmUTc2VjV5b1dQbVlHOWpuUU4rdEFXM3c4NXRYNlVQ?=
 =?utf-8?B?Y2xRVjNwVWxGbEJnWE1rQWJmVjcxRW5XUEJReUloQVljTE95dUpIS1p6aFdN?=
 =?utf-8?B?cEVxcVFnRlVlT29idnVBZ0FkaHUvbGNxek5ISm1zdktGenlmSDhKQkJqbU1L?=
 =?utf-8?B?VEtzZ1JoaVpSSmlaZi9PeHE3aHI4cE9kUy9hVUhHL2FYQ2pkakJ1L3dScjdU?=
 =?utf-8?B?dGZKWHk2NU53SFZ0TzdtQlpSRzRRZTlIMnlSQ2kzN1c1TzBxVDljNzdzQkRs?=
 =?utf-8?B?N0g5NTQveDFHSHNqREdrUGVVY29WM1R6UjRpUGU2Q3AxaXc5cmhwNkxwak9o?=
 =?utf-8?B?ZlYwY3pWQU40NG04Tm80SlBvc2ZmTTNQa1hMQVVWTlFZSmE2cTZBQmp1ZTAw?=
 =?utf-8?B?UlBEbDhMNXd6aFhOOWt4dEJUYnUvaFNqaEMzVG5tSCtEOHJPc1NSZmdyTC95?=
 =?utf-8?B?TU91Tms0dEVPSXlIcytscERyNCtSL2JYbGw5ejdpVW0xYW9zSHM4UnJlemZT?=
 =?utf-8?B?ZTFFcFpiUXlhMC9vSTFRSW9BbU4rUGh0b0twZk9oV3VlZWd0OUdPSHUrOEVP?=
 =?utf-8?B?RExwb3lWTlowV3k0dmFiaHkrUjAzQm5CelBqbXBtdVBLb3NoK2JScENMUm5C?=
 =?utf-8?B?QkpLRExzK2IzQ3dWd09zemtScmppZFZ4czEwTkFTN2FJQWhKeWNrSUhPTEQ5?=
 =?utf-8?B?M1dicENEZXhocXByN1JHYjJoaWhyK0doMSt2SFAyWUNaUXZLTkJLTENKd1pu?=
 =?utf-8?B?TDhyV3NyMXN4aGhJbWpjTWtuc1BDWWpNN0dlTDIreVhkZXZvbWMxdEhtb3V2?=
 =?utf-8?B?c29jb1pNbWNlVkREQ01UcEpZSC9VdWtmYUdPWVZyaDNWUjk4RGZKZVdCN21y?=
 =?utf-8?B?T0xPZ2RGMzFyYVUyMWI3a2Z1YTFjZTh2UnRGVlpKQnhSQmhIbjd5b3pITkZC?=
 =?utf-8?B?S3RqbWFzVkt1SHNPZVpTdmswZ3pWUGVwRXlOc1RMcTJBMnpZbEtzVk16d21Z?=
 =?utf-8?B?YTdwY25obDV0eGFVZnRDMWZaY3VMcFFQSnhORG9QZUNYcnI2ZzFOSVEzVWda?=
 =?utf-8?B?S3lYVG9SNHdxZlptM0xvN3U5bnBWVUpKZWN2TEQyM0xqb01qL0ZqOVVITURo?=
 =?utf-8?B?dDdDWHBnc0VPcWp4bXFjV1VmY3ZueGUwWWNTZWMzUTNxOFFOT05MTVYxaXp6?=
 =?utf-8?B?Tmtma0M2cmw2dUVFalI5TVhZaFFwUSsrZEczL1RlSTZUa2VvUlBSV2VkS01E?=
 =?utf-8?B?a3ZESWQxZlYrRHFlc21MZEM4dWVqSEpINTQwOElMSGQyUkM1Zys5c0R3Wlpv?=
 =?utf-8?B?WmlWWnplY3BuWitIRXl6ak04VVdINmw1cy9JV0pmWlJ4Tk5ocDVTdEdLS1Jl?=
 =?utf-8?Q?vTxE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc7a357-c8f4-4172-200c-08dc653d4632
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 15:35:02.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aotxI8TSCuNbp/krYvkzZCdFRPW5MvF/FdoZX/K+VPGQe0vtluQYtWtE549wAtt5103sjDl/zLQC26a2z7yaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020

The power domains of i.MX8DXL's acm is difference i.MX8QXP. IRQ number of
sai[0..3] and spdif0 are also difference.

Update power domains information for i.MX8DXL.

Update sai[0..3] and spdif0's IRQ number for i.MX8DXL.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index f5dcdd9405928..72434529f78e6 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -17,6 +17,49 @@
 /delete-node/ &sai5;
 /delete-node/ &sai5_lpcg;
 
+&acm {
+	compatible = "fsl,imx8dxl-acm";
+	power-domains = <&pd IMX_SC_R_AUDIO_CLK_0>,
+			<&pd IMX_SC_R_AUDIO_CLK_1>,
+			<&pd IMX_SC_R_MCLK_OUT_0>,
+			<&pd IMX_SC_R_MCLK_OUT_1>,
+			<&pd IMX_SC_R_AUDIO_PLL_0>,
+			<&pd IMX_SC_R_AUDIO_PLL_1>,
+			<&pd IMX_SC_R_ASRC_0>,
+			<&pd IMX_SC_R_SAI_0>,
+			<&pd IMX_SC_R_SAI_1>,
+			<&pd IMX_SC_R_SAI_2>,
+			<&pd IMX_SC_R_SAI_3>,
+			<&pd IMX_SC_R_SPDIF_0>,
+			<&pd IMX_SC_R_MQS_0>;
+	clocks = <&aud_rec0_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_rec1_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_ext_aud_mclk0>,
+		 <&clk_ext_aud_mclk1>,
+		 <&clk_spdif0_rx>,
+		 <&clk_sai0_rx_bclk>,
+		 <&clk_sai0_tx_bclk>,
+		 <&clk_sai1_rx_bclk>,
+		 <&clk_sai1_tx_bclk>,
+		 <&clk_sai2_rx_bclk>,
+		 <&clk_sai3_rx_bclk>;
+	clock-names = "aud_rec_clk0_lpcg_clk",
+		      "aud_rec_clk1_lpcg_clk",
+		      "aud_pll_div_clk0_lpcg_clk",
+		      "aud_pll_div_clk1_lpcg_clk",
+		      "ext_aud_mclk0",
+		      "ext_aud_mclk1",
+		      "spdif0_rx",
+		      "sai0_rx_bclk",
+		      "sai0_tx_bclk",
+		      "sai1_rx_bclk",
+		      "sai1_tx_bclk",
+		      "sai2_rx_bclk",
+		      "sai3_rx_bclk";
+};
+
 &audio_ipg_clk {
 	clock-frequency = <160000000>;
 };
@@ -191,3 +234,24 @@ &lpspi2 {
 &lpspi3 {
 	interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 };
+
+&sai0 {
+	interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sai1 {
+	interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sai2 {
+	interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sai3 {
+	interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&spdif0 {
+	interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>, /* rx */
+		     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>; /* tx */
+};

-- 
2.34.1


