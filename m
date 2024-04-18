Return-Path: <linux-kernel+bounces-149476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F60B8A9199
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D031C21044
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A8D54676;
	Thu, 18 Apr 2024 03:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bzYRuEtQ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FBA38DDB;
	Thu, 18 Apr 2024 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411462; cv=fail; b=FWa44pkVCNu1BcwQ+39ZGT3BCkaG1k0VX5HzOSxsOxBS5jOIBAAWQR5SDeqkI5R8PRIQrlMe05N61Bb7FvQM+3YPZlwSewEkNI1ZfYZyDsKa4wLCpkzj2voHvSwK+cI1UNLsIgd57ekwgT1TLgCsweK4pn8aEg8o6p05qTmvHTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411462; c=relaxed/simple;
	bh=i3kSwYnInDGXu04pHRIXU2p7dqxZiTKPhCaY/UcWte0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hmh/yLfWJ0iiPjEQgbr71Y9A1Gx3udPYhCmJJ7oe1ILmiUholrUsup/y6wLJVS+kFumUeZDoprEPpVs87m98iPhuZ6xFio1a+pZmmsqpVku3t1Z5VZ0JjoNVU7VjW/obTfQ7UPctTxVzZrnKjavrV7jckf2ElBLY8p5bfyLEeis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bzYRuEtQ; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDfUNnHX0nfMu+/Bf0nzzr9vvxaCwJiNXsWJVOOllZZWAoovIcI+siXB1wuCisYV7DdsaR2LxBp+fvdtrlnxRhtYrps7A8KtzMnUEga9NTJq4kOzGuODswkBefcQB/94iwTRK+t7myLp4ULUphe2xmxwl2pMB1XhKqsYm4TPOmF4f0nTnqGVGn03EG4/GOeAt1rvIXtVU4nw7OV74p2YYV6XzlkAk3Fm8LLZ4896m81hmU1Wq0hWDMBSL+tjU0v2lVNOGw35H3Dp0q0T/5F1wojq7gvpEh/xcXoRZ3UJXzzR5btCtuwdN6oNpj7OKd5+ypQNNFvwyr3F75GMULCe0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5QPyWyU269ya3AXy0GQQHhyosC/kg3sAKWou1I3oA4=;
 b=Csrql3m7mtB3+vZil9+Oe9Il7jZDX38CLvczLrgNVil5Gn0ZmjKRtPNQ39cUeVcxT3C2zbWSjBvE/hFr5YssY3uvjO4fvjV6FA0RNtk0Txroz/As2j9QqEbxp0doBhs1FfHB0vjw/il5C2R8JsyO+uxOAiGyqr/Z/61dnHs+cCVE2E5Y54sM4KggLe2pAt8fF/ntKZhkG6GzP7Lv0AuMef9Nt2EGkLJcX3zGLwozfP+JsFYKjvF2OEF5ltwC+OHHqZVb98WO+5EvoP4pw4D4sIGltb0LnYiCoe+PGNerDZvRKyeSjjGkRCZc81IfKwIgbws7scz3u1nyWkXIkEEDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5QPyWyU269ya3AXy0GQQHhyosC/kg3sAKWou1I3oA4=;
 b=bzYRuEtQGei004kuQQISIHHVG3NGuGSqDKsqH8xjBsZy+eSdnHZ1pJ9I+db13tLf2FvTVhAemg6h/sEWNM5xF5UoYVsUf6b14j23d3qThCESDphtoKRz7aTJzC+4x9Ua/ERxdYa+BOmI6ykPrObhOBU4oP81SuDJHIIxWDMn//c=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9518.eurprd04.prod.outlook.com (2603:10a6:102:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 03:37:35 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 03:37:35 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: David Lin <yu-hao.lin@nxp.com>, Brian Norris <briannorris@chromium.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v9 2/2] wifi: mwifiex: add host mlme for AP mode
Thread-Topic: [EXT] Re: [PATCH v9 2/2] wifi: mwifiex: add host mlme for AP
 mode
Thread-Index: AQHab2oqV1El38Ap00yuI3DpHpR6T7E5l5eAgAM6irCAMNJAYA==
Date: Thu, 18 Apr 2024 03:37:35 +0000
Message-ID:
 <PA4PR04MB9638A61A144364C3567AEA76D10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240306020053.18054-3-yu-hao.lin@nxp.com> <ZfTrm7bxMykHO-M-@google.com>
 <PA4PR04MB9638D5722670E38B5691B948D12D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To:
 <PA4PR04MB9638D5722670E38B5691B948D12D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB9518:EE_
x-ms-office365-filtering-correlation-id: f0c22837-6c9f-4038-f11d-08dc5f58e315
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IR3TWl4FovYZEVMJ4JoexUPPtf4FG/DsqGOrejvBSgX5W9E3e4xHLlOCMViOmOjF269xD4MR2jtDPisboH28Hg/E5nKE+eTNoPFG46rX6ZUQLlJ2GoRhqGptko2Blk4hZ9MnFCLN1GPEmVPfOqY9YGKeRE1bhlmRrKG4YrLD+EZVD2CdIHjDsym+4FJxbxZzLnfDlTM3Ey+sLsWEaLteaXjv796dGd8QaA0VNa9PGCwhVWawJeunPtrnEBur6KbHwak9b2BiDew3iiUqx7ZEj0oo7HUc6WAAZ7+XCJNS8/+0XLGSZKuLISR08Dug21JTNfHtArq1+sCs42sFlafOg/9eiXDRpmwyacBP156TwcBDrzO+MWEsR/HXiPOGyWq4cR4UfdWYEBUAYRnYYAXWOkAdyGuo5GnrIFSNdiJreSCuH56iOlTIebtEpOcsi7mxyN8tf3gTVDAVfPOz11ixvRbF6cPJ8iMMKWBtzTk8eW4Fw7xnk45ZdkuemeLeixmD9gLUbxWlPx3A5i1p/irOkuvfdEFdGZKYyD9o3F/Q9AmdkajJZ1BaacHsMR6s0isSRcP9R4S+b3Qw4Rqd3Fivb/c/4bryMcp+cqp7gIPXuiQ5sZq8SbDzfm4IisLt5x6lnDy+gyFJxOi+BOOcq3MDeISt7Pvfvr9I+UQTLLj81SIgrO4zG5hEOIiIcv6HhiTCoPx25L9v/CtxV8JzbX0QIuiidylQPNmPr0RNvMMyVoA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tLSyVGe11HqmV6ikSH5uDORkqpctTP7PKk9r3jmsJq1BysdFFElLq8eWd0Vm?=
 =?us-ascii?Q?og0scfxA6aQzSY90e9k+pgZj0MSdOV1hxp1qohRYPvIbmNRZ+h+wbvDP2vrK?=
 =?us-ascii?Q?pyJ8o1yiHQzFpfo3ved0kcXzc9X/xzQZJzQBak5yilEjtt+5tBzRxPooDogn?=
 =?us-ascii?Q?43WqikY1ZtjK0z4SVTpKJo0VN1Rt4gAQpclOt6RXH3aVpIbOb4f0Jvdk7wbu?=
 =?us-ascii?Q?DA+BV10e2ZN574nGAJkR3yklcJMiIC8soMQ6yLn0xvG3PFWBF/rmxQA4TVoV?=
 =?us-ascii?Q?TkXEm5tEEVdEPYTSL13fmriuVbLypGYINAqqeHFRvLVtv95jNRNqCWT5D/1e?=
 =?us-ascii?Q?JireKQHbNzuBwIotxRvmcb5QVY20XizubpSLotibFfX5ka1uGDdEwjworgpH?=
 =?us-ascii?Q?0MCiet7mzXYApT6XKe4+zH6ra216Ov+/UTwoCgYFXZ4DeKLVozB/yh7NEHd9?=
 =?us-ascii?Q?7lFjcULwPlkg1OgSDIaEwoG3TmSHDYRH7asqqwqZUiFk8i0fUsR2sF4c+MyN?=
 =?us-ascii?Q?k4GLxJiewALZw8mmiQkid4wod5HewK6dOJnCDY0kCHVmMMXuDNmjXNWW8Zsu?=
 =?us-ascii?Q?a8LQAVSBjaAwFvztmMpEIPA/k7f51AoZvx28H58EN+0wA3yveF8813YcnDB5?=
 =?us-ascii?Q?ogakD6W3pVpGQ3Dqf5nG+0mvEUKDoUKEKGZPkIqmE6N1UrwQF1vI9OB3Dwhv?=
 =?us-ascii?Q?9Lesovk4SQ6JlLgYYfZdR4KlLlyDdiruO7fSNtodMwGl1ONGidC2c4wnPEQO?=
 =?us-ascii?Q?6J5O6XF1RIrrLtQLJO9Q7xlYrLis5CRW3uvnPV9dJWIv7C70v1asSiW2yru4?=
 =?us-ascii?Q?Ep+ags8qZE4ndhTStCdtU4j6gF7A03mriR4q4pfMS6oWDqYpUZh/cKYFUP7Q?=
 =?us-ascii?Q?m7KyG+r45g+bqKquE0hJaWts8c0lazplnL73sNJQAjHR1DQc8zXY3JYo33d9?=
 =?us-ascii?Q?M92uCB7uY7ZaZyUJ4kA0BezQ7vPUVfG+/+DshkyQoz4mIN07oEWqHxOGN3K/?=
 =?us-ascii?Q?V/3BpMRMT3ihbDX9q68lQ4X+TFBVhAMBfvYSMciCArm0FsksuABdmex+KIvR?=
 =?us-ascii?Q?UL5LINykkcp7NI7CUKYxl4BUnMNRTt+4BKHmxYDLm3kn5KnJeyXrszIcdSqn?=
 =?us-ascii?Q?0TH3X/w064MfQnPnhJTDzb3SBt/xK0Pv/ZpFyo/CccwzKgyO7Qk627JNW5c0?=
 =?us-ascii?Q?7XI5+aXSLgzePqwB+Q1YA543DfkxxbGYJjIRCgJlQCTMB9EV9k3V8C3rTaaS?=
 =?us-ascii?Q?lbOQCgfI/ukCr813AoXQmIcB0t2Dl0uLn1MpiVyd/U21BYmxneD6QcPI+iyB?=
 =?us-ascii?Q?GWCuSAltamXJWnBZ0N1r5+6KQUmgM2b6LDYrcbImgOh+wj+pmNCfr/1rVPUv?=
 =?us-ascii?Q?rBpxQeoi1sbxS6xg1wMxGcCl2Fqgwy7t9Vs9bXNek4NnZA1K+PXQ/9P1oCj8?=
 =?us-ascii?Q?X8CDWuih2UP4OhHmdFzDLCYoAUQr/yDeH9aT2kg28FFfB13rjoM9JzPHRQYb?=
 =?us-ascii?Q?MG2pH+BIMqm5N0xdNk/esFCz8k0aOFk41cBMpG0ro+et4fCQTRNpMDy79kT5?=
 =?us-ascii?Q?X+M82R6mQ4oJK3X53euFWn08dJ7spz89ZKrod0uV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c22837-6c9f-4038-f11d-08dc5f58e315
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 03:37:35.0979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: do9jzOMCeIsb6ti/z8B3X0xV2AXzwUPq/0tRxVp+4jDW7i60oFU9xk9NLEVTSDNMK75+vwIoT42VTL4MusIJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9518

> From: David Lin <yu-hao.lin@nxp.com>
> Sent: Monday, March 18, 2024 10:04 AM
> To: Brian Norris <briannorris@chromium.org>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; Francesco Dolcini
> <francesco.dolcini@toradex.com>
> Subject: RE: [EXT] Re: [PATCH v9 2/2] wifi: mwifiex: add host mlme for AP
> mode
> >=20
> > From: Brian Norris <briannorris@chromium.org>
> > Sent: Saturday, March 16, 2024 8:45 AM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> > <tsung-hsien.hsieh@nxp.com>; Francesco Dolcini
> > <francesco.dolcini@toradex.com>
> > Subject: [EXT] Re: [PATCH v9 2/2] wifi: mwifiex: add host mlme for AP
> > mode
> >
> > Caution: This is an external email. Please take care when clicking
> > links or opening attachments. When in doubt, report the message using
> > the 'Report this email' button
> >
> >
> > On Wed, Mar 06, 2024 at 10:00:53AM +0800, David Lin wrote:
> > > Add host based MLME to enable WPA3 functionalities in AP mode.
> > > This feature required a firmware with the corresponding V2 Key API
> > > support. The feature (WPA3) is currently enabled and verified only
> > > on IW416. Also, verified no regression with change when host MLME is
> > > disabled.
> > >
> > > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> >
> > Quick pass for now; nothing jumps out at me today, but I'll give a
> > better look/Ack next week:
> >
> > > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> >
> >
> > > @@ -3951,12 +3974,43 @@
> > mwifiex_cfg80211_tdls_cancel_chan_switch(struct wiphy *wiphy,
> > >       }
> > >  }
> > >
> > > +static int
> > > +mwifiex_cfg80211_uap_add_station(struct mwifiex_private *priv,
> > > +const u8
> > *mac,
> > > +                              struct station_parameters *params) {
> > > +     struct mwifiex_sta_info add_sta;
> > > +     int ret;
> > > +
> > > +     memcpy(add_sta.peer_mac, mac, ETH_ALEN);
> > > +     add_sta.params =3D params;
> > > +
> > > +     ret =3D mwifiex_send_cmd(priv, HostCmd_CMD_ADD_NEW_STATION,
> > > +                            HostCmd_ACT_ADD_STA, 0, (void
> > *)&add_sta,
> > > + true);
> > > +
> > > +     if (!ret) {
> > > +             struct station_info *sinfo;
> > > +
> > > +             sinfo =3D kzalloc(sizeof(*sinfo), GFP_KERNEL);
> >
> > Couldn't this just be stack allocation?
> >
> >                 struct staion_info sinfo;
> >
> >                 cfg80211_new_sta(priv->netdev, mac, &sinfo,
> > GFP_KERNEL);
> >
> > I'm not sure you need to kzalloc() something here, if you're freeing
> > it a few lines later.
> >
>=20
> Will modify it in patch v10.
>=20

This modification will let stack overflow. Patch v10 will keep original cod=
e.

> >
> > > +             if (!sinfo)
> > > +                     return -ENOMEM;
> > > +
> > > +             cfg80211_new_sta(priv->netdev, mac, sinfo,
> GFP_KERNEL);
> > > +             kfree(sinfo);
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> >
> > Brian


