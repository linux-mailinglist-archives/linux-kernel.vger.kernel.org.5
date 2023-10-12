Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394197C74F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347395AbjJLRi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344100AbjJLRiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:38:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43791725;
        Thu, 12 Oct 2023 10:36:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KE62Db6BOwzONvrKuRV5B4422DA7AhCToFwQuhfyMzBbSInLfzlh7REUNfNhRNG0UTLqX/NcVknPTOJtTW+1u1ozu8zlsKxRJ3jUe245TuSalFbSwxggOV9rWJlcjzQ9VP57Cl+z4FiJxdidZyaSac4qXH13mAn+wByAoHjsH1qzkuIyHcrsDmjNaa+QFlUY/6/YE3J45c3vn2DT2g5DdRrqBa+bV/3O2q+QuzwlT5Uwxdpv0c9IpzmEiRxO/S/TasAR2aV8sd69bFw0c4S1NU0FlUbBhgM3pQEMbt1WsdpDknCr833uxmsXvZl+qZZ/zOGuOM4lCgBYvsjLBqhBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg2d/1RDU72eCNDeqxV2LDSbSGhsRumXv/uBGInzfEU=;
 b=RDb/0TxKdHJs2+6VEE6sTGFsIP0Nn86SHOqSb3U9CfYnIl4pqRCasRBAyP1IQVg9ZOe797XZGcKOHKAgEo9KS+poVpHDqfnsEv+JRNhy3cwiEIZ7QIUTh5EmPYt+gOPeJ55vuEJiTkfdQOu94tCLGmsDfhugJ2Mtkrj2w4mPteAtZm6fF/wiknldbq9ljs2Jf8S27/r1CzheTX0f9L9iELZbr8NpXhORh+uRxeCeSQ4wc+vM+xvuRUtKItyGbkbUaPhQ7gjCiNEp3O90URfTrqpQlzCw0+2yvIOfXYZVUocksXnHXfl1YAD4hmqWSVxHyhMu57sv6DYRd/VwTknhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg2d/1RDU72eCNDeqxV2LDSbSGhsRumXv/uBGInzfEU=;
 b=AxHId+zqo2EknO1KKTVQHWanXQ6LmKWZyJGdkB/tlbzLWJJ6dxaN9QeIbI47MMB0naQLZMP8P9iUmal9h16SFZGMjRkJM2hdR5tuzSptMRaCz27jyCtatWL0iUKbAATXrKSGfTnCrRIWaGw4dBRwub9jvWZ22LfZgqs+ed/ZLuJ+beNkITQTIe0onVq72KLWXEBsIG2zGo7tR30ulF1XkAYp5P2Sh0JcbHoaLM9xUGNelxajTT6CN7BoHGXfy+BVLF9GdUuT2/TdoNKZIIhq8h1HEpQw4nRXohc3uUR9NKPhcW+obY/BvA/0bRIo6A98naZU+YXz/N0Gh0v2yICcCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 17:36:41 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 17:36:41 +0000
Message-ID: <fdc75e70-ee82-a78d-3d90-21cf07492a6f@nvidia.com>
Date:   Thu, 12 Oct 2023 10:36:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/4] hte: Improve GPIO handling and other cleanups
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        timestamp@lists.linux.dev, linux-tegra@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <20231011202638.372382-1-andriy.shevchenko@linux.intel.com>
 <75fe5f3f-41d7-76f8-47f9-9178fa030804@nvidia.com>
 <CAMRc=McMzH4Tsr3wASN+cTfr=W-K4OnD4gO4xOxRO=aVffbpKw@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAMRc=McMzH4Tsr3wASN+cTfr=W-K4OnD4gO4xOxRO=aVffbpKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::14) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|LV8PR12MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: 8251f9a3-8978-4f3f-c6aa-08dbcb49cb72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3/FMEYHPh7X41nyVBbCNo6DvclH6IHAJsKY9MrOwcWKn4GxES/0jAYVntiGFkYa3t7GiwX5gijvL1BxZS7KyueNsEGp6e8Q85youOykVGrihh2Ujo634cUuOxHHThSsW2JqpJYwzJtVgZJ/PVBL3rF4styD5yV2cnxvm4odr55S/XTyE5CY2vQh+5yZEdB0Dm7ONc6sWH9YG7G42OtrIdZVDQnBNKvZDjzbejNtPoSiqhHMJqfHjIqXArTPVnb+yZv8unBEDMZe5VbEe7Mf2Og0QsYDf68K/gTVzYnCCElZUzGT7Y1MH+IuoE+iw58jO33HmjH1Q/EmPAUuZaIqnkk4CkFqSj/vIkfq9MDnABQN3pRC7n/WnBOUm2OtqAa0GAGWnzwPedGYlcEAhAUCVTfkRBXHPj8ABc3wf2TYnxX2Kia5TWQkJCA6Uf82Iy6mC1wG2vjbm/neKWheeBdsUpmoni7UwHEI/Nojo4lcbg1LRMwHkjLAFhHzUNZVUtJfg4FpC7iYxNTnm4a5ows/XDjwywvS+OniS7EdQxWOxHVzb7eQ5lk6Fx3yHksnpl4sU27J1FNAMgxypoY6tNO+W8UjXIMgnkbhUXYW3MZ4yyvE1yvBrqOZsmmEF6eSX3+Fi1Mrgk3ouiq0bXWIDfwntzohBJFZ8dNVkg5Y/Urkl87dWx1zGmhh5ZHE6ml33OIa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(31686004)(2616005)(107886003)(83380400001)(6512007)(316002)(5660300002)(4326008)(66556008)(66476007)(54906003)(6916009)(8676002)(38100700002)(7416002)(8936002)(6666004)(66946007)(2906002)(41300700001)(36756003)(478600001)(6506007)(53546011)(86362001)(6486002)(966005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm9WbWFTNVRzTVNRTlRtZW5sbndYUlVtUHNrdlpPbkRUNjk2bEV6VDVpM2h2?=
 =?utf-8?B?cGhlMDV3NnorQmdBcXFRY3MxRHNLZ013RXBkQmM3Skw1Mm1uYnNPbmMxemxJ?=
 =?utf-8?B?MkZJd250TjBNK2hzeTBaS2RYbTZxczlNK2tKTlZTN2ladGNoMnV0MzJJd1NK?=
 =?utf-8?B?Rjh4VHhhWFVEdXNwTFZLeFdjR25Pd05ueXZNNW5OQWR0UCtQcTJka3JrVjh6?=
 =?utf-8?B?RDZQSVBGWEMrZVFzTFZMZ3hKQmFaT1BuUFFzcTc3aWtXTTdiVUVlY1VLdll0?=
 =?utf-8?B?L1VSblR2SkVSQ1R0SGVXTjN6Uk9Ia0NZSEhSZnpQaVpOT3JyUWpwN2p1cGRJ?=
 =?utf-8?B?RXYzWXFtMUZKTEt0Q2VjUlVnOC9iSmZVNnUwVUpMVWpMMlRtYW96bzJDa283?=
 =?utf-8?B?Zm91MjRFUTFWUzhkOHdUcEIreXJaK2lQZWlGSUVzaEthT0RvSFliUi9PVkJP?=
 =?utf-8?B?UXhnU0txVlErTUlnZE1FR3E3T0d1U0pmUFBPTnVVK1YydU1RWldtVlF3U3Rs?=
 =?utf-8?B?UUtEaUI2eGVIMy9ZM3ZxWVE0SUl6NUk0WHRXQnBFYjBNaWJjeUZ1YkFsLzl2?=
 =?utf-8?B?aWs5c2hTbmxFdUl5MC9CVFNObTV4WGhYUStRRkJ6aEFQWU8wQmp4NHc3NE53?=
 =?utf-8?B?OEZZcWdOWkNrVE5icjdWRXJkOFIxQXQ1dVpBM0liemY1S3lNTy9RRzA0blF2?=
 =?utf-8?B?RjZ4ZU1KVWx5QTJZT1R0UTdTMjlWV0owekxDRzhZR0pjZURXQjFzeDRrNmxv?=
 =?utf-8?B?c0htZzgyaEZHM2IxaHhtc1BFazd4a2FUcFhuekk2N2thMk9BZHFUZXBSdUs4?=
 =?utf-8?B?OGdkeUZnSEJScC9tRmNVMHVKOUNjU1QwZ1FTRlFrUlJDZVovR0UvYUg5VlJ5?=
 =?utf-8?B?Ym5vUWtWaWdPd2ZHeUlFdWhaTStyRS9XUWZBSExZbXprZWN4MU1SQ1pNZWds?=
 =?utf-8?B?d3NjYlFsQ3JqNVJFM0ZVZlN1UkFlb0pQVTlybGloUm9kdmFpMksvWGdrcDU4?=
 =?utf-8?B?ZEZZaks1a1hSYzNNZ2FJMUh4d1o2VVF6S1I0WjV0YW5pdytubWdIeGNzV1VM?=
 =?utf-8?B?RUNIRnVZSURORXRzTU14UEgxZGI5azBGVXNRQnQyK25pcXlnbWtaOTJNY0g2?=
 =?utf-8?B?ajRuSUdIWDlpblUrT0REaGNiczB2amhTZHVlajhIT2h3blBSSVdMUFB1WWJ1?=
 =?utf-8?B?OHVMOHZHMCs5MysyWnkvQWQrZWthc0lnQ2UzWEI3ZEZrRFYvSTBpUENnbUE2?=
 =?utf-8?B?d1VHc040OE5CSHB3a1FGVTR5MW9qR2VYYU9mMFROcW5uMGdMdFVoYkJOM2Nl?=
 =?utf-8?B?ZE9LYS9Obk1pZzVyNzNuSm5DTFpkcFJIczVTa1crcUxRSGRnNXdlOGp0ODd5?=
 =?utf-8?B?QmxuWm53WHRCeDJJa0VsV0FnazR0ZXliUmhzN3pYWmV5S0tGT0VpbW5kUC9j?=
 =?utf-8?B?YkhDYXNVL1V3bFJodnU1QVUwZUpYWTluYzdiS1BhNGgvd3d0RjVvUjlIY3BH?=
 =?utf-8?B?ajB1dmJFQTR0RjY5WUZKbytWVzZMc2VwajVEVitNSnF4TkhRMnRqWlFlYVh0?=
 =?utf-8?B?bEkyU0hWZ2dkNE1tNTlQZWFJaVZoL3krbGpGWnZNdE8wVXA1eFdGLzB6aWx3?=
 =?utf-8?B?eFVSZ1hwMzR1OFBXM0R2MlJyblc5QVN2aHZMMkRBMEQ4QytNMFdsWTNUK2pn?=
 =?utf-8?B?bnVMNlZjakt2Z0pObk9RcE9KTHM2aVUwUU14NFduZlQxVytZTlJ1azZ3OTF6?=
 =?utf-8?B?ZHMxcFR6TlM4Umo0ODRlOHVCNjgzUVZKQW1Ia1diZ1NMMy9kZS92VE1nczlW?=
 =?utf-8?B?UVJ6bE1QNHl1cXRrUk9tQzQ1RHYvR1hJaG00VjFOZU8zejcwN285TWlDNzV6?=
 =?utf-8?B?b3dGLy8rcGd6RzVhVlcvNUtBWXJJU0dCT085M2R6cEdxdGpHUDBwM2JSRkRu?=
 =?utf-8?B?cXhvYkNEaVNLdE9Qa1lLTzhDN2lVQWh4d1ZRcTFtS2NNVWV6ZjdUMlN0cDE2?=
 =?utf-8?B?ZXQwZENyenFxcUVVc01YR0R6bnhyc2xpWkhSNXBtZmQ5amxabTVCYUtwQnV6?=
 =?utf-8?B?MXdwN2oxbDdpRU5lelFlNzE0S1lrRU51WktCQlRSem5UMnVJOTBWekM3RmFG?=
 =?utf-8?Q?h/zwjbMtmuFjbtJ45G2gDgM9I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8251f9a3-8978-4f3f-c6aa-08dbcb49cb72
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 17:36:41.2027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpAMR+EtXGPsD6xJRvTaIm8kAkTTNsAcnUHytbAB2feGgB/KjWDUVOf13jjJQZveolBaEycR1RJ5+9F1eAlXlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 1:20 AM, Bartosz Golaszewski wrote:
> On Thu, Oct 12, 2023 at 12:59 AM Dipen Patel <dipenp@nvidia.com> wrote:
>>
>> On 10/11/23 1:26 PM, Andy Shevchenko wrote:
>>> This is a series that provides a new API to GPIO library (so far only
>>> available in the GPIO tree), and respective update to the Tegra
>>> HTE driver. On top a couple of other cleaups (patches 3 & 4, they
>>> can be applied separately).
>>>
>>> Patch 2 inherited tags from its respective discussion thread [1].
>>>
>>> Due to dependencies this either should be applied to the GPIO tree,
>>> or to the HTE when GPIO updates land the upstream (optionally with
>>> the first patch be applied even now to the GPIO tree independently).
>>>
>>> Another option is to have an immutable branch or tag, but I assume
>>> that was discussed and rejected (?) in [1].
>>>
>>> In v2:
>>> - collected tags (Linus, Dipen)
>>> - fixed couple of typos (Dipen)
>>>
>>> Link: https://lore.kernel.org/linux-gpio/20230905185309.131295-15-brgl@bgdev.pl/ [1]
>>> Cc: Dipen Patel <dipenp@nvidia.com>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> Andy Shevchenko (3):
>>>   gpiolib: provide gpio_device_find_by_fwnode()
>>>   hte: tegra194: Remove redundant dev_err()
>>>   hte: tegra194: Switch to LATE_SIMPLE_DEV_PM_OPS()
>>>
>>> Bartosz Golaszewski (1):
>>>   hte: tegra194: don't access struct gpio_chip
>>>
>>>  drivers/gpio/gpiolib.c      | 20 ++++++++++++++++
>>>  drivers/hte/hte-tegra194.c  | 46 +++++++++++++++++++------------------
>>>  include/linux/gpio/driver.h |  1 +
>>>  3 files changed, 45 insertions(+), 22 deletions(-)
>>>
>> Looks great...I am going to assume you are going to push patches 1 and 2 through
>> gpio subsystem and rest through HTE, right?
>>
>> Reviewed-by: Dipen Patel <dipenp@nvidia.com>
>> Tested-by: Dipen Patel <dipenp@nvidia.com>
>>
> 
> Yes, let me queue them right away.
>
Thanks, I just pushed patches 3 and 4 to hte subsys tree. Thanks everyone for
the quick turnaround to resolve this issue.

> Bart

