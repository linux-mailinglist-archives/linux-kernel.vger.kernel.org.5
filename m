Return-Path: <linux-kernel+bounces-159133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6007D8B29C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE05F1F21D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A44158DA6;
	Thu, 25 Apr 2024 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="itU55qLQ"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59491156F4B;
	Thu, 25 Apr 2024 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076737; cv=fail; b=p83wzLGcHw5PnOkE4kzq37xTam5BQI5u8i8iwbxCXPhLxER7Bp0c8GAiF6mBz8sYgKKT8TRtvrhZbLlrkih4aW0lIsTV+EsnH62K5biajnjBRGbJojM9IVQZw1pRkj/xGJB/VwJAv/8+WCLZyJ4i5t9JgQ2qx2ZG5REgibfL8yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076737; c=relaxed/simple;
	bh=1Hjo5Nh5r0Z7n+ggINRlxikZqgMbbEtlFiuh7aRqESg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Zus7DRcdRW1wF3U/iLRyOUFNF1R9+UjS04FsdaXjGRsbN85klRt4EIhSd+lxQWi5eF8cEH7C0T6W7j6/QJRDBoktfawGiwiyn9AnoXmumWjrhhVHqlGWGEyCUEIHqzs3KO0w6S1+wVvCtzXFwApncEoFXAOC8lK5R4sveo1F1Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=itU55qLQ; arc=fail smtp.client-ip=40.107.8.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzyf6wKYhh/N1IsbLFHvyBp2zc1gWMLCk9iyZprXZBGwanyX7ZMiNtK7V4JtkNVfTnay4O9kYwrW4hkbDoXUGz1NJseCEYPmJ316lS5E+y8VZQPVW4BjP5z2aFxa23xB11r442Cvk5Tqy4nx+yPZYWAK3sLR7rrpNHlUELCD5ENDzzb2trmJukaBE/uTDK8KEqc8aNOXs9vEPTrs8zks333u/bvbjSu8QFVfqyZqLcPAtSet+97HSU2J1Y6mLXQv8KN8X1tFJktdKqCxlMUy+UGaEoA+d5rPFvwZ7yThx/xLkunHxMotJXcVxnfx75GZxRCEdaBe7fmcgsoESh5RyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7mDMj1bwE+zTT4nfQZ5oOk3n8WJnWM8yHZwM9YcUTo=;
 b=O4nO5Dl66fV4tg2MKxLfRazdK6p8iGfqjxlEqOo/9+dHDfRNWK2fc+Rm1yNcMN9375KyL7aQronYqlQ/moA4d7eT5sVsLX6vunTvoSHfrsRBJaNUVf3C8iM8HTe/2SK+lFRr2Jo73K7PRhyOqPm9osHmJsDnIKMso+JkIUXuxe5MI2cXf3JQ+0dzblnjcexjXYqt/do6XGTtjGiT6qZP8kTeHCN/GKmPNM61odoJw8ynpDLOXiNg1gGbg12FEJUvIJ94v3MjhqYz0OjxqYtao/bd3dgaLa1cZrWp07rC7boooAWcxIKswzTFy3s16dAUa0D5yS0/O+yTvem71rTemA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7mDMj1bwE+zTT4nfQZ5oOk3n8WJnWM8yHZwM9YcUTo=;
 b=itU55qLQoU+XaqD1vJ1IYpUrmrGzIY4I9/jfMp/H4G95kQRHsDsU8xYtZEmBnUXsoVUVJgXwe4Nt1TdKZxZGWnEvuIy6NW36JKuo7BFaT6kIHhHFgfyIZLMlfkIp+Ld0VO37mvPd5UnMS8jP/HdFERTqAMG4D6LpGNrOmh8puqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 20:25:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 20:25:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Apr 2024 16:24:45 -0400
Subject: [PATCH v4 09/10] arm64: dts: imx8qm: add ocopt and fec_mac[0,1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-dts_8qm_audio-v4-9-7fa6ab2fd64e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714076687; l=915;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1Hjo5Nh5r0Z7n+ggINRlxikZqgMbbEtlFiuh7aRqESg=;
 b=rf7L9uKRNw8/QmT7LKyTg9TgZPKs5Xno5LIfwRqyt+916TpC94ltU8gyGSxoGNS4nZsQJOAGF
 2ZqPOVEZ9WUCkb2yDZDvweMZ/AUCresZTT1uo4mbnLAbf+LChL7SLQH
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
X-MS-Office365-Filtering-Correlation-Id: 10550ef2-254c-4615-8d0c-08dc6565d295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|376005|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFJ5a3RveUNXUDdsS3VVLzlOWXozcDA2YmtaS0Mwb29NWG1SR2swV3VkenRU?=
 =?utf-8?B?RDhMdTdYMDJqQWY5bHBOL283dE11VEFlMWszT0YvVW8vTzRWenp1amo4ei9q?=
 =?utf-8?B?cFFvRmk5VmZjMGViZUlSU0tCQVZpb1JFeDg0NFRqUXV2eStVWVhBZWNJempr?=
 =?utf-8?B?UFVSYzlzdGp2eXFKR2RFajBLL2s3SzRtemNxWThnK0d1V1diNTdFZDlWS2ls?=
 =?utf-8?B?MTRVZ3d3Tk9ZYjBIeFZPbExkaGYyN3BiT3ZSRlJBeHFhTkkxaU9wTEg5alI0?=
 =?utf-8?B?ZDY2UVBtN1pncXJtVTJwOUZUaHhST09jNVNaU3JWYThYYXkxT1dORitZSzZx?=
 =?utf-8?B?L0ZXUkd1Unk1TzNFeGdmcSsybnVDaFdUTlVSOW1hVjNuaGMyNWtUVmpYSHhh?=
 =?utf-8?B?RVpXODRZdk9lMndnWHVZQWxVWndwdnhSKzdyWjQ4bjZRWStBUHpIQmxXYlNR?=
 =?utf-8?B?aEdFMjFOQlNEZm9DTHZtanJkQWI0ZzlZeGNIVEYwMWZibmlPbjluZHdxRGVS?=
 =?utf-8?B?SmltdFF0MktiN2ZSU1JCWlJJUkZkQW1pZ0FyZkEwbTZhcVVXVDVCUnliQWRl?=
 =?utf-8?B?VXJSZC9wekc1Nmx1NUhqNG5sV3pEeGZGYkc1WWtQbW10QXIxT0FqdE1ESk5W?=
 =?utf-8?B?cWNMSldZeWZxa3dSZURTUjE5TjF1dHBKYXM3UnFqUllOU0xWMktvbTZjRTVj?=
 =?utf-8?B?dnc1eDZNYlUwZFhLMHVqQUxNWXYrSXJzUHRyRnM5MDJ5a1NBbmtIejVXd212?=
 =?utf-8?B?MVBPakU1VnVEZHVsZ0FiaUNta2wvbkxtbjlXeEpSQVlNY0QvL2Vjb2ZUbUVo?=
 =?utf-8?B?bXVkbi96TlJZKzFxN2hvVW1BSmFNNndaQTNaK2ZTcGtrYm5MSlhRMG1Xd3ZS?=
 =?utf-8?B?WW9tc1BBeTZBVS9iNE1IOVkweUJlN1N5UHlHZ0lYeVIwUHQwcEM5THg0eFcw?=
 =?utf-8?B?c2VyOFVUKytvWXA3Y3lXd1lld0FGcG9SV3FKTVFjWlJ3Z1Z1ZHc3MlB1NmVk?=
 =?utf-8?B?OEwwNURRRTkyeVk4Uit1dzRCOVg3TFNEbThNRVAxZHVTN1c2U1daZ1RSNUg1?=
 =?utf-8?B?WE84ZE1qZzUyQWRzVHd4REt6YnFkWDRMbWlvTTFzYzVwQWZ4aXFxOTFqMWZ4?=
 =?utf-8?B?VzVITHVXV0xrakhoVUVPMEtNdjdWWjBXaXhrWHRaa1QwanVvRGQ2bjNxVzV3?=
 =?utf-8?B?bWowRkUvdmtaVTlGN0NPcDFreGxod0RCY3l6bDR4eXJDQ3ZXMk1yRyt6MnNR?=
 =?utf-8?B?a3gxQXpVMmNSOHdnZEJqejZWZzJEclpkbC92UlMvWGJTQTlJRWN2ZWdiMXVX?=
 =?utf-8?B?K3kvd3h1SDVPQW5QUyt4YTdtMmFwb1VnMVRIbHJWelRmWU8xZ0JGQjdCd25h?=
 =?utf-8?B?bGJDOTByYnlsVk1vTC8zbGZEMzJoUHNzUkY5eU02dEpWMHpSVWFGUUZZNlFy?=
 =?utf-8?B?MDJxcUVqNW9TVGlmdjQ4WUJNQ00zclppQzUyVVFJYzE3MHo1S2o0eGN5VTBU?=
 =?utf-8?B?bFdyaG1BT2hiaGpWL1BRenZoSUt5cS9kMVhXUFhsOXZLZ2JXNXh2aDRPL0xK?=
 =?utf-8?B?VjZGQkFoNCtwYjAzb2V4K0V2ZWRleWQvU1cveVdHQVh2MWRLa2ZseVI5WHdL?=
 =?utf-8?B?U2NxZVlNaTMxRzdadlN6OHpMazlzTEtNZVlxTUFBaHFzMmdLbldXNXhaSjNw?=
 =?utf-8?B?THNXby9mUlB4b1BGOVlwWHNuWW13R01OS3F4SlVQZ0tqTzE0akhpZjB6ZDJT?=
 =?utf-8?Q?0SSDjNch00TaRWxx9xYppBh2+1F1gS+Kjk1OSN6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGJ4S0JQRFJUbFNlUVpEMjg3RVVDQjNpWUxVY2NMZTFaR05uR2ZsdmU1b240?=
 =?utf-8?B?TlRtakJDS0kwallPc0RGNWRZSzA1TFl0aktPMUlOZTJoZDg3R0dRbFMrWldl?=
 =?utf-8?B?UzcwK1J5aGg4UFhVb3F0K2dFdGpZYnN5R1dhTDdlSFVVZ05mWWlPU3dUa0ZE?=
 =?utf-8?B?MlRUeDBCOHU4THFwdmdRS1NQSHdnd1BaU0RWRjFYbzlUWEtYMFN0dnI5VXND?=
 =?utf-8?B?NTMxajc0bXE1MlVEUkUzK0pqeGU4d1dlTmNjRWE5RGozVVl6eFF1Sm15UGtk?=
 =?utf-8?B?Vm8vYW94NGJSWlRKa2dtUUhCS2xLU2ZaUG1DU242MXA3SGQ2MDEzd3JxUzhl?=
 =?utf-8?B?OUNUZ0p1NzFZQmRVbVNnZWFHa2JFSE5NVFBkSUVIWEQvUVdlTXRhWVkxb09J?=
 =?utf-8?B?Y05IK2dlaElMeDkvdTJpb3dHWkdtMzRtMmJhV3BzUjlMRmwxeDNDSkorcHhP?=
 =?utf-8?B?Y1ZiSTcvR3JUbGhSSEFGL2NKaVBqMk1XRCtxaGMyR0Z1SzZXVXVqU2QraC9z?=
 =?utf-8?B?a3FmZHNvRE84WVM2V0UraTZTMlQvemFycHpDaktyNmovdm4xVWtiMW1ZbXZG?=
 =?utf-8?B?ZmI4OEEyYldmMTJoMWVXb0JITWxPaFpSY1hnRU1EdEZVMzd0eDdXTEEvdU9Y?=
 =?utf-8?B?bVhzRHhSd0xwQzk1UW90Q2RtZGJ6NFpuSElXa0VCY01yeXkxQXJJR2huZnpN?=
 =?utf-8?B?OHlIZG5XdVpGNW9IVGNvOUJoYVNGYmxkVmRtZlV0aU1RZW0zeXR4aHlKdVg3?=
 =?utf-8?B?bnppYVU3NHdrMUNyelI4eDN4eHYydWNsZkZHMGVDVWdaWkt5cDBKTGJkVmJr?=
 =?utf-8?B?V2lOS2tMa29jR0xPTzB6bWhTRmtMZ2JKdlkvTENlNXRuVFFIOWFlWkFURFIv?=
 =?utf-8?B?cHRxWVNyTWEwL015TXExMkU3bk56OHIyN0xLUDFPdTdvQk1tMnFKL1hTNWZZ?=
 =?utf-8?B?dXRJaURHVGVJR2VBUGxHYUFZem1MNVFvNTlmdFMzRENxbnovQTJFUUt4RVlJ?=
 =?utf-8?B?Z2Zmcjdnd0lkWWJTaEFJSGR0WlJ0VlF5Ti96UnA2QkludlFWMkNuVEYrODdS?=
 =?utf-8?B?bkFYalFFS2V4d2VhaXlKcXdyTU1hWUtiTG1xeE1GSnZEN3pMbGlMUXBSNU9v?=
 =?utf-8?B?TzdsWS9lMDdSSDNWM0IrdjdTZEExU0tpSVVWdkdhdjVXRjFnQVZiMmJzcjFI?=
 =?utf-8?B?b2VBK21BZURJOExlZVloTG53Z0hPUlpuMFQrQVY3Y1h4aStmMUlxRC9hbmsy?=
 =?utf-8?B?bDE3WUxqL0xOeVZnajhhTGM1d2ptSVFJK3pFOXdaTXdpNjUyZVZ4bCtrTUp0?=
 =?utf-8?B?UUtzczQ2bC9KR2pCc3FlQzVNZ1V3a1ZYK3Q0VDhOYkZYa015d1FsVVo4N0dE?=
 =?utf-8?B?U2FtTDc1NnJGWHF2OStJa0t2bEdsL2U0Q2ZlYklxWjF2UGVXSW8vVVdJRCs1?=
 =?utf-8?B?c0d1blJ6YlMxdlM3VjRkcFZxNUtoQjVLMCtEM1pWUEt6cTVGeWl0ZGdYblN2?=
 =?utf-8?B?WVRUZTZGdzNhSVR1SENkMUdaN1Q4UlF3SUQ4aitxeGxSUXZIQVhWNzhiSytm?=
 =?utf-8?B?S3Rtd0NueWFWeUZvTnl3SXpoaUdqWmJTSXJWN2RqRkNkQktnS0ZoTzBUZmE2?=
 =?utf-8?B?TmFRMnBieTExQU1rMGFWQzc0d3BvS0JHUjlFaDdaZjhVMnNXdHJHSEVPZDlR?=
 =?utf-8?B?Ykd6alVrRlUxWTNGNDR4WFdZUGsrc2hjQkc0SG16eEZUUkxnMGFMSS9RaGI0?=
 =?utf-8?B?Q2xUWlRHZStkdmtDOGpYbmVITEpUNXhXRDVoaTdPVjc1b2FBckxBNFRvZElF?=
 =?utf-8?B?YVhqcHZNTzlRZlBjcW1kSGV3aE0zdVJBVzljM0tNcHBVZytRdi8vazFXaUdq?=
 =?utf-8?B?M2RzWEY0dWJSZE0yaEJBVmtFUjYvaGM0SVlya1k1Q0tQZ1YwNHpVdkcrY2Rr?=
 =?utf-8?B?enV5SkxzZUFId0tTWmdIbWUxZzVReEo2b005YlczSmJRaTJRZmIvRjRjeURj?=
 =?utf-8?B?Q2ZiRU9IeXBxaDY2QzNTZlhGb0U2R2wrQTNaKzUwMU5nL3NCZHhIYVhBdGJw?=
 =?utf-8?B?emVjVWpSQXF1OWhjWjBuVUx5TlZCS2FOM0craExuc090M04zMGVHd1dFa2Rs?=
 =?utf-8?Q?1tKKtqf4SGuOFX3oiusRGlbAm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10550ef2-254c-4615-8d0c-08dc6565d295
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:25:17.9564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hp3pbMBZPtpGUj15nJu6LAjB9rG3Pla9p1DRa1wUMJ+QlnBkN4yO5RT17CNUDFBmaRVB0lukz8DJQywzK+uK2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

add ocotp ad fec_mac[0,1] for imx8qm.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 8e94ffe1acb57..46a8046e9f508 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -333,6 +333,21 @@ rtc: rtc {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
 
+		ocotp: ocotp {
+			compatible = "fsl,imx8qm-scu-ocotp";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			read-only;
+
+			fec_mac0: mac@1c4 {
+				reg = <0x1c4 6>;
+			};
+
+			fec_mac1: mac@1c6 {
+				reg = <0x1c6 6>;
+			};
+		};
+
 		tsens: thermal-sensor {
 			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
 			#thermal-sensor-cells = <1>;

-- 
2.34.1


