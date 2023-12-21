Return-Path: <linux-kernel+bounces-9130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2C081C10F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C4A1F25477
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B907F78E68;
	Thu, 21 Dec 2023 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzq8hxco"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A94777F27
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703197711; x=1734733711;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JnIJRHEMVt3+zZC91o2nRNwdvY1OtV6f/YU2BJz8q+A=;
  b=nzq8hxcotvlPuLAVYCyT+h55z0MgsDBp6FKzAeZQSj0fNIZ7VawQnSjz
   2ZstqnAjG1/ciCjn1FpcYmFXYpUA2gQAToqjHqMjsWiPTZOPoxmNqlGBY
   KlvV5LoL/BagcMT53QJpPp6+snXevmJVNmIIXPgPXb91ebY/tLgGPg6JT
   dMurfyLiAqkn9l2aIZHWbL36/3PZl3mIgxZ1rZF4Vb6ipeeuRXijmUQgA
   stPKYtql0DeYF1kbiPv0vUjHQEBIvuqohpD3DLglM9HOlEUJCICWnW4cV
   7ZE2Ifwq0aJ2lkrpZEN6UARBjegf4SoIixio2Y4TgRtgwJRxV45GOB+D1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3289419"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="3289419"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:28:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="895249755"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="895249755"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 14:28:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 14:28:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 14:28:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 14:28:30 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 14:28:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU0+pjMfyimSzmYrQqN+pFZ9BKQ+qKTS9yMU1rhb2w/q/d6wtsU/ZlI5qIkhQRjubPJTUpVbtoYMGREg3uFSaG+2j5wQsqEzD6Q53nOD/cmPwMRlMRjQ3icFHHvZoXPYTGzIFprMeQ/xxeDlYiGzO0Kve4lXLC9fzE0Bm6mlg34tHTLEvoPLBH+aOp2uC6c5xumn41DhXwSAb+YcG1Hq1bv8q8dDoJn4NSs5N+cJnGVj2SRurMkNYJXq+6V/CmCESAaHPkE60oESBez+ALSrXbUrb+94gXCgRTjU4J8f2uAVOjYHNK2Ew4edbRKTfd7loIKqAkzSpggl3zHAsvl23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix/ljxlpb/63KbPMLxvv4X+gI9n3yGdUQJ1hIwIPUsc=;
 b=f9K/SmWX9oyGOP2L5PO8U/Kkh7fZAeJfgHKsflfWh8kshotAyiMhkG2Csf+hCd+GyLNXW+0kX18S13icGFENvjNUOR6hXTtFcgQm+RP+e96F3DxCtwCrIjjKYjDm0YN47FP4BhXBdxhxXK+Cts77Ez8opAInCD9IXMgJdb2qhEbpifMAv8i2pX183gRsnKcGdoLXeslG9NQ32l/Kh6zacP8h/hu/Vf/FbVh/lWSUBmSI/XfjQhl9v2C2iPm4FpzL03wc9Jd17t8+BgBI4WreqhWS3S1CJNe6Esw5i6qk+e0RAdO4mOiO7RoSJFgV9FvRBdwupgKc9t7Ajm0oHaTEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV8PR11MB8488.namprd11.prod.outlook.com (2603:10b6:408:1e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 22:28:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 22:28:26 +0000
Date: Thu, 21 Dec 2023 14:28:22 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
CC: Randy Dunlap <rdunlap@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<nvdimm@lists.linux.dev>
Subject: Re: [PATCH 2/3] nvdimm/dimm_devs: fix kernel-doc for function params
Message-ID: <6584bc064ea54_5580229435@iweiny-mobl.notmuch>
References: <20231207210545.24056-1-rdunlap@infradead.org>
 <20231207210545.24056-2-rdunlap@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231207210545.24056-2-rdunlap@infradead.org>
X-ClientProxiedBy: SJ0PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV8PR11MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e37d622-9d19-4505-b7b5-08dc02742633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfaLU6XVB6RH76bKZbLXSC88DbllhIIJHz7J4gqlGfgVUqrSw9Ihf8bZ9GvCJKkodUSjLS5QXwE/7SiBoiQIxMzvUFjCcmBXuopHA0HggxyWR7gvRiahTsMLNhwJPKpWz9Oc34E1dTcLrYYgKD9jdhQDwNVdlUUYA962xFyWA6xgXx2wag/MCQuuu0Z6s1raqCARTGR9ksW0TH8ANa8BdFod/7zCmHdxFNDTIZIaFoUO+pEJavirTJl+3boNz6U3v86rA/Zirgk08IY95Vk4tPu9OyNLTzzYp4ZjGKSUvWfZC6AemCS8vrBu0Mhddd/SmMxAi7MZYK3eJjdWfylDvufqdYANeMF+6EwFIiftKgeSGmquYyGL25mJjZf414CDGfQmlhB+q9N74PYmMO9qdRRlgA1FvqFOGAXaQsySSYg8dErc17R628oY5VHeHiWn2aUgj8T9q0a3fOVMeZcByfFsaUk/lSiy8/OhoI31y7jKuxbCZ0inOd5iAKhKOXz2uWhG12oWqEWNCHqJnaN1iEu3PSgUkcWerSVvB2wbTjfLCbZOd79+Kuxq8axRHcAGUS+vfx5xd3mAfi+D4EeKbEAS18MxY9KH6Sfg6VcnuZIun9KQMoRguY7rpMUx28c+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(8676002)(478600001)(54906003)(66556008)(316002)(66476007)(8936002)(66946007)(83380400001)(9686003)(6512007)(6506007)(26005)(41300700001)(2906002)(4326008)(5660300002)(44832011)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iBO8riNswaXBqq2F29IR5MSJvla8lPoqP14CpL5wZZxiGtl0qiVmUI4prUYk?=
 =?us-ascii?Q?UruYKr3dg/wWogcgX+buFkSSsKoerAwTIHbM/MokzdQdEOwWI2b6Gq7M2/Ly?=
 =?us-ascii?Q?SVVQpihZZ89z4gUB5gipDglDyalFzPvXoNIs/zaQdFC0iJTQlwq8jtewN7g4?=
 =?us-ascii?Q?o4y/5vGajgaTkDDNSXaqHzPkoYEYnq5JiNHs/2a4wML/nQp7VXSbuIjN9qQw?=
 =?us-ascii?Q?WdGUVTya4UU/G0gJwAU2FR2s7O7QHSihFzWUBoBSUh7ITDilO+Sf1UgaQzCT?=
 =?us-ascii?Q?5bq6ZzbgL7BtIyOnnjKDFUzH2VdXxfgGcICkU+CLh/Taf+vF4Hom7Q4tfi1C?=
 =?us-ascii?Q?L0b0XFg8/hND//IKW9tbxvD7IE6ToWcvZ3DUMTrBYz09OvdMe0fSFL1ZtYw3?=
 =?us-ascii?Q?XqwH3tlGtGUukumwCigy8nWU5UX8tPtDf4WXKfXz7AgqAe0PrlI3A7VtD/zm?=
 =?us-ascii?Q?HYGXpfya5mJPucurpVY2BaqVbffLq/6oSq67ryrUdJS9gAHz6/xzSrq/LR/C?=
 =?us-ascii?Q?V/dmiz/N569sVHJxwhK5EX+HBNorBfSVhgLGmb6RhB4cH1RDVLjh7HtL10+R?=
 =?us-ascii?Q?JlkmzzOaEWzXWXq+oBGQ6ZtcUwAbBbzrD1MhXT/y7RupBJyc8GZbnSemTMUm?=
 =?us-ascii?Q?1hCbj8s56ozpdX8EUljYqI4Syo7wOuJESMNigEEF56SXCXpuW8+ZD3WxWw44?=
 =?us-ascii?Q?1e3liFyXC6H45M9WW/3zZXPKDZfkd1EjIE/xGT3Ozs73RUcwE+pegq8PHL8W?=
 =?us-ascii?Q?NjsNRiupiKVC3S0840p4Bv2jwJn4hPnVm9ajHmMUo5L8TlQronEGzNvlQIPH?=
 =?us-ascii?Q?FaHOecYkPScUK1hFQMAFEeSVQpCv1qlHhy2qpi5ceP6Zo6Cp8TSuqU6me8tT?=
 =?us-ascii?Q?k3dx+2A6gXW5N/jX+g2FQ9IQ50DVFoZhSm3IiTGUXEbJ5l/MFiFUh6IMQv39?=
 =?us-ascii?Q?FXWR9qkI0xvOZ58Aw37nWz0z/4XUlcECfQYb/5DouABWu6Re++Snurjh0PNf?=
 =?us-ascii?Q?l+b0HFRCSs8WiAnEHtxKojwtXcTZl9NaIB8+6CpSgr5+x7Gql4jmArKUO3N8?=
 =?us-ascii?Q?WYiNsLQlU47joh7H00K5WT5UjweqR0nhfsJ5Fl94xBEvNaXYxO3mTE6n+7Z9?=
 =?us-ascii?Q?Bc5UlrCa4H8MbKKIGet04se4QQ7JpEZjAJ8GdHr0uTBqnJ7CbFPfNs921ts7?=
 =?us-ascii?Q?wSuKecXcwM5rLoc4mlgPOawu+Yyk6sQJvqgQE9XSSuGA5jMKuOK9jqVaYeQA?=
 =?us-ascii?Q?e8ENM+BBVew/1A8OXUQgLCTNEU0QSBgeO0UElMo3heNTc6Y/VOEyINjBFbFr?=
 =?us-ascii?Q?FmeqcjVl7h1dqV+pjYJTaF3E/sd7EgQX9mCe+SG/3WH5O9RHc5TgSPgifYed?=
 =?us-ascii?Q?dkNcTYe12sYEs6SiI31Wujeb753+8cMyYJFtqBt8FBJMuX9TniAl2Koz4I4p?=
 =?us-ascii?Q?BNCWcS/g/7QzcJvIujkLcn/ZT4SbiSlWd2GyowGXqRZ2Md1caO0BqVhlKX7h?=
 =?us-ascii?Q?aH8Nx3OX0njZKFwTVOU06kTe0gCnl7JB4DRiZktCctGszlGqORDWUMLV92+t?=
 =?us-ascii?Q?nZ1+uizvYA4n+UWNwKzEk/8cQ/gJ6crjhM3blNLJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e37d622-9d19-4505-b7b5-08dc02742633
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 22:28:26.2084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Og8KtuwuThvLqn5SQGIA43lvlpayOTGC/mEpqnAGZ4nQpKoaOe+TR/SREuWkIueVoB1Zi7xGV7hrp1NZSiDmjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8488
X-OriginatorOrg: intel.com

Randy Dunlap wrote:
> Adjust kernel-doc notation to prevent warnings when using -Wall.
> 
> dimm_devs.c:59: warning: Function parameter or member 'ndd' not described in 'nvdimm_init_nsarea'
> dimm_devs.c:59: warning: Excess function parameter 'nvdimm' description in 'nvdimm_init_nsarea'
> dimm_devs.c:59: warning: No description found for return value of 'nvdimm_init_nsarea'
> dimm_devs.c:728: warning: No description found for return value of 'nd_pmem_max_contiguous_dpa'
> dimm_devs.c:773: warning: No description found for return value of 'nd_pmem_available_dpa'
> dimm_devs.c:844: warning: Function parameter or member 'ndd' not described in 'nvdimm_allocated_dpa'
> dimm_devs.c:844: warning: Excess function parameter 'nvdimm' description in 'nvdimm_allocated_dpa'
> dimm_devs.c:844: warning: No description found for return value of 'nvdimm_allocated_dpa'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: nvdimm@lists.linux.dev
> ---
>  drivers/nvdimm/dimm_devs.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff -- a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -53,7 +53,10 @@ static int validate_dimm(struct nvdimm_d
>  
>  /**
>   * nvdimm_init_nsarea - determine the geometry of a dimm's namespace area
> - * @nvdimm: dimm to initialize
> + * @ndd: dimm to initialize
> + *
> + * Returns: %0 if the area is already valid, -errno on error,

This is good...

> ...otherwise an
> + * ND_CMD_* status code.

I don't see where any of the ->ndctl() calls return an ND_CMD_* status
code.  What am I missing?

The rest looks good,
Ira

>   */
>  int nvdimm_init_nsarea(struct nvdimm_drvdata *ndd)
>  {
> @@ -722,6 +725,9 @@ static unsigned long dpa_align(struct nd
>   *			   contiguous unallocated dpa range.
>   * @nd_region: constrain available space check to this reference region
>   * @nd_mapping: container of dpa-resource-root + labels
> + *
> + * Returns: %0 if there is an alignment error, otherwise the max
> + *		unallocated dpa range
>   */
>  resource_size_t nd_pmem_max_contiguous_dpa(struct nd_region *nd_region,
>  					   struct nd_mapping *nd_mapping)
> @@ -767,6 +773,8 @@ resource_size_t nd_pmem_max_contiguous_d
>   *
>   * Validate that a PMEM label, if present, aligns with the start of an
>   * interleave set.
> + *
> + * Returns: %0 if there is an alignment error, otherwise the unallocated dpa
>   */
>  resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
>  				      struct nd_mapping *nd_mapping)
> @@ -836,8 +844,10 @@ struct resource *nvdimm_allocate_dpa(str
>  
>  /**
>   * nvdimm_allocated_dpa - sum up the dpa currently allocated to this label_id
> - * @nvdimm: container of dpa-resource-root + labels
> + * @ndd: container of dpa-resource-root + labels
>   * @label_id: dpa resource name of the form pmem-<human readable uuid>
> + *
> + * Returns: sum of the dpa allocated to the label_id
>   */
>  resource_size_t nvdimm_allocated_dpa(struct nvdimm_drvdata *ndd,
>  		struct nd_label_id *label_id)

