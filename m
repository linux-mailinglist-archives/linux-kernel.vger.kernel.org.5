Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0478082CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjLGIUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378443AbjLGIUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:20:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D9F1728
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701937209; x=1733473209;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/ezRbV5JGhi4ZlbF++R5w0QBAPvkGOB0d2avZ36Aa0M=;
  b=P3arILpmXt44GPsx9pcf4KTPO7VfRfEskG3YQdaQDNA9UeeD1KRXqyIa
   j7C7Zj6WH8OWowmnMf9f2aSOnDRN5uVOkNWCgXXGPGwEamGu5GcvRrIvb
   zkl7r93VsToZifK5tthzgs4rSUZUNTBVO4+Bcb15RtXEfBqULr2oEkBQ7
   wWO3NBI1sBdIBXHScttD8eROrtYL12WIGBg40VUH97uvMwUL+q1K1s7ru
   +ngQlYr76XvMDRj5EGqVsHdkSbz4GqEVjibO6JHH0yq2FqUNESq5+P0Yp
   6i1/z/gUQHnmBPQ3d+K9ilcPafPOGH2YvPp12ocbSeAwf6ZUUnvOC54nM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="379216217"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="379216217"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 00:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="19628301"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 00:20:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 00:20:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 00:20:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 00:20:08 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 00:20:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJsHItLCKEx6i8jk9N4xqULlZDw7Q/CAyn+WcxZV9LrCA3yAHqtbr41ObbWvEwXKPJ9XVvkSbAWnqqNL/2FV1OxMM9bXBsMTIPg3aB9mIyPUpQwcv+aWJ9xbgvjgjht/djyTGq8RV+P+T3fHjxggmcnOlVXHiZSWhzesKvyeSiz72Y9297SGOsrTin9WhzsyNuPpkRHH5+lvz8Fh7Mfjqr8xCyLdwEFH9MBDwlhDvBn3Q/zJlSauCyRPpRQ20n8DBZ4XQS++2QfHoVXCroAbvcsbJL2jKEksPZ/lQno/kaX5dCxsgQo2ANewlWfb0w4s5JRUgCWDH65Np85JykG0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1WAskQDour4pj8eC4kdHhtE5vmg2aAChbV+nT40L9k=;
 b=MIrvNWiN3tOd34iuiF5fECs8gsPj/ViPRqTI3du0DtMGH01JYMdWWzyi7RiHyVfJS66K7OdrRMd0aOJYYg4FUfKl34PhmzdrjF+yWGKzxeY6ESFy8WJMG+qphf3JtrYJwfHEmZiIObioIlN6bKAwOlzWwu9BblFp/tbRShht5K5Js5NbXjTdQXCaYZfKdnm7qKNs7LvjCXkGYjHt80Ltuq+uuv42YvjQ7qByg1JJS/uOS2t01flbjsZUXm5eju5FM1T7602osofnXpZI3TRttQw3LryBAuNVYxuRmuGi9Ege2GB6ilj+amuuag8GWuE5dwrsCIxAS7IqRjSmWWnHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN0PR11MB6183.namprd11.prod.outlook.com (2603:10b6:208:3c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 08:20:05 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 08:20:05 +0000
Date:   Thu, 7 Dec 2023 16:19:56 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [paulmck-rcu:dev.2023.11.08a] [EXP locktorture] 1254a620b4:
 WARNING:at_kernel/rcu/tree_stall.h:#rcu_stall_chain_notifier_register
Message-ID: <202312071506.6eac1bac-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN0PR11MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: f9595eab-17c8-4561-1151-08dbf6fd5148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUSQxyJNDEC4BEqp+UKMOwaCEXSyZhStxFHL0ocI45GbhbNHyAkG0EFp64DryMqDF1HbXQzXZcjhp+p9U0QJL5y4WQcgd5SMNPVIB/NKQ69XytiKxIX7djtS10QYIMsXsRGd70uslzSkSeWhtBcp4qeCfXMwsJdzCegNm1lqPTWpqXD/ymYdaRGZMa4D5LNt1F7k1PdgNnukS3E1JYRf01MeNTWVv8X73sll/1iEwnwvEZQNJhh46tqv4PLf01dTVd0+iVxQm96cUuFRFdUMx+SSNeX5vOAUCerB86UNCkkmJcfSKw1WaeD7QNbWA04025spTH+xUonqEKJLx7EvcKRQ0gLbFqiNdU/hpX9MPeaHL185RkiZ3HTNDaCFRCwRdb8j+X8djIh890T3T2auGPqxqZVXkxbDoXtBAlilYjN4WmqkkokpvQTn9JY/208Y6NDSbXxXCqoQyzS6Vc1uFAZ68TbqPHP3abKWClRVMUEfv5aIVGuxRLz/pDTJOKf7eBfWLN7FZlb57rrjuJS1hBOg0THh2acIZL36VvDxN5ADhTYUt/pJcJfxZszLARkNAIinmo4Nm+JQ91pR9omaO+FPx/zHShUMSASqO/39kyTqv/vpb6YnxD9+tULetZtJtfEMnjqZwdA6up55AkSHQicAD835zxoIA1vp3Hvp3voN7ZGmOWuUgUM/GOZS9657
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82960400001)(5660300002)(2906002)(83380400001)(6666004)(38100700002)(2616005)(1076003)(26005)(107886003)(6506007)(6512007)(36756003)(45080400002)(478600001)(66476007)(66556008)(966005)(6486002)(41300700001)(66946007)(4326008)(8676002)(316002)(8936002)(6916009)(86362001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4v/bSnvfWEaIpBkiE+1b0eN/GNrLiWVsngb0icaAE2Ugxhclgy+8EdbPZYhU?=
 =?us-ascii?Q?3yvll4YA69EeH0bG1LmuT9QIb1bdNEtcsJ2qqrRQlRItUhAyplkjqA4L8eIT?=
 =?us-ascii?Q?clkVr60O9yk0d/GidgryI5WvwFxrNsX11vq/QiN91cvwwFO5T4cV4C4qoXSC?=
 =?us-ascii?Q?y+qdlzcJgt/r5trXSnoTaNgscO401k3y53EzH8iCvwp/sdTq+zu6sl3Ass9Y?=
 =?us-ascii?Q?DJYNkC8kDhaVhMi0PlXxseLgSitPYhTFYcIiRinF54StrV7EZS8n+beQ8J5r?=
 =?us-ascii?Q?ITNsRHVaicF/XJJW2Gaq4R74f74xq1cSQW19CKWGdXm7bzKj46Bzy8U6XoXa?=
 =?us-ascii?Q?/pv2a/dAMXpo0uG8RRhj3qFAWu1IyArim3xdeFOzrmm4fQeuyLg/DRYFXE6p?=
 =?us-ascii?Q?65znmCx5AqXeaHvmvlQZKasPoQ2TZSbBIgZWAW0eo4Ffc1ed6EVCT5Ij/hYz?=
 =?us-ascii?Q?orAdjrF5rYp44cbJq45NBjzdSfn+8QWp0nXuRHWx+M5nqyY+Gl7CtBfTmhTd?=
 =?us-ascii?Q?RbIj5i+9P/Qe3jZ/+jzjrnWslxioC3CmEA1T9JHAArDuXAYxl5zmLeWj2gqS?=
 =?us-ascii?Q?lhpVD33+Tl7QU/ylV+FnqWYatrj371V7SIaNv0cUIPhBqeMxVGnBk4cF5loR?=
 =?us-ascii?Q?e98yO9jVtBT738ba24PVltixu5ZzM6Gf0lnz62E0dIlxCqHeIERtTtuCLznP?=
 =?us-ascii?Q?WzycTzgMa+9wM+GJyC5cVKxbThtQxdsOQZBOXiEF3SrII9ucJJqUzUGPN81Q?=
 =?us-ascii?Q?Xc1i+5TC/e7tKUl+ii6yZJTuS6VJgc61Qfsj5hwrcHhvFKcd2qw17CdQNlTm?=
 =?us-ascii?Q?LJ+alCZPP3CtDyok2pbyDYNuLyY69CPew/z76j+ZS+Q9jMniojiK1ChOYom2?=
 =?us-ascii?Q?JH/q6c+fEcdf1WiukRYtFdFeiyJlFL0uhbPizyvlSi8tc3tkV3dFFpX9+ngw?=
 =?us-ascii?Q?C1/tPvvzFW2YfFiW+8uEM7TQGOeRNbK27YYSNU+4mhYjBO9Glp6y4IEgNKAY?=
 =?us-ascii?Q?A7Ww2Hg5K7TfUNQpojK7J1e5R+RmlBeSdXztiJ7U9g/CPCF6HJiJM1ZiykxL?=
 =?us-ascii?Q?Bhnugwbs2Kf02UqGNJipoCjt82ZAgKQJ1ucwbRirl4zJSlgQD6nEAIKOgC3G?=
 =?us-ascii?Q?RrWdViqy22/CN5XU+sEM/mcDOhzqnVxUROI+OLmx8FtIzDxBJRYJuaDxHWb0?=
 =?us-ascii?Q?m5w9fvuYW7vxJqYscYrPZAPdr57XRQQS3VEVTWjuWElTEI47zBqyiEU3Zp/D?=
 =?us-ascii?Q?jD9BXgq0q5zqKq6ipuI7JZn8IuLxapuJdeeW88dGb4DTRtYzY71Kr/gvIchD?=
 =?us-ascii?Q?O02M9Rxe5tWCF5vxCF1TLfJOs6Zpioieeh9j1OkYNLZ07gMRArEIK9qEGRci?=
 =?us-ascii?Q?ZW0n6HboHDkeBMVnY3FnOlzteO1+DG5LBQbfN5u0S6S9bgRsyEq4+jJYIiNC?=
 =?us-ascii?Q?WNqGe5l2H3NJF6bqHy3TDJyONmT041TljD4Fgd0Dl7vV98lk0yQron2IvBM/?=
 =?us-ascii?Q?bkmLdYWs0JPZ9dOBnUKwhVeaQeMtVy/hFNhzdDdzLkh9R9ZRaqcYToq9rZJp?=
 =?us-ascii?Q?LjR5kIXkOzXVjOmNgPgxMoHnJDeNsJuSTD5w8rVY9zsNZX+D3dCCaFBSaL9M?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9595eab-17c8-4561-1151-08dbf6fd5148
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 08:20:05.7100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AC/rVpzNajL7cIbsXVmQXqprwX/9B8toMq1Q6kYQYoyKbljpmQnDyjG1284e63PdJMh8D3BHl/FN7vgd72CWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6183
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_kernel/rcu/tree_stall.h:#rcu_stall_chain_notifier_register" on:

commit: 1254a620b4a3832e65ac01bcef769b99e34515b2 ("EXP locktorture: Add RCU CPU stall-warning notifier stub")
https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2023.11.08a

in testcase: locktorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug



compiler: clang-16
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------------------+------------+------------+
|                                                                       | 11b2bc2909 | 1254a620b4 |
+-----------------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/rcu/tree_stall.h:#rcu_stall_chain_notifier_register | 0          | 12         |
| RIP:rcu_stall_chain_notifier_register                                 | 0          | 12         |
+-----------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312071506.6eac1bac-oliver.sang@intel.com


[  200.668175][  T876] ------------[ cut here ]------------
[ 200.669199][ T876] Adding torture_spin_lock_dump+0x0/0x20 [locktorture]() to RCU stall notifier list (failed, so all is well). 
[ 200.671183][ T876] WARNING: CPU: 1 PID: 876 at kernel/rcu/tree_stall.h:1088 rcu_stall_chain_notifier_register (kernel/rcu/tree_stall.h:1087) 
[  200.673094][  T876] Modules linked in: locktorture(+) torture
[  200.674129][  T876] CPU: 1 PID: 876 Comm: modprobe Tainted: G        W        N 6.6.0-03747-g1254a620b4a3 #1 44194d056aabc0fb2e11ad706d62f862fdc5dd23
[  200.676413][  T876] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 200.678192][ T876] RIP: 0010:rcu_stall_chain_notifier_register (kernel/rcu/tree_stall.h:1087) 
[ 200.679403][ T876] Code: 89 df e8 2f 0c 35 00 48 8b 33 85 ed 48 c7 c0 00 cb 49 97 48 c7 c2 a0 ca 49 97 48 0f 44 d0 48 c7 c7 40 ca 49 97 e8 fc 69 e4 ff <0f> 0b 85 ed 74 13 48 c7 c7 20 c7 1d 99 48 89 de 5b 41 5e 5d e9 83
All code
========
   0:	89 df                	mov    %ebx,%edi
   2:	e8 2f 0c 35 00       	call   0x350c36
   7:	48 8b 33             	mov    (%rbx),%rsi
   a:	85 ed                	test   %ebp,%ebp
   c:	48 c7 c0 00 cb 49 97 	mov    $0xffffffff9749cb00,%rax
  13:	48 c7 c2 a0 ca 49 97 	mov    $0xffffffff9749caa0,%rdx
  1a:	48 0f 44 d0          	cmove  %rax,%rdx
  1e:	48 c7 c7 40 ca 49 97 	mov    $0xffffffff9749ca40,%rdi
  25:	e8 fc 69 e4 ff       	call   0xffffffffffe46a26
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	85 ed                	test   %ebp,%ebp
  2e:	74 13                	je     0x43
  30:	48 c7 c7 20 c7 1d 99 	mov    $0xffffffff991dc720,%rdi
  37:	48 89 de             	mov    %rbx,%rsi
  3a:	5b                   	pop    %rbx
  3b:	41 5e                	pop    %r14
  3d:	5d                   	pop    %rbp
  3e:	e9                   	.byte 0xe9
  3f:	83                   	.byte 0x83

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	85 ed                	test   %ebp,%ebp
   4:	74 13                	je     0x19
   6:	48 c7 c7 20 c7 1d 99 	mov    $0xffffffff991dc720,%rdi
   d:	48 89 de             	mov    %rbx,%rsi
  10:	5b                   	pop    %rbx
  11:	41 5e                	pop    %r14
  13:	5d                   	pop    %rbp
  14:	e9                   	.byte 0xe9
  15:	83                   	.byte 0x83
[  200.682780][  T876] RSP: 0018:ffffc90002b67978 EFLAGS: 00010246
[  200.683857][  T876] RAX: 000000000000006b RBX: ffffffffc040a220 RCX: 0000000000000027
[  200.685304][  T876] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff8883aeb27a10
[  200.686724][  T876] RBP: 0000000000000000 R08: ffff8883aeb27a13 R09: 1ffff11075d64f42
[  200.688142][  T876] R10: dffffc0000000000 R11: ffffed1075d64f43 R12: ffff88814879e080
[  200.689573][  T876] R13: ffffc90002b679e0 R14: dffffc0000000000 R15: dffffc0000000000
[  200.690976][  T876] FS:  0000000000000000(0000) GS:ffff8883aeb00000(0063) knlGS:00000000f7aa9700
[  200.692536][  T876] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  200.693695][  T876] CR2: 000000005664b010 CR3: 0000000141a71000 CR4: 00000000000406f0
[  200.695095][  T876] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  200.696540][  T876] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  200.698173][  T876] Call Trace:
[  200.698865][  T876]  <TASK>
[ 200.699476][ T876] ? __warn (kernel/panic.c:235 kernel/panic.c:673) 
[ 200.700283][ T876] ? rcu_stall_chain_notifier_register (kernel/rcu/tree_stall.h:1087) 
[ 200.701381][ T876] ? rcu_stall_chain_notifier_register (kernel/rcu/tree_stall.h:1087) 
[ 200.702461][ T876] ? report_bug (lib/bug.c:?) 
[ 200.703294][ T876] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 200.704128][ T876] ? exc_invalid_op (arch/x86/kernel/traps.c:258) 
[ 200.704995][ T876] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 200.705913][ T876] ? rcu_stall_chain_notifier_register (kernel/rcu/tree_stall.h:1087) 
[ 200.707177][ T876] ? rcu_stall_chain_notifier_register (kernel/rcu/tree_stall.h:1087) 
[ 200.708908][ T876] init_module (include/linux/cpumask.h:909 kernel/locking/locktorture.c:98 kernel/locking/locktorture.c:1051) locktorture
[ 200.710509][ T876] do_one_initcall (init/main.c:1232) 
[  200.711382][  T876]  ? 0xffffffffc0418000
[ 200.712246][ T876] ? __asan_register_globals (mm/kasan/generic.c:229) 
[ 200.713299][ T876] do_init_module (kernel/module/main.c:2530) 
[ 200.714163][ T876] __se_sys_finit_module (kernel/module/main.c:3148 kernel/module/main.c:3166 kernel/module/main.c:3186 kernel/module/main.c:3169) 
[ 200.715119][ T876] __do_fast_syscall_32 (arch/x86/entry/common.c:164) 
[ 200.716056][ T876] do_fast_syscall_32 (arch/x86/entry/common.c:255) 
[ 200.716965][ T876] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:121) 
[  200.718040][  T876] RIP: 0023:0xf7fbb539
[ 200.718801][ T876] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 cc 90 90 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
All code
========
   0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   4:	10 07                	adc    %al,(%rdi)
   6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   a:	10 08                	adc    %cl,(%rax)
   c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	cc                   	int3
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  39:	00 00 00 
  3c:	0f                   	.byte 0xf
  3d:	1f                   	(bad)
  3e:	44                   	rex.R
	...

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	cc                   	int3
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   f:	00 00 00 
  12:	0f                   	.byte 0xf
  13:	1f                   	(bad)
  14:	44                   	rex.R


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231207/202312071506.6eac1bac-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

