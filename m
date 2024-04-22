Return-Path: <linux-kernel+bounces-153852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E638AD42A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725BE1F21CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB1D155325;
	Mon, 22 Apr 2024 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RLuZ+e8r"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F5155308;
	Mon, 22 Apr 2024 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811525; cv=fail; b=RcmN1e6H8J4Oeghi847oTvXMYj0Bhc3JvJeylYKR/wLmWalKYfjfvyV3VG9l7StleDiLpjemaPTJzEaq1FkC2//IFOJw+LNRdXCyx9eWE8Huy0g94k0cY3sOswWEJliyPkLJ2sWDrtfYTO1qgKFaHpiPaCsZNCW/DWnKYc9SiNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811525; c=relaxed/simple;
	bh=W4h5qCyDw50kJq7plUqnP0nUx0W/i9GCUhAEQQwDc4I=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=oCoUTMjt/vTQ8dtLpMfzEDFATsnoL8vuUoF1nHQkhxIX9hRsHEnnOELERt28R3A3PGmnza4EK19CqJubPAsiHuYcJ07FKBvXzvfdAR6IDHiwS9K6kd/qmI0K5C0LkksTQwk92ucA/qqnFs745j1bZYaTIMUorbybDR0TMHIzDCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RLuZ+e8r; arc=fail smtp.client-ip=40.107.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyOb8m4G86LvBSL+hpXEHZ29gPHUF//M3KMjvznr800pswbDihXpK98KtpW55g3159/mrKcZgpWGa7zreIEJKUE15/1jE8qJAAP6HxvejTR+iVtxOp9XhYFtZPz8QENCgRE9h0ioHxzwaGLLdBp2XZrcPG5ptmtobehuGdyHVE1Usru4YYoZaNJDgpRKWGgysIbqYSYAWxb90TLClrtX4CeRdGQC9DRUfrIIdN/R3CmlfK0SK/Fi52aC1d4mtC77Hug9rDUzmljeoBE81N3UgBoLUhp5hum4yIf8zsZ9JTDHzN9u3U5G2zqyfS4G2udRZinZppk/+hTyf8xv3sB0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tS69fwGexIRTVaSKx/1e68AYDlmpvMVr4SVY8tqGLmQ=;
 b=aqLrl5wNfJFsjxrOeB77M99cVP+wR5OdGrW/sTnfa8+GyY/nvn8ItICDF2HCdEaGpLMVyc3vh+GdivkCtK1IMXSQuDELqSSFuC0gcGroMJyhthp1V+BAy96jVa0RfS8jw2V99nMSjr1tUjzQPWNPSv0BYJyZ9m8Ju7DLBCel9YIhTn1wY410sLdRyEmzoJs6rwTIRepMr3EWESCkojPE+pOlvFq7jCH8Hl+GextokMRwGMuK+3/HyUYX4HZC98xosCfglL+mug/fKsBW5gl4IvkUS2ntCZPiu3Xg+VEYqF/aH+tlIqK2JmspDelq9TqVXZ+Kzesmp+pZp7RjIvNQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tS69fwGexIRTVaSKx/1e68AYDlmpvMVr4SVY8tqGLmQ=;
 b=RLuZ+e8rO+QIhCv1PB9Fj9ELgEV8hUwvhC6T82aotPFLkgzjJF+cYU9oHhC+N5NaliqvzNy7o80/giWi6Bs3i54fOMEEXR88GmzK0X5YI24ma0lGptSvktC7a5hgpCHKo6b3yyHVRHkd9O8Q6V+cWkx/KOYLPpCGEKnuiYTgJ3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 18:45:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 18:45:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/3] arm64: dts: imx8dxl: add audio support for imx8dxl
Date: Mon, 22 Apr 2024 14:44:51 -0400
Message-Id: <20240422-b4-dts_dxl_audio-v3-0-5017511f399e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACOwJmYC/32NwQ6CMBAFf4X0bM2yrBY9+R/GkJZWaaItabHBE
 P7dwkUPxuO8ZOZNLJpgTWTHYmLBJButdxmqTcHaTrqb4VZnZghIQIBcEddDbPR4b+RTW88FKQk
 IFUiBLGt9MFc7rsnzJXNn4+DDa31I5bL+iaWSA9e417hTNUmoT27st61/sCWV8Esv6x86Zt2QQ
 UFCVZIOH32e5zcyJ41d7QAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713811515; l=1370;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=W4h5qCyDw50kJq7plUqnP0nUx0W/i9GCUhAEQQwDc4I=;
 b=HfMgW6ilqCeJOx3ED/ASDNtZ9ALHkfCSF3VrjeQqe/aXkf0HF3/cpAv5CPsOrgHCbkVpObhd+
 c/dRwxXMZNaB9sJ3KSHXGMzjNWu9bLQs/GaChC4M+sSWHQpGFKkVA77
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
X-MS-Office365-Filtering-Correlation-Id: 0aea777b-eef8-49f8-b6e5-08dc62fc5b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STRMWit0Y2RXTUw5cGMvSkVSNE1TRVFwUE9XZ0V0UlA2eTV4d0hNRXNuZlRv?=
 =?utf-8?B?Q3ZxTEorT2lvTUJMR04vTXd0S2pUcUl1Zzl2ZkJQQ1dEaGtaUGszS2JrSlFz?=
 =?utf-8?B?ODRDSVQ5aUNyK1JsUmlzVW1ITVZ6dXRyVHpRNkRBZkxQM2dQaGlIMk96WmVK?=
 =?utf-8?B?LzVLOGJ0eGRaeDZDa3E0OERYZnJjc0tIeVgza0xWK1RMbVp0T2JqaUZZSnJV?=
 =?utf-8?B?QlBkQ2JUTnphVmRqZ0tJMW8zQ0ZQcnZuOXNkdGpIUjZnQ1RyRGFPWVlJdDJq?=
 =?utf-8?B?bVBtbXREbVFDL2dLTHZkczg5ZUVUQ2Z0aEozU1FMdlpYdld1cHliRmI3cnB5?=
 =?utf-8?B?THBFT0VUV085M0JxUUdGVnFCVGJnK3FwTnlMdDcwbkszcDJjR3E4ZkpNTDNv?=
 =?utf-8?B?YnNDc25iWXhEMGwrRUFmcWxpUEVjWEJVSFNyUzlUOUtsVkRxV01pNE5JZFdx?=
 =?utf-8?B?cS9TcUViODBnRXFvd000RlkrVVA4TVEveW1EZG5hZ3VCVWtFTlpUZjhPSVJy?=
 =?utf-8?B?OXNPay9UOEV3V2xXS2I2WDhnVHFSZGZpbTJVdWNFaVlHcHZaaFVlZ1hvWkdj?=
 =?utf-8?B?cndVWXp3aVlvT0UyejlxYmJvTmtjRjRQbHNteXk5K0Rod1dyNEZkTUEyQzJW?=
 =?utf-8?B?Uk8xc05wN2FNdDhjditCTmQ5c2Y3amw2T2x0U2MrZVdBZWdVSFgxWmtVZzA2?=
 =?utf-8?B?b0Nwb1dvRklzckZEendpdlkzZVdHY3pwcWZyZlJRMzFueWtoZktyK3RWa0ht?=
 =?utf-8?B?bURLaWhUbFI2cXpWRnhMN3g0RVFKOUROSFhXTVhwZENTVFczVjhJWnRsVjZU?=
 =?utf-8?B?TURuUWxydDFjekNHUXRaRHdPSFFGWWxBSUdNQTgwVFVGQW9wSS9tYjUyZFJC?=
 =?utf-8?B?WkJ4SG5mNmljdzFKQUl1T0huRy9ZNy9iNmxZeHcrUmFic2VsTFpBN2VWRSs2?=
 =?utf-8?B?SkwwcndCdVhoZVNFWENoZkIwdGZWaUlEZDF6MUk2WFU1MHRmYkFsRnhHaGxp?=
 =?utf-8?B?bE5xN1lMK1hDc1lnNklYSnR1V1M4bmJtQytYT3NBYXV5Sk5GZXcva2VZMzdG?=
 =?utf-8?B?bE92cUVIcVI0VEZpS2pra3hWMGdnbm94SUZnL2c3b3N0bGhKOGhaTVRFWTdL?=
 =?utf-8?B?N20wenFiOGtJNHVtREFsWXRLZTkrZXVJSFF5NitSdTN1cXdBMmg4dWI1cnVV?=
 =?utf-8?B?b3dMU2hRWGFWbzVBZHpRNTlRUzBLcWVjRHlMd3VyS2NVc2Z6S0RUc1RNMmQw?=
 =?utf-8?B?RXpMSkFxajdmdG9BZW5iTmk3RU9ZMWhaMDgvODBoZkRGRldqTkZvWGloR3ZC?=
 =?utf-8?B?cm0zdXpVbzNjUUFxTU9kT2pJR2N5em5oOWpKT1BCTmR2TTFJV1BCbDQwSWM4?=
 =?utf-8?B?cTNlelNRMFFNSEZQM3pGaHJocmNlczNQQUQrRkFHaXJHNWp2WldJR2ZVdjFq?=
 =?utf-8?B?VWs3eHQwdk16cjJCeDVkbWk1MlNqK1p1Q2thYkg1a0R5ejJpK0d6VkRkMGRJ?=
 =?utf-8?B?RllMS0g1TThBRFF3MjVZNkFLT3IwajNadlN3cU9xUUROUG1ReHBwcFBId21L?=
 =?utf-8?B?WllRU0dpVlQ1MkMyQ3RFZGlYcU9mRzhDeXk5KzZzd1BQbittaWplUytNdHI1?=
 =?utf-8?B?azJmRVFFeThBY1pWUEVlSWhEYWpGSmtrSXFYaC9wYUFBT0tzcTFjTXdiZlhQ?=
 =?utf-8?B?ZUNhTXBvMkV2TFZnSEtSN2tER1o1UWcwcGxxZEZaR21FbGxpa2dvVUlEbUlu?=
 =?utf-8?B?SGRVRUx1N3lGZWx6T1JPeVZwK2pFMExPYXFYdnhGRit6MVJCME1OSXJVVEFM?=
 =?utf-8?B?KzZHaStoZkJxclZoVzVwUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enY0UENsNmkyK2RmNU5pdW91ek9SVFhGckVOaVZpU0szbWlRSWZsS2h5bG92?=
 =?utf-8?B?cXQ5KzNSTzR0NjZ4WUZGMlRzUEFUenRZVTZuWEdnYXBkc05oaXBZZjh5eTk2?=
 =?utf-8?B?ZDZ5RzZNNXNLMmNrR3IzVHY0WjlUcDRCUWltR1FwNHVEeUJta3hlZW4xdzJM?=
 =?utf-8?B?aHcrdnZwTk1RejNiaGFHNW9NSUpnSnJvNXlCeUppWWlKc3hXVmJMbFF2bmJD?=
 =?utf-8?B?NTV0L1VWcENNVThnOWpXQnVobjFYelhnbWNpTTluSGl5VW9ENW1nN1RycU5r?=
 =?utf-8?B?YmlPbFF2QW11ei9NRU4rbVVLVGIya2NUbnBybGNxWFNRYS9LMXI0aGxOclpX?=
 =?utf-8?B?Unh5QmZsVVNHY3BOZDZTTjJlbFZsOGRwMXp0N0kxS2JISnZDL0tDcDdJejBz?=
 =?utf-8?B?c3BkVE5GL1czRmVGN0lEQnF3eVhFRjNnUUFUdGhIZisxTUdTdW1XRTE0SlFC?=
 =?utf-8?B?Kyt6VVJYQmpQTGxqYVZzSUdyQmtrNVZOYlM3U2JvSkU2UW5INVlPY2tsL0hn?=
 =?utf-8?B?Z3Z6N2lXSld1b2dXbjBiWUF3QTV3U3c4aWZxeGlqV3MwUlNDSEoyZ0IyeXh6?=
 =?utf-8?B?eDJ1Y21tWkZLYzdzK3IxTEZKaDIyUGJXMzZObWJhamRPdmZyQm85MlJodGdZ?=
 =?utf-8?B?U3lJdjFrTG1ldE5SYzJ1ZVQvVWY0WDdzZ2VjME8zdXI0R3Z4QktpWHZPSWR1?=
 =?utf-8?B?d29CN1RWL0JhbS8ySGhjWVFwYUdWcm1QREI4ejlTd2dVZzJCMUZvdmxzemxS?=
 =?utf-8?B?bS9ZSGgwVzRrRjFnb3U0RTFMR01nMUtjRmtzeW1jUDJmaFJFYjJVcWJyeHl2?=
 =?utf-8?B?ZG1wM0FnS09jaDZ0aTdJNSt5Z0VHNVVxbTB3MWZ2SlVpVXNJbW5ETkdLdU9a?=
 =?utf-8?B?MTRWN2x6Wjd1d0Frd3laR2xHeU1vbmhEWGZOSzVIbEZJa01FOUVldWdvTWZK?=
 =?utf-8?B?aVFsaWRiVmNjTlYzMHpXb1BwN0JGeVE5TUhqUjE2bndvL3NyY0MrMExsOVd3?=
 =?utf-8?B?TEZzdWZ0SlBnbzRLOW8ySkY0QnQ1SytkVHY1NFlIemR1OU8wNzZhVlU4T25h?=
 =?utf-8?B?REp2MXZDVjR3NXdTbnZBSUxxV05KZUhUaHBMYlVsVGRuZFJsRm5DNEJDR0sx?=
 =?utf-8?B?UUJZSnczV1Rwa0U4RE1mdGFieFpxWGQzMFB4cGJCNDY3bGQwakE0RktkTHAv?=
 =?utf-8?B?VlVML3BSRzVxRTVrV1BqSmhTaVNUUGdkdFNraldNQ1JnREJhbG9maGJLV2gz?=
 =?utf-8?B?cnNxQWV4SzZPa0FLd0RxODUxK0QvRUdLYXdGVEJoQkl0NlNmT2JwVVh3b3BF?=
 =?utf-8?B?QnIwQUwxRis2T2FZZ3RTNGR6Z1M3TXhRYld5c1RmV2gwNTZsZGpPc2RQK3U0?=
 =?utf-8?B?NVMxeWllNnF0KytmeWhCTlM4UFFxcG5KL0gwWG1hOUFxZ2VZT1VKaUV1bWhN?=
 =?utf-8?B?Rjc0RE5LaUFzSHFYcGJDZ01ndEhGS1Faa0lYWVBVM0h1cURxTlFZOG1UcmtY?=
 =?utf-8?B?bUh0eEhDcHdKZllEN1MvcWtkZUtLQ1Vvd0FnUW5sYnZ3QTlzSkgyOWplY2VY?=
 =?utf-8?B?UkNoR0dEZENNRzVpMWZRWWpHRGtGd1RScTd0eC91U2JiU2dPMG93VmdIZkhk?=
 =?utf-8?B?Qm9wcE00Zjc3UGRsMTNKS3FzM2NuZ3pDbk1Pdm9YcE5FQjdoS0FDT2Z6K29L?=
 =?utf-8?B?UlRydWYySy9FdE4rNHVrQy9pQzRlZnFqN2UrQzdZVEoyb2hXM2drQ2RscU9N?=
 =?utf-8?B?QWptUFRZZ3pzTW1kU2ovNXlncUx6WFI1WEU4VDcxOFh2Q1dzLytUaXhNZVhP?=
 =?utf-8?B?Z1htRTNIS1dPZW81UUVsNklWRmx6Wmk0QzVlR2R3eHFBTVR3Sk1JNWZVYW1Q?=
 =?utf-8?B?NjdDTTdmeUgyditGWFBGdSs1aXN5Y244ZnBVV2FyTnI2WGFYRk5MWExUOVB2?=
 =?utf-8?B?aFJHektidHlmdWlZTnFnS3JoZHBCUm1wZi92eTVMUEExeGJwK1FXSEUyTVBq?=
 =?utf-8?B?WWlMZVRYZm50bUlFaWFJejJaYTlqa0NYbGlndFJFVloxQlJ2MjRkTkozZGlK?=
 =?utf-8?B?ZmZudFJKZURzQVZXdmlkTXFnYVcyaWZ4VUJTOUw5eHAwOWVJTWFseEV2Zm5l?=
 =?utf-8?Q?Sa8c7UFqHmKOFmmGKhHO1pi7h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aea777b-eef8-49f8-b6e5-08dc62fc5b6b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 18:45:18.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YU5TkncxX0TEmcfaQRIaHKvLyRNQYmmeqYneUqgaIaX4//qMzFyKAP7y4/rGGs/iJe6iRhXtyQfmsxG0GcnmIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853

No new warning add
by make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  CHECK_DTBS=y freescale/imx8dxl-evk.dtb

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- change bt_sco_codec to 'audio-codec-bt'
- 'compatible' to first
- audio-routing = "Headphone Jack", "HP_L",
		  "Headphone Jack", "HP_R",
- remove extra space in fsl,asrc-rate  = <48000>;
- align clock at assigned-clocks =
- using tab in pinctrl_sai<n>
- Link to v2: https://lore.kernel.org/r/20240418-b4-dts_dxl_audio-v2-0-e4e2747b3a49@nxp.com

Changes in v2:
- use general name: audio-codec
- move vendor property to last
- remove undocument property 'capture-only', since linux-next/master merge
txt to yaml bind doc
- Link to v1: https://lore.kernel.org/r/20240402-b4-dts_dxl_audio-v1-0-d26d25b84a08@nxp.com

---
Frank Li (3):
      arm64: dts: imx8dxl-ss-adma: delete unused node
      arm64: dts: imx8dxl-ss-adma: update audio node power domains and IRQ number
      arm64: dts: imx8dxl-evk: add audio nodes

 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts      | 231 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi |  78 +++++++
 2 files changed, 309 insertions(+)
---
base-commit: 2d13a7797c3970a4eea160844d8905c93065634f
change-id: 20240402-b4-dts_dxl_audio-74ba02030a72

Best regards,
---
Frank Li <Frank.Li@nxp.com>


