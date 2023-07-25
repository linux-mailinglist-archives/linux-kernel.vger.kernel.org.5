Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275E5761E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjGYQIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjGYQII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:08:08 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2106.outbound.protection.outlook.com [40.107.223.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84849212E;
        Tue, 25 Jul 2023 09:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgRViv4lD5oephE/LE2XCksiRTyujKws5zXcuuJDg1vcx5/WQ6RkJlWySboAFdGyO3SSPPS8nTFdRKjK+rUWDj2yAA7Yxp6vUa8+GKZoAbU7mFG9KBUNweCzq0YwjQ+s9P73Tvf6CIgyhnAxYfnL5T6zrXUYAWfCiq1DQBWR1nvXUiuTUaCqfcOTwiCmYWGGAs9rYbm/0rpW48UxxmFtbIXBXlElBmsSma97gI1C8wGBzTqqAb5dkYOFZxI2RbepxsGWhuEjNotGsZp9SCJOFbcBFzcm6cSuNHEPtX6Hx0O5WesJz6cI0D9DajoBpkeGKzptYYyXQzXUPaZbmspzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m+Z7hesT3nbpYQZ+IIGD62dWZJEXKqs3nnN/rybIlw=;
 b=kg8zO9fVjGcuLad7xO9AfbF04XS7/lm57iTSYFbNWvfREmV5lfCjuTvLin2uvwaJQKhvQ24O9Bva4pE5+ymMXQUvz6hjZCBse+w9ZXRyqRwxRJtFhc6m8dC7VEbJY+zxaFgTxWUIm1HVEbvsfEDK/OGuxkwpwn5GUDgjBAT74iufOIx2aYtdoeVbP7VlaWIA4tStD5welyhtbhVnnM3Ep5efZNuVd10ZtvuOdIC7QDY/EQiQ+ldl3SiZ7kHo3ofeul+ZGdt2TG/pgF6i+JE5afaCAZoI+pyysEffELuhhRVuou6NtVDdDGcNgpcNIABBSFqUTlYewnuhQuRvJ/+uxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m+Z7hesT3nbpYQZ+IIGD62dWZJEXKqs3nnN/rybIlw=;
 b=bRD9WyypROfyMcaWv/8nOXB9nu+gf6FqDhxauKab34PkQIaDrRy+ffN1ZnR3J+mh7IQUcqCrWfJWT9QeuhaKoeaW7tsUTwBfs2XYbloXZy7x48k8lZQzkZUY/it0GpzJJPAp38Asr1bXYNMsyrfdYxgUH19dVe45v/EvVkVHIMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB4880.namprd13.prod.outlook.com (2603:10b6:806:1a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 16:08:00 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 16:08:00 +0000
Date:   Tue, 25 Jul 2023 18:07:54 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com
Subject: Re: [PATCH net-next v4 11/11] net: phy: nxp-c45-tja11xx: reset PCS
 if the link goes down
Message-ID: <ZL/zWt1vNV0idw80@corigine.com>
References: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
 <20230724141232.233101-12-radu-nicolae.pirea@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724141232.233101-12-radu-nicolae.pirea@oss.nxp.com>
X-ClientProxiedBy: AM9P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c76b2f-d190-4e8a-5a6d-08db8d29515e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pm+S5eSIk5shjUbrxziESzd+AIGc4c4+TFAhkOzQO3+mtbs6y468/33pdg3783rFQxPQcP/EdJAl7+qGw3E39U9VNd0hvmER8f9tYxtVTBMdbprAMF92gBPjoGYVlW9237UWfCQujyTaCH+hGrsbtycZYgBV7RAAVPQwjXgWDhOuXSsQLt35e+utFA5JV3lnrCt5UoaEDX5sDvzfbVXJWWWAGV5FWaheQXzRvSSqqggMeuglHgFQ281XTd4klV8DFrBOAQjR344QqksW5ylZ0X5O1QZWIm/YSQVCyUtOjahsAug6rCqq5XBEzEQzT/N3MnMxxPkj5mXCiVo91FFa8XaxXVEEj+JOM8aw4j8/Bfh7O7vayqbAp3HYJ9JoFZdHAikBn0nCTyBRXbYECA5vNP5DFMLOpEKt0r6T1n1kpkpcoc5/z7aI/ixIULG9aQrquv4qKMTVcrWxU+JTAqJV5twx+Nv65UCSUwBEhuFD88WlPKlwRjhJyo/ueLYKegTTw0QhHH7YrlL990HZBfue/9/B7mpUsIQvxY+mJHSDWIcT1Wz2PIWFnqkGKEnQunYZoaoiPY2x9u/2BWrIRj51RS6yjdf+Vn/4EaglzM7GvbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(376002)(39840400004)(451199021)(2906002)(478600001)(6486002)(6916009)(4326008)(558084003)(44832011)(36756003)(66556008)(7416002)(41300700001)(8676002)(316002)(66476007)(66946007)(186003)(38100700002)(6666004)(6512007)(5660300002)(86362001)(8936002)(2616005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YT51UZ3zMES/M26xSw31SxW+nhrO661UKwxSW8X7hIM08Z2SPKxyVwGQh9+9?=
 =?us-ascii?Q?VN8P8dOE6POl8IaG9xGhV//T82PXFcs+xgsQ8QmjgnMQyMTqnKYd/qw+yasm?=
 =?us-ascii?Q?HawhTMrLle0E4U9COfQtTGO585LbgfLFOwvukXDx2pe4IH0c/tNKm86bnBj0?=
 =?us-ascii?Q?LOMukggzLECC2tpthc16lpgPtCSJkkOfwCLGgIJSAtDV1VmAuJaBZYNlSi//?=
 =?us-ascii?Q?K72br2stuh4j5AFcDxet+kameQiACI8dwcp/XO8VBprowwcehRG/2WoyvJMH?=
 =?us-ascii?Q?J/zJVBwMpCfOA0+QVjLejgK0YIXDybEV5eyc7xcKrikWBJp8eryKxdpxfTJF?=
 =?us-ascii?Q?MF0gRNIM23Xl9/cKo9W4B7cfy0BwVFr78zhYVIoNM+X0lRb/oqAISwsXzjco?=
 =?us-ascii?Q?jRBIvZfvHCGUb2xcy96Wjr0R/ST707x2PCFC8vvs99ZYd37bQyMHpAW3jS0r?=
 =?us-ascii?Q?B+dG5e+epwmEv/y0ul+zF4y6ewrqu5wDpx/7Xii95qvAASTz225xX7qxCNBR?=
 =?us-ascii?Q?KiRZhkd9uld+CMf7JPIsUmAd/HjkXy84CiJpTrOvDbg3wYOWA/2kYEwjzPCo?=
 =?us-ascii?Q?A3gLMeQ3KUT7HxzvQn4wM2rIsqS78yR9EsI5jatRp3AMxqQBRr6YZIQEtM4e?=
 =?us-ascii?Q?NJvsybz27eOcUoIGTGSVhgehKGBm0QRtsECOUl/krVHX2CqU3hyVHhrsFLN+?=
 =?us-ascii?Q?Si6qOo67jR/OFnRmTq0pflLIwW4F5MjulIbYae1t+opwcPSzDoXg90C/B11T?=
 =?us-ascii?Q?8NHLXByWtAiY+R84C1iuPmoVqC0HqHxs3UT5J7+ufYtnYU5GUDMG3EbdUykq?=
 =?us-ascii?Q?FNZPLxRvNz4d4IhAfrLHLm373zRlNAvKZuq28xslW6wsPJI39BUs4gRzdi/h?=
 =?us-ascii?Q?odvd02yc7rgy+E2fE76CAV6WANtWvZwardqFfRAINnPx8SrSawLv382BPS6P?=
 =?us-ascii?Q?2A0RZe+1uUDvB1d6yNcMV0++4eCGPlMoF+XdK3Tog4nQRvDnd2cOmK9uviQC?=
 =?us-ascii?Q?n7KJkYsq/GLL5SLrXf/lVy8sz2GspUeMlDO1CyDruAN4LsaR6o6I8sp5O/lJ?=
 =?us-ascii?Q?/1eFMvTVKy+LC1PuZjUgiGNW/8keZwQ6anLYNq7cnZQbrlFcR5vwpWinG4es?=
 =?us-ascii?Q?KF7Dr6rIyK5drpb5jXomXQdMjadWmLG+as3/ivz+KIAvxSWTgFtOODYX2gz1?=
 =?us-ascii?Q?CVUA+2mrIGnQDb0mArL0MPzsfBSjIXj63xu7BicYSUFjZCmZ7M/RevJvYx1m?=
 =?us-ascii?Q?Q7Y6sOwcdBJt3kLi9yw7Yw2GR6UXSHGFrNsgFXEXDNZXwtdZVts5sUfLo2R3?=
 =?us-ascii?Q?2ImhfAHwrfzAJtUson+WkA6FDFoOleOjQEHOXJnYh187XorStj42kHZrEOJS?=
 =?us-ascii?Q?6aKEopdcL3VICnq/tsgDi9lkiSljfY2oiDRcCCuA517aymnr2W6zrKtC9kNK?=
 =?us-ascii?Q?SDJJ6K3N7mE8fd7uGIJkxZ/8fgUjmbl7WDc772Nt+6SRy+EOo2v6P7DtRTas?=
 =?us-ascii?Q?gCgaSwzGjpH8u2pn4EAAINpGbw17PJIaoTQNGgV72VvNFLfrrQGhlWohvMVU?=
 =?us-ascii?Q?ITFiCpND/SL3U590ugpO532GIDhG4yisDZxff/VVwTcOAUEYtPybDfM8T4RR?=
 =?us-ascii?Q?NdjvdDZQGq+XdsQEtnCpotpzAjOqKt0zfEIL3yZ+lL8YCzbb8+hIRf+oNoxH?=
 =?us-ascii?Q?+VbAmg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c76b2f-d190-4e8a-5a6d-08db8d29515e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 16:08:00.3541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kULxyFNUF7EotgeCxnFHCpDwBX+KGi2jLZ08k+uMZqGz6Uhq2RNrs7TE8W0lc3z13hFaMFo2hG7GHJpqreTh3nr0Y1PgWxsdU8alJ7Jq7IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4880
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:12:32PM +0300, Radu Pirea (NXP OSS) wrote:
> During PTP testing on early TJA1120 engineering samples I observed that
> if the link is lost and recovered, the tx timestamps will be randomly
> lost. To avoid this HW issue, the PCS should be reseted.

nit: reseted -> reset

...
