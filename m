Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C27678DFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245599AbjH3TW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245559AbjH3Pfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:35:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30321113
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693409729; x=1724945729;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nbUXX8F6OkGTH476SAhLtF/DcaPAgHaDacDomHAXd20=;
  b=hvndHaA4EuNAK9bZ5K+Vb3AXtAGDvc9u8w+4a8CVIbYuvF4sqj3cQP8k
   52nDNb83Ts9e2TkDnzoGwhml67/zhqObc4QW38U0EjRqICFB+8E6afWZC
   RkASwJNL8VyH+qVJQLiaBTia2YB6pxK+X/2wm0Ub4f+yDp1YVOSC+3ivb
   YSx2CbTYI5jwf6CbOmDQvOuptp0c61p7pfoZXD9XXLmpzuti9U5Yu+lo8
   QdbSOsplHoVF0o1LlqGvhzts2EEbOLIuqO3+6cpAKY15jq/J9/e6q2xTN
   1GDzRSyhWV2KehH7pGeWRmeAYAPTBOTqxHU/a+nx1STxtrh26KHKdx1yt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374594658"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="374594658"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 08:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="688954945"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="688954945"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2023 08:35:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 08:35:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 08:35:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 08:35:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 08:35:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvCyrHMnEZq8gWw3WoMx9CXBuPxM6iU9dAgVbLLi5Vlv6YXBXfPmbGfqO/rj8iFVU6JIBUnyda4IS5Znv5plr2AeKNpO+n5Rgv4pP/ULQd9u1mfmayjYnbdp48HMakPkLoh17I8O8LUqo6eTqx+Q2bhEZmtidSSr8F7eCilyV8JdbWqZI9qbRcE62rFE1q6u29GVFL14SAdqqjkQ533WphMScHKlJpEBaQp4y7MAuQDTvTxE0L3XiiwFlxw2UpA31KVh4dmPtEovkVCijPnvbp3EFZrlCLVZxBbucGqX/cPU+hkkK0Bd4upMiznFQZIqNlo1y2d2/JKnmseCwyXVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vY56X4HFXyB0byUwZz3EQe4LvLkaQCygTYGy/qFj9as=;
 b=ogPNKtU1FS8SNB+Ju8573J2mftvkMbjDLTENCSYTdGxpsOh8d/IT1K2ogPq/evKGvitfzQUiuEzrUjiXTxEUj9rLdoV/E3JU89sOh4i8kJti8RazBt5Rst+4o4HoagBQp2TqiEmdDneLpmHL01YATYkmDfS1gbmUgxvvj3qtPTwHAGIpUtG5issacSH+KrTgfM3YKMp5VGBYuyXDr51tSWspKMTWfF6WA4AFRkF6N5v9vJ1ouTIU6kYqutynQeg5vEgo7/6FtF5o+2wPB0xq9hKEXMCXzokVD7u0ljWRqY5thsv5XwNN8KU19j9tnjMmAOqxElAH5Zn9zUBCtcPGxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB4959.namprd11.prod.outlook.com (2603:10b6:a03:2de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 15:35:24 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 15:35:24 +0000
Date:   Wed, 30 Aug 2023 23:35:09 +0800
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
Subject: Re: [RFC PATCH 5/7] sched/fair: Adjust the busiest group scanning
 depth in idle load balance
Message-ID: <ZO9hrc2KDUOfbQm1@chenyu5-mobl2>
References: <cover.1690273854.git.yu.c.chen@intel.com>
 <98e26a26832669b4293a50a701f9b3b8d44e4863.1690273854.git.yu.c.chen@intel.com>
 <cca85edb-0c16-05d1-a734-5148054ba7a7@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cca85edb-0c16-05d1-a734-5148054ba7a7@linux.vnet.ibm.com>
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: 35459fda-84f0-4d97-e911-08dba96eba4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y71z45tIJZb6g6+OTvdjzdxHOZyV0gukmwx/71rg/xM45e55P+GhadjYf/u6W+vOQ0XUGCXXMxyEU70eUqVLLwvLewUfFTevofHI/NTqDFo7q3Xu7YAsaaIeSnsghrfcODeGeFq9go3oP1OZo/Ag8Pv5iwjvU7lSPy7aB/gjBVuc18E99KK1gNeM9ISyBQ4T/1CbzJZZHzeyLanwHJQYG04PYhV91P+GFtQ5Oq1zbbv1JXbgymsWp3ibGSgGkSF0lpxTyvfo20Dos2vJULnEZH7QJxx9mYZ2tDA2c5lso3unzAT8tCSFFYoo3WmPnU3mdVosgdmvS7fryeN8EczOJt+soWUWi6fi+BWxn+5XOUoDmYi36+pmT9uV4MV52NIUSW92gHYLNVfGNbGicY/jcp2SFp/0Ps1CuoawKVyiqWkfgP+EyH/08nGxcNvvsBSXJX9P4eGcoQD9WOqCZ+tnM3d+9iiMBfNSRGsLy5rL41JTzz5RolvwS9nJ41VPdkmndvSFBEApzN+fYcSGdtUJoW/u6TnsLeJO8C54AYLwdy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199024)(186009)(1800799009)(6666004)(53546011)(6506007)(6486002)(9686003)(6512007)(38100700002)(7416002)(5660300002)(82960400001)(54906003)(2906002)(8936002)(6916009)(8676002)(4326008)(86362001)(66476007)(41300700001)(33716001)(66556008)(316002)(66946007)(478600001)(83380400001)(966005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?66tRzS+C0c0STazZppxJ7iw+EAlN+p8Lg4HWG8SzaJ97hSwEm1riMM26CXS6?=
 =?us-ascii?Q?vZQDKU/WJvpH3JF6aMuNGR7ynyXtIra9I/bNgNWtbx6dQvhaQcKmgdAe8ItJ?=
 =?us-ascii?Q?gi6DfvTbKddH7dZIw5RMKKebNBwkT/J6Q7bbcnrLpRp7A7iEIEfwKB3xN0I0?=
 =?us-ascii?Q?5zNXMaI5Fxq/ukmjtfIvahQIN53eMenjAQWcGRnDlkCQZc8hfxLKNpIGZWPB?=
 =?us-ascii?Q?7XlDwBCkJic7A8DGxF9PMJjJXYNZVASezRU/a5KeV8sj7IZAHFwCko4h6ssT?=
 =?us-ascii?Q?eZc2OqnKNM3NolIlPeRKKyll9D7ROwOCniJNSmaNdZcEANFvKkLJsESuAxA+?=
 =?us-ascii?Q?WQwfg43MuqA3cwvE0+vA8emIS0XBU8rFMOFuyuD1O22TjDPnahv7k0Eas9o4?=
 =?us-ascii?Q?8UgzYntUNgKjD8vlPVSrcMT3ICFiZ3ggmr+8NWE2m7dad0xig7rinuf/+5DY?=
 =?us-ascii?Q?goVCKJnNwqMgoWbul1ovvxvkn5bid1bwEEfc3UIky7K9s9LM9Wmapa734tF7?=
 =?us-ascii?Q?9IUZv482nS0J0fV6C9kwZ+AVJ0OPOLnSnc2WP8uYXwyYazLeCm/ZWYi8ezdc?=
 =?us-ascii?Q?76+MCTcR7wJanRm1wVc7D0uNNBIpQAfTOtO7xDo1ALGUcTzUZOCz8qlz9PyU?=
 =?us-ascii?Q?Y3AO9dQ2UfMCAw/y65YBgh6hy+uKYakuYhBr37Vmk7AgvbEokdwjwy1m/rn2?=
 =?us-ascii?Q?txUkPRMYtv4uG+T4IXDW9Cgfp/8tjdXHejV7q+fMvqIrMT1BEc3zWvVYUBu7?=
 =?us-ascii?Q?a55zb9Qt1WjpS+jbFP+hVeuhihWz12A1GC97cbYcVIToji5RrATSiF/Y7rpB?=
 =?us-ascii?Q?5p3Lg4daAY8NrT3bMcBnZLUyfrTsOF0kVOP9YQi3hKW/3dTq6g3VFTWr+oAn?=
 =?us-ascii?Q?YMvRM2jpQ6Z9NqY8Krfpaly/mSwTmyQ6bn0xRQZqnheYBKH0QWkebCkk5jpV?=
 =?us-ascii?Q?+dvT22M6zfRfYwOklm/icpJbpSRcNN1bH6SUTBl7/V50qhJW06rzOio0500O?=
 =?us-ascii?Q?bfYZTRmwx52Sby2S/loodzZCqgnNcgrqc8zuGxiyN0o/UxCiKqXJZRrsnza1?=
 =?us-ascii?Q?6pI8WBSzWmY94xwk3qOA38cHJTp5AXBRafJUc2HAlH3yCLjBp4/2YQkiRxsC?=
 =?us-ascii?Q?VgIlTcmpKOLHRUv2/ojk5G0MDmE3SKlMJbcdyEuVw7JlTe9yeGOe/AlNDMSp?=
 =?us-ascii?Q?v7qYG/vcYKWfZAH3sJuWeyGkD1M5xF5SXwyDilo835yUWD/DqszPK9WElX12?=
 =?us-ascii?Q?16Vo5R0iKUP6fWNI6V9YXalNMu8Lrx1MW0L3Cdpnq5mDiimOcbIJyjLexibh?=
 =?us-ascii?Q?gXVI+V6ZuM6RlHeMhz5XdyvrT4wNlOOloXJwyNv2EvLDidyy2PBMNhblrZtp?=
 =?us-ascii?Q?Fd5OVT1ZKZOC+HeSroPj8CH8ENsva4OIwBEWUQUkN9f7+4L/lhccFlYLjkQb?=
 =?us-ascii?Q?AhHgJNK18h0U2M3/rRUTfM+PsGFx0zUvaM/SJwgw0ALPQ40onLpMurnZwNAO?=
 =?us-ascii?Q?onh1xcDR+M/ENTGjd/W8X/R3EGSXpboCHkdhjFqTgy8fbictQEVPr5/81yBQ?=
 =?us-ascii?Q?jA2LWp5SOdbsELJn+oI++T2N1P/eSwnlIo6ipkfk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35459fda-84f0-4d97-e911-08dba96eba4e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:35:24.2108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQED+ePw+gkMyHrjX8UPcCEFt0mI8n8RWpz1dKLdUlJekeAPyQcmpDBrdChIJ9rJXyUx+RDb8ReVcvKTsGLkow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4959
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-25 at 11:30:05 +0530, Shrikanth Hegde wrote:
> 
> 
> On 7/27/23 8:05 PM, Chen Yu wrote:
> > Scanning the whole sched domain to find the busiest group is time costly
> > during newidle_balance(). And if a CPU becomes idle, it would be good
> > if this idle CPU pulls some tasks from other CPUs as quickly as possible.
> > 
> > Limit the scan depth of newidle_balance() to only scan for a limited number
> > of sched groups to find a relatively busy group, and pull from it.
> > In summary, the more spare time there is in the domain, the more time
> > each newidle balance can spend on scanning for a busy group. Although
> > the newidle balance has per domain max_newidle_lb_cost to decide
> > whether to launch the balance or not, the ILB_UTIL provides a smaller
> > granularity to decide how many groups each newidle balance can scan.
> > 
> > The scanning depth is calculated by the previous periodic load balance
> > based on its overall utilization.
> > 
> > Tested on top of v6.5-rc2, Sapphire Rapids with 2 x 56C/112T = 224 CPUs.
> > With cpufreq governor set to performance, and C6 disabled.
> > 
> > Firstly, tested on a extreme synthetic test[1], which launches 224
> > process. Each process is a loop of nanosleep(1 us), which is supposed
> > to trigger newidle balance as much as possible:
> > 
> > i=1;while [ $i -le "224" ]; do ./nano_sleep 1000 & i=$(($i+1)); done;
> > 
> > NO_ILB_UTIL + ILB_SNAPSHOT:
> > 9.38%     0.45%  [kernel.kallsyms]   [k] newidle_balance
> > 6.84%     5.32%  [kernel.kallsyms]   [k] update_sd_lb_stats.constprop.0
> > 
> > ILB_UTIL + ILB_SNAPSHOT:
> > 3.35%     0.38%  [kernel.kallsyms]   [k] newidle_balance
> > 2.30%     1.81%  [kernel.kallsyms]   [k] update_sd_lb_stats.constprop.0
> > [...]
> 
> > Link: https://raw.githubusercontent.com/chen-yu-surf/tools/master/stress_nanosleep.c #1
> > Suggested-by: Tim Chen <tim.c.chen@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  kernel/sched/fair.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6925813db59b..4e360ed16e14 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10195,7 +10195,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  	struct sg_lb_stats *local = &sds->local_stat;
> >  	struct sg_lb_stats tmp_sgs;
> >  	unsigned long sum_util = 0;
> > -	int sg_status = 0;
> > +	int sg_status = 0, nr_sg_scan;
> > +	/* only newidle CPU can load the snapshot */
> > +	bool ilb_can_load = env->idle == CPU_NEWLY_IDLE &&
> > +			    sd_share && READ_ONCE(sd_share->total_capacity);
> > +
> > +	if (sched_feat(ILB_UTIL) && ilb_can_load)
> 
> Suggestion for small improvement:
> 
> it could be ? This could help save a few cycles of checking if the feature is enabled when its not newidle. 
> 
> 	if ( ilb_can_load && sched_feat(ILB_UTIL)) 
> 
> Same comments below in this patch as well in PATCH 6/7.
>

Yes this makes sense because the feature is enabled by default.
 
> > +		nr_sg_scan = sd_share->nr_sg_scan;
> >  
> >  	do {
> >  		struct sg_lb_stats *sgs = &tmp_sgs;
> > @@ -10222,6 +10228,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  			sds->busiest_stat = *sgs;
> >  		}
> >  
> > +		if (sched_feat(ILB_UTIL) && ilb_can_load && --nr_sg_scan <= 0)
> > +			goto load_snapshot;
> > +
> 
> Same comment as above.
> 

OK, will do.

thanks,
Chenyu
