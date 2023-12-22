Return-Path: <linux-kernel+bounces-9303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D113081C3BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9771F25759
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CE323B1;
	Fri, 22 Dec 2023 04:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W79BwpH5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3563B5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 04:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703217709; x=1734753709;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=QIm/oFEC9R/km2cRU7nnOJu8f5OBjgPKB6JflW2TXLw=;
  b=W79BwpH59xEZGMEmGbRqM+EXvSAnfBr60MTd2fkIYNDuKFaoHBNYuMGu
   s+PxUEjMEtkS7GvcF4D5nXb6jqdpeejec3KWiGSLMgZ7DUZmETSh5pE67
   T6uClrNccSl7oXUloFfOnl3l3eAs67gAepkx54bP6aVzhG6xJ12d/GRYa
   cpi2cR7w/8pjMnDmxLfJCMHRPTb0rTnv81YhxSUvLM1lEv2dvUEGdYy5i
   I6BMv+bvpCo4ZXnzbbWb5KzBvDKXdsmqP+hYAf4UVrRr8uwq0oa7G+iLd
   MtFrI4gfD9fS07vSXfbctEvnMZiZgFmOg0LT33q1t0nBx1fLcFyIA1Pj2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="14749383"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="14749383"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 20:01:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="811205803"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="811205803"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 20:01:46 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 20:01:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 20:01:46 -0800
Received: from outbound.mail.protection.outlook.com (104.47.55.168) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 20:01:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l17UlXKJduM2/Z0RbQ+uiEsJoNCr4SHcfVizV182dKG7AEfU4NQqrLQXFkvV9XoNcMWUKydqAqke0QfIpYRAjhNlNBmPzJEg28A0TnYAC8aEER0FB53YPZP3SE26H2rRz9asfdOqIdDCTWnnPv52Hque8X7CcWec4flP7CpwB4TcInvqXnkjb/syi1Z/D9QIZccz83GOkWzZ4NvUyBKZn9fGDtjQGj9m6P4NZjie1qIB6nNbbGNIBHq0pUnqU9p4/Np5Cz4jAFaAOeGOmqFdlsHd3j6D77Xj92s71Eac8CB6V5uwRPyY/TJt8w1azl6+71Bux5WVGbjhtxwWJa7+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsC3+5dSKURkgTMCzI91mH7TqWkHMXk1W2DUe3s3brQ=;
 b=Q0x9QsytABDpXjWPZjG9lLf9rkusSOWvnlgLDLfUY45Y1qVh6ZTFUGfiTCWlQPXjavRlJ0S65hSU+H+8HO3nDMjNfmNhXNzf6JTk/i4lkDZ0oyfTsXmwLBofniHxCWIq/XEMf7H12DxHTMltPfJ+DSH1R2/c2XA61KYwMVwXPgCp0MDxToAnZA/pOMbmdqvSAONpo6cY2WiltN94iTBDrWa/Th9A+9KPwbWpRdeAxyTkaPJsZLLNg9Uyk45P9fPhARgiZ6tPqlS0WZC0cC9qTi8QduD/9sYgK+IHl2DVYsIWisW/r3a+g4Htomf65irMXaleuEOiiTIFGR22Xl/adA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by SN7PR11MB7043.namprd11.prod.outlook.com (2603:10b6:806:29a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Fri, 22 Dec
 2023 04:01:38 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::7af8:e4b9:30f0:3ac3]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::7af8:e4b9:30f0:3ac3%2]) with mapi id 15.20.7113.016; Fri, 22 Dec 2023
 04:01:38 +0000
Date: Fri, 22 Dec 2023 12:01:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, <tim.c.chen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, Jianfeng Wang <jianfeng.w.wang@oracle.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2] mm: remove redundant lru_add_drain() prior to
 unmapping pages
Message-ID: <202312221154.85f3c4a3-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231214222717.50277-1-jianfeng.w.wang@oracle.com>
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|SN7PR11MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: deba6d46-33c1-4c40-efa5-08dc02a2b253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEr3CahKYS2C7/hTSut3u63Pmha2K9wyTeFYNsLR86YLLVr2UMB5zj8TxWWXxsSeDjkKBHeZihXScJOCtAHMfE5jo4mdl6GaJJKR7+hwW1JDM+yMwkkBDl+/7zIwHj1EPTRt3M/z+6rrzyC2Z358P4jlgqAMoAq5C2hIuqyzVaCKNZCNbP8qUVHeW4rwBVuIfgF9kaI0OgnPaDRB02qWQIcmA2yPtAN7gs8GDbjVhnYw/QWQRjA9XgFORs+WuXC6cYhFpFvRpYX9vK0vV5Oca3FlJQKmF6X1MiJGaJ4yecc7r/TdS5UIq56E/jyETLOijnGK5NBRAqz0gcmmpjtuaUNO52dnn7qM+QLPc5bnRPakpWAIInk0j34jA5nGmNl8Nwgc9v9xcyIeDLo9DGV8snlUhZqAQUJKVio+X0Lsl1BOJmxRoltG++sUaAKgd5VQGcjCqnpouV1x1dqzbNNLCuFtizhBI8GOYAxs9b73Ft+i0Ut/cZzaxuFkkwmO5UYEHey1+jtiuSyLgFe4wN5p5FXXPMjOgE1GCXcuRI3ewToSh3DTgYYQ/l5gHfXyTj0DgFPZbsL43sLI3Ntn6QCb4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(966005)(83380400001)(82960400001)(36756003)(86362001)(41300700001)(38100700002)(6486002)(5660300002)(1076003)(4326008)(8676002)(8936002)(316002)(6916009)(66946007)(66476007)(66556008)(2616005)(6512007)(26005)(45080400002)(478600001)(6506007)(2906002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gR8iNc8mTsKui558QQiHUVWG6glE4PDOMIGwfmp0ONJRfHEW2AViHKydjEOH?=
 =?us-ascii?Q?F6mLSYDy44SnSVM4ZAy7jtba+D/u1KfKx+b4P7vP6suJwkLbnKVEI/gYObu9?=
 =?us-ascii?Q?U3zb69/7oC7Wd330K1l0lXrbTE9qFeOVADVSvnsMwRzFqgk1D/Prshx2VxEr?=
 =?us-ascii?Q?5d24v/+aRkefwM8fYnxZwZs50qI/Mcr0EeBpO6FoJqW7MRlnCoE6P4MXqP+R?=
 =?us-ascii?Q?/8+1/emoKal3uUSba+AV1iVjIJuXnckjaV5Ebc4JmH2I4hJFgdOJ7OXUoTKg?=
 =?us-ascii?Q?QGaf0J8bCjXKuiAN9noVyvKwOh3HdcT9TGX9K6gpeWRP2p877i4pILh411Kv?=
 =?us-ascii?Q?hbET3xNXcwpJ0HOCbxrwhkjUPfW0TAQ2TKdD8Ow5+OU0QZ0UVwItX2xJ/Yvk?=
 =?us-ascii?Q?9L8jUP49t5PLsT+HOTczacuoCWa6h8f/p40Wq4UQthByMzf2NM9rJ+Bhq9af?=
 =?us-ascii?Q?dG1pxDi43i4d4z8BQAQiXV34Nc0GnFuMn03pbvV+H8yITOQbyyASFsosGPen?=
 =?us-ascii?Q?mTvpI3TdncDTWuBE/IOUUWwFQHmG5vkozLe80L9OwsUN1Vzkvftov9f1ITDK?=
 =?us-ascii?Q?ev8/SSyacxVKtgEWWIO9HIXtjfmt9jPX+lTQaJKzpq/j9WRvvcNKhqrssy/N?=
 =?us-ascii?Q?5EzMOHHNwWGp8PhmzyX3EM4b2Segyd45ol7rkLRueHTqDlrTQJ7HxFX8hx21?=
 =?us-ascii?Q?xg/bOuzI0n0zM1Z6h+ICl0pyqkiGroHbM2g88w9oVJQVq4l88DIFzFPl5YFy?=
 =?us-ascii?Q?Y30G8wpbVn8K7+XkLJ3GcWzSRJzqTTxbtSFsvItfoRd7CRp+DnSzWfgkVXcc?=
 =?us-ascii?Q?CjP92Sp0yzHjDPYUgb27VUM1uA+kN0lMwzo2nXTKN38TCCGHHNHuTws/uzap?=
 =?us-ascii?Q?mxgAkAV/L/K7Ix/FxGVFzW0MhtRjfgrf0fTGs1FSEXquTp4WnwYGR+8VA6Sv?=
 =?us-ascii?Q?RE6j6GRljKO2tapamUYH/GWcIEcdQtjLsMIguJ6hS9QQG0+1CZvdaO8bldAJ?=
 =?us-ascii?Q?Uuqa44j7bzFClSiCKOwYM+2Bd/crcsgB044S2RWrVA3g7u+DbjSRiwNygwWH?=
 =?us-ascii?Q?+hsJAg5R8tLqdvRlcR/m/9Qdm1aGOvaCK13Th+5V5o0tZxJJ5cEliqZ77fnO?=
 =?us-ascii?Q?P3beARTfnO41tOEJRPU4IB64iQ327pgLJ3nJBLDBSQzsQkrbH8l7sZotZ/yr?=
 =?us-ascii?Q?q3/DbUh3Y5Y2Am43rinPyGoG/TdUaAm0BDgMiBKN4rsqSWd3sD9v399/G4mo?=
 =?us-ascii?Q?ANdl3/rcgmAtMVvd3tuAz1RgHbvzKe90hgrIUZLa2Qfa13xjl1FwP8NNY8a9?=
 =?us-ascii?Q?gxtGBucYMIOgkcuz5SJYNEx0IVutoS6xHzCGh/rIAIDPWd0XfYiU5KX/BKFf?=
 =?us-ascii?Q?j7SyYJaPke0LudJtjab0D2Mx3D6XtxbK/+uzDh29xgc37cHldzUaoSrqqY5S?=
 =?us-ascii?Q?pkbP0BgKWNRsZwL8Qq5VRZJ16NqqsWVZ8biXKn70Y8Gntaw737fQTr0G2Ere?=
 =?us-ascii?Q?KsO5A/cE62fGMIDsgLye+NCIusJWt4VCUcLwtiSJAICit6qhgTq+2zVVoJZy?=
 =?us-ascii?Q?48kl7xSRmgrxwuY78K33zO+CmDMaEHel+L2oQQ/+ctu66iubv7Y1wIUUjcAQ?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: deba6d46-33c1-4c40-efa5-08dc02a2b253
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 04:01:38.5254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkIiGtJo1Er1hCtTyw/PNExTBwZCGpqzSBIIINRCN68LePqwD+6q8cR6P5L4lvR4IR/3Es0MCX+sECnU+lH9LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7043
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_mm/page_alloc.c" on:

commit: 5e3b1fa97b04faab8760b62ddab2cd2d62110400 ("[PATCH v2] mm: remove redundant lru_add_drain() prior to unmapping pages")
url: https://github.com/intel-lab-lkp/linux/commits/Jianfeng-Wang/mm-remove-redundant-lru_add_drain-prior-to-unmapping-pages/20231215-062828
base: v6.7-rc5
patch link: https://lore.kernel.org/all/20231214222717.50277-1-jianfeng.w.wang@oracle.com/
patch subject: [PATCH v2] mm: remove redundant lru_add_drain() prior to unmapping pages

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 600s

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


compiler: clang-16
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------------------------+----------+------------+
|                                                                                      | v6.7-rc5 | 5e3b1fa97b |
+--------------------------------------------------------------------------------------+----------+------------+
| kernel_BUG_at_mm/page_alloc.c                                                        | 0        | 10         |
| invalid_opcode:#[##]                                                                 | 0        | 10         |
| EIP:free_unref_page_prepare                                                          | 0        | 10         |
+--------------------------------------------------------------------------------------+----------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312221154.85f3c4a3-oliver.sang@intel.com


[  127.901286][ T2652] ------------[ cut here ]------------
[  127.901579][ T2652] kernel BUG at mm/page_alloc.c:1084!
[  127.901870][ T2652] invalid opcode: 0000 [#1] PREEMPT SMP
[  127.902168][ T2652] CPU: 1 PID: 2652 Comm: trinity-c3 Tainted: G        W        N 6.7.0-rc5-00001-g5e3b1fa97b04 #1 e678fecaf3798641ec130c7b4b31f90b64a8d53d
[ 127.902921][ T2652] EIP: free_unref_page_prepare (mm/page_alloc.c:1084) 
[ 127.903243][ T2652] Code: 8b 55 e4 b9 07 00 00 00 e8 a3 de ff ff 89 47 10 b0 01 83 c4 10 5e 5f 5b 5d 31 c9 31 d2 c3 89 f8 ba 4c 7c 68 c2 e8 86 76 fd ff <0f> 0b 68 c8 21 b2 c2 e8 8a f4 1f 00 0f 0b 0f a3 05 1c e4 c5 c2 0f
All code
========
   0:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   3:	b9 07 00 00 00       	mov    $0x7,%ecx
   8:	e8 a3 de ff ff       	call   0xffffffffffffdeb0
   d:	89 47 10             	mov    %eax,0x10(%rdi)
  10:	b0 01                	mov    $0x1,%al
  12:	83 c4 10             	add    $0x10,%esp
  15:	5e                   	pop    %rsi
  16:	5f                   	pop    %rdi
  17:	5b                   	pop    %rbx
  18:	5d                   	pop    %rbp
  19:	31 c9                	xor    %ecx,%ecx
  1b:	31 d2                	xor    %edx,%edx
  1d:	c3                   	ret
  1e:	89 f8                	mov    %edi,%eax
  20:	ba 4c 7c 68 c2       	mov    $0xc2687c4c,%edx
  25:	e8 86 76 fd ff       	call   0xfffffffffffd76b0
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	68 c8 21 b2 c2       	push   $0xffffffffc2b221c8
  31:	e8 8a f4 1f 00       	call   0x1ff4c0
  36:	0f 0b                	ud2
  38:	0f a3 05 1c e4 c5 c2 	bt     %eax,-0x3d3a1be4(%rip)        # 0xffffffffc2c5e45b
  3f:	0f                   	.byte 0xf

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	68 c8 21 b2 c2       	push   $0xffffffffc2b221c8
   7:	e8 8a f4 1f 00       	call   0x1ff496
   c:	0f 0b                	ud2
   e:	0f a3 05 1c e4 c5 c2 	bt     %eax,-0x3d3a1be4(%rip)        # 0xffffffffc2c5e431
  15:	0f                   	.byte 0xf
[  127.904296][ T2652] EAX: 00000000 EBX: e869ad40 ECX: 00000000 EDX: 00000000
[  127.904681][ T2652] ESI: 00000001 EDI: e869ad40 EBP: ed779b3b ESP: ed779b1f
[  127.905066][ T2652] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
[  127.905480][ T2652] CR0: 80050033 CR2: b69e1000 CR3: 2cd56000 CR4: 00040690
[  127.905867][ T2652] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  127.906253][ T2652] DR6: fffe0ff0 DR7: 00000400
[  127.906508][ T2652] Call Trace:
[ 127.906711][ T2652] ? fault_in_iov_iter_readable (lib/iov_iter.c:109) 
[ 127.907028][ T2652] ? generic_perform_write (mm/filemap.c:?) 
[ 127.907339][ T2652] ? shmem_file_write_iter (mm/shmem.c:?) 
[ 127.907637][ T2652] ? do_iter_write (fs/read_write.c:736) 
[ 127.907899][ T2652] ? vfs_writev (fs/read_write.c:933) 
[ 127.908144][ T2652] ? do_writev (fs/read_write.c:976) 
[ 127.908376][ T2652] ? __ia32_sys_writev (fs/read_write.c:1049 fs/read_write.c:1046 fs/read_write.c:1046) 
[ 127.908644][ T2652] ? __do_fast_syscall_32 (arch/x86/entry/common.c:165) 
[ 127.908927][ T2652] ? irqentry_exit_to_user_mode (kernel/entry/common.c:312) 
[ 127.909235][ T2652] ? irqentry_exit (kernel/entry/common.c:445) 
[ 127.909485][ T2652] ? do_fast_syscall_32 (arch/x86/entry/common.c:346) 
[ 127.909757][ T2652] ? do_SYSENTER_32 (arch/x86/entry/common.c:384) 
[ 127.910012][ T2652] ? entry_SYSENTER_32 (arch/x86/entry/entry_32.S:840) 
[  127.910282][ T2652] Modules linked in:
[  127.910512][ T2652] ---[ end trace 0000000000000000 ]---
[ 127.910806][ T2652] EIP: free_unref_page_prepare (mm/page_alloc.c:1084) 
[ 127.911140][ T2652] Code: 8b 55 e4 b9 07 00 00 00 e8 a3 de ff ff 89 47 10 b0 01 83 c4 10 5e 5f 5b 5d 31 c9 31 d2 c3 89 f8 ba 4c 7c 68 c2 e8 86 76 fd ff <0f> 0b 68 c8 21 b2 c2 e8 8a f4 1f 00 0f 0b 0f a3 05 1c e4 c5 c2 0f
All code
========
   0:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   3:	b9 07 00 00 00       	mov    $0x7,%ecx
   8:	e8 a3 de ff ff       	call   0xffffffffffffdeb0
   d:	89 47 10             	mov    %eax,0x10(%rdi)
  10:	b0 01                	mov    $0x1,%al
  12:	83 c4 10             	add    $0x10,%esp
  15:	5e                   	pop    %rsi
  16:	5f                   	pop    %rdi
  17:	5b                   	pop    %rbx
  18:	5d                   	pop    %rbp
  19:	31 c9                	xor    %ecx,%ecx
  1b:	31 d2                	xor    %edx,%edx
  1d:	c3                   	ret
  1e:	89 f8                	mov    %edi,%eax
  20:	ba 4c 7c 68 c2       	mov    $0xc2687c4c,%edx
  25:	e8 86 76 fd ff       	call   0xfffffffffffd76b0
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	68 c8 21 b2 c2       	push   $0xffffffffc2b221c8
  31:	e8 8a f4 1f 00       	call   0x1ff4c0
  36:	0f 0b                	ud2
  38:	0f a3 05 1c e4 c5 c2 	bt     %eax,-0x3d3a1be4(%rip)        # 0xffffffffc2c5e45b
  3f:	0f                   	.byte 0xf

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	68 c8 21 b2 c2       	push   $0xffffffffc2b221c8
   7:	e8 8a f4 1f 00       	call   0x1ff496
   c:	0f 0b                	ud2
   e:	0f a3 05 1c e4 c5 c2 	bt     %eax,-0x3d3a1be4(%rip)        # 0xffffffffc2c5e431
  15:	0f                   	.byte 0xf


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231222/202312221154.85f3c4a3-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


