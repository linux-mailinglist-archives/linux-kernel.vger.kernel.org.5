Return-Path: <linux-kernel+bounces-168475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5794E8BB8F9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2431C22E1C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1872B9AD;
	Sat,  4 May 2024 00:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AOV72KuG"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2067.outbound.protection.outlook.com [40.107.241.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2E2B9B1;
	Sat,  4 May 2024 00:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783355; cv=fail; b=b4DNizFUOzwyrUMXvf+gillgpeRMwrfrBlfotFuqSJhkSz+PK0rB3XdKj3mMJb5eQ43jPOlJO4xeo7Zed4dszkHE7TKqP4YvLLiVA7jcmGY5yjHOdPVtZOA3Iy5iAys44ELxQevUUhaJz7q7Nk7NAxMKpShDRKIRr9y+OOMdc0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783355; c=relaxed/simple;
	bh=8W0rPna3emTHoikPkLr5ePnGBoEpKuE0aOZ8ALmooP8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hqiXN2dFDim3V/5eE7CO+AqzrzhS4s7uQObWi1ikt2vBsrrGpliD1J9wMjBh6ebzq7N+w5+rWtto6K2IhwnyytBmitxZyUawIDSibijC4j0ZKjiW3bRQxDcat/4GirT9+4hQ9xFC9RnRQvscYIB/M1XWSQwvtJ+dG4fEkRpBJPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AOV72KuG; arc=fail smtp.client-ip=40.107.241.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e501sz2eIl5leBC79ejLIRJAA6iMBdzd8z5D9uVSS2yzDggxjD7mC9nDvrwQG7u4LBT3IgIL/yECMzx0OKZEuWb9DEH9Prf3h99Q8sNqJ6l5q49WxA/12tyIe+FWWiT1HFnPyBgsZoPKk5BfbeqlB8VqwE97UyLKQMoZ8bgJVik0VlVQDrYWtnHp4LKkmE4xv9JkC7TTPWnkfdHcSWBgvd3Pppy43BsIfrPrWqpTaq31Lqjw7QiZG5ZeY1UpxH/5N3ZdbjgI0j3fVnAKjlKS81uG9nBrjSiyEGhD2wpZE/F0HrFQZBRH8ocCD0IrcKaQvJG/wqKRzrmoVxg1XcVnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY/GT1ELAKVfVDNbLWCrDVrGzIpKnzihRrdLfAvUxdE=;
 b=ZIYfYvKtMRiGE5NSKpHgDlyqOCGAd26S7RQttfGHXIEkUoG+2znbo2HjrLzavUE2VGrFkUGcxtFKmBxV/zw8YCnwrqIbwQ4FoNd43yTxWjlcX6mUCCwd/PgNO1kwFGRPwl6cUAc/4t40828RaRwUPOhkFDHho//LPGd4NyoJdU1Dfls1rx6TUxjj3ZHNBYeDmGpdumfWvE2dF8c6mN9EMdfmtmZgX/M1aZlcpJiOsOpg8c9E2Oq9lSWGW/B0xQjIMVghFxvgjRf4ipFc5OTAYS3dfVngJ+LpKEf3wvCRuBoEN2LCPQowqWm1Y6eSHwIcZMfG6ONfeepWNIuxwoKSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY/GT1ELAKVfVDNbLWCrDVrGzIpKnzihRrdLfAvUxdE=;
 b=AOV72KuGu5sQcepe45W3s6KbkkwsycMHKdow8W75Ug6KISIk0xeLYBIM2b8bSCWzyODN2RicAYm5RYXaZtVbMhJwimdcRt6XVhjH5IDynhJygvBMqJY0sm1+fkypcZEo7VJ2/ttTd35JNamMY1yT7wS6bXQa017vDQPrjywZj2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:42:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:42:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:49:09 +0800
Subject: [PATCH 16/18] clk: imx: imx8qxp: Register dc0_bypass0_clk before
 disp clk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-16-f7915489d58d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=1742;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=/aYZoW8KghW9QdRWN1taneDgZ0S6szdiimpOLxZFTlY=;
 b=I2PAvJycJ/bjyRVAVDrUO1WLesPoitmd6g5cS04kcV86ET5ADyrAvnSvkDrAMpOLbJRt29A+u
 Nye4A+VO3hwB3S/cZVPyeDLdJAFHAZQlNHdMpTGiQznYdeLxo9Bald6
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
X-MS-Office365-Filtering-Correlation-Id: 723a506e-33b1-4657-7088-08dc6bd31462
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWREaUNHYnJDZ044RXNpRjc5azlFZlVMRlV3bVh2L0c0bnhqd1NYR0wxSVNH?=
 =?utf-8?B?em8xdVJ3amphdTEwaXdLYXBheWpuaGpXUFRZVG5ZT0lZTDUwRkVtTXNZWGxB?=
 =?utf-8?B?aWlleWhlR3R3b3FFQTMxNC8zVDBaN0JEdm9MU0cvREpPQVRqOGhhTDQzcmJE?=
 =?utf-8?B?ODJXa2FWVU9TSmNlVDdSQ1R4TmxDQjNpSGFPUExNY1gwaDNiUFQ5cExrMENO?=
 =?utf-8?B?ZkJzRU1TSHRpNVRTOEt5N1V2a3ZGMWpaWDlTRXZlNlRiWTdHdStKY1JaSytp?=
 =?utf-8?B?eWtIQWVTamE0QTArSjRRbUtGNXdZWWJCdkVoMHU2THBvU3V6UTRFeUhURzlR?=
 =?utf-8?B?OWlmcWl4TCtpSThUSGQ2aG1MbklnSGZ0VkxyOGVFTXMzYlRXbjV0M1ZxdDdq?=
 =?utf-8?B?Vm5wb1VPMll5emdIY2QyQ2JORHJHbDZrdk5YVDJ5UUJhMklBZ0t5M2xuVVll?=
 =?utf-8?B?TW53TGdaREVrblZpcEw2NFlDVDZLekt0TkdGcEZjemVpT25JNEd3YXozUzZD?=
 =?utf-8?B?VEJSZzJ0ZjNTcklRS0k0NHYvYUhYempweU54VlZxVmhMa056eWJLOEdFVDNr?=
 =?utf-8?B?RzVXSVo5NHFKRW41VTNRMFg3bXJ5YXEyUnlYQ0lZdGZZdjdzZ1NQbkEydC80?=
 =?utf-8?B?N1V3RGRFR0s2MWpSbXpCQVhiNW01bytnRVkxTVN2dWlIcTN6R2EvVXNMc0Ji?=
 =?utf-8?B?a2dmTDF0NExoK2tkN1FDcEozUWM0UVlHN0VHRUhRWFBjQ0N0cExSdDNuOStH?=
 =?utf-8?B?RjdsSUFGVmFUUFAzOGFWMnl0L2I4YVNPVjNLZ0JuVXVmMlFDSVkyRytqSXpV?=
 =?utf-8?B?MnFpaEpTa1p5M3labjN4WkQ3YlFoQWQ0clJkMEV4WmlnM0FQc3A0WlJpZGFw?=
 =?utf-8?B?b29UNGh2NS9UM0l0ZVVkT3hYbHEvMGFsR05samhVRUtjdVBWSmxoTjRteTYx?=
 =?utf-8?B?VkhCbG5ybXJ0MmRXUjdhQlFnYjArNTFHUmg0MXFlMDlTcXczTnBvWjcwY1ZI?=
 =?utf-8?B?N2M5L1dxandUUTA5UU9FZEh0dXhwRjZkTVlVNVc2LzZzQ09yVnJjOHRyY1Jz?=
 =?utf-8?B?QjNxRGxlNkNaUmRVTnNva1BJeWxTejV0c0k0d2VvQTNjUlNWbTNmcUkrNExv?=
 =?utf-8?B?VWh1Nm4zVEZlSDlDQUlqU3NnaHdWc2d0WXVFTHMwbC95N3BRVk9MRjk4ZXFU?=
 =?utf-8?B?S01Xd1FYamVoOURWWmtIUTh0d2Nwc3RiMGtGQjNTZ3Z3Z25NQkE3S0lvSm5D?=
 =?utf-8?B?cU1NSjNtWndHYnVXdVFvblJrMGQrcXdldFpyY0kxSDZHY3pVZ1g5MTFtR2xF?=
 =?utf-8?B?QVY0dGhnY0RLdGhtSFdwYXIrWWttaFh1cTIvUkpTc25qR2xNYklYVGhNeTNG?=
 =?utf-8?B?eURqUGlzcWwyR3VpSE8vMmZ1RU15SWt0QXFYczVMcXA4U0RIdHBMNCtXSHc5?=
 =?utf-8?B?d3hQdG9WcVE5MGxEdXZEaHRNMGZEZHRIUTYwU1FuSTVBVDBNMkFCZzFQOEp4?=
 =?utf-8?B?YS9VNW9XTTBOM1BUZERsOUZHa0txZS90djF4RzFUdnZyckFVcHd4RjdtYWpX?=
 =?utf-8?B?dFNuNzU4c3FKUUdhRmU3bkFCNWw2R0dvZXBITFZBbGpOdmZzaWYvb01Yakx1?=
 =?utf-8?B?M0RIdGRVOGF4Vy9QSmF3S1hvQ3FjcjBGNHduZllQU0VMWjUxS3BpVFdydDhF?=
 =?utf-8?B?U3QzZUhnODdRdmJNa3BCaS9FOEJ6TXRuUUlGOVJ4U2xESDZWREM4ZW9NcDN3?=
 =?utf-8?B?WGZ3anN5dU5kSUlXcThpMWk3RXVlRFF1N3V0VUlTUHpFL1BlbEo5ZDc5K0F0?=
 =?utf-8?Q?GICsFwOuxX6GrjeWu0E780tYs8pk7KfJ2x7No=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWhYVWxUS2tVeEhGUS8zV2d5c1FwNEh0SytZL2xSMjZMYnZlcWpWenhlTG4y?=
 =?utf-8?B?RVBKYmV3RFF2OHZ4ZGdsWHRVNWEyczdRWWFkbXpkSDcvUXpzaS9Mc0ZzV2hC?=
 =?utf-8?B?MHZhQ1B3TVN6ZE5FUnVhbjllYWViS3JKN2NpRkVFTU5qVVRBRVoyL1RvNWMr?=
 =?utf-8?B?SXNUZ0hLVTVnVFVFWEliUFFpVHhMRk1lMWFHTEJTSjhjenpOMDRkSWJwands?=
 =?utf-8?B?TFBuWVBWbTFyVFdIOXJ4VW16QTZnbFoxa2ZyM1B3TGNVZElrNTJ6bG14bS9T?=
 =?utf-8?B?VitXTmpyNXFHMlhZRjZXK1pOcmVTVkV5VGI5Nm0xa2lRMkJhK2xlSlhHdU1K?=
 =?utf-8?B?NmREQW9XVkViZ1ZNUGoxV2VHMmt2bm96cnVLVkVjOEpiYnp0OXZxdEdKc3hQ?=
 =?utf-8?B?MmF1bW5EZGU3MXovYXg5dUV4L1B3VzBIMkh3K1d1elBzOUFsY2thZklGbEZs?=
 =?utf-8?B?ZWhGZjhyeGNUbVd3MGxRV0wvSUMvK1F4aGh4dGhHL3l3MGE0bFRmKzJvVUVQ?=
 =?utf-8?B?Q1VBQ3poeG80VSsxcXE5aEFSbGJWQTBhYXhvdlY1anIrYWd0VDNEdTE5ZkJY?=
 =?utf-8?B?YWVGSlA2emd3RFFVWEtaNUQ5SE00M0lZK0o4c1RyazhMYUcvcUxWeXJGVURR?=
 =?utf-8?B?Z24rZ3dUSjB2MlpkRk11d1ZVVFdFYS9FdU5XR0tFQVpNdWUzc1NCNEVUNjM3?=
 =?utf-8?B?MUQ4eElQdHdkTzZMWEYxcmpuUlFQOFFmY2M3MjhZR1g5bWd5Rkp0dUtLWS9r?=
 =?utf-8?B?MStKRE9id1FObmZxQnJSTXZ0UTRLRjRLQ2kxT0thY0VDS1N2L0h3Y20zSUZ1?=
 =?utf-8?B?c1QxVDhnT2ZEM1pCUzMwb0RvQ3RVeisrTWc2UHgxYnBCVEw0bnozN3MxcExk?=
 =?utf-8?B?bDNpQUJqcEJOajEySWxQK016TEx3cEZmbXNkdmxkMisvV2k3UUxEcTZKVnhU?=
 =?utf-8?B?V1E4ZXNnbDh5ei9tV01tNml4bUFMQmR2NndrSFdGenBKVTFSMGs4TG9ZYlIw?=
 =?utf-8?B?TzZ0amZHMnViZHE4VjEwL3JJakVZMkNNUTVBZEptS2tTNFpiZitJRE5YSmlW?=
 =?utf-8?B?Y3U5dzltcnJHZlE3bEZXNEExTjBvMGRGREMxS2hyU1NFNFlBK0l2cTBiNlor?=
 =?utf-8?B?ZFdKZXJEaFNYQmc5UzYrSWdGSlpWR3lhWFpiNUR0TlF4Z0xNbTdaRlkvTXNm?=
 =?utf-8?B?cWVHZTRPSFZZaTJLUWluZUZOUzVWTnZhaGVtMzlpNFVrc3l6VVVFR3U0aEls?=
 =?utf-8?B?VGhzZng0YzVyY0pUcnlIK0ZSYnA0TEJOMWkvdUNBRFlDbGZYVm1UTVZSaXZG?=
 =?utf-8?B?NVcza0tJcG1SL2p2cnRNcGg0aGcvaVM3eTBqaDhURW84TDRYK29VTHJvb0Q4?=
 =?utf-8?B?c2NqL0FCdzdjK3JLaXc1UmlRUmFTL0dxdjhpQ0FFcElWRVZNOXhwSDl0aGxt?=
 =?utf-8?B?OUFHQ1lmd3J4M0J3YVZrd3JjVUJLYTVxcUlnTndnOFA3ditWN1puaU9vVFJx?=
 =?utf-8?B?dmZiSTF1REg4NzhGTURxQnNPa3FYNjNZZi9ncUtVVEFoeHo5MDJsRDl5dGVX?=
 =?utf-8?B?a2VnRTdWa21sK0VKbUl6eDh2UWsxQzNVNW9oQ09wWTIybGFua1J1U2F4STBv?=
 =?utf-8?B?UllvMmVDdkdubSswZVBCNHpOL3NKV0hzdzV2T3d5d1ZGTVFBRGc4RitlbVZt?=
 =?utf-8?B?OUFDVXdheGpYZnBxbWVGRmg2dnB3Y2JOWE5QRjNiZ3hLcGxxUU1qOHNqcGNv?=
 =?utf-8?B?NHdwakJEdU9oem82MWs0WVFGa3R1c1B1OHk4djQzeU9JbVdaQmxRZGFIeXZ4?=
 =?utf-8?B?aTUwSVFDYUpOUy9UbUQwNXVUOFk0ai9iVUdXM0kvZzdrejdINmZPUitJb2Qv?=
 =?utf-8?B?clZJQUlTUEZEdG92c0MrRVJ4ZGVxRkh4cFp6K002NExrcjlSaVJlQ1RGRlZJ?=
 =?utf-8?B?Rzh0amxUVHBqOU8zcHczZXVtSEhORG44QkZQZ0lKMzFQcW5YdWtKRzBqNXJ4?=
 =?utf-8?B?WXpuRkZ1WnRPeFVreEtoT3VkQkgrTUtFV3VWSG9RcGNBcVpSbWNDdTk2R1dT?=
 =?utf-8?B?S0paTHlPTmx2MmZSdnh1UE1DZjBic0NraERadEdHZGhEWGI1VjFEcjlVeGpI?=
 =?utf-8?Q?PIuruoVLc1roR4QtoIsxQYvQP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723a506e-33b1-4657-7088-08dc6bd31462
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:42:30.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bH+ysRg43OdovznWPi6heHw8VDBg4jddvD7zAfNGYr6BsPzVJ9DBPwNRClDzytYrIjXWOPeZJvMiEftXFEZcpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Peng Fan <peng.fan@nxp.com>

The initialization order of SCU clocks affects the sequence of SCU clock
resume. If there are no other effects, the earlier the initialization,
the earlier the resume. During SCU clock resume, the clock rate is
restored. As SCFW guidelines, configure the parent clock rate before
configuring the child rate.

Fixes: 91e916771de0 ("clk: imx: scu: remove legacy scu clock binding support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index fe6509be6ce9..47f4ceab1179 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -222,11 +222,11 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	imx_clk_scu("usb3_lpm_div", IMX_SC_R_USB_2, IMX_SC_PM_CLK_MISC);
 
 	/* Display controller SS */
-	imx_clk_scu2("dc0_disp0_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC0);
-	imx_clk_scu2("dc0_disp1_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc0_pll0_clk", IMX_SC_R_DC_0_PLL_0, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc0_pll1_clk", IMX_SC_R_DC_0_PLL_1, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc0_bypass0_clk", IMX_SC_R_DC_0_VIDEO0, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("dc0_disp0_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC0);
+	imx_clk_scu2("dc0_disp1_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc0_bypass1_clk", IMX_SC_R_DC_0_VIDEO1, IMX_SC_PM_CLK_BYPASS);
 
 	imx_clk_scu2("dc1_disp0_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC0);

-- 
2.37.1


