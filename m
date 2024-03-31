Return-Path: <linux-kernel+bounces-125910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3C3892E1C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 01:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F0228244E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 00:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A24818;
	Sun, 31 Mar 2024 00:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fM8aPAyH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C9384;
	Sun, 31 Mar 2024 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711843424; cv=fail; b=HoGsSePwLz/BlQdapi2axC1zFEYAWFpOITcXJCPuQXCaWKqT5ZfOKwsFKF3rxQ3i/mbdkqQBOBfWkmDpFV9t3gMQ7pJtAJQXzuBU83w8pGwcFiVxCCpBq7n+fVyvjGrzgM4sk6Etg1Q1fJZGA41XFVHUARiBheL671JaRY/Ja6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711843424; c=relaxed/simple;
	bh=LVsr7lwrco42IIv6eBfVo+E9uIwjBJQCWgN5QOkT8nM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LOXiGXy0+upf3gSqRmEucKRjeDQu4zKlDGkRjSqkUCdVvOvHZR98QcTu7O2EWxrRYHhi20vRMu2w9zL5QK3p36Dq68eRhVnQJG0THWjD87pJ3iVaHq4IXpzUh4S5N17I+I6zmjmZ0YGoQtRKGG8LmlXWUAam2VS0my3A3o8OGsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fM8aPAyH; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711843421; x=1743379421;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=LVsr7lwrco42IIv6eBfVo+E9uIwjBJQCWgN5QOkT8nM=;
  b=fM8aPAyHUiXcRhqBp6+eaVS0Rym/Ctqxz4oPPfQ7a7aETvsLFlgg9Yhe
   MNE+LR9UM7WYXGacIqNEAiYwxEBGtIUshleSIsMqlQ8dZ9isXq3w2JqFy
   O0Q4R2lNrdxNAM8mPnOaTAL2XV2uxmeQQ/bckzLse5YSTWxJ2siC1ws6F
   ied17L0fA0Ea/Y0NoSgVZvz+cNwqhYNAmUwipzczVrzvV6dKCgv3m8o5Q
   3vvijLDJZBJx4+6jY9UitFmufV0GyLRL+Jw5NOPaGyM+Dhuh0rjZE2lHu
   yzGcuecbQhZBpni4iWdQBfV5idI9wrn+Wew7eaHMAjcLU+mdar7kscpee
   g==;
X-CSE-ConnectionGUID: r9npP6MLSTKgAeA9NDBtJQ==
X-CSE-MsgGUID: /xOtTKMtQQW4irmPr81TgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="24454330"
X-IronPort-AV: E=Sophos;i="6.07,168,1708416000"; 
   d="scan'208";a="24454330"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 17:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,168,1708416000"; 
   d="scan'208";a="17410828"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Mar 2024 17:03:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 30 Mar 2024 17:03:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 30 Mar 2024 17:03:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 30 Mar 2024 17:03:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cw1pst6dAWOdgR5zo41v9Qge49w2k5dKr/d/YN0ZMlCgHB0ZxqY8tg/YNAatfBzdiaLUbxoZljJDI+K7cctJFElrV1v1A/xRziz/LgZ0JctBym33/MydRDuS30dkd5RC1gJ5MlrKOl4HPidvg/g1j6k1d45ge9nqU3PDhS+xxQ0i8QE0GKyXqtiZf0AQEYLCMZhRzeLOzQc1qnCNrrlqAk5MVuLAjHCGfKaqQLZteUvOJKRmkiNg9He5RfsvqptUh/G8FvqtW7vLcbXKUwBsa5gWMn/fm4aFBKVygQRKyTvvK1zw2YCFKAivdokuSBMS6QfEyWL7UBtDsgrcTSx1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxd2lgTORYNny/UpF+ep9jLJLqKiIU8VxjU9MtaHhMw=;
 b=AGFUAWzE6fSE08KOE6TGAoWLNRz+kLqTv0+uan3m8QNHgKHL71UsTAzDG75g3RakH18xacqXQC1RljvNtm6Vrbb2mPjQOGtc8K+jom1C5wwAMjdLmXOXRnj+4VU90lc9hpAOHM7k7wHYCKCuCr1fze9SY3EgtgRTn5/OnGSe7sl99TXxnztPDklZ79aJjBafIM1cJisFSzY3q2Sr9KXwASOlQkPDKH80VKcwG8ApXOcy/P3fCEOyiVbi5mweSiRaNw+a4lcvwV7hR6tRtuZe5iPHPzj7DMRnGzlpUSRMDeGLl7c4te2xqKmD9+A58YX3ZttbwYahv+Uri8H/NEADgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.21; Sun, 31 Mar
 2024 00:03:06 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Sun, 31 Mar 2024
 00:03:06 +0000
Date: Sun, 31 Mar 2024 08:02:56 +0800
From: kernel test robot <oliver.sang@intel.com>
To: tada keisuke <keisuke1.tada@kioxia.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Toshifumi OHTAKE
	<toshifumi.ootake@kioxia.com>, <linux-raid@vger.kernel.org>,
	"song@kernel.org" <song@kernel.org>, "yukuai3@huawei.com"
	<yukuai3@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH 09/11] md: add atomic mode switching when removing disk
Message-ID: <202403310746.6c8b0587-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e95e7cea71d1465496a9502b4de49e75@kioxia.com>
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4517:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmjOqEKhKmS18PqIVn/KRcWbSYm20OMzaeAs+nfFiewqdmCsZ783R0nv4R/B45Ub/M5w75qJZUOIyO7/A/xboj45gOelxKogk+71ID6zCPWILdJNdObh26tXfyskZ+MhdyVNbBZAq0XJ81uQN21036j6eAKMRK9MJV0GN30/iqn/6xhswFlE92zkBSgAUTbeGe/GpQJohH+Y8iX8jqXlSLjENYWmKk7gxen2X67ySua6dlQC8MeVTP0sbuAy3P9P+5ylxrX4XVHuVnJApKJaJ75N+q0YFEEmYp90ObS/lHZQgtwikxsbuPQb12aDgrNb1mAeN2Q1hISm1NgD8o15zAa/Na7l4Y418ZgtkNIibVb9q0AN8qcmjw0PD7TzuZBQdjeOKTmwhUddRBV1GxMizqnNsaSvyH9ko3zhBF/HQ/aFI5TL6YfjIbSstgAX7HucHCNHSQUnI1+EbIXHi4E0xnY6RIThbx9LKo0DTAx1NuqpOlk47p3jh3zYgYcd7QoPGl9YV6mqHT2t0VIaJgoDn2qta5Dqz38r9Lk8QCsK7OVhxxNU9V4HUMyc8PDYRMJbJquOO7lGm2OBf8W8gGDvSqLm3sHzKha4x2gUEdAyUQ18i1Nr7Y/P+dUk+Y+vTMoA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VlZeYyTxbV+VE9iuMRcjU15xp2ZWFZl7qgtIEYFT4NJZ7UzRcZLvZDb6tH0f?=
 =?us-ascii?Q?SrPFjXJMJPRLbSIH+XfoH7zplENHXLm9tDreACeZxwq9Tek1PN5zJzRFDgGB?=
 =?us-ascii?Q?ABMtr9msjGg6KEW55KWbzK5gZpW69Ip9XqNfxKx6dBHmw4amtGS82JLOvlY+?=
 =?us-ascii?Q?PyjfeuY5hvamTDs6sPdPWbI13/6M7J2bv+N8AR4pogN2cbxW7pECIL1FzKvB?=
 =?us-ascii?Q?zmWG9TSTwFbcpvw6DgujcURRBbVYNTAaHezi7HKaA8Q4J9/vW6wlsSnOGd0+?=
 =?us-ascii?Q?VgJEyZchIP+EPlBrdrnkDZ5ZtbHeVjiDWtvBiDALr1SBpkahlwMucKjVmE8c?=
 =?us-ascii?Q?H+GryA6ZFt49GwPTls5W8YQ+bmbDcSZ8/RAfhQIKE8O103VOYLUoXqBK5QXH?=
 =?us-ascii?Q?0CJeMu4kcg6AKxqpkVt9z6pnJTsZ3SywPl0IvvEiJolUkS0Lfv9OlOLQv7ha?=
 =?us-ascii?Q?Nksk0Nss2nz8aQ+m8hGyaOiGgNUy8wdmKrV04PQaGrAbPr0LRJCOynX93hlE?=
 =?us-ascii?Q?wvU0Jd92PDaNpDTD+c0Gw6+8+JkmHEv9Y/U+KCHEmgZmlJMYqL03RRdGz5L0?=
 =?us-ascii?Q?7dT5tmH394QuvwMgBIVtjGJWPx+pMNb/7A/0IHvn9+HcUZLgmt3YVk4TyTSU?=
 =?us-ascii?Q?FC1VGu9gkCHy/o0WAvopuCj44oRypSSoyugVFUq95Xvi7DLWRAtYv9TeQoyn?=
 =?us-ascii?Q?PZQDpAuKwQ0x8ma8l+uSaAEQIfmN/kJA4OnMfsrUvJhUHm5Dd8q6liMCz8C7?=
 =?us-ascii?Q?BmIp1u2ygk4ylQOyqLaeNLi1yhBnxW/pYImA5PLXgY6h7krHM9muBIRM8m3B?=
 =?us-ascii?Q?f0LNVWzbyy7+WI70UcUicOkX7LuGW50bjCp9G5303vwwoBfKf5G2PcoSS7nh?=
 =?us-ascii?Q?3iY7h5D0uMwazZSyDYX7sBg9hB+3ZB4H9TmQ0iq98mzx78Lg077NuPZqc2Ba?=
 =?us-ascii?Q?DwPPwh+rBGnuWg6UlvCnOkwcyzYsBHjx3fOnWxSvc7+NZX1I3QiTjuecd2iI?=
 =?us-ascii?Q?bxRgzIDzvGC+yQmzsmQw4/xRdkC+8jtD9N21bvdupbky5NvTpusaHHI1caOR?=
 =?us-ascii?Q?T3FFmux56+86DBS6C/Ut56fLVMBBmTkpkSLhUGGRCnC4yCbXXOE+YCz3oRXG?=
 =?us-ascii?Q?1WtyGk8e0s2DlcuxN1gr7Lq4TBUCd0+mxbD7cAA6RGsgqvD2AJIVQ1HDg0yv?=
 =?us-ascii?Q?+c8Gret2eBYJt5xwGoHCqCX75Ww2kSjh/G+wg2C9B/m607t3fqthvbLpy6UI?=
 =?us-ascii?Q?uJC/u8NBzAgRxOPPYWiaoFHeZUOIdmFqGgPsqto4H2gc8Ep0pyDE0s7TLgFq?=
 =?us-ascii?Q?CWd3wVm0sffkf4pdoSST/d+f7Ma6M6piD1o+D5PpQ7cF2/5vm881YRE4963p?=
 =?us-ascii?Q?MLEkJ/9x5CuhZpeyETDUwAvpeu+txgS1LenQvxVR59h63KROAAaX+wlkpoXj?=
 =?us-ascii?Q?Tv0j3IQekxE59dV+xJhICQg3MnmPaystQmfmQPgHzSVQqSl7VZZW9cDb17gn?=
 =?us-ascii?Q?8/OJb50CICK2GbL/4m5Cv3AYti43I29Ak5JYX4/QP1lSmfWXwuBUO9GubgUd?=
 =?us-ascii?Q?9c6pBOoUJXqrP2hzQCy6ks+8ROKloD+dQOR1/yXB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da9140a4-054b-41c4-c54c-08dc5115f0b8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2024 00:03:05.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6mG64JA8pRke8cNi5j4PwiRvWITt9BjxcY1r5x4ytCI9BRTnMH6bZNFdO1CZgCSM5lXqr4X4DS+IpST1cMNcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_lib/percpu-refcount.c" on:

commit: ff944d1be0fabb044f97012008a26551ca2b6110 ("[PATCH 09/11] md: add atomic mode switching when removing disk")
url: https://github.com/intel-lab-lkp/linux/commits/tada-keisuke/md-add-infra-for-active_aligned_reads-changes/20240326-201827
patch link: https://lore.kernel.org/all/e95e7cea71d1465496a9502b4de49e75@kioxia.com/
patch subject: [PATCH 09/11] md: add atomic mode switching when removing disk

in testcase: mdadm-selftests
version: mdadm-selftests-x86_64-5f41845-1_20240223
with following parameters:

	disk: 1HDD
	test_prefix: 01replace



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GHz (Haswell) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403310746.6c8b0587-oliver.sang@intel.com


kern  :err   : [  118.926307] BUG: sleeping function called from invalid context at lib/percpu-refcount.c:331
kern  :err   : [  118.935427] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 55, name: kworker/6:0
kern  :err   : [  118.944338] preempt_count: 0, expected: 0
kern  :err   : [  118.949122] RCU nest depth: 1, expected: 0
kern  :warn  : [  118.954016] CPU: 6 PID: 55 Comm: kworker/6:0 Tainted: G S                 6.8.0-rc3-00236-gff944d1be0fa #1
kern  :warn  : [  118.964389] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F9 04/21/2015
kern  :warn  : [  118.973916] Workqueue: md_misc md_start_sync
kern  :warn  : [  118.978937] Call Trace:
kern  :warn  : [  118.982115]  <TASK>
kern :warn : [  118.984943] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
kern :warn : [  118.989337] __might_resched (kernel/sched/core.c:10190) 
kern :warn : [  118.993989] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  118.999243] ? preempt_notifier_dec (kernel/sched/core.c:10144) 
kern :warn : [  119.004321] percpu_ref_switch_to_atomic_sync (include/linux/kernel.h:107 lib/percpu-refcount.c:331) 
kern :warn : [  119.010353] ? percpu_ref_reinit (lib/percpu-refcount.c:329) 
kern :warn : [  119.015351] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  119.020596] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161) 
kern :warn : [  119.026282] ? finish_task_switch+0x158/0x730 
kern :warn : [  119.031969] ? __switch_to (arch/x86/include/asm/bitops.h:55 include/asm-generic/bitops/instrumented-atomic.h:29 include/linux/thread_info.h:89 arch/x86/include/asm/fpu/sched.h:66 arch/x86/kernel/process_64.c:626) 
kern :warn : [  119.036435] rdev_removeable (drivers/md/md.c:9282) 
kern :warn : [  119.041083] md_start_sync (drivers/md/md.c:9339 drivers/md/md.c:9449) 
kern :warn : [  119.045462] ? mddev_unlock (drivers/md/md.c:9444) 
kern :warn : [  119.050021] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
kern :warn : [  119.054928] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169) 
kern :warn : [  119.059739] process_one_work (kernel/workqueue.c:2638) 
kern :warn : [  119.064476] worker_thread (kernel/workqueue.c:2700 kernel/workqueue.c:2787) 
kern :warn : [  119.068943] ? process_one_work (kernel/workqueue.c:2733) 
kern :warn : [  119.073864] kthread (kernel/kthread.c:388) 
kern :warn : [  119.077815] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  119.083321] ret_from_fork (arch/x86/kernel/process.c:153) 
kern :warn : [  119.087627] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  119.093140] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
kern  :warn  : [  119.097786]  </TASK>
kern  :warn  : [  119.759182] md: could not open device unknown-block(7,0).
kern  :warn  : [  119.765403] md: md_import_device returned -16
kern  :warn  : [  119.783930] md: could not open device unknown-block(7,0).
kern  :warn  : [  119.790144] md: md_import_device returned -16
kern  :warn  : [  119.892290] md: could not open device unknown-block(7,2).
kern  :warn  : [  119.898467] md: md_import_device returned -16
kern  :warn  : [  119.992911] md: could not open device unknown-block(7,2).
kern  :warn  : [  119.999095] md: md_import_device returned -16
kern  :info  : [  120.026412] md: recovery of RAID array md0
kern  :crit  : [  121.049797] md/raid1:md0: Disk failure on loop0, disabling device.
md/raid1:md0: Operation continuing on 4 devices.
kern  :crit  : [  121.063187] md/raid1:md0: Disk failure on loop2, disabling device.
md/raid1:md0: Operation continuing on 4 devices.
kern  :info  : [  121.217876] md: md0: recovery interrupted.
kern  :err   : [  121.312998] BUG: sleeping function called from invalid context at lib/percpu-refcount.c:331
kern  :err   : [  121.322110] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 49, name: kworker/5:0
kern  :err   : [  121.330961] preempt_count: 0, expected: 0
kern  :err   : [  121.335740] RCU nest depth: 1, expected: 0
kern  :warn  : [  121.340592] CPU: 5 PID: 49 Comm: kworker/5:0 Tainted: G S      W          6.8.0-rc3-00236-gff944d1be0fa #1
kern  :warn  : [  121.350970] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F9 04/21/2015
kern  :warn  : [  121.360474] Workqueue: md_misc md_start_sync
kern  :warn  : [  121.365471] Call Trace:
kern  :warn  : [  121.368640]  <TASK>
kern :warn : [  121.371471] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
kern :warn : [  121.375875] __might_resched (kernel/sched/core.c:10190) 
kern :warn : [  121.380527] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  121.385785] ? preempt_notifier_dec (kernel/sched/core.c:10144) 
kern :warn : [  121.390872] percpu_ref_switch_to_atomic_sync (include/linux/kernel.h:107 lib/percpu-refcount.c:331) 
kern :warn : [  121.396935] ? percpu_ref_reinit (lib/percpu-refcount.c:329) 
kern :warn : [  121.401935] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  121.407186] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161) 
kern :warn : [  121.412891] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
kern :warn : [  121.417795] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169) 
kern :warn : [  121.422613] ? ilookup (fs/inode.c:1478) 
kern :warn : [  121.426648] rdev_removeable (drivers/md/md.c:9282) 
kern :warn : [  121.431292] md_start_sync (drivers/md/md.c:9339 drivers/md/md.c:9449) 
kern :warn : [  121.435673] ? mddev_unlock (drivers/md/md.c:9444) 
kern :warn : [  121.440220] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
kern :warn : [  121.445121] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169) 
kern :warn : [  121.449942] process_one_work (kernel/workqueue.c:2638) 
kern :warn : [  121.454678] worker_thread (kernel/workqueue.c:2700 kernel/workqueue.c:2787) 
kern :warn : [  121.459141] ? process_one_work (kernel/workqueue.c:2733) 
kern :warn : [  121.464048] kthread (kernel/kthread.c:388) 
kern :warn : [  121.468000] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  121.473526] ret_from_fork (arch/x86/kernel/process.c:153) 
kern :warn : [  121.477816] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  121.483320] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
kern  :warn  : [  121.487959]  </TASK>
kern  :info  : [  121.988888] md0: detected capacity change from 37888 to 0
kern  :info  : [  121.995036] md: md0 stopped.
kern  :info  : [  123.466969] md/raid:md0: device loop2 operational as raid disk 2
kern  :info  : [  123.473751] md/raid:md0: device loop1 operational as raid disk 1
kern  :info  : [  123.480538] md/raid:md0: device loop0 operational as raid disk 0
kern  :info  : [  123.490861] md/raid:md0: raid level 5 active with 3 out of 4 devices, algorithm 2
kern  :info  : [  123.499377] md0: detected capacity change from 0 to 107520
kern  :info  : [  123.522226] md: recovery of RAID array md0
kern  :info  : [  127.495329] md: md0: recovery done.
kern  :info  : [  128.173070] md: recovery of RAID array md0
kern  :info  : [  129.790540] md: md0: recovery done.
kern  :info  : [  138.827750] md0: detected capacity change from 107520 to 0
kern  :info  : [  138.834000] md: md0 stopped.
kern  :info  : [  140.161682] md/raid:md0: device loop2 operational as raid disk 2
kern  :info  : [  140.168444] md/raid:md0: device loop1 operational as raid disk 1
kern  :info  : [  140.175190] md/raid:md0: device loop0 operational as raid disk 0
kern  :info  : [  140.185349] md/raid:md0: raid level 5 active with 3 out of 4 devices, algorithm 2
kern  :info  : [  140.193814] md0: detected capacity change from 0 to 107520
kern  :info  : [  140.211289] md: recovery of RAID array md0
kern  :info  : [  141.742870] md: md0: recovery done.
kern  :info  : [  142.144104] md: recovery of RAID array md0
kern  :info  : [  143.458509] md: md0: recovery done.
kern  :warn  : [  152.283405] md: could not open device unknown-block(7,1).
kern  :warn  : [  152.289619] md: md_import_device returned -16
kern  :warn  : [  152.427331] md: could not open device unknown-block(7,1).
kern  :warn  : [  152.433535] md: md_import_device returned -16
kern  :warn  : [  152.536920] md: could not open device unknown-block(7,5).
kern  :warn  : [  152.543110] md: md_import_device returned -16
kern  :warn  : [  152.561921] md: could not open device unknown-block(7,5).
kern  :warn  : [  152.568109] md: md_import_device returned -16
kern  :info  : [  152.590430] md: recovery of RAID array md0
kern  :crit  : [  153.616325] md/raid:md0: Disk failure on loop2, disabling device.
kern  :crit  : [  153.623160] md/raid:md0: Operation continuing on 3 devices.
kern  :info  : [  153.800876] md: md0: recovery interrupted.
kern  :info  : [  153.922361] md: recovery of RAID array md0
kern  :info  : [  155.524625] md: md0: recovery done.
kern  :err   : [  155.754540] BUG: sleeping function called from invalid context at lib/percpu-refcount.c:331
kern  :err   : [  155.763624] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 91, name: kworker/7:1
kern  :err   : [  155.772451] preempt_count: 0, expected: 0
kern  :err   : [  155.777202] RCU nest depth: 1, expected: 0
kern  :warn  : [  155.782026] CPU: 7 PID: 91 Comm: kworker/7:1 Tainted: G S      W          6.8.0-rc3-00236-gff944d1be0fa #1
kern  :warn  : [  155.792390] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F9 04/21/2015
kern  :warn  : [  155.801895] Workqueue: md_misc md_start_sync
kern  :warn  : [  155.806898] Call Trace:
kern  :warn  : [  155.810066]  <TASK>
kern :warn : [  155.812896] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
kern :warn : [  155.817271] __might_resched (kernel/sched/core.c:10190) 
kern :warn : [  155.821924] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  155.827165] ? preempt_notifier_dec (kernel/sched/core.c:10144) 
kern :warn : [  155.832226] percpu_ref_switch_to_atomic_sync (include/linux/kernel.h:107 lib/percpu-refcount.c:331) 
kern :warn : [  155.838251] ? percpu_ref_reinit (lib/percpu-refcount.c:329) 
kern :warn : [  155.843234] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  155.848476] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161) 
kern :warn : [  155.854145] ? finish_task_switch+0x158/0x730 
kern :warn : [  155.859821] ? __switch_to (arch/x86/include/asm/bitops.h:55 include/asm-generic/bitops/instrumented-atomic.h:29 include/linux/thread_info.h:89 arch/x86/include/asm/fpu/sched.h:66 arch/x86/kernel/process_64.c:626) 
kern :warn : [  155.864276] rdev_removeable (drivers/md/md.c:9282) 
kern :warn : [  155.868929] md_start_sync (drivers/md/md.c:9339 drivers/md/md.c:9449) 
kern :warn : [  155.873302] ? mddev_unlock (drivers/md/md.c:9444) 
kern :warn : [  155.877867] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
kern :warn : [  155.882764] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169) 
kern :warn : [  155.887576] process_one_work (kernel/workqueue.c:2638) 
kern :warn : [  155.892298] worker_thread (kernel/workqueue.c:2700 kernel/workqueue.c:2787) 
kern :warn : [  155.896760] ? __kthread_parkme (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:280) 
kern :warn : [  155.901570] ? schedule (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6816 kernel/sched/core.c:6830) 
kern :warn : [  155.905684] ? process_one_work (kernel/workqueue.c:2733) 
kern :warn : [  155.910573] kthread (kernel/kthread.c:388) 
kern :warn : [  155.914512] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  155.920012] ret_from_fork (arch/x86/kernel/process.c:153) 
kern :warn : [  155.924302] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  155.929797] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
kern  :warn  : [  155.934433]  </TASK>
kern  :warn  : [  156.780974] md: could not open device unknown-block(7,0).
kern  :warn  : [  156.787176] md: md_import_device returned -16
kern  :warn  : [  156.813913] md: could not open device unknown-block(7,0).
kern  :warn  : [  156.820059] md: md_import_device returned -16
kern  :warn  : [  156.871990] md: could not open device unknown-block(7,2).
kern  :warn  : [  156.878172] md: md_import_device returned -16
kern  :warn  : [  156.963988] md: could not open device unknown-block(7,2).
kern  :warn  : [  156.970173] md: md_import_device returned -16
kern  :info  : [  156.986088] md: recovery of RAID array md0
kern  :crit  : [  158.003774] md/raid:md0: Disk failure on loop0, disabling device.
kern  :crit  : [  158.010838] md/raid:md0: Operation continuing on 4 devices.
kern  :crit  : [  158.017346] md/raid:md0: Disk failure on loop2, disabling device.
kern  :crit  : [  158.024178] md/raid:md0: Operation continuing on 4 devices.
kern  :info  : [  158.184927] md: md0: recovery interrupted.
kern  :err   : [  158.266093] BUG: sleeping function called from invalid context at lib/percpu-refcount.c:331
kern  :err   : [  158.275193] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 190, name: kworker/5:2
kern  :err   : [  158.284123] preempt_count: 0, expected: 0
kern  :err   : [  158.288881] RCU nest depth: 1, expected: 0
kern  :warn  : [  158.293730] CPU: 5 PID: 190 Comm: kworker/5:2 Tainted: G S      W          6.8.0-rc3-00236-gff944d1be0fa #1
kern  :warn  : [  158.304175] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F9 04/21/2015
kern  :warn  : [  158.313665] Workqueue: md_misc md_start_sync
kern  :warn  : [  158.318646] Call Trace:
kern  :warn  : [  158.321801]  <TASK>
kern :warn : [  158.324609] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
kern :warn : [  158.328992] __might_resched (kernel/sched/core.c:10190) 
kern :warn : [  158.333629] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  158.338898] ? preempt_notifier_dec (kernel/sched/core.c:10144) 
kern :warn : [  158.343961] percpu_ref_switch_to_atomic_sync (include/linux/kernel.h:107 lib/percpu-refcount.c:331) 
kern :warn : [  158.349985] ? percpu_ref_reinit (lib/percpu-refcount.c:329) 
kern :warn : [  158.354967] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  158.360201] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161) 
kern :warn : [  158.365884] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
kern :warn : [  158.370782] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169) 
kern :warn : [  158.375586] ? ilookup (fs/inode.c:1478) 
kern :warn : [  158.379617] rdev_removeable (drivers/md/md.c:9282) 
kern :warn : [  158.384252] md_start_sync (drivers/md/md.c:9339 drivers/md/md.c:9449) 
kern :warn : [  158.388627] ? mddev_unlock (drivers/md/md.c:9444) 
kern :warn : [  158.393169] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
kern :warn : [  158.398058] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169) 
kern :warn : [  158.402883] process_one_work (kernel/workqueue.c:2638) 
kern :warn : [  158.407610] worker_thread (kernel/workqueue.c:2700 kernel/workqueue.c:2787) 
kern :warn : [  158.412071] ? __kthread_parkme (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:280) 
kern :warn : [  158.416896] ? schedule (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6816 kernel/sched/core.c:6830) 
kern :warn : [  158.421007] ? process_one_work (kernel/workqueue.c:2733) 
kern :warn : [  158.425925] kthread (kernel/kthread.c:388) 
kern :warn : [  158.429879] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  158.435389] ret_from_fork (arch/x86/kernel/process.c:153) 
kern :warn : [  158.439676] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  158.445178] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
kern  :warn  : [  158.449820]  </TASK>
kern  :info  : [  158.999087] md0: detected capacity change from 107520 to 0
kern  :info  : [  159.005324] md: md0 stopped.
kern  :notice: [  160.278559] md/raid:md0: not clean -- starting background reconstruction
kern  :info  : [  160.286141] md/raid:md0: device loop3 operational as raid disk 3
kern  :info  : [  160.292936] md/raid:md0: device loop2 operational as raid disk 2
kern  :info  : [  160.299686] md/raid:md0: device loop1 operational as raid disk 1
kern  :info  : [  160.306458] md/raid:md0: device loop0 operational as raid disk 0
kern  :info  : [  160.316201] md/raid:md0: raid level 6 active with 4 out of 4 devices, algorithm 2
kern  :info  : [  160.324745] md0: detected capacity change from 0 to 71680
kern  :info  : [  160.342177] md: resync of RAID array md0
kern  :info  : [  162.910917] md: md0: resync done.
kern  :info  : [  163.428101] md: recovery of RAID array md0
kern  :info  : [  164.843841] md: md0: recovery done.
kern  :info  : [  173.752259] md0: detected capacity change from 71680 to 0
kern  :info  : [  173.758415] md: md0 stopped.
kern  :notice: [  175.032616] md/raid:md0: not clean -- starting background reconstruction
kern  :info  : [  175.040224] md/raid:md0: device loop3 operational as raid disk 3
kern  :info  : [  175.046985] md/raid:md0: device loop2 operational as raid disk 2
kern  :info  : [  175.053746] md/raid:md0: device loop1 operational as raid disk 1
kern  :info  : [  175.060481] md/raid:md0: device loop0 operational as raid disk 0
kern  :info  : [  175.069831] md/raid:md0: raid level 6 active with 4 out of 4 devices, algorithm 2
kern  :info  : [  175.078887] md0: detected capacity change from 0 to 71680
kern  :info  : [  175.095215] md: resync of RAID array md0
kern  :info  : [  176.660892] md: md0: resync done.
kern  :info  : [  176.989056] md: recovery of RAID array md0
kern  :info  : [  178.526271] md: md0: recovery done.
kern  :warn  : [  187.686913] md: could not open device unknown-block(7,1).
kern  :warn  : [  187.693097] md: md_import_device returned -16
kern  :warn  : [  187.771973] md: could not open device unknown-block(7,1).
kern  :warn  : [  187.778161] md: md_import_device returned -16
kern  :warn  : [  187.809159] md: could not open device unknown-block(7,5).
kern  :warn  : [  187.815314] md: md_import_device returned -16
kern  :warn  : [  187.904979] md: could not open device unknown-block(7,5).
kern  :warn  : [  187.911158] md: md_import_device returned -16
kern  :info  : [  187.926356] md: recovery of RAID array md0
kern  :crit  : [  188.944557] md/raid:md0: Disk failure on loop2, disabling device.
kern  :crit  : [  188.951622] md/raid:md0: Operation continuing on 3 devices.
kern  :info  : [  189.104924] md: md0: recovery interrupted.
kern  :info  : [  189.183218] md: recovery of RAID array md0
kern  :info  : [  190.826166] md: md0: recovery done.
kern  :err   : [  191.088693] BUG: sleeping function called from invalid context at lib/percpu-refcount.c:331
kern  :err   : [  191.097786] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 73, name: kworker/4:1
kern  :err   : [  191.106610] preempt_count: 0, expected: 0
kern  :err   : [  191.111346] RCU nest depth: 1, expected: 0
kern  :warn  : [  191.116188] CPU: 4 PID: 73 Comm: kworker/4:1 Tainted: G S      W          6.8.0-rc3-00236-gff944d1be0fa #1
kern  :warn  : [  191.126554] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F9 04/21/2015
kern  :warn  : [  191.136048] Workqueue: md_misc md_start_sync
kern  :warn  : [  191.141039] Call Trace:
kern  :warn  : [  191.144202]  <TASK>
kern :warn : [  191.147019] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
kern :warn : [  191.151391] __might_resched (kernel/sched/core.c:10190) 
kern :warn : [  191.156028] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  191.161272] ? preempt_notifier_dec (kernel/sched/core.c:10144) 
kern :warn : [  191.166342] percpu_ref_switch_to_atomic_sync (include/linux/kernel.h:107 lib/percpu-refcount.c:331) 
kern :warn : [  191.172364] ? percpu_ref_reinit (lib/percpu-refcount.c:329) 
kern :warn : [  191.177338] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  191.182575] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161) 
kern :warn : [  191.188251] ? finish_task_switch+0x158/0x730 
kern :warn : [  191.193938] ? __switch_to (arch/x86/include/asm/bitops.h:55 include/asm-generic/bitops/instrumented-atomic.h:29 include/linux/thread_info.h:89 arch/x86/include/asm/fpu/sched.h:66 arch/x86/kernel/process_64.c:626) 
kern :warn : [  191.198400] rdev_removeable (drivers/md/md.c:9282) 
kern :warn : [  191.203035] md_start_sync (drivers/md/md.c:9339 drivers/md/md.c:9449) 
kern :warn : [  191.207404] ? mddev_unlock (drivers/md/md.c:9444) 
kern :warn : [  191.211944] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
kern :warn : [  191.216833] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169) 
kern :warn : [  191.221636] process_one_work (kernel/workqueue.c:2638) 
kern :warn : [  191.226359] worker_thread (kernel/workqueue.c:2700 kernel/workqueue.c:2787) 
kern :warn : [  191.230821] ? __kthread_parkme (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:280) 
kern :warn : [  191.235622] ? schedule (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6816 kernel/sched/core.c:6830) 
kern :warn : [  191.239731] ? process_one_work (kernel/workqueue.c:2733) 
kern :warn : [  191.244628] kthread (kernel/kthread.c:388) 
kern :warn : [  191.248570] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  191.254065] ret_from_fork (arch/x86/kernel/process.c:153) 
kern :warn : [  191.258346] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  191.263841] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
kern  :warn  : [  191.268471]  </TASK>
kern  :warn  : [  192.084192] md: could not open device unknown-block(7,0).
kern  :warn  : [  192.090393] md: md_import_device returned -16
kern  :warn  : [  192.111934] md: could not open device unknown-block(7,0).
kern  :warn  : [  192.118110] md: md_import_device returned -16
kern  :warn  : [  192.228041] md: could not open device unknown-block(7,2).
kern  :warn  : [  192.234252] md: md_import_device returned -16
kern  :warn  : [  192.345984] md: could not open device unknown-block(7,2).
kern  :warn  : [  192.352186] md: md_import_device returned -16
kern  :info  : [  192.373232] md: recovery of RAID array md0
kern  :crit  : [  193.383569] md/raid:md0: Disk failure on loop0, disabling device.
kern  :crit  : [  193.390634] md/raid:md0: Operation continuing on 4 devices.
kern  :crit  : [  193.397384] md/raid:md0: Disk failure on loop2, disabling device.
kern  :crit  : [  193.404226] md/raid:md0: Operation continuing on 4 devices.
kern  :info  : [  193.616932] md: md0: recovery interrupted.
kern  :err   : [  193.716934] BUG: sleeping function called from invalid context at lib/percpu-refcount.c:331
kern  :err   : [  193.726036] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 73, name: kworker/4:1
kern  :err   : [  193.734867] preempt_count: 0, expected: 0
kern  :err   : [  193.739606] RCU nest depth: 1, expected: 0
kern  :warn  : [  193.744441] CPU: 4 PID: 73 Comm: kworker/4:1 Tainted: G S      W          6.8.0-rc3-00236-gff944d1be0fa #1
kern  :warn  : [  193.754806] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F9 04/21/2015
kern  :warn  : [  193.764296] Workqueue: md_misc md_start_sync
kern  :warn  : [  193.769286] Call Trace:
kern  :warn  : [  193.772446]  <TASK>
kern :warn : [  193.775254] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
kern :warn : [  193.779632] __might_resched (kernel/sched/core.c:10190) 
kern :warn : [  193.784267] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  193.789513] ? preempt_notifier_dec (kernel/sched/core.c:10144) 
kern :warn : [  193.794581] percpu_ref_switch_to_atomic_sync (include/linux/kernel.h:107 lib/percpu-refcount.c:331) 
kern :warn : [  193.800606] ? percpu_ref_reinit (lib/percpu-refcount.c:329) 
kern :warn : [  193.805588] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  193.810832] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161) 
kern :warn : [  193.816507] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
kern :warn : [  193.821395] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169) 
kern :warn : [  193.826198] ? ilookup (fs/inode.c:1478) 
kern :warn : [  193.830227] rdev_removeable (drivers/md/md.c:9282) 
kern :warn : [  193.834870] md_start_sync (drivers/md/md.c:9339 drivers/md/md.c:9449) 
kern :warn : [  193.839241] ? mddev_unlock (drivers/md/md.c:9444) 
kern :warn : [  193.843791] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
kern :warn : [  193.848687] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169) 
kern :warn : [  193.853488] process_one_work (kernel/workqueue.c:2638) 
kern :warn : [  193.858212] worker_thread (kernel/workqueue.c:2700 kernel/workqueue.c:2787) 
kern :warn : [  193.862676] ? __kthread_parkme (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:280) 
kern :warn : [  193.867485] ? schedule (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6816 kernel/sched/core.c:6830) 
kern :warn : [  193.871592] ? process_one_work (kernel/workqueue.c:2733) 
kern :warn : [  193.876481] kthread (kernel/kthread.c:388) 
kern :warn : [  193.880417] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  193.885933] ret_from_fork (arch/x86/kernel/process.c:153) 
kern :warn : [  193.890225] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  193.895721] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
kern  :warn  : [  193.900360]  </TASK>
kern  :info  : [  194.330682] md0: detected capacity change from 71680 to 0
kern  :info  : [  194.336833] md: md0 stopped.
kern  :notice: [  195.543602] md/raid10:md0: not clean -- starting background reconstruction
kern  :info  : [  195.551446] md/raid10:md0: active with 4 out of 4 devices
kern  :info  : [  195.558030] md0: detected capacity change from 0 to 71680
kern  :info  : [  195.577281] md: resync of RAID array md0
kern  :info  : [  198.109747] md: md0: resync done.
kern  :info  : [  198.542124] md: recovery of RAID array md0
kern  :info  : [  200.056477] md: md0: recovery done.
kern  :info  : [  209.239944] md0: detected capacity change from 71680 to 0
kern  :info  : [  209.246082] md: md0 stopped.
kern  :notice: [  210.527395] md/raid10:md0: not clean -- starting background reconstruction
kern  :info  : [  210.535251] md/raid10:md0: active with 4 out of 4 devices
kern  :info  : [  210.541889] md0: detected capacity change from 0 to 71680
kern  :info  : [  210.561317] md: resync of RAID array md0
kern  :info  : [  211.716332] md: md0: resync done.
kern  :info  : [  212.447069] md: recovery of RAID array md0
kern  :info  : [  213.978699] md: md0: recovery done.
kern  :warn  : [  223.211938] md: could not open device unknown-block(7,1).
kern  :warn  : [  223.218124] md: md_import_device returned -16
kern  :warn  : [  223.257300] md: could not open device unknown-block(7,1).
kern  :warn  : [  223.263494] md: md_import_device returned -16
kern  :warn  : [  223.287023] md: could not open device unknown-block(7,5).
kern  :warn  : [  223.293171] md: md_import_device returned -16
kern  :warn  : [  223.362992] md: could not open device unknown-block(7,5).
kern  :warn  : [  223.369185] md: md_import_device returned -16
kern  :info  : [  223.384335] md: recovery of RAID array md0
kern  :crit  : [  224.403344] md/raid10:md0: Disk failure on loop2, disabling device.
md/raid10:md0: Operation continuing on 3 devices.
kern  :info  : [  224.488889] md: md0: recovery interrupted.
kern  :info  : [  224.585256] md: recovery of RAID array md0
kern  :info  : [  226.293761] md: md0: recovery done.
kern  :err   : [  226.554473] BUG: sleeping function called from invalid context at lib/percpu-refcount.c:331
kern  :err   : [  226.563578] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 130, name: kworker/6:2
kern  :err   : [  226.572535] preempt_count: 0, expected: 0
kern  :err   : [  226.577303] RCU nest depth: 1, expected: 0
kern  :warn  : [  226.582161] CPU: 6 PID: 130 Comm: kworker/6:2 Tainted: G S      W          6.8.0-rc3-00236-gff944d1be0fa #1
kern  :warn  : [  226.592612] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F9 04/21/2015
kern  :warn  : [  226.602101] Workqueue: md_misc md_start_sync
kern  :warn  : [  226.607083] Call Trace:
kern  :warn  : [  226.610237]  <TASK>
kern :warn : [  226.613045] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
kern :warn : [  226.617425] __might_resched (kernel/sched/core.c:10190) 
kern :warn : [  226.622058] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  226.627303] ? preempt_notifier_dec (kernel/sched/core.c:10144) 
kern :warn : [  226.632374] percpu_ref_switch_to_atomic_sync (include/linux/kernel.h:107 lib/percpu-refcount.c:331) 
kern :warn : [  226.638396] ? percpu_ref_reinit (lib/percpu-refcount.c:329) 
kern :warn : [  226.643378] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  226.648613] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161) 
kern :warn : [  226.654291] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
kern :warn : [  226.659186] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169) 
kern :warn : [  226.663987] ? ilookup (fs/inode.c:1478) 
kern :warn : [  226.668009] rdev_removeable (drivers/md/md.c:9282) 
kern :warn : [  226.672646] md_start_sync (drivers/md/md.c:9339 drivers/md/md.c:9449) 
kern :warn : [  226.677022] ? mddev_unlock (drivers/md/md.c:9444) 
kern :warn : [  226.681565] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
kern :warn : [  226.686461] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169) 
kern :warn : [  226.691271] process_one_work (kernel/workqueue.c:2638) 
kern :warn : [  226.695995] worker_thread (kernel/workqueue.c:2700 kernel/workqueue.c:2787) 
kern :warn : [  226.700459] ? __kthread_parkme (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:280) 
kern :warn : [  226.705266] ? schedule (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6816 kernel/sched/core.c:6830) 
kern :warn : [  226.709374] ? process_one_work (kernel/workqueue.c:2733) 
kern :warn : [  226.714265] kthread (kernel/kthread.c:388) 
kern :warn : [  226.718208] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  226.723711] ret_from_fork (arch/x86/kernel/process.c:153) 
kern :warn : [  226.728000] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  226.733502] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
kern  :warn  : [  226.738140]  </TASK>
kern  :warn  : [  227.649205] md: could not open device unknown-block(7,0).
kern  :warn  : [  227.655415] md: md_import_device returned -16
kern  :warn  : [  227.685927] md: could not open device unknown-block(7,0).
kern  :warn  : [  227.692107] md: md_import_device returned -16
kern  :warn  : [  227.797982] md: could not open device unknown-block(7,2).
kern  :warn  : [  227.804162] md: md_import_device returned -16
kern  :warn  : [  227.944996] md: could not open device unknown-block(7,2).
kern  :warn  : [  227.951208] md: md_import_device returned -16
kern  :info  : [  227.967120] md: recovery of RAID array md0
kern  :crit  : [  228.985719] md/raid10:md0: Disk failure on loop0, disabling device.
md/raid10:md0: Operation continuing on 4 devices.
kern  :crit  : [  228.999227] md/raid10:md0: Disk failure on loop2, disabling device.
md/raid10:md0: Operation continuing on 4 devices.
kern  :info  : [  229.096887] md: md0: recovery interrupted.
kern  :err   : [  229.165863] BUG: sleeping function called from invalid context at lib/percpu-refcount.c:331
kern  :err   : [  229.174964] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 73, name: kworker/4:1
kern  :err   : [  229.183784] preempt_count: 0, expected: 0
kern  :err   : [  229.188523] RCU nest depth: 1, expected: 0
kern  :warn  : [  229.193358] CPU: 4 PID: 73 Comm: kworker/4:1 Tainted: G S      W          6.8.0-rc3-00236-gff944d1be0fa #1
kern  :warn  : [  229.203724] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F9 04/21/2015
kern  :warn  : [  229.213227] Workqueue: md_misc md_start_sync
kern  :warn  : [  229.218220] Call Trace:
kern  :warn  : [  229.221379]  <TASK>
kern :warn : [  229.224200] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
kern :warn : [  229.228586] __might_resched (kernel/sched/core.c:10190) 
kern :warn : [  229.233227] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  229.238476] ? preempt_notifier_dec (kernel/sched/core.c:10144) 
kern :warn : [  229.243555] percpu_ref_switch_to_atomic_sync (include/linux/kernel.h:107 lib/percpu-refcount.c:331) 
kern :warn : [  229.249583] ? percpu_ref_reinit (lib/percpu-refcount.c:329) 
kern :warn : [  229.254570] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [  229.259823] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161) 
kern :warn : [  229.265515] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
kern :warn : [  229.270433] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169) 
kern :warn : [  229.275259] ? ilookup (fs/inode.c:1478) 
kern :warn : [  229.279304] rdev_removeable (drivers/md/md.c:9282) 
kern :warn : [  229.283960] md_start_sync (drivers/md/md.c:9339 drivers/md/md.c:9449) 
kern :warn : [  229.288353] ? mddev_unlock (drivers/md/md.c:9444) 
kern :warn : [  229.292926] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
kern :warn : [  229.297822] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169) 
kern :warn : [  229.302628] process_one_work (kernel/workqueue.c:2638) 
kern :warn : [  229.307351] worker_thread (kernel/workqueue.c:2700 kernel/workqueue.c:2787) 
kern :warn : [  229.311816] ? __kthread_parkme (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:280) 
kern :warn : [  229.316625] ? schedule (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6816 kernel/sched/core.c:6830) 
kern :warn : [  229.320742] ? process_one_work (kernel/workqueue.c:2733) 
kern :warn : [  229.325639] kthread (kernel/kthread.c:388) 
kern :warn : [  229.329583] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  229.335086] ret_from_fork (arch/x86/kernel/process.c:153) 
kern :warn : [  229.339375] ? kthread_complete_and_exit (kernel/kthread.c:341) 
kern :warn : [  229.344903] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
kern  :warn  : [  229.349552]  </TASK>
kern  :info  : [  230.034175] md0: detected capacity change from 71680 to 0
kern  :info  : [  230.040328] md: md0 stopped.
user  :notice: [  230.172156] /lkp/benchmarks/mdadm-selftests/tests/01replace...

user  :notice: [  230.182102] 	ERROR: dmesg prints errors when testing 01replace!



user  :notice: [  230.313235] FAILED - see /var/tmp/01replace.log and /var/tmp/fail01replace.log for details

user  :notice: [  232.427336] /usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-hsw-d05/mdadm-selftests-1HDD-01replace-debian-12-x86_64-20240206.cgz-ff944d1be0fa-20240330-19609-1pfk1lw-3.yaml&job_state=post_run -O /dev/null

user  :notice: [  234.062157] kill 564 vmstat --timestamp -n 10

user  :notice: [  234.166819] kill 562 dmesg --follow --decode



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240331/202403310746.6c8b0587-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


