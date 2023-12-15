Return-Path: <linux-kernel+bounces-379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA5481403C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3A91F22B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1B846B6;
	Fri, 15 Dec 2023 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGiIGw5J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A2468E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702608659; x=1734144659;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L8pO2EO1SV6ngPpGawMeIqq4hDphQbRw8BQKkdKbucE=;
  b=DGiIGw5JMmDWlBB1u/i5nYedD6d6gWxMMCJYS9eXolMq+gdag//5a6he
   ILwKW5JmzXvofn2NCuxY0Ke4j/eWn4bZFa+U1GoFvE0i5/r86zV0+Kabi
   bevlpygSd0W0yFgxgUL2Bkv04td04KUoLr1hi9/SdeoQAHoFQx1lImjRV
   8KtMBkGnolSgM40lMBLBvrp7tgQRg1kvGFGhtD+sFcnoWrOOGMbx3fccp
   a3gg9vKXfLgN0RDtJLsL7pG3ZYihTzZMZp4bgZN5fYwiegtA5hv5wro3a
   Z01MWNpb2hDzIuFpONeTuBU8UfQ9FGZmLYQddavFeYdSZiZvF5nM87Uz9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="394963269"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="394963269"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 18:50:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="844968373"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="844968373"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 18:50:58 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 18:50:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 18:50:57 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 18:50:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Te+QSM7yWI4Mwg8REIH8h0HZu3/IQk5gBiSF64C59kmb7bop+a/oE9iDxLh2ICh9lrSFy8bgNbOQtAowMfcbFVcDD/6sFdKxB+dx73sLVkBXJnXdGXAwUeiyawMELBcSgb7uCx7BW36EyKwLECi+krg0rASgdHSyYvRIerVstva3rQPmhIC0IymXTM6Lo5FPy3l7U5Mzn5GqP/xLeTUoIb97VndnDnYtaG3BHWmlJKswIdhji6Cn1ViFr/0KyzG2LB4lymGWDjUFW5pXhm2XZfPB3BBiA1ickTuGzUq2io741MMLk93BILUrKyuobI2pOID4ff/mWXbLN/EvdwKi5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXwBJXx+F1DsKFNsnrmWowaqGWiki5ntumsq4LqS1yE=;
 b=Mpg/8WSJGwzoIJzSXtS3ibawbkO2hDE/jX6cfWFQGUpPRFQHrAO84McBoQP1Occp/WcElxkckFDcy0UmZITEUeL24VojzQ8j2P22CDuUhzVhne6s7xhISGJDp9PhW8f0DiPypNoiFJucP371rBm8zKavtfBvrOivpLkwHsKnSN5goJLNkWvHl5qKkveX2PKKdXgI8PTk8hYhjRX5Lf+Ipe4oT/d/6mOFLIfcO0ywcJdBzIvIiMzYX+mrv5xwR4/IwTZAtthw1mZN4sGw9CzJCJEaWzvH5i85y3yauPBcvh3OUNhBBfqgj3IGbUwf9CbZJwB+bnWkvJGoQrgc3ZMyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MW4PR11MB7007.namprd11.prod.outlook.com (2603:10b6:303:22c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 02:50:54 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 02:50:54 +0000
Date: Fri, 15 Dec 2023 10:45:10 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
	<heng.su@intel.com>, <lkp@intel.com>
Subject: Re: [Syzkaller & bisect] There is WARNING in perf_event_open in
 v6.7-rc5 kernel
Message-ID: <ZXu9tn42ouzCZBt7@xpf.sh.intel.com>
References: <ZXpm6gQ/d59jGsuW@xpf.sh.intel.com>
 <ZXsbiAoAs_GqHGk6@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZXsbiAoAs_GqHGk6@FVFF77S0Q05N.cambridge.arm.com>
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MW4PR11MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 1efef831-958c-4708-3c29-08dbfd18a7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zehZCUUIuPJ7xFrCzEe41UX8QHcW0XjueTDPbBjZrRSdN8B2coQm5tiZjcVfrcEWE3pJcqDaGhr8ulbizCR9woqQXdIkbl5g+wtbIGRAnoW/WyzJYTuRJIFkBcrjC2ryF/bbaTUjMAg4fsnPMBDL1HN+GRMQnG68KRcuCaye8hk6CFtKiaw9oxMnwrmj1x8toPqkQ/qVIsJOwJuq3VC3i2uo/WfwMxQowakX7sBWYsamigiYQl+S+3/d56tcRakEMziA91bVCkn4nk/OiADzD2myRaDSjvqJlUb0HxmsbV+tP7aEaOz9tIjT6fBcHZAtruDQR7/H5WPm6zk0ftKaCMjdCqcIq945fd8rCQ/Tnol/UF1FnE671RwmS4nep6L3bJ8RGV8crUnFWuQaJFYqSVOKoE/7mNOAURStG95F3Il0aeZVo/ekC8XwP5EGRcLjbeu+hpCDCvuKU0hkwSbcrRX0FVYyN6uD8K7tJ9LbkGuyF1KH2nQTKJMYQoUnJn9mOtFhE8dQ5KWrIV4HjAU5TxzCk3/zVg9PZPXwgLlwqSWJUm6GtZnKqDsd7gO5kPPWXo7mhsBgG1mY530uI6syaS+QRJvlnRPNmdY1E1lDsiCVpiXR+ybXqFt8THqeywKSvH9hCHY/vikYEgE9xAf3Hr4YzkegluvMzMuMR9xG5NF8Qi/XvUmOa31zk/P2vc+y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2906002)(4001150100001)(4326008)(8676002)(8936002)(44832011)(86362001)(5660300002)(41300700001)(53546011)(107886003)(26005)(6512007)(82960400001)(83380400001)(478600001)(966005)(6486002)(45080400002)(6506007)(6666004)(38100700002)(66476007)(6916009)(66946007)(66556008)(316002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T1iJ7VOmMvVCFLk85ROJKu48I2ICVNIBkWqaPiA2xZaWRYR8VOx4zU3g5/Ho?=
 =?us-ascii?Q?nNTkMlN3MJ/DrtzLNOSD0UDuj3O4cvfE7llLFHY/A1sYhxUJHinnRpMRWlF1?=
 =?us-ascii?Q?NBmuRR66zwAmvQ4romrcje+JByjFGADMstF86Xi15xM8KN1pFVAnV85sgzp/?=
 =?us-ascii?Q?ii+q6fvP7IyJ2XEHvJzQftAZ4UCsJ/KU4F3ZHuEa36b9V6Al/kO6pnjxPcvO?=
 =?us-ascii?Q?BWX/dE9jvKh/RirRP2ouxhu59eK6jJHJP06CUNEMhJqBhp3+4vJgvHKn8k2T?=
 =?us-ascii?Q?5GK/dECO2Bp8snGHpbuzh1/cW695pXwr8zSfH8/Z7E4NB5s264zecDqbc2w9?=
 =?us-ascii?Q?wCcpOm4QzlxzC0ZWxnIdxH3tPAl9Tgqh7UGVyNsYZ9c0+uSdvf9IuivzAJvI?=
 =?us-ascii?Q?vuPmvv0nFQ7zAD0d3MiYn8REHHfmEDUtS2abzQq9ZolFqDye+VesZkxHjqQg?=
 =?us-ascii?Q?wQl62zjguvIKuEcs0/Fl3Wk0TDej+zvSAwtPMVa5FufSndQnGy3RciMJguU6?=
 =?us-ascii?Q?ID5IjgUkjRxDvOUIDlHIGKJy1PD81AfpMyXJr7s+JqsDzLTcUjkPu4d3lPgQ?=
 =?us-ascii?Q?5+7JInnfEYHIcHttm/tke7FkH8wSdBWE84IcuCZD1LdEL+GcZc0bVKxjFs/z?=
 =?us-ascii?Q?z1XcLDUgsBjHfngqVlAtOrVzcUoVAgz+gQt8B7fVjaiFIH3iibXSXJITA2B+?=
 =?us-ascii?Q?a8NGvaOaBY8bjyzynS/YM+u05NM8Cva8Foo23R85aL6IuYGGOG7R8KDNjGLx?=
 =?us-ascii?Q?7NQCFbKHvV1USLaeoh54ngmDv+pup+OT0jDCn1yMS7RaYHtG8GOrmNbLnnZJ?=
 =?us-ascii?Q?qTzmrd+L4gk3b/Gfb5ldu5JRvP1cs0bVDTkYPA/Mn0uIKqXoxPFyWGVd0zcD?=
 =?us-ascii?Q?eEsWAJs0ssK4rEDzDdw7SyEs5BrxUZDyxj9Jq+DC74RHobcExM4TgnsqTX4u?=
 =?us-ascii?Q?qqmK9LrdUKOyAabI6yCYOhA27o9gRbIjEcHED2jqFM/8w9PHpQ0dngCxTjqa?=
 =?us-ascii?Q?g9IjR5cH+CRUzRqAY8vpJHeL/1OP2+wdtt/EaLBCKhoKrCar6sHAjNQVKD5j?=
 =?us-ascii?Q?b1OKQNPsueAblNpL0brfUs9EnjxA90bOobUdYuOroYr5gQL1H6TatAL/4HKi?=
 =?us-ascii?Q?uW3ZEkgvE7fuixibvGVwPffYeHNs5UIb/pwtovZNsfBj5fJMRKSX2FFramxL?=
 =?us-ascii?Q?A+Pf2fUei3jgqikh65qiC4K2QpWG15+6WhxRu/x5QS3mj/nAfRMOxAXQLFB1?=
 =?us-ascii?Q?BkFzM+IT3vY4e/9lVbwDAMaXdZQ/Or+Vzy0AjPgM1UDHQcmMnlZ5ovqYs1Hm?=
 =?us-ascii?Q?OSFg1L3hs7lmbThguljJq3YKFEM+ZhdLNoQemCdqrtfL9M7l5dk/4f7Gi8L3?=
 =?us-ascii?Q?5iE28NrFWyKgDoYJ/9Lo+RBDbV/G9oaVQvWHZb5+UGAIBdqIKlmJZURmgJl5?=
 =?us-ascii?Q?+RY89UFoEQUMY33MnNCCYOHNldgsejXJxyTSY5FHcK1gfQT8sJiE8qd349YL?=
 =?us-ascii?Q?6+OByxTmafsTa3qFd2awB072VgOfXga4meaDSPfPaV2tg1Hb5qWl8I32mS4Y?=
 =?us-ascii?Q?dq6EfOLIrRo0Ecb6wrkTUyNppkLcAcXNXnv+vKle?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efef831-958c-4708-3c29-08dbfd18a7a5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 02:50:53.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sDTJYIBMNyMx8fszQVf3OnS2J5UzCYCj+ntKaGeWV79wy2R6aVF+B7cd15XmF5Tq2vw74CgqHG2jbQtm6fZPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7007
X-OriginatorOrg: intel.com

Hi Mark,

On 2023-12-14 at 15:13:12 +0000, Mark Rutland wrote:
> On Thu, Dec 14, 2023 at 10:22:34AM +0800, Pengfei Xu wrote:
> > There is WARNING in perf_event_open in v6.7-rc5 kernel.
> 
> > Bisected and found related commit:
> > "
> > 382c27f4ed28 perf: Fix perf_event_validate_size()
> > "
> 
> I believe this is the same issue that Lucas reported at:
> 
>   https://lore.kernel.org/lkml/20231214000620.3081018-1-lucas.demarchi@intel.com/
> 
> ... please see the analysis there.
> 

Thanks for your information, glad to know the latest status.

Thanks!

> Mark.
> 
> > Revert on top of v6.7-rc5, this issue was gone.
> > 
> >  [   23.133852] ------------[ cut here ]------------
> >  [   23.134146] WARNING: CPU: 1 PID: 727 at kernel/events/core.c:1950 __do_sys_perf_event_open+0x2ba3/0x2c50
> >  [   23.134752] Modules linked in:
> >  [   23.134924] CPU: 1 PID: 727 Comm: repro Not tainted 6.7.0-rc5-a39b6ac3781d+ #1
> >  [   23.135292] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> >  [   23.135882] RIP: 0010:__do_sys_perf_event_open+0x2ba3/0x2c50
> >  [   23.136212] Code: 48 8d b8 a8 00 00 00 e8 5b 99 bb 03 bf 01 00 00 00 41 89 c5 89 c6 e8 fc d9 c9 ff 41 83 ed 01 0f 84 81 ec ff ff e8 fd d7 c9 ff <0f> 0b e9 75 ec ff ff e8 f1 16 29 00 e9 d1 ec ff ff e8 77 17 29 00
> >  [   23.137194] RSP: 0018:ffff88800cb27d88 EFLAGS: 00010293
> >  [   23.137465] RAX: ffff888010ea8000 RBX: ffff88800d44bd40 RCX: ffffffff8196ccf4
> >  [   23.137832] RDX: 0000000000000000 RSI: ffffffff8196cd03 RDI: 0000000000000005
> >  [   23.138229] RBP: ffff88800cb27ef8 R08: ffff888010ea8000 R09: fffffbfff11c7a2a
> >  [   23.138724] R10: 0000000000000001 R11: ffffffff88e3d14f R12: ffff88800d44bd40
> >  [   23.139126] R13: 00000000ffffffff R14: 0000000000000000 R15: 1ffff11001964fbe
> >  [   23.139492] FS:  00007fef8c620600(0000) GS:ffff88806cd00000(0000) knlGS:0000000000000000
> >  [   23.139901] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  [   23.140223] CR2: 00000000200000c0 CR3: 000000000d90a000 CR4: 0000000000750ef0
> >  [   23.140619] PKRU: 55555554
> >  [   23.140778] Call Trace:
> >  [   23.140920]  <TASK>
> >  [   23.141049]  ? show_regs+0xa2/0xb0
> >  [   23.141236]  ? __warn+0xef/0x340
> >  [   23.141412]  ? report_bug+0x2f6/0x570
> >  [   23.141616]  ? __do_sys_perf_event_open+0x2ba3/0x2c50
> >  [   23.141881]  ? report_bug+0x360/0x570
> >  [   23.142083]  ? __do_sys_perf_event_open+0x2ba3/0x2c50
> >  [   23.142385]  ? handle_bug+0xa4/0x130
> >  [   23.142668]  ? exc_invalid_op+0x3a/0x90
> >  [   23.142956]  ? asm_exc_invalid_op+0x1f/0x30
> >  [   23.143241]  ? __do_sys_perf_event_open+0x2b94/0x2c50
> >  [   23.143506]  ? __do_sys_perf_event_open+0x2ba3/0x2c50
> >  [   23.143788]  ? __do_sys_perf_event_open+0x2ba3/0x2c50
> >  [   23.144089]  ? __do_sys_perf_event_open+0x2ba3/0x2c50
> >  [   23.144397]  ? __pfx___do_sys_perf_event_open+0x10/0x10
> >  [   23.144697]  ? trace_hardirqs_on+0x26/0x120
> >  [   23.144951]  __x64_sys_perf_event_open+0xc7/0x160
> >  [   23.145202]  ? syscall_enter_from_user_mode+0x51/0x60
> >  [   23.145476]  do_syscall_64+0x42/0xf0
> >  [   23.145670]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >  [   23.145940] RIP: 0033:0x7fef8c43ee5d
> >  [   23.146145] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
> >  [   23.147095] RSP: 002b:00007ffe0ede25a8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> >  [   23.147633] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fef8c43ee5d
> >  [   23.148052] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200000c0
> >  [   23.148451] RBP: 00007ffe0ede25b0 R08: 0000000000000000 R09: 00007ffe0ede25e0
> >  [   23.148860] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe0ede2708
> >  [   23.149263] R13: 0000000000401b49 R14: 0000000000403e08 R15: 00007fef8c661000
> >  [   23.149654]  </TASK>
> >  [   23.149775] irq event stamp: 1131
> >  [   23.149961] hardirqs last  enabled at (1139): [<ffffffff81420a0d>] console_unlock+0x22d/0x240
> >  [   23.150428] hardirqs last disabled at (1148): [<ffffffff814209f2>] console_unlock+0x212/0x240
> >  [   23.151012] softirqs last  enabled at (944): [<ffffffff8556dd60>] __do_softirq+0x4f0/0x791
> >  [   23.151445] softirqs last disabled at (935): [<ffffffff81266fb1>] irq_exit_rcu+0xc1/0x110
> >  [   23.151884] ---[ end trace 0000000000000000 ]---
> > 
> > 
> > I hope it's helpful.
> > 
> > 
> > ---
> > 
> > If you don't need the following environment to reproduce the problem or if you
> > already have one reproduced environment, please ignore the following information.
> > 
> > How to reproduce:
> > git clone https://gitlab.com/xupengfe/repro_vm_env.git
> > cd repro_vm_env
> > tar -xvf repro_vm_env.tar.gz
> > cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
> >   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
> >   // You could change the bzImage_xxx as you want
> >   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> > You could use below command to log in, there is no password for root.
> > ssh -p 10023 root@localhost
> > 
> > After login vm(virtual machine) successfully, you could transfer reproduced
> > binary to the vm by below way, and reproduce the problem in vm:
> > gcc -pthread -o repro repro.c
> > scp -P 10023 repro root@localhost:/root/
> > 
> > Get the bzImage for target kernel:
> > Please use target kconfig and copy it to kernel_src/.config
> > make olddefconfig
> > make -jx bzImage           //x should equal or less than cpu num your pc has
> > 
> > Fill the bzImage file into above start3.sh to load the target kernel in vm.
> > 
> > 
> > Tips:
> > If you already have qemu-system-x86_64, please ignore below info.
> > If you want to install qemu v7.1.0 version:
> > git clone https://github.com/qemu/qemu.git
> > cd qemu
> > git checkout -f v7.1.0
> > mkdir build
> > cd build
> > yum install -y ninja-build.x86_64
> > yum -y install libslirp-devel.x86_64
> > ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> > make
> > make install
> > 
> > Best Regards,
> > Thanks!

