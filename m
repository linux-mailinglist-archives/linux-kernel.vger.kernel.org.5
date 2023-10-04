Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124DD7B8E00
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244998AbjJDUZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245156AbjJDUYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:24:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3002F4;
        Wed,  4 Oct 2023 13:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USONhZteA3O+zVPNIBnstTDcvHJ67u+DiCuuO5GDGuHafrekBaWUER3wAyOe17TK1OYtliBsHGNvtH5HztE4XXP3pdqxM+qAtLpJZ4VW6lAMB1dfbQvkkJOv+kD7toVZV9Gvz6dCIusBW5dyIPG83UxhvubnX4733PbQlPo4aCTLWbcsaqZIkVqCF9d+sqQ6Djn+1CGnVhSSo3qx06rNVYVVgjr5SC0ZYC0fIuoXdMlc28KIaPmNsIZjK0e/ctO2L/7RcO8X7mG9SY26x+a9joZZjZnhybXc/TerD8V9sPEWAzwKeJsko3s8pYsUiVDXJ0sx2JWVDnoR4Hjz/TUcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITqe9wv494UA6QSf9eMTOooAEg3I3g2AQ6X9x7s/OW8=;
 b=oPXJOyvVL54DUBhsEzPbJWJS7mqyij3dYPPHnBBZXyVBMQRiUwv0fpRfJP+Y/A/pag7J5Xtnx8hyNA1GjFYMrwGgpsHbcTTcAzfh3fWRu5qVTYTivLOeo72JksWO6M+Z/l0dY8P/S3jppQo9+JMl3US04bxLtVNkPr0uegfTriuC4Njy1EWkRncv7Y+dHneEClfpUWqQB/r+Quzf/lOsbixLzhKN91l5Ztrr3YPPednQY0h5M2htvEKiTKkqPJlvw7IN9Pre/WmUD8l/610XFwi3wJwkJaXXr/pSc79BREf4xXY+8SC3fY6uz+zwqBmMbKBkG3tgOZNcrFoPTjp3Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITqe9wv494UA6QSf9eMTOooAEg3I3g2AQ6X9x7s/OW8=;
 b=m5ygioxG+cw8AjFzTbphg41RC355he5KJJa4zBLbWXj5h8pH9tLl8le+VdB+4mcSjT+3/HKuZ6mBDNM8KVptERaXmewnrRiBPEh5v9KHXhjO7B7fyN6t5WsvLFXLCLhR3NQdArcxtQxTk/BPqVCTjee2Zd5ejK47pyL4GpHziU60adYUUSimzqmUWE5xRX4hJOiEmDuX7pronpCBbzeT4AgYYB+vHu64DhuQPsGHraINOeC80tzeVVPlSKHamCHKbJpggIipEgqSNplOHc2PSyTgiI/C7nMwfEX4XONKt2oSnfJS+939gYFRf8jMps4wXalscHsXg3QZvWigMM2EtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 20:24:27 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6838.016; Wed, 4 Oct 2023
 20:24:27 +0000
Message-ID: <7956eb81-014e-74cf-6630-b347a0b9d919@nvidia.com>
Date:   Wed, 4 Oct 2023 13:24:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
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
 <7766de61-a046-3e17-1322-28bd7f1e61da@nvidia.com>
 <CAMRc=Mfbt0iUbM42zR0ZrBWgbQkctQm3LxwiFFP5dXNuQC-EqA@mail.gmail.com>
 <59ea74ba-b951-cf89-9d7f-bc7212ddb08a@nvidia.com>
 <CAMRc=MeuMkExMef1fsEV9pPHyshGTLJLSHpT2vjLVXgEm6CD3A@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAMRc=MeuMkExMef1fsEV9pPHyshGTLJLSHpT2vjLVXgEm6CD3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::29) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e91ec89-5606-49ff-1eff-08dbc517e804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5GaokJtX+00ECDkHbuEYTgElw6kUfdqEudeQJi4mmQazYhv5ME+iy1SajVzWswSTdrl7PkoFghGNYqg5PGmLFT8n8MNqtPWf7nToRFDMhbYPajlARHfo1yeI6J76LW8BftleLlvbOuxc0mlJNfcDx9u3XX8LR1nSQzFjzqmulfo+GxfCkdxe7JJYO5niDH9xnXyeJssZeOomYZnC/lOdVUHjbVgpY5tiHzEhKCz04/S4HujT2O06peFwtBt0FQouedjt6XA0QNtJKPwAxumsSWCUjvpxft7Qu5VEPP5hn6xe7yctAJAYC5uBK/TnPOULpUY0QY8AjfDdc9kL+hiuO4+3VnOVvTxCVIGS++hMILiCuwENW6tvA8lavpTvw1ZEgG16mcYINczcgIP+LnEPDp8FO/McArCZ5cETSLSnFp04qmJPNDwgoVBCiSZC9eR003qTXQc+Wau+fGH/JSC+ofvlZ8Zuf6ViyHo/dtmAUBuIZnOIq70VQHQ/EUMXS6cH8yylrBZM8Oad9kDxlIs+lC3tVRXIqOMkThrZcwQM56Kg4E9+ymEcayntOyy6ICUSGkSh6+1vcoRa0Cnj62DIiE+WCFDHR1kXKJ/WWclwoXX6GfS4dMwYYS/hje3vB4ehgBFQ3D9Ey3EJWfo++iJma6KjK5tjgH5X69UXEyPDX+eX37PRKWQDCYH30lA5Tvv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(8676002)(38100700002)(4326008)(8936002)(83380400001)(5660300002)(41300700001)(6512007)(54906003)(6666004)(316002)(478600001)(966005)(66476007)(66946007)(66556008)(6486002)(2616005)(2906002)(26005)(6506007)(53546011)(6916009)(31696002)(86362001)(36756003)(66899024)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekZhMG5zSldDWjlEY3R3d2ZFOGRkVXpUVFg2V2hIUVphdXAwSGUwRW5hVnIx?=
 =?utf-8?B?a3Z0L3BtR0QrckxZRFZSeXE2Mi9NbFQ5NG94OGE3R3E5KzNHSWY4c3k3YVlo?=
 =?utf-8?B?N0hqdklPYnR4MjdSYjdZTjU4aDJZcGVmbjJ1U2ZvVFJNZjh4SWh6VVNVSjdl?=
 =?utf-8?B?YjdHQ0c0VG5wSW11U3ViQVlVRmRyMzFYMFFQVGxhUDUrNmphaFA0dEVWdkc4?=
 =?utf-8?B?dG9VRkFVVUdxQlZadi80K2NBWXRremFkYlFXcFk4RnBIRGtSR2xidjRxdzYz?=
 =?utf-8?B?Q0hES3dyQURWMWU1SkR2N0tFYTRMUmF1NnhJdTlrTFNGNlJrcndrc3FkcExE?=
 =?utf-8?B?T0RVeldnbW9rQis3d3BUcmtSWU9Ob2phZDdYT0o0clhmRVBsZmxrbkNhNWtz?=
 =?utf-8?B?MGV0aFllcUQrajdiZkhwQk8rK2FmQ2F5eVllK1hXN0lnN0VObjgxdGdTeGgx?=
 =?utf-8?B?djZuV2dqMkE4YTczYUt5ajI2UnN6Q3AwZFN0RVdCbXd4clhiMVRpL2N5QUpW?=
 =?utf-8?B?ZEdXQThkem1QQ3N2eElQL2U1TFRoalNocTdaWS9xL0Z4OVdtZDhJT3JYOEZk?=
 =?utf-8?B?WUlYVVNlMnl0ajEzbVpmNjFvNzVPV09jcHYyellzZ3IrcG1iZkQ1OVgyYnAz?=
 =?utf-8?B?YkZTbVdhZzd6ZGpwL0NnT3JPYWhZeWRONytHOENqdFlXODZsL3dSdmk2Ulo0?=
 =?utf-8?B?YzVKdTh0TXJheXYvN3gzUlcvY3FtSDlTQjRXVkVic1l5dks3RmJCdE02TU1s?=
 =?utf-8?B?QlRxOVVaaDg1MzZKMUxoUE85K3d4M2kxemd4emowV3VlT2N4R200WkROWTRM?=
 =?utf-8?B?ekhFYzI0R1JMQ3FBejArbXoxY0wzWXlXWktOZlQ4VDlIN0tncHNtY3VCSDRy?=
 =?utf-8?B?anJWMEdJai84WnZHd1hCbFVxV2tCUlE5WlY1eXVteUxGYzNLNEJtUitjNG1Y?=
 =?utf-8?B?RG1NRFpXaFhuc3dDZ2xrSElxN0VoOUR1SWxEeWUyc3puUzF3d1E0Q1lFY0VL?=
 =?utf-8?B?bUc4UDlZU2RVQjd2NTFEcWRCQXNYa2ZnaWdqNmlxRk5jQ2QzeERPWDl1dGM1?=
 =?utf-8?B?bnhMUFM1RzVGYTd2M25uTXR5ZU1SSk9reGNDWjdDMUx3SnZiMnNBSkF3K2dp?=
 =?utf-8?B?MmpXRTVRQmdqMzJmMk9wRzNrMDM3RUFXRC9RRlJvdkpIemJHSk5iVU12SDZa?=
 =?utf-8?B?Vjlvd2dvQzFnenF3V1d5NGJVSjFsUHVEOVdnMVZzNFVWakd3S1hNQnhLaThy?=
 =?utf-8?B?NUlWMnBCTmJTYUxVNXNpaU8yeHNQUTlBRE5nR29SVHl0SFN6b1RUQ3hWMno5?=
 =?utf-8?B?UTVLN2x5VmlXSVBzeDZpU3ZDenJLM0pQOTByQ2JFSUsyU1NpU3p0dU0wWHZo?=
 =?utf-8?B?eGRxTlUxeFFmc3liSE5Mc1BlV1JCdVRwM3pQT2FnL3Rsa0V0R0NJRkI2czhR?=
 =?utf-8?B?RlBZa2hUQllsck9xTTNuUnVLR1lCNWZYL3I0SGNYbDVFRndBQW54WGVKcFVm?=
 =?utf-8?B?MFZnUHRWSkNnL3U2OGxoSGFRRTVBbEpTTklTMXR6akZheHZjZFlORG1jVGdu?=
 =?utf-8?B?WjZ0WWxONzBIQVAxRFcrbWVrcGsxOVlCWVVNbTVNMktFczVJa0R3Zjgya3l2?=
 =?utf-8?B?Y2IwZFoyZFJ3ZlhTVk84UlNYZUlkbStOckR3RlVTbkphcndwaWFWNHVkVjI2?=
 =?utf-8?B?bTdya3VtV2pGc2xtL0tkRGtwcGVoZndJaEdMUGtTa1Z1dVFQcm5tOGZXZ3Z1?=
 =?utf-8?B?YmFTSm9ZbDM4SUR4SlhPU1JldUl1dk9UNHppdUVGYUs2MFBFVUp4RlA0S1RD?=
 =?utf-8?B?YjhjaW1kdHVaYlNsWExNQ3VyZE81NlY2Ykk5d2YwRzBidVJPQjhuRDZwbUs4?=
 =?utf-8?B?Q1pNemsvL3VZY2FyaXY4TzVUL2cwR0UrM0s3MEh1SnVWQXhmS3p5R0VtRTVH?=
 =?utf-8?B?VHU4aENWcjdOS20rSDVOWCttbDVxcEg5TGI0U0JPa0xwNnNuMFo4WlpDcGFI?=
 =?utf-8?B?OEdQdXZkcVNOcm5qNnBmNEZpT2FTL2hQeER0Q2ROa0dVMVlMczJBcVdQUzlG?=
 =?utf-8?B?ajVzaDhNdUhkTUxkaWUyN2l5VER1ME9HNmNzZyt5R1JRdU9RZUVjMGxnY0dL?=
 =?utf-8?Q?mRvbmKsDmX0dHzfcOamUya5Rb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e91ec89-5606-49ff-1eff-08dbc517e804
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 20:24:27.2405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iArQrPXebdGOl7s4867cgdj6PE6EaOagffv6Fg9BoL1dYGBq6Nua4VOM06F0nerL7ab/i3L0TbXBu5UoTNd3cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 3:04 AM, Bartosz Golaszewski wrote:
> On Tue, Oct 3, 2023 at 6:42 PM Dipen Patel <dipenp@nvidia.com> wrote:
>>
>> On 10/3/23 1:58 AM, Bartosz Golaszewski wrote:
>>> On Mon, Oct 2, 2023 at 6:27 PM Dipen Patel <dipenp@nvidia.com> wrote:
>>>>
>>>> On 10/2/23 1:33 AM, Bartosz Golaszewski wrote:
>>>>> On Fri, Sep 29, 2023 at 11:38 PM Dipen Patel <dipenp@nvidia.com> wrote:
>>>>>>
>>>>>> On 9/11/23 2:44 AM, Bartosz Golaszewski wrote:
>>>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>>
>>>>>>> Using any of the GPIO interfaces using the global numberspace is
>>>>>>> deprecated. Make it clear in the comment.
>>>>>>>
>>>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>>>>>> ---
>>>>>>> This was part of a wider series but since this is independent, I'm sending
>>>>>>> it separately.
>>>>>>>
>>>>>>>  drivers/hte/hte-tegra194.c | 13 ++++++++-----
>>>>>>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
>>>>>>> index 6fe6897047ac..9fd3c00ff695 100644
>>>>>>> --- a/drivers/hte/hte-tegra194.c
>>>>>>> +++ b/drivers/hte/hte-tegra194.c
>>>>>>> @@ -407,12 +407,15 @@ static int tegra_hte_line_xlate(struct hte_chip *gc,
>>>>>>>               return -EINVAL;
>>>>>>>
>>>>>>>       /*
>>>>>>> +      * GPIO consumers can access GPIOs in two ways:
>>>>>>>        *
>>>>>>> -      * There are two paths GPIO consumers can take as follows:
>>>>>>> -      * 1) The consumer (gpiolib-cdev for example) which uses GPIO global
>>>>>>> -      * number which gets assigned run time.
>>>>>>> -      * 2) The consumer passing GPIO from the DT which is assigned
>>>>>>> -      * statically for example by using TEGRA194_AON_GPIO gpio DT binding.
>>>>>>> +      * 1) Using the global GPIO numberspace.
>>>>>>> +      *
>>>>>>> +      * This is the old, now DEPRECATED method and should not be used in
>>>>>>> +      * new code. TODO: Check if tegra is even concerned by this.
>>>>>> This use case is to do namespace mapping from gpio subsystem to hte. Few doubts:
>>>>>> 1. What does deprecate mean here? Does gpio subsys not use global space anymore?
>>>>>
>>>>> It does but we don't want to expose this to external users in any way
>>>>> anymore (and haven't to for years). This is what deprecated means.
>>>>> Users should deal with opaque GPIO descriptors not global GPIO
>>>>> numberspace.
>>>>>
>>>>>> 2. If yes, what GPIO number is set when it comes from gpiolib-cdev, as based on that I may have to
>>>>>> reflect in the mapping, tegra194_aon_gpio_map for example.
>>>>>
>>>>> Why DO you have to use a GPIO number though? If HTE needs just a
>>>>> number from some HTE numberspace (which in itself may be unnecessary)
>>>>> then why not just keep a local IDA for it? Do you have to know the
>>>>> GPIOs internal numbering scheme to make it work?
>>>>
>>>
>>> Dipen,
>>>
>>> Please set your mailer to wrap lines around at 80 characters as is
>>> customary on the mailing list.
>>
>> my email client misfired, will make sure. Thanks.
>>>
>>>> humm, overall, I just need to know which GPIO it is, for example, GPIO controller X Port A GPIO number 3
>>>> to do proper mapping.
>>>> Continuing from above example, the hte driver gets:
>>>> - GPIO Controller X from DT node
>>>> - the rest details in current code gets it from [1] and [2]
>>>>
>>>> If there is alternate method exists, I would like to explore. I think IDA will not help in this case as ID assigned
>>>> does not hold meaning in this context.
>>>>
>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib-cdev.c?h=v6.6-rc3#n760
>>>
>>> Here: any reason why we have to translate the desc to the global GPIO
>>> numberspace? Can we just pass the descriptor pointer directly to the
>>> HTE subsystem?
>> Sure, if from GPIO descriptor with combination of any helper APIs from
>> the GPIO subsystem can help identify the GPIO pin, we can eliminate the need
>> to pass global number (I assume gpio desc
>> can be only accessed/manipulated using GPIO subsystem APIs)
>>
>>>
>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hte/hte-tegra194.c?h=v6.6-rc3#n421
>>>
>>> I still don't understand why you need to know the GPIO base? I'm not
>>> quite sure what the role of line_id is in this driver. Is it only to
>>> index the array?
>>>
>>> Please bear with me, I don't know this subsystem very well.
>>
>> Sure, no problem. Let me see if I am able to elaborate:
>>
>> 1. Map arrays' indexes are GPIO offsets so to avoid having
>> the extra field for the GPIO numbers.
>>
>> 2. The HTE driver needs to know exact GPIO to enable corresponding bits
>> in its registers. For example, hte register bit 3 would correspond to
>> GPIO 6 of GPIO controller X. If gpio descriptor is passed here, I think
>> I would need to do some conversions to identify the GPIO to enable
>> corresponding register bits. In the current scheme of things,
>> I though it was easier to identify passing the output of the desc_to_gpio* API.
>>
>> 3. Since GPIO global space is runtime, need base to calculate the offset
>> where offset does not change. So in the above example, gpio cdev would pass
>> 306 and HTE does simple conversion from the base, ie. 306 - 300 = 6.
>> Now 6 will serve as pin number as map array index to find the register.
>>
>> 4. Overall, I rely on base + global number to do namespace conversion
>> between gpio and hte subsys as far as gpio-cdev use case is concerned.
>>
> 
> Ok, so you *don't* need the global numbers, just controller-relative

Thats correct....

> offsets. This makes sense. This ties nicely into my plan for removing
> all accesses to gpio_chip except for GPIO providers.
> 
> Looking at the tegra dts I'm surprised that the GPIO controllers that
> use the HTE don't take the hte_lic or hte_aon phandles as arguments.
> How exactly do they resolve the HTE device to use for timestamping?
gpiochip added few callbacks during hte subsystem patch series to manipulate
gpio line that needs hte. So it does not need any handle as of now for the
tegra series of gpio controllers at least.

> 
> In any case, I think this commit is still correct.
Agreed.
> 
> Bart
> 
>>>
>>> Bart
>>>
>>>>
>>>>>
>>>>> Bart
>>>>>
>>>>>>> +      *
>>>>>>> +      * 2) Using GPIO descriptors that can be assigned to consumer devices
>>>>>>> +      * using device-tree, ACPI or lookup tables.
>>>>>>>        *
>>>>>>>        * The code below addresses both the consumer use cases and maps into
>>>>>>>        * HTE/GTE namespace.
>>>>>>
>>>>
>>
Reviewed-by: Dipen Patel <dipenp@nvidia.com>
