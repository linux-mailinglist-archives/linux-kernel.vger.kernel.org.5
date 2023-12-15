Return-Path: <linux-kernel+bounces-284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67A9813EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060D21C22056
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F200651;
	Fri, 15 Dec 2023 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7WA9ClQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157636F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702599869; x=1734135869;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WgJPVLf8y0VyrpXx8s+Hv3ruoug6OOoZPNRHgS4KA38=;
  b=G7WA9ClQsUtSEJ7kYkLIotAdiGl0ZfRbDm4HyUW+/2KmglLesSHX8aZN
   NnnxlX9cDNymsgXrR5EWzEZ1quCYx32phjqKDGHOQs5ckTskb6qcz8C1j
   jyF5R4LQZ93DQgltkkgvFbT2mOraM0stfjf7L6EeZIYBK/yT+j9gNH2by
   tPihstEtMumCk6S4BpZ5YKw4z7ytsuma4qw2OzJFx1EDT44MnXyy7GQYD
   ZQlXm2/hZOxPXz4ik125BBsC05FhpaYh8PkF1JHFdJPKqDIOYua4Fx0dS
   9vlN2JOrUd1iiptIWtgG5QwJFc7jVWU52u9LQfYvXoqXt57g/P+YjjUDZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="375357862"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="375357862"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 16:24:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="918245939"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="918245939"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 16:24:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 16:24:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 16:24:27 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 16:24:27 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 16:24:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCknrjrxwykiyAyFmEpaYGoh5tnudKFFKjSAOBPUVRkyjQ5y19Y5whC8j1tPrdHkZqSZ7lReJfAR8XLnBIzAyIOJkBbN2wswopgemLHaPCSO226cgnWftIiJev+SKuEhwehnS7DjApqCSEHJ8K1c6GuxO2EPHxZgtnk5WNopgfYcxncfsO+q+3sKxjZ4Jsbjw4XyNfJK51qVLoLEYpLSApkRaciq7bPKsv9N4M1BKwlkHhL3k7KKO9oy2lgxOUE35ZKhtZyyGHmJPOohuUE+gQnSeCBEBtcq5r1b4KZYbGZTMmeAimCZ+gn+1nire/uuc6nd+oi9qp9ZmtsIHvfC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9RyoZzRyOCaY3oPv4ygyF1nLeMQ4bWkDMMr+akE4uo=;
 b=ofEuapKnRIGqiD/uNh6aVXOArM2Qg0PVe+qFOOivS88rSr8hwzMfYgKHaqQgYnhNvgNeEVIz19H6BaP8ne/e2ibgjypxbTbz3JRIcx+54fEgt4fTe0UE5nDjbrHw9kW7S6RoVAsn2lVrlT2jI265hy5HEN04pLoeCUu4OIia1kqeYvV10M9gIQqh2RHdiRg/Dt5+8wJ7McyRYphwxMbtYEOS5V7HazMOUNQutrvctIo6s15TrxGKd/9UUmLy4my/6IG79TynzgCdjApVfwYRlXSXha96cMyQRSP6v5UdP2tFlR6aWwRAuqZfve1ZnHWcv006rPo+L34FLdGbBLNEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB8049.namprd11.prod.outlook.com (2603:10b6:8:116::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.29; Fri, 15 Dec
 2023 00:24:20 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 00:24:20 +0000
Date: Thu, 14 Dec 2023 16:24:16 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
CC: Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] nvdimm-btt: fix several memleaks
Message-ID: <657b9cb088175_27db80294d2@iweiny-mobl.notmuch>
References: <20231210085817.30161-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231210085817.30161-1-dinghao.liu@zju.edu.cn>
X-ClientProxiedBy: BYAPR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: cd410ae8-676d-4ff4-0c08-08dbfd042e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fy2pHH05tWvp+uqTvoKPbUruJ1o3hW9hiW93YQKNWihFvY2pENkRGzQdyWw1eFt8Ctp52rsnrkXV/pEQAUpAUVPWQ4qnSk4+J+Q6TS/lByPON4GF8csXOsKVW0n/PRGsl7u7cqXIDyA9FhgfTVInSjJVdMDG35bthzUjhPo5wTFWAPw97u2AAPg5pOr9OnBHyfPLp17e+DtS7V6YpDEoYI856k2IEAg5NEGma6ncgkWSGcSLing3OPjC/wHTtS6aqW5decSrciJAwaxFq8YzFI2fxysht/M1grSaVMJ2cf4KJISZMxPPGjPrkaoBPoQwZ14ls7vCR4LhxyxuG4hiW8Fm8Fp0/Hq/HHjGXZC6Kfcv+zP7ieskRoKDDTlMY4ZG/poeOj8kIhfIxDLlPeQEiUmNwscxezKvi00aKkIrxGplGSDequx0eQaPQzwM1nTLmtTxzXH9wKMyey9p1WC3vENNhKFg1xEfv/ke6+jFdXfn9cezlH5MJKDK9aGn5xmVDAdKIMKrJWub7sI0p7gCJ0quYBGUp1HgUbbZobLpKi+77qGKkSq2EmgDT2o4JN19
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82960400001)(2906002)(38100700002)(86362001)(41300700001)(316002)(6916009)(54906003)(66476007)(66946007)(83380400001)(66556008)(9686003)(6666004)(6486002)(478600001)(6512007)(26005)(44832011)(5660300002)(8936002)(8676002)(4326008)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Lt2N3Kq8x1mpSImOeWEqNkF4SUZYnfMlNe7x60qo04Eu4Ek4PgD7H5hHwb8?=
 =?us-ascii?Q?YIFICl3lrxNYXc+MI4ASxQZe78AT8S0sNG6XWzoYKLk/79QPF2xaMsO7IjLx?=
 =?us-ascii?Q?SDDty9PmgYYwcy32etHJ7hfcxdjtT+DtAzAhzzbCfAwjqQov9caiIBmA/nCi?=
 =?us-ascii?Q?4SgjT/J9gDC7GxkbhIbNuK9WuNAUiSE7ShqlM1x0BPvtiY172/QpcGUyJW65?=
 =?us-ascii?Q?nOJVbz6z5RJ4WIn8cNsRNCeLuPoz/dhlqjmW8wj5oZF+RlJDWVOp75sRi5HD?=
 =?us-ascii?Q?NecshvPs5i4OvfTFsGvq3n+1g/qFXGMGeHMQcyWGib1NUbIuhhmGNbQD9ohW?=
 =?us-ascii?Q?49MY40suyBU4VEi59U4FcSk+8WptN5J1z1pGfIZZj6DUO1HjRiloI2l1im6y?=
 =?us-ascii?Q?NU26OmUVgh3aqjvvZcMhdyDv9D9C7Iev0/pHkvC2lYoO/iDN94A0IRsUYL87?=
 =?us-ascii?Q?lgByHc4EkgAC2SHbr8z4uxsevBI1npTtwodD1d8e+tAiTA71p9Zqq/mIfUQF?=
 =?us-ascii?Q?LUPLd4YgF+brZTmsr60UfXfiKEuPm3tp2mksfNWTe3jpL63yEZUJ2OK9B0qH?=
 =?us-ascii?Q?j78wYPLT6bBIVapc2fvFBnr0Lq9OOgdwGS7N1wOFsQBDbuTyo9ky4E00kIoo?=
 =?us-ascii?Q?ERjHcavhBWjaMWeF14hfhVFLu9VogOgUJCB2x61s8+RwPC6+xv4n0ebB7YG/?=
 =?us-ascii?Q?/YoSMxU08/lo+X17bcJsBtwj3snSz4H+sTHbnM64WexZP/PlqSthKnukp3uy?=
 =?us-ascii?Q?Q0iV5PxGRVKsInLCCGbDgL32z/euv+CMUthHhlItL/EwWc8fMiZHkPht6Edd?=
 =?us-ascii?Q?Q1iFDMIdJyd979eNtgbiJ/lWXpsw3GQC7pRxRSeqsFAqYVC35T6/iHIK3USY?=
 =?us-ascii?Q?22eCPNdFh4UkQPCtnme2ATVcpPC00Oaue4TJaVgxV7ZCCwUEcfSJv8ynTAoO?=
 =?us-ascii?Q?7CBXfQK6Meijkrmf3LLzuuiD4T4cqHvIOJZ5/nr76wUB3izpWIQe7Sfr7386?=
 =?us-ascii?Q?koYw7afIhMkTaT1W3rUwZuGiKw3v/oKCD/giphuAm97alhOYjpe62qqll5dh?=
 =?us-ascii?Q?MSRitDQNUqXSDlp8YWvCyH1MglIVjTiyO/tCb+CP4Y0W5ITYwURH3aBmljPk?=
 =?us-ascii?Q?2HbXJNarCLgoPRYpRuLvdEW75UFTNNIgd0hJzcPjWV+Cizbz0NEGYbJP/qhU?=
 =?us-ascii?Q?8pTTCjzjh05NulM/tYNTdQcUQVMbvmJdZiw7ymi8YS2AaWw1alptvFKjJi0N?=
 =?us-ascii?Q?GuYHCKc6cY5VQxZYrQm9Gi2h6thuWwmvi0TkXqxNUsfe1OJc7wpJywjJnCf9?=
 =?us-ascii?Q?EBtK9A/VWblSKYDGQdAQO6UwJjgnRbMCeu6RDpDwgBVkJNa8tlw0DTQ4xfq8?=
 =?us-ascii?Q?joP3i52UoMoAtV+GExHonQ8nGjjZAhureTMPQCkmeWmUZ7MdkxbtYii/scxV?=
 =?us-ascii?Q?REx7THLt9enTpp4kjl9czX1HPx7iamyiikjtbw6a3y692/x80V5Ng+0mPjHv?=
 =?us-ascii?Q?Vncrr+agxcK2gTGM5HMJYTo2wVzGA+dJDOLk8B+ZzOvxRz5z7PMoFXR6I+ji?=
 =?us-ascii?Q?89AuCprL4m1L2p30lUwrlJ6ZA6pQSYDQzSPbdK3Q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd410ae8-676d-4ff4-0c08-08dbfd042e4a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 00:24:20.3499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQmEsbJFcgRX/wm1IFmaGpikQW3dyqkXCs1NvKYyg6WxnOE4jyK873gDkjRI7WF1c9Q6P7Fyn5bY8glRAeXlYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8049
X-OriginatorOrg: intel.com

Dinghao Liu wrote:
> Resources allocated by kcalloc() in btt_freelist_init(),
> btt_rtt_init(), and btt_maplocks_init() are not correctly
> released in their callers when an error happens. For
> example, when an error happens in btt_freelist_init(), its
> caller discover_arenas() will directly free arena, which makes
> arena->freelist a leaked memory. Fix these memleaks by using
> devm_kcalloc() to make the memory auto-freed on driver detach.

Thanks for this work!

> 
> Fixes: 5212e11fde4d ("nd_btt: atomic sector updates")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: -Use devm_kcalloc() to fix the memleaks.
>     -Fix the potential leaked memory in btt_rtt_init()
>      and btt_maplocks_init().
> ---
>  drivers/nvdimm/btt.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index d5593b0dc700..c55231f42617 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -531,13 +531,13 @@ static int arena_clear_freelist_error(struct arena_info *arena, u32 lane)
>  	return ret;
>  }
>  
> -static int btt_freelist_init(struct arena_info *arena)
> +static int btt_freelist_init(struct device *dev, struct arena_info *arena)

Both struct arena_info and struct btt contain references to struct nd_btt
which is the device you are passing down this call stack.

Just use the device in the arena/btt rather than passing a device
structure.  That makes the code easier to read and ensures that the device
associated with this arena or btt is used.

>  {
>  	int new, ret;
>  	struct log_entry log_new;
>  	u32 i, map_entry, log_oldmap, log_newmap;
>  
> -	arena->freelist = kcalloc(arena->nfree, sizeof(struct free_entry),
> +	arena->freelist = devm_kcalloc(dev, arena->nfree, sizeof(struct free_entry),

	... devm_kcalloc(&arena->nd_btt.dev, ...)

>  					GFP_KERNEL);
>  	if (!arena->freelist)
>  		return -ENOMEM;
> @@ -718,20 +718,20 @@ static int log_set_indices(struct arena_info *arena)
>  	return 0;
>  }
>  
> -static int btt_rtt_init(struct arena_info *arena)
> +static int btt_rtt_init(struct device *dev, struct arena_info *arena)
>  {
> -	arena->rtt = kcalloc(arena->nfree, sizeof(u32), GFP_KERNEL);
> +	arena->rtt = devm_kcalloc(dev, arena->nfree, sizeof(u32), GFP_KERNEL);
>  	if (arena->rtt == NULL)
>  		return -ENOMEM;
>  
>  	return 0;
>  }
>  
> -static int btt_maplocks_init(struct arena_info *arena)
> +static int btt_maplocks_init(struct device *dev, struct arena_info *arena)
>  {
>  	u32 i;
>  
> -	arena->map_locks = kcalloc(arena->nfree, sizeof(struct aligned_lock),
> +	arena->map_locks = devm_kcalloc(dev, arena->nfree, sizeof(struct aligned_lock),
>  				GFP_KERNEL);
>  	if (!arena->map_locks)
>  		return -ENOMEM;
> @@ -805,9 +805,6 @@ static void free_arenas(struct btt *btt)
>  
>  	list_for_each_entry_safe(arena, next, &btt->arena_list, list) {
>  		list_del(&arena->list);
> -		kfree(arena->rtt);
> -		kfree(arena->map_locks);
> -		kfree(arena->freelist);

This does not quite work.

free_arenas() is used in the error paths of create_arenas() and
discover_arenas().  In those cases devm_kfree() is probably a better way
to clean up this.

However...

>  		debugfs_remove_recursive(arena->debugfs_dir);
>  		kfree(arena);

Why can't arena be allocated with devm_*?

We need to change this up a bit more to handle the error path vs regular
device shutdown free (automatic devm frees).

Ira

