Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4FD771C41
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjHGIZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjHGIZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:25:29 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589F1173B;
        Mon,  7 Aug 2023 01:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFsbV2HUFT1pKYwDL3yVMBD6GC1mtn1xJxhKkf2TBqDmD5AlV6t9+xwx6njBtU8/Zxo1pxQh4ih7OXtBaky/W1otCO0Tf4aAOFoHcJkGttkQdDesayejqRxfeZJSsVAq6rYXNaw3qlFOHy9AcASscZfBWsDtKyxwE19j1S7S7kanIS2td9wvXEtuIHqlbTSEinonHDvqewKyWHpINFiF4vZq4ccuiIO1iMCipmOWix2Jc71N3mXGr1KgRdWd8PO8cxnwPYa5lP6Uxr/OtBwcjdE5r8nd8hkU5qbG/fzRSUlEKpfC/Vh/U9JsmVYOJpiNXF4syj8WWoEANO0P5uFySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeYCQGBuVOU5k7hMMQyy5r4CdO9OTynBkNDoOD266B4=;
 b=lC3P2Mofhrk5SQ/71Xk/HUKm77yPc3LhdAaQ6fNsWYekLRdY0bjvLaqljJCFQH3POtLKtfgOr6cPtb+BeSI+gx2L9gU8z4EgGPw6KPdo6Yu7DmpLn1HPwTzOJsRPalGH+9u06Yssi3u89fMWFNc2Yv9a5SWl1oT/5TUdzMj26cC3stJbKnGHk8qEIqNJUSeJPJy/iNSYCftmrYNd9M5eNeqz76/PRwl2rTi0oKcB/LNYj0qPvmFWFnJ89rh4ewxl2OVkV+lywIGU+FmdWHfcD8QSYGZVBlVo9lUJjZPhyxAvOhffvHb3TqDKb4esMQRMsCmiXSy7+MFDCx1mwyFxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeYCQGBuVOU5k7hMMQyy5r4CdO9OTynBkNDoOD266B4=;
 b=PWtuwFHPtpw9sUpc9fur/RzePvm9h20LBAEQd9CNUwjMahFERnxUNSNrzlGDY+EmfzymiWn/1BGI/sr8zCS+UnGe5uIT9/SCPcu3hs8CR8gp+Yi5M499GROX6r7ZfLz5dCM4vpycThc9UYZ5NTYha0JIrDRYVHXFWgKMSluZyCY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8541.eurprd04.prod.outlook.com (2603:10a6:102:214::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 08:24:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 08:24:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] clk: imx: composite-8m: fix clock pauses when set_rate
 would be a no-op
Thread-Topic: [PATCH v2] clk: imx: composite-8m: fix clock pauses when
 set_rate would be a no-op
Thread-Index: AQHZyQhHU4zMCTsVi0qS8SrTg71ajK/efu0w
Date:   Mon, 7 Aug 2023 08:24:49 +0000
Message-ID: <DU0PR04MB941738BCFEB341B4DADA49AD880CA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230807082201.2332746-1-a.fatoum@pengutronix.de>
In-Reply-To: <20230807082201.2332746-1-a.fatoum@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8541:EE_
x-ms-office365-filtering-correlation-id: 81d58c51-388d-4253-9eb5-08db971fc46d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QGYY2R95NYwXsPZfNbLpKAuCYTwTOGqhWEQ3kxay1PnraNF7hKubNaaHaTcVBwJ/+Sr9LEbk6sqv89NSW6MkNRsxztp4nrz7kak3zt69MCAhulmNrmnCJ17u8m4heE+7LTPSHwj60bTb79PP9Jk4mQkL5m+jX+7nFrIQ00muNzfbzONaYsA+U+0fiB6371rKQ4fLrv5xJJejaOjszjLNQtS5LiUzZ5o5IFTjQ25NC6xQ12+lR5UYD/Enli6QDe+R2qr6DdSMNgqnftWzco9IgAFL7I95nYR+GT1zhjTFoa1GKGV/Ud4GdptXyEywdWvbkua/xzERjlR3Nl/NIzAFFuQvarKGEB35qW/+7h7NMRaXEtQUIerMoYSclfQYcBe7TGWIZQiMFDkbsFnfvlr+/9dBy7Iyv/0VsGzHZLKUzBd5jLwssAim9bVe3i1wGRWC8Xhjw2iGVc7c62F2TTVoHSnHXzyDrMtSYkZUf3i4Sv9ngK7mLrWB3Dojvz+siOoveGhDgP7+vNiGy3UZte+GFXyri3DWiJjJHkBIqTLZCn0Pt32vpQ6QSECtMX8vbtAdbEC9CFYqHOtyuwHzZhj0JI8vyNMLxds/Oa+XXeTHWBuNNKiUmmiv1vGBdXV4i55d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(186006)(1800799003)(86362001)(44832011)(41300700001)(52536014)(478600001)(6506007)(8676002)(8936002)(26005)(7416002)(38100700002)(7696005)(5660300002)(83380400001)(2906002)(110136005)(54906003)(71200400001)(38070700005)(55016003)(316002)(66556008)(66446008)(122000001)(66476007)(64756008)(76116006)(66946007)(4326008)(6636002)(9686003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P++CUpf+yWQ7jDgVsa+tzB/znwUODnIliNPHe85H0d/MTiXqEDg0fuVLg6Bk?=
 =?us-ascii?Q?g8IJXuN1HZiO0+xW+eAah6SB9FnY8TFcBgFTi0Zletn+a+cIaQyXlzBZhhea?=
 =?us-ascii?Q?slMBvQU4SbN7tK6I+c7+ZTZdmBkkdlIzegabC9K4UBtnx4IsdZ1SC1fhvW+t?=
 =?us-ascii?Q?eF9iWcCxrwsOTMevCVxod56nyFxcaSPYhHs302wZ3jMFzsRBnWIlEnxFhvDH?=
 =?us-ascii?Q?nIU7GfEqdRWZg0znw4KJtKnAQlMZRccuekfaDhyokQRXi2ZjvrdCXbFeca5Z?=
 =?us-ascii?Q?NS9sErrv7LJ8heErSDB/MDDjOeSRcFBaJt8NGyV3RgPYzKaJ68WEXDesIk3z?=
 =?us-ascii?Q?NJm5qaeFfNTc4nFqiZNtHvOYUxODjWoMmCXZFS3HB2r5Eu6a35FJ8f3lUaXh?=
 =?us-ascii?Q?tK2H8alTy/qd3JXk3AXZw5oj7JICJ6GSJ7anztX5Dq2YQCwOc6QCWaKs9cuF?=
 =?us-ascii?Q?3u3nng2I3T2x4r87Y1Vfuu2RkNP2R3B87UYxHJ0RTeX4mBL5rJPndladoN4k?=
 =?us-ascii?Q?NmxIkSoR+QAxiVtZ3RS28RnKSiGyslnQDUX/+T+zdzk0O1MsaRy4NJewmHid?=
 =?us-ascii?Q?7VlF7yQhsEvCsl5pn//tSd1sQP4vLtYbkigzf/FcUgaF/eEUBPnmFBcM3PAC?=
 =?us-ascii?Q?sEDE0MbjmUn8aVqyIf1pNpAnDY6vP6ndhtK0DV2TKmsBpaJgS0zcnMLVxtc9?=
 =?us-ascii?Q?65i8tCqFNEFgWLw2+TGQTmhBJncag18tqblPwivegkobrSz5YXaujtuPG9mr?=
 =?us-ascii?Q?fIVdiQFFZGfswh3wCCBigXDarxTz264CedOMJN/nEGlj7mjYcHOtBzSI6hUF?=
 =?us-ascii?Q?qLK8IBGZDUVcGLF4cZjtGUBUwpJrBA922acrPWGEbNq7CpxKtYRXG8/pO91i?=
 =?us-ascii?Q?EhqutF6SyS7mON0MmzMyFtNP3foR/4sEqeppSlQ7xh0Sn/rgnEWugT19Y3ZD?=
 =?us-ascii?Q?KL6UdmTb4cJtGNUBI5e1AjQbwjzk1mauBuF2p3jnShXKPaiDGEiFkhkMA/6r?=
 =?us-ascii?Q?iTWVBhmHzU2xtNuKpfeeSvQITM/CUbxi1YTf9nfc+DYkqBUIKgFvl1qdptVI?=
 =?us-ascii?Q?0q1JYxwEhx9r6rNHwo3Uq1wtkG7pbVD4Sf8zyydWKj08AVxY54SB+k4Uf5bt?=
 =?us-ascii?Q?Aa263kPZiZypLD5ZhB588LViR0nLRPlFVH101qXXTAeRId/YkWvyk1KURqAh?=
 =?us-ascii?Q?4p42V5vmEK4I7n2efGOsDnUnIqMosOq5Xc7/0+ZdyttHoh74NPG3HfWpTK3i?=
 =?us-ascii?Q?/AC8im/5OmrE6VJ6OmmtIuYyChGvjcYcz2gWXw+/O8wDh0g/kmWhmMLYj78e?=
 =?us-ascii?Q?NoQ+Tk+J9Uml7z/mcMlT/9hoWtRR20dv4G9lVv+KGpYLhJ/KoaJ2yx0NcJ07?=
 =?us-ascii?Q?MB+thSqgsWzBTCAe72mq2OMiRlTj+mRsTI69OfaFu9cz8MOoGd7sHB1LY1nG?=
 =?us-ascii?Q?C1oSlEMpMaTWDvSLW7hUIKFkLZ+9P+ff4tQACFccqYpiRH+Uoii0MtubmEtZ?=
 =?us-ascii?Q?ls5QU/t95p40+Ykuf3mWjxhQk4OPcu9EYSGLWgCZuIQ4fsJZxHHyZqWUfj4N?=
 =?us-ascii?Q?R46CVJBNIY+7/o9SJf4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d58c51-388d-4253-9eb5-08db971fc46d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 08:24:49.8026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tpO/YW/0RheahC+IqqMQoq1dDdKYgBzQBQNsTz4nHYTa990RxFVejWN/v520ikbbMOGjWvhkjC8qbn3oKXvYcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8541
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v2] clk: imx: composite-8m: fix clock pauses when set_rat=
e
> would be a no-op
>=20
> Reconfiguring the clock divider to the exact same value is observed on an
> i.MX8MN to often cause a longer than usual clock pause, probably because
> the divider restarts counting whenever the register is rewritten.
>=20
> This issue doesn't show up normally, because the clock framework will tak=
e
> care to not call set_rate when the clock rate is the same.
> However, when we reconfigure an upstream clock, the common code will
> call set_rate with the newly calculated rate on all children, e.g.:
>=20
>   - sai5 is running normally and divides Audio PLL out by 16.
>   - Audio PLL rate is increased by 32Hz (glitch-free kdiv change)
>   - rates for children are recalculated and rates are set recursively
>   - imx8m_clk_composite_divider_set_rate(sai5) is called with
>     32/16 =3D 2Hz more
>   - imx8m_clk_composite_divider_set_rate computes same divider as before
>   - divider register is written, so it restarts counting from zero and
>     MCLK is briefly paused, so instead of e.g. 40ns, MCLK is low for 120n=
s.
>=20
> Some external clock consumers can be upset by such unexpected clock
> pauses, so let's make sure we only rewrite the divider value when the val=
ue
> to be written is actually different.
>=20
> Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

Regards,
Peng.
