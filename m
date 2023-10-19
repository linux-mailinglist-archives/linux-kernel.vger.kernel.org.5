Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C0A7CFB38
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345997AbjJSNgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbjJSNga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:36:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B69812D;
        Thu, 19 Oct 2023 06:36:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBNjechRUsnrX/7iZ/TZ74mWiFDOAsFGjDCJOOX2kRklqLr4fedbembc/666xVE6GCVPx5Jm/nXCQ08/65IDBU6CRKMIqM01Zfru1mrTostsk1o9NZxS08qkVJh6d0/HBiVYQqSxGsZGaHKPfGYl66gCeG//bMu5AGisAla44cXVYicz/v9ULXddAEielsBvOcO4PHjPX8hleF1R3gZE5LXo2mv9iIipPnkSKFJ77Q47zFpJtXw3H3heNm1YSzelbLZP8+2OYJnhJUFgVTlDjZYNbwFadWwIb6ABRA3OHqdRu+6mL9UgIpvX/6HNH/aeu3bWkKupJA5ka1XMagdvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PONue8UcLImYw9/OV6KD1zj/x0gRWxeBq8+/kT/3cA=;
 b=FKnFgi7GzkyHVxJf2AFMqm4v0ekqO7MrcJzvLVRDWi8Luqs5LNvbWZXlqdf0xts2v6WOliUHxzjVWDp+t5uTKOyEWk+qG6XL2cgiG0uo4bDwGZ4Q2pBQRQOtZCKBGICgtdhhW9tr61mUsfpR+jI1dWWJay7r0xWuMgPTb2Yd8EIDGm1ZEITBSJE1NwRMKP7XkDwVmzFmfgIOvsGAM5FdW4q8VHtlm+OTDpUtqSPHnVRRKTZekWXaBUVQTUeXcVargo8e2AqFiZOSvuSJnAL5wefxA2zLRTOPUmwTsxXX7qJ61EcHvdxBn0K4ygi+QTpUJJiAYx9vTMbvbZCUOgPlQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PONue8UcLImYw9/OV6KD1zj/x0gRWxeBq8+/kT/3cA=;
 b=Y/CTVNsr878iPjW+/WoXzW5r82sjj0QltPzP+zab6khWqxDqyAJSimgRzrOTp1CIixkIt4BS8uKoYYpn1nq0SNRq3xBml5KBHdR0NawrgxR5HlRHvoln9Ho1gkL5trZUdcqGocJp7UwLtbp4d4Cadg5iZ+LADkkTZ8w1qJo00B4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB7654.eurprd04.prod.outlook.com (2603:10a6:20b:290::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 13:36:25 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 13:36:25 +0000
Date:   Thu, 19 Oct 2023 16:36:20 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        =?utf-8?B?bsOnIMOcTkFM?= <arinc.unal@arinc9.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>,
        John Crispin <john@phrozen.org>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next 5/8] dt-bindings: net: ethernet-switch: Rename
 $defs "base" to 'ethernet-ports'
Message-ID: <20231019133620.eiii6acak3ihr5j5@skbuf>
References: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
 <20231016-dt-net-cleanups-v1-5-a525a090b444@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-dt-net-cleanups-v1-5-a525a090b444@kernel.org>
X-ClientProxiedBy: AM0PR10CA0022.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::32) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1e6c7f-e943-4cf0-735c-08dbd0a86411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MsJ114EjNvyntM+DwIgaW7NAaq1Cwk/JNK4ugIPnKL4v42w2WW8zHXVYv3OYxE6i0WQ+Yjw3Ji+sBQxIsozNHnAnpZa+s4pid01JmxzufSPMZebEqdvc5ujG4sOmRLmHHfLooa6OYCGnguy6IcSCz9/S94/u83PP1DPP6e0YGekubGrNhm9qni3OPUG7xfb62NuraXpHDJ2ZuUVc7b6fKPdodd+GOw/RIY0Aydx8jnX29bC0eGnNyrPKc7K409bC/HOeFJ6ywYVbQxOoYvgg6nYC3cw8LHnslxTWHmK3pKl6D3jiGvX+Q8cJnqlwAeY4PhfZWw6Wapvz7IU2ReLrFsx2GopwTqIu+SkwSc2oVKxpo+BAkndsLV3cLSYAHb8y85z/Z9+U4huejO2hxy7mYy6DX0e6vL7GfFdPnCsZ1QhRvwwHESKGZK1VIDwwknECRjsq4UP2N/2W1u+yPCSEXH58GQceaqOuRFpwTpPiLyozvmXIMan8luM5yWo0SchdjjHsQtDeIXWIixRHN6lnrOs9eiUEz3fHEnmVz9BajGkCTo/UhTwN+NVmeKEs0Idt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(396003)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(86362001)(7416002)(2906002)(4744005)(54906003)(8936002)(4326008)(8676002)(66946007)(6916009)(44832011)(5660300002)(41300700001)(33716001)(66476007)(7406005)(38100700002)(66556008)(478600001)(1076003)(6506007)(26005)(9686003)(6666004)(6512007)(83380400001)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TIuaPNfzr2cyMk1AQEcX89E7k2Nnlvq68ifmMyZBHvd7uFOwmC4VWpI0pRYh?=
 =?us-ascii?Q?XEFwiFqOcH1Eq1xPKM6E+DD+qMRutZI+TeE3oIacT3kTKypd1aUKczydxzZo?=
 =?us-ascii?Q?A5w+//1i/Sqk43zGNsHbRn2nd8UAzPXkFZVLapbkE/keZAuHUQs64m3ytDBY?=
 =?us-ascii?Q?K4etXnfxt3OBp43kQSBF1St5PC5ljmUYO1P7ldujenh1TB7qcTe5mqLW+4KS?=
 =?us-ascii?Q?5FvwGZk1XBzorn1TWXrdBVvW3WzugEfGc75cPF9ZEKoJ//kS41EDl/n4J1/J?=
 =?us-ascii?Q?DsiXbyfsow0WXsHPytpQlIM0OZGleAkpl06qK711Tm5yjqBWo2t6+8Whk7rw?=
 =?us-ascii?Q?s/q8kTuAHVXugswdWYgafESX0Ws9Lf0NJKfsANLkOKO8E8b1CYTi/t0G8hgy?=
 =?us-ascii?Q?XFEUoIxGkxAyqpgSUvLbyijCSf7spwPaO1Sjq2Wo9H8qwtMg/SZfUxMgEB3Y?=
 =?us-ascii?Q?35oWUv0D93VcdkmKWTy7mNFp8PJ379mu+554k56oAkyd0MBF73Za/neb7di9?=
 =?us-ascii?Q?z61005g08muWnRvYvzvVyGQZkfnVjaXBeuDy5Ll466+C4BYhh7k3ijNnTJ+S?=
 =?us-ascii?Q?AL2SeIUqgLHjqxLQ1dXhrNnFR/JdpaUPk9yFqE/BofCuLZT3ozBZVWuqOVax?=
 =?us-ascii?Q?1NI5gI79KRsRJ7QFKyl3Ww0zLG/V8graiTGJLJeiNSwlZS/q3HuoM3bOV/SE?=
 =?us-ascii?Q?GyVo3S9LVdVxyVjVImosejENK6VSPvLfqc7pgwO0enctwec6XbRVTCfxKH72?=
 =?us-ascii?Q?iyKMPKPpLA3C/5TUrMUQ7iW97f13VDwfkEysaC/aSLcUks7TWjgAKDefGbEt?=
 =?us-ascii?Q?UOqCXigJFfo3+KY2+BTMOEX9+R881hlKX5JCnF3uJIvgFH3GHeMmBcjMLU2j?=
 =?us-ascii?Q?gG5eEvtvs0jl0NXG+fTO8kwNnqdrUlI4/gmTnKesczBrDntspYnwRuwBr/DJ?=
 =?us-ascii?Q?OcP15cSU6R3lvtY2IZC1rxoayaiHtEOIfDvVkIiyCk6af4943eWTpThHwgl5?=
 =?us-ascii?Q?8zTDGx596C6lP9x9SZr/axUEbqnejL586IrptJugBZeWZoTNSreN2VW8rm7i?=
 =?us-ascii?Q?zhkQYQcyu1rOWyoUai76G5SgzrdHQ69mhw41l5EEu7Vczwojj6pXOyarg4dN?=
 =?us-ascii?Q?e1s1yPk7MRW6XaQh895C8NEAr7rBxYcR7oyn8mqpBtJBiJlx7KCzUoR2dlCp?=
 =?us-ascii?Q?RAUtP9y7cgXLYxgMHJ6kav1rfjMq0j8+JMXAWNK0cDYjY83kGAw9Oh1tMt9b?=
 =?us-ascii?Q?vTvhIUblSBuQLKX0CwIwyuQZ5DEV8FUbF8TTGGdR1xzl2KUtyS7rkohS1eky?=
 =?us-ascii?Q?mBQ7O0jdcYenYr/MNlz5XKh0Eh6U9nSMZ3+Lgo86MO4ckTUtcQHz0+yLW9Lg?=
 =?us-ascii?Q?Mk4ZiXt00bGotN2e8p6cDXkMgBhHayjyxvxxOOQCAT8H0/g1C2G72pzQBU30?=
 =?us-ascii?Q?PIuNmCngb1aWTOy7fIBcii0f9/YtMQdRn/+XMxDnkoZtW+JkvFdfX9xQatfH?=
 =?us-ascii?Q?trZpGMuDml+qbosgi7JIN1GzdHU38tg837neF9kZ874EhRJdc7PHQgG+nC8a?=
 =?us-ascii?Q?puGx1U8pBsaX/Grl6wOR2IcErW3HoELirVMA998bdq4xw9hmXC2SA0muYX9G?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1e6c7f-e943-4cf0-735c-08dbd0a86411
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:36:25.6710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CH1UwV7fvyB0DGHR7nTpCnbDLw22UtcGwJp/uyCIwnG7uv1D9pHK66nMAFSgBlTuPdg+0t+SeuYZ5YFJ6hQpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7654
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 04:44:24PM -0500, Rob Herring wrote:
> The name "base" is misleading as the definition is for a complete schema
> definition without additional properties allowed, not a "base class".
> Align the same to be the same as dsa.yaml. This schema file without any
> json pointer path is the base schema which can be extended.
> 
> There are not yet any references to $defs/base to update.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
