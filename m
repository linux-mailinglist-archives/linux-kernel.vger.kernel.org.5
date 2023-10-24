Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0081B7D56F0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbjJXPwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjJXPwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12A883
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698162712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=ykD8SVnjwSHLbUyOrE2Qp1dyEU2wHlpnbGAShg0wi9s=;
        b=awGxIITTsEGGRRwvM5x7G/0IWVImopIZbzK2otyTmPkodJTXT6bJb4K8BegueYkL97siUF
        8/7GGRu9D8ITePoELmcfk4RvMicau2yPgJY9OcGCMI61vZz5VIaCoDIzFzP8e8RVSA08oz
        5jWjFsvjOTsZlw0sT3Sf0jBUEO5Fu88=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-oJ_nPyEEO9WJ0VQ9UWzbDw-1; Tue, 24 Oct 2023 11:51:50 -0400
X-MC-Unique: oJ_nPyEEO9WJ0VQ9UWzbDw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-402cd372b8bso32259485e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698162709; x=1698767509;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykD8SVnjwSHLbUyOrE2Qp1dyEU2wHlpnbGAShg0wi9s=;
        b=hOln9JFMTNkexHSozmSMYVpsHTUhY6/DkyHUmXM8pRxr0aMop+mRIa/QDt+YYcF2NT
         6kf6RWnEy2mq8rsOk7a17KU/36M62F5W+n4uUtYFDGA4j3AsKETPuuR+hk9ntlGA3lDV
         bTSwreeP9xbtpQUjUMZJC+VG2k+TlcjHXjwe7jpa8ljU7ABCYny1jk1bHFuA/LwsB6zK
         Ghj2vEzyLBwSx3KkOXnJh/Dkf9KuxItVbypgcn5hilkiCkxd1Ft7fgsNjV9/bbRztnI2
         DPJP+t4aJ621Q2Xk5Fo+EKew38h5DnouBj1pfGuITmxN2sHiwQzbjtYAGARqE8XrDbw7
         sYLQ==
X-Gm-Message-State: AOJu0YxdjYBeDm448xyXDxttKjrL+3h0M6tT55eMb3ixawbBH+b0M8A1
        cN1S77KiVMtYwuN4t6nJxPTS9s3hhmT0R34jF7actuTfqer/APCJ+RMjlQygPjgi2Cr8cnWvm/Q
        og4fkPOplwmlKmUyFY9GJ+bMZETUFkzv6
X-Received: by 2002:a5d:474d:0:b0:32d:9cdd:a23 with SMTP id o13-20020a5d474d000000b0032d9cdd0a23mr9326428wrs.25.1698162709506;
        Tue, 24 Oct 2023 08:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpzLiuCO5jFAQCzmyeo0LDOpKqpB030TvSa3f0NBwyekBXoaN9gHhDxSI4oT75Hf+qndNY7g==
X-Received: by 2002:a5d:474d:0:b0:32d:9cdd:a23 with SMTP id o13-20020a5d474d000000b0032d9cdd0a23mr9326414wrs.25.1698162709062;
        Tue, 24 Oct 2023 08:51:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:ac00:f27c:e128:f876:f17e? (p200300cbc741ac00f27ce128f876f17e.dip0.t-ipconnect.de. [2003:cb:c741:ac00:f27c:e128:f876:f17e])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d4291000000b0032da87e32e2sm10249162wrq.4.2023.10.24.08.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 08:51:48 -0700 (PDT)
Message-ID: <a1357e75-986a-4e00-a987-9d8c767a42a5@redhat.com>
Date:   Tue, 24 Oct 2023 17:51:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: vm_flags including VM_EXEC can exit timely
Content-Language: en-US
To:     Zhiguo Jiang <justinjiang@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20231024144913.421-1-justinjiang@vivo.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231024144913.421-1-justinjiang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.10.23 16:49, Zhiguo Jiang wrote:
> When pra->vm_flags include VM_EXEC flag and folio is file detected in
> folio_referenced_one(), the folio referenced traversal process can be
> exited timely to reduce the detecting folio referenced time.
> 

Can you further elaborate what the logic behind that is?

Why can we stop here if we're dealing with a pagecache folio in an 
executable VMA?

> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> ---
>   mm/rmap.c | 2 ++
>   1 file changed, 2 insertions(+)
>   mode change 100644 => 100755 mm/rmap.c
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 7a27a2b41802..932f3b7e8521
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -884,6 +884,8 @@ static bool folio_referenced_one(struct folio *folio,
>   	if (referenced) {
>   		pra->referenced++;
>   		pra->vm_flags |= vma->vm_flags & ~VM_LOCKED;
> +		if ((pra->vm_flags | VM_EXEC) && folio_is_file_lru(folio))
> +			return false;
>   	}
>   
>   	if (!pra->mapcount)

-- 
Cheers,

David / dhildenb

