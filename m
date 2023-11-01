Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393F67DE5B5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344257AbjKASAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjKASAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49982C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698861598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KYk0tSjsrn4HcNFkcNV6IhBOk/uVrvqmA+02iLrYOnk=;
        b=i7UtwFj+4Q1PRmJxDIy5TGsz6Mbdmw1Z8+ZXCAHmqCNLcVH8k/T9TV7tJk8wwbxUakdxEb
        uHsS53ANOfZ+cEX9wOsr33oja4RPiGURWrSwKpnixbHDsYC0DD9CFHvuI2hdSOEO2ilCNW
        +2aLQ7wpjRQwFnkL9E1A9U/ygGxjmTA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-O4ouqYOsNNaYX_05FZqvKQ-1; Wed, 01 Nov 2023 13:59:50 -0400
X-MC-Unique: O4ouqYOsNNaYX_05FZqvKQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22A57101A529;
        Wed,  1 Nov 2023 17:59:49 +0000 (UTC)
Received: from [10.22.33.245] (unknown [10.22.33.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E15DA1A099;
        Wed,  1 Nov 2023 17:59:47 +0000 (UTC)
Message-ID: <8e1b5497-d4ca-50a0-7cb1-ffa098e0a1c2@redhat.com>
Date:   Wed, 1 Nov 2023 13:59:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] cgroup/cpuset: Change nr_deadline_tasks to an atomic_t
 value
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xia Fukun <xiafukun@huawei.com>
References: <20231024141834.4073262-1-longman@redhat.com>
 <rzzosab2z64ae5kemem6evu5qsggef2mcjz3yw2ieysoxzsvvp@26mlfo2qidml>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <rzzosab2z64ae5kemem6evu5qsggef2mcjz3yw2ieysoxzsvvp@26mlfo2qidml>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/23 12:34, Michal Koutný wrote:
> On Tue, Oct 24, 2023 at 10:18:34AM -0400, Waiman Long <longman@redhat.com> wrote:
>> The nr_deadline_tasks field in cpuset structure was introduced by
>> commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
>> in cpusets"). Unlike nr_migrate_dl_tasks which is only modified under
>> cpuset_mutex, nr_deadline_tasks can be updated under two different
>> locks - cpuset_mutex in most cases or css_set_lock in cgroup_exit(). As
>> a result, data races can happen leading to incorrect nr_deadline_tasks
>> value.
> The effect is that dl_update_tasks_root_domain() processes tasks
> unnecessarily or that it incorrectly skips dl_add_task_root_domain()?
The effect is that dl_update_tasks_root_domain() may return incorrectly 
or it is doing unnecessary work. Will update the commit log to reflect that.
>
>> Since it is not practical to somehow take cpuset_mutex in cgroup_exit(),
>> the easy way out to avoid this possible race condition is by making
>> nr_deadline_tasks an atomic_t value.
> If css_set_lock is useless for this fields and it's going to be atomic,
> could you please add (presumably) a cleanup that moves dec_dl_tasks_cs()
> from under css_set_lock in cgroup_exit() to a (new but specific)
> cpuset_cgrp_subsys.exit() handler?

But css_set_lock is needed for updating other css data. It is true that 
we can move dec_dl_tasks_cs() outside of the lock. I can do that in the 
next version.

Cheers,
Longman

