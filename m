Return-Path: <linux-kernel+bounces-109562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AC8881ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E9F2830D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB90567D;
	Thu, 21 Mar 2024 02:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QnoJOHPq"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD71C2E;
	Thu, 21 Mar 2024 02:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987129; cv=fail; b=TTknfCfDhtGYEjhsi7luJVopbfZR+a//1KydcAmqPGJy556eaTdCIi2I8tUNuWMFkkAbLDP1BlvomjwaHZZWiARoYVb7UJhuM5h5I93X6Gqh9kbWkYUYVd9KUX8SKfJB/fd237rfk54+5zLIwIozk5z5QWW3nWf6ejcwR74+QH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987129; c=relaxed/simple;
	bh=nL2As3UX3cdWiFPngvF7i0fV7NtuZffTw3mPunJg8aE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pIkUNQGdfe/0O0sNFFTJFRjv50+vZbHkukAyyRaH7rFWR5NOtgXKS9GYeebPulVq00/Cpz6YgqR8Es9YrBsga8Pa7TkwP+dla0RGxzKi5UcJrcR040x8RK6G5co9Lc0pf3d1y6ooB2wiMmDc4c0QU6eVxK1I+KJzGsEN26uq1IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QnoJOHPq; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9E3oeyMc0ibo3TB3Qag9b/Dp5aJ+ODHSbJFj7Fqcbhubehmg5FkfcLBr4VzAk1bzOaed4JXJSASsrI9uG1nCdc9FqMAeIx6u5OuLqbBaCJ+AfOvhJB9+0f6df3xbWbloyp3+VXz+tSO+MVLb9qIKwrErk0zT+ZpBnTphEwBcpZ0W5fGyjW2L6ShJ96wAJX1PdkM5PTwfM9c28aK8D6jpzg8qpxxwFIvL/89iaQmygvTMV1S0pflNkkelo4cze8iVSbWBbJi3tMVpZPQJIMNeV5NR8dW5lIFdwXkwGuoVjVMi0ji4IQYVv8Kam69nKYSwYAWV1uIwTyJxKRJTSadEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nL2As3UX3cdWiFPngvF7i0fV7NtuZffTw3mPunJg8aE=;
 b=lLY6q77RI6H495OHSKQPIf9u8RGMt40K9KuWHqRvma+KczcE35M8UDHfuDaQfxRj/3HBNSVloUwhe9wwa/UuqgGxRyBx4ipKXBTLa7GjlqtrOyqFcmkDOH9XCQLGdu027ScOh9ZHkAnSmMKRxo0/gvPuvaHBUPw+mc0dOZjbDlXJ1jgMhh2W2AGcOi+Kd54e4oqysHStaRL7hsXQyx8lsAb2j3uk+YggnaBUpbxg8l6vAeboOEQ+LFJUCVKS/zw5+uKPnoKkwxl0XOhOlcsQVBVMxBU+XS/1LLUUhSylcnTFNr5NBHXj/W3tM0p2oOpV5z44br+tIC758b/76GgWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nL2As3UX3cdWiFPngvF7i0fV7NtuZffTw3mPunJg8aE=;
 b=QnoJOHPqpRZmFXmrBzDDAcBw2lQApuRZfgdwezLvNv6vTtgEmTdR6LqqbjiACuapyCkWVF3ehtxMbTv70FOs4wNG9mcIRGvEHqv4u6SoETWlKc4i4arKZVLXtNX3jA4XKEg8CzEjVHdmRVrYzPJQFvVoG2lSLxGHhHj0zLVAnGk=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM9PR04MB8860.eurprd04.prod.outlook.com (2603:10a6:20b:40b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Thu, 21 Mar
 2024 02:12:05 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7%3]) with mapi id 15.20.7386.030; Thu, 21 Mar 2024
 02:12:05 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, rafael.beims
	<rafael.beims@toradex.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index: AQHab2onJLj7by1TDUGmc5gbcJq9YLE5jRqAgANHPyCABGO1AIAAUzFA
Date: Thu, 21 Mar 2024 02:12:05 +0000
Message-ID:
 <PA4PR04MB963859F686A5AFD1AEEF20D9D1322@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <ZfTiz_fhzPwRk4Xb@google.com>
 <PA4PR04MB96388A076FC16CF4C76F661AD12D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZftRdB5_Po-1Qnb7@google.com>
In-Reply-To: <ZftRdB5_Po-1Qnb7@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM9PR04MB8860:EE_
x-ms-office365-filtering-correlation-id: 985fafeb-81fd-41f5-8665-08dc494c4dd6
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G4CiEyT0SDNmEtxakJX/i+DMf8SFuNGXvfJz3dzUG0PT3MoQMj95t1zW/0wEGXUBykzNcPY8a8NEIgkOvQnmkd65BAtLyp3BqZ1+W0099N4HuePUG5R1GKIVu8L9LPOI/Rm/YmQncqmCn5OZH4sqWpqFE6upXf3m5osqMdLJvE0QZBwV4/TmCAYIcdjUdhgw5XU+qG+CpONuTJKBZqJ6e/qTJvyobJGHRaf/Z4NzQyBTab5tI7DVhPbXtA5HVENtYzwflETcT4Ca2pvkBjL8/M3MZil0614R4f5+UC4ml2UaNYJrtv6QYktsZt8hSPq8gb+NZCOv7AuYhOF18NZnqmjrh9FnsEJH3ieZ43GjdqScOfmwJd/6xC5FTiy7MYISobw4Ek7glbC/ShaN+551gwBGegNZhnwsGo5a+t0sZ/LGh2EQZwPTYYMnVgpf+xfaRdHySDaufsnEu8fHLfpPEB2zZuMG2+SaTPJSjF4Mwe1J3ki50IVOo7OkX9S8DflBuS3OCEJoEguYkHeYIc8cG/XWW2kCCQHoGXBJiXbbGw4fDXdGF6WjXllcwWi41s+zXbYJcCqdIrYNmMfY4SKNCNuzMVUGD4q50sj6ohqTYvm96s+Gk1o6j6R799PF7pJg7P+cb0uUR+b85QyG/WmF0lPMLbIhD0NlonCrvHuDrCA6pcP4WxugPkxD+lKET7wM6kElddQ8ssz6MpKpynk9SlFRxlSAPE5gP+fjL6hxd+U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tbzsQ7W1DtDhZ4gsA8cdJ/AAlGjwkFyfp8dvDNxGt6j6AI1sPjqzOtNf83Uk?=
 =?us-ascii?Q?gdk/pPFE9C+o0zlNEsFkQByetaSKbuyUIrcGkm7zCO9/cW5GWmb/TdQtmhJZ?=
 =?us-ascii?Q?XwjP1kXGtHqCUPxBqvasedCNmwXZMz/A1RPUkrro0b+8TLC61eusjRFaI1z9?=
 =?us-ascii?Q?5dAB6VRgsS8YG4ZN5HfSuHsOxZ+6TkDDLfPXU0GAOT+iRjvYxL95dSS8HhKs?=
 =?us-ascii?Q?1XcYzjHQHepLVmQ0IwP+lCRtNM7Hq7pwD4XmrVI2cO9XIY8aRnYMjP/kJKL1?=
 =?us-ascii?Q?UJPWRwSSYBsJlOPawRmxI9KnaCV2L0NX7baEBIXsZsAkt8ytt6UuxRsBErvS?=
 =?us-ascii?Q?gwuGDk6eCLfDMwvP6j8YmbXTKVRNj0PAXL6tyEB7zdMFmD4rndDOMx8KmZyX?=
 =?us-ascii?Q?vBvvOmk7mNAz5ByY/kpudqB8UEVDIlkpCsELUV9tTi1IzVRIBIdte1wQYCA4?=
 =?us-ascii?Q?POZHm5vLI3lpLn+oLkzZwv/TGl5s2zrT6iwDhlbmpjU2j4y7s+780NaTom2K?=
 =?us-ascii?Q?nSszDZWRAX9hyMYBcDvoXcVeLmypfSrRkO5c9xluja8rfKNxYiaYsPtuku/S?=
 =?us-ascii?Q?wSzE8pKC/DIscDgj+3U06wbukkJ0TTJErnnY3K/DFPjcH5PcjSb8zk+fVKXk?=
 =?us-ascii?Q?ldi1izbDHSl5okIgsIFhsG3ZST+OGFGNq5Td3L1OknP6EGJoWhs03yywEg2l?=
 =?us-ascii?Q?3PhTt+6GNKmMNwUpMx4i6gLUfEdr49KKoRWT/o8EONv6B4KS68bFv6qDP3tF?=
 =?us-ascii?Q?czhOR1FOxFisnfXyL5odI/yadoaRJSF1cUKAapCeQhge0WqreQBEvLmdSJm0?=
 =?us-ascii?Q?9ZN+Rn3GJNJHXxFxraPACLF/xmNNJJuiGxO4PLsflxQfuKLlu7UW9WMkdoVl?=
 =?us-ascii?Q?q/FbSNzlZj+rX93AahFB+3ka0nQTH9n0EXU9RSl1EJwN9pkI9UaFCbwSz3nO?=
 =?us-ascii?Q?oXkCXwqc4T9YRyHgQ3VcbD47TZUVHwlhHFSsENIPzfJ28wSIuetb+B5ukLJ7?=
 =?us-ascii?Q?XRzElkMeMB7HlOVZa4nGTHrFQIB358Ia1kh9oiioGr5BlIqk7HjKZdEdc/xU?=
 =?us-ascii?Q?LVFHiKvm1zO6XDjLiRA7wN9F/8dLBFcOvjExMQxnJxI+N1OY+mIVFvA5Dll0?=
 =?us-ascii?Q?Qg0iCP3fcZ5Fz1S1nMNp9NJC0N9C/wkwATnx3aj3SWgpHwZeZlq0NMKJKRm+?=
 =?us-ascii?Q?VSHsEvv5V89WO5pvpu+toJ4V7VttrNtExYZLfDFbYjSiGfDzMX7WrmopH0E4?=
 =?us-ascii?Q?EaRFn+8khiMwyPJ21FoZI7Pe0dP3rE123+U5KXm0XaZDO5061ALNAZMvPDSU?=
 =?us-ascii?Q?wd36SMf7PaCkJNAgUVLDmyynr1Yo8NtmDKAE1Se2YGSQb9y031mf0XErsTFM?=
 =?us-ascii?Q?AF9pvLYfaUT3h5TWhRt7z9nJg8Ez0T5F38IUV6ZhZo4tgMyYwh0vauTiNc3T?=
 =?us-ascii?Q?RJNTwHcpgxXWnvTSsFSKNHUiwASAsAVr2ARt7CeFkOcO5WzsbFOqkJQ7+UO+?=
 =?us-ascii?Q?dXSDvYWWqWWSqoiWezrrhLA3Q/t0j6IZTh1dcODA4dqQKjdD8HL5lp54vgny?=
 =?us-ascii?Q?2bhATVNcaMtbT6kkYZaUtwoYJ9mIcJIiE6+sZ8Ay?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 985fafeb-81fd-41f5-8665-08dc494c4dd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 02:12:05.1619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqZo/qvb9w7ICacH/A8MnZuam4SeiagURJQOw4OP7zTJy2V2KDYL5/TaI0lU9QBmdFBPxzPznKzGgvRrHbljsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8860

> From: Brian Norris <briannorris@chromium.org>
> Sent: Thursday, March 21, 2024 5:13 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; rafael.beims <rafael.beims@toradex.com>;
> Francesco Dolcini <francesco.dolcini@toradex.com>
> Subject: Re: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support =
host
> mlme
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hi David,
>=20
> On Mon, Mar 18, 2024 at 02:20:56AM +0000, David Lin wrote:
> > > From: Brian Norris <briannorris@chromium.org>
>=20
> > > I'm not sure if this has been asked/answered before, but are the
> > > MLME/WPA3 limitations exclusively tied to the firmware support ("V2
> > > Key API")? Or are there hardware limitations on top (e.g., some
> > > firmware might get
> > > "V2 Key API" but still be unsupported on a given chip family)? Could
> > > other chips chips theoretically get this feature-set in the future?
> >
> > If firmware reported support of V2 Key API, then host mlme can be
> > supported without issues. There is a flag 'host_mlme' in struct
> > 'mwifiex_sdio_device' to indicate if host mlme should be supported. If
> > this flag is set, driver will still check if firmware can support V2
> > Key API. If firmware can't support it, host mlme will be disabled.
>=20
> Thanks! If I can distill the answer: it's just a software/firmware limita=
tion, and
> not a hardware limitation. The hardware limitation flag in this series is=
 added
> just out of caution.
>=20
> Brian

Give user the choice to use host mlme or not.

