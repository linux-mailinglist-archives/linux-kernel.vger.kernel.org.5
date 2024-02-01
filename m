Return-Path: <linux-kernel+bounces-48290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9EB8459A1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2138282E3B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524E85CDFC;
	Thu,  1 Feb 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=asem.it header.i=@asem.it header.b="NCAtRR4J"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2137.outbound.protection.outlook.com [40.107.22.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E715B669
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796427; cv=fail; b=FGlXEt/pEeZZz+0MvY/nnAU2TSzIkJkA+4MwIcVdEpjj8JVJKBdw6Z3RnAf12hJyOgjwTJtDKTvlHDLjRbm05wiZ5rFKi2GotzZzVKZk2pWupYd6LC8s4JYJxX1Ilwo87CwzDsRF1o4tkjFalELqvsge75bunQ2PYE3umkB2FNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796427; c=relaxed/simple;
	bh=5Jtn/P9VJGOZqLoAJVpRD68sdaSXyU32IMjCqHkX1K8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UHE5m0ToenUhE1dMNXm3QcotJyCkoVNpWbiJw2Zdnk2ITuyty/Vsrba9VuMYIMT+3PjyYvqt+zhzbxByYeNGUSt9zlnCYXO1yVxjMza5pcI82XRz32fVXIQ+tr0THVRO52TD9eevux8S41wy0Y/9OSB/g5zC4m3WURerCk0ngRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=asem.it; dkim=pass (1024-bit key) header.d=asem.it header.i=@asem.it header.b=NCAtRR4J; arc=fail smtp.client-ip=40.107.22.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asem.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQori5LDMwaVXMfqUyw6YrIXVe0KNd5iQs8pJfEt7aFYZUMXU1YGveuw16YMVYecYqPpJlTXpCNYGYoB9+u/Bee3bkST0rETxfADGipdHKUa8V6yM6tgR2wPsuFn08Ombb8LDvC9zwsjDbxDL9m/8kLZqzUD06wTu9/khkxGUVKzQbdVCtKs7/5/X1wIua5LTqh56574ekFvVCtZFTqf5TdopRP32/gJKgQWg3TBM5mIxqqkwL6hW71Dd+9Lp8V4FszkyKODjQJCsgtt4n1zdw8lfIl8h0Pi44lXEe2HOY50AgNmaCTmLjJ4XeiWfk2CJlc3AZb7zAjF1q4ncN4HuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRQOAcG+4r0ikF+de1juKxR1EBAOTAhKKRVDYtWL8Kw=;
 b=OZDQ0A32i6l7bhtNcXqcYdLSZm+146g7F91aGU9R4ugyA0xa/2BKhCYe9eU91foEZUCTpiUxuacoEKy/kUf43c/1CHeoUuAdF1BNG7BLrgWzP6Nr2Gw82KPYANZQdfbXIRqTt4WHZRJasLv0SLO2eP1KsXH7vf/tJ0EeWGB+LMdI1CZnMj+CRdN16usNcy35TrbrDAqJop2Z/5BI44OlzJ0sovaAkNOFoQ/EA5dv5zqXPTvrGdiGMAOJc8KMy/bNLEcLUrUMwWbmuasb4nRhlXfuiESkeJU6mD6j5j5t7MQg74bIDB0WTGvlajidZA0yRpeYUfzWKy5Xnv+bYe3T3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asem.it; dmarc=pass action=none header.from=asem.it; dkim=pass
 header.d=asem.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRQOAcG+4r0ikF+de1juKxR1EBAOTAhKKRVDYtWL8Kw=;
 b=NCAtRR4J+KZHwTE15Gk3/SDwyYVkLFVA/mY/S9wUx3SIB/8J3SjjvKFvXbOtObbxb7cMWuHNq0zrQ09bmQv1EqfMUu3x5/Wp6NfHa9qNLprIO9dLbNCjebVdDAjszgKEf6GFoTidesKMAq2N/5bueFTL4L1V/o3Rg6Ggb23+ubc=
Received: from DU2PR01MB8034.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:273::14) by DB9PR01MB7194.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:218::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 14:07:01 +0000
Received: from DU2PR01MB8034.eurprd01.prod.exchangelabs.com
 ([fe80::f272:d554:d6b7:13cd]) by DU2PR01MB8034.eurprd01.prod.exchangelabs.com
 ([fe80::f272:d554:d6b7:13cd%7]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 14:07:01 +0000
From: Flavio Suligoi <f.suligoi@asem.it>
To: Michael Walle <mwalle@kernel.org>
CC: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
	<pratyush@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard
 Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] mtd: spi-nor: everspin: add em004lxb entry
Thread-Topic: [PATCH 1/1] mtd: spi-nor: everspin: add em004lxb entry
Thread-Index: AQHaVREwV9yOPWUKn0aMKNL4g65aJbD1gEgAgAACsXA=
Date: Thu, 1 Feb 2024 14:07:01 +0000
Message-ID:
 <DU2PR01MB8034B0342FFC88CEC7CC976FF9432@DU2PR01MB8034.eurprd01.prod.exchangelabs.com>
References: <20240201131710.797505-1-f.suligoi@asem.it>
 <20240201131710.797505-2-f.suligoi@asem.it>
 <9a22148dd786dd1c37f10412b574aae8@kernel.org>
In-Reply-To: <9a22148dd786dd1c37f10412b574aae8@kernel.org>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asem.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR01MB8034:EE_|DB9PR01MB7194:EE_
x-ms-office365-filtering-correlation-id: 655ad6fe-5041-407e-2970-08dc232f0fbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +J61UxaMNDUZAFueQNzoi4BtqIAKxqcsMCfuBt+v6Y6yDwWwl6VgURTMo2cukEwrMc2AW5WESpmqW4lgOFj0iQ3hRbuvXOAbyo9hPeeV3LMyRfkDYyKtztvAPhaskmfChOlkK9nJP/zlHwl9C6CYXxuLzNCZYSX5olIQse+0aGM7xWdQcPYN6RiKa73c8c70YMwAm+PRMG/BTc20Mnu+/j923qQaDp14nhd63x7J77Vbj6TqXFFCiSHXxy9Mc3gSewrm7JeDre7L7r1FVfVF+TgKhr1QVi/dSj3k0tU1RB49UVRMExTN4p0ubUw3GWNuu/tb6Q+Br93efrLGHEL6Kh6jajH5BqIwR5J0G71VptAPDZXgmvuOJoa0Lw9EPDJ1oG43yM+3zds3DPbWQ1XTGNtpYD9iSrfNgI7TpXaKdOq3jwTwHgvq78Iy7PyVhwa1hxsRdsNwaVY/ZEGMSUX0Qd4IhjNWi5wm1Pw6GG/lv2G2u70a4UE723ZvdxltlDXS2ggHQeV5N3FE7V0VW4KGIUO0UbDotxiEsPQrg85dokWveBTykzKkAvhMFaoysgvPNQvHvPG+i8RTKQHkOdgnuw/cokUGGnLd691cTmgLti9eYumSqRA2A+e+wVoCLdl4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR01MB8034.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39850400004)(376002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(478600001)(41300700001)(55016003)(38100700002)(83380400001)(122000001)(71200400001)(9686003)(7696005)(6506007)(52536014)(64756008)(6916009)(316002)(38070700009)(33656002)(2906002)(54906003)(5660300002)(8936002)(8676002)(26005)(4326008)(66556008)(66946007)(76116006)(66446008)(66476007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?09pLEbBch2UpIGl9r7MC7nltqsrGMs2HnXGhxxUv5yWLjpSAOZJJuRrTihtR?=
 =?us-ascii?Q?Nhcze0NK8p/eLfi1+DCAKCB0157gJ+82Ng2FZh3/M7ZNFyJDdet1iCU5IXWr?=
 =?us-ascii?Q?nwS9HtSF2wRf1yf9jj0OHebkOWXka2/vvpeMb+1ygntfif4p29MWFB1yNb40?=
 =?us-ascii?Q?lj6HeBrMsu6sG0wOsrofQTxtdyD9toGCGcPEneIQZy4R8KqdCLdckk8vLrvS?=
 =?us-ascii?Q?4UyQTIoaZmkOFXjw6rxeB+Y/AUwf7j9UM4s9VJ+FtXrxGk019RnuBzQzlqtR?=
 =?us-ascii?Q?9xiZAjPciSv+wvCY4BkfBRD3KzPQ8MllrUJJV+RjZg7tn1twILxeCzGuFtz5?=
 =?us-ascii?Q?gonohaxRvsvbg/WX+x3FJ/BMuNzUw3oR/jxln1hlBabwHCwXrDRrChlT9udv?=
 =?us-ascii?Q?8FNIdiyBTxOdODEuD1V+xu19zMSNYetBukGR2f35dSI1sIzLNGAGdqFuUNdi?=
 =?us-ascii?Q?32pXrFPteD4yYRte7KxY8VnoF9N4v9iRr0IRhRefCrFYjJ0wg6Zgvuqg4g/O?=
 =?us-ascii?Q?R0fYhMw9kkGx0xAecCVGMJmh+c6FH5ISbAU6CSBxNTSHR7RbreIuRBz61dEw?=
 =?us-ascii?Q?mZjmXOp+sjTRC74yb1kItKExQDmhGs1TkdHYRQD4Ev85axhbT/YBdlMuQ2qI?=
 =?us-ascii?Q?pb/CKtzSD4yDcbWLJfSMeuSFhmsJ/V58TaIJWX5/f3FKL6MLxYd21Zz8TAse?=
 =?us-ascii?Q?7cTeXd9/hdXWENIX6cBVuvkIqN6wVF/zRyea78o0bfCV5ijmDX6ilF4lKDEu?=
 =?us-ascii?Q?RqwLvPFQEEj9kGZMswENoP+QcCjujzyRG0OW6/91QF1QmpqaEX02wsR7Tq1n?=
 =?us-ascii?Q?777WfZiGakdWMI/rJqMZALxtbpNgsc/ik77Kxx8GZ+G9/QvCpYKDtBwakB+X?=
 =?us-ascii?Q?q/EGMXe9aPQPd6zHXc540wL6s+j3i/rNw2md1ev1VsT+Ya4kaP5/mx2afy/H?=
 =?us-ascii?Q?OYlzWo87gOmrPtMBT0xRti0qne29c/0gQJ4SWwAnJXoprOZOoWFmqJsguBUd?=
 =?us-ascii?Q?cTafRtAlQshIFdrarNe1qmcQXSqyAunM6JB4y6aMxq4R+/V5KeKXclbxXsr2?=
 =?us-ascii?Q?0ovcTCOb8gy128FrH7h9NOCwE/33iQndhcO9BacJnkv7Z9fmcjA51QwdNBgz?=
 =?us-ascii?Q?p50INI6k1BKTM3yBl1CCVHtw9TdYvuMPwIN60hHwCxyFM3uM6WDU+p8LFY8B?=
 =?us-ascii?Q?UN+J/C9OjefgW5/8LTUnH5DK39QUpiWi7j3tcglENkvnX5/VWvOEB097oE34?=
 =?us-ascii?Q?JmDNfKHbjEt5IFgkqts6nQEGyf1to9hWxkY3YX/tmXCe1tA985OlzoZWBxNK?=
 =?us-ascii?Q?a5MxbRJsoAKcHoYv31RWdqrTnG5ANV5B26aOU2wkQmzAq7l1ozZmOAulzd0h?=
 =?us-ascii?Q?iEh/OD+Mvxa3NFh/x5+nU/w/dGawn2Abp2hMGyp5PjThfA1LbG7pOvrYzJ03?=
 =?us-ascii?Q?fqyGQzgplZmww2KgpzOu/YUouOA7p4yP1CDLhoQZM00DBZqDlIHlsSI1O9nv?=
 =?us-ascii?Q?ZjLZk0iErKIU6ijZxJRON0as6yl5+VyMTInCNFK9dINJQ76HFcsM1u9sbWvP?=
 =?us-ascii?Q?iqxC75n5j8e1oO/V+iY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR01MB8034.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655ad6fe-5041-407e-2970-08dc232f0fbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 14:07:01.3942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5JsHH1gpO6jNjo1TmLsi5EbM3rfM6lH7GLT22gKK6R2jDYIDpwk75gHA9Cp4R0ZsUXIlIkNnfTrRZ5wvlZvkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR01MB7194

Hi Michael,

..

> Subject: Re: [PATCH 1/1] mtd: spi-nor: everspin: add em004lxb entry
>=20
> Hi,
>=20
> > Add the Everspin EM0004LXB 4Mb (512KB) Industrial STT-MRAM Persistent
> > Memory.
>=20
> Out of curiosity, what is your use case here? Usually, I push back on thi=
s small
> MRAM devices in SPI-NOR in favor of the at25 driver. But this datasheet l=
ists
> octal dtr with 200mhz, which seems a bit ridiculous for 512kB. The at25 d=
river
> only supports single bit SPI of course.
>=20
> I'm not sure in which mode you are using this device, though. The DS show=
s a
> non-volatile configuration register (Table 10, offset 0) and it's default=
 value is
> single bit SPI.
..

We adopted the MRAM to save some important application data in case of
power loss (there are some super-capacitors to maintain the power for a few
seconds).
We use this MRAM in single SPI mode (MISO, MOSI, clock and CS).
About the SPI frequency,  we use only 30MHz, because it is a hw limit of th=
e
MX8MP CPU.

I used the SPI-NOR driver, instead of at25, because in everspin.c there are=
 other
Everspin MRAMs devices (already used in other our boards).

Best regards,
Flavio

