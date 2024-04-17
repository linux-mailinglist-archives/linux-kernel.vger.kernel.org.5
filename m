Return-Path: <linux-kernel+bounces-149227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9468A8D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E982B2831AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFFA495CB;
	Wed, 17 Apr 2024 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="WT/HVwBv"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2110.outbound.protection.outlook.com [40.107.20.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041B73D966;
	Wed, 17 Apr 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387429; cv=fail; b=mO+8nuh2MkrY+Vcx+DRT6BEQtMba3whzsKoESd8o6NJNCuuwffdsXhjAQW26mNOhkcqKRFY+54A0HENCEUAYwe/ZikhW4obP5DYwm3s8B1LsvPihBVFEmY5c2eRslMjPOn8Y+GPQTKtphFDwTO/YW5vUPbEn2F0ESKDM2qESW+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387429; c=relaxed/simple;
	bh=8JttYOL48ZiCTzSBrA46kuVAs3RAQT2JNWiTA4+xYos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HkdO4p1ZS3UMuxZ0FnCCf2rzz8bAf8ZR7Vp2a1l4Cb/uhTNWSVD/oi8cRUi4KE/Zz3me+xW9so6jidtyLmlg/No0yPINFvUqmoIrdWtSyzKRIWNlZZZg+kszrlokMRVlYZjonL1tVy91o2AT1ZJozeKcaB6afngs/pNLM+v7EVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=WT/HVwBv; arc=fail smtp.client-ip=40.107.20.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0bPTQRwNU7AE567FpCEYoiWzqUsN4b4gy9uZlSveW0TEkwpVvG/kddh5BlN1GMyr/RsmD9ZoDEMlF0NU3b5tnOH9Gw6trDO8PN+sJ3NaLumygiwzG71Qb+ZgRz1GgYoZ2a7jLG2JYBV1Ovwi61odGl/QELzLxSITgY12gPIGWllipJRrcWRFY/Rq61J7PzvYO8/Ud0R7BruWk/9xr3nQ/xKaWBdZ0iKpNLLHBFw4737jXJhq5/+dmb0CM3PA7nH1eMv/hvR1yYiO4i4llQM0Lc9GeEti98LSuhvnfiiW9PCwd8/PRbc4UFNQJUF1hdi2KY2h/N8jEVuXp/ILLiclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tduVQVf5sRHYzO1k5MdrVHFkqnby77Qq0ovt92I9vFk=;
 b=kU0TgHt1mau2vPhpyChWtDXN43AcXWf9U/Rxv8V2FcxrHC4igIydXbNRbPKMMxKRXvmktZpY9PflmQUKHI9AVKauJh+00ApN+YKAPL5h+tMsRPNZP9a15T9EGIQsi/zXUETOejaB2vifCfD87vayoDl2VJjXTtKAdqXW93/+BboEZ4kywVjIigbLojrR42E+kLxbrSTRoJH19xu5SvW4Ub57WOfvfJiFwMFHTpXMt7UHImNmpDF22XsFpbzxeQD7EY1InPBERaN2Fp6hxSAAUrzgS9KcuzUOvVtlKdFeeIvdDqgjLdlO7QOw3H7v/D6a8xA7D2bVnmlc308bNfFtNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tduVQVf5sRHYzO1k5MdrVHFkqnby77Qq0ovt92I9vFk=;
 b=WT/HVwBvNTRbSQiVlaXIRRH0Cy/LhtjUKhdf1DFIL/bIibjY8lbR8N9FQonEyD4chz09N0zsOQ81SXuUyYeN1Vjba8F1W/F6QHbHAjPr3/NsUzAn1352sX9YH+kqZ6ct2HGZ78U6gXW1lTgiQA6MQHLT7gXpsb9pz4MH+PcipcQ=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by AS1P189MB1912.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 17 Apr
 2024 20:57:04 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 20:57:04 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
	<mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Dent Project <dentproject@linuxfoundation.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v9 00/14] net: Add support for Power over
 Ethernet (PoE)
Thread-Topic: [PATCH net-next v9 00/14] net: Add support for Power over
 Ethernet (PoE)
Thread-Index: AQHakNVHtcNb31DvJEedkVvpiHJYm7Fs8eaA
Date: Wed, 17 Apr 2024 20:57:04 +0000
Message-ID: <ZiA3UKgbLOa-a9Le@p620>
References: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
In-Reply-To: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|AS1P189MB1912:EE_
x-ms-office365-filtering-correlation-id: 8ba09f7f-3e76-4485-666e-08dc5f20efc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MxhD1g9Dr/wvLfCleXPpZ72NsYYx5FevdfGKz91XQCmsgbVTC++vMU68xHowZqPDawv+F2G3FJuVC1kT46NhY6fnY1Ak9jLfsrFdZbGjAJYs9nCU296Dj5qMa/3YeNEB/Mn1Hz8BlxQa5RlfkX2wWoi+9zZ7u5jW4CQFTnlTeAJyb6+SdDTPBxg9YKLxevTe6ujAMd7pMaz6JOEqgcwLt4UdVhfYn6PNEBR1h+z6/OkKsMI2KjckT/T2CG/vD5SYMT9F43kfB+GmX2GTYvF/Oaf3eSu8J/68HwCD21z9gOcpTJk0O7ID0rPBWZRC3IR6MnbnSSk3Q31JvmrQoxIPPQIr5mZndOTpoBvUwFdUMpl8oHRzlqIvnKjXUsIF+HI8Ao7I2Kr1tX4hj+qCZcp47sBLaJm4JoViqTKRXOiiNs8FRwwUXXffQBwCOyYm9OzOidyJrlxS+UiIPFK4b/A+QdF48HcQn21OKuxbXPqo2JhO2SaGbLDifhTPXf2wPO08+p5ylv5dT0/jocz7CyY0E7aMgWeCCOAC0XTbn6FEXF+VimHRuNJA4yxGxAwQJBoKFCZoSHvPadz3IQ1ch24HYi1a01QnGyiIPBvs+vnoptWHcNe/4gls8vv4kZ+okFqv3huaOcexXDklRhExycFYZhbBbYOtoIzksXuCAkJN6DQWwB75LuZjUc7AT7lygdWQx3iz90joRvNIisFbVnlJt/wQ/IIf0+Rjz/eizOYHdXc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?McV3mC2nvZN/GTmt80/jNw7dHCJmn7qetU4Jnyk0uG6tC27pgGWTUKnu9ARZ?=
 =?us-ascii?Q?6LGzJM08WumLmeFLP05JvHYHbam1qPLc0hsJ1JyRIZ936P9avvDTvRXDDEON?=
 =?us-ascii?Q?fwyWVdg16z9pMn6wPUIM1GjEu8CReHGL6LlBnsagX87LUh01q2yNusW52wqb?=
 =?us-ascii?Q?4NjO3j7N4U4N+Y3HWDTh8A2UmCoKIWLPz4LO1tPZMiyoSZoqFEKuNd5TYYYk?=
 =?us-ascii?Q?pKfONs6MUeKH9CJkDwHF4weVHsix3bWW7PWzRRA0mrOv2v6DqaQ7uToyXG4g?=
 =?us-ascii?Q?UPKzm4/cQJ9oHVqsEsI/M4I0y0RWVZFzBCGUijxjMwffZHUK/QwCpIUBpqgO?=
 =?us-ascii?Q?yysfV0BRt3pVubeGASESi7B+Nv3KwcVzGulaP8ojsV0HiM6945x7WN27+TL2?=
 =?us-ascii?Q?u78ZbMcS9nvY7rukEHXXPPCGQmlBVDmLUB6cj1vwfZW2RwS6LOMU3BS0GC24?=
 =?us-ascii?Q?KRrCEG/y6MZ943eFEzIQ+CVj38/v45KQ7JcGXTo5YbB+CzfLALi5e/xBHCjF?=
 =?us-ascii?Q?0+ZFuiobnL6O/KzT+UY0cSIZ1dFk/lVjIRf2eIlwLVZ1zD8CyAvepSUconyx?=
 =?us-ascii?Q?pqpmpsG+opi6wf7Pgj/R5f7KnFR41QJ6ejvEDjF+3DDNUJct9V4edLuDzA8I?=
 =?us-ascii?Q?yuGfgTXiEc2LNQfO7r/Nq7AeM0+5xfAhKaBjKs6GwQSN/ET9mhHX/YOv/HYx?=
 =?us-ascii?Q?+uyuFvzNkfid3PJkHFs1zcB3JMQ0uZDgzjGg5KDlqXMwip7jDhXFJY5V7mXS?=
 =?us-ascii?Q?3STx+4gwUMUoeEpo1q5N4OJUI1Im5UN9KAS7yRMy5WXADwh7MWD4rdTlU+ui?=
 =?us-ascii?Q?6TR0GEfv2kcG7MOljX34NbeHSb9M+6uG79CmCBqZgHFtu4lcHQ2JiFLVHo0/?=
 =?us-ascii?Q?j/e1IakoLmdklik2wZKdJizdunaO8iC0DapBkR2FVLDjh+jjGOmvCoZrWCLf?=
 =?us-ascii?Q?Vq12tRTKRug22GBgi3AnZ5MXzN07wWdKKry/Sj+/wrUjQ8iQ+WHUtyHI4TRZ?=
 =?us-ascii?Q?9e2cx5MCnedWEsZQp7Wdk0dzhujykxu+/fvlYLFOiAkKRyKHBOZ8uX/Dq/3X?=
 =?us-ascii?Q?dfryxhMRboSxf1izAwUnsgBgg7xoQc2IiRfFgjej1a20hm5bIef9t2UQNegF?=
 =?us-ascii?Q?XZtC6usnqiD9+vcU7c1dyMhkpI5B6f8DuN201Z9BU+3QNXQqpVU65GgDrlZQ?=
 =?us-ascii?Q?DbX5yI0cNucX29xKZK1VpH1k9NE0E6R0mbMOwUZ7XOnGIR41WiOYWro8YhXb?=
 =?us-ascii?Q?waCtFklCP/HiKWefk5+/yIos5hivQkGY0VO5+R4/jaBkUjkE6zqn3qVkznX6?=
 =?us-ascii?Q?TWSj/enRgPUMgChlJMFrkYiLkrnrwFMTBmafVCfGdrGnhLcNuxaM1AMNUlQb?=
 =?us-ascii?Q?P7xpCBz5WyB/y6PxDpYAECxhbcYiLtYnUsMRtVB4YLHYd/Wq08qbejsLYvRG?=
 =?us-ascii?Q?SSof5l3+3Y+4kfPDyaiNxSn0GORWrKm3BDLcKF07NvvsJqz4Vw9qnr2GbKNO?=
 =?us-ascii?Q?XG5Z78+9QTx6xvOxPc3z1PoPHbGy2qAbY+u96oVlGTAe8lPGW+bW4XLooZZM?=
 =?us-ascii?Q?DCH9H+fPNq9wIODmUIrBaUg52p5m6/wxavZX9ITC?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8467FCC43867542B7E91EC0CC01C565@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba09f7f-3e76-4485-666e-08dc5f20efc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 20:57:04.5850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lwk6yCgC6Mm4GNLnninKgWBk4+WUOK+F9awoOMtXpnv9NOuBQNAvZtwPYq7U6Re+bIkcY/zovjP5sWQ00630hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P189MB1912

On Wed, Apr 17, 2024 at 04:39:48PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> This patch series aims at adding support for PoE (Power over Ethernet),
> based on the already existing support for PoDL (Power over Data Line)
> implementation. In addition, it adds support for two specific PoE
> controller, the Microchip PD692x0 and the TI TPS23881.
>=20

I don't have much in the way of review comments, it all looks pretty
good to me, for whatever that's worth.  I am excited for this support to
be mainlined, it will be super useful for our routers and provides and
extensible way I can eventually add support for additional PSE chipsets,
like the LTC4266 from Linear Technology.

I look forward to working with this to add support for port priorities
and power management given a system-level power budget that is less than
the sum of total power that could be supplied by all ports.  I don't
know exactly how this will look, but I do know that without this first
part, it wouldn't be possible.

So, great work, and thanks for the effort.  It's appreciated and will be
very useful for us.  I look forward to working with you to build on top
of this.

Thanks so much,
Kyle=

