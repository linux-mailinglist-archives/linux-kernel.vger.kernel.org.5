Return-Path: <linux-kernel+bounces-53291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C8184A31A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07ED1F22531
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ABE54747;
	Mon,  5 Feb 2024 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyYq1/1R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D9C4F602;
	Mon,  5 Feb 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159779; cv=fail; b=DjhR0270KUQCCQ55kxNp2oEVtp3PrrY/CT1IgfBpoouzgbC2+hrzz12JqcgGLux8pi6ZL6SrapWNY0i6CENaAwdjVsuitddxLVGxeJ+ZHlIf/XoW7MlErMoX6f4WryjF1zdKp2qU6L+SzUpm952lgVdnfQSFfDc0VfGtOwFyHiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159779; c=relaxed/simple;
	bh=X0kRIM/HAbM2zf5u6XIORlMh5nFkn5t29eYmFJ5awHw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rHKLthUcXbTnbKIhGZ2IHdwV2FjYYuXzbd8LaInJ3i1/i5F5HnSoA0OvOxSaK2VJRmExrJW7uvuLexjATnbRD33HWao5Um2sryD6W19+ERo8Dfk/n35CkKg2c/g+wFrQ9LAxBv6qInmUYmQHyE6l4QfO/M7BblJfLJ4xwFbiXAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyYq1/1R; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707159775; x=1738695775;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X0kRIM/HAbM2zf5u6XIORlMh5nFkn5t29eYmFJ5awHw=;
  b=kyYq1/1RzUf+YdPr9QYXLPuO3ZUhV9aCv1W1uWOYwUDaFzy79dxTJ9hh
   Je80yYSL+vDAoJ6A8TakFZO679SW4ZTvMzG3AgKmVzolLNXOm2LMHXmzp
   TOyo2te70RZb/bUtdacOB5K9TkIzIXE6FJXLyqhX4a1yVtXG4vgejYlu7
   f1eiwAQE1xzocVaz/C2+gQi2szG9nDMwPn/N7sY/aSuNkxl7NSrvDQmbL
   2MJNOCGXN+isi7kEV/EZqpIJJabVAKqHc34XEoE5Ys5X4MMxhQq5jFY4Z
   xbHU1p/HaMleVR8mrYjL6q3udv0tKHX7IjVQwYu6qM0nF5hPUYBx0dF7k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="736929"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="736929"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:02:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="1134332"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 11:02:53 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 11:02:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 11:02:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 11:02:52 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 11:02:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK6kKzoLBY7bhKzmO+5XOJBZiq9Lmgeg3S617VeOQECQi/LojmraaV7WkxfrZl2GAIh1SmzZpbAXScc0s4+NSVdFBfKspApwiaNG9F6aknWTL10PS4Q0+hwqtRuPRry+OO6EuIh2SinGk9v8OuTJHBESLjlv3ks0Dw84/tUmWYharh40+IcRKn7iNrOF3z3zilGR79ode8lRR2Lxehw4NrzRKSgRAujhzh1MEBXXm6r3rP7wktbttQoQvb2QUeo0ukP1TL8OWNoYj4MtZCwQQQjsoQvTyq4GXfrqTmtijMRmjo0yKGw4Q4nxmyxRBe1o+UQMErfJV6vANwVt/Lueyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1eOcTjOQayTFG1+AWLYz9XDGLbjKnLzdoDn+srhnps=;
 b=LGHUaXFiGUKq0Wb8zpaK9bNxKiVAi+1xXPrpqCHvjaGXl0U6XPa1P/cZ4z8CJyPTL9IwwUDmFXTLXauABKFgqXtSB9hqUUDvSkuA9JnC9Xc4TdO7PiJySXKaDwFIKgAYW6jGTEnOgf0gmM9MlGAalFvOgXGQTU3gBjYJNGIBwi0xTILIV/1o2QFXNa92DdSds7UTjrZJRSi2Fw6lXv0MPksP4+gwErUirUrQVu6R/6ZRc2LKEAauMORwut8mlQ8gMzK/4vbul4aMLyF4/rh983v/D2PrvLVprUFKLzH/OAOp46NvmMM0MsxxtVrITBC54sHCt9f1PEotHzcM9nYqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV2PR11MB5997.namprd11.prod.outlook.com (2603:10b6:408:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 19:02:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 19:02:50 +0000
Date: Mon, 5 Feb 2024 11:02:47 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	<linux-kernel@vger.kernel.org>
CC: <linux-cxl@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH 1/2 v2] cleanup: Add cond_guard() to conditional guards
Message-ID: <65c130d7c4c52_4e7f5294d3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240205142613.23914-1-fabio.maria.de.francesco@linux.intel.com>
 <20240205142613.23914-2-fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240205142613.23914-2-fabio.maria.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW4P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV2PR11MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: c46559cc-b4b1-40d0-f283-08dc267d0c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzkWOBaK6lk0IEoYW3/lLrhQc0mviVaz8wNO4fFhPxCu0APRPCNjgJVLUoZJnWAoo4rvVB/nOVGhUON15Ge+YIxviJxhw96EhMv3nWIXH3nVaihAy8h6pL0+VRggaHXCmWkyHsKjTb1jANepMMAzL4kEIDfhEd/SzQp2qfG/4f9blEQ3efwBzgai2IcNJXNHXFqcrNkYFA6jZuy5s6tIeOHcZGC9as1+yBH9wz3KvrXv3lPrRdySF/sIHY51O0WzyGl4qmqYy864TSWbICZxBmRHXNPyW8n5qKqtSywtXhbw1xDJSkOqsReQ1EuQRV6xsozdojqXjA9A1gv4nu1ClJSdiB84JpgXpnWRRVEvmz7mi+NqhyEPaRDI5D9R1f/+wpq/4uaVqozdMgGxVABIHM4BwbtONoqfhoxYnIBjxwiS5LPxcm/Wg3aINYidNbUSulSUAxARKTYP6873OEYIeKosWXi8J3xgiquTb4jPYLJ0sGczoisdCvZ75dLr0GoweKPlyzoPahLz6p3f53q7mL6Kw7b+1LwsbT+rI2JonmlTh64MtetYqfZxIBj3JbMv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(41300700001)(26005)(2906002)(8936002)(38100700002)(8676002)(82960400001)(66946007)(110136005)(66556008)(6506007)(66476007)(4326008)(54906003)(316002)(5660300002)(6666004)(6486002)(6512007)(86362001)(478600001)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?06eEKrimz0dISoiQzINoQGIU1jlgiCk0g5QmKSe419Jb5ZspxhCl6l8QAuVl?=
 =?us-ascii?Q?PUMq8IGAic3LQ0D2iW8OBYJXXaFCAaEbQw9okV55rvv2lVIh7zrni1MKb8dB?=
 =?us-ascii?Q?HT2zOjrS5MLTBN90TqtfBhdXirVaNF0og6Zisa/bmcHPp/W/Cfhmsm392P6Y?=
 =?us-ascii?Q?8HagNYYySubnxSyoEVUCkzIC5xbZrqacPBak2b1bcSvyH/91RruHO7lOEuyg?=
 =?us-ascii?Q?FvuR4M6kiJpBt8WAU2oVnDpXzirCMGvxeWwrRtWFjCKaNTK8VJZBASyRhUFZ?=
 =?us-ascii?Q?BweUIpFgQVmYHN800hKcSXtsxiBs4Uv821r/HxP8tKAct+0zr53Z1cUiFCH4?=
 =?us-ascii?Q?h3jS4p/glssQrALLCEl1dS0f8+1SPb2vqhp/VwZ8g0WToQQ5C1fr/u2PkZle?=
 =?us-ascii?Q?R1cYRDdUPs9DGiLMl5hClG1ruTRFQ/dxayI/dWQTw45Kw/dyeumkHYabxtd4?=
 =?us-ascii?Q?LepHgP5BCQ8McgzwMQYrRuDziDhlqGa+0U8vrN7yzPL5Lt19/zYXsrepW6tN?=
 =?us-ascii?Q?MVarYgbTpagfRGVt8+rUDClCocL8b3OxWVicO/zYglIV+nDd5B/LfASUPPCh?=
 =?us-ascii?Q?1SyWZo4YZ0cK9smc9utszo5gbR10isMWYhAU8g6KwqwZgbjfExCYswh316Gc?=
 =?us-ascii?Q?wpDGIr9g3RiIaCXnqo5uMMDLH3/2TLsosdUsp2PBKbF3YCEVm8RunZmKhyBC?=
 =?us-ascii?Q?RxO1S+5W1KJ5o7HnN1sIA5WzYadlwIs1f5lMrdEd33E+selfZ7WafLf7QBmo?=
 =?us-ascii?Q?TnY7M1U8OLdKgaRYfKwLW21+z5+rCijly/3Mf0iY52cmGzH1y9pj0iukGMrT?=
 =?us-ascii?Q?iicy83TnJYxkSXNXnWDNXjX0R2SiG83xvHSW9ugmQjrWRl4fS/NTLYUKb+i0?=
 =?us-ascii?Q?7284KOxI+J+ivLiQWWtWF2WaLwT51i7D1Kyb/sZdQmrb8loxztH9g/s00LpH?=
 =?us-ascii?Q?/rvrWzHnjHFBFGeg1mnVBY3/pUokgWM9rad51OZvLE4GzBPTLCx/Gld1foiq?=
 =?us-ascii?Q?w/EneYiRxsTMsbs+x/JXTF0OrgJOYqtop6klbmxFeHZJnK4WG5C/ezM+oglP?=
 =?us-ascii?Q?q3MHWP4rRrfq61R7ps+dtKKLzaBjpx71iypWGkO3z9gJtjLneJyYnkm5eL0x?=
 =?us-ascii?Q?C7uO3n0CLURuhSETdACB/jgnmmvoAgKyx+ACcmrMjuviqWpYC6mqds4DpAi+?=
 =?us-ascii?Q?Q+O8c/aHMgScmUOM4bIPZQgKUQFktAJ6jlANfSC52BAO7THe5Jj3KKZN4hxj?=
 =?us-ascii?Q?GfiPTtGz+L6eETGqTy2S8J7J9WeEyDkdRuE60Ek+uNRG2GRHqKLK1qYHHYuy?=
 =?us-ascii?Q?RdWTy/FHDQHvVMyVjaNjxKqj8F8agnKQaE/XXqj23YLgVi5jYvuCnReXUfpd?=
 =?us-ascii?Q?NoJZhdy7fF9YGeCews4i6gDKjvcOPxqFfBXJgRTnCFc9uVfPgecNGKBqlgXY?=
 =?us-ascii?Q?FwrWQ0928vvHsUfqlO8rBPr5iYDZEZJJq36RY1clcUl8MLhMC++BzOHumxJj?=
 =?us-ascii?Q?sm2oEQb1OVgJdwgMs5fa9vJEhKT1slbEKV2uMccxezIpHjUm2kSjYs2gkkPg?=
 =?us-ascii?Q?xOeRSraXT/c1TumT21cfEMI5iUFDTD4c2pI5nB1JMS5UGMQUB/CwGEbf86cQ?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c46559cc-b4b1-40d0-f283-08dc267d0c4c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 19:02:50.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7s5QKhq+NXbYKP9gotrBjzhIo8dVoXlPtGoUo7K/KG9dWve9/xZAf+3jbop7skZLdzszQcmHciS4YIabtvKcaa+O1MfBghaiVtH2epIM+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5997
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
> Consistently with the other guards, locks are unlocked at the exit of the
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
> index c2d09bc4f976..88af56600325 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -134,6 +134,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>   *	an anonymous instance of the (guard) class, not recommended for
>   *	conditional locks.
>   *
> + * cond_guard(name, fail, args...):
> + *	a guard to be used with the conditional variants of locks, like
> + *	down_read_trylock() or mutex_lock_interruptible. 'fail' are one or more
> + *	statements that are executed when waiting for a lock is interrupted or
> + *	when a _trylock() fails in case of contention.
> + *
> + *	Example:
> + *
> + *		cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);

That _fail argument likely needs to be a statement expression for the
multi-statement case.

> + *
>   * scoped_guard (name, args...) { }:
>   *	similar to CLASS(name, scope)(args), except the variable (with the
>   *	explicit name 'scope') is declard in a for-loop such that its scope is
> @@ -165,6 +175,10 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>  
>  #define __guard_ptr(_name) class_##_name##_lock_ptr
>  
> +#define cond_guard(_name, _fail, args...) \
> +	CLASS(_name, scope)(args); \
> +	if (!__guard_ptr(_name)(&scope)) _fail

No, as I stated before this is broken for usages of:

    if () cond_guard() else if ()

The 'else' in the definition is critical, this builds for me (untested):

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 88af56600325..665407498781 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -142,7 +142,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *
  *	Example:
  *
- *		cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);
+ *		cond_guard(rwsem_read_try, ({ printk(...); return 0; }), &semaphore);
  *
  * scoped_guard (name, args...) { }:
  *	similar to CLASS(name, scope)(args), except the variable (with the
@@ -177,7 +177,8 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 
 #define cond_guard(_name, _fail, args...) \
 	CLASS(_name, scope)(args); \
-	if (!__guard_ptr(_name)(&scope)) _fail
+	if (!__guard_ptr(_name)(&scope)) _fail; \
+	else
 
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\

