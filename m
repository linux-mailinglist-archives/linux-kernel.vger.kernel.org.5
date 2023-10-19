Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C98A7CFB86
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345681AbjJSNqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbjJSNq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:46:29 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2050.outbound.protection.outlook.com [40.107.13.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E549B;
        Thu, 19 Oct 2023 06:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmjwbw6DTfZEgKME31vTJRDVTGnFBcmHtUkgGA/HXJDwyVdJc7HaLifytS7mP1NEUmOlwIpPUuu5RUyt1Uh01c7F2u0SuX24Bxc9Yl9tqY8ZbOIWpCdFVeEUaNt5Euk9rzLaZwJAL2XKFpDPu6c85mspGU3dLGzXWHG1aPkwzaMU1AsGlfaOPPy4uLWSD9aqu7Q0hqT4S8OBQBA+V6C91y/kHFuEsE0FoM8iUG7gaxWwX4F5WCERUArSPUVjUi9B2lJgmottpQbGrPjCgKCrZb+kpx/cZaJbpgJtT3GnH0/BpuVje80iEVqfI5/8lsA1qwhDiaG6i6YlcIhr62L06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3mwt5nw460vXINK+wpi3SEgSSNYict5iHn7gFHWn5Y=;
 b=nOqcymUDO0s/gByBV3VVzJqIxt+6LVaLrfLamBHtXeEQUWE1hvxC0R58tiQHFPn/Gm+ls5yzq2BuUAeMx4Y8qQzHnxSxKXfx+kf9yO8555KFCnx6CBQdvHxUMSzOPS5MgSYS9oO/TVfSarlMheUtHhcMF6An10Engrdg+3AJPg/vN3xzPeVbB9ho/qoox+vzZqEoW7JRDyosLlyt3EcOt8V6itjyLNAxTG3B15H7o62nYpMsX6XKI2uu8H1b2gdmjp3OtdqKqUV1SA0Y0vOb0KY9g0l0I5Ktjn5lNl1l6YHip38jw5+257vzUrl8OVpUxCWFrgx/DnmBiJlhsU6sPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3mwt5nw460vXINK+wpi3SEgSSNYict5iHn7gFHWn5Y=;
 b=WEZZqTK7fGmLvVnHu+HL6KBUwvR69/vbZuv/x8d5DatK+VXbJLwYuyT1k/lwAY2RV9eM6NIcxs91w5GDAHV6BGBztnErGgoYX1fXqUvGLIK0gJhAeycsjsiHBRmN+655NpVqqZ+3DsPY57XXswpngBuveRfKd9qrwXFYJ5eR4qU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8201.eurprd04.prod.outlook.com (2603:10a6:10:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 13:46:24 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 13:46:24 +0000
Date:   Thu, 19 Oct 2023 16:46:19 +0300
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
Subject: Re: [PATCH net-next 7/8] dt-bindings: net: mscc,vsc7514-switch:
 Simplify DSA and switch references
Message-ID: <20231019134619.p5avpmsbttzhfmwn@skbuf>
References: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
 <20231016-dt-net-cleanups-v1-7-a525a090b444@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-dt-net-cleanups-v1-7-a525a090b444@kernel.org>
X-ClientProxiedBy: AM0PR02CA0102.eurprd02.prod.outlook.com
 (2603:10a6:208:154::43) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 37df4bdb-3170-42ee-cc41-08dbd0a9c922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4I+XjfK8/va8A3mQNTESEHqAhkmPgp8wA89IiC2TVP5uOVEAU0CNzX/gMCX5ZLZ9X1J3hiSAp0DZE3w1wcYpgb/2DDQwtEMtuoD4VikIppxqf0nUhOmRRwMykYqHPnrs5i35wwvWJVsbcPAs8bGLtQASDgQ5U+LeOsldOqKr83boa0c4BXx2WS/CJrI8RlK/BTrpt/LMvH7JDmDADIhefPBnn2RJJaqT3vJTlVMLBMQGxCYrR5R18+mQDrf+L/Oj1N6PJTGOSPuTqPOvnHc6Cb1JxDmBH4dVAapRsdPAgCXrhf0OnC70tiAo989uUXhFUuJ0yP0RImXuQdBDyk0lZcyhbuDfiKi/vKoujgOvPnf1/aVS+s6PPe/Jq8dj0/Zu8jdw+5OK2eKr3ajlZxYU0q3tYF0G/6jUHfLYzYkc62owIx4g7YPakKAAwL9e7QTi3FZX8Eyu+xKK686cvX9JNdgDxEGdFtrpYDST2cKyjulw9BO4NsLAAMOLTM241b+hFRitnesLUU/dhqzqbz2LjfeSgrqJMfVpPuwsZrBK5aeuVhyCAm7ZexUYXhG3fhf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(396003)(136003)(346002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(41300700001)(38100700002)(33716001)(9686003)(6512007)(4744005)(1076003)(2906002)(6916009)(66476007)(316002)(54906003)(44832011)(66556008)(8676002)(7416002)(4326008)(5660300002)(86362001)(8936002)(66946007)(7406005)(6666004)(6506007)(478600001)(6486002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sXe6YNxFcBmKZ4kvtnKPs88FXqKCEP6RCoWKSIPpTz3akTLLCxrhRN8hqyKT?=
 =?us-ascii?Q?8PPc+tIt4sjf+oe9iZ8Qf54e5HBScVZsA8qLCbrLM+xVCuI5E6tYB8d9nmZs?=
 =?us-ascii?Q?xE7VmgGJYonFwXlXyGRLBqSmwnSg/PXk44tdUKH752i9vfL0tsTOc+bhHiDI?=
 =?us-ascii?Q?wdMiu3XcXvgfQYFlxLGjPI7PtKjx+ncMWxKwzBYhbHAVtRYCgQbUDrSJv34y?=
 =?us-ascii?Q?oa65AmVPa3VV9mkrIdRaPtAHlXI1Ax9Q2xqrXxdssbY38xkIXPARBuPlNqEl?=
 =?us-ascii?Q?0hmOR621HvK/zEqp5BolHTSlyuOXtYwbH9hHGmSXkXC73zpbOeffs69bO+ER?=
 =?us-ascii?Q?uA/8Whu9KixzE9HcXUVsKsbqjwnftAwXvWyj1/oWVoqeEvhm1yVvbFYVUWyn?=
 =?us-ascii?Q?cIjZsPMk0jznE3Uv1sB7YsVgx1+gTt5MUDD9MQF2NHvRE6zQTMrXMagwTQvK?=
 =?us-ascii?Q?y5Qr/ZuA+rR5ULpkqd4lHW1pqhXT7daHR5xPXTSJJ31+L9Ber0mDYtxpZ7Ie?=
 =?us-ascii?Q?O8anutglECmFugJmpdsUR83wF15KH3kodwV+3KIiEmWQ5ntxgSmllUZRUuBr?=
 =?us-ascii?Q?yivgqeZMdAVopv2rk9T0w1cEd2ea0K1Fg5gZbCSzjeVsWwSOXsVnduT9g9BC?=
 =?us-ascii?Q?3OHINCFQnha/3cvBhHYGPTiy/CJDTeJi7d3P1Vg0K2tatG054z1uWjJ4vHep?=
 =?us-ascii?Q?SwaoL0J+nOV1ZQboaLIF6vOm1EK8cZDQ53XKEaXsnX+0x3p3Mf+gm8tTkYyE?=
 =?us-ascii?Q?R/cUJES652AMKAIdEJu2hOC+66qS5FuqwRGucth2T0aKQM0UYVdINrrEWxPj?=
 =?us-ascii?Q?Vd37I7tcauWf77kyixQmTdNyfPCYC3UUlxacrV9xaPeUjF7Mml67QkqEn+TS?=
 =?us-ascii?Q?v6uG4800ZtAt0MXOTlstECGekP+JNUN08ZTXH9ZHG5pTCVivAlPzCQlnb/8f?=
 =?us-ascii?Q?ZoKkWLJeIHRX/P3mXaP0YQn2RZzQoQm+N7YkGwDCVdZTDBL4EbBinFefcwTR?=
 =?us-ascii?Q?PK4He9iZHvVNitOIKmjwFWev4q02+ORmnaLkF225YyZCulW7t6yhhc/rALne?=
 =?us-ascii?Q?F0oQf1kdI8VrVtdw77FrrVoZkScLwv5WPgThl5d7CA+B87Grn6d0SnBOlypV?=
 =?us-ascii?Q?poSqGD0A4/Ycpsf/CLq6jsUO1pFsY0nhxJIJd9gP1hC+NS03EV7GaJASlLMc?=
 =?us-ascii?Q?smxn/eju4QbiZ9flQK++LZ+4DeeHGiZ6dsNJWbDTMhXcEqSxJ0UL1qAEBgxm?=
 =?us-ascii?Q?rvU5RrQV44tjonj7O82FfMm02s+7kFQFMEhKNlBfxnep5evwTGHPwOAZdCRW?=
 =?us-ascii?Q?hMOEZFTBEyCh5mmNOVkJM9gOAqwOtAbsc6n0onZBLj6Hqj4aZV5RpQtycX4m?=
 =?us-ascii?Q?K1J1U5DG7iFbr64on/APY2YRYFJvIhWuVOkNCMXrrCaQ/l//woRbw/lWUHGW?=
 =?us-ascii?Q?Jvy8Mnd59Q0LxcPE8x/REl1dkkioF/4WTGH916k2Xks5kzpPJiYwsuYDn9pD?=
 =?us-ascii?Q?uZtopudAslQuH/NAbErjfvfn26RkOuN9j05dmPHAUSUsZWJtPb73WM+L/U9X?=
 =?us-ascii?Q?KaxTjNreT96tz0mu06TBiCiAZcT+Dl7H9az0ePavur1GsSCO35kAQ6idm9NP?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37df4bdb-3170-42ee-cc41-08dbd0a9c922
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:46:24.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrCNt1Ve8mnVwE0jTjmsxd8+XGg7dRFGV6zB/70dcmNQaKvhKpfyllk2b41rfSFamHCnOg1uQLtw1Hg+X9SY8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 04:44:26PM -0500, Rob Herring wrote:
> The mscc,vsc7514-switch schema doesn't add any custom port properties,
> so it can just reference ethernet-switch.yaml#/$defs/base and
> dsa.yaml#/$defs/ethernet-ports instead of the base file and can skip
> defining port nodes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
