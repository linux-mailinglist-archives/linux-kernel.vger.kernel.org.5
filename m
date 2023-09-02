Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1FA790974
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 22:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjIBUHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 16:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjIBUHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 16:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D680E5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693685220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8XbETB7ctyE/x6TOGTNs/t5t4sH8VV59U1bJ3t/H74=;
        b=c3ijITXnHwrYL6aA50gHmp6cU34wh0K8EN+S27jm+NDNGAVhjc5EmrzQJ5p030rNkToZZ2
        iDx6N9uJKi+1dOgISEDR2aBh/hw3p7F4Nq/rmpPJCjRWjO1oHvqA800MqQXeWqkt1nGOas
        +YLQlQ4iQ4RFOMKHx7BtF89aq9ogwAI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-680-annoHyuEOXOVlFNakV_8hg-1; Sat, 02 Sep 2023 16:06:57 -0400
X-MC-Unique: annoHyuEOXOVlFNakV_8hg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C1C291C4E3;
        Sat,  2 Sep 2023 20:06:57 +0000 (UTC)
Received: from [10.22.32.67] (unknown [10.22.32.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1A891182D4;
        Sat,  2 Sep 2023 20:06:56 +0000 (UTC)
Message-ID: <7bbf8335-7543-2265-a666-a389f4c0e3aa@redhat.com>
Date:   Sat, 2 Sep 2023 16:06:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] locking/mutex: remove redundant argument from
 __mutex_lock_common()
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <76a1d64e683ee9a9f507114dfbc2d5121da8c3f3.1693433504.git.mirq-linux@rere.qmqm.pl>
 <cdb0df68-ed29-18d2-22af-12253a4ec659@redhat.com>
 <ZPNrqZokdzpuyAqR@qmqm.qmqm.pl>
 <4fd976bf-2a09-ef08-e6f5-039bb20d998b@redhat.com>
In-Reply-To: <4fd976bf-2a09-ef08-e6f5-039bb20d998b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/2/23 15:40, Waiman Long wrote:
> On 9/2/23 13:06, Michał Mirosław wrote:
>> On Wed, Aug 30, 2023 at 07:54:13PM -0400, Waiman Long wrote:
>>> On 8/30/23 18:12, Michał Mirosław wrote:
>>>> use_ww_ctx is equivalent to ww_ctx != NULL. The one case where
>>>> use_ww_ctx was true but ww_ctx == NULL leads to the same
>>>> __mutex_add_waiter() call via __ww_mutex_add_waiter().
>>> I think ww_mutex_lock() can be called with a NULL ctx. Your patch will
>>> effectively change those ww_mutex_lock() to be equivalent to 
>>> mutex_lock().
>>> So it is a behavioral change.
>> Isn't ww_mutex_lock() with ctx = NULL expected to behave like 
>> mutex_lock()?
>>
>>>> Since now __ww_mutex_add_waiter() is called only with ww_mutex != 
>>>> NULL,
>>>> remove the branch there.
>> [...]
>>>> @@ -627,12 +624,11 @@ __mutex_lock_common(struct mutex *lock, 
>>>> unsigned int state, unsigned int subclas
>>>>        debug_mutex_lock_common(lock, &waiter);
>>>>        waiter.task = current;
>>>> -    if (use_ww_ctx)
>>>> -        waiter.ww_ctx = ww_ctx;
>>>> +    waiter.ww_ctx = ww_ctx;
>>> This one is fine.
>>>> lock_contended(&lock->dep_map, ip);
>>>> -    if (!use_ww_ctx) {
>>>> +    if (!ww_ctx) {
>>> That change will break ww_mutex.
>> I see that there is the rt_mutex version that stubs out
>> __ww_mutex_add_waiter(), but its ww_mutex_lock() doesn't use
>> __mutex_lock_common() at all. With the RT version out of the picture, we
>> can see that __ww_mutex_add_waiter(), when passed ww_ctx == NULL, just
>> forwards the work to __ww_waiter_add() with the same arguments
>> and returns 0 -- making the path exactly as the !use_ww_ctx branch.
>>
>> Note: There is a lot of templating-via-preprocessor code here and I
>> might have missed something. I'll appreciate hints here as maybe it
>> could be made simpler or better understood.
>
> Yes, I have misread the code thinking that __ww_waiter_add() with a 
> NULL third argument is different from __mutex_add_waiter(). They the 
> same in this case for the non-PREEMPT_RT kernel. For the PREEMPT_RT 
> kernel, however, they are still different.

OTOH, the rtmutex code will not call __ww_mutex_add_waiter() with NULL 
ww_ctx. So in that sense, the patch is probably OK. You will need to 
expand the patch description to also describe the case for PREEMPT_RT 
kernel.

Cheers,
Longman

