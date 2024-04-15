Return-Path: <linux-kernel+bounces-145675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3925B8A5962
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EA4283FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C0C129A6B;
	Mon, 15 Apr 2024 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qiu0TWXW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7F82487
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713203083; cv=fail; b=RK/HayfT9oV0VOSjRzv8vsVpDSmVuyUT0cXLvI5i1XeNa2d0NC3dgVTW6wuRycXIYNJyV/r1SKDteTOGeVxAuQXJ6rxsz/n+Q3u9TYLWHb0RJZJ6JT9RK8P0/Fcr61D/lH1CV50WdHFFgeWR0ukDx3/N7XCsn4XCfCLQLNXPrYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713203083; c=relaxed/simple;
	bh=j/i//p2VhBr/KwnYJk0TwWFEV2lk+tWlozhmAEFk12o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p/n+F9aNPN2IO6onQG/YQoZksyQGDYmSGIeFY3xBygQoNrA3J8r92unpYlw4WVvlnmbzXLY0OMUzDTisMVrs1jnYwfvVllw2HYryLl8W5A2SnP++atS+KAED8vxRqU3nWNXAghhezr4qX439wCXUWP2XOHIkytMBScRI4eQ00go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qiu0TWXW; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713203082; x=1744739082;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j/i//p2VhBr/KwnYJk0TwWFEV2lk+tWlozhmAEFk12o=;
  b=Qiu0TWXWaXiVbjZGY8asnSxvKJjhTVyzDU1ZKMhChFl3ysMaM+yryqNV
   SCOnu+wLiSYwq7jenQIyjwKW1qbO8G9qY+BLHhzHcu5oEIypH96DTlOO6
   ns+/tDQZ1WbRuEBOMOphsv3W+A4U+Ievzks6O0I8YAQyFVamDbHMKU7C5
   Ha2cSd4VtuwKWSlBQRF0ZRHYr3l6jh/Z5szddS0o7jFrCzpoe61EEY44V
   13S/4vhLDSWBFChu94U0MMzH3PFOFc5so+yXbSQeIHZeZTE0/QI54r5q8
   1KTt67H+xiDDFucyUg/Xik+flOQHvJjNufa6J5H8vXrnIJ+ItKEuzyJTi
   w==;
X-CSE-ConnectionGUID: QIjrM7+tTHGi2vk81cf+og==
X-CSE-MsgGUID: El9TFgP2TCiKkvaLi1l6UQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8442677"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8442677"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 10:44:41 -0700
X-CSE-ConnectionGUID: G6hEaiF4RqKcA43wyS4BLQ==
X-CSE-MsgGUID: yF/AXVXRTYCi4MKrLM7ZfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="45282376"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 10:44:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 10:44:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 10:44:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 10:44:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 10:44:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ14NyKK/b8dT9ZFU9O3SPIjkOUr5UtNu9cwl8dkIq1mBajitUmxYy2MktUW6D7XqdeIvzHxtyHvkxsp1vBGjGGyNrLYkh7d3+/bVGUnMX+BITgCDMH2xkmr9RCED3073s9hYqrNl41Pofw3LUhs8UHTBxmZEuTi82pkw07QhocwSkT0ECWaaqa5PjR/yagAbmmiKNsCsk7zkwiqUIcPi0R2pq0E4Z97RZn7JJB/lOjTwAJ6Nk4CEiS/xFM1KsrzZpkHpgq3xZHGXAeumH0Dz1PNH4c5UaSOQ5s6z7mUADPqzgpZBCWSWSFQ7XcecEjtWfg+pvjLVAHTBR0id3/xDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAl08z60N8LKz22FISiQZVts2ExT5iDz4a+3kXaWEoE=;
 b=LsvDSx0pPE9ow3CZ17VdlrM0725u1Afj3GlD4fUXpt0YNxB4WgVpZEpSLkkzrOa2Fow+20xbULxi5RopzhmiBnfmTSbPeiMskZ7w3BSc8w9Iy8s91K71zshrHB+/aej3eGC3j75HNTZrwOeIDshNW6DfCuUAefGRVfiovIj41O8vUbxOAS89uTFqI6OSxk1HZSQAPO829jacFbaj5Rc+oXmxCM6PDi3xr255vcNmXN2zzVjeLye3fL+jpT1go/Q+3wO6bA1kCAZWoFCUc3mUMojWjSvvRUkTl3eXcxNTBt6FJrs3SFrm/GuJuwnvE1D9+ULV+lZoKpBkMrwo236hiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Mon, 15 Apr
 2024 17:44:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 17:44:37 +0000
Message-ID: <9daa5c12-c43d-4069-b2a6-c505217e2387@intel.com>
Date: Mon, 15 Apr 2024 10:44:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/31] x86/resctrl: Move ctrlval string parsing policy
 away from the arch code
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
 <20240321165106.31602-4-james.morse@arm.com>
 <e85e7786-7995-42d5-a5ac-1e08a84492fe@intel.com>
 <ZhleZ2q60ysIRapv@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZhleZ2q60ysIRapv@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:303:85::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2bba8b-d462-452b-180b-08dc5d73b82f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUNYG4DFw6t8IusfG1qdLCrSARd9cwAFd6KsZ5WOxCFYKx0HcGs0IcWdoZcmP6EOrx0xUEgSQNwKoJcfSB0p518Yp8zvDcondrXzJgD26ejtTgw6pwViedEP/jyZOqDi85sMG/HzOtSX8gzR5McdR0ll+FlpP6RaZPpsFQNA0F8NkPoJ2OhcxJ93tvdwtMPq8aVhqL319ziKrG5U0IrL0AH+DZrhWZmWGHiqWxMZAHhP3bTnerdEVx91gN9aWGS506EUX1ns76poKTL31CKOmvUhpOfiyZZ3R2hMgo0FgPkTqQUCSY9jnfy9bbEatSeXBg6rhiKUnL73TnWYV7GSGjxrbsFJsUi+SCJLTfBH31pFuzKcCqSbV646ah8THBShTrf1/TCPdnTCNm/LFfZBFBuzh2rG36hsWi5Qm7atktZE4soqA9D21qUpo8y5whLNUOmUQbhIGxk5nkssEPPEj3tn7nIo6Qb+RC9aGCJXCqhe25/PsqlYhNLNha3EhrTfBpdoa/oxcx5O25w1HfpwirLTTyNE7cUDTbZR7fRYfJ2fWVMAlY7/UeiY9AvrcDesdhlQAu+eZCLwaVoFVpiceMceUeCunIM/O2gnvB2qaZj3BhG081QAfC1TdydnhV5XfDpGKGxEfboVhqv5sLHeavFrSEEaPqdQNntYdIr7wEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czdpbTVuQ2R2a1BNeGhQUTlUNmNpa0RYZlVjQ0hjTGdQT2lpOTJGNzFwZXFF?=
 =?utf-8?B?VW5zN1ZaVE10Z1ZFN1hzd2ZHM2lNc1dEakt4T2NaOWhUNXNmSWxSeEhuNUZY?=
 =?utf-8?B?S3ZnY2lJTXZILzI2bEc3c005R29qZzVMZ3V4QnpHSlV0bFIzdUJqMlJWWEds?=
 =?utf-8?B?RHBLS1RDUzh2V2p0bVlSQjlyeWp5SjB3Z0k1bzl3QXh3c0ZxTElFZzV2MEli?=
 =?utf-8?B?ejAxUWNXWUVJQlZCb0Y3Yk9GTEhPa3NiakczRFFESHR5YWlhMTRnb0hNZjY0?=
 =?utf-8?B?UEFLQTB4Q21PeEV4ak9HcXdtMlJPQmRBanBwRzhMSEswRmwycUI3UCs0Y1RM?=
 =?utf-8?B?b1dqU1lqeit5RGcyZld5MHVoaGhuZFN3d0VwWW5GWm9DMHFsOXZXYXNjN01H?=
 =?utf-8?B?UkI1UGVZMnU3KzdxUWRpYUdENjlEVWRwaUF2ekZEU2FxaFZzNXJxTG14VlpJ?=
 =?utf-8?B?dFdpTzcwcnFKVEVxeVRUeHkzU2RiUmYrMnRVNWs3QWpSSjYrSzVzRndjVUc5?=
 =?utf-8?B?RG9NbjZ3UWoxeGZDQVJWekl0MjNkODhTS0tMMEV5Q1VkSDVRSytMQmtLM3E5?=
 =?utf-8?B?angwVjBVUHRMZnVnNS91TkZzeGVLQ2haZm51RXFnT2RiNEE3NUljYVN1UHE2?=
 =?utf-8?B?UFJSWHNuRll1Z2taU1RzM29RTUpCTS9mOGtJdnQvQzNCZkxDcFFEYThlTHVW?=
 =?utf-8?B?VWx1SlkxNE5RNEQyKzJDZTRJVnhMQjVlSVlEOW5oMEJwc2FVRlZ6bFVuSXRD?=
 =?utf-8?B?a1YzM0JtNENlZDQ2MnZvSGtVZG42OGdQbFpKbW56UHBaN044ZDBuSkZGalAz?=
 =?utf-8?B?a0Q4TlVhRW5DbG44R3pUcVVZT0kxbThMUkpseWhPNy9hWHlWbmRXVGYvNDND?=
 =?utf-8?B?WjlwamFrVUtVSXJzdzA1YmNxZnBIVUp1VUo2aGx2ajB4SlQrRDFTUm40ZVRo?=
 =?utf-8?B?QWpKRVRxQXNYQklxTjkxRlJSTnhFSENldU54cXRUUzhtTlpDdzdzTXpQUzJV?=
 =?utf-8?B?Y0E1NWRqeFJGUWhnSE9rSFVQUzZTZnZxWEVjVVJNeHhNYmt1K1ZlQktCdU5k?=
 =?utf-8?B?SkRKcnpXRzlWbGdSc0ZqaE9mRjJ3d0g3cVNxencybzJaS2xvMEJaSkJXcFJK?=
 =?utf-8?B?eU5Kc3dHbytmYTRUSTRHRzdSeFVhdUt4ZXF3Q0UxaVBnMDJJMmVPU1MvSmcv?=
 =?utf-8?B?bGpvS2R2MnFFSDQ4LzF0RnBCTk4vU2RTakFvRUZnNml3Zyt1R1JOMms4dFFH?=
 =?utf-8?B?aGtBV3NSSW1qbHhEMHU3Z240eGpISlJrRFI2UVZRU0ZOdnFPY3Vma3FFVnpx?=
 =?utf-8?B?WEM1ZktNYkRSYzUxZ3M1K3NvTjNoTFAycjZXNXlsUXVabFRGdkZCZHZFaGhx?=
 =?utf-8?B?cEpMWmlGaWNDYnpLcHZjcXArZHZYaW9XeWsvS2lNVWF1aCtSQk1TeEU0QTUv?=
 =?utf-8?B?QmdYVmJMMys4Zk91eDJxWGdtLzRZeHBYaWMyb0JSTlByN2FUL0Z1NDg0RFph?=
 =?utf-8?B?cU5OcmlNOEFkZVNMYkdkTGl1K0ZxaXB6M1ZMWlJGK1FEa0RKN1lwekE5d2dj?=
 =?utf-8?B?aCtXRFN3OHBJdWhCd2VPMk5XcUVhR0pvNk9XTHNzMHZWdHl2UWRLZU9Scjln?=
 =?utf-8?B?NXFDVHJIU1hFRWV0TmEwb09uMVhYVmJXdlZVSTZpL2NwRk0rbS80dGVGb3Y2?=
 =?utf-8?B?RCsyU3RvM1F1VHQ3WHNMWFJIRXFBMDVYT2NFNlYxVkJTcVh6QWxWVUVuSHNl?=
 =?utf-8?B?ejNsWFpnVHZDL0NYTmNuTkRxdFN1azdrM1VUUGJGdnJRWmFEZHRFVkk4aC92?=
 =?utf-8?B?TmVhNUFLMENGbFlIYXBacC9vR0FkKzNPdXRTQzNSdm9YeCs5OWxRdXh1OEVJ?=
 =?utf-8?B?WGU3ZjI3UmdjT1NOMkFxMXVoRDN0NmNMSWVtR0lXNkNvUEdISXNocjBjSFFI?=
 =?utf-8?B?bENva01wcEZuTjBIN2pxVzd1a0U1NFgvRDVJb2RCUnZaYWtnSmRPamNjSE5Y?=
 =?utf-8?B?RFUwV25lZlphQU15WmFFRWpOOHBCS3lqU0lFaEhXMlFLNTFqejdkRFlyb3NC?=
 =?utf-8?B?bWpTK2FGeFJ3OC93c09sQXlDVm4zL2E0V0ZsbVp1MnBmWXRKVHE2KzZDMmNY?=
 =?utf-8?B?a1VsMkJDRlNIZXdHTVRzK2lXUmVhTVRsY3JaU3IwVTJreGIwd25CMUFmYno4?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2bba8b-d462-452b-180b-08dc5d73b82f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 17:44:37.4315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOldDOO9UFFcXv217bKxsBpwou6pvwSeAvy8IzN5RWFvbb58wIaaZQi40apEfz/gG8sxGwwRLHZaWy6zh3DwfSs8WdsJXe3iMinVwc73q94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5296
X-OriginatorOrg: intel.com

Hi Dave,

On 4/12/2024 9:16 AM, Dave Martin wrote:
> On Mon, Apr 08, 2024 at 08:14:47PM -0700, Reinette Chatre wrote:
>> On 3/21/2024 9:50 AM, James Morse wrote:

>>> @@ -195,6 +204,14 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>>>  	return 0;
>>>  }
>>>  
>>> +static ctrlval_parser_t *get_parser(struct rdt_resource *res)
>>> +{
>>> +	if (res->fflags & RFTYPE_RES_CACHE)
>>> +		return &parse_cbm;
>>> +	else
>>> +		return &parse_bw;
>>> +}
>>
>> This is borderline ... at minimum it expands what fflags means and how it
>> is intended to be used and that needs to be documented because it reads:
>>
>> 	* @fflags:		flags to choose base and info files
>>
>> I am curious why you picked fflags instead of an explicit check against
>> rid?
>>
>> Reinette
> 
> Is fflags already somewhat overloaded?  There seem to be a mix of things
> that are independent Boolean flags, while other things seem mutually
> exclusive or enum-like.
> 
> Do we expect RFTYPE_RES_CACHE | RFTYPE_RES_MB ever to make sense,
> as David points out?
> 
> 
> With MPAM, we could in theory have cache population control and egress
> memory bandwidth controls on a single interconnect component.
> 
> If that would always be represented through resctrl as two components
> with the MB controls considered one level out from the CACHE controls,
> then I guess these control types remain mutually exclusive from
> resctrl's point of view.
> 
> Allowing a single rdt_resource to sprout multiple control types looks
> more invasive in the code, even if it logically makes sense in terms of
> the hardware.
> 
> (I'm guessing that may have already been ruled out?  Apologies if I
> seem to be questioning things that were decided already.  That's not
> my intention, and James will already have thought about this in any
> case...)
> 
> 
> Anyway, for this patch, there seem to be a couple of assumptions:
> 
> a) get_parser() doesn't get called except for rdt_resources that
> represent resource controls (so, fflags = RFTYPE_RES_foo for some "foo",
> with no other flags set), and
> 
> b) there are exactly two kinds of "foo", so whatever isn't a CACHE is
> a BW.
> 
> These assumptions seem to hold today (?)

(c) the parser for user provided data is based on the resource type.

As I understand (c) may not be true for MPAM that supports different
partitioning controls for a single resource. For example, for a cache
MPAM supports portion as well as maximum capacity controls that
I expect would need different parsers (perhaps mapping to different
schemata entries?) from user space but will be used to control the
same resource.

I do now know if the goal is to support this MPAM capability via
resctrl but do accomplish this I wonder if it may not be more appropriate
to associate the parser with the schema entry that is presented to user space.

> But the semantics of fflags already look a bit complicated, so I can
> see why it might be best to avoid anything that may add more
> complexity.

ack.

> If the main aim is to avoid silly copy-paste errors when coding up
> resources for a new arch, would it make sense to go for a more low-
> tech approach and just bundle up related fields in a macro?

I understand this as more than avoiding copy-paste errors. I understand
the goal is to prevent architectures from having architecture specific
parsers.

> 
> E.g., something like:
> 
> #define RDT_RESOURCE_MB_DEFAULTS		\
> 	.format_str	= "%d=%*u",		\
> 	.fflags		= RFTYPE_RES_MB,	\
> 	.parse_ctrlval	= parse_bw
> 
> #define RDT_RESOURCE_CACHE_DEFAULTS		\
> 	.format_str	= "%d=%0*x",		\
> 	.fflags		= RFTYPE_RES_CACHE,	\
> 	.parse_ctrlval	= parse_cbm
> 
> This isn't particularly pretty, but would at least help avoid accidents
> and reduce the amount of explicit boilerplate in the resource
> definitions.
> 
> Thoughts?

I understand the goal of this patch to make the parser something that
the fs code owns. This is done in support of a consistent user interface.
It is not clear how turning this into macros prevents arch code from
still overriding the parser.

You do highlight another point though, shouldn't the fs code own the
format_str also? I do not think we want arch code to control the
print format, this is also something that should be consistent between
all archs and owned by fs code, again perhaps more appropriate for
a schema entry.

Reinette

