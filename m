Return-Path: <linux-kernel+bounces-37630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1FA83B2D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B961F24F96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39165133983;
	Wed, 24 Jan 2024 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yq6uMxgh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D7D132C38;
	Wed, 24 Jan 2024 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126704; cv=fail; b=cgoyKgd4hr2sNyrThF8hR4Gu7xtoDrJzT+W01u/FEQHX1BwpeCJXFpnRzmqKI5UrE49lq5EBUzJfdvixHXR9oXDaNOYtkIVarNRMlzduT4Z3qYeII255SHM6nh9BlBKqOe9+y/II/uoCzO2TR5+MC6CXc7RRrylj+HU2ZZy2Bu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126704; c=relaxed/simple;
	bh=LQ3Huv8ioEfeFH09t9H57/ylufPNZJaHlxbqu053tkA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fxKC/lUBWjVgIbRgeUib8mimuHtc9bCK/Axs/MGV3gnGnlbrQh+ChYWCSISDyWnhvA9jk/HKqux9uB4teMAkekyMxIaZ0TxyW6VL6x9Ey91ncj7yXZ+HXcvR+paaYxc6Fv2oI3SLCs5ekoYA9OYQmIjoFRjDpHsOMOWLhWTAT5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yq6uMxgh; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706126703; x=1737662703;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LQ3Huv8ioEfeFH09t9H57/ylufPNZJaHlxbqu053tkA=;
  b=Yq6uMxghLzGU7sALcIMn09PwYvJqSadc1UvlMKfYqALw1QWnbsyv/kCi
   Yp/D/jy9BSBMO7HHUnbV2NFrr7wsB5sA7CHdY7SbOeSvuMSEhPdQtwQot
   Jkso+hhhzem+WUUoDkbjlZO15rU30vK7+svU1R8Z97DUF9tk0a1xa5iTG
   043mkUr3N7CRo7Sr3bwt2u90c8Hj/g04HxfZikis7ajVHLOqKZrXmhFTb
   GIwumG/7UdxoXjOCSCkw3pjOEy8Lap9++XElGd3qbSqbcy8OZuF5Q/jyW
   2U3sTOo2CpSMjDV1xLCbF08wlM3NN4UCtm4vHkHj+2n1NElF6nihnsk2s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1852172"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1852172"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 12:05:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820569312"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820569312"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 12:04:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 12:04:38 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 12:04:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 12:04:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 12:04:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzWNjb5fUI2cAfAF8tEXzfdV7guBQoboyb9g/XFHgNnrnBiRTBNWkWbbXaZdO1k7cuoJrEfmN+TwX6yXvqtaBH/ZPqEolJ6nvX06O0ioV4dsbNgIgn4YAd5eRfaExezX2KqkLo9k5z61XlqKole9RV1F/jMoM2JflDBP3Lz7S+oNqWg9myxARaJtrrOyZWLIdgLlTsckovG/TPkbxe39eflwe8IuPrZ7AWA3+p9E5DdepnCS+w231iK7Av1m6eaNVE7gAH3BI4By772oWUQJWC5n0OCKzzv8diMKvZxGZoVl0DTmIxsc4DsnyIsoVLfwmb+vSDODsk4/FIzXng0Wqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TRVyYXP1bwl+4vaufccRAoq54UiH4YARCDDOiVlARc=;
 b=B7sWj/uvGiKfTER7OvEDVbI6jiW1u7oeB7d4bFgKaaqXf+eS1R2FvXayMsvIkvZgLwP4a91PEvv3tBvLaow+uUmk53ej8ureihYMysRY1abI5pj9pQ5YBMv00rc0O83sPh3FOCbT915fpyQ5AUxrEXTf8U+8Dox8LtiZJuNmmw8f6Xp2P8oAjCyqu9/kqK80AN0IoCLVc2ozZpk0vcMsdo20A/RjCo0Tc0oPvmTUHV0413ahsDT75p8nuft9jYIwRa1/fXxQSP+MAQDyToTq/wy0xmbgnVTm8v+KwnxF8M+sldw20Liv5jrXRyG+AofkjgCVwYBnwHlgwbfFTHCl7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB8100.namprd11.prod.outlook.com (2603:10b6:208:445::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 20:04:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7202.034; Wed, 24 Jan 2024
 20:04:35 +0000
Message-ID: <6635c607-cab2-45f4-a0fe-ff4f53b36849@intel.com>
Date: Wed, 24 Jan 2024 12:04:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix unneeded variable warning reported by
 kernel test robot
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>
References: <202401241810.jbd8Ipa1-lkp@intel.com>
 <84128a3c83654493f637b8349153af10d69e2752.1706118776.git.babu.moger@amd.com>
 <39c4501e-4937-49de-b12b-742e6201df6f@intel.com>
 <20240124183153.GFZbFXmTKTLEpwZshW@fat_crate.local>
 <e96df7ac-f0b4-4300-8546-7c1df836dea2@intel.com>
 <20240124191429.GGZbFhldYr3K85H9cg@fat_crate.local>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240124191429.GGZbFhldYr3K85H9cg@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:303:6a::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a15d74-ded9-410d-899c-08dc1d17afb5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqunMxowWLqa/e0LJhJGfHEgtyt3ZP/P1c8GVqmlFe/yVc6kT0L1LleMtDqkiGxQ8Y92MFRhVCFeMSfMavyoXhCObiNBEeDuznZt3Hm/pgYpHVYe+VecQEfUCDTjW2zVjxVeh+3Qs92t+EmAaUlL34cRtvuvQI5KQq0z3B9v/4AKN6VBJnAior8ttSaHINNWExF+IhVcT0VwImbdD4PkbDM0vh9s6dRMyrHLQBxk8+PJlVLHq10hczcRuSKFgMUNrU1+rcuDayuoQj+KPmFmHEhz8Ddf72lP6Yp98cDqa4XVVr+BSxbtcsFcKCmZwiZTORVhIYkUZyO9AWMgQmRUnrfuJ1FvRbBH2bOZk0SrwO+3Wuc6cyjJnZWHmKosFPdazxlTPqacqwLHUeE+JTbaLqoQq2U4pEVAY4TWyAotAa6Zr+Vx37Dk/A4pTAbJN8kADIC4xHcTkrCbI/xBEk0ooypXBsZUczIeSuTjbqX69z0VnOthNJA9Swhho+B8PL93agdZuBP/sNusFcVWq9XqsCQvGKlS/wQUMsL484yIxNFYg229qZY4MQnyhRdkrHG2BvoEVDNHd9phlbi6S+4Tv/vw9758D2jlRvqCjZZOITuFizSddlsVIwOVZ0MPeZJKtgKhEcNriuOMYmm2+YawYB4nathtdgvYRmpkS1fSdnRHJ/wVKnM9wZ16qDI5tHWfYWmOifo2+p1Xc58ZSdcyJvpsZBHb7Q1UpPoEct/YMv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(31686004)(66946007)(26005)(66556008)(66476007)(6916009)(5660300002)(316002)(7416002)(8676002)(8936002)(4326008)(6666004)(83380400001)(2906002)(44832011)(6512007)(6486002)(478600001)(6506007)(966005)(41300700001)(53546011)(36756003)(86362001)(31696002)(82960400001)(38100700002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmlzYU1iWEE5TGFHb0ZpZDNHRW9wSmN1L3JZYTNwZXFBckY3WTMyQ1VMOEw3?=
 =?utf-8?B?WXJMMTVxSDczVUdTSFBIaG5iYmhSS29pVWlXNUw4VjkycGdGem9CbnVUMkJM?=
 =?utf-8?B?R1FPcHJkUDdzNDdlZTI5bmFyTDV3cTJ4cmV5VWF0bjBZdXJCSWord1B2aDY3?=
 =?utf-8?B?L2tIbm5wRmNiQnlodGVvR0RKRFZ1Q2ZuK2Q4N2VzSHRvMWU3QXBNOW11T0NK?=
 =?utf-8?B?UklQdERkRDhuZTlpWDRQSXp0ekJmOG1kWE9nWGc3WGM2d0t3a1JFQStWUmV1?=
 =?utf-8?B?N0xrVGExUy9rSVVMTTlTVzZFSzliYkxHeCtBK1RwVk1EM0RKRkxkQ09qaVA0?=
 =?utf-8?B?MVhXZFd4OWlxdlBCa3k2Wmh4dFMxRVhjaEt3VjFUVTZnMktUWWJKenRWbXF5?=
 =?utf-8?B?ZGhhRk9iaHY1WUU3NklEKzhWYThjbkxPM0xoM2xnSVlkOSt5WnVhTFFPc1VE?=
 =?utf-8?B?cFd0SVMrMUF0LzRIMjUxcEswSXpKcmdQRnY1aTR0dCtWZHhvVStac2I3Qlo1?=
 =?utf-8?B?dEV2aTlnbFVlOG9MVVFwc0NsVW9hWDZiYk1oSkt5RXE5dkIvbUlvME5OalRZ?=
 =?utf-8?B?QjIwNTFDMWFmZGV0ODJxTE5ITndaNGtEZUtPbXhRaXY1TEpqTHk2UWdJVWJY?=
 =?utf-8?B?ZHhISytaR1MyQThUeWdybGpLcXdjU0pxcGt1ZkY2S3Q2a1EwR21PcDhGd1Ix?=
 =?utf-8?B?dXpWS3gvV3BtMTNHS2kzR0FscG41dXdYdUVhVkJENEp2L2NYU2J2RC93aDFG?=
 =?utf-8?B?SWlHVE9jUVZMd2J4a1NmSUxzZ0Q1bjlCaFB6RGJ2MlNxVUhXNEF5a0YvazNy?=
 =?utf-8?B?aDZiWjdSdVNES0l3djA3TGRkZlJGSXN1MkhycC9RS3lwQ1NzS0lnaEE2THc0?=
 =?utf-8?B?TGpWL05XK2JNT3NyQWppcUVrTytaeWx0Ky9RZ3YvQklJVmY4bkFWREpnTytQ?=
 =?utf-8?B?NTdNUmZNaFV6NFRSd2hTR204Uzc3clJPRTg4RjhIczZTSi9FTW5MWWkxVHhY?=
 =?utf-8?B?L0NGMyt6RHNZODVVaWVGUm1lMWVuYWxxSC8yVGJmR3lPeXM4ZHFTOGhaZjlR?=
 =?utf-8?B?cDc4dlE2T2pZSHZ4eXBhV1NwUjk0OFFJSWY5NkJuU1h4Y3lNMmhLS05ZZVhB?=
 =?utf-8?B?MUd5a2NGbUQ4UHI1b3dibmhnaitLVVllK1VlNGh6L21pV1p2TjNYV2FYNHNU?=
 =?utf-8?B?YTFNRzhNRG0za3VNNlVjVWk4S2diRENNUGhkREJObkwzTkxudlY2VmdENXIv?=
 =?utf-8?B?OUd1bC9Ja1JRd2xaaXpubU5CdnZtUHNxcGN6QUtYUVhrZFRWQUl0UWlNVHpC?=
 =?utf-8?B?cjNOWlBQWklNUHZ6d1haY1NQUWd1NGRqU05zRnlnVkFETjRaUDQvVXBpQ2sz?=
 =?utf-8?B?QlFUYmUxN004OUhEbjZlSU9qTGFCMVYvd0lPMS9RVEx3OXd5cnFYUWMvalFX?=
 =?utf-8?B?Y01JVmlRelY1YnM5MEFRMTEycm9zK2F0eUxEbDlHbHYvNFMvclpUazlvMStE?=
 =?utf-8?B?aDdhQyszQm1BS213d0NzZnR2ZTdyY3phZEkxU1V1cXVTUGtHeXZxNmtBSW5R?=
 =?utf-8?B?Y3ZPaVFuT2I2L0E1MTQ2VXV1TXNhQlgzMkNUeEVlMGxFd1VBbGV2M25lSXFM?=
 =?utf-8?B?TDhKM1liVDFhUG9yU0FMTjJaaDh3MjRBSm41Nk9mVlVVbmVrZ1Z1VjVZN3Ns?=
 =?utf-8?B?KytXUWV2ei92TnFNcU8ybmlubEUvWjRxY1NvS05hcVJBdzhhdlF2S3ZOaVM2?=
 =?utf-8?B?Ymdydzg0TUR3b0g4VGx6eThadStWZEwxZnpmL2lNdlI0aXlQTkxYdW1FYmxy?=
 =?utf-8?B?Z1EyNDlQMVZLT0tmdkljMnhGUnRCNm5WcHRGT1hxVmc2WHRSQjg2RnBHU0hk?=
 =?utf-8?B?Q3NiaWNqbUFrVEtNSzlxNTZXc0NTMjRtakNhT0lrR0t1eFNkRytuT0dyZ3hP?=
 =?utf-8?B?TkwxL0dwNDhnejZodCs4ZWl1eWJMOEhSU1gwcGU1SUxYVGVEUnphN0syUEtV?=
 =?utf-8?B?NHY3YUtSQjlqTkVMUDM0N3dkUklkZitKNG1Ga2FQZnE5aFpITVlYb3ZKNlJR?=
 =?utf-8?B?ano2djJacDg1UUhSNFg3WE1IWW95Yks5Qm9JTS9ZRlJTOHY5NENuT0srY2s3?=
 =?utf-8?B?RUJBenp4RThYeTh2STBRam1MazllamtjekwybkdSRHcwNGY5WFNHa3R3Z2Nt?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a15d74-ded9-410d-899c-08dc1d17afb5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 20:04:35.1425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEDjvwUKa1uAY0U39CFB7WXPGRjrUxXg5nypgu+1J9uHyosjy56WXQqcq6BGlQ6+xyqszSudUw08HDMUOcx8jPPP17cxDlb497ReOw7fGPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8100
X-OriginatorOrg: intel.com

Hi Boris,

On 1/24/2024 11:14 AM, Borislav Petkov wrote:
> On Wed, Jan 24, 2024 at 10:51:49AM -0800, Reinette Chatre wrote:
>> Thank you very much. For what it is worth, I do agree with the actual fix
>> and you can add:
>> Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Ok, have a look at the below, pls, and lemme know if that's ok too.
> 
> mbm_config_write_domain() only returns 0 so it can be void. So the
> callsite doesn't need to check retval either.

Thank you very much for looking further and catching this.

You may already have taken care of this after sending this version, but I
just have a couple of nitpick comments intended to help this patch in case it
requires a clean slate from some checks. 

> 
> Thx.
> 
> ---
> From: Babu Moger <babu.moger@amd.com>
> Date: Wed, 24 Jan 2024 11:52:56 -0600
> Subject: [PATCH] x86/resctrl: Remove redundant variable in
>  mbm_config_write_domain()
> 
> The kernel test robot reported the following warning after
> 
>   54e35eb8611c ("x86/resctrl: Read supported bandwidth sources from CPUID").

I think a "commit" prefix is required here and below.

> 
> even though the issue is present even in the original patch which added
> this function
> 
>   92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")
> 
>   $ make C=1 CHECK=scripts/coccicheck arch/x86/kernel/cpu/resctrl/rdtgroup.o
>   ...
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1621:5-8: Unneeded variable: "ret". Return "0" on line 1655
> 
> Remove the local variable 'ret'.
> 
>   [ bp: Massage commit message, make mbm_config_write_domain() void. ]
> 
> Fixes: 92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")
> Closes: https://lore.kernel.org/oe-kbuild-all/202401241810.jbd8Ipa1-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>

I do not know if this is something tip prefers but the general patch checkers prefer
that "Reported-by:" is followed by "Closes:".

> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> Link: https://lore.kernel.org/r/202401241810.jbd8Ipa1-lkp@intel.com
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 2b69e560b05f..c33eb77b6d70 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1614,11 +1614,10 @@ static void mon_event_config_write(void *info)
>  	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
>  }
>  
> -static int mbm_config_write_domain(struct rdt_resource *r,
> +static void mbm_config_write_domain(struct rdt_resource *r,
>  				   struct rdt_domain *d, u32 evtid, u32 val)

This shifts the alignment slightly to no longer match the open parenthesis.

>  {
>  	struct mon_config_info mon_info = {0};
> -	int ret = 0;
>  
>  	/*
>  	 * Read the current config value first. If both are the same then
> @@ -1627,7 +1626,7 @@ static int mbm_config_write_domain(struct rdt_resource *r,
>  	mon_info.evtid = evtid;
>  	mondata_config_read(d, &mon_info);
>  	if (mon_info.mon_config == val)
> -		goto out;
> +		return;
>  
>  	mon_info.mon_config = val;
>  
> @@ -1650,9 +1649,6 @@ static int mbm_config_write_domain(struct rdt_resource *r,
>  	 * mbm_local and mbm_total counts for all the RMIDs.
>  	 */
>  	resctrl_arch_reset_rmid_all(r, d);
> -
> -out:
> -	return ret;
>  }
>  
>  static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
> @@ -1661,7 +1657,6 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
>  	char *dom_str = NULL, *id_str;
>  	unsigned long dom_id, val;
>  	struct rdt_domain *d;
> -	int ret = 0;
>  
>  next:
>  	if (!tok || tok[0] == '\0')
> @@ -1690,9 +1685,7 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
>  
>  	list_for_each_entry(d, &r->domains, list) {
>  		if (d->id == dom_id) {
> -			ret = mbm_config_write_domain(r, d, evtid, val);
> -			if (ret)
> -				return -EINVAL;
> +			mbm_config_write_domain(r, d, evtid, val);
>  			goto next;
>  		}
>  	}

The core changes look good to me. Thank you very much for creating this fix.

Reinette

