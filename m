Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3335780569B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442284AbjLENzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442250AbjLENza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:55:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F4590
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701784535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=SEVcpVCG5LqbTJH+FlkvSOnAEVuTJl164mBLwlNcRN8=;
        b=HV1mbPibXTsxD54b9cy45kVplsZIGT7H+QODQTTCKbLkyn+m6iiy8G+h9MawhPXOEUCZfl
        kqBptKnH9FhEZxCJWeIKpu3h481jbsAUxopt/lt3sxWjYrGwvGZSSeGc9upAPqqw6zTySE
        HSMsK3faDEEHvCz97Khg+HSfG+FLiL0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-UsaNAJ_5N5W5Bq9361Dbiw-1; Tue, 05 Dec 2023 08:55:34 -0500
X-MC-Unique: UsaNAJ_5N5W5Bq9361Dbiw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b4a837eb8so48352065e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 05:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701784533; x=1702389333;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEVcpVCG5LqbTJH+FlkvSOnAEVuTJl164mBLwlNcRN8=;
        b=RO0hxoO7XL9VcFIbBJUjnZLEVeH4MOE8XnXz0Kh5VmUrrLrdMkFoes/ukyhn6NH0m8
         T+rIBcllVLnSh64o9QuNMuRiVtfmQQDTrKfil/RDMDH805zCKLltunq7NrMDP15Ujmwn
         fFeb5kNZcpWOd0N+UmutGC6plIY9ZQMztzsc9ji0GTSyRh+dXk9l1bb1n6EzU+TTSsa6
         2g/g9JMfUWdt/CJo4IQtEXCNTdcYEttiIMMjqBJV/tCXcah9+sReHeBKyYXRTyOHTkMr
         iaB2hYP8e7Eb5pQDGxCtM0fVmvi3oSo+TWrnfqcA5fkfbL/pF8a3DtpolRb3qkPbBYp1
         SbTA==
X-Gm-Message-State: AOJu0Ywmixl9rk9tQU7xDWEuWzix7Bqgi8JyZ3dCINNSx6QCEEL6U5FB
        clcMaJBk1nel7FtCk4gEnArPtXEAcaopj6cfUueuWfQExLuu+j2efJxjY1x+LEDwEFx5RfZHa+J
        bTcsgmz1VUQ69XvuxnHRzjWSs
X-Received: by 2002:a05:600c:4fc6:b0:40c:e7c:679 with SMTP id o6-20020a05600c4fc600b0040c0e7c0679mr518264wmq.46.1701784532847;
        Tue, 05 Dec 2023 05:55:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBjDwu37NND4o/i6D6CWZ8L3jvtfu6ol6i7UWvkkLTr+fvl/jd8p148SijxenSDIjtz6S8Fg==
X-Received: by 2002:a05:600c:4fc6:b0:40c:e7c:679 with SMTP id o6-20020a05600c4fc600b0040c0e7c0679mr518252wmq.46.1701784532451;
        Tue, 05 Dec 2023 05:55:32 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:300:1ec7:2962:8889:ef6? (p200300cbc72f03001ec7296288890ef6.dip0.t-ipconnect.de. [2003:cb:c72f:300:1ec7:2962:8889:ef6])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b0040b461550c4sm22491562wmn.42.2023.12.05.05.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 05:55:31 -0800 (PST)
Message-ID: <fba0b342-dbad-4a60-9b64-0e2b2824d741@redhat.com>
Date:   Tue, 5 Dec 2023 14:55:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/39] mm/rmap: interface overhaul
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
 <993ea322-8cdb-4ab1-84d3-0a1cb40049c9@arm.com>
 <067753e4-faf0-4bc0-9703-ec97b7de705e@redhat.com>
 <1ba5dd86-a201-4243-bab0-349395468236@arm.com>
 <537ac106-e4f6-4845-aa09-29b775269562@redhat.com>
 <f2955021-af48-4fb8-9159-b700e4ddc926@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f2955021-af48-4fb8-9159-b700e4ddc926@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>>>>
>>>> Regarding the contpte, I think it needs more work. Especially, as raised, to not
>>>> degrade
>>>> order-0 performance. Maybe we won't make the next merge window (and you already
>>>> predicated
>>>> that in some cover letter :P ). Let's see.
>>>
>>> Yeah that's ok. I'll do the work to fix the order-0 perf. And also do the same
>>> for patch 2 in that series - would also be really helpful if you had a chance to
>>> look at patch 2 - its new for v3.
>>
>> I only skimmed over it, but it seems to go into the direction we'll need.
>> Keeping order-0 performance unharmed should have highest priority. Hopefully my
>> microbenchmarks are helpful.
> 
> Yes absolutely - are you able to share them??

I shared them in the reply to your patchset. Let me know if you can't 
find them.

[...]

>>> Having now reviewed your series, I have a less strong opinion, perhaps it's
>>> actually best with your original names; "folio" is actually the subject after
>>> all; it's the thing being operated on.
>>>
>>
>> I think having "folio" in there looks cleaner and more consistent to other
>> functions.
>>
>> I tend to like "rmap_dup_file_folio_[pte|ptes|pmd]()", because then we have
>> "file folio" and "anon folio" as one word.
>>
>> But then I wonder about the hugetlb part. Maybe simply
>> "hugetlb_rmap_remove_folio()" etc.
>>
>> Having the "hugetlb_" prefix at the beginning feels like the right thing to do,
>> looking at orher hugetlb special-handlings.
>>
>> But I'll wait a bit until I go crazy on renaming :)
> 
> I suspect we could argue in multiple directions for hours :)

:)

> 
> Let's see if others have opinions.
> 
> FWIW, I've looked through all the patches; I like what I see! This is a really
> nice clean up and will definitely help with the various patch sets I've been
> working on. Apart from the comments I've already raised, looks in pretty good
> shape to me.

Thanks!

-- 
Cheers,

David / dhildenb

