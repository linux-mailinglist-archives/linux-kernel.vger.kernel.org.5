Return-Path: <linux-kernel+bounces-15637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E957822F41
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882C51F24245
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EDC1A58E;
	Wed,  3 Jan 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSJ0Was5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3831A582
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704291384; x=1735827384;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=pRLSIQSevRrXm/kuteIsxKM118FcYKE3sp/ujkzPeo4=;
  b=eSJ0Was5P9Py6c0+udTtgZwvZH8iQcq6V0ctwkkbJJ3mxQ7mYOpMANFM
   uJVOjZYHUWF6PxHMyJy4xzHqHbqGKv8CxLldhtfZHUc770Vcb2gT9ANlX
   TvSDvWbhIcTQEU3b0nTczWEMptJSwTXBwD45+AAbXVvJ6KWpA6eZQGScG
   jEvq7XuEP7j5/4cNWb0Cq8McPfEZPuaVRhXEuqRVwHY/Co+WUicHFisLZ
   fcyToWlLFK3kAenk/3Fh9NTx3/IBGU4VN4KPJPzLKGiObLkGDB+1k9MuO
   3kEH0cGJNVswzNposkWg3C8/nwNxJjmkJnsM+L2TW9v9/JpdMuPj9OJYP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="399784215"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="399784215"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 06:16:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="28369957"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 06:16:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 06:16:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 06:16:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 06:16:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 06:16:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCihvRKCJK3l7ixiLSWsxSw5hLimlgTi41K1SXxAzoQG3kLucgWTFPVlKBVCCRo9Qjk4OWLRKDGXeRsJZHU6yGZtxbncSzXdYk6mpmRwG/m2497LZtS8H97rMPbs/JdavipJb+2lsTBLhOvy1ag4M4QXwMseGpaphwStXYf/Oo8PS3n4qNz+gfGxRnAgJPNdVVlEOoqmN+0/fpX/erCT86+/6Gls11MgPb/xRM6TAdv92ezRorD64Oz81BmP1eTZH8lRxGxwRZbimWx4klZC5oliSAOskOX8sbBxqwuXOI/HjWi5OGjV08A4QW7o2IP6HW0rq0+2v1O3nFEGlEmH3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w8/NrlYhw0zlqDICVTGIH71GqtOshS18e1ygiMpAas=;
 b=dMYuSn61NOQJm+BXsPlcxrQhMGlpfu2FUI2jflWyvAljRus/EHnwgMZ4ln6E9x1SUlcYO3VKa2IMV2vq5qKf6ADW13mXjKhwpq21PMUWrXUTmzCkTA0ZrW5A2YbA+XpXx/v3s5HbeGRuGixLXotwpS4leZmdKzSFvxYo3rU6vS/aDEViWsoRYejPFb4YvQxMfKyK56lJGjVC1vKnTU6QiIZkUUH8DcJfeURX2/f8HTO1fD41hieBFUI6WfkYLLAeYGYQG6rIfbZDh1QbZOKYHA3l7V63TJvou62ROuC2nq67jW4JMA3yFbHsRuIAWA+LO+lqitDL9y2Kn2LCr+yu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM4PR11MB6358.namprd11.prod.outlook.com (2603:10b6:8:b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 14:16:20 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 14:16:20 +0000
Message-ID: <3feecbd6-b3bd-440c-a4f9-2a7dba3ff8f1@intel.com>
Date: Wed, 3 Jan 2024 22:16:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in __folio_rmap_sanity_checks
To: David Hildenbrand <david@redhat.com>, syzbot
	<syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <ryan.roberts@arm.com>,
	<syzkaller-bugs@googlegroups.com>, Matthew Wilcox <willy@infradead.org>
References: <000000000000014174060e09316e@google.com>
 <c4e2e700-2d26-492f-8eb2-eb3ab14bc07a@redhat.com>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <c4e2e700-2d26-492f-8eb2-eb3ab14bc07a@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM4PR11MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 371b5ab7-690d-440f-b287-08dc0c668e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brrOdrB4whNbV0kyGMIhy7NHkvTZ5wHlFch97c9csXHNnJFiNVxg0NeYKqwzt37CxTHla7M4DetaE8clCMt0Cmq+uiHybTI/O6IajMb9sbDUk5AWnWAp9/cf8PBSH2ktiQQ6dR86vCd4qqQv68mVTUncSj9V8RmgJHcUDY2o2MrbqXq0fvkLZk1ufifNYMsf+SQsY3Q6I6SKz9rqF5kEa7T2A6De3bGaFwUNHEvcur9Un3ufSWYstsXd4O8Q7APhIS4gBm5FYs2SiPrdX0h2+8cOMIjPaaxPdZ6opGo2ycUazqD3BVi92i7Sqsyp4BjuIchO0ln1LuSF4gesjUcjNH5vr+a62Cw8YFcY4aEJvYgJn23X0cAzXNxUq9X/LwM18B1/mclqyloSWFHZ/PZVwqmyNTl6JjgaGN971z6MwFGorrU5SbvSdXI3j9RRvz/6mTW44M6GesolhtTbu2CUOauvGh8K/n5VKC9w97x5nUsCZ4Mo2pElQKqVvi4ouyw0jZXbM6HlI5+iHpXOU1xeRbjLqSkmm5QuJFTYcHX5wxL1JsIPikahHXCGlM5fdII+1buBWrcFHLrbzLlsbXg1jGbr8GtPoHVXDhjEmLqQ69RunOD8UINnINmV280JnL7gvVfdvdnwZN55y77vr2wL952KmRppaqkc9IUrh03ekQMPxkYnInnv5z3wnLV4ui4Q/tWGl6FZKUnl17KcbqCggA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(396003)(376002)(230173577357003)(230922051799003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(82960400001)(2906002)(5660300002)(36756003)(41300700001)(31696002)(86362001)(110136005)(83380400001)(478600001)(6486002)(966005)(316002)(66946007)(66556008)(66476007)(53546011)(6506007)(6512007)(6666004)(31686004)(45080400002)(2616005)(26005)(38100700002)(8936002)(8676002)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEY4WmMrUld3ckJ5NWsyVnZITGRaZ01xWk1TdVZ0cVJtZ203L2hCUWlrRitJ?=
 =?utf-8?B?KzNBeTNXdmhwTHFaeFFROEk5WWhFUzBuTjd4SnlQVTExWjVZZDM4NkpFWW54?=
 =?utf-8?B?QUNUOThaQnRZZ3ZCYUNoQ2FsY3hSY29PNkFJNGJZSjNCcmpMTXFrMDZwNzV5?=
 =?utf-8?B?SS9BdjRmaE81dWpySWptaDR1a3dXd3FTUCtqKzFsdW1nNHhqeHpPSXBwdHpj?=
 =?utf-8?B?RC9zRWYya3Q5OWNteExhTHhYWFVuY2dMbUEzY1p1RndjcXAwazBuMDE2TEJm?=
 =?utf-8?B?TEVXWjZPSTVBSUR3ZGlKMDBvWko1cDhuTzdXVFNxeXdxVWpZU2xFR2FCekNU?=
 =?utf-8?B?MW40M0Y3dGFRaWZveCtuVkd1Yy8yOFRZdlY4alE4SExJTmY0TTdhRkxrRldk?=
 =?utf-8?B?cWFXVGx0amdRVWN3eVkrY3o3VEtTVWUrYmVkZHhGZTMvRzFzYzA2cmpSQ3l3?=
 =?utf-8?B?VjJhcEQ5ZjVwV0w0YXFmQksyNkZtT21RNzF4dkxrOVFlaFpUUmxnazAzcDJs?=
 =?utf-8?B?cDZXYzY2cnpCQTVkdUdFYVVXT0x6YVpmOTZNRUpxTXV1akl2eTQ2OHgvUm1S?=
 =?utf-8?B?V0pMSUxhb0tOMWdaRmMzQkFxMWJiTlVZNFVMU2QxOEd5SmJKSGpyckovMjVk?=
 =?utf-8?B?MUtSb0s3Q1lveWJQYnROazlEekNKUkhoM28xSUNDa0xBVlhYb1RIdE1LWmo4?=
 =?utf-8?B?SUZrd3V1dVRpblhOeEFQTW9DdFA5dVZhN3ZGNEFUZW9sZ09Ea0M5YzJPNWJw?=
 =?utf-8?B?WU9HOEU5VnRmbGxJMXNCd0lad3BrUmpBdVpkVVcrR0JMQ1RpQUJRUUNVby9N?=
 =?utf-8?B?c2VEdXpTR0VQRHliZFo0QXQ3bTk4N2hNTHp0NGIxT2poU1JGOXB6RTJWVjlM?=
 =?utf-8?B?TFY0Ry9MOWVBK2wrME9YZFdVSVlFOWpGMTBzQ240RnB0MWpRYXQ0WnFRTzF3?=
 =?utf-8?B?ZVEzODFMUnVvSVBvKzZVVFp6R2hDV1dORW8zVFNMV1paNWlTamFMbHZIaVNP?=
 =?utf-8?B?QjJuS3cyQ2lZZlhrMHQvNDFlZFI5TVJFbE1kdGc1MmlCVTU1NzYyU2ZYU0V1?=
 =?utf-8?B?azdjbkljTEluaGdrWE5OeldncG1LMEF1UzNhM0k5aGU5a3NyWWxBVTBoNHVz?=
 =?utf-8?B?TG12R0dqUVFLWEpOUk5Vd1dFaHpQOEpKYi91WjEyNTlFYlVOdXFZRXVrYU9x?=
 =?utf-8?B?VzgzZWRpbnJha3gzRzhLalJjak9nQ0gxaGYrK2tZQTgyL3VNRkRQR05FZFlE?=
 =?utf-8?B?amJPd1AxaDBybmkyQzExZ2htVUZGbWUxN29JQS8zZjdZd3BRbFBlRmRxSExV?=
 =?utf-8?B?YkI5V2pHSThTUkQ1SmMxakEyVjZ2amNsKzJnVTRpQVM4ZGVZVVRYVHhDeEtX?=
 =?utf-8?B?TVRGc2N3VDhYYWl4V1NKQWxJN2ljQTNPVGhsRjBOVnhOcEM3anJmNXRSUE1r?=
 =?utf-8?B?K3RFQ0dTQmk3Tm1MemZWekFrdGZtdzQrRU1pZ3ZjUFNWdlJRbkx0dlpNdk5X?=
 =?utf-8?B?QjRHc0R4bCs5V3p6VG42SnF3VTA0QVd0MW5HTkdmemlrN2tBd2lPREFCV2I4?=
 =?utf-8?B?MUxxcFg2K0FRb3h0UDc4bzNSaGgxUDZtN0toNjI0Zm41MlFqSVk1QUpWV0Vv?=
 =?utf-8?B?dXZiNkxGY09hSUkzbW5vZ2RIazFtemMwK2dTejdzc0hrT21Jd3JwL1plTGd1?=
 =?utf-8?B?ZkYzSHlEZ0syK3N4TEFGZ0Q1RWtGMFVlL21WaldEZVBkdCtFMjhQQ3lsY3RC?=
 =?utf-8?B?WUxNUGtpWVdHMWdtdTBwN3VYOXgzUFJnYUhJVXhIQ1I5K1pJVTdJRG1heHZa?=
 =?utf-8?B?WmFPZXdNQUo2a0ZseUZaRnZROGtlc214bENGUStQODZLR2w1UDFwNUpJakg3?=
 =?utf-8?B?RlpZTHFHM0h2Tk5IZWltazR3TXVYeDhITGhIRkhma1V1SGRaRzBvM3BHM3Q2?=
 =?utf-8?B?U29XdEk2QVUxeW5UQmNOeHlMaUVYL0dNTGhORFowclZDV2l2RXpJclhIT2NI?=
 =?utf-8?B?RkZMUkV0UngxSGxYK3VuWnFxdmdFSlJ0MVhBQXVuQkJUdHJwcVp5QysvVkUv?=
 =?utf-8?B?WFNxcFl5dllLaktwOU9xQjNCck56eWRYTEVMQno4V3ZlTmlkZ0NOUzBnNFdN?=
 =?utf-8?B?UkgxN09qSEllSENYdFlHdmc1Zzhoa0RGb05VeGxPSnFGemx6U2EwRFFRNWtD?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 371b5ab7-690d-440f-b287-08dc0c668e7b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 14:16:20.3615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQCdIn5lrRpk7QTipjxCrmmNNON1x5uUEaZXNKOy8mMVjxgFupzZr9cv43ezikl8rQJCXTThOOlo+G+67ivgPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6358
X-OriginatorOrg: intel.com



On 1/3/2024 8:13 PM, David Hildenbrand wrote:
> On 03.01.24 12:48, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    ab0b3e6ef50d Add linux-next specific files for 20240102
>> git tree:       linux-next
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17be3e09e80000
>> kernel config:  
>> https://syzkaller.appspot.com/x/.config?x=a14a6350374945f9
>> dashboard link: 
>> https://syzkaller.appspot.com/bug?extid=50ef73537bbc393a25bb
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils 
>> for Debian) 2.40
>> syz repro:      
>> https://syzkaller.appspot.com/x/repro.syz?x=14e2256ee80000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b57db5e80000
>>
>> Downloadable assets:
>> disk image: 
>> https://storage.googleapis.com/syzbot-assets/4e6376fe5764/disk-ab0b3e6e.raw.xz
>> vmlinux: 
>> https://storage.googleapis.com/syzbot-assets/7cb9ecbaf001/vmlinux-ab0b3e6e.xz
>> kernel image: 
>> https://storage.googleapis.com/syzbot-assets/2c1a9a6d424f/bzImage-ab0b3e6e.xz
>>
>> The issue was bisected to:
>>
>> commit 68f0320824fa59c5429cbc811e6c46e7a30ea32c
>> Author: David Hildenbrand <david@redhat.com>
>> Date:   Wed Dec 20 22:44:31 2023 +0000
>>
>>      mm/rmap: convert folio_add_file_rmap_range() into 
>> folio_add_file_rmap_[pte|ptes|pmd]()
>>
>> bisection log:  
>> https://syzkaller.appspot.com/x/bisect.txt?x=10b9e1b1e80000
>> final oops:     
>> https://syzkaller.appspot.com/x/report.txt?x=12b9e1b1e80000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=14b9e1b1e80000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the 
>> commit:
>> Reported-by: syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com
>> Fixes: 68f0320824fa ("mm/rmap: convert folio_add_file_rmap_range() 
>> into folio_add_file_rmap_[pte|ptes|pmd]()")
>>
>>   kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:283
>>   __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:324
>>   kasan_slab_alloc include/linux/kasan.h:201 [inline]
>>   slab_post_alloc_hook mm/slub.c:3813 [inline]
>>   slab_alloc_node mm/slub.c:3860 [inline]
>>   kmem_cache_alloc+0x136/0x320 mm/slub.c:3867
>>   vm_area_alloc+0x1f/0x220 kernel/fork.c:465
>>   mmap_region+0x3ae/0x2a90 mm/mmap.c:2804
>>   do_mmap+0x890/0xef0 mm/mmap.c:1379
>>   vm_mmap_pgoff+0x1a7/0x3c0 mm/util.c:573
>>   ksys_mmap_pgoff+0x421/0x5a0 mm/mmap.c:1425
>>   __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
>>   __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
>>   __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x62/0x6a
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 5059 at include/linux/rmap.h:202 
>> __folio_rmap_sanity_checks+0x4d5/0x630 include/linux/rmap.h:202
>> Modules linked in:
>> CPU: 1 PID: 5059 Comm: syz-executor115 Not tainted 
>> 6.7.0-rc8-next-20240102-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, 
>> BIOS Google 11/17/2023
>> RIP: 0010:__folio_rmap_sanity_checks+0x4d5/0x630 include/linux/rmap.h:202
>> Code: 41 83 e4 01 44 89 e6 e8 79 bc b7 ff 45 84 e4 0f 85 08 fc ff ff 
>> e8 3b c1 b7 ff 48 c7 c6 e0 b5 d9 8a 48 89 df e8 5c 12 f7 ff 90 <0f> 0b 
>> 90 e9 eb fb ff ff e8 1e c1 b7 ff be 01 00 00 00 48 89 df e8
>> RSP: 0018:ffffc900038df978 EFLAGS: 00010293
>> RAX: 0000000000000000 RBX: ffffea00008cde00 RCX: ffffffff81687419
>> RDX: ffff88807becbb80 RSI: ffffffff81d06104 RDI: 0000000000000000
>> RBP: ffffea00008cde00 R08: 0000000000000000 R09: fffffbfff1e75f6a
>> R10: ffffffff8f3afb57 R11: 0000000000000001 R12: 0000000000000000
>> R13: 0000000000000001 R14: 0000000000000000 R15: dffffc0000000000
>> FS:  0000555556508380(0000) GS:ffff8880b9900000(0000) 
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00000000200000c0 CR3: 0000000079000000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   __folio_add_rmap mm/rmap.c:1167 [inline]
>>   __folio_add_file_rmap mm/rmap.c:1452 [inline]
>>   folio_add_file_rmap_ptes+0x8e/0x2c0 mm/rmap.c:1478
>>   insert_page_into_pte_locked.isra.0+0x34d/0x960 mm/memory.c:1874
>>   insert_page mm/memory.c:1900 [inline]
>>   vm_insert_page+0x62c/0x8c0 mm/memory.c:2053
>>   packet_mmap+0x314/0x570 net/packet/af_packet.c:4594
>>   call_mmap include/linux/fs.h:2090 [inline]
>>   mmap_region+0x745/0x2a90 mm/mmap.c:2819
>>   do_mmap+0x890/0xef0 mm/mmap.c:1379
>>   vm_mmap_pgoff+0x1a7/0x3c0 mm/util.c:573
>>   ksys_mmap_pgoff+0x421/0x5a0 mm/mmap.c:1425
>>   __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
>>   __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
>>   __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x62/0x6a
> 
> If I am not wrong, that triggers:
> 
> VM_WARN_ON_FOLIO(folio_test_large(folio) &&
>           !folio_test_large_rmappable(folio), folio);
> 
> So we are trying to rmap a large folio that did not go through 
> folio_prep_large_rmappable().
> 
> net/packet/af_packet.c calls vm_insert_page() on some pages/folios stoed 
> in the "struct packet_ring_buffer". No idea where that comes from, but I 
> suspect it's simply some compound allocation.
Looks like:
  alloc_pg_vec
    alloc_one_pg_vec_page
         gfp_t gfp_flags = GFP_KERNEL | __GFP_COMP |
                           __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;

         buffer = (char *) __get_free_pages(gfp_flags, order);
So you are right here... :).


Regards
Yin, Fengwei

> 
> Likely, rmap handling is completely bogus for these folios?
> 

