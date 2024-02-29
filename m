Return-Path: <linux-kernel+bounces-86551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E9886C6EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB8F285623
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E30A651A4;
	Thu, 29 Feb 2024 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XNY2RFhb"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2049.outbound.protection.outlook.com [40.107.249.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D090C64CC1;
	Thu, 29 Feb 2024 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202554; cv=fail; b=TTZtg0Z+be6MT8WHhX4l5wJ4z0iFcPz5pAWYCddeIU01TNrCMgxEz7lquQiNgvDRFXHPS6GEP+J+QgltuDcOm39xMEf2Aw57ieThQ5427NdcQdvDN4Ej+pIBwXmpsqrx7PVeQB39AOuc+e4BUh22AwzXvl7sX6S4onWkFqkERMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202554; c=relaxed/simple;
	bh=rYE4AHcBcNbiANZiqBBfL+fq0UAInQQCJOU2HQ++UPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQok3tNZ/cPZDZYlN4jBKMxORNvx7tovYJUk5Pyu8zUAY5T+BJ+RWWayNzyiMdPyi/EBNTuUTl1tniD+O5blXp5RPaBX3C9TwJUrivyLijerrWAIpXEyZ2kAUgf6VVEISG0UcTjr4kEL2HK62K4F03wP0YZJu0JdROAdPXMdIAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XNY2RFhb; arc=fail smtp.client-ip=40.107.249.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vc439ZxygqMkPo8BHU+YDl154UYTHjpHheRvig73Sb0sl+rlCplYNe7AivpN//bcz6RcMm3QQPo/TOIjPL24R+Wpq4XDHYf4uUkU2Z4WiwQtGH/twgkcWeUp+KE2QZvSmEmdHkC880jNSFSEgrbUbWXv5v9DhfWQMNVyyPaRBAnmaELVSX5cfoYrQoU6MhE8fOcwsrpKv7ULVXfnxLTWiFHj5E9KoIcOks41tBJ1M3bDLR3q5O9hS9woKGUkQvl+Qwg16bGuGCcgdwxR9Z7lBvD8rSjC0ZZXXn7a4P2Jk6JJNH8EIBH92SXcXtJ8bP1GGRXVD0L1q7lwFYRPdjx7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbQ22qFXrR8Yd8y3mR7T1ZZzh97/IUPBPJaoH1Uuwbw=;
 b=Y0VMcXnDWkATCirH0yBau+s7lFLOcpIXPc7Fhxm4Yw5QbN67c591Np3mt3eo03NqnzIlfm7DpBNiH0+3CSfpwJ9OdoId/xrbftidHW8zSXNNIjGV/T4p/UQwmaZ5ewM//LnmakUlI647bPi8WOg3K0CIVri7wRmHiteobSJCOgTIPwaYJEOVJ0Cm5UM2P9LnG/B6UgF2i/bulGNdXHBiNkpjq+IysBZcUyalt1z0TLwp09P1usFZVGPshHh4ydHkhEFxITiORGE+4hNvTSpjHNaVhyyLBf11zs4zmI9ACFYV+YGl3Yv4spkULC0FDyC5gknnYJ53tAttyEevoqEWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbQ22qFXrR8Yd8y3mR7T1ZZzh97/IUPBPJaoH1Uuwbw=;
 b=XNY2RFhbD4umozXQ2ADfjcW98EMH2t+t2S7TwOs5N/nvG3cIeu7lFupzDK1BzHyzDwUyGlc36v19OiaYQLkVAToSshJjT0bZ2u9I8Qa4uc4RSSZlnhbM+WFXha8A0XIg9DsKQCeO/Jv+xikuFC+KT2W1sQgl4hB0diFAsbCnXFw=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8360.eurprd04.prod.outlook.com (2603:10a6:20b:3f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 10:29:09 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 10:29:09 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Will Deacon <will@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "irogers@google.com" <irogers@google.com>,
	dl-linux-imx <linux-imx@nxp.com>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>, "leo.yan@linaro.org" <leo.yan@linaro.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v4 4/6] perf: imx_perf: add macro definitions
 for parsing config attr
Thread-Topic: [EXT] Re: [PATCH v4 4/6] perf: imx_perf: add macro definitions
 for parsing config attr
Thread-Index: AQHaVAmgyIcNdifNHUmteT26AlgXorEWa92AgArgGCA=
Date: Thu, 29 Feb 2024 10:29:09 +0000
Message-ID:
 <DU2PR04MB882282882D1D5824ED8DC90B8C5F2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240131055811.3035741-1-xu.yang_2@nxp.com>
 <20240131055811.3035741-4-xu.yang_2@nxp.com>
 <20240222122341.GC8308@willie-the-truck>
In-Reply-To: <20240222122341.GC8308@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AS8PR04MB8360:EE_
x-ms-office365-filtering-correlation-id: 2d588d7b-1443-4d6e-2770-08dc391143e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zXxr5lvzybgjR+V1NNtdvpuVLuEYiI3Fcd6bCvQg1xFhQojFFz2tv3+E5LY2dZO8eFTNHjnAXXpndCxRFhjddAJy4MrIeAP1JyRgf9ubW7a2sh1YD/iSByiKx9U5fiLb5TVq4qKMPA5OOZa0txTfda4pnY/8L/B0RO3ZZ+6s18DAMSbwXg9raZRQdzJsjFUEvgOTSi5I7Kf7bpDafuDyKzeZFdrAYCj3QszzzhVurUgSO3TtdS4eLp48f5F4xYQObp1Wpn7Hb+eRNvUehcjebwJKby3qCwApcVKlTxfPUtntcLbrldIdonQFSmNDiOUPjKBKIVslxL6MTlJDFbvbpdJPMzW1vS5z6Huiy8M1sZEzSC8jnuZKxXVr4JSgnmiJTbMh5KGGtvXGqwz8n6tdDMwlNEo7WSWtOtjHITD681LEKB0+IAHQAVz0hMpPvcyVDtDSnZB7DMm++5xKG+hNIw0b1NX1wFmJRT9u2GoT0ErFvUumbHeTY9QoQT6R9T+WldKugQL+/nfH5Jlt5ansh/XpMFHo4gu0envFhTpCxH2aG2yWas/7Juh98vCkQV+O0ujwwB6yRGzT06gUOTYJmTbOL8Vm/lWJt1STK0yGZ1Z1LwjKqNRaJSCLyVmhxL23kjzsvgpNOrGRyIuklmyDr1HMBhrPWTS0ptWwtjdFqsCdOEDrXRoCwnpCHNNZnKZJEUnUANiS4NdzZoRlnPnsspwUSr564HUBMgOKrR88uJ8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TNRySU+c/6PFL42ZfJx0x79MwspAk0rN2OqIsulUnYvKRW7oRV/gVNbQ9qZf?=
 =?us-ascii?Q?jOIijlc6/QlN+8qus28fGKOpQRR/g9/EJewT59uwqngYE7+C0oV82eeSBC1G?=
 =?us-ascii?Q?AoLyQ3D+tMvdJPvDbDXaUF7tvoILDXFdc2a9hioS9Nkb+QB/soZKSi9f/dDa?=
 =?us-ascii?Q?28Pc3vkjimTAQM+HbZaL2VeCRHT8vfe+ilAIlHRiHnufVQ8D2f22rmcSwQUg?=
 =?us-ascii?Q?jEgiSnqCVq91uN05C/dCpqZR90NZglnd/DpOeMkD1dKRRxdaFDD280AMkTb4?=
 =?us-ascii?Q?F8OTM5LpA0rry/ykiPyEuo6TQPkFRUMqlZQZ6DRdd0nNVYS+U8Kbj5641bQK?=
 =?us-ascii?Q?URjwaAdalqtlm0FjNGkcPIEsM+q5O1/KyTqhO7jsNFO6mquDR+hyX3Y0vJjo?=
 =?us-ascii?Q?gl6UZLtLPIblEyF4W6XoiI22nI/SNEAMQ+NX6JdQGmc+vXAOC2GKK0f6uXXY?=
 =?us-ascii?Q?mUlXhBAGVdLlw9doVexjdAT2SNong+AKAeKXfEDJGRBm3dnLnVBJsM7RLzIt?=
 =?us-ascii?Q?wRPKQZcxkoWu5ksXpSbqbeeeyPv5GaZGWRA+jVcDf10SpIHhJq5CiqXWwnuf?=
 =?us-ascii?Q?w0mXJ2pNHF497CXxdtVmV5kl0G2Ukitd75q5uy00MP++esA5qZeW+tTS3I7B?=
 =?us-ascii?Q?bqOWeEvU6qC4k7IFUvUCr8ZYmNvUGuA+8U0+/ktTUkoyzgYM+qgd0LvRVZde?=
 =?us-ascii?Q?gRZSfAyzf3Hyal58HYDnxYmGm42VdVoS+soRN0u8w8ffT9Nc158cqGJNntQf?=
 =?us-ascii?Q?kkwox+ZkfB6Ats0jhxhq/RuYVtIWdZ1qRn0dmuvC07DcPIA0dhHUAcGSNMHh?=
 =?us-ascii?Q?JwKBCkYrd1NRizYWWe+75FYm449nhLlIVieJni1A/98eRxKX3krDdE/C4e6V?=
 =?us-ascii?Q?JJ8sZH/S8JudSCK+uafL4SSteZQRINnLHPXrOdW/OzTW09iMRfw/xIrWYo6P?=
 =?us-ascii?Q?8URH0YjlSq3f6v5rCI+39TGwL1jydXON9QIXHWIS4SADbupSiRyg6A7skz2F?=
 =?us-ascii?Q?oTqvOv9GXQz5SXCIdoWmUTPO/96dfoETR5XSd8ag9GFTrugYRdkbsdFJnn9X?=
 =?us-ascii?Q?QCDk8b9ijt0CPSDuK5MhcHlrLbS7vmaEHpjFWyLNaeyXYb5U8sC+LXvgUMEs?=
 =?us-ascii?Q?6KKh6jfnTqqV8P1DaZl9crk5AGiUmM/DBD6tVCOCPr1XCT9itnRxW9PpNUfs?=
 =?us-ascii?Q?HaueoS0YiZhZajEtUt8ukcPE0SXHLNUIPTxrskhVwuzDUjWQyqowBv3XK+YU?=
 =?us-ascii?Q?IkiA2u7K1zAziNKz6s5Cx4zpQbH92K2oc4uT85ge2QiktiExOVyZ8FNcinT1?=
 =?us-ascii?Q?M1As/ZZ5jkRVUHJ6nuGYLvUY14REit3oryjiOAMHlvP6SCTlszmf+2sdYr/2?=
 =?us-ascii?Q?KlUsS3mHzkI7qwT3y3TnZKb6rQsSy0+c8PGRoDhLUKb6GNnCOBqUmUxly7oM?=
 =?us-ascii?Q?LK8CsLd3KDGChS3za8bLRC9N2YqRPdQbYxMfnQjlIxVzZlYVmdC/9QOUzMl+?=
 =?us-ascii?Q?crfpiNSzPy51Y3AWaqoxWFwRgfqujoPNiz3IxBqIzS4OlqsNuN3ovTUtwCak?=
 =?us-ascii?Q?UyIc++b7ZQcPIbZzlUA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d588d7b-1443-4d6e-2770-08dc391143e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 10:29:09.5850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llxWKcLiOIxRpR3VqQZoArRHwRdRwAfrQU8+jbUsIIrcOs+qU7c0G5ax7pQKAuFgFQQdJW+X6dp2sW41x5d/ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8360

Hi Will,

>=20
> On Wed, Jan 31, 2024 at 01:58:09PM +0800, Xu Yang wrote:
> > The user can set event and counter in cmdline and the driver need to pa=
rse
> > it using 'config' attr value. This will add macro definitions to avoid
> > hard-code in driver.
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v4:
> >  - new patch
> > ---
> >  drivers/perf/fsl_imx9_ddr_perf.c | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_d=
dr_perf.c
> > index 85aaaef7212f..94041f06c152 100644
> > --- a/drivers/perf/fsl_imx9_ddr_perf.c
> > +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> > @@ -52,6 +52,11 @@
> >  #define NUM_COUNTERS         11
> >  #define CYCLES_COUNTER               0
> >
> > +#define CONFIG_EVENT_MASK    0x00FF
> > +#define CONFIG_EVENT_OFFSET  0
> > +#define CONFIG_COUNTER_MASK  0xFF00
> > +#define CONFIG_COUNTER_OFFSET        8
>=20
> Can you move this patch earlier, please, so that the imx95 support can us=
e
> these new definitions immediately?

Yes, I will try it in next version.

Thanks,
Xu Yang

>=20
> Will

