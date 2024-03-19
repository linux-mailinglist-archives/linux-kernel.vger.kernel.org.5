Return-Path: <linux-kernel+bounces-108102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528E28805F7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1CB1C228B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F4D5FB8C;
	Tue, 19 Mar 2024 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcOiZRjR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F355786B;
	Tue, 19 Mar 2024 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710879375; cv=fail; b=ukn/TVvsBuFtp7Kq5fxBz3jXDg2sfik3jJ0BUL1V1kclMyXlIXq8J/UXc4QpvVSpKG2t5DE9MUAVPtueCmndNBHJdh3GxUiOC62q0o45WqdEg00pbb1S3KIYwmdout9f1zwJs9npp0TXcAEBhcyDRjMQkOqPkNmxYzxiWV2cHu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710879375; c=relaxed/simple;
	bh=mvw3tSyFm1GERF6Em4XhqmGMIJeG9Cc5f/K7h3ZqDqI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Da8yDaqE41GyU5ypD+l0qPWWroaBL6T3y16b6jyt2DTEtsVP6G8ejIYtYKwt5uIPkFn1ZHOmklnko0F4XfiWHYch3Opkx0PNdwW9K3jAp4Q6uok1CoSl6p7yPzOZ4XweBK634ivIUF4jJ02eqh+lttvMQ2YIh+WLAtevJ3UMXAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcOiZRjR; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710879372; x=1742415372;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mvw3tSyFm1GERF6Em4XhqmGMIJeG9Cc5f/K7h3ZqDqI=;
  b=YcOiZRjRQUVaycjuTFPn7CVsujp4u10dBr7gyYI49r0/KqMLkkFEH+oP
   tDhnSjgqgCA5pVDruFZA2cR4iHcehtmbiFSLzdZ5I/E3dJYxrb+ikeYSY
   PgXp1Vws6IDI6l11xuaWTp3CPDr+HL940NqcWDfPSWpprZNSy6oJyVQle
   M2xRnuPPFj4paYZdUEt/brLML2CHvHXXtrliN6icc1mGruY3AOyrZIJBJ
   dnWXyVLk7uRxfTzcwiEIV5dsSVjFjcU0e5j52YIzUVJWM+b7Pdf/7STqd
   Cs3TYpoeZ+DLQyafEhIA98pUOCmraH3PNHN4FiFJ8YvnhV3m/E2ejDkSa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="8722130"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="8722130"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 13:15:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="13994943"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 13:15:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 13:15:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 13:15:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 13:15:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 13:15:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJWdgRGAHJhCrIGc+KaQAySYv07q6GYjq9gEdeF8v9IyjtXLRB6I+UUp8lI2eToJJHTPBOOvlpF3Jts4u40M7XF4h8SycDzPKRdXcEBFqzWnlTvvPfx/1C1fW408EBYlBY7IuniUAcM0SngQllpYFHboFAEEiXGAJX/MAsUg6xFh++WaOM/DILQxPf+fl/vqtEPfwduGFbE0XKuE332rn6bXurDuZVd1QqDvgDUg3GCcJxXRooSXK7lCWsd8Tp2Hps42cGLc5ZkupZ/+5UdU0pgUV0pYnW9c17ULdr3fYVNccIpbHU8WIL6RSzVb1wecW419o39Hiy38WXDp0FURTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zAFDayZ2iIaLGdAIqehMMkJGNuq8AtikF2gyU9KtyE=;
 b=Ca8Dy0dc7aItxlNzwhUty8VIpd6FvOU6ynNWO1mOuMiVYWX304skdq0kbSR/zEz8UmLyho3W6r7f00GVb2P1OdwLYrtWUV65W63jRmI3If/vfPkbrq/aKOEQO81+8aTO5revMkF21K+Ngscj2pWTikhs4IQxC9M2s6oel2iLpcZJlm80Yvhoqt06n84FJ2UkTccCBjSqQMuwvPNAyli7QBL+WPwQCe5ip1IIKPXSHwpRwTm3KLxRxWSpekMIVW9QL0Dz+4CG3OmQ3BSf67TfR4TJbtijCmOKMMKkIC5IZzSyI5sRjgqTZFl2fx5I6DRFFiBhExFXOhunpsAdeiZQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6133.namprd11.prod.outlook.com (2603:10b6:208:3cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.10; Tue, 19 Mar
 2024 20:15:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 20:15:50 +0000
Date: Tue, 19 Mar 2024 13:15:48 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Andy
 Lutomirski" <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, <x86@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Derick Marks
	<derick.w.marks@intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v2 1/3] x86/numa: Fix SRAT lookup of CFMWS ranges with
 numa_fill_memblks()
Message-ID: <65f9f2741e607_7702a294f7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240319120026.2246389-1-rrichter@amd.com>
 <20240319120026.2246389-2-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240319120026.2246389-2-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0130.namprd04.prod.outlook.com
 (2603:10b6:303:84::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af34b62-48e4-4e4d-1012-08dc48515f48
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEVHtiqG1Jdn5zx0R3cl3zu7xXPqVB7FwFFmPyOPyO5LL6qOoianPzLkkeLioFOkPf6WqEKX+jEF2kk0Bwx+QnB2cSMwh4n9QbyMj/pFYqBd77znDqvrgt7FXfpSUIBQYRDaqvtllFlV1cgLa+QxEFPB7xqsnWSklDB3P91Pfjm23JxHitG6zUqdKwZ/SRCHBIi6YJr1PGNnLT5zo1QhhGPLgtHptK0kwZY0vqEEnDbBUmLgzN3E15MXac/Sztj1rH487sWyEcfq9z9Krvs+WYD7mFH4FARQGZJ5OPSUdUthQIiF3DG8Wr+M5KtB/fjp7vKxZKdBaAZUSsISvZlr3zSk9nMigv4vpzL0exx79efmsF9YS+9EVp26CSoqofwp8JHOUTKiRJo9G49bOKl3TI/H9e1x91Z/PoHCvt2vJEu0rjdqPcFRU2qYhd+iGpYD4RF8kAiKJUlpRqMFWe4sLzohBndTx0oONLO7LyJH4ss5GEbGf0bQjNE/hZJQJjDSpZH3JDaSchnW90lcjMEgMAPNR+25VHVCT4yar/YPbSpCi8XWEuzBWHpydE2HjuHOf48f+itAabFagssJ0jFChdzv6qLmaKxeMcas+SlfTTF47dsDfXo0Lqhruie5l5FXqDJ8no43YZfbNddZ1jBs7Hh+XU0J7wrX2eFVWCMS65r7vRzZW7UMMh7o6s+1FkLqBuH8IXAWD3J9KefGKV6CIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X1YNcYlFn93d8Gg4B8B2pubNClrV9zO5ONBSPCYrFRR6Db0pKpaddhOq+0cw?=
 =?us-ascii?Q?B5b1xPLYASPzI0JJUASomJjvOr7NC3SV5qxhB/vOQJUqAvbF/mdnh/GR2Ma0?=
 =?us-ascii?Q?U+0bSJcDprCjhGHg5J6LeLlyJOYYQ6GqbZvoN4HhmTSvmDMXFjq1aKZoADFK?=
 =?us-ascii?Q?lZ/Xue9Dlgyg6t/v/fbJb3B7gG56mD+F24tOWSmkZ/+aMYX9lbpcladZwvlA?=
 =?us-ascii?Q?vf9UkRE3CXkRvvlquWOyaKl/IZ0cOCv8hROPqn5JP+O1NqUdiabBxMw81eVh?=
 =?us-ascii?Q?jOQ1/44TCneHEEGEYkfru8CerwgdsC6XFn6iUQCiJl5PhmwbRGfp8lF0suYe?=
 =?us-ascii?Q?dBNUmIwAWYr3znKYhuPB7mKZZ0gIYzrvJoEJ0m4ky9p42OybzARA69ElagrY?=
 =?us-ascii?Q?16TF8vYQW5uieVwrPXv0fxWo25L9GSnU/VETtlVo9ou2F3kJz9lTYBCCiteq?=
 =?us-ascii?Q?s0XGYLGMrdXn5AasuaGAavN57/3ZswCxfRZUhC0x06EHL+RaekO/yE6A0wQf?=
 =?us-ascii?Q?85hUyWE2VWXqmNTs1IwCj9I3Nrl0UqEG9wEC0wcdDN5j95LjbVFnB3EM75S/?=
 =?us-ascii?Q?mNMwv2AeR1WeO/4wC+HV2xaXQX84V0VZ9tb1Fvpo7U0JdmwwcNL1wOONC3Kg?=
 =?us-ascii?Q?oiqGcxB1hnJK2EBJDGwz7gfi76Ix8+jiV0oLPVy1ms+NW1sz9/r1HFWRimGe?=
 =?us-ascii?Q?WiAGuxtlem/iG2k1JXxWWcZkgI8z8K7L2AQtwKrboLvhEGLjn4tTUj9rqoLn?=
 =?us-ascii?Q?GqJftUpet68eU9M0nJ+saJ4wWNh1I+XliHVKh7COneFaJFklJn00C95dR6Cn?=
 =?us-ascii?Q?UOs1+gPY9uRUtVn92klGSaJIbQ0KiPcgUY7vocauTxDj8zdsOrvBqY/FSjsI?=
 =?us-ascii?Q?zwjYa1Rx+vgE4Dw8wzC+OZPsuneLqr0RGAx55euAskP+Y4dAF1aK6koRXLPa?=
 =?us-ascii?Q?Urnv7APXXVpXQmmR/Y5pGH6wFvdobllqUbdIalue2uGW7UXqjNvKm7D17fpX?=
 =?us-ascii?Q?0OvU4Aq1hAKshoybrufp6KJN3Rm+5rmF600zFCWYbkEWfCcFxF64kDdTiwZ6?=
 =?us-ascii?Q?SEhi9uSQHry5KKGwnyFldJkWUr0by3lkg1I+Qpz4hu6Ps1uqUpoNtO3QX1bY?=
 =?us-ascii?Q?sby1KnND+HAIgfeqD04B82ZoR3HZmQC229V4O1JOXKStGSITu7U6/X1tI/6p?=
 =?us-ascii?Q?SCtBQ1S4vxIomdpqsO+ocu67KCKmhyuvdZd0CUyfm4VA4nRDcTFVNLUmkuwH?=
 =?us-ascii?Q?sTppauSZntHQpzXZoWt+SNS2bejPA+t7REcElKeRx+x85hcaKj0ogO3JOG3u?=
 =?us-ascii?Q?EJ9WLztQQfuQxX/6sPiTAHEd3Fzx74C4VtzTJG3+iPVuZjow8gQBrvWEt4Ij?=
 =?us-ascii?Q?Lj0xS1Y1PBj8MY3Ac5K2tc1HoZ5uJ5gonJJ7tH8nsvWGYq6eqb9UKIioL7kD?=
 =?us-ascii?Q?0PyrBbTS7ZB9yJZOSv2ta0qc5fFr+MxOojHMoU+jg2pfxl7aR3Nu84bfXCEi?=
 =?us-ascii?Q?OmcKPv3IMlKYKnyyX0O8mIO9ur9LW/VN6dOGl0PXTTzk8q0V5ITs+rcXbkpU?=
 =?us-ascii?Q?XLoP/UyVCUuW79+UNe1cmYEmE0DsGvDsY3RZsL4+vT38sUQreU7T/+uyiWnM?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af34b62-48e4-4e4d-1012-08dc48515f48
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 20:15:50.9153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/Z2gaJMznAJCBiJgLFR87Fixh8kbkxUa2Rp8MUrJAG6SI7EfSgaVDa2aC2rH9inqxTzmlZRICNnc2DGvhWMhuIm/GS7jzrOyNZ9rfhfk10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6133
X-OriginatorOrg: intel.com

Robert Richter wrote:
> For configurations that have the kconfig option NUMA_KEEP_MEMINFO
> disabled, the SRAT lookup done with numa_fill_memblks() fails
> returning NUMA_NO_MEMBLK (-1). An existing SRAT memory range cannot be
> found for a CFMWS address range. This causes the addition of a
> duplicate numa_memblk with a different node id and a subsequent page
> fault and kernel crash during boot.
> 
> numa_fill_memblks() is implemented and used in the init section only.
> The option NUMA_KEEP_MEMINFO is only for the case when NUMA data will
> be used outside of init. So fix the SRAT lookup by moving
> numa_fill_memblks() out of the NUMA_KEEP_MEMINFO block to make it
> always available in the init section.
> 
> Note that the issue was initially introduced with [1]. But since
> phys_to_target_node() was originally used that returned the valid node
> 0, an additional numa_memblk was not added. Though, the node id was
> wrong too.
> 
> [1] fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")
> 
> Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> Cc: Derick Marks <derick.w.marks@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  arch/x86/mm/numa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 65e9a6e391c0..ce84ba86e69e 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -929,6 +929,8 @@ int memory_add_physaddr_to_nid(u64 start)
>  }
>  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
>  
> +#endif
> +
>  static int __init cmp_memblk(const void *a, const void *b)
>  {
>  	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
> @@ -1001,5 +1003,3 @@ int __init numa_fill_memblks(u64 start, u64 end)
>  	}
>  	return 0;
>  }
> -
> -#endif

Does this achieve the goal without an additional hunk like this?

diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 1be13b2dfe8b..1aaa447ef24b 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -37,9 +37,9 @@ extern int phys_to_target_node(phys_addr_t start);
 #define phys_to_target_node phys_to_target_node
 extern int memory_add_physaddr_to_nid(u64 start);
 #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+#endif
 extern int numa_fill_memblks(u64 start, u64 end);
 #define numa_fill_memblks numa_fill_memblks
-#endif
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_SPARSEMEM_H */

