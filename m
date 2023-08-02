Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6208976D331
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjHBQAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbjHBQAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:00:40 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB139D9;
        Wed,  2 Aug 2023 09:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gj/E7rYa0eLIQP4qoGwlgL7qu70D9O1B02xb/Jqw9lU+LKpL9KmvO9e7NlKyyirhMBmVMvdYz6n1sVL/MK5aRT8TG73CayV0byyPe0eEIVg0whFVYibvmYUFAmapjw2SpaBNe0WfWJYII/xPl73xG52+Xv9D+saaMu3NO010/ulzY0ep/MU+5U3B8o6ndDcyori7tR01tkfA7BAOQHlHvJkAv0vfs1xEX4jktlGZO6sIejqQB15lBTti/c203KXH+LSog9XmiWcTiXvCxV9zPbU7gBOtzLm2Nsc3xT1OJsgAUzSgu9GvauMPM6eJKtN6LsdbkKXJKDyYiar+OG82/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoPz25+b4diK+xk958Pkw1X6F2UnVtPg1m5ux9RblGU=;
 b=Gjdbb4Y5wDKcbdQnL7F57uUo4aacowPiIyhjkPQgB15vaYtFjmqFUKBBrnqB4uKUyBLQ5Nc55OgSYOgeUwPQjgxosQGp55pLXjwNMPzsIF6JSqKHobGNtFZQL+WN9EO0aJ2EJLNVl1NXKb56wjCIr3vYtXgzoJKThU33UFUpGaYgYRwTPkkmyuo2rTYPPN7AzeeNjvuSlIyEiCA/e64XEjezQNmyyJblY8p7i1CfXwMngV2YClY+xu5l5sNwgQMDTfyTYPagL5cU/ort7O0ZoFIXEfTKjTzUJgkJzh4moFgdDQ4yqHeH0355AvPUO4i4LTmhRK32dwxxYg+0JlofPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoPz25+b4diK+xk958Pkw1X6F2UnVtPg1m5ux9RblGU=;
 b=oLD/6zjPp/Ow6Bl0A6sMBevE/lrVRpnCDeF7IRppRgX/rVfkEhp+sc2f26A5f0rRLFr5noVrtby32oZReDyWP+xKcybRD5eloQXAFkOFRjHhGqHS4IC9mxMDUJMVzxe8uk9h6WPEmw1zfVWiknUKx0e/Ow53ceV7XYhgiZb9UhY=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM9PR04MB8732.eurprd04.prod.outlook.com (2603:10a6:20b:43f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Wed, 2 Aug
 2023 16:00:34 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 16:00:34 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Johannes Zink <j.zink@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
CC:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Simon Horman <simon.horman@corigine.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wong Vee Khee <veekhee@apple.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Frank Li <frank.li@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3 net 2/2] net: stmmac: dwmac-imx: pause the
 TXC clock in fixed-link
Thread-Topic: [EXT] Re: [PATCH v3 net 2/2] net: stmmac: dwmac-imx: pause the
 TXC clock in fixed-link
Thread-Index: AQHZw8rr+4AkxJNLt0GANB66N1LNC6/VZScAgABIh3CAAN8TAIAAhezwgAAERICAABXLQA==
Date:   Wed, 2 Aug 2023 16:00:34 +0000
Message-ID: <PAXPR04MB9185C0C3B3E41534F555BC43890BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230731161929.2341584-1-shenwei.wang@nxp.com>
 <20230731161929.2341584-3-shenwei.wang@nxp.com>
 <bf2979c4-0b63-be53-b530-3d7385796534@pengutronix.de>
 <PAXPR04MB9185D7D3B088E4786A216044890AA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <e32c89e1-7385-105b-63c9-74f58c2253cb@pengutronix.de>
 <PAXPR04MB91851BB5D1375AF0EF3C51B7890BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <49d52a10-20cf-9c5b-ebe3-07292664fe11@pengutronix.de>
In-Reply-To: <49d52a10-20cf-9c5b-ebe3-07292664fe11@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM9PR04MB8732:EE_
x-ms-office365-filtering-correlation-id: 769e1c5d-4e4e-4aaa-a64e-08db93719b26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9MqvdHFLDtWnIEQavbZJWSOE/kMDFE9NLaBOPDc4LrceMNDuPeiMum23ZLf9tlHwOJwJME9ADDPkCAj2GxfDXNzDnlWrrQ1xsQ8X/Zy4FzcuVB7/3LR6wFmLOqBLLKZz+TQXJE+S5iL8moiftP+VtHnZjpszE9eR8Ty99n99knocvmEmoHWnJ4L8l41cjrrdOgdH0e+6ZTfYOJS9eQ2i92UM5ZJ0c83S534uQTeFroXNMJ2FY5VAt/92loVDREWrCx5CValMMNtvoJTx9PK1xS1Wg1n/1vCE4I7kVnGwMofOmEEjnNkxm63ugPFy0MilN2boDDIppAnxTxu6w/VsNZ1DPGzVp87AvwumM9S6I9TKpmuH9s1eWc8f+GiMgaednAIFFQ0/YGv0F3kS6TOW3dwsgN6Nm31+h5wNOsDKSDqJlUxKoriXiAKox5gykwTyoUgAQ1l+I6GINfMhFB4aykzZNtIxFewKNY7t7eXJDz60Ck9y8yEHS2VWMCpYkhvpkZSw90qPudcU8kPuwm0iooXECY+u6j7uiqJ2jxzL3P0+Gcn106dgUPYI7PT0a1e9mPFWQUIa5/gy9O+wGgMY2G1MuiLmLORsQDIK+9qvwiXwZkcyZPuiNngqtSImt0iX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(4326008)(41300700001)(8936002)(66946007)(5660300002)(76116006)(8676002)(52536014)(54906003)(110136005)(64756008)(478600001)(66556008)(2906002)(44832011)(316002)(7416002)(7406005)(66476007)(30864003)(45080400002)(55016003)(66446008)(7696005)(9686003)(966005)(71200400001)(186003)(38100700002)(55236004)(921005)(53546011)(6506007)(26005)(33656002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wwvyNClOf95SLK1aXI1xs+5k1KEJ1HoBQf2+RsTDjnK4c5OtWRLgts1ZQ3Wz?=
 =?us-ascii?Q?GSk50eYWzrg5SxQGM+B49I+eeM+dKbsdD3mbWCnkdp+yI4t6VChyi0KUd0F7?=
 =?us-ascii?Q?E6yna7MpyNW9JKKaeAqH+V0c5n9bqBF1m8yaG6CpMNSQt8y5a/fkoLh7Xqad?=
 =?us-ascii?Q?Y1w6SLFHWGgdTgE5tk7lmbbRkTqtu/uSfu7wWZcdZGET4JOYCuIok52FmkVm?=
 =?us-ascii?Q?COCXeKfSeRLe9A/qzrWYmgZfw5AyG77/ovUhhQ/rqJ6m4kMAhQY6vd7nABb3?=
 =?us-ascii?Q?5Qt6Pj6Y9y3fqNRiUiZVQpylAnPkveOeMLq2yxzTVALGxbm7ohzjGQz18vku?=
 =?us-ascii?Q?L7CQHLjdLtEUQ9Fj6/B1Ausmsl/izBQyikW+9LCLb64VAI9LolORGMiDiAYo?=
 =?us-ascii?Q?7ZW0xjwDYm/rpP0HAEnO6bk7SWTExzLoAvlCbUaoSobsoeste+YeL3UHddN1?=
 =?us-ascii?Q?Z6vqDKOS7B779Ykbnnew4pfT2blLlIRLMoxYpZP8Z9FWShwlS+uPSHi0KbHs?=
 =?us-ascii?Q?e2xc68XABhh6vd5qu9IDXh0OVitaKSMVEgzn+yddzf5/qKkfEOiNQfZXAtdc?=
 =?us-ascii?Q?zKQZ7UlV0WIisEIKzbvKpXO2g+aohtwSUvZM1tSmvcdqvrovP4G6arq4uIiQ?=
 =?us-ascii?Q?h7XbxorJ2aJ3AA5Al4HreTz2dl/+USy3UE0h0rBmxN3CP4VOA0pBFdUz1L/a?=
 =?us-ascii?Q?4I/Nvscxx9ax3yWR6xggYSTRrAxoa1EMWxDpE22eyaWWf+GoMQtNqnowli8k?=
 =?us-ascii?Q?B/qIbw+ECdRKx+Dj2eG4l0+60HeOuJkloLpbTp2yrg4UYvM+gD41gN5ndBYV?=
 =?us-ascii?Q?dK6n2Cd1cuvzpZcqiAGoRJIiBmZfbvjnNJTD9cebecUX+2TYDoUDd8llcfjs?=
 =?us-ascii?Q?xLi+2g3ZihSxcEpdFi5knqv9KW+fzZIqQd/yGIphttRc1aLl5uO5ZSD1l353?=
 =?us-ascii?Q?5Hx2GvDGqzaBAZ3saqR7AWR5qlzQZNH+7H3hJkd9iLK2KykwasdNkYLGvMo0?=
 =?us-ascii?Q?zH6j79IZsPEN8N67uPIoiNxEi3nuSpBCw9seIh3E41spYAA0KIhInnDlRP25?=
 =?us-ascii?Q?uAKz/a/91se8jdvx7waXbSgS1w+7MliOnbrXWjCtHTBTyTXlu/FGmgfagyJI?=
 =?us-ascii?Q?1O03iXfMH676Z16mTxoL3E9waJYYij2abK7YAfsVduh6iZ/yS0XY/f7JL5e3?=
 =?us-ascii?Q?T/rNJ3bop0CMFp3DNWkDI1JLkKmpy/5AUBITfaNDUfWTLJLCmZ3nIqbmLu9K?=
 =?us-ascii?Q?ablOPoZdBfnYdWOVwmyxahFaW5diSQ4J2Izf8Csl4FS2aKfCy7yNT2HhEnpS?=
 =?us-ascii?Q?Fr/EACswuKuVavJEECK7p/KCVtnkzi3eN31XNknUF+DEsqbWlkgIcDViNwMc?=
 =?us-ascii?Q?VwaFDIOrdKk3rJutLvF5v0OMM3juT3SF4+VJeo1Drb3Pw/dCrYpkBUqzgyae?=
 =?us-ascii?Q?hWxaXR7mt/H2oqkzCrRsrrokd5jFnMK0d+CltfekVnBROG1iN3pz02CI/3Id?=
 =?us-ascii?Q?XhaukIetxF+8ScSIPjTyHJrhiSOoURWJmtjh4h5ElNC5BgrzFiRf0FeYBjX4?=
 =?us-ascii?Q?mqxAsCT3m1znXO2NfVK9fTse+cE93pjpY9UmTXaV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769e1c5d-4e4e-4aaa-a64e-08db93719b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 16:00:34.6469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTgLUUEnGwN7zeEvEDBx1C7JtFQlIKGw9Ab8oN4BIGp9/cjlW0QA9Oq26CM547RrQyiRsDZZX6EtRvFxb4YS6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8732
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
> From: Johannes Zink <j.zink@pengutronix.de>
> Sent: Wednesday, August 2, 2023 9:40 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>; Russell King
> <linux@armlinux.org.uk>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; Shawn Guo <shawnguo@kernel.org>; Sascha
> Hauer <s.hauer@pengutronix.de>; Neil Armstrong <neil.armstrong@linaro.org=
>;
> Kevin Hilman <khilman@baylibre.com>; Vinod Koul <vkoul@kernel.org>; Chen-
> Yu Tsai <wens@csie.org>; Jernej Skrabec <jernej.skrabec@gmail.com>; Samue=
l
> Holland <samuel@sholland.org>
> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; Jerome Brunet
> <jbrunet@baylibre.com>; Martin Blumenstingl
> <martin.blumenstingl@googlemail.com>; Bhupesh Sharma
> <bhupesh.sharma@linaro.org>; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Simon Horman
> <simon.horman@corigine.com>; Andrew Halaney <ahalaney@redhat.com>;
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>; Wong Vee Khee
> <veekhee@apple.com>; Revanth Kumar Uppala <ruppala@nvidia.com>; Jochen
> Henneberg <jh@henneberg-systemdesign.com>; netdev@vger.kernel.org; linux-
> stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; linux-amlogic@lists.infradead.org;
> imx@lists.linux.dev; Frank Li <frank.li@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v3 net 2/2] net: stmmac: dwmac-imx: pause t=
he
> TXC clock in fixed-link
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>
>
> Hi Shenwei,
>
> On 8/2/23 16:27, Shenwei Wang wrote:
> >
> >
> >> -----Original Message-----
> >> From: Johannes Zink <j.zink@pengutronix.de>
> >> Sent: Wednesday, August 2, 2023 1:26 AM
> >> To: Shenwei Wang <shenwei.wang@nxp.com>; Russell King
> >> <linux@armlinux.org.uk>; David S. Miller <davem@davemloft.net>; Eric
> >> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> >> Paolo Abeni <pabeni@redhat.com>; Maxime Coquelin
> >> <mcoquelin.stm32@gmail.com>; Shawn Guo <shawnguo@kernel.org>;
> Sascha
> >> Hauer <s.hauer@pengutronix.de>; Neil Armstrong
> >> <neil.armstrong@linaro.org>; Kevin Hilman <khilman@baylibre.com>;
> >> Vinod Koul <vkoul@kernel.org>; Chen- Yu Tsai <wens@csie.org>; Jernej
> >> Skrabec <jernej.skrabec@gmail.com>; Samuel Holland
> >> <samuel@sholland.org>
> >> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>; Alexandre Torgue
> >> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> >> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> >> <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; Jerome Brunet
> >> <jbrunet@baylibre.com>; Martin Blumenstingl
> >> <martin.blumenstingl@googlemail.com>; Bhupesh Sharma
> >> <bhupesh.sharma@linaro.org>; Nobuhiro Iwamatsu
> >> <nobuhiro1.iwamatsu@toshiba.co.jp>; Simon Horman
> >> <simon.horman@corigine.com>; Andrew Halaney <ahalaney@redhat.com>;
> >> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>; Wong Vee Khee
> >> <veekhee@apple.com>; Revanth Kumar Uppala <ruppala@nvidia.com>;
> >> Jochen Henneberg <jh@henneberg-systemdesign.com>;
> >> netdev@vger.kernel.org; linux- stm32@st-md-mailman.stormreply.com;
> >> linux-arm-kernel@lists.infradead.org;
> >> linux-kernel@vger.kernel.org; linux-amlogic@lists.infradead.org;
> >> imx@lists.linux.dev; Frank Li <frank.li@nxp.com>
> >> Subject: Re: [EXT] Re: [PATCH v3 net 2/2] net: stmmac: dwmac-imx:
> >> pause the TXC clock in fixed-link
> >>
> >> Caution: This is an external email. Please take care when clicking
> >> links or opening attachments. When in doubt, report the message using
> >> the 'Report this email' button
> >>
> >>
> >> Hi Shenwei,
> >>
> >> On 8/1/23 19:10, Shenwei Wang wrote:
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Johannes Zink <j.zink@pengutronix.de>
> >>>> Sent: Tuesday, August 1, 2023 7:48 AM
> >>>> To: Shenwei Wang <shenwei.wang@nxp.com>; Russell King
> >>>> <linux@armlinux.org.uk>; David S. Miller <davem@davemloft.net>;
> >>>> Eric Dumazet <edumazet@google.com>; Jakub Kicinski
> >>>> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Maxime Coquelin
> >>>> <mcoquelin.stm32@gmail.com>; Shawn Guo <shawnguo@kernel.org>;
> >> Sascha
> >>>> Hauer <s.hauer@pengutronix.de>; Neil Armstrong
> >>>> <neil.armstrong@linaro.org>; Kevin Hilman <khilman@baylibre.com>;
> >>>> Vinod Koul <vkoul@kernel.org>; Chen- Yu Tsai <wens@csie.org>;
> >>>> Jernej Skrabec <jernej.skrabec@gmail.com>; Samuel Holland
> >>>> <samuel@sholland.org>
> >>>> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>; Alexandre Torgue
> >>>> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> >>>> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> >>>> <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; Jerome
> >>>> Brunet <jbrunet@baylibre.com>; Martin Blumenstingl
> >>>> <martin.blumenstingl@googlemail.com>; Bhupesh Sharma
> >>>> <bhupesh.sharma@linaro.org>; Nobuhiro Iwamatsu
> >>>> <nobuhiro1.iwamatsu@toshiba.co.jp>; Simon Horman
> >>>> <simon.horman@corigine.com>; Andrew Halaney
> <ahalaney@redhat.com>;
> >>>> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>; Wong Vee Khee
> >>>> <veekhee@apple.com>; Revanth Kumar Uppala <ruppala@nvidia.com>;
> >>>> Jochen Henneberg <jh@henneberg-systemdesign.com>;
> >>>> netdev@vger.kernel.org; linux- stm32@st-md-mailman.stormreply.com;
> >>>> linux-arm-kernel@lists.infradead.org;
> >>>> linux-kernel@vger.kernel.org; linux-amlogic@lists.infradead.org;
> >>>> imx@lists.linux.dev; Frank Li <frank.li@nxp.com>
> >>>> Subject: [EXT] Re: [PATCH v3 net 2/2] net: stmmac: dwmac-imx: pause
> >>>> the TXC clock in fixed-link
> >>>>
> >>>> Caution: This is an external email. Please take care when clicking
> >>>> links or opening attachments. When in doubt, report the message
> >>>> using the 'Report this email' button
> >>>>
> >>>>
> >>>> Hi Shenwei,
> >>>>
> >>>> thanks for your patch.
> >>>>
> >>>> On 7/31/23 18:19, Shenwei Wang wrote:
> >>>>> When using a fixed-link setup, certain devices like the SJA1105
> >>>>> require a small pause in the TXC clock line to enable their
> >>>>> internal tunable delay line (TDL).
> >>>>
> >>>> If this is only required for some devices, is it safe to enforce
> >>>> this behaviour unconditionally for any kind of fixed link devices
> >>>> connected to the MX93 EQOS or could this possibly break for other de=
vices?
> >>>>
> >>>
> >>> It won't impact normal devices. The link layer hasn't built up yet.
> >>>
> >>
> >> As Russel suggested in [1] - maybe you could rephrase your commit
> >> message for your v4 to point this out to future reviewers (apparently
> >> multiple people have had questions about this...)  and have this fact
> >> also recorded in the git log later on.
> >>
> >
> > Okay.
> >
> >> Also: does this only apply to i.MX93, or would we have to test and
> >> enable it on e.g. i.MX8MP as well?
> >>
> >
> > Yes, it is required when the EQOS MAC is selected. However, this patch
> > just enables The feature on i.MX93.
>
> If this behaviour is required on all EQOS, I think the name
> imx_dwmac_fix_speed_mx93() is misleading. It should either be
> imx_dwmac_fix_speed() if applicable to all imx implementations, or
> dwmac_fix_speed() (and moved to a non-gluecode file) if applicable for al=
l
> implementations in general.
>

It has the general fix_speed function there named imx_dwmac_fix_speed.
This one is the special for this mx93 fix.

Thanks,
Shenwei


> You can then add a second patch for enabling it for the i.mx93 in the glu=
ecode
> driver.
>
> Johannes
>
>
> >
> > Thanks,
> > Shenwei
> >
> >> Thanks
> >> Johannes
> >>
> >> [1] ZMk/xqRP67zXHNrf@shell.armlinux.org.uk
> >>
> >>
> >>> Thanks,
> >>> Shenwei
> >>>
> >>>> Best regards
> >>>> Johannes
> >>>>
> >>>>>
> >>>>> To satisfy this requirement, this patch temporarily disables the
> >>>>> TX clock, and restarts it after a required period. This provides
> >>>>> the required silent interval on the clock line for SJA1105 to
> >>>>> complete the frequency transition and enable the internal TDLs.
> >>>>>
> >>>>> So far we have only enabled this feature on the i.MX93 platform.
> >>>>>
> >>>>> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> >>>>> Reviewed-by: Frank Li <frank.li@nxp.com>
> >>>>> ---
> >>>>>     .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 42
> >> +++++++++++++++++++
> >>>>>     1 file changed, 42 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> >>>>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> >>>>> index 53ee5a42c071..2e4173d099f3 100644
> >>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> >>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> >>>>> @@ -32,6 +32,7 @@
> >>>>>     #define GPR_ENET_QOS_RGMII_EN               (0x1 << 21)
> >>>>>
> >>>>>     #define MX93_GPR_ENET_QOS_INTF_MODE_MASK    GENMASK(3, 0)
> >>>>> +#define MX93_GPR_ENET_QOS_INTF_MASK          GENMASK(3, 1)
> >>>>>     #define MX93_GPR_ENET_QOS_INTF_SEL_MII              (0x0 << 1)
> >>>>>     #define MX93_GPR_ENET_QOS_INTF_SEL_RMII             (0x4 << 1)
> >>>>>     #define MX93_GPR_ENET_QOS_INTF_SEL_RGMII    (0x1 << 1)
> >>>>> @@ -40,6 +41,7 @@
> >>>>>     #define DMA_BUS_MODE                        0x00001000
> >>>>>     #define DMA_BUS_MODE_SFT_RESET              (0x1 << 0)
> >>>>>     #define RMII_RESET_SPEED            (0x3 << 14)
> >>>>> +#define CTRL_SPEED_MASK                      GENMASK(15, 14)
> >>>>>
> >>>>>     struct imx_dwmac_ops {
> >>>>>         u32 addr_width;
> >>>>> @@ -56,6 +58,7 @@ struct imx_priv_data {
> >>>>>         struct regmap *intf_regmap;
> >>>>>         u32 intf_reg_off;
> >>>>>         bool rmii_refclk_ext;
> >>>>> +     void __iomem *base_addr;
> >>>>>
> >>>>>         const struct imx_dwmac_ops *ops;
> >>>>>         struct plat_stmmacenet_data *plat_dat; @@ -212,6 +215,42
> >>>>> @@ static void imx_dwmac_fix_speed(void *priv, uint speed, uint mod=
e)
> >>>>>                 dev_err(dwmac->dev, "failed to set tx rate %lu\n", =
rate);
> >>>>>     }
> >>>>>
> >>>>> +static void imx_dwmac_fix_speed_mx93(void *priv, uint speed, uint
> >>>>> +mode) {
> >>>>> +     struct imx_priv_data *dwmac =3D priv;
> >>>>> +     int ctrl, old_ctrl, iface;
> >>>>> +
> >>>>> +     imx_dwmac_fix_speed(priv, speed, mode);
> >>>>> +
> >>>>> +     if (!dwmac || mode !=3D MLO_AN_FIXED)
> >>>>> +             return;
> >>>>> +
> >>>>> +     if (regmap_read(dwmac->intf_regmap, dwmac->intf_reg_off, &ifa=
ce))
> >>>>> +             return;
> >>>>> +
> >>>>> +     iface &=3D MX93_GPR_ENET_QOS_INTF_MASK;
> >>>>> +     if (iface !=3D MX93_GPR_ENET_QOS_INTF_SEL_RGMII)
> >>>>> +             return;
> >>>>> +
> >>>>> +     old_ctrl =3D readl(dwmac->base_addr + MAC_CTRL_REG);
> >>>>> +     ctrl =3D old_ctrl & ~CTRL_SPEED_MASK;
> >>>>> +     regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
> >>>>> +                        MX93_GPR_ENET_QOS_INTF_MODE_MASK, 0);
> >>>>> +     writel(ctrl, dwmac->base_addr + MAC_CTRL_REG);
> >>>>> +
> >>>>> +     /* Ensure the settings for CTRL are applied and avoid CPU/Com=
piler
> >>>>> +      * reordering.
> >>>>> +      */
> >>>>> +     wmb();
> >>>>> +
> >>>>> +     usleep_range(10, 20);
> >>>>> +     iface |=3D MX93_GPR_ENET_QOS_CLK_GEN_EN;
> >>>>> +     regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
> >>>>> +                        MX93_GPR_ENET_QOS_INTF_MODE_MASK, iface);
> >>>>> +
> >>>>> +     writel(old_ctrl, dwmac->base_addr + MAC_CTRL_REG); }
> >>>>> +
> >>>>>     static int imx_dwmac_mx93_reset(void *priv, void __iomem *ioadd=
r)
> >>>>>     {
> >>>>>         struct plat_stmmacenet_data *plat_dat =3D priv; @@ -317,8
> >>>>> +356,11 @@ static int imx_dwmac_probe(struct platform_device
> >>>>> +*pdev)
> >>>>>         plat_dat->exit =3D imx_dwmac_exit;
> >>>>>         plat_dat->clks_config =3D imx_dwmac_clks_config;
> >>>>>         plat_dat->fix_mac_speed =3D imx_dwmac_fix_speed;
> >>>>> +     if (of_machine_is_compatible("fsl,imx93"))
> >>>>> +             plat_dat->fix_mac_speed =3D imx_dwmac_fix_speed_mx93;
> >>>>>         plat_dat->bsp_priv =3D dwmac;
> >>>>>         dwmac->plat_dat =3D plat_dat;
> >>>>> +     dwmac->base_addr =3D stmmac_res.addr;
> >>>>>
> >>>>>         ret =3D imx_dwmac_clks_config(dwmac, true);
> >>>>>         if (ret)
> >>>>
> >>>> --
> >>>> Pengutronix e.K.                | Johannes Zink                  |
> >>>> Steuerwalder Str. 21            |
> >>>> https://www/
> >>>> .pe%2F&data=3D05%7C01%7Cshenwei.wang%40nxp.com%7Ccfd142f0d60a4
> 61
> >> ee01408
> >>>>
> >>
> db9321578d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63826554
> >> 36335
> >>>>
> >>
> 61986%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> >> zIiLCJ
> >>>>
> >>
> BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DCV10o1M%2BOj
> >> DPOaH5C
> >>>> y%2Fka%2B0aOMs0IaVapMH7aa3RnTI%3D&reserved=3D0
> >>>>
> >>
> ngutronix.de%2F&data=3D05%7C01%7Cshenwei.wang%40nxp.com%7C761fbb75c
> >>>>
> >>
> 1c24cfe091508db928d8ade%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> >>>>
> >>
> 0%7C638264908852977732%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> >>>>
> >>
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
> >>>>
> >>
> 7C&sdata=3D2l2zNfIaNnRJENmERehNae8g%2F%2BQqlxD2YRx7ksY2X%2BE%3D&r
> >>>> eserved=3D0    |
> >>>> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> >>>> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
> >>>
> >>>
> >>
> >> --
> >> Pengutronix e.K.                | Johannes Zink                  |
> >> Steuerwalder Str. 21            |
> >> https://www/
> >> .pe%2F&data=3D05%7C01%7Cshenwei.wang%40nxp.com%7Cdc64404f8c2c4e
> b87a7808
> >>
> db93666ec9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63826584
> 03801
> >>
> 74614%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIiLCJ
> >>
> BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DoxLnb3ppqjhMti
> cQH7P
> >> lfRbIlYJ2R1Z8Tg7Bz2vC%2F%2Bc%3D&reserved=3D0
> >>
> ngutronix.de%2F&data=3D05%7C01%7Cshenwei.wang%40nxp.com%7Ccfd142f0d
> >>
> 60a461ee01408db9321578d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> >>
> C0%7C638265543633561986%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> >>
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
> >> %7C&sdata=3DyKzNPsHqD%2FxU%2FRmzLn4JSQjmuT9tU8SabLxHyGTTmms%3
> D&r
> >> eserved=3D0    |
> >> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> >> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
> >
> >
>
> --
> Pengutronix e.K.                | Johannes Zink                  |
> Steuerwalder Str. 21            |
> https://www.pe/
> ngutronix.de%2F&data=3D05%7C01%7Cshenwei.wang%40nxp.com%7Cdc64404f8
> c2c4eb87a7808db93666ec9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> C0%7C638265840380174614%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
> %7C&sdata=3Dr8tFe0Ts3ev2c7lg3MK0Qc40101d7W%2BEwnpmvMDwjho%3D&res
> erved=3D0    |
> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

