Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C567EBA8C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 01:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjKOAPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 19:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjKOAPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 19:15:12 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678CEC2;
        Tue, 14 Nov 2023 16:15:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdqx+DKjFJThTto1bccZZnDAdm3i4Luu+Yej1fC52+VtHjIZnP72dWrmq7YN+PmbgvtcT3ZXeMjnAQmQuFYHtFv4xJEYGzAMmTl10WCOZtjBFpRpvpfYsUuFbjdM0Ts2gUyguebWsXv434mJFRxVcQ8CqH44VMfCesClpGgt26qlp9aH7f62O6agMBBW12hROJ8drxeUvdd5g5ZT3iLpG8BbgTo1m5ZjnoERhUZnjNmlmw/9KZejgvXtHLr2PuoJNtUpRlnWejfLQ3vFol1YC4XW7mJ6485CsOaLo36fgtkBGl3zKUbGOTlncIrs1+VTQysCaz4bOrLTR1ltSuGeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6XOhsc+HZUru8zGh3QBXkvnwiaYP1HU9qI/X7fl1r4=;
 b=Wvf+p95bH3nM+k0iMkAQtpQblRXyJsWrAqKY0YDlUZojgOBf3Y4IT3UCKD+Y3uoiaQbGOmaFBnTYH4c6HzYFck1oVtZNetSutEBjtL6IVIg1NzWkb6/s6kqutLpF05SnoAsbQRRu/8aXdTeg3UL0yuPoTV04EOZlOH6c0d8n8o+GYVQs8kP8GEkKjhTIsPDwsPCEI6D/Wc1e/kP3Nxvn7Iz3s3qjncXuF4dJ2ZeLtD9Z44C0ONIVolkfYa2Cn8oOm0o/gLHJjFRWozqM2+bYyBPdIWpfNIWy2UUuZPN55hddc3i9C9tqs8ajHHiFsHBEh3mAPvih3hovRYBifofqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6XOhsc+HZUru8zGh3QBXkvnwiaYP1HU9qI/X7fl1r4=;
 b=gbe4wVKEuUYrVemPBvidPzGNJffBejem1edZdJ+zHLR3gLM1KJ2dTgnsHOEHfDNdXqDZ4Asu/JPLeLD0Kb1U9PHyvWg9WxAT7TEnBoefLRn0PVYFghvw0m7GatMQA8Ssu9HKEYho1xuuiNNYeYsGNQreiUSqQFzSMSsaLkFBqdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 00:15:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 00:15:06 +0000
Message-ID: <5029e355-6fe8-4d48-9bc3-20256adfbdb7@amd.com>
Date:   Tue, 14 Nov 2023 18:15:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: cmos: Use ACPI alarm for non-Intel x86 systems too
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        alvin.zhuge@gmail.com, renzhamin@gmail.com, kelvie@kelvie.ca,
        Raul Rangel <rrangel@google.com>
References: <20231106162310.85711-1-mario.limonciello@amd.com>
 <CAHQZ30DP8ED4g3bib-tZ53rm2q2_ouEEL3TxD-SgK4YrCe3bew@mail.gmail.com>
 <d55a80f7-ca4d-406f-b2c8-b2bba45e3104@amd.com>
 <20231113223819fb469198@mail.local> <ZVM4nFaDTwrKMr8K@duo.ucw.cz>
 <2023111422283827b2a3f2@mail.local>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2023111422283827b2a3f2@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0093.namprd07.prod.outlook.com
 (2603:10b6:4:ae::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c83eef-2b72-4e4b-2c23-08dbe56feb7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nWhCH/iYChX6gTng/LjBhAYZAIG2ODLKzYxkzeCMuu+08G5jsG1EStTmqQq7vZPJK/g0v+4HqoIRGuLma9EbpjDxWnJBtt/lj4MnfZBo62ujIjDH/UC0gkvvLvRSWNi8i2P9tAQwdbwSdydWkfOWve0/+Qb79MdTqMjCclF20pFEIzIFpubJ1HlOtOzAmu49sCBnzE+T+zj5oR6z4xsNYMSNPO9XTDGqZSp8ovvcxS8fOiQxs6PtexAsoT5cF5pXujfeGBRS9fSm1kh/cBF7h6uHbMeLgxRtSaoohLlXC5fuMK2ndTRPt8cQDbmABtKyhmWC8Kj0Ry0WlK17X91rSg0bYyMGn/nl7AMF9q1CLkbKM5ogtPXG7uJ0/7EFX6ryx8HdQnAYKoQngjSfoltHOME7nKv3RS4TPXGmfwFa1loIF2MpQPnTrCYuB06JQIMAASJldFkHut1QOLzgvyyjeMlv/BXdfjaLFYnh4IIXGRf/iLyBZtKe75+pKZAqeke/VNtk993dO4LT7brYjiuiN4IZj5lXmzMa6Q4pe7N7rF6REaLK/soJ2iSMnv8dDALI8SJtlRdh0m8Sd/lO54rteshsR8UfT2JmEHKeIUgFSvyiQdiq0g482d7tqUdc7/Yf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6506007)(6512007)(44832011)(53546011)(4001150100001)(36756003)(2906002)(26005)(38100700002)(83380400001)(41300700001)(31696002)(86362001)(2616005)(5660300002)(478600001)(316002)(66556008)(66476007)(54906003)(66946007)(966005)(6486002)(31686004)(110136005)(6666004)(4326008)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk9YaGdaMHAvOEQ3Qk5yTjRTZDlpSXRhTmlvdFYvZXo5NTdMRWxpMkdZeXlE?=
 =?utf-8?B?VTFoLzg5RzFrU2lIbmthUytvRnZKUjhIL2hGRzFCY3RVTXVXZEFiNkR0U25k?=
 =?utf-8?B?T1U3ZmxxTys0VEYyc1Fod3pVdTRrSTFzZXl5MDNiR25GcWMvTWlCUGRXaEpy?=
 =?utf-8?B?RnExMTMzQWJpWnIvSFRVb1k4N1lGSFFDeG5lNGR2UVhobzFKYi9WcDRpRUdQ?=
 =?utf-8?B?c0pEVHNXbXlZREpxYUlZeVI5Ui9EQ253azlkNU1SWm5ybE5ndG5CUHhYVWpq?=
 =?utf-8?B?WXYrUmIwcEwvbmRGTnhqOHBkRGczZXBGU0R2M2N6eWxqN0xWK2JmQ21TcmxX?=
 =?utf-8?B?a0lNbk1Cc3Q1UXFJeUpWQmFoUEVIT1BrSEcrM3BIVU1JdE9CSmxlMHJaZDlN?=
 =?utf-8?B?aEJIdlVwaXlLQk5rUkZqQncvQk5LZEhPU2RpTzFWSTBZczZyN2VrM0R5MHkx?=
 =?utf-8?B?eldVNytNNGpHdDlxTGlhQkNNb1BXbzlXTi84Q2lwbG1zR2dadG9Fb0R4SEpE?=
 =?utf-8?B?bzZNajVSL3VaMm5vZXlaK1N5OFQ4R0lYdjhGc3ZsM3hUdzVaK3NOQjQ5aE9U?=
 =?utf-8?B?Rkd6bDQrM3NsUGhzdnM1SUdBVFNxbWUwNjB2NHB3QnZ1WGU2Q2twNzZLZW1V?=
 =?utf-8?B?a3FNM0loUEZ2emFDYWVNM2hFbmp6TEdLaXhLZk1vaG50bi84T0lHTkVYMXFt?=
 =?utf-8?B?MzNWeThPM3o1MFFOZm42OHFROSt2SkNjc09YOVlNbG5tU3lVK2tPUVpuRVBk?=
 =?utf-8?B?elBBNkhiMk5Dcm1vN1p5Q1FMVmdsQ3RCbk4xdm1EbnYwcWVaTW9FdkZLdGlJ?=
 =?utf-8?B?Uklqcis5STNaTFpGdUxTVU5ISGpaVUs0WFJlT1J6RnhNZGxNaTBYQlZkSG9l?=
 =?utf-8?B?TW5QaVo5S29BMDhYVVNibXc4ZU95NkVYL0ZFM2QvNHhoSm5VWlpxQW92MURI?=
 =?utf-8?B?dnJGQkxzVXI1bHFjakQ5QmcwUnVld2plcG9xQWxZVFNBVmxKY1k0OGpROHU3?=
 =?utf-8?B?Y2Q5UTJBODFLNE9VQ3NpMjg3WmozS3hBbXJOUGNpd1dPL0FGay9JdjAzVFF4?=
 =?utf-8?B?S0F2L1RlTWRuTk5iTElhaStSZC9qMlVST1N3cVNtL1hPNTJVVVJxd0M5R3hM?=
 =?utf-8?B?endjV1ZjdUN4bUY2YWhzV0VXNFZvM0hiQk1nR0RoNEpkUC9VK1orZEdWdEFZ?=
 =?utf-8?B?ZGZLakNWMWt1TkFCL2s1anorWjJmemFraWp3ZTNCdFdWTm92aERWV2E4dkpz?=
 =?utf-8?B?dEtSQ2Ivbk8zVW1Mb3haek0vdmZJU2hoQThkMy9SUGM1R2x2dU5OcGZIZS8r?=
 =?utf-8?B?Rjc4V2RpdEJWdXZtZ1VQYzkyL3dYYVJtckRVYWo5allQaFNBM2FtbHBqc3FD?=
 =?utf-8?B?cGxKV2pzaGZXV0NuSDBjdDFhd201ek9JN3VhYWNVQ29tRXppREczT2I0c1pX?=
 =?utf-8?B?WUpzdmFtUDJNRE9hT0t5RXBtVWhodDdsUGlGUG83UElTTWVUY2ZZS0lHOVZ5?=
 =?utf-8?B?VVY0ODhBUnlxeGJSNVZCU3dwaE54OGZLUWdHNHlFR0Z3UW5EVWRQK1JwT1p6?=
 =?utf-8?B?NXZEVHdDQmk1akNoY1FNL1U3a00zSDIxMVlXSmozSXl6Njl2ZitkUWxtSFhi?=
 =?utf-8?B?SmEreUJFNUJRVlZkOGdsUVZQbHpoeVhrUHZZZ24xZGlSQUFKZW1aRlJVQWtt?=
 =?utf-8?B?K0MxWUlHZm9MdWxOYi9DMkM4YVlWcWNkVVg0L1FNM0l2ZHUyYklpWGlLNjgr?=
 =?utf-8?B?UjI2VWFuWm5PQXBYeURuMExYK1lSMkNQYUlpc3pCTnJpdGRBaCtxUjB2RDJ2?=
 =?utf-8?B?alZsazJxTmZMQkduNm5DcVBkRGh4SlEzMFZ5WC9NTHRkUmdmWHJJcUtFMmxm?=
 =?utf-8?B?QkF1RHFyc28yMCtpbUk2YlUwMHpoaDRvU1c5elNFbCtmdEtYUFVBUStRVUJY?=
 =?utf-8?B?TUxJNlBVazNxSGxGT0k1dGE5YnpjTTdYSHVlaEliU1lRSzlQWUZIbEx1d0ZQ?=
 =?utf-8?B?WDQrcWVlK3dYUnNTdzNvNzRMeHo2WmYyQkt5U3V3NG1laTFZRFh5Q0kvN2NR?=
 =?utf-8?B?RHhTMFo4c041US9pYzUrdjd5SE5CczlyV3hWc2NLSjNBaXoxR0ZEeGo0ZDZv?=
 =?utf-8?Q?IypsCx6lbLjQ9Y+RyAjOIjgnX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c83eef-2b72-4e4b-2c23-08dbe56feb7d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 00:15:05.9567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGVIkHJjverfsKhpbWcrTCazm1N31AQoSYWtZbVMFdAU5kl5QKNoN+zIV/KInMcSn61NBDp1GsYrv4YpScJuDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/2023 16:28, Alexandre Belloni wrote:
> On 14/11/2023 10:06:36+0100, Pavel Machek wrote:
>> On Mon 2023-11-13 23:38:19, Alexandre Belloni wrote:
>>> On 13/11/2023 15:36:28-0600, Mario Limonciello wrote:
>>>> Now that the merge window is over, can this be picked up?
>>>>
>>>
>>> I'd be happy to invoice AMD so they get a quick response time.
>>
>> That is a really bad joke.
> 
> Why would it be a joke?
> 
>  From what I get this is an issue since 2021, I don't get how this is so
> urgent that I get a ping less than 24h after the end of the merge
> window.

It's possibly longer; but I don't have a large enough sample to say that 
it's safe that far back.

> 
> This touches a driver that handle a gazillion of broken x86 hardware
> that I don't know anything about and as soon as I apply this patch, this
> becomes my problem so I need to be careful there.
> 

Don't feel the risk needs to sit on you as subsystem maintainer.
If something does come up caused by this I'm happy to help come up with 
a solution.

And if there was a regression caused by this having 
rtc_cmos.use_acpi_alarm=0 to restore the old behavior would help a 
reporter's system.

> On the other hand, I need to pay my bills so actually, yesterday I was
> actually looking at the patch but got interrupted by a project that
> ironically involved the radeon driver not working properly in 6.5.
> 
> So no, I don't actually expect AMD to have to pay to get me to review
> and apply patches but at the same time, they can't expect me to
> prioritize their patches over projects that pay the bills.
> 

My apologies on the preempted ping.  Of course you have your own priorities.

I mostly wanted to make sure it didn't get lost during the merge window. 
  I do see that you have a patchwork [1] that you actively use so I'll 
refrain from pings in the future on any submissions.

[1] https://patchwork-proxy.ozlabs.org/project/rtc-linux/list/
