Return-Path: <linux-kernel+bounces-138081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D5E89EC53
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33772B227EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF2D13D27E;
	Wed, 10 Apr 2024 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SRVzFkfU"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2090.outbound.protection.outlook.com [40.107.22.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB7513D299;
	Wed, 10 Apr 2024 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734793; cv=fail; b=AKUoN/xSMZ05yGxXno5BDKsiA99EOqBoMPBVbdqfmJ0kK0HXo4YfvTeGmWC5876Rjjqxt0cTV0Fj0snTS7psvYijrvvuoQbHZlyM2ZDNXzpvcN/+gg+AZOW9OD5ctyBgvy0qifOpEIueeLWiBbKXSoJusokWni5uZ5SQs+MsTnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734793; c=relaxed/simple;
	bh=vBK+U18dMt8FAsLQoFkYo9Y9qPAU1c/9xSj/bPT74OA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MeFQGEmOI4BcLk0WA4wCsw6buUIIDwaCni3XFQEJZ5GFU6MPN7Cf99rwCTz+Mz7qb8swOevFcPtwGYdv980bAPBhGj1fLGJWqdbqCEgRPV7kCgESn0ELLXd9ciHlEV2nLcb9Dy48H60aB7LAmlGI+XBv9a+BeahFV3D5XVZc0Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SRVzFkfU; arc=fail smtp.client-ip=40.107.22.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3AmVFPX/AvuZD9LMMhBm1HdRT+1OyUEuDVi/jb+SsgzHDrI045j2Gme9FvBmzVNVOvSCiMY1JUhjy9wYqFFZiYPCUKbjZbVgbHHB0bW0xjT6Xzp/ubBMX2Y++0QDLhc6DYm1DjoeqX3IlFyfK6fU2hFfWT+pMNlHDFwVUM+St5wumD+XSgul2OxK9JP9lfhRJZN+DEa/whOEvdi04myxH2/YIRuxUonDKCw97EChIdITUJkl0iXnrjQhn2xjlHoAT6nQtmPkg9KkWQ951n5P/vs0unBg9gCO7CyCQ+b8qI0l8XfaeaD4dC7NAtQ1KSYrE6rg7lNxmQWfJ5fFyyIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhfQubLULYAPomxGGU10XKNmGn/DyuHRGN74jeb5eGw=;
 b=gJKSLAWFZjwPM6Gt7Ly3JTOz9/sHcKv1afCu+nCLThh37SnqkUyZCmp+jeKSIl5lg+s0g54xGvuvGB1iYMEAW50fztX+pM6dxEfJhmWf2X9q0N/mEeosBwis+Mqa5U/CHgCNGE242YTZ7fmZsrwzZjjba46xKTiAqM7TmHjUZOkaVv+5X2FyyvkngwlLVneFqL7++yiBK8nXUg5yZ7AipqW2wuqxMI4NEMpjZYRdDw9ULlbqxiN66AtFxVslzVwyhrfCv65b8l4bHUsYrT1Y6AJk1eR/CIWFdzN0GkhwxX4w7D/0LQNsadMstEJdZ5OS3ZtfkdCVCZnfZuzhdAiarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhfQubLULYAPomxGGU10XKNmGn/DyuHRGN74jeb5eGw=;
 b=SRVzFkfUilN29lCWaKM+ktoGDWcJ3SUUXPyZcBZ0lX3jatHQZ3AATyCmAlAuoIplzlW+GCEq7IjUzw2uZBpTqwAL/DUMbzXcTm1AgVML1hXFG+Imd3VftPHb561jrdmWglqh9fGFzXJCjkagu1fzfG4v0Bz/yDFtbiE7zdIsJKk=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB9082.eurprd04.prod.outlook.com (2603:10a6:10:2f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 07:39:46 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%5]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 07:39:46 +0000
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
	"mike.leach@linaro.org" <mike.leach@linaro.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v8 3/8] perf: imx_perf: let the driver manage
 the counter usage rather the user
Thread-Topic: [EXT] Re: [PATCH v8 3/8] perf: imx_perf: let the driver manage
 the counter usage rather the user
Thread-Index: AQHafCOvkc1sQxct2EGL+7AcOKkKWbFgLE0AgAEKnEA=
Date: Wed, 10 Apr 2024 07:39:46 +0000
Message-ID:
 <DU2PR04MB882209413AB62531713166B38C062@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240322063930.749126-1-xu.yang_2@nxp.com>
 <20240322063930.749126-3-xu.yang_2@nxp.com>
 <20240409152627.GA23621@willie-the-truck>
In-Reply-To: <20240409152627.GA23621@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|DU2PR04MB9082:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 L51mgJ+7mRW43ihG4+NbbG34N9MUy1fOVoneu/r0ZHblRE236hPyZxAeqvUT4mZV1CCot1k1oLz3b+oP53NeKurG/bpLdWkfTInomGzNjGuatIahX0O9pQzeAdapT3FcG5045G+vbX+oYLwGn6bZWhD/htsS6ElNcDnd2kIAMEshw9U73HYmjkH1L0oSsiVIhkpEEmmqJgsqBVyI2mZ0Ss66hUILBZRBLhAKYMn2tB+k01kdoHuoDqRxMNCBPqiloJ2dNJnIyTjnQvo7OyggjqxzD8J0tJSG9Xt3yQ2W/Ty1z3stiWO+oQ6c7f226Hz18QkK4tMO3NtOXXxsoz9LxGOzMytN3Jetl3+34SuBSNGGUMCf++VZWLpA3sD7Lfkq+1N0RQ+oJM50X0lEkfc12/TLKkYS3BDJva6jGfWtTPE/0/b/OxtftYvKWt3QXnDMkTi2rmeGwukwSzDxmhHnVfAbjvtoY70Ev9kTJlJy7+H1An8GnI/bOFb+Lcsg7us39LSgBpOSc8E688TE7GIU262DNtVQ8+sprJ3CYNTuzZjTo/GLBhFttnRAGYzCnJCTXFOcrSwtbEyX440uQ01+XJrc0yTMOJhPjNm4C8xPL0EdcbmwMNRW4ZggO6e02SoKPFa37lp60kJCCTvUBaiFvym0nDScFYP3b5evS/48hJU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IErx0OpBR0qrg3H959TIhd12umo380wL+yERiXXIDdZ1YsAA4/iE2C2OvYFV?=
 =?us-ascii?Q?ua6rREaNtOV+8TXGVYC2rlu534m+roAmUUsPSclXLXUrNISY7gZOoaPv0rPr?=
 =?us-ascii?Q?sVX7Qg2zGkNyhNHKYQDMm8HlEbVrYCxc1vrm9CLrTD3hLycTrk2SlPaZjNco?=
 =?us-ascii?Q?LJrIniz4EnRsPcAmMc5zBAngCS3gNipCJ/EpiGQqjGxeiYNiyhnEGFK3OIH6?=
 =?us-ascii?Q?ECYtCl4/BPW5QVOIPq4EMn9rMIcM/JBe9rQ1Jv8GfMGJHxJC6PbcgsKwu7gq?=
 =?us-ascii?Q?aAs5m+tDCBp6gzFORZS7T8UPyv0Z4joWF+MM5H7/+hF1StSJMzIOk+HqbNAC?=
 =?us-ascii?Q?NRhEHDbgNrx0vUddTh1UvRLHFHnKew1xbZPGOWnQB4BIGC2WeTLfFGv/cU+0?=
 =?us-ascii?Q?xgdml0fR1fVrsI0efJoqR7Odc7qhThVAmRY4FGqhElyKfJnaQFn2MMtrIJhT?=
 =?us-ascii?Q?z0fRqhbZpqcUkiYE0M0dN+qjmqwieyT0Rvhr+fCzClWlrY0AnkK7uveVXqt5?=
 =?us-ascii?Q?QSjUuA/B8OSUcV3BdUmb5L7W5n8NbEx05oddX5WKnLc4JDqnpQeOGJIaIwEu?=
 =?us-ascii?Q?gV1GTTqJzpwpHfGXmSByAmmY4jlG1JRtRZruIsd7FnzbCHFEkl6QdYJfWIX8?=
 =?us-ascii?Q?ZGVoZhZcQRauFfAgTRYtRTIUJS1Kd0Tgkwyj2Y3AaJmxsnDEaILqRA21jFk4?=
 =?us-ascii?Q?22TxeFAgjTg+/xMQJoq6JSz5XcXKqNH53AXloBSLKkXgxjHvYN5wrvCAX0Xf?=
 =?us-ascii?Q?J90TIYYP7fiuun7nHyXij7ew90LdIu6ssGiijZfwbCE327GFY9VFE9lcPyLa?=
 =?us-ascii?Q?zJYZQ4OGXFaVfNu89g8C1jp/F00Hzw5B4UBdjN3o4tuNxA8nyY7lYqfbc494?=
 =?us-ascii?Q?O9Uyfa/5CKNT8VbwOYwMH/w8D4ewzaE7xw3rB3HLie1RPRHRS8Z8RJkuexFO?=
 =?us-ascii?Q?d/VoGMvHCjWr5hwns+mvSEcm4OCfP65av2ttlqdWRVMOonj/Y6R7HVpbKhTh?=
 =?us-ascii?Q?zr/HSHAtyjz14zhtSOAfG7AS28Do5TX4Y7VyXzidOU2nqQcqUwwoud1P2+Tg?=
 =?us-ascii?Q?X4iq8WDJsjzAcdNfNdReAi17dax/8xI0aF7kU9vbv1kTxtpa/bxUKmAWA2qe?=
 =?us-ascii?Q?nECtENzKYu9UuGgv6j2+aZy4i8n6FgkccgVGXvBzRFcDZfwuTq4fcd/7UYIk?=
 =?us-ascii?Q?keTGpDywvldsw8ZLlxhJW3RdisL0K8OlHRo2uDrUCSiknAzz3nWPulaMTHNU?=
 =?us-ascii?Q?HH5OJGTDiBrY4O8mCvIf0dngAgZM+4jwIOnWrKoLncGY56DRrE88xlII7mOv?=
 =?us-ascii?Q?AFPDo9bwCcaNYYVoUdzyN6tEIJG4IcaZg/1FVWI0jUQwvSnVQ6pXFgI1k4DY?=
 =?us-ascii?Q?jZ2KMa0SYRBjdJofRZuyylHF1OkvsfOkZ9GG8p0i4/aGRST21Bt/Awcyi7A/?=
 =?us-ascii?Q?JOs4+ozeONjI82s6NBIUWA8qoD+Og47pn062Ly/nqCDG7COgkIrYKQ/+VsoF?=
 =?us-ascii?Q?pGa//Y2uXteHqUd/u2rBzBw+7WYzS5LSFhxXwyicUebOdSEEIHKCtsIG8llU?=
 =?us-ascii?Q?ngRgQaOy7K3wqJJnOa8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1158f4a-db3c-4c41-dc4a-08dc59316543
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 07:39:46.6530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFUxsXhcQEQLje2WGhWdjF2zYa4wUmVm0Mb/CWb+UJAaWhkWQPq8UrhyeRWksA0nInmc7SsfgBYBcLf05Uh48w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9082

Hi Will,

>=20
> On Fri, Mar 22, 2024 at 02:39:25PM +0800, Xu Yang wrote:
> > In current design, the user of perf app needs to input counter ID to co=
unt
> > events. However, this is not user-friendly since the user needs to look=
up
> > the map table to find the counter. Instead of letting the user to input
> > the counter, let this driver to manage the counters in this patch.
>=20
> I think we still have to support the old interface so that we don't break
> those existing users (even if the driver just ignores whatever counter ID
> is provided in a backwards-compatible way).
>=20
> > This will be implemented by:
> >  1. allocate counter 0 for cycle event.
> >  2. find unused counter from 1-10 for reference events.
> >  3. allocate specific counter for counter-specific events.
> >
> > In this patch, counter attribute is removed too. To mark counter-specif=
ic
> > events, counter ID will be encoded into perf_pmu_events_attr.id.
> >
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v6:
> >  - new patch
> > Changes in v7:
> >  - no changes
> > Changes in v8:
> >  - add Rb tag
> > ---
> >  drivers/perf/fsl_imx9_ddr_perf.c | 168 ++++++++++++++++++-------------
> >  1 file changed, 99 insertions(+), 69 deletions(-)
> >
> > diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_d=
dr_perf.c
> > index 0017f2c9ef91..b728719b494c 100644
> > --- a/drivers/perf/fsl_imx9_ddr_perf.c
> > +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> > @@ -245,14 +249,12 @@ static const struct attribute_group ddr_perf_even=
ts_attr_group =3D {
> >       .attrs =3D ddr_perf_events_attrs,
> >  };
> >
> > -PMU_FORMAT_ATTR(event, "config:0-7");
> > -PMU_FORMAT_ATTR(counter, "config:8-15");
> > +PMU_FORMAT_ATTR(event, "config:0-15");
>=20
> Sadly, this is a user-visible change so I think it will break old tools,
> won't it?

For imx ddr pmu, most of the people will use metrics rather event itself,
and we have speficy the format of event parameters in metrics table.
The parameters is also updated in this patchset.

And to easy use for user, the counter should be hidden (transparent) to
user after I had talk with Frank. Then, the user need't to look up the even=
t
table to find which counter to use.=20

So this patchset will basically not break the usage of perf tools and will
improve practicality.

Thanks,
Xu Yang


>=20
> Will

