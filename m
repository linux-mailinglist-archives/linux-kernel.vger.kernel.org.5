Return-Path: <linux-kernel+bounces-6108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB358194B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA856282611
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F1940BF3;
	Tue, 19 Dec 2023 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVfp3Yy4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3494F40BE7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703029359; x=1734565359;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vwlKZYznzabYV4/1kDaV+FFg3QFLXqMlk5OCLb58GYM=;
  b=IVfp3Yy4ql/l1MFxg2stdheUCNNfyzbLM/rmNVWAqcZufBAyz83ZCJDd
   Twv0gSX/NywYp3S6QkdM4vO9jP1HPwvJwHq59sgq+Kr+weJenXQqpug6k
   95ppXerjFHrfVwExbEtUU9k/XYM8NuuN1mgnGEnHBPyWa1B2Ku9EFGbaQ
   upwyz+EZm+B6F1hYtUnsMmyYJqcn1S52WoOqLvQXubN1BL0fi96W+7HLS
   Py7yr9g3IviI/GqT7jiwuMMOXFLrBjZuo3zEnOowWKv1aT+qrcY1Czr+Q
   PYkoy90DiTpj1H8VZhosII1744W6ALr4mkn23xZGJp3bm7lDyKabpFnIk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="375887365"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="375887365"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 15:42:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="810394667"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="810394667"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 15:42:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 15:42:37 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 15:42:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 15:42:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 15:42:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0PpOiqfm++QEukpb25BxCSm9kAC/pQ9v92Gb0qmDaOe2R42rUfK0urTlRA6SEMEdPQjYg2O2FzV2reO7A8xrtLRHiXUppDMDM1B++NpDqa1AVCqEvZ+Nw+fHiw0NrVlUijMyJ2kpHBqNZIObbVG/wg0QT6iPTEBfScE23ofI8tdR9HwH9NswqhwAWBQgz+TD+NNn2tdLOstvunA67seBVEiX/Vo89WWkLdyh3VjBdXsXwFC2VcWhn3ckzKv3/2G7pcD6HL7eonaIXgdaIv62HNEsz6MoYX7CAW7MZa98ceWuv5Kw77u1SVFU84alglSjuenMgQDAtKtXEnwvX3Kpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfJfTcQvBaUaaNc3giA0u47cvKmYoaipdUHkoEdSAlI=;
 b=cBEqmY9E1smBhtG3eR+Uqu3ueCtP9NlPwruH1yZZDgofdcz2qAGg/LjNgOLCHQezIIawb5FT8aHbkDyh48EgWTQQLpFGgK24fMGyXW7OrKhazNiy3NcbM2IeHuAnS8QES5K8n6KAyRL3rqeyLRMcfZFuN274IDuiGU32hGu9hTUt6xsA/z9wQ/7zlCGHYDf/J9HGX9Fq8dai/ZYwS5ah5M3lsQ/b3emhuad/UiLDk14TgUD4vWaJK1NzZhvJri18vXiTQ6u/3od6D3q4llHEP3AVnwWXNvH5Ju43FSXmy02ciXeeVtmBI2PspiXNnOyhqe/IMUw6eFZX7JP+VgTlVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5955.namprd11.prod.outlook.com (2603:10b6:208:386::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 23:42:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 23:42:33 +0000
Date: Tue, 19 Dec 2023 15:42:29 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: <dinghao.liu@zju.edu.cn>, Ira Weiny <ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] nvdimm-btt: fix several memleaks
Message-ID: <65822a6542ca1_277bd294f3@iweiny-mobl.notmuch>
References: <20231210085817.30161-1-dinghao.liu@zju.edu.cn>
 <657b9cb088175_27db80294d2@iweiny-mobl.notmuch>
 <657c82966e358_2947c22941a@iweiny-mobl.notmuch>
 <13ffb3fd.41cd7.18c7c3b52bf.Coremail.dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <13ffb3fd.41cd7.18c7c3b52bf.Coremail.dinghao.liu@zju.edu.cn>
X-ClientProxiedBy: BY3PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9a8252-2bf1-4fdf-145c-08dc00ec2bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8LeLRBbhfaY8vO+by/QjZb7Bo+DPbPXHfkUXTxOVLRe/RLPhg4SQRcrvf/WwrPfl8OCLDZL5kByh69UFXyRWrlZQROsFOhL+CFN8dSYj4+gLrfdaUwmY++GTtG6xbgTxA3xfRhb7fK6yjLnTGfvPZAN/VguzrNro9+ibLaJ9izqvs4yL7ZuUx6tW3hxh5Tx7EPDY/mFPCnfYeXN5I8GL7dEHd3DaD9Q/n6OoTwF0VA0JpaN8Y3gVbawo7ZaOhdSa45QlGhRVaV9PzIUVMtLkIbY2NUOEQkmRCk2Y1F0a8NVz2S52g3TGfF2nGID+6eInM1GWLwMHFPwaLci/CqATc7JnHe6TwG6b484WF46GctDyKiIgBEdT2Xo2ttLCxZJMSwADPA+ZuGIU5VJaXYaYOVNypzK4JGCUPJUd6VeZRbGw/1sSwLwJcFp15f/DWhRr49TiTFIbT30Tx02cl2qQoUBzoGTM5JcWmkpmnUca9eGUpW9uUyyJ52v2/vsxskdB7QfKN9/l7uYQtTUHhLa3rFW2XwJcjzBxd0zKtOWVgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66946007)(38100700002)(966005)(8936002)(8676002)(478600001)(66476007)(6486002)(66556008)(6666004)(82960400001)(86362001)(6512007)(6506007)(83380400001)(9686003)(4326008)(6862004)(316002)(54906003)(41300700001)(5660300002)(44832011)(6200100001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yi8435jcKqdZdsr/z3hf1EAMVJL1f5CRVieY3U9kv3CXP3R0E5wsyrAIY5rN?=
 =?us-ascii?Q?BzDA+6ZwEw2neWyqkqWEE/CM3KvOe4/5R2iYFGy5kUpaYvbBPbC5SkB4sohL?=
 =?us-ascii?Q?OGCrZzYRz+IvfmesA1iLG/94ujYQhzKVcD1P+X0yoM54AVKcWeOcfa519CDw?=
 =?us-ascii?Q?oWb8mHZ3wtcSoHe3hilRqWvU25xT4WfbgszowCEt3xNqBz3h2cxuqjg8ph8a?=
 =?us-ascii?Q?YLFrS4tEY5cb9yNTnVfnxo/H2stCwXfnWEbJRe/OwdNFKP1u92rgmmY3jAK6?=
 =?us-ascii?Q?1lplZVltQwZ3lo7nGDRUJBo6H8PUr1bCIXdNOimkE4OsW+BGJdUmRDjePpUk?=
 =?us-ascii?Q?Bxv2aN7j+LgevctpkjcKhL1ojRdB/ooH9rnZ8TrEmszmBmtaaf5G7TM7UVJm?=
 =?us-ascii?Q?edFv1Ie1VTC3ZG+h2/XXmg6kIsWSgIt3j6DVDWChhAQC/8E2j1KvJtzV9HN8?=
 =?us-ascii?Q?KBwlPpe7CB1v/7ST/HzTfayW+RX8oSr8cZzIHDvdF0/NuIRjPz9x3c53+V4q?=
 =?us-ascii?Q?x2Uu5sZaIG4SzOY6cgyo7uxgM+Lsg4ojDC01KXxro1ezxzQp9QBXjlI+zRBs?=
 =?us-ascii?Q?R3v53n1whsWOnbyT1zt8EGcWsDgCT3vAA0fr255Gn9cJgACcHQRP2Xd8n17g?=
 =?us-ascii?Q?t/jnPYPTMPxrNEoOfjV6r/mKcVOlOkgNOyI/XGiUUKamWoWdjHVw9G3zgeUQ?=
 =?us-ascii?Q?9m3t8W3SIMofT2ZrtvubCqWtM8T7aApxhOe7ux8VSY/khXkAbF80FQT7ai0r?=
 =?us-ascii?Q?zlFhn2oQboZyy1QqrxVU9ZNTvOpeRmfkXlwFRUmkkUpeUYOsKR8cucYOUx9r?=
 =?us-ascii?Q?v31aHZq0uAIT+WGjTKs+yA0LkyUW8wy3xzUVyILKXBuo/o+3C8HemvoCpBTg?=
 =?us-ascii?Q?RVW376oIl0WQ1H3x0jWfSDWHPrg28oM/e+FMd+IqtPzkEbhtEVeFhyyePuF1?=
 =?us-ascii?Q?AsytSJPJqMj5qBMsWyepRjmwzcO0zQxpFR2RflJk8IbYnSqJ2g0hX/DfjEF3?=
 =?us-ascii?Q?MiGtdHhgVll/X/lq+3HBezZY/MGhTaAYbFe8ffJPH0Uf1v4fqCw1XfhkBvd+?=
 =?us-ascii?Q?BUrEwPuN9ltXhjtEa7uFaDjoim4L8VgXrXykrrhmnW1lSt0Ay5SErD77Xnri?=
 =?us-ascii?Q?T8lQaozX7rMH3A744GdsnCgSvBSbTg2PwXfVkgpBQs373vAHWWcu0zl4GMfg?=
 =?us-ascii?Q?tDr8yegMhsTuGNrWYV88fJSJUU6unB+yU1eyMb7nlT1Tzv7dmGX/Z4sE7ilu?=
 =?us-ascii?Q?n32CNM7vL2AihnXTySWjjfpjbbiaVajJfxbY/ldrD6dhT2KXso5U0+GVnzcU?=
 =?us-ascii?Q?Upg9h2rdAZk+oEjtbT734VCTPYAieV8DAGpmXlPkXfc3zipJpKQSczXCOWaJ?=
 =?us-ascii?Q?OTAZBzjVXbL95dZ4DQ/K9Y9ZYHhNGoPBuGQRfNy0wWpucPNB+dDMUlJekXGd?=
 =?us-ascii?Q?71yzF96yGnZf6RsS5loWPG2sXwLBONrMGLrmMTnBVwpxhPM1F5+r5PX/EC+9?=
 =?us-ascii?Q?c4V3N8UKsKfQ7roYUrQXKT2nwQQ6jICeOHp1DXL+MkIbFtLens2UOvYYXTkg?=
 =?us-ascii?Q?2nfHpLCDOIsU1VMDwHuryv1jMt9uCeO8esJ9uAH+h6Udo+GNTBVsXLjZPIkf?=
 =?us-ascii?Q?bazfsREMu7akdwVQawRUKBSdHwCOWAchwaJWSDvdyZoW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9a8252-2bf1-4fdf-145c-08dc00ec2bf1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 23:42:33.3278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqcymVHzvttdEa5MwfRiMEqNpUBak6kFsNM4FymAxiU62cGsgL5X3G6+NalmDG5n/M59UMXy3LPa202AydUM7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5955
X-OriginatorOrg: intel.com

dinghao.liu@ wrote:
> > Ira Weiny wrote:
> > > Dinghao Liu wrote:
> > 
> > [snip]
> > 
> > -static int btt_freelist_init(struct arena_info *arena)
> > +static int btt_freelist_init(struct device *dev, struct arena_info *arena)
> > 
> > Both struct arena_info and struct btt contain references to struct nd_btt
> > which is the device you are passing down this call stack.
> > 
> > Just use the device in the arena/btt rather than passing a device
> > structure.  That makes the code easier to read and ensures that the device
> > associated with this arena or btt is used.
> 
> Thanks for this suggestion! I will fix this in the v3 patch.
> 
> > [snip]
> > > >  
> > > > -static int btt_maplocks_init(struct arena_info *arena)
> > > > +static int btt_maplocks_init(struct device *dev, struct arena_info *arena)
> > > >  {
> > > >  	u32 i;
> > > >  
> > > > -	arena->map_locks = kcalloc(arena->nfree, sizeof(struct aligned_lock),
> > > > +	arena->map_locks = devm_kcalloc(dev, arena->nfree, sizeof(struct aligned_lock),
> > > >  				GFP_KERNEL);
> > > >  	if (!arena->map_locks)
> > > >  		return -ENOMEM;
> > > > @@ -805,9 +805,6 @@ static void free_arenas(struct btt *btt)
> > > >  
> > > >  	list_for_each_entry_safe(arena, next, &btt->arena_list, list) {
> > > >  		list_del(&arena->list);
> > > > -		kfree(arena->rtt);
> > > > -		kfree(arena->map_locks);
> > > > -		kfree(arena->freelist);
> > > 
> > > This does not quite work.
> > > 
> > > free_arenas() is used in the error paths of create_arenas() and
> > > discover_arenas().  In those cases devm_kfree() is probably a better way
> > > to clean up this.
> 
> Here I'm a little confused about when devm_kfree() should be used.

Over all it should be used whenever memory is allocated for the lifetime
of the device.

> Code in btt_init() implies that resources allocated by devm_* could be
> auto freed in both error and success paths of probe/attach (e.g., btt 
> allocated by devm_kzalloc is never freed by devm_kfree).
> Using devm_kfree() in free_arenas() is ok for me, but I want to know
> whether not using devm_kfree() constitutes a bug.

Unfortunately I'm not familiar enough with this code to know for sure.

After my quick checks before I thought it was.  But each time I look at it
I get confused.  This is why I was thinking maybe not using devm_*() and
using no_free_ptr() may be a better solution to make sure things don't
leak without changing the success path (which is likely working fine
because no bugs have been found.)

> 
> > > 
> > > However...
> > > 
> > > >  		debugfs_remove_recursive(arena->debugfs_dir);
> > > >  		kfree(arena);
> > > 
> > > Why can't arena be allocated with devm_*?
> > > 
> > > We need to change this up a bit more to handle the error path vs regular
> > > device shutdown free (automatic devm frees).
> > 
> 
> At first, I think the use of arena is correct. Therefore, allocating arena
> with devm_* should be a code style optimization. However, I rechecked
> discover_arenas and found arena might also be leaked (e.g., if
> alloc_arena() fails in the second loop, the previously allocated
> resources in the loop is leaked). The correct code could be found in
> create_arenas(), where free_arenas is called on failure of
> alloc_arena().
 
Yea I've not reached that level of detail in my analysis.

>
> To fix this issue, I think it's better to change the 'goto out_super'
> tag to 'goto out'. We could also use devm_* for arena to simplify the
> error path in discover_arenas(). 

I think it is your call at this point as I don't have time to dig in more
than I have.  Sorry.

> 
> > We might want to look at using no_free_ptr() in this code.  See this
> > patch[1] for an example of how to inhibit the cleanup and pass the
> > pointer on when the function succeeds.
> > 
> > [1]
> > https://lore.kernel.org/all/170261791914.1714654.6447680285357545638.stgit@dwillia2-xfh.jf.intel.com/
> > 
> > Ira
> 
> Thanks for this example. But it seems that no_free_ptr() is used to
> handle the scope based resource management. Changes in this patch does
> not introduce this feature. Do I understand this correctly?

You do understand but I was thinking that perhaps using no_free_ptr()
rather than devm_*() might be an easier way to fix this bug without trying
to decode the lifetime of everything.

Ira

> 
> Regards,
> Dinghao



