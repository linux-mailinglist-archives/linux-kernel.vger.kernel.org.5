Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F087CFB8D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbjJSNsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345498AbjJSNsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:48:13 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EDD132;
        Thu, 19 Oct 2023 06:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBznXgGcrISXMlJD3F7F9Iwh+SIMF3PJA8DF0axvAKHINyW6aw4/nvzJ9fOt5WGTw2oZ+hFxEzHsTH5gSaUzNoGMo2a8bE17wPS05JTPIwGQ6CCFzbtvsl2ow1dkTfFaEl6fFpAKM38jmLMW9h47lZVNmtVMgr2tnRFY4ShCUTSsb9EJjOJVeYpffYnttKzd/rXH22CZrcLLO2mbkBLS/M214gfDRT2e3ajH23QGdgBGPcsvicBDlEklAMNegsCldsiZU0DNJrWsx5Y/9FlkMQesn/VVAEZp1AfkRMxhaeXH2TW+Le5XkPDdU+AZm7alxEqGz1vPi1Pwggck9iq7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0gYmAfPXi2HJqFxyKJxdZy+ozriObt4quTN/pgqNYU=;
 b=imb3OxHtlD3+hsH07IFanU2Kc+DGcOFnILYzaBnpy8DY8TGC6qDV3XjRc1qMAtcaHb7e6EIT3IOR6RRcVceUwnQ8fzZLCFezveRRa1ZtzoVzkD2ZFMnIK75JllMWvfEqdxBvnVKtrv6iuSKo/kOiDH2QX711aVHrBT6Cw/ISVUOyoJV5OqF+bj0xJ+gC+EenD8jqgiyTEsZLHiHiezCseyRoeXqnE6PkRogrzKgyZz5DdYuHnJGXNYcm/kDCjMnVo64cfOfep3c0Se7Mp2l4hx+Cijt4V+UEy5KDISEYb5L2RS39oKF691I3vHB5x/Lo1Oa2PuRC6d4WCl8YdI0PJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0gYmAfPXi2HJqFxyKJxdZy+ozriObt4quTN/pgqNYU=;
 b=NFMmThReWW8q6kuEW2cvQdPCMI+FaiNaEHzbokM8PCr567FaDqLA20KKxSVcEXsgIZzxBRHp9TsR7M7nTkp1B8t72vZwoOPUwR6SrzwTWRKS9TImggRGsfCUpfbuxNX1FgkihjxPDjgz9CqjY7H2AlHi8CDtKuHRcn8Wi4ri3PE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8425.eurprd04.prod.outlook.com (2603:10a6:102:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Thu, 19 Oct
 2023 13:48:07 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 13:48:07 +0000
Date:   Thu, 19 Oct 2023 16:48:01 +0300
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
Subject: Re: [PATCH net-next 8/8] dt-bindings: net: dsa: Drop
 'ethernet-ports' node properties
Message-ID: <20231019134801.v2lnum6cfov2w7ft@skbuf>
References: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
 <20231016-dt-net-cleanups-v1-8-a525a090b444@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-dt-net-cleanups-v1-8-a525a090b444@kernel.org>
X-ClientProxiedBy: AS4P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::6) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d124ce3-5b57-472b-c62b-08dbd0aa063d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufasFI83i175TgubElHm65qtFm3mZN0FmIZ3Y363m33XN8HoPkQH0NBNqFQRuC8XYG68A4QA5jHB3UcLQ57qu67gRSE5b+asGfA9FnJsQ2oR45DwfhD2z3oYGIYX8TQQT1kuZF2c4+kgyoRrDvIAqbRJDQD90urx6JyLu4SYNfUJGlD1qoiPu9akBlzw90lXjrwpufVFnZ2MuWpqK01D4aYeTYuPniJkI+AYvFhO4UBs6ToAsxfbU+ytNSmcjJy4P3CBMN/vQHNOd26IsK6AeWBd9FjHiEMzRqcxcSzLS3ZgMgtOqVHzGlY3WMuVv6uWpsIw4NEYl/RHz53GZYBitpYf+eAsGq/AXTrKFAwucnk2G29V7uR9Use6DnJ6prgMwStEMwVyXUFQPR9Ehese/SP97FjwACRD/RVRRjH/YF2o1eKFfXo+uVkePXdJ9geBOiu3TziYzOoT58vaePtKVKZp7de2R8m1uLIQ04Fg4jidm9PId9UKhcAPi9pN07D43C+Tk07TPVewOKqA7az99WpfRI/sPJRXkHfcdqVTsZxXw3/ggGUS0R7xo19ni3Iu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6916009)(4744005)(2906002)(9686003)(6512007)(6666004)(1076003)(6506007)(86362001)(54906003)(66556008)(66476007)(66946007)(6486002)(478600001)(33716001)(316002)(38100700002)(7416002)(26005)(7406005)(41300700001)(44832011)(8936002)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V7lu2ROE9tjFWQooLcin+WtvwIQZIdviUILab2uXScUN0+Dxk8OICx56Lhuo?=
 =?us-ascii?Q?z3FGf0+ErdS9hSwiZBHy2fPrF8q0c5LzRVDlVKHYmM9hINcc2TmofmSfmb2a?=
 =?us-ascii?Q?ZkIGsaOHZ0ljfYNDRNhvX76bTeU1wRwA92jkXqytda6YGxdMn7KyvunwDKhA?=
 =?us-ascii?Q?kgYUd6Rzk5qrKwVzldw2fnzYsf4eq8QurYGWnkp/fYYRA+11b6ZHLCV2EX4q?=
 =?us-ascii?Q?Myt5SkLW7m2QokdPx+v7ug9sDWGtRO5fm5Z9HSkyCgPS5G3C3SrRTxTamQHZ?=
 =?us-ascii?Q?iQ5X7uB9heI0rxgISwqYDowBrXrBoKRLjdzDsbKEG7vng/4y0R8agauggpwL?=
 =?us-ascii?Q?Pty//lxmmw1u7BvQJDhO/+udHx8oIARJBooMdBrI0/TLKgV/jbrM/CqsTYAs?=
 =?us-ascii?Q?cNSOZFwnR2ZAAUuQfFuBAuXRuIqxxsM7m+zSr46DScXRX05FhMGneChI8R7O?=
 =?us-ascii?Q?xjr1A0/QW/I7+yoUy0sQDrfqG5AT5/szNYFz+zmScNBhcDdx7Q+ojzAAn9yR?=
 =?us-ascii?Q?iPVxuCFNIlVnaFkh/E5BD463lAqbL3ulaUIp+920Nj9abOVv7TWLGC14RUy4?=
 =?us-ascii?Q?biRGwfKG94bya/PZ6Y3suc5RrELF0RmXKyyLP5LItks+bwW2VVMQtVMb0lSF?=
 =?us-ascii?Q?cuwoAKTdufdphgNxFss8Y9/k40N+QsGcOyRk1MttvzqUYz6eWGOVNc48ZlvC?=
 =?us-ascii?Q?zV0IKKyIkpEYY0NxxcxgrvswuqEmWe/QZd/UzsTrqfadMS4SZA4Y8WF+id+Y?=
 =?us-ascii?Q?MYmjkpPIAYQIONPs9T/N8VlpgE7hKIbMh7DnHQUZhsg5a5B8vdphfWnnuNCg?=
 =?us-ascii?Q?SzlFmQbhC+ThK2gZZR0NZz5HktoZAY2K3eCXZA376wa+BQ2Xk7vvK29mx83v?=
 =?us-ascii?Q?X3KX3laLmIEnPn3NHSQyyHhIrzBhlPKGytjEkTP82ui/1MCNR6WFaM22FdrF?=
 =?us-ascii?Q?qqUhJI2ZpvfczcYtkemUoTDe5S7s4kkCApOeC74q/0+g4FoLaqwKlrJvpwuL?=
 =?us-ascii?Q?ND1sukNaBa73sD9kKkhE4Mi1fKNnFCF3lyj2+KNOZSX2QrhyR6jm8ZMHbcsK?=
 =?us-ascii?Q?gJwkNXg9FFPaCtPhFofbAQbNX7SsRDQCPCUMyvKrR2meB0beKy3UYGlodpnm?=
 =?us-ascii?Q?eEAwX2sp+NZRcas6BxMR11oUQu4pFrw2q3Ua7/KIY5RdIg0AD1GpqiaRjmhq?=
 =?us-ascii?Q?dQk8k2Z/eaeyHCICsTtqMRdpp1+pvaqtgQ+lrP2coWIsQPR+EfCZQ/86l8Sv?=
 =?us-ascii?Q?pbKh3y5ZaafSkmSxv7OW96iRJVRMIwzVatSRY1Aon8Oqi1nzmPK5nyifU95j?=
 =?us-ascii?Q?LMbdNgsepMeO/cf9A57X1bpz9cStGQsYblvprl6LHBc1FDutjbmRFwv3QlZI?=
 =?us-ascii?Q?XXCBtVCai0gnafoi/7krnTlFXeMClKrGBBUYcHqTbzU7eKmOsn7yLPFaShT0?=
 =?us-ascii?Q?ERFhSPJSH8cPnKf9tYLdil/TjkYv4thFlfqPXnNkO+KY+TwkqSGv6f+gaYYl?=
 =?us-ascii?Q?YVGUuOCVrq9EE7m5hvO7fTtGoHcyRU9YYxMPuSXxAcm6OipcEHZmSnUPrEdV?=
 =?us-ascii?Q?BRmn5pGwUcW4K/cAZgyY5Aa+awD3LPBS7fUPRIcmpc7QxRYJL4ohf3m4zHcs?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d124ce3-5b57-472b-c62b-08dbd0aa063d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:48:07.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ee4qizBDz+SMyA7aDFtUqGiosRnqEkfGPikgIgTEvJ8kBFtyP7MnBce3jlVQY6YrySY49ex67jD4bU7iJsc+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8425
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 04:44:27PM -0500, Rob Herring wrote:
> Constraints on 'ethernet-ports' node properties are already defined by the
> reference to ethernet-switch.yaml, so they can be dropped from the DSA
> schema.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
