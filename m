Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8E776453E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjG0FEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjG0FEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:04:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956072719
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690434279; x=1721970279;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HR0om+sbyH0ny2PDg8GaD2+snxFlotHPrqIpnEOM37k=;
  b=nPSiEO5yHVp99lquxyZmoR6FGi4NSXPjxcgQZgJXCq7TDoZFt+teLfdK
   oY7Z6mzHBWz9bfroR7Nl+RUIfuNvvxPgvu+g4jZU4QH5bjiKfYc6XWpt6
   MVehYPZgR9tenuCVdrscTqjiOE/Cm73caiLf2MkaoUXK8k8fwvRSykYDd
   Ds0we79iz/rCjxLo4bygDGhowFgN9uN6+sERBYOeE/lKrWLqLJ7iTODQV
   KdHqUDr0QRlEjtyJMciGp+4bV3VIzPEVzvPa9AZk49lAKL85S7iNSyzuj
   0XxGr26//27HVVGIhllkNZoL02bXlaJ60hUU3gwW3kZgcwsvj8kt8+vne
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="365666577"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="365666577"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:04:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="726806091"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="726806091"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2023 22:04:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 22:04:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 22:04:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 22:04:37 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 22:04:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLFb2A+ntR8xgcob/LBq6333mSM5COofIAF5d6ryJJ7YFD3zaInuGjoqOjBUcpsWrLhEKXN00P/P3Wcug7/P0NHom+J8Ed0C8841lo4AQpqhNhFMHGuksode+wojHW3q7e4KqTpOuijNm+BemZQXrR9obmmHJ4ucg9MMIUqh0l5Z9qX8lM2i+mYMXTRczSZIFgXc3gle62q9+wCDE1c1TY4kmviQuarumoEpg8Acscd25l8SDYPw+jgKL270CEBLC7LjQ6m3P2AmkRQY3IksrwVY6RFD99lEL+zkOZCgTkXbfItyn9JKZDfo6Z65oZZZUXKenp04zivBQ2c4A7DlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gdh9+Hmip6phcMALemBCDBaIkeFn4ja47N2n187AyV0=;
 b=BGVfP/mcr9u3YVmcgZ6br1lSndP+zeUjkQzS+5q6YMAKB5hzESjDS4IilV+Ux9kGLnfyEbnAUkFV/CH3XPXbJwaM9pM5EeyYpmelTHz0vWRQymdU79Qx9hxoXkCkjx5SHjDEGim7PsovDspIydPpN9pviFEF0oTLwLfN6XVXcRJyOTWC1wfKo/HmVz8UIWz4ctm89JvDZnpKlizAK2gsOPeDtSY8+3oYqck8FqEy22USprGJ/6nvoxpO7lIrHPPmwRtQ0jxtInT8Ik9IfBI6ifDsiWyyLtEr5aQ3JZVM1aZCAYawJzWQgPVHgl25/rmFIlSzQTqSg1Sc07z2UtF56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA3PR11MB7977.namprd11.prod.outlook.com (2603:10b6:806:2f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Thu, 27 Jul
 2023 05:04:35 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6609.032; Thu, 27 Jul 2023
 05:04:35 +0000
Date:   Thu, 27 Jul 2023 13:04:13 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Swapnil Sapkal" <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/1] sched: Extend cpu idle state for 1ms
Message-ID: <ZMH6zVe4ezzyoNxr@chenyu5-mobl2>
References: <20230725193048.124796-1-mathieu.desnoyers@efficios.com>
 <69076f8e-191b-2e3e-d810-ea72d8ff18bb@linux.vnet.ibm.com>
 <79fa8a62-a74e-2623-9f03-1f1af85b6c07@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <79fa8a62-a74e-2623-9f03-1f1af85b6c07@efficios.com>
X-ClientProxiedBy: KU1PR03CA0021.apcprd03.prod.outlook.com
 (2603:1096:802:18::33) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA3PR11MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb6c9ab-4898-4c5d-d63b-08db8e5ef808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8z4KVZn7PrUFxpng450/VEataxkBMJjoRhHbUWKcG8CatDAfBi/iMsvfNh0w4bNauB4EW5hQ9w+I2uFyH1x3Arl7P92tbWKCfplS4rj6qlcvGdVsxraTHx7CdaUM7hd+qWvSYXLJKesdKXE7PpuWdej+8Cd/OtRnhi3PfUuDcTunDy6DA2AF5y2LoeFm/HOwJ1Ifnf+1eaAF5gqeGLPWSZey17T3nFiM50iIpEbL9y3TWkt3AoeHRcocLyU1ihFKCmlPCpBSV7ppCfQyHWV1ZqgGlI73IojSdHfJ6HcH0V2pILFgK6vWor+g9Wb/+f59KbD5xGycqChmwyeRdhibCEJUUsgY3fFU/VXkfolLMJq20B3NOQLWDldA6uqKoZD2Ceew2xLlclN0UoHg9Xv0W6XBYXp/nTkqwrzmdnON0Vcmnfa700t1oiC9REzZBSMN8KlSu2zRYHcnWGj+3U5nskTR3ocRXg2GcYVw05mHg0j5eiOo0VtGA1AfLNXEwu64hJgxYEKRgGddSTJQ2M2sdxkj8clpEWFF7Qlesn4//YETrIFa7L8PyVHCnY5O6ug0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199021)(186003)(26005)(6506007)(5660300002)(8936002)(8676002)(7416002)(53546011)(2906002)(38100700002)(82960400001)(86362001)(6666004)(9686003)(6486002)(66476007)(6512007)(66556008)(66946007)(83380400001)(54906003)(478600001)(41300700001)(6916009)(4326008)(33716001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pkURm9ylUgrJvIbxaVhbdhLSkbLKo760+NLzItZ4M/F6fNjE/svarTHvOGrF?=
 =?us-ascii?Q?7HZ1YZryttC7+gyE6RvXhN11Twz9ACVMKKGM/o7Z29Juw4CS49OnQK4YcLTd?=
 =?us-ascii?Q?05Q3xGx6syLRDP4aNSJw1XzUXp0hu/fNR4X+688zIaApmUHRzJBMTh4Bjwop?=
 =?us-ascii?Q?WmRVM9n4zuVn/mHcltf542V+mTZxsD98EdEdPTNOOXPWU77Q6O5UkrPysVYT?=
 =?us-ascii?Q?/LkVo5zGklfl6qFS6lIELknR3Q+TkC2YMG9b4lVatk/0KdRs/09lhXAFFJY7?=
 =?us-ascii?Q?UpTyuAIKRjiNUoSQFNcg9hoT6ueBaJO2X8KRUpCJMrtP08g4kU4bXD7GUoan?=
 =?us-ascii?Q?N6PFAFP/r7NVEwJoq8XKtNGweRQB/5dE70BWoXmTwDYKWvLqrOteGsMTJiHO?=
 =?us-ascii?Q?tZgP8Aj7Ysrtxwj8HSbwvwxPpNU6Dk1VQbvIC+Y8v6j9FNMRPgyyiGCGpZa4?=
 =?us-ascii?Q?AFCvV1dkOmUpT0Jtwd87ao9CEoaUxZDYceoN5BYXVOwCg87agC82sutjTPnj?=
 =?us-ascii?Q?BUWMbma6lVbA49H7zosTe97UCL4AcH6ODw1R8d+6o23tQBwQm0PUqgyz+Vkz?=
 =?us-ascii?Q?h5MeMOvy7xX97/fygZM+0vXYd3TsIEP50r2e1VlskG58GMuYjK994MTHtT1n?=
 =?us-ascii?Q?6a6hgc3r4sHNfuTzkJ6nrE4i2jBaSyKq0mGP75xzo59WIEyfhwUx50HrQHec?=
 =?us-ascii?Q?homjj9ZLm6bTCIYWT/GSqXNUkVnbQgSZTHNLQCtAxZgF/viw9T0KYknOdhgG?=
 =?us-ascii?Q?HFzBd2z0aL1lImhgWcU1kLj+qsoaMt/qTbSOQIoBtvIaw0ExHlILEX67NWjN?=
 =?us-ascii?Q?hFWXPp7Yc4MZLFPEGimvZtUWcpzp5itWdFDoR8EkJTVBZWHWpoMiGphP+Z2G?=
 =?us-ascii?Q?ksMCXyi/CFDS0ewlyopz4sqsVmCb0YvQUcDDRfGBrBjobEYan/A5myF4qMph?=
 =?us-ascii?Q?HiWklpkzsuiMAfqhdCCH0hZClsjtLPNb6Kd+PoPQHSO08XznkcJErfGdn6Eq?=
 =?us-ascii?Q?2vbyEP19pU2h++tXZFCG4xQohePCVse01sxrxkFSdP1iDVUwLAoPjLswr9jI?=
 =?us-ascii?Q?39IGWddIi5GXGUnJ6KWz7BYCGbB+lhe0bZfI1HGGnTfo2Jvk1jbgF9T49WCx?=
 =?us-ascii?Q?S+B+La1nT+Xw8ChA7/lWoIkb9Icf+T813I3j37tumGbiJz7/CMre+ROjfk91?=
 =?us-ascii?Q?PYUSmyqpsf1HJ35svIByVuJ/ADdxFNc566c9tC1g0vTKLnSUWZ9JnYDt/fnU?=
 =?us-ascii?Q?aX/2cir67Q5+xi2kgO5ftyDw6BZv+P9GNgzhVfip77QnVlIIdJFrC1GOHvIa?=
 =?us-ascii?Q?5KlTZ7yemxDq7/Om2Fag/MwJW95+ah5lZGhtFTUoZ0hrIhXWpTbF1Gny07DT?=
 =?us-ascii?Q?U1lJ3pLnFYsr26uGVgiyk6SzdzW8ErVNglN+R8lJuRjpzLlJl1zRiXZEbksl?=
 =?us-ascii?Q?3fpd3Ix0Jh9wnpYQX6u0Uzl8PPnH7zK8zHkJEhhDp4K8ARLozzRGV95SY5m7?=
 =?us-ascii?Q?ZcbkmtfcjX6Jd6ERU3Sna9lBM+jTPgOkpWUZIOTeQf6TEcvktCRDm9Lzc7qV?=
 =?us-ascii?Q?7RGvWeCehZd+sx/kp1VXcw/etigJh6tlPv+aTMYe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb6c9ab-4898-4c5d-d63b-08db8e5ef808
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 05:04:34.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0XC2wy0K76I5XMHfyRLP3N/j/HpAB82bvXb/0d69e49YM68mryu+MoWr0S/wO5s/DsnL6wrKMt8QEHd8H3nOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7977
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-26 at 10:07:30 -0400, Mathieu Desnoyers wrote:
> On 7/26/23 04:04, Shrikanth Hegde wrote:
> > 
> > 
> > On 7/26/23 1:00 AM, Mathieu Desnoyers wrote:
> > > Allow select_task_rq to consider a cpu as idle for 1ms after that cpu
> > > has exited the idle loop.
> > > 
> > > This speeds up the following hackbench workload on a 192 cores AMD EPYC
> > > 9654 96-Core Processor (over 2 sockets):
> > > 
> > > hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100
> > > 
> > > from 49s to 34s. (30% speedup)
> > > 
> > > My working hypothesis for why this helps is: queuing more than a single
> > > task on the runqueue of a cpu which just exited idle rather than
> > > spreading work over other idle cpus helps power efficiency on systems
> > > with large number of cores.
> > >

This looks interesting. And it does help power efficiency but how it could
improve throughput? Is it because of hot cache locality waking up task on
it previous running CPU(because it will be easier to be treated as idle),
or just reducing the time in select_idle_sibling()?
 
> Good point !
> 
> Can you try your benchmark replacing the if () statement above by:
> 
> +       if (sched_clock() < READ_ONCE(rq->idle_end_time) + IDLE_CPU_DELAY_NS &&
> +           READ_ONCE(rq->nr_running) <= 4)

If I understand correctly, this nr_running is to filter the case that the system
is saturated? If that is the case, maybe 
	rq->avg_idle >= sysctl_sched_migration_cost
could be checked in case there is 1 long running task and we don't want to treat this
cpu as 'idle'?

thanks,
Chenyu
