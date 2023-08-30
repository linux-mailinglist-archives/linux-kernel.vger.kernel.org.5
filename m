Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DED478DF94
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbjH3TVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244514AbjH3NRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:17:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0506A185
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693401456; x=1724937456;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=huin1Fu7v7JPszTobbSMeNMQPADLlBlQvBfw1B/eDLM=;
  b=bY9/jN6nmWbOMxMzFVTe/b2hBw6wrkZxxL4p9FCNMMYPMywHlBjRGxzZ
   1hDmLyCnLK339+OBlNe4zGyKVoCACKg/BaDlgWURNyk+eCGhoIxnA4Aq+
   A7lJIv8efHO+u718oiyd+k8U229NYZVf5Zz55Qk9QJrrC1fJpiaiv6n+x
   hWWmt0DDNqb4CGhlxKgEKV4h/IAt5vHnSYQeHFaFYKc1hIHcP3m2yY6CL
   dlk/2/WF+pGiLuETSt9YPK95NTKKC60m8szZDOsPsI945OdCJ8HRoG56f
   6FKx6wO1+d+RJhpnX6/oLmsD3RoNp1Wh5/LVRByQpA1tIDqifvc6ASAFj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="373045626"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="373045626"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 06:17:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="809152796"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="809152796"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2023 06:17:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 06:17:19 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 06:17:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 06:17:18 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 06:17:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNiWovJPiQn94xExvUgRtD6QJjeba0hh04ksxb/00jIF1iTMENdx5os78HHyMHgSCa//a23T17QZNWNOSl+bP+kCkDVcjsJVi8xBiB60iWXJsG6yUnQtd+RkP6yknl/eWulIkBGzwJg3rooxu33qrge3DRB/zL9grml3J5qLBH6jdf8QOu/aGiUxUUBgK0KQJOUiFZb2TwIbQvbAe8gaFhsnETgRIiUDOszeZVafYbV2S35KlrIPzeu+iWlM8FoAF3H0f/9MqIVbRf0aaxCv85jKObKD1AVh2rMZASZo2HLynyNMG/Co0QaVqMkNA1Imj8EGHfOU/5yTLuhTjBdKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsOkqlQs7syQ27GML1+71kAdxT7Ooy2Iyse3wk24MZU=;
 b=BgotadfNG0jsautIqMQni84cavzKYnNA4R3kV/E9vaQci0uHP0QWle2VFRcNrQG6ZHp73i1DKEQDtN/dJOZq7zFxGiTQoXsnWOfZ3qirljHLXfEcFAEG+/KBBNBOG3F85RREAx+9g34Jc21wHUGbHYyTGNQ18ioeKxLX4mZG4JgspdhnEUVnYtA4w7rlPNOf51K0Q5zOSdxY8piORAt1IKXBb9GhHupAxZbuEn1j4kKE3PnKhgfn6LxG+S8MCa5FmZhTsdmhsjGCo2LhmTtdhhp7MQ/mU5XFxWXsBBoVXaHzDPlmTddLgzRw4mpdaF8Hw2BYlUS27OBRZrHB5OC1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BN9PR11MB5419.namprd11.prod.outlook.com (2603:10b6:408:100::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 13:17:16 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 13:17:16 +0000
Date:   Wed, 30 Aug 2023 21:16:57 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ionela.voinescu@arm.com>, <quentin.perret@arm.com>,
        <srikar@linux.vnet.ibm.com>, <mgorman@techsingularity.net>,
        <mingo@kernel.org>
Subject: Re: [PATCH] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Message-ID: <ZO9BSaGpF5lIAjzy@chenyu5-mobl2>
References: <20230829065040.920629-1-sshegde@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829065040.920629-1-sshegde@linux.vnet.ibm.com>
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BN9PR11MB5419:EE_
X-MS-Office365-Filtering-Correlation-Id: 527f9fa3-255f-489a-1fe2-08dba95b6e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3DoAK+cH+eX2O2Zmfj5n5gyeguWJIj1Kxzy8yBcCDLIA7cLb9JLbBj4SV17HopRAQc+otEWyCFDFjRBfKOe462Jo2XwJJCVfnDRgx1qhGFOmtWnivLfr3cWC+1D0p35eGaM89DJtKkDEnPPALk4Gmcmsk+OPx9zey6KQKuxalppJPtzsiiumc/K50pMLivcVszrZGJK7+4ZY2suYnFRq5Uj+ayGkHgI0GBadRd152DtocGqO2R1cLsagTPXq8vmI+ZUft0o0V+Tw2vqhxngXglGMDHlDK9zNo6GczPe/7gEWEvP+Pc3BIXDVzpE0fy0xjLmMC3HfSymu10lBnhODgGDz5/SyegX2/FuSynw5XsTbVVunLSb66luWwFwcJg1KF6doIkyTU6b2E5qX0a3oG2Lh55c/86aQlayJHXLgbSfWAKQpEaWXhmS55pWLFsnJxVGFU/rmMdoCRsf60+jyHzlvC9iMu3ei/ERAr4u3mqpefdCEzOjo8bTJQLlLcrFUqo+Vjl63A0xpNALtwh+XmJWJXbR2nvqBD7x6bRZ8RI1sEZGf3MbNa4yip/Njqqq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(33716001)(2906002)(5660300002)(7416002)(86362001)(82960400001)(38100700002)(8676002)(4326008)(41300700001)(8936002)(66556008)(26005)(316002)(9686003)(6512007)(6916009)(6506007)(53546011)(6486002)(6666004)(66476007)(478600001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rvd6f/0gMxOweYObWk6lSGfDeWc7thefVe8JC2abH9f22IMbRcBVWOGPLcWE?=
 =?us-ascii?Q?qUwv4wef6i7OeWVnkcPYe0X9S1h3hR8a4TmJipmQAvWQG57aXPN9XsZBe5d6?=
 =?us-ascii?Q?Oyb0Je5GaFFR9Tmg1ejwAq2oN9sQ+t6+Ysr8ftI61goHkkhT0ybxv/eYuGpE?=
 =?us-ascii?Q?p9T98TuuUzXeO9/N0srZvocv1XE01S+AGGiCdW7AIJY01H0aN5tnFWD+b6M4?=
 =?us-ascii?Q?dDavOcsIt1c6YnF3JuBvKwHVvsTzQ9Y7x0F4xVBbQv3EAuNI8vitu8TNvJpJ?=
 =?us-ascii?Q?FfNU8bQMQQz3qmk+1ddaxihHzP2nbidkP66svF1BHQxOsFu58H6WhWQzHb8F?=
 =?us-ascii?Q?cRzAeARHUVlUed75UH+dIFebQsrzRpE4uUUEFO3CjLVv3erQiZjEz1VBTftY?=
 =?us-ascii?Q?2pJ2JHDi8EdFAtYBkgoiUMZEn2dy3t1c3a0U0swQk99KMOj2HpP5XBHIWpnW?=
 =?us-ascii?Q?uHavkRKwHShBhuWSnt0d/2jbSXV5fuBy/ZL9QpedA8yVnsLw79VYm3wsHWYp?=
 =?us-ascii?Q?oojbxcsRZ3u+P7+/f90dokFlQCmL9ErfubXF0JByFss9wzflvl7DOQcVZNzh?=
 =?us-ascii?Q?9lLISd0xy/5cBZXw3ERfc7SBncl5M0qqUmLhVNaaJ+l3g3wo8KQyN4JDA+wx?=
 =?us-ascii?Q?+3FHPQRqaoh79gyUx3GMyuX6LVUkQ5PHUyE9Cyu7VOgFF3nC7EknCqsP0y7u?=
 =?us-ascii?Q?tZE8S64uGWQWQArcOvjflyvp0vK2MPsV1EdJtlJH3/xg3tK0epd0AOsXlozw?=
 =?us-ascii?Q?9J7nE2gDHzWQ/eYjOXEEe/dpBkwELpXcmwLVOTa7AxnsEHq6X2eikDkUKi+E?=
 =?us-ascii?Q?vCk8wajJqORXa0pf2bfXP08l8ALboYSgweMpnts4Rk+ohaeCujUI9N360kNI?=
 =?us-ascii?Q?zTxn7k3QpgTkYAPiXGHnmEDB1IrTuF8dYR/4/7HyD7Plvucx48dbAqefx0ft?=
 =?us-ascii?Q?/OssWtDlqUVWSz8rqfnTJknFkcrF3ondbVmzsMl5r5r8LZ13a//LHMaJXQ1Q?=
 =?us-ascii?Q?+VhzGYDqOzyr9aho3AeGldVPKukEBbuuawad4wfP/i9xgEjiLZ0dKqxOae2R?=
 =?us-ascii?Q?/NLvMwXYxstfoz3cWCP2Y38HMc5cedS6MquOWiT2Wb57ePXU3gQeCuX8/7ep?=
 =?us-ascii?Q?0LF6NiqaeOTUtvsSivBQ637Y1dMzDPUm8FXBgCthOzowf3C2hQonbFfgOhHc?=
 =?us-ascii?Q?Ql1Ol2a7itjcO0xg3ta+7Y13CkKLv7Ll1l7vH4q2b1G3aAp4s/F7w7IuKMJq?=
 =?us-ascii?Q?RxudooysKlG1mGUbrqC0nxkviepmBHzc6Y1zuveSVJ/v1SeW7oC4Oxkqi189?=
 =?us-ascii?Q?0GWXP99wmaLe77W9SoRkaCj3Y7+hW/XVG67iGRJHCA0ZeYNJmQtjqVMQXlo6?=
 =?us-ascii?Q?fLZ45gIFsIExGBbvQXD3mkb8ym+11mDzrZIOT+7NtgP73s7n40f6l6gtW8/T?=
 =?us-ascii?Q?8zKlRRM4Vd2k1WYVTiwwUhfFT8tVpAEB7/0oaLMzHX9TiTMOgXBuxXOqZ7FE?=
 =?us-ascii?Q?AYoxc/NKy+dvMyo7iaYViAu1OFs9sG+6j7FXIdpaBTvUW83DpkN7q8HN3/m3?=
 =?us-ascii?Q?ps30w7Y1D4BUsEOLXObzhe5ivcKU5rYrd9Atc7KU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 527f9fa3-255f-489a-1fe2-08dba95b6e1c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 13:17:16.1401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FlfeW+0yjPBBUnLaU2XKRSfQz9zCvJv+RhkV7VCluwOEF2n4zHS/4rEO88UyEx1IP9EIjfwJAflVDyY1C83Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5419
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shrikanth,

On 2023-08-29 at 12:20:40 +0530, Shrikanth Hegde wrote:
> Currently sysctl_sched_energy_aware doesn't alter the said behaviour on
> some of the architectures. IIUC its meant to either force rebuild the
> perf domains or cleanup the perf domains by echoing 1 or 0 respectively.
> 
> perf domains are not built when there is SMT, or when there is no
> Asymmetric CPU topologies or when there is no frequency invariance.
> Since such cases EAS is not set and perf domains are not built. By
> changing the values of sysctl_sched_energy_aware, its not possible to
> force build the perf domains. Hence remove this sysctl on such platforms
> that dont support it at boot. Some of the settings can be changed later
> such as smt_active by offlining the CPU's, In those cases
> build_perf_domains returns true, in that case re-enable the sysctl.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
>

[snip...]
 
> @@ -380,15 +400,11 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
>  	struct cpufreq_policy *policy;
>  	struct cpufreq_governor *gov;
> 
> -	if (!sysctl_sched_energy_aware)
> -		goto free;
> -

I tried to ramp up the EAS and maybe I overlooked it, why do we remove above
check? If the system boots with EAS enabled and sysctl_sched_energy_aware
set to 1, then the user wants to disable EAS then changing sysctl_sched_energy_aware
to 0. Without above check, how could the perf domain be freed?

thanks,
Chenyu

