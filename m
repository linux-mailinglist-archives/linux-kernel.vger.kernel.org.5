Return-Path: <linux-kernel+bounces-94221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EE3873B96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CE41C243CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BE9136650;
	Wed,  6 Mar 2024 16:01:33 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2136.outbound.protection.partner.outlook.cn [139.219.17.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6EB13F430;
	Wed,  6 Mar 2024 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740892; cv=fail; b=MB6TsUejpwuOwf7sauzPrGZoTSbl6bGOfwBjR2jRpdP9wkr+HlohPm29IkwPqvr+csiOwocq+V5HKRs89ntjgau8IwJXNZvZirIwehGBr0oM0boFWScK+L9N4kTOd4hfFKbNq/OQdpRYQziexJE+wNsYIrd0CsemJ3vzQMRUvnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740892; c=relaxed/simple;
	bh=Pbbd3arx99p+198utPQbAl0S+4t633dgR+8Py/khP3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N6ogqFGPBvGmh1ZDouh4W0JXQ8Mlw7rj0wdN5RDz8tnrVv9zpoynHDWaDDWKzgOS/rvhIYptbVqSSiL9SXH4Ys2Eylfbp40op00rNQe+TzpNellnA59PoHT6rFVgaGp2tsxi6latgxbt0OVQyR2rGPGTXdXHVnyLbYBdO2BNVjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBrxq3991/7xKJidC0W0Tzxc7opVjWLEUa+chJW+tDNvl4xJG9Z5fUOKqzPfIaDmso3m8/qQnt6UMI87HZgfhO3wKyDcJKC4Bj0Ub+uu9ZsiV3BRIZw4aEIKHl+4PwzVtU3DhYq5znwIVluQlEdzoyuBmmXcMh4h1Y/bz15m0sjBX7azjLCfLBrStem1TfE+BghcZfmqsfQkMm+LIf5+jUQrSafeQqTV3PVrMp/dDgX2QQsoIuvwBpJs0hlK6pm5j+fhTj1G3ZPmfyWpl0+1oRBjgd5+8MzfnwoDhqEOJ/3Mfdd4JNKOcyUEjmCJwN+15esiHJHhzzjHc23ph8IfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfdv3AoU0LUfMpoQxN5RD2zAvb6XJFlnInq3BjyyWnE=;
 b=e6tvEa6FI0CRneLwSkDZMDh0GF3Js9xnO6H7VF88Wf67m1YK3mSxHiQoRVNRk0DkaUTfJAT3kfJ0fXdjQWZH6qRZMgQWsxJkHbgmVLrWr9KwtFl8MJdjx1O4CR7Oq/eOCM0V0lV5RiwlmrTut2cuM4mvaIRz/lC+bFbIFO0iJQeckGMt4EzvPsqc5DmvJmp3MjN8jyIvwBmj+jyrSEUJ5FK2PB7VAd07oY+ghEObfFJqUd5vE7baneEldXPO6OSeHjwBFgj3bOQNKqNXHb71XyWepw/k50dxbjC+Gl7a9UALLmqu3BFVyUJ+4kzkfD3hZEdJfmHoaQsiS+1MGIj4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0571.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.53; Wed, 6 Mar
 2024 16:01:17 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::f6ed:1a18:3fbf:788]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::f6ed:1a18:3fbf:788%6]) with mapi id 15.20.7316.050; Wed, 6 Mar 2024
 16:01:17 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Frank Li <Frank.Li@nxp.com>
CC: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "joe@perches.com" <joe@perches.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "robh@kernel.org"
	<robh@kernel.org>, "zbigniew.lukwinski@linux.intel.com"
	<zbigniew.lukwinski@linux.intel.com>
Subject: RE: [PATCH v7 5/8] i3c: target: add svc target controller support
Thread-Topic: [PATCH v7 5/8] i3c: target: add svc target controller support
Thread-Index: AQHaWIvaQw3YyHT02UKJrOMhyC7OnbErDKXQ
Date: Wed, 6 Mar 2024 16:01:17 +0000
Message-ID:
 <SH0PR01MB08410A70ABB956DF9DD4DE25F921A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240205233326.552576-1-Frank.Li@nxp.com>
 <20240205233326.552576-6-Frank.Li@nxp.com>
In-Reply-To: <20240205233326.552576-6-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0571:EE_
x-ms-office365-filtering-correlation-id: 3006193a-a604-486a-d8dc-08dc3df6a822
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 w5jH6AvrA5s6Xg2PxzM3MmJC8M1b5nh1HIPp1c9sFBuPW0/pOWsNneBQAnSE5hzHqy/ESpEvZr9t2AAZPNmnbs0zZpqMneQeO6XcidFSP4V4W5U2uKH/Fu7mFbugNm+QXUCgE6LCXVw9BsEEd7W4Valn9HJ4WR/G08RwI8f3eICfJ1JxpuyCAAsA9W+p+D88CyHujkv30/zgQuUY1k8QuWWMttISbIwGe4eFxoR2Mg99aCY0KQjbP92gtjIWN+61/EVFYyZuMpOa5erUXJV8g9ZQ4FLA7Uiscxc5mNwhRG7UT2P3YRkQ/AYcvwhj4ohPJIN6HWCUyBBpCcXKKwMCucSSbIjyoahoSKSdN8L8seQni9I6cuweLf2Ih0QArcHeNXABYGfM36aXH5GPq5bVrdF9zR9nY8KXLRK8W+PMO/MkjSRcKDqP+uGWfv5khk0Us17sk+XPcYji5IFymXHyVCXEdV7YKZPSqGK4IRwCp6lxdcG01tYPRo/SnRzJdzIBJPQ+tF/F7YkCCHvD2Doi52KOTSfM2jMzy1z79x3mHGSKf3HesLRKiqHiEiVfwigE2QyvS25D0YClrp+ZxThILx9aRSvsqTOWkprvSNrp2z+xTaZKlFEo4NQ2MwGKVm2k
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?axLzjIVgz7yHQx2rECoVNZrSJhyiSRw7B03ZCrJiNoS3AtPceWUAaR96n5Mn?=
 =?us-ascii?Q?UuB3v4cmulEhrzXHQZbF7kd23w7XS5ZjCZ6lMLpC/d00Z6RjnFsEJxUmZejb?=
 =?us-ascii?Q?8U65fw4B4bjtPQGTjEmERlCrpnjyBIWP1T16nWgJVHkg0cm4QZw4edDNAnKd?=
 =?us-ascii?Q?EG3RhB+g4EV0Pz5GaW0m539eZRdsyK+2qZeQDZ1knpp6TMOA1z3LYA7AjzlN?=
 =?us-ascii?Q?hElGNBNXhMWv6q1pSndtOmskSj3rP/4+Jq/hRu6rtjGD6X7xxPXmTVXB34R8?=
 =?us-ascii?Q?M5RIsIX86PgoZsBuoCJCcU9YD56P3TBuA4tOlelYB9rXSocZGIHTBd4lk75E?=
 =?us-ascii?Q?J+PqH/w4T8qyB/Z5n2ne+Tcoqr+vEPjOZnYg+XOPblxKkqUsm97rICJFFbKt?=
 =?us-ascii?Q?94z1LxaxxYoaLw6dUixTK9B0TvTTIpcrMPq1CgcoUfNF1fpe3mkEspzMfW+e?=
 =?us-ascii?Q?JF8uEHC3RkrI/K9t0s3qBTlgnaarofhfkbAqBhhAefj+7jkPnBYpfU/6q8fU?=
 =?us-ascii?Q?JTtQyI1RawKTn0iWwj3vd6jX0UcbvwCjXM0E1XHll9fh+oriQ6qfT45VXe3c?=
 =?us-ascii?Q?jXwpwcUkbhfpyHqe5Ly7qpO0s+XZasa5LDL/UhkkxUYsDUPeIuux48jx7oGT?=
 =?us-ascii?Q?ZdpxlnEnWY+6GpeF5WQaLvp5fz5VNJV1uFGtXYLML9N1tS4wC5G1phebiRtQ?=
 =?us-ascii?Q?5eLvZ6B5YCoj2/EXeFK77ydxPWUFhYKgtOO4IBQ60I0XczybfiSi/pbMqd9R?=
 =?us-ascii?Q?ufofTTWWsJuT087/De+uxhjPusLUqirhwozNS4zIG0NADXQ8IiPB9VZX0NWM?=
 =?us-ascii?Q?EIYkckxCUsIU1Wbxe/ompPOuxKQ6mLcvcFxbIePgY/6PatyieP2yd8CSbCEG?=
 =?us-ascii?Q?UzinWM2d8n4WF0EUjtUF6C3uW4ukclOlsr2WeWIKYj1rO52ifmnVu2xOFegE?=
 =?us-ascii?Q?YuXgoi+P/ldoPTo4LR8zluvQCm070D2Xyd/vBf872MHNBkgspJbvDsXJEOEz?=
 =?us-ascii?Q?apsWRqYfIKs0JEYKAvOjxPXPBX+nC+P947wpDF/4v4guTK70rJV0s5EmlvHu?=
 =?us-ascii?Q?0bniXhJrbMZHS096luab/lvNQmPoisjKq+2ZxITlKQT0tXN9WPQ1iZXi3rOr?=
 =?us-ascii?Q?e4jWKmKYir6yf9a1Phcc5PaVBJcEtktUjlSSDnISOmVXbwBLwmvwk8uhK6UO?=
 =?us-ascii?Q?5VolAqSCTF3EbWQ4xKQ+qm45gGUsNeqv3oH32S3X9oXFbVMuUEjrS0v/uVc6?=
 =?us-ascii?Q?CHhztsxaCupD7NCKsnJ/7UlYoGCRuCWa7D/eIhPtoa+p9alJoLjE/fLH9XDz?=
 =?us-ascii?Q?Mt77mHHaT4nn9+pXP/p3DL0VdNleNCdaYtfnHk74rZDbGMnagGOEjR3Byro3?=
 =?us-ascii?Q?uartzmY6B+zftqcyYGLSbN7nTNERxKjllwD+aqZWfhz3wBi5Qox6csXKB6UW?=
 =?us-ascii?Q?G6latGXNAB3gNIHTbUKnbV1vIQ1EfcIgGhHNwARx3YxKJW6cWsf7l2IiTWId?=
 =?us-ascii?Q?4R20qBqdSm56WS6tO+jNG09HKM0MWstpR8MNJyQhJpt5HcVDguIu07OpMSu7?=
 =?us-ascii?Q?GtnWn+UFFVBHGmzKJx5FakqvrdUsyJ0Gf3vP3IxB+rILzyjCUH/XqliCBrIf?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 3006193a-a604-486a-d8dc-08dc3df6a822
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 16:01:17.1853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jaQX3N6ZatN2jQjb7BATAIVcmPLNhPCPV1hVfIPNQ/MwhPiH0PioyKCZ8ZqZuQ2FbjHwrt7y6DBsVG+jjdYDVFe3nCSucZ54S/i8BFYQaQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0571

Hi Frank,

> -----Original Message-----
> From: linux-i3c <linux-i3c-bounces@lists.infradead.org> On Behalf Of Fran=
k Li
> Sent: Tuesday, February 6, 2024 7:33 AM
> To: frank.li@nxp.com
> Cc: alexandre.belloni@bootlin.com; conor.culhane@silvaco.com;
> devicetree@vger.kernel.org; gregkh@linuxfoundation.org;
> ilpo.jarvinen@linux.intel.com; imx@lists.linux.dev; jirislaby@kernel.org;
> joe@perches.com; krzysztof.kozlowski+dt@linaro.org;
> krzysztof.kozlowski@linaro.org; linux-i3c@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-serial@vger.kernel.org;
> miquel.raynal@bootlin.com; robh@kernel.org;
> zbigniew.lukwinski@linux.intel.com
> Subject: [PATCH v7 5/8] i3c: target: add svc target controller support
>=20
> Add Silvaco I3C target controller support
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>=20
> Notes:
>     Change from v2 to v3
>     - fix build warning
>=20
>  drivers/i3c/master/Makefile         |   2 +-
>  drivers/i3c/master/svc-i3c-main.c   |  35 +-
>  drivers/i3c/master/svc-i3c-target.c | 776

I think putting target mode files under "master" might not make sense. We m=
ight have to
consider that we may have a "secondary master" mode. Some other ways of spl=
itting
or handling of target mode is needed here.

..

> +
> +#define I3C_SCONFIG	0x4
> +#define   I3C_SCONFIG_SLVENA_MASK	BIT(0)
> +#define	  I3C_SCONFIG_OFFLINE_MASK	BIT(9)
> +#define   I3C_SCONFIG_SADDR_MASK	GENMASK(31, 25)
> +
> +#define I3C_SSTATUS	0x8
> +#define	  I3C_SSTATUS_STNOTSTOP_MASK	BIT(0)
> +#define	  I3C_SSTATUS_STOP_MASK		BIT(10)
> +#define	  I3C_SSTATUS_RX_PEND_MASK	BIT(11)
> +#define   I3C_SSTATUS_TXNOTFULL_MASK	BIT(12)
> +#define	  I3C_SSTATUS_DACHG_MASK	BIT(13)
> +#define	  I3C_SSTATUS_EVDET_MASK	GENMASK(21, 20)
> +#define	  I3C_SSTATUS_EVDET_ACKED	0x3
> +#define	  I3C_SSTATUS_IBIDIS_MASK	BIT(24)
> +#define	  I3C_SSTATUS_HJDIS_MASK	BIT(27)
> +

There is couple of space formatting here that requires to be fixed.

Cheers,
Joshua

