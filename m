Return-Path: <linux-kernel+bounces-52770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDDE849C7B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECED21F24C6B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52C928DD0;
	Mon,  5 Feb 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRzLGafp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F782D608;
	Mon,  5 Feb 2024 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141585; cv=fail; b=n5jxb6fQmGAr/x8UI2GgDFzkLyzO7tRExAlAUmFvP+fHrNVq3bVikkPse+ASxWppBh0lHeNk5zp03hJI9mgUY40jyBYo0t6mQwXg6M8/bH8qT4KoxsWDXxVz318kWnvG7xP/Nja5X4X8Z6ATlRWXP6C2mGwaKDeg3RYx1xL/1fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141585; c=relaxed/simple;
	bh=ew7hqhvE11UIdjrcI0ncAOs/p25sQilXkGBI71sTuoU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ukyi+ADd9R2kBm53z94bqWyuj6tCXdSsOStFfQOMLdHQ6AkiD+CQSlJcHW2AOwFvto7GzlUWgWbe/FJ0bi7W/dVQ3hkL14XNbcHKHTdC9nrbkvt+GXpRQ0Y/qv3T7Lkhvb8TGAItq8UTdfIT9pkGEQ2csoVuQhW61zyX8SfzB4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRzLGafp; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707141584; x=1738677584;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=ew7hqhvE11UIdjrcI0ncAOs/p25sQilXkGBI71sTuoU=;
  b=PRzLGafpCCt/ZTnweD4PVdgihml6G5qruyGWUBVOH0faG7qSA7Et0lTr
   xc7VpzBg0hXx7UzxufAf92dDzNrbl+t0Cf6RbAM+bas1fkpBJrMClKWgn
   vh87Ela6xFhr/nrvOCunauytYZgprHg7RxpPztN5P9TbIjDMR2YIrr/91
   l9NcxSj5EJFNM//1HNAiUYtOmy9INGPMCNOHopMhzoyGATt5wVPG/GYJX
   duD1kJrx6TMPUuj8Pq8Z7LVrzQeiqImC7FLGnBMoovRwCNol+lFlgoM8l
   c8lNNCZVAD6TYsJIH9i0YO3VUtXGdlHwMTdI4M3RkyqXr2kQq3RhWp3db
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="3484976"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="3484976"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:59:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5338402"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 05:59:42 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 05:59:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 05:59:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 05:59:41 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 05:59:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7N1ViniOK4YVtWlgunN2ZajeTMb5kGXjoSLy89DmPO5asQJNWAyD/4Sq3z9sEryOFq/Wom0uhzBIFT79jKyFiKoAD40LsK40paqEJuwCRpu0Y6EY1dnsAIoI1vpacCPr9miXc62K8OXtJa3q3g7EmDJJMVWYkBrRNtr82N4+3CZzW2xYYbQm1kGc9e2wcL9DPI+OEqvEhMpnNUBbHgCZjf6cx4/XCz3m2zLnwhRYfBgHr42DEXBcYRIkpx9f4CSHwkkjrnoxTH3IOjIgy0F8mYt0TBkD2jWRaFU4Ld88WieymyQ4NmEg5VY1+q5KVOSA/MA60NNm2kefNVBoJSc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU9Cj/tOQ4vJatuDyJtHegOPmEFvJgrP43ybLPQWf0g=;
 b=IgINLBhsLpZNUS7k1abbiMjO8T0hpI5CuNjKGoKnthG6Qq8As7F5l+4/EkdpOEirfuJYMM5F/mNSj6evZ9rmy7yTHB2/IuEaJrrXlJrFbtrVHvIceEHmbK6ow38s/qSst0bwAhvSmgKygRxlYaqA+RTYLquIJ9J/6+n+otSimc5rHMS0G+z539mlNMdpegRFQiAD3KDEOtxLNXVbY/QgQL/WXkc6dGlocLl/2RhIof4v6XsTc+s9MFpNO6luLOU//rvBgyLPp9orUn6iyj/SePACYu46LAoBApc3ojQIZplQ5jWuDAnq3g2rocHa4h+foyhsTk6i6+RGyAbiDhzQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7313.namprd11.prod.outlook.com (2603:10b6:930:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 13:59:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 13:59:37 +0000
Date: Mon, 5 Feb 2024 21:59:28 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Steven Rostedt
	<rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Ricardo B. Marliere"
	<ricardo@marliere.net>, <oliver.sang@intel.com>
Subject: Re: [PATCH v3 3/3] tracing: convert __trace_seq_init to use
 WARN_ON_ONCE
Message-ID: <202402052141.769871e2-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240125222818.7425-4-ricardo@marliere.net>
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc03e15-fde4-4170-9d13-08dc2652b097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFbB8Z5/VladgoZUpb53fDq4UnA3paiJ+bRVLsUyv3dmebEZSMeueafLNo+DabigyXxLmQyGIN1I7NAmCLJMuummE9lrmIWgsZxNKyD6S9WKbjh+MGjEOB2QOdxmJ4EQ/6jXgMX7zwSH3Vi5QDJFNBgRB+jZUbESAYRJ3hqYL2X5L4ywf5tUyqSMle5n+khdbDJmZqiV8+QVVOwptP8p8EeFBxc8onVIgNk9a9WKZrNdOvtcQli6vfN+Rr4Fuixg+80DiskXXyC6N59TCj6Y9mIymvACiKbL/9awdHYILOoUFjJxhNuXPdC9DH0xd6yVBCXyfcTbkkvEBcfUAXBvSgIHJtiPlPQGrU9+WOMfQ+QBrrAc5BiSaeD0Hkd17v2Bhb413NbaV3fBH6D6IxWXpdrMUuRAz3cMxC15z/QQEV4/lDhGaHPV+SicXUz9MP1qZm4kgLds3ky9iDBtcN6xPMehPsRDeBVoTDxXee7PZ4P8KTbp2GPAbSanqU8u8gHe8MtcKjw54qmdB1O5L3EuXe80LpdD5kRaXE3kzwaoTQnKcmjZT6WRU2bUN0tUYoqyOatlflTaZQq8WfeOpuz4Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(82960400001)(6506007)(6666004)(316002)(83380400001)(26005)(86362001)(41300700001)(2616005)(1076003)(107886003)(4326008)(8676002)(8936002)(6512007)(36756003)(45080400002)(2906002)(478600001)(6486002)(966005)(5660300002)(66946007)(66556008)(66476007)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L0pe68ImTX9iib2kJTNp9CwOqrnvEwZXpFrK9CYnjmrVUx/MuGs6qrNXOTyk?=
 =?us-ascii?Q?Nf/l++oBXdsWhApeHQIl0r+vAW0VQOrrFymd+iNgW+1rpruWeX9dV+Ltu8kP?=
 =?us-ascii?Q?9/cxUVLE8J1BpHUjeKcy6F+GCRA0kZ+sfe1zSY6tuLAOa/cyffKXiJNmgfnp?=
 =?us-ascii?Q?ljfWKpioe+dzHa24C5OsJqXqbHaYZG5tnxT/Fz9880VQ7H9sdDKIYWrGd2XV?=
 =?us-ascii?Q?Y57a8NvplrW4/EbcJ3HliahH0C4dS60tKRNd+wJo5i25MtPMWqHTQBT+XMXS?=
 =?us-ascii?Q?WxHs8BwQ2yvbjxk7H0Chm+wCKiNxfXTf96c5IvZeQKHzJn74dOPcqVvv30F3?=
 =?us-ascii?Q?pmBq2C2rYUWiduF0wdha5cIfu8qAAS8fCyeP0N3L3Psg7hKPRUSF3HMwZ5ua?=
 =?us-ascii?Q?PIvmb8RDXw44f42DLdzBhrAinFxsesXqGYX42VATUO7yJHI4+kLtLccy1eD3?=
 =?us-ascii?Q?lV1G+wg9zF8xCXWaVzs6dgH3vAo1RUIg1IbhoRLm83lzx91faIv7b5YZQrXd?=
 =?us-ascii?Q?Qq7cFQZ/9Fgh1ULhGkJQCSMyVtWKtmlJtnOLYaiIv2TYuGi7IFm2oNJnYllG?=
 =?us-ascii?Q?N+CmcYvBZbYBgxKHXl1I+Y0GRgxR7h7xP9T1YqPYp26laswT/md4x+p5Dld+?=
 =?us-ascii?Q?NsfWe+pfzAlD9Rt83RmpE382IT0pUDOcGJSiAuvDJMzGmLAZu6sZa/FXwmEI?=
 =?us-ascii?Q?exlyXaQ+LBldZt9oSN2n2F55CpK20fwO6CKFHYOcPFw4TIJrCptu0wg6fRV/?=
 =?us-ascii?Q?yJw9QSTb9NqlvCoxKiXgESFh1aUsq7tgsEgaEeI25KTjFQOT168ffwmGKGlz?=
 =?us-ascii?Q?I/GdUsThx8TpDJbj00BUs+Am4M0FC0Aiu/8wDliIx/apEpbaFe4YWTlWHoMY?=
 =?us-ascii?Q?6cpT/2RH3fOBGQo08G0OQrDrA5zOdjIn+m2zeEbMLyt5Ab9DucZGnUtZRYl2?=
 =?us-ascii?Q?z+RgwMH3pbY+CzkuYXM8iN8JSZHkgM1+zaZ8UVbcBxwD2ThUW8YVK0lxsWxM?=
 =?us-ascii?Q?KGFEzmpLDIBSsSBbXr9q6YMvUbjaZ8uDrzsfpRno+SHdaCLFTtN12UkFOwGT?=
 =?us-ascii?Q?1v6Fvh6zuvuCo0opJ5VhNSooMEho7irsmeMO+vcDHykeoCSdWRChlLtIpyV4?=
 =?us-ascii?Q?9X6PoK5769aURxdTJYi56MGVI0eGgAQ04PnXWQyajK3ewSeVZkCB2fu2f4tM?=
 =?us-ascii?Q?m9vcZ1eVW0TMJS7L4SqmZTTB2ECS+Z0ShpGSGsBoNeKcuASemVLWJlZ2nEvV?=
 =?us-ascii?Q?jiysTkSxHrD6b7+c0QL8a5D5KhFBvecXw1+n3/f8OvsrzEr5iZA2/RI59e2d?=
 =?us-ascii?Q?H2ff5qmcOKRMdz2ynUe5NBm4Nh+/3EWASKBthw1HJkBCRa5RwPN/fupNpL7i?=
 =?us-ascii?Q?WawBl9bZ1TFX53ybW+U2Ed6lsEHl0uS8jnXjP80+b0jwLiFO53P4CMF7Sa4M?=
 =?us-ascii?Q?3YgcNoBQulp0JhY9v1bVsug57Bzba0RdIV6kxmAQyNLSCS7X6T37ODZ9ruIE?=
 =?us-ascii?Q?QKsTwa5aZX1zhOKIwoEx+8YVJKRHCq2LkvT9CGguPl1rJPc3QRYp5BO4Gpoa?=
 =?us-ascii?Q?/Gqe9wvMM7s350HPmDJ5lbCtTc0DoZrXlHymdwQThzovR7IO+Ups9liQyokY?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc03e15-fde4-4170-9d13-08dc2652b097
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 13:59:37.5237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKLKLPgCkjF84EFhpaPSATF40Qv5NdycJgZVbND3oBUstyx5v9fla3hETPUitJfpHEFWrc/HsvAJWZfhUXIxrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7313
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/trace/trace_seq.c:#trace_seq_printf" on:

commit: 233bcd2427b36992e8918a67a88912f9c3d497af ("[PATCH v3 3/3] tracing: convert __trace_seq_init to use WARN_ON_ONCE")
url: https://github.com/intel-lab-lkp/linux/commits/Ricardo-B-Marliere/tracing-initialize-trace_seq-buffers/20240126-063125
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
patch link: https://lore.kernel.org/all/20240125222818.7425-4-ricardo@marliere.net/
patch subject: [PATCH v3 3/3] tracing: convert __trace_seq_init to use WARN_ON_ONCE

in testcase: boot

compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed the WARN_ON_ONCE added in this commit was hit in our tests. but
not always happen, just FYI.

27b32d2097dcb40a 233bcd2427b36992e8918a67a88
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :10          50%           5:11    dmesg.RIP:trace_seq_printf
           :10          50%           5:11    dmesg.WARNING:at_kernel/trace/trace_seq.c:#trace_seq_printf



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402052141.769871e2-lkp@intel.com


[ 1915.506477][   T42] ------------[ cut here ]------------
[ 1915.506778][ T42] WARNING: CPU: 0 PID: 42 at kernel/trace/trace_seq.c:35 trace_seq_printf (kernel/trace/trace_seq.c:35) 
[ 1915.507296][   T42] Modules linked in: ipv6
[ 1915.507538][   T42] CPU: 0 PID: 42 Comm: rcu_scale_write Tainted: G                TN 6.8.0-rc1-00172-g233bcd2427b3 #1
[ 1915.508125][   T42] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1915.508690][ T42] RIP: 0010:trace_seq_printf (kernel/trace/trace_seq.c:35) 
[ 1915.508999][ T42] Code: 00 00 48 3b 83 e8 1f 00 00 77 51 48 8d 65 f0 5b 41 5e 5d 31 c0 31 c9 31 ff 31 d2 45 31 c0 45 31 c9 c3 cc 48 8d 83 f0 1f 00 00 <0f> 0b 48 89 9b e0 1f 00 00 48 c7 83 e8 1f 00 00 dc 1f 00 00 c6 03
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	48 3b 83 e8 1f 00 00 	cmp    0x1fe8(%rbx),%rax
   9:	77 51                	ja     0x5c
   b:	48 8d 65 f0          	lea    -0x10(%rbp),%rsp
   f:	5b                   	pop    %rbx
  10:	41 5e                	pop    %r14
  12:	5d                   	pop    %rbp
  13:	31 c0                	xor    %eax,%eax
  15:	31 c9                	xor    %ecx,%ecx
  17:	31 ff                	xor    %edi,%edi
  19:	31 d2                	xor    %edx,%edx
  1b:	45 31 c0             	xor    %r8d,%r8d
  1e:	45 31 c9             	xor    %r9d,%r9d
  21:	c3                   	ret
  22:	cc                   	int3
  23:	48 8d 83 f0 1f 00 00 	lea    0x1ff0(%rbx),%rax
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 89 9b e0 1f 00 00 	mov    %rbx,0x1fe0(%rbx)
  33:	48 c7 83 e8 1f 00 00 	movq   $0x1fdc,0x1fe8(%rbx)
  3a:	dc 1f 00 00 
  3e:	c6                   	.byte 0xc6
  3f:	03                   	.byte 0x3

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 89 9b e0 1f 00 00 	mov    %rbx,0x1fe0(%rbx)
   9:	48 c7 83 e8 1f 00 00 	movq   $0x1fdc,0x1fe8(%rbx)
  10:	dc 1f 00 00 
  14:	c6                   	.byte 0xc6
  15:	03                   	.byte 0x3
[ 1915.510058][   T42] RSP: 0018:ffffc90000157d40 EFLAGS: 00010046
[ 1915.510390][   T42] RAX: ffffffff84141a18 RBX: ffffffff8413fa28 RCX: 0000000000000001
[ 1915.510822][   T42] RDX: ffffc90000157dc0 RSI: ffffffff82768da2 RDI: ffffffff84141a08
[ 1915.511253][   T42] RBP: ffffc90000157da0 R08: 0000000000000000 R09: 0000000000000000
[ 1915.511684][   T42] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ 1915.512115][   T42] R13: ffffc90000157dc0 R14: 0000000000000000 R15: ffffffff8413d894
[ 1915.512546][   T42] FS:  0000000000000000(0000) GS:ffffffff82a60000(0000) knlGS:0000000000000000
[ 1915.513033][   T42] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1915.513392][   T42] CR2: 000055fe70034138 CR3: 00000001740d7000 CR4: 00000000000406b0
[ 1915.513828][   T42] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1915.514262][   T42] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1915.514696][   T42] Call Trace:
[ 1915.514881][   T42]  <TASK>
[ 1915.515048][ T42] ? __warn (kernel/panic.c:236 kernel/panic.c:677) 
[ 1915.515275][ T42] ? trace_seq_printf (kernel/trace/trace_seq.c:35) 
[ 1915.515550][ T42] ? report_bug (lib/bug.c:?) 
[ 1915.515799][ T42] ? handle_bug (arch/x86/kernel/traps.c:238) 
[ 1915.516038][ T42] ? exc_invalid_op (arch/x86/kernel/traps.c:259) 
[ 1915.516298][ T42] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 1915.516586][ T42] ? trace_seq_printf (kernel/trace/trace_seq.c:35) 
[ 1915.516860][ T42] ? trace_find_cmdline (arch/x86/include/asm/preempt.h:103 kernel/trace/trace.c:2546) 
[ 1915.517142][ T42] ? trace_find_cmdline (arch/x86/include/asm/preempt.h:103 kernel/trace/trace.c:2546) 
[ 1915.517420][ T42] ? preempt_count_sub (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:5900) 
[ 1915.517694][ T42] trace_print_lat_context (kernel/trace/trace_output.c:516 kernel/trace/trace_output.c:664) 
[ 1915.517995][ T42] print_trace_fmt (kernel/trace/trace.c:?) 
[ 1915.518257][ T42] ftrace_dump (kernel/trace/trace.c:10413) 
[ 1915.518505][ T42] rcu_scale_writer (kernel/rcu/rcuscale.c:534) 
[ 1915.518775][ T42] ? __cfi_rcu_scale_writer (kernel/rcu/rcuscale.c:453) 
[ 1915.519071][ T42] kthread (kernel/kthread.c:390) 
[ 1915.519298][ T42] ? __cfi_kthread (kernel/kthread.c:341) 
[ 1915.519554][ T42] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 1915.519802][ T42] ? __cfi_kthread (kernel/kthread.c:341) 
[ 1915.520057][ T42] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[ 1915.520326][   T42]  </TASK>
[ 1915.520496][   T42] irq event stamp: 8228
[ 1915.520724][ T42] hardirqs last enabled at (8227): _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:?) 
[ 1915.521290][ T42] hardirqs last disabled at (8228): ftrace_dump (kernel/trace/trace.c:10359) 
[ 1915.521783][ T42] softirqs last enabled at (0): copy_process (include/linux/rcupdate.h:298 include/linux/rcupdate.h:750 kernel/fork.c:2366) 
[ 1915.522276][ T42] softirqs last disabled at (0): 0x0 
[ 1915.522663][   T42] ---[ end trace 0000000000000000 ]---
[ 1915.522970][   T42]  swapper-1         0..Zff 1910231878us : fib6_table_lookup: table 2166473472 oif 80736 iif -14080 proto 0 81ff:ffff:ff60:6d05:81ff:ffff:ff00:0/0 -> ::/0 tos 96 scope 109 flags 5 ==> dev  gw :: err -1
[ 1915.524039][   T42]  swapper-1         0..... 1910231880us : Unknown type 1830
[ 1915.524442][   T42] ---------------------------------
[ 1915.524733][   T42] rcu-scale: Test complete



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240205/202402052141.769871e2-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


