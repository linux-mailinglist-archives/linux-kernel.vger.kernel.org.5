Return-Path: <linux-kernel+bounces-45008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E454842A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A40B276EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2A41272C7;
	Tue, 30 Jan 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZF5XkyG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2711E4A1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634182; cv=fail; b=CnSfSvufre1uQsfBO9G3G21N2AKqhQinyPs74hoBvTFsunTG0M5W9y/aer7BHKKeoPdszwLwvdOA9h5Xn4uyzSFP3g4ncbsUnOAw175rsUyaGQOZ02Ls7yb5Z3kTHBxsFiNL+nXb3E0oJkDrCIseYWN/wEiykoxb2LcX1RgI9rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634182; c=relaxed/simple;
	bh=iREplQB/HhrYgMGxotLM6uackOC4MIlbFQSDJWY5pgU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T9TxKtxtln6FLt6Pc23lDh7zFb+1WNv6r3L4mWDxSdr/4uER2gyM9NmkfX6SSRrOdC1oAIFsWKfMSjD6uIJeRmzgfau6Vjt5CD6RT1MoNf6eJcmBiSsxEmu+giRdLpmiQDHfg5YkZ93K7YEjmzRCFYpUrX4567WntA0XbbKHL7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZF5XkyG; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706634180; x=1738170180;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iREplQB/HhrYgMGxotLM6uackOC4MIlbFQSDJWY5pgU=;
  b=IZF5XkyGjXCx5ly0lXYp9ZxquPbVnAi2/v8nw44jGZ2gpoWEzZS4wXhy
   F0hzgim/MPZFaJ9Uwkp7dDj50dlyYxyHgDNHeRt55ByDmQ6/w/MQ6TZv6
   /pV8fc7QMhH97zpxPwX9tntYCsZSUgGtlhhdK913XCfOmPrr8HA8uCu4S
   aKRFYTxINojzUt6k65JecwlWfUXtSFL6by59UNhocGvafctsQgXW6sUaj
   CEwNmuyvqGHnR9zeuwjWyq6wsrvMdDpN22rvjOCH7RLqioMfUwlRCXNFg
   LLe9Wj6MGAD+jDGH+Zl5UrxnhcfKn6Z9livS3tMM5/6YQV3BUcf38mrSy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10008086"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="10008086"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:03:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3749227"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 09:02:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 09:02:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 09:02:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 09:02:41 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 09:02:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyEtUchbEexlDGjn6pT1zYRee6jxRcNDT38fNBuNJC7PuS4eEzsrMdh6bZe+v7q2Z5/9h33pqToIyACVTfp4exfbN/Vsucr8n+fvAHOWPPSZIZHsGSLKypZXztCVBz6cCVFJgNkHoKzWQ4/aM+6Tvqrog6ucTKmSSj/1Z9kHIkkBjm5YVnvQnZ4xHdG63aIw17FqADegbvRuOr7ziLDKuFYnQVXNl6EJcBKT179GYa4pS+72qMmKbl7magvoURJ7V1uTsMHoe7uqTH7kzLuMuk999/0ykAfl9f7URjQf2yEG2y+xpj07knL2rOofUz/Z6I8KP5pmS0ZSJuaoXRmY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkKa51I36igVoHNhHTCR6d5k4D7SY+R9C4TqUXkBgow=;
 b=RlepMaBmWzWdHYfZhcSJfJmpaatzekR74Zk7mZZWtEfjvqkfdZ5/rXduzwE+d6gHmc9JPvhWLUfxaiFVJWdXmd/aIxhRoS+PD3YQT8PJ64IUNUUvzGUBvZ+IyT523ap6iGojTpk8MUypl+IQ0X56pLb3lAORaISxUVYvnrhBpuVHStphC5BoTSIG3TGzQafTuGojOvbAcLwUAJnVOLkk9gFJItVcO1GtDKZ6S1+jAEvLelQ2u+25cIURk3l+YIf1BC0lmonOz7QCp04ogvEYSi/d0IPUZar+sr0PdJi4Icf67vNqRsbBSIKt7xHruXvPAvawb7UT1l+xGTm1mop3Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6843.namprd11.prod.outlook.com (2603:10b6:930:60::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 17:02:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 17:02:11 +0000
Date: Tue, 30 Jan 2024 09:02:09 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
CC: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2] cleanup: Add cond_guard() to conditional guards
Message-ID: <65b92b91a41a8_5cc6f29484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240130164059.25130-1-fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240130164059.25130-1-fabio.maria.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0223.namprd04.prod.outlook.com
 (2603:10b6:303:87::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 95902eda-fa3d-4353-5498-08dc21b5337f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfHyiW+/8DCOuokSKFzS+YbxWPdHMst5a/0LG0C1bTYyBGRXOxn3LDScHZEdQN926XmJRBbvkx+JYRIGKBOBVkuMPWGaOhu6R+tEXv4y4GgGHTi1FdS9NfrqBSFnnFGA0NZQGDHYUhk2CGPXbp+eA/n9XRVNclTCnvYQDHiFbl7VsvUjIGDNBmgk7wna/gOP4prGeOqxO4PZOgUYQa9IjRgDaOmddgy4s+9To8j17v/ZRfpOwYWI7ZtjkTXnr/wgte9EDPEBkZgkMctGzPGI5kun9BAfuQWKHr9T9aNCbJ2b35t2IWvspnih5ac1r4uN5lb9A/6roubBWrFcd6onYX12q63cjTTAj0rKD7rm7EVBXRzhkexUPQY/kCZhn5gOHend62EGIiMYvaaqpTmthhori6uphdrkjKBVlDI9Sh5O6zJpxjkIlW0wV/d3G/gEbn+mDcInZfOjor5leb+DovcgXXXg8lhrvfN0g5qK7Ta8SW2Is6cSBqJwnF2tXeg7awEgMPgLgeUqMGuLe0BieXQFRZPwZ7E5e5x9wp/iv0NtvKJJlKXaMxy4X40zNT7y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(82960400001)(86362001)(8676002)(38100700002)(66556008)(6512007)(9686003)(26005)(6486002)(8936002)(41300700001)(478600001)(5660300002)(66476007)(316002)(66946007)(2906002)(54906003)(4326008)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7AV5/DXOawTg9STkFBuntRVG3/eQdJx9eZRmSAe89BYCyzknGerqjkDDS6k2?=
 =?us-ascii?Q?mpDnzAKNM7XWO8Zt9tpEDPBpi/gOrXnHlXIDz5TeRlKdf5+82oUuMLUr9ynu?=
 =?us-ascii?Q?8CwG+O3Yh+J5FTIipasLiYOXX7pdsy+U8Jdkn6HmlPV+v1Cdq+OMuWSHoo4d?=
 =?us-ascii?Q?Glfol6R1IP21zEfV7nKr9SvHU0MWmdZEEHuUuAwxZltrWvEC+ohKs7RcTfC1?=
 =?us-ascii?Q?DENZuVyoid3p+IT+ugWOsVtH1IHtv+Y0jZgYHuGGZGBjxCE+JDzPqSPFlKi5?=
 =?us-ascii?Q?4EAad4BYjs/70f6hLLjrRH2JPRUILYrsLijWhLjsSrXFogS2oMv+f67J60vM?=
 =?us-ascii?Q?4rgX0aHLhMyAJobD1aIK8QI/3uGC48m+0CQYOQNoZ5Kt0npGuSgjAOy72iRn?=
 =?us-ascii?Q?zVlVAWp7YNkLim6KrrcYSddESjigQEe1/mHCEYBVOS5r4oYR9syHcD8xqLY2?=
 =?us-ascii?Q?kHqgHQBXLxl+FFv1CJHHBl3TqEYVxZfd4zi+TfD9gq+T8kEMB6nXs2VNpqKY?=
 =?us-ascii?Q?rrOJFRX6dhExNI3XDdjSNjaECFiP2+ej2f9u0OdZHjCjp0sjqpBWdEdojSFZ?=
 =?us-ascii?Q?OjTROwQ3TvIQ8/b8IbFdpG4W614rKKWxu4lhdN+5dNOeCpXAz+L2iVIry+sa?=
 =?us-ascii?Q?UCsgQnQEiGIqBOZK3A6HzBjlPK/3R8Qk5+jnmcqSHFxZJltK40LWG2FQU+2m?=
 =?us-ascii?Q?MoL68rvke314LeY5I8Us5TwVmzK8G8XnDiueRGdVUgyyBH4+tw7cXd74yxcY?=
 =?us-ascii?Q?QAgrCKSDwzItAirCsVROe1HGCBvKm0fhBqjDOUK4y2if68LSl0w3/pT8XNat?=
 =?us-ascii?Q?3LM8OFDZ4hVZFazypE59qF8zt9Uke04cC79XygLOTqcybFyygeUz7MxzGYQk?=
 =?us-ascii?Q?mvgS6nqSS7y+6DSmdV3LMdPwPQ0at41M2KI6vOKbj94gf0WYT3kj8YBlZxTU?=
 =?us-ascii?Q?lx8ccEPWfjv66hyvg47AqcZ8TPspAGj91YHd4hxJNBNZToXv6yrcjrkg+Hdi?=
 =?us-ascii?Q?TWSVAWlh07Kx7ZW+VhVEbRxtWA4Usdk2LDFYqpaFZ7p+PmecnkWfTduSQTPB?=
 =?us-ascii?Q?9gLUO79K9ZNpkFdXuPqWmqeZ4/BM+Sb0LrDPtyaBv5ClTlRfUPY1a4pVtQ1C?=
 =?us-ascii?Q?tXeLy394bzGGuHVm4nkgUT+Cmd98smKeS2LEpG7jgcQad5PVhdTA4Nx0ZrN7?=
 =?us-ascii?Q?Y2B92kjfC8g46RuuWjknz6mKrm9n5EkXjcn11Ov/uMdM/WWeW8bKI3qFtOcL?=
 =?us-ascii?Q?xSJi3cOJzSsgfvYWEc2C3R1fyMrfgMZveWJAxbpV0PsW53iQZzhFXcHmr/Pm?=
 =?us-ascii?Q?j9hgdu2vwHW7oiN5upHCeJfNwZ5IvdUPPwf548F+49VF1zjoxjjBcoE9//6a?=
 =?us-ascii?Q?2/1R0dmh4jNtNDKZQCuBKttAlVmJlI5N4aB8koA08hvK64g9hqSNYmSX+Bb2?=
 =?us-ascii?Q?OffiNKPOtlnrF/laJ9N+CGq4rQlPpEkuPMIScFF5+AydZ9HzukzjStkvJReM?=
 =?us-ascii?Q?75IGn+wCDdSkbirsbWXKJC4JE7IuiVhaZGeWCamP5kCIdIXSq9W1VmIWe7jr?=
 =?us-ascii?Q?Es0LR9mq3h8RpjLESyPDxvXrbQ6LGarWNig8P3LZAs1pMvf6tFBuEPSPRKbc?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95902eda-fa3d-4353-5498-08dc21b5337f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 17:02:11.7819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fccRNHyVz/QOVRgDcoqam5G0onVpQNX1gTSbWTqBekiNcLta5/vZr6fBkFDjGjMO6qCyxlx1xTFUEFAHxuV/vF5c/EgE3NrElpB+jq0C2+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6843
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> Add cond_guard() to conditional guards.
> 
> cond_guard() is used for the _interruptible(), _killable(), and _try
> versions of locks. It expects a block where the failure can be handled
> (e.g., calling printk() and returning -EINTR in case of failure).
> 
> As the other guards, it avoids to open code the release of the lock
> after a goto to an 'out' label.
> 
> This remains an RFC because Dan suggested a slightly different syntax:
> 
> 	if (cond_guard(...))
> 		return -EINTR;
> 
> But the scoped_cond_guard() macro omits the if statement:
> 
>     	scoped_cond_guard (...) {
>     	}
> 
> Thus define cond_guard() similarly to scoped_cond_guard() but with a block
> to handle the failure case:
> 
> 	cond_guard(...)
> 		return -EINTR;

That's too subtle for me, because of the mistakes that can be made with
brackets how about a syntax like:

 	cond_guard(..., return -EINTR, ...)

..to make it clear what happens if the lock acquisition fails without
having to remember there is a hidden incomplete "if ()" statement in
that macro? More below...

> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/region.c | 17 +++++------------
>  include/linux/cleanup.h   | 13 +++++++++++++
>  2 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0f05692bfec3..20d405f01df5 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -666,28 +666,21 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled;
> -	int rc;
>  
> -	rc = down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> +	cond_guard(rwsem_read_intr, &cxl_region_rwsem)
> +		return -EINTR;
>  
>  	if (pos >= p->interleave_ways) {
>  		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
>  			p->interleave_ways);
> -		rc = -ENXIO;
> -		goto out;
> +		return -ENXIO;
>  	}
>  
>  	cxled = p->targets[pos];
>  	if (!cxled)
> -		rc = sysfs_emit(buf, "\n");
> +		return sysfs_emit(buf, "\n");
>  	else
> -		rc = sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
> -out:
> -	up_read(&cxl_region_rwsem);
> -
> -	return rc;
> +		return sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
>  }
>  
>  static int match_free_decoder(struct device *dev, void *data)
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index c2d09bc4f976..fc850e61a47e 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -134,6 +134,15 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>   *	an anonymous instance of the (guard) class, not recommended for
>   *	conditional locks.
>   *
> + * cond_guard(_name, args...):
> + * 	for conditional locks like mutex_trylock() or down_read_interruptible().
> + * 	It expects a block for handling errors like in the following example:
> + *
> + * 	cond_guard(rwsem_read_intr, &my_sem) {
> + * 		printk(KERN_NOTICE "Try failure in work0()\n");
> + * 		return -EINTR;
> + * 	}
> + *
>   * scoped_guard (name, args...) { }:
>   *	similar to CLASS(name, scope)(args), except the variable (with the
>   *	explicit name 'scope') is declard in a for-loop such that its scope is
> @@ -165,6 +174,10 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>  
>  #define __guard_ptr(_name) class_##_name##_lock_ptr
>  
> +#define cond_guard(_name, args...) \
> +	CLASS(_name, scope)(args); \
> +	if (!__guard_ptr(_name)(&scope))

This needs to protect against being used within another if () block.
Imagine a case of:

    if (...) {
    	cond_guard(...);
	    <statement>
    } else if (...)

..does that "else if" belong to the first "if ()" or the hidden one
inside the macro?

You can steal the embedded "if ()" trick from scoped_cond_guard() and do
something like (untested):

#define cond_guard(_name, _fail, args...) \
	CLASS(_name, scope)(args); \
	if (!__guard_ptr(_name)(&scope)) _fail; else /* pass */;

