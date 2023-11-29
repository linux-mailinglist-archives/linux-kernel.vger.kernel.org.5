Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595B57FE063
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjK2TlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjK2TlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:41:23 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72B510C2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:41:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju5p8zHhrOmHqZZMbmayJqLMJUoEQJ/jEWE1so1KhL+CJ/bKQnNrOM0sUbRWvQvhwGVqgSut9IWRTCuTrrgs9bXGQJ+iDfvvvFrycDAwzARQ7LaG3A0WvKA1QMm5YH/JKEkawVrQYWu9tQJVfCaLCvvuDM/keJHXVNHEkl3WZ0YLbBJqAX3aPSgzwO5TOviZX7LHkK9/JJtnhgObG/fEs2XU6xdhn/FWTh/1OWAZl6yd7zJQscJHEHZZ6OAyZxucpzkC0jWWQ1Jspc8iLst3t2uo6XXCI6fbVITP6Z46UyR4PKQmmMWjZ+DICHEgBYxb8BWmXIEaeaO/5EeYf8eQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNMz8J9nPZivg6hqisTkBCzwuNCj20IRZEKoC0L2eyM=;
 b=YgFSnhJZbclzUF4ipN4kRUARTJJm3HfP+nw1XVMlH/wMFnsHC0fundzuPNFB1OOg1FH114osZ/FXvoSidqJFaHc6CArt/D9fNs3XuLuj15+bn6gqbIk/qnXRc+7nGxokak5ouSRUP80tQNFNznQPf7rjOekcsrGnTA8/+sLKBuqVvAqeBz1gp3gck8q2Yb6+VWRqt6QGKoQ8z7ZJ6x2ugCJKBGygLd8oIr9Lq7Lamp4tOT1xvIPzFvTNRLuttAq6MTnNu1ru4LTjCl8ImRxReK+VxBlRJCcdRhbwvlT3HMdQrAGt7P4iXlxEZf0qDX8VS+tfkuyn2VWOzdUH+hAoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNMz8J9nPZivg6hqisTkBCzwuNCj20IRZEKoC0L2eyM=;
 b=l9FgxhvvQczDPaK/PFBqp0myTUiuzewJDffzneE2/R+SbpK4kWAHv4R9ujjUKZvZM2a6c4D0GSUZQPjxKH9puHvRy2K+JCsUvpkdo92hiwYM+1Vt91IG5sFEwhkB+r/uAAZLw7XJCk5bo19M0Z4S+oI3Drolk6HYzRL8xvb6mS9cgODZqs40kKjZ9euQo1CJ5dpWjdyfJnSJ7QG6vIMHgTyfXHyYiIHxG9VPep2z7Ei4XaT790BmvSaEBIH3QqE8kA3EQpfvXNhPXlzNpiJ5SZErP3Uw8ikEWTEFGfz5LNqt/EdkTgsYYlP4bG03wHkpL35ujCZxZvu4eGhTwmxE5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 19:41:22 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 19:41:19 +0000
Message-ID: <83744787-6bc5-4958-bdaa-030c9ed8225a@nvidia.com>
Date:   Wed, 29 Nov 2023 11:40:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 03/10] mm: thp: Introduce per-size thp sysfs
 interface
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
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
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <20231122162950.3854897-4-ryan.roberts@arm.com>
 <1a738e0a-ac11-4cd3-be2f-6b6e7cb4980a@nvidia.com>
 <0641d171-731c-4c12-83c2-8212c63ffade@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <0641d171-731c-4c12-83c2-8212c63ffade@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:217::33) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 674f3b57-edda-4988-dc0e-08dbf11328ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 819oYRUUoexZ2oReo7rDHsIf2+TJq0SysdeHWKDkHlLIJAOMiBmhXSh18Ez/ghpoatDN8Y5QWBkGIbFAj40rbskqJwS8G/3dItC0WmWYgesP7Udnkw1zO+LKOw5jNmqATxpdfQovn+JYCME6KjVLm2vmefyrwZnIY3LWFWnwO9CTvzzmZf1npcWiPpR8k/OIPHjqJq5uSqyirga0X5czSrcgBemBnUji9E3OBGVcJ+d0tPsenqRYVw4Hf/0hWGbardFetPkg23XFZLnJuQPlVoh9MrJbEAq19vsQnRc3aOsPz+Npr7lq4Bmc58UNnmKG67QS36sIy2/bks44AvwSxpAuLSMt4lSL7TDDbdRGBSGDwTbZkqmNzcdHMOd9MYEDC7XX5BXEzRXMri2LrUy6z9ICXgOVRqd2t8GqQr8/hkFTmxbKc+DpvayNE9Ryc+fSNC/1bbO7JFUzeu+8SIMalR6CxHXO3RqOPNm0ZosaGM+zZozdDi8RPudxop0Vq/xdILeEpwPc+4SVsEiurF1l7XmzP9dQAxZOFRve1uIZWSypdCF5NcSc3D/OrBJJzZyObelBbuukr0TwtmuJEVBCe6GLJeN0/j95DnsHrhVVZe8sQ/COUMMs55mGVlPE++r6p5a/dMHSIVUyBRQmSPAHH2p9MCVOz35W6ZFtMJiS1FsG4L1hNodeEu1JbJdj2S49e/cpmamIToClvu0uke1/zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(921008)(31696002)(2616005)(38100700002)(86362001)(8676002)(5660300002)(6666004)(8936002)(4326008)(7416002)(2906002)(30864003)(110136005)(31686004)(202311291699002)(6506007)(478600001)(316002)(66946007)(66556008)(66476007)(6486002)(53546011)(83380400001)(36756003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm40eVJrZmJPTjBuaU1Vd2p3eFBNMEg0WE5rL1YwSk1QN1pmN3NHVU9zQnZ6?=
 =?utf-8?B?Tm9zaDEwL2diRStyaHVucGQ2bzk2SXBDbnFIKzFRL2tEdkcwVXRwTUNROXVX?=
 =?utf-8?B?TXJzUlFNaHo2c1RscDcyaGRBZDRyeE9jWDBQbndmRHBlY1E4d05YRVg1S2lB?=
 =?utf-8?B?K2dzT2RIYnZ3SDFjdG56cVhuZlZqWVlaN3d5cUtBc0Q1OUhMZlhwcWtqaitJ?=
 =?utf-8?B?V0laaDFqcDBxNTJTMHN3UkVGQVBtM3VaTjVFemNDKzQ3NnBDQmxOMjdiOGRI?=
 =?utf-8?B?dUsrMW5lRXREcUVrbFlaV1Y5Nno4TTdzZ0taNHVpZnlvV1crUTRIM3JIcThF?=
 =?utf-8?B?aHZjZUcySjFXU05uOUIvQU8wbXFSY09rbkhSUGJQOEwzeDRXaTU5ay9NYmho?=
 =?utf-8?B?Y3ZRTlpjZGhwOUorQjhrd0JDR3NzU2RybjJGMFV4VFhrY3JTNzlaTG0vaFBs?=
 =?utf-8?B?RGxNNzhPWktEK0NPbEZOMzlNdGNjTFFQaHJaSkFTVERKQURGZGJXTjVJUFI0?=
 =?utf-8?B?aE5PT3hhcGtvQTZnNUJFd3g3V0ZQTUZzaC9ZVkRDbHQxKzNrbnJCYWgySWpv?=
 =?utf-8?B?eEpvQ29USDBQcjlIS2JsUjFzVlZZWEthdXVMUzFuY29kdElMdFNRdTBPaGtn?=
 =?utf-8?B?ZXkvV1JGY1pwN2hRRVFNNlBqSmc3Sjc3djFTOC9DRlZhWTJ1MjlJYmZzNzFF?=
 =?utf-8?B?S0RndWg3VUVWR2UwWkxXdTBPTkFxY3JHZjg3blEzQzQ2QnhrZ2VRb1Q1VUZC?=
 =?utf-8?B?RXlxNUhCNEZ3TEVtcFdIdXFKSkNzU2d4SGt0R0c2aXhRU2pFUmdoVGthL2dx?=
 =?utf-8?B?MDdXSjh3cHVNSW5GSXdwTVFmTFJBTnBGUFExL0V2ZkdGTW5HVTVGT1RYY2NO?=
 =?utf-8?B?NkEyMnIyS3c0Rk55ZG52aTVvWVZhbHJpd2FyMmMzbm0wVUNROGJvR0E0WEdU?=
 =?utf-8?B?VHpyN0xjMVpUMFFUZ1NQaTFUUWlhVkxSNEdLVUJxUUNqSmNaWGVWcndHTFhx?=
 =?utf-8?B?RVRqN1BPYUJJSy9oWHFtdnNBcjRrbExUeVJtdDRpNDNhN3JDWmVnT051aGlS?=
 =?utf-8?B?dkVsT0l0eVJhd1dwaW52SWJHb2lZYStkMXNHaVd4eXYyc0ZIbllsT1ZLOHdG?=
 =?utf-8?B?UVRnMzArQkhVRzlDeXY1TmxJaTU3OXRLcW9MVldFeXdQWFcySGd5OGh3cmVC?=
 =?utf-8?B?TFNMZEcvZzIrVG9ZbWNoWDVNc1JOaG52QzlaZzgzOHdSalRNOGJzZHJnbGFp?=
 =?utf-8?B?SXQ2Tno2M3Y1MW5SY2JkQkVZWUhxZS9DNkZZdHFIWk13eFBVY0VTUjM1Ymlx?=
 =?utf-8?B?OEw5bDQ3eEYweG96amtQTEowSThWeW5HcWZ5VjNuWEdCajB2TnJPTC8ybDho?=
 =?utf-8?B?Y2RMWjFFY3ptS3YyenJPNXlqS09FS2R2MllmM3dHZmFIZzNCWlNXN1JaYTJM?=
 =?utf-8?B?TzJJbHVLeFpVcHVIdzY0ZGprVDBaQkhYdzZReGFJbEZpTk43Ullna21JWjR5?=
 =?utf-8?B?SDV2Y1pRQVRNMGN5T1I5emdYOWJNd25RajBVQWYvWmJrSkFhOW5mOExNdUF3?=
 =?utf-8?B?L2UwaWZrQjl6VEhaT3BFZk9Za3R4eEpOc281T3lvZFU5MkdnT1V2ZHRJdFNz?=
 =?utf-8?B?NmRyeXhsS1E1aHFrUE5PNGNWVEhsQ085emJtZ0dzZU1mT1ZLNkZJWTN6YUVx?=
 =?utf-8?B?TjhHSS9MS0UzeWx6U0k2MmhnM3pwQlBKdjExK0MwdzM0N3hGOXhjSzd2YStK?=
 =?utf-8?B?NXdvN3E0dkF3RVFDTTVOclFGV1NaNElNQkJIOUlPTkpJNWZzS0FvM1E5QlVL?=
 =?utf-8?B?ZG9EMWQrZXhkMExuZmozRE9HU1BTcVl1V1g1UmRXa1lVL25tVWk0WXpTV3U4?=
 =?utf-8?B?elp6QlBmdWJISHdHbHNNTjg4VmJwRGYzOGw4bDdhOGZ6cjl6VU5sT3pLYnRr?=
 =?utf-8?B?RkdPTy9tSlA2V0Mrb3dDb2kyNXBUZndQUmpBYy82V1FkT3dCalpKZWh2U0R5?=
 =?utf-8?B?VkZEeE5SWmRKN0hubktyRHF1RDBuR05mRUFxMnlkMWxHTHFKaFUrQkFVeDky?=
 =?utf-8?B?L0MrWmp3MTJRYmdQV0NJR05BTUIwNDVuTzFwdEVGeHpPczZ2Mnp1SmlqVHRF?=
 =?utf-8?B?dHFRWDF2YUJ4TDFjYk1SbjIzcTNkTk9zT1o2ZldGZXJ3VmNpZ1FPVUNSSUpW?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674f3b57-edda-4988-dc0e-08dbf11328ec
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 19:41:19.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqmsC6KTmvYpZolK1zmGW7oJpEnPWIvUjyALw7XJILwcG3HPtHcqAKTEKZjnDn8rstuc6d2wNF9ucEGcmfS5gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1On 11/29/23 03:05, Ryan Roberts wrote:
> On 29/11/2023 03:42, John Hubbard wrote:
>> On 11/22/23 08:29, Ryan Roberts wrote:
...
>>> +As well as PMD-sized THP described above, it is also possible to
>>> +configure the system to allocate "small-sized THP" to back anonymous
>>
>> Here's one of the places to change to the new name, which lately is
>> "multi-size THP", or mTHP or m_thp for short. (I've typed "multi-size"
>> instead of "multi-sized", because the 'd' doesn't add significantly to
>> the meaning, and if in doubt, shorter is better.
> 
> I was thinking of some light changes to the start of this paragraph, something like:
> 
> Modern kernels support "multi-size THP" (mTHP), which introduces the ability to
> allocate memory in blocks that are bigger than a base page but smaller than
> traditional PMD-size (as described above, in increments of a power-of-2 number
> of pages. mTHP can back anonymous
> 

Very nice.


...
>> By default, PMD-sized hugepages have enabled="inherited" and all other
>> hugepage sizes have enabled="never".
> 
> That all sounds good; will update.
> 
> I wonder if "inherit" is even better than "inherited" though?

Yes, I think so. "inherit" was actually my first idea, and after
thinking about it, I just made it worse by adding the "ed". haha. :)

...
>>>    Khugepaged controls
>>>    -------------------
>>>
>>> +.. note::
>>> +   khugepaged currently only searches for opportunities to collapse to
>>> +   PMD-sized THP and no attempt is made to collapse to small-sized
>>> +   THP.
>>> +
> 
> "small-sized THP" used here too; I propose to change it to "... collapse to
> other THP sizes."

OK, looks good.

> 
>>>    khugepaged runs usually at low frequency so while one may not want to
>>>    invoke defrag algorithms synchronously during the page faults, it
>>>    should be worth invoking defrag at least in khugepaged. However it's
>>> @@ -282,10 +321,11 @@ force
>>>    Need of application restart
>>>    ===========================
>>>
>>> -The transparent_hugepage/enabled values and tmpfs mount option only affect
>>> -future behavior. So to make them effective you need to restart any
>>> -application that could have been using hugepages. This also applies to the
>>> -regions registered in khugepaged.
>>> +The transparent_hugepage/enabled and
>>> +transparent_hugepage/hugepages-<size>kB/enabled values and tmpfs mount
>>> +option only affect future behavior. So to make them effective you need
>>> +to restart any application that could have been using hugepages. This
>>> +also applies to the regions registered in khugepaged.
>>>
>>>    Monitoring usage
>>>    ================
>>> @@ -308,6 +348,10 @@ frequently will incur overhead.
>>>    There are a number of counters in ``/proc/vmstat`` that may be used to
>>>    monitor how successfully the system is providing huge pages for use.
>>>
>>> +.. note::
>>> +   Currently the below counters only record events relating to
>>> +   PMD-sized THP. Events relating to small-sized THP are not included.
>>
>> Here's another spot to rename to "multi-size THP".
> 
> I propose to change it to "Events relating to other THP sizes..."
> 
> I'm also going to move this note to just under the "Monitoring Usage" heading
> since its current position doesn't make it clear that it includes
> "AnonHugePages". I'll also make it clear in the text that mentions AnonHugePages
> counter that it "only applies to traditional PMD-sized THP for historical
> reasons" and that "AnonHugePages should have been called AnonHugePmdMapped" as
> David suggested in the other thread.

OK.

Are we entirely dropping the AnonHugePtePages that was there in v6? I'm
looking for some way to monitor this. I may have missed it because I haven't
gone through all of v7 yet.

...
>>> -"THPeligible" indicates whether the mapping is eligible for allocating THP
>>> -pages as well as the THP is PMD mappable or not - 1 if true, 0 otherwise.
>>> -It just shows the current status.
>>> +"THPeligible" indicates whether the mapping is eligible for allocating
>>> +naturally aligned THP pages of any currently enabled size. 1 if true, 0
>>> +otherwise. It just shows the current status.
>>
>> "It just shows the current status"...as opposed to what? I'm missing an
>> educational opportunity here--not sure what this means. :)
> 
> I have no idea either - it seems superfluous. But that sentence was there
> already. I can remove it if you like?
> 

Yes, let's remove it, please.

...
>>> +/*
>>> + * Mask of all large folio orders supported for anonymous THP.
>>> + */
>>> +#define THP_ORDERS_ALL_ANON    BIT(PMD_ORDER)
>>> +
>>> +/*
>>> + * Mask of all large folio orders supported for file THP.
>>> + */
>>> +#define THP_ORDERS_ALL_FILE    (BIT(PMD_ORDER) | BIT(PUD_ORDER))
>>
>> Is there something about file THP that implies PUD_ORDER? This
>> deserves an explanatory comment, I think.
> 
> Sorry, I'm not really sure what you are asking? Today's kernel supports
> PUD-mapping file-backed memory (mostly DAX I believe). I'm not sure what comment
> you want me to add, other than "file-backed memory can support PUD-mapping", but
> that's self-evident from the define, isn't it?
> 

Well, it's sort of evident, but confusing to me anyway, because it
combines THP and PUD. Which seems to imply that we have PUD-based THPs
supported, but only for file-backed mappings. Which is weird and needs
some explanation, right?

>>
>>> +
>>> +/*
>>> + * Mask of all large folio orders supported for THP.
>>> + */
>>> +#define THP_ORDERS_ALL        (THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE)
>>> +
>>>    #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>    #define HPAGE_PMD_SHIFT PMD_SHIFT
>>>    #define HPAGE_PMD_SIZE    ((1UL) << HPAGE_PMD_SHIFT)
>>> @@ -78,13 +93,18 @@ extern struct kobj_attribute shmem_enabled_attr;
>>>
>>>    extern unsigned long transparent_hugepage_flags;
>>>
>>> -#define hugepage_flags_enabled()                           \
>>> -    (transparent_hugepage_flags &                       \
>>> -     ((1<<TRANSPARENT_HUGEPAGE_FLAG) |               \
>>> -      (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
>>> -#define hugepage_flags_always()                \
>>> -    (transparent_hugepage_flags &            \
>>> -     (1<<TRANSPARENT_HUGEPAGE_FLAG))
>>
>> Are macros actually required? If not, static inlines would be nicer.
> 
> I agree static inlines are nicer. Here I'm removing existing macros though, and

Oh, I see that I replied in the wrong part of the email, since that's the
*removal* part. oops. :)

...
>>> -static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>>> -        unsigned long addr)
>>> -{
>>> -    unsigned long haddr;
>>> -
>>> -    /* Don't have to check pgoff for anonymous vma */
>>> -    if (!vma_is_anonymous(vma)) {
>>> -        if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
>>> -                HPAGE_PMD_NR))
>>> -            return false;
>>> +static inline unsigned long transhuge_vma_suitable(struct vm_area_struct *vma,
>>> +        unsigned long addr, unsigned long orders)
>>
>> Changing this from a bool to a mask of orders is quite significant, and
>> both the function name and the function-level comment documentation need
>> to also be adjusted. Here, perhaps one of these names would work:
>>
>>          transhuge_vma_suitable_orders()
> 
> This is my preference, but its getting a bit long. How about:
> 
> 	thp_vma_suitable_orders()
> 
> I could then call the other one:
> 
> 	thp_vma_allowable_orders()
> 
> So we have a clearly related pair?

Oh yes, that works nicely.

> 
> 
>>          transhuge_vma_orders()>
>>
>>> +{
>>> +    int order;
>>> +
>>> +    /*
>>> +     * Iterate over orders, highest to lowest, removing orders that don't
>>> +     * meet alignment requirements from the set. Exit loop at first order
>>> +     * that meets requirements, since all lower orders must also meet
>>> +     * requirements.
>>
>> Should we add a little note here, to the effect of, "this is unilaterally
>> taking over a certain amount of allocation-like policy, by deciding how
>> to search for folios of a certain size"?
>>
>> Or is this The Only Way To Do It, after all? I know we had some discussion
>> about it, and intuitively it feels reasonable, but wanted to poke at it
>> one last time anyway.
> 
> This function isn't trying to implement policy, its just filtering out orders
> that don't fit and therefore definitely cannot be used. The result is a set of
> orders the could be used and its the policy maker's job to decide which one.
> Currently that policy is "biggest one that fits && does not overlap other
> non-none ptes && folio successfully allocated". That's implemented in the next
> patch and would potentially be swapped out in the future for something more
> exotic/optimal.
> 
> So I don't think we need any extra comments here.

Ack.

...
>>> -bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
>>> -            bool smaps, bool in_pf, bool enforce_sysfs)
>>> +#define hugepage_global_enabled()            \
>>> +    (transparent_hugepage_flags &            \
>>> +     ((1<<TRANSPARENT_HUGEPAGE_FLAG) |        \
>>> +      (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
>>> +
>>> +#define hugepage_global_always()            \
>>> +    (transparent_hugepage_flags &            \
>>> +     (1<<TRANSPARENT_HUGEPAGE_FLAG))
>>> +
>>
>> Here again, I'd like to request that we avoid macros, as I don't think
>> they are strictly required.
> 
> Yeah I agree. I did them this way, because they already existed and I was just
> moving them from the header to here. But I'll change to static inline.
> 
>>
>>> +bool hugepage_flags_enabled(void)
>>>    {
>>> +    /*
>>> +     * We cover both the anon and the file-backed case here; we must return
>>> +     * true if globally enabled, even when all anon sizes are set to never.
>>> +     * So we don't need to look at huge_anon_orders_global.
>>> +     */
>>> +    return hugepage_global_enabled() ||
>>> +           huge_anon_orders_always ||
>>> +           huge_anon_orders_madvise;
>>> +}
>>> +
>>> +/**
>>> + * hugepage_vma_check - determine which hugepage orders can be applied to vma
>>> + * @vma:  the vm area to check
>>> + * @vm_flags: use these vm_flags instead of vma->vm_flags
>>> + * @smaps: whether answer will be used for smaps file
>>> + * @in_pf: whether answer will be used by page fault handler
>>> + * @enforce_sysfs: whether sysfs config should be taken into account
>>> + * @orders: bitfield of all orders to consider
>>> + *
>>> + * Calculates the intersection of the requested hugepage orders and the allowed
>>> + * hugepage orders for the provided vma. Permitted orders are encoded as a set
>>> + * bit at the corresponding bit position (bit-2 corresponds to order-2, bit-3
>>> + * corresponds to order-3, etc). Order-0 is never considered a hugepage order.
>>> + *
>>> + * Return: bitfield of orders allowed for hugepage in the vma. 0 if no hugepage
>>> + * orders are allowed.
>>> + */
>>> +unsigned long hugepage_vma_check(struct vm_area_struct *vma,
>>> +                 unsigned long vm_flags, bool smaps, bool in_pf,
>>> +                 bool enforce_sysfs, unsigned long orders)
>>
>> Here again, a bool return type has been changed to a bitfield. Let's
>> also update the function name. Maybe one of these:
>>
>>          hugepage_vma_orders()
>>          hugepage_vma_allowable_orders()
> 
> thp_vma_allowable_orders()?
> 

Even better, yes.


thanks,
-- 
John Hubbard
NVIDIA

