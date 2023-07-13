Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4A7751C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjGMI5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjGMI5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:57:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10D110D4;
        Thu, 13 Jul 2023 01:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiVheZai3vSkYj1OWvMv6a3tbGrE94kuWGpDaPLQQWIw+762fM0xt4QDw+rL9FBzI+N+i1ggeOFX26BLslDI6Tfp1ZYHsQKlW9Pf+9ML9y2kkoaDqCIcV62y8zeB2clT4OG0Ch6E9Hqxbfbzm772VVAoqrHQj8UK2gIFJmDSfUhg/CdJwa+hyoC3t9GWcWI09O6thg8uoOPqNbCkQ36lfFSnaPVg01cYTJ+MW85FzGApxJSBchaTgWPdQ0mpIjnnYSpfgAJwEMMF1K8g1+H2L05gHzmN1W4ULUUhukS6zmO5PHWpUjeILsC95l+GlKHmOmkDauS4ekGQb+sAfmlL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIK0hEN3NQ0aUJb2d83HhcL84hBXkwWTsncd69YCVWQ=;
 b=TGDXbPjQ3584ioZ7hTdb1PjGUxPCvXKmlUuo1OH0rE6U3B+h4AqEJNl/6LeWeXSN/XG0U1jgjA9R3lypH6xr4UEhl8XmNn7cPXLPLwLBzovVo5nA+p87f9R2YZ4PKlXqrBWFao1gqQpdBr+PpoFoDICYzhyD2irOjCle2UTBxPFsbpqHOTq9mnHLkNeiHdmTM0v2tO43WTupFd4aUFjqu04huS/oBa3aNKHRkyiOcZsygozt/SVRyi9jtSpdhmOcepseLVtImqbHfhKLv1SAZ4Ee/4TLi49I43qK0VqCjuFvicWe6WKFe5pRrP0XY24173jJ+EqP2REp/V5lYgGrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIK0hEN3NQ0aUJb2d83HhcL84hBXkwWTsncd69YCVWQ=;
 b=C4SoyVs4oCYXFsNnXyZT5r2wy9nf+a6yCtzWn3mHZJcFGzBABCi0z6yPa20B6eouiAHsIc72Recw3u3KQ1MDGJCDzlDSeI/bv0NU48Tgd4AovaOV1SDNwa0KsUNcg5Kf/TPYoQQ5Ngl5TTzXrV56XOgU4H8LDd5TT0s5cEoXE9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BLAPR13MB4756.namprd13.prod.outlook.com (2603:10b6:208:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:56:59 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:56:59 +0000
Date:   Thu, 13 Jul 2023 09:56:51 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 09/11] net: phy: introduce
 phy_promote_to_c45()
Message-ID: <ZK+8U48j4nDvvTlM@corigine.com>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-9-9eb37edf7be0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-feature-c45-over-c22-v3-9-9eb37edf7be0@kernel.org>
X-ClientProxiedBy: LO4P123CA0478.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::15) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BLAPR13MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: 22fbd395-c7a9-4d69-55d8-08db837f1def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlDGzK6nqbGmvRT8mJGxobduXtOTGO6ms3dwN00RdVyoHGjVxkFtxRyXYQHlLf0h88Pb4ot8wHD+SAtarK+uUarlk5vDRaO5xpEqrJJEBpdhJ3ttkF/N0ZAUX/oEMAqfFpN5UJ44LXCN1Wwb+NF53j/ROU/DyVgDQT059VYxxkBUCp2Ei8pLmiugdr+4XmmrJU4epe7wjW8jYJunsDMDmwtwzerAZel2USyrHxfM38v4vB51qlEiYdGmhki1MFQjeBNUYC8qUWXFB01L4Kq4+V5UtRfJPi9hvKIP/n7+V/e8fV4JthinwCFkRU/3Mnf1Me1EmFkKVrGmmhTdQZ/K73D/mwsK0lc2RU6nrFP6jaD3+epHNaAitBeirnrR9nN6A4YvPBE2Am7/In1GpUbwdGDsWDhjjtanZseQ0gGy4/1K792l1nitmlfGVqwGfSVtLJUvpO+frm92Ncve1ggyL6UnpkohxXOMyuwN3khg+MJ+XQI6ogVDARBy4ieVyeWBukAAC9dkXlq+931J/7Ea5czB8DX45GA/QAxZyv8IPEWkgRb8S4eqIs0Mi+FtpNbpJls49DQzLDQajG7sbFnqodL9Or02EgQSSacnJC9Rl3530CaW3+QuOqGiKPisR2DofmcZslOowcv7lbiEX9KoEBepcxk7eeWnxWKiRu1vkME=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39840400004)(136003)(396003)(376002)(346002)(451199021)(558084003)(36756003)(38100700002)(86362001)(478600001)(6666004)(54906003)(6486002)(6512007)(8936002)(8676002)(44832011)(5660300002)(7416002)(316002)(66946007)(66476007)(2906002)(4326008)(66556008)(6916009)(41300700001)(2616005)(6506007)(26005)(186003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uZK628UVOJizOMNXuoVjQWD3kS2rePoPdQTvVIU5QRiPq5+4lUufAxvUYTX/?=
 =?us-ascii?Q?C0Bu1ReGe1DOltuk3ymAuyu6w7WaFzM4vu8YsZGR1NmG+SPJF/RyB41ulFrl?=
 =?us-ascii?Q?O0T579AHGfiiMEwUj1Y/7Pcg5WqJAC0mbkaU5hGSRSgOZMk0we1fxOs7ECcQ?=
 =?us-ascii?Q?mOP1+JBKxm26ND68xnNf87r57WnLXwAbStIVGsAXm5/Ma4FWOk3ub/jeT84J?=
 =?us-ascii?Q?XWqk/PJn/BqA7noUk1udlkv6Yw2w9yFyHBNEPeKZt0MESpOGpbOaCvbFLkZ6?=
 =?us-ascii?Q?/g2RIQBBAS9P/gXpsvSf3TjHZEKSUh+h3Fs/PtdV6dciSY//UYgX9mmlHyZX?=
 =?us-ascii?Q?GETSb84Djv3XQ8tsV4ID26llTvGTxMhhwiApf6GcymdWKouhx76Uvvwi286z?=
 =?us-ascii?Q?Grp26iSl5xUOAWzuPGwCMz2FXutEVXa5ouqGcEckLDdu7y0hCME1Hl8ET3Rf?=
 =?us-ascii?Q?ydOwVpS1XanUA6tOW8zE0Sj8Hg2ojQdC8pcrz3bTa+l1irZPiQE5BAmXtsZh?=
 =?us-ascii?Q?UGLktHNIPoFqoZQH259jxglWxtiyN5fBA6iMtZTT8kYh18hjhgS8HWweIPW1?=
 =?us-ascii?Q?tW3YuTeBCr9eQXVsC1QKLDO1b6gHjKNoTLlslr7rNQbw4xrpYGRv51LBcMTR?=
 =?us-ascii?Q?QxE9C4Kci3w8gz6NrrpQyobbXW6fDbyGqLielsCWMdY5dB/jIWRQqjDLy91F?=
 =?us-ascii?Q?JhK1kiX9eHVbdwYYhNOhZnOehM1eQTwH3LwsHZ9Ca07DxNc1VNyOyj5tJ63j?=
 =?us-ascii?Q?bOuIk2CP42oFyBMgtw1/1CpydC9shynFlaxOtY7oxY8Ko0tRj/X9lA/AVgu5?=
 =?us-ascii?Q?VfaVSemy0Z9Wh1Ijfx3779tt0wbaDvcUK1S2gUWYBFqX81m3pDLRMtNgcMyn?=
 =?us-ascii?Q?LOqpbeRjvdNHgMwAkl12lmLsXUcFXX0CtRGtePilMBloQ/SfVkbcefCF/zvK?=
 =?us-ascii?Q?dg5VS/fDMLRnmz7V86D8eLaXShLTrIwxIRrmc2iNMQGaPdzSkCswbCivjph8?=
 =?us-ascii?Q?hQHEwcvMbNcrI669RduSistYYMcaQqNsTJJo/S2D4DfFhAQLZqLBSPk/O5a5?=
 =?us-ascii?Q?koouwQ09yj/2kq8Cf2MzlWPwFF8Wba9Jp/0ubJJfgV0Ov62iWi+bV5SiSKv4?=
 =?us-ascii?Q?KiYoCTIS1cDrNjg+PFAY7Fxve8BaaiUVIcVTr7Kj4fP6p8z4FudPgtYldAWF?=
 =?us-ascii?Q?s2Z9mPBD4if87XvADv61j0TYNxpSow2EaFomh3iY74T9Xzbt8F9ANSC2VfEr?=
 =?us-ascii?Q?czOgTlSBpZrQwespa7BFxdF7Og1okW3kki53CJlx//TXjMXdomKYmvsJa1qM?=
 =?us-ascii?Q?XNuL74eb84W3hHwTwMUeNvuf2V3lCKY2Xj0pPZUGF7/aJyu9GhdU6AbSx0R/?=
 =?us-ascii?Q?yZ5Mfk/Q/RXk4hxL+i8bclnX8J8yfc/w7vE3naK4PAaClaxY5s59I9LWpnoj?=
 =?us-ascii?Q?YsHxok+aql4PnkP4qya3T6vywEaRfyNrQNLuhAFM8tHIZ/YG2dxxQEtk4bA7?=
 =?us-ascii?Q?PlcQ2EPcU4VsC2r4QI1Fi2jmp/PEw54wGtoRLKyzmGYVqSltj8BVe5MpSiDr?=
 =?us-ascii?Q?Bvp8SnjCSssJpH8TGJa1wCC6LVCwhSk0YAFfwurtKg6OqI0hl+MKbtOuWtaz?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fbd395-c7a9-4d69-55d8-08db837f1def
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:56:59.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBfdIb5wz3cn0Yd80ATs/ZMD/0p3ZzefNaAJYMe3CPWbTcmiH1hN3xH8VJahYeTGNFF0E+zi7enWv1rRxNcMbZf7XKK2xNMlsgwIO4fwHJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4756
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 05:07:09PM +0200, Michael Walle wrote:
> If not explitly asked to be probed as a C45 PHY, on a bus which is

nit: explitly -> explicitly
