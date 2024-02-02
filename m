Return-Path: <linux-kernel+bounces-50455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C8984795C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1B9B216FE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F93F1332A1;
	Fri,  2 Feb 2024 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5TS8ngl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463A12C7E9;
	Fri,  2 Feb 2024 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900296; cv=fail; b=utz2AfHLQwnefBFffklIERkFak4fC9F09A2ydI0zdf+nDjxk3RT/Gb/QIMSTdDreJvY2xFR/0wkMkJdbmCH+JpVUVdFTrahptrkJhWZflzGgsedC51zb9dRUVtFtJlCxmSdIgWc2+MsLvfvPJ2fBpjXRu5yMxZ8VRU8q6zYuP2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900296; c=relaxed/simple;
	bh=f3tdividdyZ+b7/fc/vG5R8q6P4DN3WyEpID6MMIXps=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZdQqetVqzju7j+k0NuKBlc5nayjkreYKupbYbdpwXNRA893gzXuizdotfgu1noORtMgrvCLDEwJgtIXfIK04b5mPIhfuW9YLb0KqDdmceWEXNJkjD4zPnvgHCytkwLq/5HOD5m0su391ou1M+814rYJdBRSDn2McLocLurgzbsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5TS8ngl; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706900295; x=1738436295;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=f3tdividdyZ+b7/fc/vG5R8q6P4DN3WyEpID6MMIXps=;
  b=M5TS8ngl25ceyb0lJAO2qd3qwhh7SwUKH9XPT9D6+dcxtu9yoBMhAPRw
   dOe6NnhaequgFAZgRnrQh47uUil5+NzD938e6S99BSQ+oI0doUT8V0dkK
   5XBxQSRhVipHxczNBFroh013YoFKjmVmDihOwQ0qAVlDHjIwIzMDDa3F/
   n1ai5DpgFV1EICEE/pmaNgoQEmulRPMMspjHp0iLccIt9j0iIvWKvVUb/
   9GrZ6BifD42yy8cEyepB9Vsetwu2sM00vgI9G3GnI/wpBK1F2THwKa+wy
   bIqQCOziP0aNVp9VkDLNO0fEuSjAdX663kiESVSVyHw5gjVY0dWuOD0Z/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="4053602"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4053602"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 10:58:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="457799"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 10:58:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 10:58:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 10:58:13 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 10:58:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmK1pwGqS2j58AS/E8XcjRDNKzbLt3Dz1qvjQK4ZR/5QJ8UGOB8yBT1TAAzigyKwmZW2BEnTIlKagUkwFSyAhzk9f5uOFHhVQTbbA6zkaP2MeGTvxmNPleg2OZp5dOLe6wGDNysIkU/Y+vCUmWUKuZbTzOlJTMM5cTHZi/QBArMOjftNtaTdm6+uMWjkCRG6cK7x5tsUoETxXS5ZXHrQFMrdb+J/katB5Wlcva9IdLxWS4BCm6U6RHWC5LIWIvNF7qGKk3sqE1Ti5++wfxA39U1IjXvTYa8LH36ejocnNLo5RBGilfR7Edekrotv5sbNn82zBfkOeML/UtdcMLSlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fgMmLMvp8dtGdYgQHRNy/IEGdc7m5YW/b9958SdQa0=;
 b=ZyRC5j/j9EIZ1yYXEw0jIgEeGcJX8lHnhWXt74xaiQ1j2SrGaMxjPtkBtLHbaKkouf2zwtij2RY3XEYChcbq3AcU1wUvoD3TYR4rcfmc7Yxw/FIaP51WqBpQC0ngGqalfMy4A24WIargSFVJRu42lBf/txnXEKv59V6PFRZPFQhfTYwWm3OoxOjmKDx/wd6KuDZ1HOlmcJulvJMOZ8w0qggwdbUbCeT4b3pB54Ps7UoMzSFYUf8PICFeOOS8V+2YOsPOkkuw1Ha+rhiPeMLS8/IQygVu19reUmZf12lACQbc56ATzfgGUov2KElLJShe0xEZHneb0cacWXDYkADmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6378.namprd11.prod.outlook.com (2603:10b6:510:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Fri, 2 Feb
 2024 18:58:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 18:58:11 +0000
Date: Fri, 2 Feb 2024 10:58:08 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	"Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [PATCH] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <65bd3b4073afd_7193229489@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240202-cxl-cper-smatch-v1-1-7a4103c7f5a0@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240202-cxl-cper-smatch-v1-1-7a4103c7f5a0@intel.com>
X-ClientProxiedBy: MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 234091a1-6b77-42a1-191c-08dc2420e6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5Knsxar/zzYDlN5IyNla6uTzokdNAOvAzotvKlTRw3xMvqLkoNYkFVybUwDYXuFWtM4Jcp+/7KylsC4cyLFXL2bc2IssANdFySlE4p+EvVn7PdthNOupuTSgIoZ9y20mh37JSA20BaLsJ6XaTKZcD+44P59SqxDQWgbm/777rbq6cxqepKnflWHTwetQYOxIIPYy0WB3TJj9YpGnuxNy8tyEvkTqgdbdPhGQheMcuQswy5LlMKZRLuTS5qVwWwPPWyUoBt1gLfk5Si6SDFtkgATf3esYXitaPLIpLSZyTInXTyeLwJyLNDHu6CEoqYBRrkpCuoG2iU1gm5orCuo3bNaDqkkYVVSAQtpgy0AI4NquLri9rKwgKDVweFrduADrK6E0aZssXbPTe37PxHxjDDLZqteh6IKlbP9RWkBVtn9mUqt0DcVp0HYpD8MKxlZMif/ot+/QQ1Lc3bZwU51BW9/xZAcJFfUOtL54V4/8B3EFjbOLVFELIXx5d51waU8pwS4FzNz+Mv/YnBW2dwkYKbMjswA+Sk4eYSDIEyhgeA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(8936002)(41300700001)(82960400001)(38100700002)(86362001)(4326008)(8676002)(6666004)(6506007)(478600001)(66946007)(966005)(9686003)(83380400001)(54906003)(6512007)(66556008)(110136005)(316002)(107886003)(66476007)(6486002)(2906002)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dzlmq4qIVXGJR3YZeZP3qVnu4WZzj8WFk6kQ79n0VKTmya6GzWeAncfSavg1?=
 =?us-ascii?Q?aUHPZJeiSF3dWptaGjA0pKOA/WCHmEgbJ/yjMW1m8/8X4qptOzAXhI92QVoY?=
 =?us-ascii?Q?rQdIbhBaEhb/LnsRCurppoA1rJD9OwM8ebuLEisHC2wJWIixZbQsbqku2nDp?=
 =?us-ascii?Q?r4gVQjqX+LAUAGDlLU3sH+pfBZhcSOqsk747cAGyjcWKGPE/2a5XlnFhNy/r?=
 =?us-ascii?Q?QFEECQsUDz08/mwmkWtaoUK4FuNnGWv3JeQmIeLvpkf1sBcLRdBw0a5tlnv6?=
 =?us-ascii?Q?Q34wDZoBwZRfj+IhVj+X9TWlGF4e9b35AIq9ZF55wBqZqrRqkQbyUrM7rwez?=
 =?us-ascii?Q?WIdMNfgivduhL+tYGVb2pUkqhagjS4sFlAj5WHQ1XO520leKHyqsEPsJljD7?=
 =?us-ascii?Q?y36I94jugLYhxGbAYcaMSAXrcNy/91f0cxytl+YfI5lIwwboXXE3w1ISFiyH?=
 =?us-ascii?Q?HbxE0IbbcNQ5vsQ6VkNs4iycqTi+VhGPi1VxAC5uohq+5N3TAauixOiJdgZ7?=
 =?us-ascii?Q?zfji26ZHsaU0CbDAAEE/zXdbMyLLt4qeICRQ14rG9Dpleg2/QDvXcmQb7HhJ?=
 =?us-ascii?Q?Fk/ix3tatJPbZ1ELiExqXstzWWadb2LXk8R7YZ1Aw3hS3G8gO9E1qU6UKh/0?=
 =?us-ascii?Q?HV8Bq4cCNW8dYe3i15iSHLeW3zIkoWrlthIVmAkRhx0IkQJ5LCVfqhQFMLWV?=
 =?us-ascii?Q?rLeScLVyukk7eOJnCJS/p6V3McjqYevKtw9Wqe8rqYXMynvO5r2KRAcmhcit?=
 =?us-ascii?Q?Y9ZZaXfRvQWDv+KDOfuKXdPew6WF19Y58P3SiX+jUvvvVzOfK6Aa2lKg0Aw6?=
 =?us-ascii?Q?nCWM5KhJxmByakwNHLnY3HK2d5uIYTMiZHtI9zVIygyQ3KApIaOi+lF0oezI?=
 =?us-ascii?Q?cbKeVcGSF7+MuUhlU+b7FBmH7mFmIWooOiRujoi6zuaKqQvCop61MjpvmGt5?=
 =?us-ascii?Q?gkCj0jGy+unlSFcnCsj7W4k0KkT7GC9KHg0uH6WgT8jinLS1KwWD+xy2FckD?=
 =?us-ascii?Q?PJ+BOpUH2WbFKir4iFSHWQo74bgh/y2cu2I5ReEkzwi9IOC9gmXwRgukOs8p?=
 =?us-ascii?Q?zDMPYNsA0qaOEepmYOZBv4t04N9lPxCSIilKWfmaSmGx7MGT+EQl9V3bJnjw?=
 =?us-ascii?Q?5WNABgt5E0k0Y+vk1lX7FuXG1uoVHOnWhF+V7ZSwzguqBcFttkAp2qFnBDS8?=
 =?us-ascii?Q?KvZ9HfdZlnS0eHejiFN0gG9aOo97ORRFejrwkOp8bYAp5AT9PcbqQu5yX3f+?=
 =?us-ascii?Q?8CjxQhYHHKkSfL7rRSANEgdpXKE2BUvBoPsOa1iJDBfD5VXIoF1TlerDy+vg?=
 =?us-ascii?Q?W0/aJdcl/obIOyZZufAPHQAZlfvYuL2VEUBazEurHZy5KkgTZ1u99fnu3Em4?=
 =?us-ascii?Q?m0LA4rsnIPJevxzXFU5XHmd4vD4pdOERSFMKGlWssyAsS9pPJif6N4ipZXEw?=
 =?us-ascii?Q?44rk3WpR7tDFOqS3BruMFkvDQL49mXWugQoCVVv/etFtzfohikJ25fnjoRgJ?=
 =?us-ascii?Q?jlRDmf0VpuLKqHj+ehYf2CvwmAVKqQNm3r5eHJNCwbra9kTX4MM+miQuZbTx?=
 =?us-ascii?Q?8My8kr+fLmFNL2betZqGz0/QTO95kJOicSoM1VFU1ZCKL0a4MCXKleHlraEi?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 234091a1-6b77-42a1-191c-08dc2420e6ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 18:58:11.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlhOP2jK9pWfHd6sU7Crcp6+H9NvJVlSIl3afngG5mZkS+T+rm+yh2DRq6a74qJ/wl6JyG0OdtXP8dDtuSJeAiXD3gs5BVyveJlAyBBi2k4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6378
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Smatch caught that cxl_cper_post_event() is called with a spinlock held
> or preemption disabled.[1]  There is no need for the callback to sleep.
> 
> Replace the RW semaphore with a RW lock.
> 
> A static call was considered but ARM does not select HAVE_STATIC_CALL
> and in that case setting the function pointer uses a RW semaphore.
> 
> [1] https://lore.kernel.org/all/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain/
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/acpi/apei/ghes.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 7b7c605166e0..bdc0ec2813a3 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -39,6 +39,7 @@
>  #include <linux/aer.h>
>  #include <linux/nmi.h>
>  #include <linux/sched/clock.h>
> +#include <linux/spinlock.h>
>  #include <linux/uuid.h>
>  #include <linux/ras.h>
>  #include <linux/task_work.h>
> @@ -677,7 +678,7 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  /*
>   * Only a single callback can be registered for CXL CPER events.
>   */
> -static DECLARE_RWSEM(cxl_cper_rw_sem);
> +static DEFINE_RWLOCK(cxl_callback_lock);
>  static cxl_cper_callback cper_callback;
>  
>  /* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
> @@ -721,14 +722,14 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>  		return;
>  	}
>  
> -	guard(rwsem_read)(&cxl_cper_rw_sem);
> +	guard(read_lock_irqsave)(&cxl_callback_lock);
>  	if (cper_callback)
>  		cper_callback(event_type, rec);

This does not help because cxl_cper_event_call() takes a sleeping
device_lock().

