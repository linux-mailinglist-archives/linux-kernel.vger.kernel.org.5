Return-Path: <linux-kernel+bounces-100742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D446D879C92
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 172AAB22C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDFD142908;
	Tue, 12 Mar 2024 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jcy2dsbw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34DF142901;
	Tue, 12 Mar 2024 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274039; cv=fail; b=R0v3AdHIhUIhfBwsy+i5nT0IiVE3+Dtxfkzhj45/nPPz3RML74tdOrqZX3uwMryLC38ZoiPslCCDhKiNH0zHDlcIh4NXsDORWLnC/i4db/WY54KXm+qGebYlrYcewLS4KSxbGaC9uy+r5tOQ7U7bu3RZKp2maq2UjwvDP0aELWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274039; c=relaxed/simple;
	bh=L4ntPWYDB6Xe9jONNRChuOrNed6kJTNYm3Oai8a5EwA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jDtAc6csFr6hd1r3nyMQ13pXlYitczJvD4zs+vH6YX8UfN7zIqrOkBImxP3kOZBtAkvyi4m3SayKhXg4JwzIxvXXLf1ytn4dGENx5tRbahUbSYQY9Bne98SMbaBZzTgaqlpUAqHv4KMTn8ERhuPJksedn38WkU8CjeeiQI9yF7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jcy2dsbw; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710274038; x=1741810038;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L4ntPWYDB6Xe9jONNRChuOrNed6kJTNYm3Oai8a5EwA=;
  b=Jcy2dsbwVV7o3GQSrcw/BjNSYtsh9aP9FL4aA9g+ZaOJ7A93s653/qcO
   LqDCAKQkQHBUs5wSBTU2XkSlFuAGMlS0D2z5Zka/wrnTILVzKOH3l/pyP
   rNb76f6kQ+htiawNAyoMmHYlPHetZ+p4lIxIQmVu57glU5XbcvOIp63JE
   lRx2MxeeoZDqa6YbxlAFZKzIBGiLKLimxHVpWxfqu/ycbil2vWPUGO/I7
   119OPiwxtkWqY5YsjzbA3Tf+IN6Sd0GJxPcPQLr73/mO7Npd0I8Evqs9i
   UjYrvN4p0XCBZjxAXQDO8Wm69RThoq8rkRym6b6ViJlUd6SA5O9jsuIV8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="15733440"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="15733440"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 13:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16253044"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 13:07:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 13:07:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 13:07:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 13:07:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKzELplD0OgBdklJ/Rvw2D4M8PkLwH8AZwiT3f8gTNzvxnsBtmn23W+Vo27fSs8OWHUM5SO3lQw6HC7oPqNZ24e+8OVkk4w0Bv9MZN/ZPUWpwe/w+6dtrtKUYOQDSOTlG1IQ6g7MZwpQoAwhmAcfGbMzwQmtZ+bWYQQa90+ZvK4VqNogE5P/jBzYCORW86G/6VRJDERBOGLTDdEd3RyUdsRZP+bu4YRK6+FQbHgyPqjlOCWTvTSPSnTjqY2d0n0HWkBHRIQqAhPgGbpqwofvtA8LZMucm27A927hSjzz6xdC3u8oBca9VGoC5jWvsuORVssasDvu0etCLjLOKHvVqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6hqNymmNinyH5hkC0IIDuuNw2lAQ5syOhrWHDaZM9U=;
 b=W9OK5Ph30W2uXyKgYM/XpWjj4DjidVhwvnfh6HnaX9ak/HUQ4zTUpxccgqBLHLDQN4BiResGznsoOzY+B4iM9pD5O126VxVmPATV+qcq+dYMoCTXZJGyHleezEwgWQhFiYaalvm/3bwPWDne2h0ZN7JCU4Y2Km+aw/Vl0sygWq2rMixJNXBFqODn9Cq/2V4AVK8lU9HkwPerGUcC30P5Wkbl66XG48f/89Zq+iyl/CAELqMgwdbkUzZepjiv0bIGtWgjL+Dyf02uy+M7MruhBfCRyWpK8Gk/hDMK6TJasRYt6Kf+RCZUf/GWJ83jJCF6tcZyOkQo59cVsYYDAgG9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB8073.namprd11.prod.outlook.com (2603:10b6:806:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Tue, 12 Mar
 2024 20:07:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Tue, 12 Mar 2024
 20:07:14 +0000
Date: Tue, 12 Mar 2024 13:07:11 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>
CC: <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, David Hildenbrand <david@redhat.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Huang Ying <ying.huang@intel.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Matthew Wilcox
	<willy@infradead.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v7 1/5] dax/bus.c: replace driver-core lock usage by a
 local rwsem
Message-ID: <65f0b5ef41817_aa222941a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240124-vv-dax_abi-v7-0-20d16cb8d23d@intel.com>
 <20240124-vv-dax_abi-v7-1-20d16cb8d23d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240124-vv-dax_abi-v7-1-20d16cb8d23d@intel.com>
X-ClientProxiedBy: MW4PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:303:dc::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: faf131ee-86b4-4b8c-2c10-08dc42d0023b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYEYelC6t6ISpqWpyvDN7xhkImsF4GvacNqnqWGU7hPl9Di/je8Fvwg8pZ4hsqlvpV4TEKciqATQPrOUwR/Y0G+5xacL0RenBxOtcc4kiG7LCBUALzgPIe2hLCeMUjVcf9/zwaTtSP2Y9/55KGk3C/pfGq644OfWfgJJdznq5P4rQj9ZH7tDbdGg6xQcbOQNF1bQtfZCda6fPgvCxUQWZyvfZ4UL5qoCoziYEa3PzoCksZK6b0b/SaCTCxyYIH9ekZrZvSvH9pVSIVRNNg7zIsPUPgrlNe7uTxWjaEYZJcmrFHkWintae93/Zulhh9uRfOJuGQd2GyEpNB2A8q373nZ1t4PmVQdtnFkMu7T/1RxLr9c3y/Ta5tQMPlKvLB64dmyO2OR63uuD7NyM8HAKzR1Q8S7dQhDZJbME/1LKotoIhpuv/HTV6jJx+1UMawnVNChwZwgi8weLB5Xi48abF+H+P5SUx7xBUPDpzKQhAj6YfDmpKV47wrDAss9CG1Jv+pFA4mZjmUuJ42CmTmy/YjMRrVP62ZhKlj11wfgcp0xBjG+BH2EdwUXXmRLGMQsJpvWQDgDWlckyJ0U4QOrOGq7NRL72IF+je9e4k3UjVzdAWGOR1VfCbegDJQI8q9E5xWxLHm1H5JYCOGNLUH02b9iJIEfHYvaad//TQHvy2bs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DzWfIir/dJgX7dJNUdas0VRxdP0QqF6OOxgX1syTZd15PgZ166MBI3BiSfHA?=
 =?us-ascii?Q?ytV/uvoV+PDH80Tp72kOtUeZk2CnAaZacF/4WIABNNlceEqmltQOflCJjSON?=
 =?us-ascii?Q?JQjJrv72hRPdfRP50xewz30yocRdV9rl110VIOZxRlZ781P+qEwhGu6/3qkh?=
 =?us-ascii?Q?N3HKDqDxtNmoXmPgqKAAyBGSQs9J7PGz/wlQy1tvj20I0EaqnrYtTcomjgp3?=
 =?us-ascii?Q?4KvScQS7rD0N+EpWrY1wmGXJXsVs2hqa1Ha141QP4AkKjSC5vYpoQ3+vmrna?=
 =?us-ascii?Q?fpyEnof+IP/Jqz/jp1wHw2Gkv5S43hDDt5XfmJmEhuXPXC6Rsxdz/Sv5vdGw?=
 =?us-ascii?Q?FBXtjhK3qrcPlyhvaOljO1h1Eo91RnNIFPgx4FQM5oCmTowjWHCaab2hVuWw?=
 =?us-ascii?Q?rHdZ45wodqaKRJF7AKghIiRheGrOlgZ3QNBv0AsEotGauGy8Hj5s/mPfg1qo?=
 =?us-ascii?Q?fnsOGvuhzh+RP9Tndx4nykBdmfOAAG6Ci70YHxk7KLqbSXGFOFP0V/AC4Hja?=
 =?us-ascii?Q?VQYtJe8/6B+lf54zRX7/0KGy+Dg/f4rH3SPefgDvKp6Ky3HOD51/tRUWW55P?=
 =?us-ascii?Q?kFgnAHZ31vnLR4Q9JkRJ2t35Psv+tdsOLOg6YbFL5OAZSr4amqzKh2cdHWz1?=
 =?us-ascii?Q?lIaZWXOh1demqwKs5dHzuHBqEjLWOZPi+wDgYtTDZikcvI8ajFDIfzAvMo3y?=
 =?us-ascii?Q?xh9+ivliGiccINPEVVFZ1ni4A0AIcNiffJQzRe6DgqtFgCbnIPbBokuIEOED?=
 =?us-ascii?Q?GRZrSW+Dp+BWebQX0U8dOBXB3MOJdqRp0G8upIkCACcDPTeb2aS3Ah9qUW5Q?=
 =?us-ascii?Q?W6hsQZ9l96KsHZC4ZlvDX6496H0fhb1dyga4kofHdaOqO+96jj62HVakoKwI?=
 =?us-ascii?Q?scoCxsMAxQsS4MpdmI7bjbPMoYNMer7JbIkkB/3+NFxnsvnZI4AbIToPyFRf?=
 =?us-ascii?Q?KqTQeqY9gikU7lBAZ3arF88BCxSiqSc5uIHEXQTsVGONY1spTH6hgrNHrx9N?=
 =?us-ascii?Q?1p7JJuKJsoorKcNJpgoSKGrucvYun58sLo0QAa4fwpRlqDMte87wkcKJbnFv?=
 =?us-ascii?Q?Nsh90LdsxFH3++K+8GjgcPNcV8GNaAhkZQObX1wsxGjE2LxJrh4j25/MqS4Z?=
 =?us-ascii?Q?3xmweU0FRUvD9YDk+/xEOU34TYasi06zQ49wEae2hg30YxkzrS0xaRzwdbfg?=
 =?us-ascii?Q?PIv03L8/jmU/Jjzf1PSaKE7btk0B6xqgIt5JbNn9TZDjDiailF4AUI+0mAZh?=
 =?us-ascii?Q?EfCTO05lPG8ChZ7vRzuG2coUSQxcrN3ncRp7pxqVqvYmdT4gJPeFsIcVbwZf?=
 =?us-ascii?Q?CdNqhHSGfRenGTDKLdWy6ACE+cdMalTQ13lG0CNbOsI2fFS4wiDGOEMdACcj?=
 =?us-ascii?Q?IWSasp/l/JWpxiUiVqR8ebVyd5EmkY9Uwic6HlRYcwrFS5dALe4qBIdh8Vhl?=
 =?us-ascii?Q?RbGN1hxLEfGrKQzdSs/f4BfKjZCZMr6gpHFDyS3UNbFNRIc2rAML93PnE2PL?=
 =?us-ascii?Q?NsY1YB+gMGuqBWCRLseeRA1/24qpLSXZVzHLko7wWngI1oV7iycH6NaiX0sK?=
 =?us-ascii?Q?xIafILORRJzjyQ+fbVbXgfL9yYhV7RWO74Kzwgi7LinjInJEyKTZGBaau5xr?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: faf131ee-86b4-4b8c-2c10-08dc42d0023b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 20:07:14.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N05pPaEks3awzD0sKgt5H6WCKZKU0bpx9dpuK2OJN6rinhSU07Qh6Bgf9qkRDAmKp4eyDxax2n2SvaNxfp5Vhm/9jxCY8JNyHnUafJ34YB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8073
X-OriginatorOrg: intel.com

Vishal Verma wrote:
> The dax driver incorrectly used driver-core device locks to protect
> internal dax region and dax device configuration structures. Replace the
> device lock usage with a local rwsem, one each for dax region
> configuration and dax device configuration. As a result of this
> conversion, no device_lock() usage remains in dax/bus.c.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/dax/bus.c | 220 ++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 157 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 1ff1ab5fa105..cb148f74ceda 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -12,6 +12,18 @@
>  
>  static DEFINE_MUTEX(dax_bus_lock);
>  
> +/*
> + * All changes to the dax region configuration occur with this lock held
> + * for write.
> + */
> +DECLARE_RWSEM(dax_region_rwsem);
> +
> +/*
> + * All changes to the dax device configuration occur with this lock held
> + * for write.
> + */
> +DECLARE_RWSEM(dax_dev_rwsem);
> +
>  #define DAX_NAME_LEN 30
>  struct dax_id {
>  	struct list_head list;
> @@ -180,7 +192,7 @@ static u64 dev_dax_size(struct dev_dax *dev_dax)
>  	u64 size = 0;
>  	int i;
>  
> -	device_lock_assert(&dev_dax->dev);
> +	WARN_ON_ONCE(!rwsem_is_locked(&dax_dev_rwsem));

Apologies for the late review, but...

All of these WARN_ON_ONCE() usages should be replaced with
lockdep_assert_held() and lockdep_assert_held_write() where appropriate.

