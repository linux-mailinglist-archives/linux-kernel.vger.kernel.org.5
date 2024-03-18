Return-Path: <linux-kernel+bounces-105647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327C087E208
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630D51C22125
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D201E868;
	Mon, 18 Mar 2024 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZGD9HjRm"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF6B1DFC1;
	Mon, 18 Mar 2024 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710727448; cv=fail; b=BDGQedn/MX0xXPha4u7hWf9QZ20rKUGfW+SAthBrcgvgyEK+qWlVV5RakZJM3p4GRrxLuNiufSXsn219J/0QYqhj8IYpaUMng8TSr4p0fSzWfXVKbGR0GYlYX8uH/K9Leaj4ls0Dv0M8Z7qTfZuzsKtRZIAw4VexHwLdyVA6SNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710727448; c=relaxed/simple;
	bh=bK4usGl+HYRWIVT1DbpjAtGbD/pxJ7o63HSKN7Y4whk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nhz0Bv1R+/WGsZa+q3IrAh7Zsb/S8r+G/+sNlKzkSogg6mwpI/uRyDGMszyWCZFMZaRwXZ5zAax3aLurXIztGmsw22+hFWroh9IQ/tFgsXaTAIJfbITM0pPh58HGQi8FGMk643u1NRKcA3VrA/vk18+wf9VwNqvmmaKrO1A3EZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZGD9HjRm; arc=fail smtp.client-ip=40.107.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1wa+Uvi8EtrtDi6cxsMJq+65tc6OgcVRkKsY9h3f/DnBdbIKZfeQBXgPCw3cyAGh9aWYFmPx/+SzqWUT6GLU62Y6coMo2nHIJ+G/e7wS8OHC9ORbcq0Qw9M/9HaYvRPbuoJ18De2i6Rb+1SZRAMenvtNmb9H/hACYeUbxfkzEZ4i6TPmAjqUzmmYXcGcgKiEBHwMtNH3jcnlTytxqlwm3wEbredYKT7sUf0fcelWS4M5Nu3BNJ0WhvJrFvKZc4KSQBxCmeWE0OB1FMJV/Ig2wTSFK7N3kFqKgB1WrWeKfEK4TilpIYnov3fRHX88E11bqLYUi2JGwuDVzw2A9vlSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEROHTQFrpuuzBvN4q0J7UoRmtJTQfteACriBMqwLc8=;
 b=CldkUDHn+oWK+3rwT/NoNBs65lRN+gSzxfUh4wn9SWJJdWILd38bBenQMQKQLhK3L7FiEVfw6kkVUNVsE2PpoePGIZqjVtvIeQm8n2xEwL2OrnRMu5KaAzbnKkCzeQgZGdp4fDS/5tzlkcqBBKT8sc2em5GMQuoBMjUxPlHPxRP+ISQcLJNixUf8juww2ucYizQRL597VeDCR2YkbAeRLJsdhAZafqJi/rJqE39FsWrS4teCRmz6FklxoOh0JiB2WuNLt7Aai0Hipn4vJOYjt2ZtxqU+fYs/rC2fGtdSi/6sOQ2v8g+AGD08WaYfNW8wCw0qLAIvNtIW2WONovmadg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEROHTQFrpuuzBvN4q0J7UoRmtJTQfteACriBMqwLc8=;
 b=ZGD9HjRm0gUtPaUCEjVen8bJhRPazbH9zQWybA0qr97a5G81OhcKCLi6tkUDCMHNhzFaYgj3mNuwJ/vGPZLV+RfsIitrR+QOoJXg3e8qbA9I3JHRQ6NiGq56bCNbPe2saHORB/NMPWZoursrtRh8ojo7uIxnR/oOxknW1mYNqBo=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9593.eurprd04.prod.outlook.com (2603:10a6:102:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Mon, 18 Mar
 2024 02:04:04 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 02:04:04 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v9 2/2] wifi: mwifiex: add host mlme for AP mode
Thread-Topic: [EXT] Re: [PATCH v9 2/2] wifi: mwifiex: add host mlme for AP
 mode
Thread-Index: AQHab2oqV1El38Ap00yuI3DpHpR6T7E5l5eAgAM6irA=
Date: Mon, 18 Mar 2024 02:04:04 +0000
Message-ID:
 <PA4PR04MB9638D5722670E38B5691B948D12D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240306020053.18054-3-yu-hao.lin@nxp.com> <ZfTrm7bxMykHO-M-@google.com>
In-Reply-To: <ZfTrm7bxMykHO-M-@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB9593:EE_
x-ms-office365-filtering-correlation-id: 8c4ec21f-797e-4e6d-3620-08dc46efaffd
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LYu9Ibv6KLS3zbQPGno5A9KDKDmiAMJgYgwm/+5U7aCFJwbSwoNajsotEEboE1GxF/3Lvs28F84S0k2vpRH79PDsE/vbWK5FWR6Xc8gG1y5VGnp+pjSRQOPfKfX+BrYaydSv5vOwVDkY5fpwW+BNN+pEnL2cEUyuVG1Oy7ayDiXNMkqh5xscdiXp6evmpEYf+j7ae5DuN8NPlT+4YkVT1Oy/7yxWazniJPW3vdG19C0qBS2RU9dXwu1Ux8C1ipgeYUlENfzV8Go9dAoWcGikNJVjgfDusUn7nK4mbmbcDtK2RhP7HYOKLQc/dDRKvG7QZZC3JE2/vO93OQIIeARxsxxgis+DbR/aIq7p4CGKjuFXvLOs4gS9Js6p31bCM6QUS1T5XlbadA6/fawMgeLks9rbqS8ndsvlwF7Ca//t/0WrhoaWrNCMnR7qBsFeqV7b+R5VqS/vG334dzhhjm929ETR29VtBlHSxmlECnj6nuZ+fsseSkt8RAsYncDRnjRAxKAGEZ4I2N/UK64misJsHyKf14LWNgcKSfWCUPRUUKSH9j59qxR6fEeLdj9IpsgY3ZoYnLjX9rd0rHtuBQPZzFIXU3LTj6NjbyzdfP2DyTYoAzaWSToX4gtOuhwiaYCSRxR2fXI/xe/1S+kYnIwE7PzqppZ4Y20ay4WK/Ip2Ryoa+QXiROaxtwzWvPqUj2U6795L9HKcvlMC284Wf6BU0eaHboZRmYwOme/dVdvzxFs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TbntTmI7LSAMgrdDERl4pTlK27QkQsAAQuNKX3c0IneCPRr1k0rnCYXJFsQH?=
 =?us-ascii?Q?4G5dTHZ6nA++0QIHMx/ohvEcH6EkrBn72woUNL9FHU63VZDmXb7pWH3PFJnC?=
 =?us-ascii?Q?0E0ThW/9K43AiTtmyu4f5eyXkEG80AXSgvoxg7aCO0Bfy7btnD2pVCRa1qqy?=
 =?us-ascii?Q?FJ19OxVFe+WpCA2ZMyZv2AfAYguCTlzFAuvc/4udyTnu63imDHKDiTPFoT76?=
 =?us-ascii?Q?A3zU033/tZ3QwVAtCC8RwNqiob5ecXjvBhZawQ1hovB1XLM/QP15mCezRwQq?=
 =?us-ascii?Q?PvNH+VPHO/GvyK1l80QYC9STsY1LPPCig8kMghd8AcNYXr9UBtWjuIZu5c13?=
 =?us-ascii?Q?bkVRo9tThqoG1YlMsphlvZnihbYmjrz9SlHMBJ+Q3RCocu/iTDZnTT9Fiebr?=
 =?us-ascii?Q?w592B290d1DiLpwb/QZy0YQlE2VMUW1T0CQUNpMXBh3X4M8AWQKMatvst6DX?=
 =?us-ascii?Q?lT22NUrvuJ1P0FceKp53yz4nYx/Snz39M2lvrFP/b4y+TVssXb+YqtHy2uSD?=
 =?us-ascii?Q?W6C6/QD//pGM7GOSRo/nVWyXyxOgiFwj39quuXFGTW49lFHLmZuFpTAs9YY6?=
 =?us-ascii?Q?PTaTAYJP60NdJcxCrCPuJAmTECdbud3lzuaH9sSdb5wUcmE4Ge9M9pE9Lvzr?=
 =?us-ascii?Q?no8/J/g13NmcC+UewRN3krhHCitvrrpaGfSgcJoHd+Mqd+h60DkfRmw0gJBH?=
 =?us-ascii?Q?uiNJkOAUIqZeuLGb2l+UxTetQQFkn63uNiS0SIr42+a4Dv/iS6hTaiKRNGuW?=
 =?us-ascii?Q?1gNByog+LRPmMEyLfjahFo64AbkpB02IPwhM/+aKN6qcFGJ/U2Kj3BI8oEaA?=
 =?us-ascii?Q?3uiXhP1Xq6zu0bNDK2D2rICYmUTNdibseUUDdC+tyNB/ON5hvxRqf4dC2a7f?=
 =?us-ascii?Q?AUy/uGHw7uz3YHL10Lgih8dEEqYgfeL0y+Kabo1QgJwGw172gnl38dhuRFkD?=
 =?us-ascii?Q?wfd2vwmFycuBCPpArDiEKKiDRn+Q84wGSMpFRgrMxlZADE5ZjC2bGlxO6n+C?=
 =?us-ascii?Q?7Cxvji0XV1YxCiewKcU2DVGP/zYsGcyqcCFaGVCLJJfw8i6EUeJVxV9Z2u6B?=
 =?us-ascii?Q?n9EkpmRvrWdpbsEiqlk971UksCXrlszLvnsPEEPoLHFa6K/BiYCGFy/jiTW3?=
 =?us-ascii?Q?ye9EfSiwXh3wXcPgC8Lm2013P8Pq029VnNFDglso200DL/an192IjfvkAF7A?=
 =?us-ascii?Q?xFaf/MVyl/P4sR9Whr4PIUy48FZgLe3m2ZXjGFfgWtIpISyk9tezggPKosaC?=
 =?us-ascii?Q?kqE6YDQJDtd/VkGS4wVf1SNyeFwk28p/ISenkCS/Bt7no8kAjXpYY4FIbjA0?=
 =?us-ascii?Q?7WLwdrpiPh8IQvN9JB0eKFJoBq/tdjzkBkiggAI8/gwBCRiS4Crij5MdM7me?=
 =?us-ascii?Q?Zr7uqOOat06Srqya3uC6L3KQ4U6uIAfC163SFb4NnqWi22nDIQfyC0mzwY8n?=
 =?us-ascii?Q?zD6eIuCWutyYD0slR/Y3ivcusY7s8LaitW1QlU4Boe/u6hBuNOoukmi0rTJi?=
 =?us-ascii?Q?qKGtpq35rO+uqPh3kQ7MmPZE+BvIN5iMdfBa0W7ZaJyYK8JfvM6U9jH2+SdS?=
 =?us-ascii?Q?PcCSxbvRObypsMkOgIadHJQwiktliG6qWEhlRzq0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4ec21f-797e-4e6d-3620-08dc46efaffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 02:04:04.2962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrFQjphHVAXTi8BMrLLceeyL0p1qrLOK4LG0OTmB3pw7QrqfledGRhoI9AvPNuu83bKHxMc/M/Hbazf47Thx5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9593

> From: Brian Norris <briannorris@chromium.org>
> Sent: Saturday, March 16, 2024 8:45 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; Francesco Dolcini
> <francesco.dolcini@toradex.com>
> Subject: [EXT] Re: [PATCH v9 2/2] wifi: mwifiex: add host mlme for AP mod=
e
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Wed, Mar 06, 2024 at 10:00:53AM +0800, David Lin wrote:
> > Add host based MLME to enable WPA3 functionalities in AP mode.
> > This feature required a firmware with the corresponding V2 Key API
> > support. The feature (WPA3) is currently enabled and verified only on
> > IW416. Also, verified no regression with change when host MLME is
> > disabled.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> Quick pass for now; nothing jumps out at me today, but I'll give a better
> look/Ack next week:
>=20
> > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
>=20
>=20
> > @@ -3951,12 +3974,43 @@
> mwifiex_cfg80211_tdls_cancel_chan_switch(struct wiphy *wiphy,
> >       }
> >  }
> >
> > +static int
> > +mwifiex_cfg80211_uap_add_station(struct mwifiex_private *priv, const u=
8
> *mac,
> > +                              struct station_parameters *params) {
> > +     struct mwifiex_sta_info add_sta;
> > +     int ret;
> > +
> > +     memcpy(add_sta.peer_mac, mac, ETH_ALEN);
> > +     add_sta.params =3D params;
> > +
> > +     ret =3D mwifiex_send_cmd(priv, HostCmd_CMD_ADD_NEW_STATION,
> > +                            HostCmd_ACT_ADD_STA, 0, (void
> *)&add_sta,
> > + true);
> > +
> > +     if (!ret) {
> > +             struct station_info *sinfo;
> > +
> > +             sinfo =3D kzalloc(sizeof(*sinfo), GFP_KERNEL);
>=20
> Couldn't this just be stack allocation?
>=20
>                 struct staion_info sinfo;
>=20
>                 cfg80211_new_sta(priv->netdev, mac, &sinfo,
> GFP_KERNEL);
>=20
> I'm not sure you need to kzalloc() something here, if you're freeing it a=
 few
> lines later.
>

Will modify it in patch v10.
=20
>=20
> > +             if (!sinfo)
> > +                     return -ENOMEM;
> > +
> > +             cfg80211_new_sta(priv->netdev, mac, sinfo, GFP_KERNEL);
> > +             kfree(sinfo);
> > +     }
> > +
> > +     return ret;
> > +}
>=20
> Brian

