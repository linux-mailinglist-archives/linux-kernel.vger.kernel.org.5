Return-Path: <linux-kernel+bounces-25701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A268282D4C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B6F2819DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612A8566E;
	Mon, 15 Jan 2024 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxhUrCZm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F936FA1;
	Mon, 15 Jan 2024 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705305455; x=1736841455;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UHzZjqR+wjDPIstjYnOGoH8EE1wb2QetT14mpySbL4o=;
  b=nxhUrCZm8gsOZQQUz2SuyivG5byyE2Zmb+I8tjlSB4roI/FZef03l8a6
   Ha6mnbsnKP/bAsHdONNH4GFSlSzJN9uQL4xdpm3G2bRKTC8PQReapTcy1
   430Gkzn93EjYJiICox543+Xi+PVdAWRTN/FrOVFq4F1CE++7+DT6WdtaZ
   GZ0IXhS0N5kRcSPSGKRLK7I76P+AQef554bAFEuogZ98eb+5r/gsqe8Wl
   O8Gpv5jSjUL3mvC99NsS5FqFAfu17CtpAKN9bcgnKofvI9JxgVllW67lN
   UIY5JN3vs7rE+B6MqBZnBgpu6zFW5cusd6YtrRVL1ofPvVgimQLvPzr0A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="18157427"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="18157427"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 23:57:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="759788778"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="759788778"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2024 23:57:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Jan 2024 23:57:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Jan 2024 23:57:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 14 Jan 2024 23:57:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 14 Jan 2024 23:57:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYAckdPTvFDbNspfI9SK98g8QaMpo5GzcchfoBBYJnYvvxVd2z057yQgfBrr8HN/cE4Z+XbHR/cXpo1F/k/HQEb/obxXrsOqNRWcmgsE7Q0CzHx0UYCJMBOn4VSoAdlIT4k6WXynnm9Wja+EA8erqTMM7EHrxYM9AmcNn1fygy+Z727F/5lY/jp0/PAApUdjXGjB5ITAladEVCPBkwo1hqfFAbDYz2NDhgfVDPO1dz4VEaEtz+5uJjH8fYBlENJdmTwjpZrmgNeXGWcaHGmNiJsDSwDDsfhfxC8ypQc7oyCi96ubdjvl72Xl3wkrY4KfviBpd/6gXjkRhOz7RSMX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkHxkMRU2e1VUeKXefAm15T3pMx55EVNxdDmmmmA0UI=;
 b=KzHHV8DTluydETBeA63rG0oZMUdOnZgP3exiqMCsXNkXBCbF/pPDKQtnRuneB9MNztXUlecpHUDzyhFUZRIOlppseJde/Jc5wnaUJTDfzGth90OClZS04tTVtgKPmB87a9iWUbC3DK2DbQd3JFv+B2zakDBnbNxe2XnHCQBC4jWguW2oawvJRdcyghdrkihBLSj4bYxvTm+ACJOAldPe0twAmMpNrUsoYouMzgpRyOE1kLLgZwXFg3v9edUmXI9cF6SQsqGUn4MaYOCKQ4kH/Ukw8NNP7824cFLJAhCx7uGh2jK/8LwDr8GUkHcklUgmDN5fxBpaG/+LVLZ6ttrtxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA3PR11MB7980.namprd11.prod.outlook.com (2603:10b6:806:2fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 07:57:31 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7181.015; Mon, 15 Jan 2024
 07:57:30 +0000
Message-ID: <7170ecaf-32e3-4bfc-b20d-a08a341ae381@intel.com>
Date: Mon, 15 Jan 2024 15:57:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] connector: Change the judgment conditions for clearing
 proc_event_num_listeners
Content-Language: en-US
To: wangkeqi <wangkeqi_chris@163.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, wangkeqi
	<wangkeqiwang@didiglobal.com>
References: <20240115075120.186143-1-wangkeqi_chris@163.com>
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20240115075120.186143-1-wangkeqi_chris@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::35)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA3PR11MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd89e98-a84b-4642-c8c2-08dc159f9f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgbMYDBgaBUwEybuPn25bWY09P5Vay2Dxh9tA81p1AmwZm/OIFzL8DMB+rrtLxuJfxIwXdds1ix4W8h9skS4v+CFBczMXJFHeLnudWEi2PdMhb1BgjGdDWwY7cR/WXFX/WHqymgmb1QOE0NY64Zza9JINZDRE/MQ89mC+iJJLUmpfOMvn0g9L0loUJioXTAGg7Xdi/7ipX9BZmh85PGahk7Vy8pgWUwPJkUbLRwf1wubU8IaOTQ8+/G/sbgY/c5y2RyfNMavffwuzOsFNb99yUq2c9AYkkNYKh9C2tOvaF8uMER6Woo5DiWFa3jgkvLIj42O48T6I3GLId4twKj0nIZcfkzjZlm9s8mQ2a6Yg/9Q+s9d2KZxU9HT8EHU/pVkMPJVto6jCvuWPbjq0nlFGDDepKtO8QDHSrD3UvgCQADEwAeojTZX9DqWsKIuwbEtfFhtOsEUdYKmbx6jQnszKmALfIg5UCqoSSQ4jeO1RRnLRJbeZVEDQr6SomD+YsapYDZfG9P5fn6MzrJyEkFG5kcSFJ+rUJozPPN+ZFIcGMr2lTjsbkNlNECJFJ4gIxy/2kxmVPFoXjCAQUswpupPTt18RdjmExnl+040uNpOYcsFN5JJVc40Ni3vsjTfsoO3GG9LM3awUjaLW6OTUM/LhzsYzsXXF/T+zlDMpYNKkTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(36756003)(966005)(316002)(66556008)(66476007)(6666004)(6506007)(6512007)(53546011)(478600001)(6486002)(41300700001)(2013699003)(8936002)(8676002)(4326008)(2906002)(5660300002)(38100700002)(83380400001)(31696002)(31686004)(26005)(86362001)(2616005)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWxCbzhWcVRpT2JocjR5cVpXbE40Wjk3VWtKaXRadS95d3NSZWZDYUN4YXAx?=
 =?utf-8?B?OE1FbW1CNDJ2Z0pNaCtlTGtQeGpxbjVXNkpMY0tra3dDUUphWU9aRFhOdHdl?=
 =?utf-8?B?V1R6ditYUkFucmVITEVjQVhaeW5SWkY4SGFMZzluVDVUaUZRVzg0L0VtZWo3?=
 =?utf-8?B?NVhsMW5XWG1KVFd3WmhRdlY5NWNKVml3RHJzeU4wTGhQeDkvZkwwWXhiN0FG?=
 =?utf-8?B?ZVV6MDQ0UFFkeFBPZ01ySHptd2pqQ3lqSE4zd3FXS0NoUFA4bFQwQTNZN2hM?=
 =?utf-8?B?NG5PamZFSjVxNk1RNXZ2MEd6eDhEbzB6MFZLcXFCa3VsWS9qeWs3anZyUUFJ?=
 =?utf-8?B?VFk0SjlLZmlteCt1ZW5QUTlZOXJiOTBNVjVmZUxDT2dPS1lnS2FBSjlVd3NM?=
 =?utf-8?B?c3hMMU1oclNKWmJYM2FHQ0hSTThmVTgxVGNjRVljdlYyT3JoZlVGOFpzNjZu?=
 =?utf-8?B?MFFtS3IxYmlQV2I4QWxNVUVtSkx1c3ZJdnZGREJyTmd5RjZmOFkyUjRldW9p?=
 =?utf-8?B?c2tndVFmVTRpR1JFelV0VVNXSEVJZVJCUHFhNGc0STdYWkNnQVVvTVJVaG0w?=
 =?utf-8?B?QWtmbkxWV3IreGlFT1BjTnlKMDhqWFFSUzR0K1dndDBpWEJFSjlmWnBIb2th?=
 =?utf-8?B?aElsaTJBOEZleDVwRnZwTldJZ0N5TnpyeGxCUnV3azU2dHhOblI1Vi9TT1F1?=
 =?utf-8?B?SWtFTkxSaitrNUdoSlhqREY1b0t2YlZxU1EzMGZBOW9tOFR3QnprZ2lIbUlH?=
 =?utf-8?B?RTh3M1dYY25UamtBSHEvSkkwTGtBNDJzaGhWVWpHalBRdmd5RVE2Z3htME9Y?=
 =?utf-8?B?bkVQTUp6bVdVYjJuelNrTkNmTHBhOVJJV2FOSjhFRjhYYThXSGt3Sk50b1BZ?=
 =?utf-8?B?QlVFS1gzNVVhU2Vra3o2SzIrUGJueWpCV0RCOVI2QnNCOGpSRFRYTmViSTRZ?=
 =?utf-8?B?WklRQWxCemlmY3I5bmRYU3JiYWFaLzRiSzZCTWRQOFJLNHBCVVFQMWM2Y0Vw?=
 =?utf-8?B?UHFnL052cUFnSkJXVDl4T3ZObUd6Yno0Zm80ZDVzYVJLdkhsUFV1bk9qeEJD?=
 =?utf-8?B?Yzh5Ymo1MzJKV0JRaCtrTG9ROU9BWWZ2V2hoN2JkTDVyMDIySDRvNDdmc21t?=
 =?utf-8?B?V2l5cUFIbGJJUEJDMEozTFRnWXFpdytZVVYzS0xVZm4rZDB2cVljRXYrWnRi?=
 =?utf-8?B?VHZpU0czTTI2dE5XNHJMb1l2UGtGZ205SjRDVm0rSE0xbndESVBKdHhMYlpa?=
 =?utf-8?B?NmF0Z2JUdW9LSThmS2JJaFNPS0ZZejNaZlM1bzJtTkZEZjZZTURhczRXODBR?=
 =?utf-8?B?R3RYVHZoTnhpaFF4eDk4RUdhSitpNy95SmZVNXdZNzZIcHhrRE1WeTdJclFi?=
 =?utf-8?B?NlIzMy9mOWVpUFh0SFBFMXNXSUtjeGIzMDJDREtmVzZ5d1ZoeGRuSXkwcU5K?=
 =?utf-8?B?eHlGbWxGNUdYVTRoNURCbkZhd1dxRDlpKzNydEVoeDJCUU1zbW9Pc2VIYTg1?=
 =?utf-8?B?cDR0RDNmNU1qU3E0TW4vdGw5Rk5ieFdibzY5VmhzeExwbytsZjd0d2ZNdGN6?=
 =?utf-8?B?Rm1aangwbjhHTXhVRkczdlhQUFp6WUtlSCsyM2Ird1JjTmV3RHk4Kzd5S3Mw?=
 =?utf-8?B?anF1UEpUeGtJU293QXRvTUdrZkFjaUI2N1lBSzYrUkNOTGd3SGJ6MVZJSEtL?=
 =?utf-8?B?TjRhWlZqOGFNRzBBbmVuTHRLdXVnL1hMUGVwVnNsVVA1RTRESEhiMmxuN1pV?=
 =?utf-8?B?N2RRN2pMOUYzTGJKck1GODdHb3d2VDJQUDgrOUVmWUQzSjdqRStVL1VBVjZ3?=
 =?utf-8?B?aS95OWJrSGw4a0xWcVNweUp0aUpMNytmSzN4Q29pSm9Mb1FUSDkvVHRvdkZq?=
 =?utf-8?B?cGlRa2NHVlYvcVJPV045SlluK0ZsVXRjUlRkdWp1VCtkYUp4SG9LYTRPMlh0?=
 =?utf-8?B?bE9lWVBZM0RXVlZxcGcxR0ZscHpjbTFWMjgzWitpZlZZOTNHSDQrcGhsb1oz?=
 =?utf-8?B?UDNuNmNwOENyVDhZV2xsZVJKZ3ZwRmIra3NmaGY3cjZ2Rmd1ZHBrbUZYL3dr?=
 =?utf-8?B?WVpGTWp5aTlQcXcwYUxlNW43bituSVp3K0UxS01MR25mK2xFS3JWWXBkbEh1?=
 =?utf-8?B?VVZLRWxPRWZLbVFCN2dhZVFlNHdYQW5hRzgweWN3bWNNWlZoZi9iVnVVaHV2?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd89e98-a84b-4642-c8c2-08dc159f9f8f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 07:57:30.3595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUS4jW//hgTtDVgWzIRiO/eHv/TofFKlW28Wu4lq2Q4XCqBgINae5CWaB17+ZFyHPNAde6pUrNY427z8be348w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7980
X-OriginatorOrg: intel.com



On 1/15/2024 3:51 PM, wangkeqi wrote:
> From: wangkeqi <wangkeqiwang@didiglobal.com>
> 
> It is inaccurate to judge whether proc_event_num_listeners is
> cleared by cn_netlink_send_mult returning -ESRCH.
> In the case of stress-ng netlink-proc, -ESRCH will always be returned,
> because netlink_broadcast_filtered will return -ESRCH,
> which may cause stress-ng netlink-proc performance degradation.
> Therefore, the judgment condition is modified to whether
> there is a listener.
> 
> Signed-off-by: wangkeqi <wangkeqiwang@didiglobal.com>

Regarding the original report:

If you fix the issue in a separate patch/commit (i.e. not just a new 
version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: 
https://lore.kernel.org/oe-lkp/202401112259.b23a1567-oliver.sang@intel.com


Could you please add the tag? Thanks.

> ---
>   drivers/connector/cn_proc.c   | 6 ++++--
>   drivers/connector/connector.c | 6 ++++++
>   include/linux/connector.h     | 1 +
>   3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index 3d5e6d705..b09f74ed3 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -108,8 +108,10 @@ static inline void send_msg(struct cn_msg *msg)
>   		filter_data[1] = 0;
>   	}
>   
> -	if (cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
> -			     cn_filter, (void *)filter_data) == -ESRCH)
> +	if (netlink_has_listeners(get_cdev_nls(), CN_IDX_PROC))
> +		cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
> +			     cn_filter, (void *)filter_data);
> +	else
>   		atomic_set(&proc_event_num_listeners, 0);
>   
>   	local_unlock(&local_event.lock);
> diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
> index 7f7b94f61..1b2cd410e 100644
> --- a/drivers/connector/connector.c
> +++ b/drivers/connector/connector.c
> @@ -129,6 +129,12 @@ int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 __group,
>   }
>   EXPORT_SYMBOL_GPL(cn_netlink_send);
>   
> +struct sock *get_cdev_nls(void)
> +{
> +	return cdev.nls;
> +}
> +EXPORT_SYMBOL_GPL(get_cdev_nls);
> +
>   /*
>    * Callback helper - queues work and setup destructor for given data.
>    */
> diff --git a/include/linux/connector.h b/include/linux/connector.h
> index cec2d99ae..255466aea 100644
> --- a/include/linux/connector.h
> +++ b/include/linux/connector.h
> @@ -127,6 +127,7 @@ int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid,
>    */
>   int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 group, gfp_t gfp_mask);
>   
> +struct sock *get_cdev_nls(void);
>   int cn_queue_add_callback(struct cn_queue_dev *dev, const char *name,
>   			  const struct cb_id *id,
>   			  void (*callback)(struct cn_msg *, struct netlink_skb_parms *));

