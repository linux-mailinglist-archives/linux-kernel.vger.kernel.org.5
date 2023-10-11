Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2942E7C548F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347006AbjJKM4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjJKMzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DE2AF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697028900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C3Q22l8FHOtSNLSPzzVZTuNcPC2ZofW6W5zArgJ64/4=;
        b=gJ547nCrK4kxtHyzWhQaSArCi/O4fk6Ccw7aywlfqATGpR1fQS1Zl8rU05CerftLKNeod4
        ZwIG5L6ihJTW8j9WvAbIj6xY9hmReKM94yyT875iIUssBYtU6uXgNa9vRwxpxd08dMBSel
        uOMSv/Gt8kv1Wi/WtmTIlD7Oq2VUFvQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-eBsTBDv4PaiW8hiycp8iNg-1; Wed, 11 Oct 2023 08:54:56 -0400
X-MC-Unique: eBsTBDv4PaiW8hiycp8iNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A8E33822E87;
        Wed, 11 Oct 2023 12:54:56 +0000 (UTC)
Received: from [10.22.16.239] (unknown [10.22.16.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 886E3215670B;
        Wed, 11 Oct 2023 12:54:54 +0000 (UTC)
Message-ID: <389a8abc-7f0f-7bcc-bc58-f70f045d00a5@redhat.com>
Date:   Wed, 11 Oct 2023 08:54:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] cgroup/cpuset: Change nr_deadline_tasks to an atomic_t
 value
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xia Fukun <xiafukun@huawei.com>
References: <20231009191515.3262292-1-longman@redhat.com>
 <ZSTiULEnD7SF9n7y@localhost.localdomain>
 <6b769316-6434-5054-43f5-7933fc2bee01@redhat.com>
 <31e06652-1dbd-e32f-3123-d17e178c5c27@redhat.com>
 <ZSZZfImXuCG4Xvaz@localhost.localdomain>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZSZZfImXuCG4Xvaz@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/23 04:14, Juri Lelli wrote:
> On 10/10/23 16:03, Waiman Long wrote:
>> On 10/10/23 15:44, Waiman Long wrote:
>>> On 10/10/23 01:34, Juri Lelli wrote:
>>>> Hi,
>>>>
>>>> On 09/10/23 15:15, Waiman Long wrote:
>>>>> The nr_deadline_tasks field in cpuset structure was introduced by
>>>>> commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
>>>>> in cpusets"). Unlike nr_migrate_dl_tasks which is only modified under
>>>>> cpuset_mutex, nr_deadline_tasks can be updated in various contexts
>>>>> under different locks. As a result, data races may happen that cause
>>>>> incorrect value to be stored in nr_deadline_tasks leading to incorrect
>>>> Could you please make an example of such data races?
>>> Since update to cs->nr_deadline_tasks is not protected by a single lock,
>>> it is possible that multiple CPUs may try to modify it at the same
>>> time.  It is possible that nr_deadline_tasks++ and nr_deadline_tasks--
>>> can be done in a single instruction like in x86 and hence atomic.
>>> However, operation like "cs->nr_deadline_tasks +=
>>> cs->nr_migrate_dl_tasks" is likely a RMW operation and so is subjected
>>> to racing. It is mostly theoretical, but probably not impossible.
>> Sorry, even increment and decrement operators are not atomic.
>>
>> inc_dl_tasks_cs() is only called from switched_to_dl() in deadline.c which
>> is protected by the rq_lock, but there are multiple rq's. dec_dl_tasks_cs()
>> is called from switched_from_dl() in deadline.c and cgroup_exit() in
>> cgroup.c. The later one is protected by css_set_lock. The other place where
>> nr_deadline_tasks can be changed is in cpuset_attach() protected by
>> cpuset_mutex.
> So, let's see. :)
>
> switched_to_dl(), switched_from_dl() and cpuset_attach() should all be
> protected (for DEADLINE tasks) by cpuset_mutex, see [1] for the former
> two.
Yes, I missed the cpuset_lock() call.
> What leaves me perplexed is indeed cgroup_exit(), which seems to operate
> under css_set_lock as you say. I however wonder why is that not racy
> already wrt, say, cpuset_attach() which AFAIU uses css information w/o
> holding css_set_lock?

The css_set_lock protects changes made to css_set. Looking at 
cgroup_migrate_execute(), css_set_lock is taken when the tasks are 
actually moving from one css_set to another one. cpuset_attach() is 
called just to update the CPU and node affinity and cpuset_mutex is 
taken to ensure stability of the CPU and node masks. There is no change 
to css_set and so css_set_lock isn't needed.

We can argue that there can be racing between cgroup_exit() and the 
iteration of tasks in cpuset_attach() or cpuset_can_attach(). An 
rcu_read_lock() is probably needed. I am stilling investigating that.

Cheers,
Longman


>
> Thanks,
> Juri
>
> 1 - https://elixir.bootlin.com/linux/latest/source/kernel/sched/core.c#L7688
>

