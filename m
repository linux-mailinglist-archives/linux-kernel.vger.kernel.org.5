Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E957EBAE0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 02:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjKOBRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 20:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjKOBRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 20:17:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26DAEB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 17:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700011057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G8zRe28oF6jtVP3vKDfHeNYaGoB5DzE0yyoVf8SF7rs=;
        b=LctVe9SG9rSno05YhujaG/Cof4Kj1DGJwbto9kW103k+If2byK+fuzmOR9x++tGUsqqaUo
        PVFZ2B1OBIOlRGFTfglG9rIGdNPuZjYXyQTE7VQ9doGH4geFIOLY9wgNTMr4RSnLC3UpyF
        m0fDQznaU7b7iGR/bWJH/r+SSgcYsLo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-5l5pOwjsPTGj_r350op2hw-1; Tue,
 14 Nov 2023 20:17:34 -0500
X-MC-Unique: 5l5pOwjsPTGj_r350op2hw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83DFF3C000A9;
        Wed, 15 Nov 2023 01:17:33 +0000 (UTC)
Received: from [10.22.16.87] (unknown [10.22.16.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02F94C15983;
        Wed, 15 Nov 2023 01:17:32 +0000 (UTC)
Message-ID: <72dced0f-6d49-4522-beeb-1a398d8f2557@redhat.com>
Date:   Tue, 14 Nov 2023 20:17:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] locking: Add rwsem_assert_held() and
 rwsem_assert_held_write()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
References: <20231110204119.3692023-1-willy@infradead.org>
 <20231110204119.3692023-2-willy@infradead.org>
 <52f481a3-bf4f-85ae-9ae6-10a23b48c7c5@redhat.com>
 <ZVPmCoLVXyShSrkN@casper.infradead.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZVPmCoLVXyShSrkN@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 16:26, Matthew Wilcox wrote:
> On Fri, Nov 10, 2023 at 05:21:22PM -0500, Waiman Long wrote:
>> On 11/10/23 15:41, Matthew Wilcox (Oracle) wrote:
>>>    static inline int rwsem_is_locked(struct rw_semaphore *sem)
>>>    {
>>> -	return atomic_long_read(&sem->count) != 0;
>>> +	return atomic_long_read(&sem->count) != RWSEM_UNLOCKED_VALUE;
>>>    }
>>> -#define RWSEM_UNLOCKED_VALUE		0L
>>> -#define __RWSEM_COUNT_INIT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
>>> +static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
>>> +{
>>> +	WARN_ON(atomic_long_read(&sem->count) == RWSEM_UNLOCKED_VALUE);
>>> +}
>> That is not correct. You mean "!= RWSEM_UNLOCKED_VALUE". Right?
> Uhhh ... I always get confused between assert and BUG_ON being opposite
> polarity, but I think it's correct.
>
> We are asserting that the rwsem is locked (either for read or write).
> That is, it is a bug if the rwsem is unlocked.
> So WARN_ON(sem->count == UNLOCKED_VALUE) is correct.  No?
You are right. I got confused too.
>
>> There are some inconsistency in the use of WARN_ON() and BUG_ON() in the
>> assertions. For PREEMPT_RT, held_write is a BUG_ON. For non-PREEMPT_RT, held
>> is a BUG_ON. It is not clear why one is BUG_ON and other one is WARN_ON. Is
>> there a rationale for that?
> I'll fix that up.
The check for write lock ownership is accurate. OTOH, the locked check 
can have false positive and so is less reliable.
>
>> BTW, we can actually check if the current process is the write-lock owner of
>> a rwsem, but not for a reader-owned rwsem.
> We actually don't want to do that.  See patches 3/4 where I explain how
> XFS takes the XFS_ILOCK for write, then passes control to a workqueue
> which asserts that the XFS_ILOCK is held for write.  The thread which
> took the rwsem for write waits for the workqueue and unlocks the rwsem.
>
I see. Thanks for the explanation.

Cheers,
Longman

