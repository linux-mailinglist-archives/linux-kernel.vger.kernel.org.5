Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E1C7D3D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjJWR0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjJWR0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:26:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B81C5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzKDgarNT/uzSbD/chKIznJo0uXr9GXWniL08ej6Q8CTxXcjbwgPnwJXbz/eCoVM18bxYE40Z4i0QSkqJ65BviobKOPD6B7eTFOWiBeSyJ9N0FkdZSvPvSRGpx7Kps40vwmRflDdqqGzkAn6HUfBYESj3jvXfQqnN4qR0nlwvaG+AtgF/MEB+J95vrrL4ddUa0rpofDVV7PvXKAs1RPmm+Tqt1Bl4d+EtOzjsBcd/hwqskltk5/0KHdAa+myWmugajSt7LTnp9stdQnMMq8j3u2oQ0ocZE0pqgjWD885t8+Bs+A64ooaWIqzCJGFRdFa5kPd2jfQtorVXNV9o45mxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ChAY3qU6V4u414jDbkvmQgJ1caU3YOLpkbm6isBcx8=;
 b=m/kr1++h0FH6GFOg2lBrqfimug5sQ/SME5eyiqC9GDK0wvpfNqet5LuGISdZJXsBK1Q2JU6R+ebWBlzGGqDbL+xyRC587M6/ySXwFSb6YuDNVd7kmlECpC2IlDlaj2mjyBo88cYpAz7LMsIIPu5/C8Ptj1jZ9ZraBSwiUyTBNqsBAYMTPTM+cuwj11eh05d9bGhdneB7TRz4upTlZB/r2Bq8EOjei+QYLgM5AhlXjlrX2MpcpiAwCVw2SdNprY5fcmbJ7+Rlx/I9vbVL9EfbJPyOJKZNbrv6RsWtv2r1u6TAwWtVknu+BCtU8QNml4A7BtXPQG0CfZS6ZGr0uss9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ChAY3qU6V4u414jDbkvmQgJ1caU3YOLpkbm6isBcx8=;
 b=GJlMBDmr4aOfyoSS8yvq1qcTe99pA0p5xtbnCM2gzVVc3mgcNL1llyGoxl+K5PhLzYh4Wj3qyXm7+aKF9EkCX5nEkZp0ocrFA1JfCFbGbCO6x0AhXuAzY+uRWsPfJWH3kaKszYaVgiCVhu3xN/EKnGCDlgGM9zR1QWYGF8EfhYUyUxX2tqIzQeDHA01o9YpMdU2/4+YUOeYQcMv/T412nHL7OcN/PYK0wmG+15rL0rJOmzwt7bupYgNNOxBZ1J+LhlfVDWp/K0w5X5/+FznzUyuPppzJLQZfmbQyjxPNS0aQCMdUywPYpWhFZVS8QiuaQ6W7Jd9BqinpTTepvwLWTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Mon, 23 Oct
 2023 17:26:08 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::16f8:183d:56cb:ba69]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::16f8:183d:56cb:ba69%6]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 17:26:08 +0000
Message-ID: <1e603c14-54aa-1ea8-cac7-99b29af92b4b@nvidia.com>
Date:   Mon, 23 Oct 2023 10:26:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] hte: tegra194: add GPIOLIB dependency
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, timestamp@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231023115646.3573494-1-arnd@kernel.org>
 <CAMRc=MdoRWn_grWoKWagAi11S=mZ9RbP673L77a+qfN_8oTBcg@mail.gmail.com>
 <CAMRc=Mc7PCEimVEJ_JYg=4+X5PAJ1Lh2SxXsNEFpuKctbEPiYg@mail.gmail.com>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAMRc=Mc7PCEimVEJ_JYg=4+X5PAJ1Lh2SxXsNEFpuKctbEPiYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::15) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: dace07f7-b981-4eee-ccaa-08dbd3ed2492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0V7X/HCwstcBhsOsc9v6DAegumC7sC3M3Jfe02Av89Y+WbPJJJXrX9RtvU9U8BSWPClggyLab+XFePVKurUFlSDvnDeW04xE9YDlvOHMwjzD9B3P4KI3eFrWS3tIe3YgtJzL6oFqtQBSUv3n2gJdCfo+v+IX+SBMhThsvgOhz1NUaUkuo+1s/kmBD/Rj0dYKpgbm/KwyU6Zcy/vIaouhxzMlbM4cjIFiVPcFn7yV5/7f2of+mpUigYmCL1UV7nz5DjQxue+JX8+SjM6mtk1N0iT71MPVGXqRpvVxQfVvNdeuTuBTL79s08uiHcfD3ApUWAJt2v7UOJQ9hmRkBiQuC3VWherROnz1ZiezC26y4gPiDkfrTCacy9zlnuajaWgbo/CaMIDvfgMENFJGsUdzwn2YvcqgL8UCsG+Sxcr2G7vycD5YQSvjP1+cbrOJQXmk4wX4cJtcDtD7phiDlPBZpN/ugXbmIrF3bgUI40qew782pJTnThKTMXPp6GAntWdPXHazKY6gduOW/r8BpaEziHsUrorlJfAMZxWFQ82nWTpZEyPiKuRYnog9BASXy1ySBFTWx4KqZ7pKFdFntRx3YRBjcqTzQ9pi+dCh2K6p1ukOtzPzFeaaDE8TXHi0Y9mIlNamwbHP42R+J9F1Ug1GWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(316002)(6666004)(6506007)(6512007)(83380400001)(26005)(2906002)(4326008)(8676002)(478600001)(5660300002)(8936002)(6486002)(41300700001)(66476007)(86362001)(66946007)(54906003)(110136005)(66556008)(36756003)(38100700002)(31696002)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG1BemZhTDNjYWZYRHovTmJudFJnVURQSDhHazFkVkJtVDNFd2VTSEVNQmFw?=
 =?utf-8?B?RkFIVDRqeFliU2tjRXgwVDYzSllNaDkrYUFaU1hOVVNPN01sVVdnUkFuUjVl?=
 =?utf-8?B?UFgrOTIvVE5JTEZwUzF4WUZOOHRsSUcveWt4ckV6cWVnZEdWY1ZoNVNYZGcx?=
 =?utf-8?B?d3RiaGwyODFhRVJTcjZrN0pEMnBkSWw5YXpZM21HVitSRUw5Z2x4RlFhUmNl?=
 =?utf-8?B?NUd1bW1QRXM2eGtYenlZUGExcFlFdUp2Z3d6K2VjTDRISU1VVlMvZXQ3aHpG?=
 =?utf-8?B?MXdFQmRwYlJNVXAvZ1Q1N0R2VzVXTklUcHFMV01WWXpkUkI1SmtVWVdtZzVM?=
 =?utf-8?B?dkUzcFhBNjV0bVhGTDQrZm85QjVoUlQ3V0tDeXVPQ1JwaFNwQ2IwU3V6Kzcv?=
 =?utf-8?B?eTg1WXJIUGQ2cFQ4ZkNUV2tSUUFhL2dLUEpaMEFtS2ljeXdzUVdzMlc0NFJP?=
 =?utf-8?B?ZFdqS1cwc1JLSEkzZzhWZXp2VDUwZEw0T3RSLzhQM0J2OGJtVnpVcXhsQW1Q?=
 =?utf-8?B?SGl3bFY5U3drUmgyODhSZ1BPZUl0OGpOVE5ZNWRpUEtIRHBDb0VVVTd3TjEy?=
 =?utf-8?B?NlR3T2p4OXhXWlhpQkpieWlUREptdC9SUXJER1VzWUREUUxvc3pnVHlReTAw?=
 =?utf-8?B?N2F6OGZBVWdsT0tpendmaVh2Z3BUZVNjTFF6OWFOQ2VwUU9UalBJQmVkOTF6?=
 =?utf-8?B?dWdyMmJaUEpTdGRaWmlPUmRxY2c5cTgxRDRIZWxCaDdHRG8vQlMyOVRGV1Rq?=
 =?utf-8?B?L2JIMTZBTmZmTnltTUlJR2Vzc3cxelA0RUZGbFdqSEg2SnJwQk44N0xZZkts?=
 =?utf-8?B?OUN3c08wWVlFakxCempKK1F0VUUzbzNpeVpxSy9PaUFUQmwxQ3lXSk1iZ3pj?=
 =?utf-8?B?SndsTWM0M2Jkem9WWDhiblpoOUVTNFNCa2tjNUJWRHV1SG5Wdm9PZ3V6bTBU?=
 =?utf-8?B?TkhYVGJRVG8vU3IrRzRvODRDNmpvbm1zVTBWMmpiNjNmQVZWWHZCUmJueDZW?=
 =?utf-8?B?cEQ5Y3ZCWEV1Q1BaWDBwMGp4SXR2Mjh2MFAzTmorVUtFcDgrOGtSMlNGQUl5?=
 =?utf-8?B?MGtZcTZzb2s5T0M4S3NxUnprcTFaVUhyalFyeUc0bVRzZEM3RHprRHFzV2ZO?=
 =?utf-8?B?K1FoVC84eStrY1dqMEZNdGhqYXYxK0taWmUvWG1jYVVCUzQrUkFkd1hPVlRq?=
 =?utf-8?B?Rm1kTnV3V0piejQzNnduSmswWnNIMVVzVHhQSGhtRU4vR2FJRFNhb1MraXJh?=
 =?utf-8?B?b3RNNU5NZDY2SEpFcFkvbldyeDBxM1kvNXpFMDF6TlhhOXJyaW9OcFdaUk83?=
 =?utf-8?B?OXhYdDlpdHVYdDBrZHdab2srMXdxako5OVVJODhKQkVMRWtWckhoQkFyZmFx?=
 =?utf-8?B?eks5bEd0WmJWdWg0djlaWkpkaWc3N1hXdnVxTHk4OUx0V0wyNEordDRNZjZX?=
 =?utf-8?B?WEF6OVM1aTlWbUVtcEMzN29ZU2tWWXZRbHdCZUVKbkV1U1hPM2ZlcG0zSXJm?=
 =?utf-8?B?T0trSUEyNG1lNkJFMUNleTMzc2JpZU5VejdDc3IwR0pwbE42dXAwVW1JTmhR?=
 =?utf-8?B?TFVlYnBFNU0zaUFjZlhQbW9zQWg1UDlSQ1NscjkwTVA3TVRrNG1zWjNGZmZK?=
 =?utf-8?B?a0QwTUFKYmpURkNtZnpHNUNkamFyMnVRb1VUU2toWVA2bDE3eGFSN3NJYWRK?=
 =?utf-8?B?aVRrL1pPdzlHN0VKQ2dSbTJxVDFrSE45NWsyM0I4dndsbnFqVW4yNUdNMXZm?=
 =?utf-8?B?MVpxaStBYlJuS2EwcUNCR0Q3V2xLWlJvTk5HUE1FL3FGU1NKZmhGcnYzL1NU?=
 =?utf-8?B?OXdIL0tOMEk3RE9yR2Zkd0V3QnpsbG9ETDFmbjNVQjFSaTRRaEZoQXZUQ3Rz?=
 =?utf-8?B?U3laN0RHM0FlWGVaZ1l1amJEakhSeUdSR3dDOXA4aklsS1lCU095d2c0Zlg1?=
 =?utf-8?B?enAySk5HUTlyeXdTNG5UWno4WnJHMTBKTWd6Q29oWHZDcDhPZ1F3ZEdWUmFB?=
 =?utf-8?B?UVpaRmt3c0ZkOWZoa2tpNTJ3VTZHUHVNZllzeE44bmhtd1VwZ3U0c3p6N0tG?=
 =?utf-8?B?Z0J6VVhadXNnUm5WNlNQYUtnTFRWL052eWtSZ0M2dWRUYkc2bWlIbkhTSHE0?=
 =?utf-8?Q?bSoRaRSeHyMerrybiRTMC/lt5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dace07f7-b981-4eee-ccaa-08dbd3ed2492
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 17:26:07.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43DGc8FCi8GrKXLrPrJKBB6XJ6Hpdc8Dbh6/2fafeClXBBfHJsey8MKNyt1+TvtUMRdElRFETQN8qrdII4pm5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/23 5:02 AM, Bartosz Golaszewski wrote:
> On Mon, Oct 23, 2023 at 2:00 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> On Mon, Oct 23, 2023 at 1:57 PM Arnd Bergmann <arnd@kernel.org> wrote:
>>>
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The driver started calling into a few interfaces that are part of GPIOLIB and
>>> don't have stub implementations otherwise:
>>>
>>> drivers/hte/hte-tegra194.c: In function 'tegra_hte_line_xlate':
>>> drivers/hte/hte-tegra194.c:424:48: error: implicit declaration of function 'gpio_device_get_base'; did you mean 'gpio_device_get_desc'? [-Werror=implicit-function-declaration]
>>>   424 |                 line_id = desc->attr.line_id - gpio_device_get_base(gs->gdev);
>>>       |                                                ^~~~~~~~~~~~~~~~~~~~
>>>       |                                                gpio_device_get_desc
>>>
>>> Add a Kconfig dependency to only allow building when this is defined.
>>>
>>> Fixes: dc850faa28ee0 ("hte: tegra194: don't access struct gpio_chip")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  drivers/hte/Kconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
>>> index 083e67492bf2e..641af722b555d 100644
>>> --- a/drivers/hte/Kconfig
>>> +++ b/drivers/hte/Kconfig
>>> @@ -17,6 +17,7 @@ if HTE
>>>  config HTE_TEGRA194
>>>         tristate "NVIDIA Tegra194 HTE Support"
>>>         depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
>>> +       depends on GPIOLIB
>>>         help
>>>           Enable this option for integrated hardware timestamping engine also
>>>           known as generic timestamping engine (GTE) support on NVIDIA Tegra194
>>> --
>>> 2.39.2
>>>
>>
>> Thanks. None of the new interfaces are "consumer" APIs and are not
>> meant to have stubs so depending on GPIOLIB is correct here.
>>
>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Ah, this goes on top of the patch that is in my tree so I'll wait for
> Dipen's Ack and apply it.

Acked-by: Dipen Patel <dipenp@nvidia.com>
> 
> Bart

