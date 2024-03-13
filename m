Return-Path: <linux-kernel+bounces-102574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AAD87B414
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECCB1F22D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70E45914E;
	Wed, 13 Mar 2024 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxPO5/3s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EB25823C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710367391; cv=none; b=ADiz6CRftCB60eS9IfDw+pJ9MFtk9lBYO7CvqiMx0gOm4QbCvj7yP4DKiRAvQ3s8ASkJd3N3ixa43ZP36w7l24ZwYWqqNPhYUSfKuyUmycEZttvC5XnW8bonZlyBv2sijHHrggTMvyaOhAQLT55jVpFPdD5CNbrDxI0xkQiNjNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710367391; c=relaxed/simple;
	bh=DnlhJqQ9/i52YDp542HabWDdzKKDSTG32LnufLRXQ7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZtsRvGfj5XvIbbax+4Fk/9+mTKBqJEUeZ9OjahJ2QUIV0fjYi3PRZcm65/VZV8AcidLWgQRwe1uskoCw8K4NrUP21MUqsrB6wmAkVmSrHaNLb9Dwu8MblngoTbc++fNjV/rTF/qyZKA56H/9eIUqa85a/XAgG1usx4AIyizAZWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxPO5/3s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710367388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6oqvVu+UL+HBieKDZrolGCCcogarIGUTX/10GrezDHM=;
	b=VxPO5/3s8pBbMIMGHwQaIP3utuO3UhSI1mWpMJDx8yKx4/rrU1YbfRN2gEWeMqGWe80hCX
	GzqELKpjD6DzKw6xXWsk2fNEgahoIDeZ72KmCPDxVB77UrUM7RSFbOTETtiPQjA+bPP5UY
	74PSaPfaiZUxl55Kkd/SkNXJs84Tk/8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-jSUMD3OEOKm-8f38mWrxPA-1; Wed, 13 Mar 2024 18:03:07 -0400
X-MC-Unique: jSUMD3OEOKm-8f38mWrxPA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4132a5b38adso2345705e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710367386; x=1710972186;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oqvVu+UL+HBieKDZrolGCCcogarIGUTX/10GrezDHM=;
        b=H8DPZRv02hRzxdSSpi4mcPjffJDk/w5IVwsWmlBA9JMWAKwhVJeLZFV96ZNy0PcN8w
         jpVsmZDTa8Ke+OhnjbdUuj0YrbpNTBUZr+WYLqS0Fd//HM3/EyI1eIef0JqqeLgBf8mT
         vVAtXPfH9koOeuxuBbBEQ+EeGuyueC0ZeofhIMopuPsiDlrU+yH9SiIdKX5vI2C5sBIN
         11Q68weqqgW+BFciVyLC0Yb22KO9G044TCgqJmd4g8hk+23l/IzBx+LhEA5Qn8gSp/NQ
         F73A19aYDSHg21PVTMXKdSIlxJbtXses0neZ95sDgGx5f12pMU7heCtoEYq24JjQburi
         8WYg==
X-Forwarded-Encrypted: i=1; AJvYcCU+jtDg9KI+yFMuzpj7vLY55rUOJW4KD0/qJcnrDbhvJRat+jBoHb/8OMNU13HFj5gJFKbNlMwSn4jOq7bS3xee46vlUKAsY0SWPHBo
X-Gm-Message-State: AOJu0Yw6W9iTIP27PkXDua+uKSO90D+rSaIgLlVCO5E9bbSz4Fk1gtdZ
	WL0pS9eICdurtTFFljc5olunmf2xuHn3bohGnoFbOzQH9rPB8/reikjdq+TlSyS2EXhrGtv0G6K
	4BoaGTsfoN9Tb4M6NPBsTt106uyegcKDVS//mCvDhK2QDgkByFyYEln6UGW++CQ==
X-Received: by 2002:a05:600c:4f8e:b0:412:f3af:c6c6 with SMTP id n14-20020a05600c4f8e00b00412f3afc6c6mr64924wmq.10.1710367385963;
        Wed, 13 Mar 2024 15:03:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGJr7nY+MrI4BsVfuIG9W9Xa8WiNurfhsZ1fk9O1VCmZJbq6bAjaDoMOZb1csrEDSOl4U+Tw==
X-Received: by 2002:a05:600c:4f8e:b0:412:f3af:c6c6 with SMTP id n14-20020a05600c4f8e00b00412f3afc6c6mr64913wmq.10.1710367385576;
        Wed, 13 Mar 2024 15:03:05 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23447.dip0.t-ipconnect.de. [79.242.52.71])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b00413e4ff2884sm3508154wmb.40.2024.03.13.15.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 15:03:05 -0700 (PDT)
Message-ID: <c04c81bc-dfc1-4dd6-972c-23c2eb8a5d0d@redhat.com>
Date: Wed, 13 Mar 2024 23:03:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory: Fix missing pte marker for !page on pte zaps
To: peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20240313213107.235067-1-peterx@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240313213107.235067-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.03.24 22:31, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Commit 0cf18e839f64 of large folio zap work broke uffd-wp.  Now mm's uffd
> unit test "wp-unpopulated" will trigger this WARN_ON_ONCE().

Good that I added the WARN_ON_ONCE() :)

> 
> The WARN_ON_ONCE() asserts that an VMA cannot be registered with
> userfaultfd-wp if it contains a !normal page, but it's actually possible.
> One example is an anonymous vma, register with uffd-wp, read anything will
> install a zero page.  Then when zap on it, this should trigger.

Are you sure? zap_install_uffd_wp_if_needed() contains right at the start:

	/* Zap on anonymous always means dropping everything */
	if (vma_is_anonymous(vma))
		return;

So if that's the case the unit test triggers, I'm confused.

> 
> What's more, removing that WARN_ON_ONCE may not be enough either, because
> we should also not rely on "whether it's a normal page" to decide whether
> pte marker is needed.  For example, one can register wr-protect over some
> DAX regions to track writes when UFFD_FEATURE_WP_ASYNC enabled, in which
> case it can have page==NULL for a devmap but we may want to keep the marker
> around.

I thought uffd-wp was limited to specific backends only. But looks like 
that changed with UFFD_FEATURE_WP_ASYNC, I guess?


Change itself looks, good. Not sure about the anon_vma example above.

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

> 
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: David Hildenbrand <david@redhat.com>
> Fixes: 0cf18e839f64 ("mm/memory: handle !page case in zap_present_pte() separately")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/memory.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index f2bc6dd15eb8..904f70b99498 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1536,7 +1536,9 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
>   		ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
>   		arch_check_zapped_pte(vma, ptent);
>   		tlb_remove_tlb_entry(tlb, pte, addr);
> -		VM_WARN_ON_ONCE(userfaultfd_wp(vma));
> +		if (userfaultfd_pte_wp(vma, ptent))
> +			zap_install_uffd_wp_if_needed(vma, addr, pte, 1,
> +						      details, ptent);
>   		ksm_might_unmap_zero_page(mm, ptent);
>   		return 1;
>   	}

-- 
Cheers,

David / dhildenb


