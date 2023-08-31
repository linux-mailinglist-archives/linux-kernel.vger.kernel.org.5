Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EBC78F034
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346560AbjHaPY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjHaPY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364FDE66
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693495378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R646Wm+YCQhQntqAVQmIJZXlj3w5+IEPFITpKSmIxpg=;
        b=dpqY2j13g5LxfC5wcnFsCQizVnCX5zBoMjk9qz67FTPnVc3f3tYp9HyIBZHpST9LwL9edK
        buyovMhIxHnfLcrWv+zl6TpXpntebQGydwDJrtBh6VkPvC52/PwWZzGcnwM8Mrrr8ULFpb
        dU00N0zSq0pE0O1FcLXrwtMVHpKFLeo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-JRPeTDGkPfKOmhij0p-3ig-1; Thu, 31 Aug 2023 11:22:53 -0400
X-MC-Unique: JRPeTDGkPfKOmhij0p-3ig-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BFAB1C29AF6;
        Thu, 31 Aug 2023 15:22:52 +0000 (UTC)
Received: from [10.22.17.50] (unknown [10.22.17.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E670A403168;
        Thu, 31 Aug 2023 15:22:51 +0000 (UTC)
Message-ID: <ffb21fd4-e227-1209-666f-12a31ae1c9b6@redhat.com>
Date:   Thu, 31 Aug 2023 11:22:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 2/2] locking/rwsem: Make reader optimistic spinning
 optional
Content-Language: en-US
To:     Bongkyu Kim <bongkyu7.kim@samsung.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        kernel test robot <lkp@intel.com>
References: <20230831030004.16576-1-bongkyu7.kim@samsung.com>
 <CGME20230831030057epcas2p3031d3497e47e61182a5b593c2d8e5dd6@epcas2p3.samsung.com>
 <20230831030004.16576-3-bongkyu7.kim@samsung.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230831030004.16576-3-bongkyu7.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/30/23 23:00, Bongkyu Kim wrote:
> Disable reader optimistic spinning by default. And, can enable it
> by "rwsem.opt_rspin" cmdline.
>
> Also, fix compile error without CONFIG_RWSEM_SPIN_ON_OWNER (reported by
> kernel test robot)
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306010043.VJHcuCnb-lkp@intel.com/
> Signed-off-by: Bongkyu Kim <bongkyu7.kim@samsung.com>
> ---
>   .../admin-guide/kernel-parameters.txt          |  9 +++++++++
>   kernel/locking/rwsem.c                         | 18 +++++++++++++++++-
>   2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 772b54df084b..adf16a07fe4d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5605,6 +5605,15 @@
>   
>   	rw		[KNL] Mount root device read-write on boot
>   
> +	rwsem.opt_rspin [KNL]
> +			Use rwsem reader optimistic spinning. Reader optimistic
> +			spinning is helpful when the reader critical section is
> +			short and there aren't that many readers around.
> +			For example, enable this option may improve performance
> +			in mobile workload that there're not many readers, but
> +			may reduce performance in server workload that there're
> +			many readers.
> +
>   	S		[KNL] Run init in single mode
>   
>   	s390_iommu=	[HW,S390]
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 9c0462d515c1..de3f173d94d4 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -117,6 +117,19 @@
>   # define DEBUG_RWSEMS_WARN_ON(c, sem)
>   #endif
>   
> +#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
> +static bool rwsem_opt_rspin;

You need to move this definition out of the "ifdef 
CONFIG_RWSEM_SPIN_ON_OWNER" block or a compilation error in 
rwsem_down_read_slowpath() may happen if CONFIG_RWSEM_SPIN_ON_OWNER 
isn't defined. You may also add __ro_after_init to rwsem_opt_rspin.

Cheers,
Longman


> +
> +static int __init opt_rspin(char *str)
> +{
> +        rwsem_opt_rspin = true;
> +
> +        return 0;
> +}
> +
> +early_param("rwsem.opt_rspin", opt_rspin);
> +#endif
> +
>   /*
>    * On 64-bit architectures, the bit definitions of the count are:
>    *
> @@ -1083,7 +1096,7 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
>   	return false;
>   }
>   
> -static inline bool rwsem_no_spinners(sem)
> +static inline bool rwsem_no_spinners(struct rw_semaphore *sem)
>   {
>   	return false;
>   }
> @@ -1157,6 +1170,9 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>   		return sem;
>   	}
>   
> +	if (!IS_ENABLED(CONFIG_RWSEM_SPIN_ON_OWNER) || !rwsem_opt_rspin)
> +		goto queue;
> +
>   	/*
>   	 * Save the current read-owner of rwsem, if available, and the
>   	 * reader nonspinnable bit.

