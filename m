Return-Path: <linux-kernel+bounces-91792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C618716B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14511F21E54
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69447E590;
	Tue,  5 Mar 2024 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pYGFa3J9"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2049.outbound.protection.outlook.com [40.107.15.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A087E110;
	Tue,  5 Mar 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623561; cv=fail; b=iHkxqgAUABCoEdhk8U0cuKCzEWdpyyHvgpxcDVSGSU4Oc15GrQ0khNnQWUSJXAxI2MDuMUGQf1TxYFQJn3sTDs+Nux5Q6/drf1GbwlWMEnIoVZ5CEdCZN4/Ec6+9o5IkfF9pMUpyNThcaiQvoksYC31b1lGRlOSzBQ6knKomHyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623561; c=relaxed/simple;
	bh=RGgT2vCIkgAAMJRxbVz+tFpNgjoJsuzOYds/JFsDuLg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SRHkr03xQ2vXIa94TLTIbCgEH+ggtIF97XsGHks1LoZNH46+LRjmFB9FgK8/J2Ug2Y/6J5D6j2PvZ8Lt8JUr9zmWjaRkUjQeb8T1CGyKOqPZwR0PLuw0lf50aIXQ04VZB3zsHhuKXkN12nnx68rvhFG37U72aeqREQhd9nfPwW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pYGFa3J9; arc=fail smtp.client-ip=40.107.15.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5T8bkwP/JdJY5Rgr/srJ57D2xYPBmeAcszpz2LSM9fLrZIc0JM7qO6itX8cdXwoGCr83E0NxfzFwPrhv72V/eTqYCnTLFy40XTuhlR/7GESQ9MBfg7wRmaIwg5Kwqpux+y83s02X8p+EtCWDN6BVPDUfVSotZtCh9GJscZchE1LXMXR6A6OXwujhyMAsCXG5/PYmHM74HdxJKRRaHqCTPTP50WiCUZBJsUSiqANAukDKtIXYnAd+CwXkAukjfrWroCckFvsPVt+hU7CJUZFOLbzSdq44t6za6nFQVyJFD0kD/BBi8Lk6mjs8NR26YtOO7NeZdvvW3cqYBL3E11h3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxEw0RfgpE3v3Dm2TsnKHf1qUoxEJonLY7AwDzUV35w=;
 b=aHhFuVRK6+Vq30SMRBVIlsXAU4WNE1zubzjuvi3XG5aHLop3XCmHXbeQVwEK7H7CNDxe1QM3SIiZbyTD/wfAqHfGwDJhYcUdSF2728eejpoE5FdkB5kn24MgBzL/43BGVBJyZWiuoqDdjB3TIYYbIe5zlkAMhKNqJByfs7h2TdaNirCPkyHFg6fEX0cdI5zj7myOECAQGpjlFSTJYGdr3BBff7bOpBpX3EP35dGCORK6+wp7eWrHzZYmLN/yub4pJPSyKkLyPZiUVEGnzWo8eEGjharre/Bf2XrhecOVV4sOoEn13VZhJ1ZZz7EkXN3QA6R9hPaPXVk71CiHwUYW5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxEw0RfgpE3v3Dm2TsnKHf1qUoxEJonLY7AwDzUV35w=;
 b=pYGFa3J9J+AZMqFmbrC9aEg093QfPat2sSRjIJTjV7gk/J0oWbXvfmJPwh1aXjUKohEDVs9AXY69j+EWy1163Wfz4Nj9QBEH9kvw/mUq5u+5rQs9XJBnIh/lHLmp5f52iRupjjMbz6LbB89ufho6q1Qw36hlFQNI+E36c37Kk9o=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB10246.eurprd04.prod.outlook.com (2603:10a6:150:1be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 07:25:56 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3%5]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 07:25:56 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v8 1/2] wifi: mwifiex: add host mlme for client
 mode
Thread-Topic: [EXT] Re: [PATCH v8 1/2] wifi: mwifiex: add host mlme for client
 mode
Thread-Index: AQHaNIYDXGT+ith2YUesnsIyMnIG77Ee4pYAgAI47lCACBeDgA==
Date: Tue, 5 Mar 2024 07:25:56 +0000
Message-ID:
 <PA4PR04MB9638983EBD1DB4D3E8FB5474D1222@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
 <20231222032123.1036277-2-yu-hao.lin@nxp.com>
 <20240227175306.GB11034@francesco-nb>
 <PA4PR04MB96383C684AAA40C14DDB4B79D15F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To:
 <PA4PR04MB96383C684AAA40C14DDB4B79D15F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|GVXPR04MB10246:EE_
x-ms-office365-filtering-correlation-id: 54ebe539-c214-4455-cb5f-08dc3ce57fae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 w5d0kez0hvvV55r3K4qIaniQq3oLapq3xXbhAYK0kKgrcLH31PffeeKECDfECThzw7aSRX5cdmiZtqj1EmmRvezrz0dkITROJmr3kGS4WW7BxLNibPvG3stt8zqGmx4VGvQd0LYnznIZJIjZKvsmtc7KZQBCiXh2FCz/0EyreBMq7Ji7fgbHz30KzvWfgZm3CLO09tDiPbXacxP0LYjrhvWpRK4jWPXZ0yEJl+5z41H0w8x/RvPzDhJsVJIf9gLZ9L1MlIJ2vB+VMFzvnjMCrbia9nvilsswXCwDupqTN2RjCp7wZKSFlu9KPGQM+OEkWKpKpWZc6hLHDyBMjaQowgzGw2iozFwTczmXK8CDhJKrOA1dfwKJIUADyrHzaCAlOkRxDa7Wlc5beMWN4kDC57IYPXgwjga9KSIrznWHo7AlQIzvPR2/Gc3a1hOn9pWMs82DPRkTUHVLvHF5T7b7x1z43EMofNdw67HmYDwVhz3LKfMp1H1JlZJ3cBUFe3bDGzR7xJuIb5kADBsx1SeEJ+KeYC9BVCP9yvA/StpXs93+OorZR9lN7OrBXkH1YjjbH42f7CIxwa6g1dG42SUw25yteK9E3OaDAUbBPT/NsqMnP0Jau6qV9cYlzc8FpOqLB2t82uDCvlakDlZBCejJP9dvjaR4URjqpKm+ko92G7b4srP/q0S9K6Fw0Rac28WIryzyC6IBUfZ5yBAfcXDUO59f/sG36b+TZzMAA+Wk3lg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ljXJdNQnjhb2463+fmvthvJHp04lT4mNhKzLLrd3FfbroGETs/nHp2/cF3mU?=
 =?us-ascii?Q?9AkMpYiRukFakYh8ivvGVO7m3BKa2ry8VA1O/Vm5iZSIZTpKOAaup1PJFQ+i?=
 =?us-ascii?Q?FpwszqiyNTJCXCjsuDYJGlMwVSOP+qqmxYnBpK5JzsuzFAHGpUtSN8idI7Ql?=
 =?us-ascii?Q?G3AXR/SdItSqKZGZGJQPaNI+1fFu3mwEFUBa/sXb2Kl/ci1mElYkLG45wEGU?=
 =?us-ascii?Q?ndLsQVgTUk3U19U9qi2b7U4AAhEbnH5vyHr4iG0B8zuuIHL56ZYA3ZSgmwUE?=
 =?us-ascii?Q?HTHAo0GcAK7GymY/4qK4QOCtFvsS2xJYl8YFBBBDKuSs0TkIHhQdn93lZGGD?=
 =?us-ascii?Q?v+6SlCqoetxVEsNra4JVlqqydi7WqHEkSL8UTWa35lfLbAnajNLYHvylAH5Y?=
 =?us-ascii?Q?tb7gzNenxO86UQSKmQI2Yd5vfTaLmXCHdT9d55RCgG3h2JpH/ghkcDDLfDeo?=
 =?us-ascii?Q?8Aiiv8CIx97C/rNkMB/I5cmLY1qY59nGK5ioO46U3baxD1dUP/ye7SVqW9M0?=
 =?us-ascii?Q?brB4ZWdxvl/cJQ1K2JOe8bjwys0m41argioW5IdjUhF2ckjQqGF3VKUXm6Pa?=
 =?us-ascii?Q?/reuet8eHo6cEu9Pca2Qoj1qFLutI8GBwRUI0Z0YVTNQOZJ92Os3A9iDZu9s?=
 =?us-ascii?Q?CGiNUKtGk/onbj7sWN6sYTE/FrIAp1YVvDLoLOKOJLRCWPDeR15Kggs8hpHs?=
 =?us-ascii?Q?LH0PiMmLSZq6JYtohB+Gkkvsnh3/sZ8cExDv7haHqTVJIgKfSahFYr/A99fH?=
 =?us-ascii?Q?txA4pI0ljX10jnhiaQYEeJ3JkayxPWZ0dz7NfRaJdfZjzUZ4OOuZmcxFBGx/?=
 =?us-ascii?Q?/SVgooHsUbofvNiYffF9I9288jlm2GYyysIPKUMNy7ze2IFqotp++gfKS4TV?=
 =?us-ascii?Q?EAIdM9IGYCSVPy+XCiZKvQW5zR5QYE7LSqOdbpYQgFMeh/ylZGV2xkT+uzN+?=
 =?us-ascii?Q?tHXqtrbFPwviGWrAFTWdLSHQGSrTzieqXG5vcsNdc8yBLpzWOK99AfeJfNPo?=
 =?us-ascii?Q?q5OhLuhAdaxPhOnt+9WaRInapk1ST7lXfeZH6ZJFHzRPIXFb36W57xOwzBRy?=
 =?us-ascii?Q?7toKPfEK4+j8uaiO7TyvkwR7dCJGEkn+WIlvV1QDf4wQT1SSyN9SMbCzHMkq?=
 =?us-ascii?Q?TGz/11BKa9DF7mnHmYKFtdu9WB3OYoFePmt3iONfxbikEnuNm1flqBqYzCOg?=
 =?us-ascii?Q?ZfHq+M9rIHgyjCxweFui0aBt1FlLWbr7+Q/eStc4PzngVreCzqWg4sruvONy?=
 =?us-ascii?Q?+mdmfSaCnN4PcYuI0lbobXB6U2hp9B+j3PHvwUO0puCrS1WYjrEsNdzAf4GW?=
 =?us-ascii?Q?jSK/zFs00FC8UX3nEOV5NvpdlMuyXokomhJpf4y+glMl82R46EH7l7O9isyZ?=
 =?us-ascii?Q?OnJGxmoEIvUQ2AiMRPN6VyiKoksDTx3e/JS7X6GxUzdMqck/MykLj2ZRp0jj?=
 =?us-ascii?Q?5/C7yZyElq/VOxJfRVhLHP0W3VeywtvGuc/PoNRaMejaWWEAjewSc2Bg7dzu?=
 =?us-ascii?Q?DOnqP/P6kQwoY5TbFHH4oBn/J9hFEG4nEI5x3MT36cAJkB8YXguDTkmm+6Dx?=
 =?us-ascii?Q?ZyvUebkWEU3wMP7qwqylEKyeTgFRYRsL7LpYKlKI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ebe539-c214-4455-cb5f-08dc3ce57fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 07:25:56.6749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oAVs6gfzK9NUjWD5DLeVBuXerMIBFuuVUZvdlPuo9qhNvFggSGTW4WoFgTlGwmoBXzoOTreOxZrnGjWRrNbXgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10246

> From: David Lin
> Sent: Thursday, February 29, 2024 11:53 AM
> To: 'Francesco Dolcini' <francesco@dolcini.it>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: RE: [EXT] Re: [PATCH v8 1/2] wifi: mwifiex: add host mlme for cl=
ient
> mode
>=20
> > From: Francesco Dolcini <francesco@dolcini.it>
> > Sent: Wednesday, February 28, 2024 1:53 AM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> > Hsieh <tsung-hsien.hsieh@nxp.com>
> > Subject: [EXT] Re: [PATCH v8 1/2] wifi: mwifiex: add host mlme for
> > client mode
> >
> > Caution: This is an external email. Please take care when clicking
> > links or opening attachments. When in doubt, report the message using
> > the 'Report this email' button
> >
> >
> > On Fri, Dec 22, 2023 at 11:21:22AM +0800, David Lin wrote:
> > > Add host based MLME to enable WPA3 functionalities in client mode.
> > > This feature required a firmware with the corresponding V2 Key API
> > > support. The feature (WPA3) is currently enabled and verified only
> > > on IW416. Also, verified no regression with change when host MLME is
> > > disabled.
> > >
> > > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> >
> > Currently this do not apply cleanly on wireless-next/main git tree, it
> > should be rebased to that branch as v9 (the reason is your addition of
> > fw_ready_extra_delay from a previous, now merged, patch).
> >
> > In general the patch looks good to me, however I am no expert on
> > wireless driver or the related linux subsystem. I just have a couple
> > of small comments that I would suggest address in v9 (given that you
> > need to do it as a minimum to rebase your code).
> >
>=20
> Yes. Will rebase and create patch v9.
>=20
> >
> > > ---
> > >  .../net/wireless/marvell/mwifiex/cfg80211.c   | 315
> > ++++++++++++++++++
> > >  drivers/net/wireless/marvell/mwifiex/cmdevt.c |  25 ++
> > >  drivers/net/wireless/marvell/mwifiex/decl.h   |  22 ++
> > >  drivers/net/wireless/marvell/mwifiex/fw.h     |  33 ++
> > >  drivers/net/wireless/marvell/mwifiex/init.c   |   6 +
> > >  drivers/net/wireless/marvell/mwifiex/join.c   |  66 +++-
> > >  drivers/net/wireless/marvell/mwifiex/main.c   |  54 +++
> > >  drivers/net/wireless/marvell/mwifiex/main.h   |  17 +
> > >  drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
> > >  drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
> > >  drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
> > >  .../net/wireless/marvell/mwifiex/sta_event.c  |  36 +-
> > >  .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   3 +-
> > >  drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
> > >  drivers/net/wireless/marvell/mwifiex/util.c   |  80 +++++
> > >  15 files changed, 673 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > index 7a15ea8072e6..3cee1b58465e 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > @@ -4202,6 +4208,302 @@ mwifiex_cfg80211_change_station(struct
> > wiphy
> > > *wiphy, struct net_device *dev,
> >
> > ...
> >
> > > +static int
> > > +mwifiex_cfg80211_probe_client(struct wiphy *wiphy,
> > > +                           struct net_device *dev, const u8 *peer,
> > > +                           u64 *cookie) {
> > > +     return -1;
> >
> > See my following comment on this
> >
> > > +}
> > > +
> > >  /* station cfg80211 operations */
> > >  static struct cfg80211_ops mwifiex_cfg80211_ops =3D {
> > >       .add_virtual_intf =3D mwifiex_add_virtual_intf, @@ -4347,6
> > > +4649,16 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter
> > *adapter)
> > >                           "%s: creating new wiphy\n", __func__);
> > >               return -ENOMEM;
> > >       }
> > > +     if (adapter->host_mlme_enabled) {
> > > +             mwifiex_cfg80211_ops.auth =3D
> > mwifiex_cfg80211_authenticate;
> > > +             mwifiex_cfg80211_ops.assoc =3D
> > mwifiex_cfg80211_associate;
> > > +             mwifiex_cfg80211_ops.deauth =3D
> > mwifiex_cfg80211_deauthenticate;
> > > +             mwifiex_cfg80211_ops.disassoc =3D
> > mwifiex_cfg80211_disassociate;
> > > +             mwifiex_cfg80211_ops.disconnect =3D NULL;
> > > +             mwifiex_cfg80211_ops.connect =3D NULL;
> > > +             mwifiex_cfg80211_ops.probe_client =3D
> > > +                     mwifiex_cfg80211_probe_client;
> >
> > Can you omit this one? You should get `-EOPNOTSUPP` for free with
> > probe_client set to NULL. Am I wrong?
> >
>=20
> Yes. You are right. Remove in patch v9.
>=20

This function must be hooked, otherwise AP mode can't work. I will hook thi=
s function as before but return -EOPNOTSUPP instead.
Patch v9 is almost done and will be submitted later. Thanks for your sugges=
tion.

> > > +     }
> > >       wiphy->max_scan_ssids =3D MWIFIEX_MAX_SSID_LIST_LENGTH;
> > >       wiphy->max_scan_ie_len =3D MWIFIEX_MAX_VSIE_LEN;
> > >       wiphy->mgmt_stypes =3D mwifiex_mgmt_stypes;
> >
> > ...
> >
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > > b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > > index a2ad2b53f016..23639aacf092 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > > @@ -136,6 +136,7 @@ int mwifiex_fill_new_bss_desc(struct
> > mwifiex_private *priv,
> > >       const struct cfg80211_bss_ies *ies;
> > >
> > >       rcu_read_lock();
> > > +     bss_desc->bss =3D bss;
> > what is this change for? I was not able to understand it, nor to find
> > any user of this bss parameter. This looks like an unrelated fix, but
> > no code seems to be affected.
> >
> Yes. It will be removed in patch v9.
>=20
> >
> > With these 2 comments addressed, please feel free to add to v9
> >
> > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> >
> >
> > And thanks for this work!
> > Francesco

