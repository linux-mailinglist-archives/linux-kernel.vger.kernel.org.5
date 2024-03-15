Return-Path: <linux-kernel+bounces-104008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416A687C7D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C501428248D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1A1D299;
	Fri, 15 Mar 2024 03:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HW/xYw0f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA17C8CE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710472096; cv=fail; b=Y8V611iIHa3LzvF+KjyZFZqX9lvxCPaXpdNYy/A9W3PbeCkM63g+yJtU/fVC6+/053RrmSxurZzwc36VrYlFfw42vzxHtrnDhdYHm81xO8AbqF61Lc4i0BuvOd+dbG3y5aRbheQUlU78waXgcwdT1n9GYHdr+X/4+xVYA2QpLvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710472096; c=relaxed/simple;
	bh=95tXDFFybVLtT9x0CGIojkSe21UxdndBM/Mj6XjriVI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=K8sE5ZgUnp3YLGcsdcLzsfmj3fDKw1m1xYo3stiGY3+11xtVd+1l5r/EPaWYDEFqQk1/Se3wFbGn5K1T3iZ7wFICwwt9swxG3buYxGTMifxDac/tM1CFClOY4/VR5U2KIKHMnslLMQCfXOx0ykH1Nb61fz0eN2AnL5EVeOh0yXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HW/xYw0f; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710472095; x=1742008095;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=95tXDFFybVLtT9x0CGIojkSe21UxdndBM/Mj6XjriVI=;
  b=HW/xYw0fZyMjMznmeHzKWSrBIegnvG+cqcTs+zo8cz4l9cJWxkLG9HgU
   z7uRp9d9MnzLYVll3SQfY6ZH0A3qO7ZZJ/8Lud918pYpqwmr95o2TXhe7
   nScUkARsRy5S2FHO/H8gvmxqMg6yOtistjP/atQkWIK6Nca7eGRn5l/Gm
   rW8iPTZRIPBdMyVqxDeIEGCBi7FQhumU6E4ZQG43Ig0Susl0IHOMeyoqc
   7MpKDfXnZRIsRWpGjBOafo7Ew+FS0pI4gGbszPUwPa5q+EgtBIe6fojSu
   dEz0TKsdrtHsLA2GG41kxCtVa/HSycs8S51Ss8/9pLQdPspneaMlFxhFp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="9108518"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="9108518"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 20:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="12592638"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 20:08:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 20:08:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 20:08:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 20:08:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 20:08:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg4juS14zieGFUTh7/isem6qzd3HJvWxg2bEmRTVW2mwM3PogYXsNlZh+ATjBclUfwuWncLbCJd3xQq2gLWQlQ3h4JVH4HYVKDl4bj0WnJEqUTF3bWr2P0zB5U1+dKBlo53N37v7A5K6YCCtmZDeNOCSV+xCcQ7LC/oI+n1/khudpCY8/B0uy9YBnBUsAzc6aCMJyq+nQJvSpenk7tUqcHlnQpFWSUKSx/ZqcprhxV0Tm7TRTTbAKRQ4CjTPWgXf1ZuUFyhhaxbmatJfcSAWLyrNJ7f92OPNp4jLLLVyU1l1p0/HZf9rGD/EbOc45Vf96YmYDk+tAG4fu6B7SYnsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zks75qjVEnKj/Q6YZil/c99uSqisSAamV369/Ks5QkQ=;
 b=VtUcfOKbYiNpfTNM2Sj+vRw6kKwKUaxBPKEWXmBcWxcospWkpS+WtIAeu16qprUNiX5GpQTmi0FHmkbEiv3eGiPvusohXbT7H/Mmc7qMyCVox6izal0r/+By+cMGDOJBE0emuYgcWPmj3eY6Zl4R2el4RLtNPCZkXtubWKnzXZUzDeW77Ykbk9fcHqvDahuEcWvy5mIQb2vrl9Kg0q8Kn+SxR8B3z/OmTwdPkJ5v3YGevRXcM7eUGWahilF2fjcPUz6w7IV19uO6Dpkv9NgFt01Q0VkfZLcZCc2rJvrKenRC9jil0zngtZhadhg443DoCpaBXd12ZpZnlbE+rWU8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6093.namprd11.prod.outlook.com (2603:10b6:8:b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 03:08:07 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 03:08:07 +0000
Date: Fri, 15 Mar 2024 11:07:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, Mel Gorman <mgorman@suse.de>, Ryan Roberts
	<ryan.roberts@arm.com>, <linux-mm@kvack.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  99fbb6bfc1:  will-it-scale.per_process_ops
 -4.7% regression
Message-ID: <202403151058.7048f6a8-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f50ceca-0438-42d1-d28f-08dc449d2346
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sWp1sNhEzoPlL03NG0IelwEf634lUTbo/Y98K3W+79/wEdZDJm6X+0uiCcDnQAK4n5VK7FPDZXEfbHKDNcFjKrdbk4d0Q6+8IyRDaOC3rLcegU1c7A4km6gqQ41YF8m8nB+HTqVHQnzfRUg3VcKSmQD8bWt+ng76mVQpC2rPSBqgff655ymU445QClHmIcNAVlAM6wHF9oAkV9+FfGZCkvQtSe7RGAQ/mhOl+aQtFwC4rQtivyp2rk9mSsXVdQR+hZKXmbgqBA+QLT280rInV4eb9yL9bi05hDtKn1OjBTKvBy9Ag78TWZ8+ebiKvLE56enxw7TvWkws+CiFOXXnt7Xix/xysJhy/Sl7UXzt0rSBca9N1Nb5ekT4gvGO+si8qkeTaZodvH4Y2mDhkTffDX5r9YgRBc9YhYk2/HJeD13L4QLepJH4Dm4sFwdVetrhggt2qrh2xcNnUeDp6PpWtZNtzz24EE5FCxKRUhc+PSoFRUrodJFJre7t2rbPa6yPUnTjXRF1msDfdadJR2V1dHZ6T6Cmbbfzp/A1ZjSVCkBXlav1FZAPWxB9ZRJhvM1Bz0EoDNBEFIMRs+n4mjOupQtO7ThAzgLBM2HwATZKr/hZgMRn9gS2mbA5/rYcTHMW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KJs3+5OXEaZ4EgQn46rs859lCZ0hlffOYvBoBmWU6pk1kLApPM+kLm79fV?=
 =?iso-8859-1?Q?DmxYI6en0pmvzwsA7yBgef6Fx7VDVcv1O2WK87vJIjA32/tS4rsY1dBEGZ?=
 =?iso-8859-1?Q?L4FcKToW2tPrJQXgqqHIJmoxwVUve7pGnJ/sC1Lus7plRSmstv1mtZFfwc?=
 =?iso-8859-1?Q?wjYEI4ZhqVM+/BnIfKbwpImQx3lIHle7k6qNiNUlcqwJ8164wU6kIgXPYc?=
 =?iso-8859-1?Q?1oQG3w7V+t6ZYufOES0cZtHO7K0xR3BP88Ofyo47NoszzHJ9fJrTRFGxf0?=
 =?iso-8859-1?Q?zToWRYe2NmgTxQEOq+Bs369NAytbkfSC09zTmmJxNHhVehgmXLixeN2tlA?=
 =?iso-8859-1?Q?aXGoIjTpNLrMAZiwT1nuyfDoK9fjAGKkFidCLNkkq85kD616PpFxBl1KZl?=
 =?iso-8859-1?Q?rL9hZqYbIKkr9zVIgQjKYfWMvUpXi8pjbpxSHZiOJ1uO56F4V9XcNKXX+P?=
 =?iso-8859-1?Q?gEs/jmqmC5ur+I7WcSxqNsn/mN/nQ6PjnolHAZwJE141xzP5NeAGe2J4Yd?=
 =?iso-8859-1?Q?aZAlBEzd8Jdu1VKRz9PAwAoCP2a3V01g9WHLlnBOSLlm4YOrkiaxrqojAJ?=
 =?iso-8859-1?Q?0Ce8bYvq4RpxAwscsF/ayRYBPlm6wbEe12C7E1h5VTgd/Grp3rerzalNCm?=
 =?iso-8859-1?Q?mr8vbRkRjbE2rPoyVFQRCIvvDvm0MJq3XXF8Yy1m0P3OpfvGCMREJ8ezex?=
 =?iso-8859-1?Q?Re+5VYO3TPM7WZRQ6rhMhxMxI4UPAUvw8sN93O7vBX9mQDXZISKESZpe6q?=
 =?iso-8859-1?Q?Zspq7PAXunWwfXcX1qb8G70YKv3rcndV4bJkbvjXlHrbIGZ7KqyIK/Nbvf?=
 =?iso-8859-1?Q?1Y2DQdKGsdCNf4tHhLfgmsI48/Nz+LjJlcveq+UYaB8IPm6pRMmX8WXzsy?=
 =?iso-8859-1?Q?3zy6wZ97IuO4HQKBx3lVN1KmRad9FpncO1qwyDMPTMVBygvcQxvzF0D/hp?=
 =?iso-8859-1?Q?METYsk3qj2X1/rRTZeQCj8RsXSVvTnAB2nOUnvNllnFQlqckmvyREHhV96?=
 =?iso-8859-1?Q?KXiish96mPtxSgoHn/keXfO6Bgr77nGfiwuHAqYHhVoY32+5eJBMl3zU+9?=
 =?iso-8859-1?Q?X7zJcn/+f6Kgi9MObo9orq9iboNCn6RXpcPOQgcz2Vt0SbslvZLyRT5qr+?=
 =?iso-8859-1?Q?SFELcBW+XU71NlgJ48iLmQxTxmoNkOtV0hnZaC+8v2hHLjV7gaR5YD9TNE?=
 =?iso-8859-1?Q?sNzaBmWj0LeNdc0OR6QBCIFChscveFGUh7xYl8/lzkc6B0jPlC//Pke9In?=
 =?iso-8859-1?Q?aYyO/+69/LS3Rm5FrdjCxIIQ0OUe2cBN/39tAihAK4+lj9piS8K6L9tRD1?=
 =?iso-8859-1?Q?yvFREIWF03VMYsZolwATZ9B2CSvH8XBaFa7rP2djQUda9mqbnOS8Yten3o?=
 =?iso-8859-1?Q?HAfkKHXGpbC/yxZHOyhDKI/G9gCqRYcS9z8U3Y6n925F09Xszof6Ax1aMd?=
 =?iso-8859-1?Q?Dph3hmHOmdiI7lKnY28/rCWDDMYXv+eOsK0oTmdyf1jSaveua2R2DBbkVV?=
 =?iso-8859-1?Q?F/wZ8DHNypd/vCQrJKsudB0bOZyObQAxE37/3eoFLtCRcEastLMFfT+nc3?=
 =?iso-8859-1?Q?kojDItbd+lB+4neqVsEGSfPAykN7Do9GYdv90ef3Wl1zDmhBMXnmASKP1Y?=
 =?iso-8859-1?Q?m2u88xBDB0JWypVfHOityezlOW+za2bkbR4nXwbL4NVUXAuQRyGjpMZg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f50ceca-0438-42d1-d28f-08dc449d2346
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 03:08:07.5133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkbZkO4J8nwQu+t2fhXxIC7O6ez1601hOjJDjjuyDHQaEwtlY7BA37UiT2gD4es0az7ad3ZXsGLyLCp+/Gfzpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6093
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -4.7% regression of will-it-scale.per_process_ops on:


commit: 99fbb6bfc16f202adc411ad5d353db214750d121 ("mm: make folios_put() the basis of release_pages()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: process
	test: page_fault2
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403151058.7048f6a8-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240315/202403151058.7048f6a8-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/page_fault2/will-it-scale

commit: 
  5dad604809 ("mm/khugepaged: keep mm in mm_slot without MMF_DISABLE_THP check")
  99fbb6bfc1 ("mm: make folios_put() the basis of release_pages()")

5dad604809c5acc5 99fbb6bfc16f202adc411ad5d35 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.02 ± 10%      -0.0        0.02 ±  7%  mpstat.cpu.all.soft%
     26593 ±  3%     -15.2%      22556 ±  4%  perf-c2c.DRAM.local
    225.67 ±  5%     +59.8%     360.67 ±  3%  perf-c2c.DRAM.remote
      3864           +27.3%       4917        perf-c2c.HITM.local
    250955 ±  4%     -11.8%     221434 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    250955 ±  4%     -11.8%     221433 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1408 ±  5%     -20.0%       1126 ±  4%  sched_debug.cpu.nr_switches.min
   8839851            -4.7%    8423518        will-it-scale.104.processes
     84998            -4.7%      80994        will-it-scale.per_process_ops
   8839851            -4.7%    8423518        will-it-scale.workload
      8905 ± 14%     -37.5%       5565 ± 29%  numa-vmstat.node0.nr_mapped
      5594 ± 24%     +64.1%       9182 ± 18%  numa-vmstat.node1.nr_mapped
    223619 ±125%    +149.2%     557292 ± 35%  numa-vmstat.node1.nr_unevictable
    223619 ±125%    +149.2%     557292 ± 35%  numa-vmstat.node1.nr_zone_unevictable
     34807 ± 14%     -37.6%      21736 ± 30%  numa-meminfo.node0.Mapped
  16743687 ±  6%      -8.4%   15343456 ±  5%  numa-meminfo.node0.MemUsed
     21509 ± 24%     +65.6%      35626 ± 18%  numa-meminfo.node1.Mapped
  15757988 ±  6%      +9.2%   17208425 ±  4%  numa-meminfo.node1.MemUsed
    128748 ± 12%     +27.4%     163979 ±  9%  numa-meminfo.node1.Slab
    894476 ±125%    +149.2%    2229168 ± 35%  numa-meminfo.node1.Unevictable
    110744            +3.9%     115041        proc-vmstat.nr_active_anon
   1744461            -3.0%    1692770        proc-vmstat.nr_anon_pages
      6880            +3.8%       7138        proc-vmstat.nr_page_table_pages
    110744            +3.9%     115041        proc-vmstat.nr_zone_active_anon
 2.693e+09            -4.8%  2.565e+09        proc-vmstat.numa_hit
 2.683e+09            -4.8%  2.555e+09        proc-vmstat.numa_local
    103708            +4.9%     108792 ±  2%  proc-vmstat.pgactivate
 2.672e+09            -4.8%  2.544e+09        proc-vmstat.pgalloc_normal
 2.661e+09            -4.8%  2.534e+09        proc-vmstat.pgfault
 2.669e+09            -4.7%  2.544e+09        proc-vmstat.pgfree
     43665 ±  7%     +11.4%      48633 ±  3%  proc-vmstat.pgreuse
  9.15e+09            -3.3%  8.845e+09        perf-stat.i.branch-instructions
      0.47            +0.0        0.50        perf-stat.i.branch-miss-rate%
  42741215            +1.6%   43433005        perf-stat.i.branch-misses
     84.26            -4.3       79.96        perf-stat.i.cache-miss-rate%
 7.696e+08            -4.3%  7.363e+08        perf-stat.i.cache-misses
 9.114e+08            +0.8%  9.187e+08        perf-stat.i.cache-references
      6.32            +3.5%       6.55        perf-stat.i.cpi
    141.24            -4.3%     135.20        perf-stat.i.cpu-migrations
    378.24            +4.6%     395.50        perf-stat.i.cycles-between-cache-misses
 4.571e+10            -3.4%  4.416e+10        perf-stat.i.instructions
      0.16            -3.3%       0.16        perf-stat.i.ipc
    169.33            -4.8%     161.22        perf-stat.i.metric.K/sec
   8806480            -4.8%    8384435        perf-stat.i.minor-faults
   8806480            -4.8%    8384435        perf-stat.i.page-faults
     21.63           -21.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__tlb_batch_free_encoded_pages
     19.17           -19.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__tlb_batch_free_encoded_pages.tlb_flush_mmu
     19.17           -19.2        0.00        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
     44.89           -12.6       32.30        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range
     44.90           -12.6       32.31        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
     44.84           -12.6       32.26        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma
     46.08           -12.4       33.66        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault.do_fault
     46.18           -12.4       33.76        perf-profile.calltrace.cycles-pp.folio_add_lru_vma.set_pte_range.finish_fault.do_fault.__handle_mm_fault
     48.87           -12.2       36.65        perf-profile.calltrace.cycles-pp.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     61.81           -12.2       49.61        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     63.82           -12.2       51.63        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     63.95           -12.2       51.76        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     62.59           -12.2       50.40        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     61.24           -12.2       49.07        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     47.21           -12.2       35.04        perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
     71.03           -12.0       59.01        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     74.04           -12.0       62.07        perf-profile.calltrace.cycles-pp.testcase
      7.86            -0.3        7.58 ±  2%  perf-profile.calltrace.cycles-pp.copy_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.61 ±  3%      -0.1        0.56 ±  3%  perf-profile.calltrace.cycles-pp.try_charge_memcg.__mem_cgroup_charge.folio_prealloc.do_fault.__handle_mm_fault
      1.36            -0.0        1.32        perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.90            -0.0        0.85        perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault
      1.28            -0.0        1.24        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.10            -0.0        1.05        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault.__handle_mm_fault
      1.29            +0.1        1.35        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.59            +0.1        0.72        perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
      0.57 ±  4%      +0.3        0.84        perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.set_pte_range.finish_fault.do_fault.__handle_mm_fault
      2.81            +0.4        3.20        perf-profile.calltrace.cycles-pp.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.21            +0.4        1.63        perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      0.00            +0.6        0.57 ±  4%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.folio_prealloc.do_fault.__handle_mm_fault
      2.68            +1.4        4.04        perf-profile.calltrace.cycles-pp.release_pages.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      2.71            +1.4        4.07        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      2.71            +1.4        4.07        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.00            +3.8        3.79        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folios_put_refs.release_pages.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      0.00            +4.0        4.03        perf-profile.calltrace.cycles-pp.folios_put_refs.release_pages.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region
     20.62           +10.6       31.18        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
     20.62           +10.6       31.18        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     20.41           +10.6       30.99        perf-profile.calltrace.cycles-pp.release_pages.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
     22.03           +10.6       32.64        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
     22.03           +10.6       32.64        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     22.03           +10.6       32.64        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
     22.03           +10.6       32.65        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     24.78           +12.0       36.74        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     24.78           +12.0       36.74        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     24.78           +12.0       36.74        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     24.78           +12.0       36.74        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.77           +12.0       36.74        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     24.78           +12.0       36.74        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     24.78           +12.0       36.74        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     24.78           +12.0       36.74        perf-profile.calltrace.cycles-pp.__munmap
      0.00           +29.4       29.41        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folios_put_refs.release_pages.__tlb_batch_free_encoded_pages.tlb_flush_mmu
      0.00           +30.9       30.87        perf-profile.calltrace.cycles-pp.folios_put_refs.release_pages.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
      0.00           +33.1       33.14        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folios_put_refs.release_pages
      0.00           +33.2       33.18        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folios_put_refs.release_pages.__tlb_batch_free_encoded_pages
     46.16           -12.4       33.72        perf-profile.children.cycles-pp.folio_batch_move_lru
     46.19           -12.4       33.77        perf-profile.children.cycles-pp.folio_add_lru_vma
     48.88           -12.2       36.66        perf-profile.children.cycles-pp.finish_fault
     61.83           -12.2       49.63        perf-profile.children.cycles-pp.__handle_mm_fault
     63.97           -12.2       51.77        perf-profile.children.cycles-pp.exc_page_fault
     63.84           -12.2       51.65        perf-profile.children.cycles-pp.do_user_addr_fault
     62.61           -12.2       50.42        perf-profile.children.cycles-pp.handle_mm_fault
     61.26           -12.2       49.08        perf-profile.children.cycles-pp.do_fault
     47.22           -12.2       35.05        perf-profile.children.cycles-pp.set_pte_range
     69.07           -12.1       56.99        perf-profile.children.cycles-pp.asm_exc_page_fault
     75.04           -11.9       63.09        perf-profile.children.cycles-pp.testcase
     66.59            -1.1       65.49        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     66.62            -1.1       65.56        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     66.62            -1.1       65.57        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      7.92            -0.3        7.62        perf-profile.children.cycles-pp.copy_page
      0.28            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.62 ±  3%      -0.1        0.56 ±  3%  perf-profile.children.cycles-pp.try_charge_memcg
      1.14            -0.0        1.09        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.18 ±  2%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.uncharge_folio
      1.37            -0.0        1.32        perf-profile.children.cycles-pp.__do_fault
      1.35            -0.0        1.30        perf-profile.children.cycles-pp._raw_spin_lock
      1.28            -0.0        1.24        perf-profile.children.cycles-pp.shmem_fault
      0.90            -0.0        0.86        perf-profile.children.cycles-pp.filemap_get_entry
      0.66            -0.0        0.64        perf-profile.children.cycles-pp.___perf_sw_event
      0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.main
      0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.run_builtin
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.14 ±  3%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.page_counter_try_charge
      0.42            +0.0        0.44        perf-profile.children.cycles-pp.free_unref_page_list
      0.21 ±  2%      +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.14 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.25            +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.24            +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.31            +0.0        0.34        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.28            +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.02            +0.0        1.06        perf-profile.children.cycles-pp.native_irq_return_iret
      2.33            +0.1        2.38        perf-profile.children.cycles-pp.__irqentry_text_end
      1.32            +0.1        1.37        perf-profile.children.cycles-pp.zap_present_ptes
      0.28 ±  8%      +0.1        0.37 ±  5%  perf-profile.children.cycles-pp.__count_memcg_events
      0.36            +0.1        0.46 ±  2%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.28 ±  7%      +0.1        0.38 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.60            +0.1        0.74        perf-profile.children.cycles-pp.lru_add_fn
      0.00            +0.2        0.22 ±  2%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.19 ±  2%      +0.2        0.43 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.00            +0.3        0.28 ±  2%  perf-profile.children.cycles-pp.uncharge_batch
      0.26 ± 11%      +0.3        0.58 ±  4%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.57 ±  2%      +0.3        0.90 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.81 ±  3%      +0.4        1.19        perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      2.83            +0.4        3.22        perf-profile.children.cycles-pp.folio_prealloc
      1.22            +0.4        1.64        perf-profile.children.cycles-pp.__mem_cgroup_charge
      2.72            +1.4        4.08        perf-profile.children.cycles-pp.tlb_finish_mmu
     20.62           +10.6       31.18        perf-profile.children.cycles-pp.tlb_flush_mmu
     22.04           +10.6       32.65        perf-profile.children.cycles-pp.unmap_vmas
     22.04           +10.6       32.65        perf-profile.children.cycles-pp.unmap_page_range
     22.04           +10.6       32.65        perf-profile.children.cycles-pp.zap_pmd_range
     22.03           +10.6       32.65        perf-profile.children.cycles-pp.zap_pte_range
     23.23           +11.8       35.04        perf-profile.children.cycles-pp.release_pages
     23.34           +11.9       35.26        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
     24.90           +12.0       36.85        perf-profile.children.cycles-pp.do_syscall_64
     24.90           +12.0       36.85        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     24.78           +12.0       36.74        perf-profile.children.cycles-pp.do_vmi_align_munmap
     24.78           +12.0       36.74        perf-profile.children.cycles-pp.do_vmi_munmap
     24.78           +12.0       36.74        perf-profile.children.cycles-pp.__x64_sys_munmap
     24.78           +12.0       36.74        perf-profile.children.cycles-pp.__vm_munmap
     24.78           +12.0       36.74        perf-profile.children.cycles-pp.unmap_region
     24.78           +12.0       36.74        perf-profile.children.cycles-pp.__munmap
      0.00           +35.1       35.05        perf-profile.children.cycles-pp.folios_put_refs
     66.59            -1.1       65.49        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      7.90            -0.3        7.60 ±  2%  perf-profile.self.cycles-pp.copy_page
      0.40            -0.3        0.11 ±  6%  perf-profile.self.cycles-pp.release_pages
      0.27            -0.1        0.19 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.56 ±  3%      -0.1        0.50 ±  4%  perf-profile.self.cycles-pp.try_charge_memcg
      0.17 ±  2%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.uncharge_folio
      1.34            -0.0        1.30        perf-profile.self.cycles-pp._raw_spin_lock
      0.24            -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.zap_present_ptes
      0.51            -0.0        0.48        perf-profile.self.cycles-pp.filemap_get_entry
      0.27 ±  2%      -0.0        0.25        perf-profile.self.cycles-pp.handle_mm_fault
      0.66            -0.0        0.64        perf-profile.self.cycles-pp._compound_head
      0.40            -0.0        0.38        perf-profile.self.cycles-pp.__handle_mm_fault
      0.12 ±  4%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.free_unref_page_list
      0.09            +0.0        0.10        perf-profile.self.cycles-pp.vma_alloc_folio
      0.08            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.02 ±141%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.36            +0.0        0.40 ±  3%  perf-profile.self.cycles-pp.folio_batch_move_lru
      1.01            +0.0        1.05        perf-profile.self.cycles-pp.native_irq_return_iret
      0.30            +0.0        0.34        perf-profile.self.cycles-pp.lru_add_fn
      0.06 ± 11%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      2.33            +0.1        2.38        perf-profile.self.cycles-pp.__irqentry_text_end
      0.08 ±  6%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.24 ±  9%      +0.1        0.32 ±  4%  perf-profile.self.cycles-pp.__count_memcg_events
      0.30 ± 11%      +0.2        0.47 ±  6%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.00            +0.2        0.19 ±  3%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.26 ± 10%      +0.3        0.56 ±  4%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.48 ±  2%      +0.3        0.80 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.4        0.41        perf-profile.self.cycles-pp.folios_put_refs




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


