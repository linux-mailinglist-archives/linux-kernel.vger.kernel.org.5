Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF1A7AFA3C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjI0FpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjI0Fow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:44:52 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2077.outbound.protection.outlook.com [40.107.15.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB605B93;
        Tue, 26 Sep 2023 19:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH/dA+b0h5bU0R88+FWCibuqx5G3CWlZpzskyEc7btYdAQXEvaapBsRdpmGy9wgLK/PZXNhT4VG7l0EzjtbmjS6vbl9aZBfkH5+ENQ+2WF6iFFtXUODqgTGyYvztmoVWOyNlDQaHDFSQGUHTN/BK3k+5FdH3yjNnhNUfOchsygVHj7EYg9x3Z9ArpQDErziwENNb95R+C6cIzPOXOLmWniZVIxmzVpUbCeJQyaPxGDRJD6cX36lwqSihufyvFBd6Xw2B0IWND4AIsDC7305PO70jHTgMRaF4+F21XtTEzVyq1zJI8mup9PCb859OMlBCB3Chl3ccs8MLSr0vnZrBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCXEjHMVvxUsxQoyjNQ6Nfp1JyoYyiVMAgKdWJ5mKZE=;
 b=McSFXtesJOFnFeB+IrCUuGMdtdLmFZ5Zv49ug2p4NYYTZdR33iKXC14V5w21ZdrDEfXoq1idz1RU4O8QpF9QFgGpV5x7VYe86Il/UU298XxiwbXbKSIfMwFvzle9DJQ7gWhsyldvsltPcKW3PUDLzdwF+4xD5QXINNVVychbcPVN479ahw0lFJhyY/4PpVD7slnM3sq+74OEuf1KZ7E0YRG6sSmZI32t8pEyw7wfoJtqSviAoGxycsWdDgAwWZ6L3+nNzm47FBOYUSOIvGbEYondhMDqz/yqW1OzGCdSeTlpw8VddLdWn8v90iT1N2TJduvMhidY+TX8b+vc0PJUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCXEjHMVvxUsxQoyjNQ6Nfp1JyoYyiVMAgKdWJ5mKZE=;
 b=UmCH+WwkC1TgxaGynYf0QWJvHE4oHDloR/ZO+7GEpL2U9OT+fE1MTa2u/VSG6izRYuQWkc6mQ0uAf318yuCKD87qFJAIZf4bMBb13E3waQ2js3GQ87cKOlJvwlPy8ttDtJlIf/TTfP2YCp+c1qu19d9Z4G7Y3DigL3XQWVVVT/U=
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR04MB7069.eurprd04.prod.outlook.com (2603:10a6:800:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 02:06:53 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::1ace:f566:c57a:7d4b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::1ace:f566:c57a:7d4b%3]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 02:06:52 +0000
From:   Ying Liu <victor.liu@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: bus: fsl,imx8qxp-pixel-link-msi-bus: Drop
 child 'reg' property
Thread-Topic: [PATCH] dt-bindings: bus: fsl,imx8qxp-pixel-link-msi-bus: Drop
 child 'reg' property
Thread-Index: AQHZ7/cBQVcqopDbVkWVCXROcm2oVbAt43BA
Date:   Wed, 27 Sep 2023 02:06:52 +0000
Message-ID: <AM7PR04MB704668EE766F6569EA73472798C2A@AM7PR04MB7046.eurprd04.prod.outlook.com>
References: <20230925212639.1975002-1-robh@kernel.org>
In-Reply-To: <20230925212639.1975002-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB7046:EE_|VI1PR04MB7069:EE_
x-ms-office365-filtering-correlation-id: f0fa5776-66df-4859-2ef4-08dbbefe6ac2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BCCiA+VsudqDlLpN6EFfJWqNmQllIXTMDDk9Ju9PZLu8lddTO3WPmnSbmdpr/woD8l5xzHDZ5AopzRYbfT+nhn/oj/2zI6pEFe+IvMEfILtnjedzTGl7AgcZWv/JbYAL+X6Bq34u2Np2yc8fbEHaYOSFMo86bBmqyNS9oEt9s9J4IcFvSsXb10mpd/SUN9cE1LwLMhrE43LTkzvfuKCMYLIuA+zbEfhZxiEcdEbAyWSfGGw/ZLL4EAOMoTTCAX2+xCPSIW1LfEJiFUN22ZHH8yQBHEx58me4iOPA3rPsbxg2lGjGz7pKBVZ2zWuWqQAHZOMGeSKMT3dLTI2EIFn4wWd80uzaJqdVkKYGRVkMpKVogJ6/oHr42gkTrMtekZCdOZRR8gmeIf1jb+PZyt8Tn4xZ/8Oc/ctD1NNmvzB0tjLeVhGo9wwP654Eh7AK9LtfmbljDu8pF77IhPrkUlYSsYxii/K/aruRCsGS45NMW/zH8QGBzaGwUzHbKncLldVHS5eCx2cWf5AEg7sPlNjt1D59Sg6xKZIet2DEOiN8Z2IyvFTHod9fRUjnA34kU36gdfo+g06ZOXypUkoqkf6+IXbkvy0GDQd2JugIzaEQ2YLxFFFcdhqiJwp8Pult1DCz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(4744005)(7416002)(66446008)(9686003)(6636002)(76116006)(64756008)(316002)(66946007)(2906002)(66476007)(54906003)(66556008)(110136005)(41300700001)(52536014)(8676002)(4326008)(8936002)(478600001)(71200400001)(5660300002)(38100700002)(55016003)(33656002)(38070700005)(7696005)(53546011)(6506007)(122000001)(83380400001)(26005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YdPkAxR6qz0COigE4pXbY5NCcuTjvigYa29IszMKFIyLdGJxkOoarOLnYJ2v?=
 =?us-ascii?Q?iQ0MOv9mUZIv63Gvxs6xxq2gpnufwroixqQfRtaRue7RxPL7R+1lIu0/zJMP?=
 =?us-ascii?Q?BZme8v92vqW+5XuGs2xHmOu6mbTwV2xPuGQCMr4gufAjQuR6mTo8gZ3sK8Yd?=
 =?us-ascii?Q?ZFGsL6svoJFyomAXRhM59YaJvHlGwDJ6dBG7ciMPuHau0YMn8p847npa31lY?=
 =?us-ascii?Q?LJAY25twRjIQkYK8Iqy7hvQnUn+aR5TyPgPKmxtSTRmjW9NJzr9ebRCqbG7H?=
 =?us-ascii?Q?0Mp5N2aAqbQl1jQN8Bd/KgVqDBg/3tuwihh2HbchlvT7xVssgmS6PPPTR/d7?=
 =?us-ascii?Q?iR2/pq7gtp23rNIaF6RTyj/G2BNbx1ocwZIohCEbETL+Z0J19Ry+3WKidCJZ?=
 =?us-ascii?Q?k3DPvV1y0NosCiYu9RVcBh8bDZTlePjYFEIxO0rRg5e3JLuMoMdq7hfXitpp?=
 =?us-ascii?Q?WMqnGrLg7Uxth99VH0szk2LvxfHYShxPOQX6e7bgCfE8aihnrqbk+c0NoIhe?=
 =?us-ascii?Q?kaVQonLWp4bQs8lp9Ew4T+u6qSF5+FfTL075Hdoyr8qxlsiVnYx9kO5fSZC0?=
 =?us-ascii?Q?q++LooZNTf5PcMqMh53/tUD2c/VPpY3dC0MrM40FEpTxrUTCavQHctg9FoUq?=
 =?us-ascii?Q?fOMCylJ+euAyBiowZs6TsEgvI0YBJ3rJOYCEJUVdu5cvrQTjenmEnyNYaSse?=
 =?us-ascii?Q?8GJ6KptnQrAM+spTVKHbo/pGFtS1OCA9IGdjdB0WvhT6u8dwpO43qrAkMLfD?=
 =?us-ascii?Q?BVXAHQQYq9a8u3gCzTrtRecp+QD1YjkL7bHMt/+7kM7gBIe+bwq7Ef2G5taL?=
 =?us-ascii?Q?ld0wLyMkRS8rzqpe4w8mGcWMWHZ8y8g1VC/NfhUrib3Kj0+NqrltLR0fsC/Z?=
 =?us-ascii?Q?MmI5F0SZF1YrzTaUy/vYXiT94V2SUqcCK6G83ErAygHtMJFMYQzQYlF+YuSF?=
 =?us-ascii?Q?jWm4imzPA/tnAqHaHXxFZcI1BuvfGuKd7OoQ7IiiYgloU/7+Gbbp6Pp9XJGD?=
 =?us-ascii?Q?rE+3XGbow+sKxc7Hl8wva9GsNPmODoA2iX9Sgn+pNSGzJN/rG8RUZ65A+Grb?=
 =?us-ascii?Q?V7UfJ4fMWafPcDxvF+uCcWuR3h6D5Pu7vl69Zv5TmFUI/AP3nfBzZPqyVAgZ?=
 =?us-ascii?Q?v7k4Dx/iuaHYbSnt9ObJswmqPqA+pwDTuHIla95gCvz45KMfOFCbEdfw28zF?=
 =?us-ascii?Q?fu4PucbCEQr+ZrhFNf1BQY9hD+R1/QMdH8PFnfx4xjr5wC+uJ5TjmOjuu6sY?=
 =?us-ascii?Q?fNPiovmEgnrErPG8QnFtoOw2AWP5UgTTjoOZizFVqRfjbpj40oNXkKMPQbtc?=
 =?us-ascii?Q?2qQ8YB27Bf7HbCE1nA0mWU5zqOeU04gtvJQuWUuNiLmx5VqHlpfa6A+vaBVp?=
 =?us-ascii?Q?y+KbYb0RehCdYUre2TWLEO1Low2woEgJfKfpgkvc6AFS/IFHybmknRGJkibL?=
 =?us-ascii?Q?q0ZAFwZCVj0S5J4OQ0hztBCFkvkhsv3yUHzlJpAQlZ//4gxCgZeCAZWZg10y?=
 =?us-ascii?Q?uBiCDW2iqjBd09sXua+6vuudS395HqWsBu5ePTylFiwWy7JkKFKRTqVaZqPS?=
 =?us-ascii?Q?UX5rGXMpVD0xuqKZ0gQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fa5776-66df-4859-2ef4-08dbbefe6ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 02:06:52.4660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrwKJA1EvYEFKGQbYAbQEVUtHlF8O4YhqWKe22WIQ/GTd0+JCgCWuwMPtAlvS/ZF/EdUvlaB+su7w2JmFPyTtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 26, 2023 5:27 AM, Rob Herring <robh@kernel.org> wrote=
:
> A bus schema based on simple-pm-bus shouldn't define how may 'reg'
> entries
> a child device has. That is a property of the device. Drop the 'reg' entr=
y.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml           | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Liu Ying <victor.liu@nxp.com>

