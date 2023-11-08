Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7757E584E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjKHOFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjKHOF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:05:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4411BEF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699452292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jiF6KGsSwf+Ous64zIXcTC1g+vwsjdfqB1Fo3UNsr5I=;
        b=MZeTTmobC3gdCPfk0zcDjX8LZwT9VfK7cta9fm6vh7VCGp+Lqf11NoPfKUhWkA956Yrtcr
        +4PyNJTIIiPCOkmwWCD3xu6/Fo1FpR7ucD5Z65nfTEA2XO2LLNcOYWd+cpMKVPc2XRh7Qp
        71EJ4vW1tsgByZwYY7nj7W4u4yPyWfY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-9om6KFQ1Mf-oYswfZdf6sA-1; Wed, 08 Nov 2023 09:04:49 -0500
X-MC-Unique: 9om6KFQ1Mf-oYswfZdf6sA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E89EA811E91;
        Wed,  8 Nov 2023 14:04:48 +0000 (UTC)
Received: from [10.22.9.17] (unknown [10.22.9.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F0A01C060AE;
        Wed,  8 Nov 2023 14:04:48 +0000 (UTC)
Message-ID: <6da49b39-653a-1eda-2d21-1f1b50cb14f0@redhat.com>
Date:   Wed, 8 Nov 2023 09:04:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] locking/rwsem: Remove unnessary check in
 rwsem_down_read_slowpath()
Content-Language: en-US
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org
References: <20231108105639.70088-1-haifeng.xu@shopee.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20231108105639.70088-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 05:56, Haifeng Xu wrote:
> When the owner of rw_semaphore is reader, the count can't be
> RWSEM_WRITER_LOCKED, so there is no need to check it.
>
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>   kernel/locking/rwsem.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 2340b6d90ec6..7a4d8a9ebd9c 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1005,8 +1005,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>   	 * waiter, don't attempt optimistic lock stealing if the lock is
>   	 * currently owned by readers.
>   	 */
> -	if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) &&
> -	    (rcnt > 1) && !(count & RWSEM_WRITER_LOCKED))
> +	if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) && (rcnt > 1))
>   		goto queue;
>   
>   	/*

Unlike RWSEM_WRITER_LOCKED bit in count, the RWSEM_READER_OWNED bit in 
owner is just a hint, not an authoritative state of the rwsem. So it is 
possible that both the RWSEM_READER_OWNED bit can be set in owner and 
RWSEM_WRITER_LOCKED bit set in count in a transition period right after 
RWSEM_WRITER_LOCKED bit is set. So the RWSEM_WRITER_LOCKED check can 
still provide some value. We should probably update the comment to 
reflect that.

Cheers,
Longman

