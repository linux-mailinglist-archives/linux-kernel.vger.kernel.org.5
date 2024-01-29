Return-Path: <linux-kernel+bounces-43126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB866840BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A46B1F2278C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7331615959E;
	Mon, 29 Jan 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d4giT426"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA6515444C;
	Mon, 29 Jan 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546170; cv=fail; b=mhdtO6W1ZH1pYq0Z9r9Wmf5JHXt0j9urMvQmBRU32Czt7RfNMSRSD8dVT4FUep4ojLoFCBEH20fLGg/5jnYA0s+ZQe2p1oIrNj3vBdud8GIdrMa+GF8XLdRwjIfcW79AViNAp1MrlJ7MeWbcLMCt3g/Q8+0EvUpYqe7b9gk5Q3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546170; c=relaxed/simple;
	bh=vzzZAmhxHsTGIpe87/N2a6tRsV4/TpYNYVc5xLSkaZU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iDGGG5F8k8ivBzUSxUHdsEjqk3FCsRMgwwySeK/IS8ncXrwKT9t9mEkLXPciabAT9o6VmDkRkRBHhm4f4hCyoWQipjo9eP0UHDvC4rMC6rbH+ataK0ahGtj1lB/Ry3mgNy9DJZXmxV1jZeH8RIJ5SqOm0CWpDz+ZpOX9kJApDyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=d4giT426; arc=fail smtp.client-ip=40.107.14.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUiJf13/Y5CuGXuEGm2XVP9+8VDzZq9S53VgJfbgy/Q27pSPKPeRu9M75+NIMpb+q/XFUFaPFhahzudmDjICRjneg6rpp+ilonCgvGCtT8+r7GmD3cGN8qMDE2dQRvSUEIF834xVXUpxV5BvpQFRPWugJrSoGXGWpz+McmuE0BMDqJ3defkbi15S7UQ0mHxrkPklYU8imjA5dDn2aISo7DU0bmbPAknIrT4dvEbR1BIT+jAvalX35jgpDd7BQ5pWidStjt+gxXJWHdbRsOMB5iI9FSKQBTUThxDZR5brjfn7U0sKPMHvsQTXZ2R0zkgC5JqsITrJIFGV0jAjEjxtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdhR3vWmOIa4CKWxjBnTlAFaPDeAWgpLx5/sipPG2LQ=;
 b=B/Fb2DA53ShMXIfHjdd1pGVo8F8+VzV4DqUek+sZzU+f+IzDHc5QzMPYDrBdV4kQFVbh6tLuBB0MpKrmtNld6SOFxFIEFbzoVaOOgMeOHKkpyzz2Z3A6kZ6HgFgnua5sKkkwqJZ5LpmuIu9vKa6BdzKE2T8CvEDvYRGLiPoM0U8ncd7SHtjpAxhWFLLhbM06T3Ry5UEZlyWyLwuLaDoHmU6cV9dJsDayLJntETUdjg8pRpJEJm56aFP2GDQ9bNZBFIaVNXEi38/3yEJ9Ccsn/1fDO8VCE3UkKJqG9I0mPhAYAAkvkAnP+jB2CjXjsEuIF8zLYA7eM0IkHvZpwTqaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdhR3vWmOIa4CKWxjBnTlAFaPDeAWgpLx5/sipPG2LQ=;
 b=d4giT426FJbaFSC4xFno1p/aj0RRMxAx2/dUy4efCNrVkWVg4cWAbaZx7E6DA/nS1/sWZJ2L8F6GzEeRAxFUy4ZZmeZlHzxsYs/C3P8AjE/wV1sIBW+/E5DkKs8OkMQTEzCf2qeYyaZkSOuecIhCCLd/R2L/P1Xg8OVQmzMCOhY=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9768.eurprd04.prod.outlook.com (2603:10a6:102:381::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 16:36:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 16:36:01 +0000
From: Frank Li <frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>, "will@kernel.org" <will@kernel.org>,
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
Subject: RE: [PATCH v3 4/4] perf vendor events arm64:: Add i.MX95 DDR
 Performane Monitor metrics
Thread-Topic: [PATCH v3 4/4] perf vendor events arm64:: Add i.MX95 DDR
 Performane Monitor metrics
Thread-Index: AQHaUpsczp2w7mQBhUGDAzro6DtY1LDw/MoQ
Date: Mon, 29 Jan 2024 16:36:01 +0000
Message-ID:
 <PAXPR04MB964250C00BC537E59BDCF808887E2@PAXPR04MB9642.eurprd04.prod.outlook.com>
References: <20240129101433.2429536-1-xu.yang_2@nxp.com>
 <20240129101433.2429536-4-xu.yang_2@nxp.com>
In-Reply-To: <20240129101433.2429536-4-xu.yang_2@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9642:EE_|PAWPR04MB9768:EE_
x-ms-office365-filtering-correlation-id: 2b29eb4e-df1a-44f1-00a9-08dc20e86142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wL4KNx4E2MoTDxL7RL1ZAPI9Lac1VcWo8JVyaWo2jGSN2HxoDpkYkuIgo46ibkwt41RiMJKPotMd1yOZBaeufRARiJnGoqnahctgEPI4ugP7oFNB1QyvtQ8ZMxNmhsoDOgX3v+t2gZ2xgTq6FoZM1Y5544fCGtp2LYirHjVibRMs5AIQJ26jYESyyusd6eZZcysgeFzopqtEiERCqq0/RparrztUyo2ZcbJdgxD+z66T5tpz2hBQiVPnd+1oNjiQD70zX63y0QJ4enHfBDFxVBSuI9fYPVCLOmgLibnatHcXZxx756HMvRMaadVhbCnZ1j7o/UpyThPKxMfR7kwgMNXbjOYPDuEJD8isH8rY1/xpF00iI64Sof3FqCRN0+NcwjKEh32ALuGtvNFPegIem/HPLN2CmGe1z3XFwZCr6ZupYXvfwDrLaSpQUgC7Gs1l4TPrjjyr77Wwvmy6lARhj9OUA5RiAdcrdZwsgAYCi0+fINo9Tlur12psBv9raqjW3U7abjjukwwNOKICiJgMxwOXDnYbZi0d3S/hIGvQFvxqjTQ1NANlAcR2ojpmgEBBAO/7kR1onivj/eSg4CrZA32WUzTIsGS6ftdJwkWWiyPKXUx6mI/gyHVnpo4FJPfc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(53546011)(26005)(83380400001)(7696005)(6506007)(55236004)(9686003)(38100700002)(122000001)(30864003)(66946007)(5660300002)(4326008)(8936002)(8676002)(52536014)(41300700001)(44832011)(54906003)(71200400001)(66446008)(478600001)(316002)(7416002)(110136005)(64756008)(76116006)(2906002)(66476007)(66556008)(921011)(86362001)(38070700009)(33656002)(55016003)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tXE2IEtRi5Og5aYyarIJExwtILxY0v/r3vMlIlvOYxSHsv2IinNhpmVnBAUL?=
 =?us-ascii?Q?ccNj4Cj5A6xmDWC4jMuYpNoi214ZSgQfPd2bdIDs/b6QCgJMRWNEpljkvmkJ?=
 =?us-ascii?Q?7xeTZuLzIKE/35Ry9NlMZVJtNvLclwKf2IBjzRl3yl2zyBTm/9Yj/cYphClZ?=
 =?us-ascii?Q?9hHXkgJkrkLcI/OtkPFmj49+3r/t1Oj8gCbCCUJWxHIJ2jwOrxbDthUn+KLI?=
 =?us-ascii?Q?kWjXR4+V8HrMO/heloeMA89Juth6/GyEJGTwA+Ulvsk9r37lgiMiW0YssQr4?=
 =?us-ascii?Q?W21DWabxaIG0GFADcm4DGcOUfkNDirQ3/5fcrSnSknRL3vZQlUApCjRDiAbc?=
 =?us-ascii?Q?o5sPrE9HitPILnbRrLClDsFxjRx3cDKAWOrcdvM0p45spYu8IF6bjZ4vLtbM?=
 =?us-ascii?Q?4s32wdQeIDk9dDG+OakRzDva1PLNEHygb5SHgy+X4Zu/usY23whJEDauoGz/?=
 =?us-ascii?Q?B78kEpGLnorHsDEKAf9hW5OCwi5va+ZAUPJUHotHmNUNkdcufdBD8e4zjMkZ?=
 =?us-ascii?Q?ydqOqLIEE5HuYxo3R3P0oGq7XByvpo31F/4oGcBzC1MNFPhTcYDBxW1kewGa?=
 =?us-ascii?Q?8e1kN2lJHaiJece0oE4LgDAy9abdXHibUJpafBRzoUmncbB1skBilOxgkn60?=
 =?us-ascii?Q?hXQXYo/ly6puWIrcmmL3ctnYDuPszGWVV1Mt1ikZo14kowQWUPQH52NpToX7?=
 =?us-ascii?Q?3dnHFWxjNJ9XwdbEAX5PXtB1tTgx2SvU5CkC93TyoLWC7cqTX4dJ7h5Xbhs8?=
 =?us-ascii?Q?rG2wK/zHoKq39BgdsanMgFrZhKg8t9mAxJWMqkS1dcN/G7QqFZhxf3GvM1TR?=
 =?us-ascii?Q?x9RCvcXPBs5D8PdG94q2IbGUlILPudra5041le/7Fsz6HgQvZ/6MfBohzCqm?=
 =?us-ascii?Q?uVfWaz6rG5IX+w3NYOrVZfoZ6SFSDK9beiGtpfYTtKlbjK56sxViwGgERvy2?=
 =?us-ascii?Q?J8rtpUs3AeXolw1qbM+LkSF0tGXt4gI0C+JrEoaLignRA9rWijh+ctLwM5zb?=
 =?us-ascii?Q?gSp+sf9UIhHJlD7ku4XELhC75JvNT71482YyFYk/0Bmh0NWgVNVsvApciun0?=
 =?us-ascii?Q?G1/lA0CLwebWUOy04pVQ5RcKTulhcbHsLGhQqCQox6atVxlSpOTWx21qDQP6?=
 =?us-ascii?Q?Pz64k/RjVzlvD6GwOvhCDmEDCxYAo89EvHgS7YidIx+Xh8aQX+0QIvk0T8Qz?=
 =?us-ascii?Q?034NcLWMgIl7MSP800h9SbIdICCaRYIMGoQpo+1/D2EAE01XXE8I4M6Z/3Eq?=
 =?us-ascii?Q?f/CIZqceMp7VG046SCsm7c/3z6rpIUlpB085dB/OgtWJykrNuKdXzgVqoRnd?=
 =?us-ascii?Q?FpSZVFLncG+pfEeZ/TPazDPNOqnEDiDu3H4B4GWpc0s1VgwOtxWyfDsKi1K0?=
 =?us-ascii?Q?xnG+xUrTLQ67x7YDjIihJxRNCglUkWDqcAxxVwV2IZxr9ieSZ2ncnHIRhExa?=
 =?us-ascii?Q?FijEXdNYxEU7SlZJE2d8bl0uoc5g3R5fJvaLiGDYX1Nz0ThE4IIWdNDU529x?=
 =?us-ascii?Q?8qy7UY7UX8UlV5zpqaWKaOdTRZkyh3akWu3egxfHn2ZqG/bOrc6leqp+dN5r?=
 =?us-ascii?Q?bJZhjWxjOBto3U+yK9M=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b29eb4e-df1a-44f1-00a9-08dc20e86142
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 16:36:01.5840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jt1bUsp/klbluPkyjMX1H03ysoPXaBw6/uCF43XVYsHWLcchYYb8bDDoA/Sjx5uUvlK6jjdFjojLqHfN0lmKXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9768



> -----Original Message-----
> From: Xu Yang <xu.yang_2@nxp.com>
> Sent: Monday, January 29, 2024 4:15 AM
> To: Frank Li <frank.li@nxp.com>; will@kernel.org; mark.rutland@arm.com;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; john.g.garry@oracle.com;
> jolsa@kernel.org; namhyung@kernel.org; irogers@google.com
> Cc: dl-linux-imx <linux-imx@nxp.com>; mike.leach@linaro.org;
> leo.yan@linaro.org; peterz@infradead.org; mingo@redhat.com;
> acme@kernel.org; alexander.shishkin@linux.intel.com;
> adrian.hunter@intel.com; Xu Yang <xu.yang_2@nxp.com>; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-perf-users@vger.kernel.org
> Subject: [PATCH v3 4/4] perf vendor events arm64:: Add i.MX95 DDR
> Performane Monitor metrics
>=20
> Add JSON metrics for i.MX95 DDR Performane Monitor.
>=20
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

Please add imx@lists.linux.dev in next version

>=20
> ---
> Changes in v2:
>  - fix wrong AXI_MASK setting
>  - remove unnecessary metrics
>  - add bandwidth_usage, camera_all, disp_all metrics
> Changes in v3:
>  - no changes
> ---
>  .../arch/arm64/freescale/imx95/sys/ddrc.json  |   9 +
>  .../arm64/freescale/imx95/sys/metrics.json    | 778 ++++++++++++++++++
>  tools/perf/pmu-events/jevents.py              |   1 +
>  3 files changed, 788 insertions(+)
>  create mode 100644 tools/perf/pmu-
> events/arch/arm64/freescale/imx95/sys/ddrc.json
>  create mode 100644 tools/perf/pmu-
> events/arch/arm64/freescale/imx95/sys/metrics.json
>=20
> diff --git a/tools/perf/pmu-
> events/arch/arm64/freescale/imx95/sys/ddrc.json b/tools/perf/pmu-
> events/arch/arm64/freescale/imx95/sys/ddrc.json
> new file mode 100644
> index 000000000000..4dc9d2968bdc
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
> @@ -0,0 +1,9 @@
> +[
> +   {
> +           "BriefDescription": "ddr cycles event",
> +           "EventCode": "0x00",
> +           "EventName": "imx95_ddr.cycles",
> +           "Unit": "imx9_ddr",
> +           "Compat": "imx95"
> +   }
> +]
> diff --git a/tools/perf/pmu-
> events/arch/arm64/freescale/imx95/sys/metrics.json b/tools/perf/pmu-
> events/arch/arm64/freescale/imx95/sys/metrics.json
> new file mode 100644
> index 000000000000..2bfcd4d574a8
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
> @@ -0,0 +1,778 @@
> +[
> +	{
> +		"BriefDescription": "bandwidth usage for lpddr5 evk board",
> +		"MetricName": "imx95_bandwidth_usage.lpddr5",
> +		"MetricExpr":
> "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x00
> 0\\,axi_id\\=3D0x000@ +
> imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x000\\,
> axi_id\\=3D0x000@ ) * 32 / duration_time) / (6400 * 1000000 * 4)",
> +		"ScaleUnit": "1e2%",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of all masters read from ddr",
> +		"MetricName": "imx95_ddr_read.all",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x000
> \\,axi_id\\=3D0x000@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of all masters write to ddr",
> +		"MetricName": "imx95_ddr_write.all",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x000
> \\,axi_id\\=3D0x000@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of all a55 read from ddr",
> +		"MetricName": "imx95_ddr_read.a55_all",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x3fc
> \\,axi_id\\=3D0x000@ +
> imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x3fe\\,
> axi_id\\=3D0x004@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of all a55 write to ddr (part1)",
> +		"MetricName": "imx95_ddr_write.a55_all_1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3fc\
> \,axi_id\\=3D0x000@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of all a55 write to ddr (part2)",
> +		"MetricName": "imx95_ddr_write.a55_all_2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3fe\
> \,axi_id\\=3D0x004@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 0 read from ddr",
> +		"MetricName": "imx95_ddr_read.a55_0",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x3ff
> \\,axi_id\\=3D0x000@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 0 write to ddr",
> +		"MetricName": "imx95_ddr_write.a55_0",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3ff\
> \,axi_id\\=3D0x000@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 1 read from ddr",
> +		"MetricName": "imx95_ddr_read.a55_1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x00f
> \\,axi_id\\=3D0x001@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 1 write to ddr",
> +		"MetricName": "imx95_ddr_write.a55_1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x00f\
> \,axi_id\\=3D0x001@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 2 read from ddr",
> +		"MetricName": "imx95_ddr_read.a55_2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3D3\\,axi_mask\\=3D0x00f
> \\,axi_id\\=3D0x002@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 2 write to ddr",
> +		"MetricName": "imx95_ddr_write.a55_2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x00f\
> \,axi_id\\=3D0x002@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 3 read from ddr",
> +		"MetricName": "imx95_ddr_read.a55_3",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x00f
> \\,axi_id\\=3D0x003@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 3 write to ddr",
> +		"MetricName": "imx95_ddr_write.a55_3",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x00f\
> \,axi_id\\=3D0x003@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 4 read from ddr",
> +		"MetricName": "imx95_ddr_read.a55_4",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x00f
> \\,axi_id\\=3D0x004@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 4 write to ddr",
> +		"MetricName": "imx95_ddr_write.a55_4",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x00f\
> \,axi_id\\=3D0x004@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 5 read from ddr",
> +		"MetricName": "imx95_ddr_read.a55_5",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3D3\\,axi_mask\\=3D0x00f
> \\,axi_id\\=3D0x005@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 5 write to ddr",
> +		"MetricName": "imx95_ddr_write.a55_5",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x00f\
> \,axi_id\\=3D0x005@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP
> transactions read from ddr",
> +		"MetricName": "imx95_ddr_read.cortexa_dsu_l3",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x00f
> \\,axi_id\\=3D0x007@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP
> transactions write to ddr",
> +		"MetricName": "imx95_ddr_write.cortexa_dsu_l3",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x00f\
> \,axi_id\\=3D0x007@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of m33 read from ddr",
> +		"MetricName": "imx95_ddr_read.m33",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x00f
> \\,axi_id\\=3D0x008@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of m33 write to ddr",
> +		"MetricName": "imx95_ddr_write.m33",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x00f\
> \,axi_id\\=3D0x008@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of m7 read from ddr",
> +		"MetricName": "imx95_ddr_read.m7",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x00f
> \\,axi_id\\=3D0x009@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of m7 write to ddr",
> +		"MetricName": "imx95_ddr_write.m7",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x00f\
> \,axi_id\\=3D0x009@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of sentinel read from ddr",
> +		"MetricName": "imx95_ddr_read.sentinel",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3D3\\,axi_mask\\=3D0x00f
> \\,axi_id\\=3D0x00a@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of sentinel write to ddr",
> +		"MetricName": "imx95_ddr_write.sentinel",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x00f\
> \,axi_id\\=3D0x00a@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of edma1 read from ddr",
> +		"MetricName": "imx95_ddr_read.edma1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x00f
> \\,axi_id\\=3D0x00b@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of edma1 write to ddr",
> +		"MetricName": "imx95_ddr_write.edma1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x00f\
> \,axi_id\\=3D0x00b@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of edma2 read from ddr",
> +		"MetricName": "imx95_ddr_read.edma2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x00f
> \\,axi_id\\=3D0x00c@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of edma2 write to ddr",
> +		"MetricName": "imx95_ddr_write.edma2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x00f\
> \,axi_id\\=3D0x00c@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of netc read from ddr",
> +		"MetricName": "imx95_ddr_read.netc",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3D3\\,axi_mask\\=3D0x00f
> \\,axi_id\\=3D0x00d@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of netc write to ddr",
> +		"MetricName": "imx95_ddr_write.netc",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x00f\
> \,axi_id\\=3D0x00d@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of npu read from ddr",
> +		"MetricName": "imx95_ddr_read.npu",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x010@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of npu write to ddr",
> +		"MetricName": "imx95_ddr_write.npu",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x010@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of gpu read from ddr",
> +		"MetricName": "imx95_ddr_read.gpu",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x020@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of gpu write to ddr",
> +		"MetricName": "imx95_ddr_write.gpu",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x020@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of usdhc1 read from ddr",
> +		"MetricName": "imx95_ddr_read.usdhc1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3D3\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x0b0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of usdhc1 write to ddr",
> +		"MetricName": "imx95_ddr_write.usdhc1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x0b0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of usdhc2 read from ddr",
> +		"MetricName": "imx95_ddr_read.usdhc2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x0c0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of usdhc2 write to ddr",
> +		"MetricName": "imx95_ddr_write.usdhc2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x0c0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of usdhc3 read from ddr",
> +		"MetricName": "imx95_ddr_read.usdhc3",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x0d0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of usdhc3 write to ddr",
> +		"MetricName": "imx95_ddr_write.usdhc3",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x0d0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of xspi read from ddr",
> +		"MetricName": "imx95_ddr_read.xspi",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3D3\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x0f0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of xspi write to ddr",
> +		"MetricName": "imx95_ddr_write.xspi",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x0f0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of pcie1 read from ddr",
> +		"MetricName": "imx95_ddr_read.pcie1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x100@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of pcie1 write to ddr",
> +		"MetricName": "imx95_ddr_write.pcie1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x100@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of pcie2 read from ddr",
> +		"MetricName": "imx95_ddr_read.pcie2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x00f
> \\,axi_id\\=3D0x006@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of pcie2 write to ddr",
> +		"MetricName": "imx95_ddr_write.pcie2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x00f\
> \,axi_id\\=3D0x006@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of pcie3 read from ddr",
> +		"MetricName": "imx95_ddr_read.pcie3",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3D3\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x120@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of pcie3 write to ddr",
> +		"MetricName": "imx95_ddr_write.pcie3",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x120@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of pcie4 read from ddr",
> +		"MetricName": "imx95_ddr_read.pcie4",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x130@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of pcie4 write to ddr",
> +		"MetricName": "imx95_ddr_write.pcie4",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x130@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of usb1 read from ddr",
> +		"MetricName": "imx95_ddr_read.usb1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x140@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of usb1 write to ddr",
> +		"MetricName": "imx95_ddr_write.usb1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x140@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of usb2 read from ddr",
> +		"MetricName": "imx95_ddr_read.usb2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3D3\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x150@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of usb2 write to ddr",
> +		"MetricName": "imx95_ddr_write.usb2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x150@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of vpu codec primary bus read
> from ddr",
> +		"MetricName": "imx95_ddr_read.vpu_primy",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x180@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of vpu codec primary bus write to
> ddr",
> +		"MetricName": "imx95_ddr_write.vpu_primy",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x180@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of vpu codec secondary bus read
> from ddr",
> +		"MetricName": "imx95_ddr_read.vpu_secndy",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x190@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of vpu codec secondary bus write
> to ddr",
> +		"MetricName": "imx95_ddr_write.vpu_secndy",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x190@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of jpeg decoder read from ddr",
> +		"MetricName": "imx95_ddr_read.jpeg_dec",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3D3\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x1a0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of jpeg decoder write to ddr",
> +		"MetricName": "imx95_ddr_write.jpeg_dec",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x1a0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of jpeg encoder read from ddr",
> +		"MetricName": "imx95_ddr_read.jpeg_dec",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x1b0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of jpeg encoder write to ddr",
> +		"MetricName": "imx95_ddr_write.jpeg_enc",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x1b0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of all vpu submodules read from
> ddr",
> +		"MetricName": "imx95_ddr_read.vpu_all",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x380
> \\,axi_id\\=3D0x180@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of all vpu submodules write to ddr",
> +		"MetricName": "imx95_ddr_write.vpu_all",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x380
> \\,axi_id\\=3D0x180@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of cortex m0+ read from ddr",
> +		"MetricName": "imx95_ddr_read.m0",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3D3\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x200@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of cortex m0+ write to ddr",
> +		"MetricName": "imx95_ddr_write.m0",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x200@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of camera edma read from ddr",
> +		"MetricName": "imx95_ddr_read.camera_edma",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x210@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of camera edma write to ddr",
> +		"MetricName": "imx95_ddr_write.camera_edma",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x210@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isi rd read from ddr",
> +		"MetricName": "imx95_ddr_read.isi_rd",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x220@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isi rd write to ddr",
> +		"MetricName": "imx95_ddr_write.isi_rd",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x220@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isi wr y read from ddr",
> +		"MetricName": "imx95_ddr_read.isi_wr_y",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3D3\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x230@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isi wr y write to ddr",
> +		"MetricName": "imx95_ddr_write.isi_wr_y",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x230@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isi wr u read from ddr",
> +		"MetricName": "imx95_ddr_read.isi_wr_u",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x240@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isi wr u write to ddr",
> +		"MetricName": "imx95_ddr_write.isi_wr_u",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x240@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isi wr v read from ddr",
> +		"MetricName": "imx95_ddr_read.isi_wr_v",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x250@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isi wr v write to ddr",
> +		"MetricName": "imx95_ddr_write.isi_wr_v",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x250@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isp input dma1 read from ddr",
> +		"MetricName": "imx95_ddr_read.isp_in_dma1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3D3\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x260@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isp input dma1 write to ddr",
> +		"MetricName": "imx95_ddr_write.isp_in_dma1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x260@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isp input dma2 read from ddr",
> +		"MetricName": "imx95_ddr_read.isp_in_dma2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x270@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isp input dma2 write to ddr",
> +		"MetricName": "imx95_ddr_write.isp_in_dma2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x270@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isp output dma1 read from ddr",
> +		"MetricName": "imx95_ddr_read.isp_out_dma1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x280@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isp output dma1 write to ddr",
> +		"MetricName": "imx95_ddr_write.isp_out_dma1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x280@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isp output dma2 read from ddr",
> +		"MetricName": "imx95_ddr_read.isp_out_dma2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3D3\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x290@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of isp output dma2 write to ddr",
> +		"MetricName": "imx95_ddr_write.isp_out_dma2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x290@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of all camera submodules read
> from ddr",
> +		"MetricName": "imx95_ddr_read.camera_all",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x380
> \\,axi_id\\=3D0x200@ +
> imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x3f0\\,
> axi_id\\=3D0x280@ +
> imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3D3\\,axi_mask\\=3D0x3f0\\,
> axi_id\\=3D0x290@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of all camera submodules write to
> ddr (part1)",
> +		"MetricName": "imx95_ddr_write.camera_all_1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x380
> \\,axi_id\\=3D0x200@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of all camera submodules write to
> ddr (part2)",
> +		"MetricName": "imx95_ddr_write.camera_all_2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x280@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of all camera submodules write to
> ddr (part3)",
> +		"MetricName": "imx95_ddr_write.camera_all_3",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x290@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of display blitter store read from
> ddr",
> +		"MetricName": "imx95_ddr_read.disp_blit",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x2a0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of display blitter write to ddr",
> +		"MetricName": "imx95_ddr_write.disp_blit",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x2a0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of display command sequencer
> read from ddr",
> +		"MetricName": "imx95_ddr_read.disp_cmd",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x3f0
> \\,axi_id\\=3D0x2b0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of display command sequencer
> write to ddr",
> +		"MetricName": "imx95_ddr_write.disp_cmd",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3f0\
> \,axi_id\\=3D0x2b0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of all display submodules read
> from ddr",
> +		"MetricName": "imx95_ddr_read.disp_all",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=3D5\\,axi_mask\\=3D0x300
> \\,axi_id\\=3D0x300@ +
> imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x3a0\\
> ,axi_id\\=3D0x2a0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of all display submodules write to
> ddr (part1)",
> +		"MetricName": "imx95_ddr_write.disp_all_1",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x300
> \\,axi_id\\=3D0x300@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	},
> +	{
> +		"BriefDescription": "bytes of all display submodules write to
> ddr (part2)",
> +		"MetricName": "imx95_ddr_write.disp_all_2",
> +		"MetricExpr":
> "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x3a0
> \\,axi_id\\=3D0x2a0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx95"
> +	}
> +]
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-
> events/jevents.py
> index 53ab050c8fa4..be4b541a0820 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -284,6 +284,7 @@ class JsonEvent:
>            'hisi_sccl,hha': 'hisi_sccl,hha',
>            'hisi_sccl,l3c': 'hisi_sccl,l3c',
>            'imx8_ddr': 'imx8_ddr',
> +          'imx9_ddr': 'imx9_ddr',
>            'L3PMC': 'amd_l3',
>            'DFPMC': 'amd_df',
>            'UMCPMC': 'amd_umc',
> --
> 2.34.1


