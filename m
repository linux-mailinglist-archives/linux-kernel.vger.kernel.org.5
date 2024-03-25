Return-Path: <linux-kernel+bounces-117153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD26C88A83E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74627C423E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCF2128366;
	Mon, 25 Mar 2024 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TQK7DmZB"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EA355E48;
	Mon, 25 Mar 2024 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373667; cv=fail; b=lrH4HZiS/ZdU2HJEz/QPwHpc+vK/415f+a+wc8JFCGBt4K9gz8qu1/IhFzy0OGr1Nj/9JtzyTBG72ESQPizC9YM4B3iA3DxokjKU43jw3sgu1MhhP4YxsW9jaAlmT8SswaoxpNHKU/lzmLE7ZoomhrMJt1VeP0LuFqj4mIFav/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373667; c=relaxed/simple;
	bh=e0sgs+0DPJ8cAb9C8HF+Iu4KuNgtO6lg2P33qmTytVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VO/BLtL3vW7/0RH12fmdOklAO09CzIgpJdrSlgCgzB4HSgPPHOC0XOMb2TK+LSB/PnmJq7EGCHrzdak6VRGDbQ+wkbICLlWfBSggxL4+PicPdqDAA/eYCoqq4PJmdg9bCkAKF7yWDhhQJu92QQ13U5kvvpNyTd62eLO3QPTms+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TQK7DmZB; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emQ0PDGoX26wAJFjaC2CXnyGzDf1em4nK0OT1RrhlGliJLKsSG++tCJUExrREvgmnu3LyBIC2s+2q5XmZx4nyXptRl6fzALOGUHYbm9eUO77IEQSlnur5+fkQ/IKrpJoKtHMvpbiIVVJxSG4hFDJGCX+T1EjOZe+3lPVgZ5sMCib9gn8zYWiDa8USEK9Fc2DlbfyLOvYhywUP1bl81Ir/TCXEInCMF9JxvTg9MJL16jN2HSU4sZO+h6DdarHpuHY9vVCXzPic6q9ZTKAFEGI3WBvR/lLLYzV40puk93YTNdx75q9dHhJyb3eirmfHHDhTij8p5ybchVQGqT5RriFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwrUjndK4MUoqDKd7aVJYdLrq2/twsACNp0J0ztvPxU=;
 b=ayV4BTEgfTQWjDA/X9Rdzlo6rB9pXFjPL0Dj1s/gq1HfJuL7wvccmLzjpvgpGreZbdtdWHxVDjPegp6ReMG4hmhp6+gcvq0vQ5CSY7rdreOGKfCWTdXTXOUr8KoLX/hOoEk43ZKfIurrJgJPX8ILRGH1ebcMiUkvx10rXlTWwnv9oRTXMYUUMBzwaPkQ9Or3QicigyvVY0aojpPNA8xIzNsv4guIwRQoCL28lwT8D3kl5Jq33ivW0yPHvQ65xYr8VCBFrmbZQGPcuXLs5Srbod/j8o68QihcgG9FO9m6pzxkOH2fVx7MrjuyaMX5Z63KtNiwTux5f0XHt2KXSrP+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwrUjndK4MUoqDKd7aVJYdLrq2/twsACNp0J0ztvPxU=;
 b=TQK7DmZBNaKjg9in+vNvMf7S4Y+0y2xxc28UoUbVjWDczBxzV+GYkSawruRExh2izZpCt8RyZpyP1zChFrDsWUe4O1hZ6x3e2JaNHP5AX42V6eetHFYHU53QPjSFtKelRbmwNz1E/O3iO+FOsHr4z/KD1HYGfXQsqSBfc4vtSQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by AS1PR04MB9681.eurprd04.prod.outlook.com (2603:10a6:20b:480::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 13:34:21 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::6fd2:46ce:25c0:3dd7]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::6fd2:46ce:25c0:3dd7%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 13:34:21 +0000
Message-ID: <99e33fe7-2563-49d0-ab66-cb4d243c70ac@oss.nxp.com>
Date: Mon, 25 Mar 2024 15:34:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] arm64: dts: S32G3: Introduce device tree for
 S32G-VNP-RDB3
Content-Language: en-US
To: Wadim Mueller <wafgo01@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chester Lin <chester62515@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Marco Felsch <m.felsch@pengutronix.de>,
 Marek Vasut <marex@denx.de>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Matthias Schiffer <matthias.schiffer@tq-group.com>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Josua Mayer <josua@solid-run.com>, Li Yang <leoyang.li@nxp.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-serial@vger.kernel.org
References: <20240324214329.29988-1-wafgo01@gmail.com>
 <20240324214329.29988-5-wafgo01@gmail.com>
 <df6f2a09-8125-4c1a-9dfd-3217233dc076@oss.nxp.com>
 <20240325132634.GA33097@bhlegrsu.conti.de>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20240325132634.GA33097@bhlegrsu.conti.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::8) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|AS1PR04MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: c301e706-0e6c-4ba7-79ce-08dc4cd046fb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 VVamkpEzn8fPIp88qae2syg5i6iJ9caBC7DN/JbrXy2Uk1Ly4uvUMktDTg++HHap0ZSsPdKuzo/2ozXVBuRM5z12n8NWJnY6PwfKHoW1cMyddlbFSl4pwHCnNsAC34gtISjngH8IVJbYw8e9u7ga5YkIejo3DDL1PuWuIBnrNp9o59Nkyi3hH/TdUwlELf5QF1i4kxKN92oujPx07MTf+0oUdjGAVBZRqFYmUb6hUXKknvuXG+s74KrLYwJFU0oiQHQIljxvpXyMDx3WuFug8fwto5lzbpQKf5bBhxDANxOF1TvCqEr7tzChfGW+CQ5wu0+VAihnUvNEtWH2dY+imzSUgOcuRl0i28Y1G1JhbXBzWxMxeV1POJ6nk0xTvSekIOtUbC1moVVa1VjPHJXNMz2X+ZZkuse5bSrQPUUA+9aJdtTHX4Q+jcMrVvkBm2DWnDTbcd5ObvocBqQHM1sEefpMzA8mlAk5Pbd6VqpK9bRvTSqDEIb5ObzuTrIoXr1CQO00QMaa/iwHVNsz+s6ofKrK818ViCzZRZihDp4zMYIZtt2EEerQ6PhqJegwRdxIqb1FA1MN1QcQYso+gOhixZMil6Fwlpwzb1XvKdwY4ALnzNLu53V4s+ZpeI1mJnMq
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TlRIY2sxRHQ1VzhkdTU4RDQ2Tk5vU21nYzhuZW1kTnJPRjNQei9kYUhTaTBJ?=
 =?utf-8?B?SUgrRlgyRGpjbHJBY2ZRb0FSRWY2am9LUE9EYnMwTjZtamNLbXFxRGZ4dnk1?=
 =?utf-8?B?enBtZERCZ0tOODN4cExJYncxeTlFM2RCM0RUeGtTSk5TRkNUdXVyZTl5M2t5?=
 =?utf-8?B?dkcvQ0YxTml0aFI2NEZiN1hURXFvVGtxdmhRa1J6QTFpYTZuSDZVd012MDhC?=
 =?utf-8?B?Z1FFMlhWRjEyTFNodGRoOE10eW9DYyt1Wi9LZ3U1cFkrbWx6ZHl0bjNVcmsy?=
 =?utf-8?B?S3YrVXNCK0ZDcTMyTFdJT01yRWNyVmZKM0pFVE9wcjRYQWRONXp2VnFJT0x6?=
 =?utf-8?B?SGREa3RyM29GWWdxTlhWOHRhcGVDaHB1RnRhbElweHQ5eGV2ZkQ4TFJseC9k?=
 =?utf-8?B?RHRqNW83cjY4R3BjaHNRbHpCRWRIY2FDRGhjVXZNTEY3Tk15T0tzVlkyYS9w?=
 =?utf-8?B?UWZVZDRJR3REdEFHQ08xaTNxUGlhRUJabjlxRE0veElDYkt1S0hiU3ZKQ29F?=
 =?utf-8?B?dmRna2hucTRhUXNFajJkNnEweUZpYVhqYkZqS3pBQmVMQkdob05MM1U0VE1w?=
 =?utf-8?B?c3NwQXdVU1U2VG5PUFpOTVpBdXVOczBpZnplZzh2Q2p1YmZOMk5DekZzT0Rq?=
 =?utf-8?B?SlVHcDhkM0o4N0ZCWlh2bGxjZ3dwSnFSQWp5d0NueTRmUTBsdG4zSkh5Rlpm?=
 =?utf-8?B?RjVoZHVZSjVOQTd1eWEyWk5tWGFnaURmcnpmWHJmb0ZpZHh3REVacloyMVZa?=
 =?utf-8?B?OW9XSXV0VmwxZzluT1VVZG9XZGV1R2x6aTJOakZ5RTFjS05NazVGWWdQWGV3?=
 =?utf-8?B?cjFsU1VTSGlqZXNoWFpkNEcwZHZiUjgvbDNVempRcE1NeHZZWExCcWF5Vm1O?=
 =?utf-8?B?ZktJWFNjTmhEWldHY2c2dHp4UG1YNVVOV0MveDlZeGJLSHkxNTBIc0pSWkFP?=
 =?utf-8?B?VDg4ZThtV1pBMmc1c1hqclJ4UmY0QTJGNkZwSjY4UlB6UEc0ZU01MjMxV0hG?=
 =?utf-8?B?TDhDMmRCYmV4Nnl4MVJramVIMkp5MkZvQ3h6NDlDZURHNkd2VUFmbnlIMEtF?=
 =?utf-8?B?eFFXNERCM0JRK05ZT3VLTHpudVF4NmVHL3JGMXFvdnYza01oYUF5a0hSRENF?=
 =?utf-8?B?OU1ockdnR09GMHg2M0tIbkFkVlRTME90RjJvL1FaK3BLK0hFUkdjWEdFNVE2?=
 =?utf-8?B?SlhqakV6M2QzQlV1aTdKd3FHdDBuZEwyeHoxSU90WGYrNklQSXV4azJBMVIw?=
 =?utf-8?B?Y2I1R0hnRVQxTDByeVdEemNTNFB6YWRnYlkrZ2JnSFFCaEVudkZ6Tm52N0Zs?=
 =?utf-8?B?NXFLeXB0N1NlSVd2UUhBY25mTW8yNW1NUGdBdzd5WU82UkM2U2dwTmx3ZURY?=
 =?utf-8?B?N1hQeVlpRU4xazk2dHA1czBjaEVaTlM4ZENYeHFkL3VRSWo4OUNxc1Z5em0z?=
 =?utf-8?B?ZUhWYjh3WEp6R0VFcFlwYlp2VHRabGVGSkpoZUVEY1dVQ29qdis2VXh4eENE?=
 =?utf-8?B?cnU2UTNJbWFaRkxzRCsrSm0yUzA1MTV0TndFNDc2QzFHcVFaTm5tbW5jOG9a?=
 =?utf-8?B?SUhlMUF0OXFYRHhMVk02djNEZUx3cWhZZXloMkJzTmk5WFRxSzB1MzNYZnR4?=
 =?utf-8?B?UjZ0QmV2Zm5VL21nZFEzTngrM0JKOUpvRXNLV1NYVGtubFVQaHBpZjIrK1lJ?=
 =?utf-8?B?bHcvb2NaaXJXWWtHb2Y2b0lrOXhLUTFXL215cTRuMzRtK2lTT2F6R1R6ZWxT?=
 =?utf-8?B?dHpYa1UzZW9OWGcxSGZEQmxmMVRkbUtkbm16NG9oa0pQbjQ5WFpzWXN4RXZB?=
 =?utf-8?B?Y3JxajRNeWRxRzN1MW44N21TL0hEbHQwYUt3c2trdTl3Q0pvYlY0dFk4bFFz?=
 =?utf-8?B?MTRuTGxIMmt1YXFBV3dnMGhXMGdDV1NhNm5oem11T253VStlczNOZldVUmJu?=
 =?utf-8?B?NTZ1dlVGQThadHpNa2llMzF1dkdOMHcxb2dUME9zSW4zN01aekI3WitHU1ND?=
 =?utf-8?B?d3FNZmNtM3Q5L2R3MGpEdWtHTmpSU1Q0NGRjS09pcWprcHBjbWVLRDlnd3B0?=
 =?utf-8?B?cGVKZWp1Z2tob2FtU3FLNENWMzYrTFd4dTZyU09NNm5LSStmZllKbXpBQXo2?=
 =?utf-8?B?TzhYZXU3UEpkU2xVRGVsb2VrVlpGT2dmNGtMSU91TExBM3dPbGJleDJsUTkx?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c301e706-0e6c-4ba7-79ce-08dc4cd046fb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 13:34:21.1394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kICVte9ae9s3MgGklfmv2OWi0JS8YF6XIZA460gmMUSWuBqsBl4so1ZMUODqzIs+Gz+GXEJhDfktxWZcUqBitj2RoZvwnArQKhubEX4P3o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9681

On 3/25/24 15:26, Wadim Mueller wrote:
> On Mon, Mar 25, 2024 at 11:30:38AM +0200, Ghennadi Procopciuc wrote:
>> On 3/24/24 23:43, Wadim Mueller wrote:
>>> This commit adds device tree support for the NXP S32G3-based
>>> S32G-VNP-RDB3 Board [1].
>>>
>>> The S32G3 features an 8-core ARM Cortex-A53 based SoC developed by NXP.
>>>
>>> The device tree files are derived from the official NXP downstream
>>> Linux tree [2].
>>>
>>> This addition encompasses a limited selection of peripherals that
>>> are upstream-supported. Apart from the ARM System Modules
>>> (GIC, Generic Timer, etc.), the following IPs have been validated:
>>>
>>>     * UART: fsl-linflexuart
>>>     * SDHC: fsl-imx-esdhc
>>>
>>> Clock settings for the chip rely on ATF Firmware [3].
>>> Pin control integration into the device tree is pending and currently
>>> relies on Firmware/U-Boot settings [4].
>>>
>>> These changes were validated using BSP39 Firmware/U-Boot from NXP [5].
>>>
>>> The modifications enable booting the official Ubuntu 22.04 from NXP on
>>> the RDB3 with default settings from the SD card and eMMC.
>>>
>>> [1] https://www.nxp.com/design/design-center/designs/s32g3-vehicle-networking-reference-design:S32G-VNP-RDB3
>>> [2] https://github.com/nxp-auto-linux/linux
>>> [3] https://github.com/nxp-auto-linux/arm-trusted-firmware
>>> [4] https://github.com/nxp-auto-linux/u-boot
>>> [5] https://github.com/nxp-auto-linux/auto_yocto_bsp
>>>
>>> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
>>> ---
>>
>> Thank you, Wadim, for bringing up the S32G3RDB3 board! The board boots
>> with all 8 cores. The log is attached below.
>>
> 
> Thanks for testing Ghennadi, much appreciated. 
> 
> According to MAINTAINERS all "dts/freescale/" DTS files
> needs to go through the IMX/MXC tree? 
> Is my understanding correct? Just asking whether I understand the file
> content correctly!
> 

Indeed, everything should go through the IMX tree.
Here [0] you can find a long discussion about this.

[0]
https://lore.kernel.org/linux-arm-kernel/a5f7b53a-6b44-4f0b-83f2-b055b8aa3b2d@suse.com/

Regards,
Ghennadi


