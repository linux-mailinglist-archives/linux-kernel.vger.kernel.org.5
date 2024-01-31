Return-Path: <linux-kernel+bounces-45622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 139FB84331D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 848AAB22FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645FD5224;
	Wed, 31 Jan 2024 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DR7+Pf2n"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6CA6122
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706666848; cv=fail; b=uYLujwkOPY4fyDEHLJ17NOwSZVGUTy4iPKsmlRwsS4mEolQBEjljcgvJ6bGuF/ei5EmnWLa7lzQuDrhvAG5ZoeMUk15GvH92TnghKyQ5U8m4WdeP4tOF3i/SUfZvGHRM+LTbT7//pFVqHbougiYfUeoJhKZQ6LzPV8vjIaobVik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706666848; c=relaxed/simple;
	bh=wmWAy7Rt0ewAQeATwMpOA0iGOoW3h7ERiR1gxfcjxy4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=msJbxCbp1aRv0fU0mQuboSr1N2QDffG3/fTpnpriCAiTjL2ihRrIDMWG5YbmbB0NRpsbbr5/iKmH8NOaUOXl4aY/ehIR2XzGjrbcpKZ9YoJssxvN4d6qlU8uHniAZ9MBARN5W/ISEpAJLv8+pSAEPil+X/dFt7UioxGIODv80Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DR7+Pf2n; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706666846; x=1738202846;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wmWAy7Rt0ewAQeATwMpOA0iGOoW3h7ERiR1gxfcjxy4=;
  b=DR7+Pf2nrFrd17nsWbGZNcTsQQgrBHrFiD0/W64A/kA7xkCbAZ7ajhEm
   PzL04bQVxD9fX/sBlXOlJ5wLnvfWs2gCdayO3dKLO8YhjCfjHlR8tPPSj
   9SSmATKZ201Tf2Msr2KJgIwUNaVJl4RCI6sPlJmdW6xYtX6SPFpVrpfXV
   C+tF7if2rZ/vqL3VZQzew78f1Ki+OHcO/x1tLEHvSTMs9A4J9DBtjT6hj
   UIxz2XClTyALh1O7FbvdcGfUmncAlV8RRc+Dxh0Eii6KoWwRrJHHOObJz
   Ft7hGv+z9JJN2l9w8kGpPjedd01r4OyLnrggSl2PpSohragFmVq7a2vZq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="434632775"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="434632775"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:07:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3923544"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 18:07:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 18:07:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 18:07:24 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 18:07:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRO/yEeF0PPML3v3kFJurtrmclgguzl8ZDGX2EqLXoww6+2PkKaFcgkTeQY7a2VSqtl9lhAns2pWqpJigeFvqoxJxrB1ZS2cErN/gQk2CBdt1xi6//hEBTnRNCRJJvz0UAW8QaC/+tP/fLe8mxq/In8SL4RIdRldCXgyNliXQgojNDWeC+wDfjqAJC6zrXM8gv48fCYXe1HS1Vqw2t6b3kTGDaebkKjelAx23w3cafrCweWNsuTssxHBWdS6sCcW04vzxdhw36D6ttKCPVb5wPvGMwc7C6tZj1L2PXVAYs0NYhWKeWDnNpQsPgpAUfh3tD1A4g5jYxdTPNKlnimJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo4e5tmXmoBxUztxLgvJA2QWuHIntRqsZ+8oEywvsj4=;
 b=AqvWlY23u6BRDbAaB2EwbIf3H8/KfA0qTGBOz4BHSTYU1YAJIZmFXdcJqTz8tpYDe67C2tpm7he3eEcUSUk3RX3ocBS4S10OOrIQGXw5h66+4ahh42D9FSQyZcCX5FgVVMNOo3AAo2JgDlmAnUkvYqGXE2mkcVBR9eAl3zGRDqCOtDoeadqwJaAeZsS8rJ4014xqrByaIm78mX761vRuapY82VCPlB+h1XkaHiHosqj6u1SP+aJAFy1g8yil+PlldCATpQ5D28pQ9gD41jKfJWp2odfHpH1wBZw7vUujAg/wRNHvlba3VlPeoxU9m8RnQ4e9NTC00M1D9vXZZJXGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS0PR11MB7682.namprd11.prod.outlook.com (2603:10b6:8:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 02:07:15 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::8cc7:6be8:dd32:a9e5]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::8cc7:6be8:dd32:a9e5%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 02:07:14 +0000
Date: Wed, 31 Jan 2024 10:01:55 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <rppt@kernel.org>
CC: <david@redhat.com>, <rdunlap@infradead.org>, <akpm@linux-foundation.org>,
	<heng.su@intel.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<pengfei.xu@intel.com>, <lkp@intel.com>
Subject: [Syzkaller & bisect] There is BUG: unable to handle kernel paging
 request in fuse_copy_one in intel-6.8-rc2
Message-ID: <ZbmqEy+8iOREMPmU@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0073.apcprd02.prod.outlook.com
 (2603:1096:4:90::13) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS0PR11MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: cc91afe0-a66d-4429-98e9-08dc220157b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCYDT97fYYMlNF2+3zx64AklhIWUzP0xyE6QzCbKyOggNRvn1K73RK0ue9xo9kqhaESLY61uIImNVf8nU1ld5Owx5mG1zcECGLnyp2loUWp5ljFo+B0yLxY4o8YuMHUeRP8ieJ1LmOCCAB0PJUGQaTobk9Zzxz2zIq08LNMhS/STDr8ymqg91aTsejdJ1Ap0Y/CUUr34v8bQ9vEg1zYC7dbEPX/NCf+uRRqndMQweCmiXCEMoN0QN1zD0uO3A0461iNV3oQ3NSjcBmdRnxvBW5mkztg2IK8ksC+vxfB6aYp6+BaMGADD2tDOKXllBin3vzvfpFCObb0zcOO0ZUKPc+I6Y/P8TV+o+zmnXeFi51s+J/60Ac5yTmH3ztiRYt5PzW76Bgi09vzBbAYEg1lFVTKWMaMPVeMOIdyRO0WS37Qlw+OPnfNyC2d7ShuJaap9UNx4rysBTGQIJg/uDbI2AhgPeSm4oidtKCogv7wV6mlQPVQ8folzHlQnKkZDivisQ+HJMWqwkfXP677G3zAx0vBy9EAiRcnanMjFAhFR7jI4pVbC8IBYewcdZjD5asXQ5korFb/B4gLM8+Id0oqVTJs1oKuCAWL5Mt7TC/DPXHglCfKRXKLHJ/MzDAly75IcZuy1OWSEJXMf+97exkN2tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2906002)(41300700001)(107886003)(6512007)(83380400001)(26005)(966005)(6486002)(316002)(66946007)(66556008)(6916009)(6666004)(478600001)(66476007)(6506007)(45080400002)(8676002)(38100700002)(82960400001)(4326008)(8936002)(86362001)(44832011)(5660300002)(21314003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t8k0KFPAuRQ1QJX0IHKwvizRc3kyqzqfzMooyhKiRKVVx16oe7prvtlj30ZS?=
 =?us-ascii?Q?eN0Ih/Lf45+d+9KJgUxM8csRei36n3wB4hZvpItKp8aRsOIXe1KstUA+3Aqz?=
 =?us-ascii?Q?wf8gZVI42xm14gFhfnTa5d+3x5UTOpn+WwcHsDbPV/Mxl7OXgUPCxC5R8nPG?=
 =?us-ascii?Q?83tDiW6BLnD8+qngLoJrbbHGIJfBQ7Noco8rxDjJ60EL2Nxmc81fGxIzxKlf?=
 =?us-ascii?Q?4M5dd4Cm/JjhI991uoZ+TtO+9NYSo6+7oJ4E0cNFoKEoYPfuE7BRZmnBSb6y?=
 =?us-ascii?Q?z3IY4mPsP49diKu4DAATGPrwONufKlvUIOcAZ6vgWpqXDCo7R38NOp6QowzU?=
 =?us-ascii?Q?ROf9FWoR6M4VGgfm5M1UlHw4eDASbaXHf0RqKVYqn+aVi4rIgCF7Wua7LCKq?=
 =?us-ascii?Q?xOshNAPi1gyAVMajUEG2s/LOowSRBxLYq337+rb5hkq25Ws1n9NGdFfVlMJo?=
 =?us-ascii?Q?WRipwqtwa/UJoD+WBw2qKD70u2jr3AFAKIUF3SFz5iZClz3gPGBzC8A56EFh?=
 =?us-ascii?Q?61Q/hr/FKKepRfb0DTDpfeAu+y3KzSQ2keXn1wpZ4KMQJOA1qhTIW4gLV+DK?=
 =?us-ascii?Q?lzQXoSmBBmq/GfBj3fJVIaQzeVjs7f4hKYNwJdfWicGNrQsDiqoXJxYCX0qL?=
 =?us-ascii?Q?VmgI+UImVwGEmIyJRLHCgH2qRZznsLz+clKGGpIepZDbwewSdtXrDC+4kPA3?=
 =?us-ascii?Q?vtOEklMclFZTBzyJKd5Yqk4Ule7anE4PyC5rm/aqvXvexIx/Z1bIVXiR427K?=
 =?us-ascii?Q?F7VHbP4BSlr26BdnhKIRbyCZhtHBy1lqlvNl/WdcB5Aitrk2ppEIvcaaiinx?=
 =?us-ascii?Q?T84n2UUi3BEIj3OrCUY09yxwNq0O8mlcpeNOqZ4Cf9quILlU7pjqzxtDKYx6?=
 =?us-ascii?Q?4xqEXQeRDkwNY47Bs1IIPkIMtElpbHBN6aMVnPUIzS7qs3XhTziuIvgR9kAE?=
 =?us-ascii?Q?BdxQkDDddSm/6nTSMsjYmYjnKXcDJkOU2sg7oQbSxpLnl2RtEnJaQ2+GSukg?=
 =?us-ascii?Q?YAy0GZoBroYLyG3zN3JQmPleNGUoFtSOn+DFt+tpAzGtma61pbhONstxFB4L?=
 =?us-ascii?Q?rKL+oLI4vXQVXZ2l47AoGutn0ueccUFo29hCAJL8OGjkZ501PbHh2XPMJdRa?=
 =?us-ascii?Q?rgNuC4Dv4tJnulWOuLpkK3z12jmjtcyOLpch9TkOCsqcqDRYkiGFx87SIUM8?=
 =?us-ascii?Q?/O4KYQcCHMDjvGpDG/pAphlAxGpXRAc2iCj+70JOd0D8XglkVyF41g3i9wIq?=
 =?us-ascii?Q?IpNb6NgoQ0zzAJNnIVZiBCJhs0uzhHH5W6mUCBEAgOivDu+HZ9tl3AGZ0eKr?=
 =?us-ascii?Q?j7DhVN5I5bhJSqQuvH/M4RtMDEnLLdr+EQx5/rU+XyCPYM27SK/5Qks6cX7v?=
 =?us-ascii?Q?kRBkVwS7/6UrH+aFaXCa915qC1uQhmXNE/dHH0DH8jNe3O5LZXTSxKfS8tyC?=
 =?us-ascii?Q?AxUBnjYPxe0J0LiKcM0Tz75IyxYwKJSjn+3J/VjHtgIe7mBYnkhsqrsXXVFN?=
 =?us-ascii?Q?mBrn2NTHi2D4q9wh0efi1m4XzsQrQn4oKIVHl9CFl8ip7XWLv0DviICcpVKO?=
 =?us-ascii?Q?SIjzHmBs2A3EjNP+V/+73NShpy6AycMKk93uuMJH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc91afe0-a66d-4429-98e9-08dc220157b6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 02:07:14.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUyrHuOORGA6xmfuOp1as3Xjw2sl/VNCMwiU47KyvCfRBdMqJ+W7nAJdrmFjDrAokh1zBJlGKj0EyBi8k9TGGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7682
X-OriginatorOrg: intel.com

Hi Mike,

Greeting!

There is "unable to handle kernel paging request in fuse_copy_one" BUG in
intel-6.8-rc2:

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240130_184751_fuse_copy_one
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/repro.c
Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/repro.prog
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/bisect_info.log
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/41bccc98fb7931d63d03f326a746ac4d429c1dd3_dmesg.log
bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240130_184751_fuse_copy_one/bzImage_v6.8-rc2.tar.gz
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/kconfig_origin

Bisected and found first bad commit is:
b758fe6df50da mm/secretmem: make it on by default

Reverted above commit on top of v6.8-rc2, above issue was gone.

Syzkaller rpro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/repro.report
BUG: unable to handle page fault for address: ffff8880119a5040
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 9c01067 P4D 9c01067 PUD 9c02067 PMD 11d62063 PTE 800fffffee65a060
Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 751 Comm: syz-executor148 Not tainted 6.8.0-rc1-2024-01-22-intel-next-e32989111619+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:memcpy+0xc/0x20 arch/x86/lib/memcpy_64.S:38
Code: f7 e7 49 01 d5 eb ba 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 48 89 f8 48 89 d1 <f3> a4 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90
RSP: 0018:ffff88800e2af878 EFLAGS: 00010293
RAX: ffff88800e2afa80 RBX: 0000000000000010 RCX: 0000000000000010
RDX: 0000000000000010 RSI: ffff8880119a5040 RDI: ffff88800e2afa80
RBP: ffff88800e2af8c0 R08: ffff888013b14a00 R09: 0000000000000001
R10: fffffbfff0ef68c4 R11: ffffffff877b4627 R12: ffff88800e2af8f8
R13: ffff88800e2af938 R14: ffff88800e2afc38 R15: 0000000000000010
FS:  000000000100c480(0000) GS:ffff88806cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880119a5040 CR3: 000000000f6ca000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 fuse_copy_one+0x11e/0x1a0 fs/fuse/dev.c:1007
 fuse_dev_do_write+0x186/0x26b0 fs/fuse/dev.c:1863
 fuse_dev_write+0x15f/0x200 fs/fuse/dev.c:1960
 call_write_iter include/linux/fs.h:2085 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write fs/read_write.c:590 [inline]
 vfs_write+0xa5a/0x1120 fs/read_write.c:570
 ksys_write+0x13a/0x270 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x7c/0xc0 fs/read_write.c:652
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x74/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x4504ed
Code: db 48 89 d8 5b 5d 41 5c 41 5d 41 5e c3 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff15c70d68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004504ed
RDX: 0000000000000050 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00000000ffffffff R08: 00000000ffffffff R09: 0000000000000000
R10: 00007fff15c70d70 R11: 0000000000000246 R12: 0000000000412190
R13: 0000000000000000 R14: 00000000004004e8 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: ffff8880119a5040
---[ end trace 0000000000000000 ]---


Hope it's helpful.

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
./configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!

