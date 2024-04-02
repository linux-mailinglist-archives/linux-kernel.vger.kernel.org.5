Return-Path: <linux-kernel+bounces-128220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE488957D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9B71C22D68
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCDF12C539;
	Tue,  2 Apr 2024 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BH2fQrsZ"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2104.outbound.protection.outlook.com [40.107.8.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F148B60279;
	Tue,  2 Apr 2024 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070570; cv=fail; b=BC8eq0ql183fOXJJIfBzulpw91glTg1Xu/a6gU2+4TGuK19qw9C9rlwFTp9A1VJxbro21FMqYpH4UYh/K3SMNAt8klk3un2eypHp8LOsHNFrp54RG7yjXzdLRuRrGD4cDOF+etHk25VCZ7Cyzej3qoQ8/N/+SUn/d3F7f4QVM78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070570; c=relaxed/simple;
	bh=nxXMwz8vU2HiHuBz9Mjf34LDWpgKXc2NOrvAoJvlImk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HRM8zMRJ/nkAJdE+udIluVzRWxUjPufeppaE9ca95ZerSN4D1leO+m+RX44eky5FHA2UPt9j5pZ/nCNiyG01s5ENbcpiENgrMIEInzhBTouR8tHalkEXFwCZq8vK2I0MEcrwoKoqS1+Y8IgMlGD2EKx82xcxShS7riLMic518Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BH2fQrsZ; arc=fail smtp.client-ip=40.107.8.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcYzPkqO2hWF0NsgnB3loH3RsQVP4nHSze4k5ZiR1mnzvUs+BgBTiLZrPm2jfCO+ajMeEhQUdaoE/+6twzismZSkPQLjeNVrJV+PhhCKFdryZFxzEF5pEFrX8pySU4+uM6yOFcv9EJDY5AUCmXENkL1jJBQ1nEMAvbyGmfgliY/s8z0Z8PfGQoVXwehDGwqbOw4Dpw8Id2IT6rRHRWEhHWKM0SOiTaa6NJElZq50tNGof6royJh3VJK3NugoiQpT7RBrKgzxnYyg20QBlxO4QNnHt5lJvmm9cT/0YzqQZUpjwCX9hNnArqqGksOWlDDXQcZJpsxe5rEmDDkFMZrRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YG5Be1GtZEfSgWmk7lzy7tkGFRn1szv0bWWjnGkB87c=;
 b=ka3BtTkaY9WZF95Ob9wlAUVkLVPLFAGJ5vY704hfiBqzNKZRJS85rSisCIKGkaEN1Iq5qKou2RTFJT2eYE/V0rq5Onv3D1FDdSguvke0makt9aWoZhBEtaVK14sy6v5tmhEOUyClHw4GZZeSZHy+QGavGfWoQ2f9FW7KbrkLoNR95ghejkTmfCDYofRAnL9DOhXYElVo1/IcITCL3HYpalFhWdfryXyVdQRVem71cUkTMQMf/C0h1DvUe9343URyuD70ZySpZvsCOhs6+35SeIf7nKlKWBBrzX8tS/oMUf1sCF7A/aD0TmvLcWRijMY64w7zaspvKKKNcCZET3TRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG5Be1GtZEfSgWmk7lzy7tkGFRn1szv0bWWjnGkB87c=;
 b=BH2fQrsZmjqkieE8fTrb+her1Th3pyCFWQgUDQhYofUdU7b9NEC/0EiY/dRH+IQNnocTJfcQnZUzJiwJDehfYp1Tf1HfczvCl1pJJX34+ZFHS8wDjepMYc95Ky6BxbC9Q4sRlX4To8VJ6fm1mkMkB75FwSLoJirtrxvFl5giopU=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7624.eurprd04.prod.outlook.com (2603:10a6:20b:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 15:09:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 15:09:25 +0000
Date: Tue, 2 Apr 2024 11:09:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <ZgwfnZJDRYmYy7Qt@lizhi-Precision-Tower-5810>
References: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com>
 <20240401-dts_fix-v1-1-8c51ce52d411@nxp.com>
 <CAOMZO5AJrQ5jyV4A-tvX93-R0_nEWpEO9YY3f5DpeXaAFO4cSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5AJrQ5jyV4A-tvX93-R0_nEWpEO9YY3f5DpeXaAFO4cSA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:a03:338::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7624:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 ygAJ4SC+1oJK/yXXu1RWatLjMtvDZesjXhIVJkgKwMWwD1NK9YqvuzoWuJijGLqIwjmvLKCi99QwNO/p0GfKCHIxWLKfmxpSV1jr4mZayt5FU58lNzYSzqrVZTyXvUpOJyKCJNwbeL7xZxIuIXXaalAdXbA8ZKPHoWztiNE9OeGY3rUrPffRRk3tK3cQpsS9husEobkE5T/i/rwrdvf/xbgwVIhW8e8pib0NTa8L9MdGOvrQW0wpBD/FJaevL5lOcwjm2kq/Q7hgUZlnRNVQ3r1biyguHvGgjoZSOWAdxwKLaW0FNFf3VuoQX1KqwYszBQYCxlYL13+3cmjIpisfCSA8z8SfZHpca+n9HiZ82Q9OG5J3OKKA4p70zj4jEAGJizOeSbGxMUAKEs8elh10oNXk+XLLYaPyiPwQKnP92ztBdPMnRrTOZsdKd51WLPjP7LEWzDBGwQmnYH7y/OISLpY5xRSPUZi6kQPyfVqw3peB9kVKcTZLB+YQEID2aEC7OrC2aj0HFEF+8VQPO7Q/VrEaOTXf3jGAHlGMzxuMJkRwUq8Vo5QHKjHgZRHrPn7pAFh9UI50ItNaa7gXZoqjZlPsozJs8cx1LfGHXzoLit1oTWolj3s8OzMvTltxZ1HXSxMQmqV0gIyq6zES/qGV+DqWb0H06hAsQuIGxwOuzITaXBvgNDk5M6pfhuUyQCVpWyEg3sttiXZWgYhhFkOhgllwOFolv9tWFupPWKC5/bk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(376005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NEJWU0JmYmFsVGlWc0dva3RKdXdoc2VnclhBQ1kxb0lKWVpIc2x1NTZOYzRN?=
 =?utf-8?B?V1FVVzBhZUo2T2JTSWkyUGFSS01hc3ZzaHQyVHUxcjBBV2NGb0VQR0hPR1Jz?=
 =?utf-8?B?bXhldktqdXZsQUFnbTdFRWdleTBRemhxNDZqWWhrRDJORnNIenRjanhxVHhk?=
 =?utf-8?B?WnVNU2k4VXBETHU3d1RkdjcvZTYzd2RoNFBLYW9YY0RmVVdUdEUweXBnOFFx?=
 =?utf-8?B?dHlSS0xGRWx0RDU0VktnUUZZRUFGOWptMUtrbEQzL1o2TTRyc3FWajhxK21O?=
 =?utf-8?B?Vktxc21wVHJtMDBrZFlsdmhiaElocUU4UlUycTZtTlpjQkNsSkU3M1ZVZUFW?=
 =?utf-8?B?Vkc1aTFwN3VvalZzUFVsaGZETGRuWXQ0WVdNWWwraVl4QmZVMHVsa29zNFdo?=
 =?utf-8?B?N3lHVERxT1dYTEVKUjRiYVhaM0EySVRnMEs0MUJ0K1c0cTZSSGdFWTV5eTVl?=
 =?utf-8?B?SWRCZkpkWndEYmhtbTBBajlmdi9XSUs2MjZYVVNCWWZQbSs3ZUcvMHRuNjVK?=
 =?utf-8?B?N29vNjF4ZENjS2FRbHpXZzhWZDRkaUhoTVg3Yml6OHEyUDhlM3djemplbXZk?=
 =?utf-8?B?RllUUkZ2TEtwSXlQU3FvUFpLakpUVUQ5Qm1rR3Npc1VVTnZxK2ovL2ZmV0Zy?=
 =?utf-8?B?NzJvZGovTEw5RHByRUpoNjhzeDdQTkljSk5NOFkrUGVMM0R0ZVlIY0N6UEFB?=
 =?utf-8?B?N25WbGJCdnhYUHFmZUMwbWNNVGtjS1d4YXlBMjFWcStYSTB0OW5lUnE4ZWNn?=
 =?utf-8?B?Yk1iTExmdWZVV0wxbXp6WklLM2NOSFQ1NGgybENsaUg5bTNkR1dOc3J6VXRh?=
 =?utf-8?B?Q2IySFVvWXNpUVRwYlFJejl2Mk1VaTkvbGRmbzhHS0oxeDcyMlhGTEZaWnNs?=
 =?utf-8?B?SVY3TWwwY1MreVNTSnVjMnBvNFNoWWJwL0phOGRHU0hUT25YZlIvVzhmWVhn?=
 =?utf-8?B?TTdsU0pPTUR3QXNSM3R0eXptRjl4aU9xeCtsRjRtNkFrTUZFZUJFOGhYUlJn?=
 =?utf-8?B?UlM4VDVOVG5tTU5UU28vVkd6ZzRSMUhZeVJlY0Y3K0ovYUlvUmxSWCtsejlV?=
 =?utf-8?B?aG1SRW0zcUpUQjJxclB4c2h6UEwwTlpFV1NNdTB1eTI3aHVPWjFRSkNWZjE5?=
 =?utf-8?B?S2xDVHJRRyt3ZTRWcTFFVWNxOE8xTkFqaFZ3YnVBeHZZVFdoQzRTUG1pMFJl?=
 =?utf-8?B?Q1cxL3pkYmMvWU5NU3RHRzkzNEJBbTIzVmVoZlNubUR4U0lZS0UwODlNUy9R?=
 =?utf-8?B?cGd1MzRCL1lvc0RXWHhjUUtIOTZ5U3BnTU5KcCtrWmh4a0NuMC93d3pJSkJB?=
 =?utf-8?B?a1kvZnJOK3JOVUhFQ01DclVIS21iTFlEczV6cGZkcXBaOUQrSHE2V0tWVDlN?=
 =?utf-8?B?amdDRXB3dnYrVllzbXhKcUUrOWwySEtnQldZQzB3Y3BlLzJ0VnMxUFR4eFBY?=
 =?utf-8?B?QWppVGZBSGVQNUlGbUkxa2dQWXdrUGordkFmYmFIdWc2VmRMRGFHUlcxUHdn?=
 =?utf-8?B?TmkwNUZpcERJWUgxajcwU21ldFRwYVhnbjJTZXljWktWSitVdmhPMitXMEpn?=
 =?utf-8?B?YkNlK1pFQVNmYTl5d1JCWm9zbktNb1p1YVJrZjVWZUhXQ24zR1l1MGxtWTFv?=
 =?utf-8?B?c2dYekNNQmJkSTBDcDFTMVBKL29RNU1TUnd3VXFpNU5LcjlqOFlVQVRDQWZa?=
 =?utf-8?B?aWlhY1ZWSUc3UTNCVjEza3J2a252elYzWXBvY0l6NHhjZ2c4Rm01SzBFNmlF?=
 =?utf-8?B?R0g3dHZUSTIrTkFwMlRnZ0VYcVlBa21TWHVBbmNIOHVPNVZDRWVuY3l5UXlu?=
 =?utf-8?B?cTN3Qnc0TDhLZkZrQ0lhQnM2ZGczWGVOeGFTcndGeTMvdWlQblg0QUpRUkpS?=
 =?utf-8?B?bWsybHkyWUNsWG9ORTZzbUF4VmszNXNETWRhVmZLT0cwV3NzbVN4ZnBZZjJh?=
 =?utf-8?B?Z0dnOFhlQTlwWHpNL0dXMURCT1ROcW1MV1hDS0tFSVVzZ0dNd0FnK2ovMXJm?=
 =?utf-8?B?bFcybmYzQU94TTJubmJrT0lpQUlaYzR0Vmk3Qnd1TFUrUk8yOTArY3pkSWhy?=
 =?utf-8?B?KzhvTWF3RDA0aDlGZWE3ckF5TUN2Um9wemhwRHhhaE01OTZ0US9jTU1QV3Q5?=
 =?utf-8?Q?Im+6Awh+sQz3iIEpu5nvcUx1I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64f9367-a590-44f8-47b5-08dc5326e2b5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 15:09:25.8411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nN4Sp2jR/mQtSZGwDkm9GFDTX9pkzRwIYUqMK0cPLp4aESRAu4Bzue65spA9UIqKC+JFvpq/uqwhYvKBZc4Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7624

On Mon, Apr 01, 2024 at 08:04:56PM -0300, Fabio Estevam wrote:
> On Mon, Apr 1, 2024 at 7:25 PM Frank Li <Frank.Li@nxp.com> wrote:
> >
> > lpcg's arg0 should use clock indices instead of index.
> >
> > pwm0_lpcg: clock-controller@5d400000 {
> >         ...                                                // Col1  Col2
> >         clocks = <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 0     0
> >                  <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 1     1
> >                  <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 2     4
> >                  <&lsio_bus_clk>,                          // 3     5
> >                  <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>;  // 4     6
> >         clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
> >                         <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
> >                         <IMX_LPCG_CLK_6>;
> > };
> >
> > Col1: index, which exited dts try to get.
> 
> I cannot understand this sentence, sorry.

This base on downstream dts code.  Downstream code use index in 'Col1' to
get clock.

For example:
<&pwm0_lpcg 3> means &lsio_bus_clk.

When someone do upstream, miss understand or omit upsteam lpcg driver's
difference between downstream and upstream version. And it also work even
index is wrong.

I realize this problem when I try to enable audio device for qm. The
difference cause audio can't work.  The grep lpcg [0-9] to find this
problem.

> 
> > Col2: actual index in lpcg driver.
> 
> You should not describe DT in terms of Linux driver.

It just descript the actual hehavior in current drivers to explain why it
can work even arg0 is wrong.


for example: <&pwm0_lpcg 4>, developer intent to get 
	<&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>;  // 4     6

but lpcg driver device device arg0 (4) by 4, get 1. So below clock return
	<&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 1     1 

Both it is IMX_SC_PM_CLK_PER, so pwm works luckly.

But correct code should be <&pwm0_lpcg IMX_LPCG_CLK_6>. 


Frank

