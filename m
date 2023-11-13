Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16957EA584
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 22:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjKMVgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 16:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMVgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 16:36:37 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0178D67;
        Mon, 13 Nov 2023 13:36:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6Bee9IP3+mUZdOipD9Mojt9nzvPp4c+rQkmMsvkhE3uwGUsN93OLegPUudWPqCkO1rOoXntDbBh9QRmjCKqLHw8WuOiLPGrlLQjCHHd1NKVf7/XQWS60Yvu9Z2TDAgsZiJDDf1YUhKFc7N58KyFxM4ynEizEGxAfhATC13pM7utwOaPEG3N0eD5Ui8sBad84TxtleON2LQ82Vu/NFzD5Mrj10ANKdFD2lI5fL5p3CDye+Zil95ULQWTUXParc94ZkoCIzZs6nzsMcdHpe8J4AZlADA0b4X68UPh0jTqohEYKZ0IPQP97a9ab1K5ImXY6VhZ5I9k9EQFf/g959vVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Us2Y7m6i4/rSdIkZvtgNL0I07mYzLYEjQPVgILHwQ74=;
 b=BIDVMQP3GYzuTeA0vjH2ElORxooFCTwrrdCAyOo7juaxcqjA/jLep+mNe74vEaa5Rz31gPNUGwAxYc/nS6nhrAjrBUG6lIW4P+4SBiFziCSZUy4X+gN2zedXbiKLaIIuRfcwsvEYfM/gOW7H1Pey0RO5GFh7uLk7MyYYSRpOyCYqe/pVupT9kcetZhs1A9vi/Fp5VQkaCRNoJ3IhObeb1REmDZ06yUuVPuhVDqih9/Q+COIYHCWRX1VA6URVTd2hD9A+3HfYM77+1eG+xNjTaygspjZSTikR4/7rCjnIRyF+i6mPiFiB/Y04b2Hh0C6L6QUiIcHaHHjh0XjX6Fmpdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us2Y7m6i4/rSdIkZvtgNL0I07mYzLYEjQPVgILHwQ74=;
 b=1vTf0ospXZFY3OxKDT0qKCjaIoshqy7guZx6qiucbpb7vBLlxgcphIV0szogd9uXYftCeMllo7K3DYb7KSKLjSEJjOAFwEyNEVc9Y7XJR0ol6hX/ZBQ5kBtXz86ygOOorkRLqbIRKsK5rM9ya68Z7B1zGvOYTGJiFlQ+yQh2x1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 21:36:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 21:36:31 +0000
Message-ID: <d55a80f7-ca4d-406f-b2c8-b2bba45e3104@amd.com>
Date:   Mon, 13 Nov 2023 15:36:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: cmos: Use ACPI alarm for non-Intel x86 systems too
Content-Language: en-US
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        alvin.zhuge@gmail.com, renzhamin@gmail.com, kelvie@kelvie.ca,
        Raul Rangel <rrangel@google.com>
References: <20231106162310.85711-1-mario.limonciello@amd.com>
 <CAHQZ30DP8ED4g3bib-tZ53rm2q2_ouEEL3TxD-SgK4YrCe3bew@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAHQZ30DP8ED4g3bib-tZ53rm2q2_ouEEL3TxD-SgK4YrCe3bew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:806:130::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: de8ccf1e-de97-4d97-6163-08dbe49099f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fl6scUb7htjukDAI4TdKnd22U5velUWf6AHtIQ4OIF5ekeiv1Vq+ggeJ3RRfsndmnum1HKBLAwtDEp7fziPVukimlywTUlnd7cOTfYIvCW/yPXZ0J5K7r4JfJefZhOG0fR0pUSZlP1yM5VXqPjh/uiVwXq7JDs3ESMu2P5uerbL4QLoR2ZubFpFh4BQYTtRpjN7ZbpMTKi4MNEXopwRZwVN34s8lQOXFw/Od0wW6GiMcCueXpl+i8wuAAYXkrLlnYtLsBa0eu7ba5PauQKTctRnNXc8Vhb5RknE9LyOYFkHcVCoGB2IJ/IByAtwPBlCAj2Apy1KIqD5K1K9SG9Lfacw4+KSirvQLSfLfNQ1Mgc8AYSoyKTFaRA4dcU6q42DyI79NzVonbYCa7VGQtSEqY8nLb203PPmh0J8krZkDLw3ekYmcGDPM9qT73RQ+tZ4Wa905OVnp7IjfVNE0ppd6D51xsvD+y6AiVpxyeR9mf2CAX3vYDS6DOLVWtUHuCwOsI15OC8VxAG00kWQlZK+H2kO2+U67RGgxBDk97z4DdeOYOFU1taaDevTrj8EjI8h8w7WhKw7gdmiMcbj0+zd68j22Q+5I9Qp8iYMfT8u4cuqwsm7lHNLoNIYymUD25KsgMHa8XMwJoOoJoGmmKdXa1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(36756003)(41300700001)(83380400001)(53546011)(2616005)(86362001)(31696002)(5660300002)(4326008)(38100700002)(44832011)(8676002)(6506007)(8936002)(66556008)(66476007)(316002)(6512007)(66946007)(54906003)(110136005)(966005)(26005)(478600001)(6666004)(6486002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWRVVnBkTVJJSDBoNEd0bmhINVNadEF1K3lOd3o3RFArY1dUclJ0VlFCek9t?=
 =?utf-8?B?UTBySTVBZ2hvR1dDMTdrTXNBNHY4MmZjUlhwUkI2Y2F1MEw4VzltSUIrSXRj?=
 =?utf-8?B?SkxGMGRKK2RrK2dsa3djSDhRUnVaTDJ2RHR2Y0ZOSVNLRHZZeHNtK1hUMDRu?=
 =?utf-8?B?eC9ockFBTzkwZmN6aEw0VW1JaVplQzUvanh6MklQQkJld1ZIMTU3bzBFbElB?=
 =?utf-8?B?Z1Y1djBXcThWNnNRemVoeU1tSEQ5SkxkbW1adnhBN0htYlJRSEF0SnhDNjhX?=
 =?utf-8?B?bnAyVy82aVQrN1VhL3FKSE40VW1wNC9NOFNpcjVXbjllQWlxNnRwd1FpWnpM?=
 =?utf-8?B?NlNtM1M0VWNacXhiUktZWkFKeFdVZm56anZiK0NKYjVUZ21Pc2M1cVIyQ3hE?=
 =?utf-8?B?NFNHTVVacXM0MG1QeG9ZZURYVGF4a25qMm1MOHQzQnovZ0hPWWRodGJoY3B0?=
 =?utf-8?B?R3YyalFCUHJNRmY2WlllVXQ1Vjc1RncxOHNGYU9GUlBIMkRGbkh4RFFHTWlr?=
 =?utf-8?B?cS9HTERoYUhSWWkyQkNLamJwUDI1Qmx6MlgrMDhRY1Zwd1JpSzZ6Z1V1YktI?=
 =?utf-8?B?WnJqWEZ0VWl4eFBabGp4WWRpSGpSRWgrNmhsZkxyTVl5MElNUUhEQlRaU09r?=
 =?utf-8?B?N2hGY2hNZWxMNk1GbXJ0S0NUWDN0R3NDeXY3dEM0SFNMbmpmcmdDYklFNEZC?=
 =?utf-8?B?aW5JZmlXR3h5eEtkYXBFV1VuRWNHaVVvQi91ZUF0NDNTVGFIcjVDZnVPaDMr?=
 =?utf-8?B?STJ2eUVndENJeU93N1oyM0g4dVJpUjY2VVBkWjNxSXB0UG02WHY2dkZRVlhn?=
 =?utf-8?B?S1dDMmFnNlE4R0NxUmhhNE5LL3ZVTS9oVXZObGhIdTBaNnAvUHNmT0EvTUxK?=
 =?utf-8?B?dFBEeDh0NTMzS1pXV1Nzakd2eGhTbXZnYjJaVCtKTVFTa1l3b2NoZVZpS1pr?=
 =?utf-8?B?d1pVVTRCSjk2eEFHUXdGZlJOeUVzTDRMSmRHOVlkTGNFQnRpNmZ6b2ZGbmpr?=
 =?utf-8?B?dWpSRkhiTktzOVY3WDg0M3FzU0dIc2xtS1Bka0UrUDFxMGIrRkkxVkxpRVdT?=
 =?utf-8?B?cnZUSTBvVUJaR01qSWEvbnNsaGllemJRQmFMa1dISXZyemtqMTRLTVRiT2RO?=
 =?utf-8?B?TlNHek9ETHpDaExjQ2Fsbi9BMkJMbmhqSXhXcWorbWpobHI4a2Y0QWhRSkVX?=
 =?utf-8?B?OVBUemFLYmU0ZVRIRTg3VEZCUDM0ejRlcVhrcjRoRjJmYzEvc1BjaDVQSEc3?=
 =?utf-8?B?QTJyVkRaTE9jZlY0K0tnUzczSFhUY1RLdVQ0elhiOVR1dEREUjhlQ3dudXhu?=
 =?utf-8?B?QzZCUEJCOHZiTEJmTGo1OU8waVpnY2YwODlEUlFSRVJBd0JRZXVrUjhHdnZE?=
 =?utf-8?B?NUIrUy9pMUtHVGhjaHNucGo1K3RJQjJ3MHFIbzMwbHJ6REwrVjRoL1BxR3F4?=
 =?utf-8?B?SzYzc0xVZDMvbnByNHJ0T1hNeDMrbkUxYTJlM2ozc3AvYTIrbmFPTTFlT0JU?=
 =?utf-8?B?Q3d5YlN0ZjNDVWJBNWQ5Q2tPQW0wQjVPUVZFcmlabkxJcHMzRTJuNld6ZTZn?=
 =?utf-8?B?WkNTQ2VzNldrQTN5OUwwSk04Z0x2TE1RTmlFV2VwbHVudlFLTGVkNitHcDg3?=
 =?utf-8?B?L245c0NkaWxaUEl0WE40S3pDcnhNTmdmRGtxbFVheDFPQWJsN0FTY2VocWp1?=
 =?utf-8?B?Y2M3NHE2MmNuaG5XN0hMRVJVOE5DU0tIUHYxUllVODA0c0NEaWlTTGhTUzIx?=
 =?utf-8?B?dloxdkVGbkNQYUl6WE1BQ01PRlNyZlpQbFpFeHc5TGJmamZnTUc0aXJaeXdp?=
 =?utf-8?B?UkFiTzJob3pHQy85MU9PSFpsOGo4Vy9RQW9GYVIxVFg5cGxhY0hxMXN2OWIw?=
 =?utf-8?B?dWxUZFBPVnZXOVM4TXU2NE8wOVVqQmMwaTkzUkRpenozaXdGS2RzMUhaTmIx?=
 =?utf-8?B?TlYwaVpIYnZmNzZSRU9PQ0JtK09PbDY4dk9XK2RTSHhESHJSMFAzTVYreGZi?=
 =?utf-8?B?c0JER3VWK3BEOGp4UllPSjJ5ZDMyVERzYTAxZnFnT2hHbmRha0F4UjFWdnJW?=
 =?utf-8?B?Slh1QXRpbjBtd2w0TXpiaXpHeEY4d1IyeXh0UkdoditmK0Z0Q2hyWVdGSHgw?=
 =?utf-8?Q?BR2AjCCc07Okk4HnYoJqbaH1I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8ccf1e-de97-4d97-6163-08dbe49099f4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 21:36:31.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ar7MKlXD3elLperzR2Z0IpxQeMVqhHhIpHrtn6UCC4ezNsPib3UxGrwLg8iOvsKircA3O0f1TApLVnHpqYY9LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/2023 10:17, Raul Rangel wrote:
> On Mon, Nov 6, 2023 at 9:14 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Intel systems > 2015 have been configured to use ACPI alarm instead
>> of HPET to avoid s2idle issues.
>>
>> Having HPET programmed for wakeup causes problems on AMD systems with
>> s2idle as well.
>>
>> One particular case is that the systemd "SuspendThenHibernate" feature
>> doesn't work properly on the Framework 13" AMD model. Switching to
>> using ACPI alarm fixes the issue.
>>
>> Adjust the quirk to apply to AMD/Hygon systems from 2021 onwards.
>> This matches what has been tested and is specifically to avoid potential
>> risk to older systems.
>>
>> Cc: stable@vger.kernel.org # 6.1+
>> Reported-by: alvin.zhuge@gmail.com
>> Reported-by: renzhamin@gmail.com
>> Closes: https://github.com/systemd/systemd/issues/24279
>> Reported-by: Kelvie Wong <kelvie@kelvie.ca>
>> Closes: https://community.frame.work/t/systemd-suspend-then-hibernate-wakes-up-after-5-minutes/39392
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/rtc/rtc-cmos.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
>> index 228fb2d11c70..696cfa7025de 100644
>> --- a/drivers/rtc/rtc-cmos.c
>> +++ b/drivers/rtc/rtc-cmos.c
>> @@ -818,18 +818,24 @@ static void rtc_wake_off(struct device *dev)
>>   }
>>
>>   #ifdef CONFIG_X86
>> -/* Enable use_acpi_alarm mode for Intel platforms no earlier than 2015 */
>>   static void use_acpi_alarm_quirks(void)
>>   {
>> -       if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
>> +       switch (boot_cpu_data.x86_vendor) {
>> +       case X86_VENDOR_INTEL:
>> +               if (dmi_get_bios_year() < 2015)
>> +                       return;
>> +               break;
>> +       case X86_VENDOR_AMD:
>> +       case X86_VENDOR_HYGON:
>> +               if (dmi_get_bios_year() < 2021)
>> +                       return;
>> +               break;
>> +       default:
>>                  return;
>> -
>> +       }
>>          if (!is_hpet_enabled())
>>                  return;
>>
>> -       if (dmi_get_bios_year() < 2015)
>> -               return;
>> -
>>          use_acpi_alarm = true;
>>   }
>>   #else
>> --
>> 2.34.1
>>
> Acked-by: Raul E Rangel <rrangel@chromium.org>

Now that the merge window is over, can this be picked up?

All of those people who reported it have also reported on the matching 
trackers that it helped their issue.

Thanks!
