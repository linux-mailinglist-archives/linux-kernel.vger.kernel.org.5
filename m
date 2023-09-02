Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E55C790961
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 21:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjIBTky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 15:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjIBTky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 15:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8D5136
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693683604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEzjv3MKP1srHHBtrlqUB+1MJdLIZhTw7IrWaVz9kCY=;
        b=epnILi+tUJ3zji+mhjF3jRM3LXrlExmuphUptG4ZgPcaXbSlMHTkbUWpakaJmgDkyr3f3+
        vGFH1ydXi+Cbyp1Ae31TzWOnjP/3xtK72THk18FsuwQeXsHwgK4mu4gAInk7xYXj8EJdFp
        X2dremm2t/mMF2crThtRRmaDJ+v4Pcg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-7Yfzgwo_Pg2ljJJnrekMGQ-1; Sat, 02 Sep 2023 15:40:02 -0400
X-MC-Unique: 7Yfzgwo_Pg2ljJJnrekMGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67C5E800193;
        Sat,  2 Sep 2023 19:40:02 +0000 (UTC)
Received: from [10.22.32.67] (unknown [10.22.32.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 158582012F37;
        Sat,  2 Sep 2023 19:40:02 +0000 (UTC)
Message-ID: <4fd976bf-2a09-ef08-e6f5-039bb20d998b@redhat.com>
Date:   Sat, 2 Sep 2023 15:40:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] locking/mutex: remove redundant argument from
 __mutex_lock_common()
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <76a1d64e683ee9a9f507114dfbc2d5121da8c3f3.1693433504.git.mirq-linux@rere.qmqm.pl>
 <cdb0df68-ed29-18d2-22af-12253a4ec659@redhat.com>
 <ZPNrqZokdzpuyAqR@qmqm.qmqm.pl>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZPNrqZokdzpuyAqR@qmqm.qmqm.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/23 13:06, Michał Mirosław wrote:
> On Wed, Aug 30, 2023 at 07:54:13PM -0400, Waiman Long wrote:
>> On 8/30/23 18:12, Michał Mirosław wrote:
>>> use_ww_ctx is equivalent to ww_ctx != NULL. The one case where
>>> use_ww_ctx was true but ww_ctx == NULL leads to the same
>>> __mutex_add_waiter() call via __ww_mutex_add_waiter().
>> I think ww_mutex_lock() can be called with a NULL ctx. Your patch will
>> effectively change those ww_mutex_lock() to be equivalent to mutex_lock().
>> So it is a behavioral change.
> Isn't ww_mutex_lock() with ctx = NULL expected to behave like mutex_lock()?
>
>>> Since now __ww_mutex_add_waiter() is called only with ww_mutex != NULL,
>>> remove the branch there.
> [...]
>>> @@ -627,12 +624,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>>>    	debug_mutex_lock_common(lock, &waiter);
>>>    	waiter.task = current;
>>> -	if (use_ww_ctx)
>>> -		waiter.ww_ctx = ww_ctx;
>>> +	waiter.ww_ctx = ww_ctx;
>> This one is fine.
>>>    	lock_contended(&lock->dep_map, ip);
>>> -	if (!use_ww_ctx) {
>>> +	if (!ww_ctx) {
>> That change will break ww_mutex.
> I see that there is the rt_mutex version that stubs out
> __ww_mutex_add_waiter(), but its ww_mutex_lock() doesn't use
> __mutex_lock_common() at all. With the RT version out of the picture, we
> can see that __ww_mutex_add_waiter(), when passed ww_ctx == NULL, just
> forwards the work to __ww_waiter_add() with the same arguments
> and returns 0 -- making the path exactly as the !use_ww_ctx branch.
>
> Note: There is a lot of templating-via-preprocessor code here and I
> might have missed something. I'll appreciate hints here as maybe it
> could be made simpler or better understood.

Yes, I have misread the code thinking that __ww_waiter_add() with a NULL 
third argument is different from __mutex_add_waiter(). They the same in 
this case for the non-PREEMPT_RT kernel. For the PREEMPT_RT kernel, 
however, they are still different.

Cheers,
Longman

