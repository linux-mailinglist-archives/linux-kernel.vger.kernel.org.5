Return-Path: <linux-kernel+bounces-9121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F254381C0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2001F23D38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224CB77F25;
	Thu, 21 Dec 2023 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXgM32mV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180F377B41
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703196878; x=1734732878;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pCWCXmw3o6dPj2XanzNqLFy4SHWf/gV8IlNJewPSiZ0=;
  b=eXgM32mVtHA6wCnjhAJlh1MO36Ch6bctYPWhD5kLAtM8EDk19XButv6s
   UM/I3E7fag5MnbpigCRgtDgdP4hjdnVyL9YKNVJHkw7M5yJElYrn7Kovw
   7y5IFUJ1iX68MpnmBgp6/NMB4YXZHkW/LBQDJgXGk0/wkZcILn1gOzdBk
   A8vo/qLL0VMhTEnvpfFDMKRh0nHDLgy7CeMkxFip5oIeLby2qqKAGijJN
   thinJwc9lVHY81onGJPMX2tu7tMuvDHngPeUAdDzw6cJSXXnzhwFaVMTf
   7BPwXXLN0gCzQR3gtfGUoCjGJ7u+JPN3ysKOCKI6usc9DGz9eoGCQ/k+M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="394940840"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="394940840"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:14:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="920455826"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="920455826"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 14:14:36 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 14:14:35 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 14:14:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 14:14:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 14:14:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pu883tDwrnmbZFETCB1PRfTo5ixlycika7jgSdFDvYx8lBpkgAsyOu9FWCwKDYonqWP+JG2IJvuqpYgCfBXxc1GvnulB/S7b70rGyBnAhX3i1XNFx4k9nctA7V/lzsCaQ0QXljmMM7BZFNnQ3x7R9RUClJKNeuGRRVDAGcXRzTrFoXRDpbbwvagOI6Mb9Oac2Zdk45k5uJSfstzj4GJozXv4aNXmeC0mvrA+GJYU7dHq7otGx+/3pPBlQP7Jfe1FQ2fpcbzt6XXkLVTQpgt3d9UdUj1rzMf5hnufT4HCCBJ0q/acCXnw7HqGqLca6pJN3TlAhiyQUUZYgOEfjwiHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VITqA6mAkKMpvQYv0bQsrKbm4SS1maWOF/oQex5/MAw=;
 b=InYzwYd8OTPsmEWv8zpDg80Gqe6TH7BtxFSErkYHGgvp0R/JOA7ovx29RQFpUQtjpJBhOhX8uhQ4hz/TI5B7nb6W0mTYbKt0CHRpARMF3M9lqElNNYlgR1CQw9uHYmnarTLVpFWR0gMf6JctKrzvSYgerRwu4KAcq6bvcZZlX6PzJ2XA6jXYbJbElwISpsPewvsAHEdGgNh+xXTCgD0NzLpZ3cl67AZkS1msSJE+p7OXOyrA1GP6hXUvHRGc35jse2yM9K9KsrU5zcqdTstQLX8URoMUp6TKEmweH3ZszWAJqYhh2uRPsFlf1SbO9/aRXA19OD9WvlK3AEIX/dwNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB8494.namprd11.prod.outlook.com (2603:10b6:610:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 22:14:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 22:14:33 +0000
Date: Thu, 21 Dec 2023 14:14:29 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
CC: Randy Dunlap <rdunlap@infradead.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<nvdimm@lists.linux.dev>
Subject: Re: [PATCH 1/3] nvdimm/btt: fix btt_blk_cleanup() kernel-doc
Message-ID: <6584b8c5999cb_55802294ef@iweiny-mobl.notmuch>
References: <20231207210545.24056-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231207210545.24056-1-rdunlap@infradead.org>
X-ClientProxiedBy: SJ0PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc8b4e5-6b95-42b3-fde4-08dc027235b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRtLIAgLUMBAF9cgOXslv01GDceF/Gwu9aQK+xHYEEp73hTSqsZ3mc8PMsFRxVTFsYp1kbSe/QFuWH3aRYRYHuOpY5xs3YiaeL4NqLU0KPYW2gOspw4Gswxc1CDkja2YXEFoIBzHFSxcc0IIdL6an1KKaDWiKn5+vN1CMVQ6Zgx6TP1skkU0YRMrKPEtwyliFmJpTHDnjsAsoz/HSqAQdCHeQxh5LpNwDhLE9ChdQDoqN6eavNTXhy+Q8SLwhEHRqhsE8C1apT3B16NVxoggDKjNYFstJGihOI5/+G+CPUYUdd3Pb8UdZysm9p8TsMl+64lB8EXWpTlQ864rfppK310wrPDRnJpxxXZMna51IlrOJedt2VUXUqW7Mz/fQWii0XXSjTvIRf8jQmZgQizrZcNmT9eLU4drhVpXzW0KDbnRozscPVGHtqNnY3z7ve6Xj4++LaZBUniVKdDzUo6ui4q7dOs7eNamud8J4lVFEVN1ZVo+VfoF1KZRJo62vvjN3bIJo/a1k5VJMdkDSgopQYy0uijyv+lWh021gK3wf7VtybotRoYSNZo6qp6YSYVhLUtpPs4oF4ut4+BWbMwaeqHqrMttK3tRl65At3/vNFsVKH+OYUlYbFkjHnMljHSN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(66556008)(66946007)(54906003)(26005)(66476007)(478600001)(8936002)(4326008)(83380400001)(8676002)(6666004)(316002)(6512007)(6486002)(9686003)(6506007)(44832011)(5660300002)(2906002)(41300700001)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TnwOuH0YRpto8d1CVSKdjNjN3tcfh9NAByovXGwIkM8kL8R8Ptlliz/5rDSE?=
 =?us-ascii?Q?MeMlvgFPPR/XCGBKqL6csLuvFkvxLtCsuB0PawREe8glyBeX8lCnzjhxJf8l?=
 =?us-ascii?Q?e9qvM9Ts6RzpKcMdAl5kVODsY0kN2xhBpFc+VCXwMGkjcXDDCfDLLfOTVjmM?=
 =?us-ascii?Q?Z53e2GDVRsGEHkUai1KjC65etuQsF8GWs56JHfTWQY3fKjBt6MOZdj0aq0kh?=
 =?us-ascii?Q?3UdKo9wycFruhRBzdgfHBSXyBmKVa1JnHnUK2ej/kV06qUY5e0Ea+bTVfD9G?=
 =?us-ascii?Q?ADbklSqUY8jDOwaa808HGC3CJx/aYNV3yvk0RhTo8RMO9XSlHN0VCFICBg8R?=
 =?us-ascii?Q?GMElHjGl+IYWOAYweVIiM5IaNrVfmY865GR5V3KVhWRn6/qsVxDyBkxa+Uha?=
 =?us-ascii?Q?pVXp/xTb8wSeY7RH30YN8gybq0TRI/lt/cauCdtScnSqZt02HPVXY1WTfFTV?=
 =?us-ascii?Q?f04SpFpdrIzPB8IIFw3iueqoQajkjNb4bL+evVTid0vSCmjkx4io53i0IKMw?=
 =?us-ascii?Q?J58pt/5+TFHnvK8ZMIE+4uobz/RlPwR54/oSeIoz5ZqWAfvXkG3rdFjqbHb3?=
 =?us-ascii?Q?B6DNFr3hqA7f1qwERArjbQwtaOId5hJ37VAF+715c1vDc65r5qWkJBVgHSLb?=
 =?us-ascii?Q?PYmcuK51Sm1jgGxDl/8xwBe0GqkIjE7zqTIFe2ns/GKhOjkm+1qh2e4PgK3f?=
 =?us-ascii?Q?iP1ISkbg84e/6jOrIN8fW81qbbKPZ9rdc8vgv+YmJBEz0xEB92KKDd3Z6vXW?=
 =?us-ascii?Q?3B5/M+MSJVu8s5f2thNJaFAqAUFo2Dd6u75v4uzCK17GGLs8QW+++Pz1pi7E?=
 =?us-ascii?Q?KqZ5pbJEaPT0+NCxxoq8EzOWoJ9ZDJRWN9bb5qsUzJjqShNOtJclTZNnpf19?=
 =?us-ascii?Q?A5CbYNG0gfhd2pfD87k9YImHmJG4xC32/VrNlm7ktk+qPUbGHTMdfme5giH0?=
 =?us-ascii?Q?namn7reJfb/7bF0m0aEHYXvPSRN9K4NJuaUcMsJrNGf6IS3nPjpbDLJaLzBE?=
 =?us-ascii?Q?VFUMld5crnIe54IGC48d29YFhLf46QKN0wb1V8qPJl2if3ngxCC3oidLhRJV?=
 =?us-ascii?Q?2qh0mPfQstWJ554sE6wueel1TiUshjKkng8h40L7gJSnAD41qMn8q/7CvsqM?=
 =?us-ascii?Q?YV5rspYn8bhiTuXsHxotLCj0a8qbLuaDsySuvBEj67OpnWWfzyNjAZJRJpDX?=
 =?us-ascii?Q?EdVF7/FSEWyDWrWycjzy1fgUvAO8OJQL+OBGbJJMh3X1csqJwjKHlZ2Up/kF?=
 =?us-ascii?Q?xTbMPDcirBbnR1yTGxZzcIGxZJ2Uavz8dA6W4z3oE6tDObzyV/ssrOAG79x+?=
 =?us-ascii?Q?OTFkFDkCllCZGnVNKSnLyUtUxjHLjbyqSTpYTQ0wO2F4UaKoHHmqA60Gl067?=
 =?us-ascii?Q?85RXHUegw0iiUx7unOfiQK7Lz/UwWBtxBpm4zoKjgy+aMJKVQlxFDunv+pT2?=
 =?us-ascii?Q?lQUp/8k2TnHmwsNEEF8K6cPpDIGnm41ihZX/bfnM4JOb3ihhTl9ItUpUZJxZ?=
 =?us-ascii?Q?S19d++4loaIkcVE6BpGLSpJptZEUZImJSrjPZAk60Ttx5QYZWxNu44Zran2f?=
 =?us-ascii?Q?ZKp18LyxVwks1UN3vwnZLPWvQFvdrWb+5eAdr67a?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc8b4e5-6b95-42b3-fde4-08dc027235b8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 22:14:33.2246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQLKGfQmYh/LLtOlyOSaov9t/uSDupLfXeui3tqJoE/Tt7AXozXHxg2xROsIfd0uW0V4ylzAVnCHtaB+CsSs1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8494
X-OriginatorOrg: intel.com

Randy Dunlap wrote:
> Correct the function parameters to prevent kernel-doc warnings:
> 
> btt.c:1567: warning: Function parameter or member 'nd_region' not described in 'btt_init'
> btt.c:1567: warning: Excess function parameter 'maxlane' description in 'btt_init'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Cc: nvdimm@lists.linux.dev
> ---
>  drivers/nvdimm/btt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -1550,7 +1550,7 @@ static void btt_blk_cleanup(struct btt *
>   * @rawsize:	raw size in bytes of the backing device
>   * @lbasize:	lba size of the backing device
>   * @uuid:	A uuid for the backing device - this is stored on media
> - * @maxlane:	maximum number of parallel requests the device can handle
> + * @nd_region:	&struct nd_region for the REGION device
>   *
>   * Initialize a Block Translation Table on a backing device to provide
>   * single sector power fail atomicity.



