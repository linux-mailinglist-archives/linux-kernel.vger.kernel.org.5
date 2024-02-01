Return-Path: <linux-kernel+bounces-47521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08171844EE0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F730B26825
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F04EAE8;
	Thu,  1 Feb 2024 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKankLXY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1750569F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706752484; cv=fail; b=Oe1d+wHB1auWB9zPZhNudkDY53jIBHZBUSKOlZCfb0NV3jWpcdNXFuN2lJntlsF9boHJ1mF9b3le+hPzui+zwrIAp/wy6de1xZof5GToQWSVd4f4zNQS/VNSmQt1LK+Ho//jrQbC0IyXIN5fCROP31HTUncHj9BuFuL8pn6NycM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706752484; c=relaxed/simple;
	bh=m/bObJo0MWJoqrd/8+mkst7xmQus4fcc5n0kuJS95U8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ov3VO8QqW4zzT7VoVSBcCFkx6LIYvT93f1LHOOyrmTHVK7DgFZzOxUE3fyS4IX02hM8uVg1ngIWNxaea9R80JEilVl5QXPrYzKLcIbNa3jTFdrJYo26g2uAb/dOcZP5Ewcmcfg7IBdPoMrhUXuorf2itGUj8+GpfaGA2uUTspMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YKankLXY; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706752482; x=1738288482;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m/bObJo0MWJoqrd/8+mkst7xmQus4fcc5n0kuJS95U8=;
  b=YKankLXYMOWXUsSBvtRVOPx78kQdhBw6uzZB3RlRy+bQk5Ja+ijP9kyb
   z+5dmgY8eVIPOhqm7Fni3zvfsEO6EhmCTXTsbxe0xF2StCEu3BtI9kGN0
   APfItlykb7K02/2WeG4MgjO2ZPz4rJmbI73RodljmCbBSGz3OOjG+Y6zq
   vA7PelB5RqAoEDs+jEW7l7pPdIULOPtDMpqtYeRx4cDZSKT3oyQ3vqubD
   meCDsa8+VwtRac0oQt7M5K5k57y4x0YkOVbtA/trdgJAI887bPxbTggQJ
   17AaysprVuZL6jnq+5smqdT7dsk92Y2Bnxfv4eTjKLxo3j9BAHBTuqOGd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3646944"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="3646944"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:54:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4240543"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 17:54:41 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 17:54:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 17:54:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 17:54:40 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 17:54:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSJ824Snn9hUS2BCHBY0NqCNW4HzZ6NdSljeAtq0oqpZS3isQwrmC+VcLUhcneBPkTVfvPQX//6X25kqbTqCjpXQt80INuTQxbr/YIPgse5W4BabqssUzNjfeBOsCwNIJnRMymXKS9sl4MMXwHQR96oaxRqYMP3MKHIzau1QCXqVRj2TQbk+NWq1kzLwMobAnF7XU+8w2LFW5oDRDbKZq9LwT8XTJ/dacZjSnrtnd/Jej7dMHwggZgB+xvVFdPrZqCg8057h2mx7DBnHIbiMbDcEpX25XPebkC2VORSQkCJpNbLEDyDIHusRKGqX8ftjaSs1WpADWyCRBAazAICSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RYYG7Zaga/UkFXKivf0WPZmfSaCpESift6AWb0tvJ0=;
 b=NJkr/vJQGY3xV6UD0lGP4ZAiSZw68mKAcvHJUHoYejTS/TuWy7FCuhzP65fhheveimibqHKCBT4wugfCQ8Qa/S0RtlOazE6PzMr1uh2+kMdPcxlNjohyZndkVklf5Mx4vrW5rVy8OHYpFiWSW9neLZpiuNvrXH2798MlYS1x+7qGHJHA9HeXVgCDv51UC/Fnr7LjnP3gtEra+9efQdviKSlPqPY+RSKv71fT4xwlQBcP7c6xjpE1PPS5ofLZ7ydw+eVIQHHHCz7Tm6eoWHWdvMQ6mrRX2UzXXtLrHwou37Xr1E9GNUkfoHnMkl88jHvilaHfmljJNV4uExsknTKxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 01:54:38 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 01:54:38 +0000
Date: Thu, 1 Feb 2024 09:54:29 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Honglei Wang <wanghonglei@didichuxing.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, Tiwei Bie <tiwei.btw@antgroup.com>, Abel Wu
	<wuyun.abel@bytedance.com>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [sched/eevdf] 2227a957e1:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <Zbr51SNYUpH2J+3z@xsang-OptiPlex-9020>
References: <ZbkDIlIR7qzPt7Vk@xsang-OptiPlex-9020>
 <cb384fac-0de0-4c11-8690-ec12c46da34c@didichuxing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cb384fac-0de0-4c11-8690-ec12c46da34c@didichuxing.com>
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9f5866-94e8-42ef-8830-08dc22c8bfc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPyJHsVb97cMVcNwakfdepAhxX6Tg2fpmlSy5tmI6yQzowlX47EillLnFjExrgvGucoQ0DvAdhrOf2lscCA/M8hu3AREW/faSWMxb4lRn2rLZaljcqoeRnW00Pslx2dLbZ96WF3wz9BjhnThdCzQDYmsPaYMcRReQWZeCeKjXR/dQYhX7ZncPNs5Go12BkVdS+LsFtamBwZYm6nFHfnvupoj+3UBulVh3vbu5MCC1r7E4xXSYL/dAeM27viNCvYWBK1teXMUOwKUIpFhcfFC99YTitXeD/fXN/SrSG090l7fo1/E1GVKA/zY1Ayp124StuKwZQKrSDkxwWvXn5P2Vwsj/E9cJdOZR/eLCOD+CJCw89yC1Hdsj9DU9tMbxyESYczP++XkS7uNKLpNti4JUs84cvr/i0CjNM/Cg1kHMeSfy6YD1yQwhXWhpVhg5JL4wrA9r1ePoEurxNDBTSxBMGW3PUOPSo+oPOkSwPar/HSHVbM5bMl0iFjpk0fGg18z80oPRaZ0ZqyBu4+7G69k9XkBuwxxakJlAdnXZyDpqnrRcgYfEmnLhYoaSYDhcKesZvF0uoWwwoKUir0NIwahl5O3jRnTcWuFGwqt7cQb5pfea2EdxBAOQSqC8P+drgCBuXTVDf7T3lazKlzPa1VM1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(2906002)(44832011)(82960400001)(6486002)(38100700002)(86362001)(966005)(478600001)(26005)(83380400001)(6512007)(6506007)(33716001)(9686003)(41300700001)(53546011)(6666004)(316002)(8936002)(8676002)(4326008)(6916009)(66946007)(54906003)(66476007)(66556008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3kw+Qr3tVIo7shpE6fc2v+UtCHSv0EqzbseQ5VpLNTyLTJe7Kloat5e/FLFj?=
 =?us-ascii?Q?Osxb1QE/VrN3WCORVWfvv6sqwPgUsYsQTcTAarF6O5lKnKzM7yRv3qGSBjC0?=
 =?us-ascii?Q?MP+9SWZiC7o8L7keyhs9oFuQ4cmzVJ8u0S2yv2i20O+t93P/G3JxUSc3+SQ8?=
 =?us-ascii?Q?WwH1xBuwS7IEt2Evjcj+SauHFj3T6xJOveTDQ7LfJ+YvjjTSegeW0utb26lP?=
 =?us-ascii?Q?ZAV9aouiJwbT/+GWRUDHstmnhLmSsEiEZEu4MvrOs21GCTBvRYdBqJKnr77O?=
 =?us-ascii?Q?dXKBfapJk9CaB+ovDI5qC3ThcOYAnv/ESJRiGQn8wV8xSJdfBvpghi3kHGS1?=
 =?us-ascii?Q?WdGI3u4Z7dX4CfbyjPoX1rPSQ7uoR03upmWZosKuNe4gwBQ8RFDfg/MyzRTn?=
 =?us-ascii?Q?NtHaOl033ONGuS8y6txXOhWde/w9wkVLNSlKjzNb88ezdZvlaIyyb4RI/8Pa?=
 =?us-ascii?Q?PNUDSxdroX/hp1bXsld4tyfHZS1jZEjAwNbL6dgZTlYrSfruV+ylztc9xauH?=
 =?us-ascii?Q?VsVNE7+JxelsWXdhxDdWg/g/zlxMDVe0rvD66utD6A1hd4uqpW5oxdMNFQNn?=
 =?us-ascii?Q?ZfMy0qvAVpzv0q5Kbsdv4KQDOO09ziOFCYeJbW7hX+ovp/3vM9kWDLnQ8qaG?=
 =?us-ascii?Q?dUCcc9broNhyBonKbWy6KwJ1LLB40EMfwRgUZ7mdZrDBknawpREkgIvjJYva?=
 =?us-ascii?Q?lZSFpbCDTQ8WmiYhP4jY4JFEvHEmyTfCFzn/VzPyb4+jwJ84PTqKHJzOZIOV?=
 =?us-ascii?Q?bAOhvQmyPOApcP5DVeemo7EYAVxLDaN1U2fCC/TBTq4PgXe3IOqD0g5pUy5O?=
 =?us-ascii?Q?AnEJ+YzVe9VrYIYUlDZ37yHLFxKF3NX8zAVqQL3mSH9fDuOFL/Ir2aagAkcb?=
 =?us-ascii?Q?UWO5mHwDFqZl+kvldKFhgZRyNjz+jtR4g3fY5e+ZpSLH7Jaz2M+QWnGMiJWo?=
 =?us-ascii?Q?UUnzWRNZt2lM9OJg4voCwg9Q1g3UXYpwx0iPzf0iqGLPIV5p7D7e8uoI/+hL?=
 =?us-ascii?Q?XqEf/+1gHI6cy181TUK9BCnYNoy4GC1htqjQ1frmPtJ5MRoszGvoeshRqqJs?=
 =?us-ascii?Q?J19eRL/lFl+VqehWvubr1e8FKiUj3891seVmofy9qTYzhnBF5UYoza3wnNM1?=
 =?us-ascii?Q?odbSAgkykvbi5CnuC9qPMQ23ZnDbyAQDaesgZHPiYm0tn0mCaYDzUxRWy2KA?=
 =?us-ascii?Q?MGu197Y2dpD4bdvOdddfZTSenW+mGhr3QTa/xsG6ml8CXx7Hj5uXyh860PfX?=
 =?us-ascii?Q?Rsj+s8K+jmc3Z6kFl+Dt0kWaipiuFaoIumNjTkPD+J76+fb0YgQZwwAAU3X0?=
 =?us-ascii?Q?tcDCUyVRM5wez0sdkdet/TM/UCNYgw245BwQe677/Vr5ZYsnpn0e5yusm6Gx?=
 =?us-ascii?Q?CleLaSDYm0v9esnI1glH6gibWNoUDjJnvV1TOE1NUOSe1AHFEDQVn0xLy2pU?=
 =?us-ascii?Q?RBrYTqXTYKw76g3Ffb41DvtEEcvESsbYg8HNFJmCubSnjO9f01moX3/COfrp?=
 =?us-ascii?Q?jYQNdPkVUKMNuj4DqMuOJ2ei07xty/JInm8HbJPzoteK5qvrgpkL+oOlFyyY?=
 =?us-ascii?Q?6JI5yejjKvgv1FJ32202+GkynGyVOjLkPu901EcNJcb3o1k3VihvbLr6f5Ld?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9f5866-94e8-42ef-8830-08dc22c8bfc6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 01:54:38.6713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mO13AQfznf4xlioJVa87MHgSkY1JJuloQuVlT5LwboYxZsE8u7c+vdvtpr6vqK++TJw9uUxIWRZdLHDmiE93Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6116
X-OriginatorOrg: intel.com

hi, Honglei,

On Thu, Feb 01, 2024 at 09:29:30AM +0800, Honglei Wang wrote:
> 
> 
> On 2024/1/30 22:09, Oliver Sang wrote:
> > hi, Abel,
> > 
> > On Tue, Jan 30, 2024 at 06:13:32PM +0800, Abel Wu wrote:
> > > On 1/30/24 3:24 PM, kernel test robot Wrote:
> > > > 
> > > > 
> > > > Hello,
> > > > 
> > > > (besides a previous performance report),
> > > > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> > > > 
> > > > commit: 2227a957e1d5b1941be4e4207879ec74f4bb37f8 ("sched/eevdf: Sort the rbtree by virtual deadline")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > 
> > > > [test failed on linus/master 3a5879d495b226d0404098e3564462d5f1daa33b]
> > > > [test failed on linux-next/master 01af33cc9894b4489fb68fa35c40e9fe85df63dc]
> > > > 
> > > > in testcase: trinity
> > > > version: trinity-i386-abe9de86-1_20230429
> 
> Hi Oliver,
> 
> I'm a bit curious, did the problem happen on i386 only? Did you hit it on
> x86_64 or other platform with the same trinity testcases?

we did not observe same issue on x86_64 so far.

we can run performance tests with this commit on x86_64 (compiled with gcc-12).
FYI, we sent out a performance report before this crash one.

https://lore.kernel.org/all/202401292151.829b01b0-oliver.sang@intel.com/

> 
> Thanks,
> Honglei

