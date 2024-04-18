Return-Path: <linux-kernel+bounces-149709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC238A94DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1141C20C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB6312FB18;
	Thu, 18 Apr 2024 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LPYlXqyW"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4C82838E;
	Thu, 18 Apr 2024 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428682; cv=fail; b=jJGN3gwgIIyXiXmm4UIOnvPWvHjCIouwPIl69d/O9reLavkylLKLFASGQXvCywR/XaYY0AmwOmthwQi9ftob4wEkC/x7gBV6wnAu7dcBkUvO+elCBiJsY3noQsBdxLVsXmgxbbzZtfWDib9a6JTOhJe0mS3iE3qA8SsDHbitjI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428682; c=relaxed/simple;
	bh=AosRRzw7JPjdWIx/nIPsflhO2UHtAhR2kEW+Mg/VAKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YN48keveB141PU2XYTvCAzaTRTfzstXwcGOMnjlKs/7pe0PQxgrs2v24ki86WxVMr6fdpGlkOR7fzPOCNdiIHEfaqnpgItDfvQphGzGgGuQnsI96cv0JFancvx30dCqyqcAr3nKk3L025NA07XQ9cPIxeIYcIfEY3tmQJxQb+3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LPYlXqyW; arc=fail smtp.client-ip=40.107.104.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bns5DHcmJTgppOoVE6TpeArWvRJmeD+l8147yjXHNnV4owgLMEPLx3jUxa+REm1pBa/NRoH4xiNvfqXEWVyGNhwMlUKs7GQWVYCDgzMuMWnxskgsGZTYzjeZDWqrX6x3Gk+u43ep2HCKz9UhPxXLzaVTgQ0vayWD6ILIN1Da6ZWp1Tkb/mj8ayEc4Ag586A1gWUz21TRB2AQsiVO3J5irJxyVGKmDr3PtGDW2EmMLAfk9VsNx9E7crznIq1DYez1RwPRAHKwYyf977cyEwzgT3LZVE8zF37Qwm0IQSokE1RxWoNPj0PA2d5K+3a/VOygm7oEN0j1XKCjMzK6hWxEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZcyOlU4VCi6/OUrQJUN+lbW9CCwGgkTX+zQBpSskt8=;
 b=LVXmeVi5Wx9G0m+Wn52NkrXWDqDTLMU7Jy0uP/dC8B5Fx1f3Lum4yN5KSkAIeY7kJ1XR9/NntIqo7w0LIMlV5zYs3UZidygz7Be7P31Lpxw0PIBQUiD6wKUa/4uEY5e1Zu5oWgZE8Mb4oIeU3voF9a9h63WRjjtPDzGUKeQAKFOPFQGLJeXQqw3L9DzP+C32IIR+xuZVIRHHVVgOly675Pcu3k7wOMA/Y8dGaaEFu0D0M8LUjMyXxgXvPqT7B4X7G0QewCg+qJvYnWv/uq3aS6d+Y69znHFn6DKjpB+qILDeA9/VJViRFUPaZbcETJItILqErNfDQaNWy4OtZMFblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZcyOlU4VCi6/OUrQJUN+lbW9CCwGgkTX+zQBpSskt8=;
 b=LPYlXqyWRQ6xO1YATi4a3qLcPOLESt7v6vzthUsSSPb5rlsBJVwitz6b85KoQw4KRjmy04nFZGQQjWTw45EohyKIRNGStrWvHHO/c8V+zwqzBg2eYjX4Dy6KtF5P2NH2Ckxt9JW2VynEs2NYpioUuzl/wnPhZ03nq1+mqK4abY4=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 08:24:37 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 08:24:36 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client
 mode
Thread-Topic: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for
 client mode
Thread-Index: AQHakVadTJiKH7Fbwkii2Ljo0AqkAbFtkzUAgAAc2KA=
Date: Thu, 18 Apr 2024 08:24:35 +0000
Message-ID:
 <PA4PR04MB963811B14B2FE5ED8A56AE39D10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-2-yu-hao.lin@nxp.com>
 <ZiC_wjm79RvrC1jp@gaggiata.pivistrello.it>
In-Reply-To: <ZiC_wjm79RvrC1jp@gaggiata.pivistrello.it>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM9PR04MB8874:EE_
x-ms-office365-filtering-correlation-id: 6b8c28f2-8071-4fa0-a1fd-08dc5f80fb8a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kqWWCzRYabI+20x9VmafjMnTPoHsYjjVRf+18a/w/8KX6W4+hiDbuc5te9dROkrQ8UVjDybMZ7wGV4wfBkYWsuVp2DiqH/5jr70D+7MAQpf6/LO9sJ1C5AmFDSiT89/Pvaes2lgYEOP+pxh6Zr+8LcaP8ZeHJQ1LgrmZOi9ICq6AyXrO0WyU2fYofA+2Ha3uhHJQHCyeHMVo1LOftPFfN9fyci+5FnvWHJqdzvgK7kjlxiIMFDnJ/s3mel0MqX5R7slgmCCPoxYxyuUTlHMgbSV/yktv8UW3TYBytFlYMKufWMQo3+/I2Veg6a1MdewWlI+AnZ96aRVQ8V3xJe3izjxqEB9j2aT4EHfZPxiFXNU66FJZuuXGqIsiSz2ybXPO2ltifmVotZEhl2E2M1vNd5aIxuYuj0QglwSqo66tOe6fgPSqJWtKhod5hbgreV3s30jqp19qhvQQJ+EPGIBvuFlv3Dr5V50umMoEdgmqKLfo0UwsaK586F9fRWFLCSS4wPUKqDGLrKmi/j0nwbBaRoZhJMGFA0h42bj4NuMjkXqxTipVlPktKSdaRlLcy9yKDV7Y6V70sVzmhPCvWyynb73gn8T5pEyQiBAM0hTzq9lXPej6HhwsN1OAPyN0a31COH/fzDHCFCAxRc/kUoX3EHjZq2Y4rElxZLt7MktL96SQ7oMUA+oJbwWDJla5q5IwQrGpyhIDz0WAajiSE/RUYGc97KwiT59EXO8O6fn0T7c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ao1FukzvouRnvDTvN6j6fPY2f42eYmdOjO42LedPo8YovtxbT2FryWddoddX?=
 =?us-ascii?Q?aS8yKOAsDvZAHONkTRGqoZciEgoKsJ549O9B4CzjcP6eEzNARm+wupQxzQsx?=
 =?us-ascii?Q?rEfemoT4TPY7OWtnywIqwsznF7sUqya66y9unlWfNgGpqYsJbFUqne97aAgS?=
 =?us-ascii?Q?r4zNW+P033ISrFeqbeE0u2yM8VymyGdBxUp03EM7sc3epYC1xHc/pRW8YmxH?=
 =?us-ascii?Q?rVclNlSH8wJlas5+7RKsUxQd1Ja38RU1nuwUrx/FPuv6Ry86U1VKrkPQZJcq?=
 =?us-ascii?Q?wU6q14+F8FMHUz1GBpzJQHI+LFRwjesPOBTgyylOjbf03Kza1sTRxlaLUEMb?=
 =?us-ascii?Q?95YB9iAa7xzF1V6utHncC/VTj4kMpkdyTJ5FLVP7bWMOeQHB2PXoNPJY0UnO?=
 =?us-ascii?Q?GjbdGTpHC9lNFX38+TaJ81R2UoKwVsQEqFUl1wL1sg4BdFdefAXS3TWFav6J?=
 =?us-ascii?Q?ZUWnwBo6DmaYFLIg/XHh8HrSRZAZnPdo1PQpLrCpx2eqPPuFoRGri2Ch+2mk?=
 =?us-ascii?Q?GAQhFLTbATQ77vI2LeLI6PuC3QfBpwPCzM154eiAleVpPS6VwVey17EHGkeE?=
 =?us-ascii?Q?5MO4hChw2ybVvBTsZYIaERusxxhVJQOJCQB1X0RiSTAq+1/uhIj9C8TBOvYb?=
 =?us-ascii?Q?IcFw5SjghFGzGHG9dMYUJGprx5r03n6SUemT5pBYQSLHRSEDq6l9UDflMYPN?=
 =?us-ascii?Q?DXI7zlr1+QNTpkw7lvr5ckmVNrl5Q9LVDBxwbjyde+JqLFuMgTIeGpAZImIi?=
 =?us-ascii?Q?ws3gMuZg1a8WPMP8mtcGoxcgyNwILW7HQudTKUiFyk2ElMMGsscDCBMjS0oe?=
 =?us-ascii?Q?QoTOh8Xvg8iBv0lJv5zu1iqbXgg3S0IK+Ua+Fr2U0IT0xbeuP7YAhH0Eu9Pn?=
 =?us-ascii?Q?g0AmvLIZQB2C8nTUqGP2A01ym/b9brwXgkRxS609XuEi+wf/jewmfti6MK7k?=
 =?us-ascii?Q?Yzr/tL2K6cAATF645BgSZdBri+cJacO30KEGdISdmoSwfhtaSOq/WdeDJt16?=
 =?us-ascii?Q?B6++bCNcfsNdyT0hAivQPPtqtEykzvMUot6dMhBPGud3NbvwNoHLfYtkLHnz?=
 =?us-ascii?Q?d4eIFDb4xRFKeX/f5vmMrdNsctLQPYVmGiPmDOK8xMbRc3ZhJpvb/BqPE2wt?=
 =?us-ascii?Q?XIr4FRkdPt0SAgSeHyQdmdeOsWWbauKLGjvg6kWbCP1seVKPQIeVyvQg48t4?=
 =?us-ascii?Q?J62YMfni//2B5R2EmmFX2x4yytJ/8VtLIXVRgyK+Z0K1CLOqtk4u3XYK+Yic?=
 =?us-ascii?Q?VaNWEV+VfPP6xFQ2Z5HixgczrDwOrl499hufjgvgMId4jYStjW2LbP1ePosO?=
 =?us-ascii?Q?SQPg35G+AXc0BdtY5JtjkSQK8KgRAyggezG7b09j2LhwcSZAAX9Pr3RHh+lK?=
 =?us-ascii?Q?SVv5d8XvD0k4ElX3nAQUplctEMrv9Rp6ttmwoBaHKoa/HVbsOB9U12aTn7kQ?=
 =?us-ascii?Q?SWqo2RJdVd9+cZ+nVBp+AU+htazkPUClFZwRoBZaqFBq4CfFu49HDQW9omhD?=
 =?us-ascii?Q?aLLrLb0+c/9XSCOlSg79nxdWlXToqI9wE789WlxOMuWmhceIbGWydjF/D38u?=
 =?us-ascii?Q?ZRP1T10UUdgFjZwMaQCXavdPhoqt1c9zuxFAnh8+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8c28f2-8071-4fa0-a1fd-08dc5f80fb8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 08:24:35.9901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yYTIN9nhgMu/tWcByFTE0MilCCajnM4/vu4Jn8/ROqNHLZuLIk8M6A3GpzOG0uVJ03ejseb744SKrjHNnX/kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Thursday, April 18, 2024 2:38 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>; Francesco Dolcini
> <francesco.dolcini@toradex.com>
> Subject: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for clien=
t
> mode
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Thu, Apr 18, 2024 at 02:06:25PM +0800, David Lin wrote:
> > Add host based MLME to enable WPA3 functionalities in client mode.
> > This feature required a firmware with the corresponding V2 Key API
> > support. The feature (WPA3) is currently enabled and verified only on
> > IW416. Also, verified no regression with change when host MLME is
> > disabled.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> ...
>=20
> > diff --git a/drivers/net/wireless/marvell/mwifiex/util.c
> > b/drivers/net/wireless/marvell/mwifiex/util.c
> > index 745b1d925b21..3817c08a1507 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/util.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> > @@ -417,6 +456,47 @@ mwifiex_process_mgmt_packet(struct
> > mwifiex_private *priv,
>=20
> ...
>=20
> > +                             mwifiex_dbg
> > +                             (priv->adapter, MSG,
> > +                              "assoc: receive disassoc from %pM\n",
> > +                              ieee_hdr->addr3);
>=20
> The way you indented this does not seems kernel coding style compliant ..=
.
> however checkpatch does not complain ... so maybe I am just wrong.
>=20
> In case you need to send a new version, please keep the open parenthesis
> together with the function name
>=20
>                                 mwifiex_dbg(priv->adapter, MSG,
>                                             "assoc: receive disassoc
> from %pM\n",
>                                             ieee_hdr->addr3);
>=20
> (yes, it's 81 column - and it's fine).
>=20
> Again, IMHO, do not send a v11 just for this trivial change.
>=20
> Francesco
>

Because checkpatch.pl doesn't complain about this kind of coding, I use thi=
s way to let code less and equal 80.
I will correct it if new version of code is needed.

David
=20


