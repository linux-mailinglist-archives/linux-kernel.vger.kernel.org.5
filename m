Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8E47BE895
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377427AbjJIRqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjJIRqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:46:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6A2AF;
        Mon,  9 Oct 2023 10:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCxovDdVrXyk/nnCBcoJhzBnPWn9vDMfCwpyaKsf2TMeRCxhp++6Vtehd7KMtAFMCJ5mXVEuwtwqAHgHWe5/Hlt65A9Rj5aWEiSBAYGJv5kNnNhCrfiBe+d7dXhErapj2ozNF+m2ktc/uiHu6YM0ASBEiMIFFHqZoDGqh9ZkS8NKl7cvEu6uOGOUxWFRVNIrPl1/TLoSTlBvIOtQ0IjQRo4rBGalWzgUWqgezqYY+U6dJ4suhljrO4cdE+peqFbGvHMdxp16OQhNhyAab3RAsgbnt0tVaw2GI7cPMRsy647FhU0u76VELwl/u3IfKB5p0pX43h2GOZTJPft3qq/rBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgPoizulzTeD8xeGBXMrepjQQEusDby8l0YcbpWXQI0=;
 b=fWlR9XOFjr4We3sJ5r8X/90M5bUprzRvZlGK9oLbI6X3c7UzkpfoRyMefqX8x5aXQTlqP7OahuBhyPoYQ6soi7OSbQp8hcdrUmZxlonFvFTeHGCETRh/te++rlzsDjsOUlAKgUveFaQZ0q3y/eB4pVQY9n//4X3FtBpA6EsykAFHKNqiAO1f7mDZh3m6ZuG2axz3lsr0huMTwJS15k0kR24Z5FSWsz2VRRyCsXIChB9F1rFBgG9hB06Q1By/zF0ub3RD/4hQ37daf5n7GfsKsIxVX7w2BlDo/Xi/Jw47LnqklVVu0IjViTJTEFttxlMSUHTdua2v8cxSIpK+MR5NKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgPoizulzTeD8xeGBXMrepjQQEusDby8l0YcbpWXQI0=;
 b=lCTbUt0TOmd2byJ98tsN5/jKhcwGH9qMtpIetHrFgv9GboH0KCH7gYr0q60XZOGWSs8/uFkXS94dD1IY1/oeMD8Y2t0GbN0w3Wi6GOxj4iqM50U1rPHTfwz5EYX/Oj7lbsbUkLVV0bnzuSaeEJVRbZ7CNuC6N8nTLRlF9JY06bo8o/fOMROW6cYYyTpNGGNXFHEZjCbK+10X5N6t9NShWRBzYOrn5W2k2RVHlObMAF40IQDfsDoK6iu5q4WeX1zuNzrDJMcMO8LtxGIepaTo/loAJpY4MDb8dm71cebmevlRFaMKhbPaNdAyzaSsjy3gjS/d7LHq9w5Ts/g7GqMCag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.36; Mon, 9 Oct 2023 17:46:33 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 17:46:33 +0000
Message-ID: <b3ea777a-9471-0458-af2b-32a2adef4dec@nvidia.com>
Date:   Mon, 9 Oct 2023 10:46:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFT PATCH 14/21] hte: tegra194: don't access struct gpio_chip
Content-Language: en-US
From:   Dipen Patel <dipenp@nvidia.com>
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
 <3a54df71-d5cc-f538-75b8-f2193e27d65b@nvidia.com>
In-Reply-To: <3a54df71-d5cc-f538-75b8-f2193e27d65b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::10) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc6035b-2f15-4580-0a16-08dbc8efad37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHuVX08q9G4/93LkdqaSox1tWdPt2kcptrlkzhM6/f0kozPZ61bC4CMrYxjxNZmwUeCw7RVCD8KzanJtbBW9z8Pujo6oiPv055dyW9B6HlF9+RcEZ6UmuHtWyUnmDMcZoZ9Kp8kZOCzx9xO1VXg4J8kSLxm8XhAnbpE0A8Q3aQUsM5bYetMtMVNPiDp4RsX7qD/lL/g3mLt9hmjX4JUuFnHzia9PiY/2VRNLFlbEkfNkZNqAlG3sePL0ePuMbeDMmTvqM0s0S9rkEDZbJGXk59VORPjSm4RnSEGtuVPJVeVDLzHr+qFJUZYsk4XCuLWw1NJMGidTsZ+8juvZ9222ypEByw74HIU64im+ERXa1SlNFRyhkwpWr64EBzwrKtBvvQl3/MDPwh8/LnJLE9FTQcsBDoWscu4G4L8Ozu4HygSbGSPr6QN5nUAjTcgcRXdYSsRwiil9a9hFmfhaMYz5bzEgYaxZCEY4eTvYIkXlfEy4XLKPJoEpPo4p5F3mz22lBypwLJ273zWz7B25B4OVq9pTFk9AwnXeCDeYQwMoGmEygKJk2vwXi4+bp+JWF0Fl6brjWfzSxF0y3RFhnDg5rLUBYFjH1fjXsTNDjJpSqcBZoDuIekQ+hPM6DwxV/Bs4oUOSKc7lfTlcUupUPzJpBnA+F3jbGDcmOZxxQQup5dB0MHUV0cV309hcoP5ebYlH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(6506007)(53546011)(83380400001)(2616005)(7416002)(26005)(66476007)(316002)(54906003)(6916009)(66946007)(66556008)(8936002)(4326008)(5660300002)(41300700001)(6666004)(966005)(478600001)(6512007)(6486002)(8676002)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFN5UHZGN3A1MkFiWDYrK3p2bUU3ODBvNjJydCtNSGF5cnU0NVpJcHBacGNp?=
 =?utf-8?B?bXBSck1ianhQaUVlUWdjMnlDT2JRMUlMQktEUC91U0REcGw3R3lJeDJqaWlx?=
 =?utf-8?B?My91UVhBRmZiTHA1Vi9vLzZReHVpYmU1dFpXYUNJMzJxeVFiOElQbFMxa2xl?=
 =?utf-8?B?Y3ZRaVBmNjJGcldTeTBYdDFDU2hNcXEzMFo3Q0J3MC94NU1NSHMrZGlobDJU?=
 =?utf-8?B?V1hsbThxVDNrR0hNaXRzN0h3MTZjUEkrQzJpbHN4dHFrTUcvUVFyc1ZrQm1j?=
 =?utf-8?B?aGNHTjJoZnIxTFYwb2YyWGIzZllqNmViWDIyb0dSSmd2cmV0SWtLZHZ5Y1M1?=
 =?utf-8?B?ZXYwclZzTDk2NWtpbGtaOGVtdVJaZ3haSzFnWFByYVZOMXpBWTdDSklaeEJ6?=
 =?utf-8?B?Mm1OdjVONG4ySG9XU09OamJURyt6dzBtT05UQzBVcVNZcnI3ZDErbmNKZkNz?=
 =?utf-8?B?SkVQbFJSTGF4aThvaGFnbTJlemtYVjVIUWJKWDhFNUNEbFY4eEIwbEFmQXpZ?=
 =?utf-8?B?cVh0RWlGbGdZVEljYWI0WDdoN0xScndVWmh4bXZmcGJ0YXpPdjRTaGtCNVQx?=
 =?utf-8?B?L2hnSHJSVHFRK2xIc0dKK3ZmVUFKbzdnYmNDb2RJS0JqWVJDTHp5N3FJK0FR?=
 =?utf-8?B?WlhoRi8xeVY1OHd0VWVQQXl6MTZHb2RYTEhaRjBmVERXcGV4eVcreDVrc213?=
 =?utf-8?B?YU5ReVZ4RERaQzNZTXh1SlBnd1dxUE5aNXJ3RzVZdDRjN2NPaUtKazQrTTZV?=
 =?utf-8?B?elZOQURuSFQ3b0lIN1FoVDJUTXYrMU5kbnVuUUl2bXJvTzVMT3dyVXd1RWFr?=
 =?utf-8?B?bFdOczN6TjhEZkxpTHlRRUZCRUpvQVNEdzV0WFRnRkI5amI4VFVzd3FXZ051?=
 =?utf-8?B?TklRT3JLZTB5MGM3akVrZkRyT2ZxbmMyTmV3SkNEOUU4NXNpQkt3MHRkRlhX?=
 =?utf-8?B?VmgvZWU4dm1oaHB2ZnZZbDkxai9weXl2bDVjQmliZzRzL2ZuT3hFNTBiZ1ZR?=
 =?utf-8?B?cWtEaWQ4UHlmRXlBRjFQN2xwWFpNWVRRajlXWG5wWEwxd1A0cmhkK3RnWUpQ?=
 =?utf-8?B?NWt5TytqTk5yeDAwRCtHZGJPYmFMbFlLM2JNWWhtVXdjVW4zUmxVWUtyUStO?=
 =?utf-8?B?RDNXeEwwNlRyaWNtRjZ5MzZXMHV3ZUZadEs5YWxyak56aXlLR3BpY0tDUkhP?=
 =?utf-8?B?RmtYMS9OZXl4TkNSdXpNeDJYanJoV1ppNWJnaVNyd2tmNUIrVTdRMVBsUnFw?=
 =?utf-8?B?aVZsUnVhTFl2R2pQTDJOUjByNVVOVGQ0aXRkWXRiTGh4RTROVVIzakdBWGtX?=
 =?utf-8?B?Mk5Mb2U1WVo3dTZiQzJONHY5T2dEdUNkNmlWNDdaVUVlMUMrYTFPZ0J3dWh0?=
 =?utf-8?B?TEgvc0tuaTVkcm9nMkFuR0tzaEJXMll1a3NhK0dkSHhaTDlXN0d0d1NLR0xx?=
 =?utf-8?B?OXJSZFg3WWxQMWVvYnVlaUxwTWQvNGEycEM4VkRMZUZCa2VHN3cwTEJaMS9D?=
 =?utf-8?B?RzhjS1lvWEJZWGM0OG41NEN1UFpzajQ5ZW9TVWJ4R2J2ZTNlalhKRHBYTHhN?=
 =?utf-8?B?ZkJjb040ZDVkbzQ2QzhKdzhkZUI4ZGRDckRwd3FlZVdTVDJSTzE5VTU5SVlx?=
 =?utf-8?B?Q0o4RjVIWUp2NlljS1RIdmRXUXR4VmloV2VGamVaSnF1dTNYKzd6ZTFUSjIz?=
 =?utf-8?B?TWlVNnNuYmJjdk1iMW9TVURrRktjVzVzNExleDdIQ05PR2JjWHVnVktmRGVy?=
 =?utf-8?B?c1hxcmFDWktzRUpGU2ZlL1RaNGJQOTZ1UDMyL1lFb24ya2F5TEJKdVZ5Z0NW?=
 =?utf-8?B?SmtTZU5XRjBNT0NSdjFPaGRBTFIvbnNEWUdsUTFKWk14dlB2QlZ4WUpxV2RC?=
 =?utf-8?B?bzI5aE5YYVNmL1AvZVBlZkl4SEVNRllWWjBjZ2pEVlIxLzZ1T0hnajNWY2JC?=
 =?utf-8?B?L3RySk5xVUdFc1Rsb2UxRWduWkxHcjE1REdHMDJNdUtiK1BLOE9NR1E1bXNt?=
 =?utf-8?B?M0t5b0dKc0lBSjFSeDd2NmkrbFZSMkI3S0tQNnU4YUVwTThaa09VQkE4VEhB?=
 =?utf-8?B?UEZTcy96YTVvOEMxRlhseHJMVG5ZaDBycTgrQjh1eWkrRzJpc1FDa3RQbUxG?=
 =?utf-8?Q?gwXee6et4NSSGsJfDzyvwBmc+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc6035b-2f15-4580-0a16-08dbc8efad37
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 17:46:33.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /E0s9DozjuZtUT6tZrNsgiOJAvhQaiTm4qbG3mafOWcx7tz4mRZe9weGXp3SQHvsJfUiKFjC+i/ums9glf1Udg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 9:34 AM, Dipen Patel wrote:
> On 10/8/23 11:48 PM, Bartosz Golaszewski wrote:
>> On Thu, Oct 5, 2023 at 9:43 PM Dipen Patel <dipenp@nvidia.com> wrote:
>>>
>>> On 10/5/23 12:05 PM, Bartosz Golaszewski wrote:
>>>> On Thu, Oct 5, 2023 at 8:12 PM Dipen Patel <dipenp@nvidia.com> wrote:
>>>>>
>>>>> On 10/5/23 6:48 AM, Bartosz Golaszewski wrote:
>>>>>> On Thu, Oct 5, 2023 at 1:52 AM Dipen Patel <dipenp@nvidia.com> wrote:
>>>>>>>
>>>>>>> On 10/4/23 3:54 PM, Dipen Patel wrote:
>>>>>>>> On 10/4/23 1:33 PM, Dipen Patel wrote:
>>>>>>>>> On 10/4/23 1:30 PM, Dipen Patel wrote:
>>>>>>>>>> On 10/4/23 5:00 AM, Bartosz Golaszewski wrote:
>>>>>>>>>>> On Thu, Sep 7, 2023 at 9:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On Tue, Sep 5, 2023 at 8:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Using struct gpio_chip is not safe as it will disappear if the
>>>>>>>>>>>>> underlying driver is unbound for any reason. Switch to using reference
>>>>>>>>>>>>> counted struct gpio_device and its dedicated accessors.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>>>>>>>
>>>>>>>>>>>> As Andy points out add <linux/cleanup.h>, with that fixed:
>>>>>>>>>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>>>>>>>>>>
>>>>>>>>>>>> I think this can be merged into the gpio tree after leaving some
>>>>>>>>>>>> slack for the HTE maintainer to look at it, things look so much
>>>>>>>>>>>> better after this.
>>>>>>>>>>>>
>>>>>>>>>>>> Yours,
>>>>>>>>>>>> Linus Walleij
>>>>>>>>>>>
>>>>>>>>>>> Dipen,
>>>>>>>>>>>
>>>>>>>>>>> if you could give this patch a test and possibly ack it for me to take
>>>>>>>>>>> it through the GPIO tree (or go the immutable tag from HTE route) then
>>>>>>>>>>> it would be great. This is the last user of gpiochip_find() treewide,
>>>>>>>>>>> so with it we could remove it entirely for v6.7.
>>>>>>>>>>
>>>>>>>>>> Progress so far for the RFT...
>>>>>>>>>>
>>>>>>>>>> I tried applying the patch series on 6.6-rc1 and it did not apply cleanly,
>>>>>>>>>> some patches I needed to manually apply and correct. With all this, it failed
>>>>>>>>>> compilation at some spi/spi-bcm2835 driver. I disabled that and was able to
>>>>>>>>>> compile. I thought I should let you know this part.
>>>>>>>>>>
>>>>>>>>>> Now, I tried to test the hte and it seems to fail finding the gpio device,
>>>>>>>>>> roughly around this place [1]. I thought it would be your patch series so
>>>>>>>>>> tried to just use 6.6rc1 without your patches and it still failed at the
>>>>>>>>>> same place. I have to trace back now from which kernel version it broke.
>>>>>>>>>
>>>>>>>>> [1].
>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git/tree/drivers/hte/hte-tegra194.c?h=for-next#n781
>>>>>>>>>
>>>>>>>>> of course with your patches it would fail for the gdev instead of the chip.
>>>>>>>>
>>>>>>>> Small update:
>>>>>>>>
>>>>>>>> I put some debugging prints in the gpio match function in the hte-tegra194.c as
>>>>>>>> below:
>>>>>>>>
>>>>>>>> static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
>>>>>>>>  {
>>>>>>>> +       struct device_node *node = data;
>>>>>>>> +       struct fwnode_handle *fw = of_node_to_fwnode(data);
>>>>>>>> +       if (!fw || !chip->fwnode)
>>>>>>>> +               pr_err("dipen patel: fw is null\n");
>>>>>>>>
>>>>>>>> -       pr_err("%s:%d\n", __func__, __LINE__);
>>>>>>>> +       pr_err("dipen patel, %s:%d: %s, %s, %s, match?:%d, fwnode name:%s\n",
>>>>>>>> __func__, __LINE__, chip->label, node->name, node->full_name, (chip->fwnode ==
>>>>>>>> fw), fw->dev->init_name);
>>>>>>>>         return chip->fwnode == of_node_to_fwnode(data);
>>>>>>>>  }
>>>>>>>>
>>>>>>>> The output of the printfs looks like below:
>>>>>>>> [    3.955194] dipen patel: fw is null -----> this message started appearing
>>>>>>>> when I added !chip->fwnode test in the if condition line.
>>>>>>>>
>>>>>>>> [    3.958864] dipen patel, tegra_gpiochip_match:689: tegra234-gpio, gpio,
>>>>>>>> gpio@c2f0000, match?:0, fwnode name:(null)
>>>>>>>>
>>>>>>>> I conclude that chip->fwnode is empty. Any idea in which conditions that node
>>>>>>>> would be empty?
>>>>>>>
>>>>>>> sorry for spamming, one last message before I sign off for the day....
>>>>>>>
>>>>>>> Seems, adding below in the tegra gpio driver resolved the issue I am facing, I
>>>>>>> was able to verify your patch series.
>>>>>>>
>>>>>>> diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
>>>>>>> index d87dd06db40d..a56c159d7136 100644
>>>>>>> --- a/drivers/gpio/gpio-tegra186.c
>>>>>>> +++ b/drivers/gpio/gpio-tegra186.c
>>>>>>> @@ -989,6 +989,8 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
>>>>>>>                 offset += port->pins;
>>>>>>>         }
>>>>>>>
>>>>>>> +       gpio->gpio.fwnode = of_node_to_fwnode(pdev->dev.of_node);
>>>>>>> +
>>>>>>>         return devm_gpiochip_add_data(&pdev->dev, &gpio->gpio, gpio);
>>>>>>>  }
>>>>>>>
>>>>>>> Now, few follow up questions:
>>>>>>> 1) is this the correct way of setting the chip fwnode in the gpio driver?
>>>>>>
>>>>>> You shouldn't need this. This driver already does:
>>>>>>
>>>>>>     gpio->gpio.parent = &pdev->dev;
>>>>>>
>>>>>> so fwnode should be assigned in gpiochip_add_data_with_key(). Can you
>>>>>> check why this doesn't happen?
>>>>>
>>>>> I do not see anywhere chip->fwnode being set in the gpiochip_add_* function.
>>>>> The only reference I see is here [1]. Does it mean I need to change my match
>>>>> function from:
>>>>>
>>>>> chip->fwnode == of_node_to_fwnode(data)
>>>>>
>>>>> to:
>>>>> dev_fwnode(chip->parent) == of_node_to_fwnode(data)?
>>>>
>>>> No! chip->fwnode is only used to let GPIOLIB know which fwnode to
>>>> assign to the GPIO device (struct gpio_device).
>>> What do you suggest I should use for the match as I do not see chip->fwnode
>>> being set?
>>>
>>
>> This is most likely going to be a longer discussion. I suggest that in
>> the meantime you just assign the gc->fwnode pointer explicitly from
>> the platform device in the tegra GPIO driver and use it in the lookup
>> function. Note that this is NOT wrong or a hack. It's just that most
>> devices don't need to be looked up using gpio_device_find().
> 
> Sure, at the same time, I am also find to use any other method/s.

(Correction) I am also fine*

With patch
https://patchwork.ozlabs.org/project/linux-gpio/patch/20231009173858.723686-1-dipenp@nvidia.com/

Tested-by: Dipen Patel <dipenp@nvidia.com>

>>
>> Bart
>>
>>>>
>>>> Bart
>>>>
>>>>>
>>>>> [1]:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib.c?h=v6.6-rc1#n767
>>>>>
>>>>>>
>>>>>> Bart
>>>>>>
>>>>>>> 2) Or should I use something else in hte matching function instead of fwnode so
>>>>>>> to avoid adding above line in the gpio driver?
>>>>>>>
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Bart
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>
>>>
> 

