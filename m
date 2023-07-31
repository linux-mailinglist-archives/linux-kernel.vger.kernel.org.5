Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7DE76A32A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjGaVoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGaVoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:44:14 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA32DD8;
        Mon, 31 Jul 2023 14:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9fBrTL0Mx3u9+gE7w9znmK336cWSkv+u7TQM0cIaWPXl49WVFuFNzo56e6hfHtZJuvZAzqd771l+aJfFgo758lIOUy0lPGSmmfTjTe9Vm8+e3U1QYZ2DqVY6daFM6Uv7Zy+0mr/fGIT4CXqpEZ1HauiHWkcFfGbWDqH8B9wJO1W6OSVG7BGspyIsdu5rA0coqt+L85wOQJo9rZ6KJyD0YkxHpRKWkNV0ZHzquV8NCzkCB/lX+QHdPbrFLuU0An2zCaiim3U9uUkYDmR+af/pxt07eIuSdEl1F+xLviv8SugmO0P7YgHfF0OIEbezTpMnsALHsLPit9KTFAYVnE8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI6VdTcMVJB6hca8xSE1VTms152I2+adyOIOz8/V4cw=;
 b=BygxemXTqPBJ/wh10pe4K5UeTGTAArTJtSBI729HAnqtWAUXbsLyo29dNAlWI+JWnUg/lAmxMox9Wr27HB5Dl7mEiCJMF76wQsrvj0Ybx3P7lFfCZrc0tlMg/AO7pb0XvWeaJC/3kpbK80aUh2V88wQ3TcU2iQ+4oaFNLdXtxX27HjSDHX0wLg8Ou8y5ygfhPvM++ThoCpxyFrWdDBm+rAoVlzamF6wN1d4kHryMBhNe98bMAHcNOzDMW1SDM1NrNQ8Qr7KS5rahV3IX1HHwdW8KZ0H8xDga5cHU4jP2SRTJKyckjhBPMlSESNKFXFbPfWtNCBFStF2G8KbsNTQaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI6VdTcMVJB6hca8xSE1VTms152I2+adyOIOz8/V4cw=;
 b=NRzLmQsUhYRxq+LEMwVltLlExlZaMOJEAmcOfc3lFcnCulYiEG7JkLXUVrbSzfk2uLbTCgqsHQXpTB2Ra75U/mAOdd9BITz5LwMdz6J2gatbsTTzXEXJGoG9o1ipA06OBDl9RXoVNWXiSH7LK+knKhtXXVdT/SxwwEmq3ToVUqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 21:44:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 21:44:09 +0000
Message-ID: <f9ae26a4-25f6-bf19-9d20-e28eb22c04ee@amd.com>
Date:   Mon, 31 Jul 2023 16:44:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniil Stas <daniil.stas@posteo.net>
Cc:     James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, stable@vger.kernel.org
References: <20230727183805.69c36d6e@g14>
 <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com> <20230727193949.55c18805@g14>
 <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com> <20230727195019.41abb48d@g14>
 <67eefe98-e6df-e152-3169-44329e22478d@amd.com> <20230727200527.4080c595@g14>
 <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:8:2f::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: d0bdad88-991f-4b6e-a44d-08db920f457a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Xu8TlRUn+NN77qSYjc7EXsO8VhsGZI7CkkB5Q7OBV/zVlJp7kTip98QonZlrAaBMM0rL+f1eli/sZxadN7JND2DoGGm1BsHlcA4uaxQqToqZ1WwDxEd6H0VWEA+OYcjFdR3JhrDMpDqXUhLl3z5ovFkU2QtFnts2Z3U56r1KhhYmi/QQt6bzvUeVmnDB3UFFKLJl4hlSojdTaxa6ld0oKpw+Hs5TIdspbvVkXMVIcJPEs60/KE14DRbksEJ+xNopZZfQS/lQ8VpfF2PZ/TMB1S1M39Hv+XZB6Xkzvft2f1qSW0u7HOO9IJHOgO+a8KLI36xBWTKA7AdgdwRhvVPVn6DkU0iWZ5dL4IYIzbIeKfpHF90RfshrZcvVGbW9fV3qh96SNI1RwtD+VrxcJ0UopObw+MSmo+khwgRK25Kl0sp3yJ5eO3FBqTnYDLIa9Mf+6MuvCUPU3fdKMVdCztuvIFpxbSX1oTn0MY5HbIls79TNTzt1tlhTjELuLIz821RMJkwKEblCduEYi/DkaITNUL+HCCuD9a5ITy7Lcziz44C99+FyiWXqc+aIUiqTgtA4BRNVcYzk74Yax0rs/pdqg9Cny7GU5J1d+wHIdOiAmCQpR3WtnJrpgqaLb1uz6ehvAouK+Pqu3PFdG/Ft7lT0QhyPYf7m4zFn7H6/co/gT3rZfw8aIOLcw9eeF1V0iTp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(478600001)(36756003)(38100700002)(31696002)(86362001)(6512007)(966005)(6486002)(6666004)(2616005)(53546011)(186003)(8676002)(26005)(8936002)(6506007)(5660300002)(31686004)(4326008)(2906002)(66556008)(66946007)(66476007)(41300700001)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnpNMlprMGJIb3M5aFh3V0Mvd1dTOURVbjVGaEVQcERNTmd3K2h5SmxPMFQv?=
 =?utf-8?B?dnpRQnlFRnpjdU05cFVqRmcvekIvTmszVFh4RmZadTZQZVh3dEN1TkJYaW1j?=
 =?utf-8?B?WGRKQzZuSE1TUU91U0hiN0ROUkc3M281MHVHaDEzSlQ3SFdNZXV1YVAwY2FF?=
 =?utf-8?B?UEsrcjhUWGg3N2JmblNFaWNIeEF2NHIrVFBzWHZzZzVJdHpQSE1xZDF4bDJw?=
 =?utf-8?B?SldzVXlSTkRSYnZxZG9IVk5BcGVyUlVLaXQ4M0IzT04xdVZHbkFubGtYNDBH?=
 =?utf-8?B?aXZpcTlhSnNTbUUrTlNYampzcFl5V2FPa2twOWlvbU54cHpJSjJNemRVK3BE?=
 =?utf-8?B?N2lyT1FuOUpoR0Y1S0dxZWl6QWxCaEZFYmllM1NyTzFtdFpQSy90czBDSDV4?=
 =?utf-8?B?aFNCSnFvNk5WRlJHREtDWW1HNEdVTnUvTVo4eVlESHcvYTVhZlZUUW5hd1pl?=
 =?utf-8?B?dE5JZUl1clhtVzlybytWUlA1NndRQ0g0MW16bTd2QUxTSDNEWjNFSzhuejZS?=
 =?utf-8?B?cFhKTkZLTzdWY25UKzNEZjBybTdCVkY3L3BBRHlCZkNqazVFUytxRm0wN3Rp?=
 =?utf-8?B?dmNlem9ZSFBaRmtQaGY5YVJYSW5EUVRhUTYwV1FSMkE1d1JIRjA4SjdrRnNk?=
 =?utf-8?B?L2ZqSmNTVEZkVUZVazBIcnpzL1ZxclR3elFLZ2wyOFJSbFdyWE9rMVpMYWJ6?=
 =?utf-8?B?RmFRb2RPT1g2MXZRakxzMTBHV01TZG0xUkFQaUFCSUd2cXpDK3ZHTUN1UXZs?=
 =?utf-8?B?cHBzVUN3RFFyUTh6REtmdjFRakJYNDFMbUtYbmR6d0dYNThqc3VZeHlRVWg3?=
 =?utf-8?B?YnNQK2hKNVlOeXZWNG0rcDNGd3BldXJ5NmswblRNc0dnKzhVRFpNVmszc2pH?=
 =?utf-8?B?RjZ5eXpMa3FVSXhQQ0VIS3VKU1VhdWl1NlI1bk5BY21YMksxd0RCMmN0TTM3?=
 =?utf-8?B?ZkZmK09VcXJxb2tMV1MzT3lveTNsQ2pRcnRNU1hpeVBIckFueUNiclhiT09B?=
 =?utf-8?B?T2Ywd0o5aVVxUmxaYjJDYXh0dDlUK0FwYkEreDBWc0FKa1h3b3Z4blFBR3c1?=
 =?utf-8?B?R3N1SHlZOGJReTdiLzN6V2pPUzZMNkZFRVlzd3U4by9VZTkxbHFkdUxEK3hS?=
 =?utf-8?B?dW40VStaUEhPNE43VzZ6SlNob1I3bkkyVC9MWHh3NVhUV1hXcmhLV0xXb3NF?=
 =?utf-8?B?bS9sU0t6TXBteHFLUzY2azFTTkx2TmVDbnMwRGRHbU5aU2trV0tWaDhpWnVV?=
 =?utf-8?B?SWU0M3l6S25NZ1VHbzBBZkRhQ2lGNzdYL09jS2F4SmNFdEFmMUFyMEt2aEQw?=
 =?utf-8?B?VkFXbnNpb1BmTS8zTTdGVkkvZ0pQdU1hdWNxaVhUUUdhMmJqSXVHNVhnY1J5?=
 =?utf-8?B?UUxOcDRHQmxxTkdrbHB6STZiYTY0Q01zeVA3VmUvQUR6cnFSWEp4UGpVcnJs?=
 =?utf-8?B?RzVKM1daMWNXelJuV2UwSEtWU1MzSG1GcCtnR1JONGtRWmp6bDExWFdnU1NU?=
 =?utf-8?B?a2hGWG8vQ1VMeEp3LzY2clgycHUrSGZpditoSzA5eEZlN2N6VVpwa3ZPd2pP?=
 =?utf-8?B?MWdXaEF1V1hZWkxxZnNJZXFUVE9JQW1pQlB5SGtnR1o1V0x2bGs4OXh3bFU3?=
 =?utf-8?B?M01XRjltcnZmS0x0MG1lR0taWjVhanJzRnJBSmwrUk0vaC9kazNuc2p2cW1E?=
 =?utf-8?B?dEU5aDh1NzlXK1YxZExCdGJIcUpmUUNXbUVZQzZkWjJNK2xRU0QvRzBHRm9T?=
 =?utf-8?B?REZmQ0g2ak4yaUF6RU84T3QrQnQ4bTZ2SWFlZmhyL0F5UldUbkgxU1BGZExL?=
 =?utf-8?B?dGYyY3laVFM5S0VtYWg0Y1NwV1RaVWhiUlJNNE9FdEo0aExSVXI4dGtQSC90?=
 =?utf-8?B?THdBL0RadW15dGs5Qm5PcVFxbTJmQ0h1aVU4VFRlRDhWQ1hjcEFVVHdRczNP?=
 =?utf-8?B?SFhyaERPTVpOMk4rcHdFS3lNY1JKY1UyWFdscU1lSHhKMXh2dWxkc2RLTk43?=
 =?utf-8?B?cHJFZnBXR1hkSEs5dytUNzN1NWh3czhucFBrM2g3K1E2RzVxejAybUpvNUtB?=
 =?utf-8?B?M2diclQ0SURpc1VNU1ZHT1A3VGJyRHRkMmQvamJCTTcyQnZETDhNLzNnemE4?=
 =?utf-8?Q?YZI8uJRHi7YzDX0av+JBrP+z7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bdad88-991f-4b6e-a44d-08db920f457a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 21:44:09.2410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5xIkCH2MSWA57lpyCb/+voWgIFdgO5lcwJllqGiwkB0+c97Kq4ibgUquG3wCYq687X0MZLR+mG8L5tN57M0vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/2023 5:53 AM, Jarkko Sakkinen wrote:
> On Fri Jul 28, 2023 at 8:41 PM UTC, Linus Torvalds wrote:
>> On Thu, 27 Jul 2023 at 10:05, Daniil Stas <daniil.stas@posteo.net> wrote:
>>>
>>> Here is the bug report I created:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=217719
>>
>> Let's just disable the stupid fTPM hwrnd thing.
>>
>> Maybe use it for the boot-time "gather entropy from different
>> sources", but clearly it should *not* be used at runtime.
>>
>> Why would anybody use that crud when any machine that has it
>> supposedly fixed (which apparently didn't turn out to be true after
>> all) would also have the CPU rdrand instruction that doesn't have the
>> problem?
>>
>> If you don't trust the CPU rdrand implementation (and that has had
>> bugs too - see clear_rdrand_cpuid_bit() and x86_init_rdrand()), why
>> would you trust the fTPM version that has caused even *more* problems?
>>
>> So I don't see any downside to just saying "that fTPM thing is not
>> working". Even if it ends up working in the future, there are
>> alternatives that aren't any worse.
>>
>>                   Linus
> 
> I quickly carved up a patch (attached), which is only compile tested
> because I do not have any AMD hardware at hand.
> 
> BR, Jarkko
> 

I'll get some testing done on this patch with some AMD reference 
hardware, but off the cuff comments:

1) It needs to target older stable than 6.3 because 6.1-rc1 is when 
b006c439d58d was introduced and 6.1.19 backported f1324bbc4 as dc64dc4c8.

2) Add a Link tag for [1]

3) The fix for [2] is lost.  The one that landed upstream was
ecff6813d2bc ("tpm: return false from tpm_amd_is_rng_defective on 
non-x86 platforms").

I sent another one that checked for chip->ops [3], but this wasn't 
picked up.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217719
[2] 
https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/ 

[3] 
https://lore.kernel.org/lkml/20230623030427.908-1-mario.limonciello@amd.com/
