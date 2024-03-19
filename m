Return-Path: <linux-kernel+bounces-106894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E7387F51C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354C41C2154C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D164CC9;
	Tue, 19 Mar 2024 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QQ5qQmw9"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2130.outbound.protection.outlook.com [40.107.7.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9851E504;
	Tue, 19 Mar 2024 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812429; cv=fail; b=D+Pyy323erKhSE65Kb7wbWoEOIZvTl6AdBRX0+fduuFJourv+O7hDZWFO5z0glMCIGF6EXsJsEiX0SYX6YTlj3dNB2RkaEXtWTlFw8x9aTHxoxUOqkxFiOaEvp0PWUTf/vBGpu1pVkBMDLD2wjLowHbpyq+HfEMgAfw/ilPkABI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812429; c=relaxed/simple;
	bh=GnoLhJyR0iesly2dv1uybV5hG44Ge4soDrEHq14375M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H340gFYOoF7vTv61Mlf9xucnMouwXrRFbIKgOD4lJR6k6M1zpbWef/kjK78/HywE68Is41t7XE1GQbRSSqmVuFJfqCdFJeDXR1fHvNBbAb91z0wYva6QVs9/lOmduNV1axnvGVjP1JMHjiA0nSI/6wj6a3GnK8RPlTqEEAQgZyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QQ5qQmw9; arc=fail smtp.client-ip=40.107.7.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9XgiLd+s6qMlv5LY0C1k8R/zvt8e8KBjvhxZsq4vTtkQt2SdWtPszZ7J11w2+SL2hJoYLGOOtUoPozNeTgIf5sfNsxD6SgRz2eh3Fu9mB/w/9m/IyC16/SuROQ0Szf/XD3wYiQ8VnumNh5OK+EElPlqEM7x6F0LSuErOdX66VZurK5lVp5pHRnP4vY1F8yTpFhVJt2Nhq31GVT8LeQVJ+BQj9aZfjc7T+6EVF3js2eQrtZ+5S4jDff6GeOg/N/PhusWKfrVPt7krPyaGdv39QEo7fys79eEC/PQ5weg0eRWvRtdVABl8NAKaXBqhq6TKdf9RYsfEHYU8fd95tUTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnoLhJyR0iesly2dv1uybV5hG44Ge4soDrEHq14375M=;
 b=ZNy9T356uUdy5t36DO6LBsPszzxjzoGkaAoW+GdFBDj4TsoUP8seGo7rqneZ+0eFkmuh5/+5gvLumls12zWtb0D0CAkNyjr0WhpdGlFrdOj37B4y2GWU50t9ti1gJqHPIi4dlE+6X7qsKDxQQP/fiVCqkxNK6+FfB7PamZ2nJoNqqC1grZrd3tUB4Q4amdDSWsdwKwwFUp0p2Ydy5OqKaYHi0YyvMm+Mb/6/BjN9vmcPcqWrYSsdHZZCnpl2cCqDQB3pkk11hB1K2j64W2Pl518eDl9uvnFsC9TokU94W5Yjph7M6CiYG+iprKdBtzRhCOgDcmnKqf7aQErwrlJNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnoLhJyR0iesly2dv1uybV5hG44Ge4soDrEHq14375M=;
 b=QQ5qQmw9Wp/qPLA0Uv9I3ukplznT5BlERQHs27kig98lDDEWJC8ggcnR5tfKrx0/ynIjaJf28l318BXV5IzSIW2LznOxJyxyn8xWKhIQP1XiaoclzXau1ldQM+hj0MPZ5RsuxcOeWdZyPMNhv5qjW0aCIBBB3X4VnRRMjj5/Yqg=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 01:40:24 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 01:40:24 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Kalle Valo <kvalo@kernel.org>, Francesco Dolcini <francesco@dolcini.it>
CC: "briannorris@chromium.org" <briannorris@chromium.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, rafael.beims <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index: AQHab2onJLj7by1TDUGmc5gbcJq9YLE4nU6AgASwFVyAAQ/s8A==
Date: Tue, 19 Mar 2024 01:40:24 +0000
Message-ID:
 <PA4PR04MB9638820A9F4074F03F026B89D12C2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
	<20240315094927.GA6624@francesco-nb> <878r2fevu5.fsf@kernel.org>
In-Reply-To: <878r2fevu5.fsf@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DB8PR04MB7001:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 l8QlYruWGQ+XyI8vPebdTaYgL1dEg/U8bX4XFTBpaPXZTTDMcVhegqP/5TZB4M8Q+9eGNmepV6X1dVNgcCU4cFw7MzCHUGSahILQTfZ36AB6CJgBcg8gnG5gbosfBK9o9rPxlUYOXY3cMaGP8CMwIgKcmn+9s9n7oQISnIY3i0suteEBkmY+ktoK6IIFGVwBaa38YUMnAdY/8suiTYynhLxjMWxUrmjLvZNiBKAcnD0zFR5WUBQlrYtvioRiNFx2kQma0qm3xjv4+9SNTUbGQsGjfUejmc23ZefHjVoF0TMR+C2EbIQ6iYQi3BWA/1H4KYtSsrxthgtFaWmf9rNt3vRpHhgb8W/oLbuvuHwD9Yq+VolCQZDvCKrTcISrREwnqMhMZGKWpEhWmceVZGbIHxtu1Oa7R070dtwt1EsaeeHhDrpERlNRTPEurW7Ea7hKyc1uLBTZW7egmUJx8uTxTWa+mvEsj10RWGm0TwRv/vILr/5Rag7T7fTWr3jLmgW/nfJaA2ffsOtXBPon+L5FFNZFvzNPL8QN7+xRznNh509dg+y8m/RBMgUMWw1zWPVyrg/E5Lmcz7bOt7NrhWjVYIf6vtWMIZN5xDjkyDVS0haQ4fycbzZqgvgqRYOA+uyreyRrwzOzxviFKLxrhSg3LmIjS28dFh2pU0zMf0l3j3s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RVKRIUkn+HR0zeU9dy+oBuZSkR2EH59k9rNj7HHc7KK1bA/FC3ShXyayjkf5?=
 =?us-ascii?Q?F2ljgH9OCVMxEp6MMbnEFGQq0YJPQQJWhOaYZehTOzg+ufkxMD0ZNZu+7pzv?=
 =?us-ascii?Q?xQrWIu1RwrCGNjTp/iDNNlEVzSn4/c3rd1XfeHSxVyANrPmfpdD28xbI8fWS?=
 =?us-ascii?Q?/xWpzn280UManjFLdDKgGLPZh7DHBzq5N2NcawpuqxziZjxFDV8cXICmHHUh?=
 =?us-ascii?Q?K1mQKzUoA+d0OvRgl44y63V8bRUSMj9e3bzBOT3OItM3wh0vxYt9na+Kj5HD?=
 =?us-ascii?Q?AbHon4YcPkwwKbx2SeeOFnP/eQXJStRoF704iUgCQ3Mll9RXxIISwAdQkeOh?=
 =?us-ascii?Q?QZFa8iHZNUGZriEXqu+uyj1sibMZIkOtEAg5tBN1P0iOEMPZH0EdHudISe9l?=
 =?us-ascii?Q?DyC797uSg3QX7SnwCvjZZInihexpB275zpWHRVafnNyE3NNcoIu0rY0CFlPb?=
 =?us-ascii?Q?FNkIwzqXc21xpmpL7L3x1X0KSZ73B2C0e0Z+W9pHVFD2tqxmwEa/xV3fMHlE?=
 =?us-ascii?Q?Yggq4cElXCa39TnR9urnkk9xyp5guvDFv3M6lmlSbouaICHyKZPR5CimqzpR?=
 =?us-ascii?Q?10BcCRG//Azp90VmF1ij/u5CEBSFruGGS9cpIQjP3p9mletbUYg9J3IYVqu1?=
 =?us-ascii?Q?VCNlXGT8MD0eqGxHHl4VE2t7g+E04a9jLnSJ2m4/rOonng067BocrciYLmYr?=
 =?us-ascii?Q?su8CE1MuYBulamZUAZDSWhN4JmwKYf2IDdV9zdTxswpMy0hK7t49rUhHW3/z?=
 =?us-ascii?Q?hu4ZPDR5zUFXZ8xGSPMfSogD0W3Hqwg9/VOgpCFZaQra1P08jh30owSDt6II?=
 =?us-ascii?Q?YXwhSYHkuSa/XwPAfeHjFU53CI8dy3CUWNAZqj7c3u7xJBkdReh0TW1hiBDo?=
 =?us-ascii?Q?7Su2I6MQLzRjrpI+i0rabK7gA+gJ/msZoBKn/iLYNuVY6TjRBM3PYeULgoTA?=
 =?us-ascii?Q?L0Ok+jpBvZW9rppKBC0QYyMgusWCu0An7BrHRWg+ZtU3IyxKihSznL7t/i75?=
 =?us-ascii?Q?xeLhf9tOEylhYdip3asmtkorlp8TDnbJ96NuuRtui91KA5PiG9FzgscZ9Rj8?=
 =?us-ascii?Q?3sexQZODqu3/SRIRy8Ob4i9Khu9mjlkbCclyfYdKBXgLQBh1jX68vaeYZwQp?=
 =?us-ascii?Q?T7NaZcKNEeOoO1neGpuXXhbDv8B8fIqC45pksBcXxyPnojb3z+N4+YDrwGWZ?=
 =?us-ascii?Q?YawWv4vAErFQ5mGa1g6+zwt4ltsu3XielVkwFbYjwJQYEvhYa4m+YbUd74RG?=
 =?us-ascii?Q?7VCdjsvqs+Kb2X2vpihlDZhhflQWOdNlaQjSNkhMTepy8LnjtpIQkRL9toE0?=
 =?us-ascii?Q?S6zNXmLyiwAhsn5UZCx9Qje4QPX2Jvxjo2JvqWDsxCaQAsLaUflfGrOD1YlU?=
 =?us-ascii?Q?YV6YggB0VFBH3N3bxQHn972d+Mna8TWC/AFWE8una+sEL0V9knyYk0i582HO?=
 =?us-ascii?Q?I9/Tn652oObwl+hWR07UZCoLW1xI+aVtF5XKiMuPos8RyNJNg7crYjCkRFLE?=
 =?us-ascii?Q?WIjurvMDN/nUIxks3rQBjwXlaPK2KU/s4nn+zIyHT8GB3IcrZlR/Rtd6uRsW?=
 =?us-ascii?Q?OwuXxiyO8aFUYIjCdoVZ9C2V12jlcjHG6V+GS3eP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c226fe-43bb-4479-56e5-08dc47b58c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 01:40:24.3304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oraQZKHCll8HVBYlXXoCRXmrENxRt4wcFCBMGCRmtaFEQoWLqJHWvMZ0rYj995zT/D0vg0XjoGlga0RudIBKCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001

> From: Kalle Valo <kvalo@kernel.org>
> Sent: Monday, March 18, 2024 5:25 PM
> To: Francesco Dolcini <francesco@dolcini.it>
> Cc: briannorris@chromium.org; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; David Lin <yu-hao.lin@nxp.com>; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; rafael.beims <rafael.beims@toradex.com>;
> Francesco Dolcini <francesco.dolcini@toradex.com>
> Subject: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host=
 mlme
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Francesco Dolcini <francesco@dolcini.it> writes:
>=20
> > Hello Brian (and Kalle),
> >
> > On Wed, Mar 06, 2024 at 10:00:51AM +0800, David Lin wrote:
> >> This series add host based MLME support to the mwifiex driver, this
> >> enables WPA3 support in both client and AP mode.
> >
> > What's your plan for this series? I know you raised some concern when
> > this started months ago and I'd love to know if there is something
> > that would need to be addressed to move forward here.
>=20
> Based on the history of this patchset I am a bit concerned if these patch=
es
> break existing setups. I'm sure Brian will look at that in detail but mor=
e test
> results from different setups we have the better.
>=20

With host mlme: tested by NXP QA and Rafael.
Without host mlme: tested by Francesco and myself.

Thanks,
David

> > p.s. I'm aware we are in the middle of the Linux merge window and
> > nothing will happen till it closes.
>=20
> BTW, thanks to some for-next branch trickery, we keep wireless-next open =
also
> during merge windows. This is to avoid unnecessarily stopping the
> development.
>=20
> --
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
wor
> k.kernel.org%2Fproject%2Flinux-wireless%2Flist%2F&data=3D05%7C02%7Cyu-hao
> .lin%40nxp.com%7C8d38662f40b342dd6f9f08dc472d3cde%7C686ea1d3bc2b4c
> 6fa92cd99c5c301635%7C0%7C0%7C638463506823212295%7CUnknown%7CT
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DfFO%2F1WjAubSnNNfMtXfRXXmAMP
> UEMjTHIIgjD4JDUnY%3D&reserved=3D0
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwirel=
ess.
> wiki.kernel.org%2Fen%2Fdevelopers%2Fdocumentation%2Fsubmittingpatches
> &data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C8d38662f40b342dd6f9f08dc47
> 2d3cde%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63846350682
> 3225278%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DuLvfm66Y
> G0OGFWNV2ZXngwVK%2FyuJlK5YO7wjbG8mUd0%3D&reserved=3D0

