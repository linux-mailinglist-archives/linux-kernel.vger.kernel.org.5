Return-Path: <linux-kernel+bounces-27127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAE982EADF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F25CB22FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F1911CBB;
	Tue, 16 Jan 2024 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PY5PtrpO"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB3311721;
	Tue, 16 Jan 2024 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705393788; x=1736929788;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=yZFDiFmFKXv3rs+0y90HbTVVfOOeVOMurQYyTf+Ho8Q=;
  b=PY5PtrpO2BlIwTXoPwQsq+y7SS8b3frzsLQyIFHIpgD2lvM3sxZnXWKx
   DcvBg2EP6fXVW9hnEMZx3agMXr8o0hvsuHFNBmg5zezlqMt6qS+xxLFOT
   6BonZEkN3/DnCZRZRgZLhuglfPGdgLpGJq8NxLb5ngt1bnuaZT2CyeUlV
   meplodXjdpwOBASlC0XL9QQzkeM0F17ChFfxwj75aHBxWj9pRqI3I/n9K
   Wu5d69qC46tmGZrSuvJnRo0IeCy9dXCg1OO9hFQDy8BB0set9DDPUzRb+
   z7ZVa74TeKt/v65KAr/YDKBaS+IqgW04IfljpKFZY2qgXTV+C0ytURDye
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="485941938"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="485941938"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 00:29:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="787366621"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="787366621"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 00:29:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 00:29:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 00:29:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 00:29:46 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 00:29:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lerHv3O77DDF884c2DiFs1srEmq094VTWF27IUW+dTIelDGPiBuG3HNQMPkinb8zxubVp+9dHy9P/ZgaGJcp+/Ka14Qk/sgPaH+ZmDNxTtePUbMY+mwrn8BpkSw1huEWGdPWqBKu581v/yf7k66Ak7nykhIKOeBIDPV+R2dn67m84rxWaa2aRvqewYsMseoUfYurYYfsGoimGhuLJouiIO5MnnGSsK7jsezr3ZKe9+Fth5b/P7bkknBQng6nY8NwZICZ9E20Eux00IEKC1wn0vGvsyor9D+/Gri/YpzoHXs9BQv0v0U17glGmzdJnEN76RI636EpXDdtZC9La4yItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Pfx8Z0KwLkK7fNAY88uh9Wfpy/DJeERrbFvQHr6GyQ=;
 b=f6HciYX2TA0y2C9svHT+pTiU8cK/r0OOnvSwnUg5w+BsInJfllaX8tejLnlR3gTmrGv4oQYX0SVWSJ8leAfo+YJJrcGu+6NUygD3PwgGkN31Bnc8ZStpFcqSJaOwOpEUw841M1jCS6ua3dunzqIe+83hLjs/r+OEZp5Rmw3UoVwzRQWHpanS4o9vEso3hy7AsXusPGrbB8V64tjD/V867GUfd+3oMFAhX3KLSny3of/E+MxVguUH0eeTXBhWpUnM76scIke6hxh8u1lU74d3d/alHK3XVwDVFza5PCN6HhSIfYcGGXEPR4LaFC/o7kA8VZYJjDKh+D9EveqvQeobfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB5689.namprd11.prod.outlook.com (2603:10b6:610:ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 08:29:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Tue, 16 Jan 2024
 08:29:44 +0000
Date: Tue, 16 Jan 2024 16:29:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Gui-Dong Han <2045gemini@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <baijiaju1990@outlook.com>, Gui-Dong Han
	<2045gemini@gmail.com>, <stable@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] tty: fix atomicity violation in n_tty_read
Message-ID: <202401161610.edf0ac63-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240112125801.2650-1-2045gemini@gmail.com>
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: 2309fb7d-9db4-4b70-6c68-08dc166d4ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GTCBF0mSXGjtUNfwtYSZSnlm9IH/BZfI6Fd89hZ80JRs+coUGNgdIz/h7oAX4oXCflqFM/p0SU7jvEcNl0+iN2lDrO6bFQUX/NJIMYRahBjIRjbLL7ypmIyA6GuZQne+uOGDGng/p0knhFEBk75hT7r1sQUPD6Vxct1P7VMt8ZFU2uNY8sopCgQRNl8sRRQnN66ScG5Sem9grPAqSNzAOe/eNb3iK4Wv83400bzGuctgkHkM12fsKncojYwKOYo0zNWCDNyRwIy94n8sSpotSyF/rwJkNU0eUPTq/mPKY46umWCEYFQCLUg9DeZuuZy2R/uL0Cg0JwkDlyBc+eyA98WtmWLzFnH773BJtNbez3J8xnHlFMmtkG0fHArMsuhem0C/OXqLWDoftOt4vBrJPYJTAXBnjWg2QeiaJrqwMLzrVxuXMX7vAeQspl+RJzBiNUmO/GuyZLbSougCvys6mfBhtYjmG3Kqgyqz0BjtfAA7SanO8AniIUYxqUGh1PWVUDuv330peQt4QJv/iqgvc+Dw/TB2KXXBDfmYwqoe6Gr+OfjYWjmr8DRP+slCKMkMctKFPwsHalbv7XzlRtBWkYj6uprCBldz+JG2yvEgLblyISP+wUEvEJtoJTKkgV0sVROkokTIrx5Ioqzaf6GS+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(107886003)(1076003)(26005)(2616005)(83380400001)(38100700002)(82960400001)(66556008)(41300700001)(8676002)(8936002)(6916009)(316002)(5660300002)(66946007)(6666004)(66476007)(2906002)(4326008)(966005)(478600001)(6512007)(6506007)(6486002)(36756003)(86362001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oDFjQnDCNIZ6osIgkJmI7U91OMqzwdHMKvQW9vmn0AJxZL+XuBj+L334vyCI?=
 =?us-ascii?Q?4w23817fyuvr8uxCgxgIDSUjyhptsJ/4xBeG1L1h8JcZcdrilCWD3YZTqDQX?=
 =?us-ascii?Q?2zTmPf4nPrwFhUCmN7DPuHG/x9KvftvYRGLfxs+6ZGcuH6DLLd81bY6dbIvP?=
 =?us-ascii?Q?JR8LQOAH9/WhNs4fC4npSV+lbU5Iq/uhhoN6pug20bDvwm52X6fxCYwKnhiw?=
 =?us-ascii?Q?6g5SfguDU+fldcgrEJMBOxMIvv1cilPASkVqEWgDcS3+XmPFs718SGRRxEe7?=
 =?us-ascii?Q?zOroVZhAsgV/9I0qVwzsKj0igD3UMbQSxWG3Slq0jyxC2ykAUb7SWdAjRA5g?=
 =?us-ascii?Q?PADU8cQ53Edgv94zMZWbMEM8WUrXdT5E61vk9Ix82IcmBj7FT4g39uX2u01R?=
 =?us-ascii?Q?DkB1yVLJbOzAFMnEfkkH7CdSGs7+KmvfC8ygHHfZh3HawxaUmHPrcIwLpT4X?=
 =?us-ascii?Q?85LNr/NQa9+ZM4E6O9bZHAmAyT0NnwVBrhB5zM5S2d4SlParwEK3q7qa8mkt?=
 =?us-ascii?Q?A6YML5W3023PO2zn7IH2Si0qTlggIhRZ4Ohh4+bx2N1WJTrE1tZs8MwR0ADM?=
 =?us-ascii?Q?rHxweeswBbttaoiSDYZLnS57rHZFHkL6CnOKV+alNg7H8BZGwYsblj6NIRjz?=
 =?us-ascii?Q?ZSVp+79/luwZTy52ilqBeLs8QznCsDSdDQtWt52u8cHfQEMa+FEh7+zGfngK?=
 =?us-ascii?Q?rwAFhxmCRblG/Nb5Ukto09AdmdXh7CXZzQwwF0ZEke1pZQWA6UBXIIjVyrPp?=
 =?us-ascii?Q?LjDlMwy1PlUJezcPJ2lgq7o3f5PvUgaNUwViUfDXm40eaTHhAWchUVPB4DaR?=
 =?us-ascii?Q?L9UN2HfFBshcCnVaydtZ7A2RosKaUlDnvP+eiXvNZeSFhMi5j1YuX6RsReDQ?=
 =?us-ascii?Q?4MSd11GqrHbC63noyvahZBAbxsDniGnI09I/zIOTn4BoWu0xhfvceotDjcsf?=
 =?us-ascii?Q?Aq0tLy74MA2+/GoBEdHFoGvth9DHrPCew/KZwyobyGa5SiaUlQ0LZjYwpyYp?=
 =?us-ascii?Q?ytNBSJUBYkKiNk6hkXUBhsHl1KEAmaGPctkAqkssHpIVrDngNdpPC34vHdcQ?=
 =?us-ascii?Q?2BeQ85G+d9gNl/nXNHhJsfsaLYPgPSGHxAdze0q6aaasbAC3S9g0dyGcIJXT?=
 =?us-ascii?Q?9JLhZ5oQQHTf5AixccIhdV/8iLO2Dd5GtUglkJjFQeHFb4m5l3p2EVTsa/cL?=
 =?us-ascii?Q?F5DwcP2zqI+IFtHnCXFoR4lhQ/Ji0J+IP8v4BoOmGiXg1PoCQ33qMaHaOpJU?=
 =?us-ascii?Q?pbU+SmXYbwNEDyoUWMJi6wVTWZ5xS1AaTuafCv05dH5bN4VwuPDMcClGSpVO?=
 =?us-ascii?Q?PKywyBd9f5OvBES1dCa4zOuYevz7HJBfg1Eu3fJrWdaOGvF1xB3dLf+F8nQd?=
 =?us-ascii?Q?7lN7xUYVaNhnzwibemfHhEBr7tEhS81rBrO/3zcxCV2R/Y43q1tnDrm9w5lu?=
 =?us-ascii?Q?L454gOG7GUuku23vUMlzjOdQH0+nAMgbZ0rLkoSpm7aO5p0xmamYjFw3RCg8?=
 =?us-ascii?Q?BOmVdNNllfrF1ng99fDdsHrnnpNZSdWUzx3kzeExubAyHtD7QU27TYXL/WwB?=
 =?us-ascii?Q?tTJoLgpzWRHELs+IjTnbZds5jB1kbykdZc29x+LR18drCPqBW0lTMtEhMiAU?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2309fb7d-9db4-4b70-6c68-08dc166d4ab3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 08:29:44.3771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpr9VPdOhUlOKsWri4WRGN+oTmMMMmBcsxV1XOwgFtn92W/1S5k1sPvOFDR9jGfG0wxfV/H9WKOd8MuAznj+Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5689
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 5c6ca526d56e87f85cf980c77f7470e76e5dd5f7 ("[PATCH] tty: fix atomicity violation in n_tty_read")
url: https://github.com/intel-lab-lkp/linux/commits/Gui-Dong-Han/tty-fix-atomicity-violation-in-n_tty_read/20240112-205942
base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git tty-testing
patch link: https://lore.kernel.org/all/20240112125801.2650-1-2045gemini@gmail.com/
patch subject: [PATCH] tty: fix atomicity violation in n_tty_read

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | 0c84bea0ca | 5c6ca526d5 |
+---------------------------------------------+------------+------------+
| boot_failures                               | 0          | 6          |
| BUG:kernel_NULL_pointer_dereference,address | 0          | 6          |
| Oops:#[##]                                  | 0          | 6          |
| RIP:_raw_spin_lock_irq                      | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 6          |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401161610.edf0ac63-oliver.sang@intel.com


[   53.979086][  T401] BUG: kernel NULL pointer dereference, address: 00000000000001d0
[   53.989877][  T401] #PF: supervisor write access in kernel mode
[   53.998103][  T401] #PF: error_code(0x0002) - not-present page
[   54.006595][  T401] PGD 800000011f423067 P4D 800000011f423067 PUD 303527067 PMD 0
[   54.017130][  T401] Oops: 0002 [#1] SMP PTI
[   54.022798][  T401] CPU: 1 PID: 401 Comm: getty Not tainted 6.7.0-rc5-00199-g5c6ca526d56e #1
[   54.032166][  T401] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 54.046197][ T401] RIP: 0010:_raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 54.054135][ T401] Code: cc 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 fa 31 c0 ba 01 00 00 00 <f0> 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e8 1d 01 00 00 90 c3 cc cc
All code
========
   0:	cc                   	int3   
   1:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   8:	00 
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	f3 0f 1e fa          	endbr64 
  1d:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  22:	fa                   	cli    
  23:	31 c0                	xor    %eax,%eax
  25:	ba 01 00 00 00       	mov    $0x1,%edx
  2a:*	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)		<-- trapping instruction
  2e:	75 05                	jne    0x35
  30:	c3                   	retq   
  31:	cc                   	int3   
  32:	cc                   	int3   
  33:	cc                   	int3   
  34:	cc                   	int3   
  35:	89 c6                	mov    %eax,%esi
  37:	e8 1d 01 00 00       	callq  0x159
  3c:	90                   	nop
  3d:	c3                   	retq   
  3e:	cc                   	int3   
  3f:	cc                   	int3   

Code starting with the faulting instruction
===========================================
   0:	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)
   4:	75 05                	jne    0xb
   6:	c3                   	retq   
   7:	cc                   	int3   
   8:	cc                   	int3   
   9:	cc                   	int3   
   a:	cc                   	int3   
   b:	89 c6                	mov    %eax,%esi
   d:	e8 1d 01 00 00       	callq  0x12f
  12:	90                   	nop
  13:	c3                   	retq   
  14:	cc                   	int3   
  15:	cc                   	int3   
[   54.079836][  T401] RSP: 0018:ffffab01406cbcd8 EFLAGS: 00010046
[   54.088222][  T401] RAX: 0000000000000000 RBX: ffffab01406cbdc8 RCX: 0000000000000000
[   54.098106][  T401] RDX: 0000000000000001 RSI: 0000000000000246 RDI: 00000000000001d0
[   54.109098][  T401] RBP: ffffab01406e9000 R08: ffff9dfa447a2210 R09: ffff9dfa447a2210
[   54.119762][  T401] R10: ffff9dfa447a2210 R11: 0000000000000000 R12: 0000000000000000
[   54.130902][  T401] R13: 7fffffffffffffff R14: ffff9dfa447a2000 R15: 0000000000000000
[   54.141603][  T401] FS:  0000000000000000(0000) GS:ffff9dfd2fd00000(0063) knlGS:00000000f7e1f900
[   54.153625][  T401] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   54.162764][  T401] CR2: 00000000000001d0 CR3: 0000000144742000 CR4: 00000000000006f0
[   54.171900][  T401] Call Trace:
[   54.182172][  T401]  <TASK>
[ 54.186095][ T401] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 54.191409][ T401] ? page_fault_oops (arch/x86/mm/fault.c:707) 
[ 54.197798][ T401] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561) 
[ 54.204312][ T401] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
[ 54.211244][ T401] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 54.211300][ T401] n_tty_read (drivers/tty/n_tty.c:2226) 
[ 54.216906][ T401] ? __pfx_woken_wake_function (kernel/sched/wait.c:439) 
[ 54.233693][ T401] tty_read (drivers/tty/tty_io.c:862 drivers/tty/tty_io.c:937) 
[ 54.239403][ T401] vfs_read (include/linux/fs.h:2014 fs/read_write.c:389 fs/read_write.c:470) 
[ 54.244978][ T401] ksys_read (fs/read_write.c:613) 
[ 54.249805][ T401] __do_fast_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:321) 
[ 54.255574][ T401] do_fast_syscall_32 (arch/x86/entry/common.c:346) 
[ 54.255607][ T401] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:121) 
[   54.255641][  T401] RIP: 0023:0xf7fce589
[ 54.255671][ T401] Code: 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
All code
========
   0:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter 
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq   
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	retq   
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   f:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240116/202401161610.edf0ac63-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


