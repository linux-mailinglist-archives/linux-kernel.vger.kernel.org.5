Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34537F57E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 06:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbjKWF4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 00:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbjKWF4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 00:56:30 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FDC9A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 21:56:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCtucKL2k2qSSE8EIGRGfr6wQjaCuAKc5DtQnXl1OY1JvLpX35HLn4ZJo1pAty9L+ZTbszi3KAcZZC5yMVRgCXtZzCht4ZhuzhYrGg98Kx7WV6qiAS+kVLJFDV7FNSzh7JMppq9TpaUk01aQWCuijBQwHq9Cl5XdnFyutImkcX4tpckaKDhhjTpmy8Lubzt++ta1VaHXrbrbxvbaC3bJFB4NS76O0UQpzYXJYOGHkx4+QETkuYk3zBJGbYBhVUUnV7HBYNbqqEASY9C/19RlCnP+JM0JzDt6IQPOjWXpwWP0SRA0yorOeTvoIsqqHhyFlmIqfdE3uLvC13Zy+sJB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3M2rMaGLxZ56wvq65RT84Trqyo0IebavMEfo3sI/IbQ=;
 b=aLtHXRb9IB3tBCDAKQzLiz8wUveVum52yVtF8Qe0B4keFct43kcqq4dV65gfEIQT0Hy9rRyTjZD20pOnkja8EMvFbYRYIV9zP3w+blZlWMc3Qxz0ngKDPRiuAfn7kxzZk7nC0WhQOe0h9R883ecqYFCvmpILdoEzU0QN1hjukPtg7AeZm4pO99XF92tAfqKWHUOahfvlVsD6aYeCF92TzX/39kUrgUnAgoXSRG+j0CCuBoueIpF1wDxXErv4vIzB/Vqhk4Wk7u5SXXVxmXkp2f6H0HNCs5PI5FR7P8Te7vfzhSNwRI9M/bWaHURdIKLMFjEysfdN1ggBDGmPwwfYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3M2rMaGLxZ56wvq65RT84Trqyo0IebavMEfo3sI/IbQ=;
 b=QyHQTEl8JRRouCMkXxAcugOE/+ZgZFLtA83gjiyGLaiADNd48nDiT/X7fTQN1NvYeu/ucHT56WymMtW6D8iXhFbKbrOq05g6Mqt9uQN7pBmiYaqtrSQz+ylkKgfUb7O4mVBB9ItjX0QucFmYgP+b0HlpkQtBhfzswaImtTzw+mBQtZYVbWrR+3uIjqNTrr63460oqbB1lUqHT02KGN3K7NZ3bykKAaQZ4Ag8o/t6hgZoegGVoDBgn9E/PlNdwhIsiLID7A7PGrYs25PyOyFuaMF8tqzWlAtjbD+LZTXO/0dvG34x54PP51IQ/nzyMKP+8CFu9vvhennrV9cRlGpdCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CYYPR12MB9014.namprd12.prod.outlook.com (2603:10b6:930:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 05:56:33 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 05:56:32 +0000
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <20231122162950.3854897-6-ryan.roberts@arm.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 05/10] selftests/mm/kugepaged: Restore thp
 settings at exit
Date:   Thu, 23 Nov 2023 16:54:41 +1100
In-reply-to: <20231122162950.3854897-6-ryan.roberts@arm.com>
Message-ID: <87bkblxbas.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0023.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::7) To DM6PR12MB3179.namprd12.prod.outlook.com
 (2603:10b6:5:183::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CYYPR12MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ffba61-829c-470e-446a-08dbebe8f0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Et6nooUef+pQh9CN/O2nQpUngwA+P9g3jfXRmihROxaLFNsAPeZtxHxgFeir3k4xphj23kIcQ7u29k4OwhAavgCmVydcYruZEqI9igZI0wGBZVJuj2yLGTzEUYpyPDIBiPN5Fws5IcTWurBL+JYC8kfaFu+vIbCIe2reqrFcT17wKyVD0eLYXsM/tYuJqbjoC6uz8VTUc7WrpCduPb5utdZXCdSrgu5+FxJzc6ra6FbKBWsHu6oNkHXOtENxLppHzuLVdv2saLN8wzaFQnu9vZy20pi/Ezg9yujhQ545WQWsquR61IWSCKy7BOP9bI7ejyVsEzuNMY8BNhIhM6Y2hqtF3OdG5qzK9/QO89nlBoaqEBCemlSRa1B4OEF4rOouw91HFpk+44YO+E+v/NABNDjz1oPBNW5xMjnh0Gf4fmbapSv6BUWTYJkYtKtgjraTXWweLVakP/CUg2MtECoLs6jo2phqFRTO6LC5yOIFcB4KJpfKJeBkx/DTxGnibmswmv3UABckOxUtAhBwadEs6ACuj5hvllAwFTMCz2LR/FvXmulm/jpmOtNLS6cU4Vwo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(9686003)(6512007)(83380400001)(86362001)(38100700002)(7416002)(5660300002)(2906002)(6666004)(478600001)(6506007)(54906003)(6916009)(8676002)(316002)(4326008)(66946007)(6486002)(41300700001)(8936002)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MZDEFE7HdRKinAN+QZ7dK6uztU2B7g+AGZ7Amdvhol8R9ezdzHp1vgUipH2z?=
 =?us-ascii?Q?qKQHGqWnYja58qHYDFv3QPv2lL8QpHul9EF173hP93Ti9pVh8JJspj32peJn?=
 =?us-ascii?Q?XxMRQICm7iQkLqEVBFchozgGF4+6g5BCgT5VW1ANLJOjIxXD1uYJ3dO+VZYb?=
 =?us-ascii?Q?0AE5pMyj2PmZ2BEl7isaLLPUp4HQbbZEUC+BDGNJbEmFSLYSdKzMrAVWOYrl?=
 =?us-ascii?Q?Q8dX37PhrbMW9Y/pYGfmRg6H9sobrzASum4GMpY1KvbepDbft6zMNG68Vdn1?=
 =?us-ascii?Q?+Ux/ca2z11Qj5OpsHKLK7xt81ZADBc7CxL0miWtg05Wy5q7gitcP8sIJtiZq?=
 =?us-ascii?Q?HDHUSEMBsoN13r6bVUHqQwOndwcyR8xU+7+NhYNUlroNaC4Iz5OidvdA/lc/?=
 =?us-ascii?Q?qv/ZVTwZoE/BEznOIIbSSZSQjq50t+n0qOVWf66oJQkRDTD/NUAv5Mz9z1PE?=
 =?us-ascii?Q?qY4Bgefhq9EOotWMgRKm1EI6hz1jzR8j7ZTeQ90PbWuD7hdrqOyfiRiAZURG?=
 =?us-ascii?Q?XxW1wZJ1d3ownAq6qLry8Y7PFuI0LM7oJf3CxqHoizNE816TKSBUCBIEIb5n?=
 =?us-ascii?Q?3TO2OM78i/z4qfTvV/hi9AXxY3/Xv347MG1+n+0JkN9++GI81M70n2QZugYO?=
 =?us-ascii?Q?QdFT6ZFZGyk4NNlkmJKOvYEvax7naUw5seZELKdD1cPWOQr0jWUcw2sSKZK1?=
 =?us-ascii?Q?rzpnauOLElnsJOKzLaLln0MADCo+c8FZl8LUofYnB0J0eCbgWGKAFfmg5CaQ?=
 =?us-ascii?Q?8x2W/VhAv5rvGdsIlxJzTyW6WFoVykAw/qOP6zjqKfk3aiUzMT2l9+lpPvd9?=
 =?us-ascii?Q?iZtSCtyDN22SWqwJEPekS//nkojRVAsNVuBrRPEJvIGytAVqjZdy5zaOLjA8?=
 =?us-ascii?Q?5jVTMGEByTHE4mMRPUebu741Ycl2GoFF82XWoufhc3FyiM/sWy1lNTqOhfU1?=
 =?us-ascii?Q?p23nTDwluWux4zGOxd4cNB032ak2cP9nc6Y6WeqXMsMdz5Y0Z03JxQm1eaWV?=
 =?us-ascii?Q?vARe6LLrPjeVGPkAkJ8FFP4huQ0OuZLA/gvBTIDFSwEmLhb+Zl68tNWlOayl?=
 =?us-ascii?Q?5r93EQ6wn54yVGYMM+Tor6GxEfStNquB2DbGHHLGb9oQP1qw3CtLQEiEJI3X?=
 =?us-ascii?Q?sJIqU6RA0UxgLeLK+b2LBVh4GBqJoTJkCqy4s5Z+m3JzCH7If5P1msA1Zrvf?=
 =?us-ascii?Q?Lw4Jhx500py35Xz3pbiKvs15yPL79dCMfMO0IrhLxDcz7teI2G3JB9hq8Lj8?=
 =?us-ascii?Q?k5zcY1lMZjRB0ZZn4QMdAjP3SruaFFSXkdmF55mhtGyDm0EUNtmQI4cIkxNk?=
 =?us-ascii?Q?UAO9ZAXlFaXPdtj8uGu5En3mb62dxl6qu6Yeakb0Q1JD+Tdww5TPTxbem+eN?=
 =?us-ascii?Q?u9Xs1Xuynpx3XTkc3XjW9x3zFmPG/yU/3cq/vT5EgxNd/qSQhODTfTS+mbuJ?=
 =?us-ascii?Q?XqftllOGqToRHVE6aFwXU6E4YADbtl1my0e8xUrYFCuB9XzwbOn1sy5YALDv?=
 =?us-ascii?Q?ISqcR1Hxi2hSydJNZJZtX1IsZQKVCCwMJC4Osy/71MrOLjlTELn8Z5pNBrYs?=
 =?us-ascii?Q?BgPPx+eEUM5ChWnKItOTQFLSifTraoGJ57jNGzqJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ffba61-829c-470e-446a-08dbebe8f0ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 05:56:32.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWmZ7D4yzGST9pHRm6mya0eRR5b9RbJu/usjt6RclV7imPMoVmLQPO9Y0pqhCWc5uyFzxqaGXzHfgbzm8rzDVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9014
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan Roberts <ryan.roberts@arm.com> writes:

> Previously, the saved thp settings would be restored upon a signal or at
> the natural end of the test suite. But there are some tests that
> directly call exit() upon failure. In this case, the thp settings were
> not being restored, which could then influence other tests.
>
> Fix this by installing an atexit() handler to do the actual restore. The
> signal handler can now just call exit() and the atexit handler is
> invoked.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> ---
>  tools/testing/selftests/mm/khugepaged.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> index 030667cb5533..fc47a1c4944c 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -374,18 +374,22 @@ static void pop_settings(void)
>  	write_settings(current_settings());
>  }
>
> -static void restore_settings(int sig)
> +static void restore_settings_atexit(void)
>  {
>  	if (skip_settings_restore)
> -		goto out;
> +		return;
>
>  	printf("Restore THP and khugepaged settings...");
>  	write_settings(&saved_settings);
>  	success("OK");
> -	if (sig)
> -		exit(EXIT_FAILURE);
> -out:
> -	exit(exit_status);
> +
> +	skip_settings_restore = true;
> +}
> +
> +static void restore_settings(int sig)
> +{
> +	/* exit() will invoke the restore_settings_atexit handler. */
> +	exit(sig ? EXIT_FAILURE : exit_status);
>  }
>
>  static void save_settings(void)
> @@ -415,6 +419,7 @@ static void save_settings(void)
>
>  	success("OK");
>
> +	atexit(restore_settings_atexit);
>  	signal(SIGTERM, restore_settings);
>  	signal(SIGINT, restore_settings);
>  	signal(SIGHUP, restore_settings);

