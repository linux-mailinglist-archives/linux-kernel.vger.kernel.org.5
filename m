Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE52A78DE63
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbjH3TCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245544AbjH3PbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:31:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AD5FB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693409467; x=1724945467;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L6L0TnXsX9B58BTFRnp/LUwaedi75W2ub3RGnkonR/c=;
  b=kzATTofuiCes3qHx6c+otMqX4bykERYy2MZ9z8k4APvXOWvuJpc8nBvH
   DSpKY8XzJEOaWSwT2Z2jt2X+rZ9rYqbUhLV/EMCiGF7Ljhf/0zm/m1nRC
   uKXeyjusC75f9XFjVDIyyLWJFBSa3BUrGUEURQIu/EnXHpI15pZcBHuWW
   YTqFU0Lptzs4yttir5JoOL5gyHU1dOFHgUmiDzNV2E836pXpOWrkqt6D3
   b6KkHUVnbwxtzGkKA9MmZwGKnNyZO2IKcR/Q8tBxA2OkjD8VdkIi65RAl
   IzFZNFPC83QjHMDCWhUBvaVPULXwJbVELrpXZ5mc21oSOl0VQQLUeSTb4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="375629111"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="375629111"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 08:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="853770163"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="853770163"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 30 Aug 2023 08:31:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 08:31:06 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 08:31:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 08:31:06 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 08:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/mhafMAO9re7fsovXgw+k6M/98eiFrrBs0Hp4tQBDpejKmRBe2/cXyQI1aRQ7IFd/pp2FPUrRcgN6nPwWvSZ11qdbKMYfVj81Pf6Xu0pP9cfqkk+9UyBYVxNWP7U1QWLZcaEfxFVUUDq5uJimTeOQ7+F+EWKkxtrGo1ax483TUOdYnLpfVYusyPfiK/CjcKzHpEnX004+Ih0nbtGclZUZo6AiBdjrZjiZ6B6Hvg4roj8/E1lFX4BVl/QTW7HCPyMJUNa/WuWSShb3hb+7EBdPOnCxo7gAfqTtCDcTRvyWD7GUcxP+jtvcWITNGAxkNeDqMoF/CE5Wc9mVSpbD2qGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/eleRyZO483UMOJh0aVumIbXmyRMbhb9JDP6OJeI3I=;
 b=GCivYdm085dOlCtTL18Xer0Emzyo9FzUxjDz1x3twxvmfi+4ccTEX28N3G5VB5uyy1a2bfmNWOaj4DpoYh0TGw6Kt7Wa8dCQO7eIWRB8fg0PuVK0kz3Ea6qzWPV+9gC8ohfCq5eGxIkkCPChuL+zycpRN4HMxfkndW2QTfKQ7UT8SxGUDvUnUHcQaRK2aHgkM5V3jNUH3hd7TOOz+VbcIknEnpLAV6xwUq7rzrrpddhx6z6QA4spYkNDhCEySSLbRA7/LcdXdVIAsM1tul01tnDRSTAx0iy6hmGb5PzUpLNEJ4GDbue/irktnQM4VPsv/ECQMK2uKxA1Qxn+V6p3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by LV2PR11MB5975.namprd11.prod.outlook.com (2603:10b6:408:17d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 15:31:03 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 15:31:03 +0000
Date:   Wed, 30 Aug 2023 23:30:47 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
CC:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        "Tim Chen" <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>, <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 4/7] sched/fair: Calculate the scan depth for idle
 balance based on system utilization
Message-ID: <ZO9gp3ZVjIOuOJB9@chenyu5-mobl2>
References: <cover.1690273854.git.yu.c.chen@intel.com>
 <61e6fce60ca738215b6e5ad9033fb692c3a8fbb1.1690273854.git.yu.c.chen@intel.com>
 <932734b0-0a0c-c906-5e0a-a560a9d93ebc@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <932734b0-0a0c-c906-5e0a-a560a9d93ebc@linux.vnet.ibm.com>
X-ClientProxiedBy: KL1PR01CA0128.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::20) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|LV2PR11MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: a0100e49-ab57-42b1-1293-08dba96e1ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFPNEiHpWlU0SyjhOSHkm4s+KBGQLVR53cD7iNfLX1mAvPpAnwDN4jzUmO97FgoBheppNVWTDQ9njmbidikk03phZLv+Uuv96lorXqtKD+AeFySDr2UbVt/xHLrR1N5/nd75mLAk1cwb/A+K3TGe7rKbCzGJyjiNEIQbGd20cqHe/58im5Yq2/paGfXJygx34cFYSbmLn9M8Kugv6Jth9IZOo926xiNob38YIHUwBzsbY3+azOGsY525dM5qQ3ddf00e+FRe9b4dEyQ9CdoclT3tYLv7Orj+lh3/VbZCVicLssxudZy+5fFOEylgMf2W1lW9odDumwzABk5Ei0kf8iFv9vOR34bFoXxC0GXQRbJLrqaHwAdSfKn8Bz0HoXnEl3DzhxOHyNtw0lv08Y7fBHV5NcPJYJBJ6LV/KK0RcAwGVCV2wYmfHtaXnHKqUGQyAcfc6gO25tq2E24I5yrMuzHrED4w0O6LlEfzq1XzW7pJZ8XkNugiiUS2MtlV8vAvPQP/U5hyDctpIrUa37G1iAo7iQ8PLReACxRKeCcUq7BFchPwejmiZIN4hlvgNeCC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199024)(1800799009)(186009)(33716001)(83380400001)(86362001)(41300700001)(5660300002)(4326008)(53546011)(8676002)(8936002)(6506007)(26005)(6666004)(6486002)(6512007)(9686003)(7416002)(478600001)(2906002)(38100700002)(66556008)(6916009)(54906003)(66476007)(66946007)(82960400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qdph7hbtKwQW0Jif66LB/CU9Z9dqTY6qZUshQNFr2vdIbhYUmtzQLSS5MWHT?=
 =?us-ascii?Q?BFz8TDF5kJYcLRAoPa2bILgkHRCNLWxWCW3RQ8Ng7ypRvH9cqMk4PmGKWH57?=
 =?us-ascii?Q?9aAH9bMW2by8WLJEca55rfdLID5dykURvSZziEV0CPRxlmtDYIO6kFfDvKvd?=
 =?us-ascii?Q?o7/8Oq52nI7EoWziUw/piH2MO+98W0QFSCGmY5V6wMpJ3JCS0FM6xLcU3kfY?=
 =?us-ascii?Q?R0jeNW+2E+nikala0aV0dVvPPx9ITYxiur4cO1IDz1PsqnuTs7Nwmf+KoWoZ?=
 =?us-ascii?Q?dW5fdrooX0PG82uRFD4tnG5MfCZ6gIGh68ZzTcrY5kuy2e7/DQu9zELOvSix?=
 =?us-ascii?Q?noovM6tbafYlgtDCu8BgbFnqDhA9MVk+pZ+WvQsLBqiix6ZKI1DYoT4Vpnve?=
 =?us-ascii?Q?ZVs/C1Ksr65wEtvmA9GTgIVqErn+kf1Xdl072R9XM+0bDSAGOcvEvb5xNrgi?=
 =?us-ascii?Q?Va6wk2iVUdaydWyAm1WhdzTOMsOsxfiaghw+hKcrilrdYzTZM5CfN7IYOFx9?=
 =?us-ascii?Q?rDAoMVznymWu9jfx/mOPRCHUzn6oVTZk3GooU7DFaozrb5Kks54kVywX8Skv?=
 =?us-ascii?Q?QjbeVMpeD+DidSx5dvzh8TExGRTTXCBx96MXSeAWMRKHd1J5uBWDoLxCpV7D?=
 =?us-ascii?Q?XKCSVB2EO45p6P7uf8Vdvsi/UIJuKXj6sIJI7pksGYDjS1sKY2uFfFnt8J4h?=
 =?us-ascii?Q?madxobbqEJDSTsGcPIeT6os1Iqo2Bn8LUhVcHv4592L/FfrkkD91BMEjbFeT?=
 =?us-ascii?Q?Ep7AyRVG/WICIet95lRpzTJSeNs+njpYCNtk4L3NyS/0oUIBSwjBnmhMhN0P?=
 =?us-ascii?Q?SwLC1XTnTvN09gxgbz1O8O5AwbNue4FBpE6TMWMIdW0v6A3qeJTc9W7qYrPz?=
 =?us-ascii?Q?BNJ2Gyb/Iafs9/ozUSmH0mY3MawaJ/VU1PIWpVDugf9+A8anvsAQ2n1V3ta7?=
 =?us-ascii?Q?pUYIrV11ln/8B0++nkigTUXa059E8Rb/miqh6yqfUCMSESP3vW3nmAJcpQQW?=
 =?us-ascii?Q?k75OxrX8Bmd69L2ePuC60GL+TD54Vnh74iDpwb9WRTa5cz+qCUUcJkOA3Y+E?=
 =?us-ascii?Q?+JwAOTHV3v2zwnES3vI6gtcvLfBrg76LZWv0fzYEYzJNKsRU2zxCD7aSBQzz?=
 =?us-ascii?Q?hvqIrXXR9BlxaxVoj8oZlrQPKJvIEQFutzTyPY/MxYowF+O/9uzzRTTX+rjW?=
 =?us-ascii?Q?G1JsqmoLpRGwxziSqnoQpC70TLSyYwD8FGgwRKAQFxva0sfkXr/cIIDanY6/?=
 =?us-ascii?Q?JwUUqEimFP8hZ9lqvNmWFMe7FPCkgw74/dRIDI/GKI+mde2prhg+RvED6+HB?=
 =?us-ascii?Q?768dpiWxHGcHDK0yD3C1G1MQrwTOGlGNlpQdv8VR+5GZ3c9luKJKSiJKgIvk?=
 =?us-ascii?Q?6Nw2cLwpPdWJw4VTKfeWOFw3GIqif+Xp2mUmYvWDPvobZxWDLOPTmyB7X83e?=
 =?us-ascii?Q?XhqDx32er265rQIlpXfraeIVjeQDP8wJsRftt5Pzi+be4ONDh6JSirR5y3oV?=
 =?us-ascii?Q?WK/Um0/GClEHwI0UF0evKSKDDxdHS9hjgnhaygsikHSM3WUtREQEjeejNjyA?=
 =?us-ascii?Q?ff9OgKnESr3bdwkLM1NGjZHVwW4QsC1tkjFoDL30?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0100e49-ab57-42b1-1293-08dba96e1ee4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:31:03.4707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVNOnH1Eu0uBoAHwMlAeXKfzuahukKlnRAi4GCuq1NigzUxJFYAI+aG9NN6TIcUAJ6GXVUKY4Lc+ZFsyhJw/Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5975
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-25 at 11:32:01 +0530, Shrikanth Hegde wrote:
> 
> 
> On 7/27/23 8:05 PM, Chen Yu wrote:
> > When the CPU is about to enter idle, it invokes newidle_balance()
> > to pull some tasks from other runqueues. Although there is per
> > domain max_newidle_lb_cost to throttle the newidle_balance(), it
> > would be good to further limit the scan based on overall system
> > utilization. The reason is that there is no limitation for
> > newidle_balance() to launch this balance simultaneously on
> > multiple CPUs. Since each newidle_balance() has to traverse all
> > the groups to calculate the statistics one by one, this total
> > time cost on newidle_balance() could be O(n^2). n is the number
> > of groups. This issue is more severe if there are many groups
> > within 1 domain, for example, a system with a large number of
> > Cores in a LLC domain. This is not good for performance or
> > power saving.
> > 
> > sqlite has spent quite some time on newidle balance() on Intel
> > Sapphire Rapids, which has 2 x 56C/112T = 224 CPUs:
> > 6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
> > 5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats
> > 
> > Based on this observation, limit the scan depth of newidle_balance()
> > by considering the utilization of the sched domain. Let the number of
> > scanned groups be a linear function of the utilization ratio:
> > 
> > nr_groups_to_scan = nr_groups * (1 - util_ratio)
> > 
> > Suggested-by: Tim Chen <tim.c.chen@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  include/linux/sched/topology.h |  1 +
> >  kernel/sched/fair.c            | 30 ++++++++++++++++++++++++++++++
> >  kernel/sched/features.h        |  1 +
> >  3 files changed, 32 insertions(+)
> > 
> > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > index d6a64a2c92aa..af2261308529 100644
> > --- a/include/linux/sched/topology.h
> > +++ b/include/linux/sched/topology.h
> > @@ -84,6 +84,7 @@ struct sched_domain_shared {
> >  	int		nr_idle_scan;
> >  	unsigned long	total_load;
> >  	unsigned long	total_capacity;
> > +	int		nr_sg_scan;
> >  };
> >  
> >  struct sched_domain {
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index edcfee9965cd..6925813db59b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10153,6 +10153,35 @@ static void ilb_save_stats(struct lb_env *env,
> >  		WRITE_ONCE(sd_share->total_capacity, sds->total_capacity);
> >  }
> >  
> > +static void update_ilb_group_scan(struct lb_env *env,
> > +				  unsigned long sum_util,
> > +				  struct sched_domain_shared *sd_share)
> > +{
> > +	u64 tmp, nr_scan;
> > +
> > +	if (!sched_feat(ILB_UTIL))
> > +		return;
> > +
> > +	if (!sd_share)
> > +		return;
> > +
> > +	if (env->idle == CPU_NEWLY_IDLE)
> > +		return;
> 
> 
> Suggestion for small improvement:
> 
> First if condition here could be check for newidle. As it often very often we could save a few cycles of checking
> sched feature.
>

Yes, this makes sense, I'll change it.

thanks,
Chenyu 
