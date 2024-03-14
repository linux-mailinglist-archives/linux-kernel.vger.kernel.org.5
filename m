Return-Path: <linux-kernel+bounces-102786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9015B87B744
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C42A1F23032
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EAD9441;
	Thu, 14 Mar 2024 05:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AQiDwf8T"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB688F55
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710393722; cv=fail; b=aIYmKnA4J0F3hHXktKfX24csD2KAUaPqBfS7vcOxI4cPAif5QZnXG7c9tBH0cseIa9kEaV0kTy0Ofccu2KNPIwt0DAgXGT1jzKQxRhLtFbulOosR+SuWIAocEBi5UyKc+wD6GdcwWfOT+9FdwJN+izJvWtM/kQWFGY8vkr10IB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710393722; c=relaxed/simple;
	bh=0/8fUwbNM+En3KpwvKCYraquGihOVyCPGtyyDQlXDsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u/QPp9eIIfDelHGELapmTB+Yv+WPLhtGLQ/a70xEYVmIIqpC98bsjs9pDkuHgMa8hfMGUBRjvhqmlGuursQZ4zRrWNcwA+xsNg4mWC9jZeh4AYfpbs1X2+afp2zMo3WA7+98B+7dkF2X2WD8BjwDZCJSbY3yJHOODuYdyTzg+mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AQiDwf8T; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRMOe2yvd0ydcebM1SL1W1kefYEh/KJfwwAgOrsR0JsvZ0QFpHf27HOGaR+BpXt3Ft4SmLtaEfsEx46NPenQY7SkgAfxx66NAsXHQwUoYq0DkChxkzBroL9Fat/OTV9H/IsDAH2yt8pvjFBVy1Geyg4U2WQPOpTEMoSPFAUu2haTT/gyTAB0zqSujO0eQ2JYnJMghot+1M/szWkz5fWDGKdmX6DbqcCh+Qiy2h6RmPwtn0DfAlfPp9a8mNng0DWYWMHvDM2hFVAPQ6tuG/fdnR+dLO/kgC0s2/wzmL/0tQ3TVDrON+X4KE3F+2xcEju/pgjb4rpDLdu1lpTBZK5E7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPEQCl/MxWlI4BIP2vXP6psvI60OrLMhB+BRm9smHVM=;
 b=aTR+m86wPCQYxkBvU+fYy9BaI5mbI5lyqpc75p8bBSAlL+7js7GZ2Edp4v0QidcOii/o2AwryJJvyOOyqCKaDwX9AAzrFPRAvcKaI8vg4JHliHLBdQgaC9mdUMKGIFE9+q/KGn6xKdUUyJTDp+VyDYYk/vI2OndkbZ09pGVDlo/WeKTcSOPuLmJvXrorvqY8AUN1csb66AijjZNw9i3L6Ovl8ge5Pqtq66cXa73AxpiF9fAqFonm+sUMQ7p51iVPHlbW7rroZ8axFwouEjsewsw4IMidRfZG5Fp0gc/NtSh2jB2MFfslcMlnSjbG5MamoSdYVpVVsWDJ47se++he8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPEQCl/MxWlI4BIP2vXP6psvI60OrLMhB+BRm9smHVM=;
 b=AQiDwf8TxI8qWU3/uOBCBya9aFOBe47E7iD1Lg4XOhNoDeyHYh+WfqGNAbatXhbEDVETsyOGwwFlQ/GFhtgH+KCb5xOpHzAohAHZRGDgh7xHPvIKj8+0lNn4LFpJkIdbMwMX99cGSmrUZrTKlXgaN09gQhMl/NYNsBA69JukOLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 05:21:58 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b%3]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 05:21:58 +0000
Date: Thu, 14 Mar 2024 10:51:47 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: Re: [PATCH 04/10] sched/debug: Increase SCHEDSTAT_VERSION to 16
Message-ID: <ZfKJaztM0FhKRmjg@BLR-5CG11610CF.amd.com>
References: <20240308105901.1096078-1-mingo@kernel.org>
 <20240308105901.1096078-5-mingo@kernel.org>
 <14d29fdf-ef10-48e6-a102-f1f0bb27c181@linux.ibm.com>
 <ZfAoEmH6KRhjyUor@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfAoEmH6KRhjyUor@gmail.com>
X-ClientProxiedBy: BM1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::18) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SJ1PR12MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b0e53e-231b-41f2-e933-08dc43e6ab6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TO0f1sP6F4FgRySJtDUipi4sbgOtAaYBrnZE6YWDyVUrLUjYm6vJ1EXcUmaHOkOQ6JDsCGUy3evvilMsJ1RRIelqM89mUHnq/IatJUMhh7r6SCTRLhTKqmTnGefSW2da6hEyUW+Q7kpOtX955gdd8DvNQwuv2mIt8EBL7SK/8tSd0tR9GRw/6DK7wi53BAeml2v+MplbYFiu7mgJjIc5WV026AMtb9olxtJiM73E2dxJSJAWXj3q0zcdZCMG7tcNl2a7HLhtRiXz6wvXRtEhNSMkLx8Ahj+HxBnSR32mqqXRl0dIsmrTQVDrIxTRZLur6rS6XnU5h7g0h/l1aWW2+w612JsUt7Gc+HMQKbtvc5pbZSfzrx0/XNbmp/N/WiET4wb1XJ+Cku5etpaH69unUmFSl5JM8/MuUDZHl5mIccAa+XH/4DLYaisK3fIB2NP2oTkPd13Xd5+vc9Eyt3YVdItgQh8WyzL8OggFdSiL33aS2/nKP3uVvnG3zsjcyvzkAezoZIMvwPYYJ7USOvrmm54AVBSq5uZnmFAUMRlS7Rg+rbdzZFMs58GWVSCamMZLyoSHoyIhC/OL0vj5Lo4ooKYuNgNM2DoN7481Dtg2pOnLjIS3yuoPnOStCV5YElZQ1cCuFA7skbtemv5MuJpHYb5S+DftPoZI3MUCfuL+nTg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pooXCDhgs6YsM3hsmMdU+2pTNIb0bdv1QIKMx/Skj0xUemR/EKMncrPFTVmW?=
 =?us-ascii?Q?wmubk4wdgLP6BKu1DSCyWhm0JO3j3MIrH8jpQTdk3N/bzhdj4+1O5POuzFiS?=
 =?us-ascii?Q?XJ4rarTyoMn3g5ODlLiq5ghXM342KqwfC8Ptc947u6a0cWHcsR/+9mAdAf/F?=
 =?us-ascii?Q?W48ap8TCbIH20HOsL7iml48c3s+0j3TyMQHyqoe0WPTutUV4yx4S2LF6Ih7w?=
 =?us-ascii?Q?hReV96rqIqrM2PZnArTEhycPMJyyc7H6+t8vGyGuOBgQ3xQn6wp933m893J4?=
 =?us-ascii?Q?z+o3nCsE8H0edc2wP2BkHfmQYFq0adDie2I97WN+IF624qIK5GgUGpsfRSZI?=
 =?us-ascii?Q?CLiLKZKgxydLpgbCk4k6MZ+GOE4OFd5UHcYFt8k2yYB0nDYgaJmJ2UHbLdDJ?=
 =?us-ascii?Q?EYa9ufH8ZDqDj3u8NFpEYKkQ4jK1FN4UuYZLuxJCES6jE8BPH4M8GWp0R6bC?=
 =?us-ascii?Q?d7wJpBFpbS+ih8c37zj2OyExTEWe6qoCi2GogvSgjZwFSWvYsdclek/acHVC?=
 =?us-ascii?Q?e+kPSaSD192xlg8gGVnrsdOygU86M6jFWORBDPNzqCHbrIQrQGjJY79i2sEE?=
 =?us-ascii?Q?+5pYu5bbg5ijCGcxuTX6XDDQ7d9rnvyg0CMYCMkiELzQ1E3HRC3CDxkQ/bMO?=
 =?us-ascii?Q?H7rkV7bPBEqFjPKpEx9H552YdkCmbm2qgKcwGOgQs+F9AZ9z5Z8b3RRwelWg?=
 =?us-ascii?Q?JPDJfWO+5Tvt5dB0Q6hoHOOHFSW+hJxyWm7r37P6pnS6omUWOSEmHEdELJRh?=
 =?us-ascii?Q?WBHBMb+r0SKrirlS7+bHFg34rbfcJElG6PQ5ADtuLXVyedOlXzhi/HVksC1W?=
 =?us-ascii?Q?nQ3YhRjYp/JKzxbBTVrDztvleZaX4QcVSD83hrFcWzJJ7J26yKmyto0Ggh7D?=
 =?us-ascii?Q?xd871OM9OPq8o0jS4NSjBEIOq6S8iOBQZUFtN63FqoSUBU9OL1r90aKxkt+L?=
 =?us-ascii?Q?NKtFOnYU9iCevcxFdvhFOptGfkAvrfctl0t1UyAj+wC6BTUmdFfqpIBE7C2Y?=
 =?us-ascii?Q?30WdkcSjAHVEFulOYTxC4PzjiRHspbMAKYVEL8+A9+S/amUhxjOjVs08Kw9M?=
 =?us-ascii?Q?tCU5LsnT/Ezl5zQFFJCFbWVWSkfbkpfiWey2P5gN1MBYeA08uExnzOiTAFhP?=
 =?us-ascii?Q?HHmTdk6VWZ3RZf4bw+kWFDyi2pGDi6amRiRGLUfa0efZbMi08mkJOIhFb8GY?=
 =?us-ascii?Q?ZFD949kUI6XVoFHGWbIq6EwJCYNKRmSUdfhv1zuboTp25fTIZdk7F6lI0aRq?=
 =?us-ascii?Q?IiAxv5dtV9d+wmhACpTt9pVc0JehvpGvlgLl7P2QkeVw9TtHLiHb539vhL/A?=
 =?us-ascii?Q?t3G4t9tCXmnTRdcoxYcbjoesYBRmc06Yl+IZtxUVKLFU38ASNwwwMLQaoHD6?=
 =?us-ascii?Q?NkL9FHBE3uX4r46dvbyafhFOzK8aiNHjPDZRKhin8sNh/VbGF7eDjZKQ1Gcq?=
 =?us-ascii?Q?ZQp8t8OOvyNLc4cG5wkf1RqDa+lFGPYJRTKMbMxXBgkTbdKEHLQFpWaKu+nd?=
 =?us-ascii?Q?HQbBXy0iX9B2dBPeFh3IMqkOmE8EvsYHqHmVnFAFfk8vP5yXw3HU70B9ny/L?=
 =?us-ascii?Q?BB2tfWdvmEMRHJ9pjPMAn6o2wHqy30dyqMFA1DE/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b0e53e-231b-41f2-e933-08dc43e6ab6b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 05:21:58.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcDy2a0fSm3xzUqM6okvb614L+0E0dTWaD7z/GatzoBG3j+I6fOz0tLGNpMsM5v2Y3mDFCaGR6x5dkyqdFMWMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124

Hello Ingo, Shrikanth,

On Tue, Mar 12, 2024 at 11:01:54AM +0100, Ingo Molnar wrote:
> 
> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> 
> > 
> > 
> > On 3/8/24 4:28 PM, Ingo Molnar wrote:
> > > We changed the order of definitions within 'enum cpu_idle_type',
> > > which changed the order of [CPU_MAX_IDLE_TYPES] columns in
> > > show_schedstat().
> > > 
> > 
> > > +++ b/kernel/sched/stats.c
> > > @@ -113,7 +113,7 @@ void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
> > >   * Bump this up when changing the output format or the meaning of an existing
> > >   * format, so that tools can adapt (or abort)
> > >   */
> > > -#define SCHEDSTAT_VERSION 15
> > > +#define SCHEDSTAT_VERSION 16
> > 
> > Please add the info about version, and change of the order 
> > briefly in Documentation/scheduler/sched-stats.rst as well.
> 
> Good point, I've added this paragraph to sched-stats.rst:
> 
>  +Version 16 of schedstats changed the order of definitions within
>  +'enum cpu_idle_type', which changed the order of [CPU_MAX_IDLE_TYPES]
>  +columns in show_schedstat(). In particular the position of CPU_IDLE
>  +and __CPU_NOT_IDLE changed places. The size of the array is unchanged.

Thanks for this change!

Since we are considering bumping up the version for this change, it
might be good to get rid of "lb_imbalance" which is currently a sum of
all the different kinds of imbalances (due to load, utilization,
number of tasks, misfit tasks). This is not useful.

Swapnil had a patch to print the different imbalances, which will
change the number of fields. Can we include this change into v16 as
well?

Swapnil, could you please rebase your patch on tip/sched/core and post
it ?

> 
> > One recent user that I recollect is sched scoreboard. Version number should 
> > be able to help the users when they it is breaking their scripts. 
> >

> > +Gautham, Any thoughts?

Yes, the scoreboard looks at the version. If it doesn't understand a
version, it will not parse it.  It can be extended to understand the
new version, since that's only about adding a new json.

> 
> If it's really a problem, I suspect we could maintain the v15 order of 
> output.

I don't think moving to v16 is an issue.

> 
> Thanks,
> 
> 	Ingo

--
Thanks and Regards
gautham.

