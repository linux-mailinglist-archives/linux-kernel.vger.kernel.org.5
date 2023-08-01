Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801AB76BACB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjHARIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbjHARIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:08:24 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121BF35A8;
        Tue,  1 Aug 2023 10:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAbVTTXdGDGyn3F3XsR4+mij1D8hhOCqriGFYHABNmM3LGylHddNMgQRXXa5vU/LnGG3PV719G7sa7KzFI2kJGqVKtoQOZMCgjEKiS8vlVeErp8+CtsWba2fyNyc3lm8v2rzxERp/F4xfqHcC7zG/f4XJMm9HoI9/umTxz9pQlYZNhxme4NRLAQmKqaHIryE3AiCtpWPHNwoM9IVWImi3LnLZ3+bk65xyqHdTiye4R/+uvYrsVuaciGtoOaeDT5xIYSyel1t+6a1Rg+ViVvR2l8fRWK4rM07YjUSmIHgJnFHksRiKw1kVGdbiamrfF+P1+cJ9Gzfn5+aswq1J3fyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7VJkdlzkvkfGQhJf7/FhknAsg8V5iXhf3Uc6CyOyAg=;
 b=cRvoZAc9trifZ+N0sSRPDm2+QyDoEPWj7S+mSZvtSiYNErrXzsBs/VMt0LnimypnDlCErX3alAlMjXtuB9r4Hnm6M3cFs80Td7MAIfnFPVA0pVWf20m2eu/yVVCn0/b1wiWVuRPOX2J+E1izWg8xxkk2cxuEYr1XYZS34h7IyS9DTMOJHnbqDGvl78QfLD/AmC/yjFWMn1B6BlnzD63HJtsn1SFQZgkWLnbvPZ+LLFfx81HXamcXk4N8nReKokrl7vsxVHbRQuWorRt3qOTmFsrNx6mgKLef4jzyCd65j5DuKIEmqc0CwHsC+y00PLf/kWXOnbbnCtpUq7GdbCg79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7VJkdlzkvkfGQhJf7/FhknAsg8V5iXhf3Uc6CyOyAg=;
 b=YcxWljvvCS7mnZpqltP8CAHvvW5a3xgp/wyjMBjn3CL1O65ZSvQQoTSPbT82KPX2iCcmquDNT0PLySK76/lyF0ImTxsAytrbp+ECdHkrqmz+jCS/8FLz9Vq/7LFoY2yKBkxo0b4fQtHxP1BaGvkflGKY+yAf0X6Njt+KeymBH5Y=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS1PR04MB9559.eurprd04.prod.outlook.com (2603:10a6:20b:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 17:06:47 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 17:06:46 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Russell King <linux@armlinux.org.uk>,
        Johannes Zink <j.zink@pengutronix.de>
CC:     "David S. Miller" <davem@davemloft.net>,
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
Thread-Index: AQHZw8rr+4AkxJNLt0GANB66N1LNC6/VZScAgAACfQCAAELmoA==
Date:   Tue, 1 Aug 2023 17:06:46 +0000
Message-ID: <PAXPR04MB9185207744645A9064D2ACF5890AA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230731161929.2341584-1-shenwei.wang@nxp.com>
 <20230731161929.2341584-3-shenwei.wang@nxp.com>
 <bf2979c4-0b63-be53-b530-3d7385796534@pengutronix.de>
 <ZMkBCGJrX/COB5+f@shell.armlinux.org.uk>
In-Reply-To: <ZMkBCGJrX/COB5+f@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AS1PR04MB9559:EE_
x-ms-office365-filtering-correlation-id: 8abe8636-229b-470e-b4e4-08db92b1b04b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lefBc2X4tAEImXJIgok1sCm4zTz2W6Rv9PC/Da69NCzmB/WRONa4cl3Pwxi6YNflC7URV8oDBUuMkIbV9om2bbZFfNue//JLXjcSbflyjgd5uFgjYTvsXsceZ4dMeY0r0GRVFBbGlVghCg1/gz69EE55zDRKRuW0Hf/rtr9BN6zGijMOUvdeJYv+I6hfUjrKvlC3CtW5UbftoLfixfLuF4ohUV1mZ9WTFOYabLWGOWGRV0NYmE6mHUSgntrmZ/mbztqDflg1JSRnsvasSg9FwTEnvY9URc/Ym9soX2qA8Xbz4xJJgD+DJMHGkhJPfdhcZt8AjPOMLitbNRXpJAgXxmnxviuG605czIDnMNMxgOY/HLT1/rHcETaG+V/kArsTdq9hKGHs5tPF336IO08DZ6m1BiUDYcUfw/HB8rOSqr2qGYoqAltwTXrslYcv1voSGbQhxZeIfKGFNO9JvgsxLGR2csu9wWHYRF84ev35NYILk6dngIQQgHZY8y8XyeibeztV3hDqn8WG0cFMVszjO14lAsOxI1TKJNm8Cnr+Ui3PxxWqQRz0fFLHWfBSqJfO0cJ96FgzlrfCJHwiGAwJNMb6LKdGVmH13PSZb67Nnf8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(966005)(44832011)(9686003)(7696005)(53546011)(55016003)(55236004)(26005)(6506007)(83380400001)(186003)(76116006)(33656002)(52536014)(66946007)(66556008)(7416002)(110136005)(54906003)(122000001)(38070700005)(7406005)(41300700001)(86362001)(38100700002)(66476007)(66446008)(4326008)(5660300002)(8676002)(8936002)(316002)(64756008)(2906002)(71200400001)(66899021)(478600001)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+U6Y1sCMs6SIDR7T5cbALmQByDD1lcg8pxnojv5u/MJ1QE7fIm3Cytv2M5sl?=
 =?us-ascii?Q?ld6HvwlvOxTFkHc4Hyg1NSmNBdiKIPSd+K6ThRb7C2GpOWVYmPjJxX5cU5dp?=
 =?us-ascii?Q?jVmXop8eWo5K20a4cn1fffURabBTxkn8VpLBLotM4pp7ckMwU1L4R0G1tKhy?=
 =?us-ascii?Q?JG1E8HdpQTS1BLK5j2RklLhS0K8AR53e5sD3AgCBMVzUpwH/POQ1gYl4OPFu?=
 =?us-ascii?Q?5KxGWQEvZcaw4sJCxvUmE0JZw3soQbl92lWcBreszBWtnWfOOp8uuCVwiGN0?=
 =?us-ascii?Q?HZc0NBta0tISdhnkkAZQQmS892ubOS5sk7oJ94YwD1k8z2bA/S02CW5WnByC?=
 =?us-ascii?Q?6D8f6Ub/XBInUIjXYSE4hrni6UdJizvpGxSI9XWZ5ePGR5p6tXtcktqkwcHS?=
 =?us-ascii?Q?gAOTNJaRBmNLdht0La13LwsdVBbcCmABU1Em153LQmbiDaxTR/Wzfvcjc2vq?=
 =?us-ascii?Q?zix59v4JVlozx48Bxf70+l6lL+CV3CI93GqM7teBrW8JfGQh6t4zJDpHf7QG?=
 =?us-ascii?Q?+SpQLfblaBcQmEZAI3/qiEsnO/Z6rRa+mU53UWN06H5ZYVdR6bP69Ugwzhv4?=
 =?us-ascii?Q?vbXrIdlfGfpF6AUSMbAhLsi1mc0icARiI3F0U762vtX78RUAy9tdzz0DsnYc?=
 =?us-ascii?Q?Q5MAO3sljGwonVxAk/fiExiFxCky0YH1T0VAi7woQ/JiVpzTm5FBEEHtZVjL?=
 =?us-ascii?Q?5Y5qCJBGcYZluBiTECAp1o60q9o+k9GVemYse3mQD68lZWnYvnFF4P1YyQSF?=
 =?us-ascii?Q?8x7iFqF3PvHzD6tycC+XywwqcKSN8xaA+cPUn2tf5RGNK33SzsY3dbnATyco?=
 =?us-ascii?Q?Ka6uiapt7sk/jhKc4AchvgTtwGAti0CEf828HRiUezP47JLzxcTw5wjgvq7Q?=
 =?us-ascii?Q?sLMOrXxzYW8LNk2ugSkS7RpdDY1jMI75OLAsY0jIdZefmDRSQyaoD2lUspyd?=
 =?us-ascii?Q?b46z4TydiOg/4Yzbm97j/ForgsKmzJmn//5603UhuoPS0T71yI5QVbQUQsOc?=
 =?us-ascii?Q?NRrwZAclauVYwdI9YPapE1bCWTZ3ppNAOhu0SjTkB2nfI+1wtDmU+tKxgJK4?=
 =?us-ascii?Q?LBxvjQ2CCdoASoISMbsHUqDQcyuLm7yXH0lrFQEoX3AU26P9i/GeLAiAWrOf?=
 =?us-ascii?Q?5npBLPrQCUE53wliKY5jbUAhygO2OoNT32Thi1SXndxByZXXoPH4K4AV4bCg?=
 =?us-ascii?Q?i3JzExYChWoUepaS+j0VWvSUa0sP+u/6fzX/OzH1mG+48HCCgFBztiSPSwLH?=
 =?us-ascii?Q?TJLznrDwVzZzITbM1naKelobjfH6442Bb5Aehq5mEz6FBuHC/3RtFj82n0w/?=
 =?us-ascii?Q?WqhKM+0zXNkH5mgpLVoIFUP4LhV92h0HZwsQWVUFswY8rj2uVhRouBrfcGBx?=
 =?us-ascii?Q?FsBW3pd2F0a+s1unwwiEEWcUj/HZvoW5HiiFogFj+/PJ/pHQVLgjQTdLP63A?=
 =?us-ascii?Q?co74c8tToMdMEElDgPZUG8RP+gXiuluPuUaEqisK1uptB3MkfXSjBzY3to65?=
 =?us-ascii?Q?+XSmXXPmKrsKliRNT2uH7KMfkX9xMTDUDA0MUXkJEwMPA1TZ5MN2Y37NYTc3?=
 =?us-ascii?Q?yl1yUJEz5VGfiZSzonYmWStedc1Yt8lUjkMfHtrN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abe8636-229b-470e-b4e4-08db92b1b04b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 17:06:46.7617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Beof31fmBXRpdAujP0CiTy78Y8aoAByLigSyaqBp9akZ25v8UkdC1Pq+dkjxAYuvbKs8ej3e3u0oAZaulKVcdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9559
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Tuesday, August 1, 2023 7:57 AM
> To: Johannes Zink <j.zink@pengutronix.de>
> Cc: Shenwei Wang <shenwei.wang@nxp.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Maxime
> Coquelin <mcoquelin.stm32@gmail.com>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <s.hauer@pengutronix.de>; Neil Armstrong
> <neil.armstrong@linaro.org>; Kevin Hilman <khilman@baylibre.com>; Vinod
> Koul <vkoul@kernel.org>; Chen-Yu Tsai <wens@csie.org>; Jernej Skrabec
> <jernej.skrabec@gmail.com>; Samuel Holland <samuel@sholland.org>;
> Giuseppe Cavallaro <peppe.cavallaro@st.com>; Alexandre Torgue
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
> On Tue, Aug 01, 2023 at 02:47:46PM +0200, Johannes Zink wrote:
> > Hi Shenwei,
> >
> > thanks for your patch.
> >
> > On 7/31/23 18:19, Shenwei Wang wrote:
> > > When using a fixed-link setup, certain devices like the SJA1105
> > > require a small pause in the TXC clock line to enable their internal
> > > tunable delay line (TDL).
> >
> > If this is only required for some devices, is it safe to enforce this
> > behaviour unconditionally for any kind of fixed link devices connected
> > to the MX93 EQOS or could this possibly break for other devices?
>
> This same point has been raised by Andrew Halaney in message-id
> <4govb566nypifbtqp5lcbsjhvoyble5luww3onaa2liinboguf@4kgihys6vhrg>
> and Fabio Estevam in message-id
>
> <CAOMZO5ANQmVbk_jy7qdVtzs3716FisT2c72W+3WZyu7FoAochw@mail.gmail.
> com>
> but we don't seem to have any answer for it.
>
Hi Russell,

I hope you have thoroughly read all of my earlier responses, as I believe I=
 already addressed this question.
I'm happy to clarify further, but kindly avoid unsubstantiated comments.

https://lore.kernel.org/imx/20230727152503.2199550-1-shenwei.wang@nxp.com/T=
/#m08da3797a056d4d8ea4c1d8956b445ae967e7cfa
" Yes, that's the purpose because it won't hurt even the other side is not =
SJA1105."

> Also, the patch still uses wmb() between the write and the delay, and as =
Will
> Deacon pointed out in his message, message-id
> <20230728153611.GH21718@willie-the-truck>
> this is not safe, yet still a new version was sent.
>

Can we conclude that even without the wmb() here, the desired delay time be=
tween
operations can still be ensured?

Thanks,
Shenwei

> It seems the author of these patches is pretty resistant to comments, and=
 has
> shown that when I was requesting changes - it was an awful struggle to ge=
t
> changes made. I'm now of the opinion that I really can't be bothered to r=
eview
> these patches, precisely because feedback is clearly not welcome or if we=
lcome,
> apparently acted upon.
>
> --
> RMK's Patch system:
> https://www.ar/
> mlinux.org.uk%2Fdeveloper%2Fpatches%2F&data=3D05%7C01%7Cshenwei.wang
> %40nxp.com%7Ce65ab380ff5b4748da5308db928ec751%7C686ea1d3bc2b4c6fa
> 92cd99c5c301635%7C0%7C0%7C638264914150592989%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000%7C%7C%7C&sdata=3D%2FzSqRqJFRQljX6ky3XJvfkMH9PwgOstb
> w8HpEppYOIM%3D&reserved=3D0
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
