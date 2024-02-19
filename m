Return-Path: <linux-kernel+bounces-70632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CEE859A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C761C209AB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 01:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035192107;
	Mon, 19 Feb 2024 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B/2WkZBN"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B4163;
	Mon, 19 Feb 2024 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708304617; cv=fail; b=HXVLAdgVTnJ0Z3kiWJXSH5pCBSFTt8A37H/feqiooZn/3/eGz51jsSFdifULlrwLtZjk2gqv9im+CQMwq9gpGvzp8Q/syhhFjzWZbuHSUMoszILuPZc6HlixPT72zGn0fTiNY3uFbpWqhyWVINleAAuzwpk1IXcT6iEM9335iK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708304617; c=relaxed/simple;
	bh=Lo4IcBEQx8Jk0fZNMVGWJYR98mNGc+sAn/KCRFi27qc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GBlAPEn+rzm9U/80gbRoMqjnGqKky6z9ZalwlOKprWS8QYfc4/8fh64FKXi0RvoJ4Fe5JEqsxhQXoh/gq3WoqHNJ9a3cVmzB/WDS9nfey0Ya8jcRk+RZF8jHDeFDjqJkD3hBk21KNORUoy6S8Hw5CUxNY2hvhpoqbwuf/X4t248=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=B/2WkZBN; arc=fail smtp.client-ip=40.107.8.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+L1lQPboomxqtos+qRgZMW+u2SWPagBLY1UhwTNLq95Wwm7YPaxStGMzTq6P/Phy+A+3a7IKBasg2h4fSDMVmExVlfpzqHWrh8hJqhWfGxBvbPlKNV0W0/ZillOu0C3Sky/83hfbkeF84kPjINx7222Uttb/+aLUtX8L6UwHfichloG3rPG8H7t8zF+y+++dzhPcCXt/hZ8XB1rQj3twWSDPUgTvwOelf7eaoUOep7m8MTFJgz6Ltek9n31bff0qNkSd6X+T0f9x5fbpDsl6iAMfMaxTEBmQ0Y5Rg7iR6QHM2IdDABI0xEmPpAGTuYEdzSzmHE12GMsXaBk0hzRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPgE3ob3aUIeF1aoxeVd81WxBqxETHatx9vjUdTrf9A=;
 b=Ak3KjwrSc7UeDFYGGwaETHXZJICeav0x29lumAwsgxt4MXJ5jfBs+goQXIvSoNFqf2kOZptXc1nQ0MN+qJ2osD6wAoL/pjZ4LJlwVHW3EnSKfc2a5QkYMu5sVlC1qnqsAfGChfxsy5SWQkWeB5oS0Uk/Ax/uoxpW9M6MRsxBS4zIMECHHgZ5nCyvNB1jgrNO1sNmiMbIcpY+G7s1aMTpygisGxmGHwPp13yie4JfLyT5bLUl74ePkVhZ7J4+z0lhjVxrsNr43mB4c7jB6y0NSVKXiH9h1hWGFyyMd0zcQaE8Iq1zC1KIWWjb4aoamJrwnhVLfTph0l/dvCXEjDCRfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPgE3ob3aUIeF1aoxeVd81WxBqxETHatx9vjUdTrf9A=;
 b=B/2WkZBNRf2zavyng2fe95kyClSZr87Pu9YtRpSW9Axxum3h9SjHGYtAN0uOaaMraXdj42v6BFCik9i9o4dQWRMsjAi5UVWl29bGbwW8GcZUnEt4gb1XIh+vQ3rZ9IsrHx1zRhOWqtjlGdmVYlkZg4AnyZ2omAf/QIAwDktQ23Y=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9633.eurprd04.prod.outlook.com (2603:10a6:10:311::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 01:03:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 01:03:29 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>, Nishanth Menon
	<nm@ti.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
	<konrad.dybcio@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
	<jonathanh@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Vinod Koul <vkoul@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patches@opensource.cirrus.com"
	<patches@opensource.cirrus.com>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: RE: [PATCH] clk: constify the of_phandle_args argument of
 of_clk_provider
Thread-Topic: [PATCH] clk: constify the of_phandle_args argument of
 of_clk_provider
Thread-Index: AQHaWq0ZPI/aYtegqkWDKKNVao0UqrEQ6UOQ
Date: Mon, 19 Feb 2024 01:03:29 +0000
Message-ID:
 <DU0PR04MB9417F8D996A661CAA9E542FE88512@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240208163710.512733-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208163710.512733-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU0PR04MB9633:EE_
x-ms-office365-filtering-correlation-id: 565eb74d-c0e6-4eab-2e9a-08dc30e69607
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YGHe7wtIOI5wGk2i4JEkm5WM2hr4XcziS1MG9DOD6/0S/iJpB+C8ki334R+NsmFErNIf/ZLWgRU18Nm7mls7jHESTWDd5VVnoFHzYTEmu6V1UgIysYFhjmo5gwXzZ/CgaSGhTd8wK07ivjxjY1M8ovw03pDVjYJ+GhGkW0OQ5BI5ZhzkSkZETdKVY9xRULREz12NvKYoVHdVuBVsGaUeqA4nJ6JgSe3aJaFwueMKeCH/AoKfUSoq7PZb5NVxD3wT8jDsGkJ1rXLfZoNaSqFxEwteM6hzHKuz7wsx5QEzJD3glmVsWWP4kGGXq2UoTZWgaKUS5X0Fp4X6yGBJvumB2s5p30oAunfi3G/+fFzp7l3A3eja0RehNEJcnJkTu5XFZmOy0VhhpFzCp94x3SqorLPRCNJ8dgTpSnfuu+SPu/h1DM7d7trGchR8evQGZO0G17MHAd+/B3EtdRvJpjxzMSGNqjkURB0ZysrwaYHSHmPbWgHIMas2wk7MFpZaSligAyR3w6Jja7tWTi7aV+oxGy8DHJA/EzIU9DrfW1Yjt2UfEzulYF/L7hBJdq9KAIfSVumHrRRhVUy8ViQluzQFwbfWXNswBxBwVJ6fSDSzBC8C4IdUBna9eNNsqy1FSOMsCVRrQBDl3lnvXuTRFdlF6Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(396003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38070700009)(921011)(26005)(41300700001)(83380400001)(8936002)(52536014)(8676002)(64756008)(66446008)(66476007)(66946007)(76116006)(66556008)(316002)(478600001)(9686003)(7696005)(71200400001)(110136005)(6506007)(33656002)(122000001)(86362001)(38100700002)(44832011)(5660300002)(2906002)(7416002)(7406005)(55016003)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i4+e8mXJqncfZOk6Huf1v5+sflTwSEEfQl94kYxCcN0Sl7VL7CrzqoZCrTRD?=
 =?us-ascii?Q?XuYQ6F0aRa9sKYpV7Pit1fadsZ0IOI7CY1WVDP3OSSERRcxmsSqJkjojBi3c?=
 =?us-ascii?Q?Dukxc7+CT5T/T82D0cEumvJymXeSCSCrszSiYWewqkAWMsPAappllUTyi8V/?=
 =?us-ascii?Q?fRvz2ytDOjkIgkHnF2QyvTxYqia4EdP4Tujd387Cq1my4V75snY0bggxPumG?=
 =?us-ascii?Q?Pg8yE4uQPs7vmosmqdtZ7FnwFAvLD8c81+KqKaleXXmgqbJaEwJ/jFOnb9hR?=
 =?us-ascii?Q?N4zjMLyqdzeiofP/U8Mfw2DNSC8/smu25P+1jx+VMf0U7wZy4p3rFf/eFoyP?=
 =?us-ascii?Q?lbBmUzW6t2WmRVRdkgAOErYibWeovbgYB2xLJSzpAzVQwSOjyt4sscoIp2q8?=
 =?us-ascii?Q?R0yp54plqxy4u6R6/0vubRX2V4QslKo/ChIO4iZ9wvQJT67Pg/ZBViCKHNxc?=
 =?us-ascii?Q?4fKF25/FAnX3hbNTKvo5NdvNBvpc+bSJTZOJEMdvB2PLDKvOx7u2QOanSrxE?=
 =?us-ascii?Q?kEPMu8xUfULWZyg354Qn0dRFsHSJMQrFSquuP7R//csyDj9Hz3VDTWleUSH8?=
 =?us-ascii?Q?JgEI3sMtOiYS3mptn2lbnpKqRPmgcaccbdLPcF6jeWGz5Vvyqz1/s32sqvWz?=
 =?us-ascii?Q?/XuiNZzjJCQCN7uFHz7RQQCEy6gS91kDrCd97wMLdtLosKlOu7iQqiKMgIpe?=
 =?us-ascii?Q?1qUHpY4A+gLCwQN3mWzZQtNmwhmR2rmxi4FlbLkZZy8CKzq02TB5Ihhb1n1v?=
 =?us-ascii?Q?gjQEe3Vs69xPDMsoZ/Bd/VYMSbOziaSfWe0SQGVxAVd27yhzO4sntfK1L0G7?=
 =?us-ascii?Q?VqiZjBbzVzYVhDDze7mvVjRGJN2NJbM6Y932iQ32pxmZ9+DMaBphNKd5zHvL?=
 =?us-ascii?Q?CRoX1MMarGTzwsH2cG7tJvcV63JeasgrNYe8m34Rb7O5ndlwlC2AZtXw8bP2?=
 =?us-ascii?Q?V7V+B09/SA3cBAzpP477mkJ7Jv852VUaLiQoeZXysqCKzk57ckmn8UOUDPVT?=
 =?us-ascii?Q?MhC+W2Djq3tXOcrk5t+bqK/DDVeBIOHth6MOt7Mkji1bQVkYwMY1lHgjim7q?=
 =?us-ascii?Q?5W+0cnnvBXxtW4Fg5qIKrSuzBnJleIure51xNWCudO7VIWUh23Ag32quYpxJ?=
 =?us-ascii?Q?jPooVPIgKy3YeH7OBvHtkxWopNPUtApwlmRLl6vf8v6CAoklOZfvw87TqVgQ?=
 =?us-ascii?Q?FzEwN93dbqq9dwwGxUnR2EloREEVlLVlZx2vpmKF+WxMeQHA/4wmPHu/NyGd?=
 =?us-ascii?Q?Ewhj5AOeC53I4EFFLNtXtkt3lmh6dEZ9dcdSZojDAgq2nWJROz6jx2oFuyJv?=
 =?us-ascii?Q?PZW/YKWq2aSclkFoC9T/uE22pRpo8tb4hP30JyzlUHSIcvGA/CtS4zsIKFDK?=
 =?us-ascii?Q?EqDo4iSymHRPUJYsL6iUctvq6Nt8+ouF7xvhSdFpDdFakfeAqHjBt23WQIm4?=
 =?us-ascii?Q?RVqP0OeGMQJ4Bvc/xBlCJb36i1navEuRaopUM6v9EMJptm5CIDqin7VE8nUW?=
 =?us-ascii?Q?N1+3mRyLSVUJrm9jhGBUJvAHOTVLO9LwSJ6A18JafVMS8ZTTuZkqKuy+PaHz?=
 =?us-ascii?Q?YslMAGRZ7W6hbM5eMm0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565eb74d-c0e6-4eab-2e9a-08dc30e69607
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 01:03:29.7182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYrdvf3S4gMi2esedVC0myE7nCcmuM5HFRGSaYtPOPDOW78ggG4W/4qFfFv+a2m5TagT2bkmI+VKnRFjp1nx4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9633

> Subject: [PATCH] clk: constify the of_phandle_args argument of
> of_clk_provider
>=20
> None of the implementations of the get() and get_hw() callbacks of "struc=
t
> of_clk_provider" modify the contents of received of_phandle_args pointer.
> They treat it as read-only variable used to find the clock to return.  Ma=
ke
> obvious that implementations are not supposed to modify the
> of_phandle_args, by making it a pointer to const.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

For i.MX:
Acked-by: Peng Fan <peng.fan@nxp.com>

Regards,
Peng.

