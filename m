Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F3276D7D7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjHBTdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjHBTdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:33:41 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED42198B;
        Wed,  2 Aug 2023 12:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxXRcyW8qK0QKkuyX/IM65nCt0v2PE47hFhZ3PvUvMNCmTW/AjjraDfcx9AvKHHB5/YO/OEPAhqJ0H20J88H8BlMlLHg8veWmDXIR1cJL4HMp74GSaPsVqE0Kj7a8yRvfwY0SOksjlIb0NJc5MUkOsfBiZzKZEvQU7JUhUPLNXWO+WfmUxEzIrIbcbTRVBUfXNWzKXKRJj8cyS60AFhghZqxscrtlS21ysv/lf1oVW6SZ0pnCjhHNa5Sjkuoko0RPfppTDrRZtOGUQUWRBW4Awjki/QWsHHzRbAfaDxEILZcaHMjSxhcMTgpgrhrl6ocSAyxRV+WaaRfEib+MA6UjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95EC9okagLe5v+gNOZNiVLm2A6d2001g8HKDTdXcV/c=;
 b=POsxWQHpIzqcQVIltYRwQ6McaDceavyYbVJkd1sGDHIBmfFJlewtT26581k3R0DI/vTikcNQD/cf435m3i0mz+v2Xy8q5vSwLUM035Yk54QYjeXlhv2bQ/5W5vUHqVwgH03MSHm1pVNo6oINtFlA2XKp/GOhZazG/xIKKz56DR99UuOSHEJVJ8Yy17IExfwO/He6631xy2EguBcBVXFjT/F3v1LpwIolBg/tIv25l/I2pMBxarXU5kuxbs0wRRZtEYtRDfOX5PwVGMi4GXTngf7dTd0k8aqEJ8HnFpO+gW3D7cWneZxtNoHnJI8gnR1VJZ0I2bF74kQ34+H3/MPi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95EC9okagLe5v+gNOZNiVLm2A6d2001g8HKDTdXcV/c=;
 b=H6QZk+szqY90dBE9I/y5+xivTsenOU0c9L/oOhtdKN8KD4nToEfX5dRhgmLpv/BGV3xz/1A2ejeRUbMfL2Txbd+Kfi7GLgEbYTfHuCxtdbflr1TVKG/NB85J9oHGmRsiFOYHSyGKOzjUdOHD8J6SqynAgHCQfq+2uplWURn4i1Y=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAXPR04MB9327.eurprd04.prod.outlook.com (2603:10a6:102:2b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 19:33:37 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 19:33:37 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jose Abreu <joabreu@synopsys.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Simon Horman <simon.horman@corigine.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wong Vee Khee <veekhee@apple.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v3 net 1/2] net: stmmac: add new mode parameter
 for fix_mac_speed
Thread-Topic: [EXT] Re: [PATCH v3 net 1/2] net: stmmac: add new mode parameter
 for fix_mac_speed
Thread-Index: AQHZw8rncXkT+tBv7kuTZDED3nHZB6/U/amAgADJUBCAABaEAIABiuKA
Date:   Wed, 2 Aug 2023 19:33:36 +0000
Message-ID: <PAXPR04MB9185058330F81CA73EBFD944890BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230731161929.2341584-1-shenwei.wang@nxp.com>
        <20230731161929.2341584-2-shenwei.wang@nxp.com>
        <20230801-portside-prepaid-513f1f39f245-mkl@pengutronix.de>
        <AS8PR04MB9176FC45B9663B5BF964F58A890AA@AS8PR04MB9176.eurprd04.prod.outlook.com>
 <20230801125828.209c5e88@kernel.org>
In-Reply-To: <20230801125828.209c5e88@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|PAXPR04MB9327:EE_
x-ms-office365-filtering-correlation-id: 653b02aa-24f1-43e7-9ccc-08db938f5dff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xRxAMtncFDmUB9BKrvo+KSD3ft8t/qA9rfvziVZ8YGz0w1UPiqrulhTdDS/9x+IqwvWibLKqPjgC/XWV9z2lsGIDHMiW1VYaBIp8kZqdKkdhNJjE7HHokt02NeF+pHCCqFxcl5GDuoatmU3Tk5O6qhknqfMR/0cRCDufiRbj5EM1/m+4g/gbZssIjCOhlx8KkzQv+h6+Dgu5en3bOL7jChEKfbDRPe64ljQMkZmEaiTqROuxw9j87x2NdsHYmkwcDBpjgk07R5sB/r9VggIYNAZDxliSLKct+4Cs8JgxW5mM5zwVOLHpqlzya9Me0H0LksVKqoCmtG/JAOCK69rHbB1rAnADWVKurtfARyTH7cbhsIlT/3Q7W5kW8BoJPurMrDfd5d0aLeHf5rxTYuQJawPpRLFvodfWlJ4XdSw7R0idfTc98pKKgFB4VsA1tYj3J0tHpJ8ldsc4tva8FD7lhoZ52mmP8nXezzAFN0AZVk/PsqJmHAPeLZvoYe0jhPBwRHo6e9FgTgXUnKjmpzLEkdsmNXtfbVRXfB266jF7bM9MKrWPU6WFeOkbA7uuANEdEj+kLECAkJw5BoPkOga2fUavIDe0lgVho9cWeAICJaDBNk2oLic34CtW5qRjvvao
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(54906003)(71200400001)(8676002)(8936002)(7696005)(478600001)(76116006)(45080400002)(64756008)(6916009)(66476007)(316002)(66446008)(66946007)(66556008)(4326008)(83380400001)(9686003)(38100700002)(122000001)(41300700001)(55016003)(44832011)(7406005)(7416002)(55236004)(26005)(6506007)(5660300002)(53546011)(86362001)(2906002)(38070700005)(52536014)(186003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qjju14odn7ndoelrr+mgirvG02gqy+9s7hr9Wyon3qhApEmu+W8uNinR5U8U?=
 =?us-ascii?Q?gCO2UkDz1Idlu+e2OMBd+DNKlMsj5DpAxVsnZ4ZJkkux1QuAizj5qruxBZ1B?=
 =?us-ascii?Q?Y93IKPf9t+/WZQj0KJCMJkvbo3ARTUmII5zoKhpgaJNKc3PakhddzYKq4oH5?=
 =?us-ascii?Q?uvxsOP2wnRDkfD9aqjAa/D/wWfUjr3SADD86vyD5Y5O+U5ll4BCW+isEcf9x?=
 =?us-ascii?Q?66rmpy81H/S5b9qmZYYh+CBc/x4B3OQ2BvH5A215i8VegB5BQlEkfrJuDwja?=
 =?us-ascii?Q?xk5g8+/+Kf/piW7olv7cLo2EA72C95LvccubzmoClXCjFjYqoNzxiEqSFy+b?=
 =?us-ascii?Q?W0ozChPaVGJ+6JHXXIdGGBo6iuDS7OQ2MwAaL4YNHVm/8yGA9pIFGHFLy7TU?=
 =?us-ascii?Q?4GjRGEymBv8H+YdwgqL4xsZEhyPBg0REWPeY9TAHdD4IbbnQIDoZA8NYThlk?=
 =?us-ascii?Q?5xLXTCLfHF328laVTKO4esMd4ZX30mqu2gVF7GXQ4KxrhK5BVSs1GQgQlOET?=
 =?us-ascii?Q?xpXf2QKECiz9GNV70uTmMoAsNvLD1r+MFsLlZo4Evpy3sS2E55yBIusKWX0n?=
 =?us-ascii?Q?ymfcWTvXwvF2tfToYRhTEa+dXOzcpVqkIHOgjypqGT/25dg56WSw7h3a6h8P?=
 =?us-ascii?Q?9VwYHdFfnx/N5QlU0R7xR6hHTX8H0XYUwJyVXc/ooMvFq+5IT/tHIda20TJG?=
 =?us-ascii?Q?zg6E8RGMQldLzcGEsoUm23Wztc7tWe6hCg1yZ9hUTYy9jBt9D8YtmP4XUAnf?=
 =?us-ascii?Q?HuazWpNU1tG3e/JVwzgqy13/xDnBH6U7wPEmJ6GooKC0H6laS4RSPYEUCfmA?=
 =?us-ascii?Q?kSHIBaYb8Zl0K70nMXmJCZ8HNg1Z5HduaDLercWl6rQcWkcLPdvOBrUl4VAc?=
 =?us-ascii?Q?ZgO5dE6lGZRzeS41KJkFfumLCd4nU4WfVIs75lEZnMxksh3H+fryPwc/V/ZN?=
 =?us-ascii?Q?h/gW+VNXLdv3UBUouf4G9vC84CY5kMjTaS5CbYfjYzbZRoKpNRj1L33UErwQ?=
 =?us-ascii?Q?AQ9F1+0qsltL5xclu7rC60feNEwS6SN2zWONPgk3UCJmSgwhK+Er5tGWRgIw?=
 =?us-ascii?Q?/tjQyqIxL/C4CwwklpbhxgA42U12ttnCSjv6ndrxrnTcEyPCk+J4HqoDDpZL?=
 =?us-ascii?Q?7FgeUmdejvopQsYthFnU5VYqLSu/x4K/5A4IU/gYRt5ln8rv304TgMItOg1o?=
 =?us-ascii?Q?7otmWXoHLE5bGeH02OH+zHlDmelwJBLjfWOBpsyJyQInrNOAxVU96fP+n/vH?=
 =?us-ascii?Q?pX8CP7BVBDS6Z4S4djUFr60HhS+fktzB4Ndm56N/Ep8e6kR0xNVEBZYrXk74?=
 =?us-ascii?Q?8BEpbMBL9PGzX0VmejRcQbhwX6Fm82wXOL4iYHsJgyZIc728rrdxDXVnrLsk?=
 =?us-ascii?Q?gOrgB4VLot2oz8IxamhFuVjWvI5gedL//xcbIEsA1lj2MvjD+OcgjeBlEFVs?=
 =?us-ascii?Q?mwtCgGxSmmxiy78JWNgf6gAJl4ISenzVXQbAm8sGndkng7NLErAjwN+V/n0/?=
 =?us-ascii?Q?kOVVvZYRpUS4JOVbMdrGS3K7iaAeaw3/6J04nCPGrHA3frUlZJll30idF/sO?=
 =?us-ascii?Q?I6gw1uaq5xrqXuIQPk+laYZLBBG4udoXUpGbn481?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653b02aa-24f1-43e7-9ccc-08db938f5dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 19:33:36.9357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6CWnXA5E9cNs/ZiGT3cjTIu7FNPd7iBE9ecq/GRmkWsq3lGBSuSkafFtVpihla4Mb3McDegMgyOD8L+aYBwcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9327
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, August 1, 2023 2:58 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> > > Subject: [EXT] Re: [PATCH v3 net 1/2] net: stmmac: add new mode
> > > parameter for fix_mac_speed
>=20
> Why is this quote included? Please get a sane email client.
>=20

I have no idea. We are using Office Outlook.

Regards,
Shenwei

> > > On 31.07.2023 11:19:28, Shenwei Wang wrote:
> > > > A mode parameter has been added to the callback function of
> > > > fix_mac_speed to indicate the physical layer type.
> > > >
> > > > The mode can be one the following:
> > > >   MLO_AN_PHY      - Conventional PHY
> > > >   MLO_AN_FIXED    - Fixed-link mode
> > > >   MLO_AN_INBAND   - In-band protocol
> > > >
> > > > Also use short version of 'uint' to replace the 'unsigned int' in
> > > > the function definitions.
> > >
> > > There are not many users of 'uint' in the kernel and it's not used
> > > in the stmmac driver so far. From my point of view I would not
> > > introduce it and stick to the standard 'unsigned int'.
> >
> > Using 'uint' makes the code look cleaner because adding one extra
> > parameter may cause some function declarations to span multiple lines.
> > This change keeps function declarations compact on a single line.
>=20
> Marc is right. Just do it.
