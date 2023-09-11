Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837DB79A127
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjIKCQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIKCQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04B910F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694398564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S/3lrXi36lgJXFC9YTvAy+juUVj3+3Iz/BRPulL9kwg=;
        b=f1e7cnDajWwvspj8hHLucTNWweqglHqG0+q85e79PxcS9O2S9rlXwFcb184LzgQpO+q0jE
        83oLk5QPGhRxmxt5JzDlGVEE5mFYbwGjmSIDrN6QSOndwPE8jaOpCaV15W/lT9TO6wuruK
        BENOsuj8wEYavmB6xiUNJXYFC7ru6RA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-4YI_k2z9PEK9m95hQDnNUQ-1; Sun, 10 Sep 2023 22:16:00 -0400
X-MC-Unique: 4YI_k2z9PEK9m95hQDnNUQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4F00816502;
        Mon, 11 Sep 2023 02:15:59 +0000 (UTC)
Received: from [10.22.8.52] (unknown [10.22.8.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70D69200B401;
        Mon, 11 Sep 2023 02:15:59 +0000 (UTC)
Message-ID: <70d89bf4-708b-f131-f90e-5250b6804d48@redhat.com>
Date:   Sun, 10 Sep 2023 22:15:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
References: <20230907174705.2976191-1-willy@infradead.org>
 <20230907174705.2976191-2-willy@infradead.org>
 <20230907190810.GA14243@noisy.programming.kicks-ass.net>
 <ZPoift7B3UDQgmWB@casper.infradead.org>
 <20230907193838.GB14243@noisy.programming.kicks-ass.net>
 <ZPpV+MeFqX6RHIYw@dread.disaster.area>
 <20230908104434.GB24372@noisy.programming.kicks-ass.net>
 <ZP5JrYOge3tSAvj7@dread.disaster.area>
 <ZP5OfhXhPkntaEkc@casper.infradead.org>
 <ZP5llBaVrJteHQf3@dread.disaster.area>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZP5llBaVrJteHQf3@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/10/23 20:55, Dave Chinner wrote:
> On Mon, Sep 11, 2023 at 12:17:18AM +0100, Matthew Wilcox wrote:
>> On Mon, Sep 11, 2023 at 08:56:45AM +1000, Dave Chinner wrote:
>>> On Fri, Sep 08, 2023 at 12:44:34PM +0200, Peter Zijlstra wrote:
>>>> Agreed, and this is fine. However there's been some very creative
>>>> 'use' of the _is_locked() class of functions in the past that did not
>>>> follow 'common' sense.
>>>>
>>>> If all usage was: I should be holding this, lets check. I probably
>>>> wouldn't have this bad feeling about things.
>>> So your argument against such an interface is essentially "we can't
>>> have nice things because someone might abuse them"?
>> Some people are very creative ...
> Sure, but that's no reason to stop anyone else from making progress.
>
>> I was thinking about how to handle this better.  We could have
>>
>> static inline void rwsem_assert_locked(const struct rw_semaphore *sem)
>> {
>> 	BUG_ON(atomic_long_read(&sem->count) == 0);
>> }
>>
>> static inline void rwsem_assert_write_locked(const struct rw_semaphore *sem)
>> {
>> 	BUG_ON((atomic_long_read(&sem->count) & 1) != 1);
>> }
> We already have CONFIG_DEBUG_RWSEMS, so we can put these
> introspection interfaces inside debug code, and make any attempt to
> use them outside of debug builds break the build. e.g:
>
> #if DEBUG_RWSEMS
> /*
>   * rwsem locked checks can only be used by conditionally compiled
>   * subsystem debug code. It is not valid to use them in normal
>   * production code.
>   */
> static inline bool rwsem_is_write_locked()
> {
> 	....
> }
>
> static inline bool rwsem_is_locked()
> {
> 	....
> }
> #else /* !DEBUG_RWSEMS */
> #define rwsem_is_write_locked()		BUILD_BUG()
> #define rwsem_is_locked()		BUILD_BUG()
> #endif /* DEBUG_RWSEMS */
>
> And now we simply add a single line to subsystem Kconfig debug
> options to turn on rwsem introspection for their debug checks like
> so:
>
>   config XFS_DEBUG
>   	bool "XFS Debugging support"
>   	depends on XFS_FS
> +	select RWSEM_DEBUG
>   	help
>   	  Say Y here to get an XFS build with many debugging features,
>   	  including ASSERT checks, function wrappers around macros,

That may be a possible compromise. Actually, I am not against having 
them defined even outside the DEBUG_RWSEMS. We already have 
mutex_is_locked() defined and used in a lot of places. So this is just 
providing the rwsem equivalents.

I also agreed that these APIs can be misused by other users. I think we 
should clearly document the caveats of using these. So unless there are 
other means of maintaining the stability of the lock state, the test 
result may no longer be true right after the test. It is simply just the 
lock state at a certain moment in time. Callers are using them at their 
own risk.

Cheers,
Longman

