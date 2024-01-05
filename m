Return-Path: <linux-kernel+bounces-17609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47D3825021
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C1E2843E2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E082421A1E;
	Fri,  5 Jan 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nye9a+eA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5A1219F9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704444124; x=1735980124;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=IjHw9q8Kki5OPV+kGGCdkFmXkMd30zU19w3iid1kxzY=;
  b=Nye9a+eAxKSW+1ErzTZnFlUvZWTvhJdluX4wuFGgPMNt/PBR4wlPK0cz
   aEPHfN+QUzXiDZj7M66D6a2DYJDnr6WaIdEFAu9VhpdNEJ2nF/koRDLtR
   NKWOS4sGhpHvBWymdtbP4bCWMN6a/p8wliEiFnYHK0lfZ8wxXWThwtWKd
   xp2ldcMIb/yi8ZhjLEjkNNUtR6ySRSGRAN5HhjxLFxXoY9bUqMWaylT3B
   uj/Qd9vvWY3YsD11HojRGiozvKZT51GsMazm7kPYprr/oh9YdvsKCMrwJ
   TRyQoVcqgEoQugKgMOkfpObU55zmFQS34K9RC+QwGjveBVdkKTKpofS7/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4835033"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="4835033"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 00:42:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="953889201"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="953889201"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 00:42:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 00:42:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 00:42:02 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 00:42:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+kZwz+ZopfW1rg2b6GYBzJmmNFYlUYPrcCXAgo5zTlkhpddJlOQ+Ie5mKFKDCzoDjFJ1gfhh7q83zGujZL/zdDE3q5pBZNNmtP2ifGXGoyYIL4hdlq+A9WfYEjCh9sNgQBqySUkbF3USZ8E4gOZ+zRKp0A8qnnRyHexYBjVB2vsAvAvxZVo/d0lYwX/fK7xymNvtXE9QHSR/18EVS9ywk/teNOUxxoWOU8xWfzTFdE9OEUo4umUDIeClAJ/4GZg+W9KjuzV2+tNBioo6x7WOd723rE9u+1wXxhfElm1fWPJQpHLpgs5ZIh/Ua1alA9CjC/nyI4VyIG9NIKrffiIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9Ag9th4HPznnlTce1lli1x8T7stEty7UefrJY45IRk=;
 b=lbn12auhm6CKU9wbuIjtxnixlP3GwgT6AIcQXUL1aFAludZwU4tWJfuah4fZrtBHDX31A/63lnEAzo4UWjMS8hIdbEi55oKmJQLwKxDPQ7Fyhb8O1bUSNhX2hJo0h7BokRj/gGqUUy8jiKoypt3k0xu22PS+oV2dKObYZ/A9CwYSDHu5mhO45boIyXFOwX7x+GHgSD5yCbNoamIrVyO8eM0hdau4+xrXPOMcKfgVPAEbzzM5t0Ox/AFvEx+7R5rsXIov8U1c3q5ZfWqeHycS0eLsrrKM24bWsv5SJCrjaP1If9/HDXWW68loQqAF+N9QXIYNrR9EdXXA08LR9oi90A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA1PR11MB6394.namprd11.prod.outlook.com (2603:10b6:208:3ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 08:41:53 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 08:41:53 +0000
Message-ID: <f8eca7b1-08c9-48a6-b7f1-cbf9cb6b568f@intel.com>
Date: Fri, 5 Jan 2024 16:41:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in __folio_rmap_sanity_checks
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
	syzbot <syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <syzkaller-bugs@googlegroups.com>, Matthew Wilcox
	<willy@infradead.org>
References: <000000000000014174060e09316e@google.com>
 <c4e2e700-2d26-492f-8eb2-eb3ab14bc07a@redhat.com>
 <3feecbd6-b3bd-440c-a4f9-2a7dba3ff8f1@intel.com>
 <36ace74a-1de7-4224-8bc1-7f487764f6e2@redhat.com>
 <8bc02927-a0f0-490a-a014-0e100d30ffe4@intel.com>
 <1eb61435-c89c-4ca1-b1b6-aa00b3478cd2@arm.com>
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <1eb61435-c89c-4ca1-b1b6-aa00b3478cd2@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA1PR11MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: e6305bf0-4061-46ae-45e9-08dc0dca2aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zu8RBvRxkuJrWDsQBL6ZwLJZaeEiXh04q6bpwCpB0W9CetqD7kakyK9JUxgmQ/Hu/LXz1d/I9kDaDPVJquUtUz6BozmWiOlOl123vri1VqbyPwqWP3+A7+spAYjSzL2Oa6vq2kzQEpmWfmDNxSzgUnUuHf/gR9Ju7Q/dp8Y8WKe4ikkTB4WxsEgEf3OtnN5F6t1eVYoZPcFcBhiGj4f9CHCIU55mnusPry3BETu8HiACNYpH0F8clh8Orh+2ct9V40ZAVLoP6mThZy+tgYOxFV1s0dR9/HpE+nEDjHLTcERKL2R87Dz7Wcm3TO0+CKT6lDXWZZr2KIY+kOqSnpvounTElpikrs/C6o5gYesqL97nRq0Hh4PMTeTRhO8Am699hSZgHUxVQXvCTlDHEhY7ZB5eBlfSlFpLM5bmpWoP5PGWk996hqnKBXYnwzw8AL3KAyUkfSVFR7u5qxO1UGZ7qKG5MC4rN5XeNXMUAlk2ftVZ+fEk5vUeoR7NgVVheBiQ5YFfz9pJN8BuCLf3n2B9kPeaXa2hHnWSeekM4d9fdFFAhlGeJ+jCxFpBE1cfxU7Pg5DvtZDX+Qih3Pu4GZLwK4MmcWe6RD9vHb5mzcYlP6yks7KokXmoVUm49dhDhdtsXFqqetTgH4ZHGtcdm1ccVlpqRsbGDNcaaeLexG1qa3ufgbmG7uMnK1F8JHgoRcA+/GScjkjxl03kITHG3mwhFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(478600001)(45080400002)(6666004)(6486002)(966005)(2616005)(86362001)(31696002)(6506007)(53546011)(6512007)(8936002)(8676002)(110136005)(36756003)(316002)(41300700001)(66946007)(66476007)(66556008)(38100700002)(83380400001)(26005)(82960400001)(31686004)(2906002)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGFyZ2RwWllMbmtXU0tEbit2ZEkxc2VlMWJ0NFlZM1dab2l5S1dJZTlvdHhC?=
 =?utf-8?B?MFdoODBsNjdUSjYvclFBc2ZhbnplcVlOdXRRZnFxNGRUVlJvbzNjcHYwYi94?=
 =?utf-8?B?allsZnZYZ2M0QlFrRnlKemh0L1dSbmFQWVFuZXgxMFBxMWFUWGFlVnNEem1U?=
 =?utf-8?B?L0ZZeHhTRFZEUEpSOGtyN2l1MVJXMG9WM3NFL1pKRGFZempDYUx3Wk1MRUEx?=
 =?utf-8?B?UnhlbXltNmxmQlJHWU1Td21DRm5qYkp3WGRDa1duWW9GYklBL2R4NVBYeWw2?=
 =?utf-8?B?bkh0SDMzS3NjamJSYTRmTzFaZWQxK2FCWnI3Y1JTMjVVY3pmdG5pa05mWGpD?=
 =?utf-8?B?MkdOcVo1NDFiZWJJSWtrS0xoMGMwQm5VZE11NXJIOWZHY0orWmZVZnM1a2sz?=
 =?utf-8?B?YnllakVsenA3SGJLL3hNRk1ZenVwcFRTdFpmNUlxK3FvYldrcEVHTi96R3RO?=
 =?utf-8?B?bmlib1lQTi9hSHJCNGRMWWhvOE5GT3BlV2RtK0Z2MDNxT0ZEVm5zSDVBa3Q5?=
 =?utf-8?B?cDhMdnRNZjFFWkdhamxlbGczM0RnM01ZMkp1c253Ri93RklLZnkvejRvRE5U?=
 =?utf-8?B?QytwOHBoNkVML0toUTgyWmw4N0ZpMUxJbmc1VDJ2dDAydFpaU20xL1dReDVy?=
 =?utf-8?B?SGVBWjIvNFZ2ZGt3bUxPSFQvSVBxeFA4WmI2VTJqb2VOazBhVmF4cURsS21p?=
 =?utf-8?B?U2YzeU1uOFhXRFpEMTQvd0cxWlAyVkFoUm9rbjhBdTU3aTdqZVJSQUZBbjUz?=
 =?utf-8?B?Ui90M0k5aGx1WXczaWVMOFlMTks2UHFFTUpnb3p2MDNQQ0RCcmlza0dLQ0lY?=
 =?utf-8?B?eVFDRkpRQjZhR3lOZjN3QzBTSTNQeVIyQTcvWU1DWHA0b1g2R25OZXFWVFRj?=
 =?utf-8?B?NXdub0Y4UldQYTJkOEZJeXZBWFVZVXpJa2p4TXEyQ2RYMjdYZ0dUSVRnaWpK?=
 =?utf-8?B?dnRQWm5RQUFFeTczY1VGcGptWG9Jemh0OW1KWEljM0tHVlhTK0g4MW9ZblhX?=
 =?utf-8?B?MDhOWmh5UWNrTFA4MTNGMTIyR2l2Y2E5aXNUQXlsM1FCUi9zQ0lsY1k3eW1a?=
 =?utf-8?B?RFBWcWpOVEpuejVqaXplWmROdU13TWoreHdveEVxd2t1OHpHQkRhTEd1OWF0?=
 =?utf-8?B?SGt6bjVGeEpzdUltMGhiNG5IVmc0NWdOTzVmL0xSOTBvQjhjTVZsejBKMGRT?=
 =?utf-8?B?Tmp6SDZhb1lOcysrdGxpcGc2ZnRvb0FwU2V6NTBaNE1oa2Y1UG8vQ2o0NGlK?=
 =?utf-8?B?Ri9hendYVWd2S0YzNXlHUURPaVBnMDZNbmUwRjFGUXBRZUhXcldnTTh0Y3c5?=
 =?utf-8?B?TklibUpxNE12Lzc1R282cWxzaDB5YjZnelhOaERpQW45WUYwWkZEMFZKdXAv?=
 =?utf-8?B?bldUUUxHcU5qZzVodWU4ZXNVUThNMFp4eFA3VkV4V1BiY25sYWNaR1FXNmRk?=
 =?utf-8?B?cFdCTkd6M1Z6Ry92OU0xa21KTXA5UEdkNGs3N3BtMmZNc1hHeHlMdXJWaVNl?=
 =?utf-8?B?eXM5N0NkTFZGcnVRU3dCaHEvOGZvdjhKdExyeEhKUk5iVGtTOGpVdlpnZ3ZT?=
 =?utf-8?B?ZGdsd3JGenhMSGtRZ2VYdXk1eTNVam1qQlRPTWdTNVhSWEUzM1Z5aStNVG5N?=
 =?utf-8?B?WDFIRkowTzE5eU12dUlaazIrcm9tMExpSXF6ZHlFbXRZd2pYYmlSTEtrSnll?=
 =?utf-8?B?SGIxRThPcDZIZGVERDk1ZG04YUZ4SG5GS3lXU250R3Q3T0Ryb2NJRUxkUDk0?=
 =?utf-8?B?MW0va09DRlhOL1M2d3lkZ3FnS2J5UHJNZDVyK0F4N290S0JqczdvYWMwOWtQ?=
 =?utf-8?B?NW9POVRBRmpZUWVrZ1BZeWlrSndEa01ocW1DT1NDaElYUFcyNU5sV2lrYkl4?=
 =?utf-8?B?eklEWXE1T1RweFVuaFFpdC9ITVpPc3NXMjZVRE9pWUhRRk0yNFRsZWJwdEZL?=
 =?utf-8?B?UFVBWmEwd2t5VW4ycDFKMU9SNnM0NkxHc3hYNGxOcVRvV1hWcEYwTHNRRmZ4?=
 =?utf-8?B?N3N3SUdIcE5zS3daZWV3akRxeSs0TWpyWVg0WXllc3BXaVdNclhNamZGMy92?=
 =?utf-8?B?OWVtUTY2RjFjZk5rSUhtVTBsRUJObXoybitqTTl3OTMzc3BGR1BKbmMxN053?=
 =?utf-8?B?UFdEVG1PcGRxek5kaTZhVHRERVlKU0tLbk1pUEgycEo1bGtoWnVXZWp3b3Yw?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6305bf0-4061-46ae-45e9-08dc0dca2aaf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 08:41:53.3639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztf9xPOYiyRBgJ1L6sv1pP/ksJ5xVgx/N14B1ZcTkg2IhdpBDsqlJ8tfg7cG6S9kxBXIx2AnQPqotW/uFAL8MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6394
X-OriginatorOrg: intel.com



On 2024/1/5 16:14, Ryan Roberts wrote:
> On 05/01/2024 02:20, Yin Fengwei wrote:
>>
>>
>> On 2024/1/5 05:36, David Hildenbrand wrote:
>>> On 03.01.24 15:16, Yin, Fengwei wrote:
>>>>
>>>>
>>>> On 1/3/2024 8:13 PM, David Hildenbrand wrote:
>>>>> On 03.01.24 12:48, syzbot wrote:
>>>>>> Hello,
>>>>>>
>>>>>> syzbot found the following issue on:
>>>>>>
>>>>>> HEAD commit:    ab0b3e6ef50d Add linux-next specific files for 20240102
>>>>>> git tree:       linux-next
>>>>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17be3e09e80000
>>>>>> kernel config:
>>>>>> https://syzkaller.appspot.com/x/.config?x=a14a6350374945f9
>>>>>> dashboard link:
>>>>>> https://syzkaller.appspot.com/bug?extid=50ef73537bbc393a25bb
>>>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
>>>>>> for Debian) 2.40
>>>>>> syz repro:
>>>>>> https://syzkaller.appspot.com/x/repro.syz?x=14e2256ee80000
>>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b57db5e80000
>>>>>>
>>>>>> Downloadable assets:
>>>>>> disk image:
>>>>>> https://storage.googleapis.com/syzbot-assets/4e6376fe5764/disk-ab0b3e6e.raw.xz
>>>>>> vmlinux:
>>>>>> https://storage.googleapis.com/syzbot-assets/7cb9ecbaf001/vmlinux-ab0b3e6e.xz
>>>>>> kernel image:
>>>>>> https://storage.googleapis.com/syzbot-assets/2c1a9a6d424f/bzImage-ab0b3e6e.xz
>>>>>>
>>>>>> The issue was bisected to:
>>>>>>
>>>>>> commit 68f0320824fa59c5429cbc811e6c46e7a30ea32c
>>>>>> Author: David Hildenbrand <david@redhat.com>
>>>>>> Date:   Wed Dec 20 22:44:31 2023 +0000
>>>>>>
>>>>>>        mm/rmap: convert folio_add_file_rmap_range() into
>>>>>> folio_add_file_rmap_[pte|ptes|pmd]()
>>>>>>
>>>>>> bisection log:
>>>>>> https://syzkaller.appspot.com/x/bisect.txt?x=10b9e1b1e80000
>>>>>> final oops:
>>>>>> https://syzkaller.appspot.com/x/report.txt?x=12b9e1b1e80000
>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=14b9e1b1e80000
>>>>>>
>>>>>> IMPORTANT: if you fix the issue, please add the following tag to the
>>>>>> commit:
>>>>>> Reported-by: syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com
>>>>>> Fixes: 68f0320824fa ("mm/rmap: convert folio_add_file_rmap_range()
>>>>>> into folio_add_file_rmap_[pte|ptes|pmd]()")
>>>>>>
>>>>>>     kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:283
>>>>>>     __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:324
>>>>>>     kasan_slab_alloc include/linux/kasan.h:201 [inline]
>>>>>>     slab_post_alloc_hook mm/slub.c:3813 [inline]
>>>>>>     slab_alloc_node mm/slub.c:3860 [inline]
>>>>>>     kmem_cache_alloc+0x136/0x320 mm/slub.c:3867
>>>>>>     vm_area_alloc+0x1f/0x220 kernel/fork.c:465
>>>>>>     mmap_region+0x3ae/0x2a90 mm/mmap.c:2804
>>>>>>     do_mmap+0x890/0xef0 mm/mmap.c:1379
>>>>>>     vm_mmap_pgoff+0x1a7/0x3c0 mm/util.c:573
>>>>>>     ksys_mmap_pgoff+0x421/0x5a0 mm/mmap.c:1425
>>>>>>     __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
>>>>>>     __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
>>>>>>     __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
>>>>>>     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>>>>     do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
>>>>>>     entry_SYSCALL_64_after_hwframe+0x62/0x6a
>>>>>> ------------[ cut here ]------------
>>>>>> WARNING: CPU: 1 PID: 5059 at include/linux/rmap.h:202
>>>>>> __folio_rmap_sanity_checks+0x4d5/0x630 include/linux/rmap.h:202
>>>>>> Modules linked in:
>>>>>> CPU: 1 PID: 5059 Comm: syz-executor115 Not tainted
>>>>>> 6.7.0-rc8-next-20240102-syzkaller #0
>>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>>>>>> BIOS Google 11/17/2023
>>>>>> RIP: 0010:__folio_rmap_sanity_checks+0x4d5/0x630 include/linux/rmap.h:202
>>>>>> Code: 41 83 e4 01 44 89 e6 e8 79 bc b7 ff 45 84 e4 0f 85 08 fc ff ff
>>>>>> e8 3b c1 b7 ff 48 c7 c6 e0 b5 d9 8a 48 89 df e8 5c 12 f7 ff 90 <0f> 0b
>>>>>> 90 e9 eb fb ff ff e8 1e c1 b7 ff be 01 00 00 00 48 89 df e8
>>>>>> RSP: 0018:ffffc900038df978 EFLAGS: 00010293
>>>>>> RAX: 0000000000000000 RBX: ffffea00008cde00 RCX: ffffffff81687419
>>>>>> RDX: ffff88807becbb80 RSI: ffffffff81d06104 RDI: 0000000000000000
>>>>>> RBP: ffffea00008cde00 R08: 0000000000000000 R09: fffffbfff1e75f6a
>>>>>> R10: ffffffff8f3afb57 R11: 0000000000000001 R12: 0000000000000000
>>>>>> R13: 0000000000000001 R14: 0000000000000000 R15: dffffc0000000000
>>>>>> FS:  0000555556508380(0000) GS:ffff8880b9900000(0000)
>>>>>> knlGS:0000000000000000
>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> CR2: 00000000200000c0 CR3: 0000000079000000 CR4: 00000000003506f0
>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>> Call Trace:
>>>>>>     <TASK>
>>>>>>     __folio_add_rmap mm/rmap.c:1167 [inline]
>>>>>>     __folio_add_file_rmap mm/rmap.c:1452 [inline]
>>>>>>     folio_add_file_rmap_ptes+0x8e/0x2c0 mm/rmap.c:1478
>>>>>>     insert_page_into_pte_locked.isra.0+0x34d/0x960 mm/memory.c:1874
>>>>>>     insert_page mm/memory.c:1900 [inline]
>>>>>>     vm_insert_page+0x62c/0x8c0 mm/memory.c:2053
>>>>>>     packet_mmap+0x314/0x570 net/packet/af_packet.c:4594
>>>>>>     call_mmap include/linux/fs.h:2090 [inline]
>>>>>>     mmap_region+0x745/0x2a90 mm/mmap.c:2819
>>>>>>     do_mmap+0x890/0xef0 mm/mmap.c:1379
>>>>>>     vm_mmap_pgoff+0x1a7/0x3c0 mm/util.c:573
>>>>>>     ksys_mmap_pgoff+0x421/0x5a0 mm/mmap.c:1425
>>>>>>     __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
>>>>>>     __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
>>>>>>     __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
>>>>>>     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>>>>     do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
>>>>>>     entry_SYSCALL_64_after_hwframe+0x62/0x6a
>>>>>
>>>>> If I am not wrong, that triggers:
>>>>>
>>>>> VM_WARN_ON_FOLIO(folio_test_large(folio) &&
>>>>>             !folio_test_large_rmappable(folio), folio);
>>>>>
>>>>> So we are trying to rmap a large folio that did not go through
>>>>> folio_prep_large_rmappable().
> 
> Would someone mind explaining the rules to me for this? As far as I can see,
> folio_prep_large_rmappable() just inits the _deferred_list and sets a flag so we
> remember to deinit the list on destruction. Why can't we just init that list for
> all folios order-2 or greater? Then everything is rmappable?
> 
>>>>>
>>>>> net/packet/af_packet.c calls vm_insert_page() on some pages/folios stoed
>>>>> in the "struct packet_ring_buffer". No idea where that comes from, but I
>>>>> suspect it's simply some compound allocation.
>>>> Looks like:
>>>>     alloc_pg_vec
>>>>       alloc_one_pg_vec_page
>>>>            gfp_t gfp_flags = GFP_KERNEL | __GFP_COMP |
>>>>                              __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
>>>>
>>>>            buffer = (char *) __get_free_pages(gfp_flags, order);
>>>> So you are right here... :).
>>>
>>> Hm, but I wonder if this something that's supposed to work or is this one of
>>> the cases where we should actually use a VM_PFN mapping?
>>>
>>> It's not a pagecache(file/shmem) page after all.
>>>
>>> We could relax that check and document why we expect something that is not
>>> marked rmappable. But it fells wrong. I suspect this should be a VM_PFNMAP
>>> instead (like recent udmabuf changes).
>>
>> VM_PFNMAP looks correct.
> 
> And why is making the folio rmappable and mapping it the normal way not the
> right solution here? Because the folio could be order-1? Or something more profound?
My understanding is order 1 could be one reason. Another thing I can
tell is the page here is not anonymous page or file-backed pagecache.
So it can't be large rmappable as David pointed out.

> 
>>
>> I do have another question: why do we just check the large folio
>> rmappable? Does that mean order0 folio is always rmappable?
>>
>> I ask this because vm_insert_pages() is called in net/ipv4/tcp.c
>> and drivers call vm_insert_page. I suppose they all need be VM_PFNMAP.
>>
>> There is not warning because we didn't check order0 folio rmappable.
Please ignore my question above. I messed the rmappable folio and 
add_rmap().


Regards
Yin, Fengwei

>>
>>
>> Regards
>> Yin, Fengwei
>>
> 

