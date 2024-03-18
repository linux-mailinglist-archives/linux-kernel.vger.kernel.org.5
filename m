Return-Path: <linux-kernel+bounces-106794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A515F87F3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C32A2820A1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E271D5D463;
	Mon, 18 Mar 2024 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NAj2ZyBp"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2112.outbound.protection.outlook.com [40.107.14.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5589B5CDCE;
	Mon, 18 Mar 2024 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803466; cv=fail; b=Nd+vYqXAay4983kCuBtkgIZHv23FYVqg8ZIffF+UiRp6TBQZpQgrOVhVSFnaqZhe+u0GvqEHZOJ2P5VRlEbl5w2G6IBKS3z+pOjutMhHxjuPsZOZpDBAXxflLM0K61i8O+Pt6bBOwta3/MLhDrbzRO0dXDbloKgwSp+YzZphuLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803466; c=relaxed/simple;
	bh=IA1qiX/nbBfcC14TNJePO/J9vM7Mn1WENw8RlNTkvjU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R6Py3ymTh2/YJbukzLW9T+XJlOfILAXtJvBDMZ2h54OJj0h/w/FvzZl8bM6YaGZNIktbFqORVjLTJKEx3jXHppwR+Fa6W3d/EhzKi3nPi0lSiUo8aJG8oabRFcu8rhpjHTLFGSpnn6zc6qxUUDdn2sXEpPvzmIQA8q0nYtRR5lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NAj2ZyBp; arc=fail smtp.client-ip=40.107.14.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCN9QSyKRWg1LjkaXFNcno3NAZuFkDLDoQNp5LjixwSN0nDOQSWUJ1reNDGlXXJrNNKoOXQSVehQzm9DuPBjPiHh6JqwbTkJ2By3VaZqt27Q5UoQjpR8sWzA/BXifr4yOXRqXUzNIwaMCF/9ZJOSbi1n885ZrO+EyMyjJsg7h8WjQ93S3ESZhUHsnqFRjFtCZsyHmU1y4WUH40Dq2sUMxCQN/+egaaPWBXB96uUYyU8x6c8CNcJ5AV79r1cEn9oPgr7BY3JFKC7Vj8irdpqKxPtg3lecr1XMxQb+43/6gYGNFfyYZTO5L+kb5mGY3htQqeSpTBohKJIGW5x+MVBcag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDjcu/lA2OqFugvdYqNHgdZndJftp1PWZFJeSZvwLNA=;
 b=F8lIWyKV4spbCB7tg9IiDMF1+UGnkR1gv2FJLaR2hitx2OdQeYxVQ8jt7CfekP2LS2nyb5wu+ypj3uJLBDGZVz8qyOXP4B6Wb4VxaxRrC4kndEhQUQVY/XXa7P2CTEEDjHieHTjrhuCdRm9r/XQuyFfh6OF1Qs9HP5ipoNKLPCRh5jGEHUY/7U1j3x6qndrNyaey0HC+zzMO183LApQIC4bP+wc4sRAbNvt9s1cdP1i2Nd/x/xT/7u1EWcdKTyeod2g9DeedvfxcnMskgFTMPhyFs5mc+1X9zP+sVeqbiH3q5mNx0r4FMJ9hKdvZqcD3gR81n8AMoONUUROKPPB61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDjcu/lA2OqFugvdYqNHgdZndJftp1PWZFJeSZvwLNA=;
 b=NAj2ZyBp+AFlR9g6yej0gg5F6XhNz6DZ9PSoa8VwVUS8XnpX59PSwCGZAf35spR6fWuZqPxg4kSRzbtqhC9yrsexQCv+1uBRjIhSnvP4iJNZrnkU7LAroIy31btlxgaSwMKHHqBN0NUMI7br68cF7yEv7D1/LowKkwwvnVPmskg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9881.eurprd04.prod.outlook.com (2603:10a6:800:1e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 23:11:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Mon, 18 Mar 2024
 23:11:00 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 0/6] Add support i.MX95 BLK CTL module clock features
Thread-Topic: [PATCH v4 0/6] Add support i.MX95 BLK CTL module clock features
Thread-Index:
 AQHadhHzV0Q2ZMhJLUKmpuh6Q87XB7E8G/aAgACbUACAAJKogIAAA6TggABBkwCAAJWa8A==
Date: Mon, 18 Mar 2024 23:11:00 +0000
Message-ID:
 <DU0PR04MB94173BD288E56BD7C7C408DD882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
 <20240317155911.pdc32nsyxcdhs2t7@pengutronix.de>
 <DU0PR04MB941725052D5E3EF78F67A1C5882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20240318095959.v5d7qeoci5v2dtkq@pengutronix.de>
 <DU0PR04MB94177A4081547764F600635E882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20240318140742.3pfn5h6wqhbtgbmj@pengutronix.de>
In-Reply-To: <20240318140742.3pfn5h6wqhbtgbmj@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB9881:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +W7aGAdFBpNnqGB4xFHFjFrMDoIFUPd3rn35G5KFhj2EaTrr+VhENBFSpbAx4do9pVps9Fv4jT/0R0Cp7eqQ33QWo3cUo2NUajmYhHM8xxdrEYxS5/11BQQZjsygv8AwsO0OrI+35iqfvChFb+wMvjhgqeofECYNmoIM6tU4vgcKax13RHj4L32rhnQrNumncIs70F5b58+Ji9N7h3y8C3ncPjJ5A676iE0Bvkfnmct6nlBmZPStCclaYNF/4zpWxHwroX08Vs/bK7axVMdcn/jJoo59Uq+hMAkDaL33Lr1TUrjQhr98Yqxv7STJdpKVMMbfuGdG6Jpzf4dUK3VhIvmdfmfqaTVviMAGiGuUssK72QXwD7R1at+dIoG7a3BQvOmmq5c/JOvmMREDQgLZJd8ybUYwJrtvRLcTkxKUkAQpjYFMfiySNMN5PdRBV4WDkhYiypl5WcEaVSG+vM8PDFAfTTeVOnyMZKH+JUrMSb4ORWXWPiW2sdGD9xtiLgkJmwMIKZ30boSGFAJkniNanO/JnjQYqPM2l+CE2GHbAM7QbvgOOhHHLJse0RpiDUbBc7Pmkk3go12V5DDukbq3y3rZHi1+cda/spOrY16kaCUC4yXcWy1BVl3WRNoR3NMIpFBFGrZaqbab/dmLKaJ6kjqLH6Jv9Lnji3aEwDgmmSg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0maW0ZQlh+eL3vSB2rAuOvhgfE2Bi50sFwXAkTAXUOhi1q/2ccPU4xEXoD8I?=
 =?us-ascii?Q?Mj05gDbY2PqnsYMq0gSGMynf+DPK+Mh4V1NH2sJMXDCpvCgPL/hW2ty95fhR?=
 =?us-ascii?Q?PNc+k5uGBNISxhcWSbNkfy2BU+/Uh3Nuo2O9KiklTi+g42gM8iE7PGukNeVj?=
 =?us-ascii?Q?djLd/yJKT0u+4NxcpIPb/1VvR0GnHW4un9Gb5SC1cIBQ9/sdTN/pdbt4g2Nh?=
 =?us-ascii?Q?Drx0ZDiEEVUtC6mSYteNMi4Mc3vGaJoePTGVvrFxq0+ydri621Bp5HDe7Cjc?=
 =?us-ascii?Q?XhUqGxw9w6GfD0waz8p+vVKmDyabQ40o0Ced7Qpl4Vm9BXLq6/8v1KtZT59N?=
 =?us-ascii?Q?rNKqNZzptWLP1iyGHfdG6FlH+BNG4kklQ/LquLDhOodOqAY2wIw1f8o9lQLz?=
 =?us-ascii?Q?HbRxYLw9T2lCH8+J2RNVCGvPmyM+R83nJx7r7UVDOAvzqN9Vfu7lkpOmm5Xv?=
 =?us-ascii?Q?x7rmR4kuTeiFiR3PyYZbLu67LFpFTq6l9f+wwUv03iK80h8ThNS4p45vRiw3?=
 =?us-ascii?Q?WhGmrkbz5AW/j7UhPYav1jxPXASvWlvAJSs7M/mEXt0d/ajyseLL44YBpgZj?=
 =?us-ascii?Q?P9b6nvbYCMOe2R8jE/Kz8o/ojvzJqimjC4HSkBtnPABialFZGZUknPq3dNhF?=
 =?us-ascii?Q?poqsgZb3SH5WvKHwKEDMpP64nfOXH0oUYpK1DVbENgZq9jUaNXYTtqfndPep?=
 =?us-ascii?Q?Z/QV94jay2WfwMpqB/0QNh5EWu3/t4/h50PBMsvCuohFpJGiVI8MvKwSQQsL?=
 =?us-ascii?Q?JzuNwRmdZ9FKtlmu0jgC1HZf96qzhRAXFVHZ293FFEg4Edkeyjkwl6dc15//?=
 =?us-ascii?Q?WHWIbIGxR9Xi4FvWqrDqSyP2C1PF2Qt0/lzBFFkwe71dnsWYlRKB1TacPtl4?=
 =?us-ascii?Q?k4SU3xGryOqGlYw/Natl08FRVaFlpOPwJ+0XaoPvUtuWxkUFo3CLNgRZWNpA?=
 =?us-ascii?Q?6vYJ68IOufV8tiFunidY06Kw7AVAEWpbFz1NTuh0fNkXufUtTctnhq5WBqkE?=
 =?us-ascii?Q?fVgCK37+hSHS8H3zfoE6pdjUAmXpyCNZ3FZydFX4mV19tbyDlGVFkWzopEd0?=
 =?us-ascii?Q?/fgYrRqr2T7mPOg/Rz9/JKS7NZ4lhjJ5YAwg+QG3te/5aVM49RfWUESfXiW2?=
 =?us-ascii?Q?N3lqtX2es5Pq55wealmNkGTdXNekX3nckNGkN5e58ZAttjpNr2sIf7RQSfqj?=
 =?us-ascii?Q?S9+kvCcxUINzN10Xm+osxv4Ogt0wCcVidJVq5ycTP/c4pl4zi8OWEOrP9g6i?=
 =?us-ascii?Q?D5iNsDS09Eqa0crJsF5vCV1EQzRHWcp+i6qUrUPsn8WAbN7tHNe8faodVJer?=
 =?us-ascii?Q?iVGeM4IPj+XSI7g/66WKA3UJlGCn1ACdG2MxJjRsJvqGOl6ZWEf5k2/ATfsl?=
 =?us-ascii?Q?QWOA5Zb+k/s2zagL5mcMJiKoZuJZ/lDlCFk0VV/zOcKrckc852XEo3ugTl+4?=
 =?us-ascii?Q?ALaFXAFwR42APV2YqRNXtOLSvr+vxSJwYyEfTYCK2HMfb7VfAzuXdJKCdhTK?=
 =?us-ascii?Q?T9uU6JUbsDzY1LwXiWny+TtSVy/uZOjJy5aQn2BFa7NB7DpUhyOx8llWx67v?=
 =?us-ascii?Q?JQI1Zqa9gfF5ZpRCUYs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b8a379-7968-4d49-d0f9-08dc47a0ad34
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 23:11:00.5418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGsJxaJkiiW8LOsnjeg5rlfBmZr+J5v3i5DnIhOoDWZcyfMLp034FX/575QxMZE5ul37ER1uRMVDQUkUSRBb5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9881

> Subject: Re: [PATCH v4 0/6] Add support i.MX95 BLK CTL module clock
> features
>=20
> On 24-03-18, Peng Fan wrote:
> > > Subject: Re: [PATCH v4 0/6] Add support i.MX95 BLK CTL module clock
> > > features
> > >
> > > On 24-03-18, Peng Fan wrote:
> > > > Hi Marco,
> > > >
> > > > > Subject: Re: [PATCH v4 0/6] Add support i.MX95 BLK CTL module
> > > > > clock features
> > > > >
> > > > > Hi Peng,
> > > > >
> > > > > thank for the patchset.
> > > > >
> > > > > On 24-03-14, Peng Fan (OSS) wrote:
> > > > > > i.MX95's several MIXes has BLK CTL module which could be used
> > > > > > for clk settings, QoS settings, Misc settings for a MIX. This
> > > > > > patchset is to add the clk feature support, including
> > > > > > dt-bindings
> > > > >
> > > > > I have to ask since there is almost no public documentation
> > > > > available yet. The
> > > > > i.MX95 does have an system-controller for managing pinmux
> > > > > settings and power-domains, right?
> > > >
> > > > Yes.
> > > >
> > > > If this is the case, why not making use of it via the
> > > > > standard scmi_pm_domain.c driver?
> > > >
> > > > The SCMI firmware not handle the BLK CTL stuff, but blk ctl stuff
> > > > is a mix of clk, qos, module specific things. It is not good for
> > > > SCMI firmare to handle it.
> > >
> > > Currently most of the blk-ctrl users do use the blk-ctrl as
> > > power-domain consumer, except for the isi and the audio part.
> >
> > Yes, for i.MX8M.
> >
> > > So as I said above the
> > > scmi_pm_domain.c should be able to supply this. The audio blk-ctrl
> > > could be abstracted via the clk-scmi.c driver. The ISI is another top=
ic.
> >
> > Pengutronix rejected the efforts for putting blk ctrl stuff in ATF for
> > i.MX8M before. So we take the kernel power domain approach to handle
> > blk ctrl clk gating.
>=20
> AFAIK the problem here was that your proposal had an layering violation
> even worse it was an layering inversion since the TF-A (lower layer) code
> updated CCM registers which were under control of Linux (upper layer).
>=20
> > > What you're are going to do here is to put pinctrl etc into SCMI
> > > firmware and power-control into Linux, which sound to me like an
> > > 50/50 approach and IMHO is rather sub-optimal.
> >
> > Now back to i.MX95 which supports function safety.
> >
> > The SCMI firmware only handle CCM/SRC/GPC for clock/power, it not
> > handle blk ctrl.
>=20
> I know that.
>=20
> > The BLK CTRL registers are not only for clk gating, it has other
> > module specific functions.
>=20
> I suspected that this is the case for i.MX95 too :/

Yes, BLK CTRL is a group of control registers for a MIX, including i.MX95.

>=20
> > Moving BLK CTRL to SCMI firmware, means linux accessing module
> > specific functions needs go through vendor SCMI protocol.
>=20
> Right and here it's a bit complicated to have an proper interface.
> Therefore I'm not again the solution of keeping the blk-ctrl within Linux=
.
>=20
> > And BLK CTRL stuff is MIX level stuff, it is not SOC level stuff as
> > CCM which is system critical resource.
>=20
> Hm.. it's still SoC level albeit the area is more limited to specific fun=
ctions like
> HSIO, MEDIA, GPU, ...
>=20
> > (BLK CTLR, I mean non system critical BLK CTRL, such as GPU,VPU,DISP)
>=20
> What's system critical is up to the system design but I get your point th=
at
> having an safe DISP stack is not going to happen.

Right. There is a M7 core runs safety application, there is a system
controller core manage clk/power/pin and etc.

The DISP related BLK CTRL could be directly assigned to M7 core if there is
such usecase.

>=20
> > The other approach is to let ATF as SCMI server to handle BLK CTRL
> > stuff, But I not see benefits.
>=20
> How is that any different from putting it into the system-controller firm=
ware.
>=20
> > > To quote your online available fact sheet:
> > >
> > > 8<----------------------------------------------------------
> > > ENERGY FLEX ARCHITECTURE
> > >
> > > The i,MX 95 family is designed to be configurable and scalable, with
> > > multiple heterogenous processing domains.
> > > This includes an application domain with up to 6 Arm Cortex A55
> > > cores, a high-performance real-time domain with Arm Cortex M7, and
> > > low- power/safety domain with Arm Cortex M33, each able to access
> > > interfaces including CAN-FD, 10GbE networking, PCIe Gen 3 x1
> > > interfaces, and accelerators such as V2X, ISP, and VPU.
> > > 8<----------------------------------------------------------
> > >
> > > 8<----------------------------------------------------------
> > > HIGH-PERFORMANCE COMPUTE
> > > The i.MX 95 family capabilities include a multi-core application
> > > domain with up to six Arm Cortex(r)-A55 cores, as well as two
> > > independent real-time domains for safety/low-power, and
> > > high-performance real-time use, consisting of high-performance Arm
> > > Cortex-M7 and Arm Cortex-M33 CPUs, combining low-power, real-time,
> > > and high-performance processing. The i.MX
> > > 95 family is designed to enable ISO 26262 ASIL-B and SIL-2 IEC 61508
> > > compliant platforms, with the safety domain serving as a critical
> > > capability for many automotive and industrial applications.
> > > ...
> > > 8<----------------------------------------------------------
> > >
> > > To me this sound like we can turn of the power/clock of an hardware
> > > block which was assigned to a core running SIL-2 certified software
> > > from an non- critical core running Linux if we follow that approach.
> > > Also the
> > > SIL-2 software requires the non-critical software to turn on the
> > > power of these hardware blocks. Is this correct?
> >
> > Non-critical software not able to turn off power/clock of a critical
> > resource in safety software domain.
> > Safety software not require non-safety software to turn on power/clocks=
.
>=20
> Due to lack of documentation I don't know how you implemented this in
> HW/SW, also the system-design is telling us which parts should be seen as
> safe and which don't. However I get your point, VPUMIX is not going to be=
 a
> part of the safe partition albeit it "could" due to complexity.

If safe function needs VPU feature, VPUMIX could be totally assigned to M7
core through TRDC isolation, not assigned its BLK CTRL to system controller
core.

>=20
> > CCM/SRC/GPC is handled by SCMI firmware, agent w/o safety needs use
> > SCMI API to request SCMI firmware to enable clock/power for a module.
> > The SCMI firmware will check whether the agent is allowed to touch a
> > clock entry or a power entry.
>=20
> I got this. I still don't like the 50/50 approach but I also get your poi=
nt about
> the GPR registers which is the only valid argument to me of not putting t=
he
> blk-ctrl handling into the system-controller firmware.

Thanks,
Peng.

>=20
> Regards,
>   Marco

