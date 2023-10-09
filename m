Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6A7BE67C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377246AbjJIQem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376275AbjJIQek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:34:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D738299;
        Mon,  9 Oct 2023 09:34:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmCF8QDQzswu5YtNVx82l203xZWy/y0eb4N1p8l/7G6oEwRRkIsw7ZGkTt1EKS6mk1qUPABTTD3vaIBsd4Iepjc6yNf9N7v2L4I+XMffc+8b94PSns2+lshwfb6fdQGAtH62Ls20RH7TE/EYkL5/CEI/EBbMuSu3Sb6l8a38yKsxxTiJGxFB5yzJdaxvCSIFInNbetyW0uuX0251UVFwFGF4H8VUkYhuxAqDqOjX/EuL916jKFK9gCsHYjQR82/ZElbhUSM1HG8Q4JBHnaqwB6FJQQU1ngAqOzZJzgr8pG33j/lEMoeY4qCTSI9LF+gY/oJCAt4wVt3HWt4MbQYWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3fqncxQ8Q7mOz0eDPZDV3DpInYKsAbgegNxirhMGe0=;
 b=P2ksezEj2KOyd+3W1bqo4+rqqh/v9ve56w0Vxar+03IeN9FyB+C8PitK05VgxHBia/jL/RgzGhf1CEtTDwvlZIf0DImc9D8JQR38avur0zYsTwtpo/fFeuvuw2Vk/tVIPTKd9UswSILke8XsIxo0geh7WObT3oyZppMZhlNJrzMcHlMxHufidxlsdaM170maEQDWREntdiNLgd/eOgHMsJlfJigae5NQ+1jYhBimXaRiPfdKG8p/mDkKMqjitVCWfniHv2RwwUqK933BWOPKrixnAgEAbBZSyAhTyA7Kbt2GgwGfN4RYOSh1SOwFy5K+bYIgMn4ynkPzdhnMDs1u7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3fqncxQ8Q7mOz0eDPZDV3DpInYKsAbgegNxirhMGe0=;
 b=VMkT+5Gv8ZaxU/J0f5t5ZZ/DOHebtyYUWMqRQqfsDP8Go473pOqMQhDN0bGnMhol4iydj5n/AeAgn8B8IeVZlk5PDYDnCXbDMYgdfnYiZRnFUUNFHxTrQfi50Kzaya6iBnXFHQu18EX7zs4Fh9dWk+hg3Q9bcGrLYFpHARrEE9K3AwZRpNVLYRlNIN0ZsqrrUvD4+a9eCtGCXsQTJparwn5q3MMkwUemd9RZD9c9cVVaiZP3PkcrnelAQTpvghpD7wfj/ybibhifKISj+9hDf0WXjZTlSjy8U9UaJodFd4S5p1iuszDGOvCEA5pIBpsWgMBUWVNaXmgPM9sj6T6kgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by BL0PR12MB4993.namprd12.prod.outlook.com (2603:10b6:208:17e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 16:34:36 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 16:34:36 +0000
Message-ID: <3a54df71-d5cc-f538-75b8-f2193e27d65b@nvidia.com>
Date:   Mon, 9 Oct 2023 09:34:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFT PATCH 14/21] hte: tegra194: don't access struct gpio_chip
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230905185309.131295-1-brgl@bgdev.pl>
 <20230905185309.131295-15-brgl@bgdev.pl>
 <CACRpkda9=VULj4Cy_sit-UpUQnVEbS-RJKAeULVCw8ZCRTq1sw@mail.gmail.com>
 <CAMRc=MdTk1B4MEh9C624Upm_EcaQgJd9OU-AGfU0G-DU1+qk6A@mail.gmail.com>
 <36b17290-c643-8d8e-e82b-49afa6b34fbb@nvidia.com>
 <3624e973-d09a-d211-c6d0-d0ffb8c20c4b@nvidia.com>
 <90b5f887-8af4-a80d-ea4d-cf2199752de4@nvidia.com>
 <0e7cae42-0b81-c038-8beb-49102feea8a6@nvidia.com>
 <CAMRc=McSG6qajxt6P3vWQEeT63Pk5tggD05pUoMD1zd5ApZxgA@mail.gmail.com>
 <647d3b52-1daf-175d-d5c2-45653dd2604c@nvidia.com>
 <CAMRc=Mc_+LxcbV+=KPwAh4DinJAAetHrK+W3jbNp4AZBzg63TA@mail.gmail.com>
 <b0f37601-39d6-618e-fa16-3b1c9e7c0e2c@nvidia.com>
 <CAMRc=MfSGY691-sFhx8GeP43g0xGk1JzNa=9q5oemQoHHAM-5Q@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAMRc=MfSGY691-sFhx8GeP43g0xGk1JzNa=9q5oemQoHHAM-5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0142.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::27) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|BL0PR12MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: e7061cd3-2ef6-4a7c-c3ab-08dbc8e5a05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEmGPDBNCCULMNglZRhE5TB2Hn734bxBHrxnlV6UOKQ+nRKYkZEpRU2xe0E+GDEkyb8N3eUZ/++5ugoBk+fYNV4IANjcuohy36BUEm7CmRXezsiS9YVbI2saAqIgAIfroQLPs1Cv9A0RZ3WIxnB7GGcaXE1ID5YrgcNtCnc0QbpI1iOvLiUnhLFP+vx9DkrLN8DqIX+IdzrMOkeJi2HH2SwxYjRSC0sswG50QXC54k54uOCrCDaejHYoSOW38xpmhgR+urYEf1zM3+t6F+dt/4ZJAVUCXMJejEMMvSgSk28dHTE4mkP1bz/sJlnQlrEunxWhUt9kZ+Tw7GFcn9pGuF+cHtMKWyZRkqct1eaBisHnJ7FELAbsOVhc3vQg9vZF6cJUhBlWIuv054tqZDxy8gqSLchSOiOiCsZtipfL0Z5XUG7ixtnx+j7qDCv8RD5crOGR17PRpBsRy5vjLMsDXy/zAAZYWXQFpHDlXTtNqfJZgt3YD/ghEq3q6f5rMn2aTuwwgvIkIpcYm6iJEBMzDNatFSYt4MaAMTfeQlH6Nodu3i6nNbfZvxZ6pzuRVsOKEPfFPDx/npfPflPIHX+kOCUPzRNfq0uEdjM78YxtIEjiu7F/NGrE08MYf1U7+1NXnodAEYm956wd4yFZ2pUMpV7hUmQT+FqpwT5sTrrFkBUCMvNH/baPGSQ0gS1HPi1t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(31686004)(26005)(2616005)(53546011)(86362001)(31696002)(36756003)(38100700002)(83380400001)(8676002)(7416002)(8936002)(6506007)(2906002)(4326008)(478600001)(6512007)(6666004)(5660300002)(41300700001)(6486002)(316002)(966005)(6916009)(66476007)(66556008)(54906003)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjJCR0x2V2FBanBvL3BmelB5V0dabHB2UXBRWXdtSW9vQnM0L0RLYVlFVjB6?=
 =?utf-8?B?MjJDVlEzcEtRZ0pJUlpObStHWThDcHRRTk01Wms3RVJ5Mlg2T2ZmVm51NVRC?=
 =?utf-8?B?LzNzRnErSm1qZGFWK0JPdDBFVXpuL3JIOHEvc3pKT0xWTDh3Q2dHUmsreTIv?=
 =?utf-8?B?UTBHTUQwYVlqalhZN01ub20rbFF4U0wxUlJwVmEzbjdWNWVpTDV1MG5mSk5H?=
 =?utf-8?B?THRncnVjTW92cWcxQW1xbjhPMW9mekJicmN3ZFZNeGd2S1I0bnAxTXRiZHpt?=
 =?utf-8?B?SjB5UDVuZmw5UXUxc1Qya3ZvMHg2WkY4bE5sWGljdTZ6eEtRZ0RhdXZZTDVD?=
 =?utf-8?B?ZmcyQ0E1ODlxZzBWWkQ5KytBcG9jYVNURThzSWhDTmhCdXY2eUtNRHF5Szd3?=
 =?utf-8?B?VStyUTFFS0IxaFFxdWFsdW9vcHJEdThoRFVmaHJvbTFNWFFoaktQR01iTEhP?=
 =?utf-8?B?ZHZXUnM3NWU4Q2JmUkJYMHduWHhhQ01wUENEWUE0T1hWZ1NZd0xJQUEreG1i?=
 =?utf-8?B?eHordmZMa0wrYXdEUTA3YXVNYkgydC9JQ05kblFKbzB3VjRyNG1oMjZ4YnRv?=
 =?utf-8?B?eFpmRnpyeGUyVVZZRm1EbFI2U29JbXRyaTc2MHJJRzlBYkw0QVgzMUQ5U1FZ?=
 =?utf-8?B?bHBteVFKL0xIbWhyaHVvSGxrZXEwbUJKMjMzbkc1MWs5RUppY0FEeHdxd2JP?=
 =?utf-8?B?NERmY0lscGc0MXNWVzh0Q1ZPNXcza1U4eTkzdkhTUG9md3JKa2pUNDQxOVFG?=
 =?utf-8?B?VVJNOXk3dTY4SExhYTNmckhFaWd3c1oyMXIzZVYvdkxnVk9aVnFmKzdrS1hM?=
 =?utf-8?B?ejNmRWNzaVg5RzVCZDNydDEzbkU2YlFpY0p0WWN1NkM0WTNzM3BCWm92czlN?=
 =?utf-8?B?TGVyTHRvY0RWN2ptY2FiYW56ODdMY1ZuRnByMFVYYnNtK2REWHpVSU4xSXp4?=
 =?utf-8?B?bVI0QXlTdHdSanFFcFFXOFRXVjNaS2owRVRnTXl3aEZwWUpLajNkOUZHcVFE?=
 =?utf-8?B?Q0RHbklmQ2NkeDM0VEp2Sk5xWUlLWm9FcmdaQ2tzQUwwTUZzREhyVTQ3SEFO?=
 =?utf-8?B?R296UzJoOXBPQXpMTCtiY0Mzdm96SURHQXlGVm91TDNhZ0JIcVRJRURFc2dE?=
 =?utf-8?B?bzBYcExYd1lJNjh0emQzbkJmOHg2enhXY2ltSy9XN3BxT2dQTW9zNFFpWnRK?=
 =?utf-8?B?UnB0K1RzSDNJaU1DRlJ5WURrQUx0WGk2Q1MxMVdoNStsSUlvd01MY2pVZTh3?=
 =?utf-8?B?bnVxUCtCOXI5OHcxMVk0c05KeFFoem1rU1BKa0huNFFuOVR2b1lCa1JqVFVM?=
 =?utf-8?B?N3VXSk9KNmN4aUpCaHZDbmtONGo2cXVZdVJ3L3BPOU9IMjJiRFlNdnFLLytZ?=
 =?utf-8?B?KzBHQmlkUEJtd3ZrZlZWWFdGVVIzK1lqRS83V1E3KzVqN1o0b3dHcTlzY1p3?=
 =?utf-8?B?Q3JGOC9VR3VQODFrUDFNUWxrd0h3Z3RCSzVSNVVwSW8vYlBaZGcwQjJCN3RZ?=
 =?utf-8?B?UWpIRERSUk42UGlnZkJkbE95OSsyN0E2Z0k5cnErR2p4SHEweUEwR3Y4dkdR?=
 =?utf-8?B?T3djOVBCMUw4TTdxdXhaZVpybDlEZkp3bHVkME1hcU43OFk2RUloaVh5T1ow?=
 =?utf-8?B?S0gwQkNtbS80VUV0b1lGNVF1UTVDNFNpN0hEQlBFVnVkNGhjM1EyeWc2MUNU?=
 =?utf-8?B?MUZOSGl2cnZVWGRvQVR6aDc3SjZZYUJQU25OTzNXRERHbUlCYXR0bmNUVkkx?=
 =?utf-8?B?VzJzMlMzNHUrWmU5d3B6VEpKd2tCeGZjNDN1b1lSaFhTZ0hsc0oyNzhoRVNI?=
 =?utf-8?B?a3lrSHoyWEFRT2ZvR2RVZjN5UGs5RHNBYVlDM2tGWCtFUWg5WmkvZEJqaDMv?=
 =?utf-8?B?Zzh5aFpUNUhpQklCOFQ2RVZ6ejB1Tmx6MDhKRjgzMnBybHdsWXRUODJZNEYr?=
 =?utf-8?B?Uk12bWtmV1BTdXBodkVlaXNKU2Z5eG5TbE45NDdLMDVtMzEwK2t6WnlpYkcz?=
 =?utf-8?B?VW9ZRU5oRCs4Tkg1UU82TzlqbWZzVmhlZHVqeURTMzBGVysyaGZhTTgvR2Vv?=
 =?utf-8?B?aTkyRVZoa0pxRmFENHlKUlFyd28rak56K0k5cC9iVzgrNzFmYkd0TWlGZHJS?=
 =?utf-8?Q?9oS3RslhHI2tJh/QX3ZgNE63f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7061cd3-2ef6-4a7c-c3ab-08dbc8e5a05e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 16:34:36.8206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0omvlxKCew17giFiSAwzme8V0R6xWbFaGwcNF+pwcmXWBA+pMScqh2Q1X5LOJWjCTqnuG8qlaEao369MXJ9ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4993
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/23 11:48 PM, Bartosz Golaszewski wrote:
> On Thu, Oct 5, 2023 at 9:43 PM Dipen Patel <dipenp@nvidia.com> wrote:
>>
>> On 10/5/23 12:05 PM, Bartosz Golaszewski wrote:
>>> On Thu, Oct 5, 2023 at 8:12 PM Dipen Patel <dipenp@nvidia.com> wrote:
>>>>
>>>> On 10/5/23 6:48 AM, Bartosz Golaszewski wrote:
>>>>> On Thu, Oct 5, 2023 at 1:52 AM Dipen Patel <dipenp@nvidia.com> wrote:
>>>>>>
>>>>>> On 10/4/23 3:54 PM, Dipen Patel wrote:
>>>>>>> On 10/4/23 1:33 PM, Dipen Patel wrote:
>>>>>>>> On 10/4/23 1:30 PM, Dipen Patel wrote:
>>>>>>>>> On 10/4/23 5:00 AM, Bartosz Golaszewski wrote:
>>>>>>>>>> On Thu, Sep 7, 2023 at 9:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Tue, Sep 5, 2023 at 8:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>>>>>>>
>>>>>>>>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>>>>>>>
>>>>>>>>>>>> Using struct gpio_chip is not safe as it will disappear if the
>>>>>>>>>>>> underlying driver is unbound for any reason. Switch to using reference
>>>>>>>>>>>> counted struct gpio_device and its dedicated accessors.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>>>>>>
>>>>>>>>>>> As Andy points out add <linux/cleanup.h>, with that fixed:
>>>>>>>>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>>>>>>>>>
>>>>>>>>>>> I think this can be merged into the gpio tree after leaving some
>>>>>>>>>>> slack for the HTE maintainer to look at it, things look so much
>>>>>>>>>>> better after this.
>>>>>>>>>>>
>>>>>>>>>>> Yours,
>>>>>>>>>>> Linus Walleij
>>>>>>>>>>
>>>>>>>>>> Dipen,
>>>>>>>>>>
>>>>>>>>>> if you could give this patch a test and possibly ack it for me to take
>>>>>>>>>> it through the GPIO tree (or go the immutable tag from HTE route) then
>>>>>>>>>> it would be great. This is the last user of gpiochip_find() treewide,
>>>>>>>>>> so with it we could remove it entirely for v6.7.
>>>>>>>>>
>>>>>>>>> Progress so far for the RFT...
>>>>>>>>>
>>>>>>>>> I tried applying the patch series on 6.6-rc1 and it did not apply cleanly,
>>>>>>>>> some patches I needed to manually apply and correct. With all this, it failed
>>>>>>>>> compilation at some spi/spi-bcm2835 driver. I disabled that and was able to
>>>>>>>>> compile. I thought I should let you know this part.
>>>>>>>>>
>>>>>>>>> Now, I tried to test the hte and it seems to fail finding the gpio device,
>>>>>>>>> roughly around this place [1]. I thought it would be your patch series so
>>>>>>>>> tried to just use 6.6rc1 without your patches and it still failed at the
>>>>>>>>> same place. I have to trace back now from which kernel version it broke.
>>>>>>>>
>>>>>>>> [1].
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git/tree/drivers/hte/hte-tegra194.c?h=for-next#n781
>>>>>>>>
>>>>>>>> of course with your patches it would fail for the gdev instead of the chip.
>>>>>>>
>>>>>>> Small update:
>>>>>>>
>>>>>>> I put some debugging prints in the gpio match function in the hte-tegra194.c as
>>>>>>> below:
>>>>>>>
>>>>>>> static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
>>>>>>>  {
>>>>>>> +       struct device_node *node = data;
>>>>>>> +       struct fwnode_handle *fw = of_node_to_fwnode(data);
>>>>>>> +       if (!fw || !chip->fwnode)
>>>>>>> +               pr_err("dipen patel: fw is null\n");
>>>>>>>
>>>>>>> -       pr_err("%s:%d\n", __func__, __LINE__);
>>>>>>> +       pr_err("dipen patel, %s:%d: %s, %s, %s, match?:%d, fwnode name:%s\n",
>>>>>>> __func__, __LINE__, chip->label, node->name, node->full_name, (chip->fwnode ==
>>>>>>> fw), fw->dev->init_name);
>>>>>>>         return chip->fwnode == of_node_to_fwnode(data);
>>>>>>>  }
>>>>>>>
>>>>>>> The output of the printfs looks like below:
>>>>>>> [    3.955194] dipen patel: fw is null -----> this message started appearing
>>>>>>> when I added !chip->fwnode test in the if condition line.
>>>>>>>
>>>>>>> [    3.958864] dipen patel, tegra_gpiochip_match:689: tegra234-gpio, gpio,
>>>>>>> gpio@c2f0000, match?:0, fwnode name:(null)
>>>>>>>
>>>>>>> I conclude that chip->fwnode is empty. Any idea in which conditions that node
>>>>>>> would be empty?
>>>>>>
>>>>>> sorry for spamming, one last message before I sign off for the day....
>>>>>>
>>>>>> Seems, adding below in the tegra gpio driver resolved the issue I am facing, I
>>>>>> was able to verify your patch series.
>>>>>>
>>>>>> diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
>>>>>> index d87dd06db40d..a56c159d7136 100644
>>>>>> --- a/drivers/gpio/gpio-tegra186.c
>>>>>> +++ b/drivers/gpio/gpio-tegra186.c
>>>>>> @@ -989,6 +989,8 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
>>>>>>                 offset += port->pins;
>>>>>>         }
>>>>>>
>>>>>> +       gpio->gpio.fwnode = of_node_to_fwnode(pdev->dev.of_node);
>>>>>> +
>>>>>>         return devm_gpiochip_add_data(&pdev->dev, &gpio->gpio, gpio);
>>>>>>  }
>>>>>>
>>>>>> Now, few follow up questions:
>>>>>> 1) is this the correct way of setting the chip fwnode in the gpio driver?
>>>>>
>>>>> You shouldn't need this. This driver already does:
>>>>>
>>>>>     gpio->gpio.parent = &pdev->dev;
>>>>>
>>>>> so fwnode should be assigned in gpiochip_add_data_with_key(). Can you
>>>>> check why this doesn't happen?
>>>>
>>>> I do not see anywhere chip->fwnode being set in the gpiochip_add_* function.
>>>> The only reference I see is here [1]. Does it mean I need to change my match
>>>> function from:
>>>>
>>>> chip->fwnode == of_node_to_fwnode(data)
>>>>
>>>> to:
>>>> dev_fwnode(chip->parent) == of_node_to_fwnode(data)?
>>>
>>> No! chip->fwnode is only used to let GPIOLIB know which fwnode to
>>> assign to the GPIO device (struct gpio_device).
>> What do you suggest I should use for the match as I do not see chip->fwnode
>> being set?
>>
> 
> This is most likely going to be a longer discussion. I suggest that in
> the meantime you just assign the gc->fwnode pointer explicitly from
> the platform device in the tegra GPIO driver and use it in the lookup
> function. Note that this is NOT wrong or a hack. It's just that most
> devices don't need to be looked up using gpio_device_find().

Sure, at the same time, I am also find to use any other method/s.
> 
> Bart
> 
>>>
>>> Bart
>>>
>>>>
>>>> [1]:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib.c?h=v6.6-rc1#n767
>>>>
>>>>>
>>>>> Bart
>>>>>
>>>>>> 2) Or should I use something else in hte matching function instead of fwnode so
>>>>>> to avoid adding above line in the gpio driver?
>>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Bart
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>

