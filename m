Return-Path: <linux-kernel+bounces-105736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A722587E3A6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A661C20E40
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631DF22EFD;
	Mon, 18 Mar 2024 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RcmmN+EY"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C65D21A19;
	Mon, 18 Mar 2024 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710742740; cv=fail; b=OCmetSHLiT4hdtrHBo4whRBcIPbCeP8eJARCiupyxFmR8ztAyYMdwYpZQOCV11s26O1btAep6/xZ4kIp0v5DhFGQAHaN5HRxZwnsl/0a/hicyBJXFuEvZF4DaW5mwgyipz7BlrtgzAHASAj/RHTpvDH9YfG69Ef/5c6Or9RNrVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710742740; c=relaxed/simple;
	bh=KEMQgtYdJRypVhtjXt0TgX8+544LjzcWKMSqPsH5ues=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WU+D1cDi7Eg5HaG/LJYyljwuK0q0tOdHgEzoKm7YfMC4lhTT0/8ZtvOrgVYVR0pq/NFLtJmBqKM4d5Vc70ddTjX4Kod/mE06THZ6U+oJ+79baFeownI3nuUJJH/gNuE4oDwcaBuOFJi7uxx9GBFtin6NDXEgzXimQSSvRdNgBCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RcmmN+EY; arc=fail smtp.client-ip=40.107.105.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kW7VLO6fpmkynemLvhKjabeR8+/DUBlV1zt+zL/cCsPmpq/fDnCRZLL0iX17FFnCuSIFq6/iwhd3WSDQ9ko7CBhWVubsfRrnhxI42A8abXk96XSgmjet7rrLGQqeMz4t/Tee2Spu145rmKwfv0UmMJ7i+W9R+ud3MUEIcg5UwtbAfw/mgVFc9Rg8Rro2AfD0P1aqF4fXvl8d9IetDw4Jz3oCZci4v29jlvu03J+jUW5UCBE93DMv95lFphrUD+72AZH8qeR4Zjug3mA/5J612W7r1CDd3yzUW2IpoppTAVBB3eB3JW8sAgQsO8qfVAQzqW9vwvxcQqP/zNYqVooNpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v97SlTxDzM55ppeZegGiAbcfYXKHdT9XeR3nl/jtqWc=;
 b=YUpxlNXMy/ET9UPO3FIJwFddWCrwInHWEzCEyn0Os2GIyQj3XnknkVnbZVnubqI4fRvMbuz9bDMdP8OKXSh8e3q7fUYIQmzk6N4BuqpLArbZZjIckjc9yJM/2TeQ7gUXiGdnG/UjjeMxTVBI9oUlUYm9HiN1dz5y72xzQieYt4lH3B+C6fYUnndPZNUY4/r96RqjGZC0fL+rhCBZz0FX5QSNkPfHVdx+CieOEMOIqcGXSLTr1/R/9DdWDbIDZWQqOoCEwLqJC41likFOuM1pBDlfCzoqNQQ78ZcTCV4d56P+9091toE/8mtJg8nM9F7LIrX3PTKgh1htx8+Q3U9JAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v97SlTxDzM55ppeZegGiAbcfYXKHdT9XeR3nl/jtqWc=;
 b=RcmmN+EYj2ZFOsxbsSrEwBHB1FFqnhNAE8pkq+7Xg0ePzf2wpkmlqj1rKqWYpvmdUcnzZOy9qeO97loVDyHVMr1YCb+QoCrl2II6noX6OpbgYIRjqRCaXuWmiOVllz0r9ZOD9JA7NK6Xba4iaJ0s4UonTwolkhME+gKoxUzYsmE=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM7PR04MB6870.eurprd04.prod.outlook.com (2603:10a6:20b:107::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 06:18:53 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 06:18:52 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v7 7/8] perf vendor events arm64:: Add i.MX95
 DDR Performance Monitor metrics
Thread-Topic: [EXT] Re: [PATCH v7 7/8] perf vendor events arm64:: Add i.MX95
 DDR Performance Monitor metrics
Thread-Index: AQHadr8M+RfJ8GNQcUWVLy175Ixi/bE5QGWAgAPHhDA=
Date: Mon, 18 Mar 2024 06:18:52 +0000
Message-ID:
 <DU2PR04MB8822D36B2C8EDF0F36DA19AA8C2D2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240315095555.2628684-1-xu.yang_2@nxp.com>
 <20240315095555.2628684-7-xu.yang_2@nxp.com> <ZfSuw5KbopW0PiPp@x1>
In-Reply-To: <ZfSuw5KbopW0PiPp@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AM7PR04MB6870:EE_
x-ms-office365-filtering-correlation-id: 3831075f-70d2-489c-27f8-08dc4713488c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Cx76maSnR9ZJwVHeYCniLDzsn+3frNHrRtl76FTLJGSa5sXn3ABuMTUyY58hr8k4w86JrJVuRd4jZWoShSRzvY5huS1/2xdUnlhSYiHvhFHjjxW/B2G4NXq7z5+dxF8oQAWF4vmrxLtdpwRUqqTYRnQjG+1nCcp87+Ilz03ZF0XdigjF61YZ8e3fhyPYiUWjhWANo9prSqbicqX8iqOfx+VZb5OWgtYmBTO5LjPObC9bXsvf5ZWLbSGYhZFiP7xPO6Op36JcvKT8Hgg2hnl+FLX0o+sTr0Zh9OdsBNIewoE8X8/3tqLVBDYoMh1MfV18nUIrMcQcR/w/2qNaPFjWluytvdzQZa+FW09JBfXmNPXtMQnzHoZj65lDE0ly6lJBtKsvzTlu7xXRA5vgkon/LbYbTxztfTdBoQ/w7Ii4ZWEAIV3dMplpEovarXHB1iD8cxQuY1nzoASTFJon5zHmwAi9TPoXt7RkButNb/WEM7rXS65dv9u9iOwJE6yJEdeBRt4N//ihbWrRSkL2Uujj2POSTc1NrAXouLGio+ggDjA5kR/qNlHs59NHzVRpTwVoTW817z3BCKd3bkURR8LEdWp/2bEVDuW5qMg4zze9eemayNC/SEDvquuyOrFhj86GPTw+jeGoM36O5hqVue39G0Ys0kpNfTomPiNIh8Hz7jux7rYctwB7ZxjItglH75T/qfT0FU8BmIfrrwh031va1Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F7heXMLwTUuLqfWkV+P7RxG4deE1m0UJPMybqK1x2XdQel0kxfXDb3kHwMU5?=
 =?us-ascii?Q?dhOt6cXCosY4oQ/2ZNCesnRdh/dGXtK6Bz6RvwmWM2PEEuw5u2GFerlHgrgh?=
 =?us-ascii?Q?QhQi+gyj3R0a9MQj6oL19uxJ7hCTtnIZZu24IfnVzKLy8Tsik6i8amTx8MXT?=
 =?us-ascii?Q?SY++SBTewbvbhbyv6clQ/G2FTcHjg8KGbv1vovYPqrfW98NyNt2N03BM5RK/?=
 =?us-ascii?Q?Egw7GRzJvD9nB7BYBgqkToyzdvF3/RgAzJdPuklyF/HvHEfW9NlJIqQfzDCT?=
 =?us-ascii?Q?+yyQYLN8Rmo45kS8HkH282+xjb+x1SalvjeNoLsC3g7zRz/U9mu3JH6Erd8j?=
 =?us-ascii?Q?QkT77slZ0+YZflwzvFIX0iBMrH1RBHVf3RcQHtF8tK1iFvcgVq63B9+TXygF?=
 =?us-ascii?Q?chTHcD9GOOEdEMxmlk1ntBy6zVWNqvIbyDlarsHc5q3XszhciUYNp7WYMysv?=
 =?us-ascii?Q?TfFRIB/H+Hq7s52nicEMMNZs2zAnHLiHvcyIX0c1zrk05CzMWXCKNYMTp7G/?=
 =?us-ascii?Q?0/4g+893yzwfq/bVv0rjqCRY81kXfzkd38BEM0nFgIuXOxvCtIchffv4WGaW?=
 =?us-ascii?Q?kMR/vNdjALG33LF8YrFqV+lG43fN8ImWkIS8VSwPhmbxG1IUaeWdh0FMslRf?=
 =?us-ascii?Q?jxZ3l27yiVWXgzyFHj3ejk4S5uMw6T7uK2gIsrLI1GTiVXj31udXvMA92z+9?=
 =?us-ascii?Q?SzS2/HcYI9rv0gtmocEvkotOq9yM4h93b5WSGx/0SFmbl7fF9HaJLXeiXALO?=
 =?us-ascii?Q?aMNlVLxO7Ok0VPHmwRYKttICE82/yeo463XYyNjh3pbSzLh+gxorcoiggXNS?=
 =?us-ascii?Q?7AnNYEmtraVZfc4Nfm0tD/ojr3bi0Tk8V4FM558NudRD51z6k51GQxGU1Zhe?=
 =?us-ascii?Q?5RclTZIWceZPuKkUGPOhUY1GmZGc8sl/oiOgZwRWTkSvscaZbVnliFKbX3UQ?=
 =?us-ascii?Q?DcsPIM4ss+FSCp2OYGXsQRUt08gr0ihqLPyHiSx2nwMdFx0SDO5yX5Il73QC?=
 =?us-ascii?Q?Xk9sgPPLAKvornO5/l/sznW/kdMfyGfGgJqX6GIUpBOhNrHVoi16deAOSoC7?=
 =?us-ascii?Q?6MzGL5mWfQ3FsQGM0V6pJ+DutrSxD38TJUzILtS9W/ViJTQXiSG+4uTyAESn?=
 =?us-ascii?Q?6DOI3rUyuEHgHbItAELRiI1JT/PnMnvudiH8PH28T7gDvCii5CO5xwLpLIEM?=
 =?us-ascii?Q?Y3lksYUCG+tJ8kFyZXLrHDSmhJn3lrQ6+I4CVupZukD12put9nDW7XeIlqSX?=
 =?us-ascii?Q?a85BqHdepb1sIUyoKwWjZYv+LlKCUlo6HXeEIG3y1QF1EEAa50DWOORREqs4?=
 =?us-ascii?Q?GdoH4yQ8CWWo4qzLcPAdWXLtTMwY4VPyGT/MUckVMywSsUULOK9S0HCSJpia?=
 =?us-ascii?Q?7r0+iH9z5vVk0QSRmtq1EW8wEeykHEoB8oO5jP+3q3rBfgNcc0rKITYabF9C?=
 =?us-ascii?Q?e0noPibAUJNTjNRyE3j/VmY5b2c50mWOVc6C1dC7ETHCzjtjVLIbIcvLDINc?=
 =?us-ascii?Q?X+c3uTUqWWK4F/hKeqR4SCum203Tlq50HOtY/MY5JA/YWjH9imLgxVEXgHIt?=
 =?us-ascii?Q?/faao69SWSV18h8DBUY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3831075f-70d2-489c-27f8-08dc4713488c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 06:18:52.6499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKC8sSZ4OopmAzxxFrKJuGYLuvFcQAT3ksCW/YyKJYrq27ZCE5Revg4lBUXPb8vup2cs8F0SHQQaSjGqVuQp+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6870

Hi Arnaldo,

>=20
> On Fri, Mar 15, 2024 at 05:55:54PM +0800, Xu Yang wrote:
> > Add JSON metrics for i.MX95 DDR Performance Monitor.
> >
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>=20
> I'm applying the tools/perf/ patches, that is 7/8 and 8/8, but I noticed
> that 8/8 has no Reviewed-by tags, is that really the case? If so, can we
> have them?

I found IMX93 metrics are still not added until v6, then I add patch 8/8 in=
 v7.
So it's still waiting for review I think. Sorry for inconvenience.

Thanks,
Xu Yang

>=20
> - Arnaldo
>=20
> > ---
> > Changes in v2:
> >  - fix wrong AXI_MASK setting
> >  - remove unnecessary metrics
> >  - add bandwidth_usage, camera_all, disp_all metrics
> > Changes in v3:
> >  - no changes
> > Changes in v4:
> >  - add Reviewed-by tag
> > Changes in v5:
> >  - fix typo
> > Changes in v6:
> >  - remove "counter=3DX" from each metric
> > Changes in v7:
> >  - add RB tag
> > ---
> >  .../arch/arm64/freescale/imx95/sys/ddrc.json  |   9 +
> >  .../arm64/freescale/imx95/sys/metrics.json    | 778 ++++++++++++++++++
> >  tools/perf/pmu-events/jevents.py              |   1 +
> >  3 files changed, 788 insertions(+)
> >  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sy=
s/ddrc.json
> >  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sy=
s/metrics.json
> >
> > diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.=
json b/tools/perf/pmu-
> events/arch/arm64/freescale/imx95/sys/ddrc.json
> > new file mode 100644
> > index 000000000000..4dc9d2968bdc
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
> > @@ -0,0 +1,9 @@
> > +[
> > +   {
> > +           "BriefDescription": "ddr cycles event",
> > +           "EventCode": "0x00",
> > +           "EventName": "imx95_ddr.cycles",
> > +           "Unit": "imx9_ddr",
> > +           "Compat": "imx95"
> > +   }
> > +]
> > diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metri=
cs.json b/tools/perf/pmu-
> events/arch/arm64/freescale/imx95/sys/metrics.json
> > new file mode 100644
> > index 000000000000..a3ae787d448c
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
> > @@ -0,0 +1,778 @@
> > +[
> > +     {
> > +             "BriefDescription": "bandwidth usage for lpddr5 evk board=
",
> > +             "MetricName": "imx95_bandwidth_usage.lpddr5",
> > +             "MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi=
_mask\\=3D0x000\\,axi_id\\=3D0x000@ +
> imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=3D0x000\\,axi_id\\=3D0x000@=
 ) * 32 / duration_time) / (6400 * 1000000 *
> 4)",
> > +             "ScaleUnit": "1e2%",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of all masters read from ddr",
> > +             "MetricName": "imx95_ddr_read.all",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x000\\,axi_id\\=3D0x000@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of all masters write to ddr",
> > +             "MetricName": "imx95_ddr_write.all",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x000\\,axi_id\\=3D0x000@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of all a55 read from ddr",
> > +             "MetricName": "imx95_ddr_read.a55_all",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3fc\\,axi_id\\=3D0x000@ +
> imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=3D0x3fe\\,axi_id\\=3D0x004=
@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of all a55 write to ddr (part1=
)",
> > +             "MetricName": "imx95_ddr_write.a55_all_1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3fc\\,axi_id\\=3D0x000@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of all a55 write to ddr (part2=
)",
> > +             "MetricName": "imx95_ddr_write.a55_all_2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3fe\\,axi_id\\=3D0x004@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of a55 core 0 read from ddr",
> > +             "MetricName": "imx95_ddr_read.a55_0",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3ff\\,axi_id\\=3D0x000@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of a55 core 0 write to ddr",
> > +             "MetricName": "imx95_ddr_write.a55_0",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3ff\\,axi_id\\=3D0x000@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of a55 core 1 read from ddr",
> > +             "MetricName": "imx95_ddr_read.a55_1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x001@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of a55 core 1 write to ddr",
> > +             "MetricName": "imx95_ddr_write.a55_1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x001@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of a55 core 2 read from ddr",
> > +             "MetricName": "imx95_ddr_read.a55_2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x002@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of a55 core 2 write to ddr",
> > +             "MetricName": "imx95_ddr_write.a55_2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x002@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of a55 core 3 read from ddr",
> > +             "MetricName": "imx95_ddr_read.a55_3",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x003@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of a55 core 3 write to ddr",
> > +             "MetricName": "imx95_ddr_write.a55_3",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x003@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of a55 core 4 read from ddr",
> > +             "MetricName": "imx95_ddr_read.a55_4",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x004@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of a55 core 4 write to ddr",
> > +             "MetricName": "imx95_ddr_write.a55_4",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x004@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of a55 core 5 read from ddr",
> > +             "MetricName": "imx95_ddr_read.a55_5",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x005@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of a55 core 5 write to ddr",
> > +             "MetricName": "imx95_ddr_write.a55_5",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x005@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP=
 transactions read from ddr",
> > +             "MetricName": "imx95_ddr_read.cortexa_dsu_l3",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x007@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP=
 transactions write to ddr",
> > +             "MetricName": "imx95_ddr_write.cortexa_dsu_l3",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x007@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of m33 read from ddr",
> > +             "MetricName": "imx95_ddr_read.m33",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x008@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of m33 write to ddr",
> > +             "MetricName": "imx95_ddr_write.m33",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x008@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of m7 read from ddr",
> > +             "MetricName": "imx95_ddr_read.m7",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x009@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of m7 write to ddr",
> > +             "MetricName": "imx95_ddr_write.m7",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x009@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of sentinel read from ddr",
> > +             "MetricName": "imx95_ddr_read.sentinel",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x00a@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of sentinel write to ddr",
> > +             "MetricName": "imx95_ddr_write.sentinel",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x00a@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of edma1 read from ddr",
> > +             "MetricName": "imx95_ddr_read.edma1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x00b@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of edma1 write to ddr",
> > +             "MetricName": "imx95_ddr_write.edma1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x00b@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of edma2 read from ddr",
> > +             "MetricName": "imx95_ddr_read.edma2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x00c@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of edma2 write to ddr",
> > +             "MetricName": "imx95_ddr_write.edma2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x00c@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of netc read from ddr",
> > +             "MetricName": "imx95_ddr_read.netc",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x00d@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of netc write to ddr",
> > +             "MetricName": "imx95_ddr_write.netc",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x00d@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of npu read from ddr",
> > +             "MetricName": "imx95_ddr_read.npu",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x010@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of npu write to ddr",
> > +             "MetricName": "imx95_ddr_write.npu",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x010@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of gpu read from ddr",
> > +             "MetricName": "imx95_ddr_read.gpu",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x020@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of gpu write to ddr",
> > +             "MetricName": "imx95_ddr_write.gpu",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x020@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of usdhc1 read from ddr",
> > +             "MetricName": "imx95_ddr_read.usdhc1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x0b0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of usdhc1 write to ddr",
> > +             "MetricName": "imx95_ddr_write.usdhc1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x0b0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of usdhc2 read from ddr",
> > +             "MetricName": "imx95_ddr_read.usdhc2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x0c0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of usdhc2 write to ddr",
> > +             "MetricName": "imx95_ddr_write.usdhc2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x0c0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of usdhc3 read from ddr",
> > +             "MetricName": "imx95_ddr_read.usdhc3",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x0d0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of usdhc3 write to ddr",
> > +             "MetricName": "imx95_ddr_write.usdhc3",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x0d0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of xspi read from ddr",
> > +             "MetricName": "imx95_ddr_read.xspi",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x0f0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of xspi write to ddr",
> > +             "MetricName": "imx95_ddr_write.xspi",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x0f0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of pcie1 read from ddr",
> > +             "MetricName": "imx95_ddr_read.pcie1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x100@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of pcie1 write to ddr",
> > +             "MetricName": "imx95_ddr_write.pcie1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x100@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of pcie2 read from ddr",
> > +             "MetricName": "imx95_ddr_read.pcie2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x006@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of pcie2 write to ddr",
> > +             "MetricName": "imx95_ddr_write.pcie2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x006@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of pcie3 read from ddr",
> > +             "MetricName": "imx95_ddr_read.pcie3",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x120@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of pcie3 write to ddr",
> > +             "MetricName": "imx95_ddr_write.pcie3",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x120@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of pcie4 read from ddr",
> > +             "MetricName": "imx95_ddr_read.pcie4",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x130@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of pcie4 write to ddr",
> > +             "MetricName": "imx95_ddr_write.pcie4",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x130@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of usb1 read from ddr",
> > +             "MetricName": "imx95_ddr_read.usb1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x140@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of usb1 write to ddr",
> > +             "MetricName": "imx95_ddr_write.usb1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x140@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of usb2 read from ddr",
> > +             "MetricName": "imx95_ddr_read.usb2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x150@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of usb2 write to ddr",
> > +             "MetricName": "imx95_ddr_write.usb2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x150@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of vpu codec primary bus read =
from ddr",
> > +             "MetricName": "imx95_ddr_read.vpu_primy",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x180@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of vpu codec primary bus write=
 to ddr",
> > +             "MetricName": "imx95_ddr_write.vpu_primy",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x180@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of vpu codec secondary bus rea=
d from ddr",
> > +             "MetricName": "imx95_ddr_read.vpu_secndy",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x190@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of vpu codec secondary bus wri=
te to ddr",
> > +             "MetricName": "imx95_ddr_write.vpu_secndy",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x190@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of jpeg decoder read from ddr"=
,
> > +             "MetricName": "imx95_ddr_read.jpeg_dec",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x1a0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of jpeg decoder write to ddr",
> > +             "MetricName": "imx95_ddr_write.jpeg_dec",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x1a0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of jpeg encoder read from ddr"=
,
> > +             "MetricName": "imx95_ddr_read.jpeg_dec",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x1b0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of jpeg encoder write to ddr",
> > +             "MetricName": "imx95_ddr_write.jpeg_enc",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x1b0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of all vpu submodules read fro=
m ddr",
> > +             "MetricName": "imx95_ddr_read.vpu_all",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x380\\,axi_id\\=3D0x180@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of all vpu submodules write to=
 ddr",
> > +             "MetricName": "imx95_ddr_write.vpu_all",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x380\\,axi_id\\=3D0x180@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of cortex m0+ read from ddr",
> > +             "MetricName": "imx95_ddr_read.m0",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x200@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of cortex m0+ write to ddr",
> > +             "MetricName": "imx95_ddr_write.m0",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x200@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of camera edma read from ddr",
> > +             "MetricName": "imx95_ddr_read.camera_edma",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x210@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of camera edma write to ddr",
> > +             "MetricName": "imx95_ddr_write.camera_edma",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x210@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isi rd read from ddr",
> > +             "MetricName": "imx95_ddr_read.isi_rd",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x220@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isi rd write to ddr",
> > +             "MetricName": "imx95_ddr_write.isi_rd",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x220@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isi wr y read from ddr",
> > +             "MetricName": "imx95_ddr_read.isi_wr_y",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x230@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isi wr y write to ddr",
> > +             "MetricName": "imx95_ddr_write.isi_wr_y",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x230@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isi wr u read from ddr",
> > +             "MetricName": "imx95_ddr_read.isi_wr_u",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x240@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isi wr u write to ddr",
> > +             "MetricName": "imx95_ddr_write.isi_wr_u",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x240@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isi wr v read from ddr",
> > +             "MetricName": "imx95_ddr_read.isi_wr_v",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x250@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isi wr v write to ddr",
> > +             "MetricName": "imx95_ddr_write.isi_wr_v",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x250@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isp input dma1 read from dd=
r",
> > +             "MetricName": "imx95_ddr_read.isp_in_dma1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x260@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isp input dma1 write to ddr=
",
> > +             "MetricName": "imx95_ddr_write.isp_in_dma1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x260@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isp input dma2 read from dd=
r",
> > +             "MetricName": "imx95_ddr_read.isp_in_dma2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x270@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isp input dma2 write to ddr=
",
> > +             "MetricName": "imx95_ddr_write.isp_in_dma2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x270@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isp output dma1 read from d=
dr",
> > +             "MetricName": "imx95_ddr_read.isp_out_dma1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x280@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isp output dma1 write to dd=
r",
> > +             "MetricName": "imx95_ddr_write.isp_out_dma1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x280@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isp output dma2 read from d=
dr",
> > +             "MetricName": "imx95_ddr_read.isp_out_dma2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x290@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of isp output dma2 write to dd=
r",
> > +             "MetricName": "imx95_ddr_write.isp_out_dma2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x290@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of all camera submodules read =
from ddr",
> > +             "MetricName": "imx95_ddr_read.camera_all",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x380\\,axi_id\\=3D0x200@ +
> imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x280=
@ +
> imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x290=
@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of all camera submodules write=
 to ddr (part1)",
> > +             "MetricName": "imx95_ddr_write.camera_all_1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x380\\,axi_id\\=3D0x200@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of all camera submodules write=
 to ddr (part2)",
> > +             "MetricName": "imx95_ddr_write.camera_all_2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x280@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of all camera submodules write=
 to ddr (part3)",
> > +             "MetricName": "imx95_ddr_write.camera_all_3",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x290@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of display blitter store read =
from ddr",
> > +             "MetricName": "imx95_ddr_read.disp_blit",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x2a0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of display blitter write to dd=
r",
> > +             "MetricName": "imx95_ddr_write.disp_blit",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x2a0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of display command sequencer r=
ead from ddr",
> > +             "MetricName": "imx95_ddr_read.disp_cmd",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x2b0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of display command sequencer w=
rite to ddr",
> > +             "MetricName": "imx95_ddr_write.disp_cmd",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x2b0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of all display submodules read=
 from ddr",
> > +             "MetricName": "imx95_ddr_read.disp_all",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x300\\,axi_id\\=3D0x300@ +
> imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=3D0x3a0\\,axi_id\\=3D0x2a0=
@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of all display submodules writ=
e to ddr (part1)",
> > +             "MetricName": "imx95_ddr_write.disp_all_1",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x300\\,axi_id\\=3D0x300@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     },
> > +     {
> > +             "BriefDescription": "bytes of all display submodules writ=
e to ddr (part2)",
> > +             "MetricName": "imx95_ddr_write.disp_all_2",
> > +             "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3a0\\,axi_id\\=3D0x2a0@ ) * 32",
> > +             "ScaleUnit": "9.765625e-4KB",
> > +             "Unit": "imx9_ddr",
> > +             "Compat": "imx95"
> > +     }
> > +]
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/j=
events.py
> > index 53ab050c8fa4..be4b541a0820 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -284,6 +284,7 @@ class JsonEvent:
> >            'hisi_sccl,hha': 'hisi_sccl,hha',
> >            'hisi_sccl,l3c': 'hisi_sccl,l3c',
> >            'imx8_ddr': 'imx8_ddr',
> > +          'imx9_ddr': 'imx9_ddr',
> >            'L3PMC': 'amd_l3',
> >            'DFPMC': 'amd_df',
> >            'UMCPMC': 'amd_umc',
> > --
> > 2.34.1

