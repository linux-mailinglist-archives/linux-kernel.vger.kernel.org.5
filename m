Return-Path: <linux-kernel+bounces-161796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0808B5163
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B778B1F222EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE4B1118C;
	Mon, 29 Apr 2024 06:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o/Kjek6v"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DC3DDB1;
	Mon, 29 Apr 2024 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371964; cv=fail; b=jn01BFJ/muhbL2AjoMDsr9rI7PzzvcujEk7i1hi1kYQH2KIANYFWsv+c30WR24bG689xmGx2ZTEGpWS4lQiQUqFrq7YGeSOJq4P5JBPgV0baJtDW3nEwNwRvQjNotPBlDUUmd9dUyN/VFibRT8sKiehhOY6oLYd6oKCEukrsdhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371964; c=relaxed/simple;
	bh=+Sj1fUuTwwSL0kAoItzClYOWICUJq/2q8/VKHQUb9AM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EClbRi+yxK8Si1/Lg4yFwthQTEUTrXkb2rpyCQ6J+MJ9sIh446VzFmR7skmnvkbnglrExMR1x+fBVySfBmfhy8SG2o5j/vKlvbFrX0k66Zi9+DlCprJW5qXS20PRDQ35ZCKpjWxJYQw6PD8tVKgDGGLKW+xZC+Xt4DlOtNsWrfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=o/Kjek6v; arc=fail smtp.client-ip=40.107.7.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc9IeOzPmEdil9QtJpqASuROe2Dxe/Yyi9df3bOx2kIr1nuwRU0pa9b7NOOmRvZY1ecbFMWlksgNa24SZk3bCr8e2Ux8W1idGLoZSkuR/VpBVJGo9NXe09WeJMUv5X8vMAGChJeBZ1NoGccQQ0ZmIm0BgSm5thxj6Jq6lKD2IfzbcC81NuulUkK6+IHa5Vff1XF8zUsxQmY3T6bDmzVUA2ELy48eOWsWywVfx/cdtLadf0HEih/t5PjEpGPBxqdS7jRJZn9xxjKZJrhix/7MAlofk/WE8qD65sA4s/feXbIpvOkxh2XM8HI6tH5HwpUaCqoMOXeXZo4nWkvpBseGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ld4TZHnfRE81yKZtQO/gJwEYQ+CVu77ZiunipcsG4uU=;
 b=Yr7kZr08eCe2TZsNJl3J41+1lSDz22pBKNuDvRzo5zB8ik0akx59V/rEx6GHt+E30dA1q9lbKxnFshu95v0VhURSKrmd7V50+wECTEQAd0npppQTriw+zO1bJ3bJzHxhTd7XTml3YMgKgUFEnBNnIJOwwM+89CYKRiu4slE7YP6OVDpVpSw2aHc1ROozQ1u1cKkNl9V2P7B1isPL7xNgEyfec6+bs53xBUUYBQhP5apM2BofKiKdFgYG8rliKIgMKOVg7/vhV2r4m7jMuzH+Vy0cQ/kG/QKBn1wmRSCCJnp6pTEK7N4LUCtUjodGbSrni9t1PM7tBu1F/hv72nIuLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld4TZHnfRE81yKZtQO/gJwEYQ+CVu77ZiunipcsG4uU=;
 b=o/Kjek6vPq+d5UY8TkiIBE71iy6uwLodunL9uhMC4ICi/p58GC0cUHJaDUjuj/YleeWglAGubqnUozLxxstUOnBz0eJPNddHWza6gLeUAHpLYuTOpEc4QGyJ2SGP/CUIvpVaZgllnP1Uw/rqCBTZh6QOiuiTWTDIKau3NOY3VBQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8891.eurprd04.prod.outlook.com (2603:10a6:20b:40a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:25:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:25:58 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Bough Chen
	<haibo.chen@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH v4] arm64: dts: imx8ulp: add caam jr
Thread-Topic: [PATCH v4] arm64: dts: imx8ulp: add caam jr
Thread-Index: AQHail9/rk3RFekv9UScQDV5SFo/57F+5fGAgAABZDA=
Date: Mon, 29 Apr 2024 06:25:58 +0000
Message-ID:
 <DU0PR04MB9417125D2C4EB2441142D22F881B2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240409092040.3870497-1-pankaj.gupta@nxp.com>
 <AM9PR04MB86045B81C1E9C3B660079546951B2@AM9PR04MB8604.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM9PR04MB86045B81C1E9C3B660079546951B2@AM9PR04MB8604.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8891:EE_
x-ms-office365-filtering-correlation-id: b4c987c2-2d98-409f-83e2-08dc68153b7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|921011|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+QlhSoK99hg70AwPKxTsYaSTO+GQOBLSC3URR/gdxBj+zHqjtAl/bqXU2E5D?=
 =?us-ascii?Q?UMKTp7Dw3eBvbmeucJcCIDqyVy2KoR/EpF7Fn2OihK2nOiVxCwvULqB1Lv5S?=
 =?us-ascii?Q?Nv9918cNt9Ke6ONVi+PK3jZSyZzaT3emqsyYwyycqDTxaLVhh5izh+M/AUaB?=
 =?us-ascii?Q?i8cS0e0MhsAA7Lc4tfzt8z6TJ/96MMmj+qd0CorW6CN7sacAuGCY76sHM/EE?=
 =?us-ascii?Q?+ckHKFD4dghf++09vdlLlSqU2Rd/1snL457XDh5LVuo35hSoZ5//ggCN5ODO?=
 =?us-ascii?Q?yyXUT2tTEsaFsAg7+ulymK//rN1ILK9mzzprEjfqV2RF6DUUHV1Tl2+NLpg5?=
 =?us-ascii?Q?vxD491eKkrMt+YJd/D/0V5qC/ooxW7ADnpKQqWk9ndqCcMMWnMq0yEONyNKw?=
 =?us-ascii?Q?AClznHuI5h6DlPuPPjonMv1JatwGMBN1AWqX/fiSXtzihJdn7CeJAuhjGvhP?=
 =?us-ascii?Q?4FW/mvYGOrypL4jq5U6ON9DtL7lUYzRtW8+h28/kiZw74NWJZmdHIdce5dT6?=
 =?us-ascii?Q?cQiNnJe10xyXEQw/lIjMDgi1/MGQPi/o3bmPG1ZfUd72BEripEIMK7s5zMoh?=
 =?us-ascii?Q?yy8YoQWkqfb3c/54mDejQxrMfThuUYKPBTVymTY0tCGxgzB11OfUsXWFACMY?=
 =?us-ascii?Q?zyn+c69POMppYRJkKSa8PJ8WxmrWJdDnawLtkLmFRFi3ILnaX3yVwg1bMMSV?=
 =?us-ascii?Q?y5tOY7lKjP7ZIISA4bOoiOCiHoaEeVpuQY8VOy4deliDnDRS0CGkc4qItHl4?=
 =?us-ascii?Q?7WaSGFphGdCV1kqzFnKYd84OtbK/FdF7WUzQji9TEYu+W4FtoBLbGMk/S1pn?=
 =?us-ascii?Q?hCoG2SlMYTYNrC4f5q5XrxR/UdXyxTdSi5lERyYkqmO9dvrJznlpyYKLB2Ss?=
 =?us-ascii?Q?arYu4hcZEZbaAKPMweSZj6sdQ/TMuuH2e0BjgnUzaZ+d224EpubUJYXhO1PF?=
 =?us-ascii?Q?F+fSLG8RecqaFoY2Jb5rAXAfOHfpQfwHSCrAaUZ0vEmRxOjVGS06jWHcbH20?=
 =?us-ascii?Q?u8JcFs4wz/zlZxUzfjCEM4+ntSmlELB4QoTryjs0TxzLN6Q677VUvYX4RKv6?=
 =?us-ascii?Q?LN/lfjh5BNd80VYo7nN62a5gAtvyVELf+J03r9tYElD0EEWsY3mMI5//CYRn?=
 =?us-ascii?Q?gMsNmJlC3yNJq8z6SS0UomA01bDhEuwjiscHdwfXlx7ogWyjZwYupU7mvjfw?=
 =?us-ascii?Q?BN6xYK1f4PdBOfu1Z2PRif8wm6vhvbk0s0UXADdSyMrlmJUxICmZKUk7vI8t?=
 =?us-ascii?Q?keiSpOajTQlDQBuwMElRZeM3rWWFJ4K/JgY7yACI99wL/WZPnz4JiKJw8XdO?=
 =?us-ascii?Q?buzO9lOe2jVGYYP2MUIGjnrzb27O19yFW5g+ibClCAg7AgVCzp0LBh6FmK+h?=
 =?us-ascii?Q?PCETHQQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3HgSl+I3gLB8ECnt7cPczEgbxo3VdqYQwNcIZm4ohxs3sPa9wFiCV9ECoHC9?=
 =?us-ascii?Q?9msQm8e6Y6etqkiK0XuumO8LEZB+YsgZ1nZ+Hegd5Tm9sqx2gFxui9DKpB4w?=
 =?us-ascii?Q?ZI+dWpPF/lRL/5JtisT8JpwuBCUHa8GK9u7zb6Ehtj0/ZjY4pIMRAnCp8dQM?=
 =?us-ascii?Q?obIr/iWF/VeVVSNcid4wbRZFBhv9IUDHdrje8Wp+8uG5RcW7thk2Geq6w7Z4?=
 =?us-ascii?Q?x/LMzCnhZCusLYhciUwIKsMm1zXNOohj3tgmagZrv+XK3/AYBcKF7wK7uxC7?=
 =?us-ascii?Q?zctqHaBt24O8AZ4Dk5vRpKGBNe8cakFBXg/DlMwmqBUoDO7symZqLUv3H8CB?=
 =?us-ascii?Q?fA8oVrEvslCjKcODMwRiEDOw8jRs3fB/EXtY0b9d5+m5lPZGezgMj9LSXqbS?=
 =?us-ascii?Q?uDj1Dm8AL1mCX0t6KWUXnUEorQMtSU5LE9yPLi3136k+mLIBgSRb7BU8cgWB?=
 =?us-ascii?Q?+TnMgiK/S2qaLzAINKnh3P4T8Lla0vsYS9FutExyQeHDH6WceL8ng9eSXika?=
 =?us-ascii?Q?PYUeUtFfsJkkGA4rx1HP456XlelpE0oDAV9XXyjqDerK4uK0Tc2/JkzGYomi?=
 =?us-ascii?Q?YEoDb5HD50wobTagNUQbKD7o5sw9gpGjKU3fEFUjJVd7UEmlnKF18RzTXwa/?=
 =?us-ascii?Q?bKhhgEe/quC76J/eYkELSal4Mias5wtv46YqudNpB4E3XbKwRi1g9QCFeQOG?=
 =?us-ascii?Q?O1xY/BFhg5VPQR/LnGqs0rSIPKePmYRUButd5GR0H24oXMVM4UNHlYdn+Jqr?=
 =?us-ascii?Q?xO5ruqE4QRvdBZFWBt4rnbXUOr6GQXO+RX65qeUX7SFi7zzpA3zskns86q1v?=
 =?us-ascii?Q?8T+gWukjwjxStZo8TqABkxVRwZ/2bHwh8qJPNRTGnrAvFCq2mwqMLygE8Rdm?=
 =?us-ascii?Q?pjdNwlN3lwfHCFEkHK/bpkZ68Se14eYZ8mK0v/Nc+Sa0e9+7U3gy3uW1t2PN?=
 =?us-ascii?Q?pHMNtSjfQ4StOvsBfOu392beXiOSRkr02x3zj/PcOeJhtz2HEtDNl5dewFO9?=
 =?us-ascii?Q?ouoze5qqI5NluUSag3VSDHh72LPZX09E2DThLGb+yC10kbenI/7O2SS/xIAZ?=
 =?us-ascii?Q?JpfhhG0IpyLcAWQiRdw3Te+qBM/KjFEvHxkO7r1iDzc1d4SpIQMaLb0uEGTx?=
 =?us-ascii?Q?D/OO90v8mDb/hZzUFlibUz/b3R0UCTQvESVG6QMH56jt+2Y17Z7qO9JytknE?=
 =?us-ascii?Q?HSSmG99CpftJen4+o3RBjB7nVohPgjgHqWBcXHY2VyR4FMcTE9FORib+Yv+k?=
 =?us-ascii?Q?6ShuheYIJZOkO0s7Lb7/8Pfklr5y4a0DMPTyRsY8SR+TVqjTrgyS6d6e/70W?=
 =?us-ascii?Q?Bch5lXbPeUvrPy/JNNmUdRdOy/fwEIA8Tcd3f2wsIAZF8XsUoShB0uvGonIA?=
 =?us-ascii?Q?31HAtk+4SyOzU1zXpRY8gfkM3MnMTIBoeO/ozjtAB70OlUhJlSMzZkYZJ1m+?=
 =?us-ascii?Q?n9inaKGTNIReeKSDz6vXMcARZWWmYZ2JVt1OYES7pVFjrnPsest9hT/lEQ+n?=
 =?us-ascii?Q?JIs7p4BY+PbdBRRQYcb/kIskpQ64I6xzRq8CT0oYHHPxOyoxHRtI8gOqqlBK?=
 =?us-ascii?Q?tCxZRMlB4TmDaJlUZvA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c987c2-2d98-409f-83e2-08dc68153b7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 06:25:58.1326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0MiVfxco9CzzvoEXv3ZdxhamrJhUekcfnd4dLv3zJ8caOXBgjbeFnz6cy8ZIGQUIooA4Pp52wbK2173rl4LhcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8891

> Subject: RE: [PATCH v4] arm64: dts: imx8ulp: add caam jr
>=20
> If there are no further comments.
> Please merge this patch.

Shawn has picked it up one week ago.

Regards,
Peng.
>=20
> Regards
> Pankaj
>=20
> > -----Original Message-----
> > From: Pankaj Gupta
> > Sent: Tuesday, April 9, 2024 2:53 PM
> > To: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> > imx@nxp.com>; Peng Fan <peng.fan@nxp.com>; Jacky Bai
> > <ping.bai@nxp.com>; Bough Chen <haibo.chen@nxp.com>;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux- kernel@vger.kernel.org
> > Cc: Pankaj Gupta <pankaj.gupta@nxp.com>; Varun Sethi
> <V.Sethi@nxp.com>
> > Subject: [PATCH v4] arm64: dts: imx8ulp: add caam jr
> >
> > Add crypto node in device tree for:
> > - CAAM job-ring
> >
> > Signed-off-by: Varun Sethi <v.sethi@nxp.com>
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >
> > v4:
> >  - Order of node properties changed.
> >
> > v3:
> >  - Commit message title is changed from "imx8ulp-evk" to "imx8ulp".
> >
> > v2:
> >  - As requested, this patch is separated from the larger patch-set of 9
> >    patches.
> >
> > Commit
> >  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 32
> > ++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > index 8a6596d5a581..ed86854a59c3 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > @@ -252,6 +252,38 @@ pcc3: clock-controller@292d0000 {
> >  				#reset-cells =3D <1>;
> >  			};
> >
> > +			crypto: crypto@292e0000 {
> > +				compatible =3D "fsl,sec-v4.0";
> > +				reg =3D <0x292e0000 0x10000>;
> > +				ranges =3D <0 0x292e0000 0x10000>;
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <1>;
> > +
> > +				sec_jr0: jr@1000 {
> > +					compatible =3D "fsl,sec-v4.0-job-ring";
> > +					reg =3D <0x1000 0x1000>;
> > +					interrupts =3D <GIC_SPI 82
> > IRQ_TYPE_LEVEL_HIGH>;
> > +				};
> > +
> > +				sec_jr1: jr@2000 {
> > +					compatible =3D "fsl,sec-v4.0-job-ring";
> > +					reg =3D <0x2000 0x1000>;
> > +					interrupts =3D <GIC_SPI 82
> > IRQ_TYPE_LEVEL_HIGH>;
> > +				};
> > +
> > +				sec_jr2: jr@3000 {
> > +					compatible =3D "fsl,sec-v4.0-job-ring";
> > +					reg =3D <0x3000 0x1000>;
> > +					interrupts =3D <GIC_SPI 82
> > IRQ_TYPE_LEVEL_HIGH>;
> > +				};
> > +
> > +				sec_jr3: jr@4000 {
> > +					compatible =3D "fsl,sec-v4.0-job-ring";
> > +					reg =3D <0x4000 0x1000>;
> > +					interrupts =3D <GIC_SPI 82
> > IRQ_TYPE_LEVEL_HIGH>;
> > +				};
> > +			};
> > +
> >  			tpm5: tpm@29340000 {
> >  				compatible =3D "fsl,imx8ulp-tpm",
> "fsl,imx7ulp- tpm";
> >  				reg =3D <0x29340000 0x1000>;
> > --
> > 2.34.1


