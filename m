Return-Path: <linux-kernel+bounces-112660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C844D887CAA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5889A281706
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEB917BBF;
	Sun, 24 Mar 2024 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rMoadpUU"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B822179B5;
	Sun, 24 Mar 2024 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711282527; cv=fail; b=cgZG+VNRVrCE4h8R23ECosmvAoNHe76WYmq8J5JJYg3cKkCP3myv6xOG7hSoGuiFVoGpzWNjRftYF91I/BIWtkD39Ood5cmAAwYo940BfaYg+31S/rhLJt2/12q+wSwOIcqfekeE41yz2k9HahiCo8ng/OkHvrNwKGYojoWo3nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711282527; c=relaxed/simple;
	bh=9y4MKyOkXabVSwRULticS+16nXCTBmBn/2+tSg5nu7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GAjPMEA7rIJcnNHZesK5lzlZb3WR1rznvoBEHa43yXj7LfhPjU+dgBfiDqWaAp1JG87KRrTEX0f9WyZN0E6g4ov0Vt98cKM7Bx6+6JWrw/eNLgyi6PG0SIpoOlpeYum3fr9Rkq5DYUAIgE3IAhg7XQdw6GwA6uQJqsWRShHBD5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rMoadpUU; arc=fail smtp.client-ip=40.107.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnql1mTm90m91GvGq+ea0LxHRDiO7Mg4lGjq8Dn4VzFiSzoDQLVXws0Kj8Uc40PW8VvYgR1kiWJNnxecGFiVtnkaiWCGGzQnH9RIfUE0fcidQtye9H0zl0ZK42pv+dftioCuIAQyPWxampJPJmmEtufUp92ADOZbzGK3FXJAYC8pGi3k7npwemHLAyU1gikw3AsDfqd4BxDbd8MBq8xithObIj0uD+Y9s0BgMaTFb8RpKjUBhHbl5tbbnG67McHJf9FMuZF+9dgGW4q1Fanuqhbyo6OJea5OmioGHnYLR95DgFaq6SgDc/4lydFd7xE1FeankCINw7me0d3LLkmx5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1n9Kq2FXCZjzqG79reIgs+4L9ckh3UcX+hw/M71dlBw=;
 b=TcKmF1XudaWdzRVEFHr1JPqaF4cy0WniX8/QShX2P9d3ypdm/jStB/UFx5/jvy0mxIAUt+tkov0ooRko1KQKsDVxH10mHiZljvZSj+//L0wQQ7fSVwvo72JFRxtCexTfb8YWBuCHLG8P92h54SauT8lipeSOsFG2Tu7To4xlhq/mPAfrHTJy833nFv5DZRl/5LyzIeoL31h49lRJNls827PF0cL1gbWgl6zRqFZ8p64QurZNEee4RR63vXJ6aSo8Tk55qrgFYA1y+O5mXDC7yd10xKWnyb263+lvXlr6fnoffpuf5zQFO/QueQQnWhmjZsEM9qCKhyHJDdkX1oH3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n9Kq2FXCZjzqG79reIgs+4L9ckh3UcX+hw/M71dlBw=;
 b=rMoadpUUlMt3crv9BzNy1zG7qXjdJUXzu61giZs5MdzOf2psNI0neT/V48nyHVfIjZrZbEb6MM7KcgvZBMV9Oi89U10/pyELBfyllRR4DxKWeCjsRwEtwOOJNACIdi9ACowi2mrMjdXAwvu7zjZV686h6b8mxNMriE8+wBLn4TM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8768.eurprd04.prod.outlook.com (2603:10a6:102:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Sun, 24 Mar
 2024 12:15:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 24 Mar 2024
 12:15:20 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Linus
 Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: RE: [PATCH v5 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v5 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHadhNakUhFqeH4Wkuoe629JrLZ/LFCUROAgARzdICAABkE8A==
Date: Sun, 24 Mar 2024 12:15:19 +0000
Message-ID:
 <DU0PR04MB941796214807CFF880E1A31F88372@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
 <20240314-pinctrl-scmi-v5-3-b19576e557f2@nxp.com>
 <7a4a8287-1f86-4ac4-acdf-c02339ba5e1e@moroto.mountain>
 <b06ab1e3-c00a-444c-908f-0ac8ad4d95fc@moroto.mountain>
In-Reply-To: <b06ab1e3-c00a-444c-908f-0ac8ad4d95fc@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8768:EE_
x-ms-office365-filtering-correlation-id: fc82d10e-6683-455f-ff79-08dc4bfc12e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 01C9BITaffJoCpLuN5arEjQjJbj6EZuoTweFPxgDMzToav7K2cS6JbuJxy3YMoBpPA714tjP2Q4XxCqQ/H3IgOncuPbQj7igTo/vn2Qb1O2YRxoID5wL6QqJLqUqMQTdOnErpIm7QtqQMFUcN3EEv6OY1Gi9aobWHSNsHeEeXcVEOgyyMFMy/GB2H0ASNDbnVfEXTx/KFs6zYZSC7fuLe34WAfzQil9BNvu9WhW8uvQ49haxRdRj6xBGztBADUKZ7kGMH8eHu63v1dzix7cneMpC1JQIfdv1rQdFkskVPQAooyJUBJGdu2Bnw/4qQMgMN90uneW7d3Em4nY6TmVSsKYLa1wObwW424qIn/0o3TVCmAbdSNpU048yf1zTCjo52pgehzto8746T/OLFM5THIaKr9dS5tBaWZB2mugKySRaJbgUJHzH6CRQOBxXIolDVXJ9hrz1PMQdXP/xQkHqwY/4eT6Zj4DOENWcYIi27ICITfhavr3wTuZEZllt3aqrCc/KZM97XDxUyyMVeGbyog8qoDR108VIgOKNz6qBlh6rKx2yJ88IsXzv5O6osiCaiIPuqJw7Cs40An32sqkHuTNuC3ro77ISYmRJWuBjWlAP6HpUKzTr5Vbk/4jQkSnAZuV4FcLdmSXiPkdniOWVIsLzelUL6jdjIXuF2OB3JHNVwcIsMa1bmkt3R7XQjmfAIeoiO+ty4FVQhpqR4LhO24En+zKVD8NGP//mBqF8kYM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?R75uXC/ocBOA72J7QxcvfYY/Ks9EtGvjtujk5MUAc9cw0cdswrtfM3m2NiqO?=
 =?us-ascii?Q?qdFsqHt7+8p5Ca7squ3ng8OlQ3rirVrw3UbZf7sVYTix5XrFDjcHYCgZGeby?=
 =?us-ascii?Q?0king5r1dZ4DfrtSXek+CvO0TopVpvUdsVzQ7g4J0Hr2P5nUkIDbwMqvYTvT?=
 =?us-ascii?Q?Iw+B7Q+NqAOqJAIFyh/JL8zaJm8Di1Nz6PZWGyar+jpPdoCQ010OXKheis2U?=
 =?us-ascii?Q?QTAS8UWPfAgkYoEq99X8R+gqT6VogaPKjDMgQMFS5bI2lllsyObiIFISULp9?=
 =?us-ascii?Q?xAuxDujLAwolNByJUvgRP8rpNwajXUP3yYY5Laif0f0sR/72Fx2Ok7bImRz8?=
 =?us-ascii?Q?/2y8ywC2gMq/sqfUAGILuPUgLkvVS41sRUNSDASwVHQoRy6KPC1CPZKutQY7?=
 =?us-ascii?Q?GKz0CfXQp/APJEssQAZLwIyJpEleUmBah7iwHM0EPReI2OkLKKbaT3qiKNXh?=
 =?us-ascii?Q?6IHBGn8bqo+cUBBZ6hKCopc4N0k0F1A24G9it0WYeZ9nMdLWygS0cgxoVIPL?=
 =?us-ascii?Q?qUr5xbUksTclSPrcvwTfVnm66tfnmaTSiIfzlCmXU4o0BhGSEWiYx9Meg1rH?=
 =?us-ascii?Q?+H9USBRzdbNrvaWw1q9pd3NImV2n07BE8oL3bD0Ge6BYMM6atbRZV1amVqwW?=
 =?us-ascii?Q?XRV+kaPAntdhCqBrsHGnp2Y1al7td7pnQFYA3acubw0KlnMHr47R4XhGlL0/?=
 =?us-ascii?Q?krXnL7tLZESmLdwPUlD2fZsyOJ7C/JArjk4lsjAjrcTfpLDeyg6oqXn04kqX?=
 =?us-ascii?Q?SaawY5QNgOKf2RDLklucOv2GsdGebZUmO28a5Xmb9HH5t4YRXcFE32dYGRrX?=
 =?us-ascii?Q?BYJuGzmADfqSlu7ScwztHDUxZBrCCAAQBh8w1lvMz2wgrQK3ERoKljDZ6J8M?=
 =?us-ascii?Q?hDjkHrC1ROuIu6pnweXIjHnVguSoL9gQxwDn6L7NbCaQGAnqku30KhIlOKws?=
 =?us-ascii?Q?zARshmlCXmp7M9in6lNra7EoKIHt3epqOPS/jhnGXFwPBZWkQb0oPNaKWP43?=
 =?us-ascii?Q?eTLCAY/yHwelhZWvpvlpqsnZON1tJYSHJP2S6L2wo3l/wVyZnJhd9fiAGa85?=
 =?us-ascii?Q?PyaJeqMxXbMoRZ3Y9PRVKI7HyC4lr3NyfZQvuehLkjgcC2WneOfKeIowva+p?=
 =?us-ascii?Q?RXB+s+TgQlEhxw4OdgQhZScpsoEou82g6Bbhdh5+v4JUk/NkQVoWvBME3VWi?=
 =?us-ascii?Q?FHgD6CnkcvB1n0h2ucZnSmDd07Drov9RhkBPH69bWbCMKzlYKyfMp40VGv8M?=
 =?us-ascii?Q?8vNNehqrlJfSZBylLUgmKL8cElDwNKiDFlcVTz/2alPyiYsBatu5o33NprbY?=
 =?us-ascii?Q?SI0FZiLOSV/Tpxz4jTtBaSqiRiJuSaS7MjrhklzcHICVgePGjMHziP8Kf482?=
 =?us-ascii?Q?Z7L9b6+oDD0wXzWWFT/mOktTj/i6gB0W8PhQyreCgIuJf0L4Z3zcsciUnkWz?=
 =?us-ascii?Q?c5FyZGSPWLLVz4hZ847vxVqvPJCsMsprv0qz7W1sxPuKlsRHagyLYlFRMLL1?=
 =?us-ascii?Q?uw/To46nTQLQSJVLVN8B2rJQnnQGjUtNuLZpo8ZqcLk7zZqtWwlof4efJtOR?=
 =?us-ascii?Q?RIyusZ2Sn7hglTaBGdw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc82d10e-6683-455f-ff79-08dc4bfc12e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2024 12:15:20.0225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +N3TL8ellVsYTzOOA9CKoGQVl4YPgx9spoabcCpYMjcFUVtcr7KpqkhVEnfneDOEC7eTQacW9iJOAGnrmFJGTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8768

Hi Dan,

> Subject: Re: [PATCH v5 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
> protocol basic support
>=20
> On Thu, Mar 21, 2024 at 05:46:53PM +0300, Dan Carpenter wrote:
> > On Thu, Mar 14, 2024 at 09:35:20PM +0800, Peng Fan (OSS) wrote:
> > > +enum scmi_pinctrl_protocol_cmd {
> > > +	PINCTRL_ATTRIBUTES =3D 0x3,
> > > +	PINCTRL_LIST_ASSOCIATIONS =3D 0x4,
> > > +	PINCTRL_CONFIG_GET =3D 0x5,
> > > +	PINCTRL_CONFIG_SET =3D 0x6,
> > > +	PINCTRL_FUNCTION_SELECT =3D 0x7,
> >
> > PINCTRL_FUNCTION_SELECT was removed from the spec so the other cmds
> > were renumbered.  I'm still going through and reviewing this file.
> > I'll hopefully be done tomorrow.
> >
>=20
> I think the rest is okay.  It's just updating to the new version of the s=
pec.
> CONFIG_GET/SET need to be updated and FUNCTION_SELECT gets deleted.

V6 has this updated. Thanks for helping reviewing this patchset.

Thanks,
Peng.

>=20
> regards,
> dan carpenter


