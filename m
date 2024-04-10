Return-Path: <linux-kernel+bounces-138075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A151A89EBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1D31F21DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED13513D268;
	Wed, 10 Apr 2024 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cE+4A/j1"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6D26AC7;
	Wed, 10 Apr 2024 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734218; cv=fail; b=qbUSQ0XHt+/YDBogQ86AeGoXKTr64gkHtbmMp++cW0wwpVRqYWiWCMMOg7bV1WJP27/loTCWXsI9YuK+7wqZXlDcKBxwrrbmxQllJq0EP5le4pt2M4wo+kzPJxRTJ+X+bHx/b4R8Skj+kQJrFVeHKTaMaih7K3Aa7GUwPrI938o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734218; c=relaxed/simple;
	bh=oeoTXsr2A+fjMiacSlA0S9LPoTGO7tto3sqcNxQ/eeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lx5hXC7OyLPsaKox6TTUg6zZRZABU59yjZbEk4FHRw9h4gWE17hHF+gk0W7U6+QXi+r9FsFwWRwm44B1pHobgYBf/Pf1gMFd1j8ME8IAJdwBVEyZ214TLDtBYK8cNWqs5qZIBjY5Rv4cV7QG5aZ6+gewHMEIa2ltJsyIa28bXnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cE+4A/j1; arc=fail smtp.client-ip=40.107.22.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM4JAEEP4j3On3aA5iKAYnEjc9K5XdNNxDn43WZ+xMMHZ5ko7buzb91cpJFLeWkxRTH2wt5uA2h/GFxXSAcETwXxUmPXAluT7W0C/zDdTrgYm6c5fPwxeZOyWq6zJXhoWvz0oJmkxkTaVucFPrCCt0B54UyuB1wv+mLeP+/HFkyP6kZoqTQcq1BIE6LnaCgHHykejxiIDTZ5Jv3PPXmP8syVo8b6CWqQBgp74+zUNuCoNjyx2Wv5VQO3sTadbM3NMyKbutZhlGtcVD5V9d5iLBmQcX3AqsCoQFdmIhjEnAgDIlayFB57xKzmloTDdnvXUrWXeR5cvzcSQ5V8JXYgiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX3sUz2EieZTxsGt/WyR5XW9mh7phzIN17Onvk9EMxg=;
 b=Bb0ERY/HXgq4zuEwBCg8u/MfFXgoMfE1Ns7tcZHT2ziotgkWFlUeZlhj0pgSkO+JQMtgddT8cJh/BvBMh56ftn+ku+ddnrW14tIsRXeryFTm6aUNO/JLiPVs77X1p5IwrsvWT7TVhJ2Xdo9rv9KuI6GJB7HY3WagZQfK1tFFOs4kfv8hQ5tufSaObd9E2Sl5Yb/ya7ZOBKiTCLzJ+/N6zwslqb7fVGcVDMTbwQ31Di0AkSrCczo+AJWWGsZX91zjZNdHJvW5swoaJz5XyWvPguziF2hA/OuJ4mFdenN1+TmRUx8rD5y0pK/JgWEEeQFk2kG6qK36jzj0m5gKzkqFbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX3sUz2EieZTxsGt/WyR5XW9mh7phzIN17Onvk9EMxg=;
 b=cE+4A/j1umd0cGi9WmTLUiz/Ai9LAmgKbze5A3PTtLoLnO2OnkwkMeJabUuCr6gchGuo7hfXqIuvj5H0Dghgog1uydV6saam+rK59KMftH8TdFWE1wA/cTs1Og5WAewy96xbXIEmuPQ3cbTZSNBOYVz70tXZdpsqaJb0WXcR8CY=
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by AS1PR04MB9584.eurprd04.prod.outlook.com (2603:10a6:20b:473::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 07:30:12 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::fa84:b970:e920:615a]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::fa84:b970:e920:615a%5]) with mapi id 15.20.7409.046; Wed, 10 Apr 2024
 07:30:12 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Johannes Berg <johannes@sipsolutions.net>, Francesco Dolcini
	<francesco@dolcini.it>, "kvalo@kernel.org" <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, rafael.beims <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index:
 AQHab2onJLj7by1TDUGmc5gbcJq9YLE4nU6AgAD7hoCABXXFAIAA1QEAgAAD/+CAAIccgIAA07QAgABoFOCAAvNSAIAEIpWAgAXgVOCABsmkAIAL6Aow
Date: Wed, 10 Apr 2024 07:30:12 +0000
Message-ID:
 <DU0PR04MB96365F2B6AFD856655D6A66CD1062@DU0PR04MB9636.eurprd04.prod.outlook.com>
References: <ZfTspRKFgrO9xCTH@google.com>
 <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB9638BE73DDBCE1CE8AA32BA8D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <b2d9a7ef53c5ab4212617e8edf202bbafe52e2f8.camel@sipsolutions.net>
 <ZftaJEIeNfV7YrVo@google.com>
 <PA4PR04MB9638F5037D1AB9BCF51CC9D9D1322@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zf4rDifM6bLuqpX2@google.com>
 <4e5f3741819e457c5c79d825c6520cb9ee531b95.camel@sipsolutions.net>
 <PA4PR04MB96386917877832602F221282D13A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZgxCngq_Rguc4qs8@google.com>
In-Reply-To: <ZgxCngq_Rguc4qs8@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|AS1PR04MB9584:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6TZXFdrFRc3ZNWEmq7CO5xq/J1t23fsSCU2/ug+9V/q6iAsZNvjStYyy9xaED1WnaURmrgVAXDZkgD9y86obDLhFVlYX1ilXTipfczJPlqEiBrtjE0ZlZ+EMB815Pzwt+kuAcg5nVAMSdVj5qbFsEWFkrZ1Ff3g8QCRUNm3nxXys9xH1Ry95gFgdFjNnyZ92wv7jfkjom6V+XXaHVBpXUiE5iMN0Q6NM964XxRahoEmTju2sibIij0Kn39oEWIx3wLCdC18CwIqhXgviXjIMR92svniZ7ed8em2IFotXbdvBPoOu7TJORupdUE1zshtGgryA3jdGCquTv9cb2UXnCOhWU9gT29Hsr8EMQ5Pw7IpzwYMe7mvUnStHHgU60bzgGPMeMOXD/XnZKzaBUpuwHHqCBK6vqcDpLXXWkkTgPG4T89q8pk9kk/OVI15N1Yd8ZUYKcDp6LOvJl8fMkTUtt20SA9/3p/jXaHwtk8H/GF1nJqkxzujeHa6PsAWxcV86wPzz+4q+lNHpL0d8wiQTPfNT/q4FQLln1PV8k0ixmH3ApXhoYodZ+05UtKjEHV5XCPOgZ2ZfCDq+al1ZePecAmUZ7O4BODkF0cOTTNgsNUvkHytdy2QBr0oUbOBhWe2ksh18LF3vmzWAjkIuaNTDHy+iFI0wBSvJU0rDpqIYatk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9636.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jyRAn+62phbgNXoSn6MHmbUvymd7AD0K31HL2qecgU35yvfysy0jrHA3BZ6h?=
 =?us-ascii?Q?YLedkXv3KlMq5CC5ZRcDpOBlgXbQ3jc16cDarYJlf0pWtc0BX9sqqVO8wFRK?=
 =?us-ascii?Q?gFxZaMK4wjCwx/VZBQIyXGlgMFiG5yYcPJ5bMXJU+25vrW/dOugln9WF4Mri?=
 =?us-ascii?Q?2myAKXlWgvIRc8MXvPJxEQdSvwPVerQTNkwbHAhR6qaa7W14sT4lB20xnXgf?=
 =?us-ascii?Q?ON7b88juGoVBXOQZJ+obsEc8YdMw7h1N8gmwTGsla2o8u9BJWerUpm23lpxg?=
 =?us-ascii?Q?0ul/sbnaAIFpklvL29QKPjW1HYCgRCJ1zTKuPp0QYNwIbpFpLZNUUtkX35L6?=
 =?us-ascii?Q?dSQxDPLhKsAa0TfedfcnPbVbcLT8EcAiHXJmX4zFMTDUcl88aoHryflEYykg?=
 =?us-ascii?Q?54vmJWISkWPwRFZnb3ARkk/KDAt83JlTegsEdi3x6ZS75o74joas2CP/tmx1?=
 =?us-ascii?Q?1RygQ++vwB6731Mv3zBZd5KBx/mgcxmsXKldoQJIURgNPIvq39qlqmHFZhGv?=
 =?us-ascii?Q?dMFogRaQ6TcnEelfO4J9RqOmnOZQ3t9XCibXbznYUHfFboM2DVK0pcOIFM0V?=
 =?us-ascii?Q?MJ2POW+mjv0RWbQd4zH98/pmYUaJfgKQmMHj8V1EgRUq1KIdYs6Ayj5thsj6?=
 =?us-ascii?Q?c9/+loWzAy6kbIVmvvsGa23xLpv1YhbAtO0afkt51T05/zp2/ZHvzqqgP9aP?=
 =?us-ascii?Q?YvhP1K6g7zp//lbjtK7e/P9Umdzluo2Yp4V3P/uq1PQf2sFHIJvqGEaXzvGe?=
 =?us-ascii?Q?cgPl9ufk0D17FDJ/DKBR6n2VxUYYyLl2DH8Jaewv2Y892afy0UWxfPpDlAIl?=
 =?us-ascii?Q?lUBV2cx2bFKEKsK+TtZLSUqUP1QaMUyPIdHHeHTJrVl6Iq8/Mzzq/oT2N+gy?=
 =?us-ascii?Q?GEo452h/e9Shl/JMxU7uO8aZ8P4DpRutf6z4g+ShpjyQy+P5QOY/UkQ7A0Aa?=
 =?us-ascii?Q?s9Do3eOcIZox9O7C0DLdA0ckfoPGGiezPg2KElsGcdUSe5MpEKJF34xvu1oB?=
 =?us-ascii?Q?53LWNX5ftSLMvG0ieSeigza1H6BrV1tyzmH63A04Nwh6JEkvsGaOlF/LJp/2?=
 =?us-ascii?Q?NOdglSzHvoYm7taA0KjOk7Ivhxu6+Ptk51GUq2RodGZZv9pvHVLjRJUUuT4W?=
 =?us-ascii?Q?KjsEKZ4L5C7sabnPaHEEX9tkCkvKr8Yo+4gi04tUpRxmAsOmNI21bQ0FP7dq?=
 =?us-ascii?Q?MN953+K6rVKpjwG9FKaAMXFPcBfvNRXwrx4IiFUIXutKj9nXQD+9AO2gjEYV?=
 =?us-ascii?Q?eXCH/eodd5nZZR9z+RI3UQoRm2cVyC8nGVLljAbMuDhe0yJ5+N5oJJk7Ye4e?=
 =?us-ascii?Q?8sdDm1AtjpcHXb3E7k5Iy1O0YAGH9jGJupwbfB6YWQpoTeY/aIufPPKdgSv2?=
 =?us-ascii?Q?+SPIRyczQPXB+jVeRBMjj/CVWWR6UNgpbowSLV9rRHRbGDeVDzdsCS0DusdC?=
 =?us-ascii?Q?SokNCZzdvKDBJSo2tKJRMQxGAGD1UNzfL1NsE+4EnHO0IBXyJ/7HHnJ/p/ZF?=
 =?us-ascii?Q?ghKiaERobUAttFqcZ/EEOG4dK/LQFh7SIHujtLXWnrkyowarTshZ8hIZu2GU?=
 =?us-ascii?Q?RtLtf7pdNmMeZAeXiUvQ5qO65lSUQ+oQTmh0+RnZ?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e713947-ae60-4ca5-05fd-08dc59300f01
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 07:30:12.4332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dp1bmH88mLMQco1Su7C4pT2ziANZsXmGPfcteXiv9M4QSZSQ9nw3Qj69mM+Nzp2SacwV4iyh6h+VoaUwzgoMPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9584

Hi Johannes and Brian,
=20
    I think this patch is used to leverage MLME of wpa_supplicant and hosta=
pd. It won't affect the usage of cfg80211 for mwifiex. I wonder if I can pr=
epare patch v10.
=20
David

> From: Brian Norris <briannorris@chromium.org>
> Sent: Wednesday, April 3, 2024 1:39 AM
> To: David Lin <yu-hao.lin@nxp.com>; Johannes Berg
> <johannes@sipsolutions.net>
> Cc: Johannes Berg <johannes@sipsolutions.net>; Francesco Dolcini
> <francesco@dolcini.it>; kvalo@kernel.org; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; Pete Hsieh <tsung-hsien.hsieh@nxp.com>;
> rafael.beims <rafael.beims@toradex.com>; Francesco Dolcini
> <francesco.dolcini@toradex.com>
> Subject: Re: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support =
host
> mlme
>=20
> Hi Johannes and David,
>=20
> On Fri, Mar 29, 2024 at 10:06:19AM +0000, David Lin wrote:
> > > From: Johannes Berg <johannes@sipsolutions.net>
> > >
> > > The way I see it, the issue here isn't necessarily the fact that
> > > this uses the auth command (and then requires assoc, of course), but
> > > that we see here this is "growing" towards a more mac80211-like
> > > model, with the code duplication (albeit little that it is today)
> > > implied by that. To me, it seems like the firmware is moving into the=
 "oh
> we can't do all _that_ in firmware"
> > > territory, and that brings it closer to mac80211.
> > >
> > > At the same time, as you say, mac80211 is doing more and more
> > > offload capability, so it seems like apart from "today the firmware
> > > requires an assoc command rather than assoc frame processing in the
> > > host", it's actually not _that_ far apart any more!
> > >
> > > Now that may be an issue in the short term, but I wouldn't be
> > > surprised at all if desiring to implement FILS and other new
> > > features in this space would make the driver move to assoc frame
> > > processing in the host as well, because it's getting more and more co=
mplex,
> just like auth.
> > >
> > > At which point - yeah the APIs are still significantly different,
> > > but again we'd end up implementing something that exists in mac80211
> > > today and taking it into mwifiex?
>=20
> So it seems there's 2 possible sticking points: code duplication, and ove=
rall
> trend in the specs and implementation that might increase duplication?
>=20
> To me, it seems like the duplication is minimal today, or at least, not m=
uch as a
> result of anything in this patch proposal. There's some repetition of 802=
11
> definitions already, but that's probably orthogonal.
>=20
> I have less understanding and foresight on the "trend" questions, althoug=
h
> David seems to somewhat agree in his response below -- that NXP intends t=
o
> handle modern security features in the host more and more, which could
> indeed mean a bit more framing-related duplication.
>=20
> > Mwifiex is designed based on a "Thick FW" architecture.
> > As security features become more complicated, this patch adds WPA3
> > support by offloading to wpa_supplicant/hostapd With this patch, auth, =
assoc
> and key handshakes are handled in wpa_supplicant/hostapd.
> > Wpa_supplicant communicates peer capability and derived keys to
> driver/FW via cfg80211 assoc and add_key commands.
> > The cfg80211 commands are standard. Implementation between driver and
> firmware is vendor specific. It shall not break any existing architecture=
.
> >
> > > > It may be harder to add
> > > > future additions to the mac80211 stack [*], if we have to add new
> > > > concerns of a non-mac80211 implementation in the mix.
> > >
> > > Not sure that makes a difference for mac80211 in itself, obviously
> > > changes in this space would then affect mwifiex, but that shouldn't
> > > be much of an issue.
> > >
> >
> > With this patch Mwifiex still a non-mac80211 implementation.
> > Driver communicates with wpa_supplicant/hostapd via cfg80211 I think
> > how driver/FW communicate each other is proprietary, I don't see a
> > dependency with mac80211 here
>=20
> David, I may have pointed in the wrong direction by claiming "conflict"
> with mac80211. I believe Johannes's concerns are in code duplication.
> Pretty much all other actively-maintained Linux WiFi drivers are based on
> mac80211, so that we don't all have to implement the same frame
> construction and parsing code. mwifiex is somewhat of an outlier in activ=
ely
> adding new features while remaining a cfg80211-only driver.
>=20
> But for myself, I'm not even fully convinced mac80211-style stuff makes s=
ense
> here. Even just looking at the auth() stuff in patch 1, this driver is fa=
r from a
> thin layer that allows mac80211 to handle the
> 802.11 details. Just look at the 'priv->host_mlme_reg' and
> HostCmd_CMD_MGMT_FRAME_REG stuff -- it seems that the simple act of
> sending a single 802.11 frame requires opting into some FW-specific comma=
nd
> mask. This feels "thick", like David mentioned above.
>=20
> > > I'm less worried about this individual patch than what it says about
> > > the direction this driver and firmware are taking, and I fear we'll
> > > end up in a situation where over time this driver actually gets to a
> > > point where it should be using mac80211, but because it's such a
> > > piece-meal affair (auth frames now, etc.) and large architectural cha=
nge,
> they'd never actually do that.
> > >
> > > To be fair, that might also require firmware API changes in some
> > > way. I used to think that was something we should never require, but
> > > I'm not so sure now any more - certainly we've changed our (Intel)
> > > FW API in support of Linux architecture many times, and overall
> > > that's for a better product (on Linux at least.)
>=20
> Yeah, I feel like I see hints of stuff (in public driver code, and in int=
ernal
> discussions with vendors) where things really work best in
> mac80211 land if firmware is developed with *some* consideration for the
> mac80211 Linux architecture (or else already is a very thin firmware from=
 the
> start). I don't feel like Marvell/NXP has that consideration at all, and =
so trying
> to drag its firmware into mac80211 regardless would bring its own unique =
pain.
> But that's just a lightly-educated feeling.
>=20
> > > Also: David, I'd appreciate if you actually took this discussion
> > > seriously; so far you've not really contributed any technical argumen=
ts.
> >
> > I think we are using standard cfg80211 commands. How it's handled
> > between driver/FW is proprietary, it's carefully verified and shall
> > not impact other features or break any architecture.
>=20
> David, repeating the "carefully verified" stuff doesn't really help the s=
ubject at
> hand, and it's not really a technical argument either, when it's not
> accompanied by any proofs. Being careful and running a good QA cycle are
> excellent and appreciated, but that's not what we're talking about any mo=
re.
> We're trying to understand what the firmware architecture is like, and wh=
at
> driver architecture matches your future development best, with the needs =
of
> the Linux community in mind.
>=20
> (Now, as an example useful argument: if you claimed that implementing a
> mac80211 driver with a generalized ieee80211_ops::tx() function would
> introduce unvetted combinations of control logic that cannot be reconcile=
d
> with your HostCmd protocols, or that QA can't properly vet that ... well,=
 that
> would be a start of a technical argument. But it would require more than =
a
> sentence or two to describe why that's impossible or difficult.)
>=20
> > We do not see a need why driver has to be redesigned based on
> > mac80211. We can keep adding new features using cfg80211.
>=20
> All in all, other than being a little grumpy about reviewing new features=
 here,
> I'm still leaning toward David's statement here -- that I don't see why i=
t *must*
> be rewritten toward mac80211. But I still defer to Johannes, and I'm just=
 trying
> to be a bit of a referee, or the proverbial "devil's advocate".
>=20
> Brian

