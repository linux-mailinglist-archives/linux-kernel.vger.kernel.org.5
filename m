Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E47876E99F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbjHCNLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbjHCNK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:10:57 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on0614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FDB4222;
        Thu,  3 Aug 2023 06:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bozFGSxXbvJ/qW12EKCDuUhsddhBIbHnNlb0pflD3b/KbXjdmLiUpPX5X9ClrOWVW3QBKKg/UzX9fw+VTXm811SUUw0YhUod56EQKmz6zGeNP4tKg9IcAzsgodlYcQYcNwnB/90aetZN0Z52+1VG97ITYJ/kG9jUwkTja5A7nhOaUFwVdAEsJJ2++kkqxleG/a50G/Rpzl/AeeNhoQd0b+NVpKdGZJbtB0X3w9vmXCZTWcOKyAZdhRnc7UBmLwESBfsemGgczY0kgYe4P5WLxmphFoIbt8VpYSq+XiiUvc4MZP02SRxjCZzArmh1FUEX7GO9uVHCzk5PW4Fw6P1ovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP0QUPSl56zdo3LgBD2UOgk1OjiC7FnJ9jjEw9uR1aQ=;
 b=BMmR2L3Wnr+OkckIqD0iwEH7Fw8Q2ooznSr8tNjOVH9PiG55eJMrqH++ZQSJ3EaYIfHTt1X7p8gOYgVNIx9ON4ngbxXxBhYHr5l5dLpVZn4tw32rGSNsfEwdVEyV5L1TBQaVeax8kj9Bhm1ILwiOmwPUHjmHy4q5PgXI0TNhI83lHlA4TB0gnOEV8tzdK9FWVfFJ2ruN4edPk+NdSVrP5i6Ugc0QJUrrlNNIJGpk1MEyq0o1mlUvQ7ZxNzwopbpRrU7uCFNIJqmxGWEfNpgNAZt9DacqVHf6MuIOkrzqPuwsCitGIxzabKMj1XHESJRLwUw0ubJeK9ucJTWMZZy6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP0QUPSl56zdo3LgBD2UOgk1OjiC7FnJ9jjEw9uR1aQ=;
 b=FD2DHvcMAG1Y1Y4qSdbn4xjkEUp/7AqZ/L/3f8ztVj7QgDSOChShDzhMW8WukoJbKl3WBw2aT3EI7n6L+iLYoKwLA6aPjDzT0ivuZGwW4jZrvw3RX84RZR+rhK7Yf7yEdZOba2lMAgcEPmowyL2n5SGs/1vjUelQOpskUF3osbc=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 13:08:03 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:08:03 +0000
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
Thread-Index: AQHZw8rr+4AkxJNLt0GANB66N1LNC6/VZScAgABIh3CAAN8TAIAAhezwgAAERICAABXLQIAA9VKAgABnjmA=
Date:   Thu, 3 Aug 2023 13:08:02 +0000
Message-ID: <PAXPR04MB9185E6512A5220E83D17D6A58908A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230731161929.2341584-1-shenwei.wang@nxp.com>
 <20230731161929.2341584-3-shenwei.wang@nxp.com>
 <bf2979c4-0b63-be53-b530-3d7385796534@pengutronix.de>
 <PAXPR04MB9185D7D3B088E4786A216044890AA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <e32c89e1-7385-105b-63c9-74f58c2253cb@pengutronix.de>
 <PAXPR04MB91851BB5D1375AF0EF3C51B7890BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <49d52a10-20cf-9c5b-ebe3-07292664fe11@pengutronix.de>
 <PAXPR04MB9185C0C3B3E41534F555BC43890BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <22f979e8-7591-3393-f323-114da0131e7a@pengutronix.de>
In-Reply-To: <22f979e8-7591-3393-f323-114da0131e7a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM9PR04MB8604:EE_
x-ms-office365-filtering-correlation-id: b53b30fa-b95a-4ae8-dce8-08db9422ab81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TjxgsExC4/RAzJtyEBcjSNmTuhhzsrgiTM5OpWxuHPByo8V+1fmFqd4TsIkcAHOdtHa30/qrniMIMK2w+w6hL7nhN1yP/h+T4G7H0Z/h/aSK/7CffDBH7TCV7tDzqBCfdcHHqAUm9jqpdi68nibxvqjsVBxLL7Ca0/z46PGtff3fjp1XTvIc+rMWvEqBnXuPpO1RrR0TZ9g71Ks0aIQVvChMI1brQogX3XJcqifeNNNoVmlIvCx+P4iL728rPS0/bxwFAoh4EJZjCg5W0iOnrfWSSLxbfABYIeG3YI/+JgPQMBZqX6vlC0VqdFG0EhTrbuJcdjp4K2bw2jXjjg+oFDuqXqntznAjE6/XJqxE3riW6IjFNPFsK440Yf6NTcdzfj1zZ/1jULV8GuVoLdrTnDfmR7o/EM5q25DZql32//1O5CZUpmI9884pGqNl4iftEEawpouS9VuHdsBmxcUoP7MVTyOmZAxmF5r1VEz5bTve1GVc1SzcZ9sq4nYYwAxA+153mj88odeRlboTmgjk0cN94YwYZw7v2cy8YHRxFqgtzqkmpyNnXb/OisA946T0+k+T9IhlUKKI1zi/E92pHiidIRm8tFRlp5Ga13JEcOlxVJiVEAwo+QB36kziDBPk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(53546011)(55236004)(83380400001)(6506007)(26005)(186003)(41300700001)(52536014)(2906002)(66946007)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(5660300002)(316002)(44832011)(7416002)(8676002)(8936002)(7696005)(71200400001)(966005)(7406005)(9686003)(45080400002)(478600001)(54906003)(110136005)(55016003)(38100700002)(921005)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MkNqZII/6Odjt5OpNRfmakRxvPB+HY9Wbepal+5J0APGsHvoka/fLni+LpKN?=
 =?us-ascii?Q?giY7/Rgl0fIfPQlCkxd+EfFdOJ4kjyGsDJUr/tmKzi7QtycKptiO6mcavY9N?=
 =?us-ascii?Q?oXB4hKlJAuWwwBK40WCZOde068f94N7QhIcgyMeF/29yduqgPQG3FRTUtk/8?=
 =?us-ascii?Q?E40qqIRCUJBlLplPBLuvU2aDeferZJAImm0xyMfVrmwzZdS3itMpRUTGtSPd?=
 =?us-ascii?Q?1JGX5E5a0+2HT7JHjT2orz+1Kg9wyJKLMEXle1RoPqBfKvau2g0C/rvdhKKe?=
 =?us-ascii?Q?PD/yNt2VB2bFjIxafS0pFI7Zu5Z0xRtrLbMcFKla4OiZm+clAQQ+BSpyosgY?=
 =?us-ascii?Q?EqaGnkEUVf1NSZ0qwogCdOtaDQvr0OPsuu9sq11QDa/+wpU+QXRhmhqfqOhS?=
 =?us-ascii?Q?QW0+Qiy/p30ZiIC4giLJnHqnl0tDWtjV9O6eva/cQfDvtP2DVFEXBimcDLuR?=
 =?us-ascii?Q?1bVw0O2D+BdbkdPdmgSODNGRBjXPb8VsuZkVf1E1RYlvg6YCEp06VlCOyRKp?=
 =?us-ascii?Q?ieCf/YIQM6BbLL/T6lDHEgfnI4f+qokFkf212+hQ3bOPl8rmJziJSd6rHhei?=
 =?us-ascii?Q?04hEg1LiQXtSMlCxdbogf9BdOgKMV+y5nwnX36QfntwwjMkShlW06yIgCHV8?=
 =?us-ascii?Q?hmaLlc9ii2qdTfAiPdAwEl/a31NjnM2yD+8rhZPA/7tFxSOPurVYNIWS81l5?=
 =?us-ascii?Q?WVB+AVkxfj592ehKZ3ncXFgIk4yUztNUfUAvxNn/14luGdAKR5oEsMoBfL/y?=
 =?us-ascii?Q?XNlFHc6aDyX++KzHk8D+2wIgDcy51SKMDUM0Vrc0S/arFnQbvjWQ1RJkw4Xg?=
 =?us-ascii?Q?YxFH9zc+6P0st14xZHHJwp7+NyaaIMy7c1YvhGQfsg7nSLvBz5Q2kQCRa8g4?=
 =?us-ascii?Q?8UzJAnsmq6o1CH/iRurNLiGYURIn6dP6H1VXc54/tHAaZr42EdCqUyJaPx4v?=
 =?us-ascii?Q?++2pOwXmsgjJQx9bOIbauNVos8K3ws16L47hmnpGebaq5dtK3iuHLQVm9m0l?=
 =?us-ascii?Q?dyVsEjZm88XADzPM/uQXy1zbqzVZMfLjPwCIVG/qRorfh1q4ZzgKoGaDVbyS?=
 =?us-ascii?Q?xd6YJnS5EuW3h2QIYweKrNpe8g+5m90FcHyl2Q4peXrNtNoh7z3J/6gIhU8j?=
 =?us-ascii?Q?B8+PDumVtHl8tOOXkQgFB0paj6jyzxPXqivUIVLcACRgB2kWMnsFLaTEetMc?=
 =?us-ascii?Q?LmAJ4azkciA6TAJZgjyfIBgT+NNX/+6mYKKIc6OCYQ0xBVboIXERCmGR2FEV?=
 =?us-ascii?Q?X7VLEN5lyRTuFCZl1eG50cZUBGu5lFBltKClVDNIVzfULtUq/SAmzm8hrZmh?=
 =?us-ascii?Q?A5W0q8zGmia2ii6rtATRQIDjGep6GTopTBkwJwRrr+GQ+zjV9emBN3Joozk0?=
 =?us-ascii?Q?R7+gqxdhvpFXVGPs9WTzW2EXmanXnZON1IeFC1CP0VdB7bWTdd7wcg829eKD?=
 =?us-ascii?Q?eiy/zjbPEUyI9XhabvQWlYar+8ikPkUrp6jTu3BRG3e5R4879W+Is5DoPjLx?=
 =?us-ascii?Q?7f18PYKKK7Fo1+FpzrAERp3ofPzlI7CoabcDMDLT+fsqvkS/Dqh5wQ7QBN8q?=
 =?us-ascii?Q?YXUcGtxVfytGs7llJH37hxC1QHZnNHIj6o1lTqZw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53b30fa-b95a-4ae8-dce8-08db9422ab81
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 13:08:03.0071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ogRgzMKTTo0SiPD8un3W7cs7qjhAxCf0V11sVAOf1Ean/FNAPkAFfoLl850acAfGJQgEdfO8OlougQLN9U/CMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8604
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Johannes Zink <j.zink@pengutronix.de>
> Sent: Thursday, August 3, 2023 1:36 AM
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
> > It has the general fix_speed function there named imx_dwmac_fix_speed.
> > This one is the special for this mx93 fix.
>
> I think I might have misunderstood your last statement or I failed to exp=
ress my
> point. If you need to replace the dwmac_fix_speed() on mx93, because this=
 SoC
> implementation requires doing so (the usual reason for doing something li=
ke this
> is something like reset quirks because of screwed up IP Core integration)=
, then
> your approach is imho valid.
>
> But if I got your last comment right, your changes should apply to EQOS M=
AC in
> general (but you want to only enable it for mx93 at the moment). In this =
case
> this quirk will later be as the fix_mac_speed function for other hardware=
 as well,
> in which case the name ..._mx93 is misleading, and imho rather a descript=
ive
> name should be used (i.e. have the name describe what it does rather than=
 for
> what hardware it is implemented).
>

The idea of supporting the SJA1105 is general, but the implementation depen=
ds on the
specific SoC. This patch provides the implementation for the MX93 SoC. To s=
upport the
MX8x SoCs, the implementation would need to be rewritten based on the curre=
nt state
of the dwmac-imx driver.

I agree the function name is somewhat ugly. Maybe a better name could be:
mx93_dwmac_fix_speed()

The assumption is that the process of pausing the clock can still be consid=
ered part of fixing the speed.

Thanks,
Shenwei

> Except if the maintainers have a strong opinion that the ..._mx93 suffix =
version
> is exactly how you should proceed...
>
> Best regards
> Johannes
>
> >
> > Thanks,
> > Shenwei
> > [snip]
>
>
> --
> Pengutronix e.K.                | Johannes Zink                  |
> Steuerwalder Str. 21            |
> https://www.pe/
> ngutronix.de%2F&data=3D05%7C01%7Cshenwei.wang%40nxp.com%7Cd328d89d
> 14e847270d5a08db93ebff01%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> C0%7C638266414027048795%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
> %7C&sdata=3DdkE9Es7kl3uNYx8zJYZt2r6933dSNtYDpQzCEagAV3M%3D&reserved
> =3D0    |
> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

