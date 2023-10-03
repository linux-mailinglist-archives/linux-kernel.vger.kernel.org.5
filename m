Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163627B70F0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbjJCSde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240781AbjJCSdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0B690
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696357964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dx1heSWm8ct9G5uwIzURNxe2EApKhuYUQCfG3EHD7ME=;
        b=GVZDw+jlWT1sbK4nPH/SSw1wZnqGn+sTEqol5fpBUQQc8aIUCJodqJQ+yr1LY+kQhlXtqC
        xDNhIRO+clehmeDPAGxGZWlXAU2uuhJHfWUUrvf8M6CaCA3G4ipcj0eRgZ1AZKwKt/cnhd
        cCCuGpNSm1NV7u6UV8bGDRJEjykZPdc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-aFhRiWDMNZebjiok0RTbww-1; Tue, 03 Oct 2023 14:32:38 -0400
X-MC-Unique: aFhRiWDMNZebjiok0RTbww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E279811E7E;
        Tue,  3 Oct 2023 18:32:37 +0000 (UTC)
Received: from [10.22.10.176] (unknown [10.22.10.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF4962026D4B;
        Tue,  3 Oct 2023 18:32:36 +0000 (UTC)
Message-ID: <35e71589-8e66-e02d-fd7e-42e646cb4a55@redhat.com>
Date:   Tue, 3 Oct 2023 14:32:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3] sched/core: Use empty mask to reset cpumasks in
 sched_setaffinity()
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
References: <20230804023218.75544-1-longman@redhat.com>
 <ZRvcRgv+HBY5+e9J@gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZRvcRgv+HBY5+e9J@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/3/23 05:17, Ingo Molnar wrote:
> * Waiman Long <longman@redhat.com> wrote:
>
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
>> will always return an -EINVAL error. With this patch, an alternative
>> error of -ENODEV will be returned returned if sched_setaffinity(2)
>> has been called before to set up user_cpus_ptr. In this case, the
>> user_cpus_ptr that stores the user provided affinity will be cleared and
>> the task's CPU affinity will be reset to that of the current cpuset. This
>> alternative error code of -ENODEV signals that the no CPU is specified
>> and, at the same time, a side effect of resetting cpu affinity to the
>> cpuset default.
> I agree that this problem needs a solution, but I don't really agree
> with the -ENODEV ABI hack.
>
> Why not just return success in that case? The 'reset' of the mask was
> successful after all.

I believe the v1 patch just returns success like what you said. However, 
there are existing tests that assume a sched_setaffinity() call with 
empty cpumask in the valid cpu range will return error. It is also 
sometime used to check if the CPU number is out of the valid range. That 
is the reason why I change the patch to return error as well to avoid 
breaking existing use cases. I purposely return a different error to 
indicate a reset has happened. Let me know if you have other suggestions 
on the best way forward.

Thanks,
Longman

