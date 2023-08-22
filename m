Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378127837E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjHVCWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjHVCWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:22:53 -0400
Received: from out-55.mta1.migadu.com (out-55.mta1.migadu.com [95.215.58.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856D019A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:22:47 -0700 (PDT)
Message-ID: <d32276eb-12ee-ef4f-6bc8-2d4da7dbd7f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692670965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7RLg7ykW01vg91M1WmtoG8NsuuordehR3Hy/sGb60iw=;
        b=HcuDOeA9A79AyJZYoWOn16f5GmQI5i7OoMI3RRrs2+Jna3j8ZiMdi/vDeSo4/sOYWIJDQv
        bS3hLN8gCy6uj6epU+ttlU+c2J9Bs556lMgcr08M/cFLwA4t43tC7NQvlw9PbWEA6GA3zY
        2dD5UBVf4CCC5WN5lLl2KDjUcuKl6nw=
Date:   Tue, 22 Aug 2023 10:21:34 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] blk-mq-tag: support queue filter in bt_tags_iter()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        ming.lei@redhat.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230821073528.3469210-1-chengming.zhou@linux.dev>
 <20230821073528.3469210-2-chengming.zhou@linux.dev>
 <f3495925-d681-ba7f-5c2f-d2c19453b067@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <f3495925-d681-ba7f-5c2f-d2c19453b067@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/22 03:58, Bart Van Assche wrote:
> On 8/21/23 00:35, chengming.zhou@linux.dev wrote:
>> @@ -417,7 +425,23 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
>>   void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
>>           void *priv)
>>   {
>> -    __blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
>> +    __blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS, NULL);
>> +}
>> +
>> +static void __blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>> +                      busy_tag_iter_fn *fn, void *priv,
>> +                      struct request_queue *q)
>> +{
>> +    unsigned int flags = tagset->flags;
>> +    int i, nr_tags;
>> +
>> +    nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
>> +
>> +    for (i = 0; i < nr_tags; i++) {
>> +        if (tagset->tags && tagset->tags[i])
>> +            __blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
>> +                          BT_TAG_ITER_STARTED, q);
>> +    }
>>   }
>>     /**
>> @@ -436,16 +460,7 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
>>   void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>>           busy_tag_iter_fn *fn, void *priv)
>>   {
>> -    unsigned int flags = tagset->flags;
>> -    int i, nr_tags;
>> -
>> -    nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
>> -
>> -    for (i = 0; i < nr_tags; i++) {
>> -        if (tagset->tags && tagset->tags[i])
>> -            __blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
>> -                          BT_TAG_ITER_STARTED);
>> -    }
>> +    __blk_mq_tagset_busy_iter(tagset, fn, priv, NULL);
>>   }
>>   EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
> 
> One change per patch please. I think the introduction of __blk_mq_tagset_busy_iter()
> should be a separate patch instead of happening in this patch.
> 

Yes, it's better. I will put it in a separate patch.

Thanks.
