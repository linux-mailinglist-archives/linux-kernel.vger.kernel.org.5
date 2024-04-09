Return-Path: <linux-kernel+bounces-136183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E46C89D0D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9DF1F2552C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9F975803;
	Tue,  9 Apr 2024 03:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lu869kEL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB474435
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632577; cv=fail; b=NXU96te8PBd23veIAVgId3mHyrD0bx9OB8z899KGdlqz19gG0Jpc+uqjCR1hLeozwMMWHZvwzdPsQM/2Z6HhEGVdxQqpRvSd9UTuZ5vLYlKuBR/F/iTJo6vnk8q6m5Ha/LjLCBJ/vZSt5a56TcFWYZzD85y6KYkAEK24/464P40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632577; c=relaxed/simple;
	bh=d2epLb7/cLAaLmgaT15NaLrqqlTd2W3fgXxkFFDrVBo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=brGjobpQIVkWcZd35MbVEZjdaN0B2RWYG2VGKc7Yflk3FDp3LOHVfvaMSHKzROtQOQMcMI0lBiBimb3gPO8Ph6FKjsSBndpxSNO3tn11nldl8qRqlVWixWvoK2308W7v7iXk6mUoNSpoywVKTlFJhb3fo8rNNaM9O83nxSkVru0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lu869kEL; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632576; x=1744168576;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d2epLb7/cLAaLmgaT15NaLrqqlTd2W3fgXxkFFDrVBo=;
  b=lu869kEL6qznKzAnwmAG8FJDlhaRQ35Znq+QA5KDtQVz2b5hF0AEImbR
   B+M7sbPs1GZuNEHQ0vZ1i5WgKAtz3nceynUkXUQ4wLz1zrwF3IlDdnkAC
   7gT0qzxYtop9gx0qxscS7sJvBR02ohzF+8I5jk4wXCyFKJC8gwqDVPFD2
   mjKfFr5QiNNBjQyCqI7K4pJVPdC/R8QT+YfkRNTqmrB7942mIL5ubNE3v
   auJXsxh/LTyevvFQkX2QNONSzTBSupLd1d1NaAa8i1Vhn34ZkRz4o2lYo
   /YgrMeRf6Wi3/A0R2SjjZfeSeeFD+cY5UpJE1DVKzczAswe442hXk9jAo
   Q==;
X-CSE-ConnectionGUID: 6xjoT2HnREuASP5rr4X06g==
X-CSE-MsgGUID: 7WClrirmQ4SbB4d0iu1H8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7801402"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7801402"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:16:16 -0700
X-CSE-ConnectionGUID: t382dTPmQYy0rnpQOvsrag==
X-CSE-MsgGUID: zjUpGiewTYiaRqmV8w6PZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="51098402"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:16:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:16:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:16:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:16:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:16:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyWVpA8gqhpqF+KNMg87nF8WUjJ9OhQP/YvZ4J4Z+9MdYeGVTOSy/LEVkUUz3RXCawZukLqqBciN6zaopUuwgy1udHLplilyak1+fw8rjMKkiWZR59vk9Kj7aHdAHCXZD/LEwdHd7nksVI0ARLmJHQ5jQ9NpPQrISpevoZ87e5qXgpfTsm4cfOqxpQn+K47nrJTrnnDGJD6UwrJtglNGLxbVYjtrTP98XI34s4NbhHT4Baye4sRM72sJqlLhSLSMEwqLJxWh3N1dzbkyZkrBFZsE9dARr+XFqq9YdDo6LsBI0lAaPuSnbLjux9fyX+9060cRRgzjGDsKaYZrWeSEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYfSTkhL3NzfD2sOvxuG6tbeJr/wBpOhEgzJmlOA6UE=;
 b=fS4XbQhBAVhQ7mlLXxYCNUXxsNWKOkQiUEQJGC6peQtJJTBEoWZwBBncx21jIxgajncNGTsTl3fBp3SXd/LyySozE3GJab/kwqbo61VQMW5dZfpWCNSo8sqEA3nFNznVepWV9jy3WkSovfwbq47ck2f2WEN0kPWGMs6H5eOfXOT5b4lkcZccnHGq+fPKZXNkJAq9ZkebsuxMujXaFFIytVRCI27ttkpnXQlwvofR3s2rzBxk2HtRKdUxNYrIsOO4ggeSJEm+GtWGtDMrWwKk8Ms4oyY54BA5XARRMlI5tH7d7FZOvKlZ0RcbajQSMOQbzWyi01WyVe/dXBz6Ap07Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.23; Tue, 9 Apr
 2024 03:16:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:16:11 +0000
Message-ID: <6bbff669-cbe5-4284-b64a-4825a541b35f@intel.com>
Date: Mon, 8 Apr 2024 20:16:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/31] x86/resctrl: Remove rdtgroup from
 update_cpu_closid_rmid()
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
 <20240321165106.31602-6-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-6-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:303:b4::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4783:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3N5F2sBwWYXVwEqWQ2+R22U/xc1o5B86+Kt7C7FgpF/Ul9DgdOKUgQIEk/mZol7qWzeZXiA6bbFSRcCOlh8axvwulilZOtpUWLhQlVgr8snGzxo1C8I661v/g+BxTjx/OHPSniO+W33VsQgn6k/YpoY1GYMwLR7M+oE2pNQ/+gFAF36bj/ztaMVVHRpES5vPU7sOJFp0SkxXn4yRDaq9z+ZWMrwr4qGHIQipUjQTTN2GwS5gSbTWa/U7R3mXM4fiPsvKxKWa4jbEEOdMxGgiZHYVMzTfMGSEHSVzeKx+wOrLFtaSwyHprVsmpeZRJYKzDHEs5EgLuPD70YNQcrAbfB33Yq9Cj0pUK/GyYA5wynvstN+K1ydnfzz8L5EiNPO+C232m5BcjmGpPH00JztrFP6wFwXuCQiPG5h3v5V+nBqCnyavDaxvqYRoJyeMGTN4QGDPVNpIvlhcYVRh3UuNqLrjcsOFyoKQWThgzIuHKBQPPgdA4UggtuKL8R1yZnBM2Z9CG0Ui5VpPW1ZQBpO8HL7lJDUBcfZsU3747ooeTwkgahDSbTdC3qhCGZBfjK7SBRiX5AyBcdr+dVtX2tr7L9lMMe2S4bq0hVhuoTAupU83PDRdPRJEexgQF+ZVS8i6nuXaVXl14HBTf2V1J3WJgVc9ALszA0g/YQ79H17luU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eCt4WVhONFRmZzhnTVkzc1VyU0NtMzNJWjIwVlR1bzROTk5rU0hzbS9TcTNV?=
 =?utf-8?B?QUtSZUhWNW0rdlZYMWJuOHlack4wcXZtNHYydlZIZDFSaHdvMFNRNEJOUlVV?=
 =?utf-8?B?dzVDOHNKNTR2d2JlRVVxQThodmkybTlIOU5YYlMyTFp1aXRYc0lIdHJIaW9O?=
 =?utf-8?B?VDBXU283ZnlodGl3a29wbW9QUTA1bS8wUW4zR1Y0endwR2FEcUg4ZXRiNzJM?=
 =?utf-8?B?UXNYRWlkVTk1NENXVi9Da3pscXNkWmlPcnU3dzRXSDVVRXpkdjczVUtBdDE2?=
 =?utf-8?B?TGZ0V3BPOXg3YmNuVFFGcGFPTHJPZHpLV3hWRG1ZY0VNQnlENzNnNGZ2WFhy?=
 =?utf-8?B?cm0xNmR2NlZzMlJxK044aFh1SnlNY09hQlhKRFBFSDFvRnVZcXRhYTlpeEw5?=
 =?utf-8?B?TlI2bmNvWTgzcUcza1dIOVBDc0NOdjhrMm5jMGQ0NkxVeHRLcnBvNUQ0Z3Jv?=
 =?utf-8?B?cStVN0hGclpRcU4wTzE2NUJMMUVqNzA2anhXMmZGcTgreUZQNnBnWThxRER2?=
 =?utf-8?B?Z2ozTjBZTXpYeVVGMFVZKy9LWWtQaFhsejZyT043V3dwc0pPOENkbmxMdXp6?=
 =?utf-8?B?MHJzVDhkbWJjQkRibXJHaHJnOHZBeXRodEdzTFNwTVQwcnFOeVluTjZrR2dL?=
 =?utf-8?B?Y1U2aTFaWTNlK1QyNElWa1B5MmRSZmR1NTZ4N0Q4aEdjTlZTNVMvN1pvazlk?=
 =?utf-8?B?SE5qN09CdkRlVksrNUlZYjkyQWNOamtLSXJYa0NqUTU1Sk1MYlgvTjBVWVBY?=
 =?utf-8?B?aEN4ekxucllaNWJlazkzMjJzems4QzhSbVhwckZ4eC8yTFJtaWN4d2dkbndx?=
 =?utf-8?B?Q09hTnNSVHlicnZIQ1BXVnJDdXgzSkZWczdYUUtVWGNvMWRtR1ZQbEF5R3lx?=
 =?utf-8?B?QUJqOVllby93Qm9TaWJxRmdSUHBqOXB5ek4rVzBJYk5saHRRNFZVQkludTA4?=
 =?utf-8?B?QUxNMDE2RVd3cWZBbFRLSENPZGNNSlRGVDBsbHRyQmphQWFqNTdGTUFRbWo4?=
 =?utf-8?B?YnZicmN3K3pmcmVwaGQ2L1B3NUNneHQrLyswTXZxZGdiWFJUWXNMK1RXM3ht?=
 =?utf-8?B?WXFnS2tjQ3I5Y2tIOHpodks3MktybSszN0xYUExicGF5dGpjai8wd01IODZZ?=
 =?utf-8?B?RE9KRysxOEltNUZYMmFTSUVpR3l1QVRIUlp5blBZYmwwQkVQY0VWU05zWVc0?=
 =?utf-8?B?aTM1TUZ3bzRJMVo0SE4wYk1SZkhJMjExWi95TDV1UzVDaU42ajg5N3RnR3NW?=
 =?utf-8?B?SWMwZHlzbEFTUDV0a3EybVVpK1hqSnhWZU5MYVhCc2hxZmZvNGVKaG0wdGRV?=
 =?utf-8?B?c25NNmo4WFpxL0h1NVhRenVYd0c4RXQ5Y3EzcHhITXA4bnIwSzZxcWpIVEpG?=
 =?utf-8?B?YnNsNDM0TUdaM09vUklGT2MrdU8ycVlEYVBIOXhyVWN1WjZ0OEQ1aWNkd2hP?=
 =?utf-8?B?NDlZSm5WcnlTYUpTa0FNaHZ6ZTVpWkF5bWx3UmpLSlBTaVRxeXNrck9JTDBx?=
 =?utf-8?B?S3ZKNURQc25hc05nQjJ3TjJUUHdXWXJzMW1RZWJNVzRiSlBmQlN3Zk9TRFd0?=
 =?utf-8?B?WEJGaDhFNUJMWnJxemczczkvSklnVjhRRXhYM3lmTUp2K0I2enoyYTdqWHBt?=
 =?utf-8?B?ZDFuTVB2VVptNUl1VWZBc01Vb0wrZEcwOFNCb0pidUhMcFRxWW9DZVdZYUsx?=
 =?utf-8?B?ZU9ySEI1TkEzTUFSQS9uWi9XR01LVXo0N2p4MCswMXNocjkreFlnanNxMDlV?=
 =?utf-8?B?UE9OQ0N3SE9SQ3BNaXg0QmwxeDZqQitIb2V6cENNdFY1dFNNMDhsWjZ4aUlw?=
 =?utf-8?B?QXJNWkNIRUEyY1Q0bkt6SlBleFJVYXd5MHUvem10Q2RGVnY0c3JRUm4ramZh?=
 =?utf-8?B?NU9QcnBnNW15WDFOc0szcU0wN2FyVGcrT0I2bmVwamxUZEd4Tkg0V1BqSHZ2?=
 =?utf-8?B?aVVRd2o2dTQ1WmlGU2ZKYnJUSm9PTE9uaUh1Nnc3WEpRQy95TjRMaDBaWUZz?=
 =?utf-8?B?TitxYlFIOENROVJTLzREYlM4akpQNmRFdGNaVEdXcUlHemliNFdXSmRDKzNQ?=
 =?utf-8?B?SXVoOHduaXl5ejJDL3VmRTBNOTM2VWI5eGRiM29neTVhUFhpcStneTdCcG13?=
 =?utf-8?B?WW1mZDVlMWRwUUkzWTN6MGVwZnNGOXlXWHk3VDhrMk1tLzVVNHZKOXhQSlRx?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b64b79-31d0-4828-58f9-08dc5843680e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:16:11.2616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7s4WT+3KU6JgMteDf4p+MTMZrkK8Ka8vuoL5pZdgEKxWL2vB/lin0dcmpyagaqOQ0if/H0OaC4KL/MVQH22sVX7G8t3E+K+5fDksreY7L84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> update_cpu_closid_rmid() takes a struct rdtgroup as an argument, which
> it uses to update the local CPUs default pqr values. This is a problem
> once the resctrl parts move out to /fs/, as the arch code cannot
> poke around inside struct rdtgroup.
> 
> Rename update_cpu_closid_rmid() as resctrl_arch_sync_cpus_defaults()
> to be used as the target of an IPI, and pass the effective CLOSID
> and RMID in a new struct.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++++++++----
>  include/linux/resctrl.h                | 11 +++++++++++
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 5d2c1ce5b6b1..18f097fce51e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -341,13 +341,13 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
>   * from update_closid_rmid() is protected against __switch_to() because
>   * preemption is disabled.
>   */
> -static void update_cpu_closid_rmid(void *info)
> +void resctrl_arch_sync_cpu_defaults(void *info)
>  {
> -	struct rdtgroup *r = info;
> +	struct resctrl_cpu_sync *r = info;
>  
>  	if (r) {
>  		this_cpu_write(pqr_state.default_closid, r->closid);
> -		this_cpu_write(pqr_state.default_rmid, r->mon.rmid);
> +		this_cpu_write(pqr_state.default_rmid, r->rmid);
>  	}
>  
>  	/*
> @@ -362,11 +362,22 @@ static void update_cpu_closid_rmid(void *info)
>   * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
>   *
>   * Per task closids/rmids must have been set up before calling this function.
> + * @r may be NULL.
>   */
>  static void
>  update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
>  {
> -	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);
> +	struct resctrl_cpu_sync defaults;
> +	struct resctrl_cpu_sync *defaults_p = NULL;

Please maintain reverse fir order.

> +
> +	if (r) {
> +		defaults.closid = r->closid;
> +		defaults.rmid = r->mon.rmid;
> +		defaults_p = &defaults;
> +	}
> +
> +	on_each_cpu_mask(cpu_mask, resctrl_arch_sync_cpu_defaults, defaults_p,
> +			 1);
>  }
>  
>  static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 6e87bc95f5ea..2b79e4159507 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -220,6 +220,17 @@ struct resctrl_schema {
>  	u32				num_closid;
>  };
>  
> +struct resctrl_cpu_sync {
> +	u32 closid;
> +	u32 rmid;
> +};
> +
> +/*
> + * Update and re-load this CPUs defaults. Called via IPI, takes a pointer to

"this CPU's defaults"?

> + * struct resctrl_cpu_sync, or NULL.
> + */

Updating the CPU's defaults is not the primary goal of this function and because
of that I do not think this should be the focus with the main goal (updating
RMID and CLOSID on CPU) ignored. Specifically, this function only updates
the defaults if *info is set but it _always_ ensures CPU is running with
appropriate CLOSID/RMID (which may or may not be from a CPU default).

I think resctrl_arch_sync_cpu_closid_rmid() may be more appropriate
and the comment needs to elaborate what the function does.

> +void resctrl_arch_sync_cpu_defaults(void *info);
> +
>  /* The number of closid supported by this resource regardless of CDP */
>  u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
>  int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);

Reinette

