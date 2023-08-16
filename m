Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515E177E936
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbjHPTAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345704AbjHPTAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1742715
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692212377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dv0WkZdGSj5KsM+cXSukrTh8TZi7xGS5tVs/0ZiXInY=;
        b=K0Jkir52IHk49K90xE/3s1o1Ec5ryfQC2AUrI615/mDFbMoI3gJbXeWJRIdIwtNUz2fTuL
        wAFiIdkHtAbX9EfnXyvFgHsqhaU8/Q/PbN63gggi1vo1U3OKn6cKBwL3HpH76Zd7TqNmaE
        8RNvZeRKh6UsuwJhs0po7I/hJGkWRkM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-61qgwo7jNE-Lx8cv8zAK6Q-1; Wed, 16 Aug 2023 14:59:35 -0400
X-MC-Unique: 61qgwo7jNE-Lx8cv8zAK6Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe11910e46so905135e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692212374; x=1692817174;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dv0WkZdGSj5KsM+cXSukrTh8TZi7xGS5tVs/0ZiXInY=;
        b=R0ChO2PHYWaAY88uM7rOsbho70Ederd0tE5J0xBRGcxVS2/tLAVz+/j4R9w75ocQdO
         de6kq4gtFcl9WNLnfPWi08DwcEZs+BeMhq0Gwy4e7Tc6hxJI+tzWrQzprLN4hww2kxzJ
         FAS2NFOEC0h5ed+0LE9hItW6oB85GD7TKMFk3JLQuCvVB/8gNKTWf4wZXTBI4urHk6P5
         YYux7MgeOkVwC41QakHfBNr8T7d7kWiEmsFj91YosoruLw6NA1mdtRMVBa7rso0d3Ga1
         xcTF242DN9u7zaRX+hBKOSBN1hyIctNKg1gVLlU38L0JOSHPqqdgLDHft/+Og2pIw+u4
         SZ8Q==
X-Gm-Message-State: AOJu0Yxp7VWA8Mv1xgwOEOAt+dfK/OSv8FSrHe8Up405fk1uBo4vCafm
        1gy4SQsFH2A4cnbIZ6EJRvoQ/VY8peYNitPH+9SJgqWvQjdomESnIRO/YeJaqBGfGm+x1dl46E8
        jBRPd8INTxmO83aYcpVfTWYHK
X-Received: by 2002:a05:600c:3786:b0:3fe:4341:a5aa with SMTP id o6-20020a05600c378600b003fe4341a5aamr457530wmr.8.1692212374648;
        Wed, 16 Aug 2023 11:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpnglTRT7OhpMAuTy8hzXwoGAmboX/W4UQGNuXFaJjoCXzX4JEbGOKalvJ+rx8scq0V6dPAQ==
X-Received: by 2002:a05:600c:3786:b0:3fe:4341:a5aa with SMTP id o6-20020a05600c378600b003fe4341a5aamr457508wmr.8.1692212374256;
        Wed, 16 Aug 2023 11:59:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:8b00:5520:fa3c:c527:592f? (p200300cbc74b8b005520fa3cc527592f.dip0.t-ipconnect.de. [2003:cb:c74b:8b00:5520:fa3c:c527:592f])
        by smtp.gmail.com with ESMTPSA id v17-20020a1cf711000000b003fe23b10fdfsm249678wmh.36.2023.08.16.11.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 11:59:33 -0700 (PDT)
Message-ID: <bade83ec-1617-1efa-6146-fa179a796174@redhat.com>
Date:   Wed, 16 Aug 2023 20:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v3] mm: Proper document tail pages fields for folio
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>
References: <20230815212547.431693-1-peterx@redhat.com>
 <b887e764-ffa3-55ee-3c44-69cb15f8a115@redhat.com> <ZNz/DtyWS1ol8xAY@x1n>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZNz/DtyWS1ol8xAY@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>   	do {
>>   		xas_lock_irq(&xas);
>> @@ -113,7 +114,6 @@ int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
>>   				if (shadowp)
>>   					*shadowp = old;
>>   			}
>> -			set_page_private(folio_page(folio, i), entry.val + i);
>>   			xas_store(&xas, folio);
>>   			xas_next(&xas);
>>   		}
>> @@ -154,9 +154,9 @@ void __delete_from_swap_cache(struct folio *folio,
>>   	for (i = 0; i < nr; i++) {
>>   		void *entry = xas_store(&xas, shadow);
>>   		VM_BUG_ON_PAGE(entry != folio, entry);
>> -		set_page_private(folio_page(folio, i), 0);
>>   		xas_next(&xas);
>>   	}
>> +	folio->private = 0;
> 
> I'd rather remove all direct reference to "private" for swap alongside, if
> this would be the last spot (perhaps folio_set_swap_entry()).

Good idea, thanks!

-- 
Cheers,

David / dhildenb

