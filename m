Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46FC76D00A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjHBO2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjHBO1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:27:52 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2087.outbound.protection.outlook.com [40.107.241.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032AAEC;
        Wed,  2 Aug 2023 07:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCGioG/OU7aSUFuqGYDmCAP3so6A4kSJBvLmawpHZSZt+rWeggCvYYTHxOKRPu1NFT3MDzwNt2gWVjN3RQNLh7cGv5ohI9LyamQ+oRe+L4gGxZzwHsqfgWPVGfyQL6h2xPbVtlFrsF9jz1trhbqUP1QMFJvNtwvmwOw8H1AinU9DcB9d2ZUkIdgHN9ekKKsVDfEgVTvHGmjCMQxI8BwFIB4kE7xV8Yf+HbyQg06SqS/PEFMWZC32utJg//VuYHKL//5e0kC8Npg1n5xhv0gEt2+k4RNH3VhzHhSHd4fQSS3I/sNywZTrXSKKO6W7y207Nn1UO1CZrJ+XypppCN//Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uoOsuxRqtJinWDygcXmjk9WFhmFVt8JwCF6e0SgWxg=;
 b=QJogitv/ssCDpf71qNn6NWVY8MsCxOHzkripSINBgETFzKelWyHU74emqhYYm4TAPAH6KiFgUs6NigHZyJGcldKXSCPMqK99KLOyK4MJf0GyKFGQhF8Swa3y/+dPR9Eq2MCsYtJm5sP8kkC7bRePlc4xcUbRNpDwoMF9tLDoG/Z74JdpOtd8bd8B3eIiarS6D8jRKYEPFbsT7hTOA9pblOjOWROhsI1+H5MogET9cCv/g311L3/vuoJeFcersN12pT4LamiRKWEgEGayiM24Vcs6MwA8sg/HHFzZWIrODamO94h+bkyaow3rkwaq7IhHuLrq/WRj6vk62XJM6D1fMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uoOsuxRqtJinWDygcXmjk9WFhmFVt8JwCF6e0SgWxg=;
 b=e7WVWZrlMBwHmsJfh5Q6RMtWeonmuOQIeZH84tERjUH59NNL7C87gQRMbRTF0MQdWp6tz2GlcH9QqngYbr2NkVZYO6rRUrBayV1ylvGUxI3CSoWUMM8sTnFYEvVMX0f/TBt6HPiZ+or1HcJuSU8iBy1TgtvfO2hOzJORbJZ+fwY=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GVXPR04MB9734.eurprd04.prod.outlook.com (2603:10a6:150:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Wed, 2 Aug
 2023 14:27:43 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 14:27:43 +0000
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
Thread-Index: AQHZw8rr+4AkxJNLt0GANB66N1LNC6/VZScAgABIh3CAAN8TAIAAhezw
Date:   Wed, 2 Aug 2023 14:27:42 +0000
Message-ID: <PAXPR04MB91851BB5D1375AF0EF3C51B7890BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230731161929.2341584-1-shenwei.wang@nxp.com>
 <20230731161929.2341584-3-shenwei.wang@nxp.com>
 <bf2979c4-0b63-be53-b530-3d7385796534@pengutronix.de>
 <PAXPR04MB9185D7D3B088E4786A216044890AA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <e32c89e1-7385-105b-63c9-74f58c2253cb@pengutronix.de>
In-Reply-To: <e32c89e1-7385-105b-63c9-74f58c2253cb@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|GVXPR04MB9734:EE_
x-ms-office365-filtering-correlation-id: 44048bec-f465-42fd-4049-08db9364a238
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZiVhSPAdiCBz33u2RgkoYNKUHNQ66Sk642nD0qC+/aTjYlJTlPQIjTDVcTU2VIdz04mkZQyxr1YYSmEuY1MGPuz+pqLNg2rIGy0bnTKPB9ma3Zu7/GGFp/pL8y8KZwE+QEB1nu5HGvg+MVzTZW1DFnCWxgc5uaUXj1wJdlO+d8RnbTm+ej1n4aW4xkPjj+YQXR7MOtGlpCiYXTepNcK/EELyYe6VHX1HogCBFA/iYhe2CGBQrYdMxrG3fRCamtnjmLLlHglZUiAZie/sBS/3OigSnG6gQLR0BoiCfqNCzATArcZ9oi74guT24XqJzdQGGnLv1VeLXqi06BcAoULU+inywWIr2cD8lJlubfw2Y3NMvEJiFOaKn5z2/9m+Kxd6VH0KW4yIrxm4PiF3CFdUvwmimdFS7hd/1ync2ewzHbhV+dFjaOINX1xHU9kRshvXio1WJS2t2IbuHiwhgaFwrMVRlylsd1pGkD1bp75jo0jkZHnRFYD0w8G7yuff7OrACwKVQL/pAiABPY761apWcd6My52OUAuRxA8vhxUj6jMw6+dIguMQZNObEcZrfjnV7Pnpu0HVY4L2r9Q+FU6YYFjkQyQBO30XxsP4yrd/LV0frdxdtgAURqxjarvCjIm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(44832011)(966005)(9686003)(7696005)(53546011)(55016003)(55236004)(26005)(6506007)(83380400001)(186003)(76116006)(52536014)(33656002)(66946007)(66556008)(7416002)(110136005)(54906003)(41300700001)(921005)(122000001)(38070700005)(86362001)(7406005)(38100700002)(66476007)(66446008)(4326008)(5660300002)(8676002)(8936002)(316002)(64756008)(2906002)(71200400001)(478600001)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dHRhMEyg7CA85W9WRG5+oBpr9lcVSHQ69LTPjhE3MivHi7g5FaUOsaZmLFA8?=
 =?us-ascii?Q?ulU2kWfg63OxIhOICwQJXJ553xYttbFKwVEr+m1RpfikL/mijRn+TvVuyROK?=
 =?us-ascii?Q?buzyVI4TuJWnIbUEJVGDrZxsAo80jz1uvxaP9r8D96uabWEUDR6pzZFF4bGo?=
 =?us-ascii?Q?b8j1wD7iJmFv/tNdxpSMViiHCP7vvCcWMIqd57hTTPaMvCXO29Xi6rVIzQkR?=
 =?us-ascii?Q?6vOX7dcSrJJVL72ad0CUHmHnMUhDDvMuWLOYYrxLGznknDklttkKDtxUNO4h?=
 =?us-ascii?Q?8Lb+hVbLINvdOa9d9sfgapyrzXcMjoQMLSh/Fwvxcdyh+ahqTNZWPyJOZx4f?=
 =?us-ascii?Q?GZRixCPmmq/cR5hx6iij4VUSWJBL8p1xd2k2S0CegE9d224VXlrGzKGEfCot?=
 =?us-ascii?Q?hzYaEeP8YZqeD6U4eeS3wrIogKv0SbzKcE0qv94zWoXF3H+Mv+3V7py292Gx?=
 =?us-ascii?Q?FbWI8/5Jy5NCO/EVK+Vsv8iE2AVnRgBoxpv7j5BBiItCmBVx1OMbX3fKW/e1?=
 =?us-ascii?Q?NwzLXTBmdnUEw5APXmGKc7Fy4dRcV6aL3/4pRqoZ1FYBTpFN5tcLDJki/q7y?=
 =?us-ascii?Q?c0etjqlrMY2t0nh9TG5eXqp2IIgmZGamWsz35Rv9QK/3nUZjkp/sHK+6m2Tw?=
 =?us-ascii?Q?5L9h7aCwbILtYrPmcxX2MRfL5BDKmxfEc5sbrBRWdDzRtMycTelBrw549IF9?=
 =?us-ascii?Q?MDUqL9N9t7bcNZFka8c7flnbjAImU84wUu7qRT5pJpRw34h24JzoOqf9LLUr?=
 =?us-ascii?Q?++bXCJopJvMmUW6wkVAtAfirUrgmDG94VnrZAcW402+1Yesm0avuxYHkOP+c?=
 =?us-ascii?Q?dgXEDMKI9BXPxZtUS/HeSENn9IQbxoyyesjQ0qfmph/jE5Yorv2z5rOVJxx1?=
 =?us-ascii?Q?HEUVsHhF9EN2Pz0eXRrmFEUyGTfrGVHkVqOWHO8QC4ssoRL03kNjekG1k81m?=
 =?us-ascii?Q?MYVmuc5bl2E6u/XTr5tGw+8jxh9t/hxlMhEm+N3s4GKIzynwK3seTVf7d5Xa?=
 =?us-ascii?Q?1MFva47ErSTNhanD/2kTibYQzIEWVnACFO9wZqlA2HZzx/9ezfRXpJH3OggG?=
 =?us-ascii?Q?WT78S5WIUzpi6tsyi7oCUDTBMJQ4l3cORQV6dwyLgjWjpEdCMQnDZ+60m7lY?=
 =?us-ascii?Q?3qEXz8n4p1MWvuOtsjN9yX97myivQYtDtAgGbb49ize2YweAsQVwNce5TNtd?=
 =?us-ascii?Q?DIUlsbc47i5VW4Ym5t6Gbov0EDhLwQzbpa77hX/kcshn0CxsSKJgccQ9vhgK?=
 =?us-ascii?Q?r3nhuMn22ZvF5HZTQiu0u7mfyyXmmWAFdQHaLup08Ek1GhSlCT5dph5COuEY?=
 =?us-ascii?Q?FGgsD6UIknRaX0W+zB3UCyXn/kLH6rwXYhaJnalnNNl/cY7CB84Jp9mLdOO9?=
 =?us-ascii?Q?d8vBUkoicEIC9m1FCc9WMeo5jvawtt1uk0xmNykMm8Lg0vTUZbiUWtZqnFcO?=
 =?us-ascii?Q?UQz5LAXKCCnyB/AfeY+RrIlM80T0iEcG8slsZIjpV7EnPypAdiAm3XDZCB+h?=
 =?us-ascii?Q?Y24CqWX2jB1bSmwE8nTZpXc+GArM0zcYeZFhwyLKvnHeVE34h1yVjKYy/OX+?=
 =?us-ascii?Q?QL6SXvHReILUNOm9c0Vp3HwG/78V/QoBxPDTWcg4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44048bec-f465-42fd-4049-08db9364a238
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 14:27:43.0148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4lSWj5IaaN9OVZ/5Aubg10ygUHYJJkx2Y3OMTrPEJ7gtVvYJ/Z1FW76miYtzri5Uf1JDEm6Ix/bysYduu8Zlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9734
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
> Sent: Wednesday, August 2, 2023 1:26 AM
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
> On 8/1/23 19:10, Shenwei Wang wrote:
> >
> >
> >> -----Original Message-----
> >> From: Johannes Zink <j.zink@pengutronix.de>
> >> Sent: Tuesday, August 1, 2023 7:48 AM
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
> >> Subject: [EXT] Re: [PATCH v3 net 2/2] net: stmmac: dwmac-imx: pause
> >> the TXC clock in fixed-link
> >>
> >> Caution: This is an external email. Please take care when clicking
> >> links or opening attachments. When in doubt, report the message using
> >> the 'Report this email' button
> >>
> >>
> >> Hi Shenwei,
> >>
> >> thanks for your patch.
> >>
> >> On 7/31/23 18:19, Shenwei Wang wrote:
> >>> When using a fixed-link setup, certain devices like the SJA1105
> >>> require a small pause in the TXC clock line to enable their internal
> >>> tunable delay line (TDL).
> >>
> >> If this is only required for some devices, is it safe to enforce this
> >> behaviour unconditionally for any kind of fixed link devices
> >> connected to the MX93 EQOS or could this possibly break for other devi=
ces?
> >>
> >
> > It won't impact normal devices. The link layer hasn't built up yet.
> >
>
> As Russel suggested in [1] - maybe you could rephrase your commit message=
 for
> your v4 to point this out to future reviewers (apparently multiple people=
 have
> had questions about this...)  and have this fact also recorded in the git=
 log later
> on.
>

Okay.

> Also: does this only apply to i.MX93, or would we have to test and enable=
 it on
> e.g. i.MX8MP as well?
>

Yes, it is required when the EQOS MAC is selected. However, this patch just=
 enables
The feature on i.MX93.

Thanks,
Shenwei

> Thanks
> Johannes
>
> [1] ZMk/xqRP67zXHNrf@shell.armlinux.org.uk
>
>
> > Thanks,
> > Shenwei
> >
> >> Best regards
> >> Johannes
> >>
> >>>
> >>> To satisfy this requirement, this patch temporarily disables the TX
> >>> clock, and restarts it after a required period. This provides the
> >>> required silent interval on the clock line for SJA1105 to complete
> >>> the frequency transition and enable the internal TDLs.
> >>>
> >>> So far we have only enabled this feature on the i.MX93 platform.
> >>>
> >>> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> >>> Reviewed-by: Frank Li <frank.li@nxp.com>
> >>> ---
> >>>    .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 42
> +++++++++++++++++++
> >>>    1 file changed, 42 insertions(+)
> >>>
> >>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> >>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> >>> index 53ee5a42c071..2e4173d099f3 100644
> >>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> >>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> >>> @@ -32,6 +32,7 @@
> >>>    #define GPR_ENET_QOS_RGMII_EN               (0x1 << 21)
> >>>
> >>>    #define MX93_GPR_ENET_QOS_INTF_MODE_MASK    GENMASK(3, 0)
> >>> +#define MX93_GPR_ENET_QOS_INTF_MASK          GENMASK(3, 1)
> >>>    #define MX93_GPR_ENET_QOS_INTF_SEL_MII              (0x0 << 1)
> >>>    #define MX93_GPR_ENET_QOS_INTF_SEL_RMII             (0x4 << 1)
> >>>    #define MX93_GPR_ENET_QOS_INTF_SEL_RGMII    (0x1 << 1)
> >>> @@ -40,6 +41,7 @@
> >>>    #define DMA_BUS_MODE                        0x00001000
> >>>    #define DMA_BUS_MODE_SFT_RESET              (0x1 << 0)
> >>>    #define RMII_RESET_SPEED            (0x3 << 14)
> >>> +#define CTRL_SPEED_MASK                      GENMASK(15, 14)
> >>>
> >>>    struct imx_dwmac_ops {
> >>>        u32 addr_width;
> >>> @@ -56,6 +58,7 @@ struct imx_priv_data {
> >>>        struct regmap *intf_regmap;
> >>>        u32 intf_reg_off;
> >>>        bool rmii_refclk_ext;
> >>> +     void __iomem *base_addr;
> >>>
> >>>        const struct imx_dwmac_ops *ops;
> >>>        struct plat_stmmacenet_data *plat_dat; @@ -212,6 +215,42 @@
> >>> static void imx_dwmac_fix_speed(void *priv, uint speed, uint mode)
> >>>                dev_err(dwmac->dev, "failed to set tx rate %lu\n", rat=
e);
> >>>    }
> >>>
> >>> +static void imx_dwmac_fix_speed_mx93(void *priv, uint speed, uint
> >>> +mode) {
> >>> +     struct imx_priv_data *dwmac =3D priv;
> >>> +     int ctrl, old_ctrl, iface;
> >>> +
> >>> +     imx_dwmac_fix_speed(priv, speed, mode);
> >>> +
> >>> +     if (!dwmac || mode !=3D MLO_AN_FIXED)
> >>> +             return;
> >>> +
> >>> +     if (regmap_read(dwmac->intf_regmap, dwmac->intf_reg_off, &iface=
))
> >>> +             return;
> >>> +
> >>> +     iface &=3D MX93_GPR_ENET_QOS_INTF_MASK;
> >>> +     if (iface !=3D MX93_GPR_ENET_QOS_INTF_SEL_RGMII)
> >>> +             return;
> >>> +
> >>> +     old_ctrl =3D readl(dwmac->base_addr + MAC_CTRL_REG);
> >>> +     ctrl =3D old_ctrl & ~CTRL_SPEED_MASK;
> >>> +     regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
> >>> +                        MX93_GPR_ENET_QOS_INTF_MODE_MASK, 0);
> >>> +     writel(ctrl, dwmac->base_addr + MAC_CTRL_REG);
> >>> +
> >>> +     /* Ensure the settings for CTRL are applied and avoid CPU/Compi=
ler
> >>> +      * reordering.
> >>> +      */
> >>> +     wmb();
> >>> +
> >>> +     usleep_range(10, 20);
> >>> +     iface |=3D MX93_GPR_ENET_QOS_CLK_GEN_EN;
> >>> +     regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
> >>> +                        MX93_GPR_ENET_QOS_INTF_MODE_MASK, iface);
> >>> +
> >>> +     writel(old_ctrl, dwmac->base_addr + MAC_CTRL_REG); }
> >>> +
> >>>    static int imx_dwmac_mx93_reset(void *priv, void __iomem *ioaddr)
> >>>    {
> >>>        struct plat_stmmacenet_data *plat_dat =3D priv; @@ -317,8
> >>> +356,11 @@ static int imx_dwmac_probe(struct platform_device *pdev)
> >>>        plat_dat->exit =3D imx_dwmac_exit;
> >>>        plat_dat->clks_config =3D imx_dwmac_clks_config;
> >>>        plat_dat->fix_mac_speed =3D imx_dwmac_fix_speed;
> >>> +     if (of_machine_is_compatible("fsl,imx93"))
> >>> +             plat_dat->fix_mac_speed =3D imx_dwmac_fix_speed_mx93;
> >>>        plat_dat->bsp_priv =3D dwmac;
> >>>        dwmac->plat_dat =3D plat_dat;
> >>> +     dwmac->base_addr =3D stmmac_res.addr;
> >>>
> >>>        ret =3D imx_dwmac_clks_config(dwmac, true);
> >>>        if (ret)
> >>
> >> --
> >> Pengutronix e.K.                | Johannes Zink                  |
> >> Steuerwalder Str. 21            |
> >> https://www/
> >> .pe%2F&data=3D05%7C01%7Cshenwei.wang%40nxp.com%7Ccfd142f0d60a461
> ee01408
> >>
> db9321578d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63826554
> 36335
> >>
> 61986%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIiLCJ
> >>
> BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DCV10o1M%2BOj
> DPOaH5C
> >> y%2Fka%2B0aOMs0IaVapMH7aa3RnTI%3D&reserved=3D0
> >>
> ngutronix.de%2F&data=3D05%7C01%7Cshenwei.wang%40nxp.com%7C761fbb75c
> >>
> 1c24cfe091508db928d8ade%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> >>
> 0%7C638264908852977732%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> >>
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
> >>
> 7C&sdata=3D2l2zNfIaNnRJENmERehNae8g%2F%2BQqlxD2YRx7ksY2X%2BE%3D&r
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
> ngutronix.de%2F&data=3D05%7C01%7Cshenwei.wang%40nxp.com%7Ccfd142f0d
> 60a461ee01408db9321578d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> C0%7C638265543633561986%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
> %7C&sdata=3DyKzNPsHqD%2FxU%2FRmzLn4JSQjmuT9tU8SabLxHyGTTmms%3D&r
> eserved=3D0    |
> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

