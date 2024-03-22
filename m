Return-Path: <linux-kernel+bounces-110993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BAA8866C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8C81F249EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7328C8E2;
	Fri, 22 Mar 2024 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GNe5q+W6"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF329321D;
	Fri, 22 Mar 2024 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089116; cv=fail; b=QVE6X2VZEGnuApxu/3bjyB+irGgGM+VKVPXjKxPLG+9kPGHk9ILlPQ1j5Jpt2Y7qo1+phRr1ZZcbft+yAy9Y8cov9vFJjmUGpLR18nwLkqmxSwVU+W1gVronhtCcjbZe+dzEwFrooI/hWOUNcvbkUuAxkFtBbJHvPY0XV/9RKRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089116; c=relaxed/simple;
	bh=2YlHTeRPZcPi/Cb7nMp4BX3yzEk8DOfY3a2xdJEPAZ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QHqqLCdvPNv2rNgjEqnt3ClHF6MZP4GHuxBISSEKO23aEX6txhnlGFBuZkd3FPkBi0kK4ohO3Pjcf0jFH4rwEzfGAgbv/XAe72IYded6chrSIteOwrX0hPH8YGdyfszwBgh8AY32n+HkT6kkFQPo5Jfi1EEaIqzfdt/NtLZtQGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GNe5q+W6; arc=fail smtp.client-ip=40.107.7.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7A32tXZFrRC7GiojaiPWLgQ2N4JdC5xXAAwWFKAHX6sUaVjNiDRP9i1TIzb7QaTzZp/h7rzm3mG1DVnL0NO4lgOw3BI13+zpAi8HMY7ZSnv8gv0/WCC0Uf+V5xIZ5zMJ1ccHvagWWwEORTB6hd+9ScfVPutfYqbmlrb0h3Qfg7DC8dUCI7Eq10j0EV3mPKcKWI6KVAc5xjHX3heGn//Y7pSVeHB/uEsFHeGgJSSyuMfRm1AvUBneNUfvZIaN+6Bjg6mo/4hENZ2j4lW6TBE1vS6VoIUSC/G7UuT2Gw9u8L1c3O7JrG1ExMRdvL4yb6HtXZgJ8jjQ03FFUMyTkXd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nr5cDn/6AaysDzcXxPIx7wczXVYfmmhDr3Bn14KDrBc=;
 b=Hd/WjjdjO+tw14mo5HqRTXAZz4v0alphhHCvTwKeiuNrEpDmsZSpIxPJ9hEIeyNrZs517Qc/mXUrdl5fP2AOaR/OfYuw02XE02D9+30fd7nfDd9PtDPg5Z/r9wExTpPJGHgYJIwkBANvMp0TM3oUmWm7X8X3dRhW+gH9TD2uwtvRV9RsJf+4EtPVzeWrYPhdBaPXaSx8P1eemzSlNkIBbC6yd+eqFj0/G2TTunexudYY7pCrGEP03UazUM4o/yM52T+QHcYBhepcQ0Vm6ulH9knlW1PcpGd6XVkO7LZ3+i7+o6WmvDAv2dOvbUw6Vistx0JaXUtqStj2dL88UHjLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr5cDn/6AaysDzcXxPIx7wczXVYfmmhDr3Bn14KDrBc=;
 b=GNe5q+W6orSabo3PiWIXGBYlKzEEWA0ozOyk7QDTdyyyDK9FZbx+RzYzcVPK5xz3Jg/u7MqCrLnlBLyhl9tRFAq+tCiM9tuu7Vn8LD2l7z+V+R8gFj1inRq+IbRWrW6yiCjRGiOHDoQhRlDLRpTc1g+/+91jmayLNGbbDENxO4I=
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 06:31:51 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3%4]) with mapi id 15.20.7386.023; Fri, 22 Mar 2024
 06:31:51 +0000
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
Subject: RE: [PATCH v7 5/8] perf: imx_perf: fix counter start and config
 sequence
Thread-Topic: [PATCH v7 5/8] perf: imx_perf: fix counter start and config
 sequence
Thread-Index: AQHadr8CiB2Brc8ylUabi+uaJoTA8rE92C8AgAV/fWA=
Date: Fri, 22 Mar 2024 06:31:51 +0000
Message-ID:
 <PAXPR04MB8829062113118B354CACCD438C312@PAXPR04MB8829.eurprd04.prod.outlook.com>
References: <20240315095555.2628684-1-xu.yang_2@nxp.com>
 <20240315095555.2628684-5-xu.yang_2@nxp.com>
 <ZfiJFj1IO67FR/z4@lizhi-Precision-Tower-5810>
In-Reply-To: <ZfiJFj1IO67FR/z4@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8829:EE_|PAWPR04MB10007:EE_
x-ms-office365-filtering-correlation-id: 69a3f7ce-009c-40d8-2db1-08dc4a39c25c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 821WL77W/YI4OvdDL0zhOsbmX4mB46BBeO+6nWlzgOEj+qIDjl8KN19wFWpwLvrgr+WgqfF7ETCNTzjzQ46ShcMm3r6Y9WKpQmwjYSVrHm6NSsPbjyhcMZnpsoMEno+jzGZEuCWl9LbD9Sp4b8cpAwNHQPtSCoA1AZmrGL4axu63QeY8gwOElWbYo48IkmSVMW92P9rEgb+clNNELHPDyjxaqllciFvVygdBp/rZYPfwZlYzYXHKtWVzq800WWaEkAe7ZHue/5nvkiQj/ilvIjoHeR4ASseJmKFATIHIk584dCErZS0YWDLHqVUwf+PF/c7uzQ24eJhen7HffNKpSb/45YJ6x8p3fhHqFGcfy2DkgmjgUuQvDNxhxSCV4dWrjBotgsTuMtkSnX3X/UMF4YgucSHL2P4fvunkEWUKv5m0tRQWTYtvjaf7SbNpfopRLoayLkDnuqP8/TEp6pg9FlUvk2sJ1vbvzujc2wRlzzgvRM9LQMUtnj4N16KdPyJu+l5bHI6mazUDwF0m6Jkczg802Tebvd+TW+CYpYNr/aJgj+h2mjQuv0LTWb1gK1hNmAk9x5nnYfNaisNJJXZdKpYwwriDl0wpuWChzKzI5XmSX2yGh32Whdo8PFYQHaOVi51bZ3mp0lD4okSYxR8SpJZJ5utmEzjo1/pwdrDGRm3VmrEmArPW3QMyWkD9l1e+lCzJlkiBu2TdI5sIVIbvZg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iQVQEgQWHShTeM3VNfofBIIQtBEmmA+RUQNCDFUd28X9xi/AuUHchqMTxAJH?=
 =?us-ascii?Q?Wh7gxelffj0GmX9yZrbEMvy6AbbDr/ymv+TWD/ope9ffa/J7Z1MECDnqHEXX?=
 =?us-ascii?Q?9GYCe9y+8FxKxHORsYazDYN51cxMtxNaRSVRx+n8aVwb8JOVbyuot02JmZ8h?=
 =?us-ascii?Q?FK+7ciJsm+ehj/nq7BwP5xLJzuXPcjKNMjaMi5ArMZQpFDkx/+38mmAIH493?=
 =?us-ascii?Q?OzsSxOeLfa09EkMtAvdLcewr0dNde7qqbGij56LVXvni3sSgQqjEr8j6cShS?=
 =?us-ascii?Q?Av0i7dxA1Ta0ETTTLC5MNB44p4lcM2aiUbnTsp2z1v59+4eVnDaqNMVXxk1S?=
 =?us-ascii?Q?0pUQ6RmdzXQR5Lnbf61yLfgw233YIS/xdBlbH6wNgkr+RJ+eOFKCdUlApMSm?=
 =?us-ascii?Q?D6pV3BOiyP3qwXtYjQ2xv4Mju4EySRcQc3+K8MQIDwfUuiwecC1/EROZGJZc?=
 =?us-ascii?Q?hUC79lPW/jW2RNyGXj/yxP2GQa/VmxaFnAEwaoFibYTn28dxCQNHT/fIbGMB?=
 =?us-ascii?Q?WITpBtGQ7WZsy6r5+QKvNaWuoKSmOWGLffX25uSdxGuWUExVbOLH99bhnB3X?=
 =?us-ascii?Q?SnSbxlqwt1KH7xf+NTH1LyIhLLl4mvlkYMKkwnDDJdcY814L/cRVXIHOgVvW?=
 =?us-ascii?Q?Ud0Nj4CkXJ15AYnvfpC5U8iYRZgFk2aMy1XD0eLDgUuOUc0j+ka0AgVFhfn9?=
 =?us-ascii?Q?o8bQFvD6cB70GtJCn6VNCSYFS5ce5+Xmja5yV4UcY7QG0nGZD+Y7OwHqF43u?=
 =?us-ascii?Q?+PS82D4D+AqVqe940iyGUFAf3pfb+X1A0sr7q04TQtpzc7Tnh83Dx7Rf/Rc6?=
 =?us-ascii?Q?fsPnUT5UG8WDIoD8vteNIYyUbAPYZG98T3zSJP26ynfwbsTI0paq2gyU19bU?=
 =?us-ascii?Q?9HZHneZpR0J4TpzUwW6AsAO27jD9HeszV0IL84P3mQpnp+hLGQxu9XxQvBw2?=
 =?us-ascii?Q?gTIZkeXCfcabsL4rRKHi6e6Mg6o7SQJI2DjqlUdaxrd1FB7e6DBkH3xx6sKJ?=
 =?us-ascii?Q?bDh8zKIWIgzU6fwYZeENK/1H29+6rGEsApelgmg4ZjXPnaeJJbD6parBZFeD?=
 =?us-ascii?Q?jI88cxiiDInI01f2O6B/pIt2uN/z4N1SsfcdgyYt6Mo7jpUml1n1dLCVrwy5?=
 =?us-ascii?Q?RUL48+8jDm+3lnudl/QrTCHyaraSea4pjeqm2+fyhYc40msZs7BRsbbEeT9j?=
 =?us-ascii?Q?D4MAzVf8nsKuWExlzisA+G0Nd80gfiz5JuXA+j78bj8IG2i520XHVyEUY9bl?=
 =?us-ascii?Q?E6AoGK1pOvqAgulV4rapmnvuhS3V+R4LEAXFrp79oCGVngDOQVEKSweQ6csP?=
 =?us-ascii?Q?yYQxqwWilcksgZOa41KKW4cSfiQCDrNXJSre2F2pY2d+eFHR53rx0B2AeuOB?=
 =?us-ascii?Q?UnwF4DLOdsNIchaoILfHroCvM4+muxhJODSRoN6ZNfHoINWhVuwRXHnNDbDl?=
 =?us-ascii?Q?H9IFx8v9unsKnCWyB7c2ng+J/VyM2V0LxkxcT15i6miOIL6m5WnaNtx84iw+?=
 =?us-ascii?Q?oro6qxtmGQbMUOa8xswUd0ENdHDzQTVWoV0HEQkvD5a11Feu3pplNG9KDVq/?=
 =?us-ascii?Q?A0A3GQUOkpV/U/E1lI0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a3f7ce-009c-40d8-2db1-08dc4a39c25c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 06:31:51.4100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BmRxFtc57aBbap76Sj6vpsKh/XxmXPY8LJJslyMJ5MaBoY3/u8/QzTAX3bwIgW9YwGh8zhHMWXojFGhc3X9UCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007


>=20
> On Fri, Mar 15, 2024 at 05:55:52PM +0800, Xu Yang wrote:
> > In current driver, the counter will start firstly and then be configure=
d.
> > This sequence is not correct for AXI filter events since the correct
> > AXI_MASK and AXI_ID are not set yet. Then the results may be inaccurate=
.
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>=20
> This one should be bug fix. Can you add fixes tag?

Sure.

Thanks,
Xu Yang

>=20
> >
> > ---
> > Changes in v5:
> >  - new patch
> > Changes in v6:
> >  - no changes
> > Changes in v7:
> >  - no changes
> > ---
> >  drivers/perf/fsl_imx9_ddr_perf.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_d=
dr_perf.c
> > index 5537f4e07852..c99c43b214cb 100644
> > --- a/drivers/perf/fsl_imx9_ddr_perf.c
> > +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> > @@ -523,12 +523,12 @@ static int ddr_perf_event_add(struct perf_event *=
event, int flags)
> >  	hwc->idx =3D counter;
> >  	hwc->state |=3D PERF_HES_STOPPED;
> >
> > -	if (flags & PERF_EF_START)
> > -		ddr_perf_event_start(event, flags);
> > -
> >  	/* read trans, write trans, read beat */
> >  	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
> >
> > +	if (flags & PERF_EF_START)
> > +		ddr_perf_event_start(event, flags);
> > +
> >  	return 0;
> >  }
> >
> > --
> > 2.34.1
> >

