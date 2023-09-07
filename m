Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1757D797DBA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbjIGVHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjIGVHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803901BCB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694120809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLY0xNL0iM0EoMVOirrTvmKbAGvbYqhrOQaF68f9k5I=;
        b=XN+0HkUcCY5UevUgh6IIRaSHJnxuI4jn2FmwwM7uQJJwn6kcIUHwWLHs/YyO9uhXG01jvr
        Mtmbxt9IN0YKoNza7ZDqGV25sA0E8V09+Bd4qBwcoaoMQjO1P4DYZroEdkTF18BlKXg8kZ
        w0fiKbWi5MT42ctZIniH/po3B/9T2co=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-ZHUrKFY_NfWxsapOBhqQ4w-1; Thu, 07 Sep 2023 17:06:40 -0400
X-MC-Unique: ZHUrKFY_NfWxsapOBhqQ4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1762823D5E;
        Thu,  7 Sep 2023 21:06:39 +0000 (UTC)
Received: from [10.22.16.164] (unknown [10.22.16.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6ED91200BABC;
        Thu,  7 Sep 2023 21:06:39 +0000 (UTC)
Message-ID: <da1daacf-22b2-20da-b6c0-9b1362b8a901@redhat.com>
Date:   Thu, 7 Sep 2023 17:06:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Content-Language: en-US
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZPolpUuCiGT/5PLO@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/7/23 15:33, Matthew Wilcox wrote:
> On Thu, Sep 07, 2023 at 02:05:54PM -0400, Waiman Long wrote:
>> On 9/7/23 13:47, Matthew Wilcox (Oracle) wrote:
>>> +static inline int rwsem_is_write_locked(struct rw_semaphore *sem)
>>> +{
>>> +	return atomic_long_read(&sem->count) & 1 /* RWSEM_WRITER_LOCKED */;
>>> +}
>> I would prefer you move the various RWSEM_* count bit macros from
>> kernel/locking/rwsem.c to under the !PREEMPT_RT block and directly use
>> RWSEM_WRITER_LOCKED instead of hardcoding a value of 1.
> Just to be clear, you want the ~50 lines from:
>
> /*
>   * On 64-bit architectures, the bit definitions of the count are:
> ...
> #define RWSEM_READ_FAILED_MASK  (RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
>                                   RWSEM_FLAG_HANDOFF|RWSEM_FLAG_READFAIL)
>
> moved from rwsem.c to rwsem.h?
>
> Or just these four lines:
>
> #define RWSEM_WRITER_LOCKED     (1UL << 0)
> #define RWSEM_FLAG_WAITERS      (1UL << 1)
> #define RWSEM_FLAG_HANDOFF      (1UL << 2)
> #define RWSEM_FLAG_READFAIL     (1UL << (BITS_PER_LONG - 1))

I think just the first 3 lines will be enough. Maybe a bit of comment 
about these bit flags in the count atomic_long value.

Cheers,
Longman


