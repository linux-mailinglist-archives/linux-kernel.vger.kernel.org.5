Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0B57BD7E3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346032AbjJIKEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345822AbjJIKEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3859F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696845803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ZDq+KacwLqN89Pgcuf93P7pKqhNHzHwi+dO6s3fMZs=;
        b=UL1o74Rw8g4win4Ih4ECQKGz5ci4i9VBJfLZfyYJ5kUuuOE9AFibZXI1ufzD4qTGo6IOqp
        B6X4/7ZjeULrK3HRbT3TFqIXTKwfgjqbHu2vSsxZxzUeFfVE2YYJicpRqoBkFol2bAHGmY
        TYneA5Gj3ybCylMjisylx6gSFU5bmAM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-MOlzT0-3PdWW_RfHESy8UA-1; Mon, 09 Oct 2023 06:03:22 -0400
X-MC-Unique: MOlzT0-3PdWW_RfHESy8UA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4065d52a83aso28073455e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696845801; x=1697450601;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZDq+KacwLqN89Pgcuf93P7pKqhNHzHwi+dO6s3fMZs=;
        b=jFmuIVECcYyhkRq/16GCU0UDbxwPn+uVmrbj7LFJK8hy0mK4doci2CKfhdkoOxHUwa
         Mn1QEHtFtNhmNUXlW/BKOlBBDYOdNypr9jXSa4yYUDWuZakjaxbCM3/M9vYm8FImOdXu
         x8hcFWqbanWqUtfzYNhk8FH7mlKkMLn7jz/717Ke0N5W2GBifS6Ru4qNiCv/dZhyudfI
         DnS7qm1gW36C6iBbksY+4KFv4/dqWOb+aqOoPONlOKOJYUyVMCC/gFklUiXRO+LFXsiB
         6QF0XdURn4xlpD6KwlchP0YW1TXNEI3X29w0QGBeD4xWF/gWbjM39GOV0/zC+Nn3S0OY
         t0Mw==
X-Gm-Message-State: AOJu0YxQV/mJQow7M+KqW3d5im/6sxqphsdeLjZpbOzk/vBTqkZZJwQd
        oIlwOtY1hHmmUYVGNk6744yIKrjA/TTInFul2ns+oMhK2Gj9rRmIpjIIs509Xx5xUoZDcm5UB4Z
        QQnGjP75u6nlKE2Vjc0hBG6qm
X-Received: by 2002:a1c:7917:0:b0:401:d803:624f with SMTP id l23-20020a1c7917000000b00401d803624fmr13718990wme.4.1696845801331;
        Mon, 09 Oct 2023 03:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFId6FWrCaw17rUDTNitUjp67GHOR1xHsUpjh7dUepuwDNGG0RB5tNnyfIWHhfq4QTievZWLA==
X-Received: by 2002:a1c:7917:0:b0:401:d803:624f with SMTP id l23-20020a1c7917000000b00401d803624fmr13718970wme.4.1696845800872;
        Mon, 09 Oct 2023 03:03:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548? (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de. [2003:cb:c733:6400:ae10:4bb7:9712:8548])
        by smtp.gmail.com with ESMTPSA id e11-20020adfe7cb000000b003176c6e87b1sm9175744wrn.81.2023.10.09.03.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 03:03:20 -0700 (PDT)
Message-ID: <4bf9f174-2d0e-554a-c01f-7188ccde0f3f@redhat.com>
Date:   Mon, 9 Oct 2023 12:03:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
References: <20231002142949.235104-1-david@redhat.com>
 <20231002142949.235104-4-david@redhat.com>
 <CAJuCfpHKPDzy0Z4a_rm8K=xnNBD9T+Y-cXCBYmQDG+3xinzuOQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 3/3] memory: move exclusivity detection in do_wp_page()
 into wp_can_reuse_anon_folio()
In-Reply-To: <CAJuCfpHKPDzy0Z4a_rm8K=xnNBD9T+Y-cXCBYmQDG+3xinzuOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.10.23 19:05, Suren Baghdasaryan wrote:
> On Mon, Oct 2, 2023 at 7:29 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> Let's clean up do_wp_page() a bit, removing two labels and making it
>> a easier to read.
>>
>> wp_can_reuse_anon_folio() now only operates on the whole folio. Move the
>> SetPageAnonExclusive() out into do_wp_page(). No need to do this under
>> page lock -- the page table lock is sufficient.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/memory.c | 88 +++++++++++++++++++++++++++--------------------------
>>   1 file changed, 45 insertions(+), 43 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 1f0e3317cbdd..512f6f05620e 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3358,6 +3358,44 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
>>          return ret;
>>   }
>>

Sorry for the late response.

>> +static bool wp_can_reuse_anon_folio(struct folio *folio,
>> +                                   struct vm_area_struct *vma)
> 
> Since this function is calling folio_move_anon_rmap(), I would suggest
> changing its name to wp_reuse_anon_folio(). This would clarify that

folio_move_anon_rmap() is *not* the reuse part, it's just an rmap 
optimization. You could remove the call here and the whole thing would 
still work :) In fact, we can call folio_move_anon_rmap() whenever we 
sure the folio belongs to a single VMA only and we're holding the page 
lock. ... but we cannot always reuse a folio in that case because there 
might be GUP references from another process.

Reuse is
* Setting PageAnonExclusive
* Write fault: wunprotect the page -> wp_page_reuse()

I went a bit back and forth while cleaning that function up, but calling 
it wp_reuse_anon_folio() would end up being confusing with 
wp_page_reuse() called afterwards [we should probably rename that one to 
wp_page_wunprotect() independently]. So I prefer to leave the actual 
(sub)page reuse part in the caller.

> it's actually doing that operation instead of just checking if it's
> possible. That would also let us keep unconditional
> SetPageAnonExclusive() in it and do that under folio lock like it used
> to do (keeping rules simple). Other than that, it looks good to me.

I really want to avoid passing a "struct page" to that function; once 
we're dealing with PTE-mapped THP, the page might actually be a tail 
page of the folio.

Thanks!

-- 
Cheers,

David / dhildenb

