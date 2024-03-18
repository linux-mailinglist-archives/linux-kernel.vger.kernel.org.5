Return-Path: <linux-kernel+bounces-106031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EE487E7E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380C61C21702
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C6832C9C;
	Mon, 18 Mar 2024 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TExQ3y3X"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2055.outbound.protection.outlook.com [40.107.15.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F842E85B;
	Mon, 18 Mar 2024 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759693; cv=fail; b=KLZhOmJmR3xKp3N7CzxmT5ftMblDBU7V8mtwK2fuV+ZCSOffESLb816iXH4B7O1MiADYKejrszQAJpisWS3FTDItfmXC+RxMYQG+aR+6spltMpWo0ljGGDanYtZS1pmedixgmqbeXdwRgCQtcObiCIdnOy2eIBNT3AAEy3HAVJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759693; c=relaxed/simple;
	bh=qJxVIWMooHa2lMaHXXqKWGahkBi/Ge8D9AK8AXFA2Ho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=odt0+PRVEMtKBF4KFjnuYqB571DdpLSN9O1jAXdm21cO3bAVaQ7u8EGNf9sFQFSdZaPR+j4nrr4Y01awhtdjjvI4D9gslSaVSL1H+uHExOfi27UTHVw8wQT+vxFujS5rwgUXcxOeoJIMBTqBEIveSNHBKKT5tUu9xKCmHio3O6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TExQ3y3X; arc=fail smtp.client-ip=40.107.15.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeoWEpcE4nr+3QAuAbNX/bJsUE2pUHTfKXt4h5qkDdobh9uRcceYHb1d7tkK/XaNhWAvlg/SgmZNG35o2FBGscGgtElxun7BUhXy1yojsciaPInhULCRg420ITAiTzRRuSe6mKKHStC23KtvCAbzT03/Y0n/OPPTdx0Vm8AjmGyxsnLTbzZ42zzscAVyHA+5JDKSOxZngBpJjNLFzm612eT8Hnk4AjlMkKZi4Tc5l+Mg4wKlC/TgFtkODHX7Rfr4Ido8xjqbILQM+vxzXH/jwen15DN2ZCMjdvU8ViWLJg4eXDCgpvY3wA3U21TlfR4ic5D1GMJQ5p2VVVuJy0ivDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUKpyYdR4B5NhSf97efcUd/GhfNz0OKi6zFUy3ChxJI=;
 b=U7V4bTGsGKgQUkYvk8piimFuaq80ZDC8Q+OHFpH077eFBb/kHPJPP9srltbutzSlB6pbZ4Mz+sXXx7DxnzPygouoU52ejkgYkiqXaGa+wI1S+g9gkYu9L2Y78l6J2a9hcOk8NjjI/dBsoK1gE+M0e1GvsZt3F9SAbxmcTjWOfjLGLUMwJ2LS26QS+tEWKRelKMednE33wKIQZB3bJ1wnBGxIin1HAvZOhy5Q3UaHx7RTg95M5FhUmzSGRkLzRwdqYn+QBeOR5dmBHXhfyQRPM/Ch3fMSaA8MRmeJlOOV2c5C12Yn1/i69DSG3SDWARb+Gqx64sXRbuidPDF4IFq0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUKpyYdR4B5NhSf97efcUd/GhfNz0OKi6zFUy3ChxJI=;
 b=TExQ3y3XY7c0n4W+yICuVISJfPfQfdScsl5teJKLegeSYsOHv8X5fU5mbGOIxH1tcDHZHNwVQdOjML98uFwKypSDTfrZ91gH8hmJF6BIu1DpAhbCiHCc/HpyRcjMyCmMuoOKLtNJUsxG6IW+I4dy3HBeNQL/+4aUF2MwtBzJWww=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7007.eurprd04.prod.outlook.com (2603:10a6:803:13e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 11:01:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Mon, 18 Mar 2024
 11:01:26 +0000
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
Thread-Index: AQHadhHzV0Q2ZMhJLUKmpuh6Q87XB7E8G/aAgACbUACAAJKogIAAA6Tg
Date: Mon, 18 Mar 2024 11:01:25 +0000
Message-ID:
 <DU0PR04MB94177A4081547764F600635E882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
 <20240317155911.pdc32nsyxcdhs2t7@pengutronix.de>
 <DU0PR04MB941725052D5E3EF78F67A1C5882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20240318095959.v5d7qeoci5v2dtkq@pengutronix.de>
In-Reply-To: <20240318095959.v5d7qeoci5v2dtkq@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB7007:EE_
x-ms-office365-filtering-correlation-id: ebdedde8-32cf-4a11-4da6-08dc473ac193
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cmwWAuaupSnJvxwWZ8sHxYYWGCrBsOW8TWqSus7kuX+DCwZWH9mR33OD5YSiGfUWMxBA8PNpMZEF+o9EOTKTUOgaRQFJ6HXN0EZIivalIrTIlQvbWqpIg1krrjgFkm/8qj8JuSvbPmRhSZDLdbhfEtQk1ks47UdDPwGxZQ82gK7sk6Ydehro5SofcLwfKZzNi4n9iIW4WT4DTyvZgOHub0L1jChs4F0DwkpI3HzT9avtN8wrNK8kNxY11RyEZVR3eismBnYdj7709Ax71+DQDorQ55s6EjD5jB7XsuXQnSVyZ629weJEtIfc2OlHshWfYrKid2tnzZe6PtKsRdUEfPNgclP3Odszkne71Ibg2OeORmEGC/9saTHEYoFNNUPNy8g8FFOzcu/Eu4QyEO074i+e4gGWa2EtqUS9suO4wdwPlGdD61zr22qoMasKuBrSoNtHAdyTIGHs+Ct+6VmqCN4JnPtPjHOmfZwwnqgr8UGSJC96lccNuf/VqO4Gy0JGLDIqS760cYs+d1eS/HmAJB/Je6M/XYcF9XuPIkHtARvrECuheCVTPHlFhEjJYPKg9szKDQgNiE+rqAOgcCD87kHAojVuyVkyljMfF0RtwQc/9KaOfJFmDx7C6eSwnhj4FrW9wTDE3wiWMbsmvB5k+6k/AaxdgYXRoNjC1ZHYVk4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cBkClrwd1GzIsQRvqmZApFVR7jxd8VQmLF/lOihrxNO0fEhOlt6NhlbO/r83?=
 =?us-ascii?Q?PeUqQJmq+SsMAbfUobmpim7gPjAiKX6lOBtv2B4tQ4oLG6p4MDxcsy3JG7uB?=
 =?us-ascii?Q?seHIyOFGnTyp6ZzxLsrS76rDL/V1JLuzMoDQBisI7mqWnH4FvM/le/LWD4qT?=
 =?us-ascii?Q?6ibcrPgdT17v0X1MLt/cN9S/BwTWCG5Gm2JthN98oIHMSVcthS1R8HXCV64C?=
 =?us-ascii?Q?2pvGXsbYEudryszllYi3dMnth3Jt7YEqRlD4RTFRAcQfBAv1fDIrDy6/amF5?=
 =?us-ascii?Q?r4yZy6Wv07vAQYkiVjIvAk8EtyFtM7daPSR9k4dZpnKyfKVA9ILawstjiLyT?=
 =?us-ascii?Q?RrCoBnfkc8k5P5hW9NkFu/y39unjau5803DxwDT/BQXQyOrH8LjjScRH0m/J?=
 =?us-ascii?Q?X5HgKxLiebq/H9m9NdnpkOILM9OvH/GW8w+7iRutcL4XDT9eAKAoaaZCBAEz?=
 =?us-ascii?Q?lYpsTSdJvLFps+nFGCXtxAJffqzHl52OGlKT4NSgx7UMTty1ApAFBf8MAm97?=
 =?us-ascii?Q?6TWZ9FKH9pQytOFDaZ46DHUDlGQA7E3jh+kEZrW89MnzUYcWIxuDzGsB3Djh?=
 =?us-ascii?Q?H+cddEtATXsFMlrhE/2iXyWqwCskd2ST38zLP1yGG5sLnC6pSkeNG0910YiG?=
 =?us-ascii?Q?rd/FVnySXyYhMFil6XCKIw86/8RFzANgin8r527xIplhRrS0kmHwevbiVLfZ?=
 =?us-ascii?Q?78Nq9kJANWbGCf22FB34M7NGn9CQvx2baalwy2Yz5HKfuVXRFqnTK/5BZ0TM?=
 =?us-ascii?Q?/hCjVaCvKqrRuDmCEu1ZZhYQqWjb7sBiaP1bqxr6pnEFy5tPqFQdT3yG+1V7?=
 =?us-ascii?Q?4NDpndldrAejsBvE74PNrhqK3hWetXgEBmCBQf7ucWl11OW4Z+B+FlN5w+ok?=
 =?us-ascii?Q?kOwQy/+3jYU7ESJNmCB04d1zvXhSZc5KreqFGQlhhh1nuUJFcjfjpxhPVtb+?=
 =?us-ascii?Q?F8CT1CSsFk/+7u0cFmmawXnC/ICMT3GkT8mJdU1oZt9I1E/ILabEELj5QJm9?=
 =?us-ascii?Q?jClkbI52oVEn1oyz1EjgdVvpljXWY7uxT7cu//FVuWwE961KYDS2JU2vctpQ?=
 =?us-ascii?Q?+tuon0Oi6AuSDZnKHGWJJZto0bDdEr5pGQa76E3xU0xRAa1UhdXvrwUsntEi?=
 =?us-ascii?Q?dVDdZjh495q+3ueWcSpfyJf4G+n1dyTSTRKZmrYGnfYurK6r5OLzGKPEYb6R?=
 =?us-ascii?Q?8zrJ/Cl/fP8pD5rCFvyKJb3i4LvZIHygrEWDYI9+4Yl3yqK6WUUfmyq29Esi?=
 =?us-ascii?Q?wDH2FdYiQyQHyqEmDa4/ykdNP/eK5Ndb+am2vPb4+7ZZP3afBNo3NBm1YiFD?=
 =?us-ascii?Q?bl1WHEIm9YAGSgx+a2pJx1z0l8cAhmsgR+lL/B6EXKplV+CRAWbUC64Hz0/l?=
 =?us-ascii?Q?azKZH1zzmRbhGWFWBM/UKPmLXtojqLQYVxIXsi4CFvLGs9PYI9vCuvSd2gsr?=
 =?us-ascii?Q?2PM5tsBWyECEEyMBzwSH1SxhuJFuJK50ZwXOWOKAzLTHT3gk3LHZb0L7xNBn?=
 =?us-ascii?Q?Gygcbl3jz0VgqsBvD9asozqOuC6rFsxxC8kjIRat3AzQPcWnCYE7p4umseDb?=
 =?us-ascii?Q?5KcqefVPo+KmZuyKZIk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdedde8-32cf-4a11-4da6-08dc473ac193
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 11:01:26.0472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTUAs3czwH+t9yO2QLHhDyl+nTfot1wfzeB5DhI2jFYN6UsCyTMRSl324Nx6vggZGgLYxjAu5VHFNtLcSFy59g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7007

> Subject: Re: [PATCH v4 0/6] Add support i.MX95 BLK CTL module clock
> features
>=20
> On 24-03-18, Peng Fan wrote:
> > Hi Marco,
> >
> > > Subject: Re: [PATCH v4 0/6] Add support i.MX95 BLK CTL module clock
> > > features
> > >
> > > Hi Peng,
> > >
> > > thank for the patchset.
> > >
> > > On 24-03-14, Peng Fan (OSS) wrote:
> > > > i.MX95's several MIXes has BLK CTL module which could be used for
> > > > clk settings, QoS settings, Misc settings for a MIX. This patchset
> > > > is to add the clk feature support, including dt-bindings
> > >
> > > I have to ask since there is almost no public documentation
> > > available yet. The
> > > i.MX95 does have an system-controller for managing pinmux settings
> > > and power-domains, right?
> >
> > Yes.
> >
> > If this is the case, why not making use of it via the
> > > standard scmi_pm_domain.c driver?
> >
> > The SCMI firmware not handle the BLK CTL stuff, but blk ctl stuff is a
> > mix of clk, qos, module specific things. It is not good for SCMI
> > firmare to handle it.
>=20
> Currently most of the blk-ctrl users do use the blk-ctrl as power-domain
> consumer, except for the isi and the audio part.=20

Yes, for i.MX8M.

So as I said above the
> scmi_pm_domain.c should be able to supply this. The audio blk-ctrl could =
be
> abstracted via the clk-scmi.c driver. The ISI is another topic.

Pengutronix rejected the efforts for putting blk ctrl stuff in ATF for i.MX=
8M
before. So we take the kernel power domain approach to handle blk ctrl
clk gating.

>=20
> What you're are going to do here is to put pinctrl etc into SCMI firmware=
 and
> power-control into Linux, which sound to me like an 50/50 approach and
> IMHO is rather sub-optimal.=20

Now back to i.MX95 which supports function safety.

The SCMI firmware only handle CCM/SRC/GPC for clock/power, it not
handle blk ctrl. The BLK CTRL registers are not only for clk gating, it has
other module specific functions. Moving BLK CTRL to SCMI firmware,
means linux accessing module specific functions needs go through
vendor SCMI protocol. And BLK CTRL stuff is MIX level stuff, it is not
SOC level stuff as CCM which is system critical resource.

(BLK CTLR, I mean non system critical BLK CTRL, such as GPU,VPU,DISP)

The other approach is to let ATF as SCMI server to handle BLK CTRL stuff,
But I not see benefits.

To quote your online available fact sheet:
>=20
> 8<----------------------------------------------------------
> ENERGY FLEX ARCHITECTURE
>=20
> The i,MX 95 family is designed to be configurable and scalable, with mult=
iple
> heterogenous processing domains.
> This includes an application domain with up to 6 Arm Cortex A55 cores, a
> high-performance real-time domain with Arm Cortex M7, and low-
> power/safety domain with Arm Cortex M33, each able to access interfaces
> including CAN-FD, 10GbE networking, PCIe Gen 3 x1 interfaces, and
> accelerators such as V2X, ISP, and VPU.
> 8<----------------------------------------------------------
>=20
> 8<----------------------------------------------------------
> HIGH-PERFORMANCE COMPUTE
> The i.MX 95 family capabilities include a multi-core application domain w=
ith
> up to six Arm Cortex(r)-A55 cores, as well as two independent real-time
> domains for safety/low-power, and high-performance real-time use,
> consisting of high-performance Arm Cortex-M7 and Arm Cortex-M33 CPUs,
> combining low-power, real-time, and high-performance processing. The i.MX
> 95 family is designed to enable ISO 26262 ASIL-B and SIL-2 IEC 61508
> compliant platforms, with the safety domain serving as a critical capabil=
ity for
> many automotive and industrial applications.
> ...
> 8<----------------------------------------------------------
>=20
> To me this sound like we can turn of the power/clock of an hardware block
> which was assigned to a core running SIL-2 certified software from an non=
-
> critical core running Linux if we follow that approach. Also the
> SIL-2 software requires the non-critical software to turn on the power of=
 these
> hardware blocks. Is this correct?

Non-critical software not able to turn off power/clock of a critical resour=
ce in
safety software domain.
Safety software not require non-safety software to turn on power/clocks.

CCM/SRC/GPC is handled by SCMI firmware, agent w/o safety needs use
SCMI API to request SCMI firmware to enable clock/power for a module.
The SCMI firmware will check whether the agent is allowed to touch
a clock entry or a power entry.

Regards,
Peng.

>=20
> Regards,
>   Marco
>=20
> > Regards,
> > Peng.
> >
> > >
> > > Regards,
> > >   Marco
> > >
> > >
> > >
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > > Changes in v4:
> > > > - Separate binding doc for each modules, I still keep the syscon
> > > > as node name, because the module is not just for clock
> > > > - Pass dt-schema check
> > > > - Update node compatibles
> > > > - Link to v3:
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> > > >
> lore%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C1e1d2c2cea9448b1bc
> 2e08
> > > >
> dc47322ce1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63846
> 35280
> > > >
> 23000120%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luM
> > > >
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DbcZKZGSM1
> 7Nv0
> > > > Yju6wZu1mSt8GGZH73aAkj9FArP8O0%3D&reserved=3D0
> > > > .kernel.org%2Fr%2F20240228-imx95-blk-ctl-v3-0-
> > > 40ceba01a211%40nxp.com&d
> > > >
> > >
> ata=3D05%7C02%7Cpeng.fan%40nxp.com%7Caad977d7e4f94c750de408dc469
> > > b3952%7C
> > > >
> > >
> 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63846287969085566
> > > 1%7CUnknow
> > > >
> > >
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> > > WwiLC
> > > >
> > >
> JXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DM%2B3lDY9BKvW0nHv4mtvi82RA
> > > 9IvYyz72TCbL
> > > > UpiYcG0%3D&reserved=3D0
> > > >
> > > > Changes in v3:
> > > > - Correct example node compatible string
> > > > - Pass "make ARCH=3Darm64 DT_CHECKER_FLAGS=3D-m -j32
> dt_binding_check"
> > > > - Link to v2:
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> > > >
> lore%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C1e1d2c2cea9448b1bc
> 2e08
> > > >
> dc47322ce1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63846
> 35280
> > > >
> 23016027%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luM
> > > >
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DOTCEsnQm1
> PVPa
> > > > HlXr84xZtmkg1sbtz1TIRFSURLzcPM%3D&reserved=3D0
> > > > .kernel.org%2Fr%2F20240228-imx95-blk-ctl-v2-0-
> > > ffb7eefb6dcd%40nxp.com&d
> > > >
> > >
> ata=3D05%7C02%7Cpeng.fan%40nxp.com%7Caad977d7e4f94c750de408dc469
> > > b3952%7C
> > > >
> > >
> 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63846287969086560
> > > 2%7CUnknow
> > > >
> > >
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> > > WwiLC
> > > >
> > >
> JXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D4leg49tKhwUMzvD5wlnvgVc7is%2
> > > FGMNvpYr6A
> > > > %2FAf3OU4%3D&reserved=3D0
> > > >
> > > > Changes in v2:
> > > > - Correct example node compatible string
> > > > - Link to v1:
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> > > >
> lore%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C1e1d2c2cea9448b1bc
> 2e08
> > > >
> dc47322ce1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63846
> 35280
> > > >
> 23029152%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luM
> > > >
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DNRw0LCxEg
> %2F8
> > > > C7WphEWYliUSufjDHQpl1qz58GTZOYxY%3D&reserved=3D0
> > > > .kernel.org%2Fr%2F20240228-imx95-blk-ctl-v1-0-
> > > 9b5ae3c14d83%40nxp.com&d
> > > >
> > >
> ata=3D05%7C02%7Cpeng.fan%40nxp.com%7Caad977d7e4f94c750de408dc469
> > > b3952%7C
> > > >
> > >
> 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63846287969087217
> > > 2%7CUnknow
> > > >
> > >
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> > > WwiLC
> > > >
> > >
> JXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DUuD5MVPFgBqwftuXCIXB7SeGyu0
> > > NWPbwY%2Bvy
> > > > ChFLyVA%3D&reserved=3D0
> > > >
> > > > ---
> > > > Peng Fan (6):
> > > >       dt-bindindgs: clock: nxp: support i.MX95 VPU CSR module
> > > >       dt-bindindgs: clock: nxp: support i.MX95 Camera CSR module
> > > >       dt-bindindgs: clock: nxp: support i.MX95 Display Master CSR m=
odule
> > > >       dt-bindindgs: clock: nxp: support i.MX95 LVDS CSR module
> > > >       dt-bindindgs: clock: nxp: support i.MX95 Display CSR module
> > > >       clk: imx: add i.MX95 BLK CTL clk driver
> > > >
> > > >  .../bindings/clock/nxp,imx95-camera-csr.yaml       |  50 +++
> > > >  .../bindings/clock/nxp,imx95-display-csr.yaml      |  50 +++
> > > >  .../clock/nxp,imx95-display-master-csr.yaml        |  62 +++
> > > >  .../bindings/clock/nxp,imx95-lvds-csr.yaml         |  50 +++
> > > >  .../bindings/clock/nxp,imx95-vpu-csr.yaml          |  50 +++
> > > >  drivers/clk/imx/Kconfig                            |   7 +
> > > >  drivers/clk/imx/Makefile                           |   1 +
> > > >  drivers/clk/imx/clk-imx95-blk-ctl.c                | 438
> +++++++++++++++++++++
> > > >  include/dt-bindings/clock/nxp,imx95-clock.h        |  32 ++
> > > >  9 files changed, 740 insertions(+)
> > > > ---
> > > > base-commit: c9c32620af65fee2b1ac8390fe1349b33f9d0888
> > > > change-id: 20240228-imx95-blk-ctl-9ef8c1fc4c22
> > > >
> > > > Best regards,
> > > > --
> > > > Peng Fan <peng.fan@nxp.com>
> > > >
> > > >
> > > >
> >

