Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0287D7B7288
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbjJCUc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjJCUc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:32:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD05AB;
        Tue,  3 Oct 2023 13:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myswKUepo/66hCWQZEH5ckgj/6y+ALmmBrpWzaB+zcN773qJ7UYHYRWwN1Whbau3ST6MGF6p+AaYTVZmO92RHw+psfRCN2VH1uF9rztnfswG5NhV17LT58d7DZ2TH+Voca4WhOVBjH1kax3MQgHIBJOoIeAl6NHHCiwDWiLzssYPOoFNIF2Ugy2DCIQi4a7fQ5XzsCqxV2F8Oz6eE0C+3U1uiE9Heb7FoPteHZDFPkI5FXhWOx8gNF5+n0H/aWz5eAUfuKqW0t8QwMu8HsMcny355VGiy5yb30RhAFJQbJZukdh7896UDORPxVcmsdKGgJM8+HC3P7dTRHDOfnlD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xm0JN9+6pP7IhHyPY0ktK+HTFDIisQCk58vU5IxTGB4=;
 b=n8WjlRtRp8FH/t7oLQBpxSEs+r9AAkU8QtSqg9GsvLQ88TsONB42uNA1soYVSROLvIwNR6tOQW/cZkMs9vIr0VimFAr4GTPxITpV8ohcCFZWhUsonc25sYYZ2Su/bHSAAuzFBvnwbkblhrKMu3AVnMbdRLf4XSsQTcrPYxjzCDoiG8uJMvOC6cEafiZKmy6z6Sp00WPPrG7Kad5AaOOE/wByDGQS905/8Q8SJXXEhf2bNa107n6uU+fuFDQe4PT72tDaGuwz69o2Bukp0c5SwEKTTVuvXxI6tpcGUXCRyEPIjW5mvnafi6fs/KF9CV2KSyw4dQFV6IFWapUpdKT2pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xm0JN9+6pP7IhHyPY0ktK+HTFDIisQCk58vU5IxTGB4=;
 b=Htlmr/7lFl4ahyQQSuYb78IsodmzgQGy5NMhGHDodmRg3n6F4jovgX9vYXkZLr5cPy80INY3uQWpcaaZOEbBpP5LvLylRUu6IWg8CBxfFVwFpQqsj3A6GfTHNgtCu5c5aeZHxXfORP6/ObZdk6fhhuYn1EKiPypvOf2fbuop2xCwvE8Rf54Wj+wFoagLgVC0ILtYiH1s2lPZVq1cziJsC8OtbuhBuZOKf49IuF1KWz/ep/xu/p8Qewj+g4Cn8u9p4Skqc7tQzxZ+h/WC0kwllYCpwudG1TLVflY4BwDXkFid5OMS9Ysq46jm7BzrZkJjaEwKL69g7Yq5nzvBkl/urw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 20:32:17 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6838.016; Tue, 3 Oct 2023
 20:32:17 +0000
Message-ID: <251de70b-5f70-5ec8-cd94-17d030be380f@nvidia.com>
Date:   Tue, 3 Oct 2023 13:32:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 07/21] gpiolib: provide gpio_device_get_base()
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
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
 <20230905185309.131295-8-brgl@bgdev.pl>
 <CACRpkdbdcPv1LHL2W-enKBJ2OARpduoOJkQ64oL6GSOfmmD3qQ@mail.gmail.com>
 <CAMRc=McSBBeHi5jDVYOF6s1etfQzYRNLo25LeY+DWG_2tEf7=w@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAMRc=McSBBeHi5jDVYOF6s1etfQzYRNLo25LeY+DWG_2tEf7=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::26) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ea804c-c456-4457-5850-08dbc44fd5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLyoRdsKNF9L4lP0efwNjIjltnaNqvmu/HcpKudT92fXPnYOqHqz4B0T+nwiCuY0IQmMML5dahEPgQ/4HQv9vr7LhH1llgIYie9pRrm5FdLDMA4u20f/HiTB7kylXNBGtc8GdYNmf0wJsiNDRLFtGKguk1swnLyg/r4tvr8RkLdC9/41AbSUGhPHmmCWRVxXA7f7EgGgLWImLQziII3EXdq02L6C4JCcfBgka3uzsS9wD4fOHGpSoMjT06XS26lYKGDOZaxzK2GieICZoMJtF1po1YIxUVPsHM2nsB9hn8GzaebmEYCoQ1X0q4pFcVFjk3S3/ZnGX8f0tCq7nwEygPrkvMHW6CASEqp1bMSjJye53/usQhiaDerQnGgLelHpyVk4hYpgwGso1X/h85IQ10puq9alpnPCopmV/kn1hP1ytMhLWEscaJOercUE1DkAPuP2E9vehYYI+ZcvQwBeAOS6vUb/Ed3JXrk0p1mx9S7T5hG4vnz6ThRZBZiK4zt5bT55DQlV1BIbK+lw2hUsJFSYABPQ3WTjiMp5dx8WWg6eYtrTYs2oTt2J6nOlcpMJlIK9NFbrDDAnRghoGlRfuGG2pOp68JfGwkfCVQ3HMeWToJUYT7zTB4A0z63cOh0fXjYehpJs647In02DfaMPIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(478600001)(53546011)(6486002)(6506007)(6666004)(26005)(2616005)(2906002)(316002)(6512007)(7416002)(83380400001)(8676002)(4326008)(8936002)(66556008)(54906003)(110136005)(66476007)(5660300002)(41300700001)(36756003)(66946007)(86362001)(38100700002)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUxWbTF0Z1RZbmlHME85cG5aNGo1cVhHcmEwZXd0T2pPWWp3YkdyM2t1a2Np?=
 =?utf-8?B?VWthcG5hM0lVbHlXU3dtUktRbDU1QTUvUVROcGI1eWRxNDhrdEpjRGQrRDdH?=
 =?utf-8?B?UEN1d0cyMldWMThmL250SjRaTENvWUNnckdpY3o1UXFIUjQ5enhFK2xFZ1dZ?=
 =?utf-8?B?R1ZWMkVYeVJOVDUxMlFTWWNmQVJuUFNrODUydVN0VXd5Z0tScVFDdmhaa0xV?=
 =?utf-8?B?L2ZIV0NQL2FGd1Zhd0NYT3RvdlFYTC9IUmE3NlAvK2luSGdHWk5MdEE3NGph?=
 =?utf-8?B?L05qd0lEZU51Q0x0R3QwY2N4bU12VlljcjdnVUdKM2lybW9wc2R2QURGamlQ?=
 =?utf-8?B?bnBGekVCNWxwdXFRaUJZYWt3OGEzOUtzdE9oRmxITVMzQmowR3lYdjdqeGoz?=
 =?utf-8?B?a2ZXVXEwc2Q0TWFVRUNoRE56ZU9LdWozc1FzUEZTTTZZNWZ4K0pVYjcvY1BF?=
 =?utf-8?B?T3NHMnAzRTQxVWZ5Q3hqZVcwck9XekVHaFlkSUNSVHBRdTRCSE9XKzFSOW5V?=
 =?utf-8?B?bnFhcDdKSm9iY1BydEx1YzFwMlRndENCR2pnN0NoaWp6ZndVd3Irb01Vb0dr?=
 =?utf-8?B?WnpHL2xPbGVzSkNpR1UxUXVMVlA3S1NQaGsrSkFldVdrTUxSV1diR2ZuZC9W?=
 =?utf-8?B?dEdOWjBrLzZycGJaYjdUeTNVUjEvU2xMeEtMUks4RElTanVrQ1ZrdlRuLzUw?=
 =?utf-8?B?dmd1ZU91TGo3dlp6NCt1Wmg3VTdONVBybGtBbWMxbXd5YVJFTUdndWd0ZFQx?=
 =?utf-8?B?QU5xekg5KzM2OEhWUUNCV1VTK08yOFFaaGd2REhjaHBmQ2Y1QmV2YkhBaW1L?=
 =?utf-8?B?d1hkUXFzOTc4TDhpWnJWaTZMWGtOZWFLVzlXSzRVWGt4aGFjalFjaS9XN0tU?=
 =?utf-8?B?bjJld0V3SFVPVzFhL3pYcVdINlVOKzFoMTh5NGovblh3ZnIrSVEyRVNxUi9w?=
 =?utf-8?B?RW5VQk9NTjgzNzV6WVcvYUV0RnRMK29aeWNLVTlKY1V0VWQ2WkI2MXUycUlX?=
 =?utf-8?B?dDU5ZWpHRFVXdjVyRG96SDc4cmxFbjQrV1dKSGg1WDYyMmZkT3RNbzEwMFRR?=
 =?utf-8?B?S04zM1JpbHFtenN6WS9uZDBDdE9VcnNRN2QvWURYb1pzTUgxVUxSS1gweDFL?=
 =?utf-8?B?UHBRUWdtTGxKemZ0b2l4NDVEd2VhYS9JWDk3UmRFaWFVQ2x6YVF2elZ6Rk5i?=
 =?utf-8?B?bnpqRStVNGNVd3BRZTNyaU9meUFRK0szSGphSG5PZkEzcGErWjZ5ZUtFZ25B?=
 =?utf-8?B?Tnp1R0QzMDBGY3RSc3NTZllPcFYvVVRpR1ZnSlVFUXFnYW5aRzZFTkcraXJt?=
 =?utf-8?B?Ui82Umg2WkRUTkZBR3FUZTZ4NE1GWXdnZHJiOHMwaE52c1ZTNERubG9XL3VE?=
 =?utf-8?B?RFBPRlZpUjIyM1hucURPQXVMMEVVVlVreVpiSVpXeC9mZnIxekd6U01YUjJ5?=
 =?utf-8?B?WXB0ZGJSNGRSUVZXb1dvNlhQTTZ6ZzRWSllkQTR2a1U3Q3RQak5uZ0JtakJ6?=
 =?utf-8?B?Q2ZPL3ZPK3hZMjRZSSttZ01pOCs5SnoyaHlwQ0Nmam96RXdLb0pJVmJ0Q0VL?=
 =?utf-8?B?UkNHNE9HQlZ6a2orMEZTRVhWYUJ0RlJNZDkyL0NTOVphL3p5Zzd0RWRHZVNZ?=
 =?utf-8?B?TGFFWjFsdjl6cTNLRm9oeXd3ZzNPYTBINWZqcmppSmNvTS9kL1RzenJybUR2?=
 =?utf-8?B?YXk0WlN5dzBqeGZJVkZzQ0JKWUREeENxOGcxQnU0bFZ1dk9hK0Q0VGFNd3Mx?=
 =?utf-8?B?Wm9uT0RaWjZ6aUl0N2ZOd2hZbUtrMW1vdWZLaElWV0ZEVDZvZE9LZElBc2RD?=
 =?utf-8?B?YUtXb2REUUx2ZjlpU1YyRTdDdTNXYkJxWi9CNFBybGNZMmlvZWYzTHo4aUc0?=
 =?utf-8?B?ZUk4K2M0Rjg5Sm1wb050UHJ0RXNPVEVjdWpiYnluVi9HVGlYUjFKay9LamJT?=
 =?utf-8?B?T1FXcllLczJndldUVS9TZDhlanhRL3Iwc1NpaFE3U2hlQ1prZThPb2tLZ3d2?=
 =?utf-8?B?OEtYeSswR0YyUUtlRjIraWlSMWNId1c2TlY1OFlmYVNHQTNVS3FVTkdodVNo?=
 =?utf-8?B?RHZvd2tLck1FdFBRcGE0biszbDlMa0N0MXVZODhXK0RCUnp1VFBUaXliRll6?=
 =?utf-8?Q?peJFGOxU2iPGyEcJLkq2hBLCg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ea804c-c456-4457-5850-08dbc44fd5a3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 20:32:17.1197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcXATqTBnhz1H/wybPGtk7m/+hAFGuXuct+fH++8eU/+ogIsiCz5LftVzuRiIbiBMkOh9VEJsOOMupsYhF6DqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 12:57 AM, Bartosz Golaszewski wrote:
> On Thu, Sep 7, 2023 at 9:17 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> On Tue, Sep 5, 2023 at 8:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Let's start adding getters for the opaque struct gpio_device. Start with
>>> a function allowing to retrieve the base GPIO number.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> I guess you have a solid usecase for drivers needing to do this
>> crazy thing, because I suppose you feel as much as me that
>> this should rather be gpiolib-internal and confined to
>> drivers/gpio/gpiolib.h?
>>
>> If you add a valid reason for making this globally visible outside
>> of drivers/[gpio|pinctrl] to the commit message I guess I can live
>> with it because we need to think of the bigger picture:
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> It brings to mind the now confusing "base" inside of
>> struct gpio_chip. We all know it should go away, but since it
>> is never used during the lifetime of the gpio_chip - or SHOULD
>> never be used - it should rather be an argument to
>> [devm_]gpiochip_add_data( .... int base);...
>>
>> Maybe something we should add to our TODO file.
>>
>> Yours,
>> Linus Walleij
> 
> For this series it's the HTE driver that uses it and I don't have a
> good idea about how to change it. Dipen?

Missed responding to this, apologies. I believe we are having similar
discussion in the hte only patch. We can continue discussing there.

> 
> I would also love to make pinctrl not use the internal GPIOLIB header
> so it'll be another user, unless you can figure out a way to not use
> gc->base? :)
> 
> I think we're stuck with it for now.
> 
> Bart

