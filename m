Return-Path: <linux-kernel+bounces-92475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B604B8720EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B8AB24678
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDAE86134;
	Tue,  5 Mar 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="naNs88vA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A306F85C66
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646951; cv=fail; b=Yi9qtqXC96+eBprw2UL1nPEn/8Hx6oR54MnhxgbOU2h5N1D8KnMZqIDuSVx0dy6UU6Kct+9ZVqNPE4d0ePEPYz3DweRu6LVEIrLV4GczlkTD+1Dabof910uYNg5mpJpd7sUlDeaVk3yBxjBKkJ/DXCWonZC6SkvNuWWtiLHe8l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646951; c=relaxed/simple;
	bh=UI+0pNU3Ei8WezL7X5mIdTJ/llt9HWj0TzWCROLER2M=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=O1Hn8o7Tcnak9iETfURSKcURTKLbqDZxM86lTzvBFH16jUiBNkUScdFHueuNArxX7LHqh5wFI0X0Oq2LpBFNk082hrelHvn8BzYMDQnBg2F6K1U39yLMJyKSnSwHARjcm2DqHj5q2X//3/mQWnHTbr8WvsxK1DtL8qdMoQN7MnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=naNs88vA; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709646950; x=1741182950;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=UI+0pNU3Ei8WezL7X5mIdTJ/llt9HWj0TzWCROLER2M=;
  b=naNs88vAygsY5LZbah9OfQb40uitK9y39mvRgm7yVVGBxBCgkez57As9
   DMROze2hsu17bDjsJ262ges0+SLawQoFvwV+wn4la/PLWrcJvI9o5fmJN
   ct5wsdI5BK95jZ7af13IlWkC66DrwozAU5yaqfoo8MDLP2CNwZvPZwqoT
   WHFfW39qEr6HECV63ANxwNuM6DoZbyOAHeBsXtAs3Au7BG3JnA+6yDujm
   vSeSMqYos8gc1ccFecMacVwYGUfes1Q6FR8qpvn3i1Rh6+ksxrRswQ3Ak
   iDNee2+cGwuayEdtAMLqxtNfpeVTOL2MZQ+VmD2nKKX5QCRSZHe1k3F9P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="14845765"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14845765"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 05:55:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9494517"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 05:55:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 05:55:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 05:55:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 05:55:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP3ZCMf5Lhxxeh1qx6Uhg4VxlfZmwJfGeET9pQ2ty9LiCEhwYaa6BrNhfdDm2Z2fQV3oisjGG4FMshHYEwNl7lVnM3wCV2gwqNLEj/T0uxvJFiWApwkZtaeNVokzUNiCNpjYRdaI0OHAEjJERrykS/819pI4TrjALqsz2ioKkIBQp3TzOS+7RPcnfyIvPnmfi9DR32z4Laurv5OJOA8wjiePPYOs5c7+JFQKx0rrNit5sbZFL2j70d+VrswoHl2dLGdRuWKMoatC3VVitpFqZ7/jn1nV3vesop6zS8qa28+YnXRrHSNH3/1Gt/e1yjTiISkLl/8G60g4m1r86EQ2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gaOMlapvH9eOIDsXvHQKBe+7OiW/vfQZmwngagF+Cg=;
 b=e/OLdrTuvRjutkdzbp3pYlBdT1FKX+/06bsUc1lvR7xwycxmH1vHflpnmMLxRFE2n0tkO9fJU6pdTs0Owa4DL8dHosaiptnFRU+/BzwoL2qUT8m+79xL4g/POapy/Jox/AF3vTwl1x2IFNRCddyqeFc//SSNpPiEPJoCLVi0lgdf9U26LTUUQqpV3OxNiLhPOYg0tWEivyg7LgWbTd/iB5aXXxYa4rHRCsJ8WzGB/RV14n/vYJGRdhIMrxo4QNOY3M1RGLWIK3nmpUNpXmxoth7WQ26Svo+GPyWA/DlTX0eGJyOE23dTe/wjTQRRTBGJ36FH0mFZIvnJLExLff0YgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6466.namprd11.prod.outlook.com (2603:10b6:208:3a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 13:55:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 13:55:40 +0000
Date: Tue, 5 Mar 2024 21:55:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [ardb:x86-pie-for-sev-v7] [x86/sme]  7d8fe2e19e:
 BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
Message-ID: <202403052100.249b1d89-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc48266-194d-4f91-2960-08dc3d1bf1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W67B9FK2Xap6S0UPJHd8TlCHOZ/D2w3oHWI6jQxXcWPF8KHGXFIxWFumEVwc4H485hvijC9x2AU3riamq4K22gnoZpHY8w40qxE2kSZmrT3FqVGRXLXe3O6Cl9j3cbRe5aBotHitxHsVet3p4Mye5I+0JFlvtZHF8HYhzJBWzAOcajrNi84yVUrOERd6nfjydt4vwaTNyZ8dRml4GkPJpqDfgV4iwACumM8vqJSzxBcxWA+JR+/FyWQoXKSJWfLaBnIDkvTob6+9XV/fT8i659YUWEUN+E1IYjmAvxD2njs4Nj5j0m3qiIePABOD6KQjPzgeAqDeBe5PL2xymDZuKUKa7PkRuAU6HtpZgNL3F8mPopf+fHEvdPWHI6IqlNNoogZNtBAWlmi/nUIT1oPVK1Y3S9+SVCbkdDwG6ApkvuXzX5yeWqsINTohzKK8aIa129+kGVVcXyaVlnC6SRysreD72fsq+uGFs4hq49XyJYrgTU9z+juMHCkctOnTx4DPxFrBQhwxtSKvbtVRanr78b4wRe7kiAdYqIv4u+OQjBd9HR1PfMZV52fXbXfhy0e0EHL6pfJOv0nG+4xAFmk6VmYxR8+f9BFRxW7HnzhtmuDv9yALgiu3Nfw98XU6OODD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LNF3qAIxFlUyJuRhcKTjMznGHf1oW3giLxS83roLxVeaNNLjSHQntpLsItbN?=
 =?us-ascii?Q?8kP+nzigFswRQI6gU9TflYVM4nTZWrl/D0lGkeH14/HsETF2hI0N/lOrynBE?=
 =?us-ascii?Q?nWBpqdBlxUlgP8jlobrikp6XUdoJ8jlHpRTxnF8OriSzMGUkc2QRUc+XuKH1?=
 =?us-ascii?Q?5z9uL8N7aQef9cK6GZqAelqh+mGz4MxSzNHQ8lqji0nKmh3xy7xSbTVUCCUb?=
 =?us-ascii?Q?I/B5En0CpKSUd6PMOjNsyNNp1Va9/UUqj335BcvgpRxY2AqxMt9QHen4q6zU?=
 =?us-ascii?Q?00YjYikr9wCvhWuW1kzGzjKsbTpKKwy02sq1yGejsSOJZcSgH5Fsf4lbfYNs?=
 =?us-ascii?Q?7iLq4ly1XhJHjNTXSSqGQozZowzaJRVmIxlCPlz+agrGsCzmYYvkWXihUb4d?=
 =?us-ascii?Q?Jq/azG1XG2HSgVqb/9q/IdlG5JXX1lOADvkxLnbZCi+DSYSEyi8TdojroaDX?=
 =?us-ascii?Q?7Mbbvb9/VrnQFmCAtfjznigM7wogHGGJPlHDY6JNtYcFO/FD4TP2ZSm2HHHQ?=
 =?us-ascii?Q?pe6NVTBpcmesX7gaLCYWxXlmxsGipsOoPh+WRzvgPqTFL+MV1qL/zDsyEURD?=
 =?us-ascii?Q?tlzayUWiMnrtRmnQ3ACg2OzwJTzbzSlbpktsSvVjbQ1gjxdpup2Mywb7QlEE?=
 =?us-ascii?Q?SGud2yrArsmIy1YEmBZnGvCWyQJAge/u480Ixs0bxy+HjSbgB0L5l1+hNEv2?=
 =?us-ascii?Q?6rf/LxSlZq+7PeklfMGjAku83MCsoh2A6YyvO3zAkke6inPq1HtB23rCfyy+?=
 =?us-ascii?Q?GcShPwM754/BMd3GZtzVYlMRitu8pXqsRFyU09zNAEtblec+ZkfDuU0c7LWa?=
 =?us-ascii?Q?0Yah99nY9Xjz55HZL1tg7r40pRAOAwyGRpqiB/qgNd2e//Emd86d6ewUKXfn?=
 =?us-ascii?Q?Oom2DIjsF+8IkXDvq/yKF6qzrKdgcauMF7yRbKeA3ViaGyb3EE99zoM5UIcs?=
 =?us-ascii?Q?9LfjienLo8JjxzBBm/QY+FO72tW0rQ1ofmbLGgaQkMOOZ9n6uHjR2Td5M+tr?=
 =?us-ascii?Q?8qQBbmBQ9AKIbbkA5AmC1ITgVfKK19Bf/MFDJhzoEKBh9dtlSmZwzw7Cg0ot?=
 =?us-ascii?Q?UcRdIoXJcOe1Ze3OorqsZESwYcdoUc749vxHlandk0mLMA4vVBfMPqioHma1?=
 =?us-ascii?Q?Lq2U0VMoP+VjdWw+UN/47w3GOod7qTBL2UPgYxLrKxgRMEzAoBSjjhM4jm52?=
 =?us-ascii?Q?crJB8x6q6xo2jSKtFgMEU+oID+m6sw+UMgqrFxrsBSWD3V1jJ/IidqyPV6CE?=
 =?us-ascii?Q?nQ/DM25746dIFNvZUjyCzDKkQQWPEv2YxKh/VUSgHiKvcdQCyonKk5vDwqlq?=
 =?us-ascii?Q?K3ythBybLPIAPrNeMM7xmkCmtP4aVAkwNjiPmBACGEvC3Umkl1ZAcz27j6R6?=
 =?us-ascii?Q?WCCFeouGxW7b7KIlLgFgvbF1XE9sAOe/yO6+Fv2nnUPDE3wPoTw7rIFdaX6m?=
 =?us-ascii?Q?PWCfwnCD/uxqi2S0abluJQaIDzndYCz7t43FzVg9Bpmq9R+b7gNjby+unvxp?=
 =?us-ascii?Q?O7nzNPDqIJlMerx7Pe649BzEg7gAiRG8tS/NSbcXQsd3kY9ZA2pViprrQUVD?=
 =?us-ascii?Q?kMDuHp4l/xHO1PBkhrlCRlF01Sv5ql07wnLhBXss/tKzr1OvtPQZUPwjo6hV?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc48266-194d-4f91-2960-08dc3d1bf1a2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 13:55:40.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ljs1t12nN+bmTr0NuC/KPqR0aFXYiPJurDQsI0gpqVr22mYD35O2UZ9o3UvwblXMJgR+izAeHM8RR5AQbTvFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6466
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_print=
k:Booting_the_kernel(entry_offset:#)" on:

commit: 7d8fe2e19e5ebe0034c5ce2b7fb19b80e61d786e ("x86/sme: Move early SME =
kernel encryption handling into .head.text")
git://git.kernel.org/cgit/linux/kernel/git/ardb/linux.git x86-pie-for-sev-v=
7

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------------=
------------+------------+------------+
|                                                                          =
            | 5e9a0435e8 | 7d8fe2e19e |
+--------------------------------------------------------------------------=
------------+------------+------------+
| BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entr=
y_offset:#) | 0          | 12         |
+--------------------------------------------------------------------------=
------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403052100.249b1d89-oliver.sang@=
intel.com



Decompressing Linux... No EFI environment detected.
Parsing ELF... Performing relocations... done.
Booting the kernel (entry_offset: 0x0000000000000000).
convert early boot stage from reboot-without-warning to failed
BUG: kernel failed in early-boot stage, last printk: Booting the kernel (en=
try_offset: 0x0000000000000000).
Linux version 6.8.0-rc6-00054-g7d8fe2e19e5e #1
Command line: ip=3D::::vm-meta-144::dhcp root=3D/dev/ram0 RESULT_ROOT=3D/re=
sult/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-bpf/gcc-=
12/7d8fe2e19e5ebe0034c5ce2b7fb19b80e61d786e/3 BOOT_IMAGE=3D/pkg/linux/x86_6=
4-rhel-8.3-bpf/gcc-12/7d8fe2e19e5ebe0034c5ce2b7fb19b80e61d786e/vmlinuz-6.8.=
0-rc6-00054-g7d8fe2e19e5e branch=3Dlinux-devel/devel-hourly-20240303-220712=
 job=3D/lkp/jobs/scheduled/vm-meta-144/boot-1-debian-11.1-x86_64-20220510.c=
gz-7d8fe2e19e5e-20240305-70991-8wkwq3-2.yaml user=3Dlkp ARCH=3Dx86_64 kconf=
ig=3Dx86_64-rhel-8.3-bpf commit=3D7d8fe2e19e5ebe0034c5ce2b7fb19b80e61d786e =
nmi_watchdog=3D0 intremap=3Dposted_msi vmalloc=3D256M initramfs_async=3D0 p=
age_owner=3Don max_uptime=3D600 LKP_SERVER=3Dinternal-lkp-server selinux=3D=
0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D=
100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi=
_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.min=
or_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlypr=
intk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw rcuperf.shutdown=
=3D0 watchdog_thresh=3D240

Kboot worker: lkp-worker26
Elapsed time: 60


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240305/202403052100.249b1d89-oliv=
er.sang@intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


