Return-Path: <linux-kernel+bounces-128351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 901428959B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1011F22B2E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C4B14B070;
	Tue,  2 Apr 2024 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTvygbqd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362A0132C38;
	Tue,  2 Apr 2024 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075186; cv=fail; b=V//wlOLbc4CDcrfzSiAJPRlcofKaU7SUFOc+8vIY25fm3rLIOCT9oA6cU+l+o7ey0KFlY5MjDubcYyBsIMnO2g537smY0+qWZF+QGHBKGLv9csGJPSVApP8y0X7NFYukFodinYq3VeArCS48bBnZw4UmAXA+JPXleS6g8Jvfi3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075186; c=relaxed/simple;
	bh=b5pyLzH12+e+WGzKyffp6ECljJCOyK3Z4t9n5lSbvAk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mdlgRSmKJjUSJqxrbt0KJUyZWIDFA+4EzO1XdsS0bvKtRqdgwh0zt4TS5g47wMQysx82ZegoSsktUctlTZ1n3YYmY+Py8f1DxMICdEBOCOHHdlw3NaMfciuqGZZkmriOByFPSe3cXHRRsQs4Xe5tj4a9Rz9hK4r0mHi9bs0hJ4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTvygbqd; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712075185; x=1743611185;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b5pyLzH12+e+WGzKyffp6ECljJCOyK3Z4t9n5lSbvAk=;
  b=HTvygbqdrfkAiFXbMMMmdtlvN/q/9FQ1LcpM2YjBZ9V1r1OgBirE0V7y
   r4GAgqb4ODpItUeCMHogErNRyDucODpd5hCHKkOYT41fumys/zhNqw8SH
   w04JhIHZcTAS/5LJLP8uxapuOJVfv51muYO1JgPOu5wfm1gd52aa/fuMT
   q47ovNvHUhE6pm4qlXvCQ7M3IhDccfk8DxMJFQY4Xb8fyu7AisAKRCRkN
   XPHsZxSYZv71pZamqU+cIfOyS7C++fpNcXcLQPkUqGu1Fo6dEOL3OwHZs
   uD108/vv5HbdQGcar0Yvo1VHLXREaRtRQZImOojXm1q/31TjyrrgH+4ed
   A==;
X-CSE-ConnectionGUID: 9fi/E3gUSjq8dci18Uw6Iw==
X-CSE-MsgGUID: g3ae6o3ORgCCYpTmsKWUww==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17880949"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17880949"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 09:26:02 -0700
X-CSE-ConnectionGUID: i0DuZE1fQhur2oE/kg6DTw==
X-CSE-MsgGUID: KqWNSXR/QU2d9VTyPAnZdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="22579284"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 09:26:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 09:26:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 09:26:01 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 09:26:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQVyw4bLzt6zOx0hfT7WUGZsAp2sC8scWRsLlaYbTeGmA6SK+MMJNpmNBmkyaj4FfsOOa2g8Hs+G7UpBailHyNrz57KIKTGv4C9oh01TZ1qqhS+5Qm7bX8JPXIIo2LJCP4rUDdSwKjgAXRVMlmChZU0n10OnobIPMUiEyhLWoeWak4korLdUJjQk/bbALnKs5RPMyJLH7e/vHt3FQ3ivz5AJxujM+Znh/X3DmjN5SZR1BaD6z8yWqCvFCTPkAOBD+cWqvuXlHGXljn4AwrtiQj/Se/gH4PckAkoaeK+YuHqjxLNzZK+caMvF+PVxqa1DJlDBKBjBJbAX32yfjDnHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdPyqucEjfqre3jBSAPQ7zbAWvaquMSazpvO5R3LIY4=;
 b=HZ/HGDPrCU2XUPM2KmsRs/qGVdgNJ3BEUyUQaDj7uungI2r97JGyw58XQbILyqpJo5vmc/sDYeXIkhcqEMO8DfA5jegNRV9cSyrOC+gg2j3AaLe3LuZyWlHf5fSqK4nNNEammcJHJ9u+Nz4zrRpQwMKjcAf0ZdsvbwS8wYnKyX0kYnMlQduGOBMkczi/fZoqujoOMl6d51rRW/hfbcAvbo3ApEywQ4PJmBfJ1cStYFUPkGv3OP+8YpqNGXjc8W8OGh3v/IHGGPJWDVKxOjBN+KfplnR1kN46FroV04hOq7OSqSvwBSxe6fUp6if0Vm+3TEa1PC5VmiIYqP8Fz2ebkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB6889.namprd11.prod.outlook.com (2603:10b6:930:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 2 Apr
 2024 16:25:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 16:25:58 +0000
Date: Tue, 2 Apr 2024 09:25:55 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Kwangjin Ko <kwangjin.ko@sk.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel_team@skhynix.com>
Subject: Re: [PATCH v2 1/1] cxl/core: Fix initialization of mbox_cmd.size_out
 in get event
Message-ID: <660c3192f30ba_7cf1a29410@iweiny-mobl.notmuch>
References: <20240402081404.1106-1-kwangjin.ko@sk.com>
 <20240402081404.1106-2-kwangjin.ko@sk.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240402081404.1106-2-kwangjin.ko@sk.com>
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB6889:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /POXWjjy3HiiyP0lOB4JHE5eNHkhmy2OCMHeo1hRLqAoGpmHZt+6A1GeEyH4qVhaABCzALgo3+LjK2ojkhGgO6vZLYzT8Zco8htxjJj5ft1Er9ozdiTB7ZaQLRJ3dvo90y1gA4sb7bWk69JcZBDh5Be3K+jKjpPLaUOiJ9eVUb4O/I+dD27EZ7hT1eXNSh690CzXKGLiLynhW7h7crXCsGihK7Ht7bZdnCWYf1nNPQKZ6azGIvAE2HWCpcW+9/l+Pl7z0eXuIvsl0OfhCOZgosGI5lvpErGPG0p6n8yTFQRPeyqMG6FGvpAEOTd7ZRL0Cf3iNJaX2iyFaWkBN7dIP/sVBxivwUW73uGHZKGT2vQx2MRCDzvz/s7qwDOf/DEA2UzBlQxkB/wv5DarRVhh5oEADqBNHyaquI0cjezqupgS/TUS5zhTbg+Iw+Nfb40ZdavqjJHjvD5KXRqwazImkJ+xhVscJq6o0wiAjU+Y+PwSp2NPdpFsgIbnp9yJ6ftf0wZ6CCuPbC8IODup+JPPH+9B4pztn5H6t5eVI9pQpaZij9PBUnNf38sPvhPvjQlqop8ukyIIFTCEIbF9qAso9vsxgGvj4I44Iv0Z74wThyw/vzS+aTrbc+C3qZ0vm2GpieRZDTAxWthJpul8h1rYOPfLAenKmLX7vtsSE/rfdTo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Js0AAYUvNzm0NE3dzp7wOabXwW6navsbW96mA+Jk2y/oJxKwxBikXMy1ivcx?=
 =?us-ascii?Q?M+Iv1NOL0OjYZWj0lamv9aRqZuMQrqmjhKZNQPjT7XCBfY+Nfwws+pwVT9xS?=
 =?us-ascii?Q?iz0NMY5rnUwdkquw7rHf4qJACfHnozOxbyY0+KZ7OPXVjwDTcw+bSciOXwGs?=
 =?us-ascii?Q?hnp5X4vmxcf+wFdadhu3kS/2rl2X3yV6RuW4XN4vnRemZLjAz2rfnwItwkft?=
 =?us-ascii?Q?7g/CJ5fXOqNefFdiXaLtDeDpMnHdr5tqOR5uKqyMYYbL6Ai+LuBHbtofnMWa?=
 =?us-ascii?Q?rVVIpp4akbVROLWUf03xbMdrgaK4xO/KBPDPBKk57rG+Wcsz3hJX65UmLrkE?=
 =?us-ascii?Q?17oXxOX/c0P2zlDr3CXulR8xwchbRaOU1FgacN71ma7+xF8ay/7w3a2d216M?=
 =?us-ascii?Q?ef2vV9xIQqGSHlSsgJCROgrcgZ0F5eUiRDggFa9BgvfKQJ5lDech/tKjQLIQ?=
 =?us-ascii?Q?g9X18VhyItpJa6RvrofLnXh1Ok/KqVBFwc09wqLEVQFEfxujP+jvAoBYQkOe?=
 =?us-ascii?Q?osfFEj85xD2xMrEoLNIVtiO6HcrdpoxH2zXCbkagZyFjBwJb0DnzuYO6TJUK?=
 =?us-ascii?Q?N7+pWIEalFqVEVMLzXKJM9ZCMS9qGMBV4OZYA7oyk21Sjl/6mQqUMzJEvop0?=
 =?us-ascii?Q?Csmat8YI5SO6G+Tccy09qqsVJIbW5ZUqHLCrVpQ+d/MDZt+IboWkBhUfZIHB?=
 =?us-ascii?Q?LRMK1wkskcz2PRPwNqK+AUoRY93xSoca6YEEEix4T/yUqrku601d+XjoPb70?=
 =?us-ascii?Q?4AS36kfa0t4tsCSpOcy4oAltQx60DtGleYyKTrunXdhbBUDpjs7PSqSNSKUY?=
 =?us-ascii?Q?dz9V4lNFXq4DrKX1bLFbPVIpqvva9fTmA08zXr2yXSG+IdlSJyqCXmzE9AFP?=
 =?us-ascii?Q?Rrd9VhTu64xPGv4GpdCgp3zPVZW86WhIB3x46p1DIv+KpzM3PP6Bd6grn1fx?=
 =?us-ascii?Q?ylq0mdkNCl4Ahy+Uxn4hpEI72jHLuGVV5YNlb1DGftr+nrtPIaxZVKdjhPly?=
 =?us-ascii?Q?0o0WjET0eY7vUglffSvul2PXfVNcySvDnCMPsMEtLQCMOneNEkLo3Pve2Zsj?=
 =?us-ascii?Q?lpcW6d1IhD23iZR9TENHIzsxk4HiQcxf6Cif8jmHCCwIXKKIRHzZOYhhwyl4?=
 =?us-ascii?Q?D+kLGydCZf0m43uKaHUMPeCi/Wi/D11apncdnAznAbeRTsVYXJQy1iiiTl0n?=
 =?us-ascii?Q?H7hxQOiKSTtwQFI4yLIf4YIxnLVmxoD/QjTMFaVn9gZK9njaq22FhCB6mq7M?=
 =?us-ascii?Q?sED9k/evXyVZmrai/ehB4gU9EcBbrj3BUnCVaVBgrW0OFwKhNJjiTxvqRSAT?=
 =?us-ascii?Q?+uBmNZy5NojB+UPaMUikQgVqzheKWMu6P7Btwu6a/5szRU4swQRCjhLZMbOT?=
 =?us-ascii?Q?iGjOVqieDJrkoBiYA3rzSdCrC5a0MESrHS8nm7jQ80rORQrxK115df8G4jRn?=
 =?us-ascii?Q?r6Vfpr5Yg+tJ5uTRe7Tu2XOQqD3qw/06hhX5DFrjaH+xOOcywRm1r3FoduCu?=
 =?us-ascii?Q?a0YbsPeQidISxv7siqiVU3kaFg8AjyugjpuU23KY2eZnWdOO85+rTVZ5G5St?=
 =?us-ascii?Q?VpiEN2pmjme2sfjhkhcUvuz1hl2msUL7egF/p30f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f56999f1-0048-4dc8-7468-08dc533193dd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 16:25:58.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWTQIDGyOVFdvLNP/DtySPfcYURyxTMyLCyd/zW6jZmc0d6xkEQDXFlB/RoQqU4P/+FZ34t7d2bmlXobnphiLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6889
X-OriginatorOrg: intel.com

Kwangjin Ko wrote:
> Since mbox_cmd.size_out is overwritten with the actual output size in
> the function below, it needs to be initialized every time.
> 
> cxl_internal_send_cmd -> __cxl_pci_mbox_send_cmd
> 
> Problem scenario:
> 
> 1) The size_out variable is initially set to the size of the mailbox.
> 2) Read an event.
>    - size_out is set to 160 bytes(header 32B + one event 128B).
>    - Two event are created while reading.
> 3) Read the new *two* events.
>    - size_out is still set to 160 bytes.
>    - Although the value of out_len is 288 bytes, only 160 bytes are
>      copied from the mailbox register to the local variable.
>    - record_count is set to 2.
>    - Accessing records[1] will result in reading incorrect data.
> 
> Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>


Tested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

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
> -- 
> 2.34.1
> 



