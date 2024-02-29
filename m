Return-Path: <linux-kernel+bounces-86552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2351586C6EE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9653A1F230A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836176519D;
	Thu, 29 Feb 2024 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M8PAE7b1"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2059.outbound.protection.outlook.com [40.107.6.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FCA60EEA;
	Thu, 29 Feb 2024 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202592; cv=fail; b=t/4ZHgnjRo9pA+sOt8voxjLpeEGzylMeCettlawf+JONNmMeH4qs50jhDVNxeZ0XI/jQ2j3oOjpix3OPNRB+cvWXw5PDAY0bzg5/l3dy+K4NL2ekxXlGD36L9IKCJtzIbGUQsFyu3PJ10CuWU7+M/wmPN627pjuBS7ccHztzuIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202592; c=relaxed/simple;
	bh=UbEBFYxbI9bocTw4AFfqptdH6W5pv/TG6C/Xvcfc41A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PVd+FKz9NkIevwetFV9hMBdLV5t/pi2EJdI9XMWyYYpoHczed4GKW5Sz0NZu8QgMhoi2pGDYhJYxOtUoB/WMk6M/XYptSqW9zgstLngq18nYiRj2OeByKcxzTTuFUMRCO5anMh7a/+BoH7dxIu3TqRR1SDbH31zPOl/8ySdBwmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=M8PAE7b1; arc=fail smtp.client-ip=40.107.6.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNQPCgQQ3blPohFnSPuLyknlWKv6GqMrMk7qBGvl/BiMbJ6/D/zoJQAfOjGM9xbhtWgl8XCAEAfQnBu2PUxQ1aEouLorjy6xlEh302XpORLO444eKJ0TV5ETR4pogELGda/I1FI4y/e9o1wA4PBiSglI/NkCPB6CzHpdINYDs78flw09WELhBahhdNlzif+8z0CyLOoAx7kVKGfZa8LtNBnB5mQyXuNMakgedSxRYz0ZzNfjYw/wJtkLuleqveUdDIho7WQVg9WPuKL6/R+yb9nKRXXTzwECn7NEfBmXUCKEW+GVSh7oNvHyhf1noYLeA88cPaC/AS1OGIppEp0jFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSGXPUfxejjqWdNfTJgo8USNIF301T5mBBoi0elqBq4=;
 b=TpOJQU+rCCaxP12NuV0zsXqeMm7EeRBPVXu7cJQ8FduBpvyrCtr7M10tsy2PhLpBO+pbrCvZtxDjK1iZksr5TEMhf1S96Ur5H1O0bFT+wdr7WxlVvFqzemRnzWVUGUliRT94awwxNXJuQnaZrkg7ZdctKEh8URm9IvAEw26ht7LbWrhdka+j2XUVWvcQ7g0QZTMRaSazFrjRmSpT7KRi8Nt8uE3EwQzLG1a2MfhEBTebtPz0RT9EGvzjGBboWgyxB92Ln2rfncMj3VuXbzGiK0HSAFcJ5s5vDGVpF9znnoj+hO7vXV1XaVnr9kI48Z7Ml7WZ9FO1D3lGCasZjlpPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSGXPUfxejjqWdNfTJgo8USNIF301T5mBBoi0elqBq4=;
 b=M8PAE7b10Cu5WWTtN/cdDcYu56+n9kxwKBHrLoCH0XhIS0B+ilzOSVPm7t/+OibQkLQKEYER4ZrDCv9EjIaV2WgB5CHOgDOOBDoNnuKr7qeNhxXVlp9WGIoLK9IP+YtCRvFT4T/mxQKV5drX2B134xHk4FLCgfDpXtthRrSR+5A=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS4PR04MB9361.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 10:29:46 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 10:29:45 +0000
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
Subject: RE: [EXT] Re: [PATCH v4 5/6] perf: imx_perf: limit counter ID from
 user space and optimize counter usage
Thread-Topic: [EXT] Re: [PATCH v4 5/6] perf: imx_perf: limit counter ID from
 user space and optimize counter usage
Thread-Index: AQHaVAmkRsOhJRfPykqMZw2ffn1WI7EWbCEAgArgIJA=
Date: Thu, 29 Feb 2024 10:29:45 +0000
Message-ID:
 <DU2PR04MB8822DF3B4A9251F18C4E3FD38C5F2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240131055811.3035741-1-xu.yang_2@nxp.com>
 <20240131055811.3035741-5-xu.yang_2@nxp.com>
 <20240222122438.GD8308@willie-the-truck>
In-Reply-To: <20240222122438.GD8308@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AS4PR04MB9361:EE_
x-ms-office365-filtering-correlation-id: 271a7a2d-562a-4987-c97b-08dc39115989
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 icFlOGUuUTaOkRD/3nKb1BdHkQdjMv1UKzJEk0Egxv5NXzI0vnh5blJzZTD8dFNH8B4vnIvMZE510TfBJZTtNvQdRVy9/eSJmXTVBYckCtQ34vf790VMKfSeXSecldZtPwsUPTrDRffrZGJzH/5CzWkGOrPEOiMjhe8WX+iTm7iwH+kFVHkyRidHpzqu57ynDFucMltuxJwCOJf/RIZXbou31zF3vNe5qSSASdaxlAHDaO5B8VakMhFsMS/cQpPwrGFp0ATa0QqqNZhnypVU3bCX41AKX+gV0kSip5MnRdFHk1CVNSBZSXp1v4+/jYHkzqCqeOyLIQ7cF5XONgzhTxETo6TknGW2MbljIpNYWoTppw9is2fIT977qMTacjrZjLuEGiy3o4BTJ6ltE7eQUM9g4HnRXsTyWj2jdrT9B84GdvPCkAbgecfiwrDgjyB0mBcuJl4eRJ3vcE8j1BL82QhIpbbGWVC95zsCJlJJBKkzeFW2jRcdnFtVsNjgBwmbFQLq8qmIfmm/y37uJnJnxamTfFMYSAUqZjR4x0pOtKGa6QuGhL6fv4f4LFdM5b7W6tzCpgTE8VyJTS4aR1m9qV35V7foQAGKf7YXMnD0nhIGcK5+IQ9l7NvKvZvblVCGeMfOHgCQ8NCFXoyX5Dje8eXTzu8RTGXe15tsC/S6Do9VcN7iybYCTxpTrf+74qRMkfHiHwi8hzEn+Pb/1w03kA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IhXKK23eF4qIU6BiJcnRBLF/w5lq7OLTERfybdf2hRKctGyC/FAZay/mxG3d?=
 =?us-ascii?Q?93w3+Qf6PC4NxwYAAVC37rQCFEP49aQxED0NBEis68/2pCNWA2BUMbjAoJeb?=
 =?us-ascii?Q?Y0o+9Udbj/Z54NS/85Vy5w8YJUP/FrJd8JQTGWHSWmtx9HeHYbwhMdDc8LZ9?=
 =?us-ascii?Q?LMBzN9QZvDCz37Qe+dVrBkf3feYsEfV0RCuRMemDmnsMZI6syefZ/agjGQ6+?=
 =?us-ascii?Q?agcgx/F4N7THH81bIsmcFgITKhYq6wzg6MlpDlHk/KDm2NgAMxrlcb0bOoSS?=
 =?us-ascii?Q?nYhtIJhtQpyy5DiEbGiv6OpFtssWn8xlQBvh0gO3SteZld9azsxQjf4gpbIS?=
 =?us-ascii?Q?eOoi+9Yp4XmygTCF+kqs8LnlOOvL1Pnoab9rnqezw9lV7j0CIYGjJNX18xaz?=
 =?us-ascii?Q?AKOap1lr0revWWJ+HkGXdkVfktQC7ZrcvTmo9GvUjxcUnq3UiyvT/IOA7vYq?=
 =?us-ascii?Q?qlW4afpxg/Hne5ZtpxAZ3ydNvfUBR8+YvJ4qUffGCuDT4DqhM5S/fDg2Opdi?=
 =?us-ascii?Q?S/SWUw8DcK8qS1vLoiY+3MJmDl68CVNWQPmKVkdLiNjVTVf7KJk4hysHYFu9?=
 =?us-ascii?Q?zEaywrMUwcABug5+hyVdpXTgSV2WElgitN8VB0iT8zMG8GTQI9xK8f3YkrmS?=
 =?us-ascii?Q?KRG3j0K7UeX9Js/nhIaa5IfVYnFdz0ygpGhcGUxJmt5ZyQA+A/C568fUdazQ?=
 =?us-ascii?Q?wt0TJJAZI6yl6W4minFmFiaPwc7lnClEAT2jseIOFjhxPoZOk9L87CN/In7Z?=
 =?us-ascii?Q?0pWgbF/t9LFnbbhDqYvlE1yV/yZJQ1TudkRIgJs4OmARyjJFv5EyYxkQYBXf?=
 =?us-ascii?Q?o9OUe0gd5F/AALuGl+JNkuoENsbDGpmuFZVSY+7F0u1j5jTTFoYTB4zX1n7L?=
 =?us-ascii?Q?1WNJnRg4pIWTFL2V94IfB10laFO9P8fQFYnuJnCX7Me7ZDb2fdOEY6ZIMfQY?=
 =?us-ascii?Q?KD0JxwKuVfEsDR4UdXomExmHXvZAdxlJUPatg7s0RPIdgLTV4SPR7XqRaziK?=
 =?us-ascii?Q?+ZesKLuNZyZKKbu+tU88vKPklatUq8UpNyB5gba/YiKaC5kutaBONBhd5gC9?=
 =?us-ascii?Q?bKWbXpojnziW3EuORTEjgxsxZn5Kl0lFq2GgweeEADBsvmeAHVDWjMwD9Qy7?=
 =?us-ascii?Q?x4bMuI7jydfgoq+z5+pHup8KMQdRWTgH2pf2KnHJwWJoTaQvm28AMpEG5u2r?=
 =?us-ascii?Q?1/vvdsfb05TNSBBdif9CGGs9/jSqbTqK8YMF/N32ERrUyfsPaXLh9OtUPQ1O?=
 =?us-ascii?Q?IdceLaU86LVeZGeyqcNkdypyxYzwsgvT+TmVQxVivmCr9eIpK7XuwCPu1Sgq?=
 =?us-ascii?Q?aFJt8XtXFIUXSzd0xNLZUHAgaRqhLndQC6oO5eD+vPLt69kzXTIBV9fEZX6Z?=
 =?us-ascii?Q?R5j5a/fULnfW7RPdA0cJNQLG5uYfK4UPxbtdlERoWRrY5CdjKL6sGy2IBVGh?=
 =?us-ascii?Q?Mlu88FigdEm1nkw9yss3QahAtE9wD8pnIv4wlJxArEiM65Lhv6HTjWSPshs3?=
 =?us-ascii?Q?JO0W2iNJ3//uvPAri+0G5n5GwuIYhdplIlCBgs/6hFLbrBrjS9+2KvSs0QGB?=
 =?us-ascii?Q?SAymaVkS88fh8THjJd4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 271a7a2d-562a-4987-c97b-08dc39115989
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 10:29:45.9114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXJUDqPZNi+RSPm5ky/eZc09EnDoPOKOmS0w1pck8sl8AmQBwXs1ysk+axtDkTJwpm+NUhdr7vAr3HZlw+QtdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9361


>=20
> On Wed, Jan 31, 2024 at 01:58:10PM +0800, Xu Yang wrote:
> > The user can pass any counter ID to perf app. However, current pmu driv=
er
> > doesn't judge the validity of the counter ID. This will add necessary
> > check for counter ID from user space. Besides, this pmu has 10 counters
> > except cycle counter which can be used to count reference events and
> > counter specific evnets. This will also add supports to auto allocate
> > counter if the user doesn't pass it the perf. Then, the usage of counte=
r
> > will be optimized.
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v2:
> >  - limit counter ID from user to 0-10
> >  - combine dynamic and static allocation of counter
> > Changes in v3:
> >  - no changes
> > Changes in v4:
> >  - rename ddr_perf_is_specific_event()
> >  - use macro definitions to parse config attr
> > ---
> >  drivers/perf/fsl_imx9_ddr_perf.c | 72 +++++++++++++++++++++++++++++++-
> >  1 file changed, 71 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_d=
dr_perf.c
> > index 94041f06c152..e71496809c52 100644
> > --- a/drivers/perf/fsl_imx9_ddr_perf.c
> > +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> > @@ -51,6 +51,7 @@
> >
> >  #define NUM_COUNTERS         11
> >  #define CYCLES_COUNTER               0
> > +#define CYCLES_EVENT_ID              0
> >
> >  #define CONFIG_EVENT_MASK    0x00FF
> >  #define CONFIG_EVENT_OFFSET  0
> > @@ -240,6 +241,19 @@ static struct attribute *ddr_perf_events_attrs[] =
=3D {
> >       NULL,
> >  };
> >
> > +/*
> > + * An event is either reference evnet or counter specific event.
> > + * For counter specific event, the event count will only be incremente=
d
> > + * on the corresponding counter.
> > + */
> > +static bool ddr_perf_is_counter_specific_event(int event)
> > +{
> > +     if (event >=3D 64 && event <=3D 73)
> > +             return true;
> > +     else
> > +             return false;
>=20
> Just collapse this to 'return event >=3D 64 && event <=3D 73;'

Okay.

Thanks,
Xu Yang

>=20
> Will

