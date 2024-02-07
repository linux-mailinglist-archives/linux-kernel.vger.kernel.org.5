Return-Path: <linux-kernel+bounces-56736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3072D84CE58
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E322B235A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0C480022;
	Wed,  7 Feb 2024 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntvIklj0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96327FBC9;
	Wed,  7 Feb 2024 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320762; cv=fail; b=XnfG6YHiIGCB6GoHHSWXG0XuAQwRGqAsbETx54ayvc7HBNwOwPLlJhw7zN+VrviYnnv+s0NLrL/lRsak9UTuhdK94x2mcHFtE3Ze6K+ASntL+BlpUFpL43JX6x+z149hW2W7ikhMeXx5a3yRX5ADKac36Pf5F+HQkXHoTsCfEs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320762; c=relaxed/simple;
	bh=IGxP06oXJ/Y5INZl2RRlyWeRMdujbnL4DRD3LNIWcOU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W3AsHNa8DYCl26MAbPHfbX8gbB7luAsNtcmh9kQHZC+Jtb0YpZnaPjFRbd7kTCQba6TPnkcA4b32gEgT8ZFu/3+BYBU67slnuaGvScxMw1fa3y6fxZ4WQXegvrcj937ShEr1PXfzqCW1ibcn8waoLCGtiuIYRrNC/1ThN2xj+lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntvIklj0; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707320761; x=1738856761;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IGxP06oXJ/Y5INZl2RRlyWeRMdujbnL4DRD3LNIWcOU=;
  b=ntvIklj0Ful5/9GfBl6Rd4ohFNXyF41GoHTKyb/srgjqauiCiep8sXDH
   XqCrevTHLdIgyYNGzVxk/SGOQnRXNp0uY9RzyrS+OQIMzYncD3oAV+WP7
   VuLbeBcogUZwNc0VO8WWR64s7qGsjaquSe2gOOWUFfCv/Yx+oavTz04fT
   aFi4ggiEutgGsyvARU+ARhdWNNnUucEDSlztUTobY9PEcueRCeay8xuNw
   ReMLf0cLXe7h2S70q8JSZq36bWnxfdCoRmrVfM63VtTdeqkDaaEgaMwJB
   NHP3DmDkM9IxujMpAu5dUxNpdlhcjOFQPzwPqYw+JEKIfNq3oKfgj/Sm+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11656129"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11656129"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 07:45:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="32168957"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2024 07:45:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 07:45:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 07:45:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 07:45:57 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Feb 2024 07:45:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2fpGeK6nFPt/mFLivjqSMJhw0hNZTmkkbFrD9c4MhZ2m3wpwwDKmqkCGX+bUFlB3656e+XrIyc4CVb6UPAd+wkqxXDI8FYOldxrZ+pjrzSyUk7oOpkqxAE9tqZxoLUwzQWxQyk6hj/11EFyQ/zLefehlaIJD7SlLGuy4Tp00tquVg+5EQEDomk43Lx711BnJyDkdmyprYzjZX7oRxz7YWgu7SdzOipQQLEai021MpfvkV3/fjFNz1n7q/J5hFPZp5N81vdyIZGIx5z8Y8ONmc6qKmW8o+WrFqbnmEBsibBCXH5TR01z7qEHIoCyQDSjZA5DY5aP/GFdknioJJ3/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6ySRS8C+Ig8NcrFHlmVVhEOgU7a+StGOfJmeMhddt0=;
 b=dUwUbXpi4ogqNMjqCijy1cFfwae4UO6f9GJxYdy9qvUu/z1n7CVzNc9jaH8C2mWaFBSzcnHXA9KQMpvaJjeD/RwL1FscVF8RO3ohCJM1ErM661FryLVVSF2cquuRkDcB6gwwDL3dlmjQHsX64Zq/nNO7VkZ4gTy1mRPcOkTWH9/qa4/JgwgXUSACW1rnPm4yjZDEXwKxqRlnsM6xSDQArHhDm7dw5UGVXSOMzq2KxSGiwRRB1XXN6kUbpbKRfCMSFcAF3CJaTUJWh1VkYnIptIZxKDDrcNr+Jb/I5Ndv5HEvL6aqz9fc55/I4AAXFJdVTqkCySrFC4kqDDgnLR3vaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 15:45:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 15:45:54 +0000
Date: Wed, 7 Feb 2024 07:45:50 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, <linux-cxl@vger.kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Ingo
 Molnar" <mingo@kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 2/2 v3] cxl/region: Use cond_guard() in show_targetN()
Message-ID: <65c3a5aed6291_3aceba2947b@iweiny-mobl.notmuch>
References: <20240206121301.7225-3-fabio.maria.de.francesco@linux.intel.com>
 <202402070919.0zuYCxMS-lkp@intel.com>
 <4546212.LvFx2qVVIh@fdefranc-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4546212.LvFx2qVVIh@fdefranc-mobl3>
X-ClientProxiedBy: BY5PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::36) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: ede89e2e-9121-4021-3243-08dc27f3de89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tw/kRFuBW4rfuKIAyhv4x2d2iLrsvw7/7P3KAxkVDlGfha/s9Y84XDntBrEvpYy9mRKQTX/KXrz8czEuqgwa+DZ0jLpf5+NeASSmQADIeygBlBjJb11c6friJztbN5kbBlxJtVYTdGPtcyaXC6313K1QNu05r/tV+NJDyCPGKzut7EhP83QrRhxvowdxt2pKykNX+OvwQtf8h37O907p8ezyMoA+1SSmOPZ2QL4RroKd6m2eQFWXySXxnL5x5GhaXRmV+C39fynEAvhvMbGZkjQq/f6Rjjt5nxHaVNASaeW0IHWt0prWA7ogRLp5hA32ivj9VFmPqNwirfMOVUbnnKZGI4t1r2lMFn02Z0Xrp2eWwhrQjsgEtyB41wJ+w8JUdV3y7Cx8MBKZp4V8Mplue/o9ppZwh2zVlHKLVZvXfxKEySPa4yosa8rCDl7vCBJ+AkqQEbBpY5q5auE58FH9SaTUdjhxs/eDzrWlwbpBtnkGMwUjrsHtrB7p2DJY2rvOwBKrZyutjPDoukHaA64/S7VzPANeQsXhxWmubB3aG3GIJjS5OL17tdleKo0sD+iQoMcsQTKUwPiEYeB+PEAklw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(230273577357003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(44832011)(2906002)(5660300002)(41300700001)(6512007)(86362001)(83380400001)(9686003)(6636002)(6666004)(54906003)(110136005)(8936002)(966005)(316002)(478600001)(6486002)(38100700002)(66946007)(82960400001)(8676002)(6506007)(26005)(4326008)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DCgAaCSAXW4cljpsuiQVtTCKGLHZbNlfcEJtc6/oESDo9PGXsRx0lQzUb42T?=
 =?us-ascii?Q?dZvGhfjtZmnnJvaq7qxnqz13ERwBvE5asWYmW3NxpOHSji6Udv1RuLJ3bUKA?=
 =?us-ascii?Q?YtpQb4dE6khv6C/RbmGjE+ye5N0lTxx+PbkUro11fnSjKVwQyUCs9q2DREnf?=
 =?us-ascii?Q?A9MaISWZ3JE6tXsIsTCCdSoHwyb5CnASRQptV0ul7HtamYMzIIuqzgnkjPAN?=
 =?us-ascii?Q?cud6HWSmk3poQbMysqbX/z+PNd79Zc+teCguaL9cphBU/GjHL16ZvCFADZ/P?=
 =?us-ascii?Q?d3V4KEIIu10A/+z9Av/7czuoshKxNarBRPYbc7YrYRUz0qUVLGWPbg2txbSG?=
 =?us-ascii?Q?wrQ5wMXjt76SWBs0GiBFwvAwiu6XRqQjY0EeEL/qKinCjRKyFuF6qP2NjHuF?=
 =?us-ascii?Q?u47/qhH5zwfCREtfxqZlChGINCeddAjdoptrBIl18tMMRr8PkgKuird95HMN?=
 =?us-ascii?Q?BY2oBnzwCvi1g7SzWzMLgP+PpO8/1ktc+Ppo/BDCgw1LFgzA21craocefvpq?=
 =?us-ascii?Q?ubyb5VFUYs30nkGsp2wK1ZDduPr6fQEf/gaeAivTJzrnS4PLgsgXno3/y70w?=
 =?us-ascii?Q?hRjk38EKTfKRklqaipYPkaTwt2hRG9poQZ7ZDdDwa4w0jNe4/P5MixVZsOnh?=
 =?us-ascii?Q?qFiy90yeHx3igurYARE0VjJy6dXWJpQlDs+r8KhWfpHx+//ABRy0SlgkuFzM?=
 =?us-ascii?Q?qwfBaeVcOmJgnItzNtY+ju/uutVFqAdBFUlY8FnERPKzlN+HMPsUWylR36JW?=
 =?us-ascii?Q?Wvo7F1Uo/oNrX5m0SI4gRcGGpccXtEWxIfLCnaRkt1Jv0fNujC7U4vx42SCM?=
 =?us-ascii?Q?wbf0MLQIKdwrwKT8Z+WCCzZskDTPdEL2qAnfUmIQmGnF/GoP9M80Vi8aEKXw?=
 =?us-ascii?Q?D/kZwPuXB0Zbx6rJ3BSU7gISbc6cNMgo4ZNKcL0UDQrzNZ20NDsESoFuBWbF?=
 =?us-ascii?Q?ohUOBn81U+MkA0Z494DKGwU2jhovQxPZuZdKDLaQZpT3ZOpWKKJFgcCUeOLF?=
 =?us-ascii?Q?B28NLiFSU8lfyUwDkefoD2SuiZmeJRBwxq+axLM/cCHFvl1zLoCyC9QDEK97?=
 =?us-ascii?Q?4/gF8C6q3LlFRoZcsnci50ODXTHzCQY2bm9SD3LSijcFGyPOL6Y1Hj+29rDC?=
 =?us-ascii?Q?wNSMmbxCLD8OM2cNyqv9nRX+yYulV54EqCDieiEsX5e6gvngM0OsUvj3bZpd?=
 =?us-ascii?Q?n9lo9j8gOdgQ0vs1Ny7cScpCgQyWTeyjrQaex4QlyszOkrynN+s80UdxpqPq?=
 =?us-ascii?Q?Dpwv6afUnfWX/aKWcq2vpYDrSOMqHbPnd3f1kw0IRicqZ132Ks0O27dZjY44?=
 =?us-ascii?Q?MMeyrRbzJXSvx458/296SE8maVEh09l99JqxPZlRCjvlIuliWSi69g5Bxw9O?=
 =?us-ascii?Q?cTkVR63CzQgzpZ4aXlaqRlj8OeFaaVeT0yZbmcHvgByAUFSrPFA5PlaFa4vy?=
 =?us-ascii?Q?CKayBOaUBTzgpgh+c8/YEhobgHtWoBTi3XnkwNwGE+nKUneKsoMhLp6q1ui4?=
 =?us-ascii?Q?lM5MM3yX/qx5/YUoG6hjKSO64+62Gf5cvgkCb2L0he59HfsBR11MaW/9oyQC?=
 =?us-ascii?Q?E/vfzv4oTEFKe6xSsMwgkJE8P0dsyYin6xWXffQE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ede89e2e-9121-4021-3243-08dc27f3de89
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 15:45:54.5946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiUI/w9xvbzBK2huPvTBo6VBc3gkuh1cDHsxVY1R7iJcvZ9GOsshIqC73fQ6ZDO+kGkcMRQApSIvs3qWjLBR9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7573
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> On Wednesday, 7 February 2024 02:54:34 CET kernel test robot wrote:
> > Hi Fabio,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v6.8-rc3 next-20240206]
> > [cannot apply to cxl/next cxl/pending]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:   
> > https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/cleanup
> > -Add-cond_guard-to-conditional-guards/20240206-203110 base:   linus/master
> > patch link:   
> > https://lore.kernel.org/r/20240206121301.7225-3-fabio.maria.de.francesco%40
> > linux.intel.com patch subject: [PATCH 2/2 v3] cxl/region: Use cond_guard()
> > in show_targetN() config: s390-allyesconfig
> > (https://download.01.org/0day-ci/archive/20240207/202402070919.0zuYCxMS-lkp
> > @intel.com/config) compiler: s390-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build):
> > (https://download.01.org/0day-ci/archive/20240207/202402070919.0zuYCxMS-lkp
> > @intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version
> > of the same patch/commit), kindly add following tags
> > 
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes:
> > | https://lore.kernel.org/oe-kbuild-all/202402070919.0zuYCxMS-lkp@intel.com
> > | /
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/cxl/core/region.c: In function 'show_targetN':
> > >> drivers/cxl/core/region.c:670:70: warning: suggest braces around empty
> > >> body in an 'else' statement [-Wempty-body]
> >      670 |         cond_guard(rwsem_read_intr, return -EINTR,
> > &cxl_region_rwsem);
> >          |                                                                      
> ^
> 
> I think that this warning deserves attention and braces should be added around 
> the 'else' empty body. I'm going to send v4:
> 
> #define cond_guard(_name, _ret, args...) \
>         CLASS(_name, scope)(args); \
>         if (!__guard_ptr(_name)(&scope)) _ret; \
>         else { }
>

I think this is a good addition.  If the user forgets ';' at the end of
the cond_guard() we could have a hidden side effect similar to what Dan
was concerned about...  This guarantees that won't happen.

Score one for the bots!
Ira

