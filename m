Return-Path: <linux-kernel+bounces-46009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A3284392E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2BD1C26F78
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645A35D8F7;
	Wed, 31 Jan 2024 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="Blm6CHkC"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC13FB30;
	Wed, 31 Jan 2024 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690152; cv=fail; b=JX2AZBki/iveDumzTKV90Jzhrd/wYQW4HxvkXvPibouQLbO1jmXMfwHv/wpXr2F0g1phHOOVHaNrfMtAUV/Cd7njSlMzKLrGcBuBKiVV2S6WfWxlRHpgenwTyaOMVf3KQP+HJxXNuFNRZNG/ezRq7AMrxU3VE9YZvIVDy6h7eyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690152; c=relaxed/simple;
	bh=gBSUYlYRBocohGm90S8briSh5lw0N9+saQuXMlmWOaI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YIo4kNGTOxfCKnmm/6XD8Aj0Q1QtXoYzQV4v92ROiaDjx/Ay8vxrvtxiDJuuhnKYTVgDPGuJcN7j79g61Z9KIx7pj7Isx0PCr6fKN5ahRxureYQVFCMWYcb5fQXV59AB6uZkSh5Ed03FHJ0XK+ykCugFTGW8xHYPz1sKjuF8PuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=Blm6CHkC; arc=fail smtp.client-ip=40.107.249.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNodf/uIp+prUZhayxZi9BXLL51m16shEUDlShcTC2cUYU/D04sezk8iNLwjXRoeI69UfmOf/ZekJoxQV7khv0HvQY184mO2uqBv3raLH0b+XLRbpnepY7yMej5pCqqA/NMH2uv/uKbi/H6WIsT0cEmNjFkf7zKodBRLZa7WJCUv+I4DAmWlLB8e2DMGD3WX0G49xkkVZ6Mp56C/jgmZwINtJslhT+VhYB8A/8YOy/qYD7ToDSJla30qSOzfSM4YBetgbg86x8H6vNr10Zxl7JxbcTKqRCOmngxHbjivkqqRp9W9GloL8bVaoA4/OEiWJ1ow8JHIonPPwlMAZ3ACFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI9Ah7vbHOqY1FB7Dlua8gxMY7GnGlT+sl4rK3KDxi0=;
 b=LMli1Jq/lHXXKhbklNxS28G4PMNJWucT+MDGA8VYE1Nf2yrdS2UfbVAlNLalhsDpsn/hL0G5lnhsNlcZcq3XTKA9U987VlCY7L8/kqM7wGy72OCbBzX1ZIbLqP/eJVCiyvwDph/gXh20/h5dBkI/3Efd8NNw+ibfdgSHYTNVBh3XeWSNm/j/oIS0iiO83Ho2qUcnaSuzNz68cOTJW5iWWhMukg1ft11kd+L6nreQOQupfBwCFu8lB7Z2l71BYGJrjvdLw4dmXlg7/vzL5ZqoWnKs0b8Y0k1doxHOtZm194cmSRReQp+9DmBlX/admPkJR+2ISXAmTW+IdVwwGhr32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI9Ah7vbHOqY1FB7Dlua8gxMY7GnGlT+sl4rK3KDxi0=;
 b=Blm6CHkCqd/w/3d1rvBW39bDE8WQXxjN2I8WL0eGEQNgJ6vrtYFHAIFUbUeJtbnmA/3RzhNFjzfH8XIsfiifhZLgUwBmfehiGTKM023FiX5vFABq9z/vyqAYrIwKlaCy6uUcw+9kdum05W4ivC01prP+ujEERnEHNLcgxnzaJKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7105.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 08:35:38 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 08:35:38 +0000
Message-ID: <6d66deda-e09d-4899-b3a3-5137eeee449c@prevas.dk>
Date: Wed, 31 Jan 2024 09:35:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] overflow: Expand check_add_overflow() for pointer
 addition
Content-Language: en-US, da
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>, Miguel Ojeda <ojeda@kernel.org>,
 Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org
References: <20240130220218.it.154-kees@kernel.org>
 <20240130220614.1154497-2-keescook@chromium.org>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240130220614.1154497-2-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0001.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::10) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: d54d52fd-63e4-44d8-ba3f-08dc223799f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kEVpITvgxu899rdzn2/FWYHma2EkIHCBcExt+thlmGzddCoQwKZbqlHTupTiEn9PRwM6In+8RSalIG40DZMMvzQNBR7Ut+g2t4laEdOThtE9KN9WYdWoW2s7b4Wl1i4JdKcTzGOt6lG+x22zEde7jycEQ0B6UkBuCUY2nyyPqtTm5+FwH8wKcbsML6ci1LVkbVAoS+ckYwpSgvxlqvTKm/QAnrnhFOOHkkb9yQIFh6X9g9jwuPWsbmdiD8W+b41UoI4nxVBqc7/tJX3uDvTSU7LaZ27OFCxOj9ixG8fidl9We36l244jWIbMJZyFHC3mMFEMVimi6zaYxwfnZpaeNxFmlalZHusNlFUbyWgfshSPbrAz7eVwsI4GI6w4umUnUuUMPaPMaszIxqUhths3URlXMUR7BRtu0M0De7cD9PxWaLQ0bnIp8EDy2y3X/p/K83jHVgf57UUvw+s1SfezzWtRCHhWj4OkM+4mruGcvwbVBH4RITN+4xCkdCHKcLB3jl01UbqbYxZKxZ9mdkNG7T22VrpJfliSr6uYI0doMg8H1PZf0iWc0Rm4rWqse2XS3iIwqfqd6r///MznpuvoHTEs12S+u6DsO5o+an9BjN7mFFUubN9YCPUbJ87UF9BWUlGcgRc0MuzhAnXUFEnKSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(396003)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6486002)(31696002)(2906002)(5660300002)(44832011)(41300700001)(7416002)(38100700002)(6916009)(66946007)(36756003)(478600001)(86362001)(6506007)(6512007)(26005)(6666004)(2616005)(316002)(4326008)(8976002)(8936002)(83380400001)(8676002)(66556008)(66476007)(54906003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU5UcTcwUytqdmloa1NtNG5PanpVWjVvSDZGQ21LSWEvSkhIQzBORUlFNWoy?=
 =?utf-8?B?R0EyVEVQWGFSOEFxa3ovc25Kb3Yza1E1NnlMdXZwZm5EYjNKdkNRY2JMTnNq?=
 =?utf-8?B?VWhjbW5ZbGdWNGtJZ1o5cDhGTm1wZHc5OGFXeFBzeEV3Vk1sV3hnSVQxbDF2?=
 =?utf-8?B?ZlRCR21TQk1qWVZldWJqZkJvbzJuVFh4V2VPcXlKSStCc2FUQllSZFh1RHcw?=
 =?utf-8?B?NmxvMUhpNmxCMFVBWER5dGE1UmNFbVFHYkpCLzYxRFZRSFZyMEQ2OWRQOEt0?=
 =?utf-8?B?WGpLanFiMnZ0cE9yOTlRYS9lcnNneEtsQjlnUkE1MUo2UkFIajhwWmpEK2tn?=
 =?utf-8?B?ZlNZTXpRdklXNisrdUtZT283emZCYzZRMktzY01QM0xiRGxZNk9yVWp0dkFJ?=
 =?utf-8?B?cDFLNlNsVHFDQ1pKeE5UbmFEUDd3dGU0eWYxNzYrdW4wdW90Uzl0dUtLejd3?=
 =?utf-8?B?dFFQRS9sZndsYzV0bDI3cXlFeGpjTVhLay9DV3A3OFZ5NUNoUEdsRlg5dXNV?=
 =?utf-8?B?cVZaQlpCRjZpZHlBRTNUVkNPUTRhV1MwRmFoTzgxdHdBeUtuM05PRzE5ZjFL?=
 =?utf-8?B?RWJlcUk5emplcjg5bjh1SlhrQXRaeEU2ZHhCU1lvYm1aNGthbmg0SUM5R1Zp?=
 =?utf-8?B?VUlGYWFoOXZqOHk0Z2VjS1RZaVV1U2l0KzRlMlN0RFhqUW1SVUQ5aWh2U05F?=
 =?utf-8?B?RFFyMVJEZHBSanNJNEJDbnltdDZmRlp3TkNJUiszUlpXUysyN3Y1eWtLa1lF?=
 =?utf-8?B?UXd0YWVldHduTUh1NldMUHZ2WkR0UVplRmdNSDByS2I3U0w0THUwR3RZRXpC?=
 =?utf-8?B?WEt3ZFdGMlJFbXpyK0pLOHp2dlBSNGJRaDRIQTA2d3lWWkZyZ1N5UU1MK29n?=
 =?utf-8?B?b3dHc2ZWUHBueHJ3SzQwVzJaN05idTFPN1dndmZHY2RKVEZJQVEzQXpKd3p6?=
 =?utf-8?B?VzBGazJITFc1ZTVKMDI1RkJNNGNoajN2TXFrUHZGc2JBZU9MMjRKWjRVQThP?=
 =?utf-8?B?MU45TmJxb0JOYm5heWZZQjM5Rk9CZ21ra0pMb3U3V2Z4VlIzWVJ0SFY3NXFi?=
 =?utf-8?B?Z1VmWStvcVhZVTFCa2s0OVVNL0lJQlpjQ2VRb1U1eFZhV0RvZEdDSlpGNk8w?=
 =?utf-8?B?MU1CZm5ENkFieTQvSk80bXdtZjhVcm1WTXZrKzV3TEN1UjFhMmZuMXhEcGxq?=
 =?utf-8?B?R2hCSWtLTW9HL0JlV2crZEczbFJQeTNISDFoR2xnWkVLUTdrOFRSTzRSbi94?=
 =?utf-8?B?MVpna2Jqend6ZG5oM3N1dGhIYTRYUWVkK3BjWWVJSjJRRXh2R2FJZUpEN3RR?=
 =?utf-8?B?YmZPb01hYkR6am4zdTB2TGd0bHJEcEVWTUIyUyt4MzZXMFRaektzcWFjS25U?=
 =?utf-8?B?cGdFTWhoSDZsVlpZV09FQnVaQlJIYWJyVGFPSWZ0N2xidGs0WjRKYmtzd3lR?=
 =?utf-8?B?ZCs3MjRUeWNzaGp1emNZT2hKZ01FNy9lSVFTU3F6bjVna0xZaG8vSGRBMnRl?=
 =?utf-8?B?cVdLN3FNWjI0YWIvenJwNmxKTnE3QnhwR1U0bGVxTnpNOGRPZnpZS291UGZu?=
 =?utf-8?B?QXhIbm1ZTURTcitlVXVSVUVkczJ1ampESEpOSjZmY1hnS3J6clVxQnczK09T?=
 =?utf-8?B?SXFyS1FkcHN1cUZlWlR2L0FickNvcWFPSVg4SFAyNnA0UDdQRzJ0WHFPQTYv?=
 =?utf-8?B?aExVTXlxL1BtcUt4QjhKZnVhQ2ErRHhTQWg4T3cwanVTdTR4UmNocCtKdVBB?=
 =?utf-8?B?aGRVRmt1M3JTcVVZbzhSREszMWExdnFKTzdlVHU5aHdXcFM2Ni8zUHM2a3dF?=
 =?utf-8?B?VjdqU2kzZGdvTlh6ZzVMR1Bsa2h6N09hSGZ6cHdveTBxeFEwMjYvbCtZZmcr?=
 =?utf-8?B?VDkxdHYxY2JJOEF6YWxaQ1pWUXJVOXVXajYvYmROUkR6eTJ2N3puNGRaMlpa?=
 =?utf-8?B?WmN1QVlkZEV5NjFKa1YvUUgvcTc5VGxKMXhIcndLcDBjVWJkemtxcGN1N2VH?=
 =?utf-8?B?bWNvTm9uRkIrZU91UUdIUmhHbGw5MVVOckxIN3Q1QTFiYnEwWE83OTdXOXJ4?=
 =?utf-8?B?Ukhkc1FRZGtNU2g5TnNSa0g3VkZxa2YvUDB0cEtBdXcwcW1EVkVJL0V2c1FZ?=
 =?utf-8?B?T205c0FMTFpPMmRJSTlRUjNEMDJ0V2p1eXNvUllrQldnUWlLWmwvVWRMdTBY?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d54d52fd-63e4-44d8-ba3f-08dc223799f7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:35:38.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPA5z8UuSV3JcOGBhwgqsNdpYkIhzpCmaDpJF2z064tR68HDnwc09ksXYwbvQbmkiBZdQTH+XMlLMP6tCw5iiv/YfyC4OnC8TerRgi0IUWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7105

On 30/01/2024 23.06, Kees Cook wrote:
> The check_add_overflow() helper is mostly a wrapper around
> __builtin_add_overflow(), but GCC and Clang refuse to operate on pointer
> arguments that would normally be allowed if the addition were open-coded.
> 
> For example, we have many places where pointer overflow is tested:
> 
> 	struct foo *ptr;
> 	...
> 	/* Check for overflow */
> 	if (ptr + count < ptr) ...
> 
> And in order to avoid running into the overflow sanitizers in the
> future, we need to rewrite these "intended" overflow checks:
> 
> 	if (check_add_overflow(ptr, count, &result)) ...
> 
> Frustratingly the argument type validation for __builtin_add_overflow()
> is done before evaluating __builtin_choose_expr(), so for arguments to
> be valid simultaneously for sizeof(*p) (when p may not be a pointer),
> and __builtin_add_overflow(a, ...) (when a may be a pointer), we must
> introduce wrappers that always produce a specific type (but they are
> only used in the places where the bogus arguments will be ignored).
> 
> To test whether a variable is a pointer or not, introduce the __is_ptr()
> helper, which uses __builtin_classify_type() to find arrays and pointers
> (via the new __is_ptr_or_array() helper), and then decays arrays into
> pointers (via the new __decay() helper), to distinguish pointers from
> arrays.
> 
> Additionally update the unit tests to cover pointer addition.
> 
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: llvm@lists.linux.dev
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/compiler_types.h | 10 +++++
>  include/linux/overflow.h       | 44 ++++++++++++++++++-
>  lib/overflow_kunit.c           | 77 ++++++++++++++++++++++++++++++----
>  3 files changed, 120 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 6f1ca49306d2..d27b58fddfaa 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -375,6 +375,16 @@ struct ftrace_likely_data {
>  /* Are two types/vars the same type (ignoring qualifiers)? */
>  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>  
> +/* Is variable addressable? */
> +#define __is_ptr_or_array(p)	(__builtin_classify_type(p) == 5)

That magic constant is a bit ugly, but I don't think there's a better
way. However, a comment saying "pointer_type_class in gcc/typeclass.h in
gcc source code" or something like that might help. Do we know for sure
that clang uses the same value? I can't find it documented anywhere.

__check_ptr_add_overflow() - Calculate pointer addition with overflow
checking
> + * @a: pointer addend
> + * @b: numeric addend
> + * @d: pointer to store sum
> + *
> + * Returns 0 on success, 1 on wrap-around.
> + *
> + * Do not use this function directly, use check_add_overflow() instead.
> + *
> + * *@d holds the results of the attempted addition, which may wrap-around.
> + */
> +#define __check_ptr_add_overflow(a, b, d)		\
> +	({						\
> +		typeof(a) __a = (a);			\
> +		typeof(b) __b = (b);			\
> +		size_t __bytes;				\
> +		bool __overflow;			\
> +							\
> +		/* we want to perform the wrap-around, but retain the result */ \
> +		__overflow = __builtin_mul_overflow(sizeof(*(__a)), __b, &__bytes); \
> +		__builtin_add_overflow((unsigned long)(__a), __bytes, (unsigned long *)(d)) || \
> +		__overflow;				\
> +	})

So I've tried to wrap my head around all these layers of macros, and it
seems ok. However, here I'm a bit worried that there's no type checking
of the destination. In particular, the user could perhaps end up doing

  check_add_overflow(p, x, p)

which will go horribly wrong. Do we have any infrastructure for testing
"this should fail to compile"? It would be good to have, not just for
this, but in general for checking our sanity checks.

Another thing is that this will always fail with negative offsets (if b
has signed type and a negative value, the multiplication won't fit in an
unsigned type). I think __bytes should be ptrdiff_t.

Rasmus


