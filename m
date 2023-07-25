Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFCE761FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjGYRJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGYRJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:09:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204AD1718;
        Tue, 25 Jul 2023 10:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya1FoM2JIgnOvu0rzlbCVxM5NXAAOEm0A0K84C9hDFEyMJWwmM5IjYyx0P0ZlX9wiFEqzSsm4c8iB52rUJ6wIM0lYO2t4LuyktxPqyffE7tmw5R2HX5BWfytjmB2CaolaJldKVisaOnCwroK2P0lbOoz8WaKPFiE7Tx2iul1Ut/obsJnmfltQrBzgVFs4/kfV8SP38jTLHb0oOcXvnSk6EV1q1FmXqGWwhUKCi0mNV2bECzxBIqM/yZSSsIKUzez9F64R5veuQLiVh+bDjoczTfHAFpEQ4EvOxpNgut7NGVAC91jUaDci1kNlmyiIvwcMlM6PdPm5D3KghUqllZXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1hWLba0x89JENralHX+7JfjJHdC0n2fXRejaa9oFJc=;
 b=EogtJ+GRhYr+Axl1MQdUhXzUf7SvYngFs4pm2Wr3ELdxxK2QK83eBQApLQdY1bEOU4zqW0pKKTTL1OeMYK2++Tvg88ut3aRFLeaEE+8Udk7a+YXxnpYh5UgELh2iXA/AHTfUMGDn1vC1/LiqglhfneV/EMt7+yHl+WZkUfE+qaLHi8yAsX5AIB5+nh69Ob3bukqnRg9o/b9vhUR3U64Oqk/p8P9LPH/Ayrl4bqNxkFUZ+2SMaAKoI5Mkt5uIMmnSWdSx5MwCXbCxeQ1mApCvUHUe+Y4dN0RxT4EXpGhPxhukg2cEvN6ocglRVuvEzUPfyPpdq66UCdK6L5DdjLKcGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1hWLba0x89JENralHX+7JfjJHdC0n2fXRejaa9oFJc=;
 b=A6xE50pMC33gqhBmQoiKh0096kHVNMh655JOFEXodFIvyyh2m9dUC4405gI5u/XtVkqxxa+bpgt8KSHRa4huBoUm7JJK1WEbK8bnKkUdbiR/b2QPSnssydv2CGexMfXm/G5STsHbsl0M4UB8rbZv5RckNBNVAvqPDYBEr9lk4sY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DS7PR13MB4672.namprd13.prod.outlook.com (2603:10b6:5:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 17:09:32 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 17:09:32 +0000
Date:   Tue, 25 Jul 2023 19:09:25 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Rob Herring <robh@kernel.org>
Cc:     =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] net: phy/pcs: Explicitly include correct DT includes
Message-ID: <ZMABxdgRZTLt1SgN@corigine.com>
References: <20230724211905.805665-1-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724211905.805665-1-robh@kernel.org>
X-ClientProxiedBy: AM0PR02CA0157.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::24) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DS7PR13MB4672:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3bafcd-372a-4043-075f-08db8d31ea0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TreRRA6FUJ2hrhTisUBzJLtgcYAV3gjEhoGQxY9dQZKQ/uto3H2lUHft34698lh1UHoBvoDEc/jz5uHthSiKjqyXjdyrSPX1J02wtWQ3G7J+yoJwFX0Gttt0ulxFfgjeA2HjHBJd9A7eW6EjaLcrP1/PFw/DCNmEQH1gmF6b4Qkvny2L9d+1qlRgsFuxuO2qFDNrWdWDSw7eyqiBmrn0Ghzv5p6Jxygrpun2/v9UtWG/OHI8w7EPYp468Ml/8lO86CoUWfLM8tkicNcTbvh8QRcnxXQMJCJ0gS8V72dIsPvBeaVoQLQaMgqXcBMHDnTCcGMwifl59h1uQhjvBQsXxGBGm4dtxiM1yZXefkhtNyF4x0FhkesdDNRDuDTaebpNRhCC4QE/hLFoxBvEIoGNCIxDJcZcw7mOrMoM09izzZ1VOWQ0vvaFHJ9vs/TjzL/cwy/dFJMgJdPY41VX8babDlxq/wM7n1oiBhd49fwVslIMg9LHCC4sjWaWKVRVPj7nGM5zMmp1MDPq7s9UJasTE4GQJkqY+ctD1mMQKDU84OS7pmLBjLNe5fJ1nbHdNbU2B0UK9CxIU6CDyswgcnkQJRWbF+m5xw55m7Zc6LsWc/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(39830400003)(396003)(451199021)(6512007)(6486002)(478600001)(54906003)(6666004)(83380400001)(86362001)(36756003)(44832011)(2906002)(2616005)(186003)(6506007)(66946007)(4744005)(38100700002)(41300700001)(316002)(6916009)(66556008)(7416002)(4326008)(8676002)(5660300002)(66476007)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r7aNnCPCql8PKGZxzg/eacnMv/vzi4rIgaNuAhiuEehu4lioFI/ywBwYU0ot?=
 =?us-ascii?Q?tT7irt6kUrayQIp7ZieGnKAyaCgMBR85upJSoZs7JsmdayL8aQZREao01KPn?=
 =?us-ascii?Q?EIXvyWuZKUtgOVBdyzlLQxPtLbFbISGqfDRusC7Wo+a+EMAAj7bJ4b6owohA?=
 =?us-ascii?Q?6XqwDYM2OeDNqEmP11ccH02PFr2LuCvKpZOQ09yEqNeunxrDfzapBar3yeXl?=
 =?us-ascii?Q?fQN0na/Jr/iBaWFFnSyFwTAiWdrzRAkdacGFutIZ9ivXiFh+8ul9e+CFdO5j?=
 =?us-ascii?Q?R0a4MomWFFjjdKcfkT/YZAiO0cZM0OZa+eM9mpiqEEj7IFazV2qjddZEBGr3?=
 =?us-ascii?Q?vmsd+ui1PUPUU+652xJ47r4ZJevlnsiHyVxS0ovjplX0EXSqe4lTSY4LMSS/?=
 =?us-ascii?Q?hPA0jAohQI2LqREkknAUAdIhq+Hu3BQuNR326i35OACt0Rws+b4AInxPX2si?=
 =?us-ascii?Q?ATcz51+n7TetIHSUknTt7u1rz2xP6e3lmP+l3X6CKJg62rX/WjRPL6J+XpzV?=
 =?us-ascii?Q?ShEOrbubkz/FiWcccgqUgmhkvh6WFjFyeVSsxRvl2MeQlRR+sPiYZMEx2rH3?=
 =?us-ascii?Q?D8UVx5yqVaWT63O0nkOVTS/Va/9BuxzExg3a9+i6oQpZSHe7llkEQ37ZDkMY?=
 =?us-ascii?Q?Igt5NgEMojppNJ1/PzaCmu3e05HgBJ+AvMnnYK4t0VPa+kDFTRSlaU5RZP0O?=
 =?us-ascii?Q?DF4eEJhmPdMQgNC+uQQaE6b2PhADSNb5qPiR28bMFDAtHVIe1rukO8dgMzEJ?=
 =?us-ascii?Q?FUX7Sa7W/lehaBlFy+trfUrzlZJjZkNquozYDKYwKfUv4lBr+wOKFzCIK3z0?=
 =?us-ascii?Q?2wEP6kAegf1BnnP1+lnylDL5teJrkKcrTa9hVLZb0e6Wc5szxfcGa3D2+N83?=
 =?us-ascii?Q?Ox8h4JUVYdGORtX3GXWTI1UEaAs3T42l8G3dMIWXwYNmeHzAS1aPrL2wYG19?=
 =?us-ascii?Q?GAIXAuuGwx/YSLXUwl98CfKqK1fniph6grVpOIlruRYKpREbMs5GTVGIk2H3?=
 =?us-ascii?Q?EbV1qTwpPu7/g1o2QpzUOruQ6kazm+yZVT2edeA8OFQtYpaEyTSvzXvLlY1C?=
 =?us-ascii?Q?euZpwr0Jd/veLsgnfL7wB4c0RPcdlkGxpdx9LRcyyo0YtOTBVhL8HaGDlCeH?=
 =?us-ascii?Q?O9MLbUSmjrXXRBZbS1dsL0T5mExzEqC4XazPnqN2BJ8d++EhILg9uWWkD9rV?=
 =?us-ascii?Q?SwivxpefzgakSRLM9sJxEkSYX5q8wUfdjRie6WZOi2//W3qeDz3p0d75kSDC?=
 =?us-ascii?Q?mp91CPwkC7WYgOh4Bd8cfWGm7p86L5rUEI0e+FI32pmWgCy/TA4i8HAccG30?=
 =?us-ascii?Q?mwD50yF1vZG7uigJDAdMF7luI4Skd38y2Jti8unSorYkVjGz8fMnSaE0xQDx?=
 =?us-ascii?Q?1sopb+7o6fTsrkyPP9tJKaZ/aunGL5voCF0SIjyxMpD1aVogNC/RuTTUqplH?=
 =?us-ascii?Q?+oV9nlGKm0G+vt701UXDHvKS9wvrBDehXdT2vRWfCWRhxjlPWbfhCuzWYY5k?=
 =?us-ascii?Q?u3mwHbsYUX347dOomIyRB/MZFQ9DwFl9QpMZpOovvY22ZIP2WQuPGbWQm1E3?=
 =?us-ascii?Q?pJt/8Dy44p/ok0wAr9oSP+7hyRiycNTs2CsExeZNG/zEIUzFi37avnZTn8Ed?=
 =?us-ascii?Q?xjayasnBWi/O7durkja1o/THURCe0EOSdxYGcdH3B4yiu5UjaEhWYO/SJDhe?=
 =?us-ascii?Q?3wRc1A=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3bafcd-372a-4043-075f-08db8d31ea0e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 17:09:32.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1g8CpXZ8Pv43Mgw/Ed7kQC8lWTO/KpICuj2qEjPFHTdcPMSp1KfT1Cq9+6kpyrm+IF7SGmfQ5hV2v0eA5Y6625MT6X91O4yF134b63Nr/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4672
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 03:19:05PM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

