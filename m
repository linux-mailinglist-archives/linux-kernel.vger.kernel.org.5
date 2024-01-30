Return-Path: <linux-kernel+bounces-43868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A068419C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391EE1F22D73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53445374C4;
	Tue, 30 Jan 2024 02:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iU/cZ6fM"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415737147;
	Tue, 30 Jan 2024 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583592; cv=fail; b=HtU4YmxjLlmGS+nRgY9CD0ZiyeShrC2jWIwhiZUvNGqXfjtfV9sL//TMjBmhfwT9sBDabuYW73eJ3rN6g/Q2ktf6xsd7yigTtt9AiamXSXWWveiJq7aWxDwVnUab2NM0yeKmcRi/fgqooND2epl/4Z5FwP8q75ss+QznjHjfnE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583592; c=relaxed/simple;
	bh=hkLbO5a2fP05el41Sa7oK79nNWvYLqdEoYURC8oiqXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FJLha2UHc0UM/EO7kqBFEoY5MD06BGbCdv9ZmoCHfHxk9O+uNonTuJ0VxmNJXghZ8ACBLmTbxlSWzRKYjXViLVV3Qx14OVaNEoq1CcphGFcvCb7Ivg9+3ma+1OsNDsuJGJpSqfpnsMR+lEtHvU/MxeoBboehQpD8cvUk6AfkA4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iU/cZ6fM; arc=fail smtp.client-ip=40.107.8.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJdLucG03GnZTCwyWLzf0aFQ8B3VKkJaD/WyKhs+8PfcEm0j9gyBsyjxzKRQFSoxUFVf858gkpPb54ftohwnBlH6UbnAwV8zyxedYB0R8z7lS3LXys36rr2Bdi1bP2AYXxeqZPaZGsftYK4NdL0h1y1DarX/F1FvTCJFXTT1ecGjE64O6tZCtgQl9Y5cw+pbRAlVQT4IWEAqYiJFwO7ROxS9yPqiffjtqxBolUm1rjUDBSyeNwSp5nW1aim/DtLt/uM74e0V4jImVvcB75P0VcaEqJqognRs7vbbJh6HCObw0L7PY8ck4CeyYAWDAPFSPei2Mr5IPwsEx6wVshbnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkLbO5a2fP05el41Sa7oK79nNWvYLqdEoYURC8oiqXo=;
 b=XHTScx11+Y/ExfMvRrUHZD/KuHuBNMu2Z5l49V6tAgvkBe5sM+gxqHaEN1owjmqUVA2xcMdhPvlWTm91su87yhaa7ZSfXA0VuJQYvlhRJFm1d1//OSJf4w0L1wSBYvqQhkSCTKIs/mT6Zgj8ydMYXVAYEFDrLB5Q/syOdBSY/TGUhONSMVd1xP+1X5FMPniqR1+2+jGBf2vt4ENBLLDCLJu4/kxd3HhfGuE8aTuTnfsTmOEg/3J7E1jnFnk9k2NV1pYMfT5AxonF7GmEScd6Umvrh4f2IOxJIhfx/TDsK7AId/9E2tQc07qlhsuNePAx7Eq38+tsvxmIjVVSopehsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkLbO5a2fP05el41Sa7oK79nNWvYLqdEoYURC8oiqXo=;
 b=iU/cZ6fMLkKCzmb1y/Sx4zysOXKPBS2VSJLelLaKbQ+QI4eFT6GCVcmAv3mibCXZwO3NGqlfafGDnRxBAmIU5tvcFIM6TIrAzOoGp3LouSuQ8SyVlUbxyLK/1euZTJbIz2koXBPQl3kKe0oalB672iCvVEx1r66TmC1Oh6xjv30=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU0PR04MB9393.eurprd04.prod.outlook.com (2603:10a6:10:358::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 02:59:47 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 02:59:46 +0000
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
Subject: RE: [PATCH v3 4/4] perf vendor events arm64:: Add i.MX95 DDR
 Performane Monitor metrics
Thread-Topic: [PATCH v3 4/4] perf vendor events arm64:: Add i.MX95 DDR
 Performane Monitor metrics
Thread-Index: AQHaUpsbDhRxzXu5lUqT6cAOfuv8brDw/UaAgACuBfA=
Date: Tue, 30 Jan 2024 02:59:46 +0000
Message-ID:
 <DU2PR04MB882242590A9D8A08F00EA7A28C7D2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240129101433.2429536-1-xu.yang_2@nxp.com>
 <20240129101433.2429536-4-xu.yang_2@nxp.com>
 <PAXPR04MB964250C00BC537E59BDCF808887E2@PAXPR04MB9642.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB964250C00BC537E59BDCF808887E2@PAXPR04MB9642.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|DU0PR04MB9393:EE_
x-ms-office365-filtering-correlation-id: 566ee943-65e2-4b77-ea3a-08dc213f847c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 g3hWZJ2K972HVzYk4jCXo4+5E8fo2UpkWY1XE2pPhPd2KdmdPBTsbEukAsZrKBks/8LtgP9XGJo2BxSJwdxkR0p8uSHXhUashDyfnXdI25M5mmo/aMz6F6QkOVdurVVkzNjXp1uTIH5XX2FP/PfPrSvjIZsexZk6cRDnXoW16af26hwl0gr357gal2gSBbC0Ibml74ghECPeu2pQ/8fJU+D/Q4ABYcxxUYKu/cUbrxioyVqBSWhOMul3i1waQ986+EhuEwC/0a4gDy6OXrnBXkKz40nO3FsO/7bpE0NfQyFcJjvzb95NOH0TKvWFPUSCKPJS9BLWBAKPMafMQW8XiqZkUmAq6r7xx572c5yxQvLjugrtE+swPLjj2eKoXnegbbN8rHK0/qsWuYhOM/OB6wA7CkC0haZFpfxoeUmEyxtNNk7NT4ykgfkSbZw6VwHK9AjnLGKBvMJY/LkIwkVjxEYFEByd4IYe6/w6ZpPmrYqc+O+U10HQ6i4xDOOklZNYtrXqoRMPMlKwpnu6w4jgISqT3UMLZXd7JSuBWT0WCczn4tTay53m5ukT9VzM/eFORyohaP1aSogggSPg0NcdXcgrNi9ffRGfeWjsKije4aM6TlKoo+Vi3GfVRg/gXbPvgmcWpF9+q5r4zwCqCSKQbA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(478600001)(55016003)(86362001)(7696005)(122000001)(38100700002)(6506007)(9686003)(8676002)(558084003)(7416002)(2906002)(316002)(4326008)(8936002)(52536014)(33656002)(76116006)(66476007)(71200400001)(66446008)(66556008)(110136005)(66946007)(64756008)(5660300002)(54906003)(38070700009)(26005)(41300700001)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vpHxBpW4T6u+ZWTnuBpe8rylnQ/fbkgs7vQtDTT5Wcve6XtstFqgOg04su9M?=
 =?us-ascii?Q?pfZGR0BYvqi/CfCOYi2HZOUVh4D7SScR53ojRy/OBMdjTDeuLW+EA02M6x5w?=
 =?us-ascii?Q?viK9/peyqTC2Ozwbs78tNy7mxO6ydCh8qOhLre3Na+mM6VJAUlT0TeVGWzlW?=
 =?us-ascii?Q?trBONDonbhaEvknx2yhA+UmbokoA3PwH1GKxzhPACDSnJzumuvEi2OHjQsEj?=
 =?us-ascii?Q?QxWCq8jRqA/axCkM3Ibf/mSWg5GCRUVJ+7nbwTTJiriHuGBq9G72HvV3Mtr6?=
 =?us-ascii?Q?eHBJalxPBbv4t42JArTbFGIhywN/p+7g0kgD87O2RwhpYzICdPWAOFKhg/GP?=
 =?us-ascii?Q?FAFHjcw5dJeV58zbsRBC4rcU0YnBl1ahnWmY12E5iBmamXpGxVE82bex05XA?=
 =?us-ascii?Q?YAhCYMHSoqa9MzCIa2NKwRbVjd8H5maz2TpJWAsk03y55KAFfotUn6ZePBaL?=
 =?us-ascii?Q?4iXOVKFvyIo6HgjjDhD2cItCjf++mrliUlIxhm3ZvVQ5QSQjWixWIwfJmom1?=
 =?us-ascii?Q?mx1epVSo1My9HTl/GCfBoNx0Va4hBAngNQi8b/m9Fdnfl/kKhZQ955ySk5NJ?=
 =?us-ascii?Q?9rBbznSB+nkYEjdiwtUMf77PCJsG4TssS+zIqu/NILxiGcLBa17jEJFPc9/d?=
 =?us-ascii?Q?9DzcVu/alrX4fFw8tuGcXpdvwtel80KNyp9Z44Zg9M572r9I9LvRzYjBIWSa?=
 =?us-ascii?Q?L0ps0vHgZQsltDtRB4ui7jcrsZMT2SYJBi1zfl2pUBNnpF08UBjLrMOEc593?=
 =?us-ascii?Q?8eQ9GoUugeiDHQSddIqk6MXGrpaPcIlqB/f2DgpZVN8yDA9R4XC/9holkUMX?=
 =?us-ascii?Q?/jPhvRH0lsUUupHJfwnZa8HImbkWv3s6jdUlw2y6xBgVcfxf/pjiqjaprz/F?=
 =?us-ascii?Q?OIrWl8ro5dChuoWa331ssBRaRJfIgmwTdTpfDgGKGA0slPubd4ta1le+sb7b?=
 =?us-ascii?Q?QVhxkH3hk9hC8UiUCFm3k9zONQTGmhTAK6md12D2+WwRvojwEI/+mgQEXOOh?=
 =?us-ascii?Q?8w3qs7CQj7TjgKbsmVLSesT0inHWCxwz01dej0k4jJjUUV8qhOdjB4x1AgFS?=
 =?us-ascii?Q?hu5oBuJ37ZLm1pgjQTTfrnpHEr+r6gUTXnauJQfB4Jl6kHXnc6IJMr36PBoi?=
 =?us-ascii?Q?UAlNQ6J6VtPI10jgsONfq0l2WLVjhcemfimw787EImb2IUowlgHjkSeSpBoL?=
 =?us-ascii?Q?FbgqjZzbC986OIJ4FD4x6iDNtqhpwV5NMk+Taq/uNTzkpMkn/gXCdIDYUkrU?=
 =?us-ascii?Q?3sIuWZ+9jUzRnhOSBrtsY9j5/B8P7/iz74C9qY/PRQeV7EOebQVxn5jPgT4R?=
 =?us-ascii?Q?8FY2iGu8w6I78G6SiQeaGgAZCtuwjwoxI8N3Q3gObrmrESiWe5qY7nmc6B6z?=
 =?us-ascii?Q?FJhkk89TMPbqfC+ppsSvdKRFLDHyFGv5Wq1dTz11O/7ACCL/tIszgg51jzid?=
 =?us-ascii?Q?3Ob6Hw7sojkt+O91q2c7ZgD/f4L/+laDB4pXeTDLSO7i26QZasU6Lnp9Uh7h?=
 =?us-ascii?Q?V/9IVsagV4Mt78a6LjoqXcfnmT7zBynbb8LvesHJSvWYGvFItgsdk8umS7yQ?=
 =?us-ascii?Q?/hwfcp3skTj2muG6AiQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 566ee943-65e2-4b77-ea3a-08dc213f847c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 02:59:46.8708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6WFYQZ0snJfvUdoxKXakD4T6aFu1DUfVhj7izxiJQibBNX8mB42DZxNfi0PUWk6Lw9GgauRqMDINLdsygd8dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9393


> > Subject: [PATCH v3 4/4] perf vendor events arm64:: Add i.MX95 DDR
> > Performane Monitor metrics
> >
> > Add JSON metrics for i.MX95 DDR Performane Monitor.
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>=20
> Please add imx@lists.linux.dev in next version

Sure.

Thanks,
Xu Yang



