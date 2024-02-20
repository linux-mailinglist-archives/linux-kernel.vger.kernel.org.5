Return-Path: <linux-kernel+bounces-72595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D9385B5BA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E27D1F22D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524AE5D8EA;
	Tue, 20 Feb 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqOW78et"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603575B1F2;
	Tue, 20 Feb 2024 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418809; cv=fail; b=l7bm7LdXuHUQhH7l4B+eL0x7LcD3zcVTPQQGQaq0z6Tt+xdnjqEmS+/2u+e5+LbAT2RUgYy7ud25O/LF4WjOXuWQZTlixm26AZz9XTQc7qPIDet7nnUYVFm7pPclIwTg1XmimrYlLhRCbDSzA9g+HMGZ3ygIB47bsMg6V93V22g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418809; c=relaxed/simple;
	bh=iwX8CTA8PH0Sg70dHv2Y78qnUAyWNqyG6n2pwC/N5uM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MitKT2YCRcbMnQCAJHGc9XbXbQ27SGKs5BTjxYvVn2ksXpCER8YQuBFSuxJEXA3isdtH8z9r5HrrWj+sdm5zzVLIkR2RpE0AZFj6itiqjlMgcqF+5ASLDAyOLcagjHdI1A3IRRE1YoKe6atyO3yzkjl4eYC0b4upgW+fqTa8YJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqOW78et; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708418808; x=1739954808;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iwX8CTA8PH0Sg70dHv2Y78qnUAyWNqyG6n2pwC/N5uM=;
  b=JqOW78et20b5VEiF4F5xjqC4D0cOAfmBVy7/X/0diVRYibYuTua3RtbC
   R7adK9w0FMU7LEE8V3cZ3Pn3rT+gtislpVXLcZy7cJm/zrOQOpE+zn6f2
   DLiajmnvpjHdBsQ8OGtSSG7ZFqyYT8JvWi8JNT0iKh8giYrDWd99aDwYG
   5RXExYyzV6mZ2R6yzlZdkP870sj+Ct0QdexYp5w0SLXne0s+DfOIFTymb
   CRRdNUbU1LtW3OKP6mbzcUJUFsAE5IdoW3Ot+nifNuAjnaTwBktNMawzM
   5FgVt/sTcogMYWUwwLZvC6tz4jwVWr6C/87E2RNpJxPFPx7vJLhge1d6N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="27954864"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="27954864"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 00:46:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="9331993"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 00:46:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 00:46:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 00:46:45 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 00:46:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcpdN3HDIMQfz7PujTTiQl4boPuHpOFw9Yt9b1pnvZXG5wJStykbwtUYgLGVKlYOn7xjEELppuPvjtPZ3BKOvdCERIlxF+FI0143PLs7mXm9Gt5ehlLrqidftZoWC+4g2ftDCWlXxRLZIeVf3o+2o1VqnTeNik0fM/4jnkj2K3fzUllFUwpCY52njrDLBWnYJ05XwuIcqXu0JsQp2etCbDbX7C990hq6nWwsM+VNWCgESxEN3pxJxfN1IkwfRj0ua865EPDGbft5iHH+O0KOxfyl8lHBLOhNIpmq90jaJbrv31tsAEyMQyx8vF7zbq/AHmwG4GCtBBH/51c9S9JNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tm77INpmWNeV30K2CozOdxwp++f3uhs2ui6WA7YPG5U=;
 b=Yp527nouVAYZASFebUgtX8mxh/F68Aa6RtPLy6KrE6PuUzUnobpvcamSPHQiO34ftKbacIDtht0iwGEOOKcZCf4WCfWYLpUOBbqefHv3xKxsIHOu+L2nkmNsw0BiXeWmCfcfdMlSgmFQOn7s/fSqtuC2RvSD4WSOjU7vi4hjNTfFjmIVH0BSCVHyUDAE0KOudTE1i06pKP8scTfULOybpCxbndIrVkh3zMalteAPCS3MsQYLqEPPFjYCjJh5CzB9NqilfqeFh2Zt7zYZYQugr1u3nrF+3xf1MvwqUBVvzeQPGgfuJbH9WfrjQ+C4MgLRYMkcLojOXVL+xppWdhBQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SJ2PR11MB7714.namprd11.prod.outlook.com (2603:10b6:a03:4fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 08:46:41 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::5095:2f06:f31d:95e2]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::5095:2f06:f31d:95e2%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 08:46:41 +0000
Date: Tue, 20 Feb 2024 16:41:29 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>
CC: <peterz@infradead.org>, <namhyung@kernel.org>, <eranian@google.com>,
	<acme@kernel.org>, <mark.rutland@arm.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <bp@alien8.de>, <kan.liang@linux.intel.com>,
	<adrian.hunter@intel.com>, <maddy@linux.ibm.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sandipan.das@amd.com>, <ananth.narayan@amd.com>, <santosh.shukla@amd.com>,
	<pengfei.xu@intel.com>, <lkp@intel.com>
Subject: Re: [PATCH v4 1/4] perf/core: Rework forwarding of {task|cpu}-clock
 events
Message-ID: <ZdRluZx3fy0xx78D@xpf.sh.intel.com>
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
 <20230504110003.2548-2-ravi.bangoria@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230504110003.2548-2-ravi.bangoria@amd.com>
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SJ2PR11MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e7d9bc-21c3-4b7a-eafb-08dc31f075b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2U5OlRZa9oRAeGwhTY4vtFhBCJHx9lt31cG/Qc2MztDriCJoL7hzv6pX/MZFI1ikb7WqMSvYfV4fLfi5ee8q1T+69cqmVsQVLDkRYKWplbfN1tNk9792tuaAuNcfXZGdvlwhv8imODGJGN15tBfrDfVZdkHgBeD/hTPuVO8Nk5yNwNA6uc0jLJ6O0cCJkQW1sS913QvkHsXHW1oEFAGbn+/g56X/R6KDP0N7iUnLk0n3pd7jBFNSKdXyGd9NxDyRmUR5vwhfsPJIJ7SVr4CTcuaS1b+5BNxv3nkbwNDfc66j2rtPTAbA69rsCOWURNFApXmnrm3GrlefMCYwQVtVvCXAQNSr71k0NUymAT7ORKnhV98l3nHS3rJAbToaYD0Ae7EsHtQJxpMBmTRyDdRoLOfbAeiR7/vZA1e9Nc4nn74P0uGPlviSImaCasX+7IlZpxUshQK6SlgNFb/3MVvuP6ajpWrQ7jOKtByJulgE4cmihrNLlkUwGpb+pTiDwweO/GQ75edaqfjWBHksarXwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kOCVP3MWgLD2ojIMOQ5iFWSSpQcCLq1AiMsJcO0FSFcN6T1wSBczj+bTsrnc?=
 =?us-ascii?Q?nHXTtsWhOaDjmopw96Ac03BBZZxIhoevAroLfmeDgCx1t2Jqe7c9XjCCtrDM?=
 =?us-ascii?Q?aB0syv0ghJN07Mk7WXkS3CAIiannJtD+fQQi/CKCfFdhFyovAsTBmspzO/Sn?=
 =?us-ascii?Q?6mKm+Xv2FfXMT1dmFhlpnn9Gmc1wVwpDUSYbO36iakHhKeTuiQlVd0UXTgJA?=
 =?us-ascii?Q?n7B7+MAkVerQfqpltFjmPVCAls0ND2vnNCx+nQwVuPoY+OLQVPp8/TK/ea7D?=
 =?us-ascii?Q?uZfSdrmljsoC+31D4zSRf4AjeRrxwcx+wo8Dm0uVhDT4lt27P9/bYvdfR6nN?=
 =?us-ascii?Q?/hSmyksymEK6yBBEnQBSnBdI83s+1bPeYv8sxJQ8bP91CthAPRwp2qCwf4xs?=
 =?us-ascii?Q?VQ/ll3GqvAmCo+E4b/AJplFt/JGsNY++qmG+c3uw5kRA3r7wTW7t/Jb6JX8V?=
 =?us-ascii?Q?zkLcDvyXS6xvO1XXSHbpLCRYtPGrEWsZqwt0gq4TMH/FWaBJT7jlcyO/7pPd?=
 =?us-ascii?Q?Nt6NTO+E0m1MhQANXLG3QlEPnihvoFKfFe3WdieFrtYQ/pbMRFUAjx23zFpW?=
 =?us-ascii?Q?2nukmQZItfH8D06nXtkePJrCV37C+qrUJyXYqRz/R/mjxNxiu1CCZTEjOkZ0?=
 =?us-ascii?Q?e/srBC1uePAkwRy34wmk2ttym7HgxfzUKZN2mQt0bpAi9VfEujrZRJZxBHaU?=
 =?us-ascii?Q?qHcHyhF1L2IDu0U1HBeSCaCRlBWT9bVoHhNrlsmxCY6+5+kr/P4fMReJiji4?=
 =?us-ascii?Q?Xzu2vnKQiZoFzP9tmyiw6QrtXYv3xi7K+RnsB4OoQswINGoj0IMpDL+iPRCi?=
 =?us-ascii?Q?eEimdh7ynPZfWB9t+3vWy9aQEU2Fy8/a3BaQl5kd8OZI4SFfUt6LxjB/wwtX?=
 =?us-ascii?Q?cXcxNWIWXZezS0UJ/3kIpFROOp9X38+t+JriLdPsWK5em3fEKp4zUJb4MXUT?=
 =?us-ascii?Q?qZlzQ/INgXX1p2CbLEctoAE/vCZ+y0gdIgnA4SuB7wlMere0ji+QOsajUOmr?=
 =?us-ascii?Q?WCxe2JOjKpaGeGO3kwJWRiQLZ+NG/nGqcSVS7Y0A2HowSWfbPukJMbM/kZR5?=
 =?us-ascii?Q?bWj5k4QsQ6/JegYshHIe62/xyf0T0vkxcmkuTmA1RNL5yRPcCX9WWbNtarGa?=
 =?us-ascii?Q?96DSGt3baOn/MixdkKX0l7KmmJlxvkKagFqR+JTJwJ2faPGP4US/hxqOOQgw?=
 =?us-ascii?Q?5w2f2kltgPdb/qEY/5/m6uvhaYC8rkf4Ysnnf0rttzXQSBjjxjekkmmkyaGj?=
 =?us-ascii?Q?uL0H/5zL37oDzoCSwgTubGm4dfI/aOio5rJyROl8+AxOqjEXFTuIUUOapls0?=
 =?us-ascii?Q?R7IOaKURoyUG1Udo2eebKZZgx/dQer2y4wCz6z2dZjHH0jGt4oseqMGID3nm?=
 =?us-ascii?Q?iUzcYvg4+ZIlVTGZMN5e2x7QGE9pvVm4KlfD78vloQwug7y0KTMLOXo4Y0wR?=
 =?us-ascii?Q?4+cEzYO7ETqoGJ0YjC2QN9K6bCQsB2ALKKGvTla+Y9nxj2EgiuqV4U9MC2OV?=
 =?us-ascii?Q?+wOEOdsOOT1UBwnrtzTZYaHR1hPAjRweuPcWzbGMypvZsKxrdaFP6fI2uFDE?=
 =?us-ascii?Q?ybTIHbIem3Jt+9Rym0QVjf/DGzEVSKV1sZeKcyNf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e7d9bc-21c3-4b7a-eafb-08dc31f075b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 08:46:41.7442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+XZ7MGPKP5VsJK7JbW6alYuDhhzYfNT48LSTVYfv2rJud5ygZ3pQfusrebIzDfwm0I9ztSryKSC60bvOlTEOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7714
X-OriginatorOrg: intel.com

Hi Ravi Bangoria,

On 2023-05-04 at 16:30:00 +0530, Ravi Bangoria wrote:
> Currently, PERF_TYPE_SOFTWARE is treated specially since task-clock and
> cpu-clock events are interfaced through it but internally gets forwarded
> to their own pmus.
> 
> Rework this by overwriting event->attr.type in perf_swevent_init() which
> will cause perf_init_event() to retry with updated type and event will
> automatically get forwarded to right pmu. With the change, SW pmu no
> longer needs to be treated specially and can be included in 'pmu_idr'
> list.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  include/linux/perf_event.h | 10 +++++
>  kernel/events/core.c       | 77 ++++++++++++++++++++------------------
>  2 files changed, 51 insertions(+), 36 deletions(-)

Greeting!
There is task hung in perf_tp_event_init in v6.8-rc4 in guest.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240219_055325_perf_tp_event_init
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240219_055325_perf_tp_event_init/repro.c
Syzkaller reproduced syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240219_055325_perf_tp_event_init/repro.prog
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240219_055325_perf_tp_event_init/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240219_055325_perf_tp_event_init/bisect_info.log
v6.8-rc4 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240219_055325_perf_tp_event_init/841c35169323cd833294798e58b9bf63fa4fa1de_dmesg.log
v6.8-rc4 bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240219_055325_perf_tp_event_init/bzimage_v6.8-rc4.tar.gz

Bisected and found bad commit:
0d6d062ca27e perf/core: Rework forwarding of {task|cpu}-clock events

It could be reproduced in 3600s.
After reverted the above commit on top of v6.8-rc4 kernel, this issue was gone.

Syzkaller repro.report:
"
clocksource: Long readout interval, skipping watchdog check: cs_nsec: 2247936849 wd_nsec: 2247937071
INFO: task syz-executor703:819 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc4-4e6c5b0f4ced+ #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor703 state:D stack:0     pid:819   tgid:819   ppid:760    flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xa7d/0x2810 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xd0/0x290 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x1c/0x30 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0xf63/0x1b50 kernel/locking/mutex.c:752
 mutex_lock_nested+0x1f/0x30 kernel/locking/mutex.c:804
 perf_trace_init+0x5c/0x310 kernel/trace/trace_event_perf.c:221
 perf_tp_event_init+0xaf/0x130 kernel/events/core.c:10106
 perf_try_init_event+0x13f/0x5a0 kernel/events/core.c:11672
 perf_init_event kernel/events/core.c:11742 [inline]
 perf_event_alloc kernel/events/core.c:12022 [inline]
 perf_event_alloc+0x1069/0x3e40 kernel/events/core.c:11888
 __do_sys_perf_event_open+0x48e/0x2c40 kernel/events/core.c:12529
 __se_sys_perf_event_open kernel/events/core.c:12420 [inline]
 __x64_sys_perf_event_open+0xc7/0x160 kernel/events/core.c:12420
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x74/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x45c36d
RSP: 002b:00007fffec7b5478 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000045c36d
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000080
RBP: 00000000000b8995 R08: 0000000000000000 R09: 000000000000031a
R10: 00000000ffffffff R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000000 R14: 00000000004f9018 R15: 0000000000000000
 </TASK>
INFO: task syz-executor703:821 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc4-4e6c5b0f4ced+ #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor703 state:D stack:0     pid:821   tgid:821   ppid:767    flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xa7d/0x2810 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xd0/0x290 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x1c/0x30 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0xf63/0x1b50 kernel/locking/mutex.c:752
 mutex_lock_nested+0x1f/0x30 kernel/locking/mutex.c:804
 perf_trace_init+0x5c/0x310 kernel/trace/trace_event_perf.c:221
 perf_tp_event_init+0xaf/0x130 kernel/events/core.c:10106
 perf_try_init_event+0x13f/0x5a0 kernel/events/core.c:11672
 perf_init_event kernel/events/core.c:11742 [inline]
 perf_event_alloc kernel/events/core.c:12022 [inline]
 perf_event_alloc+0x1069/0x3e40 kernel/events/core.c:11888
 __do_sys_perf_event_open+0x48e/0x2c40 kernel/events/core.c:12529
 __se_sys_perf_event_open kernel/events/core.c:12420 [inline]
 __x64_sys_perf_event_open+0xc7/0x160 kernel/events/core.c:12420
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x74/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x45c36d
RSP: 002b:00007fffec7b5478 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000045c36d
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000080
RBP: 00000000000b8bea R08: 0000000000000000 R09: 000000000000031e
R10: 00000000ffffffff R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000000 R14: 00000000004f9018 R15: 0000000000000000
"

Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
./configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!

> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d5628a7b5eaa..5c8a748f51ac 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -295,6 +295,8 @@ struct perf_event_pmu_context;
>  
>  struct perf_output_handle;
>  
> +#define PMU_NULL_DEV	((void *)(~0))
> +
>  /**
>   * struct pmu - generic performance monitoring unit
>   */
> @@ -827,6 +829,14 @@ struct perf_event {
>  	void *security;
>  #endif
>  	struct list_head		sb_list;
> +
> +	/*
> +	 * Certain events gets forwarded to another pmu internally by over-
> +	 * writing kernel copy of event->attr.type without user being aware
> +	 * of it. event->orig_type contains original 'type' requested by
> +	 * user.
> +	 */
> +	__u32				orig_type;
>  #endif /* CONFIG_PERF_EVENTS */
>  };
>  
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 435815d3be3f..0695bb9fbbb6 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6647,7 +6647,7 @@ static void perf_sigtrap(struct perf_event *event)
>  		return;
>  
>  	send_sig_perf((void __user *)event->pending_addr,
> -		      event->attr.type, event->attr.sig_data);
> +		      event->orig_type, event->attr.sig_data);
>  }
>  
>  /*
> @@ -9951,6 +9951,9 @@ static void sw_perf_event_destroy(struct perf_event *event)
>  	swevent_hlist_put();
>  }
>  
> +static struct pmu perf_cpu_clock; /* fwd declaration */
> +static struct pmu perf_task_clock;
> +
>  static int perf_swevent_init(struct perf_event *event)
>  {
>  	u64 event_id = event->attr.config;
> @@ -9966,7 +9969,10 @@ static int perf_swevent_init(struct perf_event *event)
>  
>  	switch (event_id) {
>  	case PERF_COUNT_SW_CPU_CLOCK:
> +		event->attr.type = perf_cpu_clock.type;
> +		return -ENOENT;
>  	case PERF_COUNT_SW_TASK_CLOCK:
> +		event->attr.type = perf_task_clock.type;
>  		return -ENOENT;
>  
>  	default:
> @@ -11086,7 +11092,7 @@ static void cpu_clock_event_read(struct perf_event *event)
>  
>  static int cpu_clock_event_init(struct perf_event *event)
>  {
> -	if (event->attr.type != PERF_TYPE_SOFTWARE)
> +	if (event->attr.type != perf_cpu_clock.type)
>  		return -ENOENT;
>  
>  	if (event->attr.config != PERF_COUNT_SW_CPU_CLOCK)
> @@ -11107,6 +11113,7 @@ static struct pmu perf_cpu_clock = {
>  	.task_ctx_nr	= perf_sw_context,
>  
>  	.capabilities	= PERF_PMU_CAP_NO_NMI,
> +	.dev		= PMU_NULL_DEV,
>  
>  	.event_init	= cpu_clock_event_init,
>  	.add		= cpu_clock_event_add,
> @@ -11167,7 +11174,7 @@ static void task_clock_event_read(struct perf_event *event)
>  
>  static int task_clock_event_init(struct perf_event *event)
>  {
> -	if (event->attr.type != PERF_TYPE_SOFTWARE)
> +	if (event->attr.type != perf_task_clock.type)
>  		return -ENOENT;
>  
>  	if (event->attr.config != PERF_COUNT_SW_TASK_CLOCK)
> @@ -11188,6 +11195,7 @@ static struct pmu perf_task_clock = {
>  	.task_ctx_nr	= perf_sw_context,
>  
>  	.capabilities	= PERF_PMU_CAP_NO_NMI,
> +	.dev		= PMU_NULL_DEV,
>  
>  	.event_init	= task_clock_event_init,
>  	.add		= task_clock_event_add,
> @@ -11415,31 +11423,31 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>  		goto unlock;
>  
>  	pmu->type = -1;
> -	if (!name)
> -		goto skip_type;
> +	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
> +		ret = -EINVAL;
> +		goto free_pdc;
> +	}
> +
>  	pmu->name = name;
>  
> -	if (type != PERF_TYPE_SOFTWARE) {
> -		if (type >= 0)
> -			max = type;
> +	if (type >= 0)
> +		max = type;
>  
> -		ret = idr_alloc(&pmu_idr, pmu, max, 0, GFP_KERNEL);
> -		if (ret < 0)
> -			goto free_pdc;
> +	ret = idr_alloc(&pmu_idr, pmu, max, 0, GFP_KERNEL);
> +	if (ret < 0)
> +		goto free_pdc;
>  
> -		WARN_ON(type >= 0 && ret != type);
> +	WARN_ON(type >= 0 && ret != type);
>  
> -		type = ret;
> -	}
> +	type = ret;
>  	pmu->type = type;
>  
> -	if (pmu_bus_running) {
> +	if (pmu_bus_running && !pmu->dev) {
>  		ret = pmu_dev_alloc(pmu);
>  		if (ret)
>  			goto free_idr;
>  	}
>  
> -skip_type:
>  	ret = -ENOMEM;
>  	pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context);
>  	if (!pmu->cpu_pmu_context)
> @@ -11481,16 +11489,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>  	if (!pmu->event_idx)
>  		pmu->event_idx = perf_event_idx_default;
>  
> -	/*
> -	 * Ensure the TYPE_SOFTWARE PMUs are at the head of the list,
> -	 * since these cannot be in the IDR. This way the linear search
> -	 * is fast, provided a valid software event is provided.
> -	 */
> -	if (type == PERF_TYPE_SOFTWARE || !name)
> -		list_add_rcu(&pmu->entry, &pmus);
> -	else
> -		list_add_tail_rcu(&pmu->entry, &pmus);
> -
> +	list_add_rcu(&pmu->entry, &pmus);
>  	atomic_set(&pmu->exclusive_cnt, 0);
>  	ret = 0;
>  unlock:
> @@ -11499,12 +11498,13 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>  	return ret;
>  
>  free_dev:
> -	device_del(pmu->dev);
> -	put_device(pmu->dev);
> +	if (pmu->dev && pmu->dev != PMU_NULL_DEV) {
> +		device_del(pmu->dev);
> +		put_device(pmu->dev);
> +	}
>  
>  free_idr:
> -	if (pmu->type != PERF_TYPE_SOFTWARE)
> -		idr_remove(&pmu_idr, pmu->type);
> +	idr_remove(&pmu_idr, pmu->type);
>  
>  free_pdc:
>  	free_percpu(pmu->pmu_disable_count);
> @@ -11525,9 +11525,8 @@ void perf_pmu_unregister(struct pmu *pmu)
>  	synchronize_rcu();
>  
>  	free_percpu(pmu->pmu_disable_count);
> -	if (pmu->type != PERF_TYPE_SOFTWARE)
> -		idr_remove(&pmu_idr, pmu->type);
> -	if (pmu_bus_running) {
> +	idr_remove(&pmu_idr, pmu->type);
> +	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
>  		if (pmu->nr_addr_filters)
>  			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
>  		device_del(pmu->dev);
> @@ -11601,6 +11600,12 @@ static struct pmu *perf_init_event(struct perf_event *event)
>  
>  	idx = srcu_read_lock(&pmus_srcu);
>  
> +	/*
> +	 * Save original type before calling pmu->event_init() since certain
> +	 * pmus overwrites event->attr.type to forward event to another pmu.
> +	 */
> +	event->orig_type = event->attr.type;
> +
>  	/* Try parent's PMU first: */
>  	if (event->parent && event->parent->pmu) {
>  		pmu = event->parent->pmu;
> @@ -13640,8 +13645,8 @@ void __init perf_event_init(void)
>  	perf_event_init_all_cpus();
>  	init_srcu_struct(&pmus_srcu);
>  	perf_pmu_register(&perf_swevent, "software", PERF_TYPE_SOFTWARE);
> -	perf_pmu_register(&perf_cpu_clock, NULL, -1);
> -	perf_pmu_register(&perf_task_clock, NULL, -1);
> +	perf_pmu_register(&perf_cpu_clock, "cpu_clock", -1);
> +	perf_pmu_register(&perf_task_clock, "task_clock", -1);
>  	perf_tp_register();
>  	perf_event_init_cpu(smp_processor_id());
>  	register_reboot_notifier(&perf_reboot_notifier);
> @@ -13684,7 +13689,7 @@ static int __init perf_event_sysfs_init(void)
>  		goto unlock;
>  
>  	list_for_each_entry(pmu, &pmus, entry) {
> -		if (!pmu->name || pmu->type < 0)
> +		if (pmu->dev)
>  			continue;
>  
>  		ret = pmu_dev_alloc(pmu);
> -- 
> 2.40.0
> 

