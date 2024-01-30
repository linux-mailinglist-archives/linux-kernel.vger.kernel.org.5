Return-Path: <linux-kernel+bounces-43859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F368419A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6C41F24A23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CDD37141;
	Tue, 30 Jan 2024 02:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MpXrQYTu"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268BB36AE9;
	Tue, 30 Jan 2024 02:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583158; cv=fail; b=LJjZ4iUqY3dQnwVHR6azJCOmVnIXTwYbAkYI4iR1qYPZwbjsiU4uP7ExTYYwASAAN47XPPx4isKYarSJpIIcOYgNLZUQmzla75Dw3deIq21NoCp0XGr1SKnRSJrW/d5dVTQDlermttGRK/cQ+vjYLzM7z/kOQdUzIUWELYUESrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583158; c=relaxed/simple;
	bh=c8BMl4EXFNNw4TkewgpNx2zblX2nANzX/ts1MxhcmYI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UVUJcW2Nyq4A6wgbDh6M4eP1koq9onm/rzrSYBtHWpgoH1IB0w5LCOKf00qLTmCgPyBdp0hRJGLHHyJEEgbX1rMVee7UT5YoBgKunK1JObNytVo0YYufad4HgqaKyaNkPNnwfBUyvCAECBnTItG89o25mZBpP+MKvNeU0OOOQKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MpXrQYTu; arc=fail smtp.client-ip=40.107.7.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9JahCLOTfAjSHdK923J3E9IWeyIfeyXXYIEZ4J/E/re9RuUpRDW7BFXrD0uqX6bSgiegxotRFQkVfqvd9O9jcwvzOgu077tZfnqs/R0IgabD2L63RQAW0bYOZN49RVz0dxGMV0krpbQfr3WIHmUGQsLZy+mzOXu0AjWDry2kYn31vfaEbIZpTBHw4Wbx/s/P7ZWgah6bdoxw502eS0UfjVnHRUrUTGmNtAgrOxKFTDUnpn9QZ9a9SYigTCsH7YXFSL31BkwDy/3RPhGgaqjiekHbIRAknz63gFOGWgCui3zvcNwP5DD6Irk7VN0UMtD4GE8Q+tyr/xY8m6gj2MayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9Y9rcqqoZZYFB9qx8nqBuiQNn+xxms8B7ZePKusSkA=;
 b=APFKnefav6fgaq+gMYRimURD2CHx5eQphTVHlt/ZN7Vm20weC5S7Af/CfimlqkmDkymyVZghyblccr/FZCQO8sES58C1g5UFmdZTZehYZZ6oJkFtJc5Jfl4MyJcIBX1YEjBIPhv2x86omtmLFz7X2H6BN27s67dlyHFpJ7Jy1kuYYzdKwdkTxkG65YlXWX5i5uEhyUBzzWxZXZcLuxPcXj7RlR2Efm5ct5ggAkN3nK/TO7+cKulGCbPCq9MrlRPQYIQCCRrDzG8G9DcnfM0pgCu+0Qy6KbEenG6ZZONVYnfdwwssrkh1ieYFVO2S7+LRob7jmJNv49nns8CnhxhYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9Y9rcqqoZZYFB9qx8nqBuiQNn+xxms8B7ZePKusSkA=;
 b=MpXrQYTu4MFeuIr7tYKX7MLCTIVOBnhHiXYqvBxngy59M14y5f1QrV2I6g8bbyM7YtVJXPYfVX3v3EWi/OfiCgY20hLgDQr+96dfsTW/C5bRiGY6Gnu5JJZWsS4z5NYF8oTssPthylconcXTMjsOa3Sh8KeO8QZIQnSg3oV7FAM=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB8PR04MB7002.eurprd04.prod.outlook.com (2603:10a6:10:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 02:52:32 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 02:52:32 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank Li <frank.li@nxp.com>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>
CC: dl-linux-imx <linux-imx@nxp.com>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>, "leo.yan@linaro.org" <leo.yan@linaro.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH v3 3/4] perf: imx_perf: limit counter ID from user space
 and optimize counter usage
Thread-Topic: [PATCH v3 3/4] perf: imx_perf: limit counter ID from user space
 and optimize counter usage
Thread-Index: AQHaUpsXAYyR9Zx+Y066MBNVZB3wIbDw/J2AgACrv4A=
Date: Tue, 30 Jan 2024 02:52:32 +0000
Message-ID:
 <DU2PR04MB882224AF65845B2AB0F30B998C7D2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240129101433.2429536-1-xu.yang_2@nxp.com>
 <20240129101433.2429536-3-xu.yang_2@nxp.com>
 <PAXPR04MB9642D08437D60164E91E73D6887E2@PAXPR04MB9642.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB9642D08437D60164E91E73D6887E2@PAXPR04MB9642.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|DB8PR04MB7002:EE_
x-ms-office365-filtering-correlation-id: 1217e9e5-b8df-4bff-5403-08dc213e816e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vAvZoCO2mR8cK2c16fsCgds1CxjN6H3/1IBFsV4vjNaPcBY0zOINotQ+ECKlQMtyM017tdd6xe/iF8YkfC3LUzTaAkSjDyQvZtig0EdAAiAhocyfz5PxwBFLmktprjhfkG8zm1anph9kfSeCh/yGCA4bF8G0IH02YpRk7UoR8PirHPcZMUY8ehSpD5BcA5+fqeQxPSLC+HAhHgD0CdaPXFkdn3in5WN9ukAIWoxH0tqL7BC3SY9MbqYpyoIM6ytMNwzAE7C9e9fD7xa5ey99R6E9ZBOwCJ+Kf9y5ZQHUotB4vSpUHoYWyVs1sSkP131csFObdQHKf6Fp43g9GfF6pXUZOOOEMEqp4CiwmK9Ne69NwbA8m6Kc/q7zChkzZKoI22fHOP7z4wLEuXgT0r2k+WeNM8s4A5y9aPA92vmHu7omsvTRFX5VtXndG5MllIN4aiVpogyu5wd3nGFnd8QwCe9kv+FsFFdhhIlNor+dcR3QHXSiB1T3JeWXlXdj51TFnfzA70rGbUCG84TXe9CfpiyRxVLyOOvPQAhrPnqZ31SV3NLSH75cOdpZVXTlHwzYJwnMux2M4JvVbqQIVKyAKFmPyTt3AQt2Rw0ie9Dmof+xatPwg5SFeustntDlQlp4w3P/rA0iMthomkUknK7tPQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38070700009)(5660300002)(2906002)(7416002)(33656002)(41300700001)(921011)(86362001)(54906003)(64756008)(316002)(66446008)(66476007)(110136005)(66556008)(66946007)(76116006)(71200400001)(7696005)(6506007)(9686003)(26005)(55016003)(478600001)(83380400001)(52536014)(8936002)(8676002)(4326008)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TsodjZLytnIB7xCRHT6fvLFSjrGg3h+nHFAVQVD73eTPpH46sjzwVAw71okJ?=
 =?us-ascii?Q?W9aBndO0ass9OFTacDJksyDTWGZ/PN+wxEl3KG2qaZ8rDd6OO1r4TcNEiIqR?=
 =?us-ascii?Q?wuv5CCIq7mvKIbdps+gQIMO7zH0IkNz9UG33MI9lU4LGKSLDd9gtRpRVJN9J?=
 =?us-ascii?Q?0dgQQqmMELYcS9RGcBcxaHgkpJUMCCjjWC43a/G6SW8l2bj8jkpZFFEOYY74?=
 =?us-ascii?Q?Em9Sjxix6oYB4R0vC9bSy9bLgnBl+jQ21Ox96SgYGHGUYuFGjUxn9j8aQy6o?=
 =?us-ascii?Q?MNiaw3PdUCWrdysznK6WJ7em49+WOL+atNJ32rnUsms90B+ClmPU2NbqQWKF?=
 =?us-ascii?Q?hplior9Gb4w2VXd151dY39hfhWKsPLpFcUBokJrj+9kcAMkyNZNWny1VxD4R?=
 =?us-ascii?Q?rD41uAYthmab2QdjSeM1BhX/qcLXDz9zPyN8GsDQqK/dS6mF2Kd0Csea56WU?=
 =?us-ascii?Q?Sc1AFt1A1T6khX4CVB4Jp1yR/YQRh1+E7ebwqpHkwwNu1K/OI2ObP0I7fPTW?=
 =?us-ascii?Q?enmmyfw+cWW9wUifBW4H8idotCr4BVokTP+fqoG0p1TMxwpd+jV7By6z//yD?=
 =?us-ascii?Q?UOJ3aA5PYl9usRokeJatd9l0hwwgoPYPEY97sEK40YANaFjPvFtScuUqkYWg?=
 =?us-ascii?Q?IZPsmdYFKedTd0AdX8X70r/M53Xr8ToG2AGwyrw+6H88UgEWYa4F8elDF5jd?=
 =?us-ascii?Q?TyLy50H1D6dcZ5hKJgqNpO9aTWiWMLOx4g/cn4/02jE9Z0yGhSxsQdcO3vAy?=
 =?us-ascii?Q?RchBJHIZRGclyd/6bChQCV+mWbm0r0a35Rjg/JJ7pLMBFTgOmSC9GqHWOs6R?=
 =?us-ascii?Q?iiSI65sbpwAkvUZdRPo2WuiSaeWEsZuVMmLkngW0dwmThmZ8HyQ9PolgunCG?=
 =?us-ascii?Q?9u7vq7GkkGRxEL8or4LJWFdr7l7zwzPsATEwzIxkLCbRPDkNZjWmv2MaZ2Y4?=
 =?us-ascii?Q?40R83x2yxjxebB8bV9yldSzBlZS5bqLGsGDt4C7p6t5W88QxP4GW23orjYwq?=
 =?us-ascii?Q?UP28TbnIAcYPOyWKm+LUutUsh19fp/CNs7CknW80B9qn4dy0E8O3Qfn3cJAA?=
 =?us-ascii?Q?MfGEjGoWckcn8Gp9BizqiK0XEqaBkDFIJIvzceXfl41Y8HuOhI47tQtChys3?=
 =?us-ascii?Q?IyN/C9fDXgCgopQ3TwGmHodXPKhbQQozDP8hktDB+v2MLcfUkuysdLk3oJ7S?=
 =?us-ascii?Q?UuAVjOp6EXcO6HHVtZYnnWxl6HYw8CT0a68VI/PN9mVSsXVYqyW8It5EtxQ3?=
 =?us-ascii?Q?GDwNUYet80Qa+TTrul5wK4J1ERJgMrZOq7WD3PK1d4RausO0WuSMG6GGopxe?=
 =?us-ascii?Q?H8zF6nFfhPXIRYMKhEi4lNe1ZYJNzLLPv317032AbUgKCuhPPpHmHqLJGx/W?=
 =?us-ascii?Q?75tzNrPc5gzjynh0oZ7r39MmPLwbsh30H6dhpcglJ0kX1qefkHtaP/yoisx6?=
 =?us-ascii?Q?Qmt7bSdPLxoDP63hT3LcsVEUDLhhrIZ48yVDPEs258uIAgPfULLpjaggHizL?=
 =?us-ascii?Q?bCfQ7is/SSDrRwPOaMTJDe76UI3qaaYdYAONCnrIQYhU+cLekCFjwfhETCMA?=
 =?us-ascii?Q?fKj2QNXEG1+2PWbQ8vs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1217e9e5-b8df-4bff-5403-08dc213e816e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 02:52:32.2935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vkFBf9yChNhaooB1SrtEIBp3rtmnXVgyk0EIy+NCRlmTe9L5NFaEFteM0h/eEMaXJmHjREjLyPu77a2f3qufGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7002

Hi Frank,

> > Subject: [PATCH v3 3/4] perf: imx_perf: limit counter ID from user spac=
e and
> > optimize counter usage
> >
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
> > ---
> >  drivers/perf/fsl_imx9_ddr_perf.c | 69
> > +++++++++++++++++++++++++++++++-
> >  1 file changed, 67 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/perf/fsl_imx9_ddr_perf.c
> > b/drivers/perf/fsl_imx9_ddr_perf.c
> > index fd118773508d..4bb80050920c 100644
> > --- a/drivers/perf/fsl_imx9_ddr_perf.c
> > +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> > @@ -51,6 +51,7 @@
> >
> >  #define NUM_COUNTERS		11
> >  #define CYCLES_COUNTER		0
> > +#define CYCLES_EVENT_ID		0
> >
> >  #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
> >
> > @@ -235,6 +236,14 @@ static struct attribute *ddr_perf_events_attrs[] =
=3D {
> >  	NULL,
> >  };
> >
> > +static bool ddr_perf_is_specific_event(int event)
>=20
> Why call specific? Name is too general.  Such as is_fixed? Or Is_with_fil=
ter?
> Need know what specific?

There are only two types of event: reference event and counter specific evn=
et.
To make it clear, I'll change it to ddr_perf_is_counter_specific_event().

>=20
> > +{
> > +	if (event >=3D 64 && event <=3D 73)
> > +		return true;
> > +	else
> > +		return false;
> > +}
> > +
> >  static const struct attribute_group ddr_perf_events_attr_group =3D {
> >  	.name =3D "events",
> >  	.attrs =3D ddr_perf_events_attrs,
> > @@ -507,6 +516,7 @@ static int ddr_perf_event_init(struct perf_event
> > *event)
> >  	struct ddr_pmu *pmu =3D to_ddr_pmu(event->pmu);
> >  	struct hw_perf_event *hwc =3D &event->hw;
> >  	struct perf_event *sibling;
> > +	int event_id, counter;
> >
> >  	if (event->attr.type !=3D event->pmu->type)
> >  		return -ENOENT;
> > @@ -519,6 +529,18 @@ static int ddr_perf_event_init(struct perf_event
> > *event)
> >  		return -EOPNOTSUPP;
> >  	}
> >
> > +	counter =3D (event->attr.config & 0xFF00) >> 8;
>=20
> Define 0xFF00?

Okay.

>=20
> > +	if (counter > NUM_COUNTERS) {
> > +		dev_warn(pmu->dev, "Only counter 0-10 is supported!\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	event_id =3D event->attr.config & 0x00FF;
>=20
> same for hardcode 0x00FF

Okay.

Thanks,
Xu Yang

>=20
> > +	if (ddr_perf_is_specific_event(event_id) && counter =3D=3D 0) {
> > +		dev_err(pmu->dev, "Need specify counter for counter
> > specific events!\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	/*
> >  	 * We must NOT create groups containing mixed PMUs, although
> > software
> >  	 * events are acceptable (for example to create a CCN group
> > @@ -552,6 +574,39 @@ static void ddr_perf_event_start(struct perf_event
> > *event, int flags)
> >  	hwc->state =3D 0;
> >  }
> >
> > +static int ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event, int
> > counter)
> > +{
> > +	int i;
> > +
> > +	if (event =3D=3D CYCLES_EVENT_ID) {
> > +		/*
> > +		 * Always map cycle event to counter 0.
> > +		 * Cycles counter is dedicated for cycle event
> > +		 * can't used for the other events.
> > +		 */
> > +		if (pmu->events[CYCLES_COUNTER] =3D=3D NULL)
> > +			return CYCLES_COUNTER;
> > +	} else if (counter !=3D 0) {
> > +		/*
> > +		 * 1. ddr_perf_event_init() will make sure counter
> > +		 *    is not 0 for counter specific events.
> > +		 * 2. Allow specify counter for referene event too.
> > +		 */
> > +		if (pmu->events[counter] =3D=3D NULL)
> > +			return counter;
> > +	} else {
> > +		/*
> > +		 * Counter may be 0 if user doesn't specify it.
> > +		 * Auto allocate counter for referene event.
> > +		 */
> > +		for (i =3D 1; i < NUM_COUNTERS; i++)
> > +			if (pmu->events[i] =3D=3D NULL)
> > +				return i;
> > +	}
> > +
> > +	return -ENOENT;
> > +}
> > +
> >  static int ddr_perf_event_add(struct perf_event *event, int flags)
> >  {
> >  	struct ddr_pmu *pmu =3D to_ddr_pmu(event->pmu);
> > @@ -559,9 +614,17 @@ static int ddr_perf_event_add(struct perf_event
> > *event, int flags)
> >  	int cfg =3D event->attr.config;
> >  	int cfg1 =3D event->attr.config1;
> >  	int cfg2 =3D event->attr.config2;
> > -	int counter;
> > +	int event_id, counter;
> >
> > -	counter =3D (cfg & 0x0000FF00) >> 8;
> > +	event_id =3D cfg & 0x00FF;
> > +	counter =3D (cfg & 0xFF00) >> 8;
> > +
> > +	/* check if counter is available */
> > +	counter =3D ddr_perf_alloc_counter(pmu, event_id, counter);
> > +	if (counter < 0) {
> > +		dev_dbg(pmu->dev, "There are not enough counters\n");
> > +		return -EOPNOTSUPP;
> > +	}
> >
> >  	pmu->events[counter] =3D event;
> >  	pmu->active_events++;
> > @@ -597,9 +660,11 @@ static void ddr_perf_event_del(struct perf_event
> > *event, int flags)
> >  {
> >  	struct ddr_pmu *pmu =3D to_ddr_pmu(event->pmu);
> >  	struct hw_perf_event *hwc =3D &event->hw;
> > +	int counter =3D hwc->idx;
> >
> >  	ddr_perf_event_stop(event, PERF_EF_UPDATE);
> >
> > +	pmu->events[counter] =3D NULL;
> >  	pmu->active_events--;
> >  	hwc->idx =3D -1;
> >  }
> > --
> > 2.34.1


