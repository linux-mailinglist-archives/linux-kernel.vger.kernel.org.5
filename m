Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E1776105B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjGYKOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGYKOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:14:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D95A10C9;
        Tue, 25 Jul 2023 03:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKV67uOJkhatVyAZ6j8c4X0YQ4ams1+YfKagWHT41IKfDBctb6h8Sk38gxI+Ww7iGmnMXF8FTp9F/W4dwerKQiurv+tAjgspIc1ZtQBvi7nvWNuLZtZuWkoh9MHFhdkRjPlX5HVyXPFbivoBxkJXSUNXP+bGBcenMfQTBdPW2YvpfAC/kr+4x/wH8rebLZ/ZtK7WiHjjHzGyaO6QkDw32+dJc44TW/dQ8a2nkBzFJgxkmpEk/xzXrf7PUNXqhbsZB1UYgwqIb9m5Ijj+Pi2ZjRK5GeU/G+BRRVaJn46sWYUzMuUEdm/2oXaA8GVnjdunswti5O60Cw790uHqtW1lWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOBz9xj518IgJdnMKd4YzAZiNBZGPi8R2mE6U7dv7po=;
 b=ZFEAiCpg0jGGlI4Uyw+UfQyvzs1ldfZclywmreyNyUo4aNF7l/2y6SoLys7cRN+uCHdIy1FuK+/LGAf7NWkBifXpMDcPvMiIio9kIIdQHm0V0toycpiejICsGtNEFOnnxGHOH3za6VsFAPGB2FApMkXCJZFMp5tDh973oVkijI8XnZyartugUA0vg7+I30q8XyTfShHsFEf1pMyRbSTfimUcuJud6ew0zCQEu0Dy6maQ3iqtQ2FJfUOVkd3bLxpSozlN6KiJAklMFX+c5uzWy5WS6SR1iGGfk5kWbE0ZPA0mLeIkeJ5K83SHtAwDcCCCTZe0stj6xEAFf01Oo1G9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOBz9xj518IgJdnMKd4YzAZiNBZGPi8R2mE6U7dv7po=;
 b=XhVFUtn0IDvHdhupV9TZoSleDv81cvznMjL0k0LxaLdTAhdZlVjl7XVzZm/xjiocZoo7UgAcqFifjZJPW8aZ7ROKVa4DXTbpD9Fzd0mWbFB8BqAZEzMJ5ptK5swi2O+CemAn5vHwsQ06c21Go2Y4It6+/PhRVOfL/RuEYYUoFF1S5r3shOrpFdc2uQI9Ah/5YyjlGULiV3zVJecfAkl28PeEO09GukGeM5G5oSApxjCY72oWIBzd5PPXsZRiQoniL0mjLb0rkn3tlB93zpVHciPd4s1py/Ae5NJa78NEEov6x/GleBfzRz88PEsHYg7ypUjKX5vMsybQxZO3roep3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Tue, 25 Jul 2023 10:14:32 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8833:f1bb:7d8b:dce7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8833:f1bb:7d8b:dce7%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 10:14:32 +0000
Message-ID: <cab267a2-28a0-969a-44cd-c87c8fe65218@nvidia.com>
Date:   Tue, 25 Jul 2023 11:14:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] memory: tegra: Add dummy implementation on Tegra194
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Sumit Gupta <sumitg@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230629160132.768940-1-thierry.reding@gmail.com>
 <1fd1d5d7-7296-0e62-9f65-7347ac0f0500@linaro.org> <ZKwCYjKXtuDsOF9E@orome>
 <1ebfbbec-d5cf-c6ac-2cf1-eab970903500@linaro.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <1ebfbbec-d5cf-c6ac-2cf1-eab970903500@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0344.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::20) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM8PR12MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: b931f46b-d5fe-4245-443e-08db8cf7f044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9ikhJW9PEkpodvxRTcTn3IOiarwmqMlD5qbIvhAP7P1s5LjBaER9/aUhMkHa7dGgPTFlBksEGD0Ukwc7O3hwSk66nLB6zkM9KFPC6p3eV5663lb18WjwSDC/RRR2y+XU6CSCwelniltY7acejODkNwzMjfrM5pVlFlapE7/qcM9mvJs/gllhaWRshRhcjhSGCdzZeHQmEmwagwpN5oeoWxDRS68GceslJ8zeW4qqeyK61FTl8bcMcxa5+sTW/c/viCYIw7jCXGe0jZMpFQPC+6nBbtlgY0aO/5iJBqKvL1tSWT1HazTmv7CcegzklpMHQdxQ7hROW44ZOXAgNx6qy3FDtDy9CDNh2zYZHegLKxNbUdCWsHrOAcQyI3Eje077ezaPpL7jOO1ifnUjbgfRtazKEpFi7p/BTe4otxswgUaEvwL/QUlB1re0G/sYySjvAZQlHrFeRgxnrpFOdRAfNnfTtYXmONo6IY+MIPSBsypkfTcKP8v6z+C/3b4ggynGBQRYioQmYZYKhd8thWuZFMI2E7MK3OOPKj9jm9JL5Y/4Sl61nRq46Bljca58MujULncG0mHOcbc2Z2QIn2lLL8UBeGJ459icBY7oscWFMnJ30jYQHzG/xap44NKH30RjtCpyTeh8pLRR4EWVLAt6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199021)(2616005)(6486002)(6666004)(478600001)(86362001)(6512007)(31696002)(36756003)(55236004)(26005)(53546011)(6506007)(5660300002)(41300700001)(316002)(8676002)(8936002)(4326008)(2906002)(110136005)(66946007)(38100700002)(66476007)(66556008)(186003)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHJiYVhpWFdoc09TQmxoQ3dRN1lrcGphNVBVWUlaenBkQjRGcmtIb3cxQm5p?=
 =?utf-8?B?Vkt0MXNJOU1ZeEkySXRSVXdZZmVUenNsWUxpZTFJcHBTWUtjd2YrYVpyTXg5?=
 =?utf-8?B?L2ZZZkxmNHB3Nm5vNlc3eUdqaDlpdjhjUWFRZ2ZZUGNNOTZjNzZkOC9RV0ZK?=
 =?utf-8?B?cVM0NUhYdnRvbCtNNG8xYVJ0Q05FckxVNnllWFE0QUtObEpBYWJpRGMwd2po?=
 =?utf-8?B?Y21pZEZaTzRxWXJTTFJ1Nm9aWG1ndisrVXc4N0pqV0lVQkt1T1JJNUJLOHpC?=
 =?utf-8?B?RWo2VitPTXhpUUg5MXVndGxaVE5BbTlvUXJHUGVzV25jcVJLcS9aQzc0Z2hG?=
 =?utf-8?B?VkdqNnBKUlZIb3NNL2s4ZVdGSEFEN1NUNnMzZWxOam9IdmF3dk9wSGxpQ01H?=
 =?utf-8?B?TTJrOVFsbkwwSTlzR0xGbjB2cUVWQmlEbHU2M2hHSzIwSHdFWEYxeEdnNVJB?=
 =?utf-8?B?L3NSVHd3NVo0NUFFa29pQkFSd2NzSzNjbFp2dlpBSzZnWHlQOHhtdk9FQ0FT?=
 =?utf-8?B?RXhJdVh5aThLY2Z2K0hMMHlBa3FXZ01ZTUFnWktydndKWmlBSnBWcE1nalpk?=
 =?utf-8?B?aVBlUHZRU3IzQXlNdHEwL2hDYmFBRHpmZEtuM1NlbDVpV2U3OHp2a2VZbVg3?=
 =?utf-8?B?VitkWDhqQ2d3RnBONmtsWU80UEpucUMzRHNRSHk4TUt2eFBXRGxLdWJMSklz?=
 =?utf-8?B?dEdLcVdaaGJXR1NraXZHSWhPditFU1JmTkFYUk1wYWxkeGpVUnlqRzZkZUVx?=
 =?utf-8?B?K080Tm9OSDJkQ0Fjb2k5aDhZbGZyL3BxUjJyNmpnc3JTK0tONEhFWGd1bWFP?=
 =?utf-8?B?azNUVEc4S1JJUmo2ek5JRFUrTGlLK2R6bm8vV0RQOGsxUzcvWUIyaGFvaElC?=
 =?utf-8?B?T0htQ1YyNEtvWDk0eENJT1orT0hXcUNYUjNDdHhuUGFuOUhvN1l4aVJtQmtW?=
 =?utf-8?B?TFZNSDYzMkVlajNVY3gvMmtISldCVWtxOCtpbkNDek9XME1VZDhCWEdsYVVQ?=
 =?utf-8?B?TlNEM3IzYms0VW82aHhxWjVab2xRQWVQU1Y4bWJ2YXFQRXN2VkhURjhMTm03?=
 =?utf-8?B?ZmZBRm5IdXB4Q1Q2T1FQVk1vMUxTNElsMFUwcGF0eCtQSEk5M1lYRXI3Ri9G?=
 =?utf-8?B?MG5ONmFvVlpKK2FpNnh0UnNqRFRkOU1UOXVtMzdudlVHc2hDWTdZQ3U0Vzhn?=
 =?utf-8?B?QmU1WmVaUGpJRFFsS0Zub1ZFMUNwWkg5NTBMTS9ZOU45d3QzYlVNN0JqQ2o4?=
 =?utf-8?B?T3NmUWhxVERkdUZPMVh0ZUlIdnEzSHkvWVVFNkhQRUsyaXRra2lpUXBvdG5I?=
 =?utf-8?B?Uk1yYytSQU15L01meWhUcElWWThCWTBadEpIaW80d016VjE2M1FDb0tRcnEv?=
 =?utf-8?B?eU5idjV6UDNKcmp5b0JxWFJjeXhXVHhhY0I1KzVUQ1RUTkdyOGQyR0kxbVhC?=
 =?utf-8?B?Y09XcmtpKzlrYXRuSm9xczNmdVBoVEtja21KVG5KNmJyZzdWcWJqcnduVmE2?=
 =?utf-8?B?aGdBVEVSZGloQUNsWEtObXVkK3BieWZkM2EydEVGZ1Y0bkZOdk9TNEZFNm16?=
 =?utf-8?B?MUhlbWdNUFNPRTlISy9mN0YyckdHT204RzJVZi90dzhjS3NqVGpwZTZvc2Jy?=
 =?utf-8?B?Q3Rxcjh1alE3Z2cyZHJHQmNUd0lacVdQZGlsOWhOVGErOEZvWCtOZkd2OEVD?=
 =?utf-8?B?VWJuQ3ZRRGxoSWRpcVIvbTRoMHJ5NXdvZDg3My9yVmFKTjd3Q1ZyY2txN0U4?=
 =?utf-8?B?VEp0dm42NnVPbU9WeitwY1pnVmxYdnNXNktES05lOTJXWjlVWk9CSkd1ZDVP?=
 =?utf-8?B?Zncrd1pYaUw5RVB5ajdUWXVBN1VIZVdSYlVvcjFzTE1SSUtiSUZ2djRuNy8z?=
 =?utf-8?B?OForcnh3eEtCck4vTFl0OHR3ZDFmUGNWZk9OeXRmRmVDaFArNDZuaDloUFNt?=
 =?utf-8?B?L2pvTFpHK2xtaFNMTjhydlBEQXY2czV1eDBMOGYvOWd0WHZOZzAwcFpQTHgx?=
 =?utf-8?B?WnBvQm1QQm5wMEZxdWQ5enRrKzhmNGZvbVN5M2JseVR4VDNLbjlocG0zbnBw?=
 =?utf-8?B?cm5EeEVxamNQTDJ0K3FrYUliQ3ZTMGdDQWEwb2ZuZjIxeUx4TWxBc2xuaGlO?=
 =?utf-8?Q?jKd6N6tpGp5erNeDzeaJ9nzHH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b931f46b-d5fe-4245-443e-08db8cf7f044
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 10:14:32.0864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Wz8yjOAnAs6cYzQ2G143NSqR3Xq3kBL/SdF0JtuivvXUW6ypqURfr0fHRuMYZI+3fqS7a8/mCzxbCTZI9aYXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 10/07/2023 14:29, Krzysztof Kozlowski wrote:
> On 10/07/2023 15:06, Thierry Reding wrote:
>> On Mon, Jul 10, 2023 at 12:10:43PM +0200, Krzysztof Kozlowski wrote:
>>> On 29/06/2023 18:01, Thierry Reding wrote:
>>>> From: Thierry Reding <treding@nvidia.com>
>>>>
>>>> With the introduction of commit 9365bf006f53 ("PCI: tegra194: Add
>>>> interconnect support in Tegra234"), the PCI driver on Tegra194 and later
>>>> requires an interconnect provider. However, a provider is currently only
>>>> exposed on Tegra234 and this causes PCI on Tegra194 to defer probe
>>>> indefinitely.
>>>>
>>>> Fix this by adding a dummy implementation on Tegra194. This allows nodes
>>>> to be provided to interconnect consumers, but doesn't do any bandwidth
>>>> accounting or frequency scaling.
>>>>
>>>> Fixes: 9365bf006f53 ("PCI: tegra194: Add interconnect support in Tegra234")
>>>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>>>
>>> Applied with checkpatch warning. Please be sure you run checkpatch
>>> before sending the patches.
>>
>> Are you referring to the Reported-by/Closes complaint?
> 
> Yes.
> 
>> I didn't include
>> a URL here because this came from an internal test report and there's no
>> corresponding public reference.
> 
> Ah, ok, apologies for pickiness then. :)
> 
>>
>> I suppose I could've left out the Reported-by altogether.
> 
> I think it is fine. Checkpatch warning is just advisory.


We need this in v6.5 as a fix, because without this change PCIe support 
is broken on Tegra194 devices. Would you be able to send as a fix for v6.5?

Thanks!
Jon

-- 
nvpublic
