Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C997E8581
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 23:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjKJWWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 17:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjKJWWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 17:22:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5654229
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 14:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699654887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tg0wVWHnfhwo90mRsU0kU9KS8A8DGQq7gTBPmwLKhcI=;
        b=ONYzEgsBeeDAvlcDEoh21ccwTeijNfohz+XSLnFHVnuSmcjGNesH/pTiILB2VtLtnKRZWa
        yAMzSptYEdJxj6/3EIKlG4W1ElkFOFgGULCOeubN/dw/XJGi40W2qiC/P9qcRIY3fsocS0
        RAOLtfm+NbhFooiyytNOxWRM64i0xHg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-EVslu0XCNTGQy-9oILGhIQ-1; Fri,
 10 Nov 2023 17:21:23 -0500
X-MC-Unique: EVslu0XCNTGQy-9oILGhIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCB551C0BA46;
        Fri, 10 Nov 2023 22:21:22 +0000 (UTC)
Received: from [10.22.32.62] (unknown [10.22.32.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EC4B1C060AE;
        Fri, 10 Nov 2023 22:21:22 +0000 (UTC)
Message-ID: <52f481a3-bf4f-85ae-9ae6-10a23b48c7c5@redhat.com>
Date:   Fri, 10 Nov 2023 17:21:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/4] locking: Add rwsem_assert_held() and
 rwsem_assert_held_write()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
References: <20231110204119.3692023-1-willy@infradead.org>
 <20231110204119.3692023-2-willy@infradead.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20231110204119.3692023-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 15:41, Matthew Wilcox (Oracle) wrote:
> Modelled after lockdep_assert_held() and lockdep_assert_held_write(),
> but are always active, even when lockdep is disabled.  Of course, they
> don't test that _this_ thread is the owner, but it's sufficient to catch
> many bugs and doesn't incur the same performance penalty as lockdep.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/rwbase_rt.h |  9 ++++++--
>   include/linux/rwsem.h     | 46 ++++++++++++++++++++++++++++++++++-----
>   2 files changed, 48 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
> index 1d264dd08625..a04acd85705b 100644
> --- a/include/linux/rwbase_rt.h
> +++ b/include/linux/rwbase_rt.h
> @@ -26,12 +26,17 @@ struct rwbase_rt {
>   	} while (0)
>   
>   
> -static __always_inline bool rw_base_is_locked(struct rwbase_rt *rwb)
> +static __always_inline bool rw_base_is_locked(const struct rwbase_rt *rwb)
>   {
>   	return atomic_read(&rwb->readers) != READER_BIAS;
>   }
>   
> -static __always_inline bool rw_base_is_contended(struct rwbase_rt *rwb)
> +static inline void rw_base_assert_held_write(const struct rwbase_rt *rwb)
> +{
> +	BUG_ON(atomic_read(&rwb->readers) != WRITER_BIAS);
> +}
> +
> +static __always_inline bool rw_base_is_contended(const struct rwbase_rt *rwb)
>   {
>   	return atomic_read(&rwb->readers) > 0;
>   }
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index 1dd530ce8b45..b5b34cca86f3 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -66,14 +66,24 @@ struct rw_semaphore {
>   #endif
>   };
>   
> -/* In all implementations count != 0 means locked */
> +#define RWSEM_UNLOCKED_VALUE		0UL
> +#define RWSEM_WRITER_LOCKED		(1UL << 0)
> +#define __RWSEM_COUNT_INIT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
> +
>   static inline int rwsem_is_locked(struct rw_semaphore *sem)
>   {
> -	return atomic_long_read(&sem->count) != 0;
> +	return atomic_long_read(&sem->count) != RWSEM_UNLOCKED_VALUE;
>   }
>   
> -#define RWSEM_UNLOCKED_VALUE		0L
> -#define __RWSEM_COUNT_INIT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
> +static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
> +{
> +	WARN_ON(atomic_long_read(&sem->count) == RWSEM_UNLOCKED_VALUE);
> +}
That is not correct. You mean "!= RWSEM_UNLOCKED_VALUE". Right?
> +
> +static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
> +{
> +	WARN_ON(!(atomic_long_read(&sem->count) & RWSEM_WRITER_LOCKED));
> +}
>   
>   /* Common initializer macros and functions */
>   
> @@ -152,11 +162,21 @@ do {								\
>   	__init_rwsem((sem), #sem, &__key);			\
>   } while (0)
>   
> -static __always_inline int rwsem_is_locked(struct rw_semaphore *sem)
> +static __always_inline int rwsem_is_locked(const struct rw_semaphore *sem)
>   {
>   	return rw_base_is_locked(&sem->rwbase);
>   }
>   
> +static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
> +{
> +	BUG_ON(!rwsem_is_locked(sem));
> +}
> +

There are some inconsistency in the use of WARN_ON() and BUG_ON() in the 
assertions. For PREEMPT_RT, held_write is a BUG_ON. For non-PREEMPT_RT, 
held is a BUG_ON. It is not clear why one is BUG_ON and other one is 
WARN_ON. Is there a rationale for that?

BTW, we can actually check if the current process is the write-lock 
owner of a rwsem, but not for a reader-owned rwsem.

Cheers,
Longman

