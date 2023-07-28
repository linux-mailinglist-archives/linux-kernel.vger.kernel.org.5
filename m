Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2526A7672A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbjG1RBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjG1RBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:01:51 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70695100;
        Fri, 28 Jul 2023 10:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAAb+LlQkwtIiIzIROwDigg9ckN9DiGd+eCPBpejqBt5o09CiixJs/EQO3dmGaUrS2jy0MDyF4CYjhn5bTjazHp2Wnk9CX8vHlii3aTBNTD3l9l9QoSMzN74vUu9Qd7Lu/HjYiXhI6la5DdwG/CR5q8ggBgivkXssS9vM5k0IJaOFgK2jCpfZGJpADUjL1kldz7+zRu1tgbRV3t6U0U9jCTctMcs+lpvIxhHyO9hhE65h4JQSjjafmxXQRwiQ9iz+8FZDQ4cwsxCGKTnvt6bAiuY3LQuwcKTm9gnBuc1kFKF5bfkEhnSDdRsrEz49Pev4mvhHu42+Ws525z+f56B5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MastBJ4kt2ecrZkqyzJ0zEUttJfaxEzYDmELArE9uRk=;
 b=YxQTDhYUyROzSDhFRr3lGC7bbB1DzWH2Fabm/UHSTbXpmfY481PgyTQcM6+oyLCCfLA68UCtyn/iyYHBCCyWo/wDGJVYui9DTgrh9uyC/zW0jB9Y2IGHvEMiYknh3IiYDySpNQo6E+EIWve5zRNice7BcfxynQhb6L8jlUV8uezVYoGlFemLBQKofzTK0A3wFjqCpjiWN2TQOVZP/Nw/hwe6dh3Dn474Wi0/GyLaWxtBsn9U4ZAu9B1rZMDJKOvDR44L1p9ZopK9p0eiaRvTmJyVsd2ZSnPtLBdQCibXFT4P8aqA2tchk0TB9XPrmr0SO7RdcAzoGuvTbddy12XJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MastBJ4kt2ecrZkqyzJ0zEUttJfaxEzYDmELArE9uRk=;
 b=Bz5gkSQBdNbHI587z20zh66pG1s9A9SM3Dqpja1zvzLEg4bmFLzs+bnIJxLmRPdTKIfq6eWLM+slVxRGM7z10cUcfM5SF4QXvMi63c+TON+J0Rs2jJLozTtzWJwT+3WdNZW426KyZCTWUh8Ck9Hfm6wPaGYdQcDlJ8H0/g1bs2s=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAXPR04MB8766.eurprd04.prod.outlook.com (2603:10a6:102:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 17:01:46 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 17:01:46 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Fabio Estevam <festevam@gmail.com>,
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
        Samuel Holland <samuel@sholland.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
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
Subject: RE: [EXT] Re: [PATCH v2 net 2/2] net: stmmac: dwmac-imx: pause the
 TXC clock in fixed-link
Thread-Topic: [EXT] Re: [PATCH v2 net 2/2] net: stmmac: dwmac-imx: pause the
 TXC clock in fixed-link
Thread-Index: AQHZwJ6ZmPtrsmRv9UGenRTta+C4Xq/PBDcAgABC5ICAACBXAIAAAQnQ
Date:   Fri, 28 Jul 2023 17:01:46 +0000
Message-ID: <PAXPR04MB9185168AEBA2FD0F7D5885028906A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230727152503.2199550-1-shenwei.wang@nxp.com>
 <20230727152503.2199550-3-shenwei.wang@nxp.com>
 <CAOMZO5ANQmVbk_jy7qdVtzs3716FisT2c72W+3WZyu7FoAochw@mail.gmail.com>
 <PAXPR04MB9185945F7E5B1A36ADF4F3E28906A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <f6c78350-e668-455f-bae5-731dbef633de@lunn.ch>
In-Reply-To: <f6c78350-e668-455f-bae5-731dbef633de@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|PAXPR04MB8766:EE_
x-ms-office365-filtering-correlation-id: a192947b-4105-4b81-88ad-08db8f8c53bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MdBi8/DKmw0BCrbuQQi5XPNRAa4A/2alYVvXWfsrs86lTeBJXRpHPjrzB+PqNz68IwvS3u5g/2e3DpjevMUX4HUb+tIce8WAGWb4dIwL5mpaWIXlFJ7dtd52I5yo6RRsUvu/iHZQygpGbhbX6VDXJDmj5xD6w8GsOnMvXJkhTdFcjk30wvzeR6ixeK6I0LBvxse8QBEqTpKO15QgKmrh1oa1DqZsahHQsWBNPHy0NjmGLVr7WgQ3jFOSMHfbPxLxgB+vozeVfwxPXWmzhIU/uBrWiUXhAN9eOhMgmosSvOCnMfFzzrWGOmO2IVzV1SeVppv9dhm+Bm8lLtZgs2KskySYic5LhWafqLXIwAzzexovGszzfzB/aEvl9LQee+IgA+k0jL5SKTLDh+Bekz9EtQjaoWq4V+HerC8ZSizZrHpAd/QFEaU96KvJeTEYJHwrjpMj6OaCU43HFUhSIOv75v/n0AUFWuma3XAFE9E1gpvo+7sH1PViWHXRfLH24W37eGemQLnZOS1Tj4oGbN+o6+amQ6K6t5JtsuVLr32c2H8EY2mn42rZh+yKF2rW64EDl4ntpo2a4cKwj9qVPvyGxLka5ZEHvG4+vFCHhzvoenP9N/0u64CGxDx3/ND7pcjt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(86362001)(41300700001)(2906002)(316002)(38070700005)(7416002)(5660300002)(7406005)(8936002)(8676002)(33656002)(55016003)(44832011)(52536014)(9686003)(55236004)(53546011)(6506007)(26005)(7696005)(478600001)(71200400001)(83380400001)(38100700002)(186003)(64756008)(4326008)(6916009)(66446008)(66476007)(66946007)(76116006)(54906003)(66556008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MTKuyRdQY56rhUrnsfeeS7GjqBnsGajI0XCeWjxJJOPm+098rNaYzeiCcMIU?=
 =?us-ascii?Q?k1dQ0YyWxSE2gJQtl9qDIhnE2MeMvBeYtQSCzvytievFuKxPURENcdnxWIwE?=
 =?us-ascii?Q?mT10Tf2lb53cd2M7yoM86woVPRK4KwwXlGB8djgBLEDkIWXjRMNFRWNGkxot?=
 =?us-ascii?Q?LZR9l9hHYaQFt6gxDxcQUNFUoM1P+fdwLqBM2XKf/JuZw5ZFEo7ZfYDJRPg0?=
 =?us-ascii?Q?sp5KanZDxcUDD3i4S2R9+IYGBG85BIFM1ARiarUL5Ub5B/wzInHZADqMwj2C?=
 =?us-ascii?Q?ACSFaUU9ow4bAKDFAidvsBvubwl+0c3t0DKV4hCkipz2Wp2foolGUF1K5sRx?=
 =?us-ascii?Q?sRyWgbJWgOYA4iE27mdCiHTKmAEuBc5dJgRfbRYswi3d82+3FmHNkYNLw3fB?=
 =?us-ascii?Q?QpylX5l+o95USY0quhy7B2KupxInAgPc66EhLqLktCtLYRNGplvwjOlZGltR?=
 =?us-ascii?Q?Xo/hcBqlAe+8HdnzDWpGQcN+8tLYBVpOye3t5vjA497ZFLpbSZuJ2W0dM5AW?=
 =?us-ascii?Q?XKsjpVkMxL5Sx2Jy+9HAkorxLH5+xeDQx4Q1xFc6dt/OFgsFA5Ibv6usjZM7?=
 =?us-ascii?Q?ep0LMF4o6IbdtT3Pz/vqgRQ/qU0glbtpnXTWq3EYl8Hwr0x1E8dAqDQc/mJe?=
 =?us-ascii?Q?vFEUZ1KR8hxzyCh2JTNQT9N9QgEe8l80KeU1A2qQ5gs5NAs1BT3PhGHZNUEG?=
 =?us-ascii?Q?GCJiuGDAuUdKMGnAD0II7vrJNKs+Js22mLaJ8+JaB5EqCG9AI32HGxRtq3A0?=
 =?us-ascii?Q?KiBtjEQUhbqpj/4C78NNySY4Rlbf4YGI730aIKNG72HBblugLAta2OZwmcs/?=
 =?us-ascii?Q?WwL2Nr0ICQKrABIsxwMwXShUrcePPDv8/Wzo7JI/HD9gi5H2LN7/lR/zU3Wf?=
 =?us-ascii?Q?RDdd4qmaPAVCShKjiCTvbctPl+Zrr5IrR/Hqwn78fU+bvfCXmajZC4DRQbvA?=
 =?us-ascii?Q?OOwkAurvCka7Ywb8FgxjHXLSJKiOVMeVuyd6t0Ze/LKlkA5ZaIeElvWVdfJ1?=
 =?us-ascii?Q?VS5FTIckrrZt89vlxacuG7I0PFbOuQbbktIhPRSYiDgHYr00TU0qfvnfuC9r?=
 =?us-ascii?Q?I3aaT3x7Jjz1VNyD2nG99sp7WbrrPzxklreLqiXMn8pZm6PaOcL/RCWlXjE7?=
 =?us-ascii?Q?HRgsZDCYL+Du+DZhw4un5lKEKqb0Ibky3Y6ZDnjH2B16kPc2tlgr8TZ2wmkS?=
 =?us-ascii?Q?1614QTauWzRDObyitL0dUOvkvhU96YLhCa/Bz6VYvKO62Eic7qD4B8ZRfGoB?=
 =?us-ascii?Q?orJWu/NGuWdwYN0LGysNmWllpdowvJz0fSL2crplPQpoL4VM5/G9j0FvkgeR?=
 =?us-ascii?Q?ooxGUS3tAq0g87qqg04rzyfH3Q1M5huKtbYVgdvBcKzMLwpswZ557hFNg7BB?=
 =?us-ascii?Q?Ol+yodou3bx4j/jsBN6BHcKRtjE0MQFTcoYEBuUKPNcQ0TegOTQF9qOChlwT?=
 =?us-ascii?Q?P946MfE9h5CiFibPlmTmGgGTQIiu0oFkESxNv3MymNySJKDfSfLhJX622ANt?=
 =?us-ascii?Q?Q9ndSuYJMVlYdOpXqZzqnwGxYwAoxNuV5FZm2PfwriFH7944FjbdoplxWm4W?=
 =?us-ascii?Q?KzcY/FW3hM/DM3UVhfThMBzZvbiqDExc2okPc+Pr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a192947b-4105-4b81-88ad-08db8f8c53bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 17:01:46.5642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNdiOtHxKOVzeLZ4nMBPGFN/IwW0az/Qurx7krTf/rn4j1tiNVyCGBoKwClv/c6VBU4gCtP9NDxNy+4AHKOLgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8766
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
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Friday, July 28, 2023 11:56 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>; Russell King
> <linux@armlinux.org.uk>; David S. Miller <davem@davemloft.net>; Eric
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
> <kernel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>; Jerome Brunet
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
> Subject: Re: [EXT] Re: [PATCH v2 net 2/2] net: stmmac: dwmac-imx: pause t=
he
> TXC clock in fixed-link
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> > > Andrew Lunn gave the following feedback in v1:
> > >
> > > "The SJA1105 has the problem, so i would expect it to be involved in =
the
> solution.
> > > Otherwise, how is this going to work for other MAC drivers?
> > >
> > > Maybe you need to expose a common clock framework clock for the TXC
> > > clock line, which the SJA1105 can disable/enable? That then makes it
> > > clear what other MAC drivers need to do."
> >
> > I have been considering this plan for some time. The idea should be
> > implemented across all i.mx8/9 platforms. I am going to start to work
> > on it in the following month, and it will take some time to implement i=
t.
>=20
> So you don't think anybody will use anything else for driving this switch=
? Vybrid?
>=20

Vybrid or i.MX6 don't have such kind of problem because they are not using =
dwmac.
Those are FEC MACs, and the MAC itself can provide delay to the switch.

Thanks,
Shenwei

> It does not really matter what you implement it for, so long is at is a c=
lear
> example for others to follow who might be using the switch with other SoC=
s.
>=20
>         Andrew
