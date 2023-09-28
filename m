Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BB17B1132
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjI1DbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 23:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjI1DbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:31:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ECB94
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 20:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpJPdFfT3FhRCrsxjCqLqUim2yduQBM7ujv6hKFwzkp4hvSR9nSjx75wG/Ptw92x3Rv4AsAKfHaPp19Pt7MldQNmcCXpDiICKKeJqUFxD81ANeDzkwuJmvMsKp9RdLCOa11oKGiY4wSROn3eovXH/1vl0mTyWMLahTN26E31Gd+M3cM5K5x2vf+ek6CjjVtxQkyjvDxASuFnRvAcJzglHximSIdCcIqW9+LULxr9IJCyQP+/tAlhWwbnCmYNinYDwtVaWWBvEMCwb9GHWoWMym3+jj5m400f7mitO6wioGiQi8cQmazvc20PyyoKYaWGcDkcTAeUJEnB+3v0p5S2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DURj9obeP+3qvLHXlr6gOUJsVnzBRpSpSEOTbc7CqSw=;
 b=oOBgptmMSnbtwqupdXuBp4pj/N57EZ5M8DZs4wyK5diF6ufd/C7hYs5rIjCXa4gUHYClZheIOP4o7OCjB8kuoysb8PMMGJg17uhaN54KRPFN+PCGvCE0wJRPRMLJiKZy6uMTTcRQuXmJdkjwMiE1XS6/x02Pz2urnjdu1U2EFeWomq6sm3Kc2nq6+F5TSGp5IaoybB5yI6GtKT3foPglx/AInj/fBGlR8c8N88JJnfvQzgUNRmpwIMRt69WQd1/LhRR9KErG8ZCKR2g9wMxuTGWFH8Y/iXT3dCxv9YLRBNNMKWvhSrRgjHtsToz4pT3/DsNxq63Nf3z6XIV50tAhqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DURj9obeP+3qvLHXlr6gOUJsVnzBRpSpSEOTbc7CqSw=;
 b=Kr9mPhfx11w11TQ0Iw5W87bJODvtI+q28WwnHgbOMXZkw9oqx3voAtNlYEt8mXD6JMeKbCxwbsbSAUTUKzSXa3JPm9KQoANQ1bl9e4Aegml8Fc7J+itGCtDsaQytN8jBkzU193AOrICA0IhATEgwbyxWOgID02LnlZ08ipsycB1ixDsK/2nJvhzoUm0FrzC6chWDIIyGzDWYeryvDsJOUBns2OyVJS5i43FySChkgl276q+bLeoJOqzYhkY8Ki7uy5Mc7biFgZUSiHuCDeGBFhIf++WpZ6tmnAgqtTXuW7wFeWGMExS9q8bvxJmK+YrnpFiIEzEFGy7zHQp2fmJJbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) by
 MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 03:31:02 +0000
Received: from DS0PR12MB6607.namprd12.prod.outlook.com
 ([fe80::3ce8:e189:f31c:454]) by DS0PR12MB6607.namprd12.prod.outlook.com
 ([fe80::3ce8:e189:f31c:454%3]) with mapi id 15.20.6792.021; Thu, 28 Sep 2023
 03:31:02 +0000
Message-ID: <04e28f8a-1393-d991-264c-b0592746c123@nvidia.com>
Date:   Wed, 27 Sep 2023 20:30:59 -0700
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
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAMRc=Mc2Yo61uivOWHagR2Raxh11dBb=S6jtCDu8_-csX3ozvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0096.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::37) To DS0PR12MB6607.namprd12.prod.outlook.com
 (2603:10b6:8:d1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6607:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b95ed42-5b44-4818-e214-08dbbfd356f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQObOIP3Uegsr6Tczngozj/8sqSEwIEd8AF5lsGGxyxGcvGOnUBED8BXHcxSi3cvT9YS/mq5yqdGkUCTpeei9uZQti30jCl+tArGxrukGyvKYIzeXTPgaIB2rnUzJTcHPY/D6gnvnDTwA0l19Tx4z4MyqZFMPS3FcJSoJU3QXzgoT4UV8f3U1wz/DHdOWsWHZXV9B8qb0DAabODj5kpjGq7sL/PqAxWwKXc8ijZWNMpBmmli3TFDmwSd0xNdLH5sa9BqR19r9eE9iE/IY9KWmO7nCtHYqKfODsdou848EPyBuA7iy3Ghr8DCz2SgM0QjM9M9o1hiSWdFnE+GtVQ25RUezJSkRDs3REYXHKoHtJ3xo3z68OOB+fftQK7OroK2R64usd4RvSX/1o9SBBBUg56YrWI7JIIZ4ELeRQxrwy788/kwo0/Sm4afFXeC0YTOpQBj6nWoKnCRKVkUsT3DoI3wbJ2JaanqrMsSHcLev4XWTFZEk9mzcKcDlp6tRmV8sbPbLICfGCDnNsnqcSOxVz4mdUfASQD1sHGCrshk2y1681WBFd2keBNYUMZjQlJNT+N3BkhT3B22qebNm/Ajb3s8+0/REmq+I7QTiAFkt+HaBhc8McK/rsRp/gGJOsepgwNLqJUVS2PEGuaKkl0h/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6607.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(53546011)(6506007)(6512007)(2616005)(6486002)(478600001)(6666004)(8676002)(26005)(2906002)(54906003)(66946007)(66476007)(8936002)(66556008)(6916009)(316002)(5660300002)(4326008)(41300700001)(31696002)(86362001)(36756003)(38100700002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N25jVmJDaVEzMGlvVWJDZ0I5ZzhEYmo2OG5MN2RJaXJwSER4RlprcGF0ZXov?=
 =?utf-8?B?cHQyMTdIS3NJeGM5T3Q1TFFJcXh0ejRiWDAvVlJJNUNMNzFydVgvSWZKU2o3?=
 =?utf-8?B?djRyOG5ETkJZTWZqK1AyeExud3ZsY053VjlrZXBrSEl0Z3djVit2dFNkVUZW?=
 =?utf-8?B?RHoxU1pMTHNxK0lSczFacnc4RThVV3dMZzE5Z1JxVmFvS0dxTmRuMkJwRXhn?=
 =?utf-8?B?Ny9aTFpVR1lPRXFxZVZvU1NQNlVReHdERUtCNEhORk12ZWZDbnVjZy9rQW5V?=
 =?utf-8?B?eFA5YUhoY29OOHRhb3JsQzdBRXl3a1hua0dBbmgzYjF1ZWdsR0EyajVLQzhW?=
 =?utf-8?B?QzZhRit4b1ROMEVtdndsT1dKVDU5bFpLSU1oSzQzQ0ZhTWJWR2V1T1kwZFlQ?=
 =?utf-8?B?bjdXcW9ld1l0WkgxQkN4WXVCUXp6Tjl3aWhWc3RCMWE0MzgvVkxPQlRiL1h2?=
 =?utf-8?B?UkpQM01MbDBhN1hSSXZqSGtuYmhQM0VpWTltbStMRFowcUk3eDBlSzFuaTRR?=
 =?utf-8?B?SGFkeGpGQy9xYXNTbEtsYmxuRm9YS2Z3S1AreE9UQUVhbDlGYXE2MWtvV2Jx?=
 =?utf-8?B?K1YveUY2Zk1XUmQybnhPVWtKWGppZHp2Yk9CMC93eHVqc1ZYQWdKS3hRdHRC?=
 =?utf-8?B?eS9zSVNwcUlqTThOZUlhUkpyVDBhUmFvMENoT3BheWp1UzF3WW01QmRXQzBJ?=
 =?utf-8?B?UGVycGtwMGhQQ2MxaU1KV2Y4OXlhUFVWQ2hyWElTL29TVG9tWVJRcERVK0RH?=
 =?utf-8?B?SEJwV3NqZFlPeVQ1YVhVTElNc3VYNTlWZ3dFNDRsWnVxTHVuWm9ETEI3dS9m?=
 =?utf-8?B?K0pzdjAxU2Y3cDlQMGdCVGVSVmJjanh4dkRwcXpQMzQyQSt6YUY3ODdZaXBR?=
 =?utf-8?B?Q1Z5QWI5UGJWaXFxSndZdlpVMFdLVVdOSHFVZ2kxMlBmb2tKNGdFSUhLaHFo?=
 =?utf-8?B?Umo1UzV3NGJVT2cvbTFXOGZFajNXeGtNVmlPOE96b2lnVzB5U1lXM2pyVk9P?=
 =?utf-8?B?UnYvenNudmpGcmwyQ293NEd6L3VRNm0rRHI4VTMxZmNacFNtNXRxUXhuQ0lI?=
 =?utf-8?B?cmJKOHlIRmRYUnJrdFlmK0JxVGo2bVU5TzZTbEdyaWh4V3M4bnk0YUtJZmR0?=
 =?utf-8?B?SkMzb29XbkRPdk1MRGdhOTdzbU1GaUhPWjlheHROazZ2Wmpab1NkNnQ1dHVS?=
 =?utf-8?B?NEhrN0o0cVhrV05uVFFOUXZJQlQ3dDNpYUpyT1hhcnA5RUVzTGw0aXUxeDR5?=
 =?utf-8?B?R2tVQlFJQjYvakVFQm1CQ2xSbVZ5T05vcHROUUVwb2RLQmUreE1DTEhkemtk?=
 =?utf-8?B?M3FwY0FJdzRrdml4V0VTMWFkT3I5RnhHTXBsZnhFS2FnYVZDYkZwT1JGd0F6?=
 =?utf-8?B?NnlXM25pRm1adkNRK0czYlhDWVF3emllNVN0QzdXb1MrKzZKZFJ0aTNzYmhj?=
 =?utf-8?B?ZTZrMVVjSjk2bjNwTGxFanZhbUZoaGRFaENYSVlYdHRmUGFldTJ0dTNaYUUv?=
 =?utf-8?B?OGQrenVoQUV3TFNNbE9tNSswREpzS0JKR2hVRU8rb3pFQ3p3SmVCYUtldExz?=
 =?utf-8?B?RnRBY05zTE1hMVBjaUVzSEt6TVhiaThMNEJJd0llMnFJVGRIbTN3U1F6SFZy?=
 =?utf-8?B?ODQvWFYyZmRCOWJhcm9TS2dveFBBYXRGMG9MM2lzVzJqZmFlOWdRRzlKUC9E?=
 =?utf-8?B?WHdBMDJuVHhvMVZsZXRTZHFhdllnNjE4MDV6d1BWZ2lzUytYL29zQm9hZ2Ru?=
 =?utf-8?B?UDVPeThsQ285K2F1dFQrb082WndwT21mTTZjUXp4ODB3YkFqdlFTREV3ODgw?=
 =?utf-8?B?UXljeHY5cFA3dFFjUWpwRTZxaW9iMVhMU2xQb3crRFc2SWthTWcxVmpJamFz?=
 =?utf-8?B?Y3lJemhUQ3pYbzRieVhSd2paSUFlZnRHL2tiWjlYWDh3d0sxTFJpclNWejkx?=
 =?utf-8?B?YWU4aWJ0U0tLQ0gvVkwvNzZsZ0NpTEV1cE9PYXNxNWVvNFlVWGoxN1Vxc0Fr?=
 =?utf-8?B?RWVTUk94M2lIQ1ZKbUVPVnVtcyszTzN1dTNmZ2RKUlAyMzNMLzRNQW82VjFQ?=
 =?utf-8?B?bWFsajdtNDVWOVBpU3QvWW9GaVVxWjRCS3Z4ZXR6ZTNnVjhISGlBdm5tUmdp?=
 =?utf-8?Q?jvhflzn3/HaRgLqzwWV1jf+su?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b95ed42-5b44-4818-e214-08dbbfd356f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6607.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 03:31:02.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atH8AXlsL8OsH/ICry0iShZ7og5Enp8ftrssKNd+K6RM8XTmw4nqsvbrEJsnSe734lpr5CQqmNRJxNAjTMWFyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/23 1:37 AM, Bartosz Golaszewski wrote:
> On Mon, Sep 11, 2023 at 11:46 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> Allow building all HTE modules with COMPILE_TEST Kconfig option enabled.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> This was part of a wider series but since this is independent, I'm sending
>> it separately.
>>
>>  drivers/hte/Kconfig | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
>> index cf29e0218bae..083e67492bf2 100644
>> --- a/drivers/hte/Kconfig
>> +++ b/drivers/hte/Kconfig
>> @@ -16,7 +16,7 @@ if HTE
>>
>>  config HTE_TEGRA194
>>         tristate "NVIDIA Tegra194 HTE Support"
>> -       depends on ARCH_TEGRA_194_SOC
>> +       depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
>>         help
>>           Enable this option for integrated hardware timestamping engine also
>>           known as generic timestamping engine (GTE) support on NVIDIA Tegra194
>> @@ -25,7 +25,7 @@ config HTE_TEGRA194
>>
>>  config HTE_TEGRA194_TEST
>>          tristate "NVIDIA Tegra194 HTE Test"
>> -        depends on HTE_TEGRA194
>> +        depends on (HTE_TEGRA194 || COMPILE_TEST)
>>          help
>>           The NVIDIA Tegra194 GTE test driver demonstrates how to use HTE
>>           framework to timestamp GPIO and LIC IRQ lines.
>> --
>> 2.39.2
>>
> 
> Hi Dipen!
> 
> Any comments on this, the other patch with a comment update as well as
> the one addressing usage of gpiochip_find() in HTE drivers?
Sorry for the late response, This looks good to me. I will review and test
rest other patches.

> 
> Bart
Acked-by: Dipen Patel <dipenp@nvidia.com>
