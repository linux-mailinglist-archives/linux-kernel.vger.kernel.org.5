Return-Path: <linux-kernel+bounces-96741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32798760E2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BE61C20BF0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C91535A0;
	Fri,  8 Mar 2024 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="HcHq4GHF"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2136.outbound.protection.outlook.com [40.107.6.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E60CEACE;
	Fri,  8 Mar 2024 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709889951; cv=fail; b=lF2TqkJ8gh0Tf4FEd9lxXBLFUjOyKrzFWu5iaw6IHJmRh4sYeXYTLBWJz/abMqVVkzWpg4kST0PKbKMtkdbqwdLPFQVzpodr6Iilns2i/ThZMu4gu/yOtMR1tbIAiKiIxuxxcfWzUPS2zeqieNb/4f+XzQrO9BYCCImzhI9BsPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709889951; c=relaxed/simple;
	bh=qbke9HgHfO9UKgaNEj6UCdUKBq4ddEcXcUivw+dyl4k=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KTjIBgQ9BWXBN/xhVJbVTcAQwaxuJ8YtglBIBmmXzcH+AWKwF2sgEfZDIqTs+7zYU5BL2xqs9kI2viVu+bdeMbnrAeVpL+WcGXZKBOI1sfqlwVmhatQMP30ixQyfr11SWZkRAiqDkxhWKlYaVLsgSf94/qusrq1UL+Fb38zLHYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=HcHq4GHF; arc=fail smtp.client-ip=40.107.6.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeK0M241lTkXdfYUH6ACU4iwaDdTdtBMxTeD3K3W8LonHeCjC/vy+HwToB9WE48DhRuT9YG9vVqLBNEthwqaq85ESyWItULvRSdKfE8cb06/nKbv+fWkCnaXRbPuwR9pgRZ4cvixr3AdEaDrMrKj8TKzN2enxnJE1pb//s7a0pjkAP9D2IUWc7LlUg6vNunLxTso5E2xu2eTXTwoOe3OKLWKbo6LZuTgG7ezvEMroyfJxU58KgU5/QDsgGPa2lKtclCuBH5j4Pb7BweTQHiSlkWRbFmQzTgvldGHdpAH7EWfl2NMS7DN4p2zC4eA9voNS3bn9w2X7T7i8tI1shOF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydlWtFc00DkU8h32Pj12MkYaJl5LG3bLy5Vic4OXy+Y=;
 b=gOwHQWWiT8mDrLkFSoa2Ki2TGYwannB9E6h2oLpd4FU65/LZeWpGj8XYwrJkxSBJHnPNZx3Pmxo6qzDwn+UmPw/b7ykBah4uvCrVkvJbjimItYcuMFPwFnn9/439H3dCADkSJAtmEFv0rV7Dwc4bFIp9fyV2RZ+Gjr2hUpOnkd5bPwLKxWhnv+gKv/TJiRP1n8OzwbMGZO1kW6gIbXZWUUSmjMe4I6xorWH74NsL8i9WwoatQK8ow2RXptu25IYI/iDV1xFD/zFAYg+0EbD3DXfpsTlzwSoPMKlUGxf2jYy8tIJLCGqBoY0YETNiVjTyPGyEZmfgQoTkb8jAqjKh3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydlWtFc00DkU8h32Pj12MkYaJl5LG3bLy5Vic4OXy+Y=;
 b=HcHq4GHFKaBYgL+StL9FzRGBH/9X8N+9f3602uOdDQ5MD+HCDbRfYtEKA2cJWFWCTzJuIQgivodpr4Fd0RV4p+PbxOMm6PLbMc7DS95gXvhLgXpYgg4y2enA6URGdSrvnnppYsBPBUeGRO9opHPIRH7bLHNbbHRM5ETjzBUM06VYsW2ZjREY7uKkcLKiHDVdT0D6XuukxHZiHRU2w3Z1kA0VuprPZpbUvwC58nU5VQHFTA89V02HArjAuvYbryJsp802NLxiEV/UoCtFR3YmsnktJ9ZxL8yA+QRLhjUe6XyToOMkqGMFIRKTPyTJ17hCNXkZOwKTpcmDoHfTMgUn0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB9279.eurprd04.prod.outlook.com (2603:10a6:102:2b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 09:25:46 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda%5]) with mapi id 15.20.7339.033; Fri, 8 Mar 2024
 09:25:45 +0000
Message-ID: <ffc940bf-b9df-4731-a34d-f725a6d6d7f1@theobroma-systems.com>
Date: Fri, 8 Mar 2024 10:25:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: enable internal pull-up for
 Q7_THRM# on RK3399 Puma
Content-Language: en-US
To: Iskander Amara <iskander.amara@theobroma-systems.com>,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 heiko@sntech.de, vahe.grigoryan@theobroma-systems.com,
 angelogioacchino.delregno@collabora.com, dsimic@manjaro.org,
 alexander.stein@ew.tq-group.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240308085243.69903-1-iskander.amara@theobroma-systems.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240308085243.69903-1-iskander.amara@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3df95f-e8c6-4c88-5413-08dc3f51bbe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O3eUfcOoA4+IB91B9Oru6XoZkxanUkP2C1xr1W+LjwwmlPN5TDcW3ko52Ecg/SN3avXvVaF74PIBxl4Lgv4D0E+uMuNkRn+js2eybBNVptGG0rxmuczjSfA8oLz7CRiC1iQNzxFj4LUv7p6aSl+XFsmVNHOlX3rp4/eBtJFq9a6OlmgrY1M/vYbKkJ5iknTu4E7img/yca0T/1HrsOwCz2OKPQFREEpUuqpFfH61U6GxXJ8Vb5mkio3tbo2+YvVzPCW6rWn94vc8B8wiA+l9etgz/PtnXqxpiCfhFGf9wRVGYFI5lAbGWIpm2CKM7skjE/jAJqjcCXLYTqs6IouWdTXi4MmC61cbEZs5AsN/TElZIz2Xv03OU5hWLBpELXF5hSkiyOoMH9+tAda1kPFckysYiQSL1MjJLu/hfJYKcZ1jjx7PKqnw4xmrRBCHckq3bRl+MTYiL1eTgNIVdcv9HMn0pe9cLkt7D7qs7IHL0+qSMp1DkbIZrIfUttw7J7x+S8kfWkEY4JKBJd8crLQluc/nmKUB1OCOKcHFA8C1x3AK+nSYYfGLGiCM3f1XgIv+N7eGT1p7CLYIiD+uyip3/UJLgC/TkahYyjk4LOrD6crG+wN6YV7fxI8CWvtiKJ9713J8BxGUkSycFpZS+QSa0Gu8DSu8zpRKEIw2cZIIdJi+5d+s+5dV4gflxR0SUXzCYbG94CdZgjpxoi2F9YZmZw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHVDc3Y3SVVvVEphbTFKTm1QcFp0UEwrWFlhelhvU2dHckJrSHlHQ3FhU29D?=
 =?utf-8?B?Z0dPY3V1Q2tJYk9SRjRvZ2phai9NYUVIM1JrVmRxMndTalpsRTZnSUpmZGN0?=
 =?utf-8?B?RVl5WStRUmMvVVlIM2crdVZvcG1Kblh2dUlaOE84Qm90NXM1N0cyelMxWmR2?=
 =?utf-8?B?UnB4VURSdGlhTHBvcDdSR3dVUGtYVXBIb3lObWdzMjkweWtldEl0OVhHM09U?=
 =?utf-8?B?QkUrQkh5MDB0Rk1Ib1dPUFFRQ3lEcjUxWVJzblNrM0Nkejh6cDVnRDlnNmo2?=
 =?utf-8?B?aWttM0pmOU13T0dFZm9KRW5BTWhwdlYyZkhCOXVDei85clA5NkhEZktGMzZN?=
 =?utf-8?B?K2daRWtvZlhlaUVTekV0YXB1Q1NuMDVmdkhlZ2NiVk5SL0tPeWVWQkVHeXg0?=
 =?utf-8?B?TUZkNVhndHhPZzVaMmQwR1pVNVc3TFFIL1d1M2xUSVo0cjF2cDl0am1RTjY0?=
 =?utf-8?B?Y3ZPeURkeDliM1dTKzRhWmVha1QvNUtISDllSlBkNmVYcTRScFlXUnV6OXUw?=
 =?utf-8?B?SjBJU3lEL1dqOHd5NUU0SzI2ci9qaWhHRFFBL2pqcXhmaE1uck9sTTB3U3pT?=
 =?utf-8?B?RFF0dEFWRHBIQUFJNnVmcFhVQ3oxcEVLLzZTVUZrWFNGcWVLaUZwRWp4OVdO?=
 =?utf-8?B?dXNyR21lcGJ5OGU3OG4xME80VEJtNGJEYnBLWGYxeE9NdjhxVDc3TE9UWnJh?=
 =?utf-8?B?a3hqQktNMmJUN2hySHRGbTliTlUwbzR2R2Q2N0pEVllML21EVDBmU3lUM1gx?=
 =?utf-8?B?T1lnMmV5WUoyaVg3c3U2VmplSVJFWlJaY0hXT25zdmVFak5MVzNUTFF5R0RU?=
 =?utf-8?B?bUVFUXFXUXJhYlhTV3ZDd1YxR1RPajlBaUdBQnU5NHRtNG1uOThLUEdneWcr?=
 =?utf-8?B?bkp6Y2VjVWhuQVI4ZnBCZ1M3V0kyMmNENzQveEVjRS9NZXNySFVSeUxRalY2?=
 =?utf-8?B?TmZlNXpVc0x2UU10OWRpQjJMWlJjOE4wVHU4TTlEWkphY3EwN1JMb2x2eG51?=
 =?utf-8?B?eDZqK29tSnk2dnl1M0JkdGo2L3J4TlJPeGQ2NlBsUnp4Um9Bb0lVL0R6TGUr?=
 =?utf-8?B?aHFZd2tGMFpjS2VSM0xEQXp3MEJGci90eHJnd2xDbnpjQUFFVVhtbyt3VzVC?=
 =?utf-8?B?YlNTMkNOazlyZ2R3NFhpZU12eUtNdVdqRmpkVU8rVHVCMDhReVlmM1NjdVlR?=
 =?utf-8?B?QkMxV0FSK0xwLzk2bEFXVmpPUFlsa1RMTnA0MDdEYzdaN2ZxM0hsSlNvOGpD?=
 =?utf-8?B?cW11UFZYaWorNEZJd2M2V2FrWFpMZklxNS9jM3RpN091UnFCRjlKZXlIdGUr?=
 =?utf-8?B?YWJZVHlUK0VQVXg2d2ZQZVYzd3c0L0w1L3dzaVZxV251VUdXdi8wUlJ4OWFR?=
 =?utf-8?B?cTczbFFReDhpaHF6MkFKSUF0bmlMSW9MMVM2ekN2YndwamJycHEwcnVyWHFY?=
 =?utf-8?B?VnU2UFlDR1ZWbzFUbmtJdjBhOWpHL2pPV1FOOXJxUjhoZFRic25BUmJaS1pv?=
 =?utf-8?B?Qi91L3VoRUZkMGsweDV0VWppUlZhWW5ub3R6aGx4enBZWDQwV0hmOW9RNkg1?=
 =?utf-8?B?bmNBa29GR3lmZG1aYWFBWmNENVpneWw1Wk9ueFlIeFRib0RIcEtWKytLWGpo?=
 =?utf-8?B?ZEg1NGx0eTMzbUFXdnlmUHZiaXk5VDlJWGU3d2tWeHl0SXlEc0NqOHVyYnRF?=
 =?utf-8?B?bmJSd1NTcHpOTWFLRk5qMlhHS0k0aERubC9TVjMwV3VjMXEzb3hJSXY1OHMr?=
 =?utf-8?B?T0NsYjJNUDhMUEZXYTY2SHlRWENjSXBnTWh0WHZUZkRUQkV0ZDNKdEc0T21E?=
 =?utf-8?B?Q3dqUkxIN3F2d3ovcHBaQ2dLQ09NOUYySko1dEdwSkxGbXl2SW4xNE5WVndz?=
 =?utf-8?B?azkxR0RFMUo0RmhoT0xucjNZby9ZdjJoa21ML01aRitUYm9GeW9NYUVFM01w?=
 =?utf-8?B?R1I1R2NTRWNEYkZyM3ZGY3FKeUlNNmE4Zm5XcVA3d0hOaG0zMDRmbnY4RVdX?=
 =?utf-8?B?bDlIcFFod2F1UmQvTGhEb09qeURoOEpMZENFRkpvWE9YWnF4OHUrOUpEMC9S?=
 =?utf-8?B?aitDN2ZlOVlRUUZMNlJzdS9UR0tRZklzbHJaMFdkQktNRHNNZlRxZGhITzds?=
 =?utf-8?B?VldzTUZqaUptV2E4OEFhK2ZnaUY5dE9waVgzdHBiUmRVcVZSTjJOakxJMm1K?=
 =?utf-8?Q?m4PI2HUjbZgOgf7/m/9I8d4=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3df95f-e8c6-4c88-5413-08dc3f51bbe1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 09:25:45.8285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/gbvv0778EGIfZxSPpNfRLVtFKxdcuYoAKP0x0S2QeeAojQrPW8XguKnTfGQ16kd5CHIhG9BV/I9IhiK9ZH8wekSpoVQxU+HFDMw8YKHeUBG0VFsy7p4vU1a9ED8jzq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9279

Hi Iskander,

On 3/8/24 09:52, Iskander Amara wrote:
> Q7_THRM# pin is connected to a diode on the module which is used
> as a level shifter, and the pin have a pull-down enabled by
> default. We need to configure it to internal pull-up, other-
> wise whenever the pin is configured as INPUT and we try to
> control it externally the value will always remain zero.
> 
> Signed-off-by: Iskander Amara <iskander.amara@theobroma-systems.com>

For the whole series:

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

@Heiko I think this may match the criteria for stable backports?

Thanks,
Quentin

