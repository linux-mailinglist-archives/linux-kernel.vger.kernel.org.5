Return-Path: <linux-kernel+bounces-15101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2961C822740
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AAE61F21E2B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2528318035;
	Wed,  3 Jan 2024 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NoMCTK4h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF73018029
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 02:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704250537; x=1735786537;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=HoaO7iZEiQD+y1ez3VdICelxAdX4dA49bkqsyHmXHLw=;
  b=NoMCTK4h16qff4+UrpUkBe/DxSQvIlryDr/JcGsvDsepIagwAHfGXqzj
   RzaJNn1P3yGBXZ3LbVpl+0DOHfCGmClUv1YLaVz/emkFzFl4+CjWiK1f6
   /KKiRKutuq7Weiu9x5O1auyF54uNiURbsC3jX8hsHoWk3UALLL4x3zu1g
   a7Gm53CZPQ7OQAF1qWlN7+8T9BbyFX47m3mOMlaU+jlcZa/KCcWLPK4Rk
   uOan+DqtHx44PSsl7fyISmv0n8rZ1r1kUyNE4UzO4M/SpTG6BkksIqbEJ
   8BUdHJ85skofNaOducv3T+g8y9SXnGB2sSKvCv3yvA+OeadevQRWrOk7a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="10577256"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="10577256"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 18:55:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="923400264"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="923400264"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 18:55:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 18:55:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 18:55:35 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 18:55:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOJ2lS1aHpCjBnCJtH9/OVddWePGzFxKylYxulv3zIixbG1arO2tTjA2nV8FTfMsnd4oSGn6dY+B5gkPRFVyJD+McZqnrkIv1+Mz8u4eeZiQwqmDGDR9PF0YLQSgwU5cZxrVPH2dNKuinhO8BY2IkIhsZHHEWFhsfs3gl4sDBwbCai1M2Xqh7Zqw3rP8LU3l8R3DDyZcbjzPgYv880wMqzWtdhAeU0Y00HWR3wkBUkazNBnjv+RbGDUE5GVLmUaZdKMBjJkA0jRLa6yupjsOheCe9yPJOH4aidEi549lg/Q0Ds6JvKFqiiq5QEvxetQKLf5mtJUCmae8ARsY7Iwigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2YAhagDUx9Lb/w1mUIPxH1d1vzCZNqXYSUT9Z4K9po=;
 b=TOqR9Eis1D1VZPTPSChkx0iE8x+tCPRStpTadNxC5GDJFkJRV9vDjrD1FjBJDstnAK0seD4O8dn/QwlA7qeHcOm/yWYRgnbDkGyy2txsczCnndUfOwXxdlX++vamh/n9p2hJ9iEZ0EQHV7d0YiPCPA6uIOtmmDQC0u7aWtniQ2FQR4kIS91GcZppSWSmHoLLKwg2hi5vAaR2jktKvXvpfNQnE04tffWKVZSnpVug0xe77Y4lWRNbheiwiZPMiPRxRRD05kWzhAiIm39gFik5Sw2LLePQUz+NaVm5j9BiS7ltSW7ZoeSJhfwCAcTLOy/85NUEBvj9DwtzUjosfRggig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 02:55:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 02:55:27 +0000
Date: Wed, 3 Jan 2024 10:55:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>, <Naohiro.Aota@wdc.com>, Lai Jiangshan
	<jiangshan.ljs@antgroup.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 2/7] workqueue: Share the same PWQ for the CPUs of a pod
Message-ID: <202401031025.95761451-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231227145143.2399-3-jiangshanlai@gmail.com>
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 2acf7b72-8c89-4e7a-e4bc-08dc0c077087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMcEcd7/GlykHMMZBwSJpO+NJKryFYkDjBSpBZgLZJGfUJHQXz8NQGAws2VP2GTPqT7P6PXLq31CCf6jv8K9K+fxRlTuFSiEI1OAY6fi51zXY9/0Lv8bofRwjeqZzvLn6pFZDw3nF7bgb2ZHNIjcMwruQ5O5zZeEyTAp84M7qKUyv8pBhEfHq0Ded+PrisaYlOXx489YcrFfa0OX1K4UytgvWLjOA9Pq7m6AchJ5vB80G7erS4408S1En4s58cz+BRnIszjftqQ5PZXVrDZM0drx+vg1y+1xMk/eXrMtjnDat3aUCheXUxnxvZU2HIAu9fm1MMj7QbroXMid9uKI0w8MX0F6ubZLkGrFnL+i9kaBVjNklv50VVjnuyNtPTTNRtP3fO3f5JWE5k8wjWvIb1zcsyeU8lZjLBvaQ45Q6IM/JeLKskw2cQ1EUhuMLowrlmSkyZ9oEXQmF5TINMHuxBBHsL2oNC/UojY5eyhPtbb22/AayykE1PVvSri/mdv/OmxD1SJncCbM+2Jfrw7mzIFhQgPPa3DfAXbu84hvV0loT0mYMF1sei84gthO+KTGCnsdE+cTc6HQAvu1sGKD9Qn8LjCaVzISq3+8qv+c2dB6yxYh3IMfkvt04IVFiQmVdCGnAFQXbmyf3PBiqCJwAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(2906002)(8676002)(8936002)(4326008)(36756003)(66556008)(6916009)(316002)(54906003)(478600001)(66476007)(86362001)(966005)(6486002)(5660300002)(6506007)(45080400002)(6666004)(6512007)(41300700001)(107886003)(82960400001)(2616005)(1076003)(26005)(38100700002)(83380400001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fnZnx8qrWe7NjUtYJumi9l3kCh9U0OkBREs8BD7gcEYi2BYv6uOQ/z6yEQ+d?=
 =?us-ascii?Q?MLSDG30jZEFrevoAJ52ClG1zyQDcn00Rti+9QSIADurfo5rYX71BQ87gChO0?=
 =?us-ascii?Q?oIvi4MtWHlFppE/9ACzxy+fLoOpgze0cnn0IqSN2H/592VPGiY1HffxE3Zmf?=
 =?us-ascii?Q?CmSMfiQ6owKZ33rEpE4UAFx+ZY1/N6oeMkpdJGc9diFdVlNhpcRj0MSkNjZF?=
 =?us-ascii?Q?AbBiwXUpKyfcl/EIVrm+L4iYNwqx9yITOSHjPstE0vo4p2k3oU/jjFrzdPva?=
 =?us-ascii?Q?Pq0e5095LQnQa16o95QlCDtc9HluT3E0u+fHywukI8RzTqqd+EmfjVeVj7/+?=
 =?us-ascii?Q?x+JlJNki3fcOVq7LTPSpDeXJIzt/V7TVPHtRdn0mt7fvrM9/ERWyEyg+/hlw?=
 =?us-ascii?Q?4LBN8lZ647i1Fynn3fo+/Zz6cDiguzYKBkQPfa9DlZ0hLcMfjvgvSkJpa8wx?=
 =?us-ascii?Q?lrIJHu9QbXp7Rn4Kv4TjdWdV5fwliaUncaENCNWIsnArH/KpXqK3SwyukiYH?=
 =?us-ascii?Q?QX/zZjHiAH6l/fmG1AGoxBnNDWvMB/7wL7KpO2DGryZqaX3CL2A0l9AciuLz?=
 =?us-ascii?Q?sRswc/Hs9jCWRfnVefTQKyw8ifUF5J03G7k65mTbJI5L332A1IMJwprvMXxJ?=
 =?us-ascii?Q?NMoN7RPzTO+Dm23QL+vgJq4r3ahtBQX3EoCxCELJkgAkJPCpnZkwyGTTE+kY?=
 =?us-ascii?Q?ycUJvNwFAzey/m0moTy1B5SxH3Asr6WZBNZtrwCZSdXKpMIWBUhydq6VzsC/?=
 =?us-ascii?Q?OLLSzk/k5mMs2BMnTLWrQ4HY9TxUPsfReA369PvE+YxvNCKbauLkSU2yHoHF?=
 =?us-ascii?Q?SfalM14O0f/nwEnptwsElhbIYRMDvLhmAuMTVR3cQ4JpwIn9f3FvYL/1sBPo?=
 =?us-ascii?Q?QjV9iGREsB99yFLEaOe4IjGYoQL1aTy3z3btSrzA6DXB352nNKDXgtezacYp?=
 =?us-ascii?Q?3b0+UZrHspNiwy+zRJej2QIbDUyIMffF2BTqjVkKWbZgfuA2YbcXk34CpduM?=
 =?us-ascii?Q?o5c5yHJhGtuP8cDxIWHBm1OOtmgmsZd/4l0Q920iLJNQxk0/v21YtVa+lLVV?=
 =?us-ascii?Q?kuvSjpVtEOxrs92Thyrh+TdfoQ1be/slWA8accjobgE39mS84M9LwyoF7Rc5?=
 =?us-ascii?Q?2cYL7wVvirle/GvsDnyAOWDEAc18zc+mKZJ2Ngt2ZYu5ksLrIAD+K34OxM0u?=
 =?us-ascii?Q?uP3hiQ3dGNttD1ghbxJTS0ViOxCnY3WA3lkh8qChTSeXzCGrUinQAvVnqgT8?=
 =?us-ascii?Q?p5Ge7UEz97rRnk7N/XMV98v5sYzOaRz3frW54AuMLfdHZLM6KA679L8g2G5u?=
 =?us-ascii?Q?B1eIci+vqfmdWVkXzFo/hwPIqyAJefJhNbnvTuV6gimml9N3oSB0hWRUB76V?=
 =?us-ascii?Q?nhuSsd9Gr7utLUYpszFTeQJeNxvO32iuc/ADUkCHz2BpKdMb4KYo3+xoAZVr?=
 =?us-ascii?Q?Z/E7jAoxNeJKh7qyqzVDvHb2jMg1P/aA2SF0L3QAG8n2qIySL/O/6pjHOv2X?=
 =?us-ascii?Q?67BQq6IG18ojeoLak3YY24mlObOH0Oadai+NqkRtDkv839sf5okRpXduEn9q?=
 =?us-ascii?Q?m1wqoDMmg63aO9UxwPWY1jnfJqpPIEkzF5y2WG66/xgQPFS8VX6o9QFfC1mt?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acf7b72-8c89-4e7a-e4bc-08dc0c077087
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 02:55:27.3938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hBu9gITWmIYO3tpjQP/BXe2s7+YyGFG2dW/pu8Dv+z2w/jUydE/5nbEvnOexMcNiFMiFyLo8znf0wUPKIQqDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5776
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/workqueue.c:#destroy_workqueue" on:

commit: 3f033de3cf87ef6c769b2d55ee1df715a982d650 ("[PATCH 2/7] workqueue: Share the same PWQ for the CPUs of a pod")
url: https://github.com/intel-lab-lkp/linux/commits/Lai-Jiangshan/workqueue-Reuse-the-default-PWQ-as-much-as-possible/20231227-225337
base: https://git.kernel.org/cgit/linux/kernel/git/tj/wq.git for-next
patch link: https://lore.kernel.org/all/20231227145143.2399-3-jiangshanlai@gmail.com/
patch subject: [PATCH 2/7] workqueue: Share the same PWQ for the CPUs of a pod

in testcase: hackbench
version: hackbench-x86_64-2.3-1_20220518
with following parameters:

	nr_threads: 800%
	iterations: 4
	mode: threads
	ipc: pipe
	cpufreq_governor: performance



compiler: gcc-12
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401031025.95761451-oliver.sang@intel.com


[   30.471685][    T1] ------------[ cut here ]------------
[ 30.476998][ T1] WARNING: CPU: 111 PID: 1 at kernel/workqueue.c:4842 destroy_workqueue (kernel/workqueue.c:4842 (discriminator 1)) 
[   30.486210][    T1] Modules linked in:
[   30.489964][    T1] CPU: 111 PID: 1 Comm: swapper/0 Not tainted 6.6.0-15761-g3f033de3cf87 #1
[   30.498396][    T1] Hardware name: Inspur NF8260M6/NF8260M6, BIOS 06.00.01 04/22/2022
[ 30.506220][ T1] RIP: 0010:destroy_workqueue (kernel/workqueue.c:4842 (discriminator 1)) 
[ 30.511794][ T1] Code: c2 75 f1 48 8b 43 08 48 39 98 a0 00 00 00 74 06 83 7b 18 01 7f 14 8b 43 5c 85 c0 75 0d 48 8b 53 68 48 8d 43 68 48 39 c2 74 4e <0f> 0b 48 c7 c6 e0 1d 42 82 48 8d 95 b0 00 00 00 48 c7 c7 68 a9 93
All code
========
   0:	c2 75 f1             	retq   $0xf175
   3:	48 8b 43 08          	mov    0x8(%rbx),%rax
   7:	48 39 98 a0 00 00 00 	cmp    %rbx,0xa0(%rax)
   e:	74 06                	je     0x16
  10:	83 7b 18 01          	cmpl   $0x1,0x18(%rbx)
  14:	7f 14                	jg     0x2a
  16:	8b 43 5c             	mov    0x5c(%rbx),%eax
  19:	85 c0                	test   %eax,%eax
  1b:	75 0d                	jne    0x2a
  1d:	48 8b 53 68          	mov    0x68(%rbx),%rdx
  21:	48 8d 43 68          	lea    0x68(%rbx),%rax
  25:	48 39 c2             	cmp    %rax,%rdx
  28:	74 4e                	je     0x78
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 c7 c6 e0 1d 42 82 	mov    $0xffffffff82421de0,%rsi
  33:	48 8d 95 b0 00 00 00 	lea    0xb0(%rbp),%rdx
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	c7                   	(bad)  
  3d:	68                   	.byte 0x68
  3e:	a9                   	.byte 0xa9
  3f:	93                   	xchg   %eax,%ebx

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 c7 c6 e0 1d 42 82 	mov    $0xffffffff82421de0,%rsi
   9:	48 8d 95 b0 00 00 00 	lea    0xb0(%rbp),%rdx
  10:	48                   	rex.W
  11:	c7                   	.byte 0xc7
  12:	c7                   	(bad)  
  13:	68                   	.byte 0x68
  14:	a9                   	.byte 0xa9
  15:	93                   	xchg   %eax,%ebx
[   30.531233][    T1] RSP: 0000:ffffc90000073dd8 EFLAGS: 00010002
[   30.537151][    T1] RAX: ffff88a444cd1000 RBX: ffff88a444ce6600 RCX: 0000000000000000
[   30.544968][    T1] RDX: ffff88a444ce665c RSI: 0000000000000286 RDI: ffff88a4444c4000
[   30.552785][    T1] RBP: ffff88a444cd1000 R08: 0004afcaac775f46 R09: 0004afcaac775f46
[   30.560605][    T1] R10: ffff88984f050840 R11: 0000000000008070 R12: ffff88a444cd1020
[   30.568430][    T1] R13: ffffc90000073e00 R14: 0000000000000462 R15: 0000000000000000
[   30.576246][    T1] FS:  0000000000000000(0000) GS:ffff88afcf8c0000(0000) knlGS:0000000000000000
[   30.585017][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.591447][    T1] CR2: 0000000000000000 CR3: 000000303e01c001 CR4: 00000000007706f0
[   30.599266][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   30.607085][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   30.614910][    T1] PKRU: 55555554
[   30.618314][    T1] Call Trace:
[   30.621453][    T1]  <TASK>
[ 30.624242][ T1] ? destroy_workqueue (kernel/workqueue.c:4842 (discriminator 1)) 
[ 30.629201][ T1] ? __warn (kernel/panic.c:677) 
[ 30.633129][ T1] ? destroy_workqueue (kernel/workqueue.c:4842 (discriminator 1)) 
[ 30.638091][ T1] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 30.642454][ T1] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 30.646639][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 30.651171][ T1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 30.656049][ T1] ? destroy_workqueue (kernel/workqueue.c:4842 (discriminator 1)) 
[ 30.661009][ T1] ? destroy_workqueue (kernel/workqueue.c:4783 kernel/workqueue.c:4842) 
[ 30.665888][ T1] ? __pfx_ftrace_check_sync (kernel/trace/ftrace.c:3803) 
[ 30.671200][ T1] ftrace_check_sync (kernel/trace/ftrace.c:3808) 
[ 30.675820][ T1] do_one_initcall (init/main.c:1236) 
[ 30.680354][ T1] do_initcalls (init/main.c:1297 init/main.c:1314) 
[ 30.684625][ T1] kernel_init_freeable (init/main.c:1555) 
[ 30.689678][ T1] ? __pfx_kernel_init (init/main.c:1433) 
[ 30.694471][ T1] kernel_init (init/main.c:1443) 
[ 30.698658][ T1] ret_from_fork (arch/x86/kernel/process.c:147) 
[ 30.702927][ T1] ? __pfx_kernel_init (init/main.c:1433) 
[ 30.707713][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[   30.712333][    T1]  </TASK>
[   30.715217][    T1] ---[ end trace 0000000000000000 ]---
[   30.720522][    T1] destroy_workqueue: ftrace_check_wq has the following busy pwq
[   30.728002][    T1]   pwq 452: cpus=0-223 node=3 flags=0x4 nice=0 active=0/256 refcnt=56


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240103/202401031025.95761451-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


