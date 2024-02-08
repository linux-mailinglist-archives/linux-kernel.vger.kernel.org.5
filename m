Return-Path: <linux-kernel+bounces-57562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4686B84DAC0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667821C21BE0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A789767C4D;
	Thu,  8 Feb 2024 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8rUlyZS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547F6930A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707377829; cv=fail; b=mPNXhb/CbZfNVBPF24Rl50uQ1AjdSrjcIgmOMRn52/Wr+9eOo1GDiGmYazzI99s2s/csC2rvHH/U1zYxPWz6+anXCcnXPrYGVJ8GVb3LqKvKA/1w61OLc2jc97eBj8ASJs4UB3ITS8knfyGRxDt1qmNdqTbh3RxjNKAPplZWmuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707377829; c=relaxed/simple;
	bh=i9Phti9cLozQFUHbDkzlGCPSu1PnGX84X4IutC5LezQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QYqpARJ6xxcaCYRzFsqzZXoOkdA2DyqqTbAstAMSYpi0lbglScnqQ2VZdCYN2nEcfByOjq2Y365ExYdT99dCZTBXetg+N+0L6bEdG7ALuQNvUBS1pvSr/uI/4P+zxg/+MT4Lz0GzLCrQxtRzRBHFBxF7gD1oLxzQOhle0Pl8Ofs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8rUlyZS; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707377824; x=1738913824;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=i9Phti9cLozQFUHbDkzlGCPSu1PnGX84X4IutC5LezQ=;
  b=n8rUlyZSNVrdREChLcS8iBhJ+2G4riH7pg1Ywh54LP0j+VFMBor/fbYE
   KpDViCqjGaseWahTW4IpJrzh1I9qEO1+5FTd4gyBLF40xvYGOX8iVANlf
   /QzPSAiXu1M8encpBiN3mEwfDZuk9yDrYCclBk5rFDCannABOf4aMqJJB
   wMAvYH0Qggq/VKBxKwxCVwBjNNll3Bf/fnjOH7gMTXEfIO5Z1JkANCS5x
   IgzzA6PPQyfB8zrybEWRx25svxui7ydXwKWI9p1ARZo9k+O1coZ2eIg8y
   lFd/vPqu3P+gMFdJV3pQfR6a2VkuqOnL9iCfKBJm0XqmGKElZhPpNR4Lo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="18675353"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="18675353"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:37:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1897868"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2024 23:37:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 23:37:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 23:37:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 23:37:02 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Feb 2024 23:37:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hzwkk7QPdsnnhdl6YodAyGN1Xwlt1KwW9JvM5UR0KmBkp2WC9U2TFiAQNHoap4h82hKqDq9QhI9cK/xhRCsqRC+r1HWBh4Ewimtpx6czmyTcb3tNW/XztvC+hBQQt347rxKss2rJ8ogYF1iLYg0ZQa/78QJwM0B4vS80al10gFIcWcPzaRiEPAKD11reXvf4J6C4iT+g4MOH63tBBmgbRZiILFxAgncrLDzN+gCWMuy594Xx73cJu6gef+MD6JdLj1+HYrc2fTEQsLmv6QtdlpziL1Z+amQaEsXmfM3jORdATTvOkkCmV6l1ZfJqinw0ACicUwQ2Y81YvwBHrw6T6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLRV8tm9GBvhTHlpJx5L0c8KOxLai9wFASnEZHXshFI=;
 b=ZsTYfgf48vPkdkdgDDxjPJ7Mmalh6pzt1fS8gWhoL3iWLGstxkTFHbBL66NrWTC/x2YaZqrTbp2DclurGXKOSZeT/5z5mddv6Xn0pT5HhERHzpdPrgi7/PlJWT8IqY/fFBWNKjwmKuHVY6Q8GLnQQaRUE2CWZhcg2PWb97wVapfFy2O4MZO+5z6FjeHLeBIeL0V4jZTRc6zhtAtokxGfVHB3v4tQZnmJbWKayQFRGE/dTSZ3Uz2pCLtby23I1eS5xD/9pa48fxJBFuCD6bkhvYdFdAdhkRkOtFb+/SWY2o/Olx4gkozU7W/PTFzl+b8Hv6//NciXULm/mqiQSOmrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB7908.namprd11.prod.outlook.com (2603:10b6:8:ea::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.24; Thu, 8 Feb 2024 07:36:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 07:36:55 +0000
Date: Thu, 8 Feb 2024 15:36:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Yang Shi <shy828301@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Rik van Riel <riel@surriel.com>,
	<linux-mm@kvack.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  96204e1531:  will-it-scale.per_thread_ops -3.9%
 regression
Message-ID: <202402081435.c3faa4b4-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0116.apcprd02.prod.outlook.com
 (2603:1096:4:92::32) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 18da5fa5-82c7-422b-4c1e-08dc2878b9a6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHiF5aDfPsQUAC+8WTB1WbAiF19PytslC1II91RHXizdE2eyrmeM7/3hBgfs+Y5GYLh40TRQXhPirnQJtZDVYWOq+UrNmQ3w7kmYVxiRqMrmcUjn8ybGr3JwTOs6rRPfrQyeSbjaknn0SoFva06BlZRl5URoGGBir2DOVgaN3yKjtd5zV84Od+g4390kup4Ro4nrZ7Kl2SzsBKbkGZOXum960ri39PcHuIo5Orbnnc1cwkPdF58CP39wLefwAiEzlUtzBj7whUnitsGsLWRaoR58rKOi1gm8jz7SswNJsOeeFIY4FyqcjtyiifAnakyH5x3M+HjrMYpJh6xoIVUVCz3Qmbuzvl/fS3Mr+nQJUTyKz9Kd5O2u6Re+N4kOMiwN+FqF9tMqDWiUexYOLdWCkKXHAp49LrHxBPqIfVbQGcYxGr3YIqS8Kww22X/DS8Zr8QQY01woueaX4fQlGRtxnqfLq79dYmJMdBNwyilzpB/Zrlc90f2xoPPzz6TS5xE4JfkfPSuinjOelZjiXL1x0XXG105v9AgRSgo4WGeOYa0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230473577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2616005)(107886003)(26005)(1076003)(83380400001)(8936002)(8676002)(6916009)(66476007)(36756003)(66946007)(41300700001)(66556008)(966005)(6486002)(6506007)(6512007)(4326008)(86362001)(6666004)(54906003)(478600001)(30864003)(5660300002)(2906002)(82960400001)(316002)(38100700002)(19627235002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?T9Eygs9VZXRa2Wp7UZ1XMWFC7RqsoYkpiE78hhSrEpuTP0kktdjM2oAXxw?=
 =?iso-8859-1?Q?6v+GO5KE/75AAc2W8yP9paljXm8PD6cfYKB5wx2ZdUWcyeWBQYk63qEi6K?=
 =?iso-8859-1?Q?V+YR0GdhomGe/mv5vtYpUTceBw+x+fbbWwKYvHTDwGVfJfRUxwHtrbgpQs?=
 =?iso-8859-1?Q?MwkJs0aM6KoNAAMQnlJ/xYWeDw9/OY9x9ETGYCY880wMjbw9iyDgGt+pCG?=
 =?iso-8859-1?Q?7z27R7rH/Cj6UVEca4tNqgun9gV1z9KPSOAFiN6y0HR1tLR2UpmlmcAFCi?=
 =?iso-8859-1?Q?+2B0OacGPatct6cyqIzVxFjmCtfueo3SkBJ/1f3nJu9ZzYKXIKc5Be2OMg?=
 =?iso-8859-1?Q?Bk9CtSRA5qbK1nmmHlVf+G2udOH77E2B98TMNF+jjoyUgR79XWBlceuC10?=
 =?iso-8859-1?Q?zHZpR7+OJP+X4IQd3Qf/f1LkYYnroY5xS3qEB21a2oQAY0aKnQBiUj8jyM?=
 =?iso-8859-1?Q?51FkPkRJ8Tk6cCC+fQcJ5Wiwoot+XZx3cioxAFwvq0ec8TMn0eCtmPgMH+?=
 =?iso-8859-1?Q?IhLMM8iccrWWL5nhhmmBJCd2hSgpUwWDTEUpZ4UV8gKOg06OhmuQfE0jew?=
 =?iso-8859-1?Q?dfMfBAmd4b2r3/3RZGya27LNYtg2DYFYSpdD66yhq9RiC15A80DacGx7bO?=
 =?iso-8859-1?Q?OjuBF/T1ZXiB0EdKcXqloSjSTCcF1X3AHvUZse++Kag6N41N78hdanD2lk?=
 =?iso-8859-1?Q?UzqPh6VKcrQewXKnaUhLLGsTgzfyLCyfQhdzHgmC7zJUQlfqTBl1qSwzDo?=
 =?iso-8859-1?Q?u/DH8yT4tI3zLgD3lbVqgbkIFV8VDUleR6RU1X1tFv32nsAqdwE/ahItkR?=
 =?iso-8859-1?Q?eiDV+LJXA9oCluJYgKWDe14fZEpkq2ZQcJ6QIEkQsxuCxtE8FXuzC8twvH?=
 =?iso-8859-1?Q?AIMf1NLMWsOLr6x0IaT9MPg9Qk+P/8y5Ydynfg/fi2NNzkFFS9IlmLQov5?=
 =?iso-8859-1?Q?8YH+x1Bm8eZRuCcWqwiGpf1UZqWQg7tJgv9is60lYhP9mlt6CwiButXsuz?=
 =?iso-8859-1?Q?jXLhDZYFE5agYH4aQFZBKuxfwoDp8SGU23qlepJi8TXvA+LqeiuXoD5ZyH?=
 =?iso-8859-1?Q?s8vyQ4tsDlVnj4jiHA9ayUC5C/PkhciJ1nN/R0EphA4kOOTRXq6zKf1w7G?=
 =?iso-8859-1?Q?+iFHx2zABun2db5dJ0LYVNigmnkSQFAcMu6kL9YN+mpUi0veARCtUfOnXa?=
 =?iso-8859-1?Q?J9lYmGHk6R+O2I0dXFiPr5fXT14jm+ZNhxd7zCHMf3lofjkJ5un3Jiaetb?=
 =?iso-8859-1?Q?BVk+wD2GyXaSEG0KjNzo18VCXoU9gpJ0mvskdnERneXTBtnp8CNhvx7MuH?=
 =?iso-8859-1?Q?X1nDWa1hHIwSyrrqlLWFW6zqWM2a03aDMNC7bPhyvT+9M6/J+bqlxVFeQq?=
 =?iso-8859-1?Q?4nVwjMNQYXELSYAAiUVx0Q90TYWEJ9gkgEqtpn+zdVJEn8bkCnGI82Ft9M?=
 =?iso-8859-1?Q?yCkV/6arRDU4QAUxEcNV51FuNrb6WstmIQBd+pJs/Ec634/wY4EdAn0+QF?=
 =?iso-8859-1?Q?XdZW13BB5oE5iQc6VbXp+qkC2otJe2no/4mkoXJ2riRawbX0HcAWLWELPl?=
 =?iso-8859-1?Q?uhvDz7pl6AFpjZBrk2PP3vHpK6F6lS0b6SzNEtU/06UGjnpKDPS7pMJ1XP?=
 =?iso-8859-1?Q?js2lBh9amiclXJ3rMciaI6bEEW+DaTZI0ZIs8YMEhR6bzz4BCeft1msQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18da5fa5-82c7-422b-4c1e-08dc2878b9a6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 07:36:55.8730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCVxvU3BTLeGAmqXBCrciXPBv2taLik7sEwRH0rwixfwvF0CzW2xd74mi5XCQOu6xPniyIlV383wBF5NXqFQgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7908
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -3.9% regression of will-it-scale.per_thread_ops on:


commit: 96204e15310c218fd9355bdcacd02fed1d18070e ("mm: thp_get_unmapped_area must honour topdown preference")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: will-it-scale
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	test: page_fault1
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402081435.c3faa4b4-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240208/202402081435.c3faa4b4-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-2sp4/page_fault1/will-it-scale

commit: 
  4ef9ad19e1 ("mm: huge_memory: don't force huge page alignment on 32 bit")
  96204e1531 ("mm: thp_get_unmapped_area must honour topdown preference")

4ef9ad19e17676b9 96204e15310c218fd9355bdcacd 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     32.93            -3.5       29.43        mpstat.cpu.all.sys%
     77.89 ±  2%     -10.2%      69.98        vmstat.procs.r
      4678           +14.0%       5332        vmstat.system.cs
    251960            -3.4%     243306        vmstat.system.in
      1049           -10.2%     943.00        turbostat.Avg_MHz
     36.22            -3.7       32.54        turbostat.Busy%
     29.10            +1.8       30.87        turbostat.C1E%
      0.35           +15.7%       0.40        turbostat.CPU%c6
    565.62            -2.3%     552.53        turbostat.PkgWatt
    123847           -18.4%     101096        meminfo.Active
    123657           -18.3%     101000        meminfo.Active(anon)
   8127530           +10.3%    8966990        meminfo.AnonHugePages
   8298705           +10.3%    9156780        meminfo.AnonPages
   8417195           +10.1%    9267954        meminfo.Inactive
   8416461           +10.1%    9267742        meminfo.Inactive(anon)
    138121           -16.9%     114720        meminfo.Shmem
   4852175 ±  2%      +9.2%    5296708        numa-meminfo.node0.AnonHugePages
   4941270 ±  2%      +9.0%    5387476        numa-meminfo.node0.AnonPages
    121571           -18.9%      98652        numa-meminfo.node1.Active
    121528           -18.9%      98620        numa-meminfo.node1.Active(anon)
   3270590           +12.4%    3674514        numa-meminfo.node1.AnonHugePages
   3352686           +12.6%    3773824        numa-meminfo.node1.AnonPages
   3395079           +12.4%    3815833        numa-meminfo.node1.Inactive
   3394971           +12.4%    3815762        numa-meminfo.node1.Inactive(anon)
    125041           -18.4%     102036        numa-meminfo.node1.Shmem
   1219136 ±  2%     +10.3%    1344427        numa-vmstat.node0.nr_anon_pages
      2337           +10.4%       2581        numa-vmstat.node0.nr_anon_transparent_hugepages
   1237208 ±  2%     +10.1%    1362084        numa-vmstat.node0.nr_inactive_anon
   1236994 ±  2%     +10.1%    1362125        numa-vmstat.node0.nr_zone_inactive_anon
     30361           -18.8%      24656        numa-vmstat.node1.nr_active_anon
    828422           +13.5%     940280        numa-vmstat.node1.nr_anon_pages
      1577           +13.3%       1788        numa-vmstat.node1.nr_anon_transparent_hugepages
    838873           +13.3%     950629 ±  2%  numa-vmstat.node1.nr_inactive_anon
     31244           -18.4%      25510        numa-vmstat.node1.nr_shmem
     30361           -18.8%      24656        numa-vmstat.node1.nr_zone_active_anon
    838696           +13.4%     950674 ±  2%  numa-vmstat.node1.nr_zone_inactive_anon
     30907           -18.4%      25233        proc-vmstat.nr_active_anon
   2068862           +11.0%    2295458        proc-vmstat.nr_anon_pages
      3957           +11.0%       4390        proc-vmstat.nr_anon_transparent_hugepages
   2099316           +10.6%    2322543        proc-vmstat.nr_inactive_anon
      7379            +4.4%       7701        proc-vmstat.nr_page_table_pages
     34526           -17.0%      28665        proc-vmstat.nr_shmem
     30907           -18.4%      25233        proc-vmstat.nr_zone_active_anon
   2099307           +10.6%    2322537        proc-vmstat.nr_zone_inactive_anon
     26039 ± 10%     -16.4%      21774 ±  6%  proc-vmstat.numa_hint_faults_local
  51127959            -3.7%   49228917        proc-vmstat.numa_hit
  50891640            -3.7%   48994322        proc-vmstat.numa_local
     32315           -21.8%      25269        proc-vmstat.pgactivate
 1.265e+10            -3.8%  1.217e+10        proc-vmstat.pgalloc_normal
  25947640            -3.6%   25012103        proc-vmstat.pgfault
 1.265e+10            -3.8%  1.217e+10        proc-vmstat.pgfree
  24650837            -3.8%   23717158        proc-vmstat.thp_fault_alloc
  44754589           -15.5%   37839290        will-it-scale.112.threads
     74.20           +11.2%      82.49        will-it-scale.112.threads_idle
  36349325            -6.0%   34182802        will-it-scale.168.threads
     72.79           +11.7%      81.28        will-it-scale.168.threads_idle
  40356275            -5.6%   38083547        will-it-scale.224.threads
     66.97           +19.5%      80.06        will-it-scale.224.threads_idle
  28146956           -15.5%   23782499        will-it-scale.56.threads
     78.16            +8.4%      84.70        will-it-scale.56.threads_idle
    795871            -3.9%     764972        will-it-scale.per_thread_ops
     67103            -4.9%      63834        will-it-scale.time.involuntary_context_switches
  17508243 ±  4%      +6.9%   18724480        will-it-scale.time.maximum_resident_set_size
  22382078            -3.6%   21577203        will-it-scale.time.minor_page_faults
      7050            -7.3%       6534        will-it-scale.time.percent_of_cpu_this_job_got
     20998            -7.4%      19448        will-it-scale.time.system_time
      1075            -3.3%       1040        will-it-scale.time.user_time
    236326           +40.3%     331522        will-it-scale.time.voluntary_context_switches
 4.056e+08            -3.9%  3.899e+08        will-it-scale.workload
   5880710            -9.8%    5305863        sched_debug.cfs_rq:/.avg_vruntime.avg
  10300738 ±  2%     -11.0%    9163982 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
   1772532 ±  6%     -15.5%    1498526 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.min
   2066050           -12.1%    1817081        sched_debug.cfs_rq:/.avg_vruntime.stddev
    321.14 ± 36%     -63.9%     115.93 ± 57%  sched_debug.cfs_rq:/.load_avg.avg
      1945 ± 20%     -47.8%       1015 ± 50%  sched_debug.cfs_rq:/.load_avg.stddev
   5880710            -9.8%    5305863        sched_debug.cfs_rq:/.min_vruntime.avg
  10300738 ±  2%     -11.0%    9163982 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
   1772532 ±  6%     -15.5%    1498526 ±  4%  sched_debug.cfs_rq:/.min_vruntime.min
   2066050           -12.1%    1817081        sched_debug.cfs_rq:/.min_vruntime.stddev
    233.57 ±  8%     -24.3%     176.83 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
    958.36 ±  4%      -9.2%     870.11 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
    240.06 ±  5%     -20.4%     190.99 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    232.74 ±  9%     -24.3%     176.20 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
    238.62 ±  5%     -20.4%     189.97 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
    134.97 ± 20%     -46.6%      72.12 ±  9%  sched_debug.cfs_rq:/.util_est.avg
    211.62 ±  7%     -30.9%     146.18 ±  3%  sched_debug.cfs_rq:/.util_est.stddev
     85860 ±  4%     +20.2%     103165 ±  4%  sched_debug.cpu.avg_idle.stddev
      2360 ± 15%     -32.2%       1600 ±  6%  sched_debug.cpu.curr->pid.avg
      4127 ±  5%     -11.4%       3655 ±  2%  sched_debug.cpu.curr->pid.stddev
      0.18 ± 13%     -30.8%       0.13 ±  5%  sched_debug.cpu.nr_running.avg
      0.35 ±  3%     -11.4%       0.31        sched_debug.cpu.nr_running.stddev
      4008           +10.9%       4445        sched_debug.cpu.nr_switches.avg
      0.25 ±  9%     +22.4%       0.31 ±  2%  sched_debug.cpu.nr_uninterruptible.avg
    234.42           +10.7%     259.59        perf-stat.i.MPKI
 1.038e+09            -2.6%  1.012e+09        perf-stat.i.branch-instructions
      0.45            +0.0        0.47        perf-stat.i.branch-miss-rate%
 1.192e+09            +4.1%  1.241e+09        perf-stat.i.cache-misses
 1.307e+09            +3.2%  1.349e+09        perf-stat.i.cache-references
      4550           +15.1%       5238        perf-stat.i.context-switches
     37.73           -11.3%      33.45        perf-stat.i.cpi
 2.282e+11           -10.6%  2.041e+11        perf-stat.i.cpu-cycles
    395.06            -4.0%     379.37        perf-stat.i.cycles-between-cache-misses
      0.08            -0.0        0.07        perf-stat.i.dTLB-load-miss-rate%
    957972           -11.5%     848218        perf-stat.i.dTLB-load-misses
 1.142e+09            -2.6%  1.112e+09        perf-stat.i.dTLB-loads
   4327055            -3.0%    4195482        perf-stat.i.dTLB-store-misses
 9.982e+08            -3.2%   9.66e+08        perf-stat.i.dTLB-stores
 5.057e+09            -2.7%   4.92e+09        perf-stat.i.instructions
      0.08            +4.6%       0.09        perf-stat.i.ipc
      1.02           -10.5%       0.91        perf-stat.i.metric.GHz
    245.40            -1.7%     241.21        perf-stat.i.metric.K/sec
     19.83            -1.0%      19.63        perf-stat.i.metric.M/sec
     81125            -3.9%      77994        perf-stat.i.minor-faults
   9961580            -4.6%    9501596        perf-stat.i.node-loads
     81127            -3.9%      77996        perf-stat.i.page-faults
    239.06            +6.3%     254.04        perf-stat.overall.MPKI
      0.41            +0.0        0.42        perf-stat.overall.branch-miss-rate%
     45.33            -7.8%      41.81        perf-stat.overall.cpi
    189.64           -13.2%     164.59        perf-stat.overall.cycles-between-cache-misses
      0.09            -0.0        0.08        perf-stat.overall.dTLB-load-miss-rate%
      0.02            +8.4%       0.02        perf-stat.overall.ipc
      3930            +1.4%       3987        perf-stat.overall.path-length
 1.044e+09            -2.5%  1.017e+09        perf-stat.ps.branch-instructions
 1.215e+09            +3.5%  1.257e+09        perf-stat.ps.cache-misses
 1.329e+09            +2.7%  1.365e+09        perf-stat.ps.cache-references
      4559           +14.8%       5231        perf-stat.ps.context-switches
 2.304e+11           -10.2%  2.069e+11        perf-stat.ps.cpu-cycles
    977167           -11.5%     864759        perf-stat.ps.dTLB-load-misses
 1.146e+09            -2.5%  1.117e+09        perf-stat.ps.dTLB-loads
   4393673            -3.1%    4258515        perf-stat.ps.dTLB-store-misses
 1.006e+09            -3.2%  9.745e+08        perf-stat.ps.dTLB-stores
 5.082e+09            -2.6%  4.948e+09        perf-stat.ps.instructions
     82026            -3.8%      78940        perf-stat.ps.minor-faults
  10075965            -4.4%    9629094        perf-stat.ps.node-loads
     82028            -3.8%      78942        perf-stat.ps.page-faults
 1.594e+12            -2.5%  1.555e+12        perf-stat.total.instructions
     82.91            -2.8       80.13        perf-profile.calltrace.cycles-pp.clear_page_erms.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
     94.27            -1.2       93.10        perf-profile.calltrace.cycles-pp.testcase
     92.74            -1.2       91.59        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     92.76            -1.1       91.62        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     92.82            -1.1       91.69        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     92.82            -1.1       91.69        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     94.24            -1.0       93.19        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     90.44            -1.0       89.46        perf-profile.calltrace.cycles-pp.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     90.76            -0.9       89.81        perf-profile.calltrace.cycles-pp.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.59 ±  2%      -0.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clear_page_erms.clear_huge_page.__do_huge_pmd_anonymous_page
      1.98            -0.2        1.77        perf-profile.calltrace.cycles-pp.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.98            -0.2        1.76        perf-profile.calltrace.cycles-pp.vma_alloc_folio.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.80            -0.2        1.60        perf-profile.calltrace.cycles-pp.prep_compound_page.get_page_from_freelist.__alloc_pages.alloc_pages_mpol.vma_alloc_folio
      1.85            -0.2        1.65        perf-profile.calltrace.cycles-pp.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.do_huge_pmd_anonymous_page.__handle_mm_fault
      1.84            -0.2        1.64        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.do_huge_pmd_anonymous_page
      1.85            -0.2        1.66        perf-profile.calltrace.cycles-pp.alloc_pages_mpol.vma_alloc_folio.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.98            -0.1        0.84        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.clear_page_erms.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault
      1.33            -0.1        1.28        perf-profile.calltrace.cycles-pp.free_unref_page_prepare.free_unref_page.release_pages.tlb_batch_pages_flush.tlb_finish_mmu
      1.51            -0.0        1.46        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.47            -0.0        1.43        perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.38            -0.0        1.33        perf-profile.calltrace.cycles-pp.free_unref_page.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region
      1.46            -0.0        1.42        perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      1.64            -0.0        1.60        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      0.78 ±  3%      +0.2        0.96        perf-profile.calltrace.cycles-pp.intel_idle_xstate.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.64            +0.2        0.82 ±  3%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.82 ±  3%      +0.3        1.12 ±  4%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.84 ±  3%      +0.3        1.16 ±  4%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.26 ±100%      +0.4        0.70        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.26 ±  5%      +0.5        1.74 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.40 ±  4%      +0.5        1.92 ±  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.45            +0.9        4.35        perf-profile.calltrace.cycles-pp.__cond_resched.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      2.75            +1.0        3.70 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      2.88            +1.0        3.87 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      3.08            +1.0        4.12 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.12            +1.1        4.18 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.12            +1.1        4.18 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.12            +1.1        4.18 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      3.15            +1.1        4.22 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     84.16            -2.9       81.22        perf-profile.children.cycles-pp.clear_page_erms
     92.75            -1.2       91.60        perf-profile.children.cycles-pp.__handle_mm_fault
     92.77            -1.1       91.63        perf-profile.children.cycles-pp.handle_mm_fault
     94.98            -1.1       93.84        perf-profile.children.cycles-pp.testcase
     92.83            -1.1       91.70        perf-profile.children.cycles-pp.do_user_addr_fault
     92.83            -1.1       91.70        perf-profile.children.cycles-pp.exc_page_fault
     93.55            -1.1       92.47        perf-profile.children.cycles-pp.asm_exc_page_fault
     90.13            -1.0       89.13        perf-profile.children.cycles-pp.clear_huge_page
     90.76            -0.9       89.81        perf-profile.children.cycles-pp.__do_huge_pmd_anonymous_page
      1.98            -0.2        1.77        perf-profile.children.cycles-pp.do_huge_pmd_anonymous_page
      1.98            -0.2        1.76        perf-profile.children.cycles-pp.vma_alloc_folio
      1.80            -0.2        1.60        perf-profile.children.cycles-pp.prep_compound_page
      1.88            -0.2        1.69        perf-profile.children.cycles-pp.get_page_from_freelist
      1.94            -0.2        1.76        perf-profile.children.cycles-pp.__alloc_pages
      1.94            -0.2        1.76        perf-profile.children.cycles-pp.alloc_pages_mpol
      0.38            -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function
      1.38            -0.0        1.33        perf-profile.children.cycles-pp.free_unref_page_prepare
      1.51            -0.0        1.46        perf-profile.children.cycles-pp.tlb_finish_mmu
      1.39            -0.0        1.34        perf-profile.children.cycles-pp.free_unref_page
      1.47            -0.0        1.42        perf-profile.children.cycles-pp.release_pages
      1.47            -0.0        1.43        perf-profile.children.cycles-pp.tlb_batch_pages_flush
      1.64            -0.0        1.60        perf-profile.children.cycles-pp.unmap_region
      0.21 ±  3%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.task_tick_fair
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.folio_prep_large_rmappable
      0.09 ±  4%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.free_tail_page_prepare
      0.17 ±  2%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.pte_alloc_one
      0.17 ±  4%      +0.0        0.19        perf-profile.children.cycles-pp.perf_rotate_context
      0.06 ± 11%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.06 ±  8%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.clockevents_program_event
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.16 ±  4%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.find_busiest_group
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.05            +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.__schedule
      0.11 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.load_balance
      0.17 ±  8%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.menu_select
      0.01 ±223%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.__mmap
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.11 ±  4%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.down_write_killable
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.schedule
      0.79 ±  4%      +0.1        0.87 ±  3%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      0.19 ±  3%      +0.1        0.27 ±  3%  perf-profile.children.cycles-pp.__do_softirq
      0.21 ±  3%      +0.1        0.31 ±  3%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.00            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      1.17            +0.1        1.29        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.79 ±  3%      +0.2        0.97        perf-profile.children.cycles-pp.intel_idle_xstate
      0.50 ±  3%      +0.2        0.70        perf-profile.children.cycles-pp.intel_idle
      1.45 ±  2%      +0.2        1.67 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.48 ±  2%      +0.2        1.73 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.50 ±  2%      +0.4        2.89 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.94 ±  4%      +0.4        2.35 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      3.60            +0.9        4.50        perf-profile.children.cycles-pp.__cond_resched
      2.91            +1.0        3.90 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      2.90            +1.0        3.90 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
      3.11            +1.0        4.15 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      3.12            +1.1        4.18 ±  2%  perf-profile.children.cycles-pp.start_secondary
      3.15            +1.1        4.22 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
      3.15            +1.1        4.22 ±  2%  perf-profile.children.cycles-pp.do_idle
      3.15            +1.1        4.22 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     83.46            -2.9       80.61        perf-profile.self.cycles-pp.clear_page_erms
      1.79            -0.2        1.59        perf-profile.self.cycles-pp.prep_compound_page
      1.30            -0.1        1.25        perf-profile.self.cycles-pp.free_unref_page_prepare
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.folio_prep_large_rmappable
      0.05            +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.06 ± 11%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.16 ±  4%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.07 ±  6%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.menu_select
      0.20 ±  3%      +0.0        0.25 ±  2%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.read_tsc
      0.78 ±  3%      +0.2        0.97        perf-profile.self.cycles-pp.intel_idle_xstate
      0.50 ±  3%      +0.2        0.70        perf-profile.self.cycles-pp.intel_idle
      2.93            +0.9        3.83        perf-profile.self.cycles-pp.__cond_resched
      2.59            +1.0        3.61        perf-profile.self.cycles-pp.clear_huge_page




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


