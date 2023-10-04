Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365327B986F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbjJDWyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240200AbjJDWyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:54:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45909EC;
        Wed,  4 Oct 2023 15:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxRvR9ChI3azE2iwN6fiAT10vy2otqg1hr+zDE7+4SeocqgXfjQYK6FYWrf6CQYLzeaDtXJPhrCbNMV+nyA+HsJaSe38yEoT5/dY3qWIeId25WVEc0ZIniGqHZAC+6NBmxZ2C3uoyR/y0bRsy0Hyt1B+SxSUsr5+5T4aHrmWoAzN6upgu6ocN/ifeloKPe/IEFfaUdawL5k9ztXw7EJOpldUJPFEbungojMBurro3vDqFNFF5oGu72iiNMEt/ZgfVLJz0nWvnloRMtgEiZrZXT1r8+XZTmwNK9X/7PzERgk9C13oEGjUwwOrOxufYopWNSNeKPZLoTBZbIdoggZSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekyj/qFCKEpBu5k8BBX37IFz9H7nKhAQBYaxcu2CP4I=;
 b=KV8dNxqn+R2gc0IYb0ZEC9W4DqinDsZj5Tsryo0s8suXnxRUjs/zue7FLJFStYwsM37mql7KMvbirfzzUiQ0NQyb7Q5cGl2rCSbADaYLv65xCThp78waYySR2l1UaWyBD+tkDv6NStQcMHV0N5f9BDjGiq2vAwJIQM9FsywI6I+B9wc+kUw2CBKr3AQNchUqs55G/tctNm4uJPX5LVrCkpOSbM/2WdxIPCQAwrsmlyiyVwPWi8DamFVfj4swwPvdDwhYl8DrxG0Id0bQDUYpiuTSIS/fG6hqbL9eXUtqbY3bA+sDJ2w7uhpq2nHGdTdB9k1JURoNkFe5l8mfQIN/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekyj/qFCKEpBu5k8BBX37IFz9H7nKhAQBYaxcu2CP4I=;
 b=t8Kl728PDwKxAzzcy83dVLCmuQI+X+6cZOvcHgTWJXFLYvDLobAvQMTNTyR3P6XompTmm+bGhTICa2oKKWJQUfOfi2Q3PQg28y/9qmZ0RCFq7fP9cjibuO10m0/YIdDXcqYgTYTkuN4VLw43zXAxJ5YbNiTL9nE1j/LIpqMK94C9FdBugo/RiFtSeLOSpRrZJqNGTfdATlm3nl3PEuK+9tiNEUKKHHZA8Lgu7ez9fCGsxQpIR+6DwESc1u/KIMBPnI8qRU+M6/hi1orM9vcVFDJ0X8CzNd8T71dUg19ToRx4yYfzsjQYwjf8Rm+K3Ob4F/OReV4tMO7HxiZdpOI4qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 4 Oct
 2023 22:54:30 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6838.016; Wed, 4 Oct 2023
 22:54:29 +0000
Message-ID: <90b5f887-8af4-a80d-ea4d-cf2199752de4@nvidia.com>
Date:   Wed, 4 Oct 2023 15:54:24 -0700
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
 <3624e973-d09a-d211-c6d0-d0ffb8c20c4b@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <3624e973-d09a-d211-c6d0-d0ffb8c20c4b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:a03:338::30) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: cf856291-424e-4ee0-4b24-08dbc52cddf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOHbppOS4fHFvmZpWyLi4SFEYnQnBbCfoTiSGIutC5470ijOq390aKjnHqr2SNaESyaEpUpwYgSLyhEnZhTEoWySkPakwBceawefwEfTPQ1AYUSHWDPD+ZUJMZe8tF0TiFvFElCNQ1XhBpTtvNUp6Udhg657sPp4pNUZ+5Dj0vrsjtEEVNaOma9hRWVVi3ePTFwQGIaJuNNNXVMpD2PUxR8cROS01PcjC/HrhlAil5LWba8B3tJk0/W3NKNG6lNGc0inTS95tmIF8VWe8glM4THFTz571SlAc5i0ou+nkGKuiQDmd4S31OFDMEw2vW/1LvrICbfbizZEpReUEOtHinoH5/A22wuMP0IAjfUy/laOKx2nsHwwMUmOSi4vxM56lKYyalG1Li+ZG33yIh4MidYviGzdH4YpOxRGb5YYzNKpoGW5zUDC922h12R5TjQylEwHYk/djsDtjRwF04dhphGPTQgt0hhHrLoXqvyMwoNO/UwK0p3imKllMVooEfk3Wd1xSEWbBmmRSA3PL1HnF8Z3Dyd/G2bk+MVQSLZ4eTJfLIjuf/1nFuoYawxqODcCfm8Wc1G+vukAEYwV+Mxun9oVjin7izhx+I+c9Oin1RnGmBdIHOehT++Aja67CTmK386DM826jOI8R0raUcw0/PzlzFa7htefetLr1ugvnXE3Cr1ObFSk/NXPExrO07IQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(110136005)(5660300002)(8676002)(8936002)(4326008)(316002)(38100700002)(83380400001)(41300700001)(66476007)(54906003)(7416002)(66946007)(31686004)(26005)(31696002)(86362001)(2616005)(2906002)(6512007)(66556008)(6506007)(53546011)(6486002)(6666004)(36756003)(478600001)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODVVVTFOVW0wYUp0YUJDVXR4R2xJdjFRNUhHeVRXMkNPUjBCZncrZ244Zk9s?=
 =?utf-8?B?RVl3UVlKZUNQU2x5djZ0ZHg0NXJXU2tjNldKNWVvVElrVlFpd2lTUWxqVk1i?=
 =?utf-8?B?Z2VldWVkVmptTG01Mk53MHpwY1hqNWJ6aTduZDFUQUJrOGxsQk9MSkdlS2hT?=
 =?utf-8?B?ZFVZZnphcFZqVUZYcEg0WmltcnVrR2RBUmVlOTBsUkp3aWppMGV3bXJvSmZF?=
 =?utf-8?B?K2FVNThha2NKZkY4aTZPbDljZ2Uvc0MwVThacWVHcno5dXNwOS9BYjg3VWhs?=
 =?utf-8?B?SWtmZWFZYVZKdEh5cEhleGxaYlNGK0cyaEZIalpabG50SDRkUHRiS0FQOWZE?=
 =?utf-8?B?cmtCRDNtMnR1REluUC9vajk0Q24rMEtqczE0KzNQWEppWXZGZk8xUkkwbVly?=
 =?utf-8?B?cnNnTXdqWTI3UHIxTE9mejd1NUIreEgxbHZUSmRkeVFtdE95REFsS2Q3Ymxs?=
 =?utf-8?B?eXdza0VXMXEwd3Z1SVM5ZXB4alhRYmFrUERzWGw2ZHZ6aVpIaHplNEZPOUcr?=
 =?utf-8?B?TVYxQ29Ic2lwd25sNVRDRS9Eb3JBRkcvK200enl1aEt2RUFYNHZHVGVUN2FS?=
 =?utf-8?B?NFEzMlBJNFJ2MU1qZVhzTDA5YldpZlhTQkxGek90ei9XVndwQm5mbHNuRmNn?=
 =?utf-8?B?UjVEeVpqVUp0dmpsa0pDWU1nMGFUTmpxc3JOaytaNTdqVTNiQ0REdmxWSEFs?=
 =?utf-8?B?SEk2QjdMczlIZW1OSjEvWVhJRW9BZ3VaQ3RZVHNOUENBL3p5M1JxWlFGVUtu?=
 =?utf-8?B?bkVCT2podGwxN2xlRGZhS0h0UFBwQmlRZkVmTTdLbHNjMmczaVJSc3hQdkRi?=
 =?utf-8?B?cXE1bmsxaWJKTUcybEVsTHB3NVpIOVIxWlgwZU82RTA1SWc0MWVVSjZQMU4x?=
 =?utf-8?B?RVNHR2w3UDk5MlRKd1QyUEowaUV4eGpVYnlaK3JhS0dMRnRRdGxIa3NJYmlG?=
 =?utf-8?B?bktSblIyenI3NHRHK0JKR09XOXJZZ29FUXhVODJzYnFTUjgycEhhRnJxQXlE?=
 =?utf-8?B?bHRYVWgwbDZWM3hSRlc4eUhLUVR3TjFPMXNLTE9PcHo4bzh1UFNvaFlsdVRB?=
 =?utf-8?B?TjEvUHh0QzEyMSt5OEdZbno5Y3JwUE53OFJPTktVZGtTczJZWlNtYVd1Yk1m?=
 =?utf-8?B?SlRCeENVblg0SW16SzhMOENsZlVzelJQcHhrNTdXT1d4TGRsR3FDeGtZYnUw?=
 =?utf-8?B?M3p6YitmVCtNV2tSSGptelExT1NGVDhIdi9MRUhIWStqeUdRNVdUalEwZXVt?=
 =?utf-8?B?N2tsbHJwd25MWlZmZVA5MGpJMUJudkdIOCtvaU83NmxhQmJZSlhuTlpuQWl2?=
 =?utf-8?B?UEM3T1NBeEZ6enJoQ1NFUkNZM1dTNVkwVEJ4TmtxeXlScHg2N05OcWJ5SDRo?=
 =?utf-8?B?emVtY2oyV3RuOFBsWWw1ekY0RVkxRmZ4THBYcGZKam9tUy8rOWtvdUV3a1dh?=
 =?utf-8?B?ejBUbWVUejFXbjZZV1M3YmRuaEhaNEt4Y1N6akZyWWdMQ3VHT3BvaFliaFpL?=
 =?utf-8?B?VlJ3Y28vdmV6TzB2N25GMURJMkZlUGpmeTRLaVdZNzlSNFZHcjlLeWFUZE52?=
 =?utf-8?B?OEZ4Z0FpMkFpV3JCbVZjTHB1SWtMVGNtMjZHblV2S01hd0RvRmZIb1FDOGJK?=
 =?utf-8?B?M0l5T3dKd2daNnR6anBhYWcyWGtoVGNkQ1kyMUNyWnVpeTNYY2VxMUJ6RGpV?=
 =?utf-8?B?anFXSVlDYlBWU3ZrbkpIdmlvc21TVWFnL2xtMHRLYld1cEM0UWJCN1NObm8r?=
 =?utf-8?B?UzZKOE1LS2NyRC94ZHljRTd2aERmeG1PV0x6YWFEeFg1cHQ1WDcrWDZJNUI3?=
 =?utf-8?B?b1Zqdmk3QlFJRFowdjRXeTZhYWxLZExxUW1pWHRyand4bHp2d2djU0VaRkNj?=
 =?utf-8?B?emEvT3JXdHVPdGQxMjdab2VJWENZbVdkMzlpZk5kb3RqajZvOHFJZnVkVEhy?=
 =?utf-8?B?SnZmUjZkb0I4ZExNQk90QXArQmZEMkFnL1FEZEIxK0hXU3IzWVpzbWRyalFF?=
 =?utf-8?B?N3ZnMTlBVWtGdlFnQnZzaTRRNU1aWTA0MmdUcFdGRGhEK1g5L3pGczhpVXR6?=
 =?utf-8?B?MlZuWS9HblV0cUJkenROZ05zREFGQ0pOSHNpR2RCYkRtRE5ucFJXaWZpZmxp?=
 =?utf-8?Q?fY4WX4MN/AuGah6CvNULMwlvy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf856291-424e-4ee0-4b24-08dbc52cddf1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 22:54:29.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6Pd6mZ3upP9SSMkuhAEEvMeiE3tV34lEwWm3t5I9CtKARUQa7k9xLa9rfOr+ZUVqpD4+Luuy6L64dz1rn5kjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 1:33 PM, Dipen Patel wrote:
> On 10/4/23 1:30 PM, Dipen Patel wrote:
>> On 10/4/23 5:00 AM, Bartosz Golaszewski wrote:
>>> On Thu, Sep 7, 2023 at 9:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>
>>>> On Tue, Sep 5, 2023 at 8:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>
>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>
>>>>> Using struct gpio_chip is not safe as it will disappear if the
>>>>> underlying driver is unbound for any reason. Switch to using reference
>>>>> counted struct gpio_device and its dedicated accessors.
>>>>>
>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>
>>>> As Andy points out add <linux/cleanup.h>, with that fixed:
>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>>
>>>> I think this can be merged into the gpio tree after leaving some
>>>> slack for the HTE maintainer to look at it, things look so much
>>>> better after this.
>>>>
>>>> Yours,
>>>> Linus Walleij
>>>
>>> Dipen,
>>>
>>> if you could give this patch a test and possibly ack it for me to take
>>> it through the GPIO tree (or go the immutable tag from HTE route) then
>>> it would be great. This is the last user of gpiochip_find() treewide,
>>> so with it we could remove it entirely for v6.7.
>>
>> Progress so far for the RFT...
>>
>> I tried applying the patch series on 6.6-rc1 and it did not apply cleanly,
>> some patches I needed to manually apply and correct. With all this, it failed
>> compilation at some spi/spi-bcm2835 driver. I disabled that and was able to
>> compile. I thought I should let you know this part.
>>
>> Now, I tried to test the hte and it seems to fail finding the gpio device,
>> roughly around this place [1]. I thought it would be your patch series so
>> tried to just use 6.6rc1 without your patches and it still failed at the
>> same place. I have to trace back now from which kernel version it broke.
> 
> [1].
> https://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git/tree/drivers/hte/hte-tegra194.c?h=for-next#n781
> 
> of course with your patches it would fail for the gdev instead of the chip.

Small update:

I put some debugging prints in the gpio match function in the hte-tegra194.c as
below:

static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
 {
+       struct device_node *node = data;
+       struct fwnode_handle *fw = of_node_to_fwnode(data);
+       if (!fw || !chip->fwnode)
+               pr_err("dipen patel: fw is null\n");

-       pr_err("%s:%d\n", __func__, __LINE__);
+       pr_err("dipen patel, %s:%d: %s, %s, %s, match?:%d, fwnode name:%s\n",
__func__, __LINE__, chip->label, node->name, node->full_name, (chip->fwnode ==
fw), fw->dev->init_name);
        return chip->fwnode == of_node_to_fwnode(data);
 }

The output of the printfs looks like below:
[    3.955194] dipen patel: fw is null -----> this message started appearing
when I added !chip->fwnode test in the if condition line.

[    3.958864] dipen patel, tegra_gpiochip_match:689: tegra234-gpio, gpio,
gpio@c2f0000, match?:0, fwnode name:(null)

I conclude that chip->fwnode is empty. Any idea in which conditions that node
would be empty?

>>
>>>
>>> Bart
>>
> 

