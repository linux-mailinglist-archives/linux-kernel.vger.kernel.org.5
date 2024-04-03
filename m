Return-Path: <linux-kernel+bounces-128990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D3D8962CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FA11F21F10
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D641BC59;
	Wed,  3 Apr 2024 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gymTmjxF"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2092.outbound.protection.outlook.com [40.107.13.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9081BC3C;
	Wed,  3 Apr 2024 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712113823; cv=fail; b=W4BuZKD5NFb8l8NyIGrp13il/CmM8ia7JMjJZwR2WE9n9RGVL4YH2nBmucu9M1uckKMFB1l+3qC2ilIA3ymecv/W6loshMJka07hXgHbXlacvHbxZd3mlTpwZFLXgtBQjvVtiVdrANu9rJN1uNzK8JZ9BlQWWuqcuRVVlf9ts30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712113823; c=relaxed/simple;
	bh=FoxuVWU4lAmf64DUfEmugTPF8a4thxFv/ceiisHrRcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aXpDYd3mzCdQYWIY+sl/7IlDsXghlHsilnM7LJf9tcX4Ni9dGOM62Jfws+ZMDWJjVGuPJqGyjkL+QEIE9MfcIu+Q+ehnVcdtU1iJ/f3x52U3X4uTJUH0kaj/guQL6GDi71YDCnmNSmnwpSRAfaxwL2PEgrdidXYyekVBW58TLJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gymTmjxF; arc=fail smtp.client-ip=40.107.13.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0USEYACEpGccKphnoLmqavdvAvls92Uvw0jiNOLpgAekRT60zoeMSoTkTU7Q5qMz6mh6B376u/DbHgO9jgh/YtuM2IGDQwdcNLNLirKVo8Hg7+k62A+P7/gV/mP1NIJ0H9oeDtq6UN8skppppwBMZyGx4WVHF/8MXsYkTh2OCHt9Cpr0cJkaEdrM3FxdlDLxEVEpRCH+ucyCy+y8PCRiQRXv/ccTRKCKi1sOf0XVK/B52FAKXkw5G/Gmfdvx0+jd1sPBRu5K43SAYqj4x9hEe4xCZv2IJAnwVnBLRJdKbxhDDSOPjEb3iRfN1W8BmwSlWCMGoo2qQUdiJ/nb90szA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oc9nUukTLQY/HfJRneUxUWYCwStETjar/AS8FZXsL0I=;
 b=HA9O6GvD9OZW/v+1QLxM9paAmN/o94URf4HHBhTxoM/JdVtUH4FyfOwyY+J0UAbdhKNe01kyA3kLQtoST4L36S3jHv0Uw5ftXUDg7UV+HkNtCjNj/vWpK0EpZuO+T7e67RwJy+owJ8/YKR6qs8ynqVpSF49R9EQy73aMosWAwrMKWDwDHKoKDJoaxVmQxlpDNCiSiPUQNXqeDYSa0PHaXzt+yb4QGQJRPJJkuKa+cSACOYOyx/aJySu2rWKYPcD4cyq7JXsQijKOdu+fIjXUo8MGjRMgoNqdKiIyJATHr1c8P3AXm5stja1B4OFUDT5mScrTH0J1bOdunnKyktQ7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc9nUukTLQY/HfJRneUxUWYCwStETjar/AS8FZXsL0I=;
 b=gymTmjxFHSV3s9coH+3EuYk2GStiEB3kCkjGQbFpTkA1ht2hdZbyMg/LI86rUMXlFkpRwvBUByxwik0cRJThq+8xPSfSadfd2SXXvKlFnE3E6S4HouKaAxyA24p+7McjhaKJFRy0ykjbKC8qG/O3GkXHr5EGF3p4nRfSUILjl0M=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9227.eurprd04.prod.outlook.com (2603:10a6:10:352::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 03:10:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 03:10:17 +0000
Date: Tue, 2 Apr 2024 23:10:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Max Krummenacher <max.krummenacher@toradex.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Joakim Zhang <qiangqing.zhang@nxp.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/7] arm64: dts: imx8-ss-lsio: fix pwm lpcg indices
Message-ID: <ZgzIjziArPh8wnHA@lizhi-Precision-Tower-5810>
References: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com>
 <20240401-dts_fix-v1-1-8c51ce52d411@nxp.com>
 <CAOMZO5AJrQ5jyV4A-tvX93-R0_nEWpEO9YY3f5DpeXaAFO4cSA@mail.gmail.com>
 <ZgwfnZJDRYmYy7Qt@lizhi-Precision-Tower-5810>
 <ZgyzxmuMIK87C2nW@dragon>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgyzxmuMIK87C2nW@dragon>
X-ClientProxiedBy: SJ2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:a03:505::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9227:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 hnZwt4Jw12sMuj4Wq9B9LINpnMQaUrGTnxF2Bxb0YBCT4NpD099U2ZPEmxTQ7S6HWIV3jukBCSnP9lWql6Pf7rukZ2/txWoXfhwWbqlRP8NAyAznXO/IG1UPeiBmimG3g2zHY0eTdqpbA9BITtT57f5ra0qM03sshQdSh8w7RHjw+Q6NmMjwaF+y7IXz+kRbvyOeXPcBAMBEygT2NEZuVxYUcdgeX0EMQFr7YqPer5txChQ/AfKeIubQsDPvTFijXYU7spa8bA2hNWb9rMfMYZ+hJgfk5rnM0fp7ZsPnxVj0xPFESr5U3VvCE+PEWss/kWcXmt1gS9VS22WOzE2J2ZRxtMDEfPY1yAvVf3ODHMK6VcVClm/GFcjZO6Eu/AgJki6mvFGX2MuBD6SJcOEP1Hren36+dp6btnoJ+J/njROk8dZF0SwU/0rVKSBcRLKLTJkJOyl+8BRZdUpjJbNcBZb8fs3veVShMC2iMSTguU31QY+WJ2N6cAUtjyUfNvGLWqWNzvnwTM6EaSjeEAnQCRzDWqXndlFZR6tKi/MCP/LDffY/lmLzRtARY7NO8fBwvD3eMMiHpZjfnHstwRYeE4n2d8wYkKJjlrvk/+oCLDYXsGa/iqRQSfXePEs5u/rfexBeSICjCOhFJpN2/TOo3qvFUWcLtWBKZGwOLYT+JI7GiFrwG+KerQe1VmwEYr/cHvvxSYp7bQWKgfPaGj92aHud2D5X6GjjdR+xfM2kF1g=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dDQ1dWtteHhZWVppUUR4QnVnR0VGTS83Z1I4T3hGUmRucXBldlFHeHg2UVZt?=
 =?utf-8?B?c0NOQTdxZHhYTklkRXhxQUFzS3B3RUlaWTcxVmNTKzBaMlJSRWpPTGRjZE1E?=
 =?utf-8?B?S1ZWTTFDNjBHM1pEQi8wQnRoMEZjLy9lQnpsY0p2MGlEalhTNzJSbU96L0FV?=
 =?utf-8?B?eEY4dWhDSzcvUzNSVy9IbndnNkhXQlJ3YVc1REJ4T3FkendsYXVFWklDWWVt?=
 =?utf-8?B?K1NzOUwrUjVESCtxMndXa1lvRFV6cmNsQlo3blJ0RGxYekhGR3gwL3o0YU94?=
 =?utf-8?B?VFRWZm0yS090TVVvR2dPL3NSUXNGbGt5RUVRYVdqdlJRMG5YN09HcS9mV0dy?=
 =?utf-8?B?cjNZU3drb1R0aW5lK3pXakNnRHhrK2hzL2c3eW5zZEphREMrdDNoYldzejF6?=
 =?utf-8?B?Z1dtbzRIdHNTbTVQcHR3K1JzQ1FhTkVjMXRsczhkOHdhOHBYbEZBUnl5cGQ3?=
 =?utf-8?B?cVJrNk5oTGVxckgvcHNhUzQ4cTQ4T0Q0MXVIakdOa0xzb0k2OHZXMTV4VjhK?=
 =?utf-8?B?TlIxOE1lc1NyTi9DeWVuN2xpTkpLR2JzYnZha0lzOVdyc0xvbTFpZkV0WWlX?=
 =?utf-8?B?cWUzSyt2NlVRZ3NXd1JHSzFwSzNSaExmd2NlWWVrT1RFT1k1cFBTcDV3Tmhr?=
 =?utf-8?B?WWZ2YWFCb1lxVlM4UXByMEY3R05hSW8zMVRvVFBvUXNxcXh4bnJWMklXRHVp?=
 =?utf-8?B?bE01WGNUOUtCMGh4QW9ZdlduaDQyWTB1OVdCZjk3azdVVi82SDgxcmtmV1BE?=
 =?utf-8?B?WjVrd25kQmN6VnpSZzdmZHVwSGs1WloxRUNZSlhFcDNyelRRTEJCK09ZK1hs?=
 =?utf-8?B?czJEV0pUWkFFVmJmbUlzOUtaWUx2MHRyNEgvbUNIcitzUFRWNHdHdlNOMk9o?=
 =?utf-8?B?NzA5NTBxSlRhYlczUkppQTRDdG5yQzRjRXQ2VlRVVmhqMGdTVm1WaFRlaFIz?=
 =?utf-8?B?S3BweHdRR1dTNjJVR2NTclNuT1JmQzYwNWZOSzFjcFpKbUNrU2tsRWZBU0tM?=
 =?utf-8?B?V1hRaS91N2ZVTVN6MUZIbW4vdVVpUFhxYklzK1k3M3lCU3VJK3MvTFRRQXpX?=
 =?utf-8?B?UFZmbjkrZnIvZkg5UW1yemw2SU1WT2dPbTI0SENDdk52RzRTR2dGZWpDUDBs?=
 =?utf-8?B?VncwdExUL3RxQ0FOQ2RDd0RUd3oyQWlBZklvQnRqemdGd3ZySUxyMm14ck5V?=
 =?utf-8?B?TE1hU0JrM2lUcEtiZVBOVWJDcGIxdGZ3WXVGRDNjclJxditMN0MrdDdzV3RL?=
 =?utf-8?B?VmlFMDcvSnVicU9wZm8xYVBvVjZZSHBUMDgxYkZ3MndKT1ZoamFVcFArV1hl?=
 =?utf-8?B?QklocVFtVUZjSmR1OFIxd0JaKzdEdTJGM2JFdzRkV0tkTFFmUjg1R1lKQUox?=
 =?utf-8?B?THJmSUVCRWtqVXdNdUNCZ25KMUZFUHE1dE5TcmJ4eTVqMzVvYU1KaG1BSWJG?=
 =?utf-8?B?UER6cXY2cHczUVV1aHVQdWtGK252dnZtVkJnS1BPQjFHaitHMnEyK0ZxckhR?=
 =?utf-8?B?NDljVjFETldQYSs3UGl1bWlTbUg2WEtYNklZbnlwb1FnTHdYN2lGWlBURHlr?=
 =?utf-8?B?MkFIZmdWa3F6ODRiZmtYS1dUa1ozaUdTVGprVDBDblpzQ0N6bFgrR21BTDNC?=
 =?utf-8?B?QVMwb2FxZE1BSm9oQncrdDZrQnlsZ0RDZ0pRTHhNQjlvTWdSa1EzTXY2ZmE3?=
 =?utf-8?B?a21kMG1pcU1UQnN6bnNxaHdmTXRJQjdNUHZLWVJ6Qm1MMVgvK1BNQUxYUTVn?=
 =?utf-8?B?TDVONnpVSjF2VG1wOFBYRTRQYUdqR2p5S1RyUldtblZZZmo2M3Y2MEhTdVpF?=
 =?utf-8?B?QmdTeHVsSzd0UGM3UXdSZ1c1WEdLcFRTbmdzVWZTU1Y1Zk5LdWhLN1RZZ3g0?=
 =?utf-8?B?TFUyQUZ4eDJ2K2lLU1lKZ3IxUnJVK05UNmFGaDYzUmdmZ3RGbTJ6d25ndFg0?=
 =?utf-8?B?UTZxb3l0NmNNL0lKT2J2dmE0Vm4yS1JwREhIalBMWUs0RkZOL0x1V0xhR3ZO?=
 =?utf-8?B?ZlpjMkNyTXkrTiswSEVEOUNMejQydVhMd0lRRjQyemJkUXhrYklHYlMyd1Vt?=
 =?utf-8?B?R1J6bHBpdkxpYjFKaEtLSXRPL1VtUS9CY1VHOURRVUcxNFRIWW9qamRvMWln?=
 =?utf-8?Q?M40ma4AJ6cAtwH/hcu6syxn4p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3db6170-68ed-4e57-0220-08dc538b96e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 03:10:17.8788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INZHysp6mSFcdNSTRVKmsQvRcAWOn2Fi/VgZzkVf1FY9PdVEHgkd+IzBm15qXUXrv1cTr52yc976RxQlsV5kQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9227

On Wed, Apr 03, 2024 at 09:41:26AM +0800, Shawn Guo wrote:
> On Tue, Apr 02, 2024 at 11:09:17AM -0400, Frank Li wrote:
> > On Mon, Apr 01, 2024 at 08:04:56PM -0300, Fabio Estevam wrote:
> > > On Mon, Apr 1, 2024 at 7:25 PM Frank Li <Frank.Li@nxp.com> wrote:
> > > >
> > > > lpcg's arg0 should use clock indices instead of index.
> > > >
> > > > pwm0_lpcg: clock-controller@5d400000 {
> > > >         ...                                                // Col1  Col2
> > > >         clocks = <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 0     0
> > > >                  <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 1     1
> > > >                  <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 2     4
> > > >                  <&lsio_bus_clk>,                          // 3     5
> > > >                  <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>;  // 4     6
> > > >         clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
> > > >                         <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
> > > >                         <IMX_LPCG_CLK_6>;
> > > > };
> > > >
> > > > Col1: index, which exited dts try to get.
> > > 
> > > I cannot understand this sentence, sorry.
> > 
> > This base on downstream dts code.  Downstream code use index in 'Col1' to
> > get clock.
> 
> So s/exited/existing you meant?

Yes, sorry for typo. 

Frank

> 
> Shawn
> 

