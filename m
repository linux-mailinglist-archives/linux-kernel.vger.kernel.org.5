Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB25976301A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjGZIma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjGZIl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1147A85
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690360267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o/8TBEU2aeN4aopJ2IRbNvdTcHHJiwsIyoYlbscqtTk=;
        b=FZI8WQ71Bo3To2Jma4qm1zk9Sk3ueDHC1CBCAqS65Gk7V6gVwrOahqSeJ0u/0zf+R2fLAB
        DYB+8hwqD3y8fl/NqTBDSZGIZcBoCj0DfOnf33c6B6K87gOzjVQJB6PWYtKTM2m1GlmpOe
        QK3IUqO08diiubmKFQzjCp9nMPHahg0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-URt1iQzpNdCVsR1VDJfjcg-1; Wed, 26 Jul 2023 04:31:05 -0400
X-MC-Unique: URt1iQzpNdCVsR1VDJfjcg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fa96b67ac1so38467325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690360264; x=1690965064;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/8TBEU2aeN4aopJ2IRbNvdTcHHJiwsIyoYlbscqtTk=;
        b=GLSKCiPHX7ld+xY3c+m+/h6X7iI88+9z9cZr6vZyRvFpAOhCH5yGJMDW40WJ4FBDpj
         U0gIk0dqGEua4kbVV2s6NswMDja/QlvqTrO1Zp3wQrDGIQpCA4JDKzID4gE99TgVcgje
         oAqmPHfTqS9SpEq/231bOnFqE32E7Ai8oAnPjSY7az/fPGImDbzYghnbGpcNIKfHAHkf
         kNXsn1Swppx1Xt+8aGlz26ebydG9t+CEW+GrELzZhndfY9nMmqvOfCSqSlw5gWbciaRZ
         q4KZenwi7X1z5mnth8mUyczDDu0vLAf6wDSM5W3W44Pe06sWfS5VYxwboC/Sr6bT3G9l
         pOLw==
X-Gm-Message-State: ABy/qLZhjzkHm4pgdKaarD84TyXzSdB+SFFZsLJQPjU4RpmMoDR+Uvy+
        tDyHdbdfLPcBnH0v/aIZPmUO9tBLlxpQBO1/1ORYg/JF4cCmM6ElbVi9Tr6vdu6OwEGK3wmaDKr
        eRfhD8ukkYhEZZf1a8mTctogs
X-Received: by 2002:a05:600c:2281:b0:3fd:2a34:e867 with SMTP id 1-20020a05600c228100b003fd2a34e867mr835248wmf.25.1690360264248;
        Wed, 26 Jul 2023 01:31:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHryebkUbQGetMhiB7/gQUnN1wLgo9/ViGR56iSz8IUVNC1EfMeqI/ocBmFhgTOKOpVKbJNCQ==
X-Received: by 2002:a05:600c:2281:b0:3fd:2a34:e867 with SMTP id 1-20020a05600c228100b003fd2a34e867mr835236wmf.25.1690360263814;
        Wed, 26 Jul 2023 01:31:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f600:a519:c50:799b:f1e3? (p200300cbc705f600a5190c50799bf1e3.dip0.t-ipconnect.de. [2003:cb:c705:f600:a519:c50:799b:f1e3])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c25cc00b003fbb06af219sm1309455wml.32.2023.07.26.01.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:31:03 -0700 (PDT)
Message-ID: <61234a18-7797-722e-ae14-1aa352c4d850@redhat.com>
Date:   Wed, 26 Jul 2023 10:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Ross Zwisler <zwisler@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
References: <20230718220106.GA3117638@google.com>
 <ZLd/WEZTH5rlwYjP@dhcp22.suse.cz> <20230719075952.GH1901145@kernel.org>
 <ZLeZaa5LMH1c2zQ3@dhcp22.suse.cz>
 <9770454d-f840-c7cf-314e-ce81839393e3@redhat.com>
 <20230719230515.GA3654720@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
In-Reply-To: <20230719230515.GA3654720@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> As an alternative, we might use the "memmap=nn[KMG]!ss[KMG]" [1] parameter
>> to mark some memory as protected.
>>
>> That memory can then be configured as devdax device and online to
>> ZONE_MOVABLE (dev/dax).
>>
>> [1] https://docs.pmem.io/persistent-memory/getting-started-guide/creating-development-environments/linux-environments/linux-memmap
> 
> I've previously been reconfiguring devdax memory like this:
> 
>    ndctl create-namespace --reconfig=namespace0.0 -m devdax -f
>    daxctl reconfigure-device --mode=system-ram dax0.0
> 
> Is this how you've been doing it, or is there something else I should
> consider?

No, exactly like that.

> 
> I just sent mail to Michal outlining my use case, hopefully it makes sense.

Yes, thanks for sharing, I'll dig deeper into that next.

> 
> I had thought about using 'memmap=' in the first kernel and the worry was that
> I'd have to support many different machines with different memory
> configurations, and have to hard-code memory offsets and lengths for the
> various memmap= kernel command line parameters. 

Indeed.

> If I can make ZONE_MOVABLE
> work that's preferable because the kernel will choose the correct usermem-only
> region for me, and then I can just use that region for the crash kernel and
> 3rd kernel boots.

It really sounds like you might be better off using CMA or 
alloc_contig_pages().

The latter is unreliable, though, and the memory cannot be used for 
other purposes once alloc_contig_pages() succeeded

See arch/powerpc/platforms/powernv/memtrace.c one one user that needs to 
set aside a lot of memory to store HW traces.

-- 
Cheers,

David / dhildenb

