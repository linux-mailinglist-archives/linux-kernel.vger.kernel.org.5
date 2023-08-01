Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4723D76B98C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjHAQSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjHAQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551DA1B4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690906624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXJy6R2O1N6NpbXl3Zkyt7SvhrIHr98fxs9gYSY7xq0=;
        b=Arx6tDhS/cz3yb/tMxIux8LPuUlA0/OXeCn6116xw6AiAjnxT1CdOXnJK/7DASvrKAANFU
        DB6Bmy/gkdhzv0Xo6yvKyfbypllK15BmJrmz5FJ4YfB2HC6qvrY8zBVv9ogWHYSJfR616O
        nVa0EvQgoxYmTJrxntgamATrpInMiUE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-t4h2C_eWNjyAQAX3YZ1teg-1; Tue, 01 Aug 2023 12:17:03 -0400
X-MC-Unique: t4h2C_eWNjyAQAX3YZ1teg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3178e3f46b1so1910960f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 09:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690906622; x=1691511422;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXJy6R2O1N6NpbXl3Zkyt7SvhrIHr98fxs9gYSY7xq0=;
        b=l+PctGmTg/o2niCujB5kyTmyElSG8LE92MijpRzftuZiS4G1uZc2abWiXh+63samZa
         IFg/Qlxrk5iVs3rA81N8Xnq0tM0rUyV96qSK5402fQcuoqgWhuEJ088xGI0XFgV8s94+
         Mt/E27hgUARta9CrX9qd6CWeFlDvC3FgaVltfL7/EsDLKFekNLHUG4UhnlLeSLSyoaXY
         eiBZNEPpff2pEEo0is53xc5Ejc9ALvSdEjTsgGmWDlRpspyGjfYhVXlDK0QWO/JAxM9d
         EQmjgt/gjBrEWlHNGQzTz9frLP9e5u2GW1h6RKg8fULSO6cBdtMsShl2fyoJcfYIXoiz
         F8ew==
X-Gm-Message-State: ABy/qLaQxjDjmqhon/5lRjqWqwWO07rmufv0o3Udt4KDksaueiAXj92a
        Tsf2OxqjytQMnO9lLugfIKt2YFmQJLAZJX6il4eUSOyIU0Vx9uka8KHEJbYC9/SCs+6NmwM684F
        AfsLZ/zl5Ujno+Umegk2lCBhxuHmfRAUi
X-Received: by 2002:adf:ef8b:0:b0:314:2ea7:af4a with SMTP id d11-20020adfef8b000000b003142ea7af4amr2822125wro.13.1690906621792;
        Tue, 01 Aug 2023 09:17:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEGH0Ulw/x64O87fJEpYxoKABrDKtvZU+QbrtOdpDe0pNVnkFsl/Bu4qmZb7dXZ1ZmPNNOp/w==
X-Received: by 2002:adf:ef8b:0:b0:314:2ea7:af4a with SMTP id d11-20020adfef8b000000b003142ea7af4amr2822111wro.13.1690906621380;
        Tue, 01 Aug 2023 09:17:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:d100:871b:ec55:67d:5247? (p200300cbc705d100871bec55067d5247.dip0.t-ipconnect.de. [2003:cb:c705:d100:871b:ec55:67d:5247])
        by smtp.gmail.com with ESMTPSA id s6-20020a5d6a86000000b003143add4396sm16471132wru.22.2023.08.01.09.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 09:17:00 -0700 (PDT)
Message-ID: <b10d9d85-d8d6-2ee5-53f9-6b5d586b55fb@redhat.com>
Date:   Tue, 1 Aug 2023 18:16:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/8] mm/huge_memory: remove stale NUMA hinting comment
 from follow_trans_huge_pmd()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-7-david@redhat.com> <ZMktuATuYhHdAW6M@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZMktuATuYhHdAW6M@x1n>
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

On 01.08.23 18:07, Peter Xu wrote:
> On Tue, Aug 01, 2023 at 02:48:42PM +0200, David Hildenbrand wrote:
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 2cd3e5502180..0b709d2c46c6 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1467,7 +1467,6 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
>>   	if ((flags & FOLL_DUMP) && is_huge_zero_pmd(*pmd))
>>   		return ERR_PTR(-EFAULT);
>>   
>> -	/* Full NUMA hinting faults to serialise migration in fault paths */
>>   	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(vma, flags))
>>   		return NULL;
> 
> Perhaps squashing into patch 1?  Thanks,

I decided against it so I don't have to make patch description of patch 
#1 even longer with something that's mostly unrelated to the core change.

-- 
Cheers,

David / dhildenb

