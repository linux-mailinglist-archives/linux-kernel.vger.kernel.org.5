Return-Path: <linux-kernel+bounces-20949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219598287B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D661F2480F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9853A39AC4;
	Tue,  9 Jan 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqyyoY0q"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32383A1A9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704809086; x=1736345086;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=5zUN6lbkJk0sWBb0UKbrBUAbi2qLD/aLNQrdM8h/Gmg=;
  b=UqyyoY0qS2y7QI+9w8G6wpN6bWGOKCRQFENwF2vCDWpppnLk/TIYfUbV
   NzJoqa8aGpWoexZDwyLjU5+mQmN5TEXEaFXi3QfdGPTzakOn2UC2XFNyg
   TGcv0506KwhtDajtSThy24sSoEUhVqchKk47WIwrvz7ZCB1ynakFEEfxB
   rY849sHuN0MluDTWsHvPbnjQ+8Q7hf87PzDniXNsymZCZdjUJ70VbezPN
   GEjow+vYhGK9160gAI4RC7A6bBlBHSXjlDWab4+XAf9ZyPQqHMQy+cB9n
   Eva/1WVZ/3OMQtIRRT6azrJLN7JY3uxPFTOn2q24RZkuNdbXC7+2Lnlo5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="395366918"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="395366918"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 06:04:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="781809802"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="781809802"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 06:04:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 06:04:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 06:04:19 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 06:04:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJ5LfRiID8CD5Sus0Bj0gLMtYchNoVaZnQInfcIqcQB5VK95dXigmxielsix+sgZ7N/zHZ8SfTJrEOBIKBvdNK62WERuukeyx8i4BubmKsSNjzwpzKrpGjNImqvXqOgP+VTMZo3pdGp+iCFcz887G7MW2uXGi9WjysY67i01T8okBOdmQqvRqr2ejF+EBw2OMfIkaXLMeYM04JZlmvtQCGL+1xSkSRqLRkyJBniU67u3VcXUAkxJylxxWM0gT+FoOHJK3Gxj80PKEePPxPli+AE5GRzNCPnWrqpErku4/9xrDws8wBePcue373N5WcgjcRsb5ktwF+yui5nLcp7XHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFG2PmmPCEFIk9GEHlIWHB3XNbYhzJliXF6NQM+0SZg=;
 b=aQwtT8iDp0hH+wCW9LFPCBR2X5OGKQqUKKfgcC04FtNah9imk8efou3m4nCH8hHxgf+hWLaY+JYptpbEnqR/MlP0xIrlserYfF6Z3Ocbp8LKhhviPsVhptCi3ifEFS0G935F+eVKJPcU/vrcMyCdlchOLXxUdQVgHcdWD3/4BAjk/ivnSahCM71ySFJp6l3gThqhERpAmgs5IT7QZUqvnCVkND0IR0TLW+XOPqK/XrBC6kM/hSIMol9A1HElxWpQ5KUfpAp0/cB5qf8W7Bec2IMXKD+pu1sSOSznq2saucH3PuwjIAhyEF3oYU2W5RM9bpb3MIXgMzoiyaAr3ZM1BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB8593.namprd11.prod.outlook.com (2603:10b6:806:3ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 14:04:07 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 14:04:06 +0000
Date: Tue, 9 Jan 2024 22:03:56 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, Peng Zhang
	<zhangpeng.00@bytedance.com>, <maple-tree@lists.infradead.org>,
	<linux-mm@kvack.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [maple_tree]  4249f13c11:  aim9.page_test.ops_per_sec
 3.5% improvement
Message-ID: <202401091651.a189376-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2fd07d-bb2c-4a5b-6170-08dc111bd7ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /oCb2Up0884/vRtziVyO/9LXNByq6WqjyxcE9rKRnLriGIPuAdzonwmpVNoj0qyN3bSNC4n2hKHpWTLzwqEXiYwUXNTlRmBvsaIRBC4JB07HknQ0W+NOrwLfZwItfKe1CJRWkmtMhsdaa1Ga0MI/hrzGq1ET3CQOZlK8vruCnTbwxSAv+GBM3N4uYv4fsqIA/XFvqESeSDhdU1MRPZM4VAt2UBue9Y53P+L6GM9rZIrfc3sxvaEL29FQLzYeETc927bUA+DsyD/qGGE6LMC9W00UQPYStLzNlJGpAY/i+DX81AAUYM/+e4GwFL0P8hTBdOIWWCHP4VvNyzMpoPzCZMDnfjaai+Uc36I86XrOqi6T/hAEIKodR0HSr+12R3bXrggN4eWr/i5ulctT/XISe3X+3gMLRbDzAEAc7qAzGWagJexDNUfAWAngU6TG2t44QFVMSvWVZoE2/mNQuTr6R2+Ml9o3cImEXR0PRfbvBf1/21PzuIjB5EtKZMRP2WsGOr5IaLOgkVXEZjtgnaPtL5NzUyWWK20AG+7wEsf2IHx1A3ibn+443JzMs84BkIq7aQ+DSPmGEB7Ov3CBetmX61Qfy1KwfMDnpBomH//tGZanFQlTkudivtqISLZS3aFd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(230473577357003)(230922051799003)(230373577357003)(1800799012)(186009)(451199024)(64100799003)(2906002)(6486002)(107886003)(2616005)(1076003)(26005)(66946007)(66556008)(66476007)(41300700001)(86362001)(36756003)(82960400001)(5660300002)(6506007)(4326008)(54906003)(83380400001)(6666004)(6512007)(478600001)(966005)(6916009)(8936002)(316002)(38100700002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7apKChJb0j7DH1hhBpaIegQpx9hoABLErOiwVXOJDXiyNkltZLDUO9d/n1?=
 =?iso-8859-1?Q?VSv0oddbIwoRsfDlhd/s5LGCj5hRkHGvpQ4li64Z1I2CJhT2o/UtTQE7KX?=
 =?iso-8859-1?Q?ODF7pms4t1PNfdkBVcm4JP6JyHWPvBGaWz0A7u7bbyl4XizQ/Z4L94K4mA?=
 =?iso-8859-1?Q?d+fHFAgFOeTdVLkPWuL+WO0vybH5QmheQRpqDUvr0TJgG4HSRM133/UgFb?=
 =?iso-8859-1?Q?VFhtdDHt4mh9tdIhxWIvayD1/1sB8vlwXVtcISDA3/fMBCkgdZUQElkcYx?=
 =?iso-8859-1?Q?ENkL6QvvIyd06UXRYHZZ3rouTe4MA2MQmEWocW6nzzZ8FC+ukksvnDqXIV?=
 =?iso-8859-1?Q?CmD1F9+3hIKvoHoYTvULI4OTvt2R8VQI2yTTqx48n6G/MFgWvAeezlFwNQ?=
 =?iso-8859-1?Q?A66pQkFBonAzwDTPg3W7lfBU16VbZSJA49NKFPslUyfpIwJBHhJfCdEzXB?=
 =?iso-8859-1?Q?hv/JsQVml+l4Jdm8EsZ6oRAwCcpjNYlhAk91TdAy5i/P0BBT/6lsg87Zhm?=
 =?iso-8859-1?Q?luVI4vNnaaPLFjv6Hm6vd5Kg/auXRDZpUbYo6MzVC0a9op1xFRf8Cnnczx?=
 =?iso-8859-1?Q?VyinAiW3VEmGYJ1QLlcCfqKpzvagAOwUto89ylLKhzpviwneyuBIOAkaTb?=
 =?iso-8859-1?Q?7sQJHfkwHLXf37NPMzeceymLVnKNa3eDEbxF3g+Y92Hr1FS8RS32hqt445?=
 =?iso-8859-1?Q?IS3TINxkGl6hJV04u7fGvklQkxVRHfbP44dWnIrIYn9zfkt8rkdD9g93GF?=
 =?iso-8859-1?Q?K9F7crZXETIy7zGcfN2Tj21GANT9fFL/10UBRbGnFYv+auqUPh5lrh4oVc?=
 =?iso-8859-1?Q?GT2NbCnmnLu8Y7bUzcoWN1T3pvI4V+Fu63IAdXck0NdH1y1ZiyWU4gt0ks?=
 =?iso-8859-1?Q?3TBHygta34sxbz/cXT3+XK9ZtJiKe/FoRI71C2dSxkS+XbvlsRk9lmfdvr?=
 =?iso-8859-1?Q?nMTUbGXYaiOzDLwC9uzZQm7UHfNB7CJYss5tTvZOHCxzhIyArmkQTPDEAW?=
 =?iso-8859-1?Q?M0WyYzaa0jQnSr8/hBSLZiI8nR/53u0rNQsPGNwKc5SUvJe6M7aaedkRgb?=
 =?iso-8859-1?Q?4JTa52vC77SzQFwYW22J9f6R6ZwKucO/bWg3BECRP9mCz+5vhIAeW4VWXY?=
 =?iso-8859-1?Q?ksuMTBTYh6hIm004EUek3uJWNI8Bp2hATrFjkyWw17suuciXi5jPeO41Ge?=
 =?iso-8859-1?Q?r+LkTx/+LG7d0BtG/LbYTqQv0tzug3eRByn2lRvRI7W6NYwWEUdyyOqA23?=
 =?iso-8859-1?Q?H/l93kmQqZfULhRZ+rut1r8iOaCgccaEbt8NCxON7qkhLP2rTPLO0Al1i1?=
 =?iso-8859-1?Q?8w+mDeThoNzq7u3UKdSnhQmh+H6CBW/qDsTyPBCItFHReoIxn9mCXj8DX8?=
 =?iso-8859-1?Q?TsAlHdPmQ8FnIfN8BhdXBKwVImT23fnBBYdWQXuJM+ZtGA+RPR3XQ0oAoG?=
 =?iso-8859-1?Q?hJgFUAke+6O9dix9U80+rz9n38xuARzArQ+x1EJJ3LclWlsqD5ubx3J58B?=
 =?iso-8859-1?Q?QP+iAxJHxf59ssWJtxFrFbJ+D7M5QqXS2wNt5+NurakRKFenhkxP2sMGWP?=
 =?iso-8859-1?Q?xwzSorQUryolBswT/6emiDU6Epm9H/FYZVGz7dAWWQY//o3LqPHXx5L+tW?=
 =?iso-8859-1?Q?6RBo6Ewj+XRT2H6NgciXX9F0HHAALNkoelmJ+y/DbG23xECo+abNezFw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2fd07d-bb2c-4a5b-6170-08dc111bd7ae
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 14:04:06.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/Jg/+Ts1v0lNlCY/kvYDm/6M88Eszjxfk2ePRqqELm+hbql7dkbXoPSuptium2KnB8n31joBh38AUxOeWzAOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8593
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 3.5% improvement of aim9.page_test.ops_per_sec on:


commit: 4249f13c11be8b8b7bf93204185e150c3bdc968d ("maple_tree: do not preallocate nodes for slot stores")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: aim9
test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory
parameters:

	testtime: 300s
	test: page_test
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240109/202401091651.a189376-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-ivb-2ep1/page_test/aim9/300s

commit: 
  e2c27b803b ("mm/filemap: avoid buffered read/write race to read inconsistent data")
  4249f13c11 ("maple_tree: do not preallocate nodes for slot stores")

e2c27b803bb66474 4249f13c11be8b8b7bf93204185 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    336518            +3.5%     348367        aim9.page_test.ops_per_sec
  95019000            +3.5%   98364469        aim9.time.minor_page_faults
     25318            +2.3%      25903        proc-vmstat.nr_active_anon
     26605            +2.2%      27197        proc-vmstat.nr_shmem
     25318            +2.3%      25903        proc-vmstat.nr_zone_active_anon
 1.087e+08            +3.3%  1.122e+08        proc-vmstat.numa_hit
 1.085e+08            +3.4%  1.121e+08        proc-vmstat.numa_local
 1.079e+08            +3.5%  1.117e+08        proc-vmstat.pgalloc_normal
  95763046            +3.5%   99109694        proc-vmstat.pgfault
 1.078e+08            +3.5%  1.116e+08        proc-vmstat.pgfree
  56340620            +1.4%   57128415        perf-stat.i.cache-references
   3744535            -7.4%    3468589        perf-stat.i.iTLB-load-misses
    923.85            +8.2%     999.87        perf-stat.i.instructions-per-iTLB-miss
    318120            +3.5%     329244        perf-stat.i.minor-faults
    318120            +3.5%     329244        perf-stat.i.page-faults
     12.48            -0.2       12.32        perf-stat.overall.cache-miss-rate%
    911.69            +8.5%     988.95        perf-stat.overall.instructions-per-iTLB-miss
  56153225            +1.4%   56938073        perf-stat.ps.cache-references
   3731915            -7.4%    3456934        perf-stat.ps.iTLB-load-misses
    317046            +3.5%     328134        perf-stat.ps.minor-faults
    317046            +3.5%     328134        perf-stat.ps.page-faults
      1.54 ± 15%      -0.9        0.61 ± 35%  perf-profile.calltrace.cycles-pp.mas_preallocate.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.56 ± 16%      -0.9        0.67 ± 18%  perf-profile.children.cycles-pp.mas_preallocate
      0.59 ± 18%      -0.5        0.06 ± 66%  perf-profile.children.cycles-pp.mas_destroy
      0.03 ± 84%      +0.1        0.13 ± 26%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.18 ± 27%      +0.2        0.42 ± 15%  perf-profile.children.cycles-pp.vma_adjust_trans_huge
      0.28 ± 12%      +0.3        0.57 ± 14%  perf-profile.children.cycles-pp.vma_complete
      0.20 ± 28%      -0.1        0.13 ± 24%  perf-profile.self.cycles-pp.security_mmap_addr
      0.16 ± 23%      -0.1        0.10 ± 17%  perf-profile.self.cycles-pp.__perf_sw_event
      0.17 ± 18%      +0.1        0.27 ± 30%  perf-profile.self.cycles-pp.get_vma_policy
      0.02 ±118%      +0.1        0.13 ± 26%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.08 ± 25%      +0.2        0.24 ± 13%  perf-profile.self.cycles-pp.vma_complete
      0.18 ± 28%      +0.2        0.42 ± 15%  perf-profile.self.cycles-pp.vma_adjust_trans_huge




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


