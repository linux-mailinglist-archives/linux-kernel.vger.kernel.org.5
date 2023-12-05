Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF74804871
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 05:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjLEELh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 23:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjLEELe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 23:11:34 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2CED3;
        Mon,  4 Dec 2023 20:11:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQpVkXD4YkoNkF0QFvb1o3d7b/LaZVrl33aVzn+gqNg8D9xPVd19E/Z6wrj+fhRTNqWmxNva2Y3LlwvH9KyEm9u4Gkspb/t8MfeRuU8miMQH1q6xj9VtseeGRugW5oMMzKLRAHTxL9FCQUAzhd5InybHGeyRhTPyCK0hZ5iTOgIS8kn5LSKf5JD9NzNwkoR/AmgY5eS737izcr5NQEDvzSekt+V4oMt8MLI/ilykBGeEFHoe6lhmQ2TcTkGDf8c6zhV2byS7DcBDAHGye613Rjstny75v9enTkP1hF6nyZ/po9QtwDptknuzrtAGK7c4bNtH+6OpdDXaeqEY5qMykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rlBLk+k/8bj3YhG1G5h0P27+DEjbBY64xJ9agDPVzg=;
 b=fgNZubl6VHyUeSOfyw9iVxy7rd5svvp+AvxbG4aMeJrfvuyW8Z0xM1WvX3q5iXDNwdtl3T9nm19o8pKJoAm2Y3yi8FeiIxssf9OOCvf1gdzENy+ZagRrZuYGJy1bipwZObeyNbLBxtQEg8mgzoYaJ6pKf7bw2tO9ZsO0zD7j5wYtJas/JVeBWYX9dt8wskgu6Ccn3pp+T7OTb5rtHo2qgHMsduOFVumMvYzMLBHjduZbqqlKDL0nPsUH2GlgDnOnImgxTbkNlhvHut7pHS8r+WXjrULOp9Loejiz4p0UmNWZxdbXZ8Lx+6ytRSEtTG0nQSUw6pLuksR63t+d0H2h2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rlBLk+k/8bj3YhG1G5h0P27+DEjbBY64xJ9agDPVzg=;
 b=Q9ZmfithFEE+pORqD2RkeMw1xIW+7xzxh+FCYLsZkI9QV7GXVMHqEFjYN+X3UThLcR3mUPrK0c0UkKsgJxuSF26dWiMWdAWatFD8Blkw+xJzTvuh0tfbe8isxXngGa/2B6td1FHWbaBZ+z896gH8f498iCpxdKRWAkUZPV0J1EFmOh23lIzfevYVNA0rgYv8R50KhkNo6+LwX1T5szLSY57m7ydYSK/JklYt2IISFBEYDNmWwGGn1jYf5No+BXaF9FzEmY7zsxQ18F//Py2AyUOBzy2JV22wgeH91Ji/faiDsQz4dsvsd3Jb/EkGcRFaW3J3osI90nStnWTKaZPWFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7432.namprd12.prod.outlook.com (2603:10b6:303:22d::9)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 04:11:37 +0000
Received: from MW4PR12MB7432.namprd12.prod.outlook.com
 ([fe80::396:4961:49ee:dc3d]) by MW4PR12MB7432.namprd12.prod.outlook.com
 ([fe80::396:4961:49ee:dc3d%5]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 04:11:37 +0000
Message-ID: <c361dbe4-1ef3-4f92-8fb5-9de184b0bf38@nvidia.com>
Date:   Tue, 5 Dec 2023 09:41:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Nov 27 (drivers/memory/tegra/tegra186.c)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231127150547.461d8bac@canb.auug.org.au>
 <8b44e417-e9dc-4d6f-b0ae-f9834d0624ac@infradead.org>
 <cdb7c02f-a314-4e64-b95c-66c91e83d4d5@linaro.org>
Content-Language: en-US
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <cdb7c02f-a314-4e64-b95c-66c91e83d4d5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::27) To MW4PR12MB7432.namprd12.prod.outlook.com
 (2603:10b6:303:22d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7432:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6b19a2-855b-4d36-8120-08dbf5484629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DaNRvBW8gdRrxh1/urft7JPiGgHc9rB+30O6fJaTFANqFZxTXKHfeKI+S5k4WHi6lYyMAURKHJazkYe23/xKwVBZZJjGlK9grWyUMWeT3EQYKp10eaf/hD1chkRPyUgiV2UMTAfN0g6mRy84r1RkCRUp3I397OH5wMDcOjdF8LVgeFWkunbRgLv7/pZvYJiuqq01Cd5pC3sUeF7ffmpUP24UMele9D9ybZ5BCBQMrj3489Cd4AcEUHaLI0/jRm/l23+n0C5xPdA5yLIfHVrCsvYEvCmNCwsab9ahUAxkvtRkx3fsQa+BT5gQsFl6TQLBI+A8iyr/BHnL5UoN4kI6+PdIo1kRSULY4Gg+I8wE30b+ySuOVCRXk4zeHlsZ29TIGInTYAz589TC6klxut9poUMavxSYqPo83hOoyNCwXXbzAuknkCR9oW12d5GyRyQZ6IfXIevVhkrfTCJ8wqwmgR+f+04tQ8L6hhv0jFBAhprakWHfYACUNeeD18vL3OYQmie57b7puXlRrHRLYwKpjPQ9mYHsLM2O8wWsc++9IZXzPK359KlZLGKmXQDAVYs4nCyuADmQxK/JTMe3DtsQe84u5mXLFk3ZRK5WCi2Rol4Wxt/E7jgSnNFWmYhKyOiRI+bvYMoXY5RDh99/GdvfwitwbXlwRLcdifVbODrLaLv0PubfbXzaIAC7JQv49t0m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(186009)(1800799012)(31696002)(5660300002)(86362001)(4326008)(8676002)(8936002)(2906002)(41300700001)(6512007)(36756003)(2616005)(6506007)(53546011)(83380400001)(6486002)(478600001)(26005)(6666004)(38100700002)(31686004)(110136005)(316002)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L08yOWxQMDl4UDFVY3dWZC9OeUJpTnl2UnpoVVV3TnZ0cEVhbGxWRmVpbjd4?=
 =?utf-8?B?SS9tT2FVeVRLYXIvTVhraHIwSWk1Y1QxQ3pnTkJ6OEFTMFZHeU5YV3I0azBW?=
 =?utf-8?B?ZXJ6UzV3d2paU1RwYU9McGxlSTBMQkFoY05mQllFODI4K3dkcUtJVWZhWWlk?=
 =?utf-8?B?RnlmaGdYRnBwYTdHb25RY1p6QkdDbXlWNXI4MVlhWkdmaEhIbU51MDQwcVlj?=
 =?utf-8?B?cU5sYkFEMDlQRVMzcERBdWNXZkNXV1lVVVNGUjB3c2dXMXR3VnBLeUNmVExW?=
 =?utf-8?B?bXY5Z2N4dGJEQ2lXNXh0cmxZVUIzWEgzRVNTbWFUTkpEa1NDcHY4SS9BRm13?=
 =?utf-8?B?VXIwR0NWQWlWdVpFNnhPRW0rRE5lelkrQTZ1aGkrbnZ5STNmblZrQS9mSUlh?=
 =?utf-8?B?dWFmdVpQMVRKbzkwQ2ZYQVhZVEIzYWc2cWU2b3Z4Q3Nhdi9LZnl1UFp6K2ZN?=
 =?utf-8?B?NWl1VjZKNEJ0aEtlaEttWCt1MExFY2VENWttNDZZV3ZXOEUvWHRVaFp6cXIv?=
 =?utf-8?B?aW1VRXppTU9xbXJnWW1nWEkxTUtXZzRTc3VsVHBUYXBMK25iN2pja0pQaGwy?=
 =?utf-8?B?bHk0YWZaSzJLaVlPdHJUKzZ1MVhmakh0dkpUN3JBZzlUaVZEVFpXVDJCZXg4?=
 =?utf-8?B?bHIvYVM3WlN3VXJRcyszLzJobXhEVWpVWC9mU0pDdFkzdTA2d3dWSmdOOWU3?=
 =?utf-8?B?dnA1U0p5OXRoZjM0aDF4N1N2NzdZU0ZYMkJFeXlUT2VwKytYNUVqYy9oY3Ex?=
 =?utf-8?B?OTBCbmNsTm9MM0RRb3UvMUpOa0ZBOTM2bU50ZmhDcXNuK3RQamkvNHR3WVVR?=
 =?utf-8?B?ZWhvTDFzNlJtdHdpdFdRU1hFUGs4UWZJU2ZYanltTG9NL2FTWWVyYW1nQVpS?=
 =?utf-8?B?OEdreVdZTHpQRXlKRkJDNVJ6TlVialFGQ3BnbFJPMzFidVgxSzdkU1VnOXlh?=
 =?utf-8?B?T25sTFlmMm0vVXlaTG1jcGk5TTd4UDYyZzJZb3VQZDh3THJGbjJLN3M1NVRP?=
 =?utf-8?B?dEYyc0VqZHBJQit6dlNRalp2L1cvWDd4M2NlU2VtSTJZRTliOTlUV09ZVFNX?=
 =?utf-8?B?azRvVjZMS3lyNTMrRGhteWxtRDM4dSsza05Id3d5ZTUwN0U0ZzFNVWpyRU5k?=
 =?utf-8?B?RWtHS1NyNHA4MDlpbTArMU9wb3JQTjRKUEVTSFpKMThUYXNIN250dnp1UHEz?=
 =?utf-8?B?alE4VHBoRk84aE5OZExPd0E0eUR4OXdmVnIvM0o0VnJVdEwrb2loRnJodjUr?=
 =?utf-8?B?Wnh1NnBmZURmTE51M1ZSL1RMVnJOY2FLKzExWHNOeWFzYzRUZmJRQ2lMbjVi?=
 =?utf-8?B?UCtWMUlNTlVndFZBZTJCRmw1QW5UeWdnM0xMRm82THlJY29DcUhlZjlTT09p?=
 =?utf-8?B?aHJEY0ZHVndIMjRJN2s4eTdxSVV5TFhtQmRoK0dIckdnM2IyTlJkcXNTU2g2?=
 =?utf-8?B?aEVBcW9Ib1ZvR1A1Qkh0YUh0OXI0Rm1JQ1c3NnAxVW80NXRkMjJoN1htVFpq?=
 =?utf-8?B?UzhhYm1Fck5oSVJGNEcwWGJPN0U0WDU2VEd5V01HYW1LZlNEcE84R0tabk9t?=
 =?utf-8?B?NE5GUUQ4b0IvTHRkSlNUYlVualFLTDNXWWp0SVoxMkl3b0ZyWnpZd2E4ZnBa?=
 =?utf-8?B?ZGUxMmlPRnFxWkt6Qm4wYlE5SFNNeDdSRnk1Y1hlU1YvbkdOKzNzUEdFZVFr?=
 =?utf-8?B?cFhHK2loT3FCUzVVL1lhSEpSbzBVYkdlQ01MUHd0anRvSy94aFE0aUdpWVU5?=
 =?utf-8?B?eUVOMkp4ZFY0cGtqOGNGdytkcWltSEJKWkV2TEpsV0FjVjQxQWc1Y2U1U3BM?=
 =?utf-8?B?OFJUa0tLNjB5YWZBMldHVlIwR0IzVmQzdzJNQ05sWCtOOWFxaXZEUlhPMnpa?=
 =?utf-8?B?aGNmcExOeU5WM1lxNVVPVGRWdXRxZ2NvY1lpeFQxWnJrTTEwYzE2OWg1UHhq?=
 =?utf-8?B?ZzJud3djZWRsN1FhOEVUaUFWVTVpcTZKUFYybGFwS1lQTHVFa0NEMkpQakZL?=
 =?utf-8?B?NWxkMW1hNGpwd0tMWXlJNVZlNEE2ZHhQNnRnMDBCU2swcXNObGpDRDJHUFNi?=
 =?utf-8?B?Y3dsTElZRWVVZWRNZVdibytyYTdJczdTVGdTMnJQZWprWnlLYTFjblg1MnRS?=
 =?utf-8?Q?5SYZPtuNjUkQ01xeFtgAz2uGH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6b19a2-855b-4d36-8120-08dbf5484629
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 04:11:37.0104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18pyBFb5PYtsDh1IdnXFwV6Qn0YdftasFxTTWqfyPiroXgbrbLVh2lMkArWAM6Z74kRLG2fGwv/kAxLjRjzEqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/2/2023 5:40 PM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On 28/11/2023 01:31, Randy Dunlap wrote:
>>
>> On 11/26/23 20:05, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20231124:
>>>
>> on ARCH=arm64:
>> when CONFIG_IOMMU_API is not set:
>>
>> ../drivers/memory/tegra/tegra186.c: In function 'tegra186_mc_resume':
>> ../drivers/memory/tegra/tegra186.c:149:17: error: implicit declaration of function 'tegra186_mc_client_sid_override' [-Werror=implicit-function-declaration]
>>    149 |                 tegra186_mc_client_sid_override(mc, client, client->sid);
> Ashish,
>
> This was reported few days ago and still no fix or comment. So we are
> repeating the same case happened weeks ago with other LKP reported issue
> - I need to ping you, otherwise you will not address reports in your
> code. We all expect that contributor addresses the reports related to
> their code.

Hi Krzysztof,

Sorry, I am not sure why but I have not received the original mail.
I searched my entire inbox but couldn't find it. I'll check my mail
settings. Same thing happened for that LKP report mail as well.
I came to know about it only when you added me in 'To' and added
'linux-tegra' mailing list.
For the LKP report, I had replied to you and was waiting for your
response.

>
> Knowing this I will double think before I take any code from you.
>
> I am planning to drop this code next week, unless some fix comes.

I'll send a fix for it today.

>
> Best regards,
> Krzysztof
>
