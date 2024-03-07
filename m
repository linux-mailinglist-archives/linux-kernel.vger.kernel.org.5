Return-Path: <linux-kernel+bounces-95362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8BA874CBB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ADBC1F23A3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E35885650;
	Thu,  7 Mar 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwtrRaob"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD741CA84
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808773; cv=none; b=fWaAuuCAovgMzE81HP6Xeb2T+fEwsNGKkdusT/mO5l/1NghbryPELo6UQLSNJHW6bPROlUfwb2qs05XpyjDPmwfzn2WLoiOfNtda+jS8MdogGmy0Ay19BqsAMNx2IQEYAZRU3RWqC5OCvIEp2tQpLTqFuF3pj2afnIizBcx0U8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808773; c=relaxed/simple;
	bh=KyQZT+N0lpw9sllRL2VmoZ7Lg94efnQL0qwXQw1V8UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejSxKgQ0luMkGIaGZfleg1eH32qkZrohAiDegRHJXfBpDFJJ+/1uVCoOZVldUIylRgBX3PJ00RnXZreoDg1eHBDZkwGz4EsJBePiLjld0YK4ZmJox/wuh+yT99qKUfsMid4/ArAk5iVQjlyFwT7gCrPCVgpfaEGwvm6WLQpvYt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwtrRaob; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709808770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3dy8wv7a9A9uM5290tiYpXeb7+f++SDQOcbdFzYNCNg=;
	b=FwtrRaob5wRZ42Q+F3EZ4CAlUBXqg4H7ZEOm5tE4xxQPFIpVxRO/1nXta3smlordE925kq
	rrspXMuYH5+fuoeUhVxOCU+h3gtdFE+7LgtAWX5I2JKjKFUFrQLOmTHw4sBdJc3SzPa62b
	LYF0kA99JukbDiHNQ8XBsZ+3MlZdxQM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-gUswtewtPsiPw_vf7gVcdQ-1; Thu, 07 Mar 2024 05:52:49 -0500
X-MC-Unique: gUswtewtPsiPw_vf7gVcdQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33e6dab9d4cso63776f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 02:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709808768; x=1710413568;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dy8wv7a9A9uM5290tiYpXeb7+f++SDQOcbdFzYNCNg=;
        b=DhP6w5sLJUUEvDrF9RWm/n+N53YqR202mjim4Wc8kHTxkxffqsgeDcLkUemhSS5hFf
         7uV0YFI1SaHALceK4s56EC//ey/SUhpVcJw2ALJsUbRBJGY1tUnVSns38vTUEQMAgurC
         WLTLyVp5l6U73h0CcgkFX4xDiu9cx5SQVqBlIwECoLuqhQwH+GL9oNR+tm9HL9YuxG7n
         Z3y+SVPDbY+lbWiaAf+S/zbL1lEWaiXcDnkfrBtfEudkFAcLaYa3RqRbTaCG+n+BZNJ1
         AJkLYP8FAoFxOS954RT5n3mJuHaC1t+QzmBomf8KEJDRzTmzgJZ3amamWdElp+a9vb5Z
         ZUfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrvn+Eqlf1G5sVZIy+InnLbOQWJ3rJGLQ1A2JaQrn4n9SHY84X/XgPopoOI+h5HvcNiOLhhh/ZpEQN0fFSWC2P9HXMWJosC8mhP+nV
X-Gm-Message-State: AOJu0YwgTyQf1VAVjxHjpMfRlFa+ggVZnk2ZaaQNinHcSYcTkxs7EvZ2
	0P9mOburg56dcI0jWLaFr7kwVgpX6ljIRfWZ5b2z3bRZlDG+tW+lrQAil/0ClQe9126zWy3VLtb
	SPo8Yp7xY6xP/hc8zmSAtIGbGctDAqSAi+A1oOAF+FfVgU7k25RbJFZG6sNlM2Q==
X-Received: by 2002:a5d:4903:0:b0:33d:f7d2:50e6 with SMTP id x3-20020a5d4903000000b0033df7d250e6mr12544977wrq.31.1709808768226;
        Thu, 07 Mar 2024 02:52:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8jpQpyzCk68e5npxY8ThskMdDUP+uwyOpIhAbwXRW3LkHaLIkRCfpBui6nrNJaRJTQ9VF4Q==
X-Received: by 2002:a5d:4903:0:b0:33d:f7d2:50e6 with SMTP id x3-20020a5d4903000000b0033df7d250e6mr12544955wrq.31.1709808767798;
        Thu, 07 Mar 2024 02:52:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:6400:4867:4ed0:9726:a0c9? (p200300cbc74d640048674ed09726a0c9.dip0.t-ipconnect.de. [2003:cb:c74d:6400:4867:4ed0:9726:a0c9])
        by smtp.gmail.com with ESMTPSA id r12-20020adff10c000000b0033de2f2a88dsm20096450wro.103.2024.03.07.02.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:52:47 -0800 (PST)
Message-ID: <db29666a-32b8-4bf6-ab13-7de3b09b0da1@redhat.com>
Date: Thu, 7 Mar 2024 11:52:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] [RFC] pagemap.rst: Document write bit
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, upstream+pagemap@sigma-star.at,
 adobriyan@gmail.com, wangkefeng.wang@huawei.com, ryan.roberts@arm.com,
 hughd@google.com, peterx@redhat.com, avagin@google.com, lstoakes@gmail.com,
 vbabka@suse.cz, akpm@linux-foundation.org, usama.anjum@collabora.com,
 corbet@lwn.net
References: <20240306232339.29659-1-richard@nod.at>
 <20240306232339.29659-2-richard@nod.at>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240306232339.29659-2-richard@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.03.24 00:23, Richard Weinberger wrote:
> Bit 58 denotes that a PTE is writable.
> The main use case is detecting CoW mappings.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>   Documentation/admin-guide/mm/pagemap.rst | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> index f5f065c67615..81ffe3601b96 100644
> --- a/Documentation/admin-guide/mm/pagemap.rst
> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -21,7 +21,8 @@ There are four components to pagemap:
>       * Bit  56    page exclusively mapped (since 4.2)
>       * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
>         Documentation/admin-guide/mm/userfaultfd.rst)
> -    * Bits 58-60 zero
> +    * Bit  58    pte is writable (since 6.10)
> +    * Bits 59-60 zero
>       * Bit  61    page is file-page or shared-anon (since 3.5)
>       * Bit  62    page swapped
>       * Bit  63    page present
> @@ -37,6 +38,11 @@ There are four components to pagemap:
>      precisely which pages are mapped (or in swap) and comparing mapped
>      pages between processes.
>   
> +   Bit 58 is useful to detect CoW mappings; however, it does not indicate
> +   whether the page mapping is writable or not. If an anonymous mapping is
> +   writable but the write bit is not set, it means that the next write access
> +   will cause a page fault, and copy-on-write will happen.

That is not true.

-- 
Cheers,

David / dhildenb


