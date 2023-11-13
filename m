Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063C97EA5C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 23:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjKMWP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 17:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjKMWPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 17:15:24 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F18DC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 14:15:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibt78wGrd2H/36jFhj+POdgBmtQVLnRIMTJJEm6EnIz6MAVZ+QvuoXLlhdrAXOR7A7SYLQ1zlSGZ5A0w4aY9XY3pGv0O6a71NfKtuEF/XjpmH+67GBeifO+dhiHV0d9f7KTgSN52bpKdy31DVuhGggDugIvIgL5gBjjjYT+0akaavTJ5Fd26hpVF83oJpkYH0CJ1iTtbesaid7bgm3LCstYvWSYoEiDmnWRDbec3xl4Ze5Z32qVqpyiwGW1bZVbkSfEbWkqOJ+eENPWpZv5RWyEche7gxTfPGrvC9rvfg7XIw2ydkVvLpUeUO3/sViprIfVtJ9YVJ7L5Ra+ujyRmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kez17g/rz99ePxgBKcsDyE/J3vr+TXL+4b+iD0qxNSY=;
 b=YMMlQ91BL25pYCx4uEbhEGpLscIA5LlYKl4XiLVArLhXrHYBpaSwMR8qkBFAnjtWQ+C6wMCBlFMgZjrxSb9pCo5zJ2G1YDcppYQiB+PNNcUy2xiPNe3e8Mb/hQNLu5kwAq4LqghlicbaSwGL/M9SYJySbq5m7aLhAXIg4YO9/OIiy6O2CFH6UglvKO66GETfFet5m9f7tDHk0vPyHZHUORL4inMGAGWQkGdDAGgjLP8Zpi4HteyT6I/Cb7Y/zp5XfOl8wNPH21Sn75L2sVbOWD3ilCfIazJ1SeLPLV620NsUH4YuHLjIAyQFHB4JIS1mwPSMExpS5JkKL6ooYX3zCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kez17g/rz99ePxgBKcsDyE/J3vr+TXL+4b+iD0qxNSY=;
 b=L8ebNPXEMdV/WsX6qigRgh+qw5WVGzS7iOEViX0Y4KWKOqwL66y2w9flZZRQSwn9H1iAOJE7OxhBUb1IdJsw4IO5fXpwhFIWJ0doTk6Bzna3T9jxieIzDiFfFfDhvXAHjiEiCDWHctM7UCR3RTdXsVCwbOw/8EvEnFX91EK9VZQf03uWPXeWvmDaeYeiHsqK/WyNTgM4mBxC/8duQf9ww6tZ8mn34UmKb1utP520oACiVXYZkb2kRHmlInSz8qGAbfK79O8nQPwsn93xc2ZGC//8AakR1oznSVe8l7AvfDWM2LRwYTuywbbnqFTH64AS1XYZ9GPRgzkDAFKwIOd8IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 22:15:18 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.6977.019; Mon, 13 Nov 2023
 22:15:18 +0000
Message-ID: <00372b9e-6020-64b7-1381-e88d9744ed05@nvidia.com>
Date:   Mon, 13 Nov 2023 17:15:15 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH] mm: support large folio numa balancing
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     ying.huang@intel.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
 <606d2d7a-d937-4ffe-a6f2-dfe3ae5a0c91@redhat.com>
 <70973a55-63a0-4a85-abe5-d8681fdb3886@huawei.com>
 <e75ce7a4-1294-435c-86eb-d6cf55281a39@linux.alibaba.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <e75ce7a4-1294-435c-86eb-d6cf55281a39@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0015.prod.exchangelabs.com (2603:10b6:208:10c::28)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e42517d-f4f1-4d45-8e74-08dbe4960525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98ZIOBZi6DnL+jkERxgrqygUmckcSOEbdbBr1FjF7i/7AQTEi6ib4rQwuXhosJmcYvZjzswC+6O4FlcEF/gNtvQUhDqlMI+gKA/8p2RT+740cZKkcatB/YuowGDLUxvxIS+Fh+46Sqb6CuYidHkelrP1lECrklDZWalKyVJtoKNolrtD83m7PW5u6irA0EDFL8c7e0oI3wLSpaWssphvChx4a0pmBpDNq6nTpChMZMGK5/EeXzjq9CbG5Zs7OwMx68wTUpndnhPgoA/3etpOiao4vABQnh3gdLvzPPF1BBm+9SZ4gbPNo/p5FaB0AGlwXLOo4ZZtlcq8VaHDQtEB7At7pk2ftr+M5gZX0x/Iv4vISmnho5+XJ8YxqVu+Ddn0CXnimw+fuqqUzri8rdJKbXio5q8/P4i98b8hvZOpJA7KgbZWipG/GbxMGnhiXoYaMx328ZbMd8QMIcGIr+M8I/3CVjeF46ETF9bi+kZvf7sSpR6H/7O+K2IbgxWP94GoLD4HsjJtHJVAPidnulnNMXSZRdz3TGl+yD7jEjhom4xD6tCg3RFg2RiI2g5ArQVN/CPkybf1JB2+vQ+ek4cTFOaVn1jG9/XTJ3hrC1B9NCx1GtulyI2dNBNPDWJGMKrPmqzbAegl43VqSiXoTbMrMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(86362001)(83380400001)(38100700002)(66556008)(66946007)(66476007)(36756003)(110136005)(316002)(8936002)(31686004)(6512007)(31696002)(6666004)(2616005)(26005)(478600001)(6486002)(41300700001)(2906002)(6506007)(53546011)(8676002)(4326008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWxFbWlTNzI5dmY3ZExjUGowSWVGZ2FTV210L2ZMa0NKVmVPcmZXSE50dTBj?=
 =?utf-8?B?YldVakc1eXdzclZSbjM4cGcvNFJtTjNtOWI0ZmZzZks1L21nZjhWaysxM1Zx?=
 =?utf-8?B?VmpNOUZXZ2tHZjNzMnBiMHBDSnM3SGdyVldPWjZTRHVlUTk3blhVU0gvS1Vl?=
 =?utf-8?B?SlNtdkNpTnEzRWs2S0l0OFVIRittaDJQazdlMG05OEswajd2TkYyanU2Nm1a?=
 =?utf-8?B?TnJMNUVDTkh3VUQ2blh0aGYvL1o4WnVMeVRUaCtxL1hteUM2QnpDMmsvK2N6?=
 =?utf-8?B?Q2pRNzBabVlGT2pSVnhlNVIvYVZwME9OLzAwZ0FMeGJrMzRkdDZONnZOekJq?=
 =?utf-8?B?UGFPWXZoTllWUGVuT2QwMXZhcnJ4SWdqQUpzYUtySXhvZjlSVkhIMDVxUFQ1?=
 =?utf-8?B?K0piWnJ4L2pVcGdGTjcvUmoyUUNrNHNCOE5Takp3a2grWWtPYXhSWWRKclhV?=
 =?utf-8?B?TDJXVXA3VVpUTTd5TllCc0JTKzRSRTF5Ymw3RG1PeHUzQnJuZHlDTktjTTZx?=
 =?utf-8?B?M3BhMTBhN3Q1bFEyUmFobWF0ampIUlRHemlMdmlRUlo4VUl6NitZK0VEUXVO?=
 =?utf-8?B?YzhaYmlQbi9sY2svTElsWHpVYXhnQVlrMElLdUlQd0puZEJZSDdGc0c5ZkFm?=
 =?utf-8?B?Q1YzREhLeHRUZFFmQU1KbW9UNDZ6V2lkRU9UOXpSa1IwWkNXL2QrNlU3dHdW?=
 =?utf-8?B?T0Z5SW1rZVRDWU1iYzFGa05LK1lJTGx3L0x2R1ViN2VCWkp1c0RVLy91VTJk?=
 =?utf-8?B?OXlOZkpvNENqc3h0TjV2M2xGU1hYVWU5N0ROendnMEZuMzJPUnJVb3FjZGhv?=
 =?utf-8?B?N3NkV0E3aTNWVXFzUENac2ljTjkwWEk2LzZiV1VmMHZpUVFOY210Vm9TNERZ?=
 =?utf-8?B?Qi95RThCNndYb0FoZGZUREE1dkZGNzlhRjhwZzJ3UXdISlAxVVVQbm9UQzdz?=
 =?utf-8?B?ZVpQSGttZUpMdXZqMXQ4Y2p0Qk5xY1MrVi8wMDA3MmhUbW1IZjVndHFvckd0?=
 =?utf-8?B?c2dFcEJiQS9mYlMrSWZyOXpCVHNYUkZobVdsdm1rdjNTVTJ6WVNuK1BzZWNz?=
 =?utf-8?B?bHNMRUJ6dlVOakxqQkJrUW1VbUFVMGhVUW4yYXlJb0M2TlhSRnhlOG5Cd3cr?=
 =?utf-8?B?WnYzeDlqZUtOdXI3QXZZZjBCbFRZaGh0UWFqbGNXV1NzSjdjVktNVFpXQ2RE?=
 =?utf-8?B?a3Q3OUNXMXZQSkFXR21YT2ZpcG41Sy9oNnZKZmczU2hFSm82ZHV1Mlhvb29D?=
 =?utf-8?B?T3c0Q1RibFpTdVdtNEF5WGJhQ1ZTa3RtWFRoWVhlQlhFSzF0eUhlZXBVQXda?=
 =?utf-8?B?UW1UNkt0eDVTYkVOdGg5Y2lmWmZMcFRGaVRsUXVaSXQ4cjVTQkh3SzRFTWNk?=
 =?utf-8?B?UllJQzZwcW5lRzg1ay9LTkRyVklTWGM3cmxvcnpNZEdldmZpOXdOemMwb0xx?=
 =?utf-8?B?SFdZT3Y0TkJzNkNvOExKRzdrWitxeXRHMmQyanhKbUNzL1E1MnZtYVdKbmN2?=
 =?utf-8?B?OEdUMktyYk5MeUN5VnBRY3BDbjg2Y0FIRCs3NGVwb3ErZUo2dXBsT2hrbUtC?=
 =?utf-8?B?L0tKVUxkL0pUVTZzV09xQWtnTjFRVjN2azFsV2tCNTZ0SUR1N2F2eFVoNFdp?=
 =?utf-8?B?aUtzMlN0VFVPMDZIbU9tYlQvWDY0L3RvTGtUNEFaQWl1YURPWCtCS2Z5bVht?=
 =?utf-8?B?WkkxZVVNWDJySVM2ZG5DV0lDcGc0YmZkM3o2MFFDUlhobzZDUzRSdVlDZENn?=
 =?utf-8?B?clF3Yk9oUGVXcHlnUnNUa3lxWnZJdTFCZlhaYjUxK2RZSjM0TlV5UDZhZFYx?=
 =?utf-8?B?QndkYSsrY3FzdXRSRmJhamV2U21FKzBvaitCQldqNnBvazBkb0NKWFlIcUFx?=
 =?utf-8?B?U2pYNGo3Mjk1bVl4aWkzMGlieVlWUXpkZXRqVmVjRUtocVFRRk4wMEppVFYz?=
 =?utf-8?B?a2VCd1gvdkt6UjdVNVUxbk5QbytPYjhGZUlJTU4xZklSTUNKZHFsNFRlaHB0?=
 =?utf-8?B?UnBZZUROQy9YSVByZWg2bnRMakc1Q2dMbEt0VmViTFBPU0R3R0ZEanRsUmJw?=
 =?utf-8?B?QVNqbHBQL3BKOTQ4SzlDYjl1eHkxU1dJUFd6Mlc0NndPV2xaRWlsYjBIRkNn?=
 =?utf-8?Q?yA3G0PNukZCJcVCixNCOA7Us+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e42517d-f4f1-4d45-8e74-08dbe4960525
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 22:15:18.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN0VtYv8wTW9D8kUxD3gbPeedrsAUzib5Jskmyf1W3sgKvPhrizjOHksnLak7nyMpPqP2wbw0JYbKUfbDd5pTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/23 5:01 AM, Baolin Wang wrote:
> 
> 
> On 11/13/2023 8:10 PM, Kefeng Wang wrote:
>>
>>
>> On 2023/11/13 18:53, David Hildenbrand wrote:
>>> On 13.11.23 11:45, Baolin Wang wrote:
>>>> Currently, the file pages already support large folio, and 
>>>> supporting for
>>>> anonymous pages is also under discussion[1]. Moreover, the numa 
>>>> balancing
>>>> code are converted to use a folio by previous thread[2], and the 
>>>> migrate_pages
>>>> function also already supports the large folio migration.
>>>>
>>>> So now I did not see any reason to continue restricting NUMA 
>>>> balancing for
>>>> large folio.
>>>
>>> I recall John wanted to look into that. CCing him.
>>>
>>> I'll note that the "head page mapcount" heuristic to detect sharers will
>>> now strike on the PTE path and make us believe that a large folios is
>>> exclusive, although it isn't.
>>>
>>> As spelled out in the commit you are referencing:
>>>
>>> commit 6695cf68b15c215d33b8add64c33e01e3cbe236c
>>> Author: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> Date:   Thu Sep 21 15:44:14 2023 +0800
>>>
>>>      mm: memory: use a folio in do_numa_page()
>>>      Numa balancing only try to migrate non-compound page in 
>>> do_numa_page(),
>>>      use a folio in it to save several compound_head calls, note we use
>>>      folio_estimated_sharers(), it is enough to check the folio 
>>> sharers since
>>>      only normal page is handled, if large folio numa balancing is 
>>> supported, a
>>>      precise folio sharers check would be used, no functional change 
>>> intended.
>>>
>>>
>>> I'll send WIP patches for one approach that can improve the situation 
>>> soonish.

To be honest, I'm still catching up on the approximate vs. exact
sharers case. It wasn't clear to me why a precise sharers count
is needed in order to do this. Perhaps the cost of making a wrong
decision is considered just too high?


>>
>> When convert numa balance to use folio, I make similar change, it works
>> with large anon folio(test with v5), but David's precise folio sharers
>> should be merged firstly, also if a large folio shared by many process,
>> we maybe split it, don't sure about it, this need some evaluation.
> 
> IIUC, numa balancing will not split the large folio.

That matches my reading of the code: normal (PMD-based) THPs are
split, but the code does not yet split PTE-THPs (also known as
small-size THPs).

thanks,

-- 
John Hubbard
NVIDIA
