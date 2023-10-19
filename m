Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855067CFB44
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345871AbjJSNhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346038AbjJSNh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:37:29 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E6F189;
        Thu, 19 Oct 2023 06:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+D7vQjQ3sjXU5Olh+q8N1kbUEivK8qLzkf6YVhmixG/Hfaza+Qq5znJxP3/7Qe8/FEsLFnHu7AIhMHZZKf6nTdS6A7LoaVEuNAlXvkLJOIqvGyScTriLw23hwrRHNnOcuSj9b2eKmtc6/uDOvLaciRZKYZOR3EdPt5iPHKn4CPQKVf2+lJ8HvhKzkonhcRldD1aLQ9pwDTEE86zjopwO6p+gNwF/WQBwPGWebbk/PUVvC/YTGBmq+Zok3DroGG5GHkfOYllHm8VvNJOcqvUuuH/CGYAlPZOmeU+m4HXA5fYJtPUBd/R9fBch5ji9J4M4bHmcOE2HRsDUZYefgOecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZYDskkM+3xrKpRFklBOEFZMrJLxAwO18NQ9GwgSzMQ=;
 b=mTQ6/w1yp2MUqArNIJ3/xLz2cBpuwuOxrD7BIQpyDlPAYwsP3qYObkzkSlpCZNzcS4mDpJm9f3KIx0S4cluP12LQ8Bq4Ta7ZPiyrJAjBQAeTIuuoxS7aW0yfoSfbIbXy9Lqyq7DTzmlZOoQBg6wHzLWHhhr6JQFc2rkOJHsC2ex08/WyxUlsZnLJU8wfzSZIYtTUC0lp2s2SBa+5Gv/eRG67ovOqEZp4BWnYRJwgwM8QfUYDCdvpfphi4hhwcEreWf1ZGBiVhoAw1rip3FuwdEb9Q+bGspKLGJFSrbxKMla34jq0A3edyQHWZ+oauIX8KQyLL+9WA+Xcl0WlZa2EMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZYDskkM+3xrKpRFklBOEFZMrJLxAwO18NQ9GwgSzMQ=;
 b=Hizg/8dh1o9AwGWN8wKLO1kYut3wYCPztRF96fwqpRhUhztHKbFxIiewc7R1lUSyi1gus35sEIfsSj8RVs+oS7J51t33mNGAv1bbhHCFbzPJrSUagAF7FHQl67l8YZF7ABk+Frz3mygYB+7c3XMxhrEFW7CARf9LilHz18ob0KU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB7654.eurprd04.prod.outlook.com (2603:10a6:20b:290::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 13:37:24 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 13:37:24 +0000
Date:   Thu, 19 Oct 2023 16:37:19 +0300
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
Subject: Re: [PATCH net-next 6/8] dt-bindings: net: mscc,vsc7514-switch:
 Clean-up example indentation
Message-ID: <20231019133719.3gldtyqbptqr4el7@skbuf>
References: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
 <20231016-dt-net-cleanups-v1-6-a525a090b444@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-dt-net-cleanups-v1-6-a525a090b444@kernel.org>
X-ClientProxiedBy: AS4P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::7) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d6b6a4-65bb-4f21-8e32-08dbd0a88737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBklWBk2sKE3BU0TIpB2WX/UHcYPjPZFNZGNPMadBRkhHtP7Pf/leLtXwNQkVvmvhz05Ky9/NZKbeP3Kqe7G6e+9zhhozo3jU+Fc3l16NCQFBTYnsD1WlI/mq/UYCMxv9hUrt6NXAmvE4u5XCyVNq8ZqkCBSsZcj+ynpPDF+tP5TfxG2A3SHjfTuDudA4fY5fyfXQqi5PUZs7CicFCJ3M4itNcqEUKeTkiCEOyMtxw0AAb7P3NZjK2EeZka0CvE7P5j1QKztQgsDGHuOmS9wbVcBY58U/bXk7qmOFBrTne4TG3Eg6qqriRNIZcZhMtzdv+Nbh5HhHt/AHQMW5Cc8KqoRVNnOXEkTPWLFgZBAuKxa64upMuBuc6kGfOMEaidg1HrGammBU9Qya6zTsfRJ39vdb5js4dkwrPHlNqNojeBBjlxpRhg06cAewkdYivumKHL/M+KicPHwzIbKqHlPRl50wk616Bgt8tJLP3lr3ZLQ84JquEFRqM5ME4uQj0bLSaCLYijXtTg7iOYvLAivqsLU7YU8pJbNWMLDIv0y/hdx7xvEQ4Y7XJERefWBXiEK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(396003)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(86362001)(7416002)(2906002)(54906003)(8936002)(4326008)(8676002)(66946007)(6916009)(44832011)(5660300002)(41300700001)(33716001)(66476007)(558084003)(7406005)(38100700002)(66556008)(478600001)(1076003)(6506007)(26005)(9686003)(6666004)(6512007)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A/VOIcgQofWlBJPbtC0pFdcl2W3AlPz4Na1GV4R7Ue9huYtjTTA0JDU8/Ccu?=
 =?us-ascii?Q?FVU52OF8NzB9eb5S9uB+4JZfVjauSpr8pJIN4FuAkmi/45RSQmClWWISfX2O?=
 =?us-ascii?Q?pvu91/PWzfkZr0Rg9aSwEHkNtWnjbhsC9zRJdNbI4CJrYaQKir71gdYKfHdB?=
 =?us-ascii?Q?wfqBakGPcbgRTesAjWnQ4MxLvyhT+QfFfgTQueHuDwEr6cR4Fu4hkaOYKpAq?=
 =?us-ascii?Q?gNN+06cf5wokeDDBTYWxtliUjqY3VdgngqHTzSS1O6AtkMNi6iMPR/5zHAIb?=
 =?us-ascii?Q?b0bpvC/x77EPq1TgrGEvCqBREb0kmNh7wLxVADBCpuQuig4JWrGorfvHPWk9?=
 =?us-ascii?Q?5o9R3WpkYsmeU88O/okPa5GNteO7ROcnnMhLx1sXvE4b/FPNpmoGw4fCOtEO?=
 =?us-ascii?Q?sxUSyEGs7dlzCpGv75KzxhIfVmM7r7fLj5ODaTNdJk+QBeMXRNEoWQ6eABQO?=
 =?us-ascii?Q?/aBbOqwMlEpPbSLJxZooFUYHjoOdhXs5wX8EQwLWp4hYO0ZAfo+8+a9mV/9V?=
 =?us-ascii?Q?s4sjx9a8PPcKMuJIPket9JcVcEO9W7azqOTnnOPqnI5SD0fMsfknFyenkVBR?=
 =?us-ascii?Q?H4zl100YQJBMgB6UnZSbFe3qGhbFTSgArSmxa2QVjWfKw+rm3JG3DMhqMWSH?=
 =?us-ascii?Q?ibwL/QzlVVIGjKVVqK6EFD+EFKbyvPVcaYne0qTAgTuEUkdXrWs2dudf8PEJ?=
 =?us-ascii?Q?ie7YjZ6AwLdUrtXsLoIXZv3HrZVUJV6CoiqPpisbp62AEWw0I2XsprC6r/5d?=
 =?us-ascii?Q?z5kpUsn6B2549aMFGmplM7Hj+LPPggDubDGoOQQe3UAFQQDBjPArb2L9TZQG?=
 =?us-ascii?Q?bYK/ZmH05LqayAPTVk2zGNrc0wdYiD6eoeUkGAOsheXdEOmwJFB3nNU+Ocvb?=
 =?us-ascii?Q?orea7E32XIZj9h/wH0mhfLlW7YZp5h6XZ5byCfXMEcdLUnWgn3d3I4DqyXj8?=
 =?us-ascii?Q?S1wR57AtFXpWC2foGccMHrTJbGIYmNWhga/hVrnKZxrpk1lJl6DXSp8YNMTp?=
 =?us-ascii?Q?l5IIcbT4EmRC4oAPw3ITqhjvtAnf3wTG0EiO8oZhWPHRc2Yd5lNeubuy0oMf?=
 =?us-ascii?Q?4uySRFwhSt3MKmp07X+YewrqYNaVHVYGZuHzScV17i46dajTvGTzc8iamJkp?=
 =?us-ascii?Q?Utzqw2GSBzi476sfMuO6BMcJSx4HV1CUXHq5FX8Wos8PkPVpNoQok4H6TBb/?=
 =?us-ascii?Q?egCmA4L6QehObBZHtEWgfknnRqtLnh0kgmUrg/MXVP3VJX48MPTZlGPfrQp5?=
 =?us-ascii?Q?vu03fAuz2rBQXF5L0vS3NJzjzR4Zxvgzwxh/WlNaP3EJEn3mChM+4i+RmYhP?=
 =?us-ascii?Q?9ccC5AeXzeDxbBoWGI+KXIrhk39vtd/0q2QasV3096FVFlGty2ldv96VQNdb?=
 =?us-ascii?Q?c6Z35Uhg9NGgpt2KkpuXe8a8Yx4ljEbzsvLfTg09W0xl+q/i1plRfjKQ1BI/?=
 =?us-ascii?Q?WcpNo2TMF1tcPMj2nMiSgLnSNnnehhsYL5thybfunctGyoLCBPnJ8MWjV0my?=
 =?us-ascii?Q?9O2JMbbQ0UG/6jzE5A03rQkRQ1h5Uxs2qVnJrIu6wAdnD0qvZh1cPyGholx+?=
 =?us-ascii?Q?ULhXKDUZwnB2/fZh7PfdSQmuY9B5CbiN4sMDAi/gRcy6L6wJ8eNRit7UC7SF?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d6b6a4-65bb-4f21-8e32-08dbd0a88737
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:37:24.5880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bB/Q+Eq/ZSecePCMZ42vLJvz6jcot0KOcry06F5TXttFBCBts+DfjJlm3ZvHwIE4xwbCn7rw50+yDlJCwluRw==
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

On Mon, Oct 16, 2023 at 04:44:25PM -0500, Rob Herring wrote:
> The indentation for the example is completely messed up for
> 'ethernet-ports'. Fix it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
