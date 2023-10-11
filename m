Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A0C7C5734
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346262AbjJKOnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjJKOnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D741CB8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697035383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dEJ24/eE3zQl4M/B9HRkH6sPWWQ+597HAVvky6JoIWc=;
        b=YdOIqIJsCQUmYrfK3R6g+lJYauJoAmgLxL8jYtfRwNr8fKIMkAMY+u6SyqxAFAJgtAIeps
        iU8WbzMOOx75qhVQzgUnvjpHhjPZt84sRRjrLtL39VJRcwV66NsUEs/Quaj0JFS1n+7MgF
        0JM4xrGmEnrYsRxRbbzgS8lQgfLgbgY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-qemu_b0CNFaj0OgKUM1l8A-1; Wed, 11 Oct 2023 10:42:59 -0400
X-MC-Unique: qemu_b0CNFaj0OgKUM1l8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10B553C40C17;
        Wed, 11 Oct 2023 14:42:59 +0000 (UTC)
Received: from [10.22.17.53] (unknown [10.22.17.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA18CC5796D;
        Wed, 11 Oct 2023 14:42:58 +0000 (UTC)
Message-ID: <59eaab91-9102-3a13-b787-f0409314bb4d@redhat.com>
Date:   Wed, 11 Oct 2023 10:42:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] workqueue: Override implicit ordered attribute in
 workqueue_apply_unbound_cpumask()
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
References: <20231011024842.3348767-1-longman@redhat.com>
 <CAJhGHyDc540v+45xNx4mtWF9O=3soxEh_p7eyGQGP48n+_o2Vg@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAJhGHyDc540v+45xNx4mtWF9O=3soxEh_p7eyGQGP48n+_o2Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/23 08:16, Lai Jiangshan wrote:
> On Wed, Oct 11, 2023 at 10:49 AM Waiman Long <longman@redhat.com> wrote:
>> Commit 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1
>> to be ordered") enabled implicit ordered attribute to be added to
>> WQ_UNBOUND workqueues with max_active of 1. This prevented the changing
>> of attributes to these workqueues leading to fix commit 0a94efb5acbb
>> ("workqueue: implicit ordered attribute should be overridable").
>>
>> However, workqueue_apply_unbound_cpumask() was not updated at that time.
>> So sysfs changes to wq_unbound_cpumask has no effect on WQ_UNBOUND
>> workqueues with implicit ordered attribute. Since not all WQ_UNBOUND
>> workqueues are visible on sysfs, we are not able to make all the
>> necessary cpumask changes even if we iterates all the workqueue cpumasks
>> in sysfs and changing them one by one.
>>
>> Fix this problem by applying the corresponding change made
>> to apply_workqueue_attrs_locked() in the fix commit to
>> workqueue_apply_unbound_cpumask().
>>
>> Fixes: 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Hello Waiman Long
>
> Thanks for the fix.
>
>> ---
>>   kernel/workqueue.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index d141bd8eb2b7..19d403aa41b0 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -5785,9 +5785,13 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
>>          list_for_each_entry(wq, &workqueues, list) {
>>                  if (!(wq->flags & WQ_UNBOUND))
>>                          continue;
>> +
>>                  /* creating multiple pwqs breaks ordering guarantee */
>> -               if (wq->flags & __WQ_ORDERED)
>> -                       continue;
>> +               if (!list_empty(&wq->pwqs)) {
> I don't remember why the same test is needed in 0a94efb5acbb.
> And I can't figure it out now.
>
> I think it needs some comments or to be removed.

Is it because there will be no active work if there is no pool 
workqueue? Anyway, I just make it to be the same as that in 
apply_workqueue_attrs_locked() as the function call sequence are 
similar. If we remove the list_empty() test, we will have to remove it 
in both.

Cheers,
Longman

>
> Thanks
> Lai
>

