Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33597B98F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244111AbjJDXwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240956AbjJDXwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:52:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06017C0;
        Wed,  4 Oct 2023 16:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixsMdNwDR+Y0qA45zMRaOfz44nSm25Mb3tCNceLYrtc3hGqpiDEcm81b+lC5eVKs1aoo69VqIZ1B3Fe5d4i54n/8E3OO4fqVM0vQFo2boQ9Fb73D+1VlVEf+OswuR2UaPYsMCdDKiiEsEfenetIHRxEeUaQt6AGLg1eF861Mbt3ZhTnbOc268uUSP5qJZQl8O/4nmaTVOU86Wcu6CAUsnD6ntE+3HadgwAsSHFkcS+nWMfPHv45juidTdDYFApQitndeEBuHloCBXy09kEN7AJFLaQkuo6R+k6H6Xe7fkvpTx2xysETNT4onO/Sj595RVoFgxuwVXn7wkI1PXq74vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhW2nzwaPbx9gyYhKYdYgdWAXjmvUI0CUtEw63hclg8=;
 b=SkIsXmgvbjIjotpijvPuQyYIiI6XkfmI7Mn6XnWuDtnQXJXmgqo1zX4nUA7IegVYQ08NQTkqYze1d+ABRw1xYbrDHDn2ywPGaQa/eUTqZX6D+DY8FAjgglTDZDHh2HB1KJsUhY11AkjErnsdDdLLhPR1L8lGJX0XW0TjaosAkeyOphzia/pajF5oqRyBcEJ2JF0KTufQDL9p7ybHO158LeWEOsjRcBHl9MgKb7SKqQOVSa4bmn6xaXvZJrmev/tn/3J47IColuZslHAmktlE8YCLOdwIibnlIJuxHAqS4blci1oZriyzR/PHwb+CqgtBKPuIgtR92RDhx85M/P+nXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhW2nzwaPbx9gyYhKYdYgdWAXjmvUI0CUtEw63hclg8=;
 b=Kskh7dnXaY80LFvj0WOOcZbyE8suogj/Ztqr27w/yMbEZnHf8zP6hIFuI9J0PJB2HVJPW+wxhkoojJaGCvVGT2+5D0VCHAxj4hAB43Ad6RdfTog8lFLqkdLP39Dvamf6B6nHVpJMX2UF73s2v0IEmI+nQhnIbEwoXNtAF6ybW/QHSf40yEG+n0aVlJVlp/SlT+eie3PnC87oFi94R6M2L2GIfYkOXQXjvHkRIBNvkJCfZ7pbSs4m+Qw3dLnagq3fTSEg+tPzsteZCispUaH3IAtAlYD4cXqZlg0gT81o5Hipiw/L4YtxARL3Pkl+xHTHwRTxDtKNw2UXKSOV9QyjgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Wed, 4 Oct
 2023 23:52:01 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6838.016; Wed, 4 Oct 2023
 23:52:01 +0000
Message-ID: <0e7cae42-0b81-c038-8beb-49102feea8a6@nvidia.com>
Date:   Wed, 4 Oct 2023 16:51:55 -0700
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
 <90b5f887-8af4-a80d-ea4d-cf2199752de4@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <90b5f887-8af4-a80d-ea4d-cf2199752de4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:a03:40::46) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e813fcb-3fc9-4a77-6478-08dbc534e6e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDTgwc3tzeOTYKVEPaXpOg03OKVoJSdzaN0tczpOrTYA4mS/jJBQiTkIWpKWC+RrEEfg12P9u8UaAxXBsG8nhNY84oXaQgkIZ45FTXNGD5epftYYl/jz1oqCgfGukON49ZH+7llJdhXq9oQiDPI7FgORSmL40l3GICLassgnEPljdrzCFZx7spgnxB/2DCLOav91LoWujDW1aPu0tm2jCttg929AkH0DRIwEkZordC/C2EnNdm3v4KhHqSfBeQR/LTwhOklJeskDujUkrfLGj29Vy5v3iTwTPB+Zcx8ZYo8TsLlP6PbasLe449DimT7EmvnQDYTI570t4IBjm7IgrLs2WmRVOawXVPTuiu3sOOdXhvAyKhivHGDBWFCCLgIle/o4hhyL/wx92VFeu5h4yyQ0/W6JJkKwTY8P641AC5OuXh/YjDMt8haYoDlPPSvIazliA+Grev3MUcmM+clCTHfSkT4e/3LP33n3P6T/GnnWhYeIPww01ov4DW/UM6yFWsh2Ktcy0Za5j7qjwUuTuWYqVRexujSWdNuC5TfTfjpNhqMZRixQLnjAUDN55H9uNS60my/wMZmdeCPDlFVelE8na5kCg9sKLAM0zCP+GvbVJXJT171MwaNwY0HsF7jpEODjp/u5Omc6XNH1ECLE5OHZ7zdRvK9Q1tjlB9XzYHBPFVr+TQgLWRw/4QlFtsei
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6486002)(478600001)(53546011)(6666004)(6506007)(966005)(83380400001)(2616005)(26005)(2906002)(6512007)(110136005)(4326008)(7416002)(41300700001)(316002)(8676002)(54906003)(66556008)(5660300002)(66946007)(66476007)(8936002)(36756003)(31696002)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MS9DdEZkOVJIQ1JaUmhmZjUrb3A0MVBtMjR5eTdrTTBIdnArcmdRRVdlS3Vu?=
 =?utf-8?B?YTh2RlVmTG5RUFpPSnl2ZnJrdmNJeFp5NW40Z0dFRURiZzBuQ2w4b3ljOEh0?=
 =?utf-8?B?KzEzYlRQR3JieG02OUl1QStmcVphK1AyN3FyUGp2azJiSWRYYklMZm45V2dN?=
 =?utf-8?B?RDhHckkxbTRtUFduTzVTZ284QWxhWDZTWXdXMFlkNE5KUHFGTldJWjh6SVRo?=
 =?utf-8?B?SjN0TjhrOUloVmYyQUNkck9nZzlGUExsQVh0ZHhTby9QL0xVc1ZiNHE5Vm9O?=
 =?utf-8?B?VHpNc0V3OElCdjZCSnBkSjBPUDZCbWdtaXhORjRFUCtKMklWaTJpTWVsWlZS?=
 =?utf-8?B?bXJxT2ZwVmtVVUkzN1ZZeFN4V0JuSVo2LzFLbVRucU5MMHE0QWpoMXpKOGJW?=
 =?utf-8?B?d1o4aC8zN1VldHhlemU3QTREcG9CT24zUGVvZVI0OG00VmxVRGhKMmd1TTlK?=
 =?utf-8?B?VzU1NU53eThoQXhqUmtaczRVbDZmVml1QTFUbjBMMG93V3lwaHNnSWdPRmpw?=
 =?utf-8?B?alV5bzQwa0hybEZyVEc3Z1cwRTEyUnNQanlUc1EwQUpkV1dxRWsvcXFoL0pT?=
 =?utf-8?B?eWNzVkpwVHZzTENEeEdPLzlpelJ5SUtoQ2dtK3ArUzRsTWY0WHV4c3dOQlNP?=
 =?utf-8?B?Rm5reElJQ1ZtUmlWTm5nL0lBV1ROY1QxT3gyV2s0MG0wVXgwRzRtbkpXaks4?=
 =?utf-8?B?Y3pTbHZCalo0Q0o3VVdmamF6OWprMTh4OG9hMisxZkxYQ2c0RXpIRUNucDZ1?=
 =?utf-8?B?UnJhT2hPL3dUWk1lTFMvMXF2Q29hUy9BNnhDZmNraitieVE3SkdKWnZkcmJ5?=
 =?utf-8?B?eGJzU3NtMyt3a2NiNmRBN3JzOTZyTDVUTW9LUU5iN2NUWGdBbEN4V3JWOHh2?=
 =?utf-8?B?WEVsck8xQzZnNDd5M0pwM2xoUzY5UWx5L3ZpeWN1OFBkZ1NHaDRXdUtYUUJu?=
 =?utf-8?B?YW80TWVVOHorSGtycDJUNEJqbkkvSmllMHRmSnJON2cyeHcwKzNTWVZsZzlK?=
 =?utf-8?B?NEJqQU0rd3FiUDZ1QmZqV2NndXEyUUxTSUJXWno3Q3E5VXU4bXlUOXhxTkpF?=
 =?utf-8?B?LzFTbVBlMndFS0lMSnJvZWRPZ1RzTzkzWjJjWHFoeU92YlQwSGQ2b3EzTjQv?=
 =?utf-8?B?R1g3SHlPRSs2YU5RbC9ld0RObHdCZEFjRVpOUWpSaDVnWk5ON05HVXZjbE9Y?=
 =?utf-8?B?ZW5jL3hkcTM4eHM2Z05RNnV2VkIvUjlCQ0MzV3EvWUlZMEtGemNCeEFtTmxj?=
 =?utf-8?B?ZnJkRlM4UVRtY1JiNmtOaFc2UzNiNUhmSnl0QUI2a1hBZjVCWVpuQzM1WWNG?=
 =?utf-8?B?QWNIVFM4Wm1sREZjQ3hESVNxZVlSZWJOcVNqUFpVb3B0MHE4MzJzUlZUK04y?=
 =?utf-8?B?bi9BWThvUDBuVGcrck9vbkhLamZpc1pOY0Viakp3MXdlY1FmeFpoZkpkeGZP?=
 =?utf-8?B?YkxROG12TTdTRnFKTFV2OW1NdVVEbzFybHpyVGVraFB5UTRKR1A0YXN1Uy9k?=
 =?utf-8?B?WE04NHE1RThMN0cwK0M2dGxhQW8wQmRMcDFxWDhFQVMzNVNlTCtYWEpLY2p4?=
 =?utf-8?B?QkloSmFtZ0lRZkRRSmE0ektON3EydzF4UVFpL1NVTm1weEErSnNTOFd6T0RI?=
 =?utf-8?B?QXNiVU40SE1qSlhoWkVHeXNZM3Zwei9ZQldEeTd2RUdmUnlEa2ZiWHZyUmVh?=
 =?utf-8?B?dlAvOFhud2dUTTVvUUM1cTc2ZzhNVWFSUGVQUk9HeHlPN2x5RHVNYlU4aTRn?=
 =?utf-8?B?RDBmZTZOenFJNnJ3ME1FL2I1NFhuUkRYT1FhWkpBYWJkUWV5SFl2cDM5aW9Q?=
 =?utf-8?B?SkgvZXMwcnl6RkF5WnBUS0VtaytvZGhLNW1LczdZdjcwSHltK3FQTnIvSjc0?=
 =?utf-8?B?NkN0Wm83OXY2MFBGSWNqRkorVmR3cTlJdGZEd1FYajNNQW5ZaWJUaUJmNlFv?=
 =?utf-8?B?V3g5RWs0VEJWUitLSnpoaEwwc0I2Tm81TFBOVEM1THVXaUJTckZlT09VSE84?=
 =?utf-8?B?VDJDNGVXcjIvM2pPYWVGSm9RcnIxQmMwNitFcnVSYllhY0VQUUUrQlE5SDls?=
 =?utf-8?B?VUhUV3Z1b3JXb2dFazkyRW4vcERrVEdLc3NSWjBObVVodjAyUHRIajVwdHhE?=
 =?utf-8?Q?PjE5YeHXcPGkKAuUuX86jSEKU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e813fcb-3fc9-4a77-6478-08dbc534e6e0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 23:52:01.0596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKZtb0giJot5ZW6z2Csp0/tkedKig8VH3VW53A/E6oyham793FADvUXmvpwoivGEojjTggfbHbpu7tWRWSbOtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 3:54 PM, Dipen Patel wrote:
> On 10/4/23 1:33 PM, Dipen Patel wrote:
>> On 10/4/23 1:30 PM, Dipen Patel wrote:
>>> On 10/4/23 5:00 AM, Bartosz Golaszewski wrote:
>>>> On Thu, Sep 7, 2023 at 9:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>>
>>>>> On Tue, Sep 5, 2023 at 8:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>
>>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>
>>>>>> Using struct gpio_chip is not safe as it will disappear if the
>>>>>> underlying driver is unbound for any reason. Switch to using reference
>>>>>> counted struct gpio_device and its dedicated accessors.
>>>>>>
>>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>
>>>>> As Andy points out add <linux/cleanup.h>, with that fixed:
>>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>>>
>>>>> I think this can be merged into the gpio tree after leaving some
>>>>> slack for the HTE maintainer to look at it, things look so much
>>>>> better after this.
>>>>>
>>>>> Yours,
>>>>> Linus Walleij
>>>>
>>>> Dipen,
>>>>
>>>> if you could give this patch a test and possibly ack it for me to take
>>>> it through the GPIO tree (or go the immutable tag from HTE route) then
>>>> it would be great. This is the last user of gpiochip_find() treewide,
>>>> so with it we could remove it entirely for v6.7.
>>>
>>> Progress so far for the RFT...
>>>
>>> I tried applying the patch series on 6.6-rc1 and it did not apply cleanly,
>>> some patches I needed to manually apply and correct. With all this, it failed
>>> compilation at some spi/spi-bcm2835 driver. I disabled that and was able to
>>> compile. I thought I should let you know this part.
>>>
>>> Now, I tried to test the hte and it seems to fail finding the gpio device,
>>> roughly around this place [1]. I thought it would be your patch series so
>>> tried to just use 6.6rc1 without your patches and it still failed at the
>>> same place. I have to trace back now from which kernel version it broke.
>>
>> [1].
>> https://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git/tree/drivers/hte/hte-tegra194.c?h=for-next#n781
>>
>> of course with your patches it would fail for the gdev instead of the chip.
> 
> Small update:
> 
> I put some debugging prints in the gpio match function in the hte-tegra194.c as
> below:
> 
> static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
>  {
> +       struct device_node *node = data;
> +       struct fwnode_handle *fw = of_node_to_fwnode(data);
> +       if (!fw || !chip->fwnode)
> +               pr_err("dipen patel: fw is null\n");
> 
> -       pr_err("%s:%d\n", __func__, __LINE__);
> +       pr_err("dipen patel, %s:%d: %s, %s, %s, match?:%d, fwnode name:%s\n",
> __func__, __LINE__, chip->label, node->name, node->full_name, (chip->fwnode ==
> fw), fw->dev->init_name);
>         return chip->fwnode == of_node_to_fwnode(data);
>  }
> 
> The output of the printfs looks like below:
> [    3.955194] dipen patel: fw is null -----> this message started appearing
> when I added !chip->fwnode test in the if condition line.
> 
> [    3.958864] dipen patel, tegra_gpiochip_match:689: tegra234-gpio, gpio,
> gpio@c2f0000, match?:0, fwnode name:(null)
> 
> I conclude that chip->fwnode is empty. Any idea in which conditions that node
> would be empty?

sorry for spamming, one last message before I sign off for the day....

Seems, adding below in the tegra gpio driver resolved the issue I am facing, I
was able to verify your patch series.

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index d87dd06db40d..a56c159d7136 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -989,6 +989,8 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
                offset += port->pins;
        }

+       gpio->gpio.fwnode = of_node_to_fwnode(pdev->dev.of_node);
+
        return devm_gpiochip_add_data(&pdev->dev, &gpio->gpio, gpio);
 }

Now, few follow up questions:
1) is this the correct way of setting the chip fwnode in the gpio driver?
2) Or should I use something else in hte matching function instead of fwnode so
to avoid adding above line in the gpio driver?

> 
>>>
>>>>
>>>> Bart
>>>
>>
> 

