Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941FD76718C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjG1QJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjG1QJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:09:34 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9FB4236;
        Fri, 28 Jul 2023 09:09:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1HfzQuhOTypRSdQ6ivQR/MEZElb5ELa1uZ0ZM3I7ra8DWEEK+oOqZlJgHgaLKjncKS3JIHbsbTBV+QQk6ORgmgXTg0/o6//UB+fZBjao3X+bnxM94VxPWMxTHa8uZcTyXrpnmj4kTdE8Lm3flwi3Dyh63PLc0yCDKsjNlIs/CRUY61rxO60aJwRHdTtALoHE6L+iKGt8Ku+XeCAr3P2c1VnCplsVTSG1zB4GGEfg33m96jFoETp+cn/jiEcbevdabYbbZjAlJBNd9wdt9SXZKnCdSC6+16VGT8Ns5MUPvYz9tDA+RnPodcKFrsX05XEw+JiQUb44zM2t8rb5PkYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/wtqdeGIhqexDWteR5SbI0NJNB1cbv4zHnDzzYRjRU=;
 b=A++dVbC5WOMeo1+bJcOJ0syL4VlgpsxHdPBNFulZA2Wk/71bOwfJFtCSg/q+nMp8Xxv8sm1oERpA9ltFQ4hIIkIIB44yZNjAAU91NHOLSOTE0MDQl5xNmfFsZ7/UhjULpP/TygZpHahZ0dqTmJvY07i/ebkykfxW7HkmUTBD56LBQkQ0jZ1s8apLUZmcXuvn8rcY4IZN7OjTy0btxtouup4N6Z6X+oXrw6OFep3YrF7AypteV6siUNLYxXxfvdp3DRl4WYHWIsmzyNSvEYDyWNUQm8pSWNc3xrtN9CUuPV9JOl5W6wTbKkqzQGf0REtcKgiqvrMoEL60l73IXNVTCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/wtqdeGIhqexDWteR5SbI0NJNB1cbv4zHnDzzYRjRU=;
 b=f3EScmtDMM1oIl96kUADqNdZ9NAE4egDD0MZ/WT0PWJm2Z3tItzgHMurDv9tUaMDJXWSIF4TWXaS0byIvbyjEHD9toWMNgtqhbMPMp0ZOAKJWlZkJhSoCxKxxtgeEGYaH/he2TwU9p0PWms9hNRGkLzmUlabk6MD9PzI9Md3DFU=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB8PR04MB6956.eurprd04.prod.outlook.com (2603:10a6:10:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:09:29 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 16:09:29 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Will Deacon <will@kernel.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Andrew Halaney <ahalaney@redhat.com>,
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
        Samuel Holland <samuel@sholland.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
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
Subject: RE: [EXT] Re: [PATCH v2 net 2/2] net: stmmac: dwmac-imx: pause the
 TXC clock in fixed-link
Thread-Topic: [EXT] Re: [PATCH v2 net 2/2] net: stmmac: dwmac-imx: pause the
 TXC clock in fixed-link
Thread-Index: AQHZwJ6ZmPtrsmRv9UGenRTta+C4Xq/N8VmAgAFcAoCAAAPhAIAAB8xg
Date:   Fri, 28 Jul 2023 16:09:29 +0000
Message-ID: <PAXPR04MB918542A7030A3193562C4A948906A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230727152503.2199550-1-shenwei.wang@nxp.com>
 <20230727152503.2199550-3-shenwei.wang@nxp.com>
 <4govb566nypifbtqp5lcbsjhvoyble5luww3onaa2liinboguf@4kgihys6vhrg>
 <ZMPdKyOtpZKEMLsO@shell.armlinux.org.uk>
 <20230728153611.GH21718@willie-the-truck>
In-Reply-To: <20230728153611.GH21718@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|DB8PR04MB6956:EE_
x-ms-office365-filtering-correlation-id: 452117ac-b961-4715-0f83-08db8f8505d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1cl+21UBhfC+GvyOLwGX6gqTJsg9Tf4VmH1xx0xsmLzVJ9ACwGlOWt3XpQcmsTX2x357JJBZi5ArdeTZZPI6eRIXijJk5lYGT6iATy1oWbVzn+Ec6pb0hFGtqJ9TvgNLS/ppJnUwJPWTp4oYzPb9vp1lola5WksB0JVDf0voXj11spChvCn63eDjaIOzMnEH4UG9FS0MBpt9TRURLkB+Uei3NKLIXrd4SrMhpDsAmvhHTvsBsvZB4PnIaSgVt5L+0rW57FF/qp9jNyvjA162iYcOVSHWwCxiTdYqIe6WSiXXfQo3OrW2xbJBOxlrE+vB6ijxNfPAGX4zIRms8C4QBWk76UUkajoM1T3OOSxhADODaOWVO95hF8Nao1oRshZ/LPE51okcHRGMaF1sQfAQXfaQEGbWBJHDZiXvYZgqX/Jf5nyVwCcVbDowVWmHFS462Fat/xc4UNzMbOmRwnEyE+SILhRxKJ2R2a0HC0jRjzLeuVtEuIkGpUfqsp1Fes73IYxQk5Y1AV4vLNP9kllJOS7U/0C2lzjyh5glZKnZC1eBFLLp7Zq7emTjk+epl7saGM3BdOK7XuqygqY0WGLw6b67IpeIaNaHVqIwb7Iuro=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199021)(86362001)(2906002)(8936002)(38070700005)(52536014)(316002)(8676002)(33656002)(7406005)(44832011)(83380400001)(5660300002)(66476007)(64756008)(66946007)(66556008)(66446008)(4326008)(76116006)(38100700002)(110136005)(54906003)(122000001)(186003)(45080400002)(26005)(53546011)(41300700001)(55236004)(6506007)(478600001)(71200400001)(7416002)(966005)(55016003)(9686003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PM7LpVr2AEujg2dv+FGfD0b9wP4pQb4XMIEqBCezCVK5Tw67FsYpkFpe0+wP?=
 =?us-ascii?Q?g9peRCnyuHJFiw/v8KdtYmbExPbViQoBt3OUM8cj2MrAv7GgqVTA2bVqLrcI?=
 =?us-ascii?Q?6/+izTYRqhgd6ed/SnuWoRKwbG65jLCpzs8c47W1D9Y8ZRtICmr+oYhzKfO+?=
 =?us-ascii?Q?qvO+JP/KvehaRZFLtc8EA74QRrZtpZYaIt9DSaB8aahnw8C7hvi9TWzmg8qZ?=
 =?us-ascii?Q?6cMRic7EKpCpAI3YPZn5dSp9Ua0VSF8TxAA+s/UsgEJD3ZoBLMFvcLkMRVoF?=
 =?us-ascii?Q?cxkg32DbyzWGNbZcJhLGo2s+ypF+/N5JiRRNiZJpWpVuZt+DFafgReRzk5l/?=
 =?us-ascii?Q?6I+hE/YHUBpv9K1KwFjWJ4lBSJ0TaRPIMYh5bvIQg4/xLdexUA8IEEwzzd0n?=
 =?us-ascii?Q?rLDqeXF3gMX7FGXoT6PzJajbhX+ftnehUsEgKDRA1CPUcE9tkt3c8F61GfxN?=
 =?us-ascii?Q?bKBeDsz+yK2dJmaYSfkGYqTKSrwnYBl7akb4zd6sChrV5YpQvGb2rMxCnqWa?=
 =?us-ascii?Q?XoMr1kOwoa71rJjZttmlM7jrNDj9Ii3LbtnKITKTQ2UKmclEkEjnVgheQkV8?=
 =?us-ascii?Q?rOu+O3etCzfrIEZrqqEoAdy+QSjg0aATg812rqxK6tJxV5nhLCiWBPTh+uOn?=
 =?us-ascii?Q?jkDUWtASgmsxvE9CpajC/f0hSoIV2o0ulcxbqSHxzIcXvr3ujZBYLoT33vdf?=
 =?us-ascii?Q?zVYSAH+qgavgFvUIUkXJo6K0m6k4lWKrAsbP38DoVrysMzzC1fyRWL3vuMju?=
 =?us-ascii?Q?ottLZGs4T0+/jaAuDfSUcAoA7x5uObpF9NcvGONNXT7BVs9zMpcQ5us9+0ff?=
 =?us-ascii?Q?M8nFKBE/y5oVuFfuWWwGpQoUhrOKkHL7p2p+YeJqT1/kb7Ei926el5mB1eJk?=
 =?us-ascii?Q?fwMf2zo+jP6sez4v255CSZxVEjAweS7Yu9yTo4UqpHS6V7TP19OJ20MtZZQC?=
 =?us-ascii?Q?7OL7g9XdQ0k41XtgZRzYt6LtOzurTODmQSVKJhYozhYNiiWC3gveOXlvLs7i?=
 =?us-ascii?Q?k+Iach1O0VWHcyOrm67hNrVGbRBsYxskc440dg2yyj/2CaLtbuRZGQBdmW6w?=
 =?us-ascii?Q?lwIpBDtRHB5BUo6EAAes9Q5p2kMmpdJP3tF4r+sBZZfOvE8q/ttQfo6jOlD1?=
 =?us-ascii?Q?Di+7qjFmnOuY82ZEprKDEK+2q2Ug91Fl+fZU3F5yoP8ZHG6BO14QEMEhUQIP?=
 =?us-ascii?Q?j/kuJszFi5oPqnT8KtmQTQQemR5w5HYThVryBPEYE7PhsN4LikvkS4rUtfH0?=
 =?us-ascii?Q?YKkFJQZ+PTJgOmDax2sCutAQ77hPBdbMT/49s5bqi5REfin+lQaISt4OC5Zr?=
 =?us-ascii?Q?72B0Foj5GtCxTJftM9HPngtQACDESqTH5ZJpsqoT+eP8tPa055eRJuDUus/e?=
 =?us-ascii?Q?hWl+lwvPWopvRkuAE9e+QSjQdoiJuaz027wsTiuGFH6wDTtDAJ2lw1lIZJQQ?=
 =?us-ascii?Q?A2CNB7NIEloQ8WT4dNzKsT+ZeJNuEJDaYJLgutVhVCtQNFC2s5Rqtga3A67e?=
 =?us-ascii?Q?D75j2drcUaKdcWNXgUiL0DSkkFg9a6KKKOFWhxKRIBzpUFtV+N+3dx9PcfhR?=
 =?us-ascii?Q?0w7L+mBKSOeJhV8AzwIO5/oDKvX9jX6gdjVKGQar?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452117ac-b961-4715-0f83-08db8f8505d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 16:09:29.4010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5S7fIKe+uz55onENv08oY2pfS/yShoWc7nClbaxRRiHgklqBAPF1Uniqz0R4TSPTb+h1omgW0EaZbywUb2SgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6956
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: Friday, July 28, 2023 10:36 AM
> To: Russell King (Oracle) <linux@armlinux.org.uk>
> Cc: Andrew Halaney <ahalaney@redhat.com>; Shenwei Wang
> <shenwei.wang@nxp.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; Shawn Guo <shawnguo@kernel.org>; Sascha
> Hauer <s.hauer@pengutronix.de>; Neil Armstrong <neil.armstrong@linaro.org=
>;
> Kevin Hilman <khilman@baylibre.com>; Vinod Koul <vkoul@kernel.org>; Chen-
> Yu Tsai <wens@csie.org>; Jernej Skrabec <jernej.skrabec@gmail.com>; Samue=
l
> Holland <samuel@sholland.org>; Giuseppe Cavallaro
> <peppe.cavallaro@st.com>; Alexandre Torgue <alexandre.torgue@foss.st.com>=
;
> Jose Abreu <joabreu@synopsys.com>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-imx
> <linux-imx@nxp.com>; Jerome Brunet <jbrunet@baylibre.com>; Martin
> Blumenstingl <martin.blumenstingl@googlemail.com>; Bhupesh Sharma
> <bhupesh.sharma@linaro.org>; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Simon Horman
> <simon.horman@corigine.com>; Bartosz Golaszewski
> <bartosz.golaszewski@linaro.org>; Wong Vee Khee <veekhee@apple.com>;
> Revanth Kumar Uppala <ruppala@nvidia.com>; Jochen Henneberg
> <jh@henneberg-systemdesign.com>; netdev@vger.kernel.org; linux-stm32@st-
> md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-amlogic@lists.infradead.org; imx@lists.linu=
x.dev;
> Frank Li <frank.li@nxp.com>
> Subject: [EXT] Re: [PATCH v2 net 2/2] net: stmmac: dwmac-imx: pause the T=
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
> On Fri, Jul 28, 2023 at 04:22:19PM +0100, Russell King (Oracle) wrote:
> > On Thu, Jul 27, 2023 at 01:36:45PM -0500, Andrew Halaney wrote:
> > > I don't have any documentation for the registers here, and as you
> > > can see I'm an amateur with respect to memory ordering based on my
> > > prior comment.
> > >
> > > But you:
> > >
> > >     1. Read intf_reg_off into variable iface
> > >     2. Write the RESET_SPEED for the appropriate mode to MAC_CTRL_REG
> > >     3. wmb() to ensure that write goes through
> >
> > I wonder about whether that wmb() is required. If the mapping is
> > device-like rather than memory-like, the write should be committed
> > before the read that regmap_update_bits() does according to the ARM
> > memory model. Maybe a bit of information about where this barrier has
> > come from would be good, and maybe getting it reviewed by the
> > arm64 barrier specialist, Will Deacon. :)
> >
> > wmb() is normally required to be paired with a rmb(), but we're not
> > talking about system memory here, so I also wonder whether wmb() is
> > the correct barrier to use.
>
> Yes, I don't think wmb() is the right thing here. If you need to ensure t=
hat the
> write to MAC_CTRL_REG has taken effect, then you'll need to go through so=
me
> device-specific sequence which probably involves reading something back. =
If you
> just need things to arrive in order eventually, the memory type already g=
ives you
> that.
>
> It's also worth pointing out that udelay() isn't necessarily ordered wrt =
MMIO
> writes, so that usleep_range() might need some help as well.
> Non-relaxed MMIO reads, however, _are_ ordered against a subsequent
> udelay(), so if you add the readback then this might all work out.
>

    1. Write RESET_SPEED
    2. Write 0 to MX93_GPR_ENET_QOS_INTF_MODE_MASK
    3. usleep_range()
    4. Restore MX93_GPR_ENET_QOS_CLK_GEN_EN | iface

In the above example, if a readback after step #2 could ensure sufficient t=
ime has passed
before step #4, the wmb() here should be abandoned.

Thanks,
Shenwei

> I gave a (slightly dated) talk about some of this at ELC a while back:
>
> https://www.yo/
> utube.com%2Fwatch%3Fv%3Di6DayghhA8Q&data=3D05%7C01%7Cshenwei.wang
> %40nxp.com%7C32396fd0396e4e46975f08db8f806680%7C686ea1d3bc2b4c6fa
> 92cd99c5c301635%7C0%7C0%7C638261553857503588%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000%7C%7C%7C&sdata=3DX5CQrQEVmUjYafYJ%2BzcnGXI9mhDT%
> 2BMzDazGHOcoomas%3D&reserved=3D0
>
> which might help.
>
> Will
