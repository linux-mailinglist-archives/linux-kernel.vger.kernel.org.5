Return-Path: <linux-kernel+bounces-39668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A307E83D4E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164441F27139
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB6D1EB2B;
	Fri, 26 Jan 2024 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ScutijRH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805E314A8D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250959; cv=fail; b=Ndt23lTLfTPcuL41oZmxXgNGeQQY/k8rxoXIUsJiSKsTudyT/zuj8K6wz3o+LWEvsRQqgWhajQnaiI3tfdhCevYOniY02v1S059vNt6zhzqU/s9mktBTQLmqipR0iQEOjiDjMrETRzXpcxT6PEdKYiq3nKQi6gjMTphwymrQkYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250959; c=relaxed/simple;
	bh=MKGIfMR9eww4y5EWvoVrHeoUBI0u3MFDgfhsszoI8ek=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c128Ki0k3GwqNRmR9tCz1mqSUtSeChWW1jOzEG16jB46bEHJmBWYuiODPIrWioTPhp1sRSZNrXmlZYkgTAYqFow7H7mTRVvrHt4DJpHZzCmBQvJlrOae/Yax/XbW2ekxlprOzCbIZHhPDl5LMfjmOP0Lf+aLUs4bAdZ8KfbGx+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ScutijRH; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706250956; x=1737786956;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MKGIfMR9eww4y5EWvoVrHeoUBI0u3MFDgfhsszoI8ek=;
  b=ScutijRHzH/8+67zXwwTKq696vTK+8IcQWoCzyN5R+d5UDAfZEmTiJ/h
   0IwLBg+ALhowZgSXMymOa1YnTaw1LB5WysJA6BBvmMffrHBtTe0XlFZ/f
   dbJBMPEbNCVm05EsOwXtpSTyZQ5kMCFNSD1CeeB0mJhJfishsm66IgCf4
   LoxgvF9DnyyNLMbFkK/c0/7ZL7qVmRKfYwtAlp1h6WL49B5vO2AfQduMX
   EBeP02wQ+QrFCUqEzK3ii25KzrantDypq9n4L6E+dvY+2Yh6GVwpQV1BL
   SjJcU2+al2PB60k4enoWedIkPJj1WupI1WF0NTRvc5wBZ2p3nRnpKd3Df
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15927262"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15927262"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 22:35:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="736595257"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="736595257"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 22:35:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 22:35:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 22:35:53 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 22:35:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uxaa9Jlb1ipxx4XC+VuWCTjhge+b9shREjI5IfsJCVMAVznTU61yp8gWMzb3H48tLPbGseCaFSdHtcXTNcEJec0W09wwaPlfjBGOi9Gp985qv0O9x5zTtd7t0sVAjOUl7ot5eFRsvVQzFuBEItb5+p46/grDsnRJRWvQyg/MCbURw/e/J63PWPT7do5813W2iTq9xYY/qsHAec7wPAKZAPvHja+XDjRVGyYWmqyzCqI+1xOykzbhNnp0Eh92+Z8/x5ImchVel6S4B6tfknKPMNclT/ol56WczsNCDmgC/Lgx8vj5OyzieO2VGPvSQUAkJVq7ov6Y4aOycNGX4YyCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaILnyZI1aiMGISNctM7F/4oMzitnGA2fPvwk4PEFYY=;
 b=ahwEPuSozVkeUOl7fztwbNv9LjbgfSMS5ML8KjCJDLqtj0iGlIG0WbozhiXRzMY2YH9qTSISeBuDdewf4/obp28+9vUn7x0Yk1mKeCZXDVgLvkl8Xd+fsFGYDsSzs9OFLNC/17Gua8hAwFvGoAX4JsqKO8Qe2y/6/CPaCu2bmVrmLLfwu6NdNvdmkfk6YDJMjYsgmM21dggxI4CqiQ/8WesmtXCE1Tr7SJ+7P3ZaMg1hWbHa+EPYN2cRTRBdD8O79CJ4OXy5rw+75lZiFVbkCE9EUrghzzQthaIXAih7tlOkE/poYuMQ47xhBvbkCHQtF+OPXmBGKvklVDBUnHtQAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6244.namprd11.prod.outlook.com (2603:10b6:208:3e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 06:35:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 06:35:51 +0000
Date: Fri, 26 Jan 2024 14:35:44 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Catalin Marinas <catalin.marinas@arm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Waiman Long <longman@redhat.com>,
	<linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [kmemleak]  39042079a0:
 kernel-selftests.kvm.memslot_perf_test.fail
Message-ID: <ZbNSwITESw+/SfNy@xsang-OptiPlex-9020>
References: <202401251429.d3dea02b-oliver.sang@intel.com>
 <ZbJNtFO_N4pVuEUK@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZbJNtFO_N4pVuEUK@arm.com>
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 5067f1c3-9328-46e6-f0ea-08dc1e390a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jytsAm3fFxUR2DTRfO0Yb4W1hfp7r/U8Ujt53fQaSGGuJ4My658vyY61/0xBgGrxOYkX4wxt3tkD6kHnElidC5mWpwbd9pafzZ0KTZdy5V7tQvWlJDI+us4mRQNFRgWsP6ujmoPUP7IN9JlHDbo/ag0cDuHUHG/K4ErmAlxX8LGXNdseDhz3YkpN5T4kIjg+uEFtNc9PjWro0knJJbiaeMiP0+t2pvIBlqj8enad137vnf1hZqnYZNJjKQaTk39rtojAj4Rv0FGAVgzOvPYs7obWuezJPkwfXDaE/PsaQ/XSxRs08xKEVjzQJbwFnW/CINuGlqfNaN06fMhdcePvO6e0k9tr7EiuWsXzllQDllcpjDzcLpgeT4q7vPpxBRtDWZMCZ8RrcaJR6v8g6816I+rBMMceNnrIgNwl8DMVknUFJShnZFKrjSH9PXN/p5eqFHtle1rlKYx5p1PBTywQRnuMTwcp/FbmvwSFSo7ZKwfmtoTNoaN+geTexi/0LSpqpjh+dUETVkUIa8Eln7eGTN7HtqZ+TI4YC9Uuz6nLWviTACaDK3ZgWppTWOCwHIMfCTZzOWLqSu/vHcXr3wZdTegEQzwIbmbikjjwlEKlfg3uevd7y/FZyFm9gOT7iX4T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(64100799003)(1800799012)(82960400001)(38100700002)(2906002)(5660300002)(33716001)(86362001)(41300700001)(26005)(107886003)(478600001)(966005)(6486002)(83380400001)(66946007)(316002)(6916009)(54906003)(66476007)(66556008)(6512007)(9686003)(6666004)(6506007)(4326008)(8936002)(8676002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FCFegthiPZ4EaBoXowqpeRdgzoft09S1ZYDesce8jtSCEv8B+tDxFq+bN5Ex?=
 =?us-ascii?Q?/vTd03LMt1Djd4+tuyjKgpsAKHQ4JQRb4O7yQHHoKeNrp7UdRztkzNXef5ao?=
 =?us-ascii?Q?wT2KHbukkti5djgmA8ak9ytGX9xBhAW1HmOS7bK2k31olPnuonXJ0zZQfmZU?=
 =?us-ascii?Q?qDVhIHjA+uOUYo27n0m3JSBoprDdTpbAGLe/Jq611lTVaBTx/CG3MpxJL1jb?=
 =?us-ascii?Q?nWPF5/gRood3tNp8wXpzdA4lzkP8o4hhMkZbXeba7ahM2XR2BBt2acrRusqX?=
 =?us-ascii?Q?BFAkWlIKHQ+2ZBLLKspFo8hDCGlCEBEXg2+6CFM/daNTmJWsg6cUGnO7spiB?=
 =?us-ascii?Q?CuFUMkY+NErl/XMioLHB/HDbkhFFKumro/DhZ++GagyZGdMWlb0VfvlW3sN0?=
 =?us-ascii?Q?gZMS8bVm974ZAvOcXUp8IkA+WY1I0AZ4Vivrb2ypuVjmdqLoa5VfwLH3J8Uu?=
 =?us-ascii?Q?Yon0p6q6DdJKmaclr37eSjLIGm/eezUdP9yrWvrB2/Mq4FN1Hm/bsO2Xf/0l?=
 =?us-ascii?Q?t1ucwIv0pIdsIrYbuuRSX2XY9R+MyTKSIdAkNqZVh7ZDarYoWVlaOlDt0T5p?=
 =?us-ascii?Q?qSL9WySfaLu3ZyfDbX+fcdEZTu7xrJaVWFhr01/1ufBrV+pG4Rt3PWoT4S1a?=
 =?us-ascii?Q?rd5/m39ff4csKnOE+OBuiq20PXijq88zxdwWfRSU1otOi4u+buQVZt7MEJEF?=
 =?us-ascii?Q?WY+ogtPHhggE89WivE4i5w0VQGKn/1WyqhMCCE3EDBZzTJHZVMG298mV1e3c?=
 =?us-ascii?Q?vd9OcZjFrJRnYz1AMcE/HqSDt7ULnKZzo7LKkUxpuip1ct34mARPr7xOrqae?=
 =?us-ascii?Q?EPYFX5esM+stuc4jzpoNNTgdR2hcRvncUHoKblT+k8YDBvZEvBdbgeeyhgqH?=
 =?us-ascii?Q?l+KV4j+GYjgmhxHFY+9bx62xJJptntAN58tLVK/wm+M+gkM6DPlBFisllmR9?=
 =?us-ascii?Q?IXdPW6R2vA16gedf97LF1ddLUSkP+UnIJFYM62g2ckUfbZiboGQ1F3vpMgBB?=
 =?us-ascii?Q?p1F/UhDbzbboIOsi1izYxvkrGn4IR63iSMqplwiTCT736csLTgbN1EEj/sql?=
 =?us-ascii?Q?lM4o71NEgR3V0Jl2QESe6ORRwSr7zSF17UmiP83r1Z8e2BmaGMm/NGEbb6iL?=
 =?us-ascii?Q?bIKAsAiiM4syUr7FhBinEdFvCm76vJ0GmFd7+HXkU+simD7PTYg0X9rYFg0u?=
 =?us-ascii?Q?sP8KQZQnfHLmB7cMKL8EE50NosVgb6TxhH3gGQqLlKPdYipJnXmE/fU5E7C6?=
 =?us-ascii?Q?86NgGGZEALdc439nT6Gg8NN/KQFcrXntHriEPJedoH6cVjXZPAOD6VF8D3N6?=
 =?us-ascii?Q?Z/G0hye8pr3X9xGeBrIPpNKtBdIlQMhEJh4ig06NAJmSUCeLhkcySq59gfOk?=
 =?us-ascii?Q?PEKJyJ0UiQDB/17S3i/j+UNDrWE/TErQywDi6TJ618/n07IVoYUK8CU2+lMS?=
 =?us-ascii?Q?abKPPoQocKUii1nasn9MAe7yWoSy3F5B8mEPr8srwp8QkvP1q66kMHPLdkKB?=
 =?us-ascii?Q?iWUQOCxo5+W5mRW5kMsxmts3EJXkl0VUcNXJ5DM7qdJpe0l5UA56Lkq4wMC3?=
 =?us-ascii?Q?+r7BSVfoBEtz8q5PSuLF9QzTkyvXUl6U58KUwsjqBGaSnEFV7G5dXZorhLiS?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5067f1c3-9328-46e6-f0ea-08dc1e390a3a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 06:35:51.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAXwhIX/Ad12/AWhXy0kaUom5ovPQv1zKsVty8mjQ7l3wPm2YDKXTzR5JO5LjXrFAU48nKXg+0FasJX06cJO1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6244
X-OriginatorOrg: intel.com

hi, Catalin,

On Thu, Jan 25, 2024 at 12:01:56PM +0000, Catalin Marinas wrote:
> On Thu, Jan 25, 2024 at 03:34:37PM +0800, kernel test robot wrote:
> > kernel test robot noticed "kernel-selftests.kvm.memslot_perf_test.fail" on:
> > 
> > commit: 39042079a0c241d09fa6fc3bb67c2ddf60011d0f ("kmemleak: avoid RCU stalls when freeing metadata for per-CPU pointers")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> [...]
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240125/202401251429.d3dea02b-oliver.sang@intel.com
> [...]
> > # Testing RW performance with 1 runs, 5 seconds each
> > #
> > not ok 71 selftests: kvm: memslot_perf_test # TIMEOUT 120 seconds
> 
> I'm not sure how this relates to kmemleak, especially the commit above.
> It might as well be that the above kmemleak commit increases the system
> load and you trip over the timeout above. Is it still reproducible with
> a larger timeout (unfortunately I don't have the hardware to try to
> reproduce the problem)?
> 
> I can see a lockdep warning in the dmesg but that doesn't look related
> to kmemleak.

below things FYI.

(1) we set same timeout for 39042079a0 and its parent, test always can pass
on parent (by 20 runs), but almost always fail on 39042079a0 (18 out of 20
runs fail).

(2) while running tests, we use a kmemleak monitor.
for parent runs, seems no problem, but for 39042079a0 runs, it will capture
below log:

$ cat kmemleak
unreferenced object 0xff110001198a1720 (size 16):
  comm "swapper/0", pid 1, jiffies 4294783051
  hex dump (first 16 bytes):
    41 43 50 49 20 48 4d 41 54 00 6b 6b 6b 6b 6b a5  ACPI HMAT.kkkkk.
  backtrace (crc 45396b86):
    [<ffffffff81a97e28>] __kmem_cache_alloc_node+0x228/0x310
    [<ffffffff81936de5>] __kmalloc_node_track_caller+0x55/0xf0
    [<ffffffff819160b4>] kstrdup+0x34/0x60
    [<ffffffff81aada3b>] mt_set_default_dram_perf+0x3cb/0x460
    [<ffffffff8658a9a6>] hmat_init+0x2b6/0x3a0
    [<ffffffff81002c58>] do_one_initcall+0xd8/0x410
    [<ffffffff864aaa4a>] do_initcalls+0x1ca/0x390
    [<ffffffff864ab53e>] kernel_init_freeable+0x8ce/0xc80
    [<ffffffff83beed8f>] kernel_init+0x1f/0x1d0
    [<ffffffff810a07c1>] ret_from_fork+0x31/0x70
    [<ffffffff81006341>] ret_from_fork_asm+0x11/0x20

(3) we tried to disable the kmemleak monitor for 39042079a0, then
memslot_perf_test can pass now. there is no kmemleak dump.

(4) we also noticed a test can pass on 39042079a0 now, but always fail on
parent, no matter kmemleak monitor enable or disable.
(normally we won't report a commit if it makes some test start to pass, so this
information is not in original report)

f67f8d4a8c1e1ebc 39042079a0c241d09fa6fc3bb67
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :20         150%          30:30    kernel-selftests.kvm.rseq_test.pass

> 
> -- 
> Catalin

