Return-Path: <linux-kernel+bounces-96586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B885875E96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0C81F2344F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20E04F214;
	Fri,  8 Mar 2024 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MET6RWCg"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D384AE555;
	Fri,  8 Mar 2024 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883184; cv=fail; b=JJY+aGRqpz+0fHrqRGzeumfBZCaOW8z3WnVsK/JwSBibvjJd8G9bAer4UCo47JfoDGxNVHrEVqzzT1kEKX2hoocOswibb6BQB51xuSlpDXJVJAOfVENNFbZwZBiX3URCW1xG4N89VRXWZlgC4O7tMyCaTw0oY1gh6zjQ9ACOjXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883184; c=relaxed/simple;
	bh=aJ0iI+Evqdw5xrCyTTk9EzGvsdrY24eEDge1f4Fp8BQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bo8aTFL33iL4a977dTR59H38ESi6w4/0hAK7ffaF0JGzDSfRaZlznwLBq/YQPQpRJvlWmJ5CjOKgHE/NwmigdGPh+fk97TRmvp74eqkgwwqkw9AD1+R3XpVRVE0QUvRAfIeV9GWkEFn/R3uO5QFIAH78H9uGYO8MOS/zuxuU3AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MET6RWCg; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxOkwRyCamVYDZE0LySOFwc1QzM1tICDTZ2siw5Zqv0hLtqNICxFgc1+baVuzyk/KSxX85LebEEDKzOP0xYZyyZhx/cZbQovtb9uvxqnOuGgQxxBQjbHuIWzJ1ZFc3tG1X9FkVc+PmNaXQpPG+GTfeKe5b0C5/Cwgq4yiDBR5YXfZZD05WMMkOHWuvZVaFNP5tgusGz6t/Vte6RKwZMXbGyOC215NS9NeTiYx5CAYTHHkcHL8n5sTDikz+HpOF83FwEBcHNRe7wFZe05NL6bLV8Gg3KtwJB/t9IWtWoqaLpuOLzVGnbUFgbFu3b47Oh1RCqmx5IK0GVd9QYFWCDvKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7EW6KNJGWIyZaHBis5e6e3+6PyJz58M2KGsxp24kSQ=;
 b=SY017MjSzc6oJ7ChV7HCOO4xVpUwA3HtTYlVfFxVCjk2q21C4RgE1Rimj3soCMOLRcOISwaTs0/f/88puRBXyT1FF0GTKsCn38QKH9BekUYzJTj47IAKZmyRVI5TBHFHoNaMoS/fH7Z062SZyI1pRX9wpMEr4XHwKC+XTujmTQ004WpMUpwfslz3fDXbyhygE/iRMQ77xnbXusKMHqQ0A1XJjlwHD0DHyxvDmse3a6kix04tndXiAfpgc23NUSkulpG6+ZheklSWmB4CqMXuqm+8i+uWwv6Pg04j2XMjqSltKvAIbax44psGpC1FgdlxDlLH5rmVdI+bs4C3/Ynxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7EW6KNJGWIyZaHBis5e6e3+6PyJz58M2KGsxp24kSQ=;
 b=MET6RWCgZrufsvHO8LLBmsrIKMX3I6Looq2GjWD1gH3RYFcJkZDl0BpfgTwnoUwEnoaQ9DsdfjVROXXZ6XGCmjRW9SP4FDqJYRynHiPCdrtlM9gmXmuimvm1c1L7RQhoDGN3juobcypgxb5nEx5SQhWFFLxLK9dEzFqrI/nJ8TQ=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM7PR04MB6999.eurprd04.prod.outlook.com (2603:10a6:20b:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 07:32:58 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Fri, 8 Mar 2024
 07:32:57 +0000
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
Subject: RE: [PATCH v6 4/7] perf: imx_perf: refactor driver for imx93
Thread-Topic: [PATCH v6 4/7] perf: imx_perf: refactor driver for imx93
Thread-Index: AQHacHXnJDlhKGFOKEyD8xAIge0Eu7Esf7qAgAD0xrA=
Date: Fri, 8 Mar 2024 07:32:57 +0000
Message-ID:
 <DU2PR04MB88227164FCBEDC50AD42606E8C272@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240307095730.3792680-1-xu.yang_2@nxp.com>
 <20240307095730.3792680-4-xu.yang_2@nxp.com>
 <ZenxnY83dnYIT9dJ@lizhi-Precision-Tower-5810>
In-Reply-To: <ZenxnY83dnYIT9dJ@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AM7PR04MB6999:EE_
x-ms-office365-filtering-correlation-id: 9538b39c-d68e-4fd8-857c-08dc3f41f9c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JqRWMOss45cWfuihLXLVN4JyBg+qzvrO5iVLrVYv940YarbZK5lDH04AXQg3PQWY4vmniJBvR+BTDaqoxmsallllC9uPeLPfGgd9KjOGP+CBx7FKULbk3Vo7K4mAkaVHMdNZVPgh2aG26vjAu45J/LnsiS09KutZI3+RozXWBJ9oQpT31lhZO+35S25TsWq267CJRxTKrlrC2tsfLYFUrJgmILKWqPPS2YYUXYLcXHVJ0cl4pPN+k5lquvSbrlpRZfD50UJnr3h+gVK0if4ggSs4rJQghX7OmLKJ+WwLdlh9/4uCG4LR9RoCun1yflXwmYvlA4bHDjrKQc3rhehl9hQyuZUwza73LHbSRDzb1rKSFRgWFl9OwtMzNJzCBIkQtHkRJgUHL+RaSuXGDUlPRtplKrW9OwyPEj6KDnhG9v+efDtnVkPgOTupwMAU/3dk1sNFA0rw8YV1lj9GALMyqXJ1W7bclZ9vP7RjBh84/01LlSA2qdP/PXCwi0AkKfybqHyJ0ZDMfMUU+ngLZblbPpDHV7LDjwMn42t8U9UjRdZJW8hZQifjwGe5y1UelG56AFU/kMyNMGSt0Hp4XfxOhB/njRt066m3/yrvaOdfm+3lKIuCxsVms60u/8/5TGCHMden2w9UevlzdF1Lydg++hFNtBkCEpIvXSD8MBpFSCN/iPfUK5vU1/leSpbu+yyq0kqRHEbqP7YeruUHg9QmONnz3GRIkp27F6PXqVS46bY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jx/uaSF5CMt0+ZdYjvnPG95JKsRV5KCDJpPIL77MNrgo6fan3ZObxljhszjQ?=
 =?us-ascii?Q?LW0uwSm3+3IBclj8GQsuiw61SXPEGoBL7LJ6ylVb4ray3eCCUpf7YWyw13af?=
 =?us-ascii?Q?i8KCo4V0WaSj12U4mIzcem7S1ZPIASo6ph4/GUQNeKxo4aWJEW92gA7HXFeu?=
 =?us-ascii?Q?f10vQlj9ptHQFKcMF22PLMvCW8aPQlrdl8g5SvpYZ5AN3wY50CGeyutb3xot?=
 =?us-ascii?Q?Tp1qjn0N+F3aROn94rSg1TZ3bArBaRrUTp4QG9fTxy6Xigup1GWwSABGTvg1?=
 =?us-ascii?Q?IRzZzzFkO+EJw+g/o4AL+fkWVR4CaW7Xv7kQaLSpVMPoEH9mYrE102ytNUM/?=
 =?us-ascii?Q?u/n7HiElYa421AXLzl49Q0RJFfY+cRIIOk9BjUzgdfyOR4/ChxN07txfwuCF?=
 =?us-ascii?Q?Uz04ZjzQK5wvgFI7ETh2S7rFaMoQIcZ/Q0suxTjgX2doOYFQC9VscyMl9WQH?=
 =?us-ascii?Q?/tneTr9+8WtfVc+8txEBVBbL76XX67y8Fra6z/uDzwB5aZF9WB0CvYGxB+qC?=
 =?us-ascii?Q?aI52hIsiTTLgc35Id0bpC9SHQxKwMauRuOaknAnhIrgDAEFPQqU8iHuq0ZRA?=
 =?us-ascii?Q?xAyTOQaV1iac5GgH5cudnu9Q0ueVV2VO+FHMGLQFrsnpQkAybkFegUuj8Ho8?=
 =?us-ascii?Q?lffAwnPQZW9JoyIkl30hZ8xvkxOP4W72PYk7x8HES6qNhso4eAQsvHjABvme?=
 =?us-ascii?Q?tyPRUw+ISwNEWTtF6d4bTmjy8oXcYk/0yVxv9igru7ddVel7gEDCpx8a3MCn?=
 =?us-ascii?Q?NJB81BHHRodmnYGlcZbrgbwaXqcdI/qxIqeqZyjBOL30e/ti1JNqYT1CAks2?=
 =?us-ascii?Q?MmdaWmdfY8VIHCJ/GlX3l/EtRiQ5isRvc+Lq990YKBlMDEHnWGCfioEwkoKq?=
 =?us-ascii?Q?fIt0Ec9PVZjkpG5IS+VxpFJAmHb26vhjBW9EbY36TktKSSofgDGY0Yno2YgZ?=
 =?us-ascii?Q?5bjQNsfua6QmkqmckiKw3glfXI0mDjaBhTI9Hlj0VRi35RxCYu8OdGWWykEa?=
 =?us-ascii?Q?ON7nxgt9zZ9dNbLcddxEFHpL909ZdHckN0kzA4jXtINWOGLW3eb+bmReXgQ+?=
 =?us-ascii?Q?G7n9c9UezhYW3IIuJ70k7JkftT+4hAuuA0qBLeabrQgy071gRmGn8MUM54mV?=
 =?us-ascii?Q?Iov3HD8Fl/3qOS63/VQg25xi/dRHJjXvdA4qbEuuIEW+CuKZTcTIPPn+ccLK?=
 =?us-ascii?Q?jfEV6LdR3/RDoStaNOZwvypG4xavltGta4Zov8dpebfh4DuM3W3OjTLzBRz5?=
 =?us-ascii?Q?5bKCT1Gdyz80apAKk1PbLeRk5hKXkce9/E9V6M/rtAK3lzFePB9LyyDK5a5V?=
 =?us-ascii?Q?IBonRLqExkiHkoRyc0YAceFLY9XqT9P4O+ZrSEv1F3/K8193VGSrsJ1aj11d?=
 =?us-ascii?Q?fx+PO47CLYI8FaIxiTS5+5W1qo+JXY5RJT2rUUTMyOEQ7UleIYrIP2vrI+FF?=
 =?us-ascii?Q?r2BZ4SlZxx5c9nzRjdOwghQVdHggzA4AMI3CjqbynmzQ2kxmCRB6053yVlRP?=
 =?us-ascii?Q?c7ZM4e4I+17Qu2MpNcrMHLvaSb5fjQXOXz1WcFwN2djKmpaxEYYfDfxhNJeW?=
 =?us-ascii?Q?U7B8Q8lazQG2uKbnXvw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9538b39c-d68e-4fd8-857c-08dc3f41f9c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:32:57.5489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZ58zPNcpVSb3Jl3/DjEmeJaJP9pUSf/apyxoT79UpVdwl9H/rDlLX6opoCKMUDnvz69vANdFu54aPUKUXYZ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999


>=20
> On Thu, Mar 07, 2024 at 05:57:27PM +0800, Xu Yang wrote:
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
> > ---
> >  drivers/perf/fsl_imx9_ddr_perf.c | 99 +++++++++++++++++++++-----------
> >  1 file changed, 66 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_d=
dr_perf.c
> > index 8d85b4d98544..4e8a3a4349c5 100644
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
> > @@ -77,6 +77,11 @@ static const struct imx_ddr_devtype_data imx93_devty=
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
> > @@ -186,7 +191,7 @@ static struct attribute *ddr_perf_events_attrs[] =
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
> > @@ -198,7 +203,7 @@ static struct attribute *ddr_perf_events_attrs[] =
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
> > @@ -210,7 +215,7 @@ static struct attribute *ddr_perf_events_attrs[] =
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
> > @@ -245,9 +250,26 @@ static struct attribute *ddr_perf_events_attrs[] =
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
> > @@ -369,36 +391,47 @@ static void ddr_perf_counter_local_config(struct =
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
> > +	if (event =3D=3D 73) {
> > +		switch (counter) {
> > +		case 2:
> > +			pmcfg1 |=3D MX93_PMCFG1_RD_TRANS_FILT_EN;
> > +			break;
> > +		case 3:
> > +			pmcfg1 |=3D MX93_PMCFG1_WR_TRANS_FILT_EN;
> > +			break;
> > +		case 4:
> > +			pmcfg1 |=3D MX93_PMCFG1_RD_BT_FILT_EN;
> > +			break;
> > +		}
> > +	} else {
> > +		switch (counter) {
> > +		case 2:
> > +			pmcfg1 &=3D ~MX93_PMCFG1_RD_TRANS_FILT_EN;
> > +			break;
> > +		case 3:
> > +			pmcfg1 &=3D ~MX93_PMCFG1_WR_TRANS_FILT_EN;
> > +			break;
> > +		case 4:
> > +			pmcfg1 &=3D ~MX93_PMCFG1_RD_BT_FILT_EN;
> > +			break;
> > +		}
> > +	}
>=20
> how about
> 	u32 mask[] =3D { 	MX93_PMCFG1_RD_TRANS_FILT_EN,
> 			MX93_PMCFG1_WR_TRANS_FILT_EN,
> 			MX93_PMCFG1_RD_BT_FILT_EN
> 	      	     };
>=20
> 	if (couter >=3D2 && counter <=3D 4)
> 		event =3D=3D 73 ? pmcfg1 |=3D mask[counter - 2] :
> 			      pmcfg1 &=3D ~mask[counter - 2];

It seems ok for me. Will try this.

Thanks,
Xu Yang

>=20
>=20
> Frank
>=20
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
> > @@ -514,7 +547,7 @@ static int ddr_perf_event_add(struct perf_event *ev=
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

