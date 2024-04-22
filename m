Return-Path: <linux-kernel+bounces-153613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 640C98AD061
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8825F1C2286A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878D1152530;
	Mon, 22 Apr 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVnVALzZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B0152516
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798806; cv=none; b=bI200EMkzQRSPJyWmDcpDtd25wyVf8N1HO8WxK4UN6ewn4zK5I1VgC/5oFFdssm78oVMw5xt3Cmtu3WGefPULCi4N1GnQ+UVYQB2yOQ7NQSfDpATIcF5nhl9/An+L6KKmpK/TVd8VAlxcucS8G6XxJ8z02QJ32sd28N08Ylnzm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798806; c=relaxed/simple;
	bh=9BoJubQ8F3eknto6RlGvOtYlxcacVB0SGhhWSau56Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENDa8gEnpomaGV6be1SvCYUMP/wd51ez02i1l6QhN4GYf0S3OYFALQUxVbGpPaStowF+pRv7ja8oeDQBVI4aZwb9BSvfbkjBV0Bop3x/2xuurZ4KDxJGH0hmzjLQ8odRYqRE1UHEsvnvtBf13uClE2guWP9XguCXPScZTvrefKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVnVALzZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713798804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XggFGBgLkmBxMCKcF+mikPzmX9ukzyj9RvHvAHhy1Mc=;
	b=XVnVALzZIx6+JnkwRTAsXDZ6fyDWCN5golY2I9GFmzL42tN6JzbmObVOq0W/9KlpYvER6j
	Owwy6odZDB0Y6u3JHxlQQMAfrl1S9PRG9GWCELQyEXfyenpznAppJ2s2GYnZ/pA6jMh2XV
	excZ50yOpmkwIf1/AKNHUdoThtpWvmE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653--C-XnLqmP2uqX_nHzmetnw-1; Mon, 22 Apr 2024 11:13:22 -0400
X-MC-Unique: -C-XnLqmP2uqX_nHzmetnw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4169d69ce6bso21401195e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713798801; x=1714403601;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XggFGBgLkmBxMCKcF+mikPzmX9ukzyj9RvHvAHhy1Mc=;
        b=V74Zik5/S+L3AZ3Tkd1hDbCp/lhxaSTQvmhpSxg1+B3A0lGDAtriJKa09GaNfqeXnm
         DwqO07bOknXvrYR9udAPjKl2/nRMccD9kLHdOUExHiFpJlDmXltJBY/GLyG1XeIxQRUA
         pIlO4jDjupV/L3/MD55XjWZ2+aq0mIKQeKeL2ioJyOsgCQXJX0FQq0mM+pJgAKzPJNUU
         GYW4zuU/W1rtb2eMNbgdAe4Vn6S8u7stAACBwEAJNIrMpDoOFOgfy/YDXZiahuqsoiQX
         36dDUrUzL7qNKM5JDJTYGyoaPlPGq9VX7UEscsE63wNm/pUFVijKE978esG1F+jJAG+K
         aUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX8DREAHPsxSNXKDVfywcIA0TTfmyP4UeOqWJbmbHv28Ar1PGHvbS8gVlVMHdf2pGmNOtqzO2gAMP7/N+kVbM6DmNpgTfBHW22d/Us
X-Gm-Message-State: AOJu0YzAk3ioLKNnYLV9CI9hRGfUlxx0DAMN4M6Ps8EgfOv3+YnrCKoe
	xTRe+CUN5N+k9ggEFLTnfYY4i7lUWmmxBUB/sncjgx7bEH7/XSCXaXlz7J4N5ZCZ7u+I52xLili
	O/CYHH3d424M03QjSoAL4/P7l1HQftVFJt3+fxfTJfj/xStZhmEnFBg1EWQqirg==
X-Received: by 2002:a05:600c:4e4d:b0:41a:7553:81fb with SMTP id e13-20020a05600c4e4d00b0041a755381fbmr1139798wmq.40.1713798800912;
        Mon, 22 Apr 2024 08:13:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdxzGTLDC9x5rcgtjXwI/A0eNiI8nBUO7Ud4wOjoBerNcw5crG9mEY3bGSCDZW7F7QdfX4tA==
X-Received: by 2002:a05:600c:4e4d:b0:41a:7553:81fb with SMTP id e13-20020a05600c4e4d00b0041a755381fbmr1139774wmq.40.1713798800426;
        Mon, 22 Apr 2024 08:13:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:600:d2fb:3a8a:9944:7910? (p200300cbc7390600d2fb3a8a99447910.dip0.t-ipconnect.de. [2003:cb:c739:600:d2fb:3a8a:9944:7910])
        by smtp.gmail.com with ESMTPSA id n33-20020a05600c502100b0041a652a501fsm3150991wmr.13.2024.04.22.08.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 08:13:20 -0700 (PDT)
Message-ID: <5d0dd592-3dd6-45ce-ab2a-9e154d36a111@redhat.com>
Date: Mon, 22 Apr 2024 17:13:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Update shuffle documentation to match its current
 state
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Tejun Heo <tj@kernel.org>,
 Wei Yang <richard.weiyang@linux.alibaba.com>, Michal Hocko
 <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Minchan Kim <minchan@kernel.org>, Huang Ying <ying.huang@intel.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel-dev@igalia.com
References: <20240422142007.1062231-1-mcanal@igalia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240422142007.1062231-1-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.04.24 16:18, Maíra Canal wrote:
> Commit 839195352d82 ("mm/shuffle: remove dynamic reconfiguration")
> removed the dynamic reconfiguration capabilities from the shuffle page
> allocator. This means that, now, we don't have any perspective of an
> "autodetection of memory-side-cache" that triggers the enablement of the
> shuffle page allocator.

IIRC (it's been a while), we never had that autodetection upstream; we 
only had the code in place that would never get called. 839195352d82 
removed that (dead) code.

> 
> Therefore, let the documentation reflect that the only way to enable
> the shuffle page allocator is by setting `page_alloc.shuffle=1`.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 10 ++++------
>   mm/Kconfig                                      |  7 +++----
>   2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 902ecd92a29f..924bb8ddd8a8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4170,13 +4170,11 @@
>   
>   	page_alloc.shuffle=
>   			[KNL] Boolean flag to control whether the page allocator
> -			should randomize its free lists. The randomization may
> -			be automatically enabled if the kernel detects it is
> -			running on a platform with a direct-mapped memory-side
> -			cache, and this parameter can be used to
> -			override/disable that behavior. The state of the flag
> -			can be read from sysfs at:
> +			should randomize its free lists. This parameter can be
> +			used to enable/disable page randomization. The state of
> +			the flag can be read from sysfs at:
>   			/sys/module/page_alloc/parameters/shuffle.
> +			This parameter is only available if CONFIG_SHUFFLE_PAGE_ALLOCATOR=y.
>   
>   	page_owner=	[KNL,EARLY] Boot-time page_owner enabling option.
>   			Storage of the information about who allocated
> diff --git a/mm/Kconfig b/mm/Kconfig
> index b1448aa81e15..f30a18a0e37d 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -333,10 +333,9 @@ config SHUFFLE_PAGE_ALLOCATOR
>   
>   	  While the randomization improves cache utilization it may
>   	  negatively impact workloads on platforms without a cache. For
> -	  this reason, by default, the randomization is enabled only
> -	  after runtime detection of a direct-mapped memory-side-cache.
> -	  Otherwise, the randomization may be force enabled with the
> -	  'page_alloc.shuffle' kernel command line parameter.
> +	  this reason, by default, the randomization is not enabled even
> +	  if SHUFFLE_PAGE_ALLOCATOR=y. The randomization may be force enabled
> +	  with the 'page_alloc.shuffle' kernel command line parameter.
>   
>   	  Say Y if unsure.
>   
Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


