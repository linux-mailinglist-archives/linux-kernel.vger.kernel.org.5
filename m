Return-Path: <linux-kernel+bounces-104327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901C987CC35
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3D52817E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC601B295;
	Fri, 15 Mar 2024 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNz7N1yZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3411C1BC22
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501627; cv=fail; b=XNsrcATiHv6oS/lwBNnZ/KB+MEnwUCbnfukjLYEzzxw+OEl49DkaYF58jITnL36nFAePY3eICN7jz3ac5n7f4j67YxwzF7nmLU8yr9f6z4Gvu9S6qjruAFvcWIQWiq9ytHnUZcf+Plg8s5uLzKeBbOYniAonA40oHt3NNIuBbQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501627; c=relaxed/simple;
	bh=JfbeSWqxjwLTuPQlOfcCFPHDnycf50mSPdoADhC3uxY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gy49bx1hSgPGip6FHk5EzWB5K8vcqAu9fAvtbApd/mp3LiszoVU++ciWTDalVpANm4WhMf7JtqyTYmrmWy0iO1jndaxF9G8lU3aUTnjMh8pwY5k6lvgIIc4ah98w4Obx6dvVuqbZSoCUG8Wo/ge7TjRhC+G9vqdUUOg9BlGUxvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNz7N1yZ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710501624; x=1742037624;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=JfbeSWqxjwLTuPQlOfcCFPHDnycf50mSPdoADhC3uxY=;
  b=LNz7N1yZZnDZ4O+UxRodSPezn/a2QY/4ey4jTbhEhhX8FpC2gcYrD1iV
   FeTUTvOvlo4sheq5dVvjgtc+zfnuYLSP71jRgHP4nrkftqV/Ca+6emJGt
   Vjm34xpVx07ROJtAkwU9kdvpY6lkYnrhklv/tlL+HxnohyUcH9e1nFj/n
   fDFhFhuXsPiPKatjyNgi7vvJwQZ/V/eOyuEKr063hxiNwl6DfGZ2PJgr5
   GUwkaH6FUNXLrYPVFEUeNUN5RqgzJa/TSaIDnDiWxwZ/pXkrkmNMD2nzG
   8VD5bc6RSutC2UPxcMwnESsRaFKBqLtE0iPn26+ErAdau6iKI+oZPwTuK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5303439"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5303439"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 04:18:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="17235218"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 04:18:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 04:18:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 04:18:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 04:18:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ochgQK29eWz9nUISmVL1FGPPNZJlUqoEyUKc1o/NjmvlZXcFQYGQGdAmJcidxy+tcjrTOquSGSu1+ZYOgflFvveRA3oed9gAGrExSWPoepgLSgWG80asCXCY4SYt7oAIPKVZ4mfbooeX0gzrm/PE20p1RwPAQg+6rdMTDPq7pefoUlIWYbc9CmY1LOgnhGSkJ/xYWT9ynEcWmW/zL5EYEArN9IpKuA5+rHI2GqfE3rIaFjk624t/cHdm9iQt7C9lSVU76iErahicwpEE7KoLNzj7Pfb3MNbnkgV8YwDDWBRV0uvYAvNV7GNS9ObEooJ0Go+V5zlq7ec6tr5MbOAELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDGVUupBs/UBSXAoRfFj0bGbuddEgn09a60EbitHcxY=;
 b=G/9RvEgdr9J3I/T3pqXjxBQrI8wZ2vaE1g0yTkG47Ofwgzc/sC/t8yda5i6BayhPbQqf4lBHtx173F96toHVVYeWSa9Ymc0yal9hrsfMRMnJQXByLJ9quzwSpZSoIYhlEBNVftb7akk/tnlsTdAnpVZy5AnKXQGpFf0ottQw7QyKKMnQnR1YvyoyiwJC4tXUCeTKr472SOA6IolLLG7lchllAFSUkRgcYm8t3FTEG3yYOOncXE41mFEVyMG5gl8UV1mMuq+wzsXaVOaiY5cFzGH9qlv1/ADt8o4lCsCbIxKBfJVM+jb1T86zw/GUCLbNxHl8OVugy91F+8cUi62ynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Fri, 15 Mar
 2024 11:18:22 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%6]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 11:18:22 +0000
Date: Fri, 15 Mar 2024 19:11:34 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: kernel test robot <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Mel Gorman
	<mgorman@suse.de>, Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>
Subject: Re: [linus:master] [mm]  99fbb6bfc1:  will-it-scale.per_process_ops
 -4.7% regression
Message-ID: <ZfQs5qkG5+yy1O3k@yujie-X299>
References: <202403151058.7048f6a8-oliver.sang@intel.com>
 <ZfPBOyONqBnhUa3R@casper.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfPBOyONqBnhUa3R@casper.infradead.org>
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW3PR11MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: 72798d55-8819-48c2-dda0-08dc44e1a018
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /45XqWZdXOmjb81ExF0EO8nUe+XXmJnG8aS3iiWeLeqeMam7ITNH7qJO2scB7ADDTftAAF8uMFkFKe8mGtA+yomFQEqLqwdGDWFAlJhLzEGnvON8FVDoe1bS0Mvk6/yGUqHdIBcGzEkYw9JVPJyy/Mxf/z25UfU/6N0bCCN2u6ucaVk/EKt9UGaUdJUimE8BdfC/lf2C5A4aDku4mAmAyHgrAU2lj5G2CEr4K+iWNFe7PZ9hp7Kx7okaTtEJ23RscJyv8/o4cfZM7Fryhjj9w/6QmzsbdwT+GYDAIuNuT6Ewn55vtCBL139TeCHPWwBtX4qnxRYsNUfJOoqjCwTnfufeMbvzeSmwhlsEMDVtgyVrWSAwGPB01WhPhXf+NBZdu8QbMpF+rVsNqaf+ppJ8e80LffteL2DwR2mXS3ev4DBmb3dSB/mGHIyoSrprcjU5XMZLRp9VICv7Wj8VphGE8fFC/A5UpdugHFgbfPmMwT/SfRoOYxCku+1jdFuip+6R/3x72CojILKQmaA1YMMm3b8e/rU9fZLcHGs7/8hhX//kIvZTVjEgnnZBgBBk683wXDLGMY7TjpMMSdhSjEhbhSQxni/SKXwMibzsAn01+XPGLbyFfnv83y9ymzKZdGOORj83pgfQOaBbevpb+dVfFFDWKHnOYpDfoK4We7EpzxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Pa2dVV4Oj6OUtQnnSQBwwhBJxB/xjq/WBfIj/RxImPm6kQVO/KCCUJjfO6?=
 =?iso-8859-1?Q?cyUOKrlpuX4Ix2edpVGm9J/Ao+nBEIKRvrU34d/cz3MePUdcifiatiqC4o?=
 =?iso-8859-1?Q?ycN5a4BRl4fW0LGo9i8KV0WDY8zZT+KvGDVR4fX0UeIPXy9aEvif0/irbz?=
 =?iso-8859-1?Q?181Ck23DwSPHpUFaGGBQgoV70NWmOKsFgJIDuBJEw/g1fLTp5yo6eQ4cKW?=
 =?iso-8859-1?Q?FCq5i5jwemmpo55PnpH4Aesp+j1wSU7mhfDGRn/+V99zDrjRUUHWiUCnx8?=
 =?iso-8859-1?Q?KpIzKeCZV6wmdDlxWGNah67dTbuEKeBtl9jbutVjqU2O0GvOq8MbW1ao23?=
 =?iso-8859-1?Q?AOIR6BgwSJzgPDJFQPJaSWG9YS0sKC/hWVg6Wny8YRAicwTig/kiJTUAM/?=
 =?iso-8859-1?Q?jHsqpqr9JwEfzS3ahBP/SuVOG90Tl/mYiAKxbGYA9BdhSrQKO8BBLdiGvz?=
 =?iso-8859-1?Q?1emxAnloVPZ25l1XGO7734V0UQJDmFXhCvSiFpdPYCwnboEiDyqzu7LGgj?=
 =?iso-8859-1?Q?OJ8JMf2rqc/nA5TIW+2NnmpFEqAnzAHq0MpGuZRDFlcxWTEiFEPH5WwJ/s?=
 =?iso-8859-1?Q?uY3CKvLCaaq1aUh/28W0YrSK7rlOhKEKNYhPxkqXdCwbQEVi/wGJf7oZWB?=
 =?iso-8859-1?Q?rrS2uXbfixogfOL/9JEb9ev+cHmON6NVwRq9Te2BeE+XfEy4OnU2YMuuIH?=
 =?iso-8859-1?Q?b4E8MQswk45QHKfwqyvozaGflAI6X+GdXvKoKhTWFLCa6eJiZ0Le/OA29r?=
 =?iso-8859-1?Q?l48lpTSbcS4rCtM9HxEBdU9XD6Wq+IYAFGykuDuK2FOT/CoQuj8d0J6O9F?=
 =?iso-8859-1?Q?5VpplJiDDi7toS1WjFPjpOrzhIP/O4KuXiWAJ9XVEgqurkv0sfV4vZXdXy?=
 =?iso-8859-1?Q?0RtJjeaGd9C4iigAVpX6Q+s+hKDkGI4djp7EqTE8aj/q1Gac46sbKeHi9S?=
 =?iso-8859-1?Q?SFkjA0KG4M+oIKV8J8vu2lYSVLIygMGNpyulQjB2vCX3BjPZPRGSnQrhYX?=
 =?iso-8859-1?Q?6X/6AaxRmuNQVDkBgQCOJcpPCnBEgmncrQ0DQhYkSMdP9M+qwXLnijD3/C?=
 =?iso-8859-1?Q?etHIUfVjoC4+NsBYOaS8u6vrwOtS2IGbLqKUdSOp0e5XeyNB/L04oeANVp?=
 =?iso-8859-1?Q?jPzxsk8B03O8XoR6RQ4OhzZ5hT6tQqdYi1Uzo9l2HHhSTeT2uMjIqpXrNF?=
 =?iso-8859-1?Q?O6Jek/90ZneU0o7pXm0UiHGLJUbBl277w9XRqRp81xWZGVGdBHAVB99PrU?=
 =?iso-8859-1?Q?v9z5gRTj3AL0HPy0YH3TElPvF8VuwNR5CeHmYfxgXDW2Y2sdeAXbAp6UBx?=
 =?iso-8859-1?Q?fARHLM9eTp33nuCKcIOzkXode33/weUjELnsBd15vupT1+EvHU9OMrxG5A?=
 =?iso-8859-1?Q?JACd0wu1goKAUYA42YGtX/eGKsNOC3DvPvPB+MjvtgojrKPWIetAiWlzFZ?=
 =?iso-8859-1?Q?ZtPLbsbbwV2gXKKHa4L7/TpNEK4L/MKJzEcjCsRuxxigVlu699SsP8CdlF?=
 =?iso-8859-1?Q?nkERc6Tqxb3UweEnF8zUHjeRvsRJIum+GW4g9kHX97NaA7SDYe8hx+N2L6?=
 =?iso-8859-1?Q?pm9RwdyRZfoPiFgIiXdqR4vqEnSbC19Z79ksiuELkeCWFg/XxFA6aJosJW?=
 =?iso-8859-1?Q?II0XGDMTBHX74LvMEBjw1SgZ6P2Kh4AhRg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72798d55-8819-48c2-dda0-08dc44e1a018
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 11:18:22.7840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVd1cl9MzdUvCf+naGPjIdAnOwsVMMk3iZc74kbr12QVZZu9YmmM65aaxdyLobE9vAv7Ez0dQ1Vq2xe1KyU9bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4556
X-OriginatorOrg: intel.com

Hi Matthew,

On Fri, Mar 15, 2024 at 03:32:11AM +0000, Matthew Wilcox wrote:
> On Fri, Mar 15, 2024 at 11:07:58AM +0800, kernel test robot wrote:
> > kernel test robot noticed a -4.7% regression of will-it-scale.per_process_ops on:
> > 
> > commit: 99fbb6bfc16f202adc411ad5d353db214750d121 ("mm: make folios_put() the basis of release_pages()")
> 
> I was kind of hoping you'd report this before it hit Linus' tree ...
> I did post it last August without any response from the bot, and it's
> been in Andrew's tree for a couple of weeks.  Is there a better way
> to draw the attention of the performance bots?

Sorry for the late report. We noticed that the following repos are
already in the bot's watchlist:

git://git.infradead.org/users/willy/linux
git://git.infradead.org/users/willy/pagecache
git://git.infradead.org/users/willy/xarray

To have the bot test a patch set earlier, it is recommended to base
the patch set on the latest mainline, and push it to a branch of the
repo, then it should trigger the bot automatically. The bot will do
build test first, followed by performance test later.

> > testcase: will-it-scale
> > test machine: 104 threads 2 sockets (Skylake) with 192G memory
> > parameters:
> > 
> > 	nr_task: 100%
> > 	mode: process
> > 	test: page_fault2
> 
> OK, this makes sense.  mmap(128MB, MAP_PRIVATE), write to all the pages,
> then unmap them.  That's going to throw 32k pages at the page freeing
> path.
> 
> Can you add this patch and rerun the test?

We applied the patch and retested. The regression is gone and we see
a +12.5% performance improvement compared to the original score before
commit 99fbb6bfc1. Please kindly check the detailed metrics below:

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/cpufreq_governor:
  lkp-skl-fpga01/will-it-scale/debian-12-x86_64-20240206.cgz/x86_64-rhel-8.3/gcc-12/100%/process/page_fault2/performance

commit:
  5dad604809c5 ("mm/khugepaged: keep mm in mm_slot without MMF_DISABLE_THP check")
  99fbb6bfc16f ("mm: make folios_put() the basis of release_pages()")
  900a4f6f4408 ("increase PAGEVEC_SIZE from 15 to 31")

5dad604809c5acc5 99fbb6bfc16f202adc411ad5d35 900a4f6f4408a94c8f3e594f367
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
   8839851            -4.7%    8423518           +12.5%    9949112        will-it-scale.104.processes
     84998            -4.7%      80994           +12.5%      95664        will-it-scale.per_process_ops
   8839851            -4.7%    8423518           +12.5%    9949112        will-it-scale.workload
      0.02 ± 10%      -0.0        0.02 ±  7%      -0.0        0.02 ±  5%  mpstat.cpu.all.soft%
      6.49            -0.4        6.14            +1.0        7.52        mpstat.cpu.all.usr%
     26593 ±  3%     -15.2%      22556 ±  4%      -1.2%      26283 ±  4%  perf-c2c.DRAM.local
    225.67 ±  5%     +59.8%     360.67 ±  3%     +21.3%     273.83 ±  3%  perf-c2c.DRAM.remote
      3864           +27.3%       4917           -25.1%       2894 ±  3%  perf-c2c.HITM.local
 1.345e+09            -4.8%   1.28e+09           +12.3%   1.51e+09        numa-numastat.node0.local_node
  1.35e+09            -4.8%  1.285e+09           +12.3%  1.516e+09        numa-numastat.node0.numa_hit
 1.338e+09            -4.7%  1.275e+09           +13.1%  1.514e+09        numa-numastat.node1.local_node
 1.344e+09            -4.7%   1.28e+09           +13.3%  1.522e+09        numa-numastat.node1.numa_hit
    250955 ±  4%     -11.8%     221434 ±  6%      -8.1%     230707 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    250955 ±  4%     -11.8%     221433 ±  6%      -8.1%     230707 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1408 ±  5%     -20.0%       1126 ±  4%     -18.8%       1144 ±  4%  sched_debug.cpu.nr_switches.min
     20.67 ± 13%     +18.8%      24.56 ± 19%     +22.8%      25.39 ± 11%  sched_debug.cpu.nr_uninterruptible.max
      5.52 ± 10%      +6.4%       5.87 ± 10%     +19.7%       6.60 ±  6%  sched_debug.cpu.nr_uninterruptible.stddev
   5384069 ±  4%      +6.4%    5728085 ± 14%      +9.9%    5915133 ±  3%  numa-meminfo.node0.AnonPages.max
     34807 ± 14%     -37.6%      21736 ± 30%     -14.5%      29760 ± 43%  numa-meminfo.node0.Mapped
  16743687 ±  6%      -8.4%   15343456 ±  5%      +1.6%   17018113 ±  6%  numa-meminfo.node0.MemUsed
     21509 ± 24%     +65.6%      35626 ± 18%     +34.2%      28856 ± 41%  numa-meminfo.node1.Mapped
  15757988 ±  6%      +9.2%   17208425 ±  4%      -0.7%   15640195 ±  7%  numa-meminfo.node1.MemUsed
    128748 ± 12%     +27.4%     163979 ±  9%     +13.2%     145716 ± 14%  numa-meminfo.node1.Slab
    894476 ±125%    +149.2%    2229168 ± 35%     -17.1%     741549 ±142%  numa-meminfo.node1.Unevictable
      8905 ± 14%     -37.5%       5565 ± 29%     -15.8%       7495 ± 44%  numa-vmstat.node0.nr_mapped
  1.35e+09            -4.8%  1.285e+09           +12.3%  1.516e+09        numa-vmstat.node0.numa_hit
 1.345e+09            -4.8%   1.28e+09           +12.3%   1.51e+09        numa-vmstat.node0.numa_local
      5594 ± 24%     +64.1%       9182 ± 18%     +29.8%       7263 ± 41%  numa-vmstat.node1.nr_mapped
    223619 ±125%    +149.2%     557292 ± 35%     -17.1%     185387 ±142%  numa-vmstat.node1.nr_unevictable
    223619 ±125%    +149.2%     557292 ± 35%     -17.1%     185387 ±142%  numa-vmstat.node1.nr_zone_unevictable
 1.344e+09            -4.7%   1.28e+09           +13.3%  1.522e+09        numa-vmstat.node1.numa_hit
 1.338e+09            -4.7%  1.275e+09           +13.1%  1.514e+09        numa-vmstat.node1.numa_local
    110744            +3.9%     115041            +1.9%     112845        proc-vmstat.nr_active_anon
   1744461            -3.0%    1692770            -2.4%    1701822        proc-vmstat.nr_anon_pages
     14294            +1.7%      14540            +5.0%      15012 ±  2%  proc-vmstat.nr_mapped
      6880            +3.8%       7138            +2.9%       7080        proc-vmstat.nr_page_table_pages
    110744            +3.9%     115041            +1.9%     112845        proc-vmstat.nr_zone_active_anon
 2.693e+09            -4.8%  2.565e+09           +12.8%  3.039e+09        proc-vmstat.numa_hit
 2.683e+09            -4.8%  2.555e+09           +12.7%  3.024e+09        proc-vmstat.numa_local
    103708            +4.9%     108792 ±  2%      -1.5%     102104        proc-vmstat.pgactivate
 2.672e+09            -4.8%  2.544e+09           +12.4%  3.003e+09        proc-vmstat.pgalloc_normal
 2.661e+09            -4.8%  2.534e+09           +12.4%  2.992e+09        proc-vmstat.pgfault
 2.669e+09            -4.7%  2.544e+09           +12.5%  3.003e+09        proc-vmstat.pgfree
     43665 ±  7%     +11.4%      48633 ±  3%      +5.5%      46058 ±  4%  proc-vmstat.pgreuse
     16.81            -1.0%      16.65            +2.2%      17.18        perf-stat.i.MPKI
  9.15e+09            -3.3%  8.845e+09            +8.8%  9.959e+09        perf-stat.i.branch-instructions
      0.47            +0.0        0.50            +0.0        0.47        perf-stat.i.branch-miss-rate%
  42741215            +1.6%   43433005            +8.7%   46461509        perf-stat.i.branch-misses
     84.26            -4.3       79.96            +1.4       85.69        perf-stat.i.cache-miss-rate%
 7.696e+08            -4.3%  7.363e+08           +12.0%  8.622e+08        perf-stat.i.cache-misses
 9.114e+08            +0.8%  9.187e+08           +10.1%  1.004e+09        perf-stat.i.cache-references
      6.32            +3.5%       6.55            -8.9%       5.76        perf-stat.i.cpi
    141.24            -4.3%     135.20            -3.9%     135.71        perf-stat.i.cpu-migrations
    378.24            +4.6%     395.50           -10.8%     337.51        perf-stat.i.cycles-between-cache-misses
 4.571e+10            -3.4%  4.416e+10            +9.6%  5.009e+10        perf-stat.i.instructions
      0.16            -3.3%       0.16            +9.5%       0.18        perf-stat.i.ipc
    169.33            -4.8%     161.22           +12.4%     190.36        perf-stat.i.metric.K/sec
   8806480            -4.8%    8384435           +12.4%    9900115        perf-stat.i.minor-faults
   8806480            -4.8%    8384435           +12.4%    9900116        perf-stat.i.page-faults
     14.04 ± 44%      -1.0%      13.90 ± 44%     +22.7%      17.22        perf-stat.overall.MPKI
     70.47 ± 44%      -3.7       66.75 ± 44%     +15.4       85.89        perf-stat.overall.cache-miss-rate%
      0.13 ± 44%      -3.5%       0.13 ± 44%     +31.6%       0.17        perf-stat.overall.ipc
 7.602e+09 ± 44%      -3.4%  7.339e+09 ± 44%     +30.6%  9.925e+09        perf-stat.ps.branch-instructions
  35433544 ± 44%      +1.4%   35934997 ± 44%     +30.3%   46185778        perf-stat.ps.branch-misses
 6.396e+08 ± 44%      -4.5%   6.11e+08 ± 44%     +34.4%  8.595e+08        perf-stat.ps.cache-misses
 7.563e+08 ± 44%      +0.9%  7.628e+08 ± 44%     +32.3%  1.001e+09        perf-stat.ps.cache-references
 3.797e+10 ± 44%      -3.5%  3.664e+10 ± 44%     +31.5%  4.992e+10        perf-stat.ps.instructions
   7318090 ± 44%      -4.9%    6957350 ± 44%     +34.9%    9868448        perf-stat.ps.minor-faults
   7318090 ± 44%      -4.9%    6957350 ± 44%     +34.9%    9868448        perf-stat.ps.page-faults
 1.149e+13 ± 44%      -3.5%  1.109e+13 ± 44%     +31.5%  1.511e+13        perf-stat.total.instructions
     21.63           -21.6        0.00           -21.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__tlb_batch_free_encoded_pages
     19.17           -19.2        0.00           -19.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__tlb_batch_free_encoded_pages.tlb_flush_mmu
     19.17           -19.2        0.00           -19.2        0.00        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
     44.89           -12.6       32.30           -16.5       28.42        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range
     44.90           -12.6       32.31           -16.5       28.42        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
     44.84           -12.6       32.26           -16.5       28.39        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma
     46.08           -12.4       33.66           -16.4       29.66        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault.do_fault
     46.18           -12.4       33.76           -16.4       29.79        perf-profile.calltrace.cycles-pp.folio_add_lru_vma.set_pte_range.finish_fault.do_fault.__handle_mm_fault
     48.87           -12.2       36.65           -15.5       33.40        perf-profile.calltrace.cycles-pp.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     61.81           -12.2       49.61           -11.6       50.25        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     63.82           -12.2       51.63           -11.1       52.73        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     63.95           -12.2       51.76           -11.1       52.86        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     62.59           -12.2       50.40           -11.4       51.22        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     61.24           -12.2       49.07           -11.7       49.58        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     47.21           -12.2       35.04           -16.0       31.18        perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
     71.03           -12.0       59.01            -9.7       61.33        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     74.04           -12.0       62.07            -9.1       64.96        perf-profile.calltrace.cycles-pp.testcase
      7.86            -0.3        7.58 ±  2%      +2.5       10.32 ±  2%  perf-profile.calltrace.cycles-pp.copy_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.61 ±  3%      -0.1        0.56 ±  3%      +0.3        0.88 ±  4%  perf-profile.calltrace.cycles-pp.try_charge_memcg.__mem_cgroup_charge.folio_prealloc.do_fault.__handle_mm_fault
      1.57            -0.0        1.52            +0.5        2.10 ±  3%  perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.36            -0.0        1.32            +0.3        1.63        perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.90            -0.0        0.85            +0.2        1.07        perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault
      1.28            -0.0        1.24            +0.2        1.52        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.33            -0.0        1.29            +0.5        1.81 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault
      1.10            -0.0        1.05            +0.2        1.30        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault.__handle_mm_fault
      1.05            -0.0        1.02            +0.2        1.26        perf-profile.calltrace.cycles-pp.alloc_pages_mpol.vma_alloc_folio.folio_prealloc.do_fault.__handle_mm_fault
      1.42            -0.0        1.40            +0.3        1.71        perf-profile.calltrace.cycles-pp.vma_alloc_folio.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      0.66            -0.0        0.64            +0.3        1.00        perf-profile.calltrace.cycles-pp._compound_head.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      0.79            -0.0        0.78            +0.2        0.97        perf-profile.calltrace.cycles-pp.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.folio_prealloc.do_fault
      0.52            -0.0        0.52 ±  2%      +0.1        0.62        perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.00            +0.0        0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.folio_prealloc
      0.78            +0.0        0.80            +0.1        0.92        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.testcase
      2.08            +0.0        2.13            +0.5        2.55        perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault.testcase
      2.33            +0.1        2.38            +0.4        2.78        perf-profile.calltrace.cycles-pp.__irqentry_text_end.testcase
      1.29            +0.1        1.35            +0.5        1.78        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      2.25            +0.1        2.32            +0.4        2.65        perf-profile.calltrace.cycles-pp.error_entry.testcase
      0.59            +0.1        0.72            +0.1        0.69        perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
      0.57 ±  4%      +0.3        0.84            +0.3        0.84 ±  4%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.set_pte_range.finish_fault.do_fault.__handle_mm_fault
      2.81            +0.4        3.20            +1.0        3.81        perf-profile.calltrace.cycles-pp.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.21            +0.4        1.63            +0.7        1.91        perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      0.00            +0.6        0.57 ±  4%      +0.2        0.18 ±141%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.folio_prealloc.do_fault.__handle_mm_fault
      2.68            +1.4        4.04            +1.0        3.65        perf-profile.calltrace.cycles-pp.release_pages.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      2.71            +1.4        4.07            +1.0        3.69        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      2.71            +1.4        4.07            +1.0        3.69        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.00            +3.8        3.79            +3.4        3.39        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folios_put_refs.release_pages.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      0.00            +4.0        4.03            +3.6        3.64        perf-profile.calltrace.cycles-pp.folios_put_refs.release_pages.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region
     20.62           +10.6       31.18            +7.4       28.04        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
     20.62           +10.6       31.18            +7.4       28.05        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     20.41           +10.6       30.99            +7.4       27.78        perf-profile.calltrace.cycles-pp.release_pages.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
     22.03           +10.6       32.64            +7.9       29.96        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
     22.03           +10.6       32.64            +7.9       29.96        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     22.03           +10.6       32.64            +7.9       29.96        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
     22.03           +10.6       32.65            +7.9       29.96        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     24.78           +12.0       36.74            +8.9       33.69        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     24.78           +12.0       36.74            +8.9       33.69        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     24.78           +12.0       36.74            +8.9       33.69        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     24.78           +12.0       36.74            +8.9       33.69        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.77           +12.0       36.74            +8.9       33.68        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     24.78           +12.0       36.74            +8.9       33.70        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     24.78           +12.0       36.74            +8.9       33.70        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     24.78           +12.0       36.74            +8.9       33.70        perf-profile.calltrace.cycles-pp.__munmap
      0.00           +29.4       29.41           +26.3       26.27        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folios_put_refs.release_pages.__tlb_batch_free_encoded_pages.tlb_flush_mmu
      0.00           +30.9       30.87           +27.7       27.66        perf-profile.calltrace.cycles-pp.folios_put_refs.release_pages.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
      0.00           +33.1       33.14           +29.6       29.63        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folios_put_refs.release_pages
      0.00           +33.2       33.18           +29.7       29.65        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folios_put_refs.release_pages.__tlb_batch_free_encoded_pages
     46.16           -12.4       33.72           -16.4       29.74        perf-profile.children.cycles-pp.folio_batch_move_lru
     46.19           -12.4       33.77           -16.4       29.80        perf-profile.children.cycles-pp.folio_add_lru_vma
     48.88           -12.2       36.66           -15.5       33.42        perf-profile.children.cycles-pp.finish_fault
     61.83           -12.2       49.63           -11.6       50.27        perf-profile.children.cycles-pp.__handle_mm_fault
     63.97           -12.2       51.77           -11.1       52.87        perf-profile.children.cycles-pp.exc_page_fault
     63.84           -12.2       51.65           -11.1       52.75        perf-profile.children.cycles-pp.do_user_addr_fault
     62.61           -12.2       50.42           -11.4       51.24        perf-profile.children.cycles-pp.handle_mm_fault
     61.26           -12.2       49.08           -11.7       49.60        perf-profile.children.cycles-pp.do_fault
     47.22           -12.2       35.05           -16.0       31.20        perf-profile.children.cycles-pp.set_pte_range
     69.07           -12.1       56.99           -10.1       59.01        perf-profile.children.cycles-pp.asm_exc_page_fault
     75.04           -11.9       63.09            -8.9       66.14        perf-profile.children.cycles-pp.testcase
     66.59            -1.1       65.49            -8.5       58.13        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     66.62            -1.1       65.56            -8.5       58.16        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     66.62            -1.1       65.57            -8.5       58.16        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      7.92            -0.3        7.62            +2.5       10.40 ±  2%  perf-profile.children.cycles-pp.copy_page
      0.28            -0.1        0.20 ±  2%      -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.62 ±  3%      -0.1        0.56 ±  3%      +0.3        0.89 ±  4%  perf-profile.children.cycles-pp.try_charge_memcg
      1.14            -0.0        1.09            +0.2        1.33        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.18 ±  2%      -0.0        0.13 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.uncharge_folio
      1.37            -0.0        1.32            +0.3        1.63        perf-profile.children.cycles-pp.__do_fault
      1.58            -0.0        1.54            +0.5        2.11 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.28            -0.0        1.24            +0.2        1.53        perf-profile.children.cycles-pp.shmem_fault
      1.35            -0.0        1.30            +0.5        1.83 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.90            -0.0        0.86            +0.2        1.07        perf-profile.children.cycles-pp.filemap_get_entry
      1.09            -0.0        1.06            +0.2        1.31        perf-profile.children.cycles-pp.alloc_pages_mpol
      0.67            -0.0        0.65            +0.3        1.01        perf-profile.children.cycles-pp._compound_head
      1.43            -0.0        1.41            +0.3        1.72        perf-profile.children.cycles-pp.vma_alloc_folio
      0.66            -0.0        0.64            +0.1        0.79        perf-profile.children.cycles-pp.___perf_sw_event
      0.36            -0.0        0.34 ±  2%      +0.1        0.45        perf-profile.children.cycles-pp.rmqueue
      0.07 ±  5%      -0.0        0.05 ±  8%      -0.0        0.05        perf-profile.children.cycles-pp.main
      0.07 ±  5%      -0.0        0.05 ±  8%      -0.0        0.05        perf-profile.children.cycles-pp.run_builtin
      0.24            -0.0        0.22 ±  4%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.39            -0.0        0.38 ±  2%      +0.1        0.48        perf-profile.children.cycles-pp.xas_load
      0.84            -0.0        0.82            +0.2        1.02        perf-profile.children.cycles-pp.__alloc_pages
      0.79            -0.0        0.78            +0.2        0.97        perf-profile.children.cycles-pp.__perf_sw_event
      0.06 ±  7%      -0.0        0.05 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.__cmd_record
      0.06 ±  7%      -0.0        0.05 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.cmd_record
      0.17 ±  4%      -0.0        0.16 ±  3%      +0.0        0.20        perf-profile.children.cycles-pp.policy_nodemask
      0.12 ±  4%      -0.0        0.11 ±  5%      +0.0        0.14        perf-profile.children.cycles-pp._find_first_bit
      0.06            -0.0        0.05            -0.0        0.02 ±141%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.49            -0.0        0.48            +0.1        0.62        perf-profile.children.cycles-pp.get_page_from_freelist
      0.20 ±  2%      -0.0        0.19            +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.xas_descend
      0.16 ±  3%      -0.0        0.15 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.handle_pte_fault
      0.09            -0.0        0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.53            -0.0        0.52            +0.1        0.62        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.07 ±  6%      -0.0        0.07            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.xas_start
      0.13            -0.0        0.13 ±  3%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.09 ±  5%      +0.0        0.09 ±  5%      +0.0        0.10        perf-profile.children.cycles-pp.down_read_trylock
      0.06            +0.0        0.06            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.05 ±  7%      +0.0        0.05 ±  7%      +0.0        0.07 ±  8%  perf-profile.children.cycles-pp.__cond_resched
      0.12 ±  3%      +0.0        0.12 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.00            +0.0        0.00            +0.1        0.05        perf-profile.children.cycles-pp.access_error
      0.31            +0.0        0.31            +0.1        0.37        perf-profile.children.cycles-pp.mas_walk
      0.27            +0.0        0.27 ±  2%      +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.get_vma_policy
      0.05            +0.0        0.05 ±  7%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__free_one_page
      0.28            +0.0        0.29            +0.1        0.34        perf-profile.children.cycles-pp.__mod_node_page_state
      0.07 ±  5%      +0.0        0.07 ±  5%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.folio_unlock
      0.12 ±  4%      +0.0        0.12            +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.shmem_get_policy
      0.07            +0.0        0.08 ±  6%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.folio_put
      0.15            +0.0        0.16 ±  3%      +0.0        0.19        perf-profile.children.cycles-pp.free_unref_page_commit
      0.36 ±  2%      +0.0        0.36            +0.1        0.43 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.20            +0.0        0.21 ±  2%      +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.free_swap_cache
      0.13 ±  5%      +0.0        0.14 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map
      0.10 ±  3%      +0.0        0.11 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.10 ±  4%      +0.0        0.11 ±  3%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.21            +0.0        0.22 ±  3%      +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.15 ±  4%      +0.0        0.16 ±  7%      +0.1        0.22 ± 18%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.07            +0.0        0.08 ±  4%      +0.0        0.08        perf-profile.children.cycles-pp.task_tick_fair
      0.09 ±  4%      +0.0        0.10            +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.up_read
      0.14 ±  3%      +0.0        0.16 ±  3%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.16 ±  2%      +0.0        0.17 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      0.84            +0.0        0.86            +0.2        1.00        perf-profile.children.cycles-pp.sync_regs
      0.02 ± 99%      +0.0        0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.rmqueue_bulk
      0.04 ± 44%      +0.0        0.06            +0.0        0.07        perf-profile.children.cycles-pp.page_counter_try_charge
      0.42            +0.0        0.44            +0.1        0.51        perf-profile.children.cycles-pp.free_unref_page_list
      0.21 ±  2%      +0.0        0.23 ±  2%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.08 ±  4%      +0.0        0.10 ±  4%      +0.0        0.12        perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.14 ±  3%      +0.0        0.17 ±  2%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.25            +0.0        0.27 ±  2%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.24            +0.0        0.27 ±  2%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.31            +0.0        0.34            +0.0        0.34 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.28            +0.0        0.30 ±  2%      +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.02            +0.0        1.06            +0.2        1.19        perf-profile.children.cycles-pp.native_irq_return_iret
      2.10            +0.0        2.15            +0.5        2.58        perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      2.33            +0.1        2.38            +0.4        2.78        perf-profile.children.cycles-pp.__irqentry_text_end
      1.32            +0.1        1.37            +0.5        1.80        perf-profile.children.cycles-pp.zap_present_ptes
      2.27            +0.1        2.33            +0.4        2.67        perf-profile.children.cycles-pp.error_entry
      0.28 ±  8%      +0.1        0.37 ±  5%      +0.1        0.41 ±  8%  perf-profile.children.cycles-pp.__count_memcg_events
      0.36            +0.1        0.46 ±  2%      +0.1        0.49        perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.28 ±  7%      +0.1        0.38 ±  4%      +0.2        0.43 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.60            +0.1        0.74            +0.1        0.71        perf-profile.children.cycles-pp.lru_add_fn
      0.00            +0.2        0.22 ±  2%      +0.1        0.12 ±  5%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.19 ±  2%      +0.2        0.43 ±  2%      +0.1        0.31 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.00            +0.3        0.28 ±  2%      +0.2        0.16 ±  2%  perf-profile.children.cycles-pp.uncharge_batch
      0.26 ± 11%      +0.3        0.58 ±  4%      +0.2        0.49 ±  7%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.57 ±  2%      +0.3        0.90 ±  2%      +0.3        0.90 ±  5%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.81 ±  3%      +0.4        1.19            +0.4        1.19 ±  3%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      2.83            +0.4        3.22            +1.0        3.84        perf-profile.children.cycles-pp.folio_prealloc
      1.22            +0.4        1.64            +0.7        1.92        perf-profile.children.cycles-pp.__mem_cgroup_charge
      2.72            +1.4        4.08            +1.0        3.70        perf-profile.children.cycles-pp.tlb_finish_mmu
     20.62           +10.6       31.18            +7.4       28.05        perf-profile.children.cycles-pp.tlb_flush_mmu
     22.04           +10.6       32.65            +7.9       29.96        perf-profile.children.cycles-pp.unmap_vmas
     22.04           +10.6       32.65            +7.9       29.96        perf-profile.children.cycles-pp.unmap_page_range
     22.04           +10.6       32.65            +7.9       29.96        perf-profile.children.cycles-pp.zap_pmd_range
     22.03           +10.6       32.65            +7.9       29.96        perf-profile.children.cycles-pp.zap_pte_range
     23.23           +11.8       35.04            +8.2       31.45        perf-profile.children.cycles-pp.release_pages
     23.34           +11.9       35.26            +8.4       31.74        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
     24.90           +12.0       36.85            +8.9       33.81        perf-profile.children.cycles-pp.do_syscall_64
     24.90           +12.0       36.85            +8.9       33.81        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     24.78           +12.0       36.74            +8.9       33.70        perf-profile.children.cycles-pp.do_vmi_align_munmap
     24.78           +12.0       36.74            +8.9       33.70        perf-profile.children.cycles-pp.do_vmi_munmap
     24.78           +12.0       36.74            +8.9       33.69        perf-profile.children.cycles-pp.__x64_sys_munmap
     24.78           +12.0       36.74            +8.9       33.69        perf-profile.children.cycles-pp.__vm_munmap
     24.78           +12.0       36.74            +8.9       33.69        perf-profile.children.cycles-pp.unmap_region
     24.78           +12.0       36.74            +8.9       33.70        perf-profile.children.cycles-pp.__munmap
      0.00           +35.1       35.05           +31.4       31.44        perf-profile.children.cycles-pp.folios_put_refs
     66.59            -1.1       65.49            -8.5       58.13        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      7.90            -0.3        7.60 ±  2%      +2.5       10.36 ±  2%  perf-profile.self.cycles-pp.copy_page
      0.40            -0.3        0.11 ±  6%      -0.3        0.12 ±  4%  perf-profile.self.cycles-pp.release_pages
      0.27            -0.1        0.19 ±  3%      -0.1        0.15 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.56 ±  3%      -0.1        0.50 ±  4%      +0.3        0.82 ±  4%  perf-profile.self.cycles-pp.try_charge_memcg
      0.17 ±  2%      -0.1        0.12 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.uncharge_folio
      1.34            -0.0        1.30            +0.5        1.81 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.24            -0.0        0.21 ±  2%      +0.0        0.25 ±  2%  perf-profile.self.cycles-pp.zap_present_ptes
      0.51            -0.0        0.48            +0.1        0.60        perf-profile.self.cycles-pp.filemap_get_entry
      0.27 ±  2%      -0.0        0.25            +0.1        0.33 ±  3%  perf-profile.self.cycles-pp.handle_mm_fault
      0.66            -0.0        0.64            +0.3        0.99        perf-profile.self.cycles-pp._compound_head
      0.40            -0.0        0.38            +0.1        0.49        perf-profile.self.cycles-pp.__handle_mm_fault
      0.24 ±  3%      -0.0        0.22 ±  3%      +0.1        0.29 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.12 ±  3%      -0.0        0.10 ±  4%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp._find_first_bit
      0.12 ±  4%      -0.0        0.11 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.free_unref_page_list
      0.16 ±  3%      -0.0        0.14 ±  3%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.57            -0.0        0.56            +0.1        0.69        perf-profile.self.cycles-pp.___perf_sw_event
      0.19 ±  3%      -0.0        0.18 ±  2%      +0.0        0.23 ±  3%  perf-profile.self.cycles-pp.xas_descend
      0.10 ±  3%      -0.0        0.09            +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.zap_pte_range
      0.13 ±  2%      -0.0        0.12 ±  4%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.13 ±  2%      -0.0        0.12 ±  5%      +0.0        0.15        perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.16 ±  2%      -0.0        0.16 ±  3%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.29            -0.0        0.28 ±  2%      +0.0        0.33 ±  2%  perf-profile.self.cycles-pp.__alloc_pages
      0.07 ±  5%      -0.0        0.07 ±  7%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.finish_fault
      0.08 ±  4%      -0.0        0.08 ±  6%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__rmqueue_pcplist
      0.10 ±  4%      -0.0        0.10            +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.do_fault
      0.11 ±  3%      -0.0        0.11 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.set_pte_range
      0.07 ±  5%      -0.0        0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.xas_start
      0.11 ±  4%      -0.0        0.11            +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.rmqueue
      0.18 ±  2%      -0.0        0.18 ±  2%      +0.0        0.22 ±  3%  perf-profile.self.cycles-pp.shmem_fault
      0.05            +0.0        0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.policy_nodemask
      0.12 ±  6%      +0.0        0.12 ±  4%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.xas_load
      0.00            +0.0        0.00            +0.1        0.05        perf-profile.self.cycles-pp.access_error
      0.00            +0.0        0.00            +0.1        0.05        perf-profile.self.cycles-pp.perf_exclude_event
      0.00            +0.0        0.00            +0.1        0.05        perf-profile.self.cycles-pp.rmqueue_bulk
      0.20            +0.0        0.20            +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.free_swap_cache
      0.30 ±  2%      +0.0        0.30            +0.1        0.36        perf-profile.self.cycles-pp.mas_walk
      0.13 ±  2%      +0.0        0.13 ±  3%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.get_vma_policy
      0.16            +0.0        0.16 ±  2%      +0.1        0.21        perf-profile.self.cycles-pp.do_user_addr_fault
      0.13 ±  8%      +0.0        0.13 ± 10%      +0.1        0.19 ± 20%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.07            +0.0        0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.08 ±  5%      +0.0        0.09 ±  5%      +0.0        0.10        perf-profile.self.cycles-pp.down_read_trylock
      0.09 ±  4%      +0.0        0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.folio_add_lru_vma
      0.12 ±  4%      +0.0        0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.14 ±  4%      +0.0        0.14 ±  5%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.__perf_sw_event
      0.10            +0.0        0.10 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.folio_add_new_anon_rmap
      0.06 ±  6%      +0.0        0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.free_unref_page_prepare
      0.28 ±  2%      +0.0        0.28            +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.18 ±  2%      +0.0        0.18 ±  2%      +0.0        0.21 ±  3%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.05            +0.0        0.06 ±  9%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.folio_prealloc
      0.07            +0.0        0.08 ±  6%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.folio_put
      0.09 ±  4%      +0.0        0.10 ±  4%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.12 ±  4%      +0.0        0.12            +0.0        0.14        perf-profile.self.cycles-pp.shmem_get_policy
      0.10 ±  3%      +0.0        0.10 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.__mod_zone_page_state
      0.12 ±  3%      +0.0        0.13            +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.12 ±  4%      +0.0        0.13 ±  2%      +0.0        0.15        perf-profile.self.cycles-pp.__pte_offset_map
      0.09            +0.0        0.10 ±  3%      +0.0        0.11        perf-profile.self.cycles-pp.up_read
      0.09            +0.0        0.10            +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.vma_alloc_folio
      0.84            +0.0        0.86            +0.2        1.00        perf-profile.self.cycles-pp.sync_regs
      0.03 ± 70%      +0.0        0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__free_one_page
      0.08            +0.0        0.10 ±  3%      +0.0        0.12        perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.06            +0.0        0.08 ±  5%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.02 ±141%      +0.0        0.06 ±  9%      +0.0        0.06        perf-profile.self.cycles-pp.page_counter_try_charge
      0.36            +0.0        0.40 ±  3%      -0.0        0.34 ±  2%  perf-profile.self.cycles-pp.folio_batch_move_lru
      1.01            +0.0        1.05            +0.2        1.19        perf-profile.self.cycles-pp.native_irq_return_iret
      2.34            +0.0        2.39            +0.5        2.81        perf-profile.self.cycles-pp.testcase
      0.30            +0.0        0.34            +0.0        0.33        perf-profile.self.cycles-pp.lru_add_fn
      0.06 ± 11%      +0.0        0.11 ±  4%      +0.0        0.10 ±  6%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      2.08            +0.1        2.13            +0.5        2.55        perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      2.33            +0.1        2.38            +0.4        2.78        perf-profile.self.cycles-pp.__irqentry_text_end
      2.26            +0.1        2.32            +0.4        2.66        perf-profile.self.cycles-pp.error_entry
      0.08 ±  6%      +0.1        0.16 ±  3%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.24 ±  9%      +0.1        0.32 ±  4%      +0.1        0.34 ±  8%  perf-profile.self.cycles-pp.__count_memcg_events
      0.30 ± 11%      +0.2        0.47 ±  6%      +0.1        0.40 ±  6%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.00            +0.2        0.19 ±  3%      +0.1        0.11 ±  5%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.26 ± 10%      +0.3        0.56 ±  4%      +0.2        0.48 ±  7%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.48 ±  2%      +0.3        0.80 ±  2%      +0.3        0.77 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.4        0.41            +0.4        0.43        perf-profile.self.cycles-pp.folios_put_refs


Best Regards,
Yujie

> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
> index 87cc678adc85..67f10b8810a8 100644
> --- a/include/linux/pagevec.h
> +++ b/include/linux/pagevec.h
> @@ -11,8 +11,8 @@
>  
>  #include <linux/types.h>
>  
> -/* 15 pointers + header align the folio_batch structure to a power of two */
> -#define PAGEVEC_SIZE	15
> +/* 31 pointers + header align the folio_batch structure to a power of two */
> +#define PAGEVEC_SIZE	31
>  
>  struct folio;
>  
> 

