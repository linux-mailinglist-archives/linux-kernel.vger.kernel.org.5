Return-Path: <linux-kernel+bounces-86104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CD386BFA3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCE11F226AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C6E383A0;
	Thu, 29 Feb 2024 03:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZhHn6lAz"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9B4376E0;
	Thu, 29 Feb 2024 03:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178759; cv=fail; b=YcAzKXV5Tet/RYZgLUfGsWuPVfCbOFfeNIuViHchAv7uq8R9drYEWGkkmI2qf/cGwmWcqtkYJE77GeQzUT/9zRrg57WhgkraBK6cqFD9mJ4JrlFP+M4JuulV3wwNoZtUhv919nnO6fEdB65n0biZaTXU3fmZqBQ3sclny2fhZik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178759; c=relaxed/simple;
	bh=8lfJQzuYIfWcUYnNnXThoxymGEHB/xSsg2JHS+pf+l4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QjBwu2hZAKBuBEMH+ZxrLUYw8zNtQuB4IJLD20zgMlWsFiioFR8P4p7og50asH/WQnalwZ8mzRJO35lcfpbjai9VmNBO64IoYdoVCUtPXvk12hqFl+MG4QOL0qGlS0HbreFzVpXF4UcB1bL4v/OPr5SzovIvhGWg+s5O4YL5zVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZhHn6lAz; arc=fail smtp.client-ip=40.107.241.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMs+bSwBL9daKLQoa8hvxqNQUUrfMKpYMmdyYs9xXh6pC8xDcQGIbkTbN1UajODHaWuwwk8k8BaHv79JJWE38+gG+do2mkxYJjD9UiV7OxdxPCL342I3IKCrgsGGSF7n++gOOoMMmlZXFtMPROpok/GDpFabB1Z/t9/Ir1j6/da5xJi5/ThODk6lbUZbNjYyjhsFHsF19pd2KtKzDudyHJvDE9ZHdUgkV9u/dLyRQ1r5DPdhSBh/GgiWUVtWlD0txaDj157mTBSpY06d9j1dwnlzTWa3oQAMZDlaoenzTOxxjy6FOwOeLbX7nu4g4eTqQ2yHxH94jt42MtN6gJdB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wb6pNgkI4ZLdr0mFI17qW2DlGqmFV0NxIQJBwZcPHD0=;
 b=je0l21GzNr0KYhc2CrMnfTvjvX3fSvezP2C38EJnjIRM8LEz2WXoiRlYCT1NmXYonM6wC/K+3+uEuTxEtfk09QTSIoXAOLiyuCOIk+moE/WbGlQAKqxzVvjuJRiY/OeE0Crqs/eywQ4h7Vw5sty6MUzxx5ARL0VEwba09xxQpgc4GmkM41GlrHVMbegVo+fUfVjGt79ZQVeX9k8+yvEFaoSuOfMzqZ+MsXZHD4d3Cfb/9BszU/FIKslxpcuKRiWISlOgb3uAtuXuS2YrCrezQ7RfV/GE1JMYuk/bdJL5X0N4mxAHIoRA+YBKRhNwxclHRzmPVswTXvUfJzOBnrv9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wb6pNgkI4ZLdr0mFI17qW2DlGqmFV0NxIQJBwZcPHD0=;
 b=ZhHn6lAzTcdSf814HEJbuTVeQIVrofRrr9s6QOn1nfspM8yuJi4EeTEFbqy3QpHfN63DjGagRlnYQdOmWLn2afzhyzgJoTjAp7mSAx4uH/TaAvLQUOnrP2mjEDVcLFWn/FvRgP55hx00QGnntVkRJlq89SxLe6miUz5p+cwFBMI=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAWPR04MB9987.eurprd04.prod.outlook.com (2603:10a6:102:387::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Thu, 29 Feb
 2024 03:52:33 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3%5]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 03:52:33 +0000
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
Thread-Index: AQHaNIYDXGT+ith2YUesnsIyMnIG77Ee4pYAgAI47lA=
Date: Thu, 29 Feb 2024 03:52:33 +0000
Message-ID:
 <PA4PR04MB96383C684AAA40C14DDB4B79D15F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
 <20231222032123.1036277-2-yu-hao.lin@nxp.com>
 <20240227175306.GB11034@francesco-nb>
In-Reply-To: <20240227175306.GB11034@francesco-nb>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAWPR04MB9987:EE_
x-ms-office365-filtering-correlation-id: 961b0857-51ac-48b1-3a78-08dc38d9dc83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Tf9Ily1cbirWbYvqDvIICKWWbQAjERg90JYJKvhfmBT2KYhYpI9O0nNSLd8qkBEWDR7aFhrtIpz73580kyzPp6cXZjTee2NQo2ETI9N7U1GsJ8NYjVMJnJbXBUwLhBWLx5sUyUqdOrxDRwfHDXnkwwwYhdppiIKj7zeI38SphgXQvp0mcTlylxvYPT8H8xIRHeuZ/xpnbUALzDDvc/SLeM/S8ZlwBo79cTNpjGhS6Xva0T7lJ9ysFlfBW9WNlzl021MaEPBsJUCUe1QnNTFzaqqn+5vCN61u986/M33zZhJIXcrdsjteAhUKn9GJeEu6zaoO+0InmR6k7sz2KBDkYUbL1RFXSXLuTQLrDZgPBBa72wUwkfUaEwb9+IuoX0bZhwHsRWQRxWOSBTGpxNUJoH7bdqnUN3tVfPcpAutG4sqGqzfXdFtS748X5D9hL5vMq1mhe8SPVe2Nz8asfYqkW/31nlE3wXGIy8eCKMZ+NMXfZGEHJsRHTPS66QENzz9bLi6uQS82dFn0g39JEo2KevfZh6PMWUfKereoqyCiHrygGOHBui+F8Ij4Csp+hqEVrdCwB4BSmzTAPKVGIDaA6G1rta2dRs+TEqbOjvHItd9Ikbk6S1YXVDOimwJSDficLnY8xFYD79b6Jeopx+MpLdBf+oKIJhd3KoN9CmSOgqbVEkt4Wg+iGfQ2Khq8s+qPQYBXWiD7jmZyzq8a/PwQsf4t+9tg+jQksxgZxQULrpw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IueMsJ4c3VF1Y8G6NLlR5uZxXrsOweUmtwwCZzlkXWyjL2gFRkqP2INYL9HF?=
 =?us-ascii?Q?7Lz6paQFjDxj46Mx9Ga97uvuFXi9MWCoO/KZAjbv864KnP2jzjlkBjsh4wT3?=
 =?us-ascii?Q?ArDzUuvi0ImusjrITh/7flZ5N67X9aicPfOnqyvYFO5v1hIb+HnXMd/UrPmq?=
 =?us-ascii?Q?BM1oq1hlCKdwYFwCChNSgaE4UMMtrtHiXOZ807qfN2DLR3Hu987n9TkoorLs?=
 =?us-ascii?Q?ATVYVgI3n9cfU/u1Qe1MeKBtc7v9PdziyLrO2eLlGuQyH0hK4J9gwjCvVOe4?=
 =?us-ascii?Q?JdqEydNue0y3JHko2gbMaE+xaoSElePCbqCgN+6+SjPcOUFll/8PGy+eSwWB?=
 =?us-ascii?Q?dqbGWGPdM/XCw41uX+N1/JobHMVb0yXPwImM/zfal2JgQXpbld5vEnP3H9sC?=
 =?us-ascii?Q?NCbNXtbl00jWgYp+eXit/0okqF7UxtuibEzMYkFbQyvIog5R3ID3DmUooTp+?=
 =?us-ascii?Q?65ZDzAWj2oWqz046/+oF+iZ6Zr29nF8b3tIzGVijW7+cI4WovQNiRtgvpnfw?=
 =?us-ascii?Q?uqM0KTBtmQyf/LpF77Vysz/4GkCvjHhbGVrOKT1cl23VQjiJExfEKJNt7tW0?=
 =?us-ascii?Q?V4yE1qWddjKGc0ZuWMi+qBsNmvYYKLsoJY1E55lHNSllR12np5KDHz3a+bLw?=
 =?us-ascii?Q?baVQkZhto7O0hwaQnUWb6p9ChUshGX6Pv2UHItaKWLDfsYH2hEZAV6CcOzxk?=
 =?us-ascii?Q?mKkw3RSKFkueyIQVEpikSLH9G0H26ZsqpM6sf8rFjmGZpJbX+kDZt0zJrNhT?=
 =?us-ascii?Q?pRgkaQyBhwNKbUtvE/W5AjHq8Wp5wqi0bGVInj2CbbUBkSHasQbJFPld8Eb+?=
 =?us-ascii?Q?NER3QXYBZtUBV89KaiWDoS3vWEZag+sqJzYick8raGKGMb/Bth9gg0R7l4Ty?=
 =?us-ascii?Q?XLTtGmP4mCWCjbBNe/a77tUsxpFC3eno4O+Lokil/KQA/83zl57dVpg4uOqw?=
 =?us-ascii?Q?9GQY89N/X08Owj+5Rn0iIrL39wxbtXAG2XK7C/XkA971+8YerqAKv8Yhe2UP?=
 =?us-ascii?Q?wM3vGLCozpfSfFdrkPJS/dPd/9KQWVeheOXZImA0GTLgGY7GUlIlnNXwO9CU?=
 =?us-ascii?Q?mEJFGeft9t8iuNfOfDiyQot8vKxeGds223tVYnpfLDpnt4NlqDeRT5wLN/gN?=
 =?us-ascii?Q?3jxQlT5xzFceJjn0BzzMNDnJqZduTSbBvLE/OHHSRSNlb5+xz9HUgodvvqTN?=
 =?us-ascii?Q?TiQaPCKRCl8O0qm7eCar8/XJ7X2xSt7lbB43OoW2YFuRFt5/OfIPpAgVCV04?=
 =?us-ascii?Q?qH2jQJH2RZ2ARuT4481v6qvwY7Md4usYqASfSaR4nkTBLH8TkQsmfrRwg5Cx?=
 =?us-ascii?Q?sdJuKkGxDvwJLP6XdnGdMKxjxMgyQF3BuOkQmR1nKpprplLG7TufKkI7h/sf?=
 =?us-ascii?Q?mXMm3u04yDGw87UKjfQEdSMIIi425l2dXZixZ5EWrVWKXkV99gPEArP6B2ug?=
 =?us-ascii?Q?g7oiD+R766JSSL4e2p5DD7G0VnGC+OfEjrZP8Ubbgz6onR8T3ab4C0RU469H?=
 =?us-ascii?Q?ykQQukd4RN41EGykCoQ1IQhPBgpBMkk7KwObTm3okdeo653fbPyjlsI6HJ4/?=
 =?us-ascii?Q?F0dfYcDWBHmBbWpSMWGN98K/jcfKLKZl0gdw3Us/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 961b0857-51ac-48b1-3a78-08dc38d9dc83
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 03:52:33.8282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nt30xqyWcnGb02L6Tg4fCybKoSqpkFqVKMqk9bPItHLYJ2CfBez+rSHok0aGSBgm6efu4oj5iihk2H6BSrmmJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9987

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Wednesday, February 28, 2024 1:53 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v8 1/2] wifi: mwifiex: add host mlme for client
> mode
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Fri, Dec 22, 2023 at 11:21:22AM +0800, David Lin wrote:
> > Add host based MLME to enable WPA3 functionalities in client mode.
> > This feature required a firmware with the corresponding V2 Key API
> > support. The feature (WPA3) is currently enabled and verified only on
> > IW416. Also, verified no regression with change when host MLME is
> > disabled.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
>=20
> Currently this do not apply cleanly on wireless-next/main git tree, it sh=
ould
> be rebased to that branch as v9 (the reason is your addition of
> fw_ready_extra_delay from a previous, now merged, patch).
>=20
> In general the patch looks good to me, however I am no expert on wireless
> driver or the related linux subsystem. I just have a couple of small comm=
ents
> that I would suggest address in v9 (given that you need to do it as a
> minimum to rebase your code).
>

Yes. Will rebase and create patch v9.
=20
>=20
> > ---
> >  .../net/wireless/marvell/mwifiex/cfg80211.c   | 315
> ++++++++++++++++++
> >  drivers/net/wireless/marvell/mwifiex/cmdevt.c |  25 ++
> >  drivers/net/wireless/marvell/mwifiex/decl.h   |  22 ++
> >  drivers/net/wireless/marvell/mwifiex/fw.h     |  33 ++
> >  drivers/net/wireless/marvell/mwifiex/init.c   |   6 +
> >  drivers/net/wireless/marvell/mwifiex/join.c   |  66 +++-
> >  drivers/net/wireless/marvell/mwifiex/main.c   |  54 +++
> >  drivers/net/wireless/marvell/mwifiex/main.h   |  17 +
> >  drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
> >  drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
> >  drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
> >  .../net/wireless/marvell/mwifiex/sta_event.c  |  36 +-
> >  .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   3 +-
> >  drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
> >  drivers/net/wireless/marvell/mwifiex/util.c   |  80 +++++
> >  15 files changed, 673 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > index 7a15ea8072e6..3cee1b58465e 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > @@ -4202,6 +4208,302 @@ mwifiex_cfg80211_change_station(struct
> wiphy
> > *wiphy, struct net_device *dev,
>=20
> ...
>=20
> > +static int
> > +mwifiex_cfg80211_probe_client(struct wiphy *wiphy,
> > +                           struct net_device *dev, const u8 *peer,
> > +                           u64 *cookie) {
> > +     return -1;
>=20
> See my following comment on this
>=20
> > +}
> > +
> >  /* station cfg80211 operations */
> >  static struct cfg80211_ops mwifiex_cfg80211_ops =3D {
> >       .add_virtual_intf =3D mwifiex_add_virtual_intf, @@ -4347,6
> > +4649,16 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter
> *adapter)
> >                           "%s: creating new wiphy\n", __func__);
> >               return -ENOMEM;
> >       }
> > +     if (adapter->host_mlme_enabled) {
> > +             mwifiex_cfg80211_ops.auth =3D
> mwifiex_cfg80211_authenticate;
> > +             mwifiex_cfg80211_ops.assoc =3D
> mwifiex_cfg80211_associate;
> > +             mwifiex_cfg80211_ops.deauth =3D
> mwifiex_cfg80211_deauthenticate;
> > +             mwifiex_cfg80211_ops.disassoc =3D
> mwifiex_cfg80211_disassociate;
> > +             mwifiex_cfg80211_ops.disconnect =3D NULL;
> > +             mwifiex_cfg80211_ops.connect =3D NULL;
> > +             mwifiex_cfg80211_ops.probe_client =3D
> > +                     mwifiex_cfg80211_probe_client;
>=20
> Can you omit this one? You should get `-EOPNOTSUPP` for free with
> probe_client set to NULL. Am I wrong?
>=20

Yes. You are right. Remove in patch v9.

> > +     }
> >       wiphy->max_scan_ssids =3D MWIFIEX_MAX_SSID_LIST_LENGTH;
> >       wiphy->max_scan_ie_len =3D MWIFIEX_MAX_VSIE_LEN;
> >       wiphy->mgmt_stypes =3D mwifiex_mgmt_stypes;
>=20
> ...
>=20
> > diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > index a2ad2b53f016..23639aacf092 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > @@ -136,6 +136,7 @@ int mwifiex_fill_new_bss_desc(struct
> mwifiex_private *priv,
> >       const struct cfg80211_bss_ies *ies;
> >
> >       rcu_read_lock();
> > +     bss_desc->bss =3D bss;
> what is this change for? I was not able to understand it, nor to find any=
 user
> of this bss parameter. This looks like an unrelated fix, but no code seem=
s to
> be affected.
>=20
Yes. It will be removed in patch v9.

>=20
> With these 2 comments addressed, please feel free to add to v9
>=20
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
>=20
> And thanks for this work!
> Francesco

