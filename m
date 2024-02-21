Return-Path: <linux-kernel+bounces-75340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC2C85E6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB1DB27251
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D3886628;
	Wed, 21 Feb 2024 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bksv.onmicrosoft.com header.i=@bksv.onmicrosoft.com header.b="D6iVD1Dx"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2137.outbound.protection.outlook.com [40.107.104.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7D21097B;
	Wed, 21 Feb 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542376; cv=fail; b=ZibtB9UL85Z2cKYj/DVs3KhL3pWzt9evJ/P4DRzpU1Ri4uZOhx7Ta7CjSTUPL5eivShcf73qIGli3+nzmlW2pofVNuGeCJZ1ZC+qvJZP5jloXHZ+sHpN3zUHXxSFd2Zrxgw3UzeE9scWtK+jZfCA2vj2qFTaOiyeW/PLX2EH8vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542376; c=relaxed/simple;
	bh=nkdEcXbWgfMJQ/F6iHPlCKTSMGrztTTDyQ3kIlT5LcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NBt/l1hruVsAnSgNp9T0A4MLL5X3ef0ypmVhLcYipQn1Pd/D2LrahP23vALB1P7YxHdKEKzmZysQdVuu2AgYqlBXkxe0BQG3wylTfsn1XKRXoFC5Ic+O9R7/8JkAHSNfqqlfGD4wYnr1OtBTtSgJtaZ0l5EuR1+P/NzSApW+res=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=concurrent-rt.com; spf=pass smtp.mailfrom=concurrent-rt.com; dkim=pass (2048-bit key) header.d=bksv.onmicrosoft.com header.i=@bksv.onmicrosoft.com header.b=D6iVD1Dx; arc=fail smtp.client-ip=40.107.104.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=concurrent-rt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=concurrent-rt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogvlnGEXSLb6pPloYn8709QascVh97PvI9uBCvVrEd5uf0lQYjTKvkH9N+ZOq38cNw6IJrl+mlFvUwdfpQgd4VIyPbX5FItXt0Pf1971BtsPgyX6QcSNrxP7gSUUpZc/WgktXpocfTuVyKH0Fb1/l6ctoGZ3viwqMTMLfF15X6DyLj5gFmqgYmKYhueHGGDv0U16lkT3pvvDaE9NPu9oZ1gInBST1L7MretNn99ZMOF9CWPmV+JkhaqJTurGB00L+sXmauboMQ9mCJfc8I7Gain5eHeMPkP87Iu09x/XVTOxhMxql968eroJQKBGBHbcIlNVxUOWF8kI/AOhHvYoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCaZ9PXuLhzaMHsTMBArgBa1W9CpJBekFnB0IVP7iio=;
 b=fIoWAypNOy2anntWTLnZedGAcoHqLBGfGrFhJbQodrKHg9xN01wjFy65d4Iiirfr7bZh/0V9TZ4HCoG/1khzsM3d0ZduEgQ0P/cEdr7ZK6sGwOz2Q/qjkXDuBb2NrAWDZwV5HRDKDrtk0CJAB+7X1FvdWXCCnFDTVXDMPw9F3bQ+kAMQ59msPGi8i29uljO1k0oqb6tz34pdwCUuOGbBaxREZSHBjpAcUqTtKZmk+Q0NmcfUCi2fAzM2cxFDZbtYVpAs9eigk2cp/q/riqR/WUF+5OQvMhb6h0GnKMze2Hw3ZfYKk9lETD6kfy8xJ571Dn1222PQCHGQ8Oykm47dNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.onmicrosoft.com;
 s=selector1-bksv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCaZ9PXuLhzaMHsTMBArgBa1W9CpJBekFnB0IVP7iio=;
 b=D6iVD1DxcLL2fb/oO7K5fUmCCS7LaSi/nO+Hixf2ke/zf+R6vJ8i/nCL2hJ5e9jfjXw6CFTfMC2WHbYUMsDJ84p/sa0YbKzfoQzSW82ZA99BGUVwviKx7DBlLlfnYHyDV+w3huN/yz7kPkMNePpS8P6blxtcxmAlinue6RXz2NCuf3S8/+WzKQzAVHQLVTNB3/d3HYjmyKYQkcD3WJ7SneJpFdnRsk41ybnXEcEJzt1kXQ+oOTjf0vmhMb4d0sGbsAYtqANa2A5qDrhWnwI4QAdPmUOmRx2kuFjeLNUR2r8HV8VIDXaIGvYMxwA3iLdrTxtlJWxcy90xGpRrRtw9Ug==
Received: from AS2PR09MB5983.eurprd09.prod.outlook.com (2603:10a6:20b:556::8)
 by PR3PR09MB4411.eurprd09.prod.outlook.com (2603:10a6:102:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 19:06:07 +0000
Received: from AS2PR09MB5983.eurprd09.prod.outlook.com
 ([fe80::2967:6e21:276e:2b3c]) by AS2PR09MB5983.eurprd09.prod.outlook.com
 ([fe80::2967:6e21:276e:2b3c%6]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 19:06:07 +0000
From: Zachary Goldstein <Zachary.Goldstein@concurrent-rt.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Shawn Guo <shawnguo@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>, Li
 Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: EXTERNAL: Re: [PATCH] arm64: ls1046ardb: Replace XGMII with
 10GBASE-R phy mode
Thread-Topic: EXTERNAL: Re: [PATCH] arm64: ls1046ardb: Replace XGMII with
 10GBASE-R phy mode
Thread-Index: AQHaZAwvsqZOO5LItUmHYwJFeAVuq7EVKISW
Date: Wed, 21 Feb 2024 19:06:07 +0000
Message-ID:
 <AS2PR09MB598321A95CD8EF0264744498A4572@AS2PR09MB5983.eurprd09.prod.outlook.com>
References:
 <20240214-ls1046-dts-use-10gbase-r-v1-1-8c2d68547393@concurrent-rt.com>
 <20240220145037.kf3avnykjif24kkr@skbuf>
In-Reply-To: <20240220145037.kf3avnykjif24kkr@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=concurrent-rt.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR09MB5983:EE_|PR3PR09MB4411:EE_
x-ms-office365-filtering-correlation-id: f719f9fe-7068-4b84-a194-08dc331028bc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 f0xy5Eb2WF48jDOD+U5A1m3xua7NTXgPPl5IByNzek8XlWrkFyhDGdapJIUMLhhuY0j+rB1RRHX4NZtiv7JilIS9wOgWIcgW7hoHPlUU3xloBYKlFJoGQ5yxgLscGSUCvda73LqERyXl+b9dRfsugXN/biKfqHvXzhC90CtZh5Fy7z0vlbwNeuMZ4w6H0c3FN8HEZQ+oE9fO9NVF3cm8Vv5O9QYE0oJKJ2PMxU/vZzI6GuqhM9R6fQ9X0FHHBCTsF61q3Ga70c9i2acx3P3a3B0hhhn1lzmd4Kl8Qdav9y9MKSYhqqDqEu+ataQg1nlMVma27rGsVSj+6+LTc8I27IGUVi1ebnVTrj9VNCRnshg/AGGHWbmjIBQs7VVkDHA7NExwlyEcygMp8JHypiuQ52xrLbzAGX7xu/55FjZiqGk7tPvmzdptf7BTuKep7UvA2xiaWt9vol4gcCyX3WtBjp/IU1ByS9oy1jutqyQgN3GlPJSLI5XsR+27uEEzPfm6gV3UosZWnyUbEmpCmjzreusGmqK2ZpZS/1uia69PsC58dBN2gjlBS2su3ABV20QVIWMX/DfY8P++qhfAB9GzgyiF0hkkwKdQPyWIiJTUDj0znx8iF5xE3XOkxy57DBEF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR09MB5983.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AB5Qqune8kVqWROzeaPp78FmG26o/DFgtncZwWg9j65V7AMrRYYRLm2TT6?=
 =?iso-8859-1?Q?s5/uotGr0xwZ+XONDsj8gwJpWVwkjUg1C/QZ7NlZKQDRtLNl7dA85WrCt4?=
 =?iso-8859-1?Q?0a22X9DxgG2ZDut3bj0VmLGsZP7XnSywk8r6+WBzthpkq7qUa6Qa0vsQ30?=
 =?iso-8859-1?Q?Trk8fyNdpY16DHjxyHVpIWrI1CqHDndTHm1P7n6uKHI3ijXBDPI/w+YTkq?=
 =?iso-8859-1?Q?G81k9VrgbhPALn4nL0v7ZenfGLyWYRgAB0VlVc6QYa2J2pSyPOQjgJ+BU6?=
 =?iso-8859-1?Q?nhMLNivm22Zr4cCEx1Zu3tdwoWPjbmE7GbhtDMGZwZay5SmLcpsSc6MeSt?=
 =?iso-8859-1?Q?MBqAnEQhgqi2dic6KCLxoTHVVSnTiza40cWqti7+C59AzQmMJXnt/MNYCP?=
 =?iso-8859-1?Q?CTbS5fyCYx/xNzGGeX4kgmQzRN62Oz1TjGdp58azFmlkzRrBLjJN4p3ud/?=
 =?iso-8859-1?Q?1Yqly2wFe63YO2PK+yXjo98dhlFUs237hp1gEk8WMhaudPdEKwJzMgGlGj?=
 =?iso-8859-1?Q?7ODHhPOI34HWBkokB/T6GewGt9F45N05tIPuaTEPSTxv7aNivJL5tvsMnB?=
 =?iso-8859-1?Q?36owWiT8nfMdAYViVig3LyArv+l/q1Z7P2vp8tqH0mvHQ2fRzgOGuNPiKI?=
 =?iso-8859-1?Q?Qkg27O/NNliupSooqzX9ajUZPiwRTlIEGOdC7pt9KGMWqook4socCQqU+m?=
 =?iso-8859-1?Q?B/RqQ9OiieGBbFE/IJqO0IvPA3VvK9QbdcKnfHjy9W5qT6ARUnjEWJAAuW?=
 =?iso-8859-1?Q?zTDv8DGzhDFIBxJzFZ3tGdHgXVzdixhfBVGYAVC8e1FD4iRDnikCJip9JV?=
 =?iso-8859-1?Q?Q5ST5RFVTI+Ppe0U5hw2Xer+Uf1k77QLZou0q9wxHbJkz5ec4gLjRDQaFP?=
 =?iso-8859-1?Q?L4UyQfJMN25TOdpJw9AjnML+eete0uAyZXBZTlnDG01zePxmsbAdyNcXZz?=
 =?iso-8859-1?Q?Oo7EgLZHCOQUCuobv6AbHlRlxer13KR1qj4MnMSITY9niv/KwJ9ocan8Au?=
 =?iso-8859-1?Q?oGC9l1P5AerOwITmXOqlBBMKe4/R8kAXA6n42Ze/yhnYw7k3vcpqugS1rY?=
 =?iso-8859-1?Q?Cu/bDQnXhIVmApWfxrwrMfL6XKF3drOEVYehwoOymqmlcRsxNGYP0/Bb7t?=
 =?iso-8859-1?Q?fvht4ekyynNaDtD/X55/rNPGm5y8bgNg1mKu0ia2qcWHrIDp9n1ES+sOAk?=
 =?iso-8859-1?Q?YRyxAFiHCOlOM5i9D801afl5J5yKAlo5eLOOGeFkQDpJMWsaEILWeaNKeg?=
 =?iso-8859-1?Q?ETxDYJ55CDuACvWoHc8VxRwHIBr1i2glAfU+k0odpZNZKtW6ugEoiYjTzv?=
 =?iso-8859-1?Q?IYHZ+nzRxWOIMMsaL/eCLHAF/Wsf1J1yHi2zin1TT+20B8MqHpg797X7Jj?=
 =?iso-8859-1?Q?LCBBHGuoY2QsIl6nZ3afYt4lbdsEpwk4HG/oOiz8ZK7NjEFU0eYgwfPotx?=
 =?iso-8859-1?Q?V0it9A9mrF+EnqEnS3L5SnlwkBBzAbRggdYPoIZOM/tcUmY24tN3GrCVlP?=
 =?iso-8859-1?Q?aZRIRwLcXEuGMSj8YfAK7GFayFHNH9KWbiOx1IdTKMX8cjt6GRG57On3m+?=
 =?iso-8859-1?Q?AkG3xiV97jdGLOhxjVjWAaGNTu1jif0++j+cDCLtfy82+AIVU4HHdxDeSY?=
 =?iso-8859-1?Q?Es3tbZ7uPiHPkFYAj0fAxJAlKnBCaETZ6ozn/tp6WMsQPeNa32yJvyYQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR09MB5983.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f719f9fe-7068-4b84-a194-08dc331028bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 19:06:07.5397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F4lcGwVD80+p4BcIeoI7JfB69pJG1Lezltk0Tq6bZpRbpOtsXzMliul3GD9Nvl5zRA38jOkSg/ywe4xFhJGcnBGnnSA3MWjipHDg/h8NhEHJG4dzjNaaAeL0CqEoJS8v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR09MB4411

On Tue, Feb 20, 2024 at 04:50:37PM +0200, Vladimir Oltean wrote:=0A=
> Hi Zachary,=0A=
> =0A=
> On Wed, Feb 14, 2024 at 05:21:54PM -0500, Zachary Goldstein via B4 Relay =
wrote:=0A=
> > From: Zachary Goldstein <zachary.goldstein@concurrent-rt.com>=0A=
> > =0A=
> > The AQR107 family does not support XGMII, but USXGMII and=0A=
> > 10GBASE-R instead. Since ce64c1f77a9d ("net: phy: aquantia: add USXGMII=
=0A=
> > support and warn if XGMII mode is set") the kernel warns about XGMII=0A=
> > being used. The LS1046A SoC does not support USXGMII, so use 10GBASE-R=
=0A=
> > instead.=0A=
> > =0A=
> > Signed-off-by: Zachary Goldstein <zachary.goldstein@concurrent-rt.com>=
=0A=
> > ---=0A=
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 2 +-=0A=
> >  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> > =0A=
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/a=
rm64/boot/dts/freescale/fsl-ls1046a-rdb.dts=0A=
> > index 07f6cc6e354a..d2066f733dc5 100644=0A=
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts=0A=
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts=0A=
> > @@ -149,7 +149,7 @@ ethernet@ea000 {=0A=
> >  =0A=
> >  	ethernet@f0000 { /* 10GEC1 */=0A=
> >  		phy-handle =3D <&aqr106_phy>;=0A=
> > -		phy-connection-type =3D "xgmii";=0A=
> > +		phy-connection-type =3D "10gbase-r";=0A=
> >  	};=0A=
> >  =0A=
> >  	ethernet@f2000 { /* 10GEC2 */=0A=
> > =0A=
> > ---=0A=
> > 2.40.1=0A=
> > base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de=0A=
> > =0A=
> > =0A=
> =0A=
> You do not need this patch in upstream, and I strongly advise against=0A=
> merging it as-is. I've just tested pure net-next on LS1046A-RDB, and I=0A=
> can bring up fm1-mac9 without any warning.=0A=
> =0A=
> You'll notice that commit 5d93cfcf7360 ("net: dpaa: Convert to phylink")=
=0A=
> did this in fman_memac.c:=0A=
> =0A=
> 	/* The internal connection to the serdes is XGMII, but this isn't=0A=
> 	 * really correct for the phy mode (which is the external connection).=
=0A=
> 	 * However, this is how all older device trees say that they want=0A=
> 	 * 10GBASE-R (aka XFI), so just convert it for them.=0A=
> 	 */=0A=
> 	if (mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)=0A=
> 		mac_dev->phy_if =3D PHY_INTERFACE_MODE_10GBASER;=0A=
> =0A=
> So, what gets passed to the Aquantia PHY is PHY_INTERFACE_MODE_10GBASER,=
=0A=
> even if in the device tree, phy-connection-type =3D "xgmii".=0A=
> =0A=
> Now, _if_ your patch were to be applied on top of upstream, it would=0A=
> actually break fm1-mac9 like this (WARN_ON added by me for a call stack=
=0A=
> of the phylink_validate() failure path):=0A=
> =0A=
> WARNING: CPU: 2 PID: 1 at drivers/net/phy/phylink.c:763 phylink_create+0x=
8f8/0x90c=0A=
> Modules linked in:=0A=
> CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc4-0105=
8-g9e1deba407fb #1812=0A=
> Hardware name: LS1046A RDB Board (DT)=0A=
> Call trace:=0A=
>  phylink_create+0x8f8/0x90c=0A=
>  dpaa_netdev_init+0x1a8/0x2c8=0A=
>  dpaa_eth_probe+0xd70/0xf64=0A=
>  platform_probe+0xa8/0xd0=0A=
>  really_probe+0x130/0x2e4=0A=
>  __driver_probe_device+0xa0/0x128=0A=
>  driver_probe_device+0x3c/0x200=0A=
>  __driver_attach+0xe8/0x1b4=0A=
>  bus_for_each_dev+0xec/0x144=0A=
>  driver_attach+0x24/0x30=0A=
>  bus_add_driver+0x154/0x244=0A=
>  driver_register+0x68/0x100=0A=
>  __platform_driver_register+0x24/0x30=0A=
>  dpaa_load+0x34/0x64=0A=
>  do_one_initcall+0xf8/0x34c=0A=
> ---[ end trace 0000000000000000 ]---=0A=
> fsl_dpaa_mac 1af0000.ethernet (unnamed net_device) (uninitialized): faile=
d to validate link configuration for in-band status=0A=
> fsl_dpaa_mac 1af0000.ethernet: error -EINVAL: Could not create phylink=0A=
> fsl_dpa: probe of dpaa-ethernet.4 failed with error -22=0A=
> =0A=
> It fails because of this in phylink_validate():=0A=
> =0A=
> 	if (!test_bit(state->interface, interfaces))=0A=
> 		return -EINVAL;=0A=
> =0A=
> And state->interface (PHY_INTERFACE_MODE_10GBASER) is not in=0A=
> mac_dev->phylink_config.supported_interfaces, because the fman_memac=0A=
> code is not prepared to handle this combination.=0A=
> =0A=
> The device tree node for fm1-mac9 looks like this, generated by an=0A=
> awkward merge between the following:=0A=
> =0A=
> 	ethernet@f0000 {=0A=
> 		phy-connection-type =3D "xgmii";	// fsl-ls1046a-rdb.dts=0A=
> 		local-mac-address =3D [...];	// U-Boot=0A=
> 		cell-index =3D <0x8>;		// qoriq-fman3-0-10g-0.dtsi=0A=
> 		pcsphy-handle =3D <0x31>;		// qoriq-fman3-0-10g-0.dtsi=0A=
> 		compatible =3D "fsl,fman-memac";	// qoriq-fman3-0-10g-0.dtsi=0A=
> 		reg =3D <0xf0000 0x1000>;		// qoriq-fman3-0-10g-0.dtsi=0A=
> 		phy-handle =3D <&aqr106_phy>;	// fsl-ls1046a-rdb.dts=0A=
> 		fsl,fman-ports =3D <0x2f 0x30>;	// qoriq-fman3-0-10g-0.dtsi=0A=
> 	};=0A=
> =0A=
> Notice that unlike fm1-mac10 (node "ethernet@f2000"), there is no=0A=
> pcs-handle-names property (fm1-mac10 has it defined in fsl-ls1046-post.dt=
si,=0A=
> whereas fm1-mac9 doesn't. Don't ask me why, I don't know....)=0A=
> =0A=
> So, knowing that of_property_match_string(mac_node, "pcs-handle-names", "=
xfi")=0A=
> will return an error code for fm1-mac9, now please walk through memac_ini=
tialization()=0A=
> and see what happens in the 2 cases:=0A=
> =0A=
> - mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII (current device tree). =
The=0A=
>   code creates a default PCS and assigns it to memac->xfi_pcs like this:=
=0A=
> 	if (err =3D=3D -EINVAL || err =3D=3D -ENODATA)=0A=
> 		pcs =3D memac_pcs_create(mac_node, 0);=0A=
> 	(...)=0A=
> 	if (err && mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)=0A=
> 		memac->xfi_pcs =3D pcs;=0A=
> =0A=
> - mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_10GBASER (your modification).=
=0A=
>   The code will still create the default PCS, but assign it to=0A=
>   memac->sgmii_pcs instead!=0A=
> =0A=
> 	if (err && mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII) // not XGMII=
, but 10GBASER!=0A=
> 		memac->xfi_pcs =3D pcs;=0A=
> 	else=0A=
> 		memac->sgmii_pcs =3D pcs;=0A=
> =0A=
> And this is why, with a NULL memac->xfi_pcs, PHY_INTERFACE_MODE_10GBASER=
=0A=
> will not be in phylink's supported_interfaces.=0A=
> =0A=
=0A=
Admittedly, I had made the wrong assumption from looking at the dpaa=0A=
driver code and fm1-mac10, that "xgmii" and "10gbase-r" were=0A=
interchangeable. =0A=
=0A=
> To make your device tree patch work as intended with the current=0A=
> mainline code, what you want is to also modify the driver like this:=0A=
> =0A=
> >From d6bda34b132d17d1c236d27436b9335fac22c062 Mon Sep 17 00:00:00 2001=
=0A=
> From: Vladimir Oltean <vladimir.oltean@nxp.com>=0A=
> Date: Tue, 20 Feb 2024 16:12:27 +0200=0A=
> Subject: [PATCH] net: dpaa: fman_memac: accept phy-interface-type =3D=0A=
>  "10gbase-r" in the device tree=0A=
> =0A=
> We support the phy-interface-mode =3D "xgmii" conversion to "10gbase-r"=
=0A=
> through code, but not actually through the device tree proper. This is=0A=
> because boards such as LS1046A-RDB do not define pcs-handle-names in the=
=0A=
> ethernet@f0000 device tree node, and the code only has fallback xfi_pcs=
=0A=
> determination logic for "xgmii".=0A=
> =0A=
> By reversing the order between the fallback xfi_pcs assignment and the=0A=
> "xgmii" overwrite with "10gbase-r", we are able to support both values=0A=
> in the device tree, with identical behavior.=0A=
> =0A=
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>=0A=
> ---=0A=
>  .../net/ethernet/freescale/fman/fman_memac.c   | 18 +++++++++---------=
=0A=
>  1 file changed, 9 insertions(+), 9 deletions(-)=0A=
> =0A=
> diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/n=
et/ethernet/freescale/fman/fman_memac.c=0A=
> index e30bf75b1d48..0996759907a8 100644=0A=
> --- a/drivers/net/ethernet/freescale/fman/fman_memac.c=0A=
> +++ b/drivers/net/ethernet/freescale/fman/fman_memac.c=0A=
> @@ -1076,6 +1076,14 @@ int memac_initialization(struct mac_device *mac_de=
v,=0A=
>  	unsigned long		 capabilities;=0A=
>  	unsigned long		*supported;=0A=
>  =0A=
> +	/* The internal connection to the serdes is XGMII, but this isn't=0A=
> +	 * really correct for the phy mode (which is the external connection).=
=0A=
> +	 * However, this is how all older device trees say that they want=0A=
> +	 * 10GBASE-R (aka XFI), so just convert it for them.=0A=
> +	 */=0A=
> +	if (mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)=0A=
> +		mac_dev->phy_if =3D PHY_INTERFACE_MODE_10GBASER;=0A=
> +=0A=
>  	mac_dev->phylink_ops		=3D &memac_mac_ops;=0A=
>  	mac_dev->set_promisc		=3D memac_set_promiscuous;=0A=
>  	mac_dev->change_addr		=3D memac_modify_mac_address;=0A=
> @@ -1142,7 +1150,7 @@ int memac_initialization(struct mac_device *mac_dev=
,=0A=
>  	 * (and therefore that xfi_pcs cannot be set). If we are defaulting to=
=0A=
>  	 * XGMII, assume this is for XFI. Otherwise, assume it is for SGMII.=0A=
>  	 */=0A=
> -	if (err && mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)=0A=
> +	if (err && mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_10GBASER)=0A=
>  		memac->xfi_pcs =3D pcs;=0A=
>  	else=0A=
>  		memac->sgmii_pcs =3D pcs;=0A=
> @@ -1156,14 +1164,6 @@ int memac_initialization(struct mac_device *mac_de=
v,=0A=
>  		goto _return_fm_mac_free;=0A=
>  	}=0A=
>  =0A=
> -	/* The internal connection to the serdes is XGMII, but this isn't=0A=
> -	 * really correct for the phy mode (which is the external connection).=
=0A=
> -	 * However, this is how all older device trees say that they want=0A=
> -	 * 10GBASE-R (aka XFI), so just convert it for them.=0A=
> -	 */=0A=
> -	if (mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)=0A=
> -		mac_dev->phy_if =3D PHY_INTERFACE_MODE_10GBASER;=0A=
> -=0A=
>  	/* TODO: The following interface modes are supported by (some) hardware=
=0A=
>  	 * but not by this driver:=0A=
>  	 * - 1000BASE-KX=0A=
> =0A=
> But!=0A=
> =0A=
> Device tree is stable ABI, and changes made to the device tree file are=
=0A=
> meant to be backwards and forwards compatible with the code (it can be=0A=
> provided separately and not necessarily in lockstep with the kernel=0A=
> version. For example, I understand Arm SystemReady IR wants U-Boot to=0A=
> provide its own device tree to Linux through EFI). So, in general,=0A=
> device tree changes which only work with a corresponding kernel change=0A=
> are frowned upon (unless maybe if the kernel change is a bug fix that is=
=0A=
> backported to all relevant stable kernel branches).=0A=
> =0A=
> So at this stage we should take a step back and re-analyze the cost/benef=
it.=0A=
> You said there is a stack trace in the Aquantia PHY driver, which there=
=0A=
> is not (in current mainline kernels). I _think_ you are seeing the stack=
=0A=
> trace with LSDK, which is currently distributed on top of linux-6.1.y=0A=
> and has not yet integrated the fman_memac conversion to phylink - thus,=
=0A=
> it does not contain commit 5d93cfcf7360 ("net: dpaa: Convert to phylink")=
=0A=
> At least, I do see this stack trace there. I think it can also be seen=0A=
> with mainline kernels before the phylink conversion, but I did not test=
=0A=
> those.=0A=
> =0A=
> The main take-away is: ALWAYS test the patch you are submitting to the=0A=
> target kernel it is going to be applied to. Especially in the area of=0A=
> device tree bindings for DPAA1, things are rarely as simple as they=0A=
> appear :) If you don't, you will have an unintended negative effect=0A=
> upon current mainline kernels (which must still work), and not the=0A=
> intended effect upon LSDK (more below).=0A=
=0A=
This is my mistake, as at the time I had no way of testing this patch on=0A=
6.8. After looking at commit 5d93cfcf7360 ("net: dpaa: Convert to=0A=
phylink"), I had made the (wrong) assumption that changing to=0A=
"10gbase-r" was pretty harmless. =0A=
=0A=
> =0A=
> There are a few options to go forward from here.=0A=
> =0A=
> As there is nothing broken in the mainline kernel where you are=0A=
> submitting this patch, the simplest one, as bland as it may sound, is=0A=
> simply to wait for a new LSDK release on top of linux-6.6.y. Even in=0A=
> lf-6.1.y, AFAICS, nothing is broken except for the stack trace. You can=
=0A=
> keep the patch in your local kernel tree copy to suppress that.=0A=
> =0A=
> The other option would be to submit the fman_memac change as a bug fix=0A=
> for stable, wait for a while for it to have time to propagate, then=0A=
> modify the device tree as well. But, it is much higher effort, and=0A=
> there is no procedure in place, AFAIK, for LSDK to integrate your patch=
=0A=
> (other than through upstream + a few months of waiting). The upcoming=0A=
> LSDK release will be on top of linux-6.6.y, it will make your effort=0A=
> irrelevant if it's only for suppressing the stack trace, and you are=0A=
> racing against it. This path is only worth it if you have the dedication=
=0A=
> to dig a bit deeper and tidy things up in the DPAA1 kernel support=0A=
> (which would be appreciated though).=0A=
> =0A=
> _If_ you are using an older linux-stable branch but not LSDK, yes, the=0A=
> feedback loop between your patch and its effect will close much sooner,=
=0A=
> but you will have to convince the linux-stable people that it's worth=0A=
> accepting your driver rework patches for a functional reason and not=0A=
> just aesthetic (see Documentation/process/stable-kernel-rules.rst for=0A=
> reference).=0A=
=0A=
Considering "xgmii" is a deprecated phy type for the AQR107 family, I=0A=
still think there is some value to this change beyond aesthetics if=0A=
support for "10gbase-r" is ever added.=

