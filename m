Return-Path: <linux-kernel+bounces-43099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05C7840B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9781F23C23
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A693F156976;
	Mon, 29 Jan 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M9u4JKJq"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64822156977;
	Mon, 29 Jan 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545716; cv=fail; b=WTUg2Q6Y7sfVrhE7q3xgOMMrzKvHpCgf+/W/N+G2Rg7I85E/j+Lc6fGtB8w3MwvCJDFhmZOiq/z/tDUzj8lPfao7xI/D4/GdjjnMOHQifPwjZngpVrVQe4QCrkpGuHyt4/E6J676HfCThW5Hf6lq0i62eEj7a744i9QDry811Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545716; c=relaxed/simple;
	bh=+wLsvvMDEm0xWHNbAXQqHjmR+EockBkXUAZbw1FkoTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=trzdxUd8sRe5TFP0uCsQk9WQEHBYyrFmEvDtFuyAUryNz/urAsblvuCIZnip2xJWxtQe3MDXBjfaHz5E/q7vuMtW52WYQ6GwbfeejnP7LzpWgn/yZGZD3kDYdghqNClrQscqVi6xu8YxLHbNGenDgsEBF25F8WEi5dwJqDsI66Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=M9u4JKJq; arc=fail smtp.client-ip=40.107.6.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQXRsqEJsDSdaBoBHNvSoZ2Zf1CbFakAA3Snp4K+aoa4OG/vuxF8f6oqqVQbDvdQTzKSYjG4AOdoi642MM1u5p9I+QCYyzZjoBSCw9FBof+bUJHmfbus9QsY03jXZS7uKmU87NGVOdYJaxlSO8y9y8YxIqydvZUt2qk8/duA07wqutHDLf3Er8YYKkY8Zk7Sh4q3d5t/L1K0xe7ygHdl56C9kq5gckwGzDqCFOWDWg+1boZRtlCp86GmXLENQzbUehqrBA/O32sbQk+Nir8yd+QufaYvk1SBIPnpM/QEFHZ/UsoP8huSEVdtgpsrFLSJxtYaGbuOkWjNubFf5uunhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE/2F+gn4c1tAWyXws9SMhTykdF8DmnYxYdLKU7Zyk8=;
 b=RdmA7EtG20d6w5QtmMBXzvmk1gjdKjfKRPrgq3Wer9TDzQJOfMsthdk7aYu9/wKg2R7sWZFxqjW7Jb7IggP+q8YRkLJQhmkvf97j334Zh0VX8SDlQ1fmVgQq5MEohABapdttc1SL6QE4rLLkpkp3PcQbo7HgPIzooQ4cpFQzy2n7fel1AkOLM5q/hB88sKkeGQRZC6ygNTLcMknfAFwYAXrDikXAOzr+RAiZ9HJH5ErLAwT0qeygV91Y67thXgkf1D300btKhXW3f0QBv55uFxvUR064EhHYCXSWewFyBWFkfbnD02BaBpLfsjblnAxw83bXDYOpFpGkoaZaTa3nSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE/2F+gn4c1tAWyXws9SMhTykdF8DmnYxYdLKU7Zyk8=;
 b=M9u4JKJqzU11MU55ie2+3DZPsrQ8vkf/gYbwPc1L8YaY8wKgh3rrxJnsrWwk0C0hWm7FjHCxgUI8vErkBCocX3wAQuZFFFArvWlHEy8rwc+YeX4unmOH0zzNcbpmaOCl/uWuJw1J2DO9GQrehFpam/EUi8VsorjAwKYecPXmt80=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7000.eurprd04.prod.outlook.com (2603:10a6:20b:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 16:28:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 16:28:28 +0000
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
Subject: RE: [PATCH v3 2/4] perf: imx_perf: add support for i.MX95 platform
Thread-Topic: [PATCH v3 2/4] perf: imx_perf: add support for i.MX95 platform
Thread-Index: AQHaUpsTO+M/KRVAmUedkCPGjgxuk7Dw+qRw
Date: Mon, 29 Jan 2024 16:28:28 +0000
Message-ID:
 <PAXPR04MB96425D284EC0A7CD29185771887E2@PAXPR04MB9642.eurprd04.prod.outlook.com>
References: <20240129101433.2429536-1-xu.yang_2@nxp.com>
 <20240129101433.2429536-2-xu.yang_2@nxp.com>
In-Reply-To: <20240129101433.2429536-2-xu.yang_2@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9642:EE_|AM7PR04MB7000:EE_
x-ms-office365-filtering-correlation-id: 5178810c-fff5-41ae-55d8-08dc20e75320
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G5zII8+oExumkbUhrq4aZmpHcI70TDNTJ17qyhV+TbnKO/BssvvOy8LzRhCgnGjf5W43G4FD72LBeKLi18YLI8ymZbiWvW7wXv5rx8IvLAmUFSSZjlw2eJXYrNJ0lIqG8oykdbbnHn+aoKHxOjh9uFWN+/XNr/WodHH2lzcXQWGHOH2OmecLHpSJ2/hZ6CpitJF6Kovj5AGUA+/Gr3/BVo5wlePpStzyPGG0biwyoRH1Od6jnYwmTaJ8IP227S9skyppjfJSBBvgP3echh2S1Y50VOyOTtFK/+oCCv27t3gzLTEz6wx5GjwrQjfITCdSCZdMa+px2wtDWQgbsgYFrWk5C5v4CezX0L3BivLNKZdeZmIG73sduzt/yFzYw3du5KAPaOL2Y8/GkhdSTCjnQPn5gQBairNRSdWQcQVgghR7cnvt/r3SLgoZPlkRZYYkVrSvLgOZC3vwtQYq5HAQNtxLc+9HbLwtJqKNdsnarYLXXfAJ6wrp3qN67yrmd2xnvnyoKO1QHUtiAx3ohO5bQFyH3htMFIK0BD01sEytL+Zg99+mVPOjCELDwy80wNH458emrYe3AC+9Ke5kvEiY0iSwAQhodMosR4xJ5k9kgl7JOXiPMN39XCfQPSbC7Wgp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(26005)(7696005)(9686003)(38100700002)(122000001)(66556008)(8676002)(8936002)(4326008)(5660300002)(44832011)(7416002)(71200400001)(76116006)(55236004)(6506007)(53546011)(2906002)(54906003)(64756008)(52536014)(66476007)(478600001)(30864003)(66446008)(110136005)(41300700001)(316002)(66946007)(921011)(38070700009)(86362001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Whr5qa1HSvH57PXkI391By1Wa3wAGapXIsSVCyE9C2iVmKpEx1/7SXB9Gnj3?=
 =?us-ascii?Q?EZGfvNjmlt4cz6/5K2jtlys6h9fcg6RAxbzWUDV3wvQO1t9tlrHvias/5Zxd?=
 =?us-ascii?Q?UI7z7iIT6H1uRQ7Fmwvbu5a7B53eaxFLF8WXEaWBIZoZQDcU20J0px03+y7u?=
 =?us-ascii?Q?5e+szavk1vfC3ga0o5RbDj7s175qt6ujEgnGpfve6W5bqyLV51WamGdyXhdB?=
 =?us-ascii?Q?8B2wvGM/cfYD4AF0RdFFJCtxbNh8rtlU7F9yesVzYYhisNyG+1XAUhI6k+LD?=
 =?us-ascii?Q?Vy0SSt28HK/HcCYFCWenrag6u05gxXdkBaSPKwp/N+8aQukKxRxUJl2n9/YC?=
 =?us-ascii?Q?/KnVU6/q0VqsfnByLh3GeQrrRpuZwJfE3f3vkSK8HX8R3UvXRU9HWZLmCFE5?=
 =?us-ascii?Q?Vkb3BV/p28StKBUzkLsPIEioxevH6tycRY3nw2gG0XeecJHnfiZnP9pXT9OK?=
 =?us-ascii?Q?J2bBgAGB75OXRBXIvUHPhlAOr1b5jX7RETfKtxWgeXwdqP2FUzi4ReY7YqVs?=
 =?us-ascii?Q?J/vYq+8VtmYqq/2DnqncN2sojZVW2eIGi2lRFs28vLO+70+gpHYdJIb5ElBS?=
 =?us-ascii?Q?XuvulutY7HVrU+rUagZ/Clq16/oEiJlNcwv0RO+xJvbgkn3VvL9lMXGLjhtu?=
 =?us-ascii?Q?QNNs5Jtcxl07Nda7ZcawtndG40Spvs/OEenfbfFzu98QW4zwo2a9nvH37bkf?=
 =?us-ascii?Q?YmBfUaeUIxMEgtGVw+dWi46nvO7w4CcqPr3NIkSvwPQzqh7KJk+G70936gCo?=
 =?us-ascii?Q?I2bAmNCaISBZd+UnSlhBMLcBZa9Dfmmo7wwBDGayDooUhQ0i12Ol0/sXULEb?=
 =?us-ascii?Q?sLr62dwgirOGPrswvhrYgiT6BORxsJHDOMLSFjyioYPsTG/cpYrr1oDLFdLX?=
 =?us-ascii?Q?uHg2kRbfHJh3WZ2ajYpTlkFqaFudX9Cb3X+PgCqbcMTwB4Z++GDhVkVuagcE?=
 =?us-ascii?Q?v4xtf5Cip1vR2CdaAEGYsH4vxCy4T/TE0yIRV48ooVwNXgLzvKUR7OErLaY1?=
 =?us-ascii?Q?79TymuqWuZdIfMAqXQwo7Ti8wMJYdGFv+LkeRtlZ13pkWazbo3wKy9onho7y?=
 =?us-ascii?Q?loDjfM1ch7+8rhUSma4Ckx1oFf9ugogSN4veE8BeKu47k6e/quDbZ82s1bOG?=
 =?us-ascii?Q?yIiKljd78o7qiTuJlcq90KfVCgSG9TuVbtMLVBAtsTlmTgYvClAWlUjTIWNL?=
 =?us-ascii?Q?M6f/L7ORYgN0sKIJ80H5p2GW5NYnscN8phbqJkY8OSWSIM7CueP6BXg43RIL?=
 =?us-ascii?Q?pbcrhuMNdtyBH+57IHxwwWgrydTEaFKyLBVreuAGOljN1KKxex0bRSizeNqB?=
 =?us-ascii?Q?9US5kM1ktPnTybmML2kaq6tes1Z9AFAFp38z+n701zrqb27jB/IN6NiDdKVg?=
 =?us-ascii?Q?8wxem9SCSiaBoP7EacUWF43TlPbEAlJ5c2oYHaSS8ydruIokkporUIAODZ3r?=
 =?us-ascii?Q?hyHbTyA/JkeLObEpiMvw4lJYL7urLicBqSBHFHoL65/IIA6s/aLKJm8cHr9V?=
 =?us-ascii?Q?NhPnkWSTylfD8JgtpWt7zv5eLz5xbwquQJzSDI+C5ycVAJk0i9vPyChVLvCv?=
 =?us-ascii?Q?VBzMsqZCPumr7Rt5a9Q=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5178810c-fff5-41ae-55d8-08dc20e75320
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 16:28:28.3900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wm6AMbEntawYh85AyXn6mYi5wObKnNst+cU1PmWNokyuQdAh6hjles+KQcNpEcL3d94UtiHWjjwtdQsNoVwr5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7000



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
> Subject: [PATCH v3 2/4] perf: imx_perf: add support for i.MX95 platform
>=20
> i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
> read beat and write beat filter capabilities. This will add support for
> i.MX95 and enhance the driver to support specific filter handling for it.
>=20
> Usage:
>=20
> For read beat:
> ~# perf stat -a -I 1000 -e
> imx9_ddr0/eddrtq_pm_rd_beat_filt2,counter=3D3,axi_mask=3DID_MASK,axi_id
> =3DID/
> ~# perf stat -a -I 1000 -e
> imx9_ddr0/eddrtq_pm_rd_beat_filt1,counter=3D4,axi_mask=3DID_MASK,axi_id
> =3DID/
> ~# perf stat -a -I 1000 -e
> imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=3D5,axi_mask=3DID_MASK,axi_id
> =3DID/
> eg: For edma2: perf stat -a -I 1000 -e
> imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=3D5,axi_mask=3D0x00f,axi_id=3D0=
x0
> 0c/
>=20
> For write beat:
> ~# perf stat -a -I 1000 -e
> imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=3D2,axi_mask=3DID_MASK,axi_id=3D
> ID/
> eg: For edma2: perf stat -a -I 1000 -e
> imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=3D2,axi_mask=3D0x00f,axi_id=3D0x=
00
> c/
>=20
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>=20
> ---
> Changes in v2:
>  - put soc spefific axi filter events to drvdata according
>    to franks suggestions.
>  - adjust pmcfg axi_id and axi_mask config
> Changes in v3:
>  - no changes
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 203 +++++++++++++++++++++++++-----
=20
I suggest you split this two patch. =20
1st patch rework imx93 only, which prepare for add imx95. All function is e=
qual.
2nd patch add imx95.=20

Frank
=20
> -
>  1 file changed, 169 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c
> b/drivers/perf/fsl_imx9_ddr_perf.c
> index 9685645bfe04..fd118773508d 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -11,14 +11,24 @@
>  #include <linux/perf_event.h>
>=20
>  /* Performance monitor configuration */
> -#define PMCFG1  			0x00
> -#define PMCFG1_RD_TRANS_FILT_EN 	BIT(31)
> -#define PMCFG1_WR_TRANS_FILT_EN 	BIT(30)
> -#define PMCFG1_RD_BT_FILT_EN 		BIT(29)
> -#define PMCFG1_ID_MASK  		GENMASK(17, 0)
> +#define PMCFG1				0x00
> +#define MX93_PMCFG1_RD_TRANS_FILT_EN	BIT(31)
> +#define MX93_PMCFG1_WR_TRANS_FILT_EN	BIT(30)
> +#define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
> +#define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
>=20
> -#define PMCFG2  			0x04
> -#define PMCFG2_ID			GENMASK(17, 0)
> +#define MX95_PMCFG1_WR_BEAT_FILT_EN	BIT(31)
> +#define MX95_PMCFG1_RD_BEAT_FILT_EN	BIT(30)
> +
> +#define PMCFG2				0x04
> +#define MX93_PMCFG2_ID			GENMASK(17, 0)
> +
> +#define PMCFG3				0x08
> +#define PMCFG4				0x0C
> +#define PMCFG5				0x10
> +#define PMCFG6				0x14
> +#define MX95_PMCFG_ID_MASK		GENMASK(9, 0)
> +#define MX95_PMCFG_ID			GENMASK(25, 16)
>=20
>  /* Global control register affects all counters and takes priority over =
local
> control registers */
>  #define PMGC0		0x40
> @@ -51,6 +61,7 @@ static DEFINE_IDA(ddr_ida);
>=20
>  struct imx_ddr_devtype_data {
>  	const char *identifier;		/* system PMU identifier for
> userspace */
> +	struct attribute **attrs;	/* AXI filter attributes */
>  };
>=20
>  struct ddr_pmu {
> @@ -67,16 +78,6 @@ struct ddr_pmu {
>  	int id;
>  };
>=20
> -static const struct imx_ddr_devtype_data imx93_devtype_data =3D {
> -	.identifier =3D "imx93",
> -};
> -
> -static const struct of_device_id imx_ddr_pmu_dt_ids[] =3D {
> -	{.compatible =3D "fsl,imx93-ddr-pmu", .data =3D &imx93_devtype_data},
> -	{ /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
> -
>  static ssize_t ddr_perf_identifier_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *page)
> @@ -178,7 +179,6 @@ static struct attribute *ddr_perf_events_attrs[] =3D =
{
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
>=20
>  	/* counter3 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
> @@ -190,7 +190,6 @@ static struct attribute *ddr_perf_events_attrs[] =3D =
{
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
>=20
>  	/* counter4 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
> @@ -202,7 +201,6 @@ static struct attribute *ddr_perf_events_attrs[] =3D =
{
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
>=20
>  	/* counter5 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
> @@ -242,6 +240,28 @@ static const struct attribute_group
> ddr_perf_events_attr_group =3D {
>  	.attrs =3D ddr_perf_events_attrs,
>  };
>=20
> +static struct attribute *imx93_ddr_perf_events_attrs[] =3D {
> +	/* counter2 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
> +	/* counter3 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
> +	/* counter4 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
> +	NULL,
> +};
> +
> +static struct attribute *imx95_ddr_perf_events_attrs[] =3D {
> +	/* counter2 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, 73),
> +	/* counter3 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, 73),
> +	/* counter4 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, 73),
> +	/* counter5 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, 73),
> +	NULL,
> +};
> +
>  PMU_FORMAT_ATTR(event, "config:0-7");
>  PMU_FORMAT_ATTR(counter, "config:8-15");
>  PMU_FORMAT_ATTR(axi_id, "config1:0-17");
> @@ -268,6 +288,28 @@ static const struct attribute_group *attr_groups[] =
=3D {
>  	NULL,
>  };
>=20
> +static const struct imx_ddr_devtype_data imx93_devtype_data =3D {
> +	.identifier =3D "imx93",
> +	.attrs =3D imx93_ddr_perf_events_attrs,
> +};
> +
> +static const struct imx_ddr_devtype_data imx95_devtype_data =3D {
> +	.identifier =3D "imx95",
> +	.attrs =3D imx95_ddr_perf_events_attrs,
> +};
> +
> +static const struct of_device_id imx_ddr_pmu_dt_ids[] =3D {
> +	{ .compatible =3D "fsl,imx93-ddr-pmu", .data =3D &imx93_devtype_data },
> +	{ .compatible =3D "fsl,imx95-ddr-pmu", .data =3D &imx95_devtype_data },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
> +
> +static inline bool is_imx93(struct ddr_pmu *pmu)
> +{
> +	return pmu->devtype_data =3D=3D &imx93_devtype_data;
> +}
> +
>  static void ddr_perf_clear_counter(struct ddr_pmu *pmu, int counter)
>  {
>  	if (counter =3D=3D CYCLES_COUNTER) {
> @@ -361,7 +403,7 @@ static void ddr_perf_counter_local_config(struct
> ddr_pmu *pmu, int config,
>  	}
>  }
>=20
> -static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cf=
g1,
> int cfg2)
> +static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg,
> int cfg1, int cfg2)
>  {
>  	u32 pmcfg1, pmcfg2;
>  	int event, counter;
> @@ -372,30 +414,80 @@ static void ddr_perf_monitor_config(struct
> ddr_pmu *pmu, int cfg, int cfg1, int
>  	pmcfg1 =3D readl_relaxed(pmu->base + PMCFG1);
>=20
>  	if (counter =3D=3D 2 && event =3D=3D 73)
> -		pmcfg1 |=3D PMCFG1_RD_TRANS_FILT_EN;
> +		pmcfg1 |=3D MX93_PMCFG1_RD_TRANS_FILT_EN;
>  	else if (counter =3D=3D 2 && event !=3D 73)
> -		pmcfg1 &=3D ~PMCFG1_RD_TRANS_FILT_EN;
> +		pmcfg1 &=3D ~MX93_PMCFG1_RD_TRANS_FILT_EN;
>=20
>  	if (counter =3D=3D 3 && event =3D=3D 73)
> -		pmcfg1 |=3D PMCFG1_WR_TRANS_FILT_EN;
> +		pmcfg1 |=3D MX93_PMCFG1_WR_TRANS_FILT_EN;
>  	else if (counter =3D=3D 3 && event !=3D 73)
> -		pmcfg1 &=3D ~PMCFG1_WR_TRANS_FILT_EN;
> +		pmcfg1 &=3D ~MX93_PMCFG1_WR_TRANS_FILT_EN;
>=20
>  	if (counter =3D=3D 4 && event =3D=3D 73)
> -		pmcfg1 |=3D PMCFG1_RD_BT_FILT_EN;
> +		pmcfg1 |=3D MX93_PMCFG1_RD_BT_FILT_EN;
>  	else if (counter =3D=3D 4 && event !=3D 73)
> -		pmcfg1 &=3D ~PMCFG1_RD_BT_FILT_EN;
> +		pmcfg1 &=3D ~MX93_PMCFG1_RD_BT_FILT_EN;
>=20
> -	pmcfg1 &=3D ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
> -	pmcfg1 |=3D FIELD_PREP(PMCFG1_ID_MASK, cfg2);
> +	pmcfg1 &=3D ~FIELD_PREP(MX93_PMCFG1_ID_MASK, 0x3FFFF);
> +	pmcfg1 |=3D FIELD_PREP(MX93_PMCFG1_ID_MASK, cfg2);
>  	writel(pmcfg1, pmu->base + PMCFG1);
>=20
>  	pmcfg2 =3D readl_relaxed(pmu->base + PMCFG2);
> -	pmcfg2 &=3D ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
> -	pmcfg2 |=3D FIELD_PREP(PMCFG2_ID, cfg1);
> +	pmcfg2 &=3D ~FIELD_PREP(MX93_PMCFG2_ID, 0x3FFFF);
> +	pmcfg2 |=3D FIELD_PREP(MX93_PMCFG2_ID, cfg1);
>  	writel(pmcfg2, pmu->base + PMCFG2);
>  }
>=20
> +static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg,
> int cfg1, int cfg2)
> +{
> +	u32 pmcfg1, pmcfg, offset =3D 0;
> +	int event, counter;
> +
> +	event =3D cfg & 0x000000FF;
> +	counter =3D (cfg & 0x0000FF00) >> 8;
> +
> +	pmcfg1 =3D readl_relaxed(pmu->base + PMCFG1);
> +
> +	if (counter =3D=3D 2 && event =3D=3D 73) {
> +		pmcfg1 |=3D MX95_PMCFG1_WR_BEAT_FILT_EN;
> +		offset =3D PMCFG3;
> +	} else if (counter =3D=3D 2 && event !=3D 73) {
> +		pmcfg1 &=3D ~MX95_PMCFG1_WR_BEAT_FILT_EN;
> +	}
> +
> +	if (counter =3D=3D 3 && event =3D=3D 73) {
> +		pmcfg1 |=3D MX95_PMCFG1_RD_BEAT_FILT_EN;
> +		offset =3D PMCFG4;
> +	} else if (counter =3D=3D 3 && event !=3D 73) {
> +		pmcfg1 &=3D ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> +	}
> +
> +	if (counter =3D=3D 4 && event =3D=3D 73) {
> +		pmcfg1 |=3D MX95_PMCFG1_RD_BEAT_FILT_EN;
> +		offset =3D PMCFG5;
> +	} else if (counter =3D=3D 4 && event !=3D 73) {
> +		pmcfg1 &=3D ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> +	}
> +
> +	if (counter =3D=3D 5 && event =3D=3D 73) {
> +		pmcfg1 |=3D MX95_PMCFG1_RD_BEAT_FILT_EN;
> +		offset =3D PMCFG6;
> +	} else if (counter =3D=3D 5 && event !=3D 73) {
> +		pmcfg1 &=3D ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> +	}
> +
> +	writel(pmcfg1, pmu->base + PMCFG1);
> +
> +	if (offset) {
> +		pmcfg =3D readl_relaxed(pmu->base + offset);
> +		pmcfg &=3D ~(FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF) |
> +				FIELD_PREP(MX95_PMCFG_ID, 0x3FF));
> +		pmcfg |=3D (FIELD_PREP(MX95_PMCFG_ID_MASK, cfg2) |
> +				FIELD_PREP(MX95_PMCFG_ID, cfg1));
> +		writel(pmcfg, pmu->base + offset);
> +	}
> +}
> +
>  static void ddr_perf_event_update(struct perf_event *event)
>  {
>  	struct ddr_pmu *pmu =3D to_ddr_pmu(event->pmu);
> @@ -476,12 +568,16 @@ static int ddr_perf_event_add(struct perf_event
> *event, int flags)
>  	hwc->idx =3D counter;
>  	hwc->state |=3D PERF_HES_STOPPED;
>=20
> +	if (is_imx93(pmu))
> +		/* read trans, write trans, read beat */
> +		imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> +	else
> +		/* write beat, read beat2, read beat1, read beat */
> +		imx95_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> +
>  	if (flags & PERF_EF_START)
>  		ddr_perf_event_start(event, flags);
>=20
> -	/* read trans, write trans, read beat */
> -	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> -
>  	return 0;
>  }
>=20
> @@ -596,6 +692,39 @@ static int ddr_perf_offline_cpu(unsigned int cpu,
> struct hlist_node *node)
>  	return 0;
>  }
>=20
> +static int ddr_perf_add_events(struct ddr_pmu *pmu)
> +{
> +	int i, ret;
> +	struct attribute **attrs =3D pmu->devtype_data->attrs;
> +	struct device *pmu_dev =3D pmu->pmu.dev;
> +
> +	if (!attrs)
> +		return 0;
> +
> +	for (i =3D 0; attrs[i]; i++) {
> +		ret =3D sysfs_add_file_to_group(&pmu_dev->kobj, attrs[i],
> "events");
> +		if (ret) {
> +			dev_warn(pmu->dev, "i.MX9 DDR Perf add events
> failed (%d)\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void ddr_perf_remove_events(struct ddr_pmu *pmu)
> +{
> +	int i;
> +	struct attribute **attrs =3D pmu->devtype_data->attrs;
> +	struct device *pmu_dev =3D pmu->pmu.dev;
> +
> +	if (!attrs)
> +		return;
> +
> +	for (i =3D 0; attrs[i]; i++)
> +		sysfs_remove_file_from_group(&pmu_dev->kobj, attrs[i],
> "events");
> +}
> +
>  static int ddr_perf_probe(struct platform_device *pdev)
>  {
>  	struct ddr_pmu *pmu;
> @@ -666,6 +795,10 @@ static int ddr_perf_probe(struct platform_device
> *pdev)
>  	if (ret)
>  		goto ddr_perf_err;
>=20
> +	ret =3D ddr_perf_add_events(pmu);
> +	if (ret)
> +		dev_warn(&pdev->dev, "i.MX9 DDR Perf filter events are
> missing\n");
> +
>  	return 0;
>=20
>  ddr_perf_err:
> @@ -683,6 +816,8 @@ static int ddr_perf_remove(struct platform_device
> *pdev)
>  {
>  	struct ddr_pmu *pmu =3D platform_get_drvdata(pdev);
>=20
> +	ddr_perf_remove_events(pmu);
> +
>  	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu-
> >node);
>  	cpuhp_remove_multi_state(pmu->cpuhp_state);
>=20
> --
> 2.34.1


