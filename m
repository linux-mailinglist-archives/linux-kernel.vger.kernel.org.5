Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74547B50DF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbjJBLJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjJBLJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94671BF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696244941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gtgcf+hFLMW3q0sfoiNdr0OOcMu3cpe/tcYTwFuRDbE=;
        b=fTUhKWz2Hf9CLaigVkLY3/m5cOpLVaQNOOAbqq0MwMqc5p865egc4a4m/aX3rII3/XuhWn
        KfWeN7sNYXiBb/ELhyXX3PxB9GBlqxf6JUIxsnSvzrF2YokPoe1FyhggSu1SxeXS8SLOSF
        Atwi0EfCbIOLVV3AAIGDoBiGPm2hXAw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-LgO5wN2SN22YmALPnfL5eQ-1; Mon, 02 Oct 2023 07:08:54 -0400
X-MC-Unique: LgO5wN2SN22YmALPnfL5eQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4055ce1e8c4so12653255e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 04:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696244923; x=1696849723;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gtgcf+hFLMW3q0sfoiNdr0OOcMu3cpe/tcYTwFuRDbE=;
        b=gKJPDQeZ/4BCUgf7LC5iTTvkP2XBUhWcj7DiKaQ+HlBim/sOlom8ic45xljySFvDGl
         vLiWzpvDEF9osfbJqrn21ZjwxJHsoXOJ4Ws0/GOh2B3R8tBZY6oXCWyXFC9gSln+cDq1
         8HQiKjLh4lPzMYMzMV7urakmlq2/Pre/rngC1dNKpjo3W1c/bRNJTRxiciiW+SQzpPhq
         xGprcWLrcUWE4YoykC+rwPBCdvZSmNjlKLwcxyT+Gj9U/VTzA9xxWo3EDRZP6NiRivq/
         mceHNcrIyGv5A9WbeJEmpcvKUa9BFbiHeFOqh7/59EdGsU8Iupo8cToEpcA6pxov7JKC
         kqHg==
X-Gm-Message-State: AOJu0Yytz1yckXD91dqP2HxH6mZ7lx/BEiXrPpqnlZRdOA+KNYHwscgA
        bQ6dyuki0dNAmWORm5BAkbmZHhh7BJIIjPPGcQT7seSxuS5+MHzqvEQKi4/dRWnAzkToRYRK/Sk
        k7NHcnrs7fWGNqvF+R5D17Sw/
X-Received: by 2002:a5d:6e53:0:b0:323:2c2b:baf0 with SMTP id j19-20020a5d6e53000000b003232c2bbaf0mr9621451wrz.15.1696244923523;
        Mon, 02 Oct 2023 04:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpSIH9QMEPaTkwE3Pxv/GuJdWgAsIruJxlHcaN0BwZf/RLEKQjG7gDlDA8fY8072jNa2UhZQ==
X-Received: by 2002:a5d:6e53:0:b0:323:2c2b:baf0 with SMTP id j19-20020a5d6e53000000b003232c2bbaf0mr9621435wrz.15.1696244923114;
        Mon, 02 Oct 2023 04:08:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id g16-20020adfa490000000b003232380ffd5sm19920471wrb.106.2023.10.02.04.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 04:08:42 -0700 (PDT)
Message-ID: <f29e6a5d-39db-8f11-2182-1f13c97882c9@redhat.com>
Date:   Mon, 2 Oct 2023 13:08:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] mm/gup: adapt get_user_page_vma_remote() to never
 return NULL
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <cover.1696174961.git.lstoakes@gmail.com>
 <b57d5f6618818f2f781a664039ace025c932074c.1696174961.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <b57d5f6618818f2f781a664039ace025c932074c.1696174961.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.23 18:00, Lorenzo Stoakes wrote:
> get_user_pages_remote() will never return 0 except in the case of
> FOLL_NOWAIT being specified, which we explicitly disallow.
> 
> This simplifies error handling for the caller and avoids the awkwardness of
> dealing with both errors and failing to pin. Failing to pin here is an
> error.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>   arch/arm64/kernel/mte.c |  4 ++--
>   include/linux/mm.h      | 16 +++++++++++++---
>   kernel/events/uprobes.c |  4 ++--
>   mm/memory.c             |  3 +--
>   4 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 4edecaac8f91..8878b392df58 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -411,8 +411,8 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
>   		struct page *page = get_user_page_vma_remote(mm, addr,
>   							     gup_flags, &vma);
>   
> -		if (IS_ERR_OR_NULL(page)) {
> -			err = page == NULL ? -EIO : PTR_ERR(page);
> +		if (IS_ERR(page)) {
> +			err = PTR_ERR(page);
>   			break;
>   		}
>   
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7b89f7bd420d..da9631683d38 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2425,6 +2425,7 @@ long pin_user_pages_remote(struct mm_struct *mm,
>   			   unsigned int gup_flags, struct page **pages,
>   			   int *locked);
>   
> +/* Either retrieve a single VMA and page, or an error. */
>   static inline struct page *get_user_page_vma_remote(struct mm_struct *mm,
>   						    unsigned long addr,
>   						    int gup_flags,
> @@ -2432,12 +2433,21 @@ static inline struct page *get_user_page_vma_remote(struct mm_struct *mm,
>   {
>   	struct page *page;
>   	struct vm_area_struct *vma;
> -	int got = get_user_pages_remote(mm, addr, 1, gup_flags, &page, NULL);
> +	int got;
> +
> +	if (unlikely(gup_flags & FOLL_NOWAIT))
> +		return ERR_PTR(-EINVAL);
> +

Do we have any callers or do we want to make that official (document it) 
and use WARN_ON_ONCE() instead?

> +	got = get_user_pages_remote(mm, addr, 1, gup_flags, &page, NULL);
>   
>   	if (got < 0)
>   		return ERR_PTR(got);
> -	if (got == 0)
> -		return NULL;
> +
> +	/*
> +	 * get_user_pages_remote() is guaranteed to not return 0 for
> +	 * non-FOLL_NOWAIT contexts, so this should never happen.
> +	 */
> +	VM_WARN_ON(got == 0);

You should probably just drop that. Not worth the comment + code and its 
better checked inside get_user_pages_remote().

Ideally, just document that behavior for get_user_pages_remote() "Will 
never return 0 without FOLL_NOWAIT."

-- 
Cheers,

David / dhildenb

