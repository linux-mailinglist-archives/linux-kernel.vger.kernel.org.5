Return-Path: <linux-kernel+bounces-15789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14243823283
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4D51F24D92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D1D1C28C;
	Wed,  3 Jan 2024 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOLqHlGh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8465A1BDDE;
	Wed,  3 Jan 2024 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704301680; x=1735837680;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=70JQJlokyiaAyGaYrk9lvN1nK0nTFbNr3bb86hDu8YQ=;
  b=BOLqHlGhS1r9yj7SW5HS4tzEi+6uKh9IEJprRp/TBvm/eH9NZV20qK2L
   zzXre2/BmkEEW6XiuXex+vmhOahtzDcLeeA7JdVa7DxNOoQB3AhW9UZrC
   +zDkrkmG6UWxZDKTjcgDiDEqRL1ebzuV2KfurTjLBMHL28vqM7jqJq+xF
   X8kEieeI3qQTYskQv5EqDPpM217IQzOGTXscXXtrMfhunf+y1sP4+GpKS
   QTi3uoOdvC9qusZCQGrsvucAUzJStcS4Wip1p+HuWyoqMGkX13gRCrtNy
   J/D3SiwGwN6YudOHJF1AOXlXH4oAqIcFkUY0URt32YWIv+0bIN9XDpgkO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="396765085"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="396765085"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 09:07:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="729835277"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="729835277"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 09:07:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 09:07:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 09:07:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 09:07:57 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 09:07:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkYi87BKHKS9KEOTdHSQZnTUQOpdjW65krugxABV1s0ckRc/j8m7ITCwCAdVOcgOHPab4nGX9zAODm79ZzUjZYGLPPpDnqkjHWR/384CUObi5NTMs13VzRmMSFVmOajkYlmTLyYZL0EZkTBzxaQFxVWfZ1kTXwdwZXmY9Vm1VNa8R96D6enDT+0W5S6mPYaBTCYoeyXu7LYUr6nadCBdsqzMluunoy4xnVapoeeKmxsuR3mz4lW2eVrPzZKcDjFP6dmJj2HGbWMs7asgxw3tOZ3qdyPaWRm4xo7HC6Dgfxfovj0J6xtOBJXHMWvG5OrmKT/dxKooH3CKW7lqk6HLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J6nJQkqtmSngy0mjMZEvNq6UxNz4BjJSSTiU+OhQAQ=;
 b=jH83QGP1+1Sa7klwmVNAory+rOM3mBflxdAH2bYQn67U6BHOX7gI6GnDurNeszC1vvGbEoD8uPYYeQK6r6zqCYT+l1GPq3oM5L1QGN0ziQlWFqc/+Lz1l7bB9WI/lHBXqnjBqI1yJ58O4IfsbVoX/heGteyvDcDtTTY2ACv+p8PFs+RkOQDWf+NqGAVUx3WQlPWlAkFBY7JlHPs0rz5XExvQhD60VujBPglhHgJJiug14Egmgyv7edUY/Km9P1e4+BtEvi45MHykzxqQmRaVmxYnnu87qA6s0Xg7PUabIt7979ubLFWw0RW0rl6aiMxtFsFdmv48GcjZlgnH+VMEog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 17:07:53 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::8de8:c1ad:7062:6afc]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::8de8:c1ad:7062:6afc%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 17:07:53 +0000
Date: Wed, 3 Jan 2024 17:07:41 +0000
From: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Damian Muszynski <damian.muszynski@intel.com>, "Arnd
 Bergmann" <arnd@arndb.de>, Tom Zanussi <tom.zanussi@linux.intel.com>, "Jie
 Wang" <jie.wang@intel.com>, <qat-linux@intel.com>,
	<linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: qat - avoid memcpy() overflow warning
Message-ID: <ZZWUXcHBwTJjiT/H@gcabiddu-mobl.ger.corp.intel.com>
References: <20240103162608.987145-1-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240103162608.987145-1-arnd@kernel.org>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DU2PR04CA0251.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::16) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|MN6PR11MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: e50c40aa-6cc8-46fa-a79d-08dc0c7e8642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3cd4n6y7U/PTq/Qmh1e7vmB31oLZrEh3duviw2y1cn4rn6rQ0RrobMooFvu1vuuyuo+HJMyCohARglR5ixw4FxRAmfJGciTGYGIU7NxonV6vzVC0xh1q2SLuUOBHcWoeyZVh1fH2qvlhY+D4Q66YrCwyAILPWNWzClXl1PxHCYL4jZQ5XsWfvRvYSLbiuWyoGIuQmhQQU3mNVR4FUtb33ob5S6iOoYPqiaox+PR72B4jwp3sjRxjQ7rwWiKUYu8jdlyZU77//Us/c9tPZl41im99tZg8EOI8qZ2F//LJ8s67GVVyp8Kq8djyTnewIluoVlrNiQ/hSetlIXktMLbsTlKWnuY5U3BtFub5SpHxKwI3RhGBNZPuY1bRd/N3fRAxjyBiFuxZ+nVAB9GLaO24c17EYCKCBXgHWFZHQ52KzFYoTldM3fG3dD6r/d5kd6pqY1ShN2SO314/DmwIUuBmsELFdbBu+zoNZlteTndQRkvuDk/Q9x7ll5AE0FkkPQuaRLHBmTNwJztcKfv6GWNo1rufdZYHqLUnaGFdjxdMiLvxnsi2QEnWaDIFyv1eeMYxGPgO9zrfCd/TrUipvlXtGac6pSs1m2BFRRz76BKBGgHL+gekL72i7c4PccJtJQ0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(230273577357003)(230922051799003)(230173577357003)(186009)(64100799003)(1800799012)(451199024)(66476007)(6506007)(36916002)(6916009)(86362001)(66556008)(6512007)(6486002)(5660300002)(2906002)(82960400001)(38100700002)(41300700001)(66946007)(26005)(83380400001)(4326008)(6666004)(478600001)(54906003)(8676002)(316002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gV91LtlBMC7701PJ5PZyP7h7qHA0STnxKzDD73jbAVJtO6Xr3rpliad/nu7e?=
 =?us-ascii?Q?nF0qJzbDBUU25zZpNg8JeEpN0SHXbQMWZWeUNEaWqbLMezWypQtTe8CGG6gU?=
 =?us-ascii?Q?2aDfGpGMsBnSdNIxA/029JhaNZTt+UaC1TpNK8lfdNdV3AYHRefA/0jDHIvx?=
 =?us-ascii?Q?srPxtSlD9oLyhu+rkIqH9xsADXv4ej96rlc/LUL17jl7Vhg8FG2l7R5myIgO?=
 =?us-ascii?Q?vT7YjkQfMUHddk0oYAQ6M1U6dQk/xfS9RqlmWwrI+clIlfcM3fFNwpFhY7J5?=
 =?us-ascii?Q?gUO2PaIktwp8h2W3sZJ+0gqn+heYhGlKUzGqv/EsCLUPk8I9U1k3676FDfy5?=
 =?us-ascii?Q?/uXw85TnLgSCF2j/NN0tDUYE+Iu68xRHKq+N2gXPUO25XXUQ69B7AKN6IRLp?=
 =?us-ascii?Q?ixQmOO4+A6zkuU+hSiDT4L4DpEuQpqkZJiAImsTfZLqXW7d1XEc5NwsbNBbK?=
 =?us-ascii?Q?sbNss8X/U7zbueOBAG/WwyvBXnL1G5QHzcOcnih1stH/6AnI3htn3z3CnxUK?=
 =?us-ascii?Q?LPoN9ZN3JA7MKZrEQydt6jhEVZEa+ph03aykmozcHgUfqqSXiwqSfxxc6Haf?=
 =?us-ascii?Q?Go2pwS3kAUOoZsFJVSzMJs8gT39lc7IjCeddFKy/0IM3CUFAVBNmLvgr6mDR?=
 =?us-ascii?Q?JyOfCtCg4hiSRcg3KUpkNcAafUJ05cB3aOfgAcJgTwEnDR7CEDOWCB47K+4O?=
 =?us-ascii?Q?o4p/4UAytJl611fUhQDt8l1FI5XErQaifnmCiji+pkXGXk82/vNcUsXWA9jI?=
 =?us-ascii?Q?9McUY52epGIxDs7ncsv5tzacc3gzg0KyY4YSCtDaS+pBTO/dXRLMqwdKzXPz?=
 =?us-ascii?Q?9vsMX3573lkO8vHNfMWgKBt8niBpvrgExic4sq4dHRfkidwY9Mex5X5P+6Uh?=
 =?us-ascii?Q?/w1i9I+Rr4Bykv9h/AJ3zJYnjgPpb+K3gzf5pDnOisLv8SmXDtGCAKjILAOX?=
 =?us-ascii?Q?FEvr8m9VPZFvFOOdVVWmKKC+7ZGnOFsPHyJOObwG1FAV7F2LjoVULor1cBy6?=
 =?us-ascii?Q?nQByoE8E94gZtYmnyzqLWuBXJo2rupiS9aYyVKqc4gYZ9Fg4XnIICEZoR+kw?=
 =?us-ascii?Q?eEX8KVntiUiZtJJGAtSMIXK45vk8PONA98GI3iWKh+3GBxhnnX2Izvi1UMl6?=
 =?us-ascii?Q?OoC9xhvdeQHn3oIbAxmQ+iWqtbssTHMVa0y2OSSIIf83z2v1jh1eQOjvpATX?=
 =?us-ascii?Q?Kxp3rGmz83KIMda0zPrVOH5on4UYupmjV+GtwLlSoZYuda2O8zTpQlErjfrI?=
 =?us-ascii?Q?7qtf2dcYzWuzji5ZPSopoBYsSYTQI+FUXgKBYCYP1kf3CrkeJAor2+01JeYm?=
 =?us-ascii?Q?nGD+ocwFpsrFHLS9/yTT408tlqELTc/yqeoyjOlF+yvYSifzz9h8FnzhE3uc?=
 =?us-ascii?Q?ZeryUSsKRxXjozzAjm/9rI/enBFQEGh4datxAvFkC0imzc01xs70Nfv9ryLk?=
 =?us-ascii?Q?yhcI99o1c7RFTr2ZOMfrgN2QgEzNbwvaOojNGI5rL8bFkNV3nzAGXt/EeKHn?=
 =?us-ascii?Q?UqsLsMzojxUOx/8kH8DrJxyTV+sK052Pk65rrnohMBZjaHM5WuJGedH852cO?=
 =?us-ascii?Q?EGMZ2nEVNT4iMOz4hYoWcyebnmz4CdrOxVUKTtiw0rOy45CrZMyc5e4sDPno?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e50c40aa-6cc8-46fa-a79d-08dc0c7e8642
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 17:07:53.8890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voOJ6O/xfx3fbpWKT1CHio4WMMuXNMXWA4hQDKXbpqTMuIb46W4bBFWlAih7piNvthkncS8jfzU1EF1OfB9F4ZlTlEE77ifrmmS2z8lcJb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com

On Wed, Jan 03, 2024 at 05:26:02PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The use of array_size() leads gcc to assume the memcpy() can have a larger
> limit than actually possible, which triggers a string fortification warning:
> 
> In file included from include/linux/string.h:296,
>                  from include/linux/bitmap.h:12,
>                  from include/linux/cpumask.h:12,
>                  from include/linux/sched.h:16,
>                  from include/linux/delay.h:23,
>                  from include/linux/iopoll.h:12,
>                  from drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c:3:
> In function 'fortify_memcpy_chk',
>     inlined from 'adf_gen4_init_thd2arb_map' at drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c:401:3:
> include/linux/fortify-string.h:579:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   579 |    __write_overflow_field(p_size_field, size);
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/fortify-string.h:588:4: error: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   588 |    __read_overflow2_field(q_size_field, size);
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Add an explicit range check to avoid this.
> 
> Fixes: 5da6a2d5353e ("crypto: qat - generate dynamically arbiter mappings")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

