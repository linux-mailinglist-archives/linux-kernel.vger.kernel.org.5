Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A4176E9BC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbjHCNNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbjHCNM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000D22137
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691068124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mWJpN+HPR5XbieLWrsaf/wc4LSMCej6l0uwrl1WLeOM=;
        b=EsqkwByxsUb5HesDmcRAgI8hUZ0Po/EmNR7nO6p82/Ztlt3JNi4VfDsFyguyT/f+GmkD/D
        UWH2XhcR1JhseFF1mdQF3Tbikhd4Ah/e4FIJlZF9c4KgdcIvnQXiVQpPoBXzxB1XLS34jz
        LOzEoVVlDxDWNPVoScOyk7qpn3wd/60=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-1T5IaR0UNuGzW8FcNDoC-Q-1; Thu, 03 Aug 2023 09:08:43 -0400
X-MC-Unique: 1T5IaR0UNuGzW8FcNDoC-Q-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fe32caefd8so910026e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691068122; x=1691672922;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWJpN+HPR5XbieLWrsaf/wc4LSMCej6l0uwrl1WLeOM=;
        b=jWuKHK6lvDknb8fcwkgASEO5xnqOHQnABY5ErURLdVfG+wMA//UO6VawZYL9mCQhY2
         RYTJ20Ri+M3EcFgpvdNYP4xTjX0X7VYbvhwTP4kGD2rfLgioL4ur+Rjd/0na/mFI4SpL
         Tx8ViakL/P1vhkdQpIujJ621chu5GulW9sTTgS9OhlbMSFZmWu2Ku+c+pIO4XISvAzFH
         03fuLXwgUWGRKLt8LLMeN9yujzxFnmUGew/bUH0KLTLRlJfWDmBpOTv9BRMA6M+Z1qeS
         hJMw9NlQor/hRwuTGYczsyymhuQ7ylxWDDjnAPZlDodSnZhFQ9Tb1CVpkVdbpWLPceD6
         gssg==
X-Gm-Message-State: ABy/qLZmcoZDfrn4ZYG+COQLkPyRRyHyMahikFzOM+JyiOhvuaGGJdVo
        bPmuWAO47SRicVgyYch0KGj8n0+vsKn15N8qIijniKbWD+9c0COoWtdrdJJR+QnoLBWhqyt60JU
        UPAX0f7WVCGGHaLr8VSth8G0n
X-Received: by 2002:a19:6755:0:b0:4fd:f827:30b with SMTP id e21-20020a196755000000b004fdf827030bmr7342436lfj.52.1691068122190;
        Thu, 03 Aug 2023 06:08:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGoiryrzC2ismKdxunCzFCJbRLM7B25sgKcD3Fj2CBZ+zQ84LB/yLC18zq1S8f/iT9Vy5HxEg==
X-Received: by 2002:a19:6755:0:b0:4fd:f827:30b with SMTP id e21-20020a196755000000b004fdf827030bmr7342419lfj.52.1691068121772;
        Thu, 03 Aug 2023 06:08:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:9a00:a5f5:5315:b9fa:64df? (p200300cbc7189a00a5f55315b9fa64df.dip0.t-ipconnect.de. [2003:cb:c718:9a00:a5f5:5315:b9fa:64df])
        by smtp.gmail.com with ESMTPSA id l7-20020a1c7907000000b003fbb5506e54sm4194333wme.29.2023.08.03.06.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:08:41 -0700 (PDT)
Message-ID: <d964ffc8-2f8d-d576-a2db-27caac92b017@redhat.com>
Date:   Thu, 3 Aug 2023 15:08:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/page_alloc: remove unneeded variable base
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230803114934.693989-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230803114934.693989-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.23 13:49, Miaohe Lin wrote:
> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> THP-sized allocations"), local variable base is just as same as order.
> So remove it. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_alloc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d7a357cb21ee..96b7c1a7d1f2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -538,8 +538,6 @@ static void bad_page(struct page *page, const char *reason)
>   
>   static inline unsigned int order_to_pindex(int migratetype, int order)
>   {
> -	int base = order;
> -
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   	if (order > PAGE_ALLOC_COSTLY_ORDER) {
>   		VM_BUG_ON(order != pageblock_order);
> @@ -549,7 +547,7 @@ static inline unsigned int order_to_pindex(int migratetype, int order)
>   	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
>   #endif
>   
> -	return (MIGRATE_PCPTYPES * base) + migratetype;
> +	return (MIGRATE_PCPTYPES * order) + migratetype;
>   }
>   
>   static inline int pindex_to_order(unsigned int pindex)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

