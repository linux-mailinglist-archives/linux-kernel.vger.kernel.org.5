Return-Path: <linux-kernel+bounces-44817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380148427D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DFD2896A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91736811E2;
	Tue, 30 Jan 2024 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="flXnWaFQ"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2131.outbound.protection.outlook.com [40.107.14.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9EB21105;
	Tue, 30 Jan 2024 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627932; cv=fail; b=YYfcQBhKD73hW64uaqo54z2Ds9Vpnwt9hatONpFyiX+U1mhSvU2jrphnOaFiPHJkDbDsVzDmosjk5/++/ODHceKDgR/FK2481pnI9Q/tvZwWNMTk2Nzt5Y+Al8BCnNWt+0eYw9WwVWMhrYo2WiXUQTb3cDHS5+PZhlR1aRY8z6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627932; c=relaxed/simple;
	bh=SVBbd2OTFL+HzzAQaR1cX+/lwiTWnYF3M7gMNPpoS0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a+dljD7NxSLqhpFWq9iM5CqyIms+t+zrtQ0DYELJUvAMJootBTHWI9ygGeAQRF92ocgb5CCtvaiSl3C3TwvRqHi4XO+NwCyGQdNmNcvT+26GLRB2AbWLZu4dCsK6BXxM07MJAnpGxiErLsn2QaPxYgCa+jQt2fQwZd2mlwWzoOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=flXnWaFQ; arc=fail smtp.client-ip=40.107.14.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efP2okQG+jIhnDDNA/+D0AOUA2dZeQ6Ze6uavgRIZxTQS07UB3P9zmJKmVhSqN2Te1wdPBwqA1SO4T3Jwqwe6Z+IBLtwcHNZjYkigRw+l+HKVqJZXT8Ux6NDmUHGejylyn/62YPbmZ4w0O1QNs8IXdKy6svXjnamkW4MBhxsHOc2FsT7+Q1XaScV5f5MKLjNQTDEhHgn199BieZmyU1+E0hJxn3tuM62IQ/Tj3jGxrdOj+IO8z0p+cZIecUSrrABbz2l0y2eexnPKQeBrKWUWOmGbbeM56DtVY9zyipIfbyiwg/79ZuJrqvHFsW3cCLp9bZWOMJaIqRV+5IjVzP08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqU2JPoCEW+gPaUwFEoqwWPjPxsKGV70Vreyt6/GTHI=;
 b=chQHcyU67zfZoQ816XMnlY8CdMPstLhTToUjc3QhiPljLBeNTllxS/GCo1b/AlbMBAz/kz5sjce0l8Re/rBiQ40SGDy/A8rMMqsjq+gTZn02mKT/bbfeDApmkB9xZ8vu7LbID0Rg3IuSnyv8KNoEmvhEa8HpdFxeF2Ce706yil9BREf6F6Ns/DCqZRQkqlfTo9GpuSMOJYxi830AdTF9sAJX3+7E/5VYNQZN0RbiQAVb1YYOCGqK+K/d/FTgZAP8kMQCXtXujj/spBr1jCH8yIyyFswChdsJ6/0LnntEfxSe2bZX0ZaXJPEgi0pRjl2kJuOMVeretmHNplf/3ZFGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqU2JPoCEW+gPaUwFEoqwWPjPxsKGV70Vreyt6/GTHI=;
 b=flXnWaFQqsITYNNDKe8EC/R2zKVRHUz8j5UyZAlDnCgU+Kia102OO1Kq2IudpAmbM4XLXfnC4Q3HfXdUH8CLD3sbZrYt6RXIB7efWpQ6rmOokGaRqrcI9KMHmuicLwvCwa8ksODH736b0MRBEnBj1+mLV/1LbrapxUlgONzDyQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS4PR10MB6277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 15:18:44 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:18:44 +0000
Message-ID: <79921f9a-2453-48ec-85db-e63a0958db1e@prevas.dk>
Date: Tue, 30 Jan 2024 16:18:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] lib/vsprintf: Implement ssprintf() to catch truncated
 strings
Content-Language: en-US, da
To: Lee Jones <lee@kernel.org>, David Laight <David.Laight@aculab.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Crutcher Dunnavant <crutcher+kernel@datastacks.com>,
 Juergen Quade <quade@hsnr.de>
References: <20240125083921.1312709-1-lee@kernel.org>
 <a37e8071-32ac-4f5d-95e8-ddd2eb21edcd@rasmusvillemoes.dk>
 <20240125103624.GC74950@google.com>
 <54e518b6dd9647c1add38b706eccbb4b@AcuMS.aculab.com>
 <20240129092440.GA1708181@google.com>
 <7054dcbfb7214665afedaea93ce4dbad@AcuMS.aculab.com>
 <20240129095237.GC1708181@google.com> <20240130150721.GA692144@google.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240130150721.GA692144@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0108.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::9)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS4PR10MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 47cbd4d8-4570-46bd-20d0-08dc21a6bfc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0cGoUOP3ndlCPgon964fPRM4IAQT+N7++Dp6vbBGXAt2859UUhw3xr58h8myNUgJs+sfPV3QjxN4GGgVSmGNuisjMV3P4XAaxuF00zdjam52W9vu2R2TY9BlupUYeD1Ud+Y3ZSyaARzTY3F22dA2gHyKARWIsjo8JWGjRf9MIDtz/LBBfV5a4Wk1VXu3e8+I6Sf8/XGJD0coL6L8kPpdK3ZiNzFDkKdvCAjmrW3xv0140vxl6ePQX/IcgA3pJhhBl+weSCXwd0MxsLnuOga5LFlx7QwBQYJiy/4Lj0zBMhXy6NRwmCAr/RgEqwOPPCFSQrloiapv4QGOkBMXXcFy0h8YI/tq0W7KmuChDFVeZy1m+LUDZq5dhtOgf2qgT1ILilOVPVxujC/MbOjbl8iyqQagg+f/OTILz2PWRT6TCEpLzf2P1eha6JQLNhF6ArxMUs0hEVNlvn8yqghU+ymdCzxhppb5kttPxipOImdMO/qk7ovSS2LTZ7oaSRui9bUQhiQvdJpwi0MJcgxYe8xRBfZNtSRMHL58Jkzf5rxgaUtFVMOMUWxEzsw0UT1uRn8sfqf2aCtRBpgR1FncD3xTz/DBq4THEQWQcRvr75vwa7G4gtasxwsGrxHxYNE6Dpm0lzQxYPSS/IT8Tmb1dEF8zQ9925MFYyPqb8pPdxPMXp8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39850400004)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(66899024)(7416002)(6512007)(2906002)(5660300002)(6506007)(66946007)(316002)(110136005)(44832011)(4326008)(45080400002)(2616005)(26005)(54906003)(66476007)(6486002)(8676002)(66556008)(8976002)(8936002)(86362001)(38100700002)(478600001)(41300700001)(31696002)(36756003)(83380400001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0lZVUR5WW4wSU9kWm1OdllJblNaRlZrZEFBLzhndTdUMHZNU0tXclBRTnlj?=
 =?utf-8?B?VUh4SENZMk91ak9Ra0F1dXJMZGpVTUs0dVVZcncydGQ1R2hVZTc1SUJpdXRt?=
 =?utf-8?B?cWc2N2JCU2R3WGJaTU5oQ0xSN0ZpYXBJeWxyLzhSTU0yS3JyblpNT3A1emtJ?=
 =?utf-8?B?RWFDb3IxOWs1WkJpKzIxRkRKTHBFMVovQ3NRbTVYQ0RVUGdUdnd4UHFya0g4?=
 =?utf-8?B?eUd4dWhsQWMzS01DNm5aRFZmYVIwSHp1SjBjbGtxUnplL2tNdHNzaWV0a1ln?=
 =?utf-8?B?T3E1OC9Hbk1tVlNoRlByTFV6VTdZejVFa0xIT0NtSThoTHRNc0dCcGFUMTZX?=
 =?utf-8?B?UlY4MVJyM3ZtOGpDN3RHM2llcFRvNmRvcUZDVWFpNHlDYlJSd3F6cGlDMzNw?=
 =?utf-8?B?NE1CTTV2K0YvakwrbEdDcTVhMEhBN0NkMEdYMjZWeFlKWEZTRE1Pbkt2SGkx?=
 =?utf-8?B?UGFFb0VXRnVrRk5hd3FjQ1hmQ1QvRGdpcVBKZDhTZlVtWkJtUXZQbGhxQ0ZT?=
 =?utf-8?B?WXNaRTUweGY2Vnkyd1BxSG83bXVSK2dyS21TVVp1cktMNlBmcnNBRFJ6dlNh?=
 =?utf-8?B?WmplVWhuRldiWDBKY0hIeXpwUjJMRW9MZEtkZk05UEx6dk9ab01PZHR5K05u?=
 =?utf-8?B?SE9tc3ptODB5SDEvS3ZTY0UrSVlJY2FHbUxvd3EzZmVtaUc5UWFaY2JrQkJt?=
 =?utf-8?B?STZBa09jL0thRkhRSXhML3NyYy9MeWlZandwVkF4TUxNZWI5VkxISStlZmRR?=
 =?utf-8?B?dzd1YnlPdHM1ZFkzOEl4QnJPWnljOGdIeXBtcGhHcG9CZEV5bnZXb3VqZ1Jr?=
 =?utf-8?B?amFka3dGdTVBd1ArSi9YUWUzb1dWaTFzZnBWTndrV0JoWXIwTXZ1akdvRlQr?=
 =?utf-8?B?dHpSUzYwR0RvSVpkZ3lqMFhLcmJpSWVvQWo3M1lGcGl2MHRMZmE5a0pSVFBW?=
 =?utf-8?B?NTltTFZ5SUpwU0lZSlNKd2NCNWZBbW5RNnhTWWI1RFVKZlZnSDQ3Y3Ivc0xu?=
 =?utf-8?B?dE4vVXpHcy93aVJGVmtlZkhZSWMySDRPVWFRSXhteFU2RDM1U0Ixb0VmdHRH?=
 =?utf-8?B?VmtQa081M2cwY2dLRTQyRkU1T0hmeHlOejlHNGtxajVyNW1NSWdOeXNrMXZw?=
 =?utf-8?B?c3RYejNNV0xPUGMzV1RDdVFWVkczdFlPQ3dUaUF1VTEvaTJmNGJUNjdxQ2kx?=
 =?utf-8?B?cGVqQ0ZqSnkrQnhPTXp5ejBLeWQvMHN1QWt4VVYvUVlDWldVRms4MjIvNEd1?=
 =?utf-8?B?a3h2b0duVjhtRlIxbUM4YmIzRHcvVml4aFZXWFcxNW1yNVlRVzJTYjRvRmdP?=
 =?utf-8?B?L2w1WDV4VndHSEVaTTBheWc0bHFXc0Z3U1E5Yll4SG54YnVmSHRVNU5HdHJh?=
 =?utf-8?B?UVdnOFhIbXk5L01LZVhYRm84N0ZsaW5EdEFTWUlhWCt6cnhiUkYxNmVJaW9C?=
 =?utf-8?B?QTZuME9aTjkvZmhlQS9PUGtJWE85YmlKc29XZkN1dkpXb1lIMEladDQ5ZWZU?=
 =?utf-8?B?cERXa2lSUmlnZ3N1WFVyS2lFZEZWdEtXYVN4dm92Q05UR0plb092SFJtdTMw?=
 =?utf-8?B?RzRpdVExeXRHT2lpaHNyOFpXRHpueVg4RkFRYkI2dC9hazdUbkZtaFFtM2Jx?=
 =?utf-8?B?RTZzakFVNlpncTJlR1NGd21KanYzMm00T3YxQ0tPbThiZFlLWnVtS3hDcVFo?=
 =?utf-8?B?cEJWVUxjM0dFYy9xWEVabTBpMHJxS0pYYW5SVDVDRGplWFFXWnc1bWttUWtH?=
 =?utf-8?B?UllHUWVkdU9PSlN0WXJoYzhIYTROSGZFUkNGS1c2c1JuMmYwMytoU3VqWjVJ?=
 =?utf-8?B?ZzIvU3poU3JLdjlleUxrbm91MnA4REU4L1BXdm4zbzYyd3NXWS8vemR3ZG9H?=
 =?utf-8?B?RmV1RVg2T25Ob2EvZmVJVDFOTHA1UWhLSFI0NFkycEJvSFMya0VCaHN1c0JP?=
 =?utf-8?B?SGtLVG53ZHZrdzJ6VHI4ZElIWEx4TFZndUdFUmlyMURzQ3BhRThTNll4cVBi?=
 =?utf-8?B?VTJ5aVdkTVI3SFdiRUdCS3dmNmRLRytqTllRMmFTcjA3aXlzWWhNUUxtZWJS?=
 =?utf-8?B?NkY3aTRyejRsQmEzS2prenk3YWIyWDRpZ2hxdi9UbWdKNWxoUTVUZXN5bDgx?=
 =?utf-8?B?bGcyNmt1NU9tYmxsYm9YeWlrUDJ3U1lNczZsYkE5WmZIb0JvR3ZEV0xTM09r?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cbd4d8-4570-46bd-20d0-08dc21a6bfc3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:18:44.6458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxs/B0GhLjUthlXj01RsY8en0jwE4Pk+S/+d18djNObGLQDjcxB038IYlnyv1P4xTEV+t4Ypr3S2lXbsIjgejj8Q6K9mIcdG/2b2kia6z3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6277

On 30/01/2024 16.07, Lee Jones wrote:
> On Mon, 29 Jan 2024, Lee Jones wrote:
> 
>> On Mon, 29 Jan 2024, David Laight wrote:
>>
>>> ...
>>>>> I'm sure that the safest return for 'truncated' is the buffer length.
>>>>> The a series of statements like:
>>>>> 	buf += xxx(buf, buf_end - buf, .....);
>>>>> can all be called with a single overflow check at the end.
>>>>>
>>>>> Forget the check, and the length just contains a trailing '\0'
>>>>> which might cause confusion but isn't going to immediately
>>>>> break the world.
>>>>
>>>> snprintf() does this and has been proven to cause buffer-overflows.
>>>> There have been multiple articles authored describing why using
>>>> snprintf() is not generally a good idea for the masses including the 2
>>>> linked in the commit message:
>>>
>>> snprintf() returns the number of bytes that would have been output [1].
>>> I'm not suggesting that, or not terminating the buffer.
>>> Just returning the length including the '\0' (unless length was zero).
>>> This still lets the code check for overflow but isn't going to
>>> generate a pointer outside the buffer if used to update a pointer.
>>
>> I see.  Well I'm not married to my solution.  However, I am convinced
>> that the 2 solutions currently offered can be improved upon.  If you or
>> anyone else has a better solution, I'd be more than happy to implement
>> and switch to it.
>>
>> Let me have a think about the solution you suggest and get back to you.
> 
> Okay, I've written a bunch of simple test cases and results are
> positive.  It seems to achieve my aim whilst minimising any potential
> pitfalls.
> 
>  - Success returns Bytes actually written - no functional change
>  - Overflow returns the size of the buffer - which makes the result
>    a) testable for overflow
>    b) non-catastrophic if accidentally used to manipulate later sizes

You are describing scnprintf(), which almost does exactly that. The last
thing we need is another interface with almost identical semantics.

>     int size = 10;
>     char buf[size];
>     char *b = buf;
> 
>     ret = spprintf(b, size, "1234");
>     size -= ret;
>     b += ret;
>     // ret = 4  size = 6  buf = "1234\0"
> 
>     ret = spprintf(b, size, "5678");
>     size -= ret;
>     b += ret;
>     // ret = 4  size = 2  buf = "12345678\0"
> 
>     ret = spprintf(b, size, "9***");
>     size -= ret;
>     b += ret;
>     // ret = 2  size = 0  buf = "123456789\0"

So here scnprint() would have returned 1, leaving size at 1. scnprintf()
has the invariant that, for non-zero size, the return value is strictly
less than that size, so when passed a size of 1, all subsequent calls
return 0 (corresponding to the fact that all it could do was to write
the '\0' terminator).

This pattern already exists, and is really the reason scnprint exists.
Yes, scnprintf() cannot distinguish overflow from
it-just-exactly-fitted. Maybe it would have been better to make it work
like this, but I don't think there's a real use - and we do have
seq_buf() if one really wants an interface that can build a string
piece-meal while keeping track of whether it ever caused overflow.

Rasmus


