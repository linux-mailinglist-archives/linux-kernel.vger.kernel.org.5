Return-Path: <linux-kernel+bounces-73958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDCF85CE0E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A511F22DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF3125632;
	Wed, 21 Feb 2024 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REI0xbqR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE806FC9;
	Wed, 21 Feb 2024 02:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482926; cv=fail; b=UcUkA608ztqif//U4moXC7+NngA9WCvjio45LJJdP2PN4575eXHi9Ga1hSJMMA3RWeL3JS/VUyh1O0oS2KJ1DYxDYBJTDqYECvui0wZnSq08YWe1yVKQr4LXgT1BOSxGa/lk0lQ1wmPq+Wn1RO0ppRpHhmqil2BaTFTgxVeQlME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482926; c=relaxed/simple;
	bh=B/KotC9WnNwQvjjt+Mow4LSk9kE2I/Xib87gNZUa3MM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ZnSXdQztfi7bptlmR0kv49j9DHdLIxvvU4D/DKUXu4pMccVdmEBh+FodebcxP270WL20MGLUSjil0IoPXtZrUeSmvkPV4eHa8wPMP7ATpM4GCfd57mAs5svbm7oRi5hbszz7FdCc8TdS5q/9Vf6sJbK5qwV+09P0Eh/Twy8+YlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REI0xbqR; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708482924; x=1740018924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B/KotC9WnNwQvjjt+Mow4LSk9kE2I/Xib87gNZUa3MM=;
  b=REI0xbqRqVuwSAqDm2jIkXE9n5EWbzzyrNmHogiBN1z6j/Sg+dMLfI/3
   MfrR4UlwEwOQXbzAT2bepNT9Sjvrszvm/Jr8TkVhJ0JRVXbp840a9swh+
   zPC7cEtU1RjBE+IGyzYInwrscME+OfeTe/IHmQ1cl9CKi+DHRpszxr5Lf
   OKoHyGJQv84llBMNjscCG77GbrjC2MEJIWMPRvZYaTvNoh6DfBAeQqOKv
   wF+tyKAf1J9iflPxv2VcpQdkYaP+K/lOzF3WcRSIXVAXmngB3+lD06DwI
   Zj5g+caHGSLqISqilJ+vh5MfrNe7HQ6Dqn5MSIVTq7+GwO/CQiQDhgsOJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="5581452"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5581452"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 18:35:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4959188"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 18:35:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 18:35:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 18:35:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 18:35:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 18:35:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duVy1m+ujWCBb/ZcdrS+PKvththIK2CxTf1dIRU2davAeg+YSphU9ejuwEFuch2l7p/8bLlRzHcLBXOsy06kps3MmuVOfktwRSzOBabI0GtjbBEyr3XhdXLojxwsFuH/lwyh1K00cDhnNY31HDToaxqKL2wjvl2erdSKNsCywP+p18ZVgr/VzYm2oIMF6eCq5dA2g8F5cCQVWI6GafRtXmQLFjcaKiDY69lhPu1u31OsB4GUGfbqoRLzyIAODFIrNGhoXo1Lnry4HQ1+dV8hoqaSWjqJ+HekaidsOTmUbPu3C39ACJ94qdghLsYmoMGW+2UcmfFoi7kjVgAuhUjOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPysfjkpb/B/J30uu6Sj08JuOgZXToDyl/91cyh+F6E=;
 b=UvtzKZB81xNwqPnZ4tTq046ZXj/1EeHQmy2na2z149L1SQwIvZorM/AyPLe3IZGPP/nxPvTJZZLRnKjXyC55cgESv/w1MxqlY0IU3MogYeXRq6/1c8O30pit8dSiRPZxgO1WJedimNxWSZ6EjP/aY0Z5UdwWqzUHul5uM/dopEt/sVSUy9uvfugSlpu1DVpJHMzVGilc34+u7oIUMbBKSFqdRdG6h2ptvSQ8+/4YEylMujuM+cus9F+Ad3tzZ9aRuXOvcVIGJt4PNYqcdbmTxX5FVsEWqDeUPl9k5O3rzjdZ0FeSE3T87EMl5CWRF0QBwFESkGKf8V0bZkhgHT4oNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by LV3PR11MB8505.namprd11.prod.outlook.com (2603:10b6:408:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 02:35:12 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::5095:2f06:f31d:95e2]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::5095:2f06:f31d:95e2%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 02:35:12 +0000
Date: Wed, 21 Feb 2024 10:30:05 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <dumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<pengfei.xu@intel.com>, <linux-kernel@vger.kernel.org>, <lkp@intel.com>
Subject: [Syzkaller & bisect] There is BUG: soft lockup after sendmsg syscall
 in v6.8-rc4
Message-ID: <ZdVgLbuAYGKoDzpS@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|LV3PR11MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: bba29ee4-8c1e-4ee6-319d-08dc3285ba8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvdhlfEScWFWaJgrjXNsWT49NfksHn7f883TAJKY/xbrwyxR3XP03vjs7Ou8cUer+bYUwFh56qTJsCauibVXLV4peUaVWl76Noyh3xXuHma9InQu4eMyQ5yij+bCmA7INkqyuRonC5M1mwua7J/vwLtGJmH7qRQSBJGblSmgQgIPzOEK0mVeCo28UgsX0DnUgt9DIhVPsaT16H/k/+iQ535itbaAw8v+4ZpBDN7LdZNjCasXRtQ1/nhVse3/xjx4GlsrWGqP+LQ+p6ZDLqn2Kf6uQbS4dnN4HK96mN/oO3vT4M4CAAxdEB7XWTganXOmHIav5Io8pgMIHvXAjcaYc9qHQ2p79WYWDteeqrrfFcSf1huL/mv+fhmG8xbaT9Aq/ASUoC4/OMKIAa0PxgW5EhI4we3p3S2og1c8KDO4DpnY/8iOrC5vprFhbjnieFFUnYC+sb4HubtrY72myXPu6tjIt5KSRY8xMG2a9LXHVs2m7zgGZ6HJBj+GKoNCRyT7MON9cxjvXi0wnngMU5IZmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aEkxEH8iphltz+atw54L5pc5SutTL+LrDQjcjrRkuUv2A7oAdvryQUjBoMiU?=
 =?us-ascii?Q?8YG3CwpPjdvW5dtBNLUBuRmIdeRr17A0fqdjtm/Zo5HJxRiU10zNm9MJ9kOJ?=
 =?us-ascii?Q?23UVqOTMe/uzQx7EdawwyrVqyzuU4fOtYjaL9SPtcYnGLPor+Xdx7wFesExW?=
 =?us-ascii?Q?QNE7JdRqzJgpgROq4UMCTMZaCAVIfroOquTZl5OgTMW9VDl0iW6EVdKLVFYT?=
 =?us-ascii?Q?ot/1aUmLlyKlnPlv+ox3nIFBvmv9j8Hd/gzYBAhDQnNHFpXxoMyNghwPRZHQ?=
 =?us-ascii?Q?o0vDoZ0c7jRo15tHdJxmwewlsOOHIlSsQx45E0wQCnEM4jEdWOxtusqKV/tO?=
 =?us-ascii?Q?skjVNU+14iPysYEBTYQJuLu39fMfeOCWQ09excL9NHACgDBFhEMDTrUUVijr?=
 =?us-ascii?Q?wuEA933SGbF1sCYdrHzU1sDnrLwd9gtPgqtoK7sTQcozSNehY+r+kkze2VIA?=
 =?us-ascii?Q?WyMf3upuwSErGsGeOXrwzg1PsZkPfL6Mi5gveEGoryF5T7M9xVw3Idquh4fx?=
 =?us-ascii?Q?52+9pFNCW4nkWBDan4KsIU1wMhCDRMmF6kBjdsEDQfqLzsFK2T6Pvp8B0ggF?=
 =?us-ascii?Q?TT9jk6n09Ox0Z196jC2UwTvexFcTtnTPaSnqYnGqYxetZlsaX5hEQxbn/DFH?=
 =?us-ascii?Q?oHJBmLjVz/JivMXwEfqmDto2WCMZPJE2hMF5EIcBNQfxyvbZ2w/lbmPYpRwu?=
 =?us-ascii?Q?XWEZA2QiHejk/7RoQk7PWkLA0g1LkqiXODS2Nlhc50P2Fmofx/bO/LkoRMNq?=
 =?us-ascii?Q?B07QHB3w6+8dbLcmqwkkwLHRzckGv4fl0oeEmUdVaxSx8+Sz4XLcYcmrf/3q?=
 =?us-ascii?Q?o0Q5cQluXqJWEKORrQ6UpJYOJvfJNs0wf4VA6JSIYrAwx7sx6G8IJ8tCAFx8?=
 =?us-ascii?Q?5MquEd9uHPzQ4nGHVeVEagAXcBnUs8CxPbfb7tLqQpmKDp18IDnqlnHKSjYZ?=
 =?us-ascii?Q?XpS3ofpMNfsMbC9mkq1OKCjLdjP4wpHVyvAOnZZv9TxogFSwGqotfWZuZM5o?=
 =?us-ascii?Q?lKXijops8saknhvVGbyfZO4Byzs4lOkz0gPtKP+I7eT6QoeU6/8Y3k4gxPL9?=
 =?us-ascii?Q?QrqpL0lkzVSe9Hk2/4lXcka7dzztD9erpuQITqM0mK25aTq2vpnyWgZmdiGD?=
 =?us-ascii?Q?gH5eeQo03//Z6JgB6+qGz4o4XZNvlmHDXHeIdWsb34Yz+P7Ijpld3Nzw6d3C?=
 =?us-ascii?Q?Umo/VE+gB7qjaPLb156UGdiqD0A1jKzcGq3rUfQVkOOCZKbFjJ/8Al7PnC2j?=
 =?us-ascii?Q?wbWoMJICPU9dwg/rTGLMwpDxq1mQxfzigMO0TrOoTW/BYpiKyMuOaMcRTLCZ?=
 =?us-ascii?Q?OM42KdrQ3ZdVIVJNUbxIsAKOEVmiZJeO3XpSLDRkRupeafU6xJb+ovwXyukX?=
 =?us-ascii?Q?lenBNxMUcY92O7I4ebCScJ+NEUT/5TOmDZgiqlgFx7HwR7pIDNNqKRX89MLg?=
 =?us-ascii?Q?miraFw8rT5dRYDcsWFYwjGaVibcwsmHkiMM5MllX8Alg3F4xNIMqsOlQkioO?=
 =?us-ascii?Q?YZM17S0AwFuZz8gzk9PRGCJYQeVoisQ5Rl4efuFTwiE0/praG8MdFQqcWe7R?=
 =?us-ascii?Q?Vmdim9dU5kaeJQQQuxThKUCC7njcx6voBLWdVjwE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bba29ee4-8c1e-4ee6-319d-08dc3285ba8f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 02:35:12.3169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZk2mf2AxkjeF08Si1fjVZjyfwcZuxhB3+XEJkKhJNaUnRmH/eJlJanDtgiA35wFYBEfuMkv8yXyaLVdUU5yMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8505
X-OriginatorOrg: intel.com

Hi Kuniyuki Iwashima and kernel experts,

Greeting!
There is BUG: soft lockup after sendmsg syscall in v6.8-rc4 in guest.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240220_161242_softlockup
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/repro.c
Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/repro.prog
Kconfig(need make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/bisect_info.log
v6.8-rc4 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/841c35169323cd833294798e58b9bf63fa4fa1de_dmesg.log
bzImage_v6.8-rc4: https://github.com/xupengfe/syzkaller_logs/raw/main/240220_161242_softlockup/bzImage_v6.8-rc4.tar.gz

Bisected and found first bad commit:
"
1279f9d9dec2 af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.
"

After reverted above commit on top of v6.8-rc4 kernel, this issue was gone.

Syzkaller repro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/repro.report
"
watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [gdbus:349]
Modules linked in:
irq event stamp: 25162
hardirqs last  enabled at (25161): [<ffffffff855dff2e>] irqentry_exit+0x3e/0xa0 kernel/entry/common.c:351
hardirqs last disabled at (25162): [<ffffffff855dded4>] sysvec_apic_timer_interrupt+0x14/0xc0 arch/x86/kernel/apic/apic.c:1076
softirqs last  enabled at (25140): [<ffffffff8127fcc8>] invoke_softirq kernel/softirq.c:427 [inline]
softirqs last  enabled at (25140): [<ffffffff8127fcc8>] __irq_exit_rcu+0xa8/0x110 kernel/softirq.c:632
softirqs last disabled at (25135): [<ffffffff8127fcc8>] invoke_softirq kernel/softirq.c:427 [inline]
softirqs last disabled at (25135): [<ffffffff8127fcc8>] __irq_exit_rcu+0xa8/0x110 kernel/softirq.c:632
CPU: 0 PID: 349 Comm: gdbus Not tainted 6.8.0-rc4-2024-02-12-intel-next-e92619743fcb+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:__sanitizer_cov_trace_pc+0x38/0x70 kernel/kcov.c:207
Code: 65 8b 05 73 89 a0 7e 48 89 e5 48 8b 75 08 a9 00 01 ff 00 74 0f f6 c4 01 74 35 8b 82 e4 1d 00 00 85 c0 74 2b 8b 82 c0 1d 00 00 <83> f8 02 75 20 48 8b 8a c8 1d 00 00 8b 92 c4 1d 00 00 48 8b 01 48
RSP: 0018:ffff88800b48f7b0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888013018000 RCX: 1ffffffff12150bb
RDX: ffff888011ab8000 RSI: ffffffff8515e235 RDI: ffff888013018770
RBP: ffff88800b48f7b0 R08: 0000000000000001 R09: fffffbfff120f86e
R10: ffffffff8907c377 R11: 0000000000000001 R12: ffff888013018000
R13: dffffc0000000000 R14: ffff888013018630 R15: ffff88800b48f840
FS:  0000000000000000(0000) GS:ffff88806ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffcc5fd648 CR3: 0000000006c82000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 unix_gc+0x465/0xfd0 net/unix/garbage.c:319
 unix_release_sock+0xb8c/0xe80 net/unix/af_unix.c:683
 unix_release+0x9c/0x100 net/unix/af_unix.c:1064
 __sock_release+0xb6/0x280 net/socket.c:659
 sock_close+0x27/0x40 net/socket.c:1421
 __fput+0x284/0xb70 fs/file_table.c:376
 ____fput+0x1f/0x30 fs/file_table.c:404
 task_work_run+0x19d/0x2b0 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xb51/0x28c0 kernel/exit.c:871
 do_group_exit+0xe5/0x2c0 kernel/exit.c:1020
 get_signal+0x2715/0x27d0 kernel/signal.c:2893
 arch_do_signal_or_restart+0x8e/0x7e0 arch/x86/kernel/signal.c:311
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x129/0x190 kernel/entry/common.c:212
 do_syscall_64+0x82/0x150 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x7fe8f8b4296f
Code: Unable to access opcode bytes at 0x7fe8f8b42945.
RSP: 002b:00007fe8d7dff9c0 EFLAGS: 00000293 ORIG_RAX: 0000000000000007
RAX: fffffffffffffdfc RBX: 00007fe8f8f73071 RCX: 00007fe8f8b4296f
RDX: 00000000ffffffff RSI: 0000000000000002 RDI: 00007fe8a801f3f0
RBP: 00007fe8a801f3f0 R08: 0000000000000000 R09: 00007fe8d7dff850
R10: 00007ffec9196080 R11: 0000000000000293 R12: 0000000000000002
R13: 0000000000000002 R14: 00007fe8d7dffa30 R15: 00007fe8a801c4c0
 </TASK>
"

Thanks!

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

