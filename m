Return-Path: <linux-kernel+bounces-4922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB2A8183DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BE02895B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975E513FFD;
	Tue, 19 Dec 2023 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSGCINHD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094721426E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702975789; x=1734511789;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sjp5EFzcj+qSu/mBTY2KvC15jZx4d080M1MfE1sHJHo=;
  b=LSGCINHDBnZqtBxPsiiqIJunO7/azCgsgS/Fkj5O/bC/vl2b6fIp0Qm5
   ac4Wm6QIyNj4O0Fe9JrGIUwE9ZExdmDO/ZjmFdOmgOZHj7A7rsu1sSN9j
   Ow95uzMcjyTsyxcoUuYa9ZMKFBKl2HZcEYBB+2gVq1ZGN87SOUP3K0o5n
   r9cADPgXaODSDKVKXtb5oQ3G7KTtq5dN5F83a3f5+bpWQ6mwcJ8kmiy3S
   irfFhYguwnUlbFBn/B0p0YMGP9dtMQI2wLKBK+ZDAQe/1QbiN/+WIbpWf
   1Ld90+UMkrHjIWCYaEC/wKkUbzdtX5iE21K68yokxu66lKTox1HE1Qdyp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="380610343"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="380610343"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:49:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="894209583"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="894209583"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 00:49:38 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 00:49:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 00:49:36 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 00:49:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 00:49:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDIfoNREHVyCYm0+qWFUcm5fO7T6WbHrz+6m0gG4XEpYShGwgdlCtuflpRgUFgOmZOIe+6LFPPZSrS9HlJIFfn1E2MZCEDB+W9aTI9xCZtJmMga+nNFwZ3RFjDMKZodPKWZvU33YqMoidpTJ6gc7jxe3O69BY8PtQa9kN/3a+cngZ4CHcM6XWu6AgeFzWB1DthXoXRpL2u1aNbeVMhKo8OHdA4V4Za8rxgWVF0vhG1u2JLD+g4VzSGINQGFdcevoRJOYpeuQFry+m5MQU6X063+IVPKlQZls9BxuatyPh0td5M2Lwv5N9kvkYdY9Fg6IihikVsYZuie/5e3xq5Yn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOXdzrJ6+1UHBG42aTYWmbfLvMzz57z2ASVhoKtIVOI=;
 b=Tf2F4zn00rKcMACL7EdBxyfF1Ty9pGBEmbUI3p7hR2FlBjcEnmS0FIhmAwCt/4YGNh75fMpM4QayJQAniNvEnRGmAKCLSodyDdlIS8wpGdr0Q8v0FIH7Q66Ig7s5ObALgSj++qEUeRoZzLXHyrKJH6jyKfYDgPzuKqv4ZsGAbqT+tihe7lcXZAfHaCyoxt+xT3TmgXak7M0or27LIrmL8gPeb/itCTycNpUSWgsBUytvEKFURFDNh7/7QgB7jlLL81c0mHgHC3b9NxhuNSLleFSB7t1BVFubvH3NGCcRYwblTQtlTRjJVsDNIBkHyHMexjsqwOcRx/xkhc4qS1ym3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB8419.namprd11.prod.outlook.com (2603:10b6:208:48b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 08:49:23 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 08:49:23 +0000
Date: Tue, 19 Dec 2023 16:49:14 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, Linus Torvalds
	<torvalds@linuxfoundation.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
	<xen-devel@lists.xenproject.org>, <oliver.sang@intel.com>
Subject: [linus:master] [x86/entry]  be5341eb0d:
 WARNING:CPU:#PID:#at_int80_emulation
Message-ID: <202312191507.348721d2-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: db540eb1-6877-498c-b44b-08dc006f65ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8Jq4Bl9NX7NXrxmk2o9VTeByu4flTIhwFgXQ62VtnyZ0G5r9nbDZy71yiEsuxUj6fF06DTe6/X9HkKxOB7I16PB7AX6uXHF+T0yeXRkZiOIp2UQtfrWMDa/asrjmLVoZxdDsN043eu+bX4/Sa6Q89/Yfl6IH1rDZQTbtAvSAWngHd8sqY4VEM6sYKr3UGwn67SOuMJXUsi8x2Vko0+9OJDvVRmmpILdxDAh7u5soIbuPcEiYgfZhxlXKsTy4/dhymCq0uhNygmpXCJnXgczIfhIjZyqy082cuN9p0D4ZZoO7VftmErqh66UMmfvlboP1FpqTgMfhluiwu2NMuhZj0pPoxcR6fsXvIoHfWyqGuF4RZYd+kF+FljzzHm/OU05/W8YWLqHXLVkpwwVG/GGjUSGxiWmPdgorVRuhbWn449UaL17OKjpXAVRQ97rhodSZc7DYrCucFzv+Ri4HF4tuY8Q+ehh6VISb+P+NN6KwkXHnLTWgTVVWwRzxDROzERRU0wmZZWIbomq9+iMxf86i0hTioI5l6yZe8CzC3+YCt/JTH8z6+UCB0vcBjhP/hmp/8T90MWiI/+FKNhMgq8pPAxvTE13mFqxWTucIxjExhUQ8OYyo8AHw2RMZjakaomAePA3uT8PvtUVzSvgtTRGyBvOYLQ3piNKeSiET6+tYRXOc+H5yI4v24ZFj6YPm9li
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(66946007)(2616005)(478600001)(6916009)(66476007)(316002)(54906003)(66556008)(38100700002)(6486002)(966005)(26005)(1076003)(8936002)(8676002)(4326008)(6506007)(45080400002)(6512007)(6666004)(5660300002)(2906002)(86362001)(82960400001)(36756003)(41300700001)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c/jYsxpGEkGq/A/w5KRYNzFUlSVD7co9epmlUh2ZiffI6IjkbzZq9t0NZb+c?=
 =?us-ascii?Q?h1OjtbmNyUuKbBFs/Z0/st107+4ULdVNyAw8Zlg3k0WQ6SSNyCH+H+oJ9cI/?=
 =?us-ascii?Q?ilZTJ0ZzJ98zIx5wsPcc/zD57tc1CEEd8onC17pR0egJ50HZDZXwRfqGJbFp?=
 =?us-ascii?Q?B6mHEjOlPdXpy3AzyjtUOP2Kwn5T3IkUuwZgEZW3rOlCuNPmvNIMmCtuYdol?=
 =?us-ascii?Q?LnczYgMt7/Qo3lhNyPfv1+vos8T7RnQJIMMI0UyVWAcryiXpouEWhCnj+SD5?=
 =?us-ascii?Q?HnEJEDU+qYqc0Wgx8GeaPFe+dGH0IL5Xt3kaF25M3qaQLHK5Q04gGWzM5exc?=
 =?us-ascii?Q?Ql/MRlU/pBUxzqL6c6XXcdneIcdwDY+If1EjobTKAjct3xm9Nixgk+ineFN+?=
 =?us-ascii?Q?xmvQCG+W40B8brLEQ+kmlKzZeB6Pma0g8JXfx2gqsdWAECN2mTCc+jaSj/8I?=
 =?us-ascii?Q?Djsa9F067lXoEu3laUoS07ETjPH35mgt6/tTFoGArwIhPU1Hiu4GO0xSG+tZ?=
 =?us-ascii?Q?jnm3RPlouEzsiHsw4WVzJD70giHP/oWr/JiQon0HMdfgl+8YqjOTxdQuvVjT?=
 =?us-ascii?Q?4p0Jm8raH0yMaNsjX11WWK/IKc1K0xYwsrD5CRv/bytw4ROvjUrI7pwl644O?=
 =?us-ascii?Q?7HQO3Oy5CTXPwdbE8lNtv54DHcLjPkmDg9pk0eq8470lWFDuTRJdr+Y8Cvxl?=
 =?us-ascii?Q?a0Ey5b4pY9dc7u3lKK/h5LSlEhI3yLUq75cf/hPz+pGwO5e9hjKeiT7GUzcq?=
 =?us-ascii?Q?KF4TdGuBzfgY1mv99XIkTF3/vs8A+cDCZxYiNHJOG2ZSZu9YxRDPlMuQA2BN?=
 =?us-ascii?Q?XDmJYLW6o/e1zjYMB+qGjCj6GnjknoQQKUIAK92sE+vOqDgEyTazMXbiKh+X?=
 =?us-ascii?Q?x2H29LcULcpfc7TSCWSkpSiDEz52pKlIiAu970xm6TNr+4nYNifaC2ecYUo8?=
 =?us-ascii?Q?ByzZ3COuTqORuxj/id7FXImh+utgxewTw0UoxiWeShpO87iTTxxoUl9YGC9c?=
 =?us-ascii?Q?CDrxooe9qnu+f3OT04dk+4zoZ+Mfa1kCnWTg+2RgNjhB+qJOArTi+mLw0+CI?=
 =?us-ascii?Q?LDtQzZ1oQBFKYMZoL1Ptpvl6PbO6vZr3Vfzjfo09BViqL0dWaV8GTO3Ps1xV?=
 =?us-ascii?Q?g9UawnoFLYJSXdIvHNwzu0np7s8smfKcII4skBjW4KJl2Z6LfR8aFwaXlq9r?=
 =?us-ascii?Q?RiHLgC9Ia9MTLSrgbaxmhj5iHAUA5YMjGCkiPUU1HiRNvbHHI+ufw++c+k3T?=
 =?us-ascii?Q?uLLqBlQG1UG7o2LV0c1IZIuovfYzdxcD13/OL4RaeY6G08BOhfrLjN9LVTSK?=
 =?us-ascii?Q?w9kZALYveX9QamzYDkXzrmYx2V3I+B5e5aoX1tI337SzO3KURb1umYN9pUdt?=
 =?us-ascii?Q?45aw+fvf9vXSAPEoc0SG+FuuT6DLReDof771ZXX+q4KYTk4ORnCV1xL95/iw?=
 =?us-ascii?Q?Z/17+XZMIdJsZVIpf6qBkolDIF9vxSkupkodl7FkxZwrobM8KRZTh+S/IXh9?=
 =?us-ascii?Q?fKvNvpf9B6cdNn1Lw3DtqmuEybg5VxtLrCRAsww9rbd2PpGyQptyXULMJ7xc?=
 =?us-ascii?Q?b/V+RLUJnmmsVPg4xbDZVaawexJGHPeJdaIhqdS2NglRYsbUEbwuOigaOc0c?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db540eb1-6877-498c-b44b-08dc006f65ad
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 08:49:22.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvQwqgSVDhd5t48a5beSP05HV2vTB4IanM/mezdq5ge4sTzycp80CJ9MKFky+ydvJ+4FBPLbOJEWz1OfS1gAjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8419
X-OriginatorOrg: intel.com


hi, Thomas Gleixner,

as we understand, this commit be5341eb0d doesn't introduce new WARNING, it just
converts the WARING in another type.


b82a8dbd3d2f4563 be5341eb0d43b1e754799498bd2
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          9:9         -100%            :9     dmesg.WARNING:CPU:#PID:#at_do_int80_syscall_32
           :9          100%           9:9     dmesg.WARNING:CPU:#PID:#at_int80_emulation


however, we failed to bisect dmesg.WARNING:CPU:#PID:#at_do_int80_syscall_32.
at the same time, we are not sure enough if this WARNING worth to care? or it's
just due to our test config (we used a randconfig in this test which could be
got from below link).

so we just report to you what we observed in our tests, in case it's still
expose some potential problems, and maybe you could find correct owner to make
some code fix.


Hello,

kernel test robot noticed "WARNING:CPU:#PID:#at_int80_emulation" on:

commit: be5341eb0d43b1e754799498bd2e8756cc167a41 ("x86/entry: Convert INT 0x80 emulation to IDTENTRY")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master 11651f8cb2e88372d4ed523d909514dc9a613ea3]

in testcase: boot

compiler: clang-16
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



[ 13.481107][ T48] WARNING: CPU: 0 PID: 48 at int80_emulation (arch/x86/entry/common.c:164) 
[   13.481454][   T48] Modules linked in:
[   13.481655][   T48] CPU: 0 PID: 48 Comm: init Tainted: G                 N 6.7.0-rc4-00002-gbe5341eb0d43 #1
[ 13.482162][ T48] RIP: 0010:int80_emulation (arch/x86/entry/common.c:164) 
[ 13.482437][ T48] Code: 01 00 00 77 43 89 c1 48 81 f9 c9 01 00 00 48 19 c9 21 c1 48 89 df 4c 8b 1c cd 90 12 20 9a 41 ba 27 cb d4 4f 45 03 53 fc 74 02 <0f> 0b 41 ff d3 48 89 c1 48 89 4b 50 90 48 89 df 5b 41 5e 31 c0 31
All code
========
   0:	01 00                	add    %eax,(%rax)
   2:	00 77 43             	add    %dh,0x43(%rdi)
   5:	89 c1                	mov    %eax,%ecx
   7:	48 81 f9 c9 01 00 00 	cmp    $0x1c9,%rcx
   e:	48 19 c9             	sbb    %rcx,%rcx
  11:	21 c1                	and    %eax,%ecx
  13:	48 89 df             	mov    %rbx,%rdi
  16:	4c 8b 1c cd 90 12 20 	mov    -0x65dfed70(,%rcx,8),%r11
  1d:	9a 
  1e:	41 ba 27 cb d4 4f    	mov    $0x4fd4cb27,%r10d
  24:	45 03 53 fc          	add    -0x4(%r11),%r10d
  28:	74 02                	je     0x2c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	41 ff d3             	call   *%r11
  2f:	48 89 c1             	mov    %rax,%rcx
  32:	48 89 4b 50          	mov    %rcx,0x50(%rbx)
  36:	90                   	nop
  37:	48 89 df             	mov    %rbx,%rdi
  3a:	5b                   	pop    %rbx
  3b:	41 5e                	pop    %r14
  3d:	31 c0                	xor    %eax,%eax
  3f:	31                   	.byte 0x31

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	41 ff d3             	call   *%r11
   5:	48 89 c1             	mov    %rax,%rcx
   8:	48 89 4b 50          	mov    %rcx,0x50(%rbx)
   c:	90                   	nop
   d:	48 89 df             	mov    %rbx,%rdi
  10:	5b                   	pop    %rbx
  11:	41 5e                	pop    %r14
  13:	31 c0                	xor    %eax,%eax
  15:	31                   	.byte 0x31
[   13.483405][   T48] RSP: 0000:ffff9d1ffbbd7f40 EFLAGS: 00010a92
[   13.483713][   T48] RAX: 000000000000001b RBX: ffff9d1ffbbd7f58 RCX: 000000000000001b
[   13.484112][   T48] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9d1ffbbd7f58
[   13.484510][   T48] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000002b
[   13.484910][   T48] R10: 00000000c26707b6 R11: ffffffff993719d0 R12: 0000000000000000
[   13.485314][   T48] R13: 0000000000000000 R14: 000000000000001b R15: 0000000000000000
[   13.485715][   T48] FS:  0000000000000000(0000) GS:ffffffff9a85c000(0063) knlGS:00000000f7fc7040
[   13.486168][   T48] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   13.486500][   T48] CR2: 00000000f7fc2204 CR3: 000000013b76a000 CR4: 00000000000406f0
[   13.486901][   T48] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   13.487299][   T48] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   13.487697][   T48] Call Trace:
[   13.487867][   T48]  <TASK>
[ 13.488018][ T48] ? __warn (kernel/panic.c:236 kernel/panic.c:677) 
[ 13.488229][ T48] ? int80_emulation (arch/x86/entry/common.c:164) 
[ 13.488474][ T48] ? report_cfi_failure (kernel/cfi.c:22) 
[ 13.488731][ T48] ? handle_cfi_failure (arch/x86/kernel/cfi.c:80) 
[ 13.488997][ T48] ? __cfi_sys_ni_posix_timers (kernel/time/posix-stubs.c:27) 
[ 13.489294][ T48] ? handle_bug (arch/x86/kernel/traps.c:238) 
[ 13.489514][ T48] ? exc_invalid_op (arch/x86/kernel/traps.c:258) 
[ 13.489753][ T48] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 13.490017][ T48] ? __cfi_sys_ni_posix_timers (kernel/time/posix-stubs.c:27) 
[ 13.490306][ T48] ? int80_emulation (arch/x86/entry/common.c:164) 
[ 13.490552][ T48] asm_int80_emulation (arch/x86/include/asm/idtentry.h:573) 
[   13.490804][   T48] RIP: 0023:0xf7ed84cd
[ 13.491012][ T48] Code: eb bb 8d 76 00 83 c4 1c 5b 5e 5f 5d e9 0c f3 f6 ff e8 07 f3 f6 ff eb d4 66 90 66 90 90 89 da 8b 5c 24 04 b8 1b 00 00 00 cd 80 <89> d3 3d 01 f0 ff ff 0f 83 e6 f2 f6 ff c3 66 90 66 90 90 55 e8 4a
All code
========
   0:	eb bb                	jmp    0xffffffffffffffbd
   2:	8d 76 00             	lea    0x0(%rsi),%esi
   5:	83 c4 1c             	add    $0x1c,%esp
   8:	5b                   	pop    %rbx
   9:	5e                   	pop    %rsi
   a:	5f                   	pop    %rdi
   b:	5d                   	pop    %rbp
   c:	e9 0c f3 f6 ff       	jmp    0xfffffffffff6f31d
  11:	e8 07 f3 f6 ff       	call   0xfffffffffff6f31d
  16:	eb d4                	jmp    0xffffffffffffffec
  18:	66 90                	xchg   %ax,%ax
  1a:	66 90                	xchg   %ax,%ax
  1c:	90                   	nop
  1d:	89 da                	mov    %ebx,%edx
  1f:	8b 5c 24 04          	mov    0x4(%rsp),%ebx
  23:	b8 1b 00 00 00       	mov    $0x1b,%eax
  28:	cd 80                	int    $0x80
  2a:*	89 d3                	mov    %edx,%ebx		<-- trapping instruction
  2c:	3d 01 f0 ff ff       	cmp    $0xfffff001,%eax
  31:	0f 83 e6 f2 f6 ff    	jae    0xfffffffffff6f31d
  37:	c3                   	ret
  38:	66 90                	xchg   %ax,%ax
  3a:	66 90                	xchg   %ax,%ax
  3c:	90                   	nop
  3d:	55                   	push   %rbp
  3e:	e8                   	.byte 0xe8
  3f:	4a                   	rex.WX

Code starting with the faulting instruction
===========================================
   0:	89 d3                	mov    %edx,%ebx
   2:	3d 01 f0 ff ff       	cmp    $0xfffff001,%eax
   7:	0f 83 e6 f2 f6 ff    	jae    0xfffffffffff6f2f3
   d:	c3                   	ret
   e:	66 90                	xchg   %ax,%ax
  10:	66 90                	xchg   %ax,%ax
  12:	90                   	nop
  13:	55                   	push   %rbp
  14:	e8                   	.byte 0xe8
  15:	4a                   	rex.WX
[   13.491980][   T48] RSP: 002b:00000000fff098ac EFLAGS: 00000286 ORIG_RAX: 000000000000001b
[   13.492402][   T48] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000fff09ad4
[   13.492800][   T48] RDX: 00000000f7fc1e64 RSI: 00000000fff09b60 RDI: 00000000fff09d4c
[   13.493204][   T48] RBP: 00000000fff09ad4 R08: 0000000000000000 R09: 0000000000000000
[   13.493607][   T48] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   13.494011][   T48] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   13.494418][   T48]  </TASK>
[   13.494576][   T48] irq event stamp: 1181
[ 13.494786][ T48] hardirqs last enabled at (1191): console_unlock (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:341 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 13.495252][ T48] hardirqs last disabled at (1200): console_unlock (kernel/printk/printk.c:339) 
[ 13.495715][ T48] softirqs last enabled at (808): __irq_exit_rcu (include/linux/sched.h:2463 kernel/softirq.c:615 kernel/softirq.c:634) 
[ 13.496172][ T48] softirqs last disabled at (797): __irq_exit_rcu (include/linux/sched.h:2463 kernel/softirq.c:615 kernel/softirq.c:634) 
[   13.496626][   T48] ---[ end trace 0000000000000000 ]---
[   13.496901][   T48] process 48 (init) attempted a POSIX timer syscall while CONFIG_POSIX_TIMERS is not set
[ 13.517868][ T48] CFI failure at int80_emulation+0x67/0xb0 (target: sys_ni_posix_timers+0x0/0x70; expected type: 0xb02b34d9 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231219/202312191507.348721d2-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


