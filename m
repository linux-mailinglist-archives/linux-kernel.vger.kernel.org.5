Return-Path: <linux-kernel+bounces-72856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EA785B991
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4C71C21C68
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9120657CA;
	Tue, 20 Feb 2024 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rn5vXNPc"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F6264A80;
	Tue, 20 Feb 2024 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426321; cv=fail; b=ScERMmVv+cb+uz0GVZzSGzxVC6d73LDMXYMAWN2v9UhdzM7lVQq8z3sv6pBu85HdDYqZUHBNWElFHetmuUehaJhA7rQOMiE+5loNB7tAO8ULn4evzcMKtB3OUgsT96w6XRAqUZqbMTzTEf23tHdgKT+TctUxbUa+eRBMpEU8h3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426321; c=relaxed/simple;
	bh=UnuLSRAzU1fv8HFUS/nYyFQsCNjpYapCFMZkC8qDgv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oIKVt3r+hHwT6WBndKjRTWTyCFKepPM0WDcIn3bI57xdc+5//0rPvlofXcdD1Jx0pNEYqcW8/hGjY1UWHcQgJ8JS4eAZdrvrCdrwnx6J+cr8E6W5gi2nZETpeaLxs+zpmTvIrC2gt1ri4m/zfpaYJ6Z5nd26Q3BjZMyQo2vBvSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rn5vXNPc; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgKcVojOUwwrp7WUUKXr4HJaD8UVaMSeN7g8mu9Dm0n/D0jDmqm7AR20l9gHbFpCC1kJzJz91yOMxFZIkkR7YzoOo26H2sO7uM3u3oiAzSnPrMx/hLBa6vUh8ISr2SrRfTwo6J6eAQtTfU3FiuZx6kVp5l8dNG0zGDkyNm9OvWEXXbuHC+RQf3+HBfad0xXSjgEcDcT6Unmqem2HUsglqCqMYWd5at7LBIl56R8KJIT108pY0BN6IxYRLsZIeX0JE1aIoI/cxya/cI5cbWSMjZqKMXoXjtpc29QHvhJBnLlsjrM3s1lc5mVQL61O0Q2BEEGYZlpyWGkJhrwF6QGegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5Bod2J9Mqu0N5RimJ/vdIA/RXbhRlIKtWnOwprHC24=;
 b=lWJ9Wc1gjfAZwkSN0dXWuSZsCXe44lRhOvXF+apUrUPeJGa7UJYabBydP7iL9i6PPpDj0s/QnVuVjjHJq2tJfy6L00e7uWCIC1vYdsdqR4VwFU/rwrpERT3YBezavRQlqmMWHSiIX/nZLcwIamKEN0JTNdjSS9PfwlgbDr2ZcpqJMZLlkFFtImRjqj+Fj+SxZJeSiJ2pGDRxOOGTUgo1JvRI5eEvGhMoR5HdIU4E+RsK8uhHjMZj2qCvI3aHb92r5w0M/09xSi3AothAGxh2qjARgnyg/36LEhDnUUf4+Ifh7pjskQWJLo4OP5ypqtDWkzPG0TK8yPO0Idm56FGbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5Bod2J9Mqu0N5RimJ/vdIA/RXbhRlIKtWnOwprHC24=;
 b=Rn5vXNPcQeaXCK/7+KtBWwtTP/Kez6/u8osLY3Pqt+4x+vQpJc+zXxChYAE3lRCRRS2gxooQC1MWjSwZeDBbqa7ZkyF4PZGn9dt3jK0qPAXQYSTeaPGZZ1hj4I2dvA45xjrdOrDuXnmoZOWP14dg+TtJCrry2LklRCCx9+NBOlw=
Received: from DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.17; Tue, 20 Feb
 2024 10:51:57 +0000
Received: from DM6PR12MB4465.namprd12.prod.outlook.com
 ([fe80::3d54:20fd:bfee:7fc6]) by DM6PR12MB4465.namprd12.prod.outlook.com
 ([fe80::3d54:20fd:bfee:7fc6%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 10:51:57 +0000
From: "Buddhabhatti, Jay" <jay.buddhabhatti@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, "Simek, Michal"
	<michal.simek@amd.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"monstr@monstr.eu" <monstr@monstr.eu>, "michal.simek@xilinx.com"
	<michal.simek@xilinx.com>, "git@xilinx.com" <git@xilinx.com>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, "open list:REAL TIME CLOCK (RTC)
 SUBSYSTEM" <linux-rtc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: rtc: zynqmp: Describe power-domains property
Thread-Topic: [PATCH] dt-bindings: rtc: zynqmp: Describe power-domains
 property
Thread-Index: AQHaY+ZmsRZsdu8zXkqO0n0tzvdoobETDdZQ
Date: Tue, 20 Feb 2024 10:51:57 +0000
Message-ID:
 <DM6PR12MB4465FAF7AB3F9CE15FAC6C879D502@DM6PR12MB4465.namprd12.prod.outlook.com>
References: <202402192019160b9c4120@mail.local>
In-Reply-To: <202402192019160b9c4120@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4465:EE_|IA1PR12MB9064:EE_
x-ms-office365-filtering-correlation-id: 8fdd2701-0b31-4568-0ed9-08dc3201f54d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GOPsAMXFUnwlK0gocFjQKsyKpFnrj9fuvmbyqR9X2awjcO4TFjQy74KBPcirRM1seo60oD2A7kwy/K3YWlMkHbbTqnHCA4rhaq4IJ2Lw5MizJnyLqc2EgMyZly4EINB2k+L6MbyNVoRiSzOjjR1wyA7hCP23D8iFr/agVpSu4XrHhdORvE+0nX5hOgXvC3Tl8leMHTtvN0QBR7uc95x+JPRsf2Ao5ILpsbCUAyDmZS1w3gDddJTGJIH5CRfP593Bncprucx8hy83gT5D9d7XLPerPsbLyRAZRoGrPP0amMAF+C0GZLWOQyto8bPzsqvSBoX/VmdyB9RpE7LC/olmB4CBREqT/kF+1z5/jbaPd/8UcS7KiKKAQf8+OQSz/N/TtTZgutSDq2d8OVPBFVm1WdCArL1RZaI5VzBSgklJRwoR5XrKulqZOs7uTuhdxGO/PtUrfvuAAM87m+8jr/0ZcMcYurePVhPq88tJtXEqbK8S3l09Qfyn4UO28P8DQWglSNjWgNoyVzdJwK/xdSFVCuH7BfNVrYbosGIwhZoJUoVOxgiDvwAXITRRk/4Iy2PEp9ANQfUzwce6k4AWCp6qsqfHNSJ1peg51xgFdCLtY5I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4465.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IUZvNUk99KzoegISlhA5OP77sRz4ERaffjNUZ4TKtp+P1CfKuL2MY2ElJIdH?=
 =?us-ascii?Q?xA6v0FAJwk045qzCp8DUpXrgbUg35pGgV3bCZobAGcbNjRHyDhFnYntbgm+C?=
 =?us-ascii?Q?dfMosuv7bmk5rJdjEqn6/MoXhohZyVhSaqPfTy0hWw75ZjkAY/9YhjWmHrJ1?=
 =?us-ascii?Q?eUZdHyvcRGozsKHkn7GzvqPzGyCAr3OSrUV3XwBTmIFWFJGU/2xSk+0CKJfw?=
 =?us-ascii?Q?leN8dDf4UcsgNSxMkeCbsocd2F4Haz1KB+lV2DiEMDjVuBQ9xl2iy0l3ZWKS?=
 =?us-ascii?Q?JTad1RiTm+O+2F/owGLrUC/Qg15KgojgdFk7pnl7bcjE7qZ3ZE9cdasD1U59?=
 =?us-ascii?Q?wLeYqF78mmmcm+FU9gqnFEhLyPeK210Kto45FKHCsZdk6Vn1nko+tYX2Bm6K?=
 =?us-ascii?Q?ORsmhExfr5WwhWbnB6v5oSdw8Ik80HdWjQfOdp3IMec6WyEh/ASD5ezE1oJP?=
 =?us-ascii?Q?kLTSKWv8MSEfiz0UTcLAK2+QQadrO2F/8KdXvr4mMYsF5D/YOSRXhPxf521n?=
 =?us-ascii?Q?dgwKr3hagGbr3L3o0rx5H2hKRCNkbNAt6SX9lPhOotVqAfpBJ0zA7oUEFj6c?=
 =?us-ascii?Q?W5OCzhsEIcEbJwwchtQHy+cMR1E09bsvQxVO5+wHLTf0ybOLH2EeZICR1EmZ?=
 =?us-ascii?Q?IxD3Kb4rP+Dux5fqIx8sYdQ/41O9qeOW7javFP7QvMWqfgTvjtsJHNqYTwGh?=
 =?us-ascii?Q?PX7RZYPW1OqpoRNcC2wFejbaaIYFy47lPvsHMK/TDsecRuqrsd/Cs9BrCUGT?=
 =?us-ascii?Q?DGtZEGm/ksnbxSF8lGDvBepCxOOenplDAnscG7PDLDDNpwR4t9vVDkBf192w?=
 =?us-ascii?Q?E03liYK/66cKutUT7CMNvLQ0Z7fIcNyaducGKmEEOzNBkizF+Va8z1Dg7AaE?=
 =?us-ascii?Q?/FicUjx0xV5eGO3h+wGbFG7jbpZm61wDQc1RwHj1KSY6MrHHyVJPYEkB2JfU?=
 =?us-ascii?Q?yknN3VuoxTYxAwW5EKRL8Knp1IS/AImm63xdeenkBkd3GPdn2ST1Gqz6N1bh?=
 =?us-ascii?Q?89wrpEopKYmXZJPL1JD0NESv9Glqtde48QhDZPcKHTWTu2IA3DsinMitHR6D?=
 =?us-ascii?Q?fqaDcFkQoFhnwbuPray2elhQiOEad9FhUkEvtaUCKvi3oejftO1Ds0Kn+KgT?=
 =?us-ascii?Q?SxEE9xDNmkXw4xroWbNtLy/9VVqSDx5IEafgqeQ28BMkXEqye3FrKuzre6Bd?=
 =?us-ascii?Q?frs0MDbjFGa59VzyyCNSMZ7QJzqxLZXpuyuhBxO9jWJGLZqdYx9G36JccjOP?=
 =?us-ascii?Q?lUahVonrko5fa6Z3Xbb3AHEkRazpJFHBxBcp1/8/QtkQjZv3PjcoYuIBi8cQ?=
 =?us-ascii?Q?PkZ5VX09HT6ZC+PKh6c+QSp26419p05B424ddE3nVlDX1sNB0HIHgmMnw3N7?=
 =?us-ascii?Q?bxLk2uRBUzsaevqHr5pzckKfKFVDKlczACt8n4FbZzG7te7dOkph+f7ZcmYo?=
 =?us-ascii?Q?++7cmV3iYI42pwZRL2aFehiM3iCOf0ror2aYq9Pgpl+lpfcPjWxzngPXuVfu?=
 =?us-ascii?Q?Yf5Kyhv5fHDb/z15/2/6I7hI18r/U6soCFL7rU00llwKzrm2SGrpDCrhOXyk?=
 =?us-ascii?Q?T5zTeUYXMXDRFO5dxjc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdd2701-0b31-4568-0ed9-08dc3201f54d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 10:51:57.1190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0hcgKYXxqGR8R0vyz/x8dyrkHhcJaug/X7p27WbAVVQ/i1/9G1tHwPWoMJfN6yZG/r3dmNFl4M26GW/RexUHZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064

Hi Alexandre,

> -----Original Message-----
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Sent: Tuesday, February 20, 2024 1:49 AM
> To: Simek, Michal <michal.simek@amd.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; linux-
> kernel@vger.kernel.org; monstr@monstr.eu; michal.simek@xilinx.com;
> git@xilinx.com; Conor Dooley <conor+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Rob Herring <robh@kernel.org>; open
> list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; moderated list:ARM/ZYNQ ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; open list:REAL TIME CLOCK (RTC)
> SUBSYSTEM <linux-rtc@vger.kernel.org>
> Subject: Re: [PATCH] dt-bindings: rtc: zynqmp: Describe power-domains
> property
>=20
> On 19/02/2024 14:11:50+0100, Michal Simek wrote:
> >
> >
> > On 2/17/24 09:26, Krzysztof Kozlowski wrote:
> > > On 16/02/2024 10:42, Michal Simek wrote:
> > > >
> > > >
> > > > On 2/16/24 10:19, Krzysztof Kozlowski wrote:
> > > > > On 16/02/2024 09:51, Michal Simek wrote:
> > > > > > RTC has its own power domain on Xilinx Versal SOC that's why
> > > > > > describe it as optional property.
> > > > > >
> > > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > > ---
> > > > > >
> > > > > >    Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml |=
 3
> +++
> > > > > >    1 file changed, 3 insertions(+)
> > > > > >
> > > > >
> > > > > But Versal is not described in this binding, is it? I see only
> > > > > one compatible.
> > > >
> > > > It is the same IP only as is on zynqmp with own power rail.
> > >
> > > Then you should have separate compatible, because they are not
> > > identical. It would also allow you to narrow the domains to versal
> > > and also require it (on versal).
> >
> > I can double check with HW guys but I am quite sure IP itself is
> > exactly the same. What it is different is that there is own power
> > domain to it (not shared one as is in zynqmp case).
> >
> > Also Linux is non secure sw and if secure firmware won't allow to
> > change setting of it it can't be required. I am just saying that Linux
> > doesn't need to be owner of any power domain that's why it shouldn't
> > be required property.
>=20
> I guess because the integration is different, you still need a differente
> compatible so you can forbid the property on non-Versal.

[Jay] RTC has its own power domain in case of Versal and ZynqMP both that w=
e double check it.

Thanks,
Jay
>=20
> >
> > Thanks,
> > Michal
>=20
> --
> Alexandre Belloni, co-owner and COO, Bootlin Embedded Linux and Kernel
> engineering https://bootlin.com


