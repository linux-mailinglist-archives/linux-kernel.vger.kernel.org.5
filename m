Return-Path: <linux-kernel+bounces-16272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB58823C02
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966861C2449B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADB119454;
	Thu,  4 Jan 2024 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMwSH+K5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7952718EBE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704348250; x=1735884250;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tiSXJDNgnEnZGQ4SQ2XGlaOb+7rVXZH+jcdk7KtWzk4=;
  b=GMwSH+K5F9pFNZ7jGq8aWfBZLHK+uyhi6Gq/pd7TkDCVmA6xwPZS4y5j
   jtpQ5oPWidZHpH5xYg/lAxjgJ7iLsuq/I+Lm3pDBP/Q2iCJh4JDJlVy2R
   z+0cjLCyx8xf7mIvHDWkb1d0f7pSBXxDaH1NXlszO4UE42xFWPI6/mLlv
   xzlfFaMc06PeKTjB59vd0GkYXp6uAZZmPjAMsyCZcNOn7z9vpn4L6+b6R
   9Rd1Q5HiJ4K8yGb3GA6nj0FXCX80ZarxnJZitahpAhQ2Zh8F5ms+VPP6a
   1lVH+6qMu56qc4gjzRzK4kNKztTCmGPbKrAseDDp/RM09Bmq4GGUqynQg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="4477501"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="4477501"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 22:04:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="903681073"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="903681073"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 22:04:08 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 22:04:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 22:04:07 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 22:04:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BanCWRg5Z9aFnCj+O5ae0F05rNh8lg6OthPvIMFja97JUSvtf6+q/FgpWGVkDs1fW6y1yMqZEFl4YBJg06L0p5qS/x3X3F1S80sbC5m9zIOWS/ZaI7jxJov+cqVAwDX9zU2ufhnRobJ2lhlWbx904IDOP3MdkNKw+Bnxkf9Y6mKXbh7wBuHi/mz/E3Ml4imnebKZ7b1dxtgi4Er+kQZB82iqkK8w2fB/AHKjLpdhCJyki65qiuJNOv5BKkAohyAsj/x43ybcfYmvoO7nZslWloXRFFTfuuBFa8rUaqF4PUZK6kPrPBAcb3NNKWSvfJn1TR/w10ilADyFTVH/NOaEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22xmZjgk2yn6zdbCsW+E7g/o73UrUdN/kNHDC2nP1b0=;
 b=B9ZfuDN+5jmGxVtmlo0pRN2YloRp8WoBuI5mkMitQPW1ze+AIkglbR+jDhQaFVhDbpVWV+Zi1Ja0cFN8owo5ZKEhWAYJqeU5ZWeiiyy2HR9bNUExxmA0Phb0c60FFe0ik0VaZuIXiZUq3Gy+JLElVRYNOq32n1IeT5lCvIyxqgTa4Dk/0pjbkw+rRpLjjYF7S1/upiHqB7g5qVv+qisMPU1OG4UG2gdyDbVHaz+Rj/X5F3whq13ZQYLU4oqpAxF8Bpr9FueabOlZc38sdHfv8ve3W6qjXer6Y8eiHh0k+RhuBR+VZlMjfEaOa7VdE+goc9i5yYX6HXAN0lMvJT8xQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH0PR11MB8192.namprd11.prod.outlook.com (2603:10b6:610:191::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.27; Thu, 4 Jan
 2024 06:04:06 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a9f3:d5aa:7ec3:d3e3]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a9f3:d5aa:7ec3:d3e3%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 06:04:05 +0000
Date: Thu, 4 Jan 2024 13:55:21 +0800
From: Feng Tang <feng.tang@intel.com>
To: Jiri Wiesner <jwiesner@suse.de>
CC: <linux-kernel@vger.kernel.org>, John Stultz <jstultz@google.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <ZZZISRg9YGyT2eQ+@feng-clx>
References: <20240103112113.GA6108@incl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240103112113.GA6108@incl>
X-ClientProxiedBy: SG2PR06CA0205.apcprd06.prod.outlook.com
 (2603:1096:4:68::13) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CH0PR11MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c9c331-6f81-4dfb-b115-08dc0ceaf550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9jelu6R1TNKA8nhnIHWzg60dJTAgD0KnccdiQA53u/7lqOEQjEL+SGqpTasVF+cGbydD1bSoo1QR+v+kxn5uSCdlyM4NKy9sz+MWYYprbwWyL4ps6pSRHP95os0r5aRJIBGZWgIRhoFJVej6wMXD8UJm3TMI1rxoApTKs9ZP5GbasEVBKVAt93d6MOUdF4oAXnLs5hE2dUA0dVWb5Y1o9+W60Uui1nILdSunC4UuOZFVter241wtB7Efo9bvjr2TUoDvOkKdvZrEXbayu0IMWJ48YHWbfjZj0x7rp+ptfV26gnwgTx9qXMktpBvpBY0PW0xEN/Bgc6dMucy2UN3kjvsYnq/cmGXsMocXAo+QCajB3Ix0C6jN4AtsmAmDj2auJGLMoREsTgD5BCvCClQQyIIPCT52aR74gahVpf5xsqqscPs/H3vgNwYqoUjseAInrChsuIbbwx4rJ4sPCOyVG9u5o0uvfrTeA4zecGR7lDJ9SRrGeRhBHXGyi+X8NZF/JOGLCct02cRnR8L2kvQHzx0QY/SyiiHxgpr92FW8xOMv5s8Ma/SRUwc6mYom9uX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(83380400001)(82960400001)(4326008)(44832011)(26005)(86362001)(6506007)(6512007)(316002)(9686003)(66476007)(66556008)(6916009)(66946007)(54906003)(66899024)(8676002)(8936002)(41300700001)(6666004)(478600001)(6486002)(5660300002)(33716001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tJVygJTlxwniY7SskWkNdA+OYfSo05ZWehgoXy6ytIFvLapVFn91uis1Lsbu?=
 =?us-ascii?Q?qUIRKvHqE9wfSK584WK12MAK93YnCVrr3ZGpvU9FHKJvXq0FTJzFvFhgKeq2?=
 =?us-ascii?Q?urzOj4qgty9TsZLi0AR4ky7mSbPEd1vbAClpFdK1ePY1uruwSZTwF1GrI9aM?=
 =?us-ascii?Q?uxKDKSCoS4yP/j2oLhxCwKqscA7ZPi7AnKYBl2DJ/i9nWt1llUjkpyCvsKQZ?=
 =?us-ascii?Q?vJ4mnvoMzZUnFxKgsXruI8TVOU946z7xo70trsU631Lmpbdflzr0iyuB227F?=
 =?us-ascii?Q?moLir9JUKuMvQUq0wfZcXJHiTdsJzL3c+PDJUythl0N1RHFc7UKINaCST//l?=
 =?us-ascii?Q?G6NnL0Udegzfre/WbIIyRE7amDTxEu5t4bht48rMOBk2r3lbf63p4Y9Y2jBp?=
 =?us-ascii?Q?CWt+mooooRdiKcgZJ8x3Hz95/1IiQoIxR82OLzQdajYHBnGNpB2t2ShNele3?=
 =?us-ascii?Q?iVpdeuFU+xIMpLW5oQZk9dOPN7eJC5d0TS9BZy0GnNe8Szppahe9gg+KKEuO?=
 =?us-ascii?Q?mGv8ar6Qa1grscRXwwkzUkYJgCa3V6AcJgbT+hDZW8TnbgWsT2WNQduri6Y/?=
 =?us-ascii?Q?9B8OxwjagjVQj68uY6yWEKUyc4xDoHi5UOi05t/2WvLfY+ZMQEJBBebv0kpn?=
 =?us-ascii?Q?U4lfVK0kghkflt0Tzvy+TpR4ExDvk2EnRHuEKEwpkacu9Gz3BeUKXTyzf73Z?=
 =?us-ascii?Q?llElqrzk6cFN0LBXsi2cHTvh/5GBk5HdCod11SRwAVsRZVzs6UWbvmPBsyb/?=
 =?us-ascii?Q?voj325ERl1Sjba87Z2+rjtxyzSr9CEs0MZA2yODm1xcd7ph4DLzPtriqDS0p?=
 =?us-ascii?Q?n2KaJmu2BVYq4Hh2QotJP8QGHaYjOAMJTUoIvwjnDo7Szdy/2dSLX8Xr/R7w?=
 =?us-ascii?Q?9wbTkkO/kVRrYqyaBU1WV3+lUMdfRf+sMT/7XMTknXCRW+qn/nAABQND6E1z?=
 =?us-ascii?Q?5NODi0L3cSzSSfipn0x2GDa+iF4Ewbh8/73NhHJ2tBOKoB2ipFZwzKh0K4pQ?=
 =?us-ascii?Q?zHztO7fBLTXfXaAiExRrSumnSwWHFAU/82sSML8j3i8Ea2ns2Gs8oNYvMU67?=
 =?us-ascii?Q?kXEAIsIjfQVY9Z4kr85Uh/2cJBI2FQjCxG0urDZPwZuw1jxpmwnBsP2U0xik?=
 =?us-ascii?Q?nmfkjpT+LfyUmHPx32mF46f902+O18WUg+G4JhLDKFGnTL0yxiOZq/VCzjif?=
 =?us-ascii?Q?ucfWIA2vThXN09T84HFJjIz0sFKgedCLAplGfzUpzVmCtqLj79Cv+lfhvxRx?=
 =?us-ascii?Q?eFDnCk2u9ejSDCs8SiiNUTQOXyBVdXruhbt5qfw4kYzLsgJynIsurw91jUEu?=
 =?us-ascii?Q?yfQvyzgo+jxzq1/T4rogzkYxVGcLcxXIjq/IE2ly8YVSeZ+IfwjZVGIJudIU?=
 =?us-ascii?Q?a9dOEPG8q3gCZUWI1d5py+z7HhEWEclsRedKO+p+hVxuUEAw1F7BzMzyFbRs?=
 =?us-ascii?Q?VVfrKxJQ3OkknGbX6o9ZQWUdEAIbdjEE52dq60ansABFeyhMST2Qbo5JAmyK?=
 =?us-ascii?Q?1lzeWH0yzD8GQFWof+3AUfm2mWr2KCPnqI/Kb5t9koEbxbyxycXbhNwxYrVM?=
 =?us-ascii?Q?4V3bomH/+AKod8wzH8ZN3roY4HFNN7Qva1oZCfRL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c9c331-6f81-4dfb-b115-08dc0ceaf550
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 06:04:05.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRZy9CVE5PSfKCuOCVHw1pxpYcEtKWg96w9uMaPuhndyPTO0eCOSMtkRqjOCHmDrE2h1kUojAALmsKrY/XeArw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8192
X-OriginatorOrg: intel.com

On Wed, Jan 03, 2024 at 12:21:13PM +0100, Jiri Wiesner wrote:
> There have been reports of the watchdog marking clocksources unstable on
> machines with 8 NUMA nodes:
> > clocksource: timekeeping watchdog on CPU373: Marking clocksource 'tsc' as unstable because the skew is too large:
> > clocksource:   'hpet' wd_nsec: 14523447520 wd_now: 5a749706 wd_last: 45adf1e0 mask: ffffffff
> > clocksource:   'tsc' cs_nsec: 14524115132 cs_now: 515ce2c5a96caa cs_last: 515cd9a9d83918 mask: ffffffffffffffff
> > clocksource:   'tsc' is current clocksource.
> > tsc: Marking TSC unstable due to clocksource watchdog
> > TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> > sched_clock: Marking unstable (1950347883333462, 79649632569)<-(1950428279338308, -745776594)
> > clocksource: Checking clocksource tsc synchronization from CPU 400 to CPUs 0,46,52,54,138,208,392,397.
> > clocksource: Switched to clocksource hpet
> 
> The measured clocksource skew - the absolute difference between cs_nsec
> and wd_nsec - was 668 microseconds:
> > cs_nsec - wd_nsec = 14524115132 - 14523447520 = 667612
> 
> The kernel (based on 5.14.21) used 200 microseconds for the
> uncertainty_margin of both the clocksource and watchdog, resulting in a
> threshold of 400 microseconds.  The discrepancy is that the measured
> clocksource skew was evaluated against a threshold suited for watchdog
> intervals of roughly WATCHDOG_INTERVAL, i.e. HZ >> 1, which is 0.5 second.
> Both the cs_nsec and the wd_nsec value indicate that the actual watchdog
> interval was circa 14.5 seconds. Since the watchdog is executed in softirq
> context the expiration of the watchdog timer can get severely delayed on
> account of a ksoftirqd thread not getting to run in a timely manner.
> Surely, a system with such belated softirq execution is not working well
> and the scheduling issue should be looked into but the clocksource
> watchdog should be able to deal with it accordingly.
> 
> The solution in this patch skips the current watchdog check if the
> watchdog interval exceeds 1.5 * WATCHDOG_INTERVAL. Considering the maximum
> watchdog interval of 1.5 * WATCHDOG_INTERVAL, the current default
> uncertainty margin (of the TSC and HPET) corresponds to a limit on
> clocksource skew of 333 ppm (microseconds of skew per second). To keep the
> limit imposed by NTP (500 microseconds of skew per second) for all
> possible watchdog intervals, the margins would have to be scaled so that
> the threshold value is proportional to the length of the actual watchdog
> interval.
> 
> Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")

IIUC, the issue could happen even before this commit? Though I do think 
this is good stuff for stable kernel.

> Suggested-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Jiri Wiesner <jwiesner@suse.de>

0Day robot reported some compiling issue. Other than that, it looks
good to me, thanks!

Reviewed-by: Feng Tang <feng.tang@intel.com>

>
> ---
>  kernel/time/clocksource.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index c108ed8a9804..ac5cb0ff278b 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -98,7 +98,9 @@ static u64 suspend_start;
>  /*
>   * Interval: 0.5sec.
>   */
> -#define WATCHDOG_INTERVAL (HZ >> 1)
> +#define WATCHDOG_INTERVAL	(HZ >> 1)
> +#define WATCHDOG_INTR_MAX_NS	((WATCHDOG_INTERVAL + (WATCHDOG_INTERVAL >> 1))\
> +				 * NSEC_PER_SEC / HZ)
>  
>  /*
>   * Threshold: 0.0312s, when doubled: 0.0625s.
> @@ -134,6 +136,7 @@ static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
>  static DEFINE_SPINLOCK(watchdog_lock);
>  static int watchdog_running;
>  static atomic_t watchdog_reset_pending;
> +static int64_t watchdog_max_intr;
>  
>  static inline void clocksource_watchdog_lock(unsigned long *flags)
>  {
> @@ -400,7 +403,7 @@ static void clocksource_watchdog(struct timer_list *unused)
>  {
>  	u64 csnow, wdnow, cslast, wdlast, delta;
>  	int next_cpu, reset_pending;
> -	int64_t wd_nsec, cs_nsec;
> +	int64_t wd_nsec, cs_nsec, interval;
>  	struct clocksource *cs;
>  	enum wd_read_status read_ret;
>  	unsigned long extra_wait = 0;
> @@ -470,6 +473,27 @@ static void clocksource_watchdog(struct timer_list *unused)
>  		if (atomic_read(&watchdog_reset_pending))
>  			continue;
>  
> +		/*
> +		 * The processing of timer softirqs can get delayed (usually
> +		 * on account of ksoftirqd not getting to run in a timely
> +		 * manner), which causes the watchdog interval to stretch.
> +		 * Some clocksources, e.g. acpi_pm, cannot tolerate
> +		 * watchdog intervals longer than a few seconds.
> +		 * Skew detection may fail for longer watchdog intervals
> +		 * on account of fixed margins being used.
> +		 */
> +		interval = max(cs_nsec, wd_nsec);
> +		if (unlikely(interval > WATCHDOG_INTR_MAX_NS)) {
> +			if (system_state > SYSTEM_SCHEDULING &&
> +			    interval > 2 * watchdog_max_intr) {
> +				watchdog_max_intr = interval;
> +				pr_warn("Skipping watchdog check: cs_nsec: %lld wd_nsec: %lld\n",
> +					cs_nsec, wd_nsec);
> +			}
> +			watchdog_timer.expires = jiffies;
> +			continue;
> +		}
> +
>  		/* Check the deviation from the watchdog clocksource. */
>  		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
>  		if (abs(cs_nsec - wd_nsec) > md) {
> -- 
> 2.35.3
> 
> 
> -- 
> Jiri Wiesner
> SUSE Labs

