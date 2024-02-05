Return-Path: <linux-kernel+bounces-53060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7903584A030
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32E21F22C74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE27E3FB34;
	Mon,  5 Feb 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CV1HhzId"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD944C60;
	Mon,  5 Feb 2024 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152818; cv=fail; b=e+j5lKopsYiC3t6eBxvOxG8npNIwT6xHxpMjdumrgi2yy6/CKSdFvTvfNhtLF1hPl2LAtOGXfChw+ff7WoDmOoRZqlztwH7sFnrvcAy3j3kvT+5AwCsc+sxX75yd4koZGrSqDBC7+n8wiGTzAZ5ipo7R1iaj5PWyuKg2bJn7Iak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152818; c=relaxed/simple;
	bh=DV90eyToXomgGnwHsbGkxi6bZhaHDKo2tIj8pUKg1ao=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WjrMZa0FyAnYaTRqAD0Fv7M0R8WZBQGu+NB/LKaM92BQfLj37kx6HGUetMmovhDyGUB1cXqOtHVyoi69TMo8Hyq/5w8yEkEuYN5OVW/sPd1rLqz+G9zWoj2Jjx4weuFZfSdo9kjSX28AnyGj4GVNWLYKgr+m/sV4F5mmgfZZ9V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CV1HhzId; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707152816; x=1738688816;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DV90eyToXomgGnwHsbGkxi6bZhaHDKo2tIj8pUKg1ao=;
  b=CV1HhzIdXrUZxTlz/g+swN0N/5fOan+ZJpQ0P/YSSviiLWP8HegBYOW9
   CKMiofQ0ss6GVHqWGtPShjKJP3T/wwI5OEUUQXhi2WX8FrfpBg9gkAyQL
   R8a7CH1OyZrOifbozV9oTkA6tOhXqUitr+ZQDsYlu19oKLHGUheiqijuY
   /84VGL/CnBxXJS3yyQ8lsktEsN2MNuKoLM1O7OTOjZW+jND0JxNkFSVSj
   nhijg+hU1wyYBZ6z3Sbnhjf6PEGo6d0cz2YNMSt0vYS3cRLB/0N7cbI73
   UQ6188Kgv4HuUtGZW1kHQtKzlucbYU0NA/OI8CzRUY/gxRwXoRVK4eca+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11209157"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11209157"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 09:06:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909343478"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909343478"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 09:06:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 09:06:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 09:06:53 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 09:06:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xf7uOLkk3kNzq3XIgQJ13FI8T42cNTzYESJ9KlQBkQUJi9WJe2ppZmwcWD0pRvgHoUn9UQZ6mjY//2eQABFfgoghUC1Kx4G7A2oD7UL6AJnEsnye0sWQ5l76DMwfxWZmAUz1dhgFBSqMqw78jDaLEOaWATWJYwUKmQbYKgH60KGqJk7g2LpXRHzf57BY2sqxOpNDuuxjucrdFqXL4VzslzhCqDzOLC6u9kZdSyVnL7ZT3Oh+ioaOWJptEapC/TwVvGNIpKOCfYsifN+cm5CLLhq/T5+X+uvYLJ79TJ9L0bQ6xEkuN+pDTtmUBJgVBNyzJtXkQjEg75prHlvOd7nOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFYRc31biVJq85+iyQkxuwxK9F3Qe8dX6CB3CNzypuU=;
 b=W6UY4RSW15FBYYmCt+z2gfbFVVHrt4CZZvFk16LSIz3FWJk2fjFYc9L5mHDpRXlkRln/upfUyucOQFe5xC7LBFr3ln3iTZFTuCZ7C1NOAShq+VtNIAQn/rFBfPbR7SkPv5WxnCSDbzNyir06/RkttQ28lsHkHif4ZTwUHCQtzZXgP8P5BlPRJ9tnVUn+/oXLd7mxEm2HbOuuNFclZXrJz+hQoRuy9BQvEDyxh/qNVaRW71UKP3w8RrYyg1tlg3vM4hNeYa5CQgQ/Davm1gqAD918nsv1oe8rZatEH2OoWgR1wc84WljnZFxLdM5/loY80hSEz4kkbdVyVl6l0x7pIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:06:52 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 17:06:52 +0000
Date: Mon, 5 Feb 2024 09:06:49 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	<linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, <linux-cxl@vger.kernel.org>, "Fabio M. De
 Francesco" <fabio.maria.de.francesco@linux.intel.com>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH 2/2] cxl/region: Use cond_guard() in show_targetN()
Message-ID: <65c115a94e1d5_36bf7d294de@iweiny-mobl.notmuch>
References: <20240204173105.935612-1-fabio.maria.de.francesco@linux.intel.com>
 <20240204173105.935612-3-fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240204173105.935612-3-fabio.maria.de.francesco@linux.intel.com>
X-ClientProxiedBy: BY5PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: b14f8e6d-61ca-4523-1ff2-08dc266cd937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+9Jz5YBELx80QuyhvbQRVTeMFb2VRGZTmWcf4WH5sD5CE6uXRUboVq1ckkO8xXW7+dPnbsezGciiVg599T/n829iPgLrZwT1liJGmJqJ3il+7KUJsCg8QEzUaVaeGP1PoKP9Cm5e2tQ7Ix3pN5HyDb066KyZtz9e8hjOwUiujp5snHpkq0EVVldbKkNycVurpaok+BxwUailXF3gHaXL+ciaSLRAOTuv/vtUf8gLAsK0pIuVte4HpoQ8rk85e02mv45XXYlJ3KAOwelLcAxBSJxbZq0K9YAkEzBjxFlIfUbIrhLiP6KjTMtt/hBmxqnxpvihO9yvYyq8yUgkopKMAzzI/dUHbI7trLOKdWPyfGHcQ1ct7pwhoHbVYhJB7JpIfMZrDnbpiO3DO8LOaT0QUQsyhgulPsNGQGGs/iP+2Uh6DFsQxC5JnKEdsJ6PzpTwJIA95wi2eOIIIjNvEd8F/OGNQRe3P6EIWJynkr1Nwav6ZYZh7DdSFuTd4g27679yUHOd8N8Rq9e6N/kTBNeLhwQc3HAezitwQSFCbYjnygP/24xHlB9ALXxrGJtPieC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(4326008)(8676002)(5660300002)(8936002)(44832011)(478600001)(6486002)(316002)(66946007)(66476007)(66556008)(54906003)(86362001)(110136005)(82960400001)(38100700002)(9686003)(6512007)(2906002)(6666004)(6506007)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lmvP1ClyMaMKVwHYmZuR3+OmCho/z3LUiFBKbyRsS4orYtbNOJudhTZN4wKO?=
 =?us-ascii?Q?QsanSbVNzJGJnkALKAQf7gTYuK22mWrODxlAlA/n9+nA9yl5ER/TlrJOs5Yf?=
 =?us-ascii?Q?xrxEETGPBd7VKrm3amYP4rDbi+ANlJ1bnrCk6hCBWseMAkCDv8t970XK6OhU?=
 =?us-ascii?Q?A2s1u0PWrkx1Q9KqBTPzzgas2zNyOmVzSFMbObW+/L1EWoQ8cESiW2s3W+0G?=
 =?us-ascii?Q?BcLjiuAfRQGtpVH6s1pej+98Qmh6T3NV+DaHUx3CC9uhId9u9+lupu15IuI7?=
 =?us-ascii?Q?CsFxSTJ5JFFLb3/vhVS00a/zbsoX/Dzvi26bQKYOafHTl7+u5DUWxvkNjRF7?=
 =?us-ascii?Q?or9V3jXDM8m4hm1YHJbV3g0yIAMRNsJZWyBo2rRrb8YK230hVHy44alIq872?=
 =?us-ascii?Q?uziTsTRK34L+l8ZzAV3reGUWrdFO9vOScdYUYHM0UDqS0s6xXXZz4Jq5jcub?=
 =?us-ascii?Q?aESpiYJ9Zj929LAHgNbB8SKbdMMVkRTXKJbPIgFC2JlmMaW6g81Ha9CPLumJ?=
 =?us-ascii?Q?pQSA58TKH5I249h/Nck89m7AY+i6wMd1G7+x8whfUVsiSLW2ooR/lrH41tug?=
 =?us-ascii?Q?BPsKDGEdNHsxljMxkntK6qUqIqi59FQwRuwmMx2c1GurI87xo+yLuX7gsQcM?=
 =?us-ascii?Q?1ZLdNVgXSLvGL95/WIaBYjUoG1DUE1zNPT28VP1tH5cqaCQFY0mAaeVDwJ0r?=
 =?us-ascii?Q?y4OPuq52duEqwR3/hl5P2N00BaqatrvsV17ntwZiNKZay8SlZsNlz2PI31EM?=
 =?us-ascii?Q?WBGRktbSGgrrD84XJ9Gg95HIy8VE4m4YU/s6bAYnMWD1Jp4AxIaZX9+SQqR0?=
 =?us-ascii?Q?yNQjFRD12sCyDKyE3aQyXYSpBqCOUliszpk59+LE7Xy4BbYS1qL/qEe36qgP?=
 =?us-ascii?Q?HwlLTrVvqYx+iFXsdGQbxVApZoZvw+v8Sc1mIExpiOjGrAW9faKLUdHJ+m4+?=
 =?us-ascii?Q?nkETpGAlAE2iUoG0vOiMWZ3xipl+X1Y2ESnwmeMVaqX7q5vBbRFAZVa+WI0L?=
 =?us-ascii?Q?xclu9baKwiZuqi8DrS+5fyByzsTmVdsX2hSLLQY+w7MOH3CDd/YQ9JQ80LpA?=
 =?us-ascii?Q?Im3KpQjQ5j7UA6mKokdG6ERVKUtD8UywQliix1k2Ady7ufLdPY/t46GHalJC?=
 =?us-ascii?Q?veIIHH0/34BKqRH4irjLY59I5tVMpRomPkSGWgmC4ruD0V5SM7A9jh8qXYTw?=
 =?us-ascii?Q?+224JyahSi/X35Zcqr2Wap4D0UZ/2/OUY5PTl8Z5nqezuQDemkVlF73tqdyN?=
 =?us-ascii?Q?zH3LsfIKE860IjRdNY7eMSAwFkS12HyUUVY8jSIwBkg8ft2v+2bdBUaNRF/S?=
 =?us-ascii?Q?UkjmjJ2elaaFm4tFsXJ6PQ2pBR7CwMN6wBmxbaxsywuTokXz0bwO2MCEuje5?=
 =?us-ascii?Q?bP7j55pYXz56tg46UucNrrA2dqfBwKbZhU2LQKBpChi15Cpd5XYB4YvpctV/?=
 =?us-ascii?Q?iJxsf+VTuZJU0FP3PxSJHGUoXn20IV+/+hZkeHj348NzXjm15gtiyWyI6oHX?=
 =?us-ascii?Q?U4sjT0g9IAToN8lKNd0cRTmOcioZOx7tkEAZe/MG6Py7zLrPki7PTzkFC36G?=
 =?us-ascii?Q?AxmyGpX5vpUhcL81K19gvceqiAzGhQKMVT6Mf4O5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b14f8e6d-61ca-4523-1ff2-08dc266cd937
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:06:52.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5bAKtLrRGgLFcE+2V3wE/WVnlNiLnuKqXx5mgvmgvg0nLPP5izrdTYSPaVt5TeVqEQThdt4QDgwyaEeqQ+eJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> Use cond_guard() in show_target() to not open code an up_read() in an 'out'
> block. If the down_read_interruptible() fails, the statement passed to the
> second argument of cond_guard() returns -EINTR.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/region.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0f05692bfec3..bd3236786a25 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -666,28 +666,20 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled;
> -	int rc;
>  
> -	rc = down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> +	cond_guard(rwsem_read_intr, return -EINTR, &cxl_region_rwsem);
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

NIT: This else is not needed anymore.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> -		rc = sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
> -out:
> -	up_read(&cxl_region_rwsem);
> -
> -	return rc;
> +		return sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
>  }
>  
>  static int match_free_decoder(struct device *dev, void *data)
> -- 
> 2.43.0
> 



