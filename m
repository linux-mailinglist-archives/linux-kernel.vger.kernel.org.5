Return-Path: <linux-kernel+bounces-136194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F13D89D0FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429091C23F44
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539FF54BE7;
	Tue,  9 Apr 2024 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SUHVngtl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9382548F8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632829; cv=fail; b=OrQ/QMAaOC+qPrpbJMCQSHhTbt3hgF8rqGe/waU4k53533nzKRkJ+slCJF15lwyUA4mFE3Yh4yqjdgZozDC2Es9ozu3CWSmuOAd6RuK3DLuf8GGbkTKf2h9bARWdXUFV8zkj0GInetMMqt703cvkdQh19sjqaLCwTGcxztQSlkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632829; c=relaxed/simple;
	bh=h/hYeWkkKnA21dsPgYzOLWpqdJ0+LJcufJBB9UvidWU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RZsGHNuE6+Lls7DmGJa+ZTgdjKldM7OQ3oNcOE5SYHr4qwrOgcDWbbwwGtKIuP4R8fDnATNs5B75KHiBQiXzfYGc5wUnM4yO9VKe06YjqZ7yK7u7319c3tXsG00trfjZ3ZvYH0gpdjUNzwlhbsj3n4DPE0f6YXtJwgrspnazh+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SUHVngtl; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632828; x=1744168828;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h/hYeWkkKnA21dsPgYzOLWpqdJ0+LJcufJBB9UvidWU=;
  b=SUHVngtlkn1xGWr+ZtV53FiAyltR+US6WbZm0NCNPDVM6gQyqO3A/5wo
   1VQ7E1afcVnjGuJg6AkdujxCkSmIjgLSz1Ye8uUOcAPY99bfYQfHA5CrO
   pceKvg0B48C6oZF8sjDTp3zCtxUbQGb6VxK1YZuKaSuIRK+gwjuY+O7li
   xY9JXwyoslhfbJTLQHZf7GhUeXa1KIDeEFlI8Fq3fop1a73P6U7tDjJNL
   3gbrPqN7sXqZHliF6XA4JYRrkUU29R97zLeKdlM8ITWJF8L7iikZwXDXX
   n0me8/9BVfnWO5ODCiDdMZTZzqoX6ejaa49n4FyRH9JdCGxpQcl1cGerB
   w==;
X-CSE-ConnectionGUID: D4IKKvEVRXK4jP/3eDNLJg==
X-CSE-MsgGUID: JtEUdDyRRiqXvxSbTgM/Rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8511430"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="8511430"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:20:27 -0700
X-CSE-ConnectionGUID: 7sWcJbTiTEusDj8G7Alg4g==
X-CSE-MsgGUID: axPjXFF6RWyyKPkQFCfBIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24874912"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:20:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:20:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:20:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:20:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:20:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESoreWS/ROLP9SqRDnB2ykarENPPL+QzX0l/WyPpaB5zdeJo1Txa64YT8tF8dtyd0dcyCQ/yZxa/LtMDJOolG71N8YuokARBxShatSb6vbpzFU7txtHXlhPTqXcS32eExG4RID/sAwrE3Ddp02srO9Jct3L23G2KFYArS/lYiXS54hQvxwOhbLkq7+GQOD8WDgPTKHtlIMYzFU3gl6wmtEqzFBDZuNCSFjpzdz7ATxftcZJLBYA0wgmUYvEOYuMJiXS2NCl5ERnC5RUXJz3dEheoUe3hvAntgtOzCISKtXFPin3nTfOjF2J/oVdG4aD/1Zt/E/bnqQMqb6CRLCXV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJRm8WhF5PsGFDBmcG+1k+HqL5ULJ+rBHn6+8CX7yuc=;
 b=m1jWuyNkzxt/gDDDiMWFVeO4ZWFnJUjYeM2azvNlJQduoGb1/NPHjHO3zMa76AIiOEfTq12DvS8Fz+k7zXF1JGUwIlAkG9zA2Y0hEcxivYRS8hIpjc9s8P3x3aLqOdYe8qYo3rsr+lf+4MxRoUK4EFcYJzrIyq8VJKiDbRyvvJar9jbu0JpM/hht8EsxhdhuF7GDyR8Ajrqgy43UkEagVaaLd0dPBWtbullUlo80MQk6TchV6PpKFH4J6DRZmeK6+suFHwl8M16xDdapahH+U6PEH+WsGtC7uLqTz3x9paOPxZ7aeQj6iksM8ouboJLT5fyTThcP4JkbTHNhDh25Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:20:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:20:19 +0000
Message-ID: <67021f34-65fd-4ea8-b696-b5d797ae9dbc@intel.com>
Date: Mon, 8 Apr 2024 20:20:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/31] x86/resctrl: Export the is_mbm_*_enabled()
 helpers to asm/resctrl.h
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-15-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-15-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3cCACtW4cASNqqwWTV+RnsU2rT122vpW3DMVe0uJEM5yw20uzTPqYvdhQ4PZ3jmOdGqGAb6ILDMN5Mt4tOWoffVqktFfCnXIQcrgzFS8nyk64053GTg2wUvZjnqal8IdojkR+cYxcIcv82w5C8uTpL2dkEghCWa4Hvndt3llGBCCe3uKZx4bmqKos6fGxA6eFcbB2X7epHDM8X6sMN0nWimVyFADuXBhBVZP28qxmPhdJ457ZsLLrBtmHcl0hSzZ7TYConlRxTiDj+R0KBqGOwMoFvpsDEk6X5o8N9vShiGvF9VaHETiKGhN+G2q+qPkgx6Nfsm1Mc1DiqonoOuI9KxzppgQtp2Wku1FqWL0UJwRIiRNRN5zhxRKENfQpS33Vc+fspG6xtGP6gJx9t7mZ2RGwU5wEBYnLIgpob3VubKxkzSIjdTqxjGjYWyVPoJJlBzp5qTNBWUzPp1F8lrzl/+A9XX2EiRTZgOgVKJ8K42qXFlrQbFcoN02bx6OVowUqlFFjlrop7b+V8V8tGmhUnIGesrXOAxsx7sWc7WDTPACiKg5zV352oo2E98snBWVE/BQXhL4wTqy9VwR0JHXqNC30fpTlJ5BaxUQEAeVlwauWxkYfQW6C5N6qmcYpOJKq81t6Z8cb1j/d2SrgfdJtcY2w6wxP2JukZ+uJ1JgCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXc1VmpKVTkxaTFMN1NVd29qVnVUYnNiNWdDMUlZNnJMWU5icHZ2azlYeW9w?=
 =?utf-8?B?VzhiRll4dlRyamkrcjF6YVFUQWVGQVM0SzgvendZNlFFaVYwL25GdDUremM0?=
 =?utf-8?B?WjF5N3lxdjlzOGk2bDdkN3E4RW8yeG51UXFZR2ZjSXkzNDMway9QWThTbmo3?=
 =?utf-8?B?enR5cVI5SXVqcXczWEorRWVSdklWeHNQYkh3WUY0VlFJS1YrWW8yYWNUbzRX?=
 =?utf-8?B?clpLcmtodVN3aW1nZHBxSnBDRUJEMFJrZ0c0ZjRMMFRJaFVrdkNaSFUzMVp4?=
 =?utf-8?B?NEtpYnc0cU5aK0Y5ZVBocGRjMFBjaUc1WVU1eTF0Q2tmWndCZ1lhRnFPZ2FP?=
 =?utf-8?B?cHc2andDdmcrRmh5WmpkNDZMVTMzMmZnTERKQTRHQjJmVFdkeWYwUzBCNEFK?=
 =?utf-8?B?OFBKV3B4THl4YmxHU2FPZUg0ZkxaNWhsWG1OZk5ldlh0RzQ1dkc1OUNSS1NC?=
 =?utf-8?B?MVNZSU00OGRMM2gxeU1LekFtK2xTVWdsRkFacXpXNjMrZGJtYy9WcE5NOUxN?=
 =?utf-8?B?SVFmL0g1ZXg1S3hBYXBpeldGOUc3OXh0VDVrQlpqREFZRlp2SXk2UklqR0Ix?=
 =?utf-8?B?SWxxbksyZ2hlejRmeUJCb3I2czFTZVlXYVBiajIrWTBEZ2NsV1JYYkYrYXFF?=
 =?utf-8?B?ZGcrTGpKWUlQTExCSXFUODNIK0hOZ0NtL3ZjKzRuRERZVGlJM09SQjdwNTg3?=
 =?utf-8?B?VXdhZkcxcVBTSHFkSTR4WHhyWnlibDlxTDZLcUtVMFM3dlJTeFd1N1JGTi9m?=
 =?utf-8?B?NzZaWGtGMExrdjVPQXNCWnlBRmNoczhJSUtCemdpZWNUQUZFZjU1RGRGaXcr?=
 =?utf-8?B?Y3BuSkZyVUR6UGRyelIzUTBWMDh3T1E3WmlCaXJJczdGYUhvUUt2Wnh1N2Ft?=
 =?utf-8?B?aEduQjMyU0Rxd0NBTGlvTFpWMHI2R0FKSmNjWTdjOUl5Y1FSRmJPWit5QzRH?=
 =?utf-8?B?MFUwcUN1djVqWGhQRHdpbDdVcy9MNlMwMXg5VzZISFh2UmNmdE80RENjYnI1?=
 =?utf-8?B?U1EwUkhva1Nhb2ZJTGFRTnVrZXFIY3l3bVhQMHJlTER2MGtCL3hnamhHT3JT?=
 =?utf-8?B?bUVZVUtVV2NEN0Fxd2s2TFRWWUljY3RJS3Z6elNtY0F0QVFENVZLd0Y1SXlC?=
 =?utf-8?B?Y1o2UkkvTncvNkwwYzduaGY2YThBcjdWUFl3bE5DTGh3NktVS3FrOG1lVnk3?=
 =?utf-8?B?LzhVMmdxam1YZFBkbHpSRWNPeU1uUktmOXBrWXZXZCtxbzFiTUZ2Z2hFNUt0?=
 =?utf-8?B?WFEydzd2QWZ0aU13WG9YSzFXVDJCeTc5cGE2dG1Eejk5RiswUHk5d1RkREYr?=
 =?utf-8?B?NzhPTHh0a3EvYnVxQzI1S3JxWjlQUElUK2lKZ3FWcmVuVjVZbXJacmp6a3cz?=
 =?utf-8?B?V3FTbFpqWi91STBXU2hZRjVoREI0UWtwckV0UlZiZ21HSWo1T3N0Y1lSMUNB?=
 =?utf-8?B?N1ZWcnBEM1dXRFFWdWV6RERyUTZRSlBKY1hxNmdQbnkrM2gyMEpWQTBudyts?=
 =?utf-8?B?b3lnbXlVR2FPSUtGazAvR3F2YU4vYmUxMVNIUi9CYzdyQnlObHBjemdRZ3FX?=
 =?utf-8?B?aE1xQmtsVEpsbWthQk1vMkdrR1dYMThrclV1WSs2NkZibzk2MEc5dGFCMkth?=
 =?utf-8?B?T3c4SytkTlgrYW4xa1dUNEVqakZyMDFvQmJaMEU0N240S2ZLd2FkenlzK0lm?=
 =?utf-8?B?QlBFeG5MYXdMUW1PdHZYUThxYm55RmxKWlZaQ0NjZ011OTlaUWRDZ2lPQjZv?=
 =?utf-8?B?MStoNlFWZVBrT2JoTFdQeW5hODNHNE9WMVJkOERZMVNoZThnUWxkSDlKcy82?=
 =?utf-8?B?ZSt3cmtkTmN1SStBZDRkVFBKajhiREM3eUJxMTRmcjFoSzF0R1dWakhaV05P?=
 =?utf-8?B?K2pFemhVemVqMWtNaHdRWHJkNkV4cmhiQ05yWEw3Zm1Sc1hlMVdJWDhpbFJw?=
 =?utf-8?B?VjJTZ0pObHYvREVlcXFzYjl4b2t5azBYWXRPbi95V2JaMzZqUEFEdy84OVhT?=
 =?utf-8?B?R3h2UVBhV01hVUlTdUNBczZhTHREVEFveXJUSVFHQ1JDSDVoUFFKSTBoa1JM?=
 =?utf-8?B?eXlFeER5Znl0eWkrOXc0dVlYOTBlVXBMQXVUQkszRzNvZmRXbjNpMUNUZ092?=
 =?utf-8?B?S2hvdkRpczh6K3pTckt0TDdvakVOa3ZHTXhXR09pYmFCR2hPTlp6Z0NaNVh2?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dea626e-cb28-4c99-5500-08dc5843fbb0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:20:18.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 734OTz6RJmktMV9eitkpqSBY+S1EFlNPxTL+vZZR/CW9HQjadjXHTx2my+grM28JDt3N2cgChu2i0HUXLqTt8VDwPPXDXz6P8Dfhe9Oul7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> The architecture specific parts of resctrl have helpers to hide accesses
> to the rdt_mon_features bitmap.
> 
> Once the filesystem parts of resctrl are moved, these can no longer live
> in internal.h. Once these are exposed to the wider kernel, they should
> have a 'resctrl_arch_' prefix, to fit the rest of the arch<->fs interface.
> 
> Move and rename the helpers that touch rdt_mon_features directly.
> is_mbm_event() and is_mbm_enabled() are only called from rdtgroup.c,
> so can be moved into that file.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/include/asm/resctrl.h         | 17 +++++++++++
>  arch/x86/kernel/cpu/resctrl/core.c     |  4 +--
>  arch/x86/kernel/cpu/resctrl/internal.h | 27 -----------------
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 18 ++++++------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 40 +++++++++++++++++---------
>  5 files changed, 54 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 5f6a5375bb4a..50407e83d0ca 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -7,6 +7,7 @@
>  #include <linux/jump_label.h>
>  #include <linux/percpu.h>
>  #include <linux/sched.h>
> +#include <linux/resctrl_types.h>
>  

Can this be alphabetical?

Reinette

