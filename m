Return-Path: <linux-kernel+bounces-154678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA318ADFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E491C21260
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC455103D;
	Tue, 23 Apr 2024 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QSq4WAGa"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2028.outbound.protection.outlook.com [40.92.20.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8221A0B;
	Tue, 23 Apr 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860649; cv=fail; b=m2VODMDUncBnisaNjwBBfFsma1OhHgzV5nje2ZOuer/KQ4YBe5OGMeuUcKOUx6Jj55C1KsKH/3ZWr0sUOoN2fAfQhJFlfn+1OrCQeRbE3Py/apjYY6eXzHmtQ11mulAUBXZUo9p1xGq08zNwGzdpiQJfYnCKA9WBE1WZNH2sc9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860649; c=relaxed/simple;
	bh=vAwfCEVCw/c/VZjyKqXlS+/bvU0vYXRb7MjxubyHhjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k20ehg+22m7WpDgSjGDvq6pJupfMC9vl8hjus1FaAonG/KH1yrJCrN3EojBM83PXQUiMxf2kB+No84c/FM8C45ghbC3DnWZIzUGsuRCNAhWPv7x7NYH8H/P84m22JbglwqeitBXKRWqb3ncge0ZBvtF9MydS+qRa54n4ub2xoM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=fail (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QSq4WAGa reason="signature verification failed"; arc=fail smtp.client-ip=40.92.20.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkwPOsYhESsX3Sq3nZUy4cvGFzhTep8UfYRjY8UcJi+BDoTv7wIUbCJ1wdlrDx1Wh/QhRNDOvtjouTgHllYwA0Yy5RWWqwjS/E5D1pJ4pZWYsFzvT9T4sqgpyQ9vzP8pEWryoK+QssqUtSNDxDgUsrkYf3sTF6LoID31TrfxvQV0wIoiWTZJylEtdISPUDfKzLh5Gdt51txk7DiIhLfrqahMWaZvxsujHIXStzmoRnSMG5U9fxnUAjTMm+tSYRolpj0Prd8KgJnDXC0mjxv3+xeYRszPP3d5rtUBrAxaUiYnVAYqUUPo9wU570eU6iQC3hjP3g3zoq0Hbvd/3BrwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4Qjd01hVymGpeHKV0Ej3fXiVs1ANEMVNNN2gNYCYzQ=;
 b=NSRdA/9s8qzp/j9Qmy1sjSA2yPK4IP4L6njwUBBlntYTco/03yr002MQwCVV5OXQW13dmhgNiXC8XRzaSRYrC3kB5cWvf1wHhfpG6dUaymJ9zOBUYJhCJYSPksVQUMFhcpBDG+8YfQWaYSS5UxIGLrvNt+O76OHMqMhQpelH4jP0ZE+y0If3dcNyS8YDFao3v/InwVQCfWqDyPnn0THInCyfUcfdQYzUKKxa81lGOLbLfmBfaSVe+qEFQKAv6S4w2yRAZ4VK0a1zRTlfHOTm0N/hFuKrhGawJC7aDQcRnslP+OwN+Ib5xVw5Ow8cr1OdiY2pbxYOYCOXnBf80UN9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4Qjd01hVymGpeHKV0Ej3fXiVs1ANEMVNNN2gNYCYzQ=;
 b=QSq4WAGa+SMzNgXMfS6EbL20BqOISRoVsSE8uvgt3WHy6tvJgKGz2VDN3xrg8uKCsrm3+8wLjk4+Jy0MMb0YV1kYC+Xx29jFlzy2HrI9NlZy03ljsKPuH8EZLXoQdIyrhR9+k8431cB5shi3yWSFIC4vXUiQOSFv3KkgTFLBEXKH0sAalaNItMNbvHxnzXQtXWM08d3u/AHdeDQYROQEvZesmxi/QGy0RqBtNT4sZuQclDOJn/FTpx06uBoBEpz39p/IBzxK7VOgNwCYVxAeeJAyW7XwLcu2TWBEAOWFmDwYrtTO9WizjSX8jFMoVInDOKCWSOcp4U1oA7RV9ofu+Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5412.namprd20.prod.outlook.com (2603:10b6:806:2a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 08:24:02 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 08:24:02 +0000
Date: Tue, 23 Apr 2024 16:24:29 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] riscv: dts: sophgo: add initial Milk-V Duo S
 board support
Message-ID:
 <IA1PR20MB495332310AE9596CF04493F4BB112@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240417065311.3881023-1-michael.opdenacker@bootlin.com>
 <20240417065311.3881023-3-michael.opdenacker@bootlin.com>
 <IA1PR20MB49539A380E44459ACE19DEB6BB0F2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <e457d5f6-3289-4049-b663-2ebcfe78dce4@bootlin.com>
 <IA1PR20MB4953D0D45EB0EDB6E8046664BB132@IA1PR20MB4953.namprd20.prod.outlook.com>
 <fbdcc77e-eab4-41da-803c-d65405f37f02@bootlin.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbdcc77e-eab4-41da-803c-d65405f37f02@bootlin.com>
X-TMN: [r//28Cciv81t3jGs7aP7nCKLgx4Fne4iTaufuyheOG4=]
X-ClientProxiedBy: TY2PR02CA0069.apcprd02.prod.outlook.com
 (2603:1096:404:e2::33) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <s6tbjbwwfmavscrjc7w3qrf63sy5lqa6zd2f7cgzmz6xn2scca@dqq23tv2dauz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: ef87dd17-be4a-4dfc-b1f4-08dc636ebb9e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A8cEpHH4Y/rsANnXRZfpXz13WJz+uG6hZlqbKPRNwgkw2T2MHXRjlqDJuV1h1ZkIR/SD1yCb2A6AGzdJKiJ5TahghKp70ffpfwZ/UT7VqKoPzfkBCMXkC1ZoZpQBpd4j5XjDFeMICcUqTmioIJZ8zw/1QQzwJwrEA7oQF7uzq+W67ieUkcw/SEOmtkoeK8Ok3bN+fD7C+xnBDWeqcVPy8WeHk/3gdl8MU3QeEtE/xkrHMpFpx5zObL532uJmVWEXgCArAQ1gby+jVuM4i+CaQsJwLO17/DsPtb0OE7HL+HSw9kGoVUrVzo7AOSLnZuVEQClAnD9J1hTAgwqEXDgMx0Dq14TyYuJ7WxTISAivsvCySxu3lGapOQleNwJfxSFKT4gYiNIJ2ShQXei3PCRP/qt+NBFdVuQHGpRrMV1hwCbN0xdkikqKRIpQbgj6O6sGjuct6/iIhHn0Ibod99YeqpgoI+fjVl1dpMxeWn2WdKVrLc+TfqLy469yi7Rgxu6vJebTA4MU2OE9Q78Y4XmNY1bWopqFsVIMZKHA0DGwfI/BCTN2XLx5MIJqmSm42LWoQj0cOW/27aztnAeVNXQGTVIPzh0Fv5IjwW0xnrfKXYXYQf4YSfgRdPH4pSMBUu/k54/4DLr2iAR4A8zhw4NC+KaFP45vae/4BjL6Ig1d4YLoSmJpzFWaZectg7kJfzzZoZJ981cj3nnHkFqSWBxmgg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?kL+eqdW/BWV2u83qYoFAL3UJjf8XMl+dy2zy878MemBuOzGPgKw5yhtjQ9?=
 =?iso-8859-1?Q?pC6cg78wDbl1ygTSR+frR1kTm1y5Ff2QjjZwXyr2eehG1+yyNBtE+p2Rao?=
 =?iso-8859-1?Q?I+Ea7OJg904Ns1wA2xL5PrAoAtjMIZ+m0MwnxaqyVsLTY+c5G+CKvwu/lS?=
 =?iso-8859-1?Q?yCFex5pn22n9k1O8DM9KuDrvV3nt0hHXK/a9+jMG4OR6+GIXwVRTc09E+f?=
 =?iso-8859-1?Q?+I13BlEgPIjelgkyZzHFJlgrTW6OzP5ThDA22/+YvjMWspaL1aVnMlwwD7?=
 =?iso-8859-1?Q?HdBfLmc/4a2+jCTaKBfZs5Wzb69S1uKo47flhqLs+JvZW/ob6DdCzvP5C/?=
 =?iso-8859-1?Q?NtKpZ057iTToA6JDVUVI/ejLbWFNcsXSmQJ8NgspB6oLiO/CiYrKsezRme?=
 =?iso-8859-1?Q?pHWWVVq8wwKIeUZvITyD6ucD3kHLVwt/XU0OJ81x6w/UF5FoYwCObtlhrt?=
 =?iso-8859-1?Q?33X599PDXVuqwbyfYd+A5CFM5ZANcz9GNFx58sxUYDzc4tkNoUYlMbDErE?=
 =?iso-8859-1?Q?fF3aEGKANL3K4QaXMaxZAnxPypoCXKbYepzsCvqST3IapMNSfRzuUcmIea?=
 =?iso-8859-1?Q?JxKw2rGHLzA1fkL5RaZiXLKicJyXz5MHt6RX1tnP8rV1rtIKmrG7V2lUxi?=
 =?iso-8859-1?Q?KSEBGWV4m3kdW/TYjlXY9QCP+idmMWeMSGnqq8X02cwBxgTbkuy1Q9wyug?=
 =?iso-8859-1?Q?veCR3tuQFohXLGZqEa2xa3Uj/Q/hGDFkdHSM4bnpOSKbd0TTNzVTdD+NvC?=
 =?iso-8859-1?Q?E6aOxOqBRamcUueCa3TbBz7J59PeZv5MfRxcQAW5+sZ3dVXgQV/m9QlG1T?=
 =?iso-8859-1?Q?3nL2augSEX0F8MvfJHFEJ1i6qGdiWiJu1Yiegh4QFsAL+MJhpVx0U0Bzsh?=
 =?iso-8859-1?Q?azWsTnYyu3+ibhNCBZG42eA52DastbNyo6TWucGioll8a+cQqz7Al7cDj0?=
 =?iso-8859-1?Q?+ItsA8HNODkfq9xYHX6flJan9ppDam6Q0iNvfhhN1LL/bQJnXPmBHRrh/W?=
 =?iso-8859-1?Q?Ve5qUfSgmenWOG9ocP69b601vEMHz12IFKLJEwzZK0rTOnqKdbLQN9gDCg?=
 =?iso-8859-1?Q?14Tw3A1bf6J3oEQ4NaVBGyqqx+6e6wtJekBmZLWIlbbQlynTXNw1HEziZn?=
 =?iso-8859-1?Q?J+Re4Clux2mL4IPRCl7K31EcGAdU1U9VZcxLVLjd2l2DG2p7A4626K+FNy?=
 =?iso-8859-1?Q?tA2ZQypSJ6+noH7WxaPbQesbdFe4Aau8ddxvyB5Qk56A2yBeaFlG4U/nZy?=
 =?iso-8859-1?Q?FOlLmd6XysvgQnmnrZ1mW2i08rqnqOh+t/yMnD4zK9rtDvOOWogbBpS/ll?=
 =?iso-8859-1?Q?XBzt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef87dd17-be4a-4dfc-b1f4-08dc636ebb9e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 08:24:02.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5412

On Tue, Apr 23, 2024 at 08:11:29AM GMT, Michael Opdenacker wrote:
> Hi Inochi,
> 
> Thanks for the advice.
> 
> On 4/21/24 at 08:30, Inochi Amaoto wrote:
> > On Sun, Apr 21, 2024 at 07:57:01AM GMT, Michael Opdenacker wrote:
> > +++ b/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
> > @@ -0,0 +1,34 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (C) 2024 Michael Opdenacker <michael.opdenacker@bootlin.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "cv1812h.dtsi"
> > +
> > +/ {
> > +	model = "Milk-V Duo S";
> > +	compatible = "milkv,duos", "sophgo,cv1812h";
> > +
> > +	aliases {
> > +		serial0 = &uart0;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0:115200n8";
> > +	};
> > +
> > +	memory@80000000 {
> > +		device_type = "memory";
> > +		reg = <0x80000000 0x20000000>;
> > +	};
> > > > Add a cpu specific file, and move this to it.
> > > Now that I'm including "cv1812h.dtsi", which has the same structure, all I
> > > need is to change the reg setting to have 512 MB of RAM instead of 256MB,
> > > right? See the V6 I'm sending soon.
> > > 
> > No, Duo S does not use cv1812h, in any means. I just told you to use
> > cv1812h for local test. If you want to upstream Duo S, you must add
> > the right cpu compatibles and necessary nodes. These two are different
> > things.
> 
> So, do you mean I should create a new "sophgo,sg2000" compatible, together
> with  a new "sg2000.dtsi" (or "sg200x.dtsi"?) file? Could this file include
> "cv18xx.dtsi"?
> 

Right. For the second question, it must. "cv18xx.dtsi" is the common file
for the whole series. You can check the existed cpu file in sophgo upstream 
repository: https://github.com/sophgo/linux/tree/for-next.

> By the way, where's the best source of information about the Sophgo sg2000
> and sg2002 processors? Even the Sophgo website doesn't seem to have them :-/
> . It just mentions the CV18xx ones.
> 

In additional to the doc mentioned by Thomas, I think you may need to
check Duo docs from milkv: https://github.com/milkv-duo/duo-files. It
contains all you need for Duo S.

> Thanks again
> Cheers
> Michael.
> 
> -- 
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

