Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E56F7FAE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjK0XkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK0XkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:40:01 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3E3187;
        Mon, 27 Nov 2023 15:40:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMIwyeo+GrB2jimioY41tzKn2Mna68fVlmFiSCKYWjYD/MkCS8IX25OwUJg2PZUpHu5fJuzEYGbvtoES/7R61XXyKU5E54K5RF3V6sbnsIOgyt49iQl6PwvRfgeUPJPhL0cxtZXVBbjbedAUVTNSPT42J2Zq1HmZq6e4IVJ6mR/MYQGAnBx7Pa8mQNUUf9r9jLFLul+EMFgJQ3pEjRnoO6wATmsgrTmSsnF8/5jyzjbz9hHKSlGJblN23QJghvtYvjxw2tx71K5A/rYlajAyyZeWQsF590o3PQ8Ed6A7cwAF8TFenXaA9j/VasYUkz4zyDumPet4XS7IsCOSHqDYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mw8mK4Q+2Cs4UNcaBF6dcAp1wy7UIyOTOlTmwbG33C8=;
 b=VlpQh9bCQ0nDIEAqr2AJuMpTaS/7xxjVeT/vd/NsInKZXSVGfidL3XlRG35d21sC/UQ9zLBE+yCk0HTmdtrz5bq851ImiObLLT4Y2L7fnge9llBqPWNhPN3kXJfym5CSaNqGggQopeRh5JUCpuLXvvgOMu/jklZQFU4bnQNE0jKh6eDUagY7F48MV3sY4LqeTEve54CY2I5ys1sQo0MaDqB7j/T/KyL8GzlmHzRh4DQI4z4YFfdfIIpIC3YoT+2rEthiTP4NY31EhQ6i97eDuyQIqpkP2hPJWRuWSPxgTf3f02kvgS7rfucVZLwyqljIK42u3V2yZe+6ffdyirJMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw8mK4Q+2Cs4UNcaBF6dcAp1wy7UIyOTOlTmwbG33C8=;
 b=rew0cp8dfjDbwkkUS8f6vQtv3XxhlEUPxdyA6352takFr/5L5WTcbY5zaMgXErxg1+43OxWokTTJyzJwPwvuDspoUEJ3vjHfG+9dTVBuFZNY2U+OxJhS0N0f7pwWF7AAjoawd5TxziQX/fhtGW2G3a74aHfWSNEtXT/ByxQO9wIjkrUoKIGLmRNjFp0bGxbODaKwpDO5LKkumQx8fhcTC8637JAViPqZqQ6j8VgWxAhR6R7KR1bOv276VmECVggCELq56MhbZmgzybvZKtQF+8JWEf9rBkGphljZ2iyHRm80cJrwfbMtAEG/53qgzAsWswEfbw+hjalmf+h/O0AjvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 23:40:05 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fb84:50ef:dbb8:1ebb]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fb84:50ef:dbb8:1ebb%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 23:40:04 +0000
Message-ID: <fd70197d-27de-4e93-bd89-69d12428b664@nvidia.com>
Date:   Mon, 27 Nov 2023 23:39:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/292] 5.15.140-rc3 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com,
        linux-tegra@vger.kernel.org, stable@vger.kernel.org
References: <20231126154348.824037389@linuxfoundation.org>
 <9b0099cd-37d2-4f19-a6bf-6f1c82338093@drhqmail202.nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <9b0099cd-37d2-4f19-a6bf-6f1c82338093@drhqmail202.nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0346.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::9) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 2adaac1b-baa0-464c-25a9-08dbefa22e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYWoFL6OyKBybEbEJN6PGpN7utTh89eA9Kc/IXOZqHMbzpe4ynB5c9IC5Dj9m+3ZzCkKAARfrApbXVrVJp0cLxWq1FKRY/rIX0RrhONBMnnvcd8fFiLtsCEG5EK45sfnhnZ3mUlZh8doYNrnf2RQMHFo5cQcNkxD1bybG+oLxK301JnE55t/xhqDXyLVkKUhEe06AO4+X/mn2x7/3wdhEauRi1KHdizpBp9OCl5W9CzxKZOxhqpfyckS0yBHPZ7qrAUYMnYEbhflHeUeZ8+7STj3kVx1jekx5iatcCnEJFN9RmD+YGSPCboJXu9P7/R/AYSik+b5+17hT8Qfi57y9a9Ik4ZeCaaOUpCo4xFGBDm2mpo27da5yUijSWXGjhFyQF1ZCxiepbgX4euLGfBgx0t7ChG966R2HIFAiGB5ykcRUqyoU4zoqlmnjvaYKRrYQ3cvwTHl731H/KjBdCGiKvrvHZR4tqV7ZYUmi4zrBtyPqEsWqQlLhuww1kJe0c94t5m2r5zVvMaHmJGSWuwTwNERM5ZNKOa/gaQ/yOJldmDDnJ8iR+kWusMNeFtYaf15JQy2zc+aOUs0gaSgUW6E+ZpvlYQ7rzmjAIMOc8rNl+1M8sL/Z2n1CtwD2i7+h9NHdUKzCRRDiJEoinrtRYJjt2QVt7POI6cAENVodiYwTcxqbFfr1r/sosLJAY6ayhLapqqzrTObMv/Vj4NCbOsv8Vyh5aVRCwEHit8Lyk0WHK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(41300700001)(36756003)(31686004)(2906002)(83380400001)(7416002)(5660300002)(86362001)(2616005)(6512007)(53546011)(6506007)(6666004)(8676002)(8936002)(31696002)(4326008)(478600001)(966005)(6486002)(66946007)(316002)(66476007)(66556008)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk9abTNoa29MRElDUXlaMkg5RElrbm1ZNGhQYW5kck1mMTZuUFpKck1MZUhN?=
 =?utf-8?B?OEdGWjFROTZXWmdJckVKQkprVzZHTnV4OHpjSTZmNVozakNhajI4NGpxSnZ6?=
 =?utf-8?B?bmpDbkRYanU5Nk40TS9tWUtDS3VFT29qVE5DQ3k2QklsNkl5WWxDNWdWUXVk?=
 =?utf-8?B?UkNKemY1K1J2OHYvTnEzTmlaMHJXOERqQmhkeEVIN1VpVExhdG51a3BPdE8v?=
 =?utf-8?B?dWZhemhYT1ZUNFRYSUpXNU9OUUdxck0vWVZ1SDd0YmlMOEtLV3BQa1YzR0NR?=
 =?utf-8?B?aGMvWHZpd01NOWJzT3k0NnNsWWRUUGMzOWJmUldZREhscFlkTm5KMVRUbXU1?=
 =?utf-8?B?OXpaR0hkNkozeStRU2JLT0kzdkdDMWJ6eDExdFRxbUd1VlRGa0toWnBxUGpw?=
 =?utf-8?B?dGpFMzk0WCs5dzJxRnJyWFZGKzdrMVZvT3R2M2s0bGNSNkFsOFFBTnF5ZkNl?=
 =?utf-8?B?RE9CWlZYNENremUwRWZ5RUJWa2Vub0lCczlQOFpaeWM5bVc0N3VaRkVDdEg0?=
 =?utf-8?B?YzdzZkVIb21TdkM4L2dzRy9wUjIzVzRITWdNaTJwck05RjF0eTlJQTdxTWtM?=
 =?utf-8?B?Uk1SQ3RoVko4elUxbDdYN2dPZzkxdTJTQm5qNjJ5OThCa0JORkdrQzc1cjI2?=
 =?utf-8?B?bWpVOTNsUWk4MnJzVFV2aGNHSXJLNVZtMllQcDVWUERET01Ldyt0bzVGRlYx?=
 =?utf-8?B?RTc1YnIvdUVESUsrMlp3RFFrYWZmYWkveWJkanpjZVpSZUhtMkdJeEY2YlRJ?=
 =?utf-8?B?ZjFPdno2NTFRSElDbUNETGdkbktERkV1MHZPa3ZXZEZRNVRVVHZTVE1aem0r?=
 =?utf-8?B?ZG9DZ3lyUURrTGh3d3gwU0xHMjBiZWp4ZVZURU1ybnU1YUx5dFR3WG1qcVR4?=
 =?utf-8?B?NjRTSG0rb3B2YndONWNzQlZ0SmZXWjh1WmgvaFc5Y2NabmdRL1NZUy9OV1Fo?=
 =?utf-8?B?MEIyNWNaemxzY2crbVZDSjF5MmJrNUwxTjY1WmtTcnZjbVZaWGtpYko3UE4v?=
 =?utf-8?B?bFFvdmVQb3BtRlBRbkpQL0ZvNTA3SmNGeUp3a0dBaUdaUG1UWk4xQ1lqRFd3?=
 =?utf-8?B?YkUxdXVDZ2F6SE5kK1hWdmRkdTZjUjY0Y3RiU1I4Q1hvZmZmV3kyNC9IUEo3?=
 =?utf-8?B?azBHZ0VIZFd3Mml6Ukd5VUtDUFc3ZHVmTUREbjd1eW8ybjNLQWR2Yk1TZzRw?=
 =?utf-8?B?eFFjNCtnWnRzL1R3VG5ZeFZkUFAvMmt3MStZbDZBUkNqak5zeGNOREFOaEZj?=
 =?utf-8?B?NGdwNkNSVzVRV1JxenM5MlFNTGR6LzdiLzNQSXNEa1BLdWo1M2pDYWlCdkRz?=
 =?utf-8?B?R24wVVQrV1VsMEF3bHdUZmhLMjdmNEpTYWt2K1BkRWVTdjRqV0N3c1VKQTN4?=
 =?utf-8?B?OTNqMUtxcUlJV2FWMHdYWDB4KzhNbFNQMEtGTUg3cjdvaHdJbG9IQml6d1N6?=
 =?utf-8?B?MWNMNDluUTBqeXgyb2lKZktJbEFFamNRSkx6TEFJSVNzNFJaempNVTgvemlV?=
 =?utf-8?B?UVlHNHRtdERxRTlZb0R3dHNXWFNUVFFhT0Joc3p4UFN4Sjh2OWNBMWJXQnhi?=
 =?utf-8?B?ZDNWc1FHQ0hOTmtzVUI0UWJuQkJLRGVrclBEVW1BaVR0NDBzWXJjWVU3S0pD?=
 =?utf-8?B?VUkxM0xRaEw3c1h2MjNKZGJHMUQvSlFyNDRDc2w1ZjZDdFZBVkZGVDg0TkQw?=
 =?utf-8?B?ZDNwNGhEdU14T1JFbXl4VnlsdDRoSnFiVHZkdjI1b0N2eGtZdGE3U0J5YVZJ?=
 =?utf-8?B?MTRtekhEY0tWTDlsWExCY0I5STF1NnAveFJ2YXpad3hKUld2aURCZnFUSUFn?=
 =?utf-8?B?UHR4cUtsZkNiYmZOdHlWV1REWVdhQnQ1RVFSMVA1YTh2WDErQW1pZWs1QWdL?=
 =?utf-8?B?S2MzR29ETzVaNXh6ZDBTWHpLeHpnOHNRM2FTa01oU0gwcGd1eWtpc2RoV3NJ?=
 =?utf-8?B?eUpqSEZILzdxUDVETWYxUTF3eTJvbCtub2pFZEthK21VcjFRV1QwMDRVd003?=
 =?utf-8?B?ZlRiTFVTaFBKOG1IdzlvMU50NldBd3FiekZ2UkcwSXJIaHRVNTVVQXlqTUI5?=
 =?utf-8?B?ZVpqSDRjeHdWZytZYTREbVNhQ2paVVdDTUtEQXUzSnJJQTRSY2Q2T1ZiRkFk?=
 =?utf-8?B?UEJEcGtSYkdSRUdqL1MyQlEzc29kaHNieXRkS2ZtWC8vbzdKUzFXWUltbHNy?=
 =?utf-8?B?OXJxWkk0dXZmZmZKbjk4RjBWa0t6a1JtL1lOUyt6NHZ6RkhBMjQ0OTNSbFZB?=
 =?utf-8?B?NUwxUm1zUER2d2xOTHFlN0ZZN1BBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adaac1b-baa0-464c-25a9-08dbefa22e79
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 23:40:04.8968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lR6TLfJm7ionEKhJuqxENPWDGDlh+K0Y439dvAt75vcCkRKeAThot49VTa2DXy6Qe3G0qHGEodPGoT3I8woXiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
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
> On Sun, 26 Nov 2023 15:46:45 +0000, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.15.140 release.
>> There are 292 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.140-rc3.gz
>> or in the git tree and branch at:
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> Failures detected for Tegra ...
> 
> Test results for stable-v5.15:
>      10 builds:	10 pass, 0 fail
>      26 boots:	26 pass, 0 fail
>      94 tests:	93 pass, 1 fail
> 
> Linux version:	5.15.140-rc3-g659e62181100
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                  tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
>                  tegra20-ventana, tegra210-p2371-2180,
>                  tegra210-p3450-0000, tegra30-cardhu-a04
> 
> Test failures:	tegra194-p2972-0000: boot.py


This is the same failure I see with v5.10.y, that new warnings are 
observed on Tegra due to commit "gpio: Don't fiddle with irqchips marked 
as immutable" ...

  WARNING KERN gpio gpiochip0: (max77620-gpio): not an immutable chip, 
please consider fixing it!
  WARNING KERN gpio gpiochip1: (tegra194-gpio): not an immutable chip, 
please consider fixing it!
  WARNING KERN gpio gpiochip2: (tegra194-gpio-aon): not an immutable 
chip, please consider fixing it!

Jon

-- 
nvpublic
