Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6B37B8E1A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbjJDUd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjJDUd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:33:58 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11C793;
        Wed,  4 Oct 2023 13:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIqDJ8lpD6EiaEFe4BGKaTxJTT2mjiruBEA8PSNJKra6sOsaDzIhtl7airFI/jIOKkGjO2Pg1u/Tvup+dgkqoTijYK8sdwQcBFA+LOvVIsHhTwv1/76QneLDinO3/+z03uEUshnm4rY8+6pprt0ysR829JjeWotCDbBkt7zk2M/ZJF64XBWcT6HgZPjD0l7oViQf3xjhKRBVfKGv+obzz4p22lXUWgVBgaz4YM2QCHGMC41X9FxXXqqObLYml7fFT7TQvMgjeWKWIZcN0aLMTp/rBlXIKqSkQcwzQ3WxADFk+e4gL1SwLy3FWlcQmjUDZJJgPD2PFsT2cnnrEfVpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1XEnrEL978bSSMTlq/GrrLO6Fanz7PENFGc7hPWT8g=;
 b=gxqN/Ala9sfy3A2hDKfWpooyZ8wR0fZKECf2GGHDj3uRGYn1uvrkBJoHCAybjEVkPcGUdII/KTZS00/HHZ4J6mP8JWRsdDR04l7smbJjlc9NCoLl5dBaiqKEA83rzey9Ru5rGAaRqh+INUHY8gZI7uD/936Kl0XEjuxWrrzQbs2OqP5+HTM7CTWuv3cMppUBHhjRhuPuiw7oKf64PME7m3+lzXtP+Q67Oc673yJVOTqQpBfIY7619ewKfZbbiWQFHpFgQeh02zcaH2j495iVyarMmuhiUHpp8JFOIDsib/JjLKQga9nNBL/Ct/+2UfRoYXz8H4igLy4l4pSR4J4ejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1XEnrEL978bSSMTlq/GrrLO6Fanz7PENFGc7hPWT8g=;
 b=hf/SZCYvRLR34zr3dOaKk8O/snR98bnzsaMgiImeDFfY0iem1sP+fnSOgO/FaGtfOrdMo9POFdw06phgOn2IuLrYX1JMVm1VpboUJc4ZnAefTAX5kJPuPVyWOd7ZQnKHSTMSPezjpvvhWcc7Ez4fQNyN8AoBU5oc4sMR6huEqZlyV17owSSOQkBlLH5a0uByoZbXsy99aXsZYrkgHH5387Pyegog/Kzr3rhnnjDbYruVu4bAO8PAPQpLze8rjmGHMd2UXm3/s/4apG5tkyIuZGCIKyT5RJaxlUK2+7A0d7+Y/UvVQv3ZcMTsG2+clhOeioS8zINcrzC+7y8KC/vGcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 20:33:52 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6838.016; Wed, 4 Oct 2023
 20:33:52 +0000
Message-ID: <3624e973-d09a-d211-c6d0-d0ffb8c20c4b@nvidia.com>
Date:   Wed, 4 Oct 2023 13:33:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFT PATCH 14/21] hte: tegra194: don't access struct gpio_chip
Content-Language: en-US
From:   Dipen Patel <dipenp@nvidia.com>
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
 <36b17290-c643-8d8e-e82b-49afa6b34fbb@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <36b17290-c643-8d8e-e82b-49afa6b34fbb@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0195.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::20) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: aeec5d26-57e1-4b5e-a65f-08dbc51938f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3F3mSJfdxioyQv9ek1qu4KSYZPQhQKSz94lDfOMMw6sfVIe3c2YsvBDBGMUIP5zjrdVSrgu6DdEmRKe28kM2ULCLrxswI1IXiOe7XQ+qnZgO7//hXW3mehKKQPOLXT9BfPo8ZVUNNMDNLl+P6Ux/R/MwURrI66oPnD46Lt3TfYjJMCOXmclUdmy4h9Ow1+OFSUpC2vGV1mXBEggrco9NWqryGBMmK05my6sKU3nb1gpmzFk4Y231OOzpuFKXGc4RFrWceYfOtLXDyGpVbvkuChmsPoeno2IkqnZ7FLvhu8ltNz0ZRu8tjZ3FSpMZCFGA+FHi+kXbANLrO9MdJ5W7oRdgkZtM+ttY7BDiV2nFbr+0UE+Z5RZN10ZHRVOqbSTZb5I1NjMVjPsPONh/xGLNmzrV2dQ7mHGI1K2H+6xQQln+UtzC0Oj0Z7n87t5f1kUyvkTfT5gY9ERO0AF5CSInFHDrwr2u+sQYD06HYMvsiGtBrpqgLZ7xu+5kJJfX+AYqjATk2dsp8o/jI59Ona2J2KQpwY/s4xByo2/PVfoamBdf36tD+j9KAjh5PlI7oIQfe2ZfzVDnkSdI2kQC0qw+0vkJZi2o/lkGPDCOd8+VNjcLBeiYmqRV5FN7bpD/rDnZBUQg67QOR3qdDRy9o2dkdK+mzFWh67WOLWmLCrPdy3jCbonmd37f1B0GnbwNZotk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6512007)(31686004)(478600001)(36756003)(966005)(26005)(54906003)(66476007)(66556008)(41300700001)(66946007)(316002)(110136005)(38100700002)(2616005)(53546011)(6666004)(6506007)(6486002)(83380400001)(86362001)(5660300002)(8676002)(4326008)(31696002)(8936002)(7416002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTRiOWV2dHN5S0tjZUVhbDRxckdaVFRkNXNYM0ZtNUh4eFBYNngzMng0ZURH?=
 =?utf-8?B?Ny9XSmJOTjlTWEdRbTlIN0EvWURxeE1FaFZTVEVDcmpGZVoxZHpiZlJ1Skdr?=
 =?utf-8?B?RzNsWVp2MjFDT05Pc2d0NGdQMVBlVkZTZGFvRkx4aTN6K3FGV2JaamZQMFBT?=
 =?utf-8?B?cFNXc2dQbTlvZEZTQjF4UTViTWZpOUJrR2dJNGEraXN0dU1pck9NUFdqVy9H?=
 =?utf-8?B?Tm5sY2RJRG4yOFFScFBIODBvSmZUeHBPWitWNmQ4RUNWaC92T2t4OVUvcEFH?=
 =?utf-8?B?UTRMS1hmdFlsTEdnUEw5L2JjUnZFd0VENTNOa2I4N3RDR1dZMVo3ZWtQOXQx?=
 =?utf-8?B?SVhSUEgvUS8vR0JYRStKZWhuOURkaWNIbm8yZmkrR05TUzRjTlFleXkycnZJ?=
 =?utf-8?B?VnJKOE5UWjB4b3Q2WFVYYzlsRTlDaGtvSlV0cUZMTVVrZzAxeWZTSnVzR2ps?=
 =?utf-8?B?cjl2UmF3eUFmaHhzbU4rUTVrbTZCMFkwUSt1aFVSMkhTTm5EOWxseUpyQ1d5?=
 =?utf-8?B?MVVrSlBJL2VCeWJqbSsxTzc1Nlh6ZFVlblFQUS9BWU9vMTU4R1dla0I4cStH?=
 =?utf-8?B?UUIzTS9OMUZpR1FlZGJQTnQ2MnNYaGExQ3lTaU8yMVZWOUZRMDU3N3poTVNi?=
 =?utf-8?B?RlN2VFllcHpiQ21DZ2FKb3Y2M0tyaVByZ09HYnhjbzJSNmVCS3pUVWhsWkZZ?=
 =?utf-8?B?Und5M09zM2JjMER4cGNiTmp1LzBZbHpVK1lISCtNMVo5bWNLRTJwUFVYZ2hG?=
 =?utf-8?B?U1ZCbHRiamd1K01KSVo1VDdsWlBaZk9aUzNtOUR3YUZwM3JTVDVNOXZFRmJQ?=
 =?utf-8?B?bXQwVUVTOFpMRTJodzdSZGVRU0wwUFVDZmZuR3Eza3UwWFIzWUNjRzJ3akUx?=
 =?utf-8?B?Zk83b24vNjY2VEFKTnFEV2NOb3NwWm9oRHJCWEViL0IyZnl1cW9GRXlpbzFP?=
 =?utf-8?B?U0c5cml1UklKSG5Nc0R0WTAzUVh3QUFNbkVBSlAvMENwQ3JTRThoQU9BRnNH?=
 =?utf-8?B?S29WdmpYSytFaTIwM3V3UVAvZ3hITUh3Y1lPU3l6a1BHK2U1bjRXMW5peE12?=
 =?utf-8?B?U0V0Vk5vdGloUzZVMkw4bWlNK00vYTdkWlNPWXkyNWE4TXM5REY2UmhtMGdS?=
 =?utf-8?B?TDVqQzRMMldFUk9xSHQwdGlpa1JzaTB5dlB5MFFhR2d6d3RyNURoQXB4RlA0?=
 =?utf-8?B?K0pldUNYbTNVb283cjFBNnFVeFhpb3JTc0ZobjJISElEYmpRbEpiWjc2NW1k?=
 =?utf-8?B?UHlYYmlTWWRVdFlGRGcvZW9KeFQrWVZlMERpNFY1N1RIQmR5R1k0QzJFSnZu?=
 =?utf-8?B?M0o0RUNENFdKck50QVZpVk1CbW1jWjVlMGlObWdGeHlENWVZUVl0MFg2VXRt?=
 =?utf-8?B?R3U4T2U0dWE0VGl0YzBnYXlSdHdrc1BJcU1mMVplQ1VZK1BYbWdlY2dmNHVM?=
 =?utf-8?B?aURFOVlGZ0ZOYys1QnFuRVlITHU5UHNsN3hJY1hBbjlaNlI2SHJGRHVCMTZG?=
 =?utf-8?B?L1VMbDVvaEhoTGQ1OSt1clNqcE56QjNxZmxQWFFCa3RUbjJzem1tQjVjK3BM?=
 =?utf-8?B?Zi9IWGJVTXExZjVnbm5MbTFQNTF5TURobWd1dktIMEpiS25La1FMU3dIMGs3?=
 =?utf-8?B?aTh2NTN3ZVl1SHlsMDB3WnlPQUUzYjN0SlQ3aWFQNGw3TFVTRy9LOVRSTUg5?=
 =?utf-8?B?Yy9pOTNmTHRQV0FDcEdLOG42ZzhFMk1aM3BaMGdaeGRwa0VEYmxmcDJXRVFT?=
 =?utf-8?B?ZFJrS255M250Ni9uaVNyQlkzRHB0WFZCdVVJK3FwRGFqa1ZHT0I5dkhubE1x?=
 =?utf-8?B?NXJqY3UreXJONzNBUXN1SXpnc3VRMk5zL0FLVjB5UStncTdaOFhRMmdPWjN2?=
 =?utf-8?B?Nkx6RUZXMmJheG9CdXNGeGZ5MDYzR1BOdDduYkhGNU8xV3A4RitBRXE3REt1?=
 =?utf-8?B?cytYRGpRSDBFTHVjWVRlQkhHSU5KUlQxMU9qOE42WDgvZmdKWnJhNDVWK3Ra?=
 =?utf-8?B?ditFT1dUSmdvbFFJVnNvMnE0cWVpNVdNMHRvNXRxYUZQRWI5QnM4MEhuR016?=
 =?utf-8?B?aktLck9HQnZ4ZlFLN3RBUFVYNHMwRkF5RU1najdsODZDWHZlZDdzenMySDNC?=
 =?utf-8?Q?9vw4BLdCtqji8i4gA13gN1Vtc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeec5d26-57e1-4b5e-a65f-08dbc51938f3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 20:33:52.5829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeKJTYYisiRDDGj+V0k86xFyvzy7Qgo9gKTxJkYVkGZtpyD7K5tkh+BPy6YrCk1dI7jSp73R2M5rym9mH9LBcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 1:30 PM, Dipen Patel wrote:
> On 10/4/23 5:00 AM, Bartosz Golaszewski wrote:
>> On Thu, Sep 7, 2023 at 9:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>
>>> On Tue, Sep 5, 2023 at 8:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>
>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>
>>>> Using struct gpio_chip is not safe as it will disappear if the
>>>> underlying driver is unbound for any reason. Switch to using reference
>>>> counted struct gpio_device and its dedicated accessors.
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> As Andy points out add <linux/cleanup.h>, with that fixed:
>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> I think this can be merged into the gpio tree after leaving some
>>> slack for the HTE maintainer to look at it, things look so much
>>> better after this.
>>>
>>> Yours,
>>> Linus Walleij
>>
>> Dipen,
>>
>> if you could give this patch a test and possibly ack it for me to take
>> it through the GPIO tree (or go the immutable tag from HTE route) then
>> it would be great. This is the last user of gpiochip_find() treewide,
>> so with it we could remove it entirely for v6.7.
> 
> Progress so far for the RFT...
> 
> I tried applying the patch series on 6.6-rc1 and it did not apply cleanly,
> some patches I needed to manually apply and correct. With all this, it failed
> compilation at some spi/spi-bcm2835 driver. I disabled that and was able to
> compile. I thought I should let you know this part.
> 
> Now, I tried to test the hte and it seems to fail finding the gpio device,
> roughly around this place [1]. I thought it would be your patch series so
> tried to just use 6.6rc1 without your patches and it still failed at the
> same place. I have to trace back now from which kernel version it broke.

[1].
https://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git/tree/drivers/hte/hte-tegra194.c?h=for-next#n781

of course with your patches it would fail for the gdev instead of the chip.
> 
>>
>> Bart
> 

