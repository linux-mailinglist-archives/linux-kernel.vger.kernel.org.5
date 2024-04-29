Return-Path: <linux-kernel+bounces-161785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AD38B5141
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DDB1F2224A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F27210A11;
	Mon, 29 Apr 2024 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p5A7FI4Y"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375729449;
	Mon, 29 Apr 2024 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371641; cv=fail; b=n83URE6lQs17zwt2326E3fiYQOA7o5sgTCiBPC13ZrugMl3Z7SNw94hF5h2MgLP9q4afePYYj/7oP8dCGZ1dz+tER8rhPTg1PIAciPDsDt+rkqZeLlloq4jE0LF42fevPy+Lr45s9ee/KTwnL6VidKjXpDTWzemegmSNapAI01w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371641; c=relaxed/simple;
	bh=ruHxHHTXByuITTMa4qWxSCMu9Hht6wzH98zoXcaKWJc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BWfQUilgf/ZvgoVBRCxWK5djz4KEEurwafhFIFnhQQ0WFCcMvhLtgzXWeC1CwgYHcoC/LuQrQvBJZRVz2HaHtgGDFJQEEFw8ErkGf232e7sk1uiNg7BKElWTGZ5ANxi0TMDvEbMp1dWix4bdAxZ0b+I1/+GLPM3hK1j2K8InA0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=p5A7FI4Y; arc=fail smtp.client-ip=40.107.104.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMi/glt4LizE4vZUxjLprQ7a6jho4naGa0C2l+VvyFk+B2C6tcKj0ak+1Ac7vvWNUfRAgMOF7dsnUtF1ZWCvtc3D3zzQQen294Zi1ORBsr0tlsLIZcp8OX8U6rK9mt3O8p6jck7T1mq2PzltDWHQoUUnx0fhRHAZfcJO2d2eYUX6oH/Ya7o2pua21CzBhqajrYRIktfOymDU6Avl6aKLNzyKCkWt9oymzLiv7yyVJiYSBXv9D3JOUM+mznK3YpyFfO5rIt91kcMTlLTQ7uPupB14qcpJor0nsQ0DPgZziwLV6/C2zc7VqjtlkSVXHEEyWtoHqgef5cYf1F1OPQ0Y8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+Rzohj9AsTqEEBWdDp9d7bQd4uKYWgAKNIU6vhJ4KA=;
 b=n11zGzDM0qDUR7MTXGy4SOFpbOq+DyzEcHEQ3LHaDIVQJYM2Nap7CP7QYWyiYhnUj/1OZEy11HZG1m6CcbzNk8d1ZScjQHq1YWyXk5GE0HQB31z6ISFrgVEzXGWFbsMjXQ4FNRvvtvEvOJZKXRXFnPnGNEUMiyjZlq8qzftkdede5hqeBPtpxB7ITKqmRuCpUS4X64t85yLhipp7V61LZ4fSc+27o6UMb22jYnML58hwoStAhFDsLZTR0RLG1L80QeMgr5HEa4FuG8wWPLWPn7gVAiCFAJ4ChMTZ8szkPF0deleMr2MT699XDS81PHE6ql/wr07w2KoYDIxmUAFv6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+Rzohj9AsTqEEBWdDp9d7bQd4uKYWgAKNIU6vhJ4KA=;
 b=p5A7FI4Yygxml8xw3up2fRIiJ6t882XNyNf/3ebBxGPrmugOadH2LzxJx41TuPyoGVeA6IvQsp3DhykLdVEIFKs28syOwtOB5ZKqawr65K96BRjOYWJB5Q11J3F6JEIuwJDBeO5D0G2CM091XUjfOwUB/unN/Tb7k6BLYClz4ak=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by VE1PR04MB7261.eurprd04.prod.outlook.com (2603:10a6:800:1a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:20:36 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:20:36 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Peng Fan
	<peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Bough Chen
	<haibo.chen@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH v4] arm64: dts: imx8ulp: add caam jr
Thread-Topic: [PATCH v4] arm64: dts: imx8ulp: add caam jr
Thread-Index: AQHail9/2tC45k7moU+7SRi9mZgH3rF+5acg
Date: Mon, 29 Apr 2024 06:20:35 +0000
Message-ID:
 <AM9PR04MB86045B81C1E9C3B660079546951B2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240409092040.3870497-1-pankaj.gupta@nxp.com>
In-Reply-To: <20240409092040.3870497-1-pankaj.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|VE1PR04MB7261:EE_
x-ms-office365-filtering-correlation-id: 75a652db-feb6-480e-54b4-08dc68147b7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|921011|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ot3ZDWViOrle39aNab7PJrdOxZBFSJr2AcfU02+ESAdPd2UhS4kVzxIJUNKD?=
 =?us-ascii?Q?uUL7H9S43PNXmLJkHTP0oHSRxrFbTuWqUL5EcttoT2+CouH9bFZ/Nx1ID6jc?=
 =?us-ascii?Q?U5J7KHPqBQ0THV0za8YmzeTq9vv6v04pTTj5StuidrKhDG54ksd2y82oQT2V?=
 =?us-ascii?Q?tVtfZb0/mTXODKxrJNhOW3kjsdUyTz9t9tqN5DnO9jmksxARJBLJ7qIrC2NW?=
 =?us-ascii?Q?JTRrpaZCCe6rjJAL1c/pG5NBSxZxzp37eStKInLbARK6MM6oARq9Vnf51zOh?=
 =?us-ascii?Q?BU5rs4+3sinc6r4nA9LM/zm1m1mGa6Ya14XsXSy0mujVUJJ1GT9D88sDZeAa?=
 =?us-ascii?Q?HNuk1llCNQsnzdA7nuSsXqtTPYAK2wzIMTYKx2EjdzcLFta6KBZT8RLV23SB?=
 =?us-ascii?Q?XqvuKaFn4gCkeEJqXJWD/6u3FiZU10FdGUoxUIqU4WFXHCOcYcevtAu+5Cc9?=
 =?us-ascii?Q?+fKhWCQljBw8lc8xfm4eMFKk7xCBRzybPVOogfDGD2wSyD197zzRXygJyu1b?=
 =?us-ascii?Q?bVSpfWnjJT1yMg9VclruTAT4L2k50O4CGgKWQUvBKw5pQ8GT/lFhju3ksXte?=
 =?us-ascii?Q?4/M7b2nmEw5Ac3t/vr7ewL+4QfgToQ4GB+VGbbNDcZQayvvTneDs4Ra0h2H3?=
 =?us-ascii?Q?j6AGcu22/4V91ahI4gczEDPu9FDj/mcTPqfVWmxHyucn1pOspFhhpahqnc8R?=
 =?us-ascii?Q?wsS+kW3bZ+PWOt1bEVAWRY/yH6WuN2bDzBlRa0+4/B3CDJ8g1UtPMGXvfU9K?=
 =?us-ascii?Q?zwHYkdA1mmUzDPSbdQMg9K963H5ZCMXglMJ1ZK4G9hwIGJD6QUtkVlOVMc+G?=
 =?us-ascii?Q?/afus/ad5d/0OJwxg4p5Wt6NieSKfOvqhDK4NWOcusxbNwcDPsrB5ZzsdVsv?=
 =?us-ascii?Q?ynV4w+Yw6G7cKlGeo5Je2KBJVXRQmnv/tYz5cXkIGxDtUaqJPJbXGmVTLJkz?=
 =?us-ascii?Q?tTNryLsoEfCqmrrgbi0XW6ya+NJprWZzfG7WDpimdmJpftFoK0XQMZrOrN5H?=
 =?us-ascii?Q?D6akG9O6WwtyQP7U55plziOXCxRNCS2mKHARm2oWB8DQRDsnEXxG8JXmXTrT?=
 =?us-ascii?Q?IYbjYDfcmMgioA93ADpj8ouCcxRxNfgM3fYULFKAFHj7b3RAz2LDodTlp3wc?=
 =?us-ascii?Q?8pHVygmQsEj75gWnaM8PwbY5cEP6fiDhWlKkSj7YKKD6Ry9l5U48aURAwmqb?=
 =?us-ascii?Q?P+t6YdWwPsfcxJGDEnd0KfnCddWdVUg8oqbQ6DZmsv1ecArpTYibvo56SeBq?=
 =?us-ascii?Q?4CabV/WfYuH4Ie6gFvKOBmjKT/f5VpSRsy7vQnLvtjprLyqMJRZlP/kYyaER?=
 =?us-ascii?Q?BxBLW1+7jjmgO3sJE4la4/iturnJv4oVrdjFceNRRsZFb6RZMDZdVo08+sXb?=
 =?us-ascii?Q?xZcqbmQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RszPjBsN1MqzAm5tKrLeYEUmWPngCDUdR3L4oS6uXkfS9u0rImUlvwAji4AG?=
 =?us-ascii?Q?clz45GUVzTbmqdkCdPmU5jbdacpO8SVa54W+8mq84Jro6v4L7yYIqTX8v0xT?=
 =?us-ascii?Q?1kbq4JvTSxYIYWGXOIhpSiffRcWnRk65YT2llACCqVki3IT3OzuJo+6wxhR7?=
 =?us-ascii?Q?q2AjXg2GC1it+V/oaM3bAqa+b756QAmWy0iO/n8syuv8fDypReSFkjMGSZQS?=
 =?us-ascii?Q?aq1tllLmogHLD8cMNNpCbRIlbqDSFj+p8LD/a4nYZVxjPRmfJqCUcU2WqLJ9?=
 =?us-ascii?Q?lJq/6hmECvd1jQKwO+BNRN6pPkdMffnZNK9nE2pim4NCJlj6gOwRRcCxm64h?=
 =?us-ascii?Q?atuG5Pu6bjfc3pEm6/rKGf/aVguUDp5wBa5uevVRlci1NAq5J9lhZWfP795O?=
 =?us-ascii?Q?cPsv4a+VVQ6m/zzyzIs5xYrIbwMg9K0Qe6HBRH6nhlTT9KQB4uefVhoeZ+3e?=
 =?us-ascii?Q?nBSVp+szQk4RhUo0QrH33bzR0qvX5eeMs/0VN8xUbDY7ip+CsGDqfqhfoQL4?=
 =?us-ascii?Q?yRAJUc4LvGBRWXInwlGXbBBHZmi3iQ7CRk123IocIl3BWDEN5QteRIjUsXn1?=
 =?us-ascii?Q?TxWX/XoB+iILhzokwT2MqAq1W1aJRcAHH1Qp2B3a0DzrkvE7p4L/q4trTb15?=
 =?us-ascii?Q?jX+TRTNVvvwe1ikRq+/ke5rNkr81/KOGyCeT1j4p3f4igBbxrL1ip9B3fOBP?=
 =?us-ascii?Q?0treYZVvZ7jL3rN5vED+ZvZuHhzCgxI0o7QOt0ueoniWuAYFN50nb9vSbdPE?=
 =?us-ascii?Q?dzjNjrW48j1qA5eeZZR6iAeuBdu5bkKV7mVqe7QAIl1tZYVm9v264HWEdTqz?=
 =?us-ascii?Q?mmIUvFvXgkPJDNipoQykV6JhfNhj5KcZlBxdOAPRFah9oopRZRK8UnA/yUyU?=
 =?us-ascii?Q?+xmaGBgQeez/RG8gTmTMW6dBVFJRB24//SXQsHre9pMz1L0nOO1/nvk6Irfk?=
 =?us-ascii?Q?UJnLF2DNg/opm7M3SyHZcaDNcFMEJT7q/9iABTO6FDcMc3P8JaCJpUwhbdnV?=
 =?us-ascii?Q?u8cL4ZJBZoBuFLCpj/+rGwzofCCrryQkAq/XHSkjkNIb5AptfX+6wBd8YmP1?=
 =?us-ascii?Q?sjQ/UZTf5mSnWuP1wQzG9z2HbFmNX+bsO1Nql7iBZcEtOgygrGxZw/ILyB0W?=
 =?us-ascii?Q?38H0hX5IBmX9F7x20MwZJkCrz0xaoXO5uhHbuOoxMGjKo78FdbExN0F4K0Lt?=
 =?us-ascii?Q?QNgmMpE1nk0+ISWHZzxzawt6WPfnq+oyZSThHYLwCh1HOLaGTxCNeT7nkhUQ?=
 =?us-ascii?Q?7Ls+P2FaXmGa+p+MfScS4FERZUkzPOvGYbFR0/2GacqtDR8yzFRLgWSmYqHJ?=
 =?us-ascii?Q?txSPT+6fk4CNng+HH2qlFlmd6oFpLNzYHa2CddiigF2rNi+6BY1Wv8/59ufo?=
 =?us-ascii?Q?dB6ZuUGYJSdd3F0hZFjowquBKBxtieqaK/YQHtBjNXcBOa9vqbzWnDwSEio3?=
 =?us-ascii?Q?JJPPaUEm08Pa+y2MAtyoYy0Qnkg54P8PU/UfBmbQfvMqmAAxvhKskoGp0+OY?=
 =?us-ascii?Q?Yz5ocwe5cyeX/BBL9Vg+i552mIFWnRlNiIR8Nyw8CiTnsXKHd92POkK7K6iQ?=
 =?us-ascii?Q?+oPSCgLmZoxsJ2bDdpdU+8LKRpPI6aDQaCBAcFKY?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a652db-feb6-480e-54b4-08dc68147b7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 06:20:35.9598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0V8ub8XM0sj30IVF8yq6ScY/74hqnb6OrweMWO6qBbHOUJn+NlRKRgMtMdQiaLUWTbR7bX9PPqM1nzR/EsRgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7261

If there are no further comments.
Please merge this patch.

Regards
Pankaj

> -----Original Message-----
> From: Pankaj Gupta
> Sent: Tuesday, April 9, 2024 2:53 PM
> To: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> imx@nxp.com>; Peng Fan <peng.fan@nxp.com>; Jacky Bai
> <ping.bai@nxp.com>; Bough Chen <haibo.chen@nxp.com>;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
> Subject: [PATCH v4] arm64: dts: imx8ulp: add caam jr
>=20
> Add crypto node in device tree for:
> - CAAM job-ring
>=20
> Signed-off-by: Varun Sethi <v.sethi@nxp.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>=20
> v4:
>  - Order of node properties changed.
>=20
> v3:
>  - Commit message title is changed from "imx8ulp-evk" to "imx8ulp".
>=20
> v2:
>  - As requested, this patch is separated from the larger patch-set of 9
>    patches.
>=20
> Commit
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 32
> ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index 8a6596d5a581..ed86854a59c3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -252,6 +252,38 @@ pcc3: clock-controller@292d0000 {
>  				#reset-cells =3D <1>;
>  			};
>=20
> +			crypto: crypto@292e0000 {
> +				compatible =3D "fsl,sec-v4.0";
> +				reg =3D <0x292e0000 0x10000>;
> +				ranges =3D <0 0x292e0000 0x10000>;
> +				#address-cells =3D <1>;
> +				#size-cells =3D <1>;
> +
> +				sec_jr0: jr@1000 {
> +					compatible =3D "fsl,sec-v4.0-job-ring";
> +					reg =3D <0x1000 0x1000>;
> +					interrupts =3D <GIC_SPI 82
> IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +
> +				sec_jr1: jr@2000 {
> +					compatible =3D "fsl,sec-v4.0-job-ring";
> +					reg =3D <0x2000 0x1000>;
> +					interrupts =3D <GIC_SPI 82
> IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +
> +				sec_jr2: jr@3000 {
> +					compatible =3D "fsl,sec-v4.0-job-ring";
> +					reg =3D <0x3000 0x1000>;
> +					interrupts =3D <GIC_SPI 82
> IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +
> +				sec_jr3: jr@4000 {
> +					compatible =3D "fsl,sec-v4.0-job-ring";
> +					reg =3D <0x4000 0x1000>;
> +					interrupts =3D <GIC_SPI 82
> IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +			};
> +
>  			tpm5: tpm@29340000 {
>  				compatible =3D "fsl,imx8ulp-tpm", "fsl,imx7ulp-
> tpm";
>  				reg =3D <0x29340000 0x1000>;
> --
> 2.34.1


