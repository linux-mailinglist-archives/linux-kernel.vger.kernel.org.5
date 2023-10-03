Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512A27B6E91
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240421AbjJCQdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbjJCQdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:33:19 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2083.outbound.protection.outlook.com [40.107.13.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D89CD9;
        Tue,  3 Oct 2023 09:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSd7hkMLxhm7nXWHCVCvogbNLE4A8ADpHuHTH3D6So5X8JwcbyXEaZna8Byj+XDVobfpk8aOusA0Lve1F8Ax1VO8223e2nL2VeaGeycp0uZSbfvIt+YQNlIgweJke+Xzd2eW3gCwwaDd9eIiZhQpEPRtjad/3RvwFF+kETM0wQIT+6X+mCmXdM4mCGlRJ+1tfBwKlvr2Q3hRWbsBv1Mk2ne6Bi+GTxiFOvtSRVz8eb/HyyWO5D7Uka3vC8RWibwou73HS5B82M8nMI93ks7nCYvKsbdGIgqgb+berzI3J14fXw0b/UmLR8JnxCV0gRGvasRQNEYKnhllOQGjs+GI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCrKFX7+Opu4ZKNpd1SZBQONXcHsMSLMZOaOaJr0QfE=;
 b=KWezDfjl8v4Or6+O5Q/zRi4IKX0mQ1wH4EoxgKPqyripS1kYL1tk6K6rhjXIEl1uA0vsjuoPFQzeYrY3qs7fKPN1ZsUAnOiKBlcEslBmxi1toy8JOw0n+G3LFWnrSkCecWpUxfqSGHtS+nJv3uQAkUtZVmbvFEmbjNSViIO21DtIdNhvXpYahgxh2XlYS28xteH72upynADEVcXYGFmwBsKRAAIhuEaH7RjbMylhBxXzS90lCcP4oL6fIMWGqCR3/SFkSu2f1C1aC/w7KU/umzwco8uZFKdrjd/sYc3z7Jxr4xJgwerd1bfp3wWHNvLD+/oKitXxHXEh6kWiiDMZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCrKFX7+Opu4ZKNpd1SZBQONXcHsMSLMZOaOaJr0QfE=;
 b=fpXyiAB2wLsOM3bH4Or6N+h+PEf9FmoWjayiprsKDATivZdOdE5HGFwetckdX/a8Sg82bpQldW9Ni4BKJ8X4HxlcHYRX7VrVlENOQdV6aQEmLWTceQw/TvOC7RkZiG2W34JgfGWwua7edYnQTGGEIJDhSBwKHwZFdFBgKCuH6l8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB6815.eurprd04.prod.outlook.com (2603:10a6:803:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 16:33:12 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 16:33:12 +0000
Date:   Tue, 3 Oct 2023 19:33:08 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH v2 net-next 12/15] net: phylink: add the 25G link
 modes to phylink_c73_priority_resolution[]
Message-ID: <20231003163308.jmevug4xdobr2mik@skbuf>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-13-vladimir.oltean@nxp.com>
 <ZRwUKf1bRa4JeKXC@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRwUKf1bRa4JeKXC@shell.armlinux.org.uk>
X-ClientProxiedBy: FR4P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: a36250cf-3281-483f-9045-08dbc42e6f88
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OWW7kLVTbO6/TrmTu4WUjHzjFm5ZQXI9aQ31qNZhG+MMRhW4G0EeagRHPNeQk+xN07xgjGBmqyKSgB1/66TKcBJt+E/JWl3bQ1T9P+NHEQEtbMMk0z83RB8XvqkUjyfgY/NQd752vf5BeNuSq0O1hnCnaD79f0KPf2nOgV11aEpnUJXqx918FuJ+MrqWP7YC0ZzugLjtbolfAXkjjCPGxwHOaHnRh46gqaD1wOVRIR55xaxDbm8vFaxX3TShGeso9/1MxpDLpJdU2wfw+M0iQPJqa15M/Vuych2MEwRtHFySde0k+KfwjsImqDLBPnpb6i6KE5a9vYjNBaWQjRwyG3HYTuLWjbS0m+oDm/yutLMK99lkg1siXTDdQPdUQV52s3pCeeJW4FasQVWaCAFozSR9ITsMfjTbBPG+eNT2iAkN7W1ptOQ0qmAdM8DS2OG39r/2PTzh0sYxfUac4cDv7WFIbCrhqRp+IRE/SP46M7Av9iOvLG89HyEL24JLoHVtWg3SZDx48YNM4zs7oCLrwrI3RWcQPO0C/3Z1NVvVONAcFZHOQlH1NibxzxfJBft
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(39860400002)(136003)(366004)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(5660300002)(4326008)(1076003)(8936002)(41300700001)(8676002)(66946007)(7416002)(66556008)(6916009)(54906003)(316002)(44832011)(66476007)(26005)(86362001)(2906002)(478600001)(9686003)(38100700002)(6486002)(33716001)(6666004)(6512007)(19627235002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uQGNmiHC9E3VJfUqJAzaV/9tBjBIf5hpPMChUBgJN55o+cy/Uv592V3304qA?=
 =?us-ascii?Q?wT+Zmh1ReVDgTyQLcVGKK+YXQLi3PIrGEnfgZ2zdhSslV9wAMM+qp7zcR0eY?=
 =?us-ascii?Q?6me6ZTVw6TmtwXg7eqQyP02Lrgy9Yv7JJvKJVuHw3N7nt55kDwEpklGP2DWJ?=
 =?us-ascii?Q?m8SzTm4kMhk7aAmWpyTlfswCpFZFA3lvGVNAGNADD9Ge6Y/NR4Epp446poxP?=
 =?us-ascii?Q?VxrNOrvPRTgaYLrnlsP+BbouWJKYMTUWfKpSZNtDorbSxsk+9eTmjVjAen5k?=
 =?us-ascii?Q?oJo85r7gA3hLdepIq29qelB/9SE43oGZ1ePiGwUfzHpUwD/ntTHtLcxionH1?=
 =?us-ascii?Q?jrdIzbNce68/eGESuwKrtpqs5oo4zFErUq26QRvBkB5B65k6Wom6aUAPRWSX?=
 =?us-ascii?Q?5TQMe7hX7Z8fMONj+Ybux+i0XTWrsxSMRHTckXRIdtUxK9wWyab8i/xbB05Q?=
 =?us-ascii?Q?OJTkxLzrstcd0WrrAU5WVkyNqtB25Gbx/a1fNXVcQ7lez3z2vyNU9gNTbeI6?=
 =?us-ascii?Q?ZF/cNeoKSTwSrWfHhMaIxrJLYjbpgR/nnBUddwi083oDvJeO54ePyGR/NIyf?=
 =?us-ascii?Q?XEQ1EK09rPczVuSCct20JgEvBgtfXdDNv4UNy3UuI4QlQ9NT/zSqx61oV0B3?=
 =?us-ascii?Q?RiLOuSPaBeHHKyeTD8829sYYbNf+Kij7oNhTxKADau2Gw5ZMPHyaKdTd4m2p?=
 =?us-ascii?Q?4BOBz+9koYrRdcIN+3FuSKfHWACx7HQnWVIqot3kykGwmFR189UeLwh+lz+E?=
 =?us-ascii?Q?3midhn4ENuUSFpYIyUjQ9jZXXb3FfMIeuBua7cm4X32t/RssxAqoct4yyCP/?=
 =?us-ascii?Q?nSf4M7M25nUm5ymjo3gsrs7mimWDnURRNYh72EVPNQ+6dQen2pCU+ywCOUtJ?=
 =?us-ascii?Q?MRvmucm/1DRrPnwMzteYaKCyttBREqVVNXcKAhV9Ec+vUrDRu11IkAAnv/NM?=
 =?us-ascii?Q?8832cvvxO75wIm78HXR7xsYCfZx7qZAD27h0MpNAjahzfYqVP3pZzaTp/1X+?=
 =?us-ascii?Q?MguvUosSfnvcVkllGiK6/z306z/9bPxle/WEJyG4pqsU6DXAI52tP4pRQRh2?=
 =?us-ascii?Q?+2wZIiqRduflcNPsiBV3i0QUc6o+2m22uGs8wxSuWgw3K3ZqgX9fXoJ8yNQr?=
 =?us-ascii?Q?hcgqI+Edef7vOC+eQUlf7qdzeQMDgMUKZD/LiUGIxE0tEhDv4McoYv1oI7p0?=
 =?us-ascii?Q?pMFc7Bnk2aZGftTcCkfbSPlkBLSWYnCn2bSAYjVY8PL/Ts1am2ZZcgPdzCuS?=
 =?us-ascii?Q?toNjnjxGLpCDd8uHkv7bmALr6gQV4D/50QXGcE8jjeKDWIEnNmbjzq9TmYTy?=
 =?us-ascii?Q?2S6ZnU/p6zKC7zO77qs/Fgh/AVyLXiCG9IO9uGoMKOXM1SHWz9ZZPzPrEO6o?=
 =?us-ascii?Q?u6SGUqHGIdQvtqTzM2/8K4EpDDvT8ULI9HeuOp9c5Yoy8U62GqGTkae2IehP?=
 =?us-ascii?Q?/5x5ELyJ4pKyQKs3mgpSPdgkSm5TSB5eWH9c8OjqjVKQn5t83m62Uf3hMU4Q?=
 =?us-ascii?Q?Un30cWOFY4HEHj4yjI+YfJVM5BUqVSJrQav5g9BihzOZTPtsw24insRXahYf?=
 =?us-ascii?Q?ocrHTfugYkfUFCq7U0R8vU+wSNORjooCseRVqhOgNhYnKh/b/y59f+BJZvUt?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36250cf-3281-483f-9045-08dbc42e6f88
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 16:33:12.3282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwQhovVDSsYpZdf1mGNz2DR2VFjaNM6RdoXAAbB0OYPqJa3vDvh/2mDm3+3yx6xyIM+JIqvY0MV8+ITka8Htww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6815
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 02:16:25PM +0100, Russell King (Oracle) wrote:
> On Sat, Sep 23, 2023 at 04:49:01PM +0300, Vladimir Oltean wrote:
> > Allow phylink_resolve_c73() to resolve backplane (KR) or SFP28 (CR)
> > link speeds of 25Gbps.
> > 
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Shouldn't this also be part of patch 5?

Not really, no.

Apart from adding the 25000baseKR_S_Full and 25000baseCR_S_Full link
modes (which are indeed newly added in patch 5) to phylink_c73_priority_resolution[],
it also adds the pre-existing 25000baseKR_Full and 25000baseCR_Full link
modes. Without this, phylink fails to resolve the 25G backplane or SFP28
speeds, and it just reports "Link is up - unknown/unknown".

The patch splitting may have been confusing. I had 2 options, either:

(a) - create one patch which adds the missing pre-existing 25G backplane/
      SFP28 modes to phylink_c73_priority_resolution[]
    - add the CR-S/KR-S link modes to phylink_c73_priority_resolution[]
      as part of the general CR-S/KR-S addition

or

(b) - first add the CR-S/KR-S link modes everywhere where phylink
      already uses 25GBase-KR/25GBase-CR
    - extend the phylink_c73_priority_resolution[] for all 4 link modes
      at the same time

I opted for (b) but I can also go with (a) if you prefer it that way.
