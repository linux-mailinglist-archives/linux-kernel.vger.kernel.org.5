Return-Path: <linux-kernel+bounces-6419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DF5819895
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE55B25334
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B23D171B5;
	Wed, 20 Dec 2023 06:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InxGLNgP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4EA168CF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703053525; x=1734589525;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Xlp4xu+mWPH6+SMlNI2ak/WiId+hP0sKzcxqASXixGs=;
  b=InxGLNgPBjAifdmxnY1hzIpiG2sKhylroitQidhrAy+032hnFqPDp1Nk
   hyfouzUDScxhReXTZ3WrZnc8njnX+MVz6cy6ENzUI8VWMTFh+sM3ZztcR
   b2jCcDUmCeyTDYCp/lzwVakv5tjWATJx+2cphOEkP4w7lmwKqcwBoNscG
   P69Ue+KbEZNRBRQhbz5EZCPfnegG5/57v0fASjXkS/jwMJ/R8YaH1V0Cd
   wz8EqjQ47XGln4KwfdxkvaTZwY/IJBqyK58HwaO4fX+B5USD8IOLVQL3x
   i7Kr3taAfXWAmy8EQFCbyf+gYHNVfdysYBEsqiBFMhhAF17obPkWHmdqa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2595809"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="2595809"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 22:25:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="842160572"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="842160572"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 22:25:23 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 22:25:22 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 22:25:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 22:25:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 22:25:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BU6eRR62pNkCQSWthtxAXvUpPqBx3upGoE5vmHyOByPKe0l+w5L5ydm2+d25Ch/SiK9fI6pSgUyoBlBjS3NEdeQ1Rq8cfuZ6Zy/HDIiB/aYKUG8XUe5WG7OFA5eN5RzEWuwwUKtiLkaFICmWVaDGvRmGdPnKWah63KXZoFn/6ZZYn0jtQxRu+mEKLhaKXlimWEAn9FCcQHSN4TMwxBH1vJshJWYjmRvOdeqx2e0bEGnqvOjhVRF9tJAw0puklUkEfnYF2WUWp30rDBhwpMGofzd6Z2NuU9i2rxz6W4R/1uDqesfwn+jR32Wy129hUxqYfsxJb3gBCreL2IwAtkd+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lR5ZuGRbspF3u00vA4UX+B0qKcNNJ/SqfUKfKjR4i7s=;
 b=OjKEqwgIfMcFDBoQrVA+LrmubAjN/9ZzK2kwReYXJvzSe5OxYtbbiyrUPNaMP1fpkAvBr5+kA/PQTERh/gpRShOtIqtpuAYO4eVpyNPLd4rd2KejqAFDnFLER4gepj224C/nIahoOGlaQusB81aQjLlv8YbFmfRovZbueFlBx3nHU8NDm+IfUoIX0oMlxG9UAUKqsHM5MYS8EC+Tm2B3jQP9040PG3NXb1VNzl9X7OQIf3Wb8W7tHWYYVYbJIUTCyOriSEej7aLNYhX9kcpwbn/VbQGFc8vb2cHL6atfXy5q4tzNKIKWnT9NuMxt7lhhxYw77yByDc8uYxn633WFkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CYYPR11MB8329.namprd11.prod.outlook.com (2603:10b6:930:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 06:25:19 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 06:25:19 +0000
Date: Wed, 20 Dec 2023 14:20:52 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Kees Cook <keescook@chromium.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: include/linux/fortify-string.h:52:29: warning:
 '__builtin_strcpy' source argument is the same as destination
Message-ID: <ZYKHxJPcAZ+rGPeb@yujie-X299>
References: <202311301039.7i51bZCz-lkp@intel.com>
 <202311301409.F2AFF5DA1@keescook>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202311301409.F2AFF5DA1@keescook>
X-ClientProxiedBy: SG2PR02CA0123.apcprd02.prod.outlook.com
 (2603:1096:4:188::22) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CYYPR11MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: a0680911-6a93-41e8-c9b0-08dc01246ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gO3R7M78RdSPrCXQrN9H2E3FxmwY9TYPGJj1q6IESTHXt4lAA+pHEedfbwbt1Li2IWIELgTdw3uqvqOqKYW5WX/hTeG+LqRp4Bl+0szdfUUdZSozzOrcFEWQBr6BsZIYGpT4uVLn3+x2GcpS+c6LcbV6fFp6zRhWxGf4QypZ9H7Z8r1e//omLW353eKuL4OOqOks1ZpY7ygjGdOZGJ/cFMjzKdNxwOowZ2wjPEUDlO1PrL7IN4H2DFe4GVmcB/hJXF88/mg/Vh1ca+Yf/Ar0GkcaWUjC+hGU+xbEQbrD6M6in46E6UZvTczMS/2f0faHf715izs9xLkWA9wDg6ntmgaLo+kJlGwnu5V7hiLLQOI/Ssgxb7YIkbBvSTQMjkF/cx+W8MyFukQpKIBm1rryjkoXUgU/cP81Oej/KJah/3eGEOr2SUPtSV3me7V/ap0Q9gPBJynmnhL6R8uNRb5Qtk/jnmUGjcFSS6QVG7EcvBjOtbZXe5AlNHYDe2BH+dN9xfr2JAtI/njbsY6oUaS29gw+BrBFuhe+TeR+UBSyrMFSIEuPvSw3zWxlhypvDZzybHZarfDHOuoYuPKopkDrQqKgUjaPcdRuHsqhL1jYXaxabkbQ54iZgfhYJudX7WEH5OqCStyx3Xj09Cxjewb9FlDkOkmZGZ9sFwjyNplg8nqAoFRuggtD1nxXQVMz4xHM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(376002)(39860400002)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(41300700001)(86362001)(33716001)(38100700002)(82960400001)(6666004)(316002)(478600001)(6506007)(6512007)(8936002)(8676002)(66476007)(6916009)(6486002)(66946007)(66556008)(966005)(9686003)(5660300002)(26005)(4326008)(83380400001)(44832011)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DbjK8qI1rGWdtFiyFwX/OQwMo3T/R4gp3JxSwBxdrHm8PQiO6lIih+8zao1c?=
 =?us-ascii?Q?6oNnVdQon7LzncQ6sLP2tfkqvvAA+FoJru9ha+pvLQjlxwrRtAhy+axKQo3r?=
 =?us-ascii?Q?vFFdgM0RIFga/HTHd0jBqVEHqux1fNcXbOg/0LQZeDtwH+a9vnwhIKPtSPdG?=
 =?us-ascii?Q?z94aqN9o+rYtoDWPc6FVWQTYROfgNeu25FC6MXIV6aK5Tw9N+J1z88j4ybwP?=
 =?us-ascii?Q?FN8s/reQ5bZSr4+rhZ4sbUbyevJva5Fq0zG6/957SNl2rcpEhRju4O/CS9Fe?=
 =?us-ascii?Q?xNK8PJwnQPAlAzMKhwCb1z5/0CEAyze/r+oD/2OyfGy4E2ElIQlfPQ+m17mQ?=
 =?us-ascii?Q?VWEQXng9ly4akJjnwQDja7far/un1n/RIKVGjGm3lc8xEGT0cJ3weBy2kFIh?=
 =?us-ascii?Q?zu/P6YKixRCt9tJHWPMOac63SDzEG3gK8WcGYiH3CO6tepqK4zSBQC9SBrPp?=
 =?us-ascii?Q?5F6UaQwmfINhikZG5A2R3Q1nlKy6Uwusjzr/OeR7zRkIPqSUCEWkGmOBKjzx?=
 =?us-ascii?Q?aw6bk5CVFBUv8u8oGb+imTNTYBuHt/oeGNI+jqTR4Hh9vgS0mg0qg6K4mfxb?=
 =?us-ascii?Q?2QxPNwQWDoN9ObfZAr2TvIR3lBamUbyQLvU6y+u1d+1lRtZPzIQtQ2gLxkgK?=
 =?us-ascii?Q?gdzk7AyeJQGrLBr8AW3O6wqQLh1B8GpD9pjjL42/lsd0Xnz4GKAJbgd+qug/?=
 =?us-ascii?Q?LB/yTQcPBep+7tPs5VWGOTtHVaXRSr36Y5hHyBgQ6PsCl8VYVbPIkZ+8Eo53?=
 =?us-ascii?Q?NKzIZvRhAhgjmNW74MUcyNhYRYXJ/+PI6eVVup6+tVq93j4FYdJD8Ab2c95S?=
 =?us-ascii?Q?5XAO8h8OQz9V6IiUUgiO41XTNJNbtCWEvJ6MS2vlHVhHuKP6fhGn/CMdwwDE?=
 =?us-ascii?Q?A0KSbP40WQcrPWEeP+7DcY6klebBcn3NT0yFU3OJ9+S7O7kD5M5yOW+O5By9?=
 =?us-ascii?Q?5tIWnRjknp4KbM3c5s1Z9jO7b7cPY1LrkB65th0ze2vP4T/aIPXLoadOX8v6?=
 =?us-ascii?Q?sK2sjOTZP7EXf/PuOaojLxBKSIrAKDcGi9+qDuw1j35AwCDm+NU+JsHSQ5ev?=
 =?us-ascii?Q?q1CZzGrjEM6n8mIWvMv/HQvBicTE4BZVRt4Du0YBDV3DEOapc9qP5N3Ngods?=
 =?us-ascii?Q?erV1F2EblWQ/BLKcdQ1NYqzIhJvNtEbewpHcdVRz9IGp8tghictQl+XvmIyp?=
 =?us-ascii?Q?sg2HFLUTJ3GS0RKBQdHeLy93T/Sis1EaZl0FxmLrq6hcoaW6IAS+NkI2QlFm?=
 =?us-ascii?Q?EOp8LGtzSOWxBaEvt95C09RoE0pGGsKJXnZjTxHYLA3E2BOp33ioq+9fdiJB?=
 =?us-ascii?Q?/vJT/n5rYW8OAb9n/1gyZm3Z3CsMwBkn16N+maPB9d0TRabR7xM4rIU3WXSI?=
 =?us-ascii?Q?TKwbJ6NFz41iHjBVduT4oj/ahUZTd2DFsZRgMnlA7jPytC2jZLxQDDnvf/PQ?=
 =?us-ascii?Q?tYUztyXhdFBjh0tNvyNYnrJIGkW7fSgR5j0h6W84a/5qfOAo3UWHvMaqGscR?=
 =?us-ascii?Q?1SpNXthO4rOF+9hEjP0VNpp13V3ACx/b5AlYYeGzoSSDdZVOZCPcXrAJcI5A?=
 =?us-ascii?Q?kZ0jzk546YJet4DgWExn2tDVxJqmj7G8qAeUCErB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0680911-6a93-41e8-c9b0-08dc01246ff6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 06:25:18.9734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQNunESz0fnV5VxUuP459pCSfPfzz6w45pwTJy3FlJe/EX1n+D3SkSwcJuQh+NLGWc3Q7lI6nCYwYT6Oqo4MdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8329
X-OriginatorOrg: intel.com

Hi Kees,

On Thu, Nov 30, 2023 at 02:11:54PM -0800, Kees Cook wrote:
> On Thu, Nov 30, 2023 at 12:02:50PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
> > commit: ba38961a069b0d8d03b53218a6c29d737577d448 um: Enable FORTIFY_SOURCE
> > date:   1 year, 3 months ago
> > config: um-randconfig-r034-20230830 (https://download.01.org/0day-ci/archive/20231130/202311301039.7i51bZCz-lkp@intel.com/config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311301039.7i51bZCz-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202311301039.7i51bZCz-lkp@intel.com/
> > 
> > [...]
> >    kernel/kallsyms.c: In function '__sprint_symbol.isra.0':
> > >> include/linux/fortify-string.h:52:29: warning: '__builtin_strcpy' source argument is the same as destination [-Wrestrict]
> >       52 | #define __underlying_strcpy __builtin_strcpy
> >          |                             ^
> >    include/linux/fortify-string.h:567:10: note: in expansion of macro '__underlying_strcpy'
> >      567 |   return __underlying_strcpy(p, q);
> >          |          ^~~~~~~~~~~~~~~~~~~
> 
> The only strcpy() in __sprint_symbol() is:
> 
> 	if (name != buffer)
> 		strcpy(buffer, name);
> 
> Which is explicitly not the same address...
> 
> This appears to be a GCC 9 false positive, maybe?

Sorry for our late reply. We tested this with various versions of gcc,
and this error disappeared when building with GCC 10 and 11, so it is
very likely to be a GCC 9 false positive. We will configure the bot to
use compilers newer than GCC 9 to test um arch.

Thanks,
Yujie

