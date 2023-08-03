Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1170376F0D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbjHCRo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjHCRoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17FC1713
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691084619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJfg9BrfOsioMYVKnwsqtB870Xfs9dP6zoI9d61i46I=;
        b=YIYYdIgCBhTYh7t+P1CUE/yOOpxDwPNAokTDVYm2/7H0YdnFgS+DEXiA8d7pNdX/ubcqf3
        7lXa2sSXZod4EJaUNgh62rcct6ny8eoBMR44ZCP5ewijLdGG0BsvxIJEmA7ksX4ZZB7Hv0
        6CAwYsB0IMll6ZMyMnDBM3+TzQvUJII=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-yzqilUztOHmTWhpGOfvppg-1; Thu, 03 Aug 2023 13:43:37 -0400
X-MC-Unique: yzqilUztOHmTWhpGOfvppg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A19B8DC667;
        Thu,  3 Aug 2023 17:43:36 +0000 (UTC)
Received: from [10.22.17.81] (unknown [10.22.17.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A55DB200A7CA;
        Thu,  3 Aug 2023 17:43:34 +0000 (UTC)
Message-ID: <fe46e855-b812-c1c5-07ce-7a3715bcbd2e@redhat.com>
Date:   Thu, 3 Aug 2023 13:43:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] sched/core: Use empty mask to reset cpumasks in
 sched_setaffinity()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
References: <20230717180243.3607603-1-longman@redhat.com>
 <20230721094233.GF3630545@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230721094233.GF3630545@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/21/23 05:42, Peter Zijlstra wrote:
> On Mon, Jul 17, 2023 at 02:02:43PM -0400, Waiman Long wrote:
>> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
>> cpumask"), user provided CPU affinity via sched_setaffinity(2) is
>> perserved even if the task is being moved to a different cpuset. However,
>> that affinity is also being inherited by any subsequently created child
>> processes which may not want or be aware of that affinity.
>>
>> One way to solve this problem is to provide a way to back off from
>> that user provided CPU affinity.  This patch implements such a scheme
>> by using an empty cpumask to signal a reset of the cpumasks to the
>> default as allowed by the current cpuset.
>>
>> Before this patch, passing in an empty cpumask to sched_setaffinity(2)
>> will always return an EINVAL error. With this patch, an error will no
>> longer be returned if sched_setaffinity(2) has been called before to
>> set up user_cpus_ptr. Instead, the user_cpus_ptr that stores the user
>> provided affinity will be cleared and the task's CPU affinity will be
>> reset to that of the current cpuset. No error will be returned in this
>> case to signal that a reset has happened.
>>
>> If sched_setaffinity(2) has not been called previously, an EINVAL error
>> will be returned with an empty cpumask just like before. As a result,
>> tests or tools that rely on this behavior will not be affected unless
>> they have somehow called sched_setaffinity(2) before.
>>
>> We will have to update the sched_setaffinity(2) manpage to document
>> this possible side effect of passing in an empty cpumask.
> So a normal task, that hasn't had it's affinity changed will have
> possible_mask.
>
> So why not use in_mask == possible_mask to clear the user state?

It is not straight forward for a user application to figure what exactly 
is possible_mask. Using a empty mask, however, is much easier with the 
CPU_ZERO() macro.

In many cases, tasks may be running under a cpuset with cpu list that is 
a proper subset of possible_mask. Since possible_mask is a valid 
cpumask, we can't use it to reset to the cpuset's default which is what 
this patch is.

Cheers,
Longman

