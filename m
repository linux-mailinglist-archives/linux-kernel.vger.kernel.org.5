Return-Path: <linux-kernel+bounces-105614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E3D87E196
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A41B1F214BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E4518049;
	Mon, 18 Mar 2024 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o57j2zJT"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1671DFD1;
	Mon, 18 Mar 2024 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710724936; cv=fail; b=a4vK7BXy7Av+LxuXya24a0m8dCBqJL/vme5GSxZ3uySAddU+kKvz6PYopfgpa7lwEMzCbM8rx37B1qt0vLuJeZwCqDRHkIhMkCA60AA+s2SzTNXAVhU3qRQjJmgYog2pGyJnNpdhgAetV95cQQhzzp/ANqlF69a5UTZX1U0qHPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710724936; c=relaxed/simple;
	bh=MiqFQD9YaF6MftIN84RukfbjPjX5x6oTPcO/u90DdS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nvRCqJ24SgEBWOgtjI4GW79x0kc7y1Jk317cTicEYwEq8Tadr6Jbufqfr/WsRaNioi5fL31G1/nT5yUqBW2AXaJKBaYq1U1HaryAgic/nuvGP3RrrVP2Y3QmwURcg/kCREN0oi0m9LpytKQWPHUZN01z9YNACbrheeq1IiEyJmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=o57j2zJT; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlkqgQYHI8oaMcFBvfL8VLfr5WGNSGBe6zN2ddBaTjlSEES+sa4QZsVaXiiX4fcueTREapu4WU3EWToeO/hWTs6e9fGZpEqx+Cov2+RJOcin5cef7VYRSPd5pvgOz7U0wKm/pbdbdB22CTIhWlZz/62AltV9bfsGd9dyEwBQQYfxdzhExxi51A0avsyx/2ciVY7pF+twcYVPJ432U1jzkg/IoTfUIzTH5YiabhgCXs2pwPOe8Nol5R65v4WBxDLtNx6T2ph2kwmyFlwZuo0r5gopn0hI97Ksw9mpUc8fMwD3dLJ8iIYEqe2yyU9jzm9r0243/p77sZ8rkmxYU7t/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBVIJoeDxKigAcquaSQ6g2RS8zL5letiAMZSE1tKesc=;
 b=UGoeEqEnUUHXccruBJ/35IYvNqA36lqr3D545VD/GTYH5kHGRnEsduVhM66zHx7ZZclrX91fH7sn1IltskS/zItZrN3pAAo/5Jw03aaDYYkuHt588hEXOWmqqpBee1P6VI6T7PqQyzfeofl6zSTHZkCmAEHiiQIWkbKanmtjUXGDYjEsIH85FRIyP00da4so5PCOYpLUXCyvWisO3ddDmLmq1C1fGTvEJlUMNjehxlEqLRG4+Y9NIV4om5C6kDIpfMsR5c0o33fB+/8a0O6d16xf9P6/98Jz3eiCxLzRN4wCHmAvkTXPZd+8MtkvOEbklfvSS1gese+BUPOKV24qCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBVIJoeDxKigAcquaSQ6g2RS8zL5letiAMZSE1tKesc=;
 b=o57j2zJTLEBK88vBTXCzNpXPEf9akvP4Q/N6KkeeRSQQVsSsCwUZg2eOmRADAzZWja3cIoON7hLPo2Rx7iCXqbx0piJJEcay9/T2QIWR4rDKsqIVbydMmoAS4o85RSst/ksS6jWtQaRdrsfi8O2bTnmlvNwUnq3PK+2gNNvQXjg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9889.eurprd04.prod.outlook.com (2603:10a6:10:4ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 01:22:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Mon, 18 Mar 2024
 01:22:07 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 0/6] Add support i.MX95 BLK CTL module clock features
Thread-Topic: [PATCH v4 0/6] Add support i.MX95 BLK CTL module clock features
Thread-Index: AQHadhHzV0Q2ZMhJLUKmpuh6Q87XB7E8G/aAgACbUAA=
Date: Mon, 18 Mar 2024 01:22:07 +0000
Message-ID:
 <DU0PR04MB941725052D5E3EF78F67A1C5882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
 <20240317155911.pdc32nsyxcdhs2t7@pengutronix.de>
In-Reply-To: <20240317155911.pdc32nsyxcdhs2t7@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB9889:EE_
x-ms-office365-filtering-correlation-id: 83959682-e8fb-496a-afa8-08dc46e9d40d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XT5WvZoPv9/cdDbYwjcEW86rTvnUk+uFxcOMMbRcGPZhvE2peQTUDSOFnwcfD9iQoa9k8rpTjXdbj9JSLTvYfCSa+ZX4QZES7yzJWW/YPAPHj27T9obF+jJHA0dAC/qcSfCTerfBdt7ydOefZUdqyC4ofn6Gy9J7tAO+/fNB90ktjWu3fOiwjTnLVfdJRWU8h4oCvYlQpcfjMc3LIp3kiEOE9p9KvJGuY0N8nvYz6Uv2olUmZdlvXJZ6/3flJVur3a7j6YADOB4014PvTqPpT4R4uU+8DYQqQQ1vw1ad+aEP/yHG5ktACMECiY1y/ca45Jj2rYrHtgw1TfnrmQ7QbIcxK6LuC9aq7Qf/tq7EIiYv68i4jPgv411C4Y911WUBOfrZkrH8uI28AxNvSLboirCdqxSC1XTQtzHWsDYmy9BYLqz6VQgd8b532Ri2M17wZnlCwGgfxj7+4vgacMEBHit8aU+gRZMZLBsLPcN6JVqTNkYJxtePFrndxpXqAQLEjuWNQg3yBCwY+ipWXphXti+TGEryWvD4BwTahU/lvDNDGLlzmBvxlHnUFFFN0HGUaU6dWzW4cdttYne9l5BW8K5ZIwGS4NIVQkK7bMggXKDm0tvk4PEGIdMnCRpKQIS2GKzSizNHzKee7NVYgpPy1NM5xPq3neXIm9NSaARR9dknxAi9S+W+qAgvTGPVwbj0E2e52KiKqurqMlTYUc4WfQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?y/jVLWrgpDtn3IIy9+z3WNczfDC5zymNI/9jsK55bagjOn9dvDCZdW0JnUHq?=
 =?us-ascii?Q?cZlaeZSeiXcHyTDUp8PzzGaKKvGyChene2acQTVsCWVm8dUVpT9bT1s8y2dn?=
 =?us-ascii?Q?BtoLP6l8c3EbBZPQiirQ7T7kwHAmyg/uk2cpVHkwYEES7/UNLZ0AcD0RRnlv?=
 =?us-ascii?Q?xVmllR4Wz95WrwW1JKS0oc814S+18L5prfe516XBriQowqXlU11WkqZwyCVl?=
 =?us-ascii?Q?xjTLcLXNIITlN6vCPowRjZCmOSEZxP49a3xJCeRt33dV55bfIanIZ+orNB7r?=
 =?us-ascii?Q?TPppebbRl91dXQCbBnTAD0Fgl9sqw8y/iWbZ4TvYS8pS/nc5s/gczjdQRqLT?=
 =?us-ascii?Q?dfHTCBHo1LSBtbqDKUEzShRzjAzf2lIR3M8vqSaGxQIBVwsn1OTbuY/VDggu?=
 =?us-ascii?Q?DnkApFKZ/Ovn4KYAOzeUiZQBTiVqfN4dh1EdOBR0Ww4TBi8QWvfO5HDQLF2e?=
 =?us-ascii?Q?jLzJz38HRM7NW6P0Vkf9YxrYoFexExyhth9YKVdZOhJUwUWGGIxsMNfR74/9?=
 =?us-ascii?Q?LjR6BtxupIrjoh7I84XcDRcWht4JNsAyVDOF9wpVb7Qe5qYzTW4Z4txueJro?=
 =?us-ascii?Q?QhoJ3gu+YJR6j93S0rSPtr+vRBv2M9A02Q2EOXKCH0CsuHMbYC7UYrulrq99?=
 =?us-ascii?Q?Z0xbM1+miLKNorChfPCGYj8HM9h4caFU+caSX4exMAcgSxeLHIM1/lWd2DSn?=
 =?us-ascii?Q?kwg74bbMi308MLiNfs1jEje4KaX0dk0x0uXPRADxXIA2y+sAvPo2FBokU/vu?=
 =?us-ascii?Q?/m6/3C+/eCVmbFMtxbaT1QDRhwsIcHdAelsg6DsGW7aEFfaq7a0Di/83KNW5?=
 =?us-ascii?Q?YJwH5zIQ6Mz/BK0bMKBf/JUtGOtdAAwAe6AO8cpZv/gi31NzIl1+/y49B9mq?=
 =?us-ascii?Q?13BcZBpVd+H9FPKrd/vnRP4nYRJIQyBhfdaE1riPhVMWJuQTBa7j9s068IwD?=
 =?us-ascii?Q?zZphY76h6msYTBI8vNytqMxSuAlzMSaO1FbaTYS5jyQO7tsVMBvnbco14Hh0?=
 =?us-ascii?Q?cmNrbJL7OHekEz/4iWa6+1OYhfEnW+iBObXMq5SjGRrcd0w9HuxkmOM4r02P?=
 =?us-ascii?Q?dKlspHnz0cMct3PRRCmtgNwJ5O89rJerA67hlWNgvvIFmOHbldmrSc82Lxh5?=
 =?us-ascii?Q?FhkqJ0VuDP8THXARPdVihR3T8qNTgkd128ZvXXVaN6sCQSeQTCEwYqzszz56?=
 =?us-ascii?Q?Lwgc7XSpP8WsukobyzMaE7CEt0Pfmu+rJfYcWJo2M1yzp3Z/VPfaEaGrjLJY?=
 =?us-ascii?Q?whwniZzST9FcswZw/bqtRA7b+rANhPeuvmYE/KQhWchPeNm2DabRT/blvnVQ?=
 =?us-ascii?Q?7dQ4Kg9x/V8MtFnfyrSh48WkClypnlUQPgNwIt9gMl/k5tz7O301kX8ePA5a?=
 =?us-ascii?Q?koEpJx2+teF/kgdbEaAPjqNAzhAaPlOKCn7F2j177QyOAl88OJLhS2h6umLk?=
 =?us-ascii?Q?vAZ8+YqScPiAxuJEcTSjJi2C6uxqkmms7yGuj8OrnlQYOi4sHxoFU1/1xDCR?=
 =?us-ascii?Q?1+Jnh5uvNEWwTyhYsdvFyyjxAPRf1LQ4uEdcgpPtu6elPqZ+StBs+51GK3uY?=
 =?us-ascii?Q?IsTdFl/lWCchTuAHn8M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83959682-e8fb-496a-afa8-08dc46e9d40d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 01:22:07.8660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sn9+ix2sLK2OPA2NnxTFzJPrddQyW35A/gabEvYHooCz3A6UHMKxZNvtvlQJOme0jq+pXnPIL9nKwtlHjKetng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9889

Hi Marco,

> Subject: Re: [PATCH v4 0/6] Add support i.MX95 BLK CTL module clock
> features
>=20
> Hi Peng,
>=20
> thank for the patchset.
>=20
> On 24-03-14, Peng Fan (OSS) wrote:
> > i.MX95's several MIXes has BLK CTL module which could be used for clk
> > settings, QoS settings, Misc settings for a MIX. This patchset is to
> > add the clk feature support, including dt-bindings
>=20
> I have to ask since there is almost no public documentation available yet=
 The
> i.MX95 does have an system-controller for managing pinmux settings and
> power-domains, right?=20

Yes.=20

If this is the case, why not making use of it via the
> standard scmi_pm_domain.c driver?

The SCMI firmware not handle the BLK CTL stuff, but blk ctl stuff is
a mix of clk, qos, module specific things. It is not good for SCMI firmare
to handle it.

Regards,
Peng.

>=20
> Regards,
>   Marco
>=20
>=20
>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > Changes in v4:
> > - Separate binding doc for each modules, I still keep the syscon as
> > node name, because the module is not just for clock
> > - Pass dt-schema check
> > - Update node compatibles
> > - Link to v3:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fr%2F20240228-imx95-blk-ctl-v3-0-
> 40ceba01a211%40nxp.com&d
> >
> ata=3D05%7C02%7Cpeng.fan%40nxp.com%7Caad977d7e4f94c750de408dc469
> b3952%7C
> >
> 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63846287969085566
> 1%7CUnknow
> >
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLC
> >
> JXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DM%2B3lDY9BKvW0nHv4mtvi82RA
> 9IvYyz72TCbL
> > UpiYcG0%3D&reserved=3D0
> >
> > Changes in v3:
> > - Correct example node compatible string
> > - Pass "make ARCH=3Darm64 DT_CHECKER_FLAGS=3D-m -j32 dt_binding_check"
> > - Link to v2:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fr%2F20240228-imx95-blk-ctl-v2-0-
> ffb7eefb6dcd%40nxp.com&d
> >
> ata=3D05%7C02%7Cpeng.fan%40nxp.com%7Caad977d7e4f94c750de408dc469
> b3952%7C
> >
> 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63846287969086560
> 2%7CUnknow
> >
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLC
> >
> JXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D4leg49tKhwUMzvD5wlnvgVc7is%2
> FGMNvpYr6A
> > %2FAf3OU4%3D&reserved=3D0
> >
> > Changes in v2:
> > - Correct example node compatible string
> > - Link to v1:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fr%2F20240228-imx95-blk-ctl-v1-0-
> 9b5ae3c14d83%40nxp.com&d
> >
> ata=3D05%7C02%7Cpeng.fan%40nxp.com%7Caad977d7e4f94c750de408dc469
> b3952%7C
> >
> 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63846287969087217
> 2%7CUnknow
> >
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLC
> >
> JXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DUuD5MVPFgBqwftuXCIXB7SeGyu0
> NWPbwY%2Bvy
> > ChFLyVA%3D&reserved=3D0
> >
> > ---
> > Peng Fan (6):
> >       dt-bindindgs: clock: nxp: support i.MX95 VPU CSR module
> >       dt-bindindgs: clock: nxp: support i.MX95 Camera CSR module
> >       dt-bindindgs: clock: nxp: support i.MX95 Display Master CSR modul=
e
> >       dt-bindindgs: clock: nxp: support i.MX95 LVDS CSR module
> >       dt-bindindgs: clock: nxp: support i.MX95 Display CSR module
> >       clk: imx: add i.MX95 BLK CTL clk driver
> >
> >  .../bindings/clock/nxp,imx95-camera-csr.yaml       |  50 +++
> >  .../bindings/clock/nxp,imx95-display-csr.yaml      |  50 +++
> >  .../clock/nxp,imx95-display-master-csr.yaml        |  62 +++
> >  .../bindings/clock/nxp,imx95-lvds-csr.yaml         |  50 +++
> >  .../bindings/clock/nxp,imx95-vpu-csr.yaml          |  50 +++
> >  drivers/clk/imx/Kconfig                            |   7 +
> >  drivers/clk/imx/Makefile                           |   1 +
> >  drivers/clk/imx/clk-imx95-blk-ctl.c                | 438 +++++++++++++=
++++++++
> >  include/dt-bindings/clock/nxp,imx95-clock.h        |  32 ++
> >  9 files changed, 740 insertions(+)
> > ---
> > base-commit: c9c32620af65fee2b1ac8390fe1349b33f9d0888
> > change-id: 20240228-imx95-blk-ctl-9ef8c1fc4c22
> >
> > Best regards,
> > --
> > Peng Fan <peng.fan@nxp.com>
> >
> >
> >

