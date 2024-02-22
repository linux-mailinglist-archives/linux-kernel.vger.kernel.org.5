Return-Path: <linux-kernel+bounces-76041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E2185F24C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F801F21AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061A817BD3;
	Thu, 22 Feb 2024 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aLectT7x"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2048.outbound.protection.outlook.com [40.107.13.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7917BA1;
	Thu, 22 Feb 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588878; cv=fail; b=AkfMV71t0LwmqSQudX6fLyV0CtRapejWXQiDwhfseh0DcIO61oYUcRROtApnwMunsyA/3Kd8zNpkbnrsVhcW+3SodBsDb07W6vrb4uv9AXYN8NEjsjipqoXbcfwFyuwhSRlkpPDUIBofUF//Nr2Npamc6IM8MJvsofsukyKvPA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588878; c=relaxed/simple;
	bh=6mExgNuIuxc0/qeCwAH8qrYURCxhd4Odfqjt1/GuDo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XsQrnEoxraDSriSaldwv7f/WAcqBA+J3bZqeOdxdZQz7FSJeG9rl+7bWXQZ0XgehvM4Mc0uaAn1TdwwIjuE+DsHrI3KD+J6tSLw+xFoOD4YOH/x0VvFwWABHBy/nbEODt74EKIXEU7N0P7/Vl6Xm57EdUsw7HcNOulx9mfoTyxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aLectT7x; arc=fail smtp.client-ip=40.107.13.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kd4iGC2A1flKj+48w/mOnziqEhNu0REvDCmYtOwWO66oCdv6HZ5MUi0nm/3sxud0WE1RaXxPqe2iIE3ogzaMuSGAchbT/6TUbu8CFcbp50Yg1dP0XmNjDmHicZQvT9E1tXtGFUOPEo7DQGKh2m75uh8hs4ci1vTJ/Zx5dVMdsWLGNKULU5Epv5QxeiP13S0E43qW+pnEE30YKaxkUK/Fs3IGx2hy5b2S5HSdvL77z8U/2UIdp056J3avOOi4ucnSclrcPGSxp/VdjP/zm4VdCPGB9y40WVje4ydvkEJ9hucjcBOhnJ2X6D9X5ib8iSsw8ynu00w9yCpcmUcK8NS9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CxvmmcEvpUDomhFh0db5rE3zD8qY+ZqZU+INhCB85A=;
 b=Ss6tznS8ohU1ncCkDzdMjiTRqRKGa4QBEXnbhNBAKNYggTk8RFzmDBlyYmSn2HOh0BLGPGKMQG1KwniLUSvkWyErPYopF5y06UOv4wOKAYAGcxLRFFEMmS2x1Uegq5sVwhyYyLrddUkP5uERqD8NGcpYT2YyT1qoF5x8QLbaADKdXDQ20BSURQPFw7YTF99PZUSpM0IhzK1yk9/STkjbVai17ay/ez4dMsM8XpsMr2IFoRn2TAzXYd8BHRMDvBEO2oTdPNXt/QSSrqtwnKBqvoIO+s3DrjRY5zIq3jHh2PQWyBDsWp5dO74LUQre4X7hELZE0WVgKlCimJC3tAa2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CxvmmcEvpUDomhFh0db5rE3zD8qY+ZqZU+INhCB85A=;
 b=aLectT7xBwHGp/p/g30QB4YCheN/0OcIZIoy4cMS13EdtKjg76C6e3FAE0yaFLWcSmdrfhNirimebB0ESHSxWXbjzUDm5DkekdNtajVwSVIhQJ+ytxKzaLABFv7TtBEF+bXOfRCD4vLNdo6ZkseV+bop+tHLqV4QYXL51hOTH9Q=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAWPR04MB9839.eurprd04.prod.outlook.com (2603:10a6:102:38b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 08:01:12 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3%5]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 08:01:12 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Rafael Beims <rafael@beims.me>, Francesco Dolcini <francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index:
 AQHaSjEAO+HQnD/Ih0ixtnf/7VSxSLDyBCEwgA2BHICAAKZRgIAKoyiggACtD4CAAOEa0IAAAr8QgACMywCACUmRUA==
Date: Thu, 22 Feb 2024 08:01:12 +0000
Message-ID:
 <PA4PR04MB9638007CEECACA73A6F13BCED1562@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
 <97bb3869-3b82-4b64-87cd-9b63d4516649@beims.me>
 <PA4PR04MB96389A5DDB41DFF80CBB4738D17D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <48364f66-99b4-40ca-b4b2-4adf1071960f@beims.me>
 <ZcSB3_16C6JTgBJB@gaggiata.pivistrello.it>
 <PA4PR04MB96381141AFBE8E61B8DD94F9D14D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <b77af968-ec6f-44df-a544-4ea2a5ad3ff2@beims.me>
 <PA4PR04MB963849A7E04ADEE5DE92002DD14C2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB963887774FBAF4E2E022C552D14C2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <3d1c45bd-fb89-4a4c-8f53-b1775f6c9a3e@beims.me>
In-Reply-To: <3d1c45bd-fb89-4a4c-8f53-b1775f6c9a3e@beims.me>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAWPR04MB9839:EE_
x-ms-office365-filtering-correlation-id: 622be234-99ff-4f6c-27f8-08dc337c6fab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1YQrbD+6ZQNRw5VhMZ14F9ps02Hi6mQL6AwHdD5UEguwSaZdmvikZxQoWLFbOfHkDkz87Y1ZIxhnF8a+HlXTHwkfn4N3m9VyH8WEN7FZn2jFocpMDuLDepgnfa1vQiIydaSAr1VTB6mVvvvW/6jONTAaoc6BwA3UfikCFWieRQ4+CugH2SvBG87Ac35vgvKfqkG1WyeGSZmmW+0ejuqwSbRuEjSZGiPMiUqIslhl1HpJ/srEDTxHD7wDljBQWDBEBjYUhWIrl/n+NuPfBzKz6jDia7zCaEuDV8Dl4X3xawKx77xENtFS0Yy1EqkH2L6U9SntwqOJ8qVGM9wfp18iMUFXNFOKKrOzzTIh+T0tZfMf7FwEOsxpDntChH+yFFpuJobq2x9afBGQyXRHkTlUs5Bpibsz8X4NHtntUTDFYj3N/zfW0ofF1f5UncUpwpMx4jW8hyx4EvmY+a6lcvrTvXADQT3J7rvsMn0ZDqm/a+MQA05+8yDEJ5CRhdwkAN8ld2rZeJSC8hDEBt06NqANiKY9p+NLhDj5LOmGXveu9BM0r47cvGjD8lOoAh0sLiXPsgi225gqeL2bVmeN1d5LuDpufiCw6ZXauVHW/Zhw/gU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?05rezAq2PTZ6IICLy2RrDHBkHYmf3nMKk3zlyw5M0YlJZDzopN0zNMWrQazX?=
 =?us-ascii?Q?PkVBEZ74jeJFSgn/tECMLtxIhh9WghoQXWStzIVdlBcEMjafmgklbsKhchAS?=
 =?us-ascii?Q?OKRGL8ocUDso4XMNkhyBr1TqbTSp68OO2tUZdtTHC3E8wNNstS9UxFxjo2Xr?=
 =?us-ascii?Q?DI3sQm3xlH02xpSVX/ItKODf30iruba35GcuFvuEgoa1837B3IbSqqbb0Es5?=
 =?us-ascii?Q?+p5gFG+sDT5Syk+jdyDsVp5AdGhsGMQNGqqNx/+0EwOTrV2AfSYVh0HXeiml?=
 =?us-ascii?Q?yh75a5b3c3pW/hr8puYePnsYrxO3iBOS5iu2pjjW5KL1P1hryna4aPXVJbLr?=
 =?us-ascii?Q?hMRNeEDV6E2u9xkDfIqbz6W0PBl3FXY1UYzNys2/HSi/zKEv5hgNfjbxENNh?=
 =?us-ascii?Q?ojPPA9tQBzbDrYU7o5/Z8TJg7rK3zqdKKFwbL64stYPAObyi1jWyy+7kAkqS?=
 =?us-ascii?Q?exWMxDVChxJQDj+au8JH4C7o2Qmhc64tkWVhMApYqtnADoEMDliseSMIrpa0?=
 =?us-ascii?Q?ZGz83BQpxZUERHq61I0EoaUOpn7+WDBk2UrXlo5goTHK1mSfnvO/P31ldFh9?=
 =?us-ascii?Q?mNKQK2WXJyU6D6trf09WgcUsvaoDBB0qriQ5u73py1+5JW5UP2x4wBg9FjmR?=
 =?us-ascii?Q?oc71Y20xgtmRAKky/Hk8KuRxmexgRgi4IzKy7CwcewOUE9++KsgZaik4IFVS?=
 =?us-ascii?Q?R5AlCDwz1yx/0pBlqS6fySYhNj1AG06SK22FuM0It2tpBYDu65ocELgqtjm9?=
 =?us-ascii?Q?L3TjdvgiH2sCgoCgQOElmnPXERTLgJlmJjT616guOywodJet+esMAxIqSZ0W?=
 =?us-ascii?Q?1vmMaWjo2ngL7LNg7zEH9xtnnQNzXATJvexk8KK2ySeBgv0fdsAdpXxi0YW3?=
 =?us-ascii?Q?b3/vdxPLkt4L0w0HcQixLIjQ47G2ADncYIGhRcdfDF/jsQpBQ4Ja4QXGcw3/?=
 =?us-ascii?Q?9UimkQypdM8w+pNDHoC5nkNE19DNQ3//R6CN9yKjv5oOGGQA/EG8sJ3UAJ3T?=
 =?us-ascii?Q?c/YOc9klwdhEbfIlmuz1n14NOeuLLjZ9MF1CVWeC2ksMzYPbDFMQ5OOUGo66?=
 =?us-ascii?Q?1x+1RcCHTrDLq8/ecd+u53QKKGDhvMZXsrCMtPFY+Yp5QayYDlFngFZCtMKi?=
 =?us-ascii?Q?eegTHbaqBmRS5qcYrMlVhEp4MYfo9OTMsztgHTutON8xoMqGAth6jzQ2RdpI?=
 =?us-ascii?Q?JlUI2WvYbLQEzEb23yzb1unH/30LZsRxDTFz6bs3bRRag1IxIdvHSRQgHYqr?=
 =?us-ascii?Q?PY/gox33l/i3NxU8OxQAwJhfh7zgQuwSdj4Lvc3+Dfk5VSNgbOV4h9DjFv5Y?=
 =?us-ascii?Q?Hs8wXXjE4MisCN/VJy1ZKR7QTNQCyBIbL/dPFE41xWRcKQvf5M+fXIMtiepU?=
 =?us-ascii?Q?BQ8qXcHmfrvh+hwX/S1wsYQkEBsn+BlMmXWoJJv3lXmHpaAIqqqOR7dEx0H/?=
 =?us-ascii?Q?6pVYjudbG9eHDauTxbGC5dotPShUdi2QF3R6YkG5zhlIiR9BKcsFvXwWMwCK?=
 =?us-ascii?Q?DM203QS4drfclU9uu8B2XJBgu21Z/0uHN2Lou1+Dbnz4YTUeGDlIT+lgrOIg?=
 =?us-ascii?Q?aQsPzovvgH1LPN9fgspQALmGUomcIZBjB+DcuwrZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 622be234-99ff-4f6c-27f8-08dc337c6fab
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 08:01:12.2185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EuWnx/0LcAMe2jZObp2EeZ9KP1uPRnF7lfVIOOHl2Prk5kTdvo/z8VCV4H7YcAAkrA9YqJmJ6WNgEcxrwYCifw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9839

> From: Rafael Beims <rafael@beims.me>
> Sent: Friday, February 16, 2024 6:11 PM
> To: David Lin <yu-hao.lin@nxp.com>; Francesco Dolcini <francesco@dolcini.=
it>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support =
host
> mlme
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On 15/02/2024 22:48, David Lin wrote:
> >> From: David Lin
> >> Sent: Friday, February 16, 2024 9:41 AM
> >> To: Rafael Beims <rafael@beims.me>; Francesco Dolcini
> >> <francesco@dolcini.it>
> >> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> briannorris@chromium.org; kvalo@kernel.org; Pete Hsieh
> >> <tsung-hsien.hsieh@nxp.com>
> >> Subject: RE: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to
> >> support host mlme
> >>
> >>> From: Rafael Beims <rafael@beims.me>
> >>> Sent: Thursday, February 15, 2024 8:11 PM
> >>> To: David Lin <yu-hao.lin@nxp.com>; Francesco Dolcini
> >>> <francesco@dolcini.it>
> >>> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> >>> briannorris@chromium.org; kvalo@kernel.org; Pete Hsieh
> >>> <tsung-hsien.hsieh@nxp.com>
> >>> Subject: Re: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to
> >>> support host mlme
> >>>
> >>> Caution: This is an external email. Please take care when clicking
> >>> links or opening attachments. When in doubt, report the message
> >>> using the 'Report this email' button
> >>>
> >>>
> >>> On 14/02/2024 23:07, David Lin wrote:
> >>>>> From: Francesco Dolcini <francesco@dolcini.it>
> >>>>> Sent: Thursday, February 8, 2024 3:25 PM
> >>>>> To: Rafael Beims <rafael@beims.me>
> >>>>> Cc: David Lin <yu-hao.lin@nxp.com>;
> >>>>> linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> >>>>> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it;
> >>>>> Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> >>>>> Subject: Re: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to
> >>>>> support host mlme
> >>>>>
> >>>>> Caution: This is an external email. Please take care when clicking
> >>>>> links or opening attachments. When in doubt, report the message
> >>>>> using the 'Report this email' button
> >>>>>
> >>>>>
> >>>>> On Wed, Feb 07, 2024 at 06:30:03PM -0300, Rafael Beims wrote:
> >>>>>> On 30/01/2024 04:19, David Lin wrote:
> >>>>>>>> From: Rafael Beims <rafael@beims.me> On 22/12/2023 00:21,
> David
> >>>>>>>> Lin wrote:
> >>>>>>>>> This series add host based MLME support to the mwifiex driver,
> >>>>>>>>> this enables WPA3 support in both client and AP mode.
> >>>>>>>>> To enable WPA3, a firmware with corresponding V2 Key API
> >>>>>>>>> support is required.
> >>>>>>>>> The feature is currently only enabled on NXP IW416 (SD8978),
> >>>>>>>>> and it was internally validated by the NXP QA team. Other NXP
> >>>>>>>>> Wi-Fi chips supported in current mwifiex are not affected by
> >>>>>>>>> this
> >> change.
> >>>>> ...
> >>>>>
> >>>>>>>>> David Lin (2):
> >>>>>>>>>       wifi: mwifiex: add host mlme for client mode
> >>>>>>>>>       wifi: mwifiex: add host mlme for AP mode
> >>>>> ...
> >>>>>
> >>>>>>>> I applied the two commits of this series on top of v6.7 but
> >>>>>>>> unfortunately the AP is failing to start with the patches. I
> >>>>>>>> get this output from "hostapd -d" (running on a Verdin AM62 with
> IW416):
> >>>>>>>>
> >>>>>>>> nl80211: kernel reports: Match already configured
> >>>>>>>> nl80211: Register frame command failed (type=3D176): ret=3D-114
> >>>>>>>> (Operation already in progress)
> >>>>>>>> nl80211: Register frame match - hexdump(len=3D0): [NULL]
> >>>>>>>>
> >>>>>>>> If I run the same hostapd on v6.7 without the patches, the AP
> >>>>>>>> is started with no issues.
> >>>>>>>>
> >>>>>>>> Is there anything else that should be done in order to test this=
?
> >>>>>>>>
> >>>>>>>>
> >>>>>>> I applied patch v8 (mbox from patch work) to Linux stable
> >>>>>>> repository (tag
> >>>>> v6.7.2).
> >>>>>>> Both client and AP mode can work with and without WPA3.
> >>>>>>>
> >>>>>> I went back and executed the tests again. I re-applied the pach
> >>>>>> on top of tag v6.7.2 to make sure we're seeing exactly the same th=
ing.
> >>>>>>
> >>>>>> At first, the behavior I was seeing was exactly the same I
> >>>>>> reported
> >> before.
> >>>>>> Upon starting hostapd with our basic example configuration, it
> >>>>>> would fail to start the AP with the error:
> >>>>>>
> >>>>>> nl80211: kernel reports: Match already configured
> >>>>>> nl80211: Could not configure driver mode
> >>>>>>
> >>>>>> After some investigation of what could cause this error, I found
> >>>>>> out that it was connman that was interfering with this somehow.
> >>>>>> After killing the connman service, the AP would start correctly.
> >>>>>>
> >>>>>> I want to point out that this behavior is different from the
> >>>>>> unpatched driver. With that one we don't need to kill connman in
> >>>>>> order to start the AP with hostapd.
> >>>>> Any idea what's going on in this regard? Is such a change in
> >>>>> behavior
> >>> expected?
> >>>>> Francesco
> >>>> When I tried to test v6.7.2+ (with patch v8) on NB + SDIO IW416, it
> >>>> needs to
> >>> issue "sudo systemctl stop NetworkManager" in order to test AP mode.
> >>>
> >>> The issue I reported is that the kernel with the patch is behaving
> >>> differently when compared to the kernel without the patch. I kept
> >>> all the test conditions the same, just replacing the kernel. It
> >>> seems that you can reproduce this on your end using NetworkManager.
> >>>
> >>> This is a change in behavior on userspace that's not currently explai=
ned.
> >>>
> >>>> For i.MX + SDIO IW416, it needs to install following two files for
> >>>> client and
> >>> AP mode to "/lib/systemd/network" for systemd-networkd:
> >>>> <<Client mode: 80-wifi-station.network>>
> >>>>
> >>>> [Match]
> >>>> Type=3Dwlan
> >>>> WLANInterfaceType=3Dstation
> >>>>
> >>>> [Network]
> >>>> DHCP=3Dyes
> >>>>
> >>>> <<AP mode: 80-wifi-ap.network>>
> >>>>
> >>>> [Match]
> >>>> Type=3Dwlan
> >>>> WLANInterfaceType=3Dap
> >>>>
> >>>> [Network]
> >>>> Address=3D192.168.100.1/24
> >>>> DHCPServer=3Dyes
> >>>>
> >>>> [DHCPServer]
> >>>> PoolOffset=3D100
> >>>> PoolSize=3D20
> >>>>
> >>>> I think this is not related to driver.
> >>>>
> >>>> David
> >>> I didn't really understand what systemd-networkd has to do with
> >>> anything being discussed here. We could use it to create an AP, but
> >>> that's not the test I did. In my case I used hostapd directly.
> >>>
> >>>
> >>> Rafael
> >> I think the difference between previous driver is host mlme.
> >> Systemd-networkd is only for address assignment, so it won't affect
> >> the test of AP mode. However, Ubuntu Network Manager will affect AP
> >> mode test, so it needs to stop it before running hostapd.
> >>
> >> David
> > I found
> https://groups.go/
> ogle.com%2Fg%2Fbeagleboard%2Fc%2F3Um2Xqa2MHU&data=3D05%7C02%7Cy
> u-hao.lin%40nxp.com%7C4c74f7c309e243eb6c0c08dc2ed78b4c%7C686ea1d3
> bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638436750492293425%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D99eQWmm39kbo63JKNFbiljFQz
> o%2Bz7ki%2FSsllw%2FdonbE%3D&reserved=3D0 to setup commman with
> hostapd. Can you give me your setting for commman? Thanks.
> >
> > David
> >
> Just to make it clear, we are *not* setting up the AP with connman. On ou=
r
> reference images we have a simple service that starts hostapd directly. W=
e also
> have connman running by default and it's responsible for setting up the o=
ther
> interfaces (ethernet, wifi client).
>
> In this setup, we previously were able to just start the hostapd service =
and the
> AP would start working. Now with the patch, connman seems to be doing
> something with the interface that causes the AP to fail starting.
>
> For reference, this is the simple AP service we start:
>
> [Unit]
> Description=3DHostapd IEEE 802.11 AP, IEEE 802.1X/WPA/WPA2/EAP/RADIUS
> Authenticator Requires=3Denable-wifi.service
>
> [Service]
> Type=3Dforking
> PIDFile=3D/run/hostapd.pid
> ExecStart=3D/usr/sbin/hostapd /etc/hostapd-tdx-demo-img.conf -P
> /run/hostapd.pid -B
>
>
> [Install]
> WantedBy=3Dmulti-user.target
>
>
> If you want to replicate this behavior on your side, probably just buildi=
ng
> connman with yocto and adding it to your image is enough. After enabling
> connman to start at boot time, you can try to start hostapd manually.
>
>
> Regards,
>
> Rafael
>

1. Without host mlme, management packet filter of AP mode is the same as cl=
ient mode. Authentication/Association packets are handled by firmware and o=
nce if station is connected, firmware will send station connection event to=
 driver. So you can still start wpa_supplicant and hostapd on uap0 at same =
time. However, this is not correct setting and usage.

2. With host mlme, management packet filter of AP mode is not the same as c=
lient mode. Authentication/Association packets are sent to hostapd, so cfg8=
0211 won't allow wpa_supplicant and hostapd run on uap0 at same time (diffe=
rent management packet filter).

I think no matter with or without patch v8, setting of connman for uap0 sho=
uld not be client mode. Setting of connman for uap0 should be ap mode or by=
pass to control it as client mode.

The behavior of patch v8 is correct and it can avoid user to run wpa_suppli=
cant and hostapd on AP wireless interface at same time. There is no side ef=
fect of patch v8 for this behavior.

I also found document from Toradex about how to run connman for AP mode:

https://developer.toradex.com/linux-bsp/application-development/networking-=
connectivity/how-to-setup-wi-fi-access-point-mode-linux/

Please check section 8:

Enable and start hostapd service:
First, make sure to blacklist the uap0 interface on connmanctl by adding it=
 to NetworkInterfaceBlacklist at connman/main.conf.

I think to block uap0 from connman is correct way to run hostapd on uap0.

David


