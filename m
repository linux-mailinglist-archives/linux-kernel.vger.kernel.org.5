Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1297B240C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjI1Rgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjI1Rgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:36:44 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BB61AB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izYoyhc78889ju6G9vUz/P1aH/35qeajllDZ7iWLipScTrPn9ujlCBtM+YCYMpDsvMf6ynV2PCMa143H+0Y3SjPAvPZfvDtjksAmfhSd4hjN7EO1FXbArxPOAYAProS/3DKuc+jZu/ty3O+5N2Wg0zailw4AeS6x+mbMBpM9Xg2nG9zQKCjJcuiiTAbaEo6wXEXLl2kJy9e9ozC2Y2JFK7Ecv6UVzU8vp0VOzI3xk3zjMA1wDRrP3vpk1h8t372wHc4CCtqM5oTLkANlSwhIokJzvnTa1N8zjt1isqojPSqxN4D3bSbcE/mM62yJh33woDKq0zPr0bZA5rcuE7pVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8oYGb7MktQWAz5u82RKZailtLvZN4S9+5rvsejGlMs=;
 b=ZcNSs3HnhW5RQmumcHys4yEM0VtLv2/xYMLpXrMCEsgMIIJW++4k4c+FEHvZ/E8UwwrhDmvlC2F1xX3kYWqJ1pfgmZIDH/MgItJYhX/bC6/ysP+UxnTSP7mGVesU3uRtdyPRxOBFDs4Ha70vFywWg8dzybNDWVLYgh3UH4sY4diTXwx0qV2jrqX3Q6K/RQIdWaJdNBm7OW4yHyU+BI6ymiu4vUkyQgRo9ooPn1RDNpYMZ7Q5WSLmrO7mUZjO7ixVkqbh1a4ngqRUwAENccbJwCtnNasBWIevn2+Q59DrhI0Th0pMMk/LfVO3nYznXfvG7JzGsVWGbyxQgVdplFUToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8oYGb7MktQWAz5u82RKZailtLvZN4S9+5rvsejGlMs=;
 b=nd9anJeKOg3iWg9qVhimzvtxCXLwA7+brTrFUB9jFImTq3L8CQSPdMLAHyslv8mtI3/RPAQjLO4xfSrQ4zxV3BDowZxwz9UtZlNEvZ30Z1StYz1US0i3FNbhjmLHRyrl0vnVV/ASYku85xWWn65embjlRb9xaIsnv66V872yqMfHtxihbpRBGC0ktZ0Q75tSVW9SdZ2Ii/Zpm6Y1xuuIk+vkQgc3KqAiFFeT86QM8srBTOt1Y/ZvoS/Zn5OTNVpwV39Q3yMerXoBIVabc64IyuoH7JTxt/K4WkmoQc3QW5h90L27pTcGOiSP7n3eIWjSIbhDZAIazOEcxlUj4aNbwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) by
 CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Thu, 28 Sep 2023 17:36:40 +0000
Received: from DS0PR12MB6607.namprd12.prod.outlook.com
 ([fe80::3ce8:e189:f31c:454]) by DS0PR12MB6607.namprd12.prod.outlook.com
 ([fe80::3ce8:e189:f31c:454%3]) with mapi id 15.20.6792.021; Thu, 28 Sep 2023
 17:36:40 +0000
Message-ID: <2fd6d2a4-d8a4-f763-2f31-00709c7d3603@nvidia.com>
Date:   Thu, 28 Sep 2023 10:36:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] hte: allow building modules with COMPILE_TEST enabled
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     timestamp@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230911094604.14179-1-brgl@bgdev.pl>
 <CAMRc=Mc2Yo61uivOWHagR2Raxh11dBb=S6jtCDu8_-csX3ozvw@mail.gmail.com>
 <04e28f8a-1393-d991-264c-b0592746c123@nvidia.com>
 <CAMRc=MfMdMJXS1Yh_T-Ke+0U3ZC-oZhb2hJqb_g1wgO2s+7JAQ@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAMRc=MfMdMJXS1Yh_T-Ke+0U3ZC-oZhb2hJqb_g1wgO2s+7JAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To DS0PR12MB6607.namprd12.prod.outlook.com
 (2603:10b6:8:d1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6607:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 427497e0-2d8a-47da-e3fe-08dbc0497946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M31pQiaaXgiGT4SSg9AzR/TN7Ji5yspE4OK14HJBuCrLrNBCPay/tNxZpUbvAgM0xy3UDjjGM/1vzGd1ytU16C6NTNdqV8pfcIUt05FsZQCWtzx723u4+dm7C/GGS9i8YEwliUxwIlm4xcMbHAsNeHlcTB9evE3klYNyP++C9BjoiB9DDtIwORkeTAVHuLYzhoq1xHt00gMtdSkFH0pLRKk82/OSClfXWBZdJ1OtFpQPNGO2w1tqKNbj5SAVxpjiOOsokCRpdDif40nZ6JMhkhWKhhu4O+rdPZEx46qrGRZneXQiOq/+jvwNZiyRLE0crUOWRNofs4M6cXmil74OglFnuPh6poNr7oB7s9LdJiMkw4PjJNRKqXVizdvbLyKtx4dmNzBiqw99oab4YvjADN3uM9L28rKGbvzc0yRB1oJbhyr3fhwR6TVVk2/PSBy7NbyPsZy51Oj+7gOvJFJb2iAUv6lWik7Ld+FPgN8XdF9s5qdumqv8haPtBmSmkZLAhpufGc+7D8M8o+hofWNOq1ETkzCs5JFAYBich+0ZxNVhMYb9TcW86Q05ctoY9LE/ZyHV6HayEAtb+gCB1AQF8Ow/brfnmM+gDwCuV0q8FQjJ411GmEGRPQk4xP+S97prEIERHSXTeMU432VVT5tm1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6607.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(6506007)(53546011)(6486002)(6666004)(478600001)(38100700002)(86362001)(31696002)(41300700001)(2906002)(83380400001)(6512007)(26005)(2616005)(66556008)(36756003)(5660300002)(6916009)(54906003)(66946007)(66476007)(316002)(4326008)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk9XOHZ2TmRRZkZBSDlFL1AxS3NNbThmb3FSSDQ3aUZWK1g0b0ZtQTNrVit3?=
 =?utf-8?B?V2gwa1d4aUNJQUZ5NUMyNGp3MXFvekdrUFF3ZTFZMkxYMWVYdkxnUlphMUpS?=
 =?utf-8?B?UUFKTDJRbTlPMUZBOTRDY2pXUFl5SjY0MlBxOWoxcDBEc25YOUJsdk1aNUxr?=
 =?utf-8?B?bTNmbXlqb2RTeS9YaFpHK05UaWRTY0x0bEdrTEZGRThGS2p2WG01ckU1OUhB?=
 =?utf-8?B?RGlyS3c0MDRQQ0ZTL21ZSHFDWVQ3blV4cUJrMzhUcnNYT091b3ZITDd4Y3U0?=
 =?utf-8?B?aEJlSHBMM2prWFlPL2R2VHREYnpudWZCY0FUdE9zbCtGUDU3dGduOUFRd3Vj?=
 =?utf-8?B?bW1tWTVxMG1wN096QkUwbEwwWHEvQXZ5VnljM2dkRTRobENXZEhnNy9pTmVF?=
 =?utf-8?B?WHZHZ0taRXB6Z2ZieFgxZXhPMm1lZTF6UmdDWTljWXZURFkvaUhUZHE2a25w?=
 =?utf-8?B?MjU3SkNnYWVVR3JSOTIwUFBSNU14ZHZaVjZGMm1XV25SK2FGbjY1Skt3dmxp?=
 =?utf-8?B?NTFyM3lKWGxWMzRFb1FZalQzY2xSY3dXQlpGbEhqL0x1SXNrUkxYN3psS283?=
 =?utf-8?B?SEVGbFJOQmFOMnE3b3VLMDF5NjduOC80ZWloUTZxMmlpaHBTeWVnY09QYTcz?=
 =?utf-8?B?ZndqSnFPOWd6ZElVazIwMG1sNEhFeHQyblRBWmlJWldwQTBHNUt5VWFpam0x?=
 =?utf-8?B?aWVtTUJLZytuZnM2eW43UlVXdFhQVWY2TkY5MFVKS3RzdWRheUVaOUwyeXk4?=
 =?utf-8?B?ZDQrdE5kSmxyclpRV0tTMUFFSlNtTGt4SktQdWlMNGp0Nm40bXJRMThnWnVk?=
 =?utf-8?B?ODI0dTlpRVVvQ216OXh5V05XWEV0a25FUmxPbExReGJGZ2hqLzBTL3pCSUxQ?=
 =?utf-8?B?MTB4SDNWSm1Xa0tFb0N6NmdraWZod3RLLzBXUHo0cjJXT1ZoMmZkNElPTEtu?=
 =?utf-8?B?dTFDZlJ2WUpaRFZ2bk45N3BhZ1gvSDdDYWRueUw0TnFkSEduZzBFaTBtbjY2?=
 =?utf-8?B?TCtVRDA2Tlgvek5ScGVWZFJkbDBEVmYyQ0NMWm81SDNWaVhhazlzQ0FGOXd2?=
 =?utf-8?B?WHgrYmpUSC9CNk9Yc1JiQ1ZJaWhzOVp3bTl0TkVQeTNJVDAweG82YmF1Y2NG?=
 =?utf-8?B?NDJydXJFZEM2WFJVQWp4QnUrbWk0d240Wm91dFBGQk1mWkhUd3crejViMDVu?=
 =?utf-8?B?cUxBLzllZE5ISWdHdDhLdE44cVord2x3UmFINU4rK3JVZkxZM0g4UU5jY2hm?=
 =?utf-8?B?MEpUVXVHRUk2amNsQXlybStZVVZHNzB1Y09FeHBhT2hzYnpsN01xWHNaTE1Q?=
 =?utf-8?B?VnhhS1QvcjZxa1VPdFdzbTB5UHd4aFNzWmQvU2RQbGl5MTdnZHVFOFEzb0pn?=
 =?utf-8?B?Q2ptZDE5QzNxd1JEZUEyS3FVV1JyL1dJcE9qWHFuT2pWRlRRQXpma1JNRnJi?=
 =?utf-8?B?UWxRMFdhNmxxdXRGNE02NWFia25TeG5yancxWnRGOHZGaEt1K2FVSDV2c1lh?=
 =?utf-8?B?MDBsYkE4bWJuVnloU3k4Z1oyU3pjYSt1VzNNZlE0cmpBVWROVWRMOWRlMFNz?=
 =?utf-8?B?TU9IV1JmRHVMMkJ1SVQvM1VpS2JKckg5a21mWmVqdGpzT3hEZVAwVmp3U0lX?=
 =?utf-8?B?L0lxY29WMnVPR0E2TUhBTnJsenNNQTFoZDUrbllNemd6RjhabStxbXlVU2o2?=
 =?utf-8?B?b0htcFVTemRJejhJQlp4S0FXbnFGblN0b1hWOXZGVXFCNHF5bmFjU1J2NjhQ?=
 =?utf-8?B?bjBidnZwajlnMG0xb0thT2MvYzEvZjRWRExYbzVBbGNIdVZ3dVZUTFZhS2M4?=
 =?utf-8?B?Q1ppU3ZyZWFjYk5ZV0Q2bmMzb29QMWZjZzlGYlp6bG9xWFNRUTYzeFR0UXQz?=
 =?utf-8?B?alQwWkxsWC90R0FSeW1kaFh1bVhCOXdyNitCaDcyc0tBaDFhK3lPb0h1MzFL?=
 =?utf-8?B?cmZsSVo0enJWV2tiUC83OGRpZ2xMRzVrWWxmaEczUE10c1RxOXQ1b0JhQ1h3?=
 =?utf-8?B?Rjd1U0xHeWpiQ0FwVm8vdnBiNS9VelJUSzV3ZFRWUnJEK0pVWHRHYzE1aXMy?=
 =?utf-8?B?aHRoZDBvMzhacVVtUmM0QW5hLzQ5cHozNWN4QklGWWk1ZTQvMmVhTTVrczlX?=
 =?utf-8?Q?cET0M9rhikVSOblgSfuYLO49J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427497e0-2d8a-47da-e3fe-08dbc0497946
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6607.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 17:36:40.5073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wP4jswGZ5MI/w0jBXpP4U+IMMIKECxBRSQZ33zKo6wbErJ4UqoGPHtts1lTIYHrfmSWbfreZburL5hQ4X1Fedw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/23 11:53 PM, Bartosz Golaszewski wrote:
> On Thu, Sep 28, 2023 at 5:31 AM Dipen Patel <dipenp@nvidia.com> wrote:
>>
>> On 9/25/23 1:37 AM, Bartosz Golaszewski wrote:
>>> On Mon, Sep 11, 2023 at 11:46 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>
>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>
>>>> Allow building all HTE modules with COMPILE_TEST Kconfig option enabled.
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>>> ---
>>>> This was part of a wider series but since this is independent, I'm sending
>>>> it separately.
>>>>
>>>>  drivers/hte/Kconfig | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
>>>> index cf29e0218bae..083e67492bf2 100644
>>>> --- a/drivers/hte/Kconfig
>>>> +++ b/drivers/hte/Kconfig
>>>> @@ -16,7 +16,7 @@ if HTE
>>>>
>>>>  config HTE_TEGRA194
>>>>         tristate "NVIDIA Tegra194 HTE Support"
>>>> -       depends on ARCH_TEGRA_194_SOC
>>>> +       depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
>>>>         help
>>>>           Enable this option for integrated hardware timestamping engine also
>>>>           known as generic timestamping engine (GTE) support on NVIDIA Tegra194
>>>> @@ -25,7 +25,7 @@ config HTE_TEGRA194
>>>>
>>>>  config HTE_TEGRA194_TEST
>>>>          tristate "NVIDIA Tegra194 HTE Test"
>>>> -        depends on HTE_TEGRA194
>>>> +        depends on (HTE_TEGRA194 || COMPILE_TEST)
>>>>          help
>>>>           The NVIDIA Tegra194 GTE test driver demonstrates how to use HTE
>>>>           framework to timestamp GPIO and LIC IRQ lines.
>>>> --
>>>> 2.39.2
>>>>
>>>
>>> Hi Dipen!
>>>
>>> Any comments on this, the other patch with a comment update as well as
>>> the one addressing usage of gpiochip_find() in HTE drivers?
>> Sorry for the late response, This looks good to me. I will review and test
>> rest other patches.
>>
>>>
>>> Bart
>> Acked-by: Dipen Patel <dipenp@nvidia.com>
> 
> Do you want me to take it through the GPIO tree or your own? Either
> way no GPIO patches depend on it.
This patch I should be able to push, assuming it is for 6.7 timeframe. Do other HTE patches depend on
any of your GPIO patches?

> 
> Bart

