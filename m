Return-Path: <linux-kernel+bounces-53059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C31D084A02D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DD41C21AEB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145AF3FB14;
	Mon,  5 Feb 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWztF6NM"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695233FE46;
	Mon,  5 Feb 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152696; cv=fail; b=eLpuoCte0z/vcoCeo8kTj153AguKEq0iWlbqXm0+XCAsMJue1Go0V3Q7X/ifyS+xm6uSMlNzOknsKv6mIjzCrtThjV5FtJoB7U7q4DSrtDOlIcWjKyQuI11W+w14COlfHMSuWtbmoJD/KwuF9W/0uO7O44jrUk6OGIUCOT7L2Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152696; c=relaxed/simple;
	bh=F+Ez3BEIO6+MKSg9di3MauS+WILU19VZF+pw9fUUR4w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j9sA4Pz91s9Y+4GM0/+MWLg0/IOQDRuhjZtXrDRaQdySItkRkJWYX4upDtyUGNgXNygn4NwUbSC9ieTkXCDYe0Vrosv9Nm67XZd7Dz0Wt+Jao5SIuzXrLlYkjaG/QKurWAMSZcZTaPMUl7BjWhv8nkQXOiHwAVtDEBdoE1hGouw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWztF6NM; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707152694; x=1738688694;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F+Ez3BEIO6+MKSg9di3MauS+WILU19VZF+pw9fUUR4w=;
  b=VWztF6NM80CE97EV+ntSrivQUYov2heqOw2q+OhoQFJ3YQhLxW49nSJW
   7XJbGIOBO3QD9FZyR2RtyW0/2MeryQDq2pg3SBa6UNeaQ3EvdPvy7SHdu
   muMM6Zantb43Pgd3PWR5YG7QL4z7BTDLvu4PYNH0mQnirm4K95JPrEfo3
   B+t8GozE88Adnq2BMpTwqgNqwoXkxBwbv+rW5eQFVnJDXOUp0/erz4gQs
   WVlt+J1q7wOQACfj+ShTOJUDfc737ljOQHtSvDendY3fg+U59yn6NSc2h
   bkINKZhiRdaYwIZsqODSDn+d9V6mH7CeJAG50W1Ote+L7J6zGDYP/cxWp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="394983878"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="394983878"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 09:04:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="788284"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 09:04:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 09:04:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 09:04:53 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 09:04:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lISIRt6IFXCbgrFITsNf1tFPg/8WKCDa/Vsli6j2OONpvf3WshCLsJ4eT+NRV3DiiXYG4vzsT0Rx/2n6WOYB2PDw9bsGmXbzJqzifRvc4ZOtLBIxaZOmnaqpo1JeAb2a43vYQkKnAzb8RqO/AvaWfuECVhCgmf6icxsySc1BRyCUjinjVaV+fZFTV/MLwVyTXCkWNZnduUUV7BlRk0RWJZz4P5UJQgqzJF80KMGfYi7kB5Qi0ixTcLLPxTOCWNeOjDvB/mONiteVl6cWHL7hv5pejE4V+ONfSceFRt+TLAKYrNJg831m/cDQ6AXwp23VpitPqj9CXsvT3dvKf8aqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRK98eAHgXGZf0RgCJ+lwqSnxkAboRehO6oQpRgiESM=;
 b=VplaPsi70/zXANZoAUFMiPGsNZrVpZwe4N3D1Bl4slR0hyuOhrCc2wNtwMZ0ZpcA2p9hChDVZQ9ObIHCPDNx+JRUYoLddF0EUEQuMTAGeHUComYqFsfGMp359EGiOr+SCmDOZuHagWIlsTUafrlJPgP9HtDcugkYeXlx3JmNQbrxPAB8fwLA0FIvdadLxU/6fjtlBtc9ZnosTF623yD+m0L8c5OXknlWx7AHM+c32+dwUc4e+KjJh60vX0xoUQA6nudyLkpvOgk0xBGqeo2fbO5wgMa8TYNtJ1k58AwuLU1GgzmhW3mGGmRUasgsND69uI6qONlloD+qFh/86QHPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV3PR11MB8578.namprd11.prod.outlook.com (2603:10b6:408:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 17:04:44 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 17:04:44 +0000
Date: Mon, 5 Feb 2024 09:04:39 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	<linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, <linux-cxl@vger.kernel.org>, "Fabio M. De
 Francesco" <fabio.maria.de.francesco@linux.intel.com>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH 1/2] cleanup: Add cond_guard() to conditional guards
Message-ID: <65c11527210a9_36bf7d2947a@iweiny-mobl.notmuch>
References: <20240204173105.935612-1-fabio.maria.de.francesco@linux.intel.com>
 <20240204173105.935612-2-fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240204173105.935612-2-fabio.maria.de.francesco@linux.intel.com>
X-ClientProxiedBy: SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV3PR11MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: b4643dd5-4bdc-467c-3253-08dc266c8cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3g//6oVhcoXBNSsY5ulMJCn8pzdQo4ANzeaQks4FvJPw6kCKU0qHmCNqiO52HAJPUAogQOfkT9MTqRL+Q/I2OCipcRsviXJ1wJRhzBzj4vzHUCDdeFIDcaepZGuywiQCWAEgKVc1cK/gSdbR9WdLD9Q0fN+tZburl5wPTGDSw2CD649BXV4it87mdA+P5oj7OUWBvRw6aCaB2eEnvv2BKQ211cnPqfGQrsyIfQRH8zMd6FsKeCQZLh3woh6ECZVcuur/Eg62xSoz4P83bfk1byYDUCI/PnkLYbp55yyOw+N4xIUko8+FqsokAVBoTTq19FNB6Uw4RqP20eqYp/7XiGT6FwqCOrHBQgKS14b7uTIF9/bIZylJQNQ9EEloQHr4KwEBNPjl0Ef6pqQ/cIDrZiZVBa2ZREMHoi+Wavxn1KE/matAcVUA8Z0KZ9kIjAPoHxQwNW9Z3wdWoTwADkI8UzQ9XUjZntLg4wmUvnhMi+gztndrbWD8VmqyaeWEgQsZKOj+oPV9rIa2WlID6gRTTLCe8WkXOqkxNkd7m7REH1kwtUGWUevOWaoKHfe8VPaK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(44832011)(5660300002)(2906002)(41300700001)(83380400001)(38100700002)(82960400001)(86362001)(26005)(6506007)(6512007)(9686003)(110136005)(66946007)(54906003)(66476007)(66556008)(6666004)(478600001)(6486002)(8936002)(4326008)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qAoS1Nck8UJMPjDEd/qRPDc3kSaKg5klLuY4/oqwdfADsraeZIiACfDku1eV?=
 =?us-ascii?Q?XpxMp1aApDIt2mIczNAByoc9qrb4zLnu4cZpwnUtqQ0zYgsLNpYeK3irqU1y?=
 =?us-ascii?Q?JvoUDw5onYC2+Tos9/fgp6e9y/Bu84FaTS9kQ10W31CQBhB7gzfSk8uRRD8r?=
 =?us-ascii?Q?hdODMqFFwR0EW5OJiRrmZpY1jbpbIJfpEc4MiuKvjaDs1+Q8SmClVI5WHCYx?=
 =?us-ascii?Q?xigP2MOm3mswwaJHsHlAXcfraU74KhoMmjOD8kAOhKE3FknvwsQl20pdW7fA?=
 =?us-ascii?Q?sHVFsoql4tl8V+xHBYRfBv3UJNabyUAt9lhKMpXzmrV9Jh3/nw86wpFIE2l/?=
 =?us-ascii?Q?4wLndA336ndZitDW6fcZ8r+gIw5O1mxC77xr7FzQ3os0meUXPk0T8HD5RLAr?=
 =?us-ascii?Q?eETOhT1wFJsu4UZm7FabvfHnTs/QFIy6LlDqiIZdiMZ+S9mFIliygRMU/3uV?=
 =?us-ascii?Q?kxzLz7W4TMlN7HRyX2t7qaSD6r0YLkdYk6598Qol5FsKobp0UqhVsh7zQh+6?=
 =?us-ascii?Q?gnMmDjhbjrVooNb48pJdZ9/x/A3C0SjmXIdFZEKKmjoqbfz5WGMxnWCtXIGk?=
 =?us-ascii?Q?0+wF+gYYVCV9QEe0syaiw7HFlb9izrAN69iR2NKAm7ZTc/wi+DUys8Eb0xRL?=
 =?us-ascii?Q?tCEJEmhumyLEcw2MbuAk3fC2afO+s8FfJODJahbsQx6Dop/qP7aY0UreRN7/?=
 =?us-ascii?Q?cx8s0wASFyR/Rx4+LkdIyOvafboBrSTsFD1pSn0Pcmr7EWclF4jKeGfwDBvS?=
 =?us-ascii?Q?lX9J5mt1MolDPmJlhlfbRbuj/MLWe9vJVHlZ7Gj4++NpldwByibcsEv6YEzY?=
 =?us-ascii?Q?+j02QEHvp8RunIR8F3LIdjKwhhNrldlZEXcTpHngCJO4v8Th2r8amlEfS84a?=
 =?us-ascii?Q?cUcYRbYzpgv7SxUvM03IIVRt+pFreRXMvMrUuyPNN27rc10SGURABtNKK8lC?=
 =?us-ascii?Q?bMKSV8pYjlgcO38vKiPfEnXiOdwhJoBuDqXmCwf2ahLBoNvu/24aPO5H6OJ3?=
 =?us-ascii?Q?Gp6HSyyy4R9kqbVqO7p0FHWSintPwXyODzC+HD1APR/HMZnbsP+Koj+IBrq+?=
 =?us-ascii?Q?xEGId5vNCrmwWrJ5tUibOTexGvO18UksDJCX0ywKfWAtu7pHee7ufF5JkVeR?=
 =?us-ascii?Q?ALyg5mDScafYjzzpVF83hXoxmzefMoRBLdg4G57YNIECqtWyobpLwEps1nAM?=
 =?us-ascii?Q?UGgdqPVdpICMma3cKACTGzS2cUetWx3lqGHFwGxeb2D0gzyZ6XWLcc8aGUc0?=
 =?us-ascii?Q?P+RWZ088Ej2H57UZVjQ4U/5Wg64V8TWvfWEP21J/9vmHKg0Qn9F4jXaaUkxh?=
 =?us-ascii?Q?UPyUArlKb2O/n7b7xJZO9mNr4aKz6/Y2kUzjrA2Kt1J3AMAmROzAvn3BtA+G?=
 =?us-ascii?Q?IaMb67hnjAyUY74n96w+uXmXjB/9Z3QbR+cFvsuzA2lWCtojjThYkkaIbYib?=
 =?us-ascii?Q?GWE8fz4wMlYawLKyn5dhplR5QWRcH9bT8g55Ds5PqjLR3vKM30iQPnMjOQkd?=
 =?us-ascii?Q?JcbGS5+uiO90etJKSwTUmOi/1gpQkR1TUnDRmMvNZSKNBrEETeEkwXtb9e3e?=
 =?us-ascii?Q?3JNvpjPJGFkCRPkgpb53Tp3gHc68aDmvmTVxI4SU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4643dd5-4bdc-467c-3253-08dc266c8cec
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:04:44.4984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlcwHk2UC55KwxQ57O2YnIcRqkBDSG0sj4PSEjyzBw7lpySrr4HOgMLsafVFlxneovK1x3yYHfyKuKowHdcAyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8578
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> Add cond_guard() macro to conditional guards.
> 
> cond_guard() is a guard to be used with the conditional variants of locks,
> like down_read_trylock() or mutex_lock_interruptible().
> 
> It takes a statement (or more statements in a block) that is passed to its
> second argument. That statement (or block) is executed if waiting for a
> lock is interrupted or if a _trylock() fails in case of contention.
> 
> Usage example:
> 
> 	cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);
> 
> Consistenly with the other guards, locks are unlocked at the exit of the

Consistently

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> scope where cond_guard() is called.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
> ---
>  include/linux/cleanup.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index c2d09bc4f976..3826e8ed4e09 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -134,6 +134,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>   *	an anonymous instance of the (guard) class, not recommended for
>   *	conditional locks.
>   *
> + * cond_guard(name, fail, args...):
> + *	a guard to be used with the conditional variants of locks, like
> + *	down_read_trylock() or mutex_lock_interruptible. 'fail' are one or more
> + *	statements that are executed if waiting for a lock is interrupted or
> + *	if a _trylock() fails in case of contention.
> + *
> + *	Example:
> + *
> + *		cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);
> + *
>   * scoped_guard (name, args...) { }:
>   *	similar to CLASS(name, scope)(args), except the variable (with the
>   *	explicit name 'scope') is declard in a for-loop such that its scope is
> @@ -165,6 +175,10 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>  
>  #define __guard_ptr(_name) class_##_name##_lock_ptr
>  
> +#define cond_guard(_name, _ret, args...) \
> +	CLASS(_name, scope)(args); \
> +	if (!__guard_ptr(_name)(&scope)) _ret
> +
>  #define scoped_guard(_name, args...)					\
>  	for (CLASS(_name, scope)(args),					\
>  	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
> -- 
> 2.43.0
> 



