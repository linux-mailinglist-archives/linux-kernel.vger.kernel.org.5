Return-Path: <linux-kernel+bounces-168469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880DF8BB8EC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9CF283D42
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F561171D;
	Sat,  4 May 2024 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GjQDZ3wg"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505161F934;
	Sat,  4 May 2024 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783322; cv=fail; b=jGVL622PSzo8RX5MSxkn1VjRZucs9+MqjcVTNiSjDnC+iIkDPU/u/Lo3eA7MnA2hYctW+VeaxroNfK6XSdxihHsanaro2RR0Nv9AV8XU26YYw2/4Mr86/0m1OLu3qUuEtftjCxsj1177BslS3DY5gkWvIWmN4Fpmb/f88kX6HuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783322; c=relaxed/simple;
	bh=tTnmH/6Qnb9N9OjP7YpZL6Z0qYEvJ4SWgZIDAnZMSPo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EnGqdY8XxJS5UJ1pyWkxyn5JlE7mKIyVGrQn9EgU7bp2HuDH+mwyzMaZrR/uj+YCPJRxoDdx917a0525KeVCYVNvDgA/0YQqV/0L6Lr/22kT7maIdNKMAS8jxlkE+7e0c7fLsA4t6yhvaTgXeM6sHNQrh5Qe9y8zOwtuNXhbnSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GjQDZ3wg; arc=fail smtp.client-ip=40.107.105.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeHzWAetFo6fIJaIVW2PjhPSLOZnHlTavll1nsME4XwPKMHXKN5nO9jF5UZ4CVmGJeQloz7DoRCCAwkiBkNhMeQ/c5hr0/rLzClafN5G0DtY/5zMMjfoY107tCQhguBYnkmoaMUm3i2zSHxGgQSOzOM5bb/cipgE4mjRIvj7H6lv4rHJ8sZv7SGSdTPgfhbUrfpcp+P0JJ3YtuIaMZeliT9mff881QtaaILBqXDQ2txOD2ySB1jNI6vJq2wU5NMhgKOUDR5q7yb4l05vyI5dlhK7EhIc65aFTj3QMkRZ5OjMag5Gg2j0j59WVIkeJvFTQNFqKnUSMfCzCifl7llGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shqQpCU+zit6vu8mozb5Ood+1gNMCo0go1qiqqcoK28=;
 b=X4sFRWQiRvadVZJeXmfzu4LYgBlmDjwVbp8UG+3fWx743GYIxHnXNhU9ZTXZix0po2fAW7g9VGID7j/lWp1nXGG+ycKwvCvEGMjVhuELM6imONDdWOL0CAQ+wmkXU2VpJzlgchLuzG8SknJsTZYPQuKcSVI6EV7lUYk+n1ob31evCDoXjRfkqYjh1LHAscdvUui2UvHl/3ItnjlSocvO+BBmEguFUgFkrJnuNJYu67zUFU7K1CMYyw07hROkQIHMb37MO0beLnYHpgEVT5J5DBAYvBTyLzhTZavwrywgyr/k0MYEGQLxdoc0y38KqJSZlSsWX+ffEgD4Ql4N8NJHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shqQpCU+zit6vu8mozb5Ood+1gNMCo0go1qiqqcoK28=;
 b=GjQDZ3wgBSw1/mBRJxim0K7dZ3O7iYUwgICLle70K3OOONYVMlmtoT0RNmdELfTOoDOZHseCWZrKV5m1m8CPBGphNkseg/BJZq1bnrc8zlTAwBKL18pb6nT29FVGlUpkB2+g29NDVLZ+x1sCCJy2jFUJkXHP7C1OTkRcvifwMYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:41:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:41:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:49:03 +0800
Subject: [PATCH 10/18] clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux
 for i.MX7D
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-10-f7915489d58d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=2512;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=tawkmb4o3zsB4Mw7AonWFpkCgwbnD1LyifvXX0BKqZk=;
 b=KoSIBH1CAzTBT8etU+iZ4h2zs6IYqvUz8RLZLmTWh6jjhWfqE9AJZn0x4lnw82iMIEOG23tvO
 ohqaAuyFEcyBl5rNeYHSz899K4esYINWgYhPd9uUSSuN0sjYJT9uO4N
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
X-MS-Office365-Filtering-Correlation-Id: 624db2e0-ca56-4e35-19da-08dc6bd300d4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDdwVUFWQ3hGNXp4bW5uQU5jVFB0c21LWmJqSWtaOUpETTlPaWJqL1N4NVF5?=
 =?utf-8?B?a1gwVTE4SHUxVlhmOGc4WDBXMFE4c1BCNksxZEg0anpySUFXalZtMWtJcnhm?=
 =?utf-8?B?OTdCVGtTazVCbWVNbkxsS29haWE1VmdBRXNHZkg2OWhNaDVTVXQxTmhpSWVZ?=
 =?utf-8?B?VFBDQVIvbXFMMHNOeFJZc2FSbktGSGhndWpxdEFSRDVrOEpCOVA5anlaU09y?=
 =?utf-8?B?WTFTOTRRUytoVjhuaFhPNUcyemRVZ2ptd3JaOC9EdkRkVEhEOGZlUWtYeFh4?=
 =?utf-8?B?QWp4ZVlaT0t2Q0EwRmpEZU9TN3RYZ1Z4ZEFWclQxcitDWlhiMVRLQkZoRENu?=
 =?utf-8?B?d0NMMjU5ekhabnhBeSszNWZqOTRtWHlvR2ZRVTBjMGFZK2tqRXNZa3ovSXhi?=
 =?utf-8?B?bkcyYlBXcVZXNmR1TkNsMjczMWNKNThRZGxvejN5dzF6cjhZbUNqU0R6cjUx?=
 =?utf-8?B?UmlnMStVK2w5Snl0dENtbUc1M1psR0RNNUNIUWpIM0hwZ0doaGdPS0JCSjF3?=
 =?utf-8?B?ZFdYejgvQkE4ckNFNjlUaDNIT0o2RXVaUjc5WUJOQTZxbm55SUVWN2MrN2Fh?=
 =?utf-8?B?Y2h2ZitwQUtxR2F4R293QXA4RHVvem1PN3JRWU5mQ1ZKazA2Z0E4NEpKdHRW?=
 =?utf-8?B?VGFZTFd0Q1c5WFJqWUgyWVZMRGVXbDU5eFYwMVlDZzZ1U2FCLzZTN2tnZGd5?=
 =?utf-8?B?eWNSWWF5ZHMwUkhTdG16azZVdHJMTWkyQjlLU0x1WUpTU3AvT2lyQVRIN0FO?=
 =?utf-8?B?Rm5UUVZDQ2pnV1VaOVUzOEpoV3BUNjMzUjI3ODZ6aHNTU29PRGJKWHdMNmxp?=
 =?utf-8?B?UW9pbkc4aVowODVTMklKUWNKczVKWXdXSjBKd0pYdFNKWDk1ZU9TbU1VTmhC?=
 =?utf-8?B?Z29OdXRQNGZTSTZialJ3Q0dOUFYxVXFKSUZiN09ZTnpRZUFocDY0YUtjR1Zr?=
 =?utf-8?B?WVo0bXZoUlJtYnNMV0Z3QnU0T0I0OVo2OVBMTTRGSUEwQktyTHJ0eDRXWHl5?=
 =?utf-8?B?Vm84MGtNdDZSUFpWZi9UUWIyMUNOdjljME8xZXhVL2xQTUY4SCtXSWJpSk1J?=
 =?utf-8?B?TFl0dGhwS0N2LzY0V2JCeGFubXF0QWEvRURQdFdkRzBKT0NEL01rVHcyODRW?=
 =?utf-8?B?d2wvTmY0Z0pneC9kN1RtOVd3aXFKdVg4VTBBaDhINUhEeEE5TDUrREJ5VzlO?=
 =?utf-8?B?aHFPNXkyay9tcTErdWNncHZ5bzgzQzVGQ3U0Nm0vWE9MTkxuYktmbWlTN2Zr?=
 =?utf-8?B?RWszckpranErSEN2TzRTLzdSQjByK1FlRnBsdnJrcHdmckVhREpmNmR2Y0kz?=
 =?utf-8?B?dFFuWmxVTDBTbDdKZzhiSkpCTlNLU1lYSmx2NzA0QnU2cU9GWFlLV0hQOVcx?=
 =?utf-8?B?RXdmK0FlbEFQSVJkdDFvQ3RnN1drWFFxUFB6aG9GbllzdncvSEpFcEhjcDRm?=
 =?utf-8?B?OW16YlRTbjNtb0dkVlZ6c3M2QjVMK2ZJQ0NBYXd5WG9tcE5zZHVXNjZWRnJz?=
 =?utf-8?B?bnFkTUtlWWNRR2pnd0d2UVBIKzRHbXF2QzZkZGZuWGc5UnlTNnBqTzBoMUg4?=
 =?utf-8?B?ZTNKeGpZaTN0SWpnQVRuQ21NUWxacDk4c1VESXRPZFdidXlGS3kvd0o0aWZV?=
 =?utf-8?B?ZnNoWFVtVjAvdm81WWY0dDZWQUVnamorVmJSSlVqbVFkbEJZdEs4bHZ4ajd6?=
 =?utf-8?B?Y3RWcDZibWJ4ZlF3b0o0cnZHc1VFSGx1ZjE5MzRmTTVMOXl2SzZXQkM1VndM?=
 =?utf-8?B?Tk1xTGFvRXpTTWgwbHg2VWtNMWRrTFkxNHhlMHAraWhVMEgwTVdrM1oySlhw?=
 =?utf-8?Q?gewqTVOtkh798sDey5lWfHPmnBWGMFi7RseF0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3p5VERGYm5xMzJRQmxqTnFFOTVvRVRPU1ZKZTRlWGxkdDU4OFlzNVlPekNp?=
 =?utf-8?B?dGdRcUxSSTNTcERNL3R3cFFDc3dweW9nYTlUN1JMd2pxTXgzNTM5b2d3dlRx?=
 =?utf-8?B?bWVyblB2R1NKZXZyenQ1MjA5SkhKQnI4VVlFZ09FTkxJclVVU3oraCtHNGw5?=
 =?utf-8?B?MkdNSXViWE1SRW1GelpncUdiSTFsYm5JYnhnemRaOTkzTXhkM2F4UkFQQzlO?=
 =?utf-8?B?bDdtZHRPVmxpSGs2NkRaWVUrbmgzamhsWjdBNU5jeWVXQVlpSm9ZTHFJMGxJ?=
 =?utf-8?B?NC9RRmhzREkvODY1VEd0eHBXeXpZZjdxYko4MGdDbWo3a1NZZEdHUEFKSnZC?=
 =?utf-8?B?dkdSalBIaHdGeVFoY3lzQXp3WXNISUFobE9aVG9DNWhnNUtiV042U0I4N2hO?=
 =?utf-8?B?K21UMm5qbDJZb2NmSDIrcTg0OWxWK1F2YnE5N1pnMkVDVXM3NHRaRGszQjds?=
 =?utf-8?B?Z05Bb3JCRzh3KzZQNGR2SGV6OS84Rmo2VjdBQ1plcVUxQnBoMS94QXZUSXZO?=
 =?utf-8?B?RXhFQUprdWt3TDEwOUVGU1RFRGVhM2xNcEUwS2p1V3VQTElhRGpZNDVMTjRU?=
 =?utf-8?B?b0xSaG85UEo1THpkOVNlOFRFRWdPdFVpVnhQSWdsenNkVm1Pc2toWXVNb1Fn?=
 =?utf-8?B?RGtjemhVNmcyejZEeEhTbVY0OTFjMEk4QUdNTjVWMGVMNkFvdllSN0RoOHNL?=
 =?utf-8?B?b3JVTnFqQjUrMHRxYVg3L2dYQVRJelI2SE5RYTBTb2Z0NTU3WHZmZlFjd2VW?=
 =?utf-8?B?VHp3OVh0RkNscWsxaWpiYjlhclF6U0pPU0tyZ3NwdGN3emtFZ2hNKzM0STJa?=
 =?utf-8?B?WXNtYWFjNWV1TFlCTnh1SVNBZlpOT215TWRCU0oyeWI1UWg5Ykw5MWtpVUUy?=
 =?utf-8?B?Q3U4d3pDRGVwTythVXU5MUNKQk50Zy9KODM0SGZkSmM5b0RXQkhxVUhVNjFr?=
 =?utf-8?B?WjhaaU1jd09FN20wT1BxeUp6eDk5bzRXK3BWeWM0TlM4aUFrWDAwQkY0UTJF?=
 =?utf-8?B?bU5ac2xSbCsxZFpNMml6NGNhZXgzVXFGenU0RDlTd295bGpwK3F1b29lTDJa?=
 =?utf-8?B?MGlQVnhaa2NYU2s4VXBBckhBWHQ0ODBmZC9MY3E4WU5kbkVYaTQwMXBlSTZo?=
 =?utf-8?B?SlZvTkFoR3E1MEY1RWMwTGkvbUluRUdPV2w3ZWJ2T1NueGp4S1RIKy8rT1Uw?=
 =?utf-8?B?WEIwV3JIUC9SM0ZmQXY5UTE1VW9FbC9LR3dVRWdSaHpMOUdxQnp5TnFzc1Q5?=
 =?utf-8?B?aFZIQlEzZmRpRU5PTWpZR0NNZ0VhdTlkR2htdThmcTFKQ2JRTE01b2xXRDRN?=
 =?utf-8?B?U3lMVnd5VW1GK01Uc09PcHNhVnFRZXZQaTFGZjhqLzJyb0FwdmJuN2JJejk4?=
 =?utf-8?B?VkQ2cmZxZjA1YmxDT1MrNnRmeHF2eStWcHJrVnJ6dDlITWR3cVExanRIWWtl?=
 =?utf-8?B?YWxDOG5rMHBrbGhyNEFTUTNQLzJIcWdzcEhrbUVQMDdaUDVRQ3lvM0UvbUcw?=
 =?utf-8?B?TURJSXRFd1psbGdmdGNhZGxUODZjdm1lT1VTTU0wbm5hWHJqNVEvWFFaaXc4?=
 =?utf-8?B?U2FWdlJUYUdEMjVES3crMzMrcUR6S0NkMUNsMHh6Y2ZsVTlMWWVtUE1CSC81?=
 =?utf-8?B?T0UxdVVMTFBTV1FvYVBxRHJEQTlxYnZ5QkN2aHdzUzJZQXgzcG5EQXhyczcy?=
 =?utf-8?B?VTA5Y2EwS2UxWEhCeVFBSkpWaUo1QVJpS2NqZW9mcjVxZXo0MjRJK1hVN1JP?=
 =?utf-8?B?ek5aaWlpbGovUHJzQVNCK1BlUFhKTnBCNDB3YXkwY21XRm82VXB0akE0OXVK?=
 =?utf-8?B?dDJ6akZEY1pEallibFBodDd0OWRLWXdLY0Y2d3lGdVpoNzZreXdzSytqQXJT?=
 =?utf-8?B?bnl0dXVsNi9pTUZxWHVIVWFhakNjRnlNMjM2L1BpV0EvaXdJNnZRZE5GUkRW?=
 =?utf-8?B?djZ0Vm0xQlBJd3JNTDNNRy9vQi9ERGc5TkRRMTdsQ05rUGRtM3MzSVpQT2pD?=
 =?utf-8?B?UU5XcldnU3MyRVo1K0ZTSnlzeDV2dnkrMVJ3REZDUkRXQ3dJcmpGcVRrRVVE?=
 =?utf-8?B?d2plRHNSbU9nUm41SFBZMGlZcnF6eERFV2pFb3FxWUIxbkZqUUZYUjF2Z1NY?=
 =?utf-8?Q?h/XvxrZ93BOmQpS5XYtyiljFB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624db2e0-ca56-4e35-19da-08dc6bd300d4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:41:57.6652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLRcxt4COoJauroaUm1hFq6td6EVmB2yRiy3SqVXQs9tqBc2cnf7GUkybszjG3FxKMlLzA0Y1iBEYhZa0s2YEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Peng Fan <peng.fan@nxp.com>

For i.MX7D DRAM related mux clock, the clock source change should ONLY
be done done in low level asm code without accessing DRAM, and then
calling clk API to sync the HW clock status with clk tree, it should never
touch real clock source switch via clk API, so CLK_SET_PARENT_GATE flag
should NOT be added, otherwise, DRAM's clock parent will be disabled when
DRAM is active, and system will hang.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 2b77d1fc7bb9..1e1296e74835 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -498,9 +498,9 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	hws[IMX7D_ENET_AXI_ROOT_SRC] = imx_clk_hw_mux2_flags("enet_axi_src", base + 0x8900, 24, 3, enet_axi_sel, ARRAY_SIZE(enet_axi_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_NAND_USDHC_BUS_ROOT_SRC] = imx_clk_hw_mux2_flags("nand_usdhc_src", base + 0x8980, 24, 3, nand_usdhc_bus_sel, ARRAY_SIZE(nand_usdhc_bus_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_DRAM_PHYM_ROOT_SRC] = imx_clk_hw_mux2_flags("dram_phym_src", base + 0x9800, 24, 1, dram_phym_sel, ARRAY_SIZE(dram_phym_sel), CLK_SET_PARENT_GATE);
-	hws[IMX7D_DRAM_ROOT_SRC] = imx_clk_hw_mux2_flags("dram_src", base + 0x9880, 24, 1, dram_sel, ARRAY_SIZE(dram_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_DRAM_ROOT_SRC] = imx_clk_hw_mux2("dram_src", base + 0x9880, 24, 1, dram_sel, ARRAY_SIZE(dram_sel));
 	hws[IMX7D_DRAM_PHYM_ALT_ROOT_SRC] = imx_clk_hw_mux2_flags("dram_phym_alt_src", base + 0xa000, 24, 3, dram_phym_alt_sel, ARRAY_SIZE(dram_phym_alt_sel), CLK_SET_PARENT_GATE);
-	hws[IMX7D_DRAM_ALT_ROOT_SRC]  = imx_clk_hw_mux2_flags("dram_alt_src", base + 0xa080, 24, 3, dram_alt_sel, ARRAY_SIZE(dram_alt_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_DRAM_ALT_ROOT_SRC]  = imx_clk_hw_mux2("dram_alt_src", base + 0xa080, 24, 3, dram_alt_sel, ARRAY_SIZE(dram_alt_sel));
 	hws[IMX7D_USB_HSIC_ROOT_SRC] = imx_clk_hw_mux2_flags("usb_hsic_src", base + 0xa100, 24, 3, usb_hsic_sel, ARRAY_SIZE(usb_hsic_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_PCIE_CTRL_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_ctrl_src", base + 0xa180, 24, 3, pcie_ctrl_sel, ARRAY_SIZE(pcie_ctrl_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_PCIE_PHY_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_phy_src", base + 0xa200, 24, 3, pcie_phy_sel, ARRAY_SIZE(pcie_phy_sel), CLK_SET_PARENT_GATE);

-- 
2.37.1


