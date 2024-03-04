Return-Path: <linux-kernel+bounces-89975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E3F86F87C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FC36B209E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA191854;
	Mon,  4 Mar 2024 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UouSA4he"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAFB138A;
	Mon,  4 Mar 2024 02:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709518696; cv=fail; b=iX5Uok8K7lR0ZeSCBlYsIP/cPED2GE1ym8Ra9a0Vpff8E1GfWnSff6yLDARNTsK0zr7oYYLkSKDlRiZy7dw3shioo2ySFqVIhyZQK/8mFWmNYhYMMc6e1xLf6VRbYLlctVEinpyMBWf7le/bV4zNyNENt+CTL1nWFfSR+3HYCGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709518696; c=relaxed/simple;
	bh=VigB3JQFY4Vmy3A+qbRD0uRQ/MyUD+96pvidbmB99R4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G1GLpglzuPWa4RCjEbNN2ZxQOayxvTi2mE2Fh6a6vFI9MA1RU4nRv3xXiQRmkItNrkV5nCgagSua16if/zyk2E8Dd81UZIrPSzDZJK+sUIZta0YdlewYccSLUh3NkUzH7wtUoHBbvTxOPCNtAvURgAjLMYcMUoTl34+1VHkVg0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UouSA4he; arc=fail smtp.client-ip=40.107.13.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNLN8IS040OXysiufhKF1teXzRRFDnVX06CB/772NjZI+yAtl/zhAiXBqKlgD6njI3yRibz0vvZ1cSXs6E2PFAbK3+PsA1za6rm8jBt6aF96lPy7Cz0yzlOO0TRknVZkKbKf0URwC1lBjxLtutcB2lWlBnbltFZI4TtywmBedq8Lqc3Tsb7761mmBbJAm4XHbgDGuDh4pj9idMzqrO0yuKPRc5qSYtD/hymKVqJdqcKdYHKIkVa1Kjfky6f+2t9QeNWCcVS/QD3AYTjAvYX5jVzRNZD79KuqddGuMu1tBeedZjYszqBGiJY6r5vpKS9ebuIDTNxwV17bhj5XZ/MZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VigB3JQFY4Vmy3A+qbRD0uRQ/MyUD+96pvidbmB99R4=;
 b=BsiRF41Hxm/0v+ACxQzXp7bpQiIn+duNE2JXOGkyijNOzBMha5Cf5VH7KK71RoRf2PGEMSI7qyUot8KCCNo1IQHR5OFyWY0UMpJfeOLED+r4Uy+GQJwr+xwVZ0yqw9QAAnZNeKkaCB6aTViuK3b1WSaA5VDBXKJDRFwZwAmKhGPE7ieaVzcZe8k5AqFwuKDbDcBe61gkAMrUU7CXKBcFvbhKh3n0ROfhLh7RT8dtQvR4oLOnTFTKTEQBeWbzRoXzqFqfYqyJAyAGuRloiOqd9LUZlwmqBhF4yAGxF80Q1B6CbVCRUIOhw1DvgQ6mczwgAAsbLNOrLd4peQg87w0ZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VigB3JQFY4Vmy3A+qbRD0uRQ/MyUD+96pvidbmB99R4=;
 b=UouSA4heKlpAaCJBERynzskLZ//KLk0qubursuNcs7GKdGIElHhrUGeb8y2/+9bwu+Mnws/+iyDpegCNUJOyJa3t7HaPwyV6xHsAvWXUdqNSWPF5joo4SkKG1sETF17PtOE/Y8uJIh8TfdHGlzGgUAk0OAyXOL2r5RdUBAjqIFM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8882.eurprd04.prod.outlook.com (2603:10a6:20b:42d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 02:18:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 02:18:10 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, "Peng Fan (OSS)"
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
Thread-Index:
 AQHaaLLyfnmFjzyGqEimlBHwa2+g1LEcnfcAgAAaQQCAAKcG0IAD/moAgACytyCAAHjsAIAAGAyAgAAWQYCAAAJ/gIAEKCYg
Date: Mon, 4 Mar 2024 02:18:10 +0000
Message-ID:
 <DU0PR04MB9417C8355827EE9477A11BF888232@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240226130243.3820915-1-peng.fan@oss.nxp.com>
 <ZdyR_MWeqOWga8iQ@pluto> <ZdyoAsYGXK9GjHVx@pluto>
 <DU0PR04MB941710FB1400D0A17F99B6ED88592@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZeCNyLxQOIazc07h@bogus>
 <DU0PR04MB9417C06FD66182C705238662885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZeGJIvk_LqglqdBa@pluto>
 <DU0PR04MB9417EAC31D3D7EC716A66C05885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZeGv-cDbkJMnJkJe@pluto> <ZeGyES-VOxafuAQx@pluto>
In-Reply-To: <ZeGyES-VOxafuAQx@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8882:EE_
x-ms-office365-filtering-correlation-id: 3a812296-9899-435e-1dd7-08dc3bf156b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /a0+NnF278WbcCsZUr5JXP+4+/+DpkA/s+A5uR/lY+kjNKo4MgXdAjDYCk7sZdoa1Owd+qQmxg5bwNMaclpg5CeF+D6Limxj9zrHJoWlHZbBXpi+1WRKPch7z2nk2+U9TWx1tZoGCLzyHyHPWxOf/0+4Q+bvZeDHAV1VTaQcaZVZqhSVTV+IFgLx9uQ3YCg51KCtAiAetYLEsDd7kPbS9PPZxMXFeiQmgW7agX+DXLxF9NyPS5oDVVi3Cj6goUrLzc+nBu8jtcsrnLSAZpiOy6bO119pjsTLjGNstTubE8o4PWgtBiVLorxyaZedqHiHGOuv2c5U4pCfIW+rUqWmQAZM0Y4tM6mjZEtyUJ7ePp2vr2bHlwPM8AXc5y30YwI5xhhI54TJf5FNKz/bHfharOAg8nF5VU3C3ISJWiDbpfbCE7OJQ4N4B1GMU/XJRUeLH6o/zHMePKAev+2X0XmCop8CUxr+DHwrKaU0H51/H2xO5iSVo0ka3sS6vg2QQaZoqQJ3k4fNom/f6S6VfdgWU7J39bYXXEZv029zreBuRNBD8bwE8oFRUT8xG5MmEb0bXWfmoO8L30DMRXAkZm9MbJaVYSWkTBeVBYw4IKfXBjm5XhyqJQ+Z+J6Qya+BjoYAE+t96nChcgHcoY67GL4frJuP0kpqeI3TVjmkfbH0QdM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P5azuauaVloNVS6uRtdyfyiGE9ZAe+AyMimqQU+qPo/prSJs9X9ZD3uV1Kmj?=
 =?us-ascii?Q?7BDT6AtkR0aNpkNve3Coc2wwWmMtrcdknv/Bgmq53BIMl2kasR6nh9z0H1KK?=
 =?us-ascii?Q?V7T1FXC9uHu8ZiZlu5CXyIH/asn2+CrV8EJepXuLf3ZsRsuFhEt7oPNzq+8H?=
 =?us-ascii?Q?Ko1kad3mJuCHwVmB+h64puD8MGH15lxrRwb6mFSPVj4fOtN1IX/04D5N/0BX?=
 =?us-ascii?Q?df56z6sjnIY9L4SS7moWnsXaKeCAxwmc7b+g5sUOkQbtjsUT6M9r/CKxFm9Y?=
 =?us-ascii?Q?0ywCB4e56GTWGvYRRSHMU5xVgCs6I9EC/IOjxhaDf6g3CQUBFWXQdLM/sC4P?=
 =?us-ascii?Q?jurpjPQzu60Z5j0Z8HxiZvTZIWnDhAimpt3ZX2dWRoTczNvO61oCJvlbTFWw?=
 =?us-ascii?Q?ec4+O01/Zg/vBgQ+8/qTmU+4aa6SDD1ktGUXBKlDIvs1mnu6Ls0s8Wa/iFJA?=
 =?us-ascii?Q?BmVxpOR4/tzfbJxSiAqHTO9fsgxnxf9hCuq5nc590cAvzclSJ+Y1xPgBidod?=
 =?us-ascii?Q?/1h6aMG14Q0zzpG7CjeK6OpExQnBkF9PcLv3BpC42m7Ne2qtr+8NRugKiSgm?=
 =?us-ascii?Q?eXLyNh2TW8ipIqZhJenHZ5Z4ifPthbeP89BWeL4Ody8t5pi+MSXuryUj3wUZ?=
 =?us-ascii?Q?OW1j+XrwCdj8LJiA1VZ9bHAJId6gxH8V0NoR+QXLqRTRHcVDS1DFIYw3fmjF?=
 =?us-ascii?Q?e4gRC1dIX4O/HilrJf1thFlY6rEslDKDPETOvlijEfY5CuaOSdxoqit+hJVw?=
 =?us-ascii?Q?ggMKaacZZ88BJCwqMaTmZ6DIdoDcwHzfL9Kl6KlOId3WIr9kLBl006bnmZik?=
 =?us-ascii?Q?ZVek3z1uZmetiLf19j4C459LlJ/rspQs36XGVaZUXIpZlNgXaAZwfFHlQs/t?=
 =?us-ascii?Q?Mz1dq6br8Mc9Um/Ww4q+asmOfFdpV97AYzGEQZ4G13iZdcIb51AuGaywd224?=
 =?us-ascii?Q?0zFS8dIqa+Ot3rl/c9UH4JgXa53ZdT1OD01EaGqePXIV3vCVe88KjEaR6NHw?=
 =?us-ascii?Q?q3yo2ngCw/1F+pb/hkWM5hCQGTyyrNpxcwdZ3cx7ysYqFVMEPAHUawG0gEpS?=
 =?us-ascii?Q?dDL/Pdcn4r1iYb8sRPONGHHNi3Z7V8i+abVc6smAH7TcR3UxTSrLZCRYtKCm?=
 =?us-ascii?Q?n4ku21Lh4WB9XSVTMpoikBaF5+6SOdqiZ4NqsH19gwq/0rzJfctgZfJR5QU6?=
 =?us-ascii?Q?SSSpxx+D/ixp1Mbpvb+rhqNg7+kvYelIxBxXqLFL+BuYU04QH6gvILs6Y/Yq?=
 =?us-ascii?Q?+Et4FXaxicSuJnqC+E96/ruYlAmQls8sWLiWYn6MhRd3dcXE2IUM/i5yAfaN?=
 =?us-ascii?Q?PE+1IV7teNCxGwrzXVVzHb8GqblJQQM0DyrNm5JBwCTfyPN4QSkYfDgZUGvl?=
 =?us-ascii?Q?VepzneRpNnXi8ouMf4rnIz3aB71kMYnTCvq7NpK1pxlyufMJDIpUFACwmvdQ?=
 =?us-ascii?Q?V2uW0xVV+zWd8acmsHdxfsYFj38kf+wPgBW1EJIV77Jq/S72cjWT9fHU9G4T?=
 =?us-ascii?Q?MImvWtr4Jvp18iSVay4UvwXgYvthO0PCKzwE6oyk2geVmIdPhoUJkTFbG57n?=
 =?us-ascii?Q?z7fBXP5ym68ztcjHBho=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a812296-9899-435e-1dd7-08dc3bf156b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 02:18:10.7436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KE64je/BhMspb5HB2Tap/LK58WYPHtqWuWAAyJjZAoPjrqdnNnhuNCuc/1i0640iAK3Vw0s8+N/avhAcNvmIjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8882

> Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support system powe=
r
> protocol
>=20
> On Fri, Mar 01, 2024 at 10:37:49AM +0000, Cristian Marussi wrote:
> > On Fri, Mar 01, 2024 at 09:22:24AM +0000, Peng Fan wrote:
> > > > Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support
> > > > system power protocol
> > > >
> > > > On Fri, Mar 01, 2024 at 12:41:29AM +0000, Peng Fan wrote:
> > > > > > Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support
> > > > > > system power protocol
> > > > > >
> > > > > > On Tue, Feb 27, 2024 at 01:01:41AM +0000, Peng Fan wrote:
> > > > > > > > Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi:
> > > > > > > > support system power protocol
> > > > > > > >
> > > > > > > > On Mon, Feb 26, 2024 at 01:28:31PM +0000, Cristian Marussi
> wrote:
> > > > > > > > > On Mon, Feb 26, 2024 at 09:02:43PM +0800, Peng Fan (OSS)
> wrote:
> > > > > > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > > > > >
> > > > > > > > > > Add SCMI System Power Protocol bindings, and the
> > > > > > > > > > protocol id is
> > > > 0x12.
> > > > > > > > > >
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > yes this is something I spotted in the past it was
> > > > > > > > > missing and I posted a similar patch but I was told that
> > > > > > > > > a protocol node without any specific additional
> > > > > > > > > properties is already being described by the general prot=
ocol
> node described above.
> > > > > > >
> > > > > > > Without this patch, there is dtbs_check warning.
> > > > > > >
> > > > > > > scmi: 'protocol@12' does not match any of the regexes: 'pinct=
rl-[0-
> 9]+'
> > > > > > > from schema $id:
> > > > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A=
%
> > > > > > >
> 2F%2Fd%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7Caf8c2c02cfc644
> > > > > > >
> 981a3a08dc39dce87d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> > > > > > >
> 0%7C638448868151253291%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wL
> > > > > > >
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C
> > > > > > > %7C%7C&sdata=3DhRNs%2BMA%2BPR3rdUSEMg%2FzqO4nN1YP4EX
> DSikXxZMhJ
> > > > > > > HQ%3D&reserved=3D0
> > > > > > >
> > > >
> evic%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C3ef5d152a8e5463e9b
> > > > 3408
> > > > > > >
> > > >
> dc39c47e41%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63844
> > > > 87632
> > > > > > >
> > > >
> 86203182%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > > > V2luM
> > > > > > >
> > > >
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DkRBV9FPk6
> > > > Nrgu
> > > > > > > Hs2SHpL74VlNUH6cYO1kAsW74CkaTk%3D&reserved=3D0
> > > > > > >
> > > > > >
> > > >
> etree.org%2Fschemas%2Ffirmware%2Farm%2Cscmi.yaml%23&data=3D05%7C0
> > > > > > 2%7Cpen
> > > > > > >
> > > > > >
> > > >
> g.fan%40nxp.com%7Ccac77deb5f6a4b20460a08dc392ead40%7C686ea1d3b
> > > > > > c2b4c6fa
> > > > > > >
> > > > > >
> > > >
> 92cd99c5c301635%7C0%7C0%7C638448119832543335%7CUnknown%7CT
> > > > > > WFpbGZsb3d8e
> > > > > > >
> > > > > >
> > > >
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> > > > > > %7C0%
> > > > > > >
> > > > > >
> > > >
> 7C%7C%7C&sdata=3D6MldIOUQ4hxn%2BRffwJJJ3jxXXtHCSxLUOa4JMWB0htU%
> > > > > > 3D&reserv
> > > > > > > ed=3D0
> > > > > > >
> > > > > >
> > > > > > Why are you adding protocol@12 to the device tree ? Does it
> > > > > > have a dedicated channel ? If not, you shouldn't need to add it=
.
> > > > >
> > > > > No dedicated channel.
> > > > > The idea is we have multile Agent, the M7 agent may ask to
> > > > > shutdown Linux Agent. So the linux agent need use protocol@12 to =
do
> the action.
> > > > >
> > > >
> > > > Ok, so indeed you need, AFAICR, the node in the DT even without a
> > > > dedicated channel nor anynone referring it: no DT node means no
> protocol initialization.
> > >
> > > Yeah, so this binding update is needed, right?
> > >
> > > >
> > > > > For now, we have not finish implementing this in linux side,
> > > > > just add the node in dts.
> > > >
> > > > On the linux side you should not need to do anything but adding
> > > > the node @12, the existent
> > > > drivers/firmware/arm_scmi/system_power_control.c
> > > > driver when loaded will shutdown the system upon receiving the
> > > > SytemPower notification....what lacks Linux side in these regards ?
> > >
> > > " Ignoring unsupported system_state:" we have new defined number
> > > here.
> > >
> >
> > So I suppose you are using the Vendor defined system states and
> > writing your own driver to handle these instead of system_power_control=
 ?
>=20
> Or some vendor extensions to the std driver ?
> IOW what is the plan...custom vendor states was left out from
> system_power_control waiting for a real usecase...that seems to have show=
n
> up eventually :D

I have not implemented the linux side driver as of now, but we do need
Extension:

Ignoring unsupported system_state: 0x80000003, we use this state indicating
others are requesting linux to suspend.

And when system is doing emergency reset, linux will get a notification, an=
d got
force reset, we are thinking to let linux do some disk flush or whatelse, t=
he
Time window is small.

Regards,
Peng.

>=20
> Thanks,
> Cristian

