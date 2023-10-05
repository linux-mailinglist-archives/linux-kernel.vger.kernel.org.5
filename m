Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106CB7BAA88
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjJETns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjJETnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:43:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0356210C9;
        Thu,  5 Oct 2023 12:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebLpMK2lkGRD5FYMGSWR4QNACkVzAMwu17qzc/odQT6FV0m22ufsuuSeNT8IOU9y6i0yq63LqX1y+Mw3eD5A9uCxEn46pkwzLSco7ga4at3/htBE/9P4mAxc711gvdqx3pE6zg7jaKKFSwOUgbga5+ud3Ljp5g2z6LH0W5UcRx9sXT4iB4qXf9tCUMXExnjAuEw5Fw/jsei3LzQCTCt1zWrSyvS23pa0MgjVPn0jLyM0NQhCuJ00Q/SERqDV6Xq9T0zq0X+1XSs1iqg4AtTJPDvDVix3Ars+1GmBJHaLLp8jJeRXvmTePK82wCK+hu0E7xQNMYtH7EPAPN6TaDzBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwXykzB2lS5hcIeQ4Zaz6Eow+4vmZV1sOM21EX03O/w=;
 b=DNFAvCWLEnQNpymMlO8DFD9GsH8JRaVX13wTglQ8YhOWHSsaPpzYj3qyNuwOr9t0+SGgQ9Rnxr3u5xuXMHAR0jfTnMB8/QBgJfJkt0wn8veA3Mf1NymcQaco91g1/eVcfAiBjvsr7oUpkQUoUb8n+v4OmeGueW3IcQXUjWwD4sk4U6YytMr9dw5/+YqmEDPAZSKrDkEY0H+OKZubWlgAwtaVGhwCCfwWz52fOQ2Z48JOIHK+UZMNXBKGvjvLDHOCNhNZlttQG8PI/4u8Y71whXTo2ypKDCstOX+HLOziWFcuZTxcW18p5ig/RqWM2gdRPzHqumZ2zFBB1SjYKmsK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwXykzB2lS5hcIeQ4Zaz6Eow+4vmZV1sOM21EX03O/w=;
 b=hBsxdDm9iuobXocWK5ERuTFl8ziBwyj96Gb1AKRJyS1TnW40PAl+GADUvvxh+XvY9XyTwsQbjt5H57axT0gmENkljt7zjx8DKtfyN18btq1WDc0g/5TT1heMk5JvrRIRx8//0iJo6FTb/wmgpoKf5y7QoGtOCGwly6AOShq6kc0RzWw/xHVcO+RNFMvOzYdAPyIm9TlfQd2x/pkWq3xcYHB1ENeoWanHU+0bOSm+43EpGEA+sthjY/AGtAY4PCGm30P90qJdOQ2ECFW7QZqygWG54a+fBFYbhA/J6AARQQ3IfW2CMFGBhLeX/W9RxvoB8vl5jcOD6TDggg9lOYVZhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 19:43:17 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6838.016; Thu, 5 Oct 2023
 19:43:17 +0000
Message-ID: <b0f37601-39d6-618e-fa16-3b1c9e7c0e2c@nvidia.com>
Date:   Thu, 5 Oct 2023 12:43:13 -0700
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
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAMRc=Mc_+LxcbV+=KPwAh4DinJAAetHrK+W3jbNp4AZBzg63TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::31) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: af5a77e3-2b70-4a46-9a00-08dbc5db526c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhwe9+2zC6GHVnBBkI7lHdnit5PFzC4ML11VZyZ8/KsdobSkOeIydlxU0skuxaUQKMv7VojJNYqpnWglUjldZWnuis09TXDzjhHaWzrM6lFsOkiDt/f+KlVCTnQ07/ivGUsk1YLGZedi9FYjbWjhURt8GcHHAwQo1jOUgeUOiPe7q2vAb40cZ/zl6OC8jkLbHhdJPaBc+Qb5maJ392tE4USCw81u53inGUk5ODAgQs/IeaBZyFYBuLdD+5xwDqoPqsjihHaqinJQeKzdBTEzg5iyhN9gxQPo5x87Fc7FoENTrmtBXWOpVKYvrcjTArqc4uUQkidC3k3pPx95xsz+ffuQrCuoeK/8sVb4vsuiaLaOO95fusdVVpRCQov4FLWz6hzRbiqnhvFy3HLpOdDMXV0cvndFHMGdUGqg6hcfL+C84xKLP+rFUkiRn/jyT0of6/Kk3gCISdAVcX15GGMlwyqcPoRqXMLmg5hN3bK7+iSmymJ8Ch1F7ZCN3Jb0/9GTRf7AAgNm3ROLceJKPX8Xt0rvn3ptJVMsVZkK0yqZKSFXzw9IStip8ZFHrylOT9bCaylaFvVwpzdJ5nBb/hMym+mU44k2TCLNu5GPiE0qfIrhveU8XYhRtpXCfNPaUWZWt/+Bx4kp5tds7L5//EeRvSkl1W//y/k0viSUY2GLjpceJ8YfwjBqWLyg+mG1R5sq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2616005)(53546011)(6512007)(6506007)(478600001)(6486002)(966005)(83380400001)(6666004)(26005)(5660300002)(66556008)(4326008)(7416002)(2906002)(66476007)(54906003)(66946007)(6916009)(8936002)(8676002)(41300700001)(316002)(86362001)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWwzWDczanlZZTVCR0syaUZQRnBJemErWm5XYm9WYjBjQ1A0b2hJNExtS080?=
 =?utf-8?B?bG91Uk1qME1xY2w3SUV0cUZXQmVmLzh5aUMzSGRPb29HNHVjMDJjeWRZT2lR?=
 =?utf-8?B?NDJ6dHUwT284bDFYQjI5aFJQeFlEMmxZOXN4bW5YTFV0clFVTmpnUlJZcTly?=
 =?utf-8?B?djFNWHhjYlNLL20rK3dmZzRIYXFURmFpbVBUemhPYTdUM3p1S3FCUmdQaUpY?=
 =?utf-8?B?OHB0Z0xCUU9iT0U5WlNRVlFERFJsNDc2NkczbCs2Rk9weVQ3S09GTGJNU0hU?=
 =?utf-8?B?cklISHp1bmNSRjViLzJvQ1ZEdncrVXMxUkFLV2pQZGJRbkJSeWRlTUlEOVFw?=
 =?utf-8?B?ekx1UGRiQlBsQnlsa1Y1UWhiSFFMWVJmVjdXd3dpQlh4RmNZWmxtVDdLRm84?=
 =?utf-8?B?d1NyMFpvaFFkb1kwOG1TTm93L1YvS0NERTFDZm5jTEM4L3A4cWlCNmowd3FD?=
 =?utf-8?B?Tk5KNjVza0RNN1R5YUQycjE0VEE5ZUZhRXVzVng3MFRmWEZUMlRxOGFGTkU2?=
 =?utf-8?B?R0YxZnliMlpPY0RxcXJvT1V1MEw5Qi9DQlhxVm01YzFDUndhRWtmWTlkNHU4?=
 =?utf-8?B?SCtDQVhxb05HcHpmenJaam9ZM0R4MmJmOEFMTzdBRFBpOWNXMm1LWVlobm5z?=
 =?utf-8?B?Zzh6QWRYT295anNLSG9HaG12c1pvRUU2SGVBSnU0ai9KK0lwYmlWRXV2VnZE?=
 =?utf-8?B?VHU0Z0o3MGRNeVlta3VHVGZmK0h5NGhoSzdsTTBJSERPeitLQUFLVFpvZSty?=
 =?utf-8?B?UmY2SWlETnNYQXpBZTJkTVlPRWNiN1kyOTEwSzM5Vmt6YUdDcURlTHBSNVZO?=
 =?utf-8?B?L09FKzY2QktMOFVvbXgxR2d2SnpwSzA5L3ZiSWpYc3oybXZyZzd4R1BZNFM0?=
 =?utf-8?B?SzViTU5xZ2ZKTVRUQ1BMaXFnVUl6R0xha1pVMFJBL3JwS1E2dDhzODBqY1Z1?=
 =?utf-8?B?eDVkbmJjL3hNbC9VeVNMc2tPTG9KNGFGNHpDa053Skk2SXJIZFFaVk1pSnZC?=
 =?utf-8?B?MklwM2FsVjdsNzUyVlZ1cVFxQzRlTFNuTnVHcDE3MnNCUDBhRTVTRVdzSUp1?=
 =?utf-8?B?aThodnhXVGRyMkplUUhmekhEU1NmS0NnZEV4NVBvczg0MVNUQ2JjUUFZajhH?=
 =?utf-8?B?RTFHeEdDdmRFMElMbzJta1JQR1lwamNSS1lIS3haMHVVSDlia3ZSN08zZGp2?=
 =?utf-8?B?empWa1BYdGJzM0NLNjNZVmhUVTQ3bnZqQWJnZmNoL1lNdW04bkhzaldZNWRQ?=
 =?utf-8?B?aStaOUo4QU1OU2FpRTFwNURYMlFlVzNjRzdCaEcxSnV1TllhbzNhdTI5TG0z?=
 =?utf-8?B?OE9Gc09yMlJmTTVDUEMxdHNPQkVUQ2JQM1huaGM0UStWRFcwNEpPL2JzZldE?=
 =?utf-8?B?UVF2Zm5iRkI5QVdtcktjQTZZcERubTVjUWowTEhMcnlzYXZ3UXVFTVMyL0RE?=
 =?utf-8?B?bjNBSGw0cFpnb3k1ZFUzNGF5Q1dsLzdrcTY0ZWJ4RGlETGxsRFlwVjIxaVhV?=
 =?utf-8?B?LzFqc0QrS2ZkQ1o4OG5hVTMrSnpGbnVMOFl3OWgxa01pZ0EzbmlxSS8weUJM?=
 =?utf-8?B?UlRweEE1cGVjR3FLN0NYaytuVkdDOUx5RVRabnFHNG9LanFsdzc0SSs5YkxG?=
 =?utf-8?B?eEl2b2ZzWXMxZVRqYzFNcUpEM2ZrZ2N1OEFIcytSbUpUVzBwMm1ydVJQRXBE?=
 =?utf-8?B?OWdsaFczWjFBRSs2SzArZHl6WEVVODVrbHhidWhzbngrZk9CV2JEZSsxQTNk?=
 =?utf-8?B?bHl5TmMzUVBMWi9tWWY3cUh1WGkySFdLczBCalZ4cHBwVXJhNVNjcUN5dFN0?=
 =?utf-8?B?aTI3eVlEZEVrYnpXME1MRC9FQ0tma0xvQXRIRDdCUVBGTTIvcGJmM3dJdUQr?=
 =?utf-8?B?U2tiS1lGNW5xMVRXM3dCN2E2bkNzR09QNGVzVUs4ajV5YjZ6ZGhScGM2Rlky?=
 =?utf-8?B?d1FpNkUwNmoxa1lzT1BpeEFJMXJxTW9hb2IzSVZFWnBpMzR0VFRqNCs1bE5I?=
 =?utf-8?B?dURJL2VUeXh0VFJHaEZUREpBNFc1TVpEQStxSjY5R0VxWVdjbjZSMTdNREl0?=
 =?utf-8?B?T2syYkNHV3hoZWFoTjlIREZZdjJoUERWQ1NkQ0g2WE5LdklQaGVXdWhwVzVG?=
 =?utf-8?Q?rJY+wmBiwXu1YDjgD+XbpNd5k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5a77e3-2b70-4a46-9a00-08dbc5db526c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:43:17.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zefR97HakIpkxEAGG89xix0NcSfRG3Nx8oUjDbb8kePHKZVj1qdEw+5/eOEyBctJOwKc2fzn7trHfPYjrGjonQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 12:05 PM, Bartosz Golaszewski wrote:
> On Thu, Oct 5, 2023 at 8:12 PM Dipen Patel <dipenp@nvidia.com> wrote:
>>
>> On 10/5/23 6:48 AM, Bartosz Golaszewski wrote:
>>> On Thu, Oct 5, 2023 at 1:52 AM Dipen Patel <dipenp@nvidia.com> wrote:
>>>>
>>>> On 10/4/23 3:54 PM, Dipen Patel wrote:
>>>>> On 10/4/23 1:33 PM, Dipen Patel wrote:
>>>>>> On 10/4/23 1:30 PM, Dipen Patel wrote:
>>>>>>> On 10/4/23 5:00 AM, Bartosz Golaszewski wrote:
>>>>>>>> On Thu, Sep 7, 2023 at 9:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>>>>>>
>>>>>>>>> On Tue, Sep 5, 2023 at 8:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>>>>>
>>>>>>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>>>>>
>>>>>>>>>> Using struct gpio_chip is not safe as it will disappear if the
>>>>>>>>>> underlying driver is unbound for any reason. Switch to using reference
>>>>>>>>>> counted struct gpio_device and its dedicated accessors.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>>>>
>>>>>>>>> As Andy points out add <linux/cleanup.h>, with that fixed:
>>>>>>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>>>>>>>
>>>>>>>>> I think this can be merged into the gpio tree after leaving some
>>>>>>>>> slack for the HTE maintainer to look at it, things look so much
>>>>>>>>> better after this.
>>>>>>>>>
>>>>>>>>> Yours,
>>>>>>>>> Linus Walleij
>>>>>>>>
>>>>>>>> Dipen,
>>>>>>>>
>>>>>>>> if you could give this patch a test and possibly ack it for me to take
>>>>>>>> it through the GPIO tree (or go the immutable tag from HTE route) then
>>>>>>>> it would be great. This is the last user of gpiochip_find() treewide,
>>>>>>>> so with it we could remove it entirely for v6.7.
>>>>>>>
>>>>>>> Progress so far for the RFT...
>>>>>>>
>>>>>>> I tried applying the patch series on 6.6-rc1 and it did not apply cleanly,
>>>>>>> some patches I needed to manually apply and correct. With all this, it failed
>>>>>>> compilation at some spi/spi-bcm2835 driver. I disabled that and was able to
>>>>>>> compile. I thought I should let you know this part.
>>>>>>>
>>>>>>> Now, I tried to test the hte and it seems to fail finding the gpio device,
>>>>>>> roughly around this place [1]. I thought it would be your patch series so
>>>>>>> tried to just use 6.6rc1 without your patches and it still failed at the
>>>>>>> same place. I have to trace back now from which kernel version it broke.
>>>>>>
>>>>>> [1].
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git/tree/drivers/hte/hte-tegra194.c?h=for-next#n781
>>>>>>
>>>>>> of course with your patches it would fail for the gdev instead of the chip.
>>>>>
>>>>> Small update:
>>>>>
>>>>> I put some debugging prints in the gpio match function in the hte-tegra194.c as
>>>>> below:
>>>>>
>>>>> static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
>>>>>  {
>>>>> +       struct device_node *node = data;
>>>>> +       struct fwnode_handle *fw = of_node_to_fwnode(data);
>>>>> +       if (!fw || !chip->fwnode)
>>>>> +               pr_err("dipen patel: fw is null\n");
>>>>>
>>>>> -       pr_err("%s:%d\n", __func__, __LINE__);
>>>>> +       pr_err("dipen patel, %s:%d: %s, %s, %s, match?:%d, fwnode name:%s\n",
>>>>> __func__, __LINE__, chip->label, node->name, node->full_name, (chip->fwnode ==
>>>>> fw), fw->dev->init_name);
>>>>>         return chip->fwnode == of_node_to_fwnode(data);
>>>>>  }
>>>>>
>>>>> The output of the printfs looks like below:
>>>>> [    3.955194] dipen patel: fw is null -----> this message started appearing
>>>>> when I added !chip->fwnode test in the if condition line.
>>>>>
>>>>> [    3.958864] dipen patel, tegra_gpiochip_match:689: tegra234-gpio, gpio,
>>>>> gpio@c2f0000, match?:0, fwnode name:(null)
>>>>>
>>>>> I conclude that chip->fwnode is empty. Any idea in which conditions that node
>>>>> would be empty?
>>>>
>>>> sorry for spamming, one last message before I sign off for the day....
>>>>
>>>> Seems, adding below in the tegra gpio driver resolved the issue I am facing, I
>>>> was able to verify your patch series.
>>>>
>>>> diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
>>>> index d87dd06db40d..a56c159d7136 100644
>>>> --- a/drivers/gpio/gpio-tegra186.c
>>>> +++ b/drivers/gpio/gpio-tegra186.c
>>>> @@ -989,6 +989,8 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
>>>>                 offset += port->pins;
>>>>         }
>>>>
>>>> +       gpio->gpio.fwnode = of_node_to_fwnode(pdev->dev.of_node);
>>>> +
>>>>         return devm_gpiochip_add_data(&pdev->dev, &gpio->gpio, gpio);
>>>>  }
>>>>
>>>> Now, few follow up questions:
>>>> 1) is this the correct way of setting the chip fwnode in the gpio driver?
>>>
>>> You shouldn't need this. This driver already does:
>>>
>>>     gpio->gpio.parent = &pdev->dev;
>>>
>>> so fwnode should be assigned in gpiochip_add_data_with_key(). Can you
>>> check why this doesn't happen?
>>
>> I do not see anywhere chip->fwnode being set in the gpiochip_add_* function.
>> The only reference I see is here [1]. Does it mean I need to change my match
>> function from:
>>
>> chip->fwnode == of_node_to_fwnode(data)
>>
>> to:
>> dev_fwnode(chip->parent) == of_node_to_fwnode(data)?
> 
> No! chip->fwnode is only used to let GPIOLIB know which fwnode to
> assign to the GPIO device (struct gpio_device).
What do you suggest I should use for the match as I do not see chip->fwnode
being set?

> 
> Bart
> 
>>
>> [1]:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib.c?h=v6.6-rc1#n767
>>
>>>
>>> Bart
>>>
>>>> 2) Or should I use something else in hte matching function instead of fwnode so
>>>> to avoid adding above line in the gpio driver?
>>>>
>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Bart
>>>>>>>
>>>>>>
>>>>>
>>>>
>>

