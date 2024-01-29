Return-Path: <linux-kernel+bounces-42874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF6B840805
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E6D28D022
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964A96772D;
	Mon, 29 Jan 2024 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3VakybI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F8966B20
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537806; cv=fail; b=hxOjZ6R/TgCUPJKRQyOcQKXu/R9ZUt558vSw4aW2H6iTMQb61aL4P4xEYhiW4USpspgMB/KI+apQ3DCmv6i3ofugru5cXsilvb9+ADVwrr+QpZFWTpddExZ16Q0+Sxxvwttiuv4q+xHKr6YPYvpT5/oklf+JfHWOU4FciNpwT3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537806; c=relaxed/simple;
	bh=6EfnfqvC2VpmgqeKhU5CgCtcFN28yqlxcBXu1a+FTn0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Co85ZUx3e9hEAEGKw1puA5A3IWFP4ZsP1u0LlXeP/pJLZ6rmBQqh72tMpWhZQ8MbvB17hMnSwetvEyaNFfBu9MTk+LIUfYIzsRZ4cuO653KKcwq5wUk0qRJXmO4yl4uPOMoGSkYIeJj64SgeD++S210MviukiXSvn/pFYPcfB/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3VakybI; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706537804; x=1738073804;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=6EfnfqvC2VpmgqeKhU5CgCtcFN28yqlxcBXu1a+FTn0=;
  b=c3VakybIqyoUTP6Svx1KBvMEHV9uRJ7/2BVVYfQkK1kXKySDhsZk5YJo
   5ZMn/VpeBD9beB2MPDzgvMU3T3W0sECdvoAojhtfNQ/S6IGymK883l7Nm
   nL1/j36OUFeicM1wbSGg0MjrtmE6vXjdMs1Fif5YOgJ4mGiKy+wqhUxIy
   dzJ97WUzgjD9Wk8Dz4FaOPcmszQF/7ASNX8qeUjUnAsOJVu2vsgHj3zCI
   qU8zN5L49W6iURpyZmt+vKIeyMFrl9CoKzvGUuw1my0KzGYbnfS5K4owo
   Wm3lOXfmWtGln0tm2rvofb56tXgjrCGxFEs/aoj2zpCwpxH4220Ugmhds
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="2850103"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2850103"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 06:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="907128285"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="907128285"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 06:16:42 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 06:16:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 06:16:42 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 06:16:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aef49xj8icK1VS9gaLn4W2mKpGYQei5VaLVu5beUEm0ToD6d7X+3cTcU10IDUs0LdRmchS50UwLQUVRzerCJOBqkZvoCmUl860og9wOAxts5MieWU2nbb6zpklTalTuZ2BDW5xc85j+llgnKe7Z8FWvGxw2vON9nBBKkwE+kaDam5w4+QqtPK/YRTXW9MmOzvhatImCG8B6fnjfG8aicpjSXWDA2k/mT1KzAo85vVZEHGlzv5V7sjqg+0Ud5jUsFwsA/ojkRvQiel0kE0MK5wo3vUkdn0JKi4WkzdncH2EwwMPbHzj0oQG+SHHoqnRFmmp3eWa0Is2kylnMP+S9RXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9LSZ6KwOaufB/FhM52+whMny+zDgwgnxDdAozFOhFA=;
 b=iSUNVXTWpRWMN2/2Z5IZbIXXfNqDnvWJ2Ku2s3oqZiWn7UoGHG6P6/CMiWFlZDN/qb3/H3EOqgjccyuvhVlCeeqXapZ2bDAYEEOY66GmBJXdDt84dLcHKbnOep1if1m6GzKb5GNLP08U/BHmK1fnhEWHwxW4tn3xdXVQH4fKskjUWKJjgWAQPEVxTUtUMBJNhRBj3+fTI2G3h29iQ2F1wW+ndFD83LW2c8btxb2IZGO0ucfVUemsi7Qo/HwbyOIE4WKB8AP+djWrbD4MQQe2loSsDPvF5dqI94E31YkCZMwC26u9CiozHh/RqNIDPKGZ0GK7OOFb7pyNGNT/Op88Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8459.namprd11.prod.outlook.com (2603:10b6:408:1b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Mon, 29 Jan
 2024 14:16:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:16:39 +0000
Date: Mon, 29 Jan 2024 22:16:30 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Abel Wu <wuyun.abel@bytedance.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched/eevdf]  2227a957e1:
 will-it-scale.per_process_ops 2.5% improvement
Message-ID: <202401292151.829b01b0-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 456f8887-e8d2-40ca-4c5d-08dc20d4e8d9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kX1rgZ4ul7nIGiRZWGEQKYe4s+sC3UpHvk5DvCAfa/llAic8vp6hYRRo/ilMN8fLW2kPvbvID1DbFuLRncZgvB4Jd0h4cZUHLPb2WoJHtftkeEQln6arj24dtcIWcQwPaSJ6zzo04XeACt79b9HWnKuhlFW+Wa4t/a64tx5yTy9yMaRdEXG5LA03baQrGyST2jRGrG3VvbQxPza8CxJfRcF3l0qjjnmGLOg+xStF1WkgB95KSpkuFWUbqAXj7pCzBc84nM2U7eJCbDdVGpdd+nZmLOep0sgx0O78n3JGHa4y2rFuGQhsMInDuHSb/LGaifIPqUMYS3coJeNei7COR0vHDcTCsCvJYAMKL057T1z1WlGShcGVk6Mxct5rWVUpW4Oz7ICPFtIk1MS2GXvaOsTl2aLCvYifL6nPQKQCv9PkVMkvuMfKs0nBOHVIr2Exm+DbkBNu75MnJ4tkMfIqz5k7K+c3SdsbvqaOv2inMGllhA/Z15xGFI/N/fdKxD3YkTAT10ezENVmptHZMLwt0TsWz5I82H963eDeoxAARu+rg9Ik+TxqkYvSWRyvuvGYFKAOWgpsdiQuokI94olNtt+HYc7gf81CtG0pafoGrccGBVkC2kFfsH9EV404KcZO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(230473577357003)(230373577357003)(1800799012)(186009)(64100799003)(451199024)(6916009)(316002)(83380400001)(66476007)(86362001)(66556008)(66946007)(966005)(478600001)(6486002)(6666004)(38100700002)(1076003)(2616005)(6512007)(26005)(8676002)(8936002)(6506007)(82960400001)(19627235002)(4326008)(5660300002)(30864003)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uFS23Au/0RWVHAOqy0wrotzV7XxIfaCnMKypQZAGLHFRoFYbbz4JgCdOpt?=
 =?iso-8859-1?Q?qYNu+fbOMLUqJLxH9UsSSSI82RqneLykZN6Eq6Z74AgpqL2z3ggL77KckN?=
 =?iso-8859-1?Q?K3QozAo9d2V2oeHmFGTwaYyvM3ErsjvgOamNIRjgdpCWbI7XIbHnvFmyRD?=
 =?iso-8859-1?Q?5TG4eP0X2hFUdSBK/LHG795vrFITBXeK6dKDQ1+G1Bzk0GyNxYMXc62F1u?=
 =?iso-8859-1?Q?tz0Ph4sY2bbW/YkxHlgUMYT+OLwlqGImFonj7ZthCKDLpQRQ2oaUFM2fX1?=
 =?iso-8859-1?Q?dtOXgLC+KPvQ9dWHxsCi+808Tx9kJkDiraQ+hD6bKxmnpIEcO5fJZ9c2E7?=
 =?iso-8859-1?Q?BilFSKTLSY985emGvVH3Y2SGiQdaodYTYkpdIUwVkADm7ERE9e65g4PiZe?=
 =?iso-8859-1?Q?wGORRCrCO/v1dQ9widvOBCn2O3DNVZnjL9plGFe977r/xJ1wFlybDapSjG?=
 =?iso-8859-1?Q?QnO4zO32emWoQYnC9H6ZNpuin9W1mo4RgUHIxkdO1rjI8XbywWhxu7p7i4?=
 =?iso-8859-1?Q?SebMoZ2Nk9qF50YPU/cZ/h6DkxP6Ue2xzeA1fNk5m78XklDYixWCFDvuvE?=
 =?iso-8859-1?Q?Y+mqAFIfq9lUSPCj3H4YUkT3PPYXlVKHmKaaaTmJUCJ+hyVCypXEoopmfr?=
 =?iso-8859-1?Q?VJ8+C32Z0FoiX49xQqKjIXK039g5XBT62236hDnPxDEOcmaITB/GnGs+1o?=
 =?iso-8859-1?Q?0+yOobP837LIvKYef3RvXFpoRpGnT7ufV4PODA4tBccYTSorWVAMz75pMF?=
 =?iso-8859-1?Q?9U+dlxqwSNnlkiH1E+BK17vQ+zwkb+avoTtn50HBLRkxe/oaXDttlDYPsQ?=
 =?iso-8859-1?Q?ppB3fO6Ym38+l+2rVClDd9FuIa70bAlJ5dMevxqPaq1Nd7DoRr25sfZOj1?=
 =?iso-8859-1?Q?j5s795n8KKG0QFPpgPhQvFSeBsSns4HcqfUhVN+Kj+VE9sV6uMAwrXKwKn?=
 =?iso-8859-1?Q?AfnZsRphpwOTSOnIUMhffOIASBYcEMr5f2QcC5NscUzi7mTPX1N9JAXJsS?=
 =?iso-8859-1?Q?Qh8DJM3NO9l4SABoF8deUmPvF8skgA7ohxK6l76SaHWurYaOiU7rf+6efU?=
 =?iso-8859-1?Q?7JZEqZ4eIKqhmUtcPVGZJmRTl9ylbtyiEpEyNTjNWV4SwDsH7l71c+ynhS?=
 =?iso-8859-1?Q?U5ddVaDY4SQMnuBCwQDkBL4jsyJN9R9kBRJT+K9HiEBmsYaafxEHsyRW+f?=
 =?iso-8859-1?Q?I9TiSxT6bHGFhv8aVDWzQbjgSmHXnY9Eol5wV1C/WGF7J4bFDx+pUKqq8K?=
 =?iso-8859-1?Q?TGv6ElaDjf7pJj/TnVcFm/vlGbq646Zr7wT9bWqgMd9dq0IM/dujFnMe1/?=
 =?iso-8859-1?Q?ddEB2VviV33Qg/mQ23BurVuBBNaWy40uyLC0BZjIY9y9V0tGvefClojOGF?=
 =?iso-8859-1?Q?lyMkDafNakFfJUABDnUXE4tRooMiJ3Lb4gcodYqaaAASVwn0nZ437dM5RT?=
 =?iso-8859-1?Q?yUxRb4ilZIdaIOQPqvKdguxFf7cFEN+BY21jvzOd0IPwY6nySXTUSeafq1?=
 =?iso-8859-1?Q?KgivoFQUaWpGe6iepQaCy/QPDTxqFor/q4GhybLjr8wRGsufNQ/86CMjGQ?=
 =?iso-8859-1?Q?xFtHuqlt8VAvhVm0/g+jJxZ2+/vSDa01XJJxuUwrYPtK7w2yF5tOx7QBgj?=
 =?iso-8859-1?Q?/gl2wrGWvfSC3mYwhGPHgNiJ+7MVSi+OBVeBi+ZhHphJbG47grC7b7kA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 456f8887-e8d2-40ca-4c5d-08dc20d4e8d9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 14:16:39.4677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09QRmByYPLbA/u+1X/jT4qZ6mtntJtHhgTpZOdnuIGKY+MPAwspVeD5b9HFDni8m6ZjJpqde7quSIyUTd8wKEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8459
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 2.5% improvement of will-it-scale.per_process_ops on:


commit: 2227a957e1d5b1941be4e4207879ec74f4bb37f8 ("sched/eevdf: Sort the rbtree by virtual deadline")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 16
	mode: process
	test: sched_yield
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops 2.6% improvement                                      |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory                                                   |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | mode=process                                                                                       |
|                  | nr_task=50%                                                                                        |
|                  | test=sched_yield                                                                                   |
+------------------+----------------------------------------------------------------------------------------------------+



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240129/202401292151.829b01b0-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/16/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/sched_yield/will-it-scale

commit: 
  84db47ca71 ("sched/numa: Fix mm numa_scan_seq based unconditional scan")
  2227a957e1 ("sched/eevdf: Sort the rbtree by virtual deadline")

84db47ca7146d7bd 2227a957e1d5b1941be4e420787 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    363.99 ±141%    +104.2%     743.31 ± 69%  numa-meminfo.node1.Inactive(file)
     91.00 ±141%    +104.2%     185.83 ± 69%  numa-vmstat.node1.nr_inactive_file
     91.00 ±141%    +104.2%     185.83 ± 69%  numa-vmstat.node1.nr_zone_inactive_file
  16803184            +2.5%   17227597        will-it-scale.16.processes
   1050198            +2.5%    1076724        will-it-scale.per_process_ops
  16803184            +2.5%   17227597        will-it-scale.workload
      1.70 ±  5%     -12.0%       1.50 ±  4%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1.72 ±  5%     -11.7%       1.51 ±  4%  perf-sched.wait_time.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      3.41 ±  5%     -12.0%       3.00 ±  4%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      3.43 ±  5%     -11.7%       3.03 ±  4%  perf-sched.wait_time.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.18            +7.1%       0.19        perf-stat.i.MPKI
 3.486e+09            -7.6%  3.222e+09        perf-stat.i.branch-instructions
      1.34            +0.1        1.47        perf-stat.i.branch-miss-rate%
  46582130            +1.6%   47319245        perf-stat.i.branch-misses
      2.67            +8.3%       2.90        perf-stat.i.cpi
      0.33            +0.0        0.36        perf-stat.i.dTLB-load-miss-rate%
  18084714            +2.4%   18523285        perf-stat.i.dTLB-load-misses
 5.491e+09            -5.2%  5.204e+09        perf-stat.i.dTLB-loads
 3.036e+09            -1.1%  3.003e+09        perf-stat.i.dTLB-stores
    741655            -4.3%     709869 ±  2%  perf-stat.i.iTLB-loads
 1.811e+10            -7.4%  1.677e+10        perf-stat.i.instructions
      1115            -9.5%       1009 ±  5%  perf-stat.i.instructions-per-iTLB-miss
      0.38            -7.4%       0.35        perf-stat.i.ipc
    115.51            -4.9%     109.88        perf-stat.i.metric.M/sec
      0.21 ±  3%      +7.6%       0.22        perf-stat.overall.MPKI
      1.34            +0.1        1.47        perf-stat.overall.branch-miss-rate%
      2.62            +8.0%       2.83        perf-stat.overall.cpi
      0.33            +0.0        0.35        perf-stat.overall.dTLB-load-miss-rate%
      0.00            +0.0        0.00        perf-stat.overall.dTLB-store-miss-rate%
      1032           -10.4%     925.55 ±  5%  perf-stat.overall.instructions-per-iTLB-miss
      0.38            -7.4%       0.35        perf-stat.overall.ipc
    324242            -9.7%     292715        perf-stat.overall.path-length
 3.474e+09            -7.6%  3.211e+09        perf-stat.ps.branch-instructions
  46423565            +1.6%   47153977        perf-stat.ps.branch-misses
  18023667            +2.4%   18460935        perf-stat.ps.dTLB-load-misses
 5.473e+09            -5.2%  5.186e+09        perf-stat.ps.dTLB-loads
 3.026e+09            -1.1%  2.993e+09        perf-stat.ps.dTLB-stores
    739444            -4.3%     707693 ±  2%  perf-stat.ps.iTLB-loads
 1.805e+10            -7.4%  1.671e+10        perf-stat.ps.instructions
 5.448e+12            -7.4%  5.043e+12        perf-stat.total.instructions
      7.82 ±  2%      -1.5        6.30        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
     12.22 ±  2%      -1.3       10.90        perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.72 ±  2%      -1.3       11.42        perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     15.64 ±  2%      -1.1       14.55        perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.60            +0.0        0.64 ±  3%  perf-profile.calltrace.cycles-pp.syscall_enter_from_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.56            +0.0        0.61 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.28 ±  2%      +0.2        2.44 ±  3%  perf-profile.calltrace.cycles-pp.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      8.28            +0.3        8.54        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__sched_yield
      0.09 ±223%      +0.4        0.53 ±  3%  perf-profile.calltrace.cycles-pp.update_min_vruntime.update_curr.pick_next_task_fair.__schedule.schedule
     15.48            +0.5       16.01        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.00            +0.6        0.61 ±  3%  perf-profile.calltrace.cycles-pp.pick_eevdf.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      2.38 ±  2%      -2.2        0.23 ±  4%  perf-profile.children.cycles-pp.pick_next_entity
      8.21 ±  2%      -1.5        6.71        perf-profile.children.cycles-pp.pick_next_task_fair
     12.32 ±  2%      -1.3       11.01        perf-profile.children.cycles-pp.__schedule
     12.75 ±  2%      -1.3       11.46        perf-profile.children.cycles-pp.schedule
     15.82 ±  2%      -1.1       14.75        perf-profile.children.cycles-pp.__x64_sys_sched_yield
      0.64            +0.0        0.68 ±  3%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.49 ±  4%      +0.0        0.54 ±  3%  perf-profile.children.cycles-pp.update_min_vruntime
      1.19 ±  3%      +0.1        1.28        perf-profile.children.cycles-pp._raw_spin_lock
      2.34 ±  2%      +0.2        2.51 ±  3%  perf-profile.children.cycles-pp.do_sched_yield
      8.17            +0.2        8.42        perf-profile.children.cycles-pp.entry_SYSCALL_64
     15.76            +0.6       16.31        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.6        0.63 ±  3%  perf-profile.children.cycles-pp.pick_eevdf
      0.55 ±  2%      -0.5        0.05 ± 45%  perf-profile.self.cycles-pp.pick_next_entity
      0.44 ±  4%      +0.0        0.48 ±  3%  perf-profile.self.cycles-pp.update_min_vruntime
      1.30            +0.1        1.36        perf-profile.self.cycles-pp.__sched_yield
      1.46 ±  3%      +0.1        1.53 ±  2%  perf-profile.self.cycles-pp.__schedule
      1.14 ±  2%      +0.1        1.22        perf-profile.self.cycles-pp._raw_spin_lock
      7.13            +0.2        7.33        perf-profile.self.cycles-pp.entry_SYSCALL_64
      9.36 ±  2%      +0.3        9.70        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
     14.93            +0.5       15.47        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.6        0.57 ±  3%  perf-profile.self.cycles-pp.pick_eevdf


***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/50%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/sched_yield/will-it-scale

commit: 
  84db47ca71 ("sched/numa: Fix mm numa_scan_seq based unconditional scan")
  2227a957e1 ("sched/eevdf: Sort the rbtree by virtual deadline")

84db47ca7146d7bd 2227a957e1d5b1941be4e420787 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.01 ± 33%     +56.6%       0.01 ± 15%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.01 ± 13%     +29.0%       0.01 ± 21%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
  54153138            +2.6%   55542860        will-it-scale.52.processes
   1041406            +2.6%    1068131        will-it-scale.per_process_ops
  54153138            +2.6%   55542860        will-it-scale.workload
    125729 ± 92%     -58.8%      51829 ± 20%  numa-meminfo.node0.Mapped
   3437584 ± 28%     -56.5%    1494873 ± 61%  numa-meminfo.node0.MemUsed
   1980318 ± 52%     -66.7%     660255 ±131%  numa-meminfo.node0.Unevictable
    814154 ±127%    +162.1%    2134179 ± 40%  numa-meminfo.node1.Unevictable
     31380 ± 91%     -58.7%      12965 ± 20%  numa-vmstat.node0.nr_mapped
    495079 ± 52%     -66.7%     165063 ±131%  numa-vmstat.node0.nr_unevictable
    495079 ± 52%     -66.7%     165063 ±131%  numa-vmstat.node0.nr_zone_unevictable
    203538 ±127%    +162.1%     533544 ± 40%  numa-vmstat.node1.nr_unevictable
    203538 ±127%    +162.1%     533544 ± 40%  numa-vmstat.node1.nr_zone_unevictable
      8.82            -1.6        7.23        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
     13.35            -1.5       11.86        perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.86            -1.5       12.40        perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     16.88            -1.4       15.52        perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      2.48 ±  2%      +0.1        2.56        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.__sched_yield
      8.35            +0.3        8.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__sched_yield
     17.48            +0.5       17.96        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__sched_yield
      0.00            +0.6        0.63 ±  3%  perf-profile.calltrace.cycles-pp.pick_eevdf.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      2.40 ±  3%      -2.2        0.23 ±  5%  perf-profile.children.cycles-pp.pick_next_entity
      9.22            -1.6        7.65        perf-profile.children.cycles-pp.pick_next_task_fair
     13.44            -1.5       11.96        perf-profile.children.cycles-pp.__schedule
     13.89            -1.5       12.43        perf-profile.children.cycles-pp.schedule
     17.07            -1.4       15.72        perf-profile.children.cycles-pp.__x64_sys_sched_yield
      1.55 ±  2%      +0.0        1.60        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      8.22            +0.3        8.48        perf-profile.children.cycles-pp.entry_SYSCALL_64
     17.65            +0.5       18.12        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.7        0.66 ±  2%  perf-profile.children.cycles-pp.pick_eevdf
      0.57 ±  2%      -0.5        0.06 ±  8%  perf-profile.self.cycles-pp.pick_next_entity
      1.16 ±  2%      +0.0        1.19        perf-profile.self.cycles-pp._raw_spin_lock
      7.17            +0.2        7.39        perf-profile.self.cycles-pp.entry_SYSCALL_64
      9.54            +0.3        9.88        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
     17.60            +0.5       18.07        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.6        0.60 ±  3%  perf-profile.self.cycles-pp.pick_eevdf
 1.099e+10            -7.9%  1.012e+10        perf-stat.i.branch-instructions
      1.08            +0.1        1.21        perf-stat.i.branch-miss-rate%
 1.192e+08            +2.2%  1.219e+08        perf-stat.i.branch-misses
      2.61            +8.6%       2.83        perf-stat.i.cpi
      0.33            +0.0        0.35        perf-stat.i.dTLB-load-miss-rate%
  56475655            +2.1%   57669096        perf-stat.i.dTLB-load-misses
 1.743e+10            -5.4%  1.649e+10        perf-stat.i.dTLB-loads
 9.656e+09            -1.2%  9.536e+09        perf-stat.i.dTLB-stores
  55897710            +3.6%   57909818 ±  3%  perf-stat.i.iTLB-load-misses
 5.716e+10            -7.7%  5.276e+10        perf-stat.i.instructions
      1103           -10.6%     987.24 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.39            -7.6%       0.36        perf-stat.i.ipc
    366.15            -5.1%     347.53        perf-stat.i.metric.M/sec
      1.08            +0.1        1.20        perf-stat.overall.branch-miss-rate%
      2.56            +8.2%       2.77        perf-stat.overall.cpi
      0.32            +0.0        0.35        perf-stat.overall.dTLB-load-miss-rate%
      1022           -10.8%     912.21 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.39            -7.6%       0.36        perf-stat.overall.ipc
    317393            -9.9%     286100        perf-stat.overall.path-length
 1.096e+10            -7.9%  1.009e+10        perf-stat.ps.branch-instructions
 1.188e+08            +2.2%  1.215e+08        perf-stat.ps.branch-misses
  56295357            +2.1%   57482750        perf-stat.ps.dTLB-load-misses
 1.738e+10            -5.4%  1.643e+10        perf-stat.ps.dTLB-loads
 9.625e+09            -1.2%  9.505e+09        perf-stat.ps.dTLB-stores
  55706724            +3.6%   57713872 ±  3%  perf-stat.ps.iTLB-load-misses
 5.698e+10            -7.7%  5.259e+10        perf-stat.ps.instructions
 1.719e+13            -7.5%  1.589e+13        perf-stat.total.instructions



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


