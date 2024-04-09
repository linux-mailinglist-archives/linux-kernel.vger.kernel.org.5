Return-Path: <linux-kernel+bounces-136816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0A989D89C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684F11F22D6C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A01129E93;
	Tue,  9 Apr 2024 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=asem.it header.i=@asem.it header.b="d/HaoAXL"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2131.outbound.protection.outlook.com [40.107.236.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6A42053
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663827; cv=fail; b=nPbsoErp5lvBg/gkgbaHm5s7Gtay4odYfDymZasKJkuYKt0MKb+jxb+bA1yIHQFXj3M2ygJP3QYeZRViRX8VxnQYBW53k+LZ4rrrvf58fEiiMaZJ/Bi5VyVYH1jbYatgXgnvwJXwucUEwDwRAGrdkX1trt2c3TBi/mS4zskNYFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663827; c=relaxed/simple;
	bh=8K45sA6ph+Wd3TxGL7sY+00G1gKprxNTj34JplnOCeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LYpQxCdXqQ1HeJz5bRplA/yNdo+qRxwteF0Tp+xq86RquxiuR1uLQvnLY52DzV2zudYb4AsE5VDpoHR6g8kKJJDggTm8MtWHU4tqGcbvHdIdu+uIEilXtV/MNb9R2ZPnccdMpFSppyDBtg+Zje89NCMDY1aO4ejOMPOAeZkTmVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=asem.it; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=d/HaoAXL; arc=fail smtp.client-ip=40.107.236.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asem.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPUyJihhWktiZRMRTOQ71sOP67TmqxFoUOzDQmQp5YlVQQsxxwBrUApBme7AxpoiAyeUb4wLt79+lLnp3luUo4SpLrsk5vEZT4NxnTswtolOCvEO0PGJrTxhHC6D/cG+7h4UDcI4OPagKjnmWU3nYueSH0MvQjDfA3+5pGZzPDUAxmE3beVi+HXHNeFJniNXIeziT6N5LPMfEG1Quc+VFmOv3uDNmw5mqGs2h9tdM0MV6tq5sPYa1eca20Co6d4/53Oj4gZFc8Ojk9glP/DlHMGTVREIe5XA/IZHnN5bcQH4zA+EEo2tIg/ZAuZpx969ac4aWatz1n2DtNcslY9oaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8K45sA6ph+Wd3TxGL7sY+00G1gKprxNTj34JplnOCeE=;
 b=nFC393eAf5jUCbuZU7d6dggR44H/+cankd2mFBOMmalYur1XO5uobbH4Tmo/U/P2XSVcQcBpa/Hni5iXaoiQDpZEaL1EDTFcpvP6OP0zp4B4nmcjJGvf+BbMKmTx6JUkDdpjUIsL5ax00F3NA9mv87iGdQI9FMc8nGJKc5zN/hxS25w6X8UzrXD5sszN+gcmq6tqi/zsIqPHRTfccj/Y7bwek5X4rMzvYYK1Ti6ljbGPYCW5FetkoYpu3P+NZnCP44g4WO/HmdyJXM5B7mqxpi0HWyoOgYXTB2kUZT5Bio9/C86CzaY+yA27ubJtKhwk7rYk+uuWzZ5KGRF2eHpzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asem.it; dmarc=pass action=none header.from=asem.it; dkim=pass
 header.d=asem.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8K45sA6ph+Wd3TxGL7sY+00G1gKprxNTj34JplnOCeE=;
 b=d/HaoAXLudviWWAPdgQTjiNS/ZSNUheSkxslhrkr9vNiMSQtc8S4q8+G8c1oalsYaveuH0PuXWyntmeCgBq28avyIxPdv7D5GRR1e6ONsyXINU0haMRuTlK1oU+XrCLyc2LW9vdiy1ruO5CyZ9skOd4HXRveAR1VwvpWMB/PZvzlaGXQ0t1v6ezhXFHLMSNhjGxnJtY8c74pvn/I/bAJDjYhcLqGU8BY36A1xSe5tYh2mq3gocw+vfsK3ktdTpskcHtEIBZCgTgK/RcVRDo/YSLDCt47AXHd8oRrvuqStbZPg+LkaArbbp/EMJ4UDyN36goPVBmQwaQwXuWUPe2mKw==
Received: from PH0PR22MB3789.namprd22.prod.outlook.com (2603:10b6:510:29c::11)
 by PH0PR22MB3790.namprd22.prod.outlook.com (2603:10b6:510:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 11:57:02 +0000
Received: from PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::35ce:ff48:fa8b:d4a7]) by PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::35ce:ff48:fa8b:d4a7%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 11:57:02 +0000
From: FLAVIO SULIGOI <f.suligoi@asem.it>
To: 'Francesco Dolcini' <francesco@dolcini.it>
CC: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
	<pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: EXTERNAL: Re: [PATCH 1/1] mtd: spi-nor: everspin: add em004lxb
 entry
Thread-Topic: EXTERNAL: Re: [PATCH 1/1] mtd: spi-nor: everspin: add em004lxb
 entry
Thread-Index: AQHah1nAfXWnkfTva0GHRKLjc+c+r7Ff2yLg
Date: Tue, 9 Apr 2024 11:57:02 +0000
Message-ID:
 <PH0PR22MB3789745264AFC2A3DC86CE3EF9072@PH0PR22MB3789.namprd22.prod.outlook.com>
References: <20240405100104.480779-1-f.suligoi@asem.it>
 <20240405100104.480779-2-f.suligoi@asem.it>
 <20240405130359.GA308940@francesco-nb>
In-Reply-To: <20240405130359.GA308940@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3789:EE_|PH0PR22MB3790:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 v1EH6kS998pykQrxspwJXaXuBzicCPS7Dvhws/Amq5vcV8JyaIVptA8h8ogyA+pocyqCqNPf7Q7lPU31gJmamJFlR33a5n+JOYZljaNGR3SCb728km8ERVvG9BOaDonFsXAJlv+grAyRRvGNBIhF5gX5c+Reg7ipjCvxtPorj54y8Jid8LlmnfwHD9/qm4+LkWMoWBNH/ih8rhBroeO0pDFPcQvXXIgSuQOB6nNEW4M1fcpO+SWvaDSlMn85Rf2+6gB0UmcfdYt1HMvWiXGNUlyLWLNzhfeDackEV37Gdv4BcK6+gpRtCyVrM9+4D1hoiDEpXl8tc52CrWYN1PaHhAsE6bI8DnfDylSBfH6Q9sMeqKB+xz9n273yaH6VICwfMadIEw1K0FiSjKkHnAnakPnxwv4NKDPoOFjuWDeF3MyLMxTDmttHLKhPM9ZmINrH8eOsq93qod+fTBT5r1uFBUqVIqfQXlHb14ZHXwHC+VCrF8e4Pyhgd7fc5DjhqSMblkNrDeIO+eAlRTBJEObD5waxWwycsR1W4zbLK7VvZQnmgRaiNiUSSRUyo9qrW8dHTi1iCVEF745GVKHW2Bjj/B3voe7oh0nWlCJtFhRYgqs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3789.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Pt+/AUBJKE6RX1ka7KV32GhlBOjcFwkSIRf7AVD8QMtkHGHA1zUnzoMVHy3E?=
 =?us-ascii?Q?aPyroiAYHM4C0Vftyp77UB75EU3AUflvj4eaf7C4MU/nY5bgZTrq+4NbRWDZ?=
 =?us-ascii?Q?Wxwa52B4NGbhkzrRy5MhzFKSfLlF6ZfKvA+UMQDltOZMpzt1Ew5BSVi2rR2C?=
 =?us-ascii?Q?fifQSg85zez6Yiht/zeym8mBNtcaiVcAs6h86y5n8am1KuNMX+0Y6XzwNbvh?=
 =?us-ascii?Q?iJiRhWssVVAtzRXpS3cz04eIpYEgn7eRt7jcqm1RSYhZkJM6x8dBMsC9mdeJ?=
 =?us-ascii?Q?27qsYy6urW3ekpd8ehy90IIArUFBXO/eSqbPr7qE+q9ebOE9HyKlXPeW6Ojk?=
 =?us-ascii?Q?hgJqopi8kl5blt3l3aNwzaa5+7d7nrE3khSaWyIfDEvqxbB2jrXQQmVARI8E?=
 =?us-ascii?Q?evNdHNLGILDrk6VRA1ZeF1U5Bs1ZJU6VVCI77zwnb/pVmfFn7W+N9tbuxgoy?=
 =?us-ascii?Q?n4V/JDBk/CFbS+7KmKCLNAi2KngL8qIthjX9114lHJCqQAn47t00W8aJCjxj?=
 =?us-ascii?Q?QaDe2Ol3R048fIMyCfCmcgIs7jB0ftx4oqKxDrAHO24HHRCermKge3X/Xrc+?=
 =?us-ascii?Q?OYdyzz1EKv4EInlVaMb+Zur6bKs5N1PA95Uq8d/XLnDtNcbLqkgqHxSJg06U?=
 =?us-ascii?Q?HL2Gk/c70uxPqLVRRlOE/sb8t+Gy9NvnhpCLw2td62IOITlC+xe7pSeAC5BK?=
 =?us-ascii?Q?8dYGedy85Jii6KtI664x8JEBP9WePOl+cJCGypSJIEBFNj60qQbKkG8QaSdu?=
 =?us-ascii?Q?izO8vNXsKflfJwZBL6uUL+JUjJ3chlsPs5iG9bkUUKLSzBGK11OmYg3DpqNf?=
 =?us-ascii?Q?oZmNXc7muXmdSpuLEUZxL3MkKcmiZBMI1E33V0nyzSAkdBe8jIMJt60qkP8B?=
 =?us-ascii?Q?jc2V0QgoIwF1FG6bvkKLRssfHrOAXv6roOGjfuldm6LeJEUJF0KugjOY1odz?=
 =?us-ascii?Q?dX5i4dHe5rPYrKVkuEJPe3oHNxsO2pm3OG1Bv6apLd5NLtKLo2yjcP/Q4nNO?=
 =?us-ascii?Q?MJwNXn2hd3jHf5DCXOFYpzk19bfHIDCTO6oSYDyTc1Lel6zib9+cUcTAzUFd?=
 =?us-ascii?Q?8XrPU5ksgBFaRSOxIHWiA9l+9jL6V5WTmZ16DINOEjFvh+k0VcUADG28MdCW?=
 =?us-ascii?Q?U4ZqSleK2w71b5hw9QsB1R9S3T+9KBYOmoec3Ika+IFIH7u8ilDSlPUK9vy4?=
 =?us-ascii?Q?6qDNQz7dSe5YVKK/uH9c4KTqLwUtiWrRgcvU2jqip8eDmbTn+hUoBvgb8oHP?=
 =?us-ascii?Q?fi6UhWnPzl/6JpbxWBNzxnSVdRHDmgsQL8nnLvoqvKCXuBRvbTd1vhIUIFC+?=
 =?us-ascii?Q?qA5mPKTWvQ3xRFYVlkaYB0IS2CPBljHcpamQU1lHQ/c9QBQ1evLn2Yz35Ky+?=
 =?us-ascii?Q?nPW1hd1DooXIHZHKSh2R5lqc3GaoMPHVni9ah9uZZSGseAf/KOwgkqwUD6Cq?=
 =?us-ascii?Q?TKDPee45M5Pq1XhjH9T/qDXDvxXdU1Y1qWBh6PBF2DVFRBz9c1pbtUmH3TgH?=
 =?us-ascii?Q?G2AUJLw9XzI3/Qr6Gec3UXuTAzqozStxhxpxlxSM534h7GY4qQxJ+BxlA3ly?=
 =?us-ascii?Q?ID9/PewI49O+EWvOTLKLQWHZE0GtLZmIdI6GAllO/aIqT+0GmUprywN3PZYR?=
 =?us-ascii?Q?7s/NML5WVHpYBeOIt03ayx4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR22MB3789.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7f5501-0319-4f62-c314-08dc588c2b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 11:57:02.0633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 855b093e-7340-45c7-9f0c-96150415893e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ep77AkKTMBOBuHL1u/dIKyv0mCcoLQtcynlxO9rB6SqBFk9vPIPdTk7s+rwct13djIn8Aw596abPQdtezthJ1ofok6sHzNzRImBt2OaxVo9vRxTUCQz24OHJ0vs9y3rT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR22MB3790

Hi Francesco,
..

> Hello Flavio, thanks for your patch.
>=20
> On Fri, Apr 05, 2024 at 12:01:04PM +0200, Flavio Suligoi wrote:
> > Add the Everspin EM0004LXB 4Mb (512KB) Industrial STT-MRAM Persistent
> > Memory.
> > This device is JEDEC compatible (JESD251 and JESD251-1), but it is not
> > able to provide SFDP information.
> >
> > Link:
> > https://urldefense.com/v3/__https://www.everspin.com/file/158244/downl
> > oad__;!!JhrIYaSK6lFZ!tWeIxTcqY-RFxb9oTGXkVDvdN3bGApINZBts9sSPv-AIlH7r2
> > xf0to_QuyONQPwOICeq6hrz5Ia-1e6vT1VfaA$
> >
> No empty lines in-between tags

Thanks for your observation, right!

>=20
> > Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
>=20
> Francesco

Flavio

