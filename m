Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F237CFB29
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbjJSNeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345754AbjJSNes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:34:48 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D1C11D;
        Thu, 19 Oct 2023 06:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPF3gxeqwj5GlY+5zGIuOKmbDiUQI866jEGIu7tO9yUkpIImazDYhG7Z6QPfEIyyUkmPlfQmMXL2FTOUf+YX40lGRUOMLE8ujMQh1MTg7Lg+IbmaClS9ZPGSkECWon74eg5Wj8fQJ4IYVc3Pl3D9uCJqn9jVnFhxpPcka+sPCTXeJWgiVPEmc2YQRL2bHlJKfIC20QK0i/H3X3HBdTeHEcPBZqHHrm8p9pVJPa+WneU3z5MK4+yOa9PAkcKDwr6qy57KYMIv0v5W1p5u/zL+EYO0e+4i+N/K1rlwObPQAzKLpcZIXgLL4/Z6JwDhwIZDqJWpSEc/AgcSblo7HGtQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0kqFBNo98aU4IfNBMZu4u7+sSyE3KNHVRewog815zo=;
 b=ceh141Rb2h/6w+lpRcsOJ/WYKjL3Hk/xA5N7niHAew/9Bl2y0hIg7Mz+d5PlqKBufHurGqAyUFc15b/ebA6mfsVFqGnqaZpQuMGdSdDZ+3vhhwQv/DA3jlYVq7v6TLqSL6HzSeJRITfUSUXOj1kiaaocDaHAvHN6M3wQIEPVQXjuGl9qb1UclubEXesf3yEU6BakioSOwIJD5wE66vyXZNPuODbbw+KeQeIDTJBdg+nprWT9s+NFwV0BpRbc6/XSfOEt0CXl6RYlNvNoDL3pK9oBCT3goaRTFmVNiVblwFSq+goV+Ua+70C5SrWOy3JIifa0oSryYXsUeCZggJ72jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0kqFBNo98aU4IfNBMZu4u7+sSyE3KNHVRewog815zo=;
 b=WZRtvd6u2cumpcMKoRGMOiA0Z87v2VKFW2ZwMNsG7PW+H4sIN+0NP4GcSf/SK7X2DMP+/8GbqAPJ3FBho4O4sMqR23nCOqH0ADPHIGyIGlJSfQJKl6udJnAklrzJi474syLXlZQ56BKDGL9MA+GHTsii7oNDZnGOnf+jICYqXjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7803.eurprd04.prod.outlook.com (2603:10a6:10:1e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 13:34:44 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 13:34:43 +0000
Date:   Thu, 19 Oct 2023 16:34:37 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Colin Foster <colin.foster@in-advantage.com>
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
Subject: Re: [PATCH net-next 4/8] dt-bindings: net: ethernet-switch: Add
 missing 'ethernet-ports' level
Message-ID: <20231019133437.24p5sakrile4ceah@skbuf>
References: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
 <20231016-dt-net-cleanups-v1-4-a525a090b444@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-dt-net-cleanups-v1-4-a525a090b444@kernel.org>
X-ClientProxiedBy: AM0PR03CA0023.eurprd03.prod.outlook.com
 (2603:10a6:208:14::36) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b3c85e-36d1-4705-14b6-08dbd0a82732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3Hwe79EJ6V3FMFlmr6mLa3UiTfB6ftI/Gc1nBdB4bCgszKeyglI6/Mq8uaWfyr5lZXxLdKc6JoRJ9EFI8zvOzgkx5RLw5Jj7MC+rwkFtKyAvPDB84CxJ0ovCVW/YpDZCWA1rsnwkl+jpFLh6Kp3uCl8Za6XWyi1z1DsGINk8HbJ74CU4+PoWTDYBQGqCLn/NDWpm8Grq7mDcymGmik3SuLDq0YrlwbKfHHMg+zAzqlZEq4W9rpHZadUwIbr2VZI4XVWTgDbqgQceZRlwToyzyz38Ld0Eynghbji1Tf23eIQ5jRTSFBvHbH6B/P2mfgN6yiPUJhsgm5jV24f+7ZRSCOKbH5cM/ekba7swP1Zzs5FLwZxeo6GCqZ0c6v9gu7ewnaWzii+ZXpVTKugAztobSWLsjdJwQ3b/7SccaEONryvrvfNKbj4HR2I2RnBMOfwpiZVJrO8F+vsgUBiHuZf4aOwmqp5D2EufdxLdXSB+nkW9FEGoMOGa142ASN2f7KABnxd8OqX68DGQ1UVdAh/FzoY8OiyK/dQXYvmtO6VpjlkT4gMR2Li1Ak3SS4moL2r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(9686003)(6512007)(26005)(1076003)(6506007)(33716001)(8676002)(83380400001)(7406005)(478600001)(7416002)(2906002)(8936002)(4326008)(110136005)(6486002)(66476007)(41300700001)(5660300002)(66946007)(54906003)(316002)(66556008)(6666004)(44832011)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+LfafpbwDlbpN74M6LEv1ugDc8jZRNS5F10A/9O31p0LsC1ZfQFRKvAp+tM0?=
 =?us-ascii?Q?WoZKmO+e+PUvmfKmzg41L1RAVGVRQxpZnY/tpPIPnNRzqGktJ+W16UzrQaGx?=
 =?us-ascii?Q?hGgI0Ml0psPY89+HCaz3Q5pn+6xefKYnF9Ar3goLpcLGS5Uv3TzI87TdD/Rq?=
 =?us-ascii?Q?qK0wn91jpKlTosEDQIoK+g/Bcd1aqlXY8qY0lunoLmIOdOBMLyrNkvEo8JdP?=
 =?us-ascii?Q?R1UnPAHjHcgROFUHLNeu3EGDYN3NuwcEFL6o1jaW77PjB3a52sbHgr+G+ELa?=
 =?us-ascii?Q?RZmex7GX/FP0yKH/q/juou9ZN2yeyHIz4xx1b58os7S7jDB25M/hGqnGGmyI?=
 =?us-ascii?Q?I2GXsNFxz78NtzkeTC2sgwcoheQ2EoBSWieX93hPhx9mVBejCyi3iYsHYUbm?=
 =?us-ascii?Q?F0h0z/kHvB9uo+MSJoWKVJymuXRvGuxgMXWtnenyV8ZuT8LDcccgc7AQXokr?=
 =?us-ascii?Q?8DT38NvkX7ttu/GiF30+Q9VEAiCaBeNt3230OatM+P0tpp9mdMNESNRi81GM?=
 =?us-ascii?Q?Mj0d1vtk8x58D7C2TGXoXsAnLIzB7mMe5UF88mHkSp0huPNZc6VoA8/iJzBg?=
 =?us-ascii?Q?z0+rDdUckdUCSp0ZlLGPQNTeqnjnj7eu49VUZ8iU5SONE8Jpf2iykIb7DlQC?=
 =?us-ascii?Q?54j9sW9U650B3vZvSSWhria5pJR288hwJR5cBOENzD79N/gfLvTxsAVhU4vu?=
 =?us-ascii?Q?Qt5GiGSnYL4SeWp8iCoxkSSYRDFtaIM4xfUKeAXytQHpovtxEaT5AoTHGgHJ?=
 =?us-ascii?Q?rI3jJIChmfQFcKdxyAyqKk36Kry5UOrwipZaHyq3PJ6sqs9TZIsPkkwsaG4h?=
 =?us-ascii?Q?amXc5stSkhRzHMUIsvtde0H8ciYNaX5N2DJNx6jMqom/wM91OAjIZRITu3D1?=
 =?us-ascii?Q?QhzOBLG86hW1Lu2DUDigj1e2hXSqtDdi9hZ5Mm7ai5ro8FhoTfOpymH/8yzt?=
 =?us-ascii?Q?EicE5rMZoiiwT+INk8OWj6owSg+d4MS+GdMJ3nNDi5OXR2VhrsCKDoToVTn8?=
 =?us-ascii?Q?BVJVe8LpBKh9Awdq6x+W1IqqCLCootrmuBh733OqD0c3bOFRMTJ6Dc2KeDae?=
 =?us-ascii?Q?fe7jKRL1lL5FRqD6Pu5V9Op6gA1/eJEZeKta+QJl3qUhu3Dlt/c4PLhNz/Nc?=
 =?us-ascii?Q?WZwLoa8IkfR5rn77n0drqjyuIYGLULg5XXajeMfWCsWyHDnECifbPSbRvwna?=
 =?us-ascii?Q?uKL/D4eO0nMVNxEdXLGkf78YrX6FQ5ODXo2TSbCNGl7RodfPqAin3uRujyg/?=
 =?us-ascii?Q?bpJkbv0jVPbpJu611WYkg9cKz9FAc62o+uj7t0cBcER/1YKKLtaPHA9Nhs9T?=
 =?us-ascii?Q?Wg+j1mHPYF6NVal6vvU+iYp9V68EJtp/2VeLPEmXoO1QxhHAWlaloSghSwq9?=
 =?us-ascii?Q?tDJyWFKW61gUhXudk5X88fPuIhI1J8fZ/5rz7Y0B1M4zppBYJFw8aAP4ECAZ?=
 =?us-ascii?Q?CU9ecSeEi7GwEXT8nLC/TwI3PbdADFPb6Xkr9xsSTlQXTdT4jRln/xkhibxg?=
 =?us-ascii?Q?spEA+q3I5rbHCdWnoTd20SC66eUjVULW2gJh0YpPzg6iTMFWrTWrxaUB9HfO?=
 =?us-ascii?Q?ACR1rRYcSIwgd/cMo5aFEx//NtNeBSzWn6/WSPBsIjg3aZyMDvpvlwsBVON/?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b3c85e-36d1-4705-14b6-08dbd0a82732
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:34:43.7193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdBlmn0RdBfHkXHCatIN6sa+9ifNN/1oGotmTm1+fKMw+OSsW51sUxhFT9G+8AVe+fN3d4YiNw8Ear2jymfhfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7803
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 04:44:23PM -0500, Rob Herring wrote:
> The '$defs/ethernet-ports' schema is referenced by schemas defining a
> child node 'ethernet-ports', but this schema misses the
> 'ethernet-ports' node. It would work if referring schemas made a
> reference like this:
> 
> properties:
>   ethernet-ports:
>     $ref: ethernet-switch.yaml#/$defs/ethernet-ports
> 
> However, that would be different from how dsa.yaml works. For
> consistency, align the schema definition with dsa.yaml and add the
> missing level.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/ethernet-switch.yaml | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-switch.yaml b/Documentation/devicetree/bindings/net/ethernet-switch.yaml
> index dcbffe19d71a..688938c2e261 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-switch.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-switch.yaml
> @@ -58,9 +58,11 @@ $defs:
>      $ref: '#'
>  
>      patternProperties:
> -      "^(ethernet-)?port@[0-9a-f]+$":
> -        description: Ethernet switch ports
> -        $ref: ethernet-switch-port.yaml#
> -        unevaluatedProperties: false
> +      "^(ethernet-)?ports$":
> +        patternProperties:
> +          "^(ethernet-)?port@[0-9a-f]+$":
> +            description: Ethernet switch ports
> +            $ref: ethernet-switch-port.yaml#
> +            unevaluatedProperties: false
>  
>  ...
> 
> -- 
> 2.42.0
>

Huh, interesting.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
