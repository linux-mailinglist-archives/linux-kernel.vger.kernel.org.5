Return-Path: <linux-kernel+bounces-86107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A65386BFB1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8881F216B3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C2538DED;
	Thu, 29 Feb 2024 03:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KxbspWUv"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5D9383A2;
	Thu, 29 Feb 2024 03:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178999; cv=fail; b=F9h8oOuleSKzuQGRCQ2XAaI9QaQ/JE+6nH7VhmP/g+SAEij+Fz9Z6E3sSyNmK6iCAQoDkNW+4D6NS+QdVMy2pAHtQHA6U1PBhLbmKq4JijUkY8pa1Xg9GBewg2+HoWbdP9IyHHW5eRzXy+Q0lkKv0LE7yezG1ejZFdeIak4Ynwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178999; c=relaxed/simple;
	bh=Kz56hq3FFfLfVK82BxEHpa4MUpQfVIGok6G4SF+qN04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dx1dZYunoSyRdJjZLT0GSYRevDyk6Ovx4cNv2PZNNy8HZ5DpXlBdeM9VyDU7nFPGbU2ipE4L2NiengKdUuAdqkI5Qn0jnP3XkGYaIdQukum3zbuR74h/dq3R4QS1ADz7C8AJCGq33s0GDX1OvD56k3EnO0AAG0sID4C45vf4XNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KxbspWUv; arc=fail smtp.client-ip=40.107.8.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISqVrnH9TjyswtMFhTH412h52x87cqhzdPY3ztBdPJiIyrJJ1uWQCbVeqOJ6QAMzEvwhZuxrYaxbbLkJB+GVCs7KFQ3Q55uSq/Z8IJWIJwzLCg+gfqu6/cqLkXiNyUXaLoEq8u1DbtKwYZHBU5+cVTk0jLk+D01kLC1gvVGj1y8XK425J/7/YrrOm8brp3SDWQXBCaOa4xQ+yDV0oYI+NSQVZuvQ3GaIZ+/RXiEhhTLMDfrHcSee50OuqIwkKJxMTaBYFjB9p+dZ9OHwUmHfAER5K9zfMrjGflnA8NY/06dAtqb03yUXvleikX6oU4vzVNhlcb+bzHLnpr2X+Y4/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqq0hbmGDXFQPrMqGSGgrhGhgRvcpXCoA3PH5WuA9AI=;
 b=DY11tmxIa4Nq+UWngHWuo5Ez/LBU4jy/x7oqu36XYjLe+HD8lgM7X9iKRtVeBP9y0xv4Y5Za+VEugK+eYqTnjr4WQPj1srqAgcO/jjU/wCiR4OrLv3C6Z+PugOq5wq0ZZQnPXLV2UG2Ml/1oofO8Z7HGI0nDmPpAXcH8aYA7cdFv8ID8FOnw3EaqEXzYPoCRkImp+lTvMX8ik8YBe5a3jRN6VzjZKMKy3kSvJa6UNjJIfWdo88UQpFR+xmWJpd1+RinKX3Y2FHmfLjEnChahsUntgQcidv/4wxJbNMoneSkUQY2wc7JhExIhbPVmjF+geHCSXFSHuCNA9hYrvdASFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqq0hbmGDXFQPrMqGSGgrhGhgRvcpXCoA3PH5WuA9AI=;
 b=KxbspWUvD6ah7H3zJivORmlnqtLv3qNg8RRVlf+LvG3l2W/9fyhH8kJjyskz3ZvoqqpOhDNJ+Fgg80eNPAXNWqK9ZS4GO+XNTc7N66C4Sr0I2YzVVPxvH8qGSRQTYab7DtFD5ML1YVsMN39Qa89QD3PnPPm7Irl/vY2ai1zFZbE=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VE1PR04MB7231.eurprd04.prod.outlook.com (2603:10a6:800:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Thu, 29 Feb
 2024 03:56:34 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3%5]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 03:56:34 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v8 2/2] wifi: mwifiex: add host mlme for AP mode
Thread-Topic: [EXT] Re: [PATCH v8 2/2] wifi: mwifiex: add host mlme for AP
 mode
Thread-Index: AQHaNIYEQCrM08sOxUmzGM8AlYmOgbEe4q4AgAI6p3A=
Date: Thu, 29 Feb 2024 03:56:34 +0000
Message-ID:
 <PA4PR04MB9638F65E764FA05F61E50AD9D15F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
 <20231222032123.1036277-3-yu-hao.lin@nxp.com>
 <20240227175326.GC11034@francesco-nb>
In-Reply-To: <20240227175326.GC11034@francesco-nb>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VE1PR04MB7231:EE_
x-ms-office365-filtering-correlation-id: 68f84e49-f336-4ea1-2f4a-08dc38da6bf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Cc6SSGXT3BZOqW9y0FaNXIxe9k7hJCnlAuFOFPuZR0pzQvd4iK27D4L3hr6kef9nrTr2OG1Omd42HmjiwcDOMq9ztHKeTpPjMZ9rwXFYlnwaKXUZqsB5Xn58ssuClP7m3OneUeEmwk8/0VrUHBY9IDsOphaCcSFhCtmPXi8aABA97fOgyMpEt5/k5ic98VNALzKPmc7mI63eWHujfOJUwKrq08RL85FaJC86kzDU/s3eA73eyXHjT8ZqRb2Nxo3SQG+5uZdcHGZs71jFg26fCCu5gxeDdFeIosyeI4s29UVnqjHZ1HoxpUeKywxbtB93Zfub8rtXjyv+gmwwudrGnTulz6ctHAscb7PLgrPMdQ5EZtNhpBiNX3biN6xC81b7ICsS4rWL3plKVLAf06LFks4CeuyLXMxE/CXnxd4SWubq0p0tafZcbhWsxtd5LiFuxj50jbOskmmq1/tS6SwzKWswD1t02BWss1kDoHKPh3zRGwigwUzs+qkqZDsiuQtoJVBr/I4r97xs8z/Fwuf8Xb4O8PPtIdo7m0MJmOgZ7j41Pd+OoYhGTr8Z5cfM/WUYIMuWhZrPzdxPOzKjmXw6E4uAjoNj0p+U/iRrJu/9YvPLvmT89lFc3p+3e8m5mv14YSGswXsgdPlPcQED7DXjaQukZrtFwGV+Br/QF8km0X73MPWh4cZFjr/YFGMKaaueaPfKXKIfHpI+Fz8Ui8JgOQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dpj1swDIpJTwt53rSE3VJ+7q9bPSfdTV5m0bMXyhMXfTRI7dlGNzfkRsPdlk?=
 =?us-ascii?Q?9Cg5S+2Bl32rosIWVRfFUFPjkV6bH4O/5Ee5RVOZLUSVqjQJKRgEbp8sf/Oz?=
 =?us-ascii?Q?Hf5yfScNjlQGeFna4e1vRh3Dosw63OVNppaSd5ObeXT25BqWVA3X5U8g9F0/?=
 =?us-ascii?Q?t8M6MAsjgXdG4zaETZ4iu9q7+7C0IUwwaU3dDFja3/kSPPPwXwvXHzB9LmcJ?=
 =?us-ascii?Q?VpOGQox5vr/LTuDxUfxF4nhjQjvzD2OPxlaBrVxnHesU9hqLiMx7IJQ6DaZp?=
 =?us-ascii?Q?xv9AXo1iMoKUPFT0ANO2sfDTcLHNt+m8iTIB0oxfvt5gwPvsQ602jhTddlT5?=
 =?us-ascii?Q?T8tB8RIlrxW2fVfP4Waqmm9/q24FR8BeFffbATo8Eu81d5oQBvw0+Q61eGf7?=
 =?us-ascii?Q?g2xooTbv/fyqJaYQqP+14f90AlMe9v6LymVyL+K2gXjmB+HEjd2tLi/CLcQo?=
 =?us-ascii?Q?u4+HGuXLcjsC7kPnEMWwYUlx6s8+kjub+fE53bOqhBkXTzqiHJh8OGrVlS1X?=
 =?us-ascii?Q?osnpMBxuMh/NLVQKLNbtUYoQ2HX2M8NozAaTGn0Jl2WM2Ox278Mdv1AUe7Ht?=
 =?us-ascii?Q?Xexk9xSb5q5zlkw/InI8PRtVcUkAJBtjCO2UNvfcILlRiC8aG9+H2/XFHgc9?=
 =?us-ascii?Q?iaBohD35XUnFsVAOrJPTyhmVtIlvL+fZEn5mINb5RX/67pgqr0Bf7v/c9lpI?=
 =?us-ascii?Q?4J26cugBtFVtD49cbw8tejXo4NHozRUkY6vgjs6FQw8qMavihzzjRmnQ7T05?=
 =?us-ascii?Q?fPqvQrrJVaQ8HlJEi1EhCsLjJ7zCAXBu3hgNB6gR7gkAsDOX4X6d7tkNV4or?=
 =?us-ascii?Q?wpUMdecGoPfhDTXl6EejrI7f5SRIiS0tVAjozzVk/JT8UMshOS1Yhx1UOgk8?=
 =?us-ascii?Q?AAGAmooKtytK+CoHXMGV8ypou/RXDVZGHMeVGkFdC8VsMjecuI1aXVaeuAQM?=
 =?us-ascii?Q?ncHAsNtUywMsW8b/r0EDsKH0fwQIHjbxFEA0UQNFYOwlPtO6Ku/Zyy63IAhk?=
 =?us-ascii?Q?o+es9kduTn4AhiIbn6HBts6RM7YOegnyx10Bh+ew5WqXKDGjGoxVMn/lt0Vq?=
 =?us-ascii?Q?OZvuNS/dm7svdg/9d8KuvW8ka+EfFr49/L0iDqNiVYdb39FVC0eQpk/Wl8Tt?=
 =?us-ascii?Q?iQEPoF5oS9wPPoodFHm4Y9j8l/6/7lYaQKBWy5H2rBM/09GUR/0CamqGrKpb?=
 =?us-ascii?Q?m4PpHJO6keyH2woTvf5nYo8iVyutfoE5lXari2FFyDwjuHwSskMjvXfsjs7h?=
 =?us-ascii?Q?x789Q9FQAqbDV9KxyD9FjVIu1W91a82nZAIke90C3WqA9HuEqHpBOYLWt9Bc?=
 =?us-ascii?Q?ty/VvXgadAsKIMsE8negIJ7YvxiXMmQHCFyv0xXZcMXkNP2n7q0zRGePkfaG?=
 =?us-ascii?Q?52EnBNACCkWnOJdS+OTNDCt8mb9y9zsEbTMDTKX+8KLCi6ENYbiq5bmGBSV4?=
 =?us-ascii?Q?HkSDgLqhixVKsnZjjuSaC3uen8Ff9IUSNokVXIz175IEjkIHhLF1gylIuSd/?=
 =?us-ascii?Q?d14bBgi86bqiBE9ApUfsZtiNvORnE8EJZn09AktDhoI9DYwaucPzhL9LRJ6C?=
 =?us-ascii?Q?YT942dXya4uIAfdOb4OywnF+dZEAdPTA1Z6gpmWy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f84e49-f336-4ea1-2f4a-08dc38da6bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 03:56:34.4121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFUzRvJl431gb2UzazC1s4qa4ixBDdG1mMXPNQUxiq5CSZVrDhNRK76c7FE98immfU4ElNvd80GGYDqG8zHZmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7231

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Wednesday, February 28, 2024 1:53 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v8 2/2] wifi: mwifiex: add host mlme for AP mod=
e
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Fri, Dec 22, 2023 at 11:21:23AM +0800, David Lin wrote:
> > Add host based MLME to enable WPA3 functionalities in AP mode.
> > This feature required a firmware with the corresponding V2 Key API
> > support. The feature (WPA3) is currently enabled and verified only on
> > IW416. Also, verified no regression with change when host MLME is
> > disabled.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
>=20
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> with the same disclaimer from patch 1/2, I'm not a wireless driver expert=
.
>=20
> > ---
> >
> > v8:
> >    - first full and complete patch to support host based MLME for AP
> >      mode.
> >
> > ---
> >  .../net/wireless/marvell/mwifiex/cfg80211.c   |  79 +++++++-
> >  drivers/net/wireless/marvell/mwifiex/cmdevt.c |   2 +
> >  drivers/net/wireless/marvell/mwifiex/fw.h     |  21 +++
> >  drivers/net/wireless/marvell/mwifiex/ioctl.h  |   5 +
> >  .../wireless/marvell/mwifiex/sta_cmdresp.c    |   2 +
> >  .../net/wireless/marvell/mwifiex/uap_cmd.c    | 171
> ++++++++++++++++++
> >  drivers/net/wireless/marvell/mwifiex/util.c   |  24 +++
> >  7 files changed, 301 insertions(+), 3 deletions(-)
> >
>=20
> ...
>=20
> > diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > index e78a201cd150..1e7f4afe9960 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > @@ -760,6 +786,144 @@ static int mwifiex_cmd_uap_sta_deauth(struct
> mwifiex_private *priv,
> >       return 0;
> >  }
> >
> > +/* This function prepares AP specific add station command.
> > + */
> > +static int mwifiex_cmd_uap_add_station(struct mwifiex_private *priv,
> > +                                    struct
> host_cmd_ds_command *cmd,
> > +                                    u16 cmd_action, void
> *data_buf) {
> > +     struct host_cmd_ds_add_station *new_sta =3D
> &cmd->params.sta_info;
> > +     struct mwifiex_sta_info *add_sta =3D (struct mwifiex_sta_info
> *)data_buf;
> > +     struct station_parameters *params =3D add_sta->params;
> > +     struct mwifiex_sta_node *sta_ptr;
> > +     u8 *pos;
> > +     u8 qos_capa;
> > +     u16 header_len =3D sizeof(struct mwifiex_ie_types_header);
> > +     u16 tlv_len;
> > +     int size;
> > +     struct mwifiex_ie_types_data *tlv;
> > +     struct mwifiex_ie_types_sta_flag *sta_flag;
> > +     int i;
> > +
> > +     cmd->command =3D
> cpu_to_le16(HostCmd_CMD_ADD_NEW_STATION);
> > +     new_sta->action =3D cpu_to_le16(cmd_action);
> > +     size =3D sizeof(struct host_cmd_ds_add_station) + S_DS_GEN;
> > +
> > +     if (cmd_action =3D=3D HostCmd_ACT_ADD_STA)
> > +             sta_ptr =3D mwifiex_add_sta_entry(priv,
> add_sta->peer_mac);
> > +     else
> > +             sta_ptr =3D mwifiex_get_sta_entry(priv,
> > + add_sta->peer_mac);
> > +
> > +     if (!sta_ptr)
> > +             return -1;
> > +
> > +     memcpy(new_sta->peer_mac, add_sta->peer_mac, ETH_ALEN);
> > +
> > +     if (cmd_action =3D=3D HostCmd_ACT_REMOVE_STA)
> > +             goto done;
>=20
> This goto here, skipping lot of code, just to do
>=20
>   cmd->size =3D cpu_to_le16(size);
>   return 0;
>=20
> is not really nice for my personal taste, but fine like that.
>=20
> Francesco

Modify the code in patch v9. Thanks.

David

