Return-Path: <linux-kernel+bounces-22965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE7082A5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A782B287A51
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499E4EA3;
	Thu, 11 Jan 2024 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0WcN9Wq"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10553A3C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704939673; x=1736475673;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5Bi1V6PyooXbBfkBX3Da/BWGZe0K0XwNaK4kYIsAVus=;
  b=D0WcN9WqQ0a3yzS61PTilZzmYYT/pGVNo5Q+uGOeW9jHkPIDUJyfvhyo
   rsNwmsrRNJyshT4xoM95IVolt5v9ZIZ4CB4+TwEYNhPLCj5OVegxBDWLc
   2nzegN25Li62TzejRTe5sAGx+ocIcaPa3wpHBJLBpymfr/0RDIoX8M2BQ
   pTsroHUJnrSOZv1EBBNlIgy6rSV9SrmMOYY6W258Ys8Tg5OFmLisb2D0D
   dsQU/shcU2O2mFCflNIWib442zCawecpnzMaZh7mLm5O0K4MyyRUIK2bO
   Mk10IW/rFyeXne+YMuxH4Q1X9TQWY/dJZJBghShFUQX8xBDfJ0NFqCtwj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="402487467"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="402487467"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 18:21:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="925849799"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="925849799"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 18:21:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 18:21:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 18:21:11 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 18:21:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fODH38RLP8A/I9PN6n0uQROoX5jsYJhbT1IudsZ6eBVWKSJTJ0Havfo29sCYQUX3KrxuuyNNRqJjpo4zKUFIrkI7ToOpwpz9SMQM1kRIRw4Z5n9koBSinmqiNhuq9ABzohJ+ckhP1BNd2nfraWH9sayLJE/COWusKQOrbzWkKICkeR9o0QV0TMajfmP4Oej1lENjMlWYBc6kuTGv6XVLfSbLo41GtHUb1ODebTWNK+DyC75w34uvQoO1gHhvRnOnV7Ubz88a8GCjzyHnc34lr59VpOiG9eOc5mkNDVxK27DI/BFF4bldSga+n5BOnFJY0bZ9oT5W9UmkRiQLEP/JMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvwI8fimlz1aMEBcO0GGLULDaoHKRzUv3ftjo2s35Fw=;
 b=LgcpNWGFG8+pVsnV2QZL27CmAKcH1gX14fqrX5M7Gvhy2NjHU4ecmgw9SMd6ESuGC/PjKuKSDJIQ3h0wPgziWoukY54RCEDQrE3jErhT7VMdg1/5xfgNIPCuZqyGSt295s7WgiAD3o/BsB4lldi+S395vOJJrsY6ublEBinwVc8AtRufDEGS4rV3+Jc9pXxsPodCPIZ2ijwXFgMfIqzdNkQtb5pe/XF+tHdV1T07n5whxBYncuocRhfrVDEAgplw85AZ0l8xdEeVAAEnz3EAUmfjheGNtSlyTigViGZlPhcV03NiTQKRzpD7xmlLPmkfFsQWRutV4jg2k2jYLaPY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS7PR11MB5968.namprd11.prod.outlook.com (2603:10b6:8:73::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.27; Thu, 11 Jan 2024 02:21:09 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 02:21:08 +0000
Date: Thu, 11 Jan 2024 10:15:38 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <mcgrof@kernel.org>
CC: <david@redhat.com>, <brauner@kernel.org>, <yosryahmed@google.com>,
	<dave@stgolabs.net>, <willy@infradead.org>, <keescook@chromium.org>,
	<heng.su@intel.com>, <pengfei.xu@intel.com>, <linux-kernel@vger.kernel.org>,
	<lkp@intel.com>
Subject: [Syzkaller & bisect] There is WARNING in shmem_writepage in v6.7
Message-ID: <ZZ9PShXjKJkVelNm@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:54::15) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS7PR11MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d994dd0-ec04-4f0f-d53a-08dc124bf887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYzKRljg/18IOv0Xp4uKPOFWaOqTIryu6VwejeVUTVSe3SP4cDueWhaUa7cM1Ko4qobfiQqwDojdcNxRX423A4ByUA3ocpk+3xzzErUeWu2vomkwAdFCul3vQlHCIURnu5VGYety/kySt2Aw2iE6QDbKmUOMtKdFOikDMNImZsu18jSg37LYYK6QQnb6eM7v0IfSLJLmwvVYnaELX739JubyGaZ3X3a55XvytPPUs0vGTSAvIgddKElygvs9blYlykmULnjKF/lTiIG0UPGUDMI2HPmB+4jG55LxSkeEVR0l92CqjvXByr3nsO95duGNoVvUqnZFnOrNeQW037zWJObZY0l+mqH70PQut/0Mnc86MEitFR10Hp2XT/G4ecOvZeIJt+e3NKVM58S8qVbG/7+Kug3EA1WgGTpHWps1VyWN0h5LTTs7duuhnOzEkUh7tZVwSSSw/xFB6tGMFj+tdsDyD5bg7P7MNjNx/xbC08BtkStd+e12c7JRwkG2TYl97wxw/8Tmc3N3vEGKh2e7OnFrXf7GEtKbO+C7DlG4QOHibATI5r6ECXKiyWjZZ4uXRGUM8hbeFuAi4nBe1US8vSU5Ub/0IdxH6b/0EzHtxzj63ZguCSQbiE2LTyaPpkc2bbJyWxbZWJLfVleaNbpFQ/aY4QyqSSGFQhLmHT9ZvcfqJZg78BXV3fYyyPc7nLNh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(966005)(478600001)(45080400002)(6506007)(6512007)(107886003)(26005)(38100700002)(82960400001)(86362001)(6666004)(2906002)(41300700001)(44832011)(4326008)(83380400001)(5660300002)(66946007)(8936002)(6486002)(66556008)(8676002)(6916009)(66476007)(316002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yjm326u2yC56+ki6bvHUzRQIjwMLUjuTIZNSWYwh7Rq+GeBGVY9LFQeOpq5g?=
 =?us-ascii?Q?viYTV/lH16LKW57YYWxEmiZOaRpMKBZ4xnkEJrBs7omf/2KPy2E8eFgzyQXX?=
 =?us-ascii?Q?lDGhTHwTes6+1iY/5Dx8SqBokrvEqzh0EWlISx/xeAAqoGhHCGk/kD8Gezpe?=
 =?us-ascii?Q?6wN8t+LA4sPVWQzcnK3jlgF48rWj5Mo66Hgwb/j4cqF774G++0g64nfIF/ZF?=
 =?us-ascii?Q?lFVe7hyrmCC+Qz2+yOlS8vnHgj/+KJoYMx4leSK4a9seIR47WGArcmnUvPdO?=
 =?us-ascii?Q?P7MmXZIL7N5B1lesQ9t/FycJOuxMQLezZqhilAM6BnA+z6dLBO5h29YFXkys?=
 =?us-ascii?Q?Mm1dSESEt2+hKFsyubve5RGp6g7g7temt+Bu+YV268BMfR1SCWvym5fFTIYE?=
 =?us-ascii?Q?waWeB8zg6U7cyTq+MZ9mNN/1evwBaGnSCxvId7XOV+UB/em6VGYF91GYVLKC?=
 =?us-ascii?Q?ICVhrh7eV76WH8HhirviIcN1IHHo/ySvH7bycOqmn43MyUo+/ubnKLet3BeM?=
 =?us-ascii?Q?cOuimr76e0frSlBtWKt/704a5ZnvxKlW59CkvEVLH8KnXeTYDT65Wn6P16et?=
 =?us-ascii?Q?/QXR9GwEKmZYV1y+24P6r1XLPO3E0irPMRkGpJztBmjCCdQlENI9kmuIuLdy?=
 =?us-ascii?Q?XFQJbl1siyVqbGGKUIRbujL1i/C52dG777kRtbloL6Au9qRtZA4ZvwI15d1O?=
 =?us-ascii?Q?sN4vrYzpo/LSFOOAnBik1UO9UaqN6rhuJALpCMbqkWbuUUMufFsuVjcSEmBu?=
 =?us-ascii?Q?v+SOViZE+DqwUS+NJEXUNYIWx/v8h93cbr+ypeU30QVQNDKcAE80hckyu0cd?=
 =?us-ascii?Q?7z4qs/BueR068Ka9UT8l4seYpq9Sp3Rhc4bNKUvxqM7C+/pL/rYnOkbOwedj?=
 =?us-ascii?Q?K2uGGScyVcGHkgjRByY2PhYlhh5x4eCpR9ev+CEqsVyohAA+dcwNXSc6Vs0N?=
 =?us-ascii?Q?HHH/1e+bftfVqMifIV1oAdKwrbR9IJfm0qoehCWu1LB/tcn4XX0ZjR8PEOFq?=
 =?us-ascii?Q?6nA28IVa0cNpbiEPvptHmFVmcVwEaF0IJqbU893tCWQj91yKAidYYYQKsnXl?=
 =?us-ascii?Q?E2lR7lhCmX8cS4LbV51awlGu9urX2Djq1rq9WOLrhX3VKwhbQc6Hqimj9r6p?=
 =?us-ascii?Q?goy9+0tLQZ+kS8hHrEBWsEk2U2OefeSuvlk6DfDHOAszQTythrWlj5L5UN6G?=
 =?us-ascii?Q?L5UXvqlMsb6N4I8p5nHY0Mc3kS9J1vUm0F8ryKzCb1d2Z9YFcYVcjxLgR7ob?=
 =?us-ascii?Q?+oGe8UFTdXOm4y6J5ZPyZF4+5uF23G6dnz29SR+harid2XOgfHwlebKAueHB?=
 =?us-ascii?Q?N2bmQ9EcYalX63Ac6CV78UrNvByNfKN7gYRNeCQzvR74zpm7yr5/zOu2OJyw?=
 =?us-ascii?Q?ZSdpkkfUWgepi32oxVSrVqy3AGDVqP0G8tvttrfZRTgQqaV1KpQWJENpb0ny?=
 =?us-ascii?Q?pI0eVD0VTtRROSvPd9GGTftHqLRlRMT0rx3kvP5dA/t1gEFvEIHtE6+Ip/Wi?=
 =?us-ascii?Q?0r6jbKZVniwBDppBFv3/QIPIeh2pyspiq5ZdVsW5M5piWd1nloeJe64v69VW?=
 =?us-ascii?Q?6bRAJ0wdgESwYPmcX0Dr6BFYNd56AJ9Kw4TWkZHw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d994dd0-ec04-4f0f-d53a-08dc124bf887
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 02:21:08.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlRA769vqKWQAI/6przO0rNR+Lkkb1fETUia7CZP5ckdJn5C8IAwdafE9lXwdYx1lXNd3PtLinhxgSZXB4mueA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
X-OriginatorOrg: intel.com

Hi Luis Chamberlain,

There is WARNING in shmem_writepage in v6.7 in guest.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240110_151928_shmem_writepage
Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240110_151928_shmem_writepage/repro.prog
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240110_151928_shmem_writepage/repro.c
Binary: https://github.com/xupengfe/syzkaller_logs/raw/main/240110_151928_shmem_writepage/repro
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240110_151928_shmem_writepage/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240110_151928_shmem_writepage/bisect_info.log
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240110_151928_shmem_writepage/0dd3ee31125508cd67f7e7172247f05b7fd1753a_dmesg.log
v6.7 bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240110_151928_shmem_writepage/bzImage_v6.7.tar.gz

Bisected and found the suspected commit:
9a976f0c847b shmem: skip page split if we're not reclaiming

"
[   31.541851] ------------[ cut here ]------------
[   31.542523] WARNING: CPU: 0 PID: 952 at mm/shmem.c:1438 shmem_writepage+0x28d/0x10f0
[   31.543355] Modules linked in:
[   31.543711] CPU: 0 PID: 952 Comm: repro Not tainted 6.7.0-0dd3ee311255+ #1
[   31.544455] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   31.546342] RIP: 0010:shmem_writepage+0x28d/0x10f0
[   31.546892] Code: 31 ff 0f b6 80 c5 00 00 00 89 c6 88 85 28 ff ff ff e8 a7 55 bd ff 0f b6 85 28 ff ff ff 84 c0 0f 84 7a 01 00 00 e8 e3 5a bd ff <0f> 0b e8 dc 5a bd ff 4c 89 e7 e8 b4 67 fa ff 4c 89 f2 48 b8 00 00
[   31.548893] RSP: 0018:ffff88801aa27040 EFLAGS: 00010293
[   31.549805] RAX: 0000000000000000 RBX: ffffea00008eeac0 RCX: ffffffff81a433b6
[   31.550583] RDX: ffff888023d84a00 RSI: ffffffff81a4342d RDI: 0000000000000007
[   31.551352] RBP: ffff88801aa27140 R08: ffff8880118a6b28 R09: fffff9400011dd58
[   31.552123] R10: 0000000000002000 R11: 0000000000000001 R12: ffffea00008eeac0
[   31.552891] R13: ffff8880118a67e8 R14: ffff88801aa271bc R15: 0000000000000008
[   31.553710] FS:  00007f47e5bb7640(0000) GS:ffff88806cc00000(0000) knlGS:0000000000000000
[   31.554577] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.555205] CR2: 00007f47e584e1f0 CR3: 000000000f772003 CR4: 0000000000770ef0
[   31.556039] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   31.556835] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   31.557656] PKRU: 55555554
[   31.557969] Call Trace:
[   31.558267]  <TASK>
[   31.558536]  ? show_regs+0xa9/0xc0
[   31.558946]  ? __warn+0xef/0x340
[   31.559325]  ? report_bug+0x25e/0x4b0
[   31.559766]  ? shmem_writepage+0x28d/0x10f0
[   31.560251]  ? report_bug+0x2cb/0x4b0
[   31.560674]  ? shmem_writepage+0x28d/0x10f0
[   31.561188]  ? handle_bug+0xa2/0x130
[   31.561629]  ? exc_invalid_op+0x3c/0x80
[   31.562081]  ? asm_exc_invalid_op+0x1f/0x30
[   31.562576]  ? shmem_writepage+0x216/0x10f0
[   31.563052]  ? shmem_writepage+0x28d/0x10f0
[   31.563530]  ? shmem_writepage+0x28d/0x10f0
[   31.564065]  ? __pfx_shmem_writepage+0x10/0x10
[   31.564584]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   31.565223]  ? __kasan_check_write+0x18/0x20
[   31.565727]  ? folio_clear_dirty_for_io+0xc1/0x600
[   31.566280]  pageout+0x3aa/0x900
[   31.566664]  ? __pfx_pageout+0x10/0x10
[   31.567096]  ? __pfx_kvm_flush_tlb_multi+0x10/0x10
[   31.567653]  ? arch_tlbbatch_flush+0x2b9/0x430
[   31.568175]  shrink_folio_list+0x122b/0x35f0
[   31.568680]  ? __pfx_shrink_folio_list+0x10/0x10
[   31.569236]  ? __lock_acquire+0x1a03/0x5cc0
[   31.569747]  ? __lock_acquire+0x1a03/0x5cc0
[   31.570244]  reclaim_folio_list+0xd9/0x2f0
[   31.570710]  ? __pfx___lock_acquire+0x10/0x10
[   31.571213]  ? __pfx_reclaim_folio_list+0x10/0x10
[   31.571787]  reclaim_pages+0x39c/0x5b0
[   31.572271]  ? __pfx_reclaim_pages+0x10/0x10
[   31.572780]  madvise_cold_or_pageout_pte_range+0x1297/0x2450
[   31.573478]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
[   31.574172]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
[   31.574841]  walk_pgd_range+0x11a8/0x21e0
[   31.575333]  ? __pfx_walk_pgd_range+0x10/0x10
[   31.575845]  __walk_page_range+0x637/0x760
[   31.576316]  ? find_vma+0xc5/0x140
[   31.576715]  ? __pfx_find_vma+0x10/0x10
[   31.577187]  ? __this_cpu_preempt_check+0x21/0x30
[   31.577736]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   31.578344]  ? walk_page_test+0xac/0x1c0
[   31.578803]  walk_page_range+0x3a0/0x830
[   31.579262]  ? __pfx_walk_page_range+0x10/0x10
[   31.579790]  madvise_pageout+0x37d/0x8f0
[   31.580289]  ? __pfx_madvise_pageout+0x10/0x10
[   31.580794]  ? mas_prev+0x103/0x650
[   31.581239]  ? __this_cpu_preempt_check+0x21/0x30
[   31.581756]  ? lock_is_held_type+0xf0/0x150
[   31.582222]  do_madvise.part.0+0xaf6/0x2ae0
[   31.582674]  ? __pfx___lock_acquire+0x10/0x10
[   31.583185]  ? __pfx_do_madvise.part.0+0x10/0x10
[   31.583713]  ? lock_release+0x417/0x7e0
[   31.584156]  ? __pfx_lock_release+0x10/0x10
[   31.584635]  ? __this_cpu_preempt_check+0x21/0x30
[   31.585216]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[   31.585925]  ? lockdep_hardirqs_on+0x8a/0x110
[   31.586420]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[   31.587114]  ? trace_hardirqs_on+0x26/0x120
[   31.587597]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   31.588330]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   31.588881]  ? ktime_get_coarse_real_ts64+0xbf/0xf0
[   31.589473]  ? __audit_syscall_entry+0x39e/0x500
[   31.590026]  __x64_sys_madvise+0x13a/0x180
[   31.590500]  do_syscall_64+0x42/0xf0
[   31.590916]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   31.591482] RIP: 0033:0x7f47e583ee5d
[   31.591890] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   31.593912] RSP: 002b:00007f47e5bb6df8 EFLAGS: 00000297 ORIG_RAX: 000000000000001c
[   31.594742] RAX: ffffffffffffffda RBX: 00007f47e5bb7640 RCX: 00007f47e583ee5d
[   31.595516] RDX: 0000000000000015 RSI: 0000000000004000 RDI: 0000000020ffb000
[   31.596329] RBP: 00007f47e5bb6e20 R08: 0000000000000000 R09: 0000000000000000
[   31.597140] R10: 0000000000000000 R11: 0000000000000297 R12: 00007f47e5bb7640
[   31.597927] R13: 0000000000000000 R14: 00007f47e589f560 R15: 0000000000000000
[   31.598725]  </TASK>
[   31.598986] irq event stamp: 1493
[   31.599358] hardirqs last  enabled at (1501): [<ffffffff8142b0e5>] console_unlock+0x2d5/0x310
[   31.600278] hardirqs last disabled at (1508): [<ffffffff8142b0ca>] console_unlock+0x2ba/0x310
[   31.601242] softirqs last  enabled at (1318): [<ffffffff812674f8>] __irq_exit_rcu+0xa8/0x110
[   31.602187] softirqs last disabled at (1313): [<ffffffff812674f8>] __irq_exit_rcu+0xa8/0x110
[   31.603220] ---[ end trace 0000000000000000 ]---
"

Hope it helps.

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

