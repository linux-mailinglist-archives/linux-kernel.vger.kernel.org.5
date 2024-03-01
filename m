Return-Path: <linux-kernel+bounces-87995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1CC86DBE7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A2B1C209BA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EF169946;
	Fri,  1 Mar 2024 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+ysFoTA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEEE8464
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277306; cv=fail; b=myMJRBsSGYwEih1kNhP6n+RGotLhT8l/XQBmnGMzt7bf+V1Tl8x0vbInDYtr7tYRZ41OF/Qh8plYj9bwiXpjwiesHneGVg0uqUSRu0C8oUnHOKF8CYKlnEjLR56tjaBcDvfVVHTOzG5kPfTxLKcTSWRtlZhgu5yTY6gBcmnsXnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277306; c=relaxed/simple;
	bh=vF+AM3Sov1DdepVG3cB2ERHEqkcPWiLaB0YnLSUni8k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dB4R1K0n98sKJQ1bmm0ceOYuCZe2/BqKroaHzjGJXp2ctBp8J19mBOo4Mq1X9KmIXqnWYozpJ/cc42jvRT2UDA1XpVkJjxIBMieLnwKp9O79CNX/FuU+CkA1rGJQA6dQJrfcguTsZagayCFgqKibnUiN8cR58CNnK9HhTGcb3x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+ysFoTA; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709277305; x=1740813305;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vF+AM3Sov1DdepVG3cB2ERHEqkcPWiLaB0YnLSUni8k=;
  b=l+ysFoTAXfIWG8ADwLR6oTFotl7ozvnTSW7g97lhqL1QmwPjpw5YeX8f
   dcH8iK597efgldiQm22n2EQCFz1Uu7VLxR9nj9efcU5IkKuDUdoDgUN1K
   vr6KDUWoHNsWo7FgAY/DrUv9FTN2awOhXI51p8j0h4tQuOaC5OwDY1ClL
   rNdZzoC6wOEeaAjAYHQBllP+Dt/lpkQvxycnVXZB7Da/2s+wSzB7RvXw3
   zNdi0jFIz62no72pG9MJwJUg9mIgWnsrwGxAOvtR2c8AsGB7PE0nEIw/1
   syJvYQYN7VHkCBAyh4LySec286aITrnfgDb07zfUswzp4wOLYjQ+k/vjW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="29227741"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="29227741"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 23:15:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8243034"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 23:15:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 23:15:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 23:15:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 23:15:02 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 23:15:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfsWTJAzmBpZb5Ztxvd+e+QxLVy+rGQiO+0ypQHk3nnrcktLObcDFb1mtIOqeCZNtDv5kD51u4omAxdoTcWlnzmOCfE0RHIBicfWpK34lp9YUjofsv5Bn4hz4DLh8e6Nv2m+oHCq/LshsSrrwHxoTFz2W3f2m3/ijONtAjJ840rcpgvoLVLCHIWNbIhcQndcoCbivicZ468iCgQfOVyp19UwKIk9VTBigQL7r/4Lqrdb7wa7Ympo97mQz1GbZWWZeSQCDjjLtpLSIYuHp/xSPDJR/Pyq2Obsp1K7txdC1NwqIw8Njx69skOD1H40QM3oAsjOrK5u+B+4UcVnlm0qFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KVmWZyAVOHjn55FYIZjPqiC+PCZmc43Rg4JhYgJhTY=;
 b=Q7xoF/2Kl+Lgmxl8wLInFAo5LnIyFvNoN1Hc6NzGa67jryL16dlupHfN6Zp8w3fBDEDsB4MclLgKTsgig9KusbRAf36lA0p+3bpl8yXoYcWZ03VN8Qh0zbFvp3crDcjLtr4kTSkasXXQ+jnRrRUntltFb8oP1CfLAbRKyjIAs05/HFeybDMP1tneDw17oAoe+kX7xu3NFqzLhl5xGQr7YOOKRl7NCss9JAqklRN49ovkl4ZiW8SAyEsfr4vOhVfyltqp9xXdGIO/x+vCKNnhasAn1QCS3XWUYRi+l0+6xuNmWyjysx8/ALMDvEtzyn298J2wdVNfEi2QA+Fw/S3W/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19)
 by PH0PR11MB7421.namprd11.prod.outlook.com (2603:10b6:510:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Fri, 1 Mar
 2024 07:14:55 +0000
Received: from PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::8c8a:c38c:aaf7:da30]) by PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::8c8a:c38c:aaf7:da30%4]) with mapi id 15.20.7339.024; Fri, 1 Mar 2024
 07:14:55 +0000
Date: Fri, 1 Mar 2024 15:14:46 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Abel Wu <wuyun.abel@bytedance.com>
CC: Breno Leitao <leitao@debian.org>, <peterz@infradead.org>, <bp@alien8.de>,
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>, Oliver Sang
	<oliver.sang@intel.com>
Subject: Re: general protection fault, probably for non-canonical address in
 pick_next_task_fair()
Message-ID: <ZeGAZg/JXifpX7bp@chenyu5-mobl2>
References: <ZeCo7STWxq+oyN2U@gmail.com>
 <123ebd58-9ca1-4a12-bdb7-c35d0c48c93c@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <123ebd58-9ca1-4a12-bdb7-c35d0c48c93c@bytedance.com>
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To PH7PR11MB6005.namprd11.prod.outlook.com
 (2603:10b6:510:1e0::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6005:EE_|PH0PR11MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: e402966e-1c48-45cc-44b9-08dc39bf4b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fL2ZysViz2RE28lc4eDy5xXgp89GH7O6crhN0LyED6WRt9Rk/8FIN3/twXqLyje2Ls8tv8tk3Kp6nKvd6Rw2cj713KW+9M3GDtlsgzahqx1Ch+WgtGspY4AkTY0Ph0XyIh5QCmQFgadA0KxF61d0Z0rPzLz4gZer7mr/0uMoXneDjDv2mTwEoGYK9unX/JGxyaH0dHutxz7ODyrzWo00pgVd/Lw6kB1msc2oSbsmzpRNeVkbUnTUudlIrO099YIrExI2E4U5YYqfhd8ik3MMhDOwKzC7jbeIfH+t559rPDG2QeQTHZZwduQMt41AJD0Wzp/GU2a9mXUGlnw4+ucvZgx/KvEk2hR52wg1TNTQSo5Do6RZ8bdbBtp9c0R+6N85AqhaJn6MFnmLV1f48k5dCAmlJ24EzOqFLvXgmYg26BIj+gnCxtb5hnUq9MDHhajXrKB8+DKjfXmofzbDOM0W19R4cWy8HBqp2gnoZoBMdg2JbNZ7svVhB3PWanIQEKPuFSlFYP3hGXsP3Vi1Pq6UD/YcEKdZBrkgkS/uJ6XrYFNjLPeNRLKNXfZU3+5ob9mNdEyTEGQ22Tq5RKavjT+tkSvElfmBJ4ePHgUB0c8qbMr7cFLu9b7gLkGqjycxWQacAG7zeZ8zIUc0es3l9if9Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pWF0o7yxA/zwHSASQybqdsQwjoWeDNjCLR/ikMY1tew3diPpAFcLPZY/VU1L?=
 =?us-ascii?Q?t9JOzUS0XmnyYjZFb6G3eyo2B7H9sJaYGaicHc4n3yvkfAq3U9Pm9hKg9j8P?=
 =?us-ascii?Q?2ufqxlccFmTXkXQt9vQdjGSqeLCl9wkjz9GBNvu4dd0ltaRei2GWx1JB7IqA?=
 =?us-ascii?Q?tuaI8vJV67g2/GvTpdxwdsX8rP18AN/nCbx7+znnZ2XepvjAn7wbgPbeJrQ9?=
 =?us-ascii?Q?QrNCR7P92oGbO3V//lQ0ghNpef9ZPrm8MbFgCtNjxbwbrVQk2qWb5TJ6ixgV?=
 =?us-ascii?Q?dhe9VHHYJQtZqdgS5imURd7WMnl7o2i425iunCHa6Qrcip137XcOSoivVDbv?=
 =?us-ascii?Q?mcghhVoZ2t5sJc4zH8QWgBpmcv89M0W7m2jlyegRNoUMTmZazUkvEZobYXlV?=
 =?us-ascii?Q?zCEnNzEkbrFVMJMjTza7KOQwhSfNJuA9c+fsSoKxoMY++OevitffIvsxLGkF?=
 =?us-ascii?Q?0V6z+BdUa6sKJwIkDs/GYO0mbAI/J7VUzl07ngAMwgrKZ7HIN0xUhwIoeJbM?=
 =?us-ascii?Q?FPhgC6IQY+NXUEkaMB1s2PgaMzXnl/D80JMvKDdDDy6tL/HZzapt4d8IRinr?=
 =?us-ascii?Q?dwEDgZV6BlzcU5w6on67bP8EleTTO9VfWpxRCS8Nn98Yo1Y2bPPJHNaXdjJn?=
 =?us-ascii?Q?V/mzLwjky/rvWOH7O465YqrnG9JUSKEQ8x4R28IlaoKXHCmfiewA6lAJ0lyh?=
 =?us-ascii?Q?8lUC3ujYHTcv+aimFdFprEbN3D8vUL9+1vF7SRoH+PANOj5YZZRwgsfN9bVD?=
 =?us-ascii?Q?N3NsU1s+DPQZp4lt+t+qAtZsC+zIAmjIIEs2PlmwxSYWPz6b3wOH8VKxTGDc?=
 =?us-ascii?Q?ubR14TBH98yI/V71R7L5RyAqA8F5wlZ2tl88j7xQoHMbam92aGbZCrsgxJ/j?=
 =?us-ascii?Q?PyTaYqt7UkIDPTao2BnYMMlC8SqfZ7oMccMvQW8BP4vSU/6NPy4Y2/Kq0Bnf?=
 =?us-ascii?Q?DsLjs5W6m18M1gPrNrqiEzvO3yzsmpK1aeih/Cewucv0XDwNF9jnJoOGVXyI?=
 =?us-ascii?Q?MfqT00HVC5jU5CPubVcBzUZIV2sf6JXCgDaMBHBC7DOM0ZSaPdiSwNRNNPqo?=
 =?us-ascii?Q?a4EOLLK6iJ+w4hWfzbIbXlPnxdAZJwBrcNXLl2k21Jr2HadvnT/ahFmz1Vn/?=
 =?us-ascii?Q?9lXfiZJzGd7UgYGOusaYoU9moQmKdWhEjuM1Q+1hPWP5pDEfc+a2tIupwpwa?=
 =?us-ascii?Q?aTCnaJ8qOhmTN7dEDT4R2UkZYUO8W8N4RMRJCLThqrFvbiYASEZZUYvAjHHg?=
 =?us-ascii?Q?JInb9bDb6GpSLqxtQA4+chcEincSONRsft7Z/HwTXqztg92w8+GE0ecl9anE?=
 =?us-ascii?Q?to5IYydqcD+Vd1sf2/QP8m0xvOCRVAl4cKaQEpRpIYbNUqVTDhKeEU2qUP2M?=
 =?us-ascii?Q?8gbB0RfdyxvwD/Qs7KFfZEa20GXJG/lQBIDR6AVNB7j5SLrneLs+48IF43ge?=
 =?us-ascii?Q?phMPGKbnhmgV0gYNnCJC8k8vQV5xiqkHpct0gTPpa9hbdM1E6sDHCiBoT+Yi?=
 =?us-ascii?Q?knVTPGJ8L1KKV1fhD8N3Hx4ifwn22TNyTyc/QqwXbkE68IkwLxRoKiFiXxpg?=
 =?us-ascii?Q?7M8sq62cKWEbGHe8nRuV8PgRnykvvsCgAKNTI6Vj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e402966e-1c48-45cc-44b9-08dc39bf4b96
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6005.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 07:14:55.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7k3Bvmcx8G24VFipAfeSsidMwggYfK2JcX7Hf9FLVlMPENXGADgcxie+tBVRybZX5Tp1cWoHHiASTvC3p68YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7421
X-OriginatorOrg: intel.com

On 2024-03-01 at 11:47:05 +0800, Abel Wu wrote:
> (+ Chen Yu, Oliver Sang)
> 
> On 2/29/24 11:55 PM, Breno Leitao Wrote:
> > I've been running some stress test using stress-ng with a kernel with some
> > debug options enabled, such as KASAN and friends (See the config below).
> > 
> > I saw it in rc4 and the decode instructions are a bit off (as it is here
> > also - search for mavabs in dmesg below and you will find something as `(bad)`,
> > so I though it was a machine issue. But now I see it again, and I am sharing
> > for awareness.
> > 
> > This is happening in upstream kernel against the following commit
> > d206a76d7d2726 ("Linux 6.8-rc6")
> > 
> > This is the exercpt that shows before the crash:
> > 
> > 	general protection fault, probably for non-canonical address 0xdffffc0000000014: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
> > 	KASAN: null-ptr-deref in range [0x00000000000000a0-0x00000000000000a7]
> > 
> > This is the stack that is getting it
> > 
> > 	? __die_body (arch/x86/kernel/dumpstack.c:421)
> > 	? die_addr (arch/x86/kernel/dumpstack.c:460)
> > 	? exc_general_protection (arch/x86/kernel/traps.c:? arch/x86/kernel/traps.c:643)
> > 	? asm_exc_general_protection (arch/x86/include/asm/idtentry.h:564)
> > 	? pick_next_task_fair (kernel/sched/sched.h:1453 kernel/sched/fair.c:8435)

Seems to be the same reason pick_eevdf returns NULL.. it panic here..
cfs_rq = group_cfs_rq(se);

I remember lkp has regular stress-ng test for regression test, but
not detect this yet.

thanks,
Chenyu

