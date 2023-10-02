Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0DF7B5832
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbjJBQ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjJBQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:27:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7B79E;
        Mon,  2 Oct 2023 09:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjbKYumRMU7xddxjtStBO49qnuv9Ze8VPbYAQXsd7KplYRtsTRD52oVUxy68YLG+4hfRdYFzmH4kQwAX6f3fJW/A0Ob2M7YHaB4cOrU42GmuifAU44bGbhLqN5jDUeJw6bPf7pmqDSPgznLAq4XGdoiRXLnrI4W4QONwg+Ki7I8hjWvICZ8OlmxE/IX+751pKjahMW5J/q3Yl3BCZgha3P9Q7zkkDvRkhBv+Ju7ghAifjJsWr0PtGZNHxFt0p69pB6T0YCvBVBsjZWaVXO9Y+/Nrvk/7+gFmlTMQD0hvGHNwerJmtZbAPHvG5FrlR3cboHIeNk8Wdzhsw70hDst4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFj6sbnIpIW9/ToS4JlrxEZ9yBDDwHdzjedB7U4MgVI=;
 b=YhoX1H0qXqv2pO92l6ZTTg7RFK/qRWhjQWVHxcjo7oL7EQ8myKsUBZmqt7BP48pAEhSg8MUlnVl2N59VMR9NPdiXlGfITsAN0VMwJ6i226K3bqiRix+POkw5FWRyRlDMw8LhH3ouYLH/PYdEEREwJ/mdjRMbTEtpE5S7nfXcNIq/W4+IwzGSwBKe5q+pEUrMrBRplyZ9QSyUclfH1zyiNd0qggk9Q6zF3SXHyDmnjXz0lBsN3Cfid3hbsms6bNNENZ5/o/po9QL/aivJuwIX+C3JJLRim0TO8NITK16bZ5JbxuZ1mE3P0IeaezB01E2SxtNCHyFkVbFeYvF+j3i/vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFj6sbnIpIW9/ToS4JlrxEZ9yBDDwHdzjedB7U4MgVI=;
 b=j+YPaA6AAMgBg953LdJmbjLEHvsE5pynaMFErzB9H0CIzAbJfyMLQzQvY1rw+giHDkP3Y4kiEsaW/sgUZ3QmYpDFaoUrcbXdxSMglirHh2U2sBsx+hXu5AjhwMGmlFw2KAhjAfPloZwoYozEJhaFNsYxgOF16jtbG81foMBe+Qzuv7JRzi6rUcvcNbTXeq+cT6qRAMxx0Y4fYVzXxR9GvubiniMVoPwU3uQ48CtZx7YCZzmWNPaOofhU87X3pRqluOv7XGzLQAT3rvWos5FQs/y3SWFLI/pyuISgZPNdt5Wn/llXO5Lmu6EK99TKgbusXgS5ZLx6S2wnV7MMyAAOXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by CH3PR12MB8849.namprd12.prod.outlook.com (2603:10b6:610:178::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 16:27:52 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 16:27:52 +0000
Message-ID: <7766de61-a046-3e17-1322-28bd7f1e61da@nvidia.com>
Date:   Mon, 2 Oct 2023 09:27:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] hte: tegra194: improve the GPIO-related comment
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        timestamp@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230911094443.14040-1-brgl@bgdev.pl>
 <cd4df23c-cc02-6723-e36d-34ca03409e6e@nvidia.com>
 <CAMRc=MeWXapho1bsX9Si5uSx7MWVhpT2cqrv5S+qPo51Ko=Vtg@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAMRc=MeWXapho1bsX9Si5uSx7MWVhpT2cqrv5S+qPo51Ko=Vtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::11) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|CH3PR12MB8849:EE_
X-MS-Office365-Filtering-Correlation-Id: 592b9bbf-8abd-4a95-cead-08dbc3648633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RToTwQtXCubXVC5Jlc7OADJuyokyUoptcKEEckrO6FR+A4ltn4gPjg3nVba4aXBiYehAvfSwYiz/b0op9C34KG5atHnuO+Hm+NYG803DRbNpAqWtXztB4Wxx+X+2BAE4HGQACDTMyAOUxw4J78h0uH/DC2Lig8LTWM/TfEMtgoWRwmlYBy8q4sF3r1H4pQbgqeAuDAMMXUwXfeNnggQHh0Tez9xeTyBHTxZU/RWOafvKYOvqUe365kg5ghg++BCa193CUQsuLs5Ltcsu585IL1IFLhjvlrN9LITy23/Oo6WrugHFkgp06e/rcZDRG8k4HB3EdKgc7wGG5JkSMEjygka22VEfo8+lrtNRQJTlYlWiuvdDn9qWsAcTedB5hGvlEgJBFNJXOSEPD0OA8OdC9ntBSUmWrArKnBwwvn0wch3g4J9xPHVdsBk9Q+rTVzZKhJRUVDZ0RvSy0OamQwCddagO1eZ5Lilht0Nqyheswi/rjaK3aI3i9/GsIYSpx4jNJnSmkqSNbvYJ8jiZKe5+wMoQGoaBFasDpDS1d3Rjn9OoLFH8AckLeTo9fs5JXQLyY5zy1XmoQRLrFwUO/i1+N9wTZMuHiFyhBn5at5abrwCjMhIByrf1QBkV/4KLhxL2cqBIv1V0GT2bwV8EJh52d/atPRCk1ToYQG+xO5Ch3z+B4VY207dqtzmngUOyjpuW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(136003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(31686004)(66899024)(53546011)(6506007)(6512007)(2906002)(316002)(36756003)(4326008)(5660300002)(8676002)(8936002)(41300700001)(31696002)(66556008)(86362001)(478600001)(66946007)(6916009)(38100700002)(66476007)(6666004)(54906003)(26005)(6486002)(966005)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE5TaTRkR2lLZjdFRkp2RHNzeTRrMFRLRnViSFNLcEgzMnRKdXNvSTJGUTRy?=
 =?utf-8?B?RytnT2tPKzZGSTNUd2JHaTNLdVJubG1KaXhSajNxYjJNbmVJcllTa2ZJRzh6?=
 =?utf-8?B?b2lHMG5ENkVuL3VNQzkrZGNCNXUvL0JwdVEyUFF4ck9UbUkwaEhHUlJJZHQ4?=
 =?utf-8?B?eCtGTk5acVd5N05yTWMvcWkxdnhPVW1KbWVibW5TdTVud0dpMnVQOXNTWFU1?=
 =?utf-8?B?RStteE9WRWNWRy8wWGJXaGpUUFEzMG0vcTlWZmtIMEREdUVoNjQwZ2NCZHdi?=
 =?utf-8?B?US91bDJmMFJBT1VmTWNadGhsWFB5dVZ3SS82Y1hEYS9hazdvR0lPT01Eb29W?=
 =?utf-8?B?TCtlSldhVnVuc3laZU5yOTV5VGIyRWZxSnZFTXIrRUMyM0VXbHVlcEt5Ukdp?=
 =?utf-8?B?ekxYY3dkQWxOazFzWVpzS3BKWGFoUXREY3VNVUZUcTVNZDZRSlYvOENZUk5T?=
 =?utf-8?B?by9Nc3dOaGMwVEticEVLVE51U2hoWUt1REVOd080NmZoQ1prc1VXai9XVWRm?=
 =?utf-8?B?RGVkN0w3OFNqYzFGb1VHd013UVNWL3RPNWtvRWZhczh6NHhXemNuVC81NExj?=
 =?utf-8?B?Y3dTV3dqRkRUMjdncmtYUlJvUU5odVNZTk5PcG5MTGcydHJBRnBGbTlkTXhk?=
 =?utf-8?B?eldYNEY3dTVocSs5VjBqems5UGVHNmw3eW0zd29ncFFIUWtkbVJnbmozRzJp?=
 =?utf-8?B?Zjk4S1FMV3pYOHlKaThMSStXZDkxT0JiSUxocUVUZk14SjhBT092Z21sZjA1?=
 =?utf-8?B?YlR2Rkwra3BxQVYzLytGTmNXZGg3c1N6RHhsdlVYWmRXS3lraWY5cnorNnhj?=
 =?utf-8?B?blpSbkZIdm5mL216aWd6VDAzMXk5VndFenE4aG5tSERGRm9CS0VSQ1I2SXdH?=
 =?utf-8?B?VkIwN0c5RFpvMTJiRkMwSXFpdkRNMklzd015cEJhMWNZU1I0NzRpNy9YOVhS?=
 =?utf-8?B?eDcyNWF2V09oY2hOdkFnUVB6NGpvV1pLYTBkekR6M1BLNkNld01OY2hzN2hK?=
 =?utf-8?B?SVJTTjFmaE1CWGJySjR4OUJWMlNRYUNVRmwrVDk5ZGM2SXc1dXFLQmFjekIv?=
 =?utf-8?B?M2UzdVRQS08yeS96YjU3SUhvRUsrRFU3S21GNmFqeGRyQ1FBMjkyTnFrZTRa?=
 =?utf-8?B?QkY5WFMyS2hWWnU2WFlZcDFXa0V6TDkvMTNhVHl6bDNWQmtOWnZvZEU4R1BX?=
 =?utf-8?B?dHljbmZxZk1MZW1OQjlVRWFPR0FuL2wyenVxMVJTdUZ6N25vRk81NjB2TnVu?=
 =?utf-8?B?U1NOQlJBYUM4WFNlNHlVU3M2UGlvM2FRV3VFUWp5a2hqeWxpQ3VUNitVb2dN?=
 =?utf-8?B?UE93WXIzMlVlODRsS2xmUjI5TEFtL0hPdGJ2MElVQmNBQ1lmeThnRmVSdENZ?=
 =?utf-8?B?VkJxYnY2dHNFQ0J2Vnp0TG9PaWY3RTRYaTZhZ1cwaEJHcW1kKy85YWhJRkVs?=
 =?utf-8?B?YXVKanBGZmc0ZmhxbXpuRDhwWnV3cERFUDRnVzlBeVRMaTFVL0hqNm0rK2NL?=
 =?utf-8?B?dW9YVDBjcnhFOUZZVlZFemY5MjViVVFEc3MwOGZsL2RYY1JPVE03Z2tWdU8v?=
 =?utf-8?B?VStDcWtWalZiTmtCU3dML2VHdEZ2cEx5UUFJTEJ1cVplZDQ0djFhcGs5czFE?=
 =?utf-8?B?N3FhMVRmUVI4bGdzMEp5eFJDUEUvWHQvWlZTQy9WQ1dYOXZVMDFzRkxYdzMx?=
 =?utf-8?B?emluQ3dFUEFGeVJiajV4Uk9BVnc3eTZPUGpVdGNSL0F6c0xDNFJTbFliR0VI?=
 =?utf-8?B?SkJIbUlHRGN6T0xzVDZPUlJDY1ZBbXRUM1IzSzlPY3hSelJ5cGdKSkNWYU43?=
 =?utf-8?B?RFpGQ2tsRTJqYWdaTllEVW00WkRkZng2UUdZMVZjckNwVDRGeUcyU2Z2bmQ5?=
 =?utf-8?B?dXUrNVhXWDZYb2h5SzV6N1lHYThVU21SRzRSR0FDV3hDVEhrUDMwaStOWDU5?=
 =?utf-8?B?TkN4eWRaWnhtYmNGTEhuazV6d1YvM1l2SXB1L1lvK2xJK2UwQUVER244R2F4?=
 =?utf-8?B?MFF3aXcrRlZUVGpTbU9KSVZrZFdER0FmWkpSSm1YRmo4c1VIWGk0dmt4RkN4?=
 =?utf-8?B?S3hHR1h0V2p6QXVPWTJUTEVHV0JRQWZzdm5FazMwakU3S0d3dGR2YUowMVpx?=
 =?utf-8?Q?3whp2ZNGWvv8iO+R5jipEkjvI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592b9bbf-8abd-4a95-cead-08dbc3648633
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 16:27:52.0591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtLOf16/uocRgjcoygJxpcCPKqLRK1yijtUS1RvxO7PxtNDkqUSHyTgAQapLFbK2VIWaYzCNj6/OV/Lh0zcLBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8849
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/23 1:33 AM, Bartosz Golaszewski wrote:
> On Fri, Sep 29, 2023 at 11:38 PM Dipen Patel <dipenp@nvidia.com> wrote:
>>
>> On 9/11/23 2:44 AM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Using any of the GPIO interfaces using the global numberspace is
>>> deprecated. Make it clear in the comment.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>> This was part of a wider series but since this is independent, I'm sending
>>> it separately.
>>>
>>>  drivers/hte/hte-tegra194.c | 13 ++++++++-----
>>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
>>> index 6fe6897047ac..9fd3c00ff695 100644
>>> --- a/drivers/hte/hte-tegra194.c
>>> +++ b/drivers/hte/hte-tegra194.c
>>> @@ -407,12 +407,15 @@ static int tegra_hte_line_xlate(struct hte_chip *gc,
>>>               return -EINVAL;
>>>
>>>       /*
>>> +      * GPIO consumers can access GPIOs in two ways:
>>>        *
>>> -      * There are two paths GPIO consumers can take as follows:
>>> -      * 1) The consumer (gpiolib-cdev for example) which uses GPIO global
>>> -      * number which gets assigned run time.
>>> -      * 2) The consumer passing GPIO from the DT which is assigned
>>> -      * statically for example by using TEGRA194_AON_GPIO gpio DT binding.
>>> +      * 1) Using the global GPIO numberspace.
>>> +      *
>>> +      * This is the old, now DEPRECATED method and should not be used in
>>> +      * new code. TODO: Check if tegra is even concerned by this.
>> This use case is to do namespace mapping from gpio subsystem to hte. Few doubts:
>> 1. What does deprecate mean here? Does gpio subsys not use global space anymore?
> 
> It does but we don't want to expose this to external users in any way
> anymore (and haven't to for years). This is what deprecated means.
> Users should deal with opaque GPIO descriptors not global GPIO
> numberspace.
> 
>> 2. If yes, what GPIO number is set when it comes from gpiolib-cdev, as based on that I may have to
>> reflect in the mapping, tegra194_aon_gpio_map for example.
> 
> Why DO you have to use a GPIO number though? If HTE needs just a
> number from some HTE numberspace (which in itself may be unnecessary)
> then why not just keep a local IDA for it? Do you have to know the
> GPIOs internal numbering scheme to make it work?

humm, overall, I just need to know which GPIO it is, for example, GPIO controller X Port A GPIO number 3
to do proper mapping.
Continuing from above example, the hte driver gets:
- GPIO Controller X from DT node
- the rest details in current code gets it from [1] and [2]

If there is alternate method exists, I would like to explore. I think IDA will not help in this case as ID assigned
does not hold meaning in this context.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib-cdev.c?h=v6.6-rc3#n760
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hte/hte-tegra194.c?h=v6.6-rc3#n421

> 
> Bart
> 
>>> +      *
>>> +      * 2) Using GPIO descriptors that can be assigned to consumer devices
>>> +      * using device-tree, ACPI or lookup tables.
>>>        *
>>>        * The code below addresses both the consumer use cases and maps into
>>>        * HTE/GTE namespace.
>>

