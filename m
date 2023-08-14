Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6337677B42C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbjHNIbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjHNIak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC65893
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692001795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a3e1TXLMXZusKYMFB1Trq+834WIag7Mx5iue3nCJmd4=;
        b=Gkd08JwhMGLZ9p22+22dTmarM14qBk6z04ijsvFdx39FSFhQc43nxqYfN6e5yDZEZU43IL
        XqBhNqgPKqGPPE4FDBS5SF4/5q2g4KtnoW7jWb2Ni86WujMOZAEvX2URxaVmzNP5u+otWr
        jB6h6bh5Hc31ifEXZLvAnDxK5OBTMdA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-MBTr4vZQOAqQjbmlNcNFoQ-1; Mon, 14 Aug 2023 04:29:53 -0400
X-MC-Unique: MBTr4vZQOAqQjbmlNcNFoQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-319652e9920so1216896f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692001792; x=1692606592;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3e1TXLMXZusKYMFB1Trq+834WIag7Mx5iue3nCJmd4=;
        b=kAM4WqVxphzU5yDcBIo6XcnugtJHmOIwkxoVr3t8z8A87Eu6mHKgR4fQB6KL5l+j+1
         iavNSEDSPkPVmJgEy6alf22FOr9FmTTmZHiuT2NtBWRbVK4xQjQRF0ukOIAnMcKR1b8S
         qlSm38l3tL1Q1G0SAflXLfItu1MlP5nLJoHvlBRa19d0IkcWP4fjJ184gUzMsYnu71kh
         HDf8rMQ3cwRj6gE0GB5hArVHNsqvVAXn45oVrvG7Fo4u4FTL+RYzYiiJNmJr1nOPi7SS
         8/dvRdPZAgmvdHbsdnLJLkG3ntq0BhRziMVHZ1lcQgnsGvMfVp9BDV36ppQjKKxBrqO+
         Mk7g==
X-Gm-Message-State: AOJu0YxGnoOTCyRfUyCs5yGu3ySUKrmXwb4pRrRaysqDZOYlwVougf3z
        TCB2e5LmTNQmJ0qtMwF7TpAhde4GWnLqmrc7sMGd2fuuTfJuj/BNeicb18qRXKahyNbAJSHSIDi
        VnXSbWIpch1xJ4WjcDviXnbKoRmDE6hZV
X-Received: by 2002:adf:fcd1:0:b0:319:5bde:df70 with SMTP id f17-20020adffcd1000000b003195bdedf70mr5769832wrs.42.1692001792264;
        Mon, 14 Aug 2023 01:29:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnOGfCdVL1g3phq3TjQGeC5jlefIxIyYL12UtGvuX2kjWJKekkVmQscCvfFC9C3eqN1UVXLA==
X-Received: by 2002:adf:fcd1:0:b0:319:5bde:df70 with SMTP id f17-20020adffcd1000000b003195bdedf70mr5769820wrs.42.1692001791869;
        Mon, 14 Aug 2023 01:29:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:d900:2d94:8433:b532:3418? (p200300d82f2bd9002d948433b5323418.dip0.t-ipconnect.de. [2003:d8:2f2b:d900:2d94:8433:b532:3418])
        by smtp.gmail.com with ESMTPSA id w17-20020adff9d1000000b00313f61889ecsm13628186wrr.66.2023.08.14.01.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 01:29:51 -0700 (PDT)
Message-ID: <88f1f73e-9879-95f9-bbc4-339c43a5c2f1@redhat.com>
Date:   Mon, 14 Aug 2023 10:29:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, linux-mm@kvack.org, koct9i@gmail.com,
        oleg@redhat.com, dave@stgolabs.net
References: <20230813123333.1705833-1-mjguzik@gmail.com>
 <00dd353b-e5aa-69fb-6b52-cb59028ea90a@redhat.com>
 <CAGudoHHHyZJXkNfGjGyxqHDay3yAzCm97r6SOdiSLYao7q2Z7A@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] kernel/fork: stop playing lockless games for exe_file
 replacement
In-Reply-To: <CAGudoHHHyZJXkNfGjGyxqHDay3yAzCm97r6SOdiSLYao7q2Z7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.23 10:21, Mateusz Guzik wrote:
> On 8/14/23, David Hildenbrand <david@redhat.com> wrote:
>> On 13.08.23 14:33, Mateusz Guzik wrote:
>>> xchg originated in 6e399cd144d8 ("prctl: avoid using mmap_sem for
>>> exe_file serialization"). While the commit message does not explain
>>> *why* the change, clearly the intent was to use mmap_sem less in this
>>> codepath. I found the original submission [1] which ultimately claims it
>>> cleans things up.
>>
>> More details are apparently in v1 of that patch:
>>
>> https://lore.kernel.org/lkml/1424979417.10344.14.camel@stgolabs.net/
>>
>> Regarding your patch: adding more mmap_write_lock() where avoidable, I'm
>> not so sure.
>>
> 
> But exe_file access is already synchronized with the semaphore and
> your own commit added a mmap_read_lock/mmap_read_unlock cycle after
> the xchg in question to accomodate this requirement.

Yes, we want to handle concurrent fork() ("Don't race with dup_mmap()"), 
thus mmap_read_lock.

> Then mmap_write_lock around the replacement is the obvious thing to do.

Apparently to you. :)

mmap_write_lock will block more than fork. For example, concurrent page 
faults (without new VMA locking), for no apparent reason to me.

> 
>> Your patch doesn't look (to me) like it is removing a lot of complexity.
>>
> 
> The code in the current form makes the reader ask what prompts xchg +
> read-lock instead of mere write-locking.
> 
> This is not a hot path either and afaics it can only cause contention
> if userspace is trying to abuse the interface to break the kernel,
> messing with a processs hard at work (which would be an extra argument
> to not play games on kernel side).
> 
> That said, no, it does not remove "a lot of complexity". It does
> remove some though at no real downside that I can see.
> 
> But then again, it is on people who insist on xchg to justify it.

Changing it now needs good justification, why we would want to block any 
concurrent MM activity. Maybe there is good justification.

In any case, this commit would have to update the documentation of 
replace_mm_exe_file, that spells out existing locking behavior.

-- 
Cheers,

David / dhildenb

