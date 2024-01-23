Return-Path: <linux-kernel+bounces-34861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435E2838870
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6ADC28178D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE86656452;
	Tue, 23 Jan 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="UIBYPxUF"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2113.outbound.protection.outlook.com [40.107.22.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738F51C3A;
	Tue, 23 Jan 2024 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997010; cv=fail; b=OBzjpzwCYjng4zUI/tMnDGSJT3ab3dJb9aHIpF64d2QDa9//kSP8bbrPWJjtBQWkT+63MU6Tgap2ihm5jGLH2xOxiPq1BK6oxULObffrXDnu1BNGd4bCQk+v9zBLD543El3qGnaD7OElNcy+s18F8FJkO9LeVhUDiUtegFbMRcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997010; c=relaxed/simple;
	bh=99A730lTFrney3/KbzDOZubWWq2VKog+qUBpWw3s9EY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HGCfGZNr+8WF5SdjzHumRsE8V1+CxGzl25X6vv/9zPsL/cOPR7FckYNFHuY3XriAUqmtt+qkROAshJ9V0kMad/5EWIAYqw74bginKy3q8M4tlVVR7iQTnTKBvLDJyGIXjRFVhzD5M7qAzajyyJYKGimc/Fy1mUTfkhGKMhtbPwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=UIBYPxUF; arc=fail smtp.client-ip=40.107.22.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9wahfhhb8HHp8d346/9ZFHJzdoegPMCYkNVnoAuZmezG/LJ+dWrKKLQ1XAlPABmNCV2lNHnTyMCIpTNWak1/C4lcLih5+Ng9SWXX1DbbIT+zuT6gQYi+7qrVzvp8uDPD5VK66Yk8UpxIA7ctlcGZTGCKOWHmE3/0NsvlLMNs6zuiKjseweUkNq5KJOSq7W2Lmba5mJ3QoR7m3II7P9goO9oIuMBBaVde3LmIRjlUXIDvjtObu2ozMSJ+BFoyKk80AzMzfMC7yO7Ia0//jYcVuM9Qq2GOXBY01ESSKdtxWsLVL2pJ3G16JynAJjkHpN4ONaY50+PkN/6aof+0kENIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzkOgJODO7bpe6cdm6Cc77A+B4EoeyBilOw+Box3yMQ=;
 b=nbolzGsyUKnkxxuR+rsp26nhnMMYqNyakwyF2JPL81rfqrNFPzedOibNX+EONzXMFfkcw0FLVkGJHAjWLJyOpywi+SdQaVa7av4QfotRKe8gX62XuaF7L+GBzHZbqeWJLgbIQEvy8NxElPnOpbEwV4NL2rSQFlWPoCmxDQCavGTssh8q7kH8MGkH9cAWVd1809f5/0iUe1J86Xcn/jxJCEa5hSvyfAP1sUroGmZTQbYMWi68vi3XBskkM9jxDq04jcdbVi4qTjeAUuix2nDwbZp0hyJrMXW1pSOO8tpjlm5RZ0ZDATTi9QyXtknaAfM/92bZfAv3HcD40XbFyu+Ipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzkOgJODO7bpe6cdm6Cc77A+B4EoeyBilOw+Box3yMQ=;
 b=UIBYPxUFH2DpV2vW4R8n8C9r4kyvx4tH07CvIL0leLeEzyjUqU2XkDk0iYF64Fxqdzr1vv9Ez+8Nkc6ItqHRac8A0F9DiJ1gM04o0B55AZts5S0srZMBHyXATN2KvbrdYoeQYFxiQkcXmiPFvTVeJAi1z5lu4j8wFiY4d0lfhLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS5PR10MB8055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:650::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 08:03:13 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 08:03:13 +0000
Message-ID: <53a886c9-10df-4bc5-9de2-d9f99ea78278@prevas.dk>
Date: Tue, 23 Jan 2024 09:03:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/82] overflow: Introduce add_would_overflow()
To: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-2-keescook@chromium.org>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240123002814.1396804-2-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0033.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::13) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS5PR10MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 678c4a6f-42f8-4eaa-e904-08dc1be9bf50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mblYbXhaQaQjrxKcZ/lEre9dgRBtjKWgH9PplXA48n9EiXrfSgcsuVqyr0VvgrL1Xbwv0YEWsE6tbEGDEwrfJuPrxNPL2RNyJoXDrqPWCF2b8ZoGiDXaMooBiZ4G5SfXD2+IxMyRuipAxTV0qgi3VCsn5QhhnLsFvRX85Ija7YzmIqRIAt4iSVijUl7mRwuphMoG887E7jaId+F+Z3VaumpjD+HnY5Q4DP9P2siS/T4KB6UXcb3+uCUA04MS1QtIZXGpaDvhC5I/vgLPAmUvREw1TAqJH2Eq4queeZXJ89xyCjVXeFtZ75an7z44au+0ydy0vgMxjI+POJ7vbasUqy0z3+z7PzcLvvHZNMX3fLyV38w3fQRuaCCrD4AEt0pifcU7DQ4Y06uQiPwnOFdABawBbENYFpsqyn7C1TXX6qAMUcLhaokTa8+mNCYYw2Ka0O6106a8/NdH/voQBCU6XC/rRVNIX8hSTO/Ign6qGSR4EUvf/Z9fmzheippboCe/wz6ARMjLDYoTmuFKoW/NWKA9LiYvyLu/11/xS1CIbPWVEH6aMg7RZzVES9ffLUTZkq5aI3Wke8rJrsHEM05A0t30ueF4MJz+5n9lGik2hn5CskqBr+Ida2Ug5bkHTsa2WjLJ/afwwBLesRLtUa/GqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39850400004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(44832011)(4326008)(83380400001)(8936002)(8976002)(8676002)(31696002)(38100700002)(86362001)(41300700001)(2906002)(36756003)(5660300002)(66946007)(66476007)(66556008)(316002)(54906003)(2616005)(31686004)(6506007)(6512007)(6486002)(478600001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXFnN3lrcGxyeWRuVjNnTUVOMDA5S1ZucnZseHFGVlRoV05zRTdBQlFSZUha?=
 =?utf-8?B?MTdaWWJoVDNQaHZucmxpU1M3TEVXb3UySzJ2VUpHQm9hYzNhU0hqM1NyV0c4?=
 =?utf-8?B?ZzJDSVFaOGY4azJJTTAreHhHcEswM3pURVFqYVY3d3JGUTFwM2NMRVkwNFNC?=
 =?utf-8?B?aGRWUHNybHYySTBPWmhKRTN6M2pTMzNrZ0sxRE9KU1pmaFdnYnBQM1FVSjFW?=
 =?utf-8?B?NG9KRUxhNjRjR3hLdTZRWmt1M1Q3KyttZGhIcHRxMTJRcUxGdFVha0RnR3ZV?=
 =?utf-8?B?anpXUmNpZnY1V2s0SVNZQjE3a3dzNjd0L0tRNURUblJtNFk0bHhISjg3cWl2?=
 =?utf-8?B?b3hjR3NUcmpZdFZNM3NydFU1a2tJVG0rcVlxdG5FdWc4MmFrc2JGSW9KL1p4?=
 =?utf-8?B?VHNwOC9TZ3RJYXlqaTY2SU5CaXhMZGxueENGdlMwbC9uM2JiYnFJTWgzemo4?=
 =?utf-8?B?aWk3TG1HNnNuWlVnR3VLQllzYWk5VXZaMzhmVEMzL2dBZGJrbFZ4MHB2bHRy?=
 =?utf-8?B?RDlFNU5mSStkTUo4SUxUQVUweFAwYjRjbEZiNXNCckFUWW5hdUdLZS9ydjF2?=
 =?utf-8?B?UjZRdkRYR3JVcGc2OFBaZTZLN3haRzkwSjd4Vko5RHhEczhKdGc1UjNUeGs2?=
 =?utf-8?B?K3FMeUp5RS9LZHhOUmNiaG16aGF6eUVhaG8zalNCcmxOalMrOGUrMjB0L3pQ?=
 =?utf-8?B?dXpNS1RUMUE5U1JsblJvdTZBM0lKS0RpZnhBZlV6ekZMMW9tNUdmYjBtaW5C?=
 =?utf-8?B?MEpEQXE2QmtxVmRXeGtBUHhkVEQ3R0tQRDladmFFd2VxOUVaTUZnamVqd21R?=
 =?utf-8?B?NGd0MERNRE14VGxESnZ2U2VpM2pQbGhFVW52LzBjZXY3MEVFcXExNFlzWUw3?=
 =?utf-8?B?dHBhcy9GNHhJdVVNKytEMTZnU3JWYjRaalRKS09DcEc5em9Cbk1SSDhZTVpL?=
 =?utf-8?B?UHk1MzcvT0Y0MGo1MFRLUHRISUhPa0FXRThzYUtnNUYvY21jY2JvVHlvRERG?=
 =?utf-8?B?eDFrZjhoVDNuaHcrQ2ZsUm5zRUlkTmpvYUVPY245MDVwLzBEVzV1K1daNTJv?=
 =?utf-8?B?eVFlVjBCcElVd0NkRXkrN1RSc2UvWGo3TE9FTWxBQWxtS01oYVR5bmdMT1VS?=
 =?utf-8?B?TVZSalhuNWdjU1hHbE5iU1dwSjVPbTdTRTRFN2tMdWxNemxnd1dPQ3JSU1pt?=
 =?utf-8?B?QkhrenZwVmE5UDJQUjhJU08zQXJlV3JsOGwvTXBzd2hlWjlHVTJmaGJpQTdV?=
 =?utf-8?B?ckx1U2tFUURUQysxWndCYldvOWlTQmVvczRLMm8wUVFFYW5JOGIzRXRSZG9Z?=
 =?utf-8?B?ZXBtd3lPUWI1dThLL1Flb2lHZGhLbWNZNy8yK2tNeHYvVjFaVTJDS0dxZDNI?=
 =?utf-8?B?dnlsL01tQ2hyVmorRDFCYTVHNGE4QlhhVTdxc2RKSUpoTE5rVUNveGU0Zk9E?=
 =?utf-8?B?eHc1TFZYb3NjQWRzUDJvZlkzcEFrUHp3R1RKUzJxL0RYdUY5NHZ5NzN5enBM?=
 =?utf-8?B?WkFUcnVaMHhWTmF2YzNmSnRtSENSdnFpcXRFL3pKd1hpR2ZLNERuZzBiWUV0?=
 =?utf-8?B?Z0tlNU9ZYkJRdkhQbFBGVUw2M0VrejJtSU1HbW5RMjlSVUJ6UVp3VFlhRmZ3?=
 =?utf-8?B?aitVV3BMNnN0WE9pTkNJUXdJT0Q3c3lRNjFNaUVwYVBmRENZbmpsQ3Jmcm1z?=
 =?utf-8?B?UTBCQmthUTUraVVrU0NJRmtvVmFjSVZsUzk3aFFHem5XWURWZ1kxWCszclpC?=
 =?utf-8?B?NVZyY0ltVlZ2aHA4TVdtNjQ0dHNKVU9DSk9zRmZUcEMrV0xaYk5PaXdkYS9k?=
 =?utf-8?B?cmdMZ2p0K3RKS0cwUnZmWkRzOUwvZDhhRjlramk1dHhBWEp4SG1JK1JpTjBr?=
 =?utf-8?B?TnhGNTN2UjBSaVd3TUlWeE4vMHJCQ1poblRmVStTenlUaHFLMno2VXhreXVx?=
 =?utf-8?B?WkZXdkpSOGhYSTVOTWVYWHlvS2RMZUJubEVRUWNGRkRqaHd0UWszVUN6Nzd2?=
 =?utf-8?B?OC8rd3JXWkpWQmxCS2pxd1VrVFJpb3R1amdCOXAxRTVjZmh3bTQ4WE5ZNWtx?=
 =?utf-8?B?cWwrNC9kUXYrZXU0Ky8yNE5aVzNpS2JFWWg2cm1jcXljclUvRld0N3ZySkx2?=
 =?utf-8?B?TlZ5STRRQWtOQTNwWjZxeHFwa1FsYXRRNDMyQ3pNSTFiYjZYQVQwRUtSRHRh?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 678c4a6f-42f8-4eaa-e904-08dc1be9bf50
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 08:03:13.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fl6jZOFU0v8N523q/FCXm6H0oGOtp9oYxkIHaDIL+8gSTJ0SLXtIWvbZx3VdDuS+JE/damo4XTQ3YT4FcNGLbWZIqUskjJBwxkHGdxNr7YY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8055

On 23/01/2024 01.26, Kees Cook wrote:
> For instances where only the overflow needs to be checked (and the sum
> isn't used), provide the new helper add_would_overflow(), which is
> a wrapper for check_add_overflow().
> 
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/overflow.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 099f2e559aa8..ac088f73e0fd 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -108,6 +108,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  		__builtin_add_overflow(__filter_integral(a), b,		\
>  				       __filter_ptrint(d))))
>  
> +/**
> + * add_would_overflow() - Check if an addition would overflow
> + * @a: first addend
> + * @b: second addend
> + *
> + * Returns true if the sum would overflow.
> + *
> + * To keep a copy of the sum when the addition doesn't overflow, use
> + * check_add_overflow() instead.
> + */
> +#define add_would_overflow(a, b)			\
> +	__must_check_overflow(({			\
> +		size_t __result;			\
> +		check_add_overflow(a, b, &__result);\
> +	}))

Hm, I think this is a bit too ill-defined. Why is the target type
hard-coded as size_t? What if a and b are u64, and we're on a 32 bit
target? Then a+b might not overflow but this helper would claim it did.

But we also cannot just use typeof(a+b) instead of size_t, since that
breaks when a and b are narrower than int (adding two u16 never
overflows since they get promoted to int, but then if assigning the
result to a u16 one truncates...).

Perhaps the target type must be explicit? sum_fits_in_type(T, a, b) ?
IDK, I just don't think size_t is the right thing to use in something
that is otherwise supposed to be type-generic.

Rasmus


