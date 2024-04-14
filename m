Return-Path: <linux-kernel+bounces-144078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E5F8A4190
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8756BB21058
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BF52561B;
	Sun, 14 Apr 2024 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FXNAmDU3"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2096.outbound.protection.outlook.com [40.92.23.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C5321A19;
	Sun, 14 Apr 2024 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713087658; cv=fail; b=WnYegUONLX6v5pJrDNdTxC1L42ktznJ1JDykWbLs1fbMzzMsFxdZl66HwtQKIagRxuSAOchR3B28X3fsE1UeXoxs2C65w4t6AKzbpWT90r9Di0htoafREzCHoZeO6Q4HcEqpAK6RL0nrbthNeumFSV6D+aexbb9vg2TasFFoNw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713087658; c=relaxed/simple;
	bh=1GkDMyCVT1C7m5/EtLyR87QN9zNrcghJMZCas++rsdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KF/Wvjd/wPzlLIZncbT5MrW3Vq9vQ3jpuBRFbkUCS9OzHmZim/xJj1g5lpyusX14dTRD60d631+chQIYVE7ugFwZT6Dnq5+h21aZ9yIu/9Z3FNPZJe6N6sVUZ6DHHp2HeCuDNeZ1E6RMEV0f5zsiqwL/9SJlkbCtbLMlptyJGnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FXNAmDU3; arc=fail smtp.client-ip=40.92.23.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0ipvkmh5xkVfs/gfl5pibigWUhS6vwiwiOJ548j7DZgtG9wiqX0/YZ1xP0EIpeMKVksopNhZJo1JceKSWB3epSelUgoWxDJL16PWeN8qPuApDr80QHf4HLOzQda9xiKbm0c6QGVUqJkE014YYggKhpOM5L4yKhLFPbDyYZ0ytP8OlMZwPwk8ezyj09zpo9cH/jTQe8sMrM3Lo6k4FKCv5evjH5TruP2YwAbKuP2EJ2u8/GTbufDV3lUvdykvMcDxW0Xlkpsv/G7TbybyMnk0m8QSYKFz0V1oNkWrUx+BvLLtCCfLh0DErAjFW90fBS3x13u/C20kuqqoldm5fGnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dLncDKo3daSTDXhtlMIxqlcJ30XpHT/4yrvEUG1+WM=;
 b=E+3F7jbf8wzdHpY9HT6jILnDsPRfJuZfg9rR1jb+xNLWacF6oEPMxVZJuA3OB5+HQZRChMGlbI6JiOF+cF8Vphrhm5b9GhVxIrNlXP0d/Qve48sDn0TrEX8lnE3vH1n8d+WqrOBhYpGRFi/J4l9OiRJrvAjGsJ7ymYhcz2kwCqyljyV27n51uHskC3TwHM3LElQbxLX78sR+CS2jLRSeGwAPkP0ZLBLBXpDwyj1TaC3kzFm9wAAIwpHB93nU6m+72J4PLd8D3sgu2Z4TEBlwHyUOKXUx5yF54QH0xvFSgcdfb8RGwM84Y9e/CTFgnB4GMguybzuXz55EZNZF32tG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dLncDKo3daSTDXhtlMIxqlcJ30XpHT/4yrvEUG1+WM=;
 b=FXNAmDU3BFjNlU0WgpqfBbnBa+2pvKMk+FgqS7/evFl/GUWVKtkg1IxEFhQdKqqP1NWBMlP0247EDX1RTNY6SN9bK2oYxsVXUYS+QjLqUQVjhRNcwD249VOKZuxI9Ha+jIL3Cv7BQ+TJ5RXwV2+LP3Luo2ba1jXMfPyJlAU/oVJiDwoofcon1SrLDo4XhyOCc3Onr98I/nb8gPDcm3HKBKaikOGfmamlFlglNzVM9ksAtrByQG8rEuUaZOnWSTFoZDUOCTznzMIosXqlXN0qDEywuxRv+FGzTvPrP9VmiEcU4pDwC4sBb6SQHjEAahlPbCAEUaZzFhAHvesgd5QMuA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB4936.namprd20.prod.outlook.com (2603:10b6:8:cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 14 Apr
 2024 09:40:55 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7452.046; Sun, 14 Apr 2024
 09:40:55 +0000
Date: Sun, 14 Apr 2024 17:41:14 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chao Wei <chao.wei@sophgo.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: (subset) [PATCH v9 0/6] riscv: sophgo: add clock support for
 Sophgo CV1800/SG2000 SoCs
Message-ID:
 <IA1PR20MB495304E9A53F0893C821DD78BB0A2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E5E78F930EE25A86EE1CBB052@IA1PR20MB4953.namprd20.prod.outlook.com>
 <2696c0e0-0f15-44d1-ba40-dcab4be802d2@bootlin.com>
 <IA1PR20MB49536A93C7A684EAE844E316BB0A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953A5ACD22C8CB791C76BABBB0A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <a86c6e6d-812b-4777-981b-c747ca601372@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a86c6e6d-812b-4777-981b-c747ca601372@bootlin.com>
X-TMN: [kS1Q8jp9rvfqW7pN9UbfMVwY3tuBX2uZ9/aV943wpMA=]
X-ClientProxiedBy: TYCP286CA0063.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::12) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <6zpfhzob3hqrtdw5klc2eg2mxmhz72sqnua6tpoud7hn3drjyf@jt4tcayajfzi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a34bd0e-ec02-483c-5e61-08dc5c66fb02
X-MS-Exchange-SLBlob-MailProps:
	5R4zPSLKzf4l6NJUjNUpYjzANfKjmwtSe/iBIWx37p11pzhWX8xFZD+qxg0Bhyk+3Mh9U71DCO/WZeutkXgdrHIZF5rFbIA67eqE51RvQqiCpCpagL2C9yvSo+i6yqw53nKKuKoWPDeNKxVFC8eVBc9iEL8y7aL2jnYKzuJ4guhOxoAB+2Ri/EGnrCgdpxsRd9U+YnXjmQ515rMoMDUD3j3Lr2yjP4jE7Rr18+c1sT6+oyABgb/emYv8EFFZOV94BBvLxPvnH2/ZDXHFIQIhfqmTCt/ZFw0NxfE3hOq3d66i7oKMmN+RiLYmWCpcgVN0SSfxcg42aHf2kzQeWV5UaQ/AUG7yxshOzmktymeIxzYAeOncw6lvsy42+SYzDcYBPC2zxaBmuG8pqmq6gevimdYqIQ4EbY7ipWLc/Rr8EE6VslMZo7J8AX8jMUZfgzTgOxclljsN6MxOfZCssbWN5hjoWsgrcDNgpOTvpBcF0UzFuTVrxyq+vkpj8r7yUwvyjNMtU/D7OY7wjjiYqY0m18pBb2K1dyzohUuymhuEv1m/+23NZG71XikLC5W4t12FNQcMRKJw9apqm1vcvioMai054zshzLOG5dKQIVUsXLsjXU8AQSZ5gWKGFmGhzi/p9YNAFhfGKqjGdFi3OekDnpLo7KtJNO6NLci4beDvMjwlfC9G0gIJfL/byriz0ILDl4beE88gqXHe0Iifu/IfDB9XNBtDjolCCKnq43bw4dYETFbILPC254/s19T7hA/+XVP7G8qb7NN1jrlbiLmLT/G9YmOtY3MPuxK1b54BkP4VkXheTc0EW69y3i74EC3HfWHVBnGiyzSfrj+Hxf4lJBEH+fGlui52
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I1hV1Scj++IsVNqTkxNPU1nNVDHxrfCbs2x8bfW/g42732f8TXXGOQVtTzYxjykCDj6Ho8PnTT0OeYnbNr8zfsDsj3C9Q9xMAafwb40wPa/oHncPE/y6pJeNeKB+8/x7PbgaKe26ZnxHf+DO2WAxNGl3Qdqcji3jgjv6ddyOObaoWDtifdg/ozNlFc6e64MOUWAMXiB8qlLWIVDGCFPylT70x/m81i9/QLNUvvSY2zNs/puxRExg5DxvUJMeu71NHyTnaNaUdAR6xvjFjbfYOhPDvmJ+uAwtBJGW8JbHx4YoCYllU/r3oluSFpqO25ai57WpDvIe4Q6Ov8y25yXrEXzxNrKFApK2SVQQhlDrIcWS1Zvck3q7HIvsK4s6+txPk3TXBLPu1z4EkWIRt948Zwukhc2cC8PN6E1StHRHTEHmI4PoyDvvADEUBAA6XDnkprc1+qZIS7MV7xqfWZn5lzVQIMrtv4/+gA7qbkYtTMmhPyBLvEALkBoKmBeNvBGz1cePYwWfF/sHeNnmPKqSZBBYl3Ufo8f5Em3ISopC7+23JATM1ODmQfRvN+9/WUAzvv5P9ylbHQD2QaP7u45EKv4/Lpe8kvLonCHk0bwe+p1U8J9Tqt1N2lhY7CkrviD3okpQIvz9qO8wzKQA6tyS+NhncQ1Fu1gl02j8ha5TEE02WYsinje0520/yq6ts73/n9jwnXj3zZgxia7r2RHpFg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?024wfnx8SGsICrJunPrLIloVOWBPKKnuCOHiTJKGYLsRDs44mU1wskougjdK?=
 =?us-ascii?Q?dxoqzf4VfjvcfDzjYe0/WWQqnKq+O10hue5gLskvM/8SCVlUU37S7ddRvBag?=
 =?us-ascii?Q?+lF8YjA9lmjIud7ifORFBf8SbThthcSH6H/ewLuflF/mzGStddtJHkpQ6W9A?=
 =?us-ascii?Q?d7RLNvfNz1w9eAG4x8Lcm3QpGkHtfkBBop2IP0bz86Ox4Z98BWD6GeRPo2DP?=
 =?us-ascii?Q?bQzJcepdDUIW7tFNdjDuYoq9g6qeHLcNsHo+Ymali84Q364jQZKY46Vo+rLV?=
 =?us-ascii?Q?DKYGadrpWXoPUScoSvMB+Z9q9iEHp9mpFYEKglOdw6Cepu1Afr0d23E25Eor?=
 =?us-ascii?Q?mOQBugr6KAFdQHH0Kq1Y3upTSLamX0WAdcOG4Uw59sdGOCDwuY+10pwAyeh/?=
 =?us-ascii?Q?MkCyOuha/7zwVz9Bi7888PBAhxYoavbH7Y+wnSCJY2guhFHVEKWsoCleF8pf?=
 =?us-ascii?Q?VggWdpwBnef31u2oUghiWJwREoIIExQPfVu5anJ2QWQMqU2VXIU21kOFbXZ7?=
 =?us-ascii?Q?7tfbzrEK3eqCu9m6Ywcx8Ejl10JyVd7o1umNZDLnhPHBDO28NSqKUsRKqX7c?=
 =?us-ascii?Q?Bx3JGckRtRvObw07bSfpP4duRiCs/ufnYzkbAwq+9G86erSNPSEXlrcLTkYD?=
 =?us-ascii?Q?esOxM3znNl5yNomYgednL3PS5xglgi4D5j2OwTrOqFoFCbocDD/nKkjefKo+?=
 =?us-ascii?Q?N30fNS63cGh/s6b0cg7t5gLazV/FsWAALJiy2WK7qf05qlR8Vs4CdzrCvZoo?=
 =?us-ascii?Q?t+ErrEvrAwDrphGC6d8zxnwlcKLDcGs7p6tpSrawGWjSQ5R3L1Zb5fo8WMFQ?=
 =?us-ascii?Q?/TlGu+xozFN/oebYpKGeTPQ20g0DQd9YzvvG+CmGsE7jN+3hZ9KYjqmh2vIB?=
 =?us-ascii?Q?yUtIZXJNflvbhBxdKXJYgyN6rsxlOuIf4Q8jrq5r89sgdBSlNPQkyhzug2jK?=
 =?us-ascii?Q?Vt8sEcR/uTgKAZWOLbGAVK/3LCrFa2hDU/T+BUIYSSOK+Jua18Zf9koTZPAk?=
 =?us-ascii?Q?GCJxy2IdgD9J8DX3+AlhLsxMIWk/+b98PflmoNmrZG74EPq4YIZGJThIEilK?=
 =?us-ascii?Q?sU4BY6cI0/qRcC4rRPi2hrASQhpWd4/NmLdmNeZjh7w10WsZTfRskNBZxUS0?=
 =?us-ascii?Q?cRw+YYG1YP4bkCBbEh9pn0ioHeRAhHhw/tBqT1pDDJgXtWLWCN9foBd/DBGl?=
 =?us-ascii?Q?UX2yyqbIYJd/gxQuQ8ZfPRofXsi+fLGU9bZLuPv7wU4JJ3/CRpvOAw+tZ9X1?=
 =?us-ascii?Q?uGRcfy+/Bi7UNulYBLcR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a34bd0e-ec02-483c-5e61-08dc5c66fb02
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2024 09:40:55.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB4936

On Sun, Apr 14, 2024 at 11:11:22AM +0200, Michael Opdenacker wrote:
> Hi Inochi
> 
> Thanks for your help!
> 
> On 4/14/24 at 08:43, Inochi Amaoto wrote:
> > > Hi Michael,
> > > 
> > > I think you boot with the `defconfig` config. This config does
> > > not enable the CV1800 clk support. I think you may need to apply
> > > [1], which enable the clk driver. Also if you want to test sdhci
> > > with real clk, you can try [2]. I test them on the Milk-V Duo S.
> > > 
> > > Regards,
> > > Inochi
> > > 
> > > [1] https://lore.kernel.org/all/IA1PR20MB4953CA5D46EA8913B130D502BB052@IA1PR20MB4953.namprd20.prod.outlook.com/
> > I make a mistake when reordering the url.
> > [1] should be https://lore.kernel.org/all/IA1PR20MB49537E8B2D1FAAA7D5B8BDA2BB052@IA1PR20MB4953.namprd20.prod.outlook.com/
> 
> 
> Indeed, I was using the "defconfig" config. Too used to having everything
> working with this configuration on RISC-V :-/
> 

I apologize for this mistake. I just forgot this after removing
default value in the Kconfig.

> Gotcha for the CONFIG_CLK_SOPHGO_CV1800 setting. However, I'm confused. Why
> is this setting available in linux-next, but neither in
> git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git ("master" and
> "for-next") nor in github.com/sophgo/linux.git ("master" and "for-next") ?

At now, we only maintain the dts related change, but not the driver 
code. The driver code is usually applied by the subsystem maintainer. 
This is why you only see the clk changes in the linux-next.

> 
> What's the tree used to push to linux-next?
> 

As you see, the driver code applied to the clk/for-next. That is the
tree used to push.

