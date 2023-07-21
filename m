Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8435875C309
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjGUJ2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGUJ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:28:23 -0400
Received: from out-15.mta0.migadu.com (out-15.mta0.migadu.com [91.218.175.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F22726
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:28:21 -0700 (PDT)
Message-ID: <14b868d1-6a61-ea32-abb9-05cdfa335a12@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689931699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4tqHQUfFTh5hROY1Q1qzq1Tm60ss8WJh3oYAR/+AsFM=;
        b=p4x2jCjixugQfyAoXSB7mUja8QN+LyCkx9XSqq/4Zl3qtR9R7lbJQ3mbkB5yfSzl5R5Eze
        MMz4OY16ZHws6ipP5TZ4nt14Xigdajh5X/ElPxy/y7ruNbq4YXk3b86VyVywPLe30+CFiE
        9SVFZeq0Vk8ynXGg3KjP2mn/fHOR2XU=
Date:   Fri, 21 Jul 2023 17:28:11 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] binder: fix memory leak in binder_init()
Content-Language: en-US
To:     gregkh@linuxfoundation.org, Carlos Llamas <cmllamas@google.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <20230625154937.64316-1-qi.zheng@linux.dev>
 <ZJhoXDpX0tOWI01M@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <ZJhoXDpX0tOWI01M@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/26 00:16, Carlos Llamas wrote:
> On Sun, Jun 25, 2023 at 03:49:37PM +0000, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> In binder_init(), the destruction of binder_alloc_shrinker_init() is not
>> performed in the wrong path, which will cause memory leaks. So this commit
>> introduces binder_alloc_shrinker_exit() and calls it in the wrong path to
>> fix that.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   drivers/android/binder.c       | 1 +
>>   drivers/android/binder_alloc.c | 6 ++++++
>>   drivers/android/binder_alloc.h | 1 +
>>   3 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
>> index 486c8271cab7..d720f93d8b19 100644
>> --- a/drivers/android/binder.c
>> +++ b/drivers/android/binder.c
>> @@ -6617,6 +6617,7 @@ static int __init binder_init(void)
>>   
>>   err_alloc_device_names_failed:
>>   	debugfs_remove_recursive(binder_debugfs_dir_entry_root);
>> +	binder_alloc_shrinker_exit();
>>   
>>   	return ret;
>>   }
>> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
>> index 662a2a2e2e84..e3db8297095a 100644
>> --- a/drivers/android/binder_alloc.c
>> +++ b/drivers/android/binder_alloc.c
>> @@ -1087,6 +1087,12 @@ int binder_alloc_shrinker_init(void)
>>   	return ret;
>>   }
>>   
>> +void binder_alloc_shrinker_exit(void)
>> +{
>> +	unregister_shrinker(&binder_shrinker);
>> +	list_lru_destroy(&binder_alloc_lru);
>> +}
>> +
>>   /**
>>    * check_buffer() - verify that buffer/offset is safe to access
>>    * @alloc: binder_alloc for this proc
>> diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
>> index 138d1d5af9ce..dc1e2b01dd64 100644
>> --- a/drivers/android/binder_alloc.h
>> +++ b/drivers/android/binder_alloc.h
>> @@ -129,6 +129,7 @@ extern struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
>>   						  int pid);
>>   extern void binder_alloc_init(struct binder_alloc *alloc);
>>   extern int binder_alloc_shrinker_init(void);
>> +extern void binder_alloc_shrinker_exit(void);
>>   extern void binder_alloc_vma_close(struct binder_alloc *alloc);
>>   extern struct binder_buffer *
>>   binder_alloc_prepare_to_free(struct binder_alloc *alloc,
>> -- 
>> 2.30.2
>>
> 
> Thanks for the fix Qi Zheng.
> 
> Acked-by: Carlos Llamas <cmllamas@google.com>

Hi Greg,

Can this patch be merged? The Fixes tag is:

Fixes: f2517eb76f1f ("android: binder: Add global lru shrinker to binder")

Thanks,
Qi
