Return-Path: <linux-kernel+bounces-110992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD19F8866C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92839285AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9B9946C;
	Fri, 22 Mar 2024 06:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QON1sgdq"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36E04409;
	Fri, 22 Mar 2024 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089097; cv=fail; b=riomDPzceMv74YCKJK8pMa9S1uNpe6e7tdCOxwcxS3z3G6GpEQp7xYXearZRNVREHb8VzvOU8pkF8D+Cq5EnqGi40K5oFxWsm2aiG/7lyRTZE2lLpiVmzEAOThwpKoVpqw817AoZrbsXiz0sIrdBz3vuDSFdXW66s8JjqafwMV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089097; c=relaxed/simple;
	bh=qekVVyydMcecyBUyOMBgMqnUxIWJnewvdoVXV+DAFD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AiKRJ+NIOwXW/PcA8wKT1Gho/vzAH+skxpn9/pbeOvNH3jfXsuu48vJZQLVgnq+cFhkOnSvTMcMZvHx7FFuQjuqiIjJmScNjMeWEIRpaXOHi+a7+jNqvC7zMP7yCeVAhP2VLbSBC6132giJ0nVI881lzo6zU0jURsCl8l2j5oo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QON1sgdq; arc=fail smtp.client-ip=40.107.7.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qd5mV0vlDZrMhfG9RTJED927FNNqDMxeGRtkGxcj95QM4RwCusfRX7UtTtHeVHmDiE9dAh0mdy9MfTTAfV8Bvj387z7vTJv+VL3IFhGpV8jCNqgfRoVw2I8byZvRX8WMfCnheOuVpm6nhM+RGGtKHdkYSY1lDLDOr92jTVgYyLh0LLDbuh0vGRBbp8uW4H8qVqqOjAuT1CfJFDHU3R0C4fHtm6f3WJXuA585awweP7lcTeKWkwwVIY1gBdGxtPREW/G3afQOsasWs4CaEaVlprYiKFhGonzKe5wztb3NcNqxu2OGYWIpk8mHfZSygfl4sXg02E4Lb+sUsMNwO1Xomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkMB3hnPAbE1o3QNmHbn2H3QKjPl+d0+rMN9JandbvU=;
 b=biPrCC7gXkuVgTiN9r97Nl8WIewJvb1uaTeZ8VzfLhl0N2G8nbNa3IssWylbTX//L/8INfUlAUOi7n5Wauz9SF5qgLPX5LW2dMaNC9P7O4p+SEPeALxkArjETOER6OywgQ3F3feao1Up0tL84ute61W3xf5mkAXG9n3djMl5c5CQdiXVjJeVI0yqiKwm3oCi8VnMhAI4utlt4odnEYR93huJGcP0aHzlwHgolbS+qfJagqDqWcC9fst3hrf9q8qyaSW8RWFLjL8vz4Fo1O9l56kcgh1eeMMyEscEB2P2k5cn6DwPSuQPTz44heco9HR7RR8ARZAxSLDsZV088gVw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkMB3hnPAbE1o3QNmHbn2H3QKjPl+d0+rMN9JandbvU=;
 b=QON1sgdqlMhUkdyDvhpI4dIXymFXYXRTrv3Fe7pB5GQCMvYDpbYDQ9Vc4uLoTz5WOK0zNk9nc8GUGtkUwjqk3kOzYRnfCIDw9BO+PlrwL8qdpuGLWroTFrViel8i3gLuXWoL2KgMebpekLqAt+neYt1VJSE5Kq2ZBAcx8s6e5Kk=
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 06:31:31 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3%4]) with mapi id 15.20.7386.023; Fri, 22 Mar 2024
 06:31:31 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "will@kernel.org" <will@kernel.org>, "mark.rutland@arm.com"
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
Subject: RE: [PATCH v7 4/8] perf: imx_perf: refactor driver for imx93
Thread-Topic: [PATCH v7 4/8] perf: imx_perf: refactor driver for imx93
Thread-Index: AQHadr7+Q7BPMTMxC02y+WE7XiG70LE910eAgAV6zgA=
Date: Fri, 22 Mar 2024 06:31:31 +0000
Message-ID:
 <PAXPR04MB8829CFC1CDC14460745916248C312@PAXPR04MB8829.eurprd04.prod.outlook.com>
References: <20240315095555.2628684-1-xu.yang_2@nxp.com>
 <20240315095555.2628684-4-xu.yang_2@nxp.com>
 <ZfiIU6EyI9J4ynTk@lizhi-Precision-Tower-5810>
In-Reply-To: <ZfiIU6EyI9J4ynTk@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8829:EE_|PAWPR04MB10007:EE_
x-ms-office365-filtering-correlation-id: 3c9cb274-cdbb-4196-cc6d-08dc4a39b680
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 l7L3myG+2vrNLmlUDH3lBzfkdPPApldW7uo/uUYtzOochfry/OoHtSVg6HtkbKhEm6hnTxDiJeSQnwRZz4K38x3YbRnrA4t/slsROp7iNn3++Q/Q2teQEBB2DISt24cMACNV/VzZPxfyDlwzsPW/S+MdLkbCEDPm2wl6AoJAjnOGk137k3ZHTdnTtcbxFvGkMZ0fVudONmKYAEccYi4/cT3vXIJImS/oUdm9Nn56it+DFVyrBHJxIDNyuo6Fci+Ob5o58WLGrSU7ps3DyxlryZDKErlmoGB4FcCNIZQ8vmqxgbqYYlzJPDt5XOXCGWL0yNdIjZw6vhtlp4bsqIad04P9gTUOsd1nXlX3mou2/rXJfL0gXJr/WZLsMfamGaWAH7OOXOud3y32wn6D5ol4tTueScx9CajCLSU/Mp5TddHF+n0k35fcG9pltHMJB6ZPrthHO4tRXIyhp6ouTgoSP+2EWMwcrleZxL5Xb6/rvWQVVBD5gaW/JEfXU2X4Y34bZv87ZBj8rUD2adZKInMfUUuVhPjRZUHDOKjgEG8j0RHD7hBPCwIt+S61i6U0XaOx0tRKgiDBVl1f5TuU6g1Ua32nViwgvIv1rdO3886k9EJQ/Xg1EK9NRzwtw7AlF1BjOeZ++5r0wfH26gfIpi6VjPPW76MiyilJ3cMN+QFgPVfhp9hURIPnplq8lYfixtnwDl9kEm8aJ5XZASRLwyCR1A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mNX/TR9AFMNum1YcNYHn64fmtpP84BQc7ImjmClq2RBLf2bgnmis8PU5cytn?=
 =?us-ascii?Q?oVwuDe4Nly7+hJkYXxHxB4kzQNgCJRwMppY4AiCgFe3seldtgGii8r/LqKvl?=
 =?us-ascii?Q?61SwHGzgYIukSjjtutf+kS7XpEerHA8aDZeQoE3fM9PwHL6yvXLO+lxf0TX3?=
 =?us-ascii?Q?kGW8SNYsDEW/dMSVJQNG3Z/vIj16UZ3A16KJ4o79tuZGWimIHw6IA0n78uQX?=
 =?us-ascii?Q?6bwLX5Ih1Hs77QuS618uec8U3qGF7sB+mJFoeJyjpZ8Og+2IcJitZyN1s4HS?=
 =?us-ascii?Q?67h8XuD3+NbpT7+8Y1bNz3KhkeOwhAXPczSY2yD6uO3bXEFjKBd1C4NoBMbH?=
 =?us-ascii?Q?at8DxI0TD2f6SkMEFMn7EklhC5GuhuwDvT8LtPrlPmbtmWBmh6ZcfVpZO0fT?=
 =?us-ascii?Q?qQddPX0DkzxOh1/ASlcV6ifK+y4V0JCGNbvPQzNt8CDGJV9Lib0ytd4VGI/u?=
 =?us-ascii?Q?P7/cletv4+JaIouZCSTMtLPmMneCZ7F4GznjyWzxfireMc/DChsg2CPafbAy?=
 =?us-ascii?Q?lbf1TlZwSHBim/PMD25inV6cpW71RyNzjO2tv3p1lYq2/Rw3qhwBVZIKIX8y?=
 =?us-ascii?Q?ktIDiB6NPwOvXMGFtb1sWDGMv92wz9sWMReHSzecHvv6eRxMyu+Kj9U2rBWQ?=
 =?us-ascii?Q?GOtS9rv3AzFEj1ha8tKv491d2j9GqzEO8XYC8NWXD8v3c9FwGxDZ524w/9X9?=
 =?us-ascii?Q?jREmrYr3Omxg829tNBjxzxtgcRbxr2FvHlmbNDUIHHusXMgu6MRf02ppPWK/?=
 =?us-ascii?Q?lwWUDliVSt3ZvyGqSEzANARG11ohB1WB1oX0OHMXlGrhzAhX8EkBf1sUHhy0?=
 =?us-ascii?Q?vDWEYxU4PYq3Y67F35e2Aq4fkx87xtYfn90qg3+9jjAQKi5oeJf1a3QILhKe?=
 =?us-ascii?Q?u3hUZZ6pKM0cTGfAqDKnwAe46ycK7kgTVLn6obsaRAoCoRt8nzNZF5cNTtPc?=
 =?us-ascii?Q?ZJtiXezjRChB5q5DsaH8NeW1WUxlcuC6ywvO7hWokhv3EwAwTQupdoVGM/kZ?=
 =?us-ascii?Q?hnoNF8ix3Y6t04kigwT3MMRGXMSn63hTnfvw3ZZOAM1/TN7OQWyFomrK1k+S?=
 =?us-ascii?Q?cQODt45SgD49K2O+du3c4JbI2NabKNzffglkwsXvFqCaOXXsZFDc5BDbOVcK?=
 =?us-ascii?Q?JDXlQZFL5COikwgZxhy2QubBpE+CZyKwe7BwNmeZFho0EaSS+mqXTi8cRKOX?=
 =?us-ascii?Q?tSC4l2GTUIVmJzaSR+cc0dlGEgf5HtlDeQu6UWm2MgpJHepBPzg4s4RFJHaa?=
 =?us-ascii?Q?2UXx5Ax7mFuQ0MBvtCjyFpYZHxvnW0QR2QdMYOCR0c/L7r8Ppkda5EJpDheB?=
 =?us-ascii?Q?UqhzkMqW/m9U/dRMRCSQS9NtyJbmxE6z+4p4FWrZ7Xf+0Su+sdOejlHDrqwQ?=
 =?us-ascii?Q?BsZ4i0pVUM1dX6cEWjTueD8bEXf/UItFLpKSwlOnLSwGYcajYuJbJKUIFmEt?=
 =?us-ascii?Q?jiSDiiezGeOIQa1qvgexAOLfT8wQZUZ4L057g92oAWnh8ZBceKQyaNUOPgRF?=
 =?us-ascii?Q?d5o7vmWvx2H9bMROxGr1Lmn+L9BBgw4aVjHhAAyiVnfzwJ+qMXo0vjMnINga?=
 =?us-ascii?Q?57cA7xLccZd26Q8pIBg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9cb274-cdbb-4196-cc6d-08dc4a39b680
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 06:31:31.4864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijPbuTk+nM/o8ZMvmurqSnxR4u1Sx4QU96ehGBSoSjHn4j3ezPfZEaR5XC9oFzBjAXXVmihwccQm905qwsdxWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007


>=20
> On Fri, Mar 15, 2024 at 05:55:51PM +0800, Xu Yang wrote:
> > This driver is initinally used to support imx93 Soc and now it's time t=
o
> > add support for imx95 Soc. However, some macro definitions and events a=
re
> > different on these two Socs. For preparing imx95 supports, this will
> > refactor driver for imx93.
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v4:
> >  - new patch
> > Changes in v5:
> >  - use is_visible to hide unwanted attributes as suggested by Will
> > Changes in v6:
> >  - improve imx93_ddr_perf_monitor_config()
> > Changes in v7:
> >  - improve imx93_ddr_perf_monitor_config() as suggested by Frank
> > ---
> >  drivers/perf/fsl_imx9_ddr_perf.c | 80 +++++++++++++++++++-------------
> >  1 file changed, 47 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_d=
dr_perf.c
> > index 4fdf8bcf6646..5537f4e07852 100644
> > --- a/drivers/perf/fsl_imx9_ddr_perf.c
> > +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> > @@ -11,14 +11,14 @@
> >  #include <linux/perf_event.h>
> >
> >  /* Performance monitor configuration */
> > -#define PMCFG1  			0x00
> > -#define PMCFG1_RD_TRANS_FILT_EN 	BIT(31)
> > -#define PMCFG1_WR_TRANS_FILT_EN 	BIT(30)
> > -#define PMCFG1_RD_BT_FILT_EN 		BIT(29)
> > -#define PMCFG1_ID_MASK  		GENMASK(17, 0)
> > +#define PMCFG1				0x00
> > +#define MX93_PMCFG1_RD_TRANS_FILT_EN	BIT(31)
> > +#define MX93_PMCFG1_WR_TRANS_FILT_EN	BIT(30)
> > +#define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
> > +#define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
> >
> > -#define PMCFG2  			0x04
> > -#define PMCFG2_ID			GENMASK(17, 0)
> > +#define PMCFG2				0x04
> > +#define MX93_PMCFG2_ID			GENMASK(17, 0)
> >
> >  /* Global control register affects all counters and takes priority ove=
r local control registers */
> >  #define PMGC0		0x40
> > @@ -76,6 +76,11 @@ static const struct imx_ddr_devtype_data imx93_devty=
pe_data =3D {
> >  	.identifier =3D "imx93",
> >  };
> >
> > +static inline bool is_imx93(struct ddr_pmu *pmu)
> > +{
> > +	return pmu->devtype_data =3D=3D &imx93_devtype_data;
> > +}
> > +
> >  static const struct of_device_id imx_ddr_pmu_dt_ids[] =3D {
> >  	{.compatible =3D "fsl,imx93-ddr-pmu", .data =3D &imx93_devtype_data},
> >  	{ /* sentinel */ }
> > @@ -185,7 +190,7 @@ static struct attribute *ddr_perf_events_attrs[] =
=3D {
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, ID(2, 70)),
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
> >  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93=
 specific*/
> >
> >  	/* counter3 specific events */
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
> > @@ -197,7 +202,7 @@ static struct attribute *ddr_perf_events_attrs[] =
=3D {
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, ID(3, 70)),
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
> >  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93=
 specific*/
> >
> >  	/* counter4 specific events */
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
> > @@ -209,7 +214,7 @@ static struct attribute *ddr_perf_events_attrs[] =
=3D {
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, ID(4, 70)),
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
> >  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 =
specific*/
> >
> >  	/* counter5 specific events */
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
> > @@ -244,9 +249,26 @@ static struct attribute *ddr_perf_events_attrs[] =
=3D {
> >  	NULL,
> >  };
> >
> > +static umode_t
> > +ddr_perf_events_attrs_is_visible(struct kobject *kobj,
> > +				       struct attribute *attr, int unused)
> > +{
> > +	struct pmu *pmu =3D dev_get_drvdata(kobj_to_dev(kobj));
> > +	struct ddr_pmu *ddr_pmu =3D to_ddr_pmu(pmu);
> > +
> > +	if ((!strcmp(attr->name, "eddrtq_pm_rd_trans_filt") ||
> > +		!strcmp(attr->name, "eddrtq_pm_wr_trans_filt") ||
> > +		!strcmp(attr->name, "eddrtq_pm_rd_beat_filt")) &&
> > +		!is_imx93(ddr_pmu))
> > +		return 0;
>=20
> I think use name to check visible is not good enough.

Yeah, I failed to find out a better way to deal with it.

>=20
> struct imx9_pmu_events_attr
> {
> 	struct perf_pmu_events_attr perf_attr;
> 	void * drv_data;
> };
>=20
> #define IMX9_DDR_PMU_EVENT_ATTR_COM(_name, _id, drv_data)                =
             \
>         (&((struct imx9_pmu_events_attr[]) {                            \
>                 { .perf_attr.attr =3D __ATTR(_name, 0444, ddr_pmu_event_s=
how, NULL),\
>                   .perf_attr.id =3D _id,
> 		  .drv_data =3D drv_data,
> 		 }                                          \
>         })[0].perf_attr.attr.attr)
>=20
> #define IMX9_DDR_PMU_EVENT_ATTR(_namee,  _id,)
> 	IMX9_DDR_PMU_EVENT_ATTR_COM(_name, _id, NULL)
>=20
> #define IMX93_DDR_PMU_EVENT_ATTR(_name, _id)
> 	IMX9_DDR_PMU_EVENT_ATTR_COM(_name, _id, &imx93_devtype_data)
>=20
> So
>=20
> ddr_perf_events_attrs_is_visible()
> {
> 	struct imx9_pmu_events_attr *imx9_attr =3D container_of(attr, imx9_pmu_e=
vents_attr, perf_attr)
>=20
> 	if (!imx9_attr->drv_data)
> 		return attr->mode;
>=20
> 	if (imx9_attr->drv_data ! =3D ddr_pmu->drv_data)
> 		return 0;
>=20
> 	return attr->mode;
> }

I've tried your suggestion, it works and make sense for me.
I'll integrate this in next version.

Thanks,
Xu Yang

>=20
> Frank
>=20
> > +
> > +	return attr->mode;
> > +}
> > +
> >  static const struct attribute_group ddr_perf_events_attr_group =3D {
> >  	.name =3D "events",
> >  	.attrs =3D ddr_perf_events_attrs,
> > +	.is_visible =3D ddr_perf_events_attrs_is_visible,
> >  };
> >
> >  PMU_FORMAT_ATTR(event, "config:0-15");
> > @@ -368,36 +390,28 @@ static void ddr_perf_counter_local_config(struct =
ddr_pmu *pmu, int config,
> >  	}
> >  }
> >
> > -static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
> > -				    int counter, int axi_id, int axi_mask)
> > +static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int eve=
nt,
> > +					  int counter, int axi_id, int axi_mask)
> >  {
> >  	u32 pmcfg1, pmcfg2;
> > +	u32 mask[] =3D {  MX93_PMCFG1_RD_TRANS_FILT_EN,
> > +			MX93_PMCFG1_WR_TRANS_FILT_EN,
> > +			MX93_PMCFG1_RD_BT_FILT_EN };
> >
> >  	pmcfg1 =3D readl_relaxed(pmu->base + PMCFG1);
> >
> > -	if (counter =3D=3D 2 && event =3D=3D 73)
> > -		pmcfg1 |=3D PMCFG1_RD_TRANS_FILT_EN;
> > -	else if (counter =3D=3D 2 && event !=3D 73)
> > -		pmcfg1 &=3D ~PMCFG1_RD_TRANS_FILT_EN;
> > -
> > -	if (counter =3D=3D 3 && event =3D=3D 73)
> > -		pmcfg1 |=3D PMCFG1_WR_TRANS_FILT_EN;
> > -	else if (counter =3D=3D 3 && event !=3D 73)
> > -		pmcfg1 &=3D ~PMCFG1_WR_TRANS_FILT_EN;
> > -
> > -	if (counter =3D=3D 4 && event =3D=3D 73)
> > -		pmcfg1 |=3D PMCFG1_RD_BT_FILT_EN;
> > -	else if (counter =3D=3D 4 && event !=3D 73)
> > -		pmcfg1 &=3D ~PMCFG1_RD_BT_FILT_EN;
> > +	if (counter >=3D 2 && counter <=3D 4)
> > +		pmcfg1 =3D event =3D=3D 73 ? pmcfg1 | mask[counter - 2] :
> > +				pmcfg1 & ~mask[counter - 2];
> >
> > -	pmcfg1 &=3D ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
> > -	pmcfg1 |=3D FIELD_PREP(PMCFG1_ID_MASK, axi_mask);
> > -	writel(pmcfg1, pmu->base + PMCFG1);
> > +	pmcfg1 &=3D ~FIELD_PREP(MX93_PMCFG1_ID_MASK, 0x3FFFF);
> > +	pmcfg1 |=3D FIELD_PREP(MX93_PMCFG1_ID_MASK, axi_mask);
> > +	writel_relaxed(pmcfg1, pmu->base + PMCFG1);
> >
> >  	pmcfg2 =3D readl_relaxed(pmu->base + PMCFG2);
> > -	pmcfg2 &=3D ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
> > -	pmcfg2 |=3D FIELD_PREP(PMCFG2_ID, axi_id);
> > -	writel(pmcfg2, pmu->base + PMCFG2);
> > +	pmcfg2 &=3D ~FIELD_PREP(MX93_PMCFG2_ID, 0x3FFFF);
> > +	pmcfg2 |=3D FIELD_PREP(MX93_PMCFG2_ID, axi_id);
> > +	writel_relaxed(pmcfg2, pmu->base + PMCFG2);
> >  }
> >
> >  static void ddr_perf_event_update(struct perf_event *event)
> > @@ -513,7 +527,7 @@ static int ddr_perf_event_add(struct perf_event *ev=
ent, int flags)
> >  		ddr_perf_event_start(event, flags);
> >
> >  	/* read trans, write trans, read beat */
> > -	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
> > +	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
> >
> >  	return 0;
> >  }
> > --
> > 2.34.1
> >

