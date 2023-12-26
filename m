Return-Path: <linux-kernel+bounces-11537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B04881E7D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984D81F2287E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84464F1EB;
	Tue, 26 Dec 2023 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdTLLB2r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3424F1E1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703600727; x=1735136727;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tJs/nTil7YxPW+2Z1eTKQ/WXRctYmTbKdEFiWMcWokA=;
  b=MdTLLB2rHygsVOQWRf8U2MZ3SxWTgAMrRPVge+e99xB9pQkYoSL7eCXl
   oiL5guJ7SIzFudPnQGVhEsjlw3WvpqUKJiRuYiI3AKNe/+Sed/UbQQ1xG
   dbQLf2E1MM9F44GOWPm8lPr6B6722ofIeIJtBVZolP95DDNzq2MnYipj/
   TMV8ytYt1PTsa5K5ikKyKnAH3dMnhanwcRnw7hl3MvTzHEnGhj2/qlGyu
   7zkALSM0NU+z22yVgCVTJ/+Wn4GMDif/0h0jePw3jPpeUu2HllFR+B/Ge
   Em9QOYXIAGQ/bUBZhqwNa6ylsKltoSjG4uAwqGXzebGlL0pthsL69ohKY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="460682103"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="460682103"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 06:25:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="12456883"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Dec 2023 06:25:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 06:25:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 06:25:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Dec 2023 06:25:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Dec 2023 06:25:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaVrPzpBEma589e4W5t6UsuyuUDIopCY1dz5XShCVmo/fwM2y1zB+dtesCb46Xs95AqSnYC6qxzbWWadijSfykBF7+qGQLtGKUo2dbNdnmOwlNwto8WaW2q82rZWXck1+o7VC4agBeIz5y9m2VUFRxat7+BNbsGCwpFhhheQoIO2zxzOqiv35LL1gWHDgVOi70yJbbl5qvJOY6hWhjzIurTtNpZaGyoNKgBuS+AWNugk7Frh8NHLYOStgmgIfYyugMrwUPKa249LuSSdpY+ozpHcwFWLbZnXnTzaA3DuKTrhBPBdXJ31drXfaukUteSXdqVtOlFnB2kwby5PgBAXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6RWTyAocpd3rb5dDnR021GQZC3wbswyZiUsy2OPQHE=;
 b=X35Yh21H7uA/Chmy4sR9jyD7A1lJYNxZI0iMYgkLWQN79i8C1u7fFVYyYXQ2QRfY93+YYx22X7vDy36XS6lQdjqaj52b7FKtBV2bThifNeoweGU64jEUY1lz9qgBCIBDNtuWUZ2L+dWcFrTcNwCbq4FRGPqtvAIMBt+O2HLqyZQD7D4z4ccEjnJT7Cej7+JgF1x5eP6HRwf9DMUkuh97Aa7wyjM9mFvMt7v6jHCQ3KwEwi6ZEy4BggxdYISs6g2wdiWJE2C0syWTj/6RE2arzJEc4fIN21rk8xmMr5NLHLTZ5C1P648U9/anzTKkzhkW2jhvD0IdttgJtwoeBXlHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 14:25:21 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a9f3:d5aa:7ec3:d3e3]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a9f3:d5aa:7ec3:d3e3%6]) with mapi id 15.20.7135.017; Tue, 26 Dec 2023
 14:25:21 +0000
Date: Tue, 26 Dec 2023 22:16:33 +0800
From: Feng Tang <feng.tang@intel.com>
To: Jiri Wiesner <jwiesner@suse.de>
CC: <linux-kernel@vger.kernel.org>, John Stultz <jstultz@google.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] clocksource: Use proportional clocksource skew threshold
Message-ID: <ZYrgQUTB3ayTtMqK@feng-clx>
References: <20231221160517.GA22919@incl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231221160517.GA22919@incl>
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CY5PR11MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f881e01-4a13-4739-3ff3-08dc061e7e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VlQ+yqxTMVXS4MBV72/1cmp+FAh5fmUvVgZ9lnK3+1q2wcjYyBJLT0hmxCymGg8ZFsfkrfWPsqqqH4y9JFjethYYVodjVbFiYRKHniPr7PVh25zR55WDTXJRuWSKWpbO4wh6J0Qno0bd6aABHqYL6/a18oULHE7v9DlUw4vv9O/sFzC9HNHoLZyDK7LyFXg2QVjxEbS2JMMX9qpwFhXxVJ8H4VZ3x87I3liXvUtqW56PLQyR6ive9BGynTjZZguQ06HVLw2gurTSprVxXPLEBzl26SGPY25t9yjly4K2IibC0optfbltuJo/OYSs/OnaJl8n4izeXgiVwC9ki2NbBsaXK2ZvLgwPrGk+/6EYYE2uOg7zbXI5DYMFbhWFFBtCoBPg31ivEh931cKHIN6jcVba+2EjpVfoAsadGGj1ppBoijttKhX7x7+N2HUSr93cxmt9c1iEtYJ1BXV2sb5B3HxPfJ3riZSDcl/4mTC1e89+/Rlm8v/Lj9rKg9nWkPpRFo2FGwFK4WjHmH+qtgP+ijNrCrilEx5EIglNFhexBhZ/k6L1Cq9B8xuJJWyZw0/b18JpHo9cLXV8stApu6QONLw5tdd2Bt753IE84hs3fmwXbiWZX32Pvc3/I6x2rZfz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(1800799012)(451199024)(2906002)(66476007)(6916009)(66946007)(5660300002)(44832011)(66556008)(4326008)(66899024)(8676002)(8936002)(316002)(54906003)(41300700001)(9686003)(478600001)(6486002)(6666004)(6512007)(6506007)(86362001)(26005)(38100700002)(33716001)(83380400001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xcB3LJGP7nXx2bs+//cnVWX5iDxvq3RPvzbbLqCGkJ4qZMWErvc1N7sX5/Jh?=
 =?us-ascii?Q?A8La1TXXrrzQEEaM6Aj8qzRq5hzws6L5yU3gnIQa98bb/d5k/H63P22pSdVT?=
 =?us-ascii?Q?riT19zcPVJw+B58jpWTDm8ohJWDCv7uZIZqrUaCwuUAbJaRY5xO8aCzvO5Dc?=
 =?us-ascii?Q?R30BrlAvjS1B4aKWxa08KI4BjAo32MxPL6sMcJdBtbExnjJGKwZYLOInpuBX?=
 =?us-ascii?Q?Z2ZPUQIR5PhjtJXLlXAh1SxxmOeObl5hSpo3Ff5R+pzIXuW+P/3j29Gf9s//?=
 =?us-ascii?Q?tPzNs6kkY8Ue5L/HXcdmQ2TikI1uy33BO5aiL0+2AgtAWx732EVgScMbIfb4?=
 =?us-ascii?Q?OXom0qF0Vm+7SgU3SCWrlhOjhl6xWB3dwHlxZIZxmxZA3VBQX8AvbuuSWjiE?=
 =?us-ascii?Q?wsLFxbodqSAZ2umsG0xGSwLOVjZ7c5JHfKcgYUslycc/Y0+8mgxfMubFUS4O?=
 =?us-ascii?Q?DQNNnxKHsN1pw/kFGgV6K0hC79nxt8luxBX9f6nsSi7geLqAo3QKu5xLdhAY?=
 =?us-ascii?Q?nUKVCoHfucEvN3z1lJwNBcWm3Y+76AeKhI1OOa6CDevcMNjAmrcMNElnQfe+?=
 =?us-ascii?Q?0YejpraGnSkAIy8efaR8MK93WeFSgV8eQSwVy0YWg2IEdxaZvkrGsPkh92mo?=
 =?us-ascii?Q?t7pZqfcez0BNcH37Xr1m0OxqozIzcO7nf8JFuMi1yUMq+ZmNSrSyxXhzdctc?=
 =?us-ascii?Q?f93ggRJ1hI4gx+Rslbvv0mJbOxotXj1PRvRSpgNLvfkBBOiRRuBiDQXOWnJq?=
 =?us-ascii?Q?zaqkqsiaVWfuxlKqHHSyU+S1rL+5TEV1srgcLs9KF2f2PJ10NxPYz15uymEh?=
 =?us-ascii?Q?7GEYlLmlRSQXJoNhlcADBQRqwAv56cR+RtwWL64DFGZMyB7+EW5h6iqvokiG?=
 =?us-ascii?Q?S6H1OmrbfjWOpnziPY07Pkq9efRZxCz9bbbDOujvZ7MwxZDVIDg8Qvby8qwF?=
 =?us-ascii?Q?WozKIZWVyKhU6wr6L4Ie21Nn2bbei5pKO9m+osjacvVI4HnF7M/sRjIDu3nw?=
 =?us-ascii?Q?+RKq2BB5h7V+aMaTfxX8E8FuBObD9vlh+EeU8BNJH2pkEFfVwn/gnP6vU7LO?=
 =?us-ascii?Q?TIsr+ndM8tnGGbF8EZ25S/3YAT246TGr+CaMc0WkR20zx4rX/QrxjsN5VKHC?=
 =?us-ascii?Q?u9xu2rshqYwT4Wjiz8qFk4ComrGwoRSaykCmm6bP1E7CCrQq+U0WssmHTjY6?=
 =?us-ascii?Q?bGbLBKZebox8K0cFGoL7zoD6jFDYXGSzzbUApZi9kJIwMvCc8kppL+Dj8KMG?=
 =?us-ascii?Q?xlLODz3dHMybj29+6zmPhjeu3K7Nrov0WhRKddiD5KG9bsLjH2MOqnIhRtlu?=
 =?us-ascii?Q?k2YLe/Vrn6VtuEmSZ/ZM1zIEa2+B1YdNXqveZr2f4I6Nf8h3QlHGz/cmgw0H?=
 =?us-ascii?Q?C3Y/qiH1LOHbbyM7vZuflxZzepSbd/0NE7+hn27eM+IlKHzcbYu8I+WjISBY?=
 =?us-ascii?Q?lC+CnvuKu1HCNB/BTgttnLFcY1YiIRAwT6yZGuupErcTfoehqJE7HDhVmjtF?=
 =?us-ascii?Q?7euVtrecd4bjDh5KynvhVVgQhLA12G/OrKuprm7E5rQByit0WntPjSaHrKyO?=
 =?us-ascii?Q?ObD6DKW9nG3QD4y5vVmyfu6Bkvw77Zq57QkXVNPi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f881e01-4a13-4739-3ff3-08dc061e7e3e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 14:25:21.8286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5r2QGRbQThdL2p9+cK0kLMjtou+00TKfvesqNUDcXcC1iLJAc8iCaga9bCsmlCI6NsBuWMYz1q/t0cppfxzJEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6318
X-OriginatorOrg: intel.com

On Thu, Dec 21, 2023 at 05:05:17PM +0100, Jiri Wiesner wrote:
> There have been reports of the watchdog marking clocksources unstable on
> machines 8 NUMA nodes:
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
> The kernel used 200 microseconds for the uncertainty_margin of both the
> clocksource and watchdog, resulting in a threshold of 400 microseconds.
> The discrepancy is that the measured clocksource skew was evaluated against
> a threshold suited for watchdog intervals of roughly WATCHDOG_INTERVAL,
> i.e. HZ >> 1. Both the cs_nsec and the wd_nsec value indicate that the
> actual watchdog interval was circa 14.5 seconds. Since the watchdog is
> executed in softirq context the expiration of the watchdog timer can get
> severely delayed on account of a ksoftirqd thread not getting to run in a
> timely manner. Surely, a system with such belated softirq execution is not
> working well and the scheduling issue should be looked into but the
> clocksource watchdog should be able to deal with it accordingly.

We've seen similar reports on LKML that the watchdog timer was delayed
for a very long time (some was 100+ seconds). As you said, the
scheduling issue should be addressed.

Meanwhile, instead of adding new complex logic to clocksource watchdog
code, can we just printk_once a warning message and skip the current
watchdog check if the duration is too long. ACPI_PM timer only has a
24 bit counter which will wrap around every 3~4 seconds, when the
duration is too long, like 14.5 seconds here, the check is already
meaningless.

Thanks,
Feng

> 
> To keep the limit imposed by NTP (500 microseconds of skew per second),
> the margins must be scaled so that the threshold value is proportional to
> the length of the actual watchdog interval. The solution in the patch
> utilizes left-shifting to approximate the division by
> WATCHDOG_INTERVAL * NSEC_PER_SEC / HZ, which leads to slighly narrower
> margins and a slightly lower threshold for longer watchdog intervals.
> 
> Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
> Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
> ---
>  kernel/time/clocksource.c | 60 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 53 insertions(+), 7 deletions(-)
[...]

