Return-Path: <linux-kernel+bounces-46568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F288844166
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80981F2B225
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B84E82880;
	Wed, 31 Jan 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EpK7DhHV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B8882883
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710116; cv=fail; b=Td8zrngNjJiUFEi1E3+xJi2vwC+2qaOJJHmpBOxRuCxz1cOBAFlanTNOdos0/hkmGBpt4VuyRncnbM+Qvl7vEieNNTd0pKXv8xWDwEN+0DAuALXL5Lv+jNAnJcVxPxMawFjAtXYp3oF5RD32nteD8ow913sKY7Ki9boflhwtkJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710116; c=relaxed/simple;
	bh=qTIbPhcOc8mm3Oc5ZmT2rImp88QSq0+xtuE+jdkcqMg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HKSmyjZwQYB/BaSOPcQssG/xe/WznLlzAvwoxmtlc/EubbVu6r1JnQt/XMcgysMqlB8bFwF0XmWCNDFEhVO/ksp1E0sS4bLLdhoOLid0eyyY2Jac/07GQOxMaDHmHqDgZYvWCSU53ZSR2qp1tuRl0ghUosgUogp2J4rREcjpI80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EpK7DhHV; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706710114; x=1738246114;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=qTIbPhcOc8mm3Oc5ZmT2rImp88QSq0+xtuE+jdkcqMg=;
  b=EpK7DhHVDWYcvblmbPd6ug4WQctyx53H9rVe1abhyxUGoRMwV2Nw8ZFr
   Tq40qgnWrI9XXPXUjPwm6Uk5kdhz17vLQBMs7ao7ubasCPI29fj8ky+31
   YJ4Uy81d6TvaNjSKOiSO+KhI9KfSJm+5SAWfxXhTig88BspaHAoAYO1JY
   F40hcmR/oIjl9B3lTvJZrb0P1HPfi40RghmmkYqgpHCxuH7Gu361VisdA
   7iGksMv+Vt63IcDHWNcpc84vRXjshqTKDQDJfQe+gv5N3p3IC8UsJoSgv
   N6N9IxnIs4jiCvuisr37nemVbZjgMz654qgPVzH7MqLato83AiLqD4IVT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2548974"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="2548974"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 06:08:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4067034"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 06:08:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 06:08:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 06:08:31 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 06:08:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNctodc9RgKELOF5OKFQZvIRh+NXzfBL48SAAoXKPrk6O+GkyO/vEVD6YNWh4LUlH4h4hCjvTcLw0okfRP0Ix2Ob7yusMSEKm0E++oQ6l1fBFdLhX+WT3Y3ez2bmMYNLRrd2q4Cx4cv8TLBK18xNNxn2+VhMQtivCaZDqbUiKZ5ZS8k/QCmt5inEuWTgGqanHb9E4CAM92tIJ9uu8jESknJUH1RexirsXpeNDDSMEbl8v7+Y8Da/FOH6H/aH3V4kSKUOfXCgo752BqLG7JHkdbjD2w2fWBI1to1jl6WGH2maVvqNBg3dM5/rpEfe+vtNge18LFAcBcptE49ScjXeEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNF6WWklycevl/+8wlr8bU3CyS8IFEmn7+Dwt5iPjcI=;
 b=HEsynTaMa7trRMLc7ngY6wYeXu79yPEYSePIfHiZlvBBct0xPnj7bCo8zCGBxLV7YVL0B75iwSfWk1/xNE+Tg/yixrIKoYfgUAceCxwHpcN2L5UeXyFjWf9wskYwvbMIzVf2299G2OGzYIRW7i0BFEx1jZT6RUhcfdIYpUQTjL33ckIoJ5wG/zDR/2YBJv1utFw+zkr6vqiqH2QIKSW2ettSFSlp02rDeCHANMKv98+FOTs44uuA8DJzghYt8atbAjUWPS4hocQiLO9W7X/oA1MR7+JlwaldJV7hcmsxK2XmC5EoCvqxTqZ6+FL9TrS7UK4ASsp+TDlHh9zlQE4G3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Wed, 31 Jan
 2024 14:08:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 14:08:29 +0000
Date: Wed, 31 Jan 2024 22:08:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Bart Van Assche <bvanassche@acm.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [block]  53889bcaf5:  stress-ng.ioprio.ops_per_sec
 13.0% improvement
Message-ID: <202401311609.2c8c0628-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 5983f8f1-57ec-4baa-0118-08dc22661953
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hcZtCsVTwWeV2Zk7sX76IB36kUBf/wB3NOQM4imetZrMWnJwfXB+9K8ODwdHU9sTByyHhV5drlOqn8jzq5xqgR9mTH5QqapYSLE/fjW7DVFL2/f1/o0EwSaVhzdXKSND4H5ygSxVbbhANzWld4ZrN1rHLSY92SwJ74pgBqeXda9TRPof9LOitgBZPOTa7NCKLexsNGUcUCeoMXrlnTuSi9jAHRBXV02meE/vhuDkKkuKqvO77E0oOPY11CJXlLQrbiT5By8ypvLsCCm2Rf9bU77NleZBzXsxB+39WqBwYG110JveBda/f+LB3QkOkD5DHNSR/q1MkFyl1omGGt6/kgn9d2JmsVhjyvhjjR3CNkp6xaumjzH8aw740HtLxBWbVYTbafWuS1NdCORR1wIDmk00mA/EZyH/Z4Y9e+Y4WxE/4tflaHStIilpvTh7hnyo5ET/7+oqndlUBgvQsyIMuNTBtuBaNdfx87rXrCybN9lz66KgnFn7XNGwjLHa27cS0QJbPwt8M+i0lXrW7AjRESJbsWY2IM3zFXOiej6tmbRbuC9RzM+gxAUrElzMXhBrpUtFN3CldkFQ6XVtKeZREyRItB6qqvyb9TVhnBa8veuTDrrvtuASUHUx9u1Z+jfpjtC8jG2VgDaBrTcSK86zmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230473577357003)(230373577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8936002)(8676002)(4326008)(5660300002)(2906002)(86362001)(19627235002)(66556008)(66946007)(66476007)(6916009)(316002)(36756003)(6486002)(6512007)(38100700002)(82960400001)(6506007)(478600001)(6666004)(83380400001)(26005)(107886003)(41300700001)(966005)(2616005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3Z7A7mcQD852zG7nPbvCotQhmp0BjZsmmZB1atDmEi8wpcXPqUuzjI3FPs?=
 =?iso-8859-1?Q?1c1h7NYVp4Fdv7sr0pV/StsUxuIq5qCD3bxGuVjgo1sJFraf42ciGqt8a4?=
 =?iso-8859-1?Q?GsppWq45ITZ3llKXwyGCUWEh/LKSTVhE4EDBmC20AtVHVmpFZHt+aIByYo?=
 =?iso-8859-1?Q?MNZp2N+yQ7S+OGfWAlhtCvwq95/JR33/CQ7oRLXVTYQUWSp72gaw7iTrWi?=
 =?iso-8859-1?Q?ixRUrhQo8mLI1nVqCobMo4jKbiGBa7Ptd3pluB84vIBFDZkITZKEs+hjxI?=
 =?iso-8859-1?Q?LFIeEd0JJUq2Vqq0XoXhiGgkogJf4rcw4eTHuQtnXTqF4r5uYBEh6bLsbA?=
 =?iso-8859-1?Q?WYopGoREpnBFNLvgt+F2Wx0C9XKEMeatnrEcxg2KBtuNtmQZMwXIcqmZUv?=
 =?iso-8859-1?Q?wt6UeCTYHndqshrJ0SXIjvwtYVavgTjhlROn5EEPizpCKdXYRcVWOZZY5i?=
 =?iso-8859-1?Q?FBco0tnn4PG/1fay74i7firXHQnnKGGaWO/WLxeg164WOctdhzAW2VrEyd?=
 =?iso-8859-1?Q?kPr73Xe7xTzVmSxBrOfYzSlJViMyM7JpPraavlWsjndPcarL2NvEeCVOHU?=
 =?iso-8859-1?Q?3pLhRkEazxrCIPDReAZn/swtZjrFhDmPuqsZrmeaa+1lChfXAzafYy8dFF?=
 =?iso-8859-1?Q?aWqoheJ6OP8zN5ZGHoK6ErlSdhHsez5kyK6XMlXPpsDPzHt5ni0S6qptwb?=
 =?iso-8859-1?Q?l6Bp8p1b6MSu5wx4U5A3RjUOz7r3nJ25/VWKLj3NGKicDbjJ/ASm3ZWaQo?=
 =?iso-8859-1?Q?hNcSeLCTA2h8l1lZhSGCqmFcunPWHWv58lcT2ang2VIBDUoEMor7F7G+vv?=
 =?iso-8859-1?Q?MEFYfWWGzaqNGeqSqaI5dUQfSafauZGsT4A1oyEzsoyd4idUJo4VZhtdTC?=
 =?iso-8859-1?Q?K5DhzxZBa/+q/z8PFfvTtIdSrCyo/co3tVBg3clxCNGNNcRs/Lg845Otkj?=
 =?iso-8859-1?Q?naGNgy71eiQUW9SdhYL4rZHAWlLEOUl4mCc6AAtmklpG6/L5/2IosAkiAc?=
 =?iso-8859-1?Q?JVrccCVTNizuMm5+9oYDUY0tOCVFH/Q31sgmh1F2jtxIuY8Nb7W033Jtmg?=
 =?iso-8859-1?Q?TjYnNxoFQt3N+Lv1V5/HJyxw+mREiUutGTFE3d1nG+X46Y/6Eo1vEEFcnx?=
 =?iso-8859-1?Q?5qbDA2CjM9P69iEXKReuavCOsKSPSzhyl+J3BYgnLUYskLmcxR1R35DJ36?=
 =?iso-8859-1?Q?RCJKzFsMiRpoZX4js92bIvcJg4V3dep0gJBMDq8znx8U58vlAX1Gdd8+46?=
 =?iso-8859-1?Q?Abr+RN5ObBoGLZctJjayu9FH4bSZeMYb6zDfhxI13XknTkbokKnOPdkJYS?=
 =?iso-8859-1?Q?Q/UFgCts8sRIduPWEQ/3AqCBY3clAaCYPeeOzUuJzjZrmRbPKp5PrAYszE?=
 =?iso-8859-1?Q?ZKtxJXxDKskb9OWSoA0CcAVMpoabKuoFbCSWVGZd9Uz2chF9x7KIFY0Joy?=
 =?iso-8859-1?Q?b67jP6U41u4nVicWfViPMkYY52ZBc/tLsgclG9L+ZXTuOJKB6ZtXKMlcR4?=
 =?iso-8859-1?Q?+hn4r9kLqJ/rglYtiNTEsD1fp8Ayp24Z4i4FQPf1ftoTbQu8H1e7FyIsZq?=
 =?iso-8859-1?Q?r0HXoPGeP4bhfkRI2ZjCWjnNPoSMNClsPkjpYAm4m90jgK+hAu5E9cOTG9?=
 =?iso-8859-1?Q?+gOeJxQN0EoruVUD2bIirVq0XJNwOFST9Yim7JKz9si7T9aJD829GOkw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5983f8f1-57ec-4baa-0118-08dc22661953
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 14:08:28.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAyoD2C1AZS4Febz9wcYvO1AXpMEiw1vEnvF5lz0s9kWBJSScUZJ6ijOkFr8MuhibIKeQBt/+c87diLYQUhC3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6522
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 13.0% improvement of stress-ng.ioprio.ops_per_sec on:


commit: 53889bcaf536b3abedeaf104019877cee37dd08b ("block: make __get_task_ioprio() easier to read")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: btrfs
	test: ioprio
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240131/202401311609.2c8c0628-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/ioprio/stress-ng/60s

commit: 
  3b7cb74547 ("block: move __get_task_ioprio() into header file")
  53889bcaf5 ("block: make __get_task_ioprio() easier to read")

3b7cb745473aec72 53889bcaf536b3abedeaf104019 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     31039 ± 50%     +62.9%      50565 ± 30%  numa-vmstat.node1.nr_anon_pages
      0.01 ± 20%     -35.7%       0.00 ± 21%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     70.30            -3.2%      68.07        turbostat.RAMWatt
     14275 ±109%    +173.4%      39022 ± 46%  numa-meminfo.node1.AnonHugePages
    124137 ± 50%     +62.9%     202248 ± 30%  numa-meminfo.node1.AnonPages
    111.17 ± 16%     -68.2%      35.33 ± 27%  perf-c2c.DRAM.local
    221.33 ±  5%     -56.2%      97.00 ± 10%  perf-c2c.DRAM.remote
    524510 ±  8%     +25.5%     658460 ± 10%  sched_debug.cpu.max_idle_balance_cost.max
      3643 ±165%    +494.7%      21671 ± 34%  sched_debug.cpu.max_idle_balance_cost.stddev
   4756555           +13.0%    5374750        stress-ng.ioprio.ops
     79272           +13.0%      89575        stress-ng.ioprio.ops_per_sec
      4.52           -31.6%       3.09 ±  8%  perf-stat.i.MPKI
 3.514e+09            +6.2%  3.734e+09        perf-stat.i.branch-instructions
      0.31 ±  6%      -0.1        0.25 ±  7%  perf-stat.i.branch-miss-rate%
  12495630 ±  4%     -12.9%   10889062 ±  6%  perf-stat.i.branch-misses
      9.01            -2.0        7.03 ±  8%  perf-stat.i.cache-miss-rate%
  73180840           -32.5%   49400992 ±  8%  perf-stat.i.cache-misses
 8.118e+08           -13.4%  7.029e+08        perf-stat.i.cache-references
      1.41            +1.6%       1.43        perf-stat.i.cpi
    328.29 ±  3%     +46.7%     481.44 ±  6%  perf-stat.i.cycles-between-cache-misses
 3.862e+09            +6.8%  4.123e+09        perf-stat.i.dTLB-loads
      0.00            -0.0        0.00 ±  4%  perf-stat.i.dTLB-store-miss-rate%
 1.695e+09           +11.5%  1.891e+09        perf-stat.i.dTLB-stores
 1.658e+10            -1.8%  1.628e+10        perf-stat.i.instructions
    154.35            +5.7%     163.21        perf-stat.i.metric.M/sec
   7769868 ±  5%     -66.9%    2575037 ±  8%  perf-stat.i.node-load-misses
   1891321 ± 12%     -67.4%     616722 ± 38%  perf-stat.i.node-loads
      4.42           -31.3%       3.03 ±  7%  perf-stat.overall.MPKI
      0.36 ±  5%      -0.1        0.29 ±  6%  perf-stat.overall.branch-miss-rate%
      9.02            -2.0        7.03 ±  8%  perf-stat.overall.cache-miss-rate%
      1.39            +1.6%       1.42        perf-stat.overall.cpi
    315.95           +48.7%     469.87 ±  7%  perf-stat.overall.cycles-between-cache-misses
      0.00            -0.0        0.00 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
      0.72            -1.6%       0.71        perf-stat.overall.ipc
 3.455e+09            +6.2%  3.671e+09        perf-stat.ps.branch-instructions
  12275780 ±  4%     -12.8%   10699106 ±  6%  perf-stat.ps.branch-misses
  71968656           -32.5%   48582093 ±  8%  perf-stat.ps.cache-misses
 7.982e+08           -13.4%  6.912e+08        perf-stat.ps.cache-references
 3.797e+09            +6.8%  4.054e+09        perf-stat.ps.dTLB-loads
 1.667e+09           +11.5%  1.859e+09        perf-stat.ps.dTLB-stores
  1.63e+10            -1.8%  1.601e+10        perf-stat.ps.instructions
   7640492 ±  5%     -66.9%    2532136 ±  8%  perf-stat.ps.node-load-misses
   1859653 ± 12%     -67.4%     606316 ± 38%  perf-stat.ps.node-loads
 9.886e+11            -1.8%  9.707e+11        perf-stat.total.instructions
      0.59 ±  2%      +0.0        0.63 ±  2%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.do_iter_readv_writev.do_iter_write.vfs_writev
      0.63 ±  2%      +0.0        0.68 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fsync
      0.62 ±  4%      +0.0        0.68 ±  4%  perf-profile.calltrace.cycles-pp.import_iovec.vfs_writev.__x64_sys_pwritev.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.13            +0.1        1.18 ±  2%  perf-profile.calltrace.cycles-pp.filemap_get_entry.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter
      1.52            +0.1        1.62        perf-profile.calltrace.cycles-pp.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter.do_iter_readv_writev
      1.59            +0.1        1.69        perf-profile.calltrace.cycles-pp.simple_write_begin.generic_perform_write.generic_file_write_iter.do_iter_readv_writev.do_iter_write
      1.10 ±  3%      +0.1        1.22 ±  2%  perf-profile.calltrace.cycles-pp.security_task_getioprio.__do_sys_ioprio_get.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.39 ±  2%      +0.1        1.52 ±  3%  perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.generic_file_write_iter.do_iter_readv_writev
      1.60 ±  2%      +0.1        1.74 ±  2%  perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.generic_file_write_iter.do_iter_readv_writev.do_iter_write
      0.35 ± 70%      +0.2        0.54        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.syscall
      1.60 ±  3%      +0.2        1.79 ±  4%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.generic_file_write_iter.do_iter_readv_writev.do_iter_write
      7.02            +0.6        7.62 ±  2%  perf-profile.calltrace.cycles-pp.generic_perform_write.generic_file_write_iter.do_iter_readv_writev.do_iter_write.vfs_writev
      8.19            +0.7        8.89 ±  2%  perf-profile.calltrace.cycles-pp.generic_file_write_iter.do_iter_readv_writev.do_iter_write.vfs_writev.__x64_sys_pwritev
      8.54            +0.7        9.26 ±  2%  perf-profile.calltrace.cycles-pp.do_iter_readv_writev.do_iter_write.vfs_writev.__x64_sys_pwritev.do_syscall_64
      9.20            +0.8        9.95 ±  2%  perf-profile.calltrace.cycles-pp.do_iter_write.vfs_writev.__x64_sys_pwritev.do_syscall_64.entry_SYSCALL_64_after_hwframe
     52.90 ±  2%      +6.3       59.21        perf-profile.calltrace.cycles-pp._raw_spin_lock.get_task_ioprio.__do_sys_ioprio_get.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.20 ±  3%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.14 ±  7%      +0.0        0.18 ± 13%  perf-profile.children.cycles-pp.up_write
      0.30 ±  5%      +0.0        0.33 ±  5%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.42 ±  2%      +0.0        0.46 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.61 ±  2%      +0.0        0.66 ±  3%  perf-profile.children.cycles-pp.__generic_file_write_iter
      1.15            +0.1        1.20 ±  2%  perf-profile.children.cycles-pp.filemap_get_entry
      0.32 ±  4%      +0.1        0.38 ±  8%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.90 ±  2%      +0.1        0.97        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.42 ±  4%      +0.1        0.49 ±  6%  perf-profile.children.cycles-pp.find_task_by_vpid
      1.56            +0.1        1.64        perf-profile.children.cycles-pp.__filemap_get_folio
      1.60            +0.1        1.70        perf-profile.children.cycles-pp.simple_write_begin
      1.49 ±  2%      +0.1        1.62 ±  3%  perf-profile.children.cycles-pp.fault_in_readable
      1.64 ±  2%      +0.2        1.80 ±  3%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      1.45 ±  3%      +0.2        1.63        perf-profile.children.cycles-pp.security_task_getioprio
      1.61 ±  3%      +0.2        1.80 ±  4%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      7.08            +0.6        7.68 ±  2%  perf-profile.children.cycles-pp.generic_perform_write
      8.22            +0.7        8.92 ±  2%  perf-profile.children.cycles-pp.generic_file_write_iter
      8.56            +0.7        9.27 ±  2%  perf-profile.children.cycles-pp.do_iter_readv_writev
      9.21            +0.8        9.97 ±  2%  perf-profile.children.cycles-pp.do_iter_write
     62.57            +1.3       63.83        perf-profile.children.cycles-pp.get_task_ioprio
     53.95 ±  2%      +6.2       60.16        perf-profile.children.cycles-pp._raw_spin_lock
      9.16 ±  5%      -5.0        4.15 ±  2%  perf-profile.self.cycles-pp.get_task_ioprio
      9.84 ±  9%      -2.2        7.62 ±  4%  perf-profile.self.cycles-pp.__do_sys_ioprio_get
      0.16 ±  5%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.18 ±  2%      +0.0        0.21 ±  5%  perf-profile.self.cycles-pp.fault_in_iov_iter_readable
      0.49            +0.0        0.52 ±  2%  perf-profile.self.cycles-pp.filemap_get_entry
      0.29 ±  6%      +0.0        0.33 ±  6%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.88 ±  2%      +0.1        0.93        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.31 ±  3%      +0.1        0.37 ±  8%  perf-profile.self.cycles-pp.__radix_tree_lookup
      1.08 ±  4%      +0.1        1.21        perf-profile.self.cycles-pp.security_task_getioprio
      1.44 ±  2%      +0.1        1.57 ±  3%  perf-profile.self.cycles-pp.fault_in_readable
      1.60 ±  3%      +0.2        1.79 ±  4%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
     48.20 ±  4%      +7.5       55.66        perf-profile.self.cycles-pp._raw_spin_lock




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


