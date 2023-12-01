Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4128005BC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377877AbjLAIfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377863AbjLAIfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:35:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638D6131;
        Fri,  1 Dec 2023 00:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701419750; x=1732955750;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6mi3k3wcA8OCTp5Ka3ygj2ZBjWk73Trh+bkiKEJR9qQ=;
  b=TmquZaGZdbjG4Kk+roakkcubg0PvyyeUFptM4zE2t1zndPT1auYRmmBH
   rW2XCKfXftLElP+Q7qV2c8LxizZ5lm2eW3tWuy23xgNiIU6So+/PhBIxW
   CD+BilOKe2b7Av8CSpG83z1pWWJFcWtd7iTaECmmNCWfdDqrdE3+OL5vc
   ideWE2PfNegbvj28tln56hyYbg95yWABevkTBfYw1W2/k2XDNoGQazgVO
   HOiffjUa7fU4rfCiuwnbBm0+z0ss5PBvXZQ5TRdDDchsh8zDnL5Xx73vG
   sJdB1mJqfnclAn9c81cRmo3b4v96rNSM290BqBsyMb3sgu6Zkyoj8oS8Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="459962009"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="459962009"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 00:35:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="887565496"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="887565496"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 00:35:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 00:35:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 00:35:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 00:35:46 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 00:35:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVX64jn1xrWNGWNPW+9I0lQeBiGSHXTlaC2jHb6KeXE9U/U87e3ZuQ9sCNaPuxEvX7Ok2fvi5z1fROo/K04bQdcFtIE+GPpNvibzEKF8oQlPc4+/Jk4E3FhXAAmWtFYtcpINbLSVPtEZPDsuD7Sc1juWTVrXjTeCV2aIbqpwdJSnJwJ/V89N+yk+9Dr4kXs4oRUQ3QxlZlotuLObuH3tSutAKxxftQX9FtbA/cYuY7CMZlKKjV9lUVxxnDawBS1x3FMxgRSslVED5nRhpZpaz4mGPEL8uvWG5mSIl7uXHUYYDklY2S2UnFIQmVtB1A6y8rloCTMll6IVj+64vy0y2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVPnDQoSAKnJIdSmAOwHc4Ilu4UaTDLsS8H5dE+Sytc=;
 b=gRlIJt2jpr4aggZbiIsfj0//RLH2SRmI6/H8Aj7ZjEdqNadBgkgAEkq+my6Sa3F88PH1bpNkDwCR+Au+DZuv2U1uyDlKDyVeH/ogFizb0Jl8xL/eO77nzBoGVdWUnE6/q9H5D+RpiSU4NlmNcWo+BgZjIYaiNDWElOvzZnE2ziGtTDOg9n/gdWpi9W8UIjwVtFawt1pM+OMjB8a+Ppjqi8GCFghfOPCE0LFrXRFID+sOIBuWV35MBxcC2kaX7jUAF316CxB3SRT1fqvN24wrPY6wAHgxRpbghgVfb0U8mZwu7MIR/JTT7OKePCmA2iUMCcYIquZSUSybQWujICTM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DM4PR11MB6067.namprd11.prod.outlook.com (2603:10b6:8:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 08:35:43 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 08:35:43 +0000
Date:   Fri, 1 Dec 2023 16:29:51 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        <heng.su@intel.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_ioctl (4)
Message-ID: <ZWmZfyg4CfTK6MNy@xpf.sh.intel.com>
References: <00000000000047eb7e060b652d9a@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <00000000000047eb7e060b652d9a@google.com>
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DM4PR11MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ecef09-c136-44e4-3010-08dbf2488181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4w9ROThD5FebE/6GPD53GR+1IsST2mwUa5SyfoJJTdqQA0T6JmBhe7UHn22LlTb4jZoLG9y6JaMY2gZwwVLRA/SwdJuHx/HZpbx9HRmepYpadlI1iqPnOV2OY5BWyZSI4+TQZE3/vOrwx5Oh8pN7WEsId+cn76HNm15+9qLR5B4b4O7dKAZl/R7mz7zpZptAGt8VHX9NF7Zhr0YlMCP9Mddxu0lmxGHPdVZK4/UzLC++xg20IgqxktHTLqe+7r7etppJxxxyWare80hMnBm65G6yC8TpzLNsoN6YMfH1HB5dOqJtqcKm0C1mqctwGm/5vBtgfKT4pd7F0NsPQYew+15ZBhbbwvnEnXrAELlrZx2o3/3IAZiIdnHdJy5Fdu4z9yWkrGHkzdIR5XI72H3uwWhOkvC3I0C43EVu4lu0US07nWeaOyTlyzqk84Aedn1TM9x9/Haf3TV7pCdPWHynuBQxv+4k6s9IFj8SzoARGaxHkG+mN4AUrLaMfqaRw5/P1/ASaY9a12JnFZdV1FRWk3JxZPxehNR3cS/gWO7RlMsTr5AdPbJbNXORqVmeZdyoPN/Ifu+jJyKqw9GuQv0IIGtkL3hZVRp4Nhmu6Z6lN/XwzWBuI28ssg60VFlI3XyHak/F7IZaBQDdOApBjHRx8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66476007)(82960400001)(66946007)(38100700002)(86362001)(54906003)(6506007)(107886003)(83380400001)(26005)(53546011)(6666004)(5660300002)(966005)(6486002)(2906002)(316002)(66556008)(478600001)(6512007)(8936002)(30864003)(8676002)(7416002)(4326008)(44832011)(41300700001)(99710200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Z0FHuxtZNMrzCFm6W4trvJkoZXm1+oVm1m/FRS/uhZSIJv+pwxjkQNP+7pn?=
 =?us-ascii?Q?0FZAXZ/bLqB6+B1Rvts2GOsht5SDhDP5JYGGv6SVxro0wb0QZp4VXhC6Hr+P?=
 =?us-ascii?Q?VhGkQtSXmPWLcDaWtfGuoNtAKhHbOi9Htefex9JKPfudtYmenaM9j61ACT7Z?=
 =?us-ascii?Q?XewWJhjB8ntQKlUmWITXvqSW5P9mQPKiFyDuJZCdmbOM1cybigfRF3om2lJD?=
 =?us-ascii?Q?n9sCH7Gj2mrpXvZ4d+GK/flyQSQAEmGSy9GLfhaaOAOMl/ZPax7klnsbGzeB?=
 =?us-ascii?Q?Mhlg+DTkvY4FMk3x66vNtZ3VWk0K+UGYt9QfxpMHKlV3u2S9grpXg1PDrv8X?=
 =?us-ascii?Q?IfWZ27TOl2bqJGbiWy+aMw1iB8PEHxgvK7Mj5zc5rW9vumsnLDC1dcDpTdLq?=
 =?us-ascii?Q?8CsH8l/Zftsy48rq/2l0uk4DzHn+wdbu62kGk3mYDcB9IfAoGxH1ia5Onm5Q?=
 =?us-ascii?Q?+GJCFSsKlPC+IcqX04m98V7vvlTqJaiE1G/2JmeAbuUmcR8/RCagAJqLuHYg?=
 =?us-ascii?Q?3izDVkZx0hFvDxjAOKfByLefTV7hSFrv+KIZ6agOQjcbBRFw4H4c6XBvKGqH?=
 =?us-ascii?Q?eysCDP5KwvRgQrnSfF4H24BqsuIkHQ2bIwoatE+8OmVXCdhGoiEzK4DfbWUC?=
 =?us-ascii?Q?oXw4/V0wneGhUfD7IbDeHIwtJubiM0CI3JxUA9Mw3hrUpwKdYI076o9l+WW3?=
 =?us-ascii?Q?p5R2QTNISEKIkyPRHEjF7a2CGzmlFjIqaIEd1i5LEfpyJNJN8AdgKww9sJLd?=
 =?us-ascii?Q?EQPln2mfG+krAiXr67I0NA3Bc+XF2C/Xmlu3NBiEHLbW9PLwXvScwG3qm8VZ?=
 =?us-ascii?Q?OfEJqilm00XfkvS0UeznHoRNfZPF2fFMTqfRodS8Gy4thUII1P+H1IBBV/6w?=
 =?us-ascii?Q?NTTp/SbdE9r8YoCy8EKVx/APA/50jNHfDg1R1ZWkKd6NJvODjD3akqm5I/Cc?=
 =?us-ascii?Q?5Hxpt84KB7KU7O+sSJ7xNbAI0FmHk39CnXLb8dHvzLKopf/PK4RhB+p4ailG?=
 =?us-ascii?Q?NK7A9Qx+PzOwoEUdZgpQ6T2cQa1/5YekYwhLBWfyNcHuLvSeBInH8imB0jj5?=
 =?us-ascii?Q?2CHMWk/svOZmW6gndBzlBp6enG24B7Z0KfnU+hCkG0MULflwQgAOr9A78LNE?=
 =?us-ascii?Q?8i9anwE+WWFJWLO9OAR2r9fgZ2EKzvBQwsSKdGgXp6PGXeZMxQzrLSYtFpmd?=
 =?us-ascii?Q?r8uNQb/t/fClYAWaBME0I3zTQIQ3yO3iAczuetz4AArQmAgljWTszjaoqABF?=
 =?us-ascii?Q?odabgK1Gf9QvAfyKL/8PNQtZL8+BfwJmNo6PKZ7ZQJ7QWmHUYRTDqDFAvYgs?=
 =?us-ascii?Q?MUrp08e9zZmg8a022YaXcA4MyV2bIyE3s9JsN3YPZam4zbxG9FrpZPEL6XuJ?=
 =?us-ascii?Q?2GmcU/exmvuoppzSXpw5sja1qbW14QQq0oBqlagoSkRdOWI1Z7bqZpbYvLdd?=
 =?us-ascii?Q?VyoPTcJcViP/P0IVT3rwRZvViBsuips2quRiwsaRUIp6Qiny3Wp0noxzvQjo?=
 =?us-ascii?Q?5RnN+HaoSVNUoIh1ISFhVJh4wGzmu1dyc80S9OOfN9E1X3v9Q+EdILVXH0zq?=
 =?us-ascii?Q?jCCsp3B70Eyvox/DHtqvgUgYLWq8d9a7H0bW8Yc9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ecef09-c136-44e4-3010-08dbf2488181
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 08:35:42.9158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWszP1hg/6Z8sp/EvfJ3o3f3irTB/cAQvDo1QtKkLjlGiVUZzIIUrqJ8KRCV0/8Z/rBcVch3U46gTXUUa85VGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6067
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

Hi,

On 2023-12-01 at 05:17:19 +0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8c9660f65153 Add linux-next specific files for 20231124
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1006f178e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
> dashboard link: https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ec6e62e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11964f7ce80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/345ed4af3a0d/disk-8c9660f6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/191053c69d57/vmlinux-8c9660f6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/aac7ee5e55e0/bzImage-8c9660f6.xz
> 

  Thanks for your report!
  I reverted the commit 0d345996e4cb573f8cc81d49b3ee9a7fd2035bef on top of
  v6.3-rc7 mainline kernel, this issue was still reproduced.
  Anyway, it's an interesting problem, I will update the email if I find
  more clue of the problem.

  Best Regards,
  Thanks!

> The issue was bisected to:
> 
> commit 0d345996e4cb573f8cc81d49b3ee9a7fd2035bef
> Author: Pengfei Xu <pengfei.xu@intel.com>
> Date:   Mon Jul 31 03:04:18 2023 +0000
> 
>     x86/kernel: increase kcov coverage under arch/x86/kernel folder
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14782eaae80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16782eaae80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12782eaae80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com
> Fixes: 0d345996e4cb ("x86/kernel: increase kcov coverage under arch/x86/kernel folder")
> 
> INFO: task syz-executor216:5234 blocked for more than 143 seconds.
>       Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor216 state:D stack:29104 pid:5234  tgid:5232  ppid:5106   flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5399 [inline]
>  __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
>  __schedule_loop kernel/sched/core.c:6801 [inline]
>  schedule+0xe7/0x270 kernel/sched/core.c:6816
>  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
>  blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
>  blkdev_common_ioctl+0x1575/0x1ce0 block/ioctl.c:562
>  blkdev_ioctl+0x249/0x770 block/ioctl.c:627
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl fs/ioctl.c:857 [inline]
>  __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x62/0x6a
> RIP: 0033:0x7f914d80ca89
> RSP: 002b:00007f914cfa3168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f914d89c1d8 RCX: 00007f914d80ca89
> RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000004
> RBP: 00007f914d89c1d0 R08: 00007ffdb3560fd7 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f914d89c1dc
> R13: 000000000000006e R14: 00007ffdb3560ef0 R15: 00007ffdb3560fd8
>  </TASK>
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/29:
>  #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
>  #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
>  #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
> 1 lock held by klogd/4501:
>  #0: ffff8880b993c718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
> 2 locks held by getty/4815:
>  #0: ffff8880273ee0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
>  #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc4/0x1490 drivers/tty/n_tty.c:2201
> 2 locks held by kworker/0:5/5180:
> 2 locks held by syz-executor216/5233:
> 1 lock held by syz-executor216/5234:
>  #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
> 1 lock held by syz-executor216/5240:
>  #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
> 1 lock held by syz-executor216/5241:
>  #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
> 1 lock held by syz-executor216/5245:
>  #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
> 1 lock held by syz-executor216/5246:
>  #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
> 1 lock held by syz-executor216/5248:
>  #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
> 1 lock held by syz-executor216/5249:
>  #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
> 1 lock held by syz-executor216/5251:
>  #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
> 1 lock held by syz-executor216/5252:
>  #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
> 1 lock held by syz-executor216/5254:
>  #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
> 1 lock held by syz-executor216/5255:
>  #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
> 
> =============================================
> 
> NMI backtrace for cpu 0
> CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
>  watchdog+0xf86/0x1210 kernel/hung_task.c:379
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>  </TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 5233 Comm: syz-executor216 Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> RIP: 0010:__sanitizer_cov_trace_switch+0x4f/0x90 kernel/kcov.c:341
> Code: 83 f8 10 75 2f 41 bd 03 00 00 00 4c 8b 75 00 31 db 4d 85 f6 74 1e 48 8b 74 dd 10 4c 89 e2 4c 89 ef 48 83 c3 01 48 8b 4c 24 28 <e8> 2c fe ff ff 49 39 de 75 e2 5b 5d 41 5c 41 5d 41 5e c3 48 83 f8
> RSP: 0018:ffffc90003fdf3a0 EFLAGS: 00000202
> RAX: 0000000000000008 RBX: 0000000000000001 RCX: ffffffff813a44c8
> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000001
> RBP: ffffffff8ac9d800 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: dffffc0000000000 R12: 0000000000000001
> R13: 0000000000000001 R14: 0000000000000003 R15: 0000000000000001
> FS:  00007f914cfc46c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f914d899f18 CR3: 00000000a0ad4000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>  unwind_next_frame+0xea8/0x2390 arch/x86/kernel/unwind_orc.c:641
>  arch_stack_walk+0xfa/0x170 arch/x86/kernel/stacktrace.c:25
>  stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
>  save_stack+0x15e/0x1f0 mm/page_owner.c:130
>  __set_page_owner+0x1f/0x60 mm/page_owner.c:196
>  set_page_owner include/linux/page_owner.h:31 [inline]
>  post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1533
>  prep_new_page mm/page_alloc.c:1540 [inline]
>  get_page_from_freelist+0xa16/0x3690 mm/page_alloc.c:3344
>  __alloc_pages+0x22d/0x2400 mm/page_alloc.c:4600
>  alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
>  relay_alloc_buf kernel/relay.c:121 [inline]
>  relay_create_buf kernel/relay.c:162 [inline]
>  relay_open_buf.part.0+0x27d/0xba0 kernel/relay.c:384
>  relay_open_buf kernel/relay.c:536 [inline]
>  relay_open+0x641/0xab0 kernel/relay.c:517
>  do_blk_trace_setup+0x4a9/0xaa0 kernel/trace/blktrace.c:591
>  __blk_trace_setup+0xd8/0x180 kernel/trace/blktrace.c:631
>  blk_trace_ioctl+0x163/0x290 kernel/trace/blktrace.c:741
>  blkdev_ioctl+0x111/0x770 block/ioctl.c:622
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl fs/ioctl.c:857 [inline]
>  __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x62/0x6a
> RIP: 0033:0x7f914d80ca89
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f914cfc4168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f914d89c1c8 RCX: 00007f914d80ca89
> RDX: 0000000020000380 RSI: 00000000c0481273 RDI: 0000000000000004
> RBP: 00007f914d89c1c0 R08: 00007f914cfc46c0 R09: 0000000000000000
> R10: 00007f914cfc46c0 R11: 0000000000000246 R12: 00007f914d89c1cc
> R13: 000000000000000b R14: 00007ffdb3560ef0 R15: 00007ffdb3560fd8
>  </TASK>
> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.100 msecs
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
