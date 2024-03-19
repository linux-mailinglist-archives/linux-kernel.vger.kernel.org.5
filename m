Return-Path: <linux-kernel+bounces-106887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934B687F502
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9820282508
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D517C64CCE;
	Tue, 19 Mar 2024 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fvqooafD"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2097.outbound.protection.outlook.com [40.107.7.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8D0612F6;
	Tue, 19 Mar 2024 01:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812169; cv=fail; b=T0uCodGGmolMqAWYqjEmdcYl7kZvLglrhiJ18oEBE2d7Lut9A6oemxTdDKEAW62atOVL9s2+5LMhlIn9bjm3v3qX5xWoPKUIsp112bsrmKWgrA022CNhKErRl8yago4pPqRRR/1Y2lACxIYDC+VTK6+/7jFKOoEQiWRZAnP9Lnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812169; c=relaxed/simple;
	bh=AGu4RijYxA7HGS2jA7Ybimg/LzTtSVyaGe/4foDTNtM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LTsxMhp3WlzZv8spXnbSMXZGTHIQCH81NnM5ciVPTDJDBUTkDDLLwfvAZixCA1sif6lpEzXtHkp+ZKqG0aqo8kxzn9rHl28SFwUt9Humdsr1QIm6WQdgCuKGznN6FxM65iibdWG2DW8YTTh90gdNOO6l8SmcgJLNHN8ESPujq2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fvqooafD; arc=fail smtp.client-ip=40.107.7.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHORky6F39cY5y5SL+QI773/rLQ1dmnp20JqITdnzh7wMup1Mwbv3yGksW03hwpXeHSWU2RGU/Bkq7LnZMBz7Wjx5sjmB+9trSGx7utyb/5zcx5EQugYXbT7IFVmkJa6ElmORQnktBAZ5oyoRAktO8VNf67zfoTTtci367hpfs/cm1nxrDf2pJjLvajPwhnZxO51OWbgoZWWmiXAoIVYv3Hz5JbqB83vQLJModII5cL1lV+PlEMH1SleZSWl2boTFII1tX0rH+uKOqH1WvX0U4JaUuYm1w6PssUZqYWul2RQ3HyLOwkHtnR7Y34UftHRd54/qN+JtqMFJ9dRE1+aYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZarbMn9wVjZsK2tBgF6PjIVnzNwYLRfbtwpz2mc0EFQ=;
 b=Dtscnq36mLmbumc3D+VQHMipFMTh4PVlke2GqgCqT6UIAurmmL2am2+mwej4wDTEhzPBaxSeArHBdK1sewgwHyGKST1JGvYSJ0yN30r7va8MY0Bk1kbAnGA31zQkqzWPzU6wI5KVsVw5v03XsGPZiZ29AW0atqjosuDj8nxZx6vRrCi62QO2hd4oqd7W+rDMhTixiglUoixH1ptS0GrBk7EY21pjenQ91QRrj4msPLiBtkifdGM9JiBNAYka5VaQEaXUHqPCR4ENdZNjlSz1Fopp4rnAq6sjcj/0k+KV2QoiK09DSkmbtFjk+IRfeT9Lm7FmADytHl9oMXyITemeyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZarbMn9wVjZsK2tBgF6PjIVnzNwYLRfbtwpz2mc0EFQ=;
 b=fvqooafDXeQcMuyPtC/ZF5Aiw09IB/wFC1tKexP43yyt6jnrIT8EOG0VNIQYZ3kHAKQVmwHAKR/ZKpDBBEadgBs1prOtpXNi6K4/poQHK9xcXDzqsRVp5UxHRQ2SE0sThpla0Bbd9dcAO2LewqJLH2rHIq2ziSYG5+VBCb3V9QU=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 01:36:01 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 01:36:01 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Brian Norris <briannorris@chromium.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, Pete
 Hsieh <tsung-hsien.hsieh@nxp.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v9 1/2] wifi: mwifiex: add host mlme for client
 mode
Thread-Topic: [EXT] Re: [PATCH v9 1/2] wifi: mwifiex: add host mlme for client
 mode
Thread-Index: AQHab2opv6Idy9UrJEGIWaaBKnpXoLE5iv+AgANDAgCAAKWbgIAA6H6g
Date: Tue, 19 Mar 2024 01:36:01 +0000
Message-ID:
 <PA4PR04MB9638742AA1748A9EA7371FBDD12C2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240306020053.18054-2-yu-hao.lin@nxp.com> <ZfThCwGj-P5Owlsn@google.com>
 <PA4PR04MB9638F2586DF7E8A41330C8C9D12D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <20240318114131.GB9565@francesco-nb>
In-Reply-To: <20240318114131.GB9565@francesco-nb>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DB8PR04MB7001:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 y6CrfB3Hszrce84uYjRV36D3sWYUcEGRXaYv2VaWQHRPNzavUAVBaJUzrzjD6ogVj98BAewFYRjhkzDD56eryrDSYh3xdecgViCOYLzl0f7aWllUZ6iB/sK18sh7XgAYcvEMexkgbRfxfJl4+ZG1jAN1j0ehp1tJEbOGIw0w3imyL8VE91N/xlH3cMXnqBVCDfUM4zc8aH44NT4qP3qLjenV6smAJMqUymWeSEW9HzbqTD7VJkj4Lg7AviypRX3tIxO7XN6wFwaxT9VhO2zF8IL3gTLP3qpr52Um8x9oKVFVZCDHXbIO727hHMs8q0WqiGv6jBbKsW1xnxvH6EKvvhgVRvpwOm45KDR2BM1vRZBwICzo2jr0nBxupXGAQh7gTP1nKgOa8kLq7fi/rRLgGvIGXAexzxkv3cgNZjmk4UAYBcA4e68OKf2rf/taVJv2Gm9NlbwaN2sHdeU4di+DE1TQAkSKgpZBfJy7WzoaprzErdBFa/gb4MBU9ocUBDh+ksIpq26V93uioZpEoLN27SmA1F5kArZCs9QDy8UJ1pt37OJdBsJvZMjjv6I6+UYu1uysYpQRlk9PjRYbECUN+ZM1z9+RNsh+TSgiOlMVuuY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XG21BmbRSpH6K+LRCuAZN1/CiWHoVn6C770VFXeBe3+jmKvUDB9RfZrSvhdE?=
 =?us-ascii?Q?rC7r+MukmWel4Qpce5PRM/iY22GeOGnilpXY3ZkVbEoConVRt4GAlgA2kkLy?=
 =?us-ascii?Q?so+HDmyf8yg7YVb1QyEswUmEm8mp/YL641HsDyy1mjjjoWCMpqiFvVbP1W9I?=
 =?us-ascii?Q?LHIvXGc6Qt+TC4QfoYY8rAtti9RWxU4UUA2OxKiPgD9skK9jjOFxRa72b6LZ?=
 =?us-ascii?Q?/Kxt3WDHKZsUe0BWU87lAB1ndA078FibWQqNAx7iTy/SO43a/v5Q5U38rSch?=
 =?us-ascii?Q?418PvPvyDo7Su1xxGp5qCIi/qafmHaMJlXjNXsAJvYqhExRY67Fe7CiF+DB9?=
 =?us-ascii?Q?B7bPIVzQlCVmfCKQgH/0zMM06F6yFjM4nTQfikIDLCVUn7WO8QcNor6Lbdvf?=
 =?us-ascii?Q?naZz/HO03KLfV7KWWu9yoJN8kZE3lTs5Fs+Cg0Z4P7uig7GaOHxR8UbFcj5w?=
 =?us-ascii?Q?2LJpW4hk8y2SXKYumffPAYGgswlBb0n/V01YNRkvn8XDAFYAJhoDwoq6Ah1g?=
 =?us-ascii?Q?D/ZEVoujIkvEg42yZDtK7uYeGdAqZ9BGX8TGKo5pPp/iwmNGjbpkF9wNZ6b3?=
 =?us-ascii?Q?4wJ8BJwi6Ik+dBiBYxX8Gh6FV3DO1WHEC2/63rcZz7Kl0zy5rdGdGPb3I4Tu?=
 =?us-ascii?Q?WI7V4wYk7sZNxeRnmeVAXw8HBcDkMqZPcK/y0zpEMQLUsUEtsXe2hFXWWZ3J?=
 =?us-ascii?Q?6Z04v/zoB7Bq9qWYn94Y6p9/a9q3peIoeAo+Nqgyvzt6uP/1d7553tigNr2S?=
 =?us-ascii?Q?qwNZTh3srDnXKIbuOW6AaqvmkYZqlNn2e3rTHaiJMYmAC7ylAJLWgMcPkrLP?=
 =?us-ascii?Q?WCXdYqGQfVMaYp4+mcI3a6Cqckx0eDzk+B/5a1bsccSEmi3g6qTScGzogE/s?=
 =?us-ascii?Q?zHRYbRAyMY+PacUzD0hMGc4z5r1XiQP6FqDZ2LLcMoU86xOyDC+kmot8NYPn?=
 =?us-ascii?Q?iYerZib3jAoKlcwCX3DikudDjZBKj5gEdeNu/EOws26vijxktrOTkc+tWZqc?=
 =?us-ascii?Q?Iq3u92Ccu2Coc9EizQI6NmP/q4ssp7bMgBaRUy37U8ih4UrdsxvaZRCZRRVF?=
 =?us-ascii?Q?QFXVC5eDKo6PkPfJ43xkzz/47lMhIeewlsbRvXGt13VF8PkEJ3IhEZ6GuDH4?=
 =?us-ascii?Q?e5pCbHtm8jZafHbRFXlGUJauj2vZZKnnxs6ArOSRPeApH/f/huGPSmQWLkFc?=
 =?us-ascii?Q?1pXHqLUJLNuZtuib5/rzE7EG6weZDNPisAMrHBwlWfZKhW8fBftk2jWAO8kg?=
 =?us-ascii?Q?c5DItpn7Yp1GW6bkz4bvdfXPqDrGe3Hz7nC7eKitjvpZSIO1bEl+RWFJZPLw?=
 =?us-ascii?Q?lVWqrGG/Vv0N3MM5wq/FBHuFoFTg4Pk4wjy0DOxCQBWIN4kZCN6zywCjCtao?=
 =?us-ascii?Q?xba67k65mKmZ778bHpShJFtYP5qUN98SYVTAOBOTElWYk60IZxClEtTm3oZ8?=
 =?us-ascii?Q?xo9Jqml0m6e6hiUXvtG1bthM6KnfJ4tNC+nr5SkWQDBHaLDwL5I9NB6VSE8n?=
 =?us-ascii?Q?yEU6YjYJkyfkcF8oUeIf781GzgfhxEOqQrRTuO/wzCGYJENEVzv1EvsHI/TM?=
 =?us-ascii?Q?Lxizn4e2U/rFnom8tKYBrEDBhRvFlk/QaLQ3SfG0?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8070eb75-404d-4ee5-e001-08dc47b4ef4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 01:36:01.3650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92lCYEb03p+Ra5WlJWVi0dprCHVfq+sVT6cdwbHIJv7w116hNss3if0oCJl9xY4IJZuZpNIThKOgL6MlpMQqyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Monday, March 18, 2024 7:42 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Brian Norris <briannorris@chromium.org>; linux-wireless@vger.kernel.o=
rg;
> linux-kernel@vger.kernel.org; kvalo@kernel.org; francesco@dolcini.it; Pet=
e
> Hsieh <tsung-hsien.hsieh@nxp.com>; Francesco Dolcini
> <francesco.dolcini@toradex.com>
> Subject: [EXT] Re: [PATCH v9 1/2] wifi: mwifiex: add host mlme for client=
 mode
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> Hello David,
>
> On Mon, Mar 18, 2024 at 02:00:35AM +0000, David Lin wrote:
> > > From: Brian Norris <briannorris@chromium.org>
> ...
> > > >  .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   2 +-
> > > >  drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
> > > >  drivers/net/wireless/marvell/mwifiex/util.c   |  80 +++++
> > > >  15 files changed, 671 insertions(+), 14 deletions(-)
> > >
> > > (Per the above, I'd normally consider whether ~671 new lines is
> > > worth splitting into multiple patches. But I don't see any great
> > > logical ways to do that.)
> > Francesco suggested to use two patches for this host mlme new feature
> > from previous many patches. I knew it is a lot of changes, but I think
> > it should be the best way to add host mlme with two patches (one for
> > client and one for AP).
>
> What I explicitly asked was to not add code in a patch, and fix the newly=
 added
> code in a following patch. What you are supposed to do is to just amend t=
he
> original code when you get review feedback.
>

Yes. I will do that for patch v10 and keep all 'Review-by:' and 'Tested-by:=
' tags.

> Splitting a big patch into multiple patches is welcome to easier review, =
and this
> needs to be done breaking down in logical pieces keeping in mind also
> bisect-ability.
>
> This [1] is an example of the addition of a relatively big new driver, an=
d you
> can see that the series is broken down in smaller patches like "Add skele=
ton
> PowerVR driver", with intermediate steps that were non-functional, but th=
ey
> were building fine, they were correct and they were enabling more effecti=
ve
> code review.
>
> Unfortunately, as Brian agreed here, there was no easy way to do it for t=
his
> patch.
>
> Francesco
>
> [1]
> https://lore.kern/
> el.org%2Fall%2Fcover.1700668843.git.donald.robson%40imgtec.com%2F&data
> =3D05%7C02%7Cyu-hao.lin%40nxp.com%7C6ce04f812a5b4dd7e74908dc47405cc
> 7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6384635889617189
> 65%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL
> CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DHPgEuiKfmtEicp
> PfTz57piOdOoT0iQfo5qnPp9p6jlY%3D&reserved=3D0


