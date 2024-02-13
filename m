Return-Path: <linux-kernel+bounces-64537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2113E85400F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91AEB1F24F87
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE3D63101;
	Tue, 13 Feb 2024 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etqD0OVZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F1862A1D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866825; cv=fail; b=OM1M6AHtRm4aOG95834twrKk6gYjCqkYVUrTb2uAHB/JfGPWOgzhRQEdw4iaqCi5aYzlQ+8vicqZrYFt6He9M8dPmUPuhx+pPyvTl5nwpSnn2t8ZNIGnN8Rr6onrX48iF4D+Ften0NBHRECqn5eYk/B5saV/idR0K5neODnFCak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866825; c=relaxed/simple;
	bh=lXIAtJVhAPpwl7x39NAmC0tPK4STas2u8/FiLx+1Mss=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LsTbq+aNL0so90Lm8KEJAvbyPCslBIoQCKiZlx1x0IdCFcAGr8GbZqqWg22w4aiXOt5zt5428CeBPbVz4eRxgwGzDqBXGsKTWATWT8rr4/7uXS/580XbuVdpGoXkSzPJY5SBNW74fK9hu8r2RQPqKm97PciXAOfkSWdlnaJ04sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etqD0OVZ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707866824; x=1739402824;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lXIAtJVhAPpwl7x39NAmC0tPK4STas2u8/FiLx+1Mss=;
  b=etqD0OVZakyUNg/WeX6fwaxbchUBmDTwkuf3DescsRXrb1gnVuwOF+KO
   Ghgs7Zts2Ip0VpPDbkTQRVeanZIhSkkeKyPJH5q6hR/84H14k7UB/iIFx
   SacrM8wtFBwpa3DS9nEVyf493iEQK2lXMlff/+oboGIFgxnnVd9/qG19t
   8fKqygg6+cYnjyzvaNF3fNySw4UKUYsA3/D8K9z6gJCtShXxZM/ElpNmH
   R3UkrHcH4LPXprc/ABZYD8oYkSYi6N7+9aT5f1cFFNQwWc0h+/c6L/OSQ
   y03NOWZfLlCtsAOkV6nUG2EubcDEyLLITUHczWdZzKa548ZX8ZX+yNT1z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1768514"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="1768514"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 15:27:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="2993959"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 15:27:02 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 15:27:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 15:27:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 15:27:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJMKyHhBVQHJ+HrzsH0rbN5u8nybN9JLmKowGvZePJPpFm8MVfs8wEsEoV57TNBleVjv1BGp+lxpRD47OfwoqhP/DTPAKgkV24nYVbFK/XRYqo/gM3hiRzFdjHFzC3GrKdpoSN+qR5R6ulSKciUCW8vxLPDMUsKAh0RL41M4+xzUajq3149BnBVvNKTs3qhG3ZbZAOGOWKJAllMmIlU5A6gAikCQVsr1wQBNetUYeiOVIAIJx/gee8TuxTfrGPyU2fAuze1DFJWWHP19dyArPSxNj6McmiEhqafdCkGTQXmpNqeXcLnYcVMp66p7lEgcT+dq8yRcutUMnZyO+SQ7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF9E3wwP6wbqRaJVc85BtcAjdCQAWL7rkeEcjkcyZfU=;
 b=XhEN2k5M9C+AUm0Mqq/zimKAjluJinL0Mv3dFuOHuod6KQkhkNERIm0G0qjbH2ITNc9NRVwu77d6zmqNKDLteSOsCY6XEgu2CeKjWxFU8SupwxozwPu1YVWQdPOjaBYF0LTJ5+q7HRrjX9V6Phiarli6FolYSNuWwZJ3biQlFIIrS4PDpNLkqI2PFRpxMBRz1Jve5B0aQxdoeiPcKSVnHNJLBK5pJvMQN03lo4vaR2XKZ9y5ebwsEiHk/QGWbNEQjgx6Vpq3ghmmDvyUb/MqTYgmTn16cqDR8+Xp4mn2w/oJ0jd4xJHIcrfjDtOu6J2R+B1RSyVGIqy2BOULnBuIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7366.namprd11.prod.outlook.com (2603:10b6:208:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 23:26:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7270.031; Tue, 13 Feb 2024
 23:26:59 +0000
Message-ID: <db3b27c5-e66e-4dd4-a56f-9e6928e26618@intel.com>
Date: Tue, 13 Feb 2024 15:26:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Content-Language: en-US
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, "Luck, Tony" <tony.luck@intel.com>
References: <20240213184438.16675-1-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240213184438.16675-1-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:303:b4::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b656dc-98bb-49be-0768-08dc2ceb466b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gH9LJGjRLRWwimn2jPej/fG4tGbYikEIVOLOQG6K634t8rH5uTp5w0YQXW/LNVhTL9bwtSbYJJaW5EREqFl19kBDtoia15sTUTXtg9PCfEzPIRUSVfeoLB3qgtOyGpWvnXtk2hbDBosQ5Q21EMHQLdUx10X9EkOEWW8aDQpY3PojwRDMH/w1Id4Rj7K+tBPfgokBhoi1lMQlPqnnmnGYrXKVD7pQ4294M+2mx3oAvx7Z7kYKyipfXWzjdqOfpsqDLdK6NBXwmLnWSKUJfJ6KHJycTDgZ6q1WOqQm6u5ZDebpSyogK+uLyrjfMBgqJQOpN0FAA6TM6JUa5Yn/+8/97Bqei1pq1cTCouAU2yV0pbnv8AYRciDq25RFXp0zYwzeNiP2GAwvlr952tGG5s2L1j2tZTP7gsaa35ClXynX80+1WnmwP/FqD4bNaGFjyxxSYN0vS53BfejaLHj/AUyE+APMadvH9woslWOoVZczVzEZBPO4ZxGfZlj8yPHxJn6+7ZZ2VB0DE5aGNTKAJyJil41r8Bw4+fGQw2q40HJUhxoaOfvrz0aw/YcbjLAvGBkZTg+RKaWTOODlvqi60G2+AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(966005)(6512007)(6486002)(478600001)(31686004)(41300700001)(66899024)(44832011)(8676002)(8936002)(4326008)(2906002)(7416002)(5660300002)(66556008)(53546011)(6506007)(6666004)(54906003)(66476007)(110136005)(66946007)(316002)(83380400001)(107886003)(86362001)(82960400001)(26005)(36756003)(38100700002)(31696002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDhjRUVMUlcrRjNGZTUwZCt4OUtiOVBJS2h1ZWJsdWQ3Y2hhL3J6dDFtU2g0?=
 =?utf-8?B?SU5YQ24rbkIrMTI5eGY0eitkSWYzaVdjTUpwQW0xUE9Da3IrTGtLMlFDUlZw?=
 =?utf-8?B?cWhHa0x3S2ZzWnlwaThGUEluVWVldFJOSkliQUZnSkVMZHpjSWNudTlSMXl2?=
 =?utf-8?B?UnFpSVZabThiN0JWcGJISk8yMWJiOHR5elRpZkZmN2FpdVM1VjBjR3FVdFp6?=
 =?utf-8?B?NHpCQUlCZm5Vc2EzdHhTK3VIQ1YvN1JsR1pWc21RODFXL3pEZS8vTzgyVnFX?=
 =?utf-8?B?TFgrMTcxald4V29oTkN6bFlNNjg5TEF1SW1GSFVwanZuWWFIcVFvSDBBYmdy?=
 =?utf-8?B?Q0duMUlhaG1OMTk4elB4UE5Ldk1xWlYvcFVoSjBzM3FnRCtrTTdEOUY5dTc4?=
 =?utf-8?B?NUkwRzFTYm1kMDFWRXZoY3FQaGdqbXVUYVF6eWRTS1QrbWs3NWlsM2hCNWYv?=
 =?utf-8?B?NUhMNFU3Q3lNSGROQlZUSnVtUE5nZktYUHRSanVZb1V1dmVEYi9mZDdJUWVU?=
 =?utf-8?B?NzBUcUNTWjk1cXN5M0ExbVBGV0l0L1B2NDEwYXgwYy8rLzNDcDJVQXhBTkhu?=
 =?utf-8?B?UHQ1Z1Z4Q1hhcGlOWTRNeDV4c3RjVC9LVzFIcmFFM3Q1T2pwbXRuL2llOTMw?=
 =?utf-8?B?NDhISndnQytHMUt4YjZJaHh3SThaemdLS3RDblV3YWQ1V0NFdU1kMG80czJs?=
 =?utf-8?B?OEs4OEpWS0J6OTFFUXhQZStINS9iYUw5ZGkxWExhMStkdmwzNkNUUGVoZUpu?=
 =?utf-8?B?TTlRWjZ6QlpGVnFNRkszTWxzZGNuU0dGNnZjNVEyYWI4Qk1IcHhPOUZzK2x2?=
 =?utf-8?B?SXFCdlYvK1FxRzgwamZzck1mVUJnYkc4RjVxSERXcWhHVHA1RTJ6L251YWcr?=
 =?utf-8?B?aWYzbmJuKzhxZ3VhdEpWOTFzVUJnVnU1a0tQc2JOQU10d3MrVXNOSnJQanZv?=
 =?utf-8?B?OUtLMkswOWFFLzVOeXArVzN4YnFOazJvOXVTRk9uUThnL0E3YjhNbkxSMXRP?=
 =?utf-8?B?NUs0dktmVnRIUUFVUVRzK3VSNXEzQ2h4aHJFN3MxbjVxTDJJVjJxL2k4UlZq?=
 =?utf-8?B?Vi8zU0J3SVpFNmpDUklNSnRHQkpsWDJpcmxmNWZabUtBK0RNejdsVjNFWGRy?=
 =?utf-8?B?M2pKdm9jZm9ta1laQU80TG5nbTZEWmlFNjNuQmtPanhmSnljd0pIRTFsZW1i?=
 =?utf-8?B?OGI4ellYc0h6U0dCNnlXdW5jRTd0cS9BaFFXTThMTEMyUlRCMFlNTTJqRW1L?=
 =?utf-8?B?Und5bkF4TDMxdTVuQkxHU0I0SXhmcnh2SHBLdHFIVTkvZ1p6Zi9uaWt1MDhw?=
 =?utf-8?B?UXh5NGx4dWZud20vSm1IRUk2Z1Flenppdnh6NE43UW43NS8xOWQ3dzdJRFJp?=
 =?utf-8?B?T1ZYejBobWljc011NkJTaENVOXpuMG9BRFg5R2pWWHVyQjhDaFhvNUZzcXJ5?=
 =?utf-8?B?MTlFU2piOFBBTHJKak5LV3JxcGdCaGFnSXZUTS96WmtaQlFnN1pvVk5DS0ND?=
 =?utf-8?B?cUd5c0F4SWhFTWp0VTlDN2IvaXd6TmF0NTRCWjA0UGJ6cDljWGdSaVRTVkxP?=
 =?utf-8?B?dnFsNHpmT0xVR2RzVVFNeHpWQ0RqZHVWOW1BWUhOaW5kZ0x4NXlsVUJmQ1RI?=
 =?utf-8?B?dGs2OG51cE53TEEzQWs1VXBZRFBna084UDRaTktMT2JKdkIyWWpIdi8rY2FM?=
 =?utf-8?B?SEdQWndBZ3lIcVcwTWxMWjd6cktzLytkb2tRWE9QQzdtSmtES0J4Q0RiRk9h?=
 =?utf-8?B?M2hmN3hQaDlmZUpIa2RXUzZ6anlmVTNmVGhjdGhEeEZuTU1zUjJadGNzcSs2?=
 =?utf-8?B?ODR4NlZuK0Vhek52VWFCbS95SjlkL0YwbnFLZkExRWhxVlVIR3lIRFU1MFAv?=
 =?utf-8?B?MmVuZ0prZ0ZvS1NPMzhURURiMUpJVmRxMDMyTm1NKzUzcWJCa1ZPVmk3RTB0?=
 =?utf-8?B?b0M1Q3praUJRWCtONkx0bVNpd1laQVVZY004cDFKTG9xY1loaDI3SGYxKzl4?=
 =?utf-8?B?ZnpwTytRcjdXSFVDc2IvcVBKOXlTZjJZU01UYVR2VmczeVdiQVMxN2lmSWV3?=
 =?utf-8?B?b1hrT3RoSXRtRTIrNDROSHVaNVAvdm53MUZaYVZhU21weG0ycjBlL0F1ZVhW?=
 =?utf-8?B?RTUrbm1DdlV3d0JORERpbVk0TFFUL2JjWUYvQlZ1TDJ3WnYvdEdYcjB0emhQ?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b656dc-98bb-49be-0768-08dc2ceb466b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 23:26:59.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ocl0WH3hRZrKTkRW+URQxOt17V6K0fETAsj1m5z7DJHgULn3ExmW3GvOWPZ5co4tMCqpJCCIWsz3f8e/GVShd8Rfxp5MOHg83+G7g73YKMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7366
X-OriginatorOrg: intel.com

(+Tony)

Hi Boris,

Could you please consider this series for inclusion?

Thank you very much.

Reinette

On 2/13/2024 10:44 AM, James Morse wrote:
> Hello!
> 
> It's been back and forth for whether this series should be rebased onto Tony's
> SNC series. This version isn't, its based on tip/x86/cache.
> (I have the rebased-and-tested versions if anyone needs them)
> 
> This version just has minor cleanup from the previous one.
> * An unusued parameter in unused code has gone,
> * I've added a comment about the sizeing of the index array - it only matters on arm64.
> 
> Changes are also noted on each patch.
> 
> ~
> 
> This series does two things, it changes resctrl to call resctrl_arch_rmid_read()
> in a way that works for MPAM, and it separates the locking so that the arch code
> and filesystem code don't have to share a mutex. I tried to split this as two
> series, but these touch similar call sites, so it would create more work.
> 
> (What's MPAM? See the cover letter of the first series. [1])
> 
> On x86 the RMID is an independent number. MPAMs equivalent is PMG, but this
> isn't an independent number - it extends the PARTID (same as CLOSID) space
> with bits that aren't used to select the configuration. The monitors can
> then be told to match specific PMG values, allowing monitor-groups to be
> created.
> 
> But, MPAM expects the monitors to always monitor by PARTID. The
> Cache-storage-utilisation counters can only work this way.
> (In the MPAM spec not setting the MATCH_PARTID bit is made CONSTRAINED
> UNPREDICTABLE - which is Arm's term to mean portable software can't rely on
> this)
> 
> It gets worse, as some SoCs may have very few PMG bits. I've seen the
> datasheet for one that has a single bit of PMG space.
> 
> To be usable, MPAM's counters always need the PARTID and the PMG.
> For resctrl, this means always making the CLOSID available when the RMID
> is used.
> 
> To ensure RMID are always unique, this series combines the CLOSID and RMID
> into an index, and manages RMID based on that. For x86, the index and RMID
> would always be the same.
> 
> 
> Currently the architecture specific code in the cpuhp callbacks takes the
> rdtgroup_mutex. This means the filesystem code would have to export this
> lock, resulting in an ill-defined interface between the two, and the possibility
> of cross-architecture lock-ordering head aches.
> 
> The second part of this series adds a domain_list_lock to protect writes to the
> domain list, and protects the domain list with RCU - or cpus_read_lock().
> 
> Use of RCU is to allow lockless readers of the domain list. To get MPAMs monitors
> working, its very likely they'll need to be plumbed up to perf. An uncore PMU
> driver would need to be a lockless reader of the domain list.
> 
> This series is based on tip/x86/caches's commit fc747eebef73, and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/monitors_and_locking/v9
> 
> Bugs welcome,
> 
> Thanks,
> 
> James
> 
> [1] https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com/
> [v1] https://lore.kernel.org/all/20221021131204.5581-1-james.morse@arm.com/
> [v2] https://lore.kernel.org/lkml/20230113175459.14825-1-james.morse@arm.com/
> [v3] https://lore.kernel.org/r/20230320172620.18254-1-james.morse@arm.com 
> [v4] https://lore.kernel.org/r/20230525180209.19497-1-james.morse@arm.com
> [v5] https://lore.kernel.org/lkml/20230728164254.27562-1-james.morse@arm.com/
> [v6] https://lore.kernel.org/all/20230914172138.11977-1-james.morse@arm.com/
> [v7] https://lore.kernel.org/r/20231025180345.28061-1-james.morse@arm.com/
> [v8] https://lore.kernel.org/lkml/20231215174343.13872-1-james.morse@arm.com/
> 
> James Morse (24):
>   tick/nohz: Move tick_nohz_full_mask declaration outside the #ifdef
>   x86/resctrl: kfree() rmid_ptrs from resctrl_exit()
>   x86/resctrl: Create helper for RMID allocation and mondata dir
>     creation
>   x86/resctrl: Move rmid allocation out of mkdir_rdt_prepare()
>   x86/resctrl: Track the closid with the rmid
>   x86/resctrl: Access per-rmid structures by index
>   x86/resctrl: Allow RMID allocation to be scoped by CLOSID
>   x86/resctrl: Track the number of dirty RMID a CLOSID has
>   x86/resctrl: Use __set_bit()/__clear_bit() instead of open coding
>   x86/resctrl: Allocate the cleanest CLOSID by searching
>     closid_num_dirty_rmid
>   x86/resctrl: Move CLOSID/RMID matching and setting to use helpers
>   x86/resctrl: Add cpumask_any_housekeeping() for limbo/overflow
>   x86/resctrl: Queue mon_event_read() instead of sending an IPI
>   x86/resctrl: Allow resctrl_arch_rmid_read() to sleep
>   x86/resctrl: Allow arch to allocate memory needed in
>     resctrl_arch_rmid_read()
>   x86/resctrl: Make resctrl_mounted checks explicit
>   x86/resctrl: Move alloc/mon static keys into helpers
>   x86/resctrl: Make rdt_enable_key the arch's decision to switch
>   x86/resctrl: Add helpers for system wide mon/alloc capable
>   x86/resctrl: Add CPU online callback for resctrl work
>   x86/resctrl: Allow overflow/limbo handlers to be scheduled on any-but
>     cpu
>   x86/resctrl: Add CPU offline callback for resctrl work
>   x86/resctrl: Move domain helper migration into resctrl_offline_cpu()
>   x86/resctrl: Separate arch and fs resctrl locks
> 
>  arch/x86/include/asm/resctrl.h            |  90 +++++
>  arch/x86/kernel/cpu/resctrl/core.c        | 102 ++---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  48 ++-
>  arch/x86/kernel/cpu/resctrl/internal.h    |  67 +++-
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 463 +++++++++++++++++-----
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  15 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 359 ++++++++++++-----
>  include/linux/resctrl.h                   |  48 ++-
>  include/linux/tick.h                      |   9 +-
>  9 files changed, 921 insertions(+), 280 deletions(-)
> 

