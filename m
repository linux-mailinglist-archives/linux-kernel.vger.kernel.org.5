Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD227DA79D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 16:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjJ1OxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 10:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1OxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 10:53:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BDCEB
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 07:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698504789; x=1730040789;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0fyi6fYc5TS10QxiBnxWseLgRU5mX8+DWnk+LlHa+fE=;
  b=fVsKQ0yYkVBTLOp8h1ZHT5t32tm8Cm1cwZkvQWi47yhrSTsf+tF2C8Ww
   SdCMtCSaqjNXlQ38Y1F/2Ar937lpD48+tSlIvihbeQYK/myeOCO3r1ZKs
   hnSyC4+vOFBPsKpfrj1zwnO4wS/jPNy/lt/u8Yjnp7dvLuVI1Vcsly3GS
   2WPII01nZxPqD80C7Ei6zQcxAMF36NjSqN8tvnqgDgu5UytGXwbsacpZ2
   KeqHVwt/8tdPXI3EgJvaryv8iFqfBOg0aZWug3Ir6hS0kzHqrATHH81g6
   9AbwROXetedZjZIcBXMEN54sqeYtcM44ScOzH+lDz1AN63pRzyp0yc0Se
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="385106972"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="385106972"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 07:53:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="7501017"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2023 07:51:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 28 Oct 2023 07:53:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 28 Oct 2023 07:53:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sat, 28 Oct 2023 07:53:07 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sat, 28 Oct 2023 07:53:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SR1l2lAzyNZiO62EOVPprz//booSVGknBvB+QQFeGBuTHtDIiTwG5e7YPcVMAaSgjtRvNJ2wuGKmb7oexni4EfZ5NS0dkjCCqheBEofAUe3eTcdz+eeoJPU5C3WiZ/VRydAZeVipIc3yryGWpLW5TlSRocXSwhXCK4soBVSuYrunHEE9r61fulyYtiycDcFlndI+0euvKeaVM4/+3GFSTpslNh1FBhkyrvJPero8ztcK8sz0qDwQTeNDvR8Arw9QjecFx5CR6utUMGB22FfX92H23JLr1Jv+b5bZlMffulb8XAGyjznL17nNW15SPi151ZiwvqM67CB/E9AoNvDUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSeRu+dIAdkU9x773bAqQmC5HOnjK564EEOPB5RC3PE=;
 b=QdFjTClqf/3SJzdyhEy2xbEgVnmAx/LQ1NsZHawXMLsAXd6E/caQu+khPyIUNM04dPlYhNFErlNAyK03RdNX8rlteHFkh/ybyYYZg2jOYbY6VnNXCPwH/tWRmWeB0dqmnpgOrx0OGfKZBPOtAheHQovSKWMT4m91Y8dzfCKIAuWSaOZk1HBUDHn5Q7qDLkWyImZDGSwn5VMEw1mAdhdS5bpwuhjBqVo6nyP415piMsB7Xs1t0L03HF3lJ0JTV88DlCw3Qbc6m67R6nOKhuW2wEIf/5wbWCLs8+wcH0RHBaC1xBJNohJoXeVXeUaKaAsdCez2u2cQUbmM9hjS+yudrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DS7PR11MB6062.namprd11.prod.outlook.com (2603:10b6:8:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Sat, 28 Oct
 2023 14:53:05 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e%4]) with mapi id 15.20.6933.024; Sat, 28 Oct 2023
 14:53:05 +0000
Date:   Sat, 28 Oct 2023 22:52:50 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Julia Lawall <julia.lawall@inria.fr>
CC:     Keisuke Nishimura <keisuke.nishimura@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Fix the decision for load balance
Message-ID: <ZT0gQskmc//KxYyD@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231027171742.1426070-1-keisuke.nishimura@inria.fr>
 <ZTyfoIBpm3lxd8Dy@chenyu5-mobl2.ccr.corp.intel.com>
 <alpine.DEB.2.22.394.2310280836100.3338@hadrien>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2310280836100.3338@hadrien>
X-ClientProxiedBy: KL1PR0401CA0018.apcprd04.prod.outlook.com
 (2603:1096:820:f::23) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DS7PR11MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: e539d884-37f5-4f50-5bf5-08dbd7c5963c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8W+eM2uoGpFs767TT3VtTRX/iIqGUkUL+tvHJXDFV1rLXM+gTLADteKqLxuNZvNuTSy3O+/IZfXsMlNJiZXret0N0snEQEDHUfS26WEj8NkMTCdT++r0nXcqMHfm/JX7hNM9Y8GbsubLARH0nE7HabstOYlDS219Rqe/T1abOdGxV1qeDh93d1GheWoE9Opb9Bx0YgD+8EMVoR/EVhvCsaXJ4sqnHtAjFkLSjnLukxpDI7+naWn8avW63PKo7pkncP8oXZlq9GvnW5nzs1rcVonzU/9ebal8ATsKeK1NXfoZCp17EgaeS7YZicJIl1l0fm84Upki9ERyYoCLUFTBigWtVPnIea26PAVs0HC82KPVDUCcN1r65h+5jFJvw+hRQ3yVpwJJjzaDg3nR7vlGP/P7qS9xSKpnsNIHeLw5ZWCVDtKZFXud/Y+/fIkCFn88AYdPewf2xkS/0R6bkO5bwd3T0zr6lgyaOJRh4VtOR7afpgEtbG+JHQRq7yF0IOYhGUrY8UuDRKkYvz8eHfla0b8sXsoyyeDchrfqF3AfZSWVIf/py5X+yaU96X4cRnZr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(38100700002)(83380400001)(7416002)(4001150100001)(5660300002)(6512007)(86362001)(82960400001)(41300700001)(66476007)(66556008)(66946007)(6916009)(53546011)(54906003)(6666004)(6506007)(316002)(4326008)(8676002)(26005)(6486002)(478600001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w/jjMEXFICrw6wo/zdn78vnnagABO16H4QVv2lKJwPa0nstHgb8aMR56S7RC?=
 =?us-ascii?Q?MgRk23rIBVwC2DoiII+Z2y2QYrH23kDvxO8E2aOxrXNu7sxb6pt3ku3jlwst?=
 =?us-ascii?Q?XNcOaAqMA7s9iQr++wek4mSt4DnjDjxG35UMfxyq3kjQP1/JEpTWdl0jn6Jk?=
 =?us-ascii?Q?UjamKaQBhmhIsEe8tiXpg+7Qi8lhcjGmSnN1k4ZEP0l4yZFHwtJ2Gni+5im7?=
 =?us-ascii?Q?OQbbWG1jBl0zkdz53UBTebmcBL+TMuvJ9I3MC4MqY9E4oKus7JUSBs9E0RBs?=
 =?us-ascii?Q?bwl0Oc2GRMl2xZFgwLpUkFKo+39uCWNDFyWXhcGt9OlPfFsumufrIXbTkoGI?=
 =?us-ascii?Q?CkxxqjEjiBNSfwvgp/hGXziXTsBOxwjjXgU9oHxsICG/L/9i+PmZ0FrVzF4e?=
 =?us-ascii?Q?9UuWyB0ZoTGQ+K28aJpHOh637cjbqoP6g/SwPV+rXxoddZK7xMEG4RS9a9Cn?=
 =?us-ascii?Q?YwGyFS9/AP1E8QJ0p55IvZfUMlanPk6n4LaNhY+OoxVhMobWhEEPvKNC4wj6?=
 =?us-ascii?Q?5TNas6D2sPlkMCRA0B4SI7HQ6XGr4L9shkbE3aP4Lnwdg8jmzOI1NPhjYDIY?=
 =?us-ascii?Q?KF0RWSNlPm0AK03NEloWEOudh67IcLNPqM6ueCmYuBhcfeT9N1syf+7p8wbP?=
 =?us-ascii?Q?MEJOooxRYM7Y6xsKFNlbFlGOXVqM1GFMAHBesx3KoK76Nph/trMuqDiRPQNa?=
 =?us-ascii?Q?tUCuY5xmqXIUbuRzUbTXV8Thu5ri4Q2TwEuihRF6WkW09WZps9PRAsdxJkXF?=
 =?us-ascii?Q?cFfoY+H3LmkkR47C43O8r0yyoEA+yIeVQqBiX7A0Dr3xuT28KFz7o4x6rjO6?=
 =?us-ascii?Q?L6ggwFu/IK8E/eJ2b6s1Clpz4XO7TKwcWV7dzKlZCRbTfOYFpkjbIaIZBTBR?=
 =?us-ascii?Q?O+e+yLelbEn+c7aBS3ulI/s4ZD5c32aioa2zPxIHg3dHkXJcunG4T4IB+LPW?=
 =?us-ascii?Q?7Wsgc0VvfhVPGdYq1woIDbpneQ1F4F49X9FJVd4NzhWxR2nVHpZen2jnpG+0?=
 =?us-ascii?Q?2HkfQc+WELTv4z6/BTTyaj9Lkh9dl+kzds9FU3NhdwzJyjl+qeIyz2l9O7Ae?=
 =?us-ascii?Q?X7SSTosqDtVnQkgjM3fpDoaPEz18Y2gBmjT4uke7hESJKu0mZhb2fbURKWw2?=
 =?us-ascii?Q?f5J+s1ckH5XsQdaCWTykp0aRo4MZzhZczx675cpK2N4g2QOMQmuFD100tQNZ?=
 =?us-ascii?Q?e96Yc6BRCJRRdVTBeRxxMjv6zxG31F+j0SRWKyDnVC8tH/9YtAH6JUcEXpU9?=
 =?us-ascii?Q?2BxPx8c9zmj7Y6SOe7svdl/ytD2k9k4k3puedoD9EpYA7jJ0hQSAkGIfva7K?=
 =?us-ascii?Q?Y59XQeUuAGqbkNhtZIHa4iRaxcN0j8GsfkcOOWGosrc00NQ6kM+pqnFlp9cU?=
 =?us-ascii?Q?zGT/BQSQv/PNk/I3ecUOtNaRFiRM5nJlq43+P7wzGlcJJcETAloNIDrbe61O?=
 =?us-ascii?Q?7cYj25nU7acZGclnVanIgbkr3u0lfJwPD/KlVoODqki7yek5KawR7vlBLAGq?=
 =?us-ascii?Q?F3Bj4/iEBmvhEuv/Shf1UX8pEn07A5fMFhtPvnivq8DoOaOFSwH7Ggt5LVj1?=
 =?us-ascii?Q?rh3j31vkj0Snhfgo0+/CdO8fEtIa1qRVUYKxzSHX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e539d884-37f5-4f50-5bf5-08dbd7c5963c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 14:53:04.3528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVTzCDGZOerbxpbhdKyV61gLo/k5PJQMLjWi0lHKi07Xs8zc8Q07t+8vRynd5YUjO/BGCo7AnxZFzAyzTw5WLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6062
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-28 at 08:37:59 +0200, Julia Lawall wrote:
> 
> 
> On Sat, 28 Oct 2023, Chen Yu wrote:
> 
> > On 2023-10-27 at 19:17:43 +0200, Keisuke Nishimura wrote:
> > > should_we_balance is called for the decision to do load-balancing.
> > > When sched ticks invoke this function, only one CPU should return
> > > true. However, in the current code, two CPUs can return true. The
> > > following situation, where b means busy and i means idle, is an
> > > example because CPU 0 and CPU 2 return true.
> > >
> > >         [0, 1] [2, 3]
> > >          b  b   i  b
> > >
> > > This fix checks if there exists an idle CPU with busy sibling(s)
> > > after looking for a CPU on an idle core. If some idle CPUs with busy
> > > siblings are found, just the first one should do load-balancing.
> > >
> > > Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
> > > Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> > > ---
> > >  kernel/sched/fair.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 2048138ce54b..eff0316d6c7d 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -11083,8 +11083,9 @@ static int should_we_balance(struct lb_env *env)
> > >  		return cpu == env->dst_cpu;
> > >  	}
> > >
> > > -	if (idle_smt == env->dst_cpu)
> > > -		return true;
> > > +	/* Is there an idle CPU with busy siblings? */
> > > +	if (idle_smt != -1)
> > > +		return idle_smt == env->dst_cpu;
> > >
> > >  	/* Are we the first CPU of this group ? */
> > >  	return group_balance_cpu(sg) == env->dst_cpu;
> >
> > Looks reasonable to me, if there is other idle SMT(from half-busy core)
> > in the system, we should leverage that SMT to do the periodic lb.
> > Per my understanding,
> 
> That's not the goal of this patch.  The goal of this patch is to avoid
> doing return group_balance_cpu(sg) == env->dst_cpu;

Yes, I mean, without this patch, we could incorrectly choose the current
non idle CPU rather than that idle SMT, but actually we should let that
idle SMT to do the idle lb.

thanks,
Chenyu

> when a half-busy core
> has been identified that is different from env->dst_cpu.
> 
> julia
> 
> >
> > Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> >
> > thanks,
> > Chenyu
> >
