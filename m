Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C577FAFCD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjK1BzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK1BzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:55:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D2E1A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701136524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NHu+lqeWh4DisTkj49UpVbjWkoKf/V0c7GXH9eX4XIw=;
        b=jEFNwwB9nF/d6URgxbafgFhk5e7gLTSqp8gWATZYghYfZewWkXe+7QmHtiXxD+rR8+Hb1O
        Q5ngCsYm/2P3hm0V1iKGv2GX6o4c1TPtgWj/C4PGNEJ+Bij3HVvg0SwT7R8xLHDKHI36HP
        rDo1FxGO1a2P2rwaDTOvmTR01lrAXPI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-WkLp9sgrMQeVCRzucbnBNg-1; Mon, 27 Nov 2023 20:55:20 -0500
X-MC-Unique: WkLp9sgrMQeVCRzucbnBNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90B2685A5BD;
        Tue, 28 Nov 2023 01:55:19 +0000 (UTC)
Received: from [10.22.8.93] (unknown [10.22.8.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1DF740C6EB9;
        Tue, 28 Nov 2023 01:55:18 +0000 (UTC)
Message-ID: <cbd2705d-9d43-4822-9b5c-ea437a2ccca7@redhat.com>
Date:   Mon, 27 Nov 2023 20:55:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] locking: introduce devm_mutex_init and
 devm_mutex_destroy
Content-Language: en-US
To:     George Stark <gnstark@salutedevices.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
        andriy.shevchenko@linux.intel.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel@salutedevices.com
References: <20231128000910.73784-1-gnstark@salutedevices.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20231128000910.73784-1-gnstark@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 19:09, George Stark wrote:
> Using of devm API leads to certain order of releasing resources.
> So all dependent resources which are not devm-wrapped should be deleted
> with respect to devm-release order. Mutex is one of such objects that
> often is bound to other resources and has no own devm wrapping.
> Since mutex_destroy() actually does nothing in non-debug builds
> frequently calling mutex_destroy() is just ignored which is safe for now
> but wrong formally and can lead to a problem if mutex_destroy() will be
> extended so introduce devm_mutex_init() and devm_mutex_destroy().
>
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> ---
>   include/linux/mutex.h  |  3 +++
>   kernel/locking/mutex.c | 37 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 40 insertions(+)
>
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index a33aa9eb9fc3..7f60cd842322 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -119,6 +119,9 @@ do {									\
>   extern void __mutex_init(struct mutex *lock, const char *name,
>   			 struct lock_class_key *key);
>   
> +int devm_mutex_init(struct device *dev, struct mutex *lock);
> +void devm_mutex_destroy(struct device *dev, struct mutex *lock);
> +
>   /**
>    * mutex_is_locked - is the mutex locked
>    * @lock: the mutex to be queried
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index d973fe6041bf..a73124719dcb 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -56,6 +56,43 @@ __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
>   }
>   EXPORT_SYMBOL(__mutex_init);
>   
> +static void devm_mutex_release(struct device *dev, void *res)
> +{
> +	mutex_destroy(*(struct mutex **)res);
> +}
> +
> +static int devm_mutex_match(struct device *dev, void *res, void *data)
> +{
> +	struct mutex **r = res;
> +
> +	if (WARN_ON(!r || !*r))
> +		return 0;
> +
> +	return *r == data;
> +}
> +
> +int devm_mutex_init(struct device *dev, struct mutex *lock)
> +{
> +	struct mutex **ptr;
> +
> +	ptr = devres_alloc(devm_mutex_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	mutex_init(lock);
> +
> +	*ptr = lock;
> +	devres_add(dev, ptr);
> +	return 0;
> +}
> +EXPORT_SYMBOL(devm_mutex_init);
> +
> +void devm_mutex_destroy(struct device *dev, struct mutex *lock)
> +{
> +	devres_release(dev, devm_mutex_release, devm_mutex_match, lock);
> +}
> +EXPORT_SYMBOL(devm_mutex_destroy);
> +
>   /*
>    * @owner: contains: 'struct task_struct *' to the current lock owner,
>    * NULL means not owned. Since task_struct pointers are aligned at

These APIs are specific to devres. I don't believe it is suitable to put 
them into the generic mutex.h header file. All devres_* functions are 
defined in include/linux/device.h which is probabably not included in 
mutex.h. You may consider putting these APIs into device.h instead.

Cheers,
Longman

