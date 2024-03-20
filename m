Return-Path: <linux-kernel+bounces-108612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8912880CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C656283F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF6A37169;
	Wed, 20 Mar 2024 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Gi/NTh9k"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2086.outbound.protection.outlook.com [40.107.6.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5B623D2;
	Wed, 20 Mar 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710923058; cv=fail; b=b3bIt1TWH6fk+pGJ3Kqp4hVe07EYozO2c9S5wvwUB/eAl3Yqdo16i7xZ3iwR/2/rTomCZfd9pG3pPWxZcHFFz2rGfDgkBcOiDdq+MZPcgfrjduAHQ8EwoHf05bJKDWS5gfKs4fyyK4td8fzXl10HzHaZw61kzfzxh5LP+ypfyBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710923058; c=relaxed/simple;
	bh=jnTBReeWbVqXO9+Pf4gro8/gGcB9A1O0QMBLBYLk0MM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CyEhy/GxgSKwj+jIYEaiDJq4Y/poivsxEOwTvWLSGbhIv6+GY8NAzewLIcNXrb0EILRxjvzTUeZlVIbrSCYWRzrE8p5kgHDmFJ0jD6z++mUtWQyOgbhZdkarz/Qfw3MJqOtesbyw9i+tl0lDL0SvGIwUJKDb4e4e/Z0x7vSxZWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Gi/NTh9k; arc=fail smtp.client-ip=40.107.6.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXzyGB0ZsK7XUrv4DFpw2BE2a9SVmjB/1q61/0g8+ZN2H7EpIdgmR2pK2+PoaQcifLwPFOLtKFHpsSnB6MxxgxGwwhu39DMqZ0Q49SfGPR7GlMy170n/Q1JqoSNNdThwVrXhU1NlDzmlxYYlfs8w6zdQJARIW0YARZeN50buKQdmbqZRSB3HntQMlaYWrHw+F5WWQhA372ZaZFRbAJV08Raq32P42t021oaqZ4+ZDxK15Apwuf5StUJXkX9hlKRdOG1mqFfmkrsxCLEm56+vWRniYxgP8tK0FZG3rloMHQVtgdpcxWZjsTFAIypXHwy9tQNRVZEwtNKbbPsyopDcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlGoGBK9+DqTF6GLJKBFJtTzbPvaAraCQ6J67xo8Gxw=;
 b=G72sm6cCjRk7Cw40gwwLWS0lKR5ZbYRk0G3DxZr93ZLfa+lyTyLA7jGZpTLAIA11wkGvnD5qJ48O9+5Dvrh3R3X0GfrPODnqNW3lTGbt28aIsehCaPBIEH8mpEBQtF7AWl/oolsgJEHoabR/FFmXSi5RYIiSmOgRKDC4j3C9z7fmpa3cfK2k27m07CkiX3Ft1ivUHBUn7kCLFLGZKia74Qm9ST+TNfdPtBHfi0kg0vhJQUKB+FE1EjoSSSaw1YVKNJh5KHh+QXBJPTuhYrghSIN/YjcM/nMZCSPBiz+fmMXYjqUwL0FSWfw7hDf7XoHaAdbcD/Sl5SUolQtuV5aO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlGoGBK9+DqTF6GLJKBFJtTzbPvaAraCQ6J67xo8Gxw=;
 b=Gi/NTh9keBmnL6r4VluJWd5PrPTvnvwuS2Vn+uCUBF+H5NTLatq1+oFO9onEyQoJomb1UK7FgKBuOGGQx/X8uUcPL3a0VFShWTK1hQkeAdw7FojrirL3dWwvcvGG+AMwFZQ698ZSjwnQYijRprKfjVtbhUNLOaSJwbvyzNPCmvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by AM0PR04MB6978.eurprd04.prod.outlook.com (2603:10a6:208:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 08:24:11 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 08:24:11 +0000
Message-ID: <6830dee9-2378-4742-8ec4-aada9b5aba17@oss.nxp.com>
Date: Wed, 20 Mar 2024 10:24:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: S32G3: Introduce device tree for
 S32G-VNP-RDB3
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Wadim Mueller <wafgo01@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Chester Lin <chester62515@gmail.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Matthias Brugger <mbrugger@suse.com>,
 NXP S32 Linux Team <s32@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Marek Vasut <marex@denx.de>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Matthias Schiffer <matthias.schiffer@tq-group.com>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Josua Mayer <josua@solid-run.com>,
 Yannic Moog <y.moog@phytec.de>, Li Yang <leoyang.li@nxp.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240319221614.56652-1-wafgo01@gmail.com>
 <20240319221614.56652-2-wafgo01@gmail.com>
 <a5268bcc-144b-4e86-a13a-33d976368f06@oss.nxp.com>
 <018d1b9d-7957-4efb-903b-2e510db1ff80@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <018d1b9d-7957-4efb-903b-2e510db1ff80@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0029.eurprd09.prod.outlook.com
 (2603:10a6:802:1::18) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|AM0PR04MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: a9064dcc-ddfe-4aad-01d3-08dc48b71eec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 QJgYUXsSWk/s1esG01BuEypLZzj/6F2HdjHY4xW0LL+1GzdDj/QCMMHD0GQ7PyF6WiXIRLAqT3RvSJ4BW5/+tDi9qxdI2S5XbEr3h4GFQzzRwM6TqxJvuJtUh+I62yuaVQwBJgIs3yxtl29ogQEhinK1W6StVquDcI6vv1ZjDNeRr+HeMqSklf+ZGxTSxaX96fCJZyyEfKwfVX6tyrjN3IkeCn9q7ZpGuTrau19lCFvmb/UdNtlmTYWjO5s//GteJOgL8rSMeJK5J4yplLOD82ykB6w0GKGbRKVo7OkD/+vTT0HqdPE/mKqLEsnWP01xawyoI4URPRmagsnQ2T+nPWOvduYyUJlQBWILNzjB/IJkLsJKRX+YgEmabQH8mJRbLnVpVIyVD42cBCjPQUq7fKpSdKHTZtFe0lHjWRMo6DPskxp8fAE9opPgJTCfaU/o9FqgLnwv0sx9w2E6u62N3n+f+e19jHs8TnsDi87dPvsXSdVToQG0yP9qgSHvbUMkVDFDWjdPiDYltvVrlawEpvAv5Wb/MEPWpj8SwqJJRUjMClHg2BqS2IC5ymnFAPFl4B5UEbHk6gtpl5+J3Fs63xARWcZFjCduv70y+g2YW2c=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bXNSOUZ0dW1JRTdvN1FrUlozL0JBNmgyY05UWUtWNm1VNWltVGpXU2h6ZFRj?=
 =?utf-8?B?QnNPYW1yaDR5Rk11U0FPMXdlQ2tQS3pGMDBhU2NpWFZxWjdHOXNpcklxUTRT?=
 =?utf-8?B?bnN0bWlFQ1dXL3JXcWc3Y0o4U0p5amVjTWtJMElPNlNadTZ0d0EzTmx2WTBR?=
 =?utf-8?B?YXlhM2RDNEp1RzdJRW5SZFNHS1pObXY1Tm9RaWNHdFd1KzhtNlNGVGNKZWxO?=
 =?utf-8?B?NGI5cEllNDhIUHNVM2ZWOXpNQTBXSjFtZ0J3anZkc3ZyeGN6VHp3UzUrRmZY?=
 =?utf-8?B?bnFMcXlMSDVwZFRDTWovd0drYzJBeW9tdXN4cE5EMmdnMGJKOUdrbFk2UUlC?=
 =?utf-8?B?YWZEUzcrV2QxSkVxWldNTFViRk14ME13Z3krc3lUSXhJV2FmK0JPRWwvRzl3?=
 =?utf-8?B?bGFMSVJXdUh6UGFBTy9ENzREYzFVUFQxb0pYVjRQNk1VVTRNaXByU2pQYW4v?=
 =?utf-8?B?YllaVFRXMXpUVFJwd2NQTitKa0MxcVBCK3k3c2VFSWpOZExUallxR0xwVE1Y?=
 =?utf-8?B?QXFEMlBraHJiN0IvUnVNUEJWdC9QWTE3YU1IUFBtK2l3UUZHMGV5c3hMMmJE?=
 =?utf-8?B?YXRaYTd0enc2U0tvRVVUdmNJcmxSb0tRU2p5RGZiQ0EyVDBJQTBiL1JZZDhy?=
 =?utf-8?B?OXpscEpibDVmRjRsR1Urb3dIb2dWcWJnUGtRczArY01JSUwvbGhFSUZVYy9Q?=
 =?utf-8?B?a29BbGRoM0RIK3J0cXh6a09XMHJXWEszUEdJWFVwNHpJcWpITEY1TWYyQnZE?=
 =?utf-8?B?T202RWJKdkR2Tjl6SUZ2dlhqdWZGeFdrZktWaTlnL3ZUZnZwZ3Z1Q3NvZXpR?=
 =?utf-8?B?TkFhUHVwTWw4L1JHRzlhbytYOW5aYXNpVURaaVR5dndjUjRoT2FLU1UzNHp4?=
 =?utf-8?B?aEZVSVdSalpBbUFvZm1JTVBFcU9vT1BiOFlzOGV6SzhNNlg5SUl4MHQ1TUFS?=
 =?utf-8?B?NWd3OEtxL3A3eHFremRiYVhLTWs2dFA2NlJUVC94MmRtckp1dWtNRVRJajV6?=
 =?utf-8?B?WStaQm8yeFNoV1VHOC9uVlpSNXQ5RVZwTDU4Skhyb2o2Wk5oOXk1NzA1eTd2?=
 =?utf-8?B?U2o5Lzc2QkMvdzJnTnpUWHM0aFAyQzRrQks2TFJLTkFGSzZWNkp1M0x5UnZk?=
 =?utf-8?B?RnJXWTBOSWwwM1NrZ0Q1RG5kNmc5SGRpa1FTUVNJL3B3SEFDNHVZQlpPaWFy?=
 =?utf-8?B?V2NLbm9ka0ZQMWRhZEllVE5xT3pGVzFiaVZwM0FvcnhIc1ZZdnN6OUZNcnBO?=
 =?utf-8?B?Rk5tZ21kWVpsTXdKMFNTRzVyQWhZMTZoYjRsdExVWWxrNWtjcnNqcDYvblBk?=
 =?utf-8?B?aUNjVUMzRUc5eUFUZHMzTFJRakxUSGpWRXlCRXpzanNGZkRYUXYwcnFpUGFZ?=
 =?utf-8?B?Mzdid2lkM2V3anUwcU04YVZUaWZOQmR3K2ZCUlhmbEk5R3M4RWQ5eTliVE5M?=
 =?utf-8?B?bHl1WXg2TlNsSWord1JqRWVwd3FqL1YvWkFycURUMi9pTjNnTmhQT0tqL1VL?=
 =?utf-8?B?SExrNU9lTXd1NENkWDV3cXpTbUtmYVFHdjlRWmRodGx4RVFzSnAxdFlvbmls?=
 =?utf-8?B?VDd5Y05uektKNWxpKzVLRWU3dHJvNVFIK3BJa0R6RThQa29xUU4yd2h3TnEx?=
 =?utf-8?B?bWFuRXhmWm9TZ3VmRjZlckkyUzVhN1hQWmh4ZGorOGlicm5rMXh0YU5xSENY?=
 =?utf-8?B?ckRXaS9ZWnJDendYWHltbyt3OUZBNHdmaEVpQVZ5UmVWUjZaMFVBTHpPMkJO?=
 =?utf-8?B?d0FNUVpEblV0eWVqMW5WTVNObkdLU0RLQXc2dWYrVkFVMC9ocXBjVkNLQ1E2?=
 =?utf-8?B?UVlOUEMvd1VCdi9tbmwvd0doQ0cycTBWMXB4SHRVbWxyTmlaTEV4RThIcE5r?=
 =?utf-8?B?RW9EVkt0WXdCdGtFeFhzZUlIMTVFcE4xQTQ5SXBldy9PZjE0ajZLa2pPVnEw?=
 =?utf-8?B?aHF6UVFQSVZ3L1dMS2JIb1RBVVhpVDRRbUR5cS9jUWtZYTAvenF3b0RsMzBD?=
 =?utf-8?B?OGw5Vk5DSHNWVGFqaGI2QTk2L0VJKzA5dWNXVnlTMGw4SXQxM0k1elFFcWFq?=
 =?utf-8?B?MUdkWkhva09wRUxYZHkyZWpET09MOU4yY3E2WXRSZ1Zwd3FuVXBFOU1XdmQ3?=
 =?utf-8?B?eUdMMUZXa3JaN3RkbmJVM0RzaDE1Z3VSRFd6citkc2FpcURHNk0wUGNLMnV0?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9064dcc-ddfe-4aad-01d3-08dc48b71eec
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:24:11.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHJfBSug+6Ag7BLAz1PRlivD5Q9Qo+q3CcoDvB5vYDMwJvBPZMYIeqET3hkUPYfjnple3zBLQyyYtp8aouRKD3ZnkVmrrhiA4hhvtPFOh28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6978

On 3/20/24 09:49, Krzysztof Kozlowski wrote:
> On 20/03/2024 08:00, Ghennadi Procopciuc wrote:
>> On 3/20/24 00:16, Wadim Mueller wrote:
>> [...]
>>> +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
>>> @@ -0,0 +1,236 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright 2021-2023 NXP
>>> + *
>>> + * Authors: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>> + *          Ciprian Costea <ciprianmarian.costea@nxp.com>
>>> + *          Andra-Teodora Ilie <andra.ilie@nxp.com>
>>
>> This pollutes the content of the file. Please make them part of the
>> commit description using 'Signed-off-by' tags.
>>
> 
> No, that's not how process works. SoB are part of DCO and Ghennadi is
> allowed to skip them. Just read the DCO. Don't add fake SoB tags just
> because someone wants...
> 
> Nothing is polluted in the file. That's what this section you have (if
> someone wants).
> 

I apologize for not getting it right earlier. After reviewing the
information available at [0], I noticed that it suggests using
Co-developed-by and Signed-off-by when a patch has multiple
contributors. However, I could not find any mention of the 'Authors'
section in the file although it seems to be a common practice.

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n491

Regards,
Ghennadi


