Return-Path: <linux-kernel+bounces-149521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97DF8A9254
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD8F281B75
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC1F54BED;
	Thu, 18 Apr 2024 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPllMUq0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAB54F1E4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713417580; cv=fail; b=GxIOFozpzcWpsflPjev+5CmGFzNEYrw2NXcvWu+PidnzaiE1P+NBrK4pJ5l59w1iDvyq1+UiGmeavpASo3+17F2TnUABUIQxLmU8/BdecEQFCkCxVHmnJDF5yu3ggR2DOtQAZnRU0RTr4yHxdaaaLoThWNehIIx07YaFLR8+dYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713417580; c=relaxed/simple;
	bh=S//vE/d3xpXAuCdwaStqiqlXdur7Iva7JTHkWTz7lco=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JQL5yC5IVHadUIqhfcHtxBXtQeiL2iYR8zk4Q70FA/nuol+xSqlO5dRyxZq/1/NhvJsUa1j4R+IB3C+6SHwzXXcFJQcTe+6okfWuDWqKS0QUSmyFMrx/thJDC8YTaUaJ2Q/TeIJZleosEbb0pCvoyZ0TEqNPhPJ5Migv8g6v9JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPllMUq0; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713417579; x=1744953579;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S//vE/d3xpXAuCdwaStqiqlXdur7Iva7JTHkWTz7lco=;
  b=XPllMUq0Jivao+N35GIJF+6BE+u7ylIJNR94CB9gMegcmx2JUFvlmKeR
   yoTofOvG4f5AlgYoJm5DY2rzqFm2UJDwOaWh1c4YtldH/7CvF9ZmrdzIE
   ibRGLHkW5MqqDAEytsNsaEz/E4J/xOkQSKIYe7+1fqRK91KxqfmdR9cf+
   vEP6fKc/l2z/4JWgQkhT2OntTw4u825AcLIbn/ivR7IvPQGAHXdZZxOBK
   gwKzyoQsV96M1QLjB6k0pSsSgZWIYuvWtaEvsuo+2eAWyJdiG1pUPUj7K
   juxAR/H1xQMPZ11bOlvhRnzgsywQEe2fGf2tj0ECwI2mrqVj2FYrypM67
   g==;
X-CSE-ConnectionGUID: PalM3IPuTm2J8/3G/kwb+Q==
X-CSE-MsgGUID: 6TKQ0OigQPS77CDcDHV7NA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="26449805"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="26449805"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 22:19:38 -0700
X-CSE-ConnectionGUID: OCfB5f4fTCKOw6I4PuhFRw==
X-CSE-MsgGUID: wZ5V1IkQSVSI7dMwZUY+LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="53789374"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 22:19:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 22:19:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 22:19:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 22:19:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 22:19:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8rSvClPtWdoxqu2YI9wu4rYUMdg5mXJYZRO+7myhj6WzdBV0pUtkvDM8oDgScPTtNGuWr02sJY68ZNLM8N+5q1LLYcECe98rvd5aTkUEumd6I6SNgu84v0ZwqlCuOTXn6XfJ30oOde3mjMo6UefHgdWgM9c2ryj6WUjEDU2iX/RgrKzfv6rv7ofqrN0q2nzFS9eTDT7MP2gWBvdMbXXTHkbkZYg9qx3aeSo7y0ll2LpalBNOz64qkV/vMaQDR+boDjezQhZP9L8pbKfuW+tdS6vC07LsWHl2WKAL/n/vfrcwWEpSH7+nK+gkpW1iiBmg1DqxkT0E9vALsq9ODhcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGEqil6tdCBvGPwYzLdOC5QSQY5xttRboM3fVtk6ijU=;
 b=FpkcEnsmhthBKKKyRIayhN9kgEI1qrrFReQ45bmOPcGLP1UleI7yiPd4K/f9Qrn5l6ikZlki44x2WvvEYSVfpoFSAcj3mXAV/PnFWnosgJ4SBhGCxuIrBXT+G1PB6HBkj2MbaEo44O1eO6QTx8nMN4a4yq7lohlazMU96ecaaydHlqSw9ZlEzlGNACH4BUs1jjLdjjC1VGSqvSODYFBf3u0vHBaAXMSsfJtJOwxWY1pFgAoCe36gfbC4r4MXrHp8JhnZrb7MJwtFZ3Bw7nCx8Jv1qoqvIabIvBej54mgLL1RoeEB33yG8kMx2cc4lzUXZSJ3YIYEfRFdLOv57+YZ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8004.namprd11.prod.outlook.com (2603:10b6:806:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Thu, 18 Apr
 2024 05:19:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 05:19:34 +0000
Message-ID: <ff24ac06-a983-4bb8-939f-50f892a274f4@intel.com>
Date: Wed, 17 Apr 2024 22:19:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 18/31] x86/resctrl: Allow
 resctrl_arch_mon_event_config_write() to return an error
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
 <20240321165106.31602-19-james.morse@arm.com>
 <d598767d-1c44-4417-9dc6-7078c97df39f@intel.com>
 <Zhfw3d3YCKu7PD3G@e133380.arm.com>
 <fbb116ab-d3db-4ab0-a597-980f85866db9@intel.com>
 <Zh/fxTLDAyUHTcn0@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zh/fxTLDAyUHTcn0@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: cfed252a-364c-4fee-fb94-08dc5f672229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LeXvawtw9g3/kx3oQ9V72pHzYR/anWZ1f5BzpzFr/WD4397feQbh+gBH+Q/MdH6L5niFhZdbyyOloQqp1lkoMJ3pMxJx+bJjhBo24csZ5SLScKsWzzQcqEJnCzDbbwhPenlsV5v3yHoEverfGqTSaVlZcXV20j9CLODNG9pUTfeNKdGec9de0YopW0y6p1vk6HMju6OXWqfbFq6lEjyPMFEQb4+xlLuCTXmEMHx0/l3Oi3H6NFTGLfP3Q5yrLQpmVUVT54c5ZOu9JDhhCTtKfLKyMSaAXy7jH2F6PUh3YBRkq8NIyRX88AzWYBv18YG9kL9ub40a0B+5zUJKPHR146xE2M3sQWOC6+lwWUHSoWqU5cyTSq1aymPS03g1i+pDo68QMv8PLbdoc3hstZg8InP3TuXJHmfvT0DzSFkxLC1Il+TGZzOjJvQaRQc46SLlvfe8YZ1zLMfNz5uQgfaHUx5mUML+fmDBVqf+9yw6CXhLClyMgzWC2w01IZsTHO4HFEaoltYsJRt/TEwTArn8Kz+BtaQWCf5FaJScJV6WUM9FdNIP5NeZBJrL3nf9b1P9a07qM9Niif7ATyAaqLKPYM9Gl0VjUAtpvU8YHd0uynQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlUwcFBtSG1lUGdEN1paeW1KUnFZOHFiTXRyc3NKeXlYTytJb0F1VlluUzI0?=
 =?utf-8?B?cHY3UnUwR0lRTGdBTnJWbU1seHpzNVcwNHFTNjI3U0d1RHlEQjB5WWM4eWph?=
 =?utf-8?B?ZE9EenozV0lVaFk1Rk10OXZCZVQzWUhtekRzQ1JtTjduZ016YmVYUXRkWnhj?=
 =?utf-8?B?bDdhMk5HSVhDU2tRQmx2dzBKdkl3bDRWc2ZRUXAxYlg2ZmVvMjRZVXRVbkpr?=
 =?utf-8?B?U2ViRzdDd0wzZzRCVEtSY3lrN0NsU3BKT2lLNlhxNVdIb3hMcVFRUGhyby9r?=
 =?utf-8?B?a0RaVFdwUGtKV2RreldlZ0FHVXFiblV2L2xQc3hjSG01RWsrTEFTalB2bGlB?=
 =?utf-8?B?Q1g3allud0JxZTdBNHJOd1BWaFNxcW40bm1ERGs1cDhyemUvVExSbS9yREVm?=
 =?utf-8?B?eWxBM0ZaVVF0Rml4UDI4UmYxeUdZVmZiaXV0LzVOS3VUL2dpZ1J3TFd2WUI5?=
 =?utf-8?B?Q2xYa1gva0xNQ1diR2FoOThOQk15L214OENpMW02c2VvY3M3enk5OTBvek5G?=
 =?utf-8?B?QWZMVmJuTnpqYUQ0V3o1M1NCVHN3RjNQSlpSVzZ1UEszdjRTQUZlNW16QWFR?=
 =?utf-8?B?b3NQdGV0SXhpcUtlWmUwbWVGc1RBNUZwUFhHWjZOSHZJaThDZXhCUlBmdUlJ?=
 =?utf-8?B?YWhvQ1ZkZnhLZzdJUzlyQ1B2emt5UFJFaUx0YlRIVjFBYjU0NWwvcGtwUDZF?=
 =?utf-8?B?a3ZFaXdlTExkdG55WEVFeWdiUjJDOGhlTGZMNXVQN0pYU3A3TFJYOHR2SmpW?=
 =?utf-8?B?bzYvdUpFQjVKRmU3SFdxWjJlRVpKM0Z1aUxyV3lvRDR3ZUZEL3A5WmxKRzVw?=
 =?utf-8?B?Y21vdjFUbkVGVGhvVzdUNzFadnkyZXUyOFJGeVVrQk5LTXR6UVRiMzRwVXR4?=
 =?utf-8?B?ay93dTNtenlORGRyYjBKWk9YMGkvYitQNlJ5a0hFN0JUSExKUHFOUHplbGIw?=
 =?utf-8?B?aTQvVml4U3lXK3J6d0dwM2lCcHdPUVkrTzV0QmNWQzN1WExiMHBQMVZ2b2Zq?=
 =?utf-8?B?dWVpMlo0RGw3RGZWdW01dkpRZ2UvQzJHaHpvd3RUbFpoMGpKbWU0ZWo5cjhD?=
 =?utf-8?B?L2RBSFRnNXpweWJURHh5ZmNpVjZIenNETlRGb2tMdDNJMzcrUFVlQkdRbExz?=
 =?utf-8?B?NHlDY0RJVFZPN1lhd3l0VjkyY1hHVEk2UjZRQlkva04wbitlVUxpL3JScHFr?=
 =?utf-8?B?NklNR3ZyemIyNUV2aVN6S0lUSVRlUXllVzdjcVJ1Z1h4NVZCM0krQVFpOXVR?=
 =?utf-8?B?NXNFdFJtNjR3NDRuRnlRQmFScStYWUFvVk5SMmJaOEVsV1FFbERUQ2ZtRmFv?=
 =?utf-8?B?NURWUW1jNjgzQ0hmaE54ZjRaWGEzU0VCK05yMGFnTHhoblJlV002MWVybStR?=
 =?utf-8?B?bm5jUUQ3UHZjMy8yZThGck85czlUUUg5V3NENlJGYWdhU2FIMUNqWXpaWVdT?=
 =?utf-8?B?UjFUNmZVN0E3WXRMNzB4MmRVUVpNZlZXVm83TFBjVHdZQ1VBY3pWNWJ0cXNl?=
 =?utf-8?B?bU9peFJockEvNGR5R2dCZmZqbEE5c2NNSkpTQzZFUStWRXQ1Z21oY01aWnpZ?=
 =?utf-8?B?UWZtOGlHRmt2aHlOZi9qbUVpbVpFbkFOYVpJWllqalNLVzhqbHcrNzhRcGdP?=
 =?utf-8?B?ejM1S3pHMmZVMGZZNHhaNk4wamFhT3ZVRWIzN0plS0NRc01mOTlZZmFYYklC?=
 =?utf-8?B?RitqYVdCdUJyQUQ5V1Z3OGhWTHdiVjJCVXVnY1o4YXArWXl1TEcxWFA4Sm0v?=
 =?utf-8?B?OEVoR0NvU0VVUWxIZ2crK1JZRlBLOU5UVGp5MnM2MmlLZ3h3UE9aWGdhcUpQ?=
 =?utf-8?B?QThRcTQ5STZvRVozd29EUHNwZzE0eVdnY2M4N3hlUkdxeWRBM2MzL2tncHA5?=
 =?utf-8?B?cVBYeElhUGZRVWNmenVhalF3eEpqdy9GenRXeXZHNGEzL3NHTDZhYS94R0Iz?=
 =?utf-8?B?TW9YK29yNDF5Qys0Y25GdHlrKzZYOStCQ1dzL3c2VU5STytBWnErV2U1b1gx?=
 =?utf-8?B?MlVJKzVLQWRVeVJkRFJCZnAvMFErZGgyanpTcWZFWGxrZ2JubWVvUG5mQXNG?=
 =?utf-8?B?T1ZBYjFmNEdQY0FyWDJwRWthdUF5clRLVU1sTHhmeC9ta2lCN1lUTGlLdFRJ?=
 =?utf-8?B?NWhWNmRvdTM1MlUxVHdqWTRzUlhlRHExaGYyNlgwUFM4eVdac1MyYVF4b3Zm?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfed252a-364c-4fee-fb94-08dc5f672229
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 05:19:34.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOM1fPiqNukpf8tYIi4USVaHcTSKshBqDR9d178FGDAJH9unSBEeaj5rOBBEPR+mUk3yLuA0SnUjRgEhPyhAw1h3L19lOVRVYZlv3oYiEm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8004
X-OriginatorOrg: intel.com

Hi Dave,

On 4/17/2024 7:42 AM, Dave Martin wrote:
> Hi Rainette,
> 
> On Thu, Apr 11, 2024 at 10:39:37AM -0700, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 4/11/2024 7:17 AM, Dave Martin wrote:
>>> On Mon, Apr 08, 2024 at 08:23:36PM -0700, Reinette Chatre wrote:
>>>> Hi James,
>>>>
>>>> On 3/21/2024 9:50 AM, James Morse wrote:
>>>>> resctrl_arch_mon_event_config_write() writes a bitmap of events provided
>>>>> by user-space into the configuration register for the monitors.
>>>>>
>>>>> This assumes that all architectures support all the features each bit
>>>>> corresponds to.
>>>>>
>>>>> MPAM can filter monitors based on read, write, or both, but there are
>>>>> many more options in the existing bitmap. To allow this interface to
>>>>> work for machines with MPAM, allow the architecture helper to return
>>>>> an error if an incompatible bitmap is set.
>>>>>
>>>>> When valid values are provided, there is no change in behaviour. If
>>>>> an invalid value is provided, currently it is silently ignored, but
>>>>> last_cmd_status is updated. After this change, the parser will stop
>>>>> at the first invalid value and return an error to user-space. This
>>>>> matches the way changes to the schemata file are made.
>>>>>
>>>>
>>>> Is this needed? With move of mbm_cfg_mask to rdt_resource I expect
>>>> MPAM would use it to set what the valid values are. With that done,
>>>> when user space provides a value, mon_config_write() compares user
>>>> provided value against mbm_cfg_mask and will already return early
>>>> (before attempting to write to hardware) with error
>>>> if value is not supported. This seems to accomplish the goal of this
>>>> patch?
>>>
>>> This sounds plausible.
>>>
>>> In a recent snapshot of James' MPAM code, it looks like we could be
>>> initialising rdt_resource::mbm_cfg_mask when setting up the rdt_resource
>>> struct for resctrl, though in fact this information is captured
>>> differently right now.  I'm sure why (though James may have a
>>> reason). [1]
>>>
>>> I don't see an obvious reason though why we couldn't set mbm_cfg_mask
>>> and detect bad config values globally in mon_config_write(), the same as
>>> for the existing AMD BMEC case.
>>>
>>> Nothing in the MPAM architecture stops hardware vendors from randomly
>>> implementing different capabilities in different components of the
>>> system, but provided that we only expose the globally supported subset
>>> of event filtering capabilities to resctrl this approach looks workable.
>>> This consistent with the James' MPAM code deals with other feature
>>> mismatches across the system today.
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/mpam_resctrl.c?h=mpam/snapshot/v6.7-rc2#n730
>>
>> My response was based on what I understood from the goal of this change
>> as described by the changelog. The patch does not appear to match with
>> the goals stated in changelog.
>>
>> As I understand the patch it aims to detect when there is an invalid
>> event id. It is not possible for this scenario to occur because this code
>> is always called with a valid event id.
>>
>> Reinette
> 
> I guess this will need discussion with James.  FWIW, my impression was
> that the real goal of this patch was to allow a bad event config to be
> detected at cross-call time and reported asynchronously.  Changes
> elsewhere look to be there just to make error reporting consistent for
> other existing paths too.

How do you interpret "bad event config"?

As I understand it, this patch only sets an error in one scenario:

	 	index = mon_event_config_index_get(mon_info->evtid);
	 	if (index == INVALID_CONFIG_INDEX) {
 			pr_warn_once("Invalid event id %d\n", mon_info->evtid);
			mon_info->err = -EINVAL;
	 		return;
 		}

When will mon_info->evtid be anything but QOS_L3_MBM_TOTAL_EVENT_ID or
QOS_L3_MBM_LOCAL_EVENT_ID? 

Reinette



