Return-Path: <linux-kernel+bounces-65625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C3B854F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068861F2A502
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0D360DEA;
	Wed, 14 Feb 2024 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceGeNUEf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74D5C913;
	Wed, 14 Feb 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930700; cv=fail; b=CpKq2HLPV+ff3d74VvzleWEo1lYdcbICDH0PfFiV/vdhexnLAt67prNKi5D86pv1UOxuowQiMWSyhtEf0JqhPJCgiSI6HcfVyAOp7SKVAY4zRCfQMPBFkrilg14LmpgMKtE382V9H6o/ytHVg/n5SthcslXMcelv95j50l949Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930700; c=relaxed/simple;
	bh=B2h5KlcHLlO+QG71/BYVx1o+rus5RJ5/MT3yCTIpj9Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WuCI/yl7EsAH1SzRPgTNbcE/o9R5sljaIP2L1LUW5NC6RE3Cs75ZtMnmqeIaVPUIOYLRiCZ09SOu6nfbHjdDxVbSaIWy2prmCLgJ79fXnhCQI4I+0yG5MBSbQnAUHeKP4RnEGdDTegvKuNl+pkWPU5iHBC/1UHqiHEzIjQ0N4hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceGeNUEf; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707930698; x=1739466698;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B2h5KlcHLlO+QG71/BYVx1o+rus5RJ5/MT3yCTIpj9Q=;
  b=ceGeNUEf9Kn7sxFtFUtIYPgJASNdt9vCjrmBpdMY5i7vCgYUNTj/rI0k
   IjrQkBNewSSKpdA8t5+egH/CnmBIxF6oyKauY0vOa1/V9KS5IabCBreC7
   32SGNGtv3w3/exHTVax9SLwpGvcw/HpIoo3rThfu3ck6BG0pg/lR4RdTz
   LHtFE+B7ZOXOaXFosbrgKIMltBSmg1XzNyfoO8YBAiWsUlNoqsXJ+XTV6
   0dxCg5b9MBYBYyhRLJhw6T56mE1Jns4cqPUcgUA7tOdGlwBVMnt4cHddv
   jAbKRwCeZKig7GwW2OUt4/u+2y1WvMEkeVFteyIgi+jTcHwl0wGfBhuvz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1861054"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1861054"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:11:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3161278"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 09:11:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 09:11:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 09:11:36 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 09:11:35 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 09:11:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfyJvWcdMsKq6zGP1UWIpAb/nbTBwCyLgff1YIxZHw1BQmjlCnp1KnyHohfXPLuCZdsdw8QonlwZv8PWdW4G5ni+lRUaBZYe01LSIYB+DQ/wxhf1Fgdq0Zzeqro7Amgk2tzNt8DuiDWhhC5o9uhA82DOj9kuuDEZvoo2g1lyKN58JLjZ74V/8Zuy5zveEyDLKWhC2AcwgPB3bvq31Y3pQjlxeAxaNjwLgOHnd5qzZ2WgbyLTegLWHCj2JiukT3yIftH+epK6k8v27rBpNlwnEmg3M0JwnjQcFTncm8qwxXgBBvNUfCWTHUAK75Pr5GTKm6RYyYMIqOdKGvOVY/NigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZv/+H4741po0gguWZoNqCEgbioG5DJxO2ePC/PtPD8=;
 b=XjiCCl2l86DeEPtC95fr4qtWd7vPqywwE45pqkCFzo0cF4fFzQNgUrzb9SmXX+vBhUmGhCqADdFmHjYVvdoPNYDJtbZAvcILVx4W7DM0gcEXUhvrj/+rirkmUjgCqaWD0Kwp1AFNow71UDASzm9iE9dgtFInbCmoZUoxG6YhOiMhJ3vXS0otQ3EV2/5skM/+D9fA0CH5GsluqyiUzbpG+HYbz+MaHN3BfUEaPsaEksePirKuRjom8gb9gYTEc68Y+XV+EbEVB6sHYB+yy/S4rPX2j9CWpYx7P82cAohanCSK2ZeRzS8DWNa3760d3jZG+Z494WDwtNfdZXaESEkxOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB6889.namprd11.prod.outlook.com (2603:10b6:930:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 17:11:30 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 17:11:30 +0000
Date: Wed, 14 Feb 2024 09:11:19 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <65ccf437ec4ee_cc44c29485@iweiny-mobl.notmuch>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
 <20240214121153.00005c97@huawei.com>
 <65cced1753256_cbc9b29490@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65cced1753256_cbc9b29490@iweiny-mobl.notmuch>
X-ClientProxiedBy: BYAPR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ccada1c-7831-46e2-c474-08dc2d7ffcc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PS0KiD59zz1ldt0DqUxx8QWdoNf1r5U1ab+vkaICBq5fqW0LGHwyyMCL8LQ95j0Lbm3eHNfYGAhLcDVb8ilSIreiQPVqw9M+BBt1Vl2F1m8TYMxgM0bvOPwfW0uaiQz7IQriKa3Q+IBYSvbL4eiQ7kCKKD9C9Yt932WiAXehJA2ziHJlw1Uklfngy0uIZzxX35cbGJDu2SUVTMHrriP+btxhhhMe+f0ahZ4RdfI9cjNE476pW4U7S1a7wxSfGRffqFKqsPKl8WrcT1fhhaF232GNd9atnOig9YwdfNYgmZmPx5ZYe7Y6utVUKC8t/Qa/omW7Pb8IX1Z06hSx/a7jYGEuDdBOGj0mLJ5JrpgCuLu9+zOEch4cn1+bgHtHjbRrWosbDaAw69eu36/993kwPq86sU66iq7T4n6L+d5I8K3+BHRnPGSkAmC/C0jiMiUGlJbLscBp9+MojorDOvIxztO7aTGWiIMVEC2O1YxmTlzQ1VS1Jwq8qOI9KaK9bpdn7TodywGCjPUQg1XnGHh8Vp+xEg7CaG26RdLDdI7ALFQIhkYod1UCyWzsVrtfigRlE8mk50MWuEDjUC8huwRUNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(4326008)(7416002)(41300700001)(8936002)(66476007)(44832011)(8676002)(66556008)(66946007)(2906002)(86362001)(82960400001)(83380400001)(110136005)(54906003)(316002)(6666004)(6506007)(966005)(6486002)(38100700002)(478600001)(26005)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SP6La1u3r8rZNUk6ItuBXhmXzJiYMWkha/Otzyj73VLSF5Jz+alKsZk20PAe?=
 =?us-ascii?Q?CGVOY2T3JT2ZdF1Jit644hToYp6Dt1tSl/CZ5jTImXrhbq7983Fon/sxIQWT?=
 =?us-ascii?Q?pGrVsBFEfsN+ttl1wxNddiL+IAr71+ediM8+nXMY9OsuYuXaGpV8Spp32e/n?=
 =?us-ascii?Q?OfNFfi5mhTGvXJIj/rXHYYk3F1TMnVsb1U22T2Hf+Zwse2vDaB65rzC72HP8?=
 =?us-ascii?Q?4gKsSv3GxFLRMrWZynAK35hJXr+ie9raiA5684PMoYkfScfVR24FK/XGWLuK?=
 =?us-ascii?Q?b9jPJ12jRgm8LsdjPJW2fhDuoeYsRgFbwSQnAGkjKJudnf3cRhd7oc6be8yh?=
 =?us-ascii?Q?AizyJfq3wIBnEoZxmoPiy4QJcuW0UeX2sQFYnb0xfgPg2trgRNG3u9VUPjVF?=
 =?us-ascii?Q?INIOQzoXjRrtfdQbfbtSepHak7paCDWzWVTijIJFgtQGDuSHmNPw74pyQZ5B?=
 =?us-ascii?Q?spyIFQcHSux/SkkymsZb8VbmyJGVzt5ZiUq8byY49vtQ0hE9ouY2YnJtqqK8?=
 =?us-ascii?Q?Xg9lTjjovRuE1/b6gaRqSDIO95vU3uGdFAHKitDBanEAq2ZZkEBozOLfOEtm?=
 =?us-ascii?Q?zd2aL1Uj60TWDu1g28jSC/n6kKnjTopqyyU6SNY53qjdO+iRrjnY69FredQU?=
 =?us-ascii?Q?uu+dpL22mgzRy4BrVc2pVU6q4XiPQhW/B0VzLEq1KCpC9pow/AGdgWly+Fiv?=
 =?us-ascii?Q?z56LuL3l5s7DVseUt8i3WmLOJmh8RBXqz7FtOTXEBmKNEYg4b/Sw6L+cCxxc?=
 =?us-ascii?Q?LHM9F1M5Y5NnmbTcLvR7UUEgwFPRcPpcgtpeUrLYJ42WJmBrPUcUJ1TJDsOx?=
 =?us-ascii?Q?cRJyrwd02KDMcx6Y+U1F+LUrcXpZheJ0FzdMvaucxsbXdF3/nBDaFA1ajuUt?=
 =?us-ascii?Q?dnf6HWg0P2xnMzpOZUbLOOalgsr9R7wkUIZ74wUf3yCvKi6LZxH1DTkgXPMR?=
 =?us-ascii?Q?WULMMt8Wrs1MelExjVaT1MkrXjt5By64CK2O49Lpiky/oZ5zTesh1ErBTsKP?=
 =?us-ascii?Q?92AqDf4dzrdEhf0kdsaRVXzQujafbtBcpNTiV5PeVOxSelUZ/I0TVlEqf1+s?=
 =?us-ascii?Q?VQPjML9ek1wq5395qKvaiLyoOctMe22BgkaBv6zbX93WyXvpYqpibIvCTaRL?=
 =?us-ascii?Q?nQkzuGWfd8J/Pz3oIvY735olyKEdvV9W7rOqwcfwVVSFoRSUZihN5Ht6vLYp?=
 =?us-ascii?Q?gi/oiWSPUbGdVydB3YHsGHW6W1fyN/UtMIXUJAA2/v/eAvJ0TlYgLAHhqb29?=
 =?us-ascii?Q?OCrQla1veG2hW0X53AM/tUb2AeNexsrearVYKN+ZXTOgQOO5rmrsUhWVLX8y?=
 =?us-ascii?Q?3DY7NR/oft7lX1XPboTE/km0ZDPZ8alM2mwgAU5P515IARrm7ovbk3PgrU4E?=
 =?us-ascii?Q?L3v1W6+1VVNCO3+sa26wxvgH0ToBsMLZezcmvgz/zJuTbRIfUibMBtpCsR84?=
 =?us-ascii?Q?DjGJficPdBEwOZD6JzRL+GZlKWCU/Ipbp93S9BAcj8mHcqWc3UIv1RrxZov5?=
 =?us-ascii?Q?LfHh7Cxho4xsY7H0TE23nLZdcuXd7OH1+LTAlU/+jiu2WF0m+W93U3KUC1a+?=
 =?us-ascii?Q?f564ld3ijGze9NsIpl/KveQ6m90W3oodhs3w1PsV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccada1c-7831-46e2-c474-08dc2d7ffcc6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:11:30.6461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AX6uVSvMSJPL51DxuO6PtOWaTC5IiGWUCKNfrvJCpYNtzv7AIYmPxTnTtVURRbeFZ1HUa4SCq8kKGhtJ5yryzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6889
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Jonathan Cameron wrote:
> > On Tue, 06 Feb 2024 14:15:32 -0800
> > Ira Weiny <ira.weiny@intel.com> wrote:
> > 
> >

[snip]

> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 9ff8a439d674..7ee45f22f56f 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -2957,7 +2957,7 @@ static void output_printk(struct trace_event_buffer *fbuffer)
> >         iter->ent = fbuffer->entry;
> >         event_call->event.funcs->trace(iter, 0, event);
> >         trace_seq_putc(&iter->seq, 0);
> > -       printk("%s", iter->seq.buffer);
> > +       printk_deferred("%s", iter->seq.buffer);
> > 
> >         raw_spin_unlock_irqrestore(&tracepoint_iter_lock, flags);
> >  }
> > 
> > My assumption is similar views will apply here to Peter Zijlstra's comment on
> > not using printk_deferred.
> > 
> > https://lore.kernel.org/all/20231010141244.GM377@noisy.programming.kicks-ass.net/
> > 
> > Note I also tried the hacks Peter links to from there. They trip issues in the initial
> > CPER print - so I assume not appropriate here.
> > 
> > So I'm thinking this is a won't fix - wait for the printk rework to land and
> > assume this will be resolved as well?
> > 
> 
> Or could we avoid the situation entirely by using a static call?
> 
> The work queue still needs to be created because of the atomicness of
> ghes_do_proc() but it avoids cxl_cper_rw_sem.
> 
> I think the hardest thing may be writing the commit message to explain all
> this.  :-(
> 

Never mind, I already went down that path.  I was surprised I did not
mention it in this commit message.  I did in V1.  :-(

"A static call was considered but ARM does not select HAVE_STATIC_CALL
and in that case setting the function pointer uses a RW semaphore."
	-- https://lore.kernel.org/all/20240202-cxl-cper-smatch-v1-1-7a4103c7f5a0@intel.com/

Should have carried that through.

So should we revert ...

	Fixes: 671a794c33c6 ("acpi/ghes: Process CXL Component Events") 

.. and wait for the printk fix or just move forward with this patch?

Sorry for the noise,
Ira

