Return-Path: <linux-kernel+bounces-19653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C30C82705D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E131C2295B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E5445944;
	Mon,  8 Jan 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3eRRkap"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D88A45954
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704722035; x=1736258035;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=VNpnoVBqMSHQKavQm92B7kRhMUOZELedYp8mDy/2+vc=;
  b=D3eRRkapMUCLQfswOkLLgTrKUkxosTK6wMxO03rH+NmfSGImHxYxxI/Z
   TmMt4BIjDN/gzCv8+DbK7vsiyjnKLqEgrIsGDBr1lrv0PlGmBrDjCS0Ca
   Uh61Xr4thxozX5jSChWCd35ppSbWj7QNACzkcV1dUA38SBUkp0QdIR1sD
   VQesZnFLQG8+ELLQsutNNhf7heJY8KUElp1UCGGnmygufLAJr29ZvhV7L
   9b+iU+lg4jhY6kStyjYb582ZkQeLEpXLBgx1BdyVWLg4j+LsB4yqEk29n
   0JSXFWym0SBQsNyXqjWT7tim2ZLcHqf7VyTkHtFOPG69s9ow3gyZTtNYL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429070416"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="429070416"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 05:53:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1028408798"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="1028408798"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 05:53:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 05:53:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 05:53:53 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 05:53:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIfCnQz0NCqPhgg6h0fREZHjRQqRsyjXejo7Mj3kJqiLGb72jSRQTQq3IoYxxhbUEe+3V9by8WQq5sLPjsUK9ZhmpU1lfO053mVQ+Jo6n9+x4jMB73Q92tJPxM4b8ef/XrbM2jNQt4iIK0QwXliOPCgvRX/0ISeP5+xoYGmKG9TmhL+DZSZYl5k7E3IFnO0+R6O57ThTKethwSu6lpfQ4xJOrNnXJigYUvLzUtnlhTm73RSiP8SV8go2NlIEu2QBudH06V6A1ed6sE+8nI524Q9vJN1ZvbsZjGPf2HE6MoFs+ZQFDitFiHteZOJzBA/QhH1zza/MnQ20VTBbOjBzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBMiSrJGFBjq+FTq+EUG0SpJJ1G2/vHV/6JC/EQHsrQ=;
 b=FQfRaUsvP7+i/X4G3tWsn/sAZv67+QoAkvAI5qlooqM5fS1IwE4zN3sU0YiR1qYy7+lvAQQTeKzXK+GS2D/56AOW3DXyQaUUF/XDGNUG7fa4yInVCPHJ5wIQTY3ATI0XQwrrTUYpiLsnHQEQUNaCzsq+/sJX4UaYBggnKNWXP0SttS7s2lgAwdhNONMk3mmFmQn6kLMSQYRh7t4oELZgT88SfKdAK8SXoSMOakNlVfMySyjMqInRKvhqBkbVt66EeV4nePBryNF4HH/mylV5VbTGyV7QPXufAPtboxnqrG3NoHo71ielbjlZsPGkzPdeexrbtGfB7VtUtftSmDrNzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4639.namprd11.prod.outlook.com (2603:10b6:806:70::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 13:53:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 13:53:51 +0000
Date: Mon, 8 Jan 2024 21:53:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Xuewen Yan <xuewen.yan@unisoc.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Zhiguo Niu
	<zhiguo.niu@unisoc.com>, <linux-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
	<longman@redhat.com>, <boqun.feng@gmail.com>, <ke.wang@unisoc.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] lock/lockdep: Add missing graph_unlock in validate_chain
Message-ID: <202401082116.303fea3-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240104054030.14733-1-xuewen.yan@unisoc.com>
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4639:EE_
X-MS-Office365-Filtering-Correlation-Id: 64db7f2e-99df-4dcf-cfec-08dc10513eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KN84J2Opd5u4TGHkBoOx66JeQ5NI14SRJNfjxbuS4xAsVKF38so/4DJyD2sni53ap0pEGVgwltkURFkcuqvJQbqz0na2vuGIHsIkVsxH1ExbUJGW3LWii/BIFk1dX1pK2oS8Tvf59JNq+qQGI54p8YAwWF+rBEZwo12zubELDXLXds/OyfDxIvH7v0Gaos5IB5sLs7CN4y3NJRf2ANxQGdUwawF03lpZklui703XUKFiKckZe1XdQgw1KKTd+eU85cZvfo51CD45gVCtEj4o/PgigwHnSnOHQGET14D2+ACBgy0FU2qdMTno/f9FOzKlVPdDJWgciPcOUpvZvVq/jEG2+HVCcg0DoCxG1dvTSGnp3PwN68cc73LRDEBCltIzH1f6xsbL4rqgoHFYioHywY04UNd9BOhR3MODAWvG7AhKyTO5G85kxUACrVR1tZGI7WHu/mNJDB0/yhhCiTAQ9pItr5VNXaQM6AA/rlIJ+oCFuhSyriL7MaJAVIR+8v2CFzZ4ihrGF3QlLtk0+DPe8uy/tLRmB5uVLkpDbJ075I19DRX8i8SIrYz/1d9UVA5XqvIsiWikGntaitdj63AHCnL04ZQTPLBCJaWrnh1gAjAM2t67P6IQV8VLPoazc4RLqQfFqDOttYAlhz5nmyQOFoA6nuOVHOmcJlrVPQnwSCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(2906002)(7416002)(15650500001)(5660300002)(82960400001)(86362001)(41300700001)(316002)(45080400002)(36756003)(8676002)(8936002)(2616005)(107886003)(6486002)(66946007)(66556008)(1076003)(66476007)(6916009)(26005)(478600001)(966005)(6512007)(6506007)(83380400001)(6666004)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CWzzTASxIMeId2WNScbn8o/q/UY/vdOx0NAaFePzWJ6Nkl4iMsFSKcbhlPLI?=
 =?us-ascii?Q?9CxFBzKSTRwkwBCu1eqN6VxdsRi2S/Idth4FAEcD7ap04ihBi6q3SRsPwGzt?=
 =?us-ascii?Q?9PB51B/uIvQpFXgtwy8+PyGANeYld+nqHaJm3SCtKfz1rkBTZqwPQnQWyJMZ?=
 =?us-ascii?Q?dE82iziNnYmfhKDzAyk5+4zuP2OTr31Ys5HWBpH+kTbZGgU3yV9P8vy0lb2s?=
 =?us-ascii?Q?Oq236Yw9tDk036coCl9WaZIAR2WjKHOvhWXGv8q4zYrj9rlgThHpKk2Z8Aps?=
 =?us-ascii?Q?lAlyo3ghkO/imJZ5fcCawXVNpPk3seVPkFYc4BaTR7JdGWQDFmcT2QYHFq8V?=
 =?us-ascii?Q?TowD+5me6VzO0urDuaRvjZPW2fqPFWTcIJqp+QPD8x01qUDOU0XsJBcCE6Yf?=
 =?us-ascii?Q?Y2JAp5l0oBhn6ThUpaM5ZzSNcbIHyvHQSSR05N6NSb6YV5nD2rDJmGT51D8o?=
 =?us-ascii?Q?LbymH9V2kSVx9SUDELAHV3BOSh/aDVtrp3tJJCEcBkz4Zd9UASxutsucJE3N?=
 =?us-ascii?Q?0wDQENg7M32NFzT16RZ5GEMwWDzMdDwZN5izSrxeIWrnKpPAT8I94Px/MEXp?=
 =?us-ascii?Q?Vy2zbRzesvDBtLPyatfmdihspN5QAxMOjbHoBLWxvZ+yRb/+YmBuwV5e5BNm?=
 =?us-ascii?Q?OCtiCXcbKEhPqhGbWRvYFOoqZ2hGX382LN0F0AZqgWpeXC7F1fCA/8ZsohJH?=
 =?us-ascii?Q?I9HtdLTktlyyMS9LdnAkA9V1hq00b8uZ/73kF2wXAxCKBBTF6OMWIs1hNzHz?=
 =?us-ascii?Q?bgRAwiI09V22l5x9N2uy0O16kQx5AFwMG9wMfeB/L+D7FU1W2zYuk/p4Xblm?=
 =?us-ascii?Q?cc1k0oMLkplLAayxyHIgYe//IpRpvshiBBw+Z6uAMQ4Vqwjrblhw3rI45ojz?=
 =?us-ascii?Q?rth30mtzPv95bvOcxjr26ifLiKdeF2xins9awDLJxzKs1xlVl5R3iuTZQHuz?=
 =?us-ascii?Q?JtxvRl+RnOz/Av0ZPYGI7H366Hwp5vNw+pCcMNrbE4q0L/TK7MCjSQfXnWAl?=
 =?us-ascii?Q?lKHVAA02HHQEMXieKwHA9haXRJWS7ljAz82y/2bVrMpN4DWxAg9bVQKmZKp+?=
 =?us-ascii?Q?BGTID0+9T32f0O2JcoEK6TTgJxTZyGsiqCeSTdKtQKOnAsz9Bh6t2AbDtsl3?=
 =?us-ascii?Q?6H7ZoA41z0DwYUgg5d1lxUsRtTjmVqfBSTb8BOHMlZY2p6GwnRPdhJijineX?=
 =?us-ascii?Q?sAFdokTtswytVSd/i+eEdEgRgMCYASr61NrHKwtfX0XvkPyiTomzWcfFjMQH?=
 =?us-ascii?Q?fxsaQlDT2c53Ov2shD2OHhaqnS7969Y+EVZatLVEEjaIdw/ChL0jIqUbzdRX?=
 =?us-ascii?Q?bdNqU/9/m6poEFHhy687GG+gnTD1iLKmdKq/xdQJOQkcCNf40AgUkWUPXeAJ?=
 =?us-ascii?Q?C/IhsQ6U+wEPsRtv9HZrZrAF0/NOwWXF9Np32GfGK+dRfLVlLkjow+8ZB/M2?=
 =?us-ascii?Q?+xXFpk+/e5UFsTfUd6cQ92KC1q7LVxniK6FTMPrKqGgXyr3ZZjSEKlHRU4tm?=
 =?us-ascii?Q?u6c4T++t5aQ81OCDLGcCmb4k3anB/LGgJvdGQEE+BTbKrjqYF+fq68VqVs4C?=
 =?us-ascii?Q?8es5YI13qwhsNlmHDfI27vmOjZtf8BFmj7ETWKPdwObW+rjA9+LyONBpVfjI?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64db7f2e-99df-4dcf-cfec-08dc10513eb8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:53:51.3971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAqAIpwAI9u9HC943iIKoda0R7MY4P/KkO4hYn0FErxE301yiN7qT8pXlYAXQMQOYD3dR8Bquh1pVscpwkq38w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4639
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/locking/lockdep.c:#lock_acquire" on:

commit: 1033f8642b6ca8652763f95013e30ff1c220f3c9 ("[PATCH] lock/lockdep: Add missing graph_unlock in validate_chain")
url: https://github.com/intel-lab-lkp/linux/commits/Xuewen-Yan/lock-lockdep-Add-missing-graph_unlock-in-validate_chain/20240104-134335
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 67a1723344cfe05430977483d6d3c7a999480143
patch link: https://lore.kernel.org/all/20240104054030.14733-1-xuewen.yan@unisoc.com/
patch subject: [PATCH] lock/lockdep: Add missing graph_unlock in validate_chain

in testcase: boot

compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------------+------------+------------+
|                                                         | 67a1723344 | 1033f8642b |
+---------------------------------------------------------+------------+------------+
| WARNING:at_kernel/locking/lockdep.c:#lock_acquire       | 0          | 8          |
| EIP:lock_acquire                                        | 0          | 8          |
+---------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401082116.303fea3-oliver.sang@intel.com


[    0.755622][    T0] ------------[ cut here ]------------
[ 0.756871][ T0] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:467 lock_acquire (kernel/locking/lockdep.c:467) 
[    0.757950][    T0] Modules linked in:
[    0.758418][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.7.0-rc8-00007-g1033f8642b6c #1
[    0.759457][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.760652][ T0] EIP: lock_acquire (kernel/locking/lockdep.c:467) 
[ 0.761215][ T0] Code: 03 c1 e3 10 8b 45 0c 83 e0 01 c1 e0 12 01 d8 05 00 40 08 00 89 45 e8 8d 55 d4 89 f9 56 e8 47 00 00 00 83 c4 04 e9 67 ff ff ff <0f> 0b b8 c8 51 6a c2 e8 b7 66 f7 00 c7 05 e4 50 8b c2 00 00 00 00
All code
========
   0:	03 c1                	add    %ecx,%eax
   2:	e3 10                	jrcxz  0x14
   4:	8b 45 0c             	mov    0xc(%rbp),%eax
   7:	83 e0 01             	and    $0x1,%eax
   a:	c1 e0 12             	shl    $0x12,%eax
   d:	01 d8                	add    %ebx,%eax
   f:	05 00 40 08 00       	add    $0x84000,%eax
  14:	89 45 e8             	mov    %eax,-0x18(%rbp)
  17:	8d 55 d4             	lea    -0x2c(%rbp),%edx
  1a:	89 f9                	mov    %edi,%ecx
  1c:	56                   	push   %rsi
  1d:	e8 47 00 00 00       	call   0x69
  22:	83 c4 04             	add    $0x4,%esp
  25:	e9 67 ff ff ff       	jmp    0xffffffffffffff91
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 c8 51 6a c2       	mov    $0xc26a51c8,%eax
  31:	e8 b7 66 f7 00       	call   0xf766ed
  36:	c7 05 e4 50 8b c2 00 	movl   $0x0,-0x3d74af1c(%rip)        # 0xffffffffc28b5124
  3d:	00 00 00 

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 c8 51 6a c2       	mov    $0xc26a51c8,%eax
   7:	e8 b7 66 f7 00       	call   0xf766c3
   c:	c7 05 e4 50 8b c2 00 	movl   $0x0,-0x3d74af1c(%rip)        # 0xffffffffc28b50fa
  13:	00 00 00 
[    0.763535][    T0] EAX: 00000000 EBX: 00200246 ECX: 00000000 EDX: 00000000
[    0.764339][    T0] ESI: 00000000 EDI: c2c299b4 EBP: c2877f3c ESP: c2877f10
[    0.765192][    T0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00210097
[    0.766057][    T0] CR0: 80050033 CR2: ffd96000 CR3: 02e96000 CR4: 00000090
[    0.766888][    T0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    0.767677][    T0] DR6: fffe0ff0 DR7: 00000400
[    0.768224][    T0] Call Trace:
[ 0.768615][ T0] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
[ 0.769115][ T0] ? __warn (kernel/panic.c:236 kernel/panic.c:677) 
[ 0.769584][ T0] ? lock_acquire (kernel/locking/lockdep.c:467) 
[ 0.770147][ T0] ? report_bug (lib/bug.c:199) 
[ 0.770697][ T0] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 0.771253][ T0] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 0.771781][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:258) 
[ 0.772375][ T0] ? handle_exception (arch/x86/entry/entry_32.S:1056) 
[ 0.772953][ T0] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 0.773465][ T0] ? lock_acquire (kernel/locking/lockdep.c:467) 
[ 0.774005][ T0] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 0.774531][ T0] ? lock_acquire (kernel/locking/lockdep.c:467) 
[ 0.775079][ T0] ? vprintk_emit (arch/x86/include/asm/preempt.h:104 kernel/printk/printk.c:3899 kernel/printk/printk.c:3914 kernel/printk/printk.c:2310) 
[ 0.775628][ T0] _raw_spin_lock (include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:154) 
[ 0.776177][ T0] ? AA_spin (lib/locking-selftest.c:310) 
[ 0.776678][ T0] AA_spin (lib/locking-selftest.c:310) 
[ 0.777139][ T0] dotest (lib/locking-selftest.c:1455) 
[ 0.777627][ T0] ? _printk (kernel/printk/printk.c:2331) 
[ 0.778068][ T0] locking_selftest (lib/locking-selftest.c:2821) 
[ 0.778571][ T0] start_kernel (init/main.c:1023) 
[ 0.779072][ T0] i386_start_kernel (arch/x86/kernel/head32.c:79) 
[ 0.779655][ T0] startup_32_smp (arch/x86/kernel/head_32.S:295) 
[    0.780199][    T0] irq event stamp: 221
[ 0.780678][ T0] hardirqs last enabled at (221): console_unlock (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:341 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 0.781708][ T0] hardirqs last disabled at (220): console_unlock (kernel/printk/printk.c:339) 
[ 0.782687][ T0] softirqs last enabled at (0): 0x0 
[ 0.783367][ T0] softirqs last disabled at (0): 0x0 
[    0.783995][    T0] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240108/202401082116.303fea3-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


