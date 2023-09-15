Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419587A16B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjIOHAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjIOHAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:00:21 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E142724;
        Fri, 15 Sep 2023 00:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdibCwHcxDCNiYqGW6JMTNWi3UMX7FgbQoY0F7PfaY6ECn4jLdQ1eMuKX3wQXCD74hzeEQ7+j5sQNgdxsJjBx9/x7seFlrprNSlljOjtQoeuPCXrqnPFjwCaJudxisih3ksARrBm6NXy/sU6QwLrHlLicAAXuRcwz5ygr8b++mgQQSQJwgVnWt4G40WdKFb72vN4KvFmT7HPuuflsNGMS/+jujdt/3FWXQHXfPF/VF60n7pfyeOwxE65kkjg4e0wKuvd1QMZ/hxoHe4j/8VPvTvu4NW+e7o29xyNdPLgRVxlXt8geqB6ArZHA4/pfLJGT7+/bAEE+JjGmDkjpRE6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2bGK+GpyK23ZVfQty9JBxtY83oNsyypQWT6MzpSz1Y=;
 b=BBowJvrHlrFBP5BD+z4L5q0/e/tBEiTwD21zxVVsf8LEST4CyCQsfxPAD03nvbG9Poie9SJOaKVnvC5DUW+t6vaoLc4RSQJd9ebvNEpyPfD46+7IoWEUOu4jJjR9LYcgZvPY+cBKWzjkHvvNx4sqvo7a/ELYqg3h8Ewj1vXJXVKclL9wM5i/esAA5I6KrKqLJXXL/KhhrBF9FdnPOLoAJN7O6HasJXumlW1cxgBmrFdRkJPCuW1W+tlH0RthItU4KA0ylQMGE5zilQo91Ft2I6LIlLM2o2BeViO0H9ADuqESKSVMoHDzBxfVUxriqLimT86ANe9Fjfz86z8nHUKOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2bGK+GpyK23ZVfQty9JBxtY83oNsyypQWT6MzpSz1Y=;
 b=dKlR1NEUe/lNEMjPPc2zsFsO01VTZFKXDtnSst03q2k+Qqg4K+zK66gpEAMvfq9tbJE4nXNEemf0IwJ3PIuT4REtS3PdqHBWI7jX5O56ReNbZ4I12dOlPRKWVAy7zSJzn+7Nt7Tp2IkL5gkWoj8TGdLhIGxESQJbVTD7NGv24ZQ=
Received: from PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14)
 by AS5PR04MB9941.eurprd04.prod.outlook.com (2603:10a6:20b:67c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 07:00:04 +0000
Received: from PA4PR04MB9248.eurprd04.prod.outlook.com
 ([fe80::a2fa:4a75:c0de:1b30]) by PA4PR04MB9248.eurprd04.prod.outlook.com
 ([fe80::a2fa:4a75:c0de:1b30%4]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 07:00:04 +0000
From:   "S.J. Wang" <shengjiu.wang@nxp.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH v2 0/5] clk: imx: imx8: Fix some error handling paths
Thread-Topic: [PATCH v2 0/5] clk: imx: imx8: Fix some error handling paths
Thread-Index: AQHZ56JABBqNp29H4E67KfuIoELhrQ==
Date:   Fri, 15 Sep 2023 07:00:04 +0000
Message-ID: <PA4PR04MB92486B510B8E8F8309F484EDE3F6A@PA4PR04MB9248.eurprd04.prod.outlook.com>
References: <cover.1694722339.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1694722339.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9248:EE_|AS5PR04MB9941:EE_
x-ms-office365-filtering-correlation-id: 2669547a-d17b-4d7c-8e5d-08dbb5b96369
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AVdaA3Qu8Jy5lXAuW2XyVXSlhdKHvHWOxu79FFRASD5AdBBK3S38JVqabDKKXkTkN6pbQ27UdmmHAOcBdIupzBlQjurmUXuFFrDj0XnAlKHYoQrtPGaNFKyopBwHvRHnvnd1cp/qkK2PBEycTyd/VaFptp6ON8vItSVUcQleAbQhQ4Wtv2n8Bd5MAnUCm8wQtqI9kWyefW9wtSM/r2NlhOtCQuCadLIusDqPJbxNQmFntHBwj0u8n+RN+jEz0NZY1uHNU/nS2lwpw0ifuQURhSfSZaT88GCrmB6PHzPa0lXgX75Z4yF4B0PZoHgmyJpgcv3Kg7zkDLVA3CcMM+D2YXOlOZT+gyNdzMM5Xb2Khf+VCTffasJ9a3m1c2MpLL9AgGNcEi77mU0mG5V+nKGeKEYu0fWMN4X62du0x5nT4tu/spndlIfy5zv+Tg74tE+110VDNZRX2mUG2vRbbYOF2FZnb/+W7ZLqNUJGVNmViOQUNno3uLL8ZjmILQqI9e+rJg/UK/RBPVic9SvDkqglN1Ewu3vM9xB7tmCgrtyzQ7NPLFnY8B+rWn3yNFlMVG80EyAd/gSJUGhaJgm4DKQnWti17jE4sUOufPyqytmC1sgdN9oxU3gVOahRO9X76yTE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9248.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(83380400001)(122000001)(921005)(966005)(478600001)(38070700005)(38100700002)(45080400002)(6506007)(86362001)(26005)(9686003)(55016003)(7696005)(71200400001)(2906002)(52536014)(4326008)(8936002)(5660300002)(8676002)(7416002)(33656002)(66946007)(66556008)(66446008)(64756008)(54906003)(66476007)(110136005)(76116006)(41300700001)(316002)(6636002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D/NdsVlrNZleem6i0bxllKWJqIYazMyO1sZlkG1HTfRbIJtiJcOF6T9unlPR?=
 =?us-ascii?Q?2AeiH/gPvCWzmkHv7Ksn3a5QgsGPERtAc9nuMkDvVD3ilAvN8aYAalVCGau5?=
 =?us-ascii?Q?VwZ0/Q73MJYEvAerPOjZvR2JK1tJBM5wjxTTX5/GV1ZJddwug3+X8i3F4dlw?=
 =?us-ascii?Q?D1b3pGJuMyZyjwLHWHIif4KFNQmY/ks9ftlH0ALt3NRTmVXwGA1ALhp/Xsug?=
 =?us-ascii?Q?rfYE6fTxIIF+KSRkueTXBfuhTpU97l/Rd2+XqnHATDOCs4Ms6TCvqUJ/B/Pz?=
 =?us-ascii?Q?tLt+27uhLST3mlreX2znxXqBNNcfLGa6lAp9DjAJZWNUJUJFXc9q1mHvbYL/?=
 =?us-ascii?Q?RCrhoWDFEqGR+9LFBTyi7TkzSIeI80HZ4OCQjy2YRUuffhVuei7xmSSPKZXQ?=
 =?us-ascii?Q?S6W8EWAjKSodbyMZR0+2Mo4xab+IJ7b/pZey8a2UdEKZs+e8CP6M0EDRj5FJ?=
 =?us-ascii?Q?r0jhPH0EfSkWk5KJdunBJdUCL4ajKQwK5OGNTsQghbGE5WNZ5i8cIuafnSfb?=
 =?us-ascii?Q?mSax9B5x1CTAYp1BQAua5rLBHkGggv1qMp0bRgUUufWEE3kZC1jfe4vlSD5e?=
 =?us-ascii?Q?R2Vf450r+NsmX4dzdBn8qITJXwJ9HbnAgJR1zLsDdgeHgLMTjTcpEtqakgDM?=
 =?us-ascii?Q?GJWsxelm/zUZUt2o40l0smASGFGjD7imNNv/h4VbyYkZ4KmRCGno6f/84lr9?=
 =?us-ascii?Q?Ju4sfUFC7ua1afy3MpcNciYwcylBpGtb7U7UTFR1jHUEKEPHeil3UP7v4ovc?=
 =?us-ascii?Q?oQ0GCRamTr676OJb4ePc9JMQcfyxnGQg15GX+31eyQGZFYSon5ZZZO7u+2RD?=
 =?us-ascii?Q?k+KlVZ8gyNuVCNJ5fvUWRtNlWJixV6JplPskZoIkdBQCzPbUGnQ/iK7ZswBn?=
 =?us-ascii?Q?/wi0HERM9eLL0Vt94rvpy/iERf5a9EvIHEwz3O0WIj1l2wIOGNv71COsZBcT?=
 =?us-ascii?Q?bPtfmDPSuaqdDDfyATadybECCk1uNQLILlmM9ZQjOtxVE4EAkpmCQ3jZbVuz?=
 =?us-ascii?Q?2QjnBlMAfZrpXqgOf4Cr1DiFb9WLXaxfWUTiEwD7bwjvNpxxQE+30UQUK0gu?=
 =?us-ascii?Q?QVRYtxKkcafwXfpn97tUdBLn+tHk3yuH1F9a7eQI7rCx6RlxnjKddgJI2zyo?=
 =?us-ascii?Q?uM7mCBnWuM+S9F8BWeTnE+8DTIO/KIkuECxDdipIcsppR90Axua+94XaSfWi?=
 =?us-ascii?Q?fW/E1CvszeluuKUUojAfurvBWxd6HpDsG9i9XgkkXltFkb2OwqINTHWm5tB2?=
 =?us-ascii?Q?+PPVq/JEOkj0nX8ZE3SOIOboK5ZJpdXH5yldMzQKBdxjM0P//GOnP4RTP5ZM?=
 =?us-ascii?Q?MpS0z5SwcH6MzrvUWG7fAqUwDoBEgek3zK/ZkIdg+EFNAfJcgzxvnHAxQ5kq?=
 =?us-ascii?Q?4cnSWz5RfwzGLt6J0+fCuNgDT8QVBzw+8q6ZDIocZUNJdaRegIJsqAeOMZ3W?=
 =?us-ascii?Q?P2q3KYItj/gl+w0KjgvDWueBW7fWtwY9fMiJ290HcIByX3veROkvElBiYjqo?=
 =?us-ascii?Q?aOow7+sEqvo7DyTEK61H4+/5RgYRVTedaiWhcJ0NdGpMsxgN9Td4UuHRHf1c?=
 =?us-ascii?Q?Jh2v/9zmzj14VZN/ssQnwOA5gyfy9MdejZ6q0za2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9248.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2669547a-d17b-4d7c-8e5d-08dbb5b96369
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 07:00:04.4410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gNkZis3bwKj7xCsBgRvYeJbsJ84Lcai5GnigLXVbVGjIqEPM7AYCup3yJ4fi4mF+slw+pD/7pI5sHNK18AAp8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9941
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
> This serie fix some error handling paths. It is split in different patche=
s to ease
> review because the issues are unrelated and the proposed fixes are maybe
> wrong (I don't have the hardware to test anything)
>
> Some of v1 patches had been incorrectly hand modified. There was a extra =
')'
> in patch 3 and 4 that prevented the merge.
>
> This v2 is a cleanly regenarated serie, compile tested at each step. This=
 time,
> git format-patch did all the work and the patches have NOT been hand
> modified afterwards.
>
>
> Some log messages have also been slightly tweaked.
> R-b tags have been added.


Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Tested-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Best regards
Wang Shengjiu
>
> v1:
> https://lore.k/
> ernel.org%2Fall%2Fcover.1693126687.git.christophe.jaillet%40wanadoo.fr%2
> F&data=3D05%7C01%7Cshengjiu.wang%40nxp.com%7C5134bf2d7d924e4ca9ae
> 08dbb561881c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6383
> 03202724496811%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&s
> data=3Df0SvmM0H1Ki%2Bp3Qqsya8u87CbVowC4bXym2i%2FSBCgJc%3D&reser
> ved=3D0
>
> Christophe JAILLET (5):
>   clk: imx: imx8: Fix an error handling path in
>     clk_imx_acm_attach_pm_domains()
>   clk: imx: imx8: Fix an error handling path if
>     devm_clk_hw_register_mux_parent_data_table() fails
>   clk: imx: imx8: Fix an error handling path in imx8_acm_clk_probe()
>   clk: imx: imx8: Add a message in case of
>     devm_clk_hw_register_mux_parent_data_table() error
>   clk: imx: imx8: Simplify clk_imx_acm_detach_pm_domains()
>
>  drivers/clk/imx/clk-imx8-acm.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> --
> 2.34.1

