Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2428E79EB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241201AbjIMOfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjIMOe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9968B90
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694615652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EmuGLD5luQvJ6ql8baS4uOR3VUqVjxIpyPp1zFnXnLU=;
        b=HMqfwshJ6qJrZzCzIFzVb0vqB/iOfdGZrt1xL46ua5X3ECtyQ5Lr9k73VIdTUzvj1f3owV
        jZ54X7Kg/w799AJ3kYSAKStlV+zx1kF3P7vmmaoprM6SOAhhV1sUQLS6rLN2Hdt4qhN6wq
        DdIiCoZgY40rYK0DY4eahWZUv8thpr4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-LmmY_tHvOJKaSWdSPHGUyg-1; Wed, 13 Sep 2023 10:34:09 -0400
X-MC-Unique: LmmY_tHvOJKaSWdSPHGUyg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31ad77537ebso4548385f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694615648; x=1695220448;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EmuGLD5luQvJ6ql8baS4uOR3VUqVjxIpyPp1zFnXnLU=;
        b=I7q58FoJIit2UjULOY5iXxyeZIQJFPrMeV91bzIibyLj6ub1r2gdJDzssnWLCXjqF1
         ++TuK2EPoVe5pplueeaDr6tLbgca8Q1dfj3QVY+aXL+lJSLcFvvHdwmPn9WEGoZubYOs
         SUE9yFdDDiirFTlRWICm0JFaWrP2pJxXtGvbm3ImZGFPif03IAaUmB2MPjlyEDzzQVha
         m+71Iqfy8Sycr6yDEWxILgOC3Na0eDghmkXJEXPaPI39CQM8EAdTgQbQx+d74/WnGIbP
         PCYwevsKzWOgwgZCoZDaTh+LC79WviOkUG40O2cK+VDTFfJ+n9GWq6+Q/5rSJsMsK/EX
         auIA==
X-Gm-Message-State: AOJu0Ywt8cWHfkFg1TzmAr72y7d6HvGz+j6xXGNv0uPcvgKR3B/xUHj5
        hHj98AI1mt0IGHyqU766gqsr0fUYQejFmlsLeN8F2rIT7hT8y4JcHEQj9LVGMhL78AdGrBHOsjw
        1zLyPfMPCiltsMjaOiWp8Wq49
X-Received: by 2002:adf:e350:0:b0:31a:d7ce:927a with SMTP id n16-20020adfe350000000b0031ad7ce927amr2155939wrj.3.1694615648307;
        Wed, 13 Sep 2023 07:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxXsLR5zjRy/DLOO1GBaPn0ZcQQNCwDb5j2gSJukItrCH3FTJ6g1iQgv/XHrp9fSH7duWpvw==
X-Received: by 2002:adf:e350:0:b0:31a:d7ce:927a with SMTP id n16-20020adfe350000000b0031ad7ce927amr2155922wrj.3.1694615647937;
        Wed, 13 Sep 2023 07:34:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:ff00:f8af:dffd:bbb7:6c76? (p200300cbc70bff00f8afdffdbbb76c76.dip0.t-ipconnect.de. [2003:cb:c70b:ff00:f8af:dffd:bbb7:6c76])
        by smtp.gmail.com with ESMTPSA id d16-20020adff2d0000000b0031981c500aasm15563508wrp.25.2023.09.13.07.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 07:34:07 -0700 (PDT)
Message-ID: <3142b596-43d9-7c6d-cdcc-59137d0f2ca1@redhat.com>
Date:   Wed, 13 Sep 2023 16:34:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/6] mm/rmap: move SetPageAnonExclusive out of
 __page_set_anon_rmap()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
References: <20230913125113.313322-1-david@redhat.com>
 <20230913125113.313322-3-david@redhat.com>
 <ZQHH6ZC9aHQaqlNJ@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZQHH6ZC9aHQaqlNJ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.23 16:32, Matthew Wilcox wrote:
> On Wed, Sep 13, 2023 at 02:51:09PM +0200, David Hildenbrand wrote:
>> @@ -1246,11 +1241,13 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>>   
>>   	if (likely(!folio_test_ksm(folio))) {
>>   		if (first)
>> -			__page_set_anon_rmap(folio, page, vma, address,
>> -					     !!(flags & RMAP_EXCLUSIVE));
>> +			__folio_set_anon(folio, vma, address,
>> +					 !!(flags & RMAP_EXCLUSIVE));
>>   		else
>>   			__page_check_anon_rmap(folio, page, vma, address);
>>   	}
>> +	if (flags & RMAP_EXCLUSIVE)
>> +		SetPageAnonExclusive(page);
> 
> Won't we end up setting AnonExclusive on ksm pages, or do we make sure
> to never pass RMAP_EXCLUSIVE for ksm pages?

Not if there is a bug and someone passes RMAP_EXCLUSIVE for these. :)

Fortunately, we do have

VM_BUG_ON_PGFLAGS(!PageAnon(page) || PageKsm(page), page);

in SetPageAnonExclusive() to catch such bugs.

> 
> Maybe better to move these last two lines inside the previous test,
> just to avoid the question.

That could end up hiding another BUG, so I'd rather let 
SetPageAnonExclusive() catch it.

-- 
Cheers,

David / dhildenb

