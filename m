Return-Path: <linux-kernel+bounces-127027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284F98945F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924F31F21214
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACF254BF7;
	Mon,  1 Apr 2024 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUHJbAvQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A8851C52;
	Mon,  1 Apr 2024 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003220; cv=fail; b=nnK7RF2w0mzI230KOeTSkAsHLjbGOOLSZJhNx9uGSSFK7Xn94dI88HsQVHR+NGTnKL0/MXY00y9uXn8/PDjeZHOcErzcmr0psS/5ru+p5A19t7u358zz0XRaW1ADD4xsbd2/QvHORm+H4voJpdhKnNvSNyZZClymynHiZV93T+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003220; c=relaxed/simple;
	bh=dT/AScDTEK+2rlqfqk/hZ+gmPDRHi99IoEcrZWnT/Lg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GSxQavHSAok6i4qPPsg63wQqqTT13R1bhNwsf/QqnxH0rxZHoNYEL7/SZYsFst4nFeh2Z3JH9g2VH8lkJX7wV5fKvZZLdnG1VvWTshW2KSMSdj0Tuo/SrhcsjqX8dt6Cb8DLANpO+yU4lhKV349arW37CEn2BoxuEE3hfSrrNyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUHJbAvQ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712003218; x=1743539218;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dT/AScDTEK+2rlqfqk/hZ+gmPDRHi99IoEcrZWnT/Lg=;
  b=OUHJbAvQ8EJL5bqUV8NnKjlCkLsQkb/kbNYQYwN4G8TbBfcOOtJEIIBC
   i3G7KrPV0Zap9d0LvrshZsDrIcYPIvogussJ2Z5V3KoRb3rdh027nc8CG
   JeE+ao8Wquw1B6B4GQRqRVQ6ushaWp+9RDuIOwODouYPKiur1GWgfabE1
   H5oQzN+HIHsxMp4WM54ntRuUi+tNOGEctCIAo2qf+VFDfOfAVymrP+aDc
   +pPjDZ/P870/WW38q9BUfPTxQcxwVxteBWS92KcXSXx2jgU0SkRDEILEZ
   asaVasG/BdcdLWEB/UEnaGkdFHlkK15hzJQKm8BDa4KPJnMiNJjPe9MSC
   w==;
X-CSE-ConnectionGUID: 1IVSb01vRWWAcz9SihzeGg==
X-CSE-MsgGUID: AIIA/t+yS++zbQAXpdxtRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="10967030"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="10967030"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 13:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="17906883"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 13:26:57 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 13:26:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 13:26:56 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 13:26:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YF18wjTflCoekNqv7hB7ugM5fEtAxk5MVF4j11uDKcdrTyfq8A97nI+XtQWK46w1yhDkb71aZlyDLTgzThlwYOnDXV/DXc81PBpQPrnPBHz32kr/JD03VshPW6ycVsbbFXa2DBtSfuQHRGn7Z/1vtYOk5Cb4V+eQbOyTzliROqMzSvi69f7spd7HqfGsXHdcbAfJUzyqYf25vYuHRhzYM2e+lCmjYYzbLkWUrHSeNrG8+eq5t9AnZ7yYAd0wuB9vFNtd3DUsEFfCaw4YBJsnVg8OVzgCj2SIbi6O74uwbpAhLAIAtBmFQ4dYS642daRIw29leZMLyfW7//v/OPSuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9Tun2qcZaiVDDsRhLwGKLkYZAZG0/AURa6ey0rKhBc=;
 b=Od8FhVyiWipYb8FCXvr4x2tIkMlEToK2DHwJW2hLAv0SNBkMabWGIcJfP18qm5myDoOsVQ9pgEhhXq8hlM5MZ726xW0Xu4y1kKXLtCUD41G7Dq646MVWHW74mgrnvTXMA2VVIh33/bKkgJb+Ms4wpWdSUbAMy+cMlEnSkGMDRY639qqSXZ52tsINchIB/fLAYubzfAgJSfK10BD3u1C+Vgv1/zEuYPM4g1w1ryyjE5mMHydyWaP/ytgIuGbfLdpC4+Vvafpq9u7sTm8L8HyZ2A/cehqfgwFQ9CfDy39nL5q9VZPUL7Su+yg52QfIXrLZLfGlTxRMzff0U+SpcmbMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV3PR11MB8693.namprd11.prod.outlook.com (2603:10b6:408:215::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 1 Apr
 2024 20:26:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 20:26:54 +0000
Date: Mon, 1 Apr 2024 13:26:46 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Kwangjin Ko <kwangjin.ko@sk.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel_team@skhynix.com>
Subject: Re: [PATCH 1/2] cxl/core: Fix initialization of mbox_cmd.size_out in
 get event
Message-ID: <660b1886315db_750ac294bc@iweiny-mobl.notmuch>
References: <20240401091057.1044-1-kwangjin.ko@sk.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240401091057.1044-1-kwangjin.ko@sk.com>
X-ClientProxiedBy: SJ0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV3PR11MB8693:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MaoMSKPXJd46oeyjgUPejwvjj03aR13uWXtVmekux/wEXnsUbhPfYY6g+ytqAUcp01c+BmKd/uDZSy2SEi65gEH+yH6eDA8HxmoSIMa74d56asDPQCDLV0c8WJGcuZqQeuSfqic46RuiD7T5akV6i48sSWDSmAEHPOvSqKXxXO8Y55+y4CMKfgoc3BpNmPAtiKu3YC6LQeEhJPmpjKcCNMVh1/RdkHqGIPLvRMmkifuX8YkgrOxHtfxZf1gi1nSThSe23GPYYMofUS52UT1JIAmuzaQlOYqYqyOkQIQBtvOar7OJLmn5qjwnIF4//ebbNThea44cV5JggJJH1v5+kqcnWaKkWx2G9+Nt56oD1Nt/KyfvdpjXgZA+vTtAlYTGy/I3iHrs0zf0nfdI87AmMWqlXUSqf6je/rytvdQSdKaGEEsX6diDZ3IBkjBfvWwcKbZl5AmDcV3rCBUuuqjJyCwvLb3vX9tJ2TT6GbaY1+MNiMNDfpHNREdgiPaGMISZ64Z5uxTE+r/a/BIMoTR8ocWBlzrSVuA9uz4xiKZ0UFnJEz68ceKLGVNuILvfvWV4NL+re3iJuT8K0hrMQtBEOFCSdZV5Fhm+TTiLNH+nlAEai8CQXTVcpNdIfcIt913a7VU7ydW+dXPhg6K+ZmoYlnMTrNBkVjn+oOWxwQIE63Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qCTywhjYp6G9K8a246VT1cQcV7mhOXqPw6z+PUDr45Ujmc+6HlvRItJC4rJU?=
 =?us-ascii?Q?U8pXM7P/iO4nOdB2RaFck5URhU4YMBu8jSVzidvs5aoq8ojqJ2gfFLDgyGk3?=
 =?us-ascii?Q?MHz+Dp4Ss+f2Kh6t0NyqAfp1BbRPNiuzOi5o1KQVqVvL9EvJqYBbLGcDgqbj?=
 =?us-ascii?Q?nMh5TXKN9JfQMX6bPZbzPzmLAuSx5GSQu6Z4DCB/7WxZ7iRnPLroMyOFcqhe?=
 =?us-ascii?Q?fwNLRz8LVe6VRyrWwPqFPaCH8udUuTgxMMNAXaliF+XvNIHZSGeyM4fMj0Aj?=
 =?us-ascii?Q?4BW4YqoiWEdJG7KyYiK6kjye8nzguWrG+ilkP4ubkHC/HQcI1Hv8iyTQuBS7?=
 =?us-ascii?Q?wRqwp0kCX8IlFyziAu4T0RGNhjON5LaR8zC5hyYFt6mw+jcSRLV2KCdrADw1?=
 =?us-ascii?Q?ho0Pu8nPpYn5zdIX5HX5SGmF3YIeVlZxkka3GnDyR/P5IEydlaejPb6vfTTy?=
 =?us-ascii?Q?Xec6kqsHhZNMdHoKpEGqaKDR+16rEMSUjB33LIdmzQftFeGYQ8N4yPH4Lj9t?=
 =?us-ascii?Q?MiuoB/PNuHrtl00sZ++igt3tqShJphIUw4Fz+WxIrkbaacqbWXxclrBaiAEp?=
 =?us-ascii?Q?uqm1tXxVkW4ljb2WTNBoSnO8XOX0/Bjy+sw4am/jlIxwTLKta6ZU41MCK3Ix?=
 =?us-ascii?Q?vUrqlXXWDulOzdT3MqLkxSEkYfXWxyccFdNB3J3MOLa4l9Bq5XcpM66kJb9C?=
 =?us-ascii?Q?DwjiktBFEH3GqgsM9YB0x8B0pwOWFL386S2VmMucsSGE5fQ3NKDPCxOQvFmB?=
 =?us-ascii?Q?+UkG+b07ijktpsT7aO92YeyLRLeDoyZgCKWNl8Nn4q5ODyDR41H1zJVTmN9a?=
 =?us-ascii?Q?46B/kjSrgR+UEDDXBiop7YHFUTzUxTOWsbXah8IX60hMu8+m72BuDo2WvhSn?=
 =?us-ascii?Q?0P6tfdxOvjjFDJxL2TMEE1jUEhKykKMfsv+DobcTt5ScH2U24TI1qf4Ol96O?=
 =?us-ascii?Q?sAb5syLrDe8CAyFCo85ks1k80GVqQddrBcnKo1wJ+/GQjLRE6bI/Y1k1LiPn?=
 =?us-ascii?Q?0BYv1NNjCzeFLxl1IAo33cdzm6FLYKfe3R7vgr40d7z6O8uJtCgSNZk3xF5M?=
 =?us-ascii?Q?4V9dNCZtznYGHMes9mTlRZ2pvFCYYKt1DV7yb+Zxbam6qkZYShCtviJZKIgk?=
 =?us-ascii?Q?EEoE6Msf/Ws4TuIvMUtlnC0zZbrP7CabPz3esNDEDGwjnOC9JQrqcA1MUfja?=
 =?us-ascii?Q?zuopPvZN5/Qj+kOA27p7zPupbgsnFkcyeLC2y6in9pJmWAqRsXUYbwgrl4VC?=
 =?us-ascii?Q?ndHLaNeqzk3N5G3suPBTM45q48/gFjBnDXlloIdqHfwk8N0a1vl/Jk3kWk57?=
 =?us-ascii?Q?/zdQgJd1RM9bvxxkb0VDP8kvpz57mTnRW08dOd15OgxAJsa0qcrfXRVnmeTt?=
 =?us-ascii?Q?rYzlntK6iR9DKN0Cse9qcde2PYi2Qwz9HnSORqJ4o9pO1ypghBsrkfqXCPBP?=
 =?us-ascii?Q?wD3AEnFQPPk5s+OvrJfsKGRghNKhWNaussXjADhOOW483iYOuUPJMSYB73KM?=
 =?us-ascii?Q?vbhDmiicmcywGf3+fnLifQ91Jb51AJe3PlU/lA/FHhEUaSmUmer+bYmaZxT2?=
 =?us-ascii?Q?5dXrdB5y0/vKGXRmwdCyqiu8joGJTIoe7dRVsT1C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb34a45f-483b-4874-082d-08dc528a1202
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 20:26:54.2724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wY1pJqeeiI+SYb6Xa68MXG2uCAesKz/PQ2s85MoVXm2pTJROj8Txm6KOrTXfBOS3X2Qp02tDT0vbpzrCO8kqcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8693
X-OriginatorOrg: intel.com

Kwangjin Ko wrote:
> Since mbox_cmd.size_out is overwritten with the actual output size in
> the function below, it needs to be initialized every time.
> 
> cxl_internal_send_cmd -> __cxl_pci_mbox_send_cmd
> 
> Problem scenario:
> 
> 1) The size_out variable is initially set to the size of the mailbox
> 2) Read an event
>    - size_out is set to 160 bytes (header 32B + one event 128B)
>    - Two event are created while read
> 3) Read two events
>    - size_out is still set as 160 bytes
>    - Although the value of out_len is 288 bytes, only 160 bytes are
>      copied from the mailbox register to the local variable
>    - record_count is set to 2
>    - Acessing records[1] causes a buffer overflow

I see how this causes a missed event due to only 1 event being copied into
the buffer but how does this cause a buffer overflow with the payload
buffer being set to the max mailbox size?

Did you simply mean that records[1] accesses incorrect data?  I agree that
is an issue.  I'm looking at a test for this.

Ira

> 
> Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>
> ---
>  drivers/cxl/core/mbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9adda4795eb7..a38531a055c8 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -958,13 +958,14 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  		.payload_in = &log_type,
>  		.size_in = sizeof(log_type),
>  		.payload_out = payload,
> -		.size_out = mds->payload_size,
>  		.min_out = struct_size(payload, records, 0),
>  	};
>  
>  	do {
>  		int rc, i;
>  
> +		mbox_cmd.size_out = mds->payload_size;
> +
>  		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>  		if (rc) {
>  			dev_err_ratelimited(dev,
> 
> base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
> -- 
> 2.34.1
> 



