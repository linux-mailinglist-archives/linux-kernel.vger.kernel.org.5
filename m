Return-Path: <linux-kernel+bounces-43455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A616841413
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAEDA1F24585
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645887604A;
	Mon, 29 Jan 2024 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="emp6LSgH"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2125.outbound.protection.outlook.com [40.107.6.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B740C76037;
	Mon, 29 Jan 2024 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706559404; cv=fail; b=IhY1imyIiA1AUyeGbgr9CGu0axBYTbyv05BYYN4f4MRPmlT8khIreLLXODODlseY5CJzQZuRaolkUEN41NLDGGsKlVtl74w3SczmSXsdIhKfXCxVva9R5kluN2wafjAr9fDHo7LwTyINPO4sPI0J4TJ/yEVdoEW6is8js9JRnmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706559404; c=relaxed/simple;
	bh=XS4fGporXJGlnLFxdAC+duY31ksSwbiWw7w9fUQr2ok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h71UE14so3N2dvuRaZ6OfVYsg/U/yNMgx8TtsCEPyJl5YYl+oTwvmXzH4K4hFw4hE5T7Ru69yzZQpwcdOGhUprw0UnO0Mf7oYIm7bo9R7gDZwfI4oQEf+avUXIr5wXWydF16jwpNbHaDf39drJcQjOHINtkM0FOzUdtvWH7QlgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=emp6LSgH; arc=fail smtp.client-ip=40.107.6.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOt4kmeIn5KoWQTzTSqRNQTPGFEMl6FlyeJxJ2hXvAxoNCgAzePwMSrAB+UN31YfMiW/a1chUox6w3ryh1TYPgiYpdfk8dzdrXKxkC7dESZTkrfNNXYNIkukeACPXXS6AJ1SQjV4lCkACEx26PJxQ8CIBZ/GCJUBZCyLlxzyBM/70hN7pTBQKTZsyzZJa2evvezPe09KcohleZSRqrs40iCAiNHCxWWa8FFkcZ+rr49k7FBbyCG+UC1mecj9faAhaG7H/CW69uSUjNmm8OlSSGqcHqVvrz5MUHeeGrWfTLodd+YhPpZig8XOl70KMG5ulhOVZp6Ch7bde2Av+aYkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STATidvgRcl4kE44tZzQyGWVeYrnKC+Z5eAvDBYkx7w=;
 b=eFeR/RbHXX/SwcAB2JKe7rwo6C0SG/D5jMo4sHNiG+JpetYjLrOYFd1WcEXS/4iIdkY4k8ONKgnOh7jsw0B0hOaq+qSJzihqTsqIMDXM66OHgIIPQl3aPMzApPMlhthmP31tPMovGCRUBiUP8xZ0FOzO0l2rMH/dzJwJD40k+bQcoZMeNyGVRxhK/JXffAbYX0JVpwxwkfg18isdiixgLQocK3AuoP+JPyQkeTKJjUmLlVCdEpVkX+O+2lCU95JyVnBMkqt4v9AeC7X4GqIP/OcTHA7qIRTXKwqTnXf2wNVAEaoaMtAqtlm8BQbIQech2+jUi98NvFz5SuKjHn8VNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STATidvgRcl4kE44tZzQyGWVeYrnKC+Z5eAvDBYkx7w=;
 b=emp6LSgHJD0liZtzqOCZ+UYvldeaB33RfRzg/4hq450NGfhmvvyMfRv8hz53hfdY78dvLvh/k1PiMxTLpKvGf/cOAlM0UtepeovQWOKW0ml/yxusWPpVr76rhaXxlZR+oFWJCWfT6SLCzUwpydxNuq3MTjnW/XJLuaZrsmsw53E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB6770.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 20:16:39 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 20:16:38 +0000
Message-ID: <33dcfa96-e584-404e-a9e5-afeca9105818@prevas.dk>
Date: Mon, 29 Jan 2024 21:16:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] overflow: Introduce inc_wrap() and dec_wrap()
Content-Language: en-US, da
To: Kees Cook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240129182845.work.694-kees@kernel.org>
 <20240129183411.3791340-5-keescook@chromium.org>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240129183411.3791340-5-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0117.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::32) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b3dcd3-d57a-4845-6611-08dc2107333f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wEWjHIFVbNtOpVHhv83nyjuwGexp1BwTZFEPV1tXpT4VM9VUciaXtEILGl1K1UP1Im8hmnYzzataX+fBL2uCDQ+vHOmziwwnm7g5kLbS7SFBncCbcV3wCfuJFReqUuM7ZNu5DcraIxnvqyikcgEcIQNNrjIMbWR9NoLTaUbeSJgFp84HZ6uQm0z5MbbQEoPU9PU4jivMNNINPyQf1SFxNu62+PuSicfQuF8in+YXkqwHJsNp57aooDVvxl9BmGvA4OOwsQoB9bp7A/S0r+M9LLRsOTPdL4Q17fSuo3m9swmBe9l7lhvXgGI3KDE+HgUuAT+7iPWsiNf8lgP8+GreiFNNQTj4wdL3YchoCrTVF+t/FP+eh/ZInrOYqu3bnoo9cJOimpTQ6OFdUawC++ihHyryTgjTbtithtj51RuKGvHHCW8lpDBWh5sIY3K106IKyS3LWBLO2QNHxeLvB+DVOg4QXE84Sl+qkHCmpeIlpULB3jF+pp0EdXcEmk8pigK7elDbC8q+KX5u05seqsHpvZuwym0iS9XQoTk0O5cT+JEYyWPAf2JhPj6fQPO3J+AowJ1lVPCV0Chw4TA+BnfVwLElBwDnfnJBAOkTBHzjHiRZ2d70YGDWIlG+YGPr7nkLX7z+stwC52zCV2PFmRFYXA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39850400004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(31686004)(6512007)(6506007)(36756003)(31696002)(86362001)(44832011)(8676002)(8936002)(41300700001)(4326008)(5660300002)(66946007)(8976002)(478600001)(38100700002)(316002)(66476007)(6916009)(54906003)(66556008)(7416002)(6486002)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTZYTWkramlSS3hpM0FTZGluSWVRK3hHTlZabGZiNlhRdFhYdEJTWnc1ZEt1?=
 =?utf-8?B?NmFuZlEwVWlTMmpOYU5Xcmt0TUpOdVVlZlloOURDYmJzeEFCdjl4dTVVWnpq?=
 =?utf-8?B?bVNqNEk5akIwN0ZqWFAwVnhOcGpybmdwZWxNN1ZBUnFIR1I2NStuYVNvVGFG?=
 =?utf-8?B?TTZRd0grZFhqdzlGNjg1QzZQL0JFUm44SXU2VnNobmFsSmR6Nmdrem5pQ0hs?=
 =?utf-8?B?SjhRRWtWVnFHYmwzejVoQzRJSis0ZGEvNjFOcDVJajlCRUY0VSsyRjBVODUr?=
 =?utf-8?B?UVJQQUgyY3ovWUdkNXA0UnJza3NNRXJ3Tk5ORUt3WUVYaUgwRW9DeEluL2F1?=
 =?utf-8?B?RjdORms1TU9FeHVJemdFNExNYTB2WHE0WTd6TjZXU29TRXNwM3Vielo4emJu?=
 =?utf-8?B?cUlFcm92Zm10c3VTcHNXSjdjUE5kZEVTUnJYN1pyOGk0SXVaWkdja2NidVZS?=
 =?utf-8?B?T2JZU0xUMEZuMjh1QnZJbWV4cllZcEErSWdTREJhU3krbFg4bzBqWVN6a2Rx?=
 =?utf-8?B?NmdqNjdnZC9LMGJpL3J0UjVGZTZPcFNoekxqdEF5bmd2L3hkKzltRXBPL0d5?=
 =?utf-8?B?TVI0TEhlR2VUU25PSXI0QkhLeEJNYUl4LzY2UEJwTkNnS2g3RnRHTjdYOXhD?=
 =?utf-8?B?eko4OWhkMzRVSUR0MHRLSlFBcHVmdXFpUnVjbHJmLzdKdmtjeTRORjUrY29B?=
 =?utf-8?B?azk1cU1RZlE0TG8zVlV4SkRObnRUdlBVQjY1L1NuTExkL1hld1pPQkp6RUxW?=
 =?utf-8?B?NlE5TnQ5UWZmQTM3SWNxZU5oVEg3WGtIQm1iOWQ2K3YrU1pDeDM0VmtQQ3RF?=
 =?utf-8?B?Y3U2RVF2dkFuN1JGT2FNWUMvMkVCdDJwSVpHdWxUWDlGcyt5TXBzQ21MNzFJ?=
 =?utf-8?B?bGJZMllsbWF6Z2pSdmhCR1ZjQVFWY3phY01zQXlJSUpwMUhHeitFZHVZMzhB?=
 =?utf-8?B?UTJLN2RXQmU1VzJvcldpd3kyQjU0MWxHbHdwanowTnJPTlcvaUdNSEtoUnVx?=
 =?utf-8?B?RGJMY0ZhK2grc1ZDcnlEL3c3THhSUm52aEgzWFR3OC9rNElHaGQ5ZUNrWXky?=
 =?utf-8?B?d2NXK0Jua0ZLYjlWVWgxYVJkKy8ya2tXbXQ1L0c2blVOUkUwQTlITmZRSzd6?=
 =?utf-8?B?SlRQVFlDTE9QYUFzUXBhM0JBSTJFdC9lQW9ueFNOR21ydXNWckNSTzNnYklG?=
 =?utf-8?B?VVlxdmRKTmdyeGN5NVNtTGZUd2oxeTdiOWFhbjA3VzNhWlVrcjNHSG9vemZW?=
 =?utf-8?B?YjdvZk9tM2ZJS1Bqb1hzYWdkaVcvOGJwbmpXclV3Wk9jRERIY3JFTm96QWN5?=
 =?utf-8?B?ZFlwRWY2SFkzRXh5bVUzWG5uT0MrTk9YbjJmekthK0FBcEQ1OGUwQmd0Umsy?=
 =?utf-8?B?SlJ3OWg0WGZlSnFXaGhMUDVTU3dJSWcvUFFwVUV1bkRTSTkzcG1IYXNGTDMz?=
 =?utf-8?B?TXVqTm11Tks1em1Da2VnNnBVVmVJRkNMcHBTbnZmVGhBQkdQNHoxcGViemo3?=
 =?utf-8?B?bVRHaVdKOUdCR1NieUlJOFhIRVQ3dXd5dlFvSHNHVFBQdzJOZ0tIQlNPbGtJ?=
 =?utf-8?B?V3pTaXgwc0ZUVXhCR2hMWTRUdk1MRFgzK2VjdmovSEw2bFJYcmQ3T0o2UnV2?=
 =?utf-8?B?VkdtRmtiSkJ6eWhwd0EvODJVRmVkRk9FaEpCL0FaMjFHKzlrTUllUHNpdDdI?=
 =?utf-8?B?WkFsdEtKc3J6cGdLeHh3akdKMG9wM1JMOW04anlPM1FwZXRHbDM0d29mQ3hp?=
 =?utf-8?B?ZjlENE9MSks4RnNhZ1g3WnFJMmp0S1FJMEFUQ2Z2Wm5XWnB2V0RlVWsvN1Vy?=
 =?utf-8?B?RXppeWZyekZGL3RuWEJnMkdPTU1sSkJQMFoxVk5XazgxNG9uVUg2VDZETWFB?=
 =?utf-8?B?U1cyL01LclJ4T2dKYzlYQ3B6WjJSMFdkVURsajJaUG5IVG1PWUFVUjBhUFBE?=
 =?utf-8?B?YlNqbHVybEk4OFB2QUtma3MvNERWbzE5Wmptdy9PcTFMbS9hZFpLR3JZTjdO?=
 =?utf-8?B?R29zU3oraUpXeSt6eFpqVDFPUFREOTc0cFh1ZzlMOWk2aGhqU2l3dE5hYlVi?=
 =?utf-8?B?MDRkQ0RJVGptejJ4ck1vMWhUbENja08zbWRBc2ZuSjdNWGNlVUxEa3krcWU1?=
 =?utf-8?B?eWtqTDJGZUh6VFMzRVl4ZFhhYkRtbzFlS1MrNkZReGFvbE9mdFFkL0RiekR2?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b3dcd3-d57a-4845-6611-08dc2107333f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 20:16:38.9138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9jUUikgWXNxLGzOGKrInZLFxDEgmVOXgthrKLVb+a9jbm/ipeCaSFlQ0JVBywRaRB1GfLSNThx8RHXsGTNuq90jN4Jta1D8XT4Y2vG1X+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6770

On 29/01/2024 19.34, Kees Cook wrote:
> This allows replacements of the idioms "var += offset" and "var -= offset"
> with the inc_wrap() and dec_wrap() helpers respectively. They will avoid
> wrap-around sanitizer instrumentation.
> 
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/overflow.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 4f945e9e7881..080b18b84498 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -138,6 +138,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  		__sum;					\
>  	})
>  
> +/**
> + * add_wrap() - Intentionally perform a wrapping increment

inc_wrap

> + * @a: variable to be incremented
> + * @b: amount to add
> + *
> + * Increments @a by @b with wrap-around. Returns the resulting
> + * value of @a. Will not trip any wrap-around sanitizers.
> + */
> +#define inc_wrap(var, offset)					\
> +	({							\
> +		if (check_add_overflow(var, offset, &var)) {	\
> +			/* do nothing */			\
> +		}						\
> +		var;						\

Hm. I wonder if multiple evaluations of var could be a problem.
Obviously never if var is actually some automatic variable, nor if it is
some simple foo->bar expression. But nothing really prevents var from
being, say, foo[gimme_an_index()] or something similarly convoluted.

Does the compiler generate ok code if one does

  typeof(var) *__pvar = &(var);
  if (check_add_overflow(*__pvar, offset, __pvar)) {}
  *__pvar;

[in fact, does it even generate code, i.e. does it compile?]

I dunno, maybe it's overkill to worry about.

Rasmus


