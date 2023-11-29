Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C193E7FD7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjK2NNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjK2NNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:13:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D494FD68
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701263636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=3TayWcGEHdK+3ZI0qKU3Neqs2Q8oviWSNuzQtqoO+JM=;
        b=GitpA5J/Okuaasvo32p4mVfVtguvlY12iyKleyg5uRpCuegIRH9N0o0LlWgyOf0LVNqDgO
        ntlYChaM22jnLRj18XD72tpEK1daMznq7p9zl05IuXHONAQa2XR1VXUQ4tZfL6aM7gkQ84
        eJ9kA8GuGggbVsf5DYqvJkaIEMYkxoA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-gaipZENeOrW55ZN26BUeSA-1; Wed, 29 Nov 2023 08:13:54 -0500
X-MC-Unique: gaipZENeOrW55ZN26BUeSA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b3dbe99d9so31415985e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263633; x=1701868433;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TayWcGEHdK+3ZI0qKU3Neqs2Q8oviWSNuzQtqoO+JM=;
        b=oqQvX4dDg1dc3HR5aQiBgei4ALwKVYLooM3rRNg91Zrz+X+f7H5KAQRGXP3oadoVJn
         nC5NmD4HqiSHS7HXefJbAXzaeDB1crRlNWelOxHA2611DJAgkfoU4scc7iMRn+kb1ebS
         kbr27UOtnUzmVK3bbDfDvOFUQG6bpndZGG2tBV/ch79OKppLcQoAnegFh+65ysojgVGd
         x0zAPyw07kHTG5ZZkBBpm3MrUeekSfOQBKnrdX+7IWYIoslmAal88941BfaUNS+2hY18
         gnLOZxIO9tiDHstZZ3fA5kOz667lvxPtz9b4EiFkWKt28cUhduFPEKUkUq5yEyM1XJDi
         SFCQ==
X-Gm-Message-State: AOJu0YxreDp2/6Yy6ieTtzptr9ZN1wSidg8WcSBtc19IR41BDM+TEAXb
        ddOotAsudrnDc+rDDO4n3D8mbnvYWBsy1mj154nTJthf8D3Q7Op5j7QnV6ac8do6ojCt+d6tX4U
        z88kbOw84iVq9KfjkmjC7kJqy
X-Received: by 2002:a05:600c:3505:b0:40b:3863:3ae7 with SMTP id h5-20020a05600c350500b0040b38633ae7mr12727466wmq.29.1701263633142;
        Wed, 29 Nov 2023 05:13:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAenEk0ful78cqcgDqr5yEhN1IHEYs4BnB7QTGSL8iBBCUEunft6kHFnY4NVoVwHn69jJU/w==
X-Received: by 2002:a05:600c:3505:b0:40b:3863:3ae7 with SMTP id h5-20020a05600c350500b0040b38633ae7mr12727431wmq.29.1701263632730;
        Wed, 29 Nov 2023 05:13:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c710:f600:634b:35f:ffa8:475b? (p200300cbc710f600634b035fffa8475b.dip0.t-ipconnect.de. [2003:cb:c710:f600:634b:35f:ffa8:475b])
        by smtp.gmail.com with ESMTPSA id t2-20020a5d4602000000b0032da4c98ab2sm18135574wrq.35.2023.11.29.05.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 05:13:52 -0800 (PST)
Message-ID: <930b6fba-43bf-4784-9bc9-1c83c1adc30c@redhat.com>
Date:   Wed, 29 Nov 2023 14:13:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 18/27] arm64: mte: Reserve tag block for the zero
 page
Content-Language: en-US
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com, pcc@google.com,
        steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
        hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-19-alexandru.elisei@arm.com>
 <c027ea00-a955-4c3c-b1ea-2c3f6906790d@redhat.com> <ZWcgzPcld1YksCtZ@raptor>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZWcgzPcld1YksCtZ@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.23 12:30, Alexandru Elisei wrote:
> On Tue, Nov 28, 2023 at 06:06:54PM +0100, David Hildenbrand wrote:
>> On 19.11.23 17:57, Alexandru Elisei wrote:
>>> On arm64, the zero page receives special treatment by having the tagged
>>> flag set on MTE initialization, not when the page is mapped in a process
>>> address space. Reserve the corresponding tag block when tag storage
>>> management is being activated.
>>
>> Out of curiosity: why does the shared zeropage require tagged storage? What
>> about the huge zeropage?
> 
> There are two different tags that are used for tag checking: the logical
> tag, the tag embedded in bits 59:56 of an address, and the physical tag
> corresponding to the address. This tag is stored in a separate memory
> location, called tag storage. When an access is performed, hardware
> compares the logical tag (from the address) with the physical tag (from the
> tag storage). If they match, the access is permitted.

Ack, matches my understanding.

> 
> The physical tag is set with special instructions.
> 
> Userspace pointers have bits 59:56 zero. If the pointer is in a VMA with
> MTE enabled, then for userspace to be able to access this address, the
> physical tag must also be 0b0000.
> 
> To make it easier on userspace, when a page is first mapped as tagged, its
> tags are cleared by the kernel; this way, userspace can access the address
> immediately, without clearing the physical tags beforehand. Another reason
> for clearing the physical tags when a page is mapped as tagged would be to
> avoid leaking uninitialized tags to userspace.

Make sense. Zero it just like we zero page content.

> 
> The zero page is special, because the physical tags are not zeroed every
> time the page is mapped in a process; instead, the zero page is marked as
> tagged (by setting a page flag) and the physical tags are zeroed only once,
> when MTE is enabled at boot.

Makes sense.

> 
> All of this means that when tag storage is enabled, which happens after MTE
> is enabled, the tag storage corresponding to the zero page is already in
> use and must be rezerved, and it can never be used for data allocations.
> 
> I hope all of the above makes sense. I can also put it in the commit
> message :)

Yes, makes sense!

> 
> As for the zero huge page, the MTE code in the kernel treats it like a
> regular page, and it zeroes the tags when it is mapped as tagged in a
> process. I agree that this might not be the best solution from a
> performance perspective, but it has worked so far.

What if user space were to change the tag of that shared resource?

Having a tag != 0 doesn't make sense for such a shared resource, so I 
suspect modifying the tag is like a write event: trigger write-fault -> COW.

> 
> With tag storage management enabled, set_pte_at()->mte_sync_tags() will
> discover that the huge zero page doesn't have tag storage reserved, the
> table entry will be mapped as invalid to use the page fault-on-access
> mechanism that I introduce later in the series [1] to reserve tag storage,

I assume (without looking at the code) that you took proper care of 
possible races.

Thanks for goind into detail!


-- 
Cheers,

David / dhildenb

