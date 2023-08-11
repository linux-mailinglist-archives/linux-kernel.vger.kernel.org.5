Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7F6778A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjHKJse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjHKJsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:48:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BFF2728
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691747311; x=1723283311;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9jmQHuZ0IZ4crYe4JSbcmKckaS0bivFDBQqQ43HcbG4=;
  b=KaCqvJry98Yt7+FIAgp8NuYz1/OEsLqPRUsCWfE9+nd+oaEoxlT0+2aA
   zf4jkbACqlskU4R/5wfKgxHlXkjfIvB6rsyIZSOhPwJmRobXPf1aDKU6K
   EGbZIBr7dYHztaMjMnkoZOSAH1rWXSB4/6e0MlHH70K7QDx/Gt6GIjB3D
   0sVVaKhWvuvLqKvkgr4vt36uLxwN3lchdSjEIELZZnwgiReckjcqUC7NE
   5isLCpLwY9FFw13PQUY/HxcBJyu1RtaEFv6SeGUBQli9WH7mo1eiEE5Es
   GhCLT0t+pn/mQLQDm41K1bhSzs/x3Y1ymVknltWdX/bdbsq3oXfbFFXoz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="435536394"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="435536394"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:48:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="876099284"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 11 Aug 2023 02:48:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 02:48:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 02:48:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 02:48:29 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 02:48:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzKW98YFqdES2MTXby5bd2Dei6fhYVgowUVa+HXr0tT4f9Zzboe9Euk5kaUu1xaqiOrKSgmYaijRjGkZJr8uAs/jo/DNnWzr3qBTwvEEwpQ8ejzu7cJKDK2tCaGddKC2qNj6U2Dre0Kj3zmjhLAzum3PRLYXHmE4xcu6A38gP2h1Y+cEng2evEsnhPIuu/VToUVdWESyeVDHz9ozsBubM++4KAGq91le9PXfbfsUJJOqf7hOX2+GkhE0p763A3haJ67juwG2NI73tha8byIvs7yPOr4tqq5UzzxiMux4FDA/whCBfl23N9Hsfkso0EpIYpVmbqpwF2d4AX8s5pX+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EN9YjFJS05gkvUfOcL5ftYt5mwDm2rmE9temEm99Xlw=;
 b=MzcYmFfAY3XrD22CRjEceel8gPBurKJRAlGPefkgf5tutzbzUXsXP9/dk24LeyTkPUZTMEJQ9qZVcEaEL9uHHAVkIK04wYIwHF9qm+wKG9BujDQuldf3KJnMhKXLXDwIJF6x6iEIaHsTernw3blb+WFd0vsNJO7vKr07eWJI33F3LyOiX/Ej8pvN5zjEwAfUueasKWxrrXTkIk3UYTEnX7/m+/QRhemeKcSfZ4rNC6E3q/ry9dGrFOMwHmRij8ccAj0kdPbuwfz0FZnXlZVJruh4PwSIdwKMOAPUnCT/dTdvmwZQDYHRJoL+1ujXuXIl1ya1qWC3Rxjrvv98DShaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CY5PR11MB6091.namprd11.prod.outlook.com (2603:10b6:930:2d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 09:48:22 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::a551:9922:da09:ba24]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::a551:9922:da09:ba24%3]) with mapi id 15.20.6652.026; Fri, 11 Aug 2023
 09:48:22 +0000
Date:   Fri, 11 Aug 2023 17:48:06 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>, <yury.norov@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <rppt@kernel.org>
Subject: Re: [RFC PATCH 2/4] sched/fair: Make tg->load_avg per node
Message-ID: <20230811094806.GB399195@ziqianlu-dell>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-3-aaron.lu@intel.com>
 <20230719115358.GB3529734@hirez.programming.kicks-ass.net>
 <20230719134500.GB91858@ziqianlu-dell>
 <20230802112836.GA212435@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230802112836.GA212435@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: KL1PR0401CA0030.apcprd04.prod.outlook.com
 (2603:1096:820:e::17) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CY5PR11MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d9fae7-201a-4db4-5d7f-08db9a501983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jamFB/lBoBJIxlyVbC2Ri/vxloolARz3z6Yfafd5xuJ/C/ZaTVo9wPBWXLrCpZPxefnAbGzS7b8XMTFB+0YdK3kKXjWKpDXISKt8PJ2R2ZIr2pXQO3QTMmRkOx4CD6Qg19Z1IyOHsF/wjb6l9j/h2I/5uPcFjRPLa/BDkWclpd/sTHd/IqPTjfFlgJZP9LUNUxu/HxMXmRfnLAp0DaIGLjPqIVb5VCindGlN51BnC2iHGPPEZSIrKNT2+Htp3A/jc8Kna9dR7iE+BGWlFzAc8hP75CanZfAbVuvDrumAGh4yJngca5XBXEGrLltzIZwOQble8X5/7+XX2MC6aA173KUDFuL5V1c9DyukTtKJq1vJXPXaQBzpYFRU8XI9r1mnNRKkYpaQxqGHGD6g5bmdDkAV/lnCFs4OlX6bv8y6xt7WAz5hKtxDq1RRim9UwdO2QuaXKWGRCqeyfSfk8fl5ccLVTvC94OnE4S6M8VvZckjNvGVoVwyWdb/Qi7r78giv/gKAAw5ho8ueVjjlFRlQzmq+/V8wwdCN2j9mMemQDIqkrPbUalmKPPevcITBQE+VO3GnYg6DsDl5TdOhUT1Aaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(186006)(1800799006)(86362001)(2906002)(26005)(6506007)(1076003)(33716001)(83380400001)(33656002)(6916009)(4326008)(316002)(478600001)(66476007)(66556008)(66946007)(8936002)(8676002)(41300700001)(6486002)(6666004)(9686003)(6512007)(966005)(54906003)(38100700002)(82960400001)(44832011)(7416002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nicgaEcA3qGg8Wmn46VDyrpMh++y1Mnf1kxswboLaBrr8tPNanmMdxVrs61c?=
 =?us-ascii?Q?CSZFwZk6Us2O9RJ9mS2LKXyDAtEBVaOyLQaa7ZxFK91iOu7avW+0PqgOmouH?=
 =?us-ascii?Q?4D8xQHZgj3JYwWGSSbjw3QbEUGNf1MfjDr7KHxiCU/q3+10t3fc6Wd+sB+eg?=
 =?us-ascii?Q?ZMadqe1x/x/Hl8CvtS9O9h08MFtNrLJkOYoWOqNU+qpE49zIgLpc35OHfywF?=
 =?us-ascii?Q?IRtS0iZ+YL/CO3b+ShbjsPbm/QLn1ihUyKOH8sOoz17AUbeewoRqia5KF5iZ?=
 =?us-ascii?Q?PK6EB78fjWvUhr/lfEfmXle342Xld3VTXeo2colm8f8RGG3ccqK7jL+ZCAtg?=
 =?us-ascii?Q?ZR3BN2pscvrDv/L3/70WFMcL24j0llQRLhbY2771nF04Ol6Mvp7pmKyUIjEU?=
 =?us-ascii?Q?HGGamtlCCdTVr8bhEcVu1/Cfeqk4ZhO/e1/r6D10bvyR0HSKmhl3V72iBRke?=
 =?us-ascii?Q?mZT0A1MRwdI+ibHpJ3ebkqtzTQWC0MbnUbkWm8Gz84d2nZzrHPRoupwRrZWV?=
 =?us-ascii?Q?tjpUdPjSYUUNXy5UxBru42YpOaTIRAj+4SJ9EAxBKcMqvtAIso+RmONTGR85?=
 =?us-ascii?Q?WJ2WyAs+3bqvcXkabedKiAV+/JAqs/qplc+KNFtRUiyOHHZBb/lKPVyA3x9q?=
 =?us-ascii?Q?2y+PD/r1hOf4W+aTjSsoplADtW74wF78xh40De3X8qzIJoNDz3e9CmVD5Uib?=
 =?us-ascii?Q?1Yt0jI7JRzIgPaYVlOQcFugxRvYdMm9D3vhYYHUUjyyLefdERrPvs67qua+k?=
 =?us-ascii?Q?YpJ9c5GHVK7N+lWtjmDx/Q2qxUBqh/TEvpGRUiJi+oAXkGlw2dq1JCPidn6l?=
 =?us-ascii?Q?jG3UwuZXikD70x6weLDiNY0I11dpb/vb0qTRe9Bb1roMwRH5KDZDcimDjTtO?=
 =?us-ascii?Q?W3uKhXEdIoudrDQ3ruvyjACIyY0Xebwusd4vFou2oR8pkfMzTB6NWV3nvF0P?=
 =?us-ascii?Q?ouMEau3EK5DVgYzL2Xdv0KgMUf6Y3pgCYb9wrSVYR/WY4ZY+wO6qwEnkqa+F?=
 =?us-ascii?Q?ul4Y4GuLpC5ACw9ZKiTD1fVqkQulaZTdmcLhp58jl7z0tW3vlPt9Cr3jiBLY?=
 =?us-ascii?Q?C9jm5zg7XD81oBtD/8ggrLNq8IOWIWUbtbApEwamZ4c6kQVH/f5ofIEPtngw?=
 =?us-ascii?Q?b/PIkV+I+Em3ihZcUh+F7T9nsXqUqzO2BC31eR5kk1hkIQkFW/FAuMBFvbQ7?=
 =?us-ascii?Q?KaGwl4Mqw5a199y/d0gt8UuqPpnUWkkVKgpPkpffxcBabgPF0TvTdT/0kCJB?=
 =?us-ascii?Q?jNkm2PpDjpnbM3khI5guwUdRSr5OEL/6VIMv/mZzoHIW80ONh0yg7Q51RfUE?=
 =?us-ascii?Q?mXbBsugsE6xmKB1Htj7aFZ4wk2+G9vEQkx2cI/U5y85Jtn+INJI3lFBOvMYh?=
 =?us-ascii?Q?Gtl/GZl5WjezU48mWfIL1+rd+osLcfJrjnuWs8SPwvR3WlZTj0kY6NE7SrSV?=
 =?us-ascii?Q?yA0rWuZvHRrkcXoBYY0EX+oFA80LsKZdB/q9dnwhE6DGjYMNfDXkrHdJFb9L?=
 =?us-ascii?Q?Q12AKyHB8OTNQTaTK58VR02GWI7qv4fzbB+yPB8BfbVv1D9M6+QveEG2HHv9?=
 =?us-ascii?Q?yQxpPsc6pOX2LHdMQDbzARnoTwJNmQ5e87VHN0Qq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d9fae7-201a-4db4-5d7f-08db9a501983
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 09:48:22.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAl3J9Vu6MSFLaPkM/kNQlPEB8g2yMhg55rLft45IJvAUV1gEgeJgvYjnx1MIBLWdENgZvKDcs98sukiwqwOIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6091
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 01:28:36PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 19, 2023 at 09:45:00PM +0800, Aaron Lu wrote:
> > On Wed, Jul 19, 2023 at 01:53:58PM +0200, Peter Zijlstra wrote:
> > > On Tue, Jul 18, 2023 at 09:41:18PM +0800, Aaron Lu wrote:
> > > > +#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_SMP)
> > > > +static inline long tg_load_avg(struct task_group *tg)
> > > > +{
> > > > +	long load_avg = 0;
> > > > +	int i;
> > > > +
> > > > +	/*
> > > > +	 * The only path that can give us a root_task_group
> > > > +	 * here is from print_cfs_rq() thus unlikely.
> > > > +	 */
> > > > +	if (unlikely(tg == &root_task_group))
> > > > +		return 0;
> > > > +
> > > > +	for_each_node(i)
> > > > +		load_avg += atomic_long_read(&tg->node_info[i]->load_avg);
> > > > +
> > > > +	return load_avg;
> > > > +}
> > > > +#endif
> > > 
> > > So I was working on something else numa and noticed that for_each_node()
> > > (and most of the nodemask stuff) is quite moronic, afaict we should do
> > > something like the below.
> > > 
> > > I now see Mike added the nr_node_ids thing fairly recent, but given
> > > distros have NODES_SHIFT=10 and actual machines typically only have <=4
> > > nodes, this would save a factor of 256 scanning.
> 
> More complete nodemask patch here:
> 
>   https://lkml.kernel.org/r/20230802112458.230221601%40infradead.org

Thanks for the update.

I incorperated this numa change and collected some data and found that
with the newly proposed approach to rate limit updates to tg->load_avg
to at most once per ms, the cost of accessing tg->load_avg is dropped
so much that adding other optimizations doesn't make much difference.

So I was thinking maybe I just need that one ratelimit patch to reduce
the cost of accessing tg->load_avg. The detailed data is here:
https://lore.kernel.org/lkml/20230811092811.GA399195@ziqianlu-dell/
