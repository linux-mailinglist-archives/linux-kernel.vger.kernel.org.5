Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE2879C804
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjILHTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjILHT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:19:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56D53E73
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694503114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+OodWnETEUgz5EFst9JGpxDf54xHXqhw04bLaPZH7zA=;
        b=CfJufZ0+jnXUOpY16coEfCS98QFO6LyZiJN9ZQMEe4HxCEEczHeF8QRji3hYNbeDMVubLi
        gHqDdWxKeZudQiHsUd87wPqpjxK1HDtphR7kFywyJrwBO45UzoqF2qdoKhL9doH/MrBHQR
        2veEcmGi/Pw8q2Awo+KXC6QZ231lHVg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-mW0EfqbfNmiL24lUeYQgWA-1; Tue, 12 Sep 2023 03:18:33 -0400
X-MC-Unique: mW0EfqbfNmiL24lUeYQgWA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fef3606d8cso42482785e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694503112; x=1695107912;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OodWnETEUgz5EFst9JGpxDf54xHXqhw04bLaPZH7zA=;
        b=ur+KoiYhLzOoX/0YJ9f/Tg26LkGHwTxbL9+azjYYTunByuk9dbhUg8wZSYpagKaZkb
         NvveKyuj2JfDF3962Akt0eBqI7f8FH8ehXAkTh0eztfjJVXtK9cIZkTyJYvKIgD6sbJT
         iOTSzcf3aTV+n7RXpcsSuLkW4Yd+OLEUiOFavN4v4We9/VjH1p0NC4piPUauUpTwZbTN
         F19Um0645XCFFDnim8nXjhlYVtdpPjFKdDmVarNjTY8rCAZdEHRj9/R6xTVPYz0n8Z4O
         7mkCQMvAPGK4G4k4fdKxbS2uZC4KwWTshRynaiF4mieXYLGQBEngpYvECkora92g1KFn
         3kFg==
X-Gm-Message-State: AOJu0YyUxF8tPxJw63iguh2n8K6g75OWkFm7ex6osk2WaHSwUvYkMer3
        AiwEMKnmrBN5pHfs8qIfTf5R0hCj9p8TzkMsyThjQVo3VrbWc/708+Wm3GLRFPU4xrGXoe61Q3O
        pELksRVaKXsY3GelyhyycVt+c
X-Received: by 2002:a7b:c853:0:b0:401:db82:3edf with SMTP id c19-20020a7bc853000000b00401db823edfmr9908950wml.39.1694503112136;
        Tue, 12 Sep 2023 00:18:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQr59YxQoahIdt2pGpOn3n/3cyfcIn7qrajZoDiICpNrmoOnS/ynh5Tia67CgdCYHJ/KD0yA==
X-Received: by 2002:a7b:c853:0:b0:401:db82:3edf with SMTP id c19-20020a7bc853000000b00401db823edfmr9908928wml.39.1694503111718;
        Tue, 12 Sep 2023 00:18:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:d600:c705:bc25:17b2:71c9? (p200300cbc74fd600c705bc2517b271c9.dip0.t-ipconnect.de. [2003:cb:c74f:d600:c705:bc25:17b2:71c9])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fed630f560sm12028942wmj.36.2023.09.12.00.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:18:31 -0700 (PDT)
Message-ID: <7f4881dc-885a-a8f5-47a5-0dd23886a416@redhat.com>
Date:   Tue, 12 Sep 2023 09:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 1/2] efi/unaccepted: Do not let /proc/vmcore try to
 access unaccepted memory
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org
References: <20230911112114.91323-1-adrian.hunter@intel.com>
 <20230911112114.91323-2-adrian.hunter@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230911112114.91323-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.23 13:21, Adrian Hunter wrote:
> Support for unaccepted memory was added recently, refer commit dcdfdd40fa82
> ("mm: Add support for unaccepted memory"), whereby a virtual machine may
> need to accept memory before it can be used.
> 
> Do not let /proc/vmcore try to access unaccepted memory because it can
> cause the guest to fail.
> 
> For /proc/vmcore, which is read-only, this means a read or mmap of
> unaccepted memory will return zeros.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

[...]

> +static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
> +{
> +	phys_addr_t paddr = pfn << PAGE_SHIFT;
> +
> +	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
> +}
> +
>   #endif /* _LINUX_MM_H */

As stated, if the relevant table is not already properly populated with 
information about unaccepted memory by the first kernel, this probably 
logically belongs into Kirills series.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

