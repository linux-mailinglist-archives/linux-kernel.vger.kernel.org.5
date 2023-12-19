Return-Path: <linux-kernel+bounces-5510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AF6818B83
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3DF1C24863
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D671CABC;
	Tue, 19 Dec 2023 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmbHu4DK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D513B1D54B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703000823; x=1734536823;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gPlxLFd0RRVgKFoGkF8jb19jURkj1FkHqNpUJYE8/Dc=;
  b=cmbHu4DK1mZ+aJk26nYIZC1AMaWdmFRctBXgzlXLc2QHkYZwhnOQ92Bw
   kuJBhEyAu6AJq4Fhy+Oo7cPcC0ZHnbd8n1+WCNdErSO6lb4ghyXcIvHHo
   yMtKrd3YOzlWHIMMAZdyUYDj6j4ABAszfemVyfOx+HmfNCW+1UMDhk3R4
   uFL3lM4+3wkZs9eKx9VMxPggIhbCdzGrwrPXB7DuW+qOvILc8Gqz2JJpD
   WD4WjWfzbOYMTGa4Y+1YBMpdjYXKbuclC/81qwQhh00ivvuAGl/B+2afN
   7pjiWaxxkOhdWjcjcF+czMJtsVyTHvdJzl/3YQlA7D+gTFgFvyYbnQGBU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="399509499"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="399509499"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:47:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="776020954"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="776020954"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 07:47:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 07:47:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 07:47:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 07:47:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doCbXhO1rmbtMwnPHBWzATdWIlBgtG0WVEwd+7VMT27A7nceuuQdAAvUarsEmL3g2509FUB1HrTwOCQfG5fjcTXh1bgNpsNT3HL+EBD3pu/zksy0Bg/Las5BYnet67qR5NOC/6lBsAxkswKXUSGhaB2YTzfup/cvzTYy2lPwwUK053to8+idldzP2TWKPjSjSalZLwxDiAc/58EVyubXohN4/2gho8vobMaXek/ErONYvZblp1Cq9aGLOffyYZDKTGhAblvF2kAv6XzK+S1NVAhP2aflYJflsdXul5lFTUh7n/wU4ARLciPkPpJGQ2Aag+InWVEki9bA2qW7F5IktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FumAgl4o265RBfJXsea1Qtlr/g9DvV871HLDGgjsE/I=;
 b=bYgeAiAvO4WwKYFGI85/P6thP7tv7jUa3LB13qV0mDh4aJzu6gk7l9vJweFfv3uR9pzQfDrKquvXikftakI9gMKHD83s6LFb2ukDY9H2fZzMnhTf/nXyx88W4sx2a2G2JFD1wbbY3MHZuDCoxCEE6xE7Drct3TBCuP8FshlrCYXN9KPvlv/HSoILYDd8CE8kByKgcBsmkSsoTRF/NA+03ic7WDKvIluRejaQZpJdtDLHxyblSw439WeqDBmOXe2/4+h87mb/L9QA62uZsCi77q9xDJWo6VYLdd2OqVed5fFZY8xPyOPO3zkqtUFeXC35zdoOI9TK8B9pkWki138L1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7480.namprd11.prod.outlook.com (2603:10b6:510:268::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 15:46:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 15:46:58 +0000
Date: Tue, 19 Dec 2023 23:46:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@redhat.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [mm]  bbcbf2a3f0: kernel_BUG_at_mm/memory.c
Message-ID: <202312192319.fa8f5709-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 21885c40-d5da-4717-64e2-08dc00a9bc20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9o+ZtOcrzhh/h3vwoBSQD9OpQuwCNk8mHq2OQHhy/nQhXV+0CmhQb4D9PIkSVXuFSzMPhEIOfPmR/X8Om2f73L/4Q0OVuh0SeWNaaRBpVgdN6U4f8pgREo0ffTJnqwHw+ag1GOK05Ub6dGUUO6VD6hDyfNpx37MVjf7DeSbY/LB0cA8xpFsVckxI24A/eEcIqM8giUmtKYdCoTR7rJEk1CzIahLkNTzjyi70eLXKrWoldSlJDQH8Pa1hlObupDwq1gqsfSTUgrTGBS0xQkNWScqRe1mVPznYiI0nmumR1p6RQB7ENBsbUbfEZT5TtaIdOu0gntcsiBlI8LkMIZoIlHN4CjxWlbCmS+0hs3yIl03m8l33eXDZv9woFzTmc2lNyoDM6+SHJCotczaVIPzavi77QtcZckOn2FPiiyQZsVINQ71AsXdO0ln0NOamFXYCPx8xFxnn9VC7VPcrX8ueqz2PSqX9PTkemKfE0avM2xBaP+C65gtR4QNNKjmCnfcAxcLul9OhiPl5ueBcW+l91oUrifqSoZ7y1cg1GXfWP2rpzVfRhLkbuZwlFoNtfjDYfFok97Wp67ueYuJsYsw9zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(45080400002)(2616005)(1076003)(6666004)(6506007)(107886003)(6512007)(38100700002)(82960400001)(86362001)(36756003)(4326008)(8676002)(8936002)(41300700001)(478600001)(5660300002)(2906002)(83380400001)(966005)(66946007)(6916009)(6486002)(316002)(54906003)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kIhczwzNlVjsioLX8MO8HMiiaeZLaYVyOHRS7vXJBbJX2CuwhXzTqj43HXG0?=
 =?us-ascii?Q?H+ij22cQECS4fZjtRzAfsI5yBpp2oF7/C7gA87T8RKRSzZzVg9Lmzj4MXkWr?=
 =?us-ascii?Q?Eirr3hv9Ilv1iWPKtG4RkK685BXOJU7qiIzDE57QSoG7QS6CFN2POSt2g+YH?=
 =?us-ascii?Q?crQfE0xzDus1Z5tv3VS+xYDnOkdnP+5Y4Cn4aQIGxj6Lsgy98rYchJViC9xL?=
 =?us-ascii?Q?K9xvOJMXS2IqE+UQDUkWofkaxXpua2/t/4AhnJxNypdFklUdHoSQ/LS15jhV?=
 =?us-ascii?Q?/DhwTR92+BiV/TtFd4uL/5mZ8fDRNNgYVDuCKe9TtprVvLjqXLNXaRh6KUdn?=
 =?us-ascii?Q?bQUJ2hkGheAoxsiWVDYGmLKeVsFpn0bV84w+0eJPJfNS+REP+c5ddNdSidoZ?=
 =?us-ascii?Q?U2Wjeu80M2/b4tJXZiWwWSa09Xj3anY4t7RCZ54m+0jq82o7bx00ECmPOD5O?=
 =?us-ascii?Q?H6Pm/0hkS4jEZLVpYuHO+jMDE9XYfLOa7XzU7V9iLfQXIRmzj3AnWuB/0H8s?=
 =?us-ascii?Q?wqT3y7uYLFvYNGPce0btBmhFpipHlVAUDCn3fAOWq4HWOa0UM0yrOT4wpHm7?=
 =?us-ascii?Q?gd2KZi0zGxsvKFUQRhsrnaNQ/+Z3h1mHcH8NHEzb8Bkb9i4l65yFbAo/J2v2?=
 =?us-ascii?Q?j9WqwtIejzjRfL5/1ooRabDdYWATrWHHPJulBtOAo9KJGUr9LICE6Lxny6Ho?=
 =?us-ascii?Q?lx5Dqj9r+YX8kDIOy5b+fkWFl/hgCRrNQkxnYk8H0VSlOunvV/ODWua87Thq?=
 =?us-ascii?Q?GmDN5AvxtPx6c871rgkaxt/jPQoXVn1a8VBksTfIZEKl0+H0W19hBYLzjfYA?=
 =?us-ascii?Q?NzjRjEATsUklYOWw3y9HKfrz3+Ptpek4zAWlc0oe2Ag19bkB2MujeMKPqy5e?=
 =?us-ascii?Q?k/DKlpUIHChdnyIQ5+4ntTGQWWLAUPEQqW+Hr4/LTk+Ucxgchu+/LbTLNWiH?=
 =?us-ascii?Q?RJcZ5PzX2pEferSaEP2UMXWn4nOxSrUZaQBK40zx6d75IVrGT4OU0uCCDFvc?=
 =?us-ascii?Q?6QK6gdM1At1I7UVcTttGcGK6HQSKIklZaAnszlLvkvAwOMw6iBHLXbaZ12x4?=
 =?us-ascii?Q?PZAqmhcL7W7Z++RsrRozgfSPL0Fk+/IQ3PrjBUBt/Be3mYgzf/FAr1dSAAjq?=
 =?us-ascii?Q?FCsSFOqBTDZnxoroxSGDAi3CAT4+DXQcKV5C9066MqDCX2g0Re/I9ON/yBDC?=
 =?us-ascii?Q?4I6XDurAPXYbNpr/inC4E56uUw9K8Zsbftlm+XPwiLrJqYrtrLEOIiJc+Mrb?=
 =?us-ascii?Q?6EPR5sPTFeGPEEb2iHOL5zrqXwNzBGw+MAWYO3xyu75DD55s5Td2cDGaQHzn?=
 =?us-ascii?Q?qmrWbcKXYGl37QJvJlhXShv/M+AAvmHt/WZPoUMYkWEQ7ICCXKaRKKSz+ns6?=
 =?us-ascii?Q?rFtOrOFOgtWce6ESE9Hm0UeVm1JVjHbacTesyxvHkVp5uQVcGYAoedwmG23n?=
 =?us-ascii?Q?x+zRXB0YE8z5jVtiu6umXWHtkZoelxzFY+3HYNO/kYGKAyS7y+X7i9RPCr89?=
 =?us-ascii?Q?zQSLMRCS3B/d9JrI9q4tNFlZT6OBq7DzsBLLXz0nMiFiXlCtbOOhfmE2JsNk?=
 =?us-ascii?Q?ruN4e4HlgYa504WZwpO/b3YD/KeOW4MqmXF9vPOnCZNW1SCqly2NkOdGm/l5?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21885c40-d5da-4717-64e2-08dc00a9bc20
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 15:46:58.8493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCe21bir7dIHRCzHuP92ZvlxLS6HD+XQ/1MdncQi6P9G5fRLwxg0J0/D3O0oDc0Jwf7ZnOL9Wf+I5X3MhPDbSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7480
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_mm/memory.c" on:

commit: bbcbf2a3f05f74f9d268eab57abbdce6a65a94ad ("mm: convert ksm_might_need_to_copy() to work on folios")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master aa4db8324c4d0e67aa4670356df4e9fae14b4d37]

in testcase: vm-scalability
version: vm-scalability-x86_64-1.0-0_20220518
with following parameters:

	runtime: 300
	thp_enabled: always
	thp_defrag: always
	nr_task: 32
	nr_ssd: 1
	priority: 1
	test: swap-w-rand
	cpufreq_governor: performance

test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/


compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312192319.fa8f5709-oliver.sang@intel.com


[   61.404380][ T5947] ------------[ cut here ]------------
[   61.409984][ T5947] kernel BUG at mm/memory.c:3990!
[   61.415085][ T5947] invalid opcode: 0000 [#1] SMP NOPTI
[   61.420506][ T5947] CPU: 32 PID: 5947 Comm: usemem Tainted: G S                 6.7.0-rc4-00252-gbbcbf2a3f05f #1
[   61.430881][ T5947] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
[ 61.442761][ T5947] RIP: 0010:do_swap_page (mm/memory.c:3990 (discriminator 3)) 
[ 61.448112][ T5947] Code: 6f 28 31 d2 be 01 00 00 00 4c 89 ff e8 9b 43 03 00 49 c7 47 28 00 00 00 00 4c 89 f9 48 c7 44 24 08 00 00 00 00 e9 cf fb ff ff <0f> 0b 49 8b 45 08 f0 48 83 28 01 0f 85 3f fc ff ff 49 8b 45 08 4c
All code
========
   0:	6f                   	outsl  %ds:(%rsi),(%dx)
   1:	28 31                	sub    %dh,(%rcx)
   3:	d2 be 01 00 00 00    	sarb   %cl,0x1(%rsi)
   9:	4c 89 ff             	mov    %r15,%rdi
   c:	e8 9b 43 03 00       	call   0x343ac
  11:	49 c7 47 28 00 00 00 	movq   $0x0,0x28(%r15)
  18:	00 
  19:	4c 89 f9             	mov    %r15,%rcx
  1c:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
  23:	00 00 
  25:	e9 cf fb ff ff       	jmp    0xfffffffffffffbf9
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	49 8b 45 08          	mov    0x8(%r13),%rax
  30:	f0 48 83 28 01       	lock subq $0x1,(%rax)
  35:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc7a
  3b:	49 8b 45 08          	mov    0x8(%r13),%rax
  3f:	4c                   	rex.WR

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	49 8b 45 08          	mov    0x8(%r13),%rax
   6:	f0 48 83 28 01       	lock subq $0x1,(%rax)
   b:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc50
  11:	49 8b 45 08          	mov    0x8(%r13),%rax
  15:	4c                   	rex.WR
[   61.468016][ T5947] RSP: 0000:ffa000000bb5fd98 EFLAGS: 00010206
[   61.474169][ T5947] RAX: ff11000111a47c99 RBX: ffa000000bb5fe08 RCX: 0000002064ac7000
[   61.482233][ T5947] RDX: 0057ffffc00a106d RSI: 0000000000000043 RDI: ffd400008192b1e8
[   61.490296][ T5947] RBP: 000000000100c13b R08: 0000000000000000 R09: ffa000000bb5fe08
[   61.498366][ T5947] R10: 0000000055555554 R11: ff1100018bebbd0c R12: ffd4000044128000
[   61.506438][ T5947] R13: ff1100205d33d800 R14: ff11000130cd2da8 R15: ffd4000044128000
[   61.514508][ T5947] FS:  00007f49c900c740(0000) GS:ff11002001000000(0000) knlGS:0000000000000000
[   61.523534][ T5947] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   61.530225][ T5947] CR2: 00007f4966b3b6b8 CR3: 00000010af786004 CR4: 0000000000771ef0
[   61.538307][ T5947] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   61.546387][ T5947] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   61.554471][ T5947] PKRU: 55555554
[   61.558137][ T5947] Call Trace:
[   61.561544][ T5947]  <TASK>
[ 61.564599][ T5947] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[ 61.568429][ T5947] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153) 
[ 61.572692][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3)) 
[ 61.577475][ T5947] ? do_error_trap (arch/x86/include/asm/traps.h:59 arch/x86/kernel/traps.c:174) 
[ 61.582172][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3)) 
[ 61.586966][ T5947] ? exc_invalid_op (arch/x86/kernel/traps.c:265) 
[ 61.591743][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3)) 
[ 61.596515][ T5947] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 61.601638][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3)) 
[ 61.606412][ T5947] ? do_swap_page (mm/memory.c:3971) 
[ 61.611179][ T5947] __handle_mm_fault (mm/memory.c:5274) 
[ 61.616203][ T5947] handle_mm_fault (mm/memory.c:5439) 
[ 61.621051][ T5947] do_user_addr_fault (arch/x86/mm/fault.c:1365) 
[ 61.626151][ T5947] exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561) 
[ 61.630824][ T5947] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
[   61.635748][ T5947] RIP: 0033:0x5612d5878ad6
[ 61.640229][ T5947] Code: 01 00 00 00 e8 1b f9 ff ff 89 c7 e8 6c ff ff ff bf 00 00 00 00 e8 0a f9 ff ff 85 d2 74 08 48 8d 04 f7 48 8b 00 c3 48 8d 04 f7 <48> 89 30 b8 00 00 00 00 c3 41 54 55 53 48 85 ff 0f 84 21 01 00 00
All code
========
   0:	01 00                	add    %eax,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	e8 1b f9 ff ff       	call   0xfffffffffffff924
   9:	89 c7                	mov    %eax,%edi
   b:	e8 6c ff ff ff       	call   0xffffffffffffff7c
  10:	bf 00 00 00 00       	mov    $0x0,%edi
  15:	e8 0a f9 ff ff       	call   0xfffffffffffff924
  1a:	85 d2                	test   %edx,%edx
  1c:	74 08                	je     0x26
  1e:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
  22:	48 8b 00             	mov    (%rax),%rax
  25:	c3                   	ret
  26:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
  2a:*	48 89 30             	mov    %rsi,(%rax)		<-- trapping instruction
  2d:	b8 00 00 00 00       	mov    $0x0,%eax
  32:	c3                   	ret
  33:	41 54                	push   %r12
  35:	55                   	push   %rbp
  36:	53                   	push   %rbx
  37:	48 85 ff             	test   %rdi,%rdi
  3a:	0f 84 21 01 00 00    	je     0x161

Code starting with the faulting instruction
===========================================
   0:	48 89 30             	mov    %rsi,(%rax)
   3:	b8 00 00 00 00       	mov    $0x0,%eax
   8:	c3                   	ret
   9:	41 54                	push   %r12
   b:	55                   	push   %rbp
   c:	53                   	push   %rbx
   d:	48 85 ff             	test   %rdi,%rdi
  10:	0f 84 21 01 00 00    	je     0x137
[   61.660112][ T5947] RSP: 002b:00007ffd09f037d8 EFLAGS: 00010246
[   61.666250][ T5947] RAX: 00007f4966b3b6b8 RBX: 000000000000358f RCX: 00000005deece66d
[   61.674295][ T5947] RDX: 0000000000000000 RSI: 000000002fa0f0d7 RDI: 00007f47e9ac3000
[   61.682347][ T5947] RBP: 000000002fa0f0d7 R08: 00007ffd09f0386c R09: 0000000000000001
[   61.690401][ T5947] R10: 00007ffd09f037c0 R11: 0000000000000000 R12: 000000000001ac78
[   61.698449][ T5947] R13: 00007f47e9ac3000 R14: 00007ffd09f0386c R15: 00007ffd09f03970
[   61.706500][ T5947]  </TASK>
[   61.709607][ T5947] Modules linked in: kmem xfs loop device_dax nd_pmem dax_pmem nd_btt btrfs blake2b_generic xor raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 kvm_intel sg kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 ahci ipmi_ssif rapl intel_cstate ast libahci mei_me drm_shmem_helper i2c_i801 ioatdma acpi_ipmi libata drm_kms_helper mei intel_uncore joydev i2c_smbus intel_pch_thermal dax_hmem dca wmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_power_meter acpi_pad drm fuse ip_tables
[   61.768510][ T5947] ---[ end trace 0000000000000000 ]---
[   61.786010][ T5947] pstore: backend (erst) writing error (-28)
[ 61.792055][ T5947] RIP: 0010:do_swap_page (mm/memory.c:3990 (discriminator 3)) 
[ 61.797397][ T5947] Code: 6f 28 31 d2 be 01 00 00 00 4c 89 ff e8 9b 43 03 00 49 c7 47 28 00 00 00 00 4c 89 f9 48 c7 44 24 08 00 00 00 00 e9 cf fb ff ff <0f> 0b 49 8b 45 08 f0 48 83 28 01 0f 85 3f fc ff ff 49 8b 45 08 4c
All code
========
   0:	6f                   	outsl  %ds:(%rsi),(%dx)
   1:	28 31                	sub    %dh,(%rcx)
   3:	d2 be 01 00 00 00    	sarb   %cl,0x1(%rsi)
   9:	4c 89 ff             	mov    %r15,%rdi
   c:	e8 9b 43 03 00       	call   0x343ac
  11:	49 c7 47 28 00 00 00 	movq   $0x0,0x28(%r15)
  18:	00 
  19:	4c 89 f9             	mov    %r15,%rcx
  1c:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
  23:	00 00 
  25:	e9 cf fb ff ff       	jmp    0xfffffffffffffbf9
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	49 8b 45 08          	mov    0x8(%r13),%rax
  30:	f0 48 83 28 01       	lock subq $0x1,(%rax)
  35:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc7a
  3b:	49 8b 45 08          	mov    0x8(%r13),%rax
  3f:	4c                   	rex.WR

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	49 8b 45 08          	mov    0x8(%r13),%rax
   6:	f0 48 83 28 01       	lock subq $0x1,(%rax)
   b:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc50
  11:	49 8b 45 08          	mov    0x8(%r13),%rax
  15:	4c                   	rex.WR


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231219/202312192319.fa8f5709-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


