Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36734797F51
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjIGXs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjIGXsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1771B1BCB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 16:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694130455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q0DSZUVajRNBw/S+LqH8eIJWqxcuhAbEAg5nSMOQP+U=;
        b=SyCLrB+Wkhiiisj4JXbizL40PgVh2FQSxdLnMczh6cP6SzJqawJ9QDWvgVGGAumBYJ8YNi
        xO1C5Umptzdu/rSgbhdo/nxlbzb92n07wmmnBIM2yQc5Be0rtxzqMnz2++xGsbdyhN8VhU
        9cx5oGQysgOKadok9h79Si872trh0bY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-VCCe6YDsPgyTRbBjYsc6Dw-1; Thu, 07 Sep 2023 19:47:32 -0400
X-MC-Unique: VCCe6YDsPgyTRbBjYsc6Dw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BB32181B542;
        Thu,  7 Sep 2023 23:47:32 +0000 (UTC)
Received: from [10.22.16.164] (unknown [10.22.16.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 056F82026D76;
        Thu,  7 Sep 2023 23:47:31 +0000 (UTC)
Message-ID: <c38847cb-92c9-139f-03cc-86d233297d58@redhat.com>
Date:   Thu, 7 Sep 2023 19:47:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
References: <20230907174705.2976191-1-willy@infradead.org>
 <20230907174705.2976191-2-willy@infradead.org>
 <2cd975ec-f868-f180-350f-b1b704118777@redhat.com>
 <ZPolpUuCiGT/5PLO@casper.infradead.org>
 <da1daacf-22b2-20da-b6c0-9b1362b8a901@redhat.com>
In-Reply-To: <da1daacf-22b2-20da-b6c0-9b1362b8a901@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/7/23 17:06, Waiman Long wrote:
>
> On 9/7/23 15:33, Matthew Wilcox wrote:
>> On Thu, Sep 07, 2023 at 02:05:54PM -0400, Waiman Long wrote:
>>> On 9/7/23 13:47, Matthew Wilcox (Oracle) wrote:
>>>> +static inline int rwsem_is_write_locked(struct rw_semaphore *sem)
>>>> +{
>>>> +    return atomic_long_read(&sem->count) & 1 /* 
>>>> RWSEM_WRITER_LOCKED */;
>>>> +}
>>> I would prefer you move the various RWSEM_* count bit macros from
>>> kernel/locking/rwsem.c to under the !PREEMPT_RT block and directly use
>>> RWSEM_WRITER_LOCKED instead of hardcoding a value of 1.
>> Just to be clear, you want the ~50 lines from:
>>
>> /*
>>   * On 64-bit architectures, the bit definitions of the count are:
>> ...
>> #define RWSEM_READ_FAILED_MASK (RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
>> RWSEM_FLAG_HANDOFF|RWSEM_FLAG_READFAIL)
>>
>> moved from rwsem.c to rwsem.h?
>>
>> Or just these four lines:
>>
>> #define RWSEM_WRITER_LOCKED     (1UL << 0)
>> #define RWSEM_FLAG_WAITERS      (1UL << 1)
>> #define RWSEM_FLAG_HANDOFF      (1UL << 2)
>> #define RWSEM_FLAG_READFAIL     (1UL << (BITS_PER_LONG - 1))
>
> I think just the first 3 lines will be enough. Maybe a bit of comment 
> about these bit flags in the count atomic_long value.

Actually, the old rwsem implementation won't allow you to reliably 
determine if a rwsem is write locked because the xadd instruction is 
used for write locking and the code had to back out the WRITER_BIAS if 
the attempt failed. Maybe that is why XFS has its own code to check if a 
rwsem is write locked which is needed with the old rwsem implementation.

The new implementation makes this check reliable. Still it is not easy 
to check if a rwsem is read locked as the check will be rather 
complicated and probably racy.

Cheers,
Longman

