Return-Path: <linux-kernel+bounces-59922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2EB84FD5C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2F21F21BC5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A8F86AF7;
	Fri,  9 Feb 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFm3U6/N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95054F86;
	Fri,  9 Feb 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707509768; cv=fail; b=Qnp6Gg57PoYENIjkCOGNQFQVXegE/C1VOr2lbh3yqy0crKHMbiR4BBg87b6vlY3DEWlXHebrQRE7sCD8Kdm/itOhWDCiCGC+Wp21t+R2tQWfY7lCTsBZZrTcmD1PcUTW6JU0rXFEqU/81NX7c02CMz+GDgcp/vX6bLqH8MpDowg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707509768; c=relaxed/simple;
	bh=uestZLoknpTJ+kBuDvq7xr2Asa0G0gM4JmwcmzoJZh4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HvshWp9paZL9lFDiinIBMH7tNhv8BBY20DRar9/7fWBot1qdx4mzjRGaAjRjjmEWXEeXC86jyWWcwm7sroSDvlbbQ7syOD+hhNBYE2edrtqZOPwv+C3KTWElnyNRH4xxmcJwAggP1J6+xFxPQTC4rYWXiXLuUpg3QxWVpSZ1C0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFm3U6/N; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707509767; x=1739045767;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uestZLoknpTJ+kBuDvq7xr2Asa0G0gM4JmwcmzoJZh4=;
  b=fFm3U6/N4+M5jLRx3lPmOUm6ul12lbLbMsknvTv+oYiPwG3GyMAb6CJa
   WLYh73lq7PCRFCRIqQx00az5mFYdG9Kotvc866zXWL5Ke3xRCXI3sHiZY
   bJZUmrk4aSP8zWMgHxwZBOkJfkqDzj4Ht8lqNvZhaU0WXWHMI9eSlGPMX
   StjDG8Ae5/BXhYJ4jh5Cu/ImCdRxqnyHOWUaFbKhPhNNFIFlkIkhNDQkk
   uz8UK19Jylv0/RPl7Jqc0sRiRsRK1hp7G95eDr+XUvP2gjs+oLzxiw8I0
   jycMvqF22T8MDZ3XorvmzHc6rIZavbew+2r6SmykjZ2N1mma84XzDbJNF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1646870"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1646870"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:16:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="6771050"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 12:16:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:16:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:16:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 12:16:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 12:16:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHyByF9IMJlvUiG04bZZiS1HvZXN/pDOSa9PcJRcwQUQnBsWtklPHNOx3K7vyUiu9VdjKgqkACmgLB1ijUA/c4DwCyz3GO2uzZfg4SB0Z3e8zLNjQVFiyqaeB9OZeJiHHGET8EbSTtaJTvYaZTJeAiZaQK8MajOngo/SYv/ZR3DlcbwqpSnem/LfJs1Mj2oWshr0XMeUXGzKch2TgklCcH4EWdzB2dFV11dJbHJWm/03uM8BMvdfsKyqdZrn1QtWkDg0oG5E2NydSKKveiNgdE6Z0dVbOzAD9o73MmWqswgoHfQHAH7FCD6yo64M/8PWtYR3zIT97OtcLzhnwzvKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61QiYqomGsSL3JBP7uRCf3tlSTso6pAvFsQd5u3CfYU=;
 b=RSjJNkcaRWABAF3nSWipavO67ZkCcKpHzoETxWX95kkHishFMdQBlbEKcQ8r/vjeqV6GdGGtEzfp3njL91SQgiT96Zm7+KRHLRlaY1qmFTu+FcCssLmyMN5k90aOUVHI5WfhXolkGdzyotXyithRhr0BfzAo15v+2Wgf+Q9xy00mBZx9jaYVpqd5S9zkZCYNvFyjmAlLDtBXVY1icyY2F/k358HcDhNHD5OlxiCwBE2nYps+Cmcx8tDlCR4E/VcGklE1wqPbnPJgq9/vlT8tiLy8NN9C80udJdqyyexqXLHRMUkburDVi8nZAlwAzE75aojONYXHjrU+Xprz0r4Veg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7620.namprd11.prod.outlook.com (2603:10b6:a03:4d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 20:15:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 20:15:59 +0000
Date: Fri, 9 Feb 2024 12:15:57 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, rostedt <rostedt@goodmis.org>, "Masami Hiramatsu
 (Google)" <mhiramat@kernel.org>
Subject: RE: CPU data cache across reboot/kexec for pmem/dax devices
Message-ID: <65c687fd30cf2_afa4294bc@dwillia2-xfh.jf.intel.com.notmuch>
References: <bc925b57-4814-4788-b369-cd2d135a7381@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bc925b57-4814-4788-b369-cd2d135a7381@efficios.com>
X-ClientProxiedBy: MW4PR04CA0390.namprd04.prod.outlook.com
 (2603:10b6:303:81::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: af6dfbf2-6bf4-49fc-672f-08dc29abee1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gt6XLjPp0Q3T287E2VR2hivbvZPZlnM3yK0SJF9us5RDHsAFNyq5nVSxJQ8Dcw/LMcQC6KenV5X4KOkADrLSzmbqtiU+V3Fh6wXOZqkEk4pn64wlYr7Du4J6VZTmBIc7JHWuMAQDIF/B3n66pAfsE0JW9KCJTIUQlMbnnQZt4xwMv50pB8oHDkAhuugcttzwOUozfuR+HP2/Stxj9+cy/lC4grHbYyHbNRGuFHsXvsPH/o2rq0HY0/dGTFXxUjsXMMYFWOT0xBMidlDRwpR03z4n6kJOisktAroyFfEbDL/YKnxyuh48K9J3IPvkDex0BoVtPyDGTgoW24MG7djEi9wUZ/bHKu9qF2Ahi9HlgRZbnpWd/ILJned5zBpiOgTbDHhfM68J2xnczX27JqDvFciGRK5IOPK/la1aFR9d7OjM3P/Yo1FEALZu5/Jo9Aj6FqYN5JOHY4IpKmxqeA3rhp+Pw4RaUzYg4R3HR5aj6oyjXmaJWb3vNCNa63cq+xP8XpqcVhheKV3NBbSrqFEEN9ySRKuLPW2wHLkEnS3/TmdnZ6uY6JyrVgnzGxT8JezV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(110136005)(316002)(54906003)(66476007)(6486002)(66556008)(66946007)(4326008)(8936002)(8676002)(38100700002)(83380400001)(26005)(9686003)(86362001)(478600001)(6512007)(6506007)(82960400001)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YZFW3Uu9/vUJYc+Ar089ivsESEGY3rGvoWenlpR42QiKViVJI0GUJ7vdEjOH?=
 =?us-ascii?Q?cxX/I2jWbVC2/PQu2NehtnKPorHFwKRlmV9YJwaxO/yP3c90Y1571QpsvKQB?=
 =?us-ascii?Q?yqBDu7W5BWWsz83lcuPSYZYHRdbGoXxuGzXX70LFVV8LSbLGbnx8gO3OeJya?=
 =?us-ascii?Q?rFrnEok4t78OflKLcXDdSdN9vTHNfMBL9BmDJCplw6GcgQijGNjoVxgZ0fhH?=
 =?us-ascii?Q?mzZIP7uSJC/ppD17kbDFcyIsNnQZI+2rmSA5Zxm8HTV98BjcL0nPnYIe10Gu?=
 =?us-ascii?Q?ZXkWpciZGjIgVERVb//JlleNcmdoLnLMmTIpVbcdgTNNV/vbGgKsxBmSL85f?=
 =?us-ascii?Q?A8p4T/wK/gL+txURzkxJFbvUuYLXMdXPnK2m5d4vw8AJeBWbAfIKexH/U/Uq?=
 =?us-ascii?Q?+B99zTYSSEy+slcBd+uHSSSVONg3xaDS9pGx8kKNcwdJwg50N2YzMkftbB0b?=
 =?us-ascii?Q?c+/MJtf3qv/7HTwiPEgPlUDZaOLkORMSWhE/yYZJo7XiUr9DLA/EQ21qHabA?=
 =?us-ascii?Q?ojJU9LzdM5FhITPClQa/MprghTaFHobQlLKApxdmAzNpJZm6tNZtRjMfpc+b?=
 =?us-ascii?Q?1hZPRbn/UGlp4yw3z7AiSA0zq/NZVkXfdFbZJQqOosbQqCCtQe9HNA/zsZoh?=
 =?us-ascii?Q?NyYVGk5JiuKkHEJcHj/Jd2deOWkGEeaHWhNpRQENG+fBZU3N/SnePrigo2ms?=
 =?us-ascii?Q?vi2Kapwl/d5rr+sYOQtGfTRYrZUBGoLg7kZeP5D1eHGTjRyxA2Z3jLXR2Ibq?=
 =?us-ascii?Q?fmLrkWto6sUtcvwj2a+hkX2yHg+/rfQi+tRH6gK+BZkBnL2D3S4U2WpzIsvv?=
 =?us-ascii?Q?9i72GlEt6VCCBQZdRslLYjgXmxLEm9/3MlCqFZu1S9V4D45vETSToDkPfAM5?=
 =?us-ascii?Q?cwYvynSrM991uxhJp/Ef9bYSNTlkuksE7WnN0U3Q05ZldiFpaohhyoYdF4ZQ?=
 =?us-ascii?Q?rzukfEt7+c9Bt5UPsA0ihP/fjf3Zsi7V3Ql3nteRIrb3NAs8baX9Xx3nzafU?=
 =?us-ascii?Q?seFzdK0F42srPphmyL+lkfhcPbwRosijsaSTjEx4/VberZ6O5HIJzoio6Ej4?=
 =?us-ascii?Q?xZOBp/d3tuhbvkTiXbaq5gv3VQAI9kD4+JP+wqbwoecz2q6ta3ov3OpOUPIY?=
 =?us-ascii?Q?4Cuaf/MdIBLTdDtKe64Ci3sTSSXJdFcuFs0mlE0sFNXlkkEabD7ucNkbhq/J?=
 =?us-ascii?Q?ocwhUaQ/h1sag683+OUTAbQlpRSLBMRL4MMKY9Mz16OIJWFahLBtEVjkEZrV?=
 =?us-ascii?Q?yEzX5mmF2WpYuLxEzUDsh93GFLi1Bb6+Hmy+zsCyx1b4HzI5A+zVRP9+TqDp?=
 =?us-ascii?Q?Iqse7CfKj/ASHspEdqIVucNK+LQ5DbmrD+0WoCwEq0XwtVUl1KRCVPtBo6bL?=
 =?us-ascii?Q?Ym3xgAYY2pBhZkd724bR7x2NIaUXHp6MPxRsWaw9VyZjuWatRZWV5H3ACwxY?=
 =?us-ascii?Q?qpx0JXi25CBFPq/tamcVElvKMOM6GCWYLQXVJwGY3raj5F+myr1WjA22FwBD?=
 =?us-ascii?Q?U47OeaobyFO9yDY+QUuxgHILDrN7m6CA3NP1B2iaUu6juO4zpK7LXoZ3mUuU?=
 =?us-ascii?Q?ht7R6qd6xMoHUriIL8M0ly7g2S3sI8XvFWOp+qqrE7O18GosIw7qpIgj58wJ?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af6dfbf2-6bf4-49fc-672f-08dc29abee1b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 20:15:59.1862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsSxVIbHg9bUqkgn+R0dnuFBlprkRTNfmyHSbKJkw8DnW+zI43AckTp9vYeTTBR5lWwIUJQQ7Ofv+URin54iojJ0zL7j3IpU1z9cfs1uJtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7620
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> Hi Dan,
> 
> In the context of extracting user-space trace data when the kernel crashes,
> the LTTng user-space tracer recommends using nvdimm/pmem to reserve an area
> of physical (volatile) RAM at boot (memmap=nn[KMG]!ss[KMG]), and use the
> resulting device to create/mount a dax-enabled fs (e.g. ext4).
> 
> We then use this filesystem to mmap() the shared memory files for the tracer.
> 
> I want to make sure that the very last events from the userspace tracer written
> to the memory mapped buffers (mmap()) by userspace are present after a
> warm-reboot (or kexec/kdump).
> 
> Note that the LTTng user-space tracer (LTTng-UST) does *not* issue any clflush
> (or equivalent pmem_persist() from libpmem) for performance reasons: ring buffer
> data is usually overwritten many times before the system actually crashes, and
> the only thing we really need to make sure is that the cache lines are not
> invalidated without write back.
> 
> So I understand that the main use-case for pmem is nvdimm, and that in order to
> guarantee persistence of the data on power off an explicit pmem_persist() is
> needed after each "transaction", but for the needs of tracing, is there some
> kind of architectural guarantee that the data present in the cpu data cache
> is not invalidated prior to write back in each of those scenarios ?
>
> - reboot with bios explicitly not clearing memory,

This one gives me pause, because a trip through the BIOS typically means
lots of resets and other low level magic, so this would likely require
pushing dirty data out of CPU caches prior to entering the BIOS code
paths.

So this either needs explicit cache flushing or mapping the memory with
write-through semantics. That latter one is not supported in the stack
today.

> - kexec/kdump.

This should maintain the state of CPU caches. As far as the CPU is
concerned it is just long jumping into a new kernel in memory without
resetting any CPU cache state.

