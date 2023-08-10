Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB8C777209
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjHJIEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjHJIEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EF1F7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691654606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PfaC/PDyoa2b4RxaoBt6Mltx+tgnoVJUP3gprplX2qg=;
        b=a10gpJHd4L32jgjOkdIO2jrkIi3dg8HRfQylueUrKlNss3Az+aGthejTBBbmjLzZoqf2NH
        XruuVL3z1j1F5ejqV6afHaAgbwqSrzDfCnAdZlr3geROfL+4ezYI9IKfyrMjwxz8w9CNdI
        Kx5F201RlreKqEN91/5MR5lS8iGs/Rc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-VeceugrkPlKE_59SnbY3xQ-1; Thu, 10 Aug 2023 04:03:24 -0400
X-MC-Unique: VeceugrkPlKE_59SnbY3xQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fc07d4c63eso8001495e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654603; x=1692259403;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfaC/PDyoa2b4RxaoBt6Mltx+tgnoVJUP3gprplX2qg=;
        b=TdW4D53ei7dBNJTzQmPHsWMl9HgHtE5e22sRc3JLC7hT0MTDttgqHrc3zsCZBtF7zc
         P6ek+GSyZFxSHk8AO1dj8IQsqWaTxwecTaCSWpsGdORvgxl7HkMwOZI1hp83kxqDQVbi
         ZF2rpCAb+S1D+5p2datMiY/RKlX/83f2FIsjXg0hT+Z4dDmJxbuPtjCfJnoR2POweo9j
         RFYU1SWklXWht8OcX9tWqNtp1HM2q2SOt5cQ1EdZ2inKOxTzzZUtkcXefU4aijUWAnug
         hQHsFMBNFhbGXjdPlLNBMLvVISs9AjsVCcSawx/TDKjXAPOYYJb4YxConvGC6PU0nkCk
         Przg==
X-Gm-Message-State: AOJu0YyOupWUsIG6cDxvnl9zHSq+UEFdOFlnC8mfuvJfYCVKUng4oawZ
        Yrwb2M3+APFLe5xmm3UQUdFwpb7jHu3iQ6l8IetR29Ag65wmE/dp0r6UeUyI+hFYmAVWpPmdkkK
        8jsJl78h/SQRHOI7pI2zlBIuXujjvOSzfYbCzk7v/VU/oPqvOvLK8/DmR5J3ewTztb83/gn984E
        QGbVJ/4Udj
X-Received: by 2002:a7b:ce8b:0:b0:3fd:2e87:aa28 with SMTP id q11-20020a7bce8b000000b003fd2e87aa28mr1011876wmj.15.1691654603441;
        Thu, 10 Aug 2023 01:03:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCX7iSjniJWsvTWd6ph7Eo1eCX+q/cocqk5NHK/Qs7MLihsJbpvXao4p9dyhd+I6r++cho+Q==
X-Received: by 2002:a7b:ce8b:0:b0:3fd:2e87:aa28 with SMTP id q11-20020a7bce8b000000b003fd2e87aa28mr1011838wmj.15.1691654602816;
        Thu, 10 Aug 2023 01:03:22 -0700 (PDT)
Received: from vschneid.remote.csb ([93.186.150.163])
        by smtp.gmail.com with ESMTPSA id v22-20020a1cf716000000b003fe23b10fdfsm4260371wmh.36.2023.08.10.01.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:03:22 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] sched: Simplify ttwu()
In-Reply-To: <20230809192651.GU212435@hirez.programming.kicks-ass.net>
References: <20230801204121.929256934@infradead.org>
 <20230801211812.101069260@infradead.org>
 <xhsmh4jl8ckcf.mognet@vschneid.remote.csb>
 <20230809192651.GU212435@hirez.programming.kicks-ass.net>
Date:   Thu, 10 Aug 2023 09:03:21 +0100
Message-ID: <xhsmhsf8rb9yu.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/23 21:26, Peter Zijlstra wrote:
> On Wed, Aug 09, 2023 at 04:21:36PM +0100, Valentin Schneider wrote:
>> On 01/08/23 22:41, Peter Zijlstra wrote:
>> > Use guards to reduce gotos and simplify control flow.
>> >
>> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> > ---
>> >  kernel/sched/core.c |  221 +++++++++++++++++++++++++---------------------------
>> >  1 file changed, 109 insertions(+), 112 deletions(-)
>> >
>> > --- a/kernel/sched/core.c
>> > +++ b/kernel/sched/core.c
>> > @@ -3706,14 +3706,14 @@ ttwu_stat(struct task_struct *p, int cpu
>> >               struct sched_domain *sd;
>> >
>> >               __schedstat_inc(p->stats.nr_wakeups_remote);
>> > -		rcu_read_lock();
>> > +
>> > +		guard(rcu)();
>>
>> This isn't strictly equivalent, right? AFAICT that pushes the
>> rcu_read_unlock() further down than it currently is - not a big deal, but
>> indentation aside scoped_guard() would preserve that.
>
> The full hunk:
>
> | @@ -3706,14 +3706,14 @@ ttwu_stat(struct task_struct *p, int cpu
> |             struct sched_domain *sd;
> |
> |             __schedstat_inc(p->stats.nr_wakeups_remote);
> | -		rcu_read_lock();
> | +
> | +		guard(rcu)();
> |             for_each_domain(rq->cpu, sd) {
> |                     if (cpumask_test_cpu(cpu, sched_domain_span(sd))) {
> |                             __schedstat_inc(sd->ttwu_wake_remote);
> |                             break;
> |                     }
> |             }
> | -		rcu_read_unlock();
> |     }
>
> And you'll see the guard goes out of scope here ^
>
> Which is the exact place rcu_read_unlock() was at, no?

Bleh, yes, lost track of the scope there...

