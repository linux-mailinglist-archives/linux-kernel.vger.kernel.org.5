Return-Path: <linux-kernel+bounces-135858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B4889CC1F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9641F235FE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E771422B9;
	Mon,  8 Apr 2024 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTJ2KYAH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D301448D4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602750; cv=none; b=eLt+YmvF/tuh10gBYW6wwAtcHJcg4XfDMGqvRVqNABBqqEK8iGnQbx7xSkcB+Y/ymQTrsEfU3JeUoS41QbitIxzrAHoAu1aUm+TJvI8I5nPfwIac0U8n8L//FWXfsI2T4YGR6wxjOmHaaCL0aN2mejI25UVWIoHCIe8fSWQfSPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602750; c=relaxed/simple;
	bh=+BUWPN1WpCcgVrSl6neuRs2Z7L+KLJo4aD7sdqxPa7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+X2NN8+MCGHQNQ0IMffzGbzfTUUV22k8TiH63e0GaiObPew1LajFmM0NNqlTU2IkFoUVrc5YrV3liDLMW3r+wz87igt48na2cW2EcO1WnWZZ1YPvm0FepkTcjDVTovtauI5PrBn1tEC3zLTku0z551WZgv4MsFm4VVQquU4m7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTJ2KYAH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712602747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HLlehq8eX/AKOXAxO8vMhUMQdq5MPavS8gzQo/pUnfo=;
	b=XTJ2KYAH/KD2XojbD69Dz1WcsTh4oLwurIxkcUhP4+inXX1mM4D6/1GQAm0Hm/ZC+HPmGs
	jMLjRd06Ke5nrbXPiOBqtrs+hFy6gxz+wIS1v0ePNhWXe2+Yyfa8fpRYO8r2FmsCLMxC8w
	gRSv72u9U6+cb2wulOpF3amb2A69zM0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-9sTVbxlSPA--QIrBh_3UjQ-1; Mon, 08 Apr 2024 14:59:05 -0400
X-MC-Unique: 9sTVbxlSPA--QIrBh_3UjQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-416542ed388so7908295e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 11:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712602745; x=1713207545;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLlehq8eX/AKOXAxO8vMhUMQdq5MPavS8gzQo/pUnfo=;
        b=SDry31LzSxroupzZA8S11lt5i+SDJiHwCvGy/gc449wMDrhibP5ckEjvUy2E+I/coQ
         uHbveaoAZ0dYj/T157nMyByXyndeTF3l/gVG9IKestKgJsxKW9tNvm2QohPwD4yM2MtK
         dCE72vDD0AnoclNhTXNQk+5aze6h/FFNyzPK7F3cKaONLtf4c96RnpEtbeAQLHzK00pc
         dFRe5ZmJdIFsBnpYZWUQ9ZaXMItghTgtbdT24H++QyANKEvpjCpwbWndexsOV2eO6/Mn
         PF27yi5WJNbpNF6Di1r0Ytdwr2dfi4W1Q3hWlMQ9tBVqnYMkHJPXek54gknYLqUCRkOx
         blmw==
X-Forwarded-Encrypted: i=1; AJvYcCXEkKAHauCnFnQEg8IIoEAFszvpgRPct2rpFWh1kaKqKmjgmmd5xHpjfXspDQaF5ZGum7iMLFYiyP5K38bBZ4it/mbhpEH5iZD01/xz
X-Gm-Message-State: AOJu0YywmYQ0T4TO7JTruU3VYKi3ikKEGcMvhrE7cTF8K5u3WndakPzi
	3DOkW8DJVT1tlb5tGUXT4BD6QoqukEL1WHqdUduAQRgfmElme0hSgct7glwtsdvBexFFWnf629h
	KvQvaAJB7F6ob9ErxLd+/EJCm0PP6l/oAkBxLuqrV1X0FS6DVnkQ2JHAd2U4ZUA==
X-Received: by 2002:a05:600c:45c3:b0:416:2a3e:27dc with SMTP id s3-20020a05600c45c300b004162a3e27dcmr7453633wmo.24.1712602744809;
        Mon, 08 Apr 2024 11:59:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRYt3+DHWy3JZbAs7+BGVGjRqPd5InKGOGWir9Cs/yPprNrKaLB4w7nELpCUe5Z0E+WYVrDQ==
X-Received: by 2002:a05:600c:45c3:b0:416:2a3e:27dc with SMTP id s3-20020a05600c45c300b004162a3e27dcmr7453621wmo.24.1712602744440;
        Mon, 08 Apr 2024 11:59:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:1300:9860:66a2:fe4d:c379? (p200300cbc7181300986066a2fe4dc379.dip0.t-ipconnect.de. [2003:cb:c718:1300:9860:66a2:fe4d:c379])
        by smtp.gmail.com with ESMTPSA id i6-20020adffc06000000b003455e5d2569sm5999681wrr.0.2024.04.08.11.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 11:59:04 -0700 (PDT)
Message-ID: <151c1981-f2ed-43fd-bec3-5ed63efe1c13@redhat.com>
Date: Mon, 8 Apr 2024 20:59:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/userfaultfd: Allow hugetlb change protection upon
 poison entry
To: peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 linux-stable <stable@vger.kernel.org>,
 syzbot+b07c8ac8eee3d4d8440f@syzkaller.appspotmail.com
References: <20240405231920.1772199-1-peterx@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240405231920.1772199-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.04.24 01:19, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> After UFFDIO_POISON, there can be two kinds of hugetlb pte markers, either
> the POISON one or UFFD_WP one.
> 
> Allow change protection to run on a poisoned marker just like !hugetlb
> cases, ignoring the marker irrelevant of the permission.
> 
> Here the two bits are mutual exclusive. For example, when install a
> poisoned entry it must not be UFFD_WP already (by checking pte_none()
> before such install).  And it also means if UFFD_WP is set there must have
> no POISON bit set.  It makes sense because UFFD_WP is a bit to reflect
> permission, and permissions do not apply if the pte is poisoned and
> destined to sigbus.
> 
> So here we simply check uffd_wp bit set first, do nothing otherwise.
> 
> Attach the Fixes to UFFDIO_POISON work, as before that it should not be
> possible to have poison entry for hugetlb (e.g., hugetlb doesn't do swap,
> so no chance of swapin errors).
> 
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-stable <stable@vger.kernel.org> # 6.6+
> Link: https://lore.kernel.org/r/000000000000920d5e0615602dd1@google.com
> Reported-by: syzbot+b07c8ac8eee3d4d8440f@syzkaller.appspotmail.com
> Fixes: fc71884a5f59 ("mm: userfaultfd: add new UFFDIO_POISON ioctl")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/hugetlb.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8267e221ca5d..ba7162441adf 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6960,9 +6960,13 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>   			if (!pte_same(pte, newpte))
>   				set_huge_pte_at(mm, address, ptep, newpte, psize);
>   		} else if (unlikely(is_pte_marker(pte))) {
> -			/* No other markers apply for now. */
> -			WARN_ON_ONCE(!pte_marker_uffd_wp(pte));
> -			if (uffd_wp_resolve)
> +			/*
> +			 * Do nothing on a poison marker; page is
> +			 * corrupted, permissons do not apply.  Here
> +			 * pte_marker_uffd_wp()==true implies !poison
> +			 * because they're mutual exclusive.
> +			 */
> +			if (pte_marker_uffd_wp(pte) && uffd_wp_resolve)
>   				/* Safe to modify directly (non-present->none). */
>   				huge_pte_clear(mm, address, ptep, psize);
>   		} else if (!huge_pte_none(pte)) {

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


