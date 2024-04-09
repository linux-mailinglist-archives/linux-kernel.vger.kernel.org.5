Return-Path: <linux-kernel+bounces-136735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF6789D7BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1581C21A69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217D386269;
	Tue,  9 Apr 2024 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ChDOpesA"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2131.outbound.protection.outlook.com [40.107.21.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8C784D02;
	Tue,  9 Apr 2024 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661578; cv=fail; b=SBCQyj2Yba2vfIJHZLBYmIlR+dzXPJacVAPMqg5Bi/nvaHGzBu2UB90BDgGXXq1v4Y/cHSffGN89V/vjPuHKouDM/UpqUMBqqDZNHN4bw+8Gp1+6ohZoGl0hEgi8vQBErbishQ14Nttf4vZLz1ZdA0Mx+wzgRLFNrk69KLQ7Ty8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661578; c=relaxed/simple;
	bh=UjHjeoJFSB5i86ViMuyxqEfU9RiEfr1kk5DuFPn2jQI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tl9L145Sy4EDNCyx7ojjImBmAlzCZzSMRA5QMqQTOIfWCeTBM22w+3pO3/PHyj2qUbVufNYwPKe7R9mMSmsj8rxKVN8Pldu+zKhRq2QBjNwHE/6ip9WhVwX39e21Ddp4juWUHWRUvBEPO9mrkvNKK0J7Y1/YxS1wmT+bgStGSMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ChDOpesA; arc=fail smtp.client-ip=40.107.21.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5PJdO5pDE3brDF+NbIrefQKF39BuGmvTIGkZ4VIDnSyDJc6XcG8U/qbcju/1iEd/SeNVCrlsVo2JMe2fjtZnWApNkyQTeM0ZmNCoANgRJa0l3mKnyE1PPuvoxa+GUbrIE9IC2ppyZvi9OdyRGPTofb6Gg6QjLmUHS+jJr6oY2WpaFqwcp96HkgXDa6/Wd3XMvk9rxeV9RSe7fk4k2Z4yPt/UCnioC/WdDXQ+MRIUV9u/hTE0rohSWx5okP0z4MT09ufiqFk0Msk5BUZEf3G6XTU7FcN0T9fvKMfNthD2M1hGZo3mGXLfHOK7YQ+6aXQqFfcK16BrymVO7LhSLWMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzQLwkw1BpD0/KtTAFzpOXAyCAgJmHdxQ5IgWr31vWw=;
 b=Jyb88XHKRkARD+0KECHXXZoNetNaN5x80vnLPdiJy5o1Eg61Kxqf8bUSNuMP7eMal5avngCvsLddAg2Fgp7Xh58moNJrHK/PzIaeZo+M+RziuOKF/fufU1LTcOSfdfxrS3W81QV6XCN+dWRsZlC5RrtGDlYCKeCrMAlbndeSfnEMTLgxStDYYnCnRKeBhdqehmN0xz1U+R25LeuWSMnS3+jVbnBYXLkaaLyJpuaMBqt3gE+4Dom6AwM59g8cwY0h6h+0BAlSKHQRUOsy3x5BsN5wfaKaYPnNxi8lDO7GN/wXsggt+FsadZUMzZdZRZzK4Pzs4CBfY+APf78/Rm01aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzQLwkw1BpD0/KtTAFzpOXAyCAgJmHdxQ5IgWr31vWw=;
 b=ChDOpesAJ5cKMeHCCRGeusH0Eyl8Y25naypQnDMYnYXQUts7OZ4rNi+438aXs/uMufO5/h16dz3PBy0Fzg/78r/cfjuLK5r+RTjnhMR++iUIt2pH4KZX1VinxDwml9G/E6S63gzUyhSaDSqVQ1euYtfbUGiyPbBMWJLjjowBSoQ=
Received: from AS1PR04MB9431.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::7)
 by AM0PR04MB7122.eurprd04.prod.outlook.com (2603:10a6:208:19c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 11:19:32 +0000
Received: from AS1PR04MB9431.eurprd04.prod.outlook.com
 ([fe80::95f1:f32e:75b4:1ecd]) by AS1PR04MB9431.eurprd04.prod.outlook.com
 ([fe80::95f1:f32e:75b4:1ecd%5]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 11:19:32 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Thread-Topic: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Thread-Index: AQHah1U7U7PbHuwUVkuCiXWcSbaKerFer8yAgAD57wCAAACBQIAAHlaAgAAGZeA=
Date: Tue, 9 Apr 2024 11:19:31 +0000
Message-ID:
 <AS1PR04MB9431F99D49D6A777B09814FB88072@AS1PR04MB9431.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-3-9fc9186856c2@nxp.com>
 <ZhQxu8LVNKf5QDLm@pluto> <ZhUDZGJilhczKlDD@bogus>
 <DU0PR04MB94175384AD9113AC6F60546588072@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZhUdQ6M0GkL0do_l@bogus>
In-Reply-To: <ZhUdQ6M0GkL0do_l@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9431:EE_|AM0PR04MB7122:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EDbxkKlPTLWHjPHlZWMJrKHdZDNkgaKdjDuExToRGWDIDfo5bERrz3a5nrGZX4AvtDtlrcgHRcmg3YfVMOvqSmDPFrGNSr1NeB4Zl4OB4UU5iB4eOXj5eO2kWd1qRaLVKgjn2hF+HGZHkam9DSiS7iaWYB7dz0SNAM6NGaO5CLqwQh+GBWnBChCvcVhi29+G43/y+/DEnH+iq6mJkOGP4D4WFqV2AEXN5PV4ss96kS9sub8quiM9iK4XjL/T1eqI9mi2wu9zvIdRDmdQ4DCRnwNhBrEUkBmoR6Bri1l+mJE4Dl0R+lDdqJLNxVoxYGEc84vd2QxNUmhup/6gBn/EK7aDH5nm33CZWuj6onc+5TS0enZeQ/idsej0ie8LZsFevzNuYpIcXvI2kD//Qxg7msvHpF5Ihxjue9EJH5OSgI/+qWWdzNYP482wHkW7rJ433ungosO5688SYTf1GCg14llw61LTQQ0/q4Fnv9Bnr4jWkRAihYltN2z0ybhlsRLbAySPrbchw73lvWS805G5FgFt72736fNaFiZv5uY1JksTtmBBETsF7vFGyWoUYfYM5Vm1qxdFc7u9DhlnzPPZc6xnc/fhyIGSVllcOPDBbzU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9431.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZKBVNIzXLe76WwbSheTL3pYIIIJ79vgn+o50rrNd/p/GChPIhjlEZMjMxCBq?=
 =?us-ascii?Q?27mjRsAVWSIwtuxanYvYeO4dLqwAVirEfUihvePuwHZrvuGAA9Lln1Jsc0yK?=
 =?us-ascii?Q?KoB2ohCjcDrJGQ53dRgpB4jjbSTLNzJRslfpswzTFN2dFn6pR40SlI/gKZOb?=
 =?us-ascii?Q?hS11+8BRcnXhHmRLDmn+0dX8ZrMNnK4HfHDhsoDD/sEX3UGgPG73X08EXi48?=
 =?us-ascii?Q?rESedorLhYDRLOvwUzF8z759YspMpv7mab0Vkq7Ef6qjqzc9PmtM1D0xKW/r?=
 =?us-ascii?Q?4BB4HhaSmuQd14/oIIuIiScsooJGlT2wGv6QZerpRvqBe9ERCeCQ4vpij8MN?=
 =?us-ascii?Q?kekIDpxkVzVwtkT0odhPQsFQx87igK/C6gDwr1gWQPUXxLu4omvwC5HAgL1j?=
 =?us-ascii?Q?V6s1reWyz0cSzypHLtQxANLN+/RiMa2xkpCRLnVsWoREEmUGK5Q6eKW7lHd6?=
 =?us-ascii?Q?Ktk+nOOg/Joa4oviIYLabHVIC5lAqe6LCiqvuVTwFS/I9IwKHNomnt2xqIgw?=
 =?us-ascii?Q?2NfG5AnNefLdgwIkjIK6p5oyflC0IfVNPi6KUfCgpDrMo0SC7DjH5VMVnYk8?=
 =?us-ascii?Q?dpPrr2wMbPDTTZJSvjSTWRpAWwgU1yDXdjYp32n7vZbiVAfbJXwitwD0/bYT?=
 =?us-ascii?Q?xhNCZX2MEQ3DukMhlPxoxyFXdaMMT+/H6UGsoxR8P/JzWiDpphr+hWFg5Ypj?=
 =?us-ascii?Q?dEItBRhMKGAn3tT/NbOF4bvkm8TySY6+hr3+vAKFaHbx43BzoPMlSfxb818C?=
 =?us-ascii?Q?kBCWvE2sAIe3Zps2upISlnjKgB0blCIU20VDYklQ3x4GPu1Nb+nsbIjoASLl?=
 =?us-ascii?Q?nIFRWPv01DMCipKaDczTYgMWmIRTJyDltn9QytiupXu8u6UcmYCwefrtK1Qj?=
 =?us-ascii?Q?Ekc4yYkPKnPEOt02rziAqFlC97qgrRUzF8zgOm+1x+xsFgh1WpCmj2QfAwDa?=
 =?us-ascii?Q?j+pYslTPuVceorfjljM9PSXB0Szm4SK0L3yNrBLwKRXCn8TbLT1eU3ZMyvKM?=
 =?us-ascii?Q?249FgOM+MhxS1wu3b/bOVk8NdcYWNnQsPwGerkxzh2Egk2Wmf5G+PMYLqhzi?=
 =?us-ascii?Q?yQ3jtVnvKQLGoD1igkL6/FIrmDOcuRSHOT9l4NA4Xn6SjrxLkyQh874BqTDT?=
 =?us-ascii?Q?nL7HD+0yv1NPNP5AhvaNzb1dSov/yzmjfKc7T2tmO7BF/M063bwsgcdkyWXI?=
 =?us-ascii?Q?N0hmQ6IZWhou3q8pn+6OfmYOz557qgyESIC+wNJohReVgJU8GMpQDmUohWeT?=
 =?us-ascii?Q?025t3I4AmYbLOxzhQU+gQNgOh1PXXoeR4iTi0W2rhV6L3nXQ1t/zAQaJY6N4?=
 =?us-ascii?Q?pRLNRPa9V8T4PPRJ5I6nSWM12iNWdgszPkjYEAjp7rQu2vZqs23HbE8WHcuR?=
 =?us-ascii?Q?b0L3BPJFAqwha8QWZyTXPIBAFTgyg1wV5Q22BgvBhg709obQJyhQmKMMRN2E?=
 =?us-ascii?Q?L+SxRA49KIStjvfw2x1NZKBPQTTbrg3NGnB99r/LB6BKARFFLgCJuoBNO5k0?=
 =?us-ascii?Q?mPK0cFKVWQnu23SLgR8TJu/SXAu/vy/+9W69NYRJvR65rdU9REVPekHWW6Dr?=
 =?us-ascii?Q?6y9tWgpybC7Z+0IJlok=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9431.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab4a83f-2d97-4c87-9eef-08dc5886ede1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 11:19:31.9504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WPOr6dW3xxBiYgayRxclkdAqWNm29h+EjmugiM4iawKUy58zWn7mdaEsw5Wqjtgin4UibY/JuHUU6zMEqk/q+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7122

> Subject: Re: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i=
MX
> BBM protocol
>=20
> On Tue, Apr 09, 2024 at 09:13:33AM +0000, Peng Fan wrote:
> > Hi Sudeep,
> >
> > > Subject: Re: [PATCH v2 3/6] firmware: arm_scmi: add initial support
> > > for i.MX BBM protocol
> > >
> > > On Mon, Apr 08, 2024 at 07:04:43PM +0100, Cristian Marussi wrote:
> > > > On Fri, Apr 05, 2024 at 08:39:25PM +0800, Peng Fan (OSS) wrote:
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > The i.MX BBM protocol is for managing i.MX BBM module which
> > > > > provides RTC and BUTTON feature.
> > > > >
> > > >
> > > > I appreciate that you added versioning but I think a bit of
> > > > documentation about what the protocol and its comamnds purpose is
> > > > still lacking, as asked by Sudeep previously
> > > >
> > > >
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> > > >
> lore%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C6a989d0fb4c1454e94
> 3608
> > > >
> dc5882c563%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6384
> 825658
> > > >
> 71932293%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luM
> > > >
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DOCvYPh3l94
> 0aQ
> > > > 7mbAgrfEJMhYmix9%2FUUOA6kZyZJYWQ%3D&reserved=3D0
> > > > .kernel.org%2Flinux-arm-
> > > kernel%2FZeGtoJ7ztSe8Kg8R%40bogus%2F%23t&data=3D
> > > >
> > >
> 05%7C02%7Cpeng.fan%40nxp.com%7Ce92ff78b9126447afe9708dc587358d
> > > 4%7C686e
> > > >
> > >
> a1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638482499632395762%7C
> > > Unknown%7C
> > > >
> > >
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> > > CJXVC
> > > >
> > >
> I6Mn0%3D%7C0%7C%7C%7C&sdata=3D7QP%2BkkjHA3Sa0CdcbbObGG4kgYYK
> > > XAGA2r%2F%2F
> > > > x0MogqU%3D&reserved=3D0
> > > >
> > >
> > > I have decided to ignore all these vendor protocol patches until
> > > they have some documentation to understand what these protocol are
> > > for, what are the commands, their input/output parameter details,
> > > any conditions are the caller and callee,..etc very similar to SCMI s=
pec.
> >
> > Where do you expect the documentation to be put?
> >
>=20
> To begin with, we need all these vendor protocols in a directory say
> vendors/nxp under drivers/firmware/arm_scmi. It can be a simple text file
> under that. We can see later if we need any more formal version elsewhere
> but that shouldn't be a blocker for these changes.
>=20
> > similar as scmi_protocol.h, put in scmi_imx_protcol.h?
> > >
> > > To start with can you please expand what is BBM or MISC protocol is ?
> >
> > ok. Sorry for missing your previous comment in v1. Let me write here
> > briefly first.
> >
>=20
> Thanks
>=20
> > The Battery Backup (BB) Domain contains the Battery Backed Security
> > Module (BBSM) and the Battery Backed Non-Secure Module (BBNSM).
> > BBM protocol is to manage i.MX BBSM and BBNSM. This protocol supports
> > #define COMMAND_PROTOCOL_VERSION             0x0U
> > #define COMMAND_PROTOCOL_ATTRIBUTES          0x1U
> > #define COMMAND_PROTOCOL_MESSAGE_ATTRIBUTES  0x2U
> > #define COMMAND_BBM_GPR_SET                  0x3U
> > #define COMMAND_BBM_GPR_GET                  0x4U
> > #define COMMAND_BBM_RTC_ATTRIBUTES           0x5U
> > #define COMMAND_BBM_RTC_TIME_SET             0x6U
> > #define COMMAND_BBM_RTC_TIME_GET             0x7U
> > #define COMMAND_BBM_RTC_ALARM_SET            0x8U
> > #define COMMAND_BBM_BUTTON_GET               0x9U
> > #define COMMAND_BBM_RTC_NOTIFY               0xAU
> > #define COMMAND_BBM_BUTTON_NOTIFY            0xBU
> > #define COMMAND_NEGOTIATE_PROTOCOL_VERSION   0x10U
> >
>=20
> Hopefully description of each of these commands cover what GPR above
> means really.

ok, will add more comment in the patch for the commands.

For GPR, there are some general purpose registers in BBM module that
could survive during power cycle, so users could set their own
value and use.

>=20
> > For now in this patchset for linux, we only use RTC, and BUTTON for
> > system wakeup
> >
> > For MISC protocol, it is for various misc things, such as discover
> > build info, get rom passed data, get reset reason, get i.mx cfg name,
> > control set(for gpio expander under m33 control and etc). The command
> > as below:
> > #define COMMAND_PROTOCOL_VERSION             0x0U
> > #define COMMAND_PROTOCOL_ATTRIBUTES          0x1U
> > #define COMMAND_PROTOCOL_MESSAGE_ATTRIBUTES  0x2U
> > #define COMMAND_MISC_CONTROL_SET             0x3U
> > #define COMMAND_MISC_CONTROL_GET             0x4U
> > #define COMMAND_MISC_CONTROL_ACTION          0x5U
> > #define COMMAND_MISC_DISCOVER_BUILD_INFO     0x6U
> > #define COMMAND_MISC_ROM_PASSOVER_GET        0x7U
> > #define COMMAND_MISC_CONTROL_NOTIFY          0x8U
> > #define COMMAND_MISC_REASON_ATTRIBUTES       0x9U
> > #define COMMAND_MISC_RESET_REASON            0xAU
> > #define COMMAND_MISC_SI_INFO                 0xBU
> > #define COMMAND_MISC_CFG_INFO                0xCU
> > #define COMMAND_MISC_SYSLOG                  0xDU
> > #define COMMAND_NEGOTIATE_PROTOCOL_VERSION   0x10U
> >
>=20
> And same here. Just as an example what BUILD_INFO ? There will be 10s if
> not 100s of different image in the system. What does this BUILD_INFO
> provide ?
> And why is this important over version or release info ?

BUILD_INFO here is to expose the commit hash and patch numbers.
This is firmware developer's decision to add this command, I could not
say it is less or more important.

>=20
> These are simple pointers, expect more questions like this if the documen=
t is
> not self sufficient in explaining such details.

My plan is to add only the commands that this patch use, not add all the
commands. So in v3, there will be doc only for the commands included,
hope this is ok.

Thanks,
Peng.
>=20
> --
> Regards,
> Sudeep

