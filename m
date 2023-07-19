Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4908758FED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjGSILj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGSILh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:11:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEC7173B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689754294; x=1721290294;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YJMY1VzJI67zSruqV6Q1blx4IKqWTmKtAQiPXn0ta6o=;
  b=K3k9ScCB30RANxOgrKT0ifv4EAaMjNtuXiUOaiPN2ZWjaCNpLgZYH2Sp
   KHKIaWcQwjfZn3U23n98pgr5Ht0DrUfGKK7E5fihKo1psZ195RfE5+XoM
   O5whP7HRk3LYI6QNjrkT65+hdrKw4a5TP6qMd91Cf0cd1SatAkQu7l2fQ
   uRt4yMjtglJlP6gdzuzfNeDvAl4bJ78/V7nTshIPR+6APB7siMAn2d98J
   P1SUm4nq+FAQNLHB/DIhHXFqe3r4SUggR8cryxL36rmKE+Rz+YYbDEIO5
   VLX4fcw8540hH5TfRT11FaACOLKs0KRmwRAlkj2IAtH8zhwlzQK5t5hzT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="356350848"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="356350848"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 01:11:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="970522901"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="970522901"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jul 2023 01:11:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 01:11:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 01:11:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 01:11:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 01:11:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHuk+GnZmd7hpDoTLmVxZZfHQhYc1TVcC+tWtEMme08rjhoUmEpTGgAGPZ3oIXXwn63uhtiPLC8DLXU6ZIOExo7WZpQsXB5af8qM9HWNy91Du67JClM5AxfyNa4vfLHKhfqcqPQs+SI1gUPu2vk4LEzI0efdZWS7kvGrZh+vxyUCQy2KVcaE9PHPVFiE3/KXf0KrE3d3JFYiBxDTOJWZxU+9e0F6NkLQP+mzhAfflR6LwWqocAbxY0ZagJCx2iKApJ7TWhVDtU+Jh871Uc8GC6TroJQ7dff/hfZNFFbUct9MBtksWIYYps8iznysR3hLzTxdX+9bghcWqkHjmb1/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvn9vZxawYsyM8Oznhrm1CcbgZ0ULqQL/toOYShGVNU=;
 b=AowdNXezaaK34gc8YBqBQDy6diRyoqqieRDmldG52iPrLFvZCkrdoty8Iq7gYxFNlTMf8gYoqtw0X+s5y6iEQVWaE//FiQrRqS39w0Z4LZewvF0TXeXxplowhG2BsxY5tjUjvTLxQMh9UUaVTNGKm8q4XHBMi0/GKM87o/tfT3Ng/KgLC6TtD+agn6Eh3zOkRqQcegn9BsN5cXApI8dg0uHGuJHvgusiEpo5EWi+7nvkCZ6RC/8vMLPdLQsBRm6cL0fRTUuvBffbRZWtFW6cu9wbV6KALEniYYTIkigrgozTO3VX9JOHT9TSTGq1HLGdgEqZbmKd2VFctKCNUnvp0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA1PR11MB6735.namprd11.prod.outlook.com (2603:10b6:806:25e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Wed, 19 Jul
 2023 08:11:25 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::104:1dc4:6843:e372]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::104:1dc4:6843:e372%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 08:11:14 +0000
Date:   Wed, 19 Jul 2023 16:11:02 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
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
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] sched/fair: delay update_tg_load_avg() for
 cfs_rq's removed load
Message-ID: <20230719081102.GB90441@ziqianlu-dell>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-4-aaron.lu@intel.com>
 <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
 <20230719051826.GB84059@ziqianlu-dell>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230719051826.GB84059@ziqianlu-dell>
X-ClientProxiedBy: SG2PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:4:7c::33) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SA1PR11MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 1478b467-4e44-49cc-9abb-08db882fb838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2TdMpxJRun2zi8774HQJ5oPrYaPsD1Af0KlG0oMCxts3wlu1d91zcc9p8XpJYRvKGbdANBzMMAkX8ME1scURvERSItiqc7uNhmhYzX8kDAMcGzz6+tl12CJPpbHoujkwscQ+SFio3+bU9zoElSCFedZ8nufAEvANJtUakB5boDzXww8TxSTKU1BDoJtDKkfxNMnAhndM/qipxyBHwdrQRPnsmC4Gx0IdlWc5T9QOIPMxCqpVsqv5zT7CknEwzLcxectdixdAu5nOEljZUlJcwIt0q41Xem8ap6T2pQ8QKVcRnBMfoBTHdrRH3dQ/UOCiE2W52ipGXdqrnTK3ZEOFId1DAtwjtFPw4ZYUOCGUIPkv1QtUsyO7rB1v3kL9K7/PU45OyU9QAwUz1AuTkcZ3BME5imOChZ2HLmcvyWyfXwIlzp+SMkGl9gAiAp0VneZcYpjXDIQOa23XA7PoChz8l2wVNEUuay9oN7EUdCqJhxDVEq7rCpIGqu2Yjl+Cqru0gNGg6aFYOA1bJWBSy55IshxFHqJRf5h7r9pSPBOtcjqMh4OXX2Arj5bM+VGSuor
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(5660300002)(7416002)(38100700002)(44832011)(82960400001)(8936002)(316002)(41300700001)(8676002)(86362001)(15650500001)(2906002)(6512007)(1076003)(26005)(33716001)(53546011)(6506007)(9686003)(478600001)(6666004)(6486002)(83380400001)(186003)(33656002)(54906003)(4326008)(6916009)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bAqU93VKfgpeek6c+B/pPj/GePuvYboeQlLicqQnEPGQY76hVDxxYn1TQVpG?=
 =?us-ascii?Q?PMnSh4h3hiZUv+gqTi9Dtg8IgmhmRgrFEl7h0gtBg51dkxLdPhV/dmJYhm/x?=
 =?us-ascii?Q?5J6PGOXyy7S2d2hZ0/gbV8jG2102/6zKu+xJKsZCfurGzWnWqNUQ2MvP9t2i?=
 =?us-ascii?Q?HR62mBsrUrJ+5BUyEFGKPFk5X/1hXbT1CpFFTvjt++u1t4TA4zdSdTQ90UvF?=
 =?us-ascii?Q?q8mi0HtAd+RnpZb9EsSbsMBugmqQpswxGp2pmiZy5L/DCbwa3Fsscz2NeMvR?=
 =?us-ascii?Q?tq4Ihvt+nbopMnmGzQLxAoFNZVR9uvn4LUVNCrCBhuUkgVNzVEaXdeypA13w?=
 =?us-ascii?Q?KEkpiYI6WJb9XrHvZbb2GQGoeqAHn0hfNNiR1ggFsiPRC5LGO1qTO8JG5T/v?=
 =?us-ascii?Q?sN2VCLNcTFZ8X88TAUrQhvHxoZBS5xOWY989p7Vu3iX3GVDKKz7ppxepysIX?=
 =?us-ascii?Q?g7QBy46moRu3/SdcD0Ok3tUsnBxEAKo6N6I27TUFaT2EX6AKkID62yMDXdxC?=
 =?us-ascii?Q?uhBErLBn/IIyCf34LfZ9j5t4SsJh/GCerH/llw9PJ+2UcFJlU2a4WUu39N3A?=
 =?us-ascii?Q?Lu42kTfHjt/2H4J29EORUqYB+9BZ6RAQLHERDsIcQBHh1T+JvFL/JUy5+vt3?=
 =?us-ascii?Q?MIA31bNm82KdolbSYW5S1i1SI3XwpViUP7LVLJ757d8X4EdoLorj6OWi8w6R?=
 =?us-ascii?Q?dOz6Q3qJ011ECJ/48XtfMKtq02nnHBut9jf5nmvktAY3xvjbBM3NE/rtWZm9?=
 =?us-ascii?Q?GqYVz21tn459gVDT1zr+lElrx6wsEuv+KgQe3uKXoM9oKzmfhsyeKutRSaGh?=
 =?us-ascii?Q?aMByiO0yr9133poTAWAmWN4qGsLvtqEnD0IEcByc1IraXrp8WSvD+dDOWgef?=
 =?us-ascii?Q?Z0Mk8n5McMcadE63Maf2OQVNfADbEMTas/qXQSXY+RVwsFj4+Rh2DJ8QVLs+?=
 =?us-ascii?Q?PheOx+7etDJpRdGQE0lC8abd3kLtjytncoEdSKID7GjplKKnpA9NEJwU1zBS?=
 =?us-ascii?Q?0F31zAGKguf4IrB0B+SGTq9c7prX09tjWgzrndVFkcHme8tJCh5OLvIys2nE?=
 =?us-ascii?Q?nEhurJlkamIyz5+pYJMoQseztR6+2FgA6Pe2LSHb2Gvs/IofgItTRz3QpisR?=
 =?us-ascii?Q?UNVpOzNOvozNqRMiH1NyHpoKct6Ot+qfzteZv7S36Qrj1LEKfkE+WpQSI0u6?=
 =?us-ascii?Q?cbN9lwLZAK/pJEYD1Lb6f8vz6HwCTip/Yz7uEZP6962uAgXFqWot/KvdbAjW?=
 =?us-ascii?Q?YYf+COYjYSB20T0Ux+Uot3xJtzxRzoAAYTtmW+n1daGxi3JVBJX+6ycgaqTr?=
 =?us-ascii?Q?LUAiJk9BpzlCWDavuTZvw/5xcOhIZVbwrYSu1E7gFVaNryywnvmippYtHPo+?=
 =?us-ascii?Q?CG+mSQHA8vux7U4TiDynKqMmG6XMgSO26BnLhn1DZwQE/QpvdpIDLQDLONXI?=
 =?us-ascii?Q?q8F0PbYfQ6XbgDpCxqG3oQvPrUrrQg9JEXh2tAXV6f2vEdgY9SVN7AFIAuHt?=
 =?us-ascii?Q?kogvWMExAzWJi4VqY2Lpl0WU97e9BrUJNYdpVFI0pbyB01dx2R06DFtlOxQd?=
 =?us-ascii?Q?FTP9SM33+RWcInFWYOmqDEywJCFp6PWU5pW4tOc+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1478b467-4e44-49cc-9abb-08db882fb838
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 08:11:14.0193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ua2RoXCeNuXJ2aJA0kn76YcyiqxHBIC/obT++btzbWWcfjd153mNSStN22KOhh5QjNQb5MdiOu0URb8R/7pUMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6735
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 01:18:26PM +0800, Aaron Lu wrote:
> On Tue, Jul 18, 2023 at 06:01:51PM +0200, Vincent Guittot wrote:
> > Have you tried to remove update_cfs_group() from enqueue/dequeue and
> > only let the tick update the share periodically ?
> 
> patch4 kind of did that :-)
> 

More about this.

If I remove update_cfs_group() in dequeue_task_fair() on top of patch4
like this:

From 43d5c12f0b2180c99149e663a71c610e31023d90 Mon Sep 17 00:00:00 2001
From: Aaron Lu <aaron.lu@intel.com>
Date: Wed, 19 Jul 2023 14:51:07 +0800
Subject: [PATCH 1/2] sched/fair: completely remove update_cfs_group() in
 dequeue path

---
 kernel/sched/fair.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2adb6a6abbce..a21ab72819ce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6434,7 +6434,6 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 		se_update_runnable(se);
-		update_cfs_group(se);
 
 		cfs_rq->h_nr_running--;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
-- 
2.40.1

Than P95 latency of the schbench workload I described in patch4's
changelog will increase to > 1ms(base and patch4's P95 < 100us):

Latency percentiles (usec) runtime 300 (s) (18504 total samples)
        50.0th: 20 (9537 samples)
        75.0th: 25 (4869 samples)
        90.0th: 29 (2264 samples)
        95.0th: 2564 (909 samples)
        *99.0th: 20768 (740 samples)
        99.5th: 23520 (93 samples)
        99.9th: 31520 (74 samples)
        min=6, max=40072

If I further remove update_cfs_group() completely in enqueue path on top
of the last change:

From 4e4cb31590ca2e4080ece9cfa9dfaaf26501c60d Mon Sep 17 00:00:00 2001
From: Aaron Lu <aaron.lu@intel.com>
Date: Wed, 19 Jul 2023 15:36:24 +0800
Subject: [PATCH 2/2] sched/fair: completely remove update_cfs_group() from
 enqueue path

---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a21ab72819ce..8fc325112282 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4847,8 +4847,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
 	se_update_runnable(se);
-	if (cfs_rq->nr_running > 0)
-		update_cfs_group(se);
 	account_entity_enqueue(cfs_rq, se);
 
 	if (flags & ENQUEUE_WAKEUP)
@@ -6344,7 +6342,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 		se_update_runnable(se);
-		update_cfs_group(se);
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
-- 
2.40.1

Then P50's latency will bump to ~4ms from ~20us:
Latency percentiles (usec) runtime 300 (s) (17940 total samples)
        50.0th: 3996 (12092 samples)
        75.0th: 4004 (4919 samples)
        90.0th: 4004 (0 samples)
        95.0th: 4012 (353 samples)
        *99.0th: 20000 (487 samples)
        99.5th: 20000 (0 samples)
        99.9th: 31136 (72 samples)
        min=7, max=37402
real    5m36.633s
user    47m33.947s
sys     4m47.097s

So for the read side, maybe just keep what patch4 does?

Thanks,
Aaron
