Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D200C7609F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjGYGFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGYGFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:05:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8544E5A;
        Mon, 24 Jul 2023 23:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690265112; x=1721801112;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=V5D4jmotoFqDMHTLeW6gqZOf+M9CI1KtkZuy3L3YrdY=;
  b=J40xG5ihni4To2TO7ZYMDXjCBtQyTQk9lF3Wmi9Tmg8GXr+ajTBLiepG
   Yo6slHoV6pQzBu4lNB+K7DszGdnOhzs55kDy0JcVRJxVBOQps4MX5Zuhn
   snb9Ue61KS2geGvMkh0DbRUC5kcnD77OQdSQoicQLp8tF/OgNBe7k2l/f
   BGAzxH4xb2t6Xr8nyBJxAjJWpnlBSbwV+AIEgStPD2r9pnF4BRdNQvGID
   AWLFIkIHD9ejPpxZTRmJbVtpx9WbT51jYleIWunf+ySRmM7HGVObBSEs9
   M0UKzwBXYprDXBGHQ54jzK5Cxp1MpcySkxP4G22fS7dOGpwLn0cONjtX3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="365084059"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="365084059"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 23:05:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="839732949"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="839732949"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 23:05:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 23:05:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 23:05:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 23:05:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 23:05:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSrlRy5NryjXHBD2/12drYiP1iNFWj2BZP2DbosRmwJbWUlJnHg4MAAyEpUPmkMXjPdmaLJqOXj79HYTIryuWVIyqzDvd7URzOLNHE3TBO1rGa9vFXgE6Td1nlFHn4i7aph1qEKyxnC7SuyGg2UfaFocp9RF+wxuPFIz1qmzRg2ipiEYWNj0JmSLmM7AKIyzaSLDJquAxPlCPPlNmH/i/6KOV7fiW7uH8OIESP+RBBCcIfIOrVO/SCF4aJaYpIeE3d04O4mqhMh3tk0sJDzINLLLAXYDb2uANW2cgGLuz4bLdj+KRdN01iG0FMtXxlV8iXrSKfDnJikzD6baCNF3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vPczETDM2uNEuO+hU+PGi+pPMEl8av1N70VmHRV4VY=;
 b=DnZEUbYT2L+v0QrCQZ+PokDNYS05v92+v2AS846ZOeXu3ESFjZXhjUGSJw9YfFOX1DWsqRjo5ZwwMxLbwPicfqcYAuiPvPOMlj/bVhS+157QNrDD0ouEkB0yiPfyH77TeAeZLd8Kuza8s93JAt1pObcanU6IJgJj6mWxd1PIhAVE8OTwJuxm1RGbvGiI9IrzWUETNSR7lPmObaSKMI0l7KF5SisQ+u5Nu+0PK2F3Y3+HclddrzRR7wmSAny/QgEV9JpNBZyB05czEsyFUujs7/xSwk8q7Z8jFmVd9dSLUXPqSOrDxHqeeyT/sokFMLdgKIOTQciyMJZxIekj9y6zaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH7PR11MB5861.namprd11.prod.outlook.com (2603:10b6:510:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 06:05:04 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::c407:a2ef:2fde:f6d1]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::c407:a2ef:2fde:f6d1%4]) with mapi id 15.20.6609.026; Tue, 25 Jul 2023
 06:05:04 +0000
Date:   Tue, 25 Jul 2023 14:00:52 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Changbin Du <changbin.du@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>,
        Changbin Du <changbin.du@huawei.com>
Subject: Re: [PATCH v2 2/2] perf: add new option '--workload-attr' to set
 workload sched_policy/priority/mask
Message-ID: <202307221757.XGfZBmn4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230717120003.2391329-3-changbin.du@huawei.com>
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH7PR11MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: cb181051-5a84-4147-2bed-08db8cd516e1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfXdyR0pfk0UKlTXM6z/gch+9p2UnEquiN3Pnm1HIAGPnjrQFbbVfVIQckEE7pu1y7GeGW0sZgEKNY9zKKP4h+v0cgdbXadhV8P1328syrekx6L7jkiYUkoicm+QuaT1Y9Vs4uCj1W+3YkEk0UR2uPGHo29H2nSwZcyECGakJgLStN/A8EDLlD3/vL4gOKEq4fDrgk1jZaK61VGhilvdAvaM9y6LO6ZnBQpPOzBFhvAxQXoepnk3WdQ/zMnn1uwE1wVfLa+D7FYTiRbQOhLl9dbwkaQ9Q9R46mCP7WeUmSuVAzlgS4m4BLWYmi5uta5V85aYuyhBb8ZqMbbAbMojSrd0Bhj3yyMfUIyfOX+U55F8z8OHCJgv9v/refXKTmMG0qRs09jZ0tGgRwQwYqjEZps8yRoGnUvq2gsn/NVZvfxnJJPWi5mpL5AKeLaAGJqFzC6xVfs6wUwZ8czrC8gjjTPIbvcdwuAC5RM+c9O19OBECI7l2IVp3j/gAJ1MgdW3npkiQb1rr8PQKjMc6d28f1LYEKVqx0BgYbJkPKHXp8zHpSpsKyDT1ONiTu6GHE+LFTDOonsDYETIHZIR5FM+qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(86362001)(82960400001)(38100700002)(4326008)(316002)(66946007)(478600001)(54906003)(41300700001)(110136005)(966005)(5660300002)(8936002)(6486002)(7416002)(8676002)(6512007)(6666004)(26005)(186003)(1076003)(2906002)(6506007)(66556008)(66476007)(83380400001)(36756003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mgqcf1h5fuWF8DjON9R8SnnR4KheNSeZIyCZUMNEb5XlFz7zrXWSr0EbLx2Y?=
 =?us-ascii?Q?LL2ch6A7tSryFhHwUn13jxjMNdduzcHol2b2CQc/zqJP/SGe8I7uku6TUhem?=
 =?us-ascii?Q?mDzQDWIgiPx4/mY0szGuLpnZqATpjudHsinWxKTM1z/60dcOkHvYlwWpB2xX?=
 =?us-ascii?Q?ILfuyB2bvliqLhLDQULpLiUJFW9vVUEEmKREUp8SliysBeJKxzE8RUbAUM2d?=
 =?us-ascii?Q?VxK9v+cYz9frIfYTUkjeCG9kEb6Mwl/nBnt6Rc6uwIZVv2BmYSWFAfWqYDxQ?=
 =?us-ascii?Q?FzQwlgoBwortdtr8WKbN2LOng8SdOmXuw+ojc0eNw/CyuVixuhkcgv93q7OI?=
 =?us-ascii?Q?FpaZ0ATjOfLems09CTIdgT0uppD8DSpfGv4j3XQoJ1MB6LRi2+xNYoYJznX5?=
 =?us-ascii?Q?3wj061fA1PNDfEgcy8vKcdii7UdUS7iLmrs4fbYIXAUgg0xUxKbKesWt8+9I?=
 =?us-ascii?Q?cf6E/lplLq9Jg7PAlKkHeA7B3OFZWy7H7PDHFrkTfN5F1P2rs8m1S+BuLK+b?=
 =?us-ascii?Q?aq7dBh8lAYWhZS5oDWbFt2YmjD0E2mVv+HUkKazmw7ZkUF/CSQ05iOUIgm21?=
 =?us-ascii?Q?wkDYemv+wS8YGLXh4SV5eHQsFnR26zxMyF5B6dBo4gOTpK7OtTcpxePQBxr1?=
 =?us-ascii?Q?9LIaAMFRUhnGCKKdkwI9DXJvj5JstNSzqyqmFOoCJaSNhjQoikFdBBMWK/fq?=
 =?us-ascii?Q?J4+HQcjmI8CM1sD5sm7C6lXP0eCmf1oXw5KgWpvmUPxpe+PnKa/kpZW29s49?=
 =?us-ascii?Q?OIznMxkvHN9j7LePcr8KCUmqNjP7EjFBVnpFXRnBJUblpUlLXN59IzKKWMJ5?=
 =?us-ascii?Q?5Lh3SjHs1u/y5HukJK3NQoY4TyBv+WeoPez17Nsv3z3W8BKd5PKk1+wm+HU8?=
 =?us-ascii?Q?cGJPu242DYjNiClUj4hKNoVZ9KM1s9sf9EQfFu/5hC4z8eBnoibo1tUCUNLy?=
 =?us-ascii?Q?l3wXpaOaeworX73Na0Ub0V7Pwq2tULKeCg/LB0urqncK03TADFGsS3cVF7QC?=
 =?us-ascii?Q?WsfnSFYymkcLUYIH4DNQnZ9UoRdVqC8YWJG3Svr8YxWjdRXsoY1AyllCHHN5?=
 =?us-ascii?Q?LO6ktRNpbwUEpv1FfGjHD32q7qTY7xhkcQ0126dmIxQbymJtRWzJ70Qasa4H?=
 =?us-ascii?Q?OBF4twibbYvIDV4ztlSin8OoqvVZIEpJv3GJPbqn+gXQFHCspZlFjziTu/rQ?=
 =?us-ascii?Q?pvX73MyvMka0dBXhnzPy+WlryEeYbF9B7JgBTz+0OQlTk3P6+IWkrSg+rOmT?=
 =?us-ascii?Q?OG/i9mmpjH2vwHv2MSiZJLJrzGzNhX9JiOYfNlt3Bx+O4PN/dlkW9EgfDYf/?=
 =?us-ascii?Q?sFjUVmCQGNDhCCinxYKJOBMwLYcF8MNdO9cXEeug39i0KGmTl34aCj+Im/Yy?=
 =?us-ascii?Q?Or+lCEa+dGrHIHEudxGKYfFqAjwNAPgS0gAR/7Jg7XJP7vcpH9MxwR4evS8l?=
 =?us-ascii?Q?I+5e6A0eLs6UXQsMu8E4qV3wQmLvbOWMMa3WqAzfVXgW4s9M36eczdUP+auf?=
 =?us-ascii?Q?cB28jXDDnxi0DQEkKGxdR6sgSUqgZsfb6ROiTT6y17rU+uUBAP5UcvbafCoN?=
 =?us-ascii?Q?77iE5rYybkaHpLb1e5sxNOZyMdXsL7tnZIzuSESj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb181051-5a84-4147-2bed-08db8cd516e1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 06:05:04.4217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2MwRYANNc1b8f5RSeX7iMvFo0if/2AGviWzbOuSBeER9zDu3mANgPjEbrJ9vmL6mHmBLSO0PSDPMxelY2Zljw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5861
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Changbin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on acme/perf/core]
[also build test WARNING on tip/perf/core tip/master linus/master v6.5-rc2 next-20230721]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Changbin-Du/perf-cpumap-Add-__perf_cpu_map__new-and-perf_cpu_map__2_cpuset/20230718-192933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
patch link:    https://lore.kernel.org/r/20230717120003.2391329-3-changbin.du%40huawei.com
patch subject: [PATCH v2 2/2] perf: add new option '--workload-attr' to set workload sched_policy/priority/mask
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202307221757.XGfZBmn4-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> tools/perf/util/evlist.c: perf/cpumap.h is included more than once.

vim +60 tools/perf/util/evlist.c

    50	
    51	#include <linux/bitops.h>
    52	#include <linux/hash.h>
    53	#include <linux/log2.h>
    54	#include <linux/err.h>
    55	#include <linux/string.h>
    56	#include <linux/time64.h>
    57	#include <linux/zalloc.h>
    58	#include <perf/evlist.h>
    59	#include <perf/evsel.h>
  > 60	#include <perf/cpumap.h>
    61	#include <perf/mmap.h>
  > 62	#include <perf/cpumap.h>
    63	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

