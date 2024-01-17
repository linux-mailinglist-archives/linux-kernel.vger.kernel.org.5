Return-Path: <linux-kernel+bounces-29124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E80183092F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15321282479
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E41421356;
	Wed, 17 Jan 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8LbW17e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7ED2110F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504085; cv=fail; b=b67pPT17oZboPMUSdg7etMulQ9r+84xtpc1oMLgNZ5nFqqVc0VbUpmqaZiFEWhj9PpdxUQIBSl7jjQK5/v3pT1Vsbx96An8Nw/xmx3VMGQ0TFTcr0+wKBOn51gNeRj4cGIA6Dz8+ICsZqBU0JrR0UOOXrGoMyX7PZ+JInGorALE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504085; c=relaxed/simple;
	bh=pN3zhCIBPB2Px3ozTF6jjl8pIsc+ncYGAvDBaqZvf40=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=PqYNgbhj2NyNIY5PaoKFCm1a89/+z4uZs17rGigNqsmBhkmdYqRz7VVFxRhSBUTmSxQojhQomH8b2RODtOlp+1bAZyAPvOdGcQidkEDjLJyQHh+oUIOJKcVOcDgUZjr51I/I0G8JDqmnA4oCDvAEcd3eVNdM1rsdA2x+YQVTtAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8LbW17e; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705504084; x=1737040084;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pN3zhCIBPB2Px3ozTF6jjl8pIsc+ncYGAvDBaqZvf40=;
  b=j8LbW17e4pukDcXBxkMT7ysy3ZLlN96lt5+AHpQtJwq4ynIU2G620fi5
   NdEV3xrxNSoytZQuTNXeB4UyME45LvrBEOKVlLPDIlq3ye3xrBap6k+e9
   ++6VkLgdTMBEoQ5N/da9jm3/D27zyKM7a0Yh/rBjMtAWfzNgGG+Mi+TXJ
   PM2VvOi2LT2493PqI/mCYGZM8wkC+zUy5DBUp1itqi8hAfaL1HbgiEoUM
   +KD0ehTdOHcCO7lkr5uev4jGgJFXm5MnzizG7PtFoLqe/NOmxZ7d/UtT9
   m3XBpeL1l5sZdeIsqK9SYs0rFaK0Db6qHieZolXd4dGmbG9bvsLe6iyNQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6891755"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="6891755"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 07:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="907778466"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="907778466"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 07:07:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 07:07:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 07:07:47 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 07:07:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoIx40LZdseGgpjcywlsMQLPwhSnoX0TeGgg+uOLFjldDLoQe/Vf3GC1J2EMOpmcD4Mv6puomUUAuZQlCgb+V6Y4eiYHQSTpx0RU5ZcWJjSvWPeAmYbhC3H38CQPuPA3rn5XgY99pCtwqfJNwkMYV3x8TNiHU16+73w18wqnD0i3/mNtz7mNYvdESbROH4XEsvZw3FhOls5UgDkvd+J7VcgmXSChPu5C93vaFQL0M+Ef3E0Bc8RmPYKvtv0tHodwWHj6kkITQa+CpW/3Cl59aijRTYh3A37MOMR43EvBOA46aNpwVnAvPVlDhGlSI02jZtwXlicNkdO5ndxPTjsEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SD5x4nkINOXVuL6rVQCofMywSRvOUS6bec3ScSlnui8=;
 b=aYBPOlr5OnFJoVjrtcDIsn5c+B3VxELDE2ffKvMXjOSt6LqfGJx+IqIFNZpW6dpdeCtfzUrc0MRQu+rfJoKbklF288LWmIHKwsfMj+L/f37xNlkKK06SiVBqGvRRO4ahdNzszMB+T6/jews9qazVMjv57AG3lyxLgIkteSBEzHrQVhIVU11hgTdwcZ/UOYeo4w2cIc9Vu9LdhVyJBkGnBvxaUY4+Ka6zmcNHWy3IRSEIvgxbvSoRKaYfRWQ89lfMCCjQ4FdAxpd1TaysZU/SBygqqM/DeK7SMml1650fxBa+PoDCqgE6IjrE07+a4l8P6AV15OqNtOwxq25bdn33Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8744.namprd11.prod.outlook.com (2603:10b6:408:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 17 Jan
 2024 15:07:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Wed, 17 Jan 2024
 15:07:22 +0000
Date: Wed, 17 Jan 2024 23:07:14 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>, <linux-afs@lists.infradead.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [afs]  f94f70d39c: WARNING:suspicious_RCU_usage
Message-ID: <202401172243.cd53d5f6-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TYAPR01CA0156.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::24) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e461e8-842d-4f21-1b29-08dc176e01ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3Wg0EWrYVVcF36ZzOzD+A0A+QOOZlLrmSLsj+Gv9l5OzqDBMhxzA1g0HW2M3uzE/M1T1Hy2n3Ebn1RW4R5FuIqmIj1V7vP/kHLyV2BtDoHLspJmT+rF7+nLOnRk2Aw+4fm1MlisdCHNNrjA8/YfSPtqc5e+gc6IeRxlFFY9liAtTFd+xfc3u7PB1GHCLSw7S42F81DcN9gKp3UKTrWE52yNSUnkkUjXue44mA2XBh55jY7wsCAHZF055Qxi1+EKS4XGa/UgtsNXD6ztRXTr9t2YqNUOeOnLZH+ZFfeYrUqoCzezCprKLnCVlzvsmtd/mxfKo04TqXrjfzaaa5x6asHDJoalZ+e7sH7h8iduFkXvWGdnVEY2PMt7jnfcICN5dETSMBti6pbv1vzv6LyKxZnChduBqMqjzjEbrGxSE1LRIi05LVTfrJ/etkcC2Z3s/PcP7n4VAP656lKW4b4CyZkDUSI4yN3GX3CMFoSxNCwrrJN1PA9LWdojLeeLZ92AOGc/DcItFcMIEMAA9wxgoP5Jz2u7F9JlDYwgtF8GtgAw3ByCffYs+wuSc/cSCkmW12oHX5Qg+uWwNFFIW5ZQP76+XD81NyF5rYL+dPWqZuhPqR1otCQwK35JR7cgtT/Uyd148yqA8QQEU+bpK8kMcc36b3DsCrVZasTaHt84SsXGXiBDCN8mm3PnZUtuInyS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(396003)(39860400002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(186009)(1800799012)(451199024)(36756003)(86362001)(82960400001)(83380400001)(8936002)(8676002)(4326008)(2616005)(1076003)(38100700002)(26005)(107886003)(6666004)(6512007)(6506007)(45080400002)(478600001)(6486002)(6916009)(66946007)(66556008)(66476007)(316002)(966005)(5660300002)(30864003)(41300700001)(2906002)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tr/lE+Qr1nb8JcoPjl0SU5LJa/H91XPc1SrtzTiI6KxCm6tNOdYkw1caH4+c?=
 =?us-ascii?Q?zxa1dJa+AklpVC0/d8yv1ap8qKTfs7Ylt9GFJGD4IYum7UrgIYfEeU9/zesZ?=
 =?us-ascii?Q?TvTj2vf71+i1ULPxWYbRumds4bEfZsMMciV50OrH1gdp+S2/BJMEzcBYqMU+?=
 =?us-ascii?Q?Igh+uevj7+WJDZts7lWx//UJyl801RtVb1WymjmCz/WMg/ca6i7VzCX/QWMz?=
 =?us-ascii?Q?In/FbNxBqbfskmiuNKovWAVSZDH9BZe+NtxWZBvgO4nO/14YvyrPsnUFefD5?=
 =?us-ascii?Q?xVaHHAjm82wFJ0pGJEsFTUawUtP6rT0JjRZg3mGUErOQR74sUHCpB1dVeRcP?=
 =?us-ascii?Q?LSTGh0Y/rCdVXUhDxQsxGkXdNVqTITqWaDdAq3S9XAndBYd/wEnPjt08rc0X?=
 =?us-ascii?Q?+Pyxvigs2cfqcStyAIQNWcdHJKp/dhtwgZuhJVmoeN23lE8yeu2srzfWkpU2?=
 =?us-ascii?Q?XRluTYYtX6QTEulCMGTVRfKOSwub2CQoi8F2BYgstGFxYYyCa3nLiYSYOyRu?=
 =?us-ascii?Q?KTz04RfeI81kHBcnCDnEACcP6SjmSZ5qk8+pfEe3jkWQYZkHW9Gvb7V08T0P?=
 =?us-ascii?Q?STa/NLH/C7skmXLXZIK76kU82LHbaWM4KzUqypqli01MCK/TkuyU+HVxHcQC?=
 =?us-ascii?Q?OBZEzK1Y6lA71e/I+Ys6P/6I5NhmTtqE70Gkd0Lfq81Qo2nLgx72OxjReDw3?=
 =?us-ascii?Q?QWJ2v4fixPOz46Mt2rPaWCqvDTVKY/u0tIOBLWmNWUaM93EaVvWJ7OybfyQy?=
 =?us-ascii?Q?5hJmc4dl45+Xrv112s7iJ689kz24ybOf6bpzNvS5rtW+tG1DOImBLBIOyJp0?=
 =?us-ascii?Q?x41GVLHAg+ogiewhlnpDWTx8nAOLCLvlt2uOs5TkYSeg5rXKJRKYo24c45Rs?=
 =?us-ascii?Q?6Je7DbvsvXMRfPeYkTW+3EtRE2Jco9gAOK4q6sLT55h2oyZvI1w+anl6fmIT?=
 =?us-ascii?Q?lnZfNjp+CArF5jKLxheWYvjoVAu89O+vj/Olqk3IW5XOTidJWuZlhZwWvXgS?=
 =?us-ascii?Q?r8oDj1pmannIB1JuSD1f/8jHkxdklIllRJyipP5h6BKbYBiBla7LUhLwtOUU?=
 =?us-ascii?Q?4Qge/tFHunFadsSj8bwM1zy8/5hALL57PEn8PhrYPUGb9n2zk96ooO/PX5rt?=
 =?us-ascii?Q?rMVbomW59hLntjCqk6w23Tl5xrsvIZQyLJBdv6ll/WNT2sYaFVFo23OcSRyM?=
 =?us-ascii?Q?qddVvmNDm7IGXINzpsmCh6UBi0D+qA2jCEPxFNiAcQGAjI45zwkY6uMTe+p+?=
 =?us-ascii?Q?g6eLMe2k1SVECIF9JzsHGtBponK+YbH9cc8vd83JAToNvt0UD86bi5l2zDjC?=
 =?us-ascii?Q?7TYASbS7f7+Ww40euwCr0Fj+7K+HFznp8tYqMdNabpwaITR9sOQneQuBwE5/?=
 =?us-ascii?Q?ZVSKs/7rvlCBjbEjsdbPfrkp+50kHMbctFTXCx4cNaADv4TxjwxHN8LjM8ql?=
 =?us-ascii?Q?48I9pGg0aHHQArfchIZm2uvtKmVxN7g5YnWrGTyZzuG07zETL49ZK0ANMKxj?=
 =?us-ascii?Q?b4wcqLpGGhzCfAHeryZW4CovPJc37i5nzffdgW5v2EFjHoFX5x2bGNjBF1vk?=
 =?us-ascii?Q?d68RcUQhfLi5QRuet88Bjz++fiV7FL8IwTRcCcLR1R7H1f+CIBmlR1zlDe7s?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e461e8-842d-4f21-1b29-08dc176e01ef
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 15:07:22.8494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wr0U9nqukwlVR9+4rMGq5IJ7/Sep5+Cq77hPcxmLtxyxh4sI/uZTSZ+HIriCwQUccAazH2EEPqm8iExE+t6y3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8744
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: f94f70d39cc2d54079ebae934862198516315db2 ("afs: Provide a way to configure address priorities")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 052d534373b7ed33712a63d5e17b2b6cdbce84fd]
[test failed on linux-next/master 8d04a7e2ee3fd6aabb8096b00c64db0d735bc874]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-01
	nr_groups: 5

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401172243.cd53d5f6-oliver.sang@intel.com


[  463.480579][ T6166] 
[  463.481694][ T6166] =============================
[  463.482931][ T6166] WARNING: suspicious RCU usage
[  463.484158][ T6166] 6.7.0-rc7-00024-gf94f70d39cc2 #1 Tainted: G        W        N
[  463.485385][ T6166] -----------------------------
[  463.486196][ T6166] include/linux/rcupdate.h:373 Illegal context switch in RCU read-side critical section!
[  463.488096][ T6166] 
[  463.488096][ T6166] other info that might help us debug this:
[  463.488096][ T6166] 
[  463.490824][ T6166] 
[  463.490824][ T6166] rcu_scheduler_active = 2, debug_locks = 1
[  463.493075][ T6166] 3 locks held by trinity-c4/6166:
[  463.494415][ T6166]  #0: eafe0bac (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x42/0x64
[  463.496294][ T6166]  #1: ca58af5c (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0x43/0x470
[  463.497496][ T6166]  #2: c42177b0 (rcu_read_lock){....}-{1:2}, at: afs_proc_addr_prefs_show+0x28/0x284
[  463.499479][ T6166] 
[  463.499479][ T6166] stack backtrace:
[  463.500797][ T6166] CPU: 1 PID: 6166 Comm: trinity-c4 Tainted: G        W        N 6.7.0-rc7-00024-gf94f70d39cc2 #1 8c9fc74f21af2a18f53bcba9406b4039ea273cf9
[  463.503266][ T6166] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  463.505486][ T6166] Call Trace:
[  463.506253][ T6166]  dump_stack_lvl+0x9a/0xdc
[  463.507029][ T6166]  dump_stack+0xd/0x14
[  463.507855][ T6166]  lockdep_rcu_suspicious+0x127/0x16c
[  463.508791][ T6166]  __might_resched+0x284/0x2b4
[  463.509656][ T6166]  __might_sleep+0x2e/0x80
[  463.510560][ T6166]  __might_fault+0x29/0x78
[  463.511471][ T6166]  _copy_to_iter+0x2e/0x560
[  463.512204][ T6166]  ? __check_heap_object+0x32/0xc8
[  463.513205][ T6166]  ? check_heap_object+0x16b/0x19c
[  463.514017][ T6166]  ? __check_object_size+0x5e/0x118
[  463.515030][ T6166]  seq_read_iter+0x3bc/0x470
[  463.515900][ T6166]  seq_read+0x7f/0x9c
[  463.516669][ T6166]  ? seq_read_iter+0x470/0x470
[  463.517552][ T6166]  proc_reg_read+0x60/0x90
[  463.518321][ T6166]  ? proc_reg_write+0x90/0x90
[  463.519126][ T6166]  do_loop_readv_writev+0x4a/0xb4
[  463.520161][ T6166]  do_iter_read+0x105/0x170
[  463.521040][ T6166]  do_readv+0xac/0x190
[  463.521836][ T6166]  __ia32_sys_readv+0x12/0x18
[  463.522679][ T6166]  __do_fast_syscall_32+0x72/0xd8
[  463.523573][ T6166]  ? find_held_lock+0x24/0x74
[  463.524397][ T6166]  ? __lock_release+0x4a/0x14c
[  463.525397][ T6166]  ? __task_pid_nr_ns+0x78/0x1fc
[  463.526245][ T6166]  ? syscall_exit_work+0xe8/0x11c
[  463.527101][ T6166]  ? lockdep_hardirqs_on_prepare+0xa4/0x154
[  463.528145][ T6166]  ? syscall_exit_to_user_mode+0x3a/0x50
[  463.529118][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.529997][ T6166]  ? syscall_exit_to_user_mode+0x3a/0x50
[  463.530959][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.531870][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.532739][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.533630][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.534507][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.535362][ T6166]  ? irqentry_exit_to_user_mode+0x28/0x2c
[  463.536356][ T6166]  ? irqentry_exit+0x7f/0xc8
[  463.537187][ T6166]  do_fast_syscall_32+0x29/0x60
[  463.538014][ T6166]  do_SYSENTER_32+0x15/0x28
[  463.538782][ T6166]  entry_SYSENTER_32+0xa2/0xfb
[  463.539573][ T6166] EIP: 0xb7f97579
[  463.540223][ T6166] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[  463.543212][ T6166] EAX: ffffffda EBX: 000000f0 ECX: 026d6120 EDX: 00000098
[  463.544449][ T6166] ESI: 28282828 EDI: f0309dea EBP: 000000c2 ESP: bfa8f62c
[  463.545572][ T6166] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[  463.546837][ T6166] BUG: sleeping function called from invalid context at lib/iov_iter.c:185
[  463.548162][ T6166] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6166, name: trinity-c4
[  463.548958][ T6166] preempt_count: 1, expected: 0
[  463.549406][ T6166] 3 locks held by trinity-c4/6166:
[  463.550089][ T6166]  #0: eafe0bac (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x42/0x64
[  463.551473][ T6166]  #1: ca58af5c (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0x43/0x470
[  463.552840][ T6166]  #2: c42177b0 (rcu_read_lock){....}-{1:2}, at: afs_proc_addr_prefs_show+0x28/0x284
[  463.554393][ T6166] CPU: 1 PID: 6166 Comm: trinity-c4 Tainted: G        W        N 6.7.0-rc7-00024-gf94f70d39cc2 #1 8c9fc74f21af2a18f53bcba9406b4039ea273cf9
[  463.555905][ T6166] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  463.557701][ T6166] Call Trace:
[  463.558373][ T6166]  dump_stack_lvl+0x9a/0xdc
[  463.559211][ T6166]  dump_stack+0xd/0x14
[  463.560000][ T6166]  __might_resched+0x13d/0x2b4
[  463.560840][ T6166]  __might_sleep+0x2e/0x80
[  463.561674][ T6166]  __might_fault+0x29/0x78
[  463.562476][ T6166]  _copy_to_iter+0x2e/0x560
[  463.563270][ T6166]  ? __check_heap_object+0x32/0xc8
[  463.564106][ T6166]  ? check_heap_object+0x16b/0x19c
[  463.565052][ T6166]  ? __check_object_size+0x5e/0x118
[  463.565935][ T6166]  seq_read_iter+0x3bc/0x470
[  463.566735][ T6166]  seq_read+0x7f/0x9c
[  463.567450][ T6166]  ? seq_read_iter+0x470/0x470
[  463.568297][ T6166]  proc_reg_read+0x60/0x90
[  463.569119][ T6166]  ? proc_reg_write+0x90/0x90
[  463.569926][ T6166]  do_loop_readv_writev+0x4a/0xb4
[  463.570855][ T6166]  do_iter_read+0x105/0x170
[  463.571623][ T6166]  do_readv+0xac/0x190
[  463.572011][ T6166]  __ia32_sys_readv+0x12/0x18
[  463.572437][ T6166]  __do_fast_syscall_32+0x72/0xd8
[  463.572890][ T6166]  ? find_held_lock+0x24/0x74
[  463.573320][ T6166]  ? __lock_release+0x4a/0x14c
[  463.573791][ T6166]  ? __task_pid_nr_ns+0x78/0x1fc
[  463.574233][ T6166]  ? syscall_exit_work+0xe8/0x11c
[  463.574682][ T6166]  ? lockdep_hardirqs_on_prepare+0xa4/0x154
[  463.577047][ T6166]  ? syscall_exit_to_user_mode+0x3a/0x50
[  463.577546][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.578005][ T6166]  ? syscall_exit_to_user_mode+0x3a/0x50
[  463.578496][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.578954][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.579408][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.579868][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.580330][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.580796][ T6166]  ? irqentry_exit_to_user_mode+0x28/0x2c
[  463.581306][ T6166]  ? irqentry_exit+0x7f/0xc8
[  463.581726][ T6166]  do_fast_syscall_32+0x29/0x60
[  463.582160][ T6166]  do_SYSENTER_32+0x15/0x28
[  463.582581][ T6166]  entry_SYSENTER_32+0xa2/0xfb
[  463.583021][ T6166] EIP: 0xb7f97579
[  463.583376][ T6166] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[  463.585266][ T6166] EAX: ffffffda EBX: 000000f0 ECX: 026d6120 EDX: 00000098
[  463.585879][ T6166] ESI: 28282828 EDI: f0309dea EBP: 000000c2 ESP: bfa8f62c
[  463.586476][ T6166] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[  463.587208][ T6166] 
[  463.587463][ T6166] =============================
[  463.587892][ T6166] [ BUG: Invalid wait context ]
[  463.588326][ T6166] 6.7.0-rc7-00024-gf94f70d39cc2 #1 Tainted: G        W        N
[  463.588990][ T6166] -----------------------------
[  463.589774][ T6166] trinity-c4/6166 is trying to lock:
[  463.590685][ T6166] edb6caf8 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0x33/0x78
[  463.592172][ T6166] other info that might help us debug this:
[  463.593196][ T6166] context-{4:4}
[  463.593900][ T6166] 3 locks held by trinity-c4/6166:
[  463.594815][ T6166]  #0: eafe0bac (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x42/0x64
[  463.596352][ T6166]  #1: ca58af5c (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0x43/0x470
[  463.597784][ T6166]  #2: c42177b0 (rcu_read_lock){....}-{1:2}, at: afs_proc_addr_prefs_show+0x28/0x284
[  463.599462][ T6166] stack backtrace:
[  463.600186][ T6166] CPU: 1 PID: 6166 Comm: trinity-c4 Tainted: G        W        N 6.7.0-rc7-00024-gf94f70d39cc2 #1 8c9fc74f21af2a18f53bcba9406b4039ea273cf9
[  463.602527][ T6166] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  463.604314][ T6166] Call Trace:
[  463.604966][ T6166]  dump_stack_lvl+0x6a/0xdc
[  463.605815][ T6166]  dump_stack+0xd/0x14
[  463.606518][ T6166]  __lock_acquire+0x819/0xab4
[  463.607301][ T6166]  ? handle_exception+0x14d/0x14d
[  463.608188][ T6166]  lock_acquire+0x88/0x24c
[  463.609025][ T6166]  ? __might_fault+0x33/0x78
[  463.609885][ T6166]  ? dump_stack+0xd/0x14
[  463.610678][ T6166]  ? __might_resched+0x149/0x2b4
[  463.611570][ T6166]  __might_fault+0x52/0x78
[  463.612346][ T6166]  ? __might_fault+0x33/0x78
[  463.613091][ T6166]  _copy_to_iter+0x2e/0x560
[  463.613884][ T6166]  ? __check_heap_object+0x32/0xc8
[  463.614734][ T6166]  ? check_heap_object+0x16b/0x19c
[  463.615576][ T6166]  ? __check_object_size+0x5e/0x118
[  463.616409][ T6166]  seq_read_iter+0x3bc/0x470
[  463.617267][ T6166]  seq_read+0x7f/0x9c
[  463.617968][ T6166]  ? seq_read_iter+0x470/0x470
[  463.618746][ T6166]  proc_reg_read+0x60/0x90
[  463.619605][ T6166]  ? proc_reg_write+0x90/0x90
[  463.620463][ T6166]  do_loop_readv_writev+0x4a/0xb4
[  463.621425][ T6166]  do_iter_read+0x105/0x170
[  463.622206][ T6166]  do_readv+0xac/0x190
[  463.622979][ T6166]  __ia32_sys_readv+0x12/0x18
[  463.623772][ T6166]  __do_fast_syscall_32+0x72/0xd8
[  463.624696][ T6166]  ? find_held_lock+0x24/0x74
[  463.625509][ T6166]  ? __lock_release+0x4a/0x14c
[  463.626438][ T6166]  ? __task_pid_nr_ns+0x78/0x1fc
[  463.627291][ T6166]  ? syscall_exit_work+0xe8/0x11c
[  463.628124][ T6166]  ? lockdep_hardirqs_on_prepare+0xa4/0x154
[  463.629190][ T6166]  ? syscall_exit_to_user_mode+0x3a/0x50
[  463.630134][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.631033][ T6166]  ? syscall_exit_to_user_mode+0x3a/0x50
[  463.631985][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.632844][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.633769][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.634643][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.635509][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.636422][ T6166]  ? irqentry_exit_to_user_mode+0x28/0x2c
[  463.637387][ T6166]  ? irqentry_exit+0x7f/0xc8
[  463.638147][ T6166]  do_fast_syscall_32+0x29/0x60
[  463.639006][ T6166]  do_SYSENTER_32+0x15/0x28
[  463.639801][ T6166]  entry_SYSENTER_32+0xa2/0xfb
[  463.640619][ T6166] EIP: 0xb7f97579
[  463.641254][ T6166] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[  463.644248][ T6166] EAX: ffffffda EBX: 000000f0 ECX: 026d6120 EDX: 00000098
[  463.645377][ T6166] ESI: 28282828 EDI: f0309dea EBP: 000000c2 ESP: bfa8f62c
[  463.646509][ T6166] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[  463.647839][ T6166] BUG: scheduling while atomic: trinity-c4/6166/0x00000002
[  463.648647][ T6166] INFO: lockdep is turned off.
[  463.649073][ T6166] Modules linked in:
[  463.649442][ T6166] CPU: 1 PID: 6166 Comm: trinity-c4 Tainted: G        W        N 6.7.0-rc7-00024-gf94f70d39cc2 #1 8c9fc74f21af2a18f53bcba9406b4039ea273cf9
[  463.651023][ T6166] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  463.652664][ T6166] Call Trace:
[  463.653262][ T6166]  dump_stack_lvl+0x9a/0xdc
[  463.654054][ T6166]  dump_stack+0xd/0x14
[  463.654530][ T6166]  __schedule_bug+0x5e/0x84
[  463.655373][ T6166]  schedule_debug+0x1e3/0x218
[  463.656163][ T6166]  __schedule+0x4d/0x774
[  463.656896][ T6166]  schedule+0x3b/0x130
[  463.657618][ T6166]  exit_to_user_mode_prepare+0xb9/0x1f0
[  463.658529][ T6166]  syscall_exit_to_user_mode+0x1a/0x50
[  463.659522][ T6166]  __do_fast_syscall_32+0x7c/0xd8
[  463.660434][ T6166]  ? find_held_lock+0x24/0x74
[  463.661236][ T6166]  ? __lock_release+0x4a/0x14c
[  463.662112][ T6166]  ? __task_pid_nr_ns+0x78/0x1fc
[  463.662933][ T6166]  ? syscall_exit_work+0xe8/0x11c
[  463.663835][ T6166]  ? lockdep_hardirqs_on_prepare+0xa4/0x154
[  463.664901][ T6166]  ? syscall_exit_to_user_mode+0x3a/0x50
[  463.665826][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.666757][ T6166]  ? syscall_exit_to_user_mode+0x3a/0x50
[  463.667763][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.668716][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.669590][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.670485][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.671345][ T6166]  ? __do_fast_syscall_32+0x7c/0xd8
[  463.672263][ T6166]  ? irqentry_exit_to_user_mode+0x28/0x2c
[  463.673209][ T6166]  ? irqentry_exit+0x7f/0xc8
[  463.673998][ T6166]  do_fast_syscall_32+0x29/0x60
[  463.674808][ T6166]  do_SYSENTER_32+0x15/0x28
[  463.675583][ T6166]  entry_SYSENTER_32+0xa2/0xfb
[  463.676478][ T6166] EIP: 0xb7f97579
[  463.677205][ T6166] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[  463.680209][ T6166] EAX: 00000009 EBX: 000000f0 ECX: 026d6120 EDX: 00000098
[  463.681363][ T6166] ESI: 28282828 EDI: f0309dea EBP: 000000c2 ESP: bfa8f62c
[  463.682516][ T6166] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240117/202401172243.cd53d5f6-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


