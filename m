Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB67BA8D8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjJESNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjJESM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:12:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD24CE;
        Thu,  5 Oct 2023 11:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwuiJqknDlH/QgBUkBuaBjK55Zdc6w1FpTrttT1WP/5nAgnNgTSfn49e00+lJv9kMeSMmT692JFbh8/YAa/Fzldo23X7eJCvSSmkHYfKvgkwhSscWPIt++K54VNbS2bKk1e/FhN8EKqGjuGU0fR62DnJidETUAuSvU3S5yUtc0Lo09agPDorlLUoL9BhTQGGC1HzOx1QSMmD1Pk74U1pknwsV5y8QZizQvzpooCbn283iO/778lwuN41YQX6Fg+3BInhTC3w0wf8LICwuXIFM06lsY6AnmIWs5B+LXDgdOuvGojb47q/ALGWSklyblAOkZ5rWc/tHAMhc23mhMcQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOauRLuwCA5+otNQIaiAt1FIorRJ9/iNda9U7+9PPKM=;
 b=E8EbEstfeE3GMXFTy8xkllVMCpcjit3pTSN2K5d7SkajJ/K/geMY4ihA4wO0Wbi81CBhYqdOdCWuIQpjGL5U/EiRay2/zaomLBAH9Dw3gP9QpSSOz7IcO0a+jAfEwpW4aIkYKbVeYPnZp8R4q4CiDdk5Cg1FiJIf8Q1OKl5BHvUNunNg8RKjdwBQlRIKJOxD2TrArsb/tI6Hh/5nNLD5tXrBAQJlbiCjRLfk0nw7DJidIsFgckkC+sYpEAi8qIJiXLQZ3SvBLo/kjyJdI7UTrK7WjUu9+NX20rsI8RIqbbBm6ZHbbVk/VUk4c5Vvcag44uFpEBdzyWdI7EJEN5xWfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOauRLuwCA5+otNQIaiAt1FIorRJ9/iNda9U7+9PPKM=;
 b=EQHq/v5RKJYFF2nZDYHA5DyALwa5aIqi/LcgvruDEor9HJEOh0Qo5c/4KlEUgSRpJn8DYPuEWP8bn369e0pcqQN+9Kmo51P7Bg6vGTQwCZDatcP6Kvlk0TB5M2TODmGRqCXFuPlpItJXU2PEW+j+kjhT0JiqvHFyYrmvdXAJRVZlpMksV6xB2+4vvldWpPu6P6eRoC+Xw82DT+XYeUCDHCONEH0OweuFA+/xHO6Jj2s/6oXUOaeiz0eoRZjjmn1vLOHyr4ts/Y1ICaaoGV7+td/yiBH+qbMgNwpQPx/Zn0kLMcvJlSakRNoHoQF4OhjXtzwAbFnNePtcN7v4gEg32Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Thu, 5 Oct
 2023 18:12:42 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6838.016; Thu, 5 Oct 2023
 18:12:41 +0000
Message-ID: <647d3b52-1daf-175d-d5c2-45653dd2604c@nvidia.com>
Date:   Thu, 5 Oct 2023 11:12:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFT PATCH 14/21] hte: tegra194: don't access struct gpio_chip
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
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAMRc=McSG6qajxt6P3vWQEeT63Pk5tggD05pUoMD1zd5ApZxgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::20) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|MN0PR12MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec7cfcc-4ebe-4eab-610c-08dbc5ceaa66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnyxgrq2YhffzHgft5R9+OmaPWj4bnqQvVxoBBMxAFB6QAxfKJTxPqf78wO9GQEwLGqVvKZU20flSOAAY8oACAERYagphnU2MRQDMg25uMcq1j5ioe0sBz2Y0JOUs5pH0sdN9e04DoAPPZODYB/Fp8L1a+ysA0Ql1dfFW3Lg2AuuHrYjgzLr+4dpAyLu/ntOI3qibe0i87EYvRM5829VWftp5N0CJRO4TpqDMfA3/ATfM02Sz+6o+4e8d4Zq4ykqb5KgrrLEk9aYnGbA1uMO6or5o9ft/Yrs3Pd3NM2pInR3HFK5HjbTe4U7Zdooh7mNKTQeYDeqM2Fb8tZomRmS/V03Y2gfm82udY2KLye8+fjpo5iM7X1t15gaeyTEW2cJFyDut7gV22iTrREVdMgCFtllZPRKdFdaOUVWzM9XmiiOygWwGp2PlE1mDZctLqE+eB7qx8oLOmdPk2gTKjFFxZHC97ADoTXXOGfnpoNQ10hpsXw1zerjqpTrneF4P1OVjpxqUdIJ8s3/DL0s8LiUNRKbbaEpUl9gVV/iJaPBi0L5uHv74D/m21JW/irN76rUGkZLfOwRDesM7AvcuU3JB3g/GapY0F01ferxrk1VCPIacVpHTspayHI0w5Vmtl8GMFj+PbFc4zWFyLlp3LyYFg7Yt+zQ+VWL2PTmsZz6fvH1zbg5I0kLkemNMuceQvuibCvSfzEHvfeE20+gAIW+vzxqvWWhE1r1jxg3AkXmfjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(83380400001)(7416002)(2906002)(31686004)(5660300002)(8676002)(36756003)(26005)(4326008)(2616005)(6486002)(41300700001)(66476007)(54906003)(8936002)(66946007)(6916009)(316002)(478600001)(53546011)(66556008)(966005)(31696002)(86362001)(6512007)(38100700002)(6666004)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFk2RTBjYVFwRnZUR1d4cG5xaHduWVBtazJhSlFjaDBKTkdNQndnMjk0cURl?=
 =?utf-8?B?TU5LWm4yWDQ2Z3ljeHZseGVFU0d6VlZHaUg3R1JmSXY1Z21qZ1Y4OU8wRWVD?=
 =?utf-8?B?anM4aFc0TDhhOEx5YlpmUDBDV2JyZTZ2WHhqTVk5SnNQbGd3d2lvK25WODI4?=
 =?utf-8?B?ODRmRmpSb2s4UjhNeDRtYytJYXhTbDJabnNuMWtDY2QycU4ySEo1MkwzZm9a?=
 =?utf-8?B?dEtBZENJY0ErakdPcnNmUC9KRC9QZitwdXVobjJnQlJReXRZL2t6SFBNalVs?=
 =?utf-8?B?Z21EbmM0NklMZGlOQ25lUnpOeGhXaXg1VCtjWk9rOU9ZcEpGTjBpWmUxZXlT?=
 =?utf-8?B?dTZJZHlWSjRMVXhvbWhxbEFwQXdRclZLVVpoWFd1YWxQOFAvSjZFdDdWTUFG?=
 =?utf-8?B?U2NCbHR1TmNQdlZNcjFhakRwREt2SC9uK3p4Y205UkM1dGhlc3dhcTl1ZG9L?=
 =?utf-8?B?S3hGUEpwV3djdXJ5QUMyaitlR2RuTlpkY2trWVhoSkdTMlI1eTk3TlhKTWJY?=
 =?utf-8?B?MFJ0Skd0elBmQ3RJZUFUak5lN2M3Nm81ZDRVeTZHQXBuM2ZZL1ZqVmF4SW5V?=
 =?utf-8?B?R2tkVjU1UWo3MWVmODdFYUttUXFuSklxdHJ5UXBDYlhtbGVCWjF1WkVSaDFG?=
 =?utf-8?B?Z3JkMFJqd1FPb2pMR1RobjhvVEpERC9sZ01mN2Zjd3VBb1F5MmpINW5pbEVn?=
 =?utf-8?B?M3ovbHBxZWlrNkt4WDJYZktsYVZmdjRmRThiMjRwc0dDTGtwako0TzVBa3k4?=
 =?utf-8?B?ZXBGaGJvMTB2bzZhVkU5cXhwQnNScS9tQzhIU2hCR3h6TnFJQ0wzQ0hoeWd4?=
 =?utf-8?B?SXNXeDZyaEJQRm9HbDJwVnB6QVBvVnFmZFA2MWV1Yno0R3BNY3hYeitYcUlM?=
 =?utf-8?B?Rjc0ZHlrNGI4bEVBdXlOWXRsbjVuZzVvTWIyRWdvU1lybE4ydUhHNDZDbG5N?=
 =?utf-8?B?cXpZMkpVZGMwaDAyakkvaWpYajFZOE9pZnZvdXVFVkR0NFBjQlc0ei9KVnNw?=
 =?utf-8?B?RzRlQmVrMTFpSU1kakJ3Z3ZVakFybFhuMlBDOXA2KzVnMldwRks5Tk11cnJo?=
 =?utf-8?B?N3NVWXgwTGtqWE5BZjBudEdjMVNBeGwvVy9BZ0N4ZXEvOVhTU1hBRWRDNDZO?=
 =?utf-8?B?b1plQ0czbHRHNFQzWDJuK0l3dlo1Z292L2FrRk5rR2Q0UGdGdnlzSUtaMC85?=
 =?utf-8?B?eTRxdlZ6VS9WZ1NrL2lPQjVvMWZ3algvRHpaU0FJYUVFVmdnNnV3RVpoMFhy?=
 =?utf-8?B?d0JoaUVXQm9PZFllKzVwdXlQdDhvVzZaSVpUdVN1bWcrc0tpUWY1V0RuRlN0?=
 =?utf-8?B?MVAxZE1hdlIxU3ZoSGJrUE0weGNST3FZc2RjS1k1cXhTWUg2cUJWL1JOTU9l?=
 =?utf-8?B?anc1UnNDZ2k2d3pyMkJzUlovaE44V0dyWDkxOXRReGdqWjIrU1d4TytIL0d3?=
 =?utf-8?B?Z0hCVVVOUEhCeTMxL3RlNGVKVER0NDFZUUYxb040eERDZnErYWlUTkY0VVZa?=
 =?utf-8?B?M2tXQ25JQmRLRFI1bUYzUXZUNWw2ejVIOW5SMDhCcCtZZUUvaHowYUJxRjR6?=
 =?utf-8?B?alJrdXNMWDlLVUJvWDM5ZlV2RjAyREJJWmZqTXdaZlRCbVRmMkR5NkIvcHgv?=
 =?utf-8?B?OGdDZmQ3dGhwZ1VjcEFoOVZjTDRQdWU0enJvdldtNmh5OTBTK1kyRXZJTUdG?=
 =?utf-8?B?TFFJRVlOVkFnUnBhK1ErcjNBS0V3SUEvNDNwRFF4c1F4WVFSRnpwU3lmaGJq?=
 =?utf-8?B?SkQ0dysxbTM3Q2tBUDFXUHJMTUtrZldMNUZjTVNTNUFZRzRLV3NDKzV1S3o4?=
 =?utf-8?B?YTBSQXJyOUEyajVMbHhveDRPNHMxVkFKZlN2TjBSWjUzeWdlU1BCS1h2d2Vq?=
 =?utf-8?B?S2FVSndjdFZZemlrOHZhdlY1RENXVlBoNENNa2taRW9iVWlXWnRtUjhBbUc0?=
 =?utf-8?B?SHpLVjdER3JkMXZFT2E5aXRlRDVZRldJaTZ3ZVdzaElRNGwxS0ltbFJ6ZGk3?=
 =?utf-8?B?UG9wMGJXT05GcEdYNUMxdTFDU0lwWTRxcC9Vc1M4MHJLS1d5V0tyWG1FZDdJ?=
 =?utf-8?B?ZityQzB1ZHgvVGpGNVhhOWxhblJMMm42UVh0Sy9QVWxKZUpQeWFpeEZ0NEpx?=
 =?utf-8?Q?EBEiHGX1qdC87Jy5C+Wazfaru?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec7cfcc-4ebe-4eab-610c-08dbc5ceaa66
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:12:41.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeSzoBoSWZ7Y5vjInDGkVlmA1F8yz2ha8eZ296sz/QyMxa4olsl25Utw8BKzj/9ptbi3mer9ab71cKN9fu781w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 6:48 AM, Bartosz Golaszewski wrote:
> On Thu, Oct 5, 2023 at 1:52 AM Dipen Patel <dipenp@nvidia.com> wrote:
>>
>> On 10/4/23 3:54 PM, Dipen Patel wrote:
>>> On 10/4/23 1:33 PM, Dipen Patel wrote:
>>>> On 10/4/23 1:30 PM, Dipen Patel wrote:
>>>>> On 10/4/23 5:00 AM, Bartosz Golaszewski wrote:
>>>>>> On Thu, Sep 7, 2023 at 9:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>>>>
>>>>>>> On Tue, Sep 5, 2023 at 8:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>>>
>>>>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>>>
>>>>>>>> Using struct gpio_chip is not safe as it will disappear if the
>>>>>>>> underlying driver is unbound for any reason. Switch to using reference
>>>>>>>> counted struct gpio_device and its dedicated accessors.
>>>>>>>>
>>>>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>>
>>>>>>> As Andy points out add <linux/cleanup.h>, with that fixed:
>>>>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>>>>>
>>>>>>> I think this can be merged into the gpio tree after leaving some
>>>>>>> slack for the HTE maintainer to look at it, things look so much
>>>>>>> better after this.
>>>>>>>
>>>>>>> Yours,
>>>>>>> Linus Walleij
>>>>>>
>>>>>> Dipen,
>>>>>>
>>>>>> if you could give this patch a test and possibly ack it for me to take
>>>>>> it through the GPIO tree (or go the immutable tag from HTE route) then
>>>>>> it would be great. This is the last user of gpiochip_find() treewide,
>>>>>> so with it we could remove it entirely for v6.7.
>>>>>
>>>>> Progress so far for the RFT...
>>>>>
>>>>> I tried applying the patch series on 6.6-rc1 and it did not apply cleanly,
>>>>> some patches I needed to manually apply and correct. With all this, it failed
>>>>> compilation at some spi/spi-bcm2835 driver. I disabled that and was able to
>>>>> compile. I thought I should let you know this part.
>>>>>
>>>>> Now, I tried to test the hte and it seems to fail finding the gpio device,
>>>>> roughly around this place [1]. I thought it would be your patch series so
>>>>> tried to just use 6.6rc1 without your patches and it still failed at the
>>>>> same place. I have to trace back now from which kernel version it broke.
>>>>
>>>> [1].
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git/tree/drivers/hte/hte-tegra194.c?h=for-next#n781
>>>>
>>>> of course with your patches it would fail for the gdev instead of the chip.
>>>
>>> Small update:
>>>
>>> I put some debugging prints in the gpio match function in the hte-tegra194.c as
>>> below:
>>>
>>> static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
>>>  {
>>> +       struct device_node *node = data;
>>> +       struct fwnode_handle *fw = of_node_to_fwnode(data);
>>> +       if (!fw || !chip->fwnode)
>>> +               pr_err("dipen patel: fw is null\n");
>>>
>>> -       pr_err("%s:%d\n", __func__, __LINE__);
>>> +       pr_err("dipen patel, %s:%d: %s, %s, %s, match?:%d, fwnode name:%s\n",
>>> __func__, __LINE__, chip->label, node->name, node->full_name, (chip->fwnode ==
>>> fw), fw->dev->init_name);
>>>         return chip->fwnode == of_node_to_fwnode(data);
>>>  }
>>>
>>> The output of the printfs looks like below:
>>> [    3.955194] dipen patel: fw is null -----> this message started appearing
>>> when I added !chip->fwnode test in the if condition line.
>>>
>>> [    3.958864] dipen patel, tegra_gpiochip_match:689: tegra234-gpio, gpio,
>>> gpio@c2f0000, match?:0, fwnode name:(null)
>>>
>>> I conclude that chip->fwnode is empty. Any idea in which conditions that node
>>> would be empty?
>>
>> sorry for spamming, one last message before I sign off for the day....
>>
>> Seems, adding below in the tegra gpio driver resolved the issue I am facing, I
>> was able to verify your patch series.
>>
>> diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
>> index d87dd06db40d..a56c159d7136 100644
>> --- a/drivers/gpio/gpio-tegra186.c
>> +++ b/drivers/gpio/gpio-tegra186.c
>> @@ -989,6 +989,8 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
>>                 offset += port->pins;
>>         }
>>
>> +       gpio->gpio.fwnode = of_node_to_fwnode(pdev->dev.of_node);
>> +
>>         return devm_gpiochip_add_data(&pdev->dev, &gpio->gpio, gpio);
>>  }
>>
>> Now, few follow up questions:
>> 1) is this the correct way of setting the chip fwnode in the gpio driver?
> 
> You shouldn't need this. This driver already does:
> 
>     gpio->gpio.parent = &pdev->dev;
> 
> so fwnode should be assigned in gpiochip_add_data_with_key(). Can you
> check why this doesn't happen?

I do not see anywhere chip->fwnode being set in the gpiochip_add_* function.
The only reference I see is here [1]. Does it mean I need to change my match
function from:

chip->fwnode == of_node_to_fwnode(data)

to:
dev_fwnode(chip->parent) == of_node_to_fwnode(data)?

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib.c?h=v6.6-rc1#n767

> 
> Bart
> 
>> 2) Or should I use something else in hte matching function instead of fwnode so
>> to avoid adding above line in the gpio driver?
>>
>>>
>>>>>
>>>>>>
>>>>>> Bart
>>>>>
>>>>
>>>
>>

