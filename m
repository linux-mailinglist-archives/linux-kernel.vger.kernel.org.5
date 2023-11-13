Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3861D7E9F31
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjKMOwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKMOwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:52:40 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877021A5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:52:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwgEFA7gLJmt5MzoONDAYL4rVrd2JDetn8Er+Puq2Wt7+tnLKl4BvqqojDzdvfyn+mZjb10aFTOCP5GicCe3UFKMt+zuehlpCQ3rgTJiRXFbuXicqSk7/Tj+YZRE9KMZxcNHoPehKJo8LiFNlaxpbJHEt51DZhdwji79dbHwiCYA+WKo0JYrzC0M3sX830NuXyLY6cf1KqXHgVGWJLYOt7CEQs/hmrgkxQVaiDUN7DkKKtE28Kj9aRjHwUn8mksjzdgMlX+SsfyKimnqmtoSUq8QtaFQWzN61TFJoZ9Wxg+9Q9jW1pI+wJArUUxNqdOGM4e036upaIsNoMZ2LFZuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6HnzFUsKGlLs8f61Ya/dUj1IWTJeXcHbwSJLwNqDuQ=;
 b=N2xMZ8W0W30nAqLI1qS/pz8HzSKvOlhwtbfKvTt+dSHudodVX9rkEs956/iQINdIyhAGX+7Lj1d6t9krXqbwB9pEix3AAbiG3NtrniE0IiW/y3bWQQziOctmrbo75EraiaQY8ke8yHG/KYBvyyecc5j3BkY4kRSnnzaTwhK2D3ZYYxYN8OaoNKd2d/cKcVc0pvhqKArgi0hNvSZzafv2ioh95yJ/zNRei7GibY9lm6jOIOcIjlMvq9eLIf/6Y4iDp+u5Si7DHZSYcbqW3myFOYjHULzptiyPoD1aYCHa33NoT+HDyrZyPoUY/zW1aqvAgM3DyzdVk6fOITydQuERGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6HnzFUsKGlLs8f61Ya/dUj1IWTJeXcHbwSJLwNqDuQ=;
 b=gJ5++TSYy7VoZGreGLHWHtxk8PkrQgOA8qdca2xkzTeZ9lpJtymI3GnIG+HngpuTg9kS0I4svc6QEs5w+OXTyEEGviPYZwKQaRMlQg+zDYMFq8PV/xdvxqim4iey7eepnEWYook2l/jrjgAJXqIX1qs+vs2o4RvIzRQk28ISaOOHrdsDHN303cxd+hUf40YpJTCG4mtXByIo0zRZ1dVb8gxGsKzJUXR4BQ80rDTzhMxmQUKXgE7J3uKVEpY8RsgloCGs3rIXaJ9XVJ0+xxioDae0V6Jlnw7CxMk8COXk2wXtj33Y4K7ER6hj6agVm1tlIjt1EOMBMUuvS0J7enrcuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 14:52:33 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.6977.019; Mon, 13 Nov 2023
 14:52:33 +0000
Message-ID: <abb85115-5790-c292-f27e-3c13b105230d@nvidia.com>
Date:   Mon, 13 Nov 2023 09:52:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia.com>
 <ZVGxkMeY50JSesaj@casper.infradead.org>
 <f1fa098b-210e-41a9-80fc-aec212976610@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <f1fa098b-210e-41a9-80fc-aec212976610@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:c0::41) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cf25e9-a98d-4fb8-d6bc-08dbe4582ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3Wc3Q8W0YyKQ+F1/oTf+FBopA6HTtnAI6qHK+Lq+IRfMx8bBZg+EtbyD3cTASRVXm+/+qH/v6DDy03FyZIibCQTHNAb+U4z1euJ4u6TuGt68vOlXrhs0FLNpNCx5+Qo1+465ltsamabQb+LjSAzYLEb9/bJATH1AJXk/Nwwy3WNfr02es7xVG+A+Ew6Ds0xp46vBCQUqVTjh+vNgUsd8NylOMZOhvY6DOEgcYN0QgOII1hrLiJpr3zsHqkfWFpP68yJ4gwoPP7i4j8PI/GXAxtTmp7zNNJE6/rTG8T3n13nXf972gANFWKq/dbRHmPxjX337e9inKzxZtfr00iX3kdmmDepqLVy6ECRpACa6fbbZiLD0maBtqcOCxRoSDCfRqAfhPxD6owTdZSUwc4rkDc0E3W75KbT3y0NQmA+Kh+tg9wHeQsf4res100YhUilahtwW8j/DYCq4/8JzGyKUtqZzsNlc5Zzy3EK0J5iadVk55BrFVivF5Tj2PtzDkEXN34fkAGx7Jrm5eE0PjsSGbyOdzUu/BG4K3q/RpWxkg4PJffbiTQRhCgwn+im7DvOEa06kek0ArrmWS4FpUlPIo1zcQkApKYyQvdbXzaBD1fwSui/rvUTqGn2iN8bJ22rraeOkbnWKx5Sulxki3dybg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(110136005)(66899024)(316002)(54906003)(66946007)(66556008)(66476007)(478600001)(6486002)(6666004)(7416002)(86362001)(5660300002)(31696002)(41300700001)(36756003)(2906002)(4326008)(8676002)(8936002)(2616005)(38100700002)(83380400001)(26005)(31686004)(53546011)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnBwU1hlM1dvcCtuNzJvT20rM0ZhdStpUnJORVlJNTh6VXdNZkhvRnEyazg1?=
 =?utf-8?B?dnJsMm5LQXBzUDZEcFRrd3dLMmhFQkRFTFdlTHFzL1FaM3JWWk9URDYyRWxO?=
 =?utf-8?B?ajhkQWtZTEdHUUNXaGhrTTJlNUltcHFjQUdXV2x1SFFJMVZqLzBtRjJCY28r?=
 =?utf-8?B?RUlKYjI3b2IraVBrdlhhWWZVaEJlb08zQW5LN3czeXJBSWtzUGxjeElmOGgv?=
 =?utf-8?B?bUR3ekppelhINGswaDlyWUp5eHRSRkVQUEhEVTJ5aVFyUE5qem1CUktnK1B5?=
 =?utf-8?B?NGNGeldUYVp5MWh5YTE1eTAxUm51dE1QQitBQlMrWld0VWtBZDU5bzRJcE14?=
 =?utf-8?B?ZCt6QnBOdlVmeC9mYnltTU1IcmJ4Nlp4TUhvNDVSeFpLaytNdGxrbHVjaGpG?=
 =?utf-8?B?Uks5SjRJZ1pEY1Erdk9KV1d6SmZsUmsxMXNhc1VnaDhkZHJvcW9MUUVUNEtp?=
 =?utf-8?B?cmp4TlRyZkhITkpDQlhEbXNPLzV4WXdheFpuZ1dkOUIzRVR1bzRLNGZoMXhI?=
 =?utf-8?B?U1p4K1IrN1FxN0Jua0c2MGo2TllVMnIvaktTOE5sNGxwcy9CaVZCbFM5bytU?=
 =?utf-8?B?clpqSkFxOTU5YnZsWjV0SWkvM2piSnF0Z00wSng4UUxIRHJxd3dMOUFRSFBF?=
 =?utf-8?B?aWJVRk9FbGdoNkhtUWJwd2I5VWhxWjJKcndXQUU5NHNWUjJ5UGxmNmo5Q0Fi?=
 =?utf-8?B?bEs0Zkg4UEs1MTJ3cmgxNStKV3p4V0dKTWZMUDhubElhRmw4ak13K004c1N3?=
 =?utf-8?B?L2FmOTQwUzBzRFQ5a1NMR0o2TTNGQmpjeWhoeko1RUJLSGFGNS9ORDFYODRx?=
 =?utf-8?B?ZUZmYTlxU2hTTkt0d2RsbVlzU2Fhc0dpR0RLN0JIV3N0SWpvKzhSQ2ZNK0U4?=
 =?utf-8?B?L2k4N0k3MkVRcnFhdm1rdjZtQVE1cWxLU2xQNG1HRXE2bUltZ0hPejN4MjRK?=
 =?utf-8?B?V0orMUduTzc3YTRvN2E0OUVSOUtXdm9WRTFrWDZ2cExhV0hHUVRDRGFkL0ZC?=
 =?utf-8?B?UkRRSDJvY0tlNTBNWHpLY09BNXpwLy9ia2lpUGhPZ1kvdFluTXhEcTV0WXAr?=
 =?utf-8?B?YWxia3hBbWxNMWhPWUs5RUl4Wk1tVWZ4enY0QklSWmVyQWRrdHlseWdRUmZY?=
 =?utf-8?B?ZnI3QlFnZlhobWJCU2thcytsNm9RbW9WNFErTzBRNzFJZGU0WXg5UndlTVdl?=
 =?utf-8?B?bVQrdHBUVUlRKzRiTFJSckdyb3lOczdhdnFraUozQ21LUjlBTTdkNFBMdDlO?=
 =?utf-8?B?Vmsvdno5YmpNUWZyR25YR1A1R3dJQ1JYZ1JPSzRVZWdXTEdNbFF4WUE4cmdE?=
 =?utf-8?B?c2MvV2tjMDJ3bDBOSkFMSGdVY3VMOFpES2UzNE5Lb0prTHEyekR2MWx5YTd6?=
 =?utf-8?B?ZHZSUytsV3R4WGo2K0lmUFFIUkpERUh0Zkl3OUZuZGEzUVJTa3Fsb1JPdmxX?=
 =?utf-8?B?ZkVOa1k1QmFXOFVtenEyb0lZaTVSSU1EdWt0aFZQRWpQbjRzS1hQVGRrRTd3?=
 =?utf-8?B?cnEzaTduU3o4S0d6UkFmdjNZYjNqZGdrTW9yVFFITFhRZUw1a3hFVWViY1lH?=
 =?utf-8?B?TFJxK09nbUNCcE56U1IwdjdGNTNZaXM4S1J0SFB5SzREc0t6SGxTRGhpMzFw?=
 =?utf-8?B?bzc2NjdTazVJcXFPVnBVMzhEWFV4YjEzaGhKakZET25rR1hlVVQ1U2pkdjYy?=
 =?utf-8?B?MGdMVWNGeUxLY3N0dmhBRkhzOUY3RXZFMGdvUG5jRnIxYmUxOWRHQnN0aWps?=
 =?utf-8?B?UHgrOUZVRUxrMG5GV2FYa3JONksyMVRPSUdpTUtQNklsbDBXSllKbFZDeWRx?=
 =?utf-8?B?VElJMVNHRG1nUzB0ZnZNVEZ6c3F5TTZoelo5VG1UVUZSRVBhejkrcm43TERz?=
 =?utf-8?B?TzZqOEYyWkxjUDJEQWVudzRCU2hGbHRBWFhXVkNKcWFZS0RxamwwaVVuTWgv?=
 =?utf-8?B?djFqc1VnT1J6TENIMGF0ZjR1OW9QWjVOTUhOVm1yMFd3Q0ltMDVWeGk2TDFz?=
 =?utf-8?B?SmdDMnNhMis4NzNzNTUwb3pFZkg2OVJJc0ZYWnN3ZWNuWXQ0b0sxUFlabEVw?=
 =?utf-8?B?OXNteGJOQjlOc3c3aHlWa2hwTHlleXg1RCtKTTNsd3Q3aEFCNW13bEJ3QW1P?=
 =?utf-8?Q?kgppOUyFF7MxX0IEhLHpMk+9i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cf25e9-a98d-4fb8-d6bc-08dbe4582ad1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 14:52:33.1706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wsGP/ws27wkJWrp5LTIJdDwos4oAivzuT3LNK7HCyf31EsXsYJAf7NOQXM95xP9WmxQzTExUmEk97cB4xiCoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/23 2:19 AM, Ryan Roberts wrote:
> On 13/11/2023 05:18, Matthew Wilcox wrote:
>> On Sun, Nov 12, 2023 at 10:57:47PM -0500, John Hubbard wrote:
>>> I've done some initial performance testing of this patchset on an arm64
>>> SBSA server. When these patches are combined with the arm64 arch contpte
>>> patches in Ryan's git tree (he has conveniently combined everything
>>> here: [1]), we are seeing a remarkable, consistent speedup of 10.5x on
>>> some memory-intensive workloads. Many test runs, conducted independently
>>> by different engineers and on different machines, have convinced me and
>>> my colleagues that this is an accurate result.
>>>
>>> In order to achieve that result, we used the git tree in [1] with
>>> following settings:
>>>
>>>      echo always >/sys/kernel/mm/transparent_hugepage/enabled
>>>      echo recommend >/sys/kernel/mm/transparent_hugepage/anon_orders
>>>
>>> This was on a aarch64 machine configure to use a 64KB base page size.
>>> That configuration means that the PMD size is 512MB, which is of course
>>> too large for practical use as a pure PMD-THP. However, with with these
>>> small-size (less than PMD-sized) THPs, we get the improvements in TLB
>>> coverage, while still getting pages that are small enough to be
>>> effectively usable.
>>
>> That is quite remarkable!
> 
> Yes, agreed - thanks for sharing these results! A very nice Monday morning boost!
> 
>>
>> My hope is to abolish the 64kB page size configuration.  ie instead of

We've found that a 64KB base page size provides better performance for
HPC and AI workloads, than a 4KB base size, at least for these kinds of
servers. In fact, the 4KB config is considered odd and I'd have to
look around to get one. It's mostly a TLB coverage issue because,
again, the problem typically has a very large memory footprint.

So even though it would be nice from a software point of view, there's
a real need for this.

>> using the mixture of page sizes that you currently are -- 64k and
>> 1M (right?  Order-0, and order-4)
> 
> Not quite; the contpte-size for a 64K page size is 2M/order-5. (and yes, it is
> 64K/order-4 for a 4K page size, and 2M/order-7 for a 16K page size. I agree that
> intuitively you would expect the order to remain constant, but it doesn't).
> 
> The "recommend" setting above will actually enable order-3 as well even though
> there is no HW benefit to this. So the full set of available memory sizes here is:
> 
> 64K/order-0, 512K/order-3, 2M/order-5, 512M/order-13

Yes, and to provide some further details about the test runs, I went
so far as to test individual anon_orders (for example, 
anon_orders=0x20), in order to isolate behavior and see what's really
going on.

On this hardware, anything with 2MB page sizes which corresponds to
anon_orders=0x20, as I recall) or larger, gets the 10x boost. It's
an interesting on/off behavior. This particular server design and
workload combination really prefers 2MB pages, even if they are
held together with contpte instead of a real PMD entry.

> 
>> , that 4k, 64k and 2MB (order-0,
>> order-4 and order-9) will provide better performance.
>>
>> Have you run any experiements with a 4kB page size?
> 
> Agree that would be interesting with 64K small-sized THP enabled. And I'd love
> to get to a world were we universally deal in variable sized chunks of memory,
> aligned on 4K boundaries.
> 
> In my experience though, there are still some performance benefits to 64K base
> page vs 4K+contpte; the page tables are more cache efficient for the former case
> - 64K of memory is described by 8 bytes in the former vs 8x16=128 bytes in the
> latter. In practice the HW will still only read 8 bytes in the latter but that's
> taking up a full cache line vs the former where a single cache line stores 8x
> 64K entries. >
> Thanks,
> Ryan
> 

thanks,

-- 
John Hubbard
NVIDIA
