Return-Path: <linux-kernel+bounces-106109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB5987E947
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66C0282E97
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F349A381BB;
	Mon, 18 Mar 2024 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GM3cmAkU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAE7A2A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710764758; cv=none; b=HYmAOdCXeE1/qO6HE8sFA4kVg28ahcPrUcMauEZLyeidzBmmipG6jWQMjjMu9Iu4RVJDMd68nJf7q7hYFlIOACwMAdu7VpDjz5pgpIEWtWCffCOb1wT29o/TIrtGnFCTcbxMGm7w0XbKUZ0r7g1O+CXPaQh5tc2i6ytPbtl3/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710764758; c=relaxed/simple;
	bh=/DSWX15lCXFElbpGmFYVFF6Q90maj62kJ/F2dVQXvF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QEjWB7NXYVFhJY45aqgjlh044Wcj3AYZ/9Jt9KmSL1mbNbo7lJgEHw5j5pcGjN3usEPaWBZ7+CA5TDRbMwVgG2lPuwS65OQgNrj5Jxgboskz1DOfc94pgh4cNUn/FQMH6x/kgz/v32lLw4P20PHxNpuTXUtysi7xwvh7H1Xpn/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GM3cmAkU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710764755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SqvGVh65KqbKTetTMf6WrYl8K7KtLN0mdgSBJqowmoc=;
	b=GM3cmAkUnIzE40PsDTAI1Jr6XedRERxRXax9jcKV4vEqrTfSPtxLBtB8JRkAe+cXl1wbnN
	7z+frL45EK7UMNOg+XOU/evG8RNJuqS9hir8ysYaUl2wHbtV9poxvGXprXZOzcuHCIvHOP
	cxX7AZPdJ7dYuX0lm1/fLng+hPvCFEk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-qxpmUAg7Mo6bs5y1y_YBdw-1; Mon, 18 Mar 2024 08:25:53 -0400
X-MC-Unique: qxpmUAg7Mo6bs5y1y_YBdw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33e4397540bso2718631f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 05:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710764752; x=1711369552;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqvGVh65KqbKTetTMf6WrYl8K7KtLN0mdgSBJqowmoc=;
        b=awCfNwFNGQAPi29E7D8VlGYnIYAHIRwAw2VUWBSlO4LkZGKV9WNNvPxPZ/FZsVZJOa
         4kFxwCP+avftbgWkKT98WfyDWQr0c3SaOjN1EOFiCMaNJv0gtCrU06+BQp3xXep7JIkq
         69HQ15o7fBTdiYpsM+YT3IB2fEXlg/dw4url1q7/CZAT9iZic4r4hopqw+uLaU+rjhGU
         UAKKrFMPweWz4+iVwyhGvp7eRQMHlaDdrDiR8NQuqjYjJ9yiDg+BvQvkpTOQW5FigSFA
         o7BvbaNzM00uLqxGCZztipZ8syWR7qI+mE4Hq4QA4+D6aediGg/71CopB2AKGunfQaIt
         /PIA==
X-Forwarded-Encrypted: i=1; AJvYcCVkSSsv2WLOyuASgmhdTl33LlbLq/PqbsdK48q4fq9J35IjTuav3WI5ebjpz9Ckzj6xgmU+byVn3v7S0BqH1Vwc3giZ1xTmZkUc+Fv7
X-Gm-Message-State: AOJu0Ywmlmf58NMvOnOYiJG0+jBuw4jLOjR0cwU+mZX4guTnGH4NSBgA
	uFVUJ4jK6hYi2TKFZ5uhC2vPSkWSKdm8g6TXeP7DSVl1NgKfF5C+/xB4IY1AM9DNdX6yMJGplUu
	Dk5PFdAxz/RiIf60kBs3dNCpkdPWfZNemrL023DvfxUjpqwst2GzB3+06rHw5PqG4Xt9ocw==
X-Received: by 2002:adf:cd0c:0:b0:33e:c522:e3b9 with SMTP id w12-20020adfcd0c000000b0033ec522e3b9mr8748448wrm.36.1710764752677;
        Mon, 18 Mar 2024 05:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2Hx4zJB/q6S5B8pGBIOadGQ9g91TnCxrmkQyN4q9h6k7VBZxpM/MjeIOpkkHZ7VFYEHGlyg==
X-Received: by 2002:adf:cd0c:0:b0:33e:c522:e3b9 with SMTP id w12-20020adfcd0c000000b0033ec522e3b9mr8748435wrm.36.1710764752260;
        Mon, 18 Mar 2024 05:25:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:1f00:94ff:246b:30d0:686b? (p200300cbc7371f0094ff246b30d0686b.dip0.t-ipconnect.de. [2003:cb:c737:1f00:94ff:246b:30d0:686b])
        by smtp.gmail.com with ESMTPSA id n16-20020adffe10000000b0033de2f2a88dsm9657147wrr.103.2024.03.18.05.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 05:25:51 -0700 (PDT)
Message-ID: <7a0d7d0e-d241-4942-b6c1-e60d597b3dd6@redhat.com>
Date: Mon, 18 Mar 2024 13:25:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] mm/ksm: catch tail page abnormal in
 page_stable_node
Content-Language: en-US
To: alexs@kernel.org, kasong@tencent.com,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240318121443.3991104-1-alexs@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240318121443.3991104-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.03.24 13:14, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> commit 19138349ed59 ("mm/migrate: Add folio_migrate_flags()") change the
> meaning of func page_stable_node() to check the compound head for tail
> 'page' instead of tail page self.
> But seems both semantics are same at results, the func always return NULL
>   for tail page. So adding a bug monitor here in case of abnormal.
> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Chris Wright <chrisw@sous-sol.org>
> To: linux-kernel@vger.kernel.org
> To: linux-mm@kvack.org
> To: Andrew Morton <akpm@linux-foundation.org>
> ---
>   mm/ksm.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 8c001819cf10..3ff469961927 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1091,7 +1091,12 @@ static inline struct ksm_stable_node *folio_stable_node(struct folio *folio)
>   
>   static inline struct ksm_stable_node *page_stable_node(struct page *page)
>   {
> -	return folio_stable_node(page_folio(page));
> +	struct ksm_stable_node *node;
> +
> +	node = folio_stable_node(page_folio(page));
> +	VM_BUG_ON_PAGE(PageTail(page) && node, page);

I don't really understand why we would want this.

Only KSM folios can have a node in the stable tree. KSM folios cannot be 
large folios. At that is precisely what folio_stable_node() checks.

If we'd have a large folio identify as a KSM folio we'd be in much 
bigger trouble.


Besides, I'm sure you read "22) Do not crash the kernel" in 
Documentation/process/coding-style.rst

-- 
Cheers,

David / dhildenb


