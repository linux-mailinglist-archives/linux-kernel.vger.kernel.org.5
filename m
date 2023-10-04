Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376607B8E14
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244960AbjJDUbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjJDUbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:31:00 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E81C0;
        Wed,  4 Oct 2023 13:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYudkx1lNsquYRIOHFzajyp69KiqWD2TffudrmvdLijp30NhyWbBj2Lc0GfSFXWmxranJm4PIMPm9h/3bgPFS+E4NNgSNpebopPd5eIybfzEZUCYE/pwfpiUaktJoPVMc4mrowQfu7baNZphaZ2BlouBoFXbAEKjZhMuIXCSLgeYlhi7R+OhJW7UpqctaXmGA+5Zc56BcIGCHqS++JP4sMw6koEYpS37pAHXmQqyZSEmu+i9kKRNDUdgGLn8wAy4wiknq5idy/afD5iPU1yw2gILYjBna01pFZVvOV2GUPWCmZyeEkH7Wsrt0XwAADGi6SmCu3hSUUfEM4rMueItrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97zaEnmYqNbNvAeNJCxPDl2XugBg6KGr5wo3zUerAq4=;
 b=Y74b/8N8kpvEtKUo9MQCGu1GyaRm2ipeKfBTnXXK+gnOD5ZFEysH8k4ALM9Tf8pzbOvq6TkJrXRWK8uhW9l/B0eNj+JZ/CPUYNTyln4uhlLcDjiDP4cDfZzIVlJiVOjH9ihR0cX7zZDsFGEf4TDv7iF0A+tt6T53lkv+kaJNRR5S+Iifo82J7AxETjC4qvDSae0VMocsyWukePtvoCSceHeLIEIrPF+RE+KiK8PBL4hlOeJMDvVT1ClRJbwyoU/YkIhSXJajtmp2FOCMXzvWpM9c3a2SZaOvIWxtchhi2aE0Bt7KY2tEa/OmLDpjey7zJmMdJT+49cwkCgKqraIHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97zaEnmYqNbNvAeNJCxPDl2XugBg6KGr5wo3zUerAq4=;
 b=m3SbrrK3rR/UyAAE1Ksu32k8dFzQurfE2SWt2H2k7tyzR2km6mk0aPBbwqk4KlrhfQjltzQAqCtf8qQuc4hin8+F2H4bxNLUDpG6RdbubsQtQG9QFwng5pMIWKaPg9L+hd+M+JtDDjdeucAr3olbe3yAL9FsilK599xZyoq7u+w2P1pxne24cKcSte0Abld0sV74D/HJBjcFSbh08FXr90cgEhQt5Tj99gCrM+4hXEe0+jT0MLLD9dKMdmlbJ80hsNC4wvGdkZYpF7S9+ZbiK1jUjW5dy9AOLuCja0QP38Km48IZRDthkertoBzCOH3T2CClCGhU5XLPWLY+aH6aig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 20:30:53 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6838.016; Wed, 4 Oct 2023
 20:30:53 +0000
Message-ID: <36b17290-c643-8d8e-e82b-49afa6b34fbb@nvidia.com>
Date:   Wed, 4 Oct 2023 13:30:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFT PATCH 14/21] hte: tegra194: don't access struct gpio_chip
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
 <20230905185309.131295-15-brgl@bgdev.pl>
 <CACRpkda9=VULj4Cy_sit-UpUQnVEbS-RJKAeULVCw8ZCRTq1sw@mail.gmail.com>
 <CAMRc=MdTk1B4MEh9C624Upm_EcaQgJd9OU-AGfU0G-DU1+qk6A@mail.gmail.com>
X-Nvconfidentiality: pubic
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAMRc=MdTk1B4MEh9C624Upm_EcaQgJd9OU-AGfU0G-DU1+qk6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5815ba-b9c7-4984-64b9-08dbc518ce7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6C84CsY6dUi3gTg0Z9Y3b4r0gSdbHxUnhyLHGPUsobfETKYLnTxORMxM1qDI1VARn1VnDx4wWMmHnQWxkxFYGgEl8Cjm+UCb8j5nc5FUqruYwGWS2vvhYfF0F2V6lVGBzIHXJ2wdTA/Hdn4DxKM2wagTVaNnGeHwsWL/EQ7z2I2Hv0wKvIF5h7kPZ3q2O7qKuFjznGFWDvlG1pldDVRyVT69ug/cv9RziY28Iaa3CuH/jjIoUoKWNGYInrmUqhZvNEuRhHxGMPKtG0XBHs6nvuWV0iFNLuOVJx2yYpRPKestGwQ6u5QTgGomamvYplv/BErNz1jE5BtJ/a7pk5bhN38B3XxzsNt06n4IXQztQxC0YH1dzCxlDxS9LUKIsyy00UAujb6I8oRyudyGfgNH1JnR25u3EgwFJhWC8v/APoQq2NlTLuZ+oRMIXToUXak0D+qwJbflY5eddz59MwBG0VlLArdMIiHirVRBsaSUurKlHBhNi4f7Bhd5Nhn1iY1E4XQo69YHaKReUiM96pogpnlfu5KxpjZyxWCTvaQ52ZJ6GDgLosms88aO7gc9u71KEERofiBn9ZvIOZfKBEu2CipjUx7pMhv5YvdF9y6jlkumwm+XjruiH/BIZhKrnSThW4/KmWxLVSxdF+OKaA7YfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(6666004)(53546011)(6486002)(478600001)(6506007)(2616005)(86362001)(38100700002)(31696002)(7416002)(41300700001)(2906002)(83380400001)(6512007)(26005)(54906003)(66556008)(66476007)(5660300002)(316002)(110136005)(66946007)(8936002)(36756003)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG4ybHRBMTlzeC9GZzd0eFBNZ05YNy9PSkZLSzV0alJkS2VlSTh2S2NQeWVX?=
 =?utf-8?B?VUZjamErS0VSRGMzYWJYY3pVVFhLQlVsaXVSVDJ4M0QxWXNvU1dOV3p4TG9Y?=
 =?utf-8?B?NVlqdGJjRWdOUlVBbzZEZ3dMaTZoU3B5cTBsUEVGeHJoMkR1QTc0aGRYcDFx?=
 =?utf-8?B?aUlodVRTTlpQa0lqU1gxcTYyd3NOc3BTUURGU1Z1K3pBU1NsSHpqME9uRTFo?=
 =?utf-8?B?UWhRK1REV1J2STVpZ1lUSjFLL1g5b0NRRkd3UitxMkhRYzhQV0RWdGRnVm9L?=
 =?utf-8?B?YWcvZTlOOVIvLzRQcWFSS0NvQ1FCQXE0ZGtrWFFyZVJiRlQ2U2pRcWpFeDJX?=
 =?utf-8?B?eHNhYmhPVkh3Nkx3MjFpcDdlUzRDdGlBbzhRcnczbWFqdVRzVjQ5RGpVTjcv?=
 =?utf-8?B?cWRlTXovSk82alAvdWc5ZjJXYXBXa1JPNm1TZFBjSmJZNTRCTURQWm1JZWxt?=
 =?utf-8?B?SnE4OEp1ckhyMWh4YmFEcEZZVmxjKzVKdHZjOXM4RkZscnZCUU5LVG9ORHdw?=
 =?utf-8?B?RTl0NExMWXdVaGhGQ0lIZVZVZjFJc09tU3pPT2FySjdsODJ5ayszZWl0ajIw?=
 =?utf-8?B?R0xxWDVuZWlKUkRjOW9IT0Q5a1ZGUHppaTRzbkVFUHdnd2Mxd3FVZER2d24y?=
 =?utf-8?B?RUhKZFF5dTJtS3BHbDQ2czhIaVZTRDVvaXhjcGpOcFViWTNIa2JqN3dyK2Rw?=
 =?utf-8?B?WGNYU0NFb1I5UGpudTNPWkRuNUN2dGVpZXZwKzl4Z01ZN3VJQndaNStTNU1w?=
 =?utf-8?B?eHpJY280R3BqbkRweHFyNC9McXo3ZGcwRG9Jb3hobmZ0NUY2MDRvbURsQ2Rm?=
 =?utf-8?B?alFGakJoY29HMFdQdGhuTGJpQnlmcitMWGZMemdRS1ZaYkNwaW11c2FRR3FU?=
 =?utf-8?B?M0E4NWtKQmh4Ui9aMy9RT1VRdFczRDQ2dGRrbm9XRXVYWHlTZ01CMm5mam1H?=
 =?utf-8?B?ejVLdUlvNkNBMWVxV0tGbmNNWEdmb2VLWFY5dmx2WlJJRzVvYzNEZzZDNVdp?=
 =?utf-8?B?VHF3cGVIL00xODZTbXE3ajJUMXkvc1hkUXpTRDFhbXJ0SUhLSC96bnRrSWQy?=
 =?utf-8?B?UWZ1K1B5R0pWY2tkL2VKU1YyVmVnSmF6eThGZStCTS8wRkFjd1gxLzUvdEFp?=
 =?utf-8?B?Z3M5V0lNUjlXcUo1ZU81TWcvQ0xtVEdMOWxBemwreXNYbHc3RW1aeFlSMk1W?=
 =?utf-8?B?V3BsV21HVll5OWEvZmRTZEU0RGJPSzF2ZHhPdEVuTWZ0aGhMVDhleVM5ckdj?=
 =?utf-8?B?MU9nZEF0RWUrendDL29ZTXFWc3FOMkoyVkJ4UDNtYkVRbHQ2dFVCVWQ5YVJm?=
 =?utf-8?B?Qm9KOWhMV0FETGs2aks2M3pES0tKS2JtQXdzS1Q2a2ZiSkt4VjFZbjBmMlRT?=
 =?utf-8?B?TmZJSGZkU3l1U29BQzBtN1NPVEVCekZjTWVoMlJBSms2U3p2QmdqNFJqYmcz?=
 =?utf-8?B?d2twb1BuamF6U1NabXZpU3VYb0ZVdlNiN3hGdEFsOVE0b2MyMko1UXBGUldr?=
 =?utf-8?B?Q0NWZDhJSUxxYjJGUHJHTnM4NlBlZUd0N0dZRTFybmhYMlJXUVFLUjZPaEJt?=
 =?utf-8?B?eHp0ZWV6UUtlTkVTVEgveCtpNlRqLzNUWmwxZkZsZUVKRXBwRlJXc1FLbG84?=
 =?utf-8?B?RGtEbU1TaUNLeDl4b0Q5YStENWpKTjJGY3FzM3hGMHFxMCsyRDJEdGRNeFBY?=
 =?utf-8?B?dWJ2QWVIcjcxaTVHRzhzdVFUNHVST3BOOHBveFlWa3JkZkFHV1IyeXd5Vkpw?=
 =?utf-8?B?c1BFL0xSeEI4ZjMxckxzOUlRTlJVbGpPMUh3eUNUZE9nQUtXc0VGbWQ2OE9a?=
 =?utf-8?B?OXMwamtRZHBjVENRck01VDg3Y09hWWxueXpnUFpiUFZLby9yT0dtYnFZZlVE?=
 =?utf-8?B?WjRJUWRZeW9haVBSVmhtVUJRbmJTZzA2SS9OdG9yQ2twV1E2cDdEUjZSV2Z4?=
 =?utf-8?B?bUR2M2loYzJXaEsyQkJVSUovYXFNYnNhWmNtYTF1dXVLQkZ6TXRhVGNMbzZH?=
 =?utf-8?B?STZRSjBKS3daWkwwSzJFTlB6cW0zZTZTeUhQWk9WcDVqRGo0KzY0L21JLzg4?=
 =?utf-8?B?Ymk1Wkp1MUkzNW5lTU9Wc2JXRWdGb3pTYlY1TWFpWjJKUDNlcUJPQWUrVlE0?=
 =?utf-8?Q?P2nLnVN6mlmphJXeSUrxkpfgq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5815ba-b9c7-4984-64b9-08dbc518ce7e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 20:30:53.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvbePj7s31gzlnp1tkYpNiwLVbXetg++gOBV4FlWMFQUNOD7gmhJKLqBiv2zUphxkz8B9d0QKx+1Dkg07ZOXEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 5:00 AM, Bartosz Golaszewski wrote:
> On Thu, Sep 7, 2023 at 9:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> On Tue, Sep 5, 2023 at 8:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Using struct gpio_chip is not safe as it will disappear if the
>>> underlying driver is unbound for any reason. Switch to using reference
>>> counted struct gpio_device and its dedicated accessors.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> As Andy points out add <linux/cleanup.h>, with that fixed:
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> I think this can be merged into the gpio tree after leaving some
>> slack for the HTE maintainer to look at it, things look so much
>> better after this.
>>
>> Yours,
>> Linus Walleij
> 
> Dipen,
> 
> if you could give this patch a test and possibly ack it for me to take
> it through the GPIO tree (or go the immutable tag from HTE route) then
> it would be great. This is the last user of gpiochip_find() treewide,
> so with it we could remove it entirely for v6.7.

Progress so far for the RFT...

I tried applying the patch series on 6.6-rc1 and it did not apply cleanly,
some patches I needed to manually apply and correct. With all this, it failed
compilation at some spi/spi-bcm2835 driver. I disabled that and was able to
compile. I thought I should let you know this part.

Now, I tried to test the hte and it seems to fail finding the gpio device,
roughly around this place [1]. I thought it would be your patch series so
tried to just use 6.6rc1 without your patches and it still failed at the
same place. I have to trace back now from which kernel version it broke.

> 
> Bart

