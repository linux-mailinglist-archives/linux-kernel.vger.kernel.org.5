Return-Path: <linux-kernel+bounces-54518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B119084B030
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FE61F21B6D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB9112BF14;
	Tue,  6 Feb 2024 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="asKSGC0Z"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2074.outbound.protection.outlook.com [40.107.241.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE012BEB6;
	Tue,  6 Feb 2024 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208958; cv=fail; b=efQgR+zRBtGMY7L20ZY1gHxfwTc77ZLAON9FESW0oaKRXlIfWG9c5mRAFvLGX2TwS1gGbY4BvNVkNP593U8rrN+pl4MUwUSiMad79nEl4l7rPzOvK3xu4LekYFVk3d3c9CdfgJVEE55Pj4zerIGOHf064l+RpMkKRjUKRFe4soA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208958; c=relaxed/simple;
	bh=EqWvdiMRZ7ljqQ1exOF4MyAedqXHMzEbmF7vev9qw9E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MuzC9d4erBbamv/oduxOjv/QpUuF8vW6ALu5BiiAbO//YXQ6sP5AHs5Sr9ATsqXhYAwIv57sqrnLbiiTbtQ1YTBTcNKWbRD/eeaHjnwXDQy5h+bbLI5AVs/oBG4okS1x6kaG9l4tusdo+I3iqQlxkSG0YmthAW1xkLMPjBkYpnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=asKSGC0Z; arc=fail smtp.client-ip=40.107.241.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2/Wm9gMg/tnVme2Rv4DPcYQ164QQYhg43zrkC+eA29C86IDzB/rB04M4lxvUqpSija/wZHERmi7QrPIaE7BlyjZWF/eBt3F6KPaY9uKaxh8PLqY2GSEagaeMPMtWCUgvJnnb02hsd4/HKTLZ8UI2w7g73SqoQxvFpEJa0PL3fJMwjemNlcpdMVoi1qUmMDfKucfC2MmY5ubW+2JFwpeER4VTiojWXuJTAOGXOrD/P8fZDZFsdZLyplNorACxVYrucE6zPXPPXzxSsIQxHvswrP+9Ghxm7O/qcGGsPXZadUCD+8SLF6pytIOGDojlbfWHx8KVF0yOl4BONAo+0rUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGPjGqp6FMwvgVibuvaJTE7X1rRkUrnQ2mtfS2dQRLI=;
 b=a8+jsH7ZYo/0F00LYHup1wXIM8M5y/QOXOXNdL9bF/lX70A6uSEh49eXm8YbqsUoN+bJZVjVShnXmQaEczUUyFa05sb59Hy6LO+8LxF0cb1QhArwwHjL0Cbpu0myVS9T+htkzYvj/Hf3FB3zkIlS+mVU1U+Vy5uiyjLJEac86ppl8bTRlk9hREYLR8+6Rg27nFSk9t3n+Hdme9FOAXrt3Qz3yKu6TB/C+rUin4qVcpomM81Ps5h4cV2LEpcePhIhu5svEagIeWIvDrTr3AC3J8H+gNIMd1XjmourcjxNiLqcd9Mdbf9+EEMgPVdHZW9LTdiMBuyLHQ7gntUd6sVjBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGPjGqp6FMwvgVibuvaJTE7X1rRkUrnQ2mtfS2dQRLI=;
 b=asKSGC0ZJtK/X+U/v/Zyl+qn6nHbLw6USvphuExSAMtiKQSfH7fkS/5doMiAZcCjVX8LoF1o6arKppr6vu5ifqWoDkpRQFRVE5FTd3KnveuZ4mw6QC2gN54YUJWh/OH9JRkepkAQAmQCZZ0dpZfifjy5w4g/DSzpmtpY2jf5gZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB6668.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 08:42:29 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 08:42:29 +0000
Message-ID: <1ee4bd0f-2a70-4696-bad3-782b5c0887f7@prevas.dk>
Date: Tue, 6 Feb 2024 09:42:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and
 mul_wrap()
Content-Language: en-US, da
To: Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Marco Elver
 <elver@google.com>, linux-kernel@vger.kernel.org
References: <20240205090854.make.507-kees@kernel.org>
 <20240205091233.1357377-2-keescook@chromium.org>
 <20240205202145.GB2220@sol.localdomain> <202402051443.A813E4D@keescook>
 <20240205231712.GC2220@sol.localdomain>
 <51025C22-0FEF-4047-BC36-EA7ED7A3BD62@kernel.org>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <51025C22-0FEF-4047-BC36-EA7ED7A3BD62@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0015.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: c18da68a-9205-4ea2-7a53-08dc26ef8d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FQY4LcMBzE27fI9ECNM8q9+W6ekRy92okZ21BnUSSuTv3PZaTgr42xnZtre5Ip/NwTXX+E0SVha7YdIXHPdDaM8/OFvTfZIxwOWvXoqxFTB1I1gEtWeiwmtwzuQI5Y585D15gQhNMetFrp4gern/roLGxuFF4J+k8Srq08vIsKDLSiOmoDO1878+1+zybJvluFBCt4vLPpS/5Did33OyUEGlt9Wt+E4frwveq0fFXu2o2B8RDxf65bBLJwjReusEFO/ZOo4C2PEquYsN0LAOGEmTn2aeULnEHb8IC7g7TVQv5zzJqgFYpo4O8p9IKItyotw2g7IQJvV53tlzyLHQ52gKw7ootm9IoCSq+Ban3shHp+/sOcFj2yDwj5UI+zqaARZ9Ekz5PGnyD6T6h9+GEJOiWiTN9e9+xTEOpozsEv4K/lRMzrPdIRfzvVB7ew0zbaF+5Y3EiJ3tDTsdyTdlHdLZXdaUp+HAFBB8opOb1OFb37vQc8kz842GBplQEJkmO2yH1FYHYPe7hZPiNjbuOulRggbBeHQT2oaqXlX/6IEX0T7q/qVVin4XeVcLNOdipl8p3NmFtOCSC4Q2gufz5Wr650+ab5PSgly+HTcIOHLxnr8MYRT4kgfo+si+m8p4jEZYBt1QpRbgPjXDoysbhg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39850400004)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(44832011)(2906002)(31686004)(41300700001)(83380400001)(38100700002)(31696002)(26005)(2616005)(86362001)(6506007)(6512007)(66476007)(54906003)(6666004)(478600001)(6486002)(66556008)(66946007)(110136005)(36756003)(4326008)(8976002)(8676002)(8936002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3cyWk9SdkZMOEdYOXp0cHVKbVFTeFBpcW9qSUNRTDIrNGZkUDd4b2NSQjU3?=
 =?utf-8?B?RzZwTzA4OFBuUDI3M2dPa0ZDV2l3ejUvKzRpZjNGbGRTRGlRSEFpSDJCckxT?=
 =?utf-8?B?Nk5ocmZONkgwSjhwWjJGZ0dEd0x2aThaMHVLZDBQZlYxUlZaY3RpYXNIWjBy?=
 =?utf-8?B?ZXBIMlMwQ2FRTUZQV01XMmQ5UDNEd1owc1FKUkI0blJ6SWNzZWNPcWdqU2lI?=
 =?utf-8?B?bVUwOTNGazZqcUUxYUZ3Z1hpV01UWjNCc1pRZnA3OCtSMU95SE11V08xSVpH?=
 =?utf-8?B?dkY2VWZzZDEzdERIL3pLY1ljZ2E3SkxjbUVtL2tPSzlESHUzcTBjTEsvdHpx?=
 =?utf-8?B?aU5UNHFpY3NOV0c4NXJQZC9nK0Z2aUJ6clkxMi9IYms4Q1YxRStlZzRzMzJC?=
 =?utf-8?B?V1ovU05lYlBZMTZXRjlnbGxWaTk0S1RvQlVTNnlDWDVaS244R01Lcjh1R2xq?=
 =?utf-8?B?anU3ZklheTUraHQwOXN0SUR0R2toWG5GWEExRXVUUVVWSkVEZ0VzRmVnNmM0?=
 =?utf-8?B?ODlCMGlkS3ZLemJZRzRFbFdYSG1wTlA5UHB3UTBva1o2SHZkUzFVUjZabjhR?=
 =?utf-8?B?QVRiczhrWlRjZTJEUXh4bThEcUxhTzRHM080eTlBU0dCYnRuaXVLcVJWTWRz?=
 =?utf-8?B?UytpSXYybDlEWitORU45NHlhVytRaDU2Kzg5cTdDcWdEa0hCMnFOdDhtK01x?=
 =?utf-8?B?MExpS3J3eWkzYnBrOTdrWkRMYXRIbHlJRXZTbUI1VmtTWEIwSHhIWVRhV0Nj?=
 =?utf-8?B?Wi9sZFhvYUlEV2xrSk5nNkJjOHRKcEwyOTlQNVJEKzVHWjNwb2xpUWY3WEtm?=
 =?utf-8?B?ZUxSZVR4cHY2Q1BpYUtzZG03bitMaldscDNvVEtFMjJJMmIwNHM2MGJiOHYv?=
 =?utf-8?B?aE1KbWtqM1gwT0lyVzJlcWFHR3U4a1huVWh2ajZXQTNrdGgzMDlld3hSTnVy?=
 =?utf-8?B?OHB6QVJuTXZZUEdjeXB6QnczcEtza2g0RzZ3cjdqZnFmWHd0Nm5zamdsTmJw?=
 =?utf-8?B?UlVTRHdwa21xUjk0WFRpdVlvaHhCZDBtaUVHQkR5UFNnZHpRYlRRbldtRFYv?=
 =?utf-8?B?ZDdWNjZwT3VHNy9HRTRKbE1xY2wvTmg5U3FnNk95L3dPalU5Nk5WSUxkcHlT?=
 =?utf-8?B?dkVaM08xMTZyQzNMMG50Q2Z2QThGbWVsSStkWDFjOVZwM3d1V0YySmNSQUpO?=
 =?utf-8?B?NERwcVVpZmwxK0VvaXlpTGtyQytXa3dzYVdjYytFMjFEcEdldmUwNmY4ckpm?=
 =?utf-8?B?Z1FwalpsYURlNTZabndmMmt3UVB0emR2Z2lKR0JtUHFZOVBLd3p3L0NXNmhC?=
 =?utf-8?B?eElYUFdzdWl3QTZEbkZUNXRJL2pUY0hzRldiOVdKSmUzTmM0S0kwT04vOEFW?=
 =?utf-8?B?U1lqRjNGSC9DMzhFMk1NNHNRQWZiZmw2YnNJTi96MFlYdFJoRlBBeTRtUFlj?=
 =?utf-8?B?djk2aFZIWi9TZ0o2c2UzT2FTbjlxc05SdG9mMVdldC81blhkWkxRNVJJRjV4?=
 =?utf-8?B?aTNJeXFyUGovMVJsNlNYaHoxa0o4TWtnb1Azb1lYeEU5dVlZc3pLNGdwcDM2?=
 =?utf-8?B?NWt1Smg2YVlEbVJleTVpTG9BL2ozRFRvUmlzamtrSlFRREJwZTgzOEpOTU50?=
 =?utf-8?B?U2VXVjlKN0dJWTlRUGpxMlBKdE1KWjNtOEEzMHhRN1Arcy9tSDZhcGJ6TWFu?=
 =?utf-8?B?WEpaaVloUkg3dHZhdEcrbzRNUzdmMm5aQjNPQmdIdEwvWUhMZENybXQ3UmFZ?=
 =?utf-8?B?VkxIbjN4SG5vcnVpdDNDVkZNdVM3S2wxOUxFTng1T0JUUm5jZmF2OXRNOUhX?=
 =?utf-8?B?MktVTWRoN1FDaEhLYWxRQ1ArNW1wVXJGdWJwd0puVHlSSkQwM2VMcEhmTEdj?=
 =?utf-8?B?aXpRS3piWTNiNUp4aE1jZnAyZlFZRU43Vk5kWkp0Z2hYTkgySU5aUG83djVF?=
 =?utf-8?B?UEg5VUlFYkR2TjlKclNiSE82U1VoRDlta1NCeXJKcG8yZUZjVzViSGVIa3pC?=
 =?utf-8?B?dWlBZEVEMlIvZnliOCtwSXYrcE1qdC9NcjJGak1EMVlYR2c3a1hCT1FjTnBi?=
 =?utf-8?B?V0tyRzVzdTh4QjBhY3EvRFF0WE5WOGdDbENBYW5iSVcxVDVJZFI3dDBHZlBT?=
 =?utf-8?B?Nm5WYVdjajBsL0wzT0FGRVM0dEZPaVRKNWY0RSs4ZVhQcTlZdGFHNEkxMDd4?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c18da68a-9205-4ea2-7a53-08dc26ef8d52
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 08:42:29.0735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FCxC9rDikHcH2u4qKFtLX+iEFk42ZwgojLXhPGaC1R3BV4jDqHwi5E8HrrrtlcqddCC7BGU5WXjjisQfowT6xiTcbDG/oR6P/EUtZkmnLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6668

On 06/02/2024 00.21, Kees Cook wrote:
> 
> 
> On February 5, 2024 11:17:12 PM GMT, Eric Biggers <ebiggers@kernel.org> wrote:
>> On Mon, Feb 05, 2024 at 02:44:14PM -0800, Kees Cook wrote:
>>> On Mon, Feb 05, 2024 at 12:21:45PM -0800, Eric Biggers wrote:
>>>> On Mon, Feb 05, 2024 at 01:12:30AM -0800, Kees Cook wrote:
>>>>> Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and mul_wrap()
>>>>
>>>> Maybe these should be called wrapping_add, wrapping_sub, and wrapping_mul?
>>>> Those names are more grammatically correct, and Rust chose those names too.
>>>
>>> Sure, that works for me. What bout the inc_wrap() and dec_wrap() names?
>>> I assume wrapping_inc() and wrapping_dec() ?
>>>
>>
>> Yes, though I'm not sure those should exist at all.  Maybe a += b should just
>> become a = wrapping_add(a, b), instead of wrapping_inc(a, b)?
>> wrapping_inc(a, b) isn't as self-explanatory.  Likewise for wrapping_dec.
> 
> It was to avoid repeating type information, as it would go from:
> 
> var_a += var_b;
> 
> to:
> 
> var_a = wrapping_add(typeof(var_a), var_a, var_b);
> 
> Which repeats "var_a" 3 times. :|

Yeah, I think that's a reasonable rationale. I'm fine with the
wrapping_* naming, and then the _inc and _dec helpers should follow.

However, I now wonder if those should really also return the new value.
Yes, that corresponds to the value of the expression (a += b), but
nobody would ever write c = (a += b) or otherwise make use of that
value, and the naming doesn't immediately imply whether one should think
of ++a or a++.

Rasmus


