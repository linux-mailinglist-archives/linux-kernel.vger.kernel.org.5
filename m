Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E038575A01C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjGSUpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjGSUp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:45:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2096.outbound.protection.outlook.com [40.107.223.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28F41734;
        Wed, 19 Jul 2023 13:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSt7BvxlnyDwYFc4qJtuq8ZqacW4MMimbmQAN7RwkHLOEPly6ddvcR25UJKefLM+tNLcIJUOq2LbZ3yRcJYulYf12FgpE+DdXDAd7Ano7zw1olaiPmHHWpf06qAtu9TjfySQPu6LYKX2nTmLcjA+lqAR4oDeGj6k8OYllTXlLD4YeRKynQWb2nHncFkVAqMx6oU+PqDZvJerfU1YLyA2TRPHU+pvzcqXD5uy8ebvkOe6RjnuiWs1N6jcnOK1Y/QHK24vixxCC2+Za/aAKM5FW1zLyJvxoPOg51QKQLmNn1y1PFfQFHjddCg2Mac9ZBfHMUA7B0TCXDRD8/S8rdaPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKafITy4Re7/0OFWZ+xJYEOz4K6xQc+yR/VvxMX0kLM=;
 b=I3UtyCIkoDWbH9o0Lu4VOtjFiHE6cz1rnGrkZIthKMOiBeHmpC/I+MBmIHPzdHjR3U8jJNS6WB5iX0BaMGnwaTsiDEKvqf2b0M16svAWoZeXfZtOkvC9ZqHDZ4HO87+peuqxove61En+sVpFiCvWkNgc7U5nH8ITyesMKg2UQfBNQpn2/aeY+gNI4SxGajEwTXhtad1OK0fOmPM3JDggjDHXyWCCEGvbG2H+kgOcZ+McoPQjlhI9TtaZ4vyyZGr6dLw5inExejyv2YS88d3MaQ0NM85sLNIO/tR+CKLPZpDoOMnLaqCy6lV6eVsZ/WPlpP2c5q+3GMCpLN97hb/YYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKafITy4Re7/0OFWZ+xJYEOz4K6xQc+yR/VvxMX0kLM=;
 b=F4mphQSE4bo9+Ea8hs5HxWEd1Tb8pVEVPAztMTR19AnTr5DKpRpjdAvFjGO6QoYQz74PxEt3fWt9zMOPapV89/y3yEQ+ebbz+0H5rP0p0j4TkrMy4PPi0gDOAof9xKrwJvqi/L8Cl/lGG5Ds46vcLPDnJ89AtbxV83Ac14eU0ZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BLAPR13MB4721.namprd13.prod.outlook.com (2603:10b6:208:327::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 20:45:24 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 20:45:24 +0000
Date:   Wed, 19 Jul 2023 21:45:17 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, xiaoning.wang@nxp.com, shenwei.wang@nxp.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH net-next 0/3] clean up the FEC driver
Message-ID: <ZLhLXVNm6LVqjg0Z@corigine.com>
References: <20230718090928.2654347-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718090928.2654347-1-wei.fang@nxp.com>
X-ClientProxiedBy: LO4P123CA0432.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::23) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BLAPR13MB4721:EE_
X-MS-Office365-Filtering-Correlation-Id: e04c7d3b-a633-4113-123d-08db889913a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5O/3IyJym/eKjzb/Ht5dIm+41li+zvlxFUNbWKgPZ2vEiDfDg0vZ4NCMT8mElJ08m1b8RHPTPl8QrMn+ACUVHPORRgFr/33y74xSu19hO4g4DoXM4e0Ocuw8JCu3rijf3Lpoa2Xj++Z5nP1njT1dRLxFXzmSxZS02t/R7v0tuubKvG/T1p2VrqCHCjYBLgADw49jDQ6/M0V12byPzio/96cS9UJgMuJBipL+PMEa/3aICdcvACQcW9oc3Wn+/Ju9tCS7EYzvB4sVj3CmqBzmHP4GfbwC4KYixwA4GAl64kiv8/kcOHsjho8tri3VjSFZJJx7MD2WbMDsHcnTFd/bWtbQwXIllJKzn99smprSIHcF5ZyLA4pgHBzCGV0aE/e2qU7gnuOdy9Mnc/BhUo0rvxacDOIwHXKeC6Ht2CQmg+POIwiq057Tm8Yn9EswtLn+6QYvay0hOjjtY+PI9t1IkhxHxf+4uRLRpyGlRNMUPRtyPM8MVJ1DmdiGlYFryxnHen6lKZJUcFl03CQ9UBlMoYxYWKwTXvxr2hG8TuYiu9si0kIUJBpklYdmk5Ak8BTQLtNjengZDL0/ORCAdpWBDxTGHLVDgbDzYRiz1cvMWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(366004)(39830400003)(136003)(451199021)(55236004)(26005)(186003)(6506007)(478600001)(41300700001)(6916009)(4326008)(5660300002)(83380400001)(66556008)(66476007)(66946007)(316002)(6666004)(4744005)(8676002)(8936002)(6512007)(6486002)(36756003)(44832011)(7416002)(38100700002)(2906002)(86362001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uIUuiAvDNI2DytDYeLwC923WtIw6jHMWZTD867cGZ7cJ0H91Bww2D61Asv4O?=
 =?us-ascii?Q?dG/oeydTgfb+xdkWZ9eGP2c0gxD3V/L15xhr7dx56IC7uYLZ0K5KKGOCW/OD?=
 =?us-ascii?Q?iw1UZGsvevwK1IjrE67hXEFbVxu/qxX+eqrsCla/cFUVQ0aYqu4GvqBRfK/3?=
 =?us-ascii?Q?GKWzzesR3r9q9qcSvH22CwlRcbtqEEvMb7o+akEIVOZTEMprfjnyWmXrx/Oq?=
 =?us-ascii?Q?linf4QeXa6kLaDJhTU29qmdg9NmvwYV4jelLtmN2x3A4//z4dI4fpNaRLNbm?=
 =?us-ascii?Q?uvQsZGVmbkYzCv2kSEKrHbtIXH38ECJNOFifyI8JZa1Ij0lGcaQmaM+R3GUk?=
 =?us-ascii?Q?JpbsagGqPRrOyBEMAe5AfKZPXNjKhPV4pF9q5C+g6PYlWPee0OdVYZht/gcu?=
 =?us-ascii?Q?xLE6T6k3zYLRTJyvDgH8tl2igO4S2Mw3MZm2IhVZJS02VFpGmhgRnvVS06dY?=
 =?us-ascii?Q?3RLAQeERxOXGzHOXnuy/uvfKyXPMHu+HkwTGhBvjxdzzjqL83JHMAdpqxsXU?=
 =?us-ascii?Q?8xkfhmR7X9Q1/y1fiZuJxWPo8Tlkt2lDIjkgfYiwEZ31tnkNuiZdb8/dREc8?=
 =?us-ascii?Q?l7nCLLXNCA/liX5IvKLzTyaNP6P+yQ4D9Nz7QOhvz7nQj033fl4HhE3zpzYy?=
 =?us-ascii?Q?Ew6TCT/XFNTt40/4Kvp4RdTCIS/DLC3xCMeNn3RsxlE6+gg/g2+1HdcFRoMg?=
 =?us-ascii?Q?bkSWzMLK3MCJI2rxvOurCa6YIX7OX2B5pGOVE0Y3XDT1D1/tXud7thnHMo9R?=
 =?us-ascii?Q?aTyoG9FgRGGf0RgLz9d0MgUI3K7Lwc33gmUy4DlDL6N+1tFJrOtsK5B+95Gf?=
 =?us-ascii?Q?tM+FIwThrgjU38C4XY2/XDqqye2jzrDmLKlz0J1u8QrOkZ0fHPnw/pDMTAyu?=
 =?us-ascii?Q?HEBamQXwnkdMqKgHuvdZVr8+/gANv22ZRlF9VLZZxBKxyUVlLHYtI37Hxlcb?=
 =?us-ascii?Q?ctF48hm4cYmf00fdyjXzH9QupH1c9CK3Unae0B7I2TU/fRK8NrhxRVKZPVFO?=
 =?us-ascii?Q?X4ohMTvo6cgp03ZaxWbrnH0mcLYhiuCHlyiqpJk9XLK3BfrdA11RVMpWqX6B?=
 =?us-ascii?Q?EuCCe12szNrHDqUHpsPVtNaD73zVxCOG7G/za31NVjyykjDyAMTnJUuRpo1v?=
 =?us-ascii?Q?e894K37/KZeQTyyQuZceWFFYOjR1YJ4v94hmyXACOXM6URddSmWnsoVAqmp+?=
 =?us-ascii?Q?XkwDGq8aUQS2ksxWssBCc7aPKPtxgOaiZtBGXTkZxARmSS96CRnUiKBZMLa3?=
 =?us-ascii?Q?xirIWmwCe/NVqolRTRBnLGrN5e5RENekA3VCIi5bhrqhXa0qj3f0b5fd6fja?=
 =?us-ascii?Q?NfPb6HIuzlCR4J5J/S8IZNMXc0MAXx5adHoetFP/LX4C0ZOqG2q/R75ca7FG?=
 =?us-ascii?Q?PLZR0SU8z3TlZvlW37Jq+gat8LdJWvfTvOHx/RnC/ULDCUnoQ0GncpkPbu0u?=
 =?us-ascii?Q?AKSmpV5VUKux6FT+QyxatkLoaNgdgbJG4kysaKcdiyD+4FloyIhffOpuZCo9?=
 =?us-ascii?Q?My00p2Iqt8vRaE0eFCeASkGYo/nI/GHlmbTsEqMKlLVG/wAUPzPzCPQd4DIk?=
 =?us-ascii?Q?pwfmuOVHTJyZk05FxTlufaNM2XiIVHZSzhskfBNA9dXTKufnOx/L3s7gUTk/?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04c7d3b-a633-4113-123d-08db889913a9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 20:45:24.6446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ih68FtXiVOfseugB1Q4KnLqa0KK569CcBtSR5tf/haJlAmwBjyAzt5AnJElk0t7ixw93IPr9vtP0Ta1ecNYrdey11FHamE1XcBDJvyxBzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4721
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 05:09:25PM +0800, Wei Fang wrote:
> When reading the codes of the FEC driver recently, I found there are
> some redundant or invalid codes, these codes make the FEC driver a
> bit messy and not concise, so this patch set has cleaned up the FEC
> driver. At present, I only found these, but I believe these are not
> all, I will continue to clean up the FEC driver in the future.
> 
> Wei Fang (3):
>   net: fec: remove the remaining code of rx copybreak
>   net: fec: remove fec_set_mac_address() from fec_enet_init()
>   net: fec: remove unused members from struct fec_enet_private

Reviewed-by: Simon Horman <simon.horman@corigine.com>

