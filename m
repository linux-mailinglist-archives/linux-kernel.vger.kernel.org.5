Return-Path: <linux-kernel+bounces-163242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32328B6792
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1521F22DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A223179F2;
	Tue, 30 Apr 2024 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fq0uW/uT"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94617589;
	Tue, 30 Apr 2024 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441193; cv=fail; b=ODqcvRxJHOYJ0bgQ3a7QW3KzhudQNY9XMcp3eCy2GXCz73s4y7nRhjuxUCF2LKmHf2dFgIJLh3oNhLws2v8Km68ZYrYM56503UTIetqGlFb1b84eAK9QtTtZv2gEk99hRikVXSKebo4cvjTb4JdXWA5a3gOBA0ulvSzfIN54J1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441193; c=relaxed/simple;
	bh=3TG11Y5362Pn+Kkiaezkt7rmBuee6uO8T/RbrqwLFdA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XQ/9lYDqYTHvvWybdLnrmfS7ZU1MiwnXrRHDpqbhpQYpsDFeDzNPR+4V8MmvnE1oLQtpFW7FQQ0soIEChiu0KUgkKVysfNtNOi/W4LHkC/Qzf21AdZ0udlwuvDlcub2lKLF3nk6MfjxmS4ofg/2FjYM4l7w2yE9VYjFXlQJHXNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fq0uW/uT; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0wOK5NxdjyYihDHXMyI6CanTQyyK74OruTk3SklD8+CTcgyC6uFJpWtck3MRRH8G/HFNAgzVAwES+BmW/32jrgDWRdQgrqAi34mKUPTRdO5ERwCvDNaCKFt/UT7bFxBgxqqAE4azUhiC3AX2r0Yk2La5rHvQJ7Lx5jBrFHd9ghkQiLMLvZrWHBvKkdoqBKRFv8POs7uaO7yUskkdq0Zwl+9dYrJNuR4eaLYVCdBciH0f3tWNM3RtWfDyz3wAp23HwyzfzyRXiRq7uZJWkOtfae5GK+J1I1O0qWO8ZJUpWmVAyUFsJnLcEdZFC6QVIavIl2h8hGaLw7gaxeZTCkCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OV60ASOQvGKlGOntWp8as3zMVvxy94SIr2ZRBlR1j/I=;
 b=NGKCfBIelfx+iNEhdAaXwAeZbJk4dYyFZFxKKujqbjT3sNNRiCpo51Y3MLwpt4so5gMrG1RW51eq1AMAG6tpYcg2Jo2J03+i/UiETV0BebodNcAq2Pl8M2e4kLEBB23Aao5yYyI4NeEpWDofalk0MOrOOpI8g//oBfjcqLxlGIwbynXqS7oReLNdtXzEbdlMD/xn3DBzaYJ/uzoTtQxAWrUhI0F0hCyYXKVbY8yTlLyBzL51kR9baok9U+U1FiAE6sJkVYsIciN6PbCJJg7z+qrmRxmXoLdDo4phw2b3Ni1eWmeb9ne3F3Hf/AYQjB28XbPkDQhMJZPX8PfPBqXpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV60ASOQvGKlGOntWp8as3zMVvxy94SIr2ZRBlR1j/I=;
 b=Fq0uW/uTxqIRv4Bx9vENVAMI4IS88Hu4PX42Dsbat9EoyVkAWIgyH43lb9z9T+RSv5fJTk0NMMVdv8EgwD3j1RuHK8Hlo6Pcg110sMI8vOlX1cVD4d08eSVAjLIoXJjRE6irjBvJGpueIbI8VjbDf1ZWV2J39VKolKqUKFGranM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA2PR04MB10088.eurprd04.prod.outlook.com (2603:10a6:102:40e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 01:39:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 01:39:47 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "S.J. Wang" <shengjiu.wang@nxp.com>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: imx8mp: Add delay after power up
Thread-Topic: [PATCH] clk: imx: imx8mp: Add delay after power up
Thread-Index: AQHalvygsYYcYJKLo0CfIP23Iyu2xrGAD7TQ
Date: Tue, 30 Apr 2024 01:39:47 +0000
Message-ID:
 <DU0PR04MB94175AA9D4AC236DF3C35B64881A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <1714040364-17127-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1714040364-17127-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA2PR04MB10088:EE_
x-ms-office365-filtering-correlation-id: b24a7f1f-e10b-45d5-55af-08dc68b66b59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|376005|1800799015|7416005|921011|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RwFfRC3XeaxGGgSK3Nux5GwmbJcyRWNV+CEVcn5SZgeCE/iB2GGmkc+Gb/jf?=
 =?us-ascii?Q?AlPZi6XJgSI53AkZbJQ0Xo+GJNsyLTu3VkxQWf3y5ba4V8f9HOF9AXz5twa+?=
 =?us-ascii?Q?XsnkcfXvvAltMrne2hnZknjsHW6Vyn4IVjrWa0L8aA+WMOIsJUpPLYEMLh8G?=
 =?us-ascii?Q?BfaMRhwAKdXwFyvV2GKEDW9GwLv/gIGBaEhk5m69KA3WulTsSZzCSl8y2ExG?=
 =?us-ascii?Q?mHw0QawJmHa3lkvb7aEwbykYC8hUrAveUph+jw7rimZUiwl4j8wOVrmeo81D?=
 =?us-ascii?Q?ptB3Yf1IEeGCYHK8PxNR4YtQBP39mGDpZpplayLf4C/JH8h+AyIEE/RkW7ay?=
 =?us-ascii?Q?AQMLTMyTyfJKTtoeDgYdBDJ8ANuxqCImRwseZ0zxfQjSTKzC3wVgpt5fj0kq?=
 =?us-ascii?Q?ZnBJYUlzdR97P1mvIE58rPjMsMulViv4Lxyf9v02vlsZt66/AbPLrbGCe52H?=
 =?us-ascii?Q?AIAK4YMQDFJwZB+xhn7cvCDXnUPjABIgRTkJcoqGIPfnlMuWFH+WPIv4qZxw?=
 =?us-ascii?Q?qejv0orG1co04VFKYXRH2eerLEbgMEb9B/4/TXhVBoFZMpM6AzyimoGGk556?=
 =?us-ascii?Q?aS4NPugVU4bwC8mTVcSTKIO61FtBAXSAhYp44KTC4FRt/HVgIOE5HH1CpGSJ?=
 =?us-ascii?Q?lSFkSRODT6zjbW2oFfMz0fAWzgFzfuGguHMxAVMVUvCRAFpBn0mskQm4oLwh?=
 =?us-ascii?Q?4/kCgG9o59jUzA5Rj3EKHrqFefwYRDWC+gycVVE3/1w70NCYIXQT7YhYKkRi?=
 =?us-ascii?Q?SIxd1dNGmrmmam2NATXAdN1CV6w5KlanHuntbGo/BYWjRmVTXk2MM+WpZzb6?=
 =?us-ascii?Q?zwSw0aCy6dpJhQqtQ16g5uYNo/598QCro92MxEI1SCCJhbZVHl8ZYFeYHRmp?=
 =?us-ascii?Q?9tlepgygxpJLRtu833VbBnIY0gedUg4PMGXw5Nezj1iNG2fXpCy0/qPqFyZD?=
 =?us-ascii?Q?3wpXzkdt7bw/ZXNgN9a9hZHhwpCs3FHRL5PJz7q0D0I0Ob6V0iBczMnQKP3Q?=
 =?us-ascii?Q?oHeard4Q8xGTKv0FV7QBzEsJemXsiNNV6mZQzylFqBo1nUc21iSwx2fx6IE5?=
 =?us-ascii?Q?Zq8JGrhiL/Qg63H5LUSEN5n/MDfmAEtTWy31Me+Jcp0xY6RxHNFb+DjGzRoK?=
 =?us-ascii?Q?d9lj1h02sOzM56fEh8lEI5zu9W20RYaKYVbK+wzy9BioXyCEvC4HsLLnHWyg?=
 =?us-ascii?Q?ceP7h4ucfSPZzqjWVUl17VCyM6ADrY9Ut0dXDtxaZ5pJAeUzz/ruSMqPBM94?=
 =?us-ascii?Q?5ew1TzZq2yaT15Gl/MlKNKE/t1ADZoqgvWGs6v+L9a/pjUg2R9RmygOyeBr+?=
 =?us-ascii?Q?r6P6KR+NDtk4h/zPtbubN0NR8rA0s824iyRn2TBMfAfp5BENGWb439oAZm+Z?=
 =?us-ascii?Q?iG7SpMY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QTEJoYp30UJxsjwsWAc8RrRyj1nVubRHHSfrx3omUqHEy+iC38z4VsGswAK6?=
 =?us-ascii?Q?BzLR+EDmIto0FJWp2i8+3qjg+r5Y380ThCrWm2A6wJwCJDVSjZGktFUhcYnV?=
 =?us-ascii?Q?jxSPQyagkrihC5Ds3a7SrnTdVb4NF3Hn7vPHgBnjB4q6gi08Ly6t1N6vA6Tl?=
 =?us-ascii?Q?IQGTdQXSslhFqL6s2A+2hRmH4c1Yzvpl6eLja4hYY3de4zl5TmQGCG9DSibi?=
 =?us-ascii?Q?rqu70CW1lN2qkPnow/Dtkf7vqT+BtY5WUgz+mIj8NaNWeynRK0BKMa9PD/RY?=
 =?us-ascii?Q?3UVCrNTG5kj/8vLvbNFvP0u6AdpWlJkJ8u5STl7/o+HNQE4T55w4ysH+xblU?=
 =?us-ascii?Q?ALi8XVY5C9utDCtFCoLm2BgmL8Wi03ZYFf+1GIDpt/bkJskT8relc/I4oe5e?=
 =?us-ascii?Q?ZrLLiZMC/6UuAaNG231qGqIxAkFgm1eLBwenR+v7tds+wLT7DANrWf+Evijy?=
 =?us-ascii?Q?SpizZBb7vASVtS66mwIkkyDChD6OUrP2rBQltYZRVDI1AEZYvJo6vGc4dF8n?=
 =?us-ascii?Q?p4MT/Gnuw5EJVt+uOuZsGzXb5Me/YBVItkaqmiwx0IMEm4LW05yD4GUECZxX?=
 =?us-ascii?Q?tGJDfYl0pFVVZXktUz50sEhHen3Hytvm4uzLLt1vMNC0jCjxZDVviJmT+B7+?=
 =?us-ascii?Q?XHpen4lKrcT+Gub2IPiljVXsx7s1LUbvdJyOVH2yhVTC+BuYTncGmGiJA35x?=
 =?us-ascii?Q?QlNaPA3ANgFXvHDR13ZfZeuh80tV3qPe4tkSvGQ6lIuIlMlUaZwpf6YB1fg+?=
 =?us-ascii?Q?Ggt3Ht0Poj2h/i7GO4oX+Mc/oBKXDjid4ad0WbCrUNkChi8Nulac24kZPuIs?=
 =?us-ascii?Q?Ij3/St2gRqQgcofaebuaqe1gMbjfyajUJjuNrgKuWuK2Lf4aHCClRJ8lm3yU?=
 =?us-ascii?Q?AFJm3E8743AVsJ3zoCI0I8VAVfjolCFGo5KyrUrnAcSuUyTgw/DSykB0mwbf?=
 =?us-ascii?Q?1VbuIc+dVazcIV7MAOHFvJktDbnyq53b9QFvtzS+fn/6fX5i+w6yQa/Jl4Nh?=
 =?us-ascii?Q?gID4vM3OBLqgHzj+j+K7wIqE5sXRU6LAurwNPiM8UIPbKd/qNiCygOjjUiGz?=
 =?us-ascii?Q?iI3rHdFJkVKx0m1xMsLPVt+a+tMQtS6sUszt5kw88j8tlm4wp59KrL4ga5/J?=
 =?us-ascii?Q?lG6nH4YuHpCHyAcqN/BBZs65l4s4DMDT2gpOW5IKfyshPS6B5rQdd9RIE3RJ?=
 =?us-ascii?Q?7bE7HpdIEf3+YYCtkt2A9HqTBfuUMVewyzfyHc+gGRoFUu+PRi+CjmLSIgFT?=
 =?us-ascii?Q?HlTG93JaVv4T5XdLemDc85JOXu6CnWQFPQDx1kVdfAh3HjWQ1uevU8IMPpFQ?=
 =?us-ascii?Q?D1eY2cyoQkALcNmYAgqRY0V3Iz1b+O8uj+pQM7gMCI86x4Jl8t8NjlJCEATN?=
 =?us-ascii?Q?uN/EdsVKFVwZ7sOZkCvq4PKgVGKPHvTGa/lepfEGtPSJ7DumsDoVsG7KhcfC?=
 =?us-ascii?Q?mzVcT6CUqa8XocZcdK2AucZFvJEAaU7Rdi+GSPKx5ZNW++5/ZyZUsqIjELmQ?=
 =?us-ascii?Q?o7J53dsz8bg8SifvorxjzZdqhbg0t1C5+xFnP3u3YNq711KaorQ/Jnp0Y0Ng?=
 =?us-ascii?Q?Gq7utX1YW5Sx8XjoLHI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24a7f1f-e10b-45d5-55af-08dc68b66b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 01:39:47.3740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Aor0ShVcOvUbhIE8c2bqBlBYNqGh8ZDXHSG5uRfn/rbX8O8oWov11GUVeUOzaK1T8jcJwvXfJ10ysoXPnvsQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10088

> Subject: [PATCH] clk: imx: imx8mp: Add delay after power up
>=20
> According to comments in drivers/pmdomain/imx/gpcv2.c:
>=20
> 	/* request the ADB400 to power up */
> 	if (domain->bits.hskreq) {
> 		regmap_update_bits(domain->regmap, domain->regs->hsk,
> 				   domain->bits.hskreq, domain-
> >bits.hskreq);
>=20
> 		/*
> 		 * ret =3D regmap_read_poll_timeout(domain->regmap,
> domain->regs->hsk, reg_val,
> 		 *				  (reg_val & domain-
> >bits.hskack), 0,
> 		 *				  USEC_PER_MSEC);
> 		 * Technically we need the commented code to wait
> handshake. But that needs
> 		 * the BLK-CTL module BUS clk-en bit being set.
> 		 *
> 		 * There is a separate BLK-CTL module and we will have such
> a driver for it,
> 		 * that driver will set the BUS clk-en bit and handshake will
> be triggered
> 		 * automatically there. Just add a delay and suppose the
> handshake finish
> 		 * after that.
> 		 */
> 	}
>=20
> The BLK-CTL module needs to add delay to wait for a handshake request
> finished before accessing registers, which is just after the enabling of =
power
> domain.
>=20
> Otherwise there is error:

No need paste all the panic log, otherwise the patch LGTM:

Revewied-by: Peng Fan <peng.fan@nxp.com>
>=20
> [    2.180834] SError Interrupt on CPU1, code 0x00000000bf000002 -- SErro=
r
> [    2.180849] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-
> next-20240424-00003-g21cec88845c6 #171
> [    2.180856] Hardware name: NXP i.MX8MPlus EVK board (DT)
> [    2.180861] Workqueue: events_unbound deferred_probe_work_func
> [    2.180878] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--)
> [    2.180885] pc : clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> [    2.180900] lr : pm_generic_runtime_resume+0x2c/0x44
> [    2.180910] sp : ffff800083423a20
> [    2.180913] x29: ffff800083423a20 x28: 0000000000000000 x27:
> 0000000000000000
> [    2.180922] x26: ffff0000c0e4e410 x25: 0000000000000000 x24:
> 0000000000000000
> [    2.180935] x23: 0000000000000000 x22: ffff0000c02afd20 x21:
> 0000000000000000
> [    2.180945] x20: ffff0000c162a000 x19: ffff0000c0e52810 x18: fffffffff=
fffffff
> [    2.180959] x17: 0000000000000000 x16: 0000000000000100 x15:
> ffff8000834239f0
> [    2.180970] x14: ffff0000c03d0a1c x13: ffff0000c0a03440 x12:
> 00000000000003c7
> [    2.180982] x11: 0000000000000000 x10: ffff8000825010ba x9 :
> 0000000000000008
> [    2.180993] x8 : 0000000000000008 x7 : 0000000000000000 x6 :
> 0000000000000000
> [    2.181005] x5 : ffff8000838b0000 x4 : ffff0000c0e66088 x3 :
> ffff8000813852c0
> [    2.181018] x2 : 0000000000000000 x1 : 0000000000000004 x0 :
> ffff8000838b0300
> [    2.181035] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-
> next-20240424-00003-g21cec88845c6 #171
> [    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
> [    2.181050] Workqueue: events_unbound deferred_probe_work_func
> [    2.181064] Call trace:
> [    2.181066]  dump_backtrace+0x90/0xe8
> [    2.181080]  show_stack+0x18/0x24
> [    2.181091]  dump_stack_lvl+0x34/0x8c
> [    2.181104]  dump_stack+0x18/0x24
> [    2.181117]  panic+0x39c/0x3d0
> [    2.181129]  nmi_panic+0x48/0x94
> [    2.181142]  arm64_serror_panic+0x6c/0x78
> [    2.181149]  do_serror+0x3c/0x70
> [    2.181157]  el1h_64_error_handler+0x30/0x48
> [    2.181164]  el1h_64_error+0x64/0x68
> [    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> [    2.181183]  __genpd_runtime_resume+0x30/0x80
> [    2.181195]  genpd_runtime_resume+0x110/0x244
> [    2.181205]  __rpm_callback+0x48/0x1d8
> [    2.181213]  rpm_callback+0x68/0x74
> [    2.181224]  rpm_resume+0x468/0x6c0
> [    2.181234]  __pm_runtime_resume+0x50/0x94
> [    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
> [    2.181258]  __driver_probe_device+0x48/0x12c
> [    2.181268]  driver_probe_device+0xd8/0x15c
> [    2.181278]  __device_attach_driver+0xb8/0x134
> [    2.181290]  bus_for_each_drv+0x84/0xe0
> [    2.181302]  __device_attach+0x9c/0x188
> [    2.181312]  device_initial_probe+0x14/0x20
> [    2.181323]  bus_probe_device+0xac/0xb0
> [    2.181334]  deferred_probe_work_func+0x88/0xc0
> [    2.181344]  process_one_work+0x150/0x290
> [    2.181357]  worker_thread+0x2f8/0x408
> [    2.181370]  kthread+0x110/0x114
> [    2.181381]  ret_from_fork+0x10/0x20
> [    2.181391] SMP: stopping secondary CPUs
> [    2.181400] Kernel Offset: disabled
> [    2.181403] CPU features: 0x0,00000040,00100000,4200421b
> [    2.181407] Memory Limit: none
> [    2.463040] ---[ end Kernel panic - not syncing: Asynchronous SError
> Interrupt ]---
>=20
> Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for
> power saving")
> Reported-by: Francesco Dolcini <francesco@dolcini.it>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mp-audiomix.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-
> imx8mp-audiomix.c
> index e4231e9c8f05..cb44c460548e 100644
> --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> @@ -6,6 +6,7 @@
>   */
>=20
>  #include <linux/clk-provider.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/mod_devicetable.h>
> @@ -362,6 +363,12 @@ static int
> clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
>=20
>  static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)  {
> +	/*
> +	 * According to the drivers/pmdomain/imx/gpcv2.c
> +	 * need to wait for handshake request to propagate
> +	 */
> +	udelay(5);
> +
>  	clk_imx8mp_audiomix_save_restore(dev, false);
>=20
>  	return 0;
> --
> 2.34.1


