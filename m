Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21392785B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbjHWPDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbjHWPDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:03:36 -0400
Received: from out-34.mta1.migadu.com (out-34.mta1.migadu.com [95.215.58.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE733FB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:03:34 -0700 (PDT)
Message-ID: <01726e80-7c0b-207a-0dd0-682cad73e9fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692803013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YNEqxpzURPTfWB7ps6SWBqHGez/4O++VPfajoHYIlRA=;
        b=DmTA428wodpegtN+yNZfEshGHQntANKA6dQLNr9qatVt4BfZUlAFvirC+A25kp3QvIumH/
        IEKHtU8aj/IZYtARVk9hQc6O6N7sIG+KKW1FlWi90zqvFqZL4sM0r2vfRz0tGsM635l6qA
        fkfv2GGFlKGtSG0yZAsnLBwJShW8374=
Date:   Wed, 23 Aug 2023 23:03:04 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 6/6] blk-mq-tag: fix blk_mq_queue_tag_busy_iter()
 documentation
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        ming.lei@redhat.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230823090441.3986631-1-chengming.zhou@linux.dev>
 <20230823090441.3986631-7-chengming.zhou@linux.dev>
 <42b7123c-2688-48cb-6f8a-96996338f963@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <42b7123c-2688-48cb-6f8a-96996338f963@acm.org>
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

On 2023/8/23 22:46, Bart Van Assche wrote:
> On 8/23/23 02:04, chengming.zhou@linux.dev wrote:
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 087ea6b232f6..69b156750559 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -312,6 +312,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>    *        tags, false to stop.
>>    * @data:    Will be passed as second argument to @fn.
>>    * @flags:    BT_TAG_ITER_*
>> + * @q:        Only iterate over requests of this queue.
>>    */
> 
> Please integrate this change in patch 2/6 since the argument 'q' is added by that
> patch.

Ok, right.

> 
>> @@ -432,8 +433,7 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
>>    * @priv:    Will be passed as second argument to @fn.
>>    *
>>    * Note: if @q->tag_set is shared with other request queues then @fn will be
>> - * called for all requests on all queues that share that tag set and not only
>> - * for requests associated with @q.
>> + * called only for requests associated with @q.
>>    */
>>   void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
>>           void *priv)
> 
> Please consider adding the following to this change:
> 
> Fixes: c7b1bf5cca76 ("blk-mq: Document the functions that iterate over requests")
> 

Ok, will update.

Thanks!
