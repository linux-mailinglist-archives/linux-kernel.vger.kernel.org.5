Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC26D78E3A3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344583AbjHaABB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbjHaABB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1351CCF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693440013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qOgsBfV0xUYYx5b7NjYudE3BKdCgn1F6igBMCwp4ZLw=;
        b=fEbWyEyFuXYQbNdLhtjKQmOHA5pgLwpKxVioDekWLXl5YQkPPQ6S4XAdvNza4Eg3SIepNp
        880Q7NX0H3IyX8HW7rOnif/acoznJLwcVLbtowlO/tpomvTOdfR6XZlwnrBAMV9FjiEQmJ
        QgQKii8C9et847o26OwxWR0I/rawKiQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-okBcxx95NUyqdaeDKZc1Eg-1; Wed, 30 Aug 2023 19:54:14 -0400
X-MC-Unique: okBcxx95NUyqdaeDKZc1Eg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CE88805F5B;
        Wed, 30 Aug 2023 23:54:14 +0000 (UTC)
Received: from [10.22.10.212] (unknown [10.22.10.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F4E12026D35;
        Wed, 30 Aug 2023 23:54:13 +0000 (UTC)
Message-ID: <cdb0df68-ed29-18d2-22af-12253a4ec659@redhat.com>
Date:   Wed, 30 Aug 2023 19:54:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] locking/mutex: remove redundant argument from
 __mutex_lock_common()
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <76a1d64e683ee9a9f507114dfbc2d5121da8c3f3.1693433504.git.mirq-linux@rere.qmqm.pl>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <76a1d64e683ee9a9f507114dfbc2d5121da8c3f3.1693433504.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/23 18:12, Michał Mirosław wrote:
> use_ww_ctx is equivalent to ww_ctx != NULL. The one case where
> use_ww_ctx was true but ww_ctx == NULL leads to the same
> __mutex_add_waiter() call via __ww_mutex_add_waiter().
I think ww_mutex_lock() can be called with a NULL ctx. Your patch will 
effectively change those ww_mutex_lock() to be equivalent to 
mutex_lock(). So it is a behavioral change.
> Since now __ww_mutex_add_waiter() is called only with ww_mutex != NULL,
> remove the branch there.
>
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>   kernel/locking/mutex.c    | 16 ++++++----------
>   kernel/locking/ww_mutex.h |  5 -----
>   2 files changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index d973fe6041bf..2f0e318233f5 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -568,15 +568,12 @@ EXPORT_SYMBOL(ww_mutex_unlock);
>   static __always_inline int __sched
>   __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclass,
>   		    struct lockdep_map *nest_lock, unsigned long ip,
> -		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
> +		    struct ww_acquire_ctx *ww_ctx)
>   {
>   	struct mutex_waiter waiter;
>   	struct ww_mutex *ww;
>   	int ret;
>   
> -	if (!use_ww_ctx)
> -		ww_ctx = NULL;
> -
That code is probably not needed given the current usage. Perhaps, you 
can change it to "WARN_ON_ONCE(ww_ctx && !use_ww_ctx);"
>   	might_sleep();
>   
>   	MUTEX_WARN_ON(lock->magic != lock);
> @@ -627,12 +624,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   
>   	debug_mutex_lock_common(lock, &waiter);
>   	waiter.task = current;
> -	if (use_ww_ctx)
> -		waiter.ww_ctx = ww_ctx;
> +	waiter.ww_ctx = ww_ctx;
This one is fine.
>   
>   	lock_contended(&lock->dep_map, ip);
>   
> -	if (!use_ww_ctx) {
> +	if (!ww_ctx) {
That change will break ww_mutex.

Cheers,
Longman

