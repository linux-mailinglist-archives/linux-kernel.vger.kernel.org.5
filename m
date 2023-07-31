Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C84A769C33
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjGaQVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjGaQU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535E21BC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690820413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ELxJX61JZUDVuGbmYJL8JIXJbn1HuECeDtl+/N3Ieec=;
        b=ak++wTO4FzMPhyi0DPXWY041beRR07HcEQGmFL86sD5b7sOT/gTF0DHFmnDrUy1ebAWVdC
        wvRTsYShOk1I2xIELg81N+huRUJYEo6PriXjOeN74XCTpOtVOSCz1kbufio7dvWzvoGuoU
        d89Y5RqRW7CXl3qf2us0CW5Dp/4zvKE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-u8y5zZ7-OcOZ-8ysPrKskQ-1; Mon, 31 Jul 2023 12:20:11 -0400
X-MC-Unique: u8y5zZ7-OcOZ-8ysPrKskQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30793c16c78so2967208f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690820410; x=1691425210;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELxJX61JZUDVuGbmYJL8JIXJbn1HuECeDtl+/N3Ieec=;
        b=J+2fRAhwW/7QiAm8ZSjtCKa9ZbnQLnYAkBREaA9PWl1Hn+xn3TVT0/OcxwQbLuacNm
         C5bmwLyrTfiC4htptZGFTjLWpebZuHriFzm+WG16oWk2XxHJm9+k8+W6BaVfMbHgTDXZ
         6LxVoRKNiaU3tyZ7DWVhZQpXe3Fy8VaToOJ/QouZYUL8bxZIrG3fVhbYgErwsgIX7/uF
         XTsBFIy8jMsfuwv0gBGK6sySYJYfm5KO4nKaZmwJ0I7gJc1kgj0QIdeGAFDaLqycw8iA
         Cv716ofndqSEppPoVJPS2qPXP5eOQqwDfaV2g/xnSiM2gcAFo755HVpQoSncznz7z5JC
         0OTw==
X-Gm-Message-State: ABy/qLatkFYXZHKIqBeaw+NCtw0k6JPePnlB6ZjYbGaHQODusxO2BbLd
        xKuq3NRcjCE2WmAr0lbwDu04qCWnpIP7yFBY9LBJFsAVZc+rTPclCY4WAZIdGrvg+52K2LsSF1F
        XbSBJwz5c9Q3ucOqmSK3JE0gC
X-Received: by 2002:a5d:50d0:0:b0:317:3c89:7f03 with SMTP id f16-20020a5d50d0000000b003173c897f03mr277786wrt.5.1690820409793;
        Mon, 31 Jul 2023 09:20:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHji9irVcFvjgqTFzYi9UvadswfJmbPmvwON5KNwN0L5dqmoVjMWxUCBTVI0m2yqO2THnHwhA==
X-Received: by 2002:a5d:50d0:0:b0:317:3c89:7f03 with SMTP id f16-20020a5d50d0000000b003173c897f03mr277760wrt.5.1690820409394;
        Mon, 31 Jul 2023 09:20:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c723:4c00:5c85:5575:c321:cea3? (p200300cbc7234c005c855575c321cea3.dip0.t-ipconnect.de. [2003:cb:c723:4c00:5c85:5575:c321:cea3])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d54c1000000b003176f2d9ce5sm13606935wrv.71.2023.07.31.09.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 09:20:09 -0700 (PDT)
Message-ID: <a3349cdb-f76f-eb87-4629-9ccba9f435a1@redhat.com>
Date:   Mon, 31 Jul 2023 18:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <412bb30f-0417-802c-3fc4-a4e9d5891c5d@redhat.com>
 <66e26ad5-982e-fe2a-e4cd-de0e552da0ca@redhat.com> <ZMfc9+/44kViqjeN@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZMfc9+/44kViqjeN@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> (2) Consequently, commit c46a7c817e66 from 2014 does not tell the whole
>>      story.
>>
>>      commit 21d9ee3eda77 ("mm: remove remaining references to NUMA
>>      hinting bits and helpers") from 2015 made the distinction again
>>      impossible.
>>
>>      Setting FOLL_FORCE | FOLL_HONOR_NUMA_HINT would end up never making
>>      progress in GUP with an inaccessible (PROT_NONE) VMA.
> 
> If we also teach follow_page_mask() on vma_is_accessible(), we should still
> be good, am I right?
> 
> Basically fast-gup will stop working on protnone, and it always fallbacks
> to slow-gup. Then it seems we're good decoupling FORCE with NUMA hint.
> 
> I assume that that's what you did below in the patch too, which looks right
> to me.

I modified it slightly: FOLL_HONOR_NUMA_FAULT is now set in 
is_valid_gup_args(), such that it will always be set for any GUP users, 
including GUP-fast.

[...]

>> +/*
>> + * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
>> + * a (NUMA hinting) fault is required.
>> + */
>> +static inline bool gup_can_follow_protnone(struct vm_area_struct *vma,
>> +					   unsigned int flags)
>> +{
>> +	/*
>> +	 * If callers don't want to honor NUMA hinting faults, no need to
>> +	 * determine if we would actually have to trigger a NUMA hinting fault.
>> +	 */
>> +	if (!(flags & FOLL_HONOR_NUMA_FAULT))
>> +		return true;
>> +
>> +	/* We really need the VMA ... */
>> +	if (!vma)
>> +		return false;
> 
> I'm not sure whether the compiler will be smart enough to inline this for
> fast-gup on pmd/pte.

Why shouldn't it? It's placed in a head file and the vma == NULL is not 
obfuscated. :)

Anyhow, I'll take a look at the compiler output.


Thanks!


-- 
Cheers,

David / dhildenb

