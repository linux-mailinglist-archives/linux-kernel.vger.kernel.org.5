Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BD37D0925
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376374AbjJTHDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376331AbjJTHDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:03:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7F01A3;
        Fri, 20 Oct 2023 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697785424; x=1729321424;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=DVoYFPTIhcCNprsD2BdN0gf5jagKEx9iCOxHVTjywxo=;
  b=FwmwPwopLl6XZZLOynWmTq7U23st7HFA91D9A5bKnxCHaPPrFJ92RLQa
   FJ+G1zhEDUI3nNGEZwF+vICkarbJMkCA3wG4RLA6rd0yfpyt5l1LBVSU3
   frco2JCW2vBXnRVPUvWO8WClAQmdQ4VGVeH9RkefF+Sh+rLFPkHdpm1xX
   V5XL6eMbhFVWySukX8bNgNMVuuJ6Ev9YaL9VjXDSjM/t960UZSDOpaO5y
   apKI9/tqf7EprkpKEEdvs3CKhwKr2TN2wUOCyu6jlW4KmT6CYeUf9UkUI
   hD5Ej2wVRYkBQF2t05tZzaGfhGnR2YCF0SZoCrQGjfqfx9+czizAHOxYB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="385319776"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="385319776"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 00:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="5293179"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 00:03:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 00:03:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 00:03:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 00:03:41 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 00:03:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK5xAt+mmEIvN7z8EVsi0/PzQz24RfO9Kl3xnAS2lRD4Yq9V93zBfyaG/5cM7uJB6TdtclSLCCaoAfSygw0K+XYiqIgrTdGU2eMoG67Kf6+oQ89snQfANKmBt3ega+tgGnKC5Vr1q0wljl6CPDu0+jPDPaGB7yJ1pKpwP6bFY1lMSTmRJpLMc6ZqfEBxbAt2geQkkQHHSg2yYoRMe55s157mKTo2d3WG7ZuApgYWpH7to9wkkLFDQ64xkJtNh8RQSyHmdHJ0rG+scWalDw3JbYtqf99JzqNPjUQM+FK72L15NuIK4QZ2hO2K3OwCyr1TXaD3Lq+++fpgURG36mg1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62FKlY8A1lVxctMznNfagFc1UeckK6QRgj9IDMUHjaw=;
 b=QDZKXkNFOM31luOyutSEgdgRLNw0ycy3z4QrmvTTm2ImoxEhQsyNRXVZNf4RcWsrcI093gcxJvl7ZPl+BCkqwEpVJ/6NeVawVtFG3JHbDX0bDYMuITv8ovffP3uTTLjvvNRRC6Coetv+QFkhIQh1ZyFGoHTuOSW+cl8x3MEKE6igzBp5hVW4uii1Ir49OJnbI1zXnGcgUuAg3/zeL1wOHV1r3khGBPDFqNi296JZm/JkiqoyBX3aVOAPGR4qszigPDoY9goufSpxIGnJzHOXsU4Pz++hAu9M/KJYn35QouzMBY4N3MQQI1DmEbk0uGqKRTGoJuMlkiZhR6tOkcK3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ0PR11MB5184.namprd11.prod.outlook.com (2603:10b6:a03:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 07:03:34 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Fri, 20 Oct 2023
 07:03:34 +0000
Date:   Fri, 20 Oct 2023 15:03:25 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Chandan Babu R <chandanbabu@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [xfs]  cbc06310c3:  filebench.sum_operations/s -40.3%
 regression
Message-ID: <202310201455.d9efae-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU1PR03CA0041.apcprd03.prod.outlook.com
 (2603:1096:802:19::29) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ0PR11MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: c59e3648-5a33-4a82-392d-08dbd13aacb5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SkKAiRmGkZeahPAR1/ODYCo4LmjKqawtN6QiCCtXOp255YINCNrcPMGDzprbl5cXFAFIK/zJLjYyYqAtaaqZxve9umFFK5QZmFXXfO6pdAFeiuaq7BkfLollhduiNYxfz55iTf07EZSTJvoFDcii1e6rjfdXawzFAhWLJVZSWkzMHOyxnHyvw3xuDXwdHByTKjrAOr3PQ6jbjmDNnDBODCXwmCPN6SRaLhliRd9qOUREenOiE3yHxgVf6S5ykbLGrHhYZD1xNYUvcbSL4WUxWd+LdsRuzgfVQgrhtvLyFUxmXAc+48BJvzoQrnrDqHlU8IgQjIvk2k1oNo9zLNWDqp61RjmGmfcA+RcFSOU2ATYJEHcrIFRjivxCeiYuKWIK4SH3Dog7hb2wamS9sswIBzOXpLXHeFrB+JlYUNzYJSkwUFQhH/uhQ6+Li3WJPNS4KA+4PM455U5uFVIhYNNBz21dOTISJxSH4bWLTgUwO2bKeufV1Rj/5PFM/Hxxl5q3B0tFuIn+y5kzVAQNrIU2e15nHNiEikgXjlTlZ9UFHyH5ei1oGX1mOGeOGL9O7Iw9O4sZihrNqWQl524snUE/pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(41300700001)(2906002)(6486002)(478600001)(966005)(5660300002)(4326008)(8936002)(8676002)(66946007)(6916009)(54906003)(66556008)(66476007)(316002)(83380400001)(36756003)(86362001)(38100700002)(82960400001)(2616005)(1076003)(26005)(6666004)(6512007)(6506007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Y+dTlZY7u7yRuKlCzeNoy+T+A6iW0gH+yMdrmPxwUxHusNWHRYsx7pQHR7?=
 =?iso-8859-1?Q?7SUEE0+75wn7DOw2x80jaKXW/dzrX9zI+2Q+I4Ozz3Odoa5m0bfltK17jr?=
 =?iso-8859-1?Q?9BCUJKvlVD4l4QLzGtQPnm8UXAY8v6P1uvmQFphDfdMIdVdOs3GeRS5USr?=
 =?iso-8859-1?Q?xraARj0RJNcVljaMUXy5IBO+S80VBXSWnaGg/JBTf4ermPrswnDygKBhDg?=
 =?iso-8859-1?Q?/n1FS2wadYln/QSzQhQwxdmitAX6qMzQnhWeKKD+Fp8CxPdaQwygF5MPn9?=
 =?iso-8859-1?Q?h0L2SuHBwv4n5xOSWkuRW5Jy3iYm94X5dEpxr6DaJqTS+ZH+6Mf6SnHqxD?=
 =?iso-8859-1?Q?x7/a2eymN91CI5MliDkgIffdjI+sCNq4DeyigsTjU5oKUCAEoQ1Cl8h3QO?=
 =?iso-8859-1?Q?3qCr4jb0gh/bTglp4WqFtakKYfZ5clebAs9FUdzEVBeENSsqSc2yKPUNrp?=
 =?iso-8859-1?Q?jvR+HzJEH8oraWrZiK+Qm7Dprxx396AjclLYsuTKBcBDLTKTbC5qHBEY8F?=
 =?iso-8859-1?Q?Rv4H2yLbTUI0BgTH0TCoiJfbKppNywNJQthiMsWd1+ExD3vhRZQyn+heoc?=
 =?iso-8859-1?Q?eA935VRcS4YHT2p+DRZ2zWjHVm0xEAiqYMfm643fCORnVMVci/uIGeNuCL?=
 =?iso-8859-1?Q?cmJ1/ZotC/zMXDdnMJZchttyO09u/wOH7LfQy+whrAB6u02246BbLSnrwb?=
 =?iso-8859-1?Q?NTlcnB5rYKG6POh4cQkwJyTE77zQt5+tR4u5uTGjZ0EDYXhv5wN6g4OkYb?=
 =?iso-8859-1?Q?aE1wvqOR13Ymn1qLtL+wlK1xkBmhzIQGcE8jtyJ2XIKvVE3nt5Aims8lHl?=
 =?iso-8859-1?Q?sbcqX6wOvFALLxo0J+gxzMKNYJ/hifFl0x66Jw1aIAJvXfwWakybXnRymf?=
 =?iso-8859-1?Q?LwL0CNyqzOGt7Z9/bnDglFPwqRpahT1mErwx/5DuGOH3lFyPozlO/NhHNx?=
 =?iso-8859-1?Q?X13Gd+wq9BsaYFBOvw4J/VOHT+KAx1aUeVeOhOLHN5852tzYGt+iEJ8Or6?=
 =?iso-8859-1?Q?1b4cFyFB4l2DigEYf6IZb97c13NWtp6xC+Tb8r3zPp2SkYheXrX8zR7vbr?=
 =?iso-8859-1?Q?CUnnuClQpO7XA6X4jE7tRjDOC05PtnMLMghTsiHqdbhPcYPuGclNhhJrmb?=
 =?iso-8859-1?Q?moPD1n8K+ViSFGUZ1Gl9vYzfJfZRwsa7nuHU7OSBS62nx3o6BSAyBYiOeA?=
 =?iso-8859-1?Q?TTlUHcTMZVh6MyvgYrYcH2+SquIiUTtFyncgD+80gpS6xBKrlZ6J3UZJPC?=
 =?iso-8859-1?Q?HdWib8fFUlBh60orw0y7bOqyFi1S1opycCJ94dJSr98/YdY5vyxCQgdj6h?=
 =?iso-8859-1?Q?u3jqI/3rI0fBIT7f307ZICOn2ZNqn7ksMHi1DYoMYEqHNBEfKVOupe0+aR?=
 =?iso-8859-1?Q?e25iCu2JnY3ue8Qjl75aFN0hnFvnHgU7xrkUTbU8W2wrns5z4DaxwU5NCL?=
 =?iso-8859-1?Q?55OmwjBGdFDszDZm3WO8Ga8INo97cGvVuZJtS7mMqDCKRIbJS3nYjZVzVq?=
 =?iso-8859-1?Q?fn5kCcFSVcQ24TmvGS+UxRWAW6kPFObueqaRnxYvl3bCKRp+sQf3746Bvh?=
 =?iso-8859-1?Q?cm1985C2qwtjoRQZRXvrxU5Tu+sOwXudtJYpcwVM5qxZADlYVbLZKgkDHu?=
 =?iso-8859-1?Q?TUHUrEI31V9kF3cuFDr40Z4kIpoY/9P/wKxKx+PugT0ADS1qMJ2aTv5A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c59e3648-5a33-4a82-392d-08dbd13aacb5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 07:03:34.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+qyvbzowzU9g3/vcqDkvi1iE53kdsZ/D2/CYFBDjl0DgyA2/SkRTe9w4t5qC1AIhXEqelUq8SB4SgCPYjVYPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5184
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a -40.3% regression of filebench.sum_operations/s on:


commit: cbc06310c36f73a5f3b0c6f0d974d60cf66d816b ("xfs: reinstate the old i_version counter as STATX_CHANGE_COOKIE")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: filebench
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: xfs
	fs2: nfsv4
	test: filemicro_rread.f
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310201455.d9efae-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231020/202310201455.d9efae-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/nfsv4/xfs/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp3/filemicro_rread.f/filebench

commit: 
  f93b930030 ("xfs: Remove duplicate include")
  cbc06310c3 ("xfs: reinstate the old i_version counter as STATX_CHANGE_COOKIE")

f93b9300301d30f2 cbc06310c36f73a5f3b0c6f0d97 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.05 ±  3%      +0.0        0.05 ±  6%  mpstat.cpu.all.sys%
      1801 ±  3%    +192.8%       5272 ±  5%  vmstat.system.cs
     34136 ±  3%     +47.7%      50422 ±  5%  meminfo.Active
    264.26 ± 11%   +6281.8%      16864 ± 20%  meminfo.Active(file)
     22783 ±  7%   +1234.4%     304018 ±  7%  turbostat.C1
      0.03 ± 17%      +0.0        0.06 ± 11%  turbostat.C1%
     60181 ± 10%     +93.2%     116249 ±  7%  turbostat.POLL
     68.91            +1.0%      69.58        turbostat.PkgWatt
     64.00           -40.2%      38.24 ± 13%  filebench.sum_bytes_mb/s
     32765           -40.3%      19568 ± 13%  filebench.sum_operations/s
     32765           -40.3%      19568 ± 13%  filebench.sum_reads/s
      0.00 ± 33%   +1911.1%       0.03 ± 19%  filebench.sum_time_ms/op
     20275 ± 31%    +269.7%      74961 ±  8%  filebench.time.voluntary_context_switches
     65.23 ± 10%   +6225.9%       4126 ± 16%  proc-vmstat.nr_active_file
    517254            -1.5%     509753        proc-vmstat.nr_inactive_file
     65.23 ± 10%   +6225.9%       4126 ± 16%  proc-vmstat.nr_zone_active_file
    517254            -1.5%     509753        proc-vmstat.nr_zone_inactive_file
   1199999           +24.8%    1497636        proc-vmstat.numa_hit
     13948         +1878.7%     276000        proc-vmstat.pgactivate
   1767189           +17.2%    2070794        proc-vmstat.pgalloc_normal
   1733917           +17.5%    2037105        proc-vmstat.pgfree
 1.462e+08            +4.8%  1.532e+08        perf-stat.i.branch-instructions
      1683 ±  3%    +210.4%       5224 ±  5%  perf-stat.i.context-switches
 1.943e+08            +4.9%  2.038e+08        perf-stat.i.dTLB-loads
  98635751            +5.4%  1.039e+08        perf-stat.i.dTLB-stores
    177093           +18.5%     209883 ±  3%  perf-stat.i.iTLB-loads
 7.228e+08            +4.5%  7.552e+08        perf-stat.i.instructions
      3.91 ±  3%      +6.2%       4.15 ±  2%  perf-stat.i.metric.M/sec
     10.86            -0.5       10.34        perf-stat.overall.branch-miss-rate%
      6.91 ±  2%      -3.6%       6.66        perf-stat.overall.cpi
     80.11            -2.6       77.55        perf-stat.overall.iTLB-load-miss-rate%
      1012            +2.9%       1042 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
 1.455e+08            +4.8%  1.524e+08        perf-stat.ps.branch-instructions
      1674 ±  3%    +209.9%       5188 ±  5%  perf-stat.ps.context-switches
 1.933e+08            +4.9%  2.028e+08        perf-stat.ps.dTLB-loads
  98135969            +5.3%  1.034e+08        perf-stat.ps.dTLB-stores
    176255           +18.5%     208779 ±  3%  perf-stat.ps.iTLB-loads
  7.19e+08            +4.5%  7.512e+08        perf-stat.ps.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

