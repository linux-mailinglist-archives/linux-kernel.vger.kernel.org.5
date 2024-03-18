Return-Path: <linux-kernel+bounces-106103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D0987E937
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A031F234BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B0F381BB;
	Mon, 18 Mar 2024 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOvNiscL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6A364A4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710764387; cv=none; b=jIMGTVd9X1sCNTuHq+rLWFnBqqAIFJStCQfr0qZZeuJ6C/yduOvyLgTKoLvf5aXHsc3eAChLu91a85gL1dcEXt1phRJHv9bDK1HcPQHj04tSoKYu4ruE5YVD8qLrq833dx43qKn3A6eMBLs0dI+TwIcJ1sHqbFhgVP2A38A6sTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710764387; c=relaxed/simple;
	bh=SfOzydn5WiIlkxoB11jIvKv/kj2NfAbiHa9cC3pAxgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NiljcPNpgDhVtBsKDKhGMfNBvW2fuDUGB5V3LXZ42TNGASixMZYwyfmIY+Qd24d7EhsOOt7/IqsRN9QAjUon9Xh9iML8Mc63Srk3Z519b6C/Ob3ADnsrsFc5HjvIaSjGp4aors3GVCAEYgNdrQuz66TH1xcGR2y/O0+Du5/LQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOvNiscL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710764384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Riwf3MWStmr2vSS3p/CTbOW0bR3Ycq544igOWwCzcqs=;
	b=YOvNiscLLbcqkk+CICXRDKZ59DW+HHv/uVFr7mAhXvtou8slkowjfFOb7vXL2R7S148VCQ
	40RGh4d0fOqcohRUMoe/Q9ydu9G0/yYT0FvOWKlJnhqomLxnjUCdVb/wnSoitQZoixZnKR
	ccCaTGWcvIgIjYxYvPszTK5Z1BQMaqQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-r1crWlCbOyqI-p6p_ArCZg-1; Mon, 18 Mar 2024 08:19:42 -0400
X-MC-Unique: r1crWlCbOyqI-p6p_ArCZg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-412c7ee0c97so20186955e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 05:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710764382; x=1711369182;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Riwf3MWStmr2vSS3p/CTbOW0bR3Ycq544igOWwCzcqs=;
        b=LmxIUgj8JM3Y5iiBvaULw8rON1XQB+zugLw7st+Ckc3aEg/FBqufFKUDwz+VGwdd/u
         YdSEJwLbWQtcqdP0qhwGc+OPG4RMav7e12nGJ0DNxF1SmIUUoCEXUj86TumsmgRNhs4l
         pyJJrEWSSbSFPC0FbYbj9a6Emfc4UXhR4avOEz/knkPdGWw0c1PNLWxeI1GROKNmTDip
         TwQ37k8vWGngbdPeYVIjQPP2/AjpKB58MAis78B6QF60p1U5QkxA7Gw8zAJhKRlMY05/
         twmjXi0tnLbthrGRGWRn6rIdeQYR61/jEOmpBAzoDhFxP4/8pOz7Y8xdDvh8o7r0cYxW
         s/qA==
X-Gm-Message-State: AOJu0YzuUA/LhRPIA4NoVcai/AT+1CifSk3JFhmfiqLMFvUJsyfwsv0y
	j6oK3wI9nvkx2zfm1dGDjHX4MJdaS9eWeFeENODrwtoSD1dEHUvJH0Umtl2unGDT7kp+OOQeOu1
	KLEhK2SEupKIRi28o8YWc8ErOG+7evabSZnuxug0svi6EfRmXn4XZDJ68IvRPCA==
X-Received: by 2002:a5d:4d05:0:b0:33e:7065:78f2 with SMTP id z5-20020a5d4d05000000b0033e706578f2mr8464007wrt.40.1710764381762;
        Mon, 18 Mar 2024 05:19:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSeaSc2V2KVoLf+J19hl3rtMu0eID5XzHNhylFk/KnsVV+Hk2Zwp7UYA2V6PwAImZsm8M9gw==
X-Received: by 2002:a5d:4d05:0:b0:33e:7065:78f2 with SMTP id z5-20020a5d4d05000000b0033e706578f2mr8463993wrt.40.1710764381281;
        Mon, 18 Mar 2024 05:19:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:1f00:94ff:246b:30d0:686b? (p200300cbc7371f0094ff246b30d0686b.dip0.t-ipconnect.de. [2003:cb:c737:1f00:94ff:246b:30d0:686b])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d4389000000b0033e75e5f280sm9719732wrq.113.2024.03.18.05.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 05:19:40 -0700 (PDT)
Message-ID: <c9341492-cf7b-4c4d-8b6b-2b92b4ecbe74@redhat.com>
Date: Mon, 18 Mar 2024 13:19:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Remove guard around pgd_offset_k() macro
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <59d3f47d5615d18cca1986f269be2fcb3df34556.1710589838.git.christophe.leroy@csgroup.eu>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <59d3f47d5615d18cca1986f269be2fcb3df34556.1710589838.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.03.24 12:52, Christophe Leroy wrote:
> The last architecture redefining pgd_offset_k() was IA64 and it was
> removed by commit cf8e8658100d ("arch: Remove Itanium (IA-64)
> architecture")
> 
> There is no need anymore to guard generic version of pgd_offset_k()
> with #ifndef pgd_offset_k
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   include/linux/pgtable.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 85fc7554cd52..bd9c7180718c 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -149,9 +149,7 @@ static inline pgd_t *pgd_offset_pgd(pgd_t *pgd, unsigned long address)
>    * a shortcut which implies the use of the kernel's pgd, instead
>    * of a process's
>    */
> -#ifndef pgd_offset_k
>   #define pgd_offset_k(address)		pgd_offset(&init_mm, (address))
> -#endif
>   
>   /*
>    * In many cases it is known that a virtual address is mapped at PMD or PTE

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


