Return-Path: <linux-kernel+bounces-64726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2896B8541FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05C61F29F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D87CBE48;
	Wed, 14 Feb 2024 04:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSP9gD2e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F923BB;
	Wed, 14 Feb 2024 04:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707884032; cv=fail; b=Q/6frHHbTXwZuSfcKriBzfUBmdWux+U+fF9O9nq4zdZh6rUtpcCdcMbjdQHAnYaAG2vx5vkLQHfxNECns7/D/16FaoM3O0CY75huFzIwF1fLN5zOmElc2o8lJG9ICTaZJs7uc6qwHnTWpBV5Y40uaa2ECDDuy2i6UGtlgiew1vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707884032; c=relaxed/simple;
	bh=tO8jGC9k8hbg6lzrZhxm+wFHU2FfD987GK0PjigPiAs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A4cQQM/GVdylP4pkZOGHeljrQc1nRm3XVFRqNoBgrhqFKD4gCTcxETb3nhOnfCGEfbtxfbYhk4q9Lk+EMBFU//upyiNSwhVaL0nkQKTu9o8A5DISSg4XHNfdkZtTdoA13ixS9kXatV5seMZDFU3hxPU1g6gOG0l8LrXQwG29dhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSP9gD2e; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707884030; x=1739420030;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=tO8jGC9k8hbg6lzrZhxm+wFHU2FfD987GK0PjigPiAs=;
  b=iSP9gD2eMDZrEBNzsTlO5RA13dxEpvQaG6eUNQm25yaXeWGd4EmGTYP2
   nyfdUM+EJXEfK8ZjEID/i+tWl8jWuZ+uS3cls6BLKlkbYeZsbjxPsvE54
   EAisKcPUOkpvEXwpql36210OtSkReeKLY49FcEDQ7juX7v8gDBHuNoeOp
   9+tkd5d5alzCP/UBW0DKEyp4GRQympVlUx2xXPokr/3vT930KBVx7v+Yz
   Ap9FJ86ebvWfnvTBuuCjgk40eK5YVlde3wAOfjL98zY0H7Uljhx57M2/w
   t5YiP2ZygW/x55CpvWqPPZB7EcWcml6Sz+ovZhZD3Yg+lZVZA6jW65kgF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="2041735"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="2041735"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 20:13:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935547523"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="935547523"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 20:13:49 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 20:13:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 20:13:48 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 20:13:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkPAwSEcSyH0M6CKAw6QF6OT+Br09bp9K7joSc7wYdWAAMqSSDjdDEk+BoHfP7v8bkKz1gUb/NleKlxwpdSZhxuNPDJGupbZDEVG2tuCGGqHjMw6hrAoFt4L/wWLs/lhgkWrDuo2lYMwlOy6a0BZyIhNHPMDXQvwfUHpLIDeVF7wDyxVqtlmBxdgMTmWFBHIvjUKUgqHfeIc8mR9Eiwr376NkSR4rCghikZ4tL55NyGW0ql1tzwUOZrXhk2w4gEkkPW0bvhmwTF87Nclbu8M25RsWCe1SVMrvOhC0OQh+VCwpbV1Jar1opv3bMpqJLfmbNboV84bNrymuFpiZUKUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGta3JkHiyn/+uZkxrTd97b6VAmu1Qb2xfXPsmNQ7hg=;
 b=YCig2vujP/tLxpstfY4vZ26e1Xkn8LHFnHm7g6cQSO0GDfwpgZDv53qI939ZMvucolRVYUXG/1aUBsbOUHaBNN4MFpxRlmu8YYMmsX9FvL84v9dYaRdDoJGCmYwhwyYzSNYgoM0GF9qUShZCCifNpygnh/1NJgYtdL6XkaueV/jQVDA5QE0ucUr6Saw5S8cjNWbtKQD048y4y2UQ8q5HrKZMiGRltiGqZSu6Vz9uojItzCP3B153oLQ6W1YVRUvjlqo6eJNCdIy5fXRkXf/YAQ/X6ZyqIT2HIIt154J/nL6TX7iv3vh0Bzvo+uLahfU94huFoeeOAk8MncQ/nmtJhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4935.namprd11.prod.outlook.com (2603:10b6:510:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Wed, 14 Feb
 2024 04:13:46 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 04:13:46 +0000
Date: Wed, 14 Feb 2024 12:13:38 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Beau Belgrave <beaub@linux.microsoft.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/4] tracing/user_events: Prepare find/delete for same
 name events
Message-ID: <202402141240.cc5aba78-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240202184449.1674-2-beaub@linux.microsoft.com>
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4935:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec39d61-c679-4e2c-89b5-08dc2d1356d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+epiC8YqCFBBj7GXesx6g0G+T4/7HqImYqJh5ZRrsEDsXuMaLucD3Y1wgKHNu1NS3Wzq59Q4FLZbvJol9OAOILRWUE4nq2oxhbAIpjRjYXHiI4C8aj07UmO5Sb6STXl3X14wkw6RgyMnooXVAn0k41wtJkqOvsVJrnIJ40zSKD08tst8TU0qUIgSJoA7UUBDmfA/68NGNMbOu+Gf0oHji9D3/4C3Xx24iMFVefwEpdcYbgoWc3X+DXsjZL1AM9ruaeb786cPfNLS+U1rtPx7WqKs42k+sSkf4lH8ANIre07wd5df+Mw/2Ny3Z7nvWDs9ulEBsqkBktLdD7xg9GwcisEaC9kbCfAXTm4RHZs/5zGzFV+pr8UzMgsHx2J0spCG1V6LFl3vBKnSFqnzNbBXK+mDJX7A4pfl7oy7fzDd/ZKpY/1LoDVvWD8WU0mkS7Dnwiic4M5pEiD3MiHeKApYUWdm9wbyONz1cXPibB1kjGRZNPODx2aIKmF7GsUZiblQzn1DGx73Pi7BRR7JHYBbXSpKnWB9qxJICk01Vp9vJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(346002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(478600001)(6512007)(966005)(41300700001)(6486002)(4326008)(8676002)(8936002)(2906002)(5660300002)(86362001)(6506007)(6666004)(66556008)(66476007)(66946007)(316002)(83380400001)(6916009)(2616005)(82960400001)(107886003)(26005)(36756003)(1076003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?56pnuQmMh7oV4e1WC9cIhTYDy4zl8MUnJvHV9EROaCJ1Mj63RPoarVqN18Rs?=
 =?us-ascii?Q?eUF8zGSwN33ZQeNSjuW/UR4Q9ipKhLKX5xm8F3CWYSD6VGi2SNclM2bzYn+R?=
 =?us-ascii?Q?vfGH2UvfEJwR7iTvFpzzQPuqBYx+VIgTB8HuR5XEWq+9w9MpAfX6O8Ih9lc4?=
 =?us-ascii?Q?Q9lK6qNQMHEjd+bLFRGEjsuwExBaHTSVjPDRF527YMu7DGNJDMCj5hfygSVs?=
 =?us-ascii?Q?aWKZV7geCv/TMw5n1IckWfxtJZekRZq+e/V+ROPMtEMVd0oQodbab/bAqvCa?=
 =?us-ascii?Q?mrz1pea4/LxMlOVWKUyNetluEItnF4wNYeQ24ox1kCbgyUSXvacV7tJ+NUbW?=
 =?us-ascii?Q?tDN2RNMEEBdfOojEC3FOQVbQp/x76MdPogF5YiSEoJicQYk/CAb7gFMK4kXs?=
 =?us-ascii?Q?87p3Jty/25o+LLVkU8RWunSBuH8vACtMtpXnrK6vH9BloOJkClOLtwhj14us?=
 =?us-ascii?Q?sAwgB5v5k8cBqThQKhUp8ndIQJsWDHUmckHRVrpw4ouFKvJN/5ZR0tgAJsgS?=
 =?us-ascii?Q?xPSiVw9tmaOT1hzIQru+BiC+DipZhzyny8DDwLYpFeM4caU9K5CW6U+S3BgT?=
 =?us-ascii?Q?B3vdMY6mkeOpUREwQRtxcvyxhTC9uGAoBt87KaIDJXjwb8qz+56dwUJP+7M/?=
 =?us-ascii?Q?vFD6Y83JXQMOe+7IOc9h+Taf8vvgPHlnsSRckWXSqXlu4FTvDsR9l6WcXvVU?=
 =?us-ascii?Q?QtkETCWAALVwiiM8rfPZyPN5TFTXQw8J7lx5cKO4sbqNm4V0zGswrHGGpC86?=
 =?us-ascii?Q?V+8qFdyFrIkAuRmb4y1//gZD/8YDgSf+DKYCafEWs2wGULCTnlFPFSJRMFNQ?=
 =?us-ascii?Q?E5jHJgKg7q19ZxzrXY22HbHLXpi+wXCQuJbR5BiRHYpd/YVm/6uGGCvGdc0f?=
 =?us-ascii?Q?oaeSp6drfY97aUkEVr539D4mJzcn8965fc6bPIsbIE2PtHsMmwkbh/sgrgtz?=
 =?us-ascii?Q?fXO220a921mAPyD4kODsBA+mvpuYe2IJD1h6G8T82OrfbfLghONM2B/L2Ncr?=
 =?us-ascii?Q?zo6vdFbHiqsyVwxdUjJ71kek7U805e2QiCoUjLiv8WVGGK7NT4O9Fbgi55ya?=
 =?us-ascii?Q?qdBh8hEKjDojU6N62oTc+hAHgqNMictik7CjDXDI4z8TWaDIw6m2LN6+Jjtf?=
 =?us-ascii?Q?Kv4QrIThnhtjtsARVFeTOGNl0DWY1QbuystlKTuFH3Evb6yb5MTJLb+pVY0V?=
 =?us-ascii?Q?EV+CatxUht9T7Zo9HncHcVwPHG/kIt/a/0mcb7o8Ei6QashEKBT1Seqsds53?=
 =?us-ascii?Q?00sEuOsfbFQVY02rHPJI7jgtcjBhpNdV3hevkjVN8eC1UFIZNBizYVXxi0qH?=
 =?us-ascii?Q?GZ4SLYb9M1g+K4iTgrX4+k+cOU252HWwCi0FBgH1o+cHFJvgv1C5Vp3PJgT3?=
 =?us-ascii?Q?dH4+60TuhdsZAdQ/nQjDdlN1DXaeraAH0sRIvm//RHOf9GR5HfV0O97i++Da?=
 =?us-ascii?Q?NmwpEai71US4aq1zdo3PVoRXqwcNoQSIeCMLlLBDf4G0x6BydqSI2rJzGhjl?=
 =?us-ascii?Q?ElgY6vpsQ4rsEkl/WOR4xGyssS32OzJ4U6AmI28kgH+sl9zU1nJjzBUCAC1u?=
 =?us-ascii?Q?9BWJ8eWZTG6WRY+JXlIu1JJvS0MN2lnjFNOLNm9S+jzRdnePTLmu+WRZIHSA?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec39d61-c679-4e2c-89b5-08dc2d1356d8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 04:13:46.5928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjXZEe9Z27Wm6Xrl4zz94+Bed913sRMNWGvZNpkrUuDhhX+b/p3kuqx9vVBI1TjQWz8xzJfG0/PqVvrurnoeHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4935
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-use-after-free_in_user_events_ioctl" on:

commit: fecc001d587ceeeb47043c20353f257e3f01b39f ("[PATCH v2 1/4] tracing/user_events: Prepare find/delete for same name events")
url: https://github.com/intel-lab-lkp/linux/commits/Beau-Belgrave/tracing-user_events-Prepare-find-delete-for-same-name-events/20240203-031207
patch link: https://lore.kernel.org/all/20240202184449.1674-2-beaub@linux.microsoft.com/
patch subject: [PATCH v2 1/4] tracing/user_events: Prepare find/delete for same name events

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: user_events



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402141240.cc5aba78-oliver.sang@intel.com


[ 106.969333][ T2278] BUG: KASAN: slab-use-after-free in user_events_ioctl (kernel/trace/trace_events_user.c:2067 kernel/trace/trace_events_user.c:2401 kernel/trace/trace_events_user.c:2543) 
[  106.970079][ T2278] Read of size 8 at addr ffff88816644ef38 by task abi_test/2278
[  106.970788][ T2278]
[  106.971058][ T2278] CPU: 2 PID: 2278 Comm: abi_test Not tainted 6.7.0-rc8-00001-gfecc001d587c #1
[  106.971881][ T2278] Hardware name: Gigabyte Technology Co., Ltd. X299 UD4 Pro/X299 UD4 Pro-CF, BIOS F8a 04/27/2021
[  106.972829][ T2278] Call Trace:
[  106.973185][ T2278]  <TASK>
[ 106.973514][ T2278] dump_stack_lvl (lib/dump_stack.c:108) 
[ 106.973966][ T2278] print_address_description+0x2c/0x3a0 
[ 106.974597][ T2278] ? user_events_ioctl (kernel/trace/trace_events_user.c:2067 kernel/trace/trace_events_user.c:2401 kernel/trace/trace_events_user.c:2543) 
[ 106.975099][ T2278] print_report (mm/kasan/report.c:476) 
[ 106.975542][ T2278] ? kasan_addr_to_slab (mm/kasan/common.c:35) 
[ 106.976025][ T2278] ? user_events_ioctl (kernel/trace/trace_events_user.c:2067 kernel/trace/trace_events_user.c:2401 kernel/trace/trace_events_user.c:2543) 
[ 106.976531][ T2278] kasan_report (mm/kasan/report.c:590) 
[ 106.976978][ T2278] ? user_events_ioctl (kernel/trace/trace_events_user.c:2067 kernel/trace/trace_events_user.c:2401 kernel/trace/trace_events_user.c:2543) 
[ 106.977481][ T2278] user_events_ioctl (kernel/trace/trace_events_user.c:2067 kernel/trace/trace_events_user.c:2401 kernel/trace/trace_events_user.c:2543) 
[ 106.977970][ T2278] __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:871 fs/ioctl.c:857 fs/ioctl.c:857) 
[ 106.978441][ T2278] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 106.978889][ T2278] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  106.979462][ T2278] RIP: 0033:0x7f2e121c8b5b
[ 106.979907][ T2278] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
All code
========
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	44 24 18             	rex.R and $0x18,%al
   6:	31 c0                	xor    %eax,%eax
   8:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
   d:	c7 04 24 10 00 00 00 	movl   $0x10,(%rsp)
  14:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  19:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
  1e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  23:	b8 10 00 00 00       	mov    $0x10,%eax
  28:	0f 05                	syscall
  2a:*	89 c2                	mov    %eax,%edx		<-- trapping instruction
  2c:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
  31:	77 1c                	ja     0x4f
  33:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  38:	64                   	fs
  39:	48                   	rex.W
  3a:	2b                   	.byte 0x2b
  3b:	04 25                	add    $0x25,%al
  3d:	28 00                	sub    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	89 c2                	mov    %eax,%edx
   2:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
   7:	77 1c                	ja     0x25
   9:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   e:	64                   	fs
   f:	48                   	rex.W
  10:	2b                   	.byte 0x2b
  11:	04 25                	add    $0x25,%al
  13:	28 00                	sub    %al,(%rax)
	...
[  106.981608][ T2278] RSP: 002b:00007ffcb0ba5ed0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  106.982385][ T2278] RAX: ffffffffffffffda RBX: 00007ffcb0ba6228 RCX: 00007f2e121c8b5b
[  106.983128][ T2278] RDX: 0000564d434bc6fe RSI: 0000000040082a01 RDI: 0000000000000005
[  106.983878][ T2278] RBP: 00007ffcb0ba5f40 R08: 0000000000000000 R09: 00007f2e120c9b80
[  106.984626][ T2278] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  106.986296][ T2278] R13: 00007ffcb0ba6238 R14: 0000564d434bedc8 R15: 00007f2e123cc020
[  106.987040][ T2278]  </TASK>
[  106.987364][ T2278]
[  106.987635][ T2278] Allocated by task 2278:
[ 106.988071][ T2278] kasan_save_stack (mm/kasan/common.c:46) 
[ 106.988543][ T2278] kasan_set_track (mm/kasan/common.c:52) 
[ 106.988999][ T2278] __kasan_kmalloc (mm/kasan/common.c:374 mm/kasan/common.c:383) 
[ 106.989465][ T2278] user_event_parse (include/linux/slab.h:600 include/linux/slab.h:721 kernel/trace/trace_events_user.c:1978) 
[ 106.989939][ T2278] user_events_ioctl_reg (kernel/trace/trace_events_user.c:2342) 
[ 106.990462][ T2278] user_events_ioctl (kernel/trace/trace_events_user.c:2538) 
[ 106.990954][ T2278] __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:871 fs/ioctl.c:857 fs/ioctl.c:857) 
[ 106.991428][ T2278] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 106.991871][ T2278] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  106.992436][ T2278]
[  106.992705][ T2278] Freed by task 2278:
[ 106.993112][ T2278] kasan_save_stack (mm/kasan/common.c:46) 
[ 106.993582][ T2278] kasan_set_track (mm/kasan/common.c:52) 
[ 106.994043][ T2278] kasan_save_free_info (mm/kasan/generic.c:524) 
[ 106.994544][ T2278] __kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan/common.c:244) 
[ 106.995028][ T2278] slab_free_freelist_hook (mm/slub.c:1826) 
[ 106.995553][ T2278] __kmem_cache_free (mm/slub.c:3809 mm/slub.c:3822) 
[ 106.996026][ T2278] destroy_user_event (kernel/trace/trace_events_user.c:1489 kernel/trace/trace_events_user.c:1467) 
[ 106.996513][ T2278] user_events_ioctl (kernel/trace/trace_events_user.c:2077 kernel/trace/trace_events_user.c:2401 kernel/trace/trace_events_user.c:2543) 
[ 106.997009][ T2278] __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:871 fs/ioctl.c:857 fs/ioctl.c:857) 
[ 106.997483][ T2278] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 106.997926][ T2278] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  106.998496][ T2278]
[  106.998768][ T2278] The buggy address belongs to the object at ffff88816644ee00
[  106.998768][ T2278]  which belongs to the cache kmalloc-cg-512 of size 512
[  107.000035][ T2278] The buggy address is located 312 bytes inside of
[  107.000035][ T2278]  freed 512-byte region [ffff88816644ee00, ffff88816644f000)
[  107.001266][ T2278]
[  107.001532][ T2278] The buggy address belongs to the physical page:
[  107.002142][ T2278] page:ffffea0005991200 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88816644b800 pfn:0x166448
[  107.003179][ T2278] head:ffffea0005991200 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  107.003996][ T2278] memcg:ffff888160dfc4e9
[  107.004425][ T2278] flags: 0x17ffffc0000840(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
[  107.005189][ T2278] page_type: 0xffffffff()
[  107.005635][ T2278] raw: 0017ffffc0000840 ffff888100051700 ffffea0004050810 ffff888100043dc8
[  107.006434][ T2278] raw: ffff88816644b800 0000000000150008 00000001ffffffff ffff888160dfc4e9
[  107.007223][ T2278] page dumped because: kasan: bad access detected
[  107.007841][ T2278]
[  107.008111][ T2278] Memory state around the buggy address:
[  107.008660][ T2278]  ffff88816644ee00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  107.009416][ T2278]  ffff88816644ee80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  107.010161][ T2278] >ffff88816644ef00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  107.010907][ T2278]                                         ^
[  107.011471][ T2278]  ffff88816644ef80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  107.012215][ T2278]  ffff88816644f000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  107.012967][ T2278] ==================================================================
[  107.013787][ T2278] Disabling lock debugging due to kernel taint



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240214/202402141240.cc5aba78-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


