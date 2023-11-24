Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FCA7F733B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjKXL7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKXL7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:59:37 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF7810CB;
        Fri, 24 Nov 2023 03:59:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaJAoQjj+e3uMBHohIDJrTwjY4xSHQ3kyoY4ri/3ZA2T26BPP+8DDWd9m2LPLp53A1nGCNEtt/OYmcldq12UBCVlhSH+gIMiOpAtNyPoQhj5JvRM53CriC0jXolp6ZlRJp+eXDqOyQ2uA/jVPGGlDj0HppBrczoIo7mED+t/86XDDzPk/nuBykf471Aof5Dm7jk0UJOqriHpLhF4L2R7CPUSJ2tbjxhsZU7icGeGX7XtjGNipcZwtjB+F/JhBeqiApKz1wErx04Ur21aWQt7KkywFFP6dfjZGEY+oumEArCTi71u08dmLmP/3DkoAdDNMt8hlP/V+MyYlARQrJ9S3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Nbj9GfG37IZIiw33AWvU4/ew9j3Zz8XFL779xP7vWg=;
 b=GlJXKV8AaeQBQotHbKxSc/v/9Weu3m9wt0xpF7Sbcyi97Vz14ey4qFKl5/LF+qUlmWEEcwNzTtyYcQ0YCAK99VWSYsXb3pa3oghlRyzWBZNxoK1/sJwwESPLSpRIn6e+NPabqGGjOEKBjs40LSEN/oo+PdeSWfmnvm+zAC2qmB8bvor3GtZgP7pFEf9v9PnHgvnB4CxZ3xMcSYgwqz+lUGyL0s6BgBtld2ZXkjMFgitufojW7UO3OUGxx/ZdiEEturPT3yZkuAhMSnMryCWfEqUAROl66xuAJwK4wR5jqRAEpHiAw8ar7317hbf0KWVfVgI1lrSbzi/7YYHwhjNTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Nbj9GfG37IZIiw33AWvU4/ew9j3Zz8XFL779xP7vWg=;
 b=dTgRc5AL9HbmJyamaLOCWvnWP5FzODw8qAmKNd6OOtDXlnmjMgU4YkMXTl6U5LfyfppchuFbaKeablAFJChkqiRBcKD7kYQjScVgJVPQIyd4R4yVYXiYvNNHyRTiT2wPzvUokIUsRLyEfHTrbIPhYyMexvMlCSQ6mvAOZ5UfXYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Fri, 24 Nov
 2023 11:59:41 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 11:59:41 +0000
Message-ID: <06512ea8-9124-42b4-beb0-f302539aedeb@amd.com>
Date:   Fri, 24 Nov 2023 12:59:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [LINUX PATCH v2 1/3] clocksource: timer-cadence-ttc: Do not probe
 TTC device configured as PWM
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Sayyed, Mubin" <mubin.sayyed@amd.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "mubin10@gmail.com" <mubin10@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
References: <20231114124748.581850-1-mubin.sayyed@amd.com>
 <20231114124748.581850-2-mubin.sayyed@amd.com>
 <d37db10b-f9fa-49b0-8b1e-36e20acbcfd6@linaro.org>
 <DM4PR12MB593888B73B65D25E42490EF29DB1A@DM4PR12MB5938.namprd12.prod.outlook.com>
 <e0f28ec5-b980-490b-a857-5218fe521381@linaro.org>
 <DM4PR12MB5938CB10059DF7E39A2A0E239DB8A@DM4PR12MB5938.namprd12.prod.outlook.com>
 <a701ba6e-ae4e-4c4d-9d93-c54e56c3348e@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <a701ba6e-ae4e-4c4d-9d93-c54e56c3348e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::28) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SN7PR12MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa7e257-6492-4013-38a8-08dbece4d6fc
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daxkOr0dSk5qEEy7RVgbUvH4EbrnIGSj6a95l091nSo5vab2oispu0j1Wds+bI8KODM1FC/IjQCXtzzeApM6Nw4ef6vuuuI3qYbdSdDmLjykoOMA9hi7tMQ9LzlokNgr6lCRRQO9C8TyW8DbWIQepjMlifVpw8H/ax6xHYImoZ6GHKKiBkoQEDR+1qMQ7IN4wwTYvI05YLBL+EXQYYOAq7vfCvPI0H5sAavloepMncqWJNmy84fulRfs0l5s0IusDon6vltRHYBsOYP15TfuQYV9SmksyoNJ0lm0a0xjdknpNn3zVi5jc2od2rYtMEvJyNuWY9VbHjfGVo3MBeLBcdi9u/Fh7U/W3rjRO9JQKJkZHh1cWwiPD9q5A+MUx9juNTTsRot1HSabDyKSp6XTcD2+0yr6MRt3+BKpccgsjX5YJkONl+4o61Ai8ClrsPSYB1sgg9P+h1e80vCSre1GVOsU1SnrdKCQyz3zpyX2qs2QxwdiW6dURSQH+A1qdRp5CuO1xh430XPivl1utPj1m2QdIWelylulr6A9oxXZem8uR3jast6So6MAVMbi4RXaybnYyxXNmEKHXky5wVm9As3h/FlAY9S8F86/0o97YTCF88yEnYHQonf0Yax3hDzRXNoRJf/tWnw+WRxyirjnWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31696002)(6506007)(6512007)(6486002)(2616005)(53546011)(26005)(7416002)(6666004)(83380400001)(8936002)(4326008)(44832011)(8676002)(5660300002)(41300700001)(2906002)(966005)(478600001)(6636002)(316002)(110136005)(54906003)(66556008)(38100700002)(66476007)(66946007)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmZOb0VuVzNWdlhYaTU4U2x4c1REeU1IaFYySDVWUS9SN1JxNmtBMy9TL0h4?=
 =?utf-8?B?cEZmT2x2MWJaeHVyNFZ3a0ZzTU5xaGR1a1NwTGVlSXVRM0U1SXFMNkdoNGh5?=
 =?utf-8?B?WFJHbUZ4b2hnY2FEaHQ4VE1GNnpGbUk4b3BSS2pwajNlVlZza1oxYS9iNVRS?=
 =?utf-8?B?STd5QkRmeHBZOFptWVdQYk9TUmx4dVVVNXR5eC9PL3d4aE5mTnlYM2Z4aERV?=
 =?utf-8?B?UVcyZTk0V2NlNnNWUHNHYmtWekFmWXB0MmgwLzE1R3JBc255cVFLY3dheUFX?=
 =?utf-8?B?QVd6SFd2bXkraXJLV01yWHk4TERabkFUMU9CemFuT3Q1VUV2RUV2a3ozdTJo?=
 =?utf-8?B?bDRtWi9iMFA2enY4SG1mdXNLQWRtLzYzc1RDaHR5N3Z6NkZ6NTh5N3E0VWFi?=
 =?utf-8?B?TUpxS3dhcGQyVFB6TEV3aUhtc2FTSllJRTdRdHhXVkgzNVJDN1kzc3RNcUlu?=
 =?utf-8?B?alBVbnZEOHRacEpkU0NOdTAxM2dhL3J2dG5rZDRaZlkvcGJwMDhPUXFKeFl4?=
 =?utf-8?B?QVFST052MW5WR2hjUnB4TnVGWkF5eFMxaThuQWMwWlpIOXFDS2FJMTFrZThq?=
 =?utf-8?B?dlB3TERPYmNGU3FxbmNhdU01NkdlVG9GNVhTU3g3Q2phajAzSXlFSTgzRThQ?=
 =?utf-8?B?ZjhON3F4VHdGK1U3QU5hK0FtWjFIUWtGVjh2emdsZmxMa25iMGVod2w4RjFQ?=
 =?utf-8?B?RTMwNEREb2JXS09kMjZVMUszWWwyby9mc3FDMUk5bFZDN2JLWm9tSnRoVU1O?=
 =?utf-8?B?eUhEQjUrVUN1dWZYMHZZV0IwOCtpR200LytzYlZpc2Z0UUhmWDVBYUh4RWZT?=
 =?utf-8?B?K2RkSGFsc0h3TjJYanl2cE1wQWJucEFLK0NwWjJ1MUZFZVV0bGVOQ0REUVBh?=
 =?utf-8?B?Q2NMMy8xY3pqL2xVblQwZnhYcFJQaklGQ2NtZDg3dDBRUU9hQXBUaElvMFhl?=
 =?utf-8?B?VzNnSFRETVJTeGlvUm5JUm1SUmw0cnFWVmZYYlc2eTNWUklFbEpuQTRpeGxa?=
 =?utf-8?B?SnY1WGMzUmcrL3UrbGFQZVRwc0FteXV0amRtMmJsUzl6d3dBVlEzeEUxUFlD?=
 =?utf-8?B?UjhRMGZGS2pFQnJUR21uVmlWeVVzN1MvRUdEOWJyNklobWVxRUpyZTZkMkJo?=
 =?utf-8?B?a0V1OWxPd3NuWFJFaUJDOVN3RzlYNVNpbWhuT2E3bDVRU1N1NTB4ZlplUFl1?=
 =?utf-8?B?MEp3UUM1OFNMZkIwVzZGY3l6UytPMzN1THgxSVJxNGZmQlc3TDBXS1ArWTFp?=
 =?utf-8?B?STFSZ00zRlNGQTZRNm80NE12b1FERzhHRTBCT0NWMHRCRnQ1RFJUaFRxOTda?=
 =?utf-8?B?dUh4TjVwNU9nMklJakRnS2ZobmcxNlFDSHZGeWNFRDFzYTRvbk94ZHZlbFRN?=
 =?utf-8?B?STRDMm1jWmFJa2JLQi9xaVI0Wkx1N0ptSjF3dk5CSDhodkRRS1R0MW9tMFV3?=
 =?utf-8?B?UER1b1BENzJIZ2RCMnBsM1lmUWdVRThHSWs2Z2tDaXVWZ1MwdHhMY29TTTJB?=
 =?utf-8?B?TnpOcUdWWWVWZFI1WTlIOFRyaGdwVFN1cW1tbSt4cTdtTWlkNjh4L0dueTd5?=
 =?utf-8?B?enlHdGI5MFk3WXNyREJBV0M4aSthQnJjUndWV2JEOW0wZ0ZPMnVKZkJwZ0xa?=
 =?utf-8?B?cWNQaXRGdWQrTGVqbzVxNUlkQm1LT0lwUHBySVlnL3J2NENEaEVBZnNIMXdT?=
 =?utf-8?B?c1VHQ3V1YlJRaGJsNW1TbkFMQ3dZYjVvWC8yTklFTFNxUHp2cEIwRUNZMlBz?=
 =?utf-8?B?cGhXaDZPWGw2Z2dwRmlrZTg2cHJZUG1zYjBEQWkzVWljRTdiTFpPVDJMcCtu?=
 =?utf-8?B?T2piL3lCMmNPak94VXl6T05FRXB3ZjBoR0N3SXE4d1dJRHNBTnhnVkIrTTZL?=
 =?utf-8?B?VzJjUVJZNE9qNmZJbHM4dEQ2YnRpOCs5Rkhjc2J3M0pCdzMwdTI0b2tGZXZy?=
 =?utf-8?B?UW5ZbkNjY2NFNzVSQzhRR2t3MDF0QTdRVHF0cDNRWXJuTDFzaXBKTFNieW1C?=
 =?utf-8?B?VXRHd3kzcXpFTTYwcFNRMVh5czJQNTRrU2JQOXA3L25jL0xSM1dITlE4Wmw3?=
 =?utf-8?B?UnJtZjZGVzlSWk9vQlFXQ2lGRmd0by9sYXcvMVNDT1NRdXZ4YUp0YzY3R2Ur?=
 =?utf-8?Q?Clzqe9QBT0Mi9eOdZM284Fj/M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa7e257-6492-4013-38a8-08dbece4d6fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 11:59:40.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhqObKB8/ap75niOc48eNfHZR/WLPnnAlGkMRWKV4rveXBw5mZAo8RHjlbD2lLxn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/23 12:35, Krzysztof Kozlowski wrote:
> On 24/11/2023 12:03, Sayyed, Mubin wrote:
>> Hi Krzysztof,
>>
>>> -----Original Message-----
>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Sent: Wednesday, November 15, 2023 5:41 PM
>>> To: Sayyed, Mubin <mubin.sayyed@amd.com>
>>> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>>> devicetree@vger.kernel.org; linux-pwm@vger.kernel.org; git (AMD-Xilinx)
>>> <git@amd.com>; mubin10@gmail.com; krzysztof.kozlowski+dt@linaro.org;
>>> u.kleine-koenig@pengutronix.de; thierry.reding@gmail.com;
>>> robh+dt@kernel.org; conor+dt@kernel.org; tglx@linutronix.de;
>>> daniel.lezcano@linaro.org; Simek, Michal <michal.simek@amd.com>
>>> Subject: Re: [LINUX PATCH v2 1/3] clocksource: timer-cadence-ttc: Do not probe
>>> TTC device configured as PWM
>>>
>>> On 15/11/2023 06:55, Sayyed, Mubin wrote:
>>>>>> +	/*
>>>>>> +	 * If pwm-cells property is present in TTC node,
>>>>>> +	 * it would be treated as PWM device.
>>>>>> +	 */
>>>>>> +	if (of_property_read_bool(timer, "#pwm-cells"))
>>>>>> +		return -ENODEV;
>>>>>
>>>>> You will introduce dmesg errors, so regressions.
>>>>>
>>>> [Mubin]: I will change it to "return 0" to avoid dmesg errors.
>>>
>>> No, because solution is wrong.
>>>
>>>>
>>>>> This does not look right. What you want is to bind one device driver
>>>>> and choose different functionality based on properties.
>>>> [Mubin]:  I am doing it based on earlier discussion related to AXI Timer PWM
>>> driver.  It was suggested to use #pwm-cells property for identifying role of
>>> device(PWM/clocksource) https://lore.kernel.org/linux-
>>> devicetree/20210513021631.GA878860@robh.at.kernel.org/.
>>>
>>> You are mixing bindings with driver. I said here about driver and yes - you must
>>> use pwm-cells to differentiate that. It's obvious.
>>>
>>> So again, one driver binding.
>> [Mubin]: I will explore whether mfd framework can be used to handle this.
> 
> You do not need MFD for this, because you do not have a really MFD. This
> is just one device, so I expect here one driver. Why do you need
> multiple drivers (which also would solve that problem but why?)?

this driver is following pattern which is xps-timer (soff IP)
Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml

which has two drivers in the kernel.
On for clocksource
arch/microblaze/kernel/timer.c
and pwm one
drivers/pwm/pwm-xilinx.c

clocksource driver will be at some point moved to drivers/clocksource because 
that's what will be used in connection to MicroBlaze V.

I have looked at TTC and functionality wise it is related to
Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
or
Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml

which are based on MFD.
Timer there is only clockevent not clocksource but it shouldn't really matter.

The biggest issue what I see is that ttc clocksource driver is used on arm32 
Zynq family for a lot of years. It means moving to different binding based on 
mfd would require keeping support for old dt binding too.
That would be from my point of view thing to start with. What do you think what 
would be the best way forward?

But I need to do my homework first to see what functionality that IP has but I 
am quite sure there could be at least multiple PMWs.

Thanks,
Michal




