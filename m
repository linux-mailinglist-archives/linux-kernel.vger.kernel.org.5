Return-Path: <linux-kernel+bounces-38819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD8E83C66D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5721C24660
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEA76EB78;
	Thu, 25 Jan 2024 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LCm3Fv6m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B660269;
	Thu, 25 Jan 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196111; cv=fail; b=ftTCupWjMacFCBlNkAIroIq9eG95JG5uHTigZQSUQxDHhbwqaOuMu1P+7jRDQoY73AbFPfjfnhyOefMBbFigITIxkUPKljLORRJVV3EzPW3KtYQS+gqfYY+Iy3cBG2+IU/yR1gIVD0/CINczEi4axe//RmNtQygMcSqoRqa6e+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196111; c=relaxed/simple;
	bh=0hpRmed/kBOYALN2H2lld3CoWjmJGh/Tez4CJn4N0h4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ndi/HxKkokBQJ49ns4vP7ycnKYzogi8WmKD0rAQAoSHboGFMuWsQkTsepMUam8j8KXxSdAmlhsvCiDZvDPQNS+SmvCuRz0V+GvzwhxQugL+c/edO7rjM+fB8DYM98MftBaJUXgDQBPjHuzT75xC3e8XKutXqxJplQJoz7h09Mi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LCm3Fv6m; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706196109; x=1737732109;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0hpRmed/kBOYALN2H2lld3CoWjmJGh/Tez4CJn4N0h4=;
  b=LCm3Fv6mZqr+Fy7bKybHOYAVEHoJxEW3Wl2dNqd9MhN7iIPMvMamxhwU
   CGxlPq7DeoD9bd6nCStfeO1/J2giMC2LfbbqU6eUSSotqZD/X5EpbIUx2
   uREuIJS9rvDTryZvHIoevuyo8R3WlNxmwtwtjKmPX/U40cYFixP/BLJOZ
   7Gmj17pLjgfxyE4WLm1z0uXbL6YaJIqTgUbr5i8DIGAm6RY1jtzSLpda4
   /8mc2Lo0NQGGaWQLzfefhadK5cwHxWe9ehKypKCB8taAMkPxzS41ty3cd
   MIZM/bRKOStjY6648M7XnRKVNIfPbFFkYxQGQLrjCr4GTl46ranlwR8W4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15724270"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15724270"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 07:21:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2434236"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 07:21:44 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 07:21:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 07:21:43 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 07:21:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaIvOitP69hLZQjQpL7IEkfzRcyozjHDX9JCv/jiT6+KmAywdPpladYJEAX/jx+qhIfDZu534gD/RUEYuFHs9/NkDuZIwWubC1eIQenwhV+0aI7a/XLw37Ev/8C4Xfz257bEL3Afv8VCNVPPVIjjx9Nra7E6en+h966h0fWfufpzKlR7clfS4nIyVv40jBTh/rF+M4McLZZFzRaBhmWWoOOmCwgZHS6elkCKCLVtvSyrg2auzSMHVXQkI7rJQGLJoYdez39ZWWfFfGNQqRdo+a93Sznub06yr4+8Hf3sz5P2nNF3CpGfaeb1Jq7r7YB0P/HZ+LoPdn0TX5KvpVLB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FuzS+M4hnQrI8BqBQkmhZSEz140PFGyZ6PGIWNKvRM=;
 b=YaMxEelRk5ImJK2cGuGIXkFksJFPuFLx6SgYlltfNNQHqUhWqWtJw/vmp0iht90gG4xWXgxK7V50Rb9HSCZSo64m/QBJupBRqcrLBHXeyIjLX+tQtEz0Rjo/7xdCZkMBwx2C6C4aKDB33B2KtZ9/uP2rGutLqkxEnwYBSyJ4JnXLdADR3Fj6EjdwkYSfxuu4nGTHP7Jr81GegAnQ7MYIv4GHWBdNWD4gmBv6WmAPtWzWBjXmcko1cM2zqwwSBBeO6pLZCQgnUZGzNOgRSngiyJ+CySKMmq77QvOqZ/gbOFIEscwcgh73nqd0aaWB913WPc4dgDq+3Mt+zUw3mSC8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH7PR11MB5981.namprd11.prod.outlook.com (2603:10b6:510:1e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Thu, 25 Jan
 2024 15:21:41 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::42b3:9892:db7f:5563]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::42b3:9892:db7f:5563%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 15:21:41 +0000
Date: Thu, 25 Jan 2024 07:21:38 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Jithu Joseph <jithu.joseph@intel.com>, Tony Luck <tony.luck@intel.com>,
	Hans de Goede <hdegoede@redhat.com>, <platform-driver-x86@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/1] platform/x86/intel/ifs: Remove unnecessary ret init
Message-ID: <ZbJ8gp47CWDDqCb4@a4bf019067fa.jf.intel.com>
References: <20240125130328.11253-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240125130328.11253-1-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0142.namprd04.prod.outlook.com
 (2603:10b6:303:84::27) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH7PR11MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: b12a98b1-497c-4423-ee7a-08dc1db95501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHpV2+PqTst0bfDo9GVPVw7J8ZH8FMxpPqMV+o7tScwTHvzPw/5/s4CWlFiw3vezRWoFquJjZ9hvMXrC/8gRfAKM/4yIvy/O1ll97fkWq1S9JNXKxilZ87PwrFfxgisCms2FK1xEEMDV6Lt/Ko1hyKpIz0ZEWaTnmZSeo29//eGCrbU4Uc7VMiELSEh5F8r5g7SX+epXh2CKTEuxZnHKI2k70RJejzCC3PqYGH4Cb0HmzQzkoEQsy3BN4tfCYQzbtuWIXNOirVYMeNyu1h3WkQwAtG6k+7zWwPaDuNW4kv0YKgCWPmhmSAvjCZmRCRbn5pSLJY7GejE3TMWXPjmqagQ9FQ9zuZ0Ipf3yZm0NWwIM6wCnX4V+UziLf5kIQLgaWOS+n3W/5cDG973917KM4xp+q3vwwj2Vdhtsh9NCymMiuG9fgl5daukrXDq0feCnd4VLVVMrNyAe8zJjq5EIyH+kzuZbDo4hYC8M5X9uWJJcBXQwXE0kcC2RkgyQrP73OIMFfUTTgTaQjVj6YL2mOzwnR+xJuKFUYKE/EDmIhNCzaEfMg42WnwKhL+9OGE0W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(38100700002)(82960400001)(44832011)(6666004)(2906002)(54906003)(66574015)(66946007)(4326008)(8936002)(26005)(4744005)(8676002)(86362001)(66476007)(316002)(66556008)(5660300002)(6506007)(6916009)(6486002)(6512007)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tklvVCwYNScp5/e9qSeqeTKN/ttN0UFe31XADKSvRq6PPd1fxzqUQXa8xK?=
 =?iso-8859-1?Q?3NTF+M2Ms6koX1RzBt0Qnah1NiFF3AHmuKk4ympngn86NMYy4Id9DNsITJ?=
 =?iso-8859-1?Q?oaHS6xfT8FmFI6gCUgoveKlgt7TsVma9Am4Ok7AsJ3HvZDkRxkppL3XTvs?=
 =?iso-8859-1?Q?FGV64idZ+HLOZCd4hm+Yf2+EaOmFzAdLyxwvs5t5qYsqWqzLb4WnE/LJ6j?=
 =?iso-8859-1?Q?CnSuOXN4SuHTXMZc1l3eVQG7M0srQYeiJKGDShp/OojBuvTIiwvS/B2u9O?=
 =?iso-8859-1?Q?CvvqLTm2ZJeDw2FeCqdGPaEJ5ce5LXvDEzETmtBfu18mSr6XJHPEAmSuv+?=
 =?iso-8859-1?Q?ZMkgcRPe6ceM9GQLbLuHkNjXMOZRTPZafn3p2JIJJhyERn8z9WunlrE99Q?=
 =?iso-8859-1?Q?nWKWCbj5zi8bUw3cf4t8UBFNaDqMkg3RQzZjvxKAZRmN+r23/i9Gi2NM/N?=
 =?iso-8859-1?Q?S4d2CIVnnGusnfK4y4euG3Rw6JYLHS+A2gkaeQt2l4DjWJf63W42Se+4p1?=
 =?iso-8859-1?Q?bYUmbL08M6b4392Ky4oFnr0NGtUDfV8CMtpvQbxZetiUndBvGQMP5RbsXZ?=
 =?iso-8859-1?Q?G+R2LQ1Dcorz93FqECeP77RmJf3XG9xc5A/5pOzPBl+M9eW/F9Ik1BPkSe?=
 =?iso-8859-1?Q?spx1IssR3p7sUHPEAHa8fHmqClVr/qU8CRIfVGHrhUspPzOKz8v7KKobo1?=
 =?iso-8859-1?Q?xPmDTAXPTRUnUm4Iw0EGGMqu7SRjL+ogq43/RSBCDBL3EHsmh9bokFO5I/?=
 =?iso-8859-1?Q?xdcBnohuGRFf5IKFfhNUTmB5k29Zj0SQUXU89qMLinxNHc3G5qasP+7ydC?=
 =?iso-8859-1?Q?7QX/R8PBdtLGVf10bKShjPA4hD6TlYfeZUNAEWvL0GMecDmGYC9qC7zdiU?=
 =?iso-8859-1?Q?LoIABBp3hWsu7uoxB324RK4BGRNQHn32sEaL5mO+FCXc/+NuPGyuCWdmVe?=
 =?iso-8859-1?Q?ElUw8qR7As2gpDAVXEbRXLlGYAkA/p5WnGNlnTWf2Ow8DSYFutMY3E9PaM?=
 =?iso-8859-1?Q?XeEGK77t7QaUiiwB72H9YdM2as2gNvaoeWNyffuEKgtu8KVlA3rxKqdE9u?=
 =?iso-8859-1?Q?idCApduPXaQI30cw5J+Q3DfQV6/HAoLZo5PrNtPusIoi+7DW5TkMicNEPI?=
 =?iso-8859-1?Q?K1p073xG4jGy7Ym6FmlFfmevizAHaR1HgOGTK8pbs98V7T56w2aa+rTfss?=
 =?iso-8859-1?Q?6R/pVcd0OHNq0ANnpl2+tUeTJkiiJ/dXyhpP2zmPxVHRWKIkbvclZEdVx2?=
 =?iso-8859-1?Q?hw0ZImoV53IkatawN6ItkUGY44nW/8sPAkpnmMLAFNGr0AlbtlgbT7gGFU?=
 =?iso-8859-1?Q?YRce9dQ9MeNwmBzy3KkpAF8UKRO+azKVPFWB4GTYmi7r70Tzczz50CAnKI?=
 =?iso-8859-1?Q?ysf6/1i0xd3297qp4befMFhuI6uQa6DthYSscM/epe2toTW26wPSAvE+55?=
 =?iso-8859-1?Q?LSsW5F8VkdB05PZacYfxG1Nyf0dWwEQCDTN/455wO2A9bPlBBGnKTZfF3D?=
 =?iso-8859-1?Q?z7ptA/O5gmrhJGyv/DqD3PH6gDp2VXzTrEVUwLrskc1gRg0fx9ieOgJOE5?=
 =?iso-8859-1?Q?1qYfSw8PjzRVgxdMuFxNiZIy69uAfU25vAsb8+YniVwNdWIhaOrFiJ2FPU?=
 =?iso-8859-1?Q?Rax90+636ADPlnN9p2g0jyBgSMhwRcYLzLQpCmAXRYRlYz3wvbefe0mA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b12a98b1-497c-4423-ee7a-08dc1db95501
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 15:21:41.3275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InEzfqcQlY8FzgRlWU73qwoMJ4alvqdM3vp9rgYS90hYAsTwHJfkKThdhvG0ldhvzXePCLeqUesvLGW/ic7VDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5981
X-OriginatorOrg: intel.com

Hi Ilpo

thanks for looking into it.

On Thu, Jan 25, 2024 at 03:03:28PM +0200, Ilpo Järvinen wrote:
> ret variable is assigned unconditionally in ifs_load_firmware(), thus
> remove the unnecessary initialization of it.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/platform/x86/intel/ifs/load.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index a1ee1a74fc3c..03e49b836a6b 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -383,7 +383,7 @@ int ifs_load_firmware(struct device *dev)
>  	unsigned int expected_size;
>  	const struct firmware *fw;
>  	char scan_path[64];
> -	int ret = -EINVAL;
> +	int ret;
>  

Looks reasonable to me. 

I can keep this as a separate cleanup patch, or merge the change in this
patch.

What ever Hans/You prefer. 

Cheers,
Ashok

