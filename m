Return-Path: <linux-kernel+bounces-43451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A14841405
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE5A1C21E7F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E89C76041;
	Mon, 29 Jan 2024 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="hzzlTvyZ"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2138.outbound.protection.outlook.com [40.107.21.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B74F657A8;
	Mon, 29 Jan 2024 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558933; cv=fail; b=Ndm+J1MLTlSEPGhKA9wIuW3nVz6m3bpSW9DQ3Hn6I/C8kos1iTDpTzPZKgpdJfdQDNMiwiSFRbddRoy2xVDxnsMSjLrxZWPyQac65VIK15nDr2IeQezIhvkJeZcprlOi/JBDN98zy8kXU98UyLtuVfrShD8cbaIRC1D/w09wdZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558933; c=relaxed/simple;
	bh=Ydh0JVxs/HaK+kpSJTLlF6eLg9SIxLFZlcOBeVsPgV0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TXSsvnRTKd7PFCVfmEPc1AyGH73KELrBHsbJzHdD9NlcceRwosJ+8CJxjD63G2ny5a8kFlt/cmpU8tzFso8kEZS8ptoc0At+sSUKD+RjTwwgoPeVE8xevGsS0oMgbbna8riozMZvtTx5SVpzEfoB9ydGb8s0obiEUsLV4wo+vpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=hzzlTvyZ; arc=fail smtp.client-ip=40.107.21.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXD7pr//l/ctS3lxkl/FTurNqUE54+WhdtwcD6av7uO9z7BdDEnu5C1A1tCmiK/+gEMFZLXWBMlkUcF2aK/RhGIbRqpgfFn6ydxWlqeB/4+BwVx24/l9fqQdqJjsFwOKyo6CPHSgNs57TdEDODZn0Nz3CczvnNhE8s4lRa3Z4EWFcXWWv8J+JoOZnJ/izD0+KoVfivl3x4yWM/EsVJ1t86d5jobyyX/wXFo2Vkeb0AAwXGMiuk6J+GIS6sTNprFYcZchdPpGZwHoAQ+47gWBKCXJEr20xSXjFdNAuFPogcZI2QyPBFXZu7rdagliXCrJS7mlAZFPT5eQ7Xl0P3h5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSJ3/bkOfMBqAscJIG+TML+HXYF4V/gu9xwsGvDk8F8=;
 b=ODmnTZDSdCO5Y60qQ7Nz5fmIVa7z9YxNHlB1CHAhV8A6qaxw4JqUCaKL4laFEE1ZTnkazY4V9RZpJP6hYQydIIbaIv97QPx1yD29WzPDPR8rz3YOd92vZXO5xbQLa0xONb24OnMxgvVX0KBYzAUdkDPbbBsrOWBb8TDO1BThkDsjFBlYkot94mhqBMpSnbHsOHlzZ9LukoYTX6aDRFJn3UsaxvSC2MNelLEWV5kStBAYTJGLeIEGlQhUz7QPIUL93YQsj7TueHq/tVgjZ+b7fUcXXkcQ0AClJbgXhVfni9/Klvo6BN3r1G8vfXWlyuuFekvk5OMXTIOqvuXJ4INjrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSJ3/bkOfMBqAscJIG+TML+HXYF4V/gu9xwsGvDk8F8=;
 b=hzzlTvyZn/rTmAs1M2F0ci/hH9z54bBOrmaEMI8K/iDi0oa5ox02HnuF3ZWGCBugSyJlvWgrFbRT8xU1r3r++RaD7smyeO6YezkpLAHkAI7RAuFbC5fhgN8gr9RPa0dsJpcaAOCG18cdB5jqW6OnrryvMiPgklnTtJ69SLfUzew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM7PR10MB3159.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 20:08:46 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 20:08:46 +0000
Message-ID: <8dead2fb-d522-492b-89f2-1358198c1cdf@prevas.dk>
Date: Mon, 29 Jan 2024 21:08:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] overflow: Introduce add_wrap(), sub_wrap(), and
 mul_wrap()
Content-Language: en-US, da
To: Kees Cook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20240129182845.work.694-kees@kernel.org>
 <20240129183411.3791340-4-keescook@chromium.org>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240129183411.3791340-4-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0113.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::19) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM7PR10MB3159:EE_
X-MS-Office365-Filtering-Correlation-Id: 92dc2ec6-e89d-472e-1986-08dc210619a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FPLmun3NAgV7jBMnFHJjQxhvXHjrl9EmdBn8Te8cFmBgzOvHCly4BOnXQTeuCr8VAGu6e+SQbDeKLQuV16cau7cabXDXKN3kQLY0khqr0j8+TocLWs7jKcIXXgZMQLA6JcwZeQRpVQI2wNr3/fSSyc4l6eGVMJiiDdH3dfZhRKTTCHtQClSdCVzxP99D9C9cBEGYhYBVcEA/BpEedeAf9awGzuvdk87l/Alkp+a09CXQQG7SsJqAni8Qa3qe4h6GXqs3agT1clWOPRIGelvpfrqsv7uMd3KsonDVnz+Po2M/7hT+AEnVufUlo7ZKDy+qKnbWqvIWdkyRmA6U9oTWZmUn053KLyTpCwGS9nVD3tZRRL5fKFmgQ4Jlde+spVNsbFOWtHALULXa1AbcozugvM51OAh1iYqxUBKezZfuHX/Rw1kI3DdYzhajjjFSHgtKnWrVMPdVLT5S4IOwyik605x8BOlX9E1nDBTdY4EEKluLEKGSVJzwrg346d7As6NEgV7T+k2uWiAIVvN5ndqw48B4d8VKHHwp5oo4yW8SvAIdfGySQ9yCW/9of6U1v/EQlyBEQqsxgvFYCO6toh3sAjMB5eAqJzlRgfQhhzMp8gFyaZMHqgCWhIsynQ+3iSRAzLRZwS0aYrwqfAcsCmVG6w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(366004)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(2616005)(31686004)(26005)(6916009)(316002)(54906003)(6512007)(36756003)(66476007)(478600001)(6506007)(6666004)(6486002)(38100700002)(66556008)(8976002)(7416002)(31696002)(66946007)(86362001)(2906002)(8936002)(4326008)(8676002)(44832011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1ZtQVp3N1h6S2g5Y3dETjRWVW0zc1R3YlVBUFdCaHNxOGxkWi82bzV3Wmh5?=
 =?utf-8?B?WUs0bm42R0Vldi8xMno2cDJaUDMxQ1BCZ2xJR0tPdmJJbGJiYXgvRllGem8z?=
 =?utf-8?B?NU9Oa0ljUVBKdzNRdTI2MnBpbk5FVlpSVCtJazd2VTJQR081eUJlRnJqWkM4?=
 =?utf-8?B?UEdXa2dScEFLWFB4M1NpTTk5c1JEakJiSmpzL0ZRRmtDeEQyRDF3cW5RcVd2?=
 =?utf-8?B?TG9MbVFRSVRsRG9hbndJYTRRQkpoUWt5dVdSMHBGZEkzV1RValZ0ZmR1MG9Y?=
 =?utf-8?B?YXJJUlFkTFlQMUtueVYxL25EbFhuQVVHVStUY2VuQzc2ZzA1dHRvQkN0dStN?=
 =?utf-8?B?aFN3QkhERWN3L1doNWVYd0ZZakVKSlVRVmNOQ0hmSExoL1FqNDl2emx4dElh?=
 =?utf-8?B?cncrdFNjMkUzTEFSV0hDVmI2ellKSG5pNmVrWTFidWV3QURXa3RQalVTMndX?=
 =?utf-8?B?QmJRRWd0M0p4eVhLUVVzZ1FpVFd3d3NWUlVxczJFRjZsRjhzQ1NmeUpNUmx5?=
 =?utf-8?B?UVQydTNmVFhUeUdGRGc1VWw2R0o5aUg2MlBqa0pINnovejBvcDgwSy9uWjRq?=
 =?utf-8?B?aERxamhuTjVKZkZjd3Q5b3hVRnFNQWN3YXdtUUlIS1hlcmRYa0VveHdSRU8v?=
 =?utf-8?B?eE5BdE5WMGR3Q0tjRzBEMktnNTVVdW5NWkhVVUNFRlc4UVUzb3V2V2RUWDJC?=
 =?utf-8?B?TTJ1K0s1MU4raEJ6QWdENHJtZlczL2g2OCtxZWM5WkJVcVQxRW1YbVd5MndV?=
 =?utf-8?B?b0x1QUplSDhOYWw3Qlh2ZUVZSml4WUl6RmtIbldtN0ZxZHVPMXFtRGFaT3p4?=
 =?utf-8?B?UEZxdnl4MTk0R1NMRWczSytBcFgvL1dLYVpYZE5RWllsTnFnTEhua2R4cEtM?=
 =?utf-8?B?dmJubDBTZC9zYVpOREM3Z2FLMkRXMHFqejNHT0wxdFhjcjlKaUlHR2l3aDZI?=
 =?utf-8?B?bEkzd3U1aUI3ckd5S1lld0drc08zOFdXNzBYODZDVWpIZnZVdGJCejJGVUE3?=
 =?utf-8?B?Vm5lWWVUd3JqNkRPUm96SWRnNEs2cFFNQ0Yzek4rVy9ySjRRd29oYU9uM1pV?=
 =?utf-8?B?UVFrNkFhSmpMVkwzeFpTNVZvOU1QUkE4M3RuM2tDbUFSYmRPa291M0RRdkYy?=
 =?utf-8?B?MnZiZ0ZXK2plK2FONUthTHdNTDA5Nnh6UGhQSkhUR01hQjI5NUpSb0tTbmNE?=
 =?utf-8?B?eS9CdTgwY3FQdVFSZmJaNm5XS3p6YTdyVUp3YkpNRGlaZFdIR0toVEN1eXdZ?=
 =?utf-8?B?VVhBWkhQK0xwSnIrOVRLMzdtTEFnYjJFRDhTVityVE1yMTBOTnRNTEZmQW1M?=
 =?utf-8?B?MWs2TzBJbmtXU1kvandQdXZTUEU3NWdlbEJod1hGbzE0cXJlMDByWVovOWRI?=
 =?utf-8?B?L0I2dDMxWCtVTkh4bTlMbE1tQllVN1VaL3BxSG8va1hZMzVHdkp4TTh5Um5U?=
 =?utf-8?B?NGEweGROdmhZNVh1ZU1zQWQzaXJPbUFyazE2NG5seDZaTEplK3V5Y3BudlFq?=
 =?utf-8?B?UkVYRS9hWEk1UVZBNlpiS3lwdC9jNHN0aWc5cUdxdDd6eTdaN0NmOU5XMEVT?=
 =?utf-8?B?OW5FQTNZeUdVUlhsMFpvYkpDd0RxdUhSNXhOeGQzaUswQkhFTk5nb0FZQWxR?=
 =?utf-8?B?TlE5T1JnNGM1RzJCcEZMNklhc1FDMWxjY0sxN0hLS1ZtSVUrbDlWWjBBeEJP?=
 =?utf-8?B?RmhjTkxvYjdRb1FvOWtBWkRzYmVRbXdTWWx0Wmc4eTdwZXVFTnlJS2p5Uktw?=
 =?utf-8?B?ckxuYmZndXZ6WlRrNzE1blBBdXdaYTB6MmFBdS9qOXFzc05meGRsd0tyYWQ3?=
 =?utf-8?B?bVV1ZnhMYzNEcmNhM2loaHExd1JjSUluaGVKM3J6YWprL1Bab0V2UTRjdStC?=
 =?utf-8?B?UytLMW9IRkVaWkU5azFKcXJSclF4Z3JvWE5ESm5MQmFrU3pZUHRiaytUQlRr?=
 =?utf-8?B?Uml4Mjg4N1RTeVc1am5hOTVNYUw1Nlp2MVZpRnNjeXR0RmRtN2k4NFNCYTlB?=
 =?utf-8?B?QnVKR2V1aUxZdUltdnA5bU1aWnlpMjJzRXlVWU1xVW9FaW1vbHdDSzAwM2wr?=
 =?utf-8?B?RTk3U1FadDVEUFlSSVRJOEIyMDdLeE9xMzR0V1JEa0pYQ015dGVYOEN6V1dm?=
 =?utf-8?B?U0l3cUpVMzNHMlFDZEZ4SFRHQVgva0txYk95VmEzTHlIbzR5SXZEL0VtK2Vw?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 92dc2ec6-e89d-472e-1986-08dc210619a0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 20:08:46.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yr43SU9WqicCZLSDa53vROMfOy5IuKSNvBG/cX8v+5UW8jk4XXVoDdQPaTTTP16iXVfMSql28MJ3Speb8yoALk8Sox9WXA7UGmXiWwHQe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3159

On 29/01/2024 19.34, Kees Cook wrote:
> Provide helpers that will perform wrapping addition, subtraction, or
> multiplication without tripping the arithmetic wrap-around sanitizers. The
> first argument is the type under which the wrap-around should happen
> with. In other words, these two calls will get very different results:
> 
> 	add_wrap(int, 50, 50) == 2500
> 	add_wrap(u8,  50, 50) ==  196

s/add/mul/g I suppose.


> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/overflow.h | 54 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 3c46c648d2e8..4f945e9e7881 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -120,6 +120,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  		check_add_overflow(var, offset, &__result);	\
>  	}))
>  
> +/**
> + * add_wrap() - Intentionally perform a wrapping addition
> + * @type: type to check overflow against

Well, nothing is "checked", so why not just say "type of result"?

>  
> +/**
> + * sub_wrap() - Intentionally perform a wrapping subtraction
> + * @type: type to check underflow against

The terminology becomes muddy, is (INT_MAX) - (-1) an underflow or
overflow? Anyway, see above.

>  
> +/**
> + * mul_wrap() - Intentionally perform a wrapping multiplication
> + * @type: type to check underflow against

And here there's definitely a copy-pasto.

The code itself looks fine.

Rasmus


