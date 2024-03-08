Return-Path: <linux-kernel+bounces-97358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDF0876961
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FD21C20B97
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD802557A;
	Fri,  8 Mar 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJbhPIf1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CAA2577D;
	Fri,  8 Mar 2024 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918001; cv=fail; b=BvQ0+Z6aoS8gjgozR8RmpHg+aXJF6kxJ7TUfnF7OxvtrYmG41ORf75L2+mdiL8abKOkUNytKfwVxHSqX3k42RMZPalOBk9wvUaP9LPJ9cdw3EvJJUIhBkSeHr6b48taGXjSdp/2Hi7LWJlttRdhftwBgNIzgyd6l/qPlj6LWY2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918001; c=relaxed/simple;
	bh=RaR5aFCgPmiLgv14z/7Vyo2B79/LYDrBZR8TblQJwig=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=evHi+8bwlerte0p0Qm0fvuDG3WGHkCNu22EsejNu3/YJNA/yK5Xb85C/3desJttrEqjQee7D0p/nhSQH/F8oCagPcso0OxzbuFev0y/Lc3J6VqBgbh4l92ePqc5dqdFAQWhFVAdq1eVL3+0g+K4jrcIN6igIl1zTVEm2IHjQZgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJbhPIf1; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709917999; x=1741453999;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RaR5aFCgPmiLgv14z/7Vyo2B79/LYDrBZR8TblQJwig=;
  b=iJbhPIf1SrHMANMcIzxhsmMgg0BwCJscNYvFhe0crVfGIGXH0lRlJYtB
   sbSxwUWbFC+H0U5h2wb9wC7164Bd1g/TOHiQSiK1C/V/Lvbxhwdblna8t
   TyaR3Im/+3SvmEexSymhu0iyyZFfMhv2OGmAfGIvuYjoiBBxIMWItSQYd
   SOuA2pO+i7EGk6sLCGwFthQS1mtHwAqr1rQ+m2DUieT3K+r4i9edQmHFs
   kj+DLhoqlp03BkXHZSs5chCmyyeL3oNFHZY5zKcI25WR86eSGhZYsLIQ3
   2VRPmYBI2LidqLAWVqTNCogsNQHxNk2Syv+8HoeJmQF58mNNrDhSYchE+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="16074963"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="16074963"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 09:13:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="41449341"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Mar 2024 09:13:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 09:13:17 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 09:13:17 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 09:13:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1b1ckDpvsgLt7RRvIm8kpB6U702VOI9Th1kTKDcxWeCAOKjOz9v/dD9pPf1rgNC4e1JgcU7Tm2HgHmwOk9TNSHBOBDX8ZlzGrg8a+TEBRVb4Bfd0W3uEGPMfut/iRb9LZBJUpDIrPGyjREe4pTzrUSWwuwgiRB+0BBK/e7OHcmPAr+mWtCIl6527ajIIaQjoHN6cKKGHo5yWeT/75aoyjPQYFzwgLo5wnhWeqt/SbKmUFoVhw9hbVWhiqx6+UeVHtyzNltT+jVjSJQucPf9DvOgjj3/z7Iyct3FE39h4hHPTx1zhpSF8c2q8HAZSpLl1GQQI/OzOgLa/Jl2wlTyUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Mb9o4ZhWlLJRgQFjlIkAmOTFkTCmHii4yuM0LZ5yps=;
 b=djuwLH9N8YZ3QxphWDbllTJ+r3x1dYxq3r7G7ZjIbe2ySQh7rJLz9mLbXjJddjhtLjF93x1Vhtmh3ynaAh9ye6FmSUHpL9LdIoORualQMtEDMRZPgC+sWqmR0s9sKH5sG02NVUm0RPDen87DjeUTCwMkNwqaTfLFQifi/l+tEHXH1BWIwTYM/f5jDyQHbC2XUazFY7i62ZSj+FEd/szDjmGQ7G118joeaJ2RZF9vwMFbSaHFgF4Ho/V8bOD1eLjc2l1xKZarDdPgtaannq8hquYlGDfjJtmPnVpn36jhg6iNvC9C1woXHmVQvh42C4yJVA78KoRZ6n6U+sBG6VerJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.6; Fri, 8 Mar
 2024 17:13:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.006; Fri, 8 Mar 2024
 17:13:13 +0000
Message-ID: <9ecea229-b9f9-42fb-b92e-fcd69d525d84@intel.com>
Date: Fri, 8 Mar 2024 09:13:03 -0800
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
 <e90ce54c-a830-4ba5-8b28-aeef06705d01@intel.com>
 <CALPaoChcJq5zoPchB2j0aM+nZpQe1xoo7w2QQUjtH+c58Yyxag@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoChcJq5zoPchB2j0aM+nZpQe1xoo7w2QQUjtH+c58Yyxag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:303:8c::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN6PR11MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c60945e-3da7-4ca4-2a53-08dc3f9309c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+7p2ljaex1BuoyVsCcwkn/wc3HArs1yOQkSFhioykM75SgvRhQoGUTK64pNZglo/FtkMPoApSQ2dWCWM7fKWkZajMO+CcCZW3I8O9eibUqX3wVOxIv77RPXU6m6zKGW3GDtsXgfppOwGUVry5UhAPGmY15CWsROyS+Jqp6f2BLvzox5hxUweBt3eKYcdpJ99HqAyoiNuWvtgHpiBIo1U+4BS5ivZKzrCNn+722d7dEZDXomdKgraRA3cFoTQ9Q6Clu+h50Iqmn/3M1vcbdAqHcOKA8WU+W5SUgnb3Kfs9pO4+k1aJ1jzhm4JCI2AzuFe0AKsMIDl5qtuzO3dDxJtKOGzS6sDKrqTkW9UqkgTVUy+gPcSkjNxa5prF7GxXPxCkKhPraNe9ySDX3UWk+JveZJtDn4ImTvWNmOP6iEhV5/QYOk+/ihOFn+ZPs2qlNt7X/mQKlAvEJD99Npf3r3G9IB8qaF2rdaAX3Q0B/guh3x1tVNQVHx5ht+y1CaohcQ5VjHR2H60wOgpk1YN724fnTE7CtgCjbqZ8YiXoUckGUvc32AVWiQ6ySKAmhxJWZHWOJP9pkgnzKWdPg6lZJ2CspZnOhrIszFBu+1t/uUYb0QyTUs8AguZ/e7HMsHUSHJfVRsv+D/IW3sa9VJABW3JSmk1KR4tuvfZzvZ8i4TUo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJjcVdMdU1GSXVURHNkUDBmZEwyaExGQ09vSFVYN3V5cWhLS05iUVBFYnIx?=
 =?utf-8?B?OVJxelVBb2ZXaWFsNDRSMEcxOVZOUFpFRGM5NmcrelBrdVd0TjRuS0dzSlNj?=
 =?utf-8?B?VE44aFZLNjA4dlZ2SGpkOEY1NEVKWWNSZGRieXUyRU1LSk5OWVUzYmJ3Slpn?=
 =?utf-8?B?TTRCaW9TLzhRY2MrMk00TnE2amRJd2QvaWF2am1nVEhCZzhwS0h1R05GdkU4?=
 =?utf-8?B?WWFVQ3lQblF0cWFtRlVhbWxxWUNKRTZiaEFlRTZGeDRqTmtINlo4Zy9CQUJH?=
 =?utf-8?B?V3Z3Y1BmZzg3ZW5YUWhkMW0zNkh5SlNwRS9ZWS9qeUx6ejEzcEhxa1FNQWtY?=
 =?utf-8?B?VkFqcXg2d0w1dk5pcDc5TjIxWEVrNmduUE94aWFUcmlyOTgwWTJob1VrWHky?=
 =?utf-8?B?SzZmL01LUlRVU2tXR2E3UW5mYi80c2hjMWpweExHTy9FVy9RcUoxNDQ2a1cy?=
 =?utf-8?B?eHo3SXNwK1NFNHl3aHdVaUlYZjQ2TnBIb21rUXltbXc2Q3FoRmVlVlU3NXV3?=
 =?utf-8?B?VXZWYUI1ZTV5aGxKWGdoV1ZFVUdpYXg5Ti80TlFjZkphcTFDcncyYmI2NVlr?=
 =?utf-8?B?RENDRGxMNHNtaXNkREVNUi9JbnQxVks2NmNmMDZhVEs1VmpTUk9USitoR0xP?=
 =?utf-8?B?VDd2cmpnUEdUczN3aFZBODY1L245Rmw3dHBFRWFQOEZEdkdxdkFZQjZBKzlD?=
 =?utf-8?B?TkpvZW5uaHhRajNLdzFxVWZCZlkzNkE3ZmZCbzQ2TUpsV1JVS00rbGZVQ1dX?=
 =?utf-8?B?Y0NxL1FTM0RXTHpLM09hL1o0OTZXTE5lYzNWSEdSM2ttOEZtKzBIdFVvdFk2?=
 =?utf-8?B?cGxSTVJiM1ZNZ3ZMTFBNMzVkY1pwQm5YTnpPclJCc1RtaFNuaDVPQ1ZVRHR0?=
 =?utf-8?B?bC9oWUx5N2VTV1E5cm4rLzRqRkRiUHU3YjkwRGI0UUZ0RDFnVktpYnI1V29Z?=
 =?utf-8?B?Y1o0TXkxc0tiUHZoWm1KK2EwWGV6R1RQZ3plOFZLM2ZFQVYzdjZZZy9oQko2?=
 =?utf-8?B?NGN3NVlpYnFzSFhMVm91U01CVlRCYjFIUHp0OFI4UUJhRVpDZnB2ZEhNSDhp?=
 =?utf-8?B?QWFKOFdScURZaTlUU1ZsNzdDdVZrMFRWa0tuWXVjbXRxVUNKUUxOQmtBek41?=
 =?utf-8?B?Z3l4SkZtMWlIMW40VTNFdy85dTlaVE43NDYwZ0dMdDg5WVdRS1dEc002MXBH?=
 =?utf-8?B?M0MwRnExdVlQYy8yTEl4Y3d5NXhoSlFPVTZqYVVYdjV1YmV6QjEyYmEvVFor?=
 =?utf-8?B?OEZWdmQrczBnMHQ4dGI3N1YvNC9MVEQ1RUF0UUN3dTZvOVVYY29UQlJGZnh3?=
 =?utf-8?B?eUcySWltb3Mveis1cmNQbmYxSkx1cExzUURUNTFMenQwdC9yU1dwYmlzdVJK?=
 =?utf-8?B?cVR3Rnd5NS8rMFcrRE9hS3dqVWMyM1dTalRQby9oTjJCOXVna2RteTVuazg2?=
 =?utf-8?B?dFVtNyswWHlGaHBLMnpjVlJFY1ZOK0hjNnV4ajhvcVM1M1BuSjJqQnBkMDVY?=
 =?utf-8?B?U1IzZmtvUWNDMEJ0OGxMSlpTVS9tRkNNZmtmeFRCbmFyT2FKYzlaSjI5eFpo?=
 =?utf-8?B?K1puakF1TmFVYVJkUDE0bUVnUWtiUjlBOWVZQUtQSmNjb3ZZa055YnNZVk84?=
 =?utf-8?B?c0RRVEsrbzFIWGpCSmJvUkdWUFFnUnRpS2EzL1JFVHNPVkp5MVVoNS9EWS94?=
 =?utf-8?B?SVNQMmtZQk1nMzdiRGhoSzZSSS9Wbms1RWJtMzdGYlpPc2hwTm5rSjZMQlRx?=
 =?utf-8?B?K2Ztcml3RVBLYTFFWjNTNmh0YnZQV0lHeXR6SEsxbC9OMXpGYlM1aE82enRM?=
 =?utf-8?B?VHhXazZBdXg5cHFCUU5zeGFMNWNwVjhQWHRVNVNyaXg1K1JZZFNzKzZSTStC?=
 =?utf-8?B?NEl1clNoczZEcE9TS1lRRlRIUVp5RWhZNlRaNXBockl3MVlnQ3hicmZJUUhr?=
 =?utf-8?B?T2FsSzg4bHA3N2MzN2d1ZndWQ2xpUFNkSGRwbWRlMFBSSm11TjRkMkU5bVBl?=
 =?utf-8?B?aHlpQTFkSHBHUEpFTzFwSURYa1V3NE50ZFd4M0M0SEswTlJyR2hmZWo4bzMx?=
 =?utf-8?B?b201OERkbVg5UEQrcGRrc2JQQ3MzQmhybktMczNTK1huOXhPQ0Fsc2pRdUc3?=
 =?utf-8?B?eGo0VkdRaTFBOTZWdGJtcEp4Mm9HVzVucThReW5yNUllUm85S1M0L3oraWNa?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c60945e-3da7-4ca4-2a53-08dc3f9309c7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 17:13:13.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ae8tqR28/zspAAIHKmBCaWXkkzHNxo4gUELiaJko5ZPRmcVWHHU86Y3qLX6jmMCDjcomtpiAGCITAEIuN7uqeeYBGYSULksNHP8oHsgmyHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8102
X-OriginatorOrg: intel.com

Hi Peter,

On 3/7/2024 3:14 PM, Peter Newman wrote:
> On Thu, Mar 7, 2024 at 2:53 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 3/7/2024 2:33 PM, Peter Newman wrote:
>>> On Thu, Mar 7, 2024 at 12:41 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>> I understood the proposed interface appeared to focus on one use case
>>>> while the goal is to find an interface to support all requirements.
>>>> With this proposed interface it it possible to make large scale changes
>>>> with a single sysfs write.
>>>
>>> Ok I see you requested[1] one such example earlier.
>>>
>>> From what I've read, is this what you had in mind of reassigning 32
>>> counters from the first 16 groups to the next?
>>>
>>> I had found that it's hard to get a single write() syscall out of a
>>> string containing newlines, so I'm using one explicit call:
>>
>> Apologies but this is not clear to me, could you please elaborate?
>>
>> If you are referring to testing via shell you can try ANSI-C Quoting like:
>>         echo -n $'c1/m1/00=_\nc2/m2/00=_\n'
> 
> The echo command uses buffered output through printf() and
> putchar()[1]. The behavior of the buffering seems to be a write() call
> after each newline, causing the kernel to see the request below as 32
> individual commands.

I see different behavior. Just to confirm I added a printk() in
rdtgroup_schemata_write():

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 7471f6b747b6..00d9809a1bac 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -384,6 +384,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 	rdt_staged_configs_clear();
 
+	printk("%s:%d Parsing %s\n", __func__, __LINE__, buf);
 	while ((tok = strsep(&buf, "\n")) != NULL) {
 		resname = strim(strsep(&tok, ":"));
 		if (!tok) {

I believe the behavior you are referring to is when user does something
like:
	# echo -e "MB:0=90\nL3:0=7ff0" > schemata

Then, indeed it is two separate writes:
[  636.391304] rdtgroup_schemata_write:387 Parsing MB:0=90
[  636.397773] rdtgroup_schemata_write:387 Parsing L3:0=7ff0

When using ANSI-C Quoting I see a single write:

	# echo -n $'MB:0=90\nL3:0=7ff0\n' > schemata

[  655.879331] rdtgroup_schemata_write:387 Parsing MB:0=90
               L3:0=7ff0

Reinette

