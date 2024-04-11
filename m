Return-Path: <linux-kernel+bounces-141415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52EA8A1E02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA0428E87F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D01112BF29;
	Thu, 11 Apr 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWbgYReL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8B612BF21
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857156; cv=fail; b=R4fO9MI4O23NwUPbLG+FXsENG46Ig7UMBjrNys3pTuTLrnVzZHt8qWvADO2H6twY+ykT0w5cm/HP6aRk16fUBSf7S8aKyziT7eSNHEauiFeyN/mLOxHR7MPbis5kJ/eyqoTfGjBvmMeTwXBEL+abB7KXHD1xpYODll60ZiE0OeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857156; c=relaxed/simple;
	bh=J3GP0ljxhM1QVVe9qB8M6jcqUPgSOH2igAWCDfYdFng=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JNCeILQ+vd6QYnHfkiQsWr/2bc7pD7InuG08XiNv52IpmafGv0Hnfkct2fQ0io3zHPNP+znoG7atGjgSDdGRL4hHodG1JvHZsmzXJYIFiyhrZXNTU3MMU20/GrAIk0D4cS1alQ97Kzx9sTCa5TCNTBCGtc8A8+zw8RXLBNGv62w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWbgYReL; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712857155; x=1744393155;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J3GP0ljxhM1QVVe9qB8M6jcqUPgSOH2igAWCDfYdFng=;
  b=PWbgYReLt647MK59DWcciv+uuHAhOFjzJonVuu/Ar+XlN48wSIskBIT7
   z969d3ORMdnrf7gyRjaDw7rHFj2txBXjAk9NeP+yo+LcqO25zKy/z3kd8
   K+8o4J//IVArHd/zBN2WblIB3FDsovyti1NXQ0TC9orCdtlJB5OpT1pDQ
   T+4gvHjrA04sWv1HQKPlIuSQHZhjzJ+oiMJee7xjgXZ99a8AqylYlKo8C
   CdW5HerNMVWRiR9X9+jguYMV+hvgEuhNiL/wXkykFQv2mBsorR/laBmDp
   B3uAzvCMbXJ5GZkCMuMxHLwZjuzbJxQ1FTs50/FGglRUcpE+p4T7uOIPo
   A==;
X-CSE-ConnectionGUID: Toc7G6UNQD+Ri7/LwIozDg==
X-CSE-MsgGUID: NNx8qHVLS6iY2fXobdkxjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="33682969"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="33682969"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:39:13 -0700
X-CSE-ConnectionGUID: YFun7vDUTLu5DctXWg4yTA==
X-CSE-MsgGUID: Yk/rE3H5S6uH4c5t1BQbAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25753877"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 10:39:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:39:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 10:39:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:39:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRR6wokqgUxGOLYtPtp+QV0oBAd64CKiY8EydN1+iErYCUSy0HqKnsYZ+iSGun7F1iPaPkLqgDhmt/xg0HVG/xOQJE2ooCzlpqlGvuc1Bjt+0+GmbgbYDSisJ5J+wC9/PnHMXpTsvHlGO7a2dJ6+68tDLkqBTRSqkPrDhjC6TAy+xjxX6qUbdhWI7rst6j/AJuTMtIAUA0XZ6OYl4GPWbf3eYwBMl4K9Fw5TlP/uTXPoSlZ9+dyeuSCsnDt2DOks8x/3AaeOJBzgiby4IyfWkLQoAYRYna93tf4+zCoRdz9m8Q8cmet4yvjHq9Po3PxS9JpJMGb11XA5z1QpnJiEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apUUN3SFVhiDGefjFH9EGsWXdIzgTY4wN8iE25OZxzo=;
 b=gR9jtxlwrUWuQrryHwFmizCQvmJGUpXDLULWWKYWSvkWXAMWO3OhYgoeQyx+XhGPO7R+XLAUGsQecq+s+yFo6bwUya6ORlpNz2HR9BiKz4MDW23h5GlOhUI003yPlWfhX+qMm6Gq6OBRiBR1/3VMRR4Ur8OWnDvrMBU2fHHs65X5IcLcgv0O32nqbO/Ldxr1xz1v9lUQMKke0/kLcrqH592q8ltKk5EOuCLsEsv8P8FsV7JwAjbpq9gIk5bbcX+w+Zg2lL9jNI7wtYBCAckRA6+2GSq3+UbH/vpDgmpV0KHn8kjfm3/re+EoT9gVOqb3RRerRXmFDjySJOpbKkQEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 17:39:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 17:39:09 +0000
Message-ID: <c96cdf6a-02a8-4ee2-91f5-e4329015e276@intel.com>
Date: Thu, 11 Apr 2024 10:39:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 17/31] x86/resctrl: Move mbm_cfg_mask to struct
 rdt_resource
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-18-james.morse@arm.com>
 <966b7b32-6600-4b1f-9535-0298fedd57a7@intel.com>
 <Zhfwzh4sHvTYyTJ1@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zhfwzh4sHvTYyTJ1@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:303:8f::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 733cfb7d-b885-4206-da65-08dc5a4e4b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akPpqCBs1k0ZHW3U76JqJx/nKAULQo3aUH+6MBpT+Usj+fQo4EadAZ9AxIPc0FdvIYprV5YIQXUxs3yO3i8ajqKqhQDJKZJXXchznoqpJ39rFiNIlaeuj0Tz3XqF0Nrshb/lbiwbU7/AKpGHDXXvve/BlVwqjLporDFndKv4PcFeBBxFTxAybdJhbCxzij5xTDTqu9glreDBPBKVEvnXKBo0VwL6Nwr9ETBq2FpNytWGa1qOxPlfHKMdf7LuccSHizvYlvoavJRytU0PWGOlal8VfBGlNjoC4AEzXxU9BMzbx9aYEcDTxKnpHG0Wtx5EbjJTrAROx0aX2u3kpTQaPGhJ39V4b7gV+Su55eUO3gWkotWUnpK+wenDkuYY7J5AjBFozmz4qCZ3IUSZhUrGqSdrEJNwKDhrx1tLtAXJAc6sV4E4jD6o2jAv9ecrKRetzh3Y5JHEbQFFXaOP3+Smq7bU3PXyQQBqIXRvg8Ym+J5irNfssMnEIlR/hIXkUqfba1twlkJ4b/Ze/+UjkaZ+kn52zJputQJzVHNy0Wuh+tWBCtQmQyFBW7PYSjcl97V8RK+FTSFRLNTNwrEXs4t4EqnAty5jHDOcYczUeXngi9fw9dV3ARKijg7HTmIjKNzCF2U64+k54XFy9Ze+9WlQ1aA3S68KGMcR/v6r+mymtx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1Uza0NCZ0FGVTYvQXZjczE4d3pKNTRyTUljeWZWYm0rTXYreU45VGpoemlm?=
 =?utf-8?B?Y2pJdG1TVW8rcjZ3ZFpOWFVpeG5nWW9mcWhUUXJnSm1LQzIvQWcvTVdNcXlB?=
 =?utf-8?B?b2tiYXlDUitqbHJiaGtFWEMwUzZvdm9acmh6a29PcmkyeW5mNi9RQ1diWUhZ?=
 =?utf-8?B?dGpZUXo0UFdROG9iekc2RFdRZUhKZ3dPYmFOdFZyS21icGZzM1J0YnlzM2s4?=
 =?utf-8?B?NjZkZElPWHFIWDJRVHMxUFpCRzJKcFJIdVRLNU9IQVp5azJFSEVFV2xXc2Zl?=
 =?utf-8?B?RGZHbGdYWTBWV3pCdlV1dDlubXRXUGdSTnRXQWY1dHdJWDEranh3SnQwZncx?=
 =?utf-8?B?cklrYktHc0tuUGlaN2IvWnh6bTZRZW5mcHhvUmI0Q01tSktWZ2ptb3Y1VDk2?=
 =?utf-8?B?Y2F3ZGVTVjRCSXJaMUt1SDFvN2hieHlFVVRPKzFIL0xFVm05aWZwWFpYZWVX?=
 =?utf-8?B?R2xvY1BWdHhhb2FxUU45OVY2ZUJlbXVqelBrRWxzTlRNMTVkTytpdWxsOGVt?=
 =?utf-8?B?eWszNi9rSlpvcDRHNTAzZ1dBKzhQdmZwSTRpS2dFOE4vSDRRcVRKVjhNRXBG?=
 =?utf-8?B?N3RMaDBZbjFIQVF3ZXpqZXNzbGlaVzZaU05FaDcvNmlIbkwrbWJQMHhMTk5W?=
 =?utf-8?B?bGdxd1J4L084ZUxtYTBJWXA4N2tEMFR1RjZyZ2JiTW1hVnYrb3E3Rk1GNktF?=
 =?utf-8?B?alhCbHh6cENCNHgyamYyQ2lPMzlmRW9oY3NzdWNwZlltL1Q3MUM2bjREY2cy?=
 =?utf-8?B?K3lLOWlOZC9XS3IrM1FVRDFDMTZvTy9vZzJlM2RCOW5lNHFWV2xONVBIWkxX?=
 =?utf-8?B?ZDhUL3lnVlhkaU5pNnpUN3FsYTA5cVFybEJMT3RjU25tMjZNOWpWSFgzckc2?=
 =?utf-8?B?RnZzdnE5TXc4cXd0ZllNWXFMR29NZktTWVhNSG5RRzVLZUhVMGNPYW5Qa0k2?=
 =?utf-8?B?QkJFMzltUDlHM1VlcmF5cGhGbzlEdjk0ZHQ2UDdtVm1BK2c5b2FKenlHMDhF?=
 =?utf-8?B?dng5RXNaV1JkYkttMWxES2tGeHM4TjJrUmZSY0xvaUVLVnpBTnUvamxYbVQ1?=
 =?utf-8?B?eDZIaWZQbHd1UDZJMTdqamFJYnpsUy9mTDk0OFpPR05yVGpnRUhuWXp4RjJY?=
 =?utf-8?B?YlVaQXRRREhQQ3ZYSUVkZzZBczBjcm13WnFXNHFxRzFZWUlLRzhjSnlDQnlV?=
 =?utf-8?B?TWE0RkU5MDE2T1gvMXRkVDhld2VQYWlNdWxtK081S1k1VFpWdERhQVc5K2Jx?=
 =?utf-8?B?Q1BaZmpycFJFYjBlRzUyUjlMam9QR0tYVDUwbDh5N2sxY29EV2czUXpFVXZT?=
 =?utf-8?B?NE9WMHFJelJHSEtJWWtqem5yZk14aENPSUN2NzY1ZkFqYVlndzdzbnVYUVgz?=
 =?utf-8?B?TGY1TXlGTFN2WGJydnNITU4ybnRMVVY2dFZVbU1BSENZLzluY3R5U2NvL2Q4?=
 =?utf-8?B?dWUxUGdyNmlqQ1piTGlrbUoxWEdFaFlLV1hpbzZ5VHE5TU9aYitjOVhtSnp0?=
 =?utf-8?B?SnJ0aG1WdVplR3duYThYQXlPMG1wNnVSbXNhV3NRcnRoOVpreCtlakp5YWJD?=
 =?utf-8?B?VWtZL2o4QWtub3FvcUIwWDZrc1Ryekh4eHk3SXgwYSsxRERwMzlkNEZhOG1T?=
 =?utf-8?B?Q2JuNzByZnhweGdKRHoxZlJJZW1JYzBJT0h2dXVxVll5QytEWVdBVHAyVW5a?=
 =?utf-8?B?MnZFalg3S2ZsMEtQTEN6bTNwK1NrbGlIYmNaeC9KSDZYZGhpSW4rZE8rKzd3?=
 =?utf-8?B?bmZOVXUwalVQNXUxWUtqTHEvd1duYUJGUzNWbWpwRXZ5eThRWFhpZHhNVk1G?=
 =?utf-8?B?R0l3QjMvb3AwV1ludWV6YzNKZFhzR0ZjWFNML1IzUzQ5bHlTdk9paTYxL1ZX?=
 =?utf-8?B?OW9Ba054eDJEWVNORXg1eW1Db3dFRmNHS3pWbUd2SWNnd24vdDZUcGZIaEVp?=
 =?utf-8?B?bnlJWlhpOFFCemdZZTUvek85ZUdHVmF2VVE0TloxbGZZaFYxYVNRS0l1QWYz?=
 =?utf-8?B?T2V3OG1xbU9ieUlYYU9vQWViY056MXBuTFBMQXBBT3dVTGgyelpNSTNZMG44?=
 =?utf-8?B?UjNJbEJVU1BLOTQ0MERSN3EvditYN0pYcTl5NXlYcTJzWWMxeDFiTVA2dWkv?=
 =?utf-8?B?dGxJM3MvVGJCd2xqUDlMam1uZ3dUQ243Sm42a1FvYUpadEU3bndKajlQdjRZ?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 733cfb7d-b885-4206-da65-08dc5a4e4b58
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:39:09.8899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjjW1hGNEGU/DT45LDm+v9uhMkBlbkMqWe8UrzFQYrniw91OD5C4tqLpyKk8L/Y4ainhXZ9OHBb5QlRyDYWDnYIjB6lH+198gCT+PQUwwaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
X-OriginatorOrg: intel.com

Hi Dave,

On 4/11/2024 7:16 AM, Dave Martin wrote:
> On Mon, Apr 08, 2024 at 08:21:24PM -0700, Reinette Chatre wrote:
>> Hi James,
>>
>> On 3/21/2024 9:50 AM, James Morse wrote:
>>> The mbm_cfg_mask field lists the bits that user-space can set when
>>> configuring an event. This value is output via the last_cmd_status
>>> file.
>>>
>>> Once the filesystem parts of resctrl are moved to live in /fs/, the
>>> struct rdt_hw_resource is inaccessible to the filesystem code. Because
>>> this value is output to user-space, it has to be accessible to the
>>> filesystem code.
>>>
>>> Move it to struct rdt_resource.
>>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>
>> ..
>>
>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>> index 975b80102fbe..8a7367d1ce45 100644
>>> --- a/include/linux/resctrl.h
>>> +++ b/include/linux/resctrl.h
>>> @@ -140,6 +140,8 @@ struct resctrl_membw {
>>>   * @format_str:		Per resource format string to show domain value
>>>   * @evt_list:		List of monitoring events
>>>   * @fflags:		flags to choose base and info files
>>> + * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
>>> + *			Monitoring Event Configuration (BMEC) is supported.
> 
> [...]
> 
>> Reinette
>>
>> BMEC is an AMD term. If MPAM is planning to use this member then this comment
>> should be made generic.
> 
> MPAM can (at least) filter reads and/or writes, and it looks like James
> is expecting to support this.
> 
> However, it probably does make sense to keep the comments neutral in a
> common header.
> 
> Would the following work?
> 
> 	* @ mbm_cfg_mask:	Arch-specific event configuration flags
> 
> 
> 
> I think that's broad enough to cover all bases, but I'll wait for your
> response.

Since this is exposed to user space, ideally all architectures would use
the same bits to mean the same thing. I assumed that is what James intended
by placing the existing (AMD BMEC) bits in the global resctrl_types.h.

Reinette

