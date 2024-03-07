Return-Path: <linux-kernel+bounces-96341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B29875A77
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848A11F233AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B2D3D0C6;
	Thu,  7 Mar 2024 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WdaBoQie"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6B91D698;
	Thu,  7 Mar 2024 22:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709852018; cv=fail; b=fJoMIf9UVVggA6R7HiUGE7YxxskQzkm/ddOrq1H3krrpHrcDi8Mjm79tvn2TsRb5aQCnbAcCzLxEpB7y/q/0aUMgwBQg8c48E8Xq73B9y/TsjMbvAqyuDtwSfgNVqHJ2ca5qUsXZOyJxrVDzbt3T7k8HWonKujKySwDMqpJfCj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709852018; c=relaxed/simple;
	bh=TQM5cHxkBTvTjYP6mfPVJbNEQ6wJkH+dZq6fXsd5NzQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bYZrQDh4mmsZI/7AiNJ2HvwrkRxYU7yid+OwYKTm92cVtZ4S1k7tniHq4iih08A8aGzq7uUZJRn0bNQ7nBbKb7Sp5zKx2XAbzAJv7/EHyDpSdfvXL/s/FQuLI+qqtXk/siovO1NdS6H+yUEcPIu5F30PjbGdAvM7pB1QP7fx3YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WdaBoQie; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709852016; x=1741388016;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TQM5cHxkBTvTjYP6mfPVJbNEQ6wJkH+dZq6fXsd5NzQ=;
  b=WdaBoQieRXYrzwjw0FOg4+JZ6Ub6zIJoEC6GT4+qXRmyFmgQQxJU3jZI
   TT3uMOxabzY9W/BoyK7+5dLA3DjUo+wOThvxvIkzO1uJ86BUMYMIXSAIb
   Kf2GGp7wedrSA0DlqlcviLXxgXrkuUZTHGFsMZtK9exUMXwSU2qeoA/E9
   ingtctsBbyF4fLBJZof3lXnJUkQiuVmh13XrGWw5uCmZPlQz6sowV9tSu
   TNBwu5WD1rhlFbE+U4dxn3fQK2eX15rQflVMSpjmjQIOMx3TStHX/YQm4
   OQmCh8dTlBfRqEstHW2C1QgHjy9tn9Ws2LyEs7JPB6NQ2HRwVO/XkOj+P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4432951"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4432951"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 14:53:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="14933477"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 14:53:35 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 14:53:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 14:53:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 14:53:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVYO6pICEeeNaN/60jkO2xIhkSbXJB2LalSmx1t1d8My4XJ4f67ATc30DDTejYqGTd+l9WDlxvJuLH8IuU936LjhzvQlVxv0qJ4P5xcs5y+gZPVRwYeSESfyMxGBf7xWlet+gJYCGyjJmn+jfn/R/e+6QVKfXnnq4eXk4OUgacIDfpbL5UNoq04H8p3kozKrdiXXmpbcWCu7eoSZiEJVgiT0e+4EBQjkGHa2uMXeoDESvLsIwFNNuWRgtBepkEPppyvM7xdYynBP1k7yfR3zalw+2VceHiyDcRxUXlSq56pkgOl3+vh4Nh6cVV519eSGXWZIK+b61jhRXpLMZHQFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDW9nd7rcGe6TMcuZ4ymYzHCaEBTk1OsGAU6shbD9H0=;
 b=kZyyIOXx4t/TKsJgdbzZBCYMy7+Ijgnt+qQpqMpU2qp/smOLO7RvmwEDZSdTEIEAeorR0lUS6G8FlUa/UCEXyytlgMxIDJ6VxwQQYfYO10Mm++qPCGy4N5kMzkefSzvHFAYX4SNHsoCuLY4MLByx0umey7mNutjIj5++30Biy/UB1HRtWtdlqO2+oRXZgA28HIxj7rMaP3s8B+CWU1ef1KAWutgVOBx/EA4Tewdu7/T8zsoztOQuwV3S7ucckQDzQTLKcttOYFETktGLODgLQoq/8Asmjzr+R6f4vUiNa6Ak5TIt/7T3A25+Ae6grMLKb0i25ie/P//wpeFBZMBRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB6866.namprd11.prod.outlook.com (2603:10b6:930:5e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Thu, 7 Mar
 2024 22:53:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.006; Thu, 7 Mar 2024
 22:53:26 +0000
Message-ID: <e90ce54c-a830-4ba5-8b28-aeef06705d01@intel.com>
Date: Thu, 7 Mar 2024 14:53:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Peter Newman <peternewman@google.com>
CC: <babu.moger@amd.com>, James Morse <james.morse@arm.com>, <corbet@lwn.net>,
	<fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <paulmck@kernel.org>, <rdunlap@infradead.org>,
	<tj@kernel.org>, <peterz@infradead.org>, <yanjiewtw@gmail.com>,
	<kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>, <seanjc@google.com>,
	<jmattson@google.com>, <leitao@debian.org>, <jpoimboe@kernel.org>,
	<rick.p.edgecombe@intel.com>, <kirill.shutemov@linux.intel.com>,
	<jithu.joseph@intel.com>, <kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
 <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
 <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
 <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
 <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com>
 <11487a31-908e-d474-50c6-65617d417deb@amd.com>
 <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com>
 <55b545fd-2851-0d0f-ac37-ec59838fb4b4@amd.com>
 <1f366890-d9ff-4ac4-9af9-1ea3128a87fc@intel.com>
 <41ca7504-c3fb-ddb6-e149-4ff82019d678@amd.com>
 <CALPaoCi=PCWr6U5zYtFPmyaFHU_iqZtZL-LaHC2mYxbETXk3ig@mail.gmail.com>
 <1d3e8b68-28fa-419b-b129-0c39df34f718@intel.com>
 <CALPaoChJPkfrMgFDhtZqwK7O8=A71CKLzQjEMG6LbgB9RhdzvA@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoChJPkfrMgFDhtZqwK7O8=A71CKLzQjEMG6LbgB9RhdzvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:303:8f::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bba751-0372-46e6-9802-08dc3ef965fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYeUnNROp8UCMkuR3jk84jkIB7AZKUeUHX9RmzETNPzNam3aEzq0RvsW5ra8DdRnjgRtYyk0/OFxs3DM4UKFPuZtHsqM7Pa9ffXr/PNfFs7+MJOTSRhSf7F06SlRTtHrReEexNhi5QMJkTYvikivYSHDD42EJGi+xRVzZyITshbM0r9Nb9qJd3HBxujEa213lcpQ+zvDo1QBzG5p3ZdKsTI4SYr2jQm6jSRIWzZScZ8PAkuw4LDeaYfT3jIwT30cQd9MKO3CTk+f6RHiODll+4Pwrbz6rcqvwvDQRsAJEXYgnro/3hWvUb8yYY4AjusHELOO3m85mZVYyI2BSLZCk3cqzkcdubO4MzAkYLevXoeSUaai2+FzMbfjjNd11GCFPpKXQ43aHIx24ERMvh/GfK2vBymS9Rov39Ej7E3QMXMdwHMHrMTIvEH0NG9lQqNBmWbcd2vkknW7aluJ7XEpT9132Uvdnj+CnA/uQ6lXu0BXAyuV3lrSLJSqqZ1NnHRDjp/C9OXSakC9ze3Cio0cL7eENynSj7nX0eha9+uGqPM0uZawfJhOTj7KkrQ8s3+Wsjbo6/jSY4u+QFi61DIvOMsE1Y7V23fVH8plo74ni7CpjVkF0Ayiski+3v/xY9RP50Cl454zbs4C4TiX5C/qGH63pveZNCj4o1dTJ5UI9HQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjZzUmdRbWE5LzBJSjk1R2ZkRUpqWFJhNk1RTGprTWtpL2JhRnRScG5SMDh2?=
 =?utf-8?B?MUtUUXFDdU0zOTIvOUcybnNpZTQxRTIvejZ6RDh4ZTZYVkV0SXpraDlMZXh1?=
 =?utf-8?B?RWJXOXQ5MGYzc2F5S2RJVjlKNU0vbHFDN0hVQ2NHSDhmMVhmeDlLcHNnRm1P?=
 =?utf-8?B?WHdISDI1ZCtCWHZwUEtzUHZHd1poMmNRYjJIaFU2cFFjQ1hQU1lWSm02UytS?=
 =?utf-8?B?TUhXbnhkeGV2OFY5YkoyQUZSQXlLTVo5ZmlKS0ZGNjA3a0J2RjNPVnhRM0l6?=
 =?utf-8?B?Mkg2UElkVmx0UERqY1FzeFhnajI5ai83ODRFc1NhNzY4aU1LOHAyTDJDVmlU?=
 =?utf-8?B?WjZlOTdkQW5tS0lCWHlBWWlPL0d0bFpIWDVSRXJzVFVHOWF5a0c2VDBLVy9F?=
 =?utf-8?B?ZnFtcXdOUy9pdnlnR2FuV3ZhZnNwSUltTTBIaGZxeDFLcTkvNUpjZHlJQWVP?=
 =?utf-8?B?dnE2YmFhbE54amZ1VkhYbWRSNFA5bVJrUzFuMUNBelR0SGJkUko1Y1czTWVY?=
 =?utf-8?B?U2VJejRSWkQyM0gwVUlkVTdsL3g0Zm92Ylc3U202V2lBVW1rM25VY2V3ZnA0?=
 =?utf-8?B?TC9CWmE5NlBWN1RLK0QzekhSQ1h2WWRIalY4VUlyVkhHMlFCYUp0VmN6M2hC?=
 =?utf-8?B?cFdqWUxvNFIyS1NEYzg3MDA5dUwrOVdlRDVVZkFVQURLMGluSVpNVWQ2V25L?=
 =?utf-8?B?K3JOQ05JbHYxZ1EydUdacENreUhjclRKck5HMjFRVmtFS2IzUUtKbXZwWkdu?=
 =?utf-8?B?L3h5NkoxWkUrOXpBQjlDeSt1dGlEdWlTL2N1Q3VyTW9hNC9nckJndElkc0JW?=
 =?utf-8?B?VEliME8vVEZKZjljWFNJdVowTkxvTStpVHFkK3ozYjJ5YkxML1VWSmhqbkcw?=
 =?utf-8?B?M0M4UkV5SlBmaXA5elp2ZmZrR3kzT1Fna3FyTWYzdHh4M1d4TkFYU3ltemh6?=
 =?utf-8?B?YVNCZnBnWThPZWpmZGdTRjhBQTFKYXptdEJjNlBQTU1WS1ZpOXo0Skdja0hR?=
 =?utf-8?B?UFhtelZEdFlzaWpyZ3dHWjhjNmVuNXVMUW9lUmlIMkhGUkdjOFFWWHVqZnNE?=
 =?utf-8?B?YjlnTzRmc3Yyb2lOV3JGQmZ1Sm1YVXNjbldMN091SCt2U2hHbWpLYlI0cE5W?=
 =?utf-8?B?S2tUK1hCTlJlcWxMUFBOK2xNYW9pQllJTHBEaS9zRFF5aGgvOW05SGlpSm5F?=
 =?utf-8?B?cjJtRlZLSnRzODM5SnlUZlMxYUFJTVlvRnVCSlM3ekxmTnFVZ0FWVmF2eXF6?=
 =?utf-8?B?QmZqYjZtUjl6Q28vdGp6YnlkVGJnRDRENm83Nk5QODBDUDJtYlBJWXBKWWpM?=
 =?utf-8?B?dGFEQWpXc2oyREtXb0JKUlpzaU9xaWpxZnZiWlB5OFhsN1lrME1lOHR4eGR1?=
 =?utf-8?B?NlMzd3Jzc0JUWU5VS0NBdzc2VVpJdXByNzZ3UkV4Qnl6TEtBTnUyQTArODhI?=
 =?utf-8?B?UkRDSC9JM2pTRWNoUU5aelA2LzdmektoVEZGb3g2WDBEN0NTQjlQelZDRjhv?=
 =?utf-8?B?WmRxMzBVMHJmcWVpYnRKMTdXNElPbWpyWXVaUzQ0N2hKM3FubTIwNVdsbWtu?=
 =?utf-8?B?ekJpMW1Vay9UWm0zOUJjVUhBZnVndzBScVVkbko2aDNrKzA3RE45UHlRck5r?=
 =?utf-8?B?bU1yQ1FZb2dpTXU1OWhjWjgxQjNMcmxyblRtbWtCWlR2UmxwaExLSWJERWx1?=
 =?utf-8?B?d3ZKVGRzbjlVRHJyVXBLWmdWSEJFUTJyMTlnS1JYYTZrSTFTcWVrZEVEVnJa?=
 =?utf-8?B?SndqYkpkKzU5SngxVnVVK3c2dUY4VHF6UFlOWmltRzNlL2ZHNUVOZDArOG9q?=
 =?utf-8?B?NDRselp5aENTeCtocUpJZzN4bExwL2FMSm42VzM2TUhnRlc1QVNxdHE2QTFH?=
 =?utf-8?B?NXRORll4Ty9FVTd1UjZkRkVFbTM3SzJhNVRtS0hXeHBhaHlpVHV5SDhIbHFW?=
 =?utf-8?B?ZkliSitoakRHdk5EbnJyNnB4RUVkVUczM0ZVRHNrUGxGVWY3UlVEL0Z3VklP?=
 =?utf-8?B?N3hnSVI1RFNhSEZqS1dFeDQwMEpMZGdLSS9aZ0lGb3NvdkxheUVuUGYyZG41?=
 =?utf-8?B?SjY5Qml6eGtVN21RaWx5ZDRobzRGK2gyQmljWEVRRzZxR3FOS3pudVJpUHBZ?=
 =?utf-8?B?VVRka1p6dlQ4bnh3NVIwSCtuNFF4UVRuWERCT2Y1ZWZQQThDS3lvTVhUSDRm?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bba751-0372-46e6-9802-08dc3ef965fd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 22:53:25.9971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUJ9EZLA7TJo+UclfOwlEezR3ny2ALZuQO9i9wSzx/XrZFbpPQRKXqPs5KOWQxslrn8cInKGij0QgYwSsaL8V8U2v37lBBrghS5xycll63g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6866
X-OriginatorOrg: intel.com

Hi Peter,

On 3/7/2024 2:33 PM, Peter Newman wrote:
> Hi Reinette,
> 
> On Thu, Mar 7, 2024 at 12:41 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Peter,
>>
>> On 3/7/2024 10:57 AM, Peter Newman wrote:
>>> Hi Babu,
>>>
>>> On Mon, Mar 4, 2024 at 2:24 PM Moger, Babu <bmoger@amd.com> wrote:
>>>> Based on our discussion, I am listing few examples here. Let me know if
>>>> I missed something.
>>>>
>>>>    mount  -t resctrl resctrl /sys/fs/resctrl/
>>>>
>>>> 1. Assign both local and total counters to default group on domain 0 and 1.
>>>>     $echo "//00=lt;01=lt" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>
>>>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>     //00=lt;01=lt
>>>>
>>>> 2. Assign a total event to mon group inside the default group for both
>>>> domain 0 and 1.
>>>>
>>>>     $mkdir /sys/fs/resctrl/mon_groups/mon_a
>>>>     $echo "/mon_a/00+t;01+t" >
>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>
>>>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>     //00=lt;01=lt
>>>>     /mon_a/00=t;01=t
>>>>
>>>> 3. Assign a local event to non-default control mon group both domain 0
>>>> and 1.
>>>>     $mkdir /sys/fs/resctrl/ctrl_a
>>>>     $echo "/ctrl_a/00=l;01=l"  >
>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>
>>>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>     //00=lt;01=lt
>>>>     /mon_a/00=t;01=t
>>>>     /ctrl_a/00=l;01=l
>>>>
>>>> 4. Assign a both counters to mon group inside another control
>>>> group(non-default).
>>>>     $mkdir /sys/fs/resctrl/ctrl_a/mon_ab/
>>>>     $echo "ctrl_a/mon_ab/00=lt;01=lt" >
>>>> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_contro
>>>>
>>>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>     //00=lt;01=lt
>>>>     /mon_a/00=t;01=t
>>>>     /ctrl_a/00=l;01=l
>>>>     ctrl_a/mon_ab/00=lt;01=lt
>>>>
>>>> 5. Unassign a counter to mon group inside another control
>>>> group(non-default).
>>>>     $echo "ctrl_a/mon_ab/00-l;01-l" >
>>>> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>>>>
>>>>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>    //00=lt;01=lt
>>>>    /mon_a/00=t;01=t
>>>>    /ctrl_a/00=l;01=l
>>>>    ctrl_a/mon_ab/00=t;01=t
>>>>
>>>> 6. Unassign all the counters on a specific group.
>>>>     $echo "ctrl_a/mon_ab/00=_" >
>>>> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>>>>
>>>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>     //00=lt;01=lt
>>>>     /mon_a/00=t;01=t
>>>>     /ctrl_a/00=l;01=l
>>>>     ctrl_a/mon_ab/00=_;01=_
>>>
>>> The use case I'm interested in is iterating 32 counters over 256
>>> groups[1]. If it's not possible to reassign 32 counters in a single
>>> write system call, with just one IPI per domain per batch reassignment
>>> operation, then I don't see any advantage over the original proposal
>>> with the assignment control file in every group directory. We already
>>> had fine-grained control placing assign/unassign nodes throughout the
>>> directory hierarchy, with the scope implicit in the directory
>>> location.
>>
>> The intent of this interface is to support modification of several
>> groups with a single write. These examples only show impact to a single
>> group at a time, but multiple groups can be modified by separating
>> configurations with a "\n". I believe Babu was planning to add some
>> of these examples in his next iteration since it is not obvious yet.
>>
>>>
>>> The interface I proposed in [1] aims to reduce the per-domain IPIs by
>>> a factor of the number of counters, rather than sending off 2 rounds
>>> of IPIs to each domain for each monitoring group.
>>
>> I understood the proposed interface appeared to focus on one use case
>> while the goal is to find an interface to support all requirements.
>> With this proposed interface it it possible to make large scale changes
>> with a single sysfs write.
> 
> Ok I see you requested[1] one such example earlier.
> 
> From what I've read, is this what you had in mind of reassigning 32
> counters from the first 16 groups to the next?
> 
> I had found that it's hard to get a single write() syscall out of a
> string containing newlines, so I'm using one explicit call:

Apologies but this is not clear to me, could you please elaborate?

If you are referring to testing via shell you can try ANSI-C Quoting like:
	echo -n $'c1/m1/00=_\nc2/m2/00=_\n'

> 
> write([mbm_assign_control fd],
> "/c1/m1/00=_;02=_;03=_;04=_;05=_;06=_;07=_;08=_;09=_;10=_;11=_;12=_;13=_;14=_;15=_\n"
> "/c1/m2/00=_;01=_;02=_;03=_;04=_;05=_;06=_;07=_;08=_;09=_;10=_;11=_;12=_;13=_;14=_;15=_\n"
> "/c1/m3/00=_;01=_;02=_;03=_;04=_;05=_;06=_;07=_;08=_;09=_;10=_;11=_;12=_;13=_;14=_;15=_\n"
> [...]
> "/c1/m14/00=_;01=_;02=_;03=_;04=_;05=_;06=_;07=_;08=_;09=_;10=_;11=_;12=_;13=_;14=_;15=_\n"
> "/c1/m15/00=_;01=_;02=_;03=_;04=_;05=_;06=_;07=_;08=_;09=_;10=_;11=_;12=_;13=_;14=_;15=_\n"
> "/c1/m16/00=lt;01=lt;02=lt;03=lt;04=lt;05=lt;06=lt;07=lt;08=lt;09=lt;10=lt;11=lt;12=lt;13=lt;14=lt;15=lt\n"
> "/c1/m17/00=lt;01=lt;02=lt;03=lt;04=lt;05=lt;06=lt;07=lt;08=lt;09=lt;10=lt;11=lt;12=lt;13=lt;14=lt;15=lt\n"
> "/c1/m18/00=lt;01=lt;02=lt;03=lt;04=lt;05=lt;06=lt;07=lt;08=lt;09=lt;10=lt;11=lt;12=lt;13=lt;14=lt;15=lt\n"
> [...]
> "/c1/m30/00=lt;01=lt;02=lt;03=lt;04=lt;05=lt;06=lt;07=lt;08=lt;09=lt;10=lt;11=lt;12=lt;13=lt;14=lt;15=lt\n"
> "/c1/m31/00=lt;01=lt;02=lt;03=lt;04=lt;05=lt;06=lt;07=lt;08=lt;09=lt;10=lt;11=lt;12=lt;13=lt;14=lt;15=lt\n",
> size);

(so far no "/" needed as prefix)

We could also consider some syntax to mean "all domains". For example,
if no domain given then it can mean "all domains"?
So, your example could possibly also be accomplished with a

	c1/m1/=_\nc1/m2/=_\nc1/m3/=_\n [...] c1/m16/=lt\nc1/m17/=lt\nc1/m18/=_\n [...]

Any thoughts?

Reinette

