Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645957D705F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343658AbjJYPGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjJYPGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E773A129
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698246325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=E3mqoT8bzSU+YoraddyScVrQG5NhO7Df6cFl8D5MlD0=;
        b=iWGh55cDV71pQSf8AMSUNoPqDKtNbEE+s97mqvOm8JEiGa/x8PMNShiTLTCbxuwNhkcJC6
        bJ6lfV1WeBxnYtZ+kKoi9Cli0Qkn+wR1SRNSCJodtRSuvKWheX3OJTjg6YMYplzzW2KwUD
        3CsQ5+IBSjIM4LtfXnp2EK7WDoEoUQE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-HHbbtA0sNAuArUqv4ZB5yQ-1; Wed, 25 Oct 2023 11:05:01 -0400
X-MC-Unique: HHbbtA0sNAuArUqv4ZB5yQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5079a8c68c6so5754399e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698246300; x=1698851100;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3mqoT8bzSU+YoraddyScVrQG5NhO7Df6cFl8D5MlD0=;
        b=OacaUGn4ex4V6zlG3QMb0zKHewJ0eXjJTXOJC6YRu87QEMwRzCu1p8c1jSGDtneBQO
         7bJWMMI9fFgk1tnhhKagtoUJw4B3ajri4GTjFD2H4krYjvkwdSJWgEhJoXsC1OAimDHv
         vNh5VYMZG6df+J71ut80bFWdn/0rhyb+GIp9RmHalSZy78M2tNe5TNv3xjQtbWCN/HEC
         C/51v2/E2tV7qMfiBhkEzvQBUEhYpvQfsT+p5RArPg3Z3pXrrfF1s9F3PGdhj5qFVmxG
         rAbIvNyp32DRw+2zgrxfV2b5p2nxin125sadc4BceaCuDmS9sizgcu6yHJ5E+KimdBIx
         EU1A==
X-Gm-Message-State: AOJu0YyENpRUPea025yjfz3dYYQHYokzBOttJ69DGgd/4bLutRkqsR0g
        yLsc/j3cPzBqZFSLhdpvTg/ZTekZCFwcJ3txN0deWQvdejzjDpM94954oQjDOaipawrW6c7nyEj
        bAOjPilUxCXANhU9HSggync/Lw5MQYvmG
X-Received: by 2002:a05:6512:2ef:b0:505:79f2:5c6c with SMTP id m15-20020a05651202ef00b0050579f25c6cmr11176645lfq.6.1698246300084;
        Wed, 25 Oct 2023 08:05:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNJ+ZkhUlNSvT+T2D7Ufc5+ZOPWFBBrBAz4tG+TiRp6t2kKi7jUhil5VWDkVPb5whIzXXOkw==
X-Received: by 2002:a05:6512:2ef:b0:505:79f2:5c6c with SMTP id m15-20020a05651202ef00b0050579f25c6cmr11176624lfq.6.1698246299596;
        Wed, 25 Oct 2023 08:04:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8100:1fcd:5169:391e:99af? (p200300cbc70881001fcd5169391e99af.dip0.t-ipconnect.de. [2003:cb:c708:8100:1fcd:5169:391e:99af])
        by smtp.gmail.com with ESMTPSA id q5-20020adfea05000000b0032d9548240fsm12232146wrm.82.2023.10.25.08.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 08:04:59 -0700 (PDT)
Message-ID: <85647327-2a34-4261-a110-c726eb7b20de@redhat.com>
Date:   Wed, 25 Oct 2023 17:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: vm_flags including VM_EXEC can exit timely
Content-Language: en-US
To:     zhiguojiang <justinjiang@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20231024144913.421-1-justinjiang@vivo.com>
 <a1357e75-986a-4e00-a987-9d8c767a42a5@redhat.com>
 <d1c01214-4548-414d-be84-21c38cfe3ede@vivo.com>
 <d2d78a5b-fa57-4e46-950d-e8e48bb020be@vivo.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d2d78a5b-fa57-4e46-950d-e8e48bb020be@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.10.23 05:04, zhiguojiang wrote:
> 
> 
> 在 2023/10/25 9:17, zhiguojiang 写道:
>>
>>
>> 在 2023/10/24 23:51, David Hildenbrand 写道:
>>> On 24.10.23 16:49, Zhiguo Jiang wrote:
>>>> When pra->vm_flags include VM_EXEC flag and folio is file detected in
>>>> folio_referenced_one(), the folio referenced traversal process can be
>>>> exited timely to reduce the detecting folio referenced time.
>>>>
>>>
>>> Can you further elaborate what the logic behind that is?
>>>
>>> Why can we stop here if we're dealing with a pagecache folio in an
>>> executable VMA?
>>>
>> Functions call flow：folio_referenced() --> rmap_walk() -->
>> rmap_walk_ksm()/rmap_walk_anon()/rmap_walk_file() --> rwc->rmap_one()
>> --> folio_referenced_one(). And folio_referenced() is called by two
>> interfaces: folio_check_references() and shrink_active_list().
>>
>> 1. folio_check_references():
>> When (referenced_ptes > 0 && (vm_flags & VM_EXEC) &&
>> folio_is_file_lru(folio)) is detected in folio_check_references(),
>> FOLIOREF_ACTIVATE will be returned and the folio will be added to the
>> active file lru. So when VM_EXEC is detected in
>> folio_referenced_one(), we can stop continuing to detect the reference
>> relationship between this folio and other vmas, and exit directly to
>> avoid unnecessary traversal.
>>
>> 2. shrink_active_list():
>> The shrink_active_list() is the same as the folio_check_references().
>>

Thanks, that all belongs into the patch description in some condensed form.

Should that "(vm_flags & VM_EXEC) && folio_is_file_lru(folio)" in all 
three places somehow be factored out in a function with a suitable name, 
so all these cases can be identified easily? Just a thought.

Then, add a comment to the code you're adding. There are plenty of 
comments for the other two cases you mentioned.


folio_referenced() documents:

	"Quick test_and_clear_referenced for all mappings of a folio"

IIUC, you're code will stop doing that, as you break in the middle
of processing some mappings, but not all.

Please describe why that is okay and add it to the patch description and 
update the function description.

>>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>>> ---
>>>>    mm/rmap.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>    mode change 100644 => 100755 mm/rmap.c
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 7a27a2b41802..932f3b7e8521
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -884,6 +884,8 @@ static bool folio_referenced_one(struct folio
>>>> *folio,
>>>>        if (referenced) {
>>>>            pra->referenced++;
>>>>            pra->vm_flags |= vma->vm_flags & ~VM_LOCKED;
>>>> +        if ((pra->vm_flags | VM_EXEC) && folio_is_file_lru(folio))
>>>> +            return false;
>>>>        }
>>>>          if (!pra->mapcount)
> Sorry, Patch mistake in writing, patch should be:
> +        if ((pra->vm_flags & VM_EXEC) && folio_is_file_lru(folio))
> +            return false;

So this was not even properly tested? :/

Of course I have to ask: what's the net (performance) benefit of this 
change?

-- 
Cheers,

David / dhildenb

