Return-Path: <linux-kernel+bounces-119829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D3688CD6E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03EC0B25940
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9899A13D257;
	Tue, 26 Mar 2024 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRG0LXNe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D93481A3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482269; cv=fail; b=bJ4Kktgniq+tSz7tNLUowLMGe0AcCW+bd8nIQ+Xa4jq1QYz89eoftRBH2mrEStE5+nTwZHlgz53BKojHMkuW0SX2eN1o/ZoqI8GZ6rGeBdZPsG9YRRSN9GRHqFdgXEQRVuyURWvnPZuVVBqhOq4tMKnQc/lVI84mop49ooVhfSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482269; c=relaxed/simple;
	bh=GBz4gGWOvHaqVmOgawbdLMe32jv3dH7Jd0N0h9gjuA0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pXEPRvT6Sep8ryUu9UdGS0xMMz2zo7doQ5DMiNdDzMt2qyHiLvqO2ZLwKxPmyU2L5Jx68SBb0eGorBel6GCwp6RKu426iIx9PiKSW2RjncCgrsBUCUJUHJDQOVOcN1cOScKBiww5h3s92RHqAChzHxbxIz5uFISDHUex3coTzW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRG0LXNe; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711482268; x=1743018268;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GBz4gGWOvHaqVmOgawbdLMe32jv3dH7Jd0N0h9gjuA0=;
  b=hRG0LXNeB0O0icaqMVCqbaaoLBuR4uswh9s+Q8C12U9La5F75i84+rnn
   PFz67V/EmibyOYeih8R8OQdkZrlYgJYyWLw767FaN/eOnjx0Tz9qhkfBD
   WqSUSljfu+ijV/ikZ0/Ck6Y4e0ymcQQhA3c6suLGS6AgwBQJvTN+yyWmi
   wpCvmetcHyfiURMGuySgGme6iq4cnTZUqOxMqC6reScwvCNlYi4cn3Ytj
   T7B0D34NSiYVyreX/hMVk/B0uUvpLOCueT0E7cpACG+SqVKWJP3077CG0
   PZDvOCkRzuTv4Wi9enfUSG+oSpQkZnNcgptG7zk0bNzmoIiQMbRuAg7U5
   w==;
X-CSE-ConnectionGUID: pUPsxgQOR+Wqy8iluFjHGw==
X-CSE-MsgGUID: NpaOg9xlQTqVfMHg2hhkYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6385118"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6385118"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 12:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20606340"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 12:44:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 12:44:26 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 12:44:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 12:44:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 12:44:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBJYH0tOajF+FmNifQE6dDy/27ShPvNrByZ4CxP9nkQstU4EKIecLlwUScYIeYYQejGC19qbw33XdlUmpZUNnHCxeKonB1DkgefknWuyqznDovETOnUV6SaPszTxf8874cohx5pC/CmU4o9vWfCk8P3MdaQtqvFDyh2SKVrOo8f6s43EBIjNMMsyjhAMRuTgQhGoIneTpFM76TOo6YjKQ3zTX9lfAcokZPCHSEjL9j6o18mJaLMWNA27yLrIw+93hnKXxVlSbfqcAEWrM35YnJofNhnLwHz2dyU2OBpJcGxqVoAlCwIx1eBvyk3shYMwKxrLnNTFWTaWjge3lIjSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmWcdkvq8TrG76a9oL5VWX2jLbFFAoGeMkVa+FLf6D4=;
 b=BrJO0Pb8lVTtVr14IPQy9yOmDDC5Ey/CbHsSANP0Gcwyw76qIggR/FeuARwjIj9TmOYdt8vKQSPEtdOr/x6NE6YSXaz0NBwuiv/6xfZvx4SQwNylGk8/9KJVWbZwdMNqmhzOVAyNtRLG8i+wOwDBOJn1TwVics21U53xKxJDnrrpBjawOTgPTLeXwFN6VwouWhZ/wKA63myI9t2oh397HpxP3W32Jq7Rq/JblE9xO3f1kXxEwdrwCsVEFSsVy/We+rDqm6ZDNMBnwS7tOKs41Rdu2ZsFR6Fr1vb7O2+gP4aBVTPEm4w65o3CKpy+eNr2XIHO0StiS9CEk40IuS+A0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA1PR11MB8595.namprd11.prod.outlook.com (2603:10b6:806:3a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 19:44:17 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::12a0:a81e:3093:97d0]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::12a0:a81e:3093:97d0%3]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 19:44:17 +0000
Message-ID: <0aaae9ce-00ae-cd0b-ed25-4d52d1620ab5@intel.com>
Date: Tue, 26 Mar 2024 12:44:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v1 31/31] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
Content-Language: en-US
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Reinette Chatre <reinette.chatre@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-32-james.morse@arm.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20240321165106.31602-32-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0044.namprd08.prod.outlook.com
 (2603:10b6:a03:117::21) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA1PR11MB8595:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZVuad6fo8xfylfWStF+x0fdOCkPnikmtSDS1/JQYZLA4U5ULQc6to5ss1jB4M4s2o4u+zBTQDFOUHF4UwCPDge/ieu7uO7x3bZa35O2a4D85c4WQIQkrwqFOO4RxXFN/pkBvbT1ALd7Bm4kjeQK4syc8wk4caD4ZIMNMbWXmYo36hAnXbx7yaC9cCaCkwFjG8TCQUGtPeGALHiQc+uhtsQGvWabspOf3kRErTEbR3kAKLj56qMKsSoKUnfvVsFOKJjDbqDrrX1EYQhENCu1BjE90yHsdPRmG1YFPnn9Edc8JVbVREWBTiej8gkxuU3xDrAvXauIvTGqGjBYKohVzTbfhRh+QzRRBlfdMohPxJQNykf1RFxMrXzCTxllDs40HZjzn+gUb/0g5WGBm+CD04fVX/XnXwNUjS4KwO6vy3zZAJbK1kBDmimQmVw8ZlgvL4IWxdGEWI9nq4mxAialkmJBBL5GwOTD57kRDB3aDFEtwTrTyZL44cShwl2ghsSfFKfAn+W+ppjUzhpxJn+LyS7oaT5ETiYae1lsD02/bw053uSRHwkBqO6BmAaNV/AoWCwOzvc0ED3s6wa0oSwGKgJOjpRnJ52c+i6FejHEksBJ1SSczQHHE/1teC8yFrr05IRmXI0NA5qhZ3SPxp84DNg+rveReHdlqBAkxtCDc8Ig=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWlhT0lDRlZQQzVxL3ZxcER3N1V2YStEejZJTHlCR3ZQOXFIaGlYZ1pIN1Br?=
 =?utf-8?B?MWhJVGlDdFkrS3VLUG1rNDVlU05UMFRZZEQrNzlMOUwvb0NPeGZWWlZENWJX?=
 =?utf-8?B?MmdjTHhNM0I1WWVFTkFocm5OYkhGYXRQR0hPNzVla1ZSWmNYdmdwRVVVZVhm?=
 =?utf-8?B?dmN3cFdjNWgvekFTTklzZmlzL3JydjN3V1VyRnhkS0RFTWR3VUltTDNQdlBZ?=
 =?utf-8?B?WXZRZUtiQ2J3WUY2UjgvNWlyTTNaNWRET2lQZ0hMRTB2bDMzY1NXMG9aSTBr?=
 =?utf-8?B?N3MvbThlc3pUNXNIMDgvOExoMEZxMnZXSnRBVmZTNXVHejgzQmE5Q1cranJ4?=
 =?utf-8?B?cHlneTBNWW1DbTk0Vkp6dXRjYlFNM3RtVExKRXc4VUtSSTRoelhzaXNrVWRU?=
 =?utf-8?B?dUpoREdUY3h5bVN4Zlc1VmRJRVM5aDdOakltZDZKOU54V1hWaEh6L2lLMVFN?=
 =?utf-8?B?eEM3THRtdWpLS2xIUFJzTzNjYnVRSEN4Y1Q3UVgvL01BT2orSnZqRWJjeCtT?=
 =?utf-8?B?U1Z0Y1U3QUpLMVloTERqaUpDaitoQWdWN1hoNFFsamZYc284dUl3SWdBOXNC?=
 =?utf-8?B?Skc1dGdGVmZsTGxGSHYyYXMxSlg3cnhlR2c2UVpMTXovdFFIdStuQmtaRWZ5?=
 =?utf-8?B?Um14SHJHYk1JQVp0SzIxQjBoNUxrdDdJK2NiUXluSEsvNWNWQm1FNkZjVERu?=
 =?utf-8?B?L3ZnNkN0ZGZ3VVVnL0hpRE1LMEozN3Q3dGhLSEZqQWdXSG1DM1NaWjVtQWha?=
 =?utf-8?B?blJ1bUFkdDVROHlUbDVHS0UwTjc5ZFZpSXRFWW5uUUt4c1BhTDVXOEVqd0NV?=
 =?utf-8?B?Q0dSeS9Od3FWTlpYb0dSR2I1NFU5MW9aQnlpYmxkN3pwUTZqT2FnNlE4ZDNX?=
 =?utf-8?B?WGdJNEtaREd6VUNYMTBMSGxQRkdoUW9JTTArWjFJaGdORnRUaGF2KzFlR2dU?=
 =?utf-8?B?V1NvMWNIcmRUVVlDb1N5SnYvdS9QTTJlRnpKaGdZanAxbDJhVUk5RmpidTU5?=
 =?utf-8?B?TEtEMmIzZUliL04xay9LZG9IeGltOWg2YkJNeXd3eFc1TjZlQWJSWktsNWxQ?=
 =?utf-8?B?VVYzaGE0MGhiSWVaV1JzeStoWlBuNVlKSUp5UVBOS01sM1hPSWJsUkFTaXF6?=
 =?utf-8?B?WXZJR09KVXhPVnkrQ2ptV2trNkU2NXlBeGZxVGhqVHI0OHZNMitvRlRpZHJ0?=
 =?utf-8?B?b2dKNE92MnkrRXlqSGN3OHNQSXkvYWgxSFI0bjZJakxwVnZMNEZsRXpzdnBo?=
 =?utf-8?B?NGpiYnFlVXpjYzdZYlg1clJ6MVFxeElzdFI4MUxGcXdzbUJYak0wcGNLeWJo?=
 =?utf-8?B?SGl1S1NRMFFtL1o1RjRVWUllNG9CNW1HZHNFRk5tZituRnVTY0UyTXdVNzZk?=
 =?utf-8?B?ZXpDZlJlcEh4OGc5bmdMT3p5a2RFaHordExOazlCL21uenJmRVNJY0N4OFpD?=
 =?utf-8?B?cnZyTXRCakpKV3hPdytLUGVwOVBCdTljOU1sSGU3a2JPSHFjVnZFYmw1UXZI?=
 =?utf-8?B?SVRnbHh5Wkl5dlpxNWtqWitlVFBUMnppUkY1dmd4bjBXSXcvOVdoMWpwSmhO?=
 =?utf-8?B?clBhZC9XLzFHeVI1YjVCM09uOG9QTE00UHV5bmIzaFY0SEJCL3RBNllSMmxj?=
 =?utf-8?B?SVdwbU12RkZhaXZhb0dTYlZvRkVQVDAxS0NVMTNwakFPOHZ4b1N3dXJ6eE1r?=
 =?utf-8?B?RVNOdS9paW8vZ0tqZkVWbklla2hoRHgxd21UcHdDOVY2cnA0R0tscHZsTEZD?=
 =?utf-8?B?dUhuM2RZaFI3ZzB3bDJoZkFmbGN1NWRPRm8xdCsvaFNkeWdvRFNPZHBIWEN4?=
 =?utf-8?B?MkdtR0NmVTlDL1ZmUjBPeEJZekxYdUR2K3MyOFcvVWllektYV0EvcGdhQXpP?=
 =?utf-8?B?UmdPSm1TdkVOY3dvdzl5Y3VXMWlTek9RbEZ2R1hkMTZpMFdXVzVJK29nNFEz?=
 =?utf-8?B?MzdxejRuZ2dxU0R2UnNpWWZOc0c0cUhsVVhYV2tjbmtVRnROZlhpc0Vpd1lu?=
 =?utf-8?B?dzQwWXJlNVR6dFpBUG9DVHlGUk42cHBuWi8yU2l6cFErTWxGeWFaaFNDYmpn?=
 =?utf-8?B?MU5Ub3Eva3pDVUlkMHZMS2lvQnFEQkJvay9IbzYxaGJQMzlJQlV2VTlIcFJN?=
 =?utf-8?Q?uYztoPQHWt6thhl/qfbcPnoES?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e209c4d8-7dc3-4f38-6076-08dc4dcd1f4f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 19:44:17.1340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BOQqD72pgYxyg8CRRhCp9qqDVu8xVH0IQyendaucEXXN3Ye5T+SrBTqlCbv7Qhdw6Jskde5/EfdnKqvjSdVWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8595
X-OriginatorOrg: intel.com

Hi, James,

On 3/21/24 09:51, James Morse wrote:
> resctrl is linux's defacto interface for managing cache and bandwidth
> policies for groups of tasks.
> 
> To allow other architectures to make use of this pseudo filesystem,
> move it live in /fs/resctrl instead of /arch/x86.
> 
> This move leaves behind the parts of resctrl that form the architecture
> interface for x86.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Discussion needed on how/when to merge this, as it would conflict with
> all outstanding series. It's probably worth deferring to some opportune
> time, but is included here for illustration.
> ---
>   arch/x86/kernel/cpu/resctrl/core.c        |   15 -
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  505 ---
>   arch/x86/kernel/cpu/resctrl/internal.h    |  310 --
>   arch/x86/kernel/cpu/resctrl/monitor.c     |  821 -----
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 1093 ------
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 3994 --------------------
>   fs/resctrl/ctrlmondata.c                  |  527 +++
>   fs/resctrl/internal.h                     |  340 ++
>   fs/resctrl/monitor.c                      |  843 +++++
>   fs/resctrl/psuedo_lock.c                  | 1122 ++++++
>   fs/resctrl/rdtgroup.c                     | 4013 +++++++++++++++++++++
>   11 files changed, 6845 insertions(+), 6738 deletions(-)
> 

checkpatch reports warnings and checks on this patch. Please fix them. e.g.

CHECK: Blank lines aren't necessary before a close brace '}'
#13340: FILE: fs/resctrl/rdtgroup.c:3184:
+
+	}

Thanks.

-Fenghua

