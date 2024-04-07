Return-Path: <linux-kernel+bounces-134323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B361E89B053
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 036A7B21730
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080CA1802E;
	Sun,  7 Apr 2024 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hB7djDUm"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2106.outbound.protection.outlook.com [40.107.247.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934BE546;
	Sun,  7 Apr 2024 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712484940; cv=fail; b=BZydZiopVDi3BxinzbQ+c0wCBO1pmV/jc4IyB1hT7TqkJKY8DsCpbJayRx4wjrhWZjToommHoxM6eCDwPuDuUSXRjPc9BdqCRpUW4c1uAtkhKJtU2lEbCQ2YXFzwxgS6u8GUh2dTKzL7P5FKaYopd4fPFMzEmUuTeQRdygwh4Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712484940; c=relaxed/simple;
	bh=tpo5KYf8WpgwpASiHRu4LwuMYt8XL11LNj0bT6W4NDA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oJYvn9+msvKnTqUStFLs+oImsuYTL9Xa7N7Kq+Rmh2PRuJ9IIgVovk2GKq0InptPvfjJYoQhEwG7iS9/JGxA48rxg/cWXH8yDF+7Q9urxY3CDNFBNUJoU4hdf4gWSeGWguuExLSqjrgEb0NeSNAQBsD+GzcHyZD4Jp2nfXffsAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hB7djDUm; arc=fail smtp.client-ip=40.107.247.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y13DYe9t9GLe0QgM43uuCTCi46Xz7rpOh1KV2wmILdtcc24iOGOEOLa914ulNEiQOYnUkHvcSi7+twGXNZMjP7kI6cQ7wTPUNRJWQuqvhm7iAaqOYDx7O6tkE+gNGy/hFFL2683B16EXCp/kYdmCPgjAOTUr2lH8PLrjFeiHf/j3YnBr7NmkzHheCwIzuOQZWpPfuz/l1OSNR01PbBgA1FSqGF92pCRHCu0aKxOvVRDHctl+iLjmEK11MEDwBhAPdzubwHafycn/t4543oZfRmHZNYqsPmr6jgx5ZZruAvkyWJt5dUyAL/2hxWarr+Gsax1BrKYdxGC5MhcmqDuN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axtGox0mOh+5XW77HOpLqY122kNJcDHPX/2vAHkewnM=;
 b=J4XsazPyzsnYZT1ggyaR0UL5u7Z0clpQjiFpwg/OuX3kzbMtLK9eKMiF5TXe7Fh8zNWMy/CIjIz1ZrdVcQR7aD9zhZB2rxDtzilMLFvoclMEdKG9ZxAhczMjWUR+UiZzlA6s8OFFblKjpFGzUO0tFDrHFqMFK8lio5bWsiKg+AEdAyJMeK++niAOntPxD5ekIuzOlxUY1z5I0p/fZ8oN2UfFcAP0xRwnHSiIkTDZ+zEJvrczQncpqWnkoH6hUtsKbJFzFFgYZasZbZAGBmiIIDi0cy31KdT1RJKmj/JNqd4dcTK1B4PISCbBOaaSB8WwL/deD2b4UhXCaYzaRv9Hhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axtGox0mOh+5XW77HOpLqY122kNJcDHPX/2vAHkewnM=;
 b=hB7djDUm42NaKtwo7wK4eG0ca7t7nylNSIQF4+DXBIfGcJg7Lwjo+y4v+NhSDjzNJwS3PP5NPjRwA6p/UNcXLfOQBuA6yqnYwUOL0fJCHJASu/wrPTCLcKuuhTN31ay0u0snrR13EI/ciiYx2tSsJmDoatl3MMYdZF302cgoodU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9876.eurprd04.prod.outlook.com (2603:10a6:20b:678::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 10:15:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 7 Apr 2024
 10:15:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI Extension
 protocol
Thread-Topic: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI Extension
 protocol
Thread-Index: AQHah1U59RmV1LBnZEq28+9F7LvjPrFbFSOAgADj6VCAAItlgIAAEx4g
Date: Sun, 7 Apr 2024 10:15:35 +0000
Message-ID:
 <DU0PR04MB941711C5756C778F955D6A9C88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-2-9fc9186856c2@nxp.com>
 <9aab8dab-27c4-40b6-b1d5-0a2babe0700d@kernel.org>
 <DU0PR04MB941719A18C3F749E7D180FD888012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ca7f1e62-5f70-4aa5-b539-764b778a71e5@kernel.org>
In-Reply-To: <ca7f1e62-5f70-4aa5-b539-764b778a71e5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS5PR04MB9876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 DqvVjX6YVuNzePlIl8mftuIHaKbWYkc6zT9rBXXnRj664K/KLkkFG8KdwWO/g62x0XuNV/ITZjvXYDoJEx22zfNFAK8SRlYzwcIpdqKmuU52dBLkb8wSMCQM2cYyOMscPTqTM8eSr177KzS0mcEC3C90fJjKeopG93oqm9cy9dddNiujuUtCJS1EZhSNQIf6tJvPG+4p9IlDw5zJgWOj977c8zSdos6KOQSKBDR332RvekvKmR1BtiOs0ZD0TbVFSx+txlKpOcP+2IUAIGRti0d6qBHTekE/HX7QYsdUSpMVSotOxxafJMh35QFQjV2cFrsv3wISdq483354wJWLHLxyO8b0j2QemLQYQMq7m1b3YU42UyFJtLxKYM2C3NMbpbNIsXEa+YQEQCpQp0FCdLK44Lg8UaSpgzsquuotA4OvN6Ejvb+rJU6oetqPYcJ4IKug3cG8JXjZ0L+1AP/UzmtdfIOoniBwQ66jfcHMSoDL6mo2Q2XJvhyC6AMMcpa7qN9zxhkavs7rjr2uAyrvASFuFvCW+0wlyBPGMLbh93pevehnpimXKle+rvvyM9GentIBuY0a20tuF64hmf2hCMOm52ul/2an5hUJMrPW2jhW028qISUT4gDpGEEbX3Ml8+CDhWR24KtPKyktldvl9XaxZAvaK9Jj+3Kv1Y1Pf0OsGFpXPXh0Yj2to7BXpVzJy8ReRbjzGaWMM03cD2mHtg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?H1AuUE78dw+cuRx7Fzc9BQJqGYHecIRKX83x83yMNBoJi6hhypiRp03LchQF?=
 =?us-ascii?Q?mHaB8xNPKgZIh3CyuSb4c2Nhs5MRpW5HguKLiC0CxJzNiyTn5LVX04alcE6l?=
 =?us-ascii?Q?UjA3lQsn1hpUWw/+tR/IH2DEkrn8+8e2lUr/IrWHkxA82mq3GaxykJnVT2x2?=
 =?us-ascii?Q?xufVLVv3yPxAqF8v5JTNnw6PKXL1eYUIe+xsg5/XrOU6L1A1+zi4JmFhiRnI?=
 =?us-ascii?Q?AB+CWkYD0ZsR2K2cosvZQw4iygx70YU73CKpugJik3vCBm5kx/g8wOp4DpaV?=
 =?us-ascii?Q?h69T7XMxVQK0iHp8PmRe2WmsVBTihW/c9wduvQ82NqC15kQC702UtV/F0uux?=
 =?us-ascii?Q?yH0hMEvVmmvMA2e80pG2m81tPiC8P4rXoJB2Q+e89TXQ8TXmaAy4n1pqmc62?=
 =?us-ascii?Q?7JSZVmUX+4Rby9k+0R8wN+dL/6NaZ8lTG6ELjkFiL8Jp74e9jbpRAcCQpK+e?=
 =?us-ascii?Q?qBkEkDoC/iLImBL8VgBItCoaRaFQKiMkI+lLgXTAHZZBOlWkf9ma6bRJ2AyU?=
 =?us-ascii?Q?OVRsJdYuVBnxdtLR7vySFwpZB4121dNaqTvrB2KdgPHIu6ZlmCmnOUTjA7TH?=
 =?us-ascii?Q?05tZ0Rawmcf9k3dazbBTpU0dTBqfom8eRxbCPnczM2EMWZr1sGOv/UKi42oT?=
 =?us-ascii?Q?jvr6c6FqmCwaKHwiav4yP2eHr7gYPwkEdaOKrEVcJhRjiwNl1qFgiLQQtrva?=
 =?us-ascii?Q?XNWoodKRZbDioMoUYoBz7GVKrtLjpxAe5+ZULFIqD+pOT8bbJ7KuJgKvL8ug?=
 =?us-ascii?Q?5mH8C3j/31AuK/3Nz8M5exy4qovX3XC65TUbLSCli1kshuNrq76jTe2Ybthm?=
 =?us-ascii?Q?tCn+HzWzVJurjVqox+ym7nUwMn6me40fU23+XQ2uk/cfq5eQkwAHdr7m5WGD?=
 =?us-ascii?Q?/yqne/o82N4bhKcQWEpg7/CIasoV8aEbyZSUMClVQplXwwFmOLe6s7e/Y6pI?=
 =?us-ascii?Q?h52NzgQEZVdEDhVZC4iEEuJknke7wgBCh9JMAvJLkbhw9az7+RJAbD6bsrZa?=
 =?us-ascii?Q?BkdsB0f5llEhzn2aW94IL0qj7YjWoF8Kswq7BeGLRtH4saKr4g3nG4ApUkOr?=
 =?us-ascii?Q?lKWL3DJ15n8aawt7nXpxe+cvDSLlcD1lAtITVcYeiONjMyU6ZpHkdZtt2UET?=
 =?us-ascii?Q?pAiZ1xg3CS/eI9CUyC/45Dxt+Lj1s8xBMFCNXp3lLbRtnUpkZYzWkH/vS8dE?=
 =?us-ascii?Q?eDFShGCe1gDRefa0IN5lIJsAo4VqzU2bxXgJzgIhR+2VCnypaSDqjog5H5BE?=
 =?us-ascii?Q?BMs5lBpVNOvcobvuW3gxtA6t6OgYbmp4Mu6WT1jU4oLPt931LlmJfkjVPDG+?=
 =?us-ascii?Q?PfyYmWrO8iQySBlU6eDpOj0OhsjajhXnANfZHueNu++vpCwytiHL7oWhqQQ7?=
 =?us-ascii?Q?mA+UIbARx6ztTlOHJKQ8kwjP+uYOZYz8uc/NeaEoa9KJewDbDsk++Fu9G53Y?=
 =?us-ascii?Q?cnDromLPZ1c2t5G/IGckPzVDaF0AKbiKLer2IvAlNwdK7dKAiAOh1NHgIVaA?=
 =?us-ascii?Q?acMswC9hJRtveXgjFxG1P4J8kh7I6l9nQqeufsNKnPU9M5IGimBJjBULASHu?=
 =?us-ascii?Q?ReYcdTpbKGLni6czzC4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a5ad43-a070-4f50-726c-08dc56ebaa3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 10:15:35.2794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0+sZexOVAeBx50SRAshIkfvhotEd+HzMC9R88T/7SIJFKlpQFTN5MfqAcVYsmWkVQmUPE6Z745wcFvf+2T/0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9876

> Subject: Re: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI Extensio=
n
> protocol
>=20
> On 07/04/2024 02:51, Peng Fan wrote:
> >> Subject: Re: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI
> >> Extension protocol
> >>
> >> On 05/04/2024 14:39, Peng Fan (OSS) wrote:
> >>> From: Peng Fan <peng.fan@nxp.com>
> >>>
> >>> Add i.MX SCMI Extension protocols bindings for:
> >>>  - Battery Backed Secure Module(BBSM)
> >>
> >> Which is what?
> >
> > I should say BBM(BBSM + BBNSM), BBM has RTC and ON/OFF key features,
> > but BBM is managed by SCMI firmware and exported to agent by BBM
> > protocol. So add bindings for i.MX BBM protocol.
> >
> > Is this ok?
>=20
> No, I still don't know what is BBSM, BBNSM and BBM.

From RM:
The Battery Backup (BB) Domain contains the Battery Backed
Security Module (BBSM) and the Battery Backed Non-Secure
Module (BBNSM).
BBNSM:
The BBNSM is the interface to a non-interruptable power
supply (backup battery) and serves as the non-volatile logic
and storage for the chip. When the chip is powered off, the
BBNSM will maintain PMIC logic while connected to a backup supply.
Main features: RTC, PMIC Control, ONOFF Control
BBSM serves as nonvolatile security logic and storage for ELE
Main features: Monotonic counter, Secure RTC,
Zeroizable Master Key,
Security Violation and Tamper Detection

>=20
> >
> >>
> >>>  - MISC settings such as General Purpose Registers settings.
> >>>
> >>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >>> ---
> >>>  .../devicetree/bindings/firmware/imx,scmi.yaml     | 80
> >> ++++++++++++++++++++++
> >>>  1 file changed, 80 insertions(+)
> >>>
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
> >>> b/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
> >>> new file mode 100644
> >>> index 000000000000..7ee19a661d83
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
> >>> @@ -0,0 +1,80 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) # Copyright
> >>> +2024 NXP %YAML 1.2
> >>> +---
> >>> +$id:
> >>> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fd=
e
> >>>
> +vi%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C410d9f1b5b874269dc6
> 908dc5
> >>>
> +6e0b628%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638480
> 77032584
> >>>
> +3394%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> uMzIiLC
> >>>
> +JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3De4zKRcyHbSCtn
> o6%2B%
> >>> +2BBaz%2FGhvPT0HikAdLmwi4VZxX4o%3D&reserved=3D0
> >>>
> >>
> +cetree.org%2Fschemas%2Ffirmware%2Fimx%2Cscmi.yaml%23&data=3D05%7
> >> C02%7Cp
> >>>
> >>
> +eng.fan%40nxp.com%7C5d16781d3eca425a342508dc562910b7%7C686ea
> >> 1d3bc2b4c
> >>>
> >>
> +6fa92cd99c5c301635%7C0%7C0%7C638479981570959816%7CUnknown%
> >> 7CTWFpbGZsb
> >>>
> >>
> +3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> >> 0%3D
> >>>
> >>
> +%7C0%7C%7C%7C&sdata=3DmWNwPvu2eyF18MroVOBHb%2Fjeo%2BIHfV5V
> >> h%2F9ebdx65MM
> >>> +%3D&reserved=3D0
> >>> +$schema:
> >>> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fd=
e
> >>>
> +vi%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C410d9f1b5b874269dc6
> 908dc5
> >>>
> +6e0b628%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638480
> 77032585
> >>>
> +6477%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> uMzIiLC
> >>>
> +JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3Dy1OBJ%2FPp4
> MljifpmG
> >>> +ZM%2FB6Ab20ivqm2qef7gzEjbNmA%3D&reserved=3D0
> >>> +cetree.org%2Fmeta-
> >> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpeng.fan%40nx
> >>>
> >>
> +p.com%7C5d16781d3eca425a342508dc562910b7%7C686ea1d3bc2b4c6fa
> >> 92cd99c5c
> >>>
> >>
> +301635%7C0%7C0%7C638479981570971949%7CUnknown%7CTWFpbGZs
> >> b3d8eyJWIjoiM
> >>>
> >>
> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> >> C%7C%7
> >>>
> >>
> +C&sdata=3Dv4XnGG00D4I8j5MJvDUVYMRTm7yRrvz0V3fUyc5KAAA%3D&reser
> >> ved=3D0
> >>> +
> >>> +title: i.MX System Control and Management Interface(SCMI) Vendor
> >>> +Protocols Extension
> >>> +
> >>> +maintainers:
> >>> +  - Peng Fan <peng.fan@nxp.com>
> >>> +
> >>> +allOf:
> >>> +  - $ref: arm,scmi.yaml#
> >>
> >> Sorry, but arm,scmi is a final schema. Is your plan to define some
> >> common part?
> >
> > No. I just wanna add vendor extension per SCMI spec.
> >
> > 0x80-0xFF:
> > Reserved for vendor or platform-specific extensions to this interface
> >
> > Each vendor may have different usage saying id 0x81, so I add i.MX
> > dt-schema file.
> >
> >>
> >>> +
> >>> +properties:
> >>> +  protocol@81:
> >>> +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
> >>> +    unevaluatedProperties: false
> >>> +    description:
> >>> +      The BBM Protocol is for managing Battery Backed Secure Module
> >> (BBSM) RTC
> >>> +      and the ON/OFF Key
> >>> +
> >>> +    properties:
> >>> +      reg:
> >>> +        const: 0x81
> >>> +
> >>> +    required:
> >>> +      - reg
> >>> +
> >>> +  protocol@84:
> >>> +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
> >>> +    unevaluatedProperties: false
> >>> +    description:
> >>> +      The MISC Protocol is for managing SoC Misc settings, such as
> >>> + GPR settings
> >>
> >> Genera register is not a setting... this is a pleonasm. Please be
> >> more specific what is the GPR, MISC protocol etc.
> >
> > The MISC Protocol is for managing SoC Misc settings, such as SAI
> > MCLK/MQS in Always On domain BLK CTRL,  SAI_CLK_SEL in WAKEUP BLK
> > CTRL, gpio expanders which is under control of SCMI firmware.
>=20
> So like a bag for everything which you do not want to call something spec=
ific?
>=20
> No, be specific...

This is not linux stuff, this is i.MX SCMI firmware design.

Sadly there is no public RM for i.MX95, we could not afford each settings
has a protocol ID, it is too heavy. The name MISC is not developed for linu=
x,
it is firmware owner decided to use it.

>=20
> >
> >>> +
> >>> +    properties:
> >>> +      reg:
> >>> +        const: 0x84
> >>> +
> >>> +      wakeup-sources:
> >>> +        description:
> >>> +          Each entry consists of 2 integers, represents the source
> >>> + and electric signal edge
> >>
> >> Can you answer questions from reviewers?
> >
> > Sorry. Is this ok?
> > minItems: 1
> > maxItems: 32
>=20
> No. Does it answers Rob's question? I see zero correlation to his questio=
n.

Constraints and edge, right? Edge, I have use electric signal edge, so
what else?

>=20
> Do not ignore emails from reviewers but respond to them.
>=20
> >
> >>
> >>> +        items:
> >>> +          items:
> >>> +            - description: the wakeup source
> >>> +            - description: the wakeup electric signal edge
> >>> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> >>> +
> >>> +    required:
> >>> +      - reg
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    firmware {
> >>> +        scmi {
> >>> +            compatible =3D "arm,scmi";
> >>
> >>> +            mboxes =3D <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
> >>> +            shmem =3D <&scmi_buf0>, <&scmi_buf1>;
> >>> +
> >>> +            #address-cells =3D <1>;
> >>> +            #size-cells =3D <0>;
> >>> +
> >>> +            protocol@81 {
> >>> +                reg =3D <0x81>;
> >>> +            };
> >>> +
> >>> +            protocol@84 {
> >>> +                reg =3D <0x84>;
> >>> +                wakeup-sources =3D <0x8000 1
> >>> +                                  0x8001 1
> >>> +                                  0x8002 1
> >>> +                                  0x8003 1
> >>> +                                  0x8004 1>;
> >>
> >> Nothing improved... If you are going to ignore reviews, then you will
> >> only get NAKed.
> >
> > Sorry, you mean the examples, or the whole dt-schema?
>=20
> *Read comments and respond to them*. Regardless where they are.

Yeah. My bad.

Thanks,
Peng
>=20
> Best regards,
> Krzysztof


