Return-Path: <linux-kernel+bounces-105642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B7187E1F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27D81F22483
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3484A2032C;
	Mon, 18 Mar 2024 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kRx56UiG"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCF61EB20;
	Mon, 18 Mar 2024 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710727242; cv=fail; b=TppbwDvj6hem5rva4aEwt7kiLlZCyB2UJw+lx4o9Znx3EiVijH4OYK2LEeQRVCEgg5LkwdtVREzarArWcv7QKof6FW0iYU0RRyq+ztHXeU6tvRV5ALdLY4YS/mk3AzkohqVtbRa7djJ//5XhGu3/S88vPcvN5WoOSjeVjJ8iLzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710727242; c=relaxed/simple;
	bh=qaMRSzhrJF6W5uLZqyfJInX3fbC/W7EhpBfoFcjqFe0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EuWfckRjNNhbcdN5Xlu2dT8n8dZgiQux1X1woS5uUT60wUNoZCG0g6DuLKQjjwsRht52RPYpB/fVqYa0XfG/P0zzd/rA6X5g9cjVNKlYgtgk20Y9SFcPenV/x7ALwWFvHo/8fDi8TScJPYSpjqvRbhw9MDNaCKy6AYOdyPj7qT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kRx56UiG; arc=fail smtp.client-ip=40.107.7.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4+/sjsxY7A/2ejYFMeMQ0nxWO5LV9c/R1JUdz8VS0OUZfPXgX345wan/C1O6nUdQMt9tWRWlw7Ok6GKtrcoXvy+/P4pS+jI+oFN8C5AhPZCPIDCxhY0Af/OcmTq9ODna8W3JXrWNv7pJibAC/QPYVc8FvJEpHaraE2233nideXALFa2FV5vvzs9W7WH+Nu9uDKgzoDd5mhwg6OyzN5uYG8NU9u0yn4wpcAOEzdN2GaknaOrfHUR6Uz1RZcv2xflK9VTxqHAVVa54SslOwh7K98IWUDf5ZGVylPb3V9m37ikeWP/Orqbl09IV/RauH+09pHG9Tjv3zhEPRAGdyvzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc4JmVsqW2oHHw8USRAhbX0f67a1tma9DHtJv9f4Pec=;
 b=EQfRiVhJQdcn7Y5g5/TSXAK7ywBK/+Aa5g38Cm2abpHOjnHq3lJCMNtKwMVYZgOGHqJYBZsN/jkzxHxxzKeEtg+hGHP3EUVELoy2m3n42fpGc3LFce4cV+zm2qMD/okiZQieXAnYioGKblPDYAwzfFOO/yZuDqtjq+u4JFfaRX0iUp9YE3Sn25T7uhSFlPmrn/8Yu2n8Yc8A+4OhhqDsyOUqVCQswIAmfRaQ1RF1gVGXY83uDQi/9aHDZ9kaprmzGtLdANASL0CUvmr2JNvzmGYQKebDBvDAcMXPAEGd+ThjRgzgh8i1AfUCCeFMm+Oc8A2GRLBi6NG9mojD1f0TxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc4JmVsqW2oHHw8USRAhbX0f67a1tma9DHtJv9f4Pec=;
 b=kRx56UiGWkdf+O2i/Ug/lKD3B39yVc1nI82PvMkEJVMa1FCvIR3URtPc+mItjLeFKkZQcMr9FH//da4uHj50Lc0WeBBLpiYw3ulEm6b26XUHPJQVcG8SRXkY/4g+7IqYdyxok5r8oFFrxfNqVi7DkDHZskS7nx3xeEoNq5vmiRc=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB9851.eurprd04.prod.outlook.com (2603:10a6:150:118::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 02:00:35 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 02:00:35 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v9 1/2] wifi: mwifiex: add host mlme for client
 mode
Thread-Topic: [EXT] Re: [PATCH v9 1/2] wifi: mwifiex: add host mlme for client
 mode
Thread-Index: AQHab2opv6Idy9UrJEGIWaaBKnpXoLE5iv+AgANDAgA=
Date: Mon, 18 Mar 2024 02:00:35 +0000
Message-ID:
 <PA4PR04MB9638F2586DF7E8A41330C8C9D12D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240306020053.18054-2-yu-hao.lin@nxp.com> <ZfThCwGj-P5Owlsn@google.com>
In-Reply-To: <ZfThCwGj-P5Owlsn@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|GVXPR04MB9851:EE_
x-ms-office365-filtering-correlation-id: db3a97d4-08e5-42a4-a238-08dc46ef337a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rvui8GuLu/Z73Cd7jyx0UMq/RNEK+KT2huLC5fD3lOHGoXEmEXK7RNUQ7xOEY9KwViD8nsFgcZ6pauRCgnPcefuzi+jINxPdqFdjdCRQ57t8Wq9zV2+4QlTsW05LA4JXbII2p/3uVg8LwhCQGdmLbzplxEjkwdXFLu8zksmgRf3e5XuukBjLtYDu8/o/jFy7c6JgC0GKTVRihf6t80rxVDvt9wtF1cQ7g2bM8xwjjSIm8BruPxqY1dFc2MZxQy/MJBoShONWStwLzrbWeERdO3BhkGhospjebNcJVvG0Fpin+qNGvDMeJzHfslFIaCUZxRx8MlE9JtWD7qsobBTVVxQI1zxZj6eDzdjnjtJB+P1arxFarAWc6G5mXbTKtw/o9QKw9oqm8oGV1V9BAsnU4we4xhKDBf5vzbxr66/m2EpnVf9RoA9AoMpTZHFFuBlQeGlAh46tY3SpuUgqdRgFxivXsn75jH7HvTPlDv9lnVwCbHtM/rAl8caOIDoZsSLhC2Xgsur/AgEb8DeF5c4K2x3DnmNk4wTPe4XpesqaOdS81Hv79WC09DpUXaHbZVEiqvJWb0Lcv6A1PeMtEZ/6qMuw5SbrUTHAO2o++mc0GuZD8GqkUL/ixIiI2uJYfmkG+I3KVXNcXMwyWDs0cabysh3KrddfJVJHyDusl4cvp+MN+o/92Kx/IomPbhCvkU2v4kvpNPHvo9iv/HjN5aJn4BC2iTEi0ohTkTlT7qLUC/U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?apytA6xVGIxeev/K9eefPIwDsuK9CEVeIHaFeXZ3yuMmkgBIVaGE4MPSX60O?=
 =?us-ascii?Q?7f/qhtpW6YP0Keecr1XEfGkJrWY90fY6FPG+IyLjxVdFbSApAWsQ5pZeh1xb?=
 =?us-ascii?Q?YursRoItQSxsQFnGDwzQyFRpwmaFvSXl3lOK1ySK5erxYrW+o602Mm74T1pi?=
 =?us-ascii?Q?CsoMRFxmoS/62WTaSIvcuj2ilrRDY/xHPTGRo2l9qXl6bvvPIF9s1wbHliUL?=
 =?us-ascii?Q?cp22tnipM43QA0uSCInj/FXgkOpTVo4oT7jygQ20dp77wW2ohCoS2r6dJHQ3?=
 =?us-ascii?Q?wBCSz/TBWrukkc6eXGNWdzOkd7XS+4rHJpcjxa8bncN9UsCssQTHJrf9Ger1?=
 =?us-ascii?Q?OLB3VFzyAzPaCFoTGemmcfhPZYQLG4gVNPXqWQi32wvYT/At4khfHShm2Mz/?=
 =?us-ascii?Q?TfcIZe5yiBYDIdr05d6wrgDx4yvoWmT16x2QeIol/CNt7UHkyo0GSiOazwus?=
 =?us-ascii?Q?lAznYYY7PUPaS0Or3SpLR5F0iDWpthucKNB3Z4Cznaf4nqLUPParFRuXE712?=
 =?us-ascii?Q?GkuBIfImXvcZ5UTtoakEPgbUEVfBoIzYy/3nHOVUnj5qMRQZb2Zh2KnKFit8?=
 =?us-ascii?Q?Liv6imIdSD2qYNr/O87aoGh6/SPeXHyIUiktrECb90BCuvUPAroODZj0D6L7?=
 =?us-ascii?Q?DgWgiwiOLZhbN2MSaQTT6RitSWnZLj3BkS5PAx2CJ/BO7TkyosVutTx/DTyO?=
 =?us-ascii?Q?HL9OkmfwczadcPoeZKIG1gn29U+aG/Xk7YrnXjzTTd09QKslqBVpdrgVIM8p?=
 =?us-ascii?Q?lcq8v6A7jfx+VrzdI6byChropwRDOBw+U+1peSo21Dt38JfviZj3gJqkJkho?=
 =?us-ascii?Q?tBd+Y2G3Ooiiat5bO2eXIDmPDL+36WZdf+mVNVTvC/0dcLoV5rSUVGBgDSon?=
 =?us-ascii?Q?kkwfPFa4DK/bbxL0ZuCW9st7JMqXdhoS1AiL0jW1eSD/d5BzJeCHCK4Xs4Xt?=
 =?us-ascii?Q?QwsXEm9Dp4ahMXK7Xhk9BqQ14MSttIe8CDwTjjTMr1WjulHJGQbBIr803VLn?=
 =?us-ascii?Q?5pIT8UmDOaBn9yUCSJi0nam943yrdOtX+7HUjPuxzbgtzCUMqa3SIUmixRrE?=
 =?us-ascii?Q?LFIEkVGsdusT9PqIzUcgteNPbbWtZPc+eRFIRg2j4CFZAQQCzcVk0hohcOzt?=
 =?us-ascii?Q?k6w6tt+ZVCynTTG68vohpgSZUNeSWhLjm0fnz+RBa+zb3k4k+mW2KfuAYPJ+?=
 =?us-ascii?Q?sWNld30Lo78bruZNR7AHLfh2FfXDCx3TE+nGItcdpab7KI9gq52La/P78mlm?=
 =?us-ascii?Q?TV4Jhh3dcGEmab58X5bvZkvtlyYt78xJQxd+iCF0fL/qHxW2Q30lkNUPXJa7?=
 =?us-ascii?Q?GTeBlpHQ8VMJMKqZvqVx2aGkIwwpm0Iu0VLnOXG01vyHWs3mEHyJC6wEiFZQ?=
 =?us-ascii?Q?+3/QQgIJCCC4GSMgmFE4d05h0phdchLBophhCPw2QWD2CG/5kzNwfag4kDhs?=
 =?us-ascii?Q?7KajVUVajOXjd6r37UWVhKUGKAf+/k06QNjUHQ+fQCaTKxlFZg8dnX1m+jym?=
 =?us-ascii?Q?5/bKiq3xpNQiZ3elfO5jQr665Foa9cgmg8/qG+1vRMmCsrPmxWY3ueuKOv3L?=
 =?us-ascii?Q?mkdtIY2jZVEO4Uoxcp4Idsh0iRZyOWWo6QobJ8R+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db3a97d4-08e5-42a4-a238-08dc46ef337a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 02:00:35.4116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfCgNBA0NZlgpz6Ak8ml74myR9eeHrgr1k6fRR16sBRBnHj5kh9Qy4UgjxUHiwUVSyyRNT/IpIh7GxO5EcIkFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9851

> From: Brian Norris <briannorris@chromium.org>
> Sent: Saturday, March 16, 2024 8:00 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; Francesco Dolcini
> <francesco.dolcini@toradex.com>
> Subject: [EXT] Re: [PATCH v9 1/2] wifi: mwifiex: add host mlme for client=
 mode
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hi David,
>=20
> Thanks for the persistence here (and thanks Francesco for all the review =
help).
> I think things are mostly well structured here, but I'll also admit it's =
a pretty
> large bit of work to review at once. So please bear with me if it takes a=
 bit of
> time to really get through it. I'll post a few thoughts now, but it's pos=
sible I'll
> have more after another pass.
>=20

Thanks for your help and take your time.

> On Wed, Mar 06, 2024 at 10:00:52AM +0800, David Lin wrote:
> > Add host based MLME to enable WPA3 functionalities in client mode.
> > This feature required a firmware with the corresponding V2 Key API
> > support. The feature (WPA3) is currently enabled and verified only on
> > IW416. Also, verified no regression with change when host MLME is
> > disabled.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >
> > v9:
> >    - remove redundent code.
> >
> > v8:
> >    - first full and complete patch to support host based MLME for clien=
t
> >      mode.
> >
> > ---
> >  .../net/wireless/marvell/mwifiex/cfg80211.c   | 315
> ++++++++++++++++++
> >  drivers/net/wireless/marvell/mwifiex/cmdevt.c |  25 ++
> >  drivers/net/wireless/marvell/mwifiex/decl.h   |  22 ++
> >  drivers/net/wireless/marvell/mwifiex/fw.h     |  33 ++
> >  drivers/net/wireless/marvell/mwifiex/init.c   |   6 +
> >  drivers/net/wireless/marvell/mwifiex/join.c   |  66 +++-
> >  drivers/net/wireless/marvell/mwifiex/main.c   |  54 +++
> >  drivers/net/wireless/marvell/mwifiex/main.h   |  16 +
> >  drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
> >  drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
> >  drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
> >  .../net/wireless/marvell/mwifiex/sta_event.c  |  36 +-
> >  .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   2 +-
> >  drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
> >  drivers/net/wireless/marvell/mwifiex/util.c   |  80 +++++
> >  15 files changed, 671 insertions(+), 14 deletions(-)
>=20
> (Per the above, I'd normally consider whether ~671 new lines is worth spl=
itting
> into multiple patches. But I don't see any great logical ways to do that.=
)
>=20

Francesco suggested to use two patches for this host mlme new feature from =
previous many patches. I knew it is a lot of changes, but I think it should=
 be the best way to add host mlme with two patches (one for client and one =
for AP).

> > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > index b909a7665e9c..bcf4f87dcaab 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
>=20
> > @@ -4204,6 +4210,302 @@ mwifiex_cfg80211_change_station(struct wiphy
> *wiphy, struct net_device *dev,
> >       return ret;
> >  }
> >
> > +static int
> > +mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
> > +                           struct net_device *dev,
> > +                           struct cfg80211_auth_request *req) {
> > +     struct mwifiex_private *priv =3D mwifiex_netdev_get_priv(dev);
> > +     struct mwifiex_adapter *adapter =3D priv->adapter;
> > +     struct sk_buff *skb;
> > +     u16 pkt_len, auth_alg;
> > +     int ret;
> > +     struct mwifiex_ieee80211_mgmt *mgmt;
> > +     struct mwifiex_txinfo *tx_info;
> > +     u32 tx_control =3D 0, pkt_type =3D PKT_TYPE_MGMT;
> > +     u8 addr[ETH_ALEN] =3D {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
>=20
>=20
> > +     memcpy(mgmt->addr4, addr, ETH_ALEN);
>=20
>         eth_broadcast_addr(mgmt->addr4);
>=20
> > --- a/drivers/net/wireless/marvell/mwifiex/main.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/main.c
>=20
> > @@ -1558,6 +1596,14 @@ mwifiex_reinit_sw(struct mwifiex_adapter
> *adapter)
> >               INIT_WORK(&adapter->rx_work,
> mwifiex_rx_work_queue);
> >       }
> >
> > +     adapter->host_mlme_workqueue =3D
> > +
> alloc_workqueue("MWIFIEX_HOST_MLME_WORK_QUEUE",
> > +                             WQ_HIGHPRI | WQ_MEM_RECLAIM |
> > + WQ_UNBOUND, 0);
>=20
> Hmm, why do you need a whole new workqueue? This driver is already full o=
f
> race conditions, while many race conditions are avoided simply because mo=
st
> work is sequentialized onto the main work queue. If you don't have a good
> reason here, I'd probably prefer you share the existing queue.
>=20
> Or otherwise, if this is *truly* independent and race-free, do you actual=
ly need
> to create a new queue? We could just use schedule_work(), which uses the
> system queue.
>=20
> If you do really need it, is it possible to key off 'host_mlme_enabled'
> or similar? There's no need to allocate the queue if we're not using it.
>=20

Will add the checking of 'host_mlme_enabled' to create this work queue if n=
eeded in patch v10.

> > +     if (!adapter->host_mlme_workqueue)
> > +             goto err_kmalloc;
> > +
> > +     INIT_WORK(&adapter->host_mlme_work,
> > + mwifiex_host_mlme_work_queue);
> > +
> >       /* Register the device. Fill up the private data structure with
> >        * relevant information from the card. Some code extracted from
> >        * mwifiex_register_dev()
>=20
>=20
> > --- a/drivers/net/wireless/marvell/mwifiex/util.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> > @@ -370,6 +370,46 @@ mwifiex_parse_mgmt_packet(struct
> mwifiex_private
> > *priv, u8 *payload, u16 len,
> >
> >       return 0;
> >  }
> > +
> > +/* This function sends deauth packet to the kernel. */ void
> > +mwifiex_host_mlme_disconnect(struct mwifiex_private *priv,
> > +                               u16 reason_code, u8 *sa) {
> > +     u8 broadcast_addr[ETH_ALEN] =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0x=
ff};
> > +     u8 frame_buf[100];
> > +     struct ieee80211_mgmt *mgmt =3D (struct ieee80211_mgmt
> > +*)frame_buf;
> > +
> > +     memset(frame_buf, 0, sizeof(frame_buf));
> > +     mgmt->frame_control =3D (__force __le16)IEEE80211_STYPE_DEAUTH;
>=20
> Hmm, "__force" is a pretty good sign that you're doing something wrong.
> Please think twice before using it.
>=20

Will modify it in patch v10.

> I believe the right answer here is cpu_to_le16(). It's a no-op on little =
endian
> architectures, but it'll make big-endian work.
>=20
> > +     mgmt->duration =3D 0;
> > +     mgmt->seq_ctrl =3D 0;
> > +     mgmt->u.deauth.reason_code =3D (__force __le16)reason_code;
>=20
> Same here.
>=20

Will do in patch v10.

> > +
> > +     if (GET_BSS_ROLE(priv) =3D=3D MWIFIEX_BSS_ROLE_STA) {
> > +             memcpy(mgmt->da, broadcast_addr, ETH_ALEN);
>=20
>                 eth_broadcast_addr(mgmt->da);
>=20

Will change it in patch v10.

> > +             memcpy(mgmt->sa,
> > +
> priv->curr_bss_params.bss_descriptor.mac_address,
> > +                    ETH_ALEN);
> > +             memcpy(mgmt->bssid, priv->cfg_bssid, ETH_ALEN);
> > +             priv->auth_flag =3D 0;
> > +             priv->auth_alg =3D WLAN_AUTH_NONE;
>=20
>=20
> > @@ -417,6 +457,46 @@ mwifiex_process_mgmt_packet(struct
> mwifiex_private *priv,
> >       pkt_len -=3D ETH_ALEN;
> >       rx_pd->rx_pkt_length =3D cpu_to_le16(pkt_len);
> >
> > +     if (priv->host_mlme_reg &&
> > +         (GET_BSS_ROLE(priv) !=3D MWIFIEX_BSS_ROLE_UAP) &&
> > +         (ieee80211_is_auth(ieee_hdr->frame_control) ||
> > +          ieee80211_is_deauth(ieee_hdr->frame_control) ||
> > +          ieee80211_is_disassoc(ieee_hdr->frame_control))) {
> > +             if (ieee80211_is_auth(ieee_hdr->frame_control)) {
> > +                     if (priv->auth_flag &
> HOST_MLME_AUTH_PENDING) {
> > +                             if (priv->auth_alg !=3D WLAN_AUTH_SAE)
> {
> > +                                     priv->auth_flag &=3D
> > +
> ~HOST_MLME_AUTH_PENDING;
> > +                                     priv->auth_flag |=3D
> > +
> HOST_MLME_AUTH_DONE;
> > +                             }
> > +                     } else {
> > +                             return 0;
> > +                     }
> > +
> > +                     mwifiex_dbg(priv->adapter, MSG,
> > +                                 "auth: receive authentication from
> %pM\n",
> > +                                 ieee_hdr->addr3);
> > +             } else {
> > +                     if (!priv->wdev.connected)
> > +                             return 0;
> > +
> > +                     if
> (ieee80211_is_deauth(ieee_hdr->frame_control)) {
> > +                             mwifiex_dbg(priv->adapter, MSG,
> > +                                         "auth: receive deauth
> from %pM\n",
> > +                                         ieee_hdr->addr3);
> > +                             priv->auth_flag =3D 0;
> > +                             priv->auth_alg =3D WLAN_AUTH_NONE;
> > +                     } else {
> > +                             mwifiex_dbg(priv->adapter, MSG,
> > +                                         "assoc: receive disasso
> from
> > + %pM\n",
>=20
> I get that sometimes abbreviations are nice, but perhaps at least use a
> consistent one? I see "disassoc" elsewhere.
>=20

Will modify it in patch v10.

> > +                                         ieee_hdr->addr3);
>=20
> Brian

