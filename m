Return-Path: <linux-kernel+bounces-86098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F48C86BF8F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52662887EB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E193376E5;
	Thu, 29 Feb 2024 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLSM/Bo8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891FE1F95F;
	Thu, 29 Feb 2024 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178402; cv=fail; b=F05GhuDHZUwFkjT9/OJr2DMl3r0QbyYKXT+MtD/7Yu6YLRT9b776LV8btOPn28COyu7lUXpKAKQzOCE78rogTOqf6xi6S6TFDb0vl5Aqmxsm0H6ki1cq1EmxSzigUeTqz6SLdk8UZcsR8FdRoF3wPnHJJ3kVplZnPTpjLvni2kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178402; c=relaxed/simple;
	bh=NApotT0Di9rQ2Ab1TE8i485C1eybRBnqSCgYt0Mkcb4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oNN7xxDutwfXq3BYoTQjmUWD0/6ckyomHhXB1fiasmDGym/xPYnz1rUo9eHLIvCZ+W8HxiH6V3Jn5oiB5Fu1OlccQDj4TOZi3mpzYQiwAuzbAQNo3uLdNhnc6XwriagyRiK9KQ6695qk6OuFH+nIi4PWnxh3C2QJS43AH6eVaC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLSM/Bo8; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709178400; x=1740714400;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NApotT0Di9rQ2Ab1TE8i485C1eybRBnqSCgYt0Mkcb4=;
  b=HLSM/Bo8bfPaMEHDvvUWDIc8meRWF6qF7hLterN0PEGDlfMnqPtBAANG
   MdBbum2fDevO8VPgTp4R3k4CwhAcOLZ1V2nvoDS665RfBHGRjUZ4shd0U
   zazuMbT3c/jZaCxwq2vjWqMmchBYMMwd65+dZ63Tz1drkEOsOJDZdUFsW
   8dtHZqHJYqe82fpOe99EjPmMW9ytQl9LaK3MPOmcVAkLoAB7mbt8s6JMR
   J/DYP0w8aMFN5VZsgGMY4op41fYGOLjcLMJ6AD1Zg2UMul0XfeIUN9Nbq
   MqtmpD/SjdBIIF0udz92JzTFWoJg9IUOusKTQQsqyX4w++1dymiyYh7mR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14191451"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="14191451"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 19:46:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="7605968"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 19:46:39 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 19:46:38 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 19:46:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 19:46:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 19:46:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inapGt/eRSuP7y+aUEunk0MVta93AGKBBwaQHspq8nVXDQNN6wxINQaH+gJCV4rZEw8nBcW+1UikwSs7FRLKjtRrBB9GWETZx0iqstzjfTRKciW+R/Stf7IJwGIVE52ErTbxmP3mlOod5IGCDM3iVaVyZrbjzAOytLcAC/BxCnPmIz8/hBuu9jYNd5Lk9RZ5g3LVQL9RU4e3voDE2T6zShBCtKebRONb53bDNOy/6QdjbmEHkKFvO5IQbpZf/cQQLPFv9QtlbhDcWp8ZidfLeQcsIYEzS8cBQ0aVX3lCGMPsj58UDHJhjOqokdyPVTE4x2BmDis0pphkAeRU/o99jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEioF9IHgZ7vclzOsOer5kFe5vbT8y9MTMRqdn+ojbE=;
 b=WdJEX6WIZFZ53UZhlxgUgWRfn/KHv6kKR29E9s6hPJu3+i7J3f/FedNMyid0HsKDt6fBC3QkUjb7OE9Vw9vksqmf865BiZ1vsvUgggLkq9dRqEIBUsaxF+HW+ooA51zVBOOjcWJNLjWAjopbProN5sslWO3IW1o4JPh/1wUmilDdT1FIg2H3dh1p3eEo3aSP7vv8PGlEWxCTZqCs5CXqmL/hlMPNuRXc4hizViOm/8OVLBupdOQxs7QDz0okm45KHfJzv0efNBe0hV4w9Y9Gt0D8UP6/YHCjtLxrthhHN1peSbvIGe4grJrUVkcKJCt76tp/loR0pyYDj6de027ApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH0PR11MB5047.namprd11.prod.outlook.com (2603:10b6:510:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Thu, 29 Feb
 2024 03:46:34 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::5095:2f06:f31d:95e2]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::5095:2f06:f31d:95e2%5]) with mapi id 15.20.7339.026; Thu, 29 Feb 2024
 03:46:34 +0000
Date: Thu, 29 Feb 2024 11:41:29 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>
CC: "peterz@infradead.org" <peterz@infradead.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "Eranian, Stephane" <eranian@google.com>,
	"acme@kernel.org" <acme@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "maddy@linux.ibm.com" <maddy@linux.ibm.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sandipan.das@amd.com"
	<sandipan.das@amd.com>, "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, lkp <lkp@intel.com>
Subject: Re: [PATCH v4 1/4] perf/core: Rework forwarding of {task|cpu}-clock
 events
Message-ID: <Zd/86VJB/EQZsYPD@xpf.sh.intel.com>
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
 <20230504110003.2548-2-ravi.bangoria@amd.com>
 <ZdRluZx3fy0xx78D@xpf.sh.intel.com>
 <9eeb2273-9690-8f71-4f3f-595310d53600@amd.com>
 <00f32f45-a423-2c6a-e53b-c132ed1cde50@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <00f32f45-a423-2c6a-e53b-c132ed1cde50@amd.com>
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH0PR11MB5047:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c66fca-4da8-45b9-3ffc-08dc38d90635
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NsAMXuOkUKMV1nHcpfnhKf9ZrJQDSOZRR7n+DGc6cBV+V+JwSCIxt+AfQ2Ur7tIdgnpniLx9+Ou0Hu5+7iP66GsMtf2tVlsHoS1ob+PhFooqMXpc8PyZfDvmlJhmcP9JtVpEGLfwsLE5UxnQ/ky//8RU8g3I2cVIQbw2/LXTHXgRcKLyyou6havarwhO71AvrTzDV+bmKN9xtK853bFRzpp0bAY0qmkB507OIvtPP3YIvuULyzteorN4wwhdXxFa9/neD+rwDAHU9oA4M2k3e4VvfliDCj0S0YI2qQNnBnS9xJNwAiKNgetIuk2KlM0xZ8bnEgazIDS+OMkUsBqF89y2rqOzJbwD8R5OxNjrPgsvogHV5nlk9lj6zcIf5U3y/D7ySBWU4SyIf1jXuGbvEXxF60NieN6d8MPR7a1mi068slI3e2H7N7n0qrMFAssGk9ywG6i3EsDa07RO7glSZZEBmhvHiRphnVqKGyAtN83U31qzrhJuw2D8HjexSkwmU3c6xPdeH4NgcWP2j8soP8oCVcS6HCYI5xJ3owfSGc9mELHrWqtECS05SXXFhi/ifNQ0Gl25bSS8FtktlmSL7sRZ0fPYZAi6Ri/UrJtBZN9O1ac5MYBpCHu+CzE5cO1/2Qjh6VSLZgXHzC06pfFD5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0vBmpDD+mhWtZesdS7saNtVPjd1SHQtiJbtrldHvRi4UJ/MNd8hE98giuUhE?=
 =?us-ascii?Q?Mddf0wVxxLA8aDNuq77Yvc7H3l9zCy61rvo0YO8gYa8pUFSAbojOLgQaNbuZ?=
 =?us-ascii?Q?dpainOI285CAwnEuKOjfxgOHyC0N78wZ9yQGDd2EF2jQbD/iWRHhbctepusk?=
 =?us-ascii?Q?B4t/TYyI9UJ7pvAFLqqpssZ9arniemc7lxqiF1LtsH6DM51O/OxDIvOBig5y?=
 =?us-ascii?Q?GUT+nmgfpV9Kfjwv/3p7sdUrdhqmtPJlqvtlcJWW0nC5KWtVQ0JHuNPljzzK?=
 =?us-ascii?Q?7h49DdhRycFhmJ4m1rTZlV0QvKKAxgIISdTrgfTGj25sxfvuHS8dJTGMgz2Y?=
 =?us-ascii?Q?SX+ycGO/sP87xVmTZTt81UAtTrUDuzlkIWCLEjJy8/48vdZmY8NhIKoOuYV4?=
 =?us-ascii?Q?A/WiM/8x/EVRyjSgvuWbkUP8HGJLY7YbTkiOT6NutQM4rCtXogD7sjblbTg3?=
 =?us-ascii?Q?bSJXkVY+iskShaQuC0DQwNDtuJwd2H1M6WwIvOr0DFToizKFBXeExoHK2Yc2?=
 =?us-ascii?Q?JhTEG241oo276N2R8vAkwzoHR+KnAHaBjc0GAkimJhjNIE4rp2n4wQ8BboIe?=
 =?us-ascii?Q?I1YNFRP7MuyxO0haDYmNVyX/DwKDi6Fh1mZroL0/knnVYUE2ZxkPhcsyF1W/?=
 =?us-ascii?Q?pv/adEZBNqv8yetIsNipj2UH8ALHROHeun2Lz7TQAYbxf6Mn8+Lv4wGn41PC?=
 =?us-ascii?Q?WBEj0plkNnu65Xo5mxddd0cFzrVSSMTcaZ4Zc7oi70zyoLz/M3sWxkWoK1pG?=
 =?us-ascii?Q?RlnXKJzfbJS5fU6ArCtx74NwUwxj9+K5LrlOJC0GfrnBbNmbOm6ebpeCQPQQ?=
 =?us-ascii?Q?DkwmzMKoFeTTCEcaDU1QB/H2AOgo7b4QALpUaIIwJnaZXTxDWcQUI5VOpUyq?=
 =?us-ascii?Q?vPrP9hSUyw9BAjyUCuBCK7yvv7T7wMBxi3TTiENEn2iZwYoVkLSdy0+h2I14?=
 =?us-ascii?Q?3YUkvvCzXQPs2+FORwoG7yOmDNdlh+/xs+cNkCxQ7uxmvMfy/8P7GJvM3tGU?=
 =?us-ascii?Q?EWJZ//5pJA/jNSYC5FhJES/oCojT1stBXsotlpyThS6C6ZkeckwbaB/jg93X?=
 =?us-ascii?Q?1gh7TZtknFmIpbh12XSLDznZqQCQrOPIlBXnYXiMgfZs9l0wPHh4U4pxidoi?=
 =?us-ascii?Q?S03uQk3NHo58fjhuQoicRJOd/VbOajv636AL/yAbAHF8W4tmk6DuJ1PBsK9x?=
 =?us-ascii?Q?DYEA7UDgsO0rC1p39dstp1cXPGJ957Eb+WFTrLsEJ7CaWHVlbzDla2fvTThw?=
 =?us-ascii?Q?QudBpziEj7nP8dh6EIcXeIhjj/++9qYxbE/Lz3GvogNt4DB+UIlSjPBuvdml?=
 =?us-ascii?Q?HGbCgcEcop8VpUyVxyaKT4DLSIxo9q3SQeV5z0tNdx+efoO/dzpsWEdGp1kC?=
 =?us-ascii?Q?0zhTexTM+0Sji47YrQIgwO2sucTiXDpbY8pUtKVQlcmyEH/4ZAeIR5cvCxbO?=
 =?us-ascii?Q?YjdeVHShhSOd2IavEiF5QwapVpiy8SS/ZdCps7CU2K8ZNY2Ye4QmrV2gS5LA?=
 =?us-ascii?Q?H87ukHxFaI+bOy6O1q16mazcyJC9H1mdL9RDKVI7wjmXBhhdax0X9G4bowpe?=
 =?us-ascii?Q?MMwIoQp4nF21O8oLesj2xILxKLuooi4umfR8xx5M?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c66fca-4da8-45b9-3ffc-08dc38d90635
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 03:46:34.4203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1T7a7hrOhoA2nRLC+wFPe5vEHd8s+WnbhSCReQYPoojuLbepZZJl5EWfSlRv1Cy1FzwzWOoU5qjr1jT3JiJsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5047
X-OriginatorOrg: intel.com

On 2024-02-28 at 20:49:59 +0800, Ravi Bangoria wrote:
> >>> Currently, PERF_TYPE_SOFTWARE is treated specially since task-clock and
> >>> cpu-clock events are interfaced through it but internally gets forwarded
> >>> to their own pmus.
> >>>
> >>> Rework this by overwriting event->attr.type in perf_swevent_init() which
> >>> will cause perf_init_event() to retry with updated type and event will
> >>> automatically get forwarded to right pmu. With the change, SW pmu no
> >>> longer needs to be treated specially and can be included in 'pmu_idr'
> >>> list.
> >>>
> >>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> >>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> >>> ---
> >>>  include/linux/perf_event.h | 10 +++++
> >>>  kernel/events/core.c       | 77 ++++++++++++++++++++------------------
> >>>  2 files changed, 51 insertions(+), 36 deletions(-)
> >>
> >> Greeting!
> >> There is task hung in perf_tp_event_init in v6.8-rc4 in guest.
> > 
> > Thanks for the bug report. I'm able to reproduce it. Will try to spend
> > more time to rootcause it.
> 
> Although the bisect has lead to 0d6d062ca27e as culprit commit, a minor
> change (shown below) in the test program can create the same task hang
> issue even with 0d6d062ca27e reverted.
> 
> -   *(uint32_t*)0x200000c0 = 6;   /* Use cpu-clock pmu type when 0d6d062ca27e is present */
> +   *(uint32_t*)0x200000c0 = 1;   /* Use software pmu type when 0d6d062ca27e is absent */
> 
> So, 0d6d062ca27e is not the culprit commit.

Thank you for your analysis and additional verification!

commit 0d6d062ca27e only changes kernel/events/core.c judgement:
PERF_TYPE_SOFTWARE to perf_cpu_clock.type in function cpu_clock_event_init():
"
@@ -11086,7 +11092,7 @@ static void cpu_clock_event_read(struct perf_event *event)
 
  static int cpu_clock_event_init(struct perf_event *event)
   {
   -       if (event->attr.type != PERF_TYPE_SOFTWARE)
   +       if (event->attr.type != perf_cpu_clock.type)
                   return -ENOENT;
"

After reverted the commit, and change test code 0x200000c0 from 6 to 1,
kernel code in kernel/events/core.c: func perf_swevent_init() still keeps
PERF_TYPE_SOFTWARE(1) judgement because above commit doesn't change judgement
in perf_swevent_init():
"
// PERF_TYPE_SOFTWARE = 1;
	if (event->attr.type != PERF_TYPE_SOFTWARE)
			return -ENOENT;
"

So it seems show that attr.type(0x200000c0) = 6 will return -2 and not solve
further action in perf_swevent_init() will not trigger task hang.

And if attr.type(0x200000c0) = 1 will pass the judgement and solve further
action in perf_swevent_init(), and then will trigger task hang.

Thanks for correction if there is something wrong.


> 
> Additionally,
> 
> o I've seen task hang or soft-lockups on a single cpu KVM guest while
>   running your test as root and also as normal user with
>   perf_event_paranoid=-1. But the same experiment on host, no lockups,
>   only task hang. So I feel the bug report is false positive and there
>   is no real issue (since the experiment requires special privilege).

Thanks for your info! Seems some problem will cause cpu soft-lockups.
If there is more clue, will update it.

> 
> o 0d6d062ca27e has inadvertently started allowing cpu-clock and task-
>   clock events creation via their own pmu->type in perf_event_open(),
>   instead of earlier design where the only interface was through sw
>   pmu. Is it harmful? Probably not. But worth to be documented:

Thanks a lot for description, and there is some other way to trigger
the perf_event type change.

Thanks!

> 
> ----><----
> 
> From c7ae1c57e2a23a05eb982524d37bc8542c9c9a34 Mon Sep 17 00:00:00 2001
> From: Ravi Bangoria <ravi.bangoria@amd.com>
> Date: Wed, 28 Feb 2024 17:29:04 +0530
> Subject: [PATCH] perf/core: Document {cpu|task}-clock event open behavior
> 
> The standard interface to invoke task-clock and cpu-clock pmu is through
> software pmu (see perf_swevent_init()), since these pmus are not exposed
> to the user via sysfs and thus user doesn't know their pmu->type. However,
> current code allows user to open an event if user has passed correct type
> in the perf event attribute. This is not easily apparent from the code and
> thus worth to be documented.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  kernel/events/core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f0f0f71213a1..4072bccab3ba 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11178,6 +11178,13 @@ static void cpu_clock_event_read(struct perf_event *event)
>  
>  static int cpu_clock_event_init(struct perf_event *event)
>  {
> +	/*
> +	 * The standard interface to invoke task-clock pmu is through software
> +	 * pmu(see perf_swevent_init()), since task-clock pmu is not exposed to
> +	 * the user via sysfs and thus user doesn't know perf_task_clock.type.
> +	 * However, allow user to open an event if user has passed correct type
> +	 * in the attribute.
> +	 */
>  	if (event->attr.type != perf_cpu_clock.type)
>  		return -ENOENT;
>  
> @@ -11260,6 +11267,13 @@ static void task_clock_event_read(struct perf_event *event)
>  
>  static int task_clock_event_init(struct perf_event *event)
>  {
> +	/*
> +	 * The standard interface to invoke task-clock pmu is through software
> +	 * pmu(see perf_swevent_init()), since task-clock pmu is not exposed to
> +	 * the user via sysfs and thus user doesn't know perf_task_clock.type.
> +	 * However, allow user to open an event if user has passed correct type
> +	 * in the attribute.
> +	 */
>  	if (event->attr.type != perf_task_clock.type)
>  		return -ENOENT;
>  
> -- 
> 2.34.1

