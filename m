Return-Path: <linux-kernel+bounces-160501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF8F8B3E50
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0465B2828D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9531D16C86A;
	Fri, 26 Apr 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ba8QAvfH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCAE15D5CF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152897; cv=none; b=LyySBf8W8h/P0gb/zGibfG4Rszbo6t4l9qGGJCnaxtyXaStPaWnexBahZPXpdt3oR254SfKEyI14ZkQh2bClSDgw5/VTQu/JQPza9wydCynv5sysfEh/tOmkx1pfPs6nMM5rlXPu354DbPPHRhrc8sTWfZaZHoSXvVPGKmHVlt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152897; c=relaxed/simple;
	bh=G6fU4p7MmHp+BZqePlpVo6NEff/Gx53BaSPVAzfQ+zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3Lz1LQ3/ZJxTAVOGTTE5AE+c6GeqYlO5cwVmarhJEybhXe++zxuTiF9jtfNu8vS7DmE0BPxzL7ahJYwdvjfLtXz4JefZILoG8Niaj4iYhptrmclkM9nThgq+AKA8OsaFWDf00m8S+RjZGDNHyzXIqCTmLskaxOH446BG4BuXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ba8QAvfH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714152895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h07zmxvfavPZw7SWNp+BhnP1ppcXFwoYMZ75eLulG0o=;
	b=ba8QAvfHl47TAokUXWDUOpg0Od3Axm3keHm5YrNuwCdQGELMdbPyGjeSF9kzPYQzc2dShm
	lBYosVhNhh7jDxx/js2v0ywc5ZcFklMfj9axVcjdqqN308SgR0NasUW6DgPYnMJyAlAB8b
	s2I4zQvsPmdAHHDfaTMN063OQqgPiXw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-Zb4jBnFoOi67jmFvDLjBSw-1; Fri, 26 Apr 2024 13:34:53 -0400
X-MC-Unique: Zb4jBnFoOi67jmFvDLjBSw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2dbef696ebeso18962271fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152892; x=1714757692;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h07zmxvfavPZw7SWNp+BhnP1ppcXFwoYMZ75eLulG0o=;
        b=vaZGXS6m1fQw8luuF4SWJoukZjSd1YB2qIvfDcr7oHbaiuKJ84ahenkL+FHkIT/cVS
         5EFWQNG9+2+U+Eat0c7tEDzV06PAziDGMRPQdtdco3smUuqNOgbEdPZwxY+DH3iGEM/S
         VA2o9ktTrM3MQhAB7YOePydCCLVWYLt0b1qBaz8giBd2WOScZao2idQ0hUgOpLYNTD+C
         zalM5GAfmA8lZuccqGlsETCscBDW195hsg+ByMSeAiuDw+wvhjIylKWy/eJ/Ev1HDTCt
         gsQDOrKfGSs9/fqygGf8ZqunnpeFSsXhGPGi28VbnnTgf6HfDqo5NGl+idWqfRuFe8DI
         1qPw==
X-Forwarded-Encrypted: i=1; AJvYcCX1OIdx28iZ/pmy3nfyakPfUFxmMIhEnKZdUKs4lATa2obOgpbPkTYjoLzsC5cxwy3CDG1u6J1SOFIiJ3stAxlevDlkUwDoMY/kURxS
X-Gm-Message-State: AOJu0Yy+x98Fq7AkJ9Z+K2NpdXzgj02D2h3BfZi7rPq2lFc99R9DF1w2
	CxfuxoNWWE9RQ/apHGxVby2et5ghPxlKROpqhOUpd0YVp0sp2ZLw/6huk+/bJqWYa9sElVdTap9
	M0dEbeoKRkyHXIppXN0RcJTh/taWgdj+TmDr15X53o+KY3gj51P2J8q3UD77z6A==
X-Received: by 2002:a2e:b610:0:b0:2da:16fd:5c95 with SMTP id r16-20020a2eb610000000b002da16fd5c95mr2347347ljn.4.1714152892329;
        Fri, 26 Apr 2024 10:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhDyYpArxHAjiA3YcLvbBCnWS5N7dxMPNjW8vQFzvLBWB9YJVoDIhFNX1bfa4MvC4IvocaAg==
X-Received: by 2002:a2e:b610:0:b0:2da:16fd:5c95 with SMTP id r16-20020a2eb610000000b002da16fd5c95mr2347329ljn.4.1714152891887;
        Fri, 26 Apr 2024 10:34:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:6100:20f2:6848:5b74:ca82? (p200300cbc726610020f268485b74ca82.dip0.t-ipconnect.de. [2003:cb:c726:6100:20f2:6848:5b74:ca82])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b00418a6d62ad0sm35470236wmq.34.2024.04.26.10.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 10:34:51 -0700 (PDT)
Message-ID: <a9fd2bc7-a9b4-4e60-b178-f60aa5c2a6de@redhat.com>
Date: Fri, 26 Apr 2024 19:34:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: Assert the mmap_lock is held in
 __anon_vma_prepare()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Suren Baghdasaryan <surenb@google.com>, Peter Xu <peterx@redhat.com>
References: <20240426144506.1290619-1-willy@infradead.org>
 <20240426144506.1290619-2-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240426144506.1290619-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.04.24 16:45, Matthew Wilcox (Oracle) wrote:
> Convert the comment into an assertion.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/rmap.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2608c40dffad..619d4d65d99b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -182,8 +182,6 @@ static void anon_vma_chain_link(struct vm_area_struct *vma,
>    * for the new allocation. At the same time, we do not want
>    * to do any locking for the common case of already having
>    * an anon_vma.
> - *
> - * This must be called with the mmap_lock held for reading.
>    */
>   int __anon_vma_prepare(struct vm_area_struct *vma)
>   {
> @@ -191,6 +189,7 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
>   	struct anon_vma *anon_vma, *allocated;
>   	struct anon_vma_chain *avc;
>   
> +	mmap_assert_locked(mm);
>   	might_sleep();
>   
>   	avc = anon_vma_chain_alloc(GFP_KERNEL);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


