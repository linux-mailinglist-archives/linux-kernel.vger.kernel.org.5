Return-Path: <linux-kernel+bounces-165273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B238A8B8A61
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B363FB2197D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5631EA84;
	Wed,  1 May 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="I4jnerqd"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763327C082;
	Wed,  1 May 2024 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567789; cv=fail; b=j12Wz8GUS2p9JLSgpng854lwNdSa5u9FwhDg/llPgjFm9vqzfIWksuL4bHX/kMM9jgD1syLON240sg4EC/LtKQt1U/ZNLpEG5bn2xb3qBwrNaN6J1RrTjh2pEjJUljFY283KizvtL8F2w8yFW9oRZd4i16i8mQBSKpymyXE92Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567789; c=relaxed/simple;
	bh=ZoFezlHrLhNH6VNyCapJyxPF8IHiuhLM60d0IZaK3P0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LHePeHmxKTGlYRMFE4WSzGzwkiAwm4MDOktUrY4+kX8FBOW2HKI51MMdTvazn+IBXlrr+TjkGtRdBpm3aq3oX3w0k1R89w3b7VqL1VNewwdWTcVNbx8/AVMLQx74zIG90xoTt1mWO/NKp9rBMS+dE15J7gCRFeLY/inO78fXfOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=I4jnerqd; arc=fail smtp.client-ip=40.107.8.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve29h5h8BcMVkb+1Je5Ycjsz2hAQoJQAfcpoCPU02rQDiyi6eMWbgVqmiWH4CRT1p62sO9E19JP4f25oOEsmIHGpAz4ku6WoIq0YUio1YmVW/b5ARmtMuVhdRHK02wVhdfAWpZAK0nJ5DQxIdNYzvXifSpe6KGckHIVHXoB3YNhXRGwHyjAgiHT5gK6lKdqVozw+aJyCK9KvXfjvM8hn4ppfeZyQf2IguSj9M3b7hQZIMw1a8Z67jLJkG49b2FU74tFuugnZa/QV2Ig7BGqdnZf8LQxATKJCYNgEMK4pJBxGfVeyapd8HpLIISzOPdCv+F6QbyvUEysCq8lkLCbeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9YUvofIdVB4JzzWI0NRmFDL50mIRPG79od9oDhnF78=;
 b=PPhfLsW7SuP9/IvAj5c89Hoi0/EXWbKMLgY7B1VIvBQJrSFz+yJ2h3I8OCIEpR9P5B3upMAK7wRGfRw0cFThZvo1dxhwm1ikWlIID7Vu4U6R8qCOHKvZLejQf90xt/PX8uVOPJuK8RcUWMJ5TV6NquI7WSVxAp7yESb3PFHSv5JAH+tBc5DBM7NdNxdFWdE+TkrKQUX4mln/1/8+o5FisgMwQP2BXPm5qEyX0207BsDr9GVsWH60V3unBlYZQtailGffEbkIA4KD/mko7Q+RiBlTDJf3y53dCRWEEgsPRQV0MqmXePiV2RxD/URSZQmE+APkfHC2FSEEek2Bc7y1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9YUvofIdVB4JzzWI0NRmFDL50mIRPG79od9oDhnF78=;
 b=I4jnerqdQYo0PtLUHhRdWVFBJn9zKyabdPh2sFHr9ErIfFjM4EJAx/AfwpKuCgOWapMfbTA7kiB2d7vu2v23jbN9ACMwe4V1EEew196pVQLukDvdMKqca8QzxuKP2g8hk3SCMyOwVFL5QxYNdnE1jeZcPCkC20Rc0O7isVHd8n0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.38; Wed, 1 May
 2024 12:49:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:49:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:03 +0800
Subject: [PATCH 05/21] pinctrl: starfive: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-5-797ceca46e5c@nxp.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
In-Reply-To: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Dvorkin Dmitry <dvorkin@tibbo.com>, 
 Wells Lu <wellslutw@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Emil Renner Berthing <kernel@esmil.dk>, 
 Jianlong Huang <jianlong.huang@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Viresh Kumar <vireshk@kernel.org>, 
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, Damien Le Moal <dlemoal@kernel.org>, 
 Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 imx@lists.linux.dev, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=6656;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=q6W94Hjdjjw7xg0ybaSa/7rYn9TOuVxzheASMuMVWPs=;
 b=oeYu4Ud4YU5lBztSso/rf0zqe1lgwaHPiuNrD5LA72yGh5Bng1xSawl8uORrM5WFZwafQV+S2
 Y5SNiNdKNvaCP9Ni25D/AlYfbPj+Btc+9YyZx4MFETYbweNVA8teD7Y
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBAPR04MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: a0db37d7-54bf-423e-011b-08dc69dd2c5c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1VDZW5sYlpQUGRDc3VTMFRDNFhzZWNLZExTcnE4VUlDS0ZNWFJPS09vRlha?=
 =?utf-8?B?bVFOT0h5bkxmWEF3WTRwK01wR1pGVkZvcjJ5Q29zNHpjT2hxZzgrUE1lb1c2?=
 =?utf-8?B?WDRnenQrWVIyR1g1c0JFUjBiRkFWM3FOaVRLVzAvOWlZREtIRFVJakorTDFJ?=
 =?utf-8?B?Ritta0RGZnBkQ1BsdkJ6TEFTRXlCR2hlZEJxS1BMWFJ0VGo1R0Y3MGs1b0RP?=
 =?utf-8?B?bHBsRldoL1VkT1V4VGFOOVZqbCtwMnZIRUZ2KzJqZGlKV3Zad3VIQlFONEpR?=
 =?utf-8?B?Um4rSHFUZFZCVUF0V2wxbFluUVFDZFVUL0FVVW5ZL25UL1JHZ1hueHdNRXBx?=
 =?utf-8?B?Q1VleEZYTVdKaHVKSE1XWStEa1huZXV6NlBxanBPK295NzFUZEZJVGhVZlNh?=
 =?utf-8?B?d0dmbFVMb1R3VzAyNlduNFd2VlkrYmpaTWhXYzc1bW92ZzZlT1kwdzBYNUla?=
 =?utf-8?B?Y2N3MkswYkVqeFZMVHY3SnlvQUpFeGpmYlNwbUVEUVN5UVJpYlBHWndUQjcx?=
 =?utf-8?B?MGt4bEtUNlJvRjdqQWRSZURIcXl1Q1N5aE5ITHpHZk4xT1hiSWZFSmlkL3VQ?=
 =?utf-8?B?cTF6VDlIUi9IdXk2cFo0c1o2NmxCUGtDc0FqdnRGbjgwMzlhZkpFZXZkNVJz?=
 =?utf-8?B?ZjNoWmVGeVNHU0lmcmhHY3gvdk9JdG5WQkozUGhxREEzYVIwNm8xUGF3QTVl?=
 =?utf-8?B?SXcxTWtqakwxMWtYNGZBamhuK1VvbTlxSTlvZXY2R0VtNCtOVHVacFJlUkhU?=
 =?utf-8?B?dVpKMUF1d0VWNjJjTDczdld1dlNRTzlqd1ZUc0NtbDdDeHQrS1VzTEJIMGFO?=
 =?utf-8?B?UzdKK0NPV0tVTDUxY0t0ejUzT1hxTktTbkFkRzRrdmdrMEp4ZUpIVUtZYkN3?=
 =?utf-8?B?VDNMQ1NCaUFLc0tPYzJUT1NNRXU3OWhKWndtdWNYSzgwRlFKQTBWanpSVVZu?=
 =?utf-8?B?SDVtOGhIdS9jaEVsVW1PYUxhTzlkeE16TTlXK2hsN001SDJRUU9FdkZ1SlZX?=
 =?utf-8?B?dFRjM3IwV0JRbUF5SENDbnkwZTAxQk1nM2pUa0JwanRMS1VWUzlERDI4YSth?=
 =?utf-8?B?OEV6QnR0OTk2c3JlQlAwanFmYm1BcU53cTlKSXptNERuSGZkaWk4ZlEwRzRs?=
 =?utf-8?B?WVk5a1MydWRGdlEraXdKK3lqdGoxMEhiWk1QSzA4VHBhTDd5UEd5TTRVa3kw?=
 =?utf-8?B?aFJyNStzNjBkVXdjVFZtZVdGVmtWSE1uQ1E5U2YrUlc3bi91SmQxbStyUXdP?=
 =?utf-8?B?RHdYeFlzR1JYbGZIVGthaTNGYys3OFF0VzlxTDhSdlJMZjhGN1IrN1I5WGU5?=
 =?utf-8?B?cUZxWHZBWmlTZHdxTlVrb0xCbElMY2FzcTJCc2xnOGZXTGNEcG9YbmwvL0g4?=
 =?utf-8?B?c1ljdEtqQlM4eTFQUGdmb2lTWjc3UGlyZW44UkpHUXRTMVgxc2RxeWNhc0Zu?=
 =?utf-8?B?em5RMmk3d3VyMkdxdU8wa2I0UTVEU2FIdTJjZWVPRVo3Y05TWjFacVdCQWVE?=
 =?utf-8?B?RTZyZi80cU1SUnY2RWE5TTlkVWl2Y1k0MnZjRmREd3dvak1weTFEMU5ybkpR?=
 =?utf-8?B?b2ZVeXpRWFRMakE1bkZ4Ylg4YXQ4OXo1R3l6bkVlOG1EWnFDek91ZUh1RDZR?=
 =?utf-8?B?UEV3ZUpVVXRmT3ROVklEQnhJUC9tTTRUd2tzU1dubE91WVd5NVlJK0tyMTBZ?=
 =?utf-8?B?T2luQlh3WWhLWnFkRlFYVVdHNnhGQTdqNGJmMzdBS2NvUEErMFh0RjZqR3JC?=
 =?utf-8?B?bGdRcmpwcGRMamJHUUZtWU9kak50djdOYUpOWUdHYWh0ZjNZUFB2ZGtDaERW?=
 =?utf-8?Q?bwWprVTIWVciAvdMeLsq30xVPquA+1HH1LP6o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anR6Vkw2WklJcEpLTVhadzhmOEZaS2ZseUJUd08vZWFPcXRGbTllb3ZxOGV4?=
 =?utf-8?B?SUovUWczU2dYb1VHMGJqV0dhenVGc1cvT3hBYWFwQmRYbXRrNzFjcDNnZUJV?=
 =?utf-8?B?NVJFQk01bncwS1lpRmd1Vzg3ZG5CVW9VV2hJQVl2bDd3blh6TzQxU2FRb2Ny?=
 =?utf-8?B?V0VjeUY0MnVhaHBMbjJGdUNITXY1clYra3NHV090Tk9PQ1hyNjhnanNGTSsw?=
 =?utf-8?B?YndESTE1elEzc0ZtVDUwZ2Q4NVVaMlZ0WTRkOFJTMXczVksxdVUxTVVtMldo?=
 =?utf-8?B?SFhuRnBaNWk3OEgrRnR6anBEZDlRZERsd1VVME9ZRm92bTRYbDRiYStPaDNN?=
 =?utf-8?B?UThSWTlLaUUzTGxndUo4ampvQ21KNFdYM1FOeWJQTDduOWNQc3Z1N3dORnRW?=
 =?utf-8?B?c2diVWdFVTNzcUdHcDIwZWd3TXl0cVNnL3NYZlFYcFVYTUVmNm5JMDRGYVpp?=
 =?utf-8?B?b1R4clZkdkVpNC8wZlNkSjZVeXlwalV3cWF1UDMvRmJHRklLZVAyaCs4aWN1?=
 =?utf-8?B?VTRLUHAxeVI1UDVtRGFqQUY2NVlTakRlbXNjamZMOVZmN1htZzBJQ3dNd3RQ?=
 =?utf-8?B?L2NzOGM5MUV6dDk2VWJkMUZZdGdKYmZISVdKbU5JZTBDUDdPbk1ZSzZDTWw2?=
 =?utf-8?B?ejBVV1hmMXlwZGpYME8wUjExeVJrNVpRcnVyeHlmZ1QwNXorOW1hZnFnS3Zy?=
 =?utf-8?B?TERoVytUQ1k5bkEyT21SSEdPSkdMeWZyM09MVnFJT2Z0WThtcllGMG1SSDFU?=
 =?utf-8?B?QUl5QU1NSU8rb2hRenZhSktmY0JMdVB2c0V4WHNZekpjby95YlVOTzlNRWx6?=
 =?utf-8?B?Uy9Kc1hWK0dPNlY3WjFoczl4dWNZNFkrZ1EvVGZKekwrUDJtdm1qYmg1YXh1?=
 =?utf-8?B?WThtQ0NFeGw5bmxiOU5ueE9HT3lXYkdoZkxqVENFb016TlQ5dmcrZEVCMk1y?=
 =?utf-8?B?YnFYSmxFN3ZrWHpNWnFlVEdjUlp4YzJ5UXZQQ0hWY3Z4M3dVVVNQMU5pUnJ1?=
 =?utf-8?B?aC8zbGIwUFdEQzZBUXVIN2NGZklQa0hQQlphMDFXTVpuSFhXS3hwZ1I3TzBD?=
 =?utf-8?B?bENLV2paRkxMbzk0WWtYK3ZtVDRsSHcxOWR3MWRSNVpRdnJiVjVWQUt6NFpS?=
 =?utf-8?B?UmkyYmFCRDNsSnZya09YaFVWdzRheDBMVHovdHg5OTVCWnRrQ0ZRWVBiMUgx?=
 =?utf-8?B?dDVMaStPTVhNUTVqWGwrU29tUHBSV3gwUG1RcDduY0ZzSWlrNmEyT2pJYlhh?=
 =?utf-8?B?MjE4MXY5b3dXWjk2ZGdpS0JDVjRtdHlFY3RlN1FLQnUyVzR3NjVXYzA3aVV5?=
 =?utf-8?B?NW1Pbk0yZnl2bDdSR1dxZlpZcGkrL2xOa1VQSnBQWld5K0c0VHdZMUtFdXZN?=
 =?utf-8?B?ei9PcnJkcUJZSVdtTmVkU1pDNW9KZyszSHY1blRQMzM0QnptTEQzSEUzMEV1?=
 =?utf-8?B?c2tjejlQQUUxdDY2cHF5Rk5zOFZJVEdKM0tiMGpGZnRRVzdKRDZMdGZPUmp5?=
 =?utf-8?B?T3FoVkJhRS9KSzZ5WWFOQUIzWTI4czE1UE1IUVZzVDRzM2I1cDBNVzMvZitS?=
 =?utf-8?B?ck0xK0tHcm5zWnR3a2xaVFk3OU50Z1hmaEpXQmpIb0FxTGNFaHJKQk9uSDRU?=
 =?utf-8?B?MXdJbE9zbnlkTlhKSzFNTEJueHpCVDNza09iWVRwQVg3cG4xSVZRWHBWQkJX?=
 =?utf-8?B?b0k0c3ZpYlVuVWNmaXdEa2JScGt2Njh5azhwblBaZ3lacWpERFIyVVU1eE85?=
 =?utf-8?B?endZdEh2YUIyN0d0Y3gzT0duV1JMQWpZT1BZNXJUTnQyTU51dVluMStZWmJC?=
 =?utf-8?B?UHAwSnRuaDZWREJkY2FURnZWSEZiRnZ0eFdaeDlyZFNvTHFoRGU0UFRpTmRv?=
 =?utf-8?B?SFkwbjNkcmdEMU1tSUF6SE83aFl1RTM1TS9OM3oyVTM5SVVSQWVXemYrb096?=
 =?utf-8?B?SDJ3NThSNy9pcDhWQkpHUkFubDBJQlp5S092MkZzRm03SEt0RDdvaUFRd2dm?=
 =?utf-8?B?ZndMalVyUU5oZ0NKUFNVNnBFc0lkTzVHTXdGbzR6QWdaSVJIM3h4dEZIZ3ov?=
 =?utf-8?B?TUdDK3BCR2RQOGIrY3kzUG44dXFtaVI1VUtpVXFTUGFOUElsMXJmYkhPbHFW?=
 =?utf-8?Q?5bVHTcyqbxmmbCBdje/rEAAlR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0db37d7-54bf-423e-011b-08dc69dd2c5c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:49:43.3920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8VMXjN5tnTZbVk5RTJATfV4WVyud8UqeKUIyvYzYSsszFnA3M3VjRSQ8h35vE1kbq/I+796vLW9oWOt6tBpLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 27 +++++++++-------------
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 18 +++++++--------
 2 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
index 6df7a310c7ed..27f99183d994 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
@@ -480,7 +480,6 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 {
 	struct starfive_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
 	struct device *dev = sfp->gc.parent;
-	struct device_node *child;
 	struct pinctrl_map *map;
 	const char **pgnames;
 	const char *grpname;
@@ -492,20 +491,18 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	nmaps = 0;
 	ngroups = 0;
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		int npinmux = of_property_count_u32_elems(child, "pinmux");
 		int npins   = of_property_count_u32_elems(child, "pins");
 
 		if (npinmux > 0 && npins > 0) {
 			dev_err(dev, "invalid pinctrl group %pOFn.%pOFn: both pinmux and pins set\n",
 				np, child);
-			of_node_put(child);
 			return -EINVAL;
 		}
 		if (npinmux == 0 && npins == 0) {
 			dev_err(dev, "invalid pinctrl group %pOFn.%pOFn: neither pinmux nor pins set\n",
 				np, child);
-			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -527,14 +524,14 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 	nmaps = 0;
 	ngroups = 0;
 	mutex_lock(&sfp->mutex);
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		int npins;
 		int i;
 
 		grpname = devm_kasprintf(dev, GFP_KERNEL, "%pOFn.%pOFn", np, child);
 		if (!grpname) {
 			ret = -ENOMEM;
-			goto put_child;
+			goto free_map;
 		}
 
 		pgnames[ngroups++] = grpname;
@@ -543,18 +540,18 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 			pins = devm_kcalloc(dev, npins, sizeof(*pins), GFP_KERNEL);
 			if (!pins) {
 				ret = -ENOMEM;
-				goto put_child;
+				goto free_map;
 			}
 
 			pinmux = devm_kcalloc(dev, npins, sizeof(*pinmux), GFP_KERNEL);
 			if (!pinmux) {
 				ret = -ENOMEM;
-				goto put_child;
+				goto free_map;
 			}
 
 			ret = of_property_read_u32_array(child, "pinmux", pinmux, npins);
 			if (ret)
-				goto put_child;
+				goto free_map;
 
 			for (i = 0; i < npins; i++) {
 				unsigned int gpio = starfive_pinmux_to_gpio(pinmux[i]);
@@ -570,7 +567,7 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 			pins = devm_kcalloc(dev, npins, sizeof(*pins), GFP_KERNEL);
 			if (!pins) {
 				ret = -ENOMEM;
-				goto put_child;
+				goto free_map;
 			}
 
 			pinmux = NULL;
@@ -580,18 +577,18 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 				ret = of_property_read_u32_index(child, "pins", i, &v);
 				if (ret)
-					goto put_child;
+					goto free_map;
 				pins[i] = v;
 			}
 		} else {
 			ret = -EINVAL;
-			goto put_child;
+			goto free_map;
 		}
 
 		ret = pinctrl_generic_add_group(pctldev, grpname, pins, npins, pinmux);
 		if (ret < 0) {
 			dev_err(dev, "error adding group %s: %d\n", grpname, ret);
-			goto put_child;
+			goto free_map;
 		}
 
 		ret = pinconf_generic_parse_dt_config(child, pctldev,
@@ -600,7 +597,7 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 		if (ret) {
 			dev_err(dev, "error parsing pin config of group %s: %d\n",
 				grpname, ret);
-			goto put_child;
+			goto free_map;
 		}
 
 		/* don't create a map if there are no pinconf settings */
@@ -623,8 +620,6 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 	mutex_unlock(&sfp->mutex);
 	return 0;
 
-put_child:
-	of_node_put(child);
 free_map:
 	pinctrl_utils_free_map(pctldev, map, nmaps);
 	mutex_unlock(&sfp->mutex);
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index 9609eb1ecc3d..4ce080caa233 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -150,7 +150,7 @@ static int jh7110_dt_node_to_map(struct pinctrl_dev *pctldev,
 	nmaps = 0;
 	ngroups = 0;
 	mutex_lock(&sfp->mutex);
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		int npins = of_property_count_u32_elems(child, "pinmux");
 		int *pins;
 		u32 *pinmux;
@@ -161,13 +161,13 @@ static int jh7110_dt_node_to_map(struct pinctrl_dev *pctldev,
 				"invalid pinctrl group %pOFn.%pOFn: pinmux not set\n",
 				np, child);
 			ret = -EINVAL;
-			goto put_child;
+			goto free_map;
 		}
 
 		grpname = devm_kasprintf(dev, GFP_KERNEL, "%pOFn.%pOFn", np, child);
 		if (!grpname) {
 			ret = -ENOMEM;
-			goto put_child;
+			goto free_map;
 		}
 
 		pgnames[ngroups++] = grpname;
@@ -175,18 +175,18 @@ static int jh7110_dt_node_to_map(struct pinctrl_dev *pctldev,
 		pins = devm_kcalloc(dev, npins, sizeof(*pins), GFP_KERNEL);
 		if (!pins) {
 			ret = -ENOMEM;
-			goto put_child;
+			goto free_map;
 		}
 
 		pinmux = devm_kcalloc(dev, npins, sizeof(*pinmux), GFP_KERNEL);
 		if (!pinmux) {
 			ret = -ENOMEM;
-			goto put_child;
+			goto free_map;
 		}
 
 		ret = of_property_read_u32_array(child, "pinmux", pinmux, npins);
 		if (ret)
-			goto put_child;
+			goto free_map;
 
 		for (i = 0; i < npins; i++)
 			pins[i] = jh7110_pinmux_pin(pinmux[i]);
@@ -200,7 +200,7 @@ static int jh7110_dt_node_to_map(struct pinctrl_dev *pctldev,
 						pins, npins, pinmux);
 		if (ret < 0) {
 			dev_err(dev, "error adding group %s: %d\n", grpname, ret);
-			goto put_child;
+			goto free_map;
 		}
 
 		ret = pinconf_generic_parse_dt_config(child, pctldev,
@@ -209,7 +209,7 @@ static int jh7110_dt_node_to_map(struct pinctrl_dev *pctldev,
 		if (ret) {
 			dev_err(dev, "error parsing pin config of group %s: %d\n",
 				grpname, ret);
-			goto put_child;
+			goto free_map;
 		}
 
 		/* don't create a map if there are no pinconf settings */
@@ -233,8 +233,6 @@ static int jh7110_dt_node_to_map(struct pinctrl_dev *pctldev,
 	*num_maps = nmaps;
 	return 0;
 
-put_child:
-	of_node_put(child);
 free_map:
 	pinctrl_utils_free_map(pctldev, map, nmaps);
 	mutex_unlock(&sfp->mutex);

-- 
2.37.1


