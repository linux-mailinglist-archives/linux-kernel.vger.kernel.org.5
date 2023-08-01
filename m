Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C813176BAD7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjHARKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjHARKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:10:50 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DE52D5E;
        Tue,  1 Aug 2023 10:10:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IljHEqzM1m941FUnF33Q8dJpX6dO0fqQEiGa2RG3FC1YcgsnKzUZTj/NLWZnQRnwDPZlKi9jImlq/tdzdWqApxfG5lZPJSj1NCnt2kjIS0VhhcYVr8BAMmYHuujts3Xl0ghwo+LVKOAdAzDn8FFvN44ohlzumbWDm09N9jBOmmc2s38eljRiptR99kATc+tK4aAMov65qtwgztDkwkLZrk1SbMbaGZLelAO6ZtTjEyQrB8iYW3rjDDfKnENLM6NkInMOGHDA5lOeQnWNhFSJb3CtFsvO+JbJfiJ4tMs6u0A7LOeR6Ucwa5/RS/XoTmrefsEbwbghApP9Yt7JDM0gMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n98rouop6UhW+bb2u1wEcn1y8x5ouUwyq2ao7OpYGTY=;
 b=buNxMiITH9B9LRH0jSjTddgKbdU5utFpntSwL2OZRvZ8jEoIatXrVkg5CKlAKTo6/qsueW7mcqRI1Mewp3IEAZJ+DX+VPukbzBBGaRtHssBYKAIIi9zfwNzXW17HXqtEaHstl71lT2NOq82OFq2c01YDwA7c3wS/r7Exi/DNeNz1hz9rAiZGkETtMNVEnQbX/dS9DuehO6yoBPC/7om944lp9xTg15iF6gSlpaLVWuwJpO3zpS3BoLVLnsbaQHQisiG/cbLQgd6IzCJ4VBQjqWUlXADxX6UmvWuKXS7aRz/Izs94dg73bBJ6rWWJrGLCL9/5fN4VV3puIfrhYIb5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n98rouop6UhW+bb2u1wEcn1y8x5ouUwyq2ao7OpYGTY=;
 b=Y7pIe0S6TXTp3vciYa5iTCJ79YZLwYBH/OoUqRqxi/apf38MxSXXk64xomzW7tlHboFczyJom80SoA5x016M2U+FqvDA98UIZHipwH/YLM/sDw61RP+VNY/23l05lqlK4URQojZpMHh8YpWHxoXtY3BBaQNM7dNj6fIxG1Qb2Jw=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI1PR04MB7119.eurprd04.prod.outlook.com (2603:10a6:800:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 17:10:07 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 17:10:07 +0000
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
Thread-Index: AQHZw8rr+4AkxJNLt0GANB66N1LNC6/VZScAgABIh3A=
Date:   Tue, 1 Aug 2023 17:10:07 +0000
Message-ID: <PAXPR04MB9185D7D3B088E4786A216044890AA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230731161929.2341584-1-shenwei.wang@nxp.com>
 <20230731161929.2341584-3-shenwei.wang@nxp.com>
 <bf2979c4-0b63-be53-b530-3d7385796534@pengutronix.de>
In-Reply-To: <bf2979c4-0b63-be53-b530-3d7385796534@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|VI1PR04MB7119:EE_
x-ms-office365-filtering-correlation-id: e85803bb-2f6e-461e-a164-08db92b227d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IZpfJpM7U4ZmSxubf0wv42RhSuyWDoPKt3uDnRWKjnuv370xLcLIQlHVd8MDsg6wMjyEEBsFDPEvm9T4xULxsjYejgAdUD+Kw0N+kQt4amo5H2ifBhXCC8LSZzZ4aE1K37+IcIF5eucXkbd1qZKTTzDp9HbAr8EPROwXlUJTehdXDznUUS5pMS7YzVpC/kKa6LKayAndB/p927fz/qQLnsVcvijypQ4HBAQs3MjTVsO5/Lf6lQEguHYfHgI3PzF25cY3rmRz7/yX+QRp8gmShkVNG2FsyD64SCIBFXt9E89BHYgaeGAvycrd5VKjec2zjx6sBrzdD5ZIpbN0v2ttXfzzudwrRDWpR3lBzZoGj4c6yZajZEb7KauOBnFrJeckiFqrE/OUmPxw4TVmnpQSVletwqeNXsGYZHvoFZQMu7L0Nw2RpTbkeoipgy/VhDE41wa2BrG6Lq0SUZh1xFZ7oZwmXZEiUQJXNlhmKt7uR259WiPkJH7s3/YbfnD0O8/1LCU8ufGG/adR0jLJYqIC/LcRMgkIHYIoE+LfBVKCiPqO51oJetQv/xJlrFGy3yTe6giW4PiTY0ZSuUeYwwVezqHgt75T2LU+j8Bi8tcslhonzSxUCfEaU7MllLRAgkpM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(66946007)(66476007)(66446008)(64756008)(66556008)(4326008)(316002)(966005)(9686003)(83380400001)(2906002)(86362001)(38070700005)(7416002)(7406005)(44832011)(186003)(26005)(52536014)(5660300002)(55236004)(53546011)(6506007)(33656002)(122000001)(921005)(38100700002)(55016003)(41300700001)(8936002)(8676002)(7696005)(45080400002)(71200400001)(478600001)(54906003)(110136005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ixxDJ2N+YLmD+UgTWq1zFdcM0FXW93PKIWsTjBVgKtvRuXPeduhv0AzuuRpR?=
 =?us-ascii?Q?D1QHKS0MYH87cO5+qjCqOhJ2bhZecNyuPH3ImoU1cirZYoK9joJbkmqf6NK/?=
 =?us-ascii?Q?rIYilWlGIpNRg7wPLHHBek92bW/oTtPHsz01uOiEB+R8poHMRSgbvJ/foIJt?=
 =?us-ascii?Q?l64Vg4UzGXfuDWKAlFKgAZfg5u9U7OYsZjJZEyeE0lyylyXokPzbbbsBXaQs?=
 =?us-ascii?Q?Xcvh1A4KP8FFiZLcoQEC7HCptGb7tAcFVihs751N2E0Ju3OMpcZuwoAXPi+x?=
 =?us-ascii?Q?tcmdWqtfHhHERWwxPhJp8hfdfDrsRIlsdRXEsizilCVlJeYkSHZvfiQAixXh?=
 =?us-ascii?Q?flSuR1tbwJ9qRFQpG1tz7OkuYU/VS+kypw9pDLcaJwrP1GoWo3c3oeWJ0UpG?=
 =?us-ascii?Q?RE/uwNDm5Rn3O4gMmMKXRJ/VL9tW4ZvKHfkEQLe9EtZ3MTyWI1dlE9MckG+J?=
 =?us-ascii?Q?/0gzUKUruX+rTV5V4LQGJuNlBCLFGtmDinQTJRiZR6mr536IgX0mlqFhsF3S?=
 =?us-ascii?Q?Pw7pqLtvz5cLkRQvz7J6pG1iQXFqv88bV0W4x+ioIuQ83+yZAeIAC8VcTRoh?=
 =?us-ascii?Q?JYbXyGj/LbReVJotXHcen8mIb0RXPn7ZLjJ5a3UfowYLH80USxFBpr8mbxSL?=
 =?us-ascii?Q?D0FP/Ll6wq3OWb+WRKWWN4rifPHZeIMYbGL3MQvn7CgeAR76zyqE7o90QgOI?=
 =?us-ascii?Q?gscOcvO2sarKQx73fULIjI6lOG8XCZqNFIgUmsU5R+UK63p/VIHdWVEU1gwb?=
 =?us-ascii?Q?PSdfiGCRq150zqyiwQ+oB3if39FUMLBl4tiuRD5fWZeio7bwCrvCNjolz2K5?=
 =?us-ascii?Q?xgFENqPiiWoljNeUrkT0agowMrunDDYj2F/KpWt3j3MNliOBFLOuCYMjLJBr?=
 =?us-ascii?Q?4Ujey379js7kEPFEoJY/eY/ZfXJMGYNWyLwWUyLcUM5szoxG8v+YR8LggTta?=
 =?us-ascii?Q?NpwqxW7FCrQ14v9aPWhRkPacqyElrZJQXOe2PHCEx+7VRn2Be99tyV/E5ZZG?=
 =?us-ascii?Q?bojOpNj+tqYCdVd3brVNcw6zIk50svfFQnCJFSmKZzQKaBqgWAGBBJOnVznR?=
 =?us-ascii?Q?ZMZr6SjATTKmsSJaMXlBeNxtho51GtrCuypsL2YmygsfD35LLJSY36wH0zMl?=
 =?us-ascii?Q?U//GJK1xxpqySpviq/1hAYJa1XcY5mcqMC0td27dgR36+0wMxeUOx8A4aLWG?=
 =?us-ascii?Q?l05GGzEzMWwk2j81WwVslhmNFcXVifsafdMeCqXCig8XL/fTbsole3nXtSQe?=
 =?us-ascii?Q?Mdvg6LW3WEOWGQvLMskrWEFNT3gc0CBRc2APTYWX6hKrIeieKoYCmirfSQv4?=
 =?us-ascii?Q?1sGtBgz8rw8WZpnpL3a61jZMkN7uIpXLigI6HZFqw7UAFnKbv3649hJwUVKq?=
 =?us-ascii?Q?1+2BJoT66cisft2JhhP/Ex7Vfbca7dfSEYmVwf+XzIL9qE2z6oKy5YyOF854?=
 =?us-ascii?Q?e+TEhBr84mtldktTD5rZoFV2IgsiPpqTBOzGRN1aE/OLockqU1xy0wfZyRHN?=
 =?us-ascii?Q?KTh/H5FcxDpqALNzB3/Sb8per351zQIrai/hJZ4zHr0q6st7H0FWquBt6ZEG?=
 =?us-ascii?Q?3qwW5hodlojhWy/UwXUdn3NMwMt1UnkAjPIqxbqE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85803bb-2f6e-461e-a164-08db92b227d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 17:10:07.2747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7+dkH60P7Wy49w0auOljUgiMga9DHGDnEvJNAnc3tzTvTjCehSXkGM3EtsHDB690VtnoFn9Todi3JREvfHpcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7119
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
> Sent: Tuesday, August 1, 2023 7:48 AM
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
> Subject: [EXT] Re: [PATCH v3 net 2/2] net: stmmac: dwmac-imx: pause the T=
XC
> clock in fixed-link
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
> thanks for your patch.
>
> On 7/31/23 18:19, Shenwei Wang wrote:
> > When using a fixed-link setup, certain devices like the SJA1105
> > require a small pause in the TXC clock line to enable their internal
> > tunable delay line (TDL).
>
> If this is only required for some devices, is it safe to enforce this beh=
aviour
> unconditionally for any kind of fixed link devices connected to the MX93 =
EQOS
> or could this possibly break for other devices?
>

It won't impact normal devices. The link layer hasn't built up yet.

Thanks,
Shenwei

> Best regards
> Johannes
>
> >
> > To satisfy this requirement, this patch temporarily disables the TX
> > clock, and restarts it after a required period. This provides the
> > required silent interval on the clock line for SJA1105 to complete the
> > frequency transition and enable the internal TDLs.
> >
> > So far we have only enabled this feature on the i.MX93 platform.
> >
> > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > Reviewed-by: Frank Li <frank.li@nxp.com>
> > ---
> >   .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 42 ++++++++++++++++++=
+
> >   1 file changed, 42 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> > index 53ee5a42c071..2e4173d099f3 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> > @@ -32,6 +32,7 @@
> >   #define GPR_ENET_QOS_RGMII_EN               (0x1 << 21)
> >
> >   #define MX93_GPR_ENET_QOS_INTF_MODE_MASK    GENMASK(3, 0)
> > +#define MX93_GPR_ENET_QOS_INTF_MASK          GENMASK(3, 1)
> >   #define MX93_GPR_ENET_QOS_INTF_SEL_MII              (0x0 << 1)
> >   #define MX93_GPR_ENET_QOS_INTF_SEL_RMII             (0x4 << 1)
> >   #define MX93_GPR_ENET_QOS_INTF_SEL_RGMII    (0x1 << 1)
> > @@ -40,6 +41,7 @@
> >   #define DMA_BUS_MODE                        0x00001000
> >   #define DMA_BUS_MODE_SFT_RESET              (0x1 << 0)
> >   #define RMII_RESET_SPEED            (0x3 << 14)
> > +#define CTRL_SPEED_MASK                      GENMASK(15, 14)
> >
> >   struct imx_dwmac_ops {
> >       u32 addr_width;
> > @@ -56,6 +58,7 @@ struct imx_priv_data {
> >       struct regmap *intf_regmap;
> >       u32 intf_reg_off;
> >       bool rmii_refclk_ext;
> > +     void __iomem *base_addr;
> >
> >       const struct imx_dwmac_ops *ops;
> >       struct plat_stmmacenet_data *plat_dat; @@ -212,6 +215,42 @@
> > static void imx_dwmac_fix_speed(void *priv, uint speed, uint mode)
> >               dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
> >   }
> >
> > +static void imx_dwmac_fix_speed_mx93(void *priv, uint speed, uint
> > +mode) {
> > +     struct imx_priv_data *dwmac =3D priv;
> > +     int ctrl, old_ctrl, iface;
> > +
> > +     imx_dwmac_fix_speed(priv, speed, mode);
> > +
> > +     if (!dwmac || mode !=3D MLO_AN_FIXED)
> > +             return;
> > +
> > +     if (regmap_read(dwmac->intf_regmap, dwmac->intf_reg_off, &iface))
> > +             return;
> > +
> > +     iface &=3D MX93_GPR_ENET_QOS_INTF_MASK;
> > +     if (iface !=3D MX93_GPR_ENET_QOS_INTF_SEL_RGMII)
> > +             return;
> > +
> > +     old_ctrl =3D readl(dwmac->base_addr + MAC_CTRL_REG);
> > +     ctrl =3D old_ctrl & ~CTRL_SPEED_MASK;
> > +     regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
> > +                        MX93_GPR_ENET_QOS_INTF_MODE_MASK, 0);
> > +     writel(ctrl, dwmac->base_addr + MAC_CTRL_REG);
> > +
> > +     /* Ensure the settings for CTRL are applied and avoid CPU/Compile=
r
> > +      * reordering.
> > +      */
> > +     wmb();
> > +
> > +     usleep_range(10, 20);
> > +     iface |=3D MX93_GPR_ENET_QOS_CLK_GEN_EN;
> > +     regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
> > +                        MX93_GPR_ENET_QOS_INTF_MODE_MASK, iface);
> > +
> > +     writel(old_ctrl, dwmac->base_addr + MAC_CTRL_REG); }
> > +
> >   static int imx_dwmac_mx93_reset(void *priv, void __iomem *ioaddr)
> >   {
> >       struct plat_stmmacenet_data *plat_dat =3D priv; @@ -317,8 +356,11
> > @@ static int imx_dwmac_probe(struct platform_device *pdev)
> >       plat_dat->exit =3D imx_dwmac_exit;
> >       plat_dat->clks_config =3D imx_dwmac_clks_config;
> >       plat_dat->fix_mac_speed =3D imx_dwmac_fix_speed;
> > +     if (of_machine_is_compatible("fsl,imx93"))
> > +             plat_dat->fix_mac_speed =3D imx_dwmac_fix_speed_mx93;
> >       plat_dat->bsp_priv =3D dwmac;
> >       dwmac->plat_dat =3D plat_dat;
> > +     dwmac->base_addr =3D stmmac_res.addr;
> >
> >       ret =3D imx_dwmac_clks_config(dwmac, true);
> >       if (ret)
>
> --
> Pengutronix e.K.                | Johannes Zink                  |
> Steuerwalder Str. 21            |
> https://www.pe/
> ngutronix.de%2F&data=3D05%7C01%7Cshenwei.wang%40nxp.com%7C761fbb75c
> 1c24cfe091508db928d8ade%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0%7C638264908852977732%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
> 7C&sdata=3D2l2zNfIaNnRJENmERehNae8g%2F%2BQqlxD2YRx7ksY2X%2BE%3D&r
> eserved=3D0    |
> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

