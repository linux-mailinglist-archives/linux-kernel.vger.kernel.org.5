Return-Path: <linux-kernel+bounces-108119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7365288063C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B5CB22FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669133CF73;
	Tue, 19 Mar 2024 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKqUvt+O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132E43C47C;
	Tue, 19 Mar 2024 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881105; cv=fail; b=JVPrxV80nwsAqSuzV5QQqdL5e1B+pPtxgytVnzStWzOvQEND132U52TTmb6usfSFvZ9K1eS8cv1bfF9egPSczDCQzfsJKqcnzNqT194u/zfMW+zgz4qNWB8kAMPe4vH92YGNvK62YSrx0WbyN9KlUKqlkn6+wks6xgXQtMJISI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881105; c=relaxed/simple;
	bh=9mB/kyh5WwCsN72St2YpMmUyRTc6MIOLSRyv/XC4ft8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SLz/OTHMwjatSh3x/yEHr0Bjm0/F/ceIq//jJHzECPiy0418liddBUzrU8EhAKeTlImK3nVIpuYoPQjPCrbMPyo8r5eJRSyqir4UdHNromvJVlQTVYIdTOBPEjOT45j4DqK6+n6hvPx/pfM8s0zziUmtT/xyHQaqQ/JEjhK9G7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKqUvt+O; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710881104; x=1742417104;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9mB/kyh5WwCsN72St2YpMmUyRTc6MIOLSRyv/XC4ft8=;
  b=UKqUvt+ORyTkaKtlt0uHmv7r8i2aEoKkjf4M+j/Sy+w9n0dVegfi91Uy
   xnrP3Gt9w9rb4qMW1R3eVrgxxQJ10b5Q3TAd3bG0S27LqJWux/RCYv6E/
   i326lhvwSnl70t9ofxDg5DmR49MXlQAN2tg2OJga+7GIZHT6z/tkxKZZ0
   oK+jBigzdQCf5cxRTwmq4VlsSmndRmMG05Mm01ggLM2j5BB1nDRM3lubJ
   2BsAWuLp90Y1Qa+qkffCwR74I8eMkXac5fjr+0aHNutJNUv0WjPICu1Uf
   vAch8JqPfnC5d44T/CQ8xYrvmWhu0U/nyBamiYPt+c+Wj42ekvAPaZ4DV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5899418"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="5899418"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 13:45:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="14005521"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 13:45:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 13:45:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 13:45:01 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 13:45:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bihzkUsZB17wjoAal7cFccqn+xU5kBg8yDJAS+s1UDn+3sE/4LC0F8jRvjJErst0kYv7UJCf9f+2IyJQairtL46qrGFuvz5vju1ncQfC8BY+ILBs/Z92oBWqr8RFo5BPyF0Ox6RB/Fiqx/MRefCDdlYzWWr0LAhbk3y36IwrQpw9eJF6lpwJCPURUV3wLbP59ueZ9W+P3VLqx1sl47Qpvt0OMd2Uhar82OyCj1XaMVJ5PoKwguQ7WH6ytkqjuiiZecsmW4J1OUt4OYtVrpQvXzocMRu+/y+3eeBb1LoVzyvjCwsHBb1ZP+wfoEtoVt40rP0uihVcvq+8494r7CHkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlfzAq2GdKWegmqYVqCjLCUxtQ878gHOPh3jdpLiGnM=;
 b=W3ArjF587bK4mPrwN676WZNtkQ7bFj2WUySwW0LqLjMBbebBdeocJU367BEp+AT/B7qI92vAYhYxQOHiZZC6SgWDyYCb9ZU4uAJ7gZTcva2SeE5b5PJBJDZWizu4Hup+RhXj5qlgyDFFfroZ0apD2cvLRnViEWmLnGoHSTLsDIvEhBgAPTWwtYf89CSRCSGWGtjBpemyXmJzZa5KMgn4AWXm6U4zfA+dj+KL5K/4VbHP5DcfFQh7uRBPHnIq/Qg12903w0ZF0UHLrLThcWQo0OTh8sL5JnVfdTqnuwm8OFsjbF0IRYse99ac+FbOAFWOQPwlW5GUbzZ13zrUjGenuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6125.namprd11.prod.outlook.com (2603:10b6:8:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Tue, 19 Mar
 2024 20:44:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 20:44:55 +0000
Date: Tue, 19 Mar 2024 13:44:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: RE: [PATCH v2 3/3] ACPI/NUMA: Remove architecture dependent
 remainings
Message-ID: <65f9f9452dd50_7702a294bb@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240319120026.2246389-1-rrichter@amd.com>
 <20240319120026.2246389-4-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240319120026.2246389-4-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:303:b8::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e11ec1-eee8-41fa-691a-08dc48556f2f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ASmxQRi03hdrjbIxCkfYfwaZOP5NiSUQXdoTvIfbqIlqkCHOcDlYm2dH3F2hZq/NqwB8KSk4i0ZZ3RYep21BwGBn9AbtZr3F+JatEPk9aRK3GkPYcQYQeCYxMIf9urRA3TV/1VCVtt6PIvuAYVG2px5lSnODM5l4bnHMn4txmy5ebeVbkBDpKpnZtUn7D36A0Wmao4zrGol1ZDPm52dP7SnGnW4Stb11l2cRVVi7Z+Gy2lQdiJBlYy9CDpYZWYhz1muBiOC0nK04BYD2p8HjElsgDR21cjhNBPPuiVtz7GYZzHS9vL3ES9Tbkgl3tuOrTeqSzhJHx7CfZTeCNsAMdlWu/pAMmrPl2T5mCfMfo9l2YPfzdqszQXQG5a06SrxezMfD8n7Q5aXRkHKsj2XC8jHM/JfVULFBh+sBhkff0IUXy3SFtXtbduftClLounjfnf/ugFsyk4BWpt1LCCUTQnXMwa+MK3rJDT9DyN5n++xwp7JetgxwxrdYAV4YjX6vZNRD6Yf8c8TzTucD8RhQBSpDcCuMoJhStO2I0A+OKe5qmCujwtLljQsqEPlyQGE9TszUOlDKW4lVrH2KCcW7ST0m5aO/M6E/HnjbWC33B7nmSQgPvRAzQM0vbCCySyYXBYpUKkCm0BD9s7pBXT3e8z5CYuc5+D8qwz08WfPMlg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?slYuOTP/OBuccQbxz+cX1QQDw3hEz6H6nQkSH7HjDSaZngcFTYAi7cIzilpn?=
 =?us-ascii?Q?qv4J1TxtvELhrM3C6iP8njRAoE9+UUnAsKWGuZtj7XRAHjg7MNuLV6At5KWK?=
 =?us-ascii?Q?tMNxLJTLimOLppgYjSzMwTFMZBqpvvTc4nAwGrDYFSN3l/eRfj7IowYckLA1?=
 =?us-ascii?Q?UIhJCAGPk6TrlFdIa4DURusQdU5TkeVuAx6uSf3t43db+rCDyIxQB0cUP5qB?=
 =?us-ascii?Q?cknEsTD7B3mgOpslXojfLewDI0h7QKUPYNai0+hXVlTadNk/KcKO35Vf27Qx?=
 =?us-ascii?Q?kxOIAIDh762mHag6APoTK5melN6JzXlgHJK4uM7ClDuJfWSog7fNuAmeb+5o?=
 =?us-ascii?Q?054CtRtoJYoHlM0/VsMrmuAHl0+fTPuev6cPTpLq2sW8i1xKk2fv9D/gbRt3?=
 =?us-ascii?Q?Jid23ftnvYl7oxI/2fLmnrHXOeyNbbX5ugYNex9HIafJ6kS7gTFsmE297WcK?=
 =?us-ascii?Q?Tfc7jDMjBg/FV2Aoknil2cJKV89pu5UZbPa8qK2M/Ax5oFYvokmrnWdUrIn4?=
 =?us-ascii?Q?heKswVFTW+WkRWMsDnMQ/bNsulCwKbqnNoFVYdr5xcJG9GERD5n2IbRN0Gfo?=
 =?us-ascii?Q?TweiQaLz6wpAXeEqClpdKclwI2wpmBZ5l12ipEK7mTGw+ZbDYiT3xRt8/kpg?=
 =?us-ascii?Q?+uk8xU2Q6Zq8evM1fRYc19IIMmh0WQ7M4tR+5E8iszaX1+MVC2BuKs1YrzMU?=
 =?us-ascii?Q?FZJb3DVin1Z8Wb7OHgo91g1R6pBssY+iYMs+dCtasrrHjL7DUa+U9y90H99A?=
 =?us-ascii?Q?a/TN+aYXh6Wd/77WjJV/jLDnqAWsnZNiM1nQTsUfqKhGBo/oX7BENpZgsWq2?=
 =?us-ascii?Q?n2ttPpv2KYpYc/4ZMHJuUrXJJWgAh6SEOTey0jsatIFRLUD6UdvhVPyPpc69?=
 =?us-ascii?Q?Ju+jX9Z88imW1oWkBQwOHcerXTuUrHHPUxJ4KJPjeFjg75VHWqZUGJ9yCdxP?=
 =?us-ascii?Q?2te3maP0zLllhfrgr5t/MCO3bcGCP9XnSDeo0BH6sMpwHOP4QSHOumMDakBb?=
 =?us-ascii?Q?Wc4Jiw1g8AmhdRdDJNMEwyqW45Y7y/VgxUV3BBJEeGLt5c9frG5ZxWLUq5uB?=
 =?us-ascii?Q?/LzLWSRc4cZpRWbwHMjHJrC+RNSRXGImm2qoFHmxwLgaT0dgAyivJGwagUHr?=
 =?us-ascii?Q?KmrFDXRM5wFlWJllKNrIJnti2xdNY82RRY9QUzblwEZwcwSXHBRFhZwFSco2?=
 =?us-ascii?Q?HazR6WjxLO8bSwgQA6YsmZg6WTRnIn94UkA18xHcMOkgunYW92+46BCtzuOs?=
 =?us-ascii?Q?yWT0fGSoidZQZJf/KJ/bZaE3XGagZ2fqiNJkOMpHiAUr9iZgQDTiCGoYbG8E?=
 =?us-ascii?Q?r1Jy71k5TNR8u3EA+SiNpSBdFY1R8mAv2GfpXCqUTlA9dn7FZROBn2FM8hDm?=
 =?us-ascii?Q?HxNhabb0wWLBXFObc0edemKmIytyA5y7I4c0IJ/yG5U7w9eEaMTl4NiP70Dr?=
 =?us-ascii?Q?UH8x9vgiZYEy8XV0SZ6ToUYOCR9jSemkxaIretKtBUWrBnEAoP+4r2po1ngN?=
 =?us-ascii?Q?OLJ/4TP2BuM8BnNaTsX0ENpBTyAzuKAVkw5tPy+aiF2uEFGzoWRooUC3TWp9?=
 =?us-ascii?Q?1S4rOLT4lmid+nMWDhsj+X5bcf0mf5QZfhkLb0whoXDg/jJjkbKT4lRKIxQ6?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e11ec1-eee8-41fa-691a-08dc48556f2f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 20:44:55.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIBDBOIo90hCBCxLtEETRryG91njzxkle3XQ2yR6tvGWlH5+v5Ng68A9CP+SKq1/8xBbBHwRin4X68Pmgg5dN2UowmBT3AO2RW50t+ZJCoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6125
X-OriginatorOrg: intel.com

Robert Richter wrote:
> With the removal of the Itanium architecture [1] the last architecture
> dependent functions:
> 
>  acpi_numa_slit_init(), acpi_numa_memory_affinity_init()
> 
> were removed. Remove its remainings in the header files too an make
> them static.

It would have helped to clarify that this is a refactoring and absorbing
logic into the helpers to validate the correctness of the conversion
approach. I almost asked for it to be split to make that clearer, but
figured it out eventually.

> [1] cf8e8658100d arch: Remove Itanium (IA-64) architecture

Checkpatch does not like this format and has some other things to say
about this legacy code being touched.

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/numa/srat.c | 68 +++++++++++++---------------------------
>  include/linux/acpi.h     |  5 ---
>  2 files changed, 21 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 50ae8557e8d1..910609a9754b 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -208,16 +208,21 @@ int __init srat_disabled(void)
>  	return acpi_numa < 0;
>  }
>  
> -#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
>  /*
>   * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
>   * I/O localities since SRAT does not list them.  I/O localities are
>   * not supported at this point.
>   */
> -void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
> +static int __init acpi_parse_slit(struct acpi_table_header *table)
>  {
> +	struct acpi_table_slit *slit = (struct acpi_table_slit *)table;
>  	int i, j;
>  
> +	if (!slit_valid(slit)) {
> +		pr_info("SLIT table looks invalid. Not used.\n");
> +		return -EINVAL;
> +	}
> +
>  	for (i = 0; i < slit->locality_count; i++) {
>  		const int from_node = pxm_to_node(i);
>  
> @@ -234,19 +239,25 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
>  				slit->entry[slit->locality_count * i + j]);
>  		}
>  	}
> +
> +	return 0;
>  }
>  
> -/*
> - * Default callback for parsing of the Proximity Domain <-> Memory
> - * Area mappings
> - */
> -int __init
> -acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
> +static int __initdata parsed_numa_memblks;

Checkpatch wants __initdata moved after the symbol name.

Otherwise this conversion looks correct.

> +static int __init
> +acpi_parse_memory_affinity(union acpi_subtable_headers * header,
> +			   const unsigned long table_end)
>  {
> +	struct acpi_srat_mem_affinity *ma;
>  	u64 start, end;
>  	u32 hotpluggable;
>  	int node, pxm;
>  
> +	ma = (struct acpi_srat_mem_affinity *)header;
> +
> +	acpi_table_print_srat_entry(&header->common);
> +
>  	if (srat_disabled())
>  		goto out_err;
>  	if (ma->header.length < sizeof(struct acpi_srat_mem_affinity)) {
> @@ -293,6 +304,8 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>  
>  	max_possible_pfn = max(max_possible_pfn, PFN_UP(end - 1));
>  
> +	parsed_numa_memblks++;
> +
>  	return 0;
>  out_err_bad_srat:
>  	bad_srat();
> @@ -448,27 +461,6 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	(*fake_pxm)++;
>  	return 0;
>  }
> -#else
> -static inline void acpi_table_print_cedt(void) {}

Would be nice to move this patch before the printing patch otherwise
feels icky to add a line in patch2 that gets deleted in patch3.

