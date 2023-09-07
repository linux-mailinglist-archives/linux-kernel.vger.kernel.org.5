Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087B1797CC7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbjIGTbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbjIGSHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:07:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB201FC4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694109959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A17IvpynFGjRTpzvVbSGwFNvsNOOnGzpHwVnCuCCR08=;
        b=hZOuqZtS6qoSF853p9bAOt9J2EMw34wHVNuX4fX7naC60FnkunH9gFQdrYg7ckk7V7iEm4
        eZQgKzr/i2QOx6pAqrFxyfvpmxJxpkJgaaWWdPHAlBsdD71JlJilet8ZmnVBBHodfJ2oDh
        Xlr32ZHM/M12Oji4Fjk2VBxNn8gQqbw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-ddqwgDxDN9-rV5Fnng-Qpw-1; Thu, 07 Sep 2023 14:05:56 -0400
X-MC-Unique: ddqwgDxDN9-rV5Fnng-Qpw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98FCA3C19385;
        Thu,  7 Sep 2023 18:05:55 +0000 (UTC)
Received: from [10.22.16.164] (unknown [10.22.16.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34BA2493112;
        Thu,  7 Sep 2023 18:05:55 +0000 (UTC)
Message-ID: <2cd975ec-f868-f180-350f-b1b704118777@redhat.com>
Date:   Thu, 7 Sep 2023 14:05:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
References: <20230907174705.2976191-1-willy@infradead.org>
 <20230907174705.2976191-2-willy@infradead.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230907174705.2976191-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 13:47, Matthew Wilcox (Oracle) wrote:
> Several places want to know whether the lock is held by a writer, instead
> of just whether it's held.  We can implement this for both normal and
> rt rwsems.  RWSEM_WRITER_LOCKED is declared in rwsem.c and exposing
> it outside that file might tempt other people to use it, so just use
> a comment to note that's what the 1 means, and help anybody find it if
> they're looking to change the implementation.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/rwbase_rt.h |  5 +++++
>   include/linux/rwsem.h     | 10 ++++++++++
>   2 files changed, 15 insertions(+)
>
> diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
> index 1d264dd08625..3c25b14edc05 100644
> --- a/include/linux/rwbase_rt.h
> +++ b/include/linux/rwbase_rt.h
> @@ -31,6 +31,11 @@ static __always_inline bool rw_base_is_locked(struct rwbase_rt *rwb)
>   	return atomic_read(&rwb->readers) != READER_BIAS;
>   }
>   
> +static __always_inline bool rw_base_is_write_locked(struct rwbase_rt *rwb)
> +{
> +	return atomic_read(&rwb->readers) == WRITER_BIAS;
> +}
> +
>   static __always_inline bool rw_base_is_contended(struct rwbase_rt *rwb)
>   {
>   	return atomic_read(&rwb->readers) > 0;
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index 1dd530ce8b45..0f78b8d2e653 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -72,6 +72,11 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
>   	return atomic_long_read(&sem->count) != 0;
>   }
>   
> +static inline int rwsem_is_write_locked(struct rw_semaphore *sem)
> +{
> +	return atomic_long_read(&sem->count) & 1 /* RWSEM_WRITER_LOCKED */;
> +}

I would prefer you move the various RWSEM_* count bit macros from 
kernel/locking/rwsem.c to under the !PREEMPT_RT block and directly use 
RWSEM_WRITER_LOCKED instead of hardcoding a value of 1.

Cheers,
Longman

