Return-Path: <linux-kernel+bounces-133370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D1089A2EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FB72821AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A843171659;
	Fri,  5 Apr 2024 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="ypdILxWl"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2122.outbound.protection.outlook.com [40.107.94.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBE816FF49;
	Fri,  5 Apr 2024 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336190; cv=fail; b=eheFrMdEADwnDoZ+tm8vRt/bk+O6xzNNudiPt556vbEopjjwFDHKpanGZO4eYqojpWRzh05WjCBLDa8rtr4tOiSFbMKZ/CH1d3W6R6sHelnnZnbIMhslApZCTk4dyTZdXpPRHxRwp1wM8lHRQW5+BI6+znlN/ZX8D2TDWMuq4OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336190; c=relaxed/simple;
	bh=m1TjF+L4VPDmKV4xqFqfMTw8D8AZCktIkY8Tv3ei6Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=siyz4cwrR0TNFklAS9VBv242SYyBn+9l2X5YI+9B7exlt9QvCXJUcXJ9E7NFqhomRnjWkXxPmguuPh6RerQiRyOG0fuEfKXSNYmmIEakDulcbTzcrRXYsJrxLP6G56BqynNfkjuj2er+Mqz2Eb7gUJygRfPTdZ9Q/RipXXQSJ0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=ypdILxWl; arc=fail smtp.client-ip=40.107.94.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmzNqexo9cvcyGSFCG+R3Wsqpr5EwBC/FMP49rJNLrbqZP010o1WHaMKDTZYUjGAeNE0v1eYTDhCvWb/U8+vrX0T3DAAxFSs5ZeIHMIqYbtxfPZtgV1Lwm4TYiaFC/xW2olI/aEWUyrTTb70UlEuxVkAiSXH/f2/6lwMf68abI+R7Rc8zjhUFLngsLl1aFfftvIF+som/DD0d18jqpzWpWdYLGcCvh17Bj0VnXmdwjyvuX0Di1WSNN9veEANUzRVC8H/VDLplYZODWiPGZQrcNUyYIaLlbHzck9ta6Ss+y+b49ZJ31ufHIE40YEebQAIVs+2BU36QcQ7zWuT4IuEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zErZbMb3jTyXqs57OMGmAAQj4J/j08jQ09xuRyuPM8g=;
 b=PAjeSCUb4Al6M+Kajf1DUAvPkqhVKqBwLjHKMKnqh+pxCSDXmcerO6392tN1hSmS3Vvnoh/2cprONrknr0RDx8+M6mVkU0+RPYxn1CB4ndRVTryelOA5hXUX3HJpxn15IDhAkSxJnUtEE1Qmst8HIRExs3paG9HzwZW7KZ4wDy+cQcbD3ut5GFX2hBUwDPFhLJupyWLWzc46fLdx7CYWOwdCW6Ch0t7twuNTVFOssdXRXD4CpPau/q27OqjeyVrfEAwgyHb0Y10fibprOdMvyAHNp5lu94FzQmrLem7Z/W7jQ8Z2P2pFNzl54osftipdpcEzo0sNjrscfSCeVaWbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zErZbMb3jTyXqs57OMGmAAQj4J/j08jQ09xuRyuPM8g=;
 b=ypdILxWl4DSuOCj8IxeP2ldUvJo40EZB3LgtNqFPc1zyNUoOeIuLNzNr6rmIM8Uy5Qc6iaWLtCHlgbdtHRVVtlPcHQ1Ncc0qM4YYjMIMD1Odp7kQRw9l2XvPLTwXZrxfCfxxPvpsnQMiXgmKMxxyoCG3Ta/oVrMC8Nnn/unLbZg=
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB4582.namprd17.prod.outlook.com (2603:10b6:a03:35b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Fri, 5 Apr
 2024 16:56:24 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b%5]) with mapi id 15.20.7409.049; Fri, 5 Apr 2024
 16:56:23 +0000
Date: Fri, 5 Apr 2024 12:56:14 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: sj@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
	akpm@linux-foundation.org, apopple@nvidia.com,
	baolin.wang@linux.alibaba.com, dave.jiang@intel.com,
	hyeongtak.ji@sk.com, kernel_team@skhynix.com, linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	rakie.kim@sk.com, rostedt@goodmis.org, surenb@google.com,
	yangx.jy@fujitsu.com, ying.huang@intel.com, ziy@nvidia.com,
	42.hyeyoo@gmail.com, art.jeongseob@gmail.com
Subject: Re: [RFC PATCH v3 0/7] DAMON based tiered memory management for CXL
 memory
Message-ID: <ZhAtLhcU3KfT/9i7@memverge.com>
References: <20240405060858.2818-1-honggyu.kim@sk.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405060858.2818-1-honggyu.kim@sk.com>
X-ClientProxiedBy: SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::10) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB4582:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W50tsk1jRsL3CJGg0tCzaelddYpwBSdiQgiN3Cr//a/NVnM8S71mUuhBh7qv+6vipPsqWjp/O1WSL2/wmzB+ks4+2lhkg/Jqe/X6J7ZUtuqq+E8mQRDt6dYZ8WbJ1k5nT9Z6AYoObf+du6XZLXGV+pTNjfNOe+LsBgQu81IhD9vKjEQ7kRZo37gVbiupaBKlUvvc+cGRdCb30h5B+3te1pOVC7o7PUXOzsLomBFfP+gpuc06VxEm9leaIjCtlcdoeP5vqcCbOavnPsD2P3mqXzfUWaS5DSULsaIpCt74QNX6YzqzRxaPcsvq7kqT4Q+IoHpmiFbi21qitUz5pIGPMNEG4tLmJXH0uCCHTaQv/870mrBJ6UhmGCcUDfziSMmSYuro/DCRilSnfzgMd109AkNd9wdxgpRgpg/ZiWXt+7uiU1QGZ+hjHZQqTtNBYi+NJajzCRqs6h1RfiE2fZm0xJ3geiuFdACZJg2nmqwXQjpaEiFTzx532yAYjNcZvN/BW795Zox1whuvRfig670i8YaQepbEJDfC83n7OfVxGypKcoDZbdSCd1kYwlRdgJp57DA+qbFGSm1Lt8/2Mj+1bknb3AySi0/Luu60/sQ8CDuYtl/oNw9A+plbBby1pHeQnrBNjjTXhbzV/njpR2rDH7DYXvFkDJgxNPE7ZunmsAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u3uA89lnbl1XjLpDljLpSx+EFbKrPa8e92AEIJA2eg+zB1ny2L3/gV8Qg9/v?=
 =?us-ascii?Q?wcmqhc2yi8DaWC9fvgDNxd6PkaR35SRxXdRAXuhy7VIUvuHrlQpX8JbtLbQa?=
 =?us-ascii?Q?WHL3K5gPSp3fkLUOXcj9IqqtvqkTJn0kgHWwxkX6DujT1C9/bLdd1alvLOIx?=
 =?us-ascii?Q?r9XUgWAsuCDxRG5O1ouee0zHz4YskyzcAlVRJFnq889ExUr3Nx7/C5Yg0SB6?=
 =?us-ascii?Q?wf84rLaaERa2af+b3FncGL1THgD+WBEUmn4Gx1wJ8SzSnP8/3uxIp+N5J+sV?=
 =?us-ascii?Q?f53Y/elCJNU4OEjg475PCsHZMMyNvVH/FDeHIlExXIruIGvUl61d30/v9y06?=
 =?us-ascii?Q?qcGDZCdnfLgduhHkhYbUD9CXkKaJFAI3QH2Yo77d6o/nrtLewQjlwsGJHFPj?=
 =?us-ascii?Q?czyzQKp62Keyn2kC8VtpSpTr7zRP2UbqgKH2lUcSHIldB/1PuhJUVjKc44I/?=
 =?us-ascii?Q?3nHPLwADQ7neG6Iism7HhhmJWHUnc5ci3myN2muWaPmPhn1ZpR9TR3GRNtRv?=
 =?us-ascii?Q?Rb9KKSqJd3HuzJye/R9tKHaGNGD+/gi+BkEKplMFpofkkB2ie5mmEUBzpFCc?=
 =?us-ascii?Q?K+0amEMcg/LE1ZnRrQA44sV4+MI8Ph9Ym7SKJ3AL+ZKnhVjOSe2woxBxITwo?=
 =?us-ascii?Q?fGLuyt/Z0y8hUPlRYQTQPo4ADWw9WphDEHg5VjbRkVMf5rtNehQnIDk3R6bB?=
 =?us-ascii?Q?ItRHxtdSyPTxZiRXuyu5k2G/m3cQS33+vnBcn54x9deeFP5VEjuG+mNJ9sxb?=
 =?us-ascii?Q?z0klIgIZTW0DEkjyXZO/QkKQLgjnOcvRMsAydG/0giVa+sJt9qgF7/rouNYu?=
 =?us-ascii?Q?ZA6DT3TAlYhZtd+0sNj+BFa6tqI7EXw6PDXiJDOtvaI7vjjd3hSA9Y7rTXjm?=
 =?us-ascii?Q?NC+8V1HedrbItuqTtFBdeXGK6vV5Mp8VKDXIMcGG+ccxNvsod/4WOkofgwMf?=
 =?us-ascii?Q?gBVJVVwpoJxzhVbldlHEtgfV7tFwZmNkeo1hBD3eXA7/NWTpaIbSCaE+zJMu?=
 =?us-ascii?Q?nLgzgQb2faSsniuXNVL5kcG5XDv8P7Yo29/LnL0196JU4GlhcxVV8LK9b6wK?=
 =?us-ascii?Q?3cQyzctryt1GNf7eXEzCyD+CyuI8FsfPF53Bn90yVtxD3AWA/HMSE58Bb7lx?=
 =?us-ascii?Q?Eshtol6LFJhI6CFV2Vxm1up/exZwxomRTsVomC/FUvtS7Gr5MUpH2kVwF56S?=
 =?us-ascii?Q?gGtS3ixv6VMKOgKASgKRFmLRd/PiLBRqH4/TZ575dlK3sAhtE6v8Of4/suet?=
 =?us-ascii?Q?1jGWsvOJiAW38wKkl3+FcWx/l63Y3+NI/cp7xndyjllelCztAEMcOkOknwVP?=
 =?us-ascii?Q?voAYGxwMXHashudX9asKuBZi4M/EMCY2pFWzwwFxi69orUuddx5u3E1PNVSz?=
 =?us-ascii?Q?WpUXJm7fm5pzQ4XbOPVShvxBUO3Cia1KCI90gUBbqfyqDxiE7WHvjFvVtM9i?=
 =?us-ascii?Q?46BNzP98PNJhlaYCQbgVaX7/22knhGPmEji6j53fPFfGjBPEkasMzwxq+Fgy?=
 =?us-ascii?Q?YbB8jFV3AFGjfjZSdHOY9+Yk2Fr7ptxOATJKeuXEtYOuqAb+og/UQSK9dN9+?=
 =?us-ascii?Q?TMHlreZk+aLwsOi75iSPYj41c/zlKgGgqG0Qd1jdUw59ADGBXADNqB5G7/qo?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbea0ab-734c-4fc0-54bc-08dc55915356
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 16:56:23.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeqfEUQg0/fVg0jo0o8bRoViY2vDLz8lEsCxvE92XDGxwp65zmDjTteUyTSaqlRis72353TqzOgym5ra8DFfwh3wIqbsbDKXIkbG+mTsOOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4582

On Fri, Apr 05, 2024 at 03:08:49PM +0900, Honggyu Kim wrote:
> There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> posted at [1].
> 
>   1. YCSB zipfian distribution read only workload
>   memory pressure with cold memory on node0 with 512GB of local DRAM.
>   =============+================================================+=========
>                |       cold memory occupied by mmap and memset  |
>                |   0G  440G  450G  460G  470G  480G  490G  500G |
>   =============+================================================+=========
>   Execution time normalized to DRAM-only values                 | GEOMEAN
>   -------------+------------------------------------------------+---------
>   DRAM-only    | 1.00     -     -     -     -     -     -     - | 1.00
>   CXL-only     | 1.22     -     -     -     -     -     -     - | 1.22
>   default      |    -  1.12  1.13  1.14  1.16  1.19  1.21  1.21 | 1.17 
>   DAMON tiered |    -  1.04  1.03  1.04  1.06  1.05  1.05  1.05 | 1.05 
>   =============+================================================+=========
>   CXL usage of redis-server in GB                               | AVERAGE
>   -------------+------------------------------------------------+---------
>   DRAM-only    |  0.0     -     -     -     -     -     -     - |  0.0
>   CXL-only     | 52.6     -     -     -     -     -     -     - | 52.6
>   default      |    -  20.4  27.0  33.1  39.5  45.6  50.5  50.3 | 38.1
>   DAMON tiered |    -   0.1   0.3   0.8   0.6   0.7   1.3   0.9 |  0.7
>   =============+================================================+=========
> 
> Each test result is based on the exeuction environment as follows.
> 
>   DRAM-only   : redis-server uses only local DRAM memory.
>   CXL-only    : redis-server uses only CXL memory.
>   default     : default memory policy(MPOL_DEFAULT).
>                 numa balancing disabled.
>   DAMON tiered: DAMON enabled with DAMOS_MIGRATE_COLD for DRAM nodes and
>                 DAMOS_MIGRATE_HOT for CXL nodes.
> 
> The above result shows the "default" execution time goes up as the size
> of cold memory is increased from 440G to 500G because the more cold
> memory used, the more CXL memory is used for the target redis workload
> and this makes the execution time increase.
> 
> However, "DAMON tiered" result shows less slowdown because the
> DAMOS_MIGRATE_COLD action at DRAM node proactively demotes pre-allocated
> cold memory to CXL node and this free space at DRAM increases more
> chance to allocate hot or warm pages of redis-server to fast DRAM node.
> Moreover, DAMOS_MIGRATE_HOT action at CXL node also promotes hot pages
> of redis-server to DRAM node actively.
> 
> As a result, it makes more memory of redis-server stay in DRAM node
> compared to "default" memory policy and this makes the performance
> improvement.
> 
> The following result of latest distribution workload shows similar data.
> 
>   2. YCSB latest distribution read only workload
>   memory pressure with cold memory on node0 with 512GB of local DRAM.
>   =============+================================================+=========
>                |       cold memory occupied by mmap and memset  |
>                |   0G  440G  450G  460G  470G  480G  490G  500G |
>   =============+================================================+=========
>   Execution time normalized to DRAM-only values                 | GEOMEAN
>   -------------+------------------------------------------------+---------
>   DRAM-only    | 1.00     -     -     -     -     -     -     - | 1.00
>   CXL-only     | 1.18     -     -     -     -     -     -     - | 1.18
>   default      |    -  1.18  1.19  1.18  1.18  1.17  1.19  1.18 | 1.18 
>   DAMON tiered |    -  1.04  1.04  1.04  1.05  1.04  1.05  1.05 | 1.04 
>   =============+================================================+=========
>   CXL usage of redis-server in GB                               | AVERAGE
>   -------------+------------------------------------------------+---------
>   DRAM-only    |  0.0     -     -     -     -     -     -     - |  0.0
>   CXL-only     | 52.6     -     -     -     -     -     -     - | 52.6
>   default      |    -  20.5  27.1  33.2  39.5  45.5  50.4  50.5 | 38.1
>   DAMON tiered |    -   0.2   0.4   0.7   1.6   1.2   1.1   3.4 |  1.2
>   =============+================================================+=========
> 
> In summary of both results, our evaluation shows that "DAMON tiered"
> memory management reduces the performance slowdown compared to the
> "default" memory policy from 17~18% to 4~5% when the system runs with
> high memory pressure on its fast tier DRAM nodes.
> 
> Having these DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD actions can make
> tiered memory systems run more efficiently under high memory pressures.
> 

Hi,

It's hard to determine from your results whether the performance
mitigation is being caused primarily by MIGRATE_COLD freeing up space
for new allocations, or from some combination of HOT/COLD actions
occurring during execution but after the database has already been
warmed up.

Do you have test results which enable only DAMOS_MIGRATE_COLD actions
but not DAMOS_MIGRATE_HOT actions? (and vice versa)

The question I have is exactly how often is MIGRATE_HOT actually being
utilized, and how much data is being moved. Testing MIGRATE_COLD only
would at least give a rough approximation of that.


Additionally, do you have any data on workloads that exceed the capacity
of the DRAM tier?  Here you say you have 512GB of local DRAM, but only
test a workload that caps out at 500G.  Have you run a test of, say,
550GB to see the effect of DAMON HOT/COLD migration actions when DRAM
capacity is exceeded?

Can you also provide the DRAM-only results for each test?  Presumably,
as workload size increases from 440G to 500G, the system probably starts
using some amount of swap/zswap/whatever.  It would be good to know how
this system compares to swap small amounts of overflow.

~Gregory

