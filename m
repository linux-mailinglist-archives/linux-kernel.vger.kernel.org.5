Return-Path: <linux-kernel+bounces-37551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E16F83B183
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D50B26F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C03131752;
	Wed, 24 Jan 2024 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4iFrgCo"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE918613D;
	Wed, 24 Jan 2024 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122322; cv=fail; b=DREYhjrSNsBuSh7BRU06Ybujieh6oGW4w3y3ejwOmzIi6/hnyIJyNQfgfQmDjZMZa0iu0s1lFTQHq+mc+/U4wd1veNv/Q9+eeZ82zAi/YkoKPYZnj427nbpDW5bHQAS6GKGs07XXoYVgqZBPL6sJ+lAmB6n4iKVDXU2XPEP+n7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122322; c=relaxed/simple;
	bh=CoAVWSgrnEHPst9MDHm/yWLezVh2xCGvznloWwxjzhE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eumGJekj27toE2CEK6whmam/NVyUV+HH+SR0EPSPxjIPr5rafK78wzL6rODUFd7GxKKByTfo40tFRx+pHdTOipoJffb+MpuApu9YmdqrmvHYSsiY9FiYpj2o/4x/K2Kxf27QRhNQvExjG6QSTRncOisUNUaPIJJ3tNtbw0CZXCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4iFrgCo; arc=fail smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706122320; x=1737658320;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CoAVWSgrnEHPst9MDHm/yWLezVh2xCGvznloWwxjzhE=;
  b=V4iFrgCoDZsfYLCBXtCV4duI50EE6hLcNBX2R7TFD8/PXcAuK7sZworQ
   AlCU1dHr3C7ORhg69PR0v93mN2OKsjwj/guJDDrf4hEPWlKSqZadZvFgz
   CMIAue7kw9RzTzptOJYQNpFBMreSmHwhyFo/ts3NbTxir6Tvsxlc5P2/1
   YxUqC2C0L8UhLIEApp0yKKddpizaySuZgQJonJhE4yGr61k/Dmg86NemS
   CyyKWfBZVoQ+LU9U3Mus5hWN/hiR3Ly64NIswtMYeB6cvLouPMKpQx7gX
   wowZ3aA0GYPOqdMA6NNA5VC5Fmrpc6yNsk0aic43EY/DKXM9IblgUyKQa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="466217203"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="466217203"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 10:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909749547"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="909749547"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 10:51:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 10:51:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 10:51:58 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 10:51:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMKh92N7jLm3ZHUzahDAFk7jIE4qTkzWBazC1DmDvNBaUpIpfSt58/A9dCb2VUGdFos6VUZZVz//9iQxfqFXA77ZVoXmxDiGKvLwnn5a4CmMoDKtUZb+0x/Qn2qqIV2rPFRiZcl6NIvZlKjMQgeobNBGYy1y/89GimBMbKgYeauRzUxF7jiR45bRrAEiftUEq7snjtmepERMea0Vsuut3RCQSxQRwLC0MadbDnC2auSzd3Ko/WiE35095+9MFRx55Cl3WKebp3dk5cC1ypQlGM4uR4I3skC7NNjhL/GHXiMRpKjZ55uGzmyCqgIxvmb4xLLy2SyloRht6vbqHZrKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8hSe3nPxC0qAp1lfhQh0BZSNBiPG8zJrR+LncHMqmM=;
 b=n9DxYDg9UHT2UYcEkmTDcM2/B8zWBr0QwZaA9/YX5Fr+OsyjQ2S0i+wTQrSSGPd/7GPiw2TugZMu9gB7P9K22x2CEbDGmMJtHOqw4inEEFcLrLnSimP6QP3TcxlzP/KI/7ovvTSpQP0kBdCr5FSTBWDpwaYqN3t2lyLGgb66o+/d8FzEMmnNiLt16TPztioUxwhyaVROFz1dNeEOuUkZwk7ZeFEoGtX4DJEsQ73NIzDeEttqeLNE2N97PMH++tCfREwAg2yLedKCWHh1+JZe/aRiqO9i20l/0K5wdp8MD9DyjL+7Zjz7m4ptruzxlBxIZXdBMsOl30cP4GWHd6q8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7397.namprd11.prod.outlook.com (2603:10b6:8:103::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 18:51:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7202.034; Wed, 24 Jan 2024
 18:51:52 +0000
Message-ID: <e96df7ac-f0b4-4300-8546-7c1df836dea2@intel.com>
Date: Wed, 24 Jan 2024 10:51:49 -0800
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
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240124183153.GFZbFXmTKTLEpwZshW@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:303:6b::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7397:EE_
X-MS-Office365-Filtering-Correlation-Id: d440179a-06d4-4ed2-f6e0-08dc1d0d8777
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MRs22VcIpJ86niiQPYtv09KkClvbyA7Z23DcYqpoFGHjHZpdBe2C4ynPucnVkuU9tTB6fet1eSx6daYpnqVjZMuyDSMhgIZyW4bPgx1ZtG2xcEv438HNUPOLFEPLBLwyXH1dI5DwzDLbZ6mXo4PPzWWFXcvQL3ezN2H7TGzcF6W6FgThR84xa2Q557uS+a48cFNTyWCtkuCmJOWRaKQhCWxTRmKC7Uoad6ZXlwcwfOX4MrjKPR3jrCyGXmQkUY5qLpNqynQ2QBKCaRL/SQKQH5ZioGP4Up6Unt6H34Qfzw4jqGNmdVPbwmVQyxtcODddh0seSpCSKjBOFdSP99nTW0pUFLYCgTlxs6dAeXp9GuOA/j6xZ7/Mn78a4uO67HaPYcO9MPRq2puerBsKjPSxzQPo9UwpwPm3UAEeNAoukgvNhjZb7jsovonMHKCl5vU4ausz9+7O+1948no/t4Ry3s/lvqoQA0irJbLhVzhfuLJqA4mf3FpVgy+cDh9FBzk0MA13BERyUseNRm57owSpG3DK6CY5xF1+QfSr1J/EZ8yyuj+uoHdkkubcDcyw/hz8AZlTNTX93YzkJCTXchivkHmpCyoVx7VlIXTS5FTCUmWV14LO++JLgLp9xKNDqVk03ZkvUoKHRmx8BZfb1GTwYKuIkeJpNpAZbhXhF+j906AuO4VWJoeAd0KNhwhLpNMO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(2616005)(41300700001)(26005)(6512007)(38100700002)(8676002)(6666004)(4326008)(5660300002)(7416002)(8936002)(6486002)(66946007)(478600001)(6506007)(66476007)(66556008)(53546011)(44832011)(6916009)(316002)(2906002)(31696002)(86362001)(36756003)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWF5dWF3bGxubDBneFVURnJmUkY3STkwU1Qxd2xGeXJpeWFIcWtyeDZMU1lq?=
 =?utf-8?B?MjlIanB5aGhQR0pRNVNHaEtLMW11TFIyMUJRR085RmtMVWtReXlXTDBaTlRY?=
 =?utf-8?B?OVhheTNnVkV0T2w1Q1hrUzkvUFZXM1gzNkZGRy94L3RCa2w5bVc2MXJHV3F3?=
 =?utf-8?B?TkFodnlnTnFMWWlTaHlMNjNXbWNaTDRBaUovRjRmMllMUTBsOUtJWkJraVpu?=
 =?utf-8?B?T1JLSUVkOHY0Q3BNeGk5ZkpQMWh1THdPeExjN2JGUHZKc0d0VWZuZGhQVjdt?=
 =?utf-8?B?aTFUZGdVVUdCRlhEMmVxTWtYY3lxVE5pVzFTbHo1SVh4eVorK29RUTVYWGt2?=
 =?utf-8?B?Y3RkdGxnR2hLUXU0NzRFWHo2Ri9iRWZaZ3FSeFo0V3pQUC9ZUHI5bmZJZkJI?=
 =?utf-8?B?bUozcWRYV2gzL1hRVy9SYjliaExxbStLdHNjVk9WbjY2UldnYnp0bkEzODBt?=
 =?utf-8?B?NGNILzhZSmRZK2xtQ1cvSmorcHY3QWRDcHlSekt0bDR4VEtJcmx0VnRFSU9X?=
 =?utf-8?B?RUlzMlZRNlIvajd3RjlDNGo1VGZMamVWNW1MQ1ZRczIvNDEvQmVvTk9yUkU3?=
 =?utf-8?B?ZXFZeng2aGVjK3pxTmZVUTE1cm9YaE9ISFhGSk5iZGk1SXdRQlVVMURpSkxt?=
 =?utf-8?B?QTBFcUtQbElKclpXUFBpVmZnV1RJMmgveTduQXJYallhU0dWbDl5LzJHUmwy?=
 =?utf-8?B?ZW5NU09qOVRCb3BFZGxmTjhGZGF2eU8wRDR1WE9RVnVBanpQbGU1VHBhanZJ?=
 =?utf-8?B?M09pMXhvb0c1anFuNHo0Slp1OVZ3UkdtbXJXTWJrQ0YyZURRU2EwMC9JNmhT?=
 =?utf-8?B?Zmg0aHprWHpFdVlwK2swTWRXYTdPQ0x6NXZsTnE3clI5MW94RW4zQ0N2bTBn?=
 =?utf-8?B?UmlVOUw3eDdsKzVDSFpVUlY0Zjl3dFVGQitudTljM00zb2oycFRFRGlQZSs5?=
 =?utf-8?B?SWF1dnZjaS9XSmhrMjdYdHJiTklyajRKR3daL3F4N0tTTk1lSlN0UlVzTENo?=
 =?utf-8?B?bldSLzgwN1NJZmpLUmlsWTd5RmRuS2Z5aVhYZUFwQ3RURmtWcE02TEhWTHBx?=
 =?utf-8?B?RlJqeVFPWGJMeXRDYm1ubWdoZmtoMVpOSXZDejhmM2JURkFDbDcwKzF2RDRx?=
 =?utf-8?B?YzdtS0VZby9kYTZwVis3Y0JMSDdxRUthVGZUOU5PVkNhK0tTeUlWZUhoaDhm?=
 =?utf-8?B?V3p5UVNPUkxrTnhTMWp1UGlhNFcwVnpCTWJ0eEZDbWE0NFdRREFaeFVYTi91?=
 =?utf-8?B?cTl1UDF1OEtPZGFhb1AveGtkdmFzeWd5SlVZNHJVWHNlYTdRS1VnbG15ZkpW?=
 =?utf-8?B?dWF6OXcwcWtlTjZHbnhBZStkNElUaktBaTNqZFVld2EwYVlOYzhYcU4vN1pr?=
 =?utf-8?B?bk5mRHJCZlJVMndvbzByeHgyUDRSQjhZcTB2eWkyaW1TVlVVU21PWnhEZTZ3?=
 =?utf-8?B?SzhjT3ZLTXRkYjArS1A1SFppODI1QnpoYnNPdE1KczhYZU5QZlFBUXRwdnJE?=
 =?utf-8?B?aE82Situcm9CQUk2dm5Fa3BVYXN3N09MTkZXVWhUc25ISFdnaWZHUXdUeFlE?=
 =?utf-8?B?RHU5bTN5Z2dIRHV6dG9aNytFdDQ4VnQzUGFEYTFHNEljQzZEOHVLeHdmZ2Zn?=
 =?utf-8?B?VmVhcEV3bTJITUxFVUNSdjl0SFlVYjNxZlpqdTdFV2ZQMDdIeHhXbjM1TUFX?=
 =?utf-8?B?TElVTmxUUktLUHR2OS9RR2RoVExnMXpHRTZuWk5UbGhObWV4eW53azlrNGZp?=
 =?utf-8?B?NXBGMkRON1kzVS9YT1pRQys4VGR5MEwzNDIwS0JyNFBnNlRFVENTV045alRK?=
 =?utf-8?B?eVJ0RXBBWklvL3dPVGlaNmlhT1d2R25LMEl4VGNUNlhXWE9LMFBLRWt4eGh4?=
 =?utf-8?B?Y3kraW56OGVhUmFlejUwSWNTSmNoNmhCRmpUVVJhazFaV3FFc0MxT0kxYjNH?=
 =?utf-8?B?UHQ0NmJxZTZKWDhiaGtWckFPWlErVmhDK3FpMVNmZ1VzUUZ4YWQ3RnVTT3Qz?=
 =?utf-8?B?U2VKT2lGMStLSzZGRXduNnZ2WWFUUGdaMUp0MGlFbDNMa1RZUUp0TWNFR0ZS?=
 =?utf-8?B?RENvd0t4WFZ5QWg0MmRxOXRzQ3lkWERQWFZBUEhqaWxSMkYreWNiaURUMTZo?=
 =?utf-8?B?L3ZpbWNPVmFOS3p1QmdvRE5Pa1JUdmZjUVF3UTdOT0RneVBTSFlVT0U0eE52?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d440179a-06d4-4ed2-f6e0-08dc1d0d8777
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 18:51:52.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33zj41ghIFrY2NtAehUP5h85H0y8j+4J4/Lcl2krSWqRf9nbXjU3t2GnSyhzyvd7ZmzYnjtKxUBqdT7qILo29g50Gp5cQYoTFvsjFDASWeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7397
X-OriginatorOrg: intel.com

Hi Boris,

On 1/24/2024 10:31 AM, Borislav Petkov wrote:
> On Wed, Jan 24, 2024 at 10:25:17AM -0800, Reinette Chatre wrote:
>> This can be confusing since it implies that the patch you mention
>> introduces the issue but instead the variable has been unneeded since
>> the original:
>> 92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")
> 
> What I said. :)

Right from the start, yes.

> 
>> To help clarify you can mention this order of events and also add an
>> appropriate "Fixes:" tag.
>>
>>> cocci warnings: (new ones prefixed by >>)
>>>>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1621:5-8: Unneeded variable: "ret". Return "  0" on line 1655
>>>
>>> Fix the warning by removing the variable "ret" and returning 0 directly.
>>
>> cocci warning was spot on*. This fix is not just a change to "make a
>> warning go away" but instead fixing an actual problem.
>> It can just be "Remove the unneeded variable and return 0 directly".
> 
> I'll fix all up before applying.

Thank you very much. For what it is worth, I do agree with the actual fix
and you can add:
Acked-by: Reinette Chatre <reinette.chatre@intel.com>

> 
>> * I'll add a private setup with the goal to catch these earlier.
> 
> Except that it doesn't fire with the patch that added the code. It looks
> like the cocci script needs adjustment...

Reinette

