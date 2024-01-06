Return-Path: <linux-kernel+bounces-18464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A52C825E05
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 04:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7161F246AF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 03:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D7B3FDD;
	Sat,  6 Jan 2024 03:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+jsNOdD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6213C07
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 03:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704510242; x=1736046242;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YVz3tmAuP/HCupeREmKAMM8rYEr96NxBoHle0xCGPxU=;
  b=e+jsNOdDB1cJapL6/VhG2nDy7CtR88KXn2fyIbVC7C3NBto8Rvh+ntEs
   z4fL5bPyk+zWZhLB7wNsTaqNWZbqs2Fr2ZdD1w70V9nmsvMRnSD/2s88Z
   +BFcJ3nhRdLDUUTAeiPnRKVuD1S/TG3fuZ6OYhoIKiFXsed7HXD5ZzZGw
   K16VIhesBYQB5EBacwE+CsTb2vbAPjkOCx0pJu/uodXwLB/gdkdZMmMCM
   VTuaOppHjOkcnM88LLNkHgae2qMfcOLXUKGNWxoEKDHhkh0G6MWpAfwnY
   +19ACupDreLWAJ8W490ISYBL0jxwnQb7boMtrWatAAR6g4wCc2kDrudCV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="4725567"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="4725567"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 19:04:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="1112255246"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="1112255246"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 19:04:01 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 19:04:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 19:04:00 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 19:04:00 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 19:04:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmVOWp99rxfKfjJPQ7nL5NQDrB51eYqEmXz20J5hpMoTTH1kQuGhM2kRNx/HggEiyDqC4/ASgBnX4iqRc7wXCNq8qhwg7PdZ9jXrCNSSMGZgSRljc9nB4iMpSEvEFji9gIJetFt1ZnXkgUs+4OJ0Byho3DTAc/URJNcs9enqz0ruOviQ04OszRpf4rri/Uv8Ny4LleLENqgfu9GPqC70vXas1qRjRCBhXf+wNwozckH4NM/xcM7BPa4t7mwXoIMLXJOnZYfuq++fRn89qSXd6p94s4E91I1QlJtwSEpKXpHIPoZt2/3cwt3PnCwFip4awTEyVq7MtU/ZDpwZzRCapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF3bjCET2AIwSkoN8hsnLJ50dixJ81X7Bk5MFC27Ycg=;
 b=BI1fn610n7qemoFXwPpX38I3rySrYnFoaaTGeVs2Pxul7l70aAO8v9PAevfRUScqFbBea5hq4oQb7uCAWxBIdEL5LgKPa6SKwMDoOnZDNvBJjEiQOqJw6RsGI9lFinvddkQdmiE2WeBp3KkK4pBpzMK4Uvt9Xr0Phh4eHcpWPYBO1mrsqC4pWTR1SYS0xRsUo83qLeN5XunOKhsq39ZMvg+lhdAklWtsuDsRTAV0UqAC0numUdJakAm/DIr5Chv2Ef061czcYvRGPYowOtRS+WOHTnVnQd7uBE7TqY046Jhtt3TbSZBuaIQMyqB0QqAGn9l3SRDdtCrG12k5yTD/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CY5PR11MB6236.namprd11.prod.outlook.com (2603:10b6:930:23::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Sat, 6 Jan
 2024 03:03:58 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a9f3:d5aa:7ec3:d3e3]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a9f3:d5aa:7ec3:d3e3%6]) with mapi id 15.20.7159.015; Sat, 6 Jan 2024
 03:03:58 +0000
Date: Sat, 6 Jan 2024 10:55:09 +0800
From: Feng Tang <feng.tang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: Jiri Wiesner <jwiesner@suse.de>, <linux-kernel@vger.kernel.org>, "John
 Stultz" <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Stephen
 Boyd" <sboyd@kernel.org>, <rui.zhang@intel.com>
Subject: Re: [PATCH] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <ZZjBDaW9tqSEicNM@feng-clx>
References: <20240103112113.GA6108@incl>
 <5b8fd9ba-1622-4ec7-b3cc-2db3a78122f1@paulmck-laptop>
 <20240104163050.GC3303@incl>
 <dd62437f-b7a2-4844-89f6-94a88a08f227@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dd62437f-b7a2-4844-89f6-94a88a08f227@paulmck-laptop>
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CY5PR11MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef25c8a-8f9d-432d-e44b-08dc0e64201f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Gie65ZF8hnF7OPuuGKeu6Ug4ZeKcTY/mSBf0IfXYV1eyCyPu2s9MRjfOmXNln99Cg9HiVYconVYR1nF5U7ErHf2QyRQUtIur7SyfHsZ8Cp4fwmKcYl5dn2FLUifryCMDxmaL8YCOmz/KsXuzJ/8w31oMi/CyEOjfNlcwl+/zPS5wM0JZnCwaiYrJvvOPiNuTH/7UGGlwXkoWIeBmxdUyt0LUhibEJ2huJ/SkLX2dZ5NulaX6vAkWM5llrJ+TxMJGtOAUrheIFvO2R04ECN1s/OaQ/6wxTgm5V7Wpbwlq7hXYC/0T2U4dQgOblwLW0zdGpHO9GR0+UurrV3r3yhAl5mmgefHh1eHn2hCmpQ3CJBVIufLmBUGvBRkA2oVR7/rGOkeKeWeFSKXPpCr/DVwrk5xdxvfG+tVjPmmJcVQzA8KWKSQIzdQHB+o06WQ5FBySoMx+PBxRhoMN7oW+9Y2EX9y5YzDMuxf89NFS+UJbaaG5m16VgxFiepq9X0QXVT47XDqg6TDw+6FMC/g95wU8Y2FHRSDyq1Ent5OAntSOgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6506007)(9686003)(4326008)(26005)(2906002)(107886003)(82960400001)(83380400001)(6916009)(33716001)(316002)(41300700001)(5660300002)(54906003)(8936002)(8676002)(966005)(38100700002)(44832011)(6666004)(478600001)(6486002)(66946007)(6512007)(66556008)(66476007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tCawsPb7nv8lpC2PFCWLO0JBs2tO+peLv8Ua6QClon2maaLEiDF6uyAoo+ta?=
 =?us-ascii?Q?TssQS4FVxjM1fRKsZyWDrl5Z6CIRvDAxCSDhYWM+tWFpsrZH3lP7pRuaQl5T?=
 =?us-ascii?Q?ct0sDECM579J6IV2vEq8YjMLD5V3P9s39sk/l7C6dDRfptl/uMn4n2gt5wDz?=
 =?us-ascii?Q?xhCc1xfJ+YJfLECWKJek8vtbw9xltem4eBjCf6QPKLL9LGLFcn8ZV6QuxU0R?=
 =?us-ascii?Q?Q4eoUV16uVLYXHKEGhdZfnUe+O/vGV0dzUWCazuELwecqG1ESozKUZZWCN0G?=
 =?us-ascii?Q?3xS4CzfMvltN8FUMJZcy2s1eseHSOdsoUpek5MBD2LYPkrSfXpd+WnFFLFgC?=
 =?us-ascii?Q?JnsLTBiXV810og91c0ZyMIYo6xma6v+Ff0tQ8PrgwBx0Hkp1rlOH3ENFbX1v?=
 =?us-ascii?Q?g5ZhDoH2jUqp0i390136UF4o3swypT1EmKx9Lw5nj3s8DWqpGtq5TOypzhxu?=
 =?us-ascii?Q?/Rf/jvFbvrpivKKwU+Zx/yjCMXbKMnk7RphFmqtnbrMwVFb0S9gTAosPjHvi?=
 =?us-ascii?Q?GefRhsVzakPUQXbnYeYuuySF69HsZLRPgg9CRkUZOLa48wXC0jGUf8rcqGoo?=
 =?us-ascii?Q?7uwYaJP6nqPwV6Q5K45qzzHkWKX/q5pN3OzfGOhQ9kcKDQbrxXZz8VigHwGc?=
 =?us-ascii?Q?45N7AK0g3fiYw6U136KOzVqbyoa5eVtztguWcSqfGHr+Vd7t+5WvMZeh5PKM?=
 =?us-ascii?Q?zo6bmsvvIHXv9cLFKf2XZkRRDdrmIA0+450ktwogc7Poe5CjQBhf3nZJBAbM?=
 =?us-ascii?Q?1pMrolPeHT79UZrlWpKAub95Tqx8v6xuHwGE/xA+aLvFML0Xl65J37CeP7HZ?=
 =?us-ascii?Q?r2O4lif4peYcksMScI0xtndwpVULPtf+ibHFRnTAhxvT6MdmsOrikMJCW0I+?=
 =?us-ascii?Q?mw0uLYXDezCkwzGH3j7zjaMfHBNz9Vgm4kg+Ca4ix+VtE48yil6yzKbM8+ic?=
 =?us-ascii?Q?qaNCuLFJ2t9X7pM2VsY3WQG7ViwKnJL3azSVrMfkbywvdjsju5KFdFhy4cTT?=
 =?us-ascii?Q?Qmf+z2m6q5eey+wxRxmU9m5eKlyWqLNpWWCgB30qvkV75aWwSooMwVtK5szq?=
 =?us-ascii?Q?SWXsrMJNBiw9zKEk8DnOMH2/nsDABdJHVtQu/7T8s/Zh36rSGvrC3cyFy85s?=
 =?us-ascii?Q?vehm5PWts50SaaCkAtWJve5KlzKXAqTE44iwyTDIiM7KI+ogxTBEYIHDaKj7?=
 =?us-ascii?Q?GHpUw7Fp8+b+MAtpX4MjU706lklSogPQh8TFvps1r3iTBJY4xBfLC+sCFut5?=
 =?us-ascii?Q?ZzuX/szAWONr6VAHAf63dEaNd27JrCpEb5cCaVqS4LH4E5sM8X1AKCVG/QpG?=
 =?us-ascii?Q?53ge507l/7g6EdjKJeNVMV/4Gt8xXvOK9EfdiuADgwvLKJbhIl9r1EmwYcq9?=
 =?us-ascii?Q?mB/lGqhSoOwo6IgpueD0Zz1HD7s4OxrxwG6PxPLUQza6RVDJs6ejmFGC0gaH?=
 =?us-ascii?Q?7gG8UBPcUPXW/nShfMZPDAFXxoA3XwKwxKZV3Vf6DYfT1SDlcQcBEeRKeezP?=
 =?us-ascii?Q?oLQ3o4Sv6nqb4CqV/POcazL05uvNPMRyv2VD5nFjKkL8+gG1WF3q4m0aSuRV?=
 =?us-ascii?Q?+mmSxpFTaPoBZ4GB5HJZrpzCkT54o3Oat5NBQ6+H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef25c8a-8f9d-432d-e44b-08dc0e64201f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 03:03:57.9598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbqVdwF4BkUH4hlyfit68O/54GqB7KgQGydQKBlvWScWEutqW6Ffv0kmV+KjQ2r4gWl+DtA2b381DvmBG6X4Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6236
X-OriginatorOrg: intel.com

On Thu, Jan 04, 2024 at 11:19:56AM -0800, Paul E. McKenney wrote:
> On Thu, Jan 04, 2024 at 05:30:50PM +0100, Jiri Wiesner wrote:
> > On Wed, Jan 03, 2024 at 02:08:08PM -0800, Paul E. McKenney wrote:
> > > I believe that there were concerns about a similar approach in the case
> > > where the jiffies counter is the clocksource
> > 
> > I ran a few simple tests on a 2 NUMA node Intel machine and found nothing 
> > so far. I tried booting with clocksource=jiffies and I changed the 
> > "nr_online_nodes <= 4" check in tsc_clocksource_as_watchdog() to enable 
> > the watchdog on my machine. I have a debugging module that monitors 
> > clocksource and watchdog reads in clocksource_watchdog() with kprobes. I 
> > see the cs/wd reads executed roughly every 0.5 second, as expected. When 
> > the machine is idle the average watchdog interval is 501.61 milliseconds 
> > (+-15.57 ms, with a minimum of 477.07 ms and a maximum of 517.93 ms). The 
> > result is similar when the CPUs of the machine are fully saturated with 
> > netperf processes. I also tried booting with clocksource=jiffies and 
> > tsc=watchdog. The watchdog interval was similar to the previous test.
> > 
> > AFAIK, the jiffies clocksource does get checked by the watchdog itself. 
> > And with that, I have run out of ideas.
> 
> If I recall correctly (ha!), the concern was that with the jiffies as
> clocksource, we would be using jiffies (via timers) to check jiffies
> (the clocksource), and that this could cause issues if the jiffies got
> behind, then suddenly updated while the clocksource watchdog was running.

Yes, we also met problem when 'jiffies' was used as clocksource/watchdog,
but don't know if it's the same problem you mentioned. Our problem
('jiffies' as watchdog marks clocksource TSC as unstable) only happens
in early boot phase with serial earlyprintk enabled, that the updating
of 'jiffies' relies on HW timer's periodic interrupt, but early printk
will disable interrupt during printing and cause some timer interrupts
lost, and hence big lagging in 'jiffies'. Rui once proposed a patch to
prevent 'jiffies' from being a watchdog due to it unreliability [1].

And I think skipping the watchdog check one time when detecting some
abnormal condition won't hurt the overall check much.

[1]. https://lore.kernel.org/lkml/bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com/

Thanks,
Feng

> Thoughts?
> 
> 							Thanx, Paul

