Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA0A7563B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjGQNCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjGQNC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFD7170B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689598889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9n0zHXcSDacvhFMCDGyf2nvIVwtaHD3xGEh2ddwFlZ8=;
        b=isO9kKKuVdgS+PmLj8kn8t+lQR7dqNevD0B9BdECl5igBoDfzKNj9wwLZo/mWUC8V8uAtl
        wmCimWYP+zUrdfpIoFtuU3g7G7ShllK2T2ON3jbN9vGLl/j1rXUqesPke13nC47unIrf09
        qvtmVsg0PKqRf8sCh5hOa/wI1cACIyU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-fRqbMDdLNiWAM80_NHTsCA-1; Mon, 17 Jul 2023 09:01:27 -0400
X-MC-Unique: fRqbMDdLNiWAM80_NHTsCA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fb40ec952bso23052875e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689598886; x=1692190886;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9n0zHXcSDacvhFMCDGyf2nvIVwtaHD3xGEh2ddwFlZ8=;
        b=BakFr4v0AuyGVkn4AEK0E4HnbelFXzlUjqqN53u8VV4hd/nd+Hco/e8ORZ3uWRjXHR
         zQ1CYBxvfX2zWkh21x66gdrlKo9ENQfzEiINORN0gjJHHkNX0uVpi84ou1xJDHbx+MGt
         c4feFOwaRh9JxjHkitBHLxEj5qzXCJnRe68VTS36UreKRZCivIIRYS5tPkGObCei1JoO
         a5za9Wn0Fu7dHasI2iazcJ7Q3WezMtmiIX4g3B+ptyJuXiMdrVMkZ9+xz2kbrRqiAqM/
         RwhU92Tg6IkC7uKqCOOs76eGOFEhaNcoZgVwI4IMDr1S0UrD0i4EpWDrYozW3/9mFnIn
         6ZxQ==
X-Gm-Message-State: ABy/qLbr/zmP84NzA/R6shlbhDafSygPtmMEQzQGaPUjYN4d19c9UW3D
        crqvUwqWmDutUFBIWnX2CZV4Hm5N2HvUSM8+UYh1bpUiEbwHSzZIK8tUBPE/WlcUviUAWQU+LN9
        L1qaYgoh/PBw+c3j/xexoyJFX
X-Received: by 2002:a5d:5045:0:b0:314:10d8:b483 with SMTP id h5-20020a5d5045000000b0031410d8b483mr9678915wrt.64.1689598886552;
        Mon, 17 Jul 2023 06:01:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE9rIUmQGqf7bxO4VT/69gTxxlwrzU6+KE5VRwg9EdtWBnPKwpFjgu5dBwr/K3plrWNFF8nrA==
X-Received: by 2002:a5d:5045:0:b0:314:10d8:b483 with SMTP id h5-20020a5d5045000000b0031410d8b483mr9678874wrt.64.1689598885978;
        Mon, 17 Jul 2023 06:01:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id x14-20020a5d490e000000b0031423a8f4f7sm19139030wrq.56.2023.07.17.06.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 06:01:25 -0700 (PDT)
Message-ID: <d36af03f-851d-5420-cc63-2a01fb13cbb1@redhat.com>
Date:   Mon, 17 Jul 2023 15:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/4] mm: Default implementation of
 arch_wants_pte_order()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <20230714161733.4144503-2-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230714161733.4144503-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.23 18:17, Ryan Roberts wrote:
> arch_wants_pte_order() can be overridden by the arch to return the
> preferred folio order for pte-mapped memory. This is useful as some
> architectures (e.g. arm64) can coalesce TLB entries when the physical
> memory is suitably contiguous.
> 
> The first user for this hint will be FLEXIBLE_THP, which aims to
> allocate large folios for anonymous memory to reduce page faults and
> other per-page operation costs.
> 
> Here we add the default implementation of the function, used when the
> architecture does not define it, which returns -1, implying that the HW
> has no preference. In this case, mm will choose it's own default order.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   include/linux/pgtable.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 5063b482e34f..2a1d83775837 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
>   }
>   #endif
>   
> +#ifndef arch_wants_pte_order
> +/*
> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
> + * to be at least order-2. Negative value implies that the HW has no preference
> + * and mm will choose it's own default order.
> + */
> +static inline int arch_wants_pte_order(void)
> +{
> +	return -1;
> +}
> +#endif
> +
>   #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>   static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>   				       unsigned long address,

What is the reason to have this into a separate patch? That should 
simply be squashed into the actual user -- patch #3.

-- 
Cheers,

David / dhildenb

