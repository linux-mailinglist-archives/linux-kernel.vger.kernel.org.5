Return-Path: <linux-kernel+bounces-87745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A1F86D870
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5621C210F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84982C2C1;
	Fri,  1 Mar 2024 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hvCzkK1A"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987AC12A;
	Fri,  1 Mar 2024 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709253695; cv=fail; b=qQGZ/aEcbda2ShDgWFXbEvgJkO2tRuAOv3q6BvHEAk184yzX70nH58CovujZKBW8NdFlNfd8wsoNpJJtwDx86/K3JBAf1IGXC2k8iJjLFiWiQwwJr16ZVi1MVqOhLrTs90NUOBiAqDVyGxYW/P6Qzn3RsbspqLYWBb84qMhECbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709253695; c=relaxed/simple;
	bh=4jpp2BlOTziBn6d0opJxIC9ulZdcfUciduLduIymFVE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LXE+ZqcP3AHJeMXKmNf1dfUTw7fopXGOtMOKLhSPTR6K17Gn0dg7ejyxnvyvDUF9oJBB8hwFyZggHISZCFvNgjOeWHCf+VKMegwGn8y6OLdjGj9W8gwX4b/vXQzuPNArdpyMw6W2JzyUBYCZVcJpAAZs5/YjEUSPebDFGKuS5GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hvCzkK1A; arc=fail smtp.client-ip=40.107.7.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSiMmiN/ghY9IQh7Po8H+N47o+ezVFGeR2dkylE67dI74/dJOIukoIFVYEvtGjGY052HMZEvdRdbg9yENPn5qZD3NwffRgEQpLboBRKx07P3OJr86dfrrxwWJaIXF6dIMmTanCD/6EOUDGuG2BlFESgcNbluhJ2k8DuP2mbGK50K4KoC7jqNavptoea/aNlrnSNwMzeAZpzYN8Alq/C7OSWYPZ4B+cgGl8Q5/53QF0XpKAfDVPHhJ2m4dtGmO68WHHxJo3LXP08QMwPh/5oYLu1GOm1a57STYq7USfls8ky8Q+wdu1IAwt8tCCZKb6kyaKyMRekDs3zYxsU6QAEz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jpp2BlOTziBn6d0opJxIC9ulZdcfUciduLduIymFVE=;
 b=JN8PDm+OM0Jq3dpTLCzOZIynJbZ/qiLNoIcTuD0qiNMqaTyrDIP0SexHNTKXX9s1ZXNKoREgsnskl+Tv+mvFyg4yp83My0GRWvAhKvCHwIGSJ/7US3P9qRX5OaIRPIFvchI6Ht8htma9OTs+aLTOpj+Urah0233JjFu1HrfDaBZbl7Rg9png8tc5LOzM5f4s0oLBzR5gPUDsGPxwX/JxRJKUNYmrq0yjzalDfUnSBsuHEyou+N5KKNMZQAqWWwJONihNAwm3vQWsxO8+cyN/ZCF42mh4/dko/gB3tN5Fr1QqyxRdCzlZzVGWnqAUVJ083VgRYuVnyObYhMyuJrN7gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jpp2BlOTziBn6d0opJxIC9ulZdcfUciduLduIymFVE=;
 b=hvCzkK1AAMw5VG7TLT7i7zOPs9IAayPoen0VifExZmr0KfpweA5+Jj+W4nsM00Qib+a5zwOBvl3B7Y6pgwIuj9jkfURM1kr1ZJGgmuqJ93NPVWPMdc12rlG/i0MIMQ0FYnHlE93G5ci2fSgZ0kik2dMIUgoLXbKNCCLeAcmTZS8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8117.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 00:41:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Fri, 1 Mar 2024
 00:41:29 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: firmware: arm,scmi: support system power
 protocol
Thread-Topic: [PATCH] dt-bindings: firmware: arm,scmi: support system power
 protocol
Thread-Index: AQHaaLLyfnmFjzyGqEimlBHwa2+g1LEcnfcAgAAaQQCAAKcG0IAD/moAgACytyA=
Date: Fri, 1 Mar 2024 00:41:29 +0000
Message-ID:
 <DU0PR04MB9417C06FD66182C705238662885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240226130243.3820915-1-peng.fan@oss.nxp.com>
 <ZdyR_MWeqOWga8iQ@pluto> <ZdyoAsYGXK9GjHVx@pluto>
 <DU0PR04MB941710FB1400D0A17F99B6ED88592@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZeCNyLxQOIazc07h@bogus>
In-Reply-To: <ZeCNyLxQOIazc07h@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8117:EE_
x-ms-office365-filtering-correlation-id: 03d4d220-11fc-4d47-624c-08dc39885599
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Q9a8au0LE6+WOR+Q/NnYw1jY7w+mTs2ggWmORu2vbCjymrikB0iKHI7d2vSe0kaiK10IMjczl1xsg2l2HTtXIKeGM490TTNk3gOeMKzYG1PjH5iCrddwQmvKBOfUZykevWcJiUkCyWu5xEaaHoCVe6Xwsuc49a50kBlYqd/i8r6Gwf76TB8v0FLLmhIt34ZYbPVSWbcfiEYAGq3kLaDZOKRKb6dWQ7rk6QK16w5EXoSN4i4mbXm0eENJzO0tDNRKVmuxO1+UkCe14ZvQMtuLGuVzwsuHHHSNQJlBq5BYmy2Jfuai/tVH24MVm0xkXxDZSRm+lHT2isoOmimh7QZqtszpFe6VGcyywiBEscQRXNHvwOT3GEceEDmTm8s2j8XQesKVtf6+74FH3tzJaiVIyfGyteb4/6Th4rYMwGvdGckgErNxoLU4YgTejWytk0I2Nwe+H7/opvcHIBMrLXsg1hSkvkpLtsD0uehzEJDuICudFss1nDLudzCMRfmNRkEm1K9/VGtfvo5Qv818D9493A4X+q71lby/tqt3DOOHmxG8/grPAztNLVv3bycic0eawzOS27U7pogsyV+/PZb5hOYx+dPSer4N41RdvCGDsdJ8HgZZbIwk00FNStvVRGFJ1ZoCqqbxLimGt25XLQr2ZZ9TYxnU9VBPtTydH7vRSd8+XmU5xA+IFychvhDbPowtFh8L4LyteHxf1OJyk6/Z3bOjOkNtdsqy9IJSZr57SOI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MCKrCOWFOUuZf2jI4bmPxmLv2P/mBsEsTbW8v2+PIECi0VGZZA5ukI8Yj6vm?=
 =?us-ascii?Q?wq4TTevIT4MDFCfctH7802G1hbSYraKTce4DW/p2t4pkKXVVKnfUA/geGVGg?=
 =?us-ascii?Q?GH7YgqyVzltkSz8qnUSr7b5luveUt0QYFDYXCaN/kiqyFZr3kAzOvpe56HS0?=
 =?us-ascii?Q?1rI/NE7ebS18qBzH+M6lkUeyW+krf235juZB+aHUI8uupSo9DPUod/XUkVTw?=
 =?us-ascii?Q?Pl7sEw7lxlSFFhCb23oKMpYS8zPtoj/0BBK85Nsz+s5kFYnwvgC8AxL8c6ja?=
 =?us-ascii?Q?PTTHZDGqRriV3P1Z5XqHqsWzEmsfIjL6ElCyFd0MWp7T5927EKrhtGFU7TWi?=
 =?us-ascii?Q?UP0JkN5tEUNOrSKB7KUBWMBMMwG0TCq4gLPw8E89xqOoSCwFxFZ9C1QDxhRE?=
 =?us-ascii?Q?t0yoPR8vJyGV/c+EyjRceRt07thhzK8gRJgkcwhtNwqBlR7febHF0B+Haj6n?=
 =?us-ascii?Q?1x4pizn3GjYGa8nAamEtZeSIwjuveBNjd4pFeDzmqcdKWOpnKr5epo9mk0xk?=
 =?us-ascii?Q?f0v/gAARk4PiiZVmfinZM4jrReZo8tl93/wbjxXlQ/j8B6TaDZio3Jveo/eu?=
 =?us-ascii?Q?k3IOZEQRSRO2ms+XUY+2WGI+WAjUpKngh7ruhPJskizafYgEPXH42I8SJiPO?=
 =?us-ascii?Q?PKzmMMurt/dV+7xzIq+z4EQkw+BRqzy8FaAJN/NRCjYO+TTI5KxM0i/YoXiJ?=
 =?us-ascii?Q?kk8CqaGfCQBIavjGq3HXOylXXM4wgfzkwRH3DW7uMpGqbT/VpNKJBgFZQ22C?=
 =?us-ascii?Q?AKi7Gv1ztkRcKvDewV3b+mlAUJxSlNHgBAYZQZG7wl1KAEvwalm/eI4x0hcx?=
 =?us-ascii?Q?o10DdlhrOgWPp7CvL+2eJQF9hO/+F9ULtK06pbb+U2IYXFZbHRHe9oHphOth?=
 =?us-ascii?Q?XnZ/HjNKf1B1oUt3kEACnSgi6FgfJutRvDLEHTrhOKhuxaJcFOBOhla7nhfe?=
 =?us-ascii?Q?vWWP+lSIPaTEejGB3aZQ5xyXeTvafw61i5/Z5Sc2zU2WTtF2SrQNkunFrQ7T?=
 =?us-ascii?Q?b6+6c6OX/+pOMcAZ7adwy7nnX/KcG3hy2UFW3COGeHNSBnPEAxExO8W32QGM?=
 =?us-ascii?Q?B/QHcLA1hpjRs7hU625zMmmvq4r6iNDroGP2xnH4vEY3bL65vButAAz6fLXD?=
 =?us-ascii?Q?2k2JXsyOJz8kUJs/rCj2ResPtioDGhyWbo03+GVuVGZ2HpiIi7vqp7UPVlAQ?=
 =?us-ascii?Q?pGX5aHXb3sK7gD/+WHV48uXCJ0CmTDFZRUh7UNjCVrXtNQyhAByyivaJS/Bu?=
 =?us-ascii?Q?0bYAjOUsVJUxJ8wlMdddHkg7Mzv+AAkU4haFFXgHUckmu+iysqToKJs7fF56?=
 =?us-ascii?Q?092Wk2vlpVar40B0fjwZ0RbWpBes9/Wcqf4j0HQuHGBF1KFjqfQ46CbmihCG?=
 =?us-ascii?Q?IREyRYseg0Z73j0NssmGedz2DhAe75tX/fxda4KqdeX0LXfbQ0jLmXSqIbXd?=
 =?us-ascii?Q?NS1h+QzcTpzcBva/2Zg9dj5kysKEVLqmrA0grtaz7NiqIHPruawslGJnKXSe?=
 =?us-ascii?Q?UZHtT5VzsVmmai3Ia5JbfLB/Rhjc1qo4m8lrwMiraa8N67i3CQhZPSRHTg9l?=
 =?us-ascii?Q?QNdRs95ESrcA9DVyg+o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d4d220-11fc-4d47-624c-08dc39885599
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 00:41:29.4077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tU2EGMqm9TNG4Lmt6I7RGwLz/ddVSVcLbShv4UAzEVIqIJo+/IWDTYV7cOL73BYdiNFL0ybcaWWewnONam8AOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8117

> Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support system powe=
r
> protocol
>=20
> On Tue, Feb 27, 2024 at 01:01:41AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support system
> > > power protocol
> > >
> > > On Mon, Feb 26, 2024 at 01:28:31PM +0000, Cristian Marussi wrote:
> > > > On Mon, Feb 26, 2024 at 09:02:43PM +0800, Peng Fan (OSS) wrote:
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > Add SCMI System Power Protocol bindings, and the protocol id is 0=
x12.
> > > > >
> > > > Hi,
> > > >
> > > > yes this is something I spotted in the past it was missing and I
> > > > posted a similar patch but I was told that a protocol node without
> > > > any specific additional properties is already being described by
> > > > the general protocol node described above.
> >
> > Without this patch, there is dtbs_check warning.
> >
> > scmi: 'protocol@12' does not match any of the regexes: 'pinctrl-[0-9]+'
> > from schema $id:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi=
c
> >
> etree.org%2Fschemas%2Ffirmware%2Farm%2Cscmi.yaml%23&data=3D05%7C0
> 2%7Cpen
> >
> g.fan%40nxp.com%7Ccac77deb5f6a4b20460a08dc392ead40%7C686ea1d3b
> c2b4c6fa
> >
> 92cd99c5c301635%7C0%7C0%7C638448119832543335%7CUnknown%7CT
> WFpbGZsb3d8e
> >
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C0%
> >
> 7C%7C%7C&sdata=3D6MldIOUQ4hxn%2BRffwJJJ3jxXXtHCSxLUOa4JMWB0htU%
> 3D&reserv
> > ed=3D0
> >
>=20
> Why are you adding protocol@12 to the device tree ? Does it have a
> dedicated channel ? If not, you shouldn't need to add it.

No dedicated channel.
The idea is we have multile Agent, the M7 agent may ask to shutdown Linux
Agent. So the linux agent need use protocol@12 to do the action.

For now, we have not finish implementing this in linux side, just add
the node in dts.

Regards,
Peng.
>=20
> --
> Regards,
> Sudeep

