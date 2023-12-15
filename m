Return-Path: <linux-kernel+bounces-1326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9819A814D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4631F2099A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E45845BE1;
	Fri, 15 Dec 2023 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ja9isF+d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B5D3DBB8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702658717; x=1734194717;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R6jfl4eFivnXPbI3/VBSiiYnDT5pTZsFJiLqQAqU/vc=;
  b=ja9isF+dtt8I8g236WuqPJ0z6dS+FcmciiFg7B5RLXMx8y12DuuBgfDC
   FHei3WDceYAPg8bq57kzweHaTLB+56JaXE+CzvjKegqY/kMo/WRtXeHLR
   mynTEw6P7Tg7HSXJ2yL6FRAzmD/wK+wenWOSms6HURSv+GVJ4UjWmA95F
   1zCsWyI83HJSoXXZq7Wv0WBTL+9Aa9xdiuDDRYLUsrXfQ9qvmxD27gpDf
   Q8K1Fpf7L4hilsBid7OwRdGA0nha4Gb7GyBjjC3lKfbPLZFwn2APAw/UJ
   OzRBzUeVWX+8wAupO/ujja02DobQ12I5pQn0coPFWbsrb4QFP06Ih1F98
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="374799683"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="374799683"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:45:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="724507536"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="724507536"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 08:45:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 08:45:15 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 08:45:15 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 08:45:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PU6DAfOncc+WlQGrn8WbnBnjOFSZvLTQra/HAuSNAkPsq+VdsqRgfmzkJPqJwc0/IDNguJGTIS1iyvGbEoZO9CTQyxNvepD/Ad/NiTaXV/iXcyoJt8WqZc8/A13eSoE27Vysh4u7HxpBOpbLFQolpKsQ1lVl/AomH3NZh+vpoyJtrshBjSW4YaUrmg5lF2Q5Bzxxdho9ee2dawY8gvEywUJZkErbB41vHMP8sK3UkT1BneG31jPTXrH1Xft2qo4YlPincsQvY+AUGP0o24aqQcr/rJ2JJZKuJPasvAEuUFOhfc4lEb+E8p7HFdPQ5WFYOeskx+q9NKgB6f9lcpmxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPMH0zwAF7P593iqW+kxq7RlPedxetAKPowu+djGYR4=;
 b=G95UT1zlqZ4fUBW/5BLcK+C7g695A5SRyalkfUtOWaZIS4viU3BP5xKV8SYlihxC1CSeoKlEYsY0UTCl+MuL49jzOcM5rnTvSL2Ps6bZ3RvBoodrgCkyKj+SSVqN0aBz1ZvEBlCnIJAJLjgLcCOz1qQ+lT3bms9ku55/2+uPfMRJqoMT7i3I+2ePWSMC4HY5fuPsFCDw3fMC0Gy/CWDyScjsJy/z8+OqOhJCngdu8V2bRYpNqxVQrACXzIMGFbEK5SHcLe+JRRiZzlbnRULsJaYNL5oieSfaWfdqu1/5bhRe0mA9QLZdvMY1/qQfhgfy9IKd+8rUQf6WmFAZ0CKayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN0PR11MB6136.namprd11.prod.outlook.com (2603:10b6:208:3c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 16:45:13 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 16:45:13 +0000
Date: Fri, 15 Dec 2023 08:45:10 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dinghao Liu <dinghao.liu@zju.edu.cn>
CC: Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] nvdimm-btt: fix several memleaks
Message-ID: <657c82966e358_2947c22941a@iweiny-mobl.notmuch>
References: <20231210085817.30161-1-dinghao.liu@zju.edu.cn>
 <657b9cb088175_27db80294d2@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <657b9cb088175_27db80294d2@iweiny-mobl.notmuch>
X-ClientProxiedBy: BYAPR01CA0058.prod.exchangelabs.com (2603:10b6:a03:94::35)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN0PR11MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 171c14cb-70cf-4a26-3019-08dbfd8d355d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sn5gmGHslkRT08A1M1pOO7ybXvNEhhissp1tLkvmVObZ93htiZzKY0jRTaHkvDJHUXC6rQ8SkrhbQBr0bYOSy5+X2/plC/yPt2Ma5uro0XbSyljOHC5ZpZOb7qYzm+LzeyQ7hAzEYqds8VtbHVCWQau8BjtFxNWjGcBwi5sctFCxI3zDcgQF7RvSbyQKbIH2mFAop6KDQWrzhVKKXAqaucArd43ARC7XMMfM+geJC9V2+zOYdo3zr5AiJxz6VpuWqv5XGS+H36JnxCfw7hDixWVLh2bNGZ5/BXdAlHTrS8hu0rJLBQsFXaM6LG1214QnX4auhCG46nggj1mD5h2NnWVWwGocKd3+g0KKRNa9qVyqgG3UM+Urm1x1obUwhjuSnOCkDpCEM4iRt77bFUrwa1w+j6TOoOPcIuoKElXWkcMZvrWKZQ0851Ce11pgiPoA8LVMbaKNDRJgSaNoBwsk5s18hF8fjYG4xJrJZKmfeW49LSW2LzheUnjB8veVW6oeG4BRdBXmxf+RDphY9pTrlVsoK1N7DGmmRWkjFdrEf7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8676002)(44832011)(4326008)(5660300002)(2906002)(8936002)(6506007)(966005)(6486002)(6512007)(478600001)(9686003)(110136005)(66476007)(54906003)(66556008)(316002)(66946007)(41300700001)(38100700002)(86362001)(82960400001)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SML7w0bPldxGWql/etWBXATkK4hl5BCVueD/4i4XVkhrLl2JPbUtogBPcM5y?=
 =?us-ascii?Q?0/Q6ttaVRBDp6u9TQ4mvsIXtnkAMN+VyVO5r1spgTKoHjIjnXRpa2oRoy4EC?=
 =?us-ascii?Q?NjcxfzssDKQIOP5q5jY966lco9BuyRshBP+lT6WrhiI4azJyeJqvqAqGPJ1h?=
 =?us-ascii?Q?07dtqPl5QdQ5sf15Oc1fvc3uSLTW85UeFA/o7GTKb35TjaRV803ESWrhSCLv?=
 =?us-ascii?Q?YlbmGO+GLGMSukg/mPfRrI1gBkcIafQ9V/0l8BYwNnidW0USdHvLbq4Ead+t?=
 =?us-ascii?Q?xgqy3EYhlcJxlq/M1MDQFJH15YoeSaJ5sncV65YTjD8cFGAS1GldGnrUlCjZ?=
 =?us-ascii?Q?ZKOAh1S8S1Xl4XEAxLupgwovSGIfsXir8zW4J1tsNDnQtJc3M5ch1tBWCk9x?=
 =?us-ascii?Q?35g7pl/dEoQ/3Gtu2Z6X9mMi7nsezHERQpPNbLF23Hu4VpAxB2hH8onoJmUB?=
 =?us-ascii?Q?A/h3JYvQubnOhsJPj3D5unoyQv7DiZi/yI14EZtBWA1xGQLkZZyIb4lJT0LR?=
 =?us-ascii?Q?MiSVoMMs8TAVqEhHt+ZJEYp9sQ2rfVjjvbTmwuxhn4DxeYM5MppjlZJsBhxK?=
 =?us-ascii?Q?zaEmFpRJnFzN+vfUYXdAEyUQHqdmKCMb0I0RUNnUuaylZG9IvYF0ChujOFjE?=
 =?us-ascii?Q?RJVwsOUSt54TeabyzQQfwV976CT1UiBqoj2qVKhKTG5vZnHSl5dJ8aBA/B/z?=
 =?us-ascii?Q?KkW1mEtqkYtNDCOCNzJchdshw1g0hinGAFggCNEStxaBFfOzKfctg/OyyI7g?=
 =?us-ascii?Q?iT0xz73baejVcWbmsZh0cXOfyJjuvs5Vdi19ra9ScbWPe+5vI6hhgtIJcVi2?=
 =?us-ascii?Q?X+r2cmw0yPKQClMV9Nwu0eqJR2BFO1qtHyvbaU0aK+uNkDACLlABWkJwT4aN?=
 =?us-ascii?Q?pqaMKpDbbfeEUq0P9GCuyPh0Pvyhxot9P0gXo2s8k/tSZeOCAK9RNV2m+wmK?=
 =?us-ascii?Q?8WJp2XViXUW6Kygum7XeRwHwjbYYdkdUz0F55MHJMD1gGhtNRJRxLGr+ByXw?=
 =?us-ascii?Q?zCrATh+5XM7C5G0dAqWT8ERwmuZ3RoAoAuewBZJkdY9J8fh9bU0ck/glce9M?=
 =?us-ascii?Q?mhf7/14ALpLQenKMNoFB+b3+ng6B6U5oiaT7w+re15KxzWaYCkMvTRJJXKDT?=
 =?us-ascii?Q?6zJqIKmREBJ9V0BtxC7ewSmwLkTQeKxBASp/JWA2emsgK4LKHv9SPqp8nbw2?=
 =?us-ascii?Q?Tg8IeAF3U/w9jk2qreIFh66itPMiiBW/u9kuzBCMxtflKNlHq7lrfnHMVh7L?=
 =?us-ascii?Q?i3u5a3Y7Aj3xADP5BeE7VBFXF+9Fvzisf1ElFxhuSj01ZPWeiynzSvv3y637?=
 =?us-ascii?Q?7UsjWLPcRbbQ4p0m6fTYb97gsgH6mpp3MmKA+Ad3/bpU3Bv/tsyONTbSC+LP?=
 =?us-ascii?Q?nLMIjg2ZeM9mJUb4QZRiBxhIguPuaVimjVmB33HpY49oFuPQ7F8o5fJmDNMV?=
 =?us-ascii?Q?IZYiFnVkOfXSrrQic6oV+J7k/deqnIUlsie2wbKpTEIdiD0fs95OpkE4KpF7?=
 =?us-ascii?Q?MryWq+AqW4x1AbUuxvFCSO7khLOSj9zYlSgBu3soySU3zqiy0co0rB2PhM5E?=
 =?us-ascii?Q?u366faFPSNu28ZyxXONjyuq/1wZU7EEIjF4olJGF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 171c14cb-70cf-4a26-3019-08dbfd8d355d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:45:13.2223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJpHZPW5LSwwb4x8P2MnyOTpXq+4ZTWAyzEkZR9fmZ73AZVGiQjxh8WIjGygPMQO9tZtUP37TMeK/RE47NO6Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6136
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dinghao Liu wrote:

[snip]

> >  
> > -static int btt_maplocks_init(struct arena_info *arena)
> > +static int btt_maplocks_init(struct device *dev, struct arena_info *arena)
> >  {
> >  	u32 i;
> >  
> > -	arena->map_locks = kcalloc(arena->nfree, sizeof(struct aligned_lock),
> > +	arena->map_locks = devm_kcalloc(dev, arena->nfree, sizeof(struct aligned_lock),
> >  				GFP_KERNEL);
> >  	if (!arena->map_locks)
> >  		return -ENOMEM;
> > @@ -805,9 +805,6 @@ static void free_arenas(struct btt *btt)
> >  
> >  	list_for_each_entry_safe(arena, next, &btt->arena_list, list) {
> >  		list_del(&arena->list);
> > -		kfree(arena->rtt);
> > -		kfree(arena->map_locks);
> > -		kfree(arena->freelist);
> 
> This does not quite work.
> 
> free_arenas() is used in the error paths of create_arenas() and
> discover_arenas().  In those cases devm_kfree() is probably a better way
> to clean up this.
> 
> However...
> 
> >  		debugfs_remove_recursive(arena->debugfs_dir);
> >  		kfree(arena);
> 
> Why can't arena be allocated with devm_*?
> 
> We need to change this up a bit more to handle the error path vs regular
> device shutdown free (automatic devm frees).

We might want to look at using no_free_ptr() in this code.  See this
patch[1] for an example of how to inhibit the cleanup and pass the pointer
on when the function succeeds.

[1] https://lore.kernel.org/all/170261791914.1714654.6447680285357545638.stgit@dwillia2-xfh.jf.intel.com/

Ira

