Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E590780540C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345287AbjLEMZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345248AbjLEMZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:25:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DBBC6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701779158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=ETXmoryrBgHKIsSSGX8IoKw3azWp+g8uDvWiDYs9lkk=;
        b=GhOjQ98kB7hBHNzwO+mgue1v9IjBNyVVovIuxXJgQ8HIxSl20b3E1wdfCWV0heNnlhLQt3
        YbAvCYDtGo8u2oPOjHjA85P1wl9uKr9YtGbw0Iv4iQfzRxF8MHHe4R1J0oh5H22uA8rcFr
        Uv0RSxhOZqsSX3Zoo8egcaiLjc4PLGQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-Ld6zYdQoNrKt3hPb_nG2tg-1; Tue, 05 Dec 2023 07:25:56 -0500
X-MC-Unique: Ld6zYdQoNrKt3hPb_nG2tg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b349b9711so48327925e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701779155; x=1702383955;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETXmoryrBgHKIsSSGX8IoKw3azWp+g8uDvWiDYs9lkk=;
        b=lU0csZRux2c5C1bnPIld34NAeISHQWLDiou1AhLgMI/0GxkMo0td+zFgS91RgVQ+dJ
         6+xHW7AmwolOe2XmdagqqCaZRXONxSzQfdhLiosU0sX4ViLHli7h5Ps/gKl9ky1E7r1+
         5UU7VWZajcgMncYYPDq0Fu7WK1yfUlX+1+Tf0naL4rfMRQjEJTvatWnO8EXvIfn4K8iC
         JGlsapzlq6ynEfzCYFhBUCQtu6rbyHiQLEr3xKrd5MZHhvM77NciFow+CCx1tqcj7kmK
         BMikNWFVU/cbRfpCyBmshBbZX0pgcHurvCD9kzeEcgbGSjPbHjGVD4iILG+LVYQnwWNd
         CGhA==
X-Gm-Message-State: AOJu0Yzf6Fp6toNfzWhBQBoYiVGjtgBkHEOcJn9YXtCW3Y5dOvGzRNvJ
        F/vuEYHtG0xndoi59uVEmHtpbRqO4Zc13te4muZXWSAxjT6rhN7NlXcml3+FgVF9enJZlnEXFCo
        W8i69wVuYVwOFjLYlNdxb+fzf
X-Received: by 2002:a05:600c:1508:b0:40b:5e59:cc9d with SMTP id b8-20020a05600c150800b0040b5e59cc9dmr473865wmg.126.1701779155530;
        Tue, 05 Dec 2023 04:25:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpBBmzrQ2OLh+b6PaLOLKXclFjQkPBqzBmCdPKmDXrgPQNI6bI9uP1/eNijm3QbDMZq07qQg==
X-Received: by 2002:a05:600c:1508:b0:40b:5e59:cc9d with SMTP id b8-20020a05600c150800b0040b5e59cc9dmr473856wmg.126.1701779155106;
        Tue, 05 Dec 2023 04:25:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:300:1ec7:2962:8889:ef6? (p200300cbc72f03001ec7296288890ef6.dip0.t-ipconnect.de. [2003:cb:c72f:300:1ec7:2962:8889:ef6])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d53ca000000b0033330ace23asm12044230wrw.73.2023.12.05.04.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 04:25:54 -0800 (PST)
Message-ID: <c87a8988-b8e1-40bd-94f0-903a06ab6232@redhat.com>
Date:   Tue, 5 Dec 2023 13:25:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/39] mm/rmap: convert folio_add_file_rmap_range()
 into folio_add_file_rmap_[pte|ptes|pmd]()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-8-david@redhat.com>
 <3e748c18-f489-4ec4-ae71-5a5b18a4b161@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3e748c18-f489-4ec4-ae71-5a5b18a4b161@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.23 13:04, Ryan Roberts wrote:
> On 04/12/2023 14:21, David Hildenbrand wrote:
>> Let's get rid of the compound parameter and instead define implicitly
>> which mappings we're adding. That is more future proof, easier to read
>> and harder to mess up.
>>
>> Use an enum to express the granularity internally. Make the compiler
>> always special-case on the granularity by using __always_inline.
>>
>> Add plenty of sanity checks with CONFIG_DEBUG_VM. Replace the
>> folio_test_pmd_mappable() check by a config check in the caller and
>> sanity checks. Convert the single user of folio_add_file_rmap_range().
>>
>> This function design can later easily be extended to PUDs and to batch
>> PMDs. Note that for now we don't support anything bigger than
>> PMD-sized folios (as we cleanly separated hugetlb handling). Sanity checks
> 
> Is that definitely true? Don't we support PUD-mapping file-backed DAX memory?

They are not handled via the rmap. Otherwise, all the PMD accounting 
(e.g., FilePmdMapped) in RMAP code would already be wrong for them.

And it's easy to verify by looking at zap_huge_pud() that doesn't call 
any rmap code.

[...]

>> +
>> +static inline void __folio_rmap_sanity_checks(struct folio *folio,
>> +		struct page *page, unsigned int nr_pages, enum rmap_mode mode)
>> +{
>> +	/* hugetlb folios are handled separately. */
>> +	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>> +	VM_WARN_ON_FOLIO(folio_test_large(folio) &&
>> +			 !folio_test_large_rmappable(folio), folio);
>> +
>> +	VM_WARN_ON_ONCE(!nr_pages || nr_pages > folio_nr_pages(folio));
> 
> nit: I don't think you technically need the second half of this - its covered by
> the test below...

My thinking was that if nr_pages would be "-1", one could end up with 
weird wraparounds.

But yeah, I thought about this as well and might just remove it.

> 
>> +	VM_WARN_ON_FOLIO(page_folio(page) != folio, folio);
>> +	VM_WARN_ON_FOLIO(page_folio(page + nr_pages - 1) != folio, folio);
> 
> ...this one.
> 

Thanks!

-- 
Cheers,

David / dhildenb

