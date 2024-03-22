Return-Path: <linux-kernel+bounces-111181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015DF8868CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90CE287172
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8923A199AD;
	Fri, 22 Mar 2024 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pv3pEDRJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BF91756D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098211; cv=fail; b=N6gu7H1pmN5OE7/iDs+npzGkfSTHkwvIN/js2DgLjweW8M/OGQOxyPKWQ4e+Mwh+4qBHK/u23Ex6rQvBKjrtIxBCeFBK0XQSboDXB4i/lHiw2ZK9+QEUA67WC+gFkaSIUJRUtJtlVhst0zhvhNcixWNQGn6kJ/YPBHBScTmyNHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098211; c=relaxed/simple;
	bh=d62A31V7iqFE0mQubg7+F2dhxo1uzng/2t+dnmgRBmY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=WBx/wL0WUbAfIMgrMa4Xb3CJbQdnqppsNDoy15lcmBpmV4hIzcQtqm/wMtV3x2YmN276f1M0kSao/1LBHwKPQXSOr8MRxKu+2qPAY6os1d3KCmbKuDNccqivpG7f4nu7z1Fk6ZYR/GLja84Bu+WGCJdiCjATrRkH1f3FRkT3HKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pv3pEDRJ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711098210; x=1742634210;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=d62A31V7iqFE0mQubg7+F2dhxo1uzng/2t+dnmgRBmY=;
  b=Pv3pEDRJlnFWNdRfqIp6mL8XNMIWIS+gswiFP+twm9Ae4ktW1qJid6Uy
   YmZL+ilseFgEFl3CNmXmjJ4JAKRt0z4ypFNY8y/4f6300Rzr+tvSvYYjM
   3o4LHuaAJCvsBTXJdeTAfSKxMl1XCwvohO3nJ1TVvQmSSisdGc+YGm+LY
   2NnDEAgpFpoVlJh4pC9AHzNTwBzbhHSy8vi/tZeVMNi5eT5AEycqQBz+r
   OaEKh+hj0e/8Mligic0EEKAt7AOqzwPmX6tvv+9MiL7POIwsl/MfI3oEO
   US7a4dM6ofJi/jwMIoxcDGNzFxBbJAd/RZUfpvqICxOM2TG3yIgHEYGRA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="5965525"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="5965525"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 02:03:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="37963090"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 02:03:29 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 02:03:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 02:03:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 02:03:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkJEJlYCy7J6yjWQGWDbxF+84sfqfxoEo3YPOj0zoum/5RrfvQiUfZr/KAEMTs8Uq7CEo2bJFCbJtjX0pnPNRVhztlVU6ytU4c2L6BoqAsJbukf+DDyAXiItdhbsEzmzBVRGHb84avUMtLx5MFgaVhBY3REIyTw1QnlZ0mih5PrZci37C7kGGY3ycj2awgbx7h2NzuGj9yr0CUnJfPJykYuJ+z5k/mY2cIfDoRHvyhfGnRTOvXI4ARPGGdScW8E9YPRF147F67hVK/Qnek/q+h59emO9auUxK1KQGrPkURl9omqrExZHoCeND1e4rVofXi28MngIMdZxBm7BwY16Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ6Zdw8HoAm8zqBcHA05ttrmeIDXnSz7MuS7fBQdR3g=;
 b=G9mSU+r3upMxe/ws9P/X7Py7VpTKp3te0UGesF96XfipomeMpW3udC8vNmtHguxxiVcKFOayaYHr9eUClzKk2z4UWRoXH86YTE9A++OYy1GXMwVhWBo/Q842O2IkzfHHN/+uvfp1TPn2ROd1D0I1hrdkT1LaQYMQlTNvivirj8WwBY0/AtIi84MnjPGNtRMkff8D3SFWw22958xK3qOgoLRf+x4fm3e6Y5F9QMK4lMFmSkViPzZUdUXhX80tB/55pZReXMX9ehyfqT9csdX73h0rckJnMPij/U3CDM1LBg7BSln3PTsev9vQdomVYNgfuMqlwMtTZDG/IaonKSF2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 22 Mar
 2024 09:03:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 09:03:26 +0000
Date: Fri, 22 Mar 2024 17:03:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Borislav Petkov <bp@alien8.de>, Tom Lendacky <thomas.lendacky@amd.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [x86/sme]  48204aba80:
 BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
Message-ID: <202403221630.2692c998-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 555a911b-290f-4ed4-fa3f-08dc4a4eef46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MepoOqLsU65dy3SnTIAqL5gtUNaGq/qZ47vzih2rWqEVVd4g2diCBvZoCct1yjjs3mBMI8Sbma1Z+jQxKmwZ0AssOF5q3GFN89lstazsRdSI8zGXqfKuYAY8mhBTAmdFHZluZWWO/yVeNxQXVv9buIppWxJMHK3KHsDIEbulRzy7aE9iOGwNqkg5OVhs6uyq7Ia4FG/p4pYe9/kf2UaFJQQNRov7+3IypRR7nxj2bn5kJtme2KNw38dvjD+Ad6Fi5v+oZU9I20oiSOQ2tZ6Lkn2KCqyloZYL5tV5SZHigARIBbBq2bOOOjseNkvqXktN/UBEsDJlTn1n7uuFc0tGJ4c2Ebx89xlofIGgVY9DQlC0969M/RUWIoWmqsMXq+IUcHyXNJf/OtXULciHcFXxzIepczhusHwotr4NJTF7dC3quCzRcFVLH+RlzEgqvSRdpdaRSewEJr07TCj8iuzrv9Gd2xK3hTm66eaNIZPYhz2cppIr6blztvi5oOvx+pMykh5c3lHDoBgw4RYq2ea+v5yFLrUO2W1uDVVxGphqLaCTZDNex9wQLWc8vxDFAGiTyabwf7FjPpGqgoxpRtEDm6Ye+htEGzB4adZhSk4M96HAL9xb8ukg5H2wv5TAlZtO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1qH0Wz4bp7fQppm15O1e0B4Vrcwz/JzRJnuz4uFnvI86Nk5A53hqgIp+EsHY?=
 =?us-ascii?Q?ol+avyJdCSva6wT1ias4vtvOYuAYf4nIaUNAaD2nisHE+iWvQXCPu1w6/Txq?=
 =?us-ascii?Q?7vD0aAKLeu0gyaS7OGrtCKJDL8z28K2sfjKaMtXrEkjkB3P3u2Cj73yo2KQ5?=
 =?us-ascii?Q?ugBVXVRawdSYyP9zXvYPTb3l+vNbrsx6m+g8quj3DsuqoL7QDnURrm1LaMdc?=
 =?us-ascii?Q?Uu6bibCSwZ6fShS2N5wVQtgVsWTEJVTX1x29DfNgvYJneW6pmhYzMlfyvBZa?=
 =?us-ascii?Q?7dRlidI9++aRHuy4qqo8cy05B9vY6FZdJplhkZPbkKoiZwJUxn7ztX5Brulm?=
 =?us-ascii?Q?Hqw34aG9qKsODRv+D81FziCAuJy9gEs8pCnHBbyRwhRo9qfhZxFdvk8yohbs?=
 =?us-ascii?Q?zZvKGkC+ztxKM4HQhu7xlWjuKFTO4LVZZcJ3ypDcJi5eWIfqr1O9fDb8xSfM?=
 =?us-ascii?Q?/J0hne0VTExOH/Rg0bOtc747UKqwB8RqbC7XEtbCmXEKnt5xgDeZBTH8HGQQ?=
 =?us-ascii?Q?qqOFAm+S5on7IE6QqrGyY/dBOBhFUaqqJ0QMvCjXtTp/7I249gU3I2Pg39c9?=
 =?us-ascii?Q?vxmOoqFQMoEi75snGDF0FamAFikafIVMiSNxWF/RRIxgj31bvFOZdKBMNHP1?=
 =?us-ascii?Q?c0xnfFu9d0ba+kfo1DJM3cd4n+iqHa0dXlpyvdu3IfUGpefaDPFeZBjtKp4C?=
 =?us-ascii?Q?4DHTYaeaGudNrostUMTIRZ9bfLbEvyQHgJ+JUMDVht7BsoAZxvZvKkLNAjzy?=
 =?us-ascii?Q?Ll0+sBRnZMxFJLSLdYS3wDDlkbwzuxAqVLSgHsd5+tbJIKWBEG9LjC5HXsDS?=
 =?us-ascii?Q?lJrAVv/Rcjb+Jgud50IGOF9475pHqdDuwe9U8sBDyTU7NNMXKdZyrNPjaZ4h?=
 =?us-ascii?Q?C6eiVhKApnCWFkRTVrkUKFzZJBPUPcCD5ftxpi42OtvABAsBMdynI3ZkIigk?=
 =?us-ascii?Q?ywB18nfHqorwAQU5hIP6sLmi1KH6wkBbTjOqd5d+nVozeE478dA6dVa6zDkP?=
 =?us-ascii?Q?1LPzen8Fvqgj+hgxEPUGwWJtfMxtKr8TKf+mYvCl+H/JE3gNqqGR0CpZn2uN?=
 =?us-ascii?Q?0MTbXVv9syEFF7HBEPN3IN68saAeWJ6LTUZLuUEi5Bi7SNKttbhrwTgAIpWq?=
 =?us-ascii?Q?0H+MjISdSoz04Bv64zl0zxkhOr/uMeDT5PekBydJriagkPgmQFIp8lQDR6lb?=
 =?us-ascii?Q?/yGXLbbf8xUC9ZsThOdswib5fuSGHaOCvuu090vNmYRrRGCMEtZprP8DDmUE?=
 =?us-ascii?Q?k9iYL9Ie6cEWB7GG2TZ1vuuAGb88Ohm12pTykStIU2kV0Ap48LjsaTSk1F9E?=
 =?us-ascii?Q?Rh/0XwWHi1JsGWmYV9SAhmo/RMP3C83DBQ8/Hby4KLSti4wJ8jvRzmbzD4H6?=
 =?us-ascii?Q?lL5bNTBgT1Fz+a1a4sEb8MLruQFS+fo1JAIe7HwFm7EJOCHMLU6JXrsWfc2f?=
 =?us-ascii?Q?xiaE9ojJiuxx0DzsVIB/33b4kiOFbuFqgykcqRRQe/QBNYLqgZAv3omD8Ysu?=
 =?us-ascii?Q?hzEmf+2+ayeT8UCAp/LjpqhIp83DgrLfT0KjC+qQvlc1MXz/L6gLXKfcJFR/?=
 =?us-ascii?Q?Y9bL0un66P/+zddAN+QZXoYOIyIWsQkhrwsCFz8FMZ7oWN2M4kd9zLeIZe9O?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 555a911b-290f-4ed4-fa3f-08dc4a4eef46
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 09:03:26.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYmFCDbj6AmHZTiGkI6JKdZPpnl4syLgi1yu/uio7XmTkU2fCMlcnMUz8yFNaueYj2zLCyX+woENdhrmGa0+jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7164
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_print=
k:Booting_the_kernel(entry_offset:#)" on:

commit: 48204aba801f1b512b3abed10b8e1a63e03f3dd1 ("x86/sme: Move early SME =
kernel encryption handling into .head.text")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 741e9d668aa50c91e4f681511ce0e408d55dd7ce]
[test failed on linux-next/master a1e7655b77e3391b58ac28256789ea45b1685abb]

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------------=
------------+------------+------------+
|                                                                          =
            | cd0d9d92c8 | 48204aba80 |
+--------------------------------------------------------------------------=
------------+------------+------------+
| BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entr=
y_offset:#) | 0          | 18         |
+--------------------------------------------------------------------------=
------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403221630.2692c998-oliver.sang@=
intel.com



Decompressing Linux... No EFI environment detected.
Parsing ELF... Performing relocations... done.
Booting the kernel (entry_offset: 0x0000000000000000).
convert early boot stage from reboot-without-warning to failed
BUG: kernel failed in early-boot stage, last printk: Booting the kernel (en=
try_offset: 0x0000000000000000).
Linux version 6.8.0-rc6-00057-g48204aba801f #1
Command line: ip=3D::::vm-meta-180::dhcp root=3D/dev/ram0 RESULT_ROOT=3D/re=
sult/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-rhel-8.3-bpf/gcc=
-12/48204aba801f1b512b3abed10b8e1a63e03f3dd1/3 BOOT_IMAGE=3D/pkg/linux/x86_=
64-rhel-8.3-bpf/gcc-12/48204aba801f1b512b3abed10b8e1a63e03f3dd1/vmlinuz-6.8=
0-rc6-00057-g48204aba801f branch=3Dlinus/master job=3D/lkp/jobs/scheduled/=
vm-meta-180/boot-1-quantal-x86_64-core-20190426.cgz-48204aba801f-20240317-3=
2104-1snnfl0-5.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3-bpf =
commit=3D48204aba801f1b512b3abed10b8e1a63e03f3dd1 nmi_watchdog=3D0 intremap=
=3Dposted_msi vmalloc=3D256M initramfs_async=3D0 page_owner=3Don max_uptime=
=3D600 LKP_SERVER=3Dinternal-lkp-server selinux=3D0 debug apic=3Ddebug sysr=
q_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 print=
k.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3D=
panic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_=
level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 conso=
le=3DttyS0,115200 vga=3Dnormal rw rcuperf.shutdown=3D0 watchdog_thresh=3D24=
0 audit=3D0

Kboot worker: lkp-worker27
Elapsed time: 60


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240322/202403221630.2692c998-oliv=
er.sang@intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


