Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BE17FAE79
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjK0XhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjK0XhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:37:21 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC49B1AD;
        Mon, 27 Nov 2023 15:37:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsQyTc+hKWdwhhp5uzVxuLx9b16YQKymVjrsZLRIz6vPMRGIxs2ZwaZ29bi48aZmpParwxcQqzPq4ACWdYpR6067yns8j5fqe6s9SaJ3giy37uxpqKv4V/bxvcPMotPWbnpdP+0tT6H09EH29fKo5K56pzOfLjX+/TnMU/Ha49xALlHS9ZQMyBwOlxNgmNalbozlu+DcSxdup3CiN08e/GjEoObv+gpfE1ZvL7Jf/TsLsW+5VPPAPVgeFIgYtJFxwUhtw5vSXWiUPEcI3Xg/7DXMYQy4Zy42eBvUYx2zJvaew5mlpgq8c7vBU9UoDK4fqz4351h7xxjPOdyS4raDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBsiM2TdcB6Ia6SZ2jekLOhqCTLS5yh9K4zHK1Br8YI=;
 b=Bq5ngEa9dzQB5WHfmzOQy2eCZCNAhd9nXkHI+ZeSlwpu9irfRTRip0St6vfekeaDlJoUrv4OU9on26Ja3xAQgW2IaJwOq1uJO2d7w2E4HRPnlD4rPYxzp8A8BRPDAEuQbPB1aS+h0nQkrzRe43a3rYq0c8UCWaTB/eTM6IqEMYmK5HsQzlf1O0UbRn2oa2wqgACFl7w+IgyeHIl7sZiZQi1RxVrXJRWvRjllwlF66t8bqCVvk0NGAB5H2ZkDkAFJ2E8UT6UiEHQ6QREB4dXOs4fR1vBVxtpTd+uq1gErKY1bVODX9+JTQlysBPM0DO6SV2UrxwralNw3XouaQ5WNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBsiM2TdcB6Ia6SZ2jekLOhqCTLS5yh9K4zHK1Br8YI=;
 b=PGA2PdxR0Z0K6qeMquRZDLunBX2yYAW/anaN+fUNOpRYdW5OGSvqnoCsw1eLwqossHu0HjlhAS7rEwXxqkvTfurRVgkkxrxiDnCqB9SoGkgU6e2fDDDsNI8zTJG29bo63W2lu/MwnUeeb6AQQ3LQHA30Wgx3DIutYlQjG2UhJb0wZiLKmAe96Bl02hKILmHbTFKGXbHlDAw2/TuxYOOc24OZdhuFHPQEWnbN8RMfoyKTgeyHUllS3oIb3fgemmBh0PQCWjg/UL9QZz+Qk3xv88jJFK8LbtI+n4ssG/FA7CzG3VkQT+IwvbxY0mXyszXnuAt4oHvFpgD8dTm6R7dsjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.28; Mon, 27 Nov 2023 23:37:24 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fb84:50ef:dbb8:1ebb]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fb84:50ef:dbb8:1ebb%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 23:37:24 +0000
Message-ID: <6e45696d-fe6b-4570-8ca7-481de78a983f@nvidia.com>
Date:   Mon, 27 Nov 2023 23:37:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/187] 5.10.202-rc3 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com,
        linux-tegra@vger.kernel.org, stable@vger.kernel.org
References: <20231126154335.643804657@linuxfoundation.org>
 <fc421b26-ed60-48fa-a2f4-0fafcb44e91c@drhqmail201.nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <fc421b26-ed60-48fa-a2f4-0fafcb44e91c@drhqmail201.nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::18) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: d0776840-a3de-494b-e9ba-08dbefa1ceb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbJqwVtRv5XUDx36kdKOUKGGBJgN01IkAOXbeisBI70FKt1MKcztCm1bPRf49zh2dAhaTqGsx64Dty5k3m37L/7PZthDGt9N+/1OasnyOeRuWrQDGAekL/5WQ7w8yyAOrUUzeKPy3AZi6JxjtevZsnXE2bv7j2ajWX7p0qC/us/ZjaguaX20BU4RiH8m7QCUgMx7afBH7ulYB5VNGBQmrgd/6BD1fhp7rKRyLlgib/OcP98q91DM5fqp8HicNsPcVlNywBg9MwwAGpelgObgn8896XZ0c73nh9puixawPjwShTkX/Jr2nbRyIAf5HqOI88xYVEy9Rb6RcPGn+F+0Ong8H1Phm+RtqXcAFtLlpMLFeT5uCEfwRn59x5Rpem0vuwdkOJOhDzNo9rttlArxyKZ1yV1qWDFAllY4eF/g/u+5i56h9GLHxRjtIgapZgl99x2LS4aWn7tu8E+EXvcslbWpWUDDquIb3NlHpeNEx3yILIGfKnaYp8V+tmH9QsnTuBVaRPck1E3HA6n2UrW6qpbyB1YXeEAvMipdvk3WLz/exJxS+D8735D6lBoyemzk6YdTqo1XS8rQS5eHrpAvPKJhNIV7dSTEwGCZvmgOGv0Eyba+KYqEiIINeY8z2DXwJrFbm0LK1fn3SZnAjvtGpPsVTb8TaHaFH+R8/0Klg8uEb9WxnQMTeYoUoprzsA7nOBA8hKyS5Se5cEdLvOGlvt5HRv5KWGiS77eIsTJGlk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(41300700001)(36756003)(31686004)(83380400001)(7416002)(5660300002)(86362001)(2616005)(2906002)(6512007)(53546011)(6506007)(6666004)(8936002)(8676002)(31696002)(4326008)(478600001)(6486002)(966005)(6916009)(66946007)(316002)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bS85cGJLR3JZekVHbWtnejBWbE9SNkdQUnBRTGFwRmxIVnRhcEluM3FnYkpN?=
 =?utf-8?B?RGNOaC83OStuWGRSMlRTOFI3MGVrQjJSQWV1bDhoNW5YeEpoZU9BMVZMelJq?=
 =?utf-8?B?Tzd0ZW9TU1BJejlYSUcwZXYyQWV6bWFqdTNMeEp1MzhYL3dBemRDSlRjN2JZ?=
 =?utf-8?B?alBla0J2bnljWHBQZjdML1ZJOWJhUEpQYi9sTVoyZ1AxaFF1RFA3MXdVNG9h?=
 =?utf-8?B?WmY4aEl3QWNTSS9relh5M2xsUE9jRHkveW5JS0RxUEJPd0FTNUNFNFIrK2dB?=
 =?utf-8?B?VnNxdlA1R2dXTzRCQ28zZCs1UkxTSEl3UWs1dEZoMzk5MnRyU1Jsd3kvbHEz?=
 =?utf-8?B?cUdtWTdJNm5oNUJoZWw3T1A2WStPcTB0UDlwNjZvbHBpZVBidXl3ZmRmcWRz?=
 =?utf-8?B?a29iWGF0QTg5ZThyMHBVdUNsUmZEclNpejlWTVZMd25UN01XT0IyQmR2OHZK?=
 =?utf-8?B?NzNzNDBwYUJEQUNGZEN2WGp5aEMzck5xZSt5YWxMNS9QSXlwMEJ5RjZYTmJU?=
 =?utf-8?B?RmhPRkxLSFhTVXpndVhGaG9QQlJjMkVxM0lYVHhBVUtFRGpQYTl3YkpjZzRm?=
 =?utf-8?B?ejgwQmROZWF1Vk94K3dCUWxRN0cwK1IvTXdKZmF1Nk1GRmkwLzVYd3IvSWRD?=
 =?utf-8?B?Y2VxbFRnL2V4RnFuUW9jb0p3aW9sRE9QeERlOFJwaEJ4NU8vZTRmM0hwYjJJ?=
 =?utf-8?B?WkZQR3FDNjd2UlFLc0pBSHhTVERXK1BGWkYxWU10K2J2KzAySE1FaEtYZ1Ex?=
 =?utf-8?B?ZzF0cVpEUmFaQ3N4MmptZjZmbkZWNXlYbHV4aGFSUytzMGlXNy9CSlE4NEpp?=
 =?utf-8?B?OEhEZ2RHRmVnOCtBRGxRa0N6SFdsZ20zYTE0U0Y1MjduajZ3NVpSbVppK1dt?=
 =?utf-8?B?Wm1Vbzc2S0dzK05hY1FNRXplZG9jY3JmUFU5WitxUTZCS2xVaE5UN1F5cXo1?=
 =?utf-8?B?dU9xVTdNWDlIMi84TmQrZjViOWpqeVIvTkJteTFLRk9uUmZqY3hRbXo4Rmor?=
 =?utf-8?B?Z05qNWNqbWZvdENqUDRETXBPY2dJLzhEclFyMGZZYlcrNjY4QUpOeG5pT0VO?=
 =?utf-8?B?bm0vb0I3Z2dabE9jL3hudTRlMjNvSll6eXEvWDZmNG1VRHI0WEJVbmVnN3Yy?=
 =?utf-8?B?a29KOTg4L3ZraENYTjE4c3VGQXNTdXdpRTRWOE1BVC9hUUM1eVdsa3RUa1BK?=
 =?utf-8?B?dkN6VVRKRVVQWHBCTEduODBUUVgrREJHcVJwNDFhVGpIS0hMejhaK0s0N0Vu?=
 =?utf-8?B?SVZmSHNSWW45YWhyWEFCbkVnM0NObStWMGYyYmJqT25TcjBQZkd2TjNvNVRz?=
 =?utf-8?B?VGdnenhHdUxteWlSRTRWQ2VOcjEvQnZEa2QzSFI2Sk82aFg2WEVtcjA2emZP?=
 =?utf-8?B?VGFuQWdCMTBLazNrcUpnYU9HcE9DR3lNbjREU2FMU08wQXd1aUxXd1NRblM1?=
 =?utf-8?B?ai9pclQ3RXYxRVFreXpiZC9MTTB6UW1yaDhsTFlVWmxXZFFUYzBNNWdQUklB?=
 =?utf-8?B?YzRUbVhYQU1rWEtRUnZ3TW91eGxmWG1vdFNKbzlBUjV3cWJscC9xVzYybmR4?=
 =?utf-8?B?Z2paa3B2T1lZRVc5K0R0L296cVZqUVBGUFFlbHFldDVjNHByN1hBR01zeXoy?=
 =?utf-8?B?T1R2bmdCZlJrYmh3V1gxRTJldi9vcTVlNlhXR3M4cm9YckdkdEowbFpLRFJP?=
 =?utf-8?B?YTZ4S0RRL1F4Y09RZnhBZ01LSmljZ1hScERlS20wdXMvRzZMaXdLU0o3VGNk?=
 =?utf-8?B?YzJNWmU2OEI4bGdFcVZSNWJMRU9rSzVuOXhOSzRUS1BKeWdBV09JQ3h4VVJy?=
 =?utf-8?B?b0lRSHFIaWh2VlhOaU5mQ0pyKyt1MXJFQ3dXY0JlMEdaUlEzeVBEaTVHYTZv?=
 =?utf-8?B?eXhXbnpGM2I0ZmZsOFczQlUvUFB3UkxidFY2MmZvVGZKS216VStSN01pV0lo?=
 =?utf-8?B?enBKRktWNm1DbjNSTTRqNHdqaHZHZFM3U0ZGOFVNdWgrWWdpRFdhR3EySUF5?=
 =?utf-8?B?SC9ZNm1ZUlAvM1piMldtTVpwWlR4ZVFOUlB0QjFQZjd1SUh3K0RRRlJKQk16?=
 =?utf-8?B?U2M2ODZqczlvTHRPK2NreWc5OWsyNFU0akl1cTFMaGx3YzZabnY5NHJFQ3Ey?=
 =?utf-8?B?YjZ2ejl5YyswMFpBazVDRXZ5ejByRmxrM2YxTWJrZFpVY1JXT3AxamZ6ZGlp?=
 =?utf-8?Q?/PnPCme/nKql2MQm5WcQ2DNIqxiqHFGlqNRu86VwrCdE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0776840-a3de-494b-e9ba-08dbefa1ceb7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 23:37:24.1542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AMl9bm9LvRUbJuTyPxN/Ju8C9NazdkvyPsXnFPWZ7+C3CvEkQ53T2wRte99OmThuE8V8Jr3Kod7NGzKTZZf8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/11/2023 23:27, Jon Hunter wrote:
> On Sun, 26 Nov 2023 15:46:55 +0000, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.10.202 release.
>> There are 187 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.202-rc3.gz
>> or in the git tree and branch at:
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> Failures detected for Tegra ...
> 
> Test results for stable-v5.10:
>      10 builds:	10 pass, 0 fail
>      26 boots:	26 pass, 0 fail
>      68 tests:	67 pass, 1 fail
> 
> Linux version:	5.10.202-rc3-g80dc4301c91e
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                  tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
>                  tegra20-ventana, tegra210-p2371-2180,
>                  tegra210-p3450-0000, tegra30-cardhu-a04
> 
> Test failures:	tegra194-p2972-0000: boot.py


After commit the commit "gpio: Don't fiddle with irqchips marked as 
immutable" added, we observe the following warnings and is causing a 
test to fail ...

  WARNING KERN gpio gpiochip0: (max77620-gpio): not an immutable chip, 
please consider fixing it!
  WARNING KERN gpio gpiochip1: (tegra194-gpio): not an immutable chip, 
please consider fixing it!
  WARNING KERN gpio gpiochip2: (tegra194-gpio-aon): not an immutable 
chip, please consider fixing it!

The following upstream changes fix these ...

7d1aa08aff06 gpio: tegra: Convert to immutable irq chip
bba00555ede7 gpio: tegra186: Make the irqchip immutable
7f42aa7b008c gpio: max77620: Make the irqchip immutable

There are quite a few other drivers that were updated in a similar way, 
so the above only fix the ones we observe on Tegra.

Jon

-- 
nvpublic
