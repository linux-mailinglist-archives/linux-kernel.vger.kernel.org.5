Return-Path: <linux-kernel+bounces-136202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C92A89D103
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927AC282F52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDAE56465;
	Tue,  9 Apr 2024 03:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNsOi2Cr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D3355E40
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633188; cv=fail; b=lnEmJkJ6nVArEFiJ4UmJjH1JeSDJXOlzQN6c+UGXYC70ztwrJKe1Fx/L26hBHKmAdnY404fs/sCTSmmv/y8N2vIUPM57IxyGO1fvIQoWDtuqO3kyfL8hL1zkbc1UMVlOJdGqZtT8fDWbTJFSaWa5ujqGHhE3LubLBwSpliS0Q3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633188; c=relaxed/simple;
	bh=iaJabRyu3FZ/IYk4f20gwSQz/x0IUzklFEaXYCq5TEw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N8zquNhHrqnLzqdcFMGBLorp1aDCvcOzN0ScruAxdKNA1LRNSeqWNr6VZ04vNsaAbPxwF+Bl/8VOPUwt2V0hU/nvnAi3ej9W02Ryo6fMm4gKLPNGjb1c+/bEp3/Qb5simcR+1nxOULVU8JXobTlexnjn9hmCLmLlWhMve9xh910=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNsOi2Cr; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712633188; x=1744169188;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iaJabRyu3FZ/IYk4f20gwSQz/x0IUzklFEaXYCq5TEw=;
  b=kNsOi2CrXXEJvVaIrug5gq5kYRxBEK4afKIus7FSAuLx5ckUWqwpm/e7
   YNHT4fBrB1MaqUN4RlNcT3uyg52iFRE3cTCK4atie3IvZU+yoiDyghfkF
   w2MA5O93ZEIAOTp2mdsnF0WQrQfhSINEYZV+PdDxmocSXB4F1/aysXxEq
   vvJs2P0QHplQWIIjYrJf9VxdcgYqj04mHN99zHRXLfzwt7gy6x4wGwI1n
   9K4pLzWVOkzIGKPwBniZ32LfJ0mlIFewWvOTQBiBskclzJ5WL5G98CC01
   eMVhNpXDhbpZFvh6mQLrF9Dr2Z+oXzLGdgPMYH0+Slt87VjS9rqViKv+i
   A==;
X-CSE-ConnectionGUID: 1XGxmzLdTaOZJ/PQpXXLyg==
X-CSE-MsgGUID: 3/6xzdVYRua2udTfcu5HAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="30426085"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="30426085"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:26:26 -0700
X-CSE-ConnectionGUID: Cvh/3ByWRFeKrqlr9s/6zA==
X-CSE-MsgGUID: Atr3PwQlQgSqOyl7TywZRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="51100377"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:26:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:26:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:26:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:26:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:26:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmrP8tLEPGFW7P2sKGr9qRej75AF9uTV7pEYzkLH/1kO+dt+5zcysy/YPIpq4dHSkbiv/OVuBkWItP6yUB8jEvhnH5+diyxobdzahsv4Oe6t3taa6J9Kgpo1OxrdqvbySCammkE0LEZ/ejjvfcvXY3kedVFm1t6BFTeGCWWpgL6n1mxgCybGlxtLOp2aH+I4/v73yKo0qNFia4Ln8kkvjmMwGxvVUe4ypuQ5x2lGWElbLXpdRudr8UnhfoEPp87v8vq13zS8MZMeJ/8K12Zw0vK1p1e8mkgGfCz/J8bkIKZiby5zh5E3bZEO35fhc7rzeZo8fBKH/0cnI00WuCJs5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMDttQ3ZqpDDkD3yiY/KTzLJcS9KwtVSTLMwfBIQJkU=;
 b=A+PvOeJPJtGxy/VWp17RoaGTYdIXzaoS2wIrhrxq9lHd8qCrnSRh6DhjsjoWftlWB+ABc1q1/pmdVEsNojNe0nMK8nVj8P6aHQmOzcyWArHJHlH8AJ0NS6XX+yLWWAPoVj6JL/QNwTzidcxYvEzbt9uHfVAly8G8sld0fNUj6erewd1wRyjYe6UZQZfiNesA5ErdiTqRmGW79MWL1Rn0IV+isKEgT7Cd1nhIs1G5mg46ZXdQU7on4AOrJ2KREN3WQ7XPT6GNll2pgzhI5S4SxZvISDRH6SZah5PeP5A2U124SWkUZV7AtfUhevKgXe7fKkWDA+jedGVvorr0J1emzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7506.namprd11.prod.outlook.com (2603:10b6:8:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:26:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:26:22 +0000
Message-ID: <7acf109f-d25f-4a37-9f97-c515346583a8@intel.com>
Date: Mon, 8 Apr 2024 20:26:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 27/31] x86/resctrl: Rename resctrl_sched_in() to begin
 resctrl_arch_
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
 <20240321165106.31602-28-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-28-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:303:83::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7506:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfnvSLA7wk70lhOcEtbItckJHupldsHKFwvn9OSx06h9uTwvnOwDrH803hYYFFeNVslmHLWMHUNAISxbkQXnSROh2RxW/sxwt1b+YNCPuWjXO6wvod7CZ5f8wypGdnbprb2+fDucaXc1xzvw3gBfTECIpvgSMOH+ca8Pvcqw+zZJ8H68kqD5Rkv2rYVhatk+5EtRmKtZJScdKX9ibSsgM/Emk7Zui3kkWCTiOZvggjqBhr/2QkvMpABiBY20GfNop7exZgaftLH5no/ky3PyBw7JzQaifaAiILrPMvhkDG+o5ZW0TvT6uc2nNy18t4qPqYs+deUCDMPvGWhwe+x1WyANLN9kqKlQ+Y/OeifbHFMn0GwNlg0VtS/SnliITrRx8wMQ8hLwrFxUt+PapuMZ2nfdknzbwkjzaOH4MtMADr1gYJIKDeVtRk+HSbdjGuukDF2ffGVb5XgbQhpDA6r5uGByOyB+NnRa+IaZrRN6MJ7pBl/Ly3s2T/SrRb58Ld0DGFtdPpiTnNQEK3dP8mwINdPRYHIZXwAKjO+HiTuEdxrphTU1WV6CTjlS8VnHQXUW8NMcU1KYC2PlMNVVnQoPToxFUsR7V/kKeuxhJ5sPs32AlJ7cUY9qZxEg/9iXyXsFsPkFfj5nmUYErSvTwFnR5cD/pEyLeuhtNwJXSdNMV1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czEyVXA3ZzVpbDQ1c05CemtYRktiSWIrUnloVjVSWHE1N2FDMGxtYVUwcGV3?=
 =?utf-8?B?SXRHcWl3bVo4SzcxY3F4b0R5NDdSMTNJMGc0aExjaDAzRUtJMlpYOXF3M2JR?=
 =?utf-8?B?V1QrSzZwaXR4NXhaS1lmdk94bWVpc2VsSmhqN1dRaFZnZzlabEsvUEdwTlpX?=
 =?utf-8?B?Y0xRU1ZvZlRnOUYrWm13RXhOT0tCa0xzTTJ1S3FOSVVCS2Fmc2NjMjVCbzJh?=
 =?utf-8?B?VDdvRVNNVzJWM09TTjZ5K1dCMEJEQmNIMWRXYjU4SmpnSE1yMVM0MUx6MHlP?=
 =?utf-8?B?S1BQdmhjUXpjREFzVUlwejJOWHNTWWREdmMzVlRpRnp6SGpvZjRHWWpIcFBS?=
 =?utf-8?B?MDFkQVRidzZTNFVhSHpESGc3SHlHSkkrUEUrdHFvSUZtbXJtRmRnT002cm1E?=
 =?utf-8?B?YUtCSnNLVlQ1YW9UcGQ1WERJWGk3eTViVjFoeFNWQW5GeVMvVHVPaTZ3aTVS?=
 =?utf-8?B?YXVnYkNVVFBwWGdsRnV6eGpwNnQrd1ZmWWRoV2lsUzdwbzJ5dTVScWlMbzRt?=
 =?utf-8?B?L1crdDg4TzVKamd1aW4yRkNhRWRjaEdmYktiSkpQS1RHL2RSVVFpTjB2cmVF?=
 =?utf-8?B?bmRxZEJVUCt5dmRmYUZnZnFhaVVTd3BsQ1NpVVAyREU3a1VBZVo0TytlblNp?=
 =?utf-8?B?STdZVGVYWUdmTGNkVCthNWxDK2ZadzZmVGJGdk5FNnVacFpLbHN3aXZMWmNm?=
 =?utf-8?B?TWdjSXdiaWIwNHJJdXZMZkF4VjZrekRPeFNTUE1lT2pUL3dxWDhGaXYwYi9a?=
 =?utf-8?B?djlqWmFXbTRtVW5FRWFvK3dsSC90OFYvWXhwTFFnbHF3VzJiRVJWSGJibEg5?=
 =?utf-8?B?dlpGSlRsUlRZdlRBaUdNSmE1L1ZNelFQTExRRmV6TkNnVmJYOUducEprb1FQ?=
 =?utf-8?B?eTlFbTBzd1ppVHBCL2FnS1FqTkI2K3REVXMvQXpFNTQvRi9NanF5Wkl4ekY1?=
 =?utf-8?B?SXZFdWlKb1RKSnk3RDJ3WjFuR2tyN0djSjRsTDRualRlTXB5bFhsS0NMVlhX?=
 =?utf-8?B?ZnhTUzAvaEFEUjFGWDQwRjAreTNWZ1JkZDJWa0JzUHdjQ2RvUlQ2b0pTMnM2?=
 =?utf-8?B?YTBqT2g3cG1lTmdXd3E2ejg2eE5DYS9ScmNZbDd3UUo4c1lFVG9MdDJlc01B?=
 =?utf-8?B?TEZzRU0yZDhYTjUrSXVWWGVHL1hXQkMxQ3RnSnhNbkY4OGxwTFJwa2xDTklD?=
 =?utf-8?B?L3BPYjdJTjlZeXhkbHZWYXFick5DVTU2cWZ4Y1I5bnlueWVBa21OWWx5WHFS?=
 =?utf-8?B?TUF4K3A1R0RpZGZjY08vaURKdTVFK3ZsSGdZNEhYdDNrV0RocFJLRnJOTjlP?=
 =?utf-8?B?Wkd3c2hPTE9EQXR6dnd5aTRJTkdtelVlTGl0cU0vNElnUE92SG9RN2ltSS9k?=
 =?utf-8?B?TVNrenF3cVl6bmt2RDFjVmdOU0N6bWpsZ2dVTU5FdmVpdG5QNHViSTFiMnpY?=
 =?utf-8?B?RTZZdzVZNXp4WmVpNnlIUmtnc0wxVGY0OGN2SDJzZ0EvUHBGcGp0aXZ3QkZY?=
 =?utf-8?B?VGY1VitJcFpoRStIdjE0K0xEN3g1VUhNaTJzVG03dUVMV0N1bWJaVGQ0QktJ?=
 =?utf-8?B?NGxLVEhRbm50NFBnaEw3RUQzQktvT1R1VHlXbHFyTjlzby8ralJ2RVJiTURU?=
 =?utf-8?B?RDdNR1VlY3A3L21GcUVJak1sMXlmWXRiSXZQSHFCVU9ROER5VE0xeWxrOWhT?=
 =?utf-8?B?UXcya3NWbVl5WER3Q0U0R25RYXMwREszaFdRM3EyV0srWEw2NklpcC82Rk0r?=
 =?utf-8?B?Mm0vVDV5QzBWMkdxOU5JZG5SSng0aFJZOFdDcjlZK2xBbmFWbjk3cDkzUDEw?=
 =?utf-8?B?dGd1WU9OWnJHMWQwL0JmUnNuK3pyazNsMGtXbk5EMWhoREVHQVlLZ2YwNGtM?=
 =?utf-8?B?ZDg1OEJGaUc3ZHF4c0pNY3h0N205VklBeDIrWDNqNERoVGtpY0hzelcyVWg0?=
 =?utf-8?B?a2tRR2svRDN5czhBeFRBSmFacXRVeElpMVZPM0UvbVMwbXBPMlZFUW1obG5t?=
 =?utf-8?B?SU5aWFVqRDdscmVqcE41RmlqVWxVMGlHbmo1eVhHWEdIenRKbWcxNDBkUDJL?=
 =?utf-8?B?WHFEcTlVaDlrWGpNdHlVYS9HNU1FdjhVbGJLTjd3RDJVUlpJa0pXWHkyV2Ja?=
 =?utf-8?B?MXRaS3I4dnR6amowT3hoOU5JeWtPZUlTZ1o3eEMySGlSUFdYaG5hYVdGd05s?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6cb2cc-39e6-4201-5aaf-08dc5844d487
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:26:22.7474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ao1W3PnVr/TWr95vtdvhB4hIjwhCk/W81PRijNg8ynop66Giry0B21gJcJDXOh7lsiU4olWAW/bXrNburLi1hAoWiUFQc8yPRtsan8hr4kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7506
X-OriginatorOrg: intel.com

Hi James,

In subject, did you intend to say "to begin with"?

On 3/21/2024 9:51 AM, James Morse wrote:
> resctrl_sched_in() loads the architecture specific CPU MSRs with the
> CLOSID and RMID values. This function was named before resctrl was
> split to have architecture specific code, and generic filesystem code.
> 
> This function is obviously architecture specific, but does not begin
> with 'resctrl_arch_', making it the odd one out in the functions an
> architecture needs to support to enable resctrl.
> 
> Rename it for concistency. This is purely cosmetic.

concistency -> consistency

Reinette

