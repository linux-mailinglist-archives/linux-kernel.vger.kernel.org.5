Return-Path: <linux-kernel+bounces-137153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD2689DDAA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146D12847D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D5712FB38;
	Tue,  9 Apr 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiZzktok"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87522EAE5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674962; cv=fail; b=MOdyT8SIF5eoQV+9dPKIjVAS36e5t2riU4Roj3gCpDKQG8+PpiOLeWymNdpNz/+X7aboBlewMIVq2x13t9S+6iylMWPkSALIKETxNKy+Mbr5BFLHNw3V5blYTouTg92C4nFEZ5S/+PcX8oEbs2/PItAGKQU/gwXB5kE5h7mD52s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674962; c=relaxed/simple;
	bh=3Pk3KhmPBzfW5swxHWXb7+mAmxl7vT66flAnd/EqwzE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E/v2gq/ssBrd4aKtn7BHIUZFAACrokl/mnMc5HxvMBaXU1WhDqxWhNRbD5SAjfB/snSI88WdaZJdRMuyQ5zhYauFKDFQFkKCW5f2knxtTjhsygtbhO5Dgl0fnWRwMf7YKrutWtooeh98E1F8A2XgDcKSF3NEvmvi+zCqciwmVmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiZzktok; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712674961; x=1744210961;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Pk3KhmPBzfW5swxHWXb7+mAmxl7vT66flAnd/EqwzE=;
  b=YiZzktokO/mKnoIeiDND+mxtJjtabdBqF2xKbRsMsfwsOtqxyecZp9BK
   B7L4doY725yZpgcjUzQ2LHHzaDIzDskxfk/JM63V9V8mALoX8PlPRVLam
   JEsQ5s40jvukUAtRVIpBdlQraY/m4lDBPSjPby155VKtwmsRVh+5ot5YJ
   FLEBZedi6wULTAxIQVq8Oy7T+A/LMZFBwVH2xWm48CS0yX1HDjA3JJ4Cn
   DqOBHnCS1oo25+/0A/u07bOILwvmT/iMP0IHSC/2s94BOvsTuIFYhPxYK
   C62UB4XHKWTUpkehGwuk12IHBgqZWuRzDxav/7O/tKZzYZ2UWD+kFy+lh
   Q==;
X-CSE-ConnectionGUID: Jw2ORJxSTfKBSsMlJ0L/eA==
X-CSE-MsgGUID: kwLZbyxmQ66lOAtC9/H7pg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25435535"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="25435535"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 08:02:34 -0700
X-CSE-ConnectionGUID: G4heJPDpTG6tjNv+mz6jDQ==
X-CSE-MsgGUID: +icUapMeRTSnrjbD5X+Uhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="24735496"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 08:02:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 08:02:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 08:02:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 08:02:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2vCqSov7qWfr1Cx7rmfDRTkkJdvw2Gg3mO5xdnqQII5Yq7Iwsw/yuE7ewW7JuyY0H+zon7X9cuTwzGTCH/PS2RU4i7/+jc7C2KIMwFsL0e2f84jjzV+mSL/yGVG5Em9/Hqg8DAWtlxWr72S0eq0vsajrFoK6sUUW2cvPZwsdwgld1tQmzx5q2a42+xBderOcHsXQZpDVgET8nOLNaUCN4/0wN0PLbkTRML8fyHA3S73CwuOPy6PaA/fsrFHoPPNynC9Of9XTv4zF63NAS5bSCPMf1B4NliQ+IIplpvux4ENSsQuNk20IL2m7poz131uDQbML8n5AGElXGqH3ltLow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0Z+sDZIr9QmbsI/Q87CY9pEQ6mzH50lU3akzchlCtU=;
 b=VRAs/cy0gwYtx5GCgOcIOGguFSnTkNcmARnYmPKwEFBlQkfMgOMP0AtfzwZHu/e5RZlq2NuGTLTm8o5HOXDvT4CqcYLO3K1KSWga7GJVuKm7f9/PCeyLf5612/C1ND7cZ/1ngczb5tuvvMAlpBjQdyWL2iRUt7vfRMsKyHUNsMEOCCD2Z80w0MEWlPoTDn5JeLOPx9jb/Og6P9fSX4D+aBR2b+JUf3eiXhJ6FItDhJpVhBEdJ1h5m2Kf1euTH5JopoqzB5D+tAqEPu0DwwAmwUtAjcGJTq0Ma13TD/pS2SIrwE9FX+Nzt88FrtaV/teZq18jYg+J663qqaVtqwZRyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5006.namprd11.prod.outlook.com (2603:10b6:a03:2db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Tue, 9 Apr
 2024 15:02:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 15:02:30 +0000
Message-ID: <8d1d39ca-60f0-47e9-a090-f630c6df19ae@intel.com>
Date: Tue, 9 Apr 2024 08:02:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/31] x86/resctrl: Fix allocation of cleanest CLOSID
 on platforms with no monitors
To: David Hildenbrand <david@redhat.com>, James Morse <james.morse@arm.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-2-james.morse@arm.com>
 <1e19965c-51f2-4f7a-8d29-e40f4e54a72c@redhat.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1e19965c-51f2-4f7a-8d29-e40f4e54a72c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5006:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fz6WLoQYdkvQTUQwtD2JJ1eIgOMzLzochwj8ZDgndLdEvImXi3DpJvS6lhAPVHdutV6INOo4a1PXi3IcZPNX7zfeHCQNTrEPAjCcDMfEuBChjvtSrkR5VnVWW8NWrT9ucF5bIGfs9aYr/6EG1/YPP1L7qGRODubc97PZtWZovtMvj2VwD7SmjchQBbhU9OlN1hMCI19vKK2aV8mNJ+2FpfL8e4zkwSojb2GlO5rqGGwVr++SQnqAvPjdX5sTXZiMRJirDUDzNCrfVLb87Wr3voQYbjwYfNO12YDjsi0416wajTLc9MrqbfIenkpKiEHXsGT7wI3prAT0/Iwd8LWtwJZvt1eJ7+UF0NU4PH6zcQueGaCs8FBNee/82ovNCPlGelrndXSseZMrp2bVm5goyoopwLpgNqIf2RJFOOKxeQNUV4hkJZOWN1WvViOtjyEENozK0KLSSMYJLEVuyZvQag2XOcqsoJfIZS5B3OxCCQCnINCI3068veTRnxFNF5H/z/Nfi+UdxMJ+2ZVJ3wuvjA3wuHkNV4dRfBuj6DKkZ/689DfxsmoOFY88kCCKZUevYNDK9NSJfC1DuWO/BazIfQ0U6+PFjkHdP7il+YnF0pFcms5MBoGJFAO7yHh7SFNsnankzIpxUgWlGks3OtAL6RNaNJYFjhBhUccnB/L6q6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGhDcHJxdFJ5VlNKcy9PSEZkYlVtR1NVeVA2dzBRbVV3RzVHS1lDazlZT1lZ?=
 =?utf-8?B?K3dpRUd0MWVmOGJjV2hXc0tjNnJWa0tEMzh6TlB0WGVHbTVMYzRoTDBWMVBI?=
 =?utf-8?B?TzBUNjFOMjBRdmpqWll5NXU0VzJEYThCRytWOGdmT0xzd0E0cmg5eUZ1aDdt?=
 =?utf-8?B?V0JkZmtlSE84VWFIRnp1eitUYWcvQnlEaGpsZU92eTJzaXdiRy8yWVhhUzV1?=
 =?utf-8?B?K1N5elBrMWNvVkdjUVpVN1FTNkZyb2pRdnJkeXhlQUlJOUJ0TDRVNG8yZndQ?=
 =?utf-8?B?Rk90UmtQZjdwMmp0Y0FvTjFscFFYYVhUT2VZOEY5c2d5K056TW1kME1zTDBF?=
 =?utf-8?B?bi9KeFA5dEtBUEFWQ2J1ZnF3UThQSWIrbVBuejEwSWdJZWtxb0J3czBlR1hW?=
 =?utf-8?B?WXp0VzJtTkM1UUxJUFliTFhYNXNkOWNUbmFHbmlqalV5MEtvLzFIR1FFQUtE?=
 =?utf-8?B?Q1lFUjdoWSs5U2Y2WlNyZWtZV0NtS0h6Nm5pS3NXNnU2cS9BWGdPNlZmVDhn?=
 =?utf-8?B?SWRpQWpydDl3MG55MUZ1ZTI4UTVkMk1aeHh1NjQrdmVzWHJVbmVVMjJCMDVT?=
 =?utf-8?B?cEhZQnVvM3VrRTNyeUJQWWlDM3laU3BFYlZjdlFSNXB2Z2NWa1NPbm9nL1VH?=
 =?utf-8?B?U3hRUWh5eXFsdDRlN3NvTzNlUlF0dndPWHhzcHBIeVFMUi81K1dMdklVK2Uv?=
 =?utf-8?B?dGsxRWs0Wm1wOExBOWlaTE9sUDR4V2xYZ2J6a1lBMlJKSEhUZHV0YVNPeHM1?=
 =?utf-8?B?dDlFWEh3OVFBTk95MEZPUWRYUjlUNm1tUHRRUU5jNmpXeDdkQnhhNHJ5S2h0?=
 =?utf-8?B?UGV0VzlsZ0tYK1pWcXhiVHM5bXRkMm9TVG1naVk3UUxtNGhlWVBJcTJkUzZS?=
 =?utf-8?B?T2dKS05vVjZTd3N0a3lHM3lybnUwenY5d1VlOXQ5V0lnSDU2S1lyeVBHbW90?=
 =?utf-8?B?aFVsbUhtMHcyd0pLVXU5Y1NhY1MxU0JvYS9FZk55ZTZRZ3NxUk9VbGpqMFpP?=
 =?utf-8?B?YmhBd2kySzdGRnl3MStJcjdZWkplZ2JwWU5OOE56M0t3ZjEzZmJxekhZVFEr?=
 =?utf-8?B?VHRNcTJDckNnSjV5V2czRW5oWEJ5NXRySEZyYTBFYW9Pcm9XSXBYR2g3RlBt?=
 =?utf-8?B?cjNuM0c5ZVZhL1kxUlBxcjd6RzRDVkJyNTlUYTl3MXNDeUtUVURSVGdra09m?=
 =?utf-8?B?OHVwYmZEZDRSNHZMbk5hN3U3RThCenpmM0RnVEh0UWJwdUlVS1E0cHJYa3po?=
 =?utf-8?B?L2oyRmx0aHY3UjJVZTUvL0FYNmRBcUtNQVVMVmV2eFg4VDhsdVBvb0xzbG92?=
 =?utf-8?B?L0VXa1BhY3daMmNwUHlmeUlITVFQZW9Wb0JQZGRGcC91d1NzeU9Xc3ZwajJI?=
 =?utf-8?B?c3pISmlhQjYxVGRMZytDVVV5WG95WUdhZkEwQzUyTmJ1aXlRWVpUQ2FBMENy?=
 =?utf-8?B?c05RR3dPWGFLb0RGd1R6c1dSTEtXWEZMRyswdGc2d3ZEYW8vTDMzV1Y2V01D?=
 =?utf-8?B?TWNTc1NKS2VxL0UreEdEWVBFcjV3OFF5aUdWTW84aXRVNGhiZkczYWpkZ2dT?=
 =?utf-8?B?TTRRK0thVlJkWTAxM1hqUGlZNWRnQ0hOT1BiMG9yQjdkV01jeXV0VEtGQmpB?=
 =?utf-8?B?S3YwVTFlUzVMS1lIWTY3cDVHbG1jVm9mbjBsTlZpNGc1NkdiVUJ1eGhYV1N6?=
 =?utf-8?B?aHJhSDJXU0ROMnozMVl1OE41VEt3ZmsvQm9GUjI3S0d3cWNsQkV4Z1hPT2ZK?=
 =?utf-8?B?S2JyL29VL2ZuYWNIZHV3Qy9xdWhjZmN5R2pXZ3V5S3N0ZkhIU3lvRU9RaGRo?=
 =?utf-8?B?c1VxZnVuTE1yS1pUOEJlSEpoTnptdUd5aW8vRWxaQkN5ZzVmVzM4ZDVQaC93?=
 =?utf-8?B?ckdBYUcrb1lKbEtwQkI2OFFVdC8valZsS1BRT1RMZmZib0ZBc3liZjBKRXBn?=
 =?utf-8?B?dFdMWkFkeUNyVU5kbGdHTEYxTmJQK1FNakQrWEtNU1B0OE5HeEx4VlEybXps?=
 =?utf-8?B?OUl5RkRrM2xqbkZvNlozWjJmQ29FSERDQ2tJeWNZSTN6cDhFVGdRM3ZGbmZC?=
 =?utf-8?B?V1dYeU5lbUxjdXRNSkY5YThOQ0ZSNmxGWjNhYzdrajZ0M2VZS1c3a3ZVbjhv?=
 =?utf-8?B?a0FNQWtvSHg4Nk9CNjNyODRxcUNtWXdUMDhreFhERmhxaExUNTcwb0I4MVQ0?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a0fdea-1509-47bf-a72c-08dc58a6143a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 15:02:30.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lK9G/pO7KM+dL8xl9pp7m13vZ2MQwvby9IuW6hVPz+4fcyImAgQVh/BUXZFKTsD6RarUQmPN9yq56Bv34xNrLRlJKTl/fRz0An4uhSbMMXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5006
X-OriginatorOrg: intel.com

Hi David,

(Thank you very much for taking a look at these)

On 4/9/2024 1:05 AM, David Hildenbrand wrote:
> On 21.03.24 17:50, James Morse wrote:
>> commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
>> searching closid_num_dirty_rmid") added a Kconfig option that causes
>> resctrl to search for the CLOSID with the fewest dirty cache lines when
>> creating a new control group. This depends on the values read from the
>> llc_occupancy counters.
>>
>> This support missed that some platforms may not have these counters.
>> This causes a NULL pointer dereference when creating a new control
>> group as the array was not allocated by dom_data_init().
>>
>> As this feature isn't necessary on platforms that don't have cache
>> occupancy monitors, add this to the check that occurs when a new
>> control group is allocated.
>>
>> The existing code is not selected by any upstream platform, it makes
>> no sense to backport this patch to stable.
>>
> 
> It's weird to not see RESCTRL_RMID_DEPENDS_ON_CLOSID appear in any Kconfig file.
> I guess it will all make sense once the refactoring is done :)

This is done later in this series where patch #29, "fs/resctrl: Add boiler
plate for external resctrl code", introduces it to fs/resctrl/Kconfig.

Reinette



